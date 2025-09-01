Return-Path: <cgroups+bounces-9531-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5FDB3D7A7
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D14F189A144
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E89258ECB;
	Mon,  1 Sep 2025 03:41:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E61242917;
	Mon,  1 Sep 2025 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698083; cv=none; b=iOcZBbywlGCYn21Txrk3l4Rcs39Z7OHeZkDk3gSHCbRsT36KZst3b8axgtaDWkji4ttuBWpAav10D1S2ur2aXDBVcyjnlvmImPJijlkSu7EqZUs9vgiZaieTjqIeRCSlI99A4Mc/51sDMqtpnZHdyHreVO3NxdSXe2d3Uuy2Qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698083; c=relaxed/simple;
	bh=Z6V/LgmG/FexB1shTnKIy8K9gHJHd6QaaMdS5h7cdbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uh3OG8R4XIVS6U09hqWVcGIGp1Jat8QLFfiLk3T9REiglYyWJlaplH7fAZ4d1d38710sBo5k3JQX6i21K15sVDJ2+EJICUL2k+1IB6U1Uaq3hulo+0guoBl5Ldq88L6+cdD5uDqdGVXL2030uMaI7K5htMzTWsVX++1NGaSAKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFZRP27XBzYQvPX;
	Mon,  1 Sep 2025 11:41:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C7F751A18FB;
	Mon,  1 Sep 2025 11:41:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzWFbVotmf1Aw--.38057S12;
	Mon, 01 Sep 2025 11:41:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	kmo@daterainc.com,
	satyat@google.com,
	ebiggers@google.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v3 08/15] md/raid10: add a new r10bio flag R10BIO_Returned
Date: Mon,  1 Sep 2025 11:32:13 +0800
Message-Id: <20250901033220.42982-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250901033220.42982-1-yukuai1@huaweicloud.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIzWFbVotmf1Aw--.38057S12
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43ZFW3Gw1rJw4fKF1DGFg_yoW8XFWxp3
	9xWry3Z3yjka1UZr1DX3yUAasYv3ZrKrWjka4vk3yrZFy3XFZ0k3W8JayUXrWDXFWS9a47
	XF1UtrZrGF45tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Prepare to unfiy the bio split code, the helper
bio_submit_split_bioset() can failed the orginal bio on split errors.

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


