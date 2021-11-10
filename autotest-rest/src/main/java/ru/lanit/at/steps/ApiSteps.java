package ru.lanit.at.steps;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.ru.*;
import io.qameta.allure.Allure;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.Assert;
import ru.lanit.at.api.ApiRequest;
import ru.lanit.at.api.models.RequestModel;
import ru.lanit.at.api.testcontext.ContextHolder;
import ru.lanit.at.utils.CompareUtil;
import ru.lanit.at.utils.DataGenerator;
import ru.lanit.at.utils.Sleep;
import ru.lanit.at.utils.VariableUtil;

import java.util.HashMap;
import java.util.Map;

import static ru.lanit.at.api.testcontext.ContextHolder.replaceVarsIfPresent;
import static ru.lanit.at.utils.JsonUtil.getFieldFromJson;

public class ApiSteps {

    private static final Logger LOG = LoggerFactory.getLogger(ApiSteps.class);
    private ApiRequest apiRequest;

    @Пусть("создаем запрос")
    public void createRequest(RequestModel requestModel) {
        apiRequest = new ApiRequest(requestModel);
    }

    @И("добавляем header")
    public void addHeaders(DataTable dataTable) {
        Map<String, String> headers = new HashMap<>();
        dataTable.asLists().forEach(it -> headers.put(it.get(0), it.get(1)));
        apiRequest.setHeaders(headers);
    }

    @И("добавляем query параметры")
    public void addQuery(DataTable dataTable) {
        Map<String, String> query = new HashMap<>();
        dataTable.asLists().forEach(it -> query.put(it.get(0), it.get(1)));
        apiRequest.setQuery(query);
    }

    @Когда("отправляем запрос")
    public void send() {
        apiRequest.sendRequest();
    }

    @Тогда("получаем статус код {int}")
    public void expectStatusCode(int code) {
        int actualStatusCode = apiRequest.getResponse().statusCode();
        Assert.assertEquals(actualStatusCode, code);
    }

    @Также("извлекаем данные")
    public void extractVariables(Map<String, String> vars) {
        String responseBody = apiRequest.getResponse().body().asPrettyString();
        vars.forEach((k, jsonPath) -> {
            String extractedValue = VariableUtil.extractBrackets(getFieldFromJson(responseBody, jsonPath));
            ContextHolder.put(k, extractedValue);
            Allure.addAttachment(k, "application/json", extractedValue, ".txt");
            LOG.info("Извлечены данные: {}={}", k, extractedValue);
        });
    }

    @Допустим("сгенерируем переменные")
    public void generateVariables(Map<String, String> table) {
        table.forEach((k, v) -> {
            String value = DataGenerator.generateValueByMask(replaceVarsIfPresent(v));
            ContextHolder.put(k, value);
            Allure.addAttachment(k, "application/json", k + ": " + value, ".txt");
            LOG.info("Сгенерирована переменная: {}={}", k, value);
        });
    }

    @Пусть("создадаем контекстные переменные")
    public void createContextVariables(Map<String, String> table) {
        table.forEach((k, v) -> {
            ContextHolder.put(k, v);
            LOG.info("Сохранена переменная: {}={}", k, v);
        });
    }

    @Ктомуже("сравниваем значения")
    public void compareVars(DataTable table) {
        table.asLists().forEach(it -> {
            String expect = replaceVarsIfPresent(it.get(0));
            String actual = replaceVarsIfPresent(it.get(2));
            boolean compareResult = CompareUtil.compare(expect, actual, it.get(1));
            Assert.assertTrue(compareResult, String.format("Ожидаемое: '%s'\nФактическое: '%s'\nОператор сравнения: '%s'\n", expect, actual, it.get(1)));
            Allure.addAttachment(expect, "application/json", expect + it.get(1) + actual, ".txt");
            LOG.info("Сравнение значений: {} {} {}", expect, it.get(1), actual);
        });
    }

    @И("подождем {int} сек")
    public void waitSeconds(int timeout) {
        Sleep.pauseSec(timeout);
    }
}
