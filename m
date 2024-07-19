Return-Path: <cgroups+bounces-3784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9DD937285
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 04:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE1FB21483
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 02:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EFD24211;
	Fri, 19 Jul 2024 02:37:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879515CB;
	Fri, 19 Jul 2024 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721356637; cv=none; b=n+KLbAWrJYDPatJXNVqVQB30//DG31mX7S3dZfCnrK6hW/bcz9pJ7EEb/yJsQ6UHqW/Eh0XHObFvFZzXOWQCzZVN91WEZCovKNn/pEM+AZ8QqKu7kRzo51L++/QE6ZKJC9vbaowEIvzVILbl2+EkVezBAMny53GMKAUaAfJGSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721356637; c=relaxed/simple;
	bh=faFEls+cYTyP0xuMiO/Tfnu5Q/JLDGXWl4bKnJLvyH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcktOofLi01JF/B7tJUo2Osam1EIYXKeg4XL2nOKFhFSAmusYcQCHf4lUNcRSDYCSygLu+P/kAdNMXixPxLlARAgBB8OHDtpsiR3nt+YM3JGE6IK0bTzVLG+I+JEv/k/N1Nm0a0NM7DjkkIw4h/D56vftz1lnH88Oz9bW9r/F7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQDMs34ZDz4f3kw1;
	Fri, 19 Jul 2024 10:36:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B51ED1A016E;
	Fri, 19 Jul 2024 10:37:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXuzlU0Zlmiw8kAg--.57041S5;
	Fri, 19 Jul 2024 10:37:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: bvanassche@acm.org,
	jack@suse.cz,
	hch@infradead.org,
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
Subject: [PATCH v2 1/3] blk-cgroup: check for pd_(alloc|free)_fn in blkcg_activate_policy()
Date: Fri, 19 Jul 2024 10:34:29 +0800
Message-Id: <20240719023431.3800647-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXuzlU0Zlmiw8kAg--.57041S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tw43Wr4kWr1kArykCw4rZrb_yoW8Xr4Dpr
	43KrW5C34vqF1xuanIg3WDtayrKan5Ww15Gry3X3ySvr47A393Kw4vy3s8XFWfZFs7JFW5
	ZFZIqay0kF10y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently all policies implement pd_(alloc|free)_fn, however, this is
not necessary for ioprio that only works for blkcg, not blkg.

There are no functional changes, prepare to cleanup activating ioprio
policy.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..dcd5e857650a 100644
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
@@ -1733,7 +1741,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 		goto err_unlock;
 	}
 
-	/* Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs */
+	/*
+	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
+	 * without pd_alloc_fn/pd_free_fn can't be activated.
+	 */
 	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
 		(!pol->pd_alloc_fn ^ !pol->pd_free_fn))
 		goto err_unlock;
-- 
2.39.2


