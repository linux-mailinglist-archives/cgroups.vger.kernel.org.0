Return-Path: <cgroups+bounces-13128-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B39D16D1F
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 167E630A4B50
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074F28B4F0;
	Tue, 13 Jan 2026 06:19:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD350368293;
	Tue, 13 Jan 2026 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285194; cv=none; b=cJZvYnwjujHKV+WtlXO4XhHXqjTrgRns6kjpeFF2OneMTmWK44rvl7gemqP92bdWYf39hXLJk3x52QedTAhT/mlQmURGWtr2W5zHIO2EKug7fEVQEaQ5Mypdke9jhclg7RURPZPXz+GMurLwVkAuq59IlJJv/oDh0bYGKJMX8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285194; c=relaxed/simple;
	bh=KBF8jz+ebcC1qqOqMiUvSGUGHcenXLyqk+wzOIWALfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W1I6aaeK11kSW3E1xGoJddGnxSzyIuMdCPSme5La9AsrPPtEOP8uNUZm1S1c5Tn9QMVTaUCFwH9bVFCt7YfBVUhkR5NYZkqLpWNXCGJ/ZjEgqXQAyPYxKc2JfrJ+dq6/BdJ2jO5/MEV6O+vPE46f9Egth+gpe9wswJEGnyImkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dqzc14nP7zYQtrW;
	Tue, 13 Jan 2026 14:19:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A4C940571;
	Tue, 13 Jan 2026 14:19:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgC3ZPX642VpuTeEDg--.370S6;
	Tue, 13 Jan 2026 14:19:41 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai3@huawei.com,
	hch@infradead.org
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH v2 2/3] blk-cgroup: skip dying blkg in blkcg_activate_policy()
Date: Tue, 13 Jan 2026 14:10:34 +0800
Message-Id: <20260113061035.1902522-3-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3ZPX642VpuTeEDg--.370S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1fZw17Jw4ftFyDWryrtFb_yoW8AFyDp3
	9xWFn8Cr9xWFy8ua1q9a47X34FyF48Jr45XFWSk39I9rsxXw1SyF17urs8XrWxZFsrtay3
	ZrnFqa4jkw4UK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UJ
	xhLUUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

When switching IO schedulers on a block device, blkcg_activate_policy()
can race with concurrent blkcg deletion, leading to a use-after-free in
rcu_accelerate_cbs.

T1:                               T2:
		                  blkg_destroy
                 		  kill(&blkg->refcnt) // blkg->refcnt=1->0
				  blkg_release // call_rcu(__blkg_release)
                                  ...
				  blkg_free_workfn
                                  ->pd_free_fn(pd)
elv_iosched_store
elevator_switch
...
iterate blkg list
blkg_get(blkg) // blkg->refcnt=0->1
                                  list_del_init(&blkg->q_node)
blkg_put(pinned_blkg) // blkg->refcnt=1->0
blkg_release // call_rcu again
rcu_accelerate_cbs // uaf

Fix this by replacing blkg_get() with blkg_tryget(), which fails if
the blkg's refcount has already reached zero. If blkg_tryget() fails,
skip processing this blkg since it's already being destroyed.

Link: https://lore.kernel.org/all/20260108014416.3656493-4-zhengqixing@huaweicloud.com/
Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 600f8c5843ea..5dbc107eec53 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1622,9 +1622,10 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 			 * GFP_NOWAIT failed.  Free the existing one and
 			 * prealloc for @blkg w/ GFP_KERNEL.
 			 */
+			if (!blkg_tryget(blkg))
+				continue;
 			if (pinned_blkg)
 				blkg_put(pinned_blkg);
-			blkg_get(blkg);
 			pinned_blkg = blkg;
 
 			spin_unlock_irq(&q->queue_lock);
-- 
2.39.2


