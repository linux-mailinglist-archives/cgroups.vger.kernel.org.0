Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0C3746D2
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhEER2p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 13:28:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:11464 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240400AbhEERVG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 13:21:06 -0400
IronPort-SDR: +PORprcYD82VJlTpzh/fXyV3ZtJtOGefelmej7b2cCyOWrsuqqUgZr4gcluHhj1rtIyghA3Ac5
 mY6PImk7hKgA==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="196230268"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="196230268"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 10:20:09 -0700
IronPort-SDR: iY7VJJJQFkvN2izb7iyCSnux/+J5KjzfQzVOdrkOuIj75vXIEDSM2Pj2eu6Skcs8Y/rUFmt4UD
 Miwr4xTTFJpw==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="433926176"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 10:20:09 -0700
Date:   Wed, 5 May 2021 10:22:59 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
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
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210505102259.044cafdf@jacob-builder>
In-Reply-To: <20210504231530.GE1370958@nvidia.com>
References: <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210422121020.GT1370958@nvidia.com>
        <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210423114944.GF1370958@nvidia.com>
        <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210426123817.GQ1370958@nvidia.com>
        <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210504084148.4f61d0b5@jacob-builder>
        <20210504180050.GB1370958@nvidia.com>
        <20210504151154.02908c63@jacob-builder>
        <20210504231530.GE1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Tue, 4 May 2021 20:15:30 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 04, 2021 at 03:11:54PM -0700, Jacob Pan wrote:
> 
> > > It is a weird way to use xarray to have a structure which
> > > itself is just a wrapper around another RCU protected structure.
> > > 
> > > Make the caller supply the ioasid_data memory, embedded in its own
> > > element, get rid of the void * and rely on XA_ZERO_ENTRY to hold
> > > allocated but not active entries.
> > >   
> > Let me try to paraphrase to make sure I understand. Currently
> > struct ioasid_data is private to the iasid core, its memory is
> > allocated by the ioasid core.
> > 
> > You are suggesting the following:
> > 1. make struct ioasid_data public
> > 2. caller allocates memory for ioasid_data, initialize it then pass it
> > to ioasid_alloc to store in the xarray
> > 3. caller will be responsible for setting private data inside
> > ioasid_data and do call_rcu after update if needed.  
> 
> Basically, but you probably won't need a "private data" once the
> caller has this struct as it can just embed it in whatever larger
> struct makes sense for it and use container_of/etc
> 
that makes sense. thanks!

> I didn't look too closely at the whole thing though. Honestly I'm a
> bit puzzled why we need a pluggable global allocator framework.. The
> whole framework went to some trouble to isolate everything into iommu
> drivers then that whole design is disturbed by this global thing.
> 
Global and pluggable are for slightly separate reasons.
- We need global PASID on VT-d in that we need to support shared
workqueues (SWQ). E.g. One SWQ can be wrapped into two mdevs then assigned
to two VMs. Each VM uses its private guest PASID to submit work but
each guest PASID must be translated to a global (system-wide) host PASID to
avoid conflict. Also, since PASID table storage is per PF, if two mdevs of
the same PF are assigned to different VMs, the PASIDs must be unique.

- The pluggable allocator is to support the option where the guest PASIDs
are allocated by the hypervisor. Let it be the same as the host PASID or
some arbitrary number cooked up by the hypervisor but backed by a host HW
PASID. VT-d spec has this virtual command interface that requires the guest
to use it instead of allocating from the guest ioasid xarray. This is the
reason why it has to go down to iommu vendor driver. I guess that is what
you meant by "went to some trouble to isolate everything into iommu"?

For ARM, since the guest owns the per device PASID table. There is no need
to allocate PASIDs from the host nor the hypervisor. Without SWQ, there is
no need for global PASID/SSID either. So PASID being global for ARM is for
simplicity in case of host PASID/SSID.



> Jason


Thanks,

Jacob
