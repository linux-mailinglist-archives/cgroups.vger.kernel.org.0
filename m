Return-Path: <cgroups+bounces-4350-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEA95722B
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 19:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF62B21E7C
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7517C98C;
	Mon, 19 Aug 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lLQ+zNlP"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6617BB13;
	Mon, 19 Aug 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088314; cv=none; b=FmoWavYpON+6JgJiKOtZUqU7oAIOvXxZbIPfbaTU+fvxGaIdF14TU1LYS70Y943s1wsVaIp7dv69ubd0MHjGq+cyY3C6wuLwV2QdskRS4oWYz+rDQaxOu2ZucpLrb7MKkHoSOtnwHO4HFbcDf5KVyvxl9v88ZWq8y4r8mDYY8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088314; c=relaxed/simple;
	bh=YR3vah68BeAj6BLnmibK2XWflbsD1C4aZdVa8NQqVbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9kgsvvEWHDZ5fFGmPpbzjJ9BBMMFb6174OEGxSwbBDSp6VTr56DIcnuhXCGskOOIZ7qI/EuSIqVKY5YIhsxeykDI0Qv5BRR4FHDop3o6eTdv2MH4m0MHl+dnNnQ2BWQ68Kse/rQSwOCZ6cdZ/8Ol+52FgrIotZQp1ELvg3MWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lLQ+zNlP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JApCwJ018823;
	Mon, 19 Aug 2024 17:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=VVYxIrjngEk4ZgfsSbP7xpbroYZ
	QHiKTEwN3JYMXipk=; b=lLQ+zNlPI9CLehHDMWX+ExJJvrpHsV9v1fvDELj9ezW
	mRKpENp+/EBhJXFyeLZ4ZzWvDcBNMB679nwlDxzs6FmLlzfZ2Xobus8lWFyP9W0+
	m/o6SB+DMFlbf0Y9Zc80a5alK2cvG0dn2pmTplHNjhPMyaK57njF1xMqw2mYQQ9E
	J/ir7Yv8njNNOCXwCwwkDdmRYLx9889d3/PftCiO21HqJ8dMrbMG8PWlsDUGqSYY
	h8HO8tLcXCF3Y9bI6wKQ41gx6eOUOUo9RJ7AGmAVnLBQb/yUmf5F2wxDydCUvN10
	WtyxQBasiwUkPEyOt3R1itMw0T4RJ5ip3HCE+sZqgSw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfsf7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 17:24:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JHOofD025562;
	Mon, 19 Aug 2024 17:24:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfsf7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 17:24:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JGQmh0002244;
	Mon, 19 Aug 2024 17:24:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0f99n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 17:24:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JHOkN550594144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 17:24:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE94920073;
	Mon, 19 Aug 2024 17:24:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B8DD2006C;
	Mon, 19 Aug 2024 17:24:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.106.215])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Aug 2024 17:24:42 +0000 (GMT)
Date: Mon, 19 Aug 2024 22:54:40 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        longman@redhat.com, adityakali@google.com, sergeh@kernel.org,
        mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/3] cgroup/cpuset: remove fetch_xcpus
Message-ID: <ZsN/2DBi3CyW9gis@linux.ibm.com>
References: <20240816082727.2779-1-chenridong@huawei.com>
 <20240816082727.2779-3-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816082727.2779-3-chenridong@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yD98jA_hyBiZua8Y8nC7KXZDuZ47mvl_
X-Proofpoint-ORIG-GUID: 0H6KXeBmubME5fDLzj2W09bLM4ipCMk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxlogscore=632 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190114

On Fri, Aug 16, 2024 at 08:27:26AM +0000, Chen Ridong wrote:
> Both fetch_xcpus and user_xcpus functions are used to retrieve the value
> of exclusive_cpus. If exclusive_cpus is not set, cpus_allowed is the
> implicit value used as exclusive in a local partition. I can not imagine
> a scenario where effective_xcpus is not empty when exclusive_cpus is
> empty. Therefore, I suggest removing the fetch_xcpus function.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index fdd5346616d3..8be0259065f5 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -771,13 +771,6 @@ static inline bool xcpus_empty(struct cpuset *cs)
>  	       cpumask_empty(cs->exclusive_cpus);
>  }
>  
> -static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
> -{
> -	return !cpumask_empty(cs->exclusive_cpus) ? cs->exclusive_cpus :
> -	       cpumask_empty(cs->effective_xcpus) ? cs->cpus_allowed
> -						  : cs->effective_xcpus;
> -}
> -
>  /*
>   * cpusets_are_exclusive() - check if two cpusets are exclusive
>   *
> @@ -785,8 +778,8 @@ static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
>   */
>  static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>  {
> -	struct cpumask *xcpus1 = fetch_xcpus(cs1);
> -	struct cpumask *xcpus2 = fetch_xcpus(cs2);
> +	struct cpumask *xcpus1 = user_xcpus(cs1);
> +	struct cpumask *xcpus2 = user_xcpus(cs2);
>  
>  	if (cpumask_intersects(xcpus1, xcpus2))
>  		return false;
> @@ -2585,7 +2578,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>  		invalidate = true;
>  		rcu_read_lock();
>  		cpuset_for_each_child(cp, css, parent) {
> -			struct cpumask *xcpus = fetch_xcpus(trialcs);
> +			struct cpumask *xcpus = user_xcpus(trialcs);
>  
>  			if (is_partition_valid(cp) &&
>  			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
> -- 
> 2.34.1
> 

Hi,

In update_cpumask too fetch_xcpus is used. You may want to remove it from there too.

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 40ec4abaf440..1b4ee6403de6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2587,7 +2587,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
                invalidate = true;
                rcu_read_lock();
                cpuset_for_each_child(cp, css, parent) {
-                       struct cpumask *xcpus = fetch_xcpus(trialcs);
+                       struct cpumask *xcpus = user_xcpus(trialcs);

                        if (is_partition_valid(cp) &&
                            cpumask_intersects(xcpus, cp->effective_xcpus)) {


Reviewed-by: Saket Kumar Bhaskar <skb99@linux.ibm.com> 

Thanks,
Saket

