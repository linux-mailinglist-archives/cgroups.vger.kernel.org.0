Return-Path: <cgroups+bounces-5954-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F4C9F5AF1
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 01:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D641624A5
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 00:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B925155342;
	Wed, 18 Dec 2024 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="UUS7809b"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915114F126
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480160; cv=none; b=bBTIf0fS5XlB/BI8u7tpAW+DA5Z3hbtUjrMNgTknHDnI9H/cyDHVjF9iBI0m3x3LLa/tNwgUBsmNiildxyPn+I157enTIKrjKSuM9ktO1dyqGu4DZWkCO4cGX31+7L4pD9OUAp8qurD9IAJEhcSfwjL5B4ilNQ65KuCafAKkRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480160; c=relaxed/simple;
	bh=G49zBKYjNI4Lr2O92y6LMZppduNJ4fYsvssXA+rD8DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jL6W5YORT+MB89oOG4j+ixOI7uxrR/qlCqXqpG2VypQ8T4JP5iu8fQsR8PvngQ/qVf3brFrWrayHWbM+sLjYjHqzr9adFj3gci2380cIcLf/W24OamsBpKf6iDWKUE3tU0PE1r55zZKR1Q0v27kFSTr246O2ZIKGAi9k47yxx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=UUS7809b; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734480159;
	bh=cOPHgek+7txVXNgAZKPNrM641zXSkIkTh3Riom+d1rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=UUS7809bi9IRKOia8eeN3oT/j6sb15b2Vi7Enta+6kp4t2V/5dZxUjS1kqTvSSJgf
	 2cZjz9wXoOL09iuJjZjp8+g6jF/TabqAOvQRnHBTR0WsB9aheiJh5E0VsDVyx6hgE8
	 XxrvNZa/NHnD+eQX5OAY3jJtr1P9HM5jalMIXyhz6f0jykggvUJ+bfBtlYfHtlvCCN
	 uBRVoWCVVF9O2U0U3QpRs+t5kYhVXeEPqaY6nPQqiNGTl8s0nzNa0VaswDwghGp0ZQ
	 hPyygVZqVJtBkLJ7YnyoXWAVolS6MtxRN3ORxfvOowRm4o1mctO6IEqYUEOdFNXUqw
	 kJF12GbrrvZFA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 3EE7996020B;
	Wed, 18 Dec 2024 00:02:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Dec 2024 08:01:33 +0800
Subject: [PATCH v4 3/8] driver core: Move true expression out of if
 condition in 3 device finding APIs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-class_fix-v4-3-3c40f098356b@quicinc.com>
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
 Fan Ni <fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: CDH0732C4YUMOuSX6q14K8VHFeZp09I8
X-Proofpoint-GUID: CDH0732C4YUMOuSX6q14K8VHFeZp09I8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_12,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170183
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


