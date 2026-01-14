Return-Path: <cgroups+bounces-13211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB78BD20705
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296D9306DBFB
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F062E54DE;
	Wed, 14 Jan 2026 17:07:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B829E114
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410427; cv=none; b=KsWNC3PdX0HeuJQQ6S9+D+syG7aBfB34j51i71MTk54ILFOW3eiM6CF6DLAxrjEvtWtB5IQhEKvlY9QoTUhlCWk9ms7kiDYPmBXm6Dd+QQjQBLyeuLJpoOuDOjwI7JgUWu4/DYdDXP0U59Q1XgOBIckQdTzVrSkxMwZU54U36SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410427; c=relaxed/simple;
	bh=T3ZReOrv37q0ujYMa7Yq6xdkGIKnAM9y/7OVtPp2dik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=P54MwutYW1sh2p2TsDSgrX6XBo4VGBz6O3M7PmKgRkUFpAD/JrnEi8brPmIp4Z8gTHFHYcqTXqAA+PleU8UzqR86Tt+M1CeLRrzGkjcC9JCsDr9hZCBZaI61/yzckNYIcmH5XrLmqNPcdYlj+L5hx82vSUvuQi0CZ7B5cAXUZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6610e4c7e46so165730eaf.0
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 09:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410425; x=1769015225;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K95I3kAYG1M0KaNSEjeNm5wWa6plLYQ5qvacwmoIgN4=;
        b=EWZ/aZFWmemVnoo/z8wlju9h7nS6b33kLu3pu4T/KvoC5N8QpVCYct0uOSEi+Wp3Gm
         TpxI+ZDg4rqbZeV1NnaF206QXUjSFbjLZ5kxu1YrbnX1jU/FCrY3OSNPDLWrxNzhCVli
         rUN84TB/L4mxdAZqqrLvZZZGn3aIdfqoMfOa9NwBJVxyepBIBKD8/EF9v7NjHz0qDrXj
         Iai00pHgf53CW7FnDxMC27rCo0PVDJAPkWjm8q9Z1h5ofw4Tym5KhN8F2kwoQblyCnmK
         B/N1W+PnEJ6zpub5W282RNjuXtiYnnyX2Gz63eVuCsECSZmyikTehSapi/GxLwsrTMf/
         PxOw==
X-Forwarded-Encrypted: i=1; AJvYcCVLkMJrji8MvePsJB9OXEZkJJm1TAtpe0YoO8ALg5aA7KJjdX5oYwl1SfKSHq4j+OttrrkIfR13@vger.kernel.org
X-Gm-Message-State: AOJu0YwDN7dvu2vKhuK/07/Z6Ju+F1R78bCog+MKKkCLS4TyRB9vHWx1
	8IjRNcq5T8GgsGGIX5u01qkiDEoRs3aGozqxLpZvEIYIFQJnselFrmHGD1kLMA2xH1zJSe+An3F
	88/jiLbLug1yVaSLknRpKfyvAy5c8IFW8aM3QbnWP0o12jW03bv2SqBZUnt0=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:221d:b0:65f:fee:f7cc with SMTP id
 006d021491bc7-6610072cac5mr2420280eaf.49.1768410424835; Wed, 14 Jan 2026
 09:07:04 -0800 (PST)
Date: Wed, 14 Jan 2026 09:07:04 -0800
In-Reply-To: <cover.1768389889.git.zhengqi.arch@bytedance.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6967cd38.050a0220.58bed.0001.GAE@google.com>
Subject: [syzbot ci] Re: Eliminate Dying Memory Cgroup
From: syzbot ci <syzbot+ci7d2110b831be06f6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apais@linux.microsoft.com, 
	axelrasmussen@google.com, cgroups@vger.kernel.org, chengming.zhou@linux.dev, 
	chenridong@huawei.com, chenridong@huaweicloud.com, david@kernel.org, 
	hamzamahfooz@linux.microsoft.com, hannes@cmpxchg.org, harry.yoo@oracle.com, 
	hughd@google.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	lance.yang@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, mkoutny@suse.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, qi.zheng@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, songmuchun@bytedance.com, 
	weixugc@google.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] Eliminate Dying Memory Cgroup
https://lore.kernel.org/all/cover.1768389889.git.zhengqi.arch@bytedance.com
* [PATCH v3 01/30] mm: memcontrol: remove dead code of checking parent memory cgroup
* [PATCH v3 02/30] mm: workingset: use folio_lruvec() in workingset_refault()
* [PATCH v3 03/30] mm: rename unlock_page_lruvec_irq and its variants
* [PATCH v3 04/30] mm: vmscan: prepare for the refactoring the move_folios_to_lru()
* [PATCH v3 05/30] mm: vmscan: refactor move_folios_to_lru()
* [PATCH v3 06/30] mm: memcontrol: allocate object cgroup for non-kmem case
* [PATCH v3 07/30] mm: memcontrol: return root object cgroup for root memory cgroup
* [PATCH v3 08/30] mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()
* [PATCH v3 09/30] buffer: prevent memory cgroup release in folio_alloc_buffers()
* [PATCH v3 10/30] writeback: prevent memory cgroup release in writeback module
* [PATCH v3 11/30] mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()
* [PATCH v3 12/30] mm: page_io: prevent memory cgroup release in page_io module
* [PATCH v3 13/30] mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
* [PATCH v3 14/30] mm: mglru: prevent memory cgroup release in mglru
* [PATCH v3 15/30] mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()
* [PATCH v3 16/30] mm: workingset: prevent memory cgroup release in lru_gen_eviction()
* [PATCH v3 17/30] mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()
* [PATCH v3 18/30] mm: zswap: prevent memory cgroup release in zswap_compress()
* [PATCH v3 19/30] mm: workingset: prevent lruvec release in workingset_refault()
* [PATCH v3 20/30] mm: zswap: prevent lruvec release in zswap_folio_swapin()
* [PATCH v3 21/30] mm: swap: prevent lruvec release in lru_gen_clear_refs()
* [PATCH v3 22/30] mm: workingset: prevent lruvec release in workingset_activation()
* [PATCH v3 23/30] mm: do not open-code lruvec lock
* [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
* [PATCH v3 25/30] mm: vmscan: prepare for reparenting traditional LRU folios
* [PATCH v3 26/30] mm: vmscan: prepare for reparenting MGLRU folios
* [PATCH v3 27/30] mm: memcontrol: refactor memcg_reparent_objcgs()
* [PATCH v3 28/30] mm: memcontrol: prepare for reparenting state_local
* [PATCH v3 29/30] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
* [PATCH v3 30/30] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers

and found the following issue:
UBSAN: array-index-out-of-bounds in reparent_memcg_lruvec_state_local

Full report is available here:
https://ci.syzbot.org/series/45c0b58d-255a-4579-9880-497bdbd4fb99

***

UBSAN: array-index-out-of-bounds in reparent_memcg_lruvec_state_local

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      b775e489bec70895b7ef6b66927886bbac79598f
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/4d8819ab-0f94-42e8-bd70-87c7e83c37d2/config
syz repro: https://ci.syzbot.org/findings/7850f5dd-4ac7-4b74-85ff-a75ddddebbee/syz_repro

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in mm/memcontrol.c:530:3
index 33 is out of range for type 'long[33]'
CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: cgroup_offline css_killed_work_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe8/0xf0 lib/ubsan.c:455
 reparent_memcg_lruvec_state_local+0x34f/0x460 mm/memcontrol.c:530
 reparent_memcg1_lruvec_state_local+0xa7/0xc0 mm/memcontrol-v1.c:1917
 reparent_state_local mm/memcontrol.c:242 [inline]
 memcg_reparent_objcgs mm/memcontrol.c:299 [inline]
 mem_cgroup_css_offline+0xc7c/0xc90 mm/memcontrol.c:4054
 offline_css kernel/cgroup/cgroup.c:5760 [inline]
 css_killed_work_fn+0x12f/0x570 kernel/cgroup/cgroup.c:6055
 process_one_work+0x949/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9af/0xee0 kernel/workqueue.c:3443
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: cgroup_offline css_killed_work_fn
Call Trace:
 <TASK>
 vpanic+0x1e0/0x670 kernel/panic.c:490
 panic+0xc5/0xd0 kernel/panic.c:627
 check_panic_on_warn+0x89/0xb0 kernel/panic.c:377
 __ubsan_handle_out_of_bounds+0xe8/0xf0 lib/ubsan.c:455
 reparent_memcg_lruvec_state_local+0x34f/0x460 mm/memcontrol.c:530
 reparent_memcg1_lruvec_state_local+0xa7/0xc0 mm/memcontrol-v1.c:1917
 reparent_state_local mm/memcontrol.c:242 [inline]
 memcg_reparent_objcgs mm/memcontrol.c:299 [inline]
 mem_cgroup_css_offline+0xc7c/0xc90 mm/memcontrol.c:4054
 offline_css kernel/cgroup/cgroup.c:5760 [inline]
 css_killed_work_fn+0x12f/0x570 kernel/cgroup/cgroup.c:6055
 process_one_work+0x949/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9af/0xee0 kernel/workqueue.c:3443
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

