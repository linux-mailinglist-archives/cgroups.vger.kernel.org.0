Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9814F60F187
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 09:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiJ0Hvd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiJ0Hv1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 03:51:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8515A31A;
        Thu, 27 Oct 2022 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666857082; x=1698393082;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=no6JZxzuKIXDL1nI+sQ6MVtarCowvwN2y8ViNLYssKs=;
  b=PPSQ+oU8eZDo+70S3IEmF/NhrOxtc/ExF46tFq0sfVdUPeeNS1wV14Ok
   KegK79dhW70GuxscINmdhieegFjVTU4rhZwIaKYnV9Y12GB1UwYGNjUK6
   EPAhVdX853O8XiHZ8uk3AKY9SqVXEF+kQWlIdNkNMq6h96TiaTI7vkEG+
   aBU0bLXfNAUygkrdvdEGUFYq38ZFGlU2lqpESQGeow9JwpPMEKdQUrMgR
   O1O9vI0nybE83sTwsOX0Taf5tKzJwM5RTQyPrXSUqRY4OBTqrmmj0+c1s
   QB1WIHmnQNWd3K/BE2LoAAp9ypIeEK3nmJcqf1iC+ORL6o5k/WaPN/mtj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="305771123"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="305771123"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 00:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="695703984"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="695703984"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2022 00:51:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 00:51:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 00:51:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 00:51:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDZj8gkI2ISOni9a6zRe3GTL9ykSaUq0I3Slz/abtJq3FjBxL3OTBJKIR/ocb+FItb6Dm/CQ91zqeUrdV021haWfT/7tgHZr73oCYciv6bDr91XPJiK8UE4I2KcphsuIlmgnXHmfalDHE6FfNDbjgHhupXl0uDDgUz9ATEy2JgqmYDa8x7WCzY337XiTrSb4nk7A29sFodLQwYzmyXpZ2gndKcaLJIYD50Y95LS7dBgDEI4W8vnRdHW6sVUpKKYH+9TWaYZKpurMXiAJvRzaqR55hG58AKQZ7a9R98lrWKaeFEpxn9iaGYgX4jxYGGzvJA0C3nzaiLCyiH0BeZXsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99DWsW4vjoliw0hPPa1d5bSibfaygoEWG5D48+ldTBo=;
 b=IA8CkpEmk+gYSMviSPkToxoUgir20SZZdMJs26yAQTMdYV0hW3DdYqwn/f4uiHvx2nBm/QpbPsnKUTpj0Nev/oU3kEUVEcjU37v3BLETrCmM0FG1faQHKwvxYt1I6ht9kiSLXrzZQHPpZGepx20cSinIff/yzQ1oy2cKn8NbVAqHiseCBf50hwc+hQuCRdtMvw8dr7MNvRJXdbO4MxS3GdOYk/iQks4lDwt2e9L43SI5/Vak8wVqth1fDdngD2CmhPoyDEq75s7lpWdDkdLTIji0vskPa4crmWxY4puJRhFJexS6v9N695nx9+L9OId+xQte+9kWLE93fjgy6AQPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 07:51:17 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Thu, 27 Oct 2022
 07:51:17 +0000
Date:   Thu, 27 Oct 2022 15:51:07 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Yang Shi <shy828301@gmail.com>, "Hocko, Michal" <mhocko@suse.com>,
        "Aneesh Kumar K V" <aneesh.kumar@linux.ibm.com>,
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
Message-ID: <Y1o4a0HzYTZRArhU@feng-clx>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx>
 <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
 <Y1ovOeEPXT1fxCuc@feng-clx>
 <87k04lk8vr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87k04lk8vr.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 900b2a72-20e9-434f-7372-08dab7f0078d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuRosUvRHUvxlM+OrY81Vkssi+dJHXC2iE+L9In4NeYu4wo+XYoDwqMu7zNhVXl9tiTeUFjh3GoQsgrdWsyfIly7wdIM9UBSeqrLKMYn/uOrMpx4UdvNVj06ytgc9GXAS0Kdig8w72O/B3Tef2+DQFCjNyVjRkxXlqqt+SDcXm0c6CTTAUKuCWOcpEupAYmVZwQqPcsM+ueflpJZSumAGz2Rl7XbpEylhauOXzA3CFn9Poys/b32uv/PvUWzBdS1asOMOY0aND1nmljqYjYtPao2eN9izMmFesfsOF+KscSJEkStpNV2cH3qk3mvgl2pVhtbVMSn1C6z5wn7YPgFDn8Hswx9MAnal0KqGqrq3mD/bAN2GRz6LgoR0cgs8OAG6DAcFbuPCTi9pRZrjflmn6h6u0EGVC1xCQqrp3Icj39s16txkq1gBuKxQ+OEVPreWrArjMzgXo0uW7qPP6cbaSICLTQ+Db4aaU3RPeKnbkrm3/2L5i6iQhxv5lz77Ykf+DuioV+GkyGPHBARm1Zind6AoWzu2kyf4O/IGyOPz7UNFAjTUAE/DrzXKZKvK9X60wj7bhiK7HECb/LimBqObapfFbQxfEkiC0W5KGL68slMOfJEpyoJTXfXlX3blEOAnLkG+oFz49p1Ds+wjRytzx50EsJEKHFKu9rJIbhHBQQFh3ztBCVB3g7G+OE81TL0/LRcYGyBqnj+jwtR4iVx4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(6512007)(66556008)(41300700001)(82960400001)(8676002)(6636002)(66476007)(54906003)(316002)(6862004)(66946007)(44832011)(5660300002)(38100700002)(4326008)(2906002)(6666004)(7416002)(6486002)(107886003)(478600001)(186003)(53546011)(8936002)(26005)(6506007)(9686003)(33716001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gd0HFP2NywL4LYdwg92Dj5sADTmgd5BbuJqHN6egjFdLt6sH6AuoPeVOXbvA?=
 =?us-ascii?Q?LlzB4V6QVcUOqTAeKKsIddd6DKNVrQo6nnLnAGcsIEFoAEsmwYKss+BG6/KS?=
 =?us-ascii?Q?6t48v6UFwExs/VbvIMAk90LKCI028fVhh5FllwWaccMOAQRxvv8Shuezvbcf?=
 =?us-ascii?Q?zJ62ccoF5Flv0hhRDz0znS8C3/Mxq8m9OPChNKxOMEKVHZl9eL1ADuqqhd+Z?=
 =?us-ascii?Q?gq01QeoYeAN7FHbxLL04xm5pJ6EOJMgWchB3eTwi2qq9sIggNVaak7Kfnjua?=
 =?us-ascii?Q?rzMGc7k1ZRb5AmO3z4LJtuGOIdSkmm2P4eCMCS3ayPE1MLgwAHfNXrIIYv6d?=
 =?us-ascii?Q?kPxFXBSgPD7QAkF4gEBRT7P6SXJ1EwOTln6jfqtSj3ICwbYZpLhO9x3PMjx3?=
 =?us-ascii?Q?swKtv1QqMtmyCYtPDkHe+VEH26xvuZzfj8LU9dgvKjpn3Xp7O6H8j9wt3578?=
 =?us-ascii?Q?COEmW1MmlzfRWNNV0kL8SteZJEc40ymdrjTlwWlrjz+OseGrfPa91ArewbUl?=
 =?us-ascii?Q?aSp9cO70YAcFc/jEVDqGs/YCmDG0FGmrJYWtqaY/7tTMpwtcS/IuD66x31uY?=
 =?us-ascii?Q?Z3Er/WB9uWMa4sKj+lMa1tDkNpwP90ECEVwl3vY8q1Tn5PDWSN+xXWvVyM29?=
 =?us-ascii?Q?J3IRpNN5T1g7dm9yegJhNk09JDub0imlYjS6fKi75n9OX2T5Yk8Ixq+YZZm2?=
 =?us-ascii?Q?6nP2J34DVptYeuEoiy09mNbF8iWN/+TP8uCdj21Yn50QN82ghxcJ0BahrXTc?=
 =?us-ascii?Q?QrWBtl/1sHiYXzc7UbnnIGnS8ia6qw9Ezo/6CnOEam7N/j+8Brq17ZehjUlH?=
 =?us-ascii?Q?MGxhVVw0BRWQrfPyfV36/muIFn99DajTdf30wbnNh6dpks59XlNB7yylanVj?=
 =?us-ascii?Q?md6wKtVDIUKRC/e1Yp3UOeOMqT3VALvHIsc5JZfs9H6sVQBmPqVzvCgaC6we?=
 =?us-ascii?Q?BZ8JcCSbEyBHxPcrRFkWDgx+l7Tj5m7wSJQu1Z8MrCTrPwW7TgzkRmahxR7T?=
 =?us-ascii?Q?HTR0xUskp9BhK9UypC5D8WwnrpleBkcukKA3SnxwQIGVmZPpjqWZComJhL+8?=
 =?us-ascii?Q?UcPBBoJuBtU367lvZe8AU+Z5hITHw9CeobT2Y7E43JZZq4gVFDWf1vkmPKJP?=
 =?us-ascii?Q?EWWzjA7/JQAiXDDgk+JLYvAqN6o6AdgmkbFR8rp4MWKjkShEvZwx1lOM279Z?=
 =?us-ascii?Q?y0EGc9Vi3jIa6Elib2EhB3KN7S8eaoQRMAfMQfNiXo7trvZKKpS73unCo5v1?=
 =?us-ascii?Q?sTrDnV8Fk1NTjkzU/rGJ4ghU3qMY5gqZ7MuSHBW5Ch+VvPVG6JDnaiB+kHDZ?=
 =?us-ascii?Q?Lc0JGF8JbFk2tCsOruB3e/cBhCmn02c9wX2VCXlZAO4H6e16L9GH5F/Ft7Ph?=
 =?us-ascii?Q?f/C3vISaZirWIouMrMNjQ6U9mceBCVtWnRtKGf0dKQT5FIg/RK28Tr6Y5y96?=
 =?us-ascii?Q?Ol1DflUKu3qM6vw5K2Wo9RV+TUazhCvBxhsezwFIozOCFYJNHCHQOAShOnT7?=
 =?us-ascii?Q?alS32xAsFRLnYa8r8Z6r1VJfVQCkOP1Eon3CjrDVT/lVdMuuDE5QTbX6oDYY?=
 =?us-ascii?Q?L2VUOPpma9m2oDvl7ddGr65JQDWMKCFonUbVms5j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 900b2a72-20e9-434f-7372-08dab7f0078d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 07:51:17.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5JAQUkewo7tRZMU+Nmy7dZ4SUgSrwSNd7+SMOY8D9oDBTT74ttyA7uphI9Mwwv7rl1gkaUePZqwXFWiFzwf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 27, 2022 at 03:45:12PM +0800, Huang, Ying wrote:
> Feng Tang <feng.tang@intel.com> writes:
> 
> > On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
> >> On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> >> > > > This all can get quite expensive so the primary question is, does the
> >> > > > existing behavior generates any real issues or is this more of an
> >> > > > correctness exercise? I mean it certainly is not great to demote to an
> >> > > > incompatible numa node but are there any reasonable configurations when
> >> > > > the demotion target node is explicitly excluded from memory
> >> > > > policy/cpuset?
> >> > >
> >> > > We haven't got customer report on this, but there are quite some customers
> >> > > use cpuset to bind some specific memory nodes to a docker (You've helped
> >> > > us solve a OOM issue in such cases), so I think it's practical to respect
> >> > > the cpuset semantics as much as we can.
> >> >
> >> > Yes, it is definitely better to respect cpusets and all local memory
> >> > policies. There is no dispute there. The thing is whether this is really
> >> > worth it. How often would cpusets (or policies in general) go actively
> >> > against demotion nodes (i.e. exclude those nodes from their allowes node
> >> > mask)?
> >> >
> >> > I can imagine workloads which wouldn't like to get their memory demoted
> >> > for some reason but wouldn't it be more practical to tell that
> >> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> >> > policies explicitly?
> >> >
> >> > > Your concern about the expensive cost makes sense! Some raw ideas are:
> >> > > * if the shrink_folio_list is called by kswapd, the folios come from
> >> > >   the same per-memcg lruvec, so only one check is enough
> >> > > * if not from kswapd, like called form madvise or DAMON code, we can
> >> > >   save a memcg cache, and if the next folio's memcg is same as the
> >> > >   cache, we reuse its result. And due to the locality, the real
> >> > >   check is rarely performed.
> >> >
> >> > memcg is not the expensive part of the thing. You need to get from page
> >> > -> all vmas::vm_policy -> mm -> task::mempolicy
> >> 
> >> Yeah, on the same page with Michal. Figuring out mempolicy from page
> >> seems quite expensive and the correctness can't be guranteed since the
> >> mempolicy could be set per-thread and the mm->task depends on
> >> CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
> >
> > Yes, you are right. Our "working" psudo code for mem policy looks like
> > what Michal mentioned, and it can't work for all cases, but try to
> > enforce it whenever possible:
> >
> > static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
> > 		unsigned long addr, void *arg)
> > {
> > 	bool *skip_demotion = arg;
> > 	struct mempolicy *mpol;
> > 	int nid, dnid;
> > 	bool ret = true;
> >
> > 	mpol = __get_vma_policy(vma, addr);
> > 	if (!mpol) {
> > 		struct task_struct *task;
> 
>                 task = NULL;
> 
> > 		if (vma->vm_mm)
> > 			task = vma->vm_mm->owner;
> >
> > 		if (task) {
> > 			mpol = get_task_policy(task);
> > 			if (mpol)
> > 				mpol_get(mpol);
> > 		}
> > 	}
> >
> > 	if (!mpol)
> > 		return ret;
> >
> > 	if (mpol->mode != MPOL_BIND)
> > 		goto put_exit;
> >
> > 	nid = folio_nid(folio);
> > 	dnid = next_demotion_node(nid);
> > 	if (!node_isset(dnid, mpol->nodes)) {
> > 		*skip_demotion = true;
> > 		ret = false;
> > 	}
> 
> I think that you need to get a node mask instead.  Even if
> !node_isset(dnid, mpol->nodes), you may demote to other node in the node
> mask.

Yes, you are right. This code was written/tested about 2 months ago,
before Aneesh's memory tiering interface patchset. It was listed
to demonstrate idea of solution. 

Thanks,
Feng

> Best Regards,
> Huang, Ying
