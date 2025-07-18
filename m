Return-Path: <cgroups+bounces-8763-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80929B09DB8
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C474E207D
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D7220F34;
	Fri, 18 Jul 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ayLmZxUC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F11F55F8
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826825; cv=none; b=uSsp0z5VRsrDon91EUuGdx9ASgXik/6xJzMIpT/rS0Cq8yXT0AZHbRw7GNetJCw3V43c1bhI3yP7V3S5NdPcHw6/X5NJYZnoIIsSnZCZpRF+otUajwGHTapdPOw43NaFi9wH8EU1Z4nI9ibvUG+Yk8mRMI4Y4ONMIFddkzCpvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826825; c=relaxed/simple;
	bh=dGKkJmaxhFVHM8HKQXN+ruzKyau0iJTAr3sXMaXEuLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv1GAMue/GVg0rqMqOwOfzio1bKzp+mnD+a3Rw347icLW+pNqnA6Fz6XyEeQIFGNah8Fb4gj4yeJQZjMhefQK4OOlzcJpOkhSH/W6xvlbynkZ8oMz86S2L5NBBJnCPDUdorComTFc+FCcJGK7+rAO3OiV8psSKabQkLCzxvSY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ayLmZxUC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so2880451a12.1
        for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752826821; x=1753431621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ab4gQxsYWdk9x2tiurNH/DMpPwSVpR7XnZUZ/FhW6Xk=;
        b=ayLmZxUCnph7495FpfHRz5Julx3f4QFzSnlSJwHwgCKdyt80FAp94RXJWhdmj3ev0O
         bIa23o/5fsUJ5dVLEcqMdI1xLzx3OvW7aCnD5cOYiyg2U19Apmpg1EeJGkkbFzO91UCa
         33j7s25W7RheXYPljNKyrLORs9xWl3NXxDgH0SyqQ1muLRtDQ9GWLEd4Cw+T58xKFtxK
         SNrlh3Xh+ryC69zE6p0wfcpruiOaUzRrQLG2Np2GS1bY3jjTaa/0DK175CBNJwTbudhf
         iJ4Ulm/2Gsg7unpiRXCNsVmUcYdmmB8TZfhK9hgYwe4eTNCQc2oaA+vZ8Ia67JNe977u
         XnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826821; x=1753431621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab4gQxsYWdk9x2tiurNH/DMpPwSVpR7XnZUZ/FhW6Xk=;
        b=UpFs+VkSpUO9EfhMCyU+lNz/fqpowOZf9FOR2JibwORXmBVhYeVsDZwk2Gwf8O/mWp
         6ciX/p5mx7K6uphcgjsK4nVN4n2IJM94p2ZGRCG/+bBGBUYy4qVWifxEkIfPs7vwqqzc
         Hw+I/kcPucQnpq4hTMJpOYAo+Jb3Z1YJEoK5vPSznGT5hsTkC2KJMVo/FUyPfTkWlhsR
         o71aZR0/YUaVbBVS/m821Guw3AVPXvJdgrWt4pu4hdYJAeBalZf7+mFcxKvQCLnV9JfX
         cjgNBbvI6bY+s+84WQQ9KcUBwEIogEJV5zcRUG9KA/giW4TOPbpNgtpSq88TeMIeB4T+
         5rTg==
X-Forwarded-Encrypted: i=1; AJvYcCUJWax5u84aWGOwZfm7WNs4+AQcfDMkiFNNrvS5hsLivQWhOTIgyuecy+0mbcBO/K6SgC64Loow@vger.kernel.org
X-Gm-Message-State: AOJu0YwflPp16MxBvkm/SViCp4VN1c0qSqro53Fxr3JIl8qtvEc4nYls
	3V7vDApK6LKMoS6ZNFCNNQXwvEtvL2mPN6Mhkj7otZSwMmhL3/CzqgqmrcK2ooP3CSk=
X-Gm-Gg: ASbGncsn9Q5s9Dy2Gi8JzMKCMYr3rvJiMjndq8c/vlzO+TNxkbvwYQVlkK7dI0p5zcC
	vhwBUiyeadDThoQ2MsnKcS2EMAMtEVQtS6Ydg2hyOA9ABXEX0DFRC4gPIi0ghxp8zAt2IHjSV56
	gUuJ1CoI4Ljy7Qz5vXdvfE9Ed/ktHY+F78z5/5KCzgH8VckazUymvBvlR4pvoxSzLFSLMCXwv8V
	6QI6dhJAWlzdsKg4DkiJqGS9W2ODoPIfNatlOhTMY8TOWHkpSCUZPoVurE4syJgFOvS9owCJcph
	fiatI+oKu6ab0FJMng/KtXz9bKLERqvK6/aXPU5ghX+6FKZ7cJu6v0uFpNVo7mI8ziaNzYY69M/
	Io4gQSim3kdQ0uc25M27+n5Mk+M4/nIzBT/fmoyieZQ==
X-Google-Smtp-Source: AGHT+IFlFmeWi6E0SMdOYun34OYAUB6SXhFoP9bJcXLK1nm2xdgsaBjOm4t+cnMR1jx+yUkBsFJYSA==
X-Received: by 2002:a05:6402:268c:b0:609:aa85:8d78 with SMTP id 4fb4d7f45d1cf-61285923522mr8734807a12.8.1752826821337;
        Fri, 18 Jul 2025 01:20:21 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f07e0fsm635217a12.13.2025.07.18.01.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:20:20 -0700 (PDT)
Date: Fri, 18 Jul 2025 10:20:18 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, 
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
Message-ID: <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jv5tpzpajmrvvmyk"
Content-Disposition: inline
In-Reply-To: <aHktSgmh-9dyB7bz@slm.duckdns.org>


--jv5tpzpajmrvvmyk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
MIME-Version: 1.0

On Thu, Jul 17, 2025 at 07:05:14AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I wonder what hierarchical summing would look like for this.

So do I.
Thus I meant to expose this only in a *.local file not the hierarchical
one.

But I realize it should [1] match cpu.stat[.local]:thottled_usec
since they're similar quantities in principle.
- cpu.stat:thottled_usec
  - sums the time the cgroup's quota was in effect
  - not hierarchical (:-/)
- cpu.stat.local:thottled_usec
  - not hierarchical
  - sums the time cgroup's or ancestor's quota was in effect
    -> IIUC this is what's the motivation of the original patch

HTH,
Michal

[1] I'd find it more logical if
cpu.stat:thottled_usec were cpu.stat.local:thottling_usec and
cpu.stat.local:thottled_usec were cpu.stat.local:throttled_usec.
Only to illustrate my understanding of hierarchy in cpu.stat, it doesn't
matter since it's what it is now.

--jv5tpzpajmrvvmyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHoDwAAKCRB+PQLnlNv4
CBlXAQCByFJfBP7Jk7Z1s3RPv9V0QeD7jkoLucvvfVRWjUYuhgEA4pHMWxkdHUIl
LfzPAnEZM/k+NpkUWf+uTYbOtaMqcAE=
=lUcY
-----END PGP SIGNATURE-----

--jv5tpzpajmrvvmyk--

