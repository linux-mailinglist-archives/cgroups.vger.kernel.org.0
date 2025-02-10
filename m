Return-Path: <cgroups+bounces-6474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC00A2E28F
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 04:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A93165A49
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 03:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DAE6F06B;
	Mon, 10 Feb 2025 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="izFeY0F4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8B3D3B3;
	Mon, 10 Feb 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739157612; cv=none; b=KSbS0VN3nM7rbBSVpUw0UZNfBvTsYBzV/I1Y1JpZUY47iQnoFFZtCnec4mLGCwGlz/Zam/95MpPgvFY/8Ffep3Y5fUALyIHA1F3BL9n7UKf8evZYXhlAiZXf5g0rHALaioyUohjx7MjMt0b/2ejKRFxLKjT+4Ccdq7Vy6+UqtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739157612; c=relaxed/simple;
	bh=FTNloSIsULYEVQLn77ypmmzSibgTN2hcd9NUNMfbr8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KgzNLrr/631gWW41PLROETaHNqCka8v8Bjjbs8Xw/oPe1xfIPnXjyOEZTnQ58wW95IQG14kjZcWQuEx4MexbYD9OwpVFEKD5K4VaVNpzJIuTHEvjw3CgGEOh/yg4vlrL+3/M5ARizCEOGxdgNqwwrmz5IcOUtdqY9qHdptd2RM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=izFeY0F4; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739157572;
	bh=k4n8m3GI4D6i5H2T1WzC/bEg9b4WYBfpAGAFhLHf9F4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=izFeY0F44k9M+yuGMamxD6wbzZhlatPt1KHzVljKhu5CkhvqDL5dA418XR2WQb/Y6
	 czKJH6XqXIIVAFO7oaw+pvRTEM3ASqKheZNrV2S6DUVBSlLdxjtX1zhabO0LiWw7vy
	 kgw0sKgTfU3Fm+TWaeaJi+M4ocu0WWYW+mej2Xr8=
X-QQ-mid: bizesmtp77t1739157546t4ra4iro
X-QQ-Originating-IP: VepxTGZxCLaidXlt0efKUm5/0axcq1XJMTlwOZ3rS/w=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Feb 2025 11:19:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9070452930109930730
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	Wen Tao <wentao@uniontech.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blk-cgroup: validate alloc/free function pairs at the start of blkcg_policy_register()
Date: Mon, 10 Feb 2025 11:18:27 +0800
Message-ID: <EE1CE61DFCF2C98F+20250210031827.25557-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MoXwTY6T4qpU1nqYPWHDHMHsNormvuAYQflUpqvdEWjiX597abV/b92U
	I/WtBJPl0OnLAxuhnVdYA0zoq9DSZYjWcrOf9lfYzNTKlVbIfFoIvuTXZCTckk45V/8CdhB
	E56ZmRxqWZvElJXcnhfk6DqPZ01tDfBUQ4yFpGN3DGF6VFHj7g7wMSshZl/19hvkdSU7UIw
	ctWP4ONI0T7wIVHMVOJD5n3IsGCjIF7mYQCN1KTC2Q14XF/vUfl9VBrqk3UZm6faU6WNz1i
	AP6x8xIBlyiQJrmxkRPXZgo7CxUnGp7BFXqqGEGWnqJlCxtjOevfe7UGK/ySSz09WDL5axQ
	TNyITz5Zo1ywdex6ow4QB/GF5N/gvRNslSEYu0A5LFd/qAQPCsBBlf8urVy5FTfQo4qJdQV
	wgC/D4bFhx0BqtSN9dPhpQBNkcn87lLVHzTR17C68lq+wterRQTmQ1vdhm5Z7wWrXeSp0SM
	gMnZX/b9Lg6zpKYWnFAJBoR0vBA9/Iz+eOngR361K8pVEe8KQo1bNhXfiRipN7UDgBOiSE5
	O55v8YHXI4KqlVTl7QQsQCbGpvEWwzDdd5BSbetIHbPbDEriCH6wr+D7N9wwwlbH/GjIRDr
	c0ajsISnxhO38mt3Wj4B5nir2PFVkktIQEYoZ1peCy4GdP+cypiNquO8rau6Z5/SaLnWMlY
	1pBZp30upyaVKXKXoTro6+yplSjBIUB2Tl/63jqDmqkPTrZH11xPKqhBBDy0cUE8ir0cMM5
	WbZdopqMs7d2haX+enjDjNsdaV3uaikbrzrayR5zv58RfBn6xtiPjJTmvH7l5Z6M9PhTcA9
	QZ//G3Bs7bAhoMSw96Ryiiw0YG+IEVdzh3Y4UoU6ZyDSPXVKzGfbD3qqMtcLX9ObbMibcWN
	V6QzkMWjSuuhn1AXnOovd2JCpHs/SYn2aOSUzU2tS5sAE4iPYdLOutBZsNEzIssXviy2trL
	vHRcQwcNTZnJp3BBt6seHOjj+0NqdPLBXS9F41F8kGjnzYpiDrvKXXo+pmdgrk7YqQA8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn function
pairs to the start of blkcg_policy_register(). This ensures we immediately
return -EINVAL if the function pairs are not correctly provided, rather
than returning -ENOSPC after locking and unlocking mutexes unnecessarily.

Co-authored-by: Wen Tao <wentao@uniontech.com>
Signed-off-by: Wen Tao <wentao@uniontech.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 block/blk-cgroup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754..81c166ee003b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1727,6 +1727,14 @@ int blkcg_policy_register(struct blkcg_policy *pol)
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
 
@@ -1740,14 +1748,6 @@ int blkcg_policy_register(struct blkcg_policy *pol)
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
-- 
2.43.0


