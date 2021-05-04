Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C5372F9B
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhEDSQh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 14:16:37 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:16001
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232065AbhEDSQg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 May 2021 14:16:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ0Whu7girHzTlFTHZPAO13zt/Fv/SJQvOTzod9K0KCmbgCsscp3PgCcdOgy0urguq7T3MTesnIPyt5qUZO3WTPd/ZkhUGhoBDC7DicVB3QxRlSW70XbU+cn07bz9hZHUemkgQ3WRqWTE9DIhmZ8QOe7QZemVl13Lh1iXmCJ/YRLox8uhCMfONtO9EO5wKbP23h06dNGgSslAW7usyj49U1zB0wUC8jVn9ZHvSThczqi+ZyLES7dingIIVeFBpPxEa3MXDaRHokewZZA8sJ7RvEjjJQ08yjxTUbKcPng1/P2mGdJMhJfBEAe0xsDl2XlSo0Q7u2ulLgQ9W2D2KVpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y5LBuxvoAdlpVsPJcxB+aQUIOpbP6uh5nSiQXgl/0E=;
 b=WJeE1jEw2925rZTB77WNUGJKXw+D8kPnQ5GSC5rAzBJVOdd4BrrZq2udmtUr4n8Wk7Mb7z3JY8nsWTPXeSl82qciXjZ1EwmNQChIutt8weaDIDxtjVWj7MttL44+/eKc7TSrz2lvBBNJ8bdXnlL1IQ4vKNjHrW2WJIfHHxs+shCHWOqZW/UbEVC8/Mll1PE9B64LPoLV7YSNKhVxAau8IxBs5l24RkWnJ3jkmqzgLIGyXKyIL/9NbXURhDwL4+ptQZusB+KuwiZ/Z9i6jPHkmoWrY+J2vpxSWxaBTqm+utWJuG0J12jCwN6rKYLXEJs9gzu772Ax/RKiQ6zEwZp9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y5LBuxvoAdlpVsPJcxB+aQUIOpbP6uh5nSiQXgl/0E=;
 b=JJPbmrj6tt56D+I875gNIus9d4K1FyTxypTHKZz6wNrp0RfaEsE05xFhcikU651qZ6iL+/KhIrneETZ4Vwv0S2R1Omfz2Jd2Z0FNPhOt2xzrOBfBDDzid/SQwiqIpMSwFSswaSVY/9knsYodKTF0Qx/TogWfUAtnYxHBSSh5AO7b7SmNczvxocMlo039hNeGBlSjJSDmCT+Xs5rdQzTfbQiH2iX+nE/V1TomXR74uttya4bxVFHDxfEu38ZDQ2dheoU/TZHJ47sU4BmIkJ2m6mEi+CiVFZAD9s8gXBawmIjwHMQTgyfN70NcVbuLU/xKuZuMoQnZynoL7IBNrpXuWA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4017.namprd12.prod.outlook.com (2603:10b6:a03:1ac::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 18:15:39 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5%4]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 18:15:39 +0000
Date:   Tue, 4 May 2021 15:15:37 -0300
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
Message-ID: <20210504181537.GC1370958@nvidia.com>
References: <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com>
 <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com>
 <YJDFj+sAv41JRIo4@yekko>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJDFj+sAv41JRIo4@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:208:19b::29) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR19CA0052.namprd19.prod.outlook.com (2603:10b6:208:19b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 4 May 2021 18:15:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ldza5-000XWm-5X; Tue, 04 May 2021 15:15:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d90076dc-696d-4698-9eee-08d90f289ef1
X-MS-TrafficTypeDiagnostic: BY5PR12MB4017:
X-Microsoft-Antispam-PRVS: <BY5PR12MB40171DA09B70535BF32D3144C25A9@BY5PR12MB4017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOPjDgw0lWgmDJ8ikMp3ES9zuv/pRPnFnJXfysS4lCW9K/2Hh8rEbY0W7YxpcKzVNY7XF+Qphg31Pq9dC2/f+S1WTF/iJ5wq67qw6zhUFE/51e/iAhof/F/UOYyaIqMHfYCuuG/sbazSO/9GV5gm0qrYMp51zcrSWw0MdP8/tARaPXvBHHokAzkLcBaA7lr6UAhxZ5JRaBpI3PKnLzCZ7XmhcMxn1NZwgNq9L69f5Dslrny22ySbVEVVqtJbcZ/PMJI49fZSDS1ngfE4MxtyDD9Mw2SyEZJ0ZwsDRuTG0wPhQ5B+iFg7SkP8y1nYN17ZRNloRWRD25Fppd/E3MWXCUNME0ek+jxl6qS9xXelSyS7uzVoSB1zdtYEx/athQKojqUjckg/HjkueSRZddfeyR9QIphApkM/yUuc1/+29x7gLe45ECX46eqZotNOu9UPWEnMnlBq7Fe3mJpa0FLlq4IoXQx41QdrGtB2mugUEqDZ4UaaD6iszzzx5QmVEZ+dBmYtST9fB77Wr4gDwalA6vnN/vmFwlmV3QgIoAfLMNSIelcI31oYgwj/nAecmz4w6QIN+qzAja6UYUGozPgrd0wBM2fLRGtfQcytHvwrZb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(2616005)(478600001)(1076003)(4326008)(6916009)(426003)(9746002)(8936002)(9786002)(7416002)(38100700002)(66556008)(86362001)(33656002)(186003)(2906002)(5660300002)(8676002)(54906003)(316002)(83380400001)(36756003)(66946007)(26005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n/8AEZmA10kdBiXH7aUAKYWVgg02s365Z8UpDFyHtteM5MtZbTHqHKSHwlkh?=
 =?us-ascii?Q?BTNK9+fqOalOgRNqzF7cD3JvdwRFNzqRoBLwcahPvwlRaoDR+I01W/1NQXoN?=
 =?us-ascii?Q?U9Y3pq0ysys1qm4lHoIqqueGrzMAPO4j7uu2XaZqMQv6cKta25O+4OEwzzc6?=
 =?us-ascii?Q?AWS6aElwXuISe8kwtyeQbBlaLQBPeWbqIcnXcmWtpY/49TdCgigeQzSRl0do?=
 =?us-ascii?Q?cFG5RDn87P8XiwhlrfzJm+A6FFnDLFvEwe3IZ1dVj8kK2M0cDsecfGlWjg8S?=
 =?us-ascii?Q?+GPUlNGUL5ENh59gQ/XVh49BbcOMHydvHJQV0pVd0bWzJuLLIt5l6enq7MCf?=
 =?us-ascii?Q?sz9q69YyUJsqiEptL+W0kvCF44tIvHmqXvYpKfTCt27VTJPqg5C6svqjimA3?=
 =?us-ascii?Q?I3ZElzn6atdmxx07qQKkq9qwrsyDPeKIKxq/+PUgl3IGoCrpQsdvd2CWQ7yO?=
 =?us-ascii?Q?mwF717gk7CO5piUJAAgQAgialryXmrKR9H3KLR2OA4Qug8LQc4QCDETEtzQw?=
 =?us-ascii?Q?vol3CdYQ9bJxl6DJLjFAIRuhiKIvIIo52Hk6WEG5TWuX7C2T7RkVrNwrr9jn?=
 =?us-ascii?Q?w4vWgzZEiao+7BWtGkuWDIkbXa6/YZea33dLY0vPi45cVGyiQziG6oEcmKr5?=
 =?us-ascii?Q?sFYyf18ihOUQrjXacPGaWsbvMJA56039MzOVxWgbaSL1OY1qOh0mq9STasKm?=
 =?us-ascii?Q?eAnnBu4eoOO9aO2D+CekBk4wFGyBQusYjpC68xRBGX8HEh4L57mjnz9l04EJ?=
 =?us-ascii?Q?OyMPkYnziUFSt8iR5pM1BgqR+l+pjAKm/9VAiYu+cTq9BGzC+5FeVZGjfvQZ?=
 =?us-ascii?Q?xymoSDJPWTPKt/yQi/9e0gUi/mnfKMcGm55lnoiLl9VLj0OOLAfXKfis/0YG?=
 =?us-ascii?Q?kpF9wvEdjGNONho4RL5BA2NHdsa8307+eugJp7FeB9VWPexaLIiHRQdyKh2q?=
 =?us-ascii?Q?NYnT6vzoyf0htJ48JLFkLgio123R4fEuHHaWeC1kY257rttHbPIakjPaA/sJ?=
 =?us-ascii?Q?PLVlhuYA4Euo4i7sy1FpLJQK9KmB87PHHIXsxQVL+LrXClct/NOXZ/uaX5R4?=
 =?us-ascii?Q?YXzM05Fzt0egVJAXx8rUX+a8LaWX7KfSI4H8930nz78pz5QA4F7iXbgtxDI+?=
 =?us-ascii?Q?F/GV83upK5/+PFLYLIB1AwFFL1Bp3alBAzr1WuPiAgsWnNMO4ZKqL+phWF2k?=
 =?us-ascii?Q?XdJhCgCny7/GUvJPBA5jhNra6bYn4sm+WnC3VG6sWUqirypYiSKFQUnI9xuO?=
 =?us-ascii?Q?0uibwDx/c0qHQodMq8Vroml2i5HP2DoXxLc8FD2tcg5Gc7x1IU/RivNWRGY4?=
 =?us-ascii?Q?f26YclGZuDiuWHoIk8RPR7ZG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90076dc-696d-4698-9eee-08d90f289ef1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 18:15:39.2517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VQXABYV1wZq4FFdbY6vghdv478AfZemBsk2gD8a4aKPnG842gx7rlqHj1oQobOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4017
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 04, 2021 at 01:54:55PM +1000, David Gibson wrote:
> On Mon, May 03, 2021 at 01:05:30PM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 29, 2021 at 01:20:22PM +1000, David Gibson wrote:
> > > > There is a certain appeal to having some
> > > > 'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of extra
> > > > information like windows that can be optionally called by the viommu
> > > > driver and it remains well defined and described.
> > > 
> > > Windows really aren't ppc specific.  They're absolutely there on x86
> > > and everything else as well - it's just that people are used to having
> > > a window at 0..<something largish> that you can often get away with
> > > treating it sloppily.
> > 
> > My point is this detailed control seems to go on to more than just
> > windows. As you say the vIOMMU is emulating specific HW that needs to
> > have kernel interfaces to match it exactly.
> 
> It's really not that bad.  The case of emulating the PAPR vIOMMU on
> something else is relatively easy, because all updates to the IO page
> tables go through hypercalls.  So, as long as the backend IOMMU can
> map all the IOVAs that the guest IOMMU can, then qemu's implementation
> of those hypercalls just needs to put an equivalent mapping in the
> backend, which it can do with a generic VFIO_DMA_MAP.

So you also want the PAPR vIOMMU driver to run on, say, an ARM IOMMU?

> vIOMMUs with page tables in guest memory are harder, but only really
> in the usual ways that a vIOMMU of that type is harder (needs cache
> mode or whatever).  At whatever point you need to shadow from the
> guest IO page tables to the host backend, you can again do that with
> generic maps, as long as the backend supports the necessary IOVAs, and
> has an IO page size that's equal to or a submultiple of the vIOMMU
> page size.

But this definitely all becomes HW specific.

For instance I want to have an ARM vIOMMU driver it needs to do some

 ret = ioctl(ioasid_fd, CREATE_NESTED_IOASID, [page table format is ARMvXXX])
 if (ret == -EOPNOTSUPP)
     ret = ioctl(ioasid_fd, CREATE_NORMAL_IOASID, ..)
     // and do completely different and more expensive emulation

I can get a little bit of generality, but at the end of the day the
IOMMU must create a specific HW layout of the nested page table, if it
can't, it can't.

> > I'm remarking that trying to unify every HW IOMMU implementation that
> > ever has/will exist into a generic API complete enough to allow the
> > vIOMMU to be created is likely to result in an API too complicated to
> > understand..
> 
> Maybe not every one, but I think we can get a pretty wide range with a
> reasonable interface.  

It sounds like a reasonable guideline is if the feature is actually
general to all IOMMUs and can be used by qemu as part of a vIOMMU
emulation when compatible vIOMMU HW is not available.

Having 'requested window' support that isn't actually implemented in
every IOMMU is going to mean the PAPR vIOMMU emulation won't work,
defeating the whole point of making things general?

Jason
