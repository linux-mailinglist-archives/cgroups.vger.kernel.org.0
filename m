Return-Path: <cgroups+bounces-13198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C0ED1E79D
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98A78307D44E
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1133395DBE;
	Wed, 14 Jan 2026 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GkQroMKg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB33559F0
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390529; cv=none; b=eyqNmc1Z4mc1nHL2FIv8AASQ/Qnp1PGvOSmSWBVWGCVXLar42nr9+fEJ3tJM7UdRtZ+00lP9rnJGiAQ7zu3TgVCdTJGiqQmkOeAQvoDZK1MPF746J6GdDUm2KlrZ/3Ug73Jcqb1Yh6syHWmfzjzbtOJLRxgYh6rMMzo5Ut5BzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390529; c=relaxed/simple;
	bh=69SJwUfil99/bsWDx2B0ReWvIk5L/eXzjcW37K7MxwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El6w4mujOwTWmtzuD4oSJ25mq9zZTSC/cp9DzmvH3wxNXP3u74G/pPA55IEbi+N5IOgRGrAX1Lv8EwERJhNq73pKxR/7G51Gym7x5ckyD2vr8nQ8Fnl27oLnvFpdKCs0AF2FCjvlii7zsvBpCe8fMjeTDYwBiBM9OXUrcYRSOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GkQroMKg; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768390525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z51xqOUPrAhoh0O0GpdBH64DgayE69nJ4AY48cemOmg=;
	b=GkQroMKgudviGh4+T3T5BnePjIc1sCeCfGOszqh4Cpf/7jz08mH0bGrBlPoQrr20CERWHc
	S1ty/PC/trZydeZrWsSp+zOKUJ65SUr5t1kUkrueBtRe+npVCrQ5t5mroPuMDsbzUyq1TH
	FuVn0xlRBuYmhx2Pkoecm8EYYvDz7b0=
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
Subject: [PATCH v3 22/30] mm: workingset: prevent lruvec release in workingset_activation()
Date: Wed, 14 Jan 2026 19:32:49 +0800
Message-ID: <a610afe2213e83d2e50eac584fe38fed453307f8.1768389889.git.zhengqi.arch@bytedance.com>
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
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in workingset_activation().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/workingset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 5fbf316fb0e71..2be53098f6282 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -596,8 +596,11 @@ void workingset_activation(struct folio *folio)
 	 * Filter non-memcg pages here, e.g. unmap can call
 	 * mark_page_accessed() on VDSO pages.
 	 */
-	if (mem_cgroup_disabled() || folio_memcg_charged(folio))
+	if (mem_cgroup_disabled() || folio_memcg_charged(folio)) {
+		rcu_read_lock();
 		workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
+		rcu_read_unlock();
+	}
 }
 
 /*
-- 
2.20.1


