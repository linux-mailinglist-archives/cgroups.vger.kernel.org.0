Return-Path: <cgroups+bounces-9459-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEBB394A7
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 09:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B327C314D
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF832ECEA2;
	Thu, 28 Aug 2025 07:06:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272E2D77FA;
	Thu, 28 Aug 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364785; cv=none; b=MP6IvAtahhlo9kBrmrt8UsL5x4sNhGRrnu/Vxv1DWi8NnfzuYRwu8jYVZaYfYaojlG9voLq4nJqEGHfnCw5dwy+Xp8aliMGCRGOAZ6K1E/iytjoiKFv5XzfKXS/4vK9JQcYJ9X0ZNEzIxbqaOaVK7SqDkg9sr3dIe6oGXjx9wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364785; c=relaxed/simple;
	bh=FGLYhwy29nlrytFsgdNnHA3AqF9CFKlWz5l2I+s/DQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzk1fE8nqdefrvzqOE8VhNbNfq47aPUcGQKQ2XToYkkdGh+kSruya4s0GLZoemOEzaTFzOjxLMkl4a5OLVG3J/JjkDaoAGSrqh5mzKlvgBUMC/y7M0JYPSArWv1rtI62gOPQJ3OaAp0lMfATcZN8iiTwWiVXAY4/DK1dPh8dFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCC9j2R2szYQtLV;
	Thu, 28 Aug 2025 15:06:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D49D61A156B;
	Thu, 28 Aug 2025 15:06:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izh_69o_X89Ag--.14658S10;
	Thu, 28 Aug 2025 15:06:15 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	neil@brown.name,
	akpm@linux-foundation.org,
	hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	tieren@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v2 06/10] md/md-linear: convert to use bio_submit_split_bioset()
Date: Thu, 28 Aug 2025 14:57:29 +0800
Message-Id: <20250828065733.556341-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250828065733.556341-1-yukuai1@huaweicloud.com>
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Izh_69o_X89Ag--.14658S10
X-Coremail-Antispam: 1UD129KBjvdXoWrtw43GFWfuFWDZF1fuw4fuFg_yoWkuFc_Wa
	4ruFykWr1UK397Krn0qwsIv3yYgrs5WryDuFy2qa17A3WfZwn7Crn5Gw45X3yxXFWfXa45
	Ar42y34ftF1UJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRiHUDtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand unify bio split code, prepare to fix disordered split
IO; On the other hand fix missing blkcg_bio_issue_init() and
trace_block_split() for split IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-linear.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 5d9b08115375..76f85cc32942 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -256,18 +256,10 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 
 	if (unlikely(bio_end_sector(bio) > end_sector)) {
 		/* This bio crosses a device boundary, so we have to split it */
-		struct bio *split = bio_split(bio, end_sector - bio_sector,
-					      GFP_NOIO, &mddev->bio_set);
-
-		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
-			bio_endio(bio);
+		bio = bio_submit_split_bioset(bio, end_sector - bio_sector,
+					      &mddev->bio_set);
+		if (!bio)
 			return true;
-		}
-
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
 	}
 
 	md_account_bio(mddev, &bio);
-- 
2.39.2


