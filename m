Return-Path: <cgroups+bounces-8624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39010AE494D
	for <lists+cgroups@lfdr.de>; Mon, 23 Jun 2025 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91217A5969
	for <lists+cgroups@lfdr.de>; Mon, 23 Jun 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1917828BAAF;
	Mon, 23 Jun 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KYAiZida"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C126E175;
	Mon, 23 Jun 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693999; cv=none; b=awzZybKNeiB40HQD5Kr78xvUt6B1rkGm7tEicZNl+IQ63qs+6kP3HPKekcLITvevCbbe0zq4poHX0HR2i5eioiZzd5G7wHRaQJ09ZJQdwYLe/EzPxUzrVugvsLHkS3sW/RtFmKCFpyXL70tbCNe7GF3NYoiu+R283xdMFvaEJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693999; c=relaxed/simple;
	bh=eKiXvCPGG7WLlm26Hmb3q6+HD966RHLLuhjnSiZlll4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhntzDIhETxI0n31yicFCV/KuURX9F/+tBuKaXn3KOeXRnMgRNHYc9MOIDl82SDORUUcfiOlKuBwbjuikvWjEqmB7Fu6GGEY4jZsZZsISC8+4g+p6Npo/AZ2oXPaBWHIRE3quQXUNliN7wh44lTmlshnydoxqDZh16vwKMnlCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KYAiZida; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCiZOO002102;
	Mon, 23 Jun 2025 15:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=PxxPxgF2ODXpDFZkHWm+P8oA/NR5X
	Y0G9EVuhakE/zQ=; b=KYAiZida+OyzOMzZExsedHOxYKbS28zeuAYDxEE5MMHI0
	9MziLVOBEk8af0MIusyWJPkQs3fqk9P8UtrAMBONnfqvcb28N6meuaoL7icm9tkM
	tzx56KFRCB3soo76R7qBukXD1sPlHs+plZ6DgaSptq0iiviSwxAXg5G+4TMBzjAq
	qnTz+lQ4XTUoVzxd0tlZQzGKyvoAegIGCj5A7N6CRNe/n0QbHjP21KaCnjtM82Tb
	CSpy18fX5+rHktbTbSzEVCKIZqhrZ6DS3FzZrkr9YMNF1MCH5icKgBBJ3bwed05P
	9hZtDtUZdD8zh8pF8upp32vditBZWZ0iroFYQRaIg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egumhyg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 15:53:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NFSveK009051;
	Mon, 23 Jun 2025 15:53:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq2h5v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 15:53:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55NFr9NV013518;
	Mon, 23 Jun 2025 15:53:09 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehq2h5tu-1;
	Mon, 23 Jun 2025 15:53:09 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: [PATCH net-next v4.1] Expose RDS features via sysfs.
Date: Mon, 23 Jun 2025 11:51:35 -0400
Message-ID: <20250623155305.3075686-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230096
X-Proofpoint-ORIG-GUID: duWBwEmbLxf3o-T2KorWfTeXqc9tcnAR
X-Proofpoint-GUID: duWBwEmbLxf3o-T2KorWfTeXqc9tcnAR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5NiBTYWx0ZWRfX7xL1wh4By42L Xd4AGC8Kwwt249NClkEGf0EYzdSm/w3GgpppJIskKdwwZ6I77HvTUS9OENSV/DyeRxCh1n5m9rD QMDJCRu0z27iRa5gYGBiXa75/1ZTbzKq6bf+DjyBVLzt0rz/Brv1W55Q6dlS5WIzMN2gOOaTbaD
 7xMc8i6H0bvI1GF0yWsKAIZCM4DITQUnF8kGC7GcEVpslXpErrTaolhhUR3/PPzhre243Euw1mR cKAwsMvBuxAnl4kHsky5hecwkW0TbpctQ+BHLUmWSxiIzdzzJeYoXwFAVZl8YoMf/xDP6AcYemB H8BMBDGSz1Kyz/4ye3rjY0CMwsho+0bII8QX4Xndt5+VUyc4GcyJil0zJTXDFRiacUE2H2JamLT
 p5SR+U7jCqHp94EdGYm/J9YlecN65xT/QyHkPM0QYoYONjDvaNO4e+yaZjdJeh6LRzelVjea
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=68597867 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=xjO9cqGlMa9R-XWzUmgA:9

Hi folks,

Changelog:
+ Since v1:
 - Changed it to use sysfs and expose a 'features' file with the data.
+ Since v2:
 - Use a 'features' directory similar to ext4, btrfs and expose each feature.
+ Since v3:
 - Fix ret returning 0 if kobject_create_and_add fails
 - Follow the syntax of Documentation/ABI/stable/sysfs-module.
+ Since v4:
 - Changed period to coma in ABI documentation.
 - Added Allison's Reviewed-by
 
This patch addresses an issue where we have applications compiled against
against older (or newer) kernels. RDS does not have any ioctls to query
for what version of ABIs it has or what features it has. Hence this solution
that proposes to put this ABI information in sysfs space.

 Documentation/ABI/stable/sysfs-transport-rds | 43 +++++++++++++++++++
 net/rds/af_rds.c                             | 63 +++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

Konrad Rzeszutek Wilk (1):
      rds: Expose feature parameters via sysfs (and ELF)


