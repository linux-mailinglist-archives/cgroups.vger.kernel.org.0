Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82DE350621
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 20:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhCaSS3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 14:18:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:12547 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233888AbhCaSSA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 14:18:00 -0400
IronPort-SDR: k9nTK5xipLABC/HWlKiPmU+hQ+oEwTwUmcAO+cqQolLfinYEycyN8p2izmmOOP1RnCKDs51KP3
 kRXo/nPsqL9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179194251"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="179194251"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 11:17:59 -0700
IronPort-SDR: fOu2Q4kpYz95Wg8WRpseF+M0RoDDUeiB7sxcuwl5noXe/9+0xQhstvY2lKI0cJRNqcr9UwNITL
 6cFVDEeuSD/w==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="394143752"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 11:17:59 -0700
Date:   Wed, 31 Mar 2021 11:20:30 -0700
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
Message-ID: <20210331112030.174e77b0@jacob-builder>
In-Reply-To: <20210331173148.GN1463678@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <20210322120300.GU2356281@nvidia.com>
        <20210324120528.24d82dbd@jacob-builder>
        <20210329163147.GG2356281@nvidia.com>
        <20210329155526.2ad791a9@jacob-builder>
        <20210330134313.GP2356281@nvidia.com>
        <20210330171041.70f2d7d0@jacob-builder>
        <20210331122805.GC1463678@nvidia.com>
        <20210331093457.753512d4@jacob-builder>
        <20210331173148.GN1463678@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Wed, 31 Mar 2021 14:31:48 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > We should try to avoid hidden behind the scenes kernel
> > > interconnections between subsystems.
> > >   
> > Can we? in case of exception. Since all these IOCTLs are coming from the
> > unreliable user space, we must deal all exceptions.
> >
> > For example, when user closes /dev/ioasid FD before (or w/o) unbind
> > IOCTL for VFIO, KVM, kernel must do cleanup and coordinate among
> > subsystems. In this patchset, we have a per mm(ioasid_set) notifier to
> > inform mdev, KVM to clean up and drop its refcount. Do you have any
> > suggestion on this?  
> 
> The ioasid should be a reference counted object.
> 
yes, this is done in this patchset.

> When the FD is closed, or the ioasid is "destroyed" it just blocks DMA
> and parks the PASID until *all* places release it. Upon a zero
> refcount the PASID is recycled for future use.
> 
Just to clarify, you are saying (when FREE happens before proper
teardown) there is no need to proactively notify all users of the IOASID to
drop their reference. Instead, just wait for the other parties to naturally
close and drop their references. Am I understanding you correctly?

I feel having the notifications can add two values:
1. Shorten the duration of errors (as you mentioned below), FD close can
take a long and unpredictable time. e.g. FD shared.
2. Provide teardown ordering among PASID users. i.e. vCPU, IOMMU, mdev.

> The duration between unmapping the ioasid and releasing all HW access
> will have HW see PCIE TLP errors due to the blocked access. If
> userspace messes up the order it is fine to cause this. We already had
> this dicussion when talking about how to deal with process exit in the
> simple SVA case.
Yes, we have disabled fault reporting during this period. The slight
differences vs. the simple SVA case is that KVM is also involved and there
might be an ordering requirement to stop vCPU first.

Thanks,

Jacob
