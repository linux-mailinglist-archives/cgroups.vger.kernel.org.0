Return-Path: <cgroups+bounces-9020-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7DB1D69D
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 13:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC263AD8C7
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431D275AE1;
	Thu,  7 Aug 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cReP764f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994120126A
	for <cgroups@vger.kernel.org>; Thu,  7 Aug 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565972; cv=none; b=qVYn3v+LzNFt0Ilr6G1sdTV5EXOrS0ZWzDokkdbkZWMHKw4t931WnpmdfRkyjGI842WWhu1Wf7pZjC5f0KACv+5pB0aiitiQTQUjOVwPk++AD0fTFOXS+U7DvAWXuaDxHXqdSRvFhO+ZHhLpiJxKvBx5mpEyscy6eIiXM+4WWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565972; c=relaxed/simple;
	bh=aCk5oBf+uU7I0T67cVUY2P43B9j9NJNVcq2Wlv2cyTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mthpz1KL6Aa4Q+tzu46JH2qcwK4h/iPPQhL3j/rPhaaKYCk2bKtl0QSUa6uPMNHfL2MbPNYcU5I8wJ513ijGqAaVAKLbe3X4t/BAMl9DtFAzzoTCFRSNEcxDbcGne6ARwhykkpeW5jNzWXS7Txy850MZ/kGx/FBLN0sx6355blE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cReP764f; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so394103f8f.2
        for <cgroups@vger.kernel.org>; Thu, 07 Aug 2025 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754565969; x=1755170769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tS5WCia7qftr8p2mf2/K4AYPK240rc4xhDYqqtejS9o=;
        b=cReP764fH6SbywmbRHh08uylSrtsGsdQvSXkBR/isHxijCFkVF+2FpNGaJYbT5PZGK
         iyy7TWnVVt7bdugOF84PONsGjNFFKHjm/1hG1BaGcgOvEEiSdM33KGKm9HqK0uJKKno6
         uLP2A6buqh3toYI5Ga4LhYGegQKx3WhK5bzsnbQ16RurNk+lqUHH7CHG6ex3YOLJewbx
         avORP64DYcKt/JKD20pduAd/vVSkHOR1kFGQ0T4z6gFGslJsf7nXpOkPTRDkoMoEcnG0
         3vveTsDjJluPTk4ISFJTq21LZshEaB5fbSoAxvrI8WPQqCco9zJGe7OJXui81DQIDaVM
         w4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565969; x=1755170769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS5WCia7qftr8p2mf2/K4AYPK240rc4xhDYqqtejS9o=;
        b=vH3ARYe38KnbLNQHiVb67GmkAEm3nqQluNRvW8nhkZL2cMfHLe/Wj3U2b3Phz2zK0Z
         4Ol+KlqEa1BTLl6XDf/EDTYZt71+rtum2CB6nrPpBRDBTU/Q1hU6SDfZ3xS8F0zZnWgt
         sQOC4VwCjxqIJlwGq+AD6qHyCxqeRz7E51IskMSK/8gnScAQlr/Nsg8hBZqwnBxkMwZq
         u3rPpdP2Fze5++OqNy3qzfx0BonxlidlNE2+xQheoEHYi2oZunQATMk6pRNDDjbTM4/K
         RvLocZQdZdh/zbTA6unvlLgsJN4SytuwIC67Zpt0h7T6U7gmvPWLVe79sVndDonOGl1a
         ifHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJkRCOB68nMHyrZEVxb5ZQ2S+zpQEF4pnHAD/57Esn+b7HE4yORXp6Qv7W/DDvprGi7LJRaCxV@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTrnqRPKfAMiCpLo7NkXLlAwKKJ0cQzmRHWbTO/Np894ZqwZT
	EcUNNCUAIQmSVPFz2roI6gwmWSu1g8kGYmvcrgg+buv7xW1t8K5fxW315DIRkNBPGwg=
X-Gm-Gg: ASbGncvDNMAHTERxKM8ChT1sEXzljD09NuXBMXMpXDgZ1EcTxhkxDnSS/ydVJ7b9+Bo
	qyVsKPuc5jg0I67TlWT9AUWPPiAWzVNu/ftr7h+HPtQScZoUrgIHLMkGrhQ+PPX0QkTWfdbBKLM
	a68pfhTR3RlBO/IvyxSF1/74td7Cx7hsEmeA+XGjswcpRPpqJ9QV7Riqhc2ygPYSxLYNDCt2BZP
	244vu1dWsr62OY3Ew4YE3RKC1fbb1WejWBx8UfBDp6HGym96lLW3mU3iuJGvdovaoNGVDrcE8ip
	YdjMIyV8n5Rzr8PTy4c5G1ArT06LBRa8NNKnpAMKmkgjcQMN0FaaTZJL4s89xDRGs/iPxdw1sPH
	drcceSFTxS3JTjpzbUvLO9RZeR23Mna/JFTj0IY8oralCN3SF69GD
X-Google-Smtp-Source: AGHT+IHJq29PT0clhBo6F0cn8O2V+zRK8NjH0FuLASC4fLJxcSmkIT7c170Uwdmbb9l2y/ilSTqY7A==
X-Received: by 2002:a05:6000:2381:b0:3b8:d337:cc16 with SMTP id ffacd0b85a97d-3b8f41b523emr5416087f8f.41.1754565968809;
        Thu, 07 Aug 2025 04:26:08 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977345sm181545495ad.108.2025.08.07.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:26:08 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:25:57 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 3/3] cgroup/cpuset: Remove the unnecessary css_get/put()
 in cpuset_partition_write()
Message-ID: <7u4dmzplzjnj2v6l54xrabdy23laax6rwjhvt3lncbueoekfbc@g6ug5de6c7u2>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkslxjt4uy5baxbv"
Content-Disposition: inline
In-Reply-To: <20250806172430.1155133-4-longman@redhat.com>


--kkslxjt4uy5baxbv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] cgroup/cpuset: Remove the unnecessary css_get/put()
 in cpuset_partition_write()
MIME-Version: 1.0

On Wed, Aug 06, 2025 at 01:24:30PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> The css_get/put() calls in cpuset_partition_write() are unnecessary as
> an active reference of the kernfs node will be taken which will prevent
> its removal and guarantee the existence of the css. Only the online
> check is needed.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--kkslxjt4uy5baxbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJSNQgAKCRB+PQLnlNv4
CN56APoCoplEsb9HyNijcd6TFKw7nn8vADYOfifnkefkpM0rWAEAgdX037v2++FT
s3OlTMXJ6WNnYxx1X1RPo7nS0T9iFgA=
=3StA
-----END PGP SIGNATURE-----

--kkslxjt4uy5baxbv--

