Return-Path: <cgroups+bounces-6015-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4580C9FBED5
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 14:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DEE1661D6
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BC1DE2D6;
	Tue, 24 Dec 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="kUSViKL0"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F81D968E
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047555; cv=none; b=rmF89tgELZYPeLDniKeXaYopkkbJLAbzwQ94r8kncL9NxD5rNj5IyLqoiwyG/pUufUyyPt2hCp9OzRAJDnymPXUI1sM1P5+45JPtTEC6pKQ5DawAIJNuahQ/XAH3ecVBZlWTQeYrWQrpQx8m0ZtVPHbgqim+lb7DgRJyPeRXH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047555; c=relaxed/simple;
	bh=9OlOZtXEbqGDafFrZXxpWZoE10b9+aoTMAN++XcN9U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaKLF1KWTekjkqrRt3WjjUaFfiAME+VQw3wMGGelAETdap/VAq84LjeF/UHOZsO3B/od0DYnV/hbYdCKMNR0pRT721ZNujFBpEVhy4frkMpyxc4WtmjhSc5w8VCUSspx9TSzkg/91oZRhDqUCuvu2+j5vnbFKcYbFL4R85JQGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=kUSViKL0; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735047553;
	bh=iiStYWBmczJf5murnV+QgTCZ+TDHGEX9li4ZnS/xVFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=kUSViKL0Uk7p7VXqqfQCo+0O8GEotMEgnPZnhS4/wmpr2thyvemREuJmp1TEjc9Dy
	 GGublyV8Gq+luHiiuzkxNA9Ttpt6aojWPZaJsIRo6/EvunTHNlU7i681PSrqG7ahwL
	 seJaXKyji9lXsrZiVwycYQ8DPnLLeghTEt9vvHq9yDa++KuyhSoXzEMXCwt2riFj/T
	 wacnjB89J8fDuQylAVErJxpsX7s6ArVQGJnjdewBcWpN8WpedED7MT7b7CuBCRe00p
	 iZ3OqnrGgyDr/e3wg2RXzL9M91XYkyblu4Rx+Z4hOrqzds5SfL02tr4dgjXSpoDcCx
	 BI0P/fZGv0cnA==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 33EA48E02DB;
	Tue, 24 Dec 2024 13:39:04 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:37:27 +0800
Subject: [PATCH v5 8/8] driver core: Move two simple APIs for finding child
 device to header
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-class_fix-v5-8-9eaaf7abe843@quicinc.com>
References: <20241224-class_fix-v5-0-9eaaf7abe843@quicinc.com>
In-Reply-To: <20241224-class_fix-v5-0-9eaaf7abe843@quicinc.com>
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
X-Proofpoint-GUID: 6UkNEWO_zjk_Wu-HE4N4px_kOlmCRv8K
X-Proofpoint-ORIG-GUID: 6UkNEWO_zjk_Wu-HE4N4px_kOlmCRv8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240118
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

The following two APIs are for finding child device, and both only have
one line code in function body.
device_find_child_by_name()
device_find_any_child()

Move them to header as static inline function.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c    | 32 --------------------------------
 include/linux/device.h | 32 +++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 35 deletions(-)

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


