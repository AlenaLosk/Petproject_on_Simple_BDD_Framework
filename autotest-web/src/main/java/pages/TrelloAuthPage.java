package pages;

import com.codeborne.selenide.SelenideElement;
import org.openqa.selenium.By;
import ru.lanit.at.web.annotations.Name;
import ru.lanit.at.web.pagecontext.WebPage;

import static com.codeborne.selenide.Selenide.$;
import static com.codeborne.selenide.Selenide.$x;

@Name(value = "Trello страница авторизации")
public class TrelloAuthPage extends WebPage {

    @Name("поле для ввода электронной почты при авторизации")
    private SelenideElement userEmailField = $(By.id("user"));

    @Name("поле для ввода пароля")
    private SelenideElement passField = $(By.id("password"));

    @Name("кнопка входа Atlassian")
    private SelenideElement entryButton = $(By.id("login"));

    @Name("кнопка входа")
    private SelenideElement finalEntryButton = $(By.id("login-submit"));
}