Return-Path: <cgroups+bounces-9461-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358BB394B7
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 09:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F4F173619
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F62F7446;
	Thu, 28 Aug 2025 07:06:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F362E0B55;
	Thu, 28 Aug 2025 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364786; cv=none; b=GsXF3RsqHDkDry3qmhSG3aflUHXIdeYcCBkPyd/bI+4DerY5hOKuRvx004LWJnkVI4MWlkQOHq2Kk9FDU6w0xV0ll2hzYX5BYQk6VJgNjkgdGA7MjDSI5F3fJsIzRau6g0br3KpEXCOkKhR18jxqKLkT3Jk58E5eMuVJ2b9p5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364786; c=relaxed/simple;
	bh=WKYbnLBmIvalKSVpovZvWe4Z3P0Ec5QsPs9wHco190E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMwDhqUnihVymR3DOVjcutHgAo7E7DEfd/T9VZccknvIklGYnEjly6mGQplDXS3uvcbM0kS9dxaNVYMERFp+v5FsXH/fZhRr7z4ByfFNKgTGD3Ct986sWHboTr3p03UFTGwq3ksdbCdYW38gZTPFmlkdkJk/JCWBw8dOdYjd6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCC9n09k9zKHMcp;
	Thu, 28 Aug 2025 15:06:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD7B31A171E;
	Thu, 28 Aug 2025 15:06:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Izh_69o_X89Ag--.14658S14;
	Thu, 28 Aug 2025 15:06:20 +0800 (CST)
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
Subject: [PATCH RFC v2 10/10] md/raid0: convert raid0_make_request() to use bio_submit_split_bioset()
Date: Thu, 28 Aug 2025 14:57:33 +0800
Message-Id: <20250828065733.556341-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn8Izh_69o_X89Ag--.14658S14
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1rJF1DAw1xXw1xCF4fuFg_yoW8Gry7pw
	43WF4Sq3yUJFZYgwsrXa4qyas5AFyjgrW8KFZ8X3s5ur1Ivr9Fkr4Yg34rtFy5ArWrCF98
	tw1vyrn8C3WUJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, raid0_make_request() will remap the original bio to underlying
disks to prevent disordered IO. Now that bio_submit_split_bioset() will put
original bio to the head of current->bio_list, it's safe converting to use
this helper and bio will still be ordered.

On the one hand unify bio split code; On the other hand fix missing
blkcg_bio_issue_init() and trace_block_split() for split IO.

CC: Jan Kara <jack@suse.cz>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid0.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 4dcc5133d679..8773f633299e 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -607,17 +607,9 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 		 : sector_div(sector, chunk_sects));
 
 	if (sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, sectors, GFP_NOIO,
-					      &mddev->bio_set);
-
-		if (IS_ERR(split)) {
-			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
-			bio_endio(bio);
+		bio = bio_submit_split_bioset(bio, sectors, &mddev->bio_set);
+		if (!bio)
 			return true;
-		}
-		bio_chain(split, bio);
-		raid0_map_submit_bio(mddev, bio);
-		bio = split;
 	}
 
 	raid0_map_submit_bio(mddev, bio);
-- 
2.39.2


