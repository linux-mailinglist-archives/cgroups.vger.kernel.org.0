Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C1631ECDB
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 18:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhBRRGq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 12:06:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:56832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhBRPyZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Feb 2021 10:54:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613662566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0bYXrkkoPf7gVIUGqIf4ANRouo9dbAcE/WUn/S4mKM=;
        b=bQvVgdZl5ZzeQ5N4N+rSaHvztptxpoBV6JLXiGija5xYmN7S7MzLGqJuhKzUQXt1AOE0qw
        +8qZMv8zEhIJbjjpds5/C/T3v3hQei4tRzfneKT7l0oV12t5skMkNnqZ5R5zIFdornAQy8
        mw9/delHn81QPDF/I6Rkba1cxdv/Sak=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AE14ACD4;
        Thu, 18 Feb 2021 15:36:06 +0000 (UTC)
Date:   Thu, 18 Feb 2021 16:36:00 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 6/8] mm: memcontrol: switch to rstat
Message-ID: <YC6JYD6AdTZ9cbbB@blackbook>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uZNJgE1PSkaSK3Iw"
Content-Disposition: inline
In-Reply-To: <20210209163304.77088-7-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--uZNJgE1PSkaSK3Iw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 11:33:02AM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> Rstat combines the best of both worlds: from the write side, it
> cheaply maintains a queue of cgroups that have pending changes, so
> that the read side can do selective tree aggregation. This way the
> reported stats will always be precise and recent as can be, while the
> aggregation can skip over potentially large numbers of idle cgroups.
IIUC, on the unified hierarchy the rstat tree built from writer
notifications is shared with all controllers. (Currently, it means
memory updates are merged with base stats cpu time updates.) This is
just for reference, to stress the current rstat design.

> ---
>  include/linux/memcontrol.h |  67 ++++++-----
>  mm/memcontrol.c            | 223 +++++++++++++++----------------------
>  2 files changed, 132 insertions(+), 158 deletions(-)
Well done.

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--uZNJgE1PSkaSK3Iw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAuiVwACgkQia1+riC5
qSgMFQ/+P3SjzQZK1rAMCOLKGsCvWS+G4aY2oJqOwqeeoIbEl4mvs2o0K3JTl72o
u/NuEl/GEEehOrO6wnWA1QW0fVPFGXIkvFLmprRk9vOhg7nixi7VqAB73FnWyIOW
NR0mM5CHnjAR7VfB2eh8rOnMTjA/LL6W+QGc2Z9OTbYHQ8ZHpILIjqlFAvIWa7SL
C8y6vGv9wpiB3oZngg1NVtQ5+CS8EkkUNgJRmSzi8DatO4gwjhFVvXpFD1oFjCvk
1aHQeouFOxvpgy2m6LHjKzg3ybP1APXunDnhrPV8d0/hsw3JNUtyGLlDWMGQmJyg
q4UVVeUu92jDkD9iWsRSBSxG0AELlHIsxJJKh4lm0VXbYSMprX90+cNLEA7fAOy7
TTEUpzaJvOHM9/KzMKjV5EPL1YQ7ZkKV20Vf09802YRh2FZm9njxneqS0GHHS89f
ZtVPB21C7INTntOrNVP8vDT/IcpAUG6eSXWGtrCWL+/Lcbr9IE0jw1Py7rUV1VnR
6CBQgFXf/qckuLdZULmlRjTsy3N3OE5KryOe8EL9c0ikHA+SJBQZ90JW3NapX/q9
KRMdi6oMWEBGp8mUPAWuT5jFrExSKOjemRdeYAF0x+l1kzVIVST7kFc2djkFi3o8
UCQ/yJaL/0En58UKyBOJPmQNBCBNwC2kH5g9ws0hiAdwlDUnxxc=
=Dp9h
-----END PGP SIGNATURE-----

--uZNJgE1PSkaSK3Iw--
