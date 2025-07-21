Return-Path: <cgroups+bounces-8792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4228B0C3F6
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AD01635DC
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD42C374B;
	Mon, 21 Jul 2025 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PLYqASu6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C722C1594
	for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100294; cv=none; b=GcZ966viuVMwWpNe4VoZpPvUAkHvQpBXjyqCyXoD7kgG5p7NIJy+4BrVTXHTsJLLJPdrcSTa2liLQU7jG3cu4q454oC4cFZEQ9YiOVodtGGCs63lRBpfwglwJUj6ugRXMPpPQbexrLAlBvpuZ8FEIzJR+6vI151CKLWLuMavnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100294; c=relaxed/simple;
	bh=+rdXCj2J2Pqz5aEk+6OfOGdby5lnUms9RvOrl+JHN64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4aX+E3ZTx0/EYDg2wNDfduVPFJcDLtFWwSbE8kus1aOxOg+YLJmmqjG1mvXUv4TqiA5eyFHkERTCk4I8yZo02iptz7cKhh5X6+DFHdfbQZe/9vqfXTGIqsQB55d9fyZZt1DXg7xEibcty2BsWc+rM4J34izxuW6k2UX5/hLM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PLYqASu6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso8121478a12.2
        for <cgroups@vger.kernel.org>; Mon, 21 Jul 2025 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753100290; x=1753705090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl/QFiCNkc8AK3skwI2LTS+6oO25XvJO+sIDQXWVbiU=;
        b=PLYqASu6HHDNxcrChAZg9D6dw9Gb5AAbDMkjYgsVxugn+Zd+jNnkH4ZHnuU9prcW68
         SxvT8GiHgPyFM1H2JIzh4ky65HJ/RVP3hy6gNX8J3Vg3AdZDtjFzFpojnH03JedDDAk+
         gK4UZeASm5p4ONGrrUzG4BxDJ2xPuVyhGNvfHS2FmxJlPtoLLQ5inU6O7ASE20Y6zu0u
         t0sOcJB4Djon9wHTx+LaaKjdQLBBNyIV52SZB3+6HKwiE6b3harbgP3ux4f8gmeQrC/R
         bJ/qb9+8Yi/R/+3OmRULjWOFFpzMUzH4js5HaZQyAWMy3gZCEgpypDOLEZq8ZU6PGqLl
         Cguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753100290; x=1753705090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl/QFiCNkc8AK3skwI2LTS+6oO25XvJO+sIDQXWVbiU=;
        b=RIpRgol6NVyX4CN1fQETGbzIJw82O+JzUbvbczIoRbuOpbu8/oKpzcWaNGZq/vi5g/
         t3HJLRZMyr5cLeO7DJ3dKiNc5BhFa8ktahOwqWNihqDc0vgSRvjgYns8QO+W9LapXPs0
         btQv8hmFnwN8wYb5LPSzNo4qi+jJrHr0xjf8J8WbXtR88FaMkE8kqzSxE5lEzQ1JOyGf
         2iE9H3HGazSIx/uM86PlsJOUULlhVRA8L1TJLxRsiURjQAAV2lM1IbrfNQRTfwILks0G
         rtOsNiHY0ynoU0AGnocFCQwFA7tXFH/fDmckPQCqhVC3nQ7kvJZlCcB0vIChFA+e0ZDE
         D28A==
X-Gm-Message-State: AOJu0YyhBB+6WNPL+w0EHXizO1X/PiaKmWkxI9oyaxnd6MGIdwMQpesf
	izzv4vj3a/luOpbxOFhnpjDXGqv1q+xiw7+8DWuQtIepx18usiaVVVUqfPVi/fdL2Io=
X-Gm-Gg: ASbGncssE5wpcjUcYGXBb9eKoO6BJFB9+Ln+619iw2SbcNzCFTPtGgTkCthYtL2Gz04
	VEdd1GhdFQ4++vSbnQImYLgvjBo9Vloqk+nHZXujva+1X4fViCCl2xT3E0iX6rLri7qjO1admrT
	vpaY0az4pGnZ4nfS5UtK1gAlH3my8Sez2YaVJNjVGpP5QRPmQ8QWllZU+bmx8i/IUzxydHUn0lc
	nixOPr4qUNwLtUN6NMFdXfO5FNB0gLD6JZmUDFQoDquueYG6zD0dkcRbT1CiEA8ONTq0O7LcjQL
	ldoJrjueDKZAwJEkhv6DXrzQuDxjlmPMAMrgiEdLl1JauXoVmnUjIaKcPZqwUo2gLHStl0g21VO
	PdBXKQ60JQhfQpa3tyVx9fORW+4ioFEMrqha+xb/e/w==
X-Google-Smtp-Source: AGHT+IF1Ecx5FsnzkwAUqZScVQAFhtEz+YnMxK7C7MokR6HmcYD2JlE1UcndHl2/gmbTtpdO/L6BRQ==
X-Received: by 2002:a50:bb41:0:b0:612:a77e:1843 with SMTP id 4fb4d7f45d1cf-612a77e1ba2mr11636743a12.5.1753100290110;
        Mon, 21 Jul 2025 05:18:10 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f335e9sm5308452a12.17.2025.07.21.05.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:18:09 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:18:07 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Anton Khirnov <anton@khirnov.net>
Cc: cgroups@vger.kernel.org
Subject: Re: unexpected memory.low events
Message-ID: <gik2vqz5bkqj2d3cgtsewxf2ty22dbghlkjaj7ghp7trshikrh@2moxbvqgkdsn>
References: <175300294723.21445.5047177326801959331@lain.khirnov.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hkc4d3jgv7f3ha22"
Content-Disposition: inline
In-Reply-To: <175300294723.21445.5047177326801959331@lain.khirnov.net>


--hkc4d3jgv7f3ha22
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: unexpected memory.low events
MIME-Version: 1.0

Hello Anton.

On Sun, Jul 20, 2025 at 11:15:47AM +0200, Anton Khirnov <anton@khirnov.net> wrote:
> memory.low in every other cgroup is 0. I would expect that with this
> setup the anon memory in <protectedcontainer> would not be swapped out
> unless it exceeded 512M.

It depends on how much reclaimable memory is out of the protected
cgroup. Another factor is why the reclaim happens -- is it limited by
physical memory on the machine itself or is it due to memory.max on some
of the ancestors?

> However, what actually happens is:
> * the 'low' entry in memory.events under <protectedcontainer> goes up
>   during periods of high IO activity, even though according to
>   documentation this should not happen unless the low boundary is
>   overcommitted

It should not happen _usually_ but it's not ruled out.

> * the container's memory.current and memory.swap.current are 336M and
>   301M respectively, as of writing this email
> * there is a highly noticeable delay when accessing web services running
>   in this container, as their pages are loaded from swap (which is
>   precisely what I wanted to prevent)

That sounds like there's large demand for reclaim which this protection
cannot help with (also assuming all of the swapped out amount is part of
workingset for give latency, 336+301>512, so your config is actually
overcommited).

> Does this look like a problem with my understanding of the docs, or my
> configuration?

I'd suggest looking into what memory limits you have configured and what
is the reclaim target [1].

Thanks,
Michal

[1] https://lore.kernel.org/all/20200729140537.13345-2-mkoutny@suse.com/

--hkc4d3jgv7f3ha22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaH4v/QAKCRB+PQLnlNv4
CBQzAQCCRZ8pCssY7LBZge4czaD2x0aByBwZShXw/1zcuJaL+AEAlz5EuFq2XhUw
K/1DY24ABfkFEJ9TSvElGZE1vXmQpAw=
=OPK2
-----END PGP SIGNATURE-----

--hkc4d3jgv7f3ha22--

