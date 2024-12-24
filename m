Return-Path: <cgroups+bounces-6013-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6613B9FBEC8
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 14:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB8018808F3
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBE1D90B9;
	Tue, 24 Dec 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nA0ar0qM"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5561CCEF0
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047537; cv=none; b=l/2tGJjp2n+VBVLpaK1LqHSD+4T4d3+VomfcuXpqjHInjE4xgcd+wMX2/DgJb0dN7z6kaaMYeGxJcBsBVQKoka3GDx8gr2D8RxAPI9U8yaM/ipgx8fHtBWH1DtiR0eMvKjNDfSSa/pv9jQWI4m/CpbZhBikfPmaRXLdi4zOtARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047537; c=relaxed/simple;
	bh=DwQV+1u1k+MMC8p20XB/ThrvufR22TR7sB4o/3ThFnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B62CcXtFJR3qUf0xfReY1rsUL1LFALtQW7SPdvltcWxOqkHIc8Ker9vyEfj3zdZxe1xLsffDdr04+65ez1P6pG2KUzBSzn9fy/UQtcPZf8MPTWdiCtR0Hcr87X+p+kBz1M4em6xYa9ispwdyCZ+yDIsgnXM0S+X0zw/V24B1hqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nA0ar0qM; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735047535;
	bh=hSVqi/9cLAHS96j0Wuyjns8MrivpzIzzYpGb9TI00yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=nA0ar0qMaea+PxSEdQtrbGs+Oesa1V7ezXqbPh5HOOP75Cdsf47p4yyuNDwETzMAy
	 /KydHHoBaBGS4vUoRR1gWNAZH1m4mxju37l5gbIKxwpWiCiuu3pnH1w03IGDvTb2fm
	 WCVAEVa39w7qO+pCNrnIR6ZauuQh8MCShInHHRyyOP7eiI4wrnGUE9Ac5UU+z5v3SA
	 0i9MY6xw1oszd73g4l7sBEHepP6ctxplGZGZ4Btrzw9djhPW16XBc5fXLlSp9+Tmyn
	 Ar4sarybM2Nie2ViqPm568V/U38om4ji2ZklEWxUio9dXy8s2aAvRkjicls91Tphv1
	 h1rnMfywP9poA==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id E8B868E0537;
	Tue, 24 Dec 2024 13:38:46 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:37:25 +0800
Subject: [PATCH v5 6/8] driver core: Correct API
 device_for_each_child_reverse_from() prototype
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-class_fix-v5-6-9eaaf7abe843@quicinc.com>
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
X-Proofpoint-GUID: eay42OfFhrevYmP5HBdveklan6yB_5Cd
X-Proofpoint-ORIG-GUID: eay42OfFhrevYmP5HBdveklan6yB_5Cd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=965
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240118
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


