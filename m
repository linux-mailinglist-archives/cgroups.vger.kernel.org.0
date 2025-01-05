Return-Path: <cgroups+bounces-6048-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C36A01891
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3771883FF9
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE84013B592;
	Sun,  5 Jan 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fNqtJsOU"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52213D893
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066112; cv=none; b=RDOs5pQbbC6O9Hg8+OEpHSl05rLEnmOchbjIBX4KFFOdVGntMuJFmmznqZRPfPZLlDw03CDWJ+BguSCSRgagH61OdKFzPcw5/HiEHqHt6zxVgR//Rk60s6B9E++hdg6a+LmpnbEsH4WIkHt1oKx48MIGRAzDH4IwsN5vvAjTC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066112; c=relaxed/simple;
	bh=zSgsbc2+Pi+ODyhW3qjEswcLb/PTSbNrr4ZLFp6ATx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reVfUgpIiRkwL45DTw4609XSMPszX2zRzQuRcma9MS55VjXU2oqqSrIB1xPj1vmOB570VRlkp7DI1hH1CBvHjGdy/vpEFUJfAyiZeu77D2bgr8Gz34yeAtjPn3IrVzF0cf9/fB+FAHjfSf+S/fV16dkg1XS86LDGPqllUuu/TOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fNqtJsOU; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066110;
	bh=lGL3paFjtP/XxIRaogpvMdvoANfFZCRy3MMPglF6rwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=fNqtJsOUzo2XKcy6Rl9qmJU1Tpa/2/bwOycIuwsk18SjymNRvauuHRsJrAMTt1dOU
	 XvCOctvdIK4fLP9eSg9M4VbYnqYX+FEHJqLTDQljrf7m98ZKIO5/6SwZX4hUYR0HhC
	 qmrVCq+WGWchf8WUd19VonTfqpoUh5nrCwtrmmHSXaze5Pd6jCzbvKQpkxuoKESYwP
	 Zw+q6bKm7/m5Gbx2YFhs6P1xysi8+OFgAN+n83ihMjb0ZKkiZl5N5bWQFBIXBUq3LJ
	 xxOTj0J31avPuWdNlmICZO9k5O8j7W2YAs+WaE9QNIvghojGmvdTQ3PSMl1tQx5j8f
	 5/ppgj1GrGF+Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 2CCA74A0349;
	Sun,  5 Jan 2025 08:34:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 05 Jan 2025 16:34:03 +0800
Subject: [PATCH v6 2/8] blk-cgroup: Fix class @block_class's subsystem
 refcount leakage
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250105-class_fix-v6-2-3a2f1768d4d4@quicinc.com>
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
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 1x07iJu_72U2SUGVbMN69LyUMf05-4MV
X-Proofpoint-ORIG-GUID: 1x07iJu_72U2SUGVbMN69LyUMf05-4MV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

blkcg_fill_root_iostats() iterates over @block_class's devices by
class_dev_iter_(init|next)(), but does not end iterating with
class_dev_iter_exit(), so causes the class's subsystem refcount leakage.

Fix by ending the iterating with class_dev_iter_exit().

Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup io.stat")
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 45a395862fbc88f448fe281eeac620710bc1587d..f1cf7f2909f3a74f245ece8bc2fa918776ffbc55 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1138,6 +1138,7 @@ static void blkcg_fill_root_iostats(void)
 		blkg_iostat_set(&blkg->iostat.cur, &tmp);
 		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 	}
+	class_dev_iter_exit(&iter);
 }
 
 static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)

-- 
2.34.1


