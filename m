Return-Path: <cgroups+bounces-10886-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C9BEDCED
	for <lists+cgroups@lfdr.de>; Sun, 19 Oct 2025 01:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEC964E1AC3
	for <lists+cgroups@lfdr.de>; Sat, 18 Oct 2025 23:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77B27E07E;
	Sat, 18 Oct 2025 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QPsUems5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D631C84A1
	for <cgroups@vger.kernel.org>; Sat, 18 Oct 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760830370; cv=none; b=jDI6S+pPxvopAplpzHGS3qDc2WjnNt8TQ4X2uHgKegihuTYSBqYQ191AUKW/ZJsinStrOD5Q3fHLxsvH3cLmbYkxCv3btoS4mppNZk8MMkGJxosjyI+YzMbflEQaSIUxK3w+YldARKxB7vJpI5ulOp3FAkfIYUfNjv4nZUTnOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760830370; c=relaxed/simple;
	bh=/0vwQE9r8A/0fyZl+JyysXP8/mM2uuSJL7mYYyG/JF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEBCO5cmjpMltIkjymtxKh0dTPJpMFII63D9Eqy6MHDScSHm6bocXdIuOKa4RT55H8k7GvLDWyIKtlDuYCjfcP4uduP8/uU15qdP67NO7v9enleEJngibg1B2YZ9iqTuBSbnEDAXxW/LgAUXeCPn3w1rC9LoWT1CIsxfxZYla4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QPsUems5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4711825a02bso17444395e9.2
        for <cgroups@vger.kernel.org>; Sat, 18 Oct 2025 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760830366; x=1761435166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tPfVQIa5Jwib9noFQD468k+92gVTH5sfdXy1y74ZZuE=;
        b=QPsUems52YxDD2KXNkJJysSoLNwy7zlkm2nNfo97YCBdSmyBnzGiR/wjgWFslqoaH1
         3jGZNnSv5VO5zpZ3O2GHXnkhzObTijD6fBNzPoaj3LjoFUICfa6T1H9uFQqCfKU7ozhv
         Tl/Yte3k5KFeNqOtmyxkc23Zs53gpFzriQvxC5msDUlmmFh30b9TIeoLObqo/SrT4Z3P
         otlw/PkWDWV19HBPZaQWUkTQm9VprhKXicYAPOp2UrtFR3XJrra4fEu0PpXHT3Hgptvd
         InZgKA4JDaFFagsoUopS/CvVRY1L+B+TyxeCcSgzgM7z/63Ed8fNA+r+8akJfB7s/5Oe
         afew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760830366; x=1761435166;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPfVQIa5Jwib9noFQD468k+92gVTH5sfdXy1y74ZZuE=;
        b=YkWHzm8UqGQGpYsoM5bfj8wzZ6NMYZP7gwEAHeaLfDfmN332LvObrfB633uWDm6OX1
         5HRsdLPW36RNdEN9PHeh76sbHFQHMDFpOK/xSM8rF7rT73SHyfGTUW7AJ0E+ZojEmE+M
         4B60ZHe0HyuZ9NUL4savc9nm4ucAno69uoZuomvVi4/EU0QWGcahok8DqAGmlm+BpU7r
         gYcN6JEhUpSXk72q/OhvP1Qdugoc4lVGBJPI+nWTjYJk6DlktSE3yE0E7S3RFkbhvDIV
         BFn4C4241hDwYtTSHswxZ1+nemRvFFbmt8VgyTlKfclQ283gAkiGlmPfT2iDII+9gVYq
         Robw==
X-Gm-Message-State: AOJu0YzClLm7P9eCvswNap94jjLmqp97W37FKf0Khc4KTgL/TbN6y3Nk
	Jsh9XvU1bLthW0ufZ0e8adSBWWUyj955ZENC2CQrDQONGw/hXQNB1+AR5HEEe5kfEv7VCYUGIbV
	PXbtI
X-Gm-Gg: ASbGncufnqFtGR1s8Pchw+V67BjGVQ3+//kifjH0l+n0jl5/6sTvbSxb7YmXqyfggWd
	cRVuQ0xLogg4JVpDceZVLK5h4NoKYxq2bq9GcA+QBMJIbu73OesWbx6cpI6o6ms5zbSuHVDgeQP
	84AOUrfYAUdsKS1Jt2XOTs5PkpeIwhgu3GrlyTZKTd1EvVwPEqLUNKTsMLZkvGHKjg6nL6LSfq0
	K+9zmvznRJ4nnQBLqS9MdXW//iGFJOwL/4SDh1LODSSQQOXS49GZ/U2Q57tnTR9d+nEmsQXzeuH
	pSH4NQOFhN0gnsUJrlZDIu6d/tyeaao8KTGthduYvz7aAiUlh5jeqbYkCgoHtoHrMeWxG4iIFDr
	Ymi9Rr4EZcnhTkmjskNRhqDXz24Ahl3+o/L6Co2ELKXG1Dzgje1u0cd8G0OVjt/eVwVHVHoKPZb
	Mv0XItnmehpCTJFi0vgXlq49/tKtew
X-Google-Smtp-Source: AGHT+IE26VDX/4VuXshqWO4YJebgtP2lKQEY23OzgFZyzeSzZG+d10KxXdrpa9diOQcozQAgJ7BuaQ==
X-Received: by 2002:a05:6000:2887:b0:427:9a9:4604 with SMTP id ffacd0b85a97d-42709a9465fmr4026803f8f.45.1760830366158;
        Sat, 18 Oct 2025 16:32:46 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de7f810sm3592134a91.17.2025.10.18.16.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 16:32:45 -0700 (PDT)
Message-ID: <88463f43-347d-437b-b026-24e0c397dbb7@suse.com>
Date: Sun, 19 Oct 2025 10:02:42 +1030
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: freezing() returned false when the cgroup is being frozen
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
References: <d41dff2c-71e5-4ea3-b7d5-8412b5b0b3e6@suse.com>
 <aPQhJ2EW8wzuyjJr@slm.duckdns.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <aPQhJ2EW8wzuyjJr@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/19 09:52, Tejun Heo 写道:
> Hello,
> 
> On Sat, Oct 18, 2025 at 07:32:16PM +1030, Qu Wenruo wrote:
> ...
>> Not familiar with cgroup, but it looks like the CGROUP_FREEZING bits are
>> only set during freezer_css_online(), but not sure if for the long running
>> ioctl case it's properly triggered.
>>
>> Anyway the freezing() checks can be worked around by checking pending
>> signals inside btrfs, as cgroup freezing will send a wakeup signal to the
>> process.
>>
>> Just curious if the freezing(current) is supposed to return false for the
>> cgroup freezing case.
> 
> cgroup1 and cgroup2 have completely separate freezer implementation.
> cgroup1's piggy back on the PM freezer which can freeze user and kthreads at
> arbitrary freezing points. While that's fine for system-wide PM freezing, it
> becomes a problem for cgroup freezing as users now can produce unkillable
> frozen processes at will, which can create interesting problems (e.g. IIRC
> the unkillable state can become transitive through ptrace).
> 
> Instead, cgroup2 freezer is a part of the task job control mechanism (the
> same thing that SIGTSTP/SIGSTOP uses) and a frozen task behaves as if it has
> sticky SIGSTOP signal pending. You can kill it, ptrace it and so on. As
> such, it doesn't interact with the PM freezing mechanism at all. I suppose
> you aren't talking about kthreads, right?

Yep, I'm only talking about user space process trapped in long ioctls.

> It's just user threads doing
> long-running ioctl's in btrfs code? If so, this should be no different from
> getting any other signals. ie. If the code can handle signals and
> task_work(), cgroup2 freezer should work fine too.

The freezing behavior is fine, my main concern is that freezing() 
function doesn't return true when cgroup (v2?) is freezing the process.

As you explained, since legacy cgroup is not that widely used anymore, I 
believe systemd is using cgroup v2, thus it's fully signal based, so 
freezing() is no longer the proper way to detect such freezing, but 
signal_pending().

Maybe some comment on freezing() about this?

Thanks,
Qu

> 
> Thanks.
> 


