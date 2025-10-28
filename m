Return-Path: <cgroups+bounces-11252-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3293C1512E
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E695B5E48FF
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C350A337B9D;
	Tue, 28 Oct 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q4KXYujY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71182337BB1
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660180; cv=none; b=I9UL79m1h0armUlGmoQA8baZHaXuoekARCtmPf9sP6DbNa1PlTHHA27fAgda5XhECtHfwUWF+GL90wGlvdLX6jlml+fHCesGmoH6QyMFob+0w4muB4GEmjySy4lgf2vKzsyFyl+/IcYO/tLm9LLp6NRdH8C/53341qvFo3Vvu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660180; c=relaxed/simple;
	bh=4zZme6vj/fv/F0aMJBOYAzVbwej+e7U6DodAB6yUuBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMcnd5Uz2NyUuHLQ/9ukPUpTURNx1xmLcJo5XSo3mWefENNXwefPQQQ/WQaFqDYVCSHqiWrtNQhq7vYsTlK0uVQtOz3EpSE4hC0drk8b1m3pks2OXCYRudfAV9HvBRw1+isnJXw0pUZbfa4PVJd8b6JEW3+7R3MSzt7HP24Q04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q4KXYujY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwZ644xbYvlNcagDZjQ0mKRDmPXR0vZ+/IMJ8ruGmik=;
	b=q4KXYujYUCNGMd6/2GfYLrwuY6WKfDyyGjAFmIfFVpIINUQT+TYRszwkW0sd/3PfetejZz
	qFDU7mIuGhZ3R8LP+L8tH0OPOfJMdxCIBW7lZeAT7MGVMa+sgKyH9un9PUQmNiCyyFDaba
	dJb66qMsLrpMqVBKRqibHSucfgUHoak=
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
Subject: [PATCH v1 07/26] mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()
Date: Tue, 28 Oct 2025 21:58:20 +0800
Message-ID: <9eca65dec044d4352bee84511fb58960a1402ddf.1761658310.git.zhengqi.arch@bytedance.com>
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
against the release of the memory cgroup in get_mem_cgroup_from_folio().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memcontrol.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d484b632c790f..1da3ad77054d3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -973,14 +973,19 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
  */
 struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	if (!folio_memcg_charged(folio))
+		return root_mem_cgroup;
+
 	rcu_read_lock();
-	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
-		memcg = root_mem_cgroup;
+retry:
+	memcg = folio_memcg(folio);
+	if (unlikely(!css_tryget(&memcg->css)))
+		goto retry;
 	rcu_read_unlock();
 	return memcg;
 }
-- 
2.20.1


