Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA82632D915
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCDRzZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 12:55:25 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13860 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhCDRzA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Mar 2021 12:55:00 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60411ecb0000>; Thu, 04 Mar 2021 09:54:19 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 17:54:17 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 17:54:09 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 17:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFzBJNXY6UbJ/0hFzyMbTSaTEiaaIG8u673XhSLntGj/ZQvf2tO8JVCBI9vA3e/1IwPPmwJXsA7OGgHvvkWlC4sdWVfCzBitjbpsDCzlkUmWtPC8kP9wqrsS2uj+8F+dCAC4Z0mpz8TmlEQP4pOwDVB8L//dvduiG0aHNmjWkigNkjJ1ExSGEAbCA2iSy4RF24rj4eErnTzAgMrqJurBeCQgIgI4hADmoquiUq1AmrrD/W6nHb0EpDDEiHA2n6jZ+yu5+foiZwpwVniFtvSKxe64JX77haDnPIWMTLMxx4aed3UPEFrmYw8YYsUzTQBntNMdR45js297OJLiK5gyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IsSiLJgMTXbIalwO2pbn+VbK2Xk9986eGeD/lKT7yQ=;
 b=BcYW/bq6+Dl2EjG+9BYRDu4AXEkJIBQMYE2o7RTd+ZBcCzgdqqz7SjYOdjr3d29+h7CveoaNcDnqgxXes3HJ2Cuma+vdpSTaURaPch0c5TiSuWeSWoBnmQzPuCnFkj74DtpkWK2t41MhagkShu1mqBjAzNgDIbjBy7utHsGP6r/gjEyfPrXV8pr19fqJkbti7ZZwqnDHxV4drhN+fGeOmFq4GbFzBz0nMuE3Amzs/I/n/QFI5O6A8E0ecTNYMBlxMqzO3qXlnhaKyUq20qsqJ1yCoXEa+vCXAXSauebqq56/ULnFF3LPOp6oOrjax7oHiMvXmM9uvthNkHX1baeH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 17:54:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 17:54:04 +0000
Date:   Thu, 4 Mar 2021 13:54:02 -0400
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
Message-ID: <20210304175402.GG4247@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org> <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210304094603.4ab6c1c4@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0375.namprd13.prod.outlook.com (2603:10b6:208:2c0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Thu, 4 Mar 2021 17:54:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lHsAk-006gQJ-Ue; Thu, 04 Mar 2021 13:54:02 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614880459; bh=1IsSiLJgMTXbIalwO2pbn+VbK2Xk9986eGeD/lKT7yQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=rDYRwf0dwRc+djrxenqKoY96c9s8HF7iXjhjlMjLqhK7AgVH6nhHtLXOWqj5t6afh
         lRlLZiPC9KLV1CRT6m/HH8hUjiKj4J/qgp8jy29CLE3yY/zivgM0gAL0fTyY7ItEUT
         gAHQeIPZwaga7VM1F/4FXVNfUxC9hE0ZV/HL6apEPfv9s9IMJczvXmjfAiVzbLcjWV
         wbkKRvXO0p6/xkWn+ZArhyau+4P0VUr//MMXazPjODaYUWG7gFwiCOOvQTvKXFiK0q
         5f1xa+nA+hZu6N1SC31B8xRv1PcVkOgp9v2jnkOhuNTtx0++k1MFiF/khEFzvPqp5a
         1uWiZtwPm8+qQ==
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 04, 2021 at 09:46:03AM -0800, Jacob Pan wrote:

> Right, I was assuming have three use cases of IOASIDs:
> 1. host supervisor SVA (not a concern, just one init_mm to bind)
> 2. host user SVA, either one IOASID per process or perhaps some private
> IOASID for private address space
> 3. VM use for guest SVA, each IOASID is bound to a guest process
> 
> My current cgroup proposal applies to #3 with IOASID_SET_TYPE_MM, which is
> allocated by the new /dev/ioasid interface.
> 
> For #2, I was thinking you can limit the host process via PIDs cgroup? i.e.
> limit fork. So the host IOASIDs are currently allocated from the system pool
> with quota of chosen by iommu_sva_init() in my patch, 0 means unlimited use
> whatever is available. https://lkml.org/lkml/2021/2/28/18

Why do we need two pools?

If PASID's are limited then why does it matter how the PASID was
allocated? Either the thing requesting it is below the limit, or it
isn't.

For something like qemu I'd expect to put the qemu process in a cgroup
with 1 PASID. Who cares what qemu uses the PASID for, or how it was
allocated?

Jason
