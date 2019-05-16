Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF620B4B
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEPPbu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 11:31:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPPbu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 16 May 2019 11:31:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60767C050918;
        Thu, 16 May 2019 15:31:50 +0000 (UTC)
Received: from antique-laptop (ovpn-200-37.brq.redhat.com [10.40.200.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4763660851;
        Thu, 16 May 2019 15:31:47 +0000 (UTC)
Date:   Thu, 16 May 2019 17:31:44 +0200
From:   Pavel Hrdina <phrdina@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Daniel Mack <daniel@zonque.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC] cgroup gets release after long time
Message-ID: <20190516153144.GC19737@antique-laptop>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20190516152224.GA7163@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 16 May 2019 15:31:50 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > hi,
> > Pavel reported an issue with bpf programs (attached to cgroup)
> > not being released at the time when the cgroup is removed and
> > are still visible in 'bpftool prog' list afterwards.
>=20
> Hi Jiri!
>=20
> Can you, please, try the patch from
> https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c4872d342bf6=
721e148e2 ?
>=20
> It should solve the problem, and I'm about to post it upstream.

Perfect, I'll give it a try with full libvirt setup as well.

Can we have this somehow detectable from user-space so libvirt can
decide when to use BPF or not?  I would like to avoid using BPF with
libvirt if this issue is not fixed and we cannot simply workaround it
as systemd automatically removes cgroups for us.

Thanks!

Pavel

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAlzdgmAACgkQUi1kczAH
4Yz7ZxAA2MaTcZ2Xu6ZnHr6zlPvF8gqqJdITmnGa+WWpvb4zEG8xR3F+ZqVgx2PS
5zXpziJfhuGL7USr6lADi99fExzCAgr9k/+9qrx3A9K4BKZyf8IXRdpoqJk1tx+V
Eptt3IHR8syH+32gbpildUMxem74IlDnw4nOI/vZmCHWd91z7t0IW8hc8a+fB0C6
mCq2wiukwF6Smfa3jXaIRouglGVpyQ5q6uZx21I4wh2Scjx9G068JR8k8M3XpRBe
LgPn1eicBDP8jRFXdJ1FKnj07Xe1CX/dErhakSkr6EDaQ+OSyX5xlz/Sv9++n5YM
0BLx65alZkc1yi3O7Vpn9B6XgsTMgTep9dJKA2vKfsVufM6XN19c+/FU67GqIBeF
qAj+6icyVO5g0WuG0qT1d6BHE6vjqAxGsPMIrBSwJbc7qq4pES45PybZgpxURuC8
RY7BEJxWt9b8ObFusqyS3LZv/+366k/F0Mh/aF8ZdE6hcyXCPDkyYlFYZb/qdTw8
u38mGABinx0XibdzjGe18hr58zTfsATW+37TyR/UyCux6fROV/Rv2M4qugpbdtbu
6v9VITm7Xnb645E4BHb3JBoM1VsdbG3jt43QtlXIA2dlBgoP0T4qODu1dLSFfYEq
YCytDlr38No/I1ele0ufbsJRRgF6sls+oFlpXkL+M3Q2TxYtQ0M=
=ugh2
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
