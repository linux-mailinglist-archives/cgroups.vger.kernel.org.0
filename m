Return-Path: <cgroups+bounces-1918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DE886CB91
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27114B26048
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F16F52A;
	Thu, 29 Feb 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="OODUZKCM"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E891361A3;
	Thu, 29 Feb 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216909; cv=none; b=Deew84Qx+Y5ibVtsFtcEwtCJAMBuAcEDsidOfw+sriu/s1dmEwCN/lfkpBJbST9TJUufP0Bs5W7pLhBqT+LSTe+ac8TyIHQDxOmmdNg71sIlV1taXNq8E17Hakq1oN0kBwfq2OILxL9iKtfdurBLMcUpLNSWRKxQSJebP4uzYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216909; c=relaxed/simple;
	bh=9YWutWMJCk2yCa98EXaPk9YGmVxLRbg5YMdOMMyVZfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLLrT4f5Bbd1HLidoly2cotkLBYUgmkCvwOZmFaBuaULS6h+sikM3mqeYlSS8zq+8ABjJ7XSNwd6+cJv+cQkHrazmdlkwx8akX3e3yUePB0owtZR0EMbBblX3Ey5yAqwzVT/ZlFoeC8uyb2ngGAftwIL9EWeO9XYikDAWKRQleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=OODUZKCM; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TCgk48007305;
	Thu, 29 Feb 2024 06:27:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=ZccVJUwzuY4xwuefFguz80ZL05Yed79XfC8Oc40ToN0=; b=
	OODUZKCM8TkfcOP1tQAzoJY4FKkc5au4A18zoNkAN1v/s8CMewtwZ6/924wPIriP
	xliLAexkyhtoAve/tg/u89jbWMNG0ob7y6utbo2XMh7YPb2kCwDu2Jf2jcoihLNt
	2Syl7R9MIjPQCA5zoI1AYxMe1daRHOp5beVw2XJs80BUi+KfcF4eDaG3G/cQFCOZ
	smAG+WoTjclGO6Ja+45lTu19eg5xSkQhB4+IZHuaURI12qF5cTPkrgf1RvoOoBxd
	9GB0lI7HAb0PrgUNTZ8fqfn+t1MIqZSKGxYCMX39jr2zEt6swrMwRhVO4/5PeX3P
	UBWsx7P78wGv7Gx/wdhzvw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wfgumn63g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Feb 2024 06:27:00 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 06:27:00 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 06:26:56 -0800
From: Xiongwei Song <xiongwei.song@windriver.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>
CC: <vbabka@suse.cz>, <yosryahmed@google.com>, <rostedt@goodmis.org>,
        <cl@linux.com>, <chengming.zhou@linux.dev>, <zhengyejian1@huawei.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 2/2] cgroup/cpuset: Mark memory_spread_slab as obsolete
Date: Thu, 29 Feb 2024 22:26:45 +0800
Message-ID: <20240229142645.1327831-2-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229142645.1327831-1-xiongwei.song@windriver.com>
References: <20240229142645.1327831-1-xiongwei.song@windriver.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: musNlEUIeLC4UiknxofRDHvGthDzMcmt
X-Proofpoint-GUID: musNlEUIeLC4UiknxofRDHvGthDzMcmt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=985 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402290111

We've removed the SLAG allocator, cpuset_do_slab_mem_spread() and
SLAB_MEM_SPREAD, memory_spread_slab is a no-op now. We can mark
memory_spread_slab as obsolete in case someone still wants to use it
after cpuset_do_slab_mem_spread() removed. For more details, please
check [1].

[1] https://lore.kernel.org/lkml/32bc1403-49da-445a-8c00-9686a3b0d6a3@redhat.com/T/#m8e292e21b00f95a4bb8086371fa7387fa4ea8f60

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
Sorry, I made a mistake with linux-mm list. Correct linux-mmc to
linux-mm.
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 2 +-
 kernel/cgroup/cpuset.c                          | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index ae646d621a8a..88d0e7fa2ee0 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -179,7 +179,7 @@ files describing that cpuset:
  - cpuset.mem_hardwall flag:  is memory allocation hardwalled
  - cpuset.memory_pressure: measure of how much paging pressure in cpuset
  - cpuset.memory_spread_page flag: if set, spread page cache evenly on allowed nodes
- - cpuset.memory_spread_slab flag: if set, spread slab cache evenly on allowed nodes
+ - cpuset.memory_spread_slab flag: IT'S OBSOLETE. Please don't use it anymore
  - cpuset.sched_load_balance flag: if set, load balance within CPUs on that cpuset
  - cpuset.sched_relax_domain_level: the searching range when migrating tasks
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ba36c073304a..728d06fe9382 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3897,6 +3897,9 @@ static struct cftype legacy_files[] = {
 	},
 
 	{
+		/* It's obsolete. Please don't use it anymore. We will remove it
+		 * in the future.
+		 */
 		.name = "memory_spread_slab",
 		.read_u64 = cpuset_read_u64,
 		.write_u64 = cpuset_write_u64,
-- 
2.43.0


