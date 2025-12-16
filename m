Return-Path: <cgroups+bounces-12378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533ECC3735
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 15:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8604230F9A85
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85727346ACE;
	Tue, 16 Dec 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HU7uDV0e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58B346ACF
	for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893350; cv=none; b=pWierlnSlRpMJt/ciEUTFiZV7OtgOU6UH+Dq3jnJGk6e3nYpI1TrPuC4z3/cn6ysNpxhhsyHzC5ikqfyCc5XkK8lrbKDPs2VUKWctcec02yJqN1LGRvzg05fKwX6UobXpGFNEBilwM8kB6EvcvhhvHFQE0BvYcgzaQggBth96tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893350; c=relaxed/simple;
	bh=sowK8ez5G7HoTtte0ShrA1/hBWdo9iNbqEOC2n72nU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP6IRri6mrL7XZgP5QLkcENfSjuEVjnA4bFbus9Dwv86BiXjBl22RzAVjtFTNFT0soFT9gCJIGWhN2c0VOrm5GZS+k0I+SEyzgqd7P0wjNMGARvg+rIq7FUp2EFotZOF40JUS8jgOwmvJV9SteolRPGxP1b+G+gC9GRSDspX27c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HU7uDV0e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47a8195e515so37830435e9.0
        for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 05:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765893346; x=1766498146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzYsjUJdKV4iptxsf7n2b2/ebFnlruh62rQM3GVQ5qI=;
        b=HU7uDV0e05Y17ThULv3WBt+MCWSem9mGtvlWKb+ab9hpxh7BSmlHaMyH5rihJxtMHl
         R4h5+9shkiZqh6n0EDTmtO1X7ttLLU+mYQUJ6Y0xLT2oDUIZVc8fnpD1GJ7IToXrFyOV
         0yrnfqAuDZhfVmDN4Of+xpRmDWzmivjgj0EkaqyGBPFjvSz3HU/Q8xQ+63BmlJ32oTOY
         zJBpg1llyyJWyJEhtzO5EOUn4hieu9zgyS4HYpYCaaClKM22MqnNPVuHNax2RqKvaJoG
         1s1AKoRuzqnXe1/fx8J0vP+bm7YKCwh47cFOd5jxasR0SNEfgXbA3HwOdjsffKb1g751
         5quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765893346; x=1766498146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzYsjUJdKV4iptxsf7n2b2/ebFnlruh62rQM3GVQ5qI=;
        b=ss/sLIcTygzuNJGkfBD7v5oqoxemyTwk53+pOGcAmmJh/gu6b+PbYt6pXsB1zWBs/0
         rnlxs8MiD/jPERo5Ho/c5KYekWm54DrTLeKktJ1zzEGZhnapmoiEIrr0YY1zHiDbSUhK
         MG+0/0HCs/wv/6yHUuNMJU2h5TaAOwl3pKYMIIlxMUb9qNUdsgHx0jxW0zeUQFlksb5g
         Cd2PYsUEiR+zy8w2DmddQdX7I63nLl7292FbntPAXDORpCGgU/AylXC7vICIm3aiWwFM
         tAaRvPuyIPdO0XrNkOIjLJoF6P65o5HUUpUXQJ9ZB0zzuuS7V/pmNdYb1xzyDrAsRa4E
         eYkg==
X-Forwarded-Encrypted: i=1; AJvYcCUKQ9Jl+DB6iUTegW5pVdHJMzaWBvLmbVU0HLgSuG0U/ZZzDkDuvXtGFG+iSUKWX6T92XAwl+ur@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJeB2HsKiI3+Wsg2kLW5OtuNeR3IMb7IuUEaaRj9Yls5o89JX
	7WJaHGkHWoW6/UvboYK78VSMnDnTJwNrckb9mZg3AUHd77RzS18lqMNXM2GbVQiBgdw=
X-Gm-Gg: AY/fxX5Mn3HA6twUNzhx1HKjybOpveUpWowhx0HD4ocxB65AkpCVTpidDRjPMXMoDv5
	lrgZQJ2ZmneNlCxyUWoVuupY1jQuiamUu5OGPLsA0tTJHCBxdOLXk27wt6bVX6cc8dGdJzonZ5H
	czzZI+ILv96xv/qB5cn5KbsDV1StSFXG4EvANZ8G3nzhGkFgQxjF649gJ6oNTMz00zDuzEc4vvv
	iUr3blG+j72jzttr1fz6J8XeG27PtyLnG2xUSbLesCGj70mdnZ9Tn0J0+HBxHjJSnOc0ug8RLHk
	S4DeusRLvkyIpoW7v8dg+aX9+t8xSBBLpkSmWCnocYx8JAe5ZDVyjAZ6eg/ZlNfMUuddb/07rNN
	GOwB5bJjTZeImBSfT9NoYFXyW5D7+wWpyCUZXGpF9ltGDffLYSEUm1kFlhVB2Zzzgb4U4OAcljE
	D4d2BY0boCqz4ZbPmKJIIvrqCk9WyrWyk=
X-Google-Smtp-Source: AGHT+IFqxFK7p8nPhkFf8kGXRC04JoiftlfevY8y2VaPpe2R4CSPfjUz8W1kpkIUV32LWlyMmTP0TA==
X-Received: by 2002:a05:600c:3486:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-47a8f8a71d5mr153328105e9.6.1765893345659;
        Tue, 16 Dec 2025 05:55:45 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f776898sm239716225e9.8.2025.12.16.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:55:45 -0800 (PST)
Date: Tue, 16 Dec 2025 14:55:43 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, david@kernel.org, 
	zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
Message-ID: <6wm77ncacitv7fb2nc7sshpjjqshsh4xffey4qxhzu6oz4gevl@qehhysirzyhq>
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
 <20251211013019.2080004-3-chenridong@huaweicloud.com>
 <o3hmzratjkcxms3ylnjiuashclllf7mvz6ttkfrz4lybdiwhhp@yeo5my374trx>
 <476fcde5-d54d-4b15-9870-844b3b8c700a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="quczqmdvgytj5i26"
Content-Disposition: inline
In-Reply-To: <476fcde5-d54d-4b15-9870-844b3b8c700a@huaweicloud.com>


--quczqmdvgytj5i26
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
MIME-Version: 1.0

On Tue, Dec 16, 2025 at 08:34:40PM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> In my v2 patch, I was reading the usage directly:
>=20
> +		unsigned long usage =3D page_counter_read(&memcg->memory);
>=20
> This works fine when CONFIG_MEMCG=3Dy, but fails to compile when memory c=
groups are disabled. To
> handle this, I initially added #ifdef CONFIG_MEMCG guards.

Ah, !CONFIG_MEMCG, I get it now. Sorry for the noise.

Michal

--quczqmdvgytj5i26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUFk3RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aj0BgEAw0NnDYAA+WDjuxM3/TVn
opuo2yRw987m7508sfF+PIcBAK7RvrijKISFtNPcv9YGtBI8gig6H/uVplSoaYwa
bc0D
=MChq
-----END PGP SIGNATURE-----

--quczqmdvgytj5i26--

