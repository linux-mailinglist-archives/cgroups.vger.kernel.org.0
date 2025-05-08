Return-Path: <cgroups+bounces-8083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B656DAAF7BC
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 12:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F953B8F8A
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C71F5842;
	Thu,  8 May 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PAVyO1Se"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAF4B1E5C;
	Thu,  8 May 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746699836; cv=none; b=mQv+fqmT9DxxlL506MqGBJlCX0nW95RKAJoY8/+CrNH9Gf6JL92XiCy/SJwQiZBLnhlpYifIuc9ZUeVIWxzbeJ5LXDUI8/1cRUlyIa1cmd31b+sdrqECc6mBzlPGcWnOkSiEfE9cT7FL1HzutA0I+SpV47l88pkYUHeRqIVL6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746699836; c=relaxed/simple;
	bh=2f0mvTJEsrACt8quasR6thVFstOBAEpqA/Tci+hgnMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QU0LJnqVfZqwZIMW2dw5OWwd7lJIgjmu1EE9IrGVU0pYl8Na20+faaaW5oFfbxqH6IHEXe2XNGlOKfyM6Tcbx5Pcg/6y+woUFdN5YoFDGBEpKljqICM2Wi5brr95ra4UiNXBpi0/HngmlBN6BafGWNdwTYrc8ngRN9EjRu6aUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PAVyO1Se; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548A43jV025848;
	Thu, 8 May 2025 10:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H00vuM
	+tgDBxnpR/swy6rHp8vZCovIIANLLfbL4mFfg=; b=PAVyO1SeTIsl3GdOnOm/NR
	5Cqi3Fesp/Xj7N2FxsCX1QAyGwdAQguw6MkIZxV7a5lIcku+9zmxSAmPE9ZQhV8B
	7hqAvGt/NbmQ51yZDdxiR1OiAuk+V5jypEDmE0a8uq/Yn5cKDZukAi7Ho0X0Auva
	bBVbR6pF02QtcwKs/SrNRmve+ud69rQERhFoGLL62zkc9niI0pKtQzOFwZTWqMta
	HkCpOwvopomZJ/v8CS3HzZi3yR6LKJOMd4qJO+OkHLMyCgqxYIMK1V1q2QhVEcnI
	MVNdvriyuXrUsJ8xXSHXcwCX14UHmoFzMhzFyQcTIz7JxoEkb24tctXHbTChc7yA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthk82cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 10:23:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 548AJg3s026411;
	Thu, 8 May 2025 10:23:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthk82cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 10:23:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5486FW2q014097;
	Thu, 8 May 2025 10:23:18 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkw244-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 10:23:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548ANHtO27394362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 10:23:17 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 312855805E;
	Thu,  8 May 2025 10:23:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9346058043;
	Thu,  8 May 2025 10:23:10 +0000 (GMT)
Received: from [9.61.251.83] (unknown [9.61.251.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 10:23:10 +0000 (GMT)
Message-ID: <42d27ed9-79a1-4bf9-863f-c5b37b11d788@linux.ibm.com>
Date: Thu, 8 May 2025 15:53:09 +0530
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
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5MCBTYWx0ZWRfX5SGxSMFzUOkB c+UFIP70izFbfOYXLUQyXScRBBOk+FaRJSSKwaHb+hSXJ3W4eThsylwwh9pnFCNJZa/jCULRx9U xvAK58Q8UrBWwNGXNcKtXvv6nDd6P0ze7a/OaZuRcWJkNOlA8zWbn4IrqsllfzA4M50bInUQ33X
 tezCawtslIpqATQ1ldqWcBudxOQ6ffAl9/EkR7K36dIN6nCpEzJZ+uXC6AKUzSLLxeZvybiGVi7 H+mq9+5PYL9JUQ1v0gusiUe10GrVR9CA4Go0UhW3EI3awsOl+sHtfpa4cYDPO8PNAPk62vtGq4v vTCY/83p4rGT9Ja+qA7ErOFTI3ifSYIm2XXUQmIt1DXmwhi3KQR1wHMwdsY7XvT6DnjY42NHQVK
 4kMzP+OJcOYcmgPebbUcFZWrBj5tprXGhfdcoIgDxhFIK1ZmIkiPLmHeil5mibdZgaBKmTcO
X-Proofpoint-ORIG-GUID: PxA9fP8T5AL5C5S9PqO5jUmWfMGLo1o6
X-Authority-Analysis: v=2.4 cv=PvCTbxM3 c=1 sm=1 tr=0 ts=681c8618 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=JiD3ZO9WovdKvrj-Rh4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: m2MI3B0EcqvE91UIA-oV1JnGjbDA2EiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080090


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

Hello Chenyu,


Tested this patch by applying on top of next-20250507, and it fixes the 
NULL pointer exception error on IBM Power9 system. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.


