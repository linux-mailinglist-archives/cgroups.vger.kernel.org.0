Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBB93935F4
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhE0TID (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 15:08:03 -0400
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:32480
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229609AbhE0TH5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 May 2021 15:07:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI9ncjhSA7NS7ohF9IXKMTjgUAyBz77JqfU+KQkW0HRJHa3pF6097QwRhsuM4hKRH7p1V/666fL4BDHxHeLDvAGelh0+/K2y/aScwTdSGniUU8BCyrxP4ynXNDNG81H7Ui+92DXkGxi3utdhVApRT7c+BcYBFGStO6rtfyn3zyWw35+dL3nlBc2mt/SN/FRIcrzJkauXkpuFF52oLO8cwP/LW4g+Y3hamicGZNwfunWiCUyRzxBOuD3fWo48Sgn9DQqEICB5fv2+IKGrjDIZMWur8lf3AJ0qrL6/c0M7SIt3uDcGVI5IZ94EvxEXxClCWcR16sPdW8loa4jhbrmMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJQhFM0W1vXArj+sph79LQ7r+iuVf+Uxh/Ul1UCgAgM=;
 b=BTN+jf7DDUBOoyrp76muUvMqs6HnRhcr1lAL6L0WGDorFP9vut4dXGgQ54i+Vtzj/vN7HKf4sEQoI7pLk0D/DKeFXQ+A+OWoJ+rMW8L9fZ4vgHilRIw4EnN1Uc3QfqPZFIistcqu13BDpuqw3lhQwq7P1+hSEs/1n129YuVEUhaxC/M2fI/4G6ImW7jM7rF8hK2qNS5GtluqcSvaa06Dyp0faRyQXWmClNQa4RgdWe4J050KIBt7zle9Bc0OirZ9WvzBxHxzkFaD29qPDXCYQFbuaJ83It6FYSJ2yx7jN4UfO9qssey0kg6WsflGphnCKakWPtLs3lXvRk/rw8WfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJQhFM0W1vXArj+sph79LQ7r+iuVf+Uxh/Ul1UCgAgM=;
 b=m7cT7Ltrc1bmBb+0dwbdDDJOE9nd1gqCKngpLyl2Cl7IWj8T8jKchd2RMhEJ9dy11IO71aQ2qeTLY6475T+ps5uWdyIIQqHw+drNp0Ot/gdiR/Bh2uuAK02MUlmQr0NhlORglaNdcFklPZa3W9ESJTY2U2X/Vtx/wVlXgFPwXkESaPwY5Xm7ef6Hb/UHVO1rHrRpoeODa1fRTm9xVAxIoly7d27H//G5SvqbbUMt+/no0SO38/Da6+tQjgPbnFa88twcDJxucuXtv2/ezsjrpjbnvXLDZ0NNPUYkczO+qnXGX8tsC8B8mvf+GvNxD7uFXhQTtIZKxDqnoy2QGUYiCA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 19:06:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Thu, 27 May 2021
 19:06:21 +0000
Date:   Thu, 27 May 2021 16:06:20 -0300
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
Message-ID: <20210527190620.GJ1002214@nvidia.com>
References: <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <YK8l1mZ0NVggAVUO@yekko>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK8l1mZ0NVggAVUO@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:208:2be::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Thu, 27 May 2021 19:06:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmLKm-00Ffym-CW; Thu, 27 May 2021 16:06:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13e0062b-c8c4-4bcc-17a1-08d9214283dc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5112FEA80B90375ED4CB1E53C2239@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FS94veDt3D4kcgx7uezrWri0nHb8UlE7lNYMsOy+zisHb/Ix7SjizdMExIzA9f/OJH+F0EtiOqFVtmqEZpqSOVma8qeZmWBuEg9GF9eQZw/cobhVBGmUyeM9MU9kBhoFdGCdyzlJ0UWLRESkKwDBixfmGxCDcGiFWDZHjxsvsLtScqtPvylWestaVZzYj/Edp5uH6tEkTDI+iN95YM51z82qLWHdzpob6HNN+3gbrTFfkkRkAIZByFdsi2OmkAVurM1i226+crjHX/3MiN6EQbXrPOitBqVJySYDoBJDIWJWCB3snCQu7k9C+HpGh7v9pkf1c+F/DmzyGvfOHRoHQmTMzV1lnhJLEd2Cvui0X6VZxCHGOvZ9orb45sNvEIuHdzAy3pakw9zMRI1tSIhH6J9srq2SCiMVB+UdpmeLUTnj9wFPl9t91thMPxHMhDaI+dMWApw7+7okYBTElFmz40mJpC7FTtB9JUMvV9sZZKcx6xQfg0YFjRW7fbB2IP8KoeL193DxZlewKPrSxVFtPY4z3C6EXFRLN8j7W7JZG5LoWvqqCTa7HyGh4ZoNyFLgkNVCmVtOI6ku6r6KKBGOFGYG7Gj7iAFEewcHcOKuyBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(9786002)(5660300002)(66556008)(66476007)(66946007)(1076003)(4326008)(8676002)(2906002)(8936002)(9746002)(478600001)(83380400001)(316002)(54906003)(33656002)(426003)(38100700002)(186003)(26005)(2616005)(86362001)(6916009)(36756003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V02h7soTmimdZzXu80ml7oCWr2eleGFq8ZsVPTib+ad6sWijOks08oKD/YOl?=
 =?us-ascii?Q?a5wBw6NMjHL2jOnGz7i979aRi/lvq5Q086j3cBvU5F1q/nkdo2/wRpygRj71?=
 =?us-ascii?Q?pw08k/uWlRRgDzhWvYwFCy3STWPXORKSE9DpSTciGUe7ei4s0dsd/8de90h6?=
 =?us-ascii?Q?FUmNABSXGL3hXxtzl3EKUi4tJ8t0M48JFDrJtoC/KuiDifR3+2hMh8ApwJ4t?=
 =?us-ascii?Q?K+MHmFyhxL9ZmronV9OE7w4bJ9pRHs5kcdSGreAC38dqODTfDv+ReYuuZ2Hv?=
 =?us-ascii?Q?vA4LRshAzs1jIPaY92QB8kDUN0uU57r6arHkoM8vZd8NOXAjbZI9+p1ZYVcN?=
 =?us-ascii?Q?6mXKoYnZDjNFyu01L7oTI7lM1QtVNz5kHjXL4nWq7swHTjqAhiHshzVd2xbE?=
 =?us-ascii?Q?W+sPrP86iUnrW8OG7Kka/PwfW9UOs5avCUzjM6hAzqtGqj/7MeMotqUNe7Aw?=
 =?us-ascii?Q?hg68vYwg7Zy3Xuel2zhRdMrHtZvJPUJqKNlER3NwC3Mwb5dR4rjRwv7jFjKA?=
 =?us-ascii?Q?uf+ZG7RoEbvSj4VxuhXwRguUV+Eo/NpMYKd4I+eIoJiGrWxpnyXfeuv0cYPt?=
 =?us-ascii?Q?Z8qjhgdy3mI1JzS6x27l2EFWOl3+cmpr0Xjj/TrwNZRVdJSMP/4g7Lro4mwS?=
 =?us-ascii?Q?mzUZti3HfwdQXXewU10Z89ggjn9UgzvabwjlFC4lh+6JhKzuMDscGtEVjsk3?=
 =?us-ascii?Q?swNska9h8UcAkdnXle+eoM4u7OCJTBGpaZ2jsrCK4j4uRwvcKVlHC0kRi3sj?=
 =?us-ascii?Q?UnNlaV2NgV2h1BMGH0IfdQwsWMy5uXf6qsbsT45W0BYd4V7QBa1UdY/L36fW?=
 =?us-ascii?Q?rUMGE5Rr96EpN3JALCFrhjfb2BJKFPiSAkBTyTi3znKL2o/dNDSv0q+j3kHM?=
 =?us-ascii?Q?p24kahdmRKGIUOmbhcusFX73oo+pHhW5sN6H0/9PMmZzxqJcshXNiRGzcR45?=
 =?us-ascii?Q?P3YftE6kLA5i25B3ikKVIYVv1mlLtQhciijVD3ikeXrMaRlOVtPOzoHKWVDn?=
 =?us-ascii?Q?UWjnit7vVFutd48DmNyMEEewS9BHV79GjlbdTHR01hNNl8yCCuub5B4mr0t9?=
 =?us-ascii?Q?0BEt8ojHK5Z8cxjS4OIQpy3PK1ttbEwXU1WnhGlt+p3jky2tU7ImuUYkdRmk?=
 =?us-ascii?Q?FA7cBYknTQHcYH0wv6iFdsYbPg0ZjIEQd0ZhZSoc9bW1ACY+Fld4fBctFUVz?=
 =?us-ascii?Q?y67ryh4E2gq+ignAMAkVIFxUM92R5hH1MCmnxNmaS5nmeMqrTtnQJHyRRDp8?=
 =?us-ascii?Q?cEJfom+MlgLUWnd0LiiVkXcV7b2cSbm12yUDP3yHuZgZabn5QVAgx9VFr/ia?=
 =?us-ascii?Q?oJ03ovKrV7+ToeO3UDBtkZ3U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e0062b-c8c4-4bcc-17a1-08d9214283dc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 19:06:21.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsZi7NDeXBrK3PCpuOqAwKbEvXH4BsZGS9S4rLGH1IiTP73d1voKAQeBI3MYxljn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 27, 2021 at 02:53:42PM +1000, David Gibson wrote:

> > > If the physical device had a bug which meant the mdevs *weren't*
> > > properly isolated from each other, then those mdevs would share a
> > > group, and you *would* care about it.  Depending on how the isolation
> > > failed the mdevs might or might not also share a group with the parent
> > > physical device.
> > 
> > That isn't a real scenario.. mdevs that can't be isolated just
> > wouldn't be useful to exist
> 
> Really?  So what do you do when you discover some mdevs you thought
> were isolated actually aren't due to a hardware bug?  Drop support
> from the driver entirely?  In which case what do you say to the people
> who understandably complain "but... we had all the mdevs in one guest
> anyway, we don't care if they're not isolated"?

I've never said to eliminate groups entirely. 

What I'm saying is that all the cases we have for mdev today do not
require groups, but are forced to create a fake group anyhow just to
satisfy the odd VFIO requirement to have a group FD.

If some future mdev needs groups then sure, add the appropriate group
stuff.

But that doesn't effect the decision to have a VFIO group FD, or not.

> > > It ensures that they're parked at the moment the group moves from
> > > kernel to userspace ownership, but it can't prevent dpdk from
> > > accessing and unparking those devices via peer to peer DMA.
> > 
> > Right, and adding all this group stuff did nothing to alert the poor
> > admin that is running DPDK to this risk.
> 
> Didn't it?  Seems to me the admin that in order to give the group to
> DPDK, the admin had to find and unbind all the things in it... so is
> therefore aware that they're giving everything in it to DPDK.

Again, I've never said the *group* should be removed. I'm only
concerned about the *group FD*

When the admin found and unbound they didn't use the *group FD* in any
way.

> > You put the same security labels you'd put on the group to the devices
> > that consitute the group. It is only more tricky in the sense that the
> > script that would have to do this will need to do more than ID the
> > group to label but also ID the device members of the group and label
> > their char nodes.
> 
> Well, I guess, if you take the view that root is allowed to break the
> kernel.  I tend to prefer that although root can obviously break the
> kernel if they intend do, we should make it hard to do by accident -
> which in this case would mean the kernel *enforcing* that the devices
> in the group have the same security labels, which I can't really see
> how to do without an exposed group.

How is this "break the kernel"? It has nothing to do with the
kernel. Security labels are a user space concern.

Jason
