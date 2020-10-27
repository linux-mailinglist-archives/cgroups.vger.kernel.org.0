Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B949C29C709
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 19:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827730AbgJ0S1K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 14:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:60416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1827727AbgJ0S1F (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Oct 2020 14:27:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603823224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0K6gtd/wfiEHecUysB7cNGAxPugKGRqj59JkdXTbE6A=;
        b=NkYbqLOTOVixtT2SGaNj25O4NxNJlnc57h+jGI0tY46XG+J4Ie6qdjCioLpGXyueWsRnfo
        1fW1dbDSbzSCT2ei79nAakTuiWMIC+i9ccbFPdOxS0IuUwuBo16kuUQSLzYNc6vVUs0bNM
        6mA2HSoJL83d/TnkWGOyjjRHQAix3YQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE70FB209;
        Tue, 27 Oct 2020 18:27:03 +0000 (UTC)
Date:   Tue, 27 Oct 2020 19:26:59 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tom Hromatka <tom.hromatka@oracle.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: [QUESTION] Cgroup namespace and cgroup v2
Message-ID: <20201027182659.GA62134@blackbook>
References: <d223c6ba-9fcf-8728-214b-1bce30f26441@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <d223c6ba-9fcf-8728-214b-1bce30f26441@oracle.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tom.

On Tue, Oct 20, 2020 at 03:12:28PM -0600, Tom Hromatka <tom.hromatka@oracle=
=2Ecom> wrote:
> But this fails on a cgroup v2 system in a
> cgroup namespace because the root cgroup is a non-leaf cgroup.
Yes, the no internal process constraint simplifies and enables many
things for v2 controllers.

> * As outlined above, the behavior of the "root" cgroup in a cgroup
> =A0 namespace on a v2 system differs from the behavior of the
> =A0 unnamespaced root cgroup.=A0 At best this is inconsistent; at worst,
> =A0 this may leak information to an unethical program.
What information does this leak? (That it's running in a cgroup namespace?)
Note that this isn't the only discrepancy between host root cgroup and
namespaced root cgroup. The host group is simply special.

> =A0 Any ideas how =A0 we can make the behavior more consistent for the
> user and =A0 libcgroup?
You can disable the controllers (via parent's cgroup.subtree_control) to
allow migration into the parent. Of course that affects also siblings of
the removed cgroup.

> * I will likely add a flag to cgdelete to simply kill processes in
> =A0 a cgroup rather than try and move them to the parent cgroup.
> =A0 Moving processes to the parent cgroup is somewhat challenging
> =A0 even in a cgroup v1 system due to permissions, etc.
In general, migrations with controlled v2 cgroup are not supported, so
moving processes up and (especially) down has less sense than in v1.
Hence, refusing the delete operation on a populated cgroup (with
controllers) is IMO justified.


Michal

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl+YZm4ACgkQia1+riC5
qSj9Zw//dOoY85XUKFEtVEr9TxvQl6DVGWCWzN8KfiZSmFMqopEBpN7OHM9R2/qh
NeofSl6DkJe9yjtB0W96v0mt3oNK3qKc1OiiBmF3GubsaSnCL5LS1Ug7XPJf/5Cd
Kgp7Up5vbeb3vwDxaiqesVFRVsCdFWYSRolVEonqZxVg0k7WmOWStdaWCDrq91Ms
HtpNn7IdWyCOjzLrDPqtF7blfq2wqlk10x0TtpgZDJs5gA8sZCdY3VPNYB319C4i
Xz9E85XEbbeODqMwoGqtSaMjost5Cs2L5eZyVF1Tjp1GlgNEAvQt7wct95egmG3A
TTAdEm7rvktQZXaMidUQbkzyBtthsI4DZMlUuwBaPCAo+MeUcFDSdUIRxTXvO2jS
PtRSJQyjwAzw1nvdKon3dyAZzt0as9F5Titt90DLbLql66FUEN3UATfVIAuvGvgq
XrqXhGkkN4gW3CTUfB6NU+4jIjMKTOUq5oeZ6zCy8kgzWPuwsybe4HdnYT/EDXns
bF4J5GXT24cZKiefCpdDDCMqCXnz+v+lB7KjkInEnvTznfhVVxhnJiX6YYwZwt0o
hrvn8KawoXriijdksxJx6OhO4ng4cZ+89hOhJP71FYoKjQMuBSqwO6/IMWk6qiDe
UVAgZxW+Q5HFsiYwLZZAuT0l7X0FK/8485TJaMuhp3ZC2nuDmvA=
=d7RA
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
