Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FCF373237
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhEDWKB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 18:10:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:47393 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbhEDWKA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 May 2021 18:10:00 -0400
IronPort-SDR: pao5c3IY1dlRQQYM51UZQ+j5zh6ey7F6jWyCu5K2/ZRO8bHhqraFxurFxpXV5WgTLKLFcBz9RG
 oRlPlSJnt5/w==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="218918606"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="218918606"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 15:09:04 -0700
IronPort-SDR: SuLTDiqHXM8cd3yT7FXZf7uhVJgQJ2nTgf8+4zbG2ekswyEiVikeXRe1aAw3rFb3TKUSyGk+eU
 uKLTEkKkso9g==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="433492852"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 15:09:04 -0700
Date:   Tue, 4 May 2021 15:11:54 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210504151154.02908c63@jacob-builder>
In-Reply-To: <20210504180050.GB1370958@nvidia.com>
References: <20210421133312.15307c44@redhat.com>
        <20210421230301.GP1370958@nvidia.com>
        <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210422121020.GT1370958@nvidia.com>
        <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210423114944.GF1370958@nvidia.com>
        <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210426123817.GQ1370958@nvidia.com>
        <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210504084148.4f61d0b5@jacob-builder>
        <20210504180050.GB1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Tue, 4 May 2021 15:00:50 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 04, 2021 at 08:41:48AM -0700, Jacob Pan wrote:
> > > > 
> > > > (also looking at ioasid.c, why do we need such a thin and odd
> > > > wrapper around xarray?)
> > > >     
> > > 
> > > I'll leave it to Jean and Jacob.  
> 
> > Could you elaborate?  
> 
> I mean stuff like this:
> 
> int ioasid_set_data(ioasid_t ioasid, void *data)
> {
>         struct ioasid_data *ioasid_data;
>         int ret = 0;
> 
>         spin_lock(&ioasid_allocator_lock);
>         ioasid_data = xa_load(&active_allocator->xa, ioasid);
>         if (ioasid_data)
>                 rcu_assign_pointer(ioasid_data->private, data);
>         else
>                 ret = -ENOENT;
>         spin_unlock(&ioasid_allocator_lock);
> 
>         /*
>          * Wait for readers to stop accessing the old private data, so the
>          * caller can free it.
>          */
>         if (!ret)
>                 synchronize_rcu();
> 
>         return ret;
> }
> EXPORT_SYMBOL_GPL(ioasid_set_data);
> 
> It is a weird way to use xarray to have a structure which
> itself is just a wrapper around another RCU protected structure.
> 
> Make the caller supply the ioasid_data memory, embedded in its own
> element, get rid of the void * and rely on XA_ZERO_ENTRY to hold
> allocated but not active entries.
> 
Let me try to paraphrase to make sure I understand. Currently
struct ioasid_data is private to the iasid core, its memory is allocated by
the ioasid core.

You are suggesting the following:
1. make struct ioasid_data public
2. caller allocates memory for ioasid_data, initialize it then pass it to
ioasid_alloc to store in the xarray
3. caller will be responsible for setting private data inside ioasid_data
and do call_rcu after update if needed.

Correct?

> Make the synchronize_rcu() the caller responsiblity, and callers
> should really be able to use call_rcu()
> 
> Jason


Thanks,

Jacob
