Return-Path: <cgroups+bounces-12767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EACCDF1BC
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 00:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 318BB300F9CC
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8F30F81A;
	Fri, 26 Dec 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5ULQChj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGMgwsnv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3226B2DA
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766790536; cv=none; b=gUWcP0ULoqRHUAe3aQ1l6AI+zvqf0NIXsLbnxMLoUo7RzaL2MXTbfkmEwXEDJkpjxObWUzYOyZ7EsSjKzkN+a1io4SoZVcJyyEpk3G9gCvnWo6ja8AP78v83Qu2XmuQaf8oPF1nfqAR0EzV9hKR7+A+eEGHCXBwjFqezlgDYAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766790536; c=relaxed/simple;
	bh=oghaDqCtoGuDQNAmtHfUkftbTAQMnzWTPNUYgFydFis=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZrBnakCq37b4/KGN9dAOoQRsUrm9EQJ4sK0xWaztCVdr8gMPnMdDCzV08AsaMlcn8N6rUtID2dnJIBChhEuckeEkeNllDoXST9gEx/7mx5gu/xmVMggUx9RcqKF1EGHo/nXVf76ZRL63ku7W96OJ0C8px77o5c0TZgOdu1KBBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5ULQChj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGMgwsnv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766790533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
	b=N5ULQChj3waHbp5JqOilPGouwqSvFnriOeVsIcIceHVuRNFf+tQ3+oRsuiOqgBXlJ//H94
	vAKxXsupdXBy363SM/u6u7X9NWKbGjvZozmeJjg3GksuMzqVFkFx130Oz0j/ViDgIlTSdx
	PNe3kVV9U2QuHVm3T1ndtjdTyNW8Dqw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-GMunjhi4MP-DwqBWXT3zkQ-1; Fri, 26 Dec 2025 18:08:52 -0500
X-MC-Unique: GMunjhi4MP-DwqBWXT3zkQ-1
X-Mimecast-MFC-AGG-ID: GMunjhi4MP-DwqBWXT3zkQ_1766790532
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a25a341ebso179394836d6.0
        for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766790532; x=1767395332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
        b=dGMgwsnv0ChuiXtLIILgLtrBDzrl/8rCZlKeDtFn6vlyqKI3A3ulUNtS4MJEaWzGJg
         g253MNP+/r7OZjMZIm0KBgWZH1cfclKY+IUasqv9Uuk7rFAIL36uc/l4Y5ehbzQGX1B5
         H2iE79XQnxOH+ji2ExBkeq8tYKRabhSoKIpg9HnWYySn3GCv1GxDtBhGdY1Lbh++GizH
         o0gWSAqGxns5+2l/VtkIm01L4g5jaNxedVoqr1jEby4WlEQDO/A7WTBL7v9Gy5oF4XvO
         rUfmrTyQxddn2AI0+5Zzs7k42xgj7UoqHOXPIkx2TvSAX91bX3dx7cChlqz53Fz++WLN
         n/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766790532; x=1767395332;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPVYyOhmWYyUzd26KqEqEx9SiJ2wqcstK13CbukMaus=;
        b=C1CxF9aiK/axbb46Hn0PLFI364ggy7gM42Hszu00TjJx4LPBwAXL12LBvbRrDMOGkL
         1GERmFsZF9Afy/5NFX/L9zEAE7VO9skIJ+60Wa2m5PsLNlYOskiE/w99enE2D5WkcLM8
         zPy6tAmO4xRTg55UzGEdgWzy8jGfW5t1ZWtS3o8IgP1ZpdrdwdmxJSe/v1F+dLEpgWiK
         4LX5tvI7G7+W24soiR5q4KBubrrSBAkbtBk4M90DMvc1ufRr/NMPxU71fVEuXRjOh83j
         5ObuwQH0Ts1iuYMzfD06Ep9KMU7sCcYbvvgmvFochZd4t/Z0PvCNlQ3ZQ9Y9ymNJMltr
         YPbg==
X-Forwarded-Encrypted: i=1; AJvYcCUXjz5mwenz6eeu3Mj6L5VJNW6Ou8nBU2NV89hms0T+WyEYTXiclfNp1Yh6rPXX4ykdxGcsSPw1@vger.kernel.org
X-Gm-Message-State: AOJu0YwFieZBIpGXAIIUtgu2cfRkF34ojbTghJG0ia1CTZcds5jQjJ0+
	x9w+K0zmZA4ZG5EpFnO+/ukPqoNvBBKUXh2vlLFNoyq9BEgFllZKIFyKwIHGp2DuNOFL08eLXuB
	f6whhMtcW349IcDmBGuA2N81ONeyFJXHx1HtsqniJlH7ttRS+BqJYQTKKuZ4=
X-Gm-Gg: AY/fxX57CLklJvV4mxA8JSHhJzCYPYaQiyvNFRGpv1nb/EaNlcwW7WhR2hhRJdAxXJ8
	pttAA0+BZ7aswhQULtRPAdId2IFHwP9T+XGZwD2i1QoH00wfUmEejMFDLXikGw1uaOkqXsURSSt
	KRsZRAoW6aSovVGRpwdcYJT6CC11LUWN0FvuKPzY4mgSeJTsleNtWfYLHmRxbr6syc35ssgP7kL
	JFSg5v11R7AVDKtDq7WJLLS9f3QMxe2jAlMJ1Or4z1qG9Z5tK6qu8hGLN2uCqh1VnLeHssDl8U/
	lzxsbxHbuEwVw36oahKt0EA0DST9PsJbHrDU6pZkS3hELS3AbcNw6k03ikn3DNMATs4Kc5pJOF1
	AD1DWvYbMtTfyC7ekvq4B00sjUaHBQ8x2nhTluKnPGZGo97TMZPCg/fEM
X-Received: by 2002:a05:6214:48b:b0:890:e31:9685 with SMTP id 6a1803df08f44-8900e319a28mr37823606d6.69.1766790532040;
        Fri, 26 Dec 2025 15:08:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpv55vF+vDJeT6imxDEvVCM6zgRYx4B3T4/k2S1vjNooJ5kJOtFWemCi2nC+rcnjO9pXNW8Q==
X-Received: by 2002:a05:6214:48b:b0:890:e31:9685 with SMTP id 6a1803df08f44-8900e319a28mr37823076d6.69.1766790531561;
        Fri, 26 Dec 2025 15:08:51 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7dc1esm173664886d6.39.2025.12.26.15.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 15:08:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2f892ef9-1965-486d-beab-eacf0b6b0386@redhat.com>
Date: Fri, 26 Dec 2025 18:08:43 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] sched: Switch the fallback task allowed cpumask to
 HK_TYPE_DOMAIN
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
 <20251224134520.33231-29-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-29-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Tasks that have all their allowed CPUs offline don't want their affinity
> to fallback on either nohz_full CPUs or on domain isolated CPUs. And
> since nohz_full implies domain isolation, checking the latter is enough
> to verify both.
>
> Therefore exclude domain isolation from fallback task affinity.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/mmu_context.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
> index ac01dc4eb2ce..ed3dd0f3fe19 100644
> --- a/include/linux/mmu_context.h
> +++ b/include/linux/mmu_context.h
> @@ -24,7 +24,7 @@ static inline void leave_mm(void) { }
>   #ifndef task_cpu_possible_mask
>   # define task_cpu_possible_mask(p)	cpu_possible_mask
>   # define task_cpu_possible(cpu, p)	true
> -# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK)
> +# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_DOMAIN)
>   #else
>   # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
>   #endif
Acked-by: Waiman Long <longman@redhat.com>


