Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5126F0348
	for <lists+cgroups@lfdr.de>; Thu, 27 Apr 2023 11:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243265AbjD0JWW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Apr 2023 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbjD0JWV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Apr 2023 05:22:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11572119
        for <cgroups@vger.kernel.org>; Thu, 27 Apr 2023 02:22:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so4770989a12.1
        for <cgroups@vger.kernel.org>; Thu, 27 Apr 2023 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682587327; x=1685179327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEYtiCxAFTT9nXuyjd6W9FGtnnEdizlurXntdkjLbWw=;
        b=DjlOfwcGalpmFwZRlwKkvYAn8STIQN+MKG4F65GC4r7jVv1sLRLlBH3Wcxen9DqUeN
         0bm6Gj7fDcuXsqj4nk5i662ifcqhyZEZYZH21y+uUc9rNB3V5EQEPJ0Ac8Sxt22MJstO
         7nwaf8iTBOVAnavohH1/kWyE76bbKgVXU2yrnc4OQGBmJw42GNzTot1mAiGOqFKbrfDJ
         Nf2GhDxWo836YKH6ifbrTfRhoscfANxgxxCyiOL6eAdqfFrf8OVPxld7nXem9N82ZJNO
         VGbizhpTMriKxG5mAYlx5TjLuE8/TjK6tn0hx3iC0JAnKmwgG7BFg734fn5nuVsAqFJE
         Ygew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682587327; x=1685179327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEYtiCxAFTT9nXuyjd6W9FGtnnEdizlurXntdkjLbWw=;
        b=E4CQm7UjGGxb6gloJ+SsUdC9m9T3hpHvQQY/1yf7Hdud8REVBeg5kzwnLcihOBHr6N
         gXinlll1qZIvL+ep38XoCBGA/5GBc+QbtbogjB+DbaDvUnIOj8iUmF7Vd3A+qG6Etk0r
         Iz0BOpRApC5zxp+2gM10Vn0wwCisk30lASR4d5Ykzg5Fw/3fpREkQKGZG+0n2s6mosej
         LvTrMFQrPaY2MeN+ZCEbGNptkiIO6JqnjhEq1NDD7UUDjCFZxi1S+DqLrYx/64HfUojQ
         lkB3zIv8Cru9U0V1s0TT9H1faPanFZVyfABz9yxouK4KlPNJ1Bbpj6r1jvVJiAZvng1E
         bkXg==
X-Gm-Message-State: AC+VfDx2/6cTRdV4FQoLAW5C1Q2dopc5jnnuEDW/WFhqnKRHbsdF++ar
        RfrHnp4G+oGOs4sizGsATBeAxXI3brbLv0izUyn6IA==
X-Google-Smtp-Source: ACHHUZ6Wh6BlH1ULxXd9iM0lMPTwmt36G5WzavnnZJLbSCA2zK7uzCMIdtusMtFTayJZMi7PrZ7HhYe2KoJozkEu5Wk=
X-Received: by 2002:a05:6402:5114:b0:506:bd27:a2f0 with SMTP id
 m20-20020a056402511400b00506bd27a2f0mr4578982edd.15.1682587326986; Thu, 27
 Apr 2023 02:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-3-yosryahmed@google.com> <ZElC127xlU2NtlqF@dhcp22.suse.cz>
In-Reply-To: <ZElC127xlU2NtlqF@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 27 Apr 2023 02:21:30 -0700
Message-ID: <CAJD7tkZ1cODXRuVQ3fWL0s=VsyKZqDPPNqFZec_COAXm0XfXWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: dump memory.stat during cgroup OOM for v1
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 26, 2023 at 8:27=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 26-04-23 13:39:19, Yosry Ahmed wrote:
> > Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> > OOM") made sure we dump all the stats in memory.stat during a cgroup
> > OOM, but it also introduced a slight behavioral change. The code used t=
o
> > print the non-hierarchical v1 cgroup stats for the entire cgroup
> > subtree, not it only prints the v2 cgroup stats for the cgroup under
> > OOM.
> >
> > Although v2 stats are a superset of v1 stats, some of them have
> > different naming. We also lost the non-hierarchical stats for the cgrou=
p
> > under OOM in v1.
>
> Why is that a problem worth solving? It would be also nice to add an
> example of the oom report before and after the patch.
> --
> Michal Hocko
> SUSE Labs

Thanks for taking a look!

The problem is that when upgrading to a kernel that contains
c8713d0b2312 on cgroup v1, the OOM logs suddenly change. The stats
names become different, a couple of stats are gone, and the
non-hierarchical stats disappear.

The non-hierarchical stats are important to identify if a memcg OOM'd
because of the memory consumption of its own processes or its
descendants. In the example below, I created a parent memcg "a", and a
child memcg "b". A process in "a" itself ("tail" in this case) is
hogging memory and causing an OOM, not the processes in the child "b"
(the "sleep" processes). With non-hierarchical stats, it's clear that
this is the case.

Also, it is generally nice to keep things consistent as much as
possible. The sudden change of the OOM log with the kernel upgrade is
confusing, especially that the memcg stats in the OOM logs in cgroup
v1 now look different from the stats in memory.stat. This patch
restores the consistency for cgroup v1, without affecting cgroup v2.
IMO, it's also a nice cleanup to have the stats formatting code be
consistent across cgroup v1 and v2. I personally didn't like the
memory_stat_format() vs. memcg_stat_show() distinction.

Here is a sample of the OOM logs from the scenario described above:

Before:
[   88.339330] memory: usage 10240kB, limit 10240kB, failcnt 54
[   88.339340] memory+swap: usage 10240kB, limit 9007199254740988kB, failcn=
t 0
[   88.339347] kmem: usage 552kB, limit 9007199254740988kB, failcnt 0
[   88.339348] Memory cgroup stats for /a:
[   88.339458] anon 9900032
[   88.339483] file 0
[   88.339483] kernel 565248
[   88.339484] kernel_stack 0
[   88.339485] pagetables 294912
[   88.339486] sec_pagetables 0
[   88.339486] percpu 15584
[   88.339487] sock 0
[   88.339487] vmalloc 0
[   88.339488] shmem 0
[   88.339488] zswap 0
[   88.339489] zswapped 0
[   88.339489] file_mapped 0
[   88.339490] file_dirty 0
[   88.339490] file_writeback 0
[   88.339491] swapcached 0
[   88.339491] anon_thp 2097152
[   88.339492] file_thp 0
[   88.339492] shmem_thp 0
[   88.339497] inactive_anon 9797632
[   88.339498] active_anon 45056
[   88.339498] inactive_file 0
[   88.339499] active_file 0
[   88.339499] unevictable 0
[   88.339500] slab_reclaimable 19888
[   88.339500] slab_unreclaimable 42752
[   88.339501] slab 62640
[   88.339501] workingset_refault_anon 0
[   88.339502] workingset_refault_file 0
[   88.339502] workingset_activate_anon 0
[   88.339503] workingset_activate_file 0
[   88.339503] workingset_restore_anon 0
[   88.339504] workingset_restore_file 0
[   88.339504] workingset_nodereclaim 0
[   88.339505] pgscan 0
[   88.339505] pgsteal 0
[   88.339506] pgscan_kswapd 0
[   88.339506] pgscan_direct 0
[   88.339507] pgscan_khugepaged 0
[   88.339507] pgsteal_kswapd 0
[   88.339508] pgsteal_direct 0
[   88.339508] pgsteal_khugepaged 0
[   88.339509] pgfault 2750
[   88.339509] pgmajfault 0
[   88.339510] pgrefill 0
[   88.339510] pgactivate 1
[   88.339511] pgdeactivate 0
[   88.339511] pglazyfree 0
[   88.339512] pglazyfreed 0
[   88.339512] zswpin 0
[   88.339513] zswpout 0
[   88.339513] thp_fault_alloc 0
[   88.339514] thp_collapse_alloc 1
[   88.339514] Tasks state (memory values in pages):
[   88.339515] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[   88.339516] [    108]     0   108     2986     2624    61440
0             0 tail
[   88.339525] [     97]     0    97      724      352    32768
0             0 sleep
[   88.339538] [     99]     0    99      724      352    32768
0             0 sleep
[   88.339541] [     98]     0    98      724      320    32768
0             0 sleep
[   88.339542] [    101]     0   101      724      320    32768
0             0 sleep
[   88.339544] [    102]     0   102      724      352    32768
0             0 sleep
[   88.339546] [    103]     0   103      724      352    32768
0             0 sleep
[   88.339548] [    104]     0   104      724      352    32768
0             0 sleep
[   88.339549] [    105]     0   105      724      352    32768
0             0 sleep
[   88.339551] [    100]     0   100      724      352    32768
0             0 sleep
[   88.339558] [    106]     0   106      724      352    32768
0             0 sleep
[   88.339563] oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpu=
set=3D/,mems_allowed=3D0-2,oom_memcg=3D/a,task_memcg=3D/a,task=3Dtail,pid=
=3D108,uid0
[   88.339588] Memory cgroup out of memory: Killed process 108 (tail)
total-vm:11944kB, anon-rss:9216kB, file-rss:0kB, shmem-rss:1280kB,
UID:00


After:
[   74.447997] memory: usage 10240kB, limit 10240kB, failcnt 116
[   74.447998] memory+swap: usage 10240kB, limit 9007199254740988kB, failcn=
t 0
[   74.448000] kmem: usage 548kB, limit 9007199254740988kB, failcnt 0
[   74.448001] Memory cgroup stats for /a:
[   74.448103] cache 0
[   74.448104] rss 9433088
[   74.448105] rss_huge 2097152
[   74.448105] shmem 0
[   74.448106] mapped_file 0
[   74.448106] dirty 0
[   74.448107] writeback 0
[   74.448107] workingset_refault_anon 0
[   74.448108] workingset_refault_file 0
[   74.448109] swap 0
[   74.448109] pgpgin 2304
[   74.448110] pgpgout 512
[   74.448111] pgfault 2332
[   74.448111] pgmajfault 0
[   74.448112] inactive_anon 9388032
[   74.448112] active_anon 4096
[   74.448113] inactive_file 0
[   74.448113] active_file 0
[   74.448114] unevictable 0
[   74.448114] hierarchical_memory_limit 10485760
[   74.448115] hierarchical_memsw_limit 9223372036854771712
[   74.448116] total_cache 0
[   74.448116] total_rss 9818112
[   74.448117] total_rss_huge 2097152
[   74.448118] total_shmem 0
[   74.448118] total_mapped_file 0
[   74.448119] total_dirty 0
[   74.448119] total_writeback 0
[   74.448120] total_workingset_refault_anon 0
[   74.448120] total_workingset_refault_file 0
[   74.448121] total_swap 0
[   74.448121] total_pgpgin 2407
[   74.448121] total_pgpgout 521
[   74.448122] total_pgfault 2734
[   74.448122] total_pgmajfault 0
[   74.448123] total_inactive_anon 9715712
[   74.448123] total_active_anon 45056
[   74.448124] total_inactive_file 0
[   74.448124] total_active_file 0
[   74.448125] total_unevictable 0
[   74.448125] Tasks state (memory values in pages):
[   74.448126] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[   74.448127] [    107]     0   107     2982     2592    61440
0             0 tail
[   74.448131] [     97]     0    97      724      352    32768
0             0 sleep
[   74.448134] [     98]     0    98      724      352    32768
0             0 sleep
[   74.448136] [     99]     0    99      724      352    32768
0             0 sleep
[   74.448137] [    101]     0   101      724      352    32768
0             0 sleep
[   74.448139] [    102]     0   102      724      352    32768
0             0 sleep
[   74.448141] [    103]     0   103      724      352    28672
0             0 sleep
[   74.448143] [    104]     0   104      724      352    32768
0             0 sleep
[   74.448144] [    105]     0   105      724      352    32768
0             0 sleep
[   74.448146] [    106]     0   106      724      352    32768
0             0 sleep
[   74.448148] [    100]     0   100      724      352    32768
0             0 sleep
[   74.448155] oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpu=
set=3D/,mems_allowed=3D0-2,oom_memcg=3D/a,task_memcg=3D/a,task=3Dtail,pid=
=3D107,uid0
[   74.448178] Memory cgroup out of memory: Killed process 107 (tail)
total-vm:11928kB, anon-rss:9088kB, file-rss:0kB, shmem-rss:1280kB,
UID:00
