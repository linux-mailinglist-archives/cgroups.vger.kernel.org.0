Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E160E07F
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiJZMUS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiJZMUR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 08:20:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01EB205F6;
        Wed, 26 Oct 2022 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666786815; x=1698322815;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UWStb3Hq9K2VYjGnDiKV0VeG96RDPegWwO3DvjRkO4E=;
  b=jbtPwjwbwbOhu7+Bnat7NHXEJP5WHHZCSOOJMXunif+Cm0N519/jx+IS
   upbIaWXmlFGjfkb1DAtePVoXAz9GmVnkO0HyHBgd2QGUvcneXejrybaJr
   XpZdt6/amnM7qWYo3HNlR1muJfdfa4UFXPIxWKkFNd7mRcBPh40zoxBx/
   9F8ABwAo3IflzLtlTYBDv2YBy1ZzkjC7HbuGAo1l/loQIrJHCeGUoX6SX
   Z1IW5yZf33ai8l+ZjuAYJ+yiS6sA4GaAkoIpjol9jmVUhz5JXl5nXws6p
   lsN9QQrdi+I8OiuwC0Z5htMi4g5FcQ3+l63I198HeLW1j7EBIVgbydY7U
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="334548143"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="334548143"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 05:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="774564571"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="774564571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2022 05:20:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 05:20:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 05:20:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 05:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3g7xJ9FF5r6PDLKMTa6Q6uzfMVMtIJnw8RQZmLkOlXgaC7vF6Sg7RwgycDJqwKfCFJzhR9lc+OGzcOJtYKKO9mnYvXPMwQYE2fQzoKcrqH3obGpUdpGPZxxipcz/qrYKfuMdUYori/pl8jwy3Mt/VdLWgLp7P4yFo45ZSNidwwp/Wuow6VjQZvagmQUMZUCDUZFKPiXRyE7Z2Ro6xj2eZ1ho3L3MQmj3F6aQxC6DeqFYYZHq/lmDrxYcf7cPD36wexRfjx4s0/KCA/OK3xw4I9LwaSkq0auTnt1IWSOAXqMf5aGHgIYfUVr/LDiRgLhD55//WK3jMW9YohUIpfiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k+umxzpSjBTowmh/uD3b8K/iFAHsv31Z0InrPsb1D8=;
 b=DvQ6R2e2SewBnq0SuiMlfaJwdW7lKK2IZLTd+Rg05L+5MDiqzbURA7qx6rxFeft+D9cF6kNZwO51LTxgKPUwwkd44fp3fD4Hv406HePSRkqBJON0NchIjjK8R3tX0GOgXwl+FMVofNp8jj6rDpufsYgjLkLfebMqV1QEkTdvTQ59TmIYwjq4jqIElSmctocAOHsXV5pOXEXZtHNOr7gyV0VNWsnX8pT7UzKa+r2oDFfieFWBE0xy5acn4kdMzsLcAG3FGVGaF79Foglx1HjFlpVmhrVaPRgdVnbcEY6jEu9IZm8Ouu/IyuEq2+rw2qcG5X39zXFrhBWev2d4oDjraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 26 Oct
 2022 12:20:11 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Wed, 26 Oct 2022
 12:20:11 +0000
Date:   Wed, 26 Oct 2022 20:20:01 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y1kl8VbPE0RYdyEB@feng-clx>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 573e305a-cd81-41ba-8c8c-08dab74c6da1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuhHRLQj/QsqsJyo0zSL4J1YcfkxVcli2ZodWEJFkzrpuLZPc0eUnyH4+Hf3Ql/p57bQ+kOhpVyF4FBTjBQRJgf/MAKWW8I30DE1ijeDAGnPxlhJbHnR0pTUQE69pQy3BIS6743k7ZW3hPCBZWoqp42Qikewq+ygMHvteHXxZoz34roRkGNUrr8lWkUXkL/L7oMG+eBA8qXLQenEsjmG2PRg1m7bJ4nvX+UoyHzGUURPH3Fvwu9R2IjLIiQtBQdHtS8f6O7g2XtJgl4GH3WWgvuCvvVIT00hTr17ta/CqxvY+y3ibn4NgepTwDGsopycwYy/u0iGr/CHAy6g3cYORWJ5rJnEZLC0F6uJAlIQjXmcUwYtS6DWluyoKC3h9IfLkoZNkApQz0Av9JoLh5FYhB4OgiTwf2pNLMqRq4RZ27YekMtJ1lHvX/OxlehEuOB0htJXYG84MX87adRHc5NbjXprV/N1hEJtQ8U7AISELW00oJScoJOqAcvkoDnZhpbSuWk0/J6Uk5I15YZVemlqkk+bCk+Z4BI3FtBKJewVFfQ9Q2gnSjpqZ89YWqCpB2joUtyme88SuhrOY7wccLouZHgELIrqMZ9LFG79Mg9zj+LPscHWXVi4ci6URTdu5pfxkc82nSRSJT3Yt6UVhDB0WCUqWvuiFIgeGU+6XIkHyse5/sGR/Kb4gGa9GKzzgQhaQQlGHiN/HpjAu0qWaX8IPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(26005)(86362001)(38100700002)(82960400001)(44832011)(41300700001)(83380400001)(7416002)(66946007)(6506007)(5660300002)(6666004)(478600001)(9686003)(107886003)(6512007)(316002)(54906003)(53546011)(66556008)(66476007)(186003)(2906002)(6916009)(33716001)(6486002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URu1t9CES64yjxWrL5wv3/LUbX6Cbj6FLSx6uv+r6O2LiIds7RPgj7CNZQkn?=
 =?us-ascii?Q?/sA/OjA6Bev2Z60S7he28DcZC+NVZdsXVQBkO8nKiv66AQW8wOyZGLWCp3Up?=
 =?us-ascii?Q?TarUDWr6GhD3RZYyFBabQEcYb7WJ2qvpU56MLtWuFo83QdQXuimnYIfF//9K?=
 =?us-ascii?Q?Nm+yBot1xY3pb7kHHxgTx2nXNCUiOd4cdTNtM0BwNMg86A/9StOyIawMAXJL?=
 =?us-ascii?Q?Yz6M7a8F4YH563HwGsZfpYFleEd9kyq3oJIpItexTI2FEjbAWSO5PrdQJumK?=
 =?us-ascii?Q?lOkkQdcxDsCxPRqDfE9j0pF9FCkLdPM5MrW5HhRumqudNng/yR9rkav2BtUl?=
 =?us-ascii?Q?05B6Z9mb5aKa3w3mK2+2lO+0oof2OkzcDSYkw68H1bo+dAiC35DPX65x/UCt?=
 =?us-ascii?Q?EMxsWkPNHJly8brYm7BwQFrZ/EDK9EDoxnrAk4hKiQt6JTlXDMU8XvHADES7?=
 =?us-ascii?Q?b5BXa1QhJGomBJJrEdmaSQkDLebWgm9jOJbOjWiHkbj2PCnrQdnJ9Zp4EXXT?=
 =?us-ascii?Q?Fcy5P9GAzQ1a0HaMvR0uJBRdxT6m2vRBgqlc01ppUnSwx5356fFfowGXN/CH?=
 =?us-ascii?Q?5Q7ro4bc4FfacLVWWCxeyU/52Yl8vGhgQC5K2n7heMEN9rM74rYmu2Hu4m0V?=
 =?us-ascii?Q?0oexGjsabUzTq+l9jg3HcQavSC0uxUW17MHQXVxPzhJLyJkMH/tbU90Dllp5?=
 =?us-ascii?Q?9YhBb+E/nAeKgxB4snJ1/S05/eYtueDBHu9gVG6IWDV00sJlXsUr5cohunXG?=
 =?us-ascii?Q?J/PDMvmCYdOUD77NeQ4DRnTGVSou3exYxQ/LmuUd+xbdy/FbAE2AGiVxeBNE?=
 =?us-ascii?Q?t6qe6kloZw0rJFUgKuKM80V+ksIrTL3zc9dwLTAIc31mZlIGmXPditQrB/yi?=
 =?us-ascii?Q?yzEfshsgCcDRVPBa6/GAUhN+uuqUuTJlCu6kAwkoq6H553FkRJ8XDTty1PuK?=
 =?us-ascii?Q?pzDDY7aSk0/SQuRBlp1kgWEQeDAq9qG/Wp2SFOTAgsvlIlc2q8yqq5qUx0Fm?=
 =?us-ascii?Q?v3/WHCiX63us/f+ZG2mmQEZlCBBCL5k7KxXW/wM5FmdFzSCSVJR20ttg4mFK?=
 =?us-ascii?Q?rVZB7oXqKY4eevUb6i0U/TkVzpzNhg6jfRFXIqgz+gkDekKf4MkyZiV8RNYi?=
 =?us-ascii?Q?THHZY6OG/l6AHFvRQ59bFWDNd5+wRaDX1hu4iOskKdL+lt2XtoKQ4ys9MUzq?=
 =?us-ascii?Q?Q+Py1yGCNDgP14/vIAM4cBOj8JouMZRdhSiB70s2uOZkz/fajPCJ8bhmr/To?=
 =?us-ascii?Q?YTsGMYDeP31zkw5cuSCitFEBvBCHgKYxM8cQJJHqkO2gbQJpiaakW1OkiAW5?=
 =?us-ascii?Q?WUc+1o8w7gvGl6dMewgdvup0rsebQhqrMuTG/o0UQt25GEAs+mpvDq2jRFaT?=
 =?us-ascii?Q?6w5o+SBYaJGgNbaIv2WqKnOTMZ9uFUpiBtKBzHjroBKD0FFxAkAtarubEH5j?=
 =?us-ascii?Q?Um1LMkYltyLgN0IOOmKXBkNnKl+Pidt7tcViJAaTmbds38QGRiE5v8cHQmDr?=
 =?us-ascii?Q?NIZ07Sd8y2azEN/9U8Wp2HH50qV9+sA15kp/KMCm2EZQ3I/Ck1mR6g1xy/bX?=
 =?us-ascii?Q?2oDunfjshKMgSoBMg61zen2eAbcgLKv8Zfjiz9i/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 573e305a-cd81-41ba-8c8c-08dab74c6da1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 12:20:11.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhTvmNZcaV6yt+r6N9YiOx6nGooSJpy/CNx57nA0FliOpAW3m5W5bPdVAd3hDOBZu/XMt6L5SvOwb5lHahrcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 26, 2022 at 05:19:50PM +0800, Michal Hocko wrote:
> On Wed 26-10-22 16:00:13, Feng Tang wrote:
> > On Wed, Oct 26, 2022 at 03:49:48PM +0800, Aneesh Kumar K V wrote:
> > > On 10/26/22 1:13 PM, Feng Tang wrote:
> > > > In page reclaim path, memory could be demoted from faster memory tier
> > > > to slower memory tier. Currently, there is no check about cpuset's
> > > > memory policy, that even if the target demotion node is not allowd
> > > > by cpuset, the demotion will still happen, which breaks the cpuset
> > > > semantics.
> > > > 
> > > > So add cpuset policy check in the demotion path and skip demotion
> > > > if the demotion targets are not allowed by cpuset.
> > > > 
> > > 
> > > What about the vma policy or the task memory policy? Shouldn't we respect
> > > those memory policy restrictions while demoting the page? 
> >  
> > Good question! We have some basic patches to consider memory policy
> > in demotion path too, which are still under test, and will be posted
> > soon. And the basic idea is similar to this patch.
> 
> For that you need to consult each vma and it's owning task(s) and that
> to me sounds like something to be done in folio_check_references.
> Relying on memcg to get a cpuset cgroup is really ugly and not really
> 100% correct. Memory controller might be disabled and then you do not
> have your association anymore.
 
You are right, for cpuset case, the solution depends on 'CONFIG_MEMCG=y',
and the bright side is most of distribution have it on.

> This all can get quite expensive so the primary question is, does the
> existing behavior generates any real issues or is this more of an
> correctness exercise? I mean it certainly is not great to demote to an
> incompatible numa node but are there any reasonable configurations when
> the demotion target node is explicitly excluded from memory
> policy/cpuset?

We haven't got customer report on this, but there are quite some customers
use cpuset to bind some specific memory nodes to a docker (You've helped
us solve a OOM issue in such cases), so I think it's practical to respect
the cpuset semantics as much as we can.

Your concern about the expensive cost makes sense! Some raw ideas are:
* if the shrink_folio_list is called by kswapd, the folios come from
  the same per-memcg lruvec, so only one check is enough
* if not from kswapd, like called form madvise or DAMON code, we can
  save a memcg cache, and if the next folio's memcg is same as the
  cache, we reuse its result. And due to the locality, the real
  check is rarely performed.

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
> 
