Return-Path: <cgroups+bounces-7593-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5DEA8B543
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DC3163452
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F7235348;
	Wed, 16 Apr 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J+HjLMTG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76581AA1E0
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795564; cv=none; b=AQnEekKMt1HePWxM+vc+weW6LG7Mq/6A494E5qRlu3gOzpyNJYjGHo+tJ+OkSRbsqKLIlxyJvpJG/cTdkzdOCjiZs+j6ibotfjRZ+HOiqZG+o1vjKQsJhuI79GjMbOknd3ORPZNL6KYEET+Ln7koX9Jgv+FR7zpdPSAK1DSBclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795564; c=relaxed/simple;
	bh=3ScT62wBFyj0bxCBuOyqKPS+JD3Y2QDmSfgdrnlRSmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGPEJcBei+QGkbXCpiugel7lXsl7hjKmfH6Y6pRpT2xaGgqyXYbIIajOF3gAGKrTTkhtCYW1v1vV8rC/4fqbNJUySCd3ksgoS/k2pXuUy5AqtrHlhSScqzfhMbLBCRH1I/gsDegdW8Tid1vhv45vmoXdmGCNRi0FfVp0hyl5k3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J+HjLMTG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so53188555e9.2
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744795561; x=1745400361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ri2FPsioeyOMpww0lEYWXKz/xcfTIJFn+R/QcNtid0=;
        b=J+HjLMTGMLPutOeqwSk7RUOcEEzYwnwfUvSfwaeGtvh/QZr/CE+Y2BydrRNni4B9Cm
         ujxAlNi5idBHR/A+W7YI1SKZ/gTSSRCGWBx04/TGkVoiyB4pMZQa9Uf2VXFTMIIsCH4J
         37Ps59SeKK7I8zOHhT3I9aI31lJ+YahGq1UcXg2Pdwy1Gzx8ZKKQSV3YiEU+R4ZzFzmW
         J5pwWZaJdVdj+w2dy8+cUL3NNr13P6u8Cl7EfwNJMquKtRj1cOotf1o20gqYDR5CBebg
         xwZHzAKoaOr+kJgWBi31/DP1M0SFhGXnWcIOeN+PtRjebmxZYGZ81L3/e1mzo9bbWJ2M
         jZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744795561; x=1745400361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ri2FPsioeyOMpww0lEYWXKz/xcfTIJFn+R/QcNtid0=;
        b=hmYBDqifvjf2NVa/UUSRBYGvV4bjvFKERxxvnJcY7XLXZVggSelYJnvAKXw/obKC4q
         XI47UcE+p3BW/0SpGB+bOQCWN6hdQDtIOcdOD9+9a1QZSlFwuKQHwwYQW326Z7WULGzx
         lr2OssMMCtP1OOEPCF2rVi8e4KHOw+Tro+qNiLyGtcP/Rpn0ddRy9coeP58nyQO7qD82
         dl2aXTAvkUrZ9NzlkJ66kBl5fKqu4kGGws4ccyEq92bWj2NIy+EiwYW7+8NSeJogTXYA
         +BfLn9n/A0b9OdXzT3s8YTuVfOPh37YACo+t4sC3RMHPWnCe5/lEGF6q12frnzFwUr8D
         W1mg==
X-Forwarded-Encrypted: i=1; AJvYcCW1gcRwyurzlvJE6PwXcY1LPc9i2BSfRkda/CPBCEWKUzbpHLtKuCnIFzhNb7DrSGm0kzZWJtcf@vger.kernel.org
X-Gm-Message-State: AOJu0YzBV1a9vRvEN/mU0Kajk8exGYJS7mqVYrwIV/izOI/dBOifBufq
	sGv4iRY4NguPVWcjdqM3xPTdfjiWIU7esziwtNTGvxxoYlbsvtLrarJtCdlDQTk=
X-Gm-Gg: ASbGncvN4W+UaVTVFhq5qod3aV8iHSdHQEQiOr6574pQyESqDM24V3CYPBx8adw5MWQ
	n/9FDuH+3BmKdPCqWA5NAPujmv9pr93uYxz9MTR4MNE6f8a1gdMdV7Vw+d7+AuIY4sIJJEcAG9g
	M5lNZ91hOUh1aNKZcvOrD9uCVLcqZUyjaeKMQvXbdMXU0snd6cnxD4hYk+31BgQDXU6nmz6ETVD
	uGOb51DS+deFJX2X+X1N3uG+m9kbpikRONQ45qg2x1ddWmcXvhuUb83fU06cSyPsDHmhxkklzTl
	FnH4MDps+aynqQPiVTdI9PPBe/mW6pDglJbcEVPjsrY=
X-Google-Smtp-Source: AGHT+IG+DNt53Y1tj1r/NgZyeW/D6nAONrAJfUbDPzr4B6m4A9eSNWJlFy6wubzxu2mVoR+YMUc51A==
X-Received: by 2002:a5d:6dac:0:b0:39c:268e:ae04 with SMTP id ffacd0b85a97d-39ee5add7admr1016490f8f.0.1744795560990;
        Wed, 16 Apr 2025 02:26:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cf42sm16763741f8f.64.2025.04.16.02.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:26:00 -0700 (PDT)
Date: Wed, 16 Apr 2025 11:25:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
Message-ID: <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
References: <20250415210415.13414-1-longman@redhat.com>
 <20250415210415.13414-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3npzfkwfjuaenbx"
Content-Disposition: inline
In-Reply-To: <20250415210415.13414-2-longman@redhat.com>


--w3npzfkwfjuaenbx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
MIME-Version: 1.0

On Tue, Apr 15, 2025 at 05:04:14PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> +	/*
> +	 * Child 2 has memory.low=3D0, but some low protection is still being
> +	 * distributed down from its parent with memory.low=3D50M if cgroup2
> +	 * memory_recursiveprot mount option is enabled. So the low event
> +	 * count will be non-zero in this case.

I say: Child 2 should have zero effective low value in this test case.
Johannes says (IIUC): One cannot argue whether there is or isn't
effective low for Child 2, it depends on siblings.
(I also say that low events should only be counted for nominal low
breaches but that's not so important here.)

But together this means no value of memory.events:low is valid or
invalid in this testcase. Hence I suggested ignoring Child 2's value in
checks.

> +	 */
>  	for (i =3D 0; i < ARRAY_SIZE(children); i++) {
> -		int no_low_events_index =3D 1;
> +		int no_low_events_index =3D has_recursiveprot ? 2 : 1;
>  		long low, oom;
> =20
>  		oom =3D cg_read_key_long(children[i], "memory.events", "oom ");

But this is not what I Suggested-by: [1]

Michal

[1] https://lore.kernel.org/r/awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz=
2w2ke@xc3sv43elkz5

--w3npzfkwfjuaenbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/93nQAKCRAt3Wney77B
SVIuAP96NW0fIlvRAMGyp434RzkvtOGnIESFYbQyryMjDaf0FAD/SnK/QY73TkA1
aZVm14O+UjCgolPl/9j9t4ba0I+3fgM=
=2iXD
-----END PGP SIGNATURE-----

--w3npzfkwfjuaenbx--

