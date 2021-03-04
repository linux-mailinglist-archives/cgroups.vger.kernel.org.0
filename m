Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999732D9F5
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 20:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhCDTEv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 14:04:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5994 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbhCDTEY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Mar 2021 14:04:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60412f100000>; Thu, 04 Mar 2021 11:03:44 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 19:03:43 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 19:02:59 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 19:02:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ7NdjWDHjomI7Kl+rhQLQJn6XtgHeGSr8jXkM7+dfn7Vp8pymNtiC/qeV4RypFO88liiqnF24gafWLXzVqsPbGOT1UEUanC4zikUXFEoaUL/grgNPEW/7tvRMF2NlROV2JrTVqPbkKsxdCkywHluK1JtAHoOq3HecfVl6+b2aQxQJOIpazY2WM/FGK5BpbCZKt7zrcC4Q5hqY0ig8gODFEha2CS/RwymzcwppxQZe4otxq2uTeIJgh9vjxyJ7hsxDnZ7iE4vIpC9s0TqdSUjC6Bu+5OI/UGz+gSQcpbpHJqjGON0u4V4iLvPDI+rCvxK3S/8Dl7tgQRpyBPHPInFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsoX4K4P4Z7v42HYxZh2fbbvzalzBIz6MU+YUWvMuh8=;
 b=SG3JYb9N3GWINJGThmiBwuFQAbc13h9uou8vfUSMRgPjU5tVVGB8qyy2vo9Q9w6uIQXhEhFyB8XK9QscSWWzAkDRzXfZVuPs7Vm1F66WnLqH/xqrMnOlin9AQNPXT0xszT1FXHgfWP7JDubKXWgZurIoSFcljW+faQ74ZBSgOWypP1SlN85/acpF3P+TxKEd5B7MRp1EUe+jU7mLL2OdAj3txZ0q/UcBMdJYiWGqZjzynrq3kJBtzDCDKDLIv06MQJy1vDChOid7qLxfTN6f16LqqC+kjkA+1JUNFVf9loXA5gsEsTxN3wxvWZ1yuO+2bjQaF80dsOKjRs/QgwJDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 19:02:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 19:02:55 +0000
Date:   Thu, 4 Mar 2021 15:02:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <iommu@lists.linux-foundation.org>, <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210304190253.GL4247@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org> <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder> <20210304175402.GG4247@nvidia.com>
 <20210304110144.39ef0941@jacob-builder>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210304110144.39ef0941@jacob-builder>
X-ClientProxiedBy: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 19:02:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lHtFN-006kRN-VZ; Thu, 04 Mar 2021 15:02:53 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614884624; bh=KsoX4K4P4Z7v42HYxZh2fbbvzalzBIz6MU+YUWvMuh8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=Y/+tXoO5Rv7rqnPPVb03AWjy73eBvBv/FvNRCgbIDCXN7yKhA+No1pWHwflPq8mAx
         ctf7TOKCfllF6lXdt8+8tAkqCHqHlNrCJENCXatL5bK/cgGiZEsysjKJcDc0XGJou1
         dsfUs/WDt6irR+h8HZlKm7VTSOGkYGdb6G54n/TfdTP55oPL9KYIgC+FDVfq7HpLbq
         9mwPWlfwcBQsMrPi8WLRgeXR0AVDc8Xo/Zf7ta5xDj57rp7VX7WHlMZwAeaVnAiLwB
         M6VTBAEmhGfqM0aEXTWGxq0U7pOCOBcvP2IhsmGSycNcs+nm2CSD2yzzezItmtAhxg
         eTpbDFsDYSXZA==
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 04, 2021 at 11:01:44AM -0800, Jacob Pan wrote:

> > For something like qemu I'd expect to put the qemu process in a cgroup
> > with 1 PASID. Who cares what qemu uses the PASID for, or how it was
> > allocated?
> 
> For vSVA, we will need one PASID per guest process. But that is up to the
> admin based on whether or how many SVA capable devices are directly
> assigned.

I hope the virtual IOMMU driver can communicate the PASID limit and
the cgroup machinery in the guest can know what the actual limit is.

I was thinking of a case where qemu is using a single PASID to setup
the guest kVA or similar

Jason
