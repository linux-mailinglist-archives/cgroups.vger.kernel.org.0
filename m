Return-Path: <cgroups+bounces-7130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49AA67104
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 11:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D712B189FD14
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627E7207A2C;
	Tue, 18 Mar 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N24W0y4B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550122040B3
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293070; cv=none; b=mZHau3s8txOnPiUZP6tavhRMK2ekyBK4M4pWY7XF5LK+xUbfqVJOUHdEZakcKxre2oMpMUuLgMaNF8trUGobGYHpaGFe1N1RPbBO8hxJhA0oDaDpOxXwPo1sca/bOmgrCXnu5ejH1HklhX80XfldOld0Cs7pgXknMtpgsN8rL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293070; c=relaxed/simple;
	bh=IFBxPeTjHI7TeObAp8XDFRUhMTnCq+H7JfaB8yzIjPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaATMoxucPZrNLTJ5eAfpOUrhxno7+aEG6bMa6Z+vu1SVZvxkn5qIEmklGEV8XMgHftK0/LhHp5+NUDIXIa9+pKeNaMAlfGdb7vEPXVo7LgTBBklGRI8+M++Yraq1yRAlOJaZ/jozoAMvotWQFfIC8OUbh/BCCHi2Zu85xXCAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N24W0y4B; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso28938365e9.1
        for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742293067; x=1742897867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFBxPeTjHI7TeObAp8XDFRUhMTnCq+H7JfaB8yzIjPY=;
        b=N24W0y4BUC65V80kMsbWm+saRH/9kqOigHaw0N7gKMLK4/Z8bHLxGcvvTFjcJqmlHR
         Cltzu5pAuTFtIwiRsmdoUwUagW7n/z7mzZZHdZAASYow/PwV5AXuSNW1hdSxynX+86FJ
         b4NTbSrYdTFVinW2q9U6btF3WDPAz40oWc4vDpQb5HBizFKPP/c4AWC2daD+i2AhhlN9
         nuM/YpU1F1jsnMUjrEkDT/HnV3Ol8cwbkk57W+pmX6Xbh7XXyx0gUOa/5O2R9BMAGegM
         yi3qGLGehthcW2agJjFhLhWgmH02BdQuvQqdjzqCaiZFWGtPP71CcAofAI5U+D7kBYfI
         hpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293067; x=1742897867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFBxPeTjHI7TeObAp8XDFRUhMTnCq+H7JfaB8yzIjPY=;
        b=k6lbbVIYy4cYy8DquT+zTWt6bBk8Qbyg+nn0cEedCW9WEijug8hKAT7kh0KCoQEPLa
         4U1NdNRtnaAgGeyt3OE1sGNCxDqJfkWvFTQrXP9LuKKe2tBIQ26CzYmhUIiwH9NhYEFI
         AHvdThBX/8ZgSeewwBV+IMMRRZeIiCPtHQtxKLRNID3UbolfBde3fGkn/lzaALOf1DDK
         rayEAPmI9D2sQb0qmhQEKKbqqxPtiZghlbMMKSIDxOcYbIR6K78lQ195Nz4ExXUbG/vg
         yjf9Ivs6A+Ij202pif8fhNDUTLafyVq5j8GJMTv4KyqJXNJLyPbUfyMNG10YwHXfIXC8
         nKkg==
X-Forwarded-Encrypted: i=1; AJvYcCXTMBDshhB7JvzzWwEiCVf0QjCITCiiOjtULRR5iaQGAdxVTi4F3clYZe/XPEqg0rOyZmjNy+uJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ISOYXl4+1VfdWreN2I7J0evAeKPVyZLZy+FzDXIfJ15oacQh
	b3sdzOIpitq0SpgZ/S2Ro3prlOrVldSfs2yIU5Nr9VA9q5lYgtHjlvf3hBlT+Vo=
X-Gm-Gg: ASbGncuoRU7QEozPJJBQVS07H89KtirCTR1DMEXAchDk1DNrmSfALBiIlItCLmb2Lo+
	lSNMjnp1VZtK/7F+s5KwkjCHKHW0EWwMkD9JDiTpMoTg9OWZChNTeyzRWTHfaifzgyW0BkNQwQC
	5fCvcHg+x3fhGRXUw2AlhEQREcFP/J/5X+72trSSXbXc6zgvyH0tPPxy/euahFaVMr1mW1RYWx8
	+0GT0Lyqz4wM+YdQE+TVyBBa9XET3AkE39A50GTPEGvElMtqIa+HGD8FhBvRAZ8hWoJp9FlLozv
	QUn57Dcb2IK4ogEgqHF9AbxulVmt7EVQlZjSISNm9+Xvt64=
X-Google-Smtp-Source: AGHT+IGDLa5UPBGfrRVOOm3XvQnMemu2Schtcck+5EYcWBJ65baV+gaiWnBiXGOVUyqS4P0tACKxdg==
X-Received: by 2002:a05:600c:4e8b:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d3b9dc596mr11587965e9.20.1742293066628;
        Tue, 18 Mar 2025 03:17:46 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3ae040f9sm13194615e9.0.2025.03.18.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:17:46 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:17:44 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org, 
	corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6wfz6q3cfwefzqq"
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-2-jiahao.kernel@gmail.com>


--m6wfz6q3cfwefzqq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
MIME-Version: 1.0

Hello.

On Tue, Mar 18, 2025 at 03:58:32PM +0800, Hao Jia <jiahao.kernel@gmail.com>=
 wrote:
> From: Hao Jia <jiahao1@lixiang.com>
>=20
> In proactive memory reclaim scenarios, it is necessary to
> accurately track proactive reclaim statistics to dynamically
> adjust the frequency and amount of memory being reclaimed
> proactively. Currently, proactive reclaim is included in
> direct reclaim statistics, which can make these
> direct reclaim statistics misleading.

How silly is it to have multiple memory.reclaim writers?
Would it make sense to bind those statistics to each such a write(r)
instead of the aggregated totals?

Michal

--m6wfz6q3cfwefzqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9lIRgAKCRAt3Wney77B
SRN9AQCIE/qNRp6gU2k+xnK3FHJnFxAelfP/oIqk3z71MjMSZgD/cizNdVftiC2U
CSpV9isE71qsCu5oCAFzbKznXsbF4Q8=
=Bloy
-----END PGP SIGNATURE-----

--m6wfz6q3cfwefzqq--

