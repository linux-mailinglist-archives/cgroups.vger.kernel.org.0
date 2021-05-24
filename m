Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7437A38E209
	for <lists+cgroups@lfdr.de>; Mon, 24 May 2021 09:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhEXH5k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 May 2021 03:57:40 -0400
Received: from ozlabs.org ([203.11.71.1]:59229 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232254AbhEXH5k (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 24 May 2021 03:57:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FpTzt3P3Mz9sPf; Mon, 24 May 2021 17:56:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1621842970;
        bh=C/hH2K1GEBPadXoSrKk7V2ObPasOjkp3z+Am5C3tgTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlkI23zR6q71HmYnJJ3f9KWdOEkVnA6VgflwcXorCZ+xSlbOn80eH8qqkj1bGiDwr
         KC9B7UJXnzhSsKRs2ic63ipbacchSoGdi4E458+5M7iaEJIuB0k7HuIOJAPxbDK6pB
         dK2O+tSql9Eour4tx4hSxxkcAjj0iCOHwEc2IDJA=
Date:   Mon, 24 May 2021 17:56:05 +1000
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
Message-ID: <YKtcFdW9U2+iW4cM@yekko>
References: <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com>
 <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com>
 <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com>
 <7e5c2276-ca1c-a8af-c15f-72a7c83c8bfa@ozlabs.ru>
 <20210505163902.GG1370958@nvidia.com>
 <YJzCC18cQDdKMR6p@yekko>
 <20210513135030.GF1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qdaYK/TYh/pdg5Us"
Content-Disposition: inline
In-Reply-To: <20210513135030.GF1002214@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--qdaYK/TYh/pdg5Us
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2021 at 10:50:30AM -0300, Jason Gunthorpe wrote:
> On Thu, May 13, 2021 at 04:07:07PM +1000, David Gibson wrote:
> > On Wed, May 05, 2021 at 01:39:02PM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 05, 2021 at 02:28:53PM +1000, Alexey Kardashevskiy wrote:
> > >=20
> > > > This is a good feature in general when let's say there is a linux s=
upported
> > > > device which has a proprietary device firmware update tool which on=
ly exists
> > > > as an x86 binary and your hardware is not x86 - running qemu + vfio=
 in full
> > > > emulation would provide a way to run the tool to update a physical =
device.
> > >=20
> > > That specific use case doesn't really need a vIOMMU though, does it?
> >=20
> > Possibly not, but the mechanics needed to do vIOMMU on different host
> > IOMMU aren't really different from what you need for a no-vIOMMU
> > guest. =20
>=20
> For very simple vIOMMUs this might be true, but this new features of nest=
ing
> PASID, migration, etc, etc all make the vIOMMU complicated and
> emuluating it completely alot harder.

Well, sure, emulating a complex vIOMMU is complex. But "very simple
vIOMMUs" covers the vast majority of currently deployed hardware, and
several are already emulated by qemu.

> Stuffing a vfio-pci into a guest and creating a physical map using a
> single IOASID is comparably trivial.

Note that for PAPR (POWER guest) systems this is not an option: the
PAPR platform *always* has a vIOMMU.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qdaYK/TYh/pdg5Us
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCrXBUACgkQbDjKyiDZ
s5IBMw/6AomCVLmh/8hoxD3OLa7DsF2qksrpcbo5JXuotCrUKLd+NER23oRbTekN
8HQ/YKfUWhmFlGh9NeBcjjUjkm/ru1HFa3vbGfQIrVWxabmQX9vQSjKDc/qvQlKB
ApOyT0PNJuHFy8rZNB7vrpd9zP9xhV1gKLk5nxmmPHeITxA2ZLrZSlfMkRhIG5vP
3xpnCB8KoycgXBsYbLCi50o11TxhVlYWoujMA/I69mLgfqFoxTy3+zz99RtEEnY9
Nqf3jnnpL+5tCu8gBZD2actRlu0jrnXU6nyYleOy89Sr2ZjrOM73cfrkrJjhuTa6
hdQVhb8XgS1HQPiELvT2WCVVQkfAG1ss0HcPi2Wt+JvVnxeQ4kNixS8ZNwh/X9/Q
lMVqY0OsG8Gz38XftHA3oj20IyAKeVYfXkQJLougTadA3/ydrOELNB169PPHtggT
qtgvOFogrmYKJyaGQaQvWIWmHd63OYqVxycbu2fimxeuM4kMxgU5ERWo6caXHLz+
bZfdkrRUW1vCGoMfjqpjG4OgDhnLwz4PUfy7tKdh6Ek4TGe0OUHYxcMcJI28AIii
jnapbsmXzLYgsyHou+UYRwtLPrIOjOpRh3eDRzfRDtI1HQBWG1RBKkJdqUf1r5FW
r45iEZaQ+AdySJsDkfCc7+SDhLx4AO8z6RuoKgukxPR6E5D8Z9c=
=GQEt
-----END PGP SIGNATURE-----

--qdaYK/TYh/pdg5Us--
