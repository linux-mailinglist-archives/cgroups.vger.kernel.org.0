Return-Path: <cgroups+bounces-8909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3091EB122F2
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 19:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434451C86919
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC792EF9CE;
	Fri, 25 Jul 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W16ENCwE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015282EF9C5
	for <cgroups@vger.kernel.org>; Fri, 25 Jul 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464228; cv=none; b=JX1J4RUorIEwl2hGK2cYh8c48tqBBAmZL5xNqXMSTDzP6NlP6vgU+AIJIdDATYasfkOnZ03EY5iV+N1yvC3W1QWhtdoeHcXAXktAoLjRNIfc2kIzUufK75FsiGAwAXQUXQvM3Te3JcdhigAxUfhgYNbRy9EHT0/gnIQRIyjk/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464228; c=relaxed/simple;
	bh=D5TZDlEPgBe6V0e0eEj/6itbBciZFTaEgNqYWePWGME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+sxV50GT4bltOP1XMskvDRhbs0kqP5F1doLNKBf0Llp2zuAy63DMQbCPCNi84IdPhhttBC993V5xdS7LdxZPgPIThYWiJ6klVl97sz8D4xWzYudztoqwxNRc8V2JjDxPn2MdvjFf5FIOHTc8VGAjGUO9/Va9vKbi/gzRbhT7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W16ENCwE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so25191815e9.3
        for <cgroups@vger.kernel.org>; Fri, 25 Jul 2025 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753464225; x=1754069025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5TZDlEPgBe6V0e0eEj/6itbBciZFTaEgNqYWePWGME=;
        b=W16ENCwEaiu/esmEZspSGHyErTKYHSCqJpiRSjyUCzQ87TiW17r4lfob+Npp9p+sRZ
         FJBFkn9PmL85y80Mg95ZTYOtwNsEACTzea4GuEWhtjmw91QVZ/wKhXd2XfeRm1VacRk+
         yMD4JZ+MhZ7NW7MzFQyV+1hLsDDEFq/GUhWOW4kFw8Yn4U32B08w+f7u39hx8uYUMKQ1
         qUB6hy9kH06CtpImh/BdRujcNpySJ15xmlX8Bxt0cJtP+NQcB1FejKFxU53XvbiebcJu
         3nwEUOEaHBFqPFRRNRTFNnllZX1ULNowhA1QsUAhry2ctyC67g2lr2Ma/uXmvhRMcsPI
         941w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464225; x=1754069025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5TZDlEPgBe6V0e0eEj/6itbBciZFTaEgNqYWePWGME=;
        b=oRmLANu5U4eIh4ejecIeUpq3Z/cCgdtTvcwQZ9xsu8bwSW/zq9PAXgGfUZrFmNRulQ
         dM/AksQjmVtv7PzM0XdX5Fh/iAwTTtvn00rfzLv6F7fbnK6aIGEiBKSP0ceTVEID532a
         bu9UG/A0xSSpKlmxvwa5J2tomX+kpMyPiBQRc0o+DJ11LLAktaooElr63Tk9Pzbr7Mi/
         AT6QFkr4Xk5aAI5U9mDY8xRsHPzX8h+RmUSrOu/2zLM0n3+QFIRFv1FBC597zpqmKgie
         scyeig0NfLImFDhfVXJXqQsfkVGEuPhoT+FJaV0hZDQVmINthFGTR86V9yJL7iu1QE7D
         k8mw==
X-Forwarded-Encrypted: i=1; AJvYcCW+sOyUDO6lGqV+aK/OUYdsbGMrOdxm5N0Z7Fmh+v4WptI9OxFXc5FHvr/Os8rio6oLFbmOoLkC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZNOFvcvQfmvJhUit+ZM4iCaoDTlNgBWFN5UbTvACqv7n0VEe
	6OGuzjorGW43Shxk8TpoOkcW3ESEO1zPhwP8Ku5sYfka0QEaRA6Ij5A9c5gOp1RGBG8=
X-Gm-Gg: ASbGncu9pCW4XdeVa5e+J6CWFr26rK2NU6mk6yBNKPvvXX7JUTl5m9lzXUrBZchiRmE
	yT7h3aSaiWnVQNwDOWjHS+40OVFh1hIAlX5AEp9m2miV87l9FF6RzqaTagWDrLGvfhdKw8yVqVt
	2tFlFZ/ArimQZzSHDBLWiZ9dvn2/y7wuRMOPun+zN4igjfYfoD2eDMdmckfCrQDnHIcH7WGc2JT
	ZygA9vVouXTtfgboGGmSKS+BsqfR9uMzdjm6LqploX7ec2/GdPKuLsINm8xkQLXZ8NXNCwmkuaN
	iMhg+Yx34gnpFs0LHOzMcGYQpdiYlMZK01fzdl8aj6gnpyh2LY7GjXz5lhLtQmc4MnBmwH/t7Jx
	C8V7ZsJs9h0eVdFmJOfU+tWaD6RPcanZ7eBK6zmKbW1vd9v+uKZnb
X-Google-Smtp-Source: AGHT+IEmETjJToaBC6uDXwn45zfx5BRKCJAgV+cWcV2CHkbcByMrQm++cVqhO4Nx+IJN1B1M5+SyhA==
X-Received: by 2002:a05:600c:4685:b0:456:2000:2f3c with SMTP id 5b1f17b1804b1-45876545782mr20723925e9.22.1753464225306;
        Fri, 25 Jul 2025 10:23:45 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac5816dsm3395325e9.17.2025.07.25.10.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:23:44 -0700 (PDT)
Date: Fri, 25 Jul 2025 19:23:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
Message-ID: <cughucmlrkwe3unwwmtx3yrqyrqwsedrbh2ck5feqs6cr36j3z@fhrnw6nfnyte>
References: <20250722014030.297537-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ferhfnh6pl64hcgw"
Content-Disposition: inline
In-Reply-To: <20250722014030.297537-1-inwardvessel@gmail.com>


--ferhfnh6pl64hcgw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/5 cgroup/for-6.16-fixes] harden css_create() for safe
 placement of call to css_rstat_init()
MIME-Version: 1.0

Hi.

On Mon, Jul 21, 2025 at 06:40:25PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
...

Thanks for the instructive summary!

> If any of the three goto jumps are taken, async cleanup will begin and
> css_rstat_exit() will be invoked. But since css_rstat_init() would not have
> succeeded, the warning will eventually be reached.

First thought is why not simply add a flag that'd guide whether
css_rstat_exit() has work to do.

This is meant as a fix, so it should have some metadata, I'd consider this one:
Fixes: 5da3bfa029d68 ("cgroup: use separate rstat trees for each subsystem")

(that's when css_rstat_init was moved to css_create)

and likely this
Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com

(Sorry for being such a bureaucrat.)

It's most appropriate in your 4/5 but do you think it'd be possible to
reshuffle the series to put the fix in front (to ease it for stable
kernels) and refactorings after?

Regards,
Michal

--ferhfnh6pl64hcgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIO9nQAKCRB+PQLnlNv4
CK4WAQDqNVr7A6TCr81qqYBqMSBGWP+xWB1zDLSjL4f55lEG1gEA6bLsEr2M8OCO
GlMuACLcGlonmiDvvTfkQL1DInvd+Qk=
=Ync2
-----END PGP SIGNATURE-----

--ferhfnh6pl64hcgw--

