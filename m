Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC31355400
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 14:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhDFMfE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 08:35:04 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:2043
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236291AbhDFMfD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Apr 2021 08:35:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB8R6kIBAd1Ye+zo2U0kuSfwQkpTua9VWXAC8C09z/Giiyz7VbW6s3d0lrtJDbiHeNzeuV5zkh56Fp2A//3TbQ2Dvt02/mMww/pdd0JB08w20x5qubj0ElDNK1CB06t6t2NKnIidDXbHYT/4NYsLkEuBtxIPpiIgyAyV2B8N/BeXVai+2/1kpRtLdzsF008xrNk1Y/SD+3y7jMGTw8B/JcC/J96sJZAXnmGQnW+eGFy60LsTTh7uaCOCbdvcIQIONG1GkR884oCuLUtqP4WPxcrV46i/CvJhWlPcRjIUQkioJ2fCWtMZapRWlZX7Si+nXfOSZ0+inGsSPQ4xW+uwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=487PkQf+U8PXv/fDH1TQwHED0SCO9RSfHacBURVdHls=;
 b=lsrqabmgRwCM8DxnAuCyI6BiOokerA/PVk5zNNbp4pOjHTEamVFhQ0EEDeShsv2T5jHJWgxLaKzc4pWOqFXRytiUkf3C5B0YJdWT7ZO2j193f6GGzMWCwAvriEKQ8nQniyRIdd7n/6ns8XOmfRiWYgEpTHdhEyRXS7jU7trIzBPbhL9IkgLY66+8IU8XxtPruYdoH1UrVmc66Nv4hKpCvt4yeW/h47mFssELE70hxpXGc1Q+fhbSVl+S2HK8utpxCD1A9x7ggLN46qe2LaWFStg6aiRa7hcQ5LhDRUlRcB5cE3sMCVo/ivV/Q9XxhPxNgdQ6LOx8H6O8wW+wGpbI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=487PkQf+U8PXv/fDH1TQwHED0SCO9RSfHacBURVdHls=;
 b=P6DL8N7G73UXtTIo1xlCjX0yg0o4XiKraNCwtOrC8t2oGt7bOuafqCR4T9PP1S+ZLSZjjh+KmonGGCEVjUDgSj3LPGsUcTBsXlOBNbegxzu6XT6ELX5rLht9UaUq9hwlwXon7RF9YSiJ7SGaJ7AlushzKV1XAKi4MsDsT7om3DmrGjbqpM0XO3TFg92beQ4llfTgvh5xCOZBAqVjR54yxCvGlNGGmhQtmpbi20J4LQpUMSrFHjY4xBb3vCErinSgJev871zsuCfHbfI0sGcXUvXwb753gjaG56jK4YUH6F2l73JU7u9o/mObS21i+8Li1WoGk2ckxaUY0Yb7eOOgSQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 12:34:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 12:34:53 +0000
Date:   Tue, 6 Apr 2021 09:34:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210406123451.GN7405@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <MWHPR11MB1886CF7C11ECE0396A0215078C769@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886CF7C11ECE0396A0215078C769@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0223.namprd13.prod.outlook.com (2603:10b6:208:2bf::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.13 via Frontend Transport; Tue, 6 Apr 2021 12:34:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTkux-00174O-De; Tue, 06 Apr 2021 09:34:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b5d7eba-eb8f-4760-ab5d-08d8f8f86104
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943A277028CB62BA733D5A5C2769@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aM/lZQNCDPAtlbUJ5y9Pm+2bSlVdcbZBLlSflvgQA4DzeZm6KMC/j0ooC+JKqvp7tJa1ywSwphlXvyP0eLAbKJW36GkfBpN0529ZLJSE4Ez3H8/prlhW32x/nK/MrgbcuotoF1tmQc5UDCJW9gv0fAcHpwudFQDVKph5RjenIuFLR+YUNG4mgu3+/yBX8/vMfU3l9/TAXQStfGbl51RMI5biTnViWe4i76H/96Tftu8xtH7D/iY/me2Bxqma+NP3/eWo9NdripYSn4mujUYUnYYp1O6TY+P+bCEddcnCx6GGJvmasFx1LyPfGfk/D0leew/Nb3o9GZ0ZcbECEWHzK5j6c9EPlYhdps4QrZ7EFclSieo/fiTuC0RPd6Q8/5XateaS/ebvppDM8KBHHkJiyHihUM40yjW7GjWL0QH7QTxbWC3A3VzTtOLeRQ5h40SUapMotiFgNnHOBZk1Vna+nTBNKUAtQWxivcrllPi4q4iW+QP0eUWgjIrVPn9MeZdnFChX6mnZjpXaJoOvxCCcTvEoCSsI+md28KLrZEcDRCnhyAznxCbo+MGaztC+NyFJ52CuB9R7kmzoDTDiTl93JroWJx58r0Yl9msowhb/3NGxnFQsb90T5+LG54b8mlDWmZGFY+5R+Rk8Y08FJd92vsj+vVfol9jyNscwSjT2QQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(316002)(6916009)(5660300002)(86362001)(9786002)(478600001)(38100700001)(8936002)(426003)(8676002)(7416002)(4326008)(186003)(36756003)(1076003)(66476007)(33656002)(54906003)(66946007)(2906002)(2616005)(66556008)(9746002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bZvKKWawrI4qOvHzo5nVM3804yPkhJGO8ChXbQfs+/CQh0MENowWQ+ddS70c?=
 =?us-ascii?Q?fMhkRNo436GrsXR1PNcz9JBB2Z7cztWUzutj1JtAjc6V/+ucPRGxoa0lbiAc?=
 =?us-ascii?Q?uq2NVwKTZ7MoRQLNsWEJ8sSf8KadFQrB4hrjcO+TQaL6dUQXROan0XU1eBpT?=
 =?us-ascii?Q?ka/K5zaAjVraj1Q8rI34zhl1I62cfRAQbR/rTm4ds+sGefx7bdohT8MBXEAA?=
 =?us-ascii?Q?XkVT3e1ZJgSsenvJ4aVuTlQkURVBaQl2rv5Xthc38zcT0g99vGBEJQsDN+NJ?=
 =?us-ascii?Q?DgrH3CUaPoskmruj1hwa7II73yXAf68ybfHH6Kp9ULc62GiiWDO0zE/cMYLE?=
 =?us-ascii?Q?XchaD71UjbHma2MX3WRYjod9h5x8evqyquDgf707PdE1Ocw/m+PAOwJhyTGC?=
 =?us-ascii?Q?i0EQYmPMnPkJEKQ5PXU5duv+BIAAKa4onJCky+jpeDPUsjeyRm8kt1Vw8jpK?=
 =?us-ascii?Q?dWeaLk2ePjl53Ib5XMPqPYgIThAtM2JlXD1odV4CuMMM8X9U9aWDKn+p1V+h?=
 =?us-ascii?Q?y/02uNINBGdsoeN33RnmVDFzAl3f8FotLWDidJO8CgGlwaSbJgadV6StP1ai?=
 =?us-ascii?Q?Sv/O6Aewk+6fOyv6v4iOAAIvP5fKFQ9GSw1KNqzjO4TEETp45bC6PYGPMcwB?=
 =?us-ascii?Q?Vp2nShhJyaSntBjyedJ9T2ktTxAvqdinYsmaVD5im9Bvmrw/iwFFuYi3e4ZQ?=
 =?us-ascii?Q?uiLCzoXbINFrZQl5+8KJoljwm+mhc7NzfXtG1PgKpYHqf9f9im9Xmbeg8wGk?=
 =?us-ascii?Q?x9XAtoX3O30bJNW7Vtj+Rh2MYLmGHvb0lavuq6GaLsp1FuX1AfoajqV4atLa?=
 =?us-ascii?Q?hQ7Gm57qaEvYnJz4vrW+MTF5kBZ/YWlpebPIulmyOhpDAL7IejbRpZ3P0mA5?=
 =?us-ascii?Q?sbA9oolWEwmHNld+IPfuCTz8veSwRpte6PzxZAEOsTdHDZodVKDFGKWckKSC?=
 =?us-ascii?Q?sJ8h3Vk+iHOFCBkujh9eW1tMcGMrrtXGwRLVmaH2pUte+xuUTivfh240APUI?=
 =?us-ascii?Q?plgnnfvnMpfvSf7p4mtrA1dMAQ7i/wbh6Si32H3eXZnghZdprHZcWJwBLqAv?=
 =?us-ascii?Q?tlMnItQoWxMHjX1mI3lfW0X9OmVyPk7EheIl+MiCSi49OTcsX/g+N3KkhAFI?=
 =?us-ascii?Q?qsEoSTHzAPSnMUV2YfWAkaVY8w5kyNZzvTCPpFIvoCsQf/fBBR516ILTgKuv?=
 =?us-ascii?Q?1RRQfz20XSKrFTmD38t3rxNlQc5N/Rx53feecvwA4OILdBJyZVqFWkzsFXH5?=
 =?us-ascii?Q?WaOR6UgtNA93noirH11di1Wt/W5MLuaRNk1pFvIo/VFuEjRsFVFJP7Iynq1b?=
 =?us-ascii?Q?S/pXt5W0+augG8uloE1yMZp08hpcEx6PPRJbZdKcmmhSPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5d7eba-eb8f-4760-ab5d-08d8f8f86104
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 12:34:53.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UthfOcIsBkqUn4gr83s0kemYcP97edxI7Oq3xC8Di8gkeyO625GpXjMsgF3lQ/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 06, 2021 at 01:27:15AM +0000, Tian, Kevin wrote:
> 
> and here is one example why using existing VFIO/VDPA interface makes
> sense. say dev1 (w/ sva) and dev2 (w/o sva) are placed in a single VFIO 
> container. 

Forget about SVA, it is an irrelevant detail of how a PASID is
configured.

> The container is associated to an iommu domain which contains a
> single 2nd-level page table, shared by both devices (when attached
> to the domain).

This level should be described by an ioasid.

> The VFIO MAP operation is applied to the 2nd-level
> page table thus naturally applied to both devices. Then userspace
> could use /dev/ioasid to further allocate IOASIDs and bind multiple
> 1st-level page tables for dev1, nested on the shared 2nd-level page
> table.

Because if you don't then we enter insane world where a PASID is being
created under /dev/ioasid but its translation path flows through setup
done by VFIO and the whole user API becomes an incomprehensible mess.

How will you even associate the PASID with the other translation??

The entire translation path for any ioasid or PASID should be defined
only by /dev/ioasid. Everything else is a legacy API.

> If following your suggestion then VFIO must deny VFIO MAP operations
> on sva1 (assume userspace should not mix sva1 and sva2 in the same
> container and instead use /dev/ioasid to map for sva1)? 

No, userspace creates an iosaid for the guest physical mapping and
passes this ioasid to VFIO PCI which will assign it as the first layer
mapping on the RID

When PASIDs are allocated the uAPI will be told to logically nested
under the first ioasid. When VFIO authorizes a PASID for a RID it
checks that all the HW rules are being followed.

If there are rules like groups of VFIO devices must always use the
same IOASID then VFIO will check these too (and realistically qemu
will have only one guest physical map ioasid anyhow)

There is no real difference between setting up an IOMMU table for a
(RID,PASID) tuple or just a RID. We can do it universally with
one interface for all consumers.

I wanted this when we were doing VDPA for the first time, now that we
are doing pasid and more difficult stuff I view it as essential.

Jason
