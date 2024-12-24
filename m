Return-Path: <cgroups+bounces-6011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C8C9FBEC9
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 14:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117AB166091
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B71D7E57;
	Tue, 24 Dec 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CaFTa2Wl"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153E1C5F3D
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047519; cv=none; b=qg+dpTuuWj3v7XF/HcybmhbzMOv8QnK9nzxChwcIXMPzhfuXn8FfyCgn47lDbrRW7uKCXE18tpYAZrkKJv6T1wvnoFTl5f2nSMcLrjko6tB/fE7Wp6xuYIKk84DAXWaUd9hW0FwEgYWCEYtixqkMcDoPjGCX50ut4Q8RTnl2cow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047519; c=relaxed/simple;
	bh=r1myTHTt6RqQBq+qIcrBHUm5l/c3S1IeRV2Ch3Esx2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kt6OpI0hlEdGtqXBWudrEOCWXtX9iFN0oOEPU0ZHWsLedsle33uJ084EJRRdXWXaQgZJCopujAqG70Hyrld1Yhk3q7vgj68HkeWfDY7YJUDTsSAiA1zg/c1uxuXXxyo5jsNeMuxM4hlsimJJyJRxhRQzP3ceIsLDCOhYCYoB8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CaFTa2Wl; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735047517;
	bh=bpdPHGVvsNjPbtVeiARlh6UhJFtwCfTalqRar5MzOl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=CaFTa2Wlbw9lV6LEwAi2rskMcM+IoWn9FIs1+ZFJerRaIk7HWLfQRgBUlOe3Tx/F+
	 ANu0OfSPhYumY3zEHI1yGNvC+QprK57LVxLDxLBzvMERPUGVzUCuBJaFIWTVPHYAcF
	 bWTEKleMoMvywMZKGTjaF2mhwwQjXPc1B+L8AGPmisSm1thPj5LlwJUNryysW14y2M
	 vW3Wp11vCCRbL6GFBILPVyUvyb4ybLNqkt26XzYPifqieAzkt2IaxVWphzJe7cSdk2
	 bKUM9j5n8eWbHNQ8EDXVcjB+Asa0jcHaROBXr9NSQsYyCnrFAwdQxnkRd0SxMWzuWh
	 qtB6wtx3xlhPg==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id B5CC58E0085;
	Tue, 24 Dec 2024 13:38:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:37:23 +0800
Subject: [PATCH v5 4/8] driver core: Rename declaration parameter name for
 API device_find_child() cluster
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-class_fix-v5-4-9eaaf7abe843@quicinc.com>
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
X-Proofpoint-GUID: 1l8w1MO6zxw4B9ZtsAu3MdKxjmZ8fBGg
X-Proofpoint-ORIG-GUID: 1l8w1MO6zxw4B9ZtsAu3MdKxjmZ8fBGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240118
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


