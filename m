Return-Path: <cgroups+bounces-4986-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5183989D6A
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 10:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016601C2089A
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 08:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACA7186616;
	Mon, 30 Sep 2024 08:56:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136C17E01C;
	Mon, 30 Sep 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686575; cv=none; b=OMzmIbHVfbZG/hXMCd116NfMW5EIrX3XcayB5kPUVBNsJu0ecIEh9ziho1TCpjwx2p0TwmnkoZff8YN+2b1Cjn1qqL0I45DUs0Yel3rmk5R1F6Cdy+YZx2MQqH/LhqCgAKmp38ougYe9LvgmY+p59TmO7dYyxP1iQD5WmsyvNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686575; c=relaxed/simple;
	bh=drZJL2piV7NklwiJ2htFBgPFgSly6mlsIsh7VP8yoMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lh4UITRDry5Rv7/yOMG8nuSmhAdbid2GvB3XjPSZH43xK387D44/WDXpP7IptohnRxxfsWsXczA5f0nHQ5ObxxIJZnxsRYTc8nC/MVDgevBmNQB9Bv9mfNfDe3iJu3k5cCh678Ob9FhuhfqU1W9x+83OiQCj0srpQ7PJnVfl4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XHFKN1GqQz4f3nby;
	Mon, 30 Sep 2024 16:55:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 570081A07B6;
	Mon, 30 Sep 2024 16:56:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28emZ_pmgEUMCw--.63034S6;
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
Subject: [PATCH 2/5] blk-iocost: use new helper blkg_print_dev_name()
Date: Mon, 30 Sep 2024 16:52:59 +0800
Message-Id: <20240930085302.1558217-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28emZ_pmgEUMCw--.63034S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5Cr47tFW5XryxZw17Awb_yoW5Xry5pF
	Wa939rt3yavr1IqF13JF42vwn5Gw4jgr43XrZ3CryfG3W2qr1IgFnrCryvyr4rZa4fArZ8
	WFZagr4UCr17ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUczV8UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

To avoid abuse of bdi_dev_name().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5a6098a3db57..eede926937ac 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3067,11 +3067,14 @@ static void ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
 static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 			     int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 
-	if (dname && iocg->cfg_weight)
-		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
+	if (!iocg->cfg_weight)
+		return 0;
+
+	if (blkg_print_dev_name(sf, pd->blkg))
+		seq_printf(sf, " %u\n", iocg->cfg_weight / WEIGHT_ONE);
+
 	return 0;
 }
 
@@ -3160,15 +3163,14 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 			  int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
 	struct ioc *ioc = pd_to_iocg(pd)->ioc;
 
-	if (!dname)
+	if (!blkg_print_dev_name(sf, pd->blkg))
 		return 0;
 
 	spin_lock_irq(&ioc->lock);
-	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
-		   dname, ioc->enabled, ioc->user_qos_params ? "user" : "auto",
+	seq_printf(sf, " enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
+		   ioc->enabled, ioc->user_qos_params ? "user" : "auto",
 		   ioc->params.qos[QOS_RPPM] / 10000,
 		   ioc->params.qos[QOS_RPPM] % 10000 / 100,
 		   ioc->params.qos[QOS_RLAT],
@@ -3359,18 +3361,17 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 static u64 ioc_cost_model_prfill(struct seq_file *sf,
 				 struct blkg_policy_data *pd, int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
 	struct ioc *ioc = pd_to_iocg(pd)->ioc;
 	u64 *u = ioc->params.i_lcoefs;
 
-	if (!dname)
+	if (!blkg_print_dev_name(sf, pd->blkg))
 		return 0;
 
 	spin_lock_irq(&ioc->lock);
-	seq_printf(sf, "%s ctrl=%s model=linear "
+	seq_printf(sf, " ctrl=%s model=linear "
 		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
 		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
-		   dname, ioc->user_cost_model ? "user" : "auto",
+		   ioc->user_cost_model ? "user" : "auto",
 		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
 		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
 	spin_unlock_irq(&ioc->lock);
-- 
2.39.2


