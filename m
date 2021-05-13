Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0899037F2C5
	for <lists+cgroups@lfdr.de>; Thu, 13 May 2021 08:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhEMGIX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 May 2021 02:08:23 -0400
Received: from ozlabs.org ([203.11.71.1]:51273 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhEMGIX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 13 May 2021 02:08:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4Fgh5D5rYVz9sWc; Thu, 13 May 2021 16:07:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1620886032;
        bh=Mzje6I+4XJ3y6Iby/DAYOwVFavVRAAtc7j9XmkVCAVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fP8u4nZiemlt/gTVvVqI6DnRAk7mDCvbaRIlDJrKeD5SvLwwmy+GW6TfJFQ2/gSHB
         EqigWrZpgStjiMYr1jY37zqkpZhEn9oghhaM+wAfRTSiOW9d+b6/s2r17OOjmh2koT
         YjPtcV1K73vL8uyeJRjiE+vbeFX1lv+Y/RkyWHWk=
Date:   Thu, 13 May 2021 15:48:19 +1000
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
Message-ID: <YJy9o8uEZs42/qDM@yekko>
References: <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ArI7kS42Lc+0E4RS"
Content-Disposition: inline
In-Reply-To: <20210503161518.GM1370958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ArI7kS42Lc+0E4RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 03, 2021 at 01:15:18PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 29, 2021 at 01:04:05PM +1000, David Gibson wrote:
> > Again, I don't know enough about VDPA to make sense of that.  Are we
> > essentially talking non-PCI virtual devices here?  In which case you
> > could define the VDPA "bus" to always have one-device groups.
>=20
> It is much worse than that.
>=20
> What these non-PCI devices need is for the kernel driver to be part of
> the IOMMU group of the underlying PCI device but tell VFIO land that
> "groups don't matter"

I don't really see a semantic distinction between "always one-device
groups" and "groups don't matter".  Really the only way you can afford
to not care about groups is if they're singletons.

> Today mdev tries to fake this by using singleton iommu groups, but it
> is really horrible and direcly hacks up the VFIO IOMMU code to
> understand these special cases. Intel was proposing more special
> hacking in the VFIO IOMMU code to extend this to PASID.

At this stage I don't really understand why that would end up so
horrible.

> When we get to a /dev/ioasid this is all nonsense. The kernel device
> driver is going to have to tell drivers/iommu exactly what kind of
> ioasid it can accept, be it a PASID inside a kernel owned group, a SW
> emulated 'mdev' ioasid, or whatever.
>=20
> In these cases the "group" idea has become a fiction that just creates
> a pain.

I don't see how the group is a fiction in this instance.  You can
still have devices that can't be isolated, therefore you can have
non-singleton groups.

> "Just reorganize VDPA to do something insane with the driver
> core so we can create a dummy group to satisfy an unnecessary uAPI
> restriction" is not a very compelling argument.
>=20
> So if the nonsensical groups goes away for PASID/mdev, where does it
> leave the uAPI in other cases?
>=20
> > I don't think simplified-but-wrong is a good goal.  The thing about
> > groups is that if they're there, you can't just "not care" about them,
> > they affect you whether you like it or not.
>=20
> You really can. If one thing claims the group then all the other group
> devices become locked out.

Aside: I'm primarily using "group" to mean the underlying hardware
unit, not the vfio construct on top of it, I'm not sure that's been
clear throughout.

So.. your model assumes that every device has a safe quiescent state
where it won't do any harm until poked, whether its group is
currently kernel owned, or owned by a userspace that doesn't know
anything about it.

At minimum this does mean that in order to use one device in the group
you must have permission to use *all* the devices in the group -
otherwise you may be able to operate a device you don't have
permission to by DMAing to its registers from a device you do have
permission to.

Whatever scripts are managing ownership of devices also need to know
about groups, because they need to put all the devices into that
quiescent state before the group can change ownership.

> The main point to understand is that groups are NOT an application
> restriction! It is a whole system restriction that the operator needs
> to understand and deal with. This is why things like dpdk don't care
> about the group at all - there is nothing they can do with the
> information.
>=20
> If the operator says to run dpdk on a specific device then the
> operator is the one that has to deal with all the other devices in the
> group getting locked out.

Ok, I think I see your point there.

> At best the application can make it more obvious that the operator is
> doing something dangerous, but the current kernel API doesn't seem to
> really support that either.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ArI7kS42Lc+0E4RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCcvaAACgkQbDjKyiDZ
s5L5IRAAg97CW+pGNxknG14IgrfUjPSBK7pDccMXtD7eVUa3BEynUYKrHHTYj7q/
EzRpFRjsIwkC8NT7lBlsCrZIL/sS1LD+zveqDYNaBIs46681UKlg5enXxZoEcTGi
WRUmWMgXhOnhrVQMB/G1TZLanViDvzHpBau0ALyX0buvg1bpkvToX7AiKvqNzv07
IKaeG23DeXI9o2M0Jh6v5UFDLA90LktEqtxsvfbqQPYY+JJWtdV3WBcYOKsHe3j4
ZFfIqOlBOsGA27BWZQucmyxtFjQfNbCB9QQO28MAcOs+A1fIwtRi4ZVNuBEQos38
3cN5riTTE4+p63WU4kEWiP3nTX3irEKQD3W5aMy1Yk8STxgBwuL5FerquBssnV4i
h362Q9JPTadeDOX1sVmDFM2Ms/WLh1fG2zGvRtOwsTwCYhWoDAziz8BYLWoHFCYY
y3DctIOZxQaK5NZjiABNbxW9y14zFWzq9aqAfyb06Cz/rDgkSBMAclfD4/DOF7ic
s0gPcVm/xFk7d4KvOD8u3tf9Q4Uk2s3jcJmXmblPF88nAjSknZj3o4/H7o1feD9x
ym2WSkkHYfC2Yq+FFCNyeXNDUQVH7PUA5DfcAaV8jygtdNo/edcZNI2pKwuRxVyU
KL0RtZY77wWQF88q+iSxIjeVgRbBxSslOVSXH40O0aJsO8+cNAQ=
=S7A7
-----END PGP SIGNATURE-----

--ArI7kS42Lc+0E4RS--
