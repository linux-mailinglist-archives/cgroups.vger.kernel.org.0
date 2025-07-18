Return-Path: <cgroups+bounces-8777-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996CEB0A8DC
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 18:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850795C161C
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12392EA48C;
	Fri, 18 Jul 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCRzWAbB"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A52E8E18
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857086; cv=none; b=LrTEru00W0vI+Me/+QZsMWbwaHvyJh4anFzNfxwlVbq5VdNKWga3wJYOtF8xhf8ZM8Z6QQqsPBEaqVZN/3a8JQeqYYURbjtZbrK8L/4B/Q4a97W2TKfGUzGm+NR9eySfJMT7mLnDlvCgi0K+fFFQyCY7cE5FztBuH97qRD373XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857086; c=relaxed/simple;
	bh=MUPT5uXqaIAkdRIv9xWwGPD8mLeeQZBbR0yFXSEW6jU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qqgpintdHdGLXb4NLx7guEZld5x1uFRTnDHq4FPx+qBY7+w5cR2zcBlSHlY7d3YgziUVjqxCvFnzuREqXT6OBJ9uR+CgvpFf2RnkzFkz0n8G2j6piZH5DnF1ZOZ7g0XQ7PF/kqViSkWY3LG3e8gAGbLU/V8zJ8oV1qNF5ecVy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCRzWAbB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752857082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JERhiZO1FqB+6NSKGdBNKdwEhTOU9waM9GCpnMyUFCw=;
	b=OCRzWAbBo7Ku8SbL45derz6+F869kjD/jqoaGf/o0IyS+9EW5z8+vqpy3DZcHYxXUjtyJY
	NnS9qVPq+58uk7P1lPuF407d+nI91f0EgR/7BtSEPCH6G7Pa7UeFs81rHXljqrf402PU+Y
	lqlNS8ZB7bgVPjQdnZWR49l/dBUirY0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-a1sX7E0SMXOJ07RW8iYRlA-1; Fri, 18 Jul 2025 12:44:39 -0400
X-MC-Unique: a1sX7E0SMXOJ07RW8iYRlA-1
X-Mimecast-MFC-AGG-ID: a1sX7E0SMXOJ07RW8iYRlA_1752857079
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d413a10b4cso310721585a.1
        for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 09:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857079; x=1753461879;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JERhiZO1FqB+6NSKGdBNKdwEhTOU9waM9GCpnMyUFCw=;
        b=bgnciK/gWjDWjihNvrBQEmk9jDclki4AixcnlBVRU6JZdgEUbGqAbbG2s3t4YMXiGu
         XZJX/tSEm26lCc7hbBQqWjV13PpfqDJeTPZgkYsn0Lk6fh61SFJPiBVW3gamySjL8sq3
         +yuXRBgDwTbGpW/0+A3ewSuDQIzmbwySGphmXvYX7SVhYNuPixggExhxouu3kACG0R/E
         cj1I+XinMcKyaGruUkUkYRzvEFh/Nl0VO81h7ew1eGWnGOqhazF3BPOghZlaAONSILTR
         FQ7jhPRldvUhjrrmh6ryB3t348f15HUsH1aOk40yAKx+VZpdaL/vTLH0QfikHwTx+xq6
         FkOA==
X-Forwarded-Encrypted: i=1; AJvYcCV88rDYwkdxUMYqY/y1O6K7X42WgfLH53lWCiaWCFTbnDK5bnNhu8Kplfi+g9pwBRVSWDZrky0j@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4Aj3hFMp9EtGsH2bFWELZFHXG2m+6IM065siZ1y8Z3qMM/R5
	zTybY6B7dVx5KwkaiKWf0ZDGO6AIN9MpCXcg4ajs0zbmQehNviUwcHcJrga3kQPi5JKP79xK90Q
	XyyqOb7AurTwZWuEcT5iHIO8P0RylvXNNTjOoERBFHVkQjq+ZlWkxeiT4c3I=
X-Gm-Gg: ASbGncuPsMKZ5f4xrr0id+LTFtTiPApVOtblVYTZf2KFiAWFswrLXZ1RoZgLYn2VXCX
	Oypy813m4CovwkWuslvsDIRclOE2+9kdpBcnYvbFJeW9cBt5TYlUJMMCUfQJt4KNjXTPvqnn86e
	FQAYTLtEryh5QT7oHTOsrQUunUFUEJbQlkIv6h3o9dwIDHUFcRFaLvt15iube4h8d0lF3H1DbPN
	X5RE2qhqePVp2+RcPBiJitvNYkSuJbmiUTHp7onL4jrutrG6dYzk2TKi0jzsTePwQY/9/KyK5UC
	0+MK6oC0+P76FVw0fr97VTvg6bVpsaLDvl8kKI1sfWDOELRHrUqPxBgNgFLExnNNZ+KDw9REtLj
	5JgM/Z0WpzA==
X-Received: by 2002:a0c:f410:0:b0:6fd:609d:e924 with SMTP id 6a1803df08f44-704f4b02165mr217575076d6.36.1752857078730;
        Fri, 18 Jul 2025 09:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4no08gFB65n1oCHwJbCCu9Qlg673ZDju2Ue/tovZEXpylDXZ4tExTNcCJYzuMmD4eWzzOdg==
X-Received: by 2002:a0c:f410:0:b0:6fd:609d:e924 with SMTP id 6a1803df08f44-704f4b02165mr217574346d6.36.1752857078137;
        Fri, 18 Jul 2025 09:44:38 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8f0842sm9557946d6.30.2025.07.18.09.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:44:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ab63352e-3a15-4f04-bd87-96eb88943520@redhat.com>
Date: Fri, 18 Jul 2025 12:44:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/core: Mask out offline CPUs when user_cpus_ptr
 is used
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20250718164143.31338-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250718164143.31338-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/25 12:41 PM, Waiman Long wrote:
> Chen Ridong reported that cpuset could report a kernel warning for a task
> due to set_cpus_allowed_ptr() returning failure in the corner case that:
>
> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>     be the same as the cpuset.cpus of its cpuset,
> 2) all the CPUs assigned to that cpuset were taken offline, and
> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.
>
> Due to the fact that CPU affinity of the tasks in the top cpuset are
> not updated when a CPU hotplug online/offline event happens, offline
> CPUs are included in CPU affinity of those tasks. It is possible
> that further masking with user_cpus_ptr set by sched_setaffinity(2)
> in __set_cpus_allowed_ptr() will leave only offline CPUs in the new
> mask causing the subsequent call to __set_cpus_allowed_ptr_locked()
> to return failure with an empty CPU affinity.
>
> Fix this failure by skipping user_cpus_ptr masking if there is no online
> CPU left.
>
> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/sched/core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Sorry, I forgot to change the patch title. Will send out a v3.

Cheers,
Longman

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 81c6df746df1..208f8af73134 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3170,12 +3170,13 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
>   
>   	rq = task_rq_lock(p, &rf);
>   	/*
> -	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
> -	 * flags are set.
> +	 * Masking should be skipped if SCA_USER, any of the SCA_MIGRATE_*
> +	 * flags are set or no online CPU left.
>   	 */
>   	if (p->user_cpus_ptr &&
>   	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
> -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
> +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
> +	    cpumask_intersects(rq->scratch_mask, cpu_active_mask))
>   		ctx->new_mask = rq->scratch_mask;
>   
>   	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);


