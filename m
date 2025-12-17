Return-Path: <cgroups+bounces-12407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA4CC661B
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3B2E3020818
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932633C192;
	Wed, 17 Dec 2025 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sWrtvrRI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338033BBB8
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956747; cv=none; b=ikki9xYAOzrIM9NRTgqkS/JDa1yvTL3LkrTrlW1oeRQfkriW3S1tf+SCDNH5AstSVKOvcjaxWRZVl96cU6AIomh5n1EsY746DwXLMjNGFog2maj+4wMDfFowFlQB5NBLAcCUdPKrhHPZjrry9xwWX92LTs+f9tJwRhpJPqmpHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956747; c=relaxed/simple;
	bh=69RjVH8TirWS3KliuY4x7mW+QRT+PoHoP27Nooi0lYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8sbH08OVJBOmyA/UlmxR+KwKp7VkVCDxSaTJizB3YJMk+6YFJ83olty1O9S8mrQ09Zp9A8xDU7CU/czOCWfvYjFDgBx34K7VMQdquf6Ag+4sOvv4xngnj4uziTNl3vWdnbebmm8eOoYOIxqnQe4d7OJ5dCjSd0TqL9tF3lnSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sWrtvrRI; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgHA+TVYxxe6Vv06rsmZd9zVObrCtofW37vIgARv2qc=;
	b=sWrtvrRIUjcLsV7Wz5k1ASxrUwoIXf5ObCdZlxnW7diW5X7mj4vFtrqgIm0bmWwwlrporg
	FvuQhwE+227JPy6VoGESBiGjDTkh1nwLknInGXf2rSOD4WFKaF/jNCHA5EV+7gOdbt70ce
	PqEwH7/QF0cw5Zu1jPS8S3uwLTa7hUM=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 17/28] mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()
Date: Wed, 17 Dec 2025 15:27:41 +0800
Message-ID: <4cb81ea06298a3b41873b7086bfc68f64b2ba8be.1765956025.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765956025.git.zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

In the near future, a folio will no longer pin its corresponding memory
cgroup. To ensure safety, it will only be appropriate to hold the rcu read
lock or acquire a reference to the memory cgroup returned by
folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard against
the release of the memory cgroup in folio_split_queue_lock{_irqsave}().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/huge_memory.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 12b46215b30c1..b9e6855ec0b6a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1154,13 +1154,25 @@ split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags
 
 static struct deferred_split *folio_split_queue_lock(struct folio *folio)
 {
-	return split_queue_lock(folio_nid(folio), folio_memcg(folio));
+	struct deferred_split *queue;
+
+	rcu_read_lock();
+	queue = split_queue_lock(folio_nid(folio), folio_memcg(folio));
+	rcu_read_unlock();
+
+	return queue;
 }
 
 static struct deferred_split *
 folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
 {
-	return split_queue_lock_irqsave(folio_nid(folio), folio_memcg(folio), flags);
+	struct deferred_split *queue;
+
+	rcu_read_lock();
+	queue = split_queue_lock_irqsave(folio_nid(folio), folio_memcg(folio), flags);
+	rcu_read_unlock();
+
+	return queue;
 }
 
 static inline void split_queue_unlock(struct deferred_split *queue)
-- 
2.20.1


