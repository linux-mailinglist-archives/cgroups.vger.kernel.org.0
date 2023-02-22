Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2DA69F393
	for <lists+cgroups@lfdr.de>; Wed, 22 Feb 2023 12:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjBVLmL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 06:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjBVLmD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 06:42:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56139CE8;
        Wed, 22 Feb 2023 03:41:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiPzJpEV2/ckfX8zDGhDS79AcaDMMs8MAiV02+ays0YRKuLeZg2QS/v0kkDD7qhcM9qmNrBJ1/HTIeV1pLE/CQuv3/zqDRjtnfHuzVRg4elD63v8hcRIdKNspmeNsgRfgND4kE6nOymnPu2/Q3wqx41lW+KvnrIpolgDuAWAMgfihMxxxMbQKpRGrUdimFY7/+c8O6cLHwaxViqK3SYFmWc45nDTIq6mRvrJwAEi12U8dT1GefPrCrUbMBFbaeD40fGcXc8O3pRZ+sojdErT7E9Rlxdijo1gHVpBxH5Z1OwvSOkYCvOONEh/knV1kU5tVEZQQGxMC1gLCObUyDgTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/J2SwDBtKM0rMVHMgsxfFOGyPRVQvdH0dlElN3WvE0=;
 b=TQYLKRLGukvEYp/Lv17NY+mc+2xwR1tZ8pOQsfEidD8/JTqTFyOz5LO7gO0hlNvDJ8Q+UFe9jlP/Xqsuib+z7jJTXyWnPdro71lZv7UGzJXEPbaP6VeQPecO68tFPH0dS75Gs4NKZdncx1OfbkG0J/X+yHG6Grl/WVpDKSImuv3qQWlF8y01QePaeaTxRKgnGSzESY7qknfxL+wu4IsLEFoLh2JQxHl0pqyCpgxRLQAmgr+OXwY+AuwAjYuBb+WLX+lHf/YM+f6QnphxtTQf00iFh4Tu1jXPl9Qo70eQtqSvcbaYBq7tuScbC3q9NeeWFLX2i64i8FPB7zKFDMiZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/J2SwDBtKM0rMVHMgsxfFOGyPRVQvdH0dlElN3WvE0=;
 b=dmrFMrylJDmeUBjHxti8ni7nIurDKzJiWNwef+HFUdt8NyZ/6g63dmlbBNQGtjovhwIx02QHTpdCsPKQVphXpdnsT/jAPJa2BWTx7LTILATGyEWwYDkaJaCVh/Q+HlwIzsIueD4GSeEjBptFMGv8hdY6sqPlY8YmsBoakazmzeSFzq/Xyw6knuKrRHeKNjKh+IkMrr4Mu205afdC13+L5JnEOXh3Wcj5cssrFmBJiyIgBx4nuUlAj+yIjMgXrAIZGqspIMokuSimJUz7fgaitTMrPGAmMk6KIh0zF03w90+B9/91WiGczpFKX28tKS8sw3kRKWLcFdJ997uAammEGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 11:41:17 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 11:41:17 +0000
References: <Y+0tWZxMUx/NZ3Ne@nvidia.com> <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com> <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com> <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com> <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com> <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Date:   Wed, 22 Feb 2023 22:38:25 +1100
In-reply-to: <Y/UiQmuVwh2eqrfA@nvidia.com>
Message-ID: <87o7pmnd0p.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0216.ausprd01.prod.outlook.com
 (2603:10c6:10:16::36) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 67eccfb4-bd15-4b28-c535-08db14c9b5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDqoo3Khvf59XCxbSCApbCP7MDIfDUPI5fagJ8R5c48LIwXlmg2KqbTkxoC/rg4dRebBBYlg0DwoUKSkn1tKCDNnwNQTAT/iHj0+W7N9FkbPw4ts17PoRsQU7hI86jslfKPkPl4UATMlhLBo//5speQeO3lZ2YLxFZr/5Cp3uwWqK6HwzCR/FB6pR0lgVH/TO1JQYOx4EQDrl0rU+ceDjhayv2/iel4I6NW/1d93jsQHTkDgiBRuTy1OPQZL9Kr+rfg/lGTGYdlTz5kC4Vf0VCXr4JdULi5DZiNjRg1q6yOzj5OlbBhwsUZwTX9HaXIFVoyAhvENV+y1oThasIncGISC49qCI00LJSL/FDEJXkM3kcXZU1qVky7V0LvsstunWPoY3sjQUJ8jDJePBcBFfXGJaLrVf5/0x4xlbNLFeuWsr/KAyW6iYHr2cPoeis+v55c4Fa26lltiQFrp+EwlFpViktAgIwRcAzDwJB+T16yicmetIYUhnuAYQ6U7IW6syEur5BLjfi0Ntuc4VFiDdTHIkDnnZ/ovvcih4bxZSt2NGsl7WIf8ecHswX16+ZaJ/QgxnR2vOp/6JQ2UmP+dn39MDl+GCcXckND/Ltvy0D61jdpsGGyqE4pHuNcMnt6RTXGYmRl5ZayFvv8tie78AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199018)(86362001)(36756003)(37006003)(54906003)(316002)(83380400001)(478600001)(6636002)(6512007)(6506007)(6666004)(26005)(186003)(2616005)(6486002)(7416002)(8936002)(6862004)(5660300002)(4326008)(38100700002)(66946007)(41300700001)(66476007)(8676002)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKG6FnAEBYVIBy7MJKIejJOOBFswRMVJ/GgdKZTuQSX+qSJPqFq9xklqgQVS?=
 =?us-ascii?Q?zOiXSENFKGQVpu9MinmSC6tTsvlxGPz5VBr17z6OLeLx9zeifjFG4RoUi9AR?=
 =?us-ascii?Q?Itu2rl+A6AwdBj0LyWByIoEVtrNHd/yQJsBFK/ttsi4xK8byGsc6XFvswumZ?=
 =?us-ascii?Q?S5beDgv7LWbIHVXHqzIaTWED2JL7BMSGE4IuO6yJfPdzhPXas5iTyDepd8Gt?=
 =?us-ascii?Q?JIG+tCZhwQCNA3xjEJQMhaY6Iz15U5+XMAHLUgXKY4I3xTFBCxLKRNOXJcYh?=
 =?us-ascii?Q?QshAcLlnOOwcyYZDJSCvicRIvRwvRYwPHUATqnogETGeTbedkSPNfjXHSLRa?=
 =?us-ascii?Q?XBibqIR45kS1n9EHkk+ehDRHf29e1Yx2s/IQ1TjIAdeQ65mKMQpsImQpeD3q?=
 =?us-ascii?Q?Tlv3PaBzqOyYdZCD/s+y5I+y+a0LEpcWPhQbbCFFJp6Mu1eI9OwigLqXs8jj?=
 =?us-ascii?Q?96PfMP/JFxGXdPybM8Ijpw/fzk1fbN+JO3Z0ojSNfsUJqXx7F/R+1dMo8WpA?=
 =?us-ascii?Q?FtjWdx0qzKROuf97qJ1fsDbH6FqhaOG1rIneMv/xIUhOSkYqlhEqVbscXZDQ?=
 =?us-ascii?Q?oZerkix4AYhyUlfp72AKWIZe50mg0uJwghvhs95jCk+fGxTKsvokmxe36lGV?=
 =?us-ascii?Q?7YY5KmSa72bJo1NaM9eHeqcJE4pHuX6JNocZdP8sgzbZy9IgZ9q8Nma1e74O?=
 =?us-ascii?Q?k219BVPDln6+HFzmhUuVtSY9QiDwgWhYVpLourG9J4EQKR5a/Gm4PdzS+Tc8?=
 =?us-ascii?Q?YE9QDsUQzUOwAw5ZcuaY4fp41sYPElcFdY52OLnvwMei5ltfiGJnJDCwEi6a?=
 =?us-ascii?Q?zThpnVcCDdj69/yNQCLfujl1f7mCHf7KOLWKP9h1mWNjnyR0ogyK2DSEcwFq?=
 =?us-ascii?Q?u2rRD/xDVFLacU1ug4I15c1rYKiYfM7QXdpVQhRb3X4iIFJknkB38tAgyKzj?=
 =?us-ascii?Q?CPCHH6nnYsHey0YDMd9sQ5vS60gHGQPBMuACzmNWKfmJ656A6coVM9LviEzp?=
 =?us-ascii?Q?+PBzuPrb/jpGKAiZ6Ace5xlPBWguu6AP8qWYxyinEHTar4uYEuYOIDDbmkUA?=
 =?us-ascii?Q?MIzh+LIKvnwnUxlF2XyCMY065FgS0rz1ajcsdulaoflcLks6ENHnGbJ8fMmu?=
 =?us-ascii?Q?ErNKbcWXhEL+cznexgj15u/pTndh7u7DXwbtUieSEy6jDeipAQGIXH/eKX5F?=
 =?us-ascii?Q?OMgw+Y12DiHmlLuIjOxrQ2bqXB1mzSLmk8OZtVcbLg9RrnwDQOJN6wHYYV/o?=
 =?us-ascii?Q?HemKvSpDlsaoVxLdUjYvnGuf9by2Ex4gJikQKwh7psAk8TFs645lcy0qNSRo?=
 =?us-ascii?Q?a4AlXR+OgQF2NyvixTyRBQE7tn8EcqwEt5vyNZP5ecN5s1JKSJ+BuSX6cNtg?=
 =?us-ascii?Q?lCw8wMGZOkOzbztwrSzd55vqXIwUnQvcc/x2nMWXCH2NdZXroyU8UNX+y36K?=
 =?us-ascii?Q?KK+T42kyfykX/Fj0JmhETYOGvYU/f3Z4LgWQZtg0sCN4GsaoAvTouNdCaii0?=
 =?us-ascii?Q?Fyt1mtK0WfisRrv6VrAD6ZbHn2KGHNzil3GjOn5WWDFOhhaoQ8K2vGNfAbz1?=
 =?us-ascii?Q?BTmKdF8DUSSOqyhisJ0rt0hA8dKmP50IBypAx+Ms?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eccfb4-bd15-4b28-c535-08db14c9b5a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 11:41:17.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdXOEVsSJNc8y3M44lHm8gCz/BKWz518szVvOqBjA0Fbb570N1OsbvRYViK+FhHWya+CqQiuYQODTaDvLAe0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

>> the owner and pinner disagreeing with each other. At least
>> conceptually, the solution is rather straight-forward - whoever pins
>> a page should also claim the ownership of it.
>
> If the answer is pinner is owner, then multi-pinners must mean
> multi-owner too. We probably can't block multi-pinner without causing
> uAPI problems.

It seems the problem is how to track multiple pinners of the page. At
the moment memcg ownership is stored in folio->memcg_data which
basically points to the owning struct mem_cgroup *.

For pinning this series already introduces this data structure:

struct vm_account {
	struct task_struct *task;
	struct mm_struct *mm;
	struct user_struct *user;
	enum vm_account_flags flags;
};

We could modify it to something like:

struct vm_account {
       struct list_head possible_pinners;
       struct mem_cgroup *memcg;
       [...]
};

When a page is pinned the first pinner takes ownership and stores it's
memcg there, updating memcg_data to point to it. This would require a
new page_memcg_data_flags but I think we have one left. Subsequent
pinners create a vm_account and add it to the pinners list.

When a driver unpins a page we scan the pinners list and assign
ownership to the next driver pinning the page by updating memcg_data and
removing the vm_account from the list.

The problem with this approach is each pinner (ie. struct vm_account)
may cover different subsets of pages. Drivers have to store a list of
pinned pages somewhere, so we could query drivers or store the list of
pinned pages in the vm_account. That seems like a fair bit of overhead
though and would make unpinning expensive as we'd have to traverse
several lists.

We'd also have to ensure possible owners had enough free memory in the
owning memcg to accept having the page charged when another pinner
unpins. That could be done by reserving space during pinning.

And of course it only works for pin_user_pages() - other users don't
always have a list of pages conveniently available although I suppose
they could walk the rmap, but again that adds overhead. So not sure it's
a great solution but figured I'd leave it here in case it triggers other
ideas.

> You are not wrong on any of these remarks, but this looses sight of
> the point - it is take the existing broken RLIMIT scheme and make it
> incrementally better by being the same broken scheme just with
> cgroups.

Right. RLIMIT_MEMLOCK is pretty broken because most uses enforce it
against a specific task so it can be easily bypassed. The aim here was
to make it at least possible to enforce a meaningful limit.

> If we eventually fix everything so memcg can do multi-pinners/owners
> then would it be reasonable to phase out the new pincg at that time?
>
> Jason

