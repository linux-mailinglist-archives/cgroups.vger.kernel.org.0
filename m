Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBADD60DD26
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 10:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiJZIhh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiJZIhg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 04:37:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18F9B7F6C;
        Wed, 26 Oct 2022 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666773454; x=1698309454;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fhNQwmgFxrWhlHo0MKDtd/alGUXXIYpmPZkfj6NbB7o=;
  b=eOfuRe22l1mmeS+eCLBN2f33IoJD62uUlPaHS46vMMW+WXagYhXbbgNy
   nf2vC9IjJ3RipqgjomyMtq9wBPtAGTnu/8vxs/IzAMu8Gxsnx40D2F+DC
   2BS0kL1NMj/EY3AXTR4cAFBVKAvT6uCNJdGImQIjse2L9WXJ9QBPtotnJ
   /hOCf+irhrq2Ys5EU2u13stqfx60kyXJKlK+Z0/J992qfvfCi2ntfzfsZ
   NsIMhtPumMq+KG1cRN74H5dJk7qUL1S9Wu9NDF2PWXHyI1ciB4T02wtN8
   OUaGR0/NHz4UxCkPZYjWRqHYosGYxFW3d5Uzx5GSlmIdGr+SCsmPCYdsr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="307888581"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="307888581"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 01:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="609875155"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="609875155"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 26 Oct 2022 01:37:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 01:37:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 01:37:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 01:37:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3Fz6FaOZCHspr6NZTerS0+o0vhbmTTYPBtoiElb1GxOwh+7vLds++7SNxLQvKftpIjYAaofrwl72E5wiz43tbi9UtcSdHFrMAbir8W+oIR1SrbHq1FRaK0V87JCeniUw0Jb9XyYgkspWbNDMgcQH8JnvTVHmYAZtQD7GIFj+oa80pCQAqXk/VctUt4/6JWj8NK4+dVcgNm4wnnNmj+ccyski2tzoRvMJL6lLWbFjPll316k3qa3wXnJaMlc7kpF671GVtxhiB4fOFwSKIYsN1MWRIn/xZEaRsMjzfvhnYr5QZuvsaMsmBGABjdcyRblmB1zVYCYHno80vCOTpwgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nJ445yd1L16ddW+cQQS7CkrJn78mJUCUyuBPbPOPNk=;
 b=RI+rezZCYoWT3XpCSPGfnCXXTyT9ir4wHIj+XQAREJ3ChCrSyEpUvJNDcgEwj+3g05/2hDGXEQGG2lb+sp2eKx9kHJQTd7KpcFYgGJxjwwEFOT3ii2U3clyBVtoiAyDH0rESLNiqv1lglsZKlwKqMY/DqxaIfON9YCLlEGsr4HWLmQ20HBqlKf3Pfb1/d9sOBrZFJTtNwP4o8jxtLY5gU8ypWyxq0bXP5PG7WFyiBa1Fvby5ecWyk+U8AMp/fG7uWCvA9JdNI4rFW3RY+RFzIz6MgTcIM88+HJJ/5XWNwl4OZ5CI1jr5kM2vwZu5Va70jl4JgXqgP77Nh1SdPSmKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5679.namprd11.prod.outlook.com (2603:10b6:a03:303::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 08:37:14 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Wed, 26 Oct 2022
 08:37:13 +0000
Date:   Wed, 26 Oct 2022 16:37:02 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hocko, Michal" <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y1jxrv5/4PxrEt+F@feng-clx>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <22f86189-76fa-61ab-4e80-9c2740ec8e8a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <22f86189-76fa-61ab-4e80-9c2740ec8e8a@intel.com>
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a80dbdc-22c5-4038-61a6-08dab72d47e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEbNX3NtCTGyhYZCxJNi+R2sRDYV/e2bL+GMbWHtytJDegUy6DfCOMIpXio+/qCdN4Sa4Tjmb/DYdSxreEZBsvhGz+Jrjj0aSBAnIzaDLuX7nv/LxUTP59NJaTNHhonSK6ut7QlDBQhn4/Spk38XvY764+uF6tqN56vu+BtGMLpQNXLeBHTQ7B/OPV0mcmU9efXl7FzTP4q2H6nK2VOq3EAduXdfKkd7fsJzKti2y7kNfJSw31RAhfa4ItoYaYEc9dtommFn4QKz+ywPsluduF38ufOHVOtz76jbvwRIp5O44qqmk2WGdGkpIm9osXHug0+104NGiSGRkCFxlTXzsK9PfMt4lHX8mi0jzqzc3VCOElOAeSXTTADlulyDnsSl87N21o0qDkprm6Hk80TB4kRgMdsgihQmrD35SPo2TSnrrO8QKSeatdswfc4T2dm/2IOofN7lbGy2VTaWdOfEaiBIAeGiBYZdkTSH/txsAjIUoTmibdtjXerHYWvTQD3I7hqEtJD73KawLuUudfFlbT3s9Tw3hs/O4hMd10kgIXDLb2A96cmx9a81NhL4f4YdzRKMCYChgb8ze2pEJ7VTECnsNRH/0psi051p/3X833KkK7x3NdIQS5rwCV9wsgkB36/qQH0XDCeWECDZ0L9UD+BZen4rsuCNFd7wF8j45X6ijFZgD/QKq1u8dsQvK+lGhcENMtdFoJzqiTF3r/R/cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(33716001)(7416002)(44832011)(2906002)(38100700002)(41300700001)(8936002)(66556008)(6636002)(6862004)(5660300002)(8676002)(66946007)(66476007)(4326008)(316002)(54906003)(83380400001)(9686003)(6512007)(26005)(53546011)(478600001)(107886003)(6506007)(6666004)(82960400001)(186003)(6486002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rY53g+eQ+nDiMs7T7SVNWAXnjSqn97WbQzidruaR0Kq8133io6mbd1j8Gyx+?=
 =?us-ascii?Q?NM6PmQ1K98kpIROcr6MJqlChvk9qPJLNVk9JY4yhBrgMZHBJ0p1QVdo1KgL0?=
 =?us-ascii?Q?ji4zPjDpgdJ7N59tIXbMOxZbW7O68rtc8qV7EvB+YBZDpA86SyNEgYFoshot?=
 =?us-ascii?Q?N9UJbGAFoThGQ0Dh7zcITeje9ZENXyWCX6FH2iBpxt8KsgMN+KCtFCeVcXhd?=
 =?us-ascii?Q?ds1RmDbxDabW+M5G/SW2fm2qxisSntAYAxbghG7gPR0jIzNKlU5+OEKOKBrB?=
 =?us-ascii?Q?UUnt+TFxCI7ss00/CYF+iYwSTCNzPF/l5F82lkIW0i6C5Ox7SFPFon+v9myc?=
 =?us-ascii?Q?mkBSzOHAyV2j2fc8np8N5Pb30TzFqoWryQFt8lD6qXgflzNsYGWHjUXpX2vB?=
 =?us-ascii?Q?Z2tFqQ1qGdlx0LIa63iztl3rqh+0de6Ihi8B8lUjWXHUZtE9c1Pj6zmj+eu6?=
 =?us-ascii?Q?h5tDKDYqdE3cMdA/irydGSv4lb5Zz/JbE0MQQN+NxfWPNrsKoTJ1RcjqwcD7?=
 =?us-ascii?Q?JqXWKePfqfttXM98Oo8EF7V99zVU3JThTAM87purKiV4Ny2TxZYDXJcP4T2T?=
 =?us-ascii?Q?TSZNmSF2Vr7AKta2VP1m06ceDhm+iJJDTzn/ZTGztY89WL/IehmBQr94s036?=
 =?us-ascii?Q?XoeCTU+B3Rf4KVeWuS9Xbokdx156RaxCrThFNITkJZ7WG08HQFSNvSEPL5Kn?=
 =?us-ascii?Q?WegR8607ILo4rCSHuWaq8VyZptg0R+Klrxnafp5EuUbNGn1IM4wZ9AGCUWvb?=
 =?us-ascii?Q?MCTKmGXMpoundWbYvVCsXwIaLspux/86qY8M4YgUQ9ORjzKwyHEyORim8l53?=
 =?us-ascii?Q?gKtcjUb7FqaQEXgJTvEgcZbqg/QjH+G8gAGKnEIEDKWohPEJ7k2glMJ46h4U?=
 =?us-ascii?Q?cQT9htQgUn+7xH80M2E9I0PjdJ4LbaTA668uhvwjA3j63yPrK6jjTxw9PNUm?=
 =?us-ascii?Q?OuX5BfS8TjT8xcfUSce2Mq6iIosgl+5EpLzIZzATLJLwYlLtVFvxjjsR075R?=
 =?us-ascii?Q?kMjl3t4GTRHgxDom6u1HTOpqRJj/xRpTR7RVjezFra+lY59X5ppOE8Hg7nOM?=
 =?us-ascii?Q?ypAlKrP6dpoOk690SyRzKnyCJ2oLfcl2+GQJWv03UIHWQRLHIpHSfG10iqM3?=
 =?us-ascii?Q?dfGn3m7mHddc0I9rHXJs6XMAOAvhxZitRWTquntAfucjmn7h0b7YjtyRGIG7?=
 =?us-ascii?Q?R34Ajyg7uiPGAlZ7c1VMjzBG5B1T08mlyq3orpISP8oPxF16xDFxZJU+tc2f?=
 =?us-ascii?Q?vcpGHVwcdST/3Rd1DU3MP8k1dcOid/WTYL5pjb2bDCI8ckwYvUPKR6e/Dedx?=
 =?us-ascii?Q?AgngbChHJDHsrYnt3iMd7r9orUX4AzIkAB6iKteXXMXrxnOqDylLMKuo4+I4?=
 =?us-ascii?Q?d+ULm+pqn75wyYkACoyzt2QlKDc5CYNXpMScIsaV70+J1amrl+0YhhCCqAxI?=
 =?us-ascii?Q?kcH/J2uTqQkx6vITXSIb3Yph6PMCY1lB7WJz/o7wA9+quyUFWJySWtFa7crJ?=
 =?us-ascii?Q?2PbiAG+CvjQZ6sluoZk7YbqAKC+vCl6ezSGigs1AprEi/MPMvVi4oPYqdKz8?=
 =?us-ascii?Q?eqJQGBUyRoBjrOhJnVQHEsojO4hw8c5W3zhvJ8kj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a80dbdc-22c5-4038-61a6-08dab72d47e6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:37:13.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6wdwkAzEiFPQN4WtOr0FuQqUyxDb+X302VrnkDoKOPR8OPWMrU5FhT2KFgWuqV/+KKt1iW0au6j1To/FhKogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 26, 2022 at 04:26:28PM +0800, Yin, Fengwei wrote:
> Hi Feng,
> 
> On 10/26/2022 3:43 PM, Feng Tang wrote:
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
> >  include/linux/cpuset.h |  6 ++++++
> >  kernel/cgroup/cpuset.c | 29 +++++++++++++++++++++++++++++
> >  mm/vmscan.c            | 35 ++++++++++++++++++++++++++++++++---
> >  3 files changed, 67 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index d58e0476ee8e..6fcce2bd2631 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -178,6 +178,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
> >  	task_unlock(current);
> >  }
> >  
> > +extern void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> > +						nodemask_t *nmask);
> >  #else /* !CONFIG_CPUSETS */
> >  
> >  static inline bool cpusets_enabled(void) { return false; }
> > @@ -299,6 +301,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
> >  	return false;
> >  }
> >  
> > +static inline void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> > +						nodemask_t *nmask)
> > +{
> > +}
> >  #endif /* !CONFIG_CPUSETS */
> >  
> >  #endif /* _LINUX_CPUSET_H */
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 3ea2e836e93e..cbb118c0502f 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -3750,6 +3750,35 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
> >  	return mask;
> >  }
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
> > +
> > +	rcu_read_lock();
> > +	css = cgroup_e_css(cgroup, &cpuset_cgrp_subsys);
> > +	if (css) {
> > +		css_get(css);
> > +		cs = css_cs(css);
> > +		*nmask = cs->effective_mems;
> > +		css_put(css);
> > +	}
> > +
> > +	rcu_read_unlock();
> > +}
> > +
> >  /**
> >   * cpuset_nodemask_valid_mems_allowed - check nodemask vs. current mems_allowed
> >   * @nodemask: the nodemask to be checked
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
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
> > +			memcg = folio_memcg(folio);
> > +			if (memcg)
> Doesn't check memcg in the change to alloc_demote_page(). What's the difference here?
> 
> > +				cpuset_get_allowed_mem_nodes(memcg->css.cgroup,
> > +								&nmask1);
> > +
> > +			if (!nodes_intersects(nmask, nmask1))
> If memcg is NULL, nmask1 will have an uninitialized value. Thanks.
 
Good catch! Yes, it should be initialized to NODE_MASK_ALL.

Actually I was not sure if I need to check 'memcg == NULL' case, while
I was under the impression that for page on LRU list, it's memcg is
either a specific memcg or the 'root_mem_cgroup'. I will double
check that.

Thanks,
Feng

> Regards
> Yin, Fengwei
> 
> > +				skip_this_demotion = true;
> > +		}
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
