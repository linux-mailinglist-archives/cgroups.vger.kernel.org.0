Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00DC36B527
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 16:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhDZOmw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 10:42:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233884AbhDZOmw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 10:42:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619448129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gehS6VLlgOM1n0sqUfbTqUuIIQgjLgEpVqlnX5VEuzE=;
        b=uD0Cy+/FdJ6UxuddtzxiQ5vdeMeTsIRVaTTPrA6MrwHIYNhne51Xo7IKF3qgFRdsyGyP6+
        WHm5NBe0MCQZyhfOfHmnMDMnMcjzFg8W7BfLKYtMFsBeKWCT7VbbabQ1yBzBomrah97Aol
        dY6/7ujlNJILvSx2OOyFAifPhM9igcQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FBA8AB87;
        Mon, 26 Apr 2021 14:42:09 +0000 (UTC)
Date:   Mon, 26 Apr 2021 16:42:07 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <YIbRP5/w1ZD804DL@blackbook>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIMZkjzNFypjZao9@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t5H9JHlfBVdAGKzg"
Content-Disposition: inline
In-Reply-To: <YIMZkjzNFypjZao9@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--t5H9JHlfBVdAGKzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Fri, Apr 23, 2021 at 12:01:38PM -0700, Roman Gushchin <guro@fb.com> wrote:
> Overall it sounds very reasonable and makes total sense to me.
I agree this sounds like very desired convenience...

> Many userspace applications can use the new interface instead of
> reading cgroup.procs in a cycle and killing all processes or using the
> freezer and kill a frozen list of tasks.
...however, exactly because of this, I'm not convinced it's justifying
yet another way how to do it and implement that in kernel. (AFAIU, both
those ways should be reliable too (assuming reading cgroup.procs of the
_default_ hierarchy), please correct me if I'm wrong.)

> It will simplify the code and make it more reliable.
It's not cost free though, part of the complexity is moved to the
kernel.
As Roman already pointed earlier, there are is unclear situation wrt
forking tasks. The similar had to be solved for the freezer hence why
not let uspace rely on that already? Having similar codepaths for
signalling the cgroups seems like a way to have two similar codepaths
side by side where one of them serves just to simplify uspace tools.

Michal

--t5H9JHlfBVdAGKzg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmCG0TsACgkQia1+riC5
qSj/Uw/+IQoj2Jh7QG+npIuKITbWSsNTQRw4Y+MjFEa4jP3oGPr1LWiism82uzTh
HCVXW7BsxOwZF+zKeXCOehMs2W9J/W3AJv6tcBymu8O0irtUIZVuOwrwe0QJChwP
k0bIXrwQR9yzA0CuC+sqLa8+z6WYfJEcmOWmJBa0T8vfjFBsmNUYl8/AehoNTCGU
lEO57EOowPqrukvdYzXsLFtC+c9tYCh9UyhuA/eKVeiJKSL4aPKs9gyShtEIOgHe
PoGGSVcUk23mSDKy0xF0lfvcWuxqlppcxl5SBm9GefW7308J1sOeZzbn4N8av8Hj
bjmHnjPI3dwGr4nVkNzbgjko7fNWEgnNvzltMjkv3+PNtCpTX3jMcG3WOG0eTUSc
LL0UzWp3dvnzySdCo0u1NsDzunpoyPhsXDRra/OBvcxCy0hHP2LRL/eveOvQtLZv
/1r9lVI93Oz2Ac+X+3nG7aWf2/lAKXbVvbltlC7amh+cPsqnf4315gHxJkg5VUl+
pDK/I5r/YGjhaEJhHL2E2ni2s/9mN5eWJHhCGaCUfC7BB800tuRcluvLhbN2Qhj+
YHDQHpOFEuPr/VCs5+ZGRmW8o4tY5kSj1IUNljDCjZQFXHCIWLx3nSrecaPK9hlX
SBfJ4MSVAIZ7WmiyQgfgJXmeHtPj2oAOeZPBf+V8mfL4uptNJRI=
=Tr1M
-----END PGP SIGNATURE-----

--t5H9JHlfBVdAGKzg--
