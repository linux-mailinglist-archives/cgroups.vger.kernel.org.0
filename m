Return-Path: <cgroups+bounces-6755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5504A4A771
	for <lists+cgroups@lfdr.de>; Sat,  1 Mar 2025 02:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BCB189CAC3
	for <lists+cgroups@lfdr.de>; Sat,  1 Mar 2025 01:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D273EA83;
	Sat,  1 Mar 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfxYSx4t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAA182D7
	for <cgroups@vger.kernel.org>; Sat,  1 Mar 2025 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792614; cv=none; b=QLKLu/A4mLPWnszGtzAXMRuDgNo3J0ZuZ5CHjSHYugqJQxOIQZSErbfngrpAx67cb4j/RN1I25JnE2sAytGBLj1hBH2qQBPk2fVvK57tEAY+okFqY07hN36uQG8EUIHm9AmAUGO+MeqOpOSVhbzo5/7A2ttrbe+8o9x8gbSFQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792614; c=relaxed/simple;
	bh=56e0BbObaUF+JpVAENl24npdFKJQqf1eympMAJPO8lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozcgfo+pTCi6yEtT1UYeiMqpCxwyddsFE51bFVp+v5jaoXCXgYctrTJidvuJF+wmXaff8JKWhAtU35i5ucTO7z++xr8L5+ApDnrepC9ZVMv1tuLkhyy/w61/eSGx714Lq9cxkdhFmTw3OdTUveEOWPeRaZTa2l0rBKE9gjJUM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfxYSx4t; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22113560c57so52953855ad.2
        for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 17:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740792612; x=1741397412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WcnC0wr+7zYlTTCeDV2IWo4JFlYwYpgFbPA87xiSvVg=;
        b=QfxYSx4tmButlFVg4WSuCikjl+plMbrtL9kLcOLpdZjJhzUCcW+nXQ/LDtjkaWamah
         N33Pthfp9vKTIm8Ed1HNbpkZBmacxe17xFU4U7Ekxcl4nhty3CNIs/lOHf72P6r927wg
         Acsd7TmS49IbZ/EhkOmdZrWhWtaf5uahsAWgsDaodrCwPuAV1qnT5xtCvrLygeepsE3k
         zQofO7mFVenzYm75XdhLC95WvqWMVP8cjWycyx7MZeEXfdMoLIxjYAnFcMI9XFZ0wJ5o
         //qkXWhwb2+DSrsI9Q6RjoNvKL+zBKIjETMCqIg2nGYS4aXk1NjuWZyHbiPPjzzfuA+I
         /N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740792612; x=1741397412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcnC0wr+7zYlTTCeDV2IWo4JFlYwYpgFbPA87xiSvVg=;
        b=nUXZwrMgxG0IlfycjIrbH/wWG6B0LE0ttHGo8SZVPYgB5f/k7fLwPRmawyv1vTHE9+
         bekqlrlwQqoUtDojGXnsxGx9n9r0Js82+C44DAwEZ0jc/fh48N9Uzqnw8wvIPr9cz/RV
         W2+AX+S2uDvVu4ez7/r0OIAggb40HdemXWSqB0g4Cc6Fxh13d1HdtCbsQ+Hk9ZHmbdI3
         38tx+kfxaCm6ketSxgrS+6Lx2N7ooryCgTwkCXZuaO9adi23YB4spWzcrz76bdysAXuR
         RDeGzLRL15l8myGGtBwLeQB+m5EScvY+hBdcdNui78E88rBuW+GU50T7VoFSRfYIGxwa
         RrGw==
X-Forwarded-Encrypted: i=1; AJvYcCWRpt1Iba7nfwAVnXxCyeN9DOLCZ+DSiADBy+l6RM/AJfqF27K+JQlRvWHKQqOROsyoYjK5+gHJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5SCroWOZGsTHGrRJ904kLxwnWtcPkyv0eVy1Owj0X8xLJCBr
	WDuWf0qYSsY12ZEnY94IL8MrjMc/6ubOoOPVxy2HncJY/NUu8HFI
X-Gm-Gg: ASbGncufAd2TMykTEapwk802FM0FnkSdmXh49LrKJ7jjglvwc+uS8XKxWcX7eVRsHoX
	wlItbpR1WXLwuhE4cETPyrB3Q9LCrLG3r61k1o54NgPwmZTEOzZ0saZVF6lYjvE0TxWbsIG4jv5
	PZIscxeV0PJSJGsw5373xfQHx0CdnddFOg0DHHtNnSDwESFyXim2yt0aWTLxqqOxlhJlX7csF6i
	U3R9ocQ/Gma4D6hpYH4wOElV/pPThRP3RA7DKl4QOFhFhVPFHrvHkggcI1PCFrtXSokQ6l7XON7
	E/2r2anzn16Pza9byHJoVYmihYGbXs8Lam9Ig6TPIt4lwmuhKwVzagt2WbUUPHiUQujd3ItIY/h
	GVdoAxin0HXwnZRI=
X-Google-Smtp-Source: AGHT+IFS84nBKQ7qD5FSWHU3UAF4RGLGLUtVzTkLxoE6IYbV54utngWld0V1qE0kZjahmoo9ERDBrQ==
X-Received: by 2002:a05:6a00:4b10:b0:731:43ca:5cc6 with SMTP id d2e1a72fcca58-734ac3d3761mr8854564b3a.15.1740792611653;
        Fri, 28 Feb 2025 17:30:11 -0800 (PST)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73637081ba7sm178941b3a.112.2025.02.28.17.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 17:30:09 -0800 (PST)
Message-ID: <0a551dcc-6a95-46a4-9a60-7e62200e63ef@gmail.com>
Date: Fri, 28 Feb 2025 17:30:08 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com> <Z8IIxUdRpqxZyIHO@google.com>
 <bd45e4df-266e-4b67-abd5-680808a40d4f@gmail.com>
 <Z8Jh7-lN_qltU7WD@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z8Jh7-lN_qltU7WD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 5:25 PM, Yosry Ahmed wrote:
> On Fri, Feb 28, 2025 at 05:06:23PM -0800, JP Kobryn wrote:
> [..]
>>>
>>>>    		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
>>>>    		if (ss->css_released)
>>> [..]
>>>> @@ -6188,6 +6186,9 @@ int __init cgroup_init(void)
>>>>    			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
>>>>    						   GFP_KERNEL);
>>>>    			BUG_ON(css->id < 0);
>>>> +
>>>> +			if (css->ss && css->ss->css_rstat_flush)
>>>> +				BUG_ON(cgroup_rstat_init(css));
>>>
>>> Why do we need this call here? We already call cgroup_rstat_init() in
>>> cgroup_init_subsys(). IIUC for subsystems with ss->early_init, we will
>>> have already called cgroup_init_subsys() in cgroup_init_early().
>>>
>>> Did I miss something?
>>
>> Hmmm it's a good question. cgroup_rstat_init() is deferred in the same
>> way that cgroup_idr_alloc() is. So for ss with early_init == true,
>> cgroup_rstat_init() is not called during cgroup_early_init().
> 
> Oh I didn't realize that the call here is only when early_init == false.
> I think we need a comment to clarify that cgroup_idr_alloc() and
> cgroup_rstat_init() are not called in cgroup_init_subsys() when
> early_init == true, and hence need to be called in cgroup_init().
> 
> Or maybe organize the code in a way to make this more obvious (put them
> in a helper with a descriptive name? idk).

I see what you're getting at. Let me think of something for v3.

> 
>>
>> Is it safe to call alloc_percpu() during early boot? If so, the
>> deferral can be removed and cgroup_rstat_init() can be called in one
>> place.
> 
> I don't think so. cgroup_init_early() is called before
> setup_per_cpu_areas().

Cool. Thanks for pointing that out.

> 
>>
>>>
>>>>    		} else {
>>>>    			cgroup_init_subsys(ss, false);
>>>>    		}
>>> [..]
>>>> @@ -300,27 +306,25 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>>>>    }
>>>>    /* see cgroup_rstat_flush() */
>>>> -static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>>>> +static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
>>>>    	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
>>>>    {
>>>> +	struct cgroup *cgrp = css->cgroup;
>>>>    	int cpu;
>>>>    	lockdep_assert_held(&cgroup_rstat_lock);
>>>>    	for_each_possible_cpu(cpu) {
>>>> -		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
>>>> +		struct cgroup_subsys_state *pos;
>>>> +		pos = cgroup_rstat_updated_list(css, cpu);
>>>>    		for (; pos; pos = pos->rstat_flush_next) {
>>>> -			struct cgroup_subsys_state *css;
>>>> +			if (!pos->ss)
>>>> +				cgroup_base_stat_flush(pos->cgroup, cpu);
>>>> +			else
>>>> +				pos->ss->css_rstat_flush(pos, cpu);
>>>> -			cgroup_base_stat_flush(pos, cpu);
>>>> -			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
>>>> -
>>>> -			rcu_read_lock();
>>>> -			list_for_each_entry_rcu(css, &pos->rstat_css_list,
>>>> -						rstat_css_node)
>>>> -				css->ss->css_rstat_flush(css, cpu);
>>>> -			rcu_read_unlock();
>>>> +			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
>>>
>>> We should call bpf_rstat_flush() only if (!pos->ss) as well, right?
>>> Otherwise we will call BPF rstat flush whenever any subsystem is
>>> flushed.
>>>
>>> I guess it's because BPF can now pass any subsystem to
>>> cgroup_rstat_flush(), and we don't keep track. I think it would be
>>> better if we do not allow BPF programs to select a css and always make
>>> them flush the self css.
>>>
>>> We can perhaps introduce a bpf_cgroup_rstat_flush() wrapper that takes
>>> in a cgroup and passes cgroup->self internally to cgroup_rstat_flush().
>>
>> I'm fine with this if others are in agreement. A similar concept was
>> done in v1.
> 
> Let's wait for Shakeel to chime in here since he suggested removing this
> hook, but I am not sure if he intended to actually do it or not. Better
> not to waste effort if this will be gone soon anyway.
> 
>>
>>>
>>> But if the plan is to remove the bpf_rstat_flush() call here soon then
>>> it's probably not worth the hassle.
>>>
>>> Shakeel (and others), WDYT?
>>


