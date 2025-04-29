Return-Path: <cgroups+bounces-7892-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC8EAA0B1D
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 14:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4281A85545
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5009D2D1915;
	Tue, 29 Apr 2025 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NKJsXX/S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83532D0295
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928347; cv=none; b=PKYML2HSXpXZJNhLDOhHVjnkqq6PXhSuLzC/5nbH8TKVkycVE7Zgyl3/z3y7M193n4aPu8Gy7yVVhB1homPhDQrx+o2f2wjsebBOtxDJ8qnNpBvxlGD3yv0oGjqPWow3TFrwYEX26n+lNBP1012FonYSjGucQzWdV3Hb2B6bD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928347; c=relaxed/simple;
	bh=PAAjyCxZGBIUTEBraJHgwf/vjhPZsyRdV+OwUH1P2mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC06YhonOmvumMHDmG718Kr3b6cBs4DbMa+sqncaqJhhaAdXK7KGRO6UesYlGq+6rcwlKny0XfuGykgSP9A1qfJk1IMCTyshictnCgKdzJ5nW3oMM8bIBrUzwAx1LW0ro8zZQAmNUit9xacoMV2DGN35JBx3uds5VagRot7YiDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NKJsXX/S; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac34257295dso1003333066b.2
        for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745928343; x=1746533143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9r/4N+f+7PaHLHb2f9S5WBuIucietvGqQf43oEfV+AM=;
        b=NKJsXX/S4mQpUzYC8hLgeAoYUivbm85cBtVbnBRHElFO5U8pnqYJ3gzrdErCG2/7vw
         alCkkN5unLXdODOiz1AJojgJANOjE8nQQe4sVH8pHrigW4Mqb4KL+O+kOPYsNsW8x53j
         cXNK7wb+nbrkIkWcszOxzgBpYn1qEIYLt+GguFMb6IiqClMoOkqioRWa/2WarfV2fIeg
         NJKzWA1q7j9L3HyrSZtY05j1LCh0HOPOXBRAZJJ2rG7JNt8dWhgXabTdLzqQw8nfC3G1
         ELQhC7atiF4v2ep+YPIwUR0MEiE5+4YJMlrIte36Cmhl3kduZ3UwG7WDO2trn82EM7SA
         iXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745928343; x=1746533143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r/4N+f+7PaHLHb2f9S5WBuIucietvGqQf43oEfV+AM=;
        b=oeEVCtMIHXXZmu3cegknYjUxdXGMhZ9VAb7P/5oV30l4In2xaofnsb37todYbB//JL
         up3t8252G8l3pPy0J9oJePIvGAa0uH38aggR4wRQKirMZypdRelEzok1cghHxSKP+jxS
         zWEBGLIXeZCIZHR2ISs4vsBGbv54hiG+RGMvXpBoQRd4RlQV31PmX0I5jIfQMaPwtAhF
         42fjVusMVN6dcG0QtvkgWysrz0qhhdjXKrRR2g4E5T5bNuF5RY9Ux7rDO0XmjInEYCOp
         8U0Mg0DSiWOy7LdflcEL0Xnddlc9CjiHPxN43/mel0botnwmRx0vHKVKTqjmCnR+OwVZ
         QmPg==
X-Forwarded-Encrypted: i=1; AJvYcCUqOXHLxkN8gfjGY4qhM+UpC+QL8MQ3CqlAIXsk0h2B36H6B5Q+C9cb7CxRyvi4XPVX4nPazRYc@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCWRtKhM3HT0+xDym8IrGlXPqwv4t9QYSOGxDEc4AmZyFCNBL
	/tRr66DwDCiQNq6FkqJeV7dyKFTa5ggcaQ49ko7HkNOL+9BZ6Ja90axwc5gzXso=
X-Gm-Gg: ASbGncvNo4UIIzcX5ppbbZoMexmwvBw0HdKdGSbkS/o9lwB9j/cOulaiMzMRn9AT/kI
	uw/kLc7o187SWjbq2OP2yCkzsXkvQAG9p5adzdZ3Sps2EwnI8lGqQDdTMDqYy5ZDzg1urqFXyg6
	pVtj2vp+CDTD8dXXXpcvkWCBH0ykxtH3XBj155nlR86coTdB8yLByML16lAY0LyBhDlsXiVRJXF
	GBk6fjqdEX1Q3yG1c+WB2mQ/Ex8j9AGmKuJUx4s+d3qYCyiwxlOlOyU70mEIl7f2SE/99HkWCr7
	qarwrUysK97XZ28hEPgfiAO0wdP2xKfy4oXXEFnFM4c=
X-Google-Smtp-Source: AGHT+IHmuO1Gx5rMmBnuAer3bucqMZAIYa2NRJ4DgmXE88/sxb/L8pifgAqHItutkUFGsnCnWrzcmg==
X-Received: by 2002:a17:907:1b0e:b0:ac2:842c:8d04 with SMTP id a640c23a62f3a-acec4e0506fmr403932166b.17.1745928342825;
        Tue, 29 Apr 2025 05:05:42 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e6a05sm778144466b.57.2025.04.29.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 05:05:42 -0700 (PDT)
Date: Tue, 29 Apr 2025 14:05:40 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sean Christopherson <seanjc@google.com>
Cc: James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, David Matlack <dmatlack@google.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] KVM: selftests: Build and link
 selftests/cgroup/lib into KVM selftests
Message-ID: <gbuucm74bt32ozem6o2p2kd26xwnwpizbk5ihrwr2swboblfio@jw7pilz2pjjr>
References: <20250414200929.3098202-1-jthoughton@google.com>
 <20250414200929.3098202-5-jthoughton@google.com>
 <aBAlcrTtBDeQCL0X@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52kytrr5hdefn2m4"
Content-Disposition: inline
In-Reply-To: <aBAlcrTtBDeQCL0X@google.com>


--52kytrr5hdefn2m4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 4/5] KVM: selftests: Build and link
 selftests/cgroup/lib into KVM selftests
MIME-Version: 1.0

On Mon, Apr 28, 2025 at 06:03:46PM -0700, Sean Christopherson <seanjc@googl=
e.com> wrote:
=2E..
> E.g. slot this is before making cgroup_util.c a library?
>=20
> --
> From: Sean Christopherson <seanjc@google.com>
> Date: Mon, 28 Apr 2025 17:38:14 -0700
> Subject: [PATCH] selftests: cgroup: Move memcontrol specific helpers out =
of
>  common cgroup_util.c
>=20
> Move a handful of helpers out of cgroup_util.c and into test_memcontrol.c
> that have nothing to with cgroups in general, in anticipation of making
> cgroup_util.c a generic library that can be used by other selftests.
>=20
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c  | 78 -------------------
>  tools/testing/selftests/cgroup/cgroup_util.h  |  5 --
>  .../selftests/cgroup/test_memcontrol.c        | 78 +++++++++++++++++++
>  3 files changed, 78 insertions(+), 83 deletions(-)

This reorg makes sense to me,

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--52kytrr5hdefn2m4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaBDAkgAKCRAt3Wney77B
ScQbAQCK3C6jnGaSeFIPYQcKO55mROcnzexc8fp4M92Ozbpb1wD+PM1uo+nC/F3w
HBvm09u1g8FO4HnRhVxrvuDQzXj+pAY=
=SDcj
-----END PGP SIGNATURE-----

--52kytrr5hdefn2m4--

