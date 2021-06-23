/**
 * 获取max-min的随机数
 * @param {*} max
 * @param {*} min
 */
export function getRandom (max, min) {
  return Math.floor(Math.random() * (max - min) + min)
}

/**
 * -乱序数组
 * @param {Array} arr
 */
export function shuffle (arr) {
  return arr.sort(() => Math.random() - 0.5)
}
