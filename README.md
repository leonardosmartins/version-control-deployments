## Version Control Deployments

[**Painel do CI/CD**](https://github.com/leonardosmartins/version-control-deployments/actions)


Este projeto é uma API de controle de **deployments** de aplicações que fornece um histórico de *deploy* contendo informações úteis.

Essa API visa em receber uma chamada **POST** com os seguintes parâmetros:

 * **Componente**: Componente que está em processo de deploy
 * **Versão**: Versão que está sendo entregue
 * **Responsável**: Nome do mebro do time que está realizando o processo de deploy
 * **Status**: Status do processo de deploy

Com todos esses parâmetros devidamente informados a API irá receber esses dados, acrescentar a data e hora do *deploy* e salvar essas informações em um *bucket* no serviço **S3**, o qual servirá como histórico dos *deployments*

## Tecnologias

Neste projeto foi utilizado a [AWS](https://aws.amazon.com/pt/) como *cloud* para hospedar o serviço e para provisionar os recursos necessários foi utilizado a ferramenta [Terraform](https://www.terraform.io/). Por fim, para criar o *CI/CD* foi utilizado o [GitHub Actions](https://github.com/features/actions)

## Configurando

* Primeiro é necessário uma conta na **AWS** e um usuário com as chaves **ACCESS_KEY** e **SECRET_KEY** geradas e com as permissões adequadas.

* Com as chaves do usuário criadas, deve-se agora criar no *GitHub*, na tela de configurações, duas *secrets* com os nomes de **ACCESS_KEY** e **SECRET_KEY** para armazenar as chaves geradas com segurança.

* Será necessário também criar um *bucket* no serviço **S3** que servirá para armazenar o arquivo de estado do terraform. Depois de criado o *bucket* deve-se configurar adequadamente o arquivo **backend.tf** informarmando o nome do *bucket* criado na propriedade **bucket** e a região onde foi criado na propriedade **region**

* Para finalizar é necessário preencher as informações no arquivo **vars.tfvars**

## Funcionamento

Com as configurações feitas, qualquer **Push** que for feito neste repositório, o *CI/CD* irá executar automanticamente, executando o *job* de **Deploy** que irá executar o terraform criando assim um **Lambda** com a aplicação em **Python**, um *bucket* onde serão salvas as informações, e também um **Api Gateway** para expor esse lambda criado. Neste *job* existe um *step* chamado **Show Output** o qual irá fornecer uma URL para ser acessada (*Ex: https://faao1d1rdf.execute-api.us-east-2.amazonaws.com/main*), ao finalizar o *CI/CD* podemos acessar essa URL adicionando **/control** (*Ex: https://faao1d1rdf.execute-api.us-east-2.amazonaws.com/main/control*) e passando todos os parâmetros necessários no corpo da requisição.

*Exemplo de corpo da requisição:*

```
{
	"componente": "appA",
	"versao": "1.0",
	"responsavel": "Leonardo",
	"status": "Ok"
}
```

## Monitoramento e Logs

Para esse cenário, temos habilitado o **CloudWatch** da AWS, onde nele conseguimos ver algumas métricas da nossa aplicação (Lambda) e também podemos acessar os *logs* gerados.

## Melhorias Futuras

* Criar um DNS para acessar essa aplicação
* Fazer mapeamento dos *status code* no Api Gateway

