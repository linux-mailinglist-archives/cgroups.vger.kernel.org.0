Return-Path: <cgroups+bounces-7454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2119A8450C
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A54C440D
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358228A414;
	Thu, 10 Apr 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pXWLultO"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456C28A3ED;
	Thu, 10 Apr 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292169; cv=none; b=j3G3Y3X2vhKjI9udIBClZOOwHFQlIdmnHGYs+ebxzmL9vvhrchn0/61Ioah5bVpbsulPbTDIw7DtYB2Xvd0HM385Bh38E11plackYShu47gtbHwqzui/7vt9X0mCgLhYIiKgHCFGRNmDJgzIMzdBt4zfUFK2m7QNEByzOM6KrNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292169; c=relaxed/simple;
	bh=8w7p142ZI6H8+1uOKiDKtSC1X5Go4vUEdku/HxK6xEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBGqLEQWPgXsvo6pe/qKG1i3Z4yjIbvZn4kKyY+xWZ27gs7Q0svBP+flJrRAHxJKjWyAxSN0We63eMmxXKQrvblvj3Iix3sSXyAU7Vo/ryNpgW6NBsaqtRCFT5X9aXEXC7l7JygvsraYtSOjylh3jaCilIswG4ADqkzrOwPWYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pXWLultO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A8FWKD026291;
	Thu, 10 Apr 2025 13:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yL9HWn+60Q9EVZ3uJcJqHtpRSmwUoWL83MLKIjRHr
	8o=; b=pXWLultOX4xmtFyzi7qYc7BS38Ec6JwExL0Cw61ntWyxHQa1tVf4wzuLd
	R39dDWQGofLSqMj1sRfE9jcpC7GOKRa8QGtt8xvHa7thV7DCrPsg3Yign0uelC3k
	unckfI7u7AtL9Aqfp/dwIZIUI6KxML4gUd5Rq1tE6zmqr1BOPIet/pY3WUPWJlX8
	0H+E1RHh9q40OVXW197xg2Dxzy8JHRSn4mOtxPE/IIrZVChTgwpeQUEINOmgXHS0
	7CNCyQlxMHbSt9hoFi2XKF7oTXhBHZhET/BM+nlcoXXbP6e73bwdmKVp1l3fG+qc
	Qb807dK8qPtZGh8rHHfL5WPyuDT6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq77qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:36:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ACmZjX013860;
	Thu, 10 Apr 2025 13:36:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunx5fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:36:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ADZvhS59310496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 13:35:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E58EE20040;
	Thu, 10 Apr 2025 13:35:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C0920043;
	Thu, 10 Apr 2025 13:35:54 +0000 (GMT)
Received: from vishalc-ibm.in.ibm.com (unknown [9.109.245.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 13:35:54 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] doc,cgroup-v2: memory.max is reported in multiples of page size
Date: Thu, 10 Apr 2025 19:04:40 +0530
Message-ID: <20250410133439.4028817-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DcsFspk4L96Youfsu3210IadEjLZGFFa
X-Proofpoint-ORIG-GUID: DcsFspk4L96Youfsu3210IadEjLZGFFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504100097

Update documentation for memory.max to clarify that the reported value
is in multiples of the system page_size. The following example
demonstrates this behavior:

  # cd /sys/fs/cgroup/
  # cat cgroup.subtree_control
  cpu io memory pids
  # mkdir mem
  # cd mem
  # echo 8000000 > memory.max
  # cat memory.max
  7995392

  # getconf PAGESIZE
  65536

  # echo $((8000000/65536*65536))
  7995392

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1a16ce68a4d7..577d05c03ffa 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1316,6 +1316,9 @@ PAGE_SIZE multiple when read back.
 	Caller could retry them differently, return into userspace
 	as -ENOMEM or silently ignore in cases like disk readahead.
 
+        Note that the value set for memory.max is reported in units
+        corresponding to the system's page size.
+
   memory.reclaim
 	A write-only nested-keyed file which exists for all cgroups.
 
-- 
2.49.0


