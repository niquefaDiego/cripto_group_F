class LazyAES
  def self.encrypt(m, k)
    if m.length % 32 != 0
      n_blocks = (m.length / 32) + 1
      m = m.ljust(n_blocks * 32, "0")
    end

    current = add_round_key(m, get_key_permutation(k, 0))

    for i in 1..7
      current = shift_rows(current)
      current = sub_bytes(current)
      current = add_round_key(current, get_key_permutation(k, i))
    end

    return current
  end

  def self.decrypt(c, k)
    current = c
    for i in 7.downto(1)
      current = add_round_key(current, get_key_permutation(k, i))
      current = inv_sub_bytes(current)
      current = inv_shift_rows(current)
    end
    current = add_round_key(current, get_key_permutation(k, 0))
    return current
  end

  def self.get_key_permutation(k, n)
    key_list = k.scan(/.{2}/)
    res = ""
    for pos in K_PERMUTATIONS[n]
      res += key_list[pos]
    end
    return res
  end

  def self.add_round_key(m, kn)
    if m.length % 32 != 0 and kn.length != 32
      raise "Message or key do not have the required size"
    end

    result = ""
    for i in 0..((m.length/32)-1)
      block = m[(i*32)..(i*32)+31]
      result += (block.to_i(16) ^ kn.to_i(16)).to_s(16).rjust(32, "0")
    end
    return result
  end

  def self.sub_bytes(m)
    if m.length % 32 != 0
      raise "Message does not have the required size"
    end

    result = ""
    for i in 0..(m.length/2)-1
      ms = m[i*2].to_i(16)
      ls = m[i*2+1].to_i(16)
      result += S_BOX[ms][ls]
    end
    return result
  end

  def self.shift_rows(m)
    if m.length % 32 != 0
      raise "Message does not have the required size"
    end

    result = ""
    for i in 0..(m.length/32)-1
      block = m[(i*32)..(i*32)+31]
      result += block[0..7]
      for shift in 1..3
        result += block[shift*2+shift*8..shift*8+7] + block[shift*8..shift*8+shift*2-1]
      end
    end
    return result
  end

  def self.inv_sub_bytes(m)
    if m.length % 32 != 0
      raise "Message does not have the required size"
    end

    result = ""
    for i in 0..(m.length/2)-1
      ms = m[i*2].to_i(16)
      ls = m[i*2+1].to_i(16)
      result += INV_S_BOX[ms][ls]
    end
    return result
  end

  def self.inv_shift_rows(m)
    if m.length % 32 != 0
      raise "Message does not have the required size"
    end

    result = ""
    for i in 0..(m.length/32)-1
      block = m[(i*32)..(i*32)+31]
      result += block[0..7]
      for shift in 1..3
        result += block[shift*6+8..shift*8+7] + block[shift*8..shift*6+7]
      end
    end
    return result
  end

  K_PERMUTATIONS = [
      [11, 8, 28, 10, 27, 24, 3, 20, 5, 19, 26, 1, 2, 16, 18, 30],
      [14, 4, 19, 8, 7, 22, 27, 26, 31, 2, 12, 17, 10, 23, 28, 3],
      [29, 3, 21, 14, 24, 13, 7, 26, 5, 27, 16, 31, 22, 8, 23, 17],
      [19, 3, 28, 4, 21, 24, 18, 5, 11, 20, 13, 17, 9, 16, 10, 1],
      [6, 17, 25, 10, 18, 28, 14, 7, 30, 1, 11, 3, 21, 13, 27, 26],
      [16, 3, 0, 17, 9, 19, 25, 10, 4, 12, 29, 11, 5, 15, 26, 8],
      [4, 7, 2, 25, 22, 20, 23, 29, 17, 12, 19, 6, 21, 10, 28, 16],
      [17, 13, 1, 4, 22, 15, 0, 14, 26, 29, 11, 7, 12, 19, 23, 31]
  ]

  S_BOX = [
      ["63", "7c", "77", "7b", "f2", "6b", "6f", "c5", "30", "01", "67", "2b", "fe", "d7", "ab", "76"],
      ["ca", "82", "c9", "7d", "fa", "59", "47", "f0", "ad", "d4", "a2", "af", "9c", "a4", "72", "c0"],
      ["b7", "fd", "93", "26", "36", "3f", "f7", "cc", "34", "a5", "e5", "f1", "71", "d8", "31", "15"],
      ["04", "c7", "23", "c3", "18", "96", "05", "9a", "07", "12", "80", "e2", "eb", "27", "b2", "75"],
      ["09", "83", "2c", "1a", "1b", "6e", "5a", "a0", "52", "3b", "d6", "b3", "29", "e3", "2f", "84"],
      ["53", "d1", "00", "ed", "20", "fc", "b1", "5b", "6a", "cb", "be", "39", "4a", "4c", "58", "cf"],
      ["d0", "ef", "aa", "fb", "43", "4d", "33", "85", "45", "f9", "02", "7f", "50", "3c", "9f", "a8"],
      ["51", "a3", "40", "8f", "92", "9d", "38", "f5", "bc", "b6", "da", "21", "10", "ff", "f3", "d2"],
      ["cd", "0c", "13", "ec", "5f", "97", "44", "17", "c4", "a7", "7e", "3d", "64", "5d", "19", "73"],
      ["60", "81", "4f", "dc", "22", "2a", "90", "88", "46", "ee", "b8", "14", "de", "5e", "0b", "db"],
      ["e0", "32", "3a", "0a", "49", "06", "24", "5c", "c2", "d3", "ac", "62", "91", "95", "e4", "79"],
      ["e7", "c8", "37", "6d", "8d", "d5", "4e", "a9", "6c", "56", "f4", "ea", "65", "7a", "ae", "08"],
      ["ba", "78", "25", "2e", "1c", "a6", "b4", "c6", "e8", "dd", "74", "1f", "4b", "bd", "8b", "8a"],
      ["70", "3e", "b5", "66", "48", "03", "f6", "0e", "61", "35", "57", "b9", "86", "c1", "1d", "9e"],
      ["e1", "f8", "98", "11", "69", "d9", "8e", "94", "9b", "1e", "87", "e9", "ce", "55", "28", "df"],
      ["8c", "a1", "89", "0d", "bf", "e6", "42", "68", "41", "99", "2d", "0f", "b0", "54", "bb", "16"]
  ]

  INV_S_BOX = [
      ["52", "09", "6a", "d5", "30", "36", "a5", "38", "bf", "40", "a3", "9e", "81", "f3", "d7", "fb"],
      ["7c", "e3", "39", "82", "9b", "2f", "ff", "87", "34", "8e", "43", "44", "c4", "de", "e9", "cb"],
      ["54", "7b", "94", "32", "a6", "c2", "23", "3d", "ee", "4c", "95", "0b", "42", "fa", "c3", "4e"],
      ["08", "2e", "a1", "66", "28", "d9", "24", "b2", "76", "5b", "a2", "49", "6d", "8b", "d1", "25"],
      ["72", "f8", "f6", "64", "86", "68", "98", "16", "d4", "a4", "5c", "cc", "5d", "65", "b6", "92"],
      ["6c", "70", "48", "50", "fd", "ed", "b9", "da", "5e", "15", "46", "57", "a7", "8d", "9d", "84"],
      ["90", "d8", "ab", "00", "8c", "bc", "d3", "0a", "f7", "e4", "58", "05", "b8", "b3", "45", "06"],
      ["d0", "2c", "1e", "8f", "ca", "3f", "0f", "02", "c1", "af", "bd", "03", "01", "13", "8a", "6b"],
      ["3a", "91", "11", "41", "4f", "67", "dc", "ea", "97", "f2", "cf", "ce", "f0", "b4", "e6", "73"],
      ["96", "ac", "74", "22", "e7", "ad", "35", "85", "e2", "f9", "37", "e8", "1c", "75", "df", "6e"],
      ["47", "f1", "1a", "71", "1d", "29", "c5", "89", "6f", "b7", "62", "0e", "aa", "18", "be", "1b"],
      ["fc", "56", "3e", "4b", "c6", "d2", "79", "20", "9a", "db", "c0", "fe", "78", "cd", "5a", "f4"],
      ["1f", "dd", "a8", "33", "88", "07", "c7", "31", "b1", "12", "10", "59", "27", "80", "ec", "5f"],
      ["60", "51", "7f", "a9", "19", "b5", "4a", "0d", "2d", "e5", "7a", "9f", "93", "c9", "9c", "ef"],
      ["a0", "e0", "3b", "4d", "ae", "2a", "f5", "b0", "c8", "eb", "bb", "3c", "83", "53", "99", "61"],
      ["17", "2b", "04", "7e", "ba", "77", "d6", "26", "e1", "69", "14", "63", "55", "21", "0c", "7d"]
  ]
end
