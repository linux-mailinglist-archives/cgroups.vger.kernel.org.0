Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF336BED0
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 07:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhD0FQE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 01:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhD0FQD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Apr 2021 01:16:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1796C061763;
        Mon, 26 Apr 2021 22:15:19 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FTqhc53bFz9sXH; Tue, 27 Apr 2021 15:15:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1619500512;
        bh=HFGpFkXW8RlYcOPAB0wEMYUjK4DKM74cGeGkNzCmj6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9ZU8PygQ+gKg4Dw7vVyO8B/ZibWN2WAUIrLKdub8+JGLK39Z6TjSoKCanuVi1+YM
         0hwW5wA/niQmTfcV6ul0Y99xwmUvhMN+vdlkSQwGrokpZrgV2ARlsQGM4RlWqV/Fcp
         +6jHzpMuVPFfrsTC35WsndWQ/VCRpN/syLpMOBwM=
Date:   Tue, 27 Apr 2021 15:15:05 +1000
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
Message-ID: <YIed2X41lAzNrRkn@yekko.fritz.box>
References: <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <20210423103851.41138791@redhat.com>
 <20210423222803.GK1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zaCd5yHFtW9CjF+V"
Content-Disposition: inline
In-Reply-To: <20210423222803.GK1370958@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--zaCd5yHFtW9CjF+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2021 at 07:28:03PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 23, 2021 at 10:38:51AM -0600, Alex Williamson wrote:
> > On Thu, 22 Apr 2021 20:39:50 -0300
>=20
> > > /dev/ioasid should understand the group concept somehow, otherwise it
> > > is incomplete and maybe even security broken.
> > >=20
> > > So, how do I add groups to, say, VDPA in a way that makes sense? The
> > > only answer I come to is broadly what I outlined here - make
> > > /dev/ioasid do all the group operations, and do them when we enjoin
> > > the VDPA device to the ioasid.
> > >=20
> > > Once I have solved all the groups problems with the non-VFIO users,
> > > then where does that leave VFIO? Why does VFIO need a group FD if
> > > everyone else doesn't?
> >=20
> > This assumes there's a solution for vDPA that doesn't just ignore the
> > problem and hope for the best.  I can't speak to a vDPA solution.
>=20
> I don't think we can just ignore the question and succeed with
> /dev/ioasid.
>=20
> Guess it should get answered as best it can for ioasid "in general"
> then we can decide if it makes sense for VFIO to use the group FD or
> not when working in ioasid mode.
>=20
> Maybe a better idea will come up
>=20
> > an implicit restriction.  You've listed a step in the description about
> > a "list of devices in the group", but nothing in the pseudo code
> > reflects that step.
>=20
> I gave it below with the readdir() - it isn't in the pseudo code
> because the applications I looked through didn't use it, and wouldn't
> benefit from it. I tried to show what things were doing today.

And chance are they will break cryptically if you give them a device
in a multi-device group.  That's not something we want to encourage.

>=20
> > I expect it would be a subtly missed by any userspace driver
> > developer unless they happen to work on a system where the grouping
> > is not ideal.
>=20
> I'm still unclear - what are be the consequence if the application
> designer misses the group detail?=20
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zaCd5yHFtW9CjF+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCHndgACgkQbDjKyiDZ
s5JxehAAtYO+RRKc5WVZPWIeDfyXnWi8ml0FoabDxvzajDH8+p17N5be0pdmIfD7
RwIxa6vsjc6bimUxdIfC2yK87E2H5OCy2k2hFKKPH6eYVl9sl13Z1bYMPku/bvdG
4SGcpDrqdhVkl3Vf3dvcmdfFPD8WFYN0+Q8rnnteezGmsI2c+xkUVXk+3MeSZ3Sv
oxtOe1wZm1SQ/pPNGIZlp7hDkGpdVNoxU7rE0B+HBmLatGUbSCIfXdCR2xkkbrDI
52EyYoXno6q3yAdBdGsMfobaj+Dyza6aL7pINX450Ue4MBtUeQi3h5ymXUE1xBm6
MDiw0tTvH2lbKFmQ/Z1aQi8UTT0rOdoN0mxstkf+vukt/3j5d5MjB/cZiRDc53uk
0fTJFsv45cSxig3jzfqSR4nIvjSSwwM3h5EnSsUaauilYpi8PDR5oaJJOlmAqZyH
f80as4HB9h7qEafiEnyEHeLlGdJLfthr9tsKLsYvvmNsOKgfci+CdwJDl0oVRBQS
1JnSDAxhmPD2FbBFO6uCP0kpqDmqumsskCkyn6SWmuRHXCliAnSUvi6xHjJ2J2Fo
3jaj3241cqqLPW6CObh4ERY6YItB24UcwCcq6I8JplSRVtwJG1f4kKevAnnfHJt3
ejcWCsfAxqmnc8Zo4MHzjBiB8+UyMz40/OxAEiPMCDRqQ4Y2kTU=
=zpk/
-----END PGP SIGNATURE-----

--zaCd5yHFtW9CjF+V--
