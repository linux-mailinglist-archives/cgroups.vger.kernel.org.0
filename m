Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9211D612EE5
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 03:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJaCTS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 22:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaCTR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 22:19:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB418B1C8;
        Sun, 30 Oct 2022 19:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667182755; x=1698718755;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MwdmFBghoqobBapJMV8vdjEtYXx44iK8DBj4tay9J4U=;
  b=B1r6/4sEOk3JQfhoETgxvfR1vN4lbLtX645Dwko/4906EtyqZ/mNLyGT
   cXhv0rQw076mvFh4lw8IqSkdCetYJZvxy+7aEGxpuxSLP566ZH7jcbRYq
   i5tecX7clEE6e/0Y2yhQE57MQwlAkrnIJi6ntzQUmf6FsR21tgy3MAT9x
   lLx09fUVCnkHC7wWFl9hKZzDdhe/Bn74UYXtuhByTfzEtwavUteoImtEU
   /l8U1nqSOuN9LpiHnBN/hSE7c+6+J9fXOABo0w766kTH9O8E+PZpXjhj/
   QovFGfnh3a6fSZMR1XL24HVbX/ASD8MIb3a7vTFRm/FpXBnf3MzX5T/hE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="310497258"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="310497258"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 19:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="696843058"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="696843058"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2022 19:19:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 30 Oct 2022 19:19:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 30 Oct 2022 19:19:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 30 Oct 2022 19:19:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA8KFV1YOZ4EQW5jyP+sZaNkNLdFWbPMjAu/uJQCv/61jjFMcekWN2Dcl/XKEZAc6S5v9kH2ISwOlTGXLBd4ejN9IA6mFAzhfo6APIqKSANnYJ61b2U6pnDJxzKyXDV218bFcGShx4zY6oTWAYSrlHqCRuflhbNPMGb6DFOuUQ5UKt9Zu0yeq5vosLGYP39t069K5Cnuz1p388jV1lp4f2kefduJIf7jxxX9cMgqjAAXxe577sThWpXHzscDgwyyYCajCA+HwiWE+1AFwvt3GVADHd22NqXu0NYeZQExIUe3a083ZZwxgn/UjS21BjFFVQikcGmg2CakqKzApsUleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUNEvzmhzR06JSunYW1/Lxh64MvYg+MwhbOBMmna18c=;
 b=V5/33T2wi/DSNCSaKVP4vgFq27iWZsY20Z46W6QNAM04O1AmxyaZ1OnSPPBVaWr2cpP03G2y8RsHJJZxIpbUqj50z+fADAhLOwio3DACO33oHO6rFG/YViO3cgqEI1rwSYcOd7FUS7/GoozK7ApN/oo8xQdoMdJy7vIkOsEvqhDGbnXmin06qeYOYXTDeuC7yGEvZVhByDQi4AwrA/tXmm4gqqjG/bkQJdNYgMc5oiQdCVbqd2IUt1uQHnabZUhAKBGwyy6CZawosQC8DeIg7AoenCVnNw5Mkq8cGq6n67/vTg8Moh2Wt2Ed6amJIQtmQ0XbgL2vlOuC1/et63irAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB6448.namprd11.prod.outlook.com (2603:10b6:8:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 02:19:11 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Mon, 31 Oct 2022
 02:19:11 +0000
Date:   Mon, 31 Oct 2022 10:19:02 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
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
Message-ID: <Y18wlvRE3jeKAhPC@feng-clx>
References: <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx>
 <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
 <Y1ovOeEPXT1fxCuc@feng-clx>
 <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
 <Y1tOigFZeDzjPGsv@feng-clx>
 <87y1t0ijbk.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkpO46yTiSVrKWRnABNW_PutuudEkB3RD-_YKxamW9SyaA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHbLzkpO46yTiSVrKWRnABNW_PutuudEkB3RD-_YKxamW9SyaA@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e009e09-02bf-4df5-6fab-08dabae64c1a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofrTGdw7IyV4brBxPgKJf3LZr85jtFR2d8KF7GooH4l14datfkrFtdzkaKAbGx6pjG6+MOvZWoITQdW8b6pyiwFoYGqACKHAfUWXDrl6eLui+FGCH+V6J3DR8ZRn7FUfiUQuxpjfxrxmBn5BEkPeXAhTZShuiYkJ0bdlIV79MVAZAK0Fo0fLQSDnRkrrXhtSp/Uz2Vl/U8tMAkC8JgiABXp7BnhKDO68RVLhLU14PkMPSc+h8/bBCcPeMDKylMuoAUsgT9uS96uR+rZaLimxrKA+IsBCNBu2bV8ULMC2noC/3MLEGOncVCoCol+coqwTu0TBk/KPyeBZvUZgFpFyma1PYvPwgbMvISBVANwukQWp163emoMAWTk78WRq8NJ+wk0kFZnXBqxQEkFj6xj0d2TzgT086urB3tW4YuPG4uphhDQj+3+nyXXkeaaT3IzVutepp44naE2OzcU2dB5Z9JrAYcb3kv4x9ZFSiLmnRwNhmAlJ8q5VyBOnNf9uZWbuoXZTVH/VmhwM045YWJ2Kahql0gmILSBEPkpnWbmnPL1rvVRnSQ74iTh1TscJYFZO4A/3vA1A2FbOeBYUhv1ryfu2cpnEzPutafo/l8vFmBUF994COAk2HIHbVC+A2XVdScRSr82zhe1uvjfgQ9gXGmUEbc+7BAVQf8XQ6b8ml0G3L6yYHfeqkneoCItEkGm4puEUHmt59vsxC62CJn8hIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(316002)(33716001)(54906003)(6916009)(186003)(53546011)(26005)(6512007)(38100700002)(4326008)(66556008)(86362001)(9686003)(2906002)(66946007)(44832011)(8936002)(8676002)(66476007)(82960400001)(41300700001)(6506007)(107886003)(6486002)(5660300002)(478600001)(6666004)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dgfFuhBu7BAycT4gyN2D8IO0yHfceTVVCEdze+51gx/s0+1mjPoW+YjFtyM1?=
 =?us-ascii?Q?BBgvpZpWad1pXOQXx+PQFAHzfiOj/l0LKZmIDJPT0JtBosAqhTY+433jVxI/?=
 =?us-ascii?Q?wASUxtWjTueOOLI/zvt9kq+locGPiv73Ghy1VoymtzyvUfmQo28oVFP3x0pS?=
 =?us-ascii?Q?aSM+Kru79Dd/CRokwr3G7mORqZgrHnTTTirBYAOH6j/4/CRVf1xOqc0ojMoL?=
 =?us-ascii?Q?4B6jLBpnMICMpsaHE2WoZnNLI064Cq8mZcqZRrSNAg3N24ibGBZUjE0Ptxx8?=
 =?us-ascii?Q?caD4JjIjDIB2h7O4kc1WyZu6OdXMSXZMpjdRfkatJV2MOn9uOZBN4mHg24fQ?=
 =?us-ascii?Q?jP36prB7l6tNPYfANoMBZC9nwL4LHO7akyooEQdBHGqW+trGApN++sObh5e0?=
 =?us-ascii?Q?7e/UzMXwBd534NkDkyYv1yUKKkdPNbODsxLzDednRfnSgQMgLBxaA0bx9g9J?=
 =?us-ascii?Q?bk6Oj2vW/o9xiSQ35UqR1LEhSGX7++ast59f2wB7u1QIdaz9+BHA2HdmugiH?=
 =?us-ascii?Q?xCnQOlW3pWXIVcRNOeQlqZotuZkxu3Q98kIIpHwsl/i3YliXBMKzZgPIpMHX?=
 =?us-ascii?Q?9zVUqW4xhKxt8BWEdMlZPN8fHgievcBbcfbbLFXdguO8DNTDPP9urbvaAqqr?=
 =?us-ascii?Q?DTUILKyD4WwrKZ7HGC7BIiWSRbTQhw4/jBRQqYdHZk15ii57sr07xLsjMdrd?=
 =?us-ascii?Q?4C7S7zrAd2LR0vLp5TblK2pehCWGADOeksc7qTuEm0a2YMyv2NjHtqquMHJj?=
 =?us-ascii?Q?RiLw+NYLeU1QRQ181ZPVv1Y/fZuTShh4wvFFDUVKoGhJCh2k5UbtYzhE+9YI?=
 =?us-ascii?Q?Gw83QaGseDTNeVzQqZBcSsOFqvR6awkuZF/VWsa+QoK8z4KXWelvb88glyJn?=
 =?us-ascii?Q?SaRXPTc2vt+T9pnByVWWNDHSd03KelRrdoXH07lw9/zyWUwbe+u3CQWYgp/U?=
 =?us-ascii?Q?QQAXV5MneNXU5XJal7KiB3Ox8NpsOSXdTXMxA7s/Ijt8UYcHQz0mWadrCr5k?=
 =?us-ascii?Q?De5ZetXHWTKtVYkcmtNr5WYcP7TbGIN+yMbOZVtCniAjxqiCX+Dtvld+vqDR?=
 =?us-ascii?Q?0egCAdEGFrWe5FanQX/EJt63BvPnSbJArauhgRAxSJzCMyY3nbjRKvK2W8RG?=
 =?us-ascii?Q?wS8xcjC6Cb4txKudyMj2+WVmnODiq0GkS6w57Gq9wg2y+PsDAn0hHw4MzEVQ?=
 =?us-ascii?Q?oOgAxXJ6eLQjDUOzeONGBSvPMzAOqibvEnZQboee1rfGGX1qFqw32YK0PIhm?=
 =?us-ascii?Q?FrdHKmGgZXL9oXr7ZyVbbBzLWtHL6rO4MBACDHBArT3wvC+h+XxPdCken3Fq?=
 =?us-ascii?Q?+f+LNPzSxdwDeJ91R9mPevsLt8Iy+uH4X7Cwh3kO+bzUuej9lTsdDGFRvqyW?=
 =?us-ascii?Q?Qs60PPcbgX8ReP5UK1t5O2vqp/k8oX/TtJdj4KxaZKdR7BaXtp6zWMOevHZA?=
 =?us-ascii?Q?rZ7v6fEGs6cF3BSh7GvY79HvO4Rs6emzox+Fgwwc1dizlSu64lQOjOHxUyFX?=
 =?us-ascii?Q?6AW9H0RTzPAk1U5MQ02en/Rp57NwxGc6vHkeIQGOBwVD9Pv+jnv1KzDueRQl?=
 =?us-ascii?Q?kGU1LzWcbmJjsIatF4DMSaLGeVilguJKpNmE/RF5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e009e09-02bf-4df5-6fab-08dabae64c1a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 02:19:11.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B61LqMv+z/scEwWybJhn2J4ETjM6devNjvJL3s3o1ZdhaqG7UMAYCxSZTp9/R/tsmj5WPH+x66kiOJnbv+JfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6448
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 29, 2022 at 01:23:53AM +0800, Yang Shi wrote:
> On Thu, Oct 27, 2022 at 10:55 PM Huang, Ying <ying.huang@intel.com> wrote:
> >
> > Feng Tang <feng.tang@intel.com> writes:
> >
> > > On Thu, Oct 27, 2022 at 10:55:58AM -0700, Yang Shi wrote:
> > >> On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
> > >> >
> > >> > On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
> > >> > > On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > >> > [...]
> > >> > > > > > This all can get quite expensive so the primary question is, does the
> > >> > > > > > existing behavior generates any real issues or is this more of an
> > >> > > > > > correctness exercise? I mean it certainly is not great to demote to an
> > >> > > > > > incompatible numa node but are there any reasonable configurations when
> > >> > > > > > the demotion target node is explicitly excluded from memory
> > >> > > > > > policy/cpuset?
> > >> > > > >
> > >> > > > > We haven't got customer report on this, but there are quite some customers
> > >> > > > > use cpuset to bind some specific memory nodes to a docker (You've helped
> > >> > > > > us solve a OOM issue in such cases), so I think it's practical to respect
> > >> > > > > the cpuset semantics as much as we can.
> > >> > > >
> > >> > > > Yes, it is definitely better to respect cpusets and all local memory
> > >> > > > policies. There is no dispute there. The thing is whether this is really
> > >> > > > worth it. How often would cpusets (or policies in general) go actively
> > >> > > > against demotion nodes (i.e. exclude those nodes from their allowes node
> > >> > > > mask)?
> > >> > > >
> > >> > > > I can imagine workloads which wouldn't like to get their memory demoted
> > >> > > > for some reason but wouldn't it be more practical to tell that
> > >> > > > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> > >> > > > policies explicitly?
> > >> > > >
> > >> > > > > Your concern about the expensive cost makes sense! Some raw ideas are:
> > >> > > > > * if the shrink_folio_list is called by kswapd, the folios come from
> > >> > > > >   the same per-memcg lruvec, so only one check is enough
> > >> > > > > * if not from kswapd, like called form madvise or DAMON code, we can
> > >> > > > >   save a memcg cache, and if the next folio's memcg is same as the
> > >> > > > >   cache, we reuse its result. And due to the locality, the real
> > >> > > > >   check is rarely performed.
> > >> > > >
> > >> > > > memcg is not the expensive part of the thing. You need to get from page
> > >> > > > -> all vmas::vm_policy -> mm -> task::mempolicy
> > >> > >
> > >> > > Yeah, on the same page with Michal. Figuring out mempolicy from page
> > >> > > seems quite expensive and the correctness can't be guranteed since the
> > >> > > mempolicy could be set per-thread and the mm->task depends on
> > >> > > CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
> > >> >
> > >> > Yes, you are right. Our "working" psudo code for mem policy looks like
> > >> > what Michal mentioned, and it can't work for all cases, but try to
> > >> > enforce it whenever possible:
> > >> >
> > >> > static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
> > >> >                 unsigned long addr, void *arg)
> > >> > {
> > >> >         bool *skip_demotion = arg;
> > >> >         struct mempolicy *mpol;
> > >> >         int nid, dnid;
> > >> >         bool ret = true;
> > >> >
> > >> >         mpol = __get_vma_policy(vma, addr);
> > >> >         if (!mpol) {
> > >> >                 struct task_struct *task;
> > >> >                 if (vma->vm_mm)
> > >> >                         task = vma->vm_mm->owner;
> > >>
> > >> But this task may not be the task you want IIUC. For example, the
> > >> process has two threads, A and B. They have different mempolicy. The
> > >> vmscan is trying to demote a page belonging to thread A, but the task
> > >> may point to thread B, so you actually get the wrong mempolicy IIUC.
> > >
> > > Yes, this is a valid concern! We don't have good solution for this.
> > > For memory policy, we may only handle the per-vma policy for now whose
> > > cost is relatively low, as a best-effort try.
> >
> > Yes.  The solution isn't perfect, especially for multiple-thread
> > processes with thread specific memory policy.  But the proposed code
> > above can support the most common cases at least, that is, run workload
> > with `numactl`.
> 
> Not only multi threads, but also may be broken for shared pages. When
> you do rmap walk, you may get multiple contradict mempolicy, which one
> would you like to obey?

In our test code, it follows the stricter policy, that if the rmap
walk meets a mempolicy disallowing the demotion, it will stop the walk
and return with 'skip_demotion' flag set.

Thanks,
Feng



