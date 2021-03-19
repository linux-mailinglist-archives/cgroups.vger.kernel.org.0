Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A07D34230C
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 18:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhCSRMV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 13:12:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:38527 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhCSRMQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 19 Mar 2021 13:12:16 -0400
IronPort-SDR: 9lbRfEfRPo0h7/ZYqarS5g+CcioFJqU0tTE1IkyLFBSW78wkj68Mj4rAeUu5RrtGvpT5vTvaku
 RU0VDMv6y0fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="177063678"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="177063678"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 10:12:15 -0700
IronPort-SDR: VbTWhJ2rgwdhOkRbc708GpiO2lxB1YMjIYwzSJznSjuXtAGNCMoVpcDc9aFVtXjBLoQ+7KUwO2
 6tf1Q/GpaDgg==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="375012290"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 10:12:15 -0700
Date:   Fri, 19 Mar 2021 10:14:39 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210319101439.19f35fd5@jacob-builder>
In-Reply-To: <YFR10eeDVf5ZHV5l@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210318172234.3e8c34f7@jacob-builder>
        <YFR10eeDVf5ZHV5l@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jean-Philippe,

On Fri, 19 Mar 2021 10:58:41 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> > Slightly off the title. As we are moving to use cgroup to limit PASID
> > allocations, it would be much simpler if we enforce on the current
> > task.  
> 
> Yes I think we should do that. Is there a problem with charging the
> process that does the PASID allocation even if the PASID indexes some
> other mm?
Besides complexity, my second concern is that we are sharing the misc
cgroup controller with other resources that do not have such behavior.

Cgroup v2 also has unified hierarchy which also requires coherent behavior
among controllers.

Thanks,

Jacob
