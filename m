Return-Path: <cgroups+bounces-8552-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2678ADC66A
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 11:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F161898E4D
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784A29188C;
	Tue, 17 Jun 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gEJANKM7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA92951D7
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152625; cv=none; b=PCEX1N9HQmul6W5eJuWPYuvf4dOv+TvgWafzc4qxKmPDNj/l+D2RFaXlzr1CNypcVjKdczLMz5wb24PjNmHVgSXh8/dakYHlPrzqu1sN5n0TptmP+u+cjrpAjiRvu/In7S4lrauIjyhOWkNnQVKMKUA7xHnN+sdCZXPSAXwC7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152625; c=relaxed/simple;
	bh=HfuUqmD+8hRychMyqs4FAw+9cfKLzYZB1tT/S12Ulwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMYBUtRTDs+xh/P/v0F64/dEYovx5vuKawBEbX7BjALMzOhsSD3IhwWahP2pMb01RP7Xm86lxi8KP5QFanebc9tywQxrCwjIUIwHc8jEplNJ8e0Qf7s3CQlt00yf6UzLl31gTuF96/ht6qq9hKTqOuMS46D6g5KMFOzR1T7mJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gEJANKM7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so3067343f8f.1
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750152622; x=1750757422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfuUqmD+8hRychMyqs4FAw+9cfKLzYZB1tT/S12Ulwg=;
        b=gEJANKM7hKjGbEGRdxLSqHdSsDnvO6jpX7F2uTnhzIQSMNbC8SmkmRLeVgzcfz1gqX
         ubbwxMlebElQ6MneRDjiwjH6EPPtNAK9aioBjPiBV9CdTeLA58NahcWng26+2Zq/Uopp
         GFk2TedBE8MC3+bChRDj4w8ytfz/D484hguC+/GfTPBJwM9tDkrwm6ytJyH55519g+15
         V/cNizIVX1KerkBirCF7qRv3HDTx6E87zH0glO/3xbsYzIwehCPETBR+imyVzBzJbG2S
         71lOJdGMnhWXcPALNICjT/4mIDV6ohdtRLlz3r5xI39HwGmiDdldktS67EPZ4Bju3Q8+
         boyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152622; x=1750757422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfuUqmD+8hRychMyqs4FAw+9cfKLzYZB1tT/S12Ulwg=;
        b=BGsRPtx+EcMm0tsmyTYuvH4LLG7v2IWWc9BB0Sd1kxpuJcyIa/IvM+gnszIqJtfh8A
         RjUo9Ty9lvmdFhtfzRGqbIYLC8A464XH+OAKYfqN97pjUQZS9B2yE58jNVJrbOgav3s4
         kmBHfrUHxYl78+Y0V2/f38ZjYJKNKlhYtb3YABwAXXM7kPFy9kGdYpJa9cYYzYuHHeZT
         ueZklRUM8t3exhs5LpUIA8SxiNtfnF25LQsrwWrqxfRtK68CCS4blG5WU3Qsq4mdJWCX
         ow46fKhh8Uq3MkhtaVYBAq9TJfr+M26F5EBC51mViZX1hjA2BDg7WQUFbiRywHZIVtjv
         ibhw==
X-Forwarded-Encrypted: i=1; AJvYcCXiZgbxFqOR7XzzL8jhXIkEi8wHRejRGr8l1S6Ct2lCaghMfETfrI/kgFQKUiUpOK+Kb1mB7O3F@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpi8RMtxJG4SiTuYf4fhyxLK2Mu2pPIykHwBHsw1H8zst02Qn
	esF1ijW+hOHyPG5tiTvk1H2Sf7J0p09EMXEYFlGfQhrrIQyYS79MTnMFnpd8MHmZdaE=
X-Gm-Gg: ASbGncsWu4Eo52fi+LXmTTrMUZTzxHYUQWLFTIj22nN0Pwt0A8o0RX0nM3INXPWLojm
	+HeH8n0/7pGcTA70HqGQbI/6dRlbHTl3mRW2eD9IHmojw0WeP4+EC72Jwn0rwIUELr6Rkk9tdsi
	5Ki7WJi6Er7n5YiggRPrC3VbflFMD16JXbQOc4QN5rIlKiOrb+MWSoUs4uDGhkWvYv+5MFi0qQf
	4RqaVSIgrlksf8e7xERu7TbW1FX/poPjXOY7mp36zzuOI5Ha6ro6zYhDXkmiY+RPBDhR/c55Y4p
	vKIzTuCkqwLTBRM+nMluCCJdmhqEPRaE65M7nr1buAbPdla0+bYFxgUKyodNvUPvEqJRtesEosI
	=
X-Google-Smtp-Source: AGHT+IHSxdx77Y/6piDqFDE4kXjRy2Rd1MG8l4DBGj+2ZCwsClRdIWxnpk7JW9DxCB2MVEmaflCBSQ==
X-Received: by 2002:a5d:5847:0:b0:3a4:cfbf:51a0 with SMTP id ffacd0b85a97d-3a57237ca69mr10145241f8f.21.1750152621643;
        Tue, 17 Jun 2025 02:30:21 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a800d9sm13275459f8f.45.2025.06.17.02.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:30:21 -0700 (PDT)
Date: Tue, 17 Jun 2025 11:30:19 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, peterz@infradead.org, 
	akpm@linux-foundation.org, mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	corbet@lwn.net, mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com, libo.chen@oracle.com, 
	kprateek.nayak@amd.com, vineethr@linux.ibm.com, venkat88@linux.ibm.com, ayushjai@amd.com, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
Message-ID: <h4chrmiscs66vwl4icda2emof4pbhqabpkklpql2azc5iujilm@o2ttlcanwztc>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <uuhyie7udxyvbdpccwi7dl5cy26ygkkuxjixpl247u5nqwpcqm@5whxlt5ddswo>
 <a8314889-f036-49ff-9cda-01367ddccf51@intel.com>
 <fpa42ohp54ewxxymaclnmiafdlfs7lbddnqhtv7haksdd5jq6z@mb6jxk3pl2m2>
 <djkzirwswrvhuuloyitnhxcm3sh7ebk6i22tvq2zzm4cb6pl45@t64jvtpl3ys6>
 <c6bfa201-ed88-47df-9402-ead65d7be475@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q522php5dxz4ohq7"
Content-Disposition: inline
In-Reply-To: <c6bfa201-ed88-47df-9402-ead65d7be475@intel.com>


--q522php5dxz4ohq7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
MIME-Version: 1.0

On Tue, Jun 03, 2025 at 10:46:06PM +0800, "Chen, Yu C" <yu.c.chen@intel.com=
> wrote:
> My understanding is that the "misplaced" container is not strictly tied
> to set_mempolicy or cpuset configuration, but is mainly caused by the
> scheduler's generic load balancer.

You are convincing me with this that, cpu.stat fits the concept better.
Doesn't that sound like that to you?

> Regarding the threaded subtrees mode, I was previously unfamiliar with
> it and have been trying to understand it better.

No problem.

> If I understand correctly, if threads within a single process are
> placed in different cgroups via cpuset, we might need to scan
> /proc/<PID>/sched to collect NUMA task migration/swap statistics.

The premise of your series was that you didn't want to do that :-)

> I agree with your prior point that NUMA balancing task activity is not
> directly
> associated with either the Memory controller or the CPU controller. Altho=
ugh
> showing this data in cpu.stat might seem more appropriate, we expose it in
> memory.stat due to the following trade-offs(or as an exception for
> NUMA balancing):
>=20
> 1.It aligns with existing NUMA-related metrics already present in
> memory.stat.

That one I'd buy into. OTOH, I'd hope this could be overcome with
documentation.

> 2.It simplifies code implementation.

I'd say that only applies when accepting memory.stat as the better
place. I think the appropriately matching API should be picked first and
implementation is only secondary to that.
=46rom your reasoning above, I think that the concept is closer to be in
cpu.stat =C2=AF\_(=E3=83=84)_/=C2=AF

Michal

--q522php5dxz4ohq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFE1qQAKCRB+PQLnlNv4
CAvDAQClJdOJ0v+nc22UzxOE8RNWod98jZVrUDcK730qHKFJJwEA18yLv+cZIXXl
mdhsA08UxzTGxv2zWwOY5iIzS+UDGQc=
=CM6f
-----END PGP SIGNATURE-----

--q522php5dxz4ohq7--

