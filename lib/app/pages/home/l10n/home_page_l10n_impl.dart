import 'package:visit_doctor/app/pages/home/l10n/home_page_l10n.dart';

class HomePageL10nImpl implements HomePageL10n {
  const HomePageL10nImpl();

  @override
  String get labelCep => 'Informe o CEP';

  @override
  String get hintCep => '00000-000';

  @override
  String get buttonSearchLabel => 'Buscar endereço';

  @override
  String get streetLabel => 'Rua';

  @override
  String get neighborhoodLabel => 'Bairro';

  @override
  String get cityLabel => 'Cidade';

  @override
  String get stateLabel => 'Estado';

  @override
  String get errorCep => 'CEP inválido';

  @override
  String get errorCepMessage =>
      'O CEP informado é inválido. Por favor, verifique os dados inseridos.';

  @override
  String get buttonConfirm => 'Confirmar';

  @override
  String get buttonAddClientToAddressLabel => 'Vincular cliente ao endereço';

  @override
  String get errorSaveClientMessage => 'Erro ao salvar cliente';

  @override
  String get saveClientSuccessMessage => 'Cliente cadastrado com sucesso';

  @override
  String get errorUpdateClientMessage => 'Erro ao atualizar cliente';

  @override
  String get updateClientSuccessMessage => 'Cliente atualizado com sucesso';
}
