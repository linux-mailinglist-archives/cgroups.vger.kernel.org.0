Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B7C396D6E
	for <lists+cgroups@lfdr.de>; Tue,  1 Jun 2021 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhFAGhy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Jun 2021 02:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhFAGhx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Jun 2021 02:37:53 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD1C061574;
        Mon, 31 May 2021 23:36:12 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FvMqt6CVVz9sWD; Tue,  1 Jun 2021 16:36:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1622529370;
        bh=RcI3Lx6JqEXLQdQCTtj7ox+tPHAP/LFuk9JoMwCrYnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8TTpBDIOhwOzpuTzNz/rgTIH6GOtOp2ImFhD29VybP0A3+MY/DGJ7LOTsp0UzL0t
         NDTCwcOkwNx796SFiWI5riuLggf6GllJosGLDxvACByxmyNyqKG3MLt4g8mln6Ei+E
         fiHf3GYNn3wFrctEbMA/+GDV1CZNMv7S++8AnP9I=
Date:   Tue, 1 Jun 2021 13:45:29 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
        Alexey Kardashevskiy <aik@ozlabs.ru>, Neo Jia <cjia@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YLWtWRzO/DukUC1a@yekko>
References: <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <6b13399d-cf03-1e71-3624-c39d4d05e958@nvidia.com>
 <YK8nXKAJdfT5UVEu@yekko>
 <2476b70c-9320-a49c-efa5-fb7027e1b572@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RMasjA1xbGOcqeUG"
Content-Disposition: inline
In-Reply-To: <2476b70c-9320-a49c-efa5-fb7027e1b572@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--RMasjA1xbGOcqeUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 11:55:00PM +0530, Kirti Wankhede wrote:
>=20
>=20
> On 5/27/2021 10:30 AM, David Gibson wrote:
> > On Wed, May 26, 2021 at 02:48:03AM +0530, Kirti Wankhede wrote:
> > >=20
> > >=20
> > > On 5/26/2021 1:22 AM, Jason Gunthorpe wrote:
> > > > On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> > > >=20
> > > > > 2. iommu backed mdev devices for SRIOV where mdev device is creat=
ed per
> > > > > VF (mdev device =3D=3D VF device) then that mdev device has same =
iommu
> > > > > protection scope as VF associated to it.
> > > >=20
> > > > This doesn't require, and certainly shouldn't create, a fake group.
> > > >=20
> > > > Only the VF's real IOMMU group should be used to model an iommu dom=
ain
> > > > linked to a VF. Injecting fake groups that are proxies for real gro=
ups
> > > > only opens the possibility of security problems like David is
> > > > concerned with.
> > > >=20
> > >=20
> > > I think this security issue should be addressed by letting mdev device
> > > inherit its parent's iommu_group, i.e. VF's iommu_group here.
> >=20
> > No, that doesn't work.  AIUI part of the whole point of mdevs is to
> > allow chunks of a single PCI function to be handed out to different
> > places, because they're isolated from each other not by the system
> > IOMMU, but by a combination of MMU hardware in the hardware (e.g. in a
> > GPU card) and software in the mdev driver.
>=20
> That's correct for non-iommu backed mdev devices.
>=20
> > If mdevs inherited the
> > group of their parent device they wouldn't count as isolated from each
> > other, which they should.
> >=20
>=20
> For iommu backed mdev devices for SRIOV, where there can be single mdev
> device for its parent, here parent device is VF, there can't be multiple
> mdev devices associated with that VF. In this case mdev can inherit the
> group of parent device.

Ah, yes, if there's just one mdev for the PCI function, and the
function doesn't have an internal memory protection unit then this
makes sense.

Which means we *do* have at least two meaningfully different group
configurations for mdev:
  * mdev is in a singleton group independent of the parent PCI device
  * mdev shares a group with its parent PCI device

Which means even in the case of mdevs, the group structure is *not* a
meaningless fiction.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RMasjA1xbGOcqeUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC1rVYACgkQbDjKyiDZ
s5LMVxAAsYLjKEMctzEWQ3xVpx/4Hfkf2mPGV/JzCIgHCBaT6eaYbHpLCAGtpuLQ
Vd7VkM2Ytcl+x9AKw2ssd0VHn9t8VaS1bSshJRCUoaIAN2Nu/HhwQ7IArsS4ro25
FvsIoALYpr9dwp7u9c2fVAOB8hWPyRH4li3k/xLY1H6c/OSMNhMUyAvOX9iaFQk4
Fw0/nLH/y17Vf9w1WEqS/X0ePMI0TK8W5UtUjXMOK//3M7jyFsodKLNblNDVnPHg
BUUFrkmWgLw7pXHYaDnvW411cSRkQ1bzUyMC9Jad6FwdWY/Y9fmuvu/oTvD9fjUS
vjlxcrIzo/e/AJn9WStMp4FB2PA0iAlonSghB0y1Zxar4eGLjPqC9rEKQ8o1Z2O0
oKrSZ4JRRGW1c3NBxg9NWIdg1nsn/TdKo3XysOf8a7HexVf0fbz9FWwy4OJ3M0uv
g5LpDFlb6CFA7ZSs+Crro+PvfWMxp6CR86S9gnN+emo3zw5dDejWgitJeRW2Jsox
CJMc3+1fVmhUAlgzCvnf5W9vlshod9Nhs32NxQCNxHGEuWUFDQu/mnw2CqGxhWjf
/KFmvOCm/S0Qo3h1eaadoiRqEhX7uEqW1cuCfxBp4wg3I85nAJEtct1CYUCzsV0q
ytCWdEh6AQg7aJB0KMrC5TWXGp4vrCn+Dm9tFqXnMMZnVmQ5QZY=
=vGLv
-----END PGP SIGNATURE-----

--RMasjA1xbGOcqeUG--
