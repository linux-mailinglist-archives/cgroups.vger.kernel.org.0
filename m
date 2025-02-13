Return-Path: <cgroups+bounces-6530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92266A33633
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 04:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319F01886D67
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2FA204F8B;
	Thu, 13 Feb 2025 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IVh9g+s+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C52046A0;
	Thu, 13 Feb 2025 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417938; cv=none; b=XXrDWgx9cPs1esWfglUIuFTEFNECu5TMTYleFjZCtY6SH8ngdQYhOcapBTp4F0TkIrrW79wyP5uzmREpuoVZl+Ybnf3k1lFUnhb0hgh2mxmkQsDcscfb5/LjhCdAj2QiF8qZyxUQhmTsI9xV+moP6/BVp/4kTz2enUU4p5cJQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417938; c=relaxed/simple;
	bh=p+GcvKfhlbd+fG5D6B3IdokvI8Xp9YdH8bZih/gPh1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1PeoAcwfrLy16KzjC2a6WItdiCZCzDdSvGheHV8nVG+0I24n4qhDJZI/bMTLikUyl9Aiui4Qs1NbUogbiYQi7Wj2kApeWsjcn4Ij3mmfzRNysmVY7P2jIFtU2m7PJUpv02D49Jk2HMPjp3wL3h7PDce2axOPILDJ+0f6iBcx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IVh9g+s+; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739417883;
	bh=DpzLx+UrFdmR+jkQpgO8A8x7JmsYNWYQhGlpjJhJR5M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IVh9g+s+dRk8CtANBNyANwNLu+FlDKatvvtV/VN9xHkK71SYRHW1g1//9Xp5JzBRG
	 LAOBF/ogqv2YgmFx0UZdVVc56f7Yo8XY1qrmTzAqdfOjONJo7X6jYaCzuyDRONwnXx
	 PJI5dl+GQP/KFYNuoemorQozCUjpQ/qVrYCnnh6g=
X-QQ-mid: bizesmtpsz4t1739417858tum0b6v
X-QQ-Originating-IP: E02J8M1hUNo1RAW5MZSzzIQwC1uMLOuKXwPzVxe+kTw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Feb 2025 11:37:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5165016000835809032
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	Wen Tao <wentao@uniontech.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] blk-cgroup: improve policy registration error handling
Date: Thu, 13 Feb 2025 11:35:45 +0800
Message-ID: <D8F5396BD45124E9+20250213033545.993799-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NQzH8pzEc5hGZIz7f+biLeNFZJx4hqL9dcYcOUtlNvQ67dLPRnpYzSYx
	B1xC3lCEJoEoRfpDF7c5sNS67+zTZJXOIWlYIaomy9MbR4re/ZrOfNTtmIG72l0/5tN6L3X
	yDUqeOld+hDqgBYTVcia3UnWpzPJ8nodc56Zs2sNoNhDcitdl40i5VzSLyw0ClAUQEqIDyW
	JJ5wgxC4APAE4NfGKeAeOORnw0mX0JD0GFkCrkItCVdudYiU33T9KKB0vpq6xgEqxX6RauJ
	RmuXgWPnOxzTSlt8Q5hfdTnKJ2nvH/xjGLBl0zOrr9u8Dwavg0Z2gTGRAYQcUgsR1Iz/VD0
	spq8ulNbjprlkrgS6aqwmyXAS/X++iECiqn+c0BeHCwVLRl8R7FW9a8FM5zTH06zDfCIpYe
	SEIYyb5o2kei4dPTO/i8Jtd0jvQxVsig/aSiVRtv5MH6mAo1+wnf7iHhhfAwcorHIR9iXsn
	Dvg50UoKVGr4zZqGY9pUAJN9fF0EEDS99fBV2kjcZvJ77UVKES2As4H+RvV5L4l7wFnep64
	UJAfaU23LCI4kZElWsNngcOCvxFkFn/4KiO3BF2rRxWgMa+1dghfZthZ+8UuQTOXPq73bxQ
	aKjTrgP5MaNLFEWKxeMOFifI9e2QPCGqM4H+y/+b0MsR7C6BPHsmXpja9tUHaNx7gP2gMny
	KBcdf39pqO4/PX7JrgJGyEpGuyxPx7hQFx7Ryd2mfvwinlu2qEQgO5gVxihmL9wb2LSzSPH
	6l/unLyCaXzkdB6tGIpCT/X6hVwoI6kkrxvAaE65PftoRVJvqBdjZyyZebk0id8jhCBQkfw
	iI0scPLI43QhOTjMQVOpGMOp8ryivhJ5VHpRFxmhNKMG/C5PYESMd1VaWhoCyA3XPA8GZhf
	9GclXzSfNxgjC6z9X6DOaHLo7SQ52qfUE6tA96Us7PUlxNZW51QETjoeDCPRgKWe7MG/NPe
	g9ghquDWcKUkZwT6iyK7hc1uI56+UbsSYCqdgEKII4lZCIZF2MrmBoiYp
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

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
---

v1->v2: Also change the return value to -ENOMEM from error path err_free_cpds

---
 block/blk-cgroup.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754..2609f7294427 100644
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
2.43.0


