Return-Path: <cgroups+bounces-8773-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08554B0A609
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 16:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AEC17B2E91
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6972248A5;
	Fri, 18 Jul 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA+azf+L"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1162AF14
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848322; cv=none; b=cK8SmfIsHX4NPq6Qk8mjMJcW16m64V6flaTjpRcBLBCNh/gCDoW7s3cizqgTw/6aogJw7QbFosdVDsqtmPGQYuwgDBn3EhPZr4xTy+1zBNigMsfa6bGwv/9Tnm9dv2d+SiIqpntWRf3rFZaKn+ly5khUDZrzYEjuRQl7VBeEyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848322; c=relaxed/simple;
	bh=/HDiIMliCtLNl3z2Bo9OK9anjcaoueDP+L8Oe97p+wk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bxd7FyDaniT6mOCo7QTlN3e0DBBE7P1JgXxBrYry5AjENS07zcvVB+OKcdfkVZUtw4ekS//5/5tIF9bvSyCpBOnwYgL+WzwjNMnK9ki5fY/KGBAaSBBWhkYTbZHgJ7bYwX1mOCanfk3+vSOr8tRGw6POYvgtMaFfn6Gk1Y68VnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UA+azf+L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752848319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsytLQJcaKqStTtlNqZ83QBux0JcP282gxaqMBrT3E4=;
	b=UA+azf+LgiyyVTEJS1MKlSR8mUuLihiPpLpYmTrFYPGuBgsGireFI1+KGNaFjB6TLmRbR9
	hX39S6I833AEJlV8ymmNkOhBdE0PM+18iBIYXIOkhUibLkV7crUP98lERkTTQNhAKaZGmd
	QkBjvLKGycxJ7yr/25VfoL0D4eaF/MU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-H6PQV6IAPoKIS6hXubVdGg-1; Fri, 18 Jul 2025 10:18:38 -0400
X-MC-Unique: H6PQV6IAPoKIS6hXubVdGg-1
X-Mimecast-MFC-AGG-ID: H6PQV6IAPoKIS6hXubVdGg_1752848317
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235089528a0so28404665ad.1
        for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 07:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848317; x=1753453117;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsytLQJcaKqStTtlNqZ83QBux0JcP282gxaqMBrT3E4=;
        b=l2T5qDZBV4t9JJvsNjHZ9UlLo6ReHcJpoeONVl+85iEQOLU/65fXOUXiMjpRB4zlK0
         QvD1KrquYHM9vEcMnO9uMbZwJCkThzuHG1IW0fKHYfcaiD4Wc5zwlqfmIkO0qtqP+j2V
         HzE8ZcdBN/QeIbIgkw8y+E7ZtMvQJCczuUM+XrMqnJPSg//j7o1EbvAt5SBI0iHZDJFJ
         W55Ib42V7yk/xS4KMZuENhqMJ8bcnRPdKxYuwmHts6BHYLa+guKFRpZ57G8TzSJ6DRxR
         24L/OltXnfgQcxb0/mtObMIl+9K/cPZ+iCbgLRznnKnwaGJ1ImW5cCgmeUrzjwOuWGXo
         e/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgVXYCt+rkdFyMBYqd40NsXqCf9cjlyscEtpgHyexRrO7gB/7sIEO/uR3jh4i569ZSfLGSetMw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2xjzibhJIM/MfQRlG4qsJoBhXKfLyYFpYU1UiIJIA1E5OWIv
	0n/C4eEwOgrOWoWJdNPeIvUfLJZ1rCLw8KW8gti9PYo+PZGBkinLX1tudKwhdfKw1itXd1du3Un
	QaAhtKaeZxiPVWQJecGlweD8JcObeJfgUeyC6am/8uUJSotQF5CCn/camPug=
X-Gm-Gg: ASbGncsOWFDw8AiJWDvntyGcKtEmjRgAQStsP0Mdrc/2VE8misA9GFjVo+r2AWjKVT+
	yvyQ81jGbZxjEVg+vMRPVLcDlRbBMEftEiLijsTCNptUzmteuAolEDMiEhO04ajN+wKIKJORRwm
	TE8/oGgyMAHWVCKHkspwwdU3szbjCqONlaBZiLKJecAk66MkBRQvT4okhYJvKl2f3uETHbBJsrT
	lcMHpQpoNxcBEVw9G0xApC6uhnFN5bi0evm0KmVKXc0O/JfBqBnY1BXUbJYhskbFIFnPsORr9vM
	g6N5xyUYB/64VxXZF5XwfvcuwBu1h251gRRcyZ4sszTtvGKCw+wKRAppdODCZ5j3haWx72qgUzu
	xzyVFP0k3rQ==
X-Received: by 2002:a17:903:f90:b0:23e:24d2:6e46 with SMTP id d9443c01a7336-23e2f6c6aa0mr107267235ad.7.1752848316944;
        Fri, 18 Jul 2025 07:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgJXo3Ori6iK5y2C4lk98DEkbJptwCJ4VpQy0rRUYTnCJzR3LlRZOLTKRIOjjII/Kn2Ms2VA==
X-Received: by 2002:a17:903:f90:b0:23e:24d2:6e46 with SMTP id d9443c01a7336-23e2f6c6aa0mr107266675ad.7.1752848316322;
        Fri, 18 Jul 2025 07:18:36 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4afesm13978015ad.110.2025.07.18.07.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 07:18:35 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <209dd5d0-81bd-49d2-9b96-9839d2e399a5@redhat.com>
Date: Fri, 18 Jul 2025 10:18:32 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: Mask out offline CPUs when user_cpus_ptr is
 used
To: Chen Ridong <chenridong@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20250715155810.514141-1-longman@redhat.com>
 <faab5c42-ec95-443c-b748-b3e7e359c934@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <faab5c42-ec95-443c-b748-b3e7e359c934@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 10:42 PM, Chen Ridong wrote:
>
> On 2025/7/15 23:58, Waiman Long wrote:
>> Chen Ridong reported that cpuset could report a kernel warning for a task
>> due to set_cpus_allowed_ptr() returning failure in the corner case that:
>>
>> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>>     be the same as the cpuset.cpus of its cpuset,
>> 2) all the CPUs assigned to that cpuset were taken offline, and
>> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.
>>
>> Due to the fact that CPU affinity of the tasks in the top cpuset are
>> not updated when a CPU hotplug online/offline event happens, offline
>> CPUs are included in CPU affinity of those tasks. It is possible
>> that further masking with user_cpus_ptr set by sched_setaffinity(2)
>> in __set_cpus_allowed_ptr() will leave only offline CPUs in the new
>> mask causing the subsequent call to __set_cpus_allowed_ptr_locked()
>> to return failure with an empty CPU affinity.
>>
>> Fix this failure by masking out offline CPUs when user_cpus_ptr masking
>> has to be done and fall back to ignoring user_cpus_ptr if the resulting
>> cpumask is empty.
>>
>> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
>> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
>> Fixes: da019032819a ("sched: Enforce user requested affinity")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/core.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 81c6df746df1..4cf25dd8827f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3172,10 +3172,15 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
>>   	/*
>>   	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
>>   	 * flags are set.
>> +	 *
>> +	 * Even though the given new_mask must have at least one online CPU,
>> +	 * masking with user_cpus_ptr may strip out all online CPUs causing
>> +	 * failure. So offline CPUs have to be masked out too.
>>   	 */
>>   	if (p->user_cpus_ptr &&
>>   	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
>> -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
>> +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
>> +	    cpumask_and(rq->scratch_mask, rq->scratch_mask, cpu_active_mask))
>>   		ctx->new_mask = rq->scratch_mask;
>>   
>>   	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
> Hi, Waiman,
> Would the following modification make more sense?
>
>    	if (p->user_cpus_ptr &&
>    	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
>   -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
>   +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
>   +	    cpumask_intersects(rq->scratch_mask, cpu_active_mask))
>    		ctx->new_mask = rq->scratch_mask;
>
> This can preserve user intent as much as possible.

I realized that I should have used cpumask_intersects() instead after 
sending out this patch. It looks like you have come to the same 
conclusion. I will send out a v2 to update that.

Thanks,
Longman


