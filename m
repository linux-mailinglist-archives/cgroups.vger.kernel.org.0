Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26DE269F4
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2019 20:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfEVSgQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 May 2019 14:36:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60089 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVSgQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 May 2019 14:36:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6221680477; Wed, 22 May 2019 20:36:04 +0200 (CEST)
Date:   Wed, 22 May 2019 20:36:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lukas Prause <langspielplatte@black-mesa.xyz>
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        rjw@rjwysocki.net, len.brown@intel.com, rostedt@goodmis.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-pm@vger.kernel.org,
        Lennart Glauer <mail@lennart-glauer.de>
Subject: Re: [PATCH] Fix comments with paths pointing to renamed or moved
 files.
Message-ID: <20190522183614.GD10003@amd>
References: <20190521155430.14941-1-langspielplatte@black-mesa.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <20190521155430.14941-1-langspielplatte@black-mesa.xyz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-05-21 17:54:30, Lukas Prause wrote:
> This patch corrects renamed or moved paths in comments.
>=20
> Signed-off-by: Lukas Prause <langspielplatte@black-mesa.xyz>
> Signed-off-by: Lennart Glauer <mail@lennart-glauer.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 9e58bdc8a562..5de8b0c7f657 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -182,7 +182,7 @@ extern int swsusp_unmark(void);
>  #endif
> =20
>  struct timeval;
> -/* kernel/power/swsusp.c */
> +/* kernel/power/hibernate.c */
>  extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
> =20
>  #ifdef CONFIG_SUSPEND

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzllp4ACgkQMOfwapXb+vJZkQCfeKwSOh2FKYaMG98zV3Dzre+t
L5cAoIt7HOw2sWn9bbsMWeOfbg1PjNGy
=AwUp
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
