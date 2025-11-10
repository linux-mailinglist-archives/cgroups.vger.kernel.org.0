Return-Path: <cgroups+bounces-11764-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA4C4966D
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 22:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76168188B688
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14963301473;
	Mon, 10 Nov 2025 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9WJRqN7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZYrhWB2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211572FD7B8
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810135; cv=none; b=E+CxlRvzBwAMdtl9JtGi/rpF0w7LpBY4fkcARnk+J8lFBoKZjMmBhXHIy19xw9qiAItmaSRCiDlfbumjpbyPgrcZS/nmpvP2J4S4VUMSzZAIZitG1mIawqdKUnboucLoLuiPwm+LY0TMBFOkFpxeGcdVeri7W+HyUUWhgNxDA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810135; c=relaxed/simple;
	bh=hJV1ZGAGyaUl9lXmqxzKnqSPBe2fYFE359oyXqNyhj8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tBvMVIyBl8nR9GZ561Pxf+InRAiSY/7YhCuMIk0i8IHZnXCcMd/xTK+ObYit4YVNvnB3HKFpPF2zeSYndTpThaEDgkwy7xyBoDinVz+jHB8NwaXY0XgVh/xtZETtYPdngq/9SVF0h3WAG/ovwAY+QyXQvys0kThv61/jZv9yjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9WJRqN7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZYrhWB2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762810133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PAQvyhYw9Rcq7EQwkG/D+2q+HFJhzkXgLDAIQIi4rE=;
	b=J9WJRqN7Ecpv4Z3nwdiV7nH7Y+vQahiGmD+dflm8sQ7ZS1APP4L3RcdngwOL5Kj35ehYnb
	yM+qJd9PxgZ8HrH+YuzF+VvXQBA/zT7ijxn/g31kPsoVtshMx/Tza3AO0aRZftMp6E3W2w
	E+I7TSnm65UtMlg9d1Alp3dPOKPTTgQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-HyDgD866OSO6KvR26A3ZvQ-1; Mon, 10 Nov 2025 16:28:51 -0500
X-MC-Unique: HyDgD866OSO6KvR26A3ZvQ-1
X-Mimecast-MFC-AGG-ID: HyDgD866OSO6KvR26A3ZvQ_1762810131
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88050708ac2so111972896d6.2
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762810131; x=1763414931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9PAQvyhYw9Rcq7EQwkG/D+2q+HFJhzkXgLDAIQIi4rE=;
        b=WZYrhWB2AzYYQ4wIWZ9In5UwRyXkg6cKcPGuiElQY5+fjjCzIh3uwCyW/t79GX3G2X
         /0zjZR+jVR8g3F4yQsrx/vnwDph0a0mLl3tlYICF5y9m2D2Yi++EShkOezzea6cFiZUt
         NRrORbz0BRSIMH9dJGZ1MBhvVTzrz4LMfkZQc5SSalR71D9TseaTLdi5Ki7APpiXgUcc
         xYeRwk1m3mRXDKEQzKmwCstpbVGkrkTswY1qRd9T34//lW4YpyqdwpfiXxxaTeFLh5+r
         8IWJPjbx/39vCSVktdoqzDbwZJdSU7rZ5MRlMaCBiNA7R/nhZgkSiSFDIdnIj6wBILtP
         YS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762810131; x=1763414931;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PAQvyhYw9Rcq7EQwkG/D+2q+HFJhzkXgLDAIQIi4rE=;
        b=lq4MLWn3Zj/USRp8+1Gm+TI5X1mp0zZJ+neuILG9ihKMIVJ6j2qhpvVM7Uu+vbJnJG
         VnZkDZz4wY8AcgG/eo4kKzp/X6hpLdqLubzq+DUb3qk1k1GvNgz6j+OHzyKnudvpuDvl
         N0l/509pZQETwD6gXVvaQNqFhwi9t388Uqli+7Gmai5a7GLM82VfHYsgUijG/8qs+rbE
         oKEP4qbkl0i4/JcfuYVOnmYia94g/yMXLlnb9AN0K1PEwuRgmLTRjO2sdO/MI3KYdOXV
         HoIF7iPbj3VcteA+2p//Pf10q7gQiZHysHKlqBxYLHPSoOtyU0T4bnb/+Tubap09v2vE
         CoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB8PE1cfYYLyhXu6Hw1prKy9ydYq29FbfLEVsxb3osH9kaT+f1J6DP5v+1BFM5/x8NOI5D3Ypg@vger.kernel.org
X-Gm-Message-State: AOJu0YyIO1zrblC9o1HVmiqUoNndjA0uIIGz3LE2P8Tc/piBkciss2fi
	IUk4WfGYxryDIhA3PDAFf5Pl0MVzIMWGj+u29qEPvsoX/jB9WL6ookGy/ZSblhS4YqtHKYrzctL
	Ium7krgCqbK9xi6c8z1rmeEQrSG7hKurHGYZsDAznc6a7TAbkX6vO+MFIjXQ=
X-Gm-Gg: ASbGnct3P9nVsVGDM7Ajg+SEWHdPvGXrg0L9cdqtlbvkQkUKVyL1TBHNsDkWfZoQktI
	sVVOpi3qjKkZt+94GsMxYT8fv0NnRC3k6gwWynERg7rbhM88Wfg85EsMWdwaJaepeFR7JoikhuE
	HZ3swcF2N1fm8aQupaUPiF2iBf5BUS/wILU9k1ZKqMj+Ok1fwEwVhDiTzhasL5dJ67gjVjdO473
	/hrEal4YX2405IoPx2Vj06hf1aAsBlodehHuER82+htkjnfIc6+6BGhsBHRITnfr4J7s12wPa/S
	Iqi/N9g3KwUOrhXBN0WFQM6G6+bH0+7EKeK4+SnbGAVIbadK3yliguSqcB2qQtF00jiIFPqNNTQ
	iKcuC9HY6l1yL1n24QH97E6vIfff/Zw2+KT5IRibOgJRS6Q==
X-Received: by 2002:a05:622a:1915:b0:4ed:6032:f644 with SMTP id d75a77b69052e-4eda4fd55damr116622651cf.79.1762810131203;
        Mon, 10 Nov 2025 13:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeDJRiEDLUmd4/GMwSqIKz3yYFvy4/XOQH4UdNBPihOyrWzNsSl7rb/Zzqwa2yi59lEXN2JA==
X-Received: by 2002:a05:622a:1915:b0:4ed:6032:f644 with SMTP id d75a77b69052e-4eda4fd55damr116622341cf.79.1762810130666;
        Mon, 10 Nov 2025 13:28:50 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edb774e8d6sm33504041cf.5.2025.11.10.13.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:28:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5d3d80dd-00ca-464d-bebf-c0fd4836b947@redhat.com>
Date: Mon, 10 Nov 2025 16:28:49 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Marco Crivellari <marco.crivellari@suse.com>, cgroups@vger.kernel.org
References: <20251105131726.46364-1-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251105131726.46364-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/25 8:17 AM, Frederic Weisbecker wrote:
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
>   kernel/irq/manage.c | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 400856abf672..5ca000c9f4a7 100644
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
> @@ -1035,8 +1035,23 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
>   		set_cpus_allowed_ptr(current, mask);
>   	free_cpumask_var(mask);
>   }
> +
> +static inline void irq_thread_set_affinity(struct task_struct *t,
> +					   struct irq_desc *desc)
> +{
> +	const struct cpumask *mask;
> +
> +	if (cpumask_available(desc->irq_common_data.affinity))
> +		mask = irq_data_get_effective_affinity_mask(&desc->irq_data);
> +	else
> +		mask = cpu_possible_mask;
> +
> +	kthread_bind_mask(t, mask);
> +}

This function seems to mirror what is done in 
irq_thread_check_affinity() when the affinity cpumask is available.  But 
if affinity isn't defined, it will make this irq kthread immune from 
changes in the set of isolated CPUs. Should we use IRQD_AFFINITY_SET 
flag to check if affinity has been set and then set PF_NO_SETAFFINITY 
only in this case?

Cheers,
Longman

>   #else
>   static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
> +static inline void irq_thread_set_affinity(struct task_struct *t,
> +					   struct irq_desc *desc) { }
>   #endif
>   
>   static int irq_wait_for_interrupt(struct irq_desc *desc,
> @@ -1221,6 +1236,7 @@ static void wake_up_and_wait_for_irq_thread_ready(struct irq_desc *desc,
>   	if (!action || !action->thread)
>   		return;
>   
> +	irq_thread_set_affinity(action->thread, desc);
>   	wake_up_process(action->thread);
>   	wait_event(desc->wait_for_threads,
>   		   test_bit(IRQTF_READY, &action->thread_flags));
> @@ -1405,16 +1421,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
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


