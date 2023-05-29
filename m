Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26135714FB9
	for <lists+cgroups@lfdr.de>; Mon, 29 May 2023 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE2TbJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 May 2023 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2TbI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 May 2023 15:31:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F8B7
        for <cgroups@vger.kernel.org>; Mon, 29 May 2023 12:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as22hGHaSzwv9uhlT6HbAIVMKUvIl9x3jKEni64QvEAqIUqQM5AUliJwwFi6aJpNWpN8tbodn692UsdxUrZryfuVTHqFReLg/55b/MEZxbcB6pSR1hJWrhqWr1nSn0p9urtpZOg8ZdW1f44ngVsniueOCd9mzVy02xEnp8FeUo6GN8T20K2514pcjvkR+jD25ou6FMU41GdYjR1JpV+vA/b9THkLVW9vYNThlmoaG3MHkoz+cIcbVXEI5Lh/T0qFKVtQu/nYhxWqvZyJnDYGecDA5hxVx4NO3nphF0ZmKmj7ax4NJ10toCdtsxzI0Goz7FVLxaB+6Y0UKrgnf4AzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J5dDKR78diflsnAZsCnyCogLwszsrvEJfa7BwqUF0w=;
 b=MzoGBRUaLDnYv742uMlX4EUbofrteotS3F6wTylzQ0Z6tfpbUM8He3rYZWyvYCBWXe938uZQOz42+8FJo48fLHehfDTtlzoqw5eggcuIaZjWsiz7yLE2iWpRdQ4XPBHDsdw23/aml4lH/BoydId8CLcLeo9eNRnuhr+0cw8tOKoWnUbCsVDYwAFBdEMthvl2CdkqOQ9s62JoZnIn4hR5lRjM2yOwev46riuyt/GYPfosvRoxl1yjMpW3GsKAwIu0KvgJH1z09yb/uNVg7lI4nEqIvkrqMKgm0Z3+aibJ9vdslKLbXyq5tR05N/MfBNmqPl1AHEOvm/CMg1gUsrN0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J5dDKR78diflsnAZsCnyCogLwszsrvEJfa7BwqUF0w=;
 b=iR9SYMQOX8VeMwvQq1H13x+rlkfXXniOGWkTplX/MaxBGAvvOkWegP4++Drvq2syehrwOcjY47E04ZiV9q7wDzfxfOh31guouIZKlHscDHU4RAhitVINPzBGP/w9ehXsthGjFg8aiTnXQvP6R1ngevIrDXgZs9AkqGBv8hfI37UD96WEHa7iVMPNT1vE3szAgzdWixm//enzTpFjnfq3D2kdA93vG3ltwDgKSwrW+clWgz4Jtt99s7jEmMMdWLngqEV608wveeEbE5kuAeXoiz2TbJETXw4TjelhXdc34YS4mWlVhx7WOoQEf4soN/eMBQcPBeUvZ2Qp9ttd65XRHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 19:31:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 19:31:04 +0000
Date:   Mon, 29 May 2023 16:31:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chris Li <chrisl@kernel.org>
Cc:     Alistair Popple <apopple@nvidia.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Message-ID: <ZHT9dqihVNWqccmY@nvidia.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
 <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com>
 <877ctm518f.fsf@nvidia.com>
 <ZFbZZPkSpsKMe8iR@google.com>
 <87ttwnkzap.fsf@nvidia.com>
 <ZFuvhP5qGPivokc0@google.com>
 <87jzxe9baj.fsf@nvidia.com>
 <ZGjntWoAfgyT0doo@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGjntWoAfgyT0doo@google.com>
X-ClientProxiedBy: CH0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:610:b1::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6cd186-adeb-4223-83f1-08db607b3e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOPxxe9L7mUyLtuC8eZQgFSIt2RvOMdHHZIgz8KRdTcMceSEy0v1YqVJqtwWwv/M0IhvR2aMk/NX+MPMLOb3ko/jln2R2KZIBgBZFmQwvSdrXwbeGoH25oVydy73tr/ZExZDIeqjPUxEBrg2R4QqwUBsjpZIpR6nGJVyhvRD3qgsP7CVorB9DNeRNTpanqKCtzTdZv7WsTdsKgM5DE1AHnzOu+4sD5s1uKf4W6I040M64XlsowFlsigFHCFN1SDGWwIjFvB1me3L3ONPaI7IoSJwDNlX/sdjjkl9aWMCZIxG4BJwRF4mlafXE91cPCwwI7lxNLyf48KbHZnmWSpGH107/+TLj19M/+twk78Gm+Z61TjoyZ6D98PYyx3Jq4AWff2dzl2W6dkk6IVhhwOqDTk7hN5EPmaYp77AwdkkTbyBDPu5wSFu15MHb5EIb95XpTcOesImozyh6CKjqZJrfGCGvqtDVQ521R9qW8ZAnv+8WqNtLTepyg64yLbv2jTZSZH+BAithPL+bYjjQY7E7LbUIBPHvVKzjBpSa4ZjGHMUP4qkPofIIJvJJyfFmXM1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(86362001)(36756003)(54906003)(4326008)(316002)(478600001)(6916009)(66946007)(66556008)(66476007)(6486002)(5660300002)(8936002)(8676002)(41300700001)(7416002)(2906002)(38100700002)(2616005)(6512007)(6506007)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMHAGD0lW8er2QW61ZoJ577pZ7jmeP7fj5wOyXluM2XqwlIXqs6GARb+ixSu?=
 =?us-ascii?Q?W4eFUmriJYnr3d+Hk37MvT25ef42dKxHVTNMs2KjlfLMbX7QkabUDr89c78N?=
 =?us-ascii?Q?zaditAhkKmq8WdO+6cZCB60jlsJiQNYhLkJpwBPX9/HsScamMp5ah435bbHE?=
 =?us-ascii?Q?AF6mAQ7th/qdHeR7kbYW8krgjjbMLa7MFwDjSGAd4aSkFCM1vopzpAPozDtU?=
 =?us-ascii?Q?5KbvDgVwrhTcUz9ydk8pxFgIykRW0wdRwToKOowWkLFzsN8G3gBqznqS5N5J?=
 =?us-ascii?Q?Mm16mzESAN/gtNJFOY/i03QIDhw76BiQCLdc9f5lnZDPkNZfA3cmgt+64qqj?=
 =?us-ascii?Q?it0Qx2dCWjT9x/js77TFmYiWd3913A/R5jlVo/H0Kfto5boPV4/sRROve/ZB?=
 =?us-ascii?Q?1iXGZnlwbQf/Tz47IQv+21W6z7Eo5iHZV5eNgknDQTpztn+E932O/0QYB3cG?=
 =?us-ascii?Q?CP1oZGfv+XHZYx6wVRKB1CQVuelcW1XxCA8cntUv1HgCKb1mvFsJjXKeXaB/?=
 =?us-ascii?Q?Y+tlOplVy4qebVC5tmqAqgho0YkYSgjfGNLDGtQN8CE7MRNjAZf2HKTB+Ie3?=
 =?us-ascii?Q?jImM2Olx+xjfv/7XR1+enk7FVcvXtOTupJgDEZk1YqyuDjmTfSTFLD2xmMps?=
 =?us-ascii?Q?b9rPIpVTbf366g7Sx5NwhPQ5WGduP7qWxLpOkWlKmShX73eXiwbJ/DeBFTlu?=
 =?us-ascii?Q?sThLsQm7pRLUXfWdY8erJNQNTV/naz80tkpUOCJi8Uod++IMpadAs6SgWysf?=
 =?us-ascii?Q?ZvV8Ld5aPhbnP56KNpghaOTk+6/fSOFfrJwo0A7900KKr2zMZ7TyNSSsMHw0?=
 =?us-ascii?Q?syqnSGdE7KtN99YgfEIh7PAM3zf+o/SSc1fxhrUFI3b2v4wKnVbFulBuVBRq?=
 =?us-ascii?Q?hW+dGQHmQx3MSVW2ym+onzCWdmCJsDJAvNiWeTsZUDdBy42kWtC+pD/SnMpI?=
 =?us-ascii?Q?zkH3XfvaBLKT7MqEsUmRrlqFSEpgOzq2oOdfrNwIbc/Jho0UqubzqugjV5wa?=
 =?us-ascii?Q?q7RWutAOJXpvX2XXzWuz9lzqz0G1hTbK4yTkgqGkkghLrbCi1tpVy5B/D52U?=
 =?us-ascii?Q?1suXhb0O8Yv99Y/NUIYgDHPyppy2jyn2Kg5vmaoGm3G0JE2NT66yG+ohVsnf?=
 =?us-ascii?Q?VIdzZMmaVQJdbcmdwRh+vF1hTRK6b2BZnIBuqljT1yB44ksrKq6H5KeY7lSg?=
 =?us-ascii?Q?wZJVQxD8nT2vWZGTKBsCWH5eRgacrG/5ASEPr+nU9HCAdOAQ3/yI6+8qVlRh?=
 =?us-ascii?Q?R9jdlp7LO/t8Ts7hhvmfLMyXhbrgKHa+e3HSuTNhMRynI/F/paKv6aDezRhk?=
 =?us-ascii?Q?iraBWWarpYh9vi+VJxdH1+YF87iAUOxKfyCkEQxwaKdSFo3qL2ndMP7LByL0?=
 =?us-ascii?Q?1kq2Fq3tZis78N2L8g/wiYIhvwQ9LGPExqdYHFzOI5lvSEoywl4VDYpDXZWP?=
 =?us-ascii?Q?2f9vS/AmIinCPJ1tNVmGo0Y0rEkTuhmd4+GrWPLw0g+LRwuRBgb1ABU54mx6?=
 =?us-ascii?Q?dWzJaSAnF2PgudXRCYBHEB6Qp6XiB0N49wNCZO9MgTmD9OdzUzrf1wdtc+Wa?=
 =?us-ascii?Q?/cVbpCIwOtVW/75XGn0QL/PvvVgo3xLQxLEpxPhi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6cd186-adeb-4223-83f1-08db607b3e61
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:31:04.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wnf+Rn55ZB98JRxH+Hin+vCuzdr6yekLd6WAItZO4JYCAbCJEqBxybuet1T07epb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 20, 2023 at 08:31:01AM -0700, Chris Li wrote:
> > This is basically where we need to get everyone aligned. The RLIMIT
> > approach currently implemented by my patch series does (2). For example:
> > 
> > 1. If a process in a pincg requests (eg. via driver ioctl) to pin a page
> >    it is charged against the pincg limit and will fail if going over
> >    limit.
> > 
> > 2. If the same process requests another pin (doesn't matter if it's the
> >    same page or not) it will be charged again and can't go over limit.
> > 
> > 3. If another process in the same pincg requests a page (again, doesn't
> >    matter if it's the same page or not) be pinned it will be charged
> >    against the limit.
> 
> I see. You want to track and punish the number of time process
> issue pin ioctl on the page.

Yes, because it is feasible to count that without a lot of overhead

In a perfect world each cgroup would be charged exactly once while any
pin is active regardless of how many times something in the cgroup
caused it to be pinned	.

Jason
