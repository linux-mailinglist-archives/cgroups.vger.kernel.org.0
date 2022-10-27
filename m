Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B6260EFA6
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 07:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ0Ftw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 01:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiJ0Ftu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 01:49:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA945E00B;
        Wed, 26 Oct 2022 22:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666849788; x=1698385788;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=75y0P6V1OYHRCfS/qMOaXMWuDPb16+hqAgnNzT8B47E=;
  b=BXn4IPpVszXzuc9fJHCsOcorXT/NiTyUlcPDRhJ41Pw4J6AAJFK5uQfy
   6xWJJCP+4JPpgwrrmbWZ7JGvp/T7ghZjqaLQfSa3UOJItkvSSyRGFrc6e
   jRHK7L/fIcIXAlB0r/Ood0JdK6XSmPfXC1R4wjoN0XrH8XvFwJXEy5ey2
   kA5Qtt7v0JOBYYU0UnIzQV8q2Cml5eQ6FqGSSKPraxxzF8Gs9ySATcN/w
   0nZ7HIqAcjnCtckrZ8U9sO8LWE0s76tDYmdzpev9rbXAcgv2Ts7fA4T3F
   USXNARVnlvjfQ6DfHkit0AF2t9vM6tCCQkzE0xKA8esBh2Yix+11KzUUX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="288531680"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="288531680"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 22:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="807326556"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="807326556"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 26 Oct 2022 22:49:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 22:49:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 22:49:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 22:49:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 22:49:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgdXxCcWzeReC0oj75g3CO7xpqPlUk0ks5CS7MgGfTrVju89pH1mK2IWZ1qlDB8bUYw49yVxUWJTFcvonY+4egACqRhtgmoPd4qpQBga52CFWHfeVzQlX8ALchxphYmoRwj/FRs6D/T4h2x6V0/7LS4AvymvUimAxsYBcwfUgXBsDjlNVAvifYVEG5jb7IWRD7LFGqHq88QFSbmo15h3yAyrlNlFHHSOCc5OZcmll/S7TlOTbLTFQeEgKo43B0uDVNxjKVVpsEGlbUk7BYZRACBV5hbYzvTACfG5rpHMR/TASp0Kuvnpb+2sL7tUpVFoy2HdcgmHhVvaZ/5gCtm/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fis9vjkbDc2HwxpX6Lm/9p9yDwP6MRAwx9p9mZrLlEg=;
 b=aQc/LtmK+a7cXh8uYyjOfY5+YdAcsuZjllSqrDkFJbVkbhzumt6vz8VTtvgHbgR9vKs81x9tOaWpo7PEZyGeH2NELI3LUVek8ovikubXXNG3S0TL2oagMtHQ1vxr3QXsdxKNRKDF88v5JiUaiLn2lFGLyZ4PpExPG382aOeu+cweKoxKH0e0XEKV6JaLmQARjO2Fmc8oQv3frqzoDmJ0MT9oX/urbC7A8txKMOjhKUs60cjAF6xJ3zz4VSFEUghDBgDRKd3f3xrVQGIXi/Wd0LG/hoFf+cAjNgg8tHu2B5P0MiGi+yjHqda6NaWR8RTkhIYRi47S4XgyXSKkMChq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 05:49:35 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Thu, 27 Oct 2022
 05:49:35 +0000
Date:   Thu, 27 Oct 2022 13:49:25 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hocko, Michal" <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y1ob5XxqJzTDjBYy@feng-clx>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <878rl1luh1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <878rl1luh1.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2ca9e4-bb68-4277-b72b-08dab7df075d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZWVW5gPPXvy1jAvFDdtKNOTp7K/fZ2yeiI3yWjPVYzxrE3uq2CK5TEhFuK8oRYTP9ZoHtrdETR5/5vLM/TAiR+Ic6uBvEkjXjSoZ1WRY44nEGOixDojxQ/UjstXllY46rCfseaRoLtu1sq0D6M7teCFiY4+LJkSG4G2FlqmeOfguc3IgDkeUooIPZPPruRVGywJO7Jbt4OAbPSr0iKTb4ueHauDZF0x51GZtVtGhqwUXicSrbmRV0WYoEV1OfNXYKaeQrR77CFkWMBog/vh/S7E3HMhqfUwBpqa/k8bkAhqCBdvvOvln7uCTcRzWS2MlHaWFCl+uKDHznbVAyuhIuqEyJygKRQ8Xnf7dBy1C1kFTyr2eJTiGRcrdJcDihHQrjHnI9Sd95GGzN0X8wbuh7TRYgEp7xw6WFwJJI4eSY4Eaxb88tbW07uySKvJYm/gAfQui2jfkcct1Q0esVOv3b0SQwz/9WkP23iUhi2j5IKdjwWB51T96qNXVFs9ZfpkYrYkubGHOKvUDCJsqrhqE2ikUfbLBJCM8ttmrwV8cwgiEzX7d4rejdfDUlgU1E1nSebUAMNmGq4mHdxLgViCPSMRg6mi7ptYMur/XhNwcwzcirsX6qfOxXPO4by+H4TVsChdeGjlidKB5+8rx6NCakRNDpy5G4Um7WF6flbrWeZ/25WMRzdWLSlB2d9fuQukbxuuWCbO6ScI7pj63i53Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(86362001)(38100700002)(82960400001)(44832011)(6506007)(186003)(6512007)(2906002)(6666004)(107886003)(478600001)(9686003)(26005)(83380400001)(6486002)(8936002)(316002)(66946007)(54906003)(33716001)(6636002)(7416002)(8676002)(66556008)(41300700001)(4326008)(6862004)(66476007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ySezv/6msHsee49n1FguV+bRmn7o6o54Qd7JRbqz+kJVTyPrauFQZ1iLa5pL?=
 =?us-ascii?Q?i56F8MY3v6pgju1+n9iTYbx1AUiE+Hafhm0czAs2y0YPttiXhIfs7gFHvK1y?=
 =?us-ascii?Q?UBxpSnUUv4woeY6HaDspFbEFQLcmhZ3+HVA+fIZ5QNG/S4YoZXYGPQUUZji/?=
 =?us-ascii?Q?EoGaWj4aOjBzq4BzwmwPBOcABNTPnbiAB3ZbPW9NyAQjh81OC0oX8p2BNnZ9?=
 =?us-ascii?Q?zd4gP4wqkcaPK0QDBj/V/R8VEA2J/oGdeXBFHEh+o/QAkJd+SSFbJAO7/SGJ?=
 =?us-ascii?Q?CLk8IppgMfaJ8NXylGxxtnsz2s1FUZGSDxDbKok+w8Vs67U/sOc3SjNh4DEZ?=
 =?us-ascii?Q?0I0/bwQ78ti+rGYT1YJPvgSKPXQFs0LxiXNPpfC210L4/ZwrMdnI3jho4K4r?=
 =?us-ascii?Q?+oB/8GWlxFocWOmrI0ImfN5s/vbWsH+X7xXQuS4ykiMahj/jPGUbmeZ+Plvc?=
 =?us-ascii?Q?7l8dN/p6gCMO+LMzLw3+sBXrVVEjhQwc1JVWvIf5l1FM1cZdc1XsSGfeDGty?=
 =?us-ascii?Q?mv0IMClCHKYsOhDCr5oWuc3Pd7A7Lbe07X6MS9bYuaiuU74MVfnhqgGJIv7b?=
 =?us-ascii?Q?3FbCbRIe0HZnHItQSpVZdeMb3fg/6FJvQ3+xUHGoX5oWCWF3DV5NsClXC4xO?=
 =?us-ascii?Q?qRPpihRfIqCQfYMfMfV0E31JPlqk7jM84WkXyk/VtN5Vb7kngOQkyrdyu6Sk?=
 =?us-ascii?Q?7gUYduk1hxA6ScId4mIOtOrzHyjk4mOgh9Hhci+e0NZHPWc5mhUU9gUKP7ti?=
 =?us-ascii?Q?kfzH4OeYVzQfcp3gGDeiIz0eKtjit05w1dUKni21wY6gnpZUQvzZwgHaUx3P?=
 =?us-ascii?Q?AQweqHV94pmA6P3SpEgkEUv3pD13oZrwoNLhsNOOGdIKoYRRA/fbmbBf+hXb?=
 =?us-ascii?Q?k+AsZERvBg4GLShqjm4QwriH+xH9mn8TUROMfBAkThqTafw9v8Q5yveo5qDW?=
 =?us-ascii?Q?mdJcYKW8bQ6hc1CH43RqSGz1BL8H4CJyfMV9FxKSKIJzVKCiiUsLm0sPsWNg?=
 =?us-ascii?Q?dA1mKpaGMa7sM26Z0uHbZ0Ze54aSQtptRIip1oLR5GuRfcc6e5XMDh1u9+xw?=
 =?us-ascii?Q?4FMNi1jKkj5VkHqon/8cFbmtf3eNc9rXlBwREZiavD3ytlsIBTn1amxPPWZM?=
 =?us-ascii?Q?b1G5s4uduIQjkomEoPsfw6H6IuXQi+/FPTcWyG+fC2ut/oEdNSMNUFDh/Jax?=
 =?us-ascii?Q?7oo+LLv6uxtqF6zs2ax1hgk2H+2hgINXbZ7ZvTrphciU0ajmCei2pXUqpVOy?=
 =?us-ascii?Q?cr7GOliNtaLuFkxAnZukGxLEv4cG0P88YcmN/Hdbe/9DaVTGETPbDvq2z3hS?=
 =?us-ascii?Q?GHFzfE3nj9+IQbnsZbGCNmClAKEMtQ6GYdGyB88KAQgh7csEPpk+JOZiKpWW?=
 =?us-ascii?Q?RpZjJhI6o78oQOXCR3Z13050NUw1IABJNmVedUrc1stVYPW9rYRu/SFoJQVB?=
 =?us-ascii?Q?nPhre7YrHKACace4iTBCZXfzthHehbLRuDCEQhCfI3Dz8jogiV3wHYJJtO7M?=
 =?us-ascii?Q?tIwCtF/xll3VOvD7uH36VZ2MVPV/QP8gQGJZ97lHkCnkALFCj7U08i9CGwGA?=
 =?us-ascii?Q?C1yH2LEuC1WL7ykPmW4zLgcKGeJstdA+sOZTD/98?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2ca9e4-bb68-4277-b72b-08dab7df075d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 05:49:35.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFAn4atekJe2fwLF0hj3Fy14XRE15ydEYS+awOle1KI+uFO6cLUI4vWLKv5zvOttBCqKAWMWlq2wDWob2YYhMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 27, 2022 at 01:13:30PM +0800, Huang, Ying wrote:
> Feng Tang <feng.tang@intel.com> writes:
> 
> > In page reclaim path, memory could be demoted from faster memory tier
> > to slower memory tier. Currently, there is no check about cpuset's
> > memory policy, that even if the target demotion node is not allowd
> > by cpuset, the demotion will still happen, which breaks the cpuset
> > semantics.
> >
> > So add cpuset policy check in the demotion path and skip demotion
> > if the demotion targets are not allowed by cpuset.
> >
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
[...]
> > index 18f6497994ec..c205d98283bc 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1537,9 +1537,21 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
> >  {
> >  	struct page *target_page;
> >  	nodemask_t *allowed_mask;
> > -	struct migration_target_control *mtc;
> > +	struct migration_target_control *mtc = (void *)private;
> >  
> > -	mtc = (struct migration_target_control *)private;
> 
> I think we should avoid (void *) conversion here.

OK, will change back.

> > +#if IS_ENABLED(CONFIG_MEMCG) && IS_ENABLED(CONFIG_CPUSETS)
> > +	struct mem_cgroup *memcg;
> > +	nodemask_t cpuset_nmask;
> > +
> > +	memcg = page_memcg(page);
> > +	cpuset_get_allowed_mem_nodes(memcg->css.cgroup, &cpuset_nmask);
> > +
> > +	if (!node_isset(mtc->nid, cpuset_nmask)) {
> > +		if (mtc->nmask)
> > +			nodes_and(*mtc->nmask, *mtc->nmask, cpuset_nmask);
> > +		return alloc_migration_target(page, (unsigned long)mtc);
> > +	}
> 
> If node_isset(mtc->nid, cpuset_nmask) == true, we should keep the
> original 2 steps allocation and apply nodes_and() on node mask.

Good catch! Yes, the nodes_and() call should be taken out from this
check and done before calling node_isset().

> > +#endif
> >  
> >  	allowed_mask = mtc->nmask;
> >  	/*
> > @@ -1649,6 +1661,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >  		enum folio_references references = FOLIOREF_RECLAIM;
> >  		bool dirty, writeback;
> >  		unsigned int nr_pages;
> > +		bool skip_this_demotion = false;
> >  
> >  		cond_resched();
> >  
> > @@ -1658,6 +1671,22 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >  		if (!folio_trylock(folio))
> >  			goto keep;
> >  
> > +#if IS_ENABLED(CONFIG_MEMCG) && IS_ENABLED(CONFIG_CPUSETS)
> > +		if (do_demote_pass) {
> > +			struct mem_cgroup *memcg;
> > +			nodemask_t nmask, nmask1;
> > +
> > +			node_get_allowed_targets(pgdat, &nmask);
> 
> pgdat will not change in the loop, so we can move this out of the loop?
 
Yes

> > +			memcg = folio_memcg(folio);
> > +			if (memcg)
> > +				cpuset_get_allowed_mem_nodes(memcg->css.cgroup,
> > +								&nmask1);
> > +
> > +			if (!nodes_intersects(nmask, nmask1))
> > +				skip_this_demotion = true;
> > +		}
> 
> If nodes_intersects() == true, we will call
> cpuset_get_allowed_mem_nodes() twice.  Better to pass the intersecting
> mask to demote_folio_list()?
 
The pages in the loop may come from different mem control group, and
the cpuset's nodemask could be different, I don't know how to save
this per-page info to be used later in demote_folio_list.

Thanks,
Feng

> > +#endif
> > +
> >  		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> >  
> >  		nr_pages = folio_nr_pages(folio);
> > @@ -1799,7 +1828,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >  		 * Before reclaiming the folio, try to relocate
> >  		 * its contents to another node.
> >  		 */
> > -		if (do_demote_pass &&
> > +		if (do_demote_pass && !skip_this_demotion &&
> >  		    (thp_migration_supported() || !folio_test_large(folio))) {
> >  			list_add(&folio->lru, &demote_folios);
> >  			folio_unlock(folio);
> 
> Best Regards,
> Huang, Ying
