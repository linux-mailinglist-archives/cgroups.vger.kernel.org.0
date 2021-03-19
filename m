Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E33341EDD
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCSNy4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 09:54:56 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:11777
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229784AbhCSNyf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 19 Mar 2021 09:54:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZGdK24KWCyKZxeRKCLu5QxZ6mSz3XNUes/v2Bgq3CPPBEHQ4z52UILFzlQouxug6gP20kHy6RdkSpuHcALUdlBXR2halPFUk/FwNn8ODa5FSlzQp57HjZY6WhNLqe1Rx4PzlIv6/CjUh8ak9XGS3Buzo6YswMIGizKvVJ0R0M8u1WrXZPN2/yW9TuHY8ONFDmyJGb8TzyoUY8JEj8NLFjLKWs3kH7qeYbyGfVNzERTh4ErR/DdLSfk22mBmQnNaswOiwdYSddIOEZ1EV9XFp99756CZAHEaSqAs8Mja87AmGTcqlW8QQqz6G3t2HdJdinyFZfKWiAQfnJ30MzBmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7ic/wgCgBjj+2SlGjLvj6N7uWWIpxlyndm1A+f5tMY=;
 b=dMBj1oWUbN9OAqchecSBUsbHBd3hQXP9XLja4lEx+mvRQ8x7z37COH3ZHUtTZdE13bPfuaHKa/DaL7d110cSQsMFAvXwWxfto8e8Mp4P+iHzeEVz4bpnvqywRPf2jFu8Nbjb1BB/7gCj4iKhf0DU58U0M310S3EB5kOEsT+3YII1YmJ4eWUqeSMxCER83vwjiJmsLL+B7ae534I/w1X20MPIgltVDBcBK6E4gl+9YWFPS7YvWYOPxXt0Tw9WPULhglS0cFeygLPa0tc8IUU8gnIS6kYx7zfdOifgpBMCNCCkTw2iW218lrosz6hb93J9RowWIVUCuvuCbfvJTjAbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7ic/wgCgBjj+2SlGjLvj6N7uWWIpxlyndm1A+f5tMY=;
 b=emfT0d1/R6izUpprunoWVFojbrjhKKwsFt3ynJeD5bxS7DWtdpWxlSRFcT4CXW7uDBxtdGCPg3MTz0ZRhhzx2kBPbaM+otRcX0wi2t4L9UcMj+jzIabTlUmmfOlRCz+Aw+ZbChZl7dZ5goGoUULJaVDtvZywMnC9TwoVSB6aGxh8ueBdpBw64a3za0K/8+QrXTacEXfRhpl06+6hT+NBhnfCdUXSCecQkqDV6qQ/45hJ/9P+CbovepwE80+eXbvrBn48NIAOBAPd+ex1cCl3qAKAntOxJxfejxm7zWUPRqQhYTKek20Qt0PsWnx7+iXYpEyOxOV2aa7QOtrQPFAHFw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 13:54:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 13:54:34 +0000
Date:   Fri, 19 Mar 2021 10:54:32 -0300
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
Message-ID: <20210319135432.GT2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFSqDNJ5yagk4eO+@myrica>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0040.namprd15.prod.outlook.com
 (2603:10b6:208:237::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0040.namprd15.prod.outlook.com (2603:10b6:208:237::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 13:54:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNFaC-00HCu0-Fb; Fri, 19 Mar 2021 10:54:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d85b05-bc74-4551-2a2c-08d8eade8688
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3307A303D3E63BC437AE0EDBC2689@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERVuvJWcTadqrl9PXXfLq1A3XzGsFJqiZc7r5KYKUtVTTEPQy2/PAEHjW7Nq+IBwnISNAGCNu+SQQ4G+f9outt1vYDoXnZ7Rjslt8TUnxldguqUAlQoxlh6S+bQ6Z9ulkFQ0xIHz2WQeQkmC319MqOdzZ7UoR+xGKsEQ2EzlS8853J1nmc8swIgL+SBbUneWOJLj6ZyQIAssINRrBRueLJKbwUPPzY/LDpCjbL2g4iFXlClfOwnJAf11u4dL9y9LfZlEl0NohK1ZAMbLHpE+2BXNAq8y1ccsT7HxCTedy6J2o80YXPMAjbKRH3jGqflzkPIWncGsI1LK28G7MS+H8ZxqtYC1/sy97ozNjlaqeyxLr0F88WjGkWmLtPis+V+uaM3W7JMKMRX6Nx+JsHFOIeervhSyj/kDIx55icUMW96R/b2SlbxusIRXmwhknZBTdYT/dTqdT3LaFn1ECG7yt23DOxL71KvANT0JJ0o3gqsVxeVkkTQDI1uV+7/qkw9q2/Ox4FzROyhNFq0UjbgyXkExQw3WV5l5CkYi1ipIbWzP3PlThDQA8r1zihR4RxzDncFFySqdrShuMU2uLehw2/LZOcD+w0vVsfV2DVQQ6CLltb/Fuzblihy4EuVsan36BmLgemBOCGWAd5Jv8MB6a1+7HBrmu1gTvGBp85b4We4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(1076003)(426003)(2906002)(83380400001)(33656002)(478600001)(6916009)(9786002)(38100700001)(7416002)(4744005)(86362001)(2616005)(9746002)(54906003)(66556008)(66476007)(5660300002)(66946007)(36756003)(8936002)(316002)(8676002)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?p6jP2lEkQEWwkME4LRq8pLHQWJaOleeBpgWCNCPUwZ5aXx0OuV8s3sdZeB5W?=
 =?us-ascii?Q?uvKec9rJqtiBZWcmjQ79kJXp+uEbIx2mPBsAxpwfZ5nD1S6sP2xljzxl/1J9?=
 =?us-ascii?Q?kJeK8qCmMSUhz2cMGfY9UdbhCOe/fCxLURk06IV1tio1QZO/VjEuDhbTksQy?=
 =?us-ascii?Q?zFD3GXvQfqmyT9oGhH8yciEGpoiEygCPNocDRqduS6S3Jfv2igwHlDCFSmAD?=
 =?us-ascii?Q?56HsCyxIvlcpYrk3DWzfixLVFKK7dfRJnA6caekhTtgNV9mxulaO4efsQNn5?=
 =?us-ascii?Q?td1J4sJhRw0A9NxrsrGg7ypTMKPLv6Fqu0WTTDrPQtD+Ln7yF7VZmoOfXORX?=
 =?us-ascii?Q?fpLitdN8zO6PFdx9kAkZWid6MqJjWsYFolo5qSJsk1MImVCJ2EG/gg8k+C3u?=
 =?us-ascii?Q?4/H+MlTC4vD/NWJ8BMNukYa+L0aNWBR447V6mRXdKg0KI4JGZyVmslWxEVw6?=
 =?us-ascii?Q?bskB+SBuKeb4tM3uZkRz7U1beu1oC9TB+0lKQK9OVcQMadLliNPRtkS9t0MV?=
 =?us-ascii?Q?TgVYgFAzJ6cJ1VIg2judlm/YtGIqsVrIRJfoFyib59SFGs7Yfie37+BfQTDj?=
 =?us-ascii?Q?ZFzmq14gjyZKS6UEZZ5sNJAZCoATLyOe+vfu1wloMeJZona7n3Fe5apHkb4E?=
 =?us-ascii?Q?STpZcqHmmR68yTw5+X1dMGkoddCYuGO/7keQWGxsIwNak3EUpWep7Nzn3FI4?=
 =?us-ascii?Q?605uAGfJovfaNumyQ/N1+IiHpElVAhVJJXi3ioi/56AVU/dcPLvaF7uAtW/5?=
 =?us-ascii?Q?poXfgb8zq8p4MEqXCNKLnaKScQ0G6SHGcxj2Q5KUF3629hSUn3xJHMAI6C6Y?=
 =?us-ascii?Q?uworzdurNd//jUI/LEAJ1NMfhhYNi7X/qdrP1YLgZul6vYTaRVlGh6TrRmpR?=
 =?us-ascii?Q?cd8wvwStCX/+FkBfVxws8rU36dGxnElkjIGdEnf7CTW30NUHo81qWazYqsKv?=
 =?us-ascii?Q?DfIAUDn4aENXe4XlNZ5x+RSMVTC9maQc8VL0VqVGcaqcP/4lGUK34MrqBsNG?=
 =?us-ascii?Q?3D3ch7b0lNerP1AfZFpdXv3B6vbSiUymSZqS3s9eUvc1M7tGySuSgof/ogWP?=
 =?us-ascii?Q?8hlpaE28oZSC5IseDWPR/xW6K/XAIViSbnYvPMKKRDyK9h9cmWC6mRPopzzA?=
 =?us-ascii?Q?wyH9Lu+Q/zuaXM7v+Lwdtz8GJIbdFaMgveq/MWuvXNFVgJGE9laT5YW1BXup?=
 =?us-ascii?Q?vFyoUzkEgG9gmOibTyluzcANJVFCZbjxVxJEc2RR8jZ8tYdbdSKiueHGsJdY?=
 =?us-ascii?Q?OTqxQKayj0fxuS71B1SQVxjBECIQ/m0T+apYDNRIzLcKQJdyW38yp+cjjb7j?=
 =?us-ascii?Q?TYnkdoQ2K0nQtP8k2EUIad9Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d85b05-bc74-4551-2a2c-08d8eade8688
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 13:54:33.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+BW4XStl2evvwx5hgXmJullMdi2MMov1i/V+AABAsMoCNGsjgC2eCDsGe7ir/pb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 02:41:32PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Mar 19, 2021 at 09:46:45AM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 19, 2021 at 10:58:41AM +0100, Jean-Philippe Brucker wrote:
> > 
> > > Although there is no use for it at the moment (only two upstream users and
> > > it looks like amdkfd always uses current too), I quite like the
> > > client-server model where the privileged process does bind() and programs
> > > the hardware queue on behalf of the client process.
> > 
> > This creates a lot complexity, how do does process A get a secure
> > reference to B? How does it access the memory in B to setup the HW?
> 
> mm_access() for example, and passing addresses via IPC

I'd rather the source process establish its own PASID and then pass
the rights to use it to some other process via FD passing than try to
go the other way. There are lots of security questions with something
like mm_access.

Jason
