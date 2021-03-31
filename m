Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC37A350498
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 18:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhCaQcz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 12:32:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:24871 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233704AbhCaQc2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 12:32:28 -0400
IronPort-SDR: RX7G75MjkKSf/VTkAtBeAJwrYEtTer3L/R6V/BSlQ5vmyEMo9Gbv8oDss2PhevLJfndSQGTXGa
 t3eahOOLNAaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="189814883"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="189814883"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 09:32:26 -0700
IronPort-SDR: 31+z6/c3bvocPJ3oT4T1qeWF8bpLEAeQOcIl0Qt31xromt+MfdoVm03Q19Xzus7cihWvP9Z/Ov
 fa8Zn4+jAvsw==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="377339505"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 09:32:26 -0700
Date:   Wed, 31 Mar 2021 09:34:57 -0700
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
Message-ID: <20210331093457.753512d4@jacob-builder>
In-Reply-To: <20210331122805.GC1463678@nvidia.com>
References: <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <20210322120300.GU2356281@nvidia.com>
        <20210324120528.24d82dbd@jacob-builder>
        <20210329163147.GG2356281@nvidia.com>
        <20210329155526.2ad791a9@jacob-builder>
        <20210330134313.GP2356281@nvidia.com>
        <20210330171041.70f2d7d0@jacob-builder>
        <20210331122805.GC1463678@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Wed, 31 Mar 2021 09:28:05 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 30, 2021 at 05:10:41PM -0700, Jacob Pan wrote:
>  [...]  
>  [...]  
>  [...]  
> > This requires the mdev driver to obtain a list of allowed
> > PASIDs(possibly during PASID bind time) prior to do enforcement. IMHO,
> > the PASID enforcement points are:
> > 1. During WQ configuration (e.g.program MSI)
> > 2. During work submission
> > 
> > For VT-d shared workqueue, there is no way to enforce #2 in mdev driver
> > in that the PASID is obtained from PASID MSR from the CPU and submitted
> > w/o driver involvement.  
> 
> I assume that the PASID MSR is privileged and only qemu can program
> it? Otherwise this seems like a security problem.
> 
yes.

> If qemu controls it then the idxd userspace driver in qemu must ensure
> it is only ever programmed to an authorized PASID.
> 
it is ensured for #1.

> > The enforcement for #2 is in the KVM PASID translation table, which
> > is per VM.  
> 
> I don't understand why KVM gets involved in PASID??
> 
Here is an excerpt from the SIOV spec.
https://software.intel.com/content/www/us/en/develop/download/intel-scalable-io-virtualization-technical-specification.html

"3.3 PASID translation
To support PASID isolation for Shared Work Queues used by VMs, the CPU must
provide a way for the PASID to be communicated to the device in the DMWr
transaction. On Intel CPUs, the CPU provides a PASID translation table in
the vCPUs virtual machine control structures. During ENQCMD/ENQCMDS
instruction execution in a VM, the PASID translation table is used by the
CPU to replace the guest PASID in the work descriptor with a host PASID
before the descriptor is sent to the device.3.3 PASID translation"

> Doesn't work submission go either to the mdev driver or through the
> secure PASID of #1?
> 
No, once a PASID is bound with IOMMU, KVM, and the mdev, work submission is
all done in HW.
But I don't think this will change for either uAPI design.

> > For our current VFIO mdev model, bind guest page table does not involve
> > mdev driver. So this is a gap we must fill, i.e. include a callback from
> > mdev driver?  
> 
> No not a callback, tell the mdev driver with a VFIO IOCTL that it is
> authorized to use a specific PASID because the vIOMMU was told to
> allow it by the guest kernel. Simple and straightforward.
> 
Make sense.

> > > ioasid_set doesn't seem to help at all, certainly not as a concept
> > > tied to /dev/ioasid.
> > >   
> > Yes, we can take the security role off ioasid_set once we have per mdev
> > list. However, ioasid_set being a per VM/mm entity also bridge
> > communications among kernel subsystems that don't have direct call path.
> > e.g. KVM, VDCM and IOMMU.  
> 
> Everything should revolve around the /dev/ioasid FD. qemu should pass
> it to all places that need to know about PASID's in the VM.
> 
I guess we need to extend KVM interface to support PASIDs. Our original
intention was to avoid introducing new interfaces.

> We should try to avoid hidden behind the scenes kernel
> interconnections between subsystems.
> 
Can we? in case of exception. Since all these IOCTLs are coming from the
unreliable user space, we must deal all exceptions.

For example, when user closes /dev/ioasid FD before (or w/o) unbind IOCTL
for VFIO, KVM, kernel must do cleanup and coordinate among subsystems.
In this patchset, we have a per mm(ioasid_set) notifier to inform mdev, KVM
to clean up and drop its refcount. Do you have any suggestion on this?

> 
> > > So when you 'allow' a mdev to access a PASID you want to say:
> > >  Allow Guest PASID A, map it to host PASID B on this /dev/ioasid FD
> > >   
> 
> > Host and guest PASID value, as well as device info are available through
> > iommu_uapi_sva_bind_gpasid(), we just need to feed that info to mdev
> > driver.  
> 
> You need that IOCTL to exist on the *mdev driver*. It is a VFIO ioctl,
> not a iommu or ioasid or sva IOCTL.
>
OK. A separate IOCTL and separate step.

> > > That seems like a good helper library to provide for drivers to use,
> > > but it should be a construct entirely contained in the driver.  
> > why? would it be cleaner if it is in the common code?  
> 
> No, it is the "mid layer" problematic design.
> 
> Having the iommu layer store driver-specific data on behalf of a
> driver will just make a mess. Use the natural layering we have and
> store driver specific data in the driver structs.
> 
> Add a library to help build the datastructure if it necessary.
> 
Let me try to paraphrase, you are suggesting common helper code and data
format but still driver specific storage of the mapping, correct?

Will try this out, seems cleaner.

> Jason


Thanks,

Jacob
