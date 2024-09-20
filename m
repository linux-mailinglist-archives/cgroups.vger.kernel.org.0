Return-Path: <cgroups+bounces-4923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E8897DA84
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 00:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B61F21D2D
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA407183CD2;
	Fri, 20 Sep 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="EbzqwpbR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB41607AA
	for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726870377; cv=none; b=PNRoeWu2sCSYQMQsdaIYqjWNtXGiS8Kjj6LzQ2GExZGcqE3I2gnJtXqEusyq1JtexRD4TEZ52DH8whS8SR0upw9A1qBq8Zu+EitUTq9yRXj2IZe0INtwqfH8LBOAxDjj8BrujpQLtyvor4WhtkGYxJZ40rVloYcsc8dUQaR+WiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726870377; c=relaxed/simple;
	bh=eM10iEwBiHwEwuC51ss44oToq72kJXV0u+FjpWgae2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJtyxwpXGXXe4gr+fhs1tnfqpQATv6/f5tlNHMacvGAi8xe0T3pfAjeYTlSOMmX+3FvUUbv1GJbbdEg3wDkFOCMXv+tQHUmiFakSZEwXDgGS1+fMWToVLghT10EMq/PQL/ooeM+d1nC6Pp9SK3uYEyDHhBycaXYMhkGDQcb7LIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=EbzqwpbR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c35b72f943so22057026d6.0
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1726870374; x=1727475174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TftwzflgOcr42nYSagxxE5NRGUcR+2wBAeOf9BrcIxs=;
        b=EbzqwpbRYbKYbUCDs1FVuaFBlYCFBoI3V/ES0WIge2AQQaKR0640xesn5stc5+aBIF
         BobTseYVfQ3VkpBCDW8kTevO+e9Ru987Bp5Ye+/wJbP09foUeGaTUVuDxPy0Bb6Z2S1c
         5/qgkjV07ChxJ0NV/hc4fxbbIHwoQ8cxBs1U+rVZDMLzbWbzPQJK8AYMYy4pMp7ih7mO
         A+n7BSUtX9tjI6+F3+fUpJ/KcOPf4IVJ8BJakhRIf+t+A3PrAb2FEMRgLq53SMgjl23w
         wUNXn1R7y5wGmqrOWb/3YKW4Vix8/AzwHJZULzMMulbOGY1dq/Jl/ld9aG8fyc2KxL1f
         xOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726870374; x=1727475174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TftwzflgOcr42nYSagxxE5NRGUcR+2wBAeOf9BrcIxs=;
        b=d1LznYyZV7DpQxMgdI6xZ0G+Z8vODWYuliLwtrs8kSSqyGGsECOM2QEGSr7INu1nEJ
         RXkO4arOLQjKJAgmWQx9s92NE8RjX1x2sKbn7/n6SdSUk9lPN/Ha/5pb/uugxOnhchVV
         QwchSX3LWxQvYD8/kM8AtptBtD3pZNBkDAXfov6D0u+Z73tYTzFnYOtd24ntVemw2mUE
         KqwxQ5o7Od3XxWVnSWYBY/6ASBlX0SxTGUelfPb56UpqNBsJ2QpUpvlVMj1KPFHyHKK/
         hthV2hs80KjT+0HTbaTH3U/5oOEdA4uolxJxuiYpbigsjeMqWh6I4tALN8/iySyxw452
         SCNg==
X-Forwarded-Encrypted: i=1; AJvYcCW+B5LVgt+PwB9HEfzaVghyGMBeRfL7aVCycfEpZShEZr9dMSloNQEWLXUL4oCVQ0NpFCvrYJ+V@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOxAj5sb6ySOQFFiEuhgqwH78ghourV6KVspnYrUikmcZcmv3
	qlUMU4fmyo1QfHgwSeFXubXkUwmCV5fD61fTeM8cnQ6e1fmB3Meuj8ol3XUh1A==
X-Google-Smtp-Source: AGHT+IHikCGCO6wkPfPxYljfcKXf0g1rNsuHaxXCKqPX29rklo2k6jfuFPREyFGdHgTgjVFsYh9NRQ==
X-Received: by 2002:a05:6214:419d:b0:6c5:1f00:502f with SMTP id 6a1803df08f44-6c7bb99bc41mr64018646d6.2.1726870374456;
        Fri, 20 Sep 2024 15:12:54 -0700 (PDT)
Received: from localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6c75e557c5csm23290296d6.82.2024.09.20.15.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 15:12:54 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	hannes@cmpxchg.org,
	weixugc@google.com,
	rientjes@google.com,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Subject: [RFC PATCH 4/4] reduce NUMA balancing scan size of cgroups over their local memory.low
Date: Fri, 20 Sep 2024 22:11:51 +0000
Message-ID: <20240920221202.1734227-5-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
References: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

When the top-tier node has less free memory than the promotion watermark,
reduce the scan size of cgroups that are over their local memory.low
proportional to their overage. In this case, the top-tier memory usage
of the cgroup should be reduced, and demotion is working towards the
goal. A smaller scan size should cause a slower rate of promotion for
the cgroup so as to not working against demotion.

A mininum of 1/16th of sysctl_numa_balancing_scan_size is still allowed
for such cgroups because identifying hot pages trapped in slow-tier is
still a worthy goal in this case (although a secondary objective).
16 is arbitrary and may need tuning.

Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
---
 kernel/sched/fair.c | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a1b756f927b2..1737b2369f56 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1727,14 +1727,21 @@ static inline bool cpupid_valid(int cpupid)
  * advantage of fast memory capacity, all recently accessed slow
  * memory pages will be migrated to fast memory node without
  * considering hot threshold.
+ * This is also used for detecting memory pressure and decide whether
+ * limitting promotion scan size is needed, for which we don't requrie
+ * more free pages than the promo watermark.
  */
-static bool pgdat_free_space_enough(struct pglist_data *pgdat)
+static bool pgdat_free_space_enough(struct pglist_data *pgdat,
+						bool require_extra)
 {
 	int z;
 	unsigned long enough_wmark;
 
-	enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
-			   pgdat->node_present_pages >> 4);
+	if (require_extra)
+		enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
+				pgdat->node_present_pages >> 4);
+	else
+		enough_wmark = 0;
 	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
 		struct zone *zone = pgdat->node_zones + z;
 
@@ -1846,7 +1853,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		unsigned int latency, th, def_th;
 
 		pgdat = NODE_DATA(dst_nid);
-		if (pgdat_free_space_enough(pgdat)) {
+		if (pgdat_free_space_enough(pgdat, true)) {
 			/* workload changed, reset hot threshold */
 			pgdat->nbp_threshold = 0;
 			return true;
@@ -3214,10 +3221,14 @@ static void task_numa_work(struct callback_head *work)
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
-	long pages, virtpages;
+	long pages, virtpages, min_scan_pages;
 	struct vma_iterator vmi;
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
+	struct pglist_data *pgdat = NODE_DATA(0);  /* hardcoded node 0 */
+	struct mem_cgroup *memcg;
+	unsigned long cgroup_size, cgroup_locallow;
+	const long min_scan_pages_fraction = 16; /* 1/16th of the scan size */
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -3262,6 +3273,39 @@ static void task_numa_work(struct callback_head *work)
 
 	pages = sysctl_numa_balancing_scan_size;
 	pages <<= 20 - PAGE_SHIFT; /* MB in pages */
+
+	min_scan_pages = pages;
+	min_scan_pages /= min_scan_pages_fraction;
+
+	memcg = get_mem_cgroup_from_current();
+	/*
+	 * Reduce the scan size when the local node is under pressure
+	 * (WMARK_PROMO is not satisfied),
+	 * proportional to a cgroup's overage of local memory guarantee.
+	 * 10% over: 68% of scan size
+	 * 20% over: 48% of scan size
+	 * 50% over: 20% of scan size
+	 * 100% over: 6% of scan size
+	 */
+	if (likely(memcg)) {
+		if (!pgdat_free_space_enough(pgdat, false)) {
+			cgroup_size = get_cgroup_local_usage(memcg, false);
+			/*
+			 * Protection needs refreshing, but reclaim on the cgroup
+			 * should have refreshed recently.
+			 */
+			cgroup_locallow = READ_ONCE(memcg->memory.elocallow);
+			if (cgroup_size > cgroup_locallow) {
+				/* 1/x^4 */
+				for (int i = 0; i < 4; i++)
+					pages = pages * cgroup_locallow / (cgroup_size + 1);
+				/* Lower bound to min_scan_pages. */
+				pages = max(pages, min_scan_pages);
+			}
+		}
+		css_put(&memcg->css);
+	}
+
 	virtpages = pages * 8;	   /* Scan up to this much virtual space */
 	if (!pages)
 		return;
-- 
2.43.0


