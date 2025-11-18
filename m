Return-Path: <cgroups+bounces-12070-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09041C6B0E7
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 96CA42AF7F
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFAA350A1A;
	Tue, 18 Nov 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PMeOj8Mz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A1349B19
	for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488351; cv=none; b=jESxSs63g09Xj8nwdmemMVD0DxBHex4qJ8jJlGqSv50E62ouqGloABvf2uG7JGKmBu/0f1dBYCSkDydhgyhZK9Oojsvh///UPgakyVSXSgjRSrbCLkKD8YRuN0gaP12iAbK5RpP0IL3hLvJFl7dDUXOVX19yPOTpMiBrr8r73/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488351; c=relaxed/simple;
	bh=9tDLmEl0AlG+JlkcUzxp8d7AUiUIQj7FJpPRHfm9nJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u91WDPYErfnuqIZDUiIiqr6Qw/eem9qs46IlbHgX+CNq2f4Ma3XBgA/ks4HZAyfl0Pg4cD4tDX/DWgGGCToXxVvQpzzHlFT1TrqN3P3EguiQBCNlScMqncTUOxLXK2kT5dijV7ZAhwxI9b8lPdYautIF56SiCJEzkc/gd90OxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PMeOj8Mz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so35760115e9.3
        for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763488346; x=1764093146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaANC36yaZF4chZG7yq+ENtiQcLbr4MDM5mx57OGjSU=;
        b=PMeOj8MzQU9TjG+chSwzqc/g7OHOg4GaivoUcenfMSZc4JEgEBtb1cp7oDh5WUO9oy
         cVxmnn5mud6VwYvHx1jGRBKKpIYFaCsnu05YmwcclYInW5MpkmChcyJmy/qam1YI6UFj
         lVjjHJwiT3nOOe6ZuRhExPd+BYL3cnRdJ7JSiMnzblOGn40JKzwdok7/BKByQu2t010Y
         kfBBb9imbGWqoy6PR70gl3ldcqR1y0yhTPh/3d2eSuxCmOtR/mXc7XQkGkF2rFahho9R
         Jx+6LHWxsjY66cEhwSLQ4SZCtpeeZoFFXv+dg9JWwfwWZJHfx/xaF7srp/QFutfiVWK/
         AhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763488346; x=1764093146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaANC36yaZF4chZG7yq+ENtiQcLbr4MDM5mx57OGjSU=;
        b=AZ4LGw1K6gS6tmU2HG6mquJxku9C+5Al+ZMWZCiraBBBSR53JBfTXTd/Ej/l7+6pLr
         4PSGCaqAw9+ROpOfztOmLgBDj7hUF/e4RB6VnkpVu3Jp1VoxD37aGExqP3NkKmPcKf+t
         hM9WSGjmPgugvxJsibUJsqqgCk/W1uNqTJY29Hv2uqTVAiF1PIFjtsvzQvFeNcN9FMt4
         UqSIGRCaXUFlAB6x66/j0wNMREz+gO5KW4zLi4vIoKnjEBBtGEiRBYHwWTmoHwYpKPC/
         QHoyhDpkG8qTvz5wDKOgLGDOiSYkrzJzl8lkfXzwX9PjxifNIEEzCykkTal6HALuTO1i
         XB1w==
X-Forwarded-Encrypted: i=1; AJvYcCVLbvm/BUDl34sSCPOU20lLtxzQHfhrNpMA7+/FkK3yYOQu1oDojasgsQY274Hbnt7x5b6hhUhH@vger.kernel.org
X-Gm-Message-State: AOJu0YyajC8rD22XuCO0lzZn0bYPFz7NK6StDLdXDIQh2Vn8tBIG/Hu+
	qwnyaQRSZB6rQum7pcRfZkqC/fLapGvrW/0v2+WEiT/c94SacPdsHL91Z6Rv3CMQVHY=
X-Gm-Gg: ASbGnctMN2bbYR1vF2t+TfSPaHpZYPbEJzHH1Y5fQ/XBCDFeO5FnBHZB/mF1icFMYde
	7v+G3cg33WsuMSwAz1PeEQLKKbNC/MYvGUjoLMkqD6RMXgsJirNvFpAQ8vWBWc3w+dbmuGO4MN+
	D4GNY8sRiIBSR4ZH7+QKSJgMn8t1MG2tr695dUej0gXgcqG0T83Nkic7wm6npOm3Cso7L68z/nD
	bogmXhAibzPzNwvrlwzZxY0q0BqSncxncvapq8XuyngdHKEZ5YCESUknAo6fMczXWROtkcGeLmo
	F52wMF7PFuJiK03otubWclSvB/0a8qaKqF6WATG2m7IwlHkn61tUi7MdVf++aciF3IlaVGb8pNU
	X7bPEbgGU/0mkFu8w/q1bwNw5PZyNqgFCiGGz3grr7g3ah0rQ0aLGeL+rjT/dAWwItcRx8eW4c5
	nsvD195hTE+mTBgNmSV9VvaJENYEpmuig=
X-Google-Smtp-Source: AGHT+IFUj6UETFT7esarzT9wjbjzFkPLV1Vezhy7cP2e4tBVdvrdSt2otb6qr2e+Rrdr7C4erQ5TWA==
X-Received: by 2002:a05:600c:4712:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4778fe9b36emr155621345e9.24.1763488346164;
        Tue, 18 Nov 2025 09:52:26 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d21591sm23572965e9.2.2025.11.18.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:52:25 -0800 (PST)
Date: Tue, 18 Nov 2025 18:52:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, chenridong@huaweicloud.com, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
Message-ID: <mcpsxwjouoxfgdoqbysxlvjrgx7m2475y75fhssz4uoryb3jqj@lnigmwq7nage>
References: <20251117015708.977585-1-sunshaojie@kylinos.cn>
 <20251117015708.977585-2-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yqudl6qznctquhdl"
Content-Disposition: inline
In-Reply-To: <20251117015708.977585-2-sunshaojie@kylinos.cn>


--yqudl6qznctquhdl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/1] cpuset: relax the overlap check for cgroup-v2
MIME-Version: 1.0

On Mon, Nov 17, 2025 at 09:57:08AM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> This patch ensures that for sibling cpusets A1 (exclusive) and B1
> (non-exclusive), change B1 cannot affect A1's exclusivity.
>=20
> for example. Assume a machine has 4 CPUs (0-3).
>=20
>    root cgroup
>       /    \
>     A1      B1
>=20
> Case 1:
>  Table 1.1: Before applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member      |
>=20
> After step #3, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
> remain as "root."
>=20
>  Table 1.2: After applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>  #3> echo "0" > B1/cpuset.cpus              | root         | member      |

OK, this looks fine to me, based on this statement from the docs about
cpuset.cpus.effective:

>  subset of "cpuset.cpus" unless none of the CPUs listed in "cpuset.cpus"
>  can be granted.  In this case, it will be treated just like an empty
>  "cpuset.cpus".

I was likely confused by the eventual switch of B1 to root in your
previous example.
(Because if you continue, it should result in (after patch too):
  #4> echo "root" > B1/cpuset.partition       | root invalid  | root invali=
d |
and end state should be invariant wrt A1,B1 or B1,A1 config order.)

> All other cases remain unaffected. For example, cgroup-v1, both A1 and B1
> are exclusive or non-exlusive.

(Note, I'm only commenting the concept here, I haven't checked the code
change actually achieves that and doesn't break anythine else ;-)

Thanks,
Michal

--yqudl6qznctquhdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRyyVhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjW9QD/c2y0ArZIX75uJ7oNlCG+
+AR0L7BKrnxC/iw8IDwHzwUA/jZoh2yJaEM+blH9V1++aGv6PORbyXfY/6FSFL6u
ZUEF
=v8ne
-----END PGP SIGNATURE-----

--yqudl6qznctquhdl--

