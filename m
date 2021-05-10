Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76983379AE0
	for <lists+cgroups@lfdr.de>; Tue, 11 May 2021 01:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhEJXqK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 19:46:10 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:61236
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229925AbhEJXqJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 May 2021 19:46:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fChj2XsbUI5A53OiEq0v1UCsCOCICwB5OUpQvJhrz09zABzCnI0/0AcUfAQTJ2ZCJPzxk/n5cQSppVS0XoAfFDoEb7vxCg+Lpjwlnp0AbKrOPsYcCEIHse+UWN2yzN+bIWUd8YlAb7w9Bj9cV0M1uWoRGPSv+TH3o4CfSMIToGqs2O1Ilgjk9nq9y7l6NnsojSVPmtLQAsqYU6m85W4n7Rn7fQ20M4+gRQok/rTuc+EyqGbPzWoXx1hc/TyH0B0vARmX2sXBhc+RXHXqTFX+knlUpuk6kubaBpb70RJ8DSz0cPCvzLELK1o2jUZ1xchrx2dDdeluTOjy/5Rbv2rH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7YvY3ghFZVy/MxSq55DpMslbyjZ5dtdU4r62kwxoiA=;
 b=DiksCGr+vh+f8hJg8SdxNvN2Mt2Uu+WT0JdGV4o3gNMvRcPw+v+eH64RwEcx8Jd5WTlkWgcS+uQZQRs6MvdVqHp1a2ZFEIPCsYgdM//6LStWQeE4hGTn5iJOb2pUnrb8DObUn9th2tIMTFRtlQU5VzlYp3qtqkbme5fZ5nHK3ZgatdWGK31DEgF9SGaD6oy3YMyDUMmgGVU9o0ygMIDP0h1Sx6EqnDja7ev08XwzeKDm1cAuClvGu8j76K1A62x/UIhoxYXlK+Ig5ORPH1iWPiCgrRLY9lqPLUvz3527w9AzBwBaa1ewQkpT17dXX6GS7po7peD36B+BFumoLbL/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7YvY3ghFZVy/MxSq55DpMslbyjZ5dtdU4r62kwxoiA=;
 b=Yq7gr1UXvocILLOd/cAZX/SeIuPRzT2nlY8iA2gHlK+T+O8REUIqM67sUydNMVMQ1W2hCWb6JmMxghjM0z54FI4m7H1TN+MmpPrZuvc91T3D7OUUM/YSBkQK3Y3wc0NYxo371BOxHUkl1GX4ETN277n93RAqLwYT8EPrjuu4MdizO7soom8G1mFQbnWh7tHbmCMR6ekWFwFKOS+Rtgsi49w+nbw8SjtLnbrFzd4uil/1SJn8Ccig0q76mz9Fdqk8oi2s+WZg1RqRmFMUIBZAAt/J3diEuPzIQ0enSyKYgVSDuwjQLLg5zOgSPRN28KS+C8q54Zc2sR06Dc5XL5kWYg==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 23:45:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 23:45:01 +0000
Date:   Mon, 10 May 2021 20:45:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210510234500.GI1002214@nvidia.com>
References: <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <20210510152502.GA90095@otc-nc-03>
 <20210510153111.GB1002214@nvidia.com>
 <20210510162212.GB90095@otc-nc-03>
 <20210510163956.GD1002214@nvidia.com>
 <20210510152854.793ee594@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510152854.793ee594@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:160::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:160::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Mon, 10 May 2021 23:45:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgFa8-004ynM-DO; Mon, 10 May 2021 20:45:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447649ce-59bf-4c95-5af4-08d9140da0e5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2810B2115250C3B78CBC0E6AC2549@DM6PR12MB2810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iEiZ520upX09gKKQjoChrV3BJ0BV0SaVBKVXQzB4BSHTf/W4jOg1Kk+O9OMMzP1gvYkM7NaTFfADZNE6zIGQNlVbm3newncEQItNmTdQstATKavVGI5iaDuXrR7eG1Y4cxd1LEv+KNI8btagNyrzqL1gECfnev4IVT6kaSae/K/hpNXs5I61gFxjJX7cBsO0s+DnuIV2B3FXzcufDQLeTBX4HcBrJpPa6/s5gZWrr7xg/8T9Ys0I2yjJ7uXAbNtslwTSSUMWstzWo8E669yeQa+CFqIP3gIpCKyiJFdFHD0stZPNcNhaWf26DJ/BHtnUXx4gWEPnlqeUBsxZooKZQ+cTGPhKGDgKtCE6/8PqDdjDmANR+9lXQaBvy0nCfCUJeAcYoyW/fvFvt3T0byaB09azj5Rc3BQT18YprgvajouzKZTjwghfj1+YEm2mN/chGHJdfsmWB0uw2RAsl4m94Y/C217k2dEUE3+PgOXhySO56WlZyjs5w9MqTdWBIb8Bos6OHQzIbtwsga4YSC7lnm230cIhZoP1JeTSaBJH+kLEz47g+uM+7BkVeZwkUzve+7LSKoFFE1v9yV1PUosXXkPsE4iwxQHBmBOyUjRMWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(426003)(9746002)(9786002)(26005)(66556008)(186003)(2906002)(7416002)(66476007)(8936002)(38100700002)(66946007)(6916009)(5660300002)(1076003)(478600001)(33656002)(4326008)(54906003)(36756003)(86362001)(8676002)(4744005)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BUp0s5BeV2Fu7aan6cme8pJEjLjmizN1izrXIo0wVMfIZNaAh6CIxsStMMhF?=
 =?us-ascii?Q?OwKSZz4yMD5VkbrIdogs9sq07BYP70zCsACd3eDWF0n1u9Puzrh8MsbGXoVQ?=
 =?us-ascii?Q?hUYhHwkYRrVwBE88kxwbechK6OqhwJiLQSbbpSyHv3gliLG4wxtDx8QpOaE1?=
 =?us-ascii?Q?xC9MY2L2oNTmOyVIKyZyl+vys29cPGM/2fWdNuoAt8bRe2oaeOLV8esH/1Xm?=
 =?us-ascii?Q?4Z2A0rUmjYVm8UQU6M14qL1xR6JEbl6+pK17gDP1+ASebzGvXqyGTlV7oZ10?=
 =?us-ascii?Q?1FxwqYb9qqbYBb8yUShrNoDRPI+UfIs6n+CP+gpXW140EbGfDYMX5H/Sfkzy?=
 =?us-ascii?Q?N8jBCLUn/Ckw9SZ+jq5LDSQBU+nxnmmYZVnWcV4wTv0QZMSU0l8kZz2TJQSz?=
 =?us-ascii?Q?NlGsRX9RIEYRVtTsdyFKq7EqLkYBYKGV6BPf88hcJwCNpALd8OPUObxzRzQ2?=
 =?us-ascii?Q?2iqNrgJnjo0HVLFjeV2alAHrAAA4qapfnLDfHg0wxdhlGWMsYh0mR46Dgfko?=
 =?us-ascii?Q?WIqTEeLKwEb/6Ot62yGw4PJ0jVCO5EpALz/IDTT9uX/O05v9sWfQO3JNnEW7?=
 =?us-ascii?Q?PjsuKvIAJpVX/raU8C31WSCmUkeP6tEP0E15XbRH6YLRJxVYL4qCm5VA1Z8S?=
 =?us-ascii?Q?e74x4tfMo3yBQ9isVplszufYeewnpwsKsdtTNuy2syuoeoraDiWS1+cNywEU?=
 =?us-ascii?Q?zAuvaIprnDke74EZdhyf0mlPJibMBGugysf5HJ96Ij5Dw243i6Il7FXfJMzV?=
 =?us-ascii?Q?1g4U09U2qV6FDBxSiHZd8rkzrwVvTaS6uWha1QqUn53UPbMoGMuWyHlKKQ35?=
 =?us-ascii?Q?9nSbtEx5vMrU5EtsufkXGg1jNx6n4xqDWGvp1TtHcAbuoXAYoXIHiDbNZhut?=
 =?us-ascii?Q?9nNj3+FK4DVkVk8bKXbDKgyJ+/CC6jjqGatHKPMqCgsOKnuWfKfR9BO2gA7h?=
 =?us-ascii?Q?6cmIDfkgtnyLO8+ayO6JUu+FvNVmkNHjk3UAWyrRuqgFSLtqByKFNIEU+gRw?=
 =?us-ascii?Q?EdMoYG/JLmRWxuA+LEZBMfltTEPB0jQEzh2psPDJWSLV8FJ9LYBkmZuunbDn?=
 =?us-ascii?Q?SH1jrS1POGSOklUtq/cJiy6KP62pJXkaSYkjqq5pI1Vp3//iZBCJiIOkZJRg?=
 =?us-ascii?Q?OryD0Gbe2DTIR6SqDxi5BqAH6wM6yItOR/Cdj5MBhHAkn3zCDAPw1o4PGTik?=
 =?us-ascii?Q?mtUg71gCLltiXWtWYEMXAfHNeF16WiBk9WPV/XfaI9euOIdjljGT8Ib9sVkX?=
 =?us-ascii?Q?TZ9SHcBPesUJV2Fptxl1DudkeR1FzuDHOM5bvmpkjO9o3za0kGJVmVO2ZyXr?=
 =?us-ascii?Q?7egJhqdz70+joWcrFrvhBy2x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447649ce-59bf-4c95-5af4-08d9140da0e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 23:45:01.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XhNRUt8mzrbVQl0PbldETwrxrvBuAkqSYmK5e2keHnU+/EHyXuCVzu3MbABNGhO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 10, 2021 at 03:28:54PM -0700, Jacob Pan wrote:

> To satisfy your "give me a PASID for this RID" proposal, can we just use
> the RID's struct device as the token? Also add a type field to explicitly
> indicate global vs per-set(per-RID). i.e.

You've got it backwards, the main behavior should be to allocate PASID
per RID.

The special behavior is to bundle a bunch of PASIDs into a grouping
and then say the PASID number space is shared between all the group
members. 

/dev/ioasid should create and own this grouping either implicitly or
explicitly. Jumping ahead to in-kernel APIs has missed the critical
step of defining the uAPI and all the behaviors together in a
completed RFC proposal.

Jason
