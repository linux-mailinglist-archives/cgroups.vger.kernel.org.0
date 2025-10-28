Return-Path: <cgroups+bounces-11255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45586C150CE
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86F918962FB
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F64339B45;
	Tue, 28 Oct 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Keb41diP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65633971F
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660201; cv=none; b=vDZm+Jv99xSAd5ADDazxL5LXKFNPzHcdjlE+4ApZRPOQ0Z9YbYrmfSivvFV8JMm7vZyQf7qyBl+plwAqZfXvbLeIQhq0Sif98HyJ81yIlDcvyjvOeMcJnAEQKf4sVlBGgnR56YpU5ywlWkK3+z5BKYe2ZRXcnskVYw9SEmiWc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660201; c=relaxed/simple;
	bh=NacU3FVS+RRrB8wkdEVX01eh4VOJCi4K0F2ydqNV8rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3ShlDyxJicdXPsvzHVRUyt670eoJ8mGIqU+lXDYO7jFo2+0OP1pIEGjb9W+eVZzFe4cWbZCAS/GXl55UdTQ5YI3DxKXp9DMHGxYeNznPS703lcwr0nClz8LIzrsmN2aAe+m0Ld/Vcgp5S3VI1JFvq3xRR6vC9x0soP2HkZ901A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Keb41diP; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQ5H2mz4dVXx5yLN5zTg1jKj+s12XH2F8FoyP4DTscE=;
	b=Keb41diPvx6YSmv3KjV5tfMFVwgCTvM3vVnU5B8tPPTriLp0WGiAeHuYMTVXp2SxD5lxBu
	33n4iaxgrmdpRj6MsPU9h3TczXEoHjcIiBgf6j5GU4SPKcdnBad+SPu7i363kDDpf4bSkC
	3R2eVAJrKlZIF4uljuyHmUYjf+6rNsw=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 10/26] mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()
Date: Tue, 28 Oct 2025 21:58:23 +0800
Message-ID: <eddcfb8a49c915dd897a91ca5560553b2bed9623.1761658310.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard
against the release of the memory cgroup in count_memcg_folio_events().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 174e52d8e7039..ca8d4e09cbe7d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -984,10 +984,15 @@ void count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 static inline void count_memcg_folio_events(struct folio *folio,
 		enum vm_event_item idx, unsigned long nr)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 
-	if (memcg)
-		count_memcg_events(memcg, idx, nr);
+	if (!folio_memcg_charged(folio))
+		return;
+
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	count_memcg_events(memcg, idx, nr);
+	rcu_read_unlock();
 }
 
 static inline void count_memcg_events_mm(struct mm_struct *mm,
-- 
2.20.1


