Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21C53685A1
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 19:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbhDVROY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 13:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238259AbhDVROY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 13:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619111629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AoLtOKIEaUoGP15b6SEJ+EZN+FEmTqg+4+tHGCyR90Q=;
        b=DCjmz1YO2gA5c/w+6sqzKHbfufMZ4naBOs265Yw/PKbxnMHg5Y8dPGhC/xam1JmrxFUDNS
        JzL0KS4GapFzKDSUQZxVKeTUd2SKEELDRK2ChIyldWvmShUH5ClcTdfS1FpA6bqVXwkwJl
        FVZW6/S6rDFDh7iJ53dc5DcqjP2/WU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-yByfXrO5Mh6oFQHlAXuS5Q-1; Thu, 22 Apr 2021 13:13:45 -0400
X-MC-Unique: yByfXrO5Mh6oFQHlAXuS5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6B551B2C993;
        Thu, 22 Apr 2021 17:13:40 +0000 (UTC)
Received: from redhat.com (ovpn-114-21.phx2.redhat.com [10.3.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEC2A60938;
        Thu, 22 Apr 2021 17:13:37 +0000 (UTC)
Date:   Thu, 22 Apr 2021 11:13:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210422111337.6ac3624d@redhat.com>
In-Reply-To: <20210421230301.GP1370958@nvidia.com>
References: <20210401160337.GJ1463678@nvidia.com>
        <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
        <20210415230732.GG1370958@nvidia.com>
        <20210416061258.325e762e@jacob-builder>
        <20210416094547.1774e1a3@redhat.com>
        <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210421162307.GM1370958@nvidia.com>
        <20210421105451.56d3670a@redhat.com>
        <20210421175203.GN1370958@nvidia.com>
        <20210421133312.15307c44@redhat.com>
        <20210421230301.GP1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 21 Apr 2021 20:03:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Apr 21, 2021 at 01:33:12PM -0600, Alex Williamson wrote:
> 
> > > I still expect that VFIO_GROUP_SET_CONTAINER will be used to connect
> > > /dev/{ioasid,vfio} to the VFIO group and all the group and device
> > > logic stays inside VFIO.  
> > 
> > But that group and device logic is also tied to the container, where
> > the IOMMU backend is the interchangeable thing that provides the IOMMU
> > manipulation for that container.  
> 
> I think that is an area where the discussion would need to be focused.
> 
> I don't feel very prepared to have it in details, as I haven't dug
> into all the group and iommu micro-operation very much.
> 
> But, it does seem like the security concept that VFIO is creating with
> the group also has to be present in the lower iommu layer too.
> 
> With different subsystems joining devices to the same ioasid's we
> still have to enforce the security propery the vfio group is creating.
> 
> > If you're using VFIO_GROUP_SET_CONTAINER to associate a group to a
> > /dev/ioasid, then you're really either taking that group outside of
> > vfio or you're re-implementing group management in /dev/ioasid.   
> 
> This sounds right.
> 
> > > Everything can be switched to ioasid_container all down the line. If
> > > it wasn't for PPC this looks fairly simple.  
> > 
> > At what point is it no longer vfio?  I'd venture to say that replacing
> > the container rather than invoking a different IOMMU backend is that
> > point.  
> 
> sorry, which is no longer vfio?

I'm suggesting that if we're replacing the container/group model with
an ioasid then we're effectively creating a new thing that really only
retains the vfio device uapi.

> > > Since getting rid of PPC looks a bit hard, we'd be stuck with
> > > accepting a /dev/ioasid and then immediately wrappering it in a
> > > vfio_container an shimming it through a vfio_iommu_ops. It is not
> > > ideal at all, but in my look around I don't see a major problem if
> > > type1 implementation is moved to live under /dev/ioasid.  
> > 
> > But type1 is \just\ an IOMMU backend, not "/dev/vfio".  Given that
> > nobody flinched at removing NVLink support, maybe just deprecate SPAPR
> > now and see if anyone objects ;)  
> 
> Would simplify this project, but I wonder :)
> 
> In any event, it does look like today we'd expect the SPAPR stuff
> would be done through the normal iommu APIs, perhaps enhanced a bit,
> which makes me suspect an enhanced type1 can implement SPAPR.

David Gibson has argued for some time that SPAPR could be handled via a
converged type1 model.  We has mapped that out at one point,
essentially a "type2", but neither of us had any bandwidth to pursue it.

> I say this because the SPAPR looks quite a lot like PASID when it has
> APIs for allocating multiple tables and other things. I would be
> interested to hear someone from IBM talk about what it is doing and
> how it doesn't fit into today's IOMMU API.

[Cc David, Alexey]

> It is very old and the iommu world has advanced tremendously lately,
> maybe I'm too optimisitic?
> 
> > > We end up with a ioasid.h that basically has the vfio_iommu_type1 code
> > > lightly recast into some 'struct iommu_container' and a set of
> > > ioasid_* function entry points that follow vfio_iommu_driver_ops_type1:
> > >   ioasid_attach_group
> > >   ioasid_detatch_group
> > >   ioasid_<something about user pages>
> > >   ioasid_read/ioasid_write  
> > 
> > Again, this looks like a vfio IOMMU backend.  What are we accomplishing
> > by replacing /dev/vfio with /dev/ioasid versus some manipulation of
> > VFIO_SET_IOMMU accepting a /dev/ioasid fd?  
> 
> The point of all of this is to make the user api for the IOMMU
> cross-subsystem. It is not a vfio IOMMU backend, it is moving the
> IOMMU abstraction from VFIO into the iommu framework and giving the
> iommu framework a re-usable user API.

Right, but I don't see that implies it cannot work within the vfio
IOMMU model.  Currently when an IOMMU is set, the /dev/vfio/vfio
container becomes a conduit for file ops from the container to be
forwarded to the IOMMU.  But that's in part because the user doesn't
have another object to interact with the IOMMU.  It's entirely possible
that with an ioasid shim, the user would continue to interact directly
with the /dev/ioasid fd for IOMMU manipulation and only use
VFIO_SET_IOMMU to associate a vfio container to that ioasid.

> My ideal outcome would be for VFIO to use only the new iommu/ioasid
> API and have no iommu pluggability at all. The iommu subsystem
> provides everything needed to VFIO, and provides it equally to VDPA
> and everything else.

As above, we don't necessarily need to have the vfio container be the
access mechanism for the IOMMU, it can become just an means to
association the container with an IOMMU.  This has quite a few
transitional benefits.

> drivers/vfio/ becomes primarily about 'struct vfio_device' and
> everything related to its IOCTL interface.
> 
> drivers/iommu and ioasid.c become all about a pluggable IOMMU
> interface, including a uAPI for it.
> 
> IMHO it makes a high level sense, though it may be a pipe dream.

This is where we've dissolved all but the vfio device uapi, which
suggests the group and container model were never necessary and I'm not
sure exactly what that uapi looks like.  We currently make use of an
IOMMU api that is group aware, but that awareness extends out to the
vfio uapi.

> > > If we have this, and /dev/ioasid implements the legacy IOCTLs, then
> > > /dev/vfio == /dev/ioasid and we can compile out vfio_fops and related
> > > from vfio.c and tell ioasid.c to create /dev/vfio instead using the
> > > ops it owns.  
> > 
> > Why would we want /dev/ioasid to implement legacy ioctls instead of
> > simply implementing an interface to allow /dev/ioasid to be used as a
> > vfio IOMMU backend?  
> 
> Only to make our own migration easier. I'd imagine everyone would want
> to sit down and design this new clear ioasid API that can co-exist on
> /dev/ioasid with the legacy once.

vfio really just wants to be able to attach groups to an address space
to consider them isolated, everything else about the IOMMU API could
happen via a new ioasid file descriptor representing that context, ie.
vfio handles the group ownership and device access, ioasid handles the
actual mappings.

> > The pseudo code above really suggests you do want to remove
> > /dev/vfio/vfio, but this is only one of the IOMMU backends for vfio, so
> > I can't quite figure out if we're talking past each other.  
> 
> I'm not quite sure what you mean by "one of the IOMMU backends?" You
> mean type1, right?
>  
> > As I expressed in another thread, type1 has a lot of shortcomings.  The
> > mapping interface leaves userspace trying desperately to use statically
> > mapped buffers because the map/unmap latency is too high.  We have
> > horrible issues with duplicate locked page accounting across
> > containers.  It suffers pretty hard from feature creep in various
> > areas.  A new IOMMU backend is an opportunity to redesign some of these
> > things.  
> 
> Sure, but also those kinds of transformational things go alot better
> if you can smoothly go from the old to the new and have technical
> co-existance in side the kernel. Having a shim that maps the old APIs
> to new APIs internally to Linux helps keep the implementation from
> becoming too bogged down with compatibility.

I'm afraid /dev/ioasid providing type1 compatibility would be just that.

> > The IOMMU group also abstracts isolation and visibility relative to
> > DMA.  For example, in a PCIe topology a multi-function device may not
> > have isolation between functions, but each requester ID is visible to
> > the IOMMU.    
> 
> Okay, I'm glad I have this all right in my head, as I was pretty sure
> this was what the group was about.
> 
> My next question is why do we have three things as a FD: group, device
> and container (aka IOMMU interface)?
> 
> Do we have container because the /dev/vfio/vfio can hold only a single
> page table so we need to swap containers sometimes?

The container represents an IOMMU address space, which can be shared by
multiple groups, where each group may contain one or more devices.
Swapping a container would require releasing all the devices (the user
cannot have access to a non-isolated device), then a group could be
moved from one container to another.

> If we start from a clean sheet and make a sketch..
> 
> /dev/ioasid is the IOMMU control interface. It can create multiple
> IOASIDs that have page tables and it can manipulate those page tables.
> Each IOASID is identified by some number.
> 
> struct vfio_device/vdpa_device/etc are consumers of /dev/ioasid
> 
> When a device attaches to an ioasid userspace gives VFIO/VDPA the
> ioasid FD and the ioasid # in the FD.
> 
> The security rule for isolation is that once a device is attached to a
> /dev/ioasid fd then all other devices in that security group must be
> attached to the same ioasid FD or left unused.

Sounds like a group...  Note also that if those other devices are not
isolated from the user's device, the user could manipulate "unused"
devices via DMA.  So even unused devices should be within the same
IOMMU context... thus attaching groups to IOMMU domains.

> Thus /dev/ioasid also becomes the unit of security and the IOMMU
> subsystem level becomes aware of and enforces the group security
> rules. Userspace does not need to "see" the group

What tools does userspace have to understand isolation of individual
devices without groups?
 
> In sketch it would be like
>   ioasid_fd = open("/dev/ioasid");
>   vfio_device_fd = open("/dev/vfio/device0")
>   vdpa_device_fd = open("/dev/vdpa/device0")
>   ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
>   ioctl(vdpa_device_fd, JOIN_IOASID_FD, ioasifd)
> 
>   gpa_ioasid_id = ioctl(ioasid_fd, CREATE_IOASID, ..)
>   ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)
> 
>   ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid_id)
>   ioctl(vpda_device, ATTACH_IOASID, gpa_ioasid_id)
> 
>   .. both VDPA and VFIO see the guest physical map and the kernel has
>      enough info that both could use the same IOMMU page table
>      structure ..
> 
>   // Guest viommu turns off bypass mode for the vfio device
>   ioctl(vfio_device, DETATCH_IOASID)
>  
>   // Guest viommu creates a new page table
>   rid_ioasid_id = ioctl(ioasid_fd, CREATE_IOASID, ..)
>   ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)
> 
>   // Guest viommu links the new page table to the RID
>   ioctl(vfio_device, ATTACH_IOASID, rid_ioasid_id)
> 
> The group security concept becomes implicit and hidden from the
> uAPI. JOIN_IOASID_FD implicitly finds the device's group inside the
> kernel and requires that all members of the group be joined only to
> this ioasid_fd.
> 
> Essentially we discover the group from the device instead of the
> device from the group.
> 
> Where does it fall down compared to the three FD version we have
> today?

The group concept is explicit today because how does userspace learn
about implicit dependencies between devices?  For example, if the user
has a conventional PCI bus with a couple devices on it, how do they
understand that those devices cannot be assigned to separate userspace
drivers?  The group fd fills that gap.  Thanks,

Alex

