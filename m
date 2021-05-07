Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B05376C4D
	for <lists+cgroups@lfdr.de>; Sat,  8 May 2021 00:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhEGWNz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 May 2021 18:13:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:15806 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhEGWNu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 7 May 2021 18:13:50 -0400
IronPort-SDR: aXdFi8hvsTiYYRo1CLYoyQUEZSKordx44yph5O8qV8LioB/hWXpBG00ulI7k7hYmK+MpsLySFS
 G1nQsBaFNttQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="179066241"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="179066241"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:12:48 -0700
IronPort-SDR: 7WNbQ0A1+3oGRBKbWEfzfOFJWCNFKRgaATZCvUAV4vlGVej4zXBduyRXqZ3lghhLF9/05JQlSR
 LNS1KAx8QGWQ==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="429156396"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:12:48 -0700
Date:   Fri, 7 May 2021 15:15:11 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507151511.612d1424@jacob-builder>
In-Reply-To: <20210507192810.GY1370958@nvidia.com>
References: <20210505102259.044cafdf@jacob-builder>
        <20210505180023.GJ1370958@nvidia.com>
        <20210505130446.3ee2fccd@jacob-builder>
        <YJOZhPGheTSlHtQc@myrica>
        <20210506122730.GQ1370958@nvidia.com>
        <20210506163240.GA9058@otc-nc-03>
        <20210507172051.GW1370958@nvidia.com>
        <20210507181458.GA73499@otc-nc-03>
        <20210507182050.GX1370958@nvidia.com>
        <20210507192325.GB73499@otc-nc-03>
        <20210507192810.GY1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Fri, 7 May 2021 16:28:10 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > The unanswered question is how do we plumb from vIOMMU without a custom
> > allocator to get a system wide PASID?   
> 
> PASID allocation is part of the iommu driver, it really shouldn't be
> global.
> 
In the current code, the pluggable custom allocator *is* part of the iommu
vendor driver. If it decides the allocation is global then it should be
suitable for the platform since there will never be a VT-d IOMMU on another
vendor's platform.

It is true that the default allocator is global which suites the current
needs. I am just wondering if we are solving a problem does not exist yet.

> When the architecture code goes to allocate a single PASID for the
> mm_struct it should flag that allocation request with a 'must work for
> all RIDs flag' and the iommu driver should take care of it. That might
> mean the iommu driver consults a global static xarray, or maybe it
> does a hypercall, but it should be done through that API, not a side
> care global singleton.
Why do we need to flag the allocation every time if on a platform *every*
PASID can potentially be global? At the time of allocation, we don't know
if the PASID will be used for a shared (ENQCMD) or a dedicated workqueue.

Thanks,

Jacob
