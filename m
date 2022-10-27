Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99C60F0F3
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiJ0HMX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiJ0HMV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 03:12:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E627A14EC64;
        Thu, 27 Oct 2022 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666854740; x=1698390740;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hv3FONUBgicG+fqtYjR87BokTlhoRbWzLj0XTG13jgQ=;
  b=T9gQhY6/jBIi6foIh3ynor9gs0UGYUmj/KG6PmIJBcHGbpR83FovpvU/
   jdqIizSG3GbtNLhODFwgHVbSrfiiuEVte8zn14Dkt0L74pPbOxk52qiVZ
   062dn5JK65ggje15QajqGcddmbLWCTGuz3FcT9k5ir+7jsxFmY+45QyJo
   FAeSmvh71bPOQFlLAXfPnoVXIrUXU7q5QelfENTLgIEcH+CclsRWEwOEs
   +yr5apdZNtsRDSmEeC2PANjKyXZKOZK7PKI8tFcH45HtFk0mhomxFCpfz
   BqxAkQQMyLgluy1Mz+euuPQoxJep9R4Ak9q8XRNKXfhDks7GazBVURB6d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="334777731"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="334777731"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 00:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="632302530"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="632302530"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2022 00:12:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 00:12:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 00:12:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 00:12:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 00:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCLCK1aiEhDIMdu60gA6QcV8LDFemNnsicjH/psluK3DehWSIPU+1Flup0u/vULCDG4FHS6J9mskcMGZYHo6v7o0/HKEmPg5MBOHXHy5exqq3edftYL1l4LAKtAuki9lp1IhuX4soK2xD8orFCXlKs0x4Qj7Lf3eeaf6lJW1fb4QxU+52q+Qr76H0JgeriQQnYBR40cYPvIKUeaXphstzpNpbjFkWyQTTNfHV/XpReJwhMq6c8tdO031AvwOABIXWnaW8xRWd1cF3Af9RSG3mwVjERvS7xshIXieOIYLdSaQ5liVIg9BmUdwkH6hxxa7nKaK6SlQ5/8cN7xxyfw2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B+LGQ49uxeoV8E2reUk2slt8ipZfbYl11cK58tugJ0=;
 b=H7Wgn2M8Ge9GbKDH4+VljfDlQX47eeD1ymrFRJPbHH09nmPZpHKUxpelAJlAMT3UXXN8BwtLtQLq0e7JlbM+Gf0XasmZSfs3pygcW2G164OaK31+Wi3ZUvkp6xNbgnGKTn0dnURUIe4S7YGCggsXHFC+qkBPmcSnJztip4VYCzwKxOM3nCzPnqX7rLkwOoVBcg7iWxf0KXZT5yy+IrOYpT+EMIBlDMyGc9VxftFOidiHqzcWXzirlUpRh31WEeRLlJTB4pR5p2YN1klKzTMqX2ivNTsTc1x2JKeELJFFd8E9M5ao2vVgmXjzRmdyXUvTLMI1xIs7D8dQPrP5Xf6Mrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6308.namprd11.prod.outlook.com (2603:10b6:930:20::8)
 by SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 07:12:04 +0000
Received: from CY5PR11MB6308.namprd11.prod.outlook.com
 ([fe80::a6bb:b1b4:592e:733b]) by CY5PR11MB6308.namprd11.prod.outlook.com
 ([fe80::a6bb:b1b4:592e:733b%6]) with mapi id 15.20.5723.034; Thu, 27 Oct 2022
 07:12:03 +0000
Date:   Thu, 27 Oct 2022 15:11:53 +0800
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
Message-ID: <Y1ovOeEPXT1fxCuc@feng-clx>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx>
 <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To CY5PR11MB6308.namprd11.prod.outlook.com
 (2603:10b6:930:20::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6308:EE_|SJ0PR11MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ee86b8-7bc5-4a30-015c-08dab7ea8cae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dp9i/k1RO+RsZTNiw04s8npPI7Alyfq8EGMYbC3t5xCHVAulsGaul+Fpsu2gcqDnKu3O3Nr/LSs1aExUNim39juCaZslgtTEp7GMfYiFudrl2GaO2CZ7CqfooVprSoYuqHXkFmdNrb6W/9GnFQdn5JN6O+eVjSAseZeSyycBU2iOgD2mAr69XtscZcsJgZciWkpkCNptwn47Jcj8tbANOC6x6SRK3MhqAtkJ5g6Y2ul09i80yC9Ofu0Zea10N7r+wIabQYgccz7wQnetGmYat5ITNE3XJf7C8PRo02T6C8Lxhl/DR2Nq3v6lO/49Nbn7XRbKyuD5EZl/Pm5QjSoBjbtOBcSuFgKCtTE5ff4r9heMKs5CIUFsFe1zGEYuJDDFB5zuPkN4l6xIIT7ZoJaYXX3CyUr/ctiWLX2FKHVpfVIl9CjCJ0jP7BgxIHg2fwZZ88IngzTfCXNysC33VmVY/QRMnENsN3U/hStyHdrl79fcxc35mFqc7TUtGAv8pl0uYY8XsDVCNzisiVrpazi7sPzPkQs+ppkphsHqdr/5jxPNmdkEXwMMbMrb/Ix9ZuIvj4ZTOj4KAbTaBtYK7FwJTmCCAJ20usO1QU+ij0LGA7+tYSR9f+nNrDBa/KUjT38bBdfJUq9pfXzTLwnLkTao1U7v2VA3TqUiGiW575LjRLKzhbdjaR5+SRJv6za47nnZqVmWxiL054xRS10fyLwqNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6308.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(82960400001)(33716001)(478600001)(7416002)(6486002)(316002)(6916009)(38100700002)(54906003)(53546011)(4326008)(8676002)(66556008)(6666004)(66476007)(6506007)(66946007)(107886003)(5660300002)(41300700001)(26005)(9686003)(6512007)(8936002)(44832011)(186003)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRo07X1IDnB+HCAuGtiSdp5TI/vcoJbRajIZ17eQ/IrgqI3B2WY79uqP5sDv?=
 =?us-ascii?Q?1wZd84YLx3zSMMFw6zdKMwToph5+ccLleHpVorrPTA917nwy9dnJN9w0iFTt?=
 =?us-ascii?Q?i+BwJhUqnTcyU0R6/bbwkh518FNksoH2WtGXjD1XC6uHkCtN8iM6lKVcOHwF?=
 =?us-ascii?Q?nCpM2ncEAo5s0P8eMF8x3JczkEAQlCWpnRYtfaaL83FG6tMkVjU5eadiV655?=
 =?us-ascii?Q?iG5uqlAFXP4qPSZwfRzOz92/J6VTao7uhJNDDW8gGHAo7ogxb1yKYDuEYmNb?=
 =?us-ascii?Q?rqAYpb2jSI8rW7Drhr1aH2EAeHAzF5TlX1WqtSsb6kk4cCj0/Dot59Ef9RgU?=
 =?us-ascii?Q?hcgvLCiRi7IyQ9uRJTIL929V7nJRJETtI+rS9Pn0fQTmpHEKk/Q/tnotoZ3f?=
 =?us-ascii?Q?d3Cv6k9zcqxF/I/aTBcYpFzPJug+XduW0OC71ltEEL/RWRo0YDPc3/yq17NQ?=
 =?us-ascii?Q?csAyiZPbu6KxM2ZTR1nPu6r6pvvnGytwNYpa6UD0EvCfHGdzVfyrbEMjY87v?=
 =?us-ascii?Q?DgA2jV6kixPhzLk4aTkyT46L2DknWIg+/Cgir1ZvmikAWwyUW+yGM0pa2afw?=
 =?us-ascii?Q?zXlQOLk5fcauumXWaKtcGdpbsSzgQBTTfAUVT2mgGRCNVMlHei0b/1sXBIeX?=
 =?us-ascii?Q?fC3SGjHSUfUdYOn9AWWpqZfhrl+8Pn6lmQG/tc4BTvnJbfxE9aDK26T9lPjh?=
 =?us-ascii?Q?oN10UZI7GJVGG4XPzBaXOiNfM+D/4+BZWI1TZ0chlXYydK0LU5GzTT9EmwU/?=
 =?us-ascii?Q?YV9yWWquJy8fL5AHzaEYyGCFqUkPGuc/5bw0uNX6kkHw7gj2jqbVk5CQa/Xx?=
 =?us-ascii?Q?1ivkBApUvW4BydiZbi2qnIDJFl1wMruhfvdWvW3rDgYFxq4AklsVMj7bMKbw?=
 =?us-ascii?Q?jehsoyTK8eioid6bTob+fdgrnlHgNs4fZvL/8U1FzYkITsHVndIb23CmR6mG?=
 =?us-ascii?Q?RBqBy8AOfD9JvT/mw36pbJ9dC17FTtf6FDoUe/gj9+VvfjYrtIC3zF3uFgdZ?=
 =?us-ascii?Q?iTacvI6I0sFtaUgA4QdlYnmO2bG3aQEYP2+270NI+OnJEW/HbZ/yL22WfBka?=
 =?us-ascii?Q?ql0ttsbjxo3NlucBoTixUK9oMPzREsfnPrkA0KT6TF1pV+phBSSkSfWOBqyW?=
 =?us-ascii?Q?EE+jdfqKU37ZRK6L2E8ntbD+WtNS13PPRzVPbqaOb9O1Tw0dGk3gCyDLoHqN?=
 =?us-ascii?Q?YZLwwGOKG8UhpC3kFOxypQBsu7J60UGgw1caGHdwNKapA1+SXy7q+gdkiQzs?=
 =?us-ascii?Q?iESRIBr6Qf/lrG/T3UNsgK7F26YUUIBPkxB7QiHov7N/obcFoRDUOWNsHyst?=
 =?us-ascii?Q?ea+dgZU0LOXbjnh6553FvX+A0vhAaAsaQicZo5fA9jFdPeGBDmQji6mXbecs?=
 =?us-ascii?Q?5M0Ftt6/KSSlcR3xs2dRCJSfx9EITHVp/fUDFO2lyQBfSLFNgqsySIRokY+t?=
 =?us-ascii?Q?lD4MSSa6V/ePFzSq/FLIcGUcpuSHf1qAit3tgLDtCk4i1nFk6hqmSrK7+YFr?=
 =?us-ascii?Q?I9bEQkL1p6xZhkGptZr/p+aFbPz8ylt5v038We7OGQm1OAh0H7xh2CAR/ptg?=
 =?us-ascii?Q?smsvpbB9OjzGfD5nX2/nVrfUJrzE52xa4xCmejeW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ee86b8-7bc5-4a30-015c-08dab7ea8cae
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6308.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 07:12:03.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1vrU3GMASY4VdZ9UOka+ldVHmgikGUDFAAv1fIqUymfpK2yFUhjhbDI+kdi07HhjWebaoV+AnMYvlHnDV8bjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5630
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
> On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > > This all can get quite expensive so the primary question is, does the
> > > > existing behavior generates any real issues or is this more of an
> > > > correctness exercise? I mean it certainly is not great to demote to an
> > > > incompatible numa node but are there any reasonable configurations when
> > > > the demotion target node is explicitly excluded from memory
> > > > policy/cpuset?
> > >
> > > We haven't got customer report on this, but there are quite some customers
> > > use cpuset to bind some specific memory nodes to a docker (You've helped
> > > us solve a OOM issue in such cases), so I think it's practical to respect
> > > the cpuset semantics as much as we can.
> >
> > Yes, it is definitely better to respect cpusets and all local memory
> > policies. There is no dispute there. The thing is whether this is really
> > worth it. How often would cpusets (or policies in general) go actively
> > against demotion nodes (i.e. exclude those nodes from their allowes node
> > mask)?
> >
> > I can imagine workloads which wouldn't like to get their memory demoted
> > for some reason but wouldn't it be more practical to tell that
> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> > policies explicitly?
> >
> > > Your concern about the expensive cost makes sense! Some raw ideas are:
> > > * if the shrink_folio_list is called by kswapd, the folios come from
> > >   the same per-memcg lruvec, so only one check is enough
> > > * if not from kswapd, like called form madvise or DAMON code, we can
> > >   save a memcg cache, and if the next folio's memcg is same as the
> > >   cache, we reuse its result. And due to the locality, the real
> > >   check is rarely performed.
> >
> > memcg is not the expensive part of the thing. You need to get from page
> > -> all vmas::vm_policy -> mm -> task::mempolicy
> 
> Yeah, on the same page with Michal. Figuring out mempolicy from page
> seems quite expensive and the correctness can't be guranteed since the
> mempolicy could be set per-thread and the mm->task depends on
> CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.

Yes, you are right. Our "working" psudo code for mem policy looks like
what Michal mentioned, and it can't work for all cases, but try to
enforce it whenever possible:

static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
		unsigned long addr, void *arg)
{
	bool *skip_demotion = arg;
	struct mempolicy *mpol;
	int nid, dnid;
	bool ret = true;

	mpol = __get_vma_policy(vma, addr);
	if (!mpol) {
		struct task_struct *task;
		if (vma->vm_mm)
			task = vma->vm_mm->owner;

		if (task) {
			mpol = get_task_policy(task);
			if (mpol)
				mpol_get(mpol);
		}
	}

	if (!mpol)
		return ret;

	if (mpol->mode != MPOL_BIND)
		goto put_exit;

	nid = folio_nid(folio);
	dnid = next_demotion_node(nid);
	if (!node_isset(dnid, mpol->nodes)) {
		*skip_demotion = true;
		ret = false;
	}

put_exit:
	mpol_put(mpol);
	return ret;
}
	
static unsigned int shrink_page_list(struct list_head *page_list,..)
{
	...

	bool skip_demotion = false;
	struct rmap_walk_control rwc = {
		.arg = &skip_demotion,
		.rmap_one = __check_mpol_demotion,
	};

	/* memory policy check */
	rmap_walk(folio, &rwc);
	if (skip_demotion)
		goto keep_locked;
}

And there seems to be no simple solution for getting the memory
policy from a page.

Thanks,
Feng

> >
> > --
> > Michal Hocko
> > SUSE Labs
> >
> 
