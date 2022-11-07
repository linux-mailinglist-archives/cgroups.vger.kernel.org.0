Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816A461EC94
	for <lists+cgroups@lfdr.de>; Mon,  7 Nov 2022 09:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiKGIJA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Nov 2022 03:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKGII7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Nov 2022 03:08:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C213E9E;
        Mon,  7 Nov 2022 00:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667808538; x=1699344538;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Sc/4SmMJODGAVdDTinFVOCgagW93gfpE74RU20Dl3ag=;
  b=Uuf+gTvcBjM8+UUczAvWAx5nkC7+E7DY2/XAmdfloxz/wVM7dEcykiTw
   mYwIXTVgtE7vL7CCtH+m4+ah4ecn3ZVpyJ70xbpAySGKo7/BbJ9szAuGm
   40N/MDOTSa7RaGbWySdilyPaAFKk1QXxLlcguqHhHgVPhD96GkbkjmDsD
   orcCtNr/CJNHlA/aQosWRJN+MSmDtWLpcRASn7Z8H1Kc2squnp1o3yf8e
   gdrm3kgBlu8qKtmRzhDBQO0K8rqV4xrak9MgbmxSXh7ZgyFowmSMni2zM
   y8oaRvEqwvwmnIuahdSLRRe5xNBu+oZWhMlZ25Ai93Oc67rtGspdVQ8zD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="290741415"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="290741415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 00:08:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="667086497"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="667086497"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2022 00:08:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 00:08:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 00:08:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 00:08:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1b08ppSCttBlIeeG/OWIdI58P4F/biOrb+Dy1nzLL8WpyUg7iO5GxgBvlS0pZM+yTWbPlkvOF/CEB3aNVUAtf3QEo+6yRRU63izuTFvkVF+kZ/qPELqYcZw8NyXMaNnbMsZme6lVDYHTB0fSDPc4j0yXSDHQLHD9OkfIzzzwQwgU8ZDi4HvbQEYL3nCF3hxu42tfT7PYQRJH1V0++nsTPWVj8FpSiLw0LIVSOQ9w5tL9QOcFNvmN21oBIjysn2dYqi9NZ61tgh58hkJb6OHy6TrB+RGMxN8C01m6Kerudu0a720SG20Ni64KcdXi0lgZd4x5nP1CVgsJ4BD6C2USA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntpbvadkmw+UjBGZU3n94Y8SRU50Gqvy7r5P1gqk91c=;
 b=Qu6LyG0hvPMR/0FmROjsRE750RxIoOVj2JWb104W/ZG7f9R7bVvNUZMjLW+6HxYe9N9AKM87i6K0GuvkdxDDozZUkCm4mAm4b6VTweMYOQNNLKdwxxp/Pv9pfMxN5w65iBlDvVzEGDQw/uu0nDIjfDGQRW2gZzrn2JVAX5j/QtZYf0QP6U9gHavSJAqkfIsJkISi/+jCkHPpAkvuBYlAktbn4eJRCEN5Whm6S3Qx/e0tKgmTsdDM0cx/ppy6tCtSAcElg9HIT0mBv1FuRiQZrcPYerwXtjk7zOo7Gslb8LNk8U26/72qK+OZkanyfCQWvSa2RY6WhZ8jvvNEgNNsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 08:08:55 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b%3]) with mapi id 15.20.5791.024; Mon, 7 Nov 2022
 08:08:55 +0000
Date:   Mon, 7 Nov 2022 16:05:37 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y2i8UbaOjGyqwJQ6@feng-clx>
References: <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
 <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
 <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz>
 <87bkpwkg24.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1+J7+1V1nJXF+3b@dhcp22.suse.cz>
 <Y1/XC+witPxFj04T@feng-clx>
 <Y1/cgrgdVP+KdYzf@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1/cgrgdVP+KdYzf@dhcp22.suse.cz>
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3ee87c-41b9-47d4-2c0b-08dac0975071
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYo34tqUDfDPxrIETDMK5W7e1y0C1VU/4PtJNvYZSt6+fMNdIg87LYZgXyUjqYehHySD7c/5mw/82g0NQiBB23TfAQoJW9HKQvSFpkHnhUUamf7xT6XBNEPngi1CfZO2L09DAyQZN3mwEoE48eozz5+0rFSB7nmzg8r1Wi3fzJwS1xhv4ckrZ/t/5TnKMxKs33tYRyE9mEwecJYRg33vXJGNU1xqDlwqCdDuOcbj0Np06Bwpr+JKR/UoK0TmbqdEayIyYVCQ8egcpsH7YJHYU8xIX1hAcV4O9WAZuAxD4pkV+EdG/C3AYbvNWafB9v20KAPnA8OlIv2DZ2FvIIBbIRa2wkiOC52URA8ubOuD84OyhyKFZiKeypAAU3SfWAkwFW4IWWlebjS0xUKwrot1Uc/cdHrNOXEphwStKexIt9aiUEtxkQt0ZL7FBbn4c8lmviNRrZWBMOB3HByvgpP5k31rqFW1jJ90jce5vH/KNZ6f1HQgEbZL/+c63Kfkrr1iP5V6/EC250uUr1ukPTiK7G55b6LSzpKHBT7JVLsXpPPlvIJjdAPJLmo7NZaOXhXZENgEumIuv1WGhXPBfj0Ar4kg7MFZAXecRMdw/zlVb7JXT3gU+BvtdM0ogb31cUzqTgIA/XILgkJCdSQ7FmvSbKf8noXlOd0kRirTk843qVVSBX0oRMc5S9yXByiLhNYJAgNfyP7/LVweBtOV/g64EmaYqOGv5jZskeSytJfS++QXiTt7A3HaJGudY3hvBIJIPKu+j8MUDT+bR8gdj241Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(6916009)(316002)(54906003)(44832011)(38100700002)(2906002)(82960400001)(41300700001)(66946007)(66476007)(5660300002)(66556008)(4326008)(8676002)(7416002)(8936002)(83380400001)(186003)(966005)(6486002)(478600001)(9686003)(6512007)(26005)(86362001)(6666004)(107886003)(6506007)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lDVXzRdKmM9ZbwlN6C5Fn/vdCGtYPH2jMgUFhokNx53RDFyN1+m/oei2VnXO?=
 =?us-ascii?Q?Sxn9kMgbdZ5lZijp4m/Ib7Y21Pd0PaPLsAjTbpn4bUSgK6Oc0aiaNse55DNt?=
 =?us-ascii?Q?3TDqGwKfK4HUR1OFqGxRiTc/A2icXI1hWvHj3rCVMf9/QvTuk3jeI/lW/+8L?=
 =?us-ascii?Q?lTLnxEhYvfwqZGeuG4p+DgAW+hiy5sWuD8YikV1hLzFQhO5SSfz15FiEkbUo?=
 =?us-ascii?Q?D7ArJC19MM/OG0JKxvey4nnlkAinEbDTZAL6m479KajLjiJJPMzY37KXIa91?=
 =?us-ascii?Q?I4Xw/E+0jSIPbsZE1uusrsEHkJAcIssIaexWu0EAj8bRN93rNgmPIq0sh8gD?=
 =?us-ascii?Q?cH8kcbaNkNLF6cyDgHMFI+mzXUscal14ges9KkGK0Qgqzp2e8TLPfWuUAd6P?=
 =?us-ascii?Q?/uDSl2r+EL5CP3rvKoN7V9vnPZVNwcBc8VBFdPi7VxyHPPInH6lGqK5V27Cb?=
 =?us-ascii?Q?Omh2iI3fhtN52gfZg58k9rHzmzUEpBAHniL6HHQ68f23bdxwxpUYtGMeuJ16?=
 =?us-ascii?Q?USrmMCpxs7C9JW9eB5Ja+7Zo/JzHIn5VvtCvjY0NApMPKUo8hSuNhdy9VK8R?=
 =?us-ascii?Q?cRBJi1uw/2330gDZR1eTSEDBXTgbwMZ8zlZsR9Y4ldfiu+GJV+xKAN1hdk4/?=
 =?us-ascii?Q?R83eoYdgaHNSodr5EkhO+NGCCpWxDNgRV8aUDeBH9dYxJauiFPBAGmRAZhhb?=
 =?us-ascii?Q?hSNxhkmkrxQHhBaLmbQ1l71J28ZNlF7NyLi56LCUhDuWPzqw3xeM6MUoRaik?=
 =?us-ascii?Q?c18t/YOtjnJnY16EyLUYPJkrEKvrwB5jJs3sJ9I3CJmjrj8Oaj3RvGYFHnep?=
 =?us-ascii?Q?9yiS93hs+w04Zcag93hjBNqgwSIwE8aoQVxoWbNYOTkaTzayMBabriO/5Rgk?=
 =?us-ascii?Q?5yYhfLdN3awsJVQEQU2DLl6SeZaWR2P1HJuMLRJh/5eo1xcRWookko0xpt3O?=
 =?us-ascii?Q?9vKJEuxVKyxG+A3/cvESIgxv/0Cww68mNXIL/ykz7prpaaM68eGOzOvL+6Qa?=
 =?us-ascii?Q?jKeha6CT6bNna9veihGhJlVr+OUuIzSPo/C6BhWx0q/54IWp6cDssgfQuFUE?=
 =?us-ascii?Q?KeVWn0kSbF/x7BDdIZU/B1vJX2lRuBGDxZcvVJZmoaCfXONgBhso7RcK2Hsn?=
 =?us-ascii?Q?+b9dIwEMK/bYZYN7LdxppP7C8L5E4ByudYKo0DKALN+NHP/7xykVTd/QIOOx?=
 =?us-ascii?Q?GMDLJZ8ax3RwnlhLQgndTYhjarXTPway7jbuKANndaeh2D+bbtC9/FOhYdGb?=
 =?us-ascii?Q?34hf9eHgBLL/eEBgh9IRdltwaxyNj7D3fdnzg3NMCC/jxFh0DE6Urm467s1Y?=
 =?us-ascii?Q?x3bNKDD4mZ4arFZLfR5eoQOmXNrvUnuBilx/JIvE6HMifrfc+Qxm5tNElfua?=
 =?us-ascii?Q?Ah/1BzjYJODcjNvRP5Kwl5CTkYa3rZILENezmDeVBlAkIKtZCKiAZwscm19I?=
 =?us-ascii?Q?KqwDnnIzrTYwk1VJMEuOhkq9oljKvf1A/scXVaY+GoT1If9yoeo6DxKhEUQ/?=
 =?us-ascii?Q?6ZYeude9BnHPEpJj9ouf0nV8d/HPT3hyPIYBwnu5GsTsIodfuDVr6IvvpEg9?=
 =?us-ascii?Q?WDZWnfn8tyxBoDJc1SmTzp1CqvpvzKWjNqMo15Zo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3ee87c-41b9-47d4-2c0b-08dac0975071
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 08:08:55.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VdIcJghSfnFXY6ma87f67ufaGIo2FFB616nxIm/2UobPojI1WEQ68jIN2NkdbHpoo4y/3PvALH38tVW3EabSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 31, 2022 at 03:32:34PM +0100, Michal Hocko wrote:
> > > OK, then let's stop any complicated solution right here then. Let's
> > > start simple with a per-mm flag to disable demotion of an address space.
> > > Should there ever be a real demand for a more fine grained solution
> > > let's go further but I do not think we want a half baked solution
> > > without real usecases.
> > 
> > Yes, the concern about the high cost for mempolicy from you and Yang is
> > valid. 
> > 
> > How about the cpuset part?
> 
> Cpusets fall into the same bucket as per task mempolicies wrt costs. Geting a
> cpuset requires knowing all tasks associated with a page. Or am I just
> missing any magic? And no memcg->cpuset association is not a proper
> solution at all.

No, you are not missing anything. It's really difficult to find a
solution for all holes. And the patch is actually a best-efforts
approach, trying to cover cgroup v2 + memory controller enabled case,
which we think is a common user case for newer platforms with tiering
memory.
 
> > We've got bug reports from different channels
> > about using cpuset+docker to control meomry placement in memory tiering
> > system, leading to 2 commits solving them:
> > 
> > 2685027fca38 ("cgroup/cpuset: Remove cpus_allowed/mems_allowed setup in
> > cpuset_init_smp()") 
> > https://lore.kernel.org/all/20220419020958.40419-1-feng.tang@intel.com/
> > 
> > 8ca1b5a49885 ("mm/page_alloc: detect allocation forbidden by cpuset and
> > bail out early")
> > https://lore.kernel.org/all/1632481657-68112-1-git-send-email-feng.tang@intel.com/
> > 
> > >From these bug reports, I think it's reasonable to say there are quite
> > some real world users using cpuset+docker+memory-tiering-system.
> 
> I don't think anybody is questioning existence of those usecases. The
> primary question is whether any of them really require any non-trivial
> (read nodemask aware) demotion policies. In other words do we know of
> cpuset policy setups where demotion fallbacks are (partially) excluded?

For cpuset numa memory binding, there are possible usercases:

* User wants cpuset to bind some important containers to faster
  memory tiers for better latency/performance (where simply disabling
  demotion should work, like your per-mm flag solution)

* User wants to bind to a set of physically closer nodes (like faster
  CPU+DRAM node and slower PMEM node). With initial demotion code,
  our HW will have 1:1 demotion/promotion pair for one DRAM node and
  its closer PMEM node, and user's binding can work fine. And there
  are many other types of memory tiering system from other vendors,
  like many CPU-less DRAM nodes in system, and Aneesh's patchset[1]
  created a more general tiering interface, where IIUC each tier has
  a nodemask, and an upper tier can demote to the whole lower tier,
  where the demotion path is N:N mapping. And for this, fine-tuning
  cpuset nodes binding needs this handling.

[1]. https://lore.kernel.org/lkml/20220818131042.113280-1-aneesh.kumar@linux.ibm.com/

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
