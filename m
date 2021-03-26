Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7368A34A2F3
	for <lists+cgroups@lfdr.de>; Fri, 26 Mar 2021 09:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhCZIHI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Mar 2021 04:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCZIHC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Mar 2021 04:07:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ABEC0613B0
        for <cgroups@vger.kernel.org>; Fri, 26 Mar 2021 01:07:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c8so4695666wrq.11
        for <cgroups@vger.kernel.org>; Fri, 26 Mar 2021 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NacPEJvwU26BHEcF1r3DKOPrdoZ0K2lnEiVQ/oV37r4=;
        b=kus60msoSJlwyU1GomSA58McYHQudRjt8lZoUOVyLCyxExYPuQiC/FgDUjEDEdiFJH
         OtPkVS983YcgkVOZ3NbX19SKHfGojdxWiV+mZsVTfFS3PH2ZKq07YDEns8DQHizqSqjj
         kAlYqYai0ZCtnRvwuakJexNRFQxOeUsmhfllUZTGd3aMTne5GjehFbclbRF9zPTDvxfr
         7mUrcCG9VaWh1DWLhfC1B0KnAzLxhwQqcmOk5cN/v/L72Qlm6lRW3AGNrgKkaY+vlaHX
         i+2MikP0ctvy5L5KCWHU8Q958BKQKlSB4DTgMhSfZv+A2P690PsjqM55+5z0YJQ2NIsx
         6Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NacPEJvwU26BHEcF1r3DKOPrdoZ0K2lnEiVQ/oV37r4=;
        b=G1H80Z2hj7IjLhFsnGr6jKvQjvZJAdt2x+i1wxntzo/PWjcM5zlogSQ66REKuAc2Qf
         aaMz3zJO/zABozUhPj4TLnoolmrnypCc4kHxFakmmkYWGU807DdTMOW9q1pSsiBoO3Mv
         dC2RoRpaZjQgbHFrs8kjKGG5HhyDu66IerXdedaHoULRCNaLM7F+VzkWEoWRVXRo2PMQ
         RJOkdE+QBr3B/Jypm7D+dMK8w+7NbsaU/dtvRR4bOzSOf0049Rer+dPdm7uuf+F+od/I
         JO4tIj4AZ3KEWQ18EGGXm4YzdHorBJYhVTessajsYr5jlooHxGZgohcVxGzYJAkU2DEW
         FyjQ==
X-Gm-Message-State: AOAM533ZeYyYC1yPk3mbB5qbucidaPrW8kOf4mMS3O4npldALSVVQyAh
        IKXWKJ1gE4qd85pprtYa7dv+6g==
X-Google-Smtp-Source: ABdhPJzrQoMie+cZs+TTXzwMUWiYsj5CUy6yLxtxOwZG8ozx04KgN++aU+MFHI+ixkkVUGXl1VqrvQ==
X-Received: by 2002:a5d:591a:: with SMTP id v26mr12982847wrd.172.1616746021071;
        Fri, 26 Mar 2021 01:07:01 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id 7sm9654955wmk.8.2021.03.26.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 01:07:00 -0700 (PDT)
Date:   Fri, 26 Mar 2021 09:06:42 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YF2WEmfXsXKCkCDb@myrica>
References: <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder>
 <YFxkNEz3THJKzW0b@myrica>
 <20210325100236.17241a1c@jacob-builder>
 <20210325171645.GF2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325171645.GF2356281@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 25, 2021 at 02:16:45PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 25, 2021 at 10:02:36AM -0700, Jacob Pan wrote:
> > Hi Jean-Philippe,
> > 
> > On Thu, 25 Mar 2021 11:21:40 +0100, Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > 
> > > On Wed, Mar 24, 2021 at 03:12:30PM -0700, Jacob Pan wrote:
> > > > Hi Jason,
> > > > 
> > > > On Wed, 24 Mar 2021 14:03:38 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > > > wrote: 
> > > > > On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:  
> > > > > > > Also wondering about device driver allocating auxiliary domains
> > > > > > > for their private use, to do iommu_map/unmap on private PASIDs (a
> > > > > > > clean replacement to super SVA, for example). Would that go
> > > > > > > through the same path as /dev/ioasid and use the cgroup of
> > > > > > > current task?    
> > > > > >
> > > > > > For the in-kernel private use, I don't think we should restrict
> > > > > > based on cgroup, since there is no affinity to user processes. I
> > > > > > also think the PASID allocation should just use kernel API instead
> > > > > > of /dev/ioasid. Why would user space need to know the actual PASID
> > > > > > # for device private domains? Maybe I missed your idea?    
> > > > > 
> > > > > There is not much in the kernel that isn't triggered by a process, I
> > > > > would be careful about the idea that there is a class of users that
> > > > > can consume a cgroup controlled resource without being inside the
> > > > > cgroup.
> > > > > 
> > > > > We've got into trouble before overlooking this and with something
> > > > > greenfield like PASID it would be best built in to the API to prevent
> > > > > a mistake. eg accepting a cgroup or process input to the allocator.
> > > > >   
> > > > Make sense. But I think we only allow charging the current cgroup, how
> > > > about I add the following to ioasid_alloc():
> > > > 
> > > > 	misc_cg = get_current_misc_cg();
> > > > 	ret = misc_cg_try_charge(MISC_CG_RES_IOASID, misc_cg, 1);
> > > > 	if (ret) {
> > > > 		put_misc_cg(misc_cg);
> > > > 		return ret;
> > > > 	}  
> > > 
> > > Does that allow PASID allocation during driver probe, in kernel_init or
> > > modprobe context?
> > > 
> > Good point. Yes, you can get cgroup subsystem state in kernel_init for
> > charging/uncharging. I would think module_init should work also since it is
> > after kernel_init. I have tried the following:
> > static int __ref kernel_init(void *unused)
> >  {
> >         int ret;
> > +       struct cgroup_subsys_state *css;
> > +       css = task_get_css(current, pids_cgrp_id);
> > 
> > But that would imply:
> > 1. IOASID has to be built-in, not as module

If IOASID is a module, the device driver will probe once the IOMMU module
is available, which I think always happens in probe deferral kworker.

> > 2. IOASIDs charged on PID1/init would not subject to cgroup limit since it
> > will be in the root cgroup and we don't support migration nor will migrate.
> > 
> > Then it comes back to the question of why do we try to limit in-kernel
> > users per cgroup if we can't enforce these cases.

It may be better to explicitly pass a cgroup during allocation as Jason
suggested. That way anyone using the API will have to be aware of this and
pass the root cgroup if that's what they want.

> Are these real use cases? Why would a driver binding to a device
> create a single kernel pasid at bind time? Why wouldn't it use
> untagged DMA?

It's not inconceivable to have a control queue doing DMA tagged with
PASID. The devices I know either use untagged DMA, or have a choice to use
a PASID. We're not outright forbidding PASID allocation at boot (I don't
think we can or should) and we won't be able to check every use of the
API, so I'm trying to figure out whether it will always default to root
cgroup, or crash in some corner case.

Thanks,
Jean
