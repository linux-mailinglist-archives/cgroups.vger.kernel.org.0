Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895D037A776
	for <lists+cgroups@lfdr.de>; Tue, 11 May 2021 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhEKN1O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 09:27:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:60520 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhEKN1L (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 May 2021 09:27:11 -0400
IronPort-SDR: fH2GzfBjsK6YQJuhKcI39buBKPS/14uwvhDyeO3p8VC11owZzFlXRGTayi0rxVgA0fLpb5/ro1
 Jpdx8tWtUyJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263370538"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="263370538"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 06:26:04 -0700
IronPort-SDR: Ja5IgSNuhJWXorN0fMwyeZIDsLuWpaHj++dzLuyI5kMh9FIT+At9MSFJy6bzSXJLsQTZl7+EM/
 Rujt7J5XToOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="461916699"
Received: from yiliu-dev.bj.intel.com (HELO yiliu-dev) ([10.238.156.135])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2021 06:25:58 -0700
Date:   Tue, 11 May 2021 21:24:44 +0800
From:   Liu Yi L <yi.l.liu@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     yi.l.liu@intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Wu, Hao" <hao.wu@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210511212444.15b47c05@yiliu-dev>
In-Reply-To: <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210504180050.GB1370958@nvidia.com>
        <20210504151154.02908c63@jacob-builder>
        <20210504231530.GE1370958@nvidia.com>
        <20210505102259.044cafdf@jacob-builder>
        <20210505180023.GJ1370958@nvidia.com>
        <20210505130446.3ee2fccd@jacob-builder>
        <YJOZhPGheTSlHtQc@myrica>
        <20210506122730.GQ1370958@nvidia.com>
        <20210506163240.GA9058@otc-nc-03>
        <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210510123729.GA1002214@nvidia.com>
        <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: IAGS/SSE(OTC)
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 11 May 2021 09:10:03 +0000, Tian, Kevin wrote:

> > From: Jason Gunthorpe
> > Sent: Monday, May 10, 2021 8:37 PM
> >   
> [...] 
> > > gPASID!=hPASID has a problem when assigning a physical device which
> > > supports both shared work queue (ENQCMD with PASID in MSR)
> > > and dedicated work queue (PASID in device register) to a guest
> > > process which is associated to a gPASID. Say the host kernel has setup
> > > the hPASID entry with nested translation though /dev/ioasid. For
> > > shared work queue the CPU is configured to translate gPASID in MSR
> > > into **hPASID** before the payload goes out to the wire. However
> > > for dedicated work queue the device MMIO register is directly mapped
> > > to and programmed by the guest, thus containing a **gPASID** value
> > > implying DMA requests through this interface will hit IOMMU faults
> > > due to invalid gPASID entry. Having gPASID==hPASID is a simple
> > > workaround here. mdev doesn't have this problem because the
> > > PASID register is in emulated control-path thus can be translated
> > > to hPASID manually by mdev driver.  
> > 
> > This all must be explicit too.
> > 
> > If a PASID is allocated and it is going to be used with ENQCMD then
> > everything needs to know it is actually quite different than a PASID
> > that was allocated to be used with a normal SRIOV device, for
> > instance.
> > 
> > The former case can accept that the guest PASID is virtualized, while
> > the lattter can not.
> > 
> > This is also why PASID per RID has to be an option. When I assign a
> > full SRIOV function to the guest then that entire RID space needs to
> > also be assigned to the guest. Upon migration I need to take all the
> > physical PASIDs and rebuild them in another hypervisor exactly as is.
> > 
> > If you force all RIDs into a global PASID pool then normal SRIOV
> > migration w/PASID becomes impossible. ie ENQCMD breaks everything else
> > that should work.
> > 
> > This is why you need to sort all this out and why it feels like some
> > of the specs here have been mis-designed.
> > 
> > I'm not sure carving out ranges is really workable for migration.
> > 
> > I think the real answer is to carve out entire RIDs as being in the
> > global pool or not. Then the ENQCMD HW can be bundled together and
> > everything else can live in the natural PASID per RID world.
> >   
> 
> OK. Here is the revised scheme by making it explicitly.
> 
> There are three scenarios to be considered:
> 
> 1) SR-IOV (AMD/ARM):
> 	- "PASID per RID" with guest-allocated PASIDs;
> 	- PASID table managed by guest (in GPA space);
> 	- the entire PASID space delegated to guest;
> 	- no need to explicitly register guest-allocated PASIDs to host;
> 	- uAPI for attaching PASID table:
> 
>     // set to "PASID per RID"
>     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_LOCAL);
> 
>     // When Qemu captures a new PASID table through vIOMMU;
>     pasidtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
>     ioctl(device_fd, VFIO_ATTACH_IOASID, pasidtbl_ioasid);
> 
>     // Set the PASID table to the RID associated with pasidtbl_ioasid;
>     ioctl(ioasid_fd, IOASID_SET_PASID_TABLE, pasidtbl_ioasid, gpa_addr);
> 
> 2) SR-IOV, no ENQCMD (Intel):
> 	- "PASID per RID" with guest-allocated PASIDs;
> 	- PASID table managed by host (in HPA space);
> 	- the entire PASID space delegated to guest too;
> 	- host must be explicitly notified for guest-allocated PASIDs;
> 	- uAPI for binding user-allocated PASIDs:
> 
>     // set to "PASID per RID"
>     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_LOCAL);
> 
>     // When Qemu captures a new PASID allocated through vIOMMU;

Is this achieved by VCMD or by capturing guest's PASID cache invalidation?

>     pgtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
>     ioctl(device_fd, VFIO_ATTACH_IOASID, pgtbl_ioasid);
> 
>     // Tell the kernel to associate pasid to pgtbl_ioasid in internal structure;
>     // &pasid being a pointer due to a requirement in scenario-3
>     ioctl(ioasid_fd, IOASID_SET_HWID, pgtbl_ioasid, &pasid);
> 
>     // Set guest page table to the RID+pasid associated to pgtbl_ioasid
>     ioctl(ioasid_fd, IOASID_BIND_PGTABLE, pgtbl_ioasid, gpa_addr);
> 
> 3) SRIOV, ENQCMD (Intel):
> 	- "PASID global" with host-allocated PASIDs;
> 	- PASID table managed by host (in HPA space);
> 	- all RIDs bound to this ioasid_fd use the global pool;
> 	- however, exposing global PASID into guest breaks migration;
> 	- hybrid scheme: split local PASID range and global PASID range;
> 	- force guest to use only local PASID range (through vIOMMU);
> 	- for ENQCMD, configure CPU to translate local->global;
> 	- for non-ENQCMD, setup both local/global pasid entries;
> 	- uAPI for range split and CPU pasid mapping:
> 
>     // set to "PASID global"
>     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_GLOBAL);
> 
>     // split local/global range, applying to all RIDs in this fd
>     // Example: local [0, 1024), global [1024, max)
>     // local PASID range is managed by guest and migrated as VM state
>     // global PASIDs are re-allocated and mapped to local PASIDs post migration
>     ioctl(ioasid_fd, IOASID_HWID_SET_GLOBAL_MIN, 1024);
> 
>     // When Qemu captures a new local_pasid allocated through vIOMMU;
>     pgtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
>     ioctl(device_fd, VFIO_ATTACH_IOASID, pgtbl_ioasid);
> 
>     // Tell the kernel to associate local_pasid to pgtbl_ioasid in internal structure;
>     // Due to HWID_GLOBAL, the kernel also allocates a global_pasid from the
>     // global pool. From now on, every hwid related operations must be applied
>     // to both PASIDs for this page table;
>     // global_pasid is returned to userspace in the same field as local_pasid;
>     ioctl(ioasid_fd, IOASID_SET_HWID, pgtbl_ioasid, &local_pasid);
> 
>     // Qemu then registers local_pasid/global_pasid pair to KVM for setting up
>     // CPU PASID translation table;
>     ioctl(kvm_fd, KVM_SET_PASID_MAPPING, local_pasid, global_pasid);
> 
>     // Set guest page table to the RID+{local_pasid, global_pasid} associated 
>     // to pgtbl_ioasid;
>     ioctl(ioasid_fd, IOASID_BIND_PGTABLE, pgtbl_ioasid, gpa_addr);
> 
> -----
> Notes:
> 
> I tried to keep common commands in generic format for all scenarios, while
> introducing new commands for usage-specific requirement. Everything is
> made explicit now. 
> 
> The userspace has sufficient information to choose its desired scheme based 
> on vIOMMU types and platform information (e.g. whether ENQCMD is exposed 
> in virtual CPUID, whether assigned devices support DMWr, etc.). 
> 
> Above example assumes one RID per bound page table, because vIOMMU
> identifies new guest page tables per-RID. If there are other usages requiring
> multiple RIDs per page table, SET_HWID/BIND_PGTABLE could accept
> another device_handle parameter to specify which RID is targeted for this
> operation.
> 
> When considering SIOV/mdev there is no change to above uAPI sequence. 
> It's n/a for 1) as SIOV requires PASID table in HPA space, nor does it
> cause any change to 3) regarding to the split range scheme. The only
>  conceptual change is in 2), where although it's still "PASID per RID" the 
> PASIDs must be managed by host because the parent driver also allocates 
> PASIDs from per-RID space to mark mdev (RID+PASID). But this difference 
> doesn't change the uAPI flow - just treat user-provisioned PASID as 'virtual' 
> and then allocate a 'real' PASID at IOASID_SET_HWID. Later always use the 
> real one when programming PASID entry (IOASID_BIND_PGTABLE) or device 
> PASID register (converted in the mediation path).
> 
> If all above can work reasonably, we even don't need the special VCMD 
> interface in VT-d for guest to allocate PASIDs from host. Just always let
> the guest to manage its PASIDs (with restriction of available local PASIDs),
> being a global allocator or per-RID allocator. the vIOMMU side just stick
> to the per-RID emulation according to the spec. 

yeah, if this scheme for scenario 3) is good. We may limit the range of
local PASIDs by limiting the PASID bit width of vIOMMU. QEMU can get the
local PASID allocated by guest IOMMU when guest does PASID cache invalidation.

-- 
Regards,
Yi Liu
