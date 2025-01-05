Return-Path: <cgroups+bounces-6054-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7CBA018A3
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FDD3A35EE
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBCB149C6A;
	Sun,  5 Jan 2025 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uNlvC6dd"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A231459FD
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066177; cv=none; b=ad74f0PpcTCypOe85AzAa4i2e3WHx2Jj9ikXZYwGRDoD0iC/2YUiDnv16A/i42q6OrqCnGFKrIMD4ATmFTvU9a4mQQh6/NA37+5LWpPr+MTPs7/cH7MMwbQsqsRLCXDa43E0PkbmKUstdZ+02FlRbUHarpbL9glUQv8zs5vFz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066177; c=relaxed/simple;
	bh=kix07/ATA0RCVGyR9CMY/mpudQLlSvHm/p3QFF31A1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJLwopU3phVQXA1hSfFBahvnlMc9PHq9nTptJXkyJ0XnX7zUFI/ZGJrRX9SixsPdqs88cbzM+l10lilmiU+Yqwgkq/hm7Jfz++PwTZm2jt2WeUpZNaS1F9vuwE/Rv7yOArGlH5ti3eT3oOF65InuJ3+FNgYAmk1ligYkufrTmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uNlvC6dd; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066175;
	bh=A9B07nUyN5uJwukRlcamTQt7ZH+BiUzxshMG2DrZvBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=uNlvC6ddxQF/8s1E4qRpjorG5DSFlDkZUldZzFgo53IecJusO2CWMEniF9Cl9cWHV
	 Il/tjiPZevVHlx172CNH2hEfIUT6I3b75lUUgMMdf+ihqqNVLX9NpK4ewt3vP9IWm+
	 smNL+6KSuUWMlEY6etZl7usEp2zPGBvkVlTJ4kgLLJXVMm6NqlU1/V8gLVp5Lr19hI
	 9VA+F+UIphfC92rGBL16QogQEG6df3XN2BJyFHnExQ966uk90fCClZLzTzouj5OcoN
	 z8Y/ac8Zio413f5ysUgS9BIBnIxs70tNDW8oTEVjbfcWaLeJv3PH5ip5wcc6F56/fq
	 qU+dOrvq43rUQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 9D0BC4A039E;
	Sun,  5 Jan 2025 08:36:05 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 05 Jan 2025 16:34:09 +0800
Subject: [PATCH v6 8/8] driver core: Move two simple APIs for finding child
 device to header
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250105-class_fix-v6-8-3a2f1768d4d4@quicinc.com>
References: <20250105-class_fix-v6-0-3a2f1768d4d4@quicinc.com>
In-Reply-To: <20250105-class_fix-v6-0-3a2f1768d4d4@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
 Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Sl6ULH1Q5gEpDGYq26JTHxCP8ve_x9HD
X-Proofpoint-ORIG-GUID: Sl6ULH1Q5gEpDGYq26JTHxCP8ve_x9HD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=907
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

The following two APIs are for finding child device, and both only have
one line code in function body.
device_find_child_by_name()
device_find_any_child()

Move them to header as static inline function.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c    | 32 --------------------------------
 include/linux/device.h | 32 +++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7d79a0549ac7bdaeb18e8c5ded11e10578460fcf..5a1f051981149dc5b5eee4fb69c0ab748a85956d 100644
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
index 36d1a1607712f5a6b0668ac02a6cf6b2d0651a2d..1e9aded9a0869e8f140b508a64df1f8141c9e8c7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1083,9 +1083,35 @@ int device_for_each_child_reverse_from(struct device *parent,
 				       device_iter_t fn);
 struct device *device_find_child(struct device *parent, const void *data,
 				 device_match_t match);
-struct device *device_find_child_by_name(struct device *parent,
-					 const char *name);
-struct device *device_find_any_child(struct device *parent);
+/**
+ * device_find_child_by_name - device iterator for locating a child device.
+ * @parent: parent struct device
+ * @name: name of the child device
+ *
+ * This is similar to the device_find_child() function above, but it
+ * returns a reference to a device that has the name @name.
+ *
+ * NOTE: you will need to drop the reference with put_device() after use.
+ */
+static inline struct device *device_find_child_by_name(struct device *parent,
+						       const char *name)
+{
+	return device_find_child(parent, name, device_match_name);
+}
+
+/**
+ * device_find_any_child - device iterator for locating a child device, if any.
+ * @parent: parent struct device
+ *
+ * This is similar to the device_find_child() function above, but it
+ * returns a reference to a child device, if any.
+ *
+ * NOTE: you will need to drop the reference with put_device() after use.
+ */
+static inline struct device *device_find_any_child(struct device *parent)
+{
+	return device_find_child(parent, NULL, device_match_any);
+}
 
 int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,

-- 
2.34.1


