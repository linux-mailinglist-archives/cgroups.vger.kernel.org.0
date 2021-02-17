Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6641B31DE8C
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhBQRoq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 12:44:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:42538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232728AbhBQRoo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Feb 2021 12:44:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613583837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/ZtgzJTS8sfYI+iyPmXaUOn6wgHJtb6JG1LGqJ8/g4=;
        b=Ord+gEArWPgdEpyPYgS/7zv9Bc8tkAltk2MtV33aIp31/wcyn5BwRCyWSD3FmpMb/OVPLG
        jMkA0fJC8S2ExwhA4NIPPTHzmtn2rCkn9z/TwTdF9tsndlbN2iJiSlTtqQaXTbzn4AAjza
        Hsdqkjba6/FIsEZ3UigYQGnmLEUoAFo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70A40B077;
        Wed, 17 Feb 2021 17:43:57 +0000 (UTC)
Date:   Wed, 17 Feb 2021 18:43:56 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 2/8] mm: memcontrol: kill mem_cgroup_nodeinfo()
Message-ID: <20210217174356.GC19239@blackbody.suse.cz>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20210209163304.77088-3-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 11:32:58AM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
>  include/linux/memcontrol.h |  8 +-------
>  mm/memcontrol.c            | 21 +++++++++++----------
>  2 files changed, 12 insertions(+), 17 deletions(-)
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAtVdsACgkQia1+riC5
qSgrDA/8DQBh0fmXJ72HwUwx8bkZ2TznoNUnP6REmrRLuB1A/A+ToxOJiDJSa8+G
RzXS7d5Cr7RCx3NBfSVu4MmTMoHhrRbUMoTJEPFcso5N4tbgAq1O3S4b4kbNsLEb
sh/HrxEoaU+YBil9GdJpKLj72Z7fInoA1xxZA3adf9VlYGHUI1sMZEVynXiHjs4j
ubG5GmoUzWaImyneL4yGoPhhlVuzv8KAfpMLT44ReYCW5Vc3R69f2TjZK+srySX8
9fu/uYYGvWvzPuhUjb+Z7g2Vug8nOVz4CoxFTiAlLnBDpHA4y+tPS/Jcj9Bj9vj9
EOR19riVzDYpZxJ7pGRzwDtuRilA8nIrdHWCgfCxqB5h57yupy4WlsdjNib1Jbfz
txYfZwWdcHzX+hkd8iDINV3C6R33DiBCtD8VwsEeGHhsEuB34JbzTLXNx3Hirbxp
hVzRx+ivRp1ZTD/bzk8KIzy6xuPAZeWBmVH8SmScDMyrbsd9V183uuv0jHyLHRQl
9UwaKAeQQ8n/ofZ7rSZK3h1fZ8y3PLZRssm6F+rNJwK7ZFvmyNq1zXGO/Clpi2Ns
p0/fNVTBQsfRaTiqhSaNcxBgk2Etq0eOIVG35qGtIC8aEMhZVV1VCHEwUwpJbVf7
LTxFOk2+C97r8dNGYCn/TRp/Ocf+JX2WLp3ouDH/1kq5sChSRD0=
=zbvU
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
