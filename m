Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862EA6108CC
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 05:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiJ1DiF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 23:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiJ1DiE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 23:38:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31717D01A3;
        Thu, 27 Oct 2022 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666928283; x=1698464283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=js591H3uUr47ReKcmReadDWEOOgGBoW4Yj7mY6SLFyk=;
  b=Mfc/u3sX5UsAMvCdY65YP2X+B34uDC9OLOlHfsIJn2497NKfG2hZ4RcO
   Q6k9JcTTGth/gjMtIxYzJ61XzolpSTgtxd8FvjYzVr3loo+xhEFdEZaEQ
   siL1gvNXQrdSXQfY8j4VGeheZpWb3M3HRBTdLWB8+xl+qmWNexnyHomfr
   3c9IFNNxqYzv3NViSkn3/q8T8S7/XjriqczBYAWp7QRFb+quIf8zvW+Yx
   dQ+Ty7v+RWf+LZrgicdZUFLNFQc1qHoDXkAooVqOdph92VivhTnmzluWd
   iG0V8b80YEFiJrqpFxOFUxBVkCyHFfNj3Jr7MUBJp/LZqMcsOpC0lU6XS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288116996"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="288116996"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 20:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583786087"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="583786087"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 20:38:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 20:38:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 20:38:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 20:38:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 20:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhPv8C8TPPWp3KylCawreGp1dZR9Mqv9l+s7vHfhs9UMRvRy6V0vKwc4eBVcBu1xwtYPwHw88UKbioNknGezCt0Ck+9scSteWL1eZlBuxDa0xYsnGPnQpoulsqTNNOS3Ee2pTwQyO+B9dG9tMbmUrd0fNuiU8ngvEI88gMH1NBpTGmessPFJ2/WEZzh7QDQWmYYAyKQ3g6PtdM7Yi4sqA2i27aq5SPIW6XSHSREZUdQLWAVYX1Z9ewUag2b0KHJ2XA1Y1XgwY2mI6kGhH82mATCH54DBXv0mrlD5zADLaTlSQApXKnvYLiWbf+ireOqAI/kE5E+MVZcLpP57Lz8trA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDoqMhdUpMybYE1SX1Sw1mLhDJ9LbUnvfHBVha3louc=;
 b=Qz1FFYc34Pe/Q1Rniip4iR049Hmpn/kxBixjbXzJNR/kth9HJXabpFbCqHjP20h+vpDazxz1McXqNkIgkkVNLCyvt3cfOeEv2dks5jd4B3Gynp8vrSnLg4KJbVN2CwxcOBhr/PBt/aJi2XdvJE8sAfDFRjiQwclDy9IiFvpzmjdYLy5DYC7TFIpEESb8hKy3f5n2u/LlQy7IOp9O90OrB03FndfhghkaxN8qk6LcAMR3RkigkqruyXEQiAJ0aNYcA3HT+N1AUgnRrYXIlImqbR2ZvbjtpUR3e4AUW7u01nlDUxA6QE+hMmXNJtYIhXVMxdKNVx06QU3o9Bv/eZ1nOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 03:37:57 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Fri, 28 Oct 2022
 03:37:57 +0000
Date:   Fri, 28 Oct 2022 11:37:46 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "Hocko, Michal" <mhocko@suse.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
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
Message-ID: <Y1tOigFZeDzjPGsv@feng-clx>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx>
 <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
 <Y1ovOeEPXT1fxCuc@feng-clx>
 <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MN2PR11MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: deb430d8-df2d-4186-56e0-08dab895cdcb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9uICrA57CQjkMGur8bN+EvRYTYXc3rGUK9ne2asReXzRSB9Qx6ZjehD2wwbG5mqeZDHAY2Rdv+UURCw41BtqWqbaRZeLYoT1isK8E6jtZ72S+bDIdDiD8L+OR7vrxMMMscvwykbp8jw8lToxqk/Ie+MBDA1MTswCGGdKur5KtY8whVHUE/fhtpZLGZazMx3m91iaN+dYjZd+FjVSkSpa4kvSb8AA5Y+0o4JhgcVWls5OQHHw24PveFXEWg2Fboth3Xx0zhaBJZEJ2doNXQcpWW9mEytD0kkPALpUyMh50ZcHsMvKjwYnPi5KK/cvMTAxRkSLNidJ4pbBV7PQK3bDxpxPdtcs3IKc/9UbTMVwzeKDcfpoJmWZwMAgw4NcywsXEOXhnfBwATLhMk5D3C4kPURXEK/E4wSE0lGKfsy/yHJ3r9DzDuasARCt87MD1S7KR2QJuZPL8Uf20pze8Arok3skB5vSeBCW8BUhA1Iqw9QLHN3luLQJ2DLMBq5XwyEdXm9cnazJR/1idR37yjl9ydW4JZcrs1YNydtoWuJDOznSyAvB92tc2XqageEF4U1OpLL6gRrnL3QPZVpEOSDBaAyubb2RV0RZLfFmLu1kj/qAWp1Yuu9WMgjCv3Nvk78+y6Qpv8TF0hnEYBTmdYDTWkUqIMpFZKkwds/EEV6X8luVFsmlaQxFG4G4SGh/PM7508sjFfOm0hDgQbhqAgW7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(7416002)(66556008)(6666004)(66946007)(66476007)(41300700001)(6486002)(8676002)(4326008)(8936002)(5660300002)(478600001)(44832011)(2906002)(38100700002)(86362001)(6916009)(186003)(107886003)(26005)(53546011)(6506007)(82960400001)(33716001)(9686003)(6512007)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPrU1hUuSYOzp8SroVq9RMYZaKhfixdM1q4Z/7sTwyi9vwo901k+PH1kKBsG?=
 =?us-ascii?Q?hFT2B9V4adri/bqVTEHJ0I9PDHORU7hEmZVRZ3Ekd+zqgrdGV2pqnCmBzsSA?=
 =?us-ascii?Q?I8IPqSr/Iofq6NTELaZE1lr3P/RtzqTLLT30QZ91fxglyorqxm3UF8FLrGaL?=
 =?us-ascii?Q?QrWd8CZ0WGbmX3ZEtodcokfXkXC8AF8R3cb+4xBN9QatdmeWceocmZZgoMGc?=
 =?us-ascii?Q?icKIkrHTFBgE+ofzXA2Tcm8gSANUh2ln3aEaPeVCoUP5hqCvfrRN0gnSLEzj?=
 =?us-ascii?Q?RzBbuGaUESv8oK6tPc3iM3Dp2Hif3XYsADrZJhfIUV6druCEeO+gunPaq/mz?=
 =?us-ascii?Q?XVQp622HutN1aVLdibdtfW7MNyf8kNIfNg3UZgKRY4IjrQXo3d/Xqd9MLnzD?=
 =?us-ascii?Q?WY2aU9IhW/wayYlYQep99zidPVHAJ0GxgIbuNXxd2zg2mYOdv6lh81dsVqoh?=
 =?us-ascii?Q?SYWzaj/1rCYmnM2STmWz7Hc9i/HM17s3wp+nybR09YhDuYMf89SLE4yRjD1v?=
 =?us-ascii?Q?haHXi6eAbHXNItCeJ9rfKQV66/mcxRiXx7oKeKDRH9v5JJYEeT49rnrsiIWx?=
 =?us-ascii?Q?4WfIMsHDKoNzkLHAXYFv1MsEBpSKIYlwr/ILiNExGAaCTYPe2Uvzm6bVMCN5?=
 =?us-ascii?Q?HulJf98mswu+1RmXRhMl2cflIU3973zXiitQae+H4AGfCIJBlU5mphYvsg6v?=
 =?us-ascii?Q?Vh9OuWSCC1dpGExLpGyFsF4jm9RaRGSwxJ/KfcV3lHE8bZoelHwWY0UboyTk?=
 =?us-ascii?Q?IzYP0F8G8IEcxc4KuT8oez/x0RN3OC+S5qfpdZeXLl90JceN3IelqQCWcf5u?=
 =?us-ascii?Q?ckOQB10T1Xya/oyV8IispEnPmF5FyJeMj7jiaqelktuSbXafXVQJ5uljMnzk?=
 =?us-ascii?Q?7veQ8vWUTlYE+O4y4vZvf7yhfY10UWgvrt2iWDr4UUY4GJJMsJSbGrwOpfHC?=
 =?us-ascii?Q?syB8mYfPd83gzCzpnPl3uGRgWvEJjNEu0r4K6EZxqjDkY9UskXfqOByGkseW?=
 =?us-ascii?Q?uJh0/QAGHiBLPyByECGSDIiNsCuTvNBzkn/IOWgaUHjbXFJnrB4+EPcbgwnH?=
 =?us-ascii?Q?nOD5ftkz4Bbxg36epB2Nq1RpRp3oRVRNRzfzxC47Uwrl+7lbIiAohTGRYGkO?=
 =?us-ascii?Q?bWrXUIKK0T9o9ATqUJq6ukbRUc3DgSxq1lZIqB99CDUWTS0wlstzhHHamTnu?=
 =?us-ascii?Q?BrYGVehZjmi2wvxRqEd7fRUgNSLwhh0aAwffXOcCodFrsQCACB9WOJr6Ltaj?=
 =?us-ascii?Q?zfHUzefirQyD99ynPMgCIZmaWdcUEL7GzipZcngF0Ftp/HGd3NhrQiamuE/9?=
 =?us-ascii?Q?9wGM22oL4OwgOhAtVSS9e0fYKp2FdA2vJoeqQZTJXPv0z1SA0xrc4Vv6FwVb?=
 =?us-ascii?Q?JXIQ2/tk/c/gaoPcLh1AdIpH86PKvQjozSdyy2WQwSrtAMGK2uLir5qd9Fx5?=
 =?us-ascii?Q?D2BX66pjYXsMYWLagJaBCBOSzDc7ONEof40D5a4vCGnukW168/rJlC8gRreH?=
 =?us-ascii?Q?exLYoTsqr0g1TPMgyios32usFFddvn/BPvrzBwZkpS4u5lyEX1tFrIQ0Dz//?=
 =?us-ascii?Q?4JWCc/hUFfmhauE64qtvpz9vSK66Q26WXqroHN30?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deb430d8-df2d-4186-56e0-08dab895cdcb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 03:37:56.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l3U4iUy3SGVaMoiQb0dLa4Y2foFZ9kaU5vOJIwtYEn0RiWLh2zEyDFnY+s6B7lKF5FJodcu1HgEhSVKbeMAow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4566
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 27, 2022 at 10:55:58AM -0700, Yang Shi wrote:
> On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
> > > On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > > > This all can get quite expensive so the primary question is, does the
> > > > > > existing behavior generates any real issues or is this more of an
> > > > > > correctness exercise? I mean it certainly is not great to demote to an
> > > > > > incompatible numa node but are there any reasonable configurations when
> > > > > > the demotion target node is explicitly excluded from memory
> > > > > > policy/cpuset?
> > > > >
> > > > > We haven't got customer report on this, but there are quite some customers
> > > > > use cpuset to bind some specific memory nodes to a docker (You've helped
> > > > > us solve a OOM issue in such cases), so I think it's practical to respect
> > > > > the cpuset semantics as much as we can.
> > > >
> > > > Yes, it is definitely better to respect cpusets and all local memory
> > > > policies. There is no dispute there. The thing is whether this is really
> > > > worth it. How often would cpusets (or policies in general) go actively
> > > > against demotion nodes (i.e. exclude those nodes from their allowes node
> > > > mask)?
> > > >
> > > > I can imagine workloads which wouldn't like to get their memory demoted
> > > > for some reason but wouldn't it be more practical to tell that
> > > > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> > > > policies explicitly?
> > > >
> > > > > Your concern about the expensive cost makes sense! Some raw ideas are:
> > > > > * if the shrink_folio_list is called by kswapd, the folios come from
> > > > >   the same per-memcg lruvec, so only one check is enough
> > > > > * if not from kswapd, like called form madvise or DAMON code, we can
> > > > >   save a memcg cache, and if the next folio's memcg is same as the
> > > > >   cache, we reuse its result. And due to the locality, the real
> > > > >   check is rarely performed.
> > > >
> > > > memcg is not the expensive part of the thing. You need to get from page
> > > > -> all vmas::vm_policy -> mm -> task::mempolicy
> > >
> > > Yeah, on the same page with Michal. Figuring out mempolicy from page
> > > seems quite expensive and the correctness can't be guranteed since the
> > > mempolicy could be set per-thread and the mm->task depends on
> > > CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
> >
> > Yes, you are right. Our "working" psudo code for mem policy looks like
> > what Michal mentioned, and it can't work for all cases, but try to
> > enforce it whenever possible:
> >
> > static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
> >                 unsigned long addr, void *arg)
> > {
> >         bool *skip_demotion = arg;
> >         struct mempolicy *mpol;
> >         int nid, dnid;
> >         bool ret = true;
> >
> >         mpol = __get_vma_policy(vma, addr);
> >         if (!mpol) {
> >                 struct task_struct *task;
> >                 if (vma->vm_mm)
> >                         task = vma->vm_mm->owner;
> 
> But this task may not be the task you want IIUC. For example, the
> process has two threads, A and B. They have different mempolicy. The
> vmscan is trying to demote a page belonging to thread A, but the task
> may point to thread B, so you actually get the wrong mempolicy IIUC.

Yes, this is a valid concern! We don't have good solution for this.
For memory policy, we may only handle the per-vma policy for now whose
cost is relatively low, as a best-effort try.

Thanks,
Feng


