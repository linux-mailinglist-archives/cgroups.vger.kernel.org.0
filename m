Return-Path: <cgroups+bounces-8619-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAA0AE26B7
	for <lists+cgroups@lfdr.de>; Sat, 21 Jun 2025 02:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17DF1BC5E1D
	for <lists+cgroups@lfdr.de>; Sat, 21 Jun 2025 00:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1B847B;
	Sat, 21 Jun 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mABo3DTg"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341AC4C7C;
	Sat, 21 Jun 2025 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750466874; cv=none; b=elOpzP9sfBfYefrVulDqPwDAAH6pWVOKDX1F76MrhcLTMT880FM4f/kjit81Dhqj8CB7q/gCxG/DL+TJP5An2KFpnYbMMPIhCGaSAThg1qJ0D5/jFEixhkPa8ghHqTxpjvlSE1K387Oom+98kdKO/r0Wxw22Zzq82rdS4jJcBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750466874; c=relaxed/simple;
	bh=P3T3lMbliCUlHip6lon8TgSCX3DYEoaqxNKSAaEvwq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+p14gtje0wopmzd/5WSOhCR1qCFXlGtDc7OdOkrWDE0FfmD9AQDtm211co+Qw/jFVCh3OJ3BeEXxFvMz0TAAYCBCnhorrl03h7SYTmONjjqSB8uNyMwJhA8Iym/O+eG4C+oqb2NilUgCNgy+yVVLNItm2SYOgxtQfwi/ESe3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mABo3DTg; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEBl13010407;
	Sat, 21 Jun 2025 00:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=TunngGGa7IAXVrIg7SDfP//CX6E4e
	X/GiN5io65+RA0=; b=mABo3DTghZ/wHoMVdfGG4EJ0K7emwY8yYhoE6DKsY6prX
	xCcZTTEu14H9TgamVwE9b+/iPHFzNvt5bPqGi16Tt1myKjHHw+J63JGG1iWez5/L
	V6+sU7sSZ18ecKas9uSA2wfBMvw1y87AtGfdwz4gLZG0cBb/aGdimTgbgLUGUn9M
	NczeK4BtW6YVmX6LGAuLnbLDw8WVKF3SQ4k5ZO9LM2NTqSIXYeBtr0CvwKWfRQo/
	ts877Im0iOgd2JoYMN5XDMurF8FhtogrOmsn/ieqm9AGp7zJYKPN1iJfqUGlsp0e
	D8jbpJOmnXzKJZHxTkro2xw+Mhk5XM7iIP03X8CDg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4vps0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 00:47:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KMVo4v037634;
	Sat, 21 Jun 2025 00:47:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhd7nnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 00:47:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55L0ixOg038657;
	Sat, 21 Jun 2025 00:47:44 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yhd7nn3-1;
	Sat, 21 Jun 2025 00:47:44 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: [PATCH net-next v4] Expose RDS features via sysfs.
Date: Fri, 20 Jun 2025 20:26:10 -0400
Message-ID: <20250621004741.2883507-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506210002
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDAwMiBTYWx0ZWRfX5M6JoSSuT/GI jOtNHafgMQhISltSb08fQdHNtpgZCDP1emjEctdPisC4O8DKiiowEqcXAB+1ZpXzqVkl7+MEsjM 63Z8YWAjG61fmgfDUM3prlRcyXlMqpxwKHRF2MNlHPmE8lwoEPlfr3FRGRBkWxd4kW1z8l3jG0l
 TSxf29JQjRt6bJ59/jmLM8R3mGsBNrty+Jot7BCARstbBi8syLFxWrgjyOT2TSX/TlZ9k75bcoj 1663y3nJq4kSz+jIVw3LvfjNFoH2c49AFYwJ7ULOqhIzenYNsJ651O9QDO49om9LdiePpT/MJki zK3QmL3W6olcoTr+hioWaTkv98K+99rdPfOc7lJk57XPVPik49TneR0eEuU2jeeonU14ZumMITj
 fIYpeM81yS60u7SP6L3elkUY3Ph2EA2TUz8zDau3GwFZSklRODKzcHpeCrEVdsc0G07R4123
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=68560131 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=xjO9cqGlMa9R-XWzUmgA:9
X-Proofpoint-GUID: 0-a_3Vg8D27RGCTNk78sUnBZ1QJn66Ya
X-Proofpoint-ORIG-GUID: 0-a_3Vg8D27RGCTNk78sUnBZ1QJn66Ya

Hi folks,

Changelog:
+ Since v1:
 - Changed it to use sysfs and expose a 'features' file with the data.
+ Since v2:
 - Use a 'features' directory similar to ext4, btrfs and expose each feature.
+ Since v3:
 - Fix ret returning 0 if kobject_create_and_add fails
 - Follow the syntax of Documentation/ABI/stable/sysfs-module.
 
This patch addresses an issue where we have applications compiled against
against older (or newer) kernels. RDS does not have any ioctls to query
for what version of ABIs it has or what features it has. Hence this solution
that proposes to put this ABI information in sysfs space.

 Documentation/ABI/stable/sysfs-transport-rds | 43 +++++++++++++++++++
 net/rds/af_rds.c                             | 63 +++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

Konrad Rzeszutek Wilk (1):
      rds: Expose feature parameters via sysfs (and ELF)


