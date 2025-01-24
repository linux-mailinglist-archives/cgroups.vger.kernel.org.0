Return-Path: <cgroups+bounces-6254-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F9A1AF70
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 05:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD65B3ACCB4
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 04:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569591D6DBB;
	Fri, 24 Jan 2025 04:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ahOTj5zq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B4A29
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693554; cv=none; b=qbFQiZrMCiSjRkoljyBAh0nrHHUE6JcfVaWRc/xCpN/y1SW1WzrubIID1V9qAPlKgmEshQLqU60dwQ6JVsoYr1o/0qtuVXZfoOsSaxwI3lLF/FISkLGkpV08/U7zXNqrHXjFYRfSkaurMBMM6bGoRFb+W9YlG1+INUvGJyHQN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693554; c=relaxed/simple;
	bh=PXg73LuFiGEKAa7Mt9lCJeMONLDawGYG3u6NrvTqFlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKVcDbageZulTtit/c99gynTslgCHw2MvvSP/CixfGvK4CLfU/0OE6BbVb10L4ck2lao4tYjNjnFSW1VjEZAIIZBSt4oeDHcHs6L7l+cf98hhYFTj8JDqCFPejf8HSBb06h2XdnlklbBRbx5zl6kMVm26gUpBSycHizBwEwA5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ahOTj5zq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d88cb85987so15868886d6.1
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 20:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737693550; x=1738298350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LA98XB9LYD/MipEPJEpEr2dcKbFDev2YEJD5nlY7UfU=;
        b=ahOTj5zq7WwXza76foPFPSTVQR7xim6MWJSkXCzanL5ZHlC1TCLZxIGVHZtLl3uGQn
         ZFAagHRq/ycYRRyoptTQbyPfCyOVZ6Wrg9qosq5ENn4+V9PpZB7Jotgnsl7km2wr7HR4
         1MWfPqyGMajPOznouxhhGdUdMoob4ZB+mKKSs6/5WFnPJw1T8Gz+wRmw85CmrOmuBubj
         jteOtnQ9/h3nW+TahxKnQUf9C+GHTgBIu8M/2FVzyR4a9KqPifvt3QOrETtWt5QPvFRd
         KyDLvk+3lhzRvcbY5xmdkw/XR54qjA3UkOPIj249bvYG9aj8l5UtuRrlS0CHn/DXY82T
         oESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737693550; x=1738298350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA98XB9LYD/MipEPJEpEr2dcKbFDev2YEJD5nlY7UfU=;
        b=uxD/pjOFrr1tBk0knFh8bPlUYWFeDGse9ycLk9RKcvq53mKMlrFY+Lx3hBqePB/0Ho
         h9jGhysqWhs7JG7f6PXhX93D0XxORqL5tML5XwMF9agPMK6nVS/xDr24qxC9swuI9Kt3
         MjzoJo1b7XO7vgxzxCZbzfZ6lUQpMCZdR1Q6qAvjdEkjaXfTtbBi0F/OGUW/ORH5k/04
         uFC7qP6iYbBZeNa7/vQd4b/mCjJyGsBearb1YULboReMeoW20tNSSy/CD3Rm9l50j+t5
         lueV3/mqT+GkYCSFEog4tBDcxPvJTeoxDMA+3YAd6SlUZrzzFpSZiDmz+GndIOasdWsz
         U28Q==
X-Forwarded-Encrypted: i=1; AJvYcCU95FuNu6PtLskNrSvFlGdQ+C4q60fF1mBnGaDa2XYpnK4ixUwKUuDwJWWkQ2da/H+/LJkxNZ3I@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gMATm/GQRvYAoBr+z8b1NkiAYzijioBQa/kZxv5+cWUPRzZx
	MdmeIDwna3fcTw3zYKqQQbUHQjw1oL1yoXM1i+sTfsmCJxKprwazhTroIVVUirA=
X-Gm-Gg: ASbGncsTzFpfMl83TZ1sGUZLkECbLAwdz0w8gIm7VQzVUCVl5/Sn7H3KegKHGne+5/H
	oZGmiG5zWjOacdT9dyBQYJk/28vNu95bhS4uNNSrGwzklpCreNdJS1cR1lZ59ft/iSVD67rNPrM
	+xsEw1V1D5q35GEGWsgsbSUSvdrplb5lnkMQzD+RCMEjftIDzkqlpEgBGAbPSyRGfVvMyVtwtqh
	N9EBzujIy8r70ozU2kH+Wl//qx2SrlL1PZJSxgF7D3xK1ipKzFPqxRWExizi5XGGXJUdvphOynp
	R0s=
X-Google-Smtp-Source: AGHT+IFNV83+n81ZC7OSsymBf3rQHfUmDNRkj6S/SLoyQgdTGlbAJ2mV0G99gsb8+lXqSCYHJomFEA==
X-Received: by 2002:ad4:5d4a:0:b0:6d9:2f70:2dab with SMTP id 6a1803df08f44-6e206253519mr36862156d6.16.1737693550460;
        Thu, 23 Jan 2025 20:39:10 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e2058c2b76sm5148046d6.107.2025.01.23.20.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 20:39:09 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: memcontrol: unshare v2-only charge API bits again
Date: Thu, 23 Jan 2025 23:38:58 -0500
Message-ID: <20250124043859.18808-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6b611388b626 ("memcg-v1: remove charge move code") removed the
remaining v1 callers.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol-v1.h | 15 ---------------
 mm/memcontrol.c    | 17 +++++++++++++----
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 144d71b65907..6dd7eaf96856 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -7,21 +7,6 @@
 
 /* Cgroup v1 and v2 common declarations */
 
-int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
-		     unsigned int nr_pages);
-
-static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-			     unsigned int nr_pages)
-{
-	if (mem_cgroup_is_root(memcg))
-		return 0;
-
-	return try_charge_memcg(memcg, gfp_mask, nr_pages);
-}
-
-void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
-void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
-
 /*
  * Iteration constructs for visiting all cgroups (under a tree).  If
  * loops are exited prematurely (break), mem_cgroup_iter_break() must
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46f8b372d212..818143b81760 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2198,8 +2198,8 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	css_put(&memcg->css);
 }
 
-int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
-		     unsigned int nr_pages)
+static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
+			    unsigned int nr_pages)
 {
 	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MAX_RECLAIM_RETRIES;
@@ -2388,6 +2388,15 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 }
 
+static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
+			     unsigned int nr_pages)
+{
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
+	return try_charge_memcg(memcg, gfp_mask, nr_pages);
+}
+
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
 	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
@@ -3368,13 +3377,13 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 	}
 }
 
-void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
+static void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
 					   unsigned int n)
 {
 	refcount_add(n, &memcg->id.ref);
 }
 
-void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
+static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
 {
 	if (refcount_sub_and_test(n, &memcg->id.ref)) {
 		mem_cgroup_id_remove(memcg);
-- 
2.48.1


