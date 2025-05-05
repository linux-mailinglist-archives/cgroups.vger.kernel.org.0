Return-Path: <cgroups+bounces-8011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06908AA9A64
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 19:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A6417876A
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619A726B956;
	Mon,  5 May 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oVuI/wzo"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796084A1D;
	Mon,  5 May 2025 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465971; cv=none; b=Zm+vzOp+brhmTQkMjXsjpiSxnTHUxBYlLcD0VVgYQryLkVw8Q1VVA7nsTsraWj5WefVK/Axmy7QzYAYHVXzZ0EpuLaGTEgbIOjdRRJRnDgP5sbdhkQZciosLPVqQiFJDZ76kCq5QvPbR9yBztmFZwYkoJuVkvs4gJ+s5lvq/lC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465971; c=relaxed/simple;
	bh=df2D0g25+pzDypgDt0E0fAjhLcXWfS9sSBfJgg7RBJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDOQ7Gjy2dFAQ8Y+f95SEMwElnbqgKydsqVz3yyXgcYNu/iBXOnaRVTX55hpSW8hvgZZfOlf8oMNBIYyx1dGOiAiRKRbA43T0zwqqnqB0LiagTm6/9H/VDL6jsOWl9TyobrcUhHaFiY6iz67Xj67HjMDjvNNmSisb8jpWjI4TbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oVuI/wzo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545AfGTu010772;
	Mon, 5 May 2025 17:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hErttr
	kiur2MWnGZBWBCx9Pk/qU5FQtP8usbZpxIWBk=; b=oVuI/wzoHYYVZ7UOshWTJ4
	5dnMe/zeOQqEiuQSSUZeVNQcVixRX+B5Xg+M7NdSiTr71i3qV39qYXGPETgTaxya
	Rdqp4UviiGbpazRPNVtUCTbd4QOjyDxwPu63PZw5RrEAa1FhaPdUK9D2paOwu3JJ
	KHK2UkmP44QCgqZIZn95z4pg5t4YystABig3S5lbeZ6h90MrUN3ZHQ09boNMhv8c
	Inu+Oj7I+O6//FjWJ6NGDiaAyX7RoZiKreRTZrN2uyoS32is9uv33J42/jP2LIMb
	l6WbcMidypKxvvrTSHHEkbg3ZLDXTml1FvYcUdK67avMO7tJWJsv4+Vdr3bBPSNA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46eusrsw01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 17:25:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 545DZPC4014082;
	Mon, 5 May 2025 17:25:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkf2m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 17:25:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 545HPcNr30409288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 17:25:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 146E35805C;
	Mon,  5 May 2025 17:25:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2CF158061;
	Mon,  5 May 2025 17:25:29 +0000 (GMT)
Received: from [9.61.244.137] (unknown [9.61.244.137])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 May 2025 17:25:29 +0000 (GMT)
Message-ID: <e8916a76-61d3-4fb5-81ac-4597180f9078@linux.ibm.com>
Date: Mon, 5 May 2025 22:55:28 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
Content-Language: en-GB
To: "Chen, Yu C" <yu.c.chen@intel.com>, "Jain, Ayush" <ayushjai@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Michal Koutny <mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Chen, Tim C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        Libo Chen <libo.chen@oracle.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Neeraj.Upadhyay@amd.com,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qoipdVZaZz7nT96xSUl1qc8aL2V8KBQW
X-Authority-Analysis: v=2.4 cv=dMSmmPZb c=1 sm=1 tr=0 ts=6818f494 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KvdA8ODPaR-T82k_2AgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qoipdVZaZz7nT96xSUl1qc8aL2V8KBQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE2MiBTYWx0ZWRfXxlYdk0EnQEEu eL4fu+fCjITVHTBGGSQ9V/R93yl5wNuL6vS4lDZGgEt++m87yTmVkswA1G4IkslixerWxKLgDr/ U2lcsmLaKzYP/TSRLNP+4ADXdWTwuKBivcp5OKCBs46tsC69lhkG+P2xa3syhxtY/fwU4yrfPrH
 7wW2eyR3TA4FMENrRQo72LRSQpmEbTLlaPSgRLtCcV9IH+l2TICB/41o2FKVyRPRyAZmJpK5ES4 hge2qIH5fn44kvONKuC+PqvLJEROj7YY4/mnhqsDHmzMFC0BKyLbiTsE3vBo1UT9Xz3jujdkfAW I6/wd4JVAIMjKmuD4XqZBg7HX/GxxdfrL1j/ZVnGku6QbEVlAm5NNjUyT07UnW1ILoL0tTLPb9s
 j6n4i96G0ouzk/EytpA6b5J5QI9VZz6tmEgE4inOC8JDgmzzINBHuU9sReG74G7awKWwXD4E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050162


On 05/05/25 8:33 pm, Chen, Yu C wrote:
> On 5/5/2025 2:43 PM, Jain, Ayush wrote:
>>
>> Hello,
>>
>> Hitting Kernel Panic on latest-next while running rcutorture tests
>>
>> 37ff6e9a2ce3 ("Add linux-next specific files for 20250502")
>>
>> reverting this patch fixes it
>> 3b2339eeb032 
>> ("sched-numa-add-statistics-of-numa-balance-task-migration-v3")
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/sched/core.c?id=3b2339eeb032627e9329daf70a4ba8cd62c9cc8d 
>>
>>
>> by looking at RIP pointer
>>
>> $ ./scripts/faddr2line vmlinux __migrate_swap_task+0x2e/0x180
>> __migrate_swap_task+0x2e/0x180:
>> count_memcg_events_mm at include/linux/memcontrol.h:987
>> (inlined by) count_memcg_events_mm at include/linux/memcontrol.h:978
>> (inlined by) __migrate_swap_task at kernel/sched/core.c:3356
>>
>> memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
>> mm->owner -> NULL
>>
>> Attaching kernel logs below:
>>
>> [ 1070.635450] rcu-torture: rcu_torture_read_exit: End of episode
>> [ 1074.047617] BUG: kernel NULL pointer dereference, address:
>> 0000000000000498
>
> Thanks Ayush,
>
> According to this address,
>    4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>    49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
> It seems that this task to be swapped has NULL mm_struct.
>
> Does the following help?
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 96db6947bc92..0cb8cc4d551d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3353,7 +3353,8 @@ void set_task_cpu(struct task_struct *p, 
> unsigned int new_cpu)
>  static void __migrate_swap_task(struct task_struct *p, int cpu)
>  {
>         __schedstat_inc(p->stats.numa_task_swapped);
> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
> +       if (p->mm)
> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>
>         if (task_on_rq_queued(p)) {
>                 struct rq *src_rq, *dst_rq;
>

Hello Chenyu,


This issue is reported even on IBM Power servers.

Proposed fix works fine. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

>
>
> Hi Andrew,
> May I know if we can hold this patch and not merge it for now,
> besides this regression, Libo has another comment related to
> this patch and I'll address it in next version. Sorry for
> inconvenience.
>
> thanks,
> Chenyu
>

