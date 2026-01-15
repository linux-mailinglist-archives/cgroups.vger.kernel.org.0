Return-Path: <cgroups+bounces-13230-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC9D2253D
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 04:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6068B3008E2F
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095DF275AE1;
	Thu, 15 Jan 2026 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tKEz2bV2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E425B30D
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768448842; cv=none; b=GSwIaH3WPiZZ4KzJzk+pJBjjA47PxgxTTkKtw0l8tvVS4yo1I1AWq/55BnV4TWWvP2wXGM2pcsHrC4O6vy1EtUXIC8PK56zHa829MzpsERTsFLOWDnXHVRYRBBqzgT9UPAjlHUDn8ObJUn6kLlQ42lM2+J8ST/OQxc5qvuHNch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768448842; c=relaxed/simple;
	bh=yUwfrtte2wtjxd5vH8W6Fuqry3iO0NInWqrWIIIsDBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQ3aPqIgBxSHRm2rjK1mfWlRum0sjKOXqJuYlIVJBUXhx2Ky/NIu+wAcJgN/n2Bg+WVYin+BAhkyKNM86UwHOgL5ljPa7SmTkjgKgGLE0WjJeflBS6p6+fBBTL+HGFk5HN6FBzb5tNN40d2J/V0w39EilLvtTnKSYzHwwrYRP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tKEz2bV2; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e01a57e0-abbb-4c40-8264-4a212a3ec07b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768448838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NuGNan8e6U/xEMs4AC1GrNFBgKW5vvEKh59uciMY3Y=;
	b=tKEz2bV2zbbzUWK/Uh6ApIMeNVExEvQkPTlpCS+spEHJMManJ6WHfiGERVFRctxWh0JjkH
	UkV1pt8Fx0rr4WdRICo94O3tceJKGlwVAWW/jq+mjgOnDh+eBiaW3Pe/rvDMpMDBx1EH/V
	mcjaoo/Z1D827V9Qdx73loLpPNqH9Dw=
Date: Thu, 15 Jan 2026 11:47:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot ci] Re: Eliminate Dying Memory Cgroup
To: syzbot ci <syzbot+ci7d2110b831be06f6@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, apais@linux.microsoft.com,
 axelrasmussen@google.com, cgroups@vger.kernel.org, chengming.zhou@linux.dev,
 chenridong@huawei.com, chenridong@huaweicloud.com, david@kernel.org,
 hamzamahfooz@linux.microsoft.com, hannes@cmpxchg.org, harry.yoo@oracle.com,
 hughd@google.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, mkoutny@suse.com,
 muchun.song@linux.dev, nphamcs@gmail.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, songmuchun@bytedance.com, weixugc@google.com,
 yosry.ahmed@linux.dev, yuanchu@google.com, zhengqi.arch@bytedance.com,
 ziy@nvidia.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <6967cd38.050a0220.58bed.0001.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <6967cd38.050a0220.58bed.0001.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/15/26 1:07 AM, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v3] Eliminate Dying Memory Cgroup
> https://lore.kernel.org/all/cover.1768389889.git.zhengqi.arch@bytedance.com
> * [PATCH v3 01/30] mm: memcontrol: remove dead code of checking parent memory cgroup
> * [PATCH v3 02/30] mm: workingset: use folio_lruvec() in workingset_refault()
> * [PATCH v3 03/30] mm: rename unlock_page_lruvec_irq and its variants
> * [PATCH v3 04/30] mm: vmscan: prepare for the refactoring the move_folios_to_lru()
> * [PATCH v3 05/30] mm: vmscan: refactor move_folios_to_lru()
> * [PATCH v3 06/30] mm: memcontrol: allocate object cgroup for non-kmem case
> * [PATCH v3 07/30] mm: memcontrol: return root object cgroup for root memory cgroup
> * [PATCH v3 08/30] mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()
> * [PATCH v3 09/30] buffer: prevent memory cgroup release in folio_alloc_buffers()
> * [PATCH v3 10/30] writeback: prevent memory cgroup release in writeback module
> * [PATCH v3 11/30] mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()
> * [PATCH v3 12/30] mm: page_io: prevent memory cgroup release in page_io module
> * [PATCH v3 13/30] mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
> * [PATCH v3 14/30] mm: mglru: prevent memory cgroup release in mglru
> * [PATCH v3 15/30] mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()
> * [PATCH v3 16/30] mm: workingset: prevent memory cgroup release in lru_gen_eviction()
> * [PATCH v3 17/30] mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()
> * [PATCH v3 18/30] mm: zswap: prevent memory cgroup release in zswap_compress()
> * [PATCH v3 19/30] mm: workingset: prevent lruvec release in workingset_refault()
> * [PATCH v3 20/30] mm: zswap: prevent lruvec release in zswap_folio_swapin()
> * [PATCH v3 21/30] mm: swap: prevent lruvec release in lru_gen_clear_refs()
> * [PATCH v3 22/30] mm: workingset: prevent lruvec release in workingset_activation()
> * [PATCH v3 23/30] mm: do not open-code lruvec lock
> * [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
> * [PATCH v3 25/30] mm: vmscan: prepare for reparenting traditional LRU folios
> * [PATCH v3 26/30] mm: vmscan: prepare for reparenting MGLRU folios
> * [PATCH v3 27/30] mm: memcontrol: refactor memcg_reparent_objcgs()
> * [PATCH v3 28/30] mm: memcontrol: prepare for reparenting state_local
> * [PATCH v3 29/30] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
> * [PATCH v3 30/30] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers
> 
> and found the following issue:
> UBSAN: array-index-out-of-bounds in reparent_memcg_lruvec_state_local
> 
> Full report is available here:
> https://ci.syzbot.org/series/45c0b58d-255a-4579-9880-497bdbd4fb99
> 
> ***
> 
> UBSAN: array-index-out-of-bounds in reparent_memcg_lruvec_state_local
> 
> tree:      linux-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> base:      b775e489bec70895b7ef6b66927886bbac79598f
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/4d8819ab-0f94-42e8-bd70-87c7e83c37d2/config
> syz repro: https://ci.syzbot.org/findings/7850f5dd-4ac7-4b74-85ff-a75ddddebbee/syz_repro
> 
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in mm/memcontrol.c:530:3
> index 33 is out of range for type 'long[33]'

Oh, the size of lruvec_stats->state_local is NR_MEMCG_NODE_STAT_ITEMS,
but memcg1_stats contains MEMCG_SWAP, which is outside the array range.

It seems that only the following items need to be reparented:

1). NR_LRU_LISTS
2). NR_SLAB_RECLAIMABLE_B + NR_SLAB_UNRECLAIMABLE_B

But for 2), since we reparented the slab page a long time ago, it seems
there has always been a problem. So this patchset will only handle 1).


> CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Workqueue: cgroup_offline css_killed_work_fn
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>   __ubsan_handle_out_of_bounds+0xe8/0xf0 lib/ubsan.c:455
>   reparent_memcg_lruvec_state_local+0x34f/0x460 mm/memcontrol.c:530
>   reparent_memcg1_lruvec_state_local+0xa7/0xc0 mm/memcontrol-v1.c:1917
>   reparent_state_local mm/memcontrol.c:242 [inline]
>   memcg_reparent_objcgs mm/memcontrol.c:299 [inline]
>   mem_cgroup_css_offline+0xc7c/0xc90 mm/memcontrol.c:4054
>   offline_css kernel/cgroup/cgroup.c:5760 [inline]
>   css_killed_work_fn+0x12f/0x570 kernel/cgroup/cgroup.c:6055
>   process_one_work+0x949/0x15a0 kernel/workqueue.c:3279
>   process_scheduled_works kernel/workqueue.c:3362 [inline]
>   worker_thread+0x9af/0xee0 kernel/workqueue.c:3443
>   kthread+0x388/0x470 kernel/kthread.c:467
>   ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>   </TASK>
> ---[ end trace ]---
> Kernel panic - not syncing: UBSAN: panic_on_warn set ...
> CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Workqueue: cgroup_offline css_killed_work_fn
> Call Trace:
>   <TASK>
>   vpanic+0x1e0/0x670 kernel/panic.c:490
>   panic+0xc5/0xd0 kernel/panic.c:627
>   check_panic_on_warn+0x89/0xb0 kernel/panic.c:377
>   __ubsan_handle_out_of_bounds+0xe8/0xf0 lib/ubsan.c:455
>   reparent_memcg_lruvec_state_local+0x34f/0x460 mm/memcontrol.c:530
>   reparent_memcg1_lruvec_state_local+0xa7/0xc0 mm/memcontrol-v1.c:1917
>   reparent_state_local mm/memcontrol.c:242 [inline]
>   memcg_reparent_objcgs mm/memcontrol.c:299 [inline]
>   mem_cgroup_css_offline+0xc7c/0xc90 mm/memcontrol.c:4054
>   offline_css kernel/cgroup/cgroup.c:5760 [inline]
>   css_killed_work_fn+0x12f/0x570 kernel/cgroup/cgroup.c:6055
>   process_one_work+0x949/0x15a0 kernel/workqueue.c:3279
>   process_scheduled_works kernel/workqueue.c:3362 [inline]
>   worker_thread+0x9af/0xee0 kernel/workqueue.c:3443
>   kthread+0x388/0x470 kernel/kthread.c:467
>   ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>   </TASK>
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ***
> 
> If these findings have caused you to resend the series or submit a
> separate fix, please add the following tag to your commit message:
>    Tested-by: syzbot@syzkaller.appspotmail.com
> 
> ---
> This report is generated by a bot. It may contain errors.
> syzbot ci engineers can be reached at syzkaller@googlegroups.com.


