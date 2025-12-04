Return-Path: <cgroups+bounces-12258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078BACA3AA3
	for <lists+cgroups@lfdr.de>; Thu, 04 Dec 2025 13:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B112B3096674
	for <lists+cgroups@lfdr.de>; Thu,  4 Dec 2025 12:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBDB341041;
	Thu,  4 Dec 2025 12:46:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785233DEF4;
	Thu,  4 Dec 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852403; cv=none; b=rZsilw99IoI6FbkYhKFQmXKj3hr1+c1uCGPyW5jrUIpvk9bgi/CqC6paYD+iy4lTQXcAbYQeo5F6x6z8x1cvQUJ/bi0/sa0RhvA1Gp4OwChDBaLbqz2uFnj0JSnkVgkuWuWD66qnEVxbq6lyp69nEdyHSBy3H86MI8p4ySZHxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852403; c=relaxed/simple;
	bh=YGVD2szU7T0Z+qZO+qTQxMHDld70oJAJHoQkiOQgl2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WItxZWDtOODnyzJR/YvL1Lo5QbP8MzfbQrNiEmfuv0N8i/eEO2IxTzCkB+hF+sRNPORJFgoWxH2t1T1z0yWOyqifSznuem41E3Py8m5iWPAnDmYPCf7qdytMYM7n3fq8MCP9MAMEf3mH1l3JZuJ6/CSFcpX03LaC6Ei1Q+fgiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dMZ4C5prPzKHMc1;
	Thu,  4 Dec 2025 20:45:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B2BE81A10CC;
	Thu,  4 Dec 2025 20:46:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgB3VlCRgjFp+BRLAg--.31494S2;
	Thu, 04 Dec 2025 20:46:34 +0800 (CST)
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
	yuzhao@google.com,
	zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [RFC PATCH -next 0/2]  mm/mglru: remove memcg lru
Date: Thu,  4 Dec 2025 12:31:22 +0000
Message-Id: <20251204123124.1822965-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3VlCRgjFp+BRLAg--.31494S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWfXw4xCw18Wr4DXr4rGrg_yoW8Aw43pF
	Z3Cay2qw1rJ34xGFs7K3WI934xZa4rGr47XryFgw1xAwsIyFn0vryIkr4rWFWUCryrtF43
	Xrn0y3W8XryUAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU07PEDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The memcg LRU was introduced for global reclaim to improve scalability,
but its implementation has grown complex. Moreover, it can cause
performance regressions when creating a large number of memory cgroups [1].

This series implements mem_cgroup_iter with a reclaim cookie in
shrink_many() for global reclaim, following the pattern already established
in shrink_node_memcgs(), an approach suggested by Johannes [1]. The new
approach provides good fairness across cgroups by preserving iteration
state between reclaim passes.

Testing was performed using the original stress test from Zhao Yu [2] on a
1 TB, 4-node NUMA system. The results show:

                                            before         after
    stddev(pgsteal) / mean(pgsteal)            91.2%         75.7%
    sum(pgsteal) / sum(requested)             216.4%        230.5%

The new implementation reduces the standard deviation relative to the mean
by 15.5 percentage points, indicating improved fairness in memory reclaim
distribution. The total pages reclaimed increased from 85,086,871 to
90,633,890 (6.5% increase), resulting in a higher ratio of actual to
requested reclaim.

To simplify review:
- Patch 1 uses mem_cgroup_iter with reclaim cookie in shrink_many()
- Patch 2 removes the now-unused memcg LRU code

[1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
[2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com

Chen Ridong (2):
  mm/mglru: use mem_cgroup_iter for global reclaim
  mm/mglru: remove memcg lru

 Documentation/mm/multigen_lru.rst |  30 ----
 include/linux/mmzone.h            |  89 ----------
 mm/memcontrol-v1.c                |   6 -
 mm/memcontrol.c                   |   4 -
 mm/mm_init.c                      |   1 -
 mm/vmscan.c                       | 270 ++++--------------------------
 6 files changed, 37 insertions(+), 363 deletions(-)

-- 
2.34.1


