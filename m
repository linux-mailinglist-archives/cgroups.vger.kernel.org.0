Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F24C31DE8A
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 18:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhBQRoS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 12:44:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:42284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234645AbhBQRoR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Feb 2021 12:44:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613583810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXWnyeMmmGz+FzIhu5jyT4Y80+vhglGdOk9hed4/Cy4=;
        b=KQ4aux8Xyeu46Gq9O++UM5dnbj0QsMYa+K/Dz+6GXQMlYGXJkNQ8kRKpsqPVedHt2H+DzM
        dbNuSLJYKe/e56JNi2GoXbxwNE1iA0R9Hw3u9SjzMIvLEWu2YaaDHyrvoVd8oCAGxb5OAH
        uNWPDAwKu0F8Wi/Whm0HLCc/muZGTyk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38DE3B7C1;
        Wed, 17 Feb 2021 17:43:30 +0000 (UTC)
Date:   Wed, 17 Feb 2021 18:43:28 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 1/8] mm: memcontrol: fix cpuhotplug statistics flushing
Message-ID: <20210217174328.GB19239@blackbody.suse.cz>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20210209163304.77088-2-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 11:32:57AM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
>  mm/memcontrol.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAtVcAACgkQia1+riC5
qSjL8g/+MmtY23uIXNe7kB1XxJQB2aO7N7s+wzgE1L0sx/NbUh4TM9SdDTclRPZ8
wDwIiEMNUPjq8xGgiGiWKrkYC34F/g+fixMQ6AZcHUaJ3ZorJFpcyy9QqPHU4SeY
HWm9eBUpEnV9CZOct1bW6y/h6RNn2dnz1m9iDJ3FXCWy6S+VnC1OrWKkFvQdyLOc
tjGdO+CQda//Mb7m0dRBgiDzZjxpOyKX8jXKOv1ygnKpPWoWr8MsBSlM+T1kF3gY
QgvcZ1eZww/d1qN6c2GjeCuu/hVuEU6DcyK4Zr212nWYa51Mi9JwCNT5lvqAt4AE
eBYuuKtY2V5OKHa3MURC4OwBpPAvWiEek3yB+v5GvHgw8rlHY24q1pGgX/XeUYdm
MVjXHvsmzZWWhHLWKYq0hHfYCyZkNet3a5lQbjH/gFSL4RTqvPlR7bbBLADQOcqi
TzINKo6UTfHoZrhw58ISFp2eTQMfUxbtSsXL3q0QP7LtadLCmu9Lal/tOwT7/ZrQ
O/TYDeRzRlILY647npRfmBGdx/YJ9jexbydvQDBJN97sYD0UjiDFYwNOO795CAEC
zDzDsnEVlhHXhzku64XEiR1JgIQdqzaIwRF1vDWd38fXQxt2x06XafLUUJDhcCGM
Qp5hE2uXFT/IteQig7NiddqpkBkBqU1bKIryacCIZKzMGmWohIw=
=NZiv
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
