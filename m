Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A41D350AF5
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 01:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhCaXoD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 19:44:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:36876 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhCaXnv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 19:43:51 -0400
IronPort-SDR: p6+cgFZ/1GpeleyupLG9VADpRHvDNTSKp4+PXF2WvgPmCu4PT3Ce0xe0vbDUhdMJFRPeaT2nDY
 yJAfl0z8x+fQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179243180"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="179243180"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:43:50 -0700
IronPort-SDR: VRxcxsUEV0sH/4DZfBI5I2LaEnMUx/NQkTnVoC7WXr8JeuKEuNiKMslo/z7SMKRlFQ9KRG92fm
 ptyyNqAhMyTQ==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="379087406"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:43:50 -0700
Date:   Wed, 31 Mar 2021 16:46:21 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <20210331164621.5f0b0d63@jacob-builder>
In-Reply-To: <20210331123801.GD1463678@nvidia.com>
References: <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <20210322120300.GU2356281@nvidia.com>
        <20210324120528.24d82dbd@jacob-builder>
        <20210329163147.GG2356281@nvidia.com>
        <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210330132740.GB1403691@nvidia.com>
        <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210331123801.GD1463678@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Wed, 31 Mar 2021 09:38:01 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > Get rid of the ioasid set.
> > >
> > > Each driver has its own list of allowed ioasids.  
>  [...]  
> 
> The /dev/ioasid FD replaces this security check. By becoming FD
> centric you don't need additional kernel security objects.
> 
> Any process with access to the /dev/ioasid FD is allowed to control
> those PASID. The seperation between VMs falls naturally from the
> seperation of FDs without creating additional, complicated, security
> infrastrucure in the kernel.
> 
> This is why all APIs must be FD focused, and you need to have a
> logical layering of responsibility.
> 
>  Allocate a /dev/ioasid FD
>  Allocate PASIDs inside the FD
>  Assign memory to the PASIDS
> 
>  Open a device FD, eg from VFIO or VDP
>  Instruct the device FD to authorize the device to access PASID A in
>  an ioasid FD
How do we know user provided PASID A was allocated by the ioasid FD?
Shouldn't we validate user input by tracking which PASIDs are allocated by
which ioasid FD? This is one reason why we have ioasid_set and its xarray.

>    * Prior to being authorized the device will have NO access to any
>      PASID
>    * Presenting BOTH the device FD and the ioasid FD to the kernel
>      is the security check. Any process with both FDs is allowed to
>      make the connection. This is normal Unix FD centric thinking.
> 
> > > Register a ioasid in the driver's list by passing the fd and ioasid #
> > >  
> > 
> > The fd here is a device fd. Am I right?   
> 
> It would be the vfio_device FD, for instance, and a VFIO IOCTL.
> 
> > If yes, your idea is ioasid is allocated via /dev/ioasid and
> > associated with device fd via either VFIO or vDPA ioctl. right?
> > sorry I may be asking silly questions but really need to ensure we
> > are talking in the same page.  
> 
> Yes, this is right
> 
> > > No listening to events. A simple understandable security model.  
> > 
> > For this suggestion, I have a little bit concern if we may have A-B/B-A
> > lock sequence issue since it requires the /dev/ioasid (if it supports)
> > to call back into VFIO/VDPA to check if the ioasid has been registered
> > to device FD and record it in the per-device list. right? Let's have
> > more discussion based on the skeleton sent by Kevin.  
> 
> Callbacks would be backwards.
> 
> User calls vfio with vfio_device fd and dev/ioasid fd
> 
> VFIO extracts some kernel representation of the ioasid from the ioasid
> fd using an API
> 
This lookup API seems to be asking for per ioasid FD storage array. Today,
the ioasid_set is per mm and contains a Xarray. Since each VM, KVM can only
open one ioasid FD, this per FD array would be equivalent to the per mm
ioasid_set, right?

> VFIO does some kernel call to IOMMU/IOASID layer that says 'tell the
> IOMMU that this PCI device is allowed to use this PASID'
> 
Would it be redundant to what iommu_uapi_sva_bind_gpasid() does? I thought
the idea is to use ioasid FD IOCTL to issue IOMMU uAPI calls. Or we can
skip this step for now and wait for the user to do SVA bind.

> VFIO mdev drivers then record that the PASID is allowed in its own
> device specific struct for later checking during other system calls.


Thanks,

Jacob
