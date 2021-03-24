Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BBF34845A
	for <lists+cgroups@lfdr.de>; Wed, 24 Mar 2021 23:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhCXWKP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Mar 2021 18:10:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:35225 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234960AbhCXWKF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 24 Mar 2021 18:10:05 -0400
IronPort-SDR: 9zxKobfwZxPI+CPFirI8c+VdQGflbVDgBZjm7+dtgAfGNEpqMOGjZXF57LYkCAdi+BiXLTYFS/
 HMUQYqGXJW2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178348424"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="178348424"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 15:10:03 -0700
IronPort-SDR: DQZSaLihhzL2eMMuOF5/+Gq/kYGub32TVjHTLJr/fySOgtaPJemHSPHFCx7OFGJFZBYCPKhCq1
 tkpDOzoJ4dTA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="413927681"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 15:10:03 -0700
Date:   Wed, 24 Mar 2021 15:12:30 -0700
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
Message-ID: <20210324151230.466fd47a@jacob-builder>
In-Reply-To: <20210324170338.GM2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210318172234.3e8c34f7@jacob-builder>
        <YFR10eeDVf5ZHV5l@myrica>
        <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <YFhiMLR35WWMW/Hu@myrica>
        <20210324100246.4e6b8aa1@jacob-builder>
        <20210324170338.GM2356281@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Wed, 24 Mar 2021 14:03:38 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:
> > > Also wondering about device driver allocating auxiliary domains for
> > > their private use, to do iommu_map/unmap on private PASIDs (a clean
> > > replacement to super SVA, for example). Would that go through the
> > > same path as /dev/ioasid and use the cgroup of current task?  
> >
> > For the in-kernel private use, I don't think we should restrict based on
> > cgroup, since there is no affinity to user processes. I also think the
> > PASID allocation should just use kernel API instead of /dev/ioasid. Why
> > would user space need to know the actual PASID # for device private
> > domains? Maybe I missed your idea?  
> 
> There is not much in the kernel that isn't triggered by a process, I
> would be careful about the idea that there is a class of users that
> can consume a cgroup controlled resource without being inside the
> cgroup.
> 
> We've got into trouble before overlooking this and with something
> greenfield like PASID it would be best built in to the API to prevent
> a mistake. eg accepting a cgroup or process input to the allocator.
> 
Make sense. But I think we only allow charging the current cgroup, how about
I add the following to ioasid_alloc():

	misc_cg = get_current_misc_cg();
	ret = misc_cg_try_charge(MISC_CG_RES_IOASID, misc_cg, 1);
	if (ret) {
		put_misc_cg(misc_cg);
		return ret;
	}

BTW, IOASID will be one of the resources under the proposed misc cgroup.

Thanks,

Jacob
