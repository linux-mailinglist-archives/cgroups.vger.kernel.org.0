Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0277356B569
	for <lists+cgroups@lfdr.de>; Fri,  8 Jul 2022 11:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbiGHJ0t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Jul 2022 05:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiGHJ0s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Jul 2022 05:26:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5587DF17
        for <cgroups@vger.kernel.org>; Fri,  8 Jul 2022 02:26:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v14so29724882wra.5
        for <cgroups@vger.kernel.org>; Fri, 08 Jul 2022 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AeiG7MtIhqF5ZJ1NoSuPiAsmZ/3x52blj6FUG78VSnk=;
        b=bFVzx/HIb9bSQE2twHQXz5krOHp4HU6nL50Aa0J/SaINwM2kgdrHRmLlyxupHCbH4i
         09HK6fORd6MpzbBw1pw4h3umh/TlPeiLJjq177PBwg7x0t5kroii/oAhBtSdouwXQf0n
         zwlATxP8H5LIRsKs4wh6f7ac/f/CCNlBMs59HF6ntQvWRiqd3fCYN3SoH6bXZDd+Pmkn
         NJd50ltKGP8+sc7FTGiacQrR3nuCCoPHx8M7lVlaHIOyY7PJd3Bh7D+KpoHL4JO12T5k
         Ii0TXf0XAqOcn6fiGDl8SY8T7yNl3RL8CpuB+bbBVFgZBKcrtn3ftUDaYyedq0JtGZhL
         HbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AeiG7MtIhqF5ZJ1NoSuPiAsmZ/3x52blj6FUG78VSnk=;
        b=FoZPLPGIYYyQD9GK7zh8zrhyokSBKSqgbhWDTN9BApl+39CWq1UyZCKiMtZ0pvyQo2
         Xq/lxTPqf/tJIhApYDelIA2DV3XRPJPtXEacC9tyiGZH8gJvV7Ze3LIoWgKxjMQy3XKH
         owfV5nRaWf9CtYPeReF00kTbn4f80BNtO6WJTeZlsYi06u3jmfzVu0Qquhz1+iXLpuPp
         ph+Or22/Fg316WteWXwEkfbyAj4ZA7mtVUvBHham4Rk3QuTjJjKBRvn33hOyR7vgrrFY
         47Gkzl7U9OjGZl8Hn1is5hDpkM+DwH/U0mp2gWwvjcQn2o0kH4/Sa5X+8jA4j+phVz7n
         wLvg==
X-Gm-Message-State: AJIora+xU60jTydV9UYUDDsYlvVXtBRL2D3Pq2sNM8oVwXNdlwNOwiJ1
        3UKHN+MyuDLTJTCY5YYnnLTHQL9QthkEtcISL5F8Dg==
X-Google-Smtp-Source: AGRyM1uSghH7BxQ0doR+p27keLlL0L2ldj2ISHkUEGAAB/E3pcGHdniUss6vG0mwkgChXGd1VQOPS9E7c3RUZeUQU/A=
X-Received: by 2002:a05:6000:a1e:b0:21b:8c8d:3cb5 with SMTP id
 co30-20020a0560000a1e00b0021b8c8d3cb5mr2370106wrb.372.1657272405303; Fri, 08
 Jul 2022 02:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220621125658.64935-1-songmuchun@bytedance.com>
 <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
 <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net> <CAJD7tkbk-E+Skkj3xxELuGFHet940DovKi0z8NxPqePzXa-Wug@mail.gmail.com>
 <YsfUIpM5NlWZhUDT@FVFYT0MHHV2J.usts.net>
In-Reply-To: <YsfUIpM5NlWZhUDT@FVFYT0MHHV2J.usts.net>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 8 Jul 2022 02:26:08 -0700
Message-ID: <CAJD7tkazvC+kZgGaV3idapQp-zPFaWBxoHwnrqTFoodHZGQcPA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Use obj_cgroup APIs to charge the LRU pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, longman@redhat.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, duanxiongchun@bytedance.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Thu, Jul 7, 2022 at 11:52 PM Muchun Song <songmuchun@bytedance.com> wrot=
e:
>
> On Thu, Jul 07, 2022 at 03:14:26PM -0700, Yosry Ahmed wrote:
> > On Mon, Jun 27, 2022 at 12:11 AM Muchun Song <songmuchun@bytedance.com>=
 wrote:
> > >
> > > On Sun, Jun 26, 2022 at 03:32:02AM -0700, Yosry Ahmed wrote:
> > > > On Tue, Jun 21, 2022 at 5:57 AM Muchun Song <songmuchun@bytedance.c=
om> wrote:
> > > > >
> > > > > This version is rebased on mm-unstable. Hopefully, Andrew can get=
 this series
> > > > > into mm-unstable which will help to determine whether there is a =
problem or
> > > > > degradation. I am also doing some benchmark tests in parallel.
> > > > >
> > > > > Since the following patchsets applied. All the kernel memory are =
charged
> > > > > with the new APIs of obj_cgroup.
> > > > >
> > > > >         commit f2fe7b09a52b ("mm: memcg/slab: charge individual s=
lab objects instead of pages")
> > > > >         commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs=
 to charge kmem pages")
> > > > >
> > > > > But user memory allocations (LRU pages) pinning memcgs for a long=
 time -
> > > > > it exists at a larger scale and is causing recurring problems in =
the real
> > > > > world: page cache doesn't get reclaimed for a long time, or is us=
ed by the
> > > > > second, third, fourth, ... instance of the same job that was rest=
arted into
> > > > > a new cgroup every time. Unreclaimable dying cgroups pile up, was=
te memory,
> > > > > and make page reclaim very inefficient.
> > > > >
> > > > > We can convert LRU pages and most other raw memcg pins to the obj=
cg direction
> > > > > to fix this problem, and then the LRU pages will not pin the memc=
gs.
> > > > >
> > > > > This patchset aims to make the LRU pages to drop the reference to=
 memory
> > > > > cgroup by using the APIs of obj_cgroup. Finally, we can see that =
the number
> > > > > of the dying cgroups will not increase if we run the following te=
st script.
> > > >
> > > > This is amazing work!
> > > >
> > > > Sorry if I came late, I didn't follow the threads of previous versi=
ons
> > > > so this might be redundant, I just have a couple of questions.
> > > >
> > > > a) If LRU pages keep getting parented until they reach root_mem_cgr=
oup
> > > > (assuming they can), aren't these pages effectively unaccounted at
> > > > this point or leaked? Is there protection against this?
> > > >
> > >
> > > In this case, those pages are accounted in root memcg level. Unfortun=
ately,
> > > there is no mechanism now to transfer a page's memcg from one to anot=
her.
> > >
> >
> > Hey Muchun,
> >
> > Quick question regarding the behavior of this change on cgroup v1 (I
> > know .. I know .. sorry):
> >
> > When a memcg dies, its LRU pages are reparented, but what happens to
> > the charge? IIUC we don't do anything because the pages are already
> > hierarchically charged to the parent. Is this correct?
> >
>
> Correct.
>
> > In cgroup v1, we have non-hierarchical stats as well, so I am trying
> > to understand if the reparented memory will appear in the
> > non-hierarchical stats of the parent (my understanding is that the
> > will not). I am also particularly interested in the charging behavior
> > of pages that get reparented to root_mem_cgroup.
> >
>
> I didn't change any memory stats when reparenting.
>
> > The main reason I am asking is that (hierarchical_usage -
> > non-hierarchical_usage - children_hierarchical_usage) is *roughly*
> > something that we use, especially at the root level, to estimate
> > zombie memory usage. I am trying to see if this change will break such
> > calculations. Thanks!
> >
>
> So I think your calculations will still be correct. If you have
> any unexpected result, please let me know. Thanks.

I have been looking at the code and the patchset and I think there
might be a problem with the stats, at least for cgroup v1. Lets say we
have a parent memcg P, which has a child memcg C. When processes in
memcg C allocate memory the stats (e.g. NR_ANON_MAPPED) are updated
for C (non-hierarchical per-cpu counters, memcg->vmstats_percpu), and
for P (aggregated stats, memcg->vmstats).

When memcg C is offlined, its pages are reparented to memcg P, so far
P->vmstats (hierarchical) still have those pages, and
P->vmstats_percpu (non-hierarchical) don't. So far so good.

Now those reparented pages get uncharged, but their memcg is P now, so
they get subtracted from P's *non-hierarchical* stats (and eventually
hierarchical stats as well). So now P->vmstats (hierarchical)
decreases, which is correct, but P->vmstats_percpu (non-hierarchical)
also decreases, which is wrong, as those stats were never added to
P->vmstats_percpu to begin with.

From a cgroup v2 perspective *maybe* everything continues to work, but
this breaks cgroup v1 non-hierarchical stats. In fact, if the
reparented memory exceeds the original non-hierarchical memory in P,
we can underflow those stats  because we are subtracting stats that
were never added in the first place.

Please let me know if I am misunderstanding something and there is
actually no problem with the non-hierarchical stats (you can stop
reading here if this is all in my head and there's actually no
problem).

Off the top of my mind we can handle stats modifications of reparented
memory separately. We should not updated local per-cpu counters, maybe
we should rather update memcg->vmstat.state_pending directly so that
the changes appear as if they come from a child memcg. Two problems
come with such an approach:

1) memcg->vmstat.state_pending is shared between cpus, and so far is
only modified by mem_cgroup_css_rstat_flush() in locked context. A
solution would be to add reparented state to
memcg->vmstat.state_percpu instead and treat it like
memcg->vmstat.state_pending in mem_cgroup_css_rstat_flush(). Keep in
mind that this adds a tiny bit of memory overhead (roughly 8
bytes*num_cpus for each memcg).

2) Identifying that we are updating stats of reparented memory. This
should be easy if we have a pointer to the page to compare page->objcg
with page->objcg->memcg->objcg, but AFAICT the memcg stats are updated
in __mod_memcg_state() and __mod_memcg_lruvec_state(), and we have no
idea in each of these what page(s) is the stats update associated
with. They are called from many different places, it would be
troublesome to pass such information down from all call sites. I have
nothing off the top of my head to fix this problem except passing the
necessary info through all code paths to __mod_memcg_state() and
__mod_memcg_lruvec_state(), which is far from ideal.

Again, I am sorry if these discussions are late, I didn't have time to
look at previous versions of this patchset.

>
> > > > b) Since moving charged pages between memcgs is now becoming easier=
 by
> > > > using the APIs of obj_cgroup, I wonder if this opens the door for
> > > > future work to transfer charges to memcgs that are actually using
> > > > reparented resources. For example, let's say cgroup A reads a few
> > > > pages into page cache, and then they are no longer used by cgroup A=
.
> > > > cgroup B, however, is using the same pages that are currently charg=
ed
> > > > to cgroup A, so it keeps taxing cgroup A for its use. When cgroup A
> > > > dies, and these pages are reparented to A's parent, can we possibly
> > > > mark these reparented pages (maybe in the page tables somewhere) so
> > > > that next time they get accessed we recharge them to B instead
> > > > (possibly asynchronously)?
> > > > I don't have much experience about page tables but I am pretty sure
> > > > they are loaded so maybe there is no room in PTEs for something lik=
e
> > > > this, but I have always wondered about what we can do for this case
> > > > where a cgroup is consistently using memory charged to another cgro=
up.
> > > > Maybe when this memory is reparented is a good point in time to dec=
ide
> > > > to recharge appropriately. It would also fix the reparenty leak to
> > > > root problem (if it even exists).
> > > >
> > >
> > > From my point of view, this is going to be an improvement to the memc=
g
> > > subsystem in the future.  IIUC, most reparented pages are page cache
> > > pages without be mapped to users. So page tables are not a suitable
> > > place to record this information. However, we already have this infor=
mation
> > > in struct obj_cgroup and struct mem_cgroup. If a page's obj_cgroup is=
 not
> > > equal to the page's obj_cgroup->memcg->objcg, it means this page have
> > > been reparented. I am thinking if a place where a page is mapped (pro=
bably
> > > page fault patch) or page (cache) is written (usually vfs write path)
> > > is suitable to transfer page's memcg from one to another. But need mo=
re
> > > thinking, e.g. How to decide if a reparented page needs to be transfe=
rred?
> > > If we need more information to make this decision, where to store tho=
se
> > > information? This is my primary thoughts on this question.
> > >
> > > Thanks.
> > >
> > > > Thanks again for this work and please excuse my ignorance if any pa=
rt
> > > > of what I said doesn't make sense :)
> > > >
> > > > >
> > > > > ```bash
> > > > > #!/bin/bash
> > > > >
> > > > > dd if=3D/dev/zero of=3Dtemp bs=3D4096 count=3D1
> > > > > cat /proc/cgroups | grep memory
> > > > >
> > > > > for i in {0..2000}
> > > > > do
> > > > >         mkdir /sys/fs/cgroup/memory/test$i
> > > > >         echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> > > > >         cat temp >> log
> > > > >         echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> > > > >         rmdir /sys/fs/cgroup/memory/test$i
> > > > > done
> > > > >
> > > > > cat /proc/cgroups | grep memory
> > > > >
> > > > > rm -f temp log
> > > > > ```
> > > > >
> > > > > v5: https://lore.kernel.org/all/20220530074919.46352-1-songmuchun=
@bytedance.com/
> > > > > v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun=
@bytedance.com/
> > > > > v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun=
@bytedance.com/
> > > > > v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun=
@bytedance.com/
> > > > > v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun=
@bytedance.com/
> > > > > RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmu=
chun@bytedance.com/
> > > > > RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmu=
chun@bytedance.com/
> > > > > RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmu=
chun@bytedance.com/
> > > > > RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmu=
chun@bytedance.com/
> > > > >
> > > > > v6:
> > > > >  - Collect Acked-by and Reviewed-by from Roman and Michal Koutn=
=C3=BD. Thanks.
> > > > >  - Rebase to mm-unstable.
> > > > >
> > > > > v5:
> > > > >  - Lots of improvements from Johannes, Roman and Waiman.
> > > > >  - Fix lockdep warning reported by kernel test robot.
> > > > >  - Add two new patches to do code cleanup.
> > > > >  - Collect Acked-by and Reviewed-by from Johannes and Roman.
> > > > >  - I didn't replace local_irq_disable/enable() to local_lock/unlo=
ck_irq() since
> > > > >    local_lock/unlock_irq() takes an parameter, it needs more thin=
king to transform
> > > > >    it to local_lock.  It could be an improvement in the future.
> > > > >
> > > > > v4:
> > > > >  - Resend and rebased on v5.18.
> > > > >
> > > > > v3:
> > > > >  - Removed the Acked-by tags from Roman since this version is bas=
ed on
> > > > >    the folio relevant.
> > > > >
> > > > > v2:
> > > > >  - Rename obj_cgroup_release_kmem() to obj_cgroup_release_bytes()=
 and the
> > > > >    dependencies of CONFIG_MEMCG_KMEM (suggested by Roman, Thanks)=
.
> > > > >  - Rebase to linux 5.15-rc1.
> > > > >  - Add a new pacth to cleanup mem_cgroup_kmem_disabled().
> > > > >
> > > > > v1:
> > > > >  - Drop RFC tag.
> > > > >  - Rebase to linux next-20210811.
> > > > >
> > > > > RFC v4:
> > > > >  - Collect Acked-by from Roman.
> > > > >  - Rebase to linux next-20210525.
> > > > >  - Rename obj_cgroup_release_uncharge() to obj_cgroup_release_kme=
m().
> > > > >  - Change the patch 1 title to "prepare objcg API for non-kmem us=
age".
> > > > >  - Convert reparent_ops_head to an array in patch 8.
> > > > >
> > > > > Thanks for Roman's review and suggestions.
> > > > >
> > > > > RFC v3:
> > > > >  - Drop the code cleanup and simplification patches. Gather those=
 patches
> > > > >    into a separate series[1].
> > > > >  - Rework patch #1 suggested by Johannes.
> > > > >
> > > > > RFC v2:
> > > > >  - Collect Acked-by tags by Johannes. Thanks.
> > > > >  - Rework lruvec_holds_page_lru_lock() suggested by Johannes. Tha=
nks.
> > > > >  - Fix move_pages_to_lru().
> > > > >
> > > > > Muchun Song (11):
> > > > >   mm: memcontrol: remove dead code and comments
> > > > >   mm: rename unlock_page_lruvec{_irq, _irqrestore} to
> > > > >     lruvec_unlock{_irq, _irqrestore}
> > > > >   mm: memcontrol: prepare objcg API for non-kmem usage
> > > > >   mm: memcontrol: make lruvec lock safe when LRU pages are repare=
nted
> > > > >   mm: vmscan: rework move_pages_to_lru()
> > > > >   mm: thp: make split queue lock safe when LRU pages are reparent=
ed
> > > > >   mm: memcontrol: make all the callers of {folio,page}_memcg() sa=
fe
> > > > >   mm: memcontrol: introduce memcg_reparent_ops
> > > > >   mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
> > > > >   mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance function
> > > > >   mm: lru: use lruvec lock to serialize memcg changes
> > > > >
> > > > >  fs/buffer.c                      |   4 +-
> > > > >  fs/fs-writeback.c                |  23 +-
> > > > >  include/linux/memcontrol.h       | 218 +++++++++------
> > > > >  include/linux/mm_inline.h        |   6 +
> > > > >  include/trace/events/writeback.h |   5 +
> > > > >  mm/compaction.c                  |  39 ++-
> > > > >  mm/huge_memory.c                 | 153 ++++++++--
> > > > >  mm/memcontrol.c                  | 584 +++++++++++++++++++++++++=
++------------
> > > > >  mm/migrate.c                     |   4 +
> > > > >  mm/mlock.c                       |   2 +-
> > > > >  mm/page_io.c                     |   5 +-
> > > > >  mm/swap.c                        |  49 ++--
> > > > >  mm/vmscan.c                      |  66 ++---
> > > > >  13 files changed, 776 insertions(+), 382 deletions(-)
> > > > >
> > > > >
> > > > > base-commit: 882be1ed6b1b5073fc88552181b99bd2b9c0031f
> > > > > --
> > > > > 2.11.0
> > > > >
> > > > >
> > > >
> >
