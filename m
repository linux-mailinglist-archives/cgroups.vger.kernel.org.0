Return-Path: <cgroups+bounces-1914-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DA886CB59
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9424EB24096
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544912FB29;
	Thu, 29 Feb 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Fi5WSARf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7C1361DA;
	Thu, 29 Feb 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216527; cv=none; b=QrQiom8VRECDl+MopTOY/cYghR+JItgqKmBZGqRhfj72iA2R9zNXKU0t7HLWIlUd0o1FHRIjW/rRNa7K7iDoodzIsjidEyBAtcI8bSvNznRa9yw2dRYaot7PXnNy0oZmxDIiZWZ/rfOJOlkgKvERrD5srhGgTy5rpzPZxcNMqXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216527; c=relaxed/simple;
	bh=eQfYYlfZztNSVMw3hVLw7QVKBwlURfYEIOXk8wyb4LU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XOg4FrI5EJqcxle8wp2k4BCPs9ek9o5QgJVLrDTau7F4Rp5B1R2r/+/ZfLdAN2ZdZsjWckxdJqcOkUzlcxAzELcc1DsZ+7SrYaX728vIAO2Oz/shrCkORvaLW2gO6SY0/diLxEt5f0rKeg6FljVmYe/9jShYqvjpYnY7DyiloRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Fi5WSARf; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T5ATuw022823;
	Thu, 29 Feb 2024 14:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=CdQQt
	2w/RCAyMiw/AwHTodQgR7TVrvlZkYmoTV0OJxo=; b=Fi5WSARfmrEbKY5bua/bF
	ZqA9bE5Vr8rHOfM/AGxC9Vfyo367Eg6jG2/d1mQaqOtTXxkGBwg/GNraE4Jg76dC
	aeIGOHTAkVS0E1TzZOYNWGG+VMkkmkZw9bJN5+Rt/ArL4F9DDTTwYZTgjzhzBsh5
	cZCi6TYxrZKFDCzISGfQ+h0xBcfVaYB3N7f6/yJI/USQHz35//KN6kVP58uD/Ku0
	o1Hctu5nRO+5Qq8Pu6fXUQ1jur2B0KrXFxP3eSDJSZITpmr8RaORHrPmjXg28KQF
	EZ0dCFmrK6Lx7Q4ManmwkAnHv3zlT4bjWPubdXkjMoUVTC/z2ElquocotETJgdZS
	w==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf7e6dgd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Feb 2024 14:20:24 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 06:20:23 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 06:20:19 -0800
From: Xiongwei Song <xiongwei.song@windriver.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>
CC: <vbabka@suse.cz>, <yosryahmed@google.com>, <rostedt@goodmis.org>,
        <cl@linux.com>, <chengming.zhou@linux.dev>, <zhengyejian1@huawei.com>,
        <cgroups@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] cgroup/cpuset: Remove cpuset_do_slab_mem_spread()
Date: Thu, 29 Feb 2024 22:20:06 +0800
Message-ID: <20240229142007.1278610-1-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Y7ftEdNsVCXNHQJqyuun61KEZUNp0dbS
X-Proofpoint-ORIG-GUID: Y7ftEdNsVCXNHQJqyuun61KEZUNp0dbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=990 clxscore=1011
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402290110

The SLAB allocator has been removed sine 6.8-rc1 [1], so there is no user
with SLAB_MEM_SPREAD and cpuset_do_slab_mem_spread(). Then SLAB_MEM_SPREAD
is marked as unused by [2]. Here we can remove
cpuset_do_slab_mem_spread(). For more details, please check [3].

[1] https://lore.kernel.org/linux-mm/20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz/
[2] https://lore.kernel.org/linux-kernel/20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz/T/
[3] https://lore.kernel.org/lkml/32bc1403-49da-445a-8c00-9686a3b0d6a3@redhat.com/T/#mf14b838c5e0e77f4756d436bac3d8c0447ea4350

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
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


