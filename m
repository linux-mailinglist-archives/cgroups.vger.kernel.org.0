Return-Path: <cgroups+bounces-8448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1983ACFBDE
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 06:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57E717800F
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 04:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C11E25EF;
	Fri,  6 Jun 2025 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="crxCbg5E"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0511EB193;
	Fri,  6 Jun 2025 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749183071; cv=none; b=jGbpGcPINB5HyLlAw5D+omCJ2dz25vzrW5zhjmHTuJk3Yy0xvX8UUGJUSycG2w2yQHxaMwlC8ThrFznZSpBrkGbOuIJyqA3dYAsDQF66A3JqdQNmQA6yDnT6V4RnOkbU9Sn4NeHD/6L+9k/cSTCD1j4xopBCA8EwfjzG/ghtMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749183071; c=relaxed/simple;
	bh=2kY4Go81E2dF+qeMLrkXW4LbExK3+rImFvjfbx8ZZu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9sgEILRz4caNRgWsexTAjZ5f0WGn7MRVkQGM10bKXFYhQXOdvr7tgGYqkhojdP7ZPg7iieNYl3GMCROTqs9T7WvCzNf/9ut6H+etNhjCjmZy8pupcieeAnRKogJJeXPaFbj7nCNfIuS/FSBCCVSFpQ6L8HpUKBLm7ZzrUsFCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=crxCbg5E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5563hEB1032442;
	Fri, 6 Jun 2025 04:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=GfCIQ+I+Kmm9i+SJMOocANua/+UE
	SN4mldpm6BZBNak=; b=crxCbg5EbwHx3t0/VHaHDarL5zRP9HXUpkha7UyJiS8R
	K6/7/P6oJRQ38RlaA0JpaTeuxMBq59fdiY6P7aAMD+f7/F91bxSiwCc4ttD0fzJc
	YPi0f3jZii0k+Za5He2ayGcF7GFEOjJ/RI3ATD6obwWnqonhicqkflsgFJ7UmNSG
	PXzbIh2SyNw9Qzfz7MnW7Jb2tDR6In/vRQ0RQyTuXmN2CxbQ/zg6kmpSHP94DDO3
	QNaYpZKxbNVIJBp+gy5aBXUZN/7wI/ZX11m7NJFEUF20qtOQqXt7/gY+JmHP70R3
	yDGWxUSz4ZkgWNsPGUKRKciToXc813INSvwzxHYDKw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 473j1y1erc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 04:11:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5563u5u4027426;
	Fri, 6 Jun 2025 04:11:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 473j1y1era-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 04:11:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5562dVCD022569;
	Fri, 6 Jun 2025 04:10:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tqyu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 04:10:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5564AvOk44106146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Jun 2025 04:10:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB5E2004B;
	Fri,  6 Jun 2025 04:10:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E94E520043;
	Fri,  6 Jun 2025 04:10:54 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.214.245])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Jun 2025 04:10:54 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, llong@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v3] Documentation: cgroup: add section explaining controller availability
Date: Fri,  6 Jun 2025 09:40:05 +0530
Message-ID: <20250606041004.12753-2-vishalc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Nezm13D4 c=1 sm=1 tr=0 ts=68426a54 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=iox4zFpeAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=OQokVuce23VSDdhOoqgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: v7V_0o9xOW4lR6tmm3RqM-TN-i4swoEs
X-Proofpoint-ORIG-GUID: kqB2Xcrb2UVBPrqXHLzHazwFswrCVxeK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAzNSBTYWx0ZWRfX/L1pXNtxcCA+ fNvoX4u3Cktx81QZ1l6SQwUGvzuQ6ZisOdLRDdEbfkc9jNLV7WznLJmc9aM4ZwwQfvgeIv5aqfN 0k1CvcwOP3xiAPgyMEHTjdm99GBb2xwponzzE8UHl5pjxFWBLYvAt0JwIeQg1GyTgehfWfrbPjo
 jIjNnnW56ia+gLKzvg1NTbIqPdY4oS8jhuyDm4/4xvUajePK44KvAYzZfh33bVrFNGDpoEnSGd2 f+rk5UHJN0IRstfIVI0/LE1y37j4m4f/wyagnN69WIJ6Gzk0Ed8xhJ+d2mlFZTjh6OwO+NO8TaS +vFWIU5ZLoTZ8IBtNBJFeqK828HpYAQH6/4nrR57zKkwHJGnUL3kmwnSzXqwSbF29MPMpz2+G+H
 ADYRYO0Ilr3l/mB+oCWoLu0i+p4EgkkUE35nn5U2KZIU4IEKy7KavSBRTItKP0nuYiStP6AM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=790 lowpriorityscore=0 priorityscore=1501
 adultscore=1 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060035

Add "Availability" section to Control Group v2 docs. It describes the
meaning of a controller being available in a cgroup, complementing the
existing "Enabling and Disabling" section.

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

Acked-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0cc35a14afbe..31acc64e656f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -435,6 +435,15 @@ both cgroups.
 Controlling Controllers
 -----------------------
 
+Availablity
+~~~~~~~~~~~
+
+A controller is available in a cgroup when it is supported by the kernel (i.e.,
+compiled in, not disabled and not attached to a v1 hierarchy) and listed in the
+"cgroup.controllers" file. Availability means the controller's interface files
+are exposed in the cgroup’s directory, allowing the distribution of the target
+resource to be observed or controlled within that cgroup.
+
 Enabling and Disabling
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.49.0


