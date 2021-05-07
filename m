Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72A3769DF
	for <lists+cgroups@lfdr.de>; Fri,  7 May 2021 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEGSQE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 May 2021 14:16:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:18120 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhEGSQA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 7 May 2021 14:16:00 -0400
IronPort-SDR: fpDwM1Cv9Sgamd69CD5QZCvvHi2/mQxzDdCG7Wpv9OfihOEiF9I9/AjCf9KY7KRH1didxwuiO3
 wt2+tFJtUzNw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="198834105"
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="198834105"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 11:14:59 -0700
IronPort-SDR: KGO5KDQ3aq1E4r48nm26o5wyNsivi8/uYFBHxEQi04F68S1zKd6vtgxoa348+BbryRQGanXZtK
 c/beNWJOh9bg==
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="407516969"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 11:14:59 -0700
Date:   Fri, 7 May 2021 11:14:58 -0700
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
Message-ID: <20210507181458.GA73499@otc-nc-03>
References: <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <20210507172051.GW1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507172051.GW1370958@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 07, 2021 at 02:20:51PM -0300, Jason Gunthorpe wrote:
> On Thu, May 06, 2021 at 09:32:40AM -0700, Raj, Ashok wrote:
> 
> > For platforms that support ENQCMD, it is required to mandate PASIDs are
> > global across the entire system. Maybe its better to call them gPASID for
> > guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> > wide mapping for ENQCMD and not a per-RID based mapping. (We covered that
> > in earlier responses)
> 
> I don't think it is actually ENQCMD that forces this, ENQCMD can use a
> per-RID PASID in the translation table as well.

When using ENQCMD the PASID that needs to be sent on the wire is picked
from an MSR setup by kernel. This is context switched along with the
process. So each process has only 1 PASID that can go out when using
ENQCMD. ENQCMD takes one mmio address specific to the acclerator and a
source for the descriptor. 

When one application is connecting to more than one accelerator since this
is MSR based filled in by the cpu instruction automaticaly requires both
accelerators to use the same PASID. 

Did you refer to this implementation? or something else?
> 
> You get forced here only based on the design of the vIOMMU
> communication channel. If the guest can demand any RID is attached to
> a specific guest determined PASID then the hypervisor must accommodate
> that.

True, but when we have guest using vSVM, and enabling vENQCMD the
requirement is the same inside a guest.
> 
> > > Which would be a different behavior than something like Intel's top
> > > level IOASID that doesn't claim all the PASIDs.
> > 
> > isn't this simple, if we can say ioasid allocator can provide 
> > 
> > - system wide PASID
> > - RID local PASID
> > 
> > Based on platform capabilities that require such differentiation?
> 
> I think at the uAPI level the callpaths that require allocating a
> PASID from a group of RIDs should be explicit in their intention and
> not implicitly rely on a certain allocator behavior.

The difficult part I see is, when one application establishes a path to one
acclerator, we have no knowledge if its going to connect to a second, third 
or such. I don't see how this can work reasonably well. What if PASIDx is allocated
for one, but the second RID its trying to attach already has this
PASID allocated? 

> 
> If you want to get a PASID that can be used with every RID on in your
> /dev/ioasid then ask for that exactly.

Correct, but how does guest through vIOMMU driver communicate that intent so uAPI
plumbing can do this? I mean architecturally via IOMMU interfaces? 


Cheers,
Ashok
