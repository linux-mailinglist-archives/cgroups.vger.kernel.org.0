Return-Path: <cgroups+bounces-4680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6BE969F72
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2024 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195831F25303
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C733A3BBF0;
	Tue,  3 Sep 2024 13:53:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C42A1CF;
	Tue,  3 Sep 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371610; cv=none; b=tu1+d/O/m/DygR/2jm6ToDEgG2Nba3w/+s3bFLODL1itjHU92A8ooHY0GtEjthbybTKXI/NAu8YfxuT1CVLDaGwKBSx5lIs3G798gAwFs/nY1+N8ResmPnjk8M1bjof3J4EIpeenOaBFwIVaiolFlnqF2frO4j3H+ENHIGCa/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371610; c=relaxed/simple;
	bh=SywWaAkoHJBn/AQ4VxVGTwmoDhjxboRfFYtHiI5+Txk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJq7nK0+Mdaop9IycGXYq2LvJY1K5Agn1WLLLW4gUkTHPTqGi2VRhgWX7CVSnNykIrJBLZh0OzFAjpwyexrDknwOWMLNDpdzdTJE1V19vhRHFuE1GC7Tj05pPfZsp7bJv0tGQJx3KRGZt0ACFCsH4fbJbl5EQYI394FXKe/VBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WynBs2s7jz4f3kpt;
	Tue,  3 Sep 2024 21:53:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A16751A07B6;
	Tue,  3 Sep 2024 21:53:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sbNFNdmiUgjAQ--.58276S5;
	Tue, 03 Sep 2024 21:53:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.12 1/2] blk-throttle: remove last_low_overflow_time
Date: Tue,  3 Sep 2024 21:51:48 +0800
Message-Id: <20240903135149.271857-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903135149.271857-1-yukuai1@huaweicloud.com>
References: <20240903135149.271857-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sbNFNdmiUgjAQ--.58276S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWDJr4kKFW8GFWkZr1kZrb_yoW8AFyrpr
	W7GF4UKws2qr4kKrZIq3W3XFyUJwsrJ3y3G395JF43Aay2v3sIgF1kur1rZ3y0vFsxCFWq
	vryqqrykGF4UW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

last_low_overflow_time is not used anymore after commit bf20ab538c81
("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW").

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 8 +-------
 block/blk-throttle.h | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index dc6140fa3de0..eb859c44c9f3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1611,17 +1611,13 @@ bool __blk_throtl_bio(struct bio *bio)
 	sq = &tg->service_queue;
 
 	while (true) {
-		if (tg->last_low_overflow_time[rw] == 0)
-			tg->last_low_overflow_time[rw] = jiffies;
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
 
 		/* if above limits, break to queue */
-		if (!tg_may_dispatch(tg, bio, NULL)) {
-			tg->last_low_overflow_time[rw] = jiffies;
+		if (!tg_may_dispatch(tg, bio, NULL))
 			break;
-		}
 
 		/* within limits, let's charge and dispatch directly */
 		throtl_charge_bio(tg, bio);
@@ -1661,8 +1657,6 @@ bool __blk_throtl_bio(struct bio *bio)
 		   tg->io_disp[rw], tg_iops_limit(tg, rw),
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
-	tg->last_low_overflow_time[rw] = jiffies;
-
 	td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
 	throttled = true;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 4d9ef5abdf21..1a36d1278eea 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -106,8 +106,6 @@ struct throtl_grp {
 	/* Number of bio's dispatched in current slice */
 	unsigned int io_disp[2];
 
-	unsigned long last_low_overflow_time[2];
-
 	uint64_t last_bytes_disp[2];
 	unsigned int last_io_disp[2];
 
-- 
2.39.2


