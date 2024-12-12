Return-Path: <cgroups+bounces-5855-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01DD9EE7EF
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 14:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F76162863
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E352156FF;
	Thu, 12 Dec 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eKvtZ1kp"
X-Original-To: cgroups@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8021506B
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010843; cv=none; b=BNH6lYGB4PcKo7GTwCcIMaVqS1qmA6kDZspmKxGdKpRKZQouGNZd4hq2B5PTeq6aBN9+/alaaI8H7yyOwIY1xKdyDxuuD85hcFxJFMARUhAHYT67D13RUFAdPF3Jn0MNyXDt1wRi02ZJg6z1UggSFLy10U30V3U2DCKSavi09io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010843; c=relaxed/simple;
	bh=z/rp7YoB2rkqBPSfvsltazJXGGbsmJYmnRsne4EWvT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZfKlRCs3MnbO+sp8GA3k4mvU8EMmL5MnLsdJsOaAzBVlsj0Oa41xBsu/BJ4wtBJ+WNG58dP1CNODahhE8H11dM1nIKDkhuD+lNYuOn4oN+ppTioiUkI5117ClzNX9h0mn7YeW7DvKpJ/4h89OF14D53+t4QrShAI7/hSsn5WFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eKvtZ1kp; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010841;
	bh=BCeIc0lcTP7COm5/43UbgSARtueD/CLiAEPuqWE662Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=eKvtZ1kpb45ZKo32/3+QuuyRCRfPKGpRLqJ/NaQig4Ei9hVU/BkANO+4EPuOzTTpm
	 FVYaUTppJJh8dc75KE8XX5f4TAxEwSCkH4RTi3QuJS3aE6UJsgKEa9RQNqdsnlEDT9
	 pazNxbYenw41bXitJHVrGLDjrT5hAkYnlTk6FxovO2mPVqfvFVmciPCZ7rbRH7A2vm
	 zeYer/BJYpa/Zi4jDokQvMtz+pICztu1t9qHmNUPSb42+1l/fDfWOe+ikm6/RrijmN
	 yKoQ+8st9VplbT/fBpvAUjshxYXeCdox9VtSG+p6yjvEEw3wQm9hIdlD8m3yelpVxT
	 SpcCoUgFUnQrg==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 6C413CC046B;
	Thu, 12 Dec 2024 13:40:30 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 21:38:44 +0800
Subject: [PATCH v3 8/9] driver core: Correct API
 device_for_each_child_reverse_from() prototype
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-class_fix-v3-8-04e20c4f0971@quicinc.com>
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
X-Proofpoint-GUID: 7sd0IW7OL1jTIq_U7vaQk7anaYDkdrS4
X-Proofpoint-ORIG-GUID: 7sd0IW7OL1jTIq_U7vaQk7anaYDkdrS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
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

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c       | 4 ++--
 drivers/cxl/core/hdm.c    | 2 +-
 drivers/cxl/core/region.c | 2 +-
 include/linux/device.h    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 34fb13f914b3db47e6a047fdabf3c9b18ecc08cc..7be9c732bec1b060a477b362f555c3e87c8c7b91 100644
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


