Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A32790D6
	for <lists+cgroups@lfdr.de>; Fri, 25 Sep 2020 20:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgIYSic (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Sep 2020 14:38:32 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54234 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYSic (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Sep 2020 14:38:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CA3DF1C0B77; Fri, 25 Sep 2020 20:38:28 +0200 (CEST)
Date:   Fri, 25 Sep 2020 20:38:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Minho Ban <mhban@samsung.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] PM/hibernate: remove the bogus call to get_gendisk
 in software_resume
Message-ID: <20200925183828.GC7253@duo.ucw.cz>
References: <20200925161447.1486883-1-hch@lst.de>
 <20200925161447.1486883-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20200925161447.1486883-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> get_gendisk grabs a reference on the disk and file operation, so this
> code will leak both of them while having absolutely no use for the
> gendisk itself.
>=20
> This effectively reverts commit 2df83fa4bce421f
> ("PM / Hibernate: Use get_gendisk to verify partition if resume_file is i=
nteger format")
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/power/hibernate.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e7aa57fb2fdc33..7d0b99d2e69631 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -948,17 +948,6 @@ static int software_resume(void)
> =20
>  	/* Check if the device is there */
>  	swsusp_resume_device =3D name_to_dev_t(resume_file);
> -
> -	/*
> -	 * name_to_dev_t is ineffective to verify parition if resume_file is in
> -	 * integer format. (e.g. major:minor)
> -	 */
> -	if (isdigit(resume_file[0]) && resume_wait) {
> -		int partno;
> -		while (!get_gendisk(swsusp_resume_device, &partno))
> -			msleep(10);
> -	}

I believe point of this code was to wait for resume device to appear
-- see the resume_wait condition. It should not be simply removed.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX245JAAKCRAw5/Bqldv6
8nqrAJ9qEdwnZpnNgalnaGH1r71lg+ujCQCfdWZzlCzS9I0pHUwKmZCAgAYm75o=
=9GW2
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
