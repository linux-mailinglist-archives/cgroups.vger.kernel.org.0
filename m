Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C048B3718D5
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhECQG2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 12:06:28 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:15712
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231133AbhECQG2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 12:06:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4ZVQJYuFxTNKhYHeKYi6G7d3PPAQLd9cK756ACgjNbq819PDVvzdVMqEAfd/tfzunyB73bJSTwrD/ehxdcRY7NHVUiz+hAmZMFzp2mDmihPH7DE1rtFq1P5I3xVEn5h5YPFZ7WlswPMHdeYCELrZIJP6IFb1dcv4juKzYgFJygk4DSej3TH8xJOP5e7Bp6ZWTkW4bX1YeQA2uejxx/0Ew/bfQF0KPObn3+qB0KHOoEybTGGRTRvrAzV4CJ5YY09Fop5wi4OxQfnSbkhDZIPzCTzCH2EAw5w7jGa+kwNcs/kuzOdKtBrjjvUIbSXV/Xhq+2+2aAP14ywRbeSkl6dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L2XLVuc7VtR24tCqFEn2YxELbEwg75eNiDbvo22F0M=;
 b=GhQHgH82TdZ2PFDTCR1flkJ+6QZVrcKlFKP48AL52K9zCF10trOCIEL8j6sGfe3KjkkFkwRFHoEkzYuVx5+9/aHL2MBBLak+Cje4pksax4r4TcEkrpajp2TD2AndjCbmV/UQKpvt//PJbpJLJgiCSrxXOwoZ/EuH6frFjFgI0vRMMAgoDi0Ck2wOd9X7+KppVXknOb0co+TV20mil1mlbF7266V7sS9m7TbiAKYWjj6NssErLRrBo4l2yidCapW3wJOnFlvVY3pZNz12KiFst//VNYiOERWHIM1LHex894VHh96zqrWkvcFXq1O/F55+5zszlXu6Fc0O2AXeqwo3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L2XLVuc7VtR24tCqFEn2YxELbEwg75eNiDbvo22F0M=;
 b=Wi7jP3Ea0sNIfYfuQeaSDrlS34K4gqZS5x4Pg+QEIud3Z02mZAWx5HZgjpuYWrkT7eJ3LdvBnAV5QuU0IQKDneOoiC4TYCpPHb2JT1YNbZBvHbeYBnbe0OxpWwEb8gNmFNrwenOz7vNtSiGqx6J4/mSyD21SINIpiTSKb3r3/sQmE/0BxURvtgEpHb/NEVmfRDJTdL+rP12eB+buOokStKYziHuBQ5Oi9fERdUTBZ76LbucCDPLn2wb/1dBL0K76QR5l5+ERx0INnJddj5Rj9oKPceVv3udORU0mQ2/zHvdxU35y1uFGS/bRXtvZoLWyMDzNYDLcGP0S4BlvpJH+Uw==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Mon, 3 May
 2021 16:05:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 16:05:33 +0000
Date:   Mon, 3 May 2021 13:05:30 -0300
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
Message-ID: <20210503160530.GL1370958@nvidia.com>
References: <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com>
 <YIol9p3z8BTWFRh8@yekko>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIol9p3z8BTWFRh8@yekko>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend Transport; Mon, 3 May 2021 16:05:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ldb4c-00GNw4-A5; Mon, 03 May 2021 13:05:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8afecc6-dd9b-470e-2422-08d90e4d47a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB321267B8E6823D61FD815BF8C25B9@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jz0ZBLQ+DBqavnStXwHKVIwE8+mqp4QGXSsWa6j1gRKbOOHmF88EL3em1cddXI1Q7w91HOxtzHcyLetU5ZoReI8V25QWC/n6QxZae33KZoCx/2Cw95g+Hl7SvwpAFAefCqAl6CHq1Mo0qwv87bYbVTV966hcaBGnO4Ho/fXJLADi/oppuWKbwaj1DHnjAPEIEkLGiBf1kGxlBu+MkKTsY3MS9LXrm7nGk7agb0bXub8gssmAPzNcYqyijm2Ie4g+F8qQXwQY8y3LYZK9hBlzSXULDtMSJE6JQeLFcu2kmKPwdbXljx3kt8bfD559ppvriYVku+UyH2cR1g21bUc+eI0RnP5TRQZkeb+mNTOG19k7DKsYN20frO478qm+tE8Nh/pTDB3cwIUlf2wiwxIVvMbLrxqouoFltqcLaJjQxe/P7I+K7pwmOK/88O5JwTKPotK5vvlYQSFQoZqVElB4aQKBfLwht6G9lFdUPlXRT5Dtx+Q8E+JAG9Hu58dTvd/oOlE3j97qOFYgNS62G6xu0y3zGQjRFCcpAuaG5LlTrgo+kep5+EZBXPOtkz3iV1OT8jEAswcm//wDxzoYfRvvdVu1DkSFSjVbG7r4BAZccNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(8676002)(186003)(33656002)(478600001)(8936002)(38100700002)(66556008)(1076003)(426003)(2616005)(6916009)(36756003)(26005)(2906002)(66476007)(86362001)(66946007)(316002)(7416002)(9786002)(9746002)(5660300002)(4744005)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cJkb6uk4OhwcMBnNmeJblzK7mFZZd/ezDOw60xiwGPKX2b3CjCmrpu4gqFJi?=
 =?us-ascii?Q?DZIZ0Mz8WEornubgoca77jG4Gz4UEJj4Fa4hvpHhmZA8hyCd8ogrKXX9DdvE?=
 =?us-ascii?Q?yCWqYhDO+8MVZymhKY3Wltm8wObXYABZaIQ2wxzU7NpqFiy293rkUPPyFWGp?=
 =?us-ascii?Q?hJ9iU/IAmJMkunE6LDtdPDnx7bdLGzkEsCEKRx1sZr1XPSPX4PFoVI9gimrl?=
 =?us-ascii?Q?EVZwNajDqKxTopCkKS17myjZ1t8LwamqRf2bJnUlXZcXQCE75Ij8NIKmMCRj?=
 =?us-ascii?Q?NNi8b7+YnakEnCBV2Lf11LCrE5FfR2qeX3cVcMtfLXhqYk7ZRXdetjfhIrxi?=
 =?us-ascii?Q?wJ67T0CV6unJlNwSpYTMe4ZdFzFQX+3PZcaHFjKeXhG4NWAmoHLd+n9vZeus?=
 =?us-ascii?Q?gnWoE04hIdF3z3BbC9QbsH5N422rTBYKcPgcyy0L8jExfO4LSXS5w4pXWdjr?=
 =?us-ascii?Q?O6z0JQvdosq4s80ETthmpvY/8JInLGM4fLZjOaTjfkuXfmtqmkh4IRRK2t+Y?=
 =?us-ascii?Q?VFiqET2g06PQo0XDRrA8WANRpNYa2cIAzHjYA2NHWN7CFKMTGjsnjb3rs98Z?=
 =?us-ascii?Q?Um6Ygx4ZkLswO4B+gIFPdoBas3JExiW4IwAlyUV+Tn53Br2SVNxzjKA4OWDm?=
 =?us-ascii?Q?cAMjGmA9ahSI8Ds564JhjdQMCJhCyoQYfevshMLVJQwA5quFqcJBRNWORsae?=
 =?us-ascii?Q?G5fCHGkE/hndIneuZ1qFFchKPvp87Ft+qNhsRPadnmpYMdbKJEJ++lBKf7fi?=
 =?us-ascii?Q?7d2agQ2M9bCVUEAnNEbteIzTrJc3c5YSszZTUBJXWbDjipjNWSOT5BoATJiI?=
 =?us-ascii?Q?DqFKA/HF2w1I3xUNYd/vzuUPfUd6t+7LmSV4fwXdFGZnjOUF5Ah7RUZZSiTz?=
 =?us-ascii?Q?tTRLBzDxj+AB6Ouucg82otfDyBd+gsu3I3vZV6f0A0vk3yoHXb0uEyzMsyVO?=
 =?us-ascii?Q?+8iluTKgf+FWgQXaDNYLoPibNH0z4iV4VGBvD/B+hR/SCbjolGaEsJWtkcRt?=
 =?us-ascii?Q?RRGThdjI4sg4OeX8Ky/8/qTQCgUFLrudtLl3U6u7aSF8p8mkgIpP8a+cVyl7?=
 =?us-ascii?Q?BHTxVwl5Vaz3CNnZhxzZsle/SqrbFHhq0wsoXpfrYCuhyJ7bFIAJ2MwrPqE5?=
 =?us-ascii?Q?qzbkHO2JQyZjIyuET79eaHwmkx2hTBZtofjmodqDC6MqFnyGZDNVyBwCRCyc?=
 =?us-ascii?Q?Jje8m9XSeQW4m7w7aXXQRFnbYyXl8Y0BRfOr7Sh6KYIk/QrX95BsVsLPp3Wb?=
 =?us-ascii?Q?ttJ0saqPZQ2wKwCNsGtYZBRLSCVPCLdPIEmBdK+3VBlHcAME7oAa+tZiCdQH?=
 =?us-ascii?Q?pOhTBW9lXDeH+nOPM6QYGPuH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8afecc6-dd9b-470e-2422-08d90e4d47a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 16:05:33.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xsuIVxNjE+atuaSiQeBCCLNGPIzvmGcc5DjK+5h8qsA3c37lolYFMMd2ZqyWyHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 01:20:22PM +1000, David Gibson wrote:
> > There is a certain appeal to having some
> > 'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of extra
> > information like windows that can be optionally called by the viommu
> > driver and it remains well defined and described.
> 
> Windows really aren't ppc specific.  They're absolutely there on x86
> and everything else as well - it's just that people are used to having
> a window at 0..<something largish> that you can often get away with
> treating it sloppily.

My point is this detailed control seems to go on to more than just
windows. As you say the vIOMMU is emulating specific HW that needs to
have kernel interfaces to match it exactly.

I'm remarking that trying to unify every HW IOMMU implementation that
ever has/will exist into a generic API complete enough to allow the
vIOMMU to be created is likely to result in an API too complicated to
understand..

Jason
