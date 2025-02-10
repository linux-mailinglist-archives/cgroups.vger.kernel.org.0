Return-Path: <cgroups+bounces-6494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E6A2FDC7
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 23:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947D4168388
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F705253F0A;
	Mon, 10 Feb 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="BRvr/uDR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E271C2DA2
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227963; cv=none; b=LhtcZfC5FkoTRw1H+pSZdm599ZEnN4r8x5NmqWVkJZqEd4RPseOh3kjEqv8U66txikYmy6udE/yrRxm7/w7kVw5WhNXi9cARU/S34Jb80tLaDQYdA0zP/dPtDEewBZUnBDA+QyJKooaYlBHa+Rs/FgNp0zjOrueIOPSAbIq4RDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227963; c=relaxed/simple;
	bh=u1A7hUp218r3DTCis5M2h9NuD/7RxkXbim97uOWF8B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8QP0ddTxZ+bLnArSw3KXXKWGMU24pDu88Ntr2zaBcVqGRQIWgl6CaciQ5Cb47RTk+xd2oH1H76i3rB8AC/GcvVciFJB4Nw8oifGsNR+wKS0wKsa+Vb0h232XBT7rTiBlspXu5EcT6zwqOQ0pLOToSU3TfhIpN+HyK3j6NFul6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=BRvr/uDR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e454a513a6so18924126d6.3
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 14:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1739227959; x=1739832759; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hIqV3tfLe7RjPFG0CQCvGtroDIm7scu+4kUGANh/xuo=;
        b=BRvr/uDRHkkuRpDYPsq9md3vA0jBBZqwpflEG1uNMsL0aNuxZqy2WhXqQgFXSqR4HL
         n0vPRiLiLNuTbcxGvM+yomTx/pE+E0KGeRO1COvH02BV2nS4yPiUpx4TRf0SAnieBRAo
         9mcLtB8JUvFYZ1sshY99gGDKl6xEaV+rb2EksyPIILP5ScYhAe3tiX5syW8X3qPU3Yia
         v8fndVpt0S9HxolQgiy0CZEt6fuYcxfFyilqZVswhXSmuTuvoSS/TR6nfVEDFR/zm8eA
         U5Kxilw6KW7SOHPUOyEwZnvVWZx6Gqm7FNn2RA2EV4Q9ZJxAXKBJlbVPqveqnRbSQCcg
         N7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227959; x=1739832759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIqV3tfLe7RjPFG0CQCvGtroDIm7scu+4kUGANh/xuo=;
        b=AFyfOEVDRALubdDa6Eew/SkroXDE0IvPkstuP2V6bt41asfQ1LplR30ciz6GQfZZ3f
         sR+nXPGchBS6Duqv3WBOxFwPcSdYvNNF6FUNo/dIEASelqwpQNyfADA3wvl74OlrphFn
         F3Zsq2YW8nHbX6nt6TCdiwTPGOJvcYH2L8mbnZeIokuqk1+mWxGVxmZEp0YbE4AQ6PXN
         MeFHsce3qlnPxa90IliM2bRbvRP1gFmAjUH133Ts8IdvQI7pudWFlk+SibhAe8DHw0Y+
         hT3TzxAfH89NxAQJhnIvEsTJe2RUpzyEJLuKEiSFTTr5iqtj+FlMbdhuVQJVO+F5bNq+
         J75A==
X-Forwarded-Encrypted: i=1; AJvYcCWM5xPOQ7QfSvHIWDnFektQ5kAHeMYpV1pBsZhVw2O3TCBbkjVMVI0gAcYs3pwKFSdPta5TFg9x@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvZiJSGGFWqaOmPSS6Kb8V55ZIUi547UGTHp65ALZpelkCSSq
	NtWfd4q0O4wdZFlL8B6nY/zjA/tG/ZX7lhQYcJZOXSKIWEzPB/UTjs1ZPloySzY=
X-Gm-Gg: ASbGncs6vB6tOD4y2QlJJZsHk3YQ2A6zpTjchPl+sAHRZ/T7fHZkgmrlbvzczCV47QA
	w7khbSExMyVzn6DAhaF4bo7jmAoNgVcMEOyNQxMYc9LvO5pxsYUD20t2inBigVd04HtIjh6nx8U
	piqMVwM+cdnQ1cjWNih+DpXJWDVg4Qx298AJbdsAyzw8b8hb6Bm2KGDfdwDqp2KDUQt8KDUREq0
	iVlO8IIZBscVokAx9KdRXSkpw7wNFPf8zuUAyGfVlct4ufM3lbtBpsRAn3gJs9ymE96w8EuyqkN
	PwaHTe5XO+PFvA==
X-Google-Smtp-Source: AGHT+IFCCtSpTxwzZJhFgQbTnEw4Hb6IM3CNmfFsUhwUhEqAD5ltagXJM+qe8uUcXCgdyfJayAr3pQ==
X-Received: by 2002:a05:6214:1d0d:b0:6d8:9a85:5b44 with SMTP id 6a1803df08f44-6e4456c11ddmr220765156d6.29.1739227958757;
        Mon, 10 Feb 2025 14:52:38 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e451e423cdsm32325906d6.125.2025.02.10.14.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:52:38 -0800 (PST)
Date: Mon, 10 Feb 2025 17:52:34 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	"T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <20250210225234.GB2484@cmpxchg.org>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>

On Mon, Feb 10, 2025 at 05:24:17PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Thu, Feb 06, 2025 at 11:09:05AM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > Oh I totally forgot about your series. In my use-case, it is not about
> > dynamically knowning how much they can expand and adjust themselves but
> > rather knowing statically upfront what resources they have been given.
> 
> From the memcg PoV, the effective value doesn't tell how much they were
> given (because of sharing).

It's definitely true that if you have an ancestral limit for several
otherwise unlimited siblings, then interpreting this number as "this
is how much memory I have available" will be completely misleading.

I would also say that sharing a limit with several siblings requires a
certain degree of awareness and cooperation between them. From that
POV, IMO it would be fine to provide a metric with contextual caveats.

The problem is, what do we do with canned, unaware, maybe untrusted
applications? And they don't necessarily know which they are.

It depends heavily on the judgement of the administrator of any given
deployment. Some workloads might be completely untrusted and hard
limited. Another deployment might consider the same workload
reasonably predictable that it's configured only with a failsafe max
limit that is much higher than where the workload is *expected* to
operate. The allotment might happen altogether with min/low
protections and no max limit. Or there could be a combination of
protection slightly below and a limit slightly above the expected
workload size.

It seems basically impossible to write portable code against this
without knowing the intent of the person setting it up.

But how do we communicate intent down to the container? The two broad
options are implicitly or explicitly:

a) Provide a cgroup file that automatically derives intended target
   size from how min/low/high/max are set up.

   Right now those can be set up super loosely depending on what the
   administrator thinks about the application. In order for this to
   work, we'd likely have to define an idiomatic way of configuring
   the controller. E.g. if you set max by itself, we assume this is
   the target size. If you set low, with or without max, then low is
   the target size. Or if you set both, target is in between.

   I'm not completely convinced this is workable. It might require
   settings beyond what's actually needed for the safe containment of
   the workload, which carries the risk of excluding something useful.
   I don't mean enforced configuration rules, but rather the case
   where a configuration is reasonable and effective given the
   workload and environment, but now the target file shows nonsense.

b) Provide a cgroup file that is freely configurable by the
   administrator with the target size of the container.

   This has obvious drawbacks as well. What's the default value? Also,
   a lot of setups are dead simple: set a hard limit and expect the
   workload to adhere to that, period. Nobody is going to reliably set
   another cgroup file that a workload may or may not consume.

The third option is to wash our hands of all of this, provide the
static hierarchy settings to the leaves (like this patch, plus do it
for the other knobs as well) and let userspace figure it out.

Thoughts?

