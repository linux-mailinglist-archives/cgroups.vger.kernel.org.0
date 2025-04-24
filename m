Return-Path: <cgroups+bounces-7789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC90CA9A2D6
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 09:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF5E444F8F
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DBE1B0435;
	Thu, 24 Apr 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gud8syDm"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414962701C3;
	Thu, 24 Apr 2025 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478382; cv=none; b=plcSpy6fsoypeo6ZxkU1759H50FM+nKw/q1CLbei8/3mZneZLAwpiXYvJqoEAzyDZoGj3C66FJuV+J9Mmvlhl2Yp9oH6MXgM+BB2P8Hb6RDZqAw9W6j3hnFaG1x/YH51xsuTU/lHA3pdxHM+tzRmVqwbAz21oMBBa7dLKJ/bOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478382; c=relaxed/simple;
	bh=9u3a03ICmRscWiMZiaIaFAv3eqEtn2iaf0EClD28sxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2WYzQGveWKeSFKNhYa/fLpPaxq4qYU2uPiD/Rqo+n1tN8ajvFanOayn0PBBuS+P5SJYlLyHgW42edeS7fxT24oKMvEipRaRJm2wFN+foBgFZxrFWkiD4DaGKt+/TeeYZGemdhgGDdDThcHEFirSwifaC261lNmfuXKdinNSrBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gud8syDm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NL3Mn1010659;
	Thu, 24 Apr 2025 07:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eiiUtS
	CuRGYYjkG0GYgwAQhmsCQCr7/NSudYGV+4b7A=; b=gud8syDmCqT2Q0rMzkSOF8
	RNsITnbvEDBJFwbLZRRGTmye+QCbWoV+ST9JnHap0pgOv9RzZNdzOGsBWvSzsq1k
	kPBtq3SrYDj08wThMi84JM4Rm5q2pvTZZTpqvCi8b0eWpNYBDNaw7u0fjSH+IT5Z
	iWIbubCX+nXVzkz4E1kkTtMeY1J0DqRY74gmSttQe5GCnhqohtqI8xtiy61Q9Wiv
	k8MfBY6fMF3Z/ZF+r5nxaGOJMUalrvoHfc0DlzdgBnnBRh2p/L7GGGwWk6oN05QW
	62NQX6fcH7ogj2pK+bmSadjrpk+D5Zmc0uzmNE9bQH+saBROBab3/jxbQ8/5jQwA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4677sm231f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 07:05:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53O2l7PK028447;
	Thu, 24 Apr 2025 07:05:52 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvpyd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 07:05:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53O75paN14484202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 07:05:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDE4358068;
	Thu, 24 Apr 2025 07:05:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8614758069;
	Thu, 24 Apr 2025 07:05:42 +0000 (GMT)
Received: from [9.61.250.107] (unknown [9.61.250.107])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 07:05:40 +0000 (GMT)
Message-ID: <57892439-7683-43b7-9b03-4553737273b7@linux.ibm.com>
Date: Thu, 24 Apr 2025 12:35:36 +0530
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA0MiBTYWx0ZWRfX7aSpWUfcpGQK Grsmq2TPz74F6uGuWD5Hizcvf/dm1gpr4Nx7WIfeHiUIgBWnwsHHxdnW64s0SoJRHIfkv2oGZCM BgeArVA3iv7k+lPrBae49v+2SRjI3676aMUbb+Iu676gp1gowonVI/avl0WNQv0e7CjoMoKiQSa
 RuViIwX/Nk90kwQWuJfkMFPwhjvc/lyRrTwR+NpDPQq4DDd5c0gj8QFdSsnhYvcXw5aM4GIJXbS yoa/iLvM6a7f7Yrj7W5k79jmgqOv3wQ02p/PwI9tLE5abAwpXcROqROzJ7IMQwdoqxi1hKt1+O+ 4dUy1Pn0ATf23A9+g2hwAB9242yNktsiL4HsLAxcUa4myuMIcObnz/1YtMFKLGpCJ28VCH7t0r9
 +n2OtfLTwD2bQ38xjCAhL/ATyW9Mbbvz//+6vSv0l01ZPm2fbx5QRv2ZS1nzAcyXDFq7Dzuh
X-Proofpoint-GUID: s25T2sYloqrekRMlvi3K0t_Unia1aQfj
X-Proofpoint-ORIG-GUID: s25T2sYloqrekRMlvi3K0t_Unia1aQfj
X-Authority-Analysis: v=2.4 cv=CcMI5Krl c=1 sm=1 tr=0 ts=6809e2d2 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8
 a=EkCr6PPAZoFWUTBO02gA:9 a=QEXdDO2ut3YA:10 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240042


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
Hello Libo,


For some reason I am not able to apply this patch. I am trying to test 
the boot warning[1].

I am trying to apply on top of next-20250423. Below is the error. Am I 
missing anything?

[1]: https://lore.kernel.org/all/20250422205740.02c4893a@canb.auug.org.au/

Error:

git am -i 
v5_20250423_libo_chen_sched_numa_skip_vma_scanning_on_memory_pinned_to_one_numa_node_via_cpuset_mems.mbx
Commit Body is:
--------------------------
sched/numa: Skip VMA scanning on memory pinned to one NUMA node via 
cpuset.mems

When the memory of the current task is pinned to one NUMA node by cgroup,
there is no point in continuing the rest of VMA scanning and hinting page
faults as they will just be overhead. With this change, there will be no
more unnecessary PTE updates or page faults in this scenario.

We have seen up to a 6x improvement on a typical java workload running on
VMs with memory and CPU pinned to one NUMA node via cpuset in a two-socket
AARCH64 system. With the same pinning, on a 18-cores-per-socket Intel
platform, we have seen 20% improvment in a microbench that creates a
30-vCPU selftest KVM guest with 4GB memory, where each vCPU reads 4KB
pages in a fixed number of loops.

Signed-off-by: Libo Chen <libo.chen@oracle.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: a
Applying: sched/numa: Skip VMA scanning on memory pinned to one NUMA 
node via cpuset.mems
error: patch failed: kernel/sched/fair.c:3329
error: kernel/sched/fair.c: patch does not apply
Patch failed at 0001 sched/numa: Skip VMA scanning on memory pinned to 
one NUMA node via cpuset.mems


Regards,

Venkat.




