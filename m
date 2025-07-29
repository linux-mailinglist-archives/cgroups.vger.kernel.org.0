Return-Path: <cgroups+bounces-8923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B4CB15622
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 01:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92C57AA3A4
	for <lists+cgroups@lfdr.de>; Tue, 29 Jul 2025 23:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AFA281358;
	Tue, 29 Jul 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE+Jo0yJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99229CEB;
	Tue, 29 Jul 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753833221; cv=none; b=pM+BJhFRH8Aqor9H/2QwUmrXvJAtAOh2QB8eszEGuclgj/nVlJy92Qhu6R3MFpH4+GwG6sMAUGKY7nB0GRh1bNkHquiO6VAuets478zkiQWfcgN8zRmzMLKmTRxkubrxOC34y6Knxzk7R/tANEbilnqUe/rd6OXpaaXKTU3P7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753833221; c=relaxed/simple;
	bh=lJ9rEqGC7up2tsUTlvNTXnW3PmR2z2j7LxrzuO4zUms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFiGbDLoKDCoH5lj+eokVb2AGiEFgMw8n58yX1V/d9/QGn3Q6PzlLaTCH1rLNg/bzmVN4XyJsmkPNv8JDpJvpet2c69TOjRZm9+OirD7zZzr447h/ghOkLFQPmwodw+JYaWgioFHX2aZyInoI8IuMNXqYYiJBafl9EvPdo+Bl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE+Jo0yJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2401b855635so23498085ad.2;
        Tue, 29 Jul 2025 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753833217; x=1754438017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAojF54Z/uqFsrnjAdNBlyIkLTUR6DICxlJaUXF8EBE=;
        b=SE+Jo0yJitv07bMtzjInhhzrm20Sr1jFqfGhN2+ei/ga430+/YteAuhNgdAohEEnjX
         EStRt8GlpM1MtmOwY00Is7pl8XprEM2TWMaI5TPg588wPyho1pjCcNRhxqMk1gJtKxeD
         NYNUo87EPiQuhMm5w4M7RoIRdNdPvrlKwODkgsMQr3jNPAPvSjlN9dPOOjXWvX5GhgNL
         4AtrXTfXpx7Q9chNHirDA+gP1co5AoMe9Ut+zQ/ZaahE3SHkwbDUZOCee9yQt1Fuc/DM
         UjkeBIWLjC5hVQPWum+HUFe5iU1N7ho6x0GSZWAFOR9kG0v11WmfUHZgOvRe5ethtFAz
         gTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753833217; x=1754438017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAojF54Z/uqFsrnjAdNBlyIkLTUR6DICxlJaUXF8EBE=;
        b=Uuostbxdp4cr9GtgzIbS0RvtkLk5xzohC6YB8Tlo2kHu6rvAjD02j/Ds3jPBer18Zr
         ywe2JBLmtREDjIIdiNtds1E6ht4OqIaU8K/FCM21jU3syg9GZqyt3COZSh6eXRQEdKgQ
         UCR96eDnxHK7tsb0gUDKB0tHXEMfcR9SkCjaT8DaU0PRj1Y3knDAcHNAtZFCIG+civfK
         +ZNGw5k2m4fdiHSwSuI5RYrvatCwMRc2ilWmZ3tD/h0r3zVwh9EoDWxhYvloFDI8QIx3
         lVK5RYsmSkaLQV+YXQ8O/wixwwQgRWmdqMSj7OljtxbjowefFYccaok2xHHAHfBVxJDe
         HVmA==
X-Forwarded-Encrypted: i=1; AJvYcCWAz6xctWqPUoAHI/jASrTjJ3ocqDVXSo7IDk009sb2bsq+Qb5og+fLx7Tk7M5v4HAKJ8sHRGcK@vger.kernel.org, AJvYcCXZ5lUc9E4NMeV14UrRZMpzvFAbHJJdQ0FC40mweOz8cL9DtLuc7cuvIWNJaYAETHovm563PfbpOfCMzb8T@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+gxugejcpkIihgJAvabtdsK8gJNFHOd1Bfb+KrwfrGdK91ef
	cPqZ5Sf558pQgjPS4m2eqC0hmd1k97IervddTt2wYz5rXr3X2nmuwzvnf3Eshw==
X-Gm-Gg: ASbGncugtndrGXv2Ua8Uc4SmNr0iPQxqR/2IU7f9nDOiim/6e8KJ/5mPdADc1EtTSkm
	E8/ZZynhz+s+tTtAF+mrlTMIuCzf8Qj0LmMyrTfPPoFCzcaq5d9cr0gaufjuQgSl/+V2CKZhRjC
	wdkdUY51dLIuyHBCtC+K1dnrG8wo5ds6dICCgyFFcAR2ePpYe9+Z3iW9+UG65CVuQ4R5wG9UH/S
	cyaiK/Ap/1n7PAPvK9fUkxkuJfPImpj9zPZXi5+8O2xfK9cAvYseICRZh74/9i2CDJvl3rU3Nqa
	2ABuMqF/roC972RZqVpxzC9mCTjJgwre7qGq93mX4WRAGz3bgKtYnEW1l3RUvfIdqpQJzi+fp/G
	4IU9S2Z5JYFB/rDptzHMqVHRNoy1Oc00=
X-Google-Smtp-Source: AGHT+IFqmzZcO1UwrH9ylCFM84cQkY+Cx9WUoYiZ2Revf+C4GRz/0YuAK1G5RSnMypPuYKr8BZGoTA==
X-Received: by 2002:a17:902:ce05:b0:240:2145:e51f with SMTP id d9443c01a7336-24096a5ef9dmr18160695ad.3.1753833217217;
        Tue, 29 Jul 2025 16:53:37 -0700 (PDT)
Received: from [192.168.1.117] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2408cc228b7sm11296995ad.53.2025.07.29.16.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 16:53:36 -0700 (PDT)
Message-ID: <378a7d41-5588-44af-ae78-6bfd43e9709a@gmail.com>
Date: Tue, 29 Jul 2025 16:53:34 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250722014030.297537-1-inwardvessel@gmail.com>
 <cughucmlrkwe3unwwmtx3yrqyrqwsedrbh2ck5feqs6cr36j3z@fhrnw6nfnyte>
 <e8156c36-48f3-4983-8a2e-5a5a4444a473@gmail.com>
 <lvfxjlx6gok6lhwvf2h3reiizfztjfsyuspa7avzog6fbuozsq@bqpqe5g4fj5j>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <lvfxjlx6gok6lhwvf2h3reiizfztjfsyuspa7avzog6fbuozsq@bqpqe5g4fj5j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/25 2:42 AM, Michal Koutný wrote:
> On Mon, Jul 28, 2025 at 11:04:56AM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
>> I did consider adding an "initialized" flag to the css but since there can
>> be multiple css's per
>> cgroup it felt like it would be adding overhead. So I went the path of
>> getting the call
>> sequence right. I'm open to feedback on this, though.
> 
> An implicit flag that builds upon the assumption that css_rstat_init()
> must only succeed after it allocates ->rstat_cpu (didn't check gotchas
> of this approach with !CONFIG_SMP)

I think this can work. This can probably be the early fix and then the
refactoring can follow.

