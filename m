Return-Path: <cgroups+bounces-4489-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B59601A5
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 08:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C901F22D74
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F46149E0E;
	Tue, 27 Aug 2024 06:29:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C70146D68;
	Tue, 27 Aug 2024 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740143; cv=none; b=bellF7eQJ7nWiaEhH4AGWScBUqU9ZzON1m0dEWm6av6FNMuLZgu/ntYNTzghMA3ojCCHS+XPjVtlCo2s/ndTwfO7SWmW7/gWyk/f20FqRSHUJPkXzecU2ObYOhm+QXkpkj880KHCB1X3pEiL4HUNWRUHS+MSGNA0cueZF2RlTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740143; c=relaxed/simple;
	bh=NqJqmcTcq+7y4he0nh5cqPcFccxFcRxwn+lMDOyvFdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JipfSiHKTiDl0EOWtO3SzvGbgNH8lcNzPWG8enCwrMwfxtRxiP3sNuGZqsGM3R9o0hsv8+2chWaF4LGHQWkK/mHp7dCyB0f2izOGib+nXpdlZ6yBGDpEJdIHx9NBAy9KZQqeFz+ydL/YiGA3NGnSSQi2cIw3WXAXGXyMtrBeCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WtHgM13ZTz1S77s;
	Tue, 27 Aug 2024 14:28:47 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8237D1A016C;
	Tue, 27 Aug 2024 14:28:57 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 27 Aug
 2024 14:28:56 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next 00/12] cgroup:cpuset:separate legacy cgroup v1 code and put under config option
Date: Tue, 27 Aug 2024 06:20:59 +0000
Message-ID: <20240827062111.580296-1-chenridong@huawei.com>
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

Cgroups v2 have been around for a while and many users have fully adopted
them, so they never use cgroups v1 features and functionality. Yet they
have to "pay" for the cgroup v1 support anyway:
1) the kernel binary contains an unused cgroup v1 code,
2) some code paths have additional checks which are not needed,
3) some common structures like task_struct and mem_cgroup contain unused
   cgroup v1-specific members.

Cgroup memory controller has already separated legacy code to
memory-v1.c. So it is time to do the same thing for cpuset controller.

This patchset aims to do:
1) moving cgroup v1-specific cpuset code to the new cpuset-v1.c file,
2) putting definitions shared by cpuset.c and cpuset-v1.c into the
   cpuset-internal.h header,
3) introducing the CONFIG_CPUSETS_V1 config option, turned off by default,
4) making cpuset-v1.c to compile only if CONFIG_CPUSETS_V1 is set.

---
V3:
- Delete blank line at the end of file.
- Rename some generic functions name with cpuset_/cpuset1_ prefix.

V2:
- Update to base on the latest cgroup/for-6.12.
- Add CONFIG_CPUSETS_V1 for cpuset_memory_pressure_bump.

Chen Ridong (12):
  cgroup/cpuset: introduce cpuset-v1.c
  cgroup/cpuset: move common code to cpuset-internal.h
  cgroup/cpuset: move memory_pressure to cpuset-v1.c
  cgroup/cpuset: move relax_domain_level to cpuset-v1.c
  cgroup/cpuset: move memory_spread to cpuset-v1.c
  cgroup/cpuset: add callback_lock helper
  cgroup/cpuset: move legacy hotplug update to cpuset-v1.c
  cgroup/cpuset: move validate_change_legacy to cpuset-v1.c
  cgroup/cpuset: move v1 interfaces to cpuset-v1.c
  cgroup/cpuset: rename functions shared between v1 and v2
  cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
  cgroup/cpuset: add sefltest for cpuset v1

 MAINTAINERS                                   |   3 +
 include/linux/cpuset.h                        |   4 +
 init/Kconfig                                  |  13 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/cpuset-internal.h               | 304 ++++++
 kernel/cgroup/cpuset-v1.c                     | 562 +++++++++++
 kernel/cgroup/cpuset.c                        | 908 +-----------------
 .../selftests/cgroup/test_cpuset_v1_base.sh   |  77 ++
 8 files changed, 1013 insertions(+), 859 deletions(-)
 create mode 100644 kernel/cgroup/cpuset-internal.h
 create mode 100644 kernel/cgroup/cpuset-v1.c
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_base.sh

-- 
2.34.1


