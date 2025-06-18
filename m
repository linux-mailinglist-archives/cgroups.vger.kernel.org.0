Return-Path: <cgroups+bounces-8578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF243ADE188
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 05:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4A917AB25
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 03:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DACB1C1F22;
	Wed, 18 Jun 2025 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GCiSKjNo"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10AA932;
	Wed, 18 Jun 2025 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216541; cv=none; b=r9G6j9agUWhgrbMv9SlwOekVxweL038Qfv1liLVKJryPJDsTSnNPI4t4EW/06ZhcGj+XMQRgVLPlPWkiOeQFN67KFBvvNXdcWkYAyP+KjfHvIDlJT7/NgbhHykC5B2lCaeA41rTvdzGrqN+gLk/BrFhTV5xal6Vby1B+Fm+bGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216541; c=relaxed/simple;
	bh=ueXBqZQEF3H69RZRoWO/3/sk4OA/OLCOjv8Mr8rHuO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXO4B84E5SFfQUYL0Q2h05vYFjbu33glJA5w0JEYic8dmQh2VOz7gSk73NQQsyJtuyJzFXNXyAN8Y9KyDk86ydJI+WinxVNRcdf4sM8slfWlxpF8ngIMOvE8ffapy/MvYDC+HZZahdLFeBoGvLmcFArihCdVXYNrZ+JF2N+7dUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GCiSKjNo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I1tZGf003472;
	Wed, 18 Jun 2025 03:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=0wp+WfmbPbO1/USMJhxOjet+grL7D
	cjFUgxJ/SEFu0A=; b=GCiSKjNoyU9hrwNLo9d6a7wwDelk+pNnQTSXMjiOgzPiC
	PWW9kBBrzZKwfGfTs4OtyHF8dpwFSxc7uvIKZmPMryRQ59vAq1Jf9Zr800l5wASi
	CHHEBYpemVrEygb0fzCwNOBbL0gZ2OyTo1N4W/Igl+EYCQgK/G+hF67fHvj73jYY
	tFI3ud7PAtuHftwzo8DiojL5/arIiqHs7QAjUbu+Jrj6hf3UWu7JTQSD938e9DRS
	OaWC2o/208AxK/VjAVVe9CG85oKiDI6s17Ohm2ZYY0Fcajf21Z6l9mccwXpC7LyC
	EQLW40H76RML1y4Xci4Ci0kgZdFWuZ/NVMf2+N/8w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900exw81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 03:15:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55I1uWSV026045;
	Wed, 18 Jun 2025 03:15:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhgb9rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 03:15:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55I3FTuc002711;
	Wed, 18 Jun 2025 03:15:29 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 478yhgb9r7-1;
	Wed, 18 Jun 2025 03:15:29 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: [PATCH net v3] Expose RDS features via sysfs.
Date: Tue, 17 Jun 2025 23:13:08 -0400
Message-ID: <20250618031522.3859138-1-konrad.wilk@oracle.com>
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
 definitions=2025-06-18_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAyNSBTYWx0ZWRfX6gjqTeZYEHGT 6xMRwanuL8jQYY3fd6NbPUk0rPkHZwlVu8WW69k0nK3JUnWJ/vwq1YslMpbmRooIG/YTiMsrEbX yQLvOJxvT6VCyuIziy3O9NI82Rl1kAoFjntu9PgEUFbE3UQ90tg+GnWzvbDW4Lh9R7rCLp8e5GZ
 5v5nFLUI0UqxllDqU2U0NDHrA9Syb8IfdorMd3qL7Xk2myef5JX7m/gCajuThGOhz/ffHREEKEU ehgy8G76vSokd46G/oUo1svJnZzMRwOjpY03jf8s6JJ56SqjLGwfmW+0kG0Aubp7M5zgmeLjcQi PwPg2ANal7Fv5d7V9J5lDKYjheJ84R8RSlxdNcS0sur8rQNMVRaWZJAIdWB60ZU3ADvAqtkTqpC
 /GUK88yx98TU7A+8+GJD3F0G3s6IsPijNBmqNVWv69UnCWPN9ZeLgvK9pJDpmaKSr3MN8lZ3
X-Proofpoint-ORIG-GUID: APXouVPywRkPkR2z_jrDlhH-TUEFSRL_
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=68522f53 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=xjO9cqGlMa9R-XWzUmgA:9 cc=ntf awl=host:13207
X-Proofpoint-GUID: APXouVPywRkPkR2z_jrDlhH-TUEFSRL_

Hi folks,

Changelog:
+ Since v2:
 - Changed it to use sysfs and expose a 'features' file with the data.
+ Since v3:
 - Use a 'features' directory similar to ext4, btrfs and expose each feature.
 - Expand on the Documentation
 
This patch addresses an issue where we have applications compiled against
against older (or newer) kernels. RDS does not have any ioctls to query
for what version of ABIs it has or what features it has. Hence this solution
that proposes to put this ABI information in sysfs space.


 Documentation/ABI/stable/sysfs-transport-rds | 55 ++++++++++++++++++++++++
 net/rds/af_rds.c                             | 62 +++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

Konrad Rzeszutek Wilk (1):
      rds: Expose feature parameters via sysfs (and ELF)


