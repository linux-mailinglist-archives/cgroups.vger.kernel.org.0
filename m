Return-Path: <cgroups+bounces-11253-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BFEC15105
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5625502206
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C98336ED2;
	Tue, 28 Oct 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="maDouu5c"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A93396E0
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660191; cv=none; b=mLNb7rgy9lUib6tZFQEPnWE4PDgzeo4K8YM7EHyQKj56Oh2EKFCu4HqrNtAIdeR/0eHsSM0cXolKahRwUnCFm57C9Bq3wIj6x5gMQem3J0mIpCwVp0u0U5n3ZTR1kvWLKu+CMC0iGqo302dmZa2hv202V482vOsZ6+LbQdvIVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660191; c=relaxed/simple;
	bh=d3HGIX+5xqQ3gJbNPVc+GczUi6vw7BKVy2gymVINVFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezP+XVD+yUo/Nn8mHs61cZF3iYKSDCcal4qH2dNkJqX6ldwDRJ8ClRXY6+VWTVoI/FcQlY0DKkEC2z8COPAQV0ueFqNf3AhKrFjfgaolrW789R3hB+2oMFRyqKk/VRVBmb06hYSZSKc2kFdds8dGDHs5+CnouOYMNl97Z1p5yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=maDouu5c; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ul0akWBgQO9d8PYcmieApSptZ1K1m0W1WjLnOQW3EIU=;
	b=maDouu5ce544NaChXO2olwlSoJjFWIOouCmnASfkFN706sflQURVJ7rfqaMcU+KKGFzR1j
	b7Gq5siNpsBiC9GDc6Px2VT6uFOE0GtMoXgS/KvQOSx48h4q9XxMHVQ0aMWon1S84m/pky
	13xFZW1Z9O3abQIUUWzA2GfMn4SyxBM=
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
Subject: [PATCH v1 08/26] buffer: prevent memory cgroup release in folio_alloc_buffers()
Date: Tue, 28 Oct 2025 21:58:21 +0800
Message-ID: <f62ef59c751a710b0e1adff07876c02942664a7b.1761658310.git.zhengqi.arch@bytedance.com>
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

In the current patch, the function get_mem_cgroup_from_folio() is
employed to safeguard against the release of the memory cgroup.
This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 6a8752f7bbedb..bc93d0b1d0c30 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -925,8 +925,7 @@ struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
 	long offset;
 	struct mem_cgroup *memcg, *old_memcg;
 
-	/* The folio lock pins the memcg */
-	memcg = folio_memcg(folio);
+	memcg = get_mem_cgroup_from_folio(folio);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
@@ -947,6 +946,7 @@ struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
 	}
 out:
 	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 	return head;
 /*
  * In case anything failed, we just free everything we got.
-- 
2.20.1


