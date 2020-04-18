Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81D1AEAC5
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2020 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDRIOe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Apr 2020 04:14:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53005 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgDRIOe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 18 Apr 2020 04:14:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4945MX3Y9vz9sQx;
        Sat, 18 Apr 2020 18:14:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587197642;
        bh=G8iMWCchG1teLmnVcfKg6CPEC0PAsZOhu4cHv56WVwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uw0O9D1cGqHhSeRW4k7P7ETkAvMrg9aUTL/PWkY+SX9D/V8obRPCWQBAeiKCmK45w
         R6NzzWSC9yOvWwgIX83jGnNWfrDZF98IEX7K9B0bZrHptZPm8llL+/SPVbNy/GxEyF
         BO9eln5LihuGFiHyNxHL2XU2Szeoq9kZhbAjPUcj8lS0K1wTzAQiCokQ+aq51G9mII
         bzOPZF0SEcq4m1fkeMWOwgxLq9+KGCMSlVOtd09Mbzfo7JTkWhWdEzgOYLOPNUaAG9
         HZGlIi8OBSTukwDp9Iyt9EFINQw4A1wAMlS1jilXkn/sUhph4dhlju6KeEUZsKCs5g
         ncOJCYKPGT8TQ==
Date:   Sat, 18 Apr 2020 18:13:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        syzbot <syzbot+826543256ed3b8c37f62@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: linux-next test error: BUG: using __this_cpu_read() in
 preemptible code in __mod_memcg_state
Message-ID: <20200418181358.0a761486@canb.auug.org.au>
In-Reply-To: <CACT4Y+ZsAgq0M=xUzrXTOYaaJfr_BrD8_5R5bhzr9k29jDSC+w@mail.gmail.com>
References: <00000000000022640205a04a20d8@google.com>
        <20200309092423.2ww3aw6yfyce7yty@box>
        <5b1196be-09ce-51f7-f5e7-63f2e597f91e@linux.alibaba.com>
        <d3fb0593-e483-3b69-bf2c-99ad6cd03567@linux.alibaba.com>
        <CACT4Y+Zfcs2MxD9-zR748UbkEpsV4BYjFgw1XgSqX4X8z=92CA@mail.gmail.com>
        <20200418174353.02295792@canb.auug.org.au>
        <20200418175059.7100ed7b@canb.auug.org.au>
        <CACT4Y+ZsAgq0M=xUzrXTOYaaJfr_BrD8_5R5bhzr9k29jDSC+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FO+IgIlyK6wXn_YCvpKjvSp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--Sig_/FO+IgIlyK6wXn_YCvpKjvSp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Sat, 18 Apr 2020 10:02:36 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > #syz invalid =20
>=20
> This is correct, thanks!
>=20
> You may now see "Status: closed as invalid on 2020/04/18 07:51" at:
> https://syzkaller.appspot.com/bug?extid=3D826543256ed3b8c37f62
>=20
> It does not show up as "open" and if this will happen again syzbot
> will report it (rather than assume it's still the old bug happening).

OK, good, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/FO+IgIlyK6wXn_YCvpKjvSp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6atsYACgkQAVBC80lX
0GxKLgf7B1CaeOafVaZuCm00dKwG5hpfeoiZ90BssMjH+U91777VeGujRDCLsz82
sgYE8FV3sqY5xnFkZi8SIMXUiVQnEVDLZiwe/gmNvS0zu9Uh9kUDUvwMhOlf6faB
kSWu907utWkPrznsU36QctaVA5qwXpRDBUZX/NVBJkcBL6xAw1/ER1n/89kf2l7X
IzJLEw68AAbwPlKAdiARMg0aQXvWbeRzs+C0HiH668G2XHL/usBBFdZT/lZCg5Xl
tBe4s8bsxBHbv0lblZZNRFXUvCKB56TbpPCqAO+PQT+bKrKjA19xD8W74/EiMd9Y
165rBH3gTrzj24jJwyJdUFNSH93Gkg==
=ZnYC
-----END PGP SIGNATURE-----

--Sig_/FO+IgIlyK6wXn_YCvpKjvSp--
