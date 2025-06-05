Return-Path: <cgroups+bounces-8441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3199ACF260
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E483AA323
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5B319D880;
	Thu,  5 Jun 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fYHELiew"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFFD192598;
	Thu,  5 Jun 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135290; cv=none; b=ptXasCCZ9AOZ1g5gkAZiQh/JXxB9htmkuH3PG8O9IQJqTeUXUxy5QHvHtf4rL63os78j2Ws/iyCI4x8loTrwCfjkBc8sRBJiSSOAeRZK+Bc+atE3wykAwLGAJlX67aXGn8MNuI/S3R2yiL0mE1WHoIxkJ0vBaCBiCpmN4aMLx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135290; c=relaxed/simple;
	bh=27vwC2fhr8WK1QaEPy8n9LBaT5Rr62UqFih79a0rzVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OE3coAyAwptyQV4MIzVz2n/BvJOPahQ4A8PA7xjHmtRpFFFjby5687SpS1ktc3llBpBZpRZM/9hqI3jjbHHCUFZKSuCoUV14OQYvycXAYrncQk6dYTnLnyLtNXjYFh4y+tl1+JLh55aruf1Q4AvCk3qWb8qDVlQ3OeKLylw3bX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fYHELiew; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5559uYEp030432;
	Thu, 5 Jun 2025 14:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ShU0X8d9LxyRlNTkxBmjSYrE4mHV
	A5cfcz17bfC2HRs=; b=fYHELiewROi2xnT4qP6aR76DhwsuhULpOVZYVQ8agYPz
	W7DIAfF0pULhq4/U51V3I6drquNyB49QMl1VglGHGUZSAcDIX2ql3/5rQ3hi433T
	rg+uCrDTmYvqYdHYQ5dNzULR2GtfYajMmvAXibRa9PzqBuevU9JOtHPYcvzhs4To
	reSGv1AnJmosTrNnO/Ad+UV+vVRtiTMOBmi7QmaOVZ/SM3+CbHRUWOx1DsJtLCjT
	LdBd1c07lJ+IPTVM3f7+SQMJD2LGjGluHSgRWtffiYR7L/GopJLuVzWdkVSdNzOz
	B0L9c6br543hD04ZWqN+kCxZ49YvJU+hqo+G4GbP3Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf01cqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:54:42 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 555Eb36B007263;
	Thu, 5 Jun 2025 14:54:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf01cqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:54:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 555DcmIX022518;
	Thu, 5 Jun 2025 14:54:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tnc0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:54:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 555EsdAT33554756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Jun 2025 14:54:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE4212004E;
	Thu,  5 Jun 2025 14:54:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 651F82004B;
	Thu,  5 Jun 2025 14:54:36 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.213.71])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Jun 2025 14:54:36 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llong@redhat.com, bagasdotme@gmail.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v2] Documentation: cgroup: add section explaining controller availability
Date: Thu,  5 Jun 2025 20:24:22 +0530
Message-ID: <20250605145421.193189-2-vishalc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Yi6NcXQyYjMNak1u6hdZOLsjVmA6Z901
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=6841afb2 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=HQQEU_knwVeOKeFEU2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: X_SXSZkJ1HdvVjGvtjJZJgcbfDP_9iwK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEyNSBTYWx0ZWRfXzoZD5xCoQOA4 Ncz/Ccx3HqT+32RuiCteWdYQT5bKmaAJSa0BentYsOgjBiHCLVKyYdzcDT8LBK0so84IDa6/SUW P8/QAa1kPXiwrkDLmXeFya9IUolcTzeevDiQfdVCnaBALl3DUjo8mK7kW0ltt2fBOf2zb2vB0fH
 R2MIAyh6xozYWLIUKazyh02XsbjjGi0zUgemiWdp4Xra+iG8dnkO+gIiYlrzBaHsuF/xMSvXZAT 4NBks1lstFWgwPGLbfC7r0I+GkQ3BqOP0paXf5vKf8miiCv6jM9nz2ZwTvzHMcN+ysAXsdwG+Jz anta5sEYlRQxoW3wFoeGF8x3CQOXdcYBR0pLokFt769EANAhmIFGoltUijP8fDKrVnvvhQkwXHq
 y6Q9eEnoqXD6iG+9feRFrc674ELVog7ofjDwY7a8gIT9s6Cz81eu/0kMC6Wk74u5iGK0BtNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=866 adultscore=1
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050125

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


