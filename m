Return-Path: <cgroups+bounces-5955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC879F5AF7
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 01:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41148162C91
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 00:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2D15853A;
	Wed, 18 Dec 2024 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xy/6u9uL"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F2157A6B
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480168; cv=none; b=ePJR7B2U2yLt+zhnMSwBiLq9BjgDfbODs9ik7y7TR+VxYUz90Mdx90BqHniSez6CzzK1iYgqvcDeWKpMa3AhM6AqVSGHM4ZjW8nOz2MOo1V2ClRjIbAihsnoDbQ8R86vNzYF0jo6CeEN3lHTwNPoNxDyHPoUzVzT3i+qL/zT19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480168; c=relaxed/simple;
	bh=r1myTHTt6RqQBq+qIcrBHUm5l/c3S1IeRV2Ch3Esx2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFHd9JSbG03Xn7vAhZN9mNS2YnkgxDk5F9sLyAsI6t3nKq9/L1V3cvZUbpkZ9+sm7wLBqp1DEZdNB8UQMcgCL/bRM+AUAIfqN+TwDeWTI6obvPc9hqmmnL6FKp5QmTLOPuGCUxhpxDpPgqKjkiDFIqJmfs29W7jafGmGNzeHHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xy/6u9uL; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734480166;
	bh=bpdPHGVvsNjPbtVeiARlh6UhJFtwCfTalqRar5MzOl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=xy/6u9uLKuAxe1VdLiHgYm4XXVsoBQt2J//8hxcoCn7v/oJlO7gY2NU7kEbIejMkg
	 F0E0duVeZhFvdyyXtOGTKqkeXLJgSODBcsWEUypnS9Ce5ZBKFpK+7VFIy3NSOIAizn
	 9ml2Gwx/PDNablLOtG7drfn7Ow0Qika7dTsI4qslvn/UQ9VuBkBL47cGnkfnZ2kbJ9
	 LLBZ4+auHNB2CgLP3Vy33XBtps1DG0JSfCitgh42bGbKKNxZbstkszos+ABoB0+vyX
	 gy8eeOADm/Or3SoCSSaAxXfj7kdDK5o8Ju6ZAL7ZnpxNdZH5sTGN3cDnlxBZpIjJ55
	 2XEicBXj77vGQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id ADBA0960497;
	Wed, 18 Dec 2024 00:02:39 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Dec 2024 08:01:34 +0800
Subject: [PATCH v4 4/8] driver core: Rename declaration parameter name for
 API device_find_child() cluster
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-class_fix-v4-4-3c40f098356b@quicinc.com>
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
X-Proofpoint-ORIG-GUID: YWGCb2xGChNivds01FUrxipNy657CFO1
X-Proofpoint-GUID: YWGCb2xGChNivds01FUrxipNy657CFO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_12,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170183
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For APIs:
device_find_child()
device_for_each_child()
device_for_each_child_reverse()

Their declaration has parameter name 'dev', but their defination
changes the name to 'parent'.

Rename declaration name to defination 'parent' to make both have
the same name.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/device.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0e0bc9bfe0d15a8734bf3d34106300f4df6b5364..a9d928398895b062094b94f2c188cbe9951d7ac1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1074,14 +1074,14 @@ void device_del(struct device *dev);
 
 DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
 
-int device_for_each_child(struct device *dev, void *data,
+int device_for_each_child(struct device *parent, void *data,
 			  int (*fn)(struct device *dev, void *data));
-int device_for_each_child_reverse(struct device *dev, void *data,
+int device_for_each_child_reverse(struct device *parent, void *data,
 				  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse_from(struct device *parent,
 				       struct device *from, const void *data,
 				       int (*fn)(struct device *, const void *));
-struct device *device_find_child(struct device *dev, const void *data,
+struct device *device_find_child(struct device *parent, const void *data,
 				 device_match_t match);
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name);

-- 
2.34.1


