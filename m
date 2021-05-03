Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C71371900
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 18:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhECQQQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 12:16:16 -0400
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:27969
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230518AbhECQQP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 12:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdIZzBeuvF0g7hK2h2M2WvH+V0VgQokXPTDx84Wcjt298/eGUzg34j1YF07ptaGgYKpNyfxfJavRYf+TNWV7YSkZqzkD12CMCDkPoPQglWxqCXaWsRKMWyl3qbtTNBV5uiGYL9EThOkMcv2xR5Qidu9qZ+iMQt7eusyEvSYhM4eg+j7LbpvLVMsWAsa5R+RHdZNnuwWS8Iu87oV4ghWnu+doKuri4arwMMmvFTFk/s7QkmW4jOo6p+7kswq1b+v+PWKswN+ulbolhYrs5bxjO6TvXHuk3i+aWSvQE6vwKgS4vbYF4BZrMURSpI7tGXYW+wrz/LKcMNLlFyqMzc4lKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsrcXyE5y/ppPoLuMeJMZjpz7sz6aBREBdV0KXEjuBU=;
 b=hbv4g7UhiaGB/zHm3VU+7AX4rITVzoyczr3DzbRld5ACBHMXGUWTdOETzW4IsIUUlhDF14hoBqWy+gyuA1KdKCN8eSeSN3qeZyF5UxykL3MtT/4KZ18+qdEopQft/JlHKavYubPOQgUl6urORCfS2syRniTfEoLaV0zqRZvHiHeTcTUX4svXqSnPoUz/6a/siL/pALZRv5WqzbRxUZGMDVGxsRTzQf6mH+GlGhi3UwqUatmoEAH7XYoSrEOI/ud3iBK0IxakzsoHUanBcv2ab5gXE2e1A3+Z4kdz0bh8oh2yfEN5yYZyIksiGxImQfBy6h/Xic8EzfzqmSU9AzgHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsrcXyE5y/ppPoLuMeJMZjpz7sz6aBREBdV0KXEjuBU=;
 b=fhriCLjytOTxefQIyrhGbxw7ejvgWd6ZiYWgmDDMtZmMV+6Eg1P1xNKxzjQjFlePEh+GiE9mBTQcq9+FODgn2LFTkGJC9Xs7TnlOQMV6l6oa+zoNY91QrQUW/BU9clqqtSjtcAMG6LMbaTgJWtsL8UMbkWPdNeEjN2q85vGCgqPcHUkvxWHbhbKk1wWNa5kVqYryQj5IvWMG7zrkBxUXmeBphrY97cAu2M2JPvsDTHqAiynJ98SKRdJxHuJTT+7hEfwQcD4We1tdsYjfwpp9Fc0TG0N3aEE28TW6T7gg37HAL9kpVHvCQoI8CEfgo50XOrMjiCqAG8/csCkNHDhhRQ==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Mon, 3 May
 2021 16:15:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 16:15:20 +0000
Date:   Mon, 3 May 2021 13:15:18 -0300
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
Message-ID: <20210503161518.GM1370958@nvidia.com>
References: <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIoiJRY3FM7xH2bH@yekko>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:610:e4::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:610:e4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend Transport; Mon, 3 May 2021 16:15:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ldbE6-00GO53-Vy; Mon, 03 May 2021 13:15:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d92f31-36f5-44a1-e285-08d90e4ea5dd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4250EA34963AB196A100A579C25B9@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNMkxlz3Km0BgpGBZRVE7mVgvV73+p4jwTEctTJvlS8RzpJUB4a9Bc0BZRbsx++Dz/bxcdp9G/exJXsbFIUB8hvQGYGTjvTkvTmP2OkidManKQQLLNRJzR7AbI5GtYj4qVj1SJeKpyTxyJEbYe/3Ux/csUpF2Sw0Zz0sAITSoBp5xs/X8D+qXg6td0IUdzQhO0t0PwmFNurNW8P1jb2mn53osJ898+H5zMkzXq3pc30kvodf9pkJCdv1AecqTwpX72PPvgvXLl7/dY/NaKYda/tBpSN0fb9w/uDQTlML3FOqPO22h1dvcFaUZDaKKQpiqI8v8glF5lhH1lxNdDGSBnPG+dii9wG+DaMhHXPPsXGRT1YY00Bnws+vHhQuK10XonUt157NlyQJtThy77yOGzOiP1JyNPMi56nusGBrIJ46ao8oyWK0ibdVFcHnSYom1aSXInFjnda2tjgGG6bykI3KPqIMzwTqE7UmO0WmGLk+KLhVdEl8OlxPGqwkWayBgBBjkJKT+xetanObmPeefOwx+L5bpdDFORlxXlr7SWG+MsaH98RKTShk4O0W2xI8vb1lDg8+ieLf0rt7eezbiyledGx2h0GOSmmu8jWUfP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(316002)(8936002)(2906002)(83380400001)(36756003)(38100700002)(86362001)(1076003)(478600001)(4326008)(9786002)(54906003)(8676002)(33656002)(66556008)(5660300002)(2616005)(66476007)(426003)(186003)(26005)(6916009)(66946007)(7416002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lIgkwEH6PEuyKHnAcH6I3GHJIjaMYQ1VPzX1Ba1EgmH44MucOQiwr2NpocRD?=
 =?us-ascii?Q?zyIewNhKLsJODR/hDiM2PC6d7pAabsP6aWYCmZYDgygYuN6kAfQjT9vSXBRq?=
 =?us-ascii?Q?zfMtK68kugF+fauovX4Rfq/U03RsVv+iXKwcJZlKHQ6TvBuIKlKjtmKlTN73?=
 =?us-ascii?Q?KkcW7Lqts25eiiTl0VhWtfC/VZyvKl+RZD2F+6wpezVU20crH0xG1uH3AKyb?=
 =?us-ascii?Q?5IhqYmkc7iAW1M+3In1mhKV1TjRnE+C4EC5+ET3tjcOzbArMpfoYdEN/vWCO?=
 =?us-ascii?Q?tXJvfzSO16uShIu76riA6hnySrnkseDuTrBOV4agO78szktAC/HCTClMSJCi?=
 =?us-ascii?Q?3EDrhAsUsbZehm+bytNT106KNw//4GC34sKiYq+0RV3s16/aS7nuoyZ+Ouga?=
 =?us-ascii?Q?Ss9WLkRiHXbsq3Yr83imhBjVbizndCb8V1ebwu71DPhRDpV7pfAWApjSmaHJ?=
 =?us-ascii?Q?AGJn+PmXJhJtYOGl5qwp0cIsYydAsyk5X1iOWXBX8tlgg+C36p5OTS0CM3nW?=
 =?us-ascii?Q?8/VM6CPV7SJ+EtaJ8dLa1GduqFhXUT/bv7RdRl7JdTvIXgXDtbtZRcvpxe0Q?=
 =?us-ascii?Q?/6ulB0JezIJooUcht9GM8jNbfH6IyUQeJZRkh/bHxDQ8Cve85zzeoA/Gx1c2?=
 =?us-ascii?Q?0kfKL4wdEA08V78DOLOgTpJqLaoqrB2lSpEoLBjEp1ma2r+HcwsxVLPRhutR?=
 =?us-ascii?Q?PMsTrkbZTAKBCIEXU2okwCo+3gRpJGW6bxQj+hdSKVb+KhuqkkDnyfltFeMU?=
 =?us-ascii?Q?jXDCw/oKRIcqVPmg1QevCqY4s99SKul7ef/jc0QW4zVUoKdLt6xDNSk+GYDw?=
 =?us-ascii?Q?iprhxTkatA5cdvUB4N35WZRQ7qfYWF1ZmcDw2lVip1Rx5LCoudH5NtFVpu/v?=
 =?us-ascii?Q?DYHzbzLwmUQiA2bvhhBaGKskuiQHyr4pk2bEmSBd7hapZ3bvwUn0woZKETtn?=
 =?us-ascii?Q?byDZvnjZ4BLta/D4Nxbt89uGZTL67ivLAZSiMVqpehdRJE1bRikdzUp7aPvo?=
 =?us-ascii?Q?02FZhxN7zEKxTaA5X91cU30Cc364jKjg6jqxrjE1HvcyEIBLuA0bTntM6Wgj?=
 =?us-ascii?Q?+p6QIrZPVRODyDFYW6NCbgl/W9ZO0nvcWMM/5B6Gi30iU4QZyL49GCfJeoVV?=
 =?us-ascii?Q?c/v2rUDueXLIshxGnKTUdUye77uy58h7wskOjbpJaQv9Z9B5EA8lmibPN6Bh?=
 =?us-ascii?Q?zgXzRFasafsiGPasfS2FK8UisybTXbMVry+IXStpuq0XMTDJWi6RpG6gWBu3?=
 =?us-ascii?Q?3YpXZgc4585EyHxnQlzHxFoAX4Jm1RsOeWNtK5dfNyaWF+rIK8aZRee42Tgs?=
 =?us-ascii?Q?eKAWF9qJtCj+6xvE4ngy8wTA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d92f31-36f5-44a1-e285-08d90e4ea5dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 16:15:20.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XWANPMcBaquO9MDwkEKFw3o8qO/4gq88R2quI7GHIdLdQ0v/W85QXttinpxYzZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 01:04:05PM +1000, David Gibson wrote:
> Again, I don't know enough about VDPA to make sense of that.  Are we
> essentially talking non-PCI virtual devices here?  In which case you
> could define the VDPA "bus" to always have one-device groups.

It is much worse than that.

What these non-PCI devices need is for the kernel driver to be part of
the IOMMU group of the underlying PCI device but tell VFIO land that
"groups don't matter"

Today mdev tries to fake this by using singleton iommu groups, but it
is really horrible and direcly hacks up the VFIO IOMMU code to
understand these special cases. Intel was proposing more special
hacking in the VFIO IOMMU code to extend this to PASID.

When we get to a /dev/ioasid this is all nonsense. The kernel device
driver is going to have to tell drivers/iommu exactly what kind of
ioasid it can accept, be it a PASID inside a kernel owned group, a SW
emulated 'mdev' ioasid, or whatever.

In these cases the "group" idea has become a fiction that just creates
a pain. "Just reorganize VDPA to do something insane with the driver
core so we can create a dummy group to satisfy an unnecessary uAPI
restriction" is not a very compelling argument.

So if the nonsensical groups goes away for PASID/mdev, where does it
leave the uAPI in other cases?

> I don't think simplified-but-wrong is a good goal.  The thing about
> groups is that if they're there, you can't just "not care" about them,
> they affect you whether you like it or not.

You really can. If one thing claims the group then all the other group
devices become locked out.

The main point to understand is that groups are NOT an application
restriction! It is a whole system restriction that the operator needs
to understand and deal with. This is why things like dpdk don't care
about the group at all - there is nothing they can do with the
information.

If the operator says to run dpdk on a specific device then the
operator is the one that has to deal with all the other devices in the
group getting locked out.

At best the application can make it more obvious that the operator is
doing something dangerous, but the current kernel API doesn't seem to
really support that either.

Jason

