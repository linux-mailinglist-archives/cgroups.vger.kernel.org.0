Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB636BECA
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 07:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhD0FP5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 01:15:57 -0400
Received: from ozlabs.org ([203.11.71.1]:36757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhD0FP4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Apr 2021 01:15:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FTqhc4jL0z9sXL; Tue, 27 Apr 2021 15:15:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1619500512;
        bh=CF2I+Bf3ktGxH9cnugcF0EvMEqXiRXsbfOiadcWHjnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWP0J5DFU6ukZ0jBukT0ugB4ga5yhwYnx+L7oqL1g1EYbU0nt+dB5rzA8sf4A8bB7
         BT28SxlEhNDU8OGd1cChjNZhBJMJuV5oLX0KZq34Nd507BVj24HQ6+dOaHMf4q1kMm
         4T7FwjzUlhCGJzFJYmnO1AHOf12tEBx8o8zay/Gk=
Date:   Tue, 27 Apr 2021 15:08:46 +1000
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
Message-ID: <YIecXkaEGNgICePO@yekko.fritz.box>
References: <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ON9ZWBdFmyZZnCtm"
Content-Disposition: inline
In-Reply-To: <20210422233950.GD1370958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ON9ZWBdFmyZZnCtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 08:39:50PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 22, 2021 at 04:38:08PM -0600, Alex Williamson wrote:
>=20
> > Because it's fundamental to the isolation of the device?  What you're
> > proposing doesn't get around the group issue, it just makes it implicit
> > rather than explicit in the uapi.
>=20
> I'm not even sure it makes it explicit or implicit, it just takes away
> the FD.
>=20
> There are four group IOCTLs, I see them mapping to /dev/ioasid follows:
>  VFIO_GROUP_GET_STATUS -=20
>    + VFIO_GROUP_FLAGS_CONTAINER_SET is fairly redundant
>    + VFIO_GROUP_FLAGS_VIABLE could be in a new sysfs under
>      kernel/iomm_groups, or could be an IOCTL on /dev/ioasid
>        IOASID_ALL_DEVICES_VIABLE
>=20
>  VFIO_GROUP_SET_CONTAINER -
>    + This happens implicitly when the device joins the IOASID
>      so it gets moved to the vfio_device FD:
>       ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
>=20
>  VFIO_GROUP_UNSET_CONTAINER -
>    + Also moved to the vfio_device FD, opposite of JOIN_IOASID_FD
>=20
>  VFIO_GROUP_GET_DEVICE_FD -
>    + Replaced by opening /dev/vfio/deviceX
>      Learn the deviceX which will be the cdev sysfs shows as:
>       /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/vfio/deviceX/dev
>     Open /dev/vfio/deviceX
>=20
> > > How do we model the VFIO group security concept to something like
> > > VDPA?
> >=20
> > Is it really a "VFIO group security concept"?  We're reflecting the
> > reality of the hardware, not all devices are fully isolated. =20
>=20
> Well, exactly.
>=20
> /dev/ioasid should understand the group concept somehow, otherwise it
> is incomplete and maybe even security broken.
>=20
> So, how do I add groups to, say, VDPA in a way that makes sense? The
> only answer I come to is broadly what I outlined here - make
> /dev/ioasid do all the group operations, and do them when we enjoin
> the VDPA device to the ioasid.
>=20
> Once I have solved all the groups problems with the non-VFIO users,
> then where does that leave VFIO? Why does VFIO need a group FD if
> everyone else doesn't?
>=20
> > IOMMU group.  This is the reality that any userspace driver needs to
> > play in, it doesn't magically go away because we drop the group file
> > descriptor. =20
>=20
> I'm not saying it does, I'm saying it makes the uAPI more regular and
> easier to fit into /dev/ioasid without the group FD.
>=20
> > It only makes the uapi more difficult to use correctly because
> > userspace drivers need to go outside of the uapi to have any idea
> > that this restriction exists. =20
>=20
> I don't think it makes any substantive difference one way or the
> other.
>=20
> With the group FD: the userspace has to read sysfs, find the list of
> devices in the group, open the group fd, create device FDs for each
> device using the name from sysfs.
>=20
> Starting from a BDF the general pseudo code is
>  group_path =3D readlink("/sys/bus/pci/devices/BDF/iommu_group")
>  group_name =3D basename(group_path)
>  group_fd =3D open("/dev/vfio/"+group_name)
>  device_fd =3D ioctl(VFIO_GROUP_GET_DEVICE_FD, BDF);
>=20
> Without the group FD: the userspace has to read sysfs, find the list
> of devices in the group and then open the device-specific cdev (found
> via sysfs) and link them to a /dev/ioasid FD.
>=20
> Starting from a BDF the general pseudo code is:
>  device_name =3D first_directory_of("/sys/bus/pci/devices/BDF/vfio/")
>  device_fd =3D open("/dev/vfio/"+device_name)
>  ioasidfd =3D open("/dev/ioasid")
>  ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)

This line is the problem.

[Historical aside: Alex's early drafts for the VFIO interface looked
quite similar to this.  Ben Herrenschmidt and myself persuaded him it
was a bad idea, and groups were developed instead.  I still think it's
a bad idea, and not just for POWER]

As Alex says, if this line fails because of the group restrictions,
that's not great because it's not very obvious what's gone wrong.  But
IMO, the success path on a multi-device group is kind of worse:
you've now made made a meaningful and visible change to the setup of
devices which are not mentioned in this line *at all*.  If you've
changed the DMA address space of this device you've also changed it
for everything else in the group - there's no getting around that.

For both those reasons, I absolutely agree with Alex that retaining
the explicit group model is valuable.

Yes, it makes set up more of a pain, but it's necessary complexity to
actually understand what's going on here.


> These two routes can have identical outcomes and identical security
> checks.
>=20
> In both cases if userspace wants a list of BDFs in the same group as
> the BDF it is interested in:
>    readdir("/sys/bus/pci/devices/BDF/iommu_group/devices")
>=20
> It seems like a very small difference to me.
>=20
> I still don't see how the group restriction gets surfaced to the
> application through the group FD. The applications I looked through
> just treat the group FD as a step on their way to get the device_fd.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ON9ZWBdFmyZZnCtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCHnFwACgkQbDjKyiDZ
s5L6fg/9EPc1aNyPljE0+EaghRaEi44E773v4bF5ZAG5AyBe2ZSOOlUmOqHzuejY
h9MEiWGeinSW7h/MjQpAZiP6DCsHILB14fiHKyaR/cC1/1s8lgKzwDsQbBeTA3Y7
Iw7+bengV/sDrRGhm140Vz1t1CnuR0Lmjrg03qtYqtEYZjsgCggtDnJFfxc4s+3g
/wvSPsx4P/1zG/v/CxLmf3wj1SG996bUXLi2EOhgxdkJYoQRGpuZ4I8AqnmB71Vl
drN0ax/eAh4R9xsrPtf/m8qyFA83HyApm9B+vuIu3yOTtw3QLuIlxXOOQhnhVUyr
FVPtEVXxq0yqyNMxA1tysZ7a528OAnBDRUrl8TchOmRaLC3u9BLtxZ8L49wOjUlc
acxGd8kwKuaKwCT6oTHcIBZnVkHPGMOOy70Q6EMW9B/S/IFbaEAAhHtpaaj3kp3s
NFdsm/XvCbBH0leKSvYul2bI6qxlWAeIbX6BvEF5i7UF6ualTv3woFpFfJqwAg/s
DOukkAD67jixAb8nX503HtDd9scDHU/klJCpxX3PAjx/jkRWLjCcTNapYVpWTQyB
OlKhVV0F+RZShQQKiAFly2MAvqDXHHeNS0y7ZJYYMtAMwr3Ow8MFy3rowFud1Y0u
9HXWEQLXSp5isygAf8X/Wn7BRg27m9HRO14alFgiCFDL3CR0HEg=
=bFJI
-----END PGP SIGNATURE-----

--ON9ZWBdFmyZZnCtm--
