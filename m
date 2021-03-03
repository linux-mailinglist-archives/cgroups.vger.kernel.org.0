Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1EF32C8FB
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 02:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhCDA7s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Mar 2021 19:59:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:40969 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237335AbhCCVRK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 3 Mar 2021 16:17:10 -0500
IronPort-SDR: j1K1quAxMPqOSSXqKXoCFfkbWh7b+tUA6mPo+1zL8/cC5wc4hw245lSDE0vwP+Mvfcn9ywcZTj
 QkFCJbpKQVng==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="272282417"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="272282417"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 13:15:15 -0800
IronPort-SDR: 4GumHzw+bqY2IuEknONcScAZW86HiX+ue90j58IjKak+hmhbzwOuAwfFlCGtOaA4n6eEKtFaub
 IoJjZGUM6C9g==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="406603184"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 13:15:11 -0800
Date:   Wed, 3 Mar 2021 13:17:26 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
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
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210303131726.7a8cb169@jacob-builder>
In-Reply-To: <YD+u3CXhwOi2LC+4@slm.duckdns.org>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
        <YD+u3CXhwOi2LC+4@slm.duckdns.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:

> On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:
> > IOASIDs are used to associate DMA requests with virtual address spaces.
> > They are a system-wide limited resource made available to the userspace
> > applications. Let it be VMs or user-space device drivers.
> > 
> > This RFC patch introduces a cgroup controller to address the following
> > problems:
> > 1. Some user applications exhaust all the available IOASIDs thus
> > depriving others of the same host.
> > 2. System admins need to provision VMs based on their needs for IOASIDs,
> > e.g. the number of VMs with assigned devices that perform DMA requests
> > with PASID.  
> 
> Please take a look at the proposed misc controller:
> 
>  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> 
> Would that fit your bill?
The interface definitely can be reused. But IOASID has a different behavior
in terms of migration and ownership checking. I guess SEV key IDs are not
tied to a process whereas IOASIDs are. Perhaps this can be solved by
adding
+	.can_attach	= ioasids_can_attach,
+	.cancel_attach	= ioasids_cancel_attach,
Let me give it a try and come back.

Thanks for the pointer.

Jacob

> 
> Thanks.
> 


Thanks,

Jacob
