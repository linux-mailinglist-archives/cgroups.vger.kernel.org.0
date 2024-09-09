Return-Path: <cgroups+bounces-4755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2F971B63
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1038A1C231B5
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B81BA291;
	Mon,  9 Sep 2024 13:43:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D31B9B4F;
	Mon,  9 Sep 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889433; cv=none; b=RQlQbxeJBGg59LkMGXvVmgaOHCer0DCpaZC1u5T4doCIGO0eBXUhxOtnSMM9rZuwSFkCAQrvV9Toy4Ci9wPfR2wPYYO3PUXYJg2H/jogcYOLoaBEFRMDVaMLMzXrvf+MWbl4pxpjml1YtgBDoXsXTeviok1gjiHt+3PyeVBeuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889433; c=relaxed/simple;
	bh=ZU6WUfnJgbPfm9I3WKRHA7moxiFbdUTwltzaU/8MSHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAiXP2irjF9/3RM0RGwFBU4XWy+HgW7fD6VgzJg770NSiXfw9W0nk031GcjaNKMl1m+D6iA4y5/iqbGKOpqaYPd6HNIm0uBHCbLYJ2TJugYuyRofVcG9UuIeJq1jueXzKbfsawqxfB64Tym0Ov7+3waRjji88tzG9jvhoKyUxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2Shz6X4Zz4f3lCm;
	Mon,  9 Sep 2024 21:43:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0ED571A018D;
	Mon,  9 Sep 2024 21:43:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn28eQ+95mhC1hAw--.55605S8;
	Mon, 09 Sep 2024 21:43:47 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai3@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.12 4/7] block, bfq: remove bfq_log_bfqg()
Date: Mon,  9 Sep 2024 21:41:51 +0800
Message-Id: <20240909134154.954924-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909134154.954924-1-yukuai1@huaweicloud.com>
References: <20240909134154.954924-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28eQ+95mhC1hAw--.55605S8
X-Coremail-Antispam: 1UD129KBjvdXoWrKry5Aw1rXF47ZryxJw4UCFg_yoWkJrcEy3
	4kK3yrArW8GrWkGr1qvr45Xa1UWaySq3Wqgr95KrWDJ3W3t3Z5CwnIqrWY9rZxJFWa9a13
	Ars0qay7tF1ktjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
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
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

It's not used, hence can be removed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index e16d96e2367b..687a3a7ba784 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1185,11 +1185,6 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 			"%s " fmt, pid_str, ##args);			\
 } while (0)
 
-#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)	do {			\
-	blk_add_cgroup_trace_msg((bfqd)->queue,				\
-		&bfqg_to_blkg(bfqg)->blkcg->css, fmt, ##args);		\
-} while (0)
-
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
@@ -1199,7 +1194,6 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 	bfq_bfqq_name((bfqq), pid_str, MAX_BFQQ_NAME_LENGTH);		\
 	blk_add_trace_msg((bfqd)->queue, "%s " fmt, pid_str, ##args);	\
 } while (0)
-#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
 
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
-- 
2.39.2


