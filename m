Return-Path: <cgroups+bounces-7297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3119A78FF5
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91317A576D
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C923C397;
	Wed,  2 Apr 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hQvSdOGQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1723A9B0;
	Wed,  2 Apr 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600902; cv=none; b=F5WA0t7Z6uTDaJf78Wjp7rcDZPDkxQ0ZZAcAUXtp4xUXeeKiAm5GX4IY7VcXLtlElqwF3adxq1/Mrn/xXmJipjWdkVVmpFkMXknTX9VjoGCbFU8tjTa7IdXR5sQ7gnPiBjv10abTPnoH8o4Xv+wpFkimzHpeG4JXuBaniMmuz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600902; c=relaxed/simple;
	bh=N/oBIehD8eRXwpCNk7k6ba24AxCMzaiO+1pmCM3xXfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdAQQegXawKHQOTdphj8EMMs2tRElm8v43WspLm3Fu5SJ2uTihT/PHkMUO/GXi7YSQfxPq7sauCCt2TxeC5kp3fUfjv1V3Mo/V7XxltearNA7iY+oPFH8DvzKWudz7UTC0ei74Jdz4IVCDrQ67p9jQwlZrylabnhgKyw3HmA18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hQvSdOGQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532A7cOn032720;
	Wed, 2 Apr 2025 13:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=WyEyXUzQBG5YYWYNGano5THo76MoLBzhRYTP61tbVHg=; b=hQvSdOGQLXH1
	biParECBb3mpF18P129RUrhEDgFDbZkodAxrPyaAahoufJkKahT8k3PqhYf7QpD+
	+jSjMh1XdxuugkDsx2OJOG6m1NPdPOcJLObyrOD7ZuyE5s0xut/HUd+tFqdD+vKr
	uepOc/HDhuNoYZNL3WAMiH5hVrwDvkObFtJXNYgEu657kE0xs/d1wo2qSR8y9LDH
	B5Zb+JtGKGgPgBUhNlFQdtcrJo8pT7lAUG1UUjWyIuLsd+/1Ysf/hSnSoOsI10XX
	XtsBq8g7Phj/GrERqKNjMN8LoSDyV0mSZsWJGswbmAgMEJpILisPF6zfWDCuaXIG
	yRTE4ngZGw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rwmaaua7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:34:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 532Cj0xn001558;
	Wed, 2 Apr 2025 13:34:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rwmaaua3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:34:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 532D34Uk010394;
	Wed, 2 Apr 2025 13:34:04 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6p0305-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:34:04 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 532DY3Br29819586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 13:34:03 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 613155805E;
	Wed,  2 Apr 2025 13:34:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8634B58056;
	Wed,  2 Apr 2025 13:33:55 +0000 (GMT)
Received: from [9.43.67.35] (unknown [9.43.67.35])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 13:33:55 +0000 (GMT)
Message-ID: <3ba327b9-3020-4a63-9623-e6eea0120056@linux.ibm.com>
Date: Wed, 2 Apr 2025 19:03:54 +0530
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
Reply-To: 20250402010611.3204674-1-yu.c.chen@intel.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250402010611.3204674-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HXJV5Q-jqXHxdR2AcOHw3yx69yUfEuGO
X-Proofpoint-ORIG-GUID: d9-NvWT-09rPiaSGGOiXdBzqDhqISW8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020085

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

I applied this patch, but I still don't see the two new fields
in /proc/{PID}/sched.

Am I missing any additional steps?

Thanks,
Madadi Vineeth Reddy

> 
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



