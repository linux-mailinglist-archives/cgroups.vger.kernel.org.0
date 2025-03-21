Return-Path: <cgroups+bounces-7213-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE09A6C1CF
	for <lists+cgroups@lfdr.de>; Fri, 21 Mar 2025 18:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491F03B35F0
	for <lists+cgroups@lfdr.de>; Fri, 21 Mar 2025 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2922D4EB;
	Fri, 21 Mar 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXtDIT3O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09861DEFF3
	for <cgroups@vger.kernel.org>; Fri, 21 Mar 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579133; cv=none; b=CTHimBX25WsCnKXTOO5RGUfYzdCU0L0knqFwKyYTgDeBJ2fpi1n0X6rmUWVtFxbXFN0FwdCtZG5qekH9wG6jMVV5x8r0Jnx/2NybISQ8hW6zu0JTtPwdkb1cNi3MBco4dIHWbmI8biacZKA1L1pRBqAtBpNlsbUVS6TC2SRA3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579133; c=relaxed/simple;
	bh=cqf0WMhRMjDsPIrTyGakO2shz/i9BUxwou9b5pSBSTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSvchQHWnBqaRi5otNBHWp6MPY/YgaJulU1ZXo7FUZyyWAgtU2eh9j5rn5HEQ1bcG3GZuS+h8BoyJYDrh9isoCzzsOfYIgMZqX8TZwaThNLV61+01ma6FVIiq1BPzIUocXgERjwoVaDZkmkQ5mINTb/BzaVEBs1QpbohomkkEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXtDIT3O; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3018f827c9bso3373181a91.0
        for <cgroups@vger.kernel.org>; Fri, 21 Mar 2025 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742579131; x=1743183931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGUkFoO4459AC6cSpEGmTy2dO+y56Fth164tavOfDuQ=;
        b=CXtDIT3O5xmG0EopgPqNVl1Pf8a/DPw6R7kjrGei7n2/2y65UOtTu8qyLUIleNifcX
         MjIcWyL+osWsXSsvo5Jz3/v1mheDYx4mzE4HJ3oc7pooJAYlMccnVC1OfkIAqd8j2eON
         eOECy+ps7/brKBfoe4YnU5mptMUwBVhyEtlmoUCJm68cOMvtXmQKf5KRH0uytqyek3bl
         +aPjmaE8WgpVZafk8iaXiu3UvpqhzKSZ1NhAiNMprSPelnVeKFIy6BPZ/1BTx3IXubQd
         je99Ne81hvksqWE1UVX6LM6vFTE/WJ1gL4CPo+lti7JFPdetQJZJ7afwfACLWKrdCK3n
         SxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742579131; x=1743183931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGUkFoO4459AC6cSpEGmTy2dO+y56Fth164tavOfDuQ=;
        b=Tanl1tRL/ZuTfQY/eqo0Xg5Td3d0yAjW9dHiSZ/EqogO+lGXVxxMwxaZqVIKhkTNm9
         raLP6iXQryuS9u1fDfudomxcTyDM8XjOtk1nwYxjMp4uq/fVYH317mbby1zxkJsM/Uj9
         +qf6g3gkr+CaUu642Wh3mZo7TmX/D2mzgL7BnzlpP8MVe6lpsPqDduAkNcyGVhMfWV/z
         i+nTJpGCZ6RSGk2nbCtQVTjl8I1wW+GSu+FsaE1anGrKvPb37T0xxFeMIShwDCZV2dHb
         BcWebiPSr1k0s8bIp8LuhMK7K0hGL9QpU+/1CRyh5DwszkZMSNlYHYFNuU+REVjEsfly
         dJSA==
X-Forwarded-Encrypted: i=1; AJvYcCWfVj4kpzTLE4rBlSuTFTAhrQqrDdeK8E1apkEcdyKjVX1hhWRfKWIgI6RhP4D65/rWVbRGWWSI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mGCqDM81SEoZOKSqgiKIC58VpDp06KnSK7FfygfpE0c7vWPu
	NV9Xal8xVzhQW/MMZurOKAUsmkuzKflFit2Ug6bYpMHjybC5yqbo
X-Gm-Gg: ASbGnctJSZ3TQ1UU9s0ojLCtXng6Hpx8SZCUMf0hUQ30HPFT1Hk3sm8Q2z5acsz1QFa
	jy0ENYpJTh+cnZdyDbj7YolyVkM14BGSXefiaW21j+DmuVXh2/YdU9a1WfPnwZ+P3vCH3uEbYm/
	qdip1jM6pTpfr6uXlZCZwnO6zWtSjm8WkcEluzzjfR1RpfOsvM9yj9+mrJQBPxQOGe9y23ULJ+a
	6lh7eedV/kaDqOUvC+kaX70aw+p9COUimMopqOKxiDOoUL2gpS4hdWEGt6UTkzByVO9lOxpo8/q
	vrvKEYefQv8UPVz8IrBfIgNF15boBwUEtAM8TxCmhp8jaV9Ba3ztOnK7pZQAGvjsilo3EylAZI5
	pUHjyOuYUEQkLsQ==
X-Google-Smtp-Source: AGHT+IFWCDfnXCaMmy4hkd8moLcdPSod9/cAKjF9NP2yYpUe+jYxwO97go6VgxVfEK6VVfPKJEqCWg==
X-Received: by 2002:a17:90b:3c05:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-3030fe942bbmr6430149a91.13.1742579131089;
        Fri, 21 Mar 2025 10:45:31 -0700 (PDT)
Received: from [192.168.2.10] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f39763sm20199895ad.10.2025.03.21.10.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 10:45:30 -0700 (PDT)
Message-ID: <5062846a-7b4d-4c59-a990-ae9f7fd624a9@gmail.com>
Date: Fri, 21 Mar 2025 10:45:29 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 v3] cgroup: save memory by splitting cgroup_rstat_cpu
 into compact and full versions
To: Tejun Heo <tj@kernel.org>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-5-inwardvessel@gmail.com>
 <Z9yMMzDo6L7GYGec@slm.duckdns.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z9yMMzDo6L7GYGec@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 2:44 PM, Tejun Heo wrote:
> Hello,
>
> On Wed, Mar 19, 2025 at 03:21:50PM -0700, JP Kobryn wrote:
>> The cgroup_rstat_cpu struct contains rstat node pointers and also the base
>> stat objects. Since ownership of the cgroup_rstat_cpu has shifted from
>> cgroup to cgroup_subsys_state, css's other than cgroup::self are now
>> carrying along these base stat objects which go unused. Eliminate this
>> wasted memory by splitting up cgroup_rstat_cpu into two separate structs.
>>
>> The cgroup_rstat_cpu struct is modified in a way that it now contains only
>> the rstat node pointers. css's that are associated with a subsystem
>> (memory, io) use this compact struct to participate in rstat without the
>> memory overhead of the base stat objects.
>>
>> As for css's represented by cgroup::self, a new cgroup_rstat_base_cpu
>> struct is introduced. It contains the new compact cgroup_rstat_cpu struct
>> as its first field followed by the base stat objects.
>>
>> Because the rstat pointers exist at the same offset (beginning) in both
>> structs, cgroup_subsys_state is modified to contain a union of the two
>> structs. Where css initialization is done, the compact struct is allocated
>> when the css is associated with a subsystem. When the css is not associated
>> with a subsystem, the full struct is allocated. The union allows the
>> existing rstat updated/flush routines to work with any css regardless of
>> subsystem association. The base stats routines however, were modified to
>> access the full struct field in the union.
> Can you do this as a part of prep patch? ie. Move the bstat out of rstat_cpu
> into the containing cgroup before switching to css based structure? It's
> rather odd to claim memory saving after bloating it up due to patch
> sequencing.
I think it's possible. I'll give my thoughts in response to your 
question below.
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 0ffc8438c6d9..f9b84e7f718d 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -170,7 +170,10 @@ struct cgroup_subsys_state {
>>   	struct percpu_ref refcnt;
>>   
>>   	/* per-cpu recursive resource statistics */
>> -	struct css_rstat_cpu __percpu *rstat_cpu;
>> +	union {
>> +		struct css_rstat_cpu __percpu *rstat_cpu;
>> +		struct css_rstat_base_cpu __percpu *rstat_base_cpu;
>> +	};
> I have a bit of difficult time following this. All that bstat is is the
> counters that the cgroup itself carries regardless of the subsystem but they
> would be collected and flushed the same way. Wouldn't that mean that the
> cgroup css should carry the same css_rstat_cpu as other csses but would have
> separate struct to carry the counters? Why is it multiplexed on
> css_rstat_cpu?

Originally the idea came from wanting to avoid having extra objects 
(even if just one pointer) in the css that would not be used. This setup 
allowed for what felt like (to me at least) an organized way of keeping 
the objects used in rstat in the same container (css). You initialize 
everything within the css and also have consistency with the css-based 
rstat API's - using the css for updated/flushed allows you to get the 
needed rstat objects via css. So if we moved the base stat objects to 
the cgroup, we could where applicable check for css_is_cgroup() and then 
use css->cgroup to get the base stats which we kind of do anyway. I 
don't see a problem there. The only complication I think is on the init 
side, we would have to perform a separate percpu allocation for these 
base stats in the cgroup. I can give this a try for next rev unless 
anyone feels otherwise.


In general, I'll wait to see if Yosry, Michal, or Shakeel want any other 
changes before sending out the next rev.

>
> Thanks.
>

