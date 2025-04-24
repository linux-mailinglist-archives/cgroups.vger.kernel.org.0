Return-Path: <cgroups+bounces-7773-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD2A99C71
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1726A194015F
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CA72904;
	Thu, 24 Apr 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YlEwcAi/"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4994139B;
	Thu, 24 Apr 2025 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452938; cv=none; b=qhpkAwoGWWNuSNWYFX36JrTgH7i01zEHfSamNfV82FupjOOofnnQof3G/mpQhC9T9ZB2iJ3LOoVUwKLyGVBGMJWLOOriLJPsqEfF6eH9rfpyO42hUmYAhMmlqJHVtIq/skeiHOG2T5/HNhTrJW+cxjKLN0aM1SHb70en9Quj7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452938; c=relaxed/simple;
	bh=1al9mn1TGyVS/U4RzXbV5frYnTVk/cOuhaMpMF8vNro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ejw8ptBrAJ+0E9PNYWG4dAnqIJ4ONutGfQWMoxEVKFglGAzjK807X0dDtnUCNXeHypkAdlub4Ovi1PyJeJNabTVFkhzHiUaIGfI7igrdqHWVxynBuEjev9y4IygQY8xlRJLVpRXH8lMOIJoM8+mLk9ONAQ943bTyAeY4Tn41Tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YlEwcAi/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLMHog017381;
	Thu, 24 Apr 2025 00:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=UKAH/aHPQj67CPvoG5HcNCkn6w9Ob
	gJUIURiRefabM0=; b=YlEwcAi/idc6RK1cKr1ZOMQcFhcR+IiXPtoF8BEbnPr1P
	LTM2zpogQFgic22/24YPUuioxJHOY0A72XQtMW6PK5iy9qQDifzP5Cy8bs0COq1G
	Xv7KLr2s7oWK48CLLO53dYAiR4hFPL0YwByAP49tIqQkbkN9hNnAcOpvFF6gqkHp
	y0xavrYDrf4RRsCRO60bwRfIQhNdItVEGRPffcKWo6eM9V6rLM7xso2BLysYRuwl
	KH/DyZ9ySGgcQIF0qmFlT/wZq7rxkobuc540K/v3EIVYQcDhDFvjnSS19Z8UKSGg
	BZG16NP2w6Sn1tdOvGrSV4dq6VWVxcX1ddhYt5P5A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jh9jj2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:01:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLZUuw031015;
	Thu, 24 Apr 2025 00:01:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06jqwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:01:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53O01oOk004345;
	Thu, 24 Apr 2025 00:01:50 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 466k06jqsh-1;
	Thu, 24 Apr 2025 00:01:50 +0000
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
Subject: [PATCH v4 0/2] sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpuset.mem
Date: Wed, 23 Apr 2025 17:01:44 -0700
Message-ID: <20250424000146.1197285-1-libo.chen@oracle.com>
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
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230161
X-Proofpoint-GUID: GVkLOOhczQGH2e-sFiuJW9TYOrNialrm
X-Proofpoint-ORIG-GUID: GVkLOOhczQGH2e-sFiuJW9TYOrNialrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE2MSBTYWx0ZWRfX3MaMa4BasE0x NN4OwrJk3O0YzXFSk1a9k+ajjCXSH2+cOM2i2A7PIH6TQob7XFRJJ7QOUO72iTFm8lbytkDPOuh /E8mCM3a7Zt4Mhp1GRLUjE4HtqGJHXYTIxMdO5IV9If1HjN6UieVOp41B9QUejSDIEMPKaLUdk/
 lFr+BWzQT2l80bUlyRMoRuaEFw6NSgJigwOTgQJ94SWdRBj86ZO2gVsx7VWGFBlAb3S/JIORcHG 18QicYjo7T7LdU2SC7a/U4a1Uqo9EZ4ImN/5w5D7hEUXi8yB2d9EDDcnHEHLh5jOGqq4R0y9TIw RUShEvL2YaU1iKCS6zlHv5hFz05SZzkCFMoAKk0YrnPTswNkdWapv+dl4ZvTb+t2DawGuvqL2ZM x4qs/VXy

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

v3->v4:
1. fix an unsafe dereference of a pointer to content not on ring buffer,
namely mem_allowed_ptr in the tracepoint.

Libo Chen (2):
  sched/numa: Skip VMA scanning on memory pinned to one NUMA node via
    cpuset.mems
  sched/numa: Add tracepoint that tracks the skipping of numa balancing
    due to cpuset memory pinning

 include/trace/events/sched.h | 31 +++++++++++++++++++++++++++++++
 kernel/sched/fair.c          |  9 +++++++++
 2 files changed, 40 insertions(+)

-- 
2.43.5


