Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6587C3615CE
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 01:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhDOXIB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 19:08:01 -0400
Received: from mail-dm6nam11on2043.outbound.protection.outlook.com ([40.107.223.43]:26689
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234941AbhDOXIB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 15 Apr 2021 19:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPn7V+rZSnMkn0zpr/E6nMyez4An/tAegaIVddBYaWifVhbxcoe750XAdCwoEP0GDIQZcf2mE+rG0DPXUgoBJNwpY/EtaG/6XsGbJs63n3i5MWVDbZq6W7C5RuBoTOl2DLB2L2vOd1HKMHGVUwuI6jiDzYZTGYMaiB/gYNDbptTydXV+uSa/1sbGVHwCPGQL+Wu4Dv2FpXYOTp/VmOZRCdgruBB0RV9XKkZyJ/i6O/FjKsk7CJkqbWnx0B8r8cI2VZ2sXKzgvxUWREU1eNuIdJhC/TBLNX3Jw4d1aP10W+5JyibCAdPJ9uAo+gZwh/RJNsXsho0wjjjla1XyWLt5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQAb58lwgyE+plmuAkfcQ1sPEzNXE19zU0nknw5tjs0=;
 b=fqWdx+UaRSeZ1uYdUKNXaJRiTJetgMeaOBgdNxdjtRnpDQDF8nGmlplZ1SzWBL1ivCxjwKX4NSrF2tazmhTTC3az7pZVw58ub7EK3QDeeJOG3t4V40DPvnX5lAAb+wZeetxG3gEtQRPp6nB48HwLWtXrERreiBxbR7mlReghcM8E6AZcTWn2NXokdKgjIB/bOYFIycuwawifi8kZHTdDUN/xWGgV8BKCID3+/1HLi0Adhhmsp2aEKKHcl9JAW++rjcr41YIgkdT0ixf+O5lJeuMmEqX6qysxVFOTx/wcAHzlI3APKDyg2vKmpjko4Id5nE/PUu2hpxNaU3dUCj33SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQAb58lwgyE+plmuAkfcQ1sPEzNXE19zU0nknw5tjs0=;
 b=mlfGdLlcOxgpclL093Ex0D98Trzl6JzDNoAfOL1XBR+gkJdaZNfXk7WLjTnDPBPlRswQmeXoQG2/ZOLSVpEeh0leUuUSa/1MZAsiohJhTJvL8O+Yv6WJ91STJxt1jKUNo/cnHkHKIUOMxfdiHgsGKkL3xn0gxUP2wfrmtRd70qWrAwI0tLva1YMUVyKr85JJCLD7+ddaqSfx4yvZDOCIWeSm6PsFS3hEWlgjgDjrNLMWRbiUVf18lg6V6TH8yANCuu91HWe3m/NMBk9JEiHDOiDpP2PP5VdWfwaNCW/+34OP9rhhuKh2IUtQOsHTwsjnQZcqch3CPv3sJtdIy6VaTg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 23:07:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.024; Thu, 15 Apr 2021
 23:07:34 +0000
Date:   Thu, 15 Apr 2021 20:07:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210415230732.GG1370958@nvidia.com>
References: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:c0::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Thu, 15 Apr 2021 23:07:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lXB5A-0072aJ-U6; Thu, 15 Apr 2021 20:07:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59867b5e-199e-40a2-7eca-08d9006340ed
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01052B9C161B842BAF5E54EAC24D9@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvKB7IO5S/nlFwb+HAhfmiNwWb3kd09qzRMGUZOxWZcke2r1TvSMJ8h9L1cot20Z43D2AMMvWft8aCKdgcUNwSgIY7k5vyWUZY8zmKlRTPwl7AIPKzeVGK6tNCxj8FEsBYoEShh9bJoXOmImpITd0ARxwdE5SHTwdjcKfskEYWHpyiXVHMP6t7WYhEl/eLy/2X8hqUFcvhFX15AZZeu7XCdE00U4sY6/40KT5VW29yACeUL0e6PF6IjQ2gMy5MQD0sbT7ptkpWvePRzp/FhOdohl92s0ml8dpKIkY/jKHzA933AcZLRzyhFTwjTqJpgoQvf+1wQSuAS+6YHZkc1nm9h0blyh4ReU+2iXIUscnTFf/IHM1GzBVnCEtYWffxHv8Ne91q3xd7s2xXpUwZ9eYtqvFvxbAZ4wFDgQVniCF8qXsFCVo09UtXT25j5J66GMjVNMgB0qcL6xS7QksCj7cZxfEeSr8zECBfyn12nqS3UdkTCt52MtCe+F18a1BDu37T4zq7Vqu1wmcQWJSobdc7j/jcvLcZzbFxtOpc1iEyghKFe9xNdW39+bmLLNL6cwpTzGsc+nvNplQGRxM8GzxjCcO4SDkzHE8xoQW5Tr/2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(36756003)(4326008)(53546011)(54906003)(86362001)(33656002)(6916009)(426003)(8936002)(1076003)(38100700002)(7416002)(26005)(83380400001)(2616005)(186003)(9746002)(9786002)(5660300002)(316002)(2906002)(66946007)(66476007)(66556008)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gL3pYZ0CQeyATs0d4WTMbJgOcufdMHcqmMh6nFfRkK44u9TCfhE3GU0xTRjs?=
 =?us-ascii?Q?oUIIx6x0tU6udVcOAZFGTS+KlNmVg1cWGOyaB5dbTs3DacCubCc6oklFRkBg?=
 =?us-ascii?Q?b1Mh/ABcdqGckrjCNN2EJ7PZy7PWYRP10swKT+GIlI6twfmYWs0Kj35VcOwD?=
 =?us-ascii?Q?ai4Nv9T/1L77p1nbm3JjKF4dkHEXtForIwpUnGlYjsRJ7QRQz27FzZbRAqB0?=
 =?us-ascii?Q?6vFQ0vLAO+udk5R5TxDpYXsMGLcHDmjGWM4JdzNxygs8f+92hVBL6+7kfC1M?=
 =?us-ascii?Q?JA6aLzoJRb8pmI3mqZaXSnESvlNF0YpHHd62rA+G8CWjlA3bm5vfJOFdbv3z?=
 =?us-ascii?Q?qC6MbEcGI+mWuteswS9Uwo5LmdIKSKwamku3WaZZiEMGib1HS9K4ergqzJx7?=
 =?us-ascii?Q?AXTGU6opFnZ9of3O4MStuXohdL5FhuIMj/vdptSmnfDLeCX5ofwj2AtBNoB0?=
 =?us-ascii?Q?45OPOZ0zm3Vnay/6O4PnrpDhQOZgj/HFHiDYNO6yRUrir7ugOoyJNsZ9PlDm?=
 =?us-ascii?Q?ftKSGFmXTefnX8fezf8AmjUSC2YGBPl4U2CJld7XGF5fJLMpNrkk2m/eIqK8?=
 =?us-ascii?Q?RtK1i7Tlgis2IFqsp/BgP4nDFxa6E4jEfsHANPJSFVSDaciejj9ZMziz4akM?=
 =?us-ascii?Q?VCgdXYbhfujaZ6k741BMpfpZ55W109HfaBTqh/jvzA+izmNLoSDClnKKkfCe?=
 =?us-ascii?Q?QpxQx+pEUbCzCRr0+xwwkGhf5EkXQimRwn10YC1/HZ/QNux56rYTm1TWxrYT?=
 =?us-ascii?Q?HuvTvTpKg3duWN2RtYZUSf5AO3e2vT4EiR1h0Z263Z65hGcuf3JzOWOz/8mJ?=
 =?us-ascii?Q?wadUZOuLR2m6q9FyC3OOGxiRlLEUJ+QkNoUk/zTG3+6/M5/6exxwLMuT0HH6?=
 =?us-ascii?Q?9jtw5UF/uQTQWKEMwaJ72QNCEkhtC6kp+FOCY7OZf62MF7NbeDE9R/z8Jl1z?=
 =?us-ascii?Q?kTr2NlyygvgzQ6UId3lVcwFz14J+IkbaNbIBuTZBiNyEeXHFCLcgjilHKwrm?=
 =?us-ascii?Q?LixjVQQ8kd2ivuX1zgT9Ruf45mksnFZMmXBqbs2DvnMnhx4JNGr45lBNeeiV?=
 =?us-ascii?Q?/szDysrbdujgPS/MJ23kS0Bg4TP4vOjGcO/SVJxLbZqIqbOcajmZJXL9booZ?=
 =?us-ascii?Q?HeCBCcmGRBS4eijc4boHstCSAdnEak1s98i/Uh/ma1Wbe+xV+uxdWQkGF5EM?=
 =?us-ascii?Q?8q4YcaYRxaIUJDxSi0RzgBxAxj2hyqFIgaR3YXXB/rm4x4yd/bylZhFUxMov?=
 =?us-ascii?Q?lvLkR33lnSEDIjPFs4HG3druO8I0GMbmZkhQKTVNdK6qgptwReBppzZxDEjF?=
 =?us-ascii?Q?QNHpPFGracmtTr7KOQcg1Gju?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59867b5e-199e-40a2-7eca-08d9006340ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 23:07:34.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIlUtknwzUiL97gu0eA/3qnGOpk4Cy5US4HRY+BlnaQtDufQf9OdRkTOCI2AwB86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 15, 2021 at 03:11:19PM +0200, Auger Eric wrote:
> Hi Jason,
> 
> On 4/1/21 6:03 PM, Jason Gunthorpe wrote:
> > On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
> > 
> >> DMA page faults are delivered to root-complex via page request message and
> >> it is per-device according to PCIe spec. Page request handling flow is:
> >>
> >> 1) iommu driver receives a page request from device
> >> 2) iommu driver parses the page request message. Get the RID,PASID, faulted
> >>    page and requested permissions etc.
> >> 3) iommu driver triggers fault handler registered by device driver with
> >>    iommu_report_device_fault()
> > 
> > This seems confused.
> > 
> > The PASID should define how to handle the page fault, not the driver.
> 
> In my series I don't use PASID at all. I am just enabling nested stage
> and the guest uses a single context. I don't allocate any user PASID at
> any point.
> 
> When there is a fault at physical level (a stage 1 fault that concerns
> the guest), this latter needs to be reported and injected into the
> guest. The vfio pci driver registers a fault handler to the iommu layer
> and in that fault handler it fills a circ bugger and triggers an eventfd
> that is listened to by the VFIO-PCI QEMU device. this latter retrives
> the faault from the mmapped circ buffer, it knowns which vIOMMU it is
> attached to, and passes the fault to the vIOMMU.
> Then the vIOMMU triggers and IRQ in the guest.
> 
> We are reusing the existing concepts from VFIO, region, IRQ to do that.
> 
> For that use case, would you also use /dev/ioasid?

/dev/ioasid could do all the things you described vfio-pci as doing,
it can even do them the same way you just described.

Stated another way, do you plan to duplicate all of this code someday
for vfio-cxl? What about for vfio-platform? ARM SMMU can be hooked to
platform devices, right?

I feel what you guys are struggling with is some choice in the iommu
kernel APIs that cause the events to be delivered to the pci_device
owner, not the PASID owner.

That feels solvable.

Jason
