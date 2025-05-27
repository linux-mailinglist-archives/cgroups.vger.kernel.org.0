Return-Path: <cgroups+bounces-8350-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D531FAC4B0D
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBA53B9747
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261E24DCE7;
	Tue, 27 May 2025 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DiReI8th"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C5225D7;
	Tue, 27 May 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336762; cv=none; b=mS/IO8CRzDdRCrzMfoVxt4IB1CSOb5Jkzz+1NJR0fCStJZmTz3CEkTXYgmI1TylF8jATwqkqOIrqHMMEQkLHMyuSIaEqxFCeedmpdvHK1P3J+8AldmfAr0ivLEieGpiVwC0vTTzjdxaT1LlQ03j2TddwJxoKXOoa0vc7R+m5TIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336762; c=relaxed/simple;
	bh=FAJqpmb+BoZ0AVDf80FVLHbg+9NVumyxtrdo2DmNzdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afal+2+7j85o+8lw1JgKPWPEM52+e2b1CDibL8byMabrWdl/ziKXc2sAy7cxjcOPgmJ/RKJWET91zy0KUY+Gh0VO/WW9pZjClbcHusiotTyE7ZWcCFLx0LG/dJXfPXSA+2p2WufOVEGNPKDvHH5PSPxKSkTXdzROIkIzNXgMZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DiReI8th; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNbpQa007658;
	Tue, 27 May 2025 09:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kKsxNrrRq+ObuNzyEdrrMJwLMVpQZb+We6ceTAbpB
	RE=; b=DiReI8thcZFJ8udBC/aooI/f6lbe+NnXRIj4YEXe2IXbOnINbWclU3jHr
	Yvood8t4HjVD84IJf5PulW19NDW5uMCESziz5M184yKgY+od9hoU951MDFtnxI4/
	baSThkMZPDdtdflNhH3OA9xKQHh6GttkicpQmYWJfSfMQmgrkAmBbI8yqJVhkEVn
	RvSDVVvK73mSf/qozxpHM17Ha89Khga7eWCLFheob/5acW50eARwahZqZP5AIMHs
	ws+//BwP8VpYpV304R64C7Yxf3lWzlG8v68aCKoLLgzUYudIg6FawHdPDK2nzKa5
	BHaG0fp8Fc8Bw9xu1ZTewa1YVYZoA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u5ucn9w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 09:05:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R7DHYr016700;
	Tue, 27 May 2025 09:05:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46ureua4tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 09:05:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54R95rci28508770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 09:05:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E139420043;
	Tue, 27 May 2025 09:05:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FEAF20040;
	Tue, 27 May 2025 09:05:51 +0000 (GMT)
Received: from vishalc-ibm.in.ibm.com (unknown [9.109.245.223])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 09:05:51 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] Documentation: cgroup: clarify controller enabling semantics
Date: Tue, 27 May 2025 14:23:36 +0530
Message-ID: <20250527085335.256045-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XAUiHN1XPtjLl4fF0KJuMAJtifm6UvN7
X-Proofpoint-GUID: XAUiHN1XPtjLl4fF0KJuMAJtifm6UvN7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA3MyBTYWx0ZWRfX8Ss8AJaVoXnE wAssbYWwVmyXrn9j0/D9t5hquiuwJlDqlJkA65m2DxfH6S92hh809trgSjlIFbcfhCmgTQZu9gU 3rZ/+icwA3/Nd++GcUtGCSOisnuUYXxmoXw0JV8Uy5FNdrlIerj5GcIHPZr984brDbxaZmZ4/ZN
 2yqWas1jzMfXvPdtrBiCOmindH2DZzDb/74/UZFU3Nh9XcaB2ELb5JmCoJx3nWom+6qpkYVPp9x QZ3Z6nmKOXy/nrNhOPnlq8HMdCh3B/xH04lFipioVNTOu91vrn81z5i25/q92A7/9u7rPtFCxf3 5e+DkWsTPq/fSd57ByBzq3NwQZMZ8jyvCgdvCht8pirIwq9pKz84MpYEaBHtTbZYbhIP2aYidwQ
 0CICP9T2UquAXETtcIm284Pzwy34RFusA4xcnhUEXK1ccL/6yf2YuE2yyk31gjJcQ00eXje4
X-Authority-Analysis: v=2.4 cv=fJM53Yae c=1 sm=1 tr=0 ts=68358073 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=a_b_lNqkOoIFiPTXujYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_04,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=847 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270073

The documentation for cgroup controller management has been updated to
be more consistent regarding following concepts:

What does it mean to have controllers
1) available in a cgroup, vs.
2) enabled in a cgroup

Which has been clearly defined below in the documentation.

"Enabling a controller in a cgroup indicates that the distribution of
the target resource across its immediate children will be controlled.
Consider the following sub-hierarchy"

As an example, consider

/sys/fs/cgroup # cat cgroup.controllers
cpuset cpu io memory hugetlb pids misc
/sys/fs/cgroup # cat cgroup.subtree_control # No controllers by default
/sys/fs/cgroup # echo +cpu +memory > cgroup.subtree_control
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

Once a controller is available in a cgroup it can be used to resource
control processes of the cgroup.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1a16ce68a4d7..0e1686511c45 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -438,8 +438,8 @@ Controlling Controllers
 Enabling and Disabling
 ~~~~~~~~~~~~~~~~~~~~~~
 
-Each cgroup has a "cgroup.controllers" file which lists all
-controllers available for the cgroup to enable::
+Each cgroup has a cgroup.controllers file, which lists all the controllers
+available for that cgroup and which can be enabled for its children.
 
   # cat cgroup.controllers
   cpu io memory
-- 
2.49.0


