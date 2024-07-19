Return-Path: <cgroups+bounces-3795-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF8937449
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 09:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799681F22A16
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 07:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345946214D;
	Fri, 19 Jul 2024 07:17:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6D47A66;
	Fri, 19 Jul 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373472; cv=none; b=WURnbhmi19SE7D8gMjiwFQPS49X1YzrXsgBe221INMoVeFhJY1umyCrLMXAGxxswLTU5iUkj7OjSnv8vLYEX5AznJgOloNIbpRbr0RpuWC07VwzEwuNdQMfDDjHLrKwKPkOPxiNrIlnHY++TYynsE4o9NnBkxlBf2GR0yN7foPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373472; c=relaxed/simple;
	bh=zpsBydU5m8ReLgfsydRwWnWa3+B3tQpIQ1ymD7Q7pMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pBFm/8EBbWc1VUlgabBjtoabEhE4xThkRL3oEGOW+kXl7qvDislUasMgF8okllygd7vvt0Y9peuO/JKskLEy05/+359j9M8doOrYhAcvKQoCLogM1h+dYIzHBxm/rCHAWfLhMJR7R5cRNu3Avj4WYuNNDv75WFrQ6a5flkDCmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQLbk3Dfgz4f3jZX;
	Fri, 19 Jul 2024 15:17:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 82DE61A016E;
	Fri, 19 Jul 2024 15:17:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHazkXE5pmhaA2Ag--.65311S5;
	Fri, 19 Jul 2024 15:17:46 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	bvanassche@acm.org,
	jack@suse.cz,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 1/3] blk-cgroup: check for pd_(alloc|free)_fn in blkcg_activate_policy()
Date: Fri, 19 Jul 2024 15:15:04 +0800
Message-Id: <20240719071506.158075-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240719071506.158075-1-yukuai1@huaweicloud.com>
References: <20240719071506.158075-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazkXE5pmhaA2Ag--.65311S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tw43Wr4kWr1kAFy5Wr1xXwb_yoW8Wr43pr
	43KrW5A34vqF1xua1ag3WUJayrKws5Xw15G343X3ySvr42yrZ3Kw1kA3s8XFWxZrs7JF45
	ZFsIvay0kF10y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfU8XdbUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently all policies implement pd_(alloc|free)_fn, however, this is
not necessary for ioprio that only works for blkcg, not blkg.

There are no functional changes, prepare to cleanup activating ioprio
policy.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..3fa21b941e89 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1554,6 +1554,14 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	if (blkcg_policy_enabled(q, pol))
 		return 0;
 
+	/*
+	 * Policy is allowed to be registered without pd_alloc_fn/pd_free_fn,
+	 * for example, ioprio. Such policy will work on blkcg level, not disk
+	 * level, and don't need to be activated.
+	 */
+	if (WARN_ON_ONCE(!pol->pd_alloc_fn || !pol->pd_free_fn))
+		return -EINVAL;
+
 	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 retry:
@@ -1733,9 +1741,12 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 		goto err_unlock;
 	}
 
-	/* Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs */
+	/*
+	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
+	 * without pd_alloc_fn/pd_free_fn can't be activated.
+	 */
 	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
-		(!pol->pd_alloc_fn ^ !pol->pd_free_fn))
+	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
 		goto err_unlock;
 
 	/* register @pol */
-- 
2.39.2


