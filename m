Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36ED250C03
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 01:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHXXA7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 19:00:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgHXXA7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 24 Aug 2020 19:00:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bb6zq03mTz9sSP;
        Tue, 25 Aug 2020 09:00:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598310057;
        bh=eDDydcN+yRwqvCr58cy3ZtpIXf7l8cnkzFj+j1CqajM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bhHutHwcHIAL9ZElVcQQk25ly0t5DlWuVtHmK3kFpuxfYpgSIUxe3i7Dwf+HPRMWN
         D+F49Hy90V3rnGPOmwlB8FmTw4m5u0OVlESvELOTcUL/qquubwqnXGVzL9LD3aPMwc
         CGMiBfTl2CvWpU0XobpSYMeT3zf2EcuOYroHY3UZ7xd2COfY9DSIdNoq5Dk+iqdqVz
         TJbQ6AjtyUJzVlovsBKnXm93TnFjnvnUBsZilA2GoXAIUizRL1PNSLM/3rGX866oa6
         RDPFiyMo6NtWzdAszGH8k1rf76B8FW4FMDFQPvXYBSzPX2JpXzy/HkXEJr1+g+Xrdl
         LmHnzuTFbCojw==
Date:   Tue, 25 Aug 2020 09:00:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Qian Cai <cai@lca.pw>, Alex Shi <alex.shi@linux.alibaba.com>,
        akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200825090054.3c5dd68a@canb.auug.org.au>
In-Reply-To: <20200824151045.GC3415@dhcp22.suse.cz>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
        <20200820145850.GA4622@lca.pw>
        <20200824145201.GB4337@lca.pw>
        <20200824151045.GC3415@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GBWE4=3K9zAUW5hSuk=F0/p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--Sig_/GBWE4=3K9zAUW5hSuk=F0/p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Mon, 24 Aug 2020 17:10:45 +0200 Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 24-08-20 10:52:02, Qian Cai wrote:
> > On Thu, Aug 20, 2020 at 10:58:50AM -0400, Qian Cai wrote: =20
> > > On Tue, Aug 11, 2020 at 07:10:27PM +0800, Alex Shi wrote: =20
> > > > Since readahead page is charged on memcg too, in theory we don't ha=
ve to
> > > > check this exception now. Before safely remove them all, add a warn=
ing
> > > > for the unexpected !memcg.
> > > >=20
> > > > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > > Acked-by: Michal Hocko <mhocko@suse.com> =20
> > >=20
> > > This will trigger, =20
> >=20
> > Andrew, Stephen, can you drop this series for now? I did manage to trig=
ger this
> > warning on all arches, powerpc, x86 and arm64 (below). =20
>=20
> Yes, I do agree. See http://lkml.kernel.org/r/20200824151013.GB3415@dhcp2=
2.suse.cz

OK, I have removed the following from linux-next for today:

  c443db77c9f3 ("mm/thp: narrow lru locking")
  18bafefba73d ("mm/thp: remove code path which never got into")
  5fb6c0683017 ("mm/thp: clean up lru_add_page_tail")
  9d1d568727a8 ("mm/thp: move lru_add_page_tail func to huge_memory.c")
  47eb331560ff ("mm/memcg: bail out early from swap accounting when memcg i=
s disabled")
  4b0d99a64d78 ("mm/memcg: warning on !memcg after readahead page charged")

--=20
Cheers,
Stephen Rothwell

--Sig_/GBWE4=3K9zAUW5hSuk=F0/p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9ERqYACgkQAVBC80lX
0GwA5wf+MmH5x5QjwvI+81lnKYiqyUbfsEnlGMvy8JrOIX37/7lb9nUtabZtlOIx
RV6oA0amomiZDwc/c2X6GQh3oVsn69NpycxvuwZmofK7TSCz6U+YZFaUsFLxdJmd
RfQIvC55ORNcYXyjd67/OgCeXYDf//WyYMy82qd37YvLK3E7vtQQRRvdrskLBMNr
MpcRDAW4Lj3JBojpGVBspX2t0L0rmXzQY2OomgWQB29HFnJqNxPQ77aRLhm2zM6E
uRoOgMi2ca9F/cxXJKQwDrPceC7xWzaiUgCD8uOxFLwqtzcdiipnOOAeg6SJ1krt
7HQIE8bmAXf6XXAKncXy8nF4+VL0Pg==
=v0cS
-----END PGP SIGNATURE-----

--Sig_/GBWE4=3K9zAUW5hSuk=F0/p--
