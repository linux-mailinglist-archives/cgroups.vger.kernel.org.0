Return-Path: <cgroups+bounces-6010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38DE9FBEC2
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 14:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C827A20E2
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D931DAC9C;
	Tue, 24 Dec 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="kGv9gI/z"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0491DAC83
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047509; cv=none; b=X5OFnIR1C3kYM77rSxvHs0d7bd2o8DBgOsn4tXfZVb6jZn7XAMxUss7vKmtUXQUAL9b1jJdhKNmGStTUwhhrdBLwU7USSAntDFuxcPq+nNhMo/YkwwQgYDEaUStr1A8NTnXb9A24CtCgVNwkvrAQ8rLPbEjCA1FRD1E3cqojwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047509; c=relaxed/simple;
	bh=G49zBKYjNI4Lr2O92y6LMZppduNJ4fYsvssXA+rD8DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFsVDni6ZLedUWVckK8C1MLovbBGFnm2QjBS+8TyRUkWGvTHojwEApC+VjJ4h8xKBnmiRVh8YLpsDuQc+goNyYis9eO1/+keRCnDZ6CR8qpcp/ldUJGJQrnJRF9XDzPHe51Zl/SEHu13GGlVKcgHqp3sRxwuFOx39KSGekNsAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=kGv9gI/z; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735047508;
	bh=cOPHgek+7txVXNgAZKPNrM641zXSkIkTh3Riom+d1rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=kGv9gI/zocbRw/35SsPmt/h9nCbU+JL+fuSrL9h39uE8GY7XbE3S4sYHu5RZffn1A
	 1krsfGcWgy9THUVyFz0vlY/u2LQgc4v3x4Vc0jIIi06rnFRV8wwcIk/otlWx6VxSwF
	 o9z4IXX8mbtsHEbswXC/wFZbyPH5NAmywkfP6VLgKoCS5YR/RE3yQLTPxTu7GRohJc
	 okmhmxZYgb1O1jGT01zhfMDJgNFhnwTlFwpK94YvA2Ov4pG6u06Mtzwy5rFZAHLfRp
	 He8fTQiDfwI8i/Q3pY1lQxnJcl3K7FNoEUydIIkcQnL6JO5CSxdeHBFANlw3L3qf3j
	 m+O/tKjAyX9tA==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id CFD8D8E0537;
	Tue, 24 Dec 2024 13:38:19 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:37:22 +0800
Subject: [PATCH v5 3/8] driver core: Move true expression out of if
 condition in 3 device finding APIs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-class_fix-v5-3-9eaaf7abe843@quicinc.com>
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
 Fan Ni <fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: UAyJ86HnSM2NvFEe9fRubnMoiClTUazR
X-Proofpoint-ORIG-GUID: UAyJ86HnSM2NvFEe9fRubnMoiClTUazR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240118
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For bus_find_device(), driver_find_device(), and device_find_child(), all
of their function body have pattern below:

{
	struct klist_iter i;
	struct device *dev;

	...
	while ((dev = next_device(&i)))
		if (match(dev, data) && get_device(dev))
			break;
	...
}

The expression 'get_device(dev)' in the if condition always returns true
since @dev != NULL.

Move the expression to if body to make logic of these APIs more clearer.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c    | 7 +++++--
 drivers/base/core.c   | 7 +++++--
 drivers/base/driver.c | 7 +++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0dc2a2247e5f482fadd3a9376a58e8..73a56f376d3a05962ce0931a2fe8b4d8839157f2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -402,9 +402,12 @@ struct device *bus_find_device(const struct bus_type *bus,
 
 	klist_iter_init_node(&sp->klist_devices, &i,
 			     (start ? &start->p->knode_bus : NULL));
-	while ((dev = next_device(&i)))
-		if (match(dev, data) && get_device(dev))
+	while ((dev = next_device(&i))) {
+		if (match(dev, data)) {
+			get_device(dev);
 			break;
+		}
+	}
 	klist_iter_exit(&i);
 	subsys_put(sp);
 	return dev;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8bdbc9e657e832a063542391426f570ccb5c18b9..69bb6bf4bd12395226ee3c99e2f63d15c7e342a5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4089,9 +4089,12 @@ struct device *device_find_child(struct device *parent, const void *data,
 		return NULL;
 
 	klist_iter_init(&parent->p->klist_children, &i);
-	while ((child = next_device(&i)))
-		if (match(child, data) && get_device(child))
+	while ((child = next_device(&i))) {
+		if (match(child, data)) {
+			get_device(child);
 			break;
+		}
+	}
 	klist_iter_exit(&i);
 	return child;
 }
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index b4eb5b89c4ee7bc35458fc75730b16a6d1e804d3..6f033a741aa7ce6138d1c61e49e72b2a3eb85e06 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -160,9 +160,12 @@ struct device *driver_find_device(const struct device_driver *drv,
 
 	klist_iter_init_node(&drv->p->klist_devices, &i,
 			     (start ? &start->p->knode_driver : NULL));
-	while ((dev = next_device(&i)))
-		if (match(dev, data) && get_device(dev))
+	while ((dev = next_device(&i))) {
+		if (match(dev, data)) {
+			get_device(dev);
 			break;
+		}
+	}
 	klist_iter_exit(&i);
 	return dev;
 }

-- 
2.34.1


