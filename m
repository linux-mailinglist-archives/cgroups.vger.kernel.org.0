Return-Path: <cgroups+bounces-7625-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D17A92B97
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 21:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863B31B62C7F
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03C1FCFF1;
	Thu, 17 Apr 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OvENhDq4"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8D14B092;
	Thu, 17 Apr 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917370; cv=none; b=k+KeKwp1wXHqhkA/3YVIZTnBPY8gNvY3XIE9hmELbc4iEp8h6Pf4DTnuRHeGi6rWNUsbf3Otvh7A8SsAbcGd3x+wRn7OBCreeUGzqwOr9L1axP/cYjUVP05lYRTVreTIay26cGRxJZvg8Dz0L7Pknlzh82mFXQatjAsct3IAqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917370; c=relaxed/simple;
	bh=IYpzgU3ipql4t3iSXSAtQFQE1hW+yvPl6bLZa72iJM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQk42pM2627VAHXSEkRUYq1ot/O3l/kFEEYQZo8u8wz/WHi5V57BrgqmCIJ8reHL3BoQewuMLEoUFOmPL3AhgnbU+NB4kYIVIpXO5GLog0RtIBiFXSiRbr0TlrabTZVR48ftUon0iMnH7JrGRv+xjR7q7X2xaeDmKqGsB+eFpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OvENhDq4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMsu4023734;
	Thu, 17 Apr 2025 19:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=18dzjAfOD2K8jCiZcllh00rVoph7d
	Q44wuMQGDfE4J8=; b=OvENhDq4LlgTLZQKqDrFUVYjzBFhX8ZkFjwHiZSHr9P7A
	m9UqzeX0TwaqFBzSD/d4D6JGBX8kTSk/GCIYcEQYl+cW8rHwEnBsbGQJojSvY1Ur
	ulRhyu4QZSjbnCgkklCQlCaeLKN5uZQ2pqNi8OOoIHZeYmzFxq9J3Ioob9Q1Fz6n
	AakoKzXjci0hH28rSFKKFNzOsN4L0IVBR2YgukMKibLjvHgG5J2Gx+9K0VnOPur5
	zNB9IteXiZq7RYL+L+GVCr0I2pQiqoHc3HuzX3/YLUI/DGJkBpy+MbrsOk0Q80yB
	eYM2R79icJ8894WC87bz3k7GuzlU3FLdJsLrIOkAA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619446yx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 19:15:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HJE0b5009219;
	Thu, 17 Apr 2025 19:15:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d3npd9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 19:15:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53HJFjRs037615;
	Thu, 17 Apr 2025 19:15:45 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d3npd8k-1;
	Thu, 17 Apr 2025 19:15:45 +0000
From: Libo Chen <libo.chen@oracle.com>
To: peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tj@kernel.org,
        akpm@linux-foundation.org, rostedt@goodmis.org, llong@redhat.com
Cc: kprateek.nayak@amd.com, raghavendra.kt@amd.com, yu.c.chen@intel.com,
        tim.c.chen@intel.com, vineethr@linux.ibm.com, chris.hyser@oracle.com,
        daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com,
        mkoutny@suse.com, Dhaval.Giani@amd.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] sched/numa: Skip VMA scanning on memory pinned
Date: Thu, 17 Apr 2025 12:15:41 -0700
Message-ID: <20250417191543.1781862-1-libo.chen@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170141
X-Proofpoint-GUID: 5cScS52SqMbsboqoH013aqwV34Et-ToO
X-Proofpoint-ORIG-GUID: 5cScS52SqMbsboqoH013aqwV34Et-ToO

v1->v2:
1. add perf improvment numbers in commit log. Yet to find perf diff on
will-it-scale, so not included here. Plan to run more workloads.
2. add tracepoint.
3. To peterz's comment, this will make it impossible to attract tasks to
those memory just like other VMA skippings. This is the current
implementation, I think we can improve that in the future, but at the
moment it's probabaly better to keep it consistent.

v2->v3:
1. add enable_cpuset() based on Mel's suggestion but again I think it's
redundant
2. print out nodemask with %*p.. format in the tracepoint

Libo Chen (2):
  sched/numa: Skip VMA scanning on memory pinned to one NUMA node via
    cpuset.mems
  sched/numa: Add tracepoint that tracks the skipping of numa balancing
    due to cpuset memory pinning

 include/trace/events/sched.h | 30 ++++++++++++++++++++++++++++++
 kernel/sched/fair.c          |  9 +++++++++
 2 files changed, 39 insertions(+)

-- 
2.43.5


