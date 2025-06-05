Return-Path: <cgroups+bounces-8446-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C8ACF9DB
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 00:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9647AA56A
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 22:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930E27F198;
	Thu,  5 Jun 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsTV1M3o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D428E17;
	Thu,  5 Jun 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749164219; cv=none; b=pwXoh+TOTVfxL/elpkmuetz1cQPbA6SexYY86OW8NYg6tG/QvqHwFFABzOBBw0ajTpB2r4axwmaBWsaVUnMqTwUongjZdPqIHTFe6NJqLCbQq6OmZifS0InJVjgR+y71ltxIJJnlZ2zwAI58OYKuy6+pq4NWZJ7e3/o5PcDcnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749164219; c=relaxed/simple;
	bh=W9wvLgzBpwRlr4/h5Pqc8uGzskgjGvLoJgQexId1ewo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLCqnTxjU/WZ+7CN119mT+/jk4wuxH75wndfgG8I7Cte61B54PpUtA78PC4ydMYFPR4OheWeARtsKM/8oFeK7uueXUuoBTV1i0hJeJSqOtvlZ2Xlkx7uxXjlRytvRjRIte1wsBPHFXBvYVuTRxVFiGQU1bbUEo0sY0p0QGC7aB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsTV1M3o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e1d4cba0so13091865ad.2;
        Thu, 05 Jun 2025 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749164217; x=1749769017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9wvLgzBpwRlr4/h5Pqc8uGzskgjGvLoJgQexId1ewo=;
        b=RsTV1M3ozDSUsv4nizOG6X5AfKI0rqfXTpRa1Muvh8nL6iPcH6arYPukrxwR6HegL0
         CeuHaD5kH07OmPs1kznKDOUyaVYFVpxUzrHQPAuTbmWPTpkq2EWvrHozfOcf3yXwHMM1
         OcNt7/xikbU0n7ly/c5EGRfBAEoC+ltAueBCNJ7Xh5kBWvT/UjKnaTAxDAbezSgikIJF
         A3lHCcLWtlmOdwncPPuwBcVTd/DE9GUobbjNozrojZBVULDRX29OuO7MWzmR7xCjSVmk
         +itXwOJsxVvVABRyL23UTgXXmxdD82mtTJDGKo3QaUBGAQ7VFXpZtMqyF/gzkpjGkILN
         vpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749164217; x=1749769017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9wvLgzBpwRlr4/h5Pqc8uGzskgjGvLoJgQexId1ewo=;
        b=eRLEud8m6vtJ5L/j6YpBLHL06IvXBDObrpCAs35MFxM2r93eubERiir9cKpChCEI9b
         fqByEBCamjqqZ1+K8PjAPaFitOMgz8eyaOSSLflF6eTA+cgaEudnhf4ySm3pMYh7MYha
         jD5qZc/695O5jZQIFC8ZP23cjBIwnTRn/cOxxjXFRJ7Ft4B2W+C9SB8kGFOu7HDXSGRa
         QcFzFoFFRXsP3iXd4sPocgai113UJnIiE9hy6P4h0lN78+C6qf3mE0qUhMJ/1TA+2+7p
         4NhF0lFZjR61S76FLLVIPz2evOrwCM5x2SmkiGrDuzI15mJvUTGX2PrE0677EBodpEcH
         fIVw==
X-Forwarded-Encrypted: i=1; AJvYcCU2RluOc2i23GbQ14LjTDtRL0hqQlSF+duioj0jIR8lNI/FI6/OhrCWp19jUJkDYg/6V9PRo466DgcNY8yw@vger.kernel.org, AJvYcCUOUZuS3n4K+exFtJFYDKn1oJuulZWzls3AHcMcJallj4nrPyR26YOcbqnZ6OZl54zUbxnZ+Qi/I3ir@vger.kernel.org, AJvYcCUtNubFflFDeVUf8d1b+9gz7LK0+OvO1cG07PrEmOOuPXXjehje0Jy7JMIOmrAOkykSG6mv4UDd@vger.kernel.org
X-Gm-Message-State: AOJu0YyxACv24uxFxZ/jFuoHFSS525J4ZrEzMLCJtl+LZ+88gfZA8mlb
	lQScJlescIe1lzJyezDDfE850+Ra8/SxTsvvXdBSmbuIO8ygJ71k9g9K
X-Gm-Gg: ASbGncvWF+d0NYCEZvUzzUtsgzlx+aF4vG3r8fqU70Tj1Esj6f2XDfH0+UMTZtjkRFJ
	dUpzNiMFQJesY9ctfGKlYxWCPTxU+uvvzqPADXLUGjEPxP+yPM62ZngNgnA8zhQY05e/Ttrwjuu
	BNx8oF7DOG3hZMI/01DmvfvxHQXgHwzpoP/lthpWtwaNZ2YyTzpYzJ2Wv6cUPnDcbiu8+JgpvPk
	lshSrH3jhF14j6tmEiUe1CgXZV2VAGjRJ1bxLSfRtyyz2pdVj2XNhqN8bR743vJrzQ4uaQvcTkc
	dsikkmG/qHoBjH4q7TOdMGcP+p3MlaZFZ3aeekGfxSf1Y3I8Jq0=
X-Google-Smtp-Source: AGHT+IF7aHWSDBE7OP8NbpbLMzieQT5Htocm4zHVaqcG6HRv4pd99kgqlQnHXj7COrmzwMCnUYQJdQ==
X-Received: by 2002:a17:902:ccd2:b0:234:d399:f948 with SMTP id d9443c01a7336-23601d973bfmr14933535ad.33.1749164217443;
        Thu, 05 Jun 2025 15:56:57 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603410b83sm1173335ad.215.2025.06.05.15.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 15:56:56 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0CDCA4222987; Fri, 06 Jun 2025 05:56:53 +0700 (WIB)
Date: Fri, 6 Jun 2025 05:56:53 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llong@redhat.com
Subject: Re: [PATCH v2] Documentation: cgroup: add section explaining
 controller availability
Message-ID: <aEIgtdrFbyNf4v85@archie.me>
References: <20250605145421.193189-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3nMlU14CJAHOY03i"
Content-Disposition: inline
In-Reply-To: <20250605145421.193189-2-vishalc@linux.ibm.com>


--3nMlU14CJAHOY03i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 08:24:22PM +0530, Vishal Chourasia wrote:
> A new documentation section titled "Availability" has been added to
> describe the meaning of a controller being available in a cgroup,
> complementing the existing "Enabling and Disabling" section.

'Add "Availability" section to Control Group v2 docs. It describes ...'

> +Availablity
> +~~~~~~~~~~~
> +
> +A controller is available in a cgroup when it is supported by the kernel=
 (i.e.,
> +compiled in, not disabled and not attached to a v1 hierarchy) and listed=
 in the
> +"cgroup.controllers" file. Availability means the controller's interface=
 files
> +are exposed in the cgroup=E2=80=99s directory, allowing the distribution=
 of the target
> +resource to be observed or controlled within that cgroup.
> +

The wording LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--3nMlU14CJAHOY03i
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaEIgsQAKCRD2uYlJVVFO
o+xtAP9RbHJTrpVIIXhiUHpiNTItRIIwIZVCzIZXFaOjhTwPwQD/ZQL/DLUTfLqI
ij2yh516RPu1k7N80NPmapHZ3f+YqgU=
=WD/J
-----END PGP SIGNATURE-----

--3nMlU14CJAHOY03i--

