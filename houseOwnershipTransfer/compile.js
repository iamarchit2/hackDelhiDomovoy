const path = require('path');
const fs = require('fs');
const solc = require('solc')
// Cannot directly require .sol Files.
// Thus, we create a path and access it.

const lotteryPath = path.resolve(__dirname, 'contracts', 'house.sol');
// __dirname takes you to the working directory directly.
const source = fs.readFileSync(lotteryPath, 'utf8');
// read the file through fs -> FileSync
module.exports = solc.compile(source, 1).contracts[':House'];
//console.log(solc.compile(source, 1));
