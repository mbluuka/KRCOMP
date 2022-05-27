# KRCOMP
Это мой компилятор для языка meow+-

Грамматика и РВ для выделения лексем, находятся в файле MEOW.g4 - вот пример части грамматики:
```
print
    :   PRINT OPEN_PAREN expressionList CLOSE_PAREN
    ;


ifStatment
    :   IF OPEN_PAREN conclusionList CLOSE_PAREN  block (ELSE block)?
    ;


conclusionList
    :   conclusion (pob=(AND | OR) conclusion)*
    ;

```
----------------------------------------------------------------------------------------------------------------------------------------------------
Дерево разбора строится с помощью определенных правил, которые расписаны в папке ast
Пример правила разбора логических переменных, которые могут встретиться в нашей программке
```
public Node visitBoolLiteral(MLLParser.BoolLiteralContext ctx) {
        switch (ctx.getText()) {
            case "true":
                return Constant.True;
            case "false":
                return Constant.False;
        }
        return null;
    }
```
----------------------------------------------------------------------------------------------------------------------------------------------------
Семантический и синтаксический анализ лежит на плечах antlr-a, также 

Пример синтаксического анализа:
```
На вход поступает такая вот программа, написанная на моем языке
```
![image](https://user-images.githubusercontent.com/50544822/170658271-6bb37c07-3cf1-4f78-9a4a-c0d51d7aa8be.png)

```
Дерево разбора:
```
![image](https://user-images.githubusercontent.com/50544822/170658293-bc6d5fc1-b090-4caf-a60b-e2a23ff63389.png)

----------------------------------------------------------------------------------------------------------------------------------------------------
Ошибки:
```
Синтаксические ошибки:
```
![image](https://user-images.githubusercontent.com/50544822/170659175-ca5cf3dc-680f-42eb-8310-3fcdf30d995d.png)
![image](https://user-images.githubusercontent.com/50544822/170659190-11e92d1c-90d1-4544-8576-ae71c83d57d4.png)

----------------------------------------------------------------------------------------------------------------------------------------------------
```
Семантические ошибки:
```
![image](https://user-images.githubusercontent.com/50544822/170659085-148bd316-5d50-4e51-b9d8-8d7ff4a024b7.png)
![image](https://user-images.githubusercontent.com/50544822/170659108-2e716b82-6f01-4a6f-a5f7-8488a475557e.png)
