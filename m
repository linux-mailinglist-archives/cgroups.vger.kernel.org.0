Return-Path: <cgroups+bounces-7090-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F4A6310F
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892E41899161
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295DF2063DB;
	Sat, 15 Mar 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e/E/nuyl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3F2063C9
	for <cgroups@vger.kernel.org>; Sat, 15 Mar 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742061000; cv=none; b=mMCHa/ejKDmJ/Z2T/2GIG61yjJjjjbCeJl+rEKjL/CxdT/zBpancXC51c6FWCdK6A2FtqRYB5JoWBO7NwGC6DRwhK0tJCrfvfbiW6Bw2ZUYJJZv3lcWffnI8ABA6tT5ODBASsbryVQKYRiIHOqYGT07jxT0v/xZp5U4yaXyqUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742061000; c=relaxed/simple;
	bh=rnw3vswnDrsPjRWC5QnmP1Un7aiy5k4mZRxD7W7IODg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y07lOx8t6cUMs7nRvSumPoeCjpLkCWl/m8U2CR7bsPYsLkFCREF7S98LCju/vwDFhFGdwMDDF84M232siINOO2GxOoMur1hDahNXBqZR6YH0Ig2F5d6NHD8DKw9YmLCJiDo+wvSo4mRA35C2qnympo5zXCWJMpdHASIf6VhaHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e/E/nuyl; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742060997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mWjPqT680ajW18j1m0PlnxhJw6Nvx3pVB+w31Bj7so=;
	b=e/E/nuylkpGXEhqHZNEobS6G+bqcssykgUckBO75NlFgK87SEgIBgQphktZTteBqNnHTbd
	x6QCYzHUjbLCNKPRZeaMdVcSSLOj6sGoyZmm+1mDUtiEh8IruX1fojGN/FiLHsrwdIn2s5
	f2gone2vSuXSW8gupsMmoVL5SC2w8ho=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 5/9] memcg: no refilling stock from obj_cgroup_release
Date: Sat, 15 Mar 2025 10:49:26 -0700
Message-ID: <20250315174930.1769599-6-shakeel.butt@linux.dev>
In-Reply-To: <20250315174930.1769599-1-shakeel.butt@linux.dev>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

obj_cgroup_release is called when all the references to the objcg have
been released i.e. no more memory objects are pointing to it. Most
probably objcg->memcg will be pointing to some ancestor memcg. In
obj_cgroup_release(), the kernel calls obj_cgroup_uncharge_pages() which
refills the local stock.

There is no need to refill the local stock with some ancestor memcg and
flush the local stock. Let's decouple obj_cgroup_release() from the
local stock by uncharging instead of refilling. One additional benefit
of this change is that it removes the requirement to only call
obj_cgroup_put() outside of local_lock.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7054b0ebd207..83db180455a1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -129,8 +129,7 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
-static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
+static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -163,8 +162,16 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
-	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+	if (nr_pages) {
+		struct mem_cgroup *memcg;
+
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+		memcg1_account_kmem(memcg, -nr_pages);
+		if (!mem_cgroup_is_root(memcg))
+			memcg_uncharge(memcg, nr_pages);
+		css_put(&memcg->css);
+	}
 
 	spin_lock_irqsave(&objcg_lock, flags);
 	list_del(&objcg->list);
-- 
2.47.1


