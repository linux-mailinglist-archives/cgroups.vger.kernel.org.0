Return-Path: <cgroups+bounces-7783-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63322A99EEC
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 04:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB8D5A5259
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D701991D2;
	Thu, 24 Apr 2025 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aNqYcQj3"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7879D0;
	Thu, 24 Apr 2025 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462782; cv=none; b=pWt3XNFaTDglZdPL2gVVNiDfSSli6CjlGiWaKafr33DX5FFbazKW8gk3c75UNZCwRVvHf8k2j3gTmByf6JWFvwFSNZXIn/1bD3mlDa7pTbqFOu/2SZakJVo1VbGP6grOTNn9ijuoUiJA/bFMbNFkflfncyy2GmBfF1GOZs5KuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462782; c=relaxed/simple;
	bh=ga0/xUO+Mwi+DnTzYFYtvcQ3uYaWRcKYGQXMiyVoiwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTjFRjpxPkQ4Z+/e8BtpnAr7WgsRDNP0WqgLfelpYDZcWmbRVdRZCYbk9J3e+xcqQ9peClA52qC27rR2zuHvayorDIOOaCf+F4xXIQz0F+3QbihIsJmLaUX6Q0iByxiHwNrod1mtJeYN6V0PkPKL75q4P+aY7EHj//S4KCZl2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aNqYcQj3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLMJdJ017500;
	Thu, 24 Apr 2025 02:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=mj0YAlP6jI+YDoTyfoEygAzSYoSo+
	UXTFc/An4e8d2U=; b=aNqYcQj3TpllrskBJYcDIs6XySXxxszOJneVG/miaGKJ8
	RRmAWROd4oB1wgC6zygkJW6owdmkv8ctriUw1dDXn5p1V+lFn+y9NRj3trErcPyU
	4FLgrWXIH/CSlJ1335M7BObv+7pZHVYSM/ahJLKdRxH+33+X4+URx7FHawblqB04
	MiPcAKKdrgG4ehGyIlHQfEr9nMRR+YDwdH5MYUiVADs6FOYSlXcTs2KYGCJ/hb0m
	4zla5lf1YR0XoWD2NqEHW8/MKrvFq4zKMICKPbAGTMDHKenidCoW+8rtFsnpP1+d
	q4ic/eYsBH146kiIm2uhLWXllN8QtN1OOjFqTo1bQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha2xj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 02:45:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O1jR5e028470;
	Thu, 24 Apr 2025 02:45:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx6xryt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 02:45:27 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53O2jQBF033048;
	Thu, 24 Apr 2025 02:45:26 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 466jx6xrxs-1;
	Thu, 24 Apr 2025 02:45:26 +0000
From: Libo Chen <libo.chen@oracle.com>
To: akpm@linux-foundation.org, rostedt@goodmis.org, peterz@infradead.org,
        mgorman@suse.de, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tj@kernel.org, llong@redhat.com
Cc: sraithal@amd.com, venkat88@linux.ibm.com, kprateek.nayak@amd.com,
        raghavendra.kt@amd.com, yu.c.chen@intel.com, tim.c.chen@intel.com,
        vineethr@linux.ibm.com, chris.hyser@oracle.com,
        daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com,
        mkoutny@suse.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpuset.mems
Date: Wed, 23 Apr 2025 19:45:21 -0700
Message-ID: <20250424024523.2298272-1-libo.chen@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAxNSBTYWx0ZWRfX0Jq4zBrCb/c8 L/Lw6nUNZ9aCsztEZvc5aJUjpWfZ070O0eLESrFnI0LqLkGCq3CGVfYBjZyKWU4aezaz1KDFHvk 8ZQRMmAbxmZWrEXWu+G0k+SRdpvUVTx8tPMs68u/vuL3llG3ZQ4E8H9uO4J7Z/BTcoN07mc8ky5
 YDIVrbo8iE5YiOEuF/Yos+1Zr2PsGOpNVlWawLtgrX+S/7VFJxrDd8LlG9vb57MGsPDfUcTFV4Z 1rICkpaEjlGKw6lDpo1n2OUl8+H+GVgXwU+u43PghK0CyiM/fZRy7h5bU18bvw5qT6Hno00/1aG oz0VlZuW3u4IRXNEtdFGTTgpDRTZknYtlafUOX6JQwQGv09jAQlvt9M0bfB9t27YDnLk5Oymo1S 1Yki2wXx
X-Proofpoint-GUID: H9VvxBcZaftlAR9Nwb5vyKh6TAXsm9Hz
X-Proofpoint-ORIG-GUID: H9VvxBcZaftlAR9Nwb5vyKh6TAXsm9Hz

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
redundant.
2. print out nodemask with %*p.. format in the tracepoint.

v3->v4:
1. fix an unsafe dereference of a pointer to content not on ring buffer,
namely mem_allowed_ptr in the tracepoint.

v4->v5:
1. add BUILD_BUG_ON() in TP_fast_assign() to guard against future
changes (particularly in size) in nodemask_t.

Libo Chen (2):
  sched/numa: Skip VMA scanning on memory pinned to one NUMA node via
    cpuset.mems
  sched/numa: Add tracepoint that tracks the skipping of numa balancing
    due to cpuset memory pinning

 include/trace/events/sched.h | 33 +++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          |  9 +++++++++
 2 files changed, 42 insertions(+)

-- 
2.43.5


