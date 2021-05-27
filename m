Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024F7392837
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 09:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhE0HOL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 03:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhE0HOD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 03:14:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F81C061574;
        Thu, 27 May 2021 00:12:25 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FrJsx3nZ0z9sX5; Thu, 27 May 2021 17:12:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1622099541;
        bh=Lefrtr63WtZPzxCJD/a0Dt0CwKqdjDj9tbK9ydRsQZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMUbeAdG8FfOw30NsEJoAerE2i88uoQM3TbXYsIqJzw49r1s6kG8D5t4trO1VCikP
         +rVJ2VxCicTOzRkJBR0xiHrYjWjJgK1YyFW/0R83MMdBht/clN1NyHUc7DS35Yjt17
         S75HTnNVpEtzMDbFQRWK1Q6j/r/BpiosihFY3ZeM=
Date:   Thu, 27 May 2021 15:00:12 +1000
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
Message-ID: <YK8nXKAJdfT5UVEu@yekko>
References: <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <6b13399d-cf03-1e71-3624-c39d4d05e958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z64+IwN5nyf9pBFr"
Content-Disposition: inline
In-Reply-To: <6b13399d-cf03-1e71-3624-c39d4d05e958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Z64+IwN5nyf9pBFr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 02:48:03AM +0530, Kirti Wankhede wrote:
>=20
>=20
> On 5/26/2021 1:22 AM, Jason Gunthorpe wrote:
> > On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> >=20
> > > 2. iommu backed mdev devices for SRIOV where mdev device is created p=
er
> > > VF (mdev device =3D=3D VF device) then that mdev device has same iommu
> > > protection scope as VF associated to it.
> >=20
> > This doesn't require, and certainly shouldn't create, a fake group.
> >=20
> > Only the VF's real IOMMU group should be used to model an iommu domain
> > linked to a VF. Injecting fake groups that are proxies for real groups
> > only opens the possibility of security problems like David is
> > concerned with.
> >=20
>=20
> I think this security issue should be addressed by letting mdev device
> inherit its parent's iommu_group, i.e. VF's iommu_group here.

No, that doesn't work.  AIUI part of the whole point of mdevs is to
allow chunks of a single PCI function to be handed out to different
places, because they're isolated from each other not by the system
IOMMU, but by a combination of MMU hardware in the hardware (e.g. in a
GPU card) and software in the mdev driver.  If mdevs inherited the
group of their parent device they wouldn't count as isolated from each
other, which they should.

>=20
> Kirti
>=20
> > Max's series approaches this properly by fully linking the struct
> > pci_device of the VF throughout the entire VFIO scheme, including the
> > group and container, while still allowing override of various VFIO
> > operations.
> >=20
> > Jason
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z64+IwN5nyf9pBFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCvJ1wACgkQbDjKyiDZ
s5LA1A/9HdoNik7wBiSYXbYApT72IFI+LhekrRCOipo8yeKeq0f2VM5RS34wrfFw
1Uhvw2jZYG8HWgG6XQczVwGyXtXtKQQL/S8djvv2Nqp3xY+++sPj2HO1xy7051m6
UpAR0ILjYOHTzj4DQI4uR7iRt6JcfK6+gedGouV++4suDp95Ta4xBo5rLBkjqn8l
VrPRt6AVMCYvVRcDb6iRhofAvhFOIjGJfarivrhPS3BzDCBrk2/BXxQ61lYy1dR9
8qqb3CFFQWbyfgtaQXz8gAQLULpWX10Ob2tUaQRrWz3iZG0H/Iq5ffX3PPuQUsjg
fIs8GH7xxWe0/7tUVzS+iwhGwcS7TmA5uktxiITJHNB/aDG3yQpzLNoLGn9fQP6h
POpSLPQY1MyPvTO9ZF91celXdAZialXuchORnG+zHmzDcG0z1NPUYORzmR0G8D8V
tuCAUL/3ayA5pR6j0X4zcpWmn32CQyC6WJ113cDDQga7fFXCbyw7zilXISGRcxHY
7PA6tsnrBbVpuuYsJINgP/NM/eHgW1U07NSiNyIjj8UNPJPjGYFm/8obYwwXTIbF
Fqv0tBPGrmq9rKbfG9Xl12SVKMdmF7f1wHVNLc6SUvUiAIVswax4YPMJmiBBoSZ9
dbzfFlE13orgt8fbZ+nYuBx9L7xc2E+kNJcw/7a45nldRaqkH8U=
=yhde
-----END PGP SIGNATURE-----

--Z64+IwN5nyf9pBFr--
