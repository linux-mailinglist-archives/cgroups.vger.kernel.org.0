Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA11348127
	for <lists+cgroups@lfdr.de>; Wed, 24 Mar 2021 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhCXTDN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 24 Mar 2021 15:03:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:21735 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237772AbhCXTDC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 24 Mar 2021 15:03:02 -0400
IronPort-SDR: cabSPKUyXvJu5GSeShXCm/n5wIaaMsU+keX7iUhEFEiw/D5TiZa7/wH6t/pIzQmfHiQqvuIqHk
 bdDLOlUx/GQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178324120"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="178324120"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 12:03:01 -0700
IronPort-SDR: vEVuZEgytcldetjUfo6Sl5MqAEoBbiZloTVAaWxshrn8DYwryViiHiE4G3TH6o/qH6X0x6iK7x
 GHD4R+R+6rhw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="525345239"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 12:03:01 -0700
Date:   Wed, 24 Mar 2021 12:05:28 -0700
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
Message-ID: <20210324120528.24d82dbd@jacob-builder>
In-Reply-To: <20210322120300.GU2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210318172234.3e8c34f7@jacob-builder>
        <YFR10eeDVf5ZHV5l@myrica>
        <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <20210322120300.GU2356281@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Mon, 22 Mar 2021 09:03:00 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Mar 19, 2021 at 11:22:21AM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Fri, 19 Mar 2021 10:54:32 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Fri, Mar 19, 2021 at 02:41:32PM +0100, Jean-Philippe Brucker
> > > wrote:  
> > > > On Fri, Mar 19, 2021 at 09:46:45AM -0300, Jason Gunthorpe wrote:    
> > > > > On Fri, Mar 19, 2021 at 10:58:41AM +0100, Jean-Philippe Brucker
> > > > > wrote: 
> > > > > > Although there is no use for it at the moment (only two upstream
> > > > > > users and it looks like amdkfd always uses current too), I quite
> > > > > > like the client-server model where the privileged process does
> > > > > > bind() and programs the hardware queue on behalf of the client
> > > > > > process.    
> > > > > 
> > > > > This creates a lot complexity, how do does process A get a secure
> > > > > reference to B? How does it access the memory in B to setup the
> > > > > HW?    
> > > > 
> > > > mm_access() for example, and passing addresses via IPC    
> > > 
> > > I'd rather the source process establish its own PASID and then pass
> > > the rights to use it to some other process via FD passing than try to
> > > go the other way. There are lots of security questions with something
> > > like mm_access.
> > >   
> > 
> > Thank you all for the input, it sounds like we are OK to remove mm
> > argument from iommu_sva_bind_device() and iommu_sva_alloc_pasid() for
> > now?
> > 
> > Let me try to summarize PASID allocation as below:
> > 
> > Interfaces	| Usage	|  Limit	| bind¹ |User visible
> > /dev/ioasid²	| G-SVA/IOVA	|  cgroup	| No
> > |Yes char dev³	| SVA		|  cgroup	|
> > Yes	|No iommu driver	| default PASID|  no
> > | No	|No kernel		| super SVA	| no
> > 	| yes   |No
> > 
> > ¹ Allocated during SVA bind
> > ² PASIDs allocated via /dev/ioasid are not bound to any mm. But its
> >   ownership is assigned to the process that does the allocation.  
> 
> What does "not bound to a mm" mean?
> 
I meant, the IOASID allocated via /dev/ioasid is in a clean state (just a
number). It's initial state is not bound to an mm. Unlike, sva_bind_device()
where the IOASID is allocated during bind time.

The use case is to support guest SVA bind, where allocation and bind are in
two separate steps.

> IMHO a use created PASID is either bound to a mm (current) at creation
> time, or it will never be bound to a mm and its page table is under
> user control via /dev/ioasid.
> 
True for PASID used in native SVA bind. But for binding with a guest mm,
PASID is allocated first (VT-d virtual cmd interface Spec 10.4.44), the
bind with the host IOMMU when vIOMMU PASID cache is invalidated.

Our intention is to have two separate interfaces:
1. /dev/ioasid (allocation/free only)
2. /dev/sva (handles all SVA related activities including page tables)

> I thought the whole point of something like a /dev/ioasid was to get
> away from each and every device creating its own PASID interface?
> 
yes, but only for the use cases that need to expose PASID to the userspace.
AFAICT, the cases are:
1. guest SVA (bind guest mm)
2. full PF/VF assignment(not mediated) where guest driver want to program
the actual PASID onto the device.

> It maybe somewhat reasonable that some devices could have some easy
> 'make a SVA PASID on current' interface built in,
I agree, this is the case PASID is hidden from the userspace, right? e.g.
uacce.

> but anything more
> complicated should use /dev/ioasid, and anything consuming PASID
> should also have an API to import and attach a PASID from /dev/ioasid.
> 
Would the above two use cases constitute the "complicated" criteria? Or we
should say anything that need the explicit PASID value has to through
/dev/ioasid?

Could you give some highlevel hint on the APIs that hook up IOASID
allocated from /dev/ioasid and use cases that combine device and domain
information? Yi is working on /dev/sva RFC, it would be good to have a
direction check.

> > Currently, the proposed /dev/ioasid interface does not map individual
> > PASID with an FD. The FD is at the ioasid_set granularity and bond to
> > the current mm. We could extend the IOCTLs to cover individual PASID-FD
> > passing case when use cases arise. Would this work?  
> 
> Is it a good idea that the FD is per ioasid_set ?
We were thinking the allocation IOCTL is on a per set basis, then we know
the ownership of between PASIDs and its set. If per PASID FD is needed, we
can extend.

> What is the set used
> for?
> 
I tried to document the concept in
https://lore.kernel.org/lkml/1614463286-97618-2-git-send-email-jacob.jun.pan@linux.intel.com/

In terms of usage for guest SVA, an ioasid_set is mostly tied to a host mm,
the use case is as the following:
1. Identify a pool of PASIDs for permission checking (below to the same VM),
e.g. only allow SVA binding for PASIDs allocated from the same set.

2. Allow different PASID-aware kernel subsystems to associate, e.g. KVM,
device drivers, and IOMMU driver. i.e. each KVM instance only cares about
the ioasid_set associated with the VM. Events notifications are also within
the ioasid_set to synchronize PASID states.

3. Guest-Host PASID look up (each set has its own XArray to store the
mapping)

4. Quota control (going away once we have cgroup)

> Usually kernel interfaces work nicer with a one fd/one object model.
> 
> But even if it is a set, you could pass the set between co-operating
> processes and the PASID can be created in the correct 'current'. But
> there is all kinds of security questsions as soon as you start doing
> anything like this - is there really a use case?
> 
We don't see a use case for passing ioasid_set to another process. All the
four use cases above are for the current process.

> Jason


Thanks,

Jacob
