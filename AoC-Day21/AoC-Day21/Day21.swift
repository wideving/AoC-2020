import Foundation

struct Food {
    let ingredients: Set<String>
    let allergens: Set<String>
}

class Day21 {
    let inputs: [Food] = data.split(separator: "\n").map { row in
        let components = row.components(separatedBy: " (contains ")
        let ingredients = components[0].split(separator: " ").map { String($0) }
        var allergens = Set<String>()
        if components.count > 1 {
            components[1].components(separatedBy: ", ").forEach {
                allergens.insert($0.replacingOccurrences(of: ")", with: ""))
            }
        }
        
        return Food(ingredients: Set(ingredients), allergens: allergens)
    }
    
    func solve() {
        var possibleAllergens = [String: Set<String>]()
        
        inputs.forEach { food in
            food.allergens.forEach { allergen in
                if possibleAllergens.contains(where: { $0.key == allergen } ) {
                    possibleAllergens[allergen] = possibleAllergens[allergen]!.intersection(food.ingredients)
                } else {
                    possibleAllergens[allergen] = food.ingredients
                }
            }
        }
        
        var ingredientsWithAllergens = Set<String>()
        possibleAllergens.forEach {
            ingredientsWithAllergens.formUnion($0.value)
        }
        
        var allIngredients = [String]()
        inputs.forEach {
            allIngredients.append(contentsOf: $0.ingredients)
        }
        
        let allergenFreeIngredients = Set<String>(allIngredients).subtracting(ingredientsWithAllergens)

        print(allergenFreeIngredients.reduce(0, { result, ingredient in
            result + allIngredients.filter { $0 == ingredient}.count
        }))
        
    }
}

let data = """
pblqsd tdtg rrzf rsbxb mml hgflmgp lsb lxvc mzxmthz mdhvtc sdpssq cdmln zmsn vfmsk slmjgj nvjql hjbq cxsvdm mfpgdr kndg chvtbb gstc hjjg bvqlhhd ggvzz tjlqrg mtnh rpxdc vxqg hvrqsz fqnzvb bkz kktl ppf tlrjcv dsjtkv txdmlzd zbsmv jssz npkdtv vlblq hlkb kpq fpjgdr lzkc lrcxf msfd ftx mptbpz rfdqzf nccr scjsx ncth fqqhkbm qvcr vvptj glf tlls qmnqtm tjlxs bnqbh vgpdr ftxzklk zpcj kqqmg fdzjc ckzc dcrnk cq bbfm xtgghn nnzm (contains soy, fish)
zpkv qvcr nvq xntsmjqf vqtqp tlls frng rmbn jssz bvqlhhd vsjpsl krlr mtnh fzrmkrdh txdmlzd cjfdvf ghjhv rkd ftxzklk dhlrh mptbpz mgtl tdv qjn gnvmv cq msfd zthtx prgck shc slssgt gn vxdrhp vgpdr fdzjc lrcxf cknhk tmt vlblq fhrc lvfph glf xbnmzr rrvq qmnqtm kvgctt pcjf tjlqrg ftx kktl cmgvvr ggzb stmnld rsbxb vvptj ctmf cdmln prhkvgbh cfvdq hgflmgp vpmfdct zntx (contains soy, eggs, wheat)
zrt rdtbcz krlr sdst mtdzn vqtqp slssgt dhlrh hghtp lzkc xtgghn qvcr sptc shc nvq mzmpqh ttpxk xzfd fqqhkbm ftx cxsvdm dfgjq cdmln dfdmj kktl lvfph fsxkvv cjfdvf ggvzz hlkb mzcpbs rzmtsz ckzc vfmsk rkd vjlpj bs rsbxb rrzf dmnxl mptbpz vpmfdct nnzm txrtjzx xbnmzr cxsmk tzlx tlrjcv glf mdhvtc gnvmv mchrgcrj pmznfk dkq ppf zpcj zcsmnq mgtl sdpssq mtnh ggzb zplxgb ftxzklk bftd zffkzcp zbblpvfb txdmlzd rfdqzf stbldpp rmxph xntsmjqf (contains dairy, eggs)
cvptv xhzkj glf tshxt rfdqzf vqtqp lrcxf pblqsd gblh bbfm chvtbb rsbxb mzxmthz zthtx fdzjc prgck cxsmk cjfdvf flcd ckzc vlblq sqmqz ppf rmbn vxgn mptbpz kll kqqmg cmgvvr tdkcd txdmlzd hgflmgp cxsvdm cdmln fhrc xbnmzr tdv vxqg dfdmj hvrqsz vvptj tjlqrg ncth hdbmkt zntx lvfph pcjf bftd dcrnk gn dhjrmdl (contains dairy)
vfmsk slmjgj cxsvdm nvq vlblq gnvmv cxsmk rl kpq dcrnk tgdk bhhmjbk qmnqtm fsxkvv bftd ggvzz cmgvvr fhrc zcsmnq vsjpsl xtgghn zthtx cjfdvf tlrjcv ftxzklk xbnmzr prgck zbblpvfb bkz frng zntx glf sfxd fdzjc fqnzvb ftx slssgt cknhk qtlnsrq lzkc thbx rrvq sptc xhzkj jzdzmg ggzb rsbxb mgdjxn kqqmg dmnxl mzmpqh dsjtkv fpjgdr txdmlzd mptbpz cfvdq (contains wheat)
nvq vlblq qvcr rkd rmbn ggzb xtgghn nvjql kslxsfnv mzmpqh fqqhkbm qnbf hgflmgp vxgn vgpdr sfxd cmgvvr zmsn tgdk ttpxk zcsmnq dmnxl stbldpp zpkv qtlnsrq klrnc vpmfdct nnzm tjlqrg pcjf pllr kll jssz ksfgf cxsmk rfdqzf prhkvgbh vvptj ncth nccr vjlpj flcd hjbq xjx cdmln slmjgj hghtp lsb xbnmzr zffkzcp tshxt cvptv ctmf lzkc ldl vfhkmn bkz slssgt txdmlzd mtnh sptc tdkcd dhjrmdl cxsvdm dhlrh rdtbcz lxvc vbsz bhhmjbk cq mptbpz rl vqtqp fdzjc glf zplxgb xzfd gnvmv xhzkj zbblpvfb tlls mgtl hvrqsz (contains peanuts, eggs, sesame)
msfd fqnzvb tjlqrg ksfgf gfkt zthtx dbds lxvc vgpdr glf zpcj xhzkj mptbpz rrzf krlr slmjgj cfvdq tlls rmxph mzcpbs dfgjq rfdqzf zmsn lrcxf tlrjcv thbx vzcgt lvfph dkq kslxsfnv tdkcd zcsmnq ttpxk kvff flcd mtnh hghtp kktl rmbn gn vlblq xntsmjqf prhkvgbh tjlxs pcjf hjbq bs kvgctt stmnld sn ctmf jgjx rhmpqn kcvgs rl cq vxdrhp pblqsd ggzb shc zntx rsbxb kqqmg cxsvdm txrtjzx hdbmkt dqldvn zbsmv kll txdmlzd jzdzmg klrnc mzmpqh zrt ldnvr nnzm prfjk (contains wheat, dairy)
kndg jzdzmg txdmlzd ldnvr vqtqp frng cxsvdm fsxkvv rhnd hglq gnvmv thbx bbfm shc zmsn sptc fqqhkbm qsvfj nkv lzkc pk ncth rhmpqn gdpdm bnqbh pcjf mchrgcrj dbds gn zthtx kpq stbldpp dqldvn rrzf mtnh zplxgb vlblq rsbxb mptbpz ncknc ccqpr ksfgf xbnmzr jgjx mzxmthz (contains peanuts, fish, dairy)
prgck bs kktl vjlpj rhnd gfkt rmxph vjrlml msfd zffkzcp mchrgcrj mptbpz cmgvvr zrt txrtjzx tjlxs kqqmg rdtbcz lzkc hjbq pblqsd sdst xntsmjqf hgflmgp bvqlhhd lsb sn txdmlzd kslxsfnv bkz vfmsk nnzm dhjrmdl sptc gblh vlblq hglq xhzkj rsbxb vsjpsl flcd kvgctt mgdjxn hghtp tjlqrg tdv tlls cxsvdm rfdqzf fqnzvb mtdzn kndg dsjtkv pvg sqmqz mzxmthz gnvmv vzcgt cq ggzb xbnmzr gstc rrvq dkq qmnqtm pmznfk krlr qtlnsrq vbsz lxvc pllr mtnh hdbmkt rl kffdz prfjk kvff jzdzmg qsvfj npkdtv rzmtsz (contains nuts, wheat, fish)
vxgn rhmpqn glf kqqmg fpjgdr ncknc tzlx kcvgs rl bftd tdtg hjjg xbnmzr rsbxb dhjrmdl xjx ksfgf tgdk jzdzmg dfgjq sn kpq vxdrhp qtlnsrq mchrgcrj krlr cxsvdm mptbpz vxqg cknhk jssz msfd cjfdvf tmt pblqsd ghjhv vfhkmn ttpxk ldnvr zdkxzm mzmpqh npkdtv vgpdr ggzb vjrlml zpkv bvqlhhd bqgjz vfmsk ggvzz tdv pllr vvptj scjsx txdmlzd nvq pcjf hghtp bhhmjbk kvff cq pmznfk pvg tjlxs vlblq ftx chvtbb lsb hgflmgp nxtvs (contains nuts)
kll flcd nccr tdkcd rpxdc ncth rrvq vlblq cdmln vfmsk krlr txrtjzx hrflzj cblbf tdv kndg mml fqnzvb shc slssgt qtlnsrq vxgn stbldpp ggzb gstc ncknc nxtvs vjlpj txdmlzd cxsvdm bs kvgctt hglq rfdqzf qnbf hvrqsz glf cknhk zntx msfd lrcxf rzsvmj zplxgb zpcj rhmpqn vzcgt xhzkj lsb kvff ghjhv hghtp mchrgcrj zbblpvfb sn qsvfj slmjgj ldl fsxkvv mdhvtc xjx vvptj pllr zbsmv kffdz dqldvn pmznfk frng pk sdpssq rsbxb vgpdr fqqhkbm rmbn bvqlhhd mzxmthz vsjpsl vbsz kqqmg tmt tlrjcv gdpdm xbnmzr mptbpz mgtl (contains nuts, peanuts, fish)
zpkv mtnh msfd zdkxzm zrt glv kll prhkvgbh rpxdc rfdqzf sn zffkzcp nvjql gblh gstc dhlrh hjbq kndg sqmqz mzmpqh bs vxqg rrzf kvff vbsz vgpdr cknhk sdpssq pcjf mzcpbs vlblq glf cmgvvr fqqhkbm shc stbldpp scjsx vzcgt lxvc lsb hghtp frng txdmlzd mptbpz rsbxb fpjgdr lvfph slmjgj ggzb xzfd cxsvdm tlls mzxmthz vxdrhp (contains sesame, soy)
kktl tjlqrg jssz rsbxb xzfd gfkt pblqsd tdv ncth dhjrmdl xtgghn pmznfk hjjg rfdqzf dfgjq mzxmthz mgtl bnqbh vxdrhp ppf ckzc lzkc mptbpz qtlnsrq gn prhkvgbh rdtbcz vjrlml qggdgf mtnh bhhmjbk kffdz fzrmkrdh glf vfhkmn pvg cmgvvr kll xbnmzr qmnqtm mtdzn kcvgs dkq dqldvn cxsvdm mml rmxph txdmlzd zpcj nkv vzcgt vbsz kndg nccr fqqhkbm hlkb nvq nnzm rzmtsz (contains eggs)
mptbpz glf chvtbb dkq xntsmjqf xjx bhhmjbk hgflmgp fpjgdr hvrqsz vfhkmn kndg vzcgt rhnd mgtl thbx rdtbcz rmxph zpkv pllr zbsmv nvjql xbnmzr tjlqrg pvg qggdgf fhrc bftd ckzc pmznfk cblbf mtdzn klrnc hglq kvff zntx mtnh dfgjq bnqbh txdmlzd ftx jgjx vfmsk slssgt frng vgpdr tgdk pblqsd lrcxf xhzkj kpq rl nvq dmnxl tlrjcv hdbmkt pk gnvmv tzlx cxsvdm rhmpqn cjfdvf lzkc qvcr mfpgdr mdhvtc rzsvmj hghtp tmt nxtvs vlblq tdkcd kvgctt ftxzklk vjlpj lvfph rzmtsz vqtqp slmjgj jzdzmg (contains dairy)
xjx xbnmzr prfjk mgdjxn glf hghtp cxsvdm vlblq mml sn qggdgf vjlpj frng vjrlml mzmpqh lrcxf rsbxb qmnqtm ckzc nccr rzmtsz hjjg hgflmgp stbldpp kvff cfvdq rhmpqn txdmlzd prhkvgbh hjbq prgck gnvmv fqqhkbm qjn stmnld slssgt kslxsfnv mgtl cmgvvr rl tzlx mfpgdr tlls zpkv ttpxk mptbpz ldl dbds kndg vsjpsl vpmfdct kqqmg qnbf mchrgcrj bs bkz flcd ncth ftxzklk cvptv tjlqrg bhhmjbk xhzkj vxgn cxsmk sfxd lsb qvcr zrt nkv sqmqz scjsx (contains dairy, peanuts, wheat)
mdhvtc tdkcd vlblq xtgghn cfvdq prgck nkv zcsmnq kvff rrzf cq rzsvmj hglq gnvmv mptbpz dcrnk pk nvq hlkb sqmqz xhzkj krlr prfjk tlrjcv cblbf kktl klrnc rpxdc cdmln ldl nccr glv lvfph mtnh kndg vfhkmn dkq ccqpr lzkc rsbxb rdtbcz hgflmgp vjrlml xjx dhlrh glf sdpssq bnqbh cxsvdm dmnxl stbldpp xbnmzr cknhk cmgvvr zthtx (contains sesame)
hglq nccr mzcpbs tlrjcv slssgt npkdtv ccqpr fdzjc vpmfdct vvptj dhjrmdl tjlqrg ldl ncth mzmpqh fqnzvb flcd fsxkvv glf ctmf rmbn bnqbh rsbxb pcjf dkq dhlrh txrtjzx cxsvdm rl lxvc ttpxk prhkvgbh kvff zrt ggvzz mptbpz klrnc bqgjz msfd rdtbcz fhrc gfkt qmnqtm tlls mchrgcrj kqqmg zbsmv hjjg dfgjq xbnmzr kndg kpq gn zbblpvfb mgtl sqmqz shc sptc zcsmnq ckzc ghjhv mzxmthz qnbf ftx glv qsvfj dqldvn mtnh rmxph xzfd rfdqzf txdmlzd gblh xtgghn ppf nvjql bvqlhhd kktl lsb cblbf tzlx vgpdr krlr (contains peanuts)
ncth kcvgs sptc cxsvdm fqnzvb mgdjxn ftxzklk ckzc kktl ccqpr tlrjcv txrtjzx kqqmg qnbf bqgjz vzcgt hrflzj kvff slssgt rsbxb mgtl mfpgdr cfvdq scjsx cvptv tshxt bnqbh cblbf glf jgjx xbnmzr vxdrhp xtgghn mzcpbs vjrlml dcrnk ksfgf fsxkvv fdzjc qvcr vbsz gnvmv txdmlzd rrvq npkdtv flcd frng rhmpqn gblh mptbpz vlblq tjlxs ldl (contains wheat, eggs)
tdkcd kktl cxsmk lrcxf rmxph tgdk vfhkmn dfgjq rzsvmj mptbpz flcd kffdz kcvgs bqgjz cvptv rrzf pllr klrnc kndg zffkzcp sdpssq rl pmznfk xbnmzr lxvc dsjtkv cknhk qnbf mtnh pcjf mtdzn sn tlrjcv kll qsvfj rsbxb krlr tdtg thbx vzcgt qjn tdv ktkbpp mzmpqh vgpdr vlblq ghjhv stbldpp bbfm dhjrmdl pblqsd rhmpqn fqnzvb fdzjc txdmlzd scjsx bhhmjbk gdpdm prgck ncknc bs chvtbb fhrc hghtp hjjg nvq cxsvdm ksfgf cjfdvf ncth (contains peanuts)
zpkv pmznfk qnbf shc dsjtkv zmsn fdzjc vlblq bs rhnd ttpxk mptbpz kndg mchrgcrj xhzkj txdmlzd cblbf nccr jssz xzfd flcd glv hghtp bbfm hdbmkt tdkcd kcvgs pblqsd vpmfdct gblh kktl mtnh pllr lzkc kvgctt hrflzj ldnvr ftx hlkb vbsz zbblpvfb dfgjq prgck qmnqtm nxtvs ggvzz ldl xbnmzr ftxzklk mfpgdr gnvmv stmnld zntx xjx glf vqtqp frng sdpssq vxdrhp kffdz hglq msfd vzcgt rsbxb cfvdq tzlx rzmtsz kqqmg gn rmbn (contains peanuts, sesame, soy)
bvqlhhd klrnc ggzb mptbpz dsjtkv qggdgf nxtvs zthtx hrflzj ldl ncth sptc prfjk txdmlzd scjsx zntx zcsmnq shc lsb txrtjzx tlrjcv bqgjz mtnh ldnvr xbnmzr chvtbb gnvmv sqmqz hgflmgp fdzjc zpkv bbfm kktl qvcr vjlpj ftxzklk xntsmjqf prhkvgbh rsbxb vqtqp zrt dmnxl ncknc cxsmk ctmf vlblq glv mdhvtc cxsvdm (contains fish, sesame, peanuts)
bhhmjbk zplxgb zmsn mzmpqh cq gblh fdzjc pblqsd mtnh dfgjq kffdz jzdzmg vfhkmn mchrgcrj npkdtv pvg tlrjcv rhmpqn cmgvvr pcjf cfvdq lsb kvgctt vxqg tgdk nccr nvq glf gstc nkv txdmlzd qvcr vzcgt txrtjzx ggzb nnzm sptc dsjtkv kslxsfnv zntx dhlrh jgjx vlblq prgck mptbpz thbx ghjhv gfkt lzkc jssz gdpdm rmbn rrvq fqnzvb xbnmzr pmznfk cblbf dbds stmnld mfpgdr kndg slssgt hglq rmxph bvqlhhd ncknc qmnqtm prhkvgbh cxsvdm xtgghn vqtqp rdtbcz pllr qsvfj kqqmg rpxdc hjbq (contains nuts, sesame, soy)
fhrc kktl fqqhkbm vjlpj zmsn qvcr zffkzcp qggdgf dbds rfdqzf sdpssq zcsmnq kll kvgctt zthtx cjfdvf cxsvdm ksfgf hghtp glf scjsx vfmsk fzrmkrdh bbfm kslxsfnv mtnh gstc rsbxb mptbpz rzmtsz hjbq qnbf vgpdr vzcgt dhjrmdl ggzb ldnvr vsjpsl txdmlzd vlblq ldl shc mzxmthz ncth kffdz mtdzn bnqbh pvg rdtbcz glv rrzf ghjhv gdpdm zbsmv bftd (contains peanuts, wheat)
xtgghn gnvmv mzxmthz vqtqp rsbxb slssgt zdkxzm rmxph prgck dcrnk txdmlzd kslxsfnv fzrmkrdh zrt vjrlml qtlnsrq dfdmj glf npkdtv lsb pllr tdtg bhhmjbk shc fhrc cblbf mptbpz bftd vbsz vlblq prfjk rkd nkv zffkzcp fpjgdr vxdrhp ldl mzmpqh rhmpqn hglq bs rhnd rl cfvdq xbnmzr jssz kll ncth mdhvtc zpcj tmt ncknc hjjg gstc pblqsd bqgjz mtnh flcd (contains peanuts, nuts)
gstc gdpdm rmbn sfxd mfpgdr tdv txdmlzd zntx ghjhv cdmln kcvgs pk xbnmzr nvq ncknc tdtg fpjgdr pmznfk stbldpp cknhk xtgghn tdkcd thbx jgjx hvrqsz zbblpvfb qsvfj gn frng glf sdpssq sqmqz rfdqzf txrtjzx rl ksfgf hjbq rsbxb dsjtkv tjlqrg kndg vlblq hglq ldl vxdrhp ggvzz cxsvdm ldnvr qggdgf vfmsk sdst ttpxk mtnh dqldvn (contains peanuts)
mzmpqh msfd qsvfj lxvc txdmlzd sfxd gstc cdmln bhhmjbk cxsmk xtgghn mtnh rfdqzf dbds ftxzklk zffkzcp mzxmthz vfmsk dmnxl zcsmnq mfpgdr rl mzcpbs rzsvmj bnqbh mgtl tdkcd dqldvn qmnqtm vsjpsl hvrqsz fhrc stmnld rmbn hlkb tzlx vjlpj glf cxsvdm txrtjzx mdhvtc fpjgdr nxtvs krlr bqgjz xbnmzr fsxkvv vvptj gn rzmtsz zmsn jssz pllr vlblq lrcxf nccr gfkt jgjx vgpdr qggdgf ccqpr sn kll zpcj dhlrh slssgt zbblpvfb tjlqrg mptbpz hgflmgp nnzm rhnd mtdzn flcd cknhk tlls nvjql pcjf jzdzmg (contains nuts, sesame, wheat)
cvptv ctmf glf tlrjcv ktkbpp zpcj vxdrhp cxsmk lsb ghjhv tzlx prfjk bftd rsbxb rpxdc dbds qtlnsrq dqldvn nvjql rhnd xbnmzr nnzm cxsvdm vbsz cfvdq cblbf txdmlzd dkq tdv mptbpz stmnld rrzf kcvgs qjn gfkt slssgt hlkb zpkv slmjgj prhkvgbh hgflmgp fhrc hvrqsz jssz vzcgt ftxzklk hjbq xntsmjqf tlls rmxph zcsmnq cmgvvr rhmpqn ldl dcrnk qggdgf mzmpqh sn vlblq thbx klrnc qnbf rzmtsz fdzjc bs ggzb gblh nvq mgtl pk jgjx dfgjq (contains wheat)
nxtvs sfxd sqmqz chvtbb ctmf cxsmk ccqpr zpkv frng xbnmzr rrvq rzsvmj fdzjc kcvgs gfkt zdkxzm ppf bhhmjbk scjsx qggdgf xntsmjqf vjrlml ftx nccr kktl zrt cjfdvf vlblq bvqlhhd bs lsb pllr fzrmkrdh mptbpz sdpssq thbx txdmlzd vxqg vjlpj rrzf kslxsfnv cxsvdm zmsn nkv ldnvr mtnh zbblpvfb dfgjq rl mzxmthz hdbmkt rhmpqn dsjtkv prhkvgbh tjlqrg dqldvn lxvc vxgn rsbxb gnvmv xzfd mml cknhk tmt mdhvtc jzdzmg tdkcd vfhkmn pcjf kqqmg vpmfdct (contains sesame, peanuts)
kcvgs ldnvr dhlrh fsxkvv tlls vjlpj gfkt gnvmv hgflmgp tgdk nnzm sdst vlblq dhjrmdl tdkcd sfxd cfvdq xzfd fqqhkbm ghjhv txdmlzd ggzb sptc mgdjxn zpcj cxsvdm rl rkd cjfdvf mtnh vxgn bbfm xbnmzr zntx ctmf dqldvn jssz cdmln cq rsbxb hghtp ppf sdpssq mchrgcrj lvfph fqnzvb hrflzj sn zbsmv nvjql zcsmnq mptbpz (contains peanuts, fish, wheat)
tjlqrg stbldpp tlls nvjql vqtqp lsb zntx bnqbh msfd kll klrnc ktkbpp npkdtv fqnzvb cxsvdm ftxzklk sdpssq thbx mtnh fqqhkbm dsjtkv dfgjq vvptj txdmlzd xntsmjqf bftd xjx dcrnk fpjgdr rdtbcz txrtjzx lxvc hrflzj zpkv krlr rsbxb xhzkj zdkxzm vlblq qsvfj mfpgdr zmsn ggzb kpq qtlnsrq rzsvmj hglq sqmqz gdpdm rkd gblh prfjk glf jgjx pk xbnmzr lvfph kndg dkq vxdrhp (contains peanuts)
zffkzcp vjrlml mfpgdr lvfph sqmqz sptc jgjx msfd hvrqsz lzkc rdtbcz cjfdvf sdst zpcj ghjhv bkz ncth sn ckzc tjlxs fsxkvv ncknc bvqlhhd hjjg kffdz mdhvtc vxdrhp ccqpr tdv glf dsjtkv hgflmgp rfdqzf ttpxk xbnmzr ktkbpp rsbxb vfhkmn stmnld ftxzklk vlblq dhjrmdl pblqsd gdpdm fqqhkbm ftx ksfgf nccr vzcgt mzmpqh nkv nnzm lxvc glv rkd txdmlzd hrflzj vjlpj xtgghn ldnvr qtlnsrq nxtvs zdkxzm dhlrh jssz cxsvdm jzdzmg ppf mzcpbs bftd dfdmj hglq cvptv dmnxl mptbpz zntx xntsmjqf (contains fish, nuts, sesame)
qnbf tdtg pblqsd tmt gblh ftx qtlnsrq bftd mgtl mzmpqh xbnmzr rpxdc sdst krlr mchrgcrj rsbxb vxdrhp bs ctmf sdpssq glv ggvzz mtnh ppf glf dfdmj dkq nvq dhlrh tlrjcv pmznfk dfgjq gstc mzxmthz zbsmv vxgn fqqhkbm rhmpqn hrflzj lrcxf vvptj vfmsk rhnd slmjgj gnvmv kslxsfnv flcd scjsx rrvq lzkc mfpgdr bhhmjbk pcjf zntx txdmlzd hjbq cjfdvf frng lsb qmnqtm mzcpbs ccqpr cxsvdm mptbpz rdtbcz rrzf nvjql vgpdr (contains wheat, dairy)
ttpxk dqldvn xtgghn stbldpp tzlx qggdgf qvcr pvg xbnmzr zbsmv zpkv kslxsfnv rmxph vjlpj gdpdm sfxd hghtp vxqg vlblq ktkbpp jgjx klrnc stmnld ftxzklk hvrqsz slssgt cq gnvmv glf kll vqtqp rfdqzf dcrnk zcsmnq bbfm ldl flcd gstc cxsvdm vsjpsl prgck mchrgcrj nvjql hdbmkt sptc mtdzn frng ldnvr nccr dkq fzrmkrdh vgpdr kktl cdmln rsbxb tshxt mtnh kcvgs mptbpz lzkc nnzm rrzf ftx (contains eggs, soy, sesame)
ccqpr tzlx zpcj mptbpz cjfdvf bkz zrt rdtbcz tmt cxsmk pvg fdzjc lxvc vlblq hvrqsz dhjrmdl msfd dcrnk ttpxk tdtg ftxzklk rsbxb mtnh cxsvdm vbsz fqnzvb xntsmjqf xjx shc dbds qnbf dkq txrtjzx zcsmnq prfjk glf sdpssq nnzm cmgvvr cblbf flcd lsb xhzkj cfvdq lzkc vjrlml rmbn frng gdpdm bs tlls ghjhv nvjql rrzf kktl txdmlzd hjjg zpkv zntx hgflmgp ggvzz dhlrh jzdzmg (contains fish, peanuts, soy)
kqqmg rfdqzf dfgjq cxsvdm glf sn mzcpbs ktkbpp vxqg mzmpqh ttpxk mzxmthz rsbxb tzlx zplxgb dcrnk zbsmv fdzjc dsjtkv sdpssq kvgctt xhzkj stmnld bnqbh bqgjz tdv stbldpp rhmpqn cq lxvc klrnc mtnh hjjg rkd vlblq gnvmv lsb cdmln dhjrmdl qtlnsrq vjrlml scjsx txdmlzd lzkc mfpgdr dkq tlrjcv xjx chvtbb ghjhv ppf cfvdq kcvgs xzfd kndg nnzm jzdzmg hdbmkt gdpdm kpq rzsvmj mgtl cjfdvf qmnqtm gstc dqldvn qsvfj vfhkmn rrzf zthtx cxsmk mtdzn xbnmzr qjn rmbn hvrqsz bhhmjbk dhlrh ldl flcd vjlpj fsxkvv (contains nuts, fish)
tlrjcv cxsvdm nccr vsjpsl vfhkmn vlblq xbnmzr prgck frng bhhmjbk zplxgb thbx jssz tdtg lrcxf pvg cjfdvf dmnxl vvptj stbldpp mtnh txrtjzx xzfd zpcj cmgvvr flcd bs qsvfj ggzb gdpdm zdkxzm rpxdc rhmpqn sdst rhnd ftxzklk nnzm fdzjc kndg vjrlml qmnqtm ldl cq cfvdq ttpxk tgdk xhzkj bnqbh fpjgdr lzkc vjlpj ggvzz glf prhkvgbh txdmlzd vxqg mfpgdr mzmpqh tjlqrg kqqmg cxsmk gfkt kvgctt kll mptbpz fqqhkbm xntsmjqf cvptv ftx zbblpvfb xjx qggdgf bqgjz chvtbb (contains soy, dairy, sesame)
cxsvdm zplxgb mtnh vfmsk ckzc hdbmkt tshxt dmnxl zpcj mtdzn nkv glv vzcgt txdmlzd vxdrhp rsbxb krlr zbblpvfb tdtg ccqpr lvfph nccr sdpssq qtlnsrq prhkvgbh klrnc rhnd mdhvtc bkz vgpdr dsjtkv tlrjcv cfvdq pmznfk dkq vlblq tzlx glf rl rzmtsz ttpxk kvgctt chvtbb nnzm scjsx mptbpz tdkcd xjx jzdzmg zffkzcp npkdtv cdmln tdv bs nvq prgck sptc gn ftx (contains soy)
ccqpr slssgt gfkt rzmtsz xtgghn prfjk cxsmk xbnmzr ghjhv gnvmv dsjtkv jgjx pllr bvqlhhd hlkb pcjf vfhkmn cq vsjpsl mtnh nvjql stbldpp mml mchrgcrj pvg dfgjq sdpssq shc fqqhkbm tdkcd sqmqz ldl mptbpz scjsx mfpgdr lzkc vlblq hdbmkt glf slmjgj thbx ksfgf dmnxl gn cjfdvf dbds tjlxs mtdzn xhzkj tdtg nxtvs zmsn ggzb xntsmjqf tgdk kslxsfnv zthtx vxgn zbblpvfb tjlqrg xzfd dkq cxsvdm rsbxb bkz vqtqp mzcpbs (contains eggs, soy, dairy)
"""
