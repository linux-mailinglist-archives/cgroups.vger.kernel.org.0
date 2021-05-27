Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4A1392831
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 09:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhE0HNz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 03:13:55 -0400
Received: from ozlabs.org ([203.11.71.1]:57533 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234684AbhE0HNz (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 May 2021 03:13:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FrJsx2tB6z9sWp; Thu, 27 May 2021 17:12:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1622099541;
        bh=/Vk6QIsfClarCnHuWF3h00g/TTHnE4TtoS0mH61nSvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBJfr7UYZPAGjibTLx3tnWLHnRpaUShxpkGQgtqAMqSU1cRDoZa5GzhsXCRFM76n6
         /2dBtWmxbyYYr4V+CxP4PSVzAwF4AD4T2TGF1pIXK0c44UNAZyDsnE8zGdVBo4KZpb
         3ivmm4aCrXG/e3Jm6+/nRQqIJ3rfH7ZWRNAOeov4=
Date:   Thu, 27 May 2021 14:58:30 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
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
Message-ID: <YK8m9jNuvEzlXWlu@yekko>
References: <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rKeY89V0ifZRRhP6"
Content-Disposition: inline
In-Reply-To: <20210525195257.GG1002214@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--rKeY89V0ifZRRhP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 04:52:57PM -0300, Jason Gunthorpe wrote:
> On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
>=20
> > 2. iommu backed mdev devices for SRIOV where mdev device is created per
> > VF (mdev device =3D=3D VF device) then that mdev device has same iommu
> > protection scope as VF associated to it.=20
>=20
> This doesn't require, and certainly shouldn't create, a fake group.

It's only fake if you start with a narrow view of what a group is.  A
group is a set of devices (in the kernel sense of "device", not
necessarily the hardware sense) which can't be isolated from each
other.  The mdev device is a kernel device, and if working as intended
it can be isolated from everything else, and is therefore in an
absolute bona fide group of its own.

> Only the VF's real IOMMU group should be used to model an iommu domain
> linked to a VF. Injecting fake groups that are proxies for real groups
> only opens the possibility of security problems like David is
> concerned with.

It's not a proxy for a real group, it's a group of its own.  If you
discover that (due to a hardware bug, for example) the mdev is *not*
properly isolated from its parent PCI device, then both the mdev
virtual device *and* the physical PCI device are in the same group.
Groups including devices of different types and on different buses
were considered from the start, and are precedented, if rare.

> Max's series approaches this properly by fully linking the struct
> pci_device of the VF throughout the entire VFIO scheme, including the
> group and container, while still allowing override of various VFIO
> operations.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rKeY89V0ifZRRhP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCvJvYACgkQbDjKyiDZ
s5IEqBAAp3p5NH8nnJVVcGSVZxbNrLeTTJqPwhNtEEsveVKJd5BmHf3EvT4BqqnK
rXisyd2ygrY8fO1DiLJOa/WM6FDA05WD0XkqyDJ2XUFAOEHpyY0EesSw7CqSl1zz
V2dbprWQAD9nJoPG/fidBsmuYEwpxjvptttrf1yEgFe+isfJLdalJbA+k/kfZOdd
F4BL6+mtySC2DoKnQqoDQYCsXrSNzsYgv6SDbj4W7izUuOqYFADN7qawINcxAEBa
I43JXW3Dhx3aLzL0JeEjFf2j/f1YMQo/RfkfLg9OWuHdsF+SF8+5lcikGWtjBZKT
pC443P1CHOmJkW0TMr9Pz2lHJfjlcTaIq35qpaEP23tKmS60FDoLIvWPlFJYidaz
tWDNMtMmS8UbcyzF868ZJiRc94+A8RTFFW7hSmHQoqLnxMqNnUoyOKrZ2ehaqg+j
JjbsxFq37+jun2Fb2BxwPg+F2jFQmaw7l6FCdhePKc/h/HeCRPpZ+jTqF6AEqdU1
KrET9bw9TE3euBNQK62gJNfdIdrkBelfcUjKluxCWamoHFeJBEnBKbqGR4wn0Jqg
QucFQtoKZyEIXVKFtK0Pedz46dzxc5iH1hj+eIAGLw92/SIjWzVYEp6vCZYHxNSk
VQFvdHTLJJ8vRVhLGJlo5Ji4EX+jgb9i7eIufxgqD+SxhzOoRvo=
=ygK9
-----END PGP SIGNATURE-----

--rKeY89V0ifZRRhP6--
