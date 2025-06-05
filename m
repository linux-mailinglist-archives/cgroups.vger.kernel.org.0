Return-Path: <cgroups+bounces-8439-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C6ACED0C
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 11:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FE77A80F7
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DC211A31;
	Thu,  5 Jun 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fsIgkseA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57862202987
	for <cgroups@vger.kernel.org>; Thu,  5 Jun 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116762; cv=none; b=dTykKOkZUWq3ZbX7+33ru/wc2eKrYD2I50HwmpZLbVijx9aqu7x/ap9Yynjr5hHO11EJHeyoKojdSuvjikei/kwEVWEDMrL0SLwaD8RO1hEEdZQQJcTJXalLs/HBJJPMb0Op6LsVhMkwh77MNBxWkgGcvlY8NpXkvgVehRufhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116762; c=relaxed/simple;
	bh=604HNf7UlClQFzx0yTPzgoW3P7AHHBZFozvDgSJXS0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxV15Mkr1DaHQy59YSsJhXdCAi7gxWJFIyF+8YhkdrEwIC4Bs8RuAhl2Fg6+IXpxMZE5QhdcTLeS6kZvsNd+HfE+WvwiXYwfVFcobLUm7XsB5EXxjAKzXGSeHNeEiQZ2aT9F7s33VSK7nqC89jJvfH3VtrKkJCQFHlrzawrx7rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fsIgkseA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so665343f8f.1
        for <cgroups@vger.kernel.org>; Thu, 05 Jun 2025 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749116758; x=1749721558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=604HNf7UlClQFzx0yTPzgoW3P7AHHBZFozvDgSJXS0k=;
        b=fsIgkseA9jD1xx/ouTUFIBBItOUHV3mExDufCzzBDaDpsaZ3sBLbn5Nl4dalR2w8iE
         7dMbVkAAH10GqsCm1Y07YU7iWVHjAIFngNJPN7a7BgAmwfSy7PEyKQb85/wGQLB3PBhX
         LXaAaQK2TjDMqZrBzboqwpyEchVL0Ysu112iAxxeRGLBOVqWHpZ8S0r4T4tSfRANgxKa
         9vxcURJuhnYoV9K/nkqBZfygFCsS+TKfFMEreJCF1wjAKV3oxLRrgLEIpYxv5bk21ZTG
         zi++LFqgCF9pSV9GHXnScjYVxLCpq0VR8B7gXCv6+RsjsP+YqZCEwun7TUCG9kZ1PH45
         V8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749116758; x=1749721558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=604HNf7UlClQFzx0yTPzgoW3P7AHHBZFozvDgSJXS0k=;
        b=pPEr1iQFeZEL1rkw8la7TtKXjhBj09LE8t1bGPOqQtjI6QoEBJ5AIM2ICDX8AAKLl6
         mftHpASZf0fMxEaD1P2xk7U4/Se6ebsnvoAacWX4VHUyu6SoPIzcSpfMu1WIF9XiDRSp
         q8jobcsa1XPUnBYiC3FXn0X7NVvoa0ZXaJnI1CS8i01aHZzze6KDyQ3S8CrxrDuSKyYv
         H/KXoSyrjCU3oRPA/aiitT/AJzSCc05sMXB6LCr6n9eLPNvidy1+5wgE3PhEt4th9sTj
         jb3t8OtYHlHJvidPGlG4tB6FnAqVNP6CTjPBu2NTiDv97TBiZjMUC70U9CoO0nNYMAuw
         Ol9w==
X-Forwarded-Encrypted: i=1; AJvYcCXiV6xi+4ptoexVrB851C1H5mSOuCGqvk5ey+PptTico2hOW1XVPzvmRFt5Oaorh06TlR0v/EWt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qFbMqscbqy2bsndt6Fj294kAnJbdpME4pCpL0WTuWyANG4XP
	1QC/RvCQ5ikyVn86d/aOiMA0UTKQ+nXT603uE11uy5Fycw/mV6FPGVp3mK2hPwYuZhE=
X-Gm-Gg: ASbGnctCBifb982ryO5ZevB8NFCW3R1KstIsIRVCvlI2YEB6ZVj49Zng3VuPP+a3PXW
	bJ2/XhPS3eC633iv61HUYgrA12qZRgMEFtXE61rbNHsvSnBQTygkzf5BkwaRUsfMTV4oP3aNqnZ
	QMlSLN/+tTDKXnMWVB4aKPuUrTQaZlabngTsF3f2sRukuEhJVBGV7sasTgB0jtqti5Is1bzZPao
	mvEjWupJC+o0T1pZC5owWjBfv4XM82sbKptXMCaro5XZqaWBCe/zmgdGoVQGkg2sKLQX0OJWM8p
	xQXCGbTTSG1gQjSSclWTGKAfbVkonkZqn6L7qyNeLPCcXr50g/NsNv/uPYWuuW5b
X-Google-Smtp-Source: AGHT+IEag34AytathBayu/Y8CxhAv38XZqHMCx2v9NsF24iHtnlbNHPubu7RDxi6AKmu9nvDIgxx3A==
X-Received: by 2002:a5d:58cb:0:b0:3a5:27ba:4795 with SMTP id ffacd0b85a97d-3a527ba4a2emr1593144f8f.41.1749116758550;
        Thu, 05 Jun 2025 02:45:58 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990d3acsm19034065e9.24.2025.06.05.02.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 02:45:57 -0700 (PDT)
Date: Thu, 5 Jun 2025 11:45:56 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bagasdotme@gmail.com, llong@redhat.com
Subject: Re: [PATCH] Documentation: cgroup: add section explaining controller
 availability
Message-ID: <mzki6zhrnxdvuqgu56rztrkw473u2r4uqt5mu3t3nv2afyhaub@4qneqmlxgwog>
References: <20250604054352.76641-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zij33dnokk3rcpgl"
Content-Disposition: inline
In-Reply-To: <20250604054352.76641-2-vishalc@linux.ibm.com>


--zij33dnokk3rcpgl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] Documentation: cgroup: add section explaining controller
 availability
MIME-Version: 1.0

On Wed, Jun 04, 2025 at 11:13:53AM +0530, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> +Availablity
> +~~~~~~~~~~~
> +
> +A controller is available in a cgroup when it is supported by the kernel and
+A controller is available in a cgroup when it is supported by the
+kernel (compiled, not disabled and not attached to a v1 hierarchy) and

Maybe this point about v1 exclusion. But altogether this section as
drafted looks sensible to me.

Thanks,
Michal

--zij33dnokk3rcpgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaEFnUgAKCRAt3Wney77B
SYD2AQD1/XItHwQUhYR860OS8RuDmuzgC+aYYTBMu01ywJEKcwD/TZxY1pEcxg5D
wXa3RXxszLiTtREuJrTuHaTRsQ2C7QI=
=69vi
-----END PGP SIGNATURE-----

--zij33dnokk3rcpgl--

