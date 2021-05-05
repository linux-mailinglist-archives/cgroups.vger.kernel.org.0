Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA68374B1D
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhEEWWU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 18:22:20 -0400
Received: from mail-dm6nam08on2053.outbound.protection.outlook.com ([40.107.102.53]:36992
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229870AbhEEWWT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 18:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOD76tAo0mMmmL21NZe2LxfYajQJEnvmGZbW5JXNgD2Az6L5waUEXiilJsV6W7pdGxOMWH3Ee/0AEV0qdVvLJ10kSlqkvrbofUNZZ9CkZZnFwuyvGmp9OGHFJmS4GPKuwFkAlWCAfsrab04c0nMRcIU9H3zW4hByi8ivpbkoBhQK/Kg0Lw6pW38qAOeSgAwy/S1HkqOobnh9e9e7YRc8DI+mBvmIq1WjdKL1cGl1MehAslOthTgYD8GAbHEYu7GL/HNC6VWO/s1vpMTZUT0Fl3NwWavfolqpKX0phs+TftPpJqGZhCWSNKYGVnnYzt9OEAiBKNo6k9hOnYcGOsfWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2Dr2AfpdUpdq9csMR9KxAzmzXD1M2n3+AilvtRKQzI=;
 b=kCFecC0HSDSOXH1NRzdJjMYBNdfzHNB8WMhzHFun0lpL/q/cSMrmwEKkldaqrrNUkfPyYFGWxDHPKAuUkv74czTknjTPUnf0Hl8hs1MBXILugm0muVXokek05DNl/u3OcPDYAUrmMnkmk8s3aQaQdjfIsg9fdya4rfMMell3jy67F5iBs72RS7wVI2ApVOf9XgLvCN0/KtstZP00XZFJgyaDK0Lzsa5Mja3FQPbsnfAd3H7zQ6LwQttDLH97Ws6edm9+NNx275tHxjuH6VuhVf48Oi6g0srshXwxquy+2zYo8JZDRNdEjjQTLRafMZBPjNEZHjHzhjR8DDijpwHv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2Dr2AfpdUpdq9csMR9KxAzmzXD1M2n3+AilvtRKQzI=;
 b=msOlANKY0aCIEPYZdRVrnlIHSheRbMI2icZ13dCoTtKgHqlLzUI3lTyCUnJnhFY0/X+W6pBhFhNPHwy/vdhsO4vM/4deb8FmHInBn3r4FC3m8c+wgN5CeXZZM481YP4X8j56ucc09zpmGCGS8uwawnHJx5juUZTDfGDOiMO//2XVg8aX1p40wHUrKeFTeao27i4+Vc7DzSbq+r0OEnYw99Q1pXHI4jKCLVLIiSDOK+KbDjlKZn3nOkxDAbkYBVSMQFdebWuNRzF0ljpB299dV05B9DCt04w+sCair+x5Ysat1JWolniG/E3t4CzOoDRXMPDrl/XrjIQdAJu5S/C4vA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Wed, 5 May
 2021 22:21:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 22:21:21 +0000
Date:   Wed, 5 May 2021 19:21:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
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
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210505222120.GM1370958@nvidia.com>
References: <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505130446.3ee2fccd@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:208:120::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 22:21:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lePtQ-001Ze0-2N; Wed, 05 May 2021 19:21:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d6f957-0f4a-48e8-abeb-08d910141c6c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426614F632BBE9DFCDD94B47C2599@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywOqFuCDGCQFvXPrtksyIhy+2fP0MI8r574LNwarFmEfXXhgFjwKT9HYH4q+20QuR587a5mncTPb4qHtX4uwJnliyz59Of2kkakzXwJ3H7r/QexatrlpSUP7ck/yPOOqTz3jiijalCIJ84M71jVivaI7BmTY3XYUyBSbV59q1vju33v+l3t1ocW8po6SDI43rVnmuf+KQzdekDfKIgFnp4ndmvinYL/hAA3lch/v6413yHvlhpVD+ubsXeueP806/3dg+hZ4MiFrZb5nFwOxp/c0XywSrVN/TR4p0eMth5eL+K9EsrumP6mnW3IEaH2Hai6EVH7zxLeLBzj6JLmQw9HR5ZUMMyH/ab6olL5aYpSyKJMaQIWsfzkj6u9Mq8Ian6OA2d+OEfP3NsN6q/uKoRDUYa6cNw0xU6DjmRQnuU7xG2vPBe9bDy0eHWVVCE9BMm69E4PIxQH2AXrVW1Ov8OjB1CqNR11Lc7TcqeEKCbygr6pfNuawmy+NijYbMgcQruyireEA5ZYdbcHC5RkO4Pj9i8VEWvDYNxYvHDPVE8PyXf4p3negvVhvdA569XGZS+J9HpFxya38ja9nQo1xetqos4uuCLuu1wAYKLZA1HA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(1076003)(83380400001)(8936002)(36756003)(38100700002)(2906002)(478600001)(86362001)(316002)(4326008)(2616005)(66556008)(33656002)(54906003)(8676002)(6916009)(7416002)(186003)(5660300002)(66476007)(26005)(426003)(66946007)(9746002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WnVb0wxJXZ6wXAR/NdABVR+AOdJUqBbYfULZMAY34N8K1XMKGEpP9lKCmd5S?=
 =?us-ascii?Q?t7tI9nABbtr+288rsdIGqqrBAwmzrnL3xukodRU+EwU2SuW+B2BuCATW4gUR?=
 =?us-ascii?Q?GzWUkmRtSJ1jaOxzmNHVgVql1D7Cd/8VSJnDWMz4NkzypsSRliEMWGiuZkNt?=
 =?us-ascii?Q?wmlcCZSh61PLVWCpHLCkdOe4w+j3KRh6vgZKE/xjnyvsjxBWOgZvNaziOD7n?=
 =?us-ascii?Q?1y67mvSpmJLUVIoB0VW2dzq4AwMw+ejq5gUux878xQapgXXwNbocQj8KtKbK?=
 =?us-ascii?Q?cquOSmGgEwbbv15mBfeCPKmjoyoy6LvjWnV6NQ5o6OGLO8JGy42SUMCTQm27?=
 =?us-ascii?Q?T41PaViQj1x2lyXTSxVE2L3nVFzPZ9rjrNcRBZJ8y1kVXYWdHhoSS1zE0Ing?=
 =?us-ascii?Q?nNShRtjuxgDm+e2ce7llqju+OybnPnNdH/5jZRCLJuRR9pTIG34DWk83YWA5?=
 =?us-ascii?Q?re9Tj4MF6GxCEELAgyt8UQc/eddfOA4JJ7r10bQF3qBWbrAN5wHjLMGVxMa7?=
 =?us-ascii?Q?iHoz/eOmxK1kdTIsJXbVgCL/MqWIGgygZPBVpIuOU1F/z7GrZZ+woQXx0YyI?=
 =?us-ascii?Q?hiYFmim1Q9UaabPeRcX8baLMuVd3/x/3CFcdpZvD/ZofQ/Hg/Cg73NOAjyHe?=
 =?us-ascii?Q?QsKcDQY8tGuAliJsBe97VC8rmYN+P39orBYdsPVdtxU2GtiOh5QZLPbb/6Xp?=
 =?us-ascii?Q?GQEm7VqPYZMlNWmMjmcwbBhjG34atG3Zwv+z5Y6lSLh8btYYyaC/haU4kXcv?=
 =?us-ascii?Q?Vlob4AgoToYPs2WkhPx5oBniFYb/+t8YJ3nbMmNQSpJQyzuEuHtzFmR4tkT4?=
 =?us-ascii?Q?K2htmPWEoqFDpCUyvaejyTibxgTfl56uvkJDR3gqNubLSDmO5k//yif6yHn0?=
 =?us-ascii?Q?hW6l1tvlfdgz4/WYmGU7heTQTkO+OO7vclI6tibYMGMmuZIgjoQ7ZyUvVy+1?=
 =?us-ascii?Q?v5IDTN4MlSK86NqzM+bWTlMV4mN7kfT8fZv/PFXbHQ/xHs0YE2ENtAnLJIYW?=
 =?us-ascii?Q?u7nB06BdLpsPJDfMa8inc9mJCucTge/4ybZCnDWBAOfGu53tCFISL0dwBrpN?=
 =?us-ascii?Q?WZ3deDYwXOH7S6nqMzl5w4mhfhDOHFDyrGPFgNB71sR+NEk9KrgK/m49krkw?=
 =?us-ascii?Q?ZRljpj3BmjYrPlOKO9Im0d9G7wYs2/Q5og1Ho/pAIkP1Dw707HoWOqFr0yCe?=
 =?us-ascii?Q?Oe+UDcMITN2HNQJ45E2oNzn3iFEWMomhr4HoAvS7i3XI1aNGY8neG7oQDoJS?=
 =?us-ascii?Q?5c3XbpRCXBbDWC31gUQ90oaKvZggAUGrlSAiNSH5KQ4H+igI4I/pSMw7gjDC?=
 =?us-ascii?Q?7pd8MIVozWW5WOm1crSJ2i2N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d6f957-0f4a-48e8-abeb-08d910141c6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 22:21:21.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCY83/h/hneVtwqh6zCWZfDGfTGBj4LwjfgK52T+Oar37F+VEDZVUYKA3j4vVipp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 01:04:46PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 5 May 2021 15:00:23 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, May 05, 2021 at 10:22:59AM -0700, Jacob Pan wrote:
> > 
> > > Global and pluggable are for slightly separate reasons.
> > > - We need global PASID on VT-d in that we need to support shared
> > > workqueues (SWQ). E.g. One SWQ can be wrapped into two mdevs then
> > > assigned to two VMs. Each VM uses its private guest PASID to submit
> > > work but each guest PASID must be translated to a global (system-wide)
> > > host PASID to avoid conflict. Also, since PASID table storage is per
> > > PF, if two mdevs of the same PF are assigned to different VMs, the
> > > PASIDs must be unique.  
> > 
> > From a protocol perspective each RID has a unique PASID table, and
> > RIDs can have overlapping PASIDs.
> > 
> True, per RID or per PF as I was referring to.
> 
> > Since your SWQ is connected to a single RID the requirement that
> > PASIDs are unique to the RID ensures they are sufficiently unique.
> > 
> True, but one process can submit work to multiple mdevs from different
> RIDs/PFs. One process uses one PASID and PASID translation table is per VM.
> The same PASID is used for all the PASID tables of each RID.

If the model is "assign this PASID to this RID" then yes, there is a
big problem keeping everything straight that can only be solved with a
global table.

But if the model is "give me a PASID for this RID" then it isn't such
a problem.

Basically trying to enforce a uniform PASID for an IOASID across all
RIDs attached to it is not such a nice choice.

> > That is fine, but all this stuff should be inside the Intel vIOMMU
> > driver not made into a global resource of the entire iommu subsystem.
> > 
> Intel vIOMMU has to use a generic uAPI to allocate PASID so the generic
> code need to have this option. I guess you are saying we should also have a
> per RID allocation option in addition to global?

There always has to be a RID involvement for the PASID, for security,
this issue really boils down to where the PASID lives.

If you need the PASID attached to the IOASID then it has to be global
because the IOASID can be attached to any RID and must keep the same
PASID.

If the PASID is learned when the IOASID is attached to a RID then the
PASID is more flexible and isn't attached to the IOASID.

Honestly I'm a little leary to bake into a UAPI a specific HW choice
that Intel made here.

I would advise making the "attach a global PASID to this IOASID"
operation explicit and opt into for case that actually need it.

Which implies the API to the iommu driver should be more like:

  'assign an IOASID to this RID and return the PASID'
  'reserve a PASID from every RID'
  'assign an IOASID to this RID and use this specific PASID'

In all cases the scope of those operations are completely local to a
certain IOMMU driver - 'reserver a PASID from every RID' is really
every RID that driver can operate on.

So it is hard to see why the allocator should be a global resource and
not something that is part of the iommu driver exclusively.

Jason
