Return-Path: <cgroups+bounces-8071-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E71AAE4DB
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 17:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEA2188C205
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728EE28AAE9;
	Wed,  7 May 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ox9dtVa4"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1C28A40A;
	Wed,  7 May 2025 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631744; cv=none; b=B5aw58/ttpaVBDptWzLVubELnY/BdP/Y8UdquNUhio2FEX1Iz2xW+GuTkcyTCdDfV0a7mU0wq984SEvv2GgDBrqeRZn50zRc1saMTQHqW+/gX2TFjvko2B2HCW9Tm+btpQOXPAzebCbaaFMD2cziJRm7vUn0g9K8eZb3OUVi4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631744; c=relaxed/simple;
	bh=9LRAMcBN26c2uDe55In7inkisD5iByxob2dso7OqTjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as1iLMNs/gf5+ILfexFdpgL1GHRTZvwPNDso1h1m1WqilIHMazkt0LtIK9sDvgBGTSYgsECXYGeg1za2Icf89/ehHWVnBGjWqjFHrrBlvr36Uaf6sbyKjq18Q8hJDLaIsv/9BKXgJRnJjrCMbNKAqRmToThKNxRGCHT366tjERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ox9dtVa4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547AfGrY032104;
	Wed, 7 May 2025 15:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NNi1XU
	SXtf55iTgGz1muDN2xXiRwxJp0klNS1lsUg/I=; b=ox9dtVa4AgnDxE78PN86fY
	4yEk4wW0dG6o1tMUuPCyR1cJ7wXDx8OzPcvj21xKSD8na92335yutQLgLIeMiSEr
	MDUWluL15DKy1lYbkXMfWm7Jm39hiJFj2fjR2xgp93+jj7YZg7QlgsYhLF1XIAzx
	2VsJrWxciupQhRUZDTwucIOsmETUe/3qGziwbjPVisRYBcWlC5fT6xGKjZjselsx
	lGWa5/vEdq3rzZyfL646H/ezkYS0jtSLEjAZwJCXg2qbovIgjaSJQZgiLHCXYZ1z
	oKnC7zqR7vXG36YLv4Csv6Q5pTNtjuPQsnXmAvqpleRi6r+aycZXnUSBqZaHbsuw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46g5yrsj85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 15:28:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 547FMpRN002913;
	Wed, 7 May 2025 15:28:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46g5yrsj80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 15:28:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547E4vJT014583;
	Wed, 7 May 2025 15:28:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypks4nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 15:28:28 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547FSSdT24773288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 15:28:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05A6058051;
	Wed,  7 May 2025 15:28:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D035805A;
	Wed,  7 May 2025 15:28:20 +0000 (GMT)
Received: from [9.61.241.123] (unknown [9.61.241.123])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 15:28:20 +0000 (GMT)
Message-ID: <2648c494-8eff-4841-b942-4f538f1f5eca@linux.ibm.com>
Date: Wed, 7 May 2025 20:58:18 +0530
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
To: "Chen, Yu C" <yu.c.chen@intel.com>
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
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1746611892.git.yu.c.chen@intel.com>
 <363632bc-ce31-4a6d-8271-ecae6f6c2d0a@linux.ibm.com>
 <c4757667-6d6a-4010-80c5-f5203630557a@intel.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <c4757667-6d6a-4010-80c5-f5203630557a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cuybk04i c=1 sm=1 tr=0 ts=681b7c1e cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=5hPzrwBVPW74md0RgpEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1kUnbGk__TJ7w150l1Ieo15RTM0521r5
X-Proofpoint-ORIG-GUID: oll6XN-rVZ_skXEdZd5A6C0-UAYqZ3Zx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0MiBTYWx0ZWRfXyd3R3iN8Gagu y56PA6v0d9L2eLSiSmUegspAHgRopboKEIyjaQRsJFTWMZVG1uHoIeKZKcrNLxa3fmprJYJ6UPs ibO4EUiZmiegQMV6sJoG9B26NakxwFcpBlwzmDHGiKBe+9Rd8YHuALU83RuPLevM4QbAbh3iahh
 VY0Z5Aaqvya2pC16Bzy3/ZWG7A7M0QYi0m+TvyIEMxKUIOlL/lM04EDwxAPBoxhJkT0kdmyQT5J C/QzPCBrh8xpMmnlDj+aThrXpMx3IpkjdMLiJUdGmh1me3d3DoM32+ca/RaUcYXCFadsYCx+7t9 3c4kBOZ5w96JNxrR5zH2QRO9v7TfPfvhJ17T6iFKpjGoCLFed7ODNrQ5XtzZ30ZNONuUEuQgQ6A
 33dwIBsq/HsBc8FUkIFM7krgnqNknrlgBGQvpx52CmmLzLkkBiYba5UmaQF7qZUWCPrHk+lD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070142


On 07/05/25 8:22 pm, Chen, Yu C wrote:
> Hi Venkat,
>
> On 5/7/2025 10:32 PM, Venkat Rao Bagalkote wrote:
>> Hello Chenyu,
>>
>>
>> On 07/05/25 4:44 pm, Chen Yu wrote:
>>> Introducing the task migration and swap statistics in the following 
>>> places:
>>> /sys/fs/cgroup/{GROUP}/memory.stat
>>> /proc/{PID}/sched
>>> /proc/vmstat
>>>
>>> These statistics facilitate a rapid evaluation of the performance 
>>> and resource
>>> utilization of the target workload.
>>>
>>> Patch 1 is a fix from Libo to avoid task swapping for kernel threads,
>>> because Numa balance only cares about the user pages via VMA.
>>>
>>> Patch 2 is the major change to expose the statistics of task 
>>> migration and
>>> swapping in corresponding files.
>>>
>>> The reason to fold patch 1 and patch 2 into 1 patch set is that 
>>> patch 1 is
>>> necessary for patch 2 to avoid accessing a NULL mm_struct from a kernel
>>> thread, which causes NULL pointer exception.
>>>
>>> The Tested-by and Acked-by tags are preserved, because these tags 
>>> are provided
>>> in version 1 which has the p->mm check.
>>
>> I see below tags from version 1 are missing. I think, its 
>> contridicting to the above line. Please correct me, If I am wrong.
>>
>>
>> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>
>
> These tags are in the patch 2/2, because Madadi and Prateek mainly
> tested patch 2/2.


Understood. Thanks for clarification.

>
>>
>> For some reason, I am not able to apply this patch on top of 
>> next-20250506. I see patch002 fails to apply. Please find the errors 
>> below.
>>
>
> next-20250507 should be OK(I just checked on top of commit 08710e696081).
> next-20250506 might still have the old patch 2/2, and next-20250507 has
> reverted it.
>
With next-20250507, there is a build issue [1] 
<https://lore.kernel.org/all/1bcc235f-b139-4423-a7bd-2dd16065e08c@linux.ibm.com/> 
, I will test this, once the build issue fixed.


Regards,

Venkat.

> thanks,
> Chenyu

