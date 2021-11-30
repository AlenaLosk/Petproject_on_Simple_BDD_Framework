package pages;

import com.codeborne.selenide.SelenideElement;
import org.openqa.selenium.By;
import ru.lanit.at.web.annotations.Name;
import ru.lanit.at.web.pagecontext.WebPage;
import static com.codeborne.selenide.Selenide.$;
import static com.codeborne.selenide.Selenide.$x;

@Name(value = "Trello основная страница")
public class TrelloBoardsPage extends WebPage {

    @Name("поле доски KanbanTool")
    private SelenideElement boardKanbanTool = $x("//div[@title='KanbanTool']");

    @Name("столбец Done")
    private SelenideElement listDone = $x("//textarea[@aria-label='Done']");

    @Name("карточка для изучения Api")
    private SelenideElement cardApi = $x("//span[text()='Карточка для изучения API']/parent::*");

    @Name("кнопка меню доски")
    private SelenideElement boardMenu = $x("//a[@class='board-header-btn mod-show-menu js-show-sidebar']");

    @Name("фон стал зеленого цвета")
    private SelenideElement isBoardBackgroundGreen = $x("//a[@class='board-header-btn mod-show-menu js-show-sidebar']");

    @Name("название доски")
    private SelenideElement boardName = $x("//div[contains(@class,'board-header-btn mod-board-name inline-rename-board js-rename-board')]");

    @Name("название доски2")
    private SelenideElement boardName2 = $x("//div[contains(@class,'board-header-btn mod-board-name inline-rename-board js-rename-board')]");

    @Name("название доски3")
    private SelenideElement boardNameEntryLine = $x("//h1[@class='js-board-editing-target board-header-btn-text']");
    //input[@class='board-name-input js-board-name-input']
    //h1[@class='js-board-editing-target board-header-btn-text']
    //div[contains(@class,'board-header-btn mod-board-name inline-rename-board js-rename-board is-editing')]

    @Name("доступ к доске")
    private SelenideElement boardPermissionLevel = $x("//a[@id='permission-level']");

    @Name("командный доступ к доске")
    private SelenideElement commandAccess = $x("//a[contains(text(),'Рабочее пространство')]");


}
