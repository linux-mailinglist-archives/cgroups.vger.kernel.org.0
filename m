Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3B3724D9
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 06:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhEDETQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 00:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDETP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 00:19:15 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD6C061574;
        Mon,  3 May 2021 21:18:21 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FZ65j4PK5z9sSs; Tue,  4 May 2021 14:18:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1620101897;
        bh=GF4kY9gVsGuwV9dXBjYISsLPpgjK/7dHag6l9MAWxKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFVVpB9WNCZN/OHDK7EFnFAqgxNmT0o6j8dz6VB4dGaDgHpoypxvLCGbts5YHK+rc
         /0GWhCoUlX/gdFz9pMVsCPN56Kbv7o9hKTFl972XyyuWKzbIa3TPAw6YsykdDcjnop
         Pv6BeZTFIqQGE9whKr7bxNbIOfV+YYaDGYHwm4S8=
Date:   Tue, 4 May 2021 13:54:55 +1000
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
Message-ID: <YJDFj+sAv41JRIo4@yekko>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com>
 <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XJz7RUBFhCVAE36r"
Content-Disposition: inline
In-Reply-To: <20210503160530.GL1370958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--XJz7RUBFhCVAE36r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 03, 2021 at 01:05:30PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 29, 2021 at 01:20:22PM +1000, David Gibson wrote:
> > > There is a certain appeal to having some
> > > 'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of extra
> > > information like windows that can be optionally called by the viommu
> > > driver and it remains well defined and described.
> >=20
> > Windows really aren't ppc specific.  They're absolutely there on x86
> > and everything else as well - it's just that people are used to having
> > a window at 0..<something largish> that you can often get away with
> > treating it sloppily.
>=20
> My point is this detailed control seems to go on to more than just
> windows. As you say the vIOMMU is emulating specific HW that needs to
> have kernel interfaces to match it exactly.

It's really not that bad.  The case of emulating the PAPR vIOMMU on
something else is relatively easy, because all updates to the IO page
tables go through hypercalls.  So, as long as the backend IOMMU can
map all the IOVAs that the guest IOMMU can, then qemu's implementation
of those hypercalls just needs to put an equivalent mapping in the
backend, which it can do with a generic VFIO_DMA_MAP.

vIOMMUs with page tables in guest memory are harder, but only really
in the usual ways that a vIOMMU of that type is harder (needs cache
mode or whatever).  At whatever point you need to shadow from the
guest IO page tables to the host backend, you can again do that with
generic maps, as long as the backend supports the necessary IOVAs, and
has an IO page size that's equal to or a submultiple of the vIOMMU
page size.

> I'm remarking that trying to unify every HW IOMMU implementation that
> ever has/will exist into a generic API complete enough to allow the
> vIOMMU to be created is likely to result in an API too complicated to
> understand..

Maybe not every one, but I think we can get a pretty wide range with a
reasonable interface.  Explicitly handling IOVA windows does most of
it.  And we kind of need to handle that anyway to expose what ranges
the IOMMU is capable of translating anyway.  I think making handling
valid IOVA windows explicit makes things simpler than having
per-backend-family interfaces to expose the limits of their
translation ranges, which is what's likely to happen without it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XJz7RUBFhCVAE36r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCQxY0ACgkQbDjKyiDZ
s5Ja1Q//brgY0BJodmvSW7+qUlkQBKlmerMDnujEgNgBr6cbpA9hN6ywQDlkXit7
xrznyLqBx16060E9F6DQqk1aaAj2+iePxmT97vs7MUHmvuXHgTlmU6T6DDC84ICk
cCIfpXsB5R+pDv0JD/j91cPQBZF1Afnf0KhRLpzjcNKgBoFWi23pAYx3E32nPVtb
1UeflnMCMdr/rHfQR9/GoJ5FP/QYvqppU7351C0yFKbI5k0Pg7RvO41pejcNKE2W
q4wmfrzPA9/7G+JtQr03lGXLVy4+xN0UPsRtxkhQtaX+YNKBVL3qb+oO4XeCf7zw
Zw5vw6Ai8reTK948BEe+S+WJZHHAYBw54ztv7P35XFjR3/avEEPWgSIrba6fAeRZ
0E+RWhYL4c09hGpbJk6FiwTan+2a7EgB90ZuanWFtJ8HCFOFSDI3IRoLVU7k7JLC
IQD7LGmsqWzhMf3FtAK++FiVeWu+NpMPGGBx3XXfSl7kWXzf9CUJRFHLv+wPK0vc
Fln92Fj3HBM3D7keiZ85teYT6G5SacTcmtJTHTfsqqmVlTdVCconk7/y0wQhMDt5
TAfzd8YH0dq6toDJqOZzqZKwGmgaYe9HviiRWa5+C6Y3QJ0dBBN6cUKKZhTKeicd
ifZUPO7PC9KjomC7UWcx6g/pN7eNPSZR2YR+Lb0hATzgCVDkcUg=
=OhAa
-----END PGP SIGNATURE-----

--XJz7RUBFhCVAE36r--
