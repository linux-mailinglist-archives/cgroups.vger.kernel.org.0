Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D0B32D8F1
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhCDRr0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 12:47:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:29565 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238885AbhCDRrQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Mar 2021 12:47:16 -0500
IronPort-SDR: X1zaUizYHujaNnDwhrb1aZT5qTgFJI1/epypBMovzeMCqkdtCx8bmefoKEFEiTDKythBVxKptS
 eGbXFr5qAI+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="187517195"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="187517195"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 09:43:47 -0800
IronPort-SDR: mAlWpKOZKEpvY0SmGMBDm5RRe6QJJdnh0KUxB8DpjbEG7MHIzGWbj1rly16CjcOejbx4bxe9LP
 bGhX6pFCtY4w==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="368260744"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 09:43:47 -0800
Date:   Thu, 4 Mar 2021 09:46:03 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
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
Message-ID: <20210304094603.4ab6c1c4@jacob-builder>
In-Reply-To: <YECtMZNqSgh7jkGP@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
        <YD+u3CXhwOi2LC+4@slm.duckdns.org>
        <20210303131726.7a8cb169@jacob-builder>
        <20210303160205.151d114e@jacob-builder>
        <YECtMZNqSgh7jkGP@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jean-Philippe,

On Thu, 4 Mar 2021 10:49:37 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:
> > Hi Jacob,
> > 
> > On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
> > <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > Hi Tejun,
> > > 
> > > On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:
> > >   
> > > > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:    
> > > > > IOASIDs are used to associate DMA requests with virtual address
> > > > > spaces. They are a system-wide limited resource made available to
> > > > > the userspace applications. Let it be VMs or user-space device
> > > > > drivers.
> > > > > 
> > > > > This RFC patch introduces a cgroup controller to address the
> > > > > following problems:
> > > > > 1. Some user applications exhaust all the available IOASIDs thus
> > > > > depriving others of the same host.
> > > > > 2. System admins need to provision VMs based on their needs for
> > > > > IOASIDs, e.g. the number of VMs with assigned devices that perform
> > > > > DMA requests with PASID.      
> > > > 
> > > > Please take a look at the proposed misc controller:
> > > > 
> > > >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > > > 
> > > > Would that fit your bill?    
> > > The interface definitely can be reused. But IOASID has a different
> > > behavior in terms of migration and ownership checking. I guess SEV key
> > > IDs are not tied to a process whereas IOASIDs are. Perhaps this can be
> > > solved by adding
> > > +	.can_attach	= ioasids_can_attach,
> > > +	.cancel_attach	= ioasids_cancel_attach,
> > > Let me give it a try and come back.
> > >   
> > While I am trying to fit the IOASIDs cgroup in to the misc cgroup
> > proposal. I'd like to have a direction check on whether this idea of
> > using cgroup for IOASID/PASID resource management is viable.  
> 
> Yes, even for host SVA it would be good to have a cgroup. Currently the
> number of shared address spaces is naturally limited by number of
> processes, which can be controlled with rlimit and cgroup. But on Arm the
> hardware limit on shared address spaces is 64k (number of ASIDs), easily
> exhausted with the default PASID and PID limits. So a cgroup for managing
> this resource is more than welcome.
> 
> It looks like your current implementation is very dependent on
> IOASID_SET_TYPE_MM?  I'll need to do more reading about cgroup to see how
> easily it can be adapted to host SVA which uses IOASID_SET_TYPE_NULL.
> 
Right, I was assuming have three use cases of IOASIDs:
1. host supervisor SVA (not a concern, just one init_mm to bind)
2. host user SVA, either one IOASID per process or perhaps some private
IOASID for private address space
3. VM use for guest SVA, each IOASID is bound to a guest process

My current cgroup proposal applies to #3 with IOASID_SET_TYPE_MM, which is
allocated by the new /dev/ioasid interface.

For #2, I was thinking you can limit the host process via PIDs cgroup? i.e.
limit fork. So the host IOASIDs are currently allocated from the system pool
with quota of chosen by iommu_sva_init() in my patch, 0 means unlimited use
whatever is available. https://lkml.org/lkml/2021/2/28/18


> Thanks,
> Jean


Thanks,

Jacob
