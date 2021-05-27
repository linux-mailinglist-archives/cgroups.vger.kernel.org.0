Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4F392836
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 09:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhE0HOK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhE0HOD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 03:14:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4CEC061760;
        Thu, 27 May 2021 00:12:25 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FrJsx3L8Cz9sXG; Thu, 27 May 2021 17:12:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1622099541;
        bh=q2H5aSayYZmCdH2b9xpnmQ/7FqSCaVqs53HOObLxnRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEwVCcUONIAnyb/P2jI7GBeihwirasiXWjARYzW4I85zhlWvC2TGRqELP3uDTLsTa
         Us+5eJYQI/MotzMh8d+E8kxLFNd6GereguIYwXvx1PLJtJ3jdDlEmFGPpLOWAvoczA
         14jsdic9Q6A0H19LoO46U6myhUnjqs34kFS5Jnew=
Date:   Thu, 27 May 2021 14:53:42 +1000
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
Message-ID: <YK8l1mZ0NVggAVUO@yekko>
References: <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jHax4+77yf7k37tQ"
Content-Disposition: inline
In-Reply-To: <20210524233744.GT1002214@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--jHax4+77yf7k37tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 08:37:44PM -0300, Jason Gunthorpe wrote:
> On Mon, May 24, 2021 at 05:52:58PM +1000, David Gibson wrote:
>=20
> > > > I don't really see a semantic distinction between "always one-device
> > > > groups" and "groups don't matter".  Really the only way you can aff=
ord
> > > > to not care about groups is if they're singletons.
> > >=20
> > > The kernel driver under the mdev may not be in an "always one-device"
> > > group.
> >=20
> > I don't really understand what you mean by that.
>=20
> I mean the group of the mdev's actual DMA device may have multiple
> things in it.
> =20
> > > It is a kernel driver so the only thing we know and care about is that
> > > all devices in the HW group are bound to kernel drivers.
> > >=20
> > > The vfio device that spawns from this kernel driver is really a
> > > "groups don't matter" vfio device because at the IOMMU layer it should
> > > be riding on the physical group of the kernel driver.  At the VFIO
> > > layer we no longer care about the group abstraction because the system
> > > guarentees isolation in some other way.
> >=20
> > Uh.. I don't really know how mdevs are isolated from each other.  I
> > thought it was because the physical device providing the mdevs
> > effectively had an internal IOMMU (or at least DMA permissioning) to
> > isolate the mdevs, even though the physical device may not be fully
> > isolated.
> >=20
> > In that case the virtual mdev is effectively in a singleton group,
> > which is different from the group of its parent device.
>=20
> That is one way to view it, but it means creating a whole group
> infrastructure and abusing the IOMMU stack just to create this
> nonsense fiction.

It's a nonsense fiction until it's not, at which point it will bite
you in the arse.

> We also abuse the VFIO container stuff to hackily
> create several different types pf IOMMU uAPIs for the mdev - all of
> which are unrelated to drivers/iommu.
>=20
> Basically, there is no drivers/iommu thing involved, thus is no really
> iommu group, for mdev it is all a big hacky lie.

Well, "iommu" group might not be the best name, but hardware isolation
is still a real concern here, even if it's not entirely related to the
IOMMU.

> > If the physical device had a bug which meant the mdevs *weren't*
> > properly isolated from each other, then those mdevs would share a
> > group, and you *would* care about it.  Depending on how the isolation
> > failed the mdevs might or might not also share a group with the parent
> > physical device.
>=20
> That isn't a real scenario.. mdevs that can't be isolated just
> wouldn't be useful to exist

Really?  So what do you do when you discover some mdevs you thought
were isolated actually aren't due to a hardware bug?  Drop support
=66rom the driver entirely?  In which case what do you say to the people
who understandably complain "but... we had all the mdevs in one guest
anyway, we don't care if they're not isolated"?

> > > This is today's model, yes. When you run dpdk on a multi-group device
> > > vfio already ensures that all the device groups remained parked and
> > > inaccessible.
> >=20
> > I'm not really following what you're saying there.
> >=20
> > If you have a multi-device group, and dpdk is using one device in it,
> > VFIO *does not* (and cannot) ensure that other devices in the group
> > are parked and inaccessible. =20
>=20
> I mean in the sense that no other user space can open those devices
> and no kernel driver can later be attached to them.

Ok.

> > It ensures that they're parked at the moment the group moves from
> > kernel to userspace ownership, but it can't prevent dpdk from
> > accessing and unparking those devices via peer to peer DMA.
>=20
> Right, and adding all this group stuff did nothing to alert the poor
> admin that is running DPDK to this risk.

Didn't it?  Seems to me the admin that in order to give the group to
DPDK, the admin had to find and unbind all the things in it... so is
therefore aware that they're giving everything in it to DPDK.

> > > If the administator configures the system with different security
> > > labels for different VFIO devices then yes removing groups makes this
> > > more tricky as all devices in the group should have the same label.
> >=20
> > That seems a bigger problem than "more tricky".  How would you propose
> > addressing this with your device-first model?
>=20
> You put the same security labels you'd put on the group to the devices
> that consitute the group. It is only more tricky in the sense that the
> script that would have to do this will need to do more than ID the
> group to label but also ID the device members of the group and label
> their char nodes.

Well, I guess, if you take the view that root is allowed to break the
kernel.  I tend to prefer that although root can obviously break the
kernel if they intend do, we should make it hard to do by accident -
which in this case would mean the kernel *enforcing* that the devices
in the group have the same security labels, which I can't really see
how to do without an exposed group.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jHax4+77yf7k37tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCvJdQACgkQbDjKyiDZ
s5LX5g//Tg6h2fX9WzW87g+SOHMeJIsvjlnyefT9P0m1W0y4+uqrIluiR7HIjtPt
xWcBK1QgEyq5HZFQaGF790FhMoZxATnu3357ej2Ib7PPyxTYSvzZrHnTsReFoJrz
ePbXbiROS/BgQF81CZ/lo39pOvBBBVTgC5VJSoUPm0MZTAGIyQfdbbLk9a4h2Pau
TwrhMLEBi3npUTNA8GoCdFOrQzQHQ2DybL3/WKMGzUGVE/z+4kCOFsumwNx31C8C
L2wODxykBEKwWNUz4Sky4TNQtkeKXmnujRhgSFo03BqnbigFgSmTUu7Zvv8LYlxB
qW6V8ZRLdakvN+n5HFoHTsKC68jcx5lv6kHlcwYu3vbeTjapxpYLfUFMWh5tRLzT
TN6KnEgls6dkjcd0LHNf3xz4HZKuUgr5gBDJRyaG12SBxGNnvnhJ7FXouOLotN/W
AAmcBogVG21wiqZvRX1BJSaQGlmF0gFNbJIiNzUgX0Yp0ybrnX1nDjtod+2sVtIF
t71/dV84+idXo/bP0oix0NVj5yzU7SgnxngoDeVNDZ9bgyCfvUwnpDI1YJ1HgkEx
Gmi1E8OI9JoNp7AGVde6S/EGojYApBBkNHOQqjG2mU+k1g428wrVz1iGrytk3aoG
IiU4/pNk1+BEgmyQ5jKlmOsIQTIp1Zh8f+ZS9dvXJZj1cGHEF1k=
=pDjM
-----END PGP SIGNATURE-----

--jHax4+77yf7k37tQ--
