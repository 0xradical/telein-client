# encoding: utf-8
module Telein
  # The mapping of carrier codes and meanings , in pt-BR
  # @todo Maybe provide in en-US format
  CARRIER_CODES = {
    12  => 'CTBC',
    14  => 'Brasil Telecom',
    20  => 'Vivo',
    21  => 'Claro',
    23  => 'Telemig',
    24  => 'Amazonia',
    31  => 'Oi',
    37  => 'Unicel',
    41  => 'TIM',
    43  => 'Sercomercio',
    77  => 'Nextel Rádio',
    78  => 'Nextel',
    81  => 'Datora',
    82  => 'Porto',
    98  => 'Fixo',
    99  => 'Número não encontrado',
    100 => 'Número inválido',
    101 => 'Erro no servidor',
    990 => 'IP blacklisted',
    991 => 'Limite excedido',
    992 => 'IP sem acesso',
    994 => 'Chave bloqueada',
    995 => 'IP excedeu 6 consultas/hora nas últimas 24 horas',
    999 => 'Chave inválida' }
end
