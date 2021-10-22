Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7F437372
	for <lists+cgroups@lfdr.de>; Fri, 22 Oct 2021 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhJVIHn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Oct 2021 04:07:43 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:41093 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhJVIHn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Oct 2021 04:07:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HbH2n6Vksz4xbL;
        Fri, 22 Oct 2021 19:05:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1634889924;
        bh=y7UzlJGSOz7NbfAOaTJWKfNCqFzC+UB+thH/t9IZhp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EJ3FGQiNmWQwIJJQuaiElVy/7wW40LC8x2h33RIiejYtx9wQ0MWk25x0dT7NyGLxi
         kYt369kU9g0qpObuuixSZqKwGeGfEwKUFzWj3ZyBRrCIqJ9bYmH1+anysDFKAKsjAQ
         vgCrA8CfD8zoiyjEsyEuQJoa7P1dUlEhCuROGa+bjHwFHFIcH5yv4olQ0FGXkrxOzU
         cTNCXW0dCaqRJwOB7iJTwejwB9xgi0EqGXi1zvf0O6EZKrsxxDbZZEkbiK2weWtIyV
         UQHLMmX01jbDb5lWxMZqGMTZvxglQ3wfGVSGhYIazVsuwvJ7Sjg/dckpSzhhmhffUm
         WLq9v4G+gTLgw==
Date:   Fri, 22 Oct 2021 19:05:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeelb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg, kmem: mark cancel_charge() inline
Message-ID: <20211022190521.4bb1ed8f@canb.auug.org.au>
In-Reply-To: <20211022070542.679839-1-arnd@kernel.org>
References: <20211022070542.679839-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/saRK=0Kvrkqc=N/ijlFU0At";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--Sig_/saRK=0Kvrkqc=N/ijlFU0At
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 22 Oct 2021 09:05:35 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> cancel_charge() is no longer called for CONFIG_MEMCG_KMEM on NOMMU
> targets, which causes a compiletime warning:
>=20
> mm/memcontrol.c:2774:13: error: unused function 'cancel_charge' [-Werror,=
-Wunused-function]
>=20
> Remove the now-incorrect #ifdef and just mark the function
> 'inline' like the other related helpers. This is simpler
> and means we no longer have to match the #ifdef with the
> caller.
>=20
> Fixes: 5f3345c17079 ("memcg, kmem: further deprecate kmem.limit_in_bytes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The 5f3345c17079 commit is in -mm, so the commit ID is not
> stable. Feel free to just fold this into the other patch, or
> take out that reference
> ---
>  mm/memcontrol.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6538595994d2..9edccfeac804 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2770,8 +2770,7 @@ static inline int try_charge(struct mem_cgroup *mem=
cg, gfp_t gfp_mask,
>  	return try_charge_memcg(memcg, gfp_mask, nr_pages);
>  }
> =20
> -#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
> -static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_page=
s)
> +static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int =
nr_pages)
>  {
>  	if (mem_cgroup_is_root(memcg))
>  		return;
> @@ -2780,7 +2779,6 @@ static void cancel_charge(struct mem_cgroup *memcg,=
 unsigned int nr_pages)
>  	if (do_memsw_account())
>  		page_counter_uncharge(&memcg->memsw, nr_pages);
>  }
> -#endif
> =20
>  static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  {
> --=20
> 2.29.2
>=20

Added to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/saRK=0Kvrkqc=N/ijlFU0At
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFycMEACgkQAVBC80lX
0Gzniwf/fRSX+NHa237AJ7OKPkwZsfL3jn/JWcd7YuAmUyyr4bzm/lsfrLozQ8yh
LTRdTkHPmBxKit3L+/nqFV6ugq3IjKirjQIU5fkrufA/yGzp9jS1m0MMep3T6Fuo
FEVd8nFPDvgECH8/4dZ4YOi56u3y5c/gJnAsrLmAbtQ9Ywy2mFyRYhd/C1bB6OCF
Gkg9/s9nIx3w5MkI/xAoY9ZT1U/i4RLdXZWEx+13qO11KjNm0ytJP+Sj/lMQVmiy
zKpDl6LXARESzTvypv+NZ+KAHylKgk0MlpqV5Ysn9tDj1RkKex1Xysbdk0TahfHw
1qptAdfizwEJce5gGxHyMvsv+ljl+g==
=8ouZ
-----END PGP SIGNATURE-----

--Sig_/saRK=0Kvrkqc=N/ijlFU0At--
