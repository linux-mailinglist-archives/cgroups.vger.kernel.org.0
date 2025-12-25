Return-Path: <cgroups+bounces-12729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19408CDE28F
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 00:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58FF430057C0
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F2E296BA5;
	Thu, 25 Dec 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vbIrljY9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD30292918
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766704902; cv=none; b=JifL+2m9F+z+nrIuxiPpUU/IWtH/nqssjyE3VhIAXwz6mKmQjWJK0wNXPNOHiDYR5+fO5t9L6HExHqGV9oHKwQ//oczP8wlW9zkflJOgEZxrsnLW5RvXKYSHyvGgan1SwgwODETNyHrK5rgXi4LABZ0H04I6MeJu18pFDy/uINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766704902; c=relaxed/simple;
	bh=eHc/9h6653MgzBLH8SGSWdotekhAKEDDGV2/8yjGhjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2IrAVdUqMQhmlfRyTKhDshPOMrpNzZleQBbnm3FzevRDN0HcuWB0uBucpI9pHLCbxcWIsnEhvYhLuejBxCD0S+fpHj1s63RLaXqZVlg5R/4qoNrs1g/QCxeeNsC+YG8aGcUAqCzYWrI8D13G7fgFpESGADHudhcl0I4/vwKDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vbIrljY9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766704898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNWA2wy5x9qmESizAoWxNjF5HTjl76WyG9bV89v6wkc=;
	b=vbIrljY9Mm8NiHjnoyWxvDlzPBU2XDS3DgZXbUz8CnkO/r1IXynRdZ8/R1sxe1r4/n2nhn
	grLSA4DBmRv8k2SMke7G7nnY2fKRze3XDs+LQhTS4HCHZYnjRzuCWi6jsah7qfHMH6W3nv
	sqCjwirvPFv+S3Obsz/ngB7fVRGsvVw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] memcg: mem_cgroup_get_from_ino() returns NULL on error
Date: Thu, 25 Dec 2025 15:21:11 -0800
Message-ID: <20251225232116.294540-4-shakeel.butt@linux.dev>
In-Reply-To: <20251225232116.294540-1-shakeel.butt@linux.dev>
References: <20251225232116.294540-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Change mem_cgroup_get_from_ino() to return NULL on error instead of
ERR_PTR values. This simplifies the API: NULL indicates failure, and a
valid pointer indicates success with a CSS reference held that the
caller must release via mem_cgroup_put().

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c     | 6 ++----
 mm/shrinker_debug.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e85816960e38..92beb74482fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3624,17 +3624,15 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 {
 	struct cgroup *cgrp;
 	struct cgroup_subsys_state *css;
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg = NULL;
 
 	cgrp = cgroup_get_from_id(ino);
 	if (IS_ERR(cgrp))
-		return ERR_CAST(cgrp);
+		return NULL;
 
 	css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
 	if (css)
 		memcg = container_of(css, struct mem_cgroup, css);
-	else
-		memcg = ERR_PTR(-ENOENT);
 
 	cgroup_put(cgrp);
 
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 20eaee3e97f7..8aaeb8f5c3af 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -130,7 +130,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		memcg = mem_cgroup_get_from_ino(ino);
-		if (!memcg || IS_ERR(memcg))
+		if (!memcg)
 			return -ENOENT;
 
 		if (!mem_cgroup_online(memcg)) {
-- 
2.47.3


