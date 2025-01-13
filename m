Return-Path: <cgroups+bounces-6099-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9AA0B1EA
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 09:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2EF3A4F63
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7EE23499B;
	Mon, 13 Jan 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlTSkW+o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CC233D69;
	Mon, 13 Jan 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758732; cv=none; b=J31NVfYzSNoGwUMFD2RB+ycfY6ICYHfVjSDmA2MWLYOer/6qrPcYFw3fh50uudRE+oAVM8jR+r5fMR8eUZiUUa852lbpqCGNjquXW9sAz/AuZqvMycyqvV/wouuvcrjJ1Nf6JwtjJNG7dMmAYuZ6YahI3rf7gOu5cOJigUNrqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758732; c=relaxed/simple;
	bh=85R1p6gQJr4UEBPOTjv1pFZtVlbImt2PJxVoHdctKXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3f3CV9A8zEK9h/+fZFaPWC1lbMckZB6dnSIv5ZU40IbYr0XsbffrtJA8eQu6Ge5qkPEZnhiTgCT6huucfS5XMSU+4sawY/cL0iQ7idFAbU5wVw8phK4Y81SJe1b9EUsHO0+wWYLdmzZDgge5RJhxD6dKA81tMVDRt3J/lI+c0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlTSkW+o; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165448243fso82608325ad.1;
        Mon, 13 Jan 2025 00:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736758729; x=1737363529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXlVDJ2NycQnRr5wc9OwcaqGxsGbrhb5YE+RIHs567A=;
        b=IlTSkW+o18uM5Mr3tvGaI5DozTFRAvf027mAndk7cNM9Re+Az5zFdiMxf/4frfZhuG
         YofUgh2J9RzcD9f24IpjTcW3dd3TM4xxVmc6ZUZ6y8YCGhMzIpZi/Ry5jy7tZpHEjZ0c
         k2xdLs3nBhtX1JyV/Lmkl/GpfsJNgA9RtHMoEBhIUoZbo/bM6+306LBXHE9aqVLPewDh
         Hpw6R6Trs3ogTuJuFdWpAjccZP1rSbwuJGg9JrscXB9lw96ey3KOtqthipUaXelVEBfS
         Fu9wl3Kr4wLLbwuBRzaNxYBZKBO2ni3pLFjZtdY+/nXXNlJ282T5PpUhqMPiI2luYoYZ
         G24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736758729; x=1737363529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXlVDJ2NycQnRr5wc9OwcaqGxsGbrhb5YE+RIHs567A=;
        b=bd8AZu5WA4ZVz7aAK7nGQus0GYXg9Lu0ICM+FJUA+8q9Dbk0I39eqjC7MGQxHJxMYM
         STspRbD+e6+CzmfT/Q18e4f93Jy/8YH9LSenjmWHhkNTFkw+hBgoFet/jCABBrtRFp5T
         txnGIalHxwZzlfYrT8mSzItgbqIua9EaSbve36LMuMyhiy9GojSgBXtADVj6XVi0oC51
         keLBvRS92lLwfG8DjsKHN1ph3678le2S/m7Rs7g3dvAfa4cbmPM7/7iWqUz30zXG1lSi
         /O4q6nL58BLeC+fgm58qhtdnbx97b6bjNr3HAHSOJD+/2G30Chwwj5IVi/7BEjYp8dYT
         chJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1vvTqCzoXKj+G8x1ZF4QXFBuk+r6/zhsQceIXvprNseEbzqp8DNQ445DUNFLGG7PsL1M8XZYsHjpn@vger.kernel.org, AJvYcCWNN3pdXBZYiXkNLc0NQggYjfH+lKBjFzTBevYiY3udZehObMk9H3E5Na36y223KCzHLwAmdWOP@vger.kernel.org, AJvYcCXH6ICmj4UUiOD1g95J52utLdrl6AAvlU84Z5jhWjE4CPhZb/bzf9u0dmHovprZf80YOTeT3lQrpiL5eXP6@vger.kernel.org
X-Gm-Message-State: AOJu0YxzaCTWOBR1ieZbhEnEIm4sFi/e1mbUVHewc2Tha86A2s+i1j1p
	9TlVuq+gaDM5o8jhXzsxX3rBGbpP8iFKhMCkS/zVJDD5hgzOqXC/YZZXcQ==
X-Gm-Gg: ASbGncurFu1SNCaEjevuMoLV05Be8hWmXLPR93iIDyJ5JXCJEUSmOzjB96Eu7lH+E1D
	+Wcce0gN37lqgQoRAI2D9bTXhxRk7OF5PxL38e9Zxbdk5xajoH7mdsEO5TJ8nKZb5LwKow3jAFy
	6dqLhnd7MMrSjFU39wwIqxN6CNOIyV33z/Ncyeu9VzfmSB+qXOIPQgYoxO+d3HekUngM3GX/yJv
	KAO3xgf/4Ys7Zwi1kixaM1uk8xQMV6O3BPuYptYLFTGPAosV1973+Cv
X-Google-Smtp-Source: AGHT+IGCQpUk/1Fyi1JXHGdo6MAwD/GD8s4y0QHGsyGsMRQkxoVoquwQa6mL3V/1RLYvJZc3shKzEw==
X-Received: by 2002:a05:6a00:3a02:b0:728:e81c:2bf4 with SMTP id d2e1a72fcca58-72d21f4eefbmr27013046b3a.11.1736758729146;
        Mon, 13 Jan 2025 00:58:49 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056da6asm5575551b3a.69.2025.01.13.00.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 00:58:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6BE0A4208FBF; Mon, 13 Jan 2025 15:58:45 +0700 (WIB)
Date: Mon, 13 Jan 2025 15:58:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-doc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	mkoutny@suse.com, Jonathan Corbet <corbet@lwn.net>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Waiman Long <llong@redhat.com>
Subject: Re: [PATCH v2] Documentation/cgroup-v2: Update
 memory.{stat,numa_stat} description to reflect possible units
Message-ID: <Z4TVxXF0-G7hnLr6@archie.me>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
 <20250113010530.432396-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Q58+IwG1F/0coK5"
Content-Disposition: inline
In-Reply-To: <20250113010530.432396-1-lizhijian@fujitsu.com>


--9Q58+IwG1F/0coK5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 09:05:30AM +0800, Li Zhijian wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 315ede811c9d..0a43be0c32d1 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1427,7 +1427,7 @@ The following nested keys are defined.
>  	types of memory, type-specific details, and other information
>  	on the state and past events of the memory management system.
> =20
> -	All memory amounts are in bytes.
> +	All memory amounts are in bytes unless said otherwise.
                                       "... unless otherwise specified."
> =20
>  	The entries are ordered to be human readable, and new entries
>  	can show up in the middle. Don't rely on items remaining in a
> @@ -1673,11 +1673,12 @@ The following nested keys are defined.
>  	application performance by combining this information with the
>  	application's CPU allocation.
> =20
> -	All memory amounts are in bytes.
> -
>  	The output format of memory.numa_stat is::
> =20
> -	  type N0=3D<bytes in node 0> N1=3D<bytes in node 1> ...
> +	  type N0=3D<value for node 0> N1=3D<value for node 1> ...
> +
> +        The 'value' can be in bytes or pages, depending on the specific
> +        type of memory. To determine the unit, refer to the memory.stat.
> =20
>  	The entries are ordered to be human readable, and new entries
>  	can show up in the middle. Don't rely on items remaining in a

The rest LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--9Q58+IwG1F/0coK5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ4TVvwAKCRD2uYlJVVFO
o3DKAQDlBYjfwbEyB44MzI3FFsl+vU6+/b/r2rkx5uYPviwSggEA4upQIKkW+fXF
a+cxFGpYI3d2LGlRR95QXscE0ZkdlAg=
=TD45
-----END PGP SIGNATURE-----

--9Q58+IwG1F/0coK5--

