Return-Path: <cgroups+bounces-2354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99989A9AE
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5981F223E7
	for <lists+cgroups@lfdr.de>; Sat,  6 Apr 2024 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415592C1A6;
	Sat,  6 Apr 2024 08:09:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51622F0F;
	Sat,  6 Apr 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712390957; cv=none; b=Xzxws0X6anV3kXNIYi6dWujH4Lfy8kAI54ZCP3WCOGxcYAMvB7LQPyPdB+xdYe4D31JaUHdYUsd2nvpKcFbZoRlvlF9SDVzKfRuHto80gp8lrjDZLlBt0WrezOc413jmIUPZp9uSm9PDV45TLtDt0y/1oRREUBYVClDNK4wPBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712390957; c=relaxed/simple;
	bh=iCfeyhGX9RMMXq590xrJBnszC/V6SW+D0j93ZZWz8N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AdauP58/t3PIL9QLw3nIab9zLPmZOhL+tOvUH/6UqhGTSO3OO8J27PStcvXe7pb+CKk/B6ataRTprW/c3/oWBXS2zQOwks/dxe2+dtQ9sjF+LatYx/54HaAywMZnYhdE3OWNTaZ6H5jwHXRdBW4jsK0NF+RZU94M9UMtr3fquU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBSg76qSmz4f3k6B;
	Sat,  6 Apr 2024 16:09:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 429DB1A0172;
	Sat,  6 Apr 2024 16:09:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAjAxFmnZTkJA--.2125S8;
	Sat, 06 Apr 2024 16:09:11 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	chenhuacai@kernel.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	jhs@mojatatu.com,
	svenjoac@gmx.de,
	raven@themaw.net,
	pctammela@mojatatu.com,
	yukuai3@huawei.com,
	qde@naccy.de,
	zhaotianrui@loongson.cn
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	cgroups@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 4/6] blk-cgroup: add a new helper blkg_conf_exit_blkg()
Date: Sat,  6 Apr 2024 16:00:57 +0800
Message-Id: <20240406080059.2248314-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAjAxFmnZTkJA--.2125S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43GF1ktFyDCr1kWw4kJFb_yoW8Cr45p3
	y2qr45K340gFnxZay3t3W7uryft3ykKry3J3yfGrWakr13try7uFn8AF40kFWrZFs7Ar45
	XrWFqrW0kr18CrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The new helper just release the spin_lock 'queue_lock' and keep the
mutex 'rq_qos_mutex' held, to allow blk_throttle and other cgroup
policies to be destroyed when they are disabled by user.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 17 +++++++++++++++++
 block/blk-cgroup.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b5e626a16758..ada9258f78bc 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -949,6 +949,23 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_exit);
 
+/*
+ * blkg_conf_exit_blkg - like blkg_conf_exit() but only release queue_lock.
+ * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
+ *
+ * This function must be called on all blkg_conf_ctx's initialized with
+ * blkg_conf_init().
+ */
+void blkg_conf_exit_blkg(struct blkg_conf_ctx *ctx)
+	__releases(&ctx->bdev->bd_queue->queue_lock)
+{
+	if (ctx->blkg) {
+		spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
+		ctx->blkg = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(blkg_conf_exit_blkg);
+
 static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
 {
 	int i;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 78b74106bf10..009f96191e71 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -219,6 +219,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx);
 void blkg_conf_exit(struct blkg_conf_ctx *ctx);
+void blkg_conf_exit_blkg(struct blkg_conf_ctx *ctx);
 
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
-- 
2.39.2


