Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49383230EA
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 19:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhBWSnX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 13:43:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:55806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhBWSnX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 23 Feb 2021 13:43:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614105756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZ33EKFydKYQll/wNBrYJt9SLMpJFdNX6PK6738sxL4=;
        b=mRqz5RlxY0MleyIZCOCdydEysSrolgNwxZXrgyikDtYy1z8XMTWGF98OFHNS48BU9VNXn+
        hyu7Y2zGqWmCaeLcc37RctNV3xOx9vTeKixinggl492o/U0QDr7KtYdw/h6EKKOjAClx2o
        85Yyb5VCteuKVyX9O1ML24HqsJ1TiBo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1CB88AE55;
        Tue, 23 Feb 2021 18:42:36 +0000 (UTC)
Date:   Tue, 23 Feb 2021 19:42:27 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix slub memory accounting
Message-ID: <YDVMk+GQ943JXGz6@blackbook>
References: <20210223092423.42420-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IG0eXaihVNtABiw1"
Content-Disposition: inline
In-Reply-To: <20210223092423.42420-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--IG0eXaihVNtABiw1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2021 at 05:24:23PM +0800, Muchun Song <songmuchun@bytedance=
=2Ecom> wrote:
>  mm/slab_common.c | 4 ++--
>  mm/slub.c        | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--IG0eXaihVNtABiw1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmA1TI8ACgkQia1+riC5
qSiWAQ/9HoHZzRkfByT6xtaSn15MABMfGyy9kpE9KTK6y30Id4ErEgc+l0uy9jSz
W3omUt+e01+K0G7jDAwTN8dK/SevY/IpENprCxKMVkZ3thk4OO72uAy4ip7Ahpc5
j4YUVofSMiHeM8BRg0jyNURYnAjD5zI1tS3D9xVVe5EFnbhSBw5ur3gTNTjs9ZUd
N9Iu5BVUmohXes7P0Z1vyFOSuvyf4bWDPb1sHnHPU9n73p6lPQ+0Z9o7ph1nR5zZ
0SG48AnWW5sEiCDxvGU27NpnNueLfTz9tBiAd5f/k1VJSZyPez1aJXcRYnQDAuxo
H9AgsQnO7BmHR2+doyHjlfaPkRtXT5QLSq/0z87hf/T78eTYMlG7hLTo2DHMEdKA
L+Jx7JQo0IasKOmID/nmL14PMDs5XYRWxw1y+DW1G0kW7u/0Th8sgMLkh0qQQYZx
m5gTJIXJ0mZjnZoK0hQqtxkuVnTvPMTy5fTvFlduzoIp1pILkdjNmFxWg8ZAenIA
lYoCkkPd17lOF7vC4jXo/L9gFSOyODZamS/jbjnwo9GqadMYiAJNHo4ShIoF3YAz
dyG5TSSVFDzn9XdwMfwPg7tBUtD6GiLG7GLjKT+IJM6LO5wFoDeQPCag41KgxTDn
SSwi1GdzHGyrGDH6JcTmAqWDudbmvTdK065ntc7Zj2XmRXMTeDc=
=7qx0
-----END PGP SIGNATURE-----

--IG0eXaihVNtABiw1--
