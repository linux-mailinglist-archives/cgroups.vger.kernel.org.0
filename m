Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A455CEC8
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiF0HLc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 03:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiF0HL3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 03:11:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5D5F52
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 00:11:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jh14so7383628plb.1
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VC489kzuovEEc/JjK52uB+SecoHVH3Iyul2HAGQcsXI=;
        b=MrgQd+okioRjqEakwYkl/vGrE/9AD5FYiASLWkCeHI6dkeoj9XCZ+HQzTzbvVkbTR4
         ASazfaHLrS9V50zrP62vKDublFCYk9Nd99+46kKmaKAY8aaTtSZzxdXExmpkXMztl40e
         WiGVkNKjJHW+BbrzwFom8wrXVKgUF7Ujq+bdmgPfyQ+55WZMqCns8+MJZohi5tGzlpHy
         OK2E63vKT6AEePSSr2sRm6nCc65KregTWWqhlAAqqXInbPg5oasfydYn2VU3/w21yxy1
         Jjzzv2DBfcuprwAHygueRAO8wKm8CjUGbJmwR02qCV4BdK898U57O1fQoOPmGmRdb/fj
         36Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VC489kzuovEEc/JjK52uB+SecoHVH3Iyul2HAGQcsXI=;
        b=baxy/HIEvjeljB7+DZixZvBpZpPH98w0db0dcuiS7k7c26KbyiQ/3jXFd4IFvbflYS
         qVhJhhfbSHVRSXYh66rSseOCvgvWL6ftxhZ+OgoMmLeSBibnwkjMyPzdKvBGwpM9OLte
         vyrHq8rb0QLM4lHfL41kMughBYgL/xYlEavm4aiDUOhwo31gpRqnpX1WWF754RwhwTD6
         0MYM2nhUBA4Pl83vAcEyaqgVoKRA3EKzr384oQl5B98dEP2rl/kbbgxc6/QWI7FKh5xa
         KzGAs1E1FXNDYLetc7CMaueSMqd4gcbrOB896a/d0yV+l1vIxpv5dRjf8tstk3CFUoGJ
         caNA==
X-Gm-Message-State: AJIora+5X5syWXBoAN0KDWzAVnu2gWSdyR6RVxbvDsp37z44cEKOHkgo
        6KmJeu+A4v7HV4dcoNUZk5jqIw==
X-Google-Smtp-Source: AGRyM1vjV/YTOrhBmQQVXmcT0VuWuGHSjICuTX3ElxCqHg66zT6fKrnc3hYmiwQlXzVbL01ivPaUYw==
X-Received: by 2002:a17:902:f813:b0:169:8f5d:c343 with SMTP id ix19-20020a170902f81300b001698f5dc343mr13164391plb.98.1656313886990;
        Mon, 27 Jun 2022 00:11:26 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id c195-20020a624ecc000000b00525472e6e15sm6400932pfb.194.2022.06.27.00.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:11:26 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:11:23 +0800
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
Message-ID: <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
 <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jun 26, 2022 at 03:32:02AM -0700, Yosry Ahmed wrote:
> On Tue, Jun 21, 2022 at 5:57 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > This version is rebased on mm-unstable. Hopefully, Andrew can get this series
> > into mm-unstable which will help to determine whether there is a problem or
> > degradation. I am also doing some benchmark tests in parallel.
> >
> > Since the following patchsets applied. All the kernel memory are charged
> > with the new APIs of obj_cgroup.
> >
> >         commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects instead of pages")
> >         commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")
> >
> > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > it exists at a larger scale and is causing recurring problems in the real
> > world: page cache doesn't get reclaimed for a long time, or is used by the
> > second, third, fourth, ... instance of the same job that was restarted into
> > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > and make page reclaim very inefficient.
> >
> > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > to fix this problem, and then the LRU pages will not pin the memcgs.
> >
> > This patchset aims to make the LRU pages to drop the reference to memory
> > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > of the dying cgroups will not increase if we run the following test script.
> 
> This is amazing work!
> 
> Sorry if I came late, I didn't follow the threads of previous versions
> so this might be redundant, I just have a couple of questions.
> 
> a) If LRU pages keep getting parented until they reach root_mem_cgroup
> (assuming they can), aren't these pages effectively unaccounted at
> this point or leaked? Is there protection against this?
>

In this case, those pages are accounted in root memcg level. Unfortunately,
there is no mechanism now to transfer a page's memcg from one to another.
 
> b) Since moving charged pages between memcgs is now becoming easier by
> using the APIs of obj_cgroup, I wonder if this opens the door for
> future work to transfer charges to memcgs that are actually using
> reparented resources. For example, let's say cgroup A reads a few
> pages into page cache, and then they are no longer used by cgroup A.
> cgroup B, however, is using the same pages that are currently charged
> to cgroup A, so it keeps taxing cgroup A for its use. When cgroup A
> dies, and these pages are reparented to A's parent, can we possibly
> mark these reparented pages (maybe in the page tables somewhere) so
> that next time they get accessed we recharge them to B instead
> (possibly asynchronously)?
> I don't have much experience about page tables but I am pretty sure
> they are loaded so maybe there is no room in PTEs for something like
> this, but I have always wondered about what we can do for this case
> where a cgroup is consistently using memory charged to another cgroup.
> Maybe when this memory is reparented is a good point in time to decide
> to recharge appropriately. It would also fix the reparenty leak to
> root problem (if it even exists).
> 

From my point of view, this is going to be an improvement to the memcg
subsystem in the future.  IIUC, most reparented pages are page cache
pages without be mapped to users. So page tables are not a suitable
place to record this information. However, we already have this information
in struct obj_cgroup and struct mem_cgroup. If a page's obj_cgroup is not
equal to the page's obj_cgroup->memcg->objcg, it means this page have
been reparented. I am thinking if a place where a page is mapped (probably
page fault patch) or page (cache) is written (usually vfs write path)
is suitable to transfer page's memcg from one to another. But need more
thinking, e.g. How to decide if a reparented page needs to be transferred?
If we need more information to make this decision, where to store those
information? This is my primary thoughts on this question.

Thanks.

> Thanks again for this work and please excuse my ignorance if any part
> of what I said doesn't make sense :)
> 
> >
> > ```bash
> > #!/bin/bash
> >
> > dd if=/dev/zero of=temp bs=4096 count=1
> > cat /proc/cgroups | grep memory
> >
> > for i in {0..2000}
> > do
> >         mkdir /sys/fs/cgroup/memory/test$i
> >         echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> >         cat temp >> log
> >         echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> >         rmdir /sys/fs/cgroup/memory/test$i
> > done
> >
> > cat /proc/cgroups | grep memory
> >
> > rm -f temp log
> > ```
> >
> > v5: https://lore.kernel.org/all/20220530074919.46352-1-songmuchun@bytedance.com/
> > v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun@bytedance.com/
> > v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/
> > v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@bytedance.com/
> > v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@bytedance.com/
> > RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun@bytedance.com/
> > RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun@bytedance.com/
> > RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun@bytedance.com/
> > RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/
> >
> > v6:
> >  - Collect Acked-by and Reviewed-by from Roman and Michal Koutný. Thanks.
> >  - Rebase to mm-unstable.
> >
> > v5:
> >  - Lots of improvements from Johannes, Roman and Waiman.
> >  - Fix lockdep warning reported by kernel test robot.
> >  - Add two new patches to do code cleanup.
> >  - Collect Acked-by and Reviewed-by from Johannes and Roman.
> >  - I didn't replace local_irq_disable/enable() to local_lock/unlock_irq() since
> >    local_lock/unlock_irq() takes an parameter, it needs more thinking to transform
> >    it to local_lock.  It could be an improvement in the future.
> >
> > v4:
> >  - Resend and rebased on v5.18.
> >
> > v3:
> >  - Removed the Acked-by tags from Roman since this version is based on
> >    the folio relevant.
> >
> > v2:
> >  - Rename obj_cgroup_release_kmem() to obj_cgroup_release_bytes() and the
> >    dependencies of CONFIG_MEMCG_KMEM (suggested by Roman, Thanks).
> >  - Rebase to linux 5.15-rc1.
> >  - Add a new pacth to cleanup mem_cgroup_kmem_disabled().
> >
> > v1:
> >  - Drop RFC tag.
> >  - Rebase to linux next-20210811.
> >
> > RFC v4:
> >  - Collect Acked-by from Roman.
> >  - Rebase to linux next-20210525.
> >  - Rename obj_cgroup_release_uncharge() to obj_cgroup_release_kmem().
> >  - Change the patch 1 title to "prepare objcg API for non-kmem usage".
> >  - Convert reparent_ops_head to an array in patch 8.
> >
> > Thanks for Roman's review and suggestions.
> >
> > RFC v3:
> >  - Drop the code cleanup and simplification patches. Gather those patches
> >    into a separate series[1].
> >  - Rework patch #1 suggested by Johannes.
> >
> > RFC v2:
> >  - Collect Acked-by tags by Johannes. Thanks.
> >  - Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
> >  - Fix move_pages_to_lru().
> >
> > Muchun Song (11):
> >   mm: memcontrol: remove dead code and comments
> >   mm: rename unlock_page_lruvec{_irq, _irqrestore} to
> >     lruvec_unlock{_irq, _irqrestore}
> >   mm: memcontrol: prepare objcg API for non-kmem usage
> >   mm: memcontrol: make lruvec lock safe when LRU pages are reparented
> >   mm: vmscan: rework move_pages_to_lru()
> >   mm: thp: make split queue lock safe when LRU pages are reparented
> >   mm: memcontrol: make all the callers of {folio,page}_memcg() safe
> >   mm: memcontrol: introduce memcg_reparent_ops
> >   mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
> >   mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance function
> >   mm: lru: use lruvec lock to serialize memcg changes
> >
> >  fs/buffer.c                      |   4 +-
> >  fs/fs-writeback.c                |  23 +-
> >  include/linux/memcontrol.h       | 218 +++++++++------
> >  include/linux/mm_inline.h        |   6 +
> >  include/trace/events/writeback.h |   5 +
> >  mm/compaction.c                  |  39 ++-
> >  mm/huge_memory.c                 | 153 ++++++++--
> >  mm/memcontrol.c                  | 584 +++++++++++++++++++++++++++------------
> >  mm/migrate.c                     |   4 +
> >  mm/mlock.c                       |   2 +-
> >  mm/page_io.c                     |   5 +-
> >  mm/swap.c                        |  49 ++--
> >  mm/vmscan.c                      |  66 ++---
> >  13 files changed, 776 insertions(+), 382 deletions(-)
> >
> >
> > base-commit: 882be1ed6b1b5073fc88552181b99bd2b9c0031f
> > --
> > 2.11.0
> >
> >
> 
