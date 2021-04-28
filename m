Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C485A36D096
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 04:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhD1Cmg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 22:42:36 -0400
Received: from ozlabs.org ([203.11.71.1]:54383 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235839AbhD1Cmg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Apr 2021 22:42:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FVNFB5SB1z9sWW; Wed, 28 Apr 2021 12:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1619577710;
        bh=mj7AA6SpFmZriYfg2y1A/MPZ1OsGXn1xwUCbY/nJ76U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyXdFYReSN3lG3BX1l2E0CC+sohSHjEGDofu5irbLpu5eXH8JJBUQwH2LTEfRceXv
         zR54hLL9XfIgdZ/bOh2sMR4V2C5Bw9M7SnxIUAE1ApQlhKSVFjSTJnOQtt68nLUwUT
         G+MRxrmyWXzr3ufdLAicPROak7l0fCUjI3XZ3lGE=
Date:   Wed, 28 Apr 2021 10:58:29 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YIizNdbA0+LYwQbI@yekko.fritz.box>
References: <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qPvzHO912Qm8Itle"
Content-Disposition: inline
In-Reply-To: <20210427171212.GD1370958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--qPvzHO912Qm8Itle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 02:12:12PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 27, 2021 at 03:08:46PM +1000, David Gibson wrote:
> > > Starting from a BDF the general pseudo code is:
> > >  device_name =3D first_directory_of("/sys/bus/pci/devices/BDF/vfio/")
> > >  device_fd =3D open("/dev/vfio/"+device_name)
> > >  ioasidfd =3D open("/dev/ioasid")
> > >  ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)
> >=20
> > This line is the problem.
> >=20
> > [Historical aside: Alex's early drafts for the VFIO interface looked
> > quite similar to this.  Ben Herrenschmidt and myself persuaded him it
> > was a bad idea, and groups were developed instead.  I still think it's
> > a bad idea, and not just for POWER]
>=20
> Spawning the VFIO device FD from the group FD is incredibly gross from
> a kernel design perspective. Since that was done the struct
> vfio_device missed out on a sysfs presence and doesn't have the
> typical 'struct device' member or dedicated char device you'd expect a
> FD based subsystem to have.
>=20
> This basically traded normal usage of the driver core for something
> that doesn't serve a technical usage. Given we are now nearly 10 years
> later and see that real widely deployed applications are not doing
> anything special with the group FD it makes me question the wisdom of
> this choice.

I'm really not sure what "anything special" would constitute here.

> > As Alex says, if this line fails because of the group restrictions,
> > that's not great because it's not very obvious what's gone wrong. =20
>=20
> Okay, that is fair, but let's solve that problem directly. For
> instance netlink has been going in the direction of adding a "extack"
> from the kernel which is a descriptive error string. If the failing
> ioctl returned the string:
>=20
>   "cannot join this device to the IOASID because device XXX in the
>    same group #10 is in use"

Um.. is there a sane way to return strings from an ioctl()?

> Would you agree it is now obvious what has gone wrong? In fact would
> you agree this is a lot better user experience than what applications
> do today even though they have the group FD?
>=20
> > But IMO, the success path on a multi-device group is kind of worse:
> > you've now made made a meaningful and visible change to the setup of
> > devices which are not mentioned in this line *at all*. =20
>=20
> I don't think spawning a single device_fd from the guoup clearly says
> there are repercussions outside that immediate, single, device.

It's not the fact that the device fds are spawed from the group fd.
It's the fact that the "attach" operation - binding the group to the
container now, binding the whatever to the iosasid in future -
explicitly takes a group.  That's an operation that affects a group,
so the interface should reflect that.

Getting the device fds from the group fd kind of follows, because it's
unsafe to do basically anything on the device unless you already
control the group (which in this case means attaching it to a
container/ioasid).  I'm entirely open to ways of doing that that are
less inelegant from a sysfs integration point of view, but the point
is you must manage the group before you can do anything at all with
individual devices.

> That comes from understanding what the ioctls are doing, and reading
> the documentation. The same applies to some non-group FD world.
>=20
> > Yes, it makes set up more of a pain, but it's necessary complexity to
> > actually understand what's going on here.
>=20
> There is a real technical problem here - the VFIO group is the thing
> that spawns the device_fd and that is incompatible with the idea to
> centralize the group security logic in drivers/iommu/ and share it
> with multiple subsystems.

I don't see why.  I mean, sure, you don't want explicitly the *vfio*
group as such.  But IOMMU group is already a cross-subsystem concept
and you can explicitly expose that in a different way.

> We also don't have an obvious clean way to incorporate a group FD into
> other subsystems (nor would I want to).

If you don't have a group concept in other subsystems, there's a fair
chance they are broken.  There are a bunch of operations that are
inherently per-group.  Well.. per container/IOASID, but the
granularity of membership for that is the group.

> One option is VFIO can keep its group FD but nothing else will have
> anthing like it. However I don't much like the idea that VFIO will
> have a special and unique programming model to do that same things
> other subsystem will do. That will make it harder for userspace to
> implement.

Again, I realy think this is necessary complexity.  You're right that
far too little of the userspace properly understands group
restrictions.. but these come from real hardware limitations, and I
don't feel like making it *less* obvious in the interface is going to
help that.

> But again, lets see what the draft ioasid proposal looks like and
> maybe someone will see a different solution.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qPvzHO912Qm8Itle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCIszUACgkQbDjKyiDZ
s5JHmw/+Lx8WGuicjy+qtJt/4zJbw9/cGrWFl3s1QTbOMI0+I//9/1t2RnyKZTWY
I0C9pRIW4K3zGkfWqikejjjmkJnmR3inhuTPptPVOdpRShuo0Bzrfb7dLO8RWS8q
yeqCe+NBGhsE9LCedqjBZ4cPr+yY2DJnx+L97ksnxEEuyQG/f6imP278QdAi3ciM
jEBVkIaW4iW40WJpDlOOioDhsQ4JxLv69FWHbUNaENO3nZLCElB4194rK5zxOLQ2
G3qNm3CknZtUAYLVUkZkqj/Z694hrNLHyusuAo+3C3B/by5ZuIYu5fEAlwtBDBxA
qVh50ehcCdxcthMoE9DqKoils6y8iNos/bdMrGqKdPpVlC1AvDhP1tTL0qs8oTLW
/6XlEYoPhaIA/axO4mcUK+yntIVLmzOSQJOm7LKubZAzTnn3QXY1ZLJKstL75t21
jKCxLHMlLbGt7RJbriLeWRW/fIOQwL8TzZ21EWoZ6d0pDtDexObcgVQrenO6ps++
YpC/OQK8dfsYjULnajp/EBpCUIjKe01qr557N5HxHH66c/W7pS7O/ZFeapTbtZBX
MKjmudIi6iMV15Yer7zU+KNpLLYudtrGvMhfj3VfLn9fh4yATr238YvFFyoKSalN
+BmZdJ/o+glqSH6B6Km4IPmuIwEbn3DrVR4/CDrse0TLyPF1tuc=
=ThH4
-----END PGP SIGNATURE-----

--qPvzHO912Qm8Itle--
