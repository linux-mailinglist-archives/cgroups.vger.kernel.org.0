Return-Path: <cgroups+bounces-5953-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5EC9F5AED
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 01:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681681622F1
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 00:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FCD14AD3A;
	Wed, 18 Dec 2024 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pY3ZflW9"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4C145B1B
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480153; cv=none; b=cnN0vD1hHk1PcfjAHyQESc4hl+3J+Eo/A3/jrCLDfgNZEfwA2N8emRKoYN+iKWhcgZxeGPkDlp9jUFuf5hPXYn4YqmsgoSe258XLGvT/hAfD6kOMZC9GXRJe6K71tqMYOPCQAjxMIkoTciRGWBRAHr5BeSxxiAkXtUX9OpzyqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480153; c=relaxed/simple;
	bh=v2UDBGjNX/TBVEEyZ+l09JjXrifkZ0al8qUGlpvaJ5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtpyJhWuUiOdt4BTo0DBHPkt9bTKhsCq+K2hk2w3GEqbvAj1pIv6hojiKEsaazz9ZihYUrpKN8s3QNz8dSSWwadu9mx/rMyOyT21IfX1e3AXGbSP0zrYbQhN2XDS0yxPAaQMo/HWftbUk5VXWkChkJx2qgesWTYpVC1F3xxyNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pY3ZflW9; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734480151;
	bh=/xL/Yze+0QjxeSoIHE+CFVDh+nPc165CBlyFJrejgkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=pY3ZflW9atnEjrr9EIzDbuL9ZSgDGxe828AAJGy9cs9HGiCB5xKrQcpBGka6yldc8
	 68k2kzxpFFozC3+D9tWJ2MUVixANz8MK1wRR8HUlmympWp5MGsvh7VU5zUJhvwlDmM
	 yc6DEZkySYFqhjGDGBLq/HDPKEdODAuzaBKQ123AvVa8+J0atiRLLOIZ4BsxCRCFAi
	 2rXntuKzFXIwFJmA0KTN/l5MQKmZEm4R2zFKQqsGjgf4FC32YPMFEUJIkXZopIyWQy
	 ex9xev3bIrtW0SHcFQSfSAxMzcGSD198TNg2yqx1DmFqHQQOdkWICpqiXUd9l7LfFm
	 pDOoCYJ7mKF0A==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id CBD979602BB;
	Wed, 18 Dec 2024 00:02:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Dec 2024 08:01:32 +0800
Subject: [PATCH v4 2/8] blk-cgroup: Fix class @block_class's subsystem
 refcount leakage
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241218-class_fix-v4-2-3c40f098356b@quicinc.com>
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
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: OO8FJ9GKUHIVtIi_MadGQBRzJ2KI06yY
X-Proofpoint-GUID: OO8FJ9GKUHIVtIi_MadGQBRzJ2KI06yY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_12,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170183
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


