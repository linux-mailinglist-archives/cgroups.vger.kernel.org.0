Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9756AE27
	for <lists+cgroups@lfdr.de>; Fri,  8 Jul 2022 00:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiGGWPH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Jul 2022 18:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGGWPG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Jul 2022 18:15:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA385C95D
        for <cgroups@vger.kernel.org>; Thu,  7 Jul 2022 15:15:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l68so11433098wml.3
        for <cgroups@vger.kernel.org>; Thu, 07 Jul 2022 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lr/CZqOVLz6yIPiD43/Upz31v3PfsMwGMsgVbDd4yko=;
        b=EPJqEJfxUClNdXE7x34+CmxN5XESf+BDwZZJvcpdMqD6veIEoWjqyuek3ttJc5/jr1
         5UxJTi7WOhVUwJUK7+G0hDK+646glFodCTUEgSwuAGhvFgSGQbAKaKHwpCNTHldHiiPm
         LDo0aOUzJ+kZacjcpzUxDPaH4/0UUlkIREln/qsz5QzUNCkI0Sep3lPSV75yTaYhvB8q
         hoLysBc1DrUeRCe7EzkWCVXdN5yTqmch1nnPU8QyFuhbgsDwn+Sy+uM7mHvtPgyUYLfI
         EbA+Ur9X6Dm9WXLyu4WIFHUx5dIAKWzz/0Uwp0Me8QB5c+o8Sw2pD5LmHOsQ+Y7j9RKl
         RabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lr/CZqOVLz6yIPiD43/Upz31v3PfsMwGMsgVbDd4yko=;
        b=AS+8El8Jx8a8YeCAoLTmMxpslYnleEixxfr6He0jGYjV2AftgkErPdJt4oUoln8vy8
         HMRqDcT1vH7sxHwe6qE6muBjXJ0Ok4B0pps2OmwETYifk/Pv2xoy3lZpCKDYpOxsYuWu
         S8dRZTcxM2GkDddSKLEw+E+gnla7fSJHLZ/grZYxTbOemQBF4TJr82b4QjChodQNmZvM
         vUcgGCW37a4I3NYxR0S8sNvW6pT7fYvbUL1Atg7ilBHRYsWaJHdGHYFtbI0FgYTobzxW
         FsyeT9YY0qgbCs2QjNqUxf2DOjIoTHGRms/gdmGWeS33KrOOsgVKXg3DriNUTWBib2yB
         GHSg==
X-Gm-Message-State: AJIora9mSqvNAGsny5Okl6Jp+2O8yf8+Shgvm3tY037T4FPxpXghozAM
        GRB9O2Q10ycn/r1CFJO61BLsPCrwZivKyHn9G8i4fA==
X-Google-Smtp-Source: AGRyM1ufbZ1WfVQZGo2LHT7pdxKfnM1n1rEjqtCIIqXEJXUz5zpqX4zplHwL+vpOrkWqb948j+RS+x1eZOoatVczLdc=
X-Received: by 2002:a1c:ed0a:0:b0:3a2:d894:23f2 with SMTP id
 l10-20020a1ced0a000000b003a2d89423f2mr576769wmh.152.1657232103081; Thu, 07
 Jul 2022 15:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220621125658.64935-1-songmuchun@bytedance.com>
 <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com> <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net>
In-Reply-To: <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 7 Jul 2022 15:14:26 -0700
Message-ID: <CAJD7tkbk-E+Skkj3xxELuGFHet940DovKi0z8NxPqePzXa-Wug@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 27, 2022 at 12:11 AM Muchun Song <songmuchun@bytedance.com> wro=
te:
>
> On Sun, Jun 26, 2022 at 03:32:02AM -0700, Yosry Ahmed wrote:
> > On Tue, Jun 21, 2022 at 5:57 AM Muchun Song <songmuchun@bytedance.com> =
wrote:
> > >
> > > This version is rebased on mm-unstable. Hopefully, Andrew can get thi=
s series
> > > into mm-unstable which will help to determine whether there is a prob=
lem or
> > > degradation. I am also doing some benchmark tests in parallel.
> > >
> > > Since the following patchsets applied. All the kernel memory are char=
ged
> > > with the new APIs of obj_cgroup.
> > >
> > >         commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab =
objects instead of pages")
> > >         commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to =
charge kmem pages")
> > >
> > > But user memory allocations (LRU pages) pinning memcgs for a long tim=
e -
> > > it exists at a larger scale and is causing recurring problems in the =
real
> > > world: page cache doesn't get reclaimed for a long time, or is used b=
y the
> > > second, third, fourth, ... instance of the same job that was restarte=
d into
> > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste m=
emory,
> > > and make page reclaim very inefficient.
> > >
> > > We can convert LRU pages and most other raw memcg pins to the objcg d=
irection
> > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > >
> > > This patchset aims to make the LRU pages to drop the reference to mem=
ory
> > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the =
number
> > > of the dying cgroups will not increase if we run the following test s=
cript.
> >
> > This is amazing work!
> >
> > Sorry if I came late, I didn't follow the threads of previous versions
> > so this might be redundant, I just have a couple of questions.
> >
> > a) If LRU pages keep getting parented until they reach root_mem_cgroup
> > (assuming they can), aren't these pages effectively unaccounted at
> > this point or leaked? Is there protection against this?
> >
>
> In this case, those pages are accounted in root memcg level. Unfortunatel=
y,
> there is no mechanism now to transfer a page's memcg from one to another.
>

Hey Muchun,

Quick question regarding the behavior of this change on cgroup v1 (I
know .. I know .. sorry):

When a memcg dies, its LRU pages are reparented, but what happens to
the charge? IIUC we don't do anything because the pages are already
hierarchically charged to the parent. Is this correct?

In cgroup v1, we have non-hierarchical stats as well, so I am trying
to understand if the reparented memory will appear in the
non-hierarchical stats of the parent (my understanding is that the
will not). I am also particularly interested in the charging behavior
of pages that get reparented to root_mem_cgroup.

The main reason I am asking is that (hierarchical_usage -
non-hierarchical_usage - children_hierarchical_usage) is *roughly*
something that we use, especially at the root level, to estimate
zombie memory usage. I am trying to see if this change will break such
calculations. Thanks!

> > b) Since moving charged pages between memcgs is now becoming easier by
> > using the APIs of obj_cgroup, I wonder if this opens the door for
> > future work to transfer charges to memcgs that are actually using
> > reparented resources. For example, let's say cgroup A reads a few
> > pages into page cache, and then they are no longer used by cgroup A.
> > cgroup B, however, is using the same pages that are currently charged
> > to cgroup A, so it keeps taxing cgroup A for its use. When cgroup A
> > dies, and these pages are reparented to A's parent, can we possibly
> > mark these reparented pages (maybe in the page tables somewhere) so
> > that next time they get accessed we recharge them to B instead
> > (possibly asynchronously)?
> > I don't have much experience about page tables but I am pretty sure
> > they are loaded so maybe there is no room in PTEs for something like
> > this, but I have always wondered about what we can do for this case
> > where a cgroup is consistently using memory charged to another cgroup.
> > Maybe when this memory is reparented is a good point in time to decide
> > to recharge appropriately. It would also fix the reparenty leak to
> > root problem (if it even exists).
> >
>
> From my point of view, this is going to be an improvement to the memcg
> subsystem in the future.  IIUC, most reparented pages are page cache
> pages without be mapped to users. So page tables are not a suitable
> place to record this information. However, we already have this informati=
on
> in struct obj_cgroup and struct mem_cgroup. If a page's obj_cgroup is not
> equal to the page's obj_cgroup->memcg->objcg, it means this page have
> been reparented. I am thinking if a place where a page is mapped (probabl=
y
> page fault patch) or page (cache) is written (usually vfs write path)
> is suitable to transfer page's memcg from one to another. But need more
> thinking, e.g. How to decide if a reparented page needs to be transferred=
?
> If we need more information to make this decision, where to store those
> information? This is my primary thoughts on this question.
>
> Thanks.
>
> > Thanks again for this work and please excuse my ignorance if any part
> > of what I said doesn't make sense :)
> >
> > >
> > > ```bash
> > > #!/bin/bash
> > >
> > > dd if=3D/dev/zero of=3Dtemp bs=3D4096 count=3D1
> > > cat /proc/cgroups | grep memory
> > >
> > > for i in {0..2000}
> > > do
> > >         mkdir /sys/fs/cgroup/memory/test$i
> > >         echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> > >         cat temp >> log
> > >         echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> > >         rmdir /sys/fs/cgroup/memory/test$i
> > > done
> > >
> > > cat /proc/cgroups | grep memory
> > >
> > > rm -f temp log
> > > ```
> > >
> > > v5: https://lore.kernel.org/all/20220530074919.46352-1-songmuchun@byt=
edance.com/
> > > v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun@byt=
edance.com/
> > > v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@byt=
edance.com/
> > > v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@byt=
edance.com/
> > > v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@byt=
edance.com/
> > > RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun=
@bytedance.com/
> > > RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun=
@bytedance.com/
> > > RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun=
@bytedance.com/
> > > RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun=
@bytedance.com/
> > >
> > > v6:
> > >  - Collect Acked-by and Reviewed-by from Roman and Michal Koutn=C3=BD=
. Thanks.
> > >  - Rebase to mm-unstable.
> > >
> > > v5:
> > >  - Lots of improvements from Johannes, Roman and Waiman.
> > >  - Fix lockdep warning reported by kernel test robot.
> > >  - Add two new patches to do code cleanup.
> > >  - Collect Acked-by and Reviewed-by from Johannes and Roman.
> > >  - I didn't replace local_irq_disable/enable() to local_lock/unlock_i=
rq() since
> > >    local_lock/unlock_irq() takes an parameter, it needs more thinking=
 to transform
> > >    it to local_lock.  It could be an improvement in the future.
> > >
> > > v4:
> > >  - Resend and rebased on v5.18.
> > >
> > > v3:
> > >  - Removed the Acked-by tags from Roman since this version is based o=
n
> > >    the folio relevant.
> > >
> > > v2:
> > >  - Rename obj_cgroup_release_kmem() to obj_cgroup_release_bytes() and=
 the
> > >    dependencies of CONFIG_MEMCG_KMEM (suggested by Roman, Thanks).
> > >  - Rebase to linux 5.15-rc1.
> > >  - Add a new pacth to cleanup mem_cgroup_kmem_disabled().
> > >
> > > v1:
> > >  - Drop RFC tag.
> > >  - Rebase to linux next-20210811.
> > >
> > > RFC v4:
> > >  - Collect Acked-by from Roman.
> > >  - Rebase to linux next-20210525.
> > >  - Rename obj_cgroup_release_uncharge() to obj_cgroup_release_kmem().
> > >  - Change the patch 1 title to "prepare objcg API for non-kmem usage"=
.
> > >  - Convert reparent_ops_head to an array in patch 8.
> > >
> > > Thanks for Roman's review and suggestions.
> > >
> > > RFC v3:
> > >  - Drop the code cleanup and simplification patches. Gather those pat=
ches
> > >    into a separate series[1].
> > >  - Rework patch #1 suggested by Johannes.
> > >
> > > RFC v2:
> > >  - Collect Acked-by tags by Johannes. Thanks.
> > >  - Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
> > >  - Fix move_pages_to_lru().
> > >
> > > Muchun Song (11):
> > >   mm: memcontrol: remove dead code and comments
> > >   mm: rename unlock_page_lruvec{_irq, _irqrestore} to
> > >     lruvec_unlock{_irq, _irqrestore}
> > >   mm: memcontrol: prepare objcg API for non-kmem usage
> > >   mm: memcontrol: make lruvec lock safe when LRU pages are reparented
> > >   mm: vmscan: rework move_pages_to_lru()
> > >   mm: thp: make split queue lock safe when LRU pages are reparented
> > >   mm: memcontrol: make all the callers of {folio,page}_memcg() safe
> > >   mm: memcontrol: introduce memcg_reparent_ops
> > >   mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
> > >   mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance function
> > >   mm: lru: use lruvec lock to serialize memcg changes
> > >
> > >  fs/buffer.c                      |   4 +-
> > >  fs/fs-writeback.c                |  23 +-
> > >  include/linux/memcontrol.h       | 218 +++++++++------
> > >  include/linux/mm_inline.h        |   6 +
> > >  include/trace/events/writeback.h |   5 +
> > >  mm/compaction.c                  |  39 ++-
> > >  mm/huge_memory.c                 | 153 ++++++++--
> > >  mm/memcontrol.c                  | 584 +++++++++++++++++++++++++++--=
----------
> > >  mm/migrate.c                     |   4 +
> > >  mm/mlock.c                       |   2 +-
> > >  mm/page_io.c                     |   5 +-
> > >  mm/swap.c                        |  49 ++--
> > >  mm/vmscan.c                      |  66 ++---
> > >  13 files changed, 776 insertions(+), 382 deletions(-)
> > >
> > >
> > > base-commit: 882be1ed6b1b5073fc88552181b99bd2b9c0031f
> > > --
> > > 2.11.0
> > >
> > >
> >
