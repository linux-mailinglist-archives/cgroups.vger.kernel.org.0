Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634FE2F5116
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbhAMR0c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jan 2021 12:26:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:37920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbhAMR0c (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 13 Jan 2021 12:26:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610558745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rhzc4mOF8yFAxKPYUubGlwQEI+I8sBfXXcHJyflCuY4=;
        b=i1Dl/qH52hba18Oihb2EQd6sStetFqE2ABR5A0e6RSSdhSAU3FGzXEH6+IBeW2xX4/9CHq
        heVNCD+VKKUM6GNtJFK3P/aXXL+biDADwEXGQ9vwg4m9GURjQlax5LzKnPvB37qLSKiUec
        GDt67B3i/bUeSG2VEtTK7ZY5g078cCk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17418ACF5;
        Wed, 13 Jan 2021 17:25:45 +0000 (UTC)
Date:   Wed, 13 Jan 2021 18:25:38 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210113172522.GA14726@blackbody.suse.cz>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20210112163011.127833-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 11:30:11AM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> -		reclaimed =3D try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -							 GFP_KERNEL, true);
> +		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> +					     GFP_KERNEL, true);
Although I was also initially confused by throwing 'reclaimed' info
away, the patch makes sense to me given the reasoning.

It is
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

As for the discussed unsuccessful retries, I'd keep it a separate change.

Regards,
Michal

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl//LRIACgkQia1+riC5
qSjZoxAAhk4KwOei0MYgZnUEnzxE1nLMsgz8ikWGTOpHBWVId+W0rQ6FyKlFpvxv
16m+S9Fx+2YxpnE7X1mLbEGDUUO1ORbBUCy2mUeWVo3EuubEBEuNDyfYKbwTarp5
rzkT5r6/pbEcoX3NNr+bX0fD1f5dFSq3uWYoMOHkzISWshzxRATC67vKS0fBfSr5
cSq/5hh6HgYh2bo9vtO83JWkSGJTYdu5GhqTZzWIJbgjRbFpX58mG/GyZzpog0Hu
g2u5GNsrdgsM6gOuHk9wLwBluXjmrFUpaZF/pRMcw/mfzAjMRo+qZNib77IhrH5s
As+MJ1ikA8p7vWIyT57tussfMunQ7EjJGHezkKBhcJ69+ICoaPveaUy3xyVZ8dYm
9BRP7uPO3AnHxDoW+WohU7QoaJu4Mxu2qZiA+Js4upfadqg0vvYHdw/P1rbVyG99
KpmGOQ3/LnQ5LYT0VcYUUMPHDniuOyoM9VY+JSXgNBZVV4uKUeXMrLbpF9MN1tAU
MvBzbm9f5/AQVHX/ayXHiVoRBu/FuadzElB+yE4OW/VHwXr0i9KnmbCyIZcK9mr7
iU5P2X328NKTQk/UwfCbZeHs/npuDHP6aA85HhYULfjKqWtZICcJfrnxpY/ealgO
o4a15hQpOwCqOiUQvWFyZ0k2xibU+axzLEWO08jTCgD3ywfoTTw=
=n33h
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
