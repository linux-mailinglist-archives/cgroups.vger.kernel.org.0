Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B294532D9E3
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 20:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhCDTBj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 14:01:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:35399 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235421AbhCDTBQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Mar 2021 14:01:16 -0500
IronPort-SDR: Bod1G5DPcWjXYx1FQgC2eq8sOngymESich0b8XLTra7T9XCpoA4EeM2441LrIUdQR27Cd5woCZ
 uCtIxPvkecEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="187534615"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="187534615"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 10:59:30 -0800
IronPort-SDR: NbqFzMbMSGkhCygtH0In0Xtszb1NnhzOwThNk0wCxsqlTYeCynz4T+5CvB+YvlRK43kFtk5qJf
 wDisfAEJFTig==
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="445844611"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 10:59:28 -0800
Date:   Thu, 4 Mar 2021 11:01:44 -0800
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
Message-ID: <20210304110144.39ef0941@jacob-builder>
In-Reply-To: <20210304175402.GG4247@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
        <YD+u3CXhwOi2LC+4@slm.duckdns.org>
        <20210303131726.7a8cb169@jacob-builder>
        <20210303160205.151d114e@jacob-builder>
        <YECtMZNqSgh7jkGP@myrica>
        <20210304094603.4ab6c1c4@jacob-builder>
        <20210304175402.GG4247@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Thu, 4 Mar 2021 13:54:02 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 04, 2021 at 09:46:03AM -0800, Jacob Pan wrote:
> 
> > Right, I was assuming have three use cases of IOASIDs:
> > 1. host supervisor SVA (not a concern, just one init_mm to bind)
> > 2. host user SVA, either one IOASID per process or perhaps some private
> > IOASID for private address space
> > 3. VM use for guest SVA, each IOASID is bound to a guest process
> > 
> > My current cgroup proposal applies to #3 with IOASID_SET_TYPE_MM, which
> > is allocated by the new /dev/ioasid interface.
> > 
> > For #2, I was thinking you can limit the host process via PIDs cgroup?
> > i.e. limit fork. So the host IOASIDs are currently allocated from the
> > system pool with quota of chosen by iommu_sva_init() in my patch, 0
> > means unlimited use whatever is available.
> > https://lkml.org/lkml/2021/2/28/18  
> 
> Why do we need two pools?
> 
> If PASID's are limited then why does it matter how the PASID was
> allocated? Either the thing requesting it is below the limit, or it
> isn't.
> 
you are right. it should be tracked based on the process regardless it is
allocated by the user (/dev/ioasid) or indirectly by kernel drivers during
iommu_sva_bind_device(). Need to consolidate both 2 and 3 and
decouple cgroup and IOASID set.

> For something like qemu I'd expect to put the qemu process in a cgroup
> with 1 PASID. Who cares what qemu uses the PASID for, or how it was
> allocated?
> 
For vSVA, we will need one PASID per guest process. But that is up to the
admin based on whether or how many SVA capable devices are directly
assigned.

> Jason


Thanks,

Jacob
