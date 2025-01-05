Return-Path: <cgroups+bounces-6053-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD10A0189E
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A04C1628FF
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B1A146A79;
	Sun,  5 Jan 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XlkpuupH"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE214659D
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066168; cv=none; b=MrUdKyq7nnjjDSh9CsztRWn3gx9C6su8iONZcUIMtdvF1e0RlpaWOOFUysfUBJNJz5NmCQMKSWgtZCQU7veHxcucIN9lgXsLalTrLDq676Yb6YVYjmdn+L5Jb5+fibKpxLxXq05ZjoHJLr2krB05EW/mY4IPHPNVr3ngFZElyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066168; c=relaxed/simple;
	bh=+c9TZmPh04rE16gDqqHrxut385V3/n7zCquQuNVLy+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dko5GmcFcR6lDQvB+4iRsm8RqkyKEPny9TLV01o/ElQ6owQmj/F1caryyiHo1ajX1yMfUk5keQphV8nnR0YV8RBMI6nPn4yuEGvLm/yY9IvDFnBS3q2VLJ3iJJpbjQGc3dJrMroehqFHt/rWosOzeEqiztMwkittvWhccITNrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XlkpuupH; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066164;
	bh=PiAv5BOHu8VoDkScQbA1zOtSEi5oMSZCHfxz8xRr84w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=XlkpuupHVpC/5PqiTpQfWKfi61u+LSJCiN+ZNP55BUBp3/5+R71bC7YVUPQOONRd0
	 Aia4aHKCB6S8mDlHPaQGcA4KClCRiyredQD+oW41q2pWtB7NKim28I3SppqNm+ZHpG
	 JbNe22dA8ex+yoUrEl5ixCOv0RXWSb6ZaNaFVsTU+ZxRx9LBDW+yODcHSNor/AsQQh
	 tYL27WX9OAeDtXzrN0++FaC7ksViRvUsGpLa/JqmvLSAn5WYQVkMBFbPjmwxcEeJ+Z
	 49BdHmPfxv06mmAoE5OJuB3WRnQnk2PtBOsjg8P3MWemJct7NEkjSPzmH88kSLaiag
	 yzQqLmTlvLZLQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id C0E314A02B4;
	Sun,  5 Jan 2025 08:35:54 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 05 Jan 2025 16:34:08 +0800
Subject: [PATCH v6 7/8] driver core: Introduce device_iter_t for device
 iterating APIs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250105-class_fix-v6-7-3a2f1768d4d4@quicinc.com>
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
X-Proofpoint-GUID: qrSn2kltzWuiU6NeTzcSFFskHe6-EEDZ
X-Proofpoint-ORIG-GUID: qrSn2kltzWuiU6NeTzcSFFskHe6-EEDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
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
index 5ee53b3bca6a4b4e1fa3cc3c8acd63ed7fd01b63..7d79a0549ac7bdaeb18e8c5ded11e10578460fcf 100644
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


