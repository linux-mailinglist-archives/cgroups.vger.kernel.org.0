Return-Path: <cgroups+bounces-7583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF80A8A523
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 19:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3123ACD7A
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A6E2192E4;
	Tue, 15 Apr 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZTWiK8yM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA21422AB
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737354; cv=none; b=TdEDPJrkWRR5LWmDeZ1wJK4q4Zh/ZA27ULdEE5AEX7jA7GtINPweSdl8w8DTh4mTYH47HNLE2rgUMfau/aVUnNoqlWvPhj1OaV942b6LG62lvoS3zBOVXuI5HBB8jzTPNJ1k8bxjOUI3bDvousYap33tp1z2NiErJCmisz2X2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737354; c=relaxed/simple;
	bh=3LTuCcEYc2hVcdzVSA5YsQiuZYMR0P8Y7Mxm2w4XJZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfwVyP/zqc2Ka3IZ4nsmI1L5hkvmo3w2T8+vEy0fAOSTPZxAspu772EhV9+uBWuyqiZ8e6J62IfRCprcyWXu07OIcaHqtMmteOy3/9O2c03cCdMY6PkH0SeeFY8YFl1Hrytf66pQd1IsQKcJVBT6n22/HBTK+/Tljz7MZbbERRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZTWiK8yM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso3343246f8f.2
        for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744737351; x=1745342151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aCTIg/HVs2mq0xM+WgoXECviqWLvTa4bEgyDlcUjb5s=;
        b=ZTWiK8yMKDdrQMpwW4LZlkVNbXhHQs78EaYvn1SEELzFzPegm2Pcj88Il/bF6r5Cns
         yOwXH6mHC/kdbH7hTNHK4Tc0eK/9tAki/Tz2LSz+QG3aAphtkUJRxVNaUSHdGKeeGilS
         SkvCBjp6dlWK39JsmhJKsrz4du7YcImCwL/TKjCcEvcY25zDIvIBdw4TzwFlCp8zbt3E
         1qU+YrRe5bTolMcCRoq9de/WOSN1txxFBOOOP5iDnzmRy7TxxJnosS7TjhI7EKmi6Bwr
         26mzs3alXzEFn67bAVPFgwRFo6cSWwN62q8KC3k1tffqHUMtO2pYNUeX2BYqX4chELk3
         haJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744737351; x=1745342151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCTIg/HVs2mq0xM+WgoXECviqWLvTa4bEgyDlcUjb5s=;
        b=Sx+XQkkdP2gs5fxuc9esZV/XRyF1kUq+7z3E8+bjAfSaHslqrGoSY6tjsG/5xZquTh
         p6HTKQ5zVEV7POLk2gFG+U/HEEdYMnPfOCEdu/K0knk0rcZqUbIMiQX1C0R6BTLmQBUc
         gukBsHLc21l/8Onz3fTWDBO4IA1MoY6+zicDg9SXv3xm9N5bCBuQZjCnad7yskuaogmj
         NJrNgQ3PU7WESKrXAM8dKEQOFqOLLjqzVBMNw42GAnElyogRI84QOlmDm9JEMi4/N+zo
         1a5zZow1NFxrq8BP0iC3XdfWrYZu4FhXLNQOKvE32MWXJ8pmZLf+2dTb+J1IOj7EDy9g
         7n0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk4b4NkIIYPpQ8haTufcs5QgibzwabeFlFHadg4jeYn1swsLFXy1cPmcjNrUBnrzL/N+B3Km0/@vger.kernel.org
X-Gm-Message-State: AOJu0YwZY5/JS9Y5fo1zu6J0Qy6bdtidGti3roi02BhX8JGvedNZOduj
	VZNvvEL5ZwB+yLZTZGb+7aYvRXoRJf95972RBJPAom3Bqx+oaDAvie1eYsAbqOA=
X-Gm-Gg: ASbGnctPBVVYf5KWjknVJrxTqSKH9ZoHifZMIHO0thrNQb0u4gwK7FxzNRfSStj1lGL
	tWgQOYIYocgA7ixJWih0MSg9P/qtmCJl6Xt6oqTE2mR5L4HppQROGdOZJUNUH6U3BXg8ClyHETq
	+4zzDzuyTq5+7lMCt4sRObBVEmgarjJn56bjt3xNeXD7LC4IqEZlGlVGgwgZOd9M85CoO5RuUEl
	dlL0IvlI/uLswTYewqkemBCI8lFl9XpbqHojEmMqDuotqYt62BxxCrkcdiSk9RLMyCPRfW712mg
	8+9pPqGQyBXwkUrfL0gCo68cIoMThrO6/srmI+JWOTc=
X-Google-Smtp-Source: AGHT+IE0dnBTb1x5DxcK37beXnHw3gjuy3gQskSVRipp/bi0wuY0O//pL/fZp7F8bWH3D2xrTe5Hpw==
X-Received: by 2002:a05:6000:2282:b0:391:4999:778b with SMTP id ffacd0b85a97d-39ee27519c1mr301518f8f.28.1744737350567;
        Tue, 15 Apr 2025 10:15:50 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44572csm15412050f8f.90.2025.04.15.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:15:50 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:15:48 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <3ngzq64vgka2ukk2mscgclu6pcr6blwt3cwwmdptpdb7l7stgv@vhpyjbzbh63h>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cor5zs4qbgttlckm"
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-6-inwardvessel@gmail.com>


--cor5zs4qbgttlckm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
MIME-Version: 1.0

On Thu, Apr 03, 2025 at 06:10:50PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
...
>  static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
>  		int cpu_in_loop)
> -	__acquires(&cgroup_rstat_lock)
> +	__acquires(lock)

Maybe
	__acquires(ss_rstat_lock(css->ss))

It shouldn't matter anyway but that may be more specific than a
generic 'lock' expression [1].

Besides that this patch LGTM.

Michal

[1] https://sparse.docs.kernel.org/en/latest/annotations.html#context-ctxt-entry-exit

--cor5zs4qbgttlckm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/6UQgAKCRAt3Wney77B
SbddAPsHqv+2FAa1isXCc+qO4DC3AZhsBckqZaPuxJkhNwHxBgEA0isqJaUtAfBn
ojjC2QJDbRXHxkFbbp6vOk0TVjjt6w4=
=Y7HY
-----END PGP SIGNATURE-----

--cor5zs4qbgttlckm--

