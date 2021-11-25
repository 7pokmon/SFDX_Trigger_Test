/*
    시나리오 2.

    계정을 생성하거나 계정 레코드를 업데이트할 때마다 Website필드에 네이버 URL값으로 필드를 업데이트합니다.
*/
public class HelloWorld {
    public void addHelloWorld(List<Account> accs) {

        for (Account a :accs) {

            if (a.Website != 'https://www.naver.com/') {

                a.Website = 'https://www.naver.com/';

            }
        }
    }
}
