Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2412E1100BA
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2019 16:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCPBu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Dec 2019 10:01:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:50832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfLCPBu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 3 Dec 2019 10:01:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7323B458;
        Tue,  3 Dec 2019 15:01:47 +0000 (UTC)
Date:   Tue, 3 Dec 2019 16:01:46 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bfq: Replace kmalloc_node with kzalloc_node
Message-ID: <20191203150146.GC20677@blackbody.suse.cz>
References: <1574175746-8809-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <1574175746-8809-1-git-send-email-xianting_tian@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Xianting.

On Tue, Nov 19, 2019 at 10:02:26AM -0500, Xianting Tian <xianting_tian@126.=
com> wrote:
> Replace kmalloc_node with kzalloc_node
IIUC, your patch makes no functional change and from the message it's
not clear what's the motivation. Could you please make the commit
message more descriptive so that it can be evaluated?=20

Michal

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl3meNEACgkQia1+riC5
qSjn/g/8DG+H4X+mWCbTBkuvpAzj2IA506EgGD7wEwtgteQBnS2xH2M81ub5aoN3
hXXgwOGkqDD3A5TMunkWI5xSLgVZ2VafksCTJiCc67GPl6VjdeQZqwdH9g0XIexm
IivfMGzgu5bMwv/phg3vus/kEOswc+vDY+kdyUaB9wL2gObQucdUWUrNx6/pqpM6
v9U18KP6e5tmMubOFeawMEGKgeBqRlib9xylpKH/YuJbov9HQbZx2PN3LeP8E0bM
5+GGdRMjMp8xd5xydruOnw/+0STQ2rYbm2yvEYlpUHu/G/YEi+oHcePaO6vI+Bfc
QdEpbtuNqbkf9xDECElg09WOxs0KF+lAOoBXIUkYueCYL3noVnwQd8qj35zUuRee
SRgUQngz2xPgAJVTkLajR/SilEBVdxX5WHhwsrEE/MUUGOS83STW5oosjSjrAH/i
3U/LYrBAyEkOPcMWPQz0XxYV16Qa4ngK3rTAWh9WKnvk1yPYK1e2TaTxW5FGR/wj
hokBpZ2IpMpD/eu1RQjAZH90JcQMsXXH5yxHLD3RH7zQ6kabbrbv4nYV44Oce1/l
BLWZQhGVNtZvzrHZcd0RhLnrtP2Km+iB3KPvL9H5D1wDWr3Wj+6kmE9NiZMkmcjO
hU67jTSELMNbLREnZx3Tc575bQKyOxcMpxoJljDr/7ht9LKD9jM=
=ePfG
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
