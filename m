Return-Path: <cgroups+bounces-930-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F568107C3
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 02:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8351F21C4F
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073E9EB8;
	Wed, 13 Dec 2023 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHLzrZun"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A32D5;
	Tue, 12 Dec 2023 17:38:50 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ba10647a19so1859136b6e.3;
        Tue, 12 Dec 2023 17:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702431529; x=1703036329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjbQsD2zw+AVOTOAO2gfbyL0vE9tzy1c44w2jRTtXIc=;
        b=WHLzrZunC8cATHiUYn8D8eRS3C9cwhfVmuPw5KeTC3zRyOIbvI1ERwrBKmmdTvQx5y
         D1lwqAA1Vv6K897KAMWcU3qO7aSa6f78EJv5eLxnLPWT3Rs93OiCryY+jHfQ9KDbn6n9
         nt2u+A6bpdOS4SvUnka4m20YgH3UEw3UMTKfG7cCic4m09sn0+2f8e72BqudPiw3Hhh8
         k/0vzhCdwCaX8t8BKQYMC8D1d/WdKkWmxeoQJlXIibezwNZs4PMbwnrfNbCx7TnvzT9z
         3CDD00YRdOX1fDWSJJ+GYofbjrkpzJSkDVvViWru07xTNPicfGPOJ9X21LiZ8AYnlrWP
         JRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431529; x=1703036329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjbQsD2zw+AVOTOAO2gfbyL0vE9tzy1c44w2jRTtXIc=;
        b=RpHFdqe6r4CH15vRGpqSDCt2xM2FrO4ubllxqLyHmW/rd0RmX+B5RbKdraiH3wMq7k
         Jcn5UEUF8ghIGc16dkdIywOHJYTlKcxXd5qzTk0NJiLs0pUEtHx2wa4QHXsu+9mhDCZj
         hWrM86+eWpqf6cxEWk2L29UD9grnzyeZXBZoM25csFM62XRYerXml4Shcgn2rNIgHzzF
         JFr7QZLgypjREfBqS9dgodpcajiRs5yo1eeYldJrDns3NYC6DFg86BTyT+32wYkL54yR
         /wTZPccI+FWSKRotcB1+1XfSfQD2D+BjmZtF6jGN3jlnoR70hEN4+YO6Ysk9cW0vWX63
         5UQQ==
X-Gm-Message-State: AOJu0Yy3drsKXisipyZDWPP2f/Jwx45ANtpF8XTgT1QgGSK09pDQOxU2
	mE5UFS16MwOOnhKdgVllTz4=
X-Google-Smtp-Source: AGHT+IGgXLdoPr2KB+fyLYZzAHHRmPQQCEoDPHrM7vuygKI9CqqksVCR1GKYIffLffbC2ftpntZpnA==
X-Received: by 2002:a05:6808:16a4:b0:3b8:b063:6bae with SMTP id bb36-20020a05680816a400b003b8b0636baemr8604954oib.93.1702431529213;
        Tue, 12 Dec 2023 17:38:49 -0800 (PST)
Received: from localhost ([2620:10d:c090:500::7:1c76])
        by smtp.gmail.com with ESMTPSA id u23-20020a62d457000000b006ce781f6f85sm9148130pfl.43.2023.12.12.17.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:38:48 -0800 (PST)
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
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH V4 1/2] mm: add defines for min/max swappiness
Date: Tue, 12 Dec 2023 17:38:02 -0800
Message-Id: <20231213013807.897742-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213013807.897742-1-schatzberg.dan@gmail.com>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
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
 mm/vmscan.c          | 10 +++++-----
 3 files changed, 8 insertions(+), 6 deletions(-)

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
index 1c1061df9cd1..9748a6b88bb8 100644
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
index 506f8220c5fe..2aa671fe938b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
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
@@ -4444,7 +4444,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 		type = LRU_GEN_ANON;
 	else if (swappiness == 1)
 		type = LRU_GEN_FILE;
-	else if (swappiness == 200)
+	else if (swappiness == MAX_SWAPPINESS)
 		type = LRU_GEN_ANON;
 	else
 		type = get_type_to_scan(lruvec, swappiness, &tier);
@@ -5368,9 +5368,9 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 
 	lruvec = get_lruvec(memcg, nid);
 
-	if (swappiness < 0)
+	if (swappiness < MIN_SWAPPINESS)
 		swappiness = get_swappiness(lruvec, sc);
-	else if (swappiness > 200)
+	else if (swappiness > MAX_SWAPPINESS)
 		goto done;
 
 	switch (cmd) {
-- 
2.34.1


