//
//  PopulateDB.swift
//  Database
//
//  Created by Sofia on 16/01/23.
//

import Foundation


extension DBSong {
    
    func Populate() {
        Clear()
        
        let s = Song()
        s.SetTitle("Goodbye cruel world")
        s.SetAuthor("Pink Floyd")
        s.SetLyrics("""
Goodbye cruel world
I'm leaving you today
Goodbye
Goodbye
Goodbye

Goodbye all you people
There's nothing you can say
To make me change my mind
Goodbye

2 Goodbye cruel world (Pink Floyd 2)
Goodbye cruel world
I'm leaving you today
Goodbye
Goodbye
Goodbye

Goodbye all you people
There's nothing you can say
To make me change my mind
Goodbye
""")
        Add(s)
        
        s.SetTitle("Bohemian Rapsody")
        s.SetAuthor("Queen")
        s.SetLyrics("""
Is this the real life?
Is this just fantasy?
Caught in a landside,
No escape from reality
Open your eyes,
Look up to the skies and see,
I'm just a poor boy, I need no sympathy,
Because I'm easy come, easy go,
Little high, little low,
Any way the wind blows doesn't really matter to
Me, to me
Mamaaa,
Just killed a man,
Put a gun against his head, pulled my trigger,
Now he's dead
Mamaaa, life had just begun,
But now I've gone and thrown it all away
Mama, oooh,
Didn't mean to make you cry,
If I'm not back again this time tomorrow,
Carry on, carry on as if nothing really matters
Too late, my time has come,
Sends shivers down my spine, body's aching all
The time
Goodbye, everybody, I've got to go,
Gotta leave you all behind and face the truth
Mama, oooh
I don't want to die,
I sometimes wish I'd never been born at all.
I see a little silhouetto of a man,
Scaramouch, Scaramouch, will you do the Fandango!
Thunderbolts and lightning, very, very frightening me
Galileo, Galileo
Galileo, Galileo
Galileo, Figaro - magnifico
I'm just a poor boy nobody loves me
He's just a poor boy from a poor family,
Spare him his life from this monstrosity
Easy come, easy go, will you let me go
Bismillah! No, we will not let you go
(Let him go!) Bismillah! We will not let you go
(Let him go!) Bismillah! We will not let you go
(Let me go) Will not let you go
(Let me go)(Never) Never let you go
(Let me go) (Never) let you go (Let me go) Ah
No, no, no, no, no, no, no
Oh mama mia, mama mia, mama mia, let me go
Beelzebub has a devil put aside for me, for me,
For me
So you think you can stop me and spit in my eye
So you think you can love me and leave me to die
Oh, baby, can't do this to me, baby,
Just gotta get out, just gotta get right outta here
Nothing really matters, Anyone can see,
Nothing really matters,
Nothing really matters to me
Any way the wind blows...
""")
        Add(s)

        s.SetTitle("Coraline")
        s.SetAuthor("Maneskin")
        s.SetLyrics("""
Dimmi le tue verità, Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Coraline bella come il sole
Guerriera dal cuore zelante
Capelli come rose rosse
Preziosi quei fili di rame, amore, portali da me
Se senti campane cantare
Vedrai Coraline che piange
Che prende il dolore degli altri
E poi lo porta dentro lei
Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Però lei sa la verità
Non è per tutti andare avanti
Con il cuore che è diviso in due metà
È freddo già
È una bambina però sente come un peso
E prima o poi si spezzerà
La gente dirà, 'Non vale niente'
Non riesce neanche a uscire da una misera porta
Ma un giorno, una volta, lei ci riuscirà
E ho detto a Coraline che può crescere
Prendere le sue cose e poi partire
Ma sente un mostro che la tiene in gabbia, che
Che le ricopre la strada di mine
E ho detto a Coraline che può crescere
Prendere le sue cose e poi partire
Ma Coraline non vuole mangiare, no
Sì, Coraline vorrebbe sparire
E Coraline piange
Coraline ha l'ansia
Coraline vuole il mare ma ha paura dell'acqua
E forse il mare è dentro di lei
E ogni parola è un'ascia
Un taglio sulla schiena
Come una zattera che naviga in un fiume in piena
E forse il fiume è dentro di lei, di lei
Sarò il fuoco ed il freddo
Riparo d'inverno
Sarò ciò che respiri
Capirò cos'hai dentro
E sarò l'acqua da bere
Il significato del bene
Sarò anche un soldato
O la luce di sera
E in cambio non chiedo niente
Soltanto un sorriso
Ogni tua piccola lacrima è oceano sopra al mio viso
E in cambio non chiedo niente
Solo un po' di tempo
Sarò vessillo, scudo
O la tua spada d'argento e
E Coraline piange
Coraline ha l'ansia
Coraline vuole il mare ma ha paura dell'acqua
E forse il mare è dentro di lei
E ogni parola è un'ascia
Un taglio sulla schiena
Come una zattera che naviga in un fiume in piena
E forse il fiume è dentro di lei, di lei
E dimmi le tue verità, Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Dimmi le tue verità, Coraline, Coraline
Coraline, bella come il sole
Ha perso il frutto del suo ventre
Non ha conosciuto l'amore
Ma un padre che di padre ha niente
Le han detto in città c'è un castello
Con mura talmente potenti
Che se ci vai a vivere dentro
Non potrà colpirti più niente
Non potrà colpirti più niente
""")
        Add(s)

        s.SetTitle("Kiss")
        s.SetAuthor("Prince")
        s.SetLyrics("""
Uh
You don't have to be beautiful
To turn me on
I just need your body, baby
From dusk 'til dawn
You don't need experience
To turn me out
You just leave it all up to me
I'm gonna show you what it's all about
You don't have to be rich
To be my girl
You don't have to be cool
To rule my world
Ain't no particular sign
I'm more compatible with
I just want your extra time and your
Kiss
Ah, oh-oh
You got to not talk dirty, baby
If you wanna impress me (ah)
You can't be too flirty, mama
I know how to undress me, yeah
I want to be your fantasy
Maybe you could be mine
You just leave it all up to me
We could have a good time, uh
Don't have to be rich
To be my girl
You don't have to be cool
To rule my world
Ain't no particular sign
I'm more compatible with
I just want your extra time and your
Kiss
Yes, oh-oh-oh-oh
Ah
I think I wanna dance
Uh
Ooh
Gotta, gotta, oh
Little girl Wendy's parade
Gotta, gotta, gotta
Women, not girls, rule my world
I said they rule my world
Act your age, mama (not your shoe size)
Not your shoe size
Maybe we could do the twirl
You don't have to watch Dynasty
To have an attitude, uh
You just leave it all up to me
My love will be your food
Yeah
You don't have to be rich
To be my girl
You don't have to be cool
To rule my world
Ain't no particular sign
I'm more compatible with
I just want your extra time and your
Kiss
""")
        Add(s)

        s.SetTitle("PTY")
        s.SetAuthor("Michael Jackson")
        s.SetLyrics("""
You know you, you make me feel so good inside
I always wanted a girl just like you
Such a PYT, Pretty Young Thing, ooh
Where did you come from, lady?
And, ooh, won't you take me there
Right away, won't you, baby?
Tenderoni, you've got to be
Spark my nature, sugar fly with me
Don't you know now is the perfect time?
We can make it right, hit the city lights
Then tonight, ease the loving pain
Let me take you to the max
I want to love you (PYT)
Pretty young thing
You need some loving (TLC)
Tender love and care
And I'll take you there, girl, ooh-oh
I want to love you (PYT)
Pretty young thing
You need some loving (TLC)
Tender love and care
And I'll take you there
(Anywhere you want to go) yes, I will, ooh!
Nothing can stop this burning desire to be with you
Got to get to you, baby
Won't you come, it's emergency
Cool my fire yearning
Honey, come set me free
Don't you know now is the perfect time?
We can dim the lights, just to make it right
In the night, hit the loving spot
I'll give you all that I've got
I want to love you (PYT)
Pretty young thing
You need some loving (TLC)
Tender love and care
And I'll take you there, yes, I will, yes, I will
I want to love you (PYT)
Pretty young thing
You need some loving (TLC)
Tender love and care
And I'll take you there
Yes, I will, hee-eh
Pretty young things, repeat after me
Sing, 'na-na-na' (Na-na-na)
'Na-na-na-na' (Na-na-na-na)
Sing, 'na-na-na' (Na-na-na)
'Na-na-na-na' (Na-na-na-na)
I will take you there, take you there
I want to love you (PYT)
Pretty young thing
You need some loving (TLC)
Tender love and care
And I'll take you there, take you there, take you there
I want to love you (PYT)
Pretty young thing
You need some loving (TLC)
Tender love and care
And I'll take you there, take you there, hoo-ooh
Hoo-ooh! (PYT)
Oh, baby (TLC)
Oh, baby
Hold on, ooh-ooh
You know, I think you're really nice (PYT)
You and I could've just put together (TLC)
You're such a P.Y.T. to me, pretty young thing
Oh, baby, oh, baby, hold on (PYT)
Oh, baby (TLC)
You can be, oh
I just wanna love you, you know, it's
I'd give you all
""")
        Add(s)

        s.SetTitle("Wannabe")
        s.SetAuthor("Spice Girls")
        s.SetLyrics("""
Yeah, I'll tell you what I want, what I really, really want
So tell me what you want, what you really, really want
I'll tell you what I want, what I really, really want
So tell me what you want, what you really, really want
I wanna, I wanna, I wanna, I wanna
I really, really, really wanna zigazig ah
I wanna, I wanna, I wanna
I really, really, really wanna zigazig ah
If you want my future, forget my past
If you wanna get with me, better make it fast
Now don't go wasting my precious time
Get your act together we could be just fine
If you wanna be my lover, you gotta get with my friends
Make it last forever, friendship never ends
If you wanna be my lover, you have got to give
Taking is too easy, but that's the way it is
Yeah, I'll tell you what I want, what I really, really want
So tell me what you want, what you really, really want
I wanna, I wanna, I wanna, I wanna
I really, really, really wanna zigazig ah
What do you think about that, now you know how I feel
Say, you can handle my love, are you for real
I won't be hasty, I'll give you a try
If you really bug me then I'll say goodbye
If you wanna be my lover, you gotta get with my friends
Make it last forever, friendship never ends
If you wanna be my lover, you have got to give
Taking is too easy, but that's the way it is
Yeah, I'll tell you what I want, what I really, really want
So tell me what you want, what you really, really want
I wanna, I wanna, I wanna, I wanna
I really, really, really wanna zigazig ah
So, here's a story from A to Z
You wanna get with me, you gotta listen carefully
We got Em in the place who likes it in your face
You got G like MC who likes it on a
Easy V doesn't come for free, she's a real lady
And as for me, ah you'll see
Slam your body down and wind it all around
Slam your body down and wind it all around
If you wanna be my lover, you gotta get with my friends
Make it last forever, friendship never ends
Yeah, I'll tell you what I want, what I really, really want
So tell me what you want, what you really, really want
I wanna, I wanna, I wanna, I wanna
I really, really, really wanna zigazig ah
Yeah, I'll tell you what I want, what I really, really want
So tell me what you want, what you really, really want
I wanna, I wanna, I wanna, I wanna
I really, really, really wanna zigazig ah
Slam your body down and wind it all around
(I really, really, really wanna zigazig ah)
Slam your body down and wind it all around
(I really, really, really wanna zigazig ah)
""")
        Add(s)


    }
    
}

