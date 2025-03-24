Return-Path: <cgroups+bounces-7222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50892A6E1DF
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 18:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E433B643F
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DDE2641C5;
	Mon, 24 Mar 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cHAvbY+K"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A62641FC
	for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838482; cv=none; b=dOJ2y2SPamvoD3ksQG63aYO15vc7eWKkZwL5IdaZh+TjGqE64egbclB4OTJrcB3OxZcARMGNjHnhDSz4x7kK0zUdIWsAVn7df5wM2FuuToWGmVKtE++8b/eJ20EyTzOSHzcXJriUVqEsHL9U8FGYeNvdoPkAdnukarS2XDpkFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838482; c=relaxed/simple;
	bh=5dGcOKqdR8f2aJ+Dor9wDx9jrRk6G6izyiZhwniZkPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO5deL8AAVC9VR+8k2HZDLNqtKFQ9M9QYpSNajtg+vNleR5/B+w25w9YdleLZVirxVHQelnQBko+zwqsMlA854pRHzX900JSqi91N2EnNERKxJy+TTlHSmwI6EKA+331DBaLttA3KszfU3QWRSoktfGm1qfXx57B8Iy6n8QOR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cHAvbY+K; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so43076135e9.0
        for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742838477; x=1743443277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dGcOKqdR8f2aJ+Dor9wDx9jrRk6G6izyiZhwniZkPk=;
        b=cHAvbY+KUbkalTdwljQHAQYB5Lo36FqRA2+mPw2t1zbJCNYErUAd3Tqha3utGj1Nv4
         HP5G5duVNEYliJh29b4rT7IQEAhTyQ6rVrfCEs2ylxEj6j1GrMq0huqaEC4IOR3T40Pq
         LXp8b0jcdSiv3rE5S1Nur1yeR5rCgtoN53w4tsxf96Dg9BmVoXRUWrc8fYO+W8tb1c1R
         EZolLYtV5Sz9Dz8hC+ac42lvM16YBrbd/6/urKhL4ckj9Jp7f4e+nwgPdCXzOPYWOMv1
         W1L5MEkZZFI93ZuDv0ax8Nr1nBzgSUeUl5nui986HiavjDQckvUU1dJnXrpRTERcnwX1
         VtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838477; x=1743443277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dGcOKqdR8f2aJ+Dor9wDx9jrRk6G6izyiZhwniZkPk=;
        b=DMh5eg7L5jr/JBcc/ZafeTuvoHyBdCYoasE55AmvbmGVpJxNGkAd4QLsI+RgGTKVL2
         MfQtfZIOTLMLtEtD7Q82fvQ28Us8eKoUIv6qaNaIY0SjmKeQTHhU/0ISygAz/g5u3UHz
         Tg7Qd9Ri8MTYvNXMYDZ8UcrjzW+BRUvgl2IcTinUxBKdMmsxSHWgaYnu11JsDVy9p+mV
         U+aXnBf68V5SvM3a2yyJS2Bc3VeAnKEiTR77qEzmBoWTYs0+KWHP6Lf8kBwIuczjh0Dk
         1Bcv++HChPCfpc5DigBgPgXyRrh51/E6JCHU88AsXknIYqLD+1m52bO8Ib50L1lV5R/t
         ScTg==
X-Forwarded-Encrypted: i=1; AJvYcCUnU3DBzJR8W6iquGO2XKzDTpuursaWhjbSa1QH6KpX1Q1tMJ/lPilZR00h38Cg06rQM6ZbpksC@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPVn5ROhSq6swPb5G1lpBPnF+P9J4UWgIF1728KIWfsVysh49
	1Pa+jadZfkAp+e5d/cZRSDtmlWwVD63RhPHfEiZCFrlM6XAPmw6ABTZPEtemAkE=
X-Gm-Gg: ASbGncsbkgfdk7L1D1tqHDFEupVK2LR/srLM/UZdQS/t4J9j0LQFRbbYH3VVofHvAl3
	a+mhX26WCiRw1La2dM6S+IWXPERDIpZF0L6HzbDJxKsM4OrRj7I+37Q3ic9FuZq7SnMjBaeC/uo
	+V9a+kVtSr7Y/iJlQ8PyMbSLngTnjsi1JoPgay0fzJnrXqTCi4kHCITVIsgPJ1OscAW83yBjdVK
	DZ2HHerQAULkoIH42We0ZfuHtDDs/S3NfNw4CaGmjW/ZYxKz/pjvO0eJBdGoK02oXXoGyfy0nq6
	muJewu8UsocxYQ8kFmdmQH6EOcW2U8qmUbqeBh9HwOujxZY=
X-Google-Smtp-Source: AGHT+IGY96hhv1Pe89mvA2qg2E5EAjuzK2ndQsFz4Semuq/cymUUVStyqHWqEpfEcK4fhjLqzJMpyw==
X-Received: by 2002:a05:600c:4693:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-43d50a3780fmr107044285e9.22.1742838477389;
        Mon, 24 Mar 2025 10:47:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39abe4971b0sm6495658f8f.26.2025.03.24.10.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:47:56 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:47:55 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4 v3] cgroup: use separate rstat api for bpf programs
Message-ID: <4akwk5uurrhqo4mb7rxijnwsgy35sotygnr5ugvp7xvwyofwn2@v6jx3qzq66ln>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2gp4crhufhfbb47"
Content-Disposition: inline
In-Reply-To: <20250319222150.71813-2-inwardvessel@gmail.com>


--t2gp4crhufhfbb47
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/4 v3] cgroup: use separate rstat api for bpf programs
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 03:21:47PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> The rstat updated/flush API functions are exported as kfuncs so bpf
> programs can make the same calls that in-kernel code can. Split these API
> functions into separate in-kernel and bpf versions. Function signatures
> remain unchanged. The kfuncs are named with the prefix "bpf_". This
> non-functional change allows for future commits which will modify the
> signature of the in-kernel API without impacting bpf call sites. The
> implementations of the kfuncs serve as adapters to the in-kernel API.

This made me look up
https://docs.kernel.org/bpf/kfuncs.html#bpf-kfunc-lifecycle-expectations

The series reworks existing kfuncs anyway, is it necessary to have the
bpf_ versions? The semantics is changed too from base+all subsystems
flush to only base flush (bpf_rstat_flush()).

I'd perhaps do the changes freely w/out taking kfuncs into account and
then add possible reconstructive patches towards the end of the series.
(I'm not unsure whether the modified btf_type_tag_percpu.c selftest
survives the latest unionization of base stats.)


Michal

--t2gp4crhufhfbb47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+GayQAKCRAt3Wney77B
Sf4aAQDjaV9fsIxeiOTJ3vG0+oTDundo09sTe/5vFK18VJVxbgEAn4OABiJDsyHA
EdNDdndGE9dhTKUhhS3l0DmtMuLdAQM=
=QYGL
-----END PGP SIGNATURE-----

--t2gp4crhufhfbb47--

