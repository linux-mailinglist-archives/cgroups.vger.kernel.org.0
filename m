Return-Path: <cgroups+bounces-8495-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA7AD6294
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 00:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA13AB34B
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD124BD03;
	Wed, 11 Jun 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nUjxgWSC"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEFDF49;
	Wed, 11 Jun 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681631; cv=none; b=UcdhkhYvizIpGGV38Q1uyq9YGvu+24zirkMUXp1ehYq7xdwahvsnjQcOjfMcC7lZ+snM2EY7omsVG/+nGau55sqInLK0J2OqNtKzrmlxVF2PzSILTY8Q+mXrmbV8ImFa3cDPUWyEGQcjWFU1L4BXo00beIwMD1dj8XqltqFDJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681631; c=relaxed/simple;
	bh=tqcQIa+ZKMMv+FxVs+6upISHy3GJKMFoMRsshIbhJ54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8MPEFPQmCemue5b1buSR77WYJjm4Ktm5OHxVAoy2CsKdCBXiw0HIL23mMXSbZ9x+5zm0LffOu7h2Oa2XwIhBvOLl08DddgnEE75VgNySf/Oyan01ViJGB68LgTHfr0SV5AZiAIBwDLfmLtvAPRF/iiMjhhozzYxUY8g2Efzhbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nUjxgWSC; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BMPQiS007414;
	Wed, 11 Jun 2025 22:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=N2UiDtG3F5sbaCXZqBA6GWF4/z633
	RE00lAXhHLMGTk=; b=nUjxgWSCFK5MYMaNstpLVc2LvUWYyx129lcsEf65JD6Kw
	oz4w/f94kZbRNIoPAalQ2jZxENLlNemBiAWNVTHWugyDhCwD2MelnS47vhFlEC4d
	NIqXNso7d0AgSll6yFwF5eQ+sjX2BpIQogijt37HHMZ9BveeHkP0l9qvktshriKt
	BjQ2m6R/LSdXygM6/y5e9GOnXgI0mqbuXZ7sZTJCvzMBc8MvVcxhtTp6WP7d8pOw
	b6e1cfDwc3ylENh5zcXWlt784TVevNKkxMDuIdsG4wTK7GR4Ar6hMe3J0WhjyKsO
	IhMIHukv2vqdRW2BeMOWckKSLftUVCZqAv8IWs26g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf8k3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 22:40:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BKoJbG020342;
	Wed, 11 Jun 2025 22:40:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvh2j41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 22:40:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55BMeMxR024452;
	Wed, 11 Jun 2025 22:40:22 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 474bvh2j3t-1;
	Wed, 11 Jun 2025 22:40:22 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: [PATCH v2] Expose RDS features via sysfs.
Date: Wed, 11 Jun 2025 18:39:18 -0400
Message-ID: <20250611224020.318684-1-konrad.wilk@oracle.com>
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
 definitions=2025-06-11_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110192
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=684a05d7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=xjO9cqGlMa9R-XWzUmgA:9 cc=ntf awl=host:13207
X-Proofpoint-GUID: ICo7S6KqboMdPrNTn7aOzEdKdIMWe5oI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE5MiBTYWx0ZWRfX+FkAX+ieSSNd Qws1T+R6xwD8GdMqKFDE7HJ+bFjryJuqQzgmoeKbomuzObF1QICihpa/LObKbOjW1KeR9XCYWML tvWHaA6fwL79KNMVLKSVTsrUkK9iudy477/UWXIHcH/CVEe/rwioaM16Y19Qey9YTAdagLJCN7Y
 7mQJF2hTn7iEarNEOxtvs+dNWaRCAVUPeAsarsiIH+4/r0v2SLRMgVEBEdc9cmSpp0O7H/Sl5L4 AJJOihYHNtD2gFV1VkShLgDa23KnAWET86Oc7pTS27QSRx4yUdGg4Up8iAe0s9HLWVpZa7XL0PK pbgQgGzXnBhrHq5MQm/SdEK9ZIRupafF1LuiWE6QGrLQici7JZaofhzkYjLOc1THDm4oDkv1gC6
 yEH2vCstQNClf7UjFaDWwdRbI6jeLUwOf67qA0dsTBLf21BoTl3Bdtq3Y69O5argmNFYJVnF
X-Proofpoint-ORIG-GUID: ICo7S6KqboMdPrNTn7aOzEdKdIMWe5oI

Hi folks,

Changelog:
+ Since v2:
 - Changed it to use sysfs and expose a 'features' file with the data.
 
This patch addresses an issue where we have applications compiled against
against older (or newer) kernels. RDS does not have any ioctls to query
for what version of ABIs it has or what features it has. Hence this solution
that proposes to put this ABI information in sysfs space.

Please take a look and thank you for spending your time reading over the
patch and providing feedback on the right way forward.

Thank you!

Konrad Rzeszutek Wilk (1):
      rds: Expose feature parameters via sysfs

 net/rds/af_rds.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)


