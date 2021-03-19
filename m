Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE6A34116B
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 01:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhCSAUR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 20:20:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:25096 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhCSAUL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Mar 2021 20:20:11 -0400
IronPort-SDR: fOwYUAiQBwpd/DcfK0gWJ/Ua0a7bVQHLX5pHte1DaLaNPe2N/lHt6RXG+h0xMC2iqjJ8mV3On7
 vFjX3C6yIoyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="251148952"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="251148952"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 17:20:10 -0700
IronPort-SDR: vm0vhQeTnExLKln4ENqx3VU3gCMCBEb+VB9rFh8sV4Mo/w2VhojiBHVFosZE2BZUKHctyGKo/S
 rjkWZc8chQHw==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="413299077"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 17:20:10 -0700
Date:   Thu, 18 Mar 2021 17:22:34 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210318172234.3e8c34f7@jacob-builder>
In-Reply-To: <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jean,

Slightly off the title. As we are moving to use cgroup to limit PASID
allocations, it would be much simpler if we enforce on the current task.

However, iommu_sva_alloc_pasid() takes an mm_struct pointer as argument
which implies it can be something other the the current task mm. So far all
kernel callers use current task mm. Is there a use case for doing PASID
allocation on behalf of another mm? If not, can we remove the mm argument?

Thanks,

Jacob

>  /**
>   * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> @@ -35,11 +44,11 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
> ioasid_t min, ioasid_t max) mutex_lock(&iommu_sva_lock);
>  	if (mm->pasid) {
>  		if (mm->pasid >= min && mm->pasid <= max)
> -			ioasid_get(mm->pasid);
> +			ioasid_get(iommu_sva_pasid, mm->pasid);
>  		else
>  			ret = -EOVERFLOW;
>  	} else {
> -		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> +		pasid = ioasid_alloc(iommu_sva_pasid, min, max, mm);
>  		if (pasid == INVALID_IOASID)
>  			ret = -ENOMEM;

Thanks,

Jacob
