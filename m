Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB91F1202
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2020 06:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgFHEPw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Jun 2020 00:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgFHEPw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Jun 2020 00:15:52 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7ABC08C5C4
        for <cgroups@vger.kernel.org>; Sun,  7 Jun 2020 21:15:50 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z145so3207348ooa.13
        for <cgroups@vger.kernel.org>; Sun, 07 Jun 2020 21:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fA+uj3QZAzsnVf9+eDRPzEvhxrdeblA3XsCH2pBda6c=;
        b=TjUF5tNlT+ZJVgIpEG8THrAsuG7kXiJxhKwJkjnOl2EXDP/9/yp8bTR1lTq8yq7H/J
         n98yyqsooEWcDoZFha3e4sUvHdOusdjOKqSS5r1TuCxM5CsUWilBL3CS/L4+l34XbwNB
         t4y09KlOnMtI6GzMDRJ1riVKAo8+aw6OL6eQ2mN2Pe2NtzzwNR4HaibqfK4NPP9IdbwG
         NgPShHDskJv64yLtr9EJuUyHq0uQT+QolJ1XcZj7a8Tg1Xpa4PAsNPh0lDC2MlcZcYwa
         os6Q0Aerzygn0DGTdXwhg1HOZVaMLrEpv0e2S9UY4VcbETHlxYG1xCug56llNqUZlCey
         Y0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fA+uj3QZAzsnVf9+eDRPzEvhxrdeblA3XsCH2pBda6c=;
        b=J8zqVGvvKyBtZ8u967kbIPXYQb3c3hej09VjPDIrFklscSo8SFc1YkVquPt/uZnqMX
         qMCOmxDLk+3lPKPW0rhty4RTnxW9+hTSimJzZMXD6iPUAq0JqYmWHWuK2Aa6ABzr4T5S
         mpsYezKzK5/x7W5rDCWjq8kq264KTjDOKZDFUtAkZXFxfTh+PhT+siig5byGOGqcDUlq
         /sRaXSS7q+xtspDEa4lTt4rAxA0peZCys/XGdZLQKerAsPusytRYiu/wnBaB6k374Bow
         qv+X6rsJipaMevMimNZn1f0sbbxnyZAWowdgoHQIsdwbMlAJDo1t+juTYGtKFWYhSuL6
         83cw==
X-Gm-Message-State: AOAM531rSMiZmw9YgyU487pXHZxxAetqkflxHqCYZSIx+5wWbihAhIjM
        FP1Pwe5HO7SdJlhp/h2YybPZVA==
X-Google-Smtp-Source: ABdhPJzdqZFlwy+fFiYYddak2nLWTFHE8TJVbNBsj90uKs3NFwCiHINAS49heKqdpvbQcFnDXG1wwg==
X-Received: by 2002:a05:6820:257:: with SMTP id b23mr13344242ooe.90.1591589747703;
        Sun, 07 Jun 2020 21:15:47 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q2sm1229767oti.36.2020.06.07.21.15.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2020 21:15:46 -0700 (PDT)
Date:   Sun, 7 Jun 2020 21:15:21 -0700 (PDT)
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
Subject: Re: [PATCH v11 00/16] per memcg lru lock
In-Reply-To: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2006072100390.2001@eggly.anvils>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 28 May 2020, Alex Shi wrote:

> This is a new version which bases on linux-next 
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
>  mm/compaction.c                                    | 104 ++++++++-----
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
>  24 files changed, 487 insertions(+), 312 deletions(-)

Hi Alex,

I didn't get to try v10 at all, waited until Johannes's preparatory
memcg swap cleanup was in mmotm; but I have spent a while thrashing
this v11, and can happily report that it is much better than v9 etc:
I believe this memcg lru_lock work will soon be ready for v5.9.

I've not yet found any flaw at the swapping end, but fixes are needed
for isolate_migratepages_block() and mem_cgroup_move_account(): I've
got a series of 4 fix patches to send you (I guess two to fold into
existing patches of yours, and two to keep as separate from me).

I haven't yet written the patch descriptions, will return to that
tomorrow.  I expect you will be preparing a v12 rebased on v5.8-rc1
or v5.8-rc2, and will be able to include these fixes in that.

Tomorrow...
Hugh
