const fetch = require("node-fetch");

function getLastExchangePriceFor(symbol) {
    fetch('https://data.messari.io/api/v1/assets/' + symbol + '/metrics')
        .then(function(response) {
            return response.json();
        })
        .then(function(myJson) {
            console.log(`${myJson.data.name}(${myJson.data.symbol}) <=> ${(myJson.data.market_data.price_usd).toFixed(2)}$`);
            console.log(`ATH (づ・ロ・)づ: ${myJson.data.all_time_high.price} $ => +/- ${(myJson.data.all_time_high.percent_down).toFixed(2)}% since ATH`);
            console.log(`Actual circulating supply: ${(myJson.data.supply.circulating).toFixed(4)} (2050 approx. total supply: ${(myJson.data.supply.circulating/myJson.data.supply.y_2050*100).toFixed(2)}%)`);
            console.log(`2050 approx circulating supply: ${myJson.data.supply.y_2050}.\n`);
        })
        .catch(err => console.error(err));
}

getLastExchangePriceFor('btc');
getLastExchangePriceFor('xmr');
getLastExchangePriceFor('xtz');