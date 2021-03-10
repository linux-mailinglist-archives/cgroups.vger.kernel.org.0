Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F2A3347D6
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 20:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhCJTXh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Mar 2021 14:23:37 -0500
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:9056
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231126AbhCJTXF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Mar 2021 14:23:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMOeLHvM36ebBS28N+2KqCfIkzfnNYbzHFtm8GIO0TTtr/h11S5fg52gosDyjmCUrQQhhB/DSZNdGerQoWdCriv460FQOqHbjCuPyaV1x6Z4CqMfXTijncn635B9tIG4GuoSwYQg+UDm44IBTFF8bbV/DJ5n47IBeqVUuQyIYCZiA8if3BlHr4/jPHkfnfUqts++Spi1Rs5054nj3c5BPHD2gateWaKBlY1NLreQKALImHeqnYba6xqcliaCphSGG/b8ZyM0nOfHmnvzG6Gl6PR82zAGL5a1PbhO22CillaZNO1VmaPar0aCpDy9pvx3gQ4XqDV27FBy4kEjQWksYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9vW5Tkli/mGOXhgNDkiWxksYvTGh56Erxhualjjxwc=;
 b=ibh3lrb4evhJWlId9mZ0fISjGGEJ3ktAvvy9HRNcXZAlqRIdQ4NA9gmb1OYzwlICPu54bX6qyCdX2QIx4jIftw+SUnCAi1Eh1UNp4XvWoMJnYSolCqIgx8oIyl+O7pYXXDXvTnl6BUTchaAYTYyfGYYFFGmDrr9Pu0GKYKVgABfU6mfAP2sq2MzY2eZFmjvj00GIW6AVzy+BCdR/RZpfxV1CPMzc9in+p6bQ8Pu6+SJQwIlhyOR+nwYaTIcy+dcHkVD/2kjUWdi6UHyKP8sZtfqLqJkxdRl965rEcCmpCdV9piJESJNzqVOyHyShe9Kwfz3B5zX7a68GC1JXpnjGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9vW5Tkli/mGOXhgNDkiWxksYvTGh56Erxhualjjxwc=;
 b=LaXeEE8/z8xKwzOnzuOHFOraxwyZ4k4XccBmPjvoy2x9oSfZ1vT0VnPlV1BL+9aH+F3tqxaytcPbjqKMqIg79Xdo12+0pV4y/l8pIYcV51XnWlw8a8pqMqNkcY/yFNu3Zb3Hev6uZx5yq+HV1BjFVkmNoou1bsK8LRXAHd3fqQTswur7Q7VHNaC/mW1lq52x5pPCKN3t1Q7/Do+PfLRix9V6deI9tZTgmjcgYnxo08TRqhz4aaUJJFhSzEXwb/BjJA933SVHpS7inLZo1JnIsUELtMyUvSqQ8z6hSpNYXnF7xhmXe6snJxJ43jz0qLKpeIE1/Oned/IRWVvZdeR2ng==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 19:23:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 19:23:03 +0000
Date:   Wed, 10 Mar 2021 15:23:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [RFC PATCH 18/18] ioasid: Add /dev/ioasid for userspace
Message-ID: <20210310192301.GC2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-19-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614463286-97618-19-git-send-email-jacob.jun.pan@linux.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:208:23b::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 19:23:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lK4Q9-00AtRk-OB; Wed, 10 Mar 2021 15:23:01 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac3cf66f-1eab-49c7-adac-08d8e3f9ec91
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2938BCD41EF4666DD4C76C18C2919@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8wNKAJIGz+io6EWMz+4g3t/7xCEEGRPKAtFO2AYBL+t5ZsiMnuL8O2ZEvuKmdHwpKdlSmBDY1H2LdTLF69tMI2gju3RZ1FMjL8WJ+MFA17TwakaoiuX8slesYbC7TC6UmS4U15hXRp9ec6e4exWn2n/QrKUzwOzAVNfr8QpSqtCjl7u/oy82WJfS6LAX5qaldcNSZQvGryKNnD2PX/hqM+qU5E1qfKC+i4woIRQF9CqFkefCaDo19obpVQCRkKKuQjCkKxtMok64aZSJY8QrxBDYHcroExB7vTX8+FlAlvglkqPLMEBs18tynbOHyEroyPzXXVw77JZ7jsTGC9bevWzh+rvh/E6gO8Q/WgYMTrEQus2lvKaRFTZZCeugvYzdNvHnfhtf/8ZuuUsozYKnBBIldZMSj9dp0SiA3lF35uu2kmDUhNP/bMRNPw+3wCGJWw3ehRZ6HjCiIwHYMmbm3p28ApfKDQpdjvDwTUD62nn3kWQ8mOm7OPSRfvzC4iyELocJFH9HCr7jEcvkZht2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(316002)(426003)(86362001)(9746002)(26005)(478600001)(7416002)(4744005)(54906003)(1076003)(8676002)(33656002)(8936002)(2906002)(4326008)(5660300002)(66946007)(66476007)(66556008)(9786002)(186003)(36756003)(6916009)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oDtHu1GZ3iYtTwMddLawo+MRw1h5A1kqSYRmosLGp8q7OwzRB4RucnAphwOF?=
 =?us-ascii?Q?+1B5jImQAStBljSLU6TpwK/YTPADireCh1TWsAHLPg0k4D7t2YcsTuT1lIXG?=
 =?us-ascii?Q?r8FR3NvqBBIX69UdGuecG9vD7d6l15ttIH6pDSyeoZOXWgAJXBS6sPIBf30j?=
 =?us-ascii?Q?rqpz3A1FD4d5hU8dBzOoEJ33IaV/hwJVUveq/+95GH0TiYLE9TkWh5ci9ILB?=
 =?us-ascii?Q?GAfoFNWMFaXQzx9lTfg58Ju3btQYmdjBgzT6ZhovVZ0NEd7syO119ey2bPf/?=
 =?us-ascii?Q?9GLeuaURKGZXVJtTz0zdLU9CPK6bT8gkp6WQQXDlwAYpO6KE506Mu0D1XPoP?=
 =?us-ascii?Q?P6aDpDNKCwe185DdnTTokJa1FbqxaVJ1rPK80uKJ8kmwWuVREZTHCGeEaRCJ?=
 =?us-ascii?Q?JEqFyEjfRj/kigXf/81qAg7Yzb2OtYjDLUMpCO4VrD3dHKWBhl5UfOsn1R2a?=
 =?us-ascii?Q?orIjFVwn6mEEkuOe7uP3NGq+ntchhkrwuVZWRyZ3vhUL/y/XTUNLvvzKbD4C?=
 =?us-ascii?Q?NehZZ+94EG5HcgFNxnPY6VZZDqrqKOsi5zUjQ9HsIJcaBlH02xSrfJOV+LXa?=
 =?us-ascii?Q?if4VJy49zC8zQixYJaxF1Nt8FWBqnVRO6BExFu04O+OvoK02qvHl3EIQ3wWI?=
 =?us-ascii?Q?pFYXqrEg4lLtmeGPactT5e6+idR1e/bhPLHVCO5ET2LlsFnngjuPPxOMPIPY?=
 =?us-ascii?Q?ydCsXbHItnd309Vo11fSwWktCBF+NHJIlPluwTFu7srSeW5dP3vtU43SQjtc?=
 =?us-ascii?Q?OZ5irWotDARL3M4smHOqa9H7CwTj/YeLU2FWNjHiLMQxpABEbbnwBC8KJIcL?=
 =?us-ascii?Q?bHpWSSZxvTSrwAEr5OuMV7ZDIDcLB8Bk5Lbq/LihQ6haPsgsDZ2bWewKhlmg?=
 =?us-ascii?Q?3//+UgmW4D8jKX9bkFW6uXAlkby6Vu4M2+v99Q4Xy0eQfv7C9dxUEKir4gLa?=
 =?us-ascii?Q?IoJEjAfz2BxEAoUQvvQTTInWkxIOJ3mQGsxXtC84jsBAsg2HrQBafdS3Lvy9?=
 =?us-ascii?Q?oKtFIKAMchyuyGEaOb0R/iqkedIhhC3P/bAErpuvmTIA3tS9XEbrAP7FNcgw?=
 =?us-ascii?Q?aEQDBQybR276ErvCkVwcJs07pke9ZCSRZbd5I6KGH5FDy7lbESvZNTwItcbC?=
 =?us-ascii?Q?g8oSu1EtX9wUQkI06reFrM95W0WqGFK4ppXz+gJDZ6DyNwsCo5SjNE17zVAU?=
 =?us-ascii?Q?Up2Bai+uO6SAeQfX6AG6WfiwTnslULAiWO8X0hpjxE2mNOXXi+Kc4x9//NXD?=
 =?us-ascii?Q?ksoFabLYNeEnqltTYiQOWzp0p4ePmUbp86EX09J1EaYwLTu8S/GywgwyB1LA?=
 =?us-ascii?Q?evcYri2jKJFLndfBs23IVkIrsnBbC98ljp50v+wxiL/zvw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3cf66f-1eab-49c7-adac-08d8e3f9ec91
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:23:03.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYcNppCp5zwkCAmmq9nzz7BXOA/YU70Ml8kcQG37Pr2sSBnLO/esv8oRQhlbnfcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Feb 27, 2021 at 02:01:26PM -0800, Jacob Pan wrote:

> +/* -------- IOCTLs for IOASID file descriptor (/dev/ioasid) -------- */
> +
> +/**
> + * IOASID_GET_API_VERSION - _IO(IOASID_TYPE, IOASID_BASE + 0)
> + *
> + * Report the version of the IOASID API.  This allows us to bump the entire
> + * API version should we later need to add or change features in incompatible
> + * ways.
> + * Return: IOASID_API_VERSION
> + * Availability: Always
> + */
> +#define IOASID_GET_API_VERSION		_IO(IOASID_TYPE, IOASID_BASE + 0)

I think this is generally a bad idea, if you change the API later then
also change the ioctl numbers and everything should work out

eg use the 4th argument to IOC to specify something about the ABI

Jason
