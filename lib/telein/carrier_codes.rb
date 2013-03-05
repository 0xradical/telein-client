# encoding: utf-8
module Telein
  # The mapping of carrier codes and meanings , in pt-BR
  # @todo Maybe provide in en-US format
  CARRIER_CODES = {
    12  => "CTBC",
    14  => "Brasil Telecom",
    20  => "Vivo",
    21  => "Claro",
    23  => "Telemig",
    24  => "Amazonia",
    31  => "Oi",
    37  => "Unicel",
    41  => "TIM",
    43  => "Sercomercio",
    77  => "Nextel",
    98  => "Fixo",
    99  => "Número não encontrado",
    100 => "Número inválido",
    101 => "Erro no servidor",
    990 => "IP blacklisted",
    995 => "IP excedeu 6 consultas/hora nas últimas 24 horas",
    999 => "Chave inválida" }
end