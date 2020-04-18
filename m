Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EB51AEA91
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2020 09:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDRHvG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Apr 2020 03:51:06 -0400
Received: from ozlabs.org ([203.11.71.1]:46071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgDRHvF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 18 Apr 2020 03:51:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4944s136kRz9sSd;
        Sat, 18 Apr 2020 17:51:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587196262;
        bh=PnyXyM97AoPYfMcN3dTcjB+68Wut2eQMpbbpRG6lrBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=axrdEW2VWsd7ssDIigXYrieU4ojaq3l0mA3buQ/tx1krUKro/X90lS47YG8jjauGj
         RjxTj2knlalFIMZumt6F8V0sGAT8nI5OyzU+wYtsPrv+MSSzFFoHmNTjvZVm3zM+Ai
         R0VQhRRDgXUIfvoVPoJ0A9uNXXtLtSkl4khmhmXl2zeNiQR49M8VAj6NR3UY1SZX0a
         RfEv/v0UvX/1WgDaMHSotAAwU6NTg8AK8RNMv0SNyejARJNGGE7cd+U6TsxrxxJuHP
         TlNljEc4rC829ZWEJdhsURjm4Cj/UW6kvYwzvWCqXx7Kj7oDXMCZoTTrcL6zRgaVX1
         RR4VHpVdVaN8w==
Date:   Sat, 18 Apr 2020 17:50:59 +1000
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
Message-ID: <20200418175059.7100ed7b@canb.auug.org.au>
In-Reply-To: <20200418174353.02295792@canb.auug.org.au>
References: <00000000000022640205a04a20d8@google.com>
        <20200309092423.2ww3aw6yfyce7yty@box>
        <5b1196be-09ce-51f7-f5e7-63f2e597f91e@linux.alibaba.com>
        <d3fb0593-e483-3b69-bf2c-99ad6cd03567@linux.alibaba.com>
        <CACT4Y+Zfcs2MxD9-zR748UbkEpsV4BYjFgw1XgSqX4X8z=92CA@mail.gmail.com>
        <20200418174353.02295792@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eZQ/ncoUUv41NCVv4iW90ZY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--Sig_/eZQ/ncoUUv41NCVv4iW90ZY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Sat, 18 Apr 2020 17:43:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi Dmitry,
>=20
> On Sat, 18 Apr 2020 09:04:38 +0200 Dmitry Vyukov <dvyukov@google.com> wro=
te:
> >
> > On Mon, Mar 9, 2020 at 2:27 PM Alex Shi <alex.shi@linux.alibaba.com> wr=
ote: =20
> > > =E5=9C=A8 2020/3/9 =E4=B8=8B=E5=8D=885:56, Alex Shi =E5=86=99=E9=81=
=93:   =20
> > > >
> > > >
> > > > =E5=9C=A8 2020/3/9 =E4=B8=8B=E5=8D=885:24, Kirill A. Shutemov =E5=
=86=99=E9=81=93:   =20
> > > >>> check_preemption_disabled: 3 callbacks suppressed
> > > >>> BUG: using __this_cpu_read() in preemptible [00000000] code: syz-=
fuzzer/9432
> > > >>> caller is __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
> > > >>> CPU: 1 PID: 9432 Comm: syz-fuzzer Not tainted 5.6.0-rc4-next-2020=
0306-syzkaller #0
> > > >>> Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 01/01/2011
> > > >>> Call Trace:
> > > >>>  __dump_stack lib/dump_stack.c:77 [inline]
> > > >>>  dump_stack+0x188/0x20d lib/dump_stack.c:118
> > > >>>  check_preemption_disabled lib/smp_processor_id.c:47 [inline]
> > > >>>  __this_cpu_preempt_check.cold+0x84/0x90 lib/smp_processor_id.c:64
> > > >>>  __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
> > > >>>  __split_huge_page mm/huge_memory.c:2575 [inline]
> > > >>>  split_huge_page_to_list+0x124b/0x3380 mm/huge_memory.c:2862
> > > >>>  split_huge_page include/linux/huge_mm.h:167 [inline]   =20
> > > >> It looks like a regression due to c8cba0cc2a80 ("mm/thp: narrow lru
> > > >> locking").   =20
> > > >
> > > > yes, I guess so.   =20
> > >
> > > Yes, it is a stupid mistake to pull out lock for __mod_memcg_state wh=
ich
> > > should be in a lock.
> > >
> > > revert this patch should be all fine, since ClearPageCompound and pag=
e_ref_inc
> > > later may related with lru_list valid issue in release_pges.
> > >
> > >
> > > Sorry for the disaster!
> > >
> > > Alex   =20
> >=20
> > +linux-next, Stephen for currently open linux-next build/boot failure
> >=20
> > Hi Alex,
> >=20
> > What's the status of this? Was the guilty patch reverted? If so,
> > please mark it as invalid for syzbot, otherwise it still shows up as
> > open bug. =20
>=20
> The patch was removed from Andrew's tree in March and never made it to
> Linus' tree.  I can't find how to tell syzbot that the patch went away ...

Lets try:

#syz invalid

--=20
Cheers,
Stephen Rothwell

--Sig_/eZQ/ncoUUv41NCVv4iW90ZY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6asWMACgkQAVBC80lX
0GzbhQgApT/uV1HBVNO8O3sFco9jKTEJWPR0wmdDneOZqFUTMMAWjGHLyJfnG4BR
PM/sdvNDeoZHI6FmwJ3UDSeZqm/emCQJuPlMgru15Dgto7WK0v0icrFkTJQMTnQF
FLTKSoqIzDCFaMYP2g8H3l+UK2MvRSEV0VWij5X4/OLuIX6ZokPDjHvPIIhMQVaU
wuhnSqOQIpYuYmijTR1CCPMGAKgD0gooD3RSfg+71kItsFe/YTLO0873+XdIKefQ
G6zMGa0povGnTtJcb4mB8orj6jeUKUaH5LKuTDdFlks5UKe3dB/pyBvXtoyft5NN
/SfgC7L9XATfYNu93uJGvIfm6TjliA==
=hH4z
-----END PGP SIGNATURE-----

--Sig_/eZQ/ncoUUv41NCVv4iW90ZY--
