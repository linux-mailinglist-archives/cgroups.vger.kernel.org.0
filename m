Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1053670AB
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbhDUQzk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 12:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237257AbhDUQzi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 12:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619024105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7JdcUX8euC4TKmJkCs8pS1cnLRRfeyWp+CS9J58HkU=;
        b=V3YULckrD0Y+bqQY3m+NwIHVsGKRNYluLIZEV37Szf1STHl46gcolirrfs7wfnS6x8uRzb
        AFfPwUqRuBQ1BYSjpKVI+0IsKywlPIXNobhEG4diOgggI64pC2SOt8d8x81pnFYYTLEyUY
        vcXhDxllyt7df7amqPLNC5UbXSKbb/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-aKLr98iKNbyZKCa4-hYviw-1; Wed, 21 Apr 2021 12:55:00 -0400
X-MC-Unique: aKLr98iKNbyZKCa4-hYviw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6B37801814;
        Wed, 21 Apr 2021 16:54:57 +0000 (UTC)
Received: from redhat.com (ovpn-114-21.phx2.redhat.com [10.3.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE3AB5D736;
        Wed, 21 Apr 2021 16:54:51 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:54:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210421105451.56d3670a@redhat.com>
In-Reply-To: <20210421162307.GM1370958@nvidia.com>
References: <YGW27KFt9eQB9X2z@myrica>
        <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210401134236.GF1463678@nvidia.com>
        <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210401160337.GJ1463678@nvidia.com>
        <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
        <20210415230732.GG1370958@nvidia.com>
        <20210416061258.325e762e@jacob-builder>
        <20210416094547.1774e1a3@redhat.com>
        <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210421162307.GM1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 21 Apr 2021 13:23:07 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Apr 21, 2021 at 01:18:07PM +0000, Liu, Yi L wrote:
> > > Ideally this new /dev/ioasid interface, and making use of it as a VFIO
> > > IOMMU backend, should replace type1.   
> > 
> > yeah, just a double check, I think this also requires a new set of uAPIs
> > (e.g. new MAP/UNMAP), which means the current VFIO IOMMU type1 related ioctls
> > would be deprecated in future. right?  
> 
> This is something to think about, it might make sense to run the
> current ioctls in some "compat" mode under /dev/ioasid just to make
> migration easier

Right, deprecating type1 doesn't necessarily mean deprecating the uAPI.
We created a type1v2 with minor semantic differences in unmap behavior
within the same uAPI.  Userspace is able to query and select an IOMMU
backend model and each model might have a different uAPI.  The SPAPR
IOMMU backend already takes advantage of this, using some ioctls
consistent with type1, but also requiring some extra steps.

Also note that the simple MAP and UNMAP uAPI of type1 has its
limitations, which we already struggle with.  See for example the
massive performance issues backing a vIOMMU with this uAPI.  The
/dev/ioasid approach should alleviate some of that, using a page table
for the 1st level, but a more advanced uAPI for the 2nd level seems
necessary at some point as well.

> In this sense /dev/ioasid would be a container that holds multiple
> IOASIDs and every new format ioctl specifies the IOASID to operate
> on. The legacy ioctls would use some default IOASID but otherwise act
> the same.
> 
> I'm assuming here there is nothing especially wrong with the /dev/vfio
> interface beyond being in the wrong place in the kernel and not
> supporting multiple IOASIDs?
> 
> Then there may be a fairly simple approch to just make /dev/vfio ==
> /dev/ioasid, at least for type 1.
>
> By this I mean we could have the new /dev/ioasid code take over the
> /dev/vfio char dev and present both interfaces, but with the same
> fops.

That's essentially replacing vfio-core, where I think we're more
talking about /dev/ioasid being an available IOMMU backend driver which
a user can select when available.  The interface of making that
selection might change to accept an external /dev/ioasid file
descriptor, of course.  Maybe you can elaborate on how the vfio device
and group uAPI live (or not) in this new scheme were /dev/ioasid is the
primary interface.  Thanks,

Alex

