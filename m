Return-Path: <cgroups+bounces-981-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875F81A26A
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF961C20B75
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0C3FB32;
	Wed, 20 Dec 2023 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykz4Zk4Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862B4175F;
	Wed, 20 Dec 2023 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bb7344a0e1so348800b6e.0;
        Wed, 20 Dec 2023 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703086028; x=1703690828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59LZCmYd65g0ypkperKKK/kJ8MVLAq87LEnhd0/0rRY=;
        b=Ykz4Zk4YQCBbpgt+DJNn1KXxw74vJqW17rwIKaS2Ws5AXcEFPvuKkKA0iHAQDoPDxA
         35cgr2MFrOCMmQfmLUVb1WZfLg24rg9cOOOCU7vg8Oc9F5/nlM7zJOrrUay1OZmLcT1R
         Z76Rv4OicwSD2r94CEY/uJiXx3AVPueBsUcUyBacmwF06Q1gz9O83zZCYoq7FJrCtcx/
         N6nfIIPqEa4SRYaOcllQMP/SIvQsyWzkHZXSXkIBK+C7EW8a/omF7OJ1Ci0YAK5cEkcG
         xgif4TmwxscsLWlxlaq9oDUSpuT5Z8vmosiJ/qZa3HyNc+cA8FymStl8ERBdm8OHuFGU
         9rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086028; x=1703690828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59LZCmYd65g0ypkperKKK/kJ8MVLAq87LEnhd0/0rRY=;
        b=TH6a/mkriBF3A5LboMpQDERUgaVtKM2dJjpuihPr78tcCJ18AFiy4ad6/EvHlsFn66
         d7rPy9JpNkEUU3d15nI9/nXDaMrVoy27Y1GwKubgOsKjxzb+KQCke9ZW/NfCiFRX28t8
         HTGdmh6nb6s7A8K7wPJjvrG64wMRbyDZ9oDBdY+zxlDW8DS3gGPJcv6NLqEyDq2utlzg
         fNs2PVWir+ZJAfQbpI7WtgO+bMSqwIsdLxgO/+d1g6ML5Szf2YjJ9T9ZrGFMEbOPW1V3
         CI1d4FTwmPBvQW0rf3rctSLt/YIMlKS/e0BUB7NSgKJks1IVPWUNuhERqpoRlqG0PNaA
         oQUw==
X-Gm-Message-State: AOJu0YyZXx5i6p5O6xJuW3EsEPWJ3sHHQnKY/mxMYOBs5crtif0XvFPJ
	7E7AAeAaGu6DUdqJ6RBm7Byss4VHs4Eb5Q==
X-Google-Smtp-Source: AGHT+IH48x/lOXdg5JUxZV/lLg8CrWcbuR3qeufJmbXflf5jebTrUVeALmaxLuoHMFc2j402sC1Y/A==
X-Received: by 2002:a05:6808:16a0:b0:3bb:535d:27ed with SMTP id bb32-20020a05680816a000b003bb535d27edmr4751625oib.86.1703086027982;
        Wed, 20 Dec 2023 07:27:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:1124])
        by smtp.gmail.com with ESMTPSA id k4-20020ad44504000000b0067f6a9a446esm743093qvu.136.2023.12.20.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:27:07 -0800 (PST)
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Huan Yang <link@vivo.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Yue Zhao <findns94@gmail.com>
Subject: [PATCH v5 1/2] mm: add defines for min/max swappiness
Date: Wed, 20 Dec 2023 07:26:50 -0800
Message-Id: <20231220152653.3273778-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use the constants 0 and 200 in a few places in the mm code when
referring to the min and max swappiness. This patch adds MIN_SWAPPINESS
and MAX_SWAPPINESS #defines to improve clarity. There are no functional
changes.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 include/linux/swap.h |  2 ++
 mm/memcontrol.c      |  2 +-
 mm/vmscan.c          | 14 +++++++-------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f6dd6575b905..e2ab76c25b4a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -407,6 +407,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
+#define MIN_SWAPPINESS 0
+#define MAX_SWAPPINESS 200
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b226090fd906..fbe9f02dd206 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4337,7 +4337,7 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	if (val > 200)
+	if (val > MAX_SWAPPINESS)
 		return -EINVAL;
 
 	if (!mem_cgroup_is_root(memcg))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9dd8977de5a2..d91963e2d47f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -183,7 +183,7 @@ struct scan_control {
 #endif
 
 /*
- * From 0 .. 200.  Higher means more swappy.
+ * From 0 .. MAX_SWAPPINESS.  Higher means more swappy.
  */
 int vm_swappiness = 60;
 
@@ -2403,7 +2403,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	ap = swappiness * (total_cost + 1);
 	ap /= anon_cost + 1;
 
-	fp = (200 - swappiness) * (total_cost + 1);
+	fp = (MAX_SWAPPINESS - swappiness) * (total_cost + 1);
 	fp /= file_cost + 1;
 
 	fraction[0] = ap;
@@ -4400,7 +4400,7 @@ static int get_type_to_scan(struct lruvec *lruvec, int swappiness, int *tier_idx
 {
 	int type, tier;
 	struct ctrl_pos sp, pv;
-	int gain[ANON_AND_FILE] = { swappiness, 200 - swappiness };
+	int gain[ANON_AND_FILE] = { swappiness, MAX_SWAPPINESS - swappiness };
 
 	/*
 	 * Compare the first tier of anon with that of file to determine which
@@ -4436,7 +4436,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	/*
 	 * Try to make the obvious choice first. When anon and file are both
 	 * available from the same generation, interpret swappiness 1 as file
-	 * first and 200 as anon first.
+	 * first and MAX_SWAPPINESS as anon first.
 	 */
 	if (!swappiness)
 		type = LRU_GEN_FILE;
@@ -4444,7 +4444,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 		type = LRU_GEN_ANON;
 	else if (swappiness == 1)
 		type = LRU_GEN_FILE;
-	else if (swappiness == 200)
+	else if (swappiness == MAX_SWAPPINESS)
 		type = LRU_GEN_ANON;
 	else
 		type = get_type_to_scan(lruvec, swappiness, &tier);
@@ -5398,9 +5398,9 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 
 	lruvec = get_lruvec(memcg, nid);
 
-	if (swappiness < 0)
+	if (swappiness < MIN_SWAPPINESS)
 		swappiness = get_swappiness(lruvec, sc);
-	else if (swappiness > 200)
+	else if (swappiness > MAX_SWAPPINESS)
 		goto done;
 
 	switch (cmd) {
-- 
2.39.3


