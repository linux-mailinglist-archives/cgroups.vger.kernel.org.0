Return-Path: <cgroups+bounces-4876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92497811C
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 15:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7991C2106E
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76EC1DC06D;
	Fri, 13 Sep 2024 13:25:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA61DC04E;
	Fri, 13 Sep 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233942; cv=none; b=mJTk1Re3ywduo6Lj0H0rcKnSzIE9QgSNyZIW2xsT7YLg2HCJNEq5wLdsOaamQGYvlbu4kXC/vg4qD2TxSv6X1/hHASi5B7uPLeKj6Q1pkbhdBJEHD06tRVGsxHTa/CKO5GaCE/+PJFJGqmhigNiYy6l8SM3r8ivymGLC07ZbWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233942; c=relaxed/simple;
	bh=ZVgNSlAKMOZIzRkPlFjag8EcjBn5Y6/V4SSAK7AwDf4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3MaO8jGotb8qA4jKX6dB1WtHhNDn1HMryqsao+xk5jP0Yy0uM2ZJ5HYaQUvmiWM0FSM7r5aTMRv4w3ITCvUun7thQNF7QF8WFP+ANcD5iIllvMVOdv3K7mBiwyvO1B0z3L7rPAFemAAsAJv57vp1hDzNujED/THbniUSc6G+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X4w52593Nz13Kmt;
	Fri, 13 Sep 2024 21:24:22 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 163711800A7;
	Fri, 13 Sep 2024 21:25:32 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 13 Sep
 2024 21:25:31 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3]  Fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Fri, 13 Sep 2024 13:17:17 +0000
Message-ID: <20240913131720.1762188-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)

The patch 1 have been reviewed by Michal Koutný.
Add two patches as follow.

v4:
- add a patch to document that saturating the system_wq is not permitted.
- add a patch to adjust WQ_MAX_ACTIVE from 512 to 2048.

v3:
- optimize commit msg.

Link v1: https://lore.kernel.org/cgroups/20240607110313.2230669-1-chenridong@huawei.com/
Link v2: https://lore.kernel.org/cgroups/20240719025232.2143638-1-chenridong@huawei.com/
Link v3: https://lore.kernel.org/cgroups/20240817093334.6062-1-chenridong@huawei.com/


Chen Ridong (3):
  cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
  workqueue: doc: Add a note saturating the system_wq is not permitted
  workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048

 Documentation/core-api/workqueue.rst | 8 ++++++--
 include/linux/workqueue.h            | 2 +-
 kernel/bpf/cgroup.c                  | 2 +-
 kernel/cgroup/cgroup-internal.h      | 1 +
 kernel/cgroup/cgroup.c               | 2 +-
 5 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.34.1


