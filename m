Return-Path: <cgroups+bounces-6046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D5A01888
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 09:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3561883CAA
	for <lists+cgroups@lfdr.de>; Sun,  5 Jan 2025 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10F13B58F;
	Sun,  5 Jan 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="krJ/Er0a"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847279C4
	for <cgroups@vger.kernel.org>; Sun,  5 Jan 2025 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066090; cv=none; b=l/uEt6VEUSviBPkTI9h3JeUVY7CQL8AGTqmq19Cc2QMXm2F38SjMG88sN3UaKCydQjYJk9NmdTBEULt4UvmQYv0olhTrr06wKdOJNzKL8w/8VDUffZnEaJtJZsxzfU4pQ/cj0nTjGzJzyM+sq/DG8JuDpNCoTHD9uZqHfI1IIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066090; c=relaxed/simple;
	bh=DkgMovNbJ4a5tpyYOqHC6gsDgeClMXlb7XTcpIa+o+4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KY/odflgbe01B+y46xymM8w66G7is2v+K1lI1jdirfqGKWmA9lG1aHouyoPLXR3qzzjocPuPgKVzT4bhmj6zS/ySMXLoLdsL2+GAJ7oEzIZxJ9++sltO146XdKpALGU6ozffE0aUHGwnLKW4wbS5vzyDc+0XvUSUseCXV3qP5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=krJ/Er0a; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736066088;
	bh=iLev11glECapIGWYouhDBrl9UTSez4lwtraWMRecsc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=krJ/Er0acCZbjFvRvjD7pXSwwczi0x4ZmEgPOrtrjlsd6TSycAevFZ2e5ybzTXsaJ
	 wIlTVumz4rO86MtvHLC9wj27pDlyDaeDGSCATQYdjbiHtDMpUsEQosjGiRWzUL2608
	 zpoTKLTAbvHcksx0L1ZYvSvBDyCSXTKdfpWYOu9y+fuaOIVm7pFQ6fJZCkxthoNjGB
	 7hffud6yYkfeQNvWNEVqZEDH9mtRC/12/49KwrQHtSBHmN5ostB2jDs6kSQpMc2xdF
	 DRh1TXfLDXrzP1Gonf9hMFmH3mGWXyMWDphti+Ql6S4u2z3RMSMD07o+E0nxVOGDZt
	 xoJF8Ol/ODxaw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 62EE84A037B;
	Sun,  5 Jan 2025 08:34:36 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v6 0/8] driver core: class: Fix bug and code improvements
 for class APIs
Date: Sun, 05 Jan 2025 16:34:01 +0800
Message-Id: <20250105-class_fix-v6-0-3a2f1768d4d4@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPpDemcC/23Q20oDMRAG4FcpuTaSw+TUK99DRJJJ1gbsbt2si
 1L67k5bxJR6E5iZfP/Ff2StzLU0tt0c2VzW2uo00mAfNgx3cXwrvGaamRIKpBTA8T229jrULz5
 IZ1MOJUWlGP0/zIXWl6znF5p3tS3T/H2JXuV5+5tiupRVcsG98NYOIQSI5unjs2Id8RGnPTvnr
 KqzUvVWkXU6y+CziCL/Y/WfVbdWkxVQlEAYRHDy3kJvfW+BrEYQBL02Nt1b01nVt7YasqHEOLi
 Yigd9a0/XIudC21aXa5ssxVY43fd12W6c9Q6tRenpzYCYqbeAdrAgURSXjHMavKaw0w+SmZRx4
 AEAAA==
X-Change-ID: 20241104-class_fix-f176bd9eba22
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, stable@vger.kernel.org, 
 Fan Ni <fan.ni@samsung.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: ZHCW9wfDTYnYPzcVt8S9Ov2UvbT4HqfG
X-Proofpoint-ORIG-GUID: ZHCW9wfDTYnYPzcVt8S9Ov2UvbT4HqfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=776
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501050078
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes regarding various
driver core device iterating APIs

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v6:
- Remove dependencies since they have been merged into driver-core tree
- Link to v5: https://lore.kernel.org/r/20241224-class_fix-v5-0-9eaaf7abe843@quicinc.com

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
base-commit: 7687c66c18c66d4ccd9949c6f641c0e7b5773483
change-id: 20241104-class_fix-f176bd9eba22

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


