Return-Path: <cgroups+bounces-8139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60EAB3505
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78145189DE37
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A9266B73;
	Mon, 12 May 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RqLZha3W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82322255F4D
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747046210; cv=none; b=Xsa7oHeZrCy6S8ShBXuQe8s4ZnNAZzFfS10sbCxA4vTD41qywtyYhWjmR9HM8vUnMwvZHMPiQ3hTG9Mpkd5ORhS1BqdwT6ADkjeJuV1KkTaG/FrUeRhOSaBxLMuVZi+SK19HDn0UtppQCrG597w1ZDyqvU/KBWRQWpmY+co4jK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747046210; c=relaxed/simple;
	bh=grWKcuszBYfX5XjvmYER5UpUwXN2KPvsZQy+qbn88KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td9URQI/8xiS5URnV53ESj/stVeL5llKPRt4YU2Y6QllHT3uK1/QWAFrX6fK8WBPFp1Gt6xr/EjJW7ImkpVug7uBjJjF5DvQ0iYIDVz14tGhN3I6/dsnXBcqUPg+4E7OZM0BUkNfqOeCbw2dhMUhW4LitNDxtilL1e2O/xmBeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RqLZha3W; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso783996166b.0
        for <cgroups@vger.kernel.org>; Mon, 12 May 2025 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747046207; x=1747651007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=grWKcuszBYfX5XjvmYER5UpUwXN2KPvsZQy+qbn88KY=;
        b=RqLZha3WoHdCgSW6yGKjpDGnL0IcUoRQiujPU1QXs1mlDOXuAFx2YO48aau3pwkwnE
         gLKj45LtuORUQO2ewNWeCXY2G8IuhdCgToOOqYJjjLVlsTYLstvqO6OeJwxz/qHLA4oO
         hkSdwARTIuLU6cDnE9GrR8Kk2z79rSY9mpBANhqhvMi0qjyi6RHdFLvQq87QAK1c4x+u
         x2yd8BxZfCXH6lk6yNB7S9R18OS7YfrjEyQQSaiOTsnDvPI5T+4/1iPMu9/XBaDz3vmj
         05/2TMmgfF/aYBi/QjX2BkzcSodYlNmKKWtMDWEbBrwZ0B/wjaf/NgJDZRoPaVchncSx
         NBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747046207; x=1747651007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grWKcuszBYfX5XjvmYER5UpUwXN2KPvsZQy+qbn88KY=;
        b=BUJEf1BiUNcAioZsAjzhUGu3bWTesKNEoUs1WB7zK0/YR7OT42oS+XTuWTZWUrltpd
         vMFLOOE4F93d4EzuQ0CpqC8Oi/uCmp+YUJYuF8ugfOJdYnbNbwpiksRYXA32Y+9dZjPL
         nAunYtdRsyPwXvfC71khLtR2Ve19qWs9HpKtZ4zYJWUR4eJW0Gt7+3m00lZgnl0sLG8u
         cNbV3gv9melv9XStAILMW1rKTE+LweCbBZesz2OT/PCGv3H+GsngKZ9DW0/bFU3YMLIv
         vgGoHjpqLN4xDrwmDDQKQC+5u+J0wRcGRBP1CfRTWP0xlz1t//z6aV6yzY3wvMkcXvpi
         ZjLg==
X-Forwarded-Encrypted: i=1; AJvYcCWgVkKaQJE4t5Htl2c/o5/rxDZDVQ7r8iSVOpRS6xfN6UJy+CBqSe4ADHXNk+7gXu7gMCrQkhab@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr2hRFsM4EQ+DguVbU+i51xO0vgQFKySF7oHrGboxRi9cq4rkk
	UvyxfWtlpYw1vzVv/j/ey4X0kYktqMMxgHn7fEcFj/Vzx0cqfgmUbQqk25MH4iI=
X-Gm-Gg: ASbGnctlbyLhlCTCLJ8HH6qeFnb+lLJp0H9qQkNwlYnAONS8TEGGvys66KwXtoCdUIY
	Eiq6JrzMmlpuZDYxYrxltIy9tEBj70vx+4zYt32ImSIwXCn2hUFh7pvWmvFK9g8ngZr8q6GIRiO
	rG0YeYXnZLkJDJAh6r3SQeWakZb7VYBRIAQ/u2puKna6M7d1jLYQjY/FdhF6nx4fvCYKmU24TR/
	4rEvIRNmNEywG/Fm4RJD18tesPMqu62Xpi80hcP9HZPGRRTUbXAzPZ/Oa/0RmYmO7nXymzEPV6M
	YzV7o5c25xbzcjcQexzl20scQ0Y7RJh7rvUpWUGStW10GIsFWEP0Uw==
X-Google-Smtp-Source: AGHT+IHPn3opWPuGz4biVathI6IuKk2eNFCTG4feYuGEpgYqHsGeEkZnfVt67vF/3B+VhYi0n3xoQw==
X-Received: by 2002:a17:907:7fa6:b0:ad2:54c5:42e8 with SMTP id a640c23a62f3a-ad254c54483mr208102766b.8.1747046206673;
        Mon, 12 May 2025 03:36:46 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad22a3a1501sm475507966b.121.2025.05.12.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 03:36:46 -0700 (PDT)
Date: Mon, 12 May 2025 12:36:44 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, David Rientjes <rientjes@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com1>, Frederic Weisbecker <frederic@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Chen Yu <yu.c.chen@intel.com>, Kees Cook <kees@kernel.org>, Yu-Chun Lin <eleanor15x@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
Message-ID: <avxk2p2dr3bywzhujwnvbakjyv4gsnshssvgwj5276aojh7qbl@llhdz2e55iai>
References: <20250506183533.1917459-1-xii@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7glneb545a7qokgx"
Content-Disposition: inline
In-Reply-To: <20250506183533.1917459-1-xii@google.com>


--7glneb545a7qokgx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC/PATCH] sched: Support moving kthreads into cpuset cgroups
MIME-Version: 1.0

Hello.

On Tue, May 06, 2025 at 11:35:32AM -0700, Xi Wang <xii@google.com> wrote:
> In theory we should be able to manage kernel tasks with cpuset
> cgroups just like user tasks, would be a flexible way to limit
> interferences to real-time and other sensitive workloads.

I can see that this might be good for PF_USER_WORKER type of kernel
tasks. However, generic kernel tasks are spawned by kernel who
knows/demands which should run where and therefore they should not be
subject to cpuset restrictions. When limiting interference is
considered, there's CPU isolation for that.

The migratable kthreadd seems too coarse grained approach to me (also
when compared with CPU isolation).
I'd mostly echo Tejun's comment [1].

Regards,
Michal

[1] https://lore.kernel.org/r/aBqmmtST-_9oM9rF@slm.duckdns.org/

--7glneb545a7qokgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaCHPOQAKCRAt3Wney77B
SVYEAP0Z/JUxAkFu4aDyuiT90IBTasBvJ2EsEmMP4MGjnahpUAEA1KAPjq8QHIRv
YGcQlipcEFx4WvZFEk5JBaHodIcCvQA=
=LnfL
-----END PGP SIGNATURE-----

--7glneb545a7qokgx--

