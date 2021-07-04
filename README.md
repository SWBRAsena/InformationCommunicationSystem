# InformationCommunicationSystem

#### Dockerを使用してテーブルを作成

- Dockerのインストールが必要、pgAdminのインストールをお勧めする。

- docker-compose.yml のあるフォルダでコマンドプロンプトを立ち上げる。

- ```
  docker-compose up -d
  ```

  でコンテナを作成する。

- ```
  psql -d ics_db -U docker < dump.yml
  ```

  でリストア（パスワードもdocker）

**あるいは、コンテナを立ち上がった後に、IcsでSqlConstructionを実行する**

#### 距離の計算

Calculationで計算を行っている。sqlを書き換えれば何でもできる。

**現時点で実装したのは、測定点aに最も近いAPのRSSIとfsから距離を計算する。**

![image-20210704170238500](C:\Users\mo_wo\AppData\Roaming\Typora\typora-user-images\image-20210704170238500.png)

