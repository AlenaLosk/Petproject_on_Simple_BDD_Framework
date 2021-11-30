package pages;

import com.codeborne.selenide.SelenideElement;
import org.openqa.selenium.By;
import ru.lanit.at.web.annotations.Name;
import ru.lanit.at.web.pagecontext.WebPage;
import static com.codeborne.selenide.Selenide.$;
import static com.codeborne.selenide.Selenide.$x;

@Name(value = "Trello страница карточки")
public class TrelloCardPage extends WebPage {

    @Name("пустой чек-бокс")
    private SelenideElement emptyCheckBox = $x("//div[@class='checklist-item no-assignee no-due']");

    @Name("кнопка обложки")
    private SelenideElement backgroundСolor = $x("//a[@class='window-cover-menu-button js-card-cover-chooser']");

    @Name("кнопка выбора обложки зеленого цвета")
    private SelenideElement makeGreenСolorOfBackground = $x("//button[@class='_31xT7xOqkxPLkw _1hFyzxe1-LRBw8']");

    @Name("кнопка закрытия обложки")
    private SelenideElement closeBackgroundСolor = $x("//a[@class='pop-over-header-close-btn icon-sm icon-close']");

    @Name("обложка карточки зеленого цвета")
    private SelenideElement GreenСolorOfBackground = $x("//div[contains(@class,'green')]");

    @Name("чек-бокс выполнения карточки")
    private SelenideElement cardWillDone = $x("//a[contains(@class, 'card-detail-badge-due-date')]");

    @Name("заполненный чек-бокс выполнения карточки")
    private SelenideElement cardIsDone = $x("//div[@title='Эта карточка выполнена.']");
}
