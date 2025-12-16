Return-Path: <cgroups+bounces-12382-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726ECC531F
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5016300252E
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 21:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E11A2F1FE4;
	Tue, 16 Dec 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ey6woMYF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE018BC3D
	for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920076; cv=none; b=YsSExh9jCtAst7S9Glge/H6IPg1Lbp4nNpsCSfvnDrXl0UEZAXdYqxm9uwhKYUw7mJ0wifDYYF/u6TOe0LB3yoQEzkl/5kr/NOeMQagiDRbxTqXewKxuSWYaxf9b6kXcMuv5wpRwcppN3ImILmHXp6PbU5bO0/C09oE1N2n+TkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920076; c=relaxed/simple;
	bh=8Xo+YlPqEZ2Y1elD3Kdie3P6r3c7tGNOIT866GNXXd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRXTLSFy6qSYzftYkWonTMC/bc89EAqUVH9FSRnWljcTzyP+Wv+WzfaL3Esf3sqi+IpXUn26dG7FPw7/dfSPJcQO47iDcnK2OtGukyKypovYxNaXFggJXha7W8JH34iAM5jsSSaBZjpqN8a4ZtnqDhKJo1vl1YnXjt5Et2uZbq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ey6woMYF; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765920067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZfOZ1kb7S1+OirlSYPDDjGrFljxGcHFaYN634TXPH08=;
	b=ey6woMYFLSuMSGJ1GMOKxV+l8NVP/+hqcWLToOCCN8rcLfAqLUsKHsuJRwZ3uujYyzJ+6J
	lZYR2kyyxmQ9XQWq2j1kzCRssuqMk0y2gA/0F8U9allCiqWgajBlM8r99+6pDuBt41blWU
	RGOISzMUDyPXqnXzHwJrh8fqrbDeYZ0=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>
Subject: [PATCH] mm: memcg: fix unit conversion for K() macro in OOM log
Date: Tue, 16 Dec 2025 13:20:54 -0800
Message-ID: <20251216212054.484079-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit bc8e51c05ad5 ("mm: memcg: dump memcg protection info on oom
or alloc failures") added functionality to dump memcg protections on OOM
or allocation failures. It uses K() macro to dump the information and
passes bytes to the macro. However the macro take number of pages
instead of bytes. It is defined as:

 #define K(x) ((x) << (PAGE_SHIFT-10))

Let's fix this.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Chris Mason <clm@fb.com>
Fixes: bc8e51c05ad5 ("mm: memcg: dump memcg protection info on oom or alloc failures")
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e2e49f4ec9e0..6f000f0e76d2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5638,6 +5638,6 @@ void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
 		memcg = root_mem_cgroup;
 
 	pr_warn("Memory cgroup min protection %lukB -- low protection %lukB",
-		K(atomic_long_read(&memcg->memory.children_min_usage)*PAGE_SIZE),
-		K(atomic_long_read(&memcg->memory.children_low_usage)*PAGE_SIZE));
+		K(atomic_long_read(&memcg->memory.children_min_usage)),
+		K(atomic_long_read(&memcg->memory.children_low_usage)));
 }
-- 
2.47.3


