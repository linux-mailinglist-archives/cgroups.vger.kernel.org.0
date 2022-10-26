Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E060DCAF
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiJZIAc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJZIAb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 04:00:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB2543176;
        Wed, 26 Oct 2022 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666771230; x=1698307230;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ekxMYdeASdyQHgs8vqRYA2eL9dBearRTLTiGUWM3A6g=;
  b=TxV3QIOnhkk07JW6hn6qadSaweG0TSpZr93y3R00ftxj6Y2NLEn6ljQM
   vuJmccrAUFjQcdm8R32OSI310HPjW5pVV/diacpnDiB1Pk+U2FIzItlU/
   PITy55u37e46rFrP+CfRBY2vTyMz9ld9VXU3duIK3vxDYIk71FKmYh9zP
   KJAqNQAmc6kGR8xGT9rMYzYNWQ12BrO1L8u/Kged5TNgHZ2nxwbMIJMyz
   WWxmkVR8PY20fSrQ3rZpECzYwRW3HPOtoct6u9vn9Dg62hA1IDSHQ8MyD
   Y1XceRbpumaDY1ZXIErXHd0Q+fC3kYj7QXVLp8HJU9TyubS4nojKM/ukh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="305501040"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="305501040"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 01:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="877102274"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="877102274"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 26 Oct 2022 01:00:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 01:00:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 01:00:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 01:00:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 01:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HseajafTN0uzUys5q8lcfYggjlOpPDHuT54fNd6XU0PR1bvBa9od2viMo3M9RgtAn4+2p/71L3BKyAA157BCHPtblrXD6BQtncX2ixVpZXk3gZ4MXMcQpIvHasMcEAbARH4zCYbNbtEpgtIuH7XkxN+KVtCOBtpJgzoxceNxJS5ulYMnc8Y6XmFULF7jYKBpdZ22kQBhHm69hrJhayaJJDYuF63U9FOngWscLU5mo6q93amX8XVgr8SYgJvBdOUgl9lXd3VLpq0wbp1uhBZNOnrGdAZEfb9Fkt/mXMufGwf6Cd+1aMhXu2EnpjYPHc+d4GC+/9gapAiVSinSuAHmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXXMXwNvD9RcMR3AM0PYx7f6a+nGW6eKhPrISp0DXmQ=;
 b=PCzaiv42cE14AXZQzxcWNAcnSXRj7ns8LHToPjE7FbMnrKLFaVNYSfNDXmKMP4lqTe2v02aC5sYvuLsQIUud1dT3XupYO96+Ed8MapUroZUc+C1eR/peuKq3NiPM1BcDMscm0cqxI+b/Pp+XuZeVLTduT1j9S740lGWz99QX1+6qaVDQsR5vzjkegpcjgRgF1gawx1pqIb8AT5VsprWi4wSfLR5zxl52wZwVDO6Rr9nbFSRqggaAmrl0C7D8KMRCtkeMbtysOTslAo8Jqq0J7rnhT9vHlgLqcey1AtTsErk2zpOKg2RzzKWQugGthOTLe71i7jBniaO/+ghn14xB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 08:00:24 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Wed, 26 Oct 2022
 08:00:24 +0000
Date:   Wed, 26 Oct 2022 16:00:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hocko, Michal" <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y1jpDfwBQId3GkJC@feng-clx>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH0PR11MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 918417b0-e5af-4ab0-ae87-08dab7282340
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxw8pwsVasH2lFeQaHCxV5AdfahVd+4QMW7tQyqKpCzpdR4KPvNdLWeMFbxXTImA3XHDre4DlHsjG/SkWhQYOeJqjLbMjPV8C8OCQiiv5pYB80nV/uWq4tOAP8LgQdN2d0fHSIlEm0s5xBJISSZ+2DhljRdmcNeGns0ndf4VC6WjVw+XwAgHxSmSkKlN7NJcjRrAckAaMFp25aB7qgHMO898F2n40/KbIEti/+0M+9ec54/F7MO1q8FNU+7pyCr4bnWRpdrTrQxkVsG4cUyirM6c8BS2szwup/kk0PHhADvCqhVre/6Njba1praDCvTP722VeEh5pqlmj0VKOSFxYPZHK+CqvNjvCKcpH5EOePS+joXucsgK9sNOJtz5YlQ0C9S/Ja+1hpUMvYs/YrBcT6ASVfxtWISCdYiGOjhNEkfCZMDz3qiTJTXSMasXq+QQLRwNdhSn9Oa6EmuXje4Zd9Ygd7H2tIZR799uxSa0W+jrpByPQN5B5DdbN7P4+Z2MwmGF4GxQR4cwPTqnAwHOgiFM55Imrjr9epgAptfiy2qDwARGkDBLrZgbQSlVXxKQrr407Klb3EclUzuG43+egw1uc2WuXBFBkZBTqYSOQPHSTlThER8RPCxW40Hj7ut8Lkrr4VTg5XCPi9KTjELeFLr2ZlfIVETqi4Fgww1PNnUCnYD9rvjsADP3eUW51sk4HKBrn6hN4gWVFx2T9G3xYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(6512007)(53546011)(9686003)(26005)(6666004)(107886003)(478600001)(186003)(44832011)(6506007)(2906002)(54906003)(33716001)(4744005)(316002)(66476007)(66946007)(7416002)(8936002)(5660300002)(8676002)(66556008)(6916009)(4326008)(41300700001)(6486002)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DdaApELdfEJ/5r1JPtJ0uJK3Aru8ObMVQhnkM4G8Sy9qGN2rrZBwCZytiwc6?=
 =?us-ascii?Q?6YwkSExUAqZkYo3AMzIJGKCm4pzfPPe0k7eG9g9ZQWxyxpHzzhKXOeMD20lR?=
 =?us-ascii?Q?Ercw2HtWJG/cZTkmSRzIRkuz5YbWUhXT2QJ72WDVi0wRS9EguuBuJ1bGiof2?=
 =?us-ascii?Q?4I/J5OVeo2+Oi4Tf4YUuqYACCfpgWMMPJv34MY4vUFyRgr+TB9NJAb4UAQxG?=
 =?us-ascii?Q?zHpmdtm3JG4/ZgRAeabxc2nccpP7bTJFO1pCa1Kb7UyDfMwr76w0WdcAMYzm?=
 =?us-ascii?Q?ky4aq/0Y0dEchAAxNr3H7T4U1F12d8lZKypO3RJUWO8aBwYJQpgoRBD0O1sT?=
 =?us-ascii?Q?RrlUU4P7heV2h5u85+CxKfomlZm0+ukd/2kKcvVMqSNToWq9cySEzUKURZEW?=
 =?us-ascii?Q?s1b7K5EQcF5I0Du5U6T8L9wSjMuspgphba1mzbkTuZll9OTUw1DpVcPdshGr?=
 =?us-ascii?Q?QmSDRasbY9kxre6HgchHlDLTnOaITU5dpar0Jc/gRTifTEQuF7wV38l832Oz?=
 =?us-ascii?Q?jI10cpi1b2Gb/fUyUVA3SdqDPQB6S6W5ZBpNrAmXCfUwRzPZD6ZSNvpmrjsc?=
 =?us-ascii?Q?T0DORkyCKFgUx+5u1JyebmCeYMFFRksfXdGc/zgYV+xItZtLI+SiwtGbxsSv?=
 =?us-ascii?Q?dPDj0Bo3FkqTtq9R6BdRCQ3OayEAUItG5Q2/qCS5gR16UTEskrk/hZfyhs/v?=
 =?us-ascii?Q?ElvjJ+BZr65SZmnOrgQaHYaya36rXeTgACQDb5HNhaKKJkn/QA/cFbJNnvZT?=
 =?us-ascii?Q?splOQzWHmnhj3ZiL0o/oFZNBjGAKeS5DvvydOjh3ISh/+WJmPGmkqQ7kq3it?=
 =?us-ascii?Q?LpudKNjoPzPpilKG/6j3Y/MdcgLPY7m++YRvA8nXQ1/fFh9HJQGwwiwN7XOX?=
 =?us-ascii?Q?0k03Ebzpia+QwyPvO3aehLkwaE8WjPFFZDeDz73VHL2aiPSktngY2T4cVfQe?=
 =?us-ascii?Q?gzedyGSOBIUpSM3pqDtyd9jFc95MhFqDWz5TCWcKjn054qswv5xkqQMK6tCQ?=
 =?us-ascii?Q?b+AcFzEzxcF3n7rcdNKcQeJlZ65ZNia+pviVL8LJDc18D4y5BhH7ZFu2jPaE?=
 =?us-ascii?Q?9OsTvpTD9LGXV7hG8SZYUNyNuANR+2FII/NDYhipOmwKJCR8RLeC9IcIqcEn?=
 =?us-ascii?Q?JmxrSyZTIzhjC722DjHl/0AirOdRTNHZB0BAkjr1iB+yPITvIyTjNgEETHlw?=
 =?us-ascii?Q?ZB3UXkl1mirRP67b8+f6g0gUFz2+lucTSc5qHKdnWoGFMhIc3PSTl1tan1LZ?=
 =?us-ascii?Q?daKLwu2EuDZzBOKKIeKUVk0pTghKKNRRamrWtF5fo7lqgEtBpIbBfA5BH/TX?=
 =?us-ascii?Q?SOcNU1zzgvdb7ILb9pWcK2e9mGNPv+9fWR85TrgfKN2t29rwREio8G2RLesC?=
 =?us-ascii?Q?7KaucQtzJ6vfulcCKSJ+LEM6bqieqdGifsafgoBlImnqQH9vqL1bULbP03z5?=
 =?us-ascii?Q?FLbP9EY3wGILikLHA8tfUwAV1VU6BcClFIf7VbsDHenWDF3vZautVCuhNfff?=
 =?us-ascii?Q?QtKgrbPUe3CWcSBNc8OmEfUW+nobHqjG20ElDN+7u0hXQvZtKQ7oXgOUBazo?=
 =?us-ascii?Q?cJW7eW8499V89anrLS9s6VYpRKMRjDrTxzBqMoJV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 918417b0-e5af-4ab0-ae87-08dab7282340
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:00:24.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzV3lum1mKtlB5ef3Jib6iIPNlS+HtQO1FA6dGeyzWDRik3MYl+kZz2dlyvDXGs6NvYQvDE2yBKwV0HZ1G/4Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
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

On Wed, Oct 26, 2022 at 03:49:48PM +0800, Aneesh Kumar K V wrote:
> On 10/26/22 1:13 PM, Feng Tang wrote:
> > In page reclaim path, memory could be demoted from faster memory tier
> > to slower memory tier. Currently, there is no check about cpuset's
> > memory policy, that even if the target demotion node is not allowd
> > by cpuset, the demotion will still happen, which breaks the cpuset
> > semantics.
> > 
> > So add cpuset policy check in the demotion path and skip demotion
> > if the demotion targets are not allowed by cpuset.
> > 
> 
> What about the vma policy or the task memory policy? Shouldn't we respect
> those memory policy restrictions while demoting the page? 
 
Good question! We have some basic patches to consider memory policy
in demotion path too, which are still under test, and will be posted
soon. And the basic idea is similar to this patch.

Thanks,
Feng

> -aneesh
