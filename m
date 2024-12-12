Return-Path: <cgroups+bounces-5852-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5E9EE7DE
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 14:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A7F18888F1
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86021505C;
	Thu, 12 Dec 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EdhlcaKD"
X-Original-To: cgroups@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD12144C2
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010811; cv=none; b=kcZR1Sd+Xb5pIdJsQDdqM759m6qZ+aUN7NnXZm4GtPTjjw72s4D4R2qCqXc2oG6aevBbRKFFBWfDS9ONxHO8QFea5v+fTYFTK1q47K5+zY5rZY7j5yM0ixW2dOoKaG7vmWzfxGVQkcJb3u1XGi7leQ+hoRTmH93BU96ieER4gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010811; c=relaxed/simple;
	bh=R8VIFdyqapZyJOl/BHNlTI5vngCzvR6PKVHcwc9zcVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwA3ThX68Xw6UyTRcYiLxRwFyKJxr0P51OiQpQqihUuksrVYVC/TamFGpqiERQuuKDy28/CZBDQZccHF54hP8bOL49E4LmgigIXBAPNsZurqkVgkHOaU4DS3lfO1fW4k3AEMh3T+ihmMj7VjiL027UDI4kuvOMIK8OV5gfXdghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EdhlcaKD; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010809;
	bh=ybt5vh1QaA/axSj+u1J5wKyDXeYgnZy6kLh7TPuQ6Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=EdhlcaKDlwBjGmboSo9N7IX33tBRzPxC9/Sax05kB/pjdUj/fq1blxVxXzlB2zGfV
	 f2BDRV5DqsC8NOm0Efzl27MRUnO2bd205kSJdydfvKg0Qj+G9Bz+wmuHgfhHI43vR6
	 6aHHpo6sHCwoRN3rB02NYbmsMUEeJwE3MtuGHKW4UirnDrO+GcQRZgJQRkhtVkFIXn
	 TLVgYZa1i8Ri9QVPL50t7eoN/4cFOyRmi5J8Nn/Gr2BXXDZeqaK4ty5pSy7MfZ7FjL
	 ZT+BUXKYsU1N1NTGvdUndJYIAj/tUAxNppDe2C3S5CRAqoQYwty+2iigNuGcegvGks
	 RvZeJ9WfQxT1Q==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 5857ACC052C;
	Thu, 12 Dec 2024 13:39:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 21:38:41 +0800
Subject: [PATCH v3 5/9] driver core: Move true expression out of if
 condition in API device_find_child()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-class_fix-v3-5-04e20c4f0971@quicinc.com>
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
X-Proofpoint-GUID: C_R3DRM13jgyUA-8TDHIoyiorACvbERK
X-Proofpoint-ORIG-GUID: C_R3DRM13jgyUA-8TDHIoyiorACvbERK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For device_find_child(), get_device() in the if condition always returns
true, move it to if body to make the API's logic more clearer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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

-- 
2.34.1


