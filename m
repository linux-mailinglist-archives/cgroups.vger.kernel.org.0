Return-Path: <cgroups+bounces-7232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D8AA708B8
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 19:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFD4188ADE7
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2483264A81;
	Tue, 25 Mar 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3XwQfmv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77626463D
	for <cgroups@vger.kernel.org>; Tue, 25 Mar 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925811; cv=none; b=LXbIDwajx9kX1CJRJ1vRLB+ogOYKX+y+34n1q7DrtyOdcXLnao71LiRSQodhhFKmGlELgT0FpPehSCNX4lBWxALxKfN2QNq97uhuhiWOytkPLYKCocO/cWwj/b3dB/blUP60e9Yf37JRMcjKu+PNZm/W86Uugj6LwyibJkhJsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925811; c=relaxed/simple;
	bh=2DJdpTFXW7xELmylfCyOKTdfNRBbEu8KWXFcMDdga+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cbsg+YpWWg257Q4CAaMdh+45XCnMYU83aiSKfWHCoaH8Kv18LEkPQNs3uCeRIoTEj8DHyndxcD+0mdYfodGvniS06WK05IbOTT04zJj3cweXk39LiG8z6/s7ImTmsmriNy+atF0uoRPmgYYkD98GtBgqQY4opNGqFouPlGF2Z60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3XwQfmv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22398e09e39so123589895ad.3
        for <cgroups@vger.kernel.org>; Tue, 25 Mar 2025 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925809; x=1743530609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OFHC4oxGhg/toa6bpGo7PeSs9DiV3rh5O8lrz2FAFs=;
        b=B3XwQfmv7xhI2FHFcRiLraqgEcXQuSUBHecmzHyiVQA4vnld4nPorlCxjAa6Qnx8BZ
         SkEZpaShuv3fSTu4ojCD9WgrZDlFYfCcgj/thI7y9LPazyenYlNtg0BZUJ5Ghq5DZzmF
         JKFJuHKrGE9eLmCMzAKfZO77jICr3DAuIatqwlOaIboga64i4tCF0duhccv24bTfjGbk
         uzWZM8/BXGThE0CBzJN29R8erHrhpsH5o/9W4w0aUYNSxsQGB1RNThBhO6sYrEHVsZt8
         dLVZlswgJ5VFQxvet5xCjRUpsuJ+HZ/vjCCIhxr372EapuONRQ9kxvpJc604+eIyVi0T
         5Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925809; x=1743530609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OFHC4oxGhg/toa6bpGo7PeSs9DiV3rh5O8lrz2FAFs=;
        b=D1KXpZ8EQlZ+dsDnqJDXWMivV5JBCHTCo+hIP7jD4PHRqoSwYVegCw2kdKzEzNZCOs
         d221OpoUQJ8Gk+2C3SKU4R8vdi+cUUWGOrfFw9D+eYaoW/ApmlY/1JOsSE0nN9BRqCfm
         SD7NCYOXHf+K5ZrdNa9YYKOeuafYbY5HVAgCnMJnfdbK8uD8i1rji72EPWHBthpUZumA
         wEtdxTMeDtE0e6fKPWI78pYhF2vbk7kIM7QiHmmjjgNRyfAMnBA3rfiByX+Ef9+VtcrC
         DZpKOiv56Thph+tqkYC++ugU1XJoFaXsPsFJZ0xXTcrSy9iA5JCZPpgGUJ/I/ZwRLhSX
         lGAw==
X-Forwarded-Encrypted: i=1; AJvYcCWmwGODhcvzyfrEmy44GgUj6qzsFgszyZcWsIJhRYvR4+S29JSAqaushfm8hXoJgq4pXZk4yxKw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60k8rxbyofACP2E7Zs51hrUxZP94VDQlbyt0ipx5IMbSARa86
	urMc4g6uUHEHNejd1peme8B80VS6t5q5gE9WXOrMh1zjBNE4ANxf
X-Gm-Gg: ASbGncvFalaSq669N4RJjWYb6H6f4O7h4yPobWISl278RNaDVh8urLNLTYqW/YMbPNU
	SGeXEm75k43/l6IIedzuq31iTUl2tv/cUP3XgE1JGmGgTvNziQfyQwlxcc8qKWSmFO1IgnULMgH
	QPkeuYgWwIP+Ll338WlrgCBW6aNo9R/8VdnEdEUCGXM1dG9YnYt+l6gZm1qm89b4TB/eYwDqaY5
	L6UmFj4RCvm/ZVVN455pw7zCLr2AOm6T9XliNjBW7uztzglTPIqbe3moSjlx5Sm2vuDJTlxjLrF
	oLz20OpKn9TfYuAEn/bnK13QeDDHSk1up7274yD6o2bDKO7nHrJHLnd0uSfQC77+9S4TFWQCGiK
	zM8aXx9oJPQq2JgurgQW46DEHFQ==
X-Google-Smtp-Source: AGHT+IGRcIkV+T0NdTkjungee/b9D2PnTIi31LT82NdWbq9QwJcA4yfw4vLUE/v7qpb0mRjHF0RbHA==
X-Received: by 2002:a05:6a21:688:b0:1f5:7353:c303 with SMTP id adf61e73a8af0-1fe42f2cbf3mr29019788637.11.1742925809037;
        Tue, 25 Mar 2025 11:03:29 -0700 (PDT)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa92bbsm10913499b3a.16.2025.03.25.11.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 11:03:28 -0700 (PDT)
Message-ID: <11a80d4a-9776-4a43-8c61-5cc1ad4abbc7@gmail.com>
Date: Tue, 25 Mar 2025 11:03:26 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v3] cgroup: use separate rstat api for bpf programs
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-2-inwardvessel@gmail.com>
 <4akwk5uurrhqo4mb7rxijnwsgy35sotygnr5ugvp7xvwyofwn2@v6jx3qzq66ln>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <4akwk5uurrhqo4mb7rxijnwsgy35sotygnr5ugvp7xvwyofwn2@v6jx3qzq66ln>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/24/25 10:47 AM, Michal Koutný wrote:
> On Wed, Mar 19, 2025 at 03:21:47PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
>> The rstat updated/flush API functions are exported as kfuncs so bpf
>> programs can make the same calls that in-kernel code can. Split these API
>> functions into separate in-kernel and bpf versions. Function signatures
>> remain unchanged. The kfuncs are named with the prefix "bpf_". This
>> non-functional change allows for future commits which will modify the
>> signature of the in-kernel API without impacting bpf call sites. The
>> implementations of the kfuncs serve as adapters to the in-kernel API.
> 
> This made me look up
> https://docs.kernel.org/bpf/kfuncs.html#bpf-kfunc-lifecycle-expectations
> 
> The series reworks existing kfuncs anyway, is it necessary to have the
> bpf_ versions? The semantics is changed too from base+all subsystems
> flush to only base flush (bpf_rstat_flush()).

This patch was done based on some conversation in v2 around what to do
with the kfuncs (bottom of [0]). It's true the kfunc API deviates from
flush-specific-subsystem approach. Dropping this patch is fine by me and
I assume it would be ok with Yosry (based on comments at end of [0]),
but I'll wait and see if he has any input.

[0] https://lore.kernel.org/all/Z8IIxUdRpqxZyIHO@google.com/

> 
> I'd perhaps do the changes freely w/out taking kfuncs into account and
> then add possible reconstructive patches towards the end of the series.
> (I'm not unsure whether the modified btf_type_tag_percpu.c selftest
> survives the latest unionization of base stats.)
> 
> 
> Michal


