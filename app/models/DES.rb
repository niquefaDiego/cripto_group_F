class DES 
    
    def self.encrypt( s,  key)
        
        if s.size % 8  != 0
            s += "\0" * (s.size % 8)
        end

        a = ""

        for i in 0..(s.size / 8)
            a += encrypt_64(s[(i*8)..(i*8+7)], key)
        end

        return a
    end

    NS = [1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1]

    PC =[ 0 , [57,49, 41,33, 25, 17, 9,
    1,58, 50,42, 34, 26,18,
    10, 2, 59,51, 43, 35,27,
    19,11,  3,60, 52, 44,36,
    63,55, 47,39, 31, 23,15,
    7,62, 54,46, 38, 30,22,
    14, 6, 61,53, 45, 37,29,
    21,13,  5,28, 20, 12, 4] ,
    [ 14 ,17,11 ,24 , 1 ,5 ,
    3 ,   28,   15,  6 ,21,   10,
    23 ,19,12 , 4, 26, 8,
    16 , 7,27 ,20, 13, 2,
    41 ,52,31 ,37, 47,55,
    30 ,40,51 ,45, 33,48,
    44 ,49,39 ,56, 34,53,
    46 ,42,50 ,36, 29,32 ]
    ]

    def encrypt_64(s, key)
        k = []
        k.append(permutation(key,1))
        c = Array.new #izquierda
        d = Array.new #derecha
        c.append(k[0][0..27])
        d.append(k[0][28..55])
        for i in 0..15
            c_temp = c[-1][NS[i]..-1] + c[-1][0..(NS[i]-1)]
            d_temp = d[-1][NS[i]..-1] + d[-1][0..(NS[i]-1)]
            c.append(c_temp)
            d.append(d_temp)
        end
        for i in 1..16
            k.append(permutation(c[i]+d[i],2))
            puts k[-1]
        end

            
    end

    def decrypt( s,  key)

    end

    
    def permutation(key, n_p)
        p = ""
        chars = key.split('')
        for i in PC[n_p]
            p += chars[i-1]
        end
        return p
    end

end
