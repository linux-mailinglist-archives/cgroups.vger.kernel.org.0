Return-Path: <cgroups+bounces-8399-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6971AAC9898
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 02:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E8D16B65D
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 00:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CE0380;
	Sat, 31 May 2025 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxq2KT7D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE40645
	for <cgroups@vger.kernel.org>; Sat, 31 May 2025 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748650067; cv=none; b=RXQMQwdKx384xMix7a8ZbpCfcTWcTE+wVcZanH4s0yj5DJ92tTK0Q+eerPC8O7AYL0FyvwGCTFbm8yezQT7hlXdw/Z7iiXs/N2rfTziFRZUYSScNyfvNuvsaOACOL4FWaFZ8duS2G7KVsrfRErgMiQdaP5LPH0bfDfHDo9slC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748650067; c=relaxed/simple;
	bh=WSHIfV2RYm3H5t1qsR6VrCV9xc8Ggs8HY5Kf7TbhlLU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KtGQF5HzlbLumbwKOAPs45Ya36nEemnpiaKMt+84HqROC/ZsNr6Caet1ktdHTDSb8NwxwZo9H7g3ARugn04pJqzKCEIKT5wYw62iAgbfWTBtsBF9FqxuAxszVE6zt24r5eJukClBoNYSE6NWXDh/A/jql/0iv5ADfGQgsbHxdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gxq2KT7D; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74267c68c11so2081465b3a.0
        for <cgroups@vger.kernel.org>; Fri, 30 May 2025 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748650065; x=1749254865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wsA7p1LK8DufmfA/B+y+S6cYd11l1KczEP1JUj9OSmQ=;
        b=Gxq2KT7DFOMaShbQBKTl7y3GXj1s2Ootzr/ZsCuiv+xUe+MIhKYn07qaKeRsYGxzwt
         ygVDCuQ9Fu+2HRQiVhRHQY6wcUXQJ8zLmvANwd++VvXVbRZWYLJM5cgbMKD8DyrMTlFq
         GjF0+JplCcvUxO2D7790m3jaTbz538v4LewpFjvOPoXlJDCRbmBzBNoaVbyT0aLocBYZ
         IqYfNUJgR7k/F5kin2evKxwbA0FEmYvGxIP0DMjLNj1F8AsKqb1rVAWs4kxbKsdsP8dT
         1SIwGsvgSBIw92/+/bnnzXhtbYZyBtznvHOoeIAKNKMgGHWfhSUgjnElFlGLJe7KD9I4
         hKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748650065; x=1749254865;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsA7p1LK8DufmfA/B+y+S6cYd11l1KczEP1JUj9OSmQ=;
        b=OxAkFH157AfzuZibH4EgJwVxsT1EmKMyLIva3iPtG70l/A4Ggx+LCofx09Z89yPdI9
         IyOBYL69zJDB5ImYBycvFl+9QVKEny32cMYX7YzP4HL6zWholqFkZSCVBeVeAuoX2CmS
         Fxg9hD6mdsAKgNq3Me9YeeEYEASiJHIEdCh0+CRD5r9SBo+LIcn2cg5EGhHjOaNtlCDw
         1BzicC/7JpWALru+sr4uqcQeUWy/+ivqPYozcdPNb6TuA66N4LouHkZwO85ZwPhdnCEJ
         e8/HCx2KleOnRxIR4u0RJbIEo5jFRmMvCzMfwUfnta+8PD2tDemP/bjBc9IGOe2r36zM
         X6YA==
X-Forwarded-Encrypted: i=1; AJvYcCXjc13/KxubqK13HWqYVJl94bSUuXqXxkdSV9Y9yX9IKHnpGrrlojA1AMVzhmMc3raAuyW5XOxN@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNFio/yloF+1CYPbyeW+uSU7obWNmVHumwcFR0BAmOTYdj15p
	4HuFI9STbyIrRiQg0A5Djhuv+i0F7hrAQezRfrVX8NxIZYXILMkFFcGv
X-Gm-Gg: ASbGncvDjvbdv/XqQjxKok+Xw/cioRMF9aVibAKeekvK4Q4aEmwxZZXCOddayGOhhg5
	s/A30gOT6DDAOssK0mtfMIYGUNFAnHR4tXg3f9yXI5o8qVI7pmn3Rt35sRQtrehLUxYDbu5CVxQ
	hP7jK3PwK1WbY3umEfaPvjdG35e1CzJcOCjaDIde9Q5vGEbb8/njG0iBsGc0W4ibfQFQRcceWzR
	P0lgadDDjrQQCGXCU9p3Yi/rWVfxwBRTRFLM4kS7TIHwbZQLkkyl5ij/ZVUaqZQC93nG8ugJepr
	n+I8mNKTiSFs8mYmW8kxItp/Bd4nZE5yywJW7kYg/4yX0wJVcvqRsnzIkSEAQseY03m3g1uQg1r
	zcBwVEUUmF2EPxi0CSFjiBRHi3xoRjtw=
X-Google-Smtp-Source: AGHT+IF1K9QM9xXPHbxv+iQBGx1wzVqRd+fShGXWV89SoLukNRZD7K7KL+hoCV9IZ42WLmZ7gPGrBw==
X-Received: by 2002:a05:6a21:e8c:b0:1f5:839e:ece8 with SMTP id adf61e73a8af0-21adff46dd0mr6884180637.2.1748650064828;
        Fri, 30 May 2025 17:07:44 -0700 (PDT)
Received: from [192.168.2.10] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb5f40sm1757137a12.67.2025.05.30.17.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 17:07:44 -0700 (PDT)
Message-ID: <8f9d2b92-a2a7-4564-9cad-4f715a5f0d68@gmail.com>
Date: Fri, 30 May 2025 17:07:42 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, llong@redhat.com, klarasmodin@gmail.com,
 shakeel.butt@linux.dev, yosryahmed@google.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250528235130.200966-1-inwardvessel@gmail.com>
 <eqodyyacsde3gv7mbi2q4iik6jeg5rdrix26ztj3ihqqr7gqk4@eefifftc7cld>
Content-Language: en-US
In-Reply-To: <eqodyyacsde3gv7mbi2q4iik6jeg5rdrix26ztj3ihqqr7gqk4@eefifftc7cld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/25 2:58 AM, Michal Koutný wrote:
> On Wed, May 28, 2025 at 04:51:30PM -0700, JP Kobryn<inwardvessel@gmail.com> wrote:
>> -	if (ss) {
>> +	if (ss && sizeof(*ss->rstat_ss_cpu_lock)) {
>>   		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
>>   		if (!ss->rstat_ss_cpu_lock)
>>   			return -ENOMEM;
> <snip>
>> +		 *                                                       When the
>> +		 * lock type is zero in size, the corresponding lock functions are
>> +		 * no-ops so passing them NULL is acceptable.
> In the ideal world this consumer code (cgroup) shouldn't care about this
> at all, no?

I feel the same way. It seems this pattern can be found in a few other 
places [0][1]:

>          if (!tlocks)
>              return -ENOMEM;
>
> I.e. this
>    		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
> should work transparently on !CONFIG_SMP (return NULL or some special
> value) and the locking functions would be specialized for this value
> properly !CONFIG_SMP (no-ops as you write).
>
> Or is my proposition not so ideal?

I think an issue would be how to distinguish between receiving NULL as a 
result of
allocating size zero vs being out of memory. If returning some special 
value like an error
pointer, any related non-NULL checks in the code base would have to be 
adjusted.

I don't think the locking functions would have to change though. All I 
see is a barrier in the
macros like this [2]:

# define arch_spin_lock(lock)       do { barrier(); (void)(lock); } 
while (0)

[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/bucket_locks.c?h=v6.15#n33
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?h=v6.15#n5830
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/spinlock_up.h?h=v6.15#n64


