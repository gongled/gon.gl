---
title: Как версионировать ПО
date: 2017-09-04
---

Среди разработчиков свободного ПО есть мнение, что хеш коммита — хороший выбор для версии. Это не так:

- Хеши нельзя сравнить друг с другом.
- Хеш тяжело запомнить.
- Хеш ничего не скажет о важности обновления.

Номер версии должен помогать администраторам систем и мейнтейнерам связанных программ оценить влияние обновления. Не заглядывая в исходный код, лучше всего об этом скажет версия. Потому мне нравится [семантическое](http://semver.org/) и [романтическое](http://dafoster.net/articles/2015/03/14/semantic-versioning-vs-romantic-versioning/) версионирование, а последовательные, алфавитно-цифровые, датированные и прочие экзотические подходы — нет.

Вот плохой пример: разработчики библиотеки x264 [используют составной идентификатор](https://download.videolan.org/x264/snapshots/) из даты и номера снапшота (который почему-то не меняется с августа 2005-го года). Выходит, о потере совместимости нельзя будет узнать из номера версии.

Потому к версии этого пакета дописывают префикс — версию API из константы `X264_BUILD` из заголовочного файла x264.h. Это, на минуточку, популярный кодек H.264/MPEG-4 AVC в видеоплеере VLC и наборе библиотек FFmpeg.

Есть исключение: нумерация версий в проектах [TeX](https://www.tug.org/) и [METAFONT](https://www.ctan.org/pkg/metafont). Каждое обновление добавляет дополнительную десятичную цифру в конце номера, ассимптотически приближая значение к числу Пи и Эйлера. Так Дональд Кнут хотел подчеркнуть, что добавление новой функциональности не планируется, а последующие изменения являются исправлениями ошибок.

Помните, что нумерация версий нужна не только машинам, но и людям. Выбирайте с умом.
