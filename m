Return-Path: <cgroups+bounces-10437-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C6B9E084
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 10:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5214B1B24BE1
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C525927280E;
	Thu, 25 Sep 2025 08:25:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283D28F4;
	Thu, 25 Sep 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788753; cv=none; b=QTMqqoX+JA+xqfMQq5tWNBdwgTUbyuzYTDLfnAFShK7IYnjZWBugGhV0wyvx6JDKSj/xffG6itSe+nKcWCoh/PLjgkji8TPSsu8T4IOuLEeUtR35RVtjJI9dPZZLWd8r0U0CnUD4E/PDyR4DRzh/NyVUM3L13ytQsARcISuIWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788753; c=relaxed/simple;
	bh=uyoC33L1mECK04nAwihRRbXpUtfFIt3Cv02wrL29ymk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nt+pGh9L0rGTeyJ0vL5mZVS101ZKGgdA6ZEpVb911gRBW4OFgNtcKK943itbYggP5rijov0QG4kB5MhIFuobuS+i3OaH2/qneB6x7dY8fraWSHhrIWh13Gpp9ACSdQN0pUvOryNYZJ1tcAfLo+GQKXphF8CcXB1mfbLPdK6gXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXRcN2h7bzKHN4Q;
	Thu, 25 Sep 2025 16:25:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A3941A0B16;
	Thu, 25 Sep 2025 16:25:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCna2OH_NRodTcIAw--.12615S7;
	Thu, 25 Sep 2025 16:25:47 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hch@lst.de,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	vgoyal@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 03/10] blk-cgroup: don't nest queu_lock under rcu in bio_associate_blkg()
Date: Thu, 25 Sep 2025 16:15:18 +0800
Message-Id: <20250925081525.700639-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250925081525.700639-1-yukuai1@huaweicloud.com>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCna2OH_NRodTcIAw--.12615S7
X-Coremail-Antispam: 1UD129KBjvdXoWrKryrGry3KFWkur1rZF4kCrg_yoWkuFX_XF
	1ku3sYgwn5A3W3try5ZF1YvFW8C3yqqr1qga4Y9a43Cry5AFZFgr9Fyw45ArW5Z3Z7Cryj
	vrWDXr47Grn2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRl_MsUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

If bio is already associated with blkg, blkcg is already pinned until
bio is done, no need for rcu protection; Otherwise protect blkcg_css()
with rcu independently. Prepare to convert protecting blkcg with
blkcg_mutex instead of queue_lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ffc3195f7e4..53a64bfe4a24 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2165,16 +2165,20 @@ void bio_associate_blkg(struct bio *bio)
 	if (blk_op_is_passthrough(bio->bi_opf))
 		return;
 
-	rcu_read_lock();
-
-	if (bio->bi_blkg)
+	if (bio->bi_blkg) {
 		css = bio_blkcg_css(bio);
-	else
+		bio_associate_blkg_from_css(bio, css);
+	} else {
+		rcu_read_lock();
 		css = blkcg_css();
+		if (!css_tryget_online(css))
+			css = NULL;
+		rcu_read_unlock();
 
-	bio_associate_blkg_from_css(bio, css);
-
-	rcu_read_unlock();
+		bio_associate_blkg_from_css(bio, css);
+		if (css)
+			css_put(css);
+	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg);
 
-- 
2.39.2


