Return-Path: <cgroups+bounces-6870-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A006AA558E6
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 22:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E1517598B
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855BE27602D;
	Thu,  6 Mar 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InQAUk11"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB226D5B6
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297019; cv=none; b=gmH8++wJn8L3qqlcvhMMwZk//9GtZvICzrE0khx7WbKPUHFN/r/xvqmFgbvwEF5h64tD+rgRN5JCTPjmBVSFOUcOXJLC9XfKiFuXr7+aBt9iI3XbIsJpKYQuRg7RoAwvnEJ7/rI8Xgzum0I3d8eT9eANnyEpuSCVojphI/2UNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297019; c=relaxed/simple;
	bh=wh1r05yHf9HTqqcQGBS+eqAkB97E4OFPqomKvC+g0VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiZVI5z9M/fOF8vbCn4N/3qpO4SYj3PP21Bfxi5obr1uoBNBC3N2pc+dZ2nrfrUiecLSvMdZUSp9+owWiqqlA/YW9natNLqWngvUJN5l2vKEFLIesqoqq3jTX2Xic2pUd/P1KuHRYBGNdkeyDYsKQXh/71dzZLiZkcjAst2ZLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InQAUk11; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223a7065ff8so27207815ad.0
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 13:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741297017; x=1741901817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IINhDf6Fw8o56JcRJ5e+93kJRMpCcvNit2/JwcLDIY=;
        b=InQAUk11qebHTCoARlYfpsEaKG76Q9cRAFkMRWWCVKUX6qwXqfMqlLFDCFDhhfhzev
         1Y60p+nz1odA3xdCkTUF2oLnc3GWcsoelc/vMIOU2VcWBVTz+FtfyVqjHEFuIfjgSy1v
         0nAc3X6kYV/nMAHuALNGe9HaGQiC3/iffmE/UWB64WEsOfo//ygbvt+iHg99k+hCQu1C
         /AkQDJU5SAGqLuRVMxcSZn81og2V1Ins2tZh7b+aRYbtK0C9/nMOG1MmfZsU/WaPI79g
         kCY5VQ75N5iuEEwHshLMNm1U37WtwvT189KarHL2owF9xBkX56mi4tUqAYuOZJyuiQan
         nFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297017; x=1741901817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IINhDf6Fw8o56JcRJ5e+93kJRMpCcvNit2/JwcLDIY=;
        b=CfzbgnpkUa10vf7AGUxDaOUGnKwineJRVo4MgDbtP2TyGIsy/mD4nDNdekDSskXzvQ
         yv8V8093vuUIaJqtz7ccJG4RZl2SIizR9LMOKcBbYRpc8+xCM7H79dM186uZ1vwHM7a5
         V+y//ogkVEsfnW74EH5ZB3u1H5pwGFjrfUuGvnfB1UAKAgQy916PDkgR0/3iFQyTaQ43
         PW74/7IXILCV8ZklJyXz1KwMppKJHxpxN4dheR/1g7dWL35mLKU0uz80j+otvZwVgGiy
         o5ceSHTxuhxUggG/REMhEyoAFAj5ObBgLhcAcGQx9ze9y2RCn/T4vfOR5Dq0aPUNTQ4Y
         BCPw==
X-Forwarded-Encrypted: i=1; AJvYcCXlJMCS7AzH5Dyc7ifUMjgub7trZuFog5d7e108rfIKGBZDaL0C2KZYDViZaYYjk+KA/yy+7EcQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1p2kJwgtypRpp5btZopblGhZx6gma6kYne/NAapf7BOwF+6m
	Uf1Kxrg9qy4P5PDw0n8zd7rjDPyu9ccbKevHQMfMzlL95pI6YNPv
X-Gm-Gg: ASbGncuvNykK/e39783BIW2Fsym+g0gX3tRS6zyEyMaH8B8DaeolL98xOQAOPNykpSY
	aIbw1S7ma2ZCPGzvkjwOlxQiLbzZo+lCJE+kJ7gRX0MLPtD1D1cwsaYiNM1mrZoqtlRkzXJhmbT
	X/94x84QALF6a/77/GLBWeT0mKyQApgTjCNkkqXvfz8MLmGBSM0uAKWNQZjFy399nHMfW0JVsnl
	lGLp9bufWo3YZ5q8mqGYdP9Fa5J7lW08OqMi96B6eWjzwe0RpZ9fon28JLdBMb3PYTe+sn0xto2
	0oJVSXJJmRrWMaHzU+CdyIsihLxt5Sf0VRvhJ88mUAPz5T4w1MLgG9VasFc/hXR3SE4Ya7MBGno
	m
X-Google-Smtp-Source: AGHT+IFqnaevbR7EZaWbc3xQVjHKp7P167o0Y2c+WpwOmU4hO/E+hRo1NTbAPz8T9gCEEukaEoeIiA==
X-Received: by 2002:a05:6a21:a45:b0:1f3:3864:bbd9 with SMTP id adf61e73a8af0-1f544acd522mr1761699637.5.1741297016950;
        Thu, 06 Mar 2025 13:36:56 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:d431:c86b:892f:8e30? ([2620:10d:c090:500::6:d8b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af287c2d533sm1223692a12.23.2025.03.06.13.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 13:36:56 -0800 (PST)
Message-ID: <1dd79ba5-aebf-4e81-8aa0-5abdf063d124@gmail.com>
Date: Thu, 6 Mar 2025 13:36:54 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
To: Yosry Ahmed <yosry.ahmed@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z8X1IfzdjbKEg5OM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 10:29 AM, Yosry Ahmed wrote:
> On Mon, Mar 03, 2025 at 04:22:42PM +0100, Michal Koutný wrote:
>> On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
>>> From: JP Kobryn <inwardvessel@gmail.com>
>> ...
>>> +static inline bool is_base_css(struct cgroup_subsys_state *css)
>>> +{
>>> +	return css->ss == NULL;
>>> +}
>>
>> Similar predicate is also used in cgroup.c (various cgroup vs subsys
>> lifecycle functions, e.g. css_free_rwork_fn()). I think it'd better
>> unified, i.e. open code the predicate here or use the helper in both
>> cases (css_is_cgroup() or similar).

Sure. Thanks for pointing that one out.

>>
>>>   void __init cgroup_rstat_boot(void)
>>>   {
>>> -	int cpu;
>>> +	struct cgroup_subsys *ss;
>>> +	int cpu, ssid;
>>>   
>>> -	for_each_possible_cpu(cpu)
>>> -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
>>> +	for_each_subsys(ss, ssid) {
>>> +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
>>> +	}
>>
>> Hm, with this loop I realize it may be worth putting this lock into
>> struct cgroup_subsys_state and initializing them in
>> cgroup_init_subsys() to keep all per-subsys data in one pack.

Will give this a go in next rev.

> 
> I thought about this, but this would have unnecessary memory overhead as
> we only need one lock per-subsystem. So having a lock in every single
> css is wasteful.
> 
> Maybe we can put the lock in struct cgroup_subsys? Then we can still
> initialize them in cgroup_init_subsys().
> 
>>
>>> +
>>> +	for_each_possible_cpu(cpu) {
>>> +		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
>>> +
>>> +		for_each_subsys(ss, ssid) {
>>> +			raw_spin_lock_init(
>>> +					per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) + ssid);
>>> +		}
>>
>> Similar here, and keep cgroup_rstat_boot() for the base locks only.
> 
> I think it will be confusing to have cgroup_rstat_boot() only initialize
> some of the locks.
> 
> I think if we initialize the subsys locks in cgroup_init_subsys(), then
> we should open code initializing the base locks in cgroup_init(), and
> remove cgroup_rstat_boot().
> 
> Alternatively, we can make cgroup_rstat_boot() take in a subsys and
> initialize its lock. If we pass NULL, then it initialize the base locks.
> In this case we can call cgroup_rstat_boot() for each subsystem that has
> an rstat callback in cgroup_init() (or cgroup_init_subsys()), and then
> once for the base locks.
> 
> WDYT?

I like this alternative idea of adjusting cgroup_rstat_boot() so it can
accept a subsys ref. Let's see how it looks when v3 goes out.

