Return-Path: <cgroups+bounces-6614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC64A3DC6E
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 15:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E64A1889928
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84781FDA99;
	Thu, 20 Feb 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GLbZzqVc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E21FBEB4
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061061; cv=none; b=q6fc7FgR5AItrt9eE5zgL6rXVOE1ezqZZ6+SMxRMfVw+S59Ej1jP4VMHvcrlHCDKxvqN2421JE5njH5bQoBcjxv/dcmg6o/yFNS8xwvJItLWwQzhCAsrzp99jzOyiYdVcvdyDOQ2UoTASKpDYU2PD6JRJ2Sx4ihSCmyofCwUVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061061; c=relaxed/simple;
	bh=l0wl7zbVUQGOEulPsP8aT0Z+3LblQccWA5SiNtW+GQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjTvBBMXJMEqmsRspVqsOIl5DJYXobsFfAfKtSBB1XlKdjBcfBHcChdF8/hvWeHmTHwMaXLO3RbY4XWzNrXaX4UFZP6ytJwkAw/Hfv2QMfr+Cyq/d7ELiNSrVadhBKs+ergavNeEl+NwXukSDhn++ainqwSypyNQDbbsk/lsTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GLbZzqVc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb79af88afso195439566b.1
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740061058; x=1740665858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTj2n+cO1ksr4sIMfZ6fZHsbGN0ZLnv+4jljDLUN3e4=;
        b=GLbZzqVcIh8+XtueLFR8LZN1gEBmbkW1wUm3XQ+8RoecRK4tXW0OKi4cQS8Ph9K+2S
         fNJxHBywdXH6n6bDxbDGWbzJJHpCGLw4BpfAEr0rj4gOuywHpP7QIXPbHcNim7Mm/TSn
         RVuhpuWb43d4WHOBw9sE9Zgy8rSpajxN3xIIxOq8jb5/6Z2T58OBFJVKPc1TALKSRgVR
         6N4cI7BzOACtjc01WBgf95dj95fakqDralRrA3yXmOEt2NXpt5cAsq/KyjdUYZktED3p
         VAgg3koLTNDBFalyGHvSJ+L1LHweBFfxChVK4KnlGIlKCv2r8qKPqlZsIeJDfRNbURYh
         sPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061058; x=1740665858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTj2n+cO1ksr4sIMfZ6fZHsbGN0ZLnv+4jljDLUN3e4=;
        b=hXpmxOQ1MdtOySfaPcIuRSkjLiKKURkZIsGB5IKCGMFxfrLpaFm8FnvTVV7ZVzIHF4
         zBNA6OwI4/1sDGu0TX+zpnBFdU0X9ny+eEXI6q4NCUOSqTMhQZ9QomZYOp/HRKgDl86a
         7IW7WaiIcWx6FvVozXtOv6SIc1rHSHlQPG7vaXP0i3u+VqO3oHoAyJO+xg31vwPb0Pht
         87JA0OYKj/IWulFcu8O+qUqQwN4RetxueDK0UQzHWVsDhcqKPhRdUYaUnubFR81ZUITM
         k5NXj+aEEVB1YKe17L0dVGObVIhd/t8Stj0ZbekgaF1RnTAFMZhd5UKoWmWBaooJr0Oo
         n9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCX4DFAS7VaFEzkYZZtxlOpJu2eQqc3Xcp/sWeSWpptgqQb1fOd9eNrcXtZjK5jJZd1hloSurUIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcyROjht44lsGCKNsriqtPA1PSdmjyINqYfTaRR6Os2ncKibr
	QsKKL0LmnqXEnPhQc+RulAskCQkEwkqW3n1T4o71WZwstvm/JV+x/f2NtoV2g0M=
X-Gm-Gg: ASbGncs5s0Z7sjaIKr2GXlkNukbSx5I6mNnDr7LG9p3kl4rXlusxtLEoNsp4a3M6yyF
	4DaYsKSvhS5xG30649TlmRXhNzZwf7kAlNb0mxHie98q4Ua3Lnck5P4eMe9tCwIkyS4x5gXwxea
	sUhS0sw6j7Mjs3utYpIzfVtBO/cO7vXRM9Wlfk+PO8Pn8Ykz0T+L0Jfy561fiMAv80afO62C5Yn
	dX8IEEaZY3n36BNDwvOldrxSQZwQ4H+/l3S64WH7ipcXQvzG9/O3iJZ7YPktPkHDsZtIpostv7A
	+oPcCD3i5h+o/Kd/Hw==
X-Google-Smtp-Source: AGHT+IE6o+/cJ+UwhOVC1D5d0dAkIysZD3muXSO+pyu0qJjSa/4TuvtmEKXevVhYTGpBTz+vXwH+Nw==
X-Received: by 2002:a17:907:9491:b0:abb:eec3:3946 with SMTP id a640c23a62f3a-abbf3d06509mr205955766b.46.1740061057935;
        Thu, 20 Feb 2025 06:17:37 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbe441236fsm239556966b.176.2025.02.20.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:17:37 -0800 (PST)
Date: Thu, 20 Feb 2025 15:17:36 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: Add entry for DMEM cgroup controller
Message-ID: <wrqz2mls4vfx7e5hdegl5rxtgz3hrw3enaalpxusarkqyqsxam@sebklnnnma2q>
References: <20250220140757.16823-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="auj7lverra4dsowb"
Content-Disposition: inline
In-Reply-To: <20250220140757.16823-1-dev@lankhorst.se>


--auj7lverra4dsowb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Add entry for DMEM cgroup controller
MIME-Version: 1.0

On Thu, Feb 20, 2025 at 03:07:57PM +0100, Maarten Lankhorst <dev@lankhorst.=
se> wrote:
> The cgroups controller is currently maintained through the
> drm-misc tree, so lets add add Maxime Ripard, Natalie Vock
> and me as specific maintainers for dmem.
>=20
> We keep the cgroup mailing list CC'd on all cgroup specific patches.
>=20
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Acked-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  .mailmap    |  1 +
>  MAINTAINERS | 11 +++++++++++
>  2 files changed, 12 insertions(+)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--auj7lverra4dsowb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7c5fQAKCRAt3Wney77B
SThJAQD0zjicigO8wYeq3uRQv5OjE5jzfwLH0yChQm9R7aGzZAEA9/vW6lQuYqpN
ppmEIS1pKu6XgwxVsiQNVnYDiagKlQc=
=6Bo9
-----END PGP SIGNATURE-----

--auj7lverra4dsowb--

