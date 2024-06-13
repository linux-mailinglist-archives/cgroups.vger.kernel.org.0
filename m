Return-Path: <cgroups+bounces-3166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EDA906152
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026961C211AF
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90717756;
	Thu, 13 Jun 2024 01:50:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F2015E83;
	Thu, 13 Jun 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243418; cv=none; b=p7dwCwf03L74kAGNA71fZjK4Mv+HL5GB8g9WJuZdLM0iD3YzzEU24qKWs8v8cU25JcbVob2TOfMuDEw9WvlQXdocmcxTKiLPj834+0KM2lkPgO78kieJvyFMZibRwMU8KQxLdeE/nZUyIs1W584wi3VHqVl7xNLh8YnF39T4hXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243418; c=relaxed/simple;
	bh=YIvPD7brCk1ohgELzPqSstLRQ3OgyZ58vBlizoogkBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIvOELUzek3T6/mHl5AW7J/peTxTq9JR0bgzRgCvdLl7fU92J8YL69iliRoM2l5avYSHIOM6GiuZLyozECE+kuiikZUTm1Tx5PNZ5FVkYfSBQNvAKtedZISSV7cYMwykEasbKOVPObVyLNC2WSHEnxktgXyA2ZWEmxKgMAkAMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W052K2shGz4f3kKj;
	Thu, 13 Jun 2024 09:50:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0253F1A0EFE;
	Thu, 13 Jun 2024 09:50:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFNUGpm3eFSPQ--.6570S5;
	Thu, 13 Jun 2024 09:50:07 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	gregkh@linuxfoundation.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC -next 1/7] kernfs: export pr_cont_kernfs_path()
Date: Thu, 13 Jun 2024 09:49:31 +0800
Message-Id: <20240613014937.1326020-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFNUGpm3eFSPQ--.6570S5
X-Coremail-Antispam: 1UD129KBjvdXoWrXF1xXFyrJr1rZr47Zr1kKrg_yoWxGFc_JF
	1kG348Kw13WFy7Arn8AwsxtryF9as3uF4Fyay3Ca90yFn0ya4rJrZay3Z8ZrnxWFyjg3s3
	ZFn0grZFvrW2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6AFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjFdgJUUUUU=
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This helper is used in iocost, prepare to build iocost as kernel module.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/kernfs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe..84ad163a4281 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -279,6 +279,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 out:
 	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
 }
+EXPORT_SYMBOL_GPL(pr_cont_kernfs_path);
 
 /**
  * kernfs_get_parent - determine the parent node and pin it
-- 
2.39.2


