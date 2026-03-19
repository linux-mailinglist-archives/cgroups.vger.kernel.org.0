Return-Path: <cgroups+bounces-14930-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOjHINdsvGkPygIAu9opvQ
	(envelope-from <cgroups+bounces-14930-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:38:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA12D2BF9
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 22:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BFC5317533F
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20F402B83;
	Thu, 19 Mar 2026 21:36:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B03E0C65
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956177; cv=none; b=Jt0gA2wlLKLFDTguegNb7MVPLLMAKPQCCDUrX2eDul/AkUtZ5dGt3llJ3RpVfb9YLB7zvZzBjt+pcLVFYiH8LVBdSsxlEd1/lzZrzW8ymboUtsbyPptsEaEfHB7fx2FQEhmu4kbF8rPUGfDWSVjMUK5eT/zBVSW/MiVQgUB5vLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956177; c=relaxed/simple;
	bh=iYv+0JMBhL0Y3n+y6pJw/rt2uBkC/RlMI6Ep70XgoGw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rv6LAjgPy9L9t6m1lDRdAA4F7Ho2efLaNNkjpqNV3yiF6cHv1J+3YtzU0b8HvgjQciHNq6gCBX8fFZpjKW2tbD3XCtPw4GNkO/nkfn0VQATgQ+o8VsbkOSHxz/l6j2zA/JaR0PSVnUPOsuNgek6jQ4QmlFSL+htValnKDOcoADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66308f16ea1so17918088eaf.2
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 14:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773956175; x=1774560975;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynbncJsLJEK7RgBrfoH+8cd27pvPqD1p1MxcDbeHsxs=;
        b=lErB2frY1BJBCIIcrG7coPrra3vpEc/2x5PQ4bqv+YvG1s5JZ70R4EEyWxYIjgcZsv
         98pqrL7lza7irpnNYetCZmVMogixPs7Ofe9OImIL/atx3JMvkOz6wHyXOC8oY9lNTQ0C
         N13/2nK0JKHISWm0bGJpWqsiMkBSOc9j8a4affQEeDUDYA16BI4HBS7rm63XtBj2GsZV
         osk72ssKBxnih1cLHCB1z1uIMwgv8T3Aa2Z9vPoaNAwgz7cSB8OPwtnly+BolppNL9vp
         N8fEG+fXMTg9fFMw5QUm8WyBJgHIGiaJJazZGroiwsEAZ+MRxHAlf5B4TVOsFkMpVcXz
         pJFg==
X-Forwarded-Encrypted: i=1; AJvYcCVNolWC4U48nu32Hzza2hnJOQN4jroB+EQkezmxq1aqxt/CVWfuP4RFAdvfxVQ2wXT899MCFtRt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PiMbiPfsTDyp4nKraXWGaLx0TcXIAFygdOLx8H9mVm3P0VSr
	dCx9VuaexHyTuekVXNahwkjgyjfUb/sChGHVopbX876dO5EilzeYbRIejkgBl8atSEsmB1i26YN
	sE+3F3MjwHwaO1Vtuvn5YIb9k/mW03q/oPoTFK/HZWjkG61TfGMx0nz+ySPc=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3104:b0:67b:a667:f51f with SMTP id
 006d021491bc7-67c22bcbc3emr753879eaf.6.1773956175475; Thu, 19 Mar 2026
 14:36:15 -0700 (PDT)
Date: Thu, 19 Mar 2026 14:36:15 -0700
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bc6c4f.050a0220.3bf4de.0001.GAE@google.com>
Subject: [syzbot ci] Re: Virtual Swap Space
From: syzbot ci <syzbot+ci0215525ee2c0ed89@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, axelrasmussen@google.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, bhe@redhat.com, 
	byungchul@sk.com, cgroups@vger.kernel.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, kasong@tencent.com, kernel-team@meta.com, 
	lance.yang@linux.dev, lenb@kernel.org, liam.howlett@oracle.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, nphamcs@gmail.com, 
	pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, 
	rafael@kernel.org, rakie.kim@sk.com, riel@surriel.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14930-lists,cgroups=lfdr.de,ci0215525ee2c0ed89];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,tencent.com,meta.com,oracle.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,surriel.com,huaweicloud.com,suse.cz];
	NEURAL_SPAM(0.00)[0.523];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzbot.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,googlesource.com:url]
X-Rspamd-Queue-Id: DCFA12D2BF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v4] Virtual Swap Space
https://lore.kernel.org/all/20260318222953.441758-1-nphamcs@gmail.com
* [PATCH v4 01/21] mm/swap: decouple swap cache from physical swap infrastructure
* [PATCH v4 02/21] swap: rearrange the swap header file
* [PATCH v4 03/21] mm: swap: add an abstract API for locking out swapoff
* [PATCH v4 04/21] zswap: add new helpers for zswap entry operations
* [PATCH v4 05/21] mm/swap: add a new function to check if a swap entry is in swap cached.
* [PATCH v4 06/21] mm: swap: add a separate type for physical swap slots
* [PATCH v4 07/21] mm: create scaffolds for the new virtual swap implementation
* [PATCH v4 08/21] zswap: prepare zswap for swap virtualization
* [PATCH v4 09/21] mm: swap: allocate a virtual swap slot for each swapped out page
* [PATCH v4 10/21] swap: move swap cache to virtual swap descriptor
* [PATCH v4 11/21] zswap: move zswap entry management to the virtual swap descriptor
* [PATCH v4 12/21] swap: implement the swap_cgroup API using virtual swap
* [PATCH v4 13/21] swap: manage swap entry lifecycle at the virtual swap layer
* [PATCH v4 14/21] mm: swap: decouple virtual swap slot from backing store
* [PATCH v4 15/21] zswap: do not start zswap shrinker if there is no physical swap slots
* [PATCH v4 16/21] swap: do not unnecesarily pin readahead swap entries
* [PATCH v4 17/21] swapfile: remove zeromap bitmap
* [PATCH v4 18/21] memcg: swap: only charge physical swap slots
* [PATCH v4 19/21] swap: simplify swapoff using virtual swap
* [PATCH v4 20/21] swapfile: replace the swap map with bitmaps
* [PATCH v4 21/21] vswap: batch contiguous vswap free calls

and found the following issue:
possible deadlock in vswap_iter

Full report is available here:
https://ci.syzbot.org/series/f8238a2a-370e-404d-b3f7-5945b574bd63

***

possible deadlock in vswap_iter

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/cf1517a6-d391-46d8-bfbe-98e6be6b93ce/config
syz repro: https://ci.syzbot.org/findings/b4e84ae7-17d4-4bf8-9c3f-4c13b10a1e52/syz_repro

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.1.18/6001 is trying to acquire lock:
ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: vswap_iter+0xfa/0x1b0 mm/vswap.c:274

but task is already holding lock:
ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: swap_cache_lock_irq+0xe2/0x190 mm/vswap.c:1529

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&cluster->lock);
  lock(&cluster->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz.1.18/6001:
 #0: ffff8881bb523440 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:391 [inline]
 #0: ffff8881bb523440 (&mm->mmap_lock){++++}-{4:4}, at: madvise_lock+0x152/0x2e0 mm/madvise.c:1789
 #1: ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #1: ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: swap_cache_lock_irq+0xe2/0x190 mm/vswap.c:1529
 #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: vswap_cgroup_record+0x41/0x440 mm/vswap.c:1909

stack backtrace:
CPU: 0 UID: 0 PID: 6001 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 vswap_iter+0xfa/0x1b0 mm/vswap.c:274
 vswap_cgroup_record+0xeb/0x440 mm/vswap.c:1910
 swap_cgroup_record+0xc5/0x130 mm/vswap.c:1933
 memcg1_swapout+0x358/0x9e0 mm/memcontrol-v1.c:623
 __remove_mapping+0x7d4/0xa70 mm/vmscan.c:762
 shrink_folio_list+0x287c/0x5160 mm/vmscan.c:1518
 reclaim_folio_list+0x100/0x400 mm/vmscan.c:2198
 reclaim_pages+0x45b/0x530 mm/vmscan.c:2235
 madvise_cold_or_pageout_pte_range+0x1eac/0x2220 mm/madvise.c:444
 walk_pmd_range mm/pagewalk.c:130 [inline]
 walk_pud_range mm/pagewalk.c:224 [inline]
 walk_p4d_range mm/pagewalk.c:262 [inline]
 walk_pgd_range+0x1032/0x1d30 mm/pagewalk.c:303
 __walk_page_range+0x14c/0x710 mm/pagewalk.c:410
 walk_page_range_vma_unsafe+0x309/0x410 mm/pagewalk.c:714
 madvise_pageout_page_range mm/madvise.c:622 [inline]
 madvise_pageout mm/madvise.c:647 [inline]
 madvise_vma_behavior+0x2951/0x43c0 mm/madvise.c:1366
 madvise_walk_vmas+0x57a/0xaf0 mm/madvise.c:1721
 madvise_do_behavior+0x386/0x540 mm/madvise.c:1937
 do_madvise+0x1fa/0x2e0 mm/madvise.c:2030
 __do_sys_madvise mm/madvise.c:2039 [inline]
 __se_sys_madvise mm/madvise.c:2037 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:2037
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2b3459c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2b35495028 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f2b34815fa0 RCX: 00007f2b3459c799
RDX: 0000000000000015 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007f2b34632c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2b34816038 R14: 00007f2b34815fa0 R15: 00007ffcfbbae8f8
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

