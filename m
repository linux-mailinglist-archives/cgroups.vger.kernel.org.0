Return-Path: <cgroups+bounces-6489-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB7A2F356
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 17:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3B2188039A
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED992580ED;
	Mon, 10 Feb 2025 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V94ddMKC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1E2580D6
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204662; cv=none; b=rolb5ag7ElYYuJ5R7AYj94yhRsGaAsdpRD5OgLstvi/Id5kxjDMKgDocNHu4D5Egw2eBY2dmUJPqN82yVFUG1ObXPyeW3i6H0BzE5nyTxqPuzhf35q6fToKgnRWhtebx2UzzUtzoaoGndMKASqGZSk9mN+8hddSDBDk6XEEGQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204662; c=relaxed/simple;
	bh=x90YashPsaPmJstRQwXxOQAPROyvVRHp1IfGEbjo984=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4UDgYWM3tqffpPnB4B7roEaQw5JZomqmouXzLcZiMlgvZAjPEQZXo8w65I8i0thQhs8ty6ZR4K2pkLzWi933cuDultbikH8HzRRw5zvWwXmM+Avj55RG5W1oI8/Z+ULJTEFOkBDEX0ro11Fi89XsiBqwaY8WfNDByyfixfm5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V94ddMKC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7d58aa674so62753066b.0
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 08:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739204659; x=1739809459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x90YashPsaPmJstRQwXxOQAPROyvVRHp1IfGEbjo984=;
        b=V94ddMKC3dsi4o1mxhReyMchHwJBUtMpCgKl22suxuaTInCX8dwcq3CP1sU1rUJTGt
         VQhD4rySZo76TjB/S0D2BklAazjF6ShXhkiEPjM8CTnnc2n0IO1atKl+qzzV2MtXIJXO
         mAX+/zM/c7CGmHitW4N1bYvGeLMbiHwFzd7EcFo+8ua9RHr1/C5Zv+YwyrVpn8NgrBic
         0tm0ssg13Vfs7yzX2+Qu+wiAm135e6pgPC4PrxbJeetbWfGw97bJWbDXQDZbteU3NDmc
         IgPm3ssDl2YBUe+RnX3BhKqbdCLho0cu/Scd3mho7dqe7I0/0kbBGW0OiftWiU7xja3L
         tMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204659; x=1739809459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x90YashPsaPmJstRQwXxOQAPROyvVRHp1IfGEbjo984=;
        b=dsOzjhyl9ME6eZW0yCTX3BZYYZnXsNkzBQEt03T4Uz8/w6d8bmpSww124kGzdu+khQ
         2Rszn3Pe5n0oW+7WtD+E8oDaz59++iBAmBM3opkeuwmWrOZWChy0zX3dFms4xx/Kt1Hn
         qY8Q9bjNabAdcmdK/6z7iYWXJgRI7VEi1zUwAuxnoVx0fPUyrIQiOIoNahcYpWbHCi87
         4wklScKkoXZnnqo2opDiCXPNUOf5VydkCZ+HW7U70OYpbB3dJXznQ+kBGaoLnjb/BRCd
         cQZ7bMnPs6Y7sMLwUhX7rHY3fGZW2sZ5/55cXCjGk+NnOmBYFe03phQ7shtbOs37FH3k
         TI2w==
X-Forwarded-Encrypted: i=1; AJvYcCWnR90cmwEPijyZ70luGAu6cgwW6e5aCfAtEftSa0owW5u5NjjEQ+hu4q+FilCLDbtPSt7lo9MI@vger.kernel.org
X-Gm-Message-State: AOJu0YxG51JSsVuoHTk54lNV/0u22yy20y59rABn6ZjSIDpgGYP0nvWa
	ibZAe+T8G37zYa68v94YFLHMewAPxLxNpoXugY3wErpdXVC1YZZT2qu3vNkHJ6E=
X-Gm-Gg: ASbGncu3pjq62QfgMeHWODvCSJWd24VsToPVZpalaTEAAH1LCl86QZJFTiSlRFD4Uv9
	VQZFpfUEmLpftUVywx9aT7PGbhFuxAsZOfqlFjyt/OVYMxBA66lN38YHRQyzN3LSqU0NiEJxGdx
	Pcy2pNn9PSwYQuO/Ez8A2f63bWkbYB5rgG7aAMtNPwHIsC3K6LqIHl42tBYWPXNmmWJUkmz7xF/
	eog3ADnAW+NDjdhhTXDezNxtOYXHEKc1EllKK6UmjYW4ye57fb1BeZNhDFjeP1U+mhqVRE5OSXx
	FWtiKgUpRG4HeAxiAg==
X-Google-Smtp-Source: AGHT+IEXW9wG25rAqoM0JOgADtS7LivWyhuiuGf3G6h6/6tuV3xZIWYrMzqsVh4jYjIlRAbthiHmtw==
X-Received: by 2002:a17:907:7f03:b0:ab7:5cc9:66fc with SMTP id a640c23a62f3a-ab789c6d927mr1500100966b.50.1739204659076;
        Mon, 10 Feb 2025 08:24:19 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf9f6c1d6sm8012911a12.65.2025.02.10.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:24:18 -0800 (PST)
Date: Mon, 10 Feb 2025 17:24:17 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>, 
	"T.J. Mercier" <tjmercier@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>

Hello.

On Thu, Feb 06, 2025 at 11:09:05AM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> Oh I totally forgot about your series. In my use-case, it is not about
> dynamically knowning how much they can expand and adjust themselves but
> rather knowing statically upfront what resources they have been given.

From the memcg PoV, the effective value doesn't tell how much they were
given (because of sharing).

> More concretely, these are workloads which used to completely occupy a
> single machine, though within containers but without limits. These
> workloads used to look at machine level metrics at startup on how much
> resources are available.

I've been there but haven't found convincing mapping of global to memcg
limits.

The issue is that such a value won't guarantee no OOM when below because
it can be (generally) effectively shared.

(Alas, apps typically don't express their memory needs in units of
PSI. So it boils down to a system wide monitor like systemd-oomd and
cooperation with it.)

> Now these workloads are being moved to multi-tenant environment but
> still the machine is partitioned statically between the workloads. So,
> these workloads need to know upfront how much resources are allocated to
> them upfront and the way the cgroup hierarchy is setup, that information
> is a bit above the tree.

FTR, e.g. in systemd setups, this can be partially overcome by exposed
EffectiveMemoryMax= (the service manager who configures the resources
also can do the ancestry traversal).
kubernetes has downward API where generic resource info is shared into
containers and I recall that lxcfs could mangle procfs
memory info wrt memory limits for legacy apps.


As I think about it, the cgroupns (in)visibility should be resolved by
assigning the proper limit to namespace's root group memory.max (read
only for contained user) and the traversal...


On Thu, Feb 06, 2025 at 11:37:31AM -0800, "T.J. Mercier" <tjmercier@google.com> wrote:
> but having a single file to read instead of walking up the
> tree with multiple reads to calculate an effective limit would be
> nice.

...in kernel is nice but possible performance gain isn't worth hiding
the shareability of the effective limit.


So I wonder what is the current PoV of more MM people...

Michal

