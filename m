Return-Path: <cgroups+bounces-11712-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08605C45577
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 09:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A245346E17
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356232512FF;
	Mon, 10 Nov 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TiT8gxSm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479B2F39CD
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762753; cv=none; b=G7LPBgt9Aq7M+fHgzhlsb/Tp44Gt4LycyhBY8/IuF9TVD3rOkh8rWre4EJAjOsNhGcxlHEgkq7ZQhC8jFfpp66/ZJiXIiGXGhQxJLz3fpSypzM9FcDnzFZruX3pjEYzXY/mypjy8NtWJb7gnL81HF651U14BwHxVHVLOMUzUS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762753; c=relaxed/simple;
	bh=ojUOoEItR7KCiJLi015etUtiBjINyYKP3aW/L3B+dq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2ROMZE5Q/5R8HRwPHWHAatyVgPwpOqn5XgZ0sY1F4O3thdv125RI8Oqz2bVTBSvreGYl7SEBGQUuLGOpu9mc1M0sotIsWTe+3Kf7/eqMQIRW1WU9T+1Bf6M4mlh5Hk1iTN8IpHVWlrj3bs9uIXjwZv9qqISduG0RitZG42ulsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TiT8gxSm; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762762737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aA2NOzQse06x9i0m2QrR5DmKV75xHASn1pyl9aKwEzM=;
	b=TiT8gxSmIZ81WzRtRKz6SsqUMzqS8jbj/Jsn3CvPn926nv44UROFAlB1rctkkIP52Jt9Zo
	c+RcFMv1f3HcRg80wUVx3Qzb5d6POUdtNRk0c1qnOEFX+coIum6yru0jdCMcjY/uW52xrr
	2He9M1IqjoI9TMFwjTggRFv2dD4Pomc=
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
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v6 0/4] reparent the THP split queue
Date: Mon, 10 Nov 2025 16:17:54 +0800
Message-ID: <cover.1762762324.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Changes in v6:
 - collect Reviewed-bys
 - rebase onto the next-20251110

Changes in v5:
 - fix the softlockup issue in deferred_split_scan() (Zi Yan)
 - modify the commit message in [PATCH v4 3/4] (Shakeel Butt)
 - move memcg_is_dying() to memcontrol.h (Shakeel Butt)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20251014

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
 include/linux/memcontrol.h |  20 +++
 mm/huge_memory.c           | 250 +++++++++++++++++++++++++------------
 mm/memcontrol.c            |   1 +
 4 files changed, 194 insertions(+), 81 deletions(-)

-- 
2.20.1


