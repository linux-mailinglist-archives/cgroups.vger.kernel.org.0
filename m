Return-Path: <cgroups+bounces-4299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4119F9528C1
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 07:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5292B250FE
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 05:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1AA824A0;
	Thu, 15 Aug 2024 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OMht0cRZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323C7F490
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698337; cv=none; b=Kl8fEvlp1VvwRUO+94VsK9RX7gSaNHZGCX7pHt8FAsPjxBcjG8j0OXsNwqi633VO/mMBQ0Lak/FR23SqRJLFyadL4zfa4XTwVcjSlRwB0WumNSFX/adOX2tN9B84CmE9o7zGYCm5GhxYO4BtP75b6jWgEXXVyVaI1ft5hbGE5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698337; c=relaxed/simple;
	bh=zFE4G806fFJ52Ft927pA2boryb14lrlyPdHnh3xoZJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exAqVM6WDpjzKzRO+tsP33a8zMsvV7yMe7ZbZ6SosGCuICoAFB6Jrzc5wDPw+N/YadAjBecc2MDOF068RRVlgOO3h55YIfnd4zi9MPUYjFY0brOsF8AFED5ey840JbpXzVAl19jAeEFvNbCPkdFxmxAnhrRIr69E12GH5PH1eaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OMht0cRZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBl+yNWVDTrBvPczXHA6yxAB2QIqH+IAeny01+DfM7g=;
	b=OMht0cRZt5CcDvh+ZY+LOgDLFGiDcR3YmhPy5UbQyi0DzGomb5EhU8GsdkP452q20TOv1z
	t+sdwOObMDH8uPitMzDC/boZ97f+rQ5TZcmRIq9RbN3yTFNZ5QEIEpHnAt2hD1ZbzSVGBv
	4U5zzA23HbLNZpDzNDuvZZfoaBgON4I=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 5/7] memcg: make v1 only functions static
Date: Wed, 14 Aug 2024 22:04:51 -0700
Message-ID: <20240815050453.1298138-6-shakeel.butt@linux.dev>
In-Reply-To: <20240815050453.1298138-1-shakeel.butt@linux.dev>
References: <20240815050453.1298138-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The functions memcg1_charge_statistics() and memcg1_check_events() are
never used outside of v1 source file. So, make them static.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol-v1.c | 7 +++++--
 mm/memcontrol-v1.h | 6 ------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index ffb7246b3f35..0589d08c1599 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -742,6 +742,9 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
 	return folio_file_page(folio, index);
 }
 
+static void memcg1_check_events(struct mem_cgroup *memcg, int nid);
+static void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
+
 /**
  * mem_cgroup_move_account - move account of the folio
  * @folio: The folio.
@@ -1439,7 +1442,7 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
 	}
 }
 
-void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
+static void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
 {
 	/* pagein of a big page is an event. So, ignore page size */
 	if (nr_pages > 0)
@@ -1484,7 +1487,7 @@ static bool memcg1_event_ratelimit(struct mem_cgroup *memcg,
  * Check events in order.
  *
  */
-void memcg1_check_events(struct mem_cgroup *memcg, int nid)
+static void memcg1_check_events(struct mem_cgroup *memcg, int nid)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		return;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 376d021a2bf4..0a9f3f9c2362 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -115,9 +115,6 @@ bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
 void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
 void memcg1_oom_recover(struct mem_cgroup *memcg);
 
-void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
-void memcg1_check_events(struct mem_cgroup *memcg, int nid);
-
 void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
 void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg);
 void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
@@ -152,9 +149,6 @@ static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) {
 static inline void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked) {}
 static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
 
-static inline void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages) {}
-static inline void memcg1_check_events(struct mem_cgroup *memcg, int nid) {}
-
 static inline void memcg1_commit_charge(struct folio *folio,
 					struct mem_cgroup *memcg) {}
 
-- 
2.43.5


