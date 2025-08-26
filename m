Return-Path: <cgroups+bounces-9423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0862B36B3B
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B443A986587
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF82F1CD1F;
	Tue, 26 Aug 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PNWH1ZIH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A562459F3
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218082; cv=none; b=ojAPURjOBPNyjyT2QZQjpMl8pcWFxHs4QWaI/gP14OVgzD28kNCisnVBtlJnnpU5q7LUhBJknJDQ22g/Bg2IoQA58jaGcCVhxMwKlQbMF6NWxYkC2vJgqIXa18gy3fyzKxf3rEkmZcPAFB4rRnJa5qlFggu4/P7Z4mtAHURA7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218082; c=relaxed/simple;
	bh=I+VWRhdnTUjnI3XomDtbZckS18oyRmRBoSQJRcxV7jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLEDpi+gVFOC6DvZGadS95chYfd4oMZwE8Ecva1t0/0MDf5JKbgstGWDrL1YZfDXjWIT02wT4afyumSZe9pNJVFUOifgEAUtHqa5ZXlmx2vwWaW786Yt2Yw5DeRz7NQr0TabHhKN+BNWqT8oeyaPMgtiFl31yYVx5DPijudBEt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PNWH1ZIH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4687374f8f.3
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756218079; x=1756822879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+VWRhdnTUjnI3XomDtbZckS18oyRmRBoSQJRcxV7jQ=;
        b=PNWH1ZIHWUdoJQaKIR7jdykr09w/Ei91PtasffFGGjBp3vFAPqCtAtjO9n41bWTIX7
         xYgUHZkU/H8p/HzinFvN2mDbLOJIWHm/vmy9RIvP127PyL4A63XI4NFcZGqpHo0Qv2vD
         l9TV7c+AkqprE3Oi981Ib2YUgWkRxa+XxDXj6k9p9iH0Zf5mDSHZ0JZw61Ss0+VOdNni
         5Xbv6PTW1+2OXgxOTYl1a/1R3t3kSLGB7/1dfkXer3i92sV980wSw/M1dtzP176rUDRJ
         XZv9hQrFop542ko2U3DWcVbYfh9+5pHkQQHFsO7BcA+RmS4l6dtvx/9l0Mzq7svVlfMN
         CV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218079; x=1756822879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+VWRhdnTUjnI3XomDtbZckS18oyRmRBoSQJRcxV7jQ=;
        b=cvB+m/86L8/kD/r3jrGPYMWO5M+cFT3qCw3YbSQDwMBz9sG7KgcZa2d108af8iFjxZ
         ZKvRZYF1kMoqSi4PUtgN6VF86FOVyxb0tCYAeboB6UTy4ZMbf8o8PGdS2uAUG2rVHYkM
         wgCkEV0uAL/uRWyXqelgv2xF7VhijrIqYezX1s7KlHucKZCK9AD3Vfc7G5GqEQBZ+8P1
         oRGpaGSan05wGjhf6RMH2OW/u74/7ILFkfOfnXfcqN8dsOwygkSmsQMlwqmnLZT+VcXQ
         WgT0Tr3xNVSNuyAefEwKlYbPamxjH2zwBBqFiqXSKuQLgXoNuFSJvaR3OPlzi10Rcdlb
         woKg==
X-Forwarded-Encrypted: i=1; AJvYcCWgWKqSfSJp2mG4tcMG6ti2coEXACdQeUpU7BaVy+xboyRp0TtTnUNOvCY+Dz+JchtLCDeTA8vr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+n2ZzIDGHToJwrY7/bLDbG92uL/TFllRBjla6MkNmqwOpSY9
	Fus750h+dnFG7hMG4R/iemGCclVotCvXQrSTZNFUaxb/CLv8kSkWbtj4caTsBiPWt/w=
X-Gm-Gg: ASbGncsvNQ/wWsFka5iAsl4PS9WpSHtZhrPWCZPbjXx4sU7gN/9TcE9pIy8TzOQ5XSa
	FBeKo+c+uxeE87AnHnBx7w6s5/8hEwvhsRE+RuRJWeWgBfvVy83li9AYODR1pDBBLDPQ/b8heDf
	sMDSzh7SED9iNOkM5yw1aF+R91OHERQ9W6jeKwjRQj2o0gVK6rrLHBNAJjpP73UKp5pWQxZ/CI0
	lzpV8Qk2n+4uS0VFuG0yULLD2bTr3QG6x7GWGQZaEZaVLSqz6ceuAPwmlwnTaDauUiSErukaKmn
	uXm1QHWw3rHfb5DLXKrzgiE8pZuIaDd684AEg0xc+i+01UU90WbkicHV5sRoEkMMJqOYCsQhRgq
	Jj+SoQmwoBXlFL9zdgKrrIYDZ2wyIKdopYLcHpM+OkVepils+wQJB2Q==
X-Google-Smtp-Source: AGHT+IF1onmcmCLINy+0Rdj3SUnLle5wvn3JPSHU/RzbuH+Mf9JjVWxvuwon82t0M3+JcME7Da8B9g==
X-Received: by 2002:a05:6000:24c9:b0:3b7:93d3:f478 with SMTP id ffacd0b85a97d-3c5dce01212mr13313281f8f.51.1756218079134;
        Tue, 26 Aug 2025 07:21:19 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32760f2686dsm377332a91.0.2025.08.26.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:21:18 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:20:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, 
	'Thomas =?utf-8?Q?Hellstr=C3=B6m'?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"'Liam R . Howlett'" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Michal Hocko <mhocko@suse.com>, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC 0/3] cgroups: Add support for pinned device memory
Message-ID: <qd3ioegpvmrrrwdy2qntxznyrnwq3bhe74lmuxio7sy4sjggtt@tm6nqds3pyvj>
References: <20250819114932.597600-5-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4nu53c6pb6rlauk"
Content-Disposition: inline
In-Reply-To: <20250819114932.597600-5-dev@lankhorst.se>


--n4nu53c6pb6rlauk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC 0/3] cgroups: Add support for pinned device memory
MIME-Version: 1.0

Hello Maarten.

On Tue, Aug 19, 2025 at 01:49:33PM +0200, Maarten Lankhorst <dev@lankhorst.=
se> wrote:
> Implementation details:
>=20
> For each cgroup up until the root cgroup, the 'min' limit is checked
> against currently effectively pinned value. If the value will go above
> 'min', the pinning attempt is rejected.

How is pinning different from setting a 'min' limit (from a user
perspective)?

>=20
> Pinned memory is handled slightly different and affects calculating
> effective min/low values. Pinned memory is subtracted from both,
> and needs to be added afterwards when calculating.
>=20
> This is because increasing the amount of pinned memory, the amount of
> free min/low memory decreases for all cgroups that are part of the
> hierarchy.

What is supposed to happen with pinned memory after cgroup removal?
I find the page_counter changes little bit complex without understanding
of the difference between min and pinned. Should this be conceptually
similar to memory.stat:unevictable? Or rather mlock(2)? So far neither
of those needed interaction with min/low values (in memcg).

Thanks,
Michal

--n4nu53c6pb6rlauk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3CyBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgF3wD/T7sV0i+cdg06NdkqMGry
p4ywSWT/m1ixLxww8iCRQjcBAIu13/A09vj6nD3AYjTurMoAlJUuSFWDZE0IA9G4
7jEP
=0oC5
-----END PGP SIGNATURE-----

--n4nu53c6pb6rlauk--

