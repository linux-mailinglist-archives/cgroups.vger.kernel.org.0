Return-Path: <cgroups+bounces-5848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81AB9EE7CE
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021FB281B91
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34B2135C3;
	Thu, 12 Dec 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uMGWb7Yg"
X-Original-To: cgroups@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AC2144C0
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010771; cv=none; b=BkxmqXiY+pKIbUKSWpkJqEJIbqxT2o4dfBCBzGKvbUFsdHr8sZZrtAh1Tlb/XDgFouWWhGxgojg80njo3zjyI3YSSgeha3WRHKM1bleQcu+ijbv41l1N+OFi8HxgriD00XsNzixjGWwIpNFtViE9tj24/a/g8dEjMk+mzgM0gJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010771; c=relaxed/simple;
	bh=e/2xP3qFb869WanTNBYe+qJB5MKHi9usxQIzrOvob5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJ/p9Ti/d1EKAHXxOawAPhxDX3EBOhMy9/8wURUt7QvXow5zrxAw6JZrvku1qMhVoz9XIuVsGxG7gqYQ73vK5C2kxVLJYGqgAIx4r8UdQ8ofC2u2Mpj8eo7nr0Jg9gY0Ucq4zUAfUJer95a430PLO6oZ2nTm0lvMeS73bGj/XR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uMGWb7Yg; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010768;
	bh=Eh2nL80zh7HWftk0msMSgPR2NrIlsrV6kCVdoP2/U/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=uMGWb7Ygd4lPgRfEQBVse00BCLTdU7yWJG1woa3ZkWgxVMt275JWAzFsRd25UlDM8
	 ur2mX8+ACw4IwLak3A1LIryb7AtO8FL15wPVG1nqSNPpBjbrZ26E3veEPpqq1qfYBV
	 kDLHApQDZpyMDLmIzCF81z/zMK008PT2gFE4kHjea+TpYOvLwByVD/EArhO6+G0bQn
	 y0AHM1p66H14T9KwmbEzG/tn5mL3YHjNBqe9LrTD103G3R8tXI81+C+Q2YAk4jIWxl
	 uZ8+t9iUdGpAT+nkTaIFShyvkD/kXa7XkKBD+8Av0+F1pDLR7cFk3bczP7OsrBvOZq
	 YZSckuLLkDV7g==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 8D8E6CC01EE;
	Thu, 12 Dec 2024 13:39:19 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 21:38:37 +0800
Subject: [PATCH v3 1/9] driver core: class: Fix wild pointer dereferences
 in API class_dev_iter_next()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-class_fix-v3-1-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
In-Reply-To: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
 Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: O3rAVS6GNetLcy20L32Omo3pNoh9hpsO
X-Proofpoint-ORIG-GUID: O3rAVS6GNetLcy20L32Omo3pNoh9hpsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

There are a potential wild pointer dereferences issue regarding APIs
class_dev_iter_(init|next|exit)(), as explained by below typical usage:

// All members of @iter are wild pointers.
struct class_dev_iter iter;

// class_dev_iter_init(@iter, @class, ...) checks parameter @class for
// potential class_to_subsys() error, and it returns void type and does
// not initialize its output parameter @iter, so caller can not detect
// the error and continues to invoke class_dev_iter_next(@iter) even if
// @iter still contains wild pointers.
class_dev_iter_init(&iter, ...);

// Dereference these wild pointers in @iter here once suffer the error.
while (dev = class_dev_iter_next(&iter)) { ... };

// Also dereference these wild pointers here.
class_dev_iter_exit(&iter);

Actually, all callers of these APIs have such usage pattern in kernel tree.
Fix by:
- Initialize output parameter @iter by memset() in class_dev_iter_init()
  and give callers prompt by pr_crit() for the error.
- Check if @iter is valid in class_dev_iter_next().

Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

---
Alternative fix solutions ever thought about:

1) Use BUG_ON(!sp) instead of error return in class_dev_iter_init().
2) Change class_dev_iter_init()'s type to int, lots of jobs to do.

This issue is APIs themself issues, and regardless of how various API
users use them, and silent wild pointer dereferences are not what API
users expect for the error absolutely.
---
 drivers/base/class.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 582b5a02a5c410113326601fe00eb6d7231f988f..d57f277978dc9033fba3484b4620bcf884a4029f 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -323,8 +323,12 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 	struct subsys_private *sp = class_to_subsys(class);
 	struct klist_node *start_knode = NULL;
 
-	if (!sp)
+	memset(iter, 0, sizeof(*iter));
+	if (!sp) {
+		pr_crit("%s: class %p was not registered yet\n",
+			__func__, class);
 		return;
+	}
 
 	if (start)
 		start_knode = &start->p->knode_class;
@@ -351,6 +355,9 @@ struct device *class_dev_iter_next(struct class_dev_iter *iter)
 	struct klist_node *knode;
 	struct device *dev;
 
+	if (!iter->sp)
+		return NULL;
+
 	while (1) {
 		knode = klist_next(&iter->ki);
 		if (!knode)

-- 
2.34.1


