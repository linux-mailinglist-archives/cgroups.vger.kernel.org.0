Return-Path: <cgroups+bounces-6012-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D582D9FBEC7
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 14:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8E31880992
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B211D8A04;
	Tue, 24 Dec 2024 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="05j2rkJi"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36662440C
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047527; cv=none; b=fxTSPZPOow+4Kcnba7hpgDRM5okRLYHp3tSLywOzfa1VcjLEBUi9ykb4KUUdiJoRiSOTBdXt/oOTNiDm7taaBHMuumap8WLmgoO1dqNdFI0M4YD7x+6O4X+p3vkiJTuJymt6JpQjyIc8RMhRcZeP8YfjKuk9IfaL4lSG8PkIyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047527; c=relaxed/simple;
	bh=9Y0rzZnBTx0M5MQSIP1RwELLmzfYczu0ijWLu1jrY5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esMiOn3P12QzyUsP4GwBoIAZ3isR+IiX1JAKTT6xgkGW98tgBgms6wbe3HJzjoQR/rhZYScreKpy0S2PFDP6GFl5dsCvlx2e39HiyFNF+od5q6mzAIFd3eAiBa3rH9ZbO8SvUv+K/DnKxwq4c6cCfR3oQlSHCnPh75ITeAvc1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=05j2rkJi; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735047526;
	bh=VKx9/BEbeYqmaBNZCu91NOLWQRLnn6ACylShMKN74W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=05j2rkJiZmrEtB/hjXW6uQ68Gx95yipkAoAmir2FtrippHpd8MzntYVoZKuyb3r3d
	 QRZRie695fTkFWJitaNv3J/KkHmMb4BlmBe6qHRa0Ta02uxJgP+9i//kYAHLMU43Du
	 AqZ2eOYNkXDMBljB09UQRP5ptVbTW3puNyVv1PEJEziY8ZBB50L1gB9/H2lmYJWXug
	 CjG0IPmQVOrqWe0QF/GLk9y58MHU9nLvtsxewtpEsaiUwSgzXmOSPSSxNsZR20575S
	 9ZN7+0ztpSCAPxdBNPwi2YDJ0lN5t6e3//SjrHS2+nnOoVg9/srMve+UkHGpxTFG2H
	 zVN7fk1zV5BVQ==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id F284B8E04BB;
	Tue, 24 Dec 2024 13:38:37 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:37:24 +0800
Subject: [PATCH v5 5/8] driver core: Correct parameter check for API
 device_for_each_child_reverse_from()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-class_fix-v5-5-9eaaf7abe843@quicinc.com>
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
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: l6LvHSUmMmOtqtG7zqS75V_bnCNiilQC
X-Proofpoint-ORIG-GUID: l6LvHSUmMmOtqtG7zqS75V_bnCNiilQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=882
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240118
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


