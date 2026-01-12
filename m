Return-Path: <cgroups+bounces-13093-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA48ED14BF0
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 19:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E61E301EA1F
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FB3876A1;
	Mon, 12 Jan 2026 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWpZ9Lrv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="guWZ/pOZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D2387561
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242241; cv=none; b=L8qLk6I2B6YTHBA5dwfBUZtceRSYdJ6MKOCwwPIPlQJPRTWZ3kD5zFmJNp5UjIseLHlhzZ4+KJg1JhCazskBVc90tTAbZ+aUdJPm9g9DmpFB7gtjRwB2y5umO2RYWHrRbDzLBnxh/syoQ//ITNBZsSANNd0LNHkEFqs2ulfFjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242241; c=relaxed/simple;
	bh=zpoNdTeaB4i3QK4pd6pXO1rrYW3DhRqSBMGvDT0il6g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q6gye1TkwkSF/CDOqAFVC8OBWvNVlGRviHFvBwn90kHSCf7/o/EdNtJlZYu2pjxrHgwWuPSw5SwybSQ2j/uPw+bYrmiUmYHGK0xTRvGx5wzxwYuFYC7wJv8T+FmhubYiCaRa9bBU5KWrrtjQexueC8HA7Q3K6B3v4nZ10h5cC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWpZ9Lrv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=guWZ/pOZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768242239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gLOxIDyxhTvVzJuSwvSFZ4MlqhsCFk9OHFtuRb1ESk=;
	b=FWpZ9LrvYHiS7aGdljd+Igfcct2cokATR6+D5ebFep8iti98uX0GqcrakCmUdIlJh8z3o/
	eHRLERNxEe9QPsW2VDqS2q5yvNLWuPgqzxtjJAewEQbRjK+OuvXSF2ATwYstzR/B+Kwmmw
	aHufBShApfcsR1sjFnEi4/uVfHYjqis=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-0q5LREIYMdCXuJzqUFrsQA-1; Mon, 12 Jan 2026 13:23:57 -0500
X-MC-Unique: 0q5LREIYMdCXuJzqUFrsQA-1
X-Mimecast-MFC-AGG-ID: 0q5LREIYMdCXuJzqUFrsQA_1768242237
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ecdaf59131so5202696137.2
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 10:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768242237; x=1768847037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2gLOxIDyxhTvVzJuSwvSFZ4MlqhsCFk9OHFtuRb1ESk=;
        b=guWZ/pOZLgLBpVMG05eI3nl8fDNrxtbg2JeJCnJpCJrPxAsxB0oM8wX1VZpMXoNChX
         pxVtL3oEQmmej+J7Eoz8v2sBGDeskbAevIn9NmTy3ojM3gvsNXW2FCX7PLS/gSwFs9Rg
         22898MVltwFNGxKeyaMy5jSocMHB7lcT1a6L12IkSe0hAwRkjhrPwbyiDdX6Q6ipjmqT
         ACAnBfRKxgkyS7q8cV5a2zWbQWX23rvz/z6tCe1AjFaUArNLOnZJ3Ouwlsk2WJK/lbk9
         hYiI6TnNwFUjKyE28XmfU3yhWW02R0ju/S/QE4BQz+4ubhR5V1itNdkLypLRsXsJi1Eg
         EMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242237; x=1768847037;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gLOxIDyxhTvVzJuSwvSFZ4MlqhsCFk9OHFtuRb1ESk=;
        b=ilr2dH7JT/nInoOHuOL13obxepGcfP0rjZNtW+Hd7wWQyKyMXlMh2Dt1EI9wScFWNA
         /Iwoa064ggjfHK+59WLltT7k7yG6UFgTNjRlGdgzeBv5xaRIo6rKXauxwN4qVK4fYbm8
         N/NeaPINPNtHktmnpNzeMu3OzvjEmFIhETmRJttx7TWLjQHqHnCeUcSyFQkoIzSxGx8A
         SS5N3RtnVtgEqH/EYewlXl4z5xL7sSTW/z2d4p7/uFCq8iK7ZhaMiJ/n315KnIOv4Rcr
         sFg0vCCr9VfMG+wqM1PFK8URSmf85F8qX+bm01NBITCD7I93/z1WPtgjYF0moRDlIoQ4
         BRiA==
X-Forwarded-Encrypted: i=1; AJvYcCVTz7PNEoWcx/qt5Otili9N0C8L+gMt/RdRpzW6ZrfbVUgW3X3KDVewgt06u7EQRCNzjaMiCpi0@vger.kernel.org
X-Gm-Message-State: AOJu0YwICEkChrFQlO2bePL6GNBBF3gAsSf2O4b6Dzxk9Qub2MTSEH7F
	+K2sAdWNn4MNwQMmFKojh4qt1VqIPUPblcptztr1Wsz3COII+NBqQP2dTHEjqEpGoqvZN9TIz73
	2/rjpkS5LhrL8T8ee5gOqdSif0/kvus6LPDMYlxMZVqPUxx+iyEgN2tpymjo=
X-Gm-Gg: AY/fxX6N+PGBVm33R9IjA1d66XklZd/SKEm8s7c4aEdT4Rwh2GJyc8EGk/xrvop3e4F
	EB6ThpVwxJv13KJhLwycQGeWN9gL7BXuAXP9oCu8IVtPe80xPL8e//VkuNULSWVp/pzs3C/pQzu
	dPhHO02ni+a1zfEVKIQrvaCROA1XZriYcLH55/2XNRN0saykZ0TKNcRF+5Lx8bozq4jtARvfGfM
	Me1W0BLPXfx3lcNdu1NKNUSebxkjA+OSCuzo+18j2r02B+6P8CU7M796mPXcmj5ns+EROcv4QfN
	SET/stUHUUJ3TgR9h0si3lOpJvAmM/L+g2DLN+Xe+q/MUXyH93Hjx62zLLoCh0tq+CTqnLpXMQO
	ri8TVibg2GYdnHVixmBjbCpTrwxHww460kIasUgcspQvwPr/EoFgbBHd1
X-Received: by 2002:a05:6102:ccd:b0:5ef:b5fc:dd4c with SMTP id ada2fe7eead31-5efb5fceabcmr2465149137.7.1768242237201;
        Mon, 12 Jan 2026 10:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwmHNbjOkRHiOzASiFvy8qH079mvHRUgTgzybGWlZGH94huRhJ7zei/lWRFsGQLOin7Q4KDw==
X-Received: by 2002:a05:6102:ccd:b0:5ef:b5fc:dd4c with SMTP id ada2fe7eead31-5efb5fceabcmr2465086137.7.1768242235294;
        Mon, 12 Jan 2026 10:23:55 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ef15be79c6sm10965711137.12.2026.01.12.10.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 10:23:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <437ccd7a-e839-4b40-840c-7c40d22f8166@redhat.com>
Date: Mon, 12 Jan 2026 13:23:40 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33 v6] cpuset/isolation: Honour kthreads preferred
 affinity
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Phil Auld <pauld@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Michal Koutny <mkoutny@suse.com>,
 netdev@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>,
 linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, Michal Hocko <mhocko@suse.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
 Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Simon Horman <horms@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Gabriele Monaco <gmonaco@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 Will Deacon <will@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>
References: <20260101221359.22298-1-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20260101221359.22298-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
> Hi,
>
> The kthread code was enhanced lately to provide an infrastructure which
> manages the preferred affinity of unbound kthreads (node or custom
> cpumask) against housekeeping constraints and CPU hotplug events.
>
> One crucial missing piece is cpuset: when an isolated partition is
> created, deleted, or its CPUs updated, all the unbound kthreads in the
> top cpuset are affine to _all_ the non-isolated CPUs, possibly breaking
> their preferred affinity along the way
>
> Solve this with performing the kthreads affinity update from cpuset to
> the kthreads consolidated relevant code instead so that preferred
> affinities are honoured.
>
> The dispatch of the new cpumasks to workqueues and kthreads is performed
> by housekeeping, as per the nice Tejun's suggestion.
>
> As a welcome side effect, HK_TYPE_DOMAIN then integrates both the set
> from isolcpus= and cpuset isolated partitions. Housekeeping cpumasks are
> now modifyable with specific synchronization. A big step toward making
> nohz_full= also mutable through cpuset in the future.
>
> Changes since v5:
>
> * Add more tags
>
> * Fix leaked destroy_work_on_stack() (Zhang Qiao, Waiman Long)
>
> * Comment schedule_drain_work() synchronization requirement (Tejun)
>
> * s/Revert of/Inverse of (Waiman Long)
>
> * Remove housekeeping_update() needless (for now) parameter (Chen Ridong)
>
> * Don't propagate housekeeping_update() failures beyond allocations (Waiman Long)
>
> * Whitespace cleanup (Waiman Long)
>
>
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	kthread/core-v6
>
> HEAD: 811e87ca8a0a1e54eb5f23e71896cb97436cccdc
>
> Happy new year,
> 	Frederic

I don't see any major issue with this v6 version. There may be some 
minor issues that can be cleaned up later. Now the issue is which tree 
should this series go to as it touches a number of different subsystems 
with different maintainers.

Cheers,
Longman


