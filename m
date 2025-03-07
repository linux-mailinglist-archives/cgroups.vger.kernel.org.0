Return-Path: <cgroups+bounces-6879-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD3DA561EE
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978BF175395
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 07:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8621A76AE;
	Fri,  7 Mar 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VghUAx6w"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5CE18B476;
	Fri,  7 Mar 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333249; cv=none; b=d3WmyTjPn+WWYKAclx4mvLlAkQECKGyPUFtt4ndb1AvEX9wRO4QGR23ACpohOcJ4krV4CSBMmn7OWk4vY1v65ucbgSOLDbe2v2c4lm0InqLt8rQq6hcS7ek6EngZMfymkM9CZdEu6yIQHHWPOBKGQgWUImu1Iclz0kYw4mtTmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333249; c=relaxed/simple;
	bh=lEHrRaSc6fn1g0LthjtcEDEbqyxHZLFiFYO6+pw4YFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhPyWYS92H74v5d9wEd9MCyxPitxIEfviVLyhCRM1Z4Rz663JmdU3joKriODzS0asqLI+hY/Uc3jzASej8NsaZrafy0JToQxeIbC7lK/cyZkcR+UckknuZDc6ki80GE+OwALZuD68kcpDTn2MBAwzJ3Xx60lATrwAodwf55U0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VghUAx6w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526KpePj011769;
	Fri, 7 Mar 2025 07:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Weyu1h
	EJixZ8+uWifCp9lRve1k9ujNyn1Q+HFpBBGnY=; b=VghUAx6woq3gE66mJVHmaa
	6nNQ6gxPDK4UJJ+15fRjIbx35OuvrUKTS3uJdfDMSDeh7ApCI+6mdWZUC+i63lNr
	kHt+/GduLoTfAjakg7T+myI5yKG+xC/mqDvNUl1I7CYBxmRtkQo1wDPrOaJitW4X
	u+HZrVRO77kXKa1nUzUKheJxSCJZSm9s94H1NxMuREYcHsl4YxVBtD2ZffLpbpAJ
	D65MSBUVwUHSA9UfFvrhZwWr+N4EWj+z/Wmpgy0A8ogL065ZeAd8eU+GHZiD5K5Y
	YzX8OrvKvA3IVLfDFc6n5eip9OQXc2RLp5c4TriqcMwmVrF8vfFfgb6LoVL/0GCg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45abe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 07:40:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5277eR8v024408;
	Fri, 7 Mar 2025 07:40:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45abe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 07:40:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527758ie020794;
	Fri, 7 Mar 2025 07:40:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454eskd58k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 07:40:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5277eOGg30409426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 07:40:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C42C12004B;
	Fri,  7 Mar 2025 07:40:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5724020040;
	Fri,  7 Mar 2025 07:40:20 +0000 (GMT)
Received: from [9.124.218.213] (unknown [9.124.218.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 07:40:20 +0000 (GMT)
Message-ID: <9dc616ee-ad2a-428f-ac26-f7a7280be439@linux.ibm.com>
Date: Fri, 7 Mar 2025 13:10:19 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,
        Qais Yousef <qyousef@layalina.io>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>, Phil Auld <pauld@redhat.com>,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        Jon Hunter <jonathanh@nvidia.com>, Waiman Long <llong@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-7-juri.lelli@redhat.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-7-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WERvGmOASmP6HG0VYgdFKGQJILFYTHu3
X-Proofpoint-GUID: yGUOaU7LWPK1oh7ZYqCwa72lE03Kuu6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_02,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070053



On 3/6/25 19:40, Juri Lelli wrote:
> partition_and_rebuild_sched_domains() and partition_sched_domains() are
> now equivalent.
> 
> Remove the former as a nice clean up.
> 
> Suggested-by: Waiman Long <llong@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f66b2aefdc04..7995cd58a01b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -993,15 +993,6 @@ void dl_rebuild_rd_accounting(void)
>   	rcu_read_unlock();
>   }
>   
> -static void
> -partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> -				    struct sched_domain_attr *dattr_new)
> -{
> -	sched_domains_mutex_lock();
> -	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	sched_domains_mutex_unlock();
> -}
> -
>   /*
>    * Rebuild scheduler domains.
>    *
> @@ -1063,7 +1054,7 @@ void rebuild_sched_domains_locked(void)
>   	ndoms = generate_sched_domains(&doms, &attr);
>   
>   	/* Have scheduler rebuild the domains */
> -	partition_and_rebuild_sched_domains(ndoms, doms, attr);
> +	partition_sched_domains(ndoms, doms, attr);
>   }
>   #else /* !CONFIG_SMP */
>   void rebuild_sched_domains_locked(void)

This makes sense.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

