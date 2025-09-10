Return-Path: <cgroups+bounces-9854-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BCFB50E3F
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 08:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFDE7B5AC8
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7238F30DEC1;
	Wed, 10 Sep 2025 06:40:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9430BF73;
	Wed, 10 Sep 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486438; cv=none; b=Devyq0gUocdCMhSXBckcGjrWV0G+64PkW6S6KmuzYmM3KD8r5gGaCAyfkodPcjkyRioSRVXDff+9T7mDaAekAV+Qc3aDZiYia7gq7XmoKwWxfxmT+R4/XHNhSC7dvjIrUlm1ujbasPj/zvKHDsLnqW/XBTMv8Hxb8irMKz+phvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486438; c=relaxed/simple;
	bh=CYHChULvtY+aMhwaSVK+pko9zLGiDZoVDjdeMlAfJJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMSoBUJVJbsJskvyFNhc5/NsJ5kkWlY9dr3zf9RKqi9lKYShWN5ZzRXk+c018n6XKJCElmopRXQZcfv+1GP3l4JJWCg2Zm6p51Tvmp4AYBc6r/+UJc4E/thzKMetlzad6T5pWv7/XxrF6og3GSPbMKx1jvRM0IlFlQaGVp7AyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cMB014CFfzKHN6C;
	Wed, 10 Sep 2025 14:40:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C29711A11AA;
	Wed, 10 Sep 2025 14:40:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY1UHcFo3ZIJCA--.51912S17;
	Wed, 10 Sep 2025 14:40:33 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	neil@brown.name,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 for-6.18/block 13/16] blk-crypto: convert to use bio_submit_split_bioset()
Date: Wed, 10 Sep 2025 14:30:53 +0800
Message-Id: <20250910063056.4159857-14-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250910063056.4159857-1-yukuai1@huaweicloud.com>
References: <20250910063056.4159857-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY1UHcFo3ZIJCA--.51912S17
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW7Zw4UCFWDuryUtF15XFb_yoW8Xr4UpF
	1a9rW2qrWUJrnFkay2ga13KFn5Ka90qFy5JrWxX3ZxAr1Ivr1kKFs7ZryFqFy8A3yFkrWD
	Xwn7AF4S9ws8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Unify bio split code, prepare to fix ordering of split IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 27fa1ec4b264..86b27f96051a 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
-#include <trace/events/block.h>
 
 #include "blk-cgroup.h"
 #include "blk-crypto-internal.h"
@@ -222,20 +221,14 @@ static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
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


