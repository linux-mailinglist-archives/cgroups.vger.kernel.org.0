Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9420633F903
	for <lists+cgroups@lfdr.de>; Wed, 17 Mar 2021 20:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhCQTTd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Mar 2021 15:19:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233125AbhCQTTI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Mar 2021 15:19:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616008746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1FI9JToETJTTOhL/4esql57OHpQfJ+0yOZIN6axrdf8=;
        b=VmvFxUqjvDYU/DSPODFi5Pwon5T2ZwXu+y//crLatDklQiIb2cbXVepLfJjFJI6M1RbWl+
        mhgMgVPGK+wCEsC3xSyussqphCLsT/QW6p5Qi7GHNWhrb7c3SFuULllbRmIh0Mr0HMThaN
        oVuYiFg8GejQAYE56RItxDMuua2BUso=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3746ACA8;
        Wed, 17 Mar 2021 19:19:06 +0000 (UTC)
Date:   Wed, 17 Mar 2021 20:19:04 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: switch to rstat fix
Message-ID: <YFJWKIOHsCZhCt8H@blackbook>
References: <20210315234100.64307-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1EAEwdJwMJVALUFz"
Content-Disposition: inline
In-Reply-To: <20210315234100.64307-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--1EAEwdJwMJVALUFz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 15, 2021 at 07:41:00PM -0400, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> Switch to the atomic variant, cgroup_rstat_irqsafe().
Congratulations(?), the first use of cgroup_rstat_irqsafe().

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--1EAEwdJwMJVALUFz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmBSViUACgkQia1+riC5
qSgA8Q/+PPCIbVzSqgX5QVoHH253Rzg+fzFNgVR6ET0KwU838hhP2b/hLQSSIBqd
2gJFvlRd2I8j9N7OH1DjOUAmZp6t+Tklmtb0LWfXobisOKeM9mONHFAm7cgdJDyV
O76eq9TjFIeN2XZNRRj+n5vYIMCe+6SrtfqTxdFsieNt7Us+pASkO7j0Iw6Qral3
mG5CaVV++/jQbrRLA9Qmrx3aa7O3kGZyMCrHE77NvSUuBbfP6pSYMtTQ6ijnh7dL
kEY6OeXKOkzCUwtmrqrtFRMwRhUgSWpGmdIoR+UXO0ReuWJF+bu1EkpJZwMBgSlz
m4QixHSiTFvdvu6shg3LL//QDMAdct/Vv1osei5J0RWUGI7W7Ybf/KjYKuGKWJHX
Mvvk0k4WIhDio8GyhatwbykLzxpFDCceWj8bLe/PJUUIWG9FkeNvH3Ny5/RPVpSS
o3QGBmUjJKpbtalwVfTi0bXi5aKNzJslJD0FMj/tkzQJxPGVMSobGBGtVXLlcge9
iM/yEZ1KTTH7qveBl/AgcqR1vHnRWALELiqfEKTZJXWtLnitku+HD626kK7NNEHD
uLzs8ntdLUXW1DkJ0Kr2Zj6yXr44uScg3olpYYOwpDbrA3j7uEfzsqeyJckBJVf6
54EqfDxy/yvOg/yFGQ4L5ayoKdo+LMuz3tRUs8alsEU93K/Q4mA=
=Z6x9
-----END PGP SIGNATURE-----

--1EAEwdJwMJVALUFz--
