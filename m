Return-Path: <cgroups+bounces-9448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC113B38B1E
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 22:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9821C210A5
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E961304966;
	Wed, 27 Aug 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WudlFJN1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5B277C94
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327567; cv=none; b=kgqWA8ncKrYPpjXKmrcuVhWBpMHrkZWuV2t9I9c56mma/XjUIiZIgI9aK5IfnkWSLWfqDDchJVNFeLttijQUQQJk/9ZXGWVSINJox4Yn/LNDgJ9G5Xoqm4vomeiAVu9orxnmGcUsfoNWj+XgvLNW0Otohcv2DfJiDiOvojyv9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327567; c=relaxed/simple;
	bh=9vb5K4+N5wi8OtRwPbSCjz9lRrijtsbMpOsiT3Ke+Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=st6LEvB3R62nJMad/eoira9nq1iICWwSlc0qLNKMGWQaIEJYniMKbHm+7lJHqP0UfPXXzErZnuG5ax0hXrcLm4Ma9Pk+tqznOVTqf2QciBQDVis9muPBLOOYJ723YJMk9xzC8xdEtHjrWpazgMUPz3Tu0eVIL183nmwPEPu5dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WudlFJN1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-246ef40cf93so2937455ad.0
        for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756327562; x=1756932362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tctTRzMCruhxGok80DE7/KVtROSFG+xyvfaf/L3fAFw=;
        b=WudlFJN1QLp+Ea+1cGII43d5H5S/AMmoRcb4ByQYZ1MDmNt5RCq3CvFgQaiu+O32ns
         qd4oq7lHzQ8xiNJOJWRJFk1qsFqG5dvMEhNKei5MvSMp+WxM6jqN10Z8R5TgJD9ZWoDj
         s6rgynILkCgabX6ImtlZ/lFwHNa3Fi8cD8jP5XPDXzOBY4eC8lMJxBl9XZOR/u2gOgGY
         VH2fkRXlvs8ZPSt09n+RPDQFRwnSbQ611++fOiAmn6qp2jmDyK5HDo8KW4Y1jxUDKvpS
         vzffRszzHEAjsmHuhdhsYZnbchEQGFLrtzqgHkP5B42E7Fyi80fpbcjMx9M5ggh7lC1B
         bk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756327562; x=1756932362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tctTRzMCruhxGok80DE7/KVtROSFG+xyvfaf/L3fAFw=;
        b=obfXStjbNADfjZY2oqYwtTkCrkgeMLnYdfuCcrv7ZdFKsrF4EQM9tvJfd+4in8e5rS
         Bxy/ncb86EgYSAdhTfO70r3qm94uI6AxWdDpZwLvvAlbtxdshMh5KUrDS5M3glnBBMso
         ZsLd0Sa/BT9Knew6NffFEm6Ex41vnD6EYOpStL9wpfjxqRAHRqqzCO6pIJlhMjtsGGXt
         F5FJPB8z75+OZwsk79kdMIddSUONNXzMFLpWlijIwuU2FjJhEEdknimbBs80g0xiVU7u
         wqqUHyFz/URsnjG1H/ODcKvm9YRDSI5DMwHwkcWtT7i07IQgytVcQLE+VjvuwiHuSlcm
         XIPg==
X-Gm-Message-State: AOJu0YyvIMOacfTygB82/orq3Lan9GRHbMi5img7p1iemwj5avd4kQF9
	RIgw/H2POl0mM661eApuijgHJBAn3K9JqCRDLvCvaySWTH/2T0si0LdRzPTs8Hn/9CMs4C9eab0
	NJOvBKNAR9Q==
X-Gm-Gg: ASbGnctbdC11KOCyNfUPB26+MFbwZSVG3lxZkLogA/Nysif85wOQq48pUDcb5JNa0NF
	5UR3j++VFsCMLBfw8wVMBHJvkJUweBK2RKHHeKeJ3Bzc2Vd1q6DxbwQ5S0Vbdb54K4UYIN3kt7H
	wFD9pHLyN6d8m30eaae9p/Yslns054bvbxitHi63E2skK6dMgh4m5wytph2rSyVUOg4mOEc/A+C
	DqTZJxaNCsvSe5/NlogVQWbycamUGMUxe3tgMKR+mTGtofMDvheBzs4FAnaE5CQkHnBxdFgMkxw
	Rg+QEM2Eip9xr88rLCAZBqDpT5MKCXmimuj9YnDwxWBlIG3A7CEAbQh/9YzYo6/baPbuHwjJPz/
	2wl5QMpw1rQg=
X-Google-Smtp-Source: AGHT+IGaiq+neKRguR3f2U+9fwVH5TXz+ava5fiaIEx1ae57rW8pmGVMxhPsXC8/DWaz+qI5C70qiQ==
X-Received: by 2002:a17:902:d4cf:b0:246:d769:2fe7 with SMTP id d9443c01a7336-246d76933b2mr167232345ad.28.1756327561528;
        Wed, 27 Aug 2025 13:46:01 -0700 (PDT)
Received: from localhost ([101.82.184.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24898a617d0sm26044805ad.15.2025.08.27.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:46:01 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: jack@suse.cz,
	tj@kernel.org,
	muchun.song@linux.dev
Subject: [PATCH v4] memcg: Don't wait writeback completion when release memcg.
Date: Thu, 28 Aug 2025 04:45:57 +0800
Message-Id: <20250827204557.90112-1-sunjunchao@bytedance.com>
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
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
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


 include/linux/memcontrol.h |  7 ++++-
 mm/memcontrol.c            | 53 ++++++++++++++++++++++++++++++++------
 2 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..b16bc4bd0ad0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -157,11 +157,16 @@ struct mem_cgroup_thresholds {
  */
 #define MEMCG_CGWB_FRN_CNT	4
 
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
index 8dd7fbed5a94..80257dba30f8 100644
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
@@ -3912,8 +3940,17 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct cgwb_frn_wait *wait = memcg->cgwb_frn[i].wait;
+
+		/*
+		 * Not necessary to wait for wb completion which might cause task hung,
+		 * only used to free resources. See memcg_cgwb_waitq_callback_fn().
+		 */
+		__add_wait_queue_entry_tail(wait->done.waitq, &wait->wq_entry);
+		if (atomic_dec_and_test(&wait->done.cnt))
+			wake_up_all(wait->done.waitq);
+	}
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.39.5


