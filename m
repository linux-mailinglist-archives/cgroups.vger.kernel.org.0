Return-Path: <cgroups+bounces-1917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369386CB8D
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 15:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BE51F275D4
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1651350D5;
	Thu, 29 Feb 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="N9HAaphI"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35D12E1E3;
	Thu, 29 Feb 2024 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216886; cv=none; b=oBtoMCvBKHhbpBFwhFL9QYGUjQlt9A/kF2fYIMQN4wb9YqObpTaJ/S95WC1wfkvTYHZnXRrRMBAtcJjS3qlCwZxG9DEZZlZpLejv2eUrVxhhA7XNEwrMRnaDgdYuscaQAdcETKgeEsrG3X2kBg7BT66z3wI5brTEpSJd9LSKmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216886; c=relaxed/simple;
	bh=vm4mI3Ab2f0hG/F0B4xC/ZVfRUMGp+3lJL31+wzT6Sk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ByQzhHDEm9faOlI8mQO+i7o0ki61WBFtPZDqZaneMISR6rakJuAPI0S9DsGCUhAbbeXHM4XaENBQhham13M9Gepc/lqxG+QYzpZEtxQj8nZNNmhJUzWP/+YdfUkxJ3ES6gkPpsgpqDcfNeIf2J25O2exgrliZejdXSsjyTZFgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=N9HAaphI; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T7d3Kq031219;
	Thu, 29 Feb 2024 14:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=iMT0T
	/W+zs5+Tu56Ymjfxu47bpyn0rsYQx9F9q5csnI=; b=N9HAaphIp7F7LWnC0Ke9X
	pkdIERiLbfl3O89+8amdpk0bEQ1Gn57ObzEQ56jIcfsfWaXU6bXj5iDUv4G5idKZ
	BGWY1VQvppNQXt8qGD9qLSfcxIozuM1uB9kVTJ0hAwzxixG9JQUX7mZA4J9662mh
	O5CLDKtZNj4san65b2/s2ZINkAaTEJFXH2aUzgzxKSSE82wxhahC6nGy5IRZfo1V
	50NZGMmIWK89ZFEbbZrEe6fbUdWdr9/qdDsVIMtdGwY/V09coXTQTyqeB0zrExMK
	/REeVyD4EskUW8IVWDbIBSJuS864DgY9pcyZszbhXg/6NCrvhFaB9TEO0ak4HgyD
	A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf5nx5jtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Feb 2024 14:26:57 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 06:26:56 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 06:26:52 -0800
From: Xiongwei Song <xiongwei.song@windriver.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>
CC: <vbabka@suse.cz>, <yosryahmed@google.com>, <rostedt@goodmis.org>,
        <cl@linux.com>, <chengming.zhou@linux.dev>, <zhengyejian1@huawei.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 1/2] cgroup/cpuset: Remove cpuset_do_slab_mem_spread()
Date: Thu, 29 Feb 2024 22:26:44 +0800
Message-ID: <20240229142645.1327831-1-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RTU9lNN_H_WsqePD3YmqpxzzdWiWbidU
X-Proofpoint-ORIG-GUID: RTU9lNN_H_WsqePD3YmqpxzzdWiWbidU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290111

The SLAB allocator has been removed sine 6.8-rc1 [1], so there is no user
with SLAB_MEM_SPREAD and cpuset_do_slab_mem_spread(). Then SLAB_MEM_SPREAD
is marked as unused by [2]. Here we can remove
cpuset_do_slab_mem_spread(). For more details, please check [3].

[1] https://lore.kernel.org/linux-mm/20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz/
[2] https://lore.kernel.org/linux-kernel/20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz/T/
[3] https://lore.kernel.org/lkml/32bc1403-49da-445a-8c00-9686a3b0d6a3@redhat.com/T/#mf14b838c5e0e77f4756d436bac3d8c0447ea4350

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
Sorry, I made a mistake with linux-mm list. Correct linux-mmc to
linux-mm.
---
---
 include/linux/cpuset.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 875d12598bd2..0ce6ff0d9c9a 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -121,11 +121,6 @@ static inline int cpuset_do_page_mem_spread(void)
 	return task_spread_page(current);
 }
 
-static inline int cpuset_do_slab_mem_spread(void)
-{
-	return task_spread_slab(current);
-}
-
 extern bool current_cpuset_is_being_rebound(void);
 
 extern void rebuild_sched_domains(void);
@@ -264,11 +259,6 @@ static inline int cpuset_do_page_mem_spread(void)
 	return 0;
 }
 
-static inline int cpuset_do_slab_mem_spread(void)
-{
-	return 0;
-}
-
 static inline bool current_cpuset_is_being_rebound(void)
 {
 	return false;
-- 
2.43.0


