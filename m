Return-Path: <cgroups+bounces-5853-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059089EE7E8
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 14:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BB8161D8C
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C11216E12;
	Thu, 12 Dec 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RtVUp5Y7"
X-Original-To: cgroups@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD92144DE
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010823; cv=none; b=EvVn3wE3Fw2icOjlvbxdkd9r70DtIRryRS+TGga/W24CUmtKDKpZpYJiru3vt7xjjBcycWRBAbhGy4wUEblRdWSoLQfoPptVT1WG7nFHEBjcOnuO51ExuUYLH1dhaD5yOhEigL1YzMAFJiJDS9N+2m13cVoGeZZMSXPSX2fsuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010823; c=relaxed/simple;
	bh=xTs0tfRiGxLqlQU1bZPA1WOpD5NDj3sC2kJdgPus4Qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=affmZL1kf1vLEavrDmULqwUYyWULmWLtFFm1BJcvboEiCsSJN4kaHuXXXIOwiz+xQ1Hqp2FFil+mcQE5dIboVCZKfV+Yh2sonN3WGi6fXhwq30kruZCUNBxSU34bhszoIwCjgHglzl0slAqcE/RLmDme12BFdaIP/yuaRYkntik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RtVUp5Y7; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010820;
	bh=PJ+USCXikXXOIa5sjtReFqqyn2Z79RPqI/MdeM0TEeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=RtVUp5Y7CwHrlKUHFRw4PblS7dSf3gZ+tfFnNCWCI0Xr4eRWYZQcdll0m4a5SDypT
	 HcA3ZSvYiPfCU5w28LcWcUbl3lJqBx3qhV6m8X0ZmcgfEAkvRVNQ2GMAIekT3/KyFm
	 3vczs6AJ2QbP3iCETnT8h8rlY1SFVZEFVlRWWMjMZnuMLBEFSLqTZH9Oxdgm9Ye617
	 29jvghvmp4HykRDugD5dC/iPazC7elqEtW7wpyhrpClIcrICez0lc+3EPZQ/tI7WXK
	 zoIOu0RhWDZ9VSQ9/avBKAz0MsqhPhXXX7pOB11Nxs519NtS+j9h/QU3xDuFvAlmH7
	 nQddK34voHR0g==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 27A94CC05A8;
	Thu, 12 Dec 2024 13:40:09 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 21:38:42 +0800
Subject: [PATCH v3 6/9] driver core: Rename declaration parameter name for
 API device_find_child() cluster
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-class_fix-v3-6-04e20c4f0971@quicinc.com>
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
X-Proofpoint-GUID: -X7mVsDv8xUXYZmJRACbgXBbnBOV2epq
X-Proofpoint-ORIG-GUID: -X7mVsDv8xUXYZmJRACbgXBbnBOV2epq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
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


