package pages;

import com.codeborne.selenide.SelenideElement;
import ru.lanit.at.web.annotations.Name;
import ru.lanit.at.web.pagecontext.WebPage;

import static com.codeborne.selenide.Selenide.$x;

@Name(value = "Trello страница меню")
public class TrelloMenu extends WebPage {
    @Name("фон доски")
    private SelenideElement boardBackground = $x("//a[@class='board-menu-navigation-item-link js-change-background']");

    @Name("цвета фона доски")
    private SelenideElement boardBackgroundColor = $x("//div[@class='board-backgrounds-section-tile board-backgrounds-colors-tile js-bg-colors']");

    @Name("сделать зеленый фон")
    private SelenideElement willBoardBackgroundGreen = $x("//div[@style='background-color: rgb(81, 152, 57);']");

    @Name("закрыть меню")
    private SelenideElement closeMenu = $x("//a[@title='Закрыть меню доски.']");
}
