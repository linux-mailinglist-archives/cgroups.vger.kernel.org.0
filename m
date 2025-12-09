Return-Path: <cgroups+bounces-12299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA53CAEA4F
	for <lists+cgroups@lfdr.de>; Tue, 09 Dec 2025 02:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6504300C5FB
	for <lists+cgroups@lfdr.de>; Tue,  9 Dec 2025 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B72FF178;
	Tue,  9 Dec 2025 01:41:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6D2FE59C;
	Tue,  9 Dec 2025 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244475; cv=none; b=mWQeeYHA2u+/H+WlKP+PXQ+l/80mClhOCljZKi1npVhwhywV16/X995tKETe+Da3GzUp0SgyjR7SbGzmmgh4LRAq25ZPBEIjjhENly/vgVwvtQHlLc+ANfifF2pxk1epuFHdf/IpC+149RTAsu/wH9b+lZdQThkmg5+yVVYMB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244475; c=relaxed/simple;
	bh=0105pBY1ohCG8qmHrwhoXva//9/RsKnAMwO8OytJUU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M0KFdENMAWKig/X4jsrbbnKXJGyij4G4V7wYNbrypMVmPz6hZg4bWBItBrMWs9raJDMdAH72wUw/hPWW5PkmewCcsSdX6qqdZ5sa/PeYvQx19TPCznMhkdOQU3p2fveU3brZaPF4z6V/G+fy1Nd4AxFKNseX4gvYsl7ZpA57so4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dQM3w6wpzzKHMHr;
	Tue,  9 Dec 2025 09:40:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C974F1A1537;
	Tue,  9 Dec 2025 09:41:10 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgBnRlAafjdpkF9fBA--.23909S2;
	Tue, 09 Dec 2025 09:41:08 +0800 (CST)
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
	zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com,
	zhongjinji@honor.com
Subject: [PATCH -next 0/5] mm/mglru: remove memcg lru
Date: Tue,  9 Dec 2025 01:25:52 +0000
Message-Id: <20251209012557.1949239-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnRlAafjdpkF9fBA--.23909S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW3Kr4rAF43Xr4rtw4rGrg_yoW8tFWxpF
	Z3ua47Kw4rCr47GFs7Ka4Uu34fZF4rAw47Wr1vg34fAr9IyFyqvr4xtw4rZFW8CrWSqry3
	Xr1q93W8XF4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
3. Patches 3–5 combine shrink_many and shrink_node_memcgs
   (This reorganization is clearer after switching to mem_cgroup_iter)

---

Changes from RFC series:
1. Updated the test result data.
2. Added patches 3–5 to combine shrink_many and shrink_node_memcgs.

RFC: https://lore.kernel.org/all/20251204123124.1822965-1-chenridong@huaweicloud.com/

Chen Ridong (5):
  mm/mglru: use mem_cgroup_iter for global reclaim
  mm/mglru: remove memcg lru
  mm/mglru: extend shrink_one for both lrugen and non-lrugen
  mm/mglru: combine shrink_many into shrink_node_memcgs
  mm/mglru: factor lrugen state out of shrink_lruvec

 Documentation/mm/multigen_lru.rst |  30 ---
 include/linux/mmzone.h            |  89 --------
 mm/memcontrol-v1.c                |   6 -
 mm/memcontrol.c                   |   4 -
 mm/mm_init.c                      |   1 -
 mm/vmscan.c                       | 332 ++++--------------------------
 6 files changed, 44 insertions(+), 418 deletions(-)

-- 
2.34.1


