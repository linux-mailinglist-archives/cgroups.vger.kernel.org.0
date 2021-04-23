Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A565369C90
	for <lists+cgroups@lfdr.de>; Sat, 24 Apr 2021 00:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhDWW2p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 18:28:45 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:10720
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231218AbhDWW2o (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 18:28:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrLXDMzgZrgIZH+fdGR87AX10IAJECqdnVPIKTwzDg2L+VXZs28zRX4rMor1aocYbTg9noVvRLYowcMyuXAmhSQ7OssJ0vXU0YNRcaEuHYvf/w53Ae7fKvM04cfxltCuyWAFjv7LBNGgniumE/pP0YfaW/kFoth0FDs7+MZePCs7edwDbvOO3Q5c5pAuqd5NuY0P2JHaz4yqLO8YRrqv/bCrYUoGBZVi1w7qr2VZskKkSo/ptDqfWuVxjtjW93KK5/0qn2JWQlH9znWBjc8p/oT5DqRzEdcuV6ieqP5oQvSmnT34eEI4YmrlMUxp3pRH/5PXS3ECYe6ROSyHGRciNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbXGDqFwkQOJaUjES4Zo6AxYK7W93MS9wh4R5dAJACU=;
 b=fGU/mAR9F8r4KOX2jjlaJrx+RMC6iYS4RfJaDNcdD5LInThsdTGvHzTioSoxQiZ9hPx5En28b6ecciz8zUkjgNwq3kEBRa+KOO9RKH0mb+RhQHeVOivpsaJ7D/rrYFW4Sppiwd7KK+Tg9mNrsvOfOVS2s32uy8Rwvd7j89fupcfZHknDIXYTsQFqxRQcV3q9WN2foGJIVPHge5pIaTVW+XduRRBBqtIULcAiAsp+ENiwbXRMpmw+bW1nRVx3ncUVXIyZb1A6Opo71YnOVe7h+7wZeTNbWly/FDyuxT+P0qFnUfPpwjKDTeZZlkmkVDWwoJLb378RiMT36k2f3vKSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbXGDqFwkQOJaUjES4Zo6AxYK7W93MS9wh4R5dAJACU=;
 b=Qil48oWo2JuziDVtV5Xfsy5m/xmSJnuoUiUDMJ7VUXfvRPSgVVEaKNCGhbepcvoNsPg0m04YbgBInXvL/+j44xbjAR5KENIEqUkEroedCq0aFIz/LGkimqZ8g8rietsH2kkUon7ppKs2KrkPsRh9U4pJx+BZA4n73i6KY7ollvWVGZQPaHzAYS6Oz+nbwVhSUM3Cjs6Wn4zHO8z6n/MdNpCliX5V0+/VdLk5W5iWiN2hDoh6eKBFnNp6gmm9443TUclVDYq1cjdcguhI1GLgGNsMk7/Amul0vXGNGEX6ZMA98ezPFFInsVQ/RnN5ftRgjMX6jXWg//xydhVpNYR4mA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 23 Apr
 2021 22:28:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 22:28:05 +0000
Date:   Fri, 23 Apr 2021 19:28:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210423222803.GK1370958@nvidia.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <20210423103851.41138791@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423103851.41138791@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:208:329::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0088.namprd03.prod.outlook.com (2603:10b6:208:329::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 22:28:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1la4HL-00CGFC-3O; Fri, 23 Apr 2021 19:28:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97fd8332-8a4f-4ec9-65ab-08d906a70ff3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37375567E42E905D06807C31C2459@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEpTLs14ncgJbc50lS45xmplWT/VItG3x8oa2QxiBeTLnggNUG4BxJi6x+bv/53mQnJH/nt0+7FpR6BNHEBh51f5btplnPu3lnP37I8iOpK4AEjXLri+53iR3n+22lHM9+DJuGfxbm0Cu/JuCLxjKdg28S3ivS6pImmPj93F6vJG6hNwSABBO+g8ylKw//Y1K+mYUoFJAF7uqbbH5Gwd5zivUdut+QdhWWrwsgavSenELopvGRjzKw4nZ4bYP4fDZaIWsETDyrw/M48zA4UWjxY32Tyu1Qg2SIYlhMCFvYAVWWpJNwZGqkp1d/EuoPpvOEAdSqWSfuXvp9cwhQgNlKuXPBW3HG0Sz3ZvDFlCIHogAMz3r6+/FiVCDMrJnjk9QXIRP5UqytB7gpCkrDVeZSG8vnghtZOIuAq4JRu4ZgJrc/MnDff9vHIvJtwdX8eS8WQSU1v2DyjMyK6cfpn6B6kVif3vAm8V93lXhtMlRsVOHFfO6bopF7enwnq5kQDwFkYwF0NXty8tZRapq7AqtBfZfCKDEsEPTq1aYNrSnSzsxDT3MyXWoWOqhdvqphGVI9TGirKgSBU/Ug3OyQ4iU6iBE+PSvd3I+VjX+rgQu+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(316002)(54906003)(26005)(9786002)(426003)(66476007)(6916009)(2616005)(4326008)(7416002)(36756003)(9746002)(2906002)(33656002)(478600001)(186003)(1076003)(83380400001)(8936002)(38100700002)(8676002)(66556008)(86362001)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?f9xpcuwGj2GOojxMKbEPgq/kcgxRN9ax6qr+i35ngDqYJCdftywQwfCCeI8q?=
 =?us-ascii?Q?vPLGH86ULFDTPq67SSF+2y6Dgmv+Pzz85S+fM5WChMeY9pgEP7On89vtrrj3?=
 =?us-ascii?Q?PViRFYEytq2oY+chm2GvqJTE2yI9lFsZkabXGGMswYVgK6LOF2q/vdTZgpzz?=
 =?us-ascii?Q?UYmy7QG6Z8y6+s+4JqQzzodMUzkN74C62FLBOfcY9JfAC+BA9ig+2ViLGb5F?=
 =?us-ascii?Q?9kydFb7lpjdW1xXlwEvc5zGZDrDATeEW6O/mNhNws3qx3DBoqVOwd/5CYPF+?=
 =?us-ascii?Q?dubfOjoJaTQTDrL08WkOVNXfwH1jHyYpBvoES6NQ1m/ObfxSAtHLzCugJZNd?=
 =?us-ascii?Q?otGnArTWERJ6/B01yC+EqfbjJjdkXW9nH2dkpF7JabXXp3Al68yq/C9AG0oK?=
 =?us-ascii?Q?iGVM0irrR1c5KXpSbdrGHO5khwUUTf0DAKXzvh6wEixEv2z2ztHRDkGyOMjO?=
 =?us-ascii?Q?LpBuUrHxM/AeNVQJdeJbZxJ/GFgvUz7JBMF789A/V0+U22mu0G+hQ9ZQRZDP?=
 =?us-ascii?Q?wd8ZbVOlgGlTOiTG1m6/Y4vRi+O8bpmE8gZEpQEjYEpl4hEA6vMc+6FbTR7W?=
 =?us-ascii?Q?/ySFj5/15fsE2DQ+WlU7wrESf/9n8K/nmxdU7waYENn+RuJgz3bhhFD+doKT?=
 =?us-ascii?Q?8X90MQkYenb2Wtn6Rvj1J4z0nGI+RGTseTPyGijq6NMzlLpAclpkZIiDaHVb?=
 =?us-ascii?Q?xFLESxdR0virdA/KsE40QcniwRY+GjeRpm7oG/R+O/hXvr+ZoS29ckLpMghf?=
 =?us-ascii?Q?dCOWxeHaJRkmJabV2oYxn5J5SRb9c2yhxRibhjWQ4oHTVzh6sldnn05y2OaK?=
 =?us-ascii?Q?OYcuuT5U8mhHZIqIoxZwBMAo0tPM7bSBcgrjldDQJ2KnOcQ/FhjIg/T7eY1x?=
 =?us-ascii?Q?bRvCDXntRIxBJJsOIhPfFC9iNioVFdJmoaC0U8ozkS7DfKIubTVfrfm6BNDH?=
 =?us-ascii?Q?Stte5oUxryMSQDC0txhykIB4aJqrSzlDeJiA0MCDHm/BRd+jGwP1rJSQSHLY?=
 =?us-ascii?Q?3YvzI/0InblpB1aGT9e42bu9WNUefEh9zyGkZPo+sWpwBmib9oDIJaF292WG?=
 =?us-ascii?Q?9vwT4AwOwYHCS1VM0QAzuLYWiwguKKFI6eJvDGiv+3H6NZJmeUbDdau/BRs2?=
 =?us-ascii?Q?4ynRFHzDD+ag6hePGQe0ObsqO4zFVduMulU2YiXL+jDYoWHhIq4h+0aji4qC?=
 =?us-ascii?Q?A5M54ZpqQKZTRv+2CPibvPtyBRSRiPy92/6/E4QTudPmD4g8n3+eQ12pPVyG?=
 =?us-ascii?Q?bHnNGCpBQkJp57ZLaYytKdOzSVUrYPFbx9AoqPuLdOnc3NZFytA8mjQaY5pG?=
 =?us-ascii?Q?viUDzC6GKfijl9B2DgQZ041Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fd8332-8a4f-4ec9-65ab-08d906a70ff3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 22:28:05.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAUXxK6Mx+PdTzOOuK5Kf4MueAoG2PucV45A2b9CUuR8yDVYGSH37NRfcMk9KdnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 23, 2021 at 10:38:51AM -0600, Alex Williamson wrote:
> On Thu, 22 Apr 2021 20:39:50 -0300

> > /dev/ioasid should understand the group concept somehow, otherwise it
> > is incomplete and maybe even security broken.
> > 
> > So, how do I add groups to, say, VDPA in a way that makes sense? The
> > only answer I come to is broadly what I outlined here - make
> > /dev/ioasid do all the group operations, and do them when we enjoin
> > the VDPA device to the ioasid.
> > 
> > Once I have solved all the groups problems with the non-VFIO users,
> > then where does that leave VFIO? Why does VFIO need a group FD if
> > everyone else doesn't?
> 
> This assumes there's a solution for vDPA that doesn't just ignore the
> problem and hope for the best.  I can't speak to a vDPA solution.

I don't think we can just ignore the question and succeed with
/dev/ioasid.

Guess it should get answered as best it can for ioasid "in general"
then we can decide if it makes sense for VFIO to use the group FD or
not when working in ioasid mode.

Maybe a better idea will come up

> an implicit restriction.  You've listed a step in the description about
> a "list of devices in the group", but nothing in the pseudo code
> reflects that step.

I gave it below with the readdir() - it isn't in the pseudo code
because the applications I looked through didn't use it, and wouldn't
benefit from it. I tried to show what things were doing today.

> I expect it would be a subtly missed by any userspace driver
> developer unless they happen to work on a system where the grouping
> is not ideal.

I'm still unclear - what are be the consequence if the application
designer misses the group detail? 

Jason
