Return-Path: <cgroups+bounces-6051-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11825A0189A
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36D9162DFE
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9E614884C;
	Sun,  5 Jan 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="f5W8D8Bj"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4531145A0F
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066147; cv=none; b=s3ZbJfxRGp3FmV5wCAxx8cfVjs/ZLv9xZ+wc3cnJssfpb70xIYeYJfzSZ4GWfvqrxR5qjmnRhbuHnsGj9Fuwo6zQ1qf4HZqH4Bp4Tycgzxg5Kl5Y7lmJE52Sj+UJuGYSpuHfzetP0O3XMYVGuZ4qq4Axo5zeWio246lB7kJouv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066147; c=relaxed/simple;
	bh=gCtVgE/p6B7cb/mIY4S5SzULQWHKTBzF14LVzxG8qd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZF3S10ytcIiO8M0cH44Vf4tyEq1GOsz57ub6lsVS9TwmrY9oSCp9tE11+BSbl+L8kOqUunjZ6xt5Hkn6lj86dg8yaPuCKwVkm2ommpMVbfa6uwgFMeM2ZrPRrfb9QHfS8Y6gmrSkRz/DEMVXM0aAUd3d2fGFb6U/Ylfj/EpHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=f5W8D8Bj; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066143;
	bh=v7TY2cXo1rPKtE2u6WFZ8DXwANe3uGTSZ6dUA30jYLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=f5W8D8BjofRPSSLCnjULS1vEQX0Php5sHsMwl6eTPWnhuKEjud4OqI/ISbb6jhJzi
	 J3hIJ4BUM9IR6uJpF8pZzxlMiYiGNn8DcNru3ZvVGbfWZxNdfTt8cqcNB1Q1BN3f7o
	 TkwqTo3AD19uPMLTw/45ByJ0xg0zm6LQCqIIZPpf23eKd/Af9b2N1elmb6n7M0d/47
	 oDb3q4C3yHaeoFbEM/v3p6TGtxYKaTBH+jigUHMC47EPIB9oY2+icme8T2nsT/Xra1
	 fhpvgYZzVHV1HhAXthU91g8VG/JKqBGNgh/nJbOkp1w6d0nTFXgmnPfzViQ+nOCpXA
	 zykVjLJ+DKyAw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 642214A02C4;
	Sun,  5 Jan 2025 08:35:32 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 05 Jan 2025 16:34:06 +0800
Subject: [PATCH v6 5/8] driver core: Correct parameter check for API
 device_for_each_child_reverse_from()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250105-class_fix-v6-5-3a2f1768d4d4@quicinc.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 7RSf8dCEIok0jeq83oKz6VFGuEeF6iUQ
X-Proofpoint-ORIG-GUID: 7RSf8dCEIok0jeq83oKz6VFGuEeF6iUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=710
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a83a1350fb5b2baa5e4ee0f5e5805a5bee536ec7..d3800f0dc5bbd2a7de80bd58b50e31038265da03 100644
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


