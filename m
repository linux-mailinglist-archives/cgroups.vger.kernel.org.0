Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555B731DE8E
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 18:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhBQRpK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 12:45:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:42700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232560AbhBQRpJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Feb 2021 12:45:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613583861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EzOKje4WL0kVoheIE3+A7Z4mHaEdboezPhHAQ+ElTW8=;
        b=StyzdM+6sBl1ztWv65eULrf4hjCKFEf843Tr0IwKdnr86PqzzDohDsAOkrFN0u6pZmPXyl
        BxoFHjHrdAHJQb58+iWNedkWTYC2HI0bzfLQtfVoz6HA7EgnerKK4CuDNxKbFuuzDw7e9n
        IfWkVNFZ2KJYiJ28Z6kHSElmRXWm2Zo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDEABB087;
        Wed, 17 Feb 2021 17:44:21 +0000 (UTC)
Date:   Wed, 17 Feb 2021 18:44:20 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 3/8] mm: memcontrol: privatize memcg_page_state query
 functions
Message-ID: <20210217174420.GD19239@blackbody.suse.cz>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <20210209163304.77088-4-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 11:32:59AM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
>  include/linux/memcontrol.h | 44 --------------------------------------
>  mm/memcontrol.c            | 32 +++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 44 deletions(-)
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAtVfQACgkQia1+riC5
qShclBAAlogxv5YghyRoLey9Ry1bJ5alDXX5JzcvBTHKgzWcUwtzv77ckze9p54r
nkerpq7ndgxFuJ5ogb5JzkwX+r1kDuidWQj/Qcpfv6T4ZkTGYJ/2nF0mjtW48o6L
Fcl+2Q9oVh0nsN0zr3MKEPj6dPxpwg1nKGuT+FzyvCEOQMOYKZsUT6bUCKMz7xzU
qAoNFNk1dusb9V/nGz+XYT1eLyRITUp+WULuhk0+ubNhOj9HcuRI5THyjcw/cXfb
+L8FHkwdoorulHgVLISahipKmUPc85OOI5GezcehnMPD+mmW6oFs71P7K8P6pGiP
3EVFbX5Dj8BjS9kp0GPYZ50QuSofw8j5YN/cW8cjW15FWes3hlnpfnH0yu5oPWys
jo79//YgNBhGka0RnWALhbr+L/nxHlLoo6FXteH0PU1nXau7QQ14exB7rqI3qalQ
fN1WrWijFDYkGv2eknVdkduSpIi+cu8NzmCIkdmaW0k6VyLBm698zkH+5wpghN6W
ypucVEuRniclM4ckftGGO5JKu1+dlyWYEiyCru+FLwAMxby4EDuYT3B8Xh+UiyCy
bsen0xV+0EPsit1OCRF41HCu8ouAqhV4BKz9aQT3SyDc2snhnpMbc2ZpVx5T2FLY
PxBk2D4Rv81JWXHO/Jcyy3YWSkuXrc7sfJ9bQj7rCwmfNt8fZ7s=
=07gk
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
