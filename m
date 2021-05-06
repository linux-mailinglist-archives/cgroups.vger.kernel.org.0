Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F37637587C
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhEFQeS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 12:34:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:40079 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235167AbhEFQeS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 6 May 2021 12:34:18 -0400
IronPort-SDR: Ll81RRz0a55T72YKjx5In/GBjGClONGsGQk5pkxxpJU+vrosxZ71eLdQFtpL+rFwHbv+ePx0hR
 kPCY1Yti1mIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="196495528"
X-IronPort-AV: E=Sophos;i="5.82,278,1613462400"; 
   d="scan'208";a="196495528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 09:32:42 -0700
IronPort-SDR: wyPtzq1AlkC8XDzoyMUG3bfiBuyrMzsFN73gf9J8keEmp0nD/1ecblUB/ji3/061mupVrEkq5v
 gUQKN9QAVdPQ==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="428627255"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 09:32:41 -0700
Date:   Thu, 6 May 2021 09:32:40 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210506163240.GA9058@otc-nc-03>
References: <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506122730.GQ1370958@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason

On Thu, May 06, 2021 at 09:27:30AM -0300, Jason Gunthorpe wrote:
> On Thu, May 06, 2021 at 09:23:48AM +0200, Jean-Philippe Brucker wrote:
> > On Wed, May 05, 2021 at 01:04:46PM -0700, Jacob Pan wrote:
> > > > > For ARM, since the guest owns the per device PASID table. There is no
> > > > > need to allocate PASIDs from the host nor the hypervisor. Without SWQ,
> > > > > there is no need for global PASID/SSID either. So PASID being global
> > > > > for ARM is for simplicity in case of host PASID/SSID.  
> > > > 
> > > > It isn't clear how ARM can support PASID and mdev but that is an
> > > > unrelated issue..
> > > > 
> > > AFAIK, the current SMMU device assignment is per RID, since only one stage2
> > > page tables per RID, not per PASID. This is equivalent to the older VT-d
> > > spec. prior to scalable mode.
> > 
> > Yes that's right. Since SMMUv3 has a single level-2 page table per RID, it
> > doesn't support assigning level-1 page tables to guests for mdevs (sub-VF
> > devices). So no PASIDs for mdevs, which also means each guest has its own
> > PASID space and the host doesn't track guest PASIDs.
> 
> Basically it means when the guest's top level IOASID is created for
> nesting that IOASID claims all PASID's on the RID and excludes any
> PASID IOASIDs from existing on the RID now or in future.

The way to look at it this is as follows:

For platforms that do not have a need to support shared work queue model
support for ENQCMD or similar, PASID space is naturally per RID. There is no
complication with this. Every RID has the full range of PASID's and no need
for host to track which PASIDs are allocated now or in future in the guest.

For platforms that support ENQCMD, it is required to mandate PASIDs are
global across the entire system. Maybe its better to call them gPASID for
guest and hPASID for host. Short reason being gPASID->hPASID is a guest
wide mapping for ENQCMD and not a per-RID based mapping. (We covered that
in earlier responses)

In our current implementation we actually don't separate this space, and
gPASID == hPASID. The iommu driver enforces that by using the custom
allocator and the architected interface that allows all guest vIOMMU
allocations to be proxied to host. Nothing but a glorified hypercall like
interface. In fact some OS's do use hypercall to get a hPASID vs using
the vCMD style interface.

For cases where there is full PASID range for every RID and completely
managed by the guest that requires no assist from host to ensure
uniqueness, they don't need to have a custom allocator. Maybe the general
allocator can have ways to ensure global uniqueness vs. RID wide
uniqueness. This is still managed by the iommu driver (vIOMMU) + the
backend for vCMD in the host IOMMU driver.

> 
> Which would be a different behavior than something like Intel's top
> level IOASID that doesn't claim all the PASIDs.

isn't this simple, if we can say ioasid allocator can provide 

- system wide PASID
- RID local PASID

Based on platform capabilities that require such differentiation?

And based on the other threads, if ioasid is just a pgtable representation,
it doesn't need a PASID per-se. But when you want to use SVM or such, you
can associate a PASID with it for the IOMMU to plumb things with hardware.

Cheers,
Ashok
