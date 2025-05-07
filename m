Return-Path: <cgroups+bounces-8069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E44AAE326
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 16:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84ED1705CE
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB8279907;
	Wed,  7 May 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SLcmGi8b"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5B2147F8;
	Wed,  7 May 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628366; cv=none; b=AwaQMYwUQimp4cN+04Bnj+UE8u/sJEV/cWBuZZOy0HD6vsV5DxbmETpYRmOTwBkMVKK9dT0B7T6cLfPpmvLIWWd/HRdtR8hrfztz855pmYpzfIIh9ywGPW0GZMJ+oGV8V7JfQZtGJ1qqx4+TwWQEXQ8NviD3v/AUBtk6Ul9YSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628366; c=relaxed/simple;
	bh=k8VxWdT15ZCGUBD08umgsWJWBsYRFN1feRspCzB3m3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0aFWzYDOHU07YAglqSmC5HgOpOYvwAz7aM5dYkKGWEQMVsmXsnq9GEUHtLkdonzDQjDCW33XhDH+bTCVj89opFFUiRbZlb/SDKU77YkrDNa3aTqpY0lrGR+Y0oTyBxxJm6Nn5LLheja4deTIRnaaXDUc56bFen/iQ1IvAAMIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SLcmGi8b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54792K4t007062;
	Wed, 7 May 2025 14:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6NZBjr
	aWg04a3F3U6UoqxbFTAm5n2ZxQNrJCvMcoBnI=; b=SLcmGi8botoVhF9MGmYvpT
	7MDXgtLp8bGCHinPSM7vBDxrLShf8LMb3Dqd7a91BTNl97hXHjDZnatDk7UBmGvZ
	eOJQM72mBejoSPCvtZkB5N5Bhej2/CGcRjpc4EHfOo941JLxInbJpoiWmgAeIODs
	rJfC6NaWUPyz1jE+8XWRIp5o53tpYeHTX/d+/+Nl80msJtcUU8CUPKl98Y9Qw5AZ
	qKEncxoLs1Fzzggz5dMkRWPCvJZgg1oamLYSd2FuWHD32JZjcLoiN1QFvK/tRwDU
	9oCtoWxctR15SS0VzKYYjRpcX3k0NbOV3g6Ug38EPZQbfBqcSUJPrDSdIG5YS4tw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fth8c4aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 14:32:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 547ECkoV022517;
	Wed, 7 May 2025 14:32:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fth8c4ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 14:32:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547CpC3r004218;
	Wed, 7 May 2025 14:32:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb25sjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 14:32:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547EW8Zh29753872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 14:32:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE99A5805A;
	Wed,  7 May 2025 14:32:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848865805E;
	Wed,  7 May 2025 14:32:05 +0000 (GMT)
Received: from [9.61.241.123] (unknown [9.61.241.123])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 14:32:05 +0000 (GMT)
Message-ID: <363632bc-ce31-4a6d-8271-ecae6f6c2d0a@linux.ibm.com>
Date: Wed, 7 May 2025 20:02:03 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] sched/numa: add statistics of numa balance task
 migration
Content-Language: en-GB
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: mkoutny@suse.com, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Chen, Tim C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        Libo Chen <libo.chen@oracle.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        "Jain, Ayush"
 <ayushjai@amd.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@foxmail.com>
References: <cover.1746611892.git.yu.c.chen@intel.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <cover.1746611892.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8HlXnsLWlB6qXxzfDmY_XnfrvLAgCWNd
X-Proofpoint-ORIG-GUID: 2pmrzjyH8KKf9GP3Jq5PDuD73Gp3NIoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEzMyBTYWx0ZWRfX7sl4M65zR3sX m89ZBdpVkIiq9x25H/+3zgHzu0FrZsJLP8FKx1XSSh/XT6yuPJ7LFfYWLzRwd4iEsH65LfQjvKp cZbOcSACwGGtjb0p1mnfzI6d0wijK0+hkNQhEU+6MrsDnRJX22tmESZt35vXYOA6l5lrqNeOMNx
 2xko7ixhyPSkPzvQ3sv+PbJpHV/A2aSXVLkvskOr9yJa65g5KpSDQzuZWJ5YJKwz7FspxiAXRhL WsTr+I4Pkri7ZwN56ZtO5u2ab/MGaEgBdpijUQc9JTVJXcXLg+gbLlAJQ9Tg2H90VI0D4IH8DxP yCcOu2m+HunJvUUM0jo9cToksq8k2ayX4of0vA+tSYAY0DsFOdPHmfkLoYdoaHxsPop4wxM2p9r
 nebNTK/q0qpgk22b+tenFz9vLI321mnDa0TRsZ4cB1hI+JR8qwdTF0I+izC7Q1HmBT3qsHTt
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=681b6eee cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=iox4zFpeAAAA:8
 a=yPCof4ZbAAAA:8 a=IN_1ItaQYsxyJibhnwMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070133

Hello Chenyu,


On 07/05/25 4:44 pm, Chen Yu wrote:
> Introducing the task migration and swap statistics in the following places:
> /sys/fs/cgroup/{GROUP}/memory.stat
> /proc/{PID}/sched
> /proc/vmstat
>
> These statistics facilitate a rapid evaluation of the performance and resource
> utilization of the target workload.
>
> Patch 1 is a fix from Libo to avoid task swapping for kernel threads,
> because Numa balance only cares about the user pages via VMA.
>
> Patch 2 is the major change to expose the statistics of task migration and
> swapping in corresponding files.
>
> The reason to fold patch 1 and patch 2 into 1 patch set is that patch 1 is
> necessary for patch 2 to avoid accessing a NULL mm_struct from a kernel
> thread, which causes NULL pointer exception.
>
> The Tested-by and Acked-by tags are preserved, because these tags are provided
> in version 1 which has the p->mm check.

I see below tags from version 1 are missing. I think, its contridicting 
to the above line. Please correct me, If I am wrong.


Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

>
> Previous version:
> v3:
> https://lore.kernel.org/lkml/20250430103623.3349842-1-yu.c.chen@intel.com/
> v2:
> https://lore.kernel.org/lkml/20250408101444.192519-1-yu.c.chen@intel.com/
> v1:
> https://lore.kernel.org/lkml/20250402010611.3204674-1-yu.c.chen@intel.com/
>
> Chen Yu (1):
>    sched/numa: add statistics of numa balance task migration
>
> Libo Chen (1):
>    sched/numa: fix task swap by skipping kernel threads
>
>   Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>   include/linux/sched.h                   | 4 ++++
>   include/linux/vm_event_item.h           | 2 ++
>   kernel/sched/core.c                     | 9 +++++++--
>   kernel/sched/debug.c                    | 4 ++++
>   kernel/sched/fair.c                     | 3 ++-
>   mm/memcontrol.c                         | 2 ++
>   mm/vmstat.c                             | 2 ++
>   8 files changed, 29 insertions(+), 3 deletions(-)
>

For some reason, I am not able to apply this patch on top of 
next-20250506. I see patch002 fails to apply. Please find the errors below.


Also, I see tags are changed. Specially Tested-by


Errors:


b4 am cover.1746611892.git.yu.c.chen@intel.com
Grabbing thread from 
lore.kernel.org/all/cover.1746611892.git.yu.c.chen@intel.com/t.mbox.gz
Analyzing 3 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
   ✓ [PATCH v4 1/2] sched/numa: fix task swap by skipping kernel threads
   ✓ [PATCH v4 2/2] sched/numa: add statistics of numa balance task 
migration
   ---
   ✓ Signed: DKIM/intel.com
---
Total patches: 2
---
Cover: 
./v4_20250507_yu_c_chen_sched_numa_add_statistics_of_numa_balance_task_migration.cover
  Link: https://lore.kernel.org/r/cover.1746611892.git.yu.c.chen@intel.com
  Base: not specified
        git am 
./v4_20250507_yu_c_chen_sched_numa_add_statistics_of_numa_balance_task_migration.mbx

# git am -i 
v4_20250507_yu_c_chen_sched_numa_add_statistics_of_numa_balance_task_migration.mbx
Commit Body is:
--------------------------
sched/numa: fix task swap by skipping kernel threads

Task swapping is triggered when there are no idle CPUs in
task A's preferred node. In this case, the NUMA load balancer
chooses a task B on A's preferred node and swaps B with A. This
helps improve NUMA locality without introducing load imbalance
between nodes.

In the current implementation, B's NUMA node preference is not
mandatory, and it aims not to increase load imbalance. That is
to say, a kernel thread might be chosen as B. However, kernel
threads are not supposed to be covered by NUMA balancing because
NUMA balancing only considers user pages via VMAs.

Fix this by not considering kernel threads as swap targets in
task_numa_compare(). This can be extended beyond kernel threads
in the future by checking if a swap candidate has a valid NUMA
preference through checking the candidate's numa_preferred_nid
and numa_faults. For now, keep the code simple.

Suggested-by: Michal Koutny <mkoutny@suse.com>
Tested-by: Ayush Jain <Ayush.jain3@amd.com>
Signed-off-by: Libo Chen <libo.chen@oracle.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: a
Applying: sched/numa: fix task swap by skipping kernel threads
Applying: sched/numa: add statistics of numa balance task migration
error: patch failed: Documentation/admin-guide/cgroup-v2.rst:1670
error: Documentation/admin-guide/cgroup-v2.rst: patch does not apply
error: patch failed: include/linux/sched.h:549
error: include/linux/sched.h: patch does not apply
error: patch failed: include/linux/vm_event_item.h:66
error: include/linux/vm_event_item.h: patch does not apply
error: patch failed: kernel/sched/core.c:3352
error: kernel/sched/core.c: patch does not apply
error: patch failed: kernel/sched/debug.c:1206
error: kernel/sched/debug.c: patch does not apply
error: patch failed: mm/memcontrol.c:463
error: mm/memcontrol.c: patch does not apply
error: patch failed: mm/vmstat.c:1347
error: mm/vmstat.c: patch does not apply
Patch failed at 0002 sched/numa: add statistics of numa balance task 
migration



Am I missing anything? Please suggest.


Regards,

Venkat.


