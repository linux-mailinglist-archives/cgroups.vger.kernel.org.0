Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3052335004E
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhCaM2O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 08:28:14 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:46817
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235654AbhCaM2L (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 08:28:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw0ihldKbdEkDmZPJvOY4tzAMf7w6A8zf0KFP0tTc0yaGmWiScoIPj3N/3KO7BmMZJDu0+AieplLpkvGFwL+n28meF19nNjsVFniGKT+Jdw45rLirbkPAWv7ujJ86zJrMMAcAW9zSIi3Nk+G+gGecjEQaViBRUvY2IEetEp5B6pIxlpIKq9DoMMOUtxxI+1sI32V579eae1TMMjX+V2KR6GbYgY64pb+846W7t1cAnoNR7WKW+m76q+fV/byNl/GaA434v8Rxpap28+nWzR3iOdC/vqzzFM1SU8+Bu3fSIABINv45v2gjrEFcgUOVD/rgzw2WRK2GVPJ4b9KWVy6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxbQytUr9+fpQTmbz09WMWQ5YuxnEIGMLAZU/zYwuzY=;
 b=aXUFxJdpPJ6POO2Ky4to7Lvq2wjOWcyBxZ/YEJB+tpev2da8GbYgxBLFNO7Qzl2ZYyKm4NJZqSBsIVZ5VjqQiloVR5hIlf3Yr7lbAFtjsmSr3u1SQq88cn401BBI7IwTgKrNWXHnvsQ2i/H4YYgBlPrElZ97kbM/ko4QAI0BhkVwDBhq5FG1yZE52lPPOnHX1E6paPEL/NBTScjyYNpFBN4vHe2fqe56n2sJXOunoSlpoynCyP0QqTJLNZclU26/sJIUc1e3SyIj6u4q1DGynAGW9GHIxi3GBzftsLaBO3FTUSPoPw5uPKo8tfpPo6FaYBX2UXgZQQ24UmWMTM8Spg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxbQytUr9+fpQTmbz09WMWQ5YuxnEIGMLAZU/zYwuzY=;
 b=jtbNqQBqs4lspf4bAsJofdQyYdMMpAAoID+L8q3Btti2yolcmrP9OlM8RJG1cL6xEc3Cu6Sgl9pljQCgeA3tjL05QFtWgd8T46myaAzoLiQRmnZzDFyXOPO827cq2knIo8LE++9IowAXzgYOORpnK+x43Fn84vnWghiKTrE8/KyIwuDtXiwxob4xf1Z/qIOvVuTIFEuOQ2NzUoWE/D3DC/KQAvhfqY2ajxsl5e52PoWs4DXajdcD4yaDXIfJBZTQqGmATwRybkDN2Hy4xNT0gRwyLh25rVcNEoqFfZT6LUhBW2YdnWOVZIJ2FRjQeNurbAy8WkP8udSZepoPXKmpkA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 12:28:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 12:28:08 +0000
Date:   Wed, 31 Mar 2021 09:28:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210331122805.GC1463678@nvidia.com>
References: <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <20210329155526.2ad791a9@jacob-builder>
 <20210330134313.GP2356281@nvidia.com>
 <20210330171041.70f2d7d0@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330171041.70f2d7d0@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:208:120::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 12:28:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRZx7-006K42-QG; Wed, 31 Mar 2021 09:28:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0af4e41-be95-44ce-507a-08d8f440702d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25842282B017188EA6AB410FC27C9@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdE7lSu/oq7mePjVgzKe+nf57N2FFePYmgaENkoPB/NVfMb122og/D9Jxe7bS2RT9jdWjVd5kg1N/IDILXjYg87gqB0+80QMxuziTVMU9pdd3n9d/ApN+YWN8FDE28bxCxfwM80eULiLSo4bEk/U60u1CyHFrVkGDHB/1rbLtOid8Sl7SIsSrwezNbFGDaL9liqdcWirllOboegrhEJ0/+Z65MfAoVr8nmQ7mfyYtXrerQWJzD3DeC0GYMaWGByj4/BCrC4onTyllb7ybTCuI+sNyFF6r9P0Uqd8fFF0YwVTt46A+cGoTdYweaHSiNTm3Cot3MG7ZhBJ8hOOOADNPLJxlxnhViLisH1zGtyGDEzH65rn0U5wV6gfkaAkYV//FtLSHnpm+7b+dBGeJ1T7rFHr0kVoPm79p7OUH+5y8MppmDczJxOTSdO7PZtt11PrtBQ0pecOR9bQelGY4KldPM3GGThff+OEuaCG+GLq96NEdQo4ZVsuZ3V8kqACznhutIdP90YSWBfQRKHu9aajWIFpsfcX6qYXI5uPQyZTqcxggLaBwq8uoh043Hv4+csicuVQzccMwK+O7QiXV+toYlCTwGhwx97qRA+RGIydYbdBqR3yiUPyIEFvBo5DgmIgf/9MH13Z9i9SDpbwOQYZZozhwdDWDpO4TKZcaf0yYv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(26005)(8936002)(36756003)(54906003)(7416002)(9746002)(9786002)(316002)(86362001)(8676002)(186003)(66556008)(33656002)(1076003)(66476007)(2616005)(66946007)(2906002)(4326008)(83380400001)(38100700001)(478600001)(5660300002)(6916009)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?H3yjkPhZfU0HuT/V/8ocuNpcAC6KzH+n3UKUv2yh2F/wwamTZ9QFYwAY5Txg?=
 =?us-ascii?Q?8jMxJc/ETXtoGHiruRUtVF3MAbEQpbHPZDY+DsxdWM3ISDTRIN0lbSm7z3v2?=
 =?us-ascii?Q?5v3ZTh6++hWQhK6NODYFa4hlWzy27aT3o9Oj/Zzz16Fu5O/JZIl86rclnOyz?=
 =?us-ascii?Q?8iYSmmyR7FDKV5NSTv9GhTCL2R8kQwD2PIAqAst65jfA2WLU3FXUlSFGEDap?=
 =?us-ascii?Q?YZzN8EKGOLNtzKvrxmbIZ0qg5a09jfk5LoxzxJwY3DVEzjC3YwHEXPs9CeNj?=
 =?us-ascii?Q?kZyBhCapnWDOo7PhEQzKUvz/023V9Eei/o0DjsqN11AioCwH2VavIEgs28cf?=
 =?us-ascii?Q?wsugqcAoNkliUT8hjsPvXQz7Gdd26NPZxv9ks6cvwW/IcBxGk0RkC1VGMKAP?=
 =?us-ascii?Q?sEENxuOj+vnE9hIZ+l7hPmuJR5iqcQ8An9YEA0Z0KynQF1BGreWawaCEEz/C?=
 =?us-ascii?Q?N303VYYur/2+HcUOlmQL0tQTiVNxRvi7+Z8ibWdKel6L0AL5f85qA3A8FQhN?=
 =?us-ascii?Q?2jgWtcJl/vBHzevtyxPtbhWFa2nlmuLDKde6DJcYyIIOSWnO8ErMPFnt/YuM?=
 =?us-ascii?Q?jxTezFlW4I7ZHWMWo9lTXColRfk71H9nh57TjKebJlDl6X+NHMgXOPD1ekxf?=
 =?us-ascii?Q?NHR/Co317UZnSv3U8wIgJW3Yt5IS2IrRgMh+9Q0yXw2kA2NLQ2grweY7mC9i?=
 =?us-ascii?Q?ZNx0tfcG2/RTuSYif55FgsyZXzkK6FRMsp3OPO+pX8Qhu3iaV9KBTdJ18isq?=
 =?us-ascii?Q?TtF8DgkT/xx734uhGBG2JAh3yFK0J4nb+jg2eYjrNXc09u9sMZGsat5AOi/x?=
 =?us-ascii?Q?aBfqToORcz9FXReNDQ1+uJGNcdzzkFfF8kIvHNzpgz7PDYSAbDq+xUYtDX/Z?=
 =?us-ascii?Q?Snc6xFhiOKhu7in4m7Bq6TxDOOJoANK/hlImmNBTux3VigKdM97QY5Pvym6Z?=
 =?us-ascii?Q?SGUM3YhS0URzXxReFwf889pQK00GK2u4uXcKBlyJlfxkXCGJrlO8vSuGH7UR?=
 =?us-ascii?Q?/N0H2rklW+k0wA0oUZo5t80NKhi9bDU9ZEvgAnb/imfvtfcWcgOmcMCighzX?=
 =?us-ascii?Q?uMlVxb9gxOSG3GIC2RrVR9cSLHlpOKQ0CaaNVr7pSc/FtIiQaftWK1EmW5HM?=
 =?us-ascii?Q?p1Jbo7EBxHuEOr11kZtxOSkpbtJo551cGhexT2T6+hlUFQ4OJNQRUma7yr/r?=
 =?us-ascii?Q?OEkYttBasNgNXE6NP0D+5kAmulK9i2SKd5JMi5GxOKMNRyh/ZpekxfZXbWgU?=
 =?us-ascii?Q?TIzFNnZpjoCZzpk/bm4cTDfa4yJxDlYcCfI3FM6UU+2B6xk4qZVcXaWtDqTT?=
 =?us-ascii?Q?wgB4ZN0PfvG2ladRMS7vxuetlR3OCERKVfY9pawvFACipA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0af4e41-be95-44ce-507a-08d8f440702d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 12:28:07.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwOv0bDaUVUZiA2FNEQbkbSQMrogUl1HmDtxx8t0uyzP+1Wf356U1JVr5qgVBIX/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 30, 2021 at 05:10:41PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 30 Mar 2021 10:43:13 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > > If two mdevs from the same PF dev are assigned to two VMs, the PASID
> > > table will be shared. IOASID set ensures one VM cannot program another
> > > VM's PASIDs. I assume 'secure context' is per VM when it comes to host
> > > PASID.  
> > 
> > No, the mdev device driver must enforce this directly. It is the one
> > that programms the physical shared HW, it is the one that needs a list
> > of PASID's it is allowed to program *for each mdev*
> > 
> This requires the mdev driver to obtain a list of allowed PASIDs(possibly
> during PASID bind time) prior to do enforcement. IMHO, the PASID enforcement
> points are:
> 1. During WQ configuration (e.g.program MSI)
> 2. During work submission
> 
> For VT-d shared workqueue, there is no way to enforce #2 in mdev driver in
> that the PASID is obtained from PASID MSR from the CPU and submitted w/o
> driver involvement.

I assume that the PASID MSR is privileged and only qemu can program
it? Otherwise this seems like a security problem.

If qemu controls it then the idxd userspace driver in qemu must ensure
it is only ever programmed to an authorized PASID.

> The enforcement for #2 is in the KVM PASID translation table, which
> is per VM.

I don't understand why KVM gets involved in PASID??

Doesn't work submission go either to the mdev driver or through the
secure PASID of #1?

> For our current VFIO mdev model, bind guest page table does not involve
> mdev driver. So this is a gap we must fill, i.e. include a callback from
> mdev driver?

No not a callback, tell the mdev driver with a VFIO IOCTL that it is
authorized to use a specific PASID because the vIOMMU was told to
allow it by the guest kernel. Simple and straightforward.

> > ioasid_set doesn't seem to help at all, certainly not as a concept
> > tied to /dev/ioasid.
> > 
> Yes, we can take the security role off ioasid_set once we have per mdev
> list. However, ioasid_set being a per VM/mm entity also bridge
> communications among kernel subsystems that don't have direct call path.
> e.g. KVM, VDCM and IOMMU.

Everything should revolve around the /dev/ioasid FD. qemu should pass
it to all places that need to know about PASID's in the VM.

We should try to avoid hidden behind the scenes kernel
interconnections between subsystems.


> > So when you 'allow' a mdev to access a PASID you want to say:
> >  Allow Guest PASID A, map it to host PASID B on this /dev/ioasid FD
> > 

> Host and guest PASID value, as well as device info are available through
> iommu_uapi_sva_bind_gpasid(), we just need to feed that info to mdev driver.

You need that IOCTL to exist on the *mdev driver*. It is a VFIO ioctl,
not a iommu or ioasid or sva IOCTL.
 
> > That seems like a good helper library to provide for drivers to use,
> > but it should be a construct entirely contained in the driver.
> why? would it be cleaner if it is in the common code?

No, it is the "mid layer" problematic design.

Having the iommu layer store driver-specific data on behalf of a
driver will just make a mess. Use the natural layering we have and
store driver specific data in the driver structs.

Add a library to help build the datastructure if it necessary.

Jason
