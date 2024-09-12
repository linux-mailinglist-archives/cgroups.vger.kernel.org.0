Return-Path: <cgroups+bounces-4854-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC14975E81
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 03:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCFA1C22657
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 01:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCCF2C1BA;
	Thu, 12 Sep 2024 01:28:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC62B9A5
	for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104528; cv=none; b=gNEd8wZuVM3pZ/j5lP5YXeAlM3B5rZwGfvFyEWczsM3MMhSJy0E3OTPqFLovH9v2P5vOBwqnZyQ1XLWEtCc0siRLblq1Kz/Aa6wUs18BKA+Wld8AkufnNwHNvqWZap1sj8Lwv6ZPu9N1Fn8iFR68RkDjOwBArtGSWaZ73jgCoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104528; c=relaxed/simple;
	bh=Qig5rm0Ksk2JjuQr5hTtLwhbCI3pWi54JOPgr7+uOM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SpXVCt9pPQJkaJXmli6DLUbD1XsvEvtfZ396D7Cbrmoofx9LfOG/LfiDhdxmlCiWyRFv8dTjvDxcofYcJaLKUVVyEGm+GG4RrY+SNAuBVeEsfKI17lvR31bwOaVY92kXEWh7tv7MknSJZgM6Pti/wd/iG3xZDVm/hGSawHeReH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X40DS1Fj9z1RBdH;
	Thu, 12 Sep 2024 09:27:36 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F163140132;
	Thu, 12 Sep 2024 09:28:43 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 12 Sep
 2024 09:28:43 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>, <guro@fb.com>
CC: <cgroups@vger.kernel.org>
Subject: [PATCH v2 -next 0/3] Some optimizations about freezer
Date: Thu, 12 Sep 2024 01:20:34 +0000
Message-ID: <20240912012037.1324165-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)

We optimized the freezer to reduce redundant loops, and we add helper
to make code concise.

We tested the following subtree:
   0
 / | \ \
A  B C  1
      / | \ \
     A  B C  2
        .....
	         n
               / | \
              A  B C
We tested is by following steps:
1. freeze 0
2. unfreeze 0
3. freeze 0
4. freeze 1
We measured the elapsed time(ns).

n=10
	freeze 0	unfreeze 0	freeze 0	freeze 1
BEFORE	106179390	94016050	110423650	95063770
AFTER	96473608	91054188	94936398	93198510

n=50
	freeze 0	unfreeze 0	freeze 0	freeze 1
BEFORE	109506660	105643800	105970220	96948940
AFTER	105244651	97357482	97517358	88466266

n=100
	freeze 0	unfreeze 0	freeze 0	freeze 1
BEFORE	127944210	122049330	120988900	101232850
AFTER	117298106	107034146	105696895	91977833

As shown above, after optimizations, we can save elapsed time.
By freezing 0 and subsequently freezing 1, the elapsed time is consistent,
indicating that our optimizations are highly effective.

---
v2:
- open code inside the loop of cgroup_freeze instead of inline function.
- add helper to make code concise.
- remove selftest script(There are hierarchy test in test_freeze.c, I
  think that is enough for this series).

Chen Ridong (3):
  cgroup/freezer: Reduce redundant traversal for cgroup_freeze
  cgroup/freezer: Add cgroup CGRP_FROZEN flag update helper
  cgroup/freezer: Reduce redundant propagation for
    cgroup_propagate_frozen

 include/linux/cgroup-defs.h |   6 +-
 kernel/cgroup/freezer.c     | 110 ++++++++++++++++++------------------
 2 files changed, 59 insertions(+), 57 deletions(-)

-- 
2.34.1


