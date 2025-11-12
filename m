Return-Path: <cgroups+bounces-11873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8957CC53C8E
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5025B4F86B0
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154233A033;
	Wed, 12 Nov 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oav3pmLB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC533F8BE
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965946; cv=none; b=gU5ucpt+kKizqf1awjmKrYD+j6RhApg+RkRlJ4WzIcgo1/7T4BjvNGmGBGQsnFv8ptMr0FfXhaSplBFFfr/jef5Wr/8tBBQrrOpXBn6Q/XA9Af+XJzabPRSKsiHzgKd2F300yC183wkj107Jv+WqKrXQs2ZH2ShULf4ZV0Zcswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965946; c=relaxed/simple;
	bh=mrms1Y0FF4oeuzw6Vlkus1NZl4UIjBZVDt7oBA4rGlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNbgZeYp1wTy07F0BspozHmhfgN80KzZ8e6Lu9pqTkyM5o3HBbFtRRXsOQ/FculmW0XrC4jfTq3kKWN5taOJoDfWfOISkn5JJ51iRbxV0VauulzyKYujONzKuIYuNAqJT0mLuXXAUZH5WfMh2kB/jzgusQcysJhr5bkWRxGmP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oav3pmLB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4774f41628bso5551455e9.0
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762965943; x=1763570743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57DHveCKRDAAu/0DboOir1PvEtk98bXbctkvjG3ObZI=;
        b=Oav3pmLBR/VSmg5gQXM4hSKqgQ3RLoG7UGCgEraiVyh6sPaDf4AUbx/q+IGpUtoGAL
         UvOjGk1asBtUpmSl2yVRY9/1VghcTi7ahfI+LeNgX/5+cRo66Qy9/13L581qz5aT4DB4
         +ABoCj5L7ER7D5BZ/i5BZN6BE1nlcY4Ad8AJ4JAC9taz5OfFiVnOjj36opvQV8wvU4I4
         wnyHx4O1KxwGP0HYsFYrsCoKlrPKjyEriI62lnN+I90V8Wl0bp7JOudAUFeIQ3GGUG+O
         5/2WIUR371L82AF7pO8Zuz8ITQXEvV6PLsFDELeFd2sd8rDF0hlVRiro9TWxKqxedrSd
         jIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965943; x=1763570743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57DHveCKRDAAu/0DboOir1PvEtk98bXbctkvjG3ObZI=;
        b=dSvqL15Uh3X3eDE4Vd02uQnjGShkpjd5BxO7g2i6U5+JQgdQwyDgNboOP1xGYCjPPg
         g8HWF33ikXIirH7zSaoKnNqxC0W8sCarQhbIWaM7d4tvuBfqH1oQYvDN/+T7ASQnRYvB
         V1PotHfUzN6Jc+t5QtvDvwe4IVl9satBnsuBtjt/SSOc1SDmsp5nMLM8wS2p+lazLIGf
         5Cg1w9nP2EctYdV9eusmXj1j8VYv+rkx93efSlLhVhwgRYSSxUqFqYu+vWMQ2PkmVOPU
         U/9eitah4caydz91ogV93zZojeBwHRpZCLdGKxATZoq5A6jJdmdTTQNwQrF+JtR24nD5
         OMJg==
X-Gm-Message-State: AOJu0YzYbCvo3zDKe3CmKizzF0ZCajmbJ72wt8A3rXFL1EzHBul61qlv
	FU3ljEDg5pvnxN3myEmDQUplPMxpVDyR3tOcQji58kzHA3PdSHntbhLU1nr0SFNqFZI=
X-Gm-Gg: ASbGncvtiIzGzdanJm6RXFCXwyWQvHl3Rwg6L/Cuhw0TtOIIw568hzWHER47z0fKWMr
	zFw0wZXWNNXpyIjxfE662JFig0c/Xpp9g2EeQYncgayuRSAZORkTIcQHJCqG6nUzcn6Izx1YBjt
	4V7wyK79TEP1KusijtIvtJAxIReufXrkXiPiHjpqwrwyocgpn4SJ8DAcgeU3Z5Kz2pYSKMcTEuX
	ihI6skVauCleGgePHcDTVm52EVnLv8QHUl5uOl2F9Y9sMa+O8QbZFxib6rCXZi8u40hlJ+ZSgXd
	+eHo7UYarqdnFzkwre4LlUIGHTx4fhDh+2cFm3z0+1su4fSuGIew/M+lo2qQEVL8eFBxCa5C/78
	gZZcYPN2JxM/Lpa9TDWaeTn0zSTsY6QmeoVCoWWzqI7lpj863zpBxKgCpTKPH4BqVJTvoElTpk+
	2yExIF44E5S9bwjLp0Y+LK
X-Google-Smtp-Source: AGHT+IFQXLMrEx30t4hwNSVEd2QumJLY6dgWFZrET7jEh3qWfu3jFyuQCUb4gp10XkkqiunyUxnBSA==
X-Received: by 2002:a05:600c:1c09:b0:477:8b2e:aa7f with SMTP id 5b1f17b1804b1-4778bd33684mr84695e9.5.1762965942740;
        Wed, 12 Nov 2025 08:45:42 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm42740225e9.12.2025.11.12.08.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:45:42 -0800 (PST)
Date: Wed, 12 Nov 2025 17:45:40 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: cgroups@vger.kernel.org, Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH 2/5] selftests/cgroup: add metrics mode for detailed test
 reporting
Message-ID: <eao6ca3utjomc7potzhcvwn4sazdkhgy4szojzfyw4i4ibdz2x@6bxc2uaup4so>
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
 <20251022064601.15945-3-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="twxx6ztssvqr4gah"
Content-Disposition: inline
In-Reply-To: <20251022064601.15945-3-sebastian.chlad@suse.com>


--twxx6ztssvqr4gah
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] selftests/cgroup: add metrics mode for detailed test
 reporting
MIME-Version: 1.0

On Wed, Oct 22, 2025 at 08:45:58AM +0200, Sebastian Chlad <sebastianchlad@g=
mail.com> wrote:
> Introduce a new "metrics mode" controlled by the environment variable
> CGROUP_TEST_METRICS. When enabled, all calls to values_close_report()
> print detailed metric information, even for successful comparisons.
> This provides a convenient way to collect quantitative test data
> without altering test logic or recompiling.
>=20
> Example usage:
>  CGROUP_TEST_METRICS=3D1 ./test_cpu
>=20
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  tools/testing/selftests/cgroup/lib/cgroup_util.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/tes=
ting/selftests/cgroup/lib/cgroup_util.c
> index a8fe54eb38d1..32ecc50e50fc 100644
> --- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> @@ -2,6 +2,7 @@
> =20
>  #define _GNU_SOURCE
> =20
> +#include <stdbool.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/limits.h>
> @@ -21,6 +22,15 @@
> =20
>  bool cg_test_v1_named;
> =20
> +static bool metric_mode =3D false;

Such variables are zero initialized, no need for explicit initializer.

> +
> +__attribute__((constructor))
> +static void init_metric_mode(void)
> +{
> +    char *env =3D getenv("CGROUP_TEST_METRICS");

I was looking at other selftests whether there isn't already similar
concept, I haven't found anything exactly like this but I noticed some
tests are affected by VERBOSE environment variable.
Would it be matching here too? (Not to introduce too many new
conventions.)

Thanks,
Michal

--twxx6ztssvqr4gah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRS5shsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ahg9gD/dpFa0m6+0ahAwSDaEm1T
UR9PCyYtEHOmXNIkY3XsMS8BAOTSM4JRs2lljlFh93OtdZI7+C/xpEWhP43WiW6M
SwQA
=q7H0
-----END PGP SIGNATURE-----

--twxx6ztssvqr4gah--

