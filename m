Return-Path: <cgroups+bounces-12410-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C2CC674A
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CC5030813E4
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D88233E37D;
	Wed, 17 Dec 2025 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qss7+xs4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161133E369
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956785; cv=none; b=czKC3T/cZQR2PYaJJ2Z/k2BXgKxdSsIYEqFXNkPmB+DitYDuIqZqDXSqEMJoU75cBNQyTscHoykxUVSzeyxip1fQz9gHt4yU7/0AL4unDPO7myEqv8gNDV75wb1ZLIN3kKLoHDhOMLuKzLeHzIu8Jsowq1pVLtyySNzEDhWY3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956785; c=relaxed/simple;
	bh=V2QjUp/J2A3sgD5j0GufhNzAkOwa8ipgKv/DGTi1o4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1FEdC1u4yeepcseaAM/yUZXhxuN82AnXEC/tc8pSYKEtFjuFEwd6IMpFPZi531OaLsDnTOtheOyl0wMaIK8rN7o9FKlVs/hbjkFZ21CkyzwqnM8IHLs6Q06Z2vKgQQwmuUt/juE0TYOxOI69JhOnZOAfesQt1f8YrFTA5C4rJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qss7+xs4; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hCVtkwWInjeWp1lZK86oR9Lr8eWsGStrPfk/NkSL0k=;
	b=qss7+xs4+fcC/k4TRH856pLkCsZ3zf6NmhCCKBEDP94wPzgJX5Se5bzxYs1nQvCcPAFf1H
	IUyFBywc0v7UZh6JX+MCryCQnvJm9NcBRnkhxr55rLWMPZBrpBYI7A4pbR3nSLhuCbDRTI
	7cQwLAFU/zWeAVJrioGetOwSuqdGWIE=
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
	Muchun Song <songmuchun@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 20/28] mm: zswap: prevent lruvec release in zswap_folio_swapin()
Date: Wed, 17 Dec 2025 15:27:44 +0800
Message-ID: <bd929a89469bff4f1f77dbe6508b06e386b73595.1765956026.git.zhengqi.arch@bytedance.com>
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

From: Muchun Song <songmuchun@bytedance.com>

In the near future, a folio will no longer pin its corresponding
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in zswap_folio_swapin().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/zswap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index b468046a90754..738d914e53549 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -664,8 +664,10 @@ void zswap_folio_swapin(struct folio *folio)
 	struct lruvec *lruvec;
 
 	if (folio) {
+		rcu_read_lock();
 		lruvec = folio_lruvec(folio);
 		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_disk_swapins);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.20.1


