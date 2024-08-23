Return-Path: <cgroups+bounces-4417-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DD95CA09
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 12:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AC9B25AD4
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123218732C;
	Fri, 23 Aug 2024 10:09:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369016A938;
	Fri, 23 Aug 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407740; cv=none; b=u8hm+anJ0vZByKQodNwCfh1gKxbyZQ/orfi2kC+Xbfd87BmnPV4up+7OJ+SGihQksDIcEH6/9XlqoRovekaA5Ac0mZYSzOTAvlVyWWopiqAPcA9tIHd9bxrq/NphZQ2v0ny7lMk+pYq/acrlOEyEkuwDPL3XuMSjOKu7x2O8IiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407740; c=relaxed/simple;
	bh=dcIZ9N3Q4RDbipIsgRCDwaZnSqntAVxJ29yUtwRsgaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7cwWHd8O0iHQfzEHS7t6HkORoAMyUf2344U+43zMPS0XIxSeNDA+8LaIkdv63sX2Tk6zAKPy9alnwBiJugr3KwPZBYPhtI4WQSgazf+dkiD1/aLm0PNfN15PJ7KNowQjGq4Tcp6TE79FXDh08s16rzWlPPSVZx2WBNgn2T5nfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wqwdj6G9tzQqQ5;
	Fri, 23 Aug 2024 18:04:09 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 2128F1401F1;
	Fri, 23 Aug 2024 18:08:54 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 18:08:53 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>, <chenridong@huawei.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 -next 00/11] cgroup:cpuset:separate legacy cgroup v1 code and put under config option
Date: Fri, 23 Aug 2024 10:00:59 +0000
Message-ID: <20240823100110.472120-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

This patchset is based on -next commit c79c85875f1a ("Add linux-next
specific files for 20240823") and assumes that "Some optimizations about
cpuset" series are merged, which are applied to cgroup/for-6.12.


Chen Ridong (11):
  cgroup/cpuset: introduce cpuset-v1.c
  cgroup/cpuset: move common code to cpuset-internal.h
  cgroup/cpuset: move memory_pressure to cpuset-v1.c
  cgroup/cpuset: move relax_domain_level to cpuset-v1.c
  cgroup/cpuset: move memory_spread to cpuset-v1.c
  cgroup/cpuset: add callback_lock helper
  cgroup/cpuset: move legacy hotplug update to cpuset-v1.c
  cgroup/cpuset: move validate_change_legacy to cpuset-v1.c
  cgroup/cpuset: move v1 interfaces to cpuset-v1.c
  cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
  cgroup/cpuset: add sefltest for cpuset v1

 MAINTAINERS                                   |   3 +
 include/linux/cpuset.h                        |   8 +-
 init/Kconfig                                  |  13 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/cpuset-internal.h               | 307 +++++++
 kernel/cgroup/cpuset-v1.c                     | 565 ++++++++++++
 kernel/cgroup/cpuset.c                        | 850 +-----------------
 .../selftests/cgroup/test_cpuset_v1_base.sh   |  77 ++
 8 files changed, 987 insertions(+), 837 deletions(-)
 create mode 100644 kernel/cgroup/cpuset-internal.h
 create mode 100644 kernel/cgroup/cpuset-v1.c
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_base.sh

-- 
2.34.1


