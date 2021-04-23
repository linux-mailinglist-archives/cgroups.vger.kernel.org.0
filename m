Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9193369739
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhDWQjn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 12:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhDWQjm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Apr 2021 12:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619195945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GQkBMDQ1KuOta/J/0gSTIN3uzemBUynRDLUIAu7wKk=;
        b=BL68RlStI9T2WRmztfEym7Vsp8BxpcmEbaeGO8IjGm81+KFlejIzd/Zdmdi9cVNuqUoLCQ
        M9Fv7WNdL1dGMWf2mY3VZ5tgxmVpDrc96nfGEuHPnZs+ntA0ogDNAUXv8zJhupJMdGomIj
        FsoeQF/nv8FiZPfwEJJwS7cJ+a4zU7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-u8ZHLF9kONSSl2ho-aJrMw-1; Fri, 23 Apr 2021 12:39:01 -0400
X-MC-Unique: u8ZHLF9kONSSl2ho-aJrMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFBD584BA43;
        Fri, 23 Apr 2021 16:38:56 +0000 (UTC)
Received: from redhat.com (ovpn-114-21.phx2.redhat.com [10.3.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B0F95D720;
        Fri, 23 Apr 2021 16:38:51 +0000 (UTC)
Date:   Fri, 23 Apr 2021 10:38:51 -0600
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
Message-ID: <20210423103851.41138791@redhat.com>
In-Reply-To: <20210422233950.GD1370958@nvidia.com>
References: <20210421162307.GM1370958@nvidia.com>
        <20210421105451.56d3670a@redhat.com>
        <20210421175203.GN1370958@nvidia.com>
        <20210421133312.15307c44@redhat.com>
        <20210421230301.GP1370958@nvidia.com>
        <20210422111337.6ac3624d@redhat.com>
        <20210422175715.GA1370958@nvidia.com>
        <20210422133747.23322269@redhat.com>
        <20210422200024.GC1370958@nvidia.com>
        <20210422163808.2d173225@redhat.com>
        <20210422233950.GD1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 22 Apr 2021 20:39:50 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 22, 2021 at 04:38:08PM -0600, Alex Williamson wrote:
> 
> > Because it's fundamental to the isolation of the device?  What you're
> > proposing doesn't get around the group issue, it just makes it implicit
> > rather than explicit in the uapi.  
> 
> I'm not even sure it makes it explicit or implicit, it just takes away
> the FD.
> 
> There are four group IOCTLs, I see them mapping to /dev/ioasid follows:
>  VFIO_GROUP_GET_STATUS - 
>    + VFIO_GROUP_FLAGS_CONTAINER_SET is fairly redundant
>    + VFIO_GROUP_FLAGS_VIABLE could be in a new sysfs under
>      kernel/iomm_groups, or could be an IOCTL on /dev/ioasid
>        IOASID_ALL_DEVICES_VIABLE
> 
>  VFIO_GROUP_SET_CONTAINER -
>    + This happens implicitly when the device joins the IOASID
>      so it gets moved to the vfio_device FD:
>       ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
> 
>  VFIO_GROUP_UNSET_CONTAINER -
>    + Also moved to the vfio_device FD, opposite of JOIN_IOASID_FD
> 
>  VFIO_GROUP_GET_DEVICE_FD -
>    + Replaced by opening /dev/vfio/deviceX
>      Learn the deviceX which will be the cdev sysfs shows as:
>       /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/vfio/deviceX/dev
>     Open /dev/vfio/deviceX
> 
> > > How do we model the VFIO group security concept to something like
> > > VDPA?  
> > 
> > Is it really a "VFIO group security concept"?  We're reflecting the
> > reality of the hardware, not all devices are fully isolated.    
> 
> Well, exactly.
> 
> /dev/ioasid should understand the group concept somehow, otherwise it
> is incomplete and maybe even security broken.
> 
> So, how do I add groups to, say, VDPA in a way that makes sense? The
> only answer I come to is broadly what I outlined here - make
> /dev/ioasid do all the group operations, and do them when we enjoin
> the VDPA device to the ioasid.
> 
> Once I have solved all the groups problems with the non-VFIO users,
> then where does that leave VFIO? Why does VFIO need a group FD if
> everyone else doesn't?

This assumes there's a solution for vDPA that doesn't just ignore the
problem and hope for the best.  I can't speak to a vDPA solution.

> > IOMMU group.  This is the reality that any userspace driver needs to
> > play in, it doesn't magically go away because we drop the group file
> > descriptor.    
> 
> I'm not saying it does, I'm saying it makes the uAPI more regular and
> easier to fit into /dev/ioasid without the group FD.
> 
> > It only makes the uapi more difficult to use correctly because
> > userspace drivers need to go outside of the uapi to have any idea
> > that this restriction exists.    
> 
> I don't think it makes any substantive difference one way or the
> other.
> 
> With the group FD: the userspace has to read sysfs, find the list of
> devices in the group, open the group fd, create device FDs for each
> device using the name from sysfs.
> 
> Starting from a BDF the general pseudo code is
>  group_path = readlink("/sys/bus/pci/devices/BDF/iommu_group")
>  group_name = basename(group_path)
>  group_fd = open("/dev/vfio/"+group_name)
>  device_fd = ioctl(VFIO_GROUP_GET_DEVICE_FD, BDF);
> 
> Without the group FD: the userspace has to read sysfs, find the list
> of devices in the group and then open the device-specific cdev (found
> via sysfs) and link them to a /dev/ioasid FD.
> 
> Starting from a BDF the general pseudo code is:
>  device_name = first_directory_of("/sys/bus/pci/devices/BDF/vfio/")
>  device_fd = open("/dev/vfio/"+device_name)
>  ioasidfd = open("/dev/ioasid")
>  ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)

This is exactly the implicit vs explicit semantics.  In the existing
vfio case, the user needs to explicitly interact with the group.  In
your proposal, the user interacts with the device, the group concept is
an implicit restriction.  You've listed a step in the description about
a "list of devices in the group", but nothing in the pseudo code
reflects that step.  I expect it would be a subtly missed by any
userspace driver developer unless they happen to work on a system where
the grouping is not ideal.  I think that makes the interface hard to
use correctly.

> These two routes can have identical outcomes and identical security
> checks.
> 
> In both cases if userspace wants a list of BDFs in the same group as
> the BDF it is interested in:
>    readdir("/sys/bus/pci/devices/BDF/iommu_group/devices")
> 
> It seems like a very small difference to me.

The difference is that the group becomes a nuance, that I expect would
be ignored, rather than a first class concept in the API.

> I still don't see how the group restriction gets surfaced to the
> application through the group FD. The applications I looked through
> just treat the group FD as a step on their way to get the device_fd.

A step where the developer hopefully recognizes that there might be
other devices in a group, a group can't be opened more than once, the
group has a flag indicating viability, they can't actually get the
device fd until the group is attached to an IOMMU context, all devices
in the group therefore have the same IOMMU context, and device fd isn't
actually available until they've gone through a proper setup, which is
an additional layer of protection.  A userspace vfio developer may not
understand why a group isn't viable, but they have that clue that it's
something at the group level to investigate.

Most of the userspace vfio drivers that I haven't contributed myself
have come about with little or no interaction from me, so I'd like to
think that the vfio uapi is actually somewhat intuitive in its concepts
and difficult to use incorrectly.  Thanks,

Alex

