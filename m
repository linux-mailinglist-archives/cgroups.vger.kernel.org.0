Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A10347E75
	for <lists+cgroups@lfdr.de>; Wed, 24 Mar 2021 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhCXRDo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Mar 2021 13:03:44 -0400
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:46092
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236257AbhCXRDm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 24 Mar 2021 13:03:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2nTVZFzGpXDYpLVEq4bo9vjptZBad6SW3kBxFag8WiS2sT1cOnrWw9xEf6wtBzSGNJzC+ZQsC+QGboLhQbPVXWjlzk3eNqL7SZfCSEdE2v9izDQ6T/rUn2+HV5D7zl2q/VI+2QOeic9Trg7i+ykMQedBg43oDbriRinEqE8WP2PPp3tsp/iien9f1vtRSD8hQTo/3sS/lBoQNbNDFLS9D3i7U1OZZFgE1xRCCxxuvQuu0u0acFOwP3nRe/zajpApuTJmpy7wtN2ftyuGpk0+Yn0/Y8G9QiavdQzGX5xyAyp6QKD5oQLDtpzQcjLf2Lxo1iErulKbnz4wkHEu1K70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzr+K3BRDxSN1riRVVfJ2WL/Ho0CU52QiKj0ERMcv9w=;
 b=IcdlC0aeNmSwYczrTN9ocxYnVy6NQI85m63r0JOzpOoDb5TES9wDcyeO1TlDhQyamhhjSYp5k/i8Xb6xs330XeBQlw/wsGqXL/sONkLQ4j8o3Jp12TM2FBHhIeqUyD+tLYraRkmryh0o9HlzAym4QCmVnqI8t4bLnCEsb5tp131amv1L7XpE/thyCLEZxZuEzcvm84x1sSiAJu+59As+16Yt9c8XKoIYQhUTwZzMcNJ4F2MxhCSqGovQNWBub+keBVGhp4B7l0zRODBo31hAzXZQjRCV+Vtsj3n1zOk0xex1VmmpimITG5WZnV54Ts3Q0HNxGa/RxGOjScYN3Sb0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzr+K3BRDxSN1riRVVfJ2WL/Ho0CU52QiKj0ERMcv9w=;
 b=sDdOckxwkgSHEz6mRMpkT1XRJw4UZByb2yMGmmn4/mUdLEWzt6FfXd/XnRtMqUtkaTLKPdUxTlqu6yB2a/aYctAamkuBn6JUwz9E9YTzmKN2go+YJ/0aZ+qNjPn1rI79l+w3U4BMQlnyK4SmTj8991e0N/PdYMNS0eofgfhUlyGlqOc+2D6fvTZDl2rm2HhjPkLFrLteNnUAakll6PnhqQxKbVNViHJW8rybDLjmcFSSrcoSOt83o74J5iHWrYM2kwYprSKLW73S3bkkatns53VHK3X2JkoiYknLpFQ7oT0SNYkDCFq6XzfuFBge9O0FxhxN7TaZWHVMEf3xaHtT0g==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 17:03:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 17:03:41 +0000
Date:   Wed, 24 Mar 2021 14:03:38 -0300
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
Message-ID: <20210324170338.GM2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324100246.4e6b8aa1@jacob-builder>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 17:03:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP6uw-00257V-F6; Wed, 24 Mar 2021 14:03:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a4038da-8c20-459f-2356-08d8eee6c63e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB48108A1D7D7D240A0EFAB60BC2639@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIjY2HL58TrYFhGy6Gov0cEmLIuon7XC4/aa1+9tcMvuo55O4WoVU6Lwgil6enWrJDv2x+A8J5bClHp3eEBsPmlR+Q6BNBhb2jcVndKyG4uXOcAAH5JodXGPevKxz0BTXF+MXet07nxd6Ez70VUnw4roTJDE7VJh60jB0jcsVsQ2x6wPFYZuwW/gp6PQ9rrFRO34B/l7Bl+BAUbXzoG8mi036qI8Gc7+fIZR8ZwfTJsZoz+976U77GcK7ZOSXVXaqJOqYNTEvpkTcCt3hRBu40cih1xjy/+cLnOCXcSlg1r8NcsqjNc13+smVzplY7t/un7vNv2xX3K7WWyPaqLdrZRAGvKkWCilohN8z3ikHFduLvC0tN/XuzZ+ZXgGPHI0EOLfORq88X/RgZJWT/pIwOh0SQdpNH5Kpg09ezRBYJ3nPidMotD8tVIXUwyPxPO5EiwhqFOmr5uKtdBbYSGhfVrEayfV+Z1MOcpRG/uUTCHJbQxpIPdJIegEHTDS7KDPDGFocEDfMB9QkTlAQTL/JuHRHgCdU05iqJhoC0/C1IhNhprVBaO/7Z/aSlx6xZ99bOM2vkVF3Wm4PWa/WR8+ac6lDFVZxh69Z+OOMx30jGbYEf3ZCm+I3VuxLRSB5+QGan84eztV68YH+ylOwz0zXLWlL/Tc7DPDSz/05hVQAgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(4326008)(7416002)(5660300002)(6916009)(54906003)(8676002)(186003)(26005)(8936002)(2616005)(316002)(1076003)(9786002)(36756003)(66946007)(33656002)(2906002)(83380400001)(66476007)(66556008)(86362001)(9746002)(426003)(38100700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vAtRwbinABwNOKNJMZQOaqV/hbG4QbbZUU2Hu4k9B/fsnZViP8rTU5BewDdu?=
 =?us-ascii?Q?eKPZSvwQbPUs1qIBLcnp5ctjeW8ykaArS+LpOHmfNjeDKz+RHArse5tBtJAI?=
 =?us-ascii?Q?G9M2I3VnuHN6BjNU41kinl2FRjN+bp4sx5eAAcrLVKILEXwjTVySnXwC4lFM?=
 =?us-ascii?Q?d+rpeEi2CbVY7B1l5o15OCPlWjxJzcwBCnnLeJje3N+UYdqYPuKyTBMUixCA?=
 =?us-ascii?Q?o7I4rNykfmc4JQvgtWPMMdGzV/KXgoVIEFJzu7ml6PxJa/6P/mubM2xCFM+1?=
 =?us-ascii?Q?u9xlXjeYLJz2lMFrQv8PWCs9xf/sc4AYnOUSUNV8pCiAPFU19ufE1tn4tpND?=
 =?us-ascii?Q?oQ8et8ZUPNtvmO9kz+JF/w6c3mN4KQfbiHwbSR/fuO0PwJMcFpxXBthzs5W2?=
 =?us-ascii?Q?RQR3NoxzrJe4qVLgdM8WrzzGghxSJD9P6l1uDafJhrB/TID1KgCqgzm6bddk?=
 =?us-ascii?Q?b3vAiSqtTH2ZJJOp0AAMYot8544aM7o7maEh82MYTJTMAQk4b5oEOB2MZ72x?=
 =?us-ascii?Q?XCyBYJY8JFzUrCxZ5Cv7Gl3g5JZbPxyI6oMsx+L15x9Tbsh2GBZD8OkVodg4?=
 =?us-ascii?Q?emqUlb1/nuyI/smiSMaE8Tu4g3L13hKA7ue4CVgMvwSStHP2npZ+Hev6K4To?=
 =?us-ascii?Q?25JVz69wLR/z1w2gucV0O3zZHppjZp9xlekGQerWzRf5sfJ2FcRh7jxufzy2?=
 =?us-ascii?Q?i0PL6PnuHCB5RlAu8C8L9ZeF0yV5G7ulW+wRoKF7JCLRtyqfOEPLMDjsUF0n?=
 =?us-ascii?Q?3OQcTzly2e/tWzZ/pBqS/NoNPmosXov6FRMDJ1lrzkOWtAQlq09mabCraknD?=
 =?us-ascii?Q?l6DXWcf99DzTft6FHXjfkiuf1c5d4cNdwYOGkFYy8LNBfnosJJf3TfaO7D2Z?=
 =?us-ascii?Q?VB2Sab0OuoA5n5kxBhunH6PubkXrvxF1IRigZI8AYJpiEmCA7PaGUgI/9CzP?=
 =?us-ascii?Q?p9fv1UCxr2jUurDTv59t5LfsjuiyuwscmcFW1xnL0JzJB5B1ASBBma8HrJb5?=
 =?us-ascii?Q?WzOb4yiTA6eXjlmBjn7gXdPRZngzRGkC1wTCma211XWE1jmAeU/HokNBcHJo?=
 =?us-ascii?Q?dBi7V69rKzDBjXszcG+b46XFKXjJbg2tg8/0SjLDfBEUn1SZtY/p4nWu7t4f?=
 =?us-ascii?Q?8K7x5K6ak8A2dy6M73cuSNxLxQmyNuNhQ7azRBSgY7lco2TjvwLzCAdTDyS5?=
 =?us-ascii?Q?j3CoQQ/KBoNf4gZQ4c9Zi40I6syDZ2Zc/S5EKRAxEbmBaHxT2gBf4saQbNyg?=
 =?us-ascii?Q?vESEJNJv266CIwQPNt6JBREniYWsRzvAFPaCBRKBmIH9nZEWQNcLGiACLFVd?=
 =?us-ascii?Q?FS4nwMMm43HnH+W5mLunIY4s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4038da-8c20-459f-2356-08d8eee6c63e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 17:03:41.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7P3+7kjQ79bxO/F3WqJA3zWpNtU31C0pyC0hMBMbK9qkGZCqGe8P+7cFVtzxbX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:
> > Also wondering about device driver allocating auxiliary domains for their
> > private use, to do iommu_map/unmap on private PASIDs (a clean replacement
> > to super SVA, for example). Would that go through the same path as
> > /dev/ioasid and use the cgroup of current task?
>
> For the in-kernel private use, I don't think we should restrict based on
> cgroup, since there is no affinity to user processes. I also think the
> PASID allocation should just use kernel API instead of /dev/ioasid. Why
> would user space need to know the actual PASID # for device private domains?
> Maybe I missed your idea?

There is not much in the kernel that isn't triggered by a process, I
would be careful about the idea that there is a class of users that
can consume a cgroup controlled resource without being inside the
cgroup.

We've got into trouble before overlooking this and with something
greenfield like PASID it would be best built in to the API to prevent
a mistake. eg accepting a cgroup or process input to the allocator.

Jason
