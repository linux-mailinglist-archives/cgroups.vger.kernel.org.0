Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D5351A3D
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhDAR6s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 13:58:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:59725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234850AbhDARzw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:52 -0400
IronPort-SDR: Gss/hcMTKFH1Aynyb3drUC8tAMQFPbjs3bwHXwKYP+sFwS/IMrP4RdkYvq6uxgApCUyaDtCBB4
 hGOcok3sT+dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192322670"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192322670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 10:21:23 -0700
IronPort-SDR: FFJ3yy27N0ijmymlKcf7V8zicG08idghljFw0s4Y6KD/UjpiAbD1gOdnFbw1W3kJKMbXkxqAG8
 ft75EXtnVLnQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="394609303"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 10:21:23 -0700
Date:   Thu, 1 Apr 2021 10:23:55 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401102355.38b0b7d7@jacob-builder>
In-Reply-To: <20210401003705.GS1463678@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <20210322120300.GU2356281@nvidia.com>
        <20210324120528.24d82dbd@jacob-builder>
        <20210329163147.GG2356281@nvidia.com>
        <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210330132740.GB1403691@nvidia.com>
        <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210331123801.GD1463678@nvidia.com>
        <20210331164621.5f0b0d63@jacob-builder>
        <20210401003705.GS1463678@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Wed, 31 Mar 2021 21:37:05 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 31, 2021 at 04:46:21PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 31 Mar 2021 09:38:01 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > > > Get rid of the ioasid set.
> > > > >
> > > > > Each driver has its own list of allowed ioasids.    
> > >  [...]  
> > > 
> > > The /dev/ioasid FD replaces this security check. By becoming FD
> > > centric you don't need additional kernel security objects.
> > > 
> > > Any process with access to the /dev/ioasid FD is allowed to control
> > > those PASID. The seperation between VMs falls naturally from the
> > > seperation of FDs without creating additional, complicated, security
> > > infrastrucure in the kernel.
> > > 
> > > This is why all APIs must be FD focused, and you need to have a
> > > logical layering of responsibility.
> > > 
> > >  Allocate a /dev/ioasid FD
> > >  Allocate PASIDs inside the FD
Just to be super clear. Do we allocate a FD for each PASID and return the
FD to the user? Or return the plain PASID number back to the user space?

> > >  Assign memory to the PASIDS
> > > 
> > >  Open a device FD, eg from VFIO or VDP
> > >  Instruct the device FD to authorize the device to access PASID A in
> > >  an ioasid FD  
> > How do we know user provided PASID A was allocated by the ioasid FD?  
> 
> You pass in the ioasid FD and use a 'get pasid from fdno' API to
> extract the required kernel structure.
> 
Seems you are talking about two FDs:
- /dev/ioasid FD
- per IOASID FD
This API ioasid = get_pasid_from_fd(dev_ioasid_fd, ioasid_fd);
dev_ioasid_fd will find the xarray for all the PASIDs allocated under it,
ioasid_fd wil be the index into the xarray to retrieve the actual ioasid.
Correct?

> > Shouldn't we validate user input by tracking which PASIDs are
> > allocated by which ioasid FD?  
> 
> Yes, but it is integral to the ioasid FD, not something separated.
> 
OK, if we have per IOASID FD in addition to the /dev/ioasid FD we can
validate user input.

> > > VFIO extracts some kernel representation of the ioasid from the ioasid
> > > fd using an API
> > >   
> > This lookup API seems to be asking for per ioasid FD storage array.
> > Today, the ioasid_set is per mm and contains a Xarray.   
> 
> Right, put the xarray per FD. A set per mm is fairly nonsensical, we
> don't use the mm as that kind of security key.
> 
Sounds good, one xarray per /dev/ioasid FD.

> > Since each VM, KVM can only open one ioasid FD, this per FD array
> > would be equivalent to the per mm ioasid_set, right?  
> 
> Why only one?  Each interaction with the other FDs should include the
> PASID/FD pair. There is no restriction to just one.
> 
OK, one per subsystem-VM. For example, if a VM has a VFIO and a VDPA
device, it should only two /dev/ioasid FDs respectively. Correct?

> > > VFIO does some kernel call to IOMMU/IOASID layer that says 'tell the
> > > IOMMU that this PCI device is allowed to use this PASID'  
> >
> > Would it be redundant to what iommu_uapi_sva_bind_gpasid() does? I
> > thought the idea is to use ioasid FD IOCTL to issue IOMMU uAPI calls.
> > Or we can skip this step for now and wait for the user to do SVA bind.  
> 
> I'm not sure what you are asking.
> 
> Possibly some of the IOMMU API will need a bit adjusting to make
> things split.
> 
> The act of programming the page tables and the act of authorizing a
> PCI BDF to use a PASID are distinct things with two different IOCTLs.
> 
Why separate? I don't see a use case to just authorize a PASID but don't
bind it with a page table. The very act of bind page table *is* the
authorization.

> iommu_uapi_sva_bind_gpasid() is never called by anything, and it's
> uAPI is never implemented.
> 
Just a little background here. We have been working on the vSVA stack
since 2017. At the time, VFIO was the de facto interface for IOMMU-aware
driver framework. These uAPIs were always developed alone side with the
accompanying VFIO patches served as consumers. By the time these IOMMU uAPIs
were merged after reviews from most vendors, the VFIO patchset was
approaching maturity in around v7. This is when we suddenly saw a new
request to support VDPA, which attempted VFIO earlier but ultimately moved
away.

For a complex stack like vSVA, I feel we have to reduce moving parts and do
some divide and conquer.

> Joerg? Why did you merge dead uapi and dead code?
> 
> Jason


Thanks,

Jacob
