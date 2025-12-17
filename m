Return-Path: <cgroups+bounces-12403-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB307CC6779
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 09:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F261A301372D
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DBB337B8A;
	Wed, 17 Dec 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dpym/8wi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDB3358BF
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956691; cv=none; b=hnJi7VKR2CUrNmbiXUDFSSBCysb2uHiA5kuigt2LQBo9jiko2Ai6EMsKZsIhaA+NF7dMPY8E96GaX3sKVeYZryxijSCnZBk7VsLFUT0DNSergtzYgGuKtjHTjYTd5xwIbkwHDbLC9x8BI8YA57Z+u+9n5Ml7ml5gRPoyyDzu/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956691; c=relaxed/simple;
	bh=F/3rA84FRmyudweYBO2D5mXlwv20pVZ3BpV2rou5P1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXsa3pTRmGLV2eX3j1I9na0tE1lorg6OHJNbUg8ZLfQC6/CF/+5LsttFb7ynjpRXiEBAow4CpIZIxqsMh7/5QkpSg5CqGSZrOijh3fF+uNGtzmt3RV6aiPHGqPHKhIDxlYSCV4/3AVB+GfQn8R449+9o0nmzDHQ+KTh9BHpjO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dpym/8wi; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765956681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ugmq4fp6u6Yh4W4K7GQktCJ98/N712HUp8zSOzWPIU=;
	b=Dpym/8wiT7J1ZVKeNfPt+C3A+L7GdRuNhMyDPTQKIMteFSS5QIJYRZCFJNdHpiMS1ez25Y
	7X1VGxT67Up330JCOXDXoI1rHcxe2C6xowJgyhm7GBrskvebqMmSp66/G9AOsDH4sMQa4I
	QgiaDtXzXOzyT4f+DsixHyZtIUbp+CY=
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
Date: Wed, 17 Dec 2025 15:27:37 +0800
Message-ID: <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
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
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard
against the release of the memory cgroup in folio_migrate_mapping().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/migrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5169f9717f606..8bcd588c083ca 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -671,6 +671,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
 
+		rcu_read_lock();
 		memcg = folio_memcg(folio);
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
@@ -698,6 +699,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 			mod_lruvec_state(new_lruvec, NR_FILE_DIRTY, nr);
 			__mod_zone_page_state(newzone, NR_ZONE_WRITE_PENDING, nr);
 		}
+		rcu_read_unlock();
 	}
 	local_irq_enable();
 
-- 
2.20.1


