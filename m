Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3617E55C24D
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiF0QuU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiF0QuR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 12:50:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C8E0DD
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:50:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q9so13907606wrd.8
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7lh6jekjoU7steMEEbic1vB+TfTl965/L+qBUDwhr+o=;
        b=aeao3b/FpYSvzkDncuVufkgfWg7QOuc7ntkfv03yDHE4NpqHKd+LgXZeDxt2cW22f1
         EDG48O/VtVxPcm3oeXROeJ3Zt2flX/BqlxXlO5uUu08ZtXxHM/92JFGYKMS1txXBHp2l
         q/6AqcVYexr2GB1mi8L0NH4Hxjog+GtVcjzff3ammbn3itajBsmdibExyHCafICZ6IL4
         LOpUGIXFk3N9VJdBqD7y6+1flUjAizsrnJQZ6Mx7LlnirxVPzHK3dIFU1HpXXM5HQyYl
         nDH8GiF6uwVR13Q4dF6zdtzfRoTLim9nGQUyGlpwe7rJhCQsurVd+uh5YmGjX4KvMrNO
         dsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7lh6jekjoU7steMEEbic1vB+TfTl965/L+qBUDwhr+o=;
        b=7BMgXMagt+2se8Kp1kbdqg6a+IxBhO21BYJblQfioB7OBazl6Ue+1jP3+C/jWmBP35
         7UmRzlu5X3F6g/fQdA91VSqpyxmknrsCLERN5+TfQf+d1MWrSeUzcGoSPwO15lzXYTCd
         pxXuXOtw2YVMCv3ajvB3U9ESuo5LOEKeWk33IBYoTtjM6F7jN1KRXLILwJHYtvA8JDwJ
         tSBsZprg5pORillr08WB5BiZmM2zKnSn+Fy8YpHqcjzWFlPYCn69qnSj87FNYxRrHeh9
         Iucj/1duqjKkQ/kpeAkBnXfoIQ1Y9heLNGCvUC8scpj99iCWXeyuVK9un/8cqrFRD6Wc
         upZg==
X-Gm-Message-State: AJIora8gCFsypVMSRNlKgwHJ85zE8TBdTry+55+gwCJ9SLVeInk7M0FX
        oex3FnPA/RRACiCMDwc/nVUa5PvXXUTGLY5WgvjYNA==
X-Google-Smtp-Source: AGRyM1vPCCWN6YOckmRFNUJIsF+W9tFcItC5w6fF8Y1gFGq8Q077L7qVP/sD7YQD+Cz3mUgyJESt2YcNfm7m7Pv5vSI=
X-Received: by 2002:a5d:4308:0:b0:219:e5a4:5729 with SMTP id
 h8-20020a5d4308000000b00219e5a45729mr13973368wrq.210.1656348614139; Mon, 27
 Jun 2022 09:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220621125658.64935-1-songmuchun@bytedance.com>
 <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
 <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net> <CAJD7tkbubDhpJV81qkXqRE5-yvvcjKrtPnZnECenafz+to=3_Q@mail.gmail.com>
 <e96f0885-16dc-3d2a-7220-2ff5e7a37737@redhat.com>
In-Reply-To: <e96f0885-16dc-3d2a-7220-2ff5e7a37737@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Jun 2022 09:49:37 -0700
Message-ID: <CAJD7tkagWJv-w9QuFyLzMo9H7WbbJKOpifsVBviVc_gdTdppDg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Use obj_cgroup APIs to charge the LRU pages
To:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Jun 27, 2022 at 3:43 AM Mika Penttil=C3=A4 <mpenttil@redhat.com> wr=
ote:
>
>
>
> On 27.6.2022 11.05, Yosry Ahmed wrote:
> > On Mon, Jun 27, 2022 at 12:11 AM Muchun Song <songmuchun@bytedance.com>=
 wrote:
> >>
> >> On Sun, Jun 26, 2022 at 03:32:02AM -0700, Yosry Ahmed wrote:
> >>> On Tue, Jun 21, 2022 at 5:57 AM Muchun Song <songmuchun@bytedance.com=
> wrote:
> >>>>
> >>>> This version is rebased on mm-unstable. Hopefully, Andrew can get th=
is series
> >>>> into mm-unstable which will help to determine whether there is a pro=
blem or
> >>>> degradation. I am also doing some benchmark tests in parallel.
> >>>>
> >>>> Since the following patchsets applied. All the kernel memory are cha=
rged
> >>>> with the new APIs of obj_cgroup.
> >>>>
> >>>>          commit f2fe7b09a52b ("mm: memcg/slab: charge individual sla=
b objects instead of pages")
> >>>>          commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs t=
o charge kmem pages")
> >>>>
> >>>> But user memory allocations (LRU pages) pinning memcgs for a long ti=
me -
> >>>> it exists at a larger scale and is causing recurring problems in the=
 real
> >>>> world: page cache doesn't get reclaimed for a long time, or is used =
by the
> >>>> second, third, fourth, ... instance of the same job that was restart=
ed into
> >>>> a new cgroup every time. Unreclaimable dying cgroups pile up, waste =
memory,
> >>>> and make page reclaim very inefficient.
> >>>>
> >>>> We can convert LRU pages and most other raw memcg pins to the objcg =
direction
> >>>> to fix this problem, and then the LRU pages will not pin the memcgs.
> >>>>
> >>>> This patchset aims to make the LRU pages to drop the reference to me=
mory
> >>>> cgroup by using the APIs of obj_cgroup. Finally, we can see that the=
 number
> >>>> of the dying cgroups will not increase if we run the following test =
script.
> >>>
> >>> This is amazing work!
> >>>
> >>> Sorry if I came late, I didn't follow the threads of previous version=
s
> >>> so this might be redundant, I just have a couple of questions.
> >>>
> >>> a) If LRU pages keep getting parented until they reach root_mem_cgrou=
p
> >>> (assuming they can), aren't these pages effectively unaccounted at
> >>> this point or leaked? Is there protection against this?
> >>>
> >>
> >> In this case, those pages are accounted in root memcg level. Unfortuna=
tely,
> >> there is no mechanism now to transfer a page's memcg from one to anoth=
er.
> >>
> >>> b) Since moving charged pages between memcgs is now becoming easier b=
y
> >>> using the APIs of obj_cgroup, I wonder if this opens the door for
> >>> future work to transfer charges to memcgs that are actually using
> >>> reparented resources. For example, let's say cgroup A reads a few
> >>> pages into page cache, and then they are no longer used by cgroup A.
> >>> cgroup B, however, is using the same pages that are currently charged
> >>> to cgroup A, so it keeps taxing cgroup A for its use. When cgroup A
> >>> dies, and these pages are reparented to A's parent, can we possibly
> >>> mark these reparented pages (maybe in the page tables somewhere) so
> >>> that next time they get accessed we recharge them to B instead
> >>> (possibly asynchronously)?
> >>> I don't have much experience about page tables but I am pretty sure
> >>> they are loaded so maybe there is no room in PTEs for something like
> >>> this, but I have always wondered about what we can do for this case
> >>> where a cgroup is consistently using memory charged to another cgroup=
.
> >>> Maybe when this memory is reparented is a good point in time to decid=
e
> >>> to recharge appropriately. It would also fix the reparenty leak to
> >>> root problem (if it even exists).
> >>>
> >>
> >>  From my point of view, this is going to be an improvement to the memc=
g
> >> subsystem in the future.  IIUC, most reparented pages are page cache
> >> pages without be mapped to users. So page tables are not a suitable
> >> place to record this information. However, we already have this inform=
ation
> >> in struct obj_cgroup and struct mem_cgroup. If a page's obj_cgroup is =
not
> >> equal to the page's obj_cgroup->memcg->objcg, it means this page have
> >> been reparented. I am thinking if a place where a page is mapped (prob=
ably
> >> page fault patch) or page (cache) is written (usually vfs write path)
> >> is suitable to transfer page's memcg from one to another. But need mor=
e
> >
> > Very good point about unmapped pages, I missed this. Page tables will
> > do us no good here. Such a change would indeed require careful thought
> > because (like you mentioned) there are multiple points in time where
> > it might be suitable to consider recharging the page (e.g. when the
> > page is mapped). This could be an incremental change though. Right now
> > we have no recharging at all, so maybe we can gradually add recharging
> > to suitable paths.
> >
> >> thinking, e.g. How to decide if a reparented page needs to be transfer=
red?
> >
> > Maybe if (page's obj_cgroup->memcg =3D=3D root_mem_cgroup) OR (memcg of
> > current is not a descendant of page's obj_cgroup->memcg) is a good
> > place to start?
> >
> > My rationale is that if the page is charged to root_mem_cgroup through
> > reparenting and a process in a memcg is using it then this is probably
> > an accounting leak. If a page is charged to a memcg A through
> > reparenting and is used by a memcg B in a different subtree, then
> > probably memcg B is getting away with using the page for free while A
> > is being taxed. If B is a descendant of A, it is still getting away
> > with using the page unaccounted, but at least it makes no difference
> > for A.
> >
> > One could argue that we might as well recharge a reparented page
> > anyway if the process is cheap (or done asynchronously), and the paths
> > where we do recharging are not very common.
> >
> > All of this might be moot, I am just thinking out loud. In any way
> > this would be future work and not part of this work.
> >
>
>
> I think you have to uncharge at the reparented parent to keep balances
> right (because parent is hierarchically charged thru page_counter). And
> maybe recharge after that if appropriate.
>

Yeah when I say "recharge" I mean transferring the accounting from one
memcg to another. I think every page should end up accounted to one
memcg afterall. Thanks for pointing that out.

>
>
>
> >
> >> If we need more information to make this decision, where to store thos=
e
> >> information? This is my primary thoughts on this question.
> >
> >>
> >> Thanks.
> >>
> >>> Thanks again for this work and please excuse my ignorance if any part
> >>> of what I said doesn't make sense :)
> >>>
> >>>>
> >>>> ```bash
> >>>> #!/bin/bash
> >>>>
> >>>> dd if=3D/dev/zero of=3Dtemp bs=3D4096 count=3D1
> >>>> cat /proc/cgroups | grep memory
> >>>>
> >>>> for i in {0..2000}
> >>>> do
> >>>>          mkdir /sys/fs/cgroup/memory/test$i
> >>>>          echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> >>>>          cat temp >> log
> >>>>          echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> >>>>          rmdir /sys/fs/cgroup/memory/test$i
> >>>> done
> >>>>
> >>>> cat /proc/cgroups | grep memory
> >>>>
> >>>> rm -f temp log
> >>>> ```
> >>>>
> >>>> v5: https://lore.kernel.org/all/20220530074919.46352-1-songmuchun@by=
tedance.com/
> >>>> v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun@by=
tedance.com/
> >>>> v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@by=
tedance.com/
> >>>> v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@by=
tedance.com/
> >>>> v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@by=
tedance.com/
> >>>> RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchu=
n@bytedance.com/
> >>>> RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchu=
n@bytedance.com/
> >>>> RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchu=
n@bytedance.com/
> >>>> RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchu=
n@bytedance.com/
> >>>>
> >>>> v6:
> >>>>   - Collect Acked-by and Reviewed-by from Roman and Michal Koutn=C3=
=BD. Thanks.
> >>>>   - Rebase to mm-unstable.
> >>>>
> >>>> v5:
> >>>>   - Lots of improvements from Johannes, Roman and Waiman.
> >>>>   - Fix lockdep warning reported by kernel test robot.
> >>>>   - Add two new patches to do code cleanup.
> >>>>   - Collect Acked-by and Reviewed-by from Johannes and Roman.
> >>>>   - I didn't replace local_irq_disable/enable() to local_lock/unlock=
_irq() since
> >>>>     local_lock/unlock_irq() takes an parameter, it needs more thinki=
ng to transform
> >>>>     it to local_lock.  It could be an improvement in the future.
> >>>>
> >>>> v4:
> >>>>   - Resend and rebased on v5.18.
> >>>>
> >>>> v3:
> >>>>   - Removed the Acked-by tags from Roman since this version is based=
 on
> >>>>     the folio relevant.
> >>>>
> >>>> v2:
> >>>>   - Rename obj_cgroup_release_kmem() to obj_cgroup_release_bytes() a=
nd the
> >>>>     dependencies of CONFIG_MEMCG_KMEM (suggested by Roman, Thanks).
> >>>>   - Rebase to linux 5.15-rc1.
> >>>>   - Add a new pacth to cleanup mem_cgroup_kmem_disabled().
> >>>>
> >>>> v1:
> >>>>   - Drop RFC tag.
> >>>>   - Rebase to linux next-20210811.
> >>>>
> >>>> RFC v4:
> >>>>   - Collect Acked-by from Roman.
> >>>>   - Rebase to linux next-20210525.
> >>>>   - Rename obj_cgroup_release_uncharge() to obj_cgroup_release_kmem(=
).
> >>>>   - Change the patch 1 title to "prepare objcg API for non-kmem usag=
e".
> >>>>   - Convert reparent_ops_head to an array in patch 8.
> >>>>
> >>>> Thanks for Roman's review and suggestions.
> >>>>
> >>>> RFC v3:
> >>>>   - Drop the code cleanup and simplification patches. Gather those p=
atches
> >>>>     into a separate series[1].
> >>>>   - Rework patch #1 suggested by Johannes.
> >>>>
> >>>> RFC v2:
> >>>>   - Collect Acked-by tags by Johannes. Thanks.
> >>>>   - Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thank=
s.
> >>>>   - Fix move_pages_to_lru().
> >>>>
> >>>> Muchun Song (11):
> >>>>    mm: memcontrol: remove dead code and comments
> >>>>    mm: rename unlock_page_lruvec{_irq, _irqrestore} to
> >>>>      lruvec_unlock{_irq, _irqrestore}
> >>>>    mm: memcontrol: prepare objcg API for non-kmem usage
> >>>>    mm: memcontrol: make lruvec lock safe when LRU pages are reparent=
ed
> >>>>    mm: vmscan: rework move_pages_to_lru()
> >>>>    mm: thp: make split queue lock safe when LRU pages are reparented
> >>>>    mm: memcontrol: make all the callers of {folio,page}_memcg() safe
> >>>>    mm: memcontrol: introduce memcg_reparent_ops
> >>>>    mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
> >>>>    mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance function
> >>>>    mm: lru: use lruvec lock to serialize memcg changes
> >>>>
> >>>>   fs/buffer.c                      |   4 +-
> >>>>   fs/fs-writeback.c                |  23 +-
> >>>>   include/linux/memcontrol.h       | 218 +++++++++------
> >>>>   include/linux/mm_inline.h        |   6 +
> >>>>   include/trace/events/writeback.h |   5 +
> >>>>   mm/compaction.c                  |  39 ++-
> >>>>   mm/huge_memory.c                 | 153 ++++++++--
> >>>>   mm/memcontrol.c                  | 584 +++++++++++++++++++++++++++=
------------
> >>>>   mm/migrate.c                     |   4 +
> >>>>   mm/mlock.c                       |   2 +-
> >>>>   mm/page_io.c                     |   5 +-
> >>>>   mm/swap.c                        |  49 ++--
> >>>>   mm/vmscan.c                      |  66 ++---
> >>>>   13 files changed, 776 insertions(+), 382 deletions(-)
> >>>>
> >>>>
> >>>> base-commit: 882be1ed6b1b5073fc88552181b99bd2b9c0031f
> >>>> --
> >>>> 2.11.0
> >>>>
> >>>>
> >>>
> >
>
