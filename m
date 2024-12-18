Return-Path: <cgroups+bounces-5959-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8F9F5B10
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 01:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106A47A41EB
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 00:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465919DF81;
	Wed, 18 Dec 2024 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MRPctL5d"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEE19D07E
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480195; cv=none; b=Pz0oBUf0IhEwXvm+rEEWepmliYNdxBAfox4TcI7YLZDUiu/TH7pSisdNrZz3pZ9Qbwh0flftxLhYix7RAPGNJTxVd1h2XPR8TSYIJK7vcwUKV8yxmcUSGMv6RWuYoA6poIAn/3NKpp1N9I8PIRD2dDEdRXjcyjbhQ5w5lb7fudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480195; c=relaxed/simple;
	bh=7c0hWaDRO0lYYPUw3fSJwZidpoLlvEvnQjd/RkahQfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8mCP2rAypuKtUYtS+y8jOTquxydoXtXa0oqKBtQvHr6ijiR4zAKzEcLu5UBOVgbF29BUdhOddF7/1EutrYnynOrlt2K1LSfbUXWo+QLCfqbCuG/d1qMR2qB+zuSHUttnZpOhXitB9vuoJo554bSsjI88gdd5mV9LXQpO7UPqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MRPctL5d; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734480194;
	bh=dqP9qynvc8yZXa+bnipKSS5T9b0BbFcof3abx8Gc0z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=MRPctL5dFoYQ3LiwnmvxriiGc1QwXzo77zQ8JdWaoYlb27NF2n6sH3ScmReaHbiLq
	 7WCQ76VcTlQU8AccwKGQYO5H8qogJ/e43Ko0yRgPEZrvKGw+U1/YZ2DCsoB/mbCNqL
	 rABYg5d9XKnu58OLaNEooQ5le6l9CCwkZkN4sUgu9alT56VobjIuOgznGWiqVwJvNO
	 camcNBZ03VQC2wyFoHcHtCj47iEZQC9lEcz28hc7HjVPzde7souSaOxe7yKSWGy/G3
	 /ov97PmMYTfEu6rEN3UvCXey+DvbSVGSGph7dSzK0qutYFeRTG/DdpMh8XllvhriSM
	 cJbLQV4/fqwIw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id C0DA896019F;
	Wed, 18 Dec 2024 00:03:07 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Dec 2024 08:01:38 +0800
Subject: [PATCH v4 8/8] driver core: Move 2 one line device finding APIs to
 header
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-class_fix-v4-8-3c40f098356b@quicinc.com>
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
X-Proofpoint-ORIG-GUID: iQ8-mg4aEfHHSs5wuAPGnOfDbU92wXlr
X-Proofpoint-GUID: iQ8-mg4aEfHHSs5wuAPGnOfDbU92wXlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_12,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170183
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

The following device finding APIs only have one line code in function body
device_find_child_by_name()
device_find_any_child()

Move them to header as static inline function.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c    | 32 --------------------------------
 include/linux/device.h | 14 +++++++++++---
 2 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 930e43a970952b20cd1c71856bdef889698f51b4..3f37a2aecb1d11561f4edd72e973a1c43368de04 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4100,38 +4100,6 @@ struct device *device_find_child(struct device *parent, const void *data,
 }
 EXPORT_SYMBOL_GPL(device_find_child);
 
-/**
- * device_find_child_by_name - device iterator for locating a child device.
- * @parent: parent struct device
- * @name: name of the child device
- *
- * This is similar to the device_find_child() function above, but it
- * returns a reference to a device that has the name @name.
- *
- * NOTE: you will need to drop the reference with put_device() after use.
- */
-struct device *device_find_child_by_name(struct device *parent,
-					 const char *name)
-{
-	return device_find_child(parent, name, device_match_name);
-}
-EXPORT_SYMBOL_GPL(device_find_child_by_name);
-
-/**
- * device_find_any_child - device iterator for locating a child device, if any.
- * @parent: parent struct device
- *
- * This is similar to the device_find_child() function above, but it
- * returns a reference to a child device, if any.
- *
- * NOTE: you will need to drop the reference with put_device() after use.
- */
-struct device *device_find_any_child(struct device *parent)
-{
-	return device_find_child(parent, NULL, device_match_any);
-}
-EXPORT_SYMBOL_GPL(device_find_any_child);
-
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index 36d1a1607712f5a6b0668ac02a6cf6b2d0651a2d..d1871a764be62e6857595bc10b9e54862c99dfa2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1083,9 +1083,17 @@ int device_for_each_child_reverse_from(struct device *parent,
 				       device_iter_t fn);
 struct device *device_find_child(struct device *parent, const void *data,
 				 device_match_t match);
-struct device *device_find_child_by_name(struct device *parent,
-					 const char *name);
-struct device *device_find_any_child(struct device *parent);
+
+static inline struct device *device_find_child_by_name(struct device *parent,
+						       const char *name)
+{
+	return device_find_child(parent, name, device_match_name);
+}
+
+static inline struct device *device_find_any_child(struct device *parent)
+{
+	return device_find_child(parent, NULL, device_match_any);
+}
 
 int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,

-- 
2.34.1


