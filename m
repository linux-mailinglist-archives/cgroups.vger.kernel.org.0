Return-Path: <cgroups+bounces-6646-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5081CA406F3
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 10:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F8F19C6E34
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A22207A10;
	Sat, 22 Feb 2025 09:32:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64054207650;
	Sat, 22 Feb 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216740; cv=none; b=dxRgLrf41AowuwM3B0r848IU8fAphf2r/geNfXcN+JchWrq6uI1LnNroccKLNafU91e647h5KctBONbEFE7N7ejuz2nbKAv4/xiCXiSehhR79Ieb14P1luCloid8No0SDy07bY1Gk2xBSyv03zd5aF7e+HJTP8NDkii24vjIPSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216740; c=relaxed/simple;
	bh=gwQE5wEdPcBjj+HrMVOJn+F/5JlzlrpsqdOEB+uyPXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAIEMtcF44HqqSCDXaKVDaEiQaQY7QAJ69ujayRwDZHMdxG2497P9bKzvL9fss7/IWCve2i0aF/YAgklDXHcFlJaPLLdv8Zl/sWv/jUCem7ooC4nbSjjlPuH0zDTp7qj6GEHBWL2cc76CxCeyv/DhKNQd5JnOdY/F6N9lt1Z/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z0MFz5lQkz4f3jXT;
	Sat, 22 Feb 2025 17:31:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7C3A51A058E;
	Sat, 22 Feb 2025 17:32:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2CamblnnzpDEg--.20805S6;
	Sat, 22 Feb 2025 17:32:13 +0800 (CST)
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
Subject: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
Date: Sat, 22 Feb 2025 17:28:23 +0800
Message-Id: <20250222092823.210318-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnC2CamblnnzpDEg--.20805S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrWw4kXF17XF13tr4fXwb_yoWrAw47pr
	W3Kw4YgF4DXFnxKF13A3W3XFW5JrWkAFy7G3y3G3y7AFn0kryqvFn5ZrWYyay8ZF93uF42
	vrnFqr9rCF1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOdgAUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

wait_time is based on jiffies, and the calculation is:

wait_time = extra_bytes * HZ / bps_limit;

If wait time is not zero, the remainder is ignored, means wait time is
short by at most 1 jiffes; On the other hand, if wait time is zero, it
will be used as 1 jiffies, means it's excessive by at most 1 jiffes.

This way causes blktests throtl/001 failure in case of CONFIG_HZ_100=y,
fix the problem by recording remainder as debt, and repay the debt
later.

Reported-and-tested-by: Ming Lei <ming.lei@redhat.com>
Closes: https://lore.kernel.org/all/20250220111735.1187999-1-ming.lei@redhat.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 24 +++++++++++++++++-------
 block/blk-throttle.h | 12 ++++++++----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0096e486b1e3..3828c6535605 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -703,9 +703,10 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 }
 
 static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
-				u64 bps_limit)
+				u64 bps_limit, bool *has_debt)
 {
 	bool rw = bio_data_dir(bio);
+	long long carryover_bytes;
 	long long bytes_allowed;
 	u64 extra_bytes;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
@@ -730,10 +731,16 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Calc approx time to dispatch */
 	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
-	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
-
-	if (!jiffy_wait)
-		jiffy_wait = 1;
+	jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit, &carryover_bytes);
+	if (carryover_bytes) {
+		/*
+		 * If extra_bytes is not divisible, the remainder is recorded as
+		 * debt. Caller must ensure the current slice has at least 1
+		 * more jiffies to repay the debt.
+		 */
+		*has_debt = true;
+		tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);
+	}
 
 	/*
 	 * This wait time is without taking into consideration the rounding
@@ -754,6 +761,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
 	u64 bps_limit = tg_bps_limit(tg, rw);
 	u32 iops_limit = tg_iops_limit(tg, rw);
+	bool has_debt = false;
 
 	/*
  	 * Currently whole state machine of group depends on first bio
@@ -784,18 +792,20 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	else
 		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
 
-	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
+	bps_wait = tg_within_bps_limit(tg, bio, bps_limit, &has_debt);
 	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
 	if (bps_wait + iops_wait == 0) {
 		if (wait)
 			*wait = 0;
+		if (has_debt)
+			throtl_extend_slice(tg, rw, jiffies + 1);
 		return true;
 	}
 
 	max_wait = max(bps_wait, iops_wait);
 	if (wait)
 		*wait = max_wait;
-	throtl_extend_slice(tg, rw, jiffies + max_wait);
+	throtl_extend_slice(tg, rw, jiffies + max_wait + has_debt);
 
 	return false;
 }
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 1a36d1278eea..56dcb5ce412f 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -110,10 +110,14 @@ struct throtl_grp {
 	unsigned int last_io_disp[2];
 
 	/*
-	 * The following two fields are updated when new configuration is
-	 * submitted while some bios are still throttled, they record how many
-	 * bytes/ios are waited already in previous configuration, and they will
-	 * be used to calculate wait time under new configuration.
+	 * The following two fields are updated when:
+	 * 1) new configuration is submitted while some bios are still
+	 * throttled, they record how many bytes/ios are waited already in
+	 * previous configuration;
+	 * 2) IOs which may cause priority inversions are dispatched while tg is
+	 * over limit, these IOs will be dispatched directly;
+	 * 3) While calculating wait_time for IO, extra_bytes * HZ is not
+	 * divisible by bps_limit, the remainder will be recorded;
 	 */
 	long long carryover_bytes[2];
 	int carryover_ios[2];
-- 
2.39.2


