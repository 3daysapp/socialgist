import 'package:i18n_extension/i18n_extension.dart';

final t = Translations('en_us') +
    {
      'en_us': 'Let\'s go',
      'pt_br': 'Vamos lá',
    } +
    {
      'en_us': 'Explore',
      'pt_br': 'Explorar',
    } +
    {
      'en_us': 'Profile',
      'pt_br': 'Perfil',
    } +
    {
      'en_us': 'Redirecting...',
      'pt_br': 'Redirecionando...',
    } +
    {
      'en_us': 'Waiting...',
      'pt_br': 'Aguarde...',
    } +
    {
      'en_us': 'Verifying access...',
      'pt_br': 'Verificando acesso...',
    } +
    {
      'en_us': 'You must log in to GitHub.',
      'pt_br': 'É necessário realizar o autenticar no GitHub.',
    } +
    {
      'en_us': 'Something wrong happened.',
      'pt_br': 'Algo de errado aconteceu.',
    } +
    {
      'en_us': 'The browser could not be opened.',
      'pt_br': 'Não foi possível abrir o navegador.',
    } +
    {
      'en_us': 'Error',
      'pt_br': 'Erro',
    } +
    {
      'en_us': 'Timeout reached.',
      'pt_br': 'Tempo máximo excedido.',
    } +
    {
      'en_us': 'Follow',
      'pt_br': 'Seguir',
    } +
    {
      'en_us': 'Following',
      'pt_br': 'Seguindo',
    } +
    {
      'en_us': 'Followers',
      'pt_br': 'Seguidores',
    } +
    {
      'en_us': 'Repositories',
      'pt_br': 'Repositórios',
    } +
    {
      'en_us': 'Gists',
      'pt_br': 'Gists',
    } +
    {
      'en_us': 'Gist',
      'pt_br': 'Gist',
    } +
    {
      'en_us': 'Loading...',
      'pt_br': 'Carregando...',
    } +
    {
      'en_us': 'File not found!',
      'pt_br': 'Arquivo não encontrado!',
    } +
    {
      'en_us': '%d Files'.one('%d File').many('%d Files'),
      'pt_br': '%d Arquivos'.one('1 Arquivo').many('%d Arquivos'),
    } +
    {
      'en_us': '%d Comments'.one('%d Comment').many('%d Comments'),
      'pt_br': '%d Comentários'.one('%d Comentário').many('%d Comentários'),
    } +
    {
      'en_us': 'Star',
      'pt_br': 'Star',
    } +
    {
      'en_us': 'Exit',
      'pt_br': 'Sair',
    };

///
///
///
extension Localization on String {
  ///
  ///
  ///
  String get i18n => localize(this, t);

  ///
  ///
  ///
  String plural(int value) => localizePlural(value, this, t);
}
