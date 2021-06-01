Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FBB3973AB
	for <lists+cgroups@lfdr.de>; Tue,  1 Jun 2021 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhFAM7D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Jun 2021 08:59:03 -0400
Received: from mail-sn1anam02on2082.outbound.protection.outlook.com ([40.107.96.82]:32943
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233909AbhFAM64 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 1 Jun 2021 08:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4gVOC4bVFt3QZdDDPPRxH0yLs4fJnMcbaqdBVu5S5iTkSekh1du0NsB6xBI8Jlq16ryxUnIA8ib4YEwsJYKy4Eo9j+1p4aYRqakUDDv/6OTMnM20CWOavexGOjrRq0GIVf9s4cu2F9X0MSBEpa7W0mpPZieqh/FZsrcT7cJMIolC31uWRygv4/0/W/2dUeOWEQ558soW9weGj6sXShG03Vsls6hv1jJlT9AQhoG1iyj8ebnlwQvWUwpxfnDy3nHSWG/wFdaEMNAURDarciAVlJ//Cz1+sgRCF/r/m1mkzCUorJxlagcaGfSuA7E9fmpykBLsSzgDi4sK36/GppP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gyZlwmlHYU/ZmUOvs3ehKHXbCDvmkOMT92IXgOjuI0=;
 b=JSzDU8etqvrtlXAFOCYjC7lel0VCKjapa6gM7WIUmOXZV1SAaKKvp5TkddFNnuitEO7XcUnAm/p6GyEITZoXMzQVRl+Bf3HwsRuA3CcdeB9cHFN+pEBO0p1TlWBNss8mPL1k3ILVaYJOcCxgtXfPd58TMyReWEu1yYJ6nqp6Xi/aiu90kScF+1YxGUY1l3KYYb1/D3KVwai+MwVz6mUd3AnPnm1S/fDYSGQD67LLqLXz5uDko0mREcDzLw0xbG5LJCVbyzurqa4PE99gPpLrPCZz+LYLGt9+YW+pTXOUPSNtHDcYSo/5fRhlgAg/mvjAZOzStZ4Lzw2F70e5zKlixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gyZlwmlHYU/ZmUOvs3ehKHXbCDvmkOMT92IXgOjuI0=;
 b=EsSoLP4vmT+VbVjBbyAbsIPlGxQoQjktFVEadP3SD9bFG6jR/sdNZfPNmdr9bssK6kW1FYOfFBhDeQ+9ECvCjiNL5vNcM7aA0oelso6zG0Hkr2rkDYvn8vI0cpPjzTG4BGsZfbVqq+ijn4rZuzG6pLtldPzDvF0Jzb/P0XmKltmUqmZM1xNP+/lNseY+M9WIWDKdFuLBDdN5jul+hDbysqGEoH2lpgcr+HCwKViigqaF7nyaupKTIBIj1GUlrOFIWwAnIDgmDdvnGPt9wnOXVyoyh7pwKtaXQTTcTlU8x4J0JBgeY/w+WAvOKxRTdL7U9c0uwCtQg2YiZjwiqmryLA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 12:57:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 12:57:13 +0000
Date:   Tue, 1 Jun 2021 09:57:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
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
Message-ID: <20210601125712.GA4157739@nvidia.com>
References: <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <YK8m9jNuvEzlXWlu@yekko>
 <20210527184847.GI1002214@nvidia.com>
 <YLWxlZC4AXJPOngB@yekko>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLWxlZC4AXJPOngB@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0013.prod.exchangelabs.com (2603:10b6:208:10c::26)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0013.prod.exchangelabs.com (2603:10b6:208:10c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend Transport; Tue, 1 Jun 2021 12:57:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lo3xI-00HS9p-3m; Tue, 01 Jun 2021 09:57:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9db6468-e9f6-4ad5-04b7-08d924fcc6a1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5253CF2F7BA7531DB647A341C23E9@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyTd9IF7sCTPcGng9yvoSm4sxvbz3irRaF7bKcgAFFsqXLRX2p+Ad+YGm9VTEbpTIedr3k3SUGRWOQXGF+MH1bVmcW1dDNlc3n2h7HrnZhr9l0VKDjSGBNBpafL5Ga/pg4mtFn5rWp9yQUylccGGWUT2QUsSFFCneXQHQJN1LOglrc9tLgFtlQe1RDhyaJW2WWRixcN8vyD3BuwdEyOGmoPIsgoI2brlYvPgAuBYM8N6NZ7qPfHb927iQNueVrJrJhnC4QMwZYUEsF97AtSrPzxm8oT3dMlUOfVZbaSWe5LTUboV5YOJ1PhR9lgQlvpbPKU1G75nAFyoRzH86JSzuQuEf+ybMl/OYsDuLMazAaMl6tfkBri77Ye9AQ5lIB523llKCtkcPmrBfZp25eM8+dbRVrhQK0+OkxIUvk4cSSdGG3TZ3ThLOZlETFH1MmzoRo0FosiBFI/BOOAllW8ZVWjKu87JsdQMWKM0RPqlMgX0CwFMdwZiC78LgA1epsUxw+khph8jvkPdRT/pvu8zYtoSo0AI/+EUA0PKNNqGSU2h+8tK/lHzgoU2tVB3Z/EZM4NK6I1K1gLYexDnUMO2fogbScIdU1adEMuckz4E6yG4aUYLj76PQDzv/7XrArKSqANfFMzhFwGQmo7E7YlK1tM1GKV2MgEGj1xAa8AJLnhGccONBIIMMpLGhTXxInDDtEUPx+PQDtGWkqT8L2J3Rh4UPJJ09cnWTE6yhzSWlpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(83380400001)(6916009)(966005)(26005)(4326008)(8676002)(2616005)(36756003)(186003)(9746002)(2906002)(478600001)(54906003)(7416002)(8936002)(38100700002)(426003)(66476007)(316002)(5660300002)(45080400002)(66946007)(66556008)(33656002)(86362001)(1076003)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zwUlqhOsSyXd5CkgHA86Hn7oVn7eFae8H0YqvN1QoFwvpsKrS6lGyJjzCt9p?=
 =?us-ascii?Q?s8wSZBH/i2fkPxYQ2RpM7Nsu/Ag49GBjC9UU5LL+x7m7rkoz9MP93E0zdkNj?=
 =?us-ascii?Q?g6QbJWMBzDouXaidz0J/nSqUSWu8XbM7vyF0Lvg5e2cIdoXFm1/iuPE5t6r+?=
 =?us-ascii?Q?w9o483dPJkINLrbbELuzzHol9NFIyvad8v7NBtjvhIGgzMrLg21iE2mI/tlO?=
 =?us-ascii?Q?J1tXkDm7bY2y+B7Mjs51kYMKBikoKDOpDcrbjKhkRLsyGFtE8S0GYwUqy1cr?=
 =?us-ascii?Q?G6P12IvC5uU3bf+/SM1znztTuF/OdwujDILpKMW1XuBp1BMaYCb/OtAtTbg1?=
 =?us-ascii?Q?JuP0FEp0hMKSI5hhLi/nJo6QkNCCcp98mRhz16AzNa2YDtgZuOdKy5OV5FZ+?=
 =?us-ascii?Q?+ocnRrOwgDal1FAWV1VWtnVQBna9v3N9dQs1dSmE7BmhM5ct7+MJdpzxGkW8?=
 =?us-ascii?Q?1Pbxit9CBlImHucpF9lvnZLHUVTXjDAfKtJGmmyIwvvaaoZXUU82Q8/uD+h2?=
 =?us-ascii?Q?4lBz+G/wDUqWT3sJul9l2BtWoW/o3HnkptPtG8Zx0Rgy+d5vMlzmRykcSDR3?=
 =?us-ascii?Q?exX9K4sH0xOXOZnxtpYDcT6IBw8eBYIYyCt92HpCqymjNlkky6AUbRmxQcFn?=
 =?us-ascii?Q?YrrMW7yalEBAGnjsCPBoxlFoKtpNtXwJkSCH2+h/Ehc3yppZR0+tP9dU+8FL?=
 =?us-ascii?Q?8clR1K+sK5BhRtAtpjWjbg3M5LWe3UAPanjU4hdzQTcgxp0onc18FGi3evP1?=
 =?us-ascii?Q?+QKHPDRyYSekYUn7Btm23GIZvvFSe/QKb95FydI3AWL4aUAk4WY36FLRw6je?=
 =?us-ascii?Q?HyDmjUS+Xeza7aEyGmLEuMZfu6MSlSGtuotWxxErHXxjA9IHkE6Lh3u0dQ2k?=
 =?us-ascii?Q?lyNlL7nAEHkS5VEeYOmVdq7ZHO1NtxliLZkxZY4yubMMTxTxyOyqK7J0rS3x?=
 =?us-ascii?Q?OsbEkddGaYEaZrwdMd6uMeCZTzSb4f9/VojfqCb0IdCDyx4k7q82phOZ8R4z?=
 =?us-ascii?Q?QSo+piHNEVPdOLmi0Il9ZBvopBU2b7N6+OHY9iJVMn3FZ1uN/sPfwGzziz98?=
 =?us-ascii?Q?WFCaWzsw0mirc+sSQ99d/hT8LDZrPQgmAPVjNFFOAud5/knACVjTc3OqtnXY?=
 =?us-ascii?Q?e0kcmZ8u0E/R9dxErThlkvlW3G7sg3wuDIohruhIWqGFR8XmFaLw1EVQy+Vp?=
 =?us-ascii?Q?CC2wBOjVOT0xjYVoBrqRb+HmYP8bxB6m2TszM0TPZsB6e6poLgf9U4VrpU2Z?=
 =?us-ascii?Q?6HkvfS+0PgxI/PPjJB3tcsc/HM8yNPu5BR4xmMTtVM5rw9Ng3m9JdhZQHttr?=
 =?us-ascii?Q?583NYcktpGNb+Ku8nbyu+nkR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9db6468-e9f6-4ad5-04b7-08d924fcc6a1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 12:57:13.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQLiNuU6v+wRKllp52/T9oCFQ/nMABooxoinU15V4UtOMrPTlkc4rZfZIpwiMio0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 01, 2021 at 02:03:33PM +1000, David Gibson wrote:
> On Thu, May 27, 2021 at 03:48:47PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 27, 2021 at 02:58:30PM +1000, David Gibson wrote:
> > > On Tue, May 25, 2021 at 04:52:57PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> > > > 
> > > > > 2. iommu backed mdev devices for SRIOV where mdev device is created per
> > > > > VF (mdev device == VF device) then that mdev device has same iommu
> > > > > protection scope as VF associated to it. 
> > > > 
> > > > This doesn't require, and certainly shouldn't create, a fake group.
> > > 
> > > It's only fake if you start with a narrow view of what a group is. 
> > 
> > A group is connected to drivers/iommu. A group object without *any*
> > relation to drivers/iommu is just a complete fiction, IMHO.
> 
> That might be where we differ.  As I've said, my group I'm primarily
> meaning the fundamental hardware unit of isolation.  *Usually* that's
> determined by the capabilities of an IOMMU, but in some cases it might
> not be.  In either case, the boundaries still matter.

As in my other email we absolutely need a group concept, it is just a
question of how the user API is designed around it.

> > The group mdev implicitly creates is just a fake proxy that comes
> > along with mdev API. It doesn't do anything and it doesn't mean
> > anything.
> 
> But.. the case of multiple mdevs managed by a single PCI device with
> an internal IOMMU also exists, and then the mdev groups are *not*
> proxies but true groups independent of the parent device.  Which means
> that the group structure of mdevs can vary, which is an argument *for*
> keeping it, not against.

If VFIO becomes more "vfio_device" centric then the vfio_device itself
has some properties. One of those can be "is it inside a drivers/iommu
group, or not?".

If the vfio_device is not using a drivers/iommu IOMMU interface then
it can just have no group at all - no reason to lie. This would mean
that the device has perfect isolation.

What I don't like is forcing certain things depending on how the
vfio_device was created - for instance forcing a IOMMU group as part
and forcing an ugly "SW IOMMU" mode in the container only as part of
mdev_device.

These should all be properties of the vfio_device itself.

Again this is all about the group fd - and how to fit in with the
/dev/ioasid proposal from Kevin:

https://lore.kernel.org/kvm/MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com/

Focusing on vfio_device and skipping the group fd smooths out some
rough edges.

Code wise we are not quite there, but I have mapped out eliminating
the group from the vfio_device centric API and a few other places it
has crept in.

The group can exist in the background to enforce security without
being a cornerstone of the API design.

Jason
