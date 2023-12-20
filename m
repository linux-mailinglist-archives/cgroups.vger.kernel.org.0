Return-Path: <cgroups+bounces-978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568268198D7
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 07:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DCE1C216C5
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F716421;
	Wed, 20 Dec 2023 06:52:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCE16403;
	Wed, 20 Dec 2023 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VytDXe5_1703055119;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VytDXe5_1703055119)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 14:52:00 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	david@redhat.com,
	ying.huang@intel.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH] mm: memcg: fix split queue list crash when large folio migration
Date: Wed, 20 Dec 2023 14:51:40 +0800
Message-Id: <61273e5e9b490682388377c20f52d19de4a80460.1703054559.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running autonuma with enabling multi-size THP, I encountered the following
kernel crash issue:

[  134.290216] list_del corruption. prev->next should be fffff9ad42e1c490,
but was dead000000000100. (prev=fffff9ad42399890)
[  134.290877] kernel BUG at lib/list_debug.c:62!
[  134.291052] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  134.291210] CPU: 56 PID: 8037 Comm: numa01 Kdump: loaded Tainted:
G            E      6.7.0-rc4+ #20
[  134.291649] RIP: 0010:__list_del_entry_valid_or_report+0x97/0xb0
......
[  134.294252] Call Trace:
[  134.294362]  <TASK>
[  134.294440]  ? die+0x33/0x90
[  134.294561]  ? do_trap+0xe0/0x110
......
[  134.295681]  ? __list_del_entry_valid_or_report+0x97/0xb0
[  134.295842]  folio_undo_large_rmappable+0x99/0x100
[  134.296003]  destroy_large_folio+0x68/0x70
[  134.296172]  migrate_folio_move+0x12e/0x260
[  134.296264]  ? __pfx_remove_migration_pte+0x10/0x10
[  134.296389]  migrate_pages_batch+0x495/0x6b0
[  134.296523]  migrate_pages+0x1d0/0x500
[  134.296646]  ? __pfx_alloc_misplaced_dst_folio+0x10/0x10
[  134.296799]  migrate_misplaced_folio+0x12d/0x2b0
[  134.296953]  do_numa_page+0x1f4/0x570
[  134.297121]  __handle_mm_fault+0x2b0/0x6c0
[  134.297254]  handle_mm_fault+0x107/0x270
[  134.300897]  do_user_addr_fault+0x167/0x680
[  134.304561]  exc_page_fault+0x65/0x140
[  134.307919]  asm_exc_page_fault+0x22/0x30

The reason for the crash is that, the commit 85ce2c517ade ("memcontrol: only
transfer the memcg data for migration") removed the charging and uncharging
operations of the migration folios and cleared the memcg data of the old folio.

During the subsequent release process of the old large folio in destroy_large_folio(),
if the large folio needs to be removed from the split queue, an incorrect split
queue can be obtained (which is pgdat->deferred_split_queue) because the old
folio's memcg is NULL now. This can lead to list operations being performed
under the wrong split queue lock protection, resulting in a list crash as above.

After the migration, the old folio is going to be freed, so we can remove it
from the split queue in mem_cgroup_migrate() a bit earlier before clearing the
memcg data to avoid getting incorrect split queue.

Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migration")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c |  2 +-
 mm/memcontrol.c  | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6be1a380a298..c50dc2e1483f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3124,7 +3124,7 @@ void folio_undo_large_rmappable(struct folio *folio)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
-		list_del(&folio->_deferred_list);
+		list_del_init(&folio->_deferred_list);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae8c62c7aa53..e66e0811cccc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7575,6 +7575,17 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 
 	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
+	/*
+	 * If the old folio a large folio and is in the split queue, it needs
+	 * to be removed from the split queue now, in case getting an incorrect
+	 * split queue in destroy_large_folio() after the memcg of the old folio
+	 * is cleared.
+	 *
+	 * In addition, the old folio is about to be freed after migration, so
+	 * removing from the split queue a bit earlier seems reasonable.
+	 */
+	if (folio_test_large(old) && folio_test_large_rmappable(old))
+		folio_undo_large_rmappable(old);
 	old->memcg_data = 0;
 }
 
-- 
2.39.3


