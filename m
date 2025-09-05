Return-Path: <cgroups+bounces-9734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A156DB44F1A
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1385A4786
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C552F99AA;
	Fri,  5 Sep 2025 07:16:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38025B1FF;
	Fri,  5 Sep 2025 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056566; cv=none; b=sGHUvKULN2vztwoHnmpCGW5Wk/aWxx/ydNj+xIaUK8Piu+wU2hkJiIbm2sXixHF/U0VdUbNyhhqQBTVqkmmKBGPN3dvJiQVHT5uukxcJ0gvVzW0jTgx3omItDpb7cMiQg+Ed2AKsp5l/sycEHE5yUR73E3QupMn2CM+8X1BHqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056566; c=relaxed/simple;
	bh=iSRuSofFjS1GPEfyY4dAz5/id5SpvFrgDpGVrvGHhqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWNr2R4kQOPVN35Kqi+hQt/Hp2KjsfYzEN6vIi2BMkNhBF4WawmND1kptcoMfMmn1OC1Corel2doVAmNvxDnGl3uJKY1qoABdw1ssN6u+xDox2ELh1P+sMEiTzVnGlnEtmqyuogIINEjP82r3GPfxda0NMegID7JAzPGVm9wfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ71G4QzbzKHMwl;
	Fri,  5 Sep 2025 15:16:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8D8781A135A;
	Fri,  5 Sep 2025 15:16:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S17;
	Fri, 05 Sep 2025 15:16:02 +0800 (CST)
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
Subject: [PATCH for-6.18/block 13/16] blk-crypto: convert to use bio_submit_split_bioset()
Date: Fri,  5 Sep 2025 15:06:40 +0800
Message-Id: <20250905070643.2533483-14-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S17
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW7Zw1ftw47GrW5Cr4DArb_yoW8Gry7pF
	1a9rWjgrW5JrnFka12ga1fKF1kta90qFy5JrWxX3ZxAr1Iyr1kKFs7ZryFqFy8C3yFkrWD
	Gwn7AF15Cws8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Unify bio split code, prepare to fix reordered split IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-crypto-fallback.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 1f9a4c33d2bd..88539e058bf0 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
-#include <trace/events/block.h>
 
 #include "blk-cgroup.h"
 #include "blk-crypto-internal.h"
@@ -223,20 +222,14 @@ static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
 		if (++i == BIO_MAX_VECS)
 			break;
 	}
-	if (num_sectors < bio_sectors(bio)) {
-		struct bio *split_bio;
 
-		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
-				      &crypto_bio_split);
-		if (IS_ERR(split_bio)) {
-			bio->bi_status = BLK_STS_RESOURCE;
+	if (num_sectors < bio_sectors(bio)) {
+		bio = bio_submit_split_bioset(bio, num_sectors,
+					      &crypto_bio_split);
+		if (!bio)
 			return false;
-		}
 
-		bio_chain(split_bio, bio);
-		trace_block_split(split_bio, bio->bi_iter.bi_sector);
-		submit_bio_noacct(bio);
-		*bio_ptr = split_bio;
+		*bio_ptr = bio;
 	}
 
 	return true;
-- 
2.39.2


