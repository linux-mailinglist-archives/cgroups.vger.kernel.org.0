Return-Path: <cgroups+bounces-6009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E69FBEBE
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 14:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500A516216D
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD11D8DFB;
	Tue, 24 Dec 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="DTkI+qi7"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E51C5F3D
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047500; cv=none; b=eBJ0KEWvey7gywAeUbVALHMVl7tP9Dr+6/3OZ03R2+jiCyPbneTgBJGKo0+F54TX+oUbdHeMFOZRAn6H8n6LW5nhTk09bUhzjaVx5YfdNsTWRKu4aSMLXIEEczDPGM9RROCnI3GMqC1N0d+KRGbR1SyGtbXq0icC5lP+05ilvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047500; c=relaxed/simple;
	bh=zMjsz7jAuZ/kQmW7w3lfAwa1gsUcolqTbT99cffmGys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHGoPW+TQvSD7K/282EQ9cGoxnq0kyf5iIOQHXjhQlyP9FPePmzoPp6Qp+RtmDHbj4inQGGFWjvtpNwZAvvK4V2TsurOsuouL5yqt9259A3/cO01KWF2xCu6LC46/TxwUyq3WaCctPdApi4chevDTYpxESm6KPxVl9fik/vE+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=DTkI+qi7; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735047499;
	bh=kn+rsGruQx2pm0qQwtoirYg6DzCwThWomNn9G8Daxpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=DTkI+qi7m2SjRclnlZnr7hKk4vcWZea5PVDWLSEuupRbO27Qy89815Spjsp+z6rWT
	 Ss/KchKoJI9c7/BHIRXQc1e+UbrhSYC1534oyTBTDVGNPhiB6EC2nRS8uA38jJCIAu
	 lZxYjybPgnIuG97mau33SDm9ObDWcLJBbsmir16dHaXE0FT/CC1Kj+WHrnHp9qId2O
	 OYmrtcrLasZdFrcBWC4tbRODa/bEiGJhjmp2mpGVjeU3z/LFO9RpF/sVNO0ph7OAdA
	 9UgfumRWwXEHgJY2A9a+P39ZOvG5YrcPAO+P3ZawUF/sWyjj2eaOey+nRXM4YQgFnb
	 +7LU0XcY5Kxxw==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 240558E04AD;
	Tue, 24 Dec 2024 13:38:09 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:37:21 +0800
Subject: [PATCH v5 2/8] blk-cgroup: Fix class @block_class's subsystem
 refcount leakage
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241224-class_fix-v5-2-9eaaf7abe843@quicinc.com>
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
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: nSnhKvYpzhjTcrD7NiJ5ZdG4NMq4wFeM
X-Proofpoint-ORIG-GUID: nSnhKvYpzhjTcrD7NiJ5ZdG4NMq4wFeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240118
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
index e68c725cf8d975f53703ecf6e6c50594076204c8..fb9858efdfe9443704cb9a239def0e08addf2518 100644
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


