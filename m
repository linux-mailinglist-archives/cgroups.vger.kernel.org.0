Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DDA34DC18
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 00:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhC2WxG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 18:53:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:36209 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhC2Ww5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Mar 2021 18:52:57 -0400
IronPort-SDR: IqGIXe9PukViKnNX1STa9vDTfUHKr7D4+YXlH0mg5xRqCSRjig7xkoKVlSC0+1RrJL96AcNjwk
 XqHk6nS13zeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191671984"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="191671984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 15:52:56 -0700
IronPort-SDR: BbuVBvkJFfwvrB6unbwRQKYGhL6XPctz9D0tCu6eZh40ZhOgWyBcdI39fFDo7z1lXLu7R+xtfS
 GsUhsM5+sVDA==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417883683"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 15:52:56 -0700
Date:   Mon, 29 Mar 2021 15:55:26 -0700
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
Message-ID: <20210329155526.2ad791a9@jacob-builder>
In-Reply-To: <20210329163147.GG2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210318172234.3e8c34f7@jacob-builder>
        <YFR10eeDVf5ZHV5l@myrica>
        <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <20210322120300.GU2356281@nvidia.com>
        <20210324120528.24d82dbd@jacob-builder>
        <20210329163147.GG2356281@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Mon, 29 Mar 2021 13:31:47 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 24, 2021 at 12:05:28PM -0700, Jacob Pan wrote:
> 
> > > IMHO a use created PASID is either bound to a mm (current) at creation
> > > time, or it will never be bound to a mm and its page table is under
> > > user control via /dev/ioasid.
> > >   
> > True for PASID used in native SVA bind. But for binding with a guest mm,
> > PASID is allocated first (VT-d virtual cmd interface Spec 10.4.44), the
> > bind with the host IOMMU when vIOMMU PASID cache is invalidated.
> > 
> > Our intention is to have two separate interfaces:
> > 1. /dev/ioasid (allocation/free only)
> > 2. /dev/sva (handles all SVA related activities including page tables)  
> 
> I'm not sure I understand why you'd want to have two things. Doesn't
> that just complicate everything?
> 
> Manipulating the ioasid, including filling it with page tables, seems
> an integral inseperable part of the whole interface. Why have two ?
> 
In one of the earlier discussions, I was made aware of some use cases (by
AMD, iirc) where PASID can be used w/o IOMMU. That is why I tried to keep
ioasid a separate subsystem. Other than that, I don't see an issue
combining the two.

> > > I thought the whole point of something like a /dev/ioasid was to get
> > > away from each and every device creating its own PASID interface?
> > >   
> > yes, but only for the use cases that need to expose PASID to the
> > userspace.  
> 
> Why "but only"? This thing should reach for a higher generality, not
> just be contained to solve some problem within qemu.
> 
I totally agree in terms of generality. I was just trying to point out
existing framework or drivers such as uacce and idxd driver does not have a
need to use /dev/ioasid.

> > > It maybe somewhat reasonable that some devices could have some easy
> > > 'make a SVA PASID on current' interface built in,  
> > I agree, this is the case PASID is hidden from the userspace, right?
> > e.g. uacce.  
> 
> "hidden", I guess, but does it matter so much?
> 
it matters when it comes to which interface to choose. Use /dev/ioasid to
allocate if PASID value cannot be hidden. Use some other interface for bind
current and allocate if a PASID is not visible to the user.

> The PASID would still consume a cgroup credit
> 
yes, credit still consumed. Just the PASID value is hidden.

> > > but anything more
> > > complicated should use /dev/ioasid, and anything consuming PASID
> > > should also have an API to import and attach a PASID from /dev/ioasid.
> > >   
> > Would the above two use cases constitute the "complicated" criteria? Or
> > we should say anything that need the explicit PASID value has to through
> > /dev/ioasid?  
> 
> Anything that needs more that creating a hidden PASID link'd to
> current should use the full interface.
> 
Yes, I think we are on the same page. For example, today's uacce or idxd
driver creates a hidden PASID when user does open(), where a new WQ is
provisioned and bound to current mm. This is the case where /dev/ioasid is
not needed.

> > In terms of usage for guest SVA, an ioasid_set is mostly tied to a host
> > mm, the use case is as the following:  
> 
> From that doc:
> 
>   It is imperative to enforce
>   VM-IOASID ownership such that a malicious guest cannot target DMA
>   traffic outside its own IOASIDs, or free an active IOASID that belongs
>   to another VM.
> 
> Huh?
> 
Sorry, I am not following. In the doc, I have an example to show the
ioasid_set to VM/mm mapping. We use mm as the ioasid_set token to identify
who the owner of an IOASID is. i.e. who allocated the IOASID. Non-owner
cannot perform bind page table or free operations.

Section: IOASID Set Private ID (SPID)
 .------------------.    .------------------.
 |   VM 1           |    |   VM 2           |
 |                  |    |                  |
 |------------------|    |------------------|
 | GPASID/SPID 101  |    | GPASID/SPID 101  |
 '------------------'    -------------------'     Guest
 __________|______________________|____________________
           |                      |               Host
           v                      v
 .------------------.    .------------------.
 | Host IOASID 201  |    | Host IOASID 202  |
 '------------------'    '------------------'
 |   IOASID set 1   |    |   IOASID set 2   |
 '------------------'    '------------------'


> Security in a PASID world comes from the IOMMU blocking access to the
> PASID except from approved PCI-ID's. If a VF/PF is assigned to a guest
> then that guest can cause the device to issue any PASID by having
> complete control and the vIOMMU is supposed to tell the real IOMMU
> what PASID's the device is alowed to access.
> 
Yes, each PF/VF has its own PASID table. The device can do whatever
it wants as long as the PASID is present in the table. Programming of the
pIOMMU PASID table entry, however, is controlled by the host.

IMHO, there are two levels of security here:
1. A PASID can only be used by a secure context
2. A device can only use allowed PASIDs (PASID namespace is system-wide but
PASID table storage is per PF/VF)

IOASID set is designed for #1.

> If a device is sharing a single PCI function with different security
> contexts (eg vfio mdev) then the device itself is responsible to
> ensure that only the secure interface can program a PASID and a less
> secure context can never self-enroll. 
> 
If two mdevs from the same PF dev are assigned to two VMs, the PASID
table will be shared. IOASID set ensures one VM cannot program another VM's
PASIDs. I assume 'secure context' is per VM when it comes to host PASID.

> Here the mdev driver would have to consule with the vIOMMU to ensure
> the mdev device is allowed to access the PASID - is that what this
> set stuff is about? 
> 
No. the mdev driver consults with IOASID core When the guest programs a
guest PASID on to he mdev. VDCM driver does a lookup:
host_pasid = ioasid_find_by_spid(ioasid_set, guest_pasid);

If the guest_pasid does not exist in the ioasid_set, the mdev programming
fails; if the guest_pasid does exist but it maps to a wrong host PASID, the
damage is limited to the guest itself.

> If yes, it is backwards. The MDEV is the thing doing the security, the
> MDEV should have the list of allowed PASID's and a single PASID
> created under /dev/ioasid should be loaded into MDEV with some 'Ok you
> can use PASID xyz from FD abc' command.
> 
I guess that is not the case. For VT-d dedicated WQ, there is only one
PASID can be programmed onto the device. Programming the PASID with
/dev/sva FD abc command will be checked against its mm where /dev/ioasid is
used to do the allocation.

For a single shared WQ assigned to multiple VMs, there will be one mdev per
VM. Again, FD commands is limited to the PASIDs allocated for the VM.

For a single share WQ assigned to one VM, it can be bound to multiple guest
processes/PASIDs. Host IOMMU driver maintains a list of the PASIDs and
ensures that they are only programmed on to the per device PASID table.

> Because you absolutely don't want to have a generic 'set' that all the
> mdevs are sharing as that violates the basic security principle at the
> start - each and every device must have a unique list of what PASID's
> it can talk to.
> 
I agree, I don't think this is the case. The ioasid_set is some what
orthogonal to mdev collections.

> > 1. Identify a pool of PASIDs for permission checking (below to the same
> > VM), e.g. only allow SVA binding for PASIDs allocated from the same set.
> > 
> > 2. Allow different PASID-aware kernel subsystems to associate, e.g. KVM,
> > device drivers, and IOMMU driver. i.e. each KVM instance only cares
> > about the ioasid_set associated with the VM. Events notifications are
> > also within the ioasid_set to synchronize PASID states.
> > 
> > 3. Guest-Host PASID look up (each set has its own XArray to store the
> > mapping)
> > 
> > 4. Quota control (going away once we have cgroup)  
> 
> It sounds worrysome things have gone this way.
> 
Could you expand on that? Guaranteeing quota is very difficult. cgroup
limit model fits most scalar resources.

> I'd say you shoul have a single /dev/ioasid per VM and KVM should
> attach to that - it should get all the global events/etc that are not
> device specific.
> 
You mean a single /dev/ioasid FD per VM and KVM? I think that is what we
are doing in this set. A VM process can only open /dev/ioasid once, then
use the FD for allocation and pass the PASID for bind page table etc.

> permission checking *must* be done on a per-device level, either inside
> the mdev driver, or inside the IOMMU at a per-PCI device level.
> 
I think we are on the same page. For mdev, VDCM driver makes sure the guest
PASID programmed is allocated by the same VM that also performed the bind SVA.

For PF/VF which is not mediated, the permission is implied by the IOMMU
driver/HW since PASID table is per device.

> Not sure what guest-host PASID means, these have to be 1:1 for device
> assignment to work - why would use something else for mdev?
> 
We have G-H PASID translation. They don't have to be 1:1.
IOASID Set Private ID (SPID) is intended as a generic solution for guest PASID.
Could you review the secion Section: IOASID Set Private ID (SPID) in the
doc patch?

We also had some slides from last year. Slide 3s-6 mostly.
https://static.sched.com/hosted_files/kvmforum2020/9f/KVM_forum_2020_PASID_MGMT_Yi_Jacob_final.pdf

Really appreciated your time!


Jacob
