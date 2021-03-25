Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838B734977A
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 18:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCYRAR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 13:00:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:23725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhCYRAL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 25 Mar 2021 13:00:11 -0400
IronPort-SDR: gOpI+QLqAtR9ATCRM1zGrl+B7MOyyJfR6qX1MJJhciRrcQ50Xl51KbmJhz8/Yt7Bq2Rq1sTPmx
 LlGxWjsGH68g==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="191006158"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="191006158"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 10:00:09 -0700
IronPort-SDR: 2y+6feWtrUcXYxfBHPesWqNmZ6kIWcDDsLyjiaRoSEn254L4SReT6/Tck0Lc0DbYE10KjtxKlE
 wtU3q2hP7nrw==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="376922132"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 10:00:08 -0700
Date:   Thu, 25 Mar 2021 10:02:36 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20210325100236.17241a1c@jacob-builder>
In-Reply-To: <YFxkNEz3THJKzW0b@myrica>
References: <20210318172234.3e8c34f7@jacob-builder>
        <YFR10eeDVf5ZHV5l@myrica>
        <20210319124645.GP2356281@nvidia.com>
        <YFSqDNJ5yagk4eO+@myrica>
        <20210319135432.GT2356281@nvidia.com>
        <20210319112221.5123b984@jacob-builder>
        <YFhiMLR35WWMW/Hu@myrica>
        <20210324100246.4e6b8aa1@jacob-builder>
        <20210324170338.GM2356281@nvidia.com>
        <20210324151230.466fd47a@jacob-builder>
        <YFxkNEz3THJKzW0b@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jean-Philippe,

On Thu, 25 Mar 2021 11:21:40 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Wed, Mar 24, 2021 at 03:12:30PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 24 Mar 2021 14:03:38 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:  
> > > > > Also wondering about device driver allocating auxiliary domains
> > > > > for their private use, to do iommu_map/unmap on private PASIDs (a
> > > > > clean replacement to super SVA, for example). Would that go
> > > > > through the same path as /dev/ioasid and use the cgroup of
> > > > > current task?    
> > > >
> > > > For the in-kernel private use, I don't think we should restrict
> > > > based on cgroup, since there is no affinity to user processes. I
> > > > also think the PASID allocation should just use kernel API instead
> > > > of /dev/ioasid. Why would user space need to know the actual PASID
> > > > # for device private domains? Maybe I missed your idea?    
> > > 
> > > There is not much in the kernel that isn't triggered by a process, I
> > > would be careful about the idea that there is a class of users that
> > > can consume a cgroup controlled resource without being inside the
> > > cgroup.
> > > 
> > > We've got into trouble before overlooking this and with something
> > > greenfield like PASID it would be best built in to the API to prevent
> > > a mistake. eg accepting a cgroup or process input to the allocator.
> > >   
> > Make sense. But I think we only allow charging the current cgroup, how
> > about I add the following to ioasid_alloc():
> > 
> > 	misc_cg = get_current_misc_cg();
> > 	ret = misc_cg_try_charge(MISC_CG_RES_IOASID, misc_cg, 1);
> > 	if (ret) {
> > 		put_misc_cg(misc_cg);
> > 		return ret;
> > 	}  
> 
> Does that allow PASID allocation during driver probe, in kernel_init or
> modprobe context?
> 
Good point. Yes, you can get cgroup subsystem state in kernel_init for
charging/uncharging. I would think module_init should work also since it is
after kernel_init. I have tried the following:
static int __ref kernel_init(void *unused)
 {
        int ret;
+       struct cgroup_subsys_state *css;
+       css = task_get_css(current, pids_cgrp_id);

But that would imply:
1. IOASID has to be built-in, not as module
2. IOASIDs charged on PID1/init would not subject to cgroup limit since it
will be in the root cgroup and we don't support migration nor will migrate.

Then it comes back to the question of why do we try to limit in-kernel
users per cgroup if we can't enforce these cases.

> Thanks,
> Jean
> 


Thanks,

Jacob
