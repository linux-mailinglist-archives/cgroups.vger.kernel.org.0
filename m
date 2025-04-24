Return-Path: <cgroups+bounces-7793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92769A9A903
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF86A5A11DF
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18666221FC2;
	Thu, 24 Apr 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hpteiApT"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C519CC3D
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488048; cv=none; b=WCW700KkN4Qb4yo7RGPRJ7tUEi74pWS+e1LFck29bK5A+BQMitfDla2+2WfliBS7vcyJ4iOZZBSyjB75GwfhMrALLkKfBh5Tz5G1aG9XlSoDWt8bmNbgucRmThtXn15FNrpdTO2igXmyhiUmzpRvhB2GNd6ai73+Sjjq4sqp4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488048; c=relaxed/simple;
	bh=YMFPFKzryL1H/3CbvZ0JbH5Ng1veVuSEFY3R6OQP0gQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rAd44sYb42GrQjURn7PF9ka+MxOa84w3S2yAsCkZVmQkTKWzeieSt26hXf+glQ0efD6qxGYl1zJNBXyB05kaG2voA29Dvtm/wfI2y/ARt+mIIDG8Ok5hzixgEVoapcyx9GcViz7B7x1SwZORcCpKTdJOniuzowPY5CL7K1QAGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hpteiApT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O5YsnH011062
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 09:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jAGZPV
	5GPf63MJ6YElfBbgVWV3zhEIpXqeTLrKOPcJE=; b=hpteiApTcts/d8Nnqri+eI
	kU6SQL00VD73RV9XKhSUhMX71p1Hhu4m3FfaWUCIcSQelGTbdDZ9efTk6T/atR4c
	QIiWt2L8IYS9KWi2AFqSgF+q0bCFyjIZ5bMoOWNe0zhfXUmSTOEXIYpXkOBx/22i
	kWpfZe2RFiUJQM3kICdkyhXW8RgWRMXPcGFf+Fnftnj87N6f8lls5+P1U9fKWBZ2
	PFHF+xwaoj1Kj2ExES7Rv9uGNRuogwBBGgM2rkxfxTKnacx/RmFEsR2+QpPKzNe5
	xLDE80qXvLz/HTY7O8Rz35ThSrbAzqqBoUxIIIGYrnrdYHQpCnTblCNuvcWdajyw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466xns5mt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 09:47:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53O9eCdR021144
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 09:47:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466xns5msf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:47:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7WS7M005820;
	Thu, 24 Apr 2025 09:47:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxfj9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:47:23 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53O9lN6754788492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 09:47:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0478C58052;
	Thu, 24 Apr 2025 09:47:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2AD458056;
	Thu, 24 Apr 2025 09:47:14 +0000 (GMT)
Received: from [9.61.250.107] (unknown [9.61.250.107])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 09:47:14 +0000 (GMT)
Message-ID: <c6afc71d-3d8e-44d7-b4be-28f6a8c80f5d@linux.ibm.com>
Date: Thu, 24 Apr 2025 15:17:12 +0530
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
 <57892439-7683-43b7-9b03-4553737273b7@linux.ibm.com>
 <ec69adf2-4eb5-4e38-804f-804d1dde0e84@oracle.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <ec69adf2-4eb5-4e38-804f-804d1dde0e84@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KplN2XWN c=1 sm=1 tr=0 ts=680a08ac cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8
 a=fxiZjATdOysBrq0T-WwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2MyBTYWx0ZWRfX6EWw3cTiO79v sH4+lcBcU3Rv1irn+z5vTf0oCgmAYS6ELMDGvyjzOSO+fQMkc4NLnP9q622ADqs8eKkvFm2+Y5r 6ImhHxjbgabVzThwH4dAzYuPGh2xVOOn1QiBXb/+lnjjJB+uls8onqbj0GDRP4sa4ZzZFsQhdkc
 X4YLrCqIIEx7tylvwbQ5Bweyd41WEgIYnPvIbsE4rsfG9PQ/YUqAuqbZuXIwY4X0QgVQjanBGE4 NH5aszLe63IeBnMKy/2IBJ5U8PdIXM+6uKEnzLeXN4AYfxlbD3ftKbfgJcgr3i31tJXUdnFyRlK bqXioCm/qn3UJvjkCaI76FSReqevEbL+aZc+DamG8DV7NPyW59JpokAjP2WHRzsbfTfppcx07BG
 ypFpW5ps+T7Lbgi5zvzNCq6vTAZw8Frnx45+ipccjpMNkeuLX6NE+4yymGWC/idAvrBqDb3+
X-Proofpoint-ORIG-GUID: _vgw3Tamx6zPYA9tOBdtiHBAPreJuyTm
X-Proofpoint-GUID: _vgw3Tamx6zPYA9tOBdtiHBAPreJuyTm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=2 engine=8.19.0-2504070000
 definitions=main-2504240063


On 24/04/25 1:16 pm, Libo Chen wrote:
>
> On 4/24/25 00:05, Venkat Rao Bagalkote wrote:
>> On 24/04/25 8:15 am, Libo Chen wrote:
>>> v1->v2:
>>> 1. add perf improvment numbers in commit log. Yet to find perf diff on
>>> will-it-scale, so not included here. Plan to run more workloads.
>>> 2. add tracepoint.
>>> 3. To peterz's comment, this will make it impossible to attract tasks to
>>> those memory just like other VMA skippings. This is the current
>>> implementation, I think we can improve that in the future, but at the
>>> moment it's probabaly better to keep it consistent.
>>>
>>> v2->v3:
>>> 1. add enable_cpuset() based on Mel's suggestion but again I think it's
>>> redundant.
>>> 2. print out nodemask with %*p.. format in the tracepoint.
>>>
>>> v3->v4:
>>> 1. fix an unsafe dereference of a pointer to content not on ring buffer,
>>> namely mem_allowed_ptr in the tracepoint.
>>>
>>> v4->v5:
>>> 1. add BUILD_BUG_ON() in TP_fast_assign() to guard against future
>>> changes (particularly in size) in nodemask_t.
>>>
>>> Libo Chen (2):
>>>  =C2=A0=C2=A0 sched/numa: Skip VMA scanning on memory pinned to one NUM=
A node via
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 cpuset.mems
>>>  =C2=A0=C2=A0 sched/numa: Add tracepoint that tracks the skipping of nu=
ma balancing
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 due to cpuset memory pinning
>>>
>>>  =C2=A0 include/trace/events/sched.h | 33 +++++++++++++++++++++++++++++=
++++
>>>  =C2=A0 kernel/sched/fair.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 9 +++++++++
>>>  =C2=A0 2 files changed, 42 insertions(+)
>>>
>> Hello Libo,
>>
>>
>> For some reason I am not able to apply this patch. I am trying to test t=
he boot warning[1].
>>
>> I am trying to apply on top of next-20250423. Below is the error. Am I m=
issing anything?
>>
>> [1]: https://lore.kernel.org/all/20250422205740.02c4893a@canb.auug.org.a=
u/=20
>> Error:
>>
>> git am -i v5_20250423_libo_chen_sched_numa_skip_vma_scanning_on_memory_p=
inned_to_one_numa_node_via_cpuset_mems.mbx
>> Commit Body is:
>> --------------------------
>> sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpus=
et.mems
>>
>> When the memory of the current task is pinned to one NUMA node by cgroup,
>> there is no point in continuing the rest of VMA scanning and hinting page
>> faults as they will just be overhead. With this change, there will be no
>> more unnecessary PTE updates or page faults in this scenario.
>>
>> We have seen up to a 6x improvement on a typical java workload running on
>> VMs with memory and CPU pinned to one NUMA node via cpuset in a two-sock=
et
>> AARCH64 system. With the same pinning, on a 18-cores-per-socket Intel
>> platform, we have seen 20% improvment in a microbench that creates a
>> 30-vCPU selftest KVM guest with 4GB memory, where each vCPU reads 4KB
>> pages in a fixed number of loops.
>>
>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>> Tested-by: Chen Yu <yu.c.chen@intel.com>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> --------------------------
>> Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: a
>> Applying: sched/numa: Skip VMA scanning on memory pinned to one NUMA nod=
e via cpuset.mems
>> error: patch failed: kernel/sched/fair.c:3329
>> error: kernel/sched/fair.c: patch does not apply
>> Patch failed at 0001 sched/numa: Skip VMA scanning on memory pinned to o=
ne NUMA node via cpuset.mems
>>
>>
> Hi Venkat,
>
> I just did git am -i t.mbox on top of next-20250423, not sure why but the=
 second patch was ahead of the
> first patch in apply order, have you made sure the second patch was not a=
pplied before the first one?
>
> - Libo


Hi Libo,

Apolozies!!!

I freshly cloned and tried and it worked now. So, please ignore my=20
earlier mail.


Regards,

Venkat.

>> Regards,
>>
>> Venkat.
>>
>>
>>
>

