Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8934F54B
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 02:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhCaAI3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Mar 2021 20:08:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:34747 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232401AbhCaAIL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Mar 2021 20:08:11 -0400
IronPort-SDR: TvWKEDXpG38ibe2lWWB2Y7LGeAiJPdXO+iZTyIu7pYWRgFPgRivhzuHOAsMd170ZsQZQXxKzsi
 ypAMSbIKXs9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="171906789"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="171906789"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 17:08:11 -0700
IronPort-SDR: HUurJyYDUTND8ozX4erY0t4tlGlrQCC5ScJGMIGUlQMd5+m5YuCEtkemwmeM+oxQ3k2dIQN7sZ
 ngtIj+/noGFA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="377035543"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 17:08:10 -0700
Date:   Tue, 30 Mar 2021 17:10:41 -0700
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
Message-ID: <20210330171041.70f2d7d0@jacob-builder>
In-Reply-To: <20210330134313.GP2356281@nvidia.com>
References: <20210318172234.3e8c34f7@jacob-builder>
        <YFR10eeDVf5ZHV5l@myrica>
        <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <20210322120300.GU2356281@nvidia.com>
        <20210324120528.24d82dbd@jacob-builder>
        <20210329163147.GG2356281@nvidia.com>
        <20210329155526.2ad791a9@jacob-builder>
        <20210330134313.GP2356281@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Tue, 30 Mar 2021 10:43:13 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > If two mdevs from the same PF dev are assigned to two VMs, the PASID
> > table will be shared. IOASID set ensures one VM cannot program another
> > VM's PASIDs. I assume 'secure context' is per VM when it comes to host
> > PASID.  
> 
> No, the mdev device driver must enforce this directly. It is the one
> that programms the physical shared HW, it is the one that needs a list
> of PASID's it is allowed to program *for each mdev*
> 
This requires the mdev driver to obtain a list of allowed PASIDs(possibly
during PASID bind time) prior to do enforcement. IMHO, the PASID enforcement
points are:
1. During WQ configuration (e.g.program MSI)
2. During work submission

For VT-d shared workqueue, there is no way to enforce #2 in mdev driver in
that the PASID is obtained from PASID MSR from the CPU and submitted w/o
driver involvement. The enforcement for #2 is in the KVM PASID translation
table, which is per VM.

For our current VFIO mdev model, bind guest page table does not involve
mdev driver. So this is a gap we must fill, i.e. include a callback from
mdev driver?

> ioasid_set doesn't seem to help at all, certainly not as a concept
> tied to /dev/ioasid.
> 
Yes, we can take the security role off ioasid_set once we have per mdev
list. However, ioasid_set being a per VM/mm entity also bridge
communications among kernel subsystems that don't have direct call path.
e.g. KVM, VDCM and IOMMU.

> > No. the mdev driver consults with IOASID core When the guest programs a
> > guest PASID on to he mdev. VDCM driver does a lookup:
> > host_pasid = ioasid_find_by_spid(ioasid_set, guest_pasid);  
> 
> This is the wrong layering. Tell the mdev device directly what it is
> allowed to do. Do not pollute the ioasid core with security stuff.
> 
> > > I'd say you shoul have a single /dev/ioasid per VM and KVM should
> > > attach to that - it should get all the global events/etc that are not
> > > device specific.
> > >   
> > You mean a single /dev/ioasid FD per VM and KVM? I think that is what we
> > are doing in this set. A VM process can only open /dev/ioasid once, then
> > use the FD for allocation and pass the PASID for bind page table etc.  
> 
> Yes, I think that is reasonable.
> 
> Tag all the IOCTL's with the IOASID number.
>  
> > > Not sure what guest-host PASID means, these have to be 1:1 for device
> > > assignment to work - why would use something else for mdev?
> > >   
> > We have G-H PASID translation. They don't have to be 1:1.
> > IOASID Set Private ID (SPID) is intended as a generic solution for
> > guest PASID. Could you review the secion Section: IOASID Set Private ID
> > (SPID) in the doc patch?  
> 
> Again this only works for MDEV? How would you do translation for a
> real PF/VF?
> 
Right, we will need some mediation for PF/VF.

> So when you 'allow' a mdev to access a PASID you want to say:
>  Allow Guest PASID A, map it to host PASID B on this /dev/ioasid FD
> 
> ?
> 
Host and guest PASID value, as well as device info are available through
iommu_uapi_sva_bind_gpasid(), we just need to feed that info to mdev driver.

> That seems like a good helper library to provide for drivers to use,
> but it should be a construct entirely contained in the driver.
why? would it be cleaner if it is in the common code?

Thanks,

Jacob
