Return-Path: <cgroups+bounces-11260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDCAC150F9
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29611C219DE
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65C334691;
	Tue, 28 Oct 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mcp43v4U"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D523321DD
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660237; cv=none; b=pZFGZq/G8ds+1yJKIq7jHI9kzplltGymSjYa+ONFEhuwtQ/XiRalwU4OysN4xbpM+QapWX/IzMdSXsv8ckUP9HUhL51LQnKd9WaQQnw2QQKLUyf2oV2MCtQYbOWfWr7GLCmzDkV0yCalIT6R8vJWoXSrNq9Y16kzNiXm7lrR6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660237; c=relaxed/simple;
	bh=B99n2BJg7ZZJCSR2ssO24WoXB6kUezL1KP4/WR6sRm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8FBo/X0T6WoXxcGU+jsXS+VnEk3J8sIopw+udL/y5ZaGLN1bpPinlnHTj7H4g/2/EBjKETP305VaLSswNsxqbBwgW6pacfwIvNgojMrfuRgRq7JNnBatE3EjaMBz9BKqdiCx7/gIO+v2myE/rGigCQkopPQ2cPKlAP63UV5fpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mcp43v4U; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6cy0qJU4vZTky6WsO6fPgmyrH0v2+1c03Oi7wqa5+0=;
	b=Mcp43v4Uw1DN1te6MLoGfIu4JBZPPNa/YdsIikEd59YRXiDP67BQ+YkTF+91+BLyLuIPFr
	EZQ+DNJ0Tz9/WrVUMTS7op86uCagBE5emzwbk0TROnKZweY3Opo2prHAUcrb+eDsox0mLI
	BN26/J6xOdjx6l2HOhJ2q5avXrQhhH8=
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
Subject: [PATCH v1 15/26] mm: workingset: prevent memory cgroup release in lru_gen_eviction()
Date: Tue, 28 Oct 2025 21:58:28 +0800
Message-ID: <847c35eb649fde525eecde97fcee3d01708b7b3a.1761658310.git.zhengqi.arch@bytedance.com>
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
against the release of the memory cgroup in lru_gen_eviction().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/workingset.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 8cad8ee6dec6a..c4d21c15bad51 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -241,11 +241,14 @@ static void *lru_gen_eviction(struct folio *folio)
 	int refs = folio_lru_refs(folio);
 	bool workingset = folio_test_workingset(folio);
 	int tier = lru_tier_from_refs(refs, workingset);
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 	struct pglist_data *pgdat = folio_pgdat(folio);
+	unsigned short memcg_id;
 
 	BUILD_BUG_ON(LRU_GEN_WIDTH + LRU_REFS_WIDTH > BITS_PER_LONG - EVICTION_SHIFT);
 
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	lrugen = &lruvec->lrugen;
 	min_seq = READ_ONCE(lrugen->min_seq[type]);
@@ -253,8 +256,10 @@ static void *lru_gen_eviction(struct folio *folio)
 
 	hist = lru_hist_from_seq(min_seq);
 	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
+	memcg_id = mem_cgroup_id(memcg);
+	rcu_read_unlock();
 
-	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, workingset);
+	return pack_shadow(memcg_id, pgdat, token, workingset);
 }
 
 /*
-- 
2.20.1


