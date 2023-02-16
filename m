Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029CD6994AB
	for <lists+cgroups@lfdr.de>; Thu, 16 Feb 2023 13:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjBPMpq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Feb 2023 07:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBPMpp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Feb 2023 07:45:45 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A181210C;
        Thu, 16 Feb 2023 04:45:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLm0Wbh0rl0kDcbgfMxnuGCOG+er31CQiYpIE1jySIGM6pejLcgGBlfULavYTlWpLzZeWTYWWkcMyyC/cIod+0hAXH9DL/El35uqUdmjF2BiOErqibky1tFIN4iSkt2VrsbMf6sHZTxcBDmDKfyR7udQxZcX6AoaWLhtofs9drjbMcPIz+XDhLRrwV38IkpljSFfgVVyiS8HQJmg9+QsO2Ay3Vs7msHY2XoiNjlKyPOx6EccxIWMNGAXxivw71bD6Mb6kyyW7blb/cxjtNP/7153tarexI9uam/pFaRCgC43LafsU0d8lpsdJVkECMZpuq7nZTPavU1QCiz/+KxRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dueX91XBPxeg3KkiY0Sk6ldj36DhXEK4K7I69eP3Ybs=;
 b=BA2gDw0oBz1/OCDybDLhfYdXp0sh6TMoF2WvqI28UJAY+6meEWwSCVmpqDceEV3jPAChyqLRJHJnQcSyF0ta0CIm0p/hbbLKK5EnrIQxvwooEZXUsWCheEO901+g799wQxs16BaBSc5SkaGt0jrRuIOl6+cJSiPBMgx5GEI3Qv7nB/nRsjlukhX5SKLyluaoNDU3PIod7PKKHusz+Fq2Fwu/jjEFSB30621Z7jv2mfcfWkf0+MXa+aBO0jxz/FeIFW/JicfQ8XDM4omLvCcrbg43usxHht7ffG/nFUSSvTsFlJc/P/urtLpl7tIL+bm1DgaI01h0x6EbDz00akBN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dueX91XBPxeg3KkiY0Sk6ldj36DhXEK4K7I69eP3Ybs=;
 b=X71sqwUEX9xGSBw9vUgX1TE1rviSXoyGnsvaC32q5bW3vZmdhrJNa95st8ls2sFoJVEEZsHyv+2sjRN8lQFz9BpFQRKYzM8XiepQkwLP4r6sR+fbIrKlcxT0nJHhsqkbxR4wcDFZ+VMUiR1tJ1drUmH4qL62PWSXZjGDo/f0q1XNROrc14V3FynZ9W1sWGVlBKkUbSysJWUXpjEnTtTyjXNthcLh2Bdw9BePTY4+LSItLP7ALYep+qXyJ84d/GsboIepPdStPHYHvMr4Esl3c2IYaKiOtX+vnzfgWMBkwaFWQvvDEZzE7Lsn+JN0d4uEgK3GcKRcMeHDjDWC6/9XqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 12:45:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 12:45:41 +0000
Date:   Thu, 16 Feb 2023 08:45:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+4lcq4Fge27TQIn@nvidia.com>
References: <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
X-ClientProxiedBy: MN2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:208:234::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7467d0-ba9b-4fcc-2514-08db101bb5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHlNCOBz/rjaaFVcbzOolSE6yX4GygL6ISdEjBC0C9jOf0g7vJiM9cfAJnDsQV7ej7s7nfW7x4a/fN67toALUKZNUVTa1QR8f4q1wQ2mazTw/UbE/QjS2Apgj56dWLjiRGRjgeHdcllmLIGqu6jsO1Y9mx89XrZLiqeqBnDbxyb/8rAu/XvQkKpV+5+7sniIZXxZHN1tey449HqWE/uugawNCcFADbX+qybuackjKFpjtlRSguCi6+pnYTnb/ZAHLsB9nIacz/CPd3SV9zdDeEIZgC0H48VwdqLWFXNFsxHklPfLBaaJcta9yBKk7ozyv9LRW69MedzOPmk7qN65zQT+7+7AyvrBvNrDPMcUYfFmI0LCquze+QLS3exm7GPfnthvrj5G4KS5eIUVRZSRHUufoZc1Qbf/55lVgXXNbwmtCsXcwn7G42iN1Zeknzm1E+eKTS2Y/87G+qiSlX1TCXri8Fs1q8mE/VbJQq+lAS/aLW24HSAR80VasWVNEtlLTmrXEbgwXOjXUl9rbhAA1SgCAFjWfGzTg2fYvVNIOHUaGo11zlU82ZFSujJKPcrNtoKj7Zd0H8vsk4HLQ1765knSr6MsZcG3mfxKNJw6bTje5XG/Bv0V9EeYUCQVq+GPU1G4Is2kP/IKqnNiTAtrrT+PSUySXJ0LCGPMvdyMLL46coMN6OjYWGRGy3Jjn+sT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199018)(86362001)(38100700002)(36756003)(5660300002)(7416002)(2906002)(8676002)(6916009)(66556008)(66946007)(4326008)(66476007)(8936002)(26005)(2616005)(186003)(6512007)(83380400001)(6506007)(54906003)(316002)(41300700001)(6666004)(6486002)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHk0c+aVmHRBO7KvHISFwN/Pk03DIpvg6JBQKEWSq2nxhgjAVVayDhRZUr3t?=
 =?us-ascii?Q?R+Yw6d4goY17KNwuUHpcfn1hY0Gf/e/xQr61SUaeHa+RvC1m5I456Bg0vvxP?=
 =?us-ascii?Q?qPu1b0/XQiZ2OGqIvifmymOmw5FRE1MA7h97iY/T+IR9Aai0iSt59ilQrqWy?=
 =?us-ascii?Q?lm7dIAX2cNEUfD3/Hggk1LCpcU28jjMGSFblMLdTfclMGQaDGmKNzkTzvWks?=
 =?us-ascii?Q?EaPS62ORH+94UeaCFElab2NtLMrgh+oPhh4So7iTjAvwXXNHN3QvS+HyEKr1?=
 =?us-ascii?Q?LFGL/nWx3at3xN2xNM25in08+q+qA2XK/RHHAHo4F+gz1mVCM0esJ1oSvmol?=
 =?us-ascii?Q?Pl6Txf//sOyKQ+sIpQmmsDR3dSQYp1ewp6ugeR+zYzyTqoAvw0OJRd1MbTDS?=
 =?us-ascii?Q?l+D2fcPgkOodikzAvaR9EWAti/SwaR+NVi/cfo3pMCtWe3Z5ir2TW9dQQzy4?=
 =?us-ascii?Q?lf8Tb5IJoccSNd+KqoPGJdZZ1FtCkKC3HvgVnqSjIusbxdm68IEpBm5fJLC0?=
 =?us-ascii?Q?UqzD21XkhV1uxpzMaeeraN/+qpfwKu40JxHT1vqf+lH6CIimAewkvKoNlugC?=
 =?us-ascii?Q?qyviLTaMwstzdFxZr0Konh1iTaMmQ3Eyy8+jdfJmK5IPkSPX28Z2VqQxktNh?=
 =?us-ascii?Q?9E1cAGjLJet4RqZptngI5Y0xCJ/CGQ+a5aPnZ9+R/ugAhoS1V9F/QgFB4RuR?=
 =?us-ascii?Q?EweJXUKiVwkBzN4/0iXX9nGn2cyJMmLNiIO4IkvgQ4sgo6XjyiZYm6b49lQ2?=
 =?us-ascii?Q?219pBOWCxf4wQikeIzR8SpPBusy+olNiNXHD3QRxxeZtnT0u9OtDhZcg22WZ?=
 =?us-ascii?Q?y/claY2tF5wB+f8WaFzr4W8dqucE24aFLR/hh9NikxcpXlw9waAiqWzsSFTr?=
 =?us-ascii?Q?KclAckr/vFYYru90yv8WAfOJ/kzUVR8UX2voXwc5EEvHndJYMOddDKPpneDC?=
 =?us-ascii?Q?nHDDc0aq+g3BcDFNbkCD8Ag+7JBKgUhyzGUNi3plDN2+F6AI6sT7eV2s0ISC?=
 =?us-ascii?Q?kPM+KfAEOUnzOXv4Vq5cIg/12UjyRKkGIJlXK9GXRPOBJBbL/un/L8YaJmaD?=
 =?us-ascii?Q?DnEOQlhkcBZj0kwwvo+n51vQSNGg25d8jgErbQZ2q0p08oE6D27f/Eu7uKEQ?=
 =?us-ascii?Q?GtFPzuiH3BJyxa6wM5HhoY8VvUJe1acHaWsTY6BEwgfIz/76lPUvVSvrlfs/?=
 =?us-ascii?Q?+eufc7SaErQkHP75O0RSQn45pQoLAXdDraPQu5uexhjI0jAE7UeLXNHoWAv/?=
 =?us-ascii?Q?BYqy4uszhFVQS/VOaBQrBf7BVdqgXmn/9LC7ljuVjcBxtP9URQJheZ/4HcxC?=
 =?us-ascii?Q?9emKdimnY6qv6CcBUwOIu6GzD1JqjHQfCNRyCQPB3auOIJkKSsLIC9GE3dwR?=
 =?us-ascii?Q?LPvMvrL6+QVFSTucSfaEoVIOhs3y+pkrxTrbcWZCnPKC8w7azCI4sOkl81ag?=
 =?us-ascii?Q?hFeYTmbrOYle6JDxzUW6hO9u3QW7AIIVnOq1ZEhGtZREwIhBL+kJiN95hsqp?=
 =?us-ascii?Q?D0+SnnpnctTGqAbcy2LlLIP+RTdJQtJNsvrufUBo4nh3zIXkTJ+9qniEw8Yn?=
 =?us-ascii?Q?qCvyTH/iLbBJP4ojVh8FmZ8eabcJHJM45UVy6Q3z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7467d0-ba9b-4fcc-2514-08db101bb5d1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 12:45:41.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ew0din0HJNs4Lp4ccCcYG3tVyrdv/M+jbA75rRkn6buBTp+YtHjSSuiMPT/dNB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 16, 2023 at 09:04:03AM +0100, Michal Hocko wrote:

> > In most cases the ownship traces back to a file descriptor. When the
> > file is closed the pin goes away.
> 
> This assumes a specific use of {un}pin_user_page*, right? IIUC the
> cgroup charging is meant to be used from vm_account but that doesn't
> really tell anything about the lifetime nor the ownership. Maybe this is
> just a matter of documentation update...

Yes documentation.

> > > The interface itself doesn't talk about
> > > anything like that and so it seems perfectly fine to unpin from a
> > > completely different context then pinning. 
> > 
> > Yes, concievably the close of the FD can be in a totally different
> > process with a different cgroup.
> 
> Wouldn't you get an unbalanced charges then? How can admin recover that
> situation?

No, the approach in this patch series captures the cgroup that was
charged and stores it in the FD until uncharge.

This is the same as we do today for rlimit. The user/process that is
charged is captured and the uncharge always applies to user/process
that was charged, not the user/process that happens to be associated
with the uncharging context.

cgroup just add another option so it is user/process/cgroup that can
hold the charge.

It is conceptually similar to how each struct page has the memcg that
its allocation was charged to - we just record this in the FD not the
page.

> > > Another thing that is not really clear to me is how the limit is
> > > actually going to be used in practice. As there is no concept of a
> > > reclaim for pins then I can imagine that it would be quite easy to
> > > reach the hard limit and essentially DoS any further use of pins. 
> > 
> > Yes, that is the purpose. It is to sandbox pin users to put some limit
> > on the effect they have on the full machine.
> > 
> > It replaces the rlimit mess that was doing the same thing.
> 
> arguably rlimit has a concept of the owner at least AFAICS. I do realize
> this is not really great wrt a high level resource control though.

rlimit uses either the user or the process as the "owner". In this
model we view a cgroup as the "owner". The lifetime logic is all the
same, you figure out the owner (cgroup/user/process) when the charge
is made and record it, when the uncharge comes the recorded owner is
uncharged.

It never allows unbalanced charge/uncharge because that would be a
security problem even for rlimit cases today.

Jason
