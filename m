Return-Path: <cgroups+bounces-5958-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74F9F5B0A
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 01:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B213188D035
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 00:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF2189B85;
	Wed, 18 Dec 2024 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="YnP7Ay91"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE241991A5
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480189; cv=none; b=iGxpTZ1ZQlarsYz6SyYlSSfl6Ik9S9U5fycZZUZRaR5YwwtoGD8dlLkvuaoGdfsUq5Jq0lbQ81I1FENp6wfU+ZjCTE+ZHnw5FT6YrCSp0CmI4vj0qSX6oYKyvIPuPtB3SVLHxkoRQdMuWHrNu3k/jMYSclQzeiaBtRXzicQ99Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480189; c=relaxed/simple;
	bh=uLh0iwbx+bHSkqf31NJfzOKrZYjwuqeeVtQOgp32dKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmPudQDMtjS/VTa4LlmXF1rudRjxNCQy+MaoJ69FqbSkrU2h1N0p8k4OMOlURgBvaRsO6EEeZuA4yhWzJ10cOraM+EXUhqSv1oEBBN8qqOOyT82OEU3rQdwwV/L7qCKEiC88RZVJF5H/CHqOn/Mnjtuz+vKmP6j5N6Zyhes6Kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=YnP7Ay91; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734480187;
	bh=D+LGXKD45T7pkrXMj16PMStlutJQBRuIDizc9g023YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=YnP7Ay91kLubdbRfzxrkuP5cJSyhydYxHZoV1WXRLj2skxdBvSVM57cXFGPO42zrE
	 bZExsU0Xuu8EbkcNkaqw9A9vUwMC1HavVudGrYWBjGy+o/+t0wW4YJoJwwzvGu9nJg
	 4U0nykDx3XEQbvNTkPsL9UK+7MdFYhXrloFz4od4Ias62Rsl03iNP1rxIpXSEhePW2
	 tisLhMDBrQIpJ08lwvKvTzjhagGb6c0i9X+QuU8p5EGM1BCcgwWKDasXqs81tujvnx
	 tAe0YDrcMHBNrGMuVqde5/m7JqRWbuVNzZGupN4GzWhnayuBbOojyy55OzHjjYwGJU
	 oZx2xpDSCtLpg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 7771D960369;
	Wed, 18 Dec 2024 00:03:00 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Dec 2024 08:01:37 +0800
Subject: [PATCH v4 7/8] driver core: Introduce device_iter_t for device
 iterating APIs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-class_fix-v4-7-3c40f098356b@quicinc.com>
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
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: op-Uu6fWZ2at7V2gq1P2oHGG5qp6-LJB
X-Proofpoint-GUID: op-Uu6fWZ2at7V2gq1P2oHGG5qp6-LJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_12,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170183
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

There are several for_each APIs which has parameter with type below:
int (*fn)(struct device *dev, void *data)
They iterate over various device lists and call @fn() for each device
with caller provided data @*data, and they usually need to modify @*data.

Give the type an dedicated typedef with advantages shown below:
typedef int (*device_iter_t)(struct device *dev, void *data)

- Shorter API declarations and definitions
- Prevent further for_each APIs from using bad parameter type

So introduce device_iter_t and apply it to various existing APIs below:
bus_for_each_dev()
(class|driver)_for_each_device()
device_for_each_child(_reverse|_reverse_from)().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c            | 2 +-
 drivers/base/class.c          | 2 +-
 drivers/base/core.c           | 6 +++---
 drivers/base/driver.c         | 2 +-
 include/linux/device.h        | 6 +++---
 include/linux/device/bus.h    | 7 +++++--
 include/linux/device/class.h  | 4 ++--
 include/linux/device/driver.h | 2 +-
 8 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 73a56f376d3a05962ce0931a2fe8b4d8839157f2..6b9e65a42cd2e12046ddabf2d8dfb209d513f7da 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -354,7 +354,7 @@ static struct device *next_device(struct klist_iter *i)
  * count in the supplied callback.
  */
 int bus_for_each_dev(const struct bus_type *bus, struct device *start,
-		     void *data, int (*fn)(struct device *, void *))
+		     void *data, device_iter_t fn)
 {
 	struct subsys_private *sp = bus_to_subsys(bus);
 	struct klist_iter i;
diff --git a/drivers/base/class.c b/drivers/base/class.c
index d57f277978dc9033fba3484b4620bcf884a4029f..70ee6a7ba5a3746b5a182c6101b5c085b424d01d 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -402,7 +402,7 @@ EXPORT_SYMBOL_GPL(class_dev_iter_exit);
  * code.  There's no locking restriction.
  */
 int class_for_each_device(const struct class *class, const struct device *start,
-			  void *data, int (*fn)(struct device *, void *))
+			  void *data, device_iter_t fn)
 {
 	struct subsys_private *sp = class_to_subsys(class);
 	struct class_dev_iter iter;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7be9c732bec1b060a477b362f555c3e87c8c7b91..930e43a970952b20cd1c71856bdef889698f51b4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3980,7 +3980,7 @@ const char *device_get_devnode(const struct device *dev,
  * other than 0, we break out and return that value.
  */
 int device_for_each_child(struct device *parent, void *data,
-			  int (*fn)(struct device *dev, void *data))
+			  device_iter_t fn)
 {
 	struct klist_iter i;
 	struct device *child;
@@ -4010,7 +4010,7 @@ EXPORT_SYMBOL_GPL(device_for_each_child);
  * other than 0, we break out and return that value.
  */
 int device_for_each_child_reverse(struct device *parent, void *data,
-				  int (*fn)(struct device *dev, void *data))
+				  device_iter_t fn)
 {
 	struct klist_iter i;
 	struct device *child;
@@ -4044,7 +4044,7 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
  */
 int device_for_each_child_reverse_from(struct device *parent,
 				       struct device *from, void *data,
-				       int (*fn)(struct device *, void *))
+				       device_iter_t fn)
 {
 	struct klist_iter i;
 	struct device *child;
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 6f033a741aa7ce6138d1c61e49e72b2a3eb85e06..8ab010ddf709a2b173cfd0c18610a122e58a2f4c 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -115,7 +115,7 @@ EXPORT_SYMBOL_GPL(driver_set_override);
  * Iterate over the @drv's list of devices calling @fn for each one.
  */
 int driver_for_each_device(struct device_driver *drv, struct device *start,
-			   void *data, int (*fn)(struct device *, void *))
+			   void *data, device_iter_t fn)
 {
 	struct klist_iter i;
 	struct device *dev;
diff --git a/include/linux/device.h b/include/linux/device.h
index 025bac08fca7b2513acb1fbcb666be1dc64f03d1..36d1a1607712f5a6b0668ac02a6cf6b2d0651a2d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1075,12 +1075,12 @@ void device_del(struct device *dev);
 DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
 
 int device_for_each_child(struct device *parent, void *data,
-			  int (*fn)(struct device *dev, void *data));
+			  device_iter_t fn);
 int device_for_each_child_reverse(struct device *parent, void *data,
-				  int (*fn)(struct device *dev, void *data));
+				  device_iter_t fn);
 int device_for_each_child_reverse_from(struct device *parent,
 				       struct device *from, void *data,
-				       int (*fn)(struct device *, void *));
+				       device_iter_t fn);
 struct device *device_find_child(struct device *parent, const void *data,
 				 device_match_t match);
 struct device *device_find_child_by_name(struct device *parent,
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index bc3fd74bb763e6d2d862859bd2ec3f0d443f2d7a..3d3517da41a141aeadc8f219a44fd360cfd931ff 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -139,9 +139,12 @@ int device_match_acpi_dev(struct device *dev, const void *adev);
 int device_match_acpi_handle(struct device *dev, const void *handle);
 int device_match_any(struct device *dev, const void *unused);
 
+/* Device iterating function type for various driver core for_each APIs */
+typedef int (*device_iter_t)(struct device *dev, void *data);
+
 /* iterator helpers for buses */
-int bus_for_each_dev(const struct bus_type *bus, struct device *start, void *data,
-		     int (*fn)(struct device *dev, void *data));
+int bus_for_each_dev(const struct bus_type *bus, struct device *start,
+		     void *data, device_iter_t fn);
 struct device *bus_find_device(const struct bus_type *bus, struct device *start,
 			       const void *data, device_match_t match);
 /**
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 518c9c83d64bdf85bb5607cea6ea640884ec3460..aa67d473681612f24a4569bf82fe5f91237d5a50 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -92,8 +92,8 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 struct device *class_dev_iter_next(struct class_dev_iter *iter);
 void class_dev_iter_exit(struct class_dev_iter *iter);
 
-int class_for_each_device(const struct class *class, const struct device *start, void *data,
-			  int (*fn)(struct device *dev, void *data));
+int class_for_each_device(const struct class *class, const struct device *start,
+			  void *data, device_iter_t fn);
 struct device *class_find_device(const struct class *class, const struct device *start,
 				 const void *data, device_match_t match);
 
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 5c04b8e3833b995f9fd4d65b8732b3dfce2eba7e..cd8e0f0a634be9ea63ff22e89d66ada3b1a9eaf2 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -154,7 +154,7 @@ void driver_remove_file(const struct device_driver *driver,
 int driver_set_override(struct device *dev, const char **override,
 			const char *s, size_t len);
 int __must_check driver_for_each_device(struct device_driver *drv, struct device *start,
-					void *data, int (*fn)(struct device *dev, void *));
+					void *data, device_iter_t fn);
 struct device *driver_find_device(const struct device_driver *drv,
 				  struct device *start, const void *data,
 				  device_match_t match);

-- 
2.34.1


