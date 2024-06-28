Return-Path: <cgroups+bounces-3440-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5291B5B8
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 06:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D3A1C21887
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 04:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99B224CC;
	Fri, 28 Jun 2024 04:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=discourse.org header.i=@discourse.org header.b="CAexxBll"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4420DCB
	for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719549071; cv=none; b=P8oM2hmWz5PaxJd9Eh17YJHz24MomCVMJVOecoIleAxoJ3C/uE5+6RuNQPDn+A0Dl6Sd/Z0EWd6LoblSzjYKf9PWO+RulUj5b+x3ThjyA+pGKG67JdEuu2CTj+GM2x8E0ckKZkFSUE8C4NBA4PU0HVus6QZIfsS19RAB1UgxcmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719549071; c=relaxed/simple;
	bh=Y9x+opTZ0BPj3XoxmYesKxFdLC1Rz5gamwXHpoF8THg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnKw/STAyMh67NNrGU+4y7R97vnUmtY7fkVWRU1DVN98Wkw5sA4hsu8dr7qQOXvSnxI+J7wWKUO2LJCwHT07nn8OxWOmjeW4M47OdwHOkMwy5ifXnbGqKj+m5ZVVnWWMRLkzP4AlMfJciaAnohlwV8L/aTGz8aZ6wTmv/PG4moQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=discourse.org; spf=pass smtp.mailfrom=discourse.org; dkim=pass (1024-bit key) header.d=discourse.org header.i=@discourse.org header.b=CAexxBll; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=discourse.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=discourse.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-700cbdd90fbso121409a34.0
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 21:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=discourse.org; s=google; t=1719549065; x=1720153865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EQkDNARsMAPDljbUc9Ko7RkreNfYrlM9x+xWvFzxSY4=;
        b=CAexxBll55FWf2xwKW9csGEQ1XGSU9A1lTT9ZqhhcVp8rVWsongWeZXEpVLo/5Yw9A
         eN581m9RaDVnEAieiGxSi06m6rxnwv1SB6KHzioXs/zYYG6ig5b/yLRBGIq1nH9Lq8jm
         JNOXtXhd2KeBApdTTaMP7RcsQng8GOgxScujU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719549065; x=1720153865;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQkDNARsMAPDljbUc9Ko7RkreNfYrlM9x+xWvFzxSY4=;
        b=UlgqT4xK7EH/dSimw5ssXwDqhEfM/lC39+AiqPTIrJg8VtFwVUqQF/9z9oYRMp4QiH
         YG2EPfdK776ToKQJp+meDigs+2J+7J85KL8wusFUhOokD+SNflAEEPLjL9gHam8R+trx
         UoeK4cHZkE05TpIBSo18HWPjl/CPCzJL1E1Zwv9ek+nOlYRlMnvdHZGdyPr/dhuMovp+
         ozGEx9S1bgWIEFlqzL9pwUp/hmtLe/LE7ZEWvX2SDQdYsGbJpMZdtVOjYVrzNQgAi48c
         7qICFDBp7XMgyfF4UD0l6zlarcVjkZZfbw+YHOQZ0GDi4IIAvBZpfAG/edaqCz5qPfsg
         6Jhg==
X-Gm-Message-State: AOJu0YwiDxPepDkrdt/QVJuJGoVg3gnQuU6f8wCzw5to2LaluxTsOQEB
	bDGrUPWHLaPaSKBoOfZNLf/xS4x0SqKFnOKhSXn7yB1DC2KEHL6dmpFWw3M3Pcj7CnrdKSJighU
	K
X-Google-Smtp-Source: AGHT+IEbcXGXrpz0lzY0Icc7enxeSOQJKLQ5tO5rEexA2v7QBVtX/Z1v3rFSByfs2dathGDSLL90gw==
X-Received: by 2002:a05:6830:671c:b0:700:cea4:fb9c with SMTP id 46e09a7af769-700cea4fd7cmr13227618a34.34.1719549065042;
        Thu, 27 Jun 2024 21:31:05 -0700 (PDT)
Received: from ?IPV6:2403:5817:22f2:0:2ef0:5dff:fe39:5b3a? ([2403:5817:22f2:0:2ef0:5dff:fe39:5b3a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f761fsm480053a12.62.2024.06.27.21.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 21:31:04 -0700 (PDT)
Message-ID: <82aa66e1-6b3e-4663-9369-5b7bbf2e4d07@discourse.org>
Date: Fri, 28 Jun 2024 14:31:00 +1000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unexpected CPU pressure measurements when applying cpu.max
 control
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <d13273c1-533b-46b4-a3ab-25927a8b334e@discourse.org>
 <Zn3SfIDbZhiySAOQ@slm.duckdns.org>
Content-Language: en-AU
From: Michael Fitz-Payne <fitzy@discourse.org>
Organization: Civilized Discourse Construction Kit, Inc.
In-Reply-To: <Zn3SfIDbZhiySAOQ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun,

Thank you for the response.

On 28/6/24 06:58, Tejun Heo wrote:

>> In short, processes executing within a CPU-limited cgroup are contributing
>> to the system-wide CPU pressure measurement. This results in misleading data
>> that points toward system CPU contention, when no system-wide contention
>> exists.
> 
> This is in line with how PSI aggregation is defined for other resources. It
> doesn't care why the pressure condition exists. e.g. If system.slice is the
> only runnable top level cgroup and it's thrashing severely due to
> memory.high, the system level metrics will be reporting full memory
> pressure.

OK, that makes full sense why the pressure aggregation results in these 
reported measurements.

>> - On 5.10 the 'full' line is not present in either the cgroup cpu.pressure
>> interface or the kernel /proc/pressure/cpu interface. I'm assuming this was
>> added in a newer kernel at some point.
> 
> Yes, because full pressures are defined in terms of CPU cycles that couldn't
> be consumed due to lack of the resource, initially, we didn't have
> definition for CPU full pressure. Later, we used that for measuring cpu.max
> throttling. It makes some sense but can also be argued that it's not quite
> the same thing.

That explains what I had observed on 6.8.9 - the cgroup full 
cpu.pressure measurements were what I would have expected from the 
artificially constrained workload.

Whilst it may not be *quite* the same thing (some/full pressure), I 
think the outcome is better information that what older kernels provided.

>> As we know, the kernel 'full' measurement is undefined.
> 
> How do you mean?

I was specifically referring to the kernel.org documentation here, which 
states:

"CPU full is undefined at the system level, but has been reported since 
5.13, so it is set to zero for backward compatibility."

Accounting the above note on the cgroup cpu.pressure, I think I have a 
way forward.

> This sounds more like you want to measure local (non-hierarchical) pressure.
> Maybe that makes sense although I'm not sure whether this can be defined
> neatly.

If we were to group CPU-limited (cpu.max) processes into cgroups 
separate from unconstrained processes (e.g. system.slice), we could more 
accurately observe the 'rest of the world' CPU pressure by mostly 
ignoring the cpu.pressure measurements from those cgroups.

This may be enough for what we need - which is really just a strong 
signal of *unexpected* CPU contention.

Thanks

