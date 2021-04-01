Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817A83519B9
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhDAR4F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhDARpS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Apr 2021 13:45:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA1C02FE97;
        Thu,  1 Apr 2021 09:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwLhemHguv3xJPF/O+v3lgOVvdKjDgY/kmk5nU7lPRsAQIF5GQGtW01uDu4L+KvWBbR9jPNeBZAx4HvXMgCN1S5qao2eEDpa685nzfQeQ/qdKCWTuj/6/XUbATjIzRxXworQCRcDbGbICSROfrmesNmiufIgWIZuAXQ0IKH9+oFJRtd7nl52IDFrCFo7PfMZQPJnCCB9H9GdL4lrjhGrzirO3yDC2ycQl271HrK5gPn9BXP+3Hpnk6FML+zm0sBTFq63QCgElex3lhtzatG3/wpgxzUBWnh1x03KqPbW2tbOS+zLIe4ozW1S8zlzGMkO2zDi77fkoqaUYY2nh22tGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzW2BYP3ezifTSicTa4DSrM25NdyzyyIuxKnyri/X1I=;
 b=YDzV0Uccf6e1ZqNNxqbK1EIhBPMbbibDQVj+UiaI3M4gnXyy6saTrZ7RsGsb9vre8RBBxtwJvlBIKVXSXuTqUsd+NOf447IfZ9ceusz6iVVB4toSxeA2OhVTzuXsjmp94lswXF35+7A8f/eJk3f1fMaWRgDkuwXR2Fc/f6vmdRmPys1trddKAtrtBY97j0HT3SEdK/YUL/C53+GLq9GyuT2PMjijZZtwQcw5ek9tw+Wq979RcVhWmHPPUcEBTudUvXR/7ueNYl0KphEUCZAAV0S9PS5nNcOB7iKDORIKSDA+HAlrXAgldnq6H+D+5JXXi5EJ8tjEQac2ZdM6DWh8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzW2BYP3ezifTSicTa4DSrM25NdyzyyIuxKnyri/X1I=;
 b=cfICuL1ll+qfpY/WKb7rUzig5uRYwC+DwFsMrEWm4UJaN75y6zvmmDzAlLtz55gDlHWu4dYpyv1bezVSERorqn/JhLQs9rnnHd7QXY0bjLOD8r/HDBuLSsY4TpxvtrzgNKg5eG2QBcPcwIZgjzLv7mLH3zzazBxs9B8GOacSsrBDHxJQ2YiQTY6JYBAuN+9BHN1GwccQLJyolxFvTzojDCHzD43Dx/YFaJHRP29PkDZKv5ovmoYAC7LYVpyI+s4KBefZzUoGjIn6bO2Ru7P0S9QmZYRkq6+1Jx6FoJsR0EvGwrdblUqDMseaeNl6bIV6FmiQ4PzwYjqoLZQ3N/F6Fg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:03:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:03:39 +0000
Date:   Thu, 1 Apr 2021 13:03:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401160337.GJ1463678@nvidia.com>
References: <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 16:03:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRznF-006nAk-N2; Thu, 01 Apr 2021 13:03:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31b478fc-dd09-47ef-2012-08d8f527b69e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:
X-Microsoft-Antispam-PRVS: <DM5PR12MB133804E2900ECE6D566011B0C27B9@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nY17ppZo/Em1VwqheQOfo+QJ90Q1vvnGJkNzFCWXNWYO4cGVu+3nRtGVOuYE/Hd5fUqUXCt52Q8YcQMyFXvg7LnydDPXujeJQxdHcU0cD3/AQG3Sfsd7IHQHQWKQoJi40UQ3zCDp75FO7t19g9w5cJx2bUgPNASOJBHfTt2oxfoGPqYRMSh2i4AmGqAx5d9NhWCeuf8IehsB20u1jyncRtPLMBs7lI08V2rRAVAiu3SVU9KaTSnjcvqyYepbIrFj3SBiX7/FSv1niWY9pg/1Aktkhsj2aoqXXoTrw9CNOPif8j1rmpIz0mzjqV3zOjuNRoOMaCefv8sUdmMdWxsbzyfHCATaSetmlze3Yyao0NeXPiqzC9FNPJmUgInMkUyeeAOknzV2gZSpZ8bSCm4cOwMwB35Yn4BbfGTnNI29g9DJUZbuwSXmAWNyF7RxR+YBiKEStCJe1mBRGhLbMqfHL7OPiHcA8Q65nOwpDvpnaml8DUhTIFsdcZdJWxL1sjgE0d5Gqj7Y8CTjEt2Ik5VPAyLVx1Jp/7F2vKDveEq8P83kIbrK4hu7kIBDb1yX6LhBD/EhB91PLugytZpwS/5c/D2hVWOxVe/T6RU+7QvtgMHDNaoWFIEsKvKbV3mrK94THAKF/13TEX3wEuOFrd4DlKwXZQlzqBltlo25qVHGDRKJnJ9JuwIVU2isTOmyW16urgdcqKBy/huQyXgA1wftd0I4Xl1GXWOYq0Weizsqe4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(54906003)(26005)(83380400001)(186003)(33656002)(316002)(8676002)(6916009)(86362001)(9786002)(4326008)(9746002)(1076003)(2616005)(66946007)(7416002)(66476007)(5660300002)(66556008)(38100700001)(2906002)(966005)(478600001)(8936002)(36756003)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MKW6chrYMNvv1z2ay718cuvELSz+nq6GyIRq1zzBETILz82uUshkOLGQYEfW?=
 =?us-ascii?Q?0Pt+PsG2piJG+lrkSJQ4zH9H/LIihQ7Nl35RpVPl/3tCpGsIEtYEnQQs3/QG?=
 =?us-ascii?Q?xnbBbUsYlQ4XzbCnoj+3RG24rcd0qW65HabKelWPFSHwtfVX9AdwdJZxwWg5?=
 =?us-ascii?Q?KYK/MO0EsA1rbPsa/5K7yt8b4Ou81QOuQ2/qb+j/kRw38jC5nklq/G1+aLdK?=
 =?us-ascii?Q?sMwpfMxLQYRn9nr7zl0gpLk8naCihR00hDCUPe8kH8FS5L5j6O50mwYfyGhW?=
 =?us-ascii?Q?6mZcX2Tl0VdSN1NnWI5MB1Y9No+yoPTT3AVZaeZe5s0dfplDAmqI+ZP7oreY?=
 =?us-ascii?Q?yqVnm+2cIlvoSwCIwNTCsqB2llt7rjiTI85iJMVl3k8DEXAcUZGwsah2/v9y?=
 =?us-ascii?Q?t2vDxw5F8iOzgN/6B9vigjN9Ld02eaHhx4RRyovrTQN29ynPar+Lw7a0G/9m?=
 =?us-ascii?Q?hVvqL0hecZ9WqpjUpNUY52gymDt42lb5tysB9yXGGBsgWfGYTTBldydcUJDz?=
 =?us-ascii?Q?rcncMFS9rjQP5vtyngEwJseFyCAE97EAG/DHUpRcaleabr2N7cO1B1f0YQmc?=
 =?us-ascii?Q?uFDYxBnPhdqWMA5aH0iTvnQk4b8uUtmxTyYQkrXx3NcVSX3aGrMdwbRg+CpZ?=
 =?us-ascii?Q?EQJbNJdnO4PzL3KPMt6kUBr3/I0ELWsFQmN9+8plu6EBS8n563xCqioJsUlH?=
 =?us-ascii?Q?7hanSd+VeQv+YTrCu3lx8ts1K8ZoXGRDqm+me0gixOxd+yVz2nQ91WapjE6p?=
 =?us-ascii?Q?k6kwS7kpUaJ05Jw1RuICFeOdJ1TlfpZfQgq9EPc7PKlTGhsmklthd+RQUn1h?=
 =?us-ascii?Q?dj5zVWj8FiBEFBNT1JU5gUFWGQGoSNYjBUB/XjzZtUGOWkrX+Y49eqiMVrs7?=
 =?us-ascii?Q?qVbWeP4woHdg13s4G5yhLh9UWvofHXIRCn0zH7/0kcBmADuP2hIdBcdZeOrb?=
 =?us-ascii?Q?daFyhUXG0xvGIkb2kA+1Gz0o3dhhQC4tVtzoslYWpxxo+JGDcIaDXc8IVnPg?=
 =?us-ascii?Q?VwzsVbMZ/qsQaiYH/VwihV/paIjJeLeW7SYLvLsh0yPTACWwxeVxVz9o0iAM?=
 =?us-ascii?Q?N1i5Wx3zAkZVteTAsRrWgUI6gs6UtBHG88+N/NNii4gHqLWtm3u5BYn0Aem9?=
 =?us-ascii?Q?9ywGAXz9zDdG+isjFX0n2/OLbwVJE73khJ0WYl/9yWiOFbuU50QiTWgsT+OE?=
 =?us-ascii?Q?b6QWfUtromBNr4NujTNcEqCLfFGIUNSL1X2P85frTC3SJR0kSHsrVZjrarN2?=
 =?us-ascii?Q?JGtJSx+9Um1gFSz3Q3le4bb/T4DMCiwtJ8jYIdyEwWM5fTkLDFWjciPuF3B9?=
 =?us-ascii?Q?Q9f5SrjFCVb4RjdgtEwW1yR6r48tluck8M8dt1lFGdnk6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b478fc-dd09-47ef-2012-08d8f527b69e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:03:39.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zw1m+LtYdkcUyLj5wUogDPZJjfecLHsyjdi4FtslBi/vyano6gwtrIDYR+0/fT4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:

> DMA page faults are delivered to root-complex via page request message and
> it is per-device according to PCIe spec. Page request handling flow is:
> 
> 1) iommu driver receives a page request from device
> 2) iommu driver parses the page request message. Get the RID,PASID, faulted
>    page and requested permissions etc.
> 3) iommu driver triggers fault handler registered by device driver with
>    iommu_report_device_fault()

This seems confused.

The PASID should define how to handle the page fault, not the driver.

I don't remember any device specific actions in ATS, so what is the
driver supposed to do?

> 4) device driver's fault handler signals an event FD to notify userspace to
>    fetch the information about the page fault. If it's VM case, inject the
>    page fault to VM and let guest to solve it.

If the PASID is set to 'report page fault to userspace' then some
event should come out of /dev/ioasid, or be reported to a linked
eventfd, or whatever.

If the PASID is set to 'SVM' then the fault should be passed to
handle_mm_fault

And so on.

Userspace chooses what happens based on how they configure the PASID
through /dev/ioasid.

Why would a device driver get involved here?

> Eric has sent below series for the page fault reporting for VM with passthru
> device.
> https://lore.kernel.org/kvm/20210223210625.604517-5-eric.auger@redhat.com/

It certainly should not be in vfio pci. Everything using a PASID needs
this infrastructure, VDPA, mdev, PCI, CXL, etc.

Jason
