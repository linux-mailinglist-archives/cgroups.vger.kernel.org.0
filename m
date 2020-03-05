Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF117A8CF
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 16:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEP1Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 10:27:24 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:36372 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCEP1X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 10:27:23 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1j9sPB-001NpB-70; Thu, 05 Mar 2020 16:27:21 +0100
Message-ID: <7ce3aa9cf6f7501ce2ce6057a03a40cd5e126efd.camel@sipsolutions.net>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Thu, 05 Mar 2020 16:27:19 +0100
In-Reply-To: <20200305145554.GA5897@mtj.thefacebook.com>
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
         <20200304163044.GF189690@mtj.thefacebook.com>
         <4d3e00457bba40b25f3ac4fd376ba7306ffc4e68.camel@sipsolutions.net>
         <20200305145554.GA5897@mtj.thefacebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-umClWGF5jrM9UDKCYNFb"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--=-umClWGF5jrM9UDKCYNFb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-05 at 09:55 -0500, Tejun Heo wrote:
> Hello,
>=20
> On Thu, Mar 05, 2020 at 02:13:58PM +0100, Benjamin Berg wrote:
> > A major discussion point seemed to be that cgroups should be grouped by
> > their resource management needs rather than a logical hierarchy. I
> > think that the resource management needs actually map well enough to
> > the logical hierarchy in our case. The hierarchy looks like:
>=20
> Yeah, the two layouts share a lot of commonalities in most cases. It's
> not like we usually wanna distribute resources completely unrelated to
> how the system is composed logically.
>=20
> >                          root
> >                        /     \
> >            system.slice       user.slice
> >           /    |              |         \
> >       cron  journal    user-1000.slice   user-1001.slice
> >                               |                      \
> >                       user@1000.service            [SAME]
> >                         |          |
> >                    apps.slice   session.slice
> >                        |             |
> >                   unprotected    protected
> >=20
> ...
> > I think this actually makes sense. Both from an hierarchical point of
> > view and also for configuring resources. In particular the user-.slice
> > layer is important, because this grouping allows us to dynamically
> > adjust resource management. The obvious thing we can do there is to
> > prioritise the currently active user while also lowering resource
> > allocations for inactive users (e.g. graphical greeter still running in
> > the background).
>=20
> Changing memory limits dynamically can lead to pretty abrupt system
> behaviors depending on how big the swing is but memory.low and io/cpu
> weights should behave fine.

Right, we'll need some daemon to handle this, so we could even smooth
out any change over a period of time. But it seems like that will not
be needed. I don't expect we'll want to change anything beyond
memory.low and io/cpu weights.

I opened
  https://github.com/systemd/systemd/issues/15028
to discuss this further. I'll update the ticket with more pointers and
information later.

> > Note, that from my point of view the scenario that most concerns me is
> > a resource competition between session.slice and its siblings. This
> > makes the hierarchy above even less important; we just need to give the
> > user enough control to do resource allocations within their own
> > subtree.
> >=20
> > So, it seems to me that the suggested mount option should work well in
> > our scenario.
>=20
> Sounds great. In our experience, what would help quite a lot is using
> per-application cgroups more (e.g. containing each application as user
> services) so that one misbehaving command can't overwhelm the session
> and eventually when oomd has to kick in, it can identify and kill only
> the culprit application rather than the whole session.

We are already trying to do this in GNOME. :)

Right now GNOME is only moving processes into cgroups after launching
them though (i.e. transient systemd scopes).

But, the goal here is to improve it further and launch all
applications directly using systemd (i.e. as systemd services). systemd
itself is going to define some standards to facilitate everything. And
we'll probably also need to update some XDG standards.

So, there are some plans already, but many details have not been solved
yet. But at least KDE and GNOME people are looking into integrating
well with systemd.

Benjamin

--=-umClWGF5jrM9UDKCYNFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAl5hGlcACgkQq6ZWhpmF
Y3D4GQ//ULZn9Tv0vNbOtqQCvuZu0lhFrt9g16vYb6j9YEL2H/h/J9VLxjHl0CPd
4aTp5Z/DrWSNPBV1KipW4mjpDWyL+rkSIGEff37GSj3AyEMi4JA/56zs6ChwFvXN
sx+AQpz0GvJDbMExM3fYdbL8IFEWjf3X+ziKl3Wbax6QGQv4ku4J23Kjs5xUk5ow
rgxrFUehFPWvRazx+q10CCpVafTSSEMdKWb1fsUKQjursoqSqvAnOG1y8hWTU5ai
Zx4PkAXI/1/2U/4/Dj/JM40HRP0N8hJ0teBIuUJDC88YUzosLVlbhlWemOXP6/kq
qfCEIWZJ1e4Ljgmwizdzbw6OoFGumM0GZgxw2tf3fM9cX50jXtQhDmexSmjzHiT3
vx4IyTPJuZKd7Jlw73IWtuZzZp0mXmDEqKY+7KjMeM6g0MZ/eM1zHwmzcQvAkEuz
YPphGWdFHGTgJsu/5Df4PYqlI6iJLXhYXwMxd0BFGEVwPxn69bm0XxCaU0U3WqyU
NjKteth48GRLQzYEJvwxU9MpjIsIwftHPkE38luiCQ1yQrM2jEHo4qsRAnBjnff2
QfSgY6s7+y7tIQKisD6DAVt62ydQpjzIdGRQargvQIIngb6xovPkpemjoXCwba8a
6PWvJAbBrgvMlrDCPMQHjKFqKvziRM2iO0pS4vZfx6zVRioxM04=
=0s2G
-----END PGP SIGNATURE-----

--=-umClWGF5jrM9UDKCYNFb--

