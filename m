Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986B137703C
	for <lists+cgroups@lfdr.de>; Sat,  8 May 2021 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhEHHIg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 May 2021 03:08:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:51092 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhEHHIg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 8 May 2021 03:08:36 -0400
IronPort-SDR: QFS3E9UGG65H3pX352oiZNGkzdnhp1gyexQLrkqcvxtbxm+jRukJ4SBGZjsMc2Z43E6Dp2KHou
 mkTZaqfmPAjw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="179129212"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="179129212"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 00:07:34 -0700
IronPort-SDR: HcYo65eFc2I9AQ9MFhV/t+Tiui1lCCrJbkRQDdije3CmI44usgCC0xSeoI94otqxA99wpkX9Pr
 7G/V+Gvra+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="431898036"
Received: from yiliu-dev.bj.intel.com (HELO yiliu-dev) ([10.238.156.135])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2021 00:07:30 -0700
Date:   Sat, 8 May 2021 15:06:17 +0800
From:   Liu Yi L <yi.l.liu@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     yi.l.liu@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210508150617.1e357fcf@yiliu-dev>
In-Reply-To: <20210505222120.GM1370958@nvidia.com>
References: <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210426123817.GQ1370958@nvidia.com>
        <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210504084148.4f61d0b5@jacob-builder>
        <20210504180050.GB1370958@nvidia.com>
        <20210504151154.02908c63@jacob-builder>
        <20210504231530.GE1370958@nvidia.com>
        <20210505102259.044cafdf@jacob-builder>
        <20210505180023.GJ1370958@nvidia.com>
        <20210505130446.3ee2fccd@jacob-builder>
        <20210505222120.GM1370958@nvidia.com>
Organization: IAGS/SSE(OTC)
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Wed, 5 May 2021 19:21:20 -0300, Jason Gunthorpe wrote:

> On Wed, May 05, 2021 at 01:04:46PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 5 May 2021 15:00:23 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Wed, May 05, 2021 at 10:22:59AM -0700, Jacob Pan wrote:
> > >   
> > > > Global and pluggable are for slightly separate reasons.
> > > > - We need global PASID on VT-d in that we need to support shared
> > > > workqueues (SWQ). E.g. One SWQ can be wrapped into two mdevs then
> > > > assigned to two VMs. Each VM uses its private guest PASID to submit
> > > > work but each guest PASID must be translated to a global (system-wide)
> > > > host PASID to avoid conflict. Also, since PASID table storage is per
> > > > PF, if two mdevs of the same PF are assigned to different VMs, the
> > > > PASIDs must be unique.    
> > > 
> > > From a protocol perspective each RID has a unique PASID table, and
> > > RIDs can have overlapping PASIDs.
> > >   
> > True, per RID or per PF as I was referring to.
> >   
> > > Since your SWQ is connected to a single RID the requirement that
> > > PASIDs are unique to the RID ensures they are sufficiently unique.
> > >   
> > True, but one process can submit work to multiple mdevs from different
> > RIDs/PFs. One process uses one PASID and PASID translation table is per VM.
> > The same PASID is used for all the PASID tables of each RID.  
> 
> If the model is "assign this PASID to this RID" then yes, there is a
> big problem keeping everything straight that can only be solved with a
> global table.
> 
> But if the model is "give me a PASID for this RID" then it isn't such
> a problem.

Let me double confirm if I'm understanding you correctly. So your suggestion
is to have a per-RID PASID namespace, which can be maintainer by IOMMU driver.
right? Take native SVM usage as an example, everytime a process is bound with
a device, a PASID within this RID will be allocated. Am I correct so far?

If yes, then there is a case in which IOTLB efficiency is really low. Let's ay
there is a process bound with multiple devices(RIDs) and has different PASIDs
allocated for each RID. In such case, the PASID values are different for each
RID. As most vendor will do, PASID will be used to tag IOTLB entries. So in such
case, here will be multiple IOTLB entries for a single VA->PA mapping. And the
number of such duplicate IOTLB entries increases linearly per the number of the
device number. Seems not good from performance perspective.

> 
> Basically trying to enforce a uniform PASID for an IOASID across all
> RIDs attached to it is not such a nice choice.
> 
> > > That is fine, but all this stuff should be inside the Intel vIOMMU
> > > driver not made into a global resource of the entire iommu subsystem.
> > >   
> > Intel vIOMMU has to use a generic uAPI to allocate PASID so the generic
> > code need to have this option. I guess you are saying we should also have a
> > per RID allocation option in addition to global?  
> 
> There always has to be a RID involvement for the PASID, for security,
> this issue really boils down to where the PASID lives.
> 
> If you need the PASID attached to the IOASID then it has to be global
> because the IOASID can be attached to any RID and must keep the same
> PASID.
> 
> If the PASID is learned when the IOASID is attached to a RID then the
> PASID is more flexible and isn't attached to the IOASID.
> 
> Honestly I'm a little leary to bake into a UAPI a specific HW choice
> that Intel made here.
> 
> I would advise making the "attach a global PASID to this IOASID"
> operation explicit and opt into for case that actually need it.
> 
> Which implies the API to the iommu driver should be more like:
> 
>   'assign an IOASID to this RID and return the PASID'
>   'reserve a PASID from every RID'
>   'assign an IOASID to this RID and use this specific PASID'
> 
> In all cases the scope of those operations are completely local to a
> certain IOMMU driver - 'reserver a PASID from every RID' is really
> every RID that driver can operate on.

Also, this reservation will be failed if the PASID happens to be occupied
by previous usage. As the PASID translation table is per-VM, ENQCMD in VM
will be a problem under such PASID management model.

> 
> So it is hard to see why the allocator should be a global resource and
> not something that is part of the iommu driver exclusively.
> 
> Jason

-- 
Regards,
Yi Liu
