Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56997372D1C
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEDPjy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 11:39:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:43996 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhEDPjy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 May 2021 11:39:54 -0400
IronPort-SDR: SoVxsb2A2CctvZ6e9DjudQiFmiv/DsPwZcf5uBoBc/oh6kHN77sv2RAhyekFWmuCOEiFq7klCP
 AsiV1nkkkcvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="197624568"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="197624568"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 08:38:59 -0700
IronPort-SDR: eVcqlKDXCpii3jZkhwnN7a0J/3G3igfAg57JBIW0V3O+usbdg9PgdLmu68B05/OGA2lKj1bKla
 JssfZGxXOk+Q==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="427815781"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 08:38:59 -0700
Date:   Tue, 4 May 2021 08:41:48 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20210504084148.4f61d0b5@jacob-builder>
In-Reply-To: <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421162307.GM1370958@nvidia.com>
        <20210421105451.56d3670a@redhat.com>
        <20210421175203.GN1370958@nvidia.com>
        <20210421133312.15307c44@redhat.com>
        <20210421230301.GP1370958@nvidia.com>
        <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210422121020.GT1370958@nvidia.com>
        <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210423114944.GF1370958@nvidia.com>
        <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210426123817.GQ1370958@nvidia.com>
        <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Kevin,

On Wed, 28 Apr 2021 06:34:11 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > 
> > (also looking at ioasid.c, why do we need such a thin and odd wrapper
> > around xarray?)
> >   
> 
> I'll leave it to Jean and Jacob.
I am not sure whether you are referring to the current ioasid.c or the
changes proposed in this patchset. I added a per VM/ioasid_set
(also per /dev/ioasid fd) xarray to store guest-host PASID mapping.

The current code has a xarray for the allocators.

struct ioasid_allocator_data {
	struct ioasid_allocator_ops *ops;
	struct list_head list;
	struct list_head slist;
#define IOASID_ALLOCATOR_CUSTOM BIT(0) /* Needs framework to track results */
	unsigned long flags;
	struct xarray xa;
	struct rcu_head rcu;
};

Could you elaborate?

Thanks,

Jacob
