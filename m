Return-Path: <cgroups+bounces-5854-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8939EE7EC
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 14:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BC71889407
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89252153F7;
	Thu, 12 Dec 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nIB8IsdD"
X-Original-To: cgroups@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA2214A92
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010833; cv=none; b=jfFrQQZ8wBCffJu7I607X98bQ3ZXbxdtb0wycVcrydfVoCYblXb8jh6Jlx4LShxIUyPOPe0bU2jptTt4/AYudnCBqY5gQD8UsBm6a/4GGHQ5V/FGhU5BNQijoxDc3CvbiYTq/KGgDTn58ctmVAaiRLXu+AjR0tckbJNPPScVczU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010833; c=relaxed/simple;
	bh=9Y0rzZnBTx0M5MQSIP1RwELLmzfYczu0ijWLu1jrY5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQS3aORegLbF93YiseJtLIp8r9bjym7xoywizM6VVJL+rDMv/5J8gxelp66D2tOcv17/JxLgi1PHFNHO0jPRSorKiiNBjg/V2sGlpoEY6VWHvGEDr1tN7PqRsu6Ok/dByri4KLMn+0y/QWIS/VmuVH0JSUROQd8O4ckx33dqvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nIB8IsdD; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010830;
	bh=VKx9/BEbeYqmaBNZCu91NOLWQRLnn6ACylShMKN74W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=nIB8IsdDwOoGW46n0TW3vhB1KBisrBiDMPqbp8nCwsLFZZ+k7+Lmlqlj+JG3J8Scr
	 xRgJcHpHL169NI8N5YlFLCjPfdNmGaJhaVaUJHIZ+4gEJTixtMVqeHiGdHmD24qiy0
	 LJG6t2H4xputS0p5P1XTxU/VCLU1a+51AV5QG8dKpKsOAJhxt0M0F/ab4hwq15wKEi
	 W/CIR/jmYI4dlrX5Vwwj09QD6dju02pQYe9or91JIRbRohM+N7L65jcLLuLCID4fkV
	 nUH2Hwbzqa+O24H5PSbDAXI5pYGR6nE/EXdetQ2lOvopDDyUP/Q28YJHC2jrIr5Cjw
	 vDkRKKpdClxyg==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 88487CC01D9;
	Thu, 12 Dec 2024 13:40:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 21:38:43 +0800
Subject: [PATCH v3 7/9] driver core: Correct parameter check for API
 device_for_each_child_reverse_from()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-class_fix-v3-7-04e20c4f0971@quicinc.com>
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
X-Proofpoint-GUID: tB6raR49I267QBFCsBauAbl4kPrToOFi
X-Proofpoint-ORIG-GUID: tB6raR49I267QBFCsBauAbl4kPrToOFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=881
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

device_for_each_child_reverse_from() checks (!parent->p) for its
parameter @parent, and that is not consistent with other APIs of
its cluster as shown below:

device_for_each_child_reverse_from() // check (!parent->p)
device_for_each_child_reverse()      // check (!parent || !parent->p)
device_for_each_child()              // same above
device_find_child()                  // same above

Correct the API's parameter @parent check by (!parent || !parent->p).

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 69bb6bf4bd12395226ee3c99e2f63d15c7e342a5..34fb13f914b3db47e6a047fdabf3c9b18ecc08cc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4050,7 +4050,7 @@ int device_for_each_child_reverse_from(struct device *parent,
 	struct device *child;
 	int error = 0;
 
-	if (!parent->p)
+	if (!parent || !parent->p)
 		return 0;
 
 	klist_iter_init_node(&parent->p->klist_children, &i,

-- 
2.34.1


