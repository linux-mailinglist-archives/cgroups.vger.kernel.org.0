Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6411F700A
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 00:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgFKW0S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKW0S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 18:26:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A4C03E96F
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2020 15:26:18 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d67so6916524oig.6
        for <cgroups@vger.kernel.org>; Thu, 11 Jun 2020 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GzFRhux1wSgI812RbpDpAhu3GXlBa7Bd4rcSyefPhVA=;
        b=OzpB2OD9k6LHz7ctmh2NEbz3y65CGLWLCVnma5Ps+TheGsbwt1vtfty1l3R3pGnYi5
         9kuK0m7QLaiGniJz2VRtt96/6QrJfTA4qQDIRq75mHWD7qH3gXO4fDgzfxRAKoaUa08+
         g8jWn+o/OFWX7N7K1X9s2lzB6POD5vvemgqI7vA6/6BlOEUxvWa/knoa9Oy/1qf9IhmA
         5SOlMrILU6p5Wwb9ABnnoDRYXG+L3ijF/V8ltXVNzXsW2KL8DuzZOo4feCoTLLzZRh4j
         pYvE9MrzQirUE0i9K12igcNi4L53ZGAPfU2j01WCpFNaecw5hXl7S4TXNSLNaoLRaalx
         6NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GzFRhux1wSgI812RbpDpAhu3GXlBa7Bd4rcSyefPhVA=;
        b=SeFfjHUtHvP5af2a/LVZXQSOGSGZvuxtELqD72yWFNBM1RxtD76FROdenkT/fp1aza
         VBAY6kEvHqooZk5OnSM5xcRUn8jUq+UR0rGU5cJrHZay82g3N87KMSe/A8LiY/am9gdz
         42M7qo9yy987Pq4LRYrWt7TkPgTpPz5EIcipprDUX+n1Kknrvc90o6BoOUOhlABbwIVR
         SFlxHIGsOx11S4E6qH0z6K2DGqS3fe72itwRlSFwrdKZQbL3XUW3SFrXAo01gGaENKsz
         3WkQEVcVq06widKiIMjmjIvZUFQ3mG/yaygNj2ZNjLx9nJ6DgziiGVQ0Kdq71W2eoDKi
         /W9g==
X-Gm-Message-State: AOAM532LyXmlcn+X8gIWHC3sEOayES8VgLe95nTK2FEWkElnpZHZ3rj7
        FJcPymvM77vZkdHzS5X311L7pQ==
X-Google-Smtp-Source: ABdhPJzOGXq9awTs6f6SrHd8AbBVBmRp+c0JvL2f3Ys+E1G7lVWVJ4FnYj92vCFLqGFElzt7dToGlw==
X-Received: by 2002:aca:ea43:: with SMTP id i64mr146837oih.51.1591914377498;
        Thu, 11 Jun 2020 15:26:17 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p13sm951911otp.58.2020.06.11.15.26.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2020 15:26:16 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:26:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v12 00/16] per memcg lru lock
In-Reply-To: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2006111510220.10801@eggly.anvils>
References: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 11 Jun 2020, Alex Shi wrote:

> This is a new version which bases on v5.8,

No, not even v5.8-rc1 has come out yet.  v12 applied cleanly on
2dca74a40e1e7ff45079d85fc507769383039b9d but I didn't check the build.

> only change mm/compaction.c
> since mm-compaction-avoid-vm_bug_onpageslab-in-page_mapcount.patch 
> removed.
> 
> Johannes Weiner has suggested:
> "So here is a crazy idea that may be worth exploring:
> 
> Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
> linked list.
> 
> Can we make PageLRU atomic and use it to stabilize the lru_lock
> instead, and then use the lru_lock only serialize list operations?
> ..."

It was well worth exploring, and may help in a few cases;
Johannes's memcg swap simplifications have helped a lot more;
but crashes under rotate_reclaimable_page() show that this series
still does not give enough protection from mem_cgroup_move_account().

I'll send a couple of fixes to compaction bugs in reply to this:
with those in, compaction appears to be solid.

Hugh

> 
> With new memcg charge path and this solution, we could isolate
> LRU pages to exclusive visit them in compaction, page migration, reclaim,
> memcg move_accunt, huge page split etc scenarios while keeping pages' 
> memcg stable. Then possible to change per node lru locking to per memcg
> lru locking. As to pagevec_lru_move_fn funcs, it would be safe to let
> pages remain on lru list, lru lock could guard them for list integrity.
> 
> The patchset includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation.
> 2, use TestCleanPageLRU as page isolation's precondition
> 3, replace per node lru_lock with per memcg per node lru_lock
> 
> The 3rd part moves per node lru_lock into lruvec, thus bring a lru_lock for
> each of memcg per node. So on a large machine, each of memcg don't
> have to suffer from per node pgdat->lru_lock competition. They could go
> fast with their self lru_lock
> 
> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> 
> With this patchset, the readtwice performance increased about 80%
> in concurrent containers.
> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
> Mel Gorman, Shakeel Butt, Matthew Wilcox etc.
> 
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
> 
> 
> Alex Shi (14):
>   mm/vmscan: remove unnecessary lruvec adding
>   mm/page_idle: no unlikely double check for idle page counting
>   mm/compaction: correct the comments of compact_defer_shift
>   mm/compaction: rename compact_deferred as compact_should_defer
>   mm/thp: move lru_add_page_tail func to huge_memory.c
>   mm/thp: clean up lru_add_page_tail
>   mm/thp: narrow lru locking
>   mm/memcg: add debug checking in lock_page_memcg
>   mm/lru: introduce TestClearPageLRU
>   mm/compaction: do page isolation first in compaction
>   mm/mlock: reorder isolation sequence during munlock
>   mm/lru: replace pgdat lru_lock with lruvec lock
>   mm/lru: introduce the relock_page_lruvec function
>   mm/pgdat: remove pgdat lru_lock
> 
> Hugh Dickins (2):
>   mm/vmscan: use relock for move_pages_to_lru
>   mm/lru: revise the comments of lru_lock
> 
>  Documentation/admin-guide/cgroup-v1/memcg_test.rst |  15 +-
>  Documentation/admin-guide/cgroup-v1/memory.rst     |   8 +-
>  Documentation/trace/events-kmem.rst                |   2 +-
>  Documentation/vm/unevictable-lru.rst               |  22 +--
>  include/linux/compaction.h                         |   4 +-
>  include/linux/memcontrol.h                         |  92 +++++++++++
>  include/linux/mm_types.h                           |   2 +-
>  include/linux/mmzone.h                             |   6 +-
>  include/linux/page-flags.h                         |   1 +
>  include/linux/swap.h                               |   4 +-
>  include/trace/events/compaction.h                  |   2 +-
>  mm/compaction.c                                    |  96 +++++++-----
>  mm/filemap.c                                       |   4 +-
>  mm/huge_memory.c                                   |  51 +++++--
>  mm/memcontrol.c                                    |  87 ++++++++++-
>  mm/mlock.c                                         |  93 ++++++------
>  mm/mmzone.c                                        |   1 +
>  mm/page_alloc.c                                    |   1 -
>  mm/page_idle.c                                     |   8 -
>  mm/rmap.c                                          |   2 +-
>  mm/swap.c                                          | 112 ++++----------
>  mm/swap_state.c                                    |   6 +-
>  mm/vmscan.c                                        | 168 +++++++++++----------
>  mm/workingset.c                                    |   4 +-
>  24 files changed, 481 insertions(+), 310 deletions(-)
> 
> -- 
> 1.8.3.1
