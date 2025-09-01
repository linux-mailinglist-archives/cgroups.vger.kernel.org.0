Return-Path: <cgroups+bounces-9519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ED6B3D628
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 02:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4C51897A4B
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76AC1A9F82;
	Mon,  1 Sep 2025 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkUIhLTd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F091A2C0B
	for <cgroups@vger.kernel.org>; Mon,  1 Sep 2025 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756687244; cv=none; b=d4nNPevXGFC49pMGGQodPToYemncWFIBe6b8VVpTIztaPnH9OigQt/tTu0T26964AGcRFveRMZ9Y4xScCFA/UOjNmbDXkBaJxKYdYuBl9iWTIYDyTv7Dg67aJS4t+Rpx3xakIbUtxR4rHEhgcr/ed4ZeySM5O465mBWwJDe7erY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756687244; c=relaxed/simple;
	bh=JoblhYz9dahBRwMmaa0J547ZEkV9rIlv/henUU5I1gU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PXtXmFg5BHJ4xYi0fpRBomYb6SGuVAsFb4m3g5TU03kFvZHOuDjX0qmCgLfl/yi88IJzLI46qQmRfIA4wPVJ4kqDtDYD2AHKHRfDhVmFtwox5cIvz/v5RY+Wy2qilE2yI55JCiZd1Br9Q52+x3LfxD4YgKqh1i8nFllbOztLu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkUIhLTd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756687240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrMIwbKfMEb6yRLBP1w+gP1g3bNDdqYh5FsVhAbQTNM=;
	b=UkUIhLTd5eGPo+HwVHBNS71DDrpn9kyCx6Bu0bRKgUpgXiZ0OM5/quyVQaOM0emIZ1oiRA
	uQobLCA6sA0se7p5cOMFiAm0j8vsjzcRw7Nt9Uluw6LZtZ7WopkTC2PrTcK38wAgERFEkb
	rGTNwLQgMTKm/sx/T7x6I5fsCF3GZqo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Ob5i7eHiOsCOfYttlj070A-1; Sun, 31 Aug 2025 20:40:38 -0400
X-MC-Unique: Ob5i7eHiOsCOfYttlj070A-1
X-Mimecast-MFC-AGG-ID: Ob5i7eHiOsCOfYttlj070A_1756687238
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7ff94e5c251so245018685a.1
        for <cgroups@vger.kernel.org>; Sun, 31 Aug 2025 17:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756687238; x=1757292038;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrMIwbKfMEb6yRLBP1w+gP1g3bNDdqYh5FsVhAbQTNM=;
        b=ODJ7Db72cckf9yCXIgIU6JI66Q0nJ19UEwIbon/Z59mnE/QvZjSthlDIZm5Ud9TGPm
         9x1DGu0WF3oGRuMHJrFytLJQyVDmD35RuRuoIIHl+vwIAlmJQuxF8+45yTH+WHNY3uVN
         j/t/3UyqLQSjQnwwwQ6jDYDmZa7ff79GFHpP8wRrlGnfKHSDOfcg+hSfyiFoOiBcXaIk
         3LheDLXLAGBIMdfRAYTgmOIqVeBuVR3G1NtcIwPMxbbGhdMNL70LpdesiIXizAhIYqqw
         uOJaqT97iBZ36DA987VE5dT2UyDPS+U/+wZSPT+4agVDBxAEPXuFE7jPYVTUwujrd11x
         SX2A==
X-Forwarded-Encrypted: i=1; AJvYcCXYORKmHAiAZ2fbVPpfrkqIAxmdY/+ECZEbLjAE5DLYqzVglY+KT4Pe5gOeNNVtNa6KgGHX3YSp@vger.kernel.org
X-Gm-Message-State: AOJu0YzlH/OtlorL7sew0OqKSmlXFHJOssbVm9pLdjDqt1ixCffUEEkJ
	B1KRDGnV5vyhGpD0Neh4hP3eHK00ATGkbdYcsVsYnq0crRkPHtqRRbK3dye+8DoJm5Po8AJHAGG
	2eq+Uh95zOewrUfC1LdWJVgnyqvnThPdhvrRojoV7/xU/BpUDjIBXR92kAOM=
X-Gm-Gg: ASbGnct/TOYuNBQUFSMw1H6ElH00uy5jyLZDjTA4/2tr/FAgc5TrHFCzHdXzvY3sN5L
	+VwG2Y6UraT1mA0ByyoRdrSn9G7JPH1zoSTmlHK6KleGIrNhJN6reIHY25lEDaZGwXQh5oakdg7
	YcBOXtOxddOVZphSpsheHDbRGSbcSQgMRxhvE7+Deu6eoE5tDlk9t+8rjFYPNrFjQFfWcd1NwI6
	lwG8DEBwHJKYQAdEgJydsHlvApp2myToEkSS0QS5hhou85oRoCJJBThoizLfXooFE4tzJH2/L9V
	jwa0zal5HFlKpd17LSCbYTGneQi1KD+xZDYGqB8B7vlLEzw1GG479d4l3cjo+XOhBu/3Lzx9IOI
	tHXe1sP1KiA==
X-Received: by 2002:a05:620a:4593:b0:7f9:bd9e:594 with SMTP id af79cd13be357-7ff21cfd11cmr623811685a.0.1756687238358;
        Sun, 31 Aug 2025 17:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuAz+S/t2TQzzgl25NKg9V7UFRh37CBUP/APWizliriEmCulEECBq3MJRUYN43kACd53y87A==
X-Received: by 2002:a05:620a:4593:b0:7f9:bd9e:594 with SMTP id af79cd13be357-7ff21cfd11cmr623809985a.0.1756687237968;
        Sun, 31 Aug 2025 17:40:37 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0d86df61sm590022385a.14.2025.08.31.17.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 17:40:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a8cdeb85-2629-440d-9c11-69f6e19f8cb6@redhat.com>
Date: Sun, 31 Aug 2025 20:40:36 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-15-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829154814.47015-15-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
> CPUs passed through isolcpus= boot option. Users interested in also
> knowing the runtime defined isolated CPUs through cpuset must use
> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
>
> There are many drawbacks to that approach:
>
> 1) Most interested subsystems want to know about all isolated CPUs, not
>    just those defined on boot time.
>
> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
>    concurrent cpuset changes.
>
> 3) Further cpuset modifications are not propagated to subsystems
>
> Solve 1) and 2) and centralize all isolated CPUs within the
> HK_TYPE_DOMAIN housekeeping cpumask.
>
> Subsystems can rely on RCU to synchronize against concurrent changes.
>
> The propagation mentioned in 3) will be handled in further patches.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/sched/isolation.h |  4 +-
>   kernel/cgroup/cpuset.c          |  2 +
>   kernel/sched/isolation.c        | 65 ++++++++++++++++++++++++++++++---
>   kernel/sched/sched.h            |  1 +
>   4 files changed, 65 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5ddb8dc5ca91..48f3b6b20604 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -23,16 +23,39 @@ EXPORT_SYMBOL_GPL(housekeeping_flags);
>   
>   bool housekeeping_enabled(enum hk_type type)
>   {
> -	return !!(housekeeping_flags & BIT(type));
> +	return !!(READ_ONCE(housekeeping_flags) & BIT(type));
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>   
> +static bool housekeeping_dereference_check(enum hk_type type)
> +{
> +	if (type == HK_TYPE_DOMAIN) {
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
> +			return true;
> +		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
> +			return true;
> +
> +		return false;
> +	}
> +
> +	return true;
> +}

Both lockdep_is_cpuset_held() and lockdep_is_cpus_write_held() may be 
defined only if CONFIG_LOCKDEP is set. However, this function is 
currently referenced by __housekeeping_cpumask() via RCU_LOCKDEP_WARN(). 
So it is not invoked if CONFIG_LOCKDEP is not set. You are assuming that 
static function not referenced is not being compiled into the object 
file. Should we bracket it with "ifdef CONFIG_LOCKDEP" just to make this 
clear?


> +
> +static inline struct cpumask *__housekeeping_cpumask(enum hk_type type)
> +{
> +	return rcu_dereference_check(housekeeping_cpumasks[type],
> +				     housekeeping_dereference_check(type));
> +}
> +
>   const struct cpumask *housekeeping_cpumask(enum hk_type type)
>   {
> -	if (housekeeping_flags & BIT(type)) {
> -		return rcu_dereference_check(housekeeping_cpumasks[type], 1);
> -	}
> -	return cpu_possible_mask;
> +	const struct cpumask *mask = NULL;
> +
> +	if (READ_ONCE(housekeeping_flags) & BIT(type))
> +		mask = __housekeeping_cpumask(type);
> +	if (!mask)
> +		mask = cpu_possible_mask;
> +	return mask;
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>   
> @@ -70,12 +93,42 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
>   
>   bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   {
> -	if (housekeeping_flags & BIT(type))
> +	if (READ_ONCE(housekeeping_flags) & BIT(type))
>   		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>   	return true;
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>   
> +int housekeeping_update(struct cpumask *mask, enum hk_type type)
> +{
> +	struct cpumask *trial, *old = NULL;
> +
> +	if (type != HK_TYPE_DOMAIN)
> +		return -ENOTSUPP;
> +
> +	trial = kmalloc(sizeof(*trial), GFP_KERNEL);
> +	if (!trial)
> +		return -ENOMEM;
> +
> +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
> +	if (!cpumask_intersects(trial, cpu_online_mask)) {
> +		kfree(trial);
> +		return -EINVAL;
> +	}
> +
> +	if (housekeeping_flags & BIT(type))
> +		old = __housekeeping_cpumask(type);
> +	else
> +		WRITE_ONCE(housekeeping_flags, housekeeping_flags | BIT(type));

Should we use to READ_ONCE() to retrieve the current housekeeping_flags 
value?

Cheers,
Longman


