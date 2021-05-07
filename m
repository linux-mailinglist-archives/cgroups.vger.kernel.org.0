Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E577B376AA5
	for <lists+cgroups@lfdr.de>; Fri,  7 May 2021 21:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhEGTYa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 May 2021 15:24:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:14862 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhEGTY2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 7 May 2021 15:24:28 -0400
IronPort-SDR: Aae5xii9ZaTXAAms2OtuMlRey0iGQ9pesGwCMc3SgrDvsFFDBFHC5Awe5pfVfo6U0SFmD69our
 Qp51jGGdYMmw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="260071989"
X-IronPort-AV: E=Sophos;i="5.82,281,1613462400"; 
   d="scan'208";a="260071989"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 12:23:27 -0700
IronPort-SDR: owknbHpIZ3mF/ie4r0R2rDOtoOSVpmTFhlXS/Dz3/RJ0W25pNZmjgimvjqKRfcf2tNEO9hhmvH
 gFAZrLHfFCRg==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="407536474"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 12:23:27 -0700
Date:   Fri, 7 May 2021 12:23:25 -0700
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
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507192325.GB73499@otc-nc-03>
References: <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <20210507172051.GW1370958@nvidia.com>
 <20210507181458.GA73499@otc-nc-03>
 <20210507182050.GX1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507182050.GX1370958@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason

- Removed lizefan's email due to bounces... 

On Fri, May 07, 2021 at 03:20:50PM -0300, Jason Gunthorpe wrote:
> On Fri, May 07, 2021 at 11:14:58AM -0700, Raj, Ashok wrote:
> > On Fri, May 07, 2021 at 02:20:51PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 06, 2021 at 09:32:40AM -0700, Raj, Ashok wrote:
> > > 
> > > > For platforms that support ENQCMD, it is required to mandate PASIDs are
> > > > global across the entire system. Maybe its better to call them gPASID for
> > > > guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> > > > wide mapping for ENQCMD and not a per-RID based mapping. (We covered that
> > > > in earlier responses)
> > > 
> > > I don't think it is actually ENQCMD that forces this, ENQCMD can use a
> > > per-RID PASID in the translation table as well.
> > 
> > When using ENQCMD the PASID that needs to be sent on the wire is picked
> > from an MSR setup by kernel. This is context switched along with the
> > process. So each process has only 1 PASID that can go out when using
> > ENQCMD. ENQCMD takes one mmio address specific to the acclerator and a
> > source for the descriptor.
> 
> Oh. I forgot this also globally locked the PASID to a single
> MSR. Sigh. That makes the whole mechanism useless for anything except
> whole process SVA.

Is there another kind of SVA? Our mapping from that each process requires a
single mm, and PASID for SVM was a direct map from that. 

> 
> It also make it a general kernel problem and not just related to the
> vIOMMU scenario.
> 
> > > I think at the uAPI level the callpaths that require allocating a
> > > PASID from a group of RIDs should be explicit in their intention and
> > > not implicitly rely on a certain allocator behavior.
> > 
> > The difficult part I see is, when one application establishes a path
> > to one acclerator, we have no knowledge if its going to connect to a
> > second, third or such. I don't see how this can work reasonably
> > well. What if PASIDx is allocated for one, but the second RID its
> > trying to attach already has this PASID allocated?
> 
> You mean like some kind of vIOMMU hot plug?

Not vIOMMU hot plug. but an application opens accel1, does a bind to
allocate a PASID. What i meant was kernel has no information if this needs
to be a per-RID PASID, or a global PASID. Keeping this global solves the
other problems or more complex mechanisms to say "Reserve this PASID on all
accelerators" which seems pretty complicated to implement.

Now are we loosing anything by keeping the PASIDs global? 

As we discussed there is no security issue since the PASID table that hosts 
these PASIDs for SVM are still per-RID.  For e.g.

app establishes connection to accl1, allocates PASID-X
   RID for accel1 now has PASID-X and the process mm plummed 
later app also connects with accl2, now the PASID-X is plummed in for RID
of accel2.


> 
> > > If you want to get a PASID that can be used with every RID on in your
> > > /dev/ioasid then ask for that exactly.
> > 
> > Correct, but how does guest through vIOMMU driver communicate that intent so uAPI
> > plumbing can do this? I mean architecturally via IOMMU interfaces? 
> 
> I would have to ask for a PASID that has the property it needs. You
> are saying the property is even bigger than "usable on a group of
> RIDs" but is actually "global for every RID and IOMMU in the system so
> it can go into a MSR". Gross, but fine, ask for that explicitly when
> allocating the PASID.

If one process has a single mm, is that also gross? :-) So a single process
having a PASID is just an identifier for IOMMU. It just seems like what a
mm is for a process == PASID for SVM-IOMMU support.

The unanswered question is how do we plumb from vIOMMU without a custom
allocator to get a system wide PASID? 

The way it works today is if we have a custom allocator registered, that's
the mechanics to get PASIDs allocated. for Intel vIOMMU it happens to be a
global unique allocation. If a particular vIOMMU doesn't require, it does
not have vIOMMU interface, and those naturally get a guest local PASID name
space. (Im not sure if that's how the allocator works today, but I guess its
extensible to accomplish a RID local PASID if that's exactly what is
required)

Cheers,
Ashok
