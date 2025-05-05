Return-Path: <cgroups+bounces-8022-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402E7AAA0F0
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 00:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFB017A646
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 22:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A162983E2;
	Mon,  5 May 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft0EfMFc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC992980D9;
	Mon,  5 May 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483532; cv=none; b=aTu2PF++YuhpVycYX2gN9jR1bAmc2hlUS5//5VscNt3AQFBJc23FJzEV3aYtg+DMPb7MWhHVaBICJ3c7LQ1JWoNWcu9hqO6KqCoX11pm6MoncveMT+Xb+zAnxdVVF+7JVIINQynSKIfKmP3gcgEbBcRhr6kax8x9i598lP1umOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483532; c=relaxed/simple;
	bh=YvkgPaVDGWc2VA02vFpJo5W0VJJjB35QXXBCWd/5JuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzXsmBT1KVqirdZeD6oSqsYlAoyucu2r/cYnixmyWehhSz0pjVz3einx4FBuuWpbpzTQcqREfZQuw9Dz8j/lhWZXwOQXLML/BdRhfBlH5FSqcG+TpmBh0NdlbsYJk+C88GJxwhsI8EWi8ezAUIO7rbKhSlwvV5Zs+AaWlfuGcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft0EfMFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0B8C4CEEE;
	Mon,  5 May 2025 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483532;
	bh=YvkgPaVDGWc2VA02vFpJo5W0VJJjB35QXXBCWd/5JuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ft0EfMFcvldoDy1jdZ2sH3tcJMcjN605wAZIcO1eBOJSlci7J9AKPitKc9RVGLn7Y
	 5CaFW4QPmgkDnOznsKZEign5cUopLDBQt8C+rccphraQ9OGgz2cRaPfi7QH5BRbwEj
	 oMGj3rVQehm5WHwyP7qprfGTl8kHOZ5oozgu8+hQxoA8nBuvOT9pdj0EKxUb2iOPMR
	 p/Cdlb17N9AgTj2jmKySEjXVLgvy1BLq9JD1eSbrNxkpyxQAAsZW639niRlKVBdnOC
	 5sIEQ4OcAQX4tJRBTXqcwsJGbWuoMiPxADaeCNhKzQA+QTLLv/u6O8AIIGEifMVar0
	 WgUsxeDlceoZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	Wen Tao <wentao@uniontech.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 103/642] blk-cgroup: improve policy registration error handling
Date: Mon,  5 May 2025 18:05:19 -0400
Message-Id: <20250505221419.2672473-103-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Chen Linxuan <chenlinxuan@uniontech.com>

[ Upstream commit e1a0202c6bfda24002a3ae2115154fa90104c649 ]

This patch improve the returned error code of blkcg_policy_register().

1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
   function pairs to the start of blkcg_policy_register(). This ensures
   we immediately return -EINVAL if the function pairs are not correctly
   provided, rather than returning -ENOSPC after locking and unlocking
   mutexes unnecessarily.

   Those locks should not contention any problems, as error of policy
   registration is a super cold path.

2. Return -ENOMEM when cpd_alloc_fn() failed.

Co-authored-by: Wen Tao <wentao@uniontech.com>
Signed-off-by: Wen Tao <wentao@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c94efae5bcfaf..8b07015db819a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1727,27 +1727,27 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	struct blkcg *blkcg;
 	int i, ret;
 
+	/*
+	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
+	 * without pd_alloc_fn/pd_free_fn can't be activated.
+	 */
+	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
+	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
+		return -EINVAL;
+
 	mutex_lock(&blkcg_pol_register_mutex);
 	mutex_lock(&blkcg_pol_mutex);
 
 	/* find an empty slot */
-	ret = -ENOSPC;
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (!blkcg_policy[i])
 			break;
 	if (i >= BLKCG_MAX_POLS) {
 		pr_warn("blkcg_policy_register: BLKCG_MAX_POLS too small\n");
+		ret = -ENOSPC;
 		goto err_unlock;
 	}
 
-	/*
-	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
-	 * without pd_alloc_fn/pd_free_fn can't be activated.
-	 */
-	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
-	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
-		goto err_unlock;
-
 	/* register @pol */
 	pol->plid = i;
 	blkcg_policy[pol->plid] = pol;
@@ -1758,8 +1758,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 			struct blkcg_policy_data *cpd;
 
 			cpd = pol->cpd_alloc_fn(GFP_KERNEL);
-			if (!cpd)
+			if (!cpd) {
+				ret = -ENOMEM;
 				goto err_free_cpds;
+			}
 
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
-- 
2.39.5


