Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DCB36DAA7
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhD1O7G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 10:59:06 -0400
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:38720
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240016AbhD1O5N (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 10:57:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoivOheLchlzAGW09j6qUE1jJFUZsA4G4RHRD1ip4CTtxRQ4tAp0wmSpKp0TpPUdYa4r4/tdb8kvzW8Vop3sWE73GrtE0SZRestigvwNe3p564vdFMjOGXhlizZssxdD1cW/VvxvjpoFNqmLPs8ZPYwjDuc3nrtl395U80T8/hhfH8ecoUo3XEb79KTxMpD2EU2U8t4xx9sM8vXWGmkETTJ0tMDr6A49+eYWa9NIMeI8t0OLlqobQ3/rRRDZl5vYm3KHjvuE9N8L52luRMtZ8BlGnt9tNLEedCFtJtjZMC8wulFLQaJ/CYp4lZJBbDCoeQPVtcrBFdNRV9Yyzr8ROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atv8M8kVZhsk3nYMhAsMvAQazJTo6Tns2amFmaSapZ0=;
 b=HvHv5ODFzfHYB5ePKZx+yFGdLVWikGyY44wTeTJMw2QF0tgEsZ39h1R8D655bJ8PIlIP7d1aSuKul75fPrB0KyNkZKar1y6GQv9lBgrW93tWIvEsWfPp2yzfsTQauwA1henvyh7IhNAdXxnUVVm8oQBVf3avu4xtJJxENsevq1ovvFzGIyyqTZ6MD+pKwUPM6R1363iT5MB2VQdGFVNuqqQ9MP0SOUXPqldEx/rQPbrLwbGXgPX4dGlPbYE/ht7fI9qn9s1eoy1Snw/tG5Nhg1X0t1o7MBInXNfyWhKlr10OTXhA7Vh5QQBjgkh26WBQ4xBAcKiWB6wyL9AHgBJKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atv8M8kVZhsk3nYMhAsMvAQazJTo6Tns2amFmaSapZ0=;
 b=A/0VpExIoyr+jBLACPdweT58nFKWc4oZYep2ATmF/NRkZa3xILBtxY8dHEOhRdt8LrFuI2FvaTFMr9MJdnCioAmYfmtyAdqJwq8zG4WtmStfsN5XaFsO20k7AMEEFBpXBbY/7Zx7cY7TkLIfjPEDtbDNG5B5YqfkO/87ng4xLkj1XcdXoqQcT8OB0UudahhyXxN4gSXPQnsasjbe13KCbqOSB2i8OXIgxkzv1P5Kcrg+Ze/Q3qg2pJJsN3e46TeyLoLpobE6nNyizbU+IRX84hAHUkn1eUrYLsNuhd1876Lxgpix9JHcy3L3GM3tMpjVcPyKm9zawKTwUK+dnDlreQ==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 14:56:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 14:56:24 +0000
Date:   Wed, 28 Apr 2021 11:56:22 -0300
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
Message-ID: <20210428145622.GU1370958@nvidia.com>
References: <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIizNdbA0+LYwQbI@yekko.fritz.box>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:610:4c::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR10CA0002.namprd10.prod.outlook.com (2603:10b6:610:4c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Wed, 28 Apr 2021 14:56:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lblby-00E2c8-Iz; Wed, 28 Apr 2021 11:56:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6dc2879-e706-4975-af47-08d90a55caca
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1434275C47F86FBEE62EFFDAC2409@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDBka1u4WrPTu6n95TH5Yncs0FMSk1bnjV5H6wH5N+nw3oL97cV18Mw4+lIlj+z0wGmMgshnA1KI40HCoQIf+gDjYp1kWx67HxKE5ka2X3jsAB1nMnTX26rOVEXNBDdv5Lj9frxCjXwKRTi/SiNdLHn+F77oFwZBMIC5HdEY1OcKxGrEwkNO+4YAjcr3yb7xRHQTJdQO0v+vKWDdkfGSdqR5vFT3NlAQRogZzjsgj+gekaBgtvZHwFFHMZUFppIBlWOJvNEUWuqxQ7F5At5bUn3VAN5soG1QmnMPzqJZvituTyINbNN07u5cMJYgO1h0NqbIBO5jaSP0foixrfys2lrTJ7yQv28mEOjabdOg46eIwnu5fq9dqDhUzibDsV/pXq45cXfDPtGeVpfsOKiiIqzmsnsGq8djTfd6BUxDMhTZARLTu3po3EX7mlO7DRRudI8WG3gAKVUc+kGRCdwgq4205A/eeWRaooIhpFgJ3pzgUDqZ810daJaaF5tZd7RQ350KRw41XYFhx6LRs4BuJCQdRGsdQDId6tfm4uyHSQ4TkxsVEyT6NFxDBK7Muv0Np7JpebswRTS2pcHkmaHKNiV5LeOalRtfgBehqU8BzApcAcCEjdWDVt8OOxHJ/3SW2qLyeeKZ/C5jU4RwLyPJiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(83380400001)(26005)(7416002)(316002)(4326008)(66556008)(8676002)(2616005)(478600001)(38100700002)(8936002)(186003)(66946007)(33656002)(426003)(5660300002)(36756003)(9746002)(9786002)(1076003)(54906003)(2906002)(66476007)(6916009)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+dDX2TXWc62NXlCWCbT0ps4AamtQnuX/yWP4gIrgbzopq0Ql1hKDoiEkKA65?=
 =?us-ascii?Q?9wvbadO/JoSktrlydoPZeaB4VzRTprLf4AZNLvR2vKASVQoE325+Px6pzvBG?=
 =?us-ascii?Q?E3JnX2e5VyX/oDfEkbrJ/Gz2AV3AEG1a2VEVVtmb8Qw85O451AEHtPgeThS2?=
 =?us-ascii?Q?pGHPuJZAkZ+LMSkt6HshKe6zoX5KsqMHNaXsNUUzbAo3B0iWZEZeSwnzjdl3?=
 =?us-ascii?Q?InTKRS+E6lNIQ0L8SjITuvvyYWYMPvtdeK90JaYdtcGBmIWTt8QjGS1TO3Gv?=
 =?us-ascii?Q?Xzl391ZfuKI0Yvlrp1PiqhouUKNCyTyAgGZ/3Twdz6bsg691pAOMAAw3nxzK?=
 =?us-ascii?Q?cJ4nz+KUiGzDTvG+fsMntp4jQ6aZn63V5S1Hntntz32+jM7kH/Vgm1CliFyx?=
 =?us-ascii?Q?e3KI3728W8fwlV3e2sU7GS+5EZUHXuivtPfJy9/wS/E6NywSOQ9VxAKtmf/e?=
 =?us-ascii?Q?h8vUkAl+rNtIV1J3BncaTo4YDfIVA5zHFuTvWET0Y4syqq2HaW+LvWclsorR?=
 =?us-ascii?Q?r3jfqVw3s2oLGAl0lHFP1ywGjcDwbAGFTWOF2lnjmgx1yC4SrwPSOxUSOmK6?=
 =?us-ascii?Q?HwZYrK0cPfVsrUNDRCG7CcrQdTqaqOV09tu74GhczZFfS0qExQa62u6eAQcZ?=
 =?us-ascii?Q?k0gDH1JVlA/M+G/tyYAYe18GUht05eToWYJFMNIM10ouvOax6GAszELhpxL7?=
 =?us-ascii?Q?TSNs+gC5GjXtmYjxg3Fvip2pryYvPjoxGXQib5Sbya1nX2ANQ9jCEyYe+wCI?=
 =?us-ascii?Q?zklYZoXuQwhaDeZqXkYOBia01mrtRnsUVWu9rr6OVI7g6RwE7bJD7WHMDZ2v?=
 =?us-ascii?Q?zk/CvHEFiZ+FU5BZAJh7NYpGgtcsR04myRNw5Z5AKDyZYSv6yzMcUiZ0NSmu?=
 =?us-ascii?Q?hYr6/sh4d+0OzCRnCTq9pZNq+YPfdlgNEdNMbFT/ftZae1lKMyzMi5AsmLxi?=
 =?us-ascii?Q?JLPbjktJcw9z/ytbbHOk0/LYHI66cXFQzOmacU+iGK3r94pxMxbOUMBog7d4?=
 =?us-ascii?Q?B3qjd/bvo9SCEfiRzo9lMyBE5hdsaMO/+yD8RJfHA3YuvisG3EnQK0fspfji?=
 =?us-ascii?Q?aur60i1JiIw+ga5NXY5xn8lzwFzhS1UGbWWP4H9saDL/za8LksOkCi+CCfBN?=
 =?us-ascii?Q?4wQbDWkZJxmGyCYW3zW6g4oNj8OU09lUAQuROBhduI/IqbT+ZmNtIi5Tb4MX?=
 =?us-ascii?Q?IYUYgh6EHEFFVsrXfq28lT2TafJa7hxwZUAg1XHaJHs6gkb+LMvo5qvzKGTk?=
 =?us-ascii?Q?TQ+7C1zBUijCuWLHc5F/rF/9cWu37tWmNrZ3Ga8R6GV7EklshV+gYoNxIMD1?=
 =?us-ascii?Q?BJHAL/F1CngwpjxPCBc46Ee+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dc2879-e706-4975-af47-08d90a55caca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 14:56:24.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY73uJeU4b+95cpuS7YEsim8MGaIFyK2jj91877lzSzhQwd/BNIdc2Nz2bDMJ/dm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 28, 2021 at 10:58:29AM +1000, David Gibson wrote:
> On Tue, Apr 27, 2021 at 02:12:12PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 27, 2021 at 03:08:46PM +1000, David Gibson wrote:
> > > > Starting from a BDF the general pseudo code is:
> > > >  device_name = first_directory_of("/sys/bus/pci/devices/BDF/vfio/")
> > > >  device_fd = open("/dev/vfio/"+device_name)
> > > >  ioasidfd = open("/dev/ioasid")
> > > >  ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)
> > > 
> > > This line is the problem.
> > > 
> > > [Historical aside: Alex's early drafts for the VFIO interface looked
> > > quite similar to this.  Ben Herrenschmidt and myself persuaded him it
> > > was a bad idea, and groups were developed instead.  I still think it's
> > > a bad idea, and not just for POWER]
> > 
> > Spawning the VFIO device FD from the group FD is incredibly gross from
> > a kernel design perspective. Since that was done the struct
> > vfio_device missed out on a sysfs presence and doesn't have the
> > typical 'struct device' member or dedicated char device you'd expect a
> > FD based subsystem to have.
> > 
> > This basically traded normal usage of the driver core for something
> > that doesn't serve a technical usage. Given we are now nearly 10 years
> > later and see that real widely deployed applications are not doing
> > anything special with the group FD it makes me question the wisdom of
> > this choice.
> 
> I'm really not sure what "anything special" would constitute here.

Well, really anything actually. All I see in, say, dpdk, is open the
group fd, get a device fd, do the container dance and never touch the
group fd again or care about groups in any way. It seems typical of
this class of application.

If dpdk is exposing other devices to a risk it certainly hasn't done
anything to make that obvious.

> > Okay, that is fair, but let's solve that problem directly. For
> > instance netlink has been going in the direction of adding a "extack"
> > from the kernel which is a descriptive error string. If the failing
> > ioctl returned the string:
> > 
> >   "cannot join this device to the IOASID because device XXX in the
> >    same group #10 is in use"
> 
> Um.. is there a sane way to return strings from an ioctl()?

Yes, it can be done, a string buffer pointer and length in the input
for instance.

> Getting the device fds from the group fd kind of follows, because it's
> unsafe to do basically anything on the device unless you already
> control the group (which in this case means attaching it to a
> container/ioasid).  I'm entirely open to ways of doing that that are
> less inelegant from a sysfs integration point of view, but the point
> is you must manage the group before you can do anything at all with
> individual devices.

I think most likely VFIO is going to be the only thing to manage a
multi-device group.

I see things like VDPA being primarily about PASID, and an IOASID that
is matched to a PASID is inherently a single device IOMMU group.

> I don't see why.  I mean, sure, you don't want explicitly the *vfio*
> group as such.  But IOMMU group is already a cross-subsystem concept
> and you can explicitly expose that in a different way.

Yes, and no, the kernel drivers in something like VDPA have decided
what device and group they are in before we get to IOASID. It is
illogical to try to retro-actively bolt in a group concept to their
APIs.
 
> Again, I realy think this is necessary complexity.  You're right that
> far too little of the userspace properly understands group
> restrictions.. but these come from real hardware limitations, and I
> don't feel like making it *less* obvious in the interface is going to
> help that.

The appeal of making it less obvious is we can have a single
simplified API flow so that an application that doesn't understand or
care about groups can have uniformity.

Jason
