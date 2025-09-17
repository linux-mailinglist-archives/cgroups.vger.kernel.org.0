Return-Path: <cgroups+bounces-10219-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D0B81F88
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 23:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F264A81DA
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 21:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EFB30AD12;
	Wed, 17 Sep 2025 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TorN1Fxf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79841309F0E
	for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144606; cv=none; b=r7bzZsHU/qxgANzQ/m3zA3DikO4fYqSF5FsysC+i5pRGisZstCCDWkpzolw+9de2lIEEYVQfDK+frAlEcjnntbu2FwhULOpLzG2OiLhR/wPJFpR1v6PQX8+aIUhEK1ziludRcdoqzLqgvh5tI8G9A/mwMDEB5A702JNeOYBa5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144606; c=relaxed/simple;
	bh=kSk/aZDdOKg9KQ+kZYEgOHT7740YYKums598mpBSIOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jo5k6ESLmpEjKy2UPX0IRhFfjY24j6e0fGvM/Ej/7zSoCuhwM2i+q8876JaD8z/Ulglc5I/CJlrZjGkWcK1AMgem44Hm3XQf29stGbeAuvsVXuW+XEamswtP13MQMBm62cVe7awWpmTxFvWH/Dgu5c/LxFBy/bgFzWaaYtFzDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TorN1Fxf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32ec2f001abso149448a91.2
        for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758144604; x=1758749404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTKGc8yUnIOhZLLz3jZrfDJbgKc8bNDWHQlSBE8s81M=;
        b=TorN1FxfdPEDyI8c3oNPXhUW0dQ9yj1IHi03x7u4hhrVLxgjKs0+s01bH0fthlX0K+
         WIdgmE6Kj03edTceZtZXFymCN1lqrfh1sEEG6Z+oX5pDMb6yX6R/z1Hb6AEBZeThAdB1
         0/u+b707Il6+8YAWBVOPLv6niIHk715R3Dr/sZOUKjYVVZv/L0o6BY8yrZBAny04fAnj
         oHB3k6LSgMTSux59ukjXl8G2TdK1HSsWnMu8NhEQTKBGnZ+2Q/wQMBSX5a++00aSsOct
         cIWBaI2WlylkK0B4ghIIxjMON5iGEC3MQWDnDlh2gqEqtwF0si1lw6zodsWBIeFKhwCS
         LDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144604; x=1758749404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTKGc8yUnIOhZLLz3jZrfDJbgKc8bNDWHQlSBE8s81M=;
        b=euw9CntVkamnaZDXEGENmPk2sHbnmFD9s0RL2+xIUGLUDP76E18/qqjHhPeLuC717d
         YQUynPdm7xeQD1yYyRk019ckhVDXW3w9Q7GP2fz9QMftNXqDZYdc5oi2N4luYnnRQrMm
         Hs0j1FTl76oK4cGZxRzptWr8xgICUkrUR6SbN65Vpb8DPglS4H2oVAn/+U+m1HALASwX
         t+CCcsD6X9wUba58IKpoI5rpRhGb2P1L0R92Nyc6bWh5U7PnlrSilIcNZWqDXhxALIdN
         MTTaxhwt4txUmefJ/YEBZ4vCBj+8B/jUNzP1HRr0aNi8yw9q3RXi6TCMA5/Fhj5ipSvK
         1PTg==
X-Gm-Message-State: AOJu0YwPlzeQ3u9wsUlpY1kIS3c5maOuf/F573tbdl10lY84/qO4OJYN
	ktUW9uO04XgoJuguFIHEd5QdTWOGAfjJiioDlypysdb5tOnNZ4sVvFieTtXKo/oMsmE73JzQSgn
	2/Kh82iYs6Q==
X-Gm-Gg: ASbGncu74epbBNp1qf54PzvC1qDV49mqd8CSHOgzK+zwEpRvcagZWAtKuQzPqT1gHej
	nTDfmp2M+Dtr8v1L1uUYeav7QNo560yzvlHF++3VxmNMGOAClwgwLny4qiYeG38rplsd7MQrNt6
	+mRrcQZ8/dzyqQSazHAAIwhqowLlnowIvq2CFBaI3X0e6pMEV6QVMNuNWD2LnLB9g8OxnqILqLz
	PwEoDCmIXqhBJd4zuqZwzFpl7xL9l3WrE0yqG818FjABd00y9eqXGuUuuH6MFsD6WgcIn4QFQH7
	HsJ0/cnRVE4nn0BdbEnxzMlyTok7p0TZQNsH87X3HYeUGE7C8qSDffFKLAVXqJCwgeifJkr/j6T
	4gEy0aQvETdY6XPOljVLgsAkRdvQNb7pd5yc8XKNTXg==
X-Google-Smtp-Source: AGHT+IGDhJnULOHslKrpZ1PH63RDEs3+poCntiJ1uXWg6h4a4Y8H/NO/ci03aY1C2K79gg4IrkFAmA==
X-Received: by 2002:a17:90b:268b:b0:32e:32e4:9775 with SMTP id 98e67ed59e1d1-32ee3ed1932mr4707208a91.12.1758144603506;
        Wed, 17 Sep 2025 14:30:03 -0700 (PDT)
Received: from localhost ([61.171.213.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607f0deasm407961a91.23.2025.09.17.14.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:30:03 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: jack@suse.cz,
	tj@kernel.org,
	muchun.song@linux.dev,
	venkat88@linux.ibm.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org
Subject: [PATCH v6] memcg: Don't wait writeback completion when release memcg.
Date: Thu, 18 Sep 2025 05:29:59 +0800
Message-Id: <20250917212959.355656-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, we encountered the following hung task:

INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
[Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
[Wed Jul 30 17:47:45 2025] Call Trace:
[Wed Jul 30 17:47:45 2025]  __schedule+0x934/0xe10
[Wed Jul 30 17:47:45 2025]  ? complete+0x3b/0x50
[Wed Jul 30 17:47:45 2025]  ? _cond_resched+0x15/0x30
[Wed Jul 30 17:47:45 2025]  schedule+0x40/0xb0
[Wed Jul 30 17:47:45 2025]  wb_wait_for_completion+0x52/0x80
[Wed Jul 30 17:47:45 2025]  ? finish_wait+0x80/0x80
[Wed Jul 30 17:47:45 2025]  mem_cgroup_css_free+0x22/0x1b0
[Wed Jul 30 17:47:45 2025]  css_free_rwork_fn+0x42/0x380
[Wed Jul 30 17:47:45 2025]  process_one_work+0x1a2/0x360
[Wed Jul 30 17:47:45 2025]  worker_thread+0x30/0x390
[Wed Jul 30 17:47:45 2025]  ? create_worker+0x1a0/0x1a0
[Wed Jul 30 17:47:45 2025]  kthread+0x110/0x130
[Wed Jul 30 17:47:45 2025]  ? __kthread_cancel_work+0x40/0x40
[Wed Jul 30 17:47:45 2025]  ret_from_fork+0x1f/0x30

The direct cause is that memcg spends a long time waiting for dirty page
writeback of foreign memcgs during release.

The root causes are:
    a. The wb may have multiple writeback tasks, containing millions
       of dirty pages, as shown below:

>>> for work in list_for_each_entry("struct wb_writeback_work", \
				    wb.work_list.address_of_(), "list"):
...     print(work.nr_pages, work.reason, hex(work))
...
900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
1275228 WB_REASON_FOREIGN_FLUSH 0xffff969d9b444bc0
1099673 WB_REASON_FOREIGN_FLUSH 0xffff969f0954d6c0
1351522 WB_REASON_FOREIGN_FLUSH 0xffff969e76713340
2567437 WB_REASON_FOREIGN_FLUSH 0xffff9694ae208400
2954033 WB_REASON_FOREIGN_FLUSH 0xffff96a22d62cbc0
3008860 WB_REASON_FOREIGN_FLUSH 0xffff969eee8ce3c0
3337932 WB_REASON_FOREIGN_FLUSH 0xffff9695b45156c0
3348916 WB_REASON_FOREIGN_FLUSH 0xffff96a22c7a4f40
3345363 WB_REASON_FOREIGN_FLUSH 0xffff969e5d872800
3333581 WB_REASON_FOREIGN_FLUSH 0xffff969efd0f4600
3382225 WB_REASON_FOREIGN_FLUSH 0xffff969e770edcc0
3418770 WB_REASON_FOREIGN_FLUSH 0xffff96a252ceea40
3387648 WB_REASON_FOREIGN_FLUSH 0xffff96a3bda86340
3385420 WB_REASON_FOREIGN_FLUSH 0xffff969efc6eb280
3418730 WB_REASON_FOREIGN_FLUSH 0xffff96a348ab1040
3426155 WB_REASON_FOREIGN_FLUSH 0xffff969d90beac00
3397995 WB_REASON_FOREIGN_FLUSH 0xffff96a2d7288800
3293095 WB_REASON_FOREIGN_FLUSH 0xffff969dab423240
3293595 WB_REASON_FOREIGN_FLUSH 0xffff969c765ff400
3199511 WB_REASON_FOREIGN_FLUSH 0xffff969a72d5e680
3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00

    b. The writeback might severely throttled by wbt, with a speed
       possibly less than 100kb/s, leading to a very long writeback time.

>>> wb.write_bandwidth
(unsigned long)24
>>> wb.write_bandwidth
(unsigned long)13

The wb_wait_for_completion() here is probably only used to prevent
use-after-free. Therefore, we manage 'done' separately and automatically
free it.

This allows us to remove wb_wait_for_completion() while preventing
the use-after-free issue.

Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
  Changes in v6:
    * Add comment to explain reason and usage of 
      struct cgwb_frn_wait.

  Changes in v5:
    * Protect operation on wq_head with spinlock.

  Changes in v4:
    * Check done->cnt in memcg_cgwb_waitq_callback_fn().
    * Code cleanups as Tejun suggested.

  Changes in v3:
    * Rename cgwb_frn_wq_entry to cgwb_frn_wait.
    * Define memcg_cgwb_waitq_callback_fn() only when
      CONFIG_CGROUP_WRITEBACK is defined.
    * Embed wb_completion into struct cgwb_frn_wait.

  Change in v2:
    * Use custom waitq function to free resources

 include/linux/memcontrol.h | 14 +++++++++-
 mm/memcontrol.c            | 57 ++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..1568121d25ca 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -157,11 +157,23 @@ struct mem_cgroup_thresholds {
  */
 #define MEMCG_CGWB_FRN_CNT	4
 
+/*
+ * This structure exists to avoid waiting for writeback to finish on
+ * memcg release, which could lead to a hang task.
+ * @done.cnt is always > 0 before a memcg is released, so @wq_entry.func
+ * may only be invoked by finish_writeback_work() after memcg is freed.
+ * See mem_cgroup_css_free() for details.
+ */
+struct cgwb_frn_wait {
+	struct wb_completion done;
+	struct wait_queue_entry wq_entry;
+};
+
 struct memcg_cgwb_frn {
 	u64 bdi_id;			/* bdi->id of the foreign inode */
 	int memcg_id;			/* memcg->css.id of foreign inode */
 	u64 at;				/* jiffies_64 at the time of dirtying */
-	struct wb_completion done;	/* tracks in-flight foreign writebacks */
+	struct cgwb_frn_wait *wait;	/* tracks in-flight foreign writebacks */
 };
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..110937c3671a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3459,7 +3459,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 		    frn->memcg_id == wb->memcg_css->id)
 			break;
 		if (time_before64(frn->at, oldest_at) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    atomic_read(&frn->wait->done.cnt) == 1) {
 			oldest = i;
 			oldest_at = frn->at;
 		}
@@ -3506,12 +3506,12 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		 * already one in flight.
 		 */
 		if (time_after64(frn->at, now - intv) &&
-		    atomic_read(&frn->done.cnt) == 1) {
+		    atomic_read(&frn->wait->done.cnt) == 1) {
 			frn->at = 0;
 			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
 			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
 					       WB_REASON_FOREIGN_FLUSH,
-					       &frn->done);
+					       &frn->wait->done);
 		}
 	}
 }
@@ -3702,13 +3702,29 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 	__mem_cgroup_free(memcg);
 }
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+static int memcg_cgwb_waitq_callback_fn(struct wait_queue_entry *wq_entry, unsigned int mode,
+					int flags, void *key)
+{
+	struct cgwb_frn_wait *frn_wait = container_of(wq_entry,
+						      struct cgwb_frn_wait, wq_entry);
+
+	if (!atomic_read(&frn_wait->done.cnt)) {
+		list_del(&wq_entry->entry);
+		kfree(frn_wait);
+	}
+
+	return 0;
+}
+#endif
+
 static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
 	struct memcg_vmstats_percpu *statc;
 	struct memcg_vmstats_percpu __percpu *pstatc_pcpu;
 	struct mem_cgroup *memcg;
 	int node, cpu;
-	int __maybe_unused i;
+	int __maybe_unused i = 0;
 	long error;
 
 	memcg = kmem_cache_zalloc(memcg_cachep, GFP_KERNEL);
@@ -3763,9 +3779,17 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		memcg->cgwb_frn[i].done =
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+
+		frn->wait = kmalloc(sizeof(struct cgwb_frn_wait), GFP_KERNEL);
+		if (!frn->wait)
+			goto fail;
+
+		frn->wait->done =
 			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
+		init_wait_func(&frn->wait->wq_entry, memcg_cgwb_waitq_callback_fn);
+	}
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
@@ -3775,6 +3799,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
+#ifdef CONFIG_CGROUP_WRITEBACK
+	while (i--)
+		kfree(memcg->cgwb_frn[i].wait);
+#endif
 	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
 	return ERR_PTR(error);
@@ -3912,8 +3940,21 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	spin_lock(&memcg_cgwb_frn_waitq.lock);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct cgwb_frn_wait *wait = memcg->cgwb_frn[i].wait;
+
+		/*
+		 * Not necessary to wait for wb completion which might cause task hung,
+		 * only used to free resources. See memcg_cgwb_waitq_callback_fn().
+		 */
+		__add_wait_queue_entry_tail(wait->done.waitq, &wait->wq_entry);
+		if (atomic_dec_and_test(&wait->done.cnt)) {
+			__remove_wait_queue(wait->done.waitq, &wait->wq_entry);
+			kfree(wait);
+		}
+	}
+	spin_unlock(&memcg_cgwb_frn_waitq.lock);
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.39.5


