Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D62F396D6F
	for <lists+cgroups@lfdr.de>; Tue,  1 Jun 2021 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhFAGhy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Jun 2021 02:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhFAGhy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Jun 2021 02:37:54 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23268C061756;
        Mon, 31 May 2021 23:36:13 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FvMqv04JQz9sWc; Tue,  1 Jun 2021 16:36:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1622529371;
        bh=Ak8v6J4KZgBCm2gkleU0vO46h8Ck6IdgA6FN2O7Jaio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGuoGWAXjF+uLY5kl0PEgFkT0CF0LUWT0pU8sXnoXW00QpIg9n4YSk3ANreX9JBOJ
         gOU9X71o5Z8FUdMaSuAj+rLmHaCXbVOAzpBiU0cO1TAq5jv5B+3HyCudYO9YbJhI5z
         yDi4FmOsknyKB/UQFB2n724sq4XVAH2B4zNAdF9Q=
Date:   Tue, 1 Jun 2021 14:03:33 +1000
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
Message-ID: <YLWxlZC4AXJPOngB@yekko>
References: <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <YK8m9jNuvEzlXWlu@yekko>
 <20210527184847.GI1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vhkj2zFFbKMf0kbf"
Content-Disposition: inline
In-Reply-To: <20210527184847.GI1002214@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--vhkj2zFFbKMf0kbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 03:48:47PM -0300, Jason Gunthorpe wrote:
> On Thu, May 27, 2021 at 02:58:30PM +1000, David Gibson wrote:
> > On Tue, May 25, 2021 at 04:52:57PM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> > >=20
> > > > 2. iommu backed mdev devices for SRIOV where mdev device is created=
 per
> > > > VF (mdev device =3D=3D VF device) then that mdev device has same io=
mmu
> > > > protection scope as VF associated to it.=20
> > >=20
> > > This doesn't require, and certainly shouldn't create, a fake group.
> >=20
> > It's only fake if you start with a narrow view of what a group is.=20
>=20
> A group is connected to drivers/iommu. A group object without *any*
> relation to drivers/iommu is just a complete fiction, IMHO.

That might be where we differ.  As I've said, my group I'm primarily
meaning the fundamental hardware unit of isolation.  *Usually* that's
determined by the capabilities of an IOMMU, but in some cases it might
not be.  In either case, the boundaries still matter.

> > > Only the VF's real IOMMU group should be used to model an iommu domain
> > > linked to a VF. Injecting fake groups that are proxies for real groups
> > > only opens the possibility of security problems like David is
> > > concerned with.
> >=20
> > It's not a proxy for a real group, it's a group of its own.  If you
> > discover that (due to a hardware bug, for example) the mdev is *not*
>=20
> What Kirti is talking about here is the case where a mdev is wrapped
> around a VF and the DMA isolation stems directly from the SRIOV VF's
> inherent DMA isolation, not anything the mdev wrapper did.
>=20
> The group providing the isolation is the VF's group.

Yes, in that case the mdev absolutely should be in the VF's group -
having its own group is not just messy but incorrect.

> The group mdev implicitly creates is just a fake proxy that comes
> along with mdev API. It doesn't do anything and it doesn't mean
> anything.

But.. the case of multiple mdevs managed by a single PCI device with
an internal IOMMU also exists, and then the mdev groups are *not*
proxies but true groups independent of the parent device.  Which means
that the group structure of mdevs can vary, which is an argument *for*
keeping it, not against.

> > properly isolated from its parent PCI device, then both the mdev
> > virtual device *and* the physical PCI device are in the same group.
> > Groups including devices of different types and on different buses
> > were considered from the start, and are precedented, if rare.
>=20
> This is far too theoretical for me. A security broken mdev is
> functionally useless.

Is it, though?  Again, I'm talking about the case of multiple mdevs
with a single parent device (because that's the only case I was aware
of until recently).  Isolation comes from a device-internal
IOMMU... that turns out to be broken.  But if your security domain
happens to include all the mdevs on the device anyway, then you don't
care.

Are you really going to say people can't use their fancy hardware in
this mode because it has a security flaw that's not relevant to their
usecase?


And then.. there's Kirti's case.  In that case the mdev should belong
to its parent PCI device's group since that's what's providing
isolation.  But in that case the parent device can be in a
multi-device group for any of the usual reasons (PCIe-to-PCI bridge,
PCIe switch with broken ACS, multifunction device with crosstalk).
Which means the mdev also shares a group with those other device.  So
again, the group structure matters and is not a fiction.

> We don't need to support it, and we don't need complicated software to
> model it.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vhkj2zFFbKMf0kbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC1sZMACgkQbDjKyiDZ
s5Jg0A//dfV0uuvM5wq5Lqe/8NygQkdHhnPLy98IVfmW8vahS2FUIZu+ys2WYxJz
nHkUuUMBA2iO9qx2qbT8gz75Ps7Np2dq1u6IJKoPguwT+ynzj5K1S1qWHN5ZjZtM
znpsoMq8OH+U0NZ7qrPRdD9FmoE+iwOGc0OhrG0eiaXZGRojgC2dVSRKC7filiZZ
Q53HYq9FteBRgkJSTof80+TVmQhhmT5XMySErJaiSMktHrehNZjgqulPUSjMRR2h
xKiGXCe9sXYrLvpfkvb5YBx6VHrtdQt9BKw53z5ctBoD1PbB/Dcxlpeu9m0KJm91
uEai0euc9G65QVqpGWoWW9yvsoE+YD6+Lk0KhveEN9yk/OknaiPHqIyLRR1j9G4i
HyjjC3V9VxGXrHgZY4taNvvb+CtOAWYeTfjR5QDYBTbZu7hUCeVPjAGlJEkCxufl
GOQfzJmMFyDrYVuvNzeYs3GHD3mncdg3NxWrLH03xVwaNHzIaNO6SKDAfjRVqBQH
ExP9kjVozUEPjspmHwQXJA6s/jRMK5v7Pl7Q4I5oHFXl9HK+1IKnMe1Wbj7LARul
5aL1tcFnyXA/5crtTcCMUxgWsHtKN+rN0EQ5O/rioAJWejkIGip2JSr+hN8bl+fS
nVamgXI2cpk3CESdmpROG+BeeLXPEvH/G36pj/C/x1K0MQhrx84=
=Bli1
-----END PGP SIGNATURE-----

--vhkj2zFFbKMf0kbf--
