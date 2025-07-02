Return-Path: <cgroups+bounces-8667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370DAF15C0
	for <lists+cgroups@lfdr.de>; Wed,  2 Jul 2025 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC0B3BCB55
	for <lists+cgroups@lfdr.de>; Wed,  2 Jul 2025 12:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E043266B72;
	Wed,  2 Jul 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OfaPKYw2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340026A0EB
	for <cgroups@vger.kernel.org>; Wed,  2 Jul 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459676; cv=none; b=PgV7V3664GJdEsc2Rp63o0dMJGBn2GFbTeIxq6tNSGKjoijtllsS4Yl25Lg0QJdlabcxcIXCCY3xHXDDeQma5GMP3zIrgk7C7GX+9uRrWFKdGbJHpHV0q69olRk1g1sePdcrPF5x4NW2vWwoubeAMwcX7QNFeUKp8hQbBvH647M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459676; c=relaxed/simple;
	bh=w4Nwr3rzBU8oAkSw6PUTnXCWYhJ7PZRyve2lIpVTSKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRZ12VTORxL1Kqtwhz7sQNxGnkwDYJprJO8TeCeJ/ksjTRh3XDShEOph9ZPClE6z6W6mN/SJODmrCkanKz8SxYNTueP4mFirqaXaCaYzEHkj1ru1jEzWXoDxeKwX4UhiGExgmGW/HAw1EJQsLKLWW/+YYu+eGokuVtccvcNQfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OfaPKYw2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so4059733f8f.3
        for <cgroups@vger.kernel.org>; Wed, 02 Jul 2025 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751459672; x=1752064472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYauURT58UhCHylTptKqbdFltvK7gtU+BWTcrPEHD/Y=;
        b=OfaPKYw2cYcn/F5xoa+WPeE5QukO7X43r4yI/zGjhIlRFVN1/WcVa4CaKMdHRCW5wn
         NU7ILLUzmQPzN8yZ7QcGCFftv9uxl8qvVvqgDUH55Hh/HgKHEkYirh1SNfvbOMVTNpuE
         05Irdjn1+XK2Br63ppVnMjra6aXvCtVg3rCfq9PYfIaQaRyAH67FHaMm6oPBx8HtPZsu
         oWFl7mwrstoIwbajC9Gi2fRdoQhyHkzWjjVVscqEgl+w/zXrXBPnKrXbawdNh8LoNgRY
         e4s+6oo4KX9irznTFMh9QjDbILRcz/+VS9FUGNMX6oxnFw36Zbo+1qHUZnl3gLhgeXDL
         ALlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751459672; x=1752064472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYauURT58UhCHylTptKqbdFltvK7gtU+BWTcrPEHD/Y=;
        b=Aj+xC149DmuwyvMBELwLU2mKN6OzpUj+sbeRMGDEDuf2tagSTaev9r51qN14BevaMh
         ctevumPgfk6effE8e5tGPfnoTU4yRj9PGYdshhi17Oyvb9owYXDVJ2TxE+4R2B2ZJbCz
         6ymWks+L0/4tf9lwwqGd7w0fcEowcz+zk1a2dvqbxbsLZDlcQxFO36FpZjcncWe1BWHr
         SPp4cxd4+f8FyPofo1kNLbLfqPFDAzW4+ypRTG+z/wPX+PsTt53gIWnXdpN3lUwHeFVc
         6kEXa5PvDd6H9oP41wdkLyBz9uNoii3PvA+gMk9WpyHgFlP3OLrphTdLlDX4phVbwdCH
         SHZA==
X-Forwarded-Encrypted: i=1; AJvYcCUa7o2qFAitfsSLfEnsZrWOE0jtLmc0US3LT/F+HlRymosR7Fm8/EWtAhEa63EIquM/18pC6589@vger.kernel.org
X-Gm-Message-State: AOJu0YwtKC7EgN5lh4b8R2H8FxkwTWwfZBIIeISuyxE4CSlDU29ZuEoe
	Ej51oL/GQz2TrOHU88eqX8W+rUhVmaqmfmJZzIXkxX1i8Ylc8l1UuQmXES0TdhNBNuM=
X-Gm-Gg: ASbGncsYvW2Q/SmQTPTh6JQSkxJLpydRyTOhQjOmO2ZAy8Icw8tTUwSDbmI9jgJzkf7
	loo6RsGHfABK9I3POWLhgkkplOWtxhQdati+M+gm5cuNGqFTBEY1zsWN3Qy9tBgTCQweHWeVXB4
	on9ss1zYouXkWJ5UMxjnrvODV3ZtpwuTkW/QYOpB9nssCOhSAdv/kmfG/DPVoe8VvApDhu2Mzw8
	mW5iDXjgVQY80SgpZn9fTPqMAnMMfn3xNFIEA4ZAx6cQJSWodFvAOTPJFrDBAUncwF61F0HE/M6
	La1fcXMHlg7rAmrNpVApS7MT4lEBH7PE8jMDj34uDM/8VS/qWjllF8oEEPSIwwlT
X-Google-Smtp-Source: AGHT+IHpmwTSHq0ZYz8lQTm5DuVgf5H+LAptA4zeTr6a+ZP5dC8xfupiDfgs6zU9Ea25L7XoigSn+A==
X-Received: by 2002:a05:6000:26c7:b0:3a4:fbaf:3f99 with SMTP id ffacd0b85a97d-3b1fe4c8d71mr2056593f8f.13.1751459672276;
        Wed, 02 Jul 2025 05:34:32 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5a3sm15800036f8f.40.2025.07.02.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:34:31 -0700 (PDT)
Date: Wed, 2 Jul 2025 14:34:29 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH 0/2] selftests/cgroup: better bound for cpu.max tests
Message-ID: <4bqk62cqsv3b4sid76zf3jwvyswdym7bl5wf7r6ouwqvmmvsfv@qztfmjdd7nvc>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="smuhsidh4jj2dmo5"
Content-Disposition: inline
In-Reply-To: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>


--smuhsidh4jj2dmo5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] selftests/cgroup: better bound for cpu.max tests
MIME-Version: 1.0

Hello Shashank.

On Tue, Jul 01, 2025 at 11:13:54PM +0900, Shashank Balaji <shashank.mahadas=
yam@sony.com> wrote:
> cpu.max selftests (both the normal one and the nested one) test the
> working of throttling by setting up cpu.max, running a cpu hog process
> for a specified duration, and comparing usage_usec as reported by
> cpu.stat with the duration of the cpu hog: they should be far enough.
>=20
> Currently, this is done by using values_close, which has two problems:
>=20
> 1. Semantic: values_close is used with an error percentage of 95%, which
>    one will not expect on seeing "values close". The intent it's
> actually going for is "values far".
>=20
> 2. Accuracy: the tests can pass even if usage_usec is upto around double
>    the expected amount. That's too high of a margin for usage_usec.
>=20
> Overall, this patchset improves the readability and accuracy of the
> cpu.max tests.
>=20
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

I think you're getting at an actual bug in the test definition.=20

I think that the test_cpucg_max should either run hog_cpus_timed with
CPU_HOG_CLOCK_PROCESS instead of CPU_HOG_CLOCK_WALL to make sense or the
expected_usage_usec should be defined with the configured quota in mind
(i.e. 1/100).  (The latter seems to make the test more natural.)

With such defined metrics, the asserted expression could be
	values_close(usage_usec, expected_usage_usec, 10)
based on your numbers, error is around 20% so our helper's argument is
roughly half of that. (I'd be fine even with err=3D20 to prevent some
false positives.)

I think those changes could even be in one patch but I leave that up to
you. My comment to your 2nd patch is that I'd like to stick to relative
errors and keep positive values_close() predicate that's used in other
selftests too. (But those 95% in the current code are clumsy given two
different qualities are compared.)

Thanks,
Michal

--smuhsidh4jj2dmo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGUnSQAKCRB+PQLnlNv4
CK12AQC617NY4Bgg95KOUtRUliBbD467q6iN7i8UX5uw1TDHPQD/YDZ9YQbLmR8s
aaGAL35x9nFcbe50VlfD5NyVDwbVugI=
=ntIR
-----END PGP SIGNATURE-----

--smuhsidh4jj2dmo5--

