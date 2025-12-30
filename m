Return-Path: <cgroups+bounces-12804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A920ACE86D1
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 01:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F4EC300FFBE
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A922DCBFA;
	Tue, 30 Dec 2025 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b75GFGci"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C72DA76A
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055060; cv=none; b=oDzGM/2AI9dK5CKkPer84A6xS/9y4ox0odA8MK31mx2mp/lE+aQfciACEkmbtD7ngZN9EzsWQ+tqQhP321ZARG7AhOySlazC7jIqVJuzLVaeRDpOblOUZnFKmC9vBNJ3IFQVaUIDpVXUWSYtbSUCLO/DdDyeWiiwxIQ53gEJaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055060; c=relaxed/simple;
	bh=Eu/0MvqtXzKZbDhFka3bibWxt0bbXBOC90Q2iECgF+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCYFxOYSGWlKcf+oUHlnOweqdTcrXtJlA2+O4bUrk0+bjDw46qls+wFx5KD/efupIvKB5ubXCVDKVVHLOdBOWLx/x3oBPk1trPnuuCotXZIAjaIIjuMrS/Ise1o2L6hPpZVS83SCcfHFDZqOC97Z/XcHMsC2nCvIBYZ+tp4JxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b75GFGci; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cc50eb0882so3514589a34.3
        for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 16:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767055052; x=1767659852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IheJhIQLOL+uGWt6XQ0zIC5UxYwT55m5ifEVRi78ko8=;
        b=b75GFGciNFmZMA1pAddG/IJyk0M4t8bjXViGqRPJUtlIXNSocJ3qCuRdzql4roVBtZ
         Qrdqe8iYz7Gqxf7ywr3VQyWONwdpO/lDW9ksNyJh+w7vmT1izd2arvO0pJy3QYropwn/
         A878rasRxsLtm+n5QK7MVcxyJlV40ig9KrV5JxxKyw8D0H+0TEIhgGsjCLH95Z0hiE7N
         8RWNwEm1HWyVBonRBhvnnUCwchniJf2BQPG5K6oxn0ODRncyVibOZ2qJcE15PPfMUrMk
         gB59gvD00SHa7wjiux9LcA7lI81kBy2sSg0xT3VH7QaujB/0Qbq9W14ydND7Y6Xw/Eft
         sQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767055052; x=1767659852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IheJhIQLOL+uGWt6XQ0zIC5UxYwT55m5ifEVRi78ko8=;
        b=svPFMlojaFZ7t5VCmYuOJMQHkmBcvKDQX38GGxvfQEEtDxF6UuHw4EhOWsPOb/oCoN
         yeZljNFnkUg23gzXvjHy1UxTn9ETuxTRdQ+M3s0aDgSnmIbzpkMRH0pUB9dljvQrIKUi
         MBZmNCHJj9Qm3AZB72Znf9BZCGDQSBoOg6w83k7BHO/fHzapbCL80uSqGRcJZ15wGCnn
         mC5vXM2/tno6yLh/vdj7KOzVWJWIhGPQzjAFP6eInMXUOMdQjA7NZCrg7h5rA/6+EBMQ
         8kcg7UATwzSA8K3vRCtFxgHNGMmVDMhnV3WN1dKMARzf9O//1kmB/O1rAwV1bip6WM/F
         XSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaL/12QYfiZKnI2kuvt1+AXfJSQOEugIundPcJhIsaRkda1KR4zIMmmOxcUJ1n2HVSrx4nu9Hq@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3Gn3uNV2mRyPuOzW54zbIU4EuMXc9s77gdlC8tF2C6PyEmbP
	G7/WrSC2DSmhulDQO+CR/YpYP11S9ziG1wsLUDMTomEyn2X50LzGpSOgnrWbOfum2bQ=
X-Gm-Gg: AY/fxX6p4rGd2TP3vNFjeisaoqVXHXLsDU8IP5iChMdv/6lNtYxvt2Rulf3Lgea9VBh
	Kggrm8MFcbvMkDSowDw5NBSRhYOn+q0Rjcza49uBiUEbuLGTQFEmGKp6CECNgfIbtK3xgiCqZOZ
	AyqS1YqVKjPk61b/XJ696M9nj9C4Upc1/yp+UBwRbRQZZLuWiYNL6h7hXd6XAuHbEU5fuRXlpfF
	O6SLyyAZ/48Hja1y2ZjZLJeVfDcCPXx+GFtafZLP1/VjjYfGOeOGTblxhRk+RsvlopBFHObjZMG
	yDS0evYNtvK0j+HOeoEksR1XJI18LjI7efD5OSinTyUlZUs6HHXH89jfCymva0jkGTcFqc1zFDZ
	N1rcObdfZGRQIYjb3j/EYbKPuf8DFHW6Go0zKi5KR0jJH2AFoIQKINf7qLkjL8DedNXGoVRKmy/
	aCaOZzTCvU
X-Google-Smtp-Source: AGHT+IFl9yxlJpaq7sZYozgWoQTaTewr4cBUOiverIAjbR/CmqFwp/DL9X0O2bEGHsivPH5Emtcv9g==
X-Received: by 2002:a05:6830:2642:b0:7c7:6217:5c60 with SMTP id 46e09a7af769-7cc66a603d6mr14529090a34.25.1767055052471;
        Mon, 29 Dec 2025 16:37:32 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d4f62sm21773347a34.19.2025.12.29.16.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 16:37:31 -0800 (PST)
Message-ID: <0f65c4fe-8b10-403d-b5b6-ed33fc4eb69c@kernel.dk>
Date: Mon, 29 Dec 2025 17:37:29 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] block: Protect against concurrent isolated cpuset
 change
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
 Johannes Weiner <hannes@cmpxchg.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-10-frederic@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251224134520.33231-10-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 6:44 AM, Frederic Weisbecker wrote:
> The block subsystem prevents running the workqueue to isolated CPUs,
> including those defined by cpuset isolated partitions. Since
> HK_TYPE_DOMAIN will soon contain both and be subject to runtime
> modifications, synchronize against housekeeping using the relevant lock.
> 
> For full support of cpuset changes, the block subsystem may need to
> propagate changes to isolated cpumask through the workqueue in the
> future.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  block/blk-mq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1978eef95dca..0037af1216f3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4257,12 +4257,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  
>  		/*
>  		 * Rule out isolated CPUs from hctx->cpumask to avoid
> -		 * running block kworker on isolated CPUs
> +		 * running block kworker on isolated CPUs.
> +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> +		 * here.
>  		 */
> +		rcu_read_lock();
>  		for_each_cpu(cpu, hctx->cpumask) {
>  			if (cpu_is_isolated(cpu))
>  				cpumask_clear_cpu(cpu, hctx->cpumask);
>  		}
> +		rcu_read_unlock();

Want me to just take this one separately and get it out of your hair?
Doesn't seem to have any dependencies.

-- 
Jens Axboe

