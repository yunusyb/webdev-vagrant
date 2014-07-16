class squishy_v1::users {

  group { "sudo":
    ensure => present,
    gid    => 501,
  }

  group { "squishydev":
    ensure => present,
    gid    => 502,
  }

  add_user { gchaix:
    name	  => "Greg Lund-Chaix",
    uid		  => 5001,
    email	  => "gchaix@squishymedia.com",
	shell     => "/bin/bash",
  }

  add_ssh_key { gchaix:
    key		=>	"AAAAB3NzaC1yc2EAAAABIwAAAgEAr3Aua8vK7ol4iLR+VMIpKSP1wVSZIA5oJ8RXP4nOhYB7uA/GRBcz/4kmRAmWiWLh4q8Fy6aOolEOaonSM1NYZd0z9olZYoVA7DZTZPsoVevGwZqnpvdih92Uyh9qSlVsYxYdozocPSeGLQbOlKWq5vYW+y9ovChNTGCPgVi7X17Lz873z1daMGrL3w0gvNostKTl+N3EksxRj3RYm6zvkx5sBas2uddXniBjU5MjQv1vhqnVl621ePYjuV/lVeV53kZRFpKzxe8yM+jr/EsFNKdfa2OiREVi3Ywsr27Ah3HJc9CJkNMs6lkDJZOvWy8QtUkqyxs48wahBnpbLVrvnjDMVMm6ahqeL5Ugp/UX1IssIOF2A26Z6vFOduVhJWm4k2NBD78aXe1m+2HjzwEFHvW+uVDF3aONkfy9oJAl4lEQZmBQoKbnXh4fmbTo7hNC3VDKDWtyGL3rOcvoSA8lkhQr7Z729yN+zMu28FuKEogmbgWT+mSaf/Czx8MB9T6vXpY2+jZ/Ds/eiTO66+jPFVmEObRdfQwPV6ifEHtiWiwr14O01bXH4hLibrc6qhrH7OTMJ4ALqfZDsWGZxijey94lqbdzlGNIku4nnMsiZ52p6/SzP5UTE9Mfjagmd8YVhTuELmNTY6IJbqyTdHBXrW/K7cv+Npr/PXYdJ6zorPs=",
    type	=>	"ssh-rsa",
  }

  add_user { ben:
      name    =>  "ben",
      uid     =>  5002,
      email   =>  "ben@squishymedia.com",
      shell   =>  "/sbin/nologin",
  }

  #add_ssh_key { ben:
  #  key		=>  "AAAAB3NzaC1yc2EAAAADAQABAAABAQCmczFbgi1hBu111bpgdpRZB3ceWD2Js2qBvFL0YqchoSvym3986hbRN5tgL+40G2Ctpj0HZBXD5pblwWSQflCnnDjIq4NcuCa0JFdSm2/ej1ibgTIl8TgvsyYCKSzo+/pZr62R54VA0sIeRxImix5Qq1gdexayEZpA8yiyWM5aT4mplaXoOJ3Z6muU8yWPURiI0qVEQmOelD/5qK8riuoZHnQ0ehxtg+gV3tppNB8gADlu7jf7vOBi1L+4DbRuY++PLzKaKBEQMBj/LCFsxL+iHjXpmA7a1aZE9G6Do/hZlQAxnI/Jv8Dly370B44rdgBcQkbEZxzVjzESzTzB6qTP",
  #  type	  =>	"ssh-rsa",
  #}

  add_user { elizabeth:
      name    =>  "Elizabeth Miller",
      uid     =>  5003,
      email   =>  "elizabeth@squishymedia.com",
  }

  add_ssh_key { elizabeth:
    key		 =>	"AAAAB3NzaC1yc2EAAAADAQABAAABAQCkgcdDJlj0IPZEg/CW8c+5SXeDDrTL2A9im75mzZm8SxJqbCONirWnDN+JL8o+ucxk7kKECUM78s3NZZPXMLsAoUGC8mS5aZZ7RkFlfiaWVXBrnVtdp+fxHphrv4eE311mFbmqcnxFopYhMTcfJFyxs2yyGxU8r8QrNAor1c02ZBbiwrh/wA4stlP/IgTIzRivzgrqdk1wZMaff0IlEdIAEn7G7FecRVz7n+XZMnCQy4A+BVrGBmXtSWZ7FCfL11g7iHkb/adjO+eszjbdbTFAbh0jMBvCCha4HrYY6OxajNJnga4t87NJeTTdFyH4ujmzZJcyRHjAP8jwR7M32u/L",
    type	 =>	"ssh-rsa",
  }

  add_user { evan:
      name    =>  "Evan Heidtmann",
      uid     =>  5004,
      email   =>  "evan@squishymedia.com",
  }

  add_ssh_key	{ evan:
    key		 =>	"AAAAB3NzaC1yc2EAAAADAQABAAABAQDgo327O3puhruLmSp7def/KGPa3nH4RaurHjEXWt3dzBkfvah7hBpc0a5ys/M3YrWvQDMzRf5/k0CsUzSEACK0NNvXSxl1PdGXyW76aKnvFw/6dVvYQDQsq81tuZrO5+H1Mgr8uHY1EFICfpa0JOXysoR9tg0hhB1B7fduiHJd0MhpK2dTCiZWaZ3z/P2cU7yG/K2TVDODaoqbT9Tz9wS/TsXRw6uzsvYe9IQBTtAZru0atIHROt6OfX3sCzTMvdfADwiW8RXkcH8bp91atUxOj+bKqvo/D3leXzg9/NoHEUQoxIKFs9BnxCLcFLEXecR8fScw8f8la+7cwnnqbihn",
    type	 => "ssh-rsa",
  }

  add_user { greg:
      name    =>  "Greg Noack",
      uid     =>  5005,
      email   =>  "greg@squishymedia.com",
  }

  add_ssh_key { greg:
    key		 =>	"AAAAB3NzaC1yc2EAAAADAQABAAABAQC2b6wpUJ63GkLVqaQM0IXpfEND9NnxGfwVTizoTnE/lgS/NBuUH1m9TdNZZgtucxlicfxU6eNcDQeB/9P/wUnelEQnAbjnTtGOZtEOT2XZMgZsf3AtfyWTlBm8JitKc9NpYimRrCbIod/KdX4gXpTbbY87IHGhBJjZ1hEn/TXfr7ANn4bFhMza/j6CLHmkcyVyCHygpQLbPYIrcnPNk8MEAnnIwum0Hgqr4K6fUt6hhvh8VL+HuWvtTs0v2kKaDboD8lyKy4KlWPzADT3Yve+0CDmptQNp9bRUcXR77+F9e2JQRQV5nKAmpW7yr4Rkfz2YRpyNHa3RvwYJOkYwflJR",
    type	 =>	"ssh-rsa",
  }

  add_user { jesse:
      name    =>  "Jesse Firestone",
      uid     =>  5006,
      email   =>  "jesse@squishymedia.com",
  }

  add_ssh_key { jesse:
    key		 =>	"AAAAB3NzaC1yc2EAAAABIwAAAQEA7t9b5YV8hDZMDixZAHW8wqLN3qeyfPW0f3F4F8QDOafscLhXzlGpxI03U0aPcav3o1T9moPWLqy9KW8SD7TUUU7WA/e27duU8n4BS5FJU6CJw2b4AMyWzmvTlHuPKLz72zGYmYjKJ2ejG+f3fdf5VrxF8/LwgAoSlfyDJ01vxi+9X2Sqs9mIbhAMCDowVkEvd69SjX6DdR9SeNAAlbcnfPqSeHylKrBM7OEBAMgnzUPAo8Urqf4xCTMExgh3epvuUZ3bvR7LnvWTq7/OAkKIBRShxNDhxkhUg/1aQ7G3uTXbKLFzkiZ2gK/DgKIW/2giuItekGx2ICz7dvHJJ6Gzkw==",
    type	 => "ssh-rsa",
  }

  add_user { xn:
      name    =>  "Christian Seppa",
      uid     =>  5007,
      email   =>  "christian@squishymedia.com",
      shell   =>  "/sbin/nologin",
  }

  #add_ssh_key { xn:
  #    key      => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDVJzN27CL5aW6Yl6YvGYx7qMBt23EGPVdRCYP2WZwpewWIABjMnGz6rJCyOt5BGem8oQJheGj2LDFMN5v96E0Wr1ivom4Cdp/BlPy46+KOvfLakV5qatBfYhBrDFBR/8+OusEiK3pDCBe0X/dcaLJVUX+E3+i9iQXPpnTre2PBG1AHtxLBCjuHWxTLnZjPGoiJQP7TUa8/B0ofNu2VGuQqFQV1p0yMNrZMAwdhtCH3I9TMfb6R7iEAymZAEZrlY3goNTXQB3HoHgnD9FInf/oB6L9Q8HSZlKkCx7CjKkcd/I6NNj/lekqlt27/vuNyHeDgD8grGjJldUXVXViurvD/",
  #    type     => "ssh-rsa",
  #}

  add_user { olivier:
      name    =>  "Olivier Bouwman",
      uid     =>  5008,
      email   =>  "olivier.bouwman@gmail.com",
  }

  add_ssh_key { olivier:
      key      => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC2qlPdtCw1BSl52VieT3sbicrq7IqfD2oEri/W+/rP40ZbVEp9dwzK/4Y/RQ8FSrLnDIbdHBmC09ZDVWxyyzJRuGv307f1lR4N8fImznQfWQ/KLJoJYlLoombRXKBYkZDfczeIru2WlIW8A2H0TvlZhpAJO7yvMt/YknvVdCl7nXJcA2kVycOA20TB2ZvdO3GCzYb4UAU2faBC/Chsi6uncgkd27/TXWkEEg1cqLxvIDePpTm/V/ZNEgkZV4W2myuqYInfAg1tCUglXaj0C0/7fpb0X7S2UkV3ZrcKlldyTzWw8cL7teMW6gnEcMU6HHu7OuiWFKA8khgmDIM/G1Az",
      type     => "ssh-rsa",
  }

  add_user { amanda:
      name    =>  "Amanda Erickson",
      uid     =>  5009,
      email   =>  "amanda@squishymedia.com",
  }

  add_ssh_key { amanda:
      key      => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDJBMUeM/ndT52ryM5WNBYFS7ZX2UFt8o4kzL2wjApeyJaOd3kyQkyWsIMX4MTiXdHvzVtDW6iRKHtPLSTSTVz76RujOypaW+sEHCanXw1Jdn7eOSzxsvf14jRdrggxZiLXTMtXD2jRQe6vtJ5Uk4hC4/Xqi6R3HA3UJQv11JswvXBS7S9BG5iuEg3PiN6KQNSLdGbzRZJU7nFXDj7z1MUhzesSTDiyEWQb+HLGC5JSKhGGkWMZza+Q/7krl5BLgFQtp3rF8mTUxmVb0dV7tGsqk0q3fLmyzWohu3//lhzulKPomyXK8fO1jqaaiqN7/Rq4vk9CYTD/jIquShj7NLOX",
      type     => "ssh-rsa",
  }

  add_user { dirvish:
      name    =>  "Dirvish Backup User",
      uid     =>  5999,
      email   =>  "systems@squishymedia.com",
  }

  add_ssh_key { dirvish:
      key      => "AAAAB3NzaC1yc2EAAAABIwAAAQEA1ENXxN6q+ZxF22YSPAyeStO0WEgenzWgPsJ5cVZQCtSXCrdX5ZxtNBTdo1uIm853a93WbEOXiezZ9q86qd4k16W9iuWbrQvZjz3J0gKQNjYf+yMbJpIbAxs2DlJYMErar45ggS+NkUfeE64syQN4p55yEo4CLHU35JRvU+OWSy6l0fPoO4BuyA9/1PFtJP46pbSDM6QnnH267BTgvZDfAF1AGbaCNdlQNqUWT8XqGq6G1F8y3fs8AMRXiCr1R1mbZI0QXVQZGMZ3WPSkb0GPoNqYF2rG99D89fb/n+x9nlncXTfd7q3ePW1Ev4QyNFWFMPa6IM7BJIDWyjoAWIjbLQ==",
      type     => "ssh-rsa",
  }
  add_user { lisa:
      name    =>  "Lisa Jansen",
      uid     =>  5010,
      email   =>  "lisaannjansen@gmail.com",
  }

  add_ssh_key { lisa:
      key      => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCzUZnqfWiMiYjGFwndf/wKW5m9kJ5uB0PpO1m+WXmYT8ROcZATgc2J8suksLo6IqXiFKd55nKP4UhpP5gQ6roOxPtDW+tZy0Ud+AvcgrxNOHVFvqjU7JSQJgMoxCGf92FS7fqlNTkfHxOxuZtYt1NnX9v0V4i7BvKVBddEeJlXqc+aOfnvjkl/Ssmc9QzfqcP5OUD17LPahrfED5xNWK+WPLLw6NjhUztWQ7j3a4X/aazwUg2dcglvTQa5xhORM+g5utBa5/e9Cn+6eQRduJA9Mgu3F5gGCVJjZF5uqUP3v2Zt+y1OY386Daak/E1smNTSH3+POBSFifsE8ftqnSJ7",
      type     => "ssh-rsa",
  }

  add_user { shellyking:
      name    =>  "shelly furio",
      uid     =>  5011,
      email   =>  "shellyfurio@gmail.com",
  }

  add_ssh_key { shellyking:
      key      => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDBif4MW23/G2aN5G8u3reaZLRiNEr5IHG5Li/syCp5b733JGXqzwygyyS/uqMo/gfNI1FeJCOmOFz/mA69o+uMu3dZOHkPsEYWjDm7pD2FDL4b+YbhV6U2t1f93uFuTxMlfwaVKdqmGgUrToNlKS+eCK42BfhpMvmA4xuFkIAsVaDXxLnMQ0ESDGiFZ/LUYQev0JThZpCgL26MmGJt4d9xMRYU+FvUtW8WV+jRdLn7DKfWnL5ZcQmBvJRpn/dEuwr/+0NYGC64SGPD/a7Rp/M/ha6VS0OXxdLIXERAIGdvBfGULiSa3z9zw5PNqH73KVwdf06wVof/DWqtiO1z2Dy1",
      type     => "ssh-rsa",
  }

    add_user { gitlab_ci_runner:
        name    =>  "gitlab_ci_runner",
        uid     =>  5012,
        email   =>  "systems@squishymedia.com",
    }

    add_ssh_key { gitlab_ci_runner:
        key      => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC0urQ2CI+9cQjjFVv5KWHGTmFY6cSW0bF5yIrFVYIjuupABTDAJeBHj6oBiLNURz607/Kc6bUC7cV/ZCve2rEpCZhA2QOF2qGpxxllwIYtb6kZ+VYlJp1++1CjInnDqROSo4DijKgdAQgCCsqLxfHJrBhS/orCFLOEOvtZZxRB+2kDsTxTt9dkmo3A3kKnizyDmMf91+RNogIieTR90vjsrLT0yUzhyCep6eHtRFIe+Srb6bgCcg8ZIzPueIx7YoGqQP3ZGOnNwAP8FiU6yFH0f5SO6jWhtTUG0v0PIOm4mR+tOkS3ymeaHUJapbzpbsWg3yJLlW+F3BuZNY1mai+x",
        type     => "ssh-rsa",
    }

      add_user { bryon:
          name    =>  "Bryon Burleigh",
          uid     =>  5013,
          email   =>  "bryon@squishymedia.com",
      }

      add_ssh_key { bryon:
          key      => "AAAAB3NzaC1yc2EAAAADAQABAAACAQClxGO4A8S5OijS/7/rAdDrLbw7SJ7rwu53nIhvvUjkSy0rJ8XPFTHQ2Ijov0bzUkg3l1ZfygjGHwvV0V4SHI8u+mmf4HmNlgHmDKvh3eab5KY0GcfY9o4W9Dhnao3PAfA0GMrX1aYIdX4XU+o5gNTVzktgGWkEfDsRBo4VJ4dXlAEFRPtVrRA9CWLA07ea+M42DoqwXYoEpY0Nd0lDC7Tl8sQMKAxnfTMFvJPulBTr+73ymCE/B4MmwGRJHUU0iRrGJFQHmLfB36+bcbJXvmTfHTI4xLKe4cHCdn4KpqcXL754VVRxIAcghyHRugmirT6SKh4bmiCYeCYdhb2jjtIS4fELXkCaRtQ/8KaJAPX0oyH0U2YenTfbD749BxQwJ5iLnc4+yfV1NmDMakk4xDNAI2juW5ZiEBghX59pkyUxTJb1CLzXJpDr+aJZTrIFew1tdzM3xs89Qss+iIAd7vy4NT+8k9rPMY6pRsY5x42YzQemDZ3zWkZwMIo8qnZI0qRzbnvYae53XCBGKMIhZgC4LWir99XIi3rqKf+RTUs4lk8QVsiK/WoGkIiR9BONe2cRE3LYzOwo5p0DYMwI6HWKTji05aDvee5OkAL0Bq9k1aLkHI26mQ124yrTItNs1lBV28nx3ekxGJpYXHoPHxanh4Snd3BO9tmG/i5rKE96AQ==",
          type     => "ssh-rsa",
      }
}
