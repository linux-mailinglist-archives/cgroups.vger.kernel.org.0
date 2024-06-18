Return-Path: <cgroups+bounces-3221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4174C90C25E
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 05:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78151F23804
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 03:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F919DF71;
	Tue, 18 Jun 2024 03:18:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8F19B3FF;
	Tue, 18 Jun 2024 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680731; cv=none; b=qvUnpUmnKK6ZjJa3+xbRrpw1o3LYfdzlqYUgvgU8pCIOpWzq9/ijgZ7KUEye3D2RFbQ5yqM9rpmXR6tXMO9cyzR7ekqFyv0UKe4R1qXUPTZmID6KdVGhd1dW83/fXm72UdRArzDkjw+xWl6ektzaFo0d4DjXAFs2nj7BWCSVzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680731; c=relaxed/simple;
	bh=37FNoyThb91+k69BH2A2XMi5p5DkUSGVuJLuAHPERM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SvXhkBlD4XoYCEUBkR+l34MXmzRUc+6IVfkJID+i5b/OMoK/aoOUW+cACphwVA1ghHVmBAQmedDNMNvzBAqOAtzVTZX9kh7MC5Ku8TdC/keP9U7o5m+ZlzSAbx1g2kDpJQhUcRGwEcqK0zhwi0oxpURWWyOVLI7P+Y67FABzkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W3Bm63cljz4f3jsP;
	Tue, 18 Jun 2024 11:18:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D15111A0181;
	Tue, 18 Jun 2024 11:18:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXAQ+N_HBmFJj8AA--.12964S6;
	Tue, 18 Jun 2024 11:18:40 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	bvanassche@acm.org,
	hch@infradead.org,
	josef@toxicpanda.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 2/7] cgroup: export cgroup_parse_float
Date: Tue, 18 Jun 2024 11:17:46 +0800
Message-Id: <20240618031751.3470464-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
References: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXAQ+N_HBmFJj8AA--.12964S6
X-Coremail-Antispam: 1UD129KBjvdXoWruryUXryxGFy3Jw4Duw15urg_yoWxZFX_Aw
	1DWry0grWxA3ZF934qqws3Xayv9w4rKFWqv34UJFyUAF1DJF95JwnIqr15trsxCan7tryU
	uF9xurn7tr4DGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6AFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbdOz7UUUUU=
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The symbol is used by iocost, prepare to build iocost as kernel module.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 kernel/cgroup/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4abd817b0c7c..81b579495f8c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6966,6 +6966,7 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
 	*v = whole * power_of_ten(dec_shift) + frac;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cgroup_parse_float);
 
 /*
  * sock->sk_cgrp_data handling.  For more info, see sock_cgroup_data
-- 
2.39.2


