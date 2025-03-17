Return-Path: <cgroups+bounces-7099-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99EA63BB1
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 03:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98605188F50C
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 02:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93613B7B3;
	Mon, 17 Mar 2025 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eujEPbGH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEC22F01;
	Mon, 17 Mar 2025 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742178698; cv=none; b=oiip6tr/U9xbu8tFY2mQdU8P0nZYX5xcDJubRNkn97XZAla0yJ0GSr1rUlNDEZvH2HZAwHttaq89eEt4QpeFVwbFnf/gGFM8ughZPBbdLWN/vZLsFPCRrru7HVvBH+vb9CxT3L9QD7VWNCK2VTlZN226NHYavBjbZaqReChplXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742178698; c=relaxed/simple;
	bh=UgfxJNs9q+/V4egib8TdG9hry6mBYQ5JsRB8g8YOHV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFaep+SWej698dwvoL8UxsZQAy9IvibIEbbUwr/ZH+cGi2GPoIaEouE8S/esYGFIcU0Rj0rvyhVYSVe0vf05plqHQ5I1bJUIdm+pBngB6IWXoEuxD7jq8nk6Qju0njqwXt+v/paR9p95S/ZhtQIPwxtcBBVu4n6eBFdeD0uyGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eujEPbGH; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742178612;
	bh=3Ep9OXxN57SI8f3T+ZVX5uyeB57BAjZ5iyhA2KEimRc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eujEPbGHu2xoiuLVyAqfym6OY2aEfo1/y+VTsgSa4sWnBZ3VjiLJV3Jcd/WT/5SUx
	 rgu1sIqSuduu8THjxYRJFcNY7nNTnhSlfQ7cU9x8uiOnx4nkkQmrShENtHEPKr+TnP
	 huyTBkJPvz9O1AF4Zecu4wcyoQtTUmcw3dZImT+o=
X-QQ-mid: bizesmtp82t1742178584trdbk4w4
X-QQ-Originating-IP: PfeJu7VBQytMgWIHxuI6OA58c+5IKKd8+cawwIOHxTY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 10:29:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16559626076117230096
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	Wen Tao <wentao@uniontech.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] blk-cgroup: improve policy registration error handling
Date: Mon, 17 Mar 2025 10:29:24 +0800
Message-ID: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MRY6qckr/MVJxb3HfPNW3ZfnBmjUWM9MGV9dFuk0w/eq/JIaFCYCtdB3
	mIks34asbJFtK71dGiZ4otvPa6tpbs84T3O+iyXe9k4/r1rKm1amACL1bMjEtlgq3yswCr6
	8VYl9+modzLsiC4bJTi8rM/QfVzNQaduGZtZcmsdb/U34sN/C74aHjh+9CyDhteIWokDNZo
	67F06gq/TtB82o/tPaEq9+3jTltgA4/c9H2KIRr58hmxAmCb02eIorzi23AQEB38FqymY5s
	oidj5szmYrGVpYI7Uk+eRCrmSeMSX45ZJHolqPlMO1bGK4sGpOO5BnQIHev/yuy0CH42aKC
	VCkvvOKnjbSqbYGfTOlQZYRfwPH9JHaBJjQ8oC8cYOnu26VtQHtIHmHa2d+N9tCZcLbFALe
	f7tV5JUBNJGwVDmCbALf7GxxRdVsPf+TZQriuN7geyztp0adeYRAgXpEBGEbwSVNYHYgTJI
	psw4tbq4ECxSAbsqd5OYbmrftmbS6f8JP7wPKumrm4h87gqE1yk3S6p5qvmcbY3Q0ToE8kt
	RHUZ8fP0xdsgzkhY2iidQDq/ZaOi8oo62tBdsJ7/YhJm8fAtC7bXN9bsJJ1gbrOZBNNA222
	5GglTQye6Z390FoXBSlLpiDBrlEqyvxBuR5rq/ZlB9nO3TkSChszqRdJ1E4ZM4aBlteUAIf
	6/QSZo071fUbsvAAOp3fMwBI5wvfXCIxnzRC6UTeo+IXSmz0CDmssIX2vspRh0J3p20Ar8V
	ob235v7KS18bWoem0QeCfhugSNVKw7B9t4zrbxTmjk8Hy/BOiT5JkvzxB1+7GkJSnoKnEtP
	FZqg18hbdCZ9FpDVAzELTV9bBEtTiy3O8nwMsgZypy7oDZHkyLZZmX5j6+H7zlbCXwebJRG
	uQEZuaVWaqHfKPh+BPKeWfCTk9p8BvXqSVG9tg1BlWvLUJfbkD6iPTaBZmpVrnXxfoZR0oS
	y+sbvMr7jmOzFOvAOd1d17iAbFuLh8APAhSPc8nkN+LhhF3+GmTDCin1/
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
2.48.1


