Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E68F34E985
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhC3Nqq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Mar 2021 09:46:46 -0400
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:21217
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232165AbhC3NqZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Mar 2021 09:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp3LhUC3x8c2OOW/vZ4+J1hwuctRd9cZVl7MWupZGhJBVAGZiQuctsg93ks81PXA9GJi7TM3ANFw3TUp+1GwnGrfBg1jmTiJ3IVxhjKIrLzqrcITGCdSaVRPeiC9zDtH/zUqos2Emp4QonWsL6YhbZ9bUrzzK3QHzXXoLbZLcT9VioLRiqOOJYwGe1499xgq5/1Lo1Mm0VAoibuAXNGOjhGSI7P2YYbd1H0HMF+g7XyzbkF3THeFpWdBKFOclsA/VkLYPNGJ6j92U7Z6j3Io+6jCspnYkVzivEABNZPrULMDdafEfQ66qXSE5FwV+BrhBbffGUioyakW/IWNEfuVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzICrweByfFjw+vWK2FIyaa44HA54eR0gh4sxM92Dz4=;
 b=ftSbXC8VhSegvQ1QaPW2n5DFTTlomRnUeeLp0PQLVY6uET2eqwqzTjm1ou7etneYqSQuiNAtA97QIM66jM8FZkPrsoFRL5GpfwDduOS21QbETBpwUv8859MR0mV8qqLizVF1PagqWrQWG9bKpnyKb+HAAQsN4BPl5W7NviBaAWLc3VqQCIuyDGueUKqyn8OF8EjR/CTRdfXyn/eP7ufxjaQFtodC13jVE7FMrM5PGGiP7S65ejBSPkFUlZGg7meRQsOIt9szMeTj3ZydddpdW4zeF+0U+z/jUIFkeeKmC/L7q1/UfRTmF207PPSEdZNwgdkF1cWtv7BYoEhCaw2hFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzICrweByfFjw+vWK2FIyaa44HA54eR0gh4sxM92Dz4=;
 b=bq1fFYPuF2Wy8rYG23wbY9SJxFsJKwYasqjmV9GaZOHInfhZOBWc0zUVXBMsdpjdEh9RGRuLknm8D4yBGs3XxF9+pO5hefkwzu6QNpWqcrn1wDIh+MIfM8M5nHdBKdt21lSLjMadKl0XSYieHb3M32w9B1la4drhBfHlD8QJ9KBUsD7fkmOjlq9LfEfxZzus3NmaAdLE8t+6M+tbZmGvqRhgVWgKNU9ueiZHJ2BXDwIiAQgcYwNKoFFeoPdaPBN3qgsdHURfBoeCbjLNgUmwfL3vrwBcDExCrz7NzkinasXupLsJgDOPbtam8QgJF/f8Z7XPbJ+VUrXEja0XZ9SQrw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 13:46:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:46:22 +0000
Date:   Tue, 30 Mar 2021 10:46:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
Message-ID: <20210330134621.GQ2356281@nvidia.com>
References: <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder>
 <YFxkNEz3THJKzW0b@myrica>
 <20210325100236.17241a1c@jacob-builder>
 <20210325171645.GF2356281@nvidia.com>
 <YF2WEmfXsXKCkCDb@myrica>
 <20210330130755.GN2356281@nvidia.com>
 <YGMqwPnYjSfV+Cbr@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGMqwPnYjSfV+Cbr@myrica>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 13:46:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lREhJ-005tgV-1N; Tue, 30 Mar 2021 10:46:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c891ea47-f285-49b7-ba45-08d8f3823463
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13370C3FD04C260BF2DFE9ECC27D9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UgNYu37RlZGxk4zuyKy4PPK8zvxWjukj9eDXYs+acV1r2oIPfTdFvylf5XWCiVO8QZEMZxjjqCiQLa5aVwMlOshqzjs1yJE9fjcD0rbQ+SntCOpNrpoZdG9uiQoe49fT2fjhc+Nz7a62smsCf2qsq21OpyyaubcC0MrfE0mMWnN8bty8nTn3RlkVpzRb4a9+apBHI2Fh1eRloOSKIxE/gKzbX+LWP7GvAuZmp0X3i+oZVqWM0I75M+88l/uK5tG+nVCSYVclCEa6NQjbwB+UKuWMoGterQ2zxCnpxbdEsrH9I4PUv+v89EnqcvT6grKqAZBY75p+ttqrS1S/1aIhFFYlbpF9ZmVYI0pm514YYyTAjZL4LMA1XZ3gDgc6hAgFhihhctn7gvpRexkhsAwN2NxBwiAVrf5Q4Oq2vBhHVMb39DMstDkftuEW2DsJBxRdy9HDd4c7+4jI1QUc5OdjBfpfZm65ec/7cjaSoegpajQp4Fkc6Sog0g6Eh3RWxtdbIuGzw4ATHAktYnq2j3P9bqS6tuBGzA6H1xoqcQ83hF0ZY1rI1xW+50xRglp7GGs2+wX11GSibs1zhlczan4waqS8+fxzk7ouv1ScXXmPYslWJzDOzR1lACxhLD7Nbfqa9z6HViUkLQCiNCqcsLXrX6xz/bdsNLymu+82pQKE8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(478600001)(186003)(38100700001)(426003)(316002)(6916009)(1076003)(33656002)(9786002)(2906002)(9746002)(4326008)(54906003)(5660300002)(7416002)(36756003)(8936002)(66556008)(86362001)(66476007)(66946007)(26005)(8676002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tKvH9UDXHeZ1lS3yPeSHPSg1Is2LHuMthqCJxC0shxiUE2PdqsZrEOghYgUm?=
 =?us-ascii?Q?nX8LJ5D6tTLNgpxhXkEBjg8HV8MEco+AcGL1O3GJCxGaHblENo0d73T0j3gd?=
 =?us-ascii?Q?wn4CxsFdROdttu6n63rEhWiCAoUpdjqruwurf9JpMOUDt0g+edmDShehMX6H?=
 =?us-ascii?Q?2XccY8+gLji0/1HkJIjm0zGoNoWtpsGCtf1vbmFg4LmyNty40aS474Iw9eiR?=
 =?us-ascii?Q?GR1AKRZW7D4dj9rmzuE6Fn5xobEcQUjWEfFW9gGgTsnqeikwamScv8w4a0Dt?=
 =?us-ascii?Q?7Y461yXse3Yh6W9HLpxqBhjcYpYLKlIDKYcHpzsgMCX+3AbfJyKDf2QLoJ3o?=
 =?us-ascii?Q?ei+2sq4a6jTdNgaRh+FZQWKBRu4OrPdbtHDjR/McGiDnQ5dhnJ68Q6PGFMRb?=
 =?us-ascii?Q?Fq9UlyJDdNyXLVAqOXv0ZATjAgT1KaB8jgPF1SCZSqunYtxhCMDAFx2AidFu?=
 =?us-ascii?Q?MvktR5WNyxNi8djMqOEGs7gsDBv91jEsQs/lK4icO2eSsNsv6trmaNSM7Fq2?=
 =?us-ascii?Q?9khWJwTsfKXSaictxEgENbux7nl+wMnaf7bvevd/RhaIYb2098RmsvW7LkWA?=
 =?us-ascii?Q?Znugif01hSX1JO52Or9GF6cDGBWaOdPyHn04rpnaoFqNDiHjnXzWqN2zlXLz?=
 =?us-ascii?Q?ZVQdwvloKrC5g+S4RDXHLOMsvgXgoFFYhQgd99Sa694bje3SLPTaQuAvMHpb?=
 =?us-ascii?Q?V+uFG+nSBw3xvih3LXiM5CAGe8hXq9XkIeyBEBEyCD8mOPuZ42Zf+62jZLjK?=
 =?us-ascii?Q?jMfZv24rKx3mYlw4y2ZPEDkMZNeFyCJhT+5CQhRulqKUvw7jFPiPqs/q8HeG?=
 =?us-ascii?Q?4yu8rlVtx9wdxNV+pK/h0qCiuOEGj+fRl9ejZFu0kspX0wLFMO2x+FlP7QvS?=
 =?us-ascii?Q?W+e2N81KAGuEWaIND+vXUrGdvglVCzzoP8ZbseXnBPucscde0nbdoPGwTqwS?=
 =?us-ascii?Q?FoANj1B7ZpLK8VRnP4D6jbzehLumY7V2XUJgxB6/w7qT1Z44aeK2Ta/iI4bs?=
 =?us-ascii?Q?It+aIQx3XH+DMI9rc0IMu0Anhz+RERbEl3ivv/BNcS/bBe1Jcp3vUB5a45rR?=
 =?us-ascii?Q?x8cr+aWohU77vLM0EAevT6qbQkdZdKzvdT5pxL7GV2iJlJe/LtnwhQObrH/b?=
 =?us-ascii?Q?bPtHZy4vNO93zgBVheHlMt90hiydat1v9zz9JxeewMdf7oHhKfkPnBN3TOBJ?=
 =?us-ascii?Q?OMY+0QFjaHUkAzH1Qdrg8yKhxf64HMA6uIisDRIYaR1ysYevNEptDfqfX5wO?=
 =?us-ascii?Q?tJT6g5KmPVAN6WjzJdqBLaOVk8VMGnTgxlKI79T5XaLNsTvSrBXQsk/ru4cP?=
 =?us-ascii?Q?jiewla9CJeuMK+I3E/g/swo2Ghl6q3Q6VwlNmdzFiRt8BA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c891ea47-f285-49b7-ba45-08d8f3823463
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:46:22.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAC+bgwY1N6sYCKcis4DJPGJU/F6dl60uRX0rr7MNKHLMIpS68f+lfphcliv7LXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 30, 2021 at 03:42:24PM +0200, Jean-Philippe Brucker wrote:
> On Tue, Mar 30, 2021 at 10:07:55AM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 26, 2021 at 09:06:42AM +0100, Jean-Philippe Brucker wrote:
> > 
> > > It's not inconceivable to have a control queue doing DMA tagged with
> > > PASID. The devices I know either use untagged DMA, or have a choice to use
> > > a PASID.
> > 
> > I don't think we should encourage that. A PASID and all the related is
> > so expensive compared to just doing normal untagged kernel DMA.
> 
> How is it expensive?  Low number of PASIDs, or slowing down DMA
> transactions?  PASIDs aren't a scarce resource on Arm systems, they have
> almost 1M unused PASIDs per VM.

There may be lots of PASIDs, but they are not without cost. The page
table behind them costs memory and cache occupancy, doing the lookups
hurts DMA performance.

Compare to a physical addressed kernel DMA (like x86 often sets up)
the runtime overheads from unnecessary PASID use is quite big.

Jason
