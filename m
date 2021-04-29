Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E2936E28C
	for <lists+cgroups@lfdr.de>; Thu, 29 Apr 2021 02:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhD2AWl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 20:22:41 -0400
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:17614
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhD2AWl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 20:22:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS7sPbgnaKeSWCNqoibkY00ZBRGFITJivwHatChRaMWSHjZg8LyKoVQK1iuhSwDsvGd21GiK5yfwGuFg4nA4uNia17dCoP0AURPqfHc/KSjGOAZmiGKyh2RGSst8VeGvSVLGuukRTfSXW8PJb0StaYypeJqlpsFktHhVJ1E8FxivJAAmqe/c0DaE5wTXS8SwsCg4Czydk1vVLxheufc8xot/kgmtoL6/3aqoqWM0UOdG8UBguBepBfoUPkKzuGaZqgSyzIkgWPQvh+mI9dEYurfrYpWxdCExtxRn7KoGmCI5jcOjnEq16gkn3hscmWSXdgHObHeMUdopBOwq2WhdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf0FFjCU92BRz2ovOAkN3QZk/lQx+XcNXHCwnSKh++g=;
 b=CBgIToG5XByhVyQM1dNYH6jNzM3HkBrnb0LPp15KEwf6ZC8aKLWEnm9fEyKEOnPB2ClQIURVC/ExMaL6/rIQbZlUbzcGT5Vkbf1/1rSmcsquelJnfGuCuyQy/ZYxmHud78YVHi+tSWQGWBxSuFB1NWSS8zV0PrrTcJXEMq9JYFU3vCtaPU77lQdthgJ+NgY7tFMJM5UZUpwVxa4DpwvSeTUbMuTSpbXv5JL/ENDCEXqMAfO1RgcBhVkbLSpH3LhoSq0Hpi+p9uxTwbkLTj1qcIhleQZq5LrbAgncIKKV1tAhmxxGywEweY2RD7A8m7LqBDwNxuBuQCOndm9v8sA4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf0FFjCU92BRz2ovOAkN3QZk/lQx+XcNXHCwnSKh++g=;
 b=GaacGmeHXHXdN4305GmDC9fhEkaja/py8uRlvHrEEwwsKUMTiybDxh/0Iwtluf1yOx3zhjjUc4wDpDKLd26gXqzTyGExzjDDxOiC0EAHHEs7CXlL+UCCNf8VqmFpyOTSquC9dXGqVbI0CuuzsgEVOhS1f9r+y+xW6DZsheGh+FaRmMYY2BENJaXAErnJJaAXaz+eWKvuT2CI+FJN+6d2nl1WgHaNDv8281oumsOQNxMu1lbeOLLmW4AkbBiTUBVvUViqWzTm1CxEvIyk9v1YwhnIZajir2Ia5lWNZn4h3IVfgS4e2WgixF4HKs2hVkt3WtA3rW+bx10eMhwNTYO1xQ==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.26; Thu, 29 Apr
 2021 00:21:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 00:21:51 +0000
Date:   Wed, 28 Apr 2021 21:21:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210429002149.GZ1370958@nvidia.com>
References: <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:610:e7::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:610:e7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend Transport; Thu, 29 Apr 2021 00:21:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbuRB-00EBit-69; Wed, 28 Apr 2021 21:21:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9fdf923-15dc-4f02-02cc-08d90aa4c89e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24881597FB48B2A06E953EA9C25F9@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo8fR49yi3kCjzFWPZ2oOT1M6N0GLM14o+yaERjPyv2LTgAERBKOSJoWdDHh8LZMDeS0+gzvuBdEes9HCIQXe5TuOBkXngAXH3Xb5AyNFxGSgHW0o7hH3oRLr1QxXbAaXrnRxsDe2xOoEVZ4ykL2l3oiyM3ysZxouySDxCJY7+XegD1aegBAOTElCxidIYeJgK/4qKQ9NjP7oR0ZOdp+IuUWbVDD8Ee+HE6w0WUf0KAnJUz9+oJZnzMLaWHF1TM5WIz2w20/lbU12/0hv2AtLLGLMD2hAoe7tDzQ79JHrXffcJ9SoSRpWg/CpLgJ3pF+Fj+iCYFo7/svrqi5giJFnbpTXbJj8Gr2afgXEfJorBDFLU1UQU4dtZfdM4PXhugppHY2P152zM5DLOCmD4lqeDrzyXq/cS+ScVDNUkA601l3XJrJFHFOVR9mmT/MWJV8tmkhG6bCXcoTbVnts4kKeIHDzJ+htV6HOxq/scMZ28AiDe4qfXo9LwJPuRc1LDdMnkAk4yF5rTN258A4ZjjT2rSuoltUnNQbC9O/XDElTMut1JNfYais+kyAsta6m0SGf8JGthV8d1NW/mPgH9xc14/kRLYOsTWfEeoHF/19BV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(8676002)(5660300002)(186003)(66476007)(6916009)(38100700002)(2616005)(7416002)(1076003)(478600001)(4326008)(66946007)(33656002)(66556008)(9786002)(36756003)(2906002)(9746002)(83380400001)(54906003)(316002)(86362001)(26005)(426003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4FX0G7It+4VDVHMZn9i/576PMlClUT7EOpVBK33esO9PG5V5tr/Q3Rme5vR5?=
 =?us-ascii?Q?v9uX/0zHBFLMc0vBb7+blNYcPcGdO933xNGKLNoeuil0Qx7gFn28zxtJtS5T?=
 =?us-ascii?Q?/XmTqC4Bw7PJZ5oxjyi3fnif2TrMl4i6JbiVTCMjw4nEcfDdXqsXhzWsog7z?=
 =?us-ascii?Q?Eki+B5KtzYRPZfHtZoph58f3aCNUPnywdzrhVRyDjzcb0qAkab729D/Ise9Q?=
 =?us-ascii?Q?dA+vjb0XDMAeydovMuIfhJPgunboc9H8SuiRaT5ooeNRsL5YhQ4KHnlPcVez?=
 =?us-ascii?Q?TwFCGt6sDp+Ytn8As5NxKjaS1DZuqwpQiuIAarMoldNTcNEtKYRiI3oKRq6G?=
 =?us-ascii?Q?GFIpB7x+Q5LSRHQUWQuNoPPwNbkhTe2QmpQ8sf+c7r3nQMNws/kxdZviZEu4?=
 =?us-ascii?Q?+wwXzU+h0/J+oOj3YgtzbXC/kSZVntI5inNYooc0CauqcQ76WALWqJJXWgG1?=
 =?us-ascii?Q?3o2aM3Z1WHE/tHZLsGfLFImNc11BpjFdrbcDD/86H80iJ20vy+V9LPgYt+Tz?=
 =?us-ascii?Q?nuO7UPBhEsZzx2lvPgqV1qROGvHtKA7FrIw3JcPMhnNWqcyzB48YXcGgTNyA?=
 =?us-ascii?Q?x7WprD4nSSJMnJf1WWDHHS/jrJ5o4OUV9lSxtAQ35lzYqwWIv1OkyLFyypqi?=
 =?us-ascii?Q?afMKdk7yJIMbZ1gdhmTB7jS+R9x7wu9afXA2jzpWj7mVB6j4Fr9UxcGCFktv?=
 =?us-ascii?Q?zWmtmAmkKRW3wR3KgvKNs9ptZ4v5B37QzybtRb9mAkiyA3fwdkzNWV2SqQSJ?=
 =?us-ascii?Q?k9w3o8+6kNSJWoDpBP41IGfpqVU7gWm+PoSz3nv5NmHGfjhDy3GqkhjDrLWe?=
 =?us-ascii?Q?PkOyASvKtR43vYRkKxVj2V0stgwWHMw82wXWyIKkfO12hwsGdX5R/sYmeaiR?=
 =?us-ascii?Q?YSxGTttpPI6+Tw1zfPRz0F126svE8jqxU+oO7fasskZt9fzYbW9f1xfxfd90?=
 =?us-ascii?Q?EXb+gB7GL4SPtYr2dG8ES54Z5z8avWnmBO0tjKKKX+xSQJpad4NvhgI+EMTK?=
 =?us-ascii?Q?a9fDksS4ZAncBDHt6qhs2F7+CIUM8um6h13t+rI+GypNBUCZSL1t53IHZpec?=
 =?us-ascii?Q?36Q+BaTKenNCTk5d1khQQzBaHxTQEdiffLuVDqHN+AyVUoyL9eKHMaUjxIU3?=
 =?us-ascii?Q?TQz/DkC0veZHEhHc/sUve4cnxw5QEZEEJ7fbdqkYl7CtQCpRjt+LOzwCLHu1?=
 =?us-ascii?Q?nBda1+G4wIHuokjL5q53MemtPqUbruFiqAxFgB6BzYR3f2A/+kJsNZO9yfyi?=
 =?us-ascii?Q?ql2VPyJrObiCo2Uht1lqHMsSHMnXoicX3Gvh5B3DgC9dGxFmiLlelT3gsjbR?=
 =?us-ascii?Q?pRZX39rX1pk2epnuv6Mdv3tX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fdf923-15dc-4f02-02cc-08d90aa4c89e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 00:21:51.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqAp6mCPI3DLZ25edwwiSFCT2yxO9hu3GeqaeP6NKlGrvMW3fmazvbXTsPy6iFJ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 28, 2021 at 11:23:39AM +1000, David Gibson wrote:

> Yes.  My proposed model for a unified interface would be that when you
> create a new container/IOASID, *no* IOVAs are valid.

Hurm, it is quite tricky. All IOMMUs seem to have a dead zone around
the MSI window, so negotiating this all in a general way is not going
to be a very simple API.

To be general it would be nicer to say something like 'I need XXGB of
IOVA space' 'I need 32 bit IOVA space' etc and have the kernel return
ranges that sum up to at least that big. Then the kernel can do its
all its optimizations.

I guess you are going to say that the qemu PPC vIOMMU driver needs
more exact control..

> I expect we'd need some kind of query operation to expose limitations
> on the number of windows, addresses for them, available pagesizes etc.

Is page size an assumption that hugetlbfs will always be used for backing
memory or something?

> > As an ideal, only things like the HW specific qemu vIOMMU driver
> > should be reaching for all the special stuff.
> 
> I'm hoping we can even avoid that, usually.  With the explicitly
> created windows model I propose above, it should be able to: qemu will
> create the windows according to the IOVA windows the guest platform
> expects to see and they either will or won't work on the host platform
> IOMMU.  If they do, generic maps/unmaps should be sufficient.  If they
> don't well, the host IOMMU simply cannot emulate the vIOMMU so you're
> out of luck anyway.

It is not just P9 that has special stuff, and this whole area of PASID
seems to be quite different on every platform

If things fit very naturally and generally then maybe, but I've been
down this road before of trying to make a general description of a
group of very special HW. It ended in tears after 10 years when nobody
could understand the "general" API after it was Frankenstein'd up with
special cases for everything. Cautionary tale

There is a certain appeal to having some
'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of extra
information like windows that can be optionally called by the viommu
driver and it remains well defined and described.

Jason
