Return-Path: <cgroups+bounces-4-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C786C7D4394
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 02:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB73B20D43
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 00:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C9F636;
	Tue, 24 Oct 2023 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+JSA04S"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA1161
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 00:07:06 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684D010A;
	Mon, 23 Oct 2023 17:07:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9b1e3a809so24365695ad.2;
        Mon, 23 Oct 2023 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698106024; x=1698710824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVGJ5sudlybAUoU4/L69TVsLsQEiCat6/Z6vYWRvA+k=;
        b=Y+JSA04Sf/kqSiWkNzN0Xtq16jXeaD95NvJKpPq8oYpg15id/7Ndd1C3MXPI/l78dh
         aOpape3vrcSuitp6tXktXrozpbhBgxvwA3fgEiXdlptL1rX+76wcRcMzqCim/M4f6qT/
         4ihbPaMIXOGvZZwLn5o3n4X9CgFILxlCZCVqj4IzVMnAxbVFxiV305Wa/yOSWJmF2is3
         PxPKkKdLVc8wpCfGPRK0nckIOotnDkYqn5CMvW94e7h6V9u1R6ssmIIe3jy8Fril7HX/
         zLyajVYr5kNeBm0ZTX6p6pKKr8Sy4Sz6NbOB7AknxUqJmjeYVr0hVEB3xc0nXMFI9fwY
         3eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106024; x=1698710824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVGJ5sudlybAUoU4/L69TVsLsQEiCat6/Z6vYWRvA+k=;
        b=LW5iIFky0R6jzG9nitlv97r0p5baxpaD1aSXZ9f5LDxbjhnMiVbj48ZCeyx5vnN8E2
         awm+I/DGloFqFiqCHV5pgLBxOa91uJ3GTRDuzCo2ZBxpQUBQJ/E5pbnrWweDpo/8QxB7
         2NlWI9wS6YfnTGEjQ6OSaeZduAfMQjoxsKYiWjMoyVbNSU9DvIjVwhXqZ6GH/gumb+/o
         A+aWtKUxAVvAcMEQG0l85lQpG59PMKo/IM8L4CgUgCQw/Jw6tMTfrTeHnmE+OqwMRLo0
         pRvcWRofMF3lhn+ZmVrAl6CIoKrfrU4b7qoSWIPCtotwP9iZNI9IqKRdK9GHMrNxUqkr
         +kSA==
X-Gm-Message-State: AOJu0YxoPqB9S5N1AT8NZpzeKkKD/oDvyoj/B5ApOsxzyOoSMmMXYNwj
	Juk1NQZl/Ga1bpdxlef7Lqw=
X-Google-Smtp-Source: AGHT+IE7EC9NzWgKAl37wbTsKByqXoQg4bH181CdHJEGVy0sZwB5krK0Q6/inRU8TgnzAMx4IqTjzQ==
X-Received: by 2002:a17:902:ea09:b0:1c8:9d32:339e with SMTP id s9-20020a170902ea0900b001c89d32339emr8958779plg.50.1698106023659;
        Mon, 23 Oct 2023 17:07:03 -0700 (PDT)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001bc2831e1a8sm6438314plf.80.2023.10.23.17.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:07:03 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH] zswap: export more zswap store failure stats
Date: Mon, 23 Oct 2023 17:07:02 -0700
Message-Id: <20231024000702.1387130-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since:

"42c06a0e8ebe mm: kill frontswap"

we no longer have a counter to tracks the number of zswap store
failures. This makes it hard to investigate and monitor for zswap
issues.

This patch adds a global and a per-cgroup zswap store failure counter,
as well as a dedicated debugfs counter for compression algorithm failure
(which can happen for e.g when random data are passed to zswap).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/vm_event_item.h |  1 +
 mm/memcontrol.c               |  1 +
 mm/vmstat.c                   |  1 +
 mm/zswap.c                    | 18 ++++++++++++++----
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..7b2b117b193d 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -145,6 +145,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_ZSWAP
 		ZSWPIN,
 		ZSWPOUT,
+		ZSWPOUT_FAIL,
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 61c0c46c2d62..0e247e72a379 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -593,6 +593,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	ZSWPIN,
 	ZSWPOUT,
+	ZSWPOUT_FAIL,
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..85cc79449355 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1401,6 +1401,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_ZSWAP
 	"zswpin",
 	"zswpout",
+	"zswpout_fail",
 #endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
diff --git a/mm/zswap.c b/mm/zswap.c
index 37d2b1cb2ecb..38e6620f8b58 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -61,6 +61,8 @@ static u64 zswap_pool_limit_hit;
 static u64 zswap_written_back_pages;
 /* Store failed due to a reclaim failure after pool limit was reached */
 static u64 zswap_reject_reclaim_fail;
+/* Store failed due to compression algorithm failure */
+static u64 zswap_reject_compress_fail;
 /* Compressed page was too big for the allocator to (optimally) store */
 static u64 zswap_reject_compress_poor;
 /* Store failed because underlying allocator could not get memory */
@@ -1213,10 +1215,10 @@ bool zswap_store(struct folio *folio)
 
 	/* Large folios aren't supported */
 	if (folio_test_large(folio))
-		return false;
+		goto out_reject;
 
 	if (!zswap_enabled || !tree)
-		return false;
+		goto out_reject;
 
 	/*
 	 * If this is a duplicate, it must be removed before attempting to store
@@ -1309,8 +1311,10 @@ bool zswap_store(struct folio *folio)
 	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
 
-	if (ret)
+	if (ret) {
+		zswap_reject_compress_fail++;
 		goto put_dstmem;
+	}
 
 	/* store */
 	zpool = zswap_find_zpool(entry);
@@ -1377,8 +1381,12 @@ bool zswap_store(struct folio *folio)
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
-	if (objcg)
+	if (objcg) {
+		count_objcg_event(objcg, ZSWPOUT_FAIL);
 		obj_cgroup_put(objcg);
+	}
+out_reject:
+	count_vm_event(ZSWPOUT_FAIL);
 	return false;
 
 shrink:
@@ -1550,6 +1558,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_alloc_fail);
 	debugfs_create_u64("reject_kmemcache_fail", 0444,
 			   zswap_debugfs_root, &zswap_reject_kmemcache_fail);
+	debugfs_create_u64("reject_compress_fail", 0444,
+			   zswap_debugfs_root, &zswap_reject_compress_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
 	debugfs_create_u64("written_back_pages", 0444,
-- 
2.34.1


