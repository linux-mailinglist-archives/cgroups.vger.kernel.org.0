Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480B736BECF
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 07:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhD0FQD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 01:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhD0FQB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Apr 2021 01:16:01 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A80C06175F;
        Mon, 26 Apr 2021 22:15:18 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4FTqhc3pMLz9sXG; Tue, 27 Apr 2021 15:15:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1619500512;
        bh=+nFxNvo8MfgXeqjkoOWLS2Md7oNwm+xBLLDSKHVAYoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlTeZWqtTGxjMYwCZXKQrP2OXxOLXe+DzWZ7vxihJDyoyTgD0EIvxDCU+lTBTdPPJ
         S0HRni/Y1puqy4b9CdNtGXofuiINYxXhiW6NmrdTLo7IIRpAnB1EDK5hC5sJEVm4r8
         1LbS7S2NAHu0Fv9JnXPs4teVNWQZNGaBjF/6sW/U=
Date:   Tue, 27 Apr 2021 14:50:45 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
Message-ID: <YIeYJZOdgMN/orl0@yekko.fritz.box>
References: <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X4uKcMKEY/0ezLpU"
Content-Disposition: inline
In-Reply-To: <20210422111337.6ac3624d@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--X4uKcMKEY/0ezLpU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 11:13:37AM -0600, Alex Williamson wrote:
> On Wed, 21 Apr 2021 20:03:01 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> > On Wed, Apr 21, 2021 at 01:33:12PM -0600, Alex Williamson wrote:
> >=20
> > > > I still expect that VFIO_GROUP_SET_CONTAINER will be used to connect
> > > > /dev/{ioasid,vfio} to the VFIO group and all the group and device
> > > > logic stays inside VFIO. =20
> > >=20
> > > But that group and device logic is also tied to the container, where
> > > the IOMMU backend is the interchangeable thing that provides the IOMMU
> > > manipulation for that container. =20
> >=20
> > I think that is an area where the discussion would need to be focused.
> >=20
> > I don't feel very prepared to have it in details, as I haven't dug
> > into all the group and iommu micro-operation very much.
> >=20
> > But, it does seem like the security concept that VFIO is creating with
> > the group also has to be present in the lower iommu layer too.
> >=20
> > With different subsystems joining devices to the same ioasid's we
> > still have to enforce the security propery the vfio group is creating.
> >=20
> > > If you're using VFIO_GROUP_SET_CONTAINER to associate a group to a
> > > /dev/ioasid, then you're really either taking that group outside of
> > > vfio or you're re-implementing group management in /dev/ioasid.  =20
> >=20
> > This sounds right.
> >=20
> > > > Everything can be switched to ioasid_container all down the line. If
> > > > it wasn't for PPC this looks fairly simple. =20
> > >=20
> > > At what point is it no longer vfio?  I'd venture to say that replacing
> > > the container rather than invoking a different IOMMU backend is that
> > > point. =20
> >=20
> > sorry, which is no longer vfio?
>=20
> I'm suggesting that if we're replacing the container/group model with
> an ioasid then we're effectively creating a new thing that really only
> retains the vfio device uapi.
>=20
> > > > Since getting rid of PPC looks a bit hard, we'd be stuck with
> > > > accepting a /dev/ioasid and then immediately wrappering it in a
> > > > vfio_container an shimming it through a vfio_iommu_ops. It is not
> > > > ideal at all, but in my look around I don't see a major problem if
> > > > type1 implementation is moved to live under /dev/ioasid. =20
> > >=20
> > > But type1 is \just\ an IOMMU backend, not "/dev/vfio".  Given that
> > > nobody flinched at removing NVLink support, maybe just deprecate SPAPR
> > > now and see if anyone objects ;) =20
> >=20
> > Would simplify this project, but I wonder :)
> >=20
> > In any event, it does look like today we'd expect the SPAPR stuff
> > would be done through the normal iommu APIs, perhaps enhanced a bit,
> > which makes me suspect an enhanced type1 can implement SPAPR.
>=20
> David Gibson has argued for some time that SPAPR could be handled via a
> converged type1 model.  We has mapped that out at one point,
> essentially a "type2", but neither of us had any bandwidth to pursue it.

Right.  The sPAPR TCE backend is kind of an unfortunate accident of
history.  We absolutely could do a common interface, but no-one's had
time to work on it.

> > I say this because the SPAPR looks quite a lot like PASID when it has
> > APIs for allocating multiple tables and other things. I would be
> > interested to hear someone from IBM talk about what it is doing and
> > how it doesn't fit into today's IOMMU API.

Hm.  I don't think it's really like PASID.  Just like Type1, the TCE
backend represents a single DMA address space which all devices in the
container will see at all times.  The difference is that there can be
multiple (well, 2) "windows" of valid IOVAs within that address space.
Each window can have a different TCE (page table) layout.  For kernel
drivers, a smallish translated window at IOVA 0 is used for 32-bit
devices, and a large direct mapped (no page table) window is created
at a high IOVA for better performance with 64-bit DMA capable devices.

With the VFIO backend we create (but don't populate) a similar
smallish 32-bit window, userspace can create its own secondary window
if it likes, though obvious for userspace use there will always be a
page table.  Userspace can choose the total size (but not address),
page size and to an extent the page table format of the created
window.  Note that the TCE page table format is *not* the same as the
POWER CPU core's page table format.  Userspace can also remove the
default small window and create its own.

The second wrinkle is pre-registration.  That lets userspace register
certain userspace VA ranges (*not* IOVA ranges) as being the only ones
allowed to be mapped into the IOMMU.  This is a performance
optimization, because on pre-registration we also pre-account memory
that will be effectively locked by DMA mappings, rather than doing it
at DMA map and unmap time.

This came about because POWER guests always contain a vIOMMU.  That
(combined with the smallish default IOVA window) means that DMA maps
and unmaps can become an important bottleneck, rather than being
basically a small once-off cost when qemu maps all of guest memory
into the IOMMU.  That's optimized with a special interlink between
KVM and VFIO that accelerates the guest-initiated maps/unmap
operations.  However, it's not feasible to do the accounting in that
fast path, hence the need for the pre-registration.

>=20
> [Cc David, Alexey]
>=20
> > It is very old and the iommu world has advanced tremendously lately,
> > maybe I'm too optimisitic?
> >=20
> > > > We end up with a ioasid.h that basically has the vfio_iommu_type1 c=
ode
> > > > lightly recast into some 'struct iommu_container' and a set of
> > > > ioasid_* function entry points that follow vfio_iommu_driver_ops_ty=
pe1:
> > > >   ioasid_attach_group
> > > >   ioasid_detatch_group
> > > >   ioasid_<something about user pages>
> > > >   ioasid_read/ioasid_write =20
> > >=20
> > > Again, this looks like a vfio IOMMU backend.  What are we accomplishi=
ng
> > > by replacing /dev/vfio with /dev/ioasid versus some manipulation of
> > > VFIO_SET_IOMMU accepting a /dev/ioasid fd? =20
> >=20
> > The point of all of this is to make the user api for the IOMMU
> > cross-subsystem. It is not a vfio IOMMU backend, it is moving the
> > IOMMU abstraction from VFIO into the iommu framework and giving the
> > iommu framework a re-usable user API.

I like the idea of a common DMA/IOMMU handling system across
platforms.  However in order to be efficiently usable for POWER it
will need to include multiple windows, allowing the user to change
those windows and something like pre-registration to amortize
accounting costs for heavy vIOMMU load.

Well... possibly we can do without the pre-reg now that 32-bit DMA
limited devics are less common, as are POWER8 systems.  With modern
devices and modern kernels a guest is likely to use a single large
64-bit secondary window mapping all guest RAM, so the vIOMMU
bottleneck shouldn't be such an issue.

> Right, but I don't see that implies it cannot work within the vfio
> IOMMU model.  Currently when an IOMMU is set, the /dev/vfio/vfio
> container becomes a conduit for file ops from the container to be
> forwarded to the IOMMU.  But that's in part because the user doesn't
> have another object to interact with the IOMMU.  It's entirely possible
> that with an ioasid shim, the user would continue to interact directly
> with the /dev/ioasid fd for IOMMU manipulation and only use
> VFIO_SET_IOMMU to associate a vfio container to that ioasid.
>=20
> > My ideal outcome would be for VFIO to use only the new iommu/ioasid
> > API and have no iommu pluggability at all. The iommu subsystem
> > provides everything needed to VFIO, and provides it equally to VDPA
> > and everything else.
>=20
> As above, we don't necessarily need to have the vfio container be the
> access mechanism for the IOMMU, it can become just an means to
> association the container with an IOMMU.  This has quite a few
> transitional benefits.
>=20
> > drivers/vfio/ becomes primarily about 'struct vfio_device' and
> > everything related to its IOCTL interface.
> >=20
> > drivers/iommu and ioasid.c become all about a pluggable IOMMU
> > interface, including a uAPI for it.
> >=20
> > IMHO it makes a high level sense, though it may be a pipe dream.
>=20
> This is where we've dissolved all but the vfio device uapi, which
> suggests the group and container model were never necessary and I'm not
> sure exactly what that uapi looks like.  We currently make use of an
> IOMMU api that is group aware, but that awareness extends out to the
> vfio uapi.
>=20
> > > > If we have this, and /dev/ioasid implements the legacy IOCTLs, then
> > > > /dev/vfio =3D=3D /dev/ioasid and we can compile out vfio_fops and r=
elated
> > > > from vfio.c and tell ioasid.c to create /dev/vfio instead using the
> > > > ops it owns. =20
> > >=20
> > > Why would we want /dev/ioasid to implement legacy ioctls instead of
> > > simply implementing an interface to allow /dev/ioasid to be used as a
> > > vfio IOMMU backend? =20
> >=20
> > Only to make our own migration easier. I'd imagine everyone would want
> > to sit down and design this new clear ioasid API that can co-exist on
> > /dev/ioasid with the legacy once.
>=20
> vfio really just wants to be able to attach groups to an address space
> to consider them isolated, everything else about the IOMMU API could
> happen via a new ioasid file descriptor representing that context, ie.
> vfio handles the group ownership and device access, ioasid handles the
> actual mappings.
>=20
> > > The pseudo code above really suggests you do want to remove
> > > /dev/vfio/vfio, but this is only one of the IOMMU backends for vfio, =
so
> > > I can't quite figure out if we're talking past each other. =20
> >=20
> > I'm not quite sure what you mean by "one of the IOMMU backends?" You
> > mean type1, right?
> > =20
> > > As I expressed in another thread, type1 has a lot of shortcomings.  T=
he
> > > mapping interface leaves userspace trying desperately to use statical=
ly
> > > mapped buffers because the map/unmap latency is too high.  We have
> > > horrible issues with duplicate locked page accounting across
> > > containers.  It suffers pretty hard from feature creep in various
> > > areas.  A new IOMMU backend is an opportunity to redesign some of the=
se
> > > things. =20
> >=20
> > Sure, but also those kinds of transformational things go alot better
> > if you can smoothly go from the old to the new and have technical
> > co-existance in side the kernel. Having a shim that maps the old APIs
> > to new APIs internally to Linux helps keep the implementation from
> > becoming too bogged down with compatibility.
>=20
> I'm afraid /dev/ioasid providing type1 compatibility would be just that.
>=20
> > > The IOMMU group also abstracts isolation and visibility relative to
> > > DMA.  For example, in a PCIe topology a multi-function device may not
> > > have isolation between functions, but each requester ID is visible to
> > > the IOMMU.   =20
> >=20
> > Okay, I'm glad I have this all right in my head, as I was pretty sure
> > this was what the group was about.
> >=20
> > My next question is why do we have three things as a FD: group, device
> > and container (aka IOMMU interface)?
> >=20
> > Do we have container because the /dev/vfio/vfio can hold only a single
> > page table so we need to swap containers sometimes?
>=20
> The container represents an IOMMU address space, which can be shared by
> multiple groups, where each group may contain one or more devices.
> Swapping a container would require releasing all the devices (the user
> cannot have access to a non-isolated device), then a group could be
> moved from one container to another.
>=20
> > If we start from a clean sheet and make a sketch..
> >=20
> > /dev/ioasid is the IOMMU control interface. It can create multiple
> > IOASIDs that have page tables and it can manipulate those page tables.
> > Each IOASID is identified by some number.
> >=20
> > struct vfio_device/vdpa_device/etc are consumers of /dev/ioasid
> >=20
> > When a device attaches to an ioasid userspace gives VFIO/VDPA the
> > ioasid FD and the ioasid # in the FD.
> >=20
> > The security rule for isolation is that once a device is attached to a
> > /dev/ioasid fd then all other devices in that security group must be
> > attached to the same ioasid FD or left unused.
>=20
> Sounds like a group...  Note also that if those other devices are not
> isolated from the user's device, the user could manipulate "unused"
> devices via DMA.  So even unused devices should be within the same
> IOMMU context... thus attaching groups to IOMMU domains.
>=20
> > Thus /dev/ioasid also becomes the unit of security and the IOMMU
> > subsystem level becomes aware of and enforces the group security
> > rules. Userspace does not need to "see" the group
>=20
> What tools does userspace have to understand isolation of individual
> devices without groups?
> =20
> > In sketch it would be like
> >   ioasid_fd =3D open("/dev/ioasid");
> >   vfio_device_fd =3D open("/dev/vfio/device0")
> >   vdpa_device_fd =3D open("/dev/vdpa/device0")
> >   ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
> >   ioctl(vdpa_device_fd, JOIN_IOASID_FD, ioasifd)
> >=20
> >   gpa_ioasid_id =3D ioctl(ioasid_fd, CREATE_IOASID, ..)
> >   ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)
> >=20
> >   ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid_id)
> >   ioctl(vpda_device, ATTACH_IOASID, gpa_ioasid_id)
> >=20
> >   .. both VDPA and VFIO see the guest physical map and the kernel has
> >      enough info that both could use the same IOMMU page table
> >      structure ..
> >=20
> >   // Guest viommu turns off bypass mode for the vfio device
> >   ioctl(vfio_device, DETATCH_IOASID)
> > =20
> >   // Guest viommu creates a new page table
> >   rid_ioasid_id =3D ioctl(ioasid_fd, CREATE_IOASID, ..)
> >   ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)
> >=20
> >   // Guest viommu links the new page table to the RID
> >   ioctl(vfio_device, ATTACH_IOASID, rid_ioasid_id)
> >=20
> > The group security concept becomes implicit and hidden from the
> > uAPI. JOIN_IOASID_FD implicitly finds the device's group inside the
> > kernel and requires that all members of the group be joined only to
> > this ioasid_fd.
> >=20
> > Essentially we discover the group from the device instead of the
> > device from the group.
> >=20
> > Where does it fall down compared to the three FD version we have
> > today?
>=20
> The group concept is explicit today because how does userspace learn
> about implicit dependencies between devices?  For example, if the user
> has a conventional PCI bus with a couple devices on it, how do they
> understand that those devices cannot be assigned to separate userspace
> drivers?  The group fd fills that gap.  Thanks,
>=20
> Alex
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X4uKcMKEY/0ezLpU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCHmCMACgkQbDjKyiDZ
s5K9cBAAtS9UiXLwxHaW8kUOvegJDqedyZUV6IcqR/DX3g7oRg0Xv9wxWaZm93ok
+7CD4/T+mjmD2HqZgNwxbzwzN2kogCfOGu/psxIAkYtxh73gvxDBtvKOtmBWoG92
cVupX5bqp18ufWoiCWBhuH6PtjJfFkzA6X2KH7278yBzaOZ6bh00KDCADUEPRb44
Cj7EGuz+no4MbbqAePC+25gRI0ivVyRghoP9t9dGt0pPZYCOW8D03P6t6Qs8lWRG
0YHZG5X3HL2TKBwVpAT5Hp8lGefHpiXZ7by4nAuLrmLaJayBkGYLhYwkth+Cm6wQ
c3+/OVJ6t1MIv2T/JkfmndsnwKPAQaevd53Pi65ywrCIC7/Zrqaj8SRycfOKODsr
CwgMfNBMSzgS708nMQuyj56Xjnq1NhTWneLktYrgn5eF1zIKwf6Xpvenv/s4kXZ5
0EhI/MbKKDsF5bCTzwXftknKCMMJrsgX5TXUv0OiC8I+2QE7YHP22ayZxbUpAo6h
jEG2Tqhg6T0U2fTKU7WSZ8sJbPYWPJYgq/MiCqWHq2aM3Z4w4XDYTTTQca6vhGEV
KJfZ42+a+JQXwtNcV0S2CFo2lgGHR+tqruvBYMaAulGlcq2IkXD+Kb2HsccYZ0tm
aP71rgPbNj/07GU5oivqotEV8Hj2DC43enc/lDldGypz6SE9j0M=
=oLXF
-----END PGP SIGNATURE-----

--X4uKcMKEY/0ezLpU--
