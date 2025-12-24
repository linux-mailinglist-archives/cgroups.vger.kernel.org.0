Return-Path: <cgroups+bounces-12641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5057ECDB9C7
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 08:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77651302652E
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2032142B;
	Wed, 24 Dec 2025 07:45:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B11D9A5F;
	Wed, 24 Dec 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766562339; cv=none; b=jAna2kPFwcb22OSC82joqvXj3MzVuwaEtAdGVNW8fHBz5mpJPAeEjSEejwSZr9gNpdirTsHsnqUN7bfY7+4xQWC2ahJo01s4QanKmwp0XBeTvAgH6CvgHcOHLokpnY1qVKZo+iqUMYKp79HfVEDtDQ4NTF/JojCEpwJNb688b6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766562339; c=relaxed/simple;
	bh=hWW9931UVpm4wcQiwuBsR3ACkuXKyiGAX5Wgol6YIzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hoPxvcv1zwsc/JQpZlaRnXum9y3dYCprind/6tktQ9/xnIjuHVLbDKLtoiqwoq9Tm+1mdEHrdEKX7R6D+//vRu4qJXGg5RAWZQmTzbDvT7QAaOf7GXtO9vrWPkyQZfNmKOwnXeDI64NLpVOVW91+/ZYA/QMu0wPeLM8VphewQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dbkRr2GN6zYQtmq;
	Wed, 24 Dec 2025 15:44:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 95D114056C;
	Wed, 24 Dec 2025 15:45:34 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_cMmktp9pcvBQ--.63051S2;
	Wed, 24 Dec 2025 15:45:33 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com,
	mkoutny@suse.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 0/7] mm/mglru: remove memcg lru
Date: Wed, 24 Dec 2025 07:30:25 +0000
Message-Id: <20251224073032.161911-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3l_cMmktp9pcvBQ--.63051S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw18JF4rXFyfKF48Xr48Crg_yoW5XF4xpF
	Z3Wasrtw4rAFWUXFs7K3W7u34fZa18Aw47WrZYg34fArs0y3WDZr4xtw4ruFW8CrWSqr17
	Xrn8C3W8XF4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The memcg LRU was introduced to improve scalability in global reclaim,
but its implementation has grown complex and can cause performance
regressions when creating many memory cgroups [1].

This series implements mem_cgroup_iter with a reclaim cookie in
shrink_many() for global reclaim, following the pattern already used in
shrink_node_memcgs(), an approach suggested by Johannes [1]. The new
design maintains good fairness across cgroups by preserving iteration
state between reclaim passes.

Testing was performed using the original stress test from Yu Zhao [2] on a
1 TB, 4-node NUMA system. The results show:

    pgsteal:
                                        memcg LRU    memcg iter
    stddev(pgsteal) / mean(pgsteal)     106.03%       93.20%
    sum(pgsteal) / sum(requested)        98.10%       99.28%
    
    workingset_refault_anon:
                                        memcg LRU    memcg iter
    stddev(refault) / mean(refault)     193.97%      134.67%
    sum(refault)                       1,963,229    2,027,567

The new implementation shows clear fairness improvements, reducing the
standard deviation relative to the mean by 12.8 percentage points for
pgsteal and bringing the pgsteal ratio closer to 100%. Refault counts
increased by 3.2% (from 1,963,229 to 2,027,567).

To simplify review:
1. Patch 1 uses mem_cgroup_iter with reclaim cookie in shrink_many()
2. Patch 2 removes the now-unused memcg LRU code
3. Patches 3–7 combine shrink_many and shrink_node_memcgs
   (This reorganization is clearer after switching to mem_cgroup_iter)

[1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
[2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com

---

Changes in v2:
1. Patch 1 now aligns more closely with shrink_node_memcgs
2. Patch 3 separates the flush_reclaim_state() changes into its own patch
3. Incorporated feedback/suggestions from Johannes and Shakeel.

Changes from RFC series:
1. Updated the test result data.
2. Added patches 3–5 to combine shrink_many and shrink_node_memcgs.

Chen Ridong (7):
  mm/mglru: use mem_cgroup_iter for global reclaim
  mm/mglru: remove memcg lru
  mm/mglru: make calls to flush_reclaim_state() similar for MGLRU and
    non-MGLRU
  mm/mglru: rename should_abort_scan to lru_gen_should_abort_scan
  mm/mglru: extend lru_gen_shrink_lruvec to support root reclaim
  mm/mglru: combine shrink_many into shrink_node_memcgs
  mm/mglru: remove memcg disable handling from lru_gen_shrink_node

 Documentation/mm/multigen_lru.rst |  30 ---
 include/linux/mmzone.h            |  89 ---------
 mm/memcontrol-v1.c                |   6 -
 mm/memcontrol.c                   |   4 -
 mm/mm_init.c                      |   1 -
 mm/vmscan.c                       | 313 +++---------------------------
 6 files changed, 31 insertions(+), 412 deletions(-)

-- 
2.34.1


