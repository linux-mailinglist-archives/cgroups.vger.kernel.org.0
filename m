Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2A9362343
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhDPPB2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 11:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233916AbhDPPB1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Apr 2021 11:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618585262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5MhNFa+G0GXPiMOp8zeJtDGBUydEX9X5pmRHMN7Eug=;
        b=XR/e+NTTTfwQ7jfhHBmwVOhMuPvL+4dR/AEzchWh2cw7pGaxVBgwFrM494YuMlztZ6PKTS
        q8SmLX0pQXA5JHSYfKXZBPECkxsMRORv4X0T5KdJGSbFjAV1et0hvpMF2jvZYn1Zu/I2KU
        D4swtJeoTfuAYk3bMQNJRhQpLGYUOXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-Z4tRWluRNO-bDudkzhywfw-1; Fri, 16 Apr 2021 11:00:57 -0400
X-MC-Unique: Z4tRWluRNO-bDudkzhywfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC79B107AFB6;
        Fri, 16 Apr 2021 15:00:54 +0000 (UTC)
Received: from [10.36.113.21] (ovpn-113-21.ams2.redhat.com [10.36.113.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34752107D5C1;
        Fri, 16 Apr 2021 15:00:47 +0000 (UTC)
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
References: <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
 <b1492fd3-8ce2-1632-3b14-73d8d4356fd7@redhat.com>
 <20210416140524.GI1370958@nvidia.com>
 <f71c1e37-6466-e931-be1d-b9b36d785596@redhat.com>
 <20210416143451.GJ1370958@nvidia.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <6159ef35-c24e-105f-43f6-f90d481f4b24@redhat.com>
Date:   Fri, 16 Apr 2021 17:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210416143451.GJ1370958@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On 4/16/21 4:34 PM, Jason Gunthorpe wrote:
> On Fri, Apr 16, 2021 at 04:26:19PM +0200, Auger Eric wrote:
> 
>> This was largely done during several confs including plumber, KVM forum,
>> for several years. Also API docs were shared on the ML. I don't remember
>> any voice was raised at those moments.
> 
> I don't think anyone objects to the high level ideas, but
> implementation does matter. I don't think anyone presented "hey we
> will tunnel an uAPI through VFIO to the IOMMU subsystem" - did they?

At minimum
https://events19.linuxfoundation.cn/wp-content/uploads/2017/11/Shared-Virtual-Memory-in-KVM_Yi-Liu.pdf

But most obviously everything is documented in
Documentation/userspace-api/iommu.rst where the VFIO tunneling is
clearly stated ;-)

But well let's work together to design a better and more elegant
solution then.

Thanks

Eric
> 
> Look at the fairly simple IMS situation, for example. This was
> presented at plumbers too, and the slides were great - but the
> implementation was too hacky. It required a major rework of the x86
> interrupt handling before it was OK.
> 
> Jason
> 

