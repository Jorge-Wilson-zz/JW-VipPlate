local Translations = {
    error = {
        owner = "You are not the owner of this vehicle",
        notvehicledist = "You are not close to the license plate",
        platelen = "Incompatible board size"
    },

    success = {
        plate = "Subject Changed Successfully",
    },

    Progressbar = {
        changingPlate = "Swapping Board",
    }

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})