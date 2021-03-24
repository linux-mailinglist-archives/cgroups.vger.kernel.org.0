Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E332347E65
	for <lists+cgroups@lfdr.de>; Wed, 24 Mar 2021 18:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhCXRBE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 24 Mar 2021 13:01:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:50718 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236969AbhCXRAe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 24 Mar 2021 13:00:34 -0400
IronPort-SDR: 35iqYBQVVRjVFqbbIO2lq3+7VCYylIvJsaUfh36OrwNLO3S8iHTlqNNKI/pIDIjpAiH03xfroh
 B8G8wPJgLiNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170094181"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="170094181"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 10:00:33 -0700
IronPort-SDR: YaXrQdlMK3wx/87Gouc8P/JcmCFUnmxlV9XMFtnEUTpfgHtOYwd8VKOOu4hPqOQ8ocZEoUbDJh
 55GbULgN11QA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="593442260"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 10:00:32 -0700
Date:   Wed, 24 Mar 2021 10:02:46 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20210324100246.4e6b8aa1@jacob-builder>
In-Reply-To: <YFhiMLR35WWMW/Hu@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210318172234.3e8c34f7@jacob-builder>
        <YFR10eeDVf5ZHV5l@myrica>
        <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <YFhiMLR35WWMW/Hu@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jean-Philippe,

On Mon, 22 Mar 2021 10:24:00 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

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
> 
> Fine by me. By the way the IDXD currently missues the bind API for
> supervisor PASID, and the drvdata parameter isn't otherwise used. This
> would be a good occasion to clean both. The new bind prototype could be:
> 
> struct iommu_sva *iommu_sva_bind_device(struct device *dev, int flags)
> 
yes, we really just hijacked drvdata as flags, it would be cleaner to use
flags explicitly.

> And a flag IOMMU_SVA_BIND_SUPERVISOR (not that I plan to implement it in
> the SMMU, but I think we need to clean the current usage)
> 
You mean move #define SVM_FLAG_SUPERVISOR_MODE out of Intel code to be a
generic flag in iommu-sva-lib.h called IOMMU_SVA_BIND_SUPERVISOR?

I agree if that is the proposal.

> > 
> > Let me try to summarize PASID allocation as below:
> > 
> > Interfaces	| Usage	|  Limit	| bind¹ |User visible
> > --------------------------------------------------------------------
> > /dev/ioasid²	| G-SVA/IOVA	|  cgroup	| No
> > |Yes
> > --------------------------------------------------------------------
> > char dev³	| SVA		|  cgroup	| Yes	|No
> > --------------------------------------------------------------------
> > iommu driver	| default PASID|  no		| No	|No
> >  
> 
> Is this PASID #0?
> 
True for native case but not limited to PASID#0 for guest case. E.g. for
mdev assignment with guest IOVA, the guest PASID would #0, but the host aux
domain default PASID can be non-zero. Here I meant to include both cases.

> > --------------------------------------------------------------------
> > kernel		| super SVA	| no		| yes   |No
> > --------------------------------------------------------------------  
> 
> Also wondering about device driver allocating auxiliary domains for their
> private use, to do iommu_map/unmap on private PASIDs (a clean replacement
> to super SVA, for example). Would that go through the same path as
> /dev/ioasid and use the cgroup of current task?
>
For the in-kernel private use, I don't think we should restrict based on
cgroup, since there is no affinity to user processes. I also think the
PASID allocation should just use kernel API instead of /dev/ioasid. Why
would user space need to know the actual PASID # for device private domains?
Maybe I missed your idea?

> Thanks,
> Jean
> 
> > 
> > ¹ Allocated during SVA bind
> > ² PASIDs allocated via /dev/ioasid are not bound to any mm. But its
> >   ownership is assigned to the process that does the allocation.
> > ³ Include uacce, other private device driver char dev such as idxd
> > 
> > Currently, the proposed /dev/ioasid interface does not map individual
> > PASID with an FD. The FD is at the ioasid_set granularity and bond to
> > the current mm. We could extend the IOCTLs to cover individual PASID-FD
> > passing case when use cases arise. Would this work?
> > 
> > Thanks,
> > 
> > Jacob  


Thanks,

Jacob
