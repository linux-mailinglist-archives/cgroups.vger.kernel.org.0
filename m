Return-Path: <cgroups+bounces-5956-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DBA9F5AFE
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 01:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9301894C47
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 00:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1483594E;
	Wed, 18 Dec 2024 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="kmACy36Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA3153BF7
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480175; cv=none; b=kwRcaLLLSjT/S930wINDNCxL0scwZcD3a1Lo4UbM1v22SWszRS5XECFj3DOrLkNtIunYeSug1Zr+osaLZJqEG+LRRuoCP3kG3qPRSw72h/Kay9EGWa7yeZwgF6wJIfVg6ZaQxIgZUQMnD+FIC6qsKEFgZ8YW2rboUOecMAgBkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480175; c=relaxed/simple;
	bh=9Y0rzZnBTx0M5MQSIP1RwELLmzfYczu0ijWLu1jrY5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kT4An3NvqvreO+vOxUPqizLqO0jM4pNRtRa2vpv7i5sXEiKl7CUzX2Vn8LXbiElkimLzlD7geh1PFe4cD6YbisP3SXrwnv8npAewVkadGbJkwoX4ygDA1AVFZ+MCuy9LklTEN/XWx4zVdwS0kvQ1tcNgNzJQem7xtIfOzO/dmjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=kmACy36Q; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734480173;
	bh=VKx9/BEbeYqmaBNZCu91NOLWQRLnn6ACylShMKN74W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=kmACy36QOK4/r7uTgptRo1D+Y14AoMnQTPcWZmKDAMSIw0k/X1FxISAcG5YX4kiah
	 HDl08eKYcQ1QDII7Lks43T0XnzIU6dwTzXGk2tLbKdFstL70TtXdh47IpAvdQwH5ZU
	 lnpltLpyJIJHyrQLlWF4k3ZxN8M1Xp51JNWWYUqYxm9w3ql357ZjB6J6ZeeUEqNX81
	 sD/qtdRje1YrPHMERIYNqEwvnH1kIi0BL/ZuO7JpjBWYT1pN1VCCSlF/ph73z/Vyn6
	 3MpiNgdF0oap6Z4XBbtE92c++FbADkfjQ5tzOg1CcYtNdVGbGCfOWIzznJZil5U5Gv
	 9oA8GFtfQOY2A==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id EA902960384;
	Wed, 18 Dec 2024 00:02:46 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Dec 2024 08:01:35 +0800
Subject: [PATCH v4 5/8] driver core: Correct parameter check for API
 device_for_each_child_reverse_from()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-class_fix-v4-5-3c40f098356b@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KokUCULd9Vqgo7vGe7-HrA4X93kFzyS0
X-Proofpoint-GUID: KokUCULd9Vqgo7vGe7-HrA4X93kFzyS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_12,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=882 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170183
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

device_for_each_child_reverse_from() checks (!parent->p) for its
parameter @parent, and that is not consistent with other APIs of
its cluster as shown below:

device_for_each_child_reverse_from() // check (!parent->p)
device_for_each_child_reverse()      // check (!parent || !parent->p)
device_for_each_child()              // same above
device_find_child()                  // same above

Correct the API's parameter @parent check by (!parent || !parent->p).

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 69bb6bf4bd12395226ee3c99e2f63d15c7e342a5..34fb13f914b3db47e6a047fdabf3c9b18ecc08cc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4050,7 +4050,7 @@ int device_for_each_child_reverse_from(struct device *parent,
 	struct device *child;
 	int error = 0;
 
-	if (!parent->p)
+	if (!parent || !parent->p)
 		return 0;
 
 	klist_iter_init_node(&parent->p->klist_children, &i,

-- 
2.34.1


