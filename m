Return-Path: <cgroups+bounces-6645-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DFDA406F2
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 10:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BE219C6E7B
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 09:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77370207A09;
	Sat, 22 Feb 2025 09:32:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7E20764B;
	Sat, 22 Feb 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216740; cv=none; b=qdeU19K+qhbzsdfGCwcPIdFYjEqSQeulHUJmbRAolT8ArJFVZoZYUEGOu4EUaWRDqfcGEQC5D0Lt8L/nxnmoK/leYT/NrNgIFCdkzNvS4e+otxdzj9CiSUEqIpOISyNmMuGkTZjLYGz2K2xoAJFBTIhn70qxgWd9w+sGQDwHNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216740; c=relaxed/simple;
	bh=9YaRZ4hzRifS3Bnu6tcC01Ehxpe8/bIdEVhNDZSV7ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfbjLYVLxgJ2PiFsPXM1u7MGKFlvBZK8RULc4yxsxYRBuJOaLAvHInz88uPVzeux8B1C7Vex7ZNfrprsOV/qRDvdLmu8Dwolyq9pWlk5iE6NM15dnT11qI2LeAp42ieey7b909sUYA9Vg2eWeovt7qZvadw51JGH5IP5YrsrN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0MFx54tqz4f3lCm;
	Sat, 22 Feb 2025 17:31:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA87D1A06DC;
	Sat, 22 Feb 2025 17:32:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2CamblnnzpDEg--.20805S5;
	Sat, 22 Feb 2025 17:32:12 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
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
Subject: [PATCH 1/2] blk-throttle: cleanup throtl_extend_slice()
Date: Sat, 22 Feb 2025 17:28:22 +0800
Message-Id: <20250222092823.210318-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250222092823.210318-1-yukuai1@huaweicloud.com>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2CamblnnzpDEg--.20805S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DWr15WryUCr4kZr1DWrg_yoW8AFyfpr
	W3Aw4jgF4DXFnrKFWY9wn8tFWjkws7Jry7Aa47WrWfAF12v34DKF1DZr1FvFWkAF929F40
	9rykA34fK3WjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8T5lUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Merge time_before() from caller into throtl_extend_slice() to make code
cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8d149aff9fd0..0096e486b1e3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -524,6 +524,9 @@ static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
 static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
 				       unsigned long jiffy_end)
 {
+	if (!time_before(tg->slice_end[rw], jiffy_end))
+		return;
+
 	throtl_set_slice_end(tg, rw, jiffy_end);
 	throtl_log(&tg->service_queue,
 		   "[%c] extend slice start=%lu end=%lu jiffies=%lu",
@@ -778,12 +781,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	 */
 	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
 		throtl_start_new_slice(tg, rw, true);
-	else {
-		if (time_before(tg->slice_end[rw],
-		    jiffies + tg->td->throtl_slice))
-			throtl_extend_slice(tg, rw,
-				jiffies + tg->td->throtl_slice);
-	}
+	else
+		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
 
 	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
 	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
@@ -794,12 +793,9 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	}
 
 	max_wait = max(bps_wait, iops_wait);
-
 	if (wait)
 		*wait = max_wait;
-
-	if (time_before(tg->slice_end[rw], jiffies + max_wait))
-		throtl_extend_slice(tg, rw, jiffies + max_wait);
+	throtl_extend_slice(tg, rw, jiffies + max_wait);
 
 	return false;
 }
-- 
2.39.2


