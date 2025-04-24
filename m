Return-Path: <cgroups+bounces-7794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AC3A9A90C
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499591940053
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52D221283;
	Thu, 24 Apr 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mYoGdWUK"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD9221293;
	Thu, 24 Apr 2025 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488249; cv=none; b=XWNcRRs9GO/YHgS1+JFyJQdVBEAvxNMLlnhjMrxycc1Bms4u+Oj2gHCPhdLQhW4qjiHKrk99c8xMMsOKkExYmRicGGkeAXGsn5bC/BxKTwUscO45Uirllw3MKKKuXcyjoQLhQWjLw4v86IL/WNm2q1RX9I/LSgIZEzunKWPqHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488249; c=relaxed/simple;
	bh=MI0rkee7qPSFJNcBOLfAdj1VY4hP4+td5WuZ+B4CRDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXCtCOD2kBq+2wjwdj15sawh830rBG5pUkcNYY6nnQWiVIJMH+QPZFxM6jrEzQb6rDhewuP58Kv0gMy2cc16nsYm/tI/UL7Pb7q++HKfqjjxWUG+jhVprybHgZwcIiBhenCkdAbq4PVmWTkZaMA4yv5MgAhNJ/osHsZh0fZyD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mYoGdWUK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8kHdI010515;
	Thu, 24 Apr 2025 09:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uh8kHX
	wfj8QuQ+9gFTMr1gfS0Q8c4U8sdk6PJBfRG3E=; b=mYoGdWUKKgSnwyQ7Q2Dbmh
	1QBxrYObcf4OsQEQDx29fpvsXZMmQEvvymef/am8U47XxpuVMna9aQvc42SMRapO
	0jCSRWUVgMuHS0WDf5Lh+1sAtBPE5UcnDRwJ9E9PXkDLmDvMh+LOYXR0LCpyKw95
	Kg96vCCNO8NW01g34k99VpiCCYVQ0ZNz6MKevV+2/6IvbHHfgIslfa6l30njqLeE
	tPn3SzcOcm1PWItcO/+ZNbaOVw4FZmF0IZYXdzfCEq2Qb7a827AgjHj1ODkYyddh
	uo6xMwfGtrAf5UNOpk/W+zDkVOG+/nvrkvE0kuD8nEZIIpYqgvFYamvTZBucUOYw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4677sm2vbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:50:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7EJed028388;
	Thu, 24 Apr 2025 09:50:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvqj7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:50:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53O9oHZP21824066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 09:50:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8417158068;
	Thu, 24 Apr 2025 09:50:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA4358052;
	Thu, 24 Apr 2025 09:50:09 +0000 (GMT)
Received: from [9.61.250.107] (unknown [9.61.250.107])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 09:50:09 +0000 (GMT)
Message-ID: <f67fd213-b39b-4f49-a839-38b9ad5565d2@linux.ibm.com>
Date: Thu, 24 Apr 2025 15:20:07 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] sched/numa: Skip VMA scanning on memory pinned to
 one NUMA node via cpuset.mems
Content-Language: en-GB
To: Libo Chen <libo.chen@oracle.com>, akpm@linux-foundation.org,
        rostedt@goodmis.org, peterz@infradead.org, mgorman@suse.de,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        tj@kernel.org, llong@redhat.com
Cc: sraithal@amd.com, kprateek.nayak@amd.com, raghavendra.kt@amd.com,
        yu.c.chen@intel.com, tim.c.chen@intel.com, vineethr@linux.ibm.com,
        chris.hyser@oracle.com, daniel.m.jordan@oracle.com,
        lorenzo.stoakes@oracle.com, mkoutny@suse.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250424024523.2298272-1-libo.chen@oracle.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250424024523.2298272-1-libo.chen@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2MyBTYWx0ZWRfX8ZNpSkKZyLTj Z+Uh4OY7lraJNkmIj/Ymz3IDHhUnNAVYWIuUR14Vh9nvJo6WJ+cKAwxYAsjHMBI+e+NeItqKSEF dOoOn8vXM92/bORUa+FklfQl2ALTdVcT4jRNSsIdb07qFoq9mq8pFf4RgFlE4rqQY3MqXil71H0
 B8I27/qbVG+bvp1CvWcs0t1FGYbu7WVVztmIJQQDCYD6/x+4OpMfWQ3mLcW2hfp3N28GNccJwl1 kVfBepsOpGx+uX5A/t2Mp/QMz9Xx40qEEeS25jlF+IQg7zV7CRJ5F1BV76PmElF928pnhyxqj8h GtqCXz7ukg//H81xyZ/SY8xDYBZFd/m3YjzMqp7Zy1o6elPlScNctzEOrCfEX1A+aGCh0/dUFM8
 FWSG7eWotzbhavj3ftdYMMkq1Rs6MQKzVqnKwogCN1Bef4xAVfWJESnVzPzKNZUgimeGJpEf
X-Proofpoint-GUID: jJI7p_Pu69VP6hngBoJhzak20Bjjly3h
X-Proofpoint-ORIG-GUID: jJI7p_Pu69VP6hngBoJhzak20Bjjly3h
X-Authority-Analysis: v=2.4 cv=CcMI5Krl c=1 sm=1 tr=0 ts=680a095b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=2orru8iOFGd5tucj_wIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240063


On 24/04/25 8:15 am, Libo Chen wrote:
> v1->v2:
> 1. add perf improvment numbers in commit log. Yet to find perf diff on
> will-it-scale, so not included here. Plan to run more workloads.
> 2. add tracepoint.
> 3. To peterz's comment, this will make it impossible to attract tasks to
> those memory just like other VMA skippings. This is the current
> implementation, I think we can improve that in the future, but at the
> moment it's probabaly better to keep it consistent.
>
> v2->v3:
> 1. add enable_cpuset() based on Mel's suggestion but again I think it's
> redundant.
> 2. print out nodemask with %*p.. format in the tracepoint.
>
> v3->v4:
> 1. fix an unsafe dereference of a pointer to content not on ring buffer,
> namely mem_allowed_ptr in the tracepoint.
>
> v4->v5:
> 1. add BUILD_BUG_ON() in TP_fast_assign() to guard against future
> changes (particularly in size) in nodemask_t.
>
> Libo Chen (2):
>    sched/numa: Skip VMA scanning on memory pinned to one NUMA node via
>      cpuset.mems
>    sched/numa: Add tracepoint that tracks the skipping of numa balancing
>      due to cpuset memory pinning
>
>   include/trace/events/sched.h | 33 +++++++++++++++++++++++++++++++++
>   kernel/sched/fair.c          |  9 +++++++++
>   2 files changed, 42 insertions(+)
>
Tested the above patch on top of next-20250424 and it fixes the boot 
warning on IBM Power server. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


