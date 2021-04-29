Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA736E432
	for <lists+cgroups@lfdr.de>; Thu, 29 Apr 2021 06:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhD2ETA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 00:19:00 -0400
Received: from ozlabs.org ([203.11.71.1]:35437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236873AbhD2ETA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Apr 2021 00:19:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FW2Kx1MK8z9sjD; Thu, 29 Apr 2021 14:18:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1619669893;
        bh=hsi/0KQt96DzQmNT580YEU9V2UkP5TGhmJvkh107yvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKTV6jhUCQG6QGXO0yH4rJ0e1PKhM4eKJ+VPACBqzzyMB7lNfd0pf0uJyRsuOpKkS
         4a4aXtGWyzp1xpv7GbZy9pee3/Zw4bA7PCSLwHPsjZJ1McFkwdWmOJSIfyF2xZ3zAn
         i8zpShOOVMxVTYpefxWG3AmPchYbPYKTcg30OJRc=
Date:   Thu, 29 Apr 2021 13:04:05 +1000
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
Message-ID: <YIoiJRY3FM7xH2bH@yekko>
References: <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XZCPoS4KxluW8njQ"
Content-Disposition: inline
In-Reply-To: <20210428145622.GU1370958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--XZCPoS4KxluW8njQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 28, 2021 at 11:56:22AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 28, 2021 at 10:58:29AM +1000, David Gibson wrote:
> > On Tue, Apr 27, 2021 at 02:12:12PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 27, 2021 at 03:08:46PM +1000, David Gibson wrote:
> > > > > Starting from a BDF the general pseudo code is:
> > > > >  device_name =3D first_directory_of("/sys/bus/pci/devices/BDF/vfi=
o/")
> > > > >  device_fd =3D open("/dev/vfio/"+device_name)
> > > > >  ioasidfd =3D open("/dev/ioasid")
> > > > >  ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)
> > > >=20
> > > > This line is the problem.
> > > >=20
> > > > [Historical aside: Alex's early drafts for the VFIO interface looked
> > > > quite similar to this.  Ben Herrenschmidt and myself persuaded him =
it
> > > > was a bad idea, and groups were developed instead.  I still think i=
t's
> > > > a bad idea, and not just for POWER]
> > >=20
> > > Spawning the VFIO device FD from the group FD is incredibly gross from
> > > a kernel design perspective. Since that was done the struct
> > > vfio_device missed out on a sysfs presence and doesn't have the
> > > typical 'struct device' member or dedicated char device you'd expect a
> > > FD based subsystem to have.
> > >=20
> > > This basically traded normal usage of the driver core for something
> > > that doesn't serve a technical usage. Given we are now nearly 10 years
> > > later and see that real widely deployed applications are not doing
> > > anything special with the group FD it makes me question the wisdom of
> > > this choice.
> >=20
> > I'm really not sure what "anything special" would constitute here.
>=20
> Well, really anything actually. All I see in, say, dpdk, is open the
> group fd, get a device fd, do the container dance and never touch the
> group fd again or care about groups in any way. It seems typical of
> this class of application.

Well, sure, the only operation you do on the group itself is attach it
to the container (and then every container operation can be thought of
as applying to all its attached groups).  But that attach operation
really is fundamentally about the group.  It always, unavoidably,
fundamentally affects every device in the group - including devices
you may not typically think about, like bridges and switches.

That is *not* true of the other device operations, like poking IO.

> If dpdk is exposing other devices to a risk it certainly hasn't done
> anything to make that obvious.

And in practice I suspect it will just break if you give it a >1
device group.

> > > Okay, that is fair, but let's solve that problem directly. For
> > > instance netlink has been going in the direction of adding a "extack"
> > > from the kernel which is a descriptive error string. If the failing
> > > ioctl returned the string:
> > >=20
> > >   "cannot join this device to the IOASID because device XXX in the
> > >    same group #10 is in use"
> >=20
> > Um.. is there a sane way to return strings from an ioctl()?
>=20
> Yes, it can be done, a string buffer pointer and length in the input
> for instance.

I suppose.  Rare enough that I expect everyone will ignore it, alas :/.

> > Getting the device fds from the group fd kind of follows, because it's
> > unsafe to do basically anything on the device unless you already
> > control the group (which in this case means attaching it to a
> > container/ioasid).  I'm entirely open to ways of doing that that are
> > less inelegant from a sysfs integration point of view, but the point
> > is you must manage the group before you can do anything at all with
> > individual devices.
>=20
> I think most likely VFIO is going to be the only thing to manage a
> multi-device group.

You don't get to choose that.  You could explicitly limit other things
to only one-device groups, but that would be an explicit limitation.
Essentially any device can end up in a multi-device group, if you put
it behind a PCIe to PCI bridge, or a PCIe switch which doesn't support
access controls.

The groups are still there, whether or not other things want to deal
with them.

> I see things like VDPA being primarily about PASID, and an IOASID that
> is matched to a PASID is inherently a single device IOMMU group.

I don't know enough about PASID to make sense of that.

> > I don't see why.  I mean, sure, you don't want explicitly the *vfio*
> > group as such.  But IOMMU group is already a cross-subsystem concept
> > and you can explicitly expose that in a different way.
>=20
> Yes, and no, the kernel drivers in something like VDPA have decided
> what device and group they are in before we get to IOASID. It is
> illogical to try to retro-actively bolt in a group concept to their
> APIs.

Again, I don't know enough about VDPA to make sense of that.  Are we
essentially talking non-PCI virtual devices here?  In which case you
could define the VDPA "bus" to always have one-device groups.

> > Again, I realy think this is necessary complexity.  You're right that
> > far too little of the userspace properly understands group
> > restrictions.. but these come from real hardware limitations, and I
> > don't feel like making it *less* obvious in the interface is going to
> > help that.
>=20
> The appeal of making it less obvious is we can have a single
> simplified API flow so that an application that doesn't understand or
> care about groups can have uniformity.

I don't think simplified-but-wrong is a good goal.  The thing about
groups is that if they're there, you can't just "not care" about them,
they affect you whether you like it or not.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XZCPoS4KxluW8njQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCKIiMACgkQbDjKyiDZ
s5Ko9RAAruwUcNc8D5emb4+A75xQ5FhpAN1TX0gJbsRkNbWI5YyofP4isXd7e5vJ
m+5diAhMg7KO37NKLSM5UW4wUotGlmqoDUHbUzWAqTPWsoDFcxUyNnmRJs8VQf5N
UScJmiRZBuh3x/6WB2YpKxY0qGf8FD0yWLDjR8QFKcJPeQyvSkmo7qvVjflt4Y9T
buzgdN+mZ5l3GasBfx3w6HE8s9OlIfD2D5vv1uosc8q+eJcq3axUk83hCqqIQteA
xaNkfFXhuc3DRSTKkAL+B/snZWiG3O9AGOlDM86kHOFAihbH71bIcsgnMjZRSynA
RYed6WpcYXyjxsPxvtLwxTHN4eHS9OGqLVSWnkHS6S5CREbNokA0Uyr1tCWx+V7j
WefMR7fVnWrN6M7ZA3RLiA8Mw5Pd1ObB3kp1FoROqrHaCQe5V3YzyjTENWawSNKx
Dm5os40SkM/6jGXqxtVmLu8qv66RadGR7Hgn9T8YEv99afPgnG5WqoVzXpXmDSqt
29yjzQrDIvz8LO/jDU6dcvIjv9ELV1D4A7AMmWDYrCPEmu2+T6GKSYm60G1aDuYK
/Sd/Mg7HX8hZvTRDrt9BfAt0QC0cWsM6z598wI56cJ+XSy661uStb8wnnVGawlKJ
9VKxystpE/ry52y2kevd0N2OWa5V1AyGVDKdi5GU2h2iVgK1tO8=
=BkOW
-----END PGP SIGNATURE-----

--XZCPoS4KxluW8njQ--
