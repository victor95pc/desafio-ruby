# desafio-ruby


First step: Fazer fork desse projeto e iniciar teu desafio! :)


O plano é o seguinte:


0 - Você vai criar tipo um marketplace

1 - Permitir cadastro de lojas. Utilizar a gem “devise” para gerenciar cadastro/login das lojas

2 - Consumir as APIs das lojas abaixo, e importar pelo menos 100 produtos DE CADA loja para o DBMongo

3 - Exibir os produtos em grid conforme print abaixo

4 - Fazer uma busca indexada por produto utilizando o Elasticsearch (Em termos de layout, você pode remover os filtros que têm no print e adicionar um campo de busca no lugar)

5 - Fazer uma interface administrativa utilizando rails_admin para gerenciar as lojas e respectivos produtos


Ps.: Caso seja necessário, segue adaptador do kaminari para o mongoid --> https://github.com/kaminari/kaminari-mongoid



APIs:

https://www.fossil.com.br/api/catalog_system/pub/products/search/

http://www.timex.com.br/api/catalog_system/pub/products/search/

https://www.schumann.com.br/api/catalog_system/pub/products/search/

Paginação: https://www.fossil.com.br/api/catalog_system/pub/products/search?_from=0&_to=49



Pode criar as três lojas:

* Timex

* Fossil

* Schumann



Estrutura - Loja:

* Nome

* Website

* Logo

* Email



Estrutura - Produto

* Nome

* Preço

* Parcelas

* Imagem

* Url


![alt text](http://i.imgur.com/O2LaEPd.png)


** Aí você publica essa aplicação em algum lugar (heroku, que seja) e nos envia o link do github pra vermos seu código. Damos um prazo normalmente de 4 dias, e você entrega o que vc conseguir até lá. Blz?
