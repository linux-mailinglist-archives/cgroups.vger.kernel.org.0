Return-Path: <cgroups+bounces-6052-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A84A0189D
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A523A2B13
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928414883C;
	Sun,  5 Jan 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QITSaLyC"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3B147C71
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066156; cv=none; b=q7S8Zy0pkXEPOcB8H/KQRGEE6ewVTcHAHnLTcp4Fv84JSnBGwna01CfHUfOUx4vvb2UEckqsja/ipudYC6mXDkHf7Mr9brW8Z/UVdW/wBOa5IvTXs+t0Oxoj/WYg/Ny2uFtfaFV77dBspiPdbVFug7Gr/IMHlAPybYJLn3Fr9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066156; c=relaxed/simple;
	bh=YvTwIFgTC/LWB3xoEjTly9oluEvizWxESpju05AN3zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FL/zwSdJXQB7irY7oQqUafPRaPZDCyNpxEIvSy/8IeRZ/pv8z+iFmwot+jwoIEMXZeTu5G+bEjuYGRCfY8GaKpmxdo7n10nzrsQ5sLCBkKcxKnqS/hmorjGbioEi7RI28An+5tBs0N1ZG/ftLJHt6+c7FAnsvMyM7ABMpaXCEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QITSaLyC; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066154;
	bh=GWyxZJvp+QefrwRwUKuyaovvJfEK4jbeqXubth0Rhss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=QITSaLyCaQHCO5/cx1y4M9euWrtaSPdjV8scxiPI2Etas/kQME9gPiF5P+e6q2hns
	 82NNONa7quQVGaxZ+lkrNEglNoEghhlKBgsNA7W3ir8KIE6Fu7mKlvvJbTj9Pc1ebI
	 BEGTnbRJ/CfIhaqocO8hCKMHWn/GXW1bYxWJiyJqGQHRWW3xnegQ0yqLGTQH1NVml/
	 gzlHz2G3J5ytrDb+wcRWMboh3JSE4kMEaeZ5hPg5Fc24aUxJIH7DUzJkYnzTSQcXx8
	 uJpEmgAkEC0MLtaAxLKa2JhXyafM2Zl29vm+23DkzOdtTGoBMxLjfaIDmbHZhsTRxp
	 Q5Jl+ZOrGbcww==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 072064A035B;
	Sun,  5 Jan 2025 08:35:43 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 05 Jan 2025 16:34:07 +0800
Subject: [PATCH v6 6/8] driver core: Correct API
 device_for_each_child_reverse_from() prototype
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250105-class_fix-v6-6-3a2f1768d4d4@quicinc.com>
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
X-Proofpoint-GUID: ZDKzlXVJGiCGPnlnrANJbdIvS6hgwJdu
X-Proofpoint-ORIG-GUID: ZDKzlXVJGiCGPnlnrANJbdIvS6hgwJdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=879
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For API device_for_each_child_reverse_from(..., const void *data,
		int (*fn)(struct device *dev, const void *data))

- Type of @data is const pointer, and means caller's data @*data is not
  allowed to be modified, but that usually is not proper for such non
  finding device iterating API.

- Types for both @data and @fn are not consistent with all other
  for_each device iterating APIs device_for_each_child(_reverse)(),
  bus_for_each_dev() and (driver|class)_for_each_device().

Correct its prototype by removing const from parameter types, then adapt
for various existing usages.

An dedicated typedef device_iter_t will be introduced as @fn() type for
various for_each device interating APIs later.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c       | 4 ++--
 drivers/cxl/core/hdm.c    | 2 +-
 drivers/cxl/core/region.c | 2 +-
 include/linux/device.h    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d3800f0dc5bbd2a7de80bd58b50e31038265da03..5ee53b3bca6a4b4e1fa3cc3c8acd63ed7fd01b63 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4043,8 +4043,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
  * device_for_each_child_reverse_from();
  */
 int device_for_each_child_reverse_from(struct device *parent,
-				       struct device *from, const void *data,
-				       int (*fn)(struct device *, const void *))
+				       struct device *from, void *data,
+				       int (*fn)(struct device *, void *))
 {
 	struct klist_iter i;
 	struct device *child;
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 28edd5822486851912393f066478252b20abc19d..50e6a45b30ba260c066a0781b9ed3a2f6f3462d7 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -703,7 +703,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int commit_reap(struct device *dev, const void *data)
+static int commit_reap(struct device *dev, void *data)
 {
 	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_decoder *cxld;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bfecd71040c2f4373645380b4c31327d8b42d095..a4cff4c266e7a7dd6a3feb1513bf14b7d3f9afa2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -778,7 +778,7 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	return rc;
 }
 
-static int check_commit_order(struct device *dev, const void *data)
+static int check_commit_order(struct device *dev, void *data)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index a9d928398895b062094b94f2c188cbe9951d7ac1..025bac08fca7b2513acb1fbcb666be1dc64f03d1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1079,8 +1079,8 @@ int device_for_each_child(struct device *parent, void *data,
 int device_for_each_child_reverse(struct device *parent, void *data,
 				  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse_from(struct device *parent,
-				       struct device *from, const void *data,
-				       int (*fn)(struct device *, const void *));
+				       struct device *from, void *data,
+				       int (*fn)(struct device *, void *));
 struct device *device_find_child(struct device *parent, const void *data,
 				 device_match_t match);
 struct device *device_find_child_by_name(struct device *parent,

-- 
2.34.1


