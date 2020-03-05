Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA017A62C
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 14:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCENOK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 08:14:10 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:33946 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCENOJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 08:14:09 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1j9qK8-0016vc-Qx; Thu, 05 Mar 2020 14:14:00 +0100
Message-ID: <4d3e00457bba40b25f3ac4fd376ba7306ffc4e68.camel@sipsolutions.net>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Thu, 05 Mar 2020 14:13:58 +0100
In-Reply-To: <20200304163044.GF189690@mtj.thefacebook.com> (sfid-20200304_173047_938875_870FD3F3)
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
         <20200304163044.GF189690@mtj.thefacebook.com>
         (sfid-20200304_173047_938875_870FD3F3)
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-w13sUwChv92X5R0vevXM"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--=-w13sUwChv92X5R0vevXM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-04 at 11:30 -0500, Tejun Heo wrote:
> Hello,
>=20
> (cc'ing Johannes and quoting whole msg)
>=20
> On Wed, Mar 04, 2020 at 10:44:44AM +0100, Benjamin Berg wrote:
> > Hi,
> >=20
> > TL;DR: I seem to need memory.min/memory.max to be set on each child
> > cgroup and not just the parents. Is this expected?
>=20
> Yes, currently. However, v5.7+ will have a cgroup2 mount option to
> propagate protection automatically.
>=20
>   https://lore.kernel.org/linux-mm/20191219200718.15696-4-hannes@cmpxchg.=
org/

Oh, that is an interesting discussion/development, thanks for the
pointer!

I think that mount option is great. It is also interesting to see that
I could achieve a similar effect by disabling the memory controller.
That makes sense, but it had not occurred to me.


A major discussion point seemed to be that cgroups should be grouped by
their resource management needs rather than a logical hierarchy. I
think that the resource management needs actually map well enough to
the logical hierarchy in our case. The hierarchy looks like:

                         root
                       /     \
           system.slice       user.slice
          /    |              |         \
      cron  journal    user-1000.slice   user-1001.slice
                              |                      \
                      user@1000.service            [SAME]
                        |          |
                   apps.slice   session.slice
                       |             |
                  unprotected    protected

Where the tree underneath user@1000.service is managed separately from
the rest. Moving parts of this tree to other locations would require
interactions between two systemd processes.

But, all layers can actually have a purpose:
 * user.slice:
   - Admin/distribution defines resource guarantees/constraints that
     apply to all users as a group.
     (Assuming a single user system, the same guarantees as below.)
   - i.e. it defines the separation of system services vs. user.
 * user-.slice:
   - Admin defines resource guarantees/constrains for a single user
   - A separate policy dynamically changes this depending on whether
     the user is currently active (on seat0). Ensuring only the
     active user is benefiting.
 * user@1000.service:
   - Nothing needed here, just the point where resource management
     is delegated to the users control.
 * session.slice:
   - User/session manages resources to ensure UI responsiveness

I think this actually makes sense. Both from an hierarchical point of
view and also for configuring resources. In particular the user-.slice
layer is important, because this grouping allows us to dynamically
adjust resource management. The obvious thing we can do there is to
prioritise the currently active user while also lowering resource
allocations for inactive users (e.g. graphical greeter still running in
the background).

Note, that from my point of view the scenario that most concerns me is
a resource competition between session.slice and its siblings. This
makes the hierarchy above even less important; we just need to give the
user enough control to do resource allocations within their own
subtree.

So, it seems to me that the suggested mount option should work well in
our scenario.

Benjamin


> > I have been experimenting with using cgroups to protect a GNOME
> > session. The intention is that the GNOME Shell itself and important
> > other services remain responsive, even if the application workload is
> > thrashing. The long term goal here is to bridge the time until an OOM
> > killer like oomd would get the system back into normal conditions using
> > memory pressure information.
> >=20
> > Note that I have done these tests without any swap and with huge
> > memory.min/memory.low values. I consider this scenario pathological,
> > however, it seems like a reasonable way to really exercise the cgroup
> > reclaim protection logic.
>=20
> It's incomplete and more brittle in that the kernel has to treat a
> large portion of memory usage as essentially memlocked.
>=20
> > The resulting cgroup hierarchy looked something like:
> >=20
> > -.slice
> > =E2=94=9C=E2=94=80user.slice
> > =E2=94=82 =E2=94=94=E2=94=80user-1000.slice
> > =E2=94=82   =E2=94=9C=E2=94=80user@1000.service
> > =E2=94=82   =E2=94=82 =E2=94=9C=E2=94=80session.slice
> > =E2=94=82   =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80gsd-*.service
> > =E2=94=82   =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=94=E2=94=80208803 /usr=
/libexec/gsd-rfkill
> > =E2=94=82   =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80gnome-shell-wayland.s=
ervice
> > =E2=94=82   =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80208493 /usr=
/bin/gnome-shell
> > =E2=94=82   =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80208549 /usr=
/bin/Xwayland :0 -rootless -noreset -accessx
> > -core -auth /run/user/1000/.mutter-Xwayla>
> > =E2=94=82   =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=94=E2=94=80 =E2=80=A6
> > =E2=94=82   =E2=94=82 =E2=94=94=E2=94=80apps.slice
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80gnome-launched-tracker-miner-=
fs.desktop-208880.scope
> > =E2=94=82   =E2=94=82   =E2=94=82 =E2=94=94=E2=94=80208880 /usr/libexec=
/tracker-miner-fs
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80dbus-:1.2-org.gnome.OnlineAcc=
ounts@0.service
> > =E2=94=82   =E2=94=82   =E2=94=82 =E2=94=94=E2=94=80208668 /usr/libexec=
/goa-daemon
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80flatpak-org.gnome.Fractal-210=
350.scope
> > =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80gnome-terminal-server.service
> > =E2=94=82   =E2=94=82   =E2=94=82 =E2=94=9C=E2=94=80209261 /usr/libexec=
/gnome-terminal-server
> > =E2=94=82   =E2=94=82   =E2=94=82 =E2=94=9C=E2=94=80209434 bash
> > =E2=94=82   =E2=94=82   =E2=94=82 =E2=94=94=E2=94=80 =E2=80=A6 includin=
g the test load i.e. "make -j32" of a C++
> > code
> >=20
> >=20
> > I also enabled the CPU and IO controllers in my tests, but I don't
> > think that is as relevant. The main thing is that I set
>=20
> CPU control isn't but IO is. Without working IO isolation, it's
> relatively easy to drive the system into the ground given enough
> stress ouside the protected area.
>=20
> >   memory.min: 2GiB
> >   memory.low: 4GiB
> >=20
> > using systemd on all of
> >=20
> >  * user.slice,
> >  * user-1000.slice,
> >  * user@1000.slice,
> >  * session.slice and
> >  * everything inside session.slice
> >    (i.e. gnome-shell-wayland.service, gsd-*.service, =E2=80=A6)
> >=20
> > excluding apps.slice from protection.
> >=20
> > (In a realistic scenario I expect to have swap and then reserving maybe
> > a few hundred MiB; DAMON might help with finding good values.)
>=20
> What's DAMON?
>=20
> > At that point, the protection started working pretty much flawlessly.
> > i.e. my gnome-shell would continue to run without major page faulting
> > even though everything in apps.slice was thrashing heavily. The
> > mouse/keyboard remained completely responsive, and interacting with
> > applications ended up working much better thanks to knowing where input
> > was going. Even if the applications themselves took seconds to react.
> >=20
> > So far, so good. What surprises me is that I needed to set the
> > protection on the child cgroups (i.e. gnome-shell-wayland.service).
> > Without this, it would not work (reliably) and my gnome-shell would
> > still have a lot of re-faults to load libraries and other mmap'ed data
> > back into memory (I used "perf --no-syscalls -F" to trace this and
> > observed these to be repeatedly for the same pages loading e.g.
> > functions for execution).
> >=20
> > Due to accounting effects, I would expect re-faults to happen up to one
> > time in this scenario. At that point the page in question will be
> > accounted against the shell's cgroup and reclaim protection could kick
> > in. Unfortunately, that did not seem to happen unless the shell's
> > cgroup itself had protections and not just all of its parents.
> >=20
> > Is it expected that I need to set limits on each child?
>=20
> Yes, right now, memory.low needs to be configured all the way down to
> the leaf to be effective, which can be rather cumbersome. As written
> above, future kernels will be easier to work with in this respect.
>=20
> Thanks.
>=20

--=-w13sUwChv92X5R0vevXM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAl5g+xYACgkQq6ZWhpmF
Y3C6zhAAjU01MqlPqogmB/brIp8Kk/15NivzhgoO7pk30vBNDQ37fhwnRhLWLGGj
jRgPcWDDtS6fWi15GUdqm1bgM2yUeacBJ/LT0OLswp0tPDIhsH26adVOMKwa2EOd
lNTXR6GhmneT4MJVk/RcUmGdl6f22vUS98DI1StwweA4TUj4MdWALRkMYf0UogHK
efulEApoIWWYUQ7vfoEDoO083+iUt6FDX2aSJsTYVq86yhCBq8CmQrWCvxb2S1ku
epCuC6qI661nG+A2RrzirNfNVHhWYFi5WZlwmsyShv4S6nAUbEiRXjTreKbME63c
rIbb+9wfBestWFoiaLmmumDaWCoKTHjE0AAf8SGgoYX/a6SAgZqCMK/ZeARuYhCE
ZS2vy5jMHEH5hwYTaDjCk2hZzF7zyYxp66pOJAKAnwXrtPpd6tiNi7YNQldI4QJW
RIC1aS4kEklAq2FibTcFNsT4JLmWdxcXs0cI46q9ZJRNTNAik51OzNcU02OZHIbI
Wypwq3eIGwtKySe4gvCyGy/wyiJF70BP44DRcYchBPYlegxbhVoH5N+811xV0kTe
I5w20XVmPreashBTp3pifsDtLuKC8dLrSH1YvW7RsgdtESIq7igTQu1Y5ex2bx2L
M3K/vNlPA8CdDrF5aphvbe1uR8JhMEZTiETNIuK0rUEnG//HrxI=
=DxZM
-----END PGP SIGNATURE-----

--=-w13sUwChv92X5R0vevXM--

