Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B898F60EFB1
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 07:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiJ0F5h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 01:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiJ0F5f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 01:57:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE7156250;
        Wed, 26 Oct 2022 22:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666850255; x=1698386255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PpyW5P1A1nyfaGrNFMcz1Qt4uf1ujLGkCzaNkQuQ8XI=;
  b=JFQaO4pbI0VbcG8uFk1GLkR5MemxjrOoZ23BgpsKaysb3fXJ5EUXIGMG
   3XASjPDi1ETWslG1Mbzh4CNlvjTB8kE/uuw9P1LZS1N8UwJO1Q74++rp3
   1k8RnWMrOXrzwoRA49hKT55ViCy0nh3js/QGrankP1JDA1L/hSzTwO6jS
   MqI0PHFF7EIHa1SpJksqo12AMDHiBF/nWptx4FaILak5yE8BjXReoXLO8
   cxV3JHDL+ffFPSf656iyPLh1CMcNRUBJaLRepkM7on+IOVYWcKL02KO+K
   sdCV48HDcsMcM6+IVzQO5SIUUjBHOLGmSl/GdkiZ/hEQXmpK9qVgrLsxJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="295545783"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="295545783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 22:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="774868697"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="774868697"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2022 22:57:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 22:57:34 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 22:57:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 22:57:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 22:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkpNXqD4yLdUGjDuOHvI7U8GK3eOTzAXpF7RSFZi93mSPw2curywMvqpLbTzxggs7W4kapJxWG9T6HfT7bgjb4/sadgUri6Uy7NQrDgWle2FWnPLxfuRZTiyYaizBlyDfkPYGC/l2C95AEPg5oo5O58CBA57YMoPw7+Xslfr3iN8Ksv6IQkDBpOscVwbF3bzdgO1tGaWCow9tTU9dMmDJvM0wjDG6IghZRlxNA1UOi9SY7KPhz3O81y7b7+fs4QjOvxLlpSdFBKlhqflbItM9HnJaGpC90pDzt3MJqO7FlvwZuW1pR3rC6Y+7Oxe0u8h8a9ftAOHSELnHdlhs1ZxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkJJxM5t8czBTvZ48SocJpY7mD9ALGkqHr/OdpZNSak=;
 b=befFKOQmAvcA5cgHaGbLarc97JwoCHQRfkFoZkTH6WEp3f18EhY6OrLU/7zPgmhqbosYZDh8Yq9ntOTyEKPg8hsxwtbZXqs79BelWw5MIDA2YT8l72X2kCG9AYI6AoKZ8QpVchCFc9i6mDuzGXjM8g3QSscyGipiAGuXfrL/Ah6qlLL5YMxSZkax6BCH6MOKj6nE/AcJAdFBQXR8T8y0ur4tfGzBa7m5LPfE4JkOlwplR8kYgDoxwLJY86SdhuupmAid51vR6Fj8NBFYOBnD8XRPt3im9DofocWECucJQ/vljKA57oaWVp/5CFcv8aOPLqQNHdM6kbpV1y72rrysCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN9PR11MB5435.namprd11.prod.outlook.com (2603:10b6:408:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 05:57:30 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Thu, 27 Oct 2022
 05:57:30 +0000
Date:   Thu, 27 Oct 2022 13:57:20 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hocko, Michal" <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y1odwO1/5fxqvQNn@feng-clx>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <da533477-da08-88cb-1e76-46364f1a6151@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da533477-da08-88cb-1e76-46364f1a6151@redhat.com>
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BN9PR11MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: e97d5156-9376-412b-f856-08dab7e02263
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEBMFqTZlsiTURyUmqt79UQrcEAkBiXdHHb2gIUOvbeyfxFApSGan7B+ErVd3mYrLv+sety7siC7wDzpv6i3ZOil2tMH6j9eU5snV1CRVI3hCp6YvRJwTWeZkvRUPg2c2lwmu+9kKzonp1oz76/E4grmVU9F9hP8kPCLJZvOW1+2UOaDdS0LvYGdRh1+HLSLP6GcYXY31ugrwboG1G88CpVFyjShtqG++rbNZpowwtqESYbPGzuV4f96EL7GJcsss/IlwzCcHryDWiNk0om/ODT8xoSJmd4XQVrjihcOpdgYMFsJMZFywExY4fzyzKvFZ/rhuWfLF+7aMDqqYDS0znxFlPdZOyOnZJjnTIYOuh4l33USX5mu2gkzdDVy88L1l+UUGarGY497SjPYM76bff9XDReQeh4lck03accehzgcdyd3R+t6c/unQW96cFz/YiwFeeXmie1PrAIu7J94cmfl1MQxIUsQrAmzK1LWbTZD+0Ki4ft13BY3CEQ0mbw1oDFjiPLek8qyTkrzzJI3UGFzb8esh0CWdL/bUU3WXqGzYBOiiV4+btSY7h6WhVL9jHu/ZIDyEUWHRBgKDO5tevfwvtOJwSH+ueXgcHk8wejqasxskeyyMHUECLFG7jXJtVP40jImavAIBXTqXVloPza7/uzbtRKMUztkl22Hd1yuE9gCjyltGqkIf7LJF0mqaa1ZvqBw0EY9sGXBxY4Hmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(186003)(33716001)(44832011)(107886003)(9686003)(6512007)(6666004)(26005)(83380400001)(2906002)(6506007)(53546011)(7416002)(66556008)(41300700001)(66946007)(478600001)(6486002)(5660300002)(38100700002)(54906003)(6916009)(316002)(8936002)(66476007)(86362001)(8676002)(4326008)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VCkyx9V7HQoZVZkTxM6VQWPyyRTNaLHXvaerJbH2gAA65jDKMd96fOGQqj5L?=
 =?us-ascii?Q?6Bh7oGJVHsLA/pLZOmusCa9xcV1uX4mLsnpuBcukkMwXF8CjssERLwW2iBSj?=
 =?us-ascii?Q?FnG0lgiQbbXA5+x0P7cIboVBdOTx5fafWEuoMW/SyiAuBb+u/ffROilLIFaQ?=
 =?us-ascii?Q?/49P4ZiV4Qzy4FYPcGyv0Ds1iJXONZ28AtTyUip13htsLVKuusNqvgyIo5w2?=
 =?us-ascii?Q?7cutlu1Oz8ja4b7/VgiznPfijJvuegRBAvCHKmgz3XgIm4Vx8ICqCfZ/fdW6?=
 =?us-ascii?Q?w5hZqwjksNWDEQz/xeesQ7kyWkoptPg0eaQIF5bRmnDGzjDgnw88EWFtmHVl?=
 =?us-ascii?Q?hO4W3SXG/Sx7pqIfGdkWFaskJdg5N1xXZTHqZY5vI/dwb9cMv/S9mGKatDQ3?=
 =?us-ascii?Q?mYjzD7wo4f0I3fx8hBXjfE1wJGjHhGyr7z20RSnqrTpXjpQMEuM7z4hODuZ0?=
 =?us-ascii?Q?bX9/A9gfb/lpkJGjg0WLFQGnemSZeViEBv2n/p1yQnGf7nlQ7e3RmoyEo4uS?=
 =?us-ascii?Q?omg/C/Zj7hLC2V8XsipUadwMEOORouZOK44AjatvJ/yedwLfKUfQySDal9zg?=
 =?us-ascii?Q?5/t6IVcjGvGKJ3cEFRubwC0wNqvhjF4t2MGqHKvNc/BY/U7NwcwWjEsGdbGb?=
 =?us-ascii?Q?O/kKP4pWZySSu/CCbzYUv6jfT/OykKiZUbPsPXIm8vf78MqbcHQFMe0ZHx1o?=
 =?us-ascii?Q?91KbHMYVj3lSdHrdkIJfVITdKW0AxOOPKIck+HWmW1J2su5KBKFBdIK1GmDC?=
 =?us-ascii?Q?xQz5yGOP4dfJUHHPbSKk03DaFMa0xqMFPdlCZPuPAVKBGqc4/zFgiFE6FIgF?=
 =?us-ascii?Q?nA3r+J11itOqqua8l8nYzXJL8vkvKHGQCyUN5zzrM97Eu4EkrOo5STAO1nLv?=
 =?us-ascii?Q?bYGn5OFZSTvjBw3CiTBCtB8JD664jfQ20WANv0BD+p/TmvIXJiqc25Inuvb4?=
 =?us-ascii?Q?l6WuEq3sc3cRVFVC1WrfNhea3xlmOeYOt19L/AxT/iuuTyDs7ueGbL9buLiI?=
 =?us-ascii?Q?KDsN2zUWqfvyNjE0Fd58Goyge8JOWzjdzZWKrlQN/VzutmAYkDzFzo+t4Z4G?=
 =?us-ascii?Q?Rr3u3VCvlQJ5ELd4DZEdL91QWJ781vrkPff81+5L8dtneY0aI9nrmr1LGxo1?=
 =?us-ascii?Q?DAosEo2vKWR/h7gI3Wm8PCPHpypJZ9LiD9Ipk9g4diSQlR8xCz6r1cJWGVAx?=
 =?us-ascii?Q?OQogL9HgDwZMRAA4Eqz0mMPDZa2evoB4cNaw/nXB4jgzSdvcgWkgibP/YM2N?=
 =?us-ascii?Q?IuhUXKSQ5j4+M4rtDf4rsK5GKbPciQMUkw40BHnokCbJDG+9ro7F6kzGN8sk?=
 =?us-ascii?Q?PyuAgVr/inbEvhVhgNUQ2yeSjhEqga4wULzM4+RthRrhi6w4BqYozcW+DMXO?=
 =?us-ascii?Q?TX+LSK18WMha+WkeSBg7JJhw4lnm/7/6siUtFh3jMJ8naDnNs1N1zAxk7qy5?=
 =?us-ascii?Q?qACXBs18UPoYgmGUbi8ToY9fnnjUFhV43tb6j/kV+JUOGFkWeI8og/SpaTK5?=
 =?us-ascii?Q?trYYvvM6bpCH15sUAaYwj/emb17jtDhiC2rtYltSe74HAMnzGYec79ovyhE+?=
 =?us-ascii?Q?+Q5gV5Sw2dFRxzne4t7XShfT0987KIsAfxFVd71T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e97d5156-9376-412b-f856-08dab7e02263
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 05:57:30.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isivTBKyBBlFPjsZlZ+HvE2QNRaVnKpaOI8ElXbbKRTTnNtn913EX9xxWSaxI996NNuMlB28B7EVQFfZE5bFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5435
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 26, 2022 at 10:36:32PM +0800, Waiman Long wrote:
> On 10/26/22 03:43, Feng Tang wrote:
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
> > Hi reviewers,
> >
> > For easy bisectable, I combined the cpuset change and mm change
> > in one patch, if you prefer to separate them, I can turn it into
> > 2 patches.
> >
> > Thanks,
> > Feng
> >
> >   include/linux/cpuset.h |  6 ++++++
> >   kernel/cgroup/cpuset.c | 29 +++++++++++++++++++++++++++++
> >   mm/vmscan.c            | 35 ++++++++++++++++++++++++++++++++---
> >   3 files changed, 67 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index d58e0476ee8e..6fcce2bd2631 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -178,6 +178,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
> >   	task_unlock(current);
> >   }
> >   
> > +extern void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> > +						nodemask_t *nmask);
> >   #else /* !CONFIG_CPUSETS */
> >   
> >   static inline bool cpusets_enabled(void) { return false; }
> > @@ -299,6 +301,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
> >   	return false;
> >   }
> >   
> > +static inline void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> > +						nodemask_t *nmask)
> > +{
> > +}
> >   #endif /* !CONFIG_CPUSETS */
> >   
> >   #endif /* _LINUX_CPUSET_H */
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 3ea2e836e93e..cbb118c0502f 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -3750,6 +3750,35 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
> >   	return mask;
> >   }
> >   
> > +/*
> > + * Retrieve the allowed memory nodemask for a cgroup.
> > + *
> > + * Set *nmask to cpuset's effective allowed nodemask for cgroup v2,
> > + * and NODE_MASK_ALL (means no constraint) for cgroup v1 where there
> > + * is no guaranteed association from a cgroup to a cpuset.
> > + */
> > +void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup, nodemask_t *nmask)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +	struct cpuset *cs;
> > +
> > +	if (!is_in_v2_mode()) {
> > +		*nmask = NODE_MASK_ALL;
> > +		return;
> > +	}
> 
> You are allowing all nodes to be used for cgroup v1. Is there a reason 
> why you ignore v1?
 
The use case for the API is, for a memory control group, user want to
get its associated cpuset controller's memory policy, so it tries
the memcg --> cgroup --> cpuset chain. IIUC, there is no a reliable
chain for cgroup v1, plus cgroup v2 is the default option for many
distros, the cgroup v1 is bypassed here.

> > +
> > +	rcu_read_lock();
> > +	css = cgroup_e_css(cgroup, &cpuset_cgrp_subsys);
> > +	if (css) {
> > +		css_get(css);
> > +		cs = css_cs(css);
> > +		*nmask = cs->effective_mems;
> > +		css_put(css);
> > +	}
> Since you are holding an RCU read lock and copying out the whole 
> nodemask, you probably don't need to do a css_get/css_put pair.

Thanks for the note!

Thanks,
Feng

> > +
> > +	rcu_read_unlock();
> > +}
> > +
> Cheers,
> 
> Longman
> 
