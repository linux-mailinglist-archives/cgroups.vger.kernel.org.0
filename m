Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7DF3509C0
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 23:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCaVsd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 17:48:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:29027 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhCaVsZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 17:48:25 -0400
IronPort-SDR: vX12jxrGuq0xe3XtWkuORTItHWn5aGH+I5j6/GFF7XEHN0nV+90Sc6UN9rH3JYl57e1ILvxJTc
 P+uZmMYbYmgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179228134"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="179228134"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:48:25 -0700
IronPort-SDR: yk80OYLcR4tKt5SiMAstpyOv/C1XaphqzO42mvr0itegwo8WfHbIUUBa3uWqTfJN+ktLFvP/hp
 xhWQ7ncb1NCA==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="394215231"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:48:25 -0700
Date:   Wed, 31 Mar 2021 14:50:56 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210331145056.760478ca@jacob-builder>
In-Reply-To: <20210331183324.GR1463678@nvidia.com>
References: <20210322120300.GU2356281@nvidia.com>
        <20210324120528.24d82dbd@jacob-builder>
        <20210329163147.GG2356281@nvidia.com>
        <20210329155526.2ad791a9@jacob-builder>
        <20210330134313.GP2356281@nvidia.com>
        <20210330171041.70f2d7d0@jacob-builder>
        <20210331122805.GC1463678@nvidia.com>
        <20210331093457.753512d4@jacob-builder>
        <20210331173148.GN1463678@nvidia.com>
        <20210331112030.174e77b0@jacob-builder>
        <20210331183324.GR1463678@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Wed, 31 Mar 2021 15:33:24 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 31, 2021 at 11:20:30AM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 31 Mar 2021 14:31:48 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > > > We should try to avoid hidden behind the scenes kernel
> > > > > interconnections between subsystems.
> > > > >     
>  [...]  
>  [...]  
> > yes, this is done in this patchset.
> >   
>  [...]  
> > Just to clarify, you are saying (when FREE happens before proper
> > teardown) there is no need to proactively notify all users of the
> > IOASID to drop their reference. Instead, just wait for the other
> > parties to naturally close and drop their references. Am I
> > understanding you correctly?  
> 
> Yes. What are receivers going to do when you notify them anyhow? What
> will a mdev do? This is how you get into they crazy locking problems.
> 
The receivers perform cleanup work similar to normal unbind. Drain/Abort
PASID. Locking is an issue in that the atomic notifier is under IOASID
spinlock, so I provided a common ordered workqueue to let mdev drivers
queue cleanup work that cannot be done in atomic context. Not ideal. Also
need to prevent nested notifications for certain cases.

> It is an error for userspace to shutdown like this, recover sensibly
> and don't crash the kernel. PCIe error TLPs are expected, supress
> them. That is what we decided on the mmu notifier discussion.
> 
> > I feel having the notifications can add two values:
> > 1. Shorten the duration of errors (as you mentioned below), FD close can
> > take a long and unpredictable time. e.g. FD shared.  
> 
> Only if userspace exits in some uncontrolled way. In a controlled exit
> it can close all the FDs in the right order.
> 
> It is OK if userspace does something weird and ends up with disabled
> IOASIDs. It shouldn't do that if it cares.
> 
Agreed.

> > 2. Provide teardown ordering among PASID users. i.e. vCPU, IOMMU, mdev.
> >  
> 
> This is a hard ask too, there is no natural ordering here I can see,
> obviously we want vcpu, mdev, iommu for qemu but that doesn't seem to
> fall out unless we explicitly hard wire it into the kernel.
> 
The ordering problem as I understood is that it is difficult for KVM to
rendezvous all vCPUs before updating PASID translation table. So there
could be in-flight enqcmd with the stale PASID after the PASID table update
and refcount drop.

If KVM is the last one to drop the PASID refcount, the PASID could be
immediately reused and starts a new life. The in-flight enqcmd with the
stale PASID could cause problems. The likelihood and window is very small.

If we ensure KVM does PASID table update before IOMMU and mdev driver, the
stale PASID in the in-flight enqcmd would be be drained before starting
a new life.

Perhaps Yi and Kevin can explain this better.

> Doesn't kvm always kill the vCPU first based on the mmu notifier
> shooting down all the memory? IIRC this happens before FD close?
> 
I don't know the answer, Kevin & Yi?

> > > The duration between unmapping the ioasid and releasing all HW access
> > > will have HW see PCIE TLP errors due to the blocked access. If
> > > userspace messes up the order it is fine to cause this. We already had
> > > this dicussion when talking about how to deal with process exit in the
> > > simple SVA case.  
> > Yes, we have disabled fault reporting during this period. The slight
> > differences vs. the simple SVA case is that KVM is also involved and
> > there might be an ordering requirement to stop vCPU first.  
> 
> KVM can continue to use the PASIDs, they are parked and DMA is
> permanently blocked. When KVM reaches a natural point in its teardown
> it can release them.
> 
> If you have to stop the vcpu from a iommu notifier you are in the
> crazy locking world I mentioned. IMHO don't create exciting locking
> problems just to avoid PCI errors in uncontrolled shutdown.
> 
> Suppress the errors instead.
> 
I agree, this simplify things a lot. Just need to clarify the in-flight
enqcmd case.

> Jason


Thanks,

Jacob
