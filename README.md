
# Курс iOS Developer. Дипломная работа. Нетология 2022 

### Prerequisites

The following are the versions used when compiling this program:

Swift Version: 5

Xcode Version: 14

Targeted iOS: 13.0 and above iPhone

Device Orientation: Portrait

## Running the App

Download all the files from this repo onto a local directory. Compile the program on Xcode.

## Using UIKit/AutoLayout/Extantions/Models/Delegate/Protocols/User Default


### Экран с логикой:
* Реализовал проверку на пустые поля логина и пароля. Если одно из полей пустое, то при нажатии на кнопку к этому полю применяется действие (изменение цвета фона, рамки или подергивание);
* Реализовал проверку на количество введенных символов пароля. Если меньше определенного количество, то под полем с паролеме появляется UILabel с предупреждением;
* Реализовал стандартный логин и пароль. В случае ввода некорректных данных выбрасывается UIAlertController с предупреждением;
* Реализовал проверку валидности email адреса.

![output4](https://user-images.githubusercontent.com/73440376/224117658-e151eeb8-1695-4929-9d6e-d8de783863dd.gif)
___
### Экран с профилем:
* При нажатии на кнопку Set status  реализована проверка на пустой UITextFiled с установкой статуса, по аналогии с логикой;
* При нажатии на UILabel с лайками количество лайков увеличивается;
* При нажатии на картинку с постом презентовывается View с детальным описанием этого поста. При этом в UILabel с количеством просмотров увеличивает счетчик просмотром на 1.

![output1](https://user-images.githubusercontent.com/73440376/224119351-579dc4a9-7947-4adf-b692-445a856c21df.gif)
___
### Экран с коллекцией фото:
* При однократном нажатии на ячейку с фото реализована анимация

![output2](https://user-images.githubusercontent.com/73440376/224120782-3035312a-48ec-4875-bb8a-0eeb1b9473cd.gif)
