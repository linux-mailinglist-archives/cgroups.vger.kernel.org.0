Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9A55C27F
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiF0QrA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiF0Qq6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 12:46:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DCADFCD
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:46:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v65-20020a1cac44000000b003a03c76fa38so5230608wme.5
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bDcRmSQyBr05nzXPgpyc6xTLsc0brlD0x4W2LR7QIbo=;
        b=aKxmgDk02Bptkzu0SNtBnGb2+Ewr/Ar6y0gNQ0muOVW7szgQ3ESxrnhidM4t0X/K8k
         ZeC7fzPEUFMJdo83yP+0NGhjjUweLptujm+83IieUBllhmA/bdnfiIbyKWwyHOzmKmiA
         2y9X3mJ6S9GmBYtujXomCDlIvn1Vo/8Zj8ivaO7KFJ9LsfL9n3N/oLgjh3rGyhVLpO4v
         ACD+LbYeT/k+0sp/woZM4dEe0isLUD34Dqe1Dazh5WpHIsogcy1DlWZpm5yhZwaVpaay
         7PCXwIghWL1JJo8Mh/pMwR62cyZK/0O7yRqdZcnaZh16Ed8Ot4Z0+Se3nc1KK+DLkY+f
         snww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bDcRmSQyBr05nzXPgpyc6xTLsc0brlD0x4W2LR7QIbo=;
        b=T5pVq0mU98BuZ12xK/7bPBwNRHmHrzwhC7TsuOgDy5jgv2bux4epEs5/von1Q8ODu4
         7ojEzTyvlyVOair5AWRJ0OOFohIwsUQzrcW0hInfOgAerljiXHPApR4AdVibVvOzmgsj
         BsOo98ZQYylmfbQtKqRjg/F2fULsM59NyBMACo1Iwp5t7kK2HDLJ/H13RFK+2muBUnf6
         LZbiUFsZbB4UuuSK7mQZ9d952GPno2UpRh7THrHZw8tSzy0Ot5hFeuasnDkGBmfMRHyC
         VE6DFudYM+nvm7HZ5KxAtt5kjFg2yInYzycNHYkxvMFpoftggE7FrXm3d8MFXQYRAN1Q
         wOOA==
X-Gm-Message-State: AJIora8dJK4FMXls7lSlaUGL+oLs2lE0GFI22y0J6mYNjFboluJWvPQc
        bYVJYKAsLRFlHDC52EjME+Z5HK1Seg+LXl3mAM5g0A==
X-Google-Smtp-Source: AGRyM1tV+vvHmLLT1az7JQPkveA1pbIZeuuBF6c8X5iHs59Jk7uk7t33b3uC56yBXnrWjBdlPVBvDJqSic/hrcmOWbQ=
X-Received: by 2002:a05:600c:34cc:b0:39c:832c:bd92 with SMTP id
 d12-20020a05600c34cc00b0039c832cbd92mr16341147wmq.24.1656348415207; Mon, 27
 Jun 2022 09:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220621125658.64935-1-songmuchun@bytedance.com>
 <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
 <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net> <CAJD7tkbubDhpJV81qkXqRE5-yvvcjKrtPnZnECenafz+to=3_Q@mail.gmail.com>
 <YrmC3FbUAD74lKq/@FVFYT0MHHV2J.usts.net>
In-Reply-To: <YrmC3FbUAD74lKq/@FVFYT0MHHV2J.usts.net>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Jun 2022 09:46:19 -0700
Message-ID: <CAJD7tkY9MEnF=0JnCuCvKJ675SWKWsMMckNnrhUL7N0XjNrdLg@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 3:13 AM Muchun Song <songmuchun@bytedance.com> wrot=
e:
>
> On Mon, Jun 27, 2022 at 01:05:06AM -0700, Yosry Ahmed wrote:
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
> >
> > Very good point about unmapped pages, I missed this. Page tables will
> > do us no good here. Such a change would indeed require careful thought
> > because (like you mentioned) there are multiple points in time where
> > it might be suitable to consider recharging the page (e.g. when the
> > page is mapped). This could be an incremental change though. Right now
> > we have no recharging at all, so maybe we can gradually add recharging
> > to suitable paths.
> >
>
> Agree.
>
> > > thinking, e.g. How to decide if a reparented page needs to be transfe=
rred?
> >
> > Maybe if (page's obj_cgroup->memcg =3D=3D root_mem_cgroup) OR (memcg of
>
> This is a good start.
>
> > current is not a descendant of page's obj_cgroup->memcg) is a good
>
> I am not sure this one since a page could be shared between different
> memcg.
>
>     root
>    /   \
>   A     B
>  / \     \
> C   E     D
>
> e.g. a page (originally, it belongs to memcg E and E is dying) is reparen=
ted
> to memcg A, and it is shared between C and D now. Then we need to conside=
r
> whether it should be recharged. Yep, we need more thinging about rechargi=
ng.

Assuming that we are recharging in the mapping path, and D is mapping
a page that was used by E and later reparented to A, I think we should
recharge it to D and uncharge from A in all cases:
If C is not using the page (not shared), then the page should be
accounted to its real user, D, instead of taxing A.
If C is also using the page(shared), then it is not wrong to have the
page accounted to D since it's also a user of the page. Either way
only one of the memcgs using the page will be charged.

So I think either way recharging the page to D instead of A would be
correct. IMO, whether we want to skip the recharge to D for some cases
or not would depend on performance and not correctness, since it
should always be correct to recharge the page to D in this scenario.

>
> > place to start?
> >
> > My rationale is that if the page is charged to root_mem_cgroup through
>
> I think the following issue not only exists in root_mem_cgroup but also
> in non-root.

What's special about root is that every single memcg is a descendant
from root, and that accounting user pages to root is usually not
something that we want. So if we rely on a heuristic like (memcg of
current is not a descendant of page's obj_cgroup->memcg), we need to
have a special case for root so that reparented pages to root are
always recharged.

>
> > reparenting and a process in a memcg is using it then this is probably
> > an accounting leak. If a page is charged to a memcg A through
> > reparenting and is used by a memcg B in a different subtree, then
> > probably memcg B is getting away with using the page for free while A
> > is being taxed. If B is a descendant of A, it is still getting away
> > with using the page unaccounted, but at least it makes no difference
> > for A.
>
> I agree this case needs to be improved.
>
> >
> > One could argue that we might as well recharge a reparented page
> > anyway if the process is cheap (or done asynchronously), and the paths
> > where we do recharging are not very common.
> >
> > All of this might be moot, I am just thinking out loud. In any way
> > this would be future work and not part of this work.
> >
>
> Agree.
>
> Thanks.
>
> >
> > > If we need more information to make this decision, where to store tho=
se
> > > information? This is my primary thoughts on this question.
> >
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
