Return-Path: <cgroups+bounces-12170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C618C7EF14
	for <lists+cgroups@lfdr.de>; Mon, 24 Nov 2025 05:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C753C3460B2
	for <lists+cgroups@lfdr.de>; Mon, 24 Nov 2025 04:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934A296BAF;
	Mon, 24 Nov 2025 04:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnznyRyz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eajPrkbX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D8DF6C
	for <cgroups@vger.kernel.org>; Mon, 24 Nov 2025 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763958714; cv=none; b=L/GjSdqAvVimDZw1Fnt6abrEe4st1MdVDEnLxautBoSWt5AbLGhXhyv5rqk5HjCYL4hTkq9dw8znE5VDOVkCJuZ58sQzC14owQomNPQArjE+tBNWWnnzqdCnGOlurtafSgZHaM2aSNtt6P1tI01D+qBOoxDz5PRLE5qLDCLTNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763958714; c=relaxed/simple;
	bh=XjViVLHcJSFUu6vfjnfWsEofdU0eskQdsaI7+7sZhBs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DIbjscC4DdekhxndPaheMxPyvEwo1LXyavg+tD8bZDwoUhZK86/8Ne7F2/e8fBBsEHVUur/BSKioDKareFHi9AZonbOuAzbJ/Z82MSyi0qLhqlT6tOLk9XqbxXRagsg3vrW1ptvnjMbmiCwzb+7FQ6YizHqamLKDwwaBYRLExuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnznyRyz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eajPrkbX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763958711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXq63fZI6qLaCQ4t6HE7CgeaY6ydj2Sk6du/HedBBaU=;
	b=gnznyRyz4j0hQllOEJwSTAYGxZ2SPK3BifjrNA3dwVQv5/0uLUipLuyfbjN6Zga94b7w4H
	w0OzPcdPtWh2tcpENA9FjTxhMIWFo6+16pzJKtA63hGhU52eM9eMvk/z/D6K/Ta+BHIrmy
	VWg9F7FfNrlA+bSgr4RdlT+8tloM04c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-35SQMpPgNZyzxVGl1pIPew-1; Sun, 23 Nov 2025 23:31:50 -0500
X-MC-Unique: 35SQMpPgNZyzxVGl1pIPew-1
X-Mimecast-MFC-AGG-ID: 35SQMpPgNZyzxVGl1pIPew_1763958710
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6e701d26so96461171cf.1
        for <cgroups@vger.kernel.org>; Sun, 23 Nov 2025 20:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763958710; x=1764563510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BXq63fZI6qLaCQ4t6HE7CgeaY6ydj2Sk6du/HedBBaU=;
        b=eajPrkbXDBFyeliqD0t628GcxWfzS2GtdujaE0+QUv9XryJpF7teVKgXTzIYFHBLym
         UqebwfASk9Wi9Bjha5/8ydfaOWMbVTjr/WLEsJuN04J3etLfuBmGn4BahM1IEK4rmAc9
         qWZbaHqb1jhpH1mUgyOMWlE/DkpKSOT2aX7QUEIGFseMooY97vxJEno0BGz/cqidRuWm
         c8zj5c2a4J70jjIgLSWW3w7JY14kngeERURaNCK2Bah4Lllsy6x/BcrxuH4qX+wqd1W/
         6cFz5rbpW14+9ePO9MRdSZqT7mqGbwxqyABjCpkxP8/1b2y1s3KJHm/GrINv20ohSQwp
         1YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763958710; x=1764563510;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXq63fZI6qLaCQ4t6HE7CgeaY6ydj2Sk6du/HedBBaU=;
        b=ozMHij2ZHTyAxr3cULR1hhiL4As3i+E2r5+Zy+kACiLoRQhe7ru1FxfV4lI1/Y+Qzl
         2FDMDrrhrQN9VeLIM/ZSQy9X1LULJrts38DOGtFEJJTj24Z9SxWk/CyuGbzs1Wq/Fq5m
         uYoj3LowC5QI1MNW5EMfBbHsrQFR1fsz0UpGaSSE/sAdT3PeYBoh1VklX1UHJUwKWJq+
         AhOpU1MXMGjSaVdsoHMyXdnze3YtdXlDrlvIQCPWgYsknaC8x7mBEPoPzIOD2ystDxOP
         gt3931E5ojhGR4eI3rfEH9SbBLWQVEmcVZnfw8YAO2fEh8RCo7ceOsSimlTEyk7GhyhZ
         S6Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWK/aXCaGBcBy3Qd1Lh+uuY683YSygfwJO0jF14V7rPvlL2TjDPunbhtEW6xpRJF2F2vT9mdqS+@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFGC697CD9WqAPl8O6cqb9mR5Nov5Ndfy5RV4oW90ZlN7ECbj
	krVtcH6uBhhSymaQSOkyoQyDfkLJnn+kBsivzFgCwL0ZcwMZkPdLjOP5TqqNsmxuJ48IXUjVBFe
	tkJcOX3KJSeY8uTH1j918OTQrKiw9mMl8TP80snbvEbrz8OKu2b8exb8n9Ik=
X-Gm-Gg: ASbGncsUmSzaHZ9HmV+5nBNRlGjbVDBXOiSPeItD1aQWI8U4zJPCYwOQG/QXnePohzy
	zlbNTRbtxJf21sPj5tAYGqyJTkEwDw/E2lxLnyqkeECbYgLaNsZOWIcmLr4IB3oSCh82eeaLyKt
	+GTeUAyo/eLkZPwl7foMlGbj4ZFMfe1bFA1d0RpBS76j8/9vvosdBU3wutI9ftmDwfXWHrIO8oK
	kAljyw5KHxYc1bWk4TR+UAFjShVEDwX24zPrI9V+LwdYjBNu4LrHAcfvjjAuyfjNfiF/SrDRtRc
	QMii5ubyw3rynohus1Sh5Xy3bCUozjC5hyONB/M7aNuAhBHgCe+XCrLm8r+DeE4K1/1ImoCg2yC
	NUqKX4Mg1lLVMXl46RueMlM8xDu+AvXTIjkV2XlRZPYvUNG1ElVR5VwDu
X-Received: by 2002:a05:622a:11c5:b0:4e8:af8a:f951 with SMTP id d75a77b69052e-4ee5895c017mr148884671cf.83.1763958709855;
        Sun, 23 Nov 2025 20:31:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhmbEvpe/5pSF3pV92EwJkNGfTrDMbU0ExQPeYAuZEt3y3Ve82M1K/mH1tBXHrzon0WmCtmA==
X-Received: by 2002:a05:622a:11c5:b0:4e8:af8a:f951 with SMTP id d75a77b69052e-4ee5895c017mr148884481cf.83.1763958709495;
        Sun, 23 Nov 2025 20:31:49 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c84esm90318906d6.30.2025.11.23.20.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 20:31:48 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dd61a698-a298-4038-a4d9-a40ffe0b05d6@redhat.com>
Date: Sun, 23 Nov 2025 23:31:47 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Fix potential race in
 dl_add_task_root_domain()
To: Pingfan Liu <piliu@redhat.com>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <https://lore.kernel.org/lkml/20251119095525.12019-3-piliu@redhat.com>
 <20251124033415.10784-1-piliu@redhat.com>
Content-Language: en-US
In-Reply-To: <20251124033415.10784-1-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/25 10:34 PM, Pingfan Liu wrote:
> The access rule for local_cpu_mask_dl requires it to be called on the
> local CPU with preemption disabled. However, dl_add_task_root_domain()
> currently violates this rule.
>
> Without preemption disabled, the following race can occur:
>
> 1. ThreadA calls dl_add_task_root_domain() on CPU 0
> 2. Gets pointer to CPU 0's local_cpu_mask_dl
> 3. ThreadA is preempted and migrated to CPU 1
> 4. ThreadA continues using CPU 0's local_cpu_mask_dl
> 5. Meanwhile, the scheduler on CPU 0 calls find_later_rq() which also
>     uses local_cpu_mask_dl (with preemption properly disabled)
> 6. Both contexts now corrupt the same per-CPU buffer concurrently
>
> Fix this by moving the local_cpu_mask_dl access to the preemption
> disabled section.
>
> Closes: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt14gen4.remote.csb
> Fixes: 318e18ed22e8 ("sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug")
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> To: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Chen Ridong <chenridong@huaweicloud.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> To: cgroups@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
>   kernel/sched/deadline.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 194a341e85864..e9153e86de0a7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2944,7 +2944,7 @@ void dl_add_task_root_domain(struct task_struct *p)
>   	struct rq *rq;
>   	struct dl_bw *dl_b;
>   	unsigned int cpu;
> -	struct cpumask *msk = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> +	struct cpumask *msk;
>   
>   	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>   	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
> @@ -2952,6 +2952,7 @@ void dl_add_task_root_domain(struct task_struct *p)
>   		return;
>   	}
>   
> +	msk = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
>   	/*
>   	 * Get an active rq, whose rq->rd traces the correct root
>   	 * domain.

It will be clearerer by moving the statement down to before the 
dl_get_task_effective_cpus() call that uses msk. Please also update the 
comment as suggested by Juri.

Thanks,
Longman


