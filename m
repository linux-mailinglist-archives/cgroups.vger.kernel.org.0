Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726F836D095
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 04:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhD1Cmg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 22:42:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53095 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhD1Cmg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Apr 2021 22:42:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FVNFB4FRJz9srX; Wed, 28 Apr 2021 12:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1619577710;
        bh=gE3cwxeK8l52V3mXQ8Xznwj1fLwrrrjLu8KWJT/DX9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SflghnlghzACtBYRzPNbsCJ+dAV56XMiDSEKz9RA3l5nSe+zufSUmI3DT5EaR/A3T
         BaKjdbudVH0aFttmCtWqp5/X40LE0tVirFJvWdJVJNqXw6uDi46p2SUUxuf/6kS/HU
         f/ygGsxHlo7TvpMhoX7/NxFIL1i96S+MJgESlHkE=
Date:   Wed, 28 Apr 2021 10:49:03 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
Message-ID: <YIiw/z9ohYavM/aX@yekko.fritz.box>
References: <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <MWHPR11MB1886A98D9176B5571530EF1D8C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YIec/Rt7OxvfFw7W@yekko.fritz.box>
 <20210427163954.GC1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JQRVQfh5FhbBFvT+"
Content-Disposition: inline
In-Reply-To: <20210427163954.GC1370958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--JQRVQfh5FhbBFvT+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 01:39:54PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 27, 2021 at 03:11:25PM +1000, David Gibson wrote:
>=20
> > > So your proposal sort of moves the entire container/group/domain=20
> > > managment into /dev/ioasid and then leaves vfio only provide device
> > > specific uAPI. An ioasid represents a page table (address space), thu=
s=20
> > > is equivalent to the scope of VFIO container.
> >=20
> > Right.  I don't really know how /dev/iosasid is supposed to work, and
> > so far I don't see how it conceptually differs from a container.  What
> > is it adding?
>=20
> There are three motivating topics:
>  1) /dev/vfio/vfio is only usable by VFIO and we have many interesting
>     use cases now where we need the same thing usable outside VFIO
>  2) /dev/vfio/vfio does not support modern stuff like PASID and
>     updating to support that is going to be a big change, like adding
>     multiple IOASIDs so they can be modeled as as a tree inside a
>     single FD
>  3) I understand there is some desire to revise the uAPI here a bit,
>     ie Alex mentioned the poor mapping performance.
>=20
> I would say it is not conceptually different from what VFIO calls a
> container, it is just a different uAPI with the goal to be cross
> subsystem.

Ok, that makes sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JQRVQfh5FhbBFvT+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCIsP8ACgkQbDjKyiDZ
s5LRgBAAnUYT4mzHS9z12bEDDjxIJlNISL9eC8ubKY8SIUm+mchxLYgEY3wAkoJL
eFglIjrPvJD6R2vnpBVT9z8SNbHHULxTcVcLbhb1M0Qf5TrzniLGaBfdJbrgxomz
lMTL3xTJ/djQcAeE4ulfQheA5Rh5OMmEmrFgzUUkI0y2aHK04YCyjxnxFYMSmIje
ECTKFFl4sCwH6d7mDfOvz0CcelTIuI4OvpaFPw8jdKCv8rhF56C0En63sSdrGDIm
iU2d/im/d4d7cnQfUHtcdw9neI4ia2NNYf2tIzLz2Ow9TBavv3VaeHMjUKQueKTE
Adk6pdb9yZxeKurPYFoU9Cm1mhi4zbd+K48TGAexE57xCDWSEZcr44nM4ALv8YjC
6ZCU67IEM+J/uM0XYyv99G/ctqQeyQRRw9VtxT2sM/qBiI3S+t+S80LcFXV63La9
uP/5VvEe+C5+yMatJxFkdMQ92djhlFqFFnu84vhJnQX0U9zJvEx2XvSpoc/cxOUj
uORn3Pex3YVOoh8SSIM8eJOEZxYy/Zk0EMZgP1Ub0zgD2PaS1DUqYgkVNslUZ1qs
qhkZttZsxvwsPKBLXoSSarYj6h25ic6a8vGr/GMPxZJ6EDHuivzkqsJY0owcdIus
AlCuTBNJvmY/5OUSao/MZ/XrbOXP/hCgYagOjMsTsudi3e/WYp8=
=hSc/
-----END PGP SIGNATURE-----

--JQRVQfh5FhbBFvT+--
