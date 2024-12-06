Return-Path: <cgroups+bounces-5769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0EB9E6382
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 02:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F1816A352
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 01:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDA9145A18;
	Fri,  6 Dec 2024 01:45:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD313C677;
	Fri,  6 Dec 2024 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449509; cv=none; b=Z7UhNtc16ElIK+TN4Sz+RQ+POSUHhm4g9b6t9TfUpn/kTh6UKSUKUdl88y9NNIS/KUNtU7j2JjTXbm11w1yNwaqAWbIVmV9KmHAGgCNyBoZ2WzaXzheaPOPvDzzFUUK3CHf5msA90dw9WoMhvwRmrb05jyxkRNL6s5MhkeB85ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449509; c=relaxed/simple;
	bh=BVAAda1tLg5pIMwh4c9Z4Tb7TM1e9QabNLUmbZrnPNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXRKpCdpefW2mUikSv12CgGKgfXJZ+uQP1bhIybtRDc36NLJxBSGQq7aFiFT+tcO0Kt1n264YFJmc2QrABXwkperQHUVMhreKNBg6VPTeib0Bv0oWyr8ROyIR3hhm3vMBjtM07WPhgsbcoz54FaYXR8StkpdtWiTYfEqHecn8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y4DZz5760z4f3jR1;
	Fri,  6 Dec 2024 09:44:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BBCAD1A018D;
	Fri,  6 Dec 2024 09:45:02 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgD30oYKV1JnkkskDw--.31315S5;
	Fri, 06 Dec 2024 09:45:02 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	davidf@vimeo.com,
	vbabka@suse.cz
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [next -v1 3/5] memcg: simplify the mem_cgroup_update_lru_size function
Date: Fri,  6 Dec 2024 01:35:10 +0000
Message-Id: <20241206013512.2883617-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206013512.2883617-1-chenridong@huaweicloud.com>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD30oYKV1JnkkskDw--.31315S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJryftr4ruw4ftw4xGFWrGrg_yoW8Jw1Upw
	srCa4Fya4rZry3XwnrtFn8uayfAa18tay8A343Xw13Jr13K340934DKrW8WFW7Xa4kCF43
	XFWDJr4ft3yDZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbd-BtUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

In the `mem_cgroup_update_lru_size` function, the `lru_size` should be
updated by adding `nr_pages` regardless of whether `nr_pages` is greater
than 0 or less than 0. To simplify this function, add a check for
`nr_pages` == 0. When `nr_pages` is not equal to 0, perform the same
actions.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/memcontrol.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index da6e4e9bd0fa..f977e0be1c04 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1280,15 +1280,14 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 	unsigned long *lru_size;
 	long size;
 
-	if (mem_cgroup_disabled())
+	if (mem_cgroup_disabled() || !nr_pages)
 		return;
 
 	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	lru_size = &mz->lru_zone_size[zid][lru];
 
-	if (nr_pages < 0)
-		*lru_size += nr_pages;
 
+	*lru_size += nr_pages;
 	size = *lru_size;
 	if (WARN_ONCE(size < 0,
 		"%s(%p, %d, %d): lru_size %ld\n",
@@ -1296,9 +1295,6 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 		VM_BUG_ON(1);
 		*lru_size = 0;
 	}
-
-	if (nr_pages > 0)
-		*lru_size += nr_pages;
 }
 
 /**
-- 
2.34.1


