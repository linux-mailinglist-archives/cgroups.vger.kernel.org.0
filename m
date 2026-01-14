Return-Path: <cgroups+bounces-13191-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CDBD1E7CB
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DAA30F0ABA
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3DA396B6C;
	Wed, 14 Jan 2026 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y7jeyurN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B1395DBE
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390468; cv=none; b=lf2caCodQgNpEfto8Q3NPDJdnf/AIYaaJauPxis8IiF98jD1GdDUb1XtRyJGUklXh31HBcQ8/HesGWbyXKyydzVl56gtE+VYUsYBSC+QuuaX1qtfkBDleB+pwdYYxoOUSQOVSUB+p3Ua7ovTmCUBjmL6LmHsTh8uLMrBWOVk43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390468; c=relaxed/simple;
	bh=CMUNtUKoZfDrBGF1gYUu5Q5mAZM62opAF3LzbJZ+JdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uz3UxDb3YSbexxafD3/A/HgcL0UHgvrEUtC19aahmqEOfRfd5DvTAxnidJIwKDC+3mMYslqMxlIUssHHwiMP/3TGCT5IvYLTPblyCYcoXRJ0ut4UYZtRu/knDaj8LRS8xM29PWhCuM0Hr0GHjEZAoyun3IkrZi2g+u38Z6VlTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y7jeyurN; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768390464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=em4Iy6O35b1A8UR+0FO08xHRW0BrOK64xODkveylgXo=;
	b=Y7jeyurNAc4uvEAfTJbTgqIYsRk+83DVSW416xY5r0eDb6iv3XH27yMYQ2bGbyNYhYd72+
	PYMpbf/+shaKQ4FIyWr49L4PdVygdOGf/27V1nmPR89IlgW132TbT8c2ORTn1N6AVBlUfc
	xP0YLXfIhN8VvEXDrmrtOeYrYTwrmV0=
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
	yosry.ahmed@linux.dev,
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
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 15/30] mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()
Date: Wed, 14 Jan 2026 19:32:42 +0800
Message-ID: <3e739f195644611749093c8dd2c8dd2cea1d2485.1768389889.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1768389889.git.zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
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
against the release of the memory cgroup in mem_cgroup_swap_full().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b5d4139ea1aaa..548e67dbf2386 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5283,27 +5283,29 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 bool mem_cgroup_swap_full(struct folio *folio)
 {
 	struct mem_cgroup *memcg;
+	bool ret = false;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	if (vm_swap_full())
 		return true;
-	if (do_memsw_account())
-		return false;
+	if (do_memsw_account() || !folio_memcg_charged(folio))
+		return ret;
 
+	rcu_read_lock();
 	memcg = folio_memcg(folio);
-	if (!memcg)
-		return false;
-
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
 		unsigned long usage = page_counter_read(&memcg->swap);
 
 		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
-		    usage * 2 >= READ_ONCE(memcg->swap.max))
-			return true;
+		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
+			ret = true;
+			break;
+		}
 	}
+	rcu_read_unlock();
 
-	return false;
+	return ret;
 }
 
 static int __init setup_swap_account(char *s)
-- 
2.20.1


