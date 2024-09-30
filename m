Return-Path: <cgroups+bounces-4983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D411989D63
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 10:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACCA6B22437
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AD3183CCA;
	Mon, 30 Sep 2024 08:56:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80C17DFEB;
	Mon, 30 Sep 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686574; cv=none; b=YkRTRKQl5zu3Xssk4OlAqHhWQunn/tdISCZH+ybx5AD8d+Gvnn1BGvcb+9xcpklbQg9AyDcuz0OwIMuP2vV2CX5Z/tnq+KeGtdb1fpXw3ri0Pufl0S829qUOpFypShyy8ROFgUZLQ2wDtdLewHV2uuF+JqTLiQZFEPb/jjhiGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686574; c=relaxed/simple;
	bh=og/ZpgLgLs3C+isRBPNaeHdFYY+98m7ego/AVEB96tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgr6yXHBkR+gDlP9RFEwAzfBjNS9+/U43m8ACh0mlA7PyS3E063PI8BGccyp8BVRC51lptrMO3g5yVyuBuqyPbDI4V3w4H2Ig0S+t6GVqvtAfxco3iWdTfbZmQ60PGujbwttQ5xx14iLItURcWQqe83iMH5prpnkQjvtwRVxuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XHFKP0KQgz4f3nV8;
	Mon, 30 Sep 2024 16:55:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 37C981A092F;
	Mon, 30 Sep 2024 16:56:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28emZ_pmgEUMCw--.63034S8;
	Mon, 30 Sep 2024 16:56:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 4/5] blk-iolatency: use new helper blkg_print_dev_name()
Date: Mon, 30 Sep 2024 16:53:01 +0800
Message-Id: <20240930085302.1558217-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
References: <20240930085302.1558217-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28emZ_pmgEUMCw--.63034S8
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1rCw48AF1rJr1rJr1xAFb_yoWfKwbE9F
	Z7Z3ZIvr93WF4YvFWkCF1fXry0kr1kXF1xWayxA34DZF4FqFWkAFZrArs09F4aqF4xK345
	AF98ur4fJr1IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbv8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

To avoid abuse of bdi_dev_name().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iolatency.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ebb522788d97..9c9ab4a73e0b 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -898,12 +898,15 @@ static u64 iolatency_prfill_limit(struct seq_file *sf,
 				  struct blkg_policy_data *pd, int off)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
-	const char *dname = blkg_dev_name(pd->blkg);
 
-	if (!dname || !iolat->min_lat_nsec)
+	if (!iolat->min_lat_nsec)
 		return 0;
-	seq_printf(sf, "%s target=%llu\n",
-		   dname, div_u64(iolat->min_lat_nsec, NSEC_PER_USEC));
+
+	if (!blkg_print_dev_name(sf, pd->blkg))
+		return 0;
+
+	seq_printf(sf, " target=%llu\n",
+		   div_u64(iolat->min_lat_nsec, NSEC_PER_USEC));
 	return 0;
 }
 
-- 
2.39.2


