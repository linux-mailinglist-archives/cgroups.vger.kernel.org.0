Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A5844430
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2019 18:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfFMQfX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 12:35:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41997 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbfFMHmw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 03:42:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 127DF80345; Thu, 13 Jun 2019 09:42:38 +0200 (CEST)
Date:   Thu, 13 Jun 2019 09:42:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au
Subject: Re: -next-20190607 kernel: oopses on bootup or shutdown
Message-ID: <20190613074248.GA6161@amd>
References: <20190611085753.GA12364@amd>
 <20190611132536.GE3341036@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20190611132536.GE3341036@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-06-11 06:25:36, Tejun Heo wrote:
1;2802;0c> On Tue, Jun 11, 2019 at 10:57:53AM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > It failed to boot three times; now it booted but failed on shutdown.
> >=20
> > Hardware is thinkpad X60 (32bit x86), and I'm copying oops by hand.
>=20
> Can you please try next-20190611?  It should be fixed now.

Seems like it is fixed.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0B/ngACgkQMOfwapXb+vIDPACcCWfUfp5L8ccnUUgw9v9QDd90
Y4YAn05D4kjSCB0W6GLdPNx2uiFHavkc
=uPDn
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
