Return-Path: <cgroups+bounces-5951-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 946E39F5AE9
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 01:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4904B162505
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 00:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF182AF1B;
	Wed, 18 Dec 2024 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="X98NLjzy"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52733D8
	for <cgroups@vger.kernel.org>; Wed, 18 Dec 2024 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480139; cv=none; b=lZYZxAIHV+DAzjPJ8wCIvLau2iiA2yBq2VETkXLHav2mTtwlwdAcrNhN3KcAxj8orEjgWaQKvurcB6tc0PWLgLcwhRoSGANL12MVtszVjSUEegQic5J88QdOc7BBkwt+fXm5Rx3iOE5FgU54PZiXOxWRI36eyS6nBC/uotcidp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480139; c=relaxed/simple;
	bh=twBoU/hUI0BmgFQO7AYrFtb1Yc7+m7J4E3301tqjuAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uwEevDa9NMn11EdeDu6HVOtxhl7lOZN9Y00DZ5Fm5Eq4rVALNgp2VuHyTFZhRvuqokKTMY1aHIJPIWCxDghkiTD6Vn4/jNiFOpCbym1Dssd8LfO1empKcyFQMzizMLHoLJoJV1DuNYDcy/XXxgGZusowTPdQVju485B220g+uyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=X98NLjzy; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734480136;
	bh=TAmttWzYiyjZd5pyfmY5LYYcGBF5iOXw956oS/nDGtc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=X98NLjzygvnowUFQNJGiqv+9g15ao+2S/JyPh+Z0yGqILITTjAUNDV4ixt7JeRRR0
	 NTwiv3b89cox2P09LNPwIpRePqBNhTwwspNYjWhUPDDn+Btn3LUjsimTgh7yxNdI5+
	 xPlHjw4G6R/MmLjpAbrK6YCfJ1E37R5cHYF2A8aq/0GFyT580qjVvBxr3mQZ7tL1MT
	 4o/d/yHb1h7rklHvg+T51o53ZHnJ/ol9GphINfN9MULTXtm1juq3rs/v+bPe2wY8x4
	 ZJ+ryt3thd4LsvHB/JOXxYP9k++AZCf8Azkd83FfPufsXahQySHeleojaLeNM6QE2S
	 tBB9zVdr2cPaQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id F309D960180;
	Wed, 18 Dec 2024 00:02:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v4 0/8] driver core: class: Fix bug and code improvements
 for class APIs
Date: Wed, 18 Dec 2024 08:01:30 +0800
Message-Id: <20241218-class_fix-v4-0-3c40f098356b@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANoQYmcC/22Q3U7DMAxGX6XKNUF2kqZNr3gPhKr8OCwSa6EpF
 Wjau+NtQnQSl/6Sc+TPJ1FpKVTF0JzEQlupZZ54MA+NiAc/vZIsiWehQBlEMDK++VrHXL5kxs6
 G5Ch4pQT/f1+I46vr+YXnQ6nrvHxf1Rte0l9Lu7NsKEH20FubnXPGt08fnyWWKT7G+Sgunk3tW
 FR7VjHb6YSuT+Ah/cPqP1bds5pZMKQgmgyuw3v2fCu0EKe1rLdWIvhKkt+PZR2amJIGCgGDy9p
 i6xJ3gL4PFj2RsoascanzYn/LobntAsieqa5jynFM80TSe4odkg6B/LAZXuH8A3b/uy6eAQAA
X-Change-ID: 20241104-class_fix-f176bd9eba22
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
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, stable@vger.kernel.org, 
 Fan Ni <fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: zmuUOPLAPeEA9ukysVMFzKdYQRil6pPm
X-Proofpoint-GUID: zmuUOPLAPeEA9ukysVMFzKdYQRil6pPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_12,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011 spamscore=0
 mlxlogscore=872 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170183
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes regarding various
driver core device iterating APIs

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v4:
- Squich patches 3-5 into one based on Jonathan and Fan comments.
- Add one more patch 
- Link to v3: https://lore.kernel.org/r/20241212-class_fix-v3-0-04e20c4f0971@quicinc.com

Changes in v3:
- Correct commit message, add fix tag, and correct pr_crit() message for 1st patch
- Add more patches regarding driver core device iterating APIs.
- Link to v2: https://lore.kernel.org/r/20241112-class_fix-v2-0-73d198d0a0d5@quicinc.com

Changes in v2:
- Remove both fix and stable tag for patch 1/3
- drop patch 3/3
- Link to v1: https://lore.kernel.org/r/20241105-class_fix-v1-0-80866f9994a5@quicinc.com

---
Zijun Hu (8):
      driver core: class: Fix wild pointer dereferences in API class_dev_iter_next()
      blk-cgroup: Fix class @block_class's subsystem refcount leakage
      driver core: Move true expression out of if condition in 3 device finding APIs
      driver core: Rename declaration parameter name for API device_find_child() cluster
      driver core: Correct parameter check for API device_for_each_child_reverse_from()
      driver core: Correct API device_for_each_child_reverse_from() prototype
      driver core: Introduce device_iter_t for device iterating APIs
      driver core: Move 2 one line device finding APIs to header

 block/blk-cgroup.c            |  1 +
 drivers/base/bus.c            |  9 +++++---
 drivers/base/class.c          | 11 ++++++++--
 drivers/base/core.c           | 49 +++++++++----------------------------------
 drivers/base/driver.c         |  9 +++++---
 drivers/cxl/core/hdm.c        |  2 +-
 drivers/cxl/core/region.c     |  2 +-
 include/linux/device.h        | 28 ++++++++++++++++---------
 include/linux/device/bus.h    |  7 +++++--
 include/linux/device/class.h  |  4 ++--
 include/linux/device/driver.h |  2 +-
 11 files changed, 60 insertions(+), 64 deletions(-)
---
base-commit: cdd30ebb1b9f36159d66f088b61aee264e649d7a
change-id: 20241104-class_fix-f176bd9eba22
prerequisite-change-id: 20241201-const_dfc_done-aaec71e3bbea:v4
prerequisite-patch-id: 536aa56c0d055f644a1f71ab5c88b7cac9510162
prerequisite-patch-id: 39b0cf088c72853d9ce60c9e633ad2070a0278a8
prerequisite-patch-id: 60b22c42b67ad56a3d2a7b80a30ad588cbe740ec
prerequisite-patch-id: 119a167d7248481987b5e015db0e4fdb0d6edab8
prerequisite-patch-id: 133248083f3d3c57beb16473c2a4c62b3abc5fd0
prerequisite-patch-id: 4cda541f55165650bfa69fb19cbe0524eff0cb85
prerequisite-patch-id: 2b4193c6ea6370c07e6b66de04be89fb09448f54
prerequisite-patch-id: 73c675db18330c89fd8ca4790914d1d486ce0db8
prerequisite-patch-id: 88c50fc851fd7077797fd4e63fb12966b1b601bd
prerequisite-patch-id: 47b93916c1b5fb809d7c99aeaa05c729b1af01c5
prerequisite-patch-id: 52ffb42b5aae69cae708332e0ddc7016139999f1

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


