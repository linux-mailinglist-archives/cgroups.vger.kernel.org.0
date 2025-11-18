Return-Path: <cgroups+bounces-12066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC1C6AAB9
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9572D35D110
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3622436CE1E;
	Tue, 18 Nov 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMveGjwv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehHo1Mui"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5E36A017
	for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483230; cv=none; b=PQUVbdnPsGJcOJYtBRBZj6vRC7RSjd3/uu2S8CKW7EQ+ydF7q6dPtV5Ou9wVQj5n1YYFmnYb8v43bp/UhPfkhXfnvl7b9nITd4Nu2zKyTv6D2t85Jz9xf5yIqdn0eg6oYcQqyeMYhLQTnMLBSBXl94r4m4OZ7cLb5u+8VbMJPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483230; c=relaxed/simple;
	bh=kUJHfh9HugpJ2cqshFdZqTZ+sD74QCWFCfBCAt8vmQg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fQm5g2afAjDa6Oa6YM030gKa/kGejkpmZXs7JGrZ/OZQ88ZJEchq6umgHjbQcMSxZ1NAqQPaIZlJThFArQ9EP0mVDq+KFtfuC+1OlvOUdEdR19WHIJDd4TNBNbqsyMvsLaGzKy4zYXa/nX9fT4sZ5kUaAugatZvhtwrtYL/ZsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMveGjwv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehHo1Mui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763483227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z690EtwcaRnPK4zK/JgQymqn+WLohl3IVAAKV+zdRik=;
	b=GMveGjwvbTZUECU0ghL0s/Yp0bSU48xbjpbnQ0Lp4FFkkfNgq5DES0jQpYrW2z4mqRlXYS
	+HkGZNptbgi+lvUlTur32D+379+7odgC03IDl/HFLGf8Nb9r94OZWL0QHiCX31SQGqqEU7
	d4EM8bu3iWfotOwmSpOM3A9U5oWCF68=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554--7BUKYSIO4mDOq_r7yYQmQ-1; Tue, 18 Nov 2025 11:27:04 -0500
X-MC-Unique: -7BUKYSIO4mDOq_r7yYQmQ-1
X-Mimecast-MFC-AGG-ID: -7BUKYSIO4mDOq_r7yYQmQ_1763483224
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b233e206ddso1486582085a.3
        for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763483224; x=1764088024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z690EtwcaRnPK4zK/JgQymqn+WLohl3IVAAKV+zdRik=;
        b=ehHo1MuirW58WU3R/OzNHNO5oMX+L8FW4po8+O9rubmAIQHLyvfWngpHFq3z/zkzD8
         /SbJbG0Knk4pEfhjQvFCwyy09eiwQ2AvYAMQF5fgOVNoCDyks2WJtS/1ackMTATNDWi5
         d9LLXw/fFpycWevo8xJb81wq1POpYHnubligjth2aJNj/wMqQDfcja3Ma83hzOdBs4g5
         IH0MR/e/0xAQLE4g3FtRFjbzQvLbP8wfROBSB8HjXf9N3ysdoPgmtApj1LBARhXdoxLx
         Zxb1be37CnmTyPsZ0l2vzUTlNNZslennn7OSTqIZ4FvFntwFgoGGqXjce9tDQNwxm2+h
         tWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763483224; x=1764088024;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z690EtwcaRnPK4zK/JgQymqn+WLohl3IVAAKV+zdRik=;
        b=tKledWFvCb2gEiIfSKwdnVDGNX/3srn8scEoK3myOrBujGpg984aK4Kv7GPX7SWdTe
         oyWHy9ZUQGIb8aXxlT19ThdndZmrv912RZZLePaad/1csh8BofV0FiPOLNjDTwaOVgkc
         1T0gIrHc7UV54m4SQwwMpnslHPjpCcx++eA3iNN8puzN+EVKOMtiCajZIA9RrQC7tEo4
         7Mv0pIHV+HkbzWZx1/17fh7KMDQ+sZ2l5NHXxKgPftdgm15HtFY0gxqhFcNVD4O7lDam
         W2sUf0dze4KdOvs4q7XEa6Mz4b6I43+cpGTRobA7ZAjDrQ9eQVYVYIIBoFqeWq4XsBQc
         Jy6w==
X-Forwarded-Encrypted: i=1; AJvYcCUlMMCI99i9XnbDWCUGnEo4CkeTvJSualTZ12l6oXHc9SNH0msLjcbo1PACtGgJrA777iOSq6o2@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwBs9QoUAd79PfQdyDnPy24Nc2ehw5ypML6GT4vLlzhzH6fq5
	XetENZcy6+lu5/f/nRUWg0bK+JdkDUVaARrkFhtrO7aYt7AC9k3Rpblvf//cctaGufEC6L595KC
	PIx9IwBk+WJ8hwl6K//xAeYpkKrH7rInJ9mgWW1cowBbCzOFK2CEEaiGyIww=
X-Gm-Gg: ASbGnct6pyRg8cQKGhi7sPO/PsVtXmeV0eXYZQZreBkMnHwp+N4SKogrT2U8mwgs0ka
	YZ63OWFOeKgWnj2zhOmsnwXluNbHlgnmsLBlDObnO7KJCq/bxxGh5R6vIdHq4ugZxA5KTiSDJX6
	afMYzGSVZpN4RqcgyIS+gbOgpApU4OYq3pBTCZWVi7ypIuSWDOmQEOeg8w4SblhwdoAhIQWs2qW
	nPrjQBbrUrQT5ksZzxqyIna9CiNeGREp5sIKVRAJzpGisx8QJq2JzDZbP9/DVEse4i6OhdvMUx8
	jiDaUOHUXYpbU+sKdimyjo+bXoV2qNdjGwSKsKErevdoBHX2AE67NNVzFYgAnoIi1OK5oY4TAPw
	ZEk1k2tOl9Iiundjjz4uvbToLloDBk8hubh4pC/wUni+OTg==
X-Received: by 2002:a05:620a:2699:b0:8b2:f82f:c630 with SMTP id af79cd13be357-8b2f82fc8damr779879685a.31.1763483223910;
        Tue, 18 Nov 2025 08:27:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3ZcSy2+5FXyNrXAz/9Op4M2TNKXMQ5Koed++aPIewDtl6gtundToUu2A+xx3VqOCdyF5i1A==
X-Received: by 2002:a05:620a:2699:b0:8b2:f82f:c630 with SMTP id af79cd13be357-8b2f82fc8damr779875685a.31.1763483223319;
        Tue, 18 Nov 2025 08:27:03 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2e44c3154sm693064585a.20.2025.11.18.08.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 08:27:02 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f7794481-5a43-478e-99f2-ae6c45eccaa9@redhat.com>
Date: Tue, 18 Nov 2025 11:27:01 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Marco Crivellari <marco.crivellari@suse.com>, Waiman Long
 <llong@redhat.com>, cgroups@vger.kernel.org
References: <20251118143052.68778-1-frederic@kernel.org>
 <20251118143052.68778-2-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251118143052.68778-2-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 9:30 AM, Frederic Weisbecker wrote:
> When a cpuset isolated partition is created / updated or destroyed,
> the IRQ threads are affine blindly to all the non-isolated CPUs. And
> this happens without taking into account the IRQ thread initial
> affinity that becomes ignored.
>
> For example in a system with 8 CPUs, if an IRQ and its kthread are
> initially affine to CPU 5, creating an isolated partition with only
> CPU 2 inside will eventually end up affining the IRQ kthread to all
> CPUs but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for
> CPU 5.
>
> Besides the blind re-affinity, this doesn't take care of the actual
> low level interrupt which isn't migrated. As of today the only way to
> isolate non managed interrupts, along with their kthreads, is to
> overwrite their affinity separately, for example through /proc/irq/
>
> To avoid doing that manually, future development should focus on
> updating the IRQs affinity whenever cpuset isolated partitions are
> updated.
>
> In the meantime, cpuset shouldn't fiddle with IRQ threads directly.
> To prevent from that, set the PF_NO_SETAFFINITY flag to them.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/irq/manage.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 400856abf672..76e2cbe21d1f 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -176,7 +176,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
>   }
>   
>   /**
> - * irq_set_thread_affinity - Notify irq threads to adjust affinity
> + * irq_thread_update_affinity - Notify irq threads to adjust affinity
>    * @desc:	irq descriptor which has affinity changed
>    *
>    * Just set IRQTF_AFFINITY and delegate the affinity setting to the
> @@ -184,7 +184,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
>    * we hold desc->lock and this code can be called from hard interrupt
>    * context.
>    */
> -static void irq_set_thread_affinity(struct irq_desc *desc)
> +static void irq_thread_update_affinity(struct irq_desc *desc)
>   {
>   	struct irqaction *action;
>   
> @@ -283,7 +283,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>   		fallthrough;
>   	case IRQ_SET_MASK_OK_NOCOPY:
>   		irq_validate_effective_affinity(data);
> -		irq_set_thread_affinity(desc);
> +		irq_thread_update_affinity(desc);
>   		ret = 0;
>   	}
>   
> @@ -1035,8 +1035,16 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
>   		set_cpus_allowed_ptr(current, mask);
>   	free_cpumask_var(mask);
>   }
> +
> +static inline void irq_thread_set_affinity(struct task_struct *t,
> +					   struct irq_desc *desc)
> +{
> +	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data));
> +}

According to irq_thread_check_affinity(), accessing the cpumask returned 
from irq_data_get_effective_affinity_mask(&desc->irq_data) requires 
taking desc->lock to ensure its stability. Do we need something similar 
here? Other than that, it looks good to me.

Cheers,
Longman

>   #else
>   static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
> +static inline void irq_thread_set_affinity(struct task_struct *t,
> +					   struct irq_desc *desc) { }
>   #endif
>   
>   static int irq_wait_for_interrupt(struct irq_desc *desc,
> @@ -1221,6 +1229,7 @@ static void wake_up_and_wait_for_irq_thread_ready(struct irq_desc *desc,
>   	if (!action || !action->thread)
>   		return;
>   
> +	irq_thread_set_affinity(action->thread, desc);
>   	wake_up_process(action->thread);
>   	wait_event(desc->wait_for_threads,
>   		   test_bit(IRQTF_READY, &action->thread_flags));
> @@ -1405,16 +1414,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
>   	 * references an already freed task_struct.
>   	 */
>   	new->thread = get_task_struct(t);
> -	/*
> -	 * Tell the thread to set its affinity. This is
> -	 * important for shared interrupt handlers as we do
> -	 * not invoke setup_affinity() for the secondary
> -	 * handlers as everything is already set up. Even for
> -	 * interrupts marked with IRQF_NO_BALANCE this is
> -	 * correct as we want the thread to move to the cpu(s)
> -	 * on which the requesting code placed the interrupt.
> -	 */
> -	set_bit(IRQTF_AFFINITY, &new->thread_flags);
> +
>   	return 0;
>   }
>   


