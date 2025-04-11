Return-Path: <cgroups+bounces-7466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2F8A8520B
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 05:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D753BA617
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 03:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739AE1DED66;
	Fri, 11 Apr 2025 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJaIzT3i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2938192D66
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342296; cv=none; b=X7CQq8rOKu8Efry+U3R9F4FMNG2W9ZWTnLWTLjrYHTAXbhUKHq4SpvPgaXMKyJz1kZdMTlBpT68G4ulAaHLzsyScjR5OEOYx0i8Z/qclbx/Xk1AlJIdkGlCoShgS8Crl8bc6YAM9yT/zHig9p8/CbvH8AemVAULXC4P8/FO4Y3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342296; c=relaxed/simple;
	bh=YESqTCMPzLcHlZmNED4F/AePyaVHx3eG7yfic6crGFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWfjlhMiVvKMj8B+HtiKTx+BaT1Q2u0Is4WqMOUB8fKaeDXxPuh8GZPa5jFy3yQ5pZuYlbizA8Pv+O5xPwUPOZxjh6WygFPc2KJlTrJt+bqhprjvWYOOZXIerJT5XMMaNWLsXv613F3h/mqo94A81wUx+M+ZFXtU77qzHrOiJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJaIzT3i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224019ad9edso20820645ad.1
        for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744342294; x=1744947094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6KMYioGwvZqzqvNLntsUxx7k0qHY5fAJEFbvhfiymk=;
        b=KJaIzT3iQJrUCnw4BAXOoQ/MbXrFekP0CxSuKqTHWmpndrhkpaR5dPoqF7cmXxcq8A
         TNSoW9KqrMK+gXPHTOQxLEYpVMgNb+aYfZuloykazL6H2TTuwXd1+OEr15fHzvopTQyg
         Z3S6YAAzQrilJAo+lFXV6kbnzRgXVfoOqG2CBoX0QQpiQLAMz5oPVnfqt8TAcmWY+sNk
         yRrXyeXJRyVyKfdKQPgejClgAEh9ceqsgrMpS7FW7SuFR/YYHlqrbs/zXvxLypCFNaNf
         6Tb7zq7wtJwdLqb8uJ7oJOh1Qtac8CUKwtSgj08PzOf+TjGPWZPC8GjcaorfIUQm6CN1
         qLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744342294; x=1744947094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6KMYioGwvZqzqvNLntsUxx7k0qHY5fAJEFbvhfiymk=;
        b=vNHdxyREkGgJdDnMtr7RQHASz/qS15gP4WgNpPj235eduVkG9CLOh3BALNOtKkjD/T
         r0YSFLUcarZ97sWTbh1QarzOiDKJeuwFIvVkAdLDBKwnZRSOyhQ7snkMsfqPODVMCvcl
         x+NHeC0fKJfbqy96N/NM+KC8BezZz6YzipBPyEF8tdTPcfGb93Yop+kaI9F/xUEzuoQ1
         XJOp+A+McHojuUKbBy1+cUBY2cFAMs8AU0mG2FtKb44bcKXV09erLLU+P7Jl+W5dYjJN
         vvRbDs4xNfZVdS34pY4Toh/WHc4J26hMZ7cH3syq/l+Pj/2SPQ9un3sJVdCsLXv3YTgm
         UPOw==
X-Forwarded-Encrypted: i=1; AJvYcCUwb6jjZGTXJqK1co8xOytCJeUFPn9XxG+kTR5J3TVfVPVQxy7LFLXypXr42xS5046lUUw+AeHd@vger.kernel.org
X-Gm-Message-State: AOJu0YzaP5s0OTjdngtbFLtHcVPEY1kP8sybmkoz0NZeEekIT45KPJEE
	JyR4pAI0vo0jxpI1UMr8XZETtXWrqg/x9lP2DAHa++XBeDbNE/m8
X-Gm-Gg: ASbGnctZEv+i/3FWCrAtniFk8Nsq3a6ppJjQEXO6Gg2+Snm8lIQmp1W/2aCCLbh70yi
	8RrbBWI4MbtZ2/3Ad1h/0gOtaVlp7fpoq0mRVp5T+LR+Ws9fCU89uRqQPpPDg9hTDszTpBhvtJJ
	3Dznyv/dzmTw3kQaHR0g4n8wVRpFWO5X0zr01Hwq77n8CUD94rT+1+IdSATdYd6A55RHn5qDmvW
	jaY02EKlOM3X3LAAdQ8oKHrYR6Na8X9hRP9QBIOGsECVg9nTxPgdAjfqkBfSnryaF0ytJh/dLpd
	f/ntc0kK97WOFuNHQvj+g2FqIiWzsq2BDrJJTcPa5NSP9vCbb4XoMdNcLLGPmao6+osqlC8lMFZ
	iYFQD7MtgMw==
X-Google-Smtp-Source: AGHT+IEjgeFqbmzv/qsJfxVeaJrC9P6gUgiU8XFC2/wT7D1SXFzvlvZfurFfP6FU7HnbUEf/eiGZhw==
X-Received: by 2002:a17:902:e84e:b0:224:584:6f04 with SMTP id d9443c01a7336-22bea4ab6b7mr14734875ad.18.1744342293924;
        Thu, 10 Apr 2025 20:31:33 -0700 (PDT)
Received: from [192.168.2.10] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95c62sm38838595ad.125.2025.04.10.20.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 20:31:32 -0700 (PDT)
Message-ID: <ac6758cb-58ef-41c9-9d3d-625cbe0eeefb@gmail.com>
Date: Thu, 10 Apr 2025 20:31:31 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
To: Tejun Heo <tj@kernel.org>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
 <Z_BA2UD8jHCpvz4B@slm.duckdns.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z_BA2UD8jHCpvz4B@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/25 1:28 PM, Tejun Heo wrote:
> On Thu, Apr 03, 2025 at 06:10:50PM -0700, JP Kobryn wrote:
>> It is possible to eliminate contention between subsystems when
>> updating/flushing stats by using subsystem-specific locks. Let the existing
>> rstat locks be dedicated to the cgroup base stats and rename them to
>> reflect that. Add similar locks to the cgroup_subsys struct for use with
>> individual subsystems.
>>
>> Lock initialization is done in the new function ss_rstat_init(ss) which
>> replaces cgroup_rstat_boot(void). If NULL is passed to this function, the
>> global base stat locks will be initialized. Otherwise, the subsystem locks
>> will be initialized.
>>
>> Change the existing lock helper functions to accept a reference to a css.
>> Then within these functions, conditionally select the appropriate locks
>> based on the subsystem affiliation of the given css. Add helper functions
>> for this selection routine to avoid repeated code.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 4-5 look fine to me. I'll wait for others to chime in before applying.
>
> Thanks.
>
Michal, Yosry, can you give patches 4 and 5 a look? I think the changes 
requested up to this

point have been worked into the series.


