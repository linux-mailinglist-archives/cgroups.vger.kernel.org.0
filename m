Return-Path: <cgroups+bounces-7133-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F00A6746F
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE14189F336
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275820CCD0;
	Tue, 18 Mar 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OSzCLQTx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4811F4E37
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302767; cv=none; b=gN+CtBatQhWK5coZPz+NjxRXaNd+8N38Zf907RwZBm+5HcXcK9OV4JV8L+moR6HkoYjF4STKAncgn2Lksxl4vAVYKyRAM4rcvSUYICQH4GiaGWskbd5gsYxqd837djzI6kEQwnvbZP5Z+hZMz3Cy99WzIQVgLlSQKILvqrGIl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302767; c=relaxed/simple;
	bh=gljv3y7R/xNGG5r30nhLE2gjmI4y3A5An4CROnDPlJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPU7COBsORrBiTixHEs+J5X0BgX/IgNb18mQRN+qHXaGehzHuKa5S7+CXK0Y3I2DQAKlB4vUmbvKfiMnelgRiQYi9sMO6tpgQiYScmBPsZjxsqVqFLcACYxKnRdPMFjb5m3jYuyLRA+7f8gXIw0Jlx1d0gqCaRC15RuNVFb0jr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OSzCLQTx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so23944905e9.2
        for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742302760; x=1742907560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2rOvWhbbaasJpoVbBB9qwUHxj3E8kjbQWmEpFoMuV4=;
        b=OSzCLQTxG4qZW2/AIyNuDStTCfvZI8tNY+YThs8TFEWH2hKugi/1fjcb9jyHF2pSTW
         x31GhohaXvd8YTwhFGfVilrLyLSROAWQIg+XnD1qme0o332hwKHTJ8gJk6GolnXCLY77
         gizCyAfxXeL6HAdL83HS1MLO/th6Py7Sl2+Erty40x6a9xvC1Xpphu5TbmW6vgiTMpfd
         3RGzs8rMDPYBkNIJeoxQgAAa2fHflkUxonzI951Iv42WnOAg6tfd7jemi1DpK7KQl5Ja
         xvemqkMNYZ5qxX5todJhwHiwquT0EI5muAPTf2ZJJkeitMSRotuj0n4cjRYniPuTJbmO
         F9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302760; x=1742907560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2rOvWhbbaasJpoVbBB9qwUHxj3E8kjbQWmEpFoMuV4=;
        b=l1RoRSEXWcEcwWfKqmNUbI4ZfaSxaQIuPyDck4YIqRqAg5BdYPHlZzLNZAbmjgl4wL
         n+8r9IBqDKZfUYNE31WuRF5VO6zjc0SHggWbMbx4nPtjtXP46fkoYX85EfEEq8/XRJ9l
         NHE8T5KxkidaAE2MbvJa/aqdjWYRI4x1INvgXA1FAY2aBL4M/V21RgJozLgmkcKomrzp
         hvwWhF1qBXBWMTxdi1dy4Z50yazEmBJW/DwxVvpgk3gIf4n68yfpCT3nxZ8OchkCJqov
         T69JGcv4Ijt4HbgM51e1KBoJq9luIJEcffA1RrNk9/Bhk8It29i3tTi+82o4tP6tcLUl
         4l1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrEySOEq0A4RTCGjKTpxo2nvVLoiUPiVdZX1KVnG8clR6nW54G9UBrOCXzVSJrmd7HsV406+0v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GDqBZfFuRVITCsuf8l9IUPgIkupc6gGpCmSzuB1whVAkSipr
	a0fmFtlJCC8SaBkk2kYuhj8ZuL/w9GUVLznDte5JJdJ9qUDT0Cyb4BGgVLZhGAA=
X-Gm-Gg: ASbGncs8oDL4gpqfn5J8XHrb/H+f/L06pOvZrwCToZFoGqV/48kFcvOmQEZ/6d5j31e
	OKysa98o2w2OCTHghZ1/UzqZA5S+/FBk6diBVfTU6Uvb5jyjpB9ZOyx/FxXNYhvS/ExbKgexIMP
	O/F91EI3qLXGQYEoRP+DH1h6NF1NbOIaQMi2prNkKZ+/QOxFoK83wRJ/Hpl1mj0e/QtIoYUdwA7
	Z3nGkbV6XMcje5Sw5nxKu3xAn9ZwlujRP2d9SVZZ4CkhBgRWoATYUr5NZurZBzH5u1iF0Ql4v00
	AZ9sSbJQZIB/N76xYgRpZOYgOGedq/vE2wUu5cEcgP4pueI=
X-Google-Smtp-Source: AGHT+IHHq1FjZN5VJMxJeUWLrPLcpeqp4yaSmDJJduS99OrMxuesK9mrDKA+/77LBO0Ea09TIcFYlw==
X-Received: by 2002:a05:600c:3b1a:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-43d3fdd4228mr6097725e9.13.1742302760454;
        Tue, 18 Mar 2025 05:59:20 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60b91sm134340745e9.31.2025.03.18.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:59:20 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:59:18 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org, 
	corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
 <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b2yyf4snjcuo47hx"
Content-Disposition: inline
In-Reply-To: <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>


--b2yyf4snjcuo47hx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
MIME-Version: 1.0

On Tue, Mar 18, 2025 at 08:03:44PM +0800, Hao Jia <jiahao.kernel@gmail.com>=
 wrote:
> > How silly is it to have multiple memory.reclaim writers?
> > Would it make sense to bind those statistics to each such a write(r)
> > instead of the aggregated totals?
>=20
>=20
> I'm sorry, I didn't understand what your suggestion was conveying.

For instance one reclaimer for page cache and another for anon (in one
memcg):
  echo "1G swappiness=3D0" >memory.reclaim &
  echo "1G swappiness=3D200" >memory.reclaim

> Are you suggesting that the statistics for {pgscan, pgsteal}_{kswapd,
> direct, khugepaged} be merged into one?

Not more merging -- opposite, having separate stats (somewhere) for each
of the above reclaimers.

Michal

--b2yyf4snjcuo47hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9luHQAKCRAt3Wney77B
SZrFAQDPVbRXLvpmRUGwdCybiYFtLuew28nJGGWaRN57SWaoRAD+MoSo5nhTmVet
YpfFIbfWdyHIM73tHfgR5xw7MrTgJQg=
=TReP
-----END PGP SIGNATURE-----

--b2yyf4snjcuo47hx--

