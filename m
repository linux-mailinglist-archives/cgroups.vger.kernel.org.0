Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5027C32C8FC
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 02:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhCDA7s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Mar 2021 19:59:48 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16851 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385319AbhCDAYr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Mar 2021 19:24:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604028a40004>; Wed, 03 Mar 2021 16:24:04 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 00:24:03 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 00:24:01 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 00:24:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC/YMgwRwCj+g0AQ/ccOrHyQx+tFwXw8tlJQ8202xjfgo4/pFAxkgnanZqldWT6FoGjcpece26SkQUAysYxnsM1EUGUb/hLGvJWKtvAh9HMf8ASIV5/T3AAhSSngebbMDPXvVxXyBduy5X5cEubj09V2e7FU0i2gBr67xrC0lWqEyBI7LBVI4+osA94Pabc9T8B8qfpnwvcrvKAyy8C8rb7A4E1GQwkoJev6vtvbkhLZiGg+vQWJjpM4TedHTwbd4gwPCTGwAj/mUuKagVzoUJXlh402g621bIAlT4HvFyvL9doNjr6sHoEjzaWMbocfT6Oas5+wLEYHWEPyrYMUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIwvvpE4wGoBAdK1+JiL6a3DRIITWKYkTYWOnUwBXbw=;
 b=cu/A7RwNZq1If5+l3S3xw1fS9qVbFqEPm7o3kybtRoAPDhQy5S3wWlk4QY7CW4/BV/Q/u2W4VD172xbwFuN99P3LCbs/Ghl3iUc+UvKC8kXpFZyoiYVa6U9csSrVPtyXM1xwpIjhBrDz7BnMpRrIjUaLBdsSfqhY8+vOzz8NFj0BSuYEWUMLRsEyZZ3LlFplk4ZZebkoXlBEwHElXrPDt0/nf5IO3rt0G5QWslKrmN41qVyYuS4Wp/sRp06ihSMLB+ef2mgvGNeGN4BRvvWC39niNFO1BkrOgG0GAx2T+ZbR+ufW6PMKEu29xMxiN6QWQd6b4gU2Ck5/DP61q5bt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 00:23:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 00:23:58 +0000
Date:   Wed, 3 Mar 2021 20:23:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
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
Message-ID: <20210304002357.GY4247@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org> <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210303160205.151d114e@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0095.namprd13.prod.outlook.com (2603:10b6:208:2b9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Thu, 4 Mar 2021 00:23:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lHbmX-006O4j-FM; Wed, 03 Mar 2021 20:23:57 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614817444; bh=aIwvvpE4wGoBAdK1+JiL6a3DRIITWKYkTYWOnUwBXbw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=C3fjXaTiJBKO1GYRDJrCCxB7V2sCABjNAU8GwkVL7OgiP2eaQQhwz77qemjqv2HWG
         Ur0ALQQj7VoRWcK74JUXIAo6+w0CUQ2u7PuU9l8jvnXVeaxsaHVpuaPCrjjM4R1043
         QNxly8dOmrEdVq7/0RAaTXgjlA1cBCIqoiugq07vYKnuQ8YkPJZQtVFihRibWUvyQX
         sG7mW0uDkK3pgJouCW4jfadroRjQvwWwZr5oe10GAXxw63aopaVF0YCsKuumeLEyx3
         UmYjK/zIitVVODJ0TossHZvjZq3g3/chw/RpLRUQnVTSwaV6tqQdk5D1PTwhz6ezUN
         QRd1sctf32nvg==
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:
> > The interface definitely can be reused. But IOASID has a different
> > behavior in terms of migration and ownership checking. I guess SEV key
> > IDs are not tied to a process whereas IOASIDs are. Perhaps this can be
> > solved by adding
> > +	.can_attach	= ioasids_can_attach,
> > +	.cancel_attach	= ioasids_cancel_attach,
> > Let me give it a try and come back.
> > 
> While I am trying to fit the IOASIDs cgroup in to the misc cgroup proposal.
> I'd like to have a direction check on whether this idea of using cgroup for
> IOASID/PASID resource management is viable.
> 
> Alex/Jason/Jean and everyone, your feedback is much appreciated.

IMHO I can't think of anything else to enforce some limit on a HW
scarce resource that unpriv userspace can consume.

Jason
