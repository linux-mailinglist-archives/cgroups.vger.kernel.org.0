Return-Path: <cgroups+bounces-7370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9543A7C576
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 23:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6F0189FF1C
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A4C1C84A3;
	Fri,  4 Apr 2025 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1OQy9fa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4AC8E0
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801686; cv=none; b=CCiQWywLYYfwLzklzT+mpqzeic1aAur/HYPFkuOnj3g+8Zsa92SOCe22H3CMWxNXD8D8QlsDjkEcnIKruoj/lL5jHSC1XX5xaB6dhcdiBxOxnGA/ZVUmVIgN77ghsdcHfhdQs255l8qw2/zV+/ExPWY3H26Du2eG72m/6+QDlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801686; c=relaxed/simple;
	bh=yOZaYPlc6TvzNQfRH8b3abqDo0J+KA7bDHM0i/JQ608=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbliR5rJY3OWaL+fFX+dr35C+iGqhqljDN43A/bncQBrqqOFsWN3DJV14TCOnApe+OT3XoX/u/PM+OC/B+tIpgyTBEhiliTeDRJTmBKDEo1kEdz24L3SihBXKbTKL9nMFMxq0MBF/Ux94/+qypfux7G6nCBPp6+O6BmbxWkdjig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1OQy9fa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso34416745ad.2
        for <cgroups@vger.kernel.org>; Fri, 04 Apr 2025 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743801684; x=1744406484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCDFsmCLXNsZf0RsjmKJX1X6mpiwwMUVa78UqlfKrP0=;
        b=I1OQy9faoTFc7UOgNptDfycBPVTsl7XkNyWy6Akk1oGuUKBBp46dpHC1GBySFeCMN9
         4JBbwmMvd0Q72fUmVFH+ycOWIwSEMsx5d72GOOroWXmhmlP+yj5vqkWm8X/2iKfyg9fQ
         sqlJI1WCavA+LPirXqkCNDLFqn9d7aYchFqqt+a25QyPqH+NENihWLmzYWMvyZNtVAiA
         H31SRDAF9e36LfnOQ3bHR5L7Cxr6OTF2z9SJMTImYUQ8fG4vtHvUOVQ2Beo6hwJD2qp/
         HFGllnAF+shp8+qxhk+PuYuKKAE+r7qVqddINTi/DQC1DCHc9G6OrR1wy0sJRXkcBdZ6
         NRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801684; x=1744406484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCDFsmCLXNsZf0RsjmKJX1X6mpiwwMUVa78UqlfKrP0=;
        b=hDd4dhxpVu9MMznB0pwF3LCsnaISBqNRogJzskL8Df49Guz9L+KlzmrsZPCAXBzvy1
         WGkESnG/7DF0am0JdnY7CSCSmKMDKqO0NdvEHIjtw+gmhy2coPykQKDYfm8ZOgQwHbEi
         zn1Fh39LoY3aBr6W0B2ROpoxlrp6WsI47D73K0oPBV+9O8FYJu4adE7wELd+FqoWqhZ2
         93ButLKQlHLDwtE2DEbNcgXz5NcDul20ljPiYnMTwbbB7HWEZ73qZUsVVo82yyBdvw53
         /oaPrBWVxJ6LB+T3/NX7QP9Y8LCIRm4HGemuq0/sTUAoCep/p1ExC/7/R/B9NylqOZAU
         OS5A==
X-Forwarded-Encrypted: i=1; AJvYcCXFAgwXtKcVVLwG7hNAH1y9lzXPRdsTouEMmptuaWlk3EnLIv3nD1mOkY/4UKtTPzRm2V+yA//7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04K9Md8GE94GqWwnNWe0Aipl958oZgxFVLc5cpALOhHJz52i5
	3BG9I/nlE6Mih72ZuqeY735KNW7YBP/82vww7Q8AmOan0sMaLdOS
X-Gm-Gg: ASbGncsu6905f/fEXzXkwxucNz5SZYtgijfeFVlbI7IcJC1KZtYbfSE0Mg87/0I0K1F
	4RVyGZGVapzq3evORp74IaWXvZ0D+QFfEVXzhG8ucKid3B6EE9Ye4b5mWEtRG2ZMqNBY573fsUs
	cQFBqGBO/i6k4QFeQ/10Rm58Xenw6WgyjXaxO8lmOqv/nXJsbDiOJ2P/bKaTQYU3oZ23Y8P1k9R
	d4gdVI6MfR/xaeyw4Xm8gkPdm9cyAMAkH7MMBzxv3OudpK0L2+/+KqODe11gL/IJWmXbSY6gTOy
	97qm2ovHYvbgEENUPkNYY1wCX+ne9+a/AC5TQAENvfLMvpqWmFk15+23PcDSdupsNKi+TWd3iHc
	2tudo44WVhvEzuCs=
X-Google-Smtp-Source: AGHT+IGLlcM3WioENcq4p23jy3bfRO+1RDbfA+DKFQTDFRa4ZtZ8MehPirkPRZR6rK1AZvGlE4xHNw==
X-Received: by 2002:a17:903:8c7:b0:21f:71b4:d2aa with SMTP id d9443c01a7336-22a8a042b20mr69352375ad.5.1743801683861;
        Fri, 04 Apr 2025 14:21:23 -0700 (PDT)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1ccsm37329615ad.174.2025.04.04.14.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 14:21:23 -0700 (PDT)
Message-ID: <5cafaf69-133c-42ad-a481-d4ea843298e5@gmail.com>
Date: Fri, 4 Apr 2025 14:21:21 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] cgroup: change rstat function signatures from
 cgroup-based to css-based
To: Tejun Heo <tj@kernel.org>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-4-inwardvessel@gmail.com>
 <Z_A6WXpNcybYssn6@slm.duckdns.org> <Z_A8jcXXKJp-snYA@slm.duckdns.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z_A8jcXXKJp-snYA@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/25 1:09 PM, Tejun Heo wrote:
> On Fri, Apr 04, 2025 at 10:00:25AM -1000, Tejun Heo wrote:
>> On Thu, Apr 03, 2025 at 06:10:48PM -0700, JP Kobryn wrote:
>>> This non-functional change serves as preparation for moving to
>>> subsystem-based rstat trees. To simplify future commits, change the
>>> signatures of existing cgroup-based rstat functions to become css-based and
>>> rename them to reflect that.
>>>
>>> Though the signatures have changed, the implementations have not. Within
>>> these functions use the css->cgroup pointer to obtain the associated cgroup
>>> and allow code to function the same just as it did before this patch. At
>>> applicable call sites, pass the subsystem-specific css pointer as an
>>> argument or pass a pointer to cgroup::self if not in subsystem context.
>>>
>>> Note that cgroup_rstat_updated_list() and cgroup_rstat_push_children()
>>> are not altered yet since there would be a larger amount of css to
>>> cgroup conversions which may overcomplicate the code at this
>>> intermediate phase.
>>>
>>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>>
>> Applied 1-3 to cgroup/for-5.16.
> 
> There were some conflicts with the commits already in cgroup/for-5.15-fixes.
> I resolved them but it'd be great if you can verify that I didn't do
> anything silly.

I'm thinking you meant 6.* instead of 5.* in the two branches above. The
changes to resolve conflicts look good to me. Thanks for the quick
review.

> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.16
> 
> Thanks.
> 


