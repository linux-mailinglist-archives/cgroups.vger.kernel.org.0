Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85B737F2C7
	for <lists+cgroups@lfdr.de>; Thu, 13 May 2021 08:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhEMGIZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 May 2021 02:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhEMGIY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 May 2021 02:08:24 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D2C061574;
        Wed, 12 May 2021 23:07:15 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4Fgh5D6YwQz9sWl; Thu, 13 May 2021 16:07:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1620886032;
        bh=EDbwQxFNCJJrrEgHzT5gGi+1oWXpdmyJr1eJ+NUQ4bM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWqsHMbOiAyxwLod+Rqt4KhSwB2oo0bV5TchI5WxvF3IL2lqztrJrQv615kgKUDnS
         rvOjRZCfVWenSYZrOWPrRga+vGFG2OWEIfQgUnlH6IFYpycIGoxJyhVRhtXU4RZ9Gc
         02pKAkrH9LTvDiy9LdpyASoaGfwW0N2RNDDTSEfE=
Date:   Thu, 13 May 2021 16:07:07 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
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
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YJzCC18cQDdKMR6p@yekko>
References: <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com>
 <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com>
 <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com>
 <7e5c2276-ca1c-a8af-c15f-72a7c83c8bfa@ozlabs.ru>
 <20210505163902.GG1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Mf++rjztzZShRAS"
Content-Disposition: inline
In-Reply-To: <20210505163902.GG1370958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--/Mf++rjztzZShRAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2021 at 01:39:02PM -0300, Jason Gunthorpe wrote:
> On Wed, May 05, 2021 at 02:28:53PM +1000, Alexey Kardashevskiy wrote:
>=20
> > This is a good feature in general when let's say there is a linux suppo=
rted
> > device which has a proprietary device firmware update tool which only e=
xists
> > as an x86 binary and your hardware is not x86 - running qemu + vfio in =
full
> > emulation would provide a way to run the tool to update a physical devi=
ce.
>=20
> That specific use case doesn't really need a vIOMMU though, does it?

Possibly not, but the mechanics needed to do vIOMMU on different host
IOMMU aren't really different from what you need for a no-vIOMMU
guest.  With a vIOMMU you need to map guest IOVA space into the host
IOVA space.  With no no-vIOMMU you need to map guest physical
addresses into the host IOVA space.  In either case the GPA/gIOVA to
userspace and userspace to HPA mappings are basically arbitrary.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Mf++rjztzZShRAS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCcwgsACgkQbDjKyiDZ
s5JqLg/+Px9hBLz/IZ8N6Bl1BLwug0BbIEk1xxrBhtyubIdEbf6AuAkqa0HnxcSm
EgS1KJ0eOe3yLUKaLskepCJDojbuqFYnLf1VTv3Uu0zp5AP8ggKQgfokxUVJdhpR
aWMVjwOFAoUatYTP2umFN2ZfUsSxe/FsTkdTiAVApqn4AdTSlbGBvK+C4D7WPzZy
5rjVhgLfaQWJDGrTnhqCr4PJoz0z1FpOhzYXtpHR+u+d9BgDe2yj1gEFzICDk+UV
67QOqTNxWi1gSQ6uVa+xmB+xY0RZ7+x+fwObNBHrGWuFKJzwbf6aCQIprqEY5mro
9KAR0kP3LkywUN+rZjWQun9pXQdu/JWjZPtmdbm4rw+kIJEDdMk9TrOohOpjxUot
7vSoLVklFyMbnL84I3i7CELRxpkvtXaBd5VdGkEObg5nCcY8Fci8yLmhjOLXviGU
iNmRCaiZikT+JKvnwiG7qIILT3DCA92Y+AiQYayPkmujhlmzxpFkyAM1Igh7EIfe
a4O/U8qm61xxoTZhe+cbM11cIfiux8FwcxUrq54D1DCZstQ60IP/FaA4CQGSiBwm
55RNfJf+KFN9HG9hxH8BZYEGRtCYMuDfTjFdM0DaYHI8Rjv3X9MO4vuSI1tkoiQd
kW7n1QyP2QKMzSHCJlE56aSa9T6HTtUetOuO3vAxirN9Z5/042I=
=S/vm
-----END PGP SIGNATURE-----

--/Mf++rjztzZShRAS--
