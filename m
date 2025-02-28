Return-Path: <cgroups+bounces-6739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB802A49297
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 08:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 972897A96FF
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29B1D5AAD;
	Fri, 28 Feb 2025 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKGhwYIy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92D1D79BE
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729514; cv=none; b=aHiZombypzZFimarsdETfNVRZlX7kPxV9/2i18ctjtfT37nHWPWdshYz7GxsbKHTUZPhMtJPPqAZWsXdknwaDgvjId3+/CruafvgeJ3DzKNQAJTSb9yuOvnJs8e/NnjFwHv1t0OJU66qbQZHd61ybB3yFNT2WVJUQ79Y5aGpqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729514; c=relaxed/simple;
	bh=QRx7jZRT55AKyjpFQGyFiao/6ngnuUeVAto4r0nfsVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLFEtnLcVCPrjwo8KtEoaS4CVX6R2pUSs+jdGRvHtnRdBWuIYAXaljRYXKTwEN6HJB4XhQ8Mir0W7go4lvgfXIXhaO4RHq8dWlQH3G/l20WP8xXtVdXE5zXDHzxJxLy2LdNL7BVqTB+G0CxyElDzDxba7ylWHHE7/HDKeqroKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKGhwYIy; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740729511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VCEGjyZe+NN0DZWtHUpr5+jCBnuJyJ0VIJUe5VXlq8=;
	b=pKGhwYIythzfPZUUvu9WlOfs4j0TLxTYveugs6VVz6vtAmEdqTKcfPp3JrH0JyMA0ymAC4
	hX0Qdr6CY54uCEink45UtRfouqr3vp5DvPqBt9JxhObqqgUcqXSLkl1G7truPbl8j0SF+i
	YVXLPk+zopZiy6Wrq9/L+SrnXUM7cjg=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/3] memcg: don't call propagate_protected_usage() for v1
Date: Thu, 27 Feb 2025 23:58:06 -0800
Message-ID: <20250228075808.207484-2-shakeel.butt@linux.dev>
In-Reply-To: <20250228075808.207484-1-shakeel.butt@linux.dev>
References: <20250228075808.207484-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memcg-v1 does not support memory protection (min/low) and thus there is
no need to track protected memory usage for it.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 55b0e9482c00..36b2dfbc86c0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3601,6 +3601,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg, *old_memcg;
+	bool memcg_on_dfl = cgroup_subsys_on_dfl(memory_cgrp_subsys);
 
 	old_memcg = set_active_memcg(parent);
 	memcg = mem_cgroup_alloc(parent);
@@ -3618,7 +3619,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 
-		page_counter_init(&memcg->memory, &parent->memory, true);
+		page_counter_init(&memcg->memory, &parent->memory, memcg_on_dfl);
 		page_counter_init(&memcg->swap, &parent->swap, false);
 #ifdef CONFIG_MEMCG_V1
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
@@ -3638,7 +3639,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return &memcg->css;
 	}
 
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
+	if (memcg_on_dfl && !cgroup_memory_nosocket)
 		static_branch_inc(&memcg_sockets_enabled_key);
 
 	if (!cgroup_memory_nobpf)
-- 
2.43.5


