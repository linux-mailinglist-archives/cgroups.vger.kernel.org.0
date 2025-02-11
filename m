Return-Path: <cgroups+bounces-6506-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65347A30DCF
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 15:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8277A3119
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEC24CEDE;
	Tue, 11 Feb 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZwELRqUi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5D24C67A
	for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282986; cv=none; b=aUGg6cFdH01Knp/W+1Gv9ER9hCoSHNd7Tphuhr/hZbBy7iDlAq197B4MPs+e136edhnvbib3R4HA6hRbREnk4n93QYOmwV2ru3gt9P5rwvZJbWgsepufP+GNvlmkT7C/q/xqKhVrg9kqTIC3fUtP5r/NmIu+SMJ0GpQBzN1VXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282986; c=relaxed/simple;
	bh=gzPr48ZVkkfELeWekydsxFqDfYNLXetRXKYYCbvXUPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es/LdL8P2rel4hFrJCuy9HcEel5E09dn+J/qpiWNLuwNUMluNIZCxjMeejpdJunBY/DQFb4oG8nWHw8/5/58faYG+xf+xNw53AFaxyIqMhMo+Bm+7pvbXL4QElZKlGNj1urfb04aRj1e7Krz0PloHyaArew+uqljH94qy0+Ovk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZwELRqUi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de6ff9643fso4774667a12.3
        for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739282983; x=1739887783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzPr48ZVkkfELeWekydsxFqDfYNLXetRXKYYCbvXUPo=;
        b=ZwELRqUiKrMpJ72b0YjUyQuq5JmDLT8bccAyAV4CZog9/LVTdQt8NvS3624QISeKF8
         psPQ56jshMitSH1yVJmBfPzaOJ3+skmgUkS+JEZBxB5UYnuEJC+vLMh6Blat4AlRQhQj
         ZajNmH4rMpWaVxPaTYzC0k5eSNKYy/piScsc46OQSnfcjz+xd6Zgu2v/YjotId7SSui0
         2uUNVWswN0+yN52/OVUzae1fU1pQ0SjKwEvDG6WYbDaJXMGlNf6gABMVWH6wfjuZgB4l
         d349EFYxALdi5medWevfa00rNIvgnip4aeKqcrZNgVyUteCcPe5nZe/j+HKXwzpOuN4k
         cD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739282983; x=1739887783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzPr48ZVkkfELeWekydsxFqDfYNLXetRXKYYCbvXUPo=;
        b=l3cXVEMjjQDdl9B1yPSd08L6PIi09L1PSJNQqvpmfr7elbji10U4XyB3veT3pNK5vz
         PVIckLcqadZggP49w2EAV0Ob+ZxifmZkI2hORaVVhr3BRYslSzE8aH8crlL729tNGcL+
         5uguwbkIJE6CFncuJXYhW957MOTOSviuwZUj3GY5x2GhEts0XzJh5z1485qYQmZ3/A+U
         kM/2K0Pgz+xUmvCT5o8v0m98Jou6ISvnIIMJjrITZAaMgbgN3UWYSgDikTUjpaum36wu
         TBp3Mj6h3FeP5o+RMbkCTwVO296mGiPTUpxoZVUbyOqfT4p2RTulc85s3MT9RHaAHZ5s
         mACw==
X-Forwarded-Encrypted: i=1; AJvYcCXQZKx/Aix6BPBHLl2oruqlFmEuPqyWIgHEQYruQyRMPOo5OShQAb/F//O9FdwcapYl9tdvjXaq@vger.kernel.org
X-Gm-Message-State: AOJu0YyzddLCCdY7k3+//fm7wtyxw0o4no17aLfpeUSPFVG+QbWi21Xp
	RiWDgE/VNRz+R27wKH9KZH3PU+H6uKwLnTE0HkFlyKiaO82x3IfsFNNn1myEUsc=
X-Gm-Gg: ASbGnctQ4kn7QvIZbUJy95ZhrERSf6P3vlwvsd9ea8Zcu59csJitkLQrJjzQv6ko7vO
	afOtF5uO2h2pxxeaQPsRL63RtE9SnO2yokiyoWQM5CJZfcupsmav5MOJhaTDKaihmRnYlmUDkCD
	ILpEwGLuzYOCoIjqZT28tP0zPMAN4kmbQBrrWjPYgVGuYY42VjNAI0nMH5IVeNRD0VgktBVvS5q
	xX1OeZfDINQoeYLZdA7Wq+46no61EZn88vR2vXX6IjNHWZQhK/O0iEXPDxek5zdHtW3+JYTDCgK
	OwKv+2M0CKC8OgJoXQ==
X-Google-Smtp-Source: AGHT+IHbzo7gzW1TGGADGeSXW3cTzBVGtenI66+tOJ/vbJjB6aL3crDJ+y/TLZy7jx8zgR2NlYS5Ng==
X-Received: by 2002:a05:6402:43c3:b0:5de:45b5:bacc with SMTP id 4fb4d7f45d1cf-5de45b5baefmr17804385a12.20.1739282983008;
        Tue, 11 Feb 2025 06:09:43 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de6e5880b6sm4969773a12.37.2025.02.11.06.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:09:42 -0800 (PST)
Date: Tue, 11 Feb 2025 15:09:40 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: David Reaver <me@davidreaver.com>
Cc: Umar Pathan <cynexium@gmail.com>, tj@kernel.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Umar Pathan <cynexium@proton.me>
Subject: Re: [PATCH cgroup] https://github.com/raspberrypi/linux/issues/6631
Message-ID: <uu3uzopzwhsbplpdafqmd3eep5mzrubyuo2ct5bfp56ftbjjwf@a55wr6k7n4kv>
References: <20250201095145.32300-1-cynexium@proton.me>
 <86cyg1bvuw.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lqqtfhoh6lsmyy5"
Content-Disposition: inline
In-Reply-To: <86cyg1bvuw.fsf@davidreaver.com>


--5lqqtfhoh6lsmyy5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH cgroup] https://github.com/raspberrypi/linux/issues/6631
MIME-Version: 1.0

Hello both.

On Sat, Feb 01, 2025 at 06:08:55AM -0800, David Reaver <me@davidreaver.com> wrote:
> I dug around Github and I think I found the patch you intended to submit
> https://github.com/raspberrypi/linux/pull/6632/commits/711f76376ae7e11f48a1c22a4a04828a24d6a87a

Heh, thanks.

> Unfortunately, your email only contains the inverse of your PR's
> whitespace change removing a line in freezer.c, not the rest of the
> patch. Did you perhaps revert that whitespace change in a new commit and
> accidentally only submit that commit instead of the whole change?

There was little freezing counting rework in v6.13. If you can still
reproduce the issue, it'd be something to look into. (I'm not sure about
interpretation of the direct/propagate freezing in the reproduction
steps, if there were sample commands, it'd be nice.)

Thanks,
Michal

--5lqqtfhoh6lsmyy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ6taIgAKCRAt3Wney77B
SRSBAQDqXePAIAVSyhhwQp267lealFHqVlBkn8tH6ddc3YE3DgEAu54uuv+OPlaR
mHdsDUDPgzkIiCdSS7+Z84OrTXObGQs=
=Xxe7
-----END PGP SIGNATURE-----

--5lqqtfhoh6lsmyy5--

