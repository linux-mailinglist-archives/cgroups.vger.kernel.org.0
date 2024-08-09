Return-Path: <cgroups+bounces-4186-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31F94D6B8
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 20:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3446F282936
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291791607A8;
	Fri,  9 Aug 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I2+FqQRz"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580C15F40A;
	Fri,  9 Aug 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229620; cv=none; b=rIp49RfR23/EBTsQKlDA8MPpgps8A7o9pnVT4mHL1sUVsfhYnAsvRtENn8HGeYSaUwJQ+j98xJQ5mWlXqCGXVrj9oOHXUeSfQQ7j5NYNn6mqlQ3tAmPCrLhCL0rC2DoA1bAWiYnENP8Q513FlldqMX7lwuQt4ZRJVOoPzY77Shs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229620; c=relaxed/simple;
	bh=/dHohhjd6mqlamUXfVgbOAeseXKkRFzIWn0NkexjeWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ1RNHvFTLqM1L8aP0q0MBmuXXNV0lKjyCuDBiKd4/sL6HfrC9rxiRssRHZlRo14xdIVCiRXYAkavxr/R/LiyOE0GQ32M8IjegS4gK15EyuWtgjRUEnvR1Xbpe9LhpuIKFkRZKs2zwp6F4UECd1wmAR7+ONhRZQjLASjWQpMkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I2+FqQRz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479IXdwH010358;
	Fri, 9 Aug 2024 18:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=b
	mEjRON3V05lDNcx6eATNnufsLS6Cq7LkG7wr3fR8CY=; b=I2+FqQRzNFievgARW
	VpRgqdgGlgm8Pub96+nNNaw3tTkHv/XATg9A2wh6qCN4yHEEyWGa+JQvDl74FnT/
	XX3yc0nfp9bSoSti26ZtL/NVB7aTEAs5WqwsFO4tLE3nf0YsYXKe0kksinbUF9Y/
	u9+DIWNV6TpbKwETBT6RufKKm3V/xWeAmiWuCOWUlAny/x07AQn6eIq/HBGKvznb
	+U4RfiGg536Fxk5o+0xGm4xC7or2zXuKJOqqrqfCerTi1FlCwvosz4vVT1lHvPaX
	oWcnivpc35RQzMlynLEjvphuF9quEDW+Ip9ZEmoUKciAzYAs1P/G2Mnfv9Vv+eW5
	ALhFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wrgg81a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 18:53:10 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 479Ir9xV012702;
	Fri, 9 Aug 2024 18:53:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wrgg81a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 18:53:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 479IoHCi024361;
	Fri, 9 Aug 2024 18:53:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy91558d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 18:53:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 479Ir4j745875536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 18:53:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBB3920043;
	Fri,  9 Aug 2024 18:53:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DA7920040;
	Fri,  9 Aug 2024 18:53:01 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.65.191])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Aug 2024 18:53:00 +0000 (GMT)
Date: Sat, 10 Aug 2024 00:21:43 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
        sergeh@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: Do not clear xcpus when clearing
 cpus
Message-ID: <ZrZlP//QMWFEV6gJ@linux.ibm.com>
References: <20240731092102.2369580-1-chenridong@huawei.com>
 <6a79b50a-ad74-4b1b-a98c-7da8ef341b24@redhat.com>
 <a3cee760-398f-4661-b4b5-f2fcfd5de7b7@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3cee760-398f-4661-b4b5-f2fcfd5de7b7@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uL465YgwusuPMStJhZi5zVRPI9YVTvU4
X-Proofpoint-ORIG-GUID: S17c7uSdwnOz9iIQFyQjuFH7szQHnfkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_14,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=983 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090134

On Thu, Aug 01, 2024 at 12:31:44PM -0400, Waiman Long wrote:
> 
> On 7/31/24 23:22, Waiman Long wrote:
> > On 7/31/24 05:21, Chen Ridong wrote:
> > > After commit 737bb142a00d ("cgroup/cpuset: Make cpuset.cpus.exclusive
> > > independent of cpuset.cpus"), cpuset.cpus.exclusive and cpuset.cpus
> > > became independent. However we found that
> > > cpuset.cpus.exclusive.effective
> > > is cleared when cpuset.cpus is clear. To fix this issue, just remove
> > > xcpus
> > > clearing when cpuset.cpus is being cleared.
> > > 
> > > It can be reproduced as below:
> > > cd /sys/fs/cgroup/
> > > mkdir test
> > > echo +cpuset > cgroup.subtree_control
> > > cd test
> > > echo 3 > cpuset.cpus.exclusive
> > > cat cpuset.cpus.exclusive.effective
> > > 3
> > > echo > cpuset.cpus
> > > cat cpuset.cpus.exclusive.effective // was cleared
> > > 
> > > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> > > ---
> > >   kernel/cgroup/cpuset.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > index a9b6d56eeffa..248c39bebbe9 100644
> > > --- a/kernel/cgroup/cpuset.c
> > > +++ b/kernel/cgroup/cpuset.c
> > > @@ -2523,10 +2523,9 @@ static int update_cpumask(struct cpuset *cs,
> > > struct cpuset *trialcs,
> > >        * that parsing.  The validate_change() call ensures that cpusets
> > >        * with tasks have cpus.
> > >        */
> > > -    if (!*buf) {
> > > +    if (!*buf)
> > >           cpumask_clear(trialcs->cpus_allowed);
> > > -        cpumask_clear(trialcs->effective_xcpus);
> > > -    } else {
> > > +    else {
> > >           retval = cpulist_parse(buf, trialcs->cpus_allowed);
> > >           if (retval < 0)
> > >               return retval;
> > 
> > Yes, that is a corner case bug that has not been properly handled.
> > 
> > Reviewed-by: Waiman Long <longman@redhat.com>
> > 
> With a second thought, I think we should keep the clearing of
> effective_xcpus if exclusive_cpus is empty. IOW
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6ba8313f1fc3..2023cd68d9bc 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2516,7 +2516,8 @@ static int update_cpumask(struct cpuset *cs, struct
> cpuset *trialcs,
>          */
>         if (!*buf) {
>                 cpumask_clear(trialcs->cpus_allowed);
> -               cpumask_clear(trialcs->effective_xcpus);
> +               if (cpumask_empty(trialcs->exclusive_cpus))
> + cpumask_clear(trialcs->effective_xcpus);
>         } else {
>                 retval = cpulist_parse(buf, trialcs->cpus_allowed);
>                 if (retval < 0)
> 
> Thanks,
> Longman
> 
Hi Longman,

Is there any situation in which we could land here for or after clearing 
exclusive_cpus. AFAIK only way we could landup after clearing exclusive_cpus 
to update_exclusive_cpumask(), which anyway clears effective_xcpus. 
In that case, clearing effective_xcpus would be redundant in update_cpumask().


Also, is there any situation in which we could end up clearing exclusive_cpus
without clearing effective_xcpus as we have a piece of code:

	static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
	{
		return !cpumask_empty(cs->exclusive_cpus) ? cs->exclusive_cpus :
	       	cpumask_empty(cs->effective_xcpus) ? cs->cpus_allowed
						  : cs->effective_xcpus;
	}

Thanks,
Saket

