Return-Path: <cgroups+bounces-7305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79BA79576
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 20:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEAE3AD926
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5041DB346;
	Wed,  2 Apr 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLmQq/Dz"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648918A93F;
	Wed,  2 Apr 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619913; cv=none; b=TEqMZBpNvZ+y6BGb5j+t/QCq3anpyFgvopf51b0YiJNYsS2aPC9d8wuA79uILJUZaNMBQV+A+29zIamAcwzWdyBz453uI7OBJcBI9eT88UIxFtFX5TX1Vhttie20ApN5nIVTUxXl+SegAsPgeYWyCY3SFHxMAiMVGMcL1x1TaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619913; c=relaxed/simple;
	bh=IKFtIfujl6w1fXs8MvpVq7RHyw1mm7U9SCIeKJRjke8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEV8LvLKPLh1GkcuoxcPDbwPq5y8ULwdA9XxLscRkJDvgx6mOYFHMosV49kU5OVDDqZYokmck/iY8SwoV9GThLGusGun7zppIFJjj5wi0wmCPUQod+ik/aXpKqscJppAWchxKRJQqyKSPQXOxwT36uUIi2zbZpesvZur2wQC2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLmQq/Dz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532HC6LN020790;
	Wed, 2 Apr 2025 18:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=6bE4SBM+FwuyNcAR95oXFclKRAI6VKjLu495Gc/0C9Y=; b=WLmQq/DzMtt8
	DeYjBK+P+7MclC9GlMNDFjqCA8SZuLlb+Gv+d977CZdn/2aFXjv2tQFD6DmCNALj
	vs2nO+zSwuyZHurPSYz8Fa48DJcpLaROhqD4eLseQG3zpiB/OVM2QgvdTd2eh99U
	YiwB3PmHCZxBbTP19YRf8w7OqgGvnB3K94qVjSE09BnpyDVdy2zv9MlXN8PjZfxv
	BlIEPEFTP8sE+UBn5Dc+ouEngT0ZspSWHfcCn3QNF+Fhbr7saP8HExn6o7kkMMNX
	edBCuaPL4kqdkuKhpGfRihqn8XnTRwjOhc/3TTfr3Dz+PtCNNMK9MxCvuqmIbwNd
	sI7gRogJ/w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s9dx8g6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 18:51:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 532IlErc032276;
	Wed, 2 Apr 2025 18:51:03 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s9dx8g6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 18:51:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 532H8T9q001724;
	Wed, 2 Apr 2025 18:51:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45rddkygdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 18:51:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 532Ip1oj34341412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 18:51:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F6015805D;
	Wed,  2 Apr 2025 18:51:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C29A5805A;
	Wed,  2 Apr 2025 18:50:52 +0000 (GMT)
Received: from [9.43.25.190] (unknown [9.43.25.190])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 18:50:52 +0000 (GMT)
Message-ID: <44b7d213-cca6-45d6-a48a-a3f358e7bca3@linux.ibm.com>
Date: Thu, 3 Apr 2025 00:20:50 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task migration
 and swap
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Chen Yu <yu.chen.surf@foxmail.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20250402010611.3204674-1-yu.c.chen@intel.com
In-Reply-To: <20250402010611.3204674-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oJbx8o8m1fjFkfgZHqP3VfiVKjbV2RxB
X-Proofpoint-ORIG-GUID: KtlAFmNiB-Pr_cVYA3bnVU1pBGwJqN5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020118

Hi Chen Yu,

On 02/04/25 06:36, Chen Yu wrote:
> On system with NUMA balancing enabled, it is found that tracking
> the task activities due to NUMA balancing is helpful. NUMA balancing
> has two mechanisms for task migration: one is to migrate the task to
> an idle CPU in its preferred node, the other is to swap tasks on
> different nodes if they are on each other's preferred node.
> 
> The kernel already has NUMA page migration statistics in
> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched.
> but does not have statistics for task migration/swap.
> Add the task migration and swap count accordingly.
> 
> The following two new fields:
> 
> numa_task_migrated
> numa_task_swapped
> 
> will be displayed in both
> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched

I was able to see the fields and their corresponding values for schbench:

numa_task_swapped                            :                    2
numa_task_migrated                           :                    0
numa_task_swapped                            :                    1
numa_task_migrated                           :                    0
numa_task_swapped                            :                    0
numa_task_migrated                           :                    0
numa_task_swapped                            :                    1

Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

> Previous RFC version can be found here:
> https://lore.kernel.org/lkml/1847c5ef828ad4835a35e3a54b88d2e13bce0eea.1740483690.git.yu.c.chen@intel.com/
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> RFC->v1: Rename the nr_numa_task_migrated to
>          numa_task_migrated, and nr_numa_task_swapped
>          numa_task_swapped in /proc/{PID}/sched,
>          so both cgroup's memory.stat and task's
>          sched have the same field name.
> ---
>  include/linux/sched.h         |  4 ++++
>  include/linux/vm_event_item.h |  2 ++
>  kernel/sched/core.c           | 10 ++++++++--
>  kernel/sched/debug.c          |  4 ++++
>  mm/memcontrol.c               |  2 ++
>  mm/vmstat.c                   |  2 ++
>  6 files changed, 22 insertions(+), 2 deletions(-)

