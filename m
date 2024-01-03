Return-Path: <cgroups+bounces-1061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD54E823181
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 17:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30132287363
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA51C68F;
	Wed,  3 Jan 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqBfK335"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D051BDE3;
	Wed,  3 Jan 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbe87cbc052so1500964276.2;
        Wed, 03 Jan 2024 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704300555; x=1704905355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwZZYWh+e0yk/cuTVxoiseyhi+aiBF9zz0tdKJ/4vMs=;
        b=kqBfK335h0wkxsSw38j2vQvPlktEv1Gwb5XiT31bJjqgMFS1/CQFoVOn4Q4PrqBoBt
         hfx1ntKGVABM1TPc5ZytAv5lMuHE3U46OfpHlW0uCM2JI5whZoMLGu4KQoRN+m6DB2X0
         urw9plMiz9AaoUYFlegISzmVJ3aIDansCn3g+T56g405Kw6EQxmeNMkedwL0uaunbm9R
         yayCKzCiqW+AEkTeOPqUaRX/wSaHVKQF904+5pX9ImQzyGXwMjPCUuAH4H2XDN+MR3ul
         lBdNNwrOggTQt7NK/SSbYabhCBSD+MYhpgETJqtFsEk8ncBMuzYNUCzVTiPGHG/mPofe
         Gxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300555; x=1704905355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwZZYWh+e0yk/cuTVxoiseyhi+aiBF9zz0tdKJ/4vMs=;
        b=NqBgC2vm4DkgGJTSjk/ChPzKsbftIGsYg5sV2QnvTFkcQF+qG348xEjgTCPjwrpeY7
         HmAhhSppo2QaolVal+5POCp8lXhB2TiHPLmxiYcd0vNgSmDFMCY2lXT5kCb3/ZHqNMWD
         QTE+4Lj+ofX1plOdS206ROpw37xWm090o/R+/Tx8fRUrjK+M2TI2j0EslORTOMD4sDKX
         kZda8deF3ZlToCUHAg5CH8lpMDsya97XAE+rQP10KxdB0Yz99c6kIvg/upX2jJYN2yiW
         8ZpY21Kw7rZruHU+FsGST+ypaiQ1v1/BuT8Sxl1zlIeT8HHogFYDRIQAXKwrfDh5B0li
         xlqg==
X-Gm-Message-State: AOJu0YwqcM7QNoHODPPjrrqiQV8Gjl2+so9+oz03g52tithIqdEaZQ5i
	31+JjOms3sDsIcIbOGF83sE=
X-Google-Smtp-Source: AGHT+IGe4cxlLsn+e6P2JdgSr5WbR+2RuPxygGamlYxVp3FhQSYsh7zg529zAFbjlkOVWnvfCaAsxw==
X-Received: by 2002:a25:ef52:0:b0:dbe:a003:a24a with SMTP id w18-20020a25ef52000000b00dbea003a24amr971520ybm.56.1704300555318;
        Wed, 03 Jan 2024 08:49:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:fcab])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05622a260a00b00427f1eeddccsm7362030qtb.38.2024.01.03.08.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:49:15 -0800 (PST)
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	David Rientjes <rientjes@google.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 1/2] mm: add defines for min/max swappiness
Date: Wed,  3 Jan 2024 08:48:36 -0800
Message-Id: <20240103164841.2800183-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
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
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
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


