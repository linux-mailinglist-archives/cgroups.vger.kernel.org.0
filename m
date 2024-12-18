Return-Path: <cgroups+bounces-5952-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C29F5AEB
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 01:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F967A4135
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 00:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F73535DC;
	Wed, 18 Dec 2024 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="j2gHB8N1"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215B4642D
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480145; cv=none; b=USr31PpstmcnqkUwcdnujSH0tUbBkHN1VJ3LZjK5tvr3Lbh9bzeIOHo/AHsKIjIBznfjpbU94ChxdNCrddtlVsQIXoZLIVqHZJCvM+dOMmVk4KkQWs8PTewfwWSWYdDDjchhiVUJlw2MlGJIkYDug6BTrplnSGGrYozT5GJ5Y18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480145; c=relaxed/simple;
	bh=e/2xP3qFb869WanTNBYe+qJB5MKHi9usxQIzrOvob5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sS1ycGGIjkyqRgy//kN5vPkCrJYqzGlLWLdFHU0ksReSfG/6R9jkEBOm10jq2ax/J7wRZSATxlRy0CertYZAPce+5R/uEYf4JJAzwdu2ijOhEkcDj9XRJZoiaIIHiRYgdMI9KzIGEo7gIry6xW82yWdLxnSQsALgGR0K+9kBZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=j2gHB8N1; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734480143;
	bh=Eh2nL80zh7HWftk0msMSgPR2NrIlsrV6kCVdoP2/U/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=j2gHB8N1VE0sxCA9hDQao6S2E87uQsywhx05ScK5a3wtAkwMybSkor4qm9Lfwd47c
	 a70rf330pQ+EPQpXULXgxibd1jfBsxgohiGbtO4pMdKJZKfyiD0+mcBhhK8LXMem8V
	 FHDEDuySGBbOtWh6A62dL4ln6GjouLm+OBaVhIBUjCT5EBRHlEIT41KWZsz6bk81td
	 NMdm96c7/Lv82Ceky8Ijd/WMHS4c2NrCG5NvVy7vW4XCNT/XzEJ03D1k5xd5ARiU20
	 H1YaCvGuYOiuIii4uRwBvaIFij6eqQQJDloXqhp4Jo//Nj8YgrpWrgRIr7ZMWvAE6E
	 4WUCwKVLPwfIQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 772CB96018F;
	Wed, 18 Dec 2024 00:02:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Dec 2024 08:01:31 +0800
Subject: [PATCH v4 1/8] driver core: class: Fix wild pointer dereferences
 in API class_dev_iter_next()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-class_fix-v4-1-3c40f098356b@quicinc.com>
References: <20241218-class_fix-v4-0-3c40f098356b@quicinc.com>
In-Reply-To: <20241218-class_fix-v4-0-3c40f098356b@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KgSYcnwTObkWkgn5Hgdu4e-1op-hHu0H
X-Proofpoint-GUID: KgSYcnwTObkWkgn5Hgdu4e-1op-hHu0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_12,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170183
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


