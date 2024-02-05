# Arquitetura - MiniCore

**Objetivo**: Propor uma arquitetura simplificada e de fácil entendimento, tendo como foco o FrontEnd. A estrutura proposta é baseada em três camadas distintas, sendo elas: User Interactor, Adaptation e External.

### Camadas

**User Interactor**: Deve ser responsável por declarar as entradas, saídas e interações da aplicação.

**Adaptation**: Deve ser responsável por realizar a tradução e comunicação entre as camadas de User Interactor e External.

**External**: Deve ser responsável por lidar com as informações externas à sua aplicação.
<br>
<br>

<p align="center">
<img src="vai.png" width="512" alt="Achitecture diagram"/>
</p>

<br>
<br>

<p align="center">
<img src="volta.png" width="512" alt="Achitecture diagram"/>
</p>

### Limites

Dentro dos limites arquiteturais estabelecidos, destaca-se que a camada User Interactor não deve possuir acesso direto à camada External. Para contornar essa restrição, a camada Adaptation atua como intermediária, realizando a comunicação entre as camadas User Interactor e External.

Visando aprimorar o desenvolvimento com eficiência e flexibilidade, a arquitetura assegura um baixo acoplamento através da clara separação de responsabilidades em cada camada.


## Estrutura da Arquitetura

### UI (User Interface)
Esta camada deve conter os elementos visuais da aplicação.

### Interactor
Esta camada deve abranger os estados ou reatividades da aplicação, a representação das regras de negócio, abstrações para comunicação entre as outras camadas e as operações executadas pela sua UI.

- #### Atoms: 
    Devem armazenar um estado da aplicação.

- #### Actions: 
    Devem ter a finalidade de alterar os estados da aplicação.

- #### DTO: 
    Data Transfer Object é um padrão de design usado para transferir dados entre camadas.

- #### Models: 
    Representam as regras de negócio.

- #### Interfaces:
    Devem conter interfaces para alcançar um baixo acoplamento, reduzindo a dependência direta e proporcionando uma substituição fácil de implementações.
 
## Data
Devem interagir com as fontes externas.

- #### Adapter:
   Deve haver as adaptaçãoes para garantir que os dados externos sigam os padrões definidos pela aplicação.

- #### Tratamento de erros:
    Como boa prática, devemos tratar os erros da nossa aplicação garantindo estabilidade e reduzindo a ocorrência de falhas.
  
- #### Repository: 
    Deve conter a classe concreta, proveniente da abstração, para a comunicação entre as camadas.
    
- #### Service: 
    Deve conter a classe concreta, proveniente da abstração, para a comunicação entre as camadas.

## Core
Deve conter informações globais e reutilizáveis para todas as camadas da aplicação.

## Benefícios da Utilização da Arquitetura MiniCore:

- #### Facilidade de Entendimento: 
    Proporciona uma estrutura clara e intuitiva, facilitando a compreensão do código para desenvolvedores.

- #### Manutenibilidade:
    A divisão em camadas e a clareza das responsabilidades tornam o código mais fácil de manter e atualizar.

- #### Escalabilidade de Código:
    A arquitetura é projetada para lidar com o crescimento da aplicação, garantindo que ela possa escalar de maneira eficaz.

- #### Acesso Fácil a Variáveis e Métodos Globais:
    Facilita o acesso a variáveis e métodos globais, promovendo uma comunicação eficiente entre as diferentes partes do sistema.

- #### Facilita Testes (Sem a Necessidade de Mockar os Atoms):
    Simplifica a realização de testes, eliminando a necessidade de simular ou simbolizar (mockar) os Atoms, tornando o processo de teste mais eficiente e menos complexo.

Outro ponto importante será o estado global, com isso ganhamos: <br><br>
Acessibilidade Universal: O estado global permite que os dados sejam acessados de qualquer lugar da aplicação. Isso pode ser útil quando você precisa compartilhar informações entre diferentes partes da interface do usuário ou entre várias páginas.

Redução da Complexidade: Em vez de passar dados através de vários componentes como parâmetros, o uso de um estado global pode simplificar o código, tornando-o mais legível e fácil de entender.

Facilidade de Manutenção: Ao centralizar o estado em um local global, torna-se mais fácil manter e modificar o estado da aplicação. Isso pode facilitar a resolução de bugs e a implementação de novos recursos.

Melhor Desempenho: Dependendo da implementação, um estado global bem gerenciado pode levar a um melhor desempenho, especialmente em comparação com abordagens onde os dados precisam ser passados através de muitos componentes.


<br>

Ao adotar a arquitetura MiniCore, os desenvolvedores ganham um desenvolvimento de sistemas mais robustos, eficientes e de fácil manutenção, promovendo uma experiência de desenvolvimento mais positiva e sustentável.

## Exemplos

De acordo com a arquitetura proposta, define-se a estrutura de pastas.

```
.
└── app/
    ├── public/
    │   └── pages/
    ├── core/
    │   ├── assets/
    │   ├── themes/
    │   └── widgets/
    ├── data/
    │   ├── adapters/
    │   ├── repositories/
    │   └── services/
    └── interactor/
        ├── atoms/
        ├── actions/
        ├── dtos/
        ├── models/ 
        ├── repositories/
        └── services/
```

Veja alguns [exemplos](https://github.com/FelCarv01/mini-core-examples).
