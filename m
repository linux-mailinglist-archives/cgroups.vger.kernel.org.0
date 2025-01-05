Return-Path: <cgroups+bounces-6049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8D1A01894
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F4C162B28
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3679C4;
	Sun,  5 Jan 2025 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nfoXIRM6"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1113DDD3
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066124; cv=none; b=R3c2PO1nx5VE2jGNn6JdbaZEJFNr3He3PmBO0Pqns/bPAl+JaSrkuVwBFS7ihHpI9BnqNylwKcjQYkbPNsr24V0XRe5O16a9O9b3XrUJEyeLYxpazxEeQBscsXMgH1OX0Dp4i2ovML5aNqbPKp8piVsPq9qHf3sTtIDsYk66cNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066124; c=relaxed/simple;
	bh=nHUKjtCa84MPYL+GlDf95K/i7UhG7yvj3y1scXIZ0aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/c6y1TqHNgKQPoQp2J82ZjQC0oGzDmJ2Hd/3Pj0aDRTId011Z8UP/Q0JKdgOkgHhDdYXQIv+0whxsxh7GDHh7+Cu5ZQQzdLA5eYbQ4dtU3sGFyePEqTejKvj0fUxGKaP22sA6UzNQ/OO+FiZrV/Aalm1vw3b8dD7YX0ygAdXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nfoXIRM6; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066121;
	bh=IFL4sqkTU02o6bt1eHtOI9QlAEJv+Hc92FiAS7SV86Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=nfoXIRM6+N3YTu3fDz2lKFbV2AjxC8eDDQU/Vr1YoioB1Ai/dl3o+92ZYYiNJEKVM
	 ElNlsMfim24Hgs+rqvhD5n9LGkm1KrAWmksZLKx9GzWi+iIm/Hr1NaYZuBvme1xfYa
	 I2kIGVmS3p9Bxhyz1FkaKpYJw8zsF5MKlsHhYfQwsbUtl/DxBucwzdUo6G9bncwYJX
	 3LEFHK07PNYzuHSetyDV32mz3yUf474DYCEDZ1QGW03up9QceQSbakjMgFRADDiDyd
	 pAjZZ9pS/ZJZtI9u880V2/6hZX8XF9ug4H9EFGTHQ08xJDAEV68b7Dtig/O6k1DgKB
	 SgO96LSrnY08A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 471924A049A;
	Sun,  5 Jan 2025 08:35:10 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 05 Jan 2025 16:34:04 +0800
Subject: [PATCH v6 3/8] driver core: Move true expression out of if
 condition in 3 device finding APIs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250105-class_fix-v6-3-3a2f1768d4d4@quicinc.com>
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
 Fan Ni <fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: EDQToYwsTqdg8GcAexXi0X55ZHrCcmKW
X-Proofpoint-ORIG-GUID: EDQToYwsTqdg8GcAexXi0X55ZHrCcmKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
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
index d4c20e9b23da71e9afb11108cf4353ed1b47f591..a83a1350fb5b2baa5e4ee0f5e5805a5bee536ec7 100644
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


