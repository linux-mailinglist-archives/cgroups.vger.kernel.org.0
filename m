Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC6372DEA
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhEDQVC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 12:21:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:31417 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhEDQVC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 May 2021 12:21:02 -0400
IronPort-SDR: gPzaO0HU4yaVX9ij0LSMDnOJQg0MEz/adti3TjuK2q8HxFEQ+9xT89vaWYROCxRLhkjTJ8Gwe6
 wLVpBiG7wz3g==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="261967950"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="261967950"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 09:20:06 -0700
IronPort-SDR: FE31X0f0O1HmtVya2wHzkb2m+mH92c3O29UDYShex4/bS8cRaxxOvxXCVAHn64M0HmX4ZXzTcL
 vnP6nVihO/fg==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="468576361"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 09:20:06 -0700
Date:   Tue, 4 May 2021 09:22:55 -0700
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
Message-ID: <20210504092255.76c387f8@jacob-builder>
In-Reply-To: <20210428204606.GX1370958@nvidia.com>
References: <20210421175203.GN1370958@nvidia.com>
        <20210421133312.15307c44@redhat.com>
        <20210421230301.GP1370958@nvidia.com>
        <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210422121020.GT1370958@nvidia.com>
        <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210423114944.GF1370958@nvidia.com>
        <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210426123817.GQ1370958@nvidia.com>
        <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210428204606.GX1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Wed, 28 Apr 2021 17:46:06 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > I think the name IOASID is fine for the uAPI, the kernel version can
> > > be called ioasid_id or something.  
> > 
> > ioasid is already an id and then ioasid_id just adds confusion. Another
> > point is that ioasid is currently used to represent both PCI PASID and
> > ARM substream ID in the kernel. It implies that if we want to separate
> > ioasid and pasid in the uAPI the 'pasid' also needs to be replaced with
> > another general term usable for substream ID. Are we making the
> > terms too confusing here?  
> 
> This is why I also am not so sure about exposing the PASID in the API
> because it is ultimately a HW specific item.
> 
> As I said to David, one avenue is to have some generic uAPI that is
> very general and keep all this deeply detailed stuff, that really only
> matters for qemu, as part of a more HW specific vIOMMU driver
> interface.
I think it is not just for QEMU. I am assuming you meant PASID is
needed for guest driver to program assigned but not mediated devices.

User space drivers may also need to get the real HW PASID to program it on
to the HW. So this uAPI need to provide some lookup functionality. Perhaps
the kernel generic version can be called ioasid_hw_id?

So we have the following per my understanding:
- IOASID: a userspace logical number which identifies a page table, this can
be a first level (GVA-GPA), or a second level (GPA->HPA) page table.
- PASID: strictly defined in PCIe term
- Substream ID: strictly defined in ARM SMMUv3 spec.
- IOASID_HW_ID: a generic ID backed by PASID, Substream ID, or any other
		 HW IDs used to tag DMA

Is that right?

Thanks,

Jacob
