Return-Path: <cgroups+bounces-7712-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68422A968A3
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F00D17A049
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D265427CCC7;
	Tue, 22 Apr 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KH1OViQG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61527CCDC
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323897; cv=none; b=Y2YN/0s+0RUv3G+jVEd5hEZ3Enwc0415Bz/1pUAHLZjBapNpaW6Vyq6fa669HBzv0KxJqj8hZEw3rrO3tMF0OWEUiqskD7YOy1tOyeYz04fLbY/2quQ6/irRHBM/dQG+JPFJobNAKrr5MsitQTVFAbJ+hu1aP8JZjraH10YX7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323897; c=relaxed/simple;
	bh=Q/0eQ4z6xF/rZSS6yNW+QOVGiNYbzpf0j7hh9npWX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR1EcwCrmuAj1IrB+ytXCTcELggvP8LUoyIjCelE425qDSml2N5TQPwDJUvnsirzSkCThojpp2XgGVj8xW9zoNi/2wj450Qs11EB0fqkj5DeVfVMCUkzf4qP/irCrl6oVhPJMF9nnT96dCxdRwIcw+YKoqiKMwK8532vlAtd2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KH1OViQG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso9620722a12.3
        for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745323894; x=1745928694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KT1JxRWSPsmY8fesz3r5b2lILhpBpQyPhmAe3rmQpu8=;
        b=KH1OViQGN/9Izj1jLQ6iOqU8f1rpU4HpLRSKlHxG+hpwZ0RTgkdnUlnydB/Je2YhMN
         AUYbcyFbCMFK/aq6y+GMjpWunX/jJ+sYUpULEXUvbh9QIWZSJmXd9oN2AvmD+z45kJnm
         KLOtqrODJ+Q6PBRgq34JwMSttRarvpTO41Bzjf/FnLJiGNSDhVGu0XEJ51gRi2F7X/kT
         yvSg27sjlI8t0dT2ixjAgyQVPeloMRLtsqpU4PGzcVXl2f0yeWX+DohxBfLbTE/WMI0R
         Y97tCfDVKys4eelK/2fCfefHNBjjxc25LN+fJ7WCXXfqSDYRMvkSqNXWWW41Lo9dzPGn
         Yy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745323894; x=1745928694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT1JxRWSPsmY8fesz3r5b2lILhpBpQyPhmAe3rmQpu8=;
        b=oBj9rvUJmmhq62YlJGuS9jgiwP04Dp/Pnj4w9m1EOsQbcaA/a8ouYOyfi3oNE658X/
         FfYJunxcMqfJY/OEtwGdhtdhBdNTmhUXWKaL9lNBa56Lkp+AF9vsCPBn77z5YhQmF6XV
         C4tSSpU6aDyrNds5MjgY3kbpgGDDShrcaWcjWnBYbIQ15bmBxHfbcwuwRZdvTnx4dNHQ
         D91og3FWr7qVjnd5vE0Putwow8UzgtIZKzjP39v/SfhWVA7zSIgJU+YL86OL9kZadLFS
         fDLK5TTDvDMe7c1PQ1xS1R00U2IVJz1XFKSOrMNI/GQPfn/04mGscV5X9oeNFTG187HH
         3OUA==
X-Forwarded-Encrypted: i=1; AJvYcCVAl6HDx3olRDEiqbEYIft3f4rXhZ/PDqbKUtl2kHzaR2vZYXdNVI5rEv/Hxp9atOq6IwqZxjbm@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7A1auSLkHPbEKDKXPJ6byL7dWNMMXvN0JDLpN13L1qebKqhd
	iLZaYU3qQRiDNjt8Wp/ILi0snZQRM0XGkIMrBqIXhDyXeWuPnN4wIK+62bHWYTg=
X-Gm-Gg: ASbGnctO5x9EEGw2rajU4wSleKceEH/V7ymJci1llL+RI9jdYGuczPe/qmzAYt2FxAy
	ZVyTv6qrDqxENO2VUYOjtlU6BTM5X0zRqxfjsHllwr02ZAv1A5nsQoHseIVsxHCv3ooJ2Aptfqf
	/HXkWQPveps2eaqXuv3sCS2hE0kBBPAObAnk4G2pCdKlgxGt4E2J18o34u/u0F21wzfsZZqic+D
	WBd0E8ZiX/TvJk4veQCtRrtTuSIQ7xAtV6e2zKi+c1ZfXorUNbsnD4f7fRyHNozlnKBugSAwk90
	jZ8Z2Nlm/TWTlQ2ZBdNfR9sjAeS1a1NQE1VIeHE8QFw=
X-Google-Smtp-Source: AGHT+IFyYmcZlvcAITMghOEvilutpzLwoU5xPOnInSRoTQAJsg2jq3a94IEVeo4CoWvMA1NEnQNxKw==
X-Received: by 2002:a17:907:96a4:b0:abf:19ac:771 with SMTP id a640c23a62f3a-acb74adabfdmr1382972966b.2.1745323893733;
        Tue, 22 Apr 2025 05:11:33 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef4ac41sm644389366b.152.2025.04.22.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 05:11:33 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:11:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
Message-ID: <h64z4wl6mw3qxfwmqsvlddsie62ehkoag47lm2in3nda7dhloq@rjxpkggawqem>
References: <20250415210415.13414-1-longman@redhat.com>
 <20250415210415.13414-2-longman@redhat.com>
 <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
 <0033f39f-ff47-4645-9b1e-f19ff39233e7@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sq3j7fc2pogean7z"
Content-Disposition: inline
In-Reply-To: <0033f39f-ff47-4645-9b1e-f19ff39233e7@redhat.com>


--sq3j7fc2pogean7z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
MIME-Version: 1.0

On Sun, Apr 20, 2025 at 05:48:15PM -0400, Waiman Long <llong@redhat.com> wrote:
> I was referring to the suggestion that the setting of memory_recursiveprot
> mount option has a material impact of the child 2 test result. Roman
> probably didn't have memory_recursiveprot set when developing this selftest.

The patch in its v7 form is effectively a revert of
	1d09069f5313f ("selftests: memcg: expect no low events in unprotected sibling")

i.e. this would be going in circles (that commit is also a revert) hence
I suggested to exempt looking at memory.events:low entirely with
memory_recursiveprot (and check for 0 when !memory_recursiveprot) --
which is something new (and hopefully universally better :-)

Michal

--sq3j7fc2pogean7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaAeHYgAKCRAt3Wney77B
STU8AQDtPchwdDd7GvYG9/lftHphnD62oj3o0m0hpo2aWJjY4gEAjv+IF2GZLFKQ
73DPixoPDX77bf3ZdvlqpW53y0lI8wo=
=3Mvf
-----END PGP SIGNATURE-----

--sq3j7fc2pogean7z--

