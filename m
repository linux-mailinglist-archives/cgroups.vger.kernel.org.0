Return-Path: <cgroups+bounces-10965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930BDBF6D58
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034A41885276
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F1C33509E;
	Tue, 21 Oct 2025 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG2zq2MF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B8333430
	for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053960; cv=none; b=rW9PqKbAiW3lKsFDWGz/JF60BXcbsxo6R3cqyu5MPLzLVvgGbVd8o5NKOrSbWG+Qg8ZP6oCA7A05RyavkHI8eQisgeW3ZbYrurC9b/nrcoxq2WCnEwl29oZbs2hqaDDE7xXam8vD/QLXDWxusxY5xAi3tdY7QLVVlEcHVlFc9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053960; c=relaxed/simple;
	bh=A2vdq3fjCx6AIl2BDZIfxhOwGIe9UlrZ+Owl/fdNpyU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XOXs/jn16SCXQCtDhwjqet+up+k95nlFqbuAiX8Y2fFvRu+DG8+OqVdu/SlFUzUMR79R9MYl/2+K1VwWKs+m6VF05j/oSboX5UJ43HVpntvzlkGFFWS+ES9THt+f71P6XtUgGmehMMYIlv0jZCBite4YGdtT3xD4GBMnc7Xkv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG2zq2MF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761053957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3KJELQ+1zBaV6zsfBpuZG8t84lL3xkiKid35BQ9x2E=;
	b=SG2zq2MFO/c/UsWw/U6WiCzx7HXsmA0d4S7xKDNHiQmg2V9yXIcOfAUVs2GaS96v/vBN6B
	sWr2CPJiLCfBWFASyiQDpYEPYmia9xSvo/BnqISmqeFzk6AJANazx0qpYOCQ8ZBYqGgIxv
	u2jLRCvjvbYJs0lN6iBjr2ppYNmfY78=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-6Oecs9c6OrW1uv5pFu_-Rw-1; Tue, 21 Oct 2025 09:39:16 -0400
X-MC-Unique: 6Oecs9c6OrW1uv5pFu_-Rw-1
X-Mimecast-MFC-AGG-ID: 6Oecs9c6OrW1uv5pFu_-Rw_1761053956
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e45d71f05so175401206d6.2
        for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 06:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053956; x=1761658756;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3KJELQ+1zBaV6zsfBpuZG8t84lL3xkiKid35BQ9x2E=;
        b=di8234tAUewxL5JPAz81tzZGhCDtJvr8+Z+aDoCJ5Yt3H0LhoB9rQAssHGiiyeMWx0
         6PcP6Zr2WPehcxYyTtQ60/Tg0S98d4xfZKRJLGcN0v/OsFFd5+KFc9NHjmARpNryO2Hy
         j0oqSkNjBwi1bSops6UMifD2UDcXmoDUIDnVgqxJyMESf927Ase4D99U6BtYnsA0CnBv
         pEUDv9czBHzdyviZjo38v6lIIh6GmsKf1NYSsS7z+xIaAn+lXEV7OiH3zeLfmozQL9PI
         mtwDLNza1wGGalVL2OpTQheZImmr1NeJ7hJDkLo/ZASlz9r/MyvXimfNvC+cUOldzSNj
         I+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUbi3V+OnHeRDpOSni55Y4nL7vkz5YwR+kgp+1d9qr22cAlrj54RUqM5HxHkr3M3+pd/Z05ZZ+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hWw+9K22SVxSB4FRBakz+oQmqtsX0o+21jMduPzcdl8fVg5E
	zo0AZ6esDrdpcNfnV9RMnGog0xIEqvw6HZ6OOiezbO4yd4L5FCOBLDB9tV8pJ3DeXdOxkRz5IBA
	PzPEckXnCAi2s4bk7xTdNg5x30pTWcv2MusKujYTpZnyHBr9aM+UdEoK5XrE=
X-Gm-Gg: ASbGncunpsTXTxxOhZ/MlM2QaDQWmgzqRURv8d6iB1t+CWkBg5GphZ2zu52wfy/+sOW
	88JWz8wCbOLJNbDLDTn7pIkjIqXy87sDGzqQGENY8G516hbk8Ohu18JaFNL+A+Na4aD/P6ThO9s
	FZxGKliea7D2YBeOPkDcdF/veHe5ubSZVeCMwCbV3hPcSXTBlV73PG0hzEJghgI8YmpjZW7rx6M
	BkKmZr6/t+eLImwKTGPKfNlllOo58yYLeAwY8U1+6FMzq/M0+eU36P+LgaG/zxI1e7DUlM4Xg9L
	//B71fNnYx9aE2CImj/WVhycIjm7gbfRbJ7Js7ysfpayzh4xFCwNd3RaIGA7Cd8+7vYvDaBIYtC
	dXZsGjT2K9gLGK5VpP2y1hWZFqtoc2Vm/M8wnreu5MmeuUQ==
X-Received: by 2002:ac8:7d8a:0:b0:4e8:a6c3:4322 with SMTP id d75a77b69052e-4e8a6c343dbmr147838451cf.68.1761053955824;
        Tue, 21 Oct 2025 06:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz7AKLLzN2UNU/guKrJvkpbFnggCrMTTSh4yWUy38aXqbwBFVcdBvCw2i1DLngSoeAJ3ah8Q==
X-Received: by 2002:ac8:7d8a:0:b0:4e8:a6c3:4322 with SMTP id d75a77b69052e-4e8a6c343dbmr147838031cf.68.1761053955419;
        Tue, 21 Oct 2025 06:39:15 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3370fsm74330521cf.3.2025.10.21.06.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:39:14 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ea2d3e0e-b1ee-4b58-a93a-b9d127258e75@redhat.com>
Date: Tue, 21 Oct 2025 09:39:10 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
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
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-14-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> @@ -80,12 +110,45 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
>   
>   bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   {
> -	if (housekeeping.flags & BIT(type))
> +	if (READ_ONCE(housekeeping.flags) & BIT(type))
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
Should you use cpumask_size() instead of sizeof(*trial) as the latter 
can be much bigger?
> +	if (!trial)
> +		return -ENOMEM;
> +
> +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
> +	if (!cpumask_intersects(trial, cpu_online_mask)) {
> +		kfree(trial);
> +		return -EINVAL;
> +	}
> +
> +	if (!housekeeping.flags)
> +		static_branch_enable(&housekeeping_overridden);
> +
> +	if (!(housekeeping.flags & BIT(type)))
> +		old = housekeeping_cpumask_dereference(type);
> +	else
> +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
> +	rcu_assign_pointer(housekeeping.cpumasks[type], trial);
> +
> +	synchronize_rcu();
> +
> +	kfree(old);

If "isolcpus" boot command line option is set, old can be a pointer to 
the boot time memblock area which isn't a pointer that can be handled by 
the slab allocator AFAIU. I don't know the exact consequence, but it may 
not be good. One possible solution I can think of is to make 
HK_TYPE_DOMAIN and HK_TYPE_DOMAIN_ROOT point to the same memblock 
pointer and don't pass the old HK_TYPE_DOMAIN pointer to kfree() if it 
matches HK_TYPE_DOMAIN_BOOT one. Alternatively, we can just set the 
HK_TYPE_DOMAIN_BOOT pointer at boot and make HK_TYPE_DOMAIN falls back 
to HK_TYPE_DOMAIN_BOOT if not set.

Cheers,
Longman


