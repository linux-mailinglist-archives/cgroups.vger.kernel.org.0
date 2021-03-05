Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70732F24E
	for <lists+cgroups@lfdr.de>; Fri,  5 Mar 2021 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCESTY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 13:19:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:16642 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhCESTP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Mar 2021 13:19:15 -0500
IronPort-SDR: 4SXeAhiTGcU1b6hToXet6fDpC6kqxnnLXiQkr4Luw1SYwMEr0CfBdxrvYtKFSB8PTebX5IqKW2
 Bil+uM1SCn2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="187807333"
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="187807333"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 10:19:14 -0800
IronPort-SDR: Yve4Xs/BQQO/dPrUERl1ezaSRoE42oOdpR/DR9drzbbAJMBbkvwbwxAPL/sU8t0amziAK3gbiO
 W9p6P5svTYjw==
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="436593317"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 10:19:13 -0800
Date:   Fri, 5 Mar 2021 10:20:48 -0800
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
Message-ID: <20210305102048.7c274968@jacob-builder>
In-Reply-To: <YEHsOR/XjDxQapE6@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
        <YD+u3CXhwOi2LC+4@slm.duckdns.org>
        <20210303131726.7a8cb169@jacob-builder>
        <20210303160205.151d114e@jacob-builder>
        <YECtMZNqSgh7jkGP@myrica>
        <20210304094603.4ab6c1c4@jacob-builder>
        <YEHsOR/XjDxQapE6@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jean-Philippe,

On Fri, 5 Mar 2021 09:30:49 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Thu, Mar 04, 2021 at 09:46:03AM -0800, Jacob Pan wrote:
> > Hi Jean-Philippe,
> > 
> > On Thu, 4 Mar 2021 10:49:37 +0100, Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> >   
> > > On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:  
> > > > Hi Jacob,
> > > > 
> > > > On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
> > > > <jacob.jun.pan@linux.intel.com> wrote:
> > > >     
> > > > > Hi Tejun,
> > > > > 
> > > > > On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org>
> > > > > wrote: 
> > > > > > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:      
> > > > > > > IOASIDs are used to associate DMA requests with virtual
> > > > > > > address spaces. They are a system-wide limited resource made
> > > > > > > available to the userspace applications. Let it be VMs or
> > > > > > > user-space device drivers.
> > > > > > > 
> > > > > > > This RFC patch introduces a cgroup controller to address the
> > > > > > > following problems:
> > > > > > > 1. Some user applications exhaust all the available IOASIDs
> > > > > > > thus depriving others of the same host.
> > > > > > > 2. System admins need to provision VMs based on their needs
> > > > > > > for IOASIDs, e.g. the number of VMs with assigned devices
> > > > > > > that perform DMA requests with PASID.        
> > > > > > 
> > > > > > Please take a look at the proposed misc controller:
> > > > > > 
> > > > > >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > > > > > 
> > > > > > Would that fit your bill?      
> > > > > The interface definitely can be reused. But IOASID has a different
> > > > > behavior in terms of migration and ownership checking. I guess
> > > > > SEV key IDs are not tied to a process whereas IOASIDs are.
> > > > > Perhaps this can be solved by adding
> > > > > +	.can_attach	= ioasids_can_attach,
> > > > > +	.cancel_attach	= ioasids_cancel_attach,
> > > > > Let me give it a try and come back.
> > > > >     
> > > > While I am trying to fit the IOASIDs cgroup in to the misc cgroup
> > > > proposal. I'd like to have a direction check on whether this idea of
> > > > using cgroup for IOASID/PASID resource management is viable.    
> > > 
> > > Yes, even for host SVA it would be good to have a cgroup. Currently
> > > the number of shared address spaces is naturally limited by number of
> > > processes, which can be controlled with rlimit and cgroup. But on Arm
> > > the hardware limit on shared address spaces is 64k (number of ASIDs),
> > > easily exhausted with the default PASID and PID limits. So a cgroup
> > > for managing this resource is more than welcome.
> > > 
> > > It looks like your current implementation is very dependent on
> > > IOASID_SET_TYPE_MM?  I'll need to do more reading about cgroup to see
> > > how easily it can be adapted to host SVA which uses
> > > IOASID_SET_TYPE_NULL. 
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
> > i.e. limit fork.  
> 
> That works but isn't perfect, because the hardware resource of shared
> address spaces can be much lower that PID limit - 16k ASIDs on Arm. To
> allow an admin to fairly distribute that resource we could introduce
> another cgroup just to limit the number of shared address spaces, but
> limiting the number of IOASIDs does the trick.
> 
make sense. it would be cleaner to have a single approach to limit IOASIDs
(as Jason asked).

> > So the host IOASIDs are currently allocated from the system pool
> > with quota of chosen by iommu_sva_init() in my patch, 0 means unlimited
> > use whatever is available. https://lkml.org/lkml/2021/2/28/18  
> 
> Yes that's sensible, but it would be good to plan the cgroup user
> interface to work for #2 as well, even if we don't implement it right
> away.
> 
will do it in the next version.

> Thanks,
> Jean


Thanks,

Jacob
