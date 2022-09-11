/**
 *
 *          FILE:  hxltm-web-utils.js
 *                 assets/js/hxltm-web-utils.js
 *
 *         USAGE:  ---
 *
 *   DESCRIPTION:  hxltm-web-utils
 *
 *  REQUIREMENTS:  - papaparse
 *          BUGS:  ---
 *         NOTES:  ---
 *        AUTHOR:  Emerson Rocha <rocha[at]ieee.org>
 *       COMPANY:  EticaAI
 *       LICENSE:  Public Domain dedication
 *                 SPDX-License-Identifier: Unlicense
 *       VERSION:  v1.0
 *       CREATED:  2022-09-11 20:29 UTC
 *      REVISION:  ---
**/

console.log('hxltm-web-utils.js')

/**
 * hxltm_headers_filter
 *
 * @param {array} headers 
 * @returns {array}
 */
function hxltm_headers_filter(headers) {
  let new_headers = []
  headers.forEach(function (item) {
    if (!(item.startsWith('#meta'))) {
      new_headers.push(item)
    }
  })
  return new_headers
}

/**
 * 
 * @param {string} remove_csv 
 * @param {Object} options
 * @param {callback} cb
 * @returns {number}
 */
function hxltm_prefetch(remove_csv, _options, cb) {
  Papa.parse(remove_csv, {
    download: true,
    header: true,
    worker: false,
    preview: 1,
    // skipEmptyLines: 'greedy',
    // escapeFormulae: false,
    // transform: function (value, header) {
    //   return value
    // },
    step: function (row) {
      // console.log("Row:", row.data);
      let original_headers = Object.keys(row.data)
      let new_headers = hxltm_headers_filter(original_headers)
      console.log('headers', original_headers, new_headers)
      cb({ options: new_headers })
    },
    // complete: function () {
    //   console.log("hxltm_prefetch: All done!");
    // }
    // complete: function(results, file) {
    //   console.log("Parsing complete:", results, file);
    //   cb()
    // }

  });
  // console.log(remove_csv, cb)
}

/**
 * 
 * @param {string} remove_csv 
 * @param {Object} options
 * @param {callback} cb
 */
function hxltm_fetch(remove_csv, options, cb) {
  Papa.parse(remove_csv, {
    download: true,
    header: true,
    worker: true,
    preview: 0,
    skipEmptyLines: 'greedy',
    escapeFormulae: false,
    columns: options.columns,
    // transform: function (value, header) {
    //   return value
    // },
    step: function (row) {
      console.log("Row:", row.data);
    },
    complete: function () {
      console.log("hxltm_fetch All done!");
      cb()
    }
  });
  console.log('hxltm_fetch', remove_csv, callback)
}

let remote_csv = "http://git.workspace.localhost/fititnt/awesome-spatial-reference-data/data/cod_ab.hxl.csv"
// hxltm_fetch('./data/cod_ab.hxl.csv', console.log)
hxltm_prefetch(remote_csv, null, function (options) {
  console.log('hxltm_prefetch done')
  hxltm_fetch(remote_csv, options, function () {
    console.log('hxltm_fetch done')
  })
})

// hxltm_prefetch(remote_csv, null, function (options) {
//   console.log('hxltm_prefetch done')
//   // hxltm_fetch(remote_csv, options, function () {
//   //   console.log('hxltm_fetch done')
//   // })
// })
// hxltm_fetch("http://git.workspace.localhost/fititnt/awesome-spatial-reference-data/data/cod_ab.hxl.csv", console.log)
