Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05083792A9
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhEJP2G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 11:28:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:26962 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237874AbhEJP0J (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 May 2021 11:26:09 -0400
IronPort-SDR: 3eHyPsmBMqXsOcGxu67xAJm9gg6RqgwDfK8a2yi+BJX3RNJVIe9sUMnGXNQFaz5vi+M6COLUOr
 or4JepUYMaqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="197234725"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="197234725"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 08:25:05 -0700
IronPort-SDR: GjXRpWxI0GTq9EfqsAr0hz2jjpbs5onS2DLUgUp5jeCZ4ykKcxn/jUUXM/nI3Zw1v9kib0m8MB
 voaWFDGgutcg==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="536454725"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 08:25:03 -0700
Date:   Mon, 10 May 2021 08:25:02 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
Message-ID: <20210510152502.GA90095@otc-nc-03>
References: <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
 <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510123729.GA1002214@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 10, 2021 at 09:37:29AM -0300, Jason Gunthorpe wrote:
> On Sat, May 08, 2021 at 09:56:59AM +0000, Tian, Kevin wrote:
> > > From: Raj, Ashok <ashok.raj@intel.com>
> > > Sent: Friday, May 7, 2021 12:33 AM
> > > 
> > > > Basically it means when the guest's top level IOASID is created for
> > > > nesting that IOASID claims all PASID's on the RID and excludes any
> > > > PASID IOASIDs from existing on the RID now or in future.
> > > 
> > > The way to look at it this is as follows:
> > > 
> > > For platforms that do not have a need to support shared work queue model
> > > support for ENQCMD or similar, PASID space is naturally per RID. There is no
> > > complication with this. Every RID has the full range of PASID's and no need
> > > for host to track which PASIDs are allocated now or in future in the guest.
> > > 
> > > For platforms that support ENQCMD, it is required to mandate PASIDs are
> > > global across the entire system. Maybe its better to call them gPASID for
> > > guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> > > wide mapping for ENQCMD and not a per-RID based mapping. (We covered
> > > that
> > > in earlier responses)
> > > 
> > > In our current implementation we actually don't separate this space, and
> > > gPASID == hPASID. The iommu driver enforces that by using the custom
> > > allocator and the architected interface that allows all guest vIOMMU
> > > allocations to be proxied to host. Nothing but a glorified hypercall like
> > > interface. In fact some OS's do use hypercall to get a hPASID vs using
> > > the vCMD style interface.
> > > 
> > 
> > After more thinking about the new interface, I feel gPASID==hPASID 
> > actually causes some confusion in uAPI design. In concept an ioasid
> > is not active until it's attached to a device, because it's just an ID
> > if w/o a device. So supposedly an ioasid should reject all user commands
> > before attach. However an guest likely asks for a new gPASID before
> > attaching it to devices and vIOMMU. if gPASID==hPASID then Qemu 
> > must request /dev/ioasid to allocate a hw_id for an ioasid which hasn't 
> > been attached to any device, with the assumption on kernel knowledge 
> > that this hw_id is from an global allocator w/o dependency on any 
> > device. This doesn't sound a clean design, not to say it also conflicts 
> > with live migration.
> 
> Everything must be explicit. The situation David pointed to of
> qemu emulating a vIOMMU while running on a host with a different
> platform/physical IOMMU must be considered.
> 
> If the vIOMMU needs specific behavior it must use /dev/iommu to ask
> for it specifically and not just make wild assumptions about how the
> platform works.

I think the right way is for pIOMMU to enforce the right behavior. vIOMMU
can ask for a PASID and physical IOMMU driver would give what is optimal
for the platform. if vIOMMU says give me per-device PASID, but that can
lead to conflicts in PASID name space, its best to avoid it. 

Global PASID doesn't break anything, but giving that control to vIOMMU
doesn't seem right. When we have mixed uses cases like hardware that
supports shared wq and SRIOV devices that need PASIDs we need to 
comprehend how they will work without having a backend to migrate PASIDs 
to new destination.

for ENQCMD we have the gPASID->hPASID translation in the VMCS control.
For devices that support SIOV, programming a PASID to  a device is also
mediated, so its possible for something like the mediated interface to
assist with that migration for the dedicated WQ.


When we have both SRIOV and shared WQ exposed to the same guest, we 
do have an issue. The simplest way that I thought was to have a guest 
and host PASID separation.  Where the guest has its own PASID  space 
and host has its own carved out.  Guest can do what ever it wants within 
that allocated space without fear of any collition with any other device. 

Cheers,
Ashok
