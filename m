Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0F351CE9
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhDASXB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhDASNs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Apr 2021 14:13:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9A6C05BD3D;
        Thu,  1 Apr 2021 06:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSiOxOmWdaaBT8v8QQmZ2Up8XwlM1MPBEwJ8zbU5qkBARiceM4mozKBTqpM/UT0s9Sc47UD95tXU3QZCDA+G15+DovYnO/Ft2xsz1z18tWeVgcf1YhPaUmX/H7UVZdTab8NvBYsWeDGuwhVD1z/CHOhBt+394S+VzGm7Qjlnd3x7STiS0aV+3ozQXofxDdvMPRzzSaObTferaoM19ECfl6N/IMkiIexYg2tJ5UxamJuygGwGdoOTfngi4NsJqzvgRB7WH1ulgPfPsE0Yyu4mFXq4RMBOkMhXfso1O9bnEX7jvh6gzFHSjJo9Kb1cZR7X43umvSUCB41jfo7iwRTuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTePrFjo+hnvFWhbhxOpSCw1Wyy/aCiDz8Wsh4y/Zfo=;
 b=ZMarxmBozQq61dWuOkP/upfN1eG1JJtuxciDiwdFLQlyZ1lQvlP73phQ9g2WTFCMiQv6DU+rzOsg9LIS3WakUQ22dfDI4s8KknKySOUPIDuzaNRCTT54mqsWH/xjusIIyrZGToZoRCC0cqVBa35Y4lACxCphbLZQAf6Dbw3M7K0rSPd5Grqi4mkjjNcHdRPdscZSuZ5osTCzfspjIzfH/lfqEic5fGpAMKGKeNWY97lB6i35JmV1oSI6xy7v8ORqDZy/Moj9VLw1nWdRMOZWfn+SIWDj8yCJWjrTmZJyS9YTl+57rdy/Zpo+sK3hJPOwmkSG8Fp9nue5lAhW7LZMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTePrFjo+hnvFWhbhxOpSCw1Wyy/aCiDz8Wsh4y/Zfo=;
 b=qDLG9IShNI4x4anKv4nPoRYigkOuei1OsTIg3i0FH4ltnvmUEWmnpImwFSgoaY0AN2oHJpUvJTsqhyJn1eNAtNufJ9rW3ubNn94UkpeQXUVwVE9uyaZbd+AESba7MCk7EUaQmND94Yxokd/ua+mb4SseuBi4eBlikfrRvQEptWh9dgnrObf0/wxzScVSLjJ4OtzUQo27H30I1pu21iOhTFAgTfapjr5YGSVoRHHEqmi0SK8Jpj0jprSXJAlrorZEtp69LvqLjEFGSnEQmbYuewZtIYBCLoB6MjiDUuAqpjV3KXVUTt5w6JCWQIlneqmnDM9P6Wy9Ca92gja3F/E5CA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 13:15:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 13:15:34 +0000
Date:   Thu, 1 Apr 2021 10:15:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
Message-ID: <20210401131533.GD1463678@nvidia.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:208:234::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 13:15:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRxAb-006kZq-6x; Thu, 01 Apr 2021 10:15:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 943905cd-e400-4738-d10a-08d8f5103bc7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1881:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1881709B95562AD7C5D6A0F9C27B9@DM5PR12MB1881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsuqMaH1rgQT8Rwm7pLdhn6EHqsy0izc/DTZ8F7n48aTBNgZwGH/A84dXM4NhPBuhjb9xpo8/36MDf8cNXrhFPPt6M+1fsy+rtpCoQBkw/TbfTqzOAYfm5PU4NH4nN+VRz+ie8+brl+stIrjQKwMHx4vJoY/xnkcKbpkPCyS0vQWkB37dO9mgj0V+nKqMHbSUL2JK5pH7+sIWwFgSmP8c2O2fVIHnA7FSRyZ8ld4geb3622nhOTc3e2gY2nUnkx5E4yBDw2+rqa/463osoQszzr3SGknMFqEXlrO7ZUnU3sepq7t2THFffX4OSLlv1HrHWJX7XkjGEVY9vvo2AFYXdXPrZYfDV40h6fMrZC/A6yJ55YwosVj/7ybSXe/ONyLAhwXT0C6/PktFnqrlON7muI5+SvfOwAddkm0eW2NlB2xoPaalCWbnBMIQ5+w/y4nEGjfCXe08QnxMp4KzP+wSRLbBl/sL5EmxADpjEmo0sOhHXvX0Tr9NannvwFTbmph5h1G6cAIZkHy51csc21wpqyeMyzuKSmXUtvSfF32FWwNbDv0tZfwt8NvSrXFFyyooAXg1txkMBr9dXO/6KN7aRvzunupanQOUrRllebEBE3ewqUUbhCxWx40CoZtdr1HGtEhDqie9JMUDlAf+rECPfBJYKxkV52BNnHJ9IF0fu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(36756003)(66476007)(66556008)(7416002)(9786002)(9746002)(6916009)(4326008)(38100700001)(26005)(426003)(33656002)(186003)(66946007)(1076003)(86362001)(2906002)(54906003)(5660300002)(2616005)(316002)(478600001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eCXeXaStzjRD0cHPVnjIWm5ZI1/IIUDLYMmqICXV3AL72g4ZDTfI7315XkfC?=
 =?us-ascii?Q?d4idI96igYsS+0iPgqeBT9lHnsiqyj1S8EnRJRQOszi9VL9ohIDyjsp3Zkm0?=
 =?us-ascii?Q?jQh0RY1lLx2NLdQnkD1t+CLnFApr8zecjuggNkNnT7ckwPYuBjJKKBvtIfN4?=
 =?us-ascii?Q?MHpUtkBdHo6c5X3sknLds5DrUX4aMLuRWoMHG2OG2YE/QrCFKHs4/Ncx1lhR?=
 =?us-ascii?Q?bAeH4LjGzkq+ztd3ISMvx8Piw8syW1HNsIGHgJIHeUagvHHE9qa814z6XV1a?=
 =?us-ascii?Q?ye5z7jo2M6OGvNyMb+sXNI3j+rypCWOlw71d+525JTFQmChuji0/JsdYHLyB?=
 =?us-ascii?Q?Jsd/kEwmL6XQ7PrETRPkv708JKZ5L//EWUyUJiajgWrRMQwbzl/5RvilHFHv?=
 =?us-ascii?Q?Qq/Udejn7r0ZkKxjST2D8uN2dB2G8Te5Jq1phqHrtsGtiHydmCH9tI3kZTHH?=
 =?us-ascii?Q?qToytomtbw+VRhBMFZ4gQj5U2h/u9kaufmiUeXkFPYThV54ZMWQLvAYoy69g?=
 =?us-ascii?Q?FtX/rm9/SNMRHGIMHBoE+AMcgoDZxrvdERBSToqEaQmLro/k7x5deic6/x1n?=
 =?us-ascii?Q?kaTKM2zQW6peUTKNoAwJYQpwBwqsMu2J2DhwkLwvdf7hdQF67kGHjyLNgZSt?=
 =?us-ascii?Q?SWwIcvvcI5YpjFEuD/nVYp25ia1W6gVl08OkNoU2clokmWgK+q145i+SVnNY?=
 =?us-ascii?Q?jWntaHXx1yYUBWfellLvY+NRk/v17QrXKQ7GOdVOidglEW9sWra3zoSOn3G1?=
 =?us-ascii?Q?ntELp2lEGadpYe3rFb48TtpSQSczoaQ8k4k3iD7jsZF3KiHpPi7HuxVfq+el?=
 =?us-ascii?Q?oTC6xERPExRf+KboZe6Wu9bluoRypkpJzqJ27N5uOOVYJkabsKxF3jNkjonP?=
 =?us-ascii?Q?IV2rllzunnj7OE+ak6OLsE0T1R2+F67rQAfSSI22XzL332Pdm25f5lRAz8X+?=
 =?us-ascii?Q?0L4yd3M2ok+8rcWWezAZ8IN9BLD9lv55muSXa2oQMmbJnyeZkWRfDfHqP4j2?=
 =?us-ascii?Q?k+1mZFfBQfv5LXQMLkFYgSxJJsn9Ou9wemA1pd5mpJvg1bc89k7nGHuSX67b?=
 =?us-ascii?Q?im1svsRWfpjSAWoIrTx+PePGc7VYjyAkQggPxlkfrXaFeOJXDjMZ/y4LWvA3?=
 =?us-ascii?Q?93OV2sTZ9bu7BkD4pj0b7kN42Ta2zT/UeT7UURTIzLc+R0d/DOuH6bchMwqs?=
 =?us-ascii?Q?Bw5eHhGG5r1U/LGq4x7dtu4M0vhNmG2DYeS5ciz4YnXiFKf6VXrjQ0GgsnXu?=
 =?us-ascii?Q?fZRi7tSJp4VvfM5+eZ9zEP13CnPWtM7ZkpioVQq6NEugwHAspfDhB0cDBXa1?=
 =?us-ascii?Q?2sqWSEFBlWKODo9pjrsjmkkukoUO6uIhWsenfMvJ2Iyqxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943905cd-e400-4738-d10a-08d8f5103bc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 13:15:34.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSKNKnvB0u0/tAmHhqixBH1oDsJ87KbwK4N8YzUXjcQjveyYAmHZN27ong18TBKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, April 1, 2021 7:47 PM
> [...]
> > I'm worried Intel views the only use of PASID in a guest is with
> > ENQCMD, but that is not consistent with the industry. We need to see
> > normal nested PASID support with assigned PCI VFs.
> 
> I'm not quire flow here. Intel also allows PASID usage in guest without
> ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without ENQCMD.

Then you need all the parts, the hypervisor calls from the vIOMMU, and
you can't really use a vPASID.

I'm not sure how Intel intends to resolve all of this.

> > > - this per-ioasid SVA operations is not aligned with the native SVA usage
> > >   model. Native SVA bind is per-device.
> > 
> > Seems like that is an error in native SVA.
> > 
> > SVA is a particular mode of the PASID's memory mapping table, it has
> > nothing to do with a device.
> 
> I think it still has relationship with device. This is determined by the
> DMA remapping hierarchy in hardware. e.g. Intel VT-d, the DMA isolation is
> enforced first in device granularity and then PASID granularity. SVA makes
> usage of both PASID and device granularity isolation.

When the device driver authorizes a PASID the VT-d stuff should setup
the isolation parameters for the give pci_device and PASID.

Do not leak implementation details like this as uAPI. Authorization
and memory map are distinct ideas with distinct interfaces. Do not mix
them.

Jason
