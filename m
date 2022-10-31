Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC286138C0
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 15:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiJaOJx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJaOJw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 10:09:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7751056E;
        Mon, 31 Oct 2022 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667225388; x=1698761388;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TTF9pvuSA4wR17Q7wTPTvuXU+LnqoHqiUaB2Zn6irYE=;
  b=I4p+nPoAbJX+XF49fxZN3j/gdvtPH2sl8e/ebzTu9IvIuJW409Xm8O0c
   L5lo43mHFws9z8LXdHr/Cj8NIFvAY1e2QjeVGFlR/c2roV6nKkbbBTRpN
   FiuWK64hcK1LBcbZBKUIUA3p090t15OB17niZSrxOyBJWDzMF4a08hmX6
   uuRGHOjh9I/bIyirey5RW2b1b8CJ+qdBqHFxMl0hEB5spEnLO3FXBQTtD
   6tGNJL0nj2cnWSD4vz+SKeEBvPeOaJh6lhp6GueTuw7xI5t96YbaOpJDM
   b82xyxcyHaN4P5TQD/G4ubvDt9pckC0+QrFbRUPz5do4VXq5tq26cwmed
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="335563386"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="335563386"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 07:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="962788140"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="962788140"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 31 Oct 2022 07:09:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 07:09:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 07:09:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 07:09:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyabbBsuY1jj8hvhm77q8zg5nCfD6FmaObzIlmPd5Cpu25KzNiOR/YILuhhf3L/BeOp7dCXtLPha4Cb0w5aZicmnoxWh/IkHk0bmssDzIGK8Ae374gHo06tmKNzUp6/Cb6Yy4ZoFM++vQSFw84IDrpfc2ci9uPHur4oxR9vyF9uCGcMEdaIEkT0BVvelSU1rr3iKQxH/YWM4Vj8m3n11v4haF+D2JbS1HFBAo6VIuCm+OWJQfjoSzeHp8mIe8BPNH0z8ONiBkBLoOllDgwXrnW2Slo4r825J+V0KKAbB9/kcHXatyIBQ4POEJC6Q88vNQ77T0wGFzQ6LlRUk4xuu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37/o52NF4t+fjxh9p28vsTLrPLr4kWmpeT+Lp2q7KLw=;
 b=iWTW83WhOpZkP+ClhdwW7vhaK05ry1WFu26f5hzhDQ8uVjSqZb33T9Y6zzAg/v7EN2rHH0hNwGuz8Rpfc4N1qKtWXm9szs+/Y4MQr19XYLTLFeIOCb62E78eFObmwh9r8R4dg6JeVx1+NcZmROuxkvJsshV1OUYST+1YRaTGSWayluGIOgP6JllK95/23gOC7aQF5d1sOuc4jsg7qC0xfmssY+pyQjx4uvrXIghemiGDE+/rz04ur09O8eRi7rwSfv7TjjdnX01lR22dO14k3DADUv52CxWnPzGyI3wp5YGG4J9IY+5zod4ZU9pPldiyQ6ONa6/MK/lM1+JG/YSBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6308.namprd11.prod.outlook.com (2603:10b6:930:20::8)
 by MW4PR11MB5800.namprd11.prod.outlook.com (2603:10b6:303:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 14:09:30 +0000
Received: from CY5PR11MB6308.namprd11.prod.outlook.com
 ([fe80::714c:d1b1:fa93:7d74]) by CY5PR11MB6308.namprd11.prod.outlook.com
 ([fe80::714c:d1b1:fa93:7d74%7]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 14:09:30 +0000
Date:   Mon, 31 Oct 2022 22:09:15 +0800
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
Message-ID: <Y1/XC+witPxFj04T@feng-clx>
References: <Y1kl8VbPE0RYdyEB@feng-clx>
 <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
 <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
 <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz>
 <87bkpwkg24.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1+J7+1V1nJXF+3b@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1+J7+1V1nJXF+3b@dhcp22.suse.cz>
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To CY5PR11MB6308.namprd11.prod.outlook.com
 (2603:10b6:930:20::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6308:EE_|MW4PR11MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc2b8e0-0a2a-4cd5-eae2-08dabb498743
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oj8UpDhKW0tqhJCtTZafsqeq9tJw0DfAl5Rus5DbtTH638/m8RWBTtdiajwb4NqD6xEvksQoJsYqCiV/t2qWDiY+GsWuwDt00hA/8pWm39ZZ97YjLgfPRyju2D8s7A04CaNiVU4qXb03Bzge9kUQyeTdb8Z4Nj+TgsfRZt9ANhNx3mni+n0KqrrIA3z0qxTmLvczy8lJm2Q9XrLiSrMAHMtklOJWpLIjY3Xu1Sk3E4glg0RdRzkK9iVPwRe3VBgoZw9LAXgpA/W0QrtSoV98FMtVTUOwAd88mkkVkmmXmArPKbgf/TemVHPx1rIk2Jy9kfDgkShpUPf7xMLl/FFwgOWGdpLxQDFRf7LHZqFI+DtOo5IOUfLDy0ZDcNfimtKY8Ubw+evdFkAwDO3/Wr2cOoPNaWj99+CVILPNQanbB7mtQmzAqouckqvEoVGgQGTLID2hfjn+yy9N0tJTjy099SV7/3fkOgHVdsoC7KfCB/wy2i62nSSfKcGL6aRZBi4qEI1JT9LVWHm+DAO+sJhmEgOKjyUse1LxVx7sHeqPpaFu6UVTOkoEwGrCwGu+XJJm2yQyPIlzbUEMSg7TPLBPElTrgwx/98Zzwyy3k5S3HaH9KRpnc7X9D5VMYN6kkRIJFPySkLXt35gPX7x361HHC5q42oheplWmFFCk7nzpWmej4mhXri10hjpr+GkEoSTS7xEdtI5/6MV29iWroqkQG3sak5mS8yXRHrnxI0ddgaeDQ1+SuAsW2JQsl8RuUF4a7ITsQMVr8hsOqezJywwjFgvfCnmDLBDm7Sv1d0WxAcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6308.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(6486002)(478600001)(966005)(82960400001)(86362001)(38100700002)(54906003)(6916009)(44832011)(5660300002)(7416002)(66556008)(66946007)(66476007)(6512007)(4326008)(8676002)(83380400001)(6666004)(8936002)(316002)(186003)(2906002)(33716001)(41300700001)(9686003)(26005)(6506007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KK2Ye9MwkHaKyk3N1OOY1fBMYeUfy+bQxiNP/gavvB5r2pbKwgVpvoLyb/wt?=
 =?us-ascii?Q?Wi2x523lLdfC+m970OoOuqCECd2wUmiSrWtRBc3QFIlHVKxXzjAJ1KEDRj1t?=
 =?us-ascii?Q?FTfMqSG4gCPh/q3EjIXqbZj5XzPEnZP+xmzjHkqJrleKPDMokHOvfFBoZNgB?=
 =?us-ascii?Q?PPTH55i3N2w6PRdEh59t5boEHsI/uiEK5t7jNT29OkTnHCLROCvssHc8Kk5L?=
 =?us-ascii?Q?4n+5GLRPQtSoTiWXAoIzwKoV+sHMrkA0oLiH8ZVH6QItWdhWFrPQbMcWYQQo?=
 =?us-ascii?Q?50Sj0OipV5bH2STRjuMjWsrE5gFn2pKrNgOGuMP9UNLs/Jcm18NftoNzWxas?=
 =?us-ascii?Q?0AJHtACzuJtRg9XZ2M4n8igPnRQr1o+4uF9C/F8jVI4UKgY1h3suWrySdKdw?=
 =?us-ascii?Q?hCF4LY5MHTf/o1CZ3bo89XA+XIA4A1ygZuLjdWu7HPiHPLLRYhIAIzMX4mRT?=
 =?us-ascii?Q?X7gS7YmwvhzjPkZU5YKTnM0djUumPjpEfGyDUPxgZUPt5iI8OxPw6nQ7cSAi?=
 =?us-ascii?Q?gz+F8UuYcG2a6G+boerlcedJ3jdsx3x4UuJfzOWSyC53xqNi+NDH7n114hBg?=
 =?us-ascii?Q?TUbFB/iHenS+7O6WAES1MPrzfc2eGb/k3vjMdR5PtcfJNC2G+J3OObHFe8KK?=
 =?us-ascii?Q?b72cIoztkjUAItprdZmhkZmH162ekL8+TxLuJnQ88tqNIYNib+d/Z2dYKrWp?=
 =?us-ascii?Q?tNkkVJ1/u4Z5GxqOcNHRjvGrToar6SWbhHTPGhB7lciOUhR+EPzkIiOXGe35?=
 =?us-ascii?Q?rUEEvGG21hnRpxAzTXeVNnQSbVwMfxCD/F/hlJ4cLy2tChhJBi6XuD4S2hZy?=
 =?us-ascii?Q?DJhaE/NotybYlD3GfcgYzjADwCa1+b2NZ5ANizEnCvDHfhHoaJP4D4uRA31+?=
 =?us-ascii?Q?BBxoj5DZGSJmSm2QSUweiMEWN3EXXXQ+b7z5eqz+LLJGGvBOTGSwC+MLiJxM?=
 =?us-ascii?Q?wgb1TZcIuTIpGH50YUu8Y9Tuhv6zR90yGc/YXsmpplSgvkFRlUiMswokg+kd?=
 =?us-ascii?Q?7KMQ2J5H6qbAuldtUaUXVns6C1nQDdbyscQyfX5fSehWAtamEkcrfvquDM+5?=
 =?us-ascii?Q?6YcFBW2FJ2UFes7fSFReHsEKvWX3NDgI6OQx9Dt/eL8cvbEv+N2JZmyLuh3q?=
 =?us-ascii?Q?C+qYVGvhbQndqQzfaIOJMX1FqzP1R71DQALAWkt73ohvwkv0Z+ikToZ5vI/V?=
 =?us-ascii?Q?EOlvg/Vr6mkO7Go+idtR1COaQxXmKpUX3DkCmDK9GvAufRvbBz6Wdq2JXlNh?=
 =?us-ascii?Q?v7vEp/9KdPmJkyTxifDmtZTyWyaBot5nHjauSsu/UFX2YN5FNlJOG4qpPihC?=
 =?us-ascii?Q?C+v1Af7HyCLwNE2j0qeUGluFh6UC9QOiJrCFVpKb50MEsXafowvt3WS3v+W+?=
 =?us-ascii?Q?Q1IZPrKzakt4NA17PQ59zLqto9S5yAVGxmWgNEqmUcE8wqWoDTvLPfWY+/C1?=
 =?us-ascii?Q?30IdaHDm3gwv88hJ9igzfTSmGdrxmTlF7+d7wh7TQDpGX2NA22WMELjbvY7V?=
 =?us-ascii?Q?bxyL86ZXawTv0zckRYvbdIIQYClwoHRXUMQfw6LakLf8NYt7gEvD/+BbM316?=
 =?us-ascii?Q?qPyYrjaUMkt+bK+hNfzh4ywBTrojVA0ol49WTVK9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc2b8e0-0a2a-4cd5-eae2-08dabb498743
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6308.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 14:09:30.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lN+EBwq1r1dmuPLsjQFI+KjjUcC5bS3CtIIbuIEUkVm8fPq2v37ifss20YjU1238aw4zeReBVBSqHDhBO+acIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5800
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 31, 2022 at 04:40:15PM +0800, Michal Hocko wrote:
> On Fri 28-10-22 07:22:27, Huang, Ying wrote:
> > Michal Hocko <mhocko@suse.com> writes:
> > 
> > > On Thu 27-10-22 17:31:35, Huang, Ying wrote:
> [...]
> > >> I think that it's possible for different processes have different
> > >> requirements.
> > >> 
> > >> - Some processes don't care about where the memory is placed, prefer
> > >>   local, then fall back to remote if no free space.
> > >> 
> > >> - Some processes want to avoid cross-socket traffic, bind to nodes of
> > >>   local socket.
> > >> 
> > >> - Some processes want to avoid to use slow memory, bind to fast memory
> > >>   node only.
> > >
> > > Yes, I do understand that. Do you have any specific examples in mind?
> > > [...]
> > 
> > Sorry, I don't have specific examples.
> 
> OK, then let's stop any complicated solution right here then. Let's
> start simple with a per-mm flag to disable demotion of an address space.
> Should there ever be a real demand for a more fine grained solution
> let's go further but I do not think we want a half baked solution
> without real usecases.

Yes, the concern about the high cost for mempolicy from you and Yang is
valid. 

How about the cpuset part? We've got bug reports from different channels
about using cpuset+docker to control meomry placement in memory tiering
system, leading to 2 commits solving them:

2685027fca38 ("cgroup/cpuset: Remove cpus_allowed/mems_allowed setup in
cpuset_init_smp()") 
https://lore.kernel.org/all/20220419020958.40419-1-feng.tang@intel.com/

8ca1b5a49885 ("mm/page_alloc: detect allocation forbidden by cpuset and
bail out early")
https://lore.kernel.org/all/1632481657-68112-1-git-send-email-feng.tang@intel.com/

From these bug reports, I think it's reasonable to say there are quite
some real world users using cpuset+docker+memory-tiering-system. So
I plan to refine the original cpuset patch with some optimizations
discussed (like checking once for kswapd based shrink_folio_list()).

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
> 
