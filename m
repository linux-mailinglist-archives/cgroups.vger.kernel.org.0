Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACED534247E
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 19:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSSUL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 19 Mar 2021 14:20:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:43853 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhCSST5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 19 Mar 2021 14:19:57 -0400
IronPort-SDR: AfRTTIfnm3k8DZ2eVFVpbrXZQKaT1IyHxOdyI5aNGfzhVeu62FDDHSkUcmtqpIPEyDu4I6bQ0G
 8FC/4JGiWt0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="275015314"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="275015314"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:19:57 -0700
IronPort-SDR: DaGp9VUiyAWOZGeJ59SlsgzZCYqJUVXG870PSyjGfjzTXCQPSSvNJ/3R6rY4fh0uK1NNYzRbnF
 iTJPUQsbE37w==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="375032714"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:19:56 -0700
Date:   Fri, 19 Mar 2021 11:22:21 -0700
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
Message-ID: <20210319112221.5123b984@jacob-builder>
In-Reply-To: <20210319135432.GT2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210318172234.3e8c34f7@jacob-builder>
        <YFR10eeDVf5ZHV5l@myrica>
        <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Fri, 19 Mar 2021 10:54:32 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Mar 19, 2021 at 02:41:32PM +0100, Jean-Philippe Brucker wrote:
> > On Fri, Mar 19, 2021 at 09:46:45AM -0300, Jason Gunthorpe wrote:  
> > > On Fri, Mar 19, 2021 at 10:58:41AM +0100, Jean-Philippe Brucker wrote:
> > >   
> > > > Although there is no use for it at the moment (only two upstream
> > > > users and it looks like amdkfd always uses current too), I quite
> > > > like the client-server model where the privileged process does
> > > > bind() and programs the hardware queue on behalf of the client
> > > > process.  
> > > 
> > > This creates a lot complexity, how do does process A get a secure
> > > reference to B? How does it access the memory in B to setup the HW?  
> > 
> > mm_access() for example, and passing addresses via IPC  
> 
> I'd rather the source process establish its own PASID and then pass
> the rights to use it to some other process via FD passing than try to
> go the other way. There are lots of security questions with something
> like mm_access.
> 

Thank you all for the input, it sounds like we are OK to remove mm argument
from iommu_sva_bind_device() and iommu_sva_alloc_pasid() for now?

Let me try to summarize PASID allocation as below:

Interfaces	| Usage	|  Limit	| bind¹ |User visible
--------------------------------------------------------------------
/dev/ioasid²	| G-SVA/IOVA	|  cgroup	| No	|Yes
--------------------------------------------------------------------
char dev³	| SVA		|  cgroup	| Yes	|No
--------------------------------------------------------------------
iommu driver	| default PASID|  no		| No	|No
--------------------------------------------------------------------
kernel		| super SVA	| no		| yes   |No
--------------------------------------------------------------------

¹ Allocated during SVA bind
² PASIDs allocated via /dev/ioasid are not bound to any mm. But its
  ownership is assigned to the process that does the allocation.
³ Include uacce, other private device driver char dev such as idxd

Currently, the proposed /dev/ioasid interface does not map individual PASID
with an FD. The FD is at the ioasid_set granularity and bond to the current
mm. We could extend the IOCTLs to cover individual PASID-FD passing case
when use cases arise. Would this work?

Thanks,

Jacob
