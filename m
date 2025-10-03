Return-Path: <cgroups+bounces-10535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D77BB79F2
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B2874EE6D6
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580862D6E4A;
	Fri,  3 Oct 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFUg0FPr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461702D29CE
	for <cgroups@vger.kernel.org>; Fri,  3 Oct 2025 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510451; cv=none; b=OhkVEGcIHCASQ/q2OZLI0Z6dZ8DP2yn0D1FolATGvIDoAB74j5UarAJAxxKzgen8l7p5kTDUJp60gLd0mQkMoK7YmFYFbiP6Dz/xyTUvMg3FZQUk7gO04a+rPjx8lgZl4KvFAvudFytS78j36jfLiUYnzwNJVX0oahkKB17RpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510451; c=relaxed/simple;
	bh=r9jXdPkNp4ZbYhSY8KjNLD3PMOnYC6udukSIbvtBc1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgU9PRLGAeqVlA7eLY0zVjKkEr7VJO7BzR7cEiylPMvNsZ9fku1BSh6nFWRjMZT7K9FN7qyrIAojUNxB8H/S1w67uaQ5a6sCgQV6q66J2rmpGj7E7Hg9k1abUI+cxqVm8eyEv5whBQtDJOJVpaTmj+HGhciQTP1NNlW6t6uw4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFUg0FPr; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759510435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xRVhaW2/i9fEx7I+LuZkY7sYjvYyEufnTn/0UGKwdi0=;
	b=JFUg0FPrMvBpqOsOnXFw1DQ5mKTUoNhv4ZasSvNFslafvWH0wPdUdFy4mTg40rMlU6RUKI
	TqBCkuIDs60abnrrtDQxPvU0IALLTfKW0PvrsfomgVv2OVlM2tuRdY9jU2/T4e8kd56sPw
	3WFwXu/A+bbqzgtSp/nWKS3EOza4gvM=
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
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 0/4] reparent the THP split queue
Date: Sat,  4 Oct 2025 00:53:14 +0800
Message-ID: <cover.1759510072.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Changes in v4:
 - add split_queue_lock*() and let folio_split_queue_lock*() to use them.
   (I have kept everyone's Acked-bys and Reviewed-bys. If you need to discard
    it, please let me know.)
 - let deferred_split_scan() to use split_queue_lock_irqsave(), which will fix
   the race problem in [PATCH v3 4/4].
   (Muchun Song)
 - collect Reviewed-bys
 - rebase onto the next-20251002

Changes in v3:
 - use css_is_dying() in folio_split_queue_lock*() to check if memcg is dying
   (David Hildenbrand, Shakeel Butt and Zi Yan)
 - modify the commit message in [PATCH v2 4/4]
   (Roman Gushchin)
 - fix the build error in [PATCH v2 4/4]
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20250926

Changes in v2:
 - fix build errors in [PATCH 2/4] and [PATCH 4/4]
 - some cleanups for [PATCH 3/4] (suggested by David Hildenbrand)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20250922

Hi all,

In the future, we will reparent LRU folios during memcg offline to eliminate
dying memory cgroups, which requires reparenting the THP split queue to its
parent memcg.

Similar to list_lru, the split queue is relatively independent and does not need
to be reparented along with objcg and LRU folios (holding objcg lock and lru
lock). Therefore, we can apply the same mechanism as list_lru to reparent the
split queue first when memcg is offine.

The first three patches in this series are separated from the series
"Eliminate Dying Memory Cgroup" [1], mainly to do some cleanup and preparatory
work.

The last patch reparents the THP split queue to its parent memcg during memcg
offline.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/all/20250415024532.26632-1-songmuchun@bytedance.com/

Muchun Song (3):
  mm: thp: replace folio_memcg() with folio_memcg_charged()
  mm: thp: introduce folio_split_queue_lock and its variants
  mm: thp: use folio_batch to handle THP splitting in
    deferred_split_scan()

Qi Zheng (1):
  mm: thp: reparent the split queue during memcg offline

 include/linux/huge_mm.h    |   4 +
 include/linux/memcontrol.h |  10 ++
 mm/huge_memory.c           | 258 +++++++++++++++++++++++++------------
 mm/memcontrol.c            |   1 +
 4 files changed, 192 insertions(+), 81 deletions(-)

-- 
2.20.1


