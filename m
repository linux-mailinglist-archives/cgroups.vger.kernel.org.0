Return-Path: <cgroups+bounces-4982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FD989D5F
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 10:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD028352E
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ECA181D00;
	Mon, 30 Sep 2024 08:56:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131613DB92;
	Mon, 30 Sep 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686574; cv=none; b=VM16x9zgIpzTpatINqkejp1rYmjd3aHdToi413S5JzkKhC71wquh69IRWVPM5swx3BV845T05i4LLGerlWP/A8Wc8cnapq0kj+RcnUwmpiIDanFrw4GhfzANxx1zhUXhUPZ1RCFqSyqpnUBDWgFnXjSXSj1eyn1Y7g8I2eNf68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686574; c=relaxed/simple;
	bh=F5hBlWKSQTKJ0TBhuFW7eiyaUzN2AmHFwdYvxcrj45c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/5E+De0hPLmcyj6pbxSFOVWioxsC3MTg7njnGpK9Yiu5r1W0gf5uOlF8k6J432++JzOvw0MoR7dE4euMOegSp5zfx2kOEquCrWq5fa1UGldP6ydWEcgqjDAMVyiCgkGayTwaOcmkVT1DWGcmzAehpzDCdyo1L/8sR2OaM71j0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XHFKT3Z8pz4f3kkG;
	Mon, 30 Sep 2024 16:55:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E05931A0568;
	Mon, 30 Sep 2024 16:56:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28emZ_pmgEUMCw--.63034S5;
	Mon, 30 Sep 2024 16:56:08 +0800 (CST)
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
Subject: [PATCH v2 1/5] blk-cgroup: add a new helper blkg_print_dev_name()
Date: Mon, 30 Sep 2024 16:52:58 +0800
Message-Id: <20240930085302.1558217-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28emZ_pmgEUMCw--.63034S5
X-Coremail-Antispam: 1UD129KBjvdXoWrur17Zw17Aw1kCrWDJF4DXFb_yoWDCFX_WF
	97Cry8X3Z3Aan7GF90yFnIqrWUCw45XrW0gasIgF9rAF13XFs7A3y7Jw4kJ3yxuFZxG345
	C3y7Ars7CrnavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
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
	nUUI43ZEXa7VUbn2-7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The bdi_dev_name() should not be used in blk-cgroup code, because bdi is
not related at all, add a new helper to print device name directly from
gendisk. The helper can also fix that "unknown" will be printed for
hidden disks.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index b9e3265c1eb3..d62bcc2bae14 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -239,6 +239,18 @@ static inline bool bio_issue_as_root_blkg(struct bio *bio)
 	return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
 }
 
+static inline bool blkg_print_dev_name(struct seq_file *sf,
+				       struct blkcg_gq *blkg)
+{
+	struct gendisk *disk = blkg->q->disk;
+
+	if (!disk)
+		return false;
+
+	seq_printf(sf, "%u:%u", disk->major, disk->first_minor);
+	return true;
+}
+
 /**
  * blkg_lookup - lookup blkg for the specified blkcg - q pair
  * @blkcg: blkcg of interest
-- 
2.39.2


