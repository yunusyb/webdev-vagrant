class squishy_v1::users {

  group { "sudo":
    ensure => present,
    gid    => 501,
  }

  group { "dev":
    ensure => present,
    gid    => 502,
  }

#  add_user { gchaix:
#    name	  => "Greg Lund-Chaix",
#    uid		  => 5001,
#    email	  => "glundchaix@gmail.com",
#	shell     => "/bin/bash",
#  }
#
#  add_ssh_key { gchaix:
#    key		=>	"AAAABue1Es5quee5mee0ooGh1xooveeT6ukizai9iepov7akuunuuPhuTahgae1xiech5Ceebooloo2Ea1Ohfah0koo2piohaite0eureeT9eo0IeXookiemohjahCeiduke6ahchohn0je5QuioreiHae7chahXo5xohtei6veaba7oshenoh4Gu1sheek6diekeixegei0dei5chail3feiquoot9aingei6gie7epaerahGei6roF9ooshah4eL2ailaesheezae0xah7Iesh7BaiGh6paiy9oruCaiHaegoanoo5erueyu8Ua2tae0leefeiphahxongauShoos5thieguwei9WieNaxeixogheebeushu4ien7ahhoomeese6thais5yai9eghuk1bee9Quiet1quei7oodeiy2iiy5Shai0engae9veequoongeirighooGhaojoh4eevahmeecu2oqu5AteeXei1vohMo3ahgi8wohshegiefeeb4d=",
#    type	=>	"ssh-rsa",
#  }
}
