Return-Path: <cgroups+bounces-6050-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC3AA01897
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A898E162F75
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C7B1465BA;
	Sun,  5 Jan 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eaCBSM2G"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16947145A17
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066135; cv=none; b=ZqUw7wIoz4IfGQ3Xq5LSldfxezvUxLkVpILs4pzCE5pJSRcr4PCZux/ssmY1JqvRgaV67mw74flgFizkCBMQK3GI9Q4Y8u2K41fuQ9qXHzB0rfIqDcszdye46+eZtsn96FttvPsZb7GqiOtyrl9f7KBsXYdYZW0+Z4xT5yMN7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066135; c=relaxed/simple;
	bh=r1myTHTt6RqQBq+qIcrBHUm5l/c3S1IeRV2Ch3Esx2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s2Ed6YZ9hYKifuKcI9lULNM66pgfTwAdkTyxibaZdKDB+k4qxaTsYv7G5hd9i1zlcxeVl7hyM8VtwWqK5+6Yi/YyJRPPQEsTGzft+5t2DdM2oiHnwlROesOiyO/7VFgvpGpT2I+LSO+QTcU0hhuyjKynNwuEHYtwZNMEQGCXYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eaCBSM2G; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066132;
	bh=bpdPHGVvsNjPbtVeiARlh6UhJFtwCfTalqRar5MzOl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=eaCBSM2G+TeHwDF09uDQGvbhZ7n1Hc8o1kKaxNfNXbMGSEYmmqiG+cWPkKNapf+QA
	 xgkYLn5aOKygXgdAISBQF39wHvFRwICVRet/74loPtk9K3K1dxr+ZwlpT7E3n69v/L
	 rgjt4jqzvHSa+ZKf1lymo+85RhtTy4Hkq2/+PM8O44iRN1O8x3HGsfqh5qEQ6GFM79
	 2zyEfBPl3BH5za5trVhoT26lPbJfP8QYIdgJLPPUTRuR6bMUTu5KHBw8tb7yBQnuME
	 kcvjdxc4KXlm8nZtubyyCvBuUeDyLSu2//5B+W7uRJ6uWlLxgNYZJ+NYyZq2vNbnrD
	 5M8yvBBYmJXXA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 571724A01FE;
	Sun,  5 Jan 2025 08:35:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 05 Jan 2025 16:34:05 +0800
Subject: [PATCH v6 4/8] driver core: Rename declaration parameter name for
 API device_find_child() cluster
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250105-class_fix-v6-4-3a2f1768d4d4@quicinc.com>
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
X-Proofpoint-GUID: _7sbAjSMV71f8--LJCaWVvr4sQagM1Ue
X-Proofpoint-ORIG-GUID: _7sbAjSMV71f8--LJCaWVvr4sQagM1Ue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
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


