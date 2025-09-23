Return-Path: <cgroups+bounces-10381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29634B94E99
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A377A3AF0B0
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B88314A67;
	Tue, 23 Sep 2025 08:05:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56792253F20;
	Tue, 23 Sep 2025 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614738; cv=none; b=YdhnXMSxh6h4RTCQTcKlZDMEnQiNWgLT/wWAH/pJ2uZBgJTFziifINacpW3rWQe+u2BYpI6bjEjepSd/l2AuaZ29FipCWtF59B4fdXIYnu0y5wfXBgW07XmVYdS65tXb0gh57r4arOtEbGDD7p8kB13ubZNyUP32sLOe01Mr5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614738; c=relaxed/simple;
	bh=boFE5m4LYGEbcDTZFzMDSwGaywi/35xpv1Jf/2oquE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8oS38nfXBkMJdIMTID8rxgns4+ltPKMxsAB04LB5mYiKuH+vt2u8JRdkV2QCd7BmYjkDS7SXCsx4eF2WL4wrF7vwANRtcTPURM07LFhGPQLZUvBy1C3JprRMi1aX5/d0SiAh0OWkWpiVXbrZw1nVZn1qoXkGDGhVxV/qfcxAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cWCG13Wm1zKHN0L;
	Tue, 23 Sep 2025 16:05:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F82D1A1B4E;
	Tue, 23 Sep 2025 16:05:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjGTLVNJoHpMlAg--.40262S5;
	Tue, 23 Sep 2025 16:05:34 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: nilay@linux.ibm.com,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 1/2] blk-cgroup: allocate policy data with GFP_NOIO in blkcg_activate_policy()
Date: Tue, 23 Sep 2025 15:55:19 +0800
Message-Id: <20250923075520.3746244-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjGTLVNJoHpMlAg--.40262S5
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWxZFykCrWruw47uryDKFg_yoWDurb_ua
	4DW34xZFZ3Arnakw1vy3WYqF9Fkrs8Gr4jgFySqF9rAF1DXFZ7A3WxAw17WrW3CFW5Cry7
	JF909r4qvrnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbQxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v2
	6r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjrHUDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Queue is freezed while activating policy, allocate memory with queue
freezed has the risk of deadlock because memory reclaim can issue new
IO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7246fc256315..0c7b58696d3c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1630,7 +1630,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 		if (!pd) {
 			/*
 			 * GFP_NOWAIT failed.  Free the existing one and
-			 * prealloc for @blkg w/ GFP_KERNEL.
+			 * prealloc for @blkg w/ GFP_NOIO.
 			 */
 			if (pinned_blkg)
 				blkg_put(pinned_blkg);
@@ -1642,7 +1642,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 			if (pd_prealloc)
 				pol->pd_free_fn(pd_prealloc);
 			pd_prealloc = pol->pd_alloc_fn(disk, blkg->blkcg,
-						       GFP_KERNEL);
+						       GFP_NOIO);
 			if (pd_prealloc)
 				goto retry;
 			else
-- 
2.39.2


