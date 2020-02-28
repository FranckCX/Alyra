// const readline = require("readline");
// const fetch = require("node-fetch");
// const rl = readline.createInterface({
//     input: process.stdin,
//     output: process.stdout
// });

// rl.question("Get Last Exchange rate for ", function(symbol) {
//         fetch('https://api.bitfinex.com/v1/pubticker/' + symbol)
//         .then(function(response) {
//             return response.json();
//         })
//         .then(function(myJson) {
//             console.log(`Last exchange rate (${symbol}) : ${myJson.last_price}$`);
//         })
//         .catch(err => console.error(err));
//         console.log(`Last exchange rate (${symbol}) : ${myJson.last_price}$`);
//         rl.close();
// });

// rl.on("close", function() {
//     process.exit(0);
// });

 
const fetch = require("node-fetch");

function getLastExchangePriceFor(symbol) {
    fetch('https://api.bitfinex.com/v1/pubticker/' + symbol)
        .then(function(response) {
            return response.json();
        })
        .then(function(myJson) {
            console.log(`Last exchange price for (${symbol}) : ${myJson.last_price}$`);
        })
        .catch(err => console.error(err));
}

getLastExchangePriceFor('btcusd')
