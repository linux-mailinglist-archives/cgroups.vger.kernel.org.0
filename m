Return-Path: <cgroups+bounces-10572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D340BC02E7
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 07:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47AC04F2DF4
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 05:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715AF1DED52;
	Tue,  7 Oct 2025 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dxzAiwBk"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4D4C6C;
	Tue,  7 Oct 2025 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759814011; cv=none; b=WeSUkJSMFEWOu6MKj6CbQwWHzwCqCe2R8G0QjgJl5QNmdYxjhYG2hbSL6NGQvzOgcYxxsl1o9RYmz6IouzUVp8ZUAoAKNeh228A/wc7CJKY7ELDGikC18Ga1YfJvnT1hCS9Oujw4B/7dcIs5Qn/fhLgO23Nn7Reo7OpAyG8y8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759814011; c=relaxed/simple;
	bh=8jMOyjPcJW5s0EO4a4tzQbHaQlEKwAsbkBUuQ52Z2L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0DR0TEOv4WpLSNo57KL2k++mEDAr9Hb1bt3GD0m35oPKrU4HRU0Y8ErKz4A0LevvvXsS/gNL/iDp+t0u48mO8TAdR2CvtcntlBfVv+a7KECcTG4DwxgfmunU9VvEAlhSzn6GlmajoaR0sE4Ngwmb6QE4f+Y7tOYepm5Y5StRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dxzAiwBk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596KJBxc002750;
	Tue, 7 Oct 2025 05:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XVq5AB
	Kv33NUVY4bWap2D/BLFM1M8DnbRXmDWdd32HI=; b=dxzAiwBkqcA1o5kDRORsEL
	Af6dP78M1li9Jc4I9YJKSI04DfkiWp/iiqKgkXaQ5QnCx53wMTJsHHxq9rT8TqQx
	oHBoLldTak8PVZ5O3BSih/O8exfjLZLxvqTWwYS/MVqCH6lzmKMoel8Vo0020/33
	CnQV8qCE1kUFh5KOQv2QOhCQADMRy9nmbPvfmo7qzAH3/hTNBRBJzoqZuLewwBJd
	WGYne6BUnfWRzzx5V57JY/oEyy6qgaIyb3/xESooys7AruFjX8lSi6fWn5vSfENm
	E27Tpcm2brcPjII68HxANAFx7oR214e+xDcNrfXcpR6dNBzUXPGEpXexyt0RA8uQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49js0scwx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:12:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59755rBY025638;
	Tue, 7 Oct 2025 05:12:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49js0scwx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:12:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5974tc8C000882;
	Tue, 7 Oct 2025 05:12:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ke9y1s34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:12:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5975CZ7S45744420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 05:12:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5946320040;
	Tue,  7 Oct 2025 05:12:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D04A220043;
	Tue,  7 Oct 2025 05:12:30 +0000 (GMT)
Received: from [9.39.21.122] (unknown [9.39.21.122])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Oct 2025 05:12:30 +0000 (GMT)
Message-ID: <2b37d74f-7a5d-486b-98df-679bd7e2b0c2@linux.ibm.com>
Date: Tue, 7 Oct 2025 10:42:29 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] sched: Employ sched_change guards
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
        mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
        changwoo@igalia.com, cgroups@vger.kernel.org,
        sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
        tj@kernel.org
References: <20250910154409.446470175@infradead.org>
 <20250910155808.415580225@infradead.org>
 <fee0edd5-86d1-4dff-9e07-70fd2208b073@linux.ibm.com>
 <20251006181429.GV3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251006181429.GV3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e4a147 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=qX6ajofIpXMs4fIIw1kA:9
 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: cAqOOaCKutzRGHdSxvZApmpDB_dpjxLd
X-Proofpoint-ORIG-GUID: euvDvoERsB13dXaex28twqgFbv7-s7Ba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDIwMSBTYWx0ZWRfX32bytjmGzGCV
 UjpUqZMEWxRLOY1FL939p/tPFpycFWvvjDJDzsR4KycttyTHbQYa4OoMvsQMOs7zBuM9nitRwQs
 PT1t1OhhYoQzFgug9w9SWc6CaoCha8EBxdz0Cqf7tcSENBQJcR1kw/JujHtem1EkfKL/3XRQPCg
 kBRssF+nr52FI08nuAvCvqSfhz8UUwR9syE+4nUKmFGsGk9c0dBfSGDNbJUO7sEViryWf7bfeLL
 MsFssEmH07hcWNnkQivz/5j0xbRYossatwPrinkaHCl1y3dUyjv/C0SjnDq2QFYtIyF+W45GNvi
 BvcTr1RbeeNyI4UCFmkN2oerfX1fJ2ZwRIoqTGYm/JUq6ztlDUF9Y1AnKdPENmlZPK4U8Lh/x1o
 eE1uAA0HsB132IpaqyedhF9lRk5TMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510030201



On 10/6/25 11:44 PM, Peter Zijlstra wrote:
> On Mon, Oct 06, 2025 at 08:51:27PM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 9/10/25 9:14 PM, Peter Zijlstra wrote:
>>> As proposed a long while ago -- and half done by scx -- wrap the
>>> scheduler's 'change' pattern in a guard helper.
>>>
>> [...]>   		put_task_struct(p);
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -3860,23 +3860,22 @@ extern void check_class_changed(struct r
>>>    extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
>>>    extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
>>> -#ifdef CONFIG_SCHED_CLASS_EXT
>>> -/*
>>> - * Used by SCX in the enable/disable paths to move tasks between sched_classes
>>> - * and establish invariants.
>>> - */
>>> -struct sched_enq_and_set_ctx {
>>> +struct sched_change_ctx {
>>>    	struct task_struct	*p;
>>> -	int			queue_flags;
>>> +	int			flags;
>>>    	bool			queued;
>>>    	bool			running;
>>>    };
>>> -void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
>>> -			    struct sched_enq_and_set_ctx *ctx);
>>> -void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
>>> +struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags);
>>> +void sched_change_end(struct sched_change_ctx *ctx);
>>> -#endif /* CONFIG_SCHED_CLASS_EXT */
>>> +DEFINE_CLASS(sched_change, struct sched_change_ctx *,
>>> +	     sched_change_end(_T),
>>> +	     sched_change_begin(p, flags),
>>> +	     struct task_struct *p, unsigned int flags)
>>> +
>>> +DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
>>>    #include "ext.h"
>> could you please add a comment on matching flags on dequeue/enqueue
>> here?
> 
> Would something like so be okay? This assumes at least the second patch
> is applied as well.
> 
> ---
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10783,6 +10783,12 @@ struct sched_change_ctx *sched_change_be
>   	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
>   	struct rq *rq = task_rq(p);
>   
> +	/*
> +	 * Must exclusively use matched flags since this is both dequeue and
> +	 * enqueue.
> +	 */

yes. Something like that. Unless callsites explicitly change the flags using
the scope, enqueue will happen with matching flags.

> +	WARN_ON_ONCE(flags & 0xFFFF0000);
> +

A mythical example:
scope_guard(sched_change, p, DEQUEUE_THROTTLE)
	scope->flags &= ~DEQUEUE_THROTTLE;
	scope->flags |= ENQUEUE_HEAD;

But, One could still do this right? for such users the warning may be wrong.

>   	lockdep_assert_rq_held(rq);
>   
>   	if (!(flags & DEQUEUE_NOCLOCK)) {


