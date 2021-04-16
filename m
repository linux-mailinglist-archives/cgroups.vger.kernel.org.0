Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7500136222C
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 16:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhDPO1F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 10:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232796AbhDPO1E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Apr 2021 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618583199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1Hv2NbQ/MlDR82Y8nOIlqSLTEiVX08oupchgjJ9jRA=;
        b=O1rjioiI59LvC+S4nBSeMhvzoA5ceS7spb7jFCdkjrRNpFC6fI2SWlI3K6TOtlvalhf1eK
        N8JyO3WbCICOTkpav9TbWyRS8TN7sLxljNHIGja8vud0uQjveKKbJMfRJFUsKy+0WG39bV
        fUYD+aLmoTlKKHb4d/5H4oRLVS0daMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Zj04weCaOsqjgL2F0OCe8Q-1; Fri, 16 Apr 2021 10:26:35 -0400
X-MC-Unique: Zj04weCaOsqjgL2F0OCe8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4FE0BBEE4;
        Fri, 16 Apr 2021 14:26:32 +0000 (UTC)
Received: from [10.36.113.21] (ovpn-113-21.ams2.redhat.com [10.36.113.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 321F25D9C0;
        Fri, 16 Apr 2021 14:26:21 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
References: <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
 <b1492fd3-8ce2-1632-3b14-73d8d4356fd7@redhat.com>
 <20210416140524.GI1370958@nvidia.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <f71c1e37-6466-e931-be1d-b9b36d785596@redhat.com>
Date:   Fri, 16 Apr 2021 16:26:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210416140524.GI1370958@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,
On 4/16/21 4:05 PM, Jason Gunthorpe wrote:
> On Fri, Apr 16, 2021 at 03:38:02PM +0200, Auger Eric wrote:
> 
>> The redesign requirement came pretty late in the development process.
>> The iommu user API is upstream for a while, the VFIO interfaces have
>> been submitted a long time ago and under review for a bunch of time.
>> Redesigning everything with a different API, undefined at this point, is
>> a major setback for our work and will have a large impact on the
>> introduction of features companies are looking forward, hence our
>> frustration.
> 
> I will answer both you and Jacob at once.
> 
> This is uAPI, once it is set it can never be changed.
> 
> The kernel process and philosophy is to invest heavily in uAPI
> development and review to converge on the best uAPI possible.
> 
> Many past submissions have take a long time to get this right, there
> are several high profile uAPI examples.
> 
> Do you think this case is so special, or the concerns so minor, that it
> should get to bypass all of the normal process?

That's not my intent to bypass any process. I am just trying to
understand what needs to be re-designed and for what use case.
> 
> Ask yourself, is anyone advocating for the current direction on
> technical merits alone?
> 
> Certainly the patches I last saw where completely disgusting from a
> uAPI design perspective.
> 
> It was against the development process to organize this work the way
> it was done. Merging a wack of dead code to the kernel to support a
> uAPI vision that was never clearly articulated was a big mistake.
> 
> Start from the beginning. Invest heavily in defining a high quality
> uAPI. Clearly describe the uAPI to all stake holders.
This was largely done during several confs including plumber, KVM forum,
for several years. Also API docs were shared on the ML. I don't remember
any voice was raised at those moments.

 Break up the
> implementation into patch series without dead code. Make the
> patches. Remove the dead code this group has already added.
> 
> None of this should be a surprise. The VDPA discussion and related
> "what is a mdev" over a year ago made it pretty clear VFIO is not the
> exclusive user of "IOMMU in userspace" and that places limits on what
> kind of uAPIs expansion it should experience going forward.
Maybe clear for you but most probably not for many other stakeholders.

Anyway I do not intend to further argue and I will be happy to learn
from you and work with you, Jacob, Liu and all other stakeholders to
define a better integration.

Thanks

Eric
> 
> Jason
> 

