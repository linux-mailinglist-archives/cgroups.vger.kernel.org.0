Return-Path: <cgroups+bounces-12725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CAFCDE21B
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3361D300B911
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591122BCF4A;
	Thu, 25 Dec 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSOw+OGR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q7aHiHAh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD327E05F
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766701685; cv=none; b=uQnrqKS8FPzc4FtXFzekkCUd9xVRczdNak7NhZFA+vQA5lDZfknCJfoanq4WnLu+cUp6+pvB6nf1h7NPEF5onbwnrIA7u5ucBZSuhAT408ncohS/a2Zqu0fcAG0/Cmm22RmjhDXyIgqxqYoRVTBAM8es44DJfKwOcylMVTSZ0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766701685; c=relaxed/simple;
	bh=ly8xlAcwEq5AylEYJRI18D+dCgZKx0t1PbpMqP7W2Io=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MqJw8MYV+FHUsp+dMXc2aLRW2VxgZn4M5+kK5Joh5bhmr9Dd12zDihQayImGXIuULS8fhjvcG/1dbXqmHYwX7hsDD4cRf5CuICx5++CQys+pt34nn+G37oVKgAOIVFNtCFkcfNQ9aRShyX6A4lPZIHoYNvNkzJ5L16NN59uWFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSOw+OGR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q7aHiHAh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766701681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
	b=cSOw+OGRHLgmekV4vjsqdGW9ahqzupW+zMotkvdJI1XRWufmWBruEViL2tDwMjr3ism/KO
	SvYv6v/1g4c/y3e77aHBIjZ5Kh25PGCs1q8lreUgHoYduUqF4ryWOMGOtKuS0wbby/zUk/
	urEWql1HdMBEUR89l/eXMQzfC7IlNnk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Y4_rP4s2MFeCeZ4-0-3bvA-1; Thu, 25 Dec 2025 17:28:00 -0500
X-MC-Unique: Y4_rP4s2MFeCeZ4-0-3bvA-1
X-Mimecast-MFC-AGG-ID: Y4_rP4s2MFeCeZ4-0-3bvA_1766701680
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a2e9e09e6so234930756d6.2
        for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766701680; x=1767306480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
        b=q7aHiHAhKiDFctYhmJS8WvOtJaLGJJEUm41lj1/1YVBLxmzbbIDbpp1MWcUFgJGuEw
         2/EMTXdVNHQYo0PqfBqjIPv9eBwmHTUegV+Y98OtcB8cdlCbGOSQzFdIQ3HZ2/aCWKGB
         iCTtxpM2oQThBS5VplpTT0UkLMGVYf0pSZpZkPkCVHg9CEcEUjt+AZ01K8hMCwY09ZIY
         bhe3xukhHvsQ/06yaEwMhpILaP4JSKuwPo5iu7iRW+kUzuUQxkJlwVo0cfQT/loVNRe9
         IcbgVKJN9brswEY9XFv4jEV95MdxoPFneV5GYiiRKRPDJioBQCBE++lCpNVRhQGmXz3X
         RAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766701680; x=1767306480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
        b=bv7b4yem7WdiaLShcn3jJQqzHqPPcTd3G6BfkcSWUrTObyWfpyVhhptysYSZM3DT50
         6hz4TGykkfnD32bffM5IBzSRGTmSjVm91pOhyKjVu5cECY/WUPOCXz7VzH3bjEcV/5+K
         iWx4ToWpB6VT5spQjJ4DI/nphVHA1mTPFnILd1qmJ6bmIi3AzDXckvzruAho3sdF4Lvl
         V2mZFj/KigopOCnuxumc/DZfdH63dEyL9Ueh1cz4mE5GLjjnh+srGoRs7HGz+9VWuxBn
         U07s9EVblf3EJ8ViY4YQr8/cijpwLWNSbY2W1+pxmHAPAbbjtI4zDAdCLFSk7d8wRpg/
         MJyw==
X-Forwarded-Encrypted: i=1; AJvYcCWR8jToTnY8wtARfe360zS930bK8sOBTA7ftinAfrHf16pAcZr8xlVko3U96+VanrTvRbyzU5Uy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79K6CW0Q19+Z24ULwweq7nrXvldNLa/C5cG0cTJbZQphA27gi
	Nqmnh0hB205TcCAmnrVBf1vYhs4vIv+lHzRy0LY7pTQuE5hrTXhBmLzX92xUD08BEhLwEjFecRy
	wMQfhgF+I2xlaq22h5ONaVaDNj8zAgy1+ILfnTfA9WsUz+Y/0hAnaJBp/xhM=
X-Gm-Gg: AY/fxX69K37ZUTqN+EWCA9sHLKNl5wu6gmqgByJ6wYjyx7y0TFl/Yoq0QgASbtvTnkU
	hudC3I6V8DgzvwzuMT3ift2hJ4awvmCGoS6O83H8paNVdgSETngd6px27TeHtrgvsAPtd1dTtDI
	5C1uQaglAt0TXqW6T9n6DK7PPZiRkUpLMntEeLUj6W8Soc9G7oPKjPDcnmyNCH0g225T8at5vHs
	MH4/7J8Gqn1KXUAS1XIUEUQFRFMGuaR/tCmfBVdqpjNEXlOAGN2IItjd5qhAy/X+i05WnvFZjcU
	hnN7xEecwRAUBEdF1OhKIYauXqmMm+ksBEcpFqxLZdCbQghG+qj/1evg+L0c82/fvU/Qa6XtyTZ
	Sbjar2BQfuXdKBWYzOfwBGl2WiNDVj4qmso2RQVaCceQiZ9/pGYVwHg+M
X-Received: by 2002:a05:620a:414c:b0:8bb:26db:e22f with SMTP id af79cd13be357-8c08fbb5432mr3197588285a.30.1766701679940;
        Thu, 25 Dec 2025 14:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkk34PfoZDZVXHOsdvaSoOtEJlSomrI6NhnO1ciZ/uaqISBnHAQBKZ+i37TxyEDRNXrTUZhA==
X-Received: by 2002:a05:620a:414c:b0:8bb:26db:e22f with SMTP id af79cd13be357-8c08fbb5432mr3197585085a.30.1766701679541;
        Thu, 25 Dec 2025 14:27:59 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fdasm1605628285a.35.2025.12.25.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 14:27:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <04708b57-7ffe-4a97-925f-926d577061a6@redhat.com>
Date: Thu, 25 Dec 2025 17:27:54 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-6-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-6-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:44 AM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
>
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
>
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>   include/linux/sched/isolation.h | 4 ++++
>   kernel/sched/isolation.c        | 5 +++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..109a2149e21a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,8 +7,12 @@
>   #include <linux/tick.h>
>   
>   enum hk_type {
> +	/* Revert of boot-time isolcpus= argument */
> +	HK_TYPE_DOMAIN_BOOT,
>   	HK_TYPE_DOMAIN,
> +	/* Revert of boot-time isolcpus=managed_irq argument */
>   	HK_TYPE_MANAGED_IRQ,
> +	/* Revert of boot-time nohz_full= or isolcpus=nohz arguments */
>   	HK_TYPE_KERNEL_NOISE,
>   	HK_TYPE_MAX,
>   

"Revert" is a verb. The term "Revert of" sound strange to me. I think 
using "Inverse of" will sound better.

Cheers,
Longman


