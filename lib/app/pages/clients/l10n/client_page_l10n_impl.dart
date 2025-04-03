import 'client_page_l10n.dart';

class ClientPageL10nImpl implements ClientPageL10n {
  const ClientPageL10nImpl();
  @override
  String get clients => 'Clientes';

  @override
  String get errorLoadingClients => 'Erro ao carregar os clientes';

  @override
  String get clientAgeLabel => 'Idade';

  @override
  String get clientCityLabel => 'Cidade';

  @override
  String get clientNameLabel => 'Nome do cliente';

  @override
  String get clientOpenButtonLabel => 'Visualizar';

  @override
  String get clientStateLabel => 'UF';

  @override
  String get clientVisitButtonLabel => 'Visitar';

  @override
  String get dialogDeleteClientMessage =>
      'Ao confirmar, as visitas vinculadas a este cliente também serão apagadas. \n\nDeseja continuar?';

  @override
  String get dialogDeleteClientTitle => 'Este cliente tem visitas vinculadas';

  @override
  String get dialogOptionNoLabel => 'Não';

  @override
  String get dialogOptionYesLabel => 'Sim';

  @override
  String get emptySearchClientMessage => 'Não há resultados para a busca, tente outros termos.';

  @override
  String resultSearchClientMessage(int result) => 'Resultado da busca ($result)';
}
