Return-Path: <cgroups+bounces-6014-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C81B9FBED1
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 14:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7677A230F
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FEB1DDC36;
	Tue, 24 Dec 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Z6v0JnKO"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889E1DDC1C
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047546; cv=none; b=TDbfZ/hBcIUMw5k3YK1+pk6WhrdKSpCawPCN8mrjeb8oMpYq0ShIFUFzGOeop6j8QYVNfKnIgxcSkZLpIoifYLCYiiPFXF0bcNjj2k4+PtJcCL5puvn6GVb+lXISf7MyMLZafEbPmcyfCMLHgk2G9MsmgNRM9PJpzZ95zGv2xhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047546; c=relaxed/simple;
	bh=uLh0iwbx+bHSkqf31NJfzOKrZYjwuqeeVtQOgp32dKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4E2cNSpw6b+JDHxEeY3bHtF7OhMQNEQoQqGeO48/V/5Qe1rA/SGswhet4I/fjCAsrMJMWPiETF1Au09lw86ZUMs1pJAiCvTm+KWkM3i4X/e0ZUL8yyVOR7gwH3cAcjvhZmw6gEi0AEYTv2t1avBeXpzsZiZ3lPlbMU20xUq7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Z6v0JnKO; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735047544;
	bh=D+LGXKD45T7pkrXMj16PMStlutJQBRuIDizc9g023YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=Z6v0JnKOJPzs8uAdxAoebSjVa0ymHtdhHpCYShcwKK2mlbEhp2bCKUpdlfQuxAOJn
	 HFo8HNEl+1Xtw90wsRZmtzIDntvQPdTH6s1QfggjO0QDLF/XObzeGDjhcHQ4wfoQNc
	 mlhDPvKZMC9CTx/zulZpfrfOmqDlkTWoOwnx8eHci8KarxwEBnHl36MJZN6Hy50nOG
	 hsxmh02N0Mn/JXVvMnXezs13x6LWxo+iIYwenkC+vgVAcIdeycpO1ClT+rWCZfCHTz
	 gAU6CMiduS0ZmV+5P1X3IyYokvHAmd+kc712cWjBgMBjQsER2dv6iObd1EAUZJKEN6
	 zss7WfGiKYflA==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 66EA18E045E;
	Tue, 24 Dec 2024 13:38:55 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:37:26 +0800
Subject: [PATCH v5 7/8] driver core: Introduce device_iter_t for device
 iterating APIs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-class_fix-v5-7-9eaaf7abe843@quicinc.com>
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
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: sTsJRH0_rcCc7wD6Bm61cjc2n_t0Z2UA
X-Proofpoint-ORIG-GUID: sTsJRH0_rcCc7wD6Bm61cjc2n_t0Z2UA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240118
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


