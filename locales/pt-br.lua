local Translations = {
    error = {
        owner = "Você não e dono desse veiculo",
        notvehicledist = "Você não esta proximo da placa do veiculo",
        platelen = "Tamanho da placa Incompativel"
    },

    success = {
        plate = "Placa alterada com sucesso",
    },

    Progressbar = {
        changingPlate = "Trocando Placa",
    }

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})