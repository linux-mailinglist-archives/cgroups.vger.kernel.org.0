Return-Path: <cgroups+bounces-12160-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99CFC7AD90
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318E33A158A
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8F934D906;
	Fri, 21 Nov 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5XBqAVs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYEGe/ZW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C0349AF7
	for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742552; cv=none; b=tILdYbQZAX+X0C3+ZZlL8V8ivbTCnwNAO0kYFG40gGnZKGHB23aFszPyJb9YOHJU1vz5ZprGfK6miVjuOV2Aj6ScltBRRcT8Sv6vEum7GpDgGobXovNSAwz9Q9huJZSp0kE4FJFMmfy+hn/HmX0HQiZShzShxGsA4mluISNViRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742552; c=relaxed/simple;
	bh=979HLQC3lNQXGFCiSXcooaaUGR8SYmMAV/7MPWiZUSM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IA8wxH6KkQ9pGDPXbLiIeJhbQIII/MEHIf9Sd1NjMKPsBJkXW2UjS2ZzpBILE5gzwGNSJsB9l1f6EWRyP7o7Ej7qd07TEoaKMRwsiYbQ7pfz+sb7/3zjDulsTzO7WosFjFsaY2aCDBQd6yfQjKMaep0kkMoZZqC1l5Pjkg3YDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5XBqAVs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYEGe/ZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763742550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VOjYq9807PzFVxfU83VO6JTqxLAvw1GjBkW/sIQ1XY=;
	b=a5XBqAVsNPIBaLZhn2dRkSVSPi6CXVmGtHdIUtmdP4XuiA/ifDj3k1uea8HfX8sP6ynDXg
	Tgh+642CJCSA+9MpEyWiII/UN6t5+qf18g1HWWM9DoorI8gQ+h487UkFlGor/0w1r9X78h
	BKs1yhrlW4bdXiPw9Ysb07jVvibpYlo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-EvsAvCM9PCeCG4IzMNLfqA-1; Fri, 21 Nov 2025 11:29:08 -0500
X-MC-Unique: EvsAvCM9PCeCG4IzMNLfqA-1
X-Mimecast-MFC-AGG-ID: EvsAvCM9PCeCG4IzMNLfqA_1763742548
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6e701d26so54482791cf.1
        for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763742548; x=1764347348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/VOjYq9807PzFVxfU83VO6JTqxLAvw1GjBkW/sIQ1XY=;
        b=YYEGe/ZWCUyRif85/csNw0mGQp1aVXXfvUg0lNEJBag0dZqsM2VvdDxiD8QpAIswAX
         yYYwlL4W14ySflquf6GfmuxlZPWrW4wlU8NK4Bi3OQRhmEC5Ff5gXWHVKFTDOCeAVQpw
         qKlmsJVBIM+0fk3LHLDw9a0IF78WLnXAzOVvKrOYezr8DlCxRljOIv99BIUemPQZSkn5
         09hVCclGM9b2lliIbG/b3fIeuBM9CMLrMaFH83tu41PhE/3neplRXCRHfrrwufWp9/MQ
         RxwUb64rxjAY5nYBcjrH0wXqyYAKL86exn827pTkyRxi2yFKShEiIX3nyzGCeu9C/v72
         5RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763742548; x=1764347348;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VOjYq9807PzFVxfU83VO6JTqxLAvw1GjBkW/sIQ1XY=;
        b=J/TKTBZKIO9y5q1TXeFqaxPVgyMrUNfsiSEeauZaTpS+yTjuxF8vaZ1rQwz51dl82w
         2aey4v+smxmfF1RaKuOD0LIvctQSuQ4ih9T/REGt+dPwOg8/Ul3cGr8DRVoEqVbztYxw
         AGZYf5ja3h15fpF7ZZNE8u+sOqDuhhxbAQ/dEQcMvimXhZI9UnpiLzv7hjv2gMO6WjJf
         f5BWDm6Z7PaFwiuC6JKPHSVK5jv3a8ZuGU513b4BXPeoiD/aK7317smws9lOwBLpVdQy
         +Jeh9ZatAmorsr9lQuS/OLc3lhRyVo684muH+6V61ihyTJcRHnsAeeWMx6ejFM554Ggh
         qYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsRJ+MOv7KKf5rx8wMkxUebxhrcS6QRza1Fs1enXXym8fw65wk4X/U9mqCLoaDA3CZnJMi+1sY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2X2BhN6iIzohcMf8dYrHruum41SnuOv/ms0/mQPpOc8fK5z1e
	phxPnSseBzJcv/a9JhT4OTnNtKhZ2dsD3WtKGcrFxbXzTzWy3SxEwFlzn37s721e4L/6yN7yoDN
	ZR9Yzb0w7LLBykylWdl73gIj030sAkD4x9DKJ21vBgi8KGu1XLFAkb7LRvsd9el6yhno=
X-Gm-Gg: ASbGncsENpIRu2Sgj2XYgHS5j9YRbw6yAAVgHvm/XJSXXWimZfi6/eeWWwinJ1nb8QZ
	a2MlHdkR1XaAz+xlWBkbd14Yf26zMtiiS6ALbtZhTiU2d0qOerQPliH4bMmMXl95uAxwBBoICYa
	VliLNBpSeoj1OYWsFSRFAszHBROb5GzMaHHfTVznmIms3qL/fYM4HsgMJ7owgwDDVcQfbniqABp
	FTvhW5y7sQ35Prx9quiNkuwAn9oGspNbHO8kFifkXQLL8b2bezGOfPvptamB5AZSHM5FUzcSnST
	MSLz5ZezPKTBXQPPj2bj7JdKz0vutEIeoVcsEczzPcJFH3JB3HSMamJcSrh+EVUJF6et8Pcx2pk
	7b+QxvN2LTC/LrF2ELg/znXihES6UMS/9v89BCl30csICGesxRLayc9jK
X-Received: by 2002:a05:622a:13c6:b0:4ec:f9a1:17c5 with SMTP id d75a77b69052e-4ee58841de4mr36845281cf.10.1763742547946;
        Fri, 21 Nov 2025 08:29:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHplEocfCvbd0HWPMxEJVKcY+zZIueRg99xqK5/OjwLx6+Fz+GigMFjCtRmsIqmoqqlZX79PA==
X-Received: by 2002:a05:622a:13c6:b0:4ec:f9a1:17c5 with SMTP id d75a77b69052e-4ee58841de4mr36844891cf.10.1763742547473;
        Fri, 21 Nov 2025 08:29:07 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48d3a8d2sm38005971cf.3.2025.11.21.08.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 08:29:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dae1f8fa-72c3-4e6a-a097-aecedcc29306@redhat.com>
Date: Fri, 21 Nov 2025 11:29:05 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 v3] genirq: Fix interrupt threads affinity vs. cpuset
 isolated partitions
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Waiman Long
 <llong@redhat.com>, cgroups@vger.kernel.org
References: <20251121143500.42111-1-frederic@kernel.org>
 <20251121143500.42111-3-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251121143500.42111-3-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 9:34 AM, Frederic Weisbecker wrote:
> When a cpuset isolated partition is created / updated or destroyed, the
> interrupt threads are affine blindly to all the non-isolated CPUs. And this
> happens without taking into account the interrupt threads initial affinity
> that becomes ignored.
>
> For example in a system with 8 CPUs, if an interrupt and its kthread are
> initially affine to CPU 5, creating an isolated partition with only CPU 2
> inside will eventually end up affining the interrupt kthread to all CPUs
> but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for CPU 5.
>
> Besides the blind re-affinity, this doesn't take care of the actual low
> level interrupt which isn't migrated. As of today the only way to isolate
> non managed interrupts, along with their kthreads, is to overwrite their
> affinity separately, for example through /proc/irq/
>
> To avoid doing that manually, future development should focus on updating
> the interrupt's affinity whenever cpuset isolated partitions are updated.
>
> In the meantime, cpuset shouldn't fiddle with interrupt threads directly.
> To prevent from that, set the PF_NO_SETAFFINITY flag to them.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://patch.msgid.link/20251118143052.68778-2-frederic@kernel.org
> ---
>   kernel/irq/manage.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index c1ce30c9c3ab..98b9b8b4de27 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1408,16 +1408,23 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
>   	 * references an already freed task_struct.
>   	 */
>   	new->thread = get_task_struct(t);
> +
>   	/*
> -	 * Tell the thread to set its affinity. This is
> -	 * important for shared interrupt handlers as we do
> -	 * not invoke setup_affinity() for the secondary
> -	 * handlers as everything is already set up. Even for
> -	 * interrupts marked with IRQF_NO_BALANCE this is
> -	 * correct as we want the thread to move to the cpu(s)
> -	 * on which the requesting code placed the interrupt.
> +	 * The affinity may not yet be available, but it will be once
> +	 * the IRQ will be enabled. Delay and defer the actual setting
> +	 * to the thread itself once it is ready to run. In the meantime,
> +	 * prevent it from ever being reaffined directly by cpuset or
> +	 * housekeeping. The proper way to do it is to reaffine the whole
> +	 * vector.
>   	 */
> -	set_bit(IRQTF_AFFINITY, &new->thread_flags);
> +	kthread_bind_mask(t, cpu_possible_mask);
> +
> +	/*
> +	 * Ensure the thread adjusts the affinity once it reaches the
> +	 * thread function.
> +	 */
> +	new->thread_flags = BIT(IRQTF_AFFINITY);
> +
>   	return 0;
>   }
>   

LGTM

Acked-by: Waiman Long <longman@redhat.com>


