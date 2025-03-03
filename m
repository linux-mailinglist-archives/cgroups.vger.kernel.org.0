Return-Path: <cgroups+bounces-6790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D746DA4CBF0
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 20:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DB2188F00A
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB522AE71;
	Mon,  3 Mar 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dssae0jB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70454217F40
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029833; cv=none; b=teRxzqP4LZc+RScqIQeHOrzDLgRunuVDPybBx70EhJB6FRgiapwkKX8HSyamjwyxgj4ZmfqMaIwJIXqeFu/82/SK0bIYzdzriW5fFN9jY6vRl607TFiepcPxKdZ1+SzMRYOCePD/Gn1dbAsHcUJbqxu1xZencYseFuQqWq8VsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029833; c=relaxed/simple;
	bh=dl0S/0VSCLK7wtsjagpVT3Bi4QZc0kkG0N5KN0s8DKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cugl2yoCIu5TS8TVV/mXhyfMftdQXw5ciBz5TAk56Zvk5tUquS3h7t0YCLnmv5tATk7h7JvKu51NjCf5mTXM8IuXr4AnyDyQ3kkXXJZga1lnTulSB8NQB/PMVHZ4QOPO65duYClzWOUZz4KjMYxf15okVSwut5ZiVfzhhyYJchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dssae0jB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2239c066347so33897305ad.2
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 11:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741029832; x=1741634632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oT9AUtB0ACRn/+0gEqHCG5ERr1zYH8DtVjF/4J+dENQ=;
        b=Dssae0jBrCC1JsUjYDxRDQN1+IAiqdTdToz62VmZ0JRSmxGAmkwKnfGF91KYSA4+jp
         0U1z2NYsi7HjDOQol5t03NlZr1xwRB21P2KNCXlPSTjJcf/M2e8vnv6ph09n4n7jZOCk
         lGOOzhKzxQfp6LqhQLjMU93czibeMGTj5ZKSyWtK1HS9RMK2RZhDME2k1woD7FazAmAd
         9ewc+v6AQpr9gmWV+XJr7IjmaOZz1qx91kGZbEI1aHS4wn4e5xTV/5bCJC0rTqUGuV33
         1VRmJaZiEsmiw7EmswcWakPEhEkUQFQRALKN4qNlJ5zeUPa1mvPNqBwd/L8afN666AV+
         8nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029832; x=1741634632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9AUtB0ACRn/+0gEqHCG5ERr1zYH8DtVjF/4J+dENQ=;
        b=kNR7k/bN95upB1DQLhMo0z5DhunSqoapDY8Jh5VuJigQomeW785ISJgb1i+1HujyDG
         BxSHPj1dIhBqzjQ6RoZiXfp6srL94okTbbUcdVRmGSv3dNgwZBHsutdiA8lO7mGAFaRf
         tPClYu0d07eVWo/LnieQctbMAYMs5BtjNi5E5GCOOMSUboAWOm0d/HTn7yfTu3PGHA1n
         4sbgF8DKBVSHfV2jBSH6tITuh8oARxcj/SOFtEL2SYRs4apBlFuTiR7YGORbg059kgEG
         xDv/kBD3zhFOwle7DzXQL/gia4GSO9xnpHygGvLn5K4GaTKHei8+3QbQ5IZ/feVW3HT6
         ClsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIs3Z31tjJuwxAVJ1BDz2mSojzpbrATbxSKu/Xmj2H+o23ok/yePLud0faiSihXWXwIkrPpyGc@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTJtKAL8p8a5Qvw0D6O+9sSp+GoRCn1Ri5Dh6vKg+b/YqCmSb
	078xUWoP68fxd0E6WKH6/V0F/yG7RMsrEr/SRhWNzMuz5VAjPcWj
X-Gm-Gg: ASbGncv4uGn17LSyq2g6PPCoxOFnSVuqpSFFzGCA2gPMmKwxLCRRJlxsenCWaOJETbB
	pOigD+GNk7TnD7s+K10nVyVSYl0HgmgIDMr4FoWEqBDJBaq4PlAbrtBYLipccLraJ+z6bXhhuxq
	TEWKY1HmM2oGe1/am1truP6EsKDDcX9HvmCCmgBjdXektoXNMCnF7MjSrsMycQ/LzTY7pzpdlDw
	+N3qHNdnsD6Qn0AMpjdIoj15vKIlYtHEVNXGznwDLZPWkTRucftp70wfB96yDNsON1qrufGmMFB
	HgxaPSwDZ5FlffTG4qo2h9u0673Heh0lBXkX4g4n5CVoXO6ikPdh31e8ty6uxSW2MVNeiE2ni6A
	yTg==
X-Google-Smtp-Source: AGHT+IF84rqBQ7Io43mUSWn5lUhyZT7z6JFemiNL4w8tCe07mNSDdgdtVJqfsqzghisNWFJkoefqTA==
X-Received: by 2002:a05:6a21:6da8:b0:1ee:e30c:68d8 with SMTP id adf61e73a8af0-1f2f4cba1e9mr23711203637.12.1741029831619;
        Mon, 03 Mar 2025 11:23:51 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:64c5:2132:888c:8c76? ([2620:10d:c090:500::7:c71d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19c14sm8596571a12.20.2025.03.03.11.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 11:23:51 -0800 (PST)
Message-ID: <f59a7b94-d2eb-42bc-a4a1-2aa6e35bedc6@gmail.com>
Date: Mon, 3 Mar 2025 11:23:49 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
To: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, tj@kernel.org,
 mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
 <jnxu6dot3od74pu57mhnx7sssf36tx462n5obx53wmvtuaxlcq@b4dqcpnenoyv>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <jnxu6dot3od74pu57mhnx7sssf36tx462n5obx53wmvtuaxlcq@b4dqcpnenoyv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/3/25 10:40 AM, Shakeel Butt wrote:
> On Mon, Mar 03, 2025 at 06:29:53PM +0000, Yosry Ahmed wrote:
>> On Mon, Mar 03, 2025 at 04:22:42PM +0100, Michal Koutný wrote:
>>> On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
>>>> From: JP Kobryn <inwardvessel@gmail.com>
>>> ...
>>>> +static inline bool is_base_css(struct cgroup_subsys_state *css)
>>>> +{
>>>> +	return css->ss == NULL;
>>>> +}
>>>
>>> Similar predicate is also used in cgroup.c (various cgroup vs subsys
>>> lifecycle functions, e.g. css_free_rwork_fn()). I think it'd better
>>> unified, i.e. open code the predicate here or use the helper in both
>>> cases (css_is_cgroup() or similar).
>>>
>>>>   void __init cgroup_rstat_boot(void)
>>>>   {
>>>> -	int cpu;
>>>> +	struct cgroup_subsys *ss;
>>>> +	int cpu, ssid;
>>>>   
>>>> -	for_each_possible_cpu(cpu)
>>>> -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
>>>> +	for_each_subsys(ss, ssid) {
>>>> +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
>>>> +	}
>>>
>>> Hm, with this loop I realize it may be worth putting this lock into
>>> struct cgroup_subsys_state and initializing them in
>>> cgroup_init_subsys() to keep all per-subsys data in one pack.
>>
>> I thought about this, but this would have unnecessary memory overhead as
>> we only need one lock per-subsystem. So having a lock in every single
>> css is wasteful.
>>
>> Maybe we can put the lock in struct cgroup_subsys? Then we can still
>> initialize them in cgroup_init_subsys().
>>
> 
> Actually one of things I was thinking about if we can just not have
> per-subsystem lock at all. At the moment, it is protecting
> rstat_flush_next field (today in cgroup and JP's series it is in css).
> What if we make it a per-cpu then we don't need the per-subsystem lock
> all? Let me know if I missed something which is being protected by this
> lock.
> 
> This is help the case where there are multiple same subsystem stat
> flushers, possibly of differnt part of cgroup tree. Though they will
> still compete on per-cpu lock but still would be better than a
> sub-system level lock.

Right, the trade-off would mean one subsystem flushing could contend for
a cpu where a different subsystem is updating and vice versa.


