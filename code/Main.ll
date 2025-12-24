from io import *
from sys import *
from window import *
from obj import *
from math import *

function overlap(rect1px,rect1py,rect1dx,rect1dy,rect2px,rect2py,rect2dx,rect2dy)
    if rect1px < (rect2px - rect1dx)
        return false
    elif rect1px >= (rect2px + rect2dx)
        return false
    elif rect1py < (rect2py - rect1dy)
        return false
    elif rect1py >= (rect2py + rect2dy)
        return false        
    end
    return true
end

function main()
    w = window::new("Pong with LuaLike",1900,1000)
    w.init()

    PADDLEWIDTH = 0.03
    PADDLEHEIGHT = 0.2
    BALLWIDTH = 0.027
    BALLHEIGHT = 0.05

    score1 = 0
    score2 = 0
    
    rect1x = 0.0
    rect1y = 0.5
    rect2x = 1.0 - PADDLEWIDTH
    rect2y = 0.5
    
    ballx = 0.5
    bally = 0.5

    ballvelox = -0.2
    ballveloy = 0.2

    while w.running()
        w.update()

        if w.key("W","down")
            rect1y = rect1y - 0.5 * w.elapsed()
        elif w.key("S","down")
            rect1y = rect1y + 0.5 * w.elapsed()
        end

        if w.key("UP","down")
            rect2y = rect2y - 0.5 * w.elapsed()
        elif w.key("DOWN","down")
            rect2y = rect2y + 0.5 * w.elapsed()
        end

        ballx = ballx + ballvelox * w.elapsed()
        bally = bally + ballveloy * w.elapsed()

        if rect1y < 0.0
            rect1y = 0.0
        end
        if rect1y > (1.0 - PADDLEHEIGHT)
            rect1y = 1.0 - PADDLEHEIGHT
        end
        if rect2y < 0.0
            rect2y = 0.0
        end
        if rect2y > (1.0 - PADDLEHEIGHT)
            rect2y = 1.0 - PADDLEHEIGHT
        end

        if bally < 0.0
            bally = 0.0
            ballveloy = -ballveloy * 1.05
        end
        if bally > (1.0 - BALLHEIGHT)
            bally = 1.0 - BALLHEIGHT
            ballveloy = -ballveloy * 1.05
        end
        if ballx < (-PADDLEWIDTH)
            ballx = 0.5
            bally = 0.5
            ballvelox = 0.2
            ballveloy = 0.2
            score2 = score2 + 1
        end
        if ballx > 1.0
            ballx = 0.5
            bally = 0.5
            ballvelox = 0.2
            ballveloy = 0.2
            score1 = score1 + 1
        end

        -- if rect1x >= (ballx - PADDLEWIDTH) && rect1x < (ballx + BALLWIDTH) && rect1y >= (bally - PADDLEHEIGHT) && rect1y < (bally + BALLHEIGHT)
        --     ballvelox = -ballvelox * 1.1
        -- end
        if overlap(rect1x,rect1y,PADDLEWIDTH,PADDLEHEIGHT,ballx,bally,BALLWIDTH,BALLHEIGHT)
            ballvelox = -ballvelox * 1.1
        end
        if rect2x >= (ballx - PADDLEWIDTH) && rect2x < (ballx + BALLWIDTH) && rect2y >= (bally - PADDLEHEIGHT) && rect2y < (bally + BALLHEIGHT)
            ballvelox = -ballvelox * 1.1
        end


        w.clear(0xFF000000)
        
        wwidth = w.width()
        wheight = w.height()
        w.rect(rect1x * wwidth,rect1y * wheight,PADDLEWIDTH * wwidth,PADDLEHEIGHT * wheight,0xFF0000FF)
        w.rect(rect2x * wwidth,rect2y * wheight,PADDLEWIDTH * wwidth,PADDLEHEIGHT * wheight,0xFFFF0000)
        w.rect(ballx * wwidth,bally * wheight,BALLWIDTH * wwidth,BALLHEIGHT * wheight,0xFFFFFFFF)

        sc1 = math::getInt(score1)
        sc2 = math::getInt(score2)
        w.string(sc1+" : "+sc2,0.5 * wwidth,0.01 * wheight,0xFFFFFFFF)

        w.render()
        sys::msleep(5)
    end

    return 0
end