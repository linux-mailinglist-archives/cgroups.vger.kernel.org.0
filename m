Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9482D2EB381
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 20:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbhAETbw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 14:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbhAETbw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 14:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609875024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYLw5N+U/E6yggeoX+94IfSIBU6gHdaEvQjzfPKPjQk=;
        b=VZzZT2jBFnKU2mi/VguNSxF/42dlErWpWlb4FtxtNcH5ykQkGnSpsmAJnvx5SutnzWiMEP
        nSkkW8M/o3Kh7ARnHJwFECfefWcHC/+XyRW9ExAk4oiMdz8wh2KqIWYMURlT1outK+FajJ
        QqxD+jdzTePX0PhSk+parXGNDi/t6ZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-O1qkZ10_OiasS06j4Lf_fw-1; Tue, 05 Jan 2021 14:30:22 -0500
X-MC-Unique: O1qkZ10_OiasS06j4Lf_fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A42F8107ACE6;
        Tue,  5 Jan 2021 19:30:18 +0000 (UTC)
Received: from ovpn-115-104.rdu2.redhat.com (ovpn-115-104.rdu2.redhat.com [10.10.115.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ACBC5D9CC;
        Tue,  5 Jan 2021 19:30:14 +0000 (UTC)
Message-ID: <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com>
Subject: Re: [PATCH v21 00/19] per memcg lru lock
From:   Qian Cai <qcai@redhat.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Date:   Tue, 05 Jan 2021 14:30:13 -0500
In-Reply-To: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2020-11-05 at 16:55 +0800, Alex Shi wrote:
> This version rebase on next/master 20201104, with much of Johannes's
> Acks and some changes according to Johannes comments. And add a new patch
> v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> v21-0007.
> 
> This patchset followed 2 memcg VM_WARN_ON_ONCE_PAGE patches which were
> added to -mm tree yesterday.
>  
> Many thanks for line by line review by Hugh Dickins, Alexander Duyck and
> Johannes Weiner.

Given the troublesome history of this patchset, and had been put into linux-next 
recently, as well as it touched both THP and mlock. Is it a good idea to suspect
this patchset introducing some races and a spontaneous crash with some mlock
memory presume?

[10392.154328][T23803] huge_memory: total_mapcount: 5, page_count(): 6
[10392.154835][T23803] page:00000000eb7725ad refcount:6 mapcount:0 mapping:0000000000000000 index:0x7fff72a0 pfn:0x20023760
[10392.154865][T23803] head:00000000eb7725ad order:5 compound_mapcount:0 compound_pincount:0
[10392.154889][T23803] anon flags: 0x87fff800009000d(locked|uptodate|dirty|head|swapbacked)
[10392.154908][T23803] raw: 087fff800009000d 5deadbeef0000100 5deadbeef0000122 c0002016ff5e0849
[10392.154933][T23803] raw: 000000007fff72a0 0000000000000000 00000006ffffffff c0002014eb676000
[10392.154965][T23803] page dumped because: total_mapcount(head) > 0
[10392.154987][T23803] pages's memcg:c0002014eb676000
[10392.155023][T23803] ------------[ cut here ]------------
[10392.155042][T23803] kernel BUG at mm/huge_memory.c:2767!
[10392.155064][T23803] Oops: Exception in kernel mode, sig: 5 [#1]
[10392.155084][T23803] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256 NUMA PowerNV
[10392.155114][T23803] Modules linked in: loop kvm_hv kvm ip_tables x_tables sd_mod bnx2x ahci tg3 libahci mdio libphy libata firmware_class dm_mirror dm_region_hash dm_log dm_mod
[10392.155185][T23803] CPU: 44 PID: 23803 Comm: ranbug Not tainted 5.11.0-rc2-next-20210105 #2
[10392.155217][T23803] NIP:  c0000000003b5218 LR: c0000000003b5214 CTR: 0000000000000000
[10392.155247][T23803] REGS: c00000001a8d6ee0 TRAP: 0700   Not tainted  (5.11.0-rc2-next-20210105)
[10392.155279][T23803] MSR:  9000000002823033 <SF,HV,VEC,VSX,FP,ME,IR,DR,RI,LE>  CR: 28422222  XER: 00000000
[10392.155314][T23803] CFAR: c0000000003135ac IRQMASK: 1 
[10392.155314][T23803] GPR00: c0000000003b5214 c00000001a8d7180 c000000007f70b00 000000000000001e 
[10392.155314][T23803] GPR04: c000000000eacd38 0000000000000004 0000000000000027 c000001ffe8a7218 
[10392.155314][T23803] GPR08: 0000000000000023 0000000000000000 0000000000000000 c000000007eacfc8 
[10392.155314][T23803] GPR12: 0000000000002000 c000001ffffcda00 0000000000000000 0000000000000001 
[10392.155314][T23803] GPR16: c00c0008008dd808 0000000000040000 0000000000000000 0000000000000020 
[10392.155314][T23803] GPR20: c00c0008008dd800 0000000000000020 0000000000000006 0000000000000001 
[10392.155314][T23803] GPR24: 0000000000000005 ffffffffffffffff c0002016ff5e0848 0000000000000000 
[10392.155314][T23803] GPR28: c0002014eb676e60 c00c0008008dd800 c00000001a8d73a8 c00c0008008dd800 
[10392.155533][T23803] NIP [c0000000003b5218] split_huge_page_to_list+0xa38/0xa40
[10392.155558][T23803] LR [c0000000003b5214] split_huge_page_to_list+0xa34/0xa40
[10392.155579][T23803] Call Trace:
[10392.155595][T23803] [c00000001a8d7180] [c0000000003b5214] split_huge_page_to_list+0xa34/0xa40 (unreliable)
[10392.155630][T23803] [c00000001a8d7270] [c0000000002dd378] shrink_page_list+0x1568/0x1b00
shrink_page_list at mm/vmscan.c:1251 (discriminator 1)
[10392.155655][T23803] [c00000001a8d7380] [c0000000002df798] shrink_inactive_list+0x228/0x5e0
[10392.155678][T23803] [c00000001a8d7450] [c0000000002e0858] shrink_lruvec+0x2b8/0x6f0
shrink_lruvec at mm/vmscan.c:2462
[10392.155710][T23803] [c00000001a8d7590] [c0000000002e0fd8] shrink_node+0x348/0x970
[10392.155742][T23803] [c00000001a8d7660] [c0000000002e1728] do_try_to_free_pages+0x128/0x560
[10392.155765][T23803] [c00000001a8d7710] [c0000000002e3b78] try_to_free_pages+0x198/0x500
[10392.155780][T23803] [c00000001a8d77e0] [c000000000356f5c] __alloc_pages_slowpath.constprop.112+0x64c/0x1380
[10392.155795][T23803] [c00000001a8d79c0] [c000000000358170] __alloc_pages_nodemask+0x4e0/0x590
[10392.155830][T23803] [c00000001a8d7a50] [c000000000381fb8] alloc_pages_vma+0xb8/0x340
[10392.155854][T23803] [c00000001a8d7ac0] [c000000000324fe8] handle_mm_fault+0xf38/0x1bd0
[10392.155887][T23803] [c00000001a8d7ba0] [c000000000316cd4] __get_user_pages+0x434/0x7d0
[10392.155920][T23803] [c00000001a8d7cb0] [c0000000003197d0] __mm_populate+0xe0/0x290
__mm_populate at mm/gup.c:1459
[10392.155952][T23803] [c00000001a8d7d20] [c00000000032d5a0] do_mlock+0x180/0x360
do_mlock at mm/mlock.c:688
[10392.155975][T23803] [c00000001a8d7d90] [c00000000032d954] sys_mlock+0x24/0x40
[10392.155999][T23803] [c00000001a8d7db0] [c00000000002f510] system_call_exception+0x170/0x280
[10392.156032][T23803] [c00000001a8d7e10] [c00000000000d7c8] system_call_common+0xe8/0x218
[10392.156065][T23803] Instruction dump:
[10392.156082][T23803] e93d0008 71290001 41820014 7fe3fb78 38800000 4bf5e36d 60000000 3c82f8b7 
[10392.156121][T23803] 7fa3eb78 38846b70 4bf5e359 60000000 <0fe00000> 60000000 3c4c07bc 3842b8e0 
[10392.156160][T23803] ---[ end trace 2e3423677d4f91f3 ]---
[10392.312793][T23803] 
[10393.312808][T23803] Kernel panic - not syncing: Fatal exception
[10394.723608][T23803] ---[ end Kernel panic - not syncing: Fatal exception ]---

> 
> So now this patchset includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation. 
> 2, use TestCleanPageLRU as page isolation's precondition.
> 3, replace per node lru_lock with per memcg per node lru_lock.
> 
> Current lru_lock is one for each of node, pgdat->lru_lock, that guard for
> lru lists, but now we had moved the lru lists into memcg for long time. Still
> using per node lru_lock is clearly unscalable, pages on each of memcgs have
> to compete each others for a whole lru_lock. This patchset try to use per
> lruvec/memcg lru_lock to repleace per node lru lock to guard lru lists, make
> it scalable for memcgs and get performance gain.
> 
> Currently lru_lock still guards both lru list and page's lru bit, that's ok.
> but if we want to use specific lruvec lock on the page, we need to pin down
> the page's lruvec/memcg during locking. Just taking lruvec lock first may be
> undermined by the page's memcg charge/migration. To fix this problem, we could
> take out the page's lru bit clear and use it as pin down action to block the
> memcg changes. That's the reason for new atomic func TestClearPageLRU.
> So now isolating a page need both actions: TestClearPageLRU and hold the
> lru_lock.
> 
> The typical usage of this is isolate_migratepages_block() in compaction.c
> we have to take lru bit before lru lock, that serialized the page isolation
> in memcg page charge/migration which will change page's lruvec and new 
> lru_lock in it.
> 
> The above solution suggested by Johannes Weiner, and based on his new memcg 
> charge path, then have this patchset. (Hugh Dickins tested and contributed
> much
> code from compaction fix to general code polish, thanks a lot!).
> 
> Daniel Jordan's testing show 62% improvement on modified readtwice case
> on his 2P * 10 core * 2 HT broadwell box on v18, which has no much different
> with this v20.
> https://lore.kernel.org/lkml/20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com/
> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
> Mel Gorman, Shakeel Butt, Matthew Wilcox, Alexander Duyck etc.
> 
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
> 
> 
> Alex Shi (16):
>   mm/thp: move lru_add_page_tail func to huge_memory.c
>   mm/thp: use head for head page in lru_add_page_tail
>   mm/thp: Simplify lru_add_page_tail()
>   mm/thp: narrow lru locking
>   mm/vmscan: remove unnecessary lruvec adding
>   mm/rmap: stop store reordering issue on page->mapping
>   mm/memcg: add debug checking in lock_page_memcg
>   mm/swap.c: fold vm event PGROTATED into pagevec_move_tail_fn
>   mm/lru: move lock into lru_note_cost
>   mm/vmscan: remove lruvec reget in move_pages_to_lru
>   mm/mlock: remove lru_lock on TestClearPageMlocked
>   mm/mlock: remove __munlock_isolate_lru_page
>   mm/lru: introduce TestClearPageLRU
>   mm/compaction: do page isolation first in compaction
>   mm/swap.c: serialize memcg changes in pagevec_lru_move_fn
>   mm/lru: replace pgdat lru_lock with lruvec lock
> 
> Alexander Duyck (1):
>   mm/lru: introduce the relock_page_lruvec function
> 
> Hugh Dickins (2):
>   mm: page_idle_get_page() does not need lru_lock
>   mm/lru: revise the comments of lru_lock
> 
>  Documentation/admin-guide/cgroup-v1/memcg_test.rst |  15 +-
>  Documentation/admin-guide/cgroup-v1/memory.rst     |  21 +--
>  Documentation/trace/events-kmem.rst                |   2 +-
>  Documentation/vm/unevictable-lru.rst               |  22 +--
>  include/linux/memcontrol.h                         | 110 +++++++++++
>  include/linux/mm_types.h                           |   2 +-
>  include/linux/mmzone.h                             |   6 +-
>  include/linux/page-flags.h                         |   1 +
>  include/linux/swap.h                               |   4 +-
>  mm/compaction.c                                    |  94 +++++++---
>  mm/filemap.c                                       |   4 +-
>  mm/huge_memory.c                                   |  45 +++--
>  mm/memcontrol.c                                    |  79 +++++++-
>  mm/mlock.c                                         |  63 ++-----
>  mm/mmzone.c                                        |   1 +
>  mm/page_alloc.c                                    |   1 -
>  mm/page_idle.c                                     |   4 -
>  mm/rmap.c                                          |  11 +-
>  mm/swap.c                                          | 208 ++++++++----------
> ---
>  mm/vmscan.c                                        | 207 ++++++++++----------
>  mm/workingset.c                                    |   2 -
>  21 files changed, 530 insertions(+), 372 deletions(-)
> 

