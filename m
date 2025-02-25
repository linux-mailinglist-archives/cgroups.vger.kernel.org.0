Return-Path: <cgroups+bounces-6715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82481A44B2D
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 20:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26993B5455
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157F1A2567;
	Tue, 25 Feb 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDeBtCy9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECB1547F8
	for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511254; cv=none; b=Dag1oOzCD+tH1sqaEPW8jOhANW4nQmSs4HIlOwVEiGz44lJ5RgqxQAVZJu9anL96oQOdyOrv3bTjWnNhfIX4S8eh+HHNU5uuw21SxOTuu3f/gbaZfu6twcZIk36+mm7tcWy3HfuTRUy1uSAyLj/oVt7XMoAlAnbmsWlV5e+0E/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511254; c=relaxed/simple;
	bh=a2qsdSzbQRfL2k/qSK9ZxfnUG1eWsKfNax29GN3kJFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/tkZdsflebYZzHINHOobVNq4oeTVnDVAhRUTT364ltNS/Df48k/uOY7HvXMRii2ZkljBcCT8dJZRQYQHacDnBozfc7mQbPo0n/mq2MBCeMiCnYg4ytJ7GE25R36CPoWVRU2Y4RVRMQR4AyFCt0YTFI0KbS+hO1dyzpTw9ZqVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDeBtCy9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2211acda7f6so135818925ad.3
        for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 11:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740511252; x=1741116052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RARoSJFMUdQN3QyYp+tR9O5/gRRxTrGr5MQp2tsGrUI=;
        b=DDeBtCy9xh3h5+uoa8SHzlgNJrNBLaZThAJyy9bZWLv+1tIZRlsrFedLK4Ke2E1E1V
         c40TMEGtDdn9J9ZpAT9EX+BzffL1gec81jzaQwooHMuHcVcOXDp3JnPRoHq8EsOm3pPq
         GzXfZdmdu+fPoTF8ffQFNRJ2E9wX/5C/3G8y/v0EnWM8KHAtdXIuNXDa2DoimnC6FTdL
         RDcU+ywt/McEjKzrkQFUeLOdhUsBTyQpSSFTl9GxUk4Wju2hWiJLo3QuREzX08tNVoc+
         1eQ07wmLMacospd3zuEkTUrF6trzbNHGPwzY97G9anes6Olxb/2M7toQf+Vmgg0fLqQd
         moLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740511252; x=1741116052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RARoSJFMUdQN3QyYp+tR9O5/gRRxTrGr5MQp2tsGrUI=;
        b=bszdxRk4bfhgjm0JSjIJjJcDSZXngDlR5UG672xFN0IzqGLSXUl4agmqGOnzjvB1dd
         wkezt9yFyEbVIikaFGHlj1Q/TkzBI/92zx7qEpYKaeCRX7frHhGozmLaPYzjDS8IVaN8
         C19er9KLsxJkWn802pKRsUt6fPDk7l14PZ37FyfVqMrSOWxIkU6UvIV3j8A244V2tYM+
         nXzMiIrBEBXTuLA2Bgl4bLIOzqRs+vkssm6PJbk4Z3Beb+bU8QmN2SwkAdgOAO4yIqwR
         P1+Ww7QcUadd8ufvBGJgDDx7vI2HLp3jFGNwAwTyyp7QvqI+JoLM1mcWi1IJ7h/S6/lF
         B7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkboJ0MQGu2IpomZXHg1iXYRK7KLonTCllhWfdIg4j6AOPc7umHrNELTHIzC7UnAJO27XkJYv8@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyGdpGv1Tk0KoJdUTaIcKmHQ8AVOCwW1DRNBBOwoWJS9aori/
	msH2xS47IO1UPJ3+ijeo5lqafyF9Rse55DyaUUqJwH3gc4+HQa5SB6PiKw==
X-Gm-Gg: ASbGnctBnIVR8JSnK+71NL4znkwr3LuunQnMiu9KpXkHvtNTXmyueoo3GvRXYwhqzD5
	34nXZ8/UH8eshlHHC9wdPGK3TY/q/1O7JvDBkaneGDv9ErSgazMMoJ7lbCQjsvh7NMnB/5wlXNY
	oiS6ccfZVPM07jZdRRFc6TKZHBp4qcAb64cXEUStYhP05oKIrWqfAlk4UA7nMPpcvXLBfLpuxkx
	ilgUbk+CP3oexZ51EB/VsJcjDbs4VhPxcot3F3VpoHva0M/wY9p1D11ixyg8mWLkh08oCYNp62q
	86IKcof9lNXU8HOUeT6gjDKqgbrPqR91Iqeu/csUbO5h21gIgb6QyRZMoVE=
X-Google-Smtp-Source: AGHT+IEYHBqoR7HqO01GqOk1FyOIutNksksY4x6woVPhNH/xTQLyHZNQ5bVskEq5n49/TddfPlO5Vg==
X-Received: by 2002:a17:902:d48f:b0:220:f7bb:849 with SMTP id d9443c01a7336-22320099429mr8181545ad.13.1740511252066;
        Tue, 25 Feb 2025 11:20:52 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:d919:fdd7:c8cc:6adc? ([2620:10d:c090:500::4:79cf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a63efsm17859725ad.205.2025.02.25.11.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 11:20:51 -0800 (PST)
Message-ID: <ab098b58-3043-46bb-a026-2713d67ab63f@gmail.com>
Date: Tue, 25 Feb 2025 11:20:49 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org,
 akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 kernel-team@meta.com
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-4-inwardvessel@gmail.com>
 <yz6jmggzhbejzybcign2k3mfxvkx5zb6fxlacscrprbjsoplki@6x5dtnmzks7u>
 <Z7dk7t9vH42FYSBG@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z7dk7t9vH42FYSBG@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 9:22 AM, Yosry Ahmed wrote:
> On Thu, Feb 20, 2025 at 09:06:44AM -0800, Shakeel Butt wrote:
>> On Mon, Feb 17, 2025 at 07:14:40PM -0800, JP Kobryn wrote:
>> [...]
>>> @@ -3240,6 +3234,12 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
>>>   				css = css_create(dsct, ss);
>>>   				if (IS_ERR(css))
>>>   					return PTR_ERR(css);
>>
>> Since rstat is part of css, why not cgroup_rstat_init() inside
>> css_create()?

Good idea. Will do that in v2.
>>
>>> +
>>> +				if (css->ss && css->ss->css_rstat_flush) {
>>> +					ret = cgroup_rstat_init(css);
>>> +					if (ret)
>>> +						goto err_out;
>>> +				}
>>>   			}
>>>   
>>>   			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
>>> @@ -3253,6 +3253 css when it is destroyed, so moving the cleanup to css_kill()
should handle th,21 @@ static int cgroup_apply_control_enable(struct 
cgroup *cgrp)
>>>   	}
>>>   
>>>   	return 0;
>>
>> Why not the following cleanup in css_kill()? If you handle it in
>> css_kill(), you don't need this special handling.
> 
> Also, I don't think we are currently calling cgroup_rstat_exit() for
> every css when it is destroyed, so moving the cleanup to css_kill()
> should handle this as well.

Thanks, this makes sense and will eliminate the need for the extra 
cleanup here. It seems that instead of kill_css(), the 
css_free_rwork_fn() function is a good place to call css_rstat_exit(), 
since it corresponds with calling cgroup_rstat_exit() when the css is
the "self" base stats.
> 
>>
>>> +
>>> +err_out:
>>> +	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
>>> +		for_each_subsys(ss, ssid) {
>>> +			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
>>> +
>>> +			if (!(cgroup_ss_mask(dsct) & (1 << ss->id)))
>>> +				continue;
>>> +
>>> +			if (css && css->ss && css->ss->css_rstat_flush)
>>> +				cgroup_rstat_exit(css);
>>> +		}
>>> +	}
>>> +
>>> +	return ret;
>>>   }
>>


