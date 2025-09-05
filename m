Return-Path: <cgroups+bounces-9731-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FE4B44F33
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D9E7BEED7
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354922F60B5;
	Fri,  5 Sep 2025 07:16:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA52F0673;
	Fri,  5 Sep 2025 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056563; cv=none; b=n5SV7/oZMucUleSlgIoTRwumiFhPs+L6APFkEvluBAFJeyj/vjgwPpAZ/xlAZxzNYpHuNjUJYlabZYl6E4FLABAReb/16B6brgOsO2nOLigyJUw5gVSbpmXICT9oCjZmOlRV2RuvvxGxHsCOqn1dOiGsrAGKysAjGYVN7ZQFTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056563; c=relaxed/simple;
	bh=t57rb5yBvC62q4IqqavVmH6NkPX7Rxvrv4mAtnmUr6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NXM55lrC1qmAHktXhxDVZfpMODo9l6DUXeARUwvwqsZM++aKVtHsLSSwkgaAVd+cCWUU7MqCZQK3XxEp4aqdHeUuWe4IImPt2EDKxZFJ5YIG/kdkwm8jPy4TDqIDDOzxw0LyvPt4nf5ktsXvTzY4yyeH1sZCRKrKv2gGbNciONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71C16PYzKHMmV;
	Fri,  5 Sep 2025 15:15:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E1C91A103F;
	Fri,  5 Sep 2025 15:15:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S13;
	Fri, 05 Sep 2025 15:15:58 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 09/16] md/raid10: add a new r10bio flag R10BIO_Returned
Date: Fri,  5 Sep 2025 15:06:36 +0800
Message-Id: <20250905070643.2533483-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S13
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43uF47XFWUGw1DWry3Arb_yoW8Xw48p3
	9rWry3Z3yjkF4UZw1DXw4UAasYy3WDKrW5Ca4vk3yrZFy3XFZ0kF18JayUXr4DXFWS9a47
	XF1UtrZrGF45tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The new helper bio_submit_split_bioset() can failed the orginal bio on
split errors, prepare to handle this case in raid_end_bio_io().

The flag name is refer to the r1bio flag name.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 8 +++++---
 drivers/md/raid10.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 859c40a5ecf4..a775a1317635 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -322,10 +322,12 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
 	struct bio *bio = r10_bio->master_bio;
 	struct r10conf *conf = r10_bio->mddev->private;
 
-	if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
-		bio->bi_status = BLK_STS_IOERR;
+	if (!test_and_set_bit(R10BIO_Returned, &r10_bio->state)) {
+		if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
+			bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+	}
 
-	bio_endio(bio);
 	/*
 	 * Wake up any possible resync thread that waits for the device
 	 * to go idle.
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 3f16ad6904a9..da00a55f7a55 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -165,6 +165,8 @@ enum r10bio_state {
  * so that raid10d knows what to do with them.
  */
 	R10BIO_ReadError,
+/* For bio_split errors, record that bi_end_io was called. */
+	R10BIO_Returned,
 /* If a write for this request means we can clear some
  * known-bad-block records, we set this flag.
  */
-- 
2.39.2


