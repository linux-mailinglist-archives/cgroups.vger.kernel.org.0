Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CADB22941D
	for <lists+cgroups@lfdr.de>; Wed, 22 Jul 2020 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGVIzf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jul 2020 04:55:35 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGVIze (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jul 2020 04:55:34 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MuDoR-1kpZTK3Be9-00uVwW; Wed, 22 Jul 2020 10:55:31 +0200
Received: by mail-qv1-f49.google.com with SMTP id e3so675423qvo.10;
        Wed, 22 Jul 2020 01:55:31 -0700 (PDT)
X-Gm-Message-State: AOAM530Kvn8KM2lnGCSzM7NnNGghfg6aDrbjyfs8BGyLvptUbHIGQGe8
        /QEImm2NsQxKJsSfXC0Bmm5i4gXXIzzvGYu/vN0=
X-Google-Smtp-Source: ABdhPJz2CG97fM8LdsudY8wGM5BPLCychAwsj3wuHCiRR3jjOOOqtO5R0Nb6oNtKoi0uAlHHaYCrqBDaqZZMZF06Gbo=
X-Received: by 2002:ad4:4c09:: with SMTP id bz9mr28822296qvb.210.1595408130368;
 Wed, 22 Jul 2020 01:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuj3bHUMz8XQztbmTgF0c5+rZ5-FkUjFyvEftej2jLT+Q@mail.gmail.com>
In-Reply-To: <CA+G9fYuj3bHUMz8XQztbmTgF0c5+rZ5-FkUjFyvEftej2jLT+Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Jul 2020 10:55:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3br1bDc8C6UjRWzdmwzVV26YYe3ixHV7LH5Z0-OiqPQQ@mail.gmail.com>
Message-ID: <CAK8P3a3br1bDc8C6UjRWzdmwzVV26YYe3ixHV7LH5Z0-OiqPQQ@mail.gmail.com>
Subject: Re: BUG at mm/vmalloc.c:3089! - invalid opcode: 0000 [#1] SMP KASAN PTI
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>,
        Cgroups <cgroups@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:crnOLwS+41d8HyGZU9Rdycw07Z/sTpkPO77WcPg7qhCzPAY4BFA
 JLmzroaKFY17VPr1EqhrRwTLHCO+1BzUYA5h1wDfbdMHy1BwqS8qI4ylmwp2F8rc//lfl+q
 VIkOfNRYuAJtyVysOhDeDuZlWo12j591zT14ATo7wHJN2zQeeouRV2GLW+fs8Nzf645SFYr
 Ciizc5G/6iNvpSBKBkYHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KShUyS/OgMY=:66bM5qt8wZIMCWq7VF5TDA
 9abv+b7UqeAhSFgSc/1x2d8p+1LMkingX+Xpk4VNv6Kn3PCo6IPbRreYlkGsfT2CHGL7L/UGb
 0Q2hOqQdEUJlM7QPbkc3OCx/7rGnxGzvbEy7lYQsjfhJLRo9ImMJ+1y7t4bQVaJ9FA1i9Dp8I
 tQjAdeQB+yGQ4Dhwngi1lU+wgcuvBL4I0chX9esv9uvvAFBQNQhv0jIeYlxwA4Y8LjvFqaLeC
 wGlki2mOBQ/uGRhw+XVzeF2OnZCz0vXglr9eNqvPd3LGNrt6JrOn1HooMJEk3qA6wa7pNU8Gg
 5/3joHitVOMKThWRewNYZwGv3xFWoijJL2jeu7YmpfH+RLG028jafJf0R4/nKPMUFIGVADm3E
 +pPpeuzUgdc7LL1qeldnwTVwrcbwMk3msEjoodSrwpTOXjKXvGQJQBFtNdg3JxdEY4jQTRHaU
 PPbD+cveRkD9VqfYh++1RLtq3VUJdOzGJ/czVEfH9HJw44fIK1gNWbECwRRNoFIURonWpNspv
 EpSMmvbG0WScA7lIyMsfFmnLWIFS56cSboB2JIBGicDzNUkZx+8cINLQeNUyJI1eyFoppoNC1
 Fm+KBMjmzQsxsckfyITbfPJbF01st15Y+Hl+bR5QlsO3XTp/uXYBS7nt9w/J+OM1DMJE28AFe
 DCP1JgpPpppjV+nI6lZkV/STYLgkIP03a0CSVDjzsFnj1/Kpmag4kVmwWP2PjflvM4zvbMl2/
 Agpx5LlZmHy4Iw+ZRdzvjqiJzP8V00s0/LXY4Wpce4wZjwOusOQlflS5gxSBNjBu4fMIqnU2j
 KCSl47ZFiFQUVx9ktlM4Ik91coBAc3bOPDx3TutZTTB6Zi8JrmNNWnNXwaRK0AH4e7ulkjIuX
 RGiUrawqrMrI+AZTrZ6vlxDK+0Unhbb84a72k2RSBuZZ2MWS/b2n/RwgyL9F53fX1llLsMSfo
 ZLCdGlxQeb0bk8ss3EfgNqGyf1kycJjs9hnuj8m5dVf19lWqJd0KH
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Adding Roman Gushchin to Cc, he touched that code recently.

Naresh, if nobody has any immediate ideas, you could double-check by
reverting these commits:

e0b8d00b7561 mm: memcg/percpu: per-memcg percpu memory statistics
99411af13595 mm/percpu: fix 'defined but not used' warning
9398ce6306b6 mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix-fix
54116d471779 mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix
ec518e090843 mm: memcg/percpu: account percpu memory to memory cgroups
9bc897d18dc3 percpu: return number of released bytes from pcpu_free_area()

       Arnd

On Wed, Jul 22, 2020 at 10:12 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Kernel BUG at mm/vmalloc.c:3089! on x86_64 Kasan configured kernel reported
> this while testing LTP cgroup_fj_stress_memory_4_4_none test cases.
>
> Also found on arm64 and i386 devices and qemu.
>
> metadata:
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git commit: de2e69cfe54a8f2ed4b75f09d3110c514f45d38e
>   git describe: next-20200721
>   make_kernelversion: 5.8.0-rc6
>   kernel-config:
> https://builds.tuxbuild.com/zU-I3LEfC1AaKQ59Er60ZQ/kernel.config
>
> crash log,
> [ 1421.080221] ------------[ cut here ]------------
> [ 1421.084874] kernel BUG at mm/vmalloc.c:3089!
> [ 1421.090356] invalid opcode: 0000 [#1] SMP KASAN PTI
> [ 1421.096009] CPU: 1 PID: 19100 Comm: kworker/1:1 Not tainted
> 5.8.0-rc6-next-20200721 #1
> [ 1421.103933] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [ 1421.111418] Workqueue: events pcpu_balance_workfn
> [ 1421.116138] RIP: 0010:free_vm_area+0x2d/0x30
> [ 1421.120413] Code: e5 41 54 49 89 fc 48 83 c7 08 e8 9e 5e 04 00 49
> 8b 7c 24 08 e8 74 f8 ff ff 49 39 c4 75 0c 4c 89 e7 e8 97 d2 03 00 41
> 5c 5d c3 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 49
> 89 fe
> [ 1421.139154] RSP: 0018:ffff88840142fc80 EFLAGS: 00010282
> [ 1421.144381] RAX: 0000000000000000 RBX: ffff88841b843738 RCX: ffffffff86ca1d78
> [ 1421.151515] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8883bfacd630
> [ 1421.158647] RBP: ffff88840142fc88 R08: 0000000000000001 R09: ffffed1080285f7e
> [ 1421.165780] R10: 0000000000000003 R11: ffffed1080285f7d R12: ffff888409e89880
> [ 1421.172913] R13: ffff88841b843730 R14: 0000000000000080 R15: 0000000000000080
> [ 1421.180045] FS:  0000000000000000(0000) GS:ffff88841fa80000(0000)
> knlGS:0000000000000000
> [ 1421.188132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1421.193876] CR2: 00007f1230b41080 CR3: 000000025d40e002 CR4: 00000000003706e0
> [ 1421.201008] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1421.208132] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1421.215255] Call Trace:
> [ 1421.217703]  pcpu_free_vm_areas+0x30/0x44
> [ 1421.221714]  pcpu_balance_workfn+0x7bd/0x8f0
> [ 1421.225987]  ? pcpu_create_chunk+0x2f0/0x2f0
> [ 1421.230261]  ? read_word_at_a_time+0x12/0x20
> [ 1421.234531]  ? strscpy+0xc1/0x190
> [ 1421.237842]  process_one_work+0x474/0x7b0
> [ 1421.241856]  worker_thread+0x7b/0x6a0
> [ 1421.245521]  ? wake_up_process+0x10/0x20
> [ 1421.249448]  ? process_one_work+0x7b0/0x7b0
> [ 1421.253635]  kthread+0x1aa/0x200
> [ 1421.256867]  ? kthread_create_on_node+0xd0/0xd0
> [ 1421.261400]  ret_from_fork+0x22/0x30
> [ 1421.264978] Modules linked in: x86_pkg_temp_thermal
> [ 1421.269869] ---[ end trace 6352cf97284f07da ]---
> [ 1421.274955] RIP: 0010:free_vm_area+0x2d/0x30
> [ 1421.281026] Code: e5 41 54 49 89 fc 48 83 c7 08 e8 9e 5e 04 00 49
> 8b 7c 24 08 e8 74 f8 ff ff 49 39 c4 75 0c 4c 89 e7 e8 97 d2 03 00 41
> 5c 5d c3 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 49
> 89 fe
> [ 1421.300553] RSP: 0018:ffff88840142fc80 EFLAGS: 00010282
> [ 1421.307051] RAX: 0000000000000000 RBX: ffff88841b843738 RCX: ffffffff86ca1d78
> [ 1421.314184] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8883bfacd630
> [ 1421.321317] RBP: ffff88840142fc88 R08: 0000000000000001 R09: ffffed1080285f7e
> [ 1421.328477] R10: 0000000000000003 R11: ffffed1080285f7d R12: ffff888409e89880
> [ 1421.335639] R13: ffff88841b843730 R14: 0000000000000080 R15: 0000000000000080
> [ 1421.342777] FS:  0000000000000000(0000) GS:ffff88841fa80000(0000)
> knlGS:0000000000000000
> [ 1421.350870] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1421.356643] CR2: 00007f1230b41080 CR3: 000000025d40e002 CR4: 00000000003706e0
> [ 1421.363811] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1421.370951] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
> Full test log,
> https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200721/testrun/2972982/suite/linux-log-parser/test/check-kernel-bug-1594684/log
>
> --
> Linaro LKFT
> https://lkft.linaro.org
