Return-Path: <cgroups+bounces-7304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D040DA794D8
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 20:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67743B12E7
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD911C84B0;
	Wed,  2 Apr 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fXYwAevC"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFD198833;
	Wed,  2 Apr 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617394; cv=none; b=Jgj5kotkzroOSPKkHdUUXxfvqsyJsyupprfg4Pq5gQ1AjO+neW+2XsMyJeDEgdndDizf/oV5cKkUacIYGWgMDahCV9tqz70S5HW71m3SS/VQwHhI5WbPieVBTjF4vuO1Mmq4vQpziXSksZIiQ4J/fA3XzFoBo01AEIJ1g0dq0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617394; c=relaxed/simple;
	bh=f65h3x8TJOHM+wgZUWC5JhipIt6kWap9ovcSDDBoc/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueGD8zyuePxIKjUC4aMfJLT4eHJOeRLCGZvLq4pMyvhd/C7eLVb4k46mvI1Y9gJnWFVmGrn5EIkU66MwXdfGH11suMg2mLRJe5nW8m7O3nHhWVvo4SXC2+8sEnoNQ0n/8qmDg0BE3x9PB5nZe8VeqgMSWHAe372gzTeHbat0CnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fXYwAevC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532FvoZt012812;
	Wed, 2 Apr 2025 18:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aA9v9i
	J6a2hVg9DZITySaMpcxE/t1z/PL+NK1w4Gw8g=; b=fXYwAevCKqxcMZzMXYQWdq
	iGZF3pmOJgnd56Nr9vle6qP2caIdNfk0Ry1iSF4WRnNVFWq65oJBNhKoXlwoX5GE
	cbTCppRA60pVBqCbNGMpvB6oKoNU1ONG39kCEQGo6+snbI64Pz9vf7bS1WsjXcMt
	s7gdjVkxuH3B2Huv8wI6jWGbrbWzB3bybljiGapnvp6vcqYVQkQlGU4xL32JST+j
	d0PA4BLn8gXDPLOXm0Nz1D8K91Jy10znVzkx1z0J+S16+ClVpoWOLhUrgOrJQGVx
	ohlQhKVkVan1ucQEa09BiL2tpsigRvTzYOXvbTq8Yk2/UVCkQSIkj/cYdrevpr4Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s59fsrfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 18:09:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 532I0OWd024127;
	Wed, 2 Apr 2025 18:09:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s59fsrf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 18:09:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 532F8pQe019392;
	Wed, 2 Apr 2025 18:09:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6t9d2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 18:09:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 532I95FU20251310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 18:09:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E41358045;
	Wed,  2 Apr 2025 18:09:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 206BF58054;
	Wed,  2 Apr 2025 18:08:56 +0000 (GMT)
Received: from [9.43.25.190] (unknown [9.43.25.190])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 18:08:55 +0000 (GMT)
Message-ID: <31aa40f3-ca75-4e44-a1d0-e2ab3ce17fdd@linux.ibm.com>
Date: Wed, 2 Apr 2025 23:38:53 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task migration
 and swap
To: K Prateek Nayak <kprateek.nayak@amd.com>
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
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Chen Yu <yu.chen.surf@foxmail.com>, Chen Yu <yu.c.chen@intel.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
 <3ba327b9-3020-4a63-9623-e6eea0120056@linux.ibm.com>
 <57f5803b-11e5-4b91-a4c3-9be191fbf8d3@amd.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <57f5803b-11e5-4b91-a4c3-9be191fbf8d3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iFHp1aQm4i4tJ7SA8zFakuHytMi7uJEi
X-Proofpoint-GUID: jRBlImzhYTQzfiaN5MCscTxt7gqqyRPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020114

On 02/04/25 22:53, K Prateek Nayak wrote:
> On 4/2/2025 7:03 PM, Madadi Vineeth Reddy wrote:
>> Hi Chen Yu,
>>
>> On 02/04/25 06:36, Chen Yu wrote:
>>> On system with NUMA balancing enabled, it is found that tracking
>>> the task activities due to NUMA balancing is helpful. NUMA balancing
>>> has two mechanisms for task migration: one is to migrate the task to
>>> an idle CPU in its preferred node, the other is to swap tasks on
>>> different nodes if they are on each other's preferred node.
>>>
>>> The kernel already has NUMA page migration statistics in
>>> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched.
>>> but does not have statistics for task migration/swap.
>>> Add the task migration and swap count accordingly.
>>>
>>> The following two new fields:
>>>
>>> numa_task_migrated
>>> numa_task_swapped
>>>
>>> will be displayed in both
>>> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
>>
>> I applied this patch, but I still don't see the two new fields
>> in /proc/{PID}/sched.
>>
>> Am I missing any additional steps?
> 
> You also need to enable schedstats:
> 
> echo 1 > /proc/sys/kernel/sched_schedstats
> 
> After that it should be visible:

Thanks, Prateek! I had missed enabling schedstats. Now that it's enabled,
I can see the fields.

Thanks,
Madadi Vineeth Reddy 

> 
> $ cat /proc/4030/sched
> sched-messaging (4030, #threads: 641)
> -------------------------------------------------------------------
> se.exec_start                                :        283818.948537
> 
> ...
> 
> nr_forced_migrations                         :                    0
> numa_task_migrated                           :                    0
> numa_task_swapped                            :                    0
> nr_wakeups                                   :                    0
> 
> ...
> 


