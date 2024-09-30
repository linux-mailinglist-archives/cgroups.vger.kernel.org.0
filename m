Return-Path: <cgroups+bounces-4987-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F4989D6F
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 10:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF621F214A1
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B417187875;
	Mon, 30 Sep 2024 08:56:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85F17E918;
	Mon, 30 Sep 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686576; cv=none; b=QMuqiwYS0yAn/M+zZNY1hF4W/2CEGSEaFHayk4raJyBmLxayZLwTWmDWavQK3/PnJ2j0uQMl5EeeL6joLGZsU7PJhN4BgkHZu/Ej7fv34FAwZhVcNAA4pK098bkeIucacJKlS7rwwX2DaS3OBDVXurHnzG7H93pGrUU7T3A4+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686576; c=relaxed/simple;
	bh=Cv5Fqr5fUDP+WM4qhGcV6/fa5KcFQBnq86VjMWn/mtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StiAFTxNd9s0QdNJ8vDT/WvPNnJeUiklovfMOnLVfo3L/uoYmyYK8A0UuIEyrr60Co4PvM0M+iUlc9Ixu9AQziQwVBVPfD/HJ8xhHcv1BMBR3NFP6s4SZ7ry3VGRvKMp0QRrvQ/9pofk1AyMv7eRGNzjTFtLeSGJ+CmS8z/ZVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XHFKV2kGhz4f3kkd;
	Mon, 30 Sep 2024 16:55:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C43991A058E;
	Mon, 30 Sep 2024 16:56:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28emZ_pmgEUMCw--.63034S7;
	Mon, 30 Sep 2024 16:56:09 +0800 (CST)
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
Subject: [PATCH 3/5] blk-throttle: use new helper blkg_print_dev_name()
Date: Mon, 30 Sep 2024 16:53:00 +0800
Message-Id: <20240930085302.1558217-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28emZ_pmgEUMCw--.63034S7
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1rCw48AF15Kr43WFWfZrb_yoWkAFg_uF
	ykCr18XFn3Ja4kArWDAr95ZFW2g3Zaqr10ga48Ja4xZr1aqan5Jay7XrsrKrWxZFWSk3sx
	J3Z8XrW8AF1FqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

To avoid abuse of bdi_dev_name().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6943ec720f39..35d86d7570c5 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1381,15 +1381,8 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 			 int off)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
-	const char *dname = blkg_dev_name(pd->blkg);
-	u64 bps_dft;
-	unsigned int iops_dft;
-
-	if (!dname)
-		return 0;
-
-	bps_dft = U64_MAX;
-	iops_dft = UINT_MAX;
+	u64 bps_dft = U64_MAX;
+	unsigned int iops_dft = UINT_MAX;
 
 	if (tg->bps[READ] == bps_dft &&
 	    tg->bps[WRITE] == bps_dft &&
@@ -1397,7 +1390,9 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	    tg->iops[WRITE] == iops_dft)
 		return 0;
 
-	seq_printf(sf, "%s", dname);
+	if (!blkg_print_dev_name(sf, pd->blkg))
+		return 0;
+
 	if (tg->bps[READ] == U64_MAX)
 		seq_printf(sf, " rbps=max");
 	else
-- 
2.39.2


