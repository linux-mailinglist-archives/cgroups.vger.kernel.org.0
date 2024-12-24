Return-Path: <cgroups+bounces-6007-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE99FBEB5
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4CC7A1DC8
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4C1C3BFF;
	Tue, 24 Dec 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iSCCEvwb"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79ED440C
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047482; cv=none; b=rvVmv+0QwF77EYrbDOl9bhjjIenzLcirnlUtLLOocuwD0GCjo9c8VhBDn4F3u34fWzg9fw5tMgnVqXQKL63KMDCTFytS9ji8snhAB27EPuKc6xzW7+oFCy9kUEjJZcYr93XW7shXEiY5Sg5DzHlc7HxzYXoMOTDAufQHn8Mf8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047482; c=relaxed/simple;
	bh=aPpvpsXi/EswvNPIWLSY3NMmTXIESW+FEK9y737W7DM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DsbRI4RD6o72LPg3tflM82edG4ymKSlGfWWKaaRqNr3LmGwQpYzXwO10bAZ0CaB1qQ2B6mQ1J/95Mm7oa1LM7bdkFXX73OTqSSpAhCTNYz7sFcV9ziVt72SU3Xtp3fl0M4blvDfbTTP1gqqzX5YA+FreIlP8bddWVopIXC/3nao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iSCCEvwb; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735047480;
	bh=2M+Ps+FibYYAOJJogIDlBEZcgzam9+JgkUrzpg6dnvM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=iSCCEvwbMfDiev3yj74Qz29bPrGor0p7hJGBQowBJl5Pq737zlAF0czSIT2fjqTKg
	 JabxybUNk5dZmQgZjZU2c+XTaKaIMSC1uXOHdDD8C8jIjsjuFkqqyLj4QdZpsqJxUa
	 uyqWwsOkj3JFBEhRqMvPHLFB72pBbQKxsHwNrtPOE5kkvAy4Uc6kkxsE5+iCzLgsjU
	 Wu9rUeAzYCDK0qoAGKrFw9g6lVPbCjl3Xl/yXXQoV8NXsSsrO8qxzHfs9kQ/m6ygjU
	 0IBv9tloinF0k2Tm+FYLTNOMNOwn3vrox4HSX6ZCDQmecwtD04j1ZPNCO7dcv3TwWs
	 F858WPBrGAfsw==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id C89A48E0535;
	Tue, 24 Dec 2024 13:37:51 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v5 0/8] driver core: class: Fix bug and code improvements
 for class APIs
Date: Tue, 24 Dec 2024 21:37:19 +0800
Message-Id: <20241224-class_fix-v5-0-9eaaf7abe843@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABC5amcC/23R207DMAwG4Fepck2QnUOb9or3QGjKwWGRWDuaU
 oGmvTveJkQnyJ2dfH8i5yQqzYWqGJqTmGkttUwjF/ahEXHvx1eSJXEtFCiDCEbGN1/rLpdPmbF
 rQ+opeKUEnz/OxO1r1vML1/tSl2n+ukaveOn+pNhNyooSpAPXtrnve+Pt0/tHiWWMj3E6iEvOq
 jYW1dYqtp1O2LsEHtI/Vv9adW81WzCkIJoMfYd/rdlat7WGrY4GGDpt23Bvz7dhzMTdWpbbRET
 wlSTvH8oyNJ1LJmu+HdEGi12IIVNHERKgC7x4GgGCE9t/GJrbWwA5Z6zLLuW4S9NI0nuKHZIOg
 fywWn7C+RtNWEdj2gEAAA==
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, stable@vger.kernel.org, 
 Fan Ni <fan.ni@samsung.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: coH3phFozP4hnAwycRiGvxyw7YgmntRK
X-Proofpoint-ORIG-GUID: coH3phFozP4hnAwycRiGvxyw7YgmntRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=846
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240118
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes regarding various
driver core device iterating APIs

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v5:
- Add comments back and correct tile and commit messages for patch 8/8.
- Link to v4: https://lore.kernel.org/r/20241218-class_fix-v4-0-3c40f098356b@quicinc.com

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
      driver core: Move two simple APIs for finding child device to header

 block/blk-cgroup.c            |  1 +
 drivers/base/bus.c            |  9 +++++---
 drivers/base/class.c          | 11 ++++++++--
 drivers/base/core.c           | 49 +++++++++----------------------------------
 drivers/base/driver.c         |  9 +++++---
 drivers/cxl/core/hdm.c        |  2 +-
 drivers/cxl/core/region.c     |  2 +-
 include/linux/device.h        | 46 +++++++++++++++++++++++++++++++---------
 include/linux/device/bus.h    |  7 +++++--
 include/linux/device/class.h  |  4 ++--
 include/linux/device/driver.h |  2 +-
 11 files changed, 78 insertions(+), 64 deletions(-)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241104-class_fix-f176bd9eba22
prerequisite-change-id: 20241201-const_dfc_done-aaec71e3bbea:v5
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
prerequisite-patch-id: 5b58c0292ea5a5e37b08e2c8287d94df958128db
prerequisite-patch-id: 52ffb42b5aae69cae708332e0ddc7016139999f1

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


