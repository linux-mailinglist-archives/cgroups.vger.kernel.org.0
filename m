Return-Path: <cgroups+bounces-4338-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7DE9556D2
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE6B21D09
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA5A148832;
	Sat, 17 Aug 2024 09:41:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F213D2BB;
	Sat, 17 Aug 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887673; cv=none; b=c8okSmf3reKk1IuidczNit7iQWINg771kl4CpNURPbFLcmuauCXMV/RIeOnFU+jsp0xWlfYxx4OuvQ5n+kFh4M009Fn7+CzSiumuVXmqLw3VqTm1AJjdcijbwHeVfiOM7ICk3KBeFL9CspUWa/fVryR+gmZtECSlX9pyIblMgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887673; c=relaxed/simple;
	bh=1vQbqMNoPbzJ0O04XY4mSjMDHVjleybqK3jR1qZXpr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n2ne3wr+jjWSURiQj/nUXf1HDTjbMCMOEXt9Sp3Hgoe38lRa6vrGDd2MufZUzAmdW4ZBPAAX5f/jvg0DPTpJteE253UeLVkvmsASO4WI9tHV0kcpG6AALyqFHVbqzvGC6BQWJd0Teer9A/UX0/kDGKeJa4Qo/fGYrZBh/GrRAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WmDJc2kJJz20lPD;
	Sat, 17 Aug 2024 17:36:32 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 91F51140154;
	Sat, 17 Aug 2024 17:41:09 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 17 Aug
 2024 17:41:08 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/1] Fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Sat, 17 Aug 2024 09:33:33 +0000
Message-ID: <20240817093334.6062-1-chenridong@huawei.com>
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

changes from v1/v2:
- Optimize commit msg.

Link v1: https://lore.kernel.org/cgroups/20240607110313.2230669-1-chenridong@huawei.com/
Link v2: https://lore.kernel.org/cgroups/20240719025232.2143638-1-chenridong@huawei.com/

Chen Ridong (1):
  cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock

 kernel/bpf/cgroup.c             | 2 +-
 kernel/cgroup/cgroup-internal.h | 1 +
 kernel/cgroup/cgroup.c          | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1


