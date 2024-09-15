Return-Path: <cgroups+bounces-4882-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E69794FD
	for <lists+cgroups@lfdr.de>; Sun, 15 Sep 2024 09:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4569B284693
	for <lists+cgroups@lfdr.de>; Sun, 15 Sep 2024 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E4A1CFB6;
	Sun, 15 Sep 2024 07:21:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CB18D
	for <cgroups@vger.kernel.org>; Sun, 15 Sep 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726384883; cv=none; b=PanuSjSqR6UJ2esORsac2sRSlVDhgFdxMFdWgUnObx/Wf0AhmAhgxOFsE71XoGKZl9CoM8stXy4JdNk60Nw1Vnqh44EZm+RI5wRFHcFfH1qfeb+gHIogWMtmPDgTO4eccQ1zzD08BQbjezBxbdfgoFwZm2JiRmw9delok/j0NOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726384883; c=relaxed/simple;
	bh=8zzJlNwq2IIdbZ2uBXtBwqGIll9+qtSCsNi82xbQYko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y4cXYagS7Lnm0G4hXNA+nSl+jcPBlGcd1mWEQISi+ZQz8CpKxwDFnNANmt7tpSBWsKysqC6YIlmrW5CNYG4RLrf/YMrz+STXtlyFVCzcqHwGr1dpOAU6fYuU9P3Fxr+ZRr9yhQIAtxff1dd8eSqJet9hNuS+DX/1wIr27EVJ5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X5zwD26FKzyRmk;
	Sun, 15 Sep 2024 15:20:28 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EFF318006C;
	Sun, 15 Sep 2024 15:21:18 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sun, 15 Sep
 2024 15:21:17 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>, <guro@fb.com>
CC: <cgroups@vger.kernel.org>
Subject: [PATHC v3 -next 0/3] Some optimizations about freezer
Date: Sun, 15 Sep 2024 07:13:04 +0000
Message-ID: <20240915071307.1976026-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

I optimized the freezer to reduce redundant loops, and I add helper
to make code concise.

The following subtree was tested to prove whether my optimizations are
effective.
   0
 / | \ \
A  B C  1
      / | \ \
     A  B C  2
        .....
	         n
               / | \
              A  B C

I tested by following steps:
1. freeze 0
2. unfreeze 0
3. freeze 0
4. freeze 1

And I measured the elapsed time(ns).

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

As shown above, after optimizations, it can save elapsed time.
By freezing 0 and subsequently freezing 1, the elapsed time is consistent,
indicating that my optimizations are highly effective.

---
v3:
- fix build warnings reported-by kernel test robot.

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


