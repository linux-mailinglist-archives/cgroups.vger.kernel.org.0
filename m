Return-Path: <cgroups+bounces-5419-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066A9BBA42
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811A81C24545
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3B1C174E;
	Mon,  4 Nov 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SppinLlP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57951BBBD7
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737332; cv=none; b=Kmcq8lq4+zsR9THvoL15wT5T3NeEDdWhFptoagUxeY5CTBM7V9DMbRGgcB+miKMZK7FeBP+GQz7PtIyJMwLkgXCW1/4uE1JEb0pcSZ745koOrpxK+6kog1huY0+JCCHiEoG5Jv4hplu+BoHjg57fD2dbI9dksfSQxkCWPe4hmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737332; c=relaxed/simple;
	bh=1IJVTOdevInuCFt0TT64VQzJrQeBcyo57p7osJy8EOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFTOlyk6aDWpWQC7q7b3R4RcUxASVveksDQGr1vSwFzH62WaAtQl3UT4JmwoPwlu9UrVVRiInPn4YpmGcTSJ/BWCshzK3EL5ZvEaKgbUotQ+w4d0VNvSP+jtoHFnQ3ztc0kmv9tP4a2SO+6HAwDrt5vIw3WRJeiULUpj3IctGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SppinLlP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e44654ae3so587411466b.1
        for <cgroups@vger.kernel.org>; Mon, 04 Nov 2024 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730737329; x=1731342129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IJVTOdevInuCFt0TT64VQzJrQeBcyo57p7osJy8EOM=;
        b=SppinLlPgyjmCh2MfqTsfW5HaAGziwj269neHwN6KD+zC93SZkd4fWQg9SFyzUiScQ
         i4DyIHpBEcEDwvdyuDVHZaiA/8lje9vusISReAXmuljOhFu+u0YXA5erRZkJDy2KN+QT
         fDq+x68uSx+Zgs+1RiiCjkRUxyd7W1BlJ7OuWZCFbnp6zsPKsZpazr6nUb5m9bu8KPpN
         Qmnxer5DYb3Au3eTHZTtgik9Mokj/89guk50+HCzxaH9hsHxwxRITgr+lCL49R5snTlJ
         9hQVW6++ijEiakI/jEDqs81BwVAz2HHgc/Tko3f+jGuGb0xkDdi6yhWBB9pk1N3laJg6
         YCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737329; x=1731342129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IJVTOdevInuCFt0TT64VQzJrQeBcyo57p7osJy8EOM=;
        b=TcZQMN9KW9LLWoA68fEq7qBPnIx4cshTzvFKE5iLITqeEKKbCAJMVGLrBpyp8WePvO
         lFHzkQrVo4NR1bFhnmTu/grhl0g8jvbLwSkoCBKrtQIXYsGpCr9bKut1IbAoTB2I2j59
         Qlay3qS/sFZwcDIkHg4nX7dyL5eK9IlfY08PfrHEJvCHNmWy16Eq92T25/QukK92DDSF
         sqfoj7u8tO8IiMeXpQ7m23AflxjlBjbOaGxDRhhrY8TrYEcEbd6sXq10qGkHSfS1hMPV
         9ty04sv9t1W44X2wFaTshdnRBl8GYlzxIa4A9ZeEBmkOpDNYeYEG7aaaSC5LtRboeuaR
         cntg==
X-Forwarded-Encrypted: i=1; AJvYcCWy+126qn/L/YBo/85AwS3CySU7Kr+iBBsS/QdUq8PlzsIfWHEYHvUAFyrzGIq8uSZcKDM224x2@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXfrnBZC6MvPxUfhaeeYgPQq7Kq16FZlGQzBRkuz28BuJq1of
	8OS6GAEK2lnDuOyMZZPIguxu0xU/kEbymRmowxZTJBRH4owYlOSz0+oH039QwsU=
X-Google-Smtp-Source: AGHT+IEIxI5kzSOoP15F+IAqnvkf4bEB0uP9CKSZmNbKww+N79Bfsg6uYpHMWT+RGeNBfeWTUF9b4A==
X-Received: by 2002:a17:907:7e8f:b0:a99:dde6:9f42 with SMTP id a640c23a62f3a-a9e50b935bcmr1467166566b.47.1730737329029;
        Mon, 04 Nov 2024 08:22:09 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16f85e8sm1618166b.84.2024.11.04.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:22:08 -0800 (PST)
Date: Mon, 4 Nov 2024 17:22:06 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Rientjes <rientjes@google.com>, willy@infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>, Sourav Panda <souravpanda@google.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable v1 2/2] mm, swap: add pages allocated for
 struct swap_cgroup to vmstat
Message-ID: <427pnhob4jjh6shhwypbsvaqgqvikgvxche2llbieagksbu2je@dwneoygkvixc>
References: <20241031224551.1736113-1-kinseyho@google.com>
 <20241031224551.1736113-3-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xsnkmnsfnfqko6pa"
Content-Disposition: inline
In-Reply-To: <20241031224551.1736113-3-kinseyho@google.com>


--xsnkmnsfnfqko6pa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kinsey.

On Thu, Oct 31, 2024 at 10:45:51PM GMT, Kinsey Ho <kinseyho@google.com> wrote:
> Export the number of pages allocated for storing struct swap_cgroup in
> vmstat using global system-wide counters.

This consumption is quite static (it only changes between swapon/swapoff
switches). The resulting value can be calculated as a linear combination
of entries in /proc/swaps already (if you know the right coefficients).

I'm not sure this warrants the new entry (or is my assumption about
static-ness wrong?)

Michal

--xsnkmnsfnfqko6pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZyj0rAAKCRAt3Wney77B
SY9LAP9/jdQUnp8MsUTsmirYbLEY5QeOWGUXcJ1lihd7wb/XxAD+M2sjppH7KZ56
DqztrEdrWYgFudgEBgGGKuXkH178EQo=
=xrK9
-----END PGP SIGNATURE-----

--xsnkmnsfnfqko6pa--

