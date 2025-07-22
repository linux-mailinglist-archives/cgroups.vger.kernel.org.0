Return-Path: <cgroups+bounces-8834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36921B0D882
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 13:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA631C23DDB
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FDD289811;
	Tue, 22 Jul 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ri23a2gE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0823C4F6
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184826; cv=none; b=hw3obgsNxeThfzt9fNHUd5aAFvFJJrSqwynRA06xCt2ZBHAJitJHiscRc55Djz8alU9X1y/7OicbEdCCYVb+jzwC6ki7ICf00bCPEeIBqQhqvt57Nguz9+vlCi0tNzT/y+/YQ6iUMHPBbNLaw0sjXUhd6ba1KWXgDOq9UvIrnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184826; c=relaxed/simple;
	bh=k32B28Z4jA3CrwK8vHPRe8YQ8xcqplXm+OBYnSwWT8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3WdeFOBpqPJ3LrG+Z/s+A5lukWq+YsrCMOP62U0w6cMUyZoRhhytqopmaTqA7wbv+2t6hG3thsiH7v8GF9SZLZunOE4RlJyvF/NnImXDPuvcuJay/5BgAK6X6SXW+ZnSkq/fgjghc0HeTFP9bsPjtFXRrwlQEbv8tBBzcrlxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ri23a2gE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so11351665a12.0
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753184823; x=1753789623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k32B28Z4jA3CrwK8vHPRe8YQ8xcqplXm+OBYnSwWT8c=;
        b=Ri23a2gEsN7a4PRAVYnhBEzvfDdaPacPHpikoEJ4FG+BWPDbNBTUVlaZEpL2fUIdQS
         6zggDB7N8boKTwK04R6RHhJ1q92NRvGAa0eGDTzIwEmCn8LRfuFmG2bzJPprXPow2SNA
         qeGj8aSZV8QehLt4OFORBdizkTIkccwtU4pSh7z2NnZS1S0jXckOgGQ2zs0Za9GsI4O9
         Ar+FTI8X/9/R1EWvYhYWPVME9iBZcptTbOo/7KaRNiaU6lv8fhZrG+pobIxG0YknXbbX
         ksf+0oZFZ4hvZ0R2aZ6vR/QPRV0oCONYgfrN3lODfFvS5apDC1XznZKV7ijaGeiBj9Bw
         V1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184823; x=1753789623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k32B28Z4jA3CrwK8vHPRe8YQ8xcqplXm+OBYnSwWT8c=;
        b=ZT+GypMrEAW+d1pcOjhieiqhVsXiD7zN56UA5TThPg2d7CVfltqou3r8AFGZyUwdqK
         Aefomr4CcQ0TQshzOKoXaGxxy+vyEtt8piex8ZH6j832hRSjNplm8g/MZSVFbJPQ69uF
         wtCeEUPGGs9LJOmotinpCGuqgJu4zSCRCnmG5KqBsUYlcShhgBxD1Aq3XqxSH2jCOJhd
         GJNCNSCRkq2UeSedn0J+Ag6N+9UhNv6TJZcc85aBAXEDrMrwxyXWHCiK+1sFw4+Z7F/E
         71AX6VECbF3r0SpAfBQuVnOhc0UkpbdV/F5bZo/eBEvhsVDRPbvfOYmK7/c3AB52c1gr
         xJHg==
X-Gm-Message-State: AOJu0YyDlI5kkNJzBcUFIRpa5F8XmReiarV1Om+bznTwQtFsWfNsgdtP
	YVI1sCEL66HrdY6LYwuDO6KrisfwdqWJwjkzDqpdKpWKIx+gOumkidI8C8UBxStsid0AgZB49MF
	/q0cH
X-Gm-Gg: ASbGncv6vGi1EmeqHdVMojrYJ1oXBeDVcpxHfdE8yUWu5893i5sJTkX9GW9Brn2mNTz
	uCIbVDLZcL+Yiy5xschSDAm1Se+3j3St/F6bk92i85uQMGoJsBF3w7woVT1v2aDfB//hTzmW1tY
	27NJ3qvWZrqStfCE5HByHNH3DGooUjIwAm29y/721XPJHrRXjcXa9RqQ5qauuDglJsZToE0St1h
	Vo7wvnBKgsyBPRRAJI0f9Ar2bD/uBu3FqSuNKm0MYxCOCaMRRbmNo+BBpC45/g4v90JaowStHoW
	H29AoXi6/wqQ72FMvZVyr4Bo81Spk+GW5FJIFYoa/RhmD9TwEKQ5L4lfnhQTakPQtu+lsO+ijKT
	2W8wuPjKkhmrulh+6/g2nM+zHfpbTAHBEaQEk6IR2xw==
X-Google-Smtp-Source: AGHT+IGMULcPob4diBN56LbVWntIXm1x/hqFQBzN+4BB9SHqv10KImvBA+Z3p9Hyp509Hte9fm2+jA==
X-Received: by 2002:a17:906:4786:b0:ad8:adf3:7d6d with SMTP id a640c23a62f3a-af153a359d1mr301690566b.21.1753184822619;
        Tue, 22 Jul 2025 04:47:02 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79557fsm847480166b.10.2025.07.22.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:47:02 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:47:00 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Anton Khirnov <anton@khirnov.net>
Cc: cgroups@vger.kernel.org
Subject: Re: unexpected memory.low events
Message-ID: <nxcveyfssgmnap4xemebk26l577cq65hynibymtn4ofdtyubyx@kd2dzvqw2tkm>
References: <175300294723.21445.5047177326801959331@lain.khirnov.net>
 <gik2vqz5bkqj2d3cgtsewxf2ty22dbghlkjaj7ghp7trshikrh@2moxbvqgkdsn>
 <175317626678.21445.13079906521329219727@lain.khirnov.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ushg4jvmoglquulu"
Content-Disposition: inline
In-Reply-To: <175317626678.21445.13079906521329219727@lain.khirnov.net>


--ushg4jvmoglquulu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: unexpected memory.low events
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 11:24:26AM +0200, Anton Khirnov <anton@khirnov.net>=
 wrote:
> I am not touching memory.max in any cgroup, it is left at 'max'
> everywhere. The events (which I get by polling memory.events) always
> seem to be triggered by high IO activity - e.g. every container
> rechecks the checksums of all system files at midnight, etc.

Thanks, so it seems there really is competition over your machine's
memory, apparently for single-use page cache.

=20
> So if I'm understanding it right, memory.current also includes page
> cache, correct? And then if I'm to achieve effective protection, I
> either need to account for all files that the container will read, or
> protect individual processes within the container?

That's right, page cache counts towards cgroup's memory.current
(breakdown is in the right fields of memory.stat). If your container
runs both the latency sensitive and IO streaming job, the protection is
sort of blind and applies to both (and especially if there IO is intense
in allocating whereas the anon app is idle, you'd observe this).

So you could form a subtree structure to separate those and apply
protection only to the anon memory processes...

> Or is there a way to give a higher weight to page cache during reclaim
> on a per-cgroup basis? Apparently swappiness can not longer be
> configured per-cgroup in v2.

=2E..or you may add restriction with memory.swap.max which should push the
reclaim the page cache side of LRUs.

HTH,
Michal

--ushg4jvmoglquulu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaH96MQAKCRB+PQLnlNv4
CJ0iAP9iXUNLnh2j7IFL9shEXAQSM7LxSuaJ2aA9eTBuBCa3VQEAgRImQn55vlhW
O9guVKN8G6abeXTF/BIliJCQPEUafww=
=gnAn
-----END PGP SIGNATURE-----

--ushg4jvmoglquulu--

