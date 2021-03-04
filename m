Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01C732DBBD
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 22:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhCDV1m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 16:27:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:46354 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237839AbhCDV1k (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Mar 2021 16:27:40 -0500
IronPort-SDR: ay2YA9k2DmLcJTf5v8ZyRlwRmAVn8f+u0uD6c0gEJHOVbXvgXksVF2votuNLeWRRmPL+mbiu20
 i8fB+ayvg3jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="187565543"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="187565543"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 13:25:53 -0800
IronPort-SDR: MQ7Ih7H0p2xK1hWg7n4AeoanVjOPZRwTjBXJnjrogCBsf4jtzESf6/D/mAX8KKNBeg8DF+etxU
 JJCkaD1zIg3A==
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="384637280"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 13:25:53 -0800
Date:   Thu, 4 Mar 2021 13:28:09 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <iommu@lists.linux-foundation.org>, <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210304132809.75b3fa55@jacob-builder>
In-Reply-To: <20210304190253.GL4247@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
        <YD+u3CXhwOi2LC+4@slm.duckdns.org>
        <20210303131726.7a8cb169@jacob-builder>
        <20210303160205.151d114e@jacob-builder>
        <YECtMZNqSgh7jkGP@myrica>
        <20210304094603.4ab6c1c4@jacob-builder>
        <20210304175402.GG4247@nvidia.com>
        <20210304110144.39ef0941@jacob-builder>
        <20210304190253.GL4247@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Thu, 4 Mar 2021 15:02:53 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 04, 2021 at 11:01:44AM -0800, Jacob Pan wrote:
> 
> > > For something like qemu I'd expect to put the qemu process in a cgroup
> > > with 1 PASID. Who cares what qemu uses the PASID for, or how it was
> > > allocated?  
> > 
> > For vSVA, we will need one PASID per guest process. But that is up to
> > the admin based on whether or how many SVA capable devices are directly
> > assigned.  
> 
> I hope the virtual IOMMU driver can communicate the PASID limit and
> the cgroup machinery in the guest can know what the actual limit is.
> 
For VT-d, emulated vIOMMU can communicate with the guest IOMMU driver on how
many PASID bits are supported (extended cap reg PASID size fields). But it
cannot communicate how many PASIDs are in the pool(host cgroup capacity).

The QEMU process may not be the only one in a cgroup so it cannot give hard
guarantees. I don't see a good way to communicate accurately at runtime as
the process migrates or limit changes.

We were thinking to adopt the "Limits" model as defined in the cgroup-v2
doc.
"
Limits
------

A child can only consume upto the configured amount of the resource.
Limits can be over-committed - the sum of the limits of children can
exceed the amount of resource available to the parent.
"

So the guest cgroup would still think it has full 20 bits of PASID at its
disposal. But PASID allocation may fail before reaching the full 20 bits
(2M).
Similar on the host side, we only enforce the limit set by the cgroup but
not guarantee it.

> I was thinking of a case where qemu is using a single PASID to setup
> the guest kVA or similar
> 
got it.

> Jason


Thanks,

Jacob
