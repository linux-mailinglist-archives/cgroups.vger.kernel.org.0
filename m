Return-Path: <cgroups+bounces-5856-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589D9EE7F4
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC67F1674EC
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03721C172;
	Thu, 12 Dec 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="b9rrj/mn"
X-Original-To: cgroups@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE6215710
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010856; cv=none; b=FSTIvLecjLZmctm9g9bSQpARgA1zz37FcJRVlBJ5elN+2VXh9aIsU67W8YL7XQSzNKW9a2foOpsGDfBpItHonQD4GDozOqYVsD1iZBRtBeEVBPbmxJW2TPAjj8AbycnwB4s+4Rk6k0knC86EYoIDuMiMTW+LNPVHXaBIUpjFJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010856; c=relaxed/simple;
	bh=y9RQSXv1X/b7onq26soG95yWCh3wV1nPZhg2N7QA94I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ta3BuTaQ3kenUmWKMHwKf9FKuCWSSZaecbaTpnMzziKnv1lLNJR5Fg7FcspoOdZXOfQAn4jFHA2MhnkHJPJIStxOXs+LB7QfqaeIdanxqlp8sTDY+RlH02LUr77oQn3WFdO0upHUi/eP3yzgorJbllhZRfPI13jeJWlaErb4GCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=b9rrj/mn; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010852;
	bh=aNctqcORfAEPE8lIZjnrCUjfsnSedHfS6VRbqUX7SHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=b9rrj/mnnDVpn3vlwG4EWqSDqJUU/97nO526TwBQD8RIUyUjuaFxzKiuHzPXJUPvz
	 kI080SReAu1u34fJ1G+eJ5bB15vqDHXhXBYiyqRm1cwQ6775oEFhynqGOYrBR8jies
	 hGEMpYLnMW7tw+4lRa7AYVHBGISvdxoJ7oh5cnFAZO3kJ6EHYysf6N20SWA8oRsWb+
	 Wc7PSHCyaJnduEcSQSh/NWmS1BEvjgYcCHaaZvIQXWNcPobMr4iD4vMzdMNRRUeYaV
	 9z5ejIh+tFStrDHbIMG2XFBIeZpGDmJqrP50KmeIECFQeZulY9vBl4kB4DxQ89oX8r
	 V20W0afioCW0Q==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 5F4E3CC0564;
	Thu, 12 Dec 2024 13:40:41 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 21:38:45 +0800
Subject: [PATCH v3 9/9] driver core: Introduce device_iter_t for device
 iterating APIs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-class_fix-v3-9-04e20c4f0971@quicinc.com>
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
X-Proofpoint-GUID: dpeo6YlG0e-Juhs4ByQzAKGAmtk4fdQW
X-Proofpoint-ORIG-GUID: dpeo6YlG0e-Juhs4ByQzAKGAmtk4fdQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
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


