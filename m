Return-Path: <cgroups+bounces-8643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF556AEBDE9
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54F86474DC
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98AD2EA72F;
	Fri, 27 Jun 2025 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlTdDRM9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884E29DB6E;
	Fri, 27 Jun 2025 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043358; cv=none; b=pqS5Jaz2pm/L4R9Ex46n1QxI9+7GoH6fO83kvQEfNz+P2UXc5hPNZKYJ/KYtXRyRJYucZMEAzQ0YAUeFdZ5tenOU8+jYVHNaGotCUHLHck40frus/BCLpJc0voyhpNfbHxSffk3zXLC2gbYupdcT6XRcWDptgN8mLjIPUO5QsbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043358; c=relaxed/simple;
	bh=x6EAdzo2tcw4qTY9xmJChcEVzhxOcemJWCbfQM7FUsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAFs7vCzLxPJvHxe3JmF6pmdMvU2Vc7ubBg7of+6aNp3yLuj/Z3aZiwpt+iujrGINjIIz1H9vYhrnUINErPPa9HRz68BC83s6ET8XLHM7nIdVL27yPmzlSaEfDhfINjbGG3o/D4CsYITOpgiAdQzlpBvP5RycJgUALKTnHtG2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlTdDRM9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747e41d5469so21599b3a.3;
        Fri, 27 Jun 2025 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751043356; x=1751648156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IzY92g6qFC35rS09jQUSGvQxcGnVo37AAViyu9kECs=;
        b=dlTdDRM9PwVTObu8Eak89j0LoEaMpSmLhuf183fRZaI9Oe38lZwDBxaGUvdsuzTOnb
         2PZUrNYXPfuLLU7k1IpCy1G+9D07A+K0+btVsVLuAzfP5CqBn4J5FloMb449TMgqI/FK
         4AHUAzfWNdO5EKmNxlV3mgv6fZauZm1FgfyqMBVvgBNyo6KJAxCpTNsHiCpb4v9Uiz/u
         LE9vxNx3Mvf12G8pKSSV4y60aBjRUkBBUZyKCfpcY7Z/BEYnZIoPZBlkCRaJrlgYtG/n
         fp+BjAHEajbfLfVbdzoHFwKNN4upbN9qIxqmDc9vdDDqQAOuKsqPsaf+Sktcd458gOvw
         uwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043356; x=1751648156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IzY92g6qFC35rS09jQUSGvQxcGnVo37AAViyu9kECs=;
        b=LHpNGazD5VyHhcQPKYCx3xO37W1LcKjyPH4nlVkyghts8QPoKYrs8noTIPVOuZ5pzv
         w0qUwBm26nVPIKF45Y/RgsGN7FyjI7kJ9qpM28BflvRkZRRYb8j+5qWdDTxxNB4+56zR
         74QW3Fbq50tFWqEgQWxh3oyq7E+c3I1PDMjuv9gjsNebSzIkt26f0C5Yv694LEkimj5n
         /VCoFEHEsRq2tYbQrP2D4dDxTM2Yv4mWRYnkZRdl0HKqpbWFUkBPMnOrylqzMS+jV8aO
         Y88zWS4SR6WukL4mV6ZWac6lFP+piNumN1Qr7DNS5j6j98giAhTlA03VBTepc5k28dZw
         bwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhKneucazntFGILaR2F5xXVteojeu08yy4BW+fn4nsirtaNYc6bOzSQqeTUTKBrkNqH3rv2G+i@vger.kernel.org, AJvYcCXIWxQBqyq5gbbSmboG82xCe/3q24RqQac8FY0OnkLp7y2Z2oBQErGJiNLpeHTPkvbHcYCJuSi5Jjh6zPvS@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9pQW/KMbdHHlcviSDUMkWIHn8+5+2PRsu+WQIzLJpeuG3Rek
	0TCBv4ZbZumw79VpLJhExLY67odAYkHoWJPZ6uJQ01jo45h/YYaNxpfG
X-Gm-Gg: ASbGncsAhtyQkMHQkchbRxhfjPFsr4mvck7IZ3nnF6QBx2IStjjiQ91llpQxpHLXIgl
	ANvVjiOCIRkPsiQM74UDFQAkXPFlxi13a1vCSyIjTg1dXYPAlidIUtLT9pUyxu4lgJ5xv3nOola
	tauaRRW2ZjknGS5OpFGO+ZkvTOUUj2WFVMr7lkiBivCoDxmWziiALSb2fiANibwpA/Oc/3MN8O/
	ZpSeo56GJShFbK4ayiERHDwNVqGccch7g6+ZRTpQc+kK+wP9t1bszbj6TQeqPK2UfwueeOE7q+2
	lFjlGNfL0E8J4mXAWqGcI3dpUFckeHrlAThF6JdqSRgNATwDNzjBfHZ1PyIgfZ2/eUjA+SkSAeO
	t/2D7UcFDJqWMHODgGPxs4gLNOhJCQT5J
X-Google-Smtp-Source: AGHT+IGc5oBqORk0S+5R+VA6QmfT0DKFXm414YawpFW52+dltLUhf84WrzU54kQ3XKk1GaSw9uMe1Q==
X-Received: by 2002:a05:6a00:1911:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-74af6e66683mr6054766b3a.8.1751043356205;
        Fri, 27 Jun 2025 09:55:56 -0700 (PDT)
Received: from [192.168.2.117] (c-67-180-10-175.hsd1.ca.comcast.net. [67.180.10.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56e8b00sm2652403b3a.143.2025.06.27.09.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:55:55 -0700 (PDT)
Message-ID: <a7e6aeb8-9fb1-4570-845c-3ce9946190a2@gmail.com>
Date: Fri, 27 Jun 2025 09:55:54 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
To: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: "tj@kernel.org" <tj@kernel.org>, "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
 <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/25 6:15 AM, Wlodarczyk, Bertrand wrote:
>> The kernel faces scalability issues when multiple userspace programs
>> attempt to read cgroup statistics concurrently.
>>
>> The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,
>> which prevents access and updates to the statistics of the css from
>> multiple CPUs in parallel.
>>
>> Given that rstat operates on a per-CPU basis and only aggregates
>> statistics in the parent cgroup, there is no compelling reason why
>> these statistics cannot be atomic.
>> By eliminating the lock during CPU statistics access, each CPU can
>> traverse its rstat hierarchy independently, without blocking.
>> Synchronization is achieved during parent propagation through atomic
>> operations.
>>
>> This change significantly enhances performance on commit
>> 8dcb0ed834a3ec03 ("memcg: cgroup: call css_rstat_updated irrespective
>> of in_nmi()") in scenarios where multiple CPUs accessCPU rstat within
>> a single cgroup hierarchy, yielding a performance improvement of around 40 times.
>> Notably, performance for memory and I/O rstats remains unchanged, as
>> the lock remains in place for these usages.
>>
>> Additionally, this patch addresses a race condition detectable in the
>> current mainline by KCSAN in __cgroup_account_cputime, which occurs
>> when attempting to read a single hierarchy from multiple CPUs.
>>
>> Signed-off-by: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
> 
>> This patch breaks memory controller as explained in the comments on the previous version.
> 
> Ekhm... no? I addressed the issue and v2 has lock back and surrounding the call to dependent submodules?
> The behavior is the same as before patching.
> 
> In the long term, in my opinion, the atomics should happen also in dependent submodules to eliminate locks
> completely.
> 
>   > Also the response to the tearing issue explained by JP is not satisfying.
> 
> In other words, the claim is: "it's better to stall other cpus in spinlock plus disable IRQ every time in order to
> serve outdated snapshot instead of providing user to the freshest statistics much, much faster".

But they're not really "outdated" are they? Regardless of the wait, once
the lock is acquired they will get the latest snapshot.

