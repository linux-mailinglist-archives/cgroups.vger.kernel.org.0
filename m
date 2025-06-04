Return-Path: <cgroups+bounces-8432-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F3ACD788
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 07:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E622167818
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 05:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0AE1C7005;
	Wed,  4 Jun 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O1CXBuoa"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794F2581;
	Wed,  4 Jun 2025 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749015924; cv=none; b=WGoyNlYKao3VkYESw48EmPYOMdXKdR2NKVJiBNJ0yhbx3ca7nyFjXYn5v68zxTz0C+lsa7dxoW73nT8P51Jr1Ep5MJZVWQ6WrDyovkVIza+tctab6rqC2IrBZFLYE4KIVKmIoTCkj5PH7zdsHPNNEAL05JYYGqt4HjoW9GUGU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749015924; c=relaxed/simple;
	bh=CfLtqzHHaY4doOrdi8xjRk+IFtdUdKN3wsI17JcTQDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SwU+2ACDk76tvNFaudEShFbklp2zWe4uzwhXRD/qF6MuxFA+4nBXGfV62QrnF71uVDs/idg2L8ovhNISG357kSkLd20pYfTyHZuqa0g6RwCCKT7jBSXFsCN+HOLEUSSxE+HZdSY0naHym+Ifpf07BLqJDNlwQqciWyYt/6kD4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O1CXBuoa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5543sB3g027925;
	Wed, 4 Jun 2025 05:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=MGwMCcbZnV/E5roc53l8Op6u4fYi
	fdCCWTjLFLVW9rQ=; b=O1CXBuoac4NeV/Tmn3ouXkdo9TRSWPiowI9DhZuAcqAg
	f00dait1ZdF1N0f0xLdV1M3dezehBes2Ac8IDhJdI50zIPJ3Z5fTW5CqCwRDbkPR
	V39djxRMyNzG7gm8ODm9p3yg+cXCtdoEFpmINOVvxXo2oV/pxhW+leCNpVWGPaF2
	1BUkrUIIfVgKp5W5HUeT4+8rVqq4XyGfCvTaTxi2PwcTQrp8iof8KHyr9/83K3WT
	HH6H8iog+ThmQZm+6tJrqff9I/0lD8jfN3pU//xBTVph2IXiIRwHJs1FEUxdiqRc
	kTda9p/TQtve1ZyUmFI7h8evV7DTtZHCYU2hMG7SqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gey8m20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 05:45:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5545jDNX013249;
	Wed, 4 Jun 2025 05:45:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gey8m1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 05:45:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5542i6L1019883;
	Wed, 4 Jun 2025 05:45:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3nx8v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 05:45:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5545jAgq10092986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Jun 2025 05:45:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C55E20043;
	Wed,  4 Jun 2025 05:45:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76D2520040;
	Wed,  4 Jun 2025 05:45:07 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.20.96])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Jun 2025 05:45:07 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, llong@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] Documentation: cgroup: add section explaining controller availability
Date: Wed,  4 Jun 2025 11:13:53 +0530
Message-ID: <20250604054352.76641-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=683fdd69 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=HQQEU_knwVeOKeFEU2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C81rhpJsaUpP4mt53DogBzq6cg6qhRV_
X-Proofpoint-ORIG-GUID: 5O1nNfm1u2pw_IpNjj3ZO2JwPUFHqsGb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA0NSBTYWx0ZWRfX0D3w9cCZFXjF Gpt+l/EdTl85b5F/7EcRhOPrPRByNaxTuwcgn3TJcuI+ZhtbJu98scv2Bw3Ux10+LlLkxafPCD6 //TWGygtHGAlppnm8pBnrNy1Y4/5n/2DzIyE+Fv1vjFlen9a0978yOo7aJDNwzhHwXAY1Y/rAAU
 mW4ahCocSdfzeAzGeUuyV5PF5QTNyBeaeMYYW5k00B4C6Cex5g7nOviR8KoV01iTi5qDwobc15P HIDe56bpM0f8DeMhCWBMxDcYONFWBbtW1pA4GKzN7tu5amcxHR98jgxfiM9WkjbKscWTxiqYCtw 6eGhV8oJqNt9nwOE3y04jF9k8SVSDXztYEJmehsPVNfUb9WESl1yqxXc5IvmsgTmFMB3Gk8LKPi
 4Ai3V3eRkWTOjV1SpshJIQ5tsaw2liJskDQhxiNyziU4RkfuxD5Fr7HcvTBAIFbpJdZlo9xS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=842 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=14 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040045

A new documentation section titled "Availability" has been added to
describe the meaning of a controller being available in a cgroup,
complementing the existing "Enabling and Disabling" section.

This update improves the clarity of cgroup controller management by
explicitly distinguishing between:

1. Availability – when a controller is supported by the kernel and
   listed in "cgroup.controllers", making its interface files accessible
   in the cgroup's directory.
2. Enabling – when a controller is enabled via explicitly writing the
   name of the controller to "cgroup.subtree_control" to control
   distribution of resource across the cgroup's immediate children.

As an example, consider

/sys/fs/cgroup # cat cgroup.controllers
cpuset cpu io memory hugetlb pids misc
/sys/fs/cgroup # cat cgroup.subtree_control # No controllers enabled by default
/sys/fs/cgroup # echo +cpu +memory > cgroup.subtree_control # enabling "cpu" and "memory"
/sys/fs/cgroup # cat cgroup.subtree_control
cpu memory                   # cpu and memory enabled in /sys/fs/cgroup
/sys/fs/cgroup # mkdir foo_cgrp
/sys/fs/cgroup # cd foo_cgrp/
/sys/fs/cgroup/foo_cgrp # cat cgroup.controllers
cpu memory                   # cpu and memory available in 'foo_cgrp'
/sys/fs/cgroup/foo_cgrp # cat cgroup.subtree_control  # empty by default
/sys/fs/cgroup/foo_cgrp # ls
cgroup.controllers      cpu.max.burst           memory.numa_stat
cgroup.events           cpu.pressure            memory.oom.group
cgroup.freeze           cpu.stat                memory.peak
cgroup.kill             cpu.stat.local          memory.pressure
cgroup.max.depth        cpu.weight              memory.reclaim
cgroup.max.descendants  cpu.weight.nice         memory.stat
cgroup.pressure         io.pressure             memory.swap.current
cgroup.procs            memory.current          memory.swap.events
cgroup.stat             memory.events           memory.swap.high
cgroup.subtree_control  memory.events.local     memory.swap.max
cgroup.threads          memory.high             memory.swap.peak
cgroup.type             memory.low              memory.zswap.current
cpu.idle                memory.max              memory.zswap.max
cpu.max                 memory.min              memory.zswap.writeback

In this example, "cpu" and "memory" are enabled in the root cgroup,
making them available in "foo_cgrp". This exposes the corresponding
interface files in "foo_cgrp/", allowing resource control of processes
in that cgroup. However, these controllers are not yet enabled in
"foo_cgrp" itself.

Once a controller is available in a cgroup it can be used to resource
control processes of the cgroup.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0cc35a14afbe..202bf39867ea 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -435,6 +435,15 @@ both cgroups.
 Controlling Controllers
 -----------------------
 
+Availablity
+~~~~~~~~~~~
+
+A controller is available in a cgroup when it is supported by the kernel and
+listed in the "cgroup.controllers" file. Availability means the controller's
+interface files are exposed in the cgroup’s directory, allowing the
+distribution of the target resource to be observed or controlled within
+that cgroup.
+
 Enabling and Disabling
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.49.0


