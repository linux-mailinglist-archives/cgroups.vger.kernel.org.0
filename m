Return-Path: <cgroups+bounces-10566-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 354B4BBE7CD
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E95B44ED4A2
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBDB2D73B9;
	Mon,  6 Oct 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eOe+6Rt5"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD87299927;
	Mon,  6 Oct 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764454; cv=none; b=dbu48tRs17Zs82c9+RTwystO2WQ+vXAX3iH6v1T16AQ3ajXqxT5IBlGO9WsyNuZXHewkNnnRjm6QVXK+HkLZDI9EKvqwKII4YrBJJxmMqtKzZ0lp0RaTUa/o0svdT7AAVDNnAFfluAlyy7iltyuASGW6QBRsA7hAeNJkMMuVHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764454; c=relaxed/simple;
	bh=MoS6ImqYcoCG5XsgUemtdrS0YKZ+fPGBtCYoedZyEcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGm+WPgU1lon9DKJ61aNhtkQpwS9lDey3pRxbXBYTrvREMujGRcQUXBCSS49YzGPp3DW2rkh4FzhZ5Cpl02m1DDaf3Zjt54f+L5zhLmlBDyjtWiLx855o5m/HN4StPoAA/cD02t/wu4CVsiM6zlR7wbkZzO5FlBWOudwRi/+5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eOe+6Rt5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5968U6DD013752;
	Mon, 6 Oct 2025 15:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BGTTua
	/GjXQXBBYK78wLNyLke//ig1ARcXJHik9zE20=; b=eOe+6Rt5jf3NL5jroF+RYp
	Pc6QINRrCb15aZFy4cfhBgkYsPtwVLQFt3gHGYz/VSBWarKcE4Qy17EtlM7V0luN
	NzdmjIB+INSD7fnzyJb/IfNz9lEZvY7+9Gcv4kEmvHDPpa3MlmZhyjgxAeDJvOz/
	YJKVT6yiJexnsX9zW2Dt6PN3XXet2TKShwFSJ7c7eFUzZESFqV5sNMVNMcl2+GL9
	mIVwREEHR8DbpJHQheDIw0dFQrPfTC5LbkkSbgc6XSnrP3kI+IhRYABEax0fxyLL
	nsaVPLiYX73WBmI/DnjEUTUEVHEtNMItMmt0E/h2UGZM/aSLYOtttnbHlbLQifqg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gt6vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 15:21:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 596Eqs69015698;
	Mon, 6 Oct 2025 15:21:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gt6vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 15:21:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596DSr6T031419;
	Mon, 6 Oct 2025 15:21:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kfdjxkxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 15:21:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 596FLXCR30999030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Oct 2025 15:21:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8776720043;
	Mon,  6 Oct 2025 15:21:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBA7720040;
	Mon,  6 Oct 2025 15:21:28 +0000 (GMT)
Received: from [9.124.214.120] (unknown [9.124.214.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Oct 2025 15:21:28 +0000 (GMT)
Message-ID: <fee0edd5-86d1-4dff-9e07-70fd2208b073@linux.ibm.com>
Date: Mon, 6 Oct 2025 20:51:27 +0530
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
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20250910155808.415580225@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX19dQ+iwBtKSY
 RZYC63N/LKEDG4lvHmvFk4kqeUdiKTUkoeEydIQj0gERIPYb7wzu/dT3ruYfzf0tqk6hSEPnSJj
 vAceTL/D9jZp5YcHo5/G2yjcE/7XmF1v6nE6NAkYgZ6tDoR0jpPyotWtdVuKa2+VLswggC2e5aM
 wkOBU6yYwsfngbRIOOikjDuah2PY3FhN0G/RycWSMvphVFMQ2ydddJ0JrfDYoMfkl8NBoVhmP5a
 B4bxump1C9JbRjLmdH28j2Hm+k8erlXktgMgwIhqZFW+ew57epmRULGEpyL0Q+vqyhgabfuvw/Y
 3OP2j05K18HHNX1Y69N+8Bmb7l9iAq77MpkwPey4rD80S0Wa5dDtdYAj/RkTbi8eGzwwD4M16TX
 kCpJp80qt5/9NnlUxs1edOuughRksg==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e3de81 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=hKsuor804cSa_We8IwkA:9
 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: 05FclDpPzSC4xn8YbrD0TJ5uabLK3hwr
X-Proofpoint-ORIG-GUID: eWovQ_0FPZV6sBTIKMBJldvpkfSp2N_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018



On 9/10/25 9:14 PM, Peter Zijlstra wrote:
> As proposed a long while ago -- and half done by scx -- wrap the
> scheduler's 'change' pattern in a guard helper.
> 
[...]>   		put_task_struct(p);
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3860,23 +3860,22 @@ extern void check_class_changed(struct r
>   extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
>   extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
>   
> -#ifdef CONFIG_SCHED_CLASS_EXT
> -/*
> - * Used by SCX in the enable/disable paths to move tasks between sched_classes
> - * and establish invariants.
> - */
> -struct sched_enq_and_set_ctx {
> +struct sched_change_ctx {
>   	struct task_struct	*p;
> -	int			queue_flags;
> +	int			flags;
>   	bool			queued;
>   	bool			running;
>   };
>   
> -void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
> -			    struct sched_enq_and_set_ctx *ctx);
> -void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
> +struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags);
> +void sched_change_end(struct sched_change_ctx *ctx);
>   
> -#endif /* CONFIG_SCHED_CLASS_EXT */
> +DEFINE_CLASS(sched_change, struct sched_change_ctx *,
> +	     sched_change_end(_T),
> +	     sched_change_begin(p, flags),
> +	     struct task_struct *p, unsigned int flags)
> +
> +DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
>   
>   #include "ext.h"
>   
could you please add a comment on matching flags on dequeue/enqueue
here?

Since the ctx->flags don't get cleared, one could be left wondering how
does the enqueue happens(exp: ENQUEUE_RESTORE) until they see it works 
since flags match.

