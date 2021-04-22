Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0319236874D
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 21:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhDVTie (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 15:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236822AbhDVTie (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 15:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619120278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biOoOdkcB54+0RggxGqfQD/QFH+RgEKqiVLmKbv8Qt8=;
        b=fayt2MBbgO03VbZmKTrQBvqN/qEu+igyUOgpmsDCZFSS7DWTEymtRbuA5cZACm5EypDMZM
        m1nobetVFkSG0Tw7tMFtdq8hWrjc5JdZMx0LTPSZIGvVEA5enXsYrftkO6r2ieAnifHhFT
        3ERhmDBUM9dfwjs09DG6iTgdoFu1kjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Jm4NmWn3NMmQ8koJLzBOpw-1; Thu, 22 Apr 2021 15:37:56 -0400
X-MC-Unique: Jm4NmWn3NMmQ8koJLzBOpw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30D138542C1;
        Thu, 22 Apr 2021 19:37:53 +0000 (UTC)
Received: from redhat.com (ovpn-114-21.phx2.redhat.com [10.3.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5A360BE5;
        Thu, 22 Apr 2021 19:37:47 +0000 (UTC)
Date:   Thu, 22 Apr 2021 13:37:47 -0600
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
Message-ID: <20210422133747.23322269@redhat.com>
In-Reply-To: <20210422175715.GA1370958@nvidia.com>
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
        <20210422175715.GA1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 22 Apr 2021 14:57:15 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > The security rule for isolation is that once a device is attached to a
> > > /dev/ioasid fd then all other devices in that security group must be
> > > attached to the same ioasid FD or left unused.  
> > 
> > Sounds like a group...  Note also that if those other devices are not
> > isolated from the user's device, the user could manipulate "unused"
> > devices via DMA.  So even unused devices should be within the same
> > IOMMU context... thus attaching groups to IOMMU domains.  
> 
> That is a very interesting point. So, say, in the classic PCI bus
> world if I have a NIC and HD on my PCI bus and both are in the group,
> I assign the NIC to a /dev/ioasid & VFIO then it is possible to use
> the NIC to access the HD via DMA
> 
> And here you want a more explicit statement that the HD is at risk by
> using the NIC?

If by "classic" you mean conventional PCI bus, then this is much worse
than simply "at risk".  The IOMMU cannot differentiate devices behind a
PCIe-to-PCI bridge, so the moment you turn on the IOMMU context for the
NIC, the address space for your HBA is pulled out from under it.  In
the vfio world, the NIC and HBA are grouped and managed together, the
user cannot change the IOMMU context of a group unless all of the
devices in the group are "viable", ie. they are released from any host
drivers.

> Honestly, I'm not sure the current group FD is actually showing that
> very strongly - though I get the point it is modeled in the sysfs and
> kind of implicit in the API - we evolved things in a way where most
> actual applications are taking in a PCI BDF from the user, not a group
> reference. So the actual security impact seems lost on the user.

vfio users are extremely aware of grouping, they understand the model,
if not always the reason for the grouping.  You only need to look at
r/VFIO to find various lsgroup scripts and kernel patches to manipulate
grouping.  The visibility to the user is valuable imo.

> Along my sketch if we have:
> 
>    ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
>    [..]
>    ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid_id) == ENOPERM
> 
> I would feel comfortable if the ATTACH_IOASID fails by default if all
> devices in the group have not been joined to the same ioasidfd.

And without a group representation to userspace, how would a user know
to resolve that?

> So in the NIC&HD example the application would need to do:
> 
>    ioasid_fd = open("/dev/ioasid");
>    nic_device_fd = open("/dev/vfio/device0")
>    hd_device_fd = open("/dev/vfio/device1")
>    
>    ioctl(nic_device_fd, JOIN_IOASID_FD, ioasifd)
>    ioctl(hd_device_fd, JOIN_IOASID_FD, ioasifd)
>    [..]
>    ioctl(nice_device, ATTACH_IOASID, gpa_ioasid_id) == SUCCESS
> 
> Now the security relation is forced by the kernel to be very explicit.

But not discoverable to the user.

> However to keep current semantics, I'd suggest a flag on
> JOIN_IOASID_FD called "IOASID_IMPLICIT_GROUP" which has the effect of
> allowing the ATTACH_IOASID to succeed without the user having to
> explicitly join all the group devices. This is analogous to the world
> we have today of opening the VFIO group FD but only instantiating one
> device FD.
> 
> In effect the ioasid FD becomes the group and the numbered IOASID's
> inside the FD become the /dev/vfio/vfio objects - we don't end up with
> fewer objects in the system, they just have different uAPI
> presentations.
> 
> I'd envision applications like DPDK that are BDF centric to use the
> first API with some '--allow-insecure-vfio' flag to switch on the
> IOASID_IMPLICIT_GROUP. Maybe good applications would also print:
>   "Danger Will Robinson these PCI BDFs [...] are also at risk"
> When the switch is used by parsing the sysfs

So the group still exist in sysfs, they just don't have vfio
representations?  An implicit grouping does what, automatically unbind
the devices, so an admin gives a user access to the NIC but their HBA
device disappears because they were implicitly linked?  That's why vfio
basis ownership on the group, if a user owns the group but the group is
not viable because a device is still bound to another kernel driver,
the use can't do anything.  Implicitly snarfing up subtly affected
devices is bad.

> > > Thus /dev/ioasid also becomes the unit of security and the IOMMU
> > > subsystem level becomes aware of and enforces the group security
> > > rules. Userspace does not need to "see" the group  
> > 
> > What tools does userspace have to understand isolation of individual
> > devices without groups?  
> 
> I think we can continue to show all of this group information in sysfs
> files, it just doesn't require application code to open a group FD.
> 
> This becomes relavent the more I think about it - elmininating the
> group and container FD uAPI by directly creating the device FD also
> sidesteps questions about how to model these objects in a /dev/ioasid
> only world. We simply don't have them at all so the answer is pretty
> easy.

I'm not sold.  Ideally each device would be fully isolated, then we
could assume a 1:1 relation of group and device and collapse the model
to work on devices.  We don't live in that world and I see a benefit to
making that explicit in the uapi, even if that group fd might seem
superfluous at times.  Thanks,

Alex

