Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3856B2FB
	for <lists+cgroups@lfdr.de>; Fri,  8 Jul 2022 08:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiGHGwZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Jul 2022 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiGHGwY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Jul 2022 02:52:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000AA6D57E
        for <cgroups@vger.kernel.org>; Thu,  7 Jul 2022 23:52:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so1039213pjm.2
        for <cgroups@vger.kernel.org>; Thu, 07 Jul 2022 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+DFSXCiwRMURoK5XTS8H5JHl90F6lsK83jFk40hr3cE=;
        b=0mtdSGDV4x1HTS61u84SIy7J626352mZUVOKAx076n+bCwBpUqvhbGp6nUPhyi6zg6
         E5Lj3sgRKEXA1rmUErXsyKl+vL63KIbVmpi2pMHijd0j5VTT643qYxZWESP2NXgAeITQ
         xi72qWswWf5EdQIEXFvmeuF17RG7fEXci7fCNfL0soJjQuh4lMJKYrYUCtBxcyStOXfu
         w1aXiaAUP1Fs6KPTb2XlaSIYiGSUTG0HW8txnZfUSdLDKlrlxMAWbiqBRc9de7ZrtA2b
         Y4ErKdr5HAuwUXCg8eMpm5I5fwAcv6hu/n9KaQuh2JcpOCum/z3jY90yhZ3T9YzhPhxq
         7PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+DFSXCiwRMURoK5XTS8H5JHl90F6lsK83jFk40hr3cE=;
        b=hWotKYAv7vpwuBhivMiE8+MsfAOrcWK+HQ9BrKXufhJYfwuxhDnDny2K89L3cT2vjD
         PG2jfVVXGrJltS1Eloxm+qE5FYZLqrbXGx3N74i55egVECeOztAretjAQPX30KN79Z1n
         rNzP4MLoX39Qdw9Ulm6vJOzvnyuQ24FtbNFGP1hrZl3NTJWUPWCgMn8gFLaz8UIiN/NV
         BZW17TqM4Zl+aEfYrjM6HX5ieN012PSeLhFzPoX57tv+hFvujlJsmN/rHhjklHFd2qcK
         p9vZGmP/4fNmOLosVO79mkSLqzNShALmAFxEkE03hnaXumg9zSyItDv6jKLZCEqBu2sR
         AsVQ==
X-Gm-Message-State: AJIora8+7rhblR8moiaAEEM0pWw9Fo9Wr/AX9h9/DMkVgxi+7sOWSXbq
        fsBIiNAtyBIhcVOnJ1UjHQ83Fg==
X-Google-Smtp-Source: AGRyM1uCvCxgMy2pC8dM9+8Ibn+YUZ1fzwsXoow8VRFzAD+jFOkjfsRLl2NVqa1fN6z9EZTsh2YzAA==
X-Received: by 2002:a17:902:ecd0:b0:16a:5222:3a97 with SMTP id a16-20020a170902ecd000b0016a52223a97mr2257762plh.139.1657263142401;
        Thu, 07 Jul 2022 23:52:22 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b0016a4f3ca2b5sm19756840plh.277.2022.07.07.23.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 23:52:22 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:52:18 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, longman@redhat.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, duanxiongchun@bytedance.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v6 00/11] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YsfUIpM5NlWZhUDT@FVFYT0MHHV2J.usts.net>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
 <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
 <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net>
 <CAJD7tkbk-E+Skkj3xxELuGFHet940DovKi0z8NxPqePzXa-Wug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbk-E+Skkj3xxELuGFHet940DovKi0z8NxPqePzXa-Wug@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 07, 2022 at 03:14:26PM -0700, Yosry Ahmed wrote:
> On Mon, Jun 27, 2022 at 12:11 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Sun, Jun 26, 2022 at 03:32:02AM -0700, Yosry Ahmed wrote:
> > > On Tue, Jun 21, 2022 at 5:57 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > This version is rebased on mm-unstable. Hopefully, Andrew can get this series
> > > > into mm-unstable which will help to determine whether there is a problem or
> > > > degradation. I am also doing some benchmark tests in parallel.
> > > >
> > > > Since the following patchsets applied. All the kernel memory are charged
> > > > with the new APIs of obj_cgroup.
> > > >
> > > >         commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects instead of pages")
> > > >         commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")
> > > >
> > > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > > it exists at a larger scale and is causing recurring problems in the real
> > > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > > second, third, fourth, ... instance of the same job that was restarted into
> > > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > > and make page reclaim very inefficient.
> > > >
> > > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > > >
> > > > This patchset aims to make the LRU pages to drop the reference to memory
> > > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > > of the dying cgroups will not increase if we run the following test script.
> > >
> > > This is amazing work!
> > >
> > > Sorry if I came late, I didn't follow the threads of previous versions
> > > so this might be redundant, I just have a couple of questions.
> > >
> > > a) If LRU pages keep getting parented until they reach root_mem_cgroup
> > > (assuming they can), aren't these pages effectively unaccounted at
> > > this point or leaked? Is there protection against this?
> > >
> >
> > In this case, those pages are accounted in root memcg level. Unfortunately,
> > there is no mechanism now to transfer a page's memcg from one to another.
> >
> 
> Hey Muchun,
> 
> Quick question regarding the behavior of this change on cgroup v1 (I
> know .. I know .. sorry):
> 
> When a memcg dies, its LRU pages are reparented, but what happens to
> the charge? IIUC we don't do anything because the pages are already
> hierarchically charged to the parent. Is this correct?
>

Correct.

> In cgroup v1, we have non-hierarchical stats as well, so I am trying
> to understand if the reparented memory will appear in the
> non-hierarchical stats of the parent (my understanding is that the
> will not). I am also particularly interested in the charging behavior
> of pages that get reparented to root_mem_cgroup.
>

I didn't change any memory stats when reparenting.

> The main reason I am asking is that (hierarchical_usage -
> non-hierarchical_usage - children_hierarchical_usage) is *roughly*
> something that we use, especially at the root level, to estimate
> zombie memory usage. I am trying to see if this change will break such
> calculations. Thanks!
> 

So I think your calculations will still be correct. If you have
any unexpected result, please let me know. Thanks.

> > > b) Since moving charged pages between memcgs is now becoming easier by
> > > using the APIs of obj_cgroup, I wonder if this opens the door for
> > > future work to transfer charges to memcgs that are actually using
> > > reparented resources. For example, let's say cgroup A reads a few
> > > pages into page cache, and then they are no longer used by cgroup A.
> > > cgroup B, however, is using the same pages that are currently charged
> > > to cgroup A, so it keeps taxing cgroup A for its use. When cgroup A
> > > dies, and these pages are reparented to A's parent, can we possibly
> > > mark these reparented pages (maybe in the page tables somewhere) so
> > > that next time they get accessed we recharge them to B instead
> > > (possibly asynchronously)?
> > > I don't have much experience about page tables but I am pretty sure
> > > they are loaded so maybe there is no room in PTEs for something like
> > > this, but I have always wondered about what we can do for this case
> > > where a cgroup is consistently using memory charged to another cgroup.
> > > Maybe when this memory is reparented is a good point in time to decide
> > > to recharge appropriately. It would also fix the reparenty leak to
> > > root problem (if it even exists).
> > >
> >
> > From my point of view, this is going to be an improvement to the memcg
> > subsystem in the future.  IIUC, most reparented pages are page cache
> > pages without be mapped to users. So page tables are not a suitable
> > place to record this information. However, we already have this information
> > in struct obj_cgroup and struct mem_cgroup. If a page's obj_cgroup is not
> > equal to the page's obj_cgroup->memcg->objcg, it means this page have
> > been reparented. I am thinking if a place where a page is mapped (probably
> > page fault patch) or page (cache) is written (usually vfs write path)
> > is suitable to transfer page's memcg from one to another. But need more
> > thinking, e.g. How to decide if a reparented page needs to be transferred?
> > If we need more information to make this decision, where to store those
> > information? This is my primary thoughts on this question.
> >
> > Thanks.
> >
> > > Thanks again for this work and please excuse my ignorance if any part
> > > of what I said doesn't make sense :)
> > >
> > > >
> > > > ```bash
> > > > #!/bin/bash
> > > >
> > > > dd if=/dev/zero of=temp bs=4096 count=1
> > > > cat /proc/cgroups | grep memory
> > > >
> > > > for i in {0..2000}
> > > > do
> > > >         mkdir /sys/fs/cgroup/memory/test$i
> > > >         echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> > > >         cat temp >> log
> > > >         echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> > > >         rmdir /sys/fs/cgroup/memory/test$i
> > > > done
> > > >
> > > > cat /proc/cgroups | grep memory
> > > >
> > > > rm -f temp log
> > > > ```
> > > >
> > > > v5: https://lore.kernel.org/all/20220530074919.46352-1-songmuchun@bytedance.com/
> > > > v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun@bytedance.com/
> > > > v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/
> > > > v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@bytedance.com/
> > > > v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@bytedance.com/
> > > > RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun@bytedance.com/
> > > > RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun@bytedance.com/
> > > > RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun@bytedance.com/
> > > > RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/
> > > >
> > > > v6:
> > > >  - Collect Acked-by and Reviewed-by from Roman and Michal Koutný. Thanks.
> > > >  - Rebase to mm-unstable.
> > > >
> > > > v5:
> > > >  - Lots of improvements from Johannes, Roman and Waiman.
> > > >  - Fix lockdep warning reported by kernel test robot.
> > > >  - Add two new patches to do code cleanup.
> > > >  - Collect Acked-by and Reviewed-by from Johannes and Roman.
> > > >  - I didn't replace local_irq_disable/enable() to local_lock/unlock_irq() since
> > > >    local_lock/unlock_irq() takes an parameter, it needs more thinking to transform
> > > >    it to local_lock.  It could be an improvement in the future.
> > > >
> > > > v4:
> > > >  - Resend and rebased on v5.18.
> > > >
> > > > v3:
> > > >  - Removed the Acked-by tags from Roman since this version is based on
> > > >    the folio relevant.
> > > >
> > > > v2:
> > > >  - Rename obj_cgroup_release_kmem() to obj_cgroup_release_bytes() and the
> > > >    dependencies of CONFIG_MEMCG_KMEM (suggested by Roman, Thanks).
> > > >  - Rebase to linux 5.15-rc1.
> > > >  - Add a new pacth to cleanup mem_cgroup_kmem_disabled().
> > > >
> > > > v1:
> > > >  - Drop RFC tag.
> > > >  - Rebase to linux next-20210811.
> > > >
> > > > RFC v4:
> > > >  - Collect Acked-by from Roman.
> > > >  - Rebase to linux next-20210525.
> > > >  - Rename obj_cgroup_release_uncharge() to obj_cgroup_release_kmem().
> > > >  - Change the patch 1 title to "prepare objcg API for non-kmem usage".
> > > >  - Convert reparent_ops_head to an array in patch 8.
> > > >
> > > > Thanks for Roman's review and suggestions.
> > > >
> > > > RFC v3:
> > > >  - Drop the code cleanup and simplification patches. Gather those patches
> > > >    into a separate series[1].
> > > >  - Rework patch #1 suggested by Johannes.
> > > >
> > > > RFC v2:
> > > >  - Collect Acked-by tags by Johannes. Thanks.
> > > >  - Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
> > > >  - Fix move_pages_to_lru().
> > > >
> > > > Muchun Song (11):
> > > >   mm: memcontrol: remove dead code and comments
> > > >   mm: rename unlock_page_lruvec{_irq, _irqrestore} to
> > > >     lruvec_unlock{_irq, _irqrestore}
> > > >   mm: memcontrol: prepare objcg API for non-kmem usage
> > > >   mm: memcontrol: make lruvec lock safe when LRU pages are reparented
> > > >   mm: vmscan: rework move_pages_to_lru()
> > > >   mm: thp: make split queue lock safe when LRU pages are reparented
> > > >   mm: memcontrol: make all the callers of {folio,page}_memcg() safe
> > > >   mm: memcontrol: introduce memcg_reparent_ops
> > > >   mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
> > > >   mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance function
> > > >   mm: lru: use lruvec lock to serialize memcg changes
> > > >
> > > >  fs/buffer.c                      |   4 +-
> > > >  fs/fs-writeback.c                |  23 +-
> > > >  include/linux/memcontrol.h       | 218 +++++++++------
> > > >  include/linux/mm_inline.h        |   6 +
> > > >  include/trace/events/writeback.h |   5 +
> > > >  mm/compaction.c                  |  39 ++-
> > > >  mm/huge_memory.c                 | 153 ++++++++--
> > > >  mm/memcontrol.c                  | 584 +++++++++++++++++++++++++++------------
> > > >  mm/migrate.c                     |   4 +
> > > >  mm/mlock.c                       |   2 +-
> > > >  mm/page_io.c                     |   5 +-
> > > >  mm/swap.c                        |  49 ++--
> > > >  mm/vmscan.c                      |  66 ++---
> > > >  13 files changed, 776 insertions(+), 382 deletions(-)
> > > >
> > > >
> > > > base-commit: 882be1ed6b1b5073fc88552181b99bd2b9c0031f
> > > > --
> > > > 2.11.0
> > > >
> > > >
> > >
> 
