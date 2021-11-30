package pages;

import com.codeborne.selenide.SelenideElement;
import ru.lanit.at.web.annotations.Name;
import ru.lanit.at.web.pagecontext.WebPage;

import static com.codeborne.selenide.Selenide.$x;

@Name(value = "Trello")
public class TrelloPage extends WebPage {

    @Name("кнопка авторизации")
    private SelenideElement logInButton = $x("//a[@href='/login']");

    /*@Name("поле поиска")
    private SelenideElement searchField = $x("//input[@name='q']");

    @Name("кнопка поиска")
    private SelenideElement searchButton = $x("//*[@role='listbox']/..//*[@name='btnK']");*/
}
