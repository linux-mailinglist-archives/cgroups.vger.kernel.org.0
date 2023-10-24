Return-Path: <cgroups+bounces-9-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8087D47CD
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 08:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9101F21562
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC712B80;
	Tue, 24 Oct 2023 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPR4zGXi"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551166FCB
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:56:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF69FD;
	Mon, 23 Oct 2023 23:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698130612; x=1729666612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XjUA7FOIZbX4F51s7cPA++WLh9WTaMTngI/3uRtcjP0=;
  b=OPR4zGXiUsRo5qvqkkGmyOYKv88iikv0xGyq5R+CdnBfsXAD6e+p2s4N
   sw8/fhCcezHdLEA/gB5nhdBC2RTyWpvLSDZT8TSpEmdLlv7wnPAtciTpD
   iVullzCk9uLPKVww4rqNvbkPyzKCXDQgzbMOgkmK7UZw6FfGE+oBCmHbN
   rK0bHggwz5YiLG/uhDsVQwIDaln2iWfN1FDizSyIg3M62Vtloq5/ve3Hn
   6Drw4npBs7x4GbkSC2vh6zxEGWUSYBP+cSG9X29rBwVNWLgcC5XFiazF6
   n5m6l3x/wqt/jQZmwdaQKOAq2UXS1qEIg0A9uN1yAfszkaU/R1cMRJOZJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="367227455"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="367227455"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751901424"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="751901424"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 23:56:51 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 23:56:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 23:56:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 23:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUkrXuuJYwFQ7Oil36Nr9IlsGaqXoC8OY4o2G2UZfpxSAEQuyuZWBbEZFC+NukvTYLIGmbj39n6oECmFyfGAkwN9hphFXKBMGsCzKISpquiydZ07rr5UsdxaaGLfntC7hOOl4VkcLGeSIjVwVGMYkcW6iVn+hdMKBoYjObDTD3w0Q+98FtgV6NJubC1NSBZ2jRpXVUID5bc4m+QnT52cxIDqJ8/lqqEvJv3Q1+6+5RTeC2m0FR2zfGof+lwT8VUVza+zAijJ/aafrKLISY+iYQfBZGvV6LCGQB6H/euos8isr3l9iknGAMbCV7bAvcCUSlWnT2uHL5K50QxqMrQz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBoIgowfT276QZ2omitJoFtm9bJBLWP5o4MoqPgdk10=;
 b=nS8RfF7BxmrMsama2bmmcjyiwT7LfL27B6aTeJwxDp6GXRtWxIHkPOKIKkQXhkL385SvDA7F5uRHFmvF5+OHsXDiDkFNgLeX4NAFuotHca28UTCa27jsnApsw1H8OSRK0KSLfcIv5OoELP6C+DIRR989iTTQNXLiuQVMgAY6UrvZ/puX0Qs/VdTHVMeSRSz5SSAgD7MU5r1TDfqpehYKhz2ZTj43Tq06XkBpT7PHO8TDkrUlaXZ0ZWiKIKrTd89xiKz7I2LwKJHIBz3xgnB24/o7RrHiL3ilxeeORXSToUktzoRYBUYyDLVfj79Zs8D2+SivrVPcr6G9KR8V/UhCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 24 Oct
 2023 06:56:49 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 06:56:49 +0000
Date: Tue, 24 Oct 2023 14:56:37 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Feng Tang <feng.tang@intel.com>, Shakeel Butt <shakeelb@google.com>,
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Huang, Ying" <ying.huang@intel.com>, "Yin, Fengwei"
	<fengwei.yin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
	Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, Michal
 =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Waiman Long
	<longman@redhat.com>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>, Wei Xu <weixugc@google.com>, Greg Thelen
	<gthelen@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <ZTdqpcDFVHhFwWMc@xsang-OptiPlex-9020>
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com>
 <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
 <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
 <ZTXLeAAI1chMamkU@feng-clx>
 <CAJD7tka5UnHBz=eX1LtynAjJ+O_oredMKBBL3kFNfG7PHjuMCw@mail.gmail.com>
 <CAJD7tkYXJ3vcGvteNH98tB_C7OTo718XSxL=mFsUa7kO8vzFzA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJD7tkYXJ3vcGvteNH98tB_C7OTo718XSxL=mFsUa7kO8vzFzA@mail.gmail.com>
X-ClientProxiedBy: KL1PR0401CA0032.apcprd04.prod.outlook.com
 (2603:1096:820:e::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CY5PR11MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 67964464-cedd-4126-c81d-08dbd45e64a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24ejq4G8EOgIqeRL6YTUT2m0HKeU0UVZa4V6bHaRqo8cBtMLDm6sfRwZtcNnOaCQmc9G+vqLFRoJcLjZgBf4TJRj+NdJYNWEjqS74VaDX2Sk8pOzMGsH1TuCeR0I1ykKgssGLxG5meNbuMbhsFl+YUvKiy3FfH6IhC8Rv+AiaTjN7H85xwFSUT6bAzwxk3cKtQSvqp0KZ7nY+2NY1h+ZxLyZNP/+tJrT/wyNjlGKLyNGyHYyIOKb9F9wI8CkafrD0MZK6w4bjjrWrG6XnOOLA0/hF5kgVm3H0wrg3elzbh2HqvBahVqIuaayor27myzk53w2uy0e3H51OZEpj0/1tw3CgWwGqA+pqb6QGbeCSKOVpTx0I/8GEPs80aGKlfZsdol+1CZ7jEL7Iq+egv6pU+y5o3GUF7mbPOWga4U7SJ/Qe9jbp6oA307gf+/BV5vBz+E/NVRukJA/coydO6wCv5dzslgkNJUHhudCo3nQJueEEYxs+qGEsfCKjOjhXFQB5bqapf/SbHfgwiFy/u3ov3kpT6VivMIAcj2122Ap07ZGFrNxj6InyargccXVhF55
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6512007)(7416002)(2906002)(5660300002)(9686003)(44832011)(4326008)(6666004)(8676002)(33716001)(41300700001)(54906003)(6916009)(66556008)(66476007)(478600001)(66946007)(38100700002)(6486002)(8936002)(83380400001)(6506007)(316002)(107886003)(82960400001)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v51oYAur7FFQn1Kf+WHgoFPykBSNwH8+u5jry3HCcbe1GxfYcUK/wbEg4T5d?=
 =?us-ascii?Q?+6JJ6sa+i1AJLvuiisayAwHjZIp8KXajqNQMuenp8Az9dfouMPBqdN8nM0JT?=
 =?us-ascii?Q?w7YDI/qwtfuRir+JpIQkR1SxSFgBTTKxoUUAWm5wErFnqsPbEFYDjISgED32?=
 =?us-ascii?Q?lLKWmSk4AxUzTxbo9tEXk/4UGPJteRHWsRw9Dy1G/Iiz/xDmO/SaMEZk/Iv5?=
 =?us-ascii?Q?9OXcyhNg6+n1zLWQEFeJBHReiIOCM/YZHY0cgzVwuTvlCeKeLV/RDR+Pvw3e?=
 =?us-ascii?Q?CPCIskX1WRus4aCOGusvmHJBFDaqEEeAM8y80nehHsl36/AdxATStLSZkA5l?=
 =?us-ascii?Q?uSbQzF2FcagxewieVwKBP1TApTlK1K+L4fPzyR5Eh7IoXZOPNNg9qFxy8Ros?=
 =?us-ascii?Q?vQtHBTEMt/CDKSoRYQHO21L5yLUZZPvaCJcXdcx91DivIGzg6q3Au3erDRpf?=
 =?us-ascii?Q?60oZ5pBteHWVDgNRBi9YR2qrZRe9zbev+Qq5mjeRlWawcf/ezPMtBAnuGmON?=
 =?us-ascii?Q?K3UzXt/SKtzTXUFIU6LzcVzaPy0noKonuM05Poms9CX9Sp1KYNwgJh10Juke?=
 =?us-ascii?Q?jKUhsmntBHO4MMhjXAD85hu1/He/2VFgLotMRkKWY3b46Ybb7aFtvDZ8XqWS?=
 =?us-ascii?Q?6pj7m+J7zLXP/09CT65X06W7vBz2wNOJv3yJ9jXjzxzr1Ywh5CQoagFSAL0w?=
 =?us-ascii?Q?J+m+Ze7rtE05GUigSXwZYe2qOixesnfO8oBJFkUIp6PPNKYpKKDyr8Cn0TyI?=
 =?us-ascii?Q?7CtDlb1L6oZ/6yOqGFS+i8MMoSjVpcfnwvIZ6cukb9Um1mGBtLKrecgHYbMQ?=
 =?us-ascii?Q?Hlo/fQ1Oh+1ibVb7JqHh6JrDcqLTkkOKa511TC0eU1m039ikmiThnhIM90gf?=
 =?us-ascii?Q?J+tSmkhWEdYthQh4QxKF2XINCyLj2Ge30O5DkWrTl8mbgpaiDaQs2G7a9J7V?=
 =?us-ascii?Q?IDgxjQ6IlB5TgARQ+N3E+5hMxFAw07IOWGNi3XbUuV+9VxYY+im//Lu2rw2X?=
 =?us-ascii?Q?7TUx/SjmGCRyJu5qUYUemS/NdPlV8UhXO+LZKmthhBxZWZRuCSA193idY3Jl?=
 =?us-ascii?Q?9GzaxFFVToffT0KmBPbtIgE6gIttZU5FJ2rP2X+Uh+XleNLKfn2dtCwAT1Yg?=
 =?us-ascii?Q?YpbOw6HNGP8UdYkvmAAD/G2e7YCwbSs2WRsMYrO0STfQ3DtK4uS1FNwhEwWz?=
 =?us-ascii?Q?RkGJGhbHHRlN3ptOTyau/H/3TIgXUFoW5Hlxzd/bXbLq61wyrRzlB3s5ETpP?=
 =?us-ascii?Q?XKL0rNAY6KNaRDAag8ggz/zj8IuEQ6rBmuiAniDo5eZNFarBGDeJbyrR4PxL?=
 =?us-ascii?Q?kItfwAQxix7KVUzyqI5lvnNDkceuv+6oH+q2w3cRQ38aWkuaUQts9sU5COxn?=
 =?us-ascii?Q?ZgWJsVabNwXxXA16Cq6rMac38wj4r1Qd6FzVOCAAoM67qckxEaipUPQcY21E?=
 =?us-ascii?Q?yQuyU+/Fv5yDvYqKz0hZ5jDQ2rcBKFdte8QJ44hWvyiIhUEEiygzOEJ2z4Ru?=
 =?us-ascii?Q?JifB4nwe1mDrp3xXiLifkU2g+b70h9XgWhe7ufAn17c1aH/RzQ9Jw8QlXKXR?=
 =?us-ascii?Q?pobt1OtDLN2JNYuBWhzddmZ1VKGDI68HK829Wpkt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67964464-cedd-4126-c81d-08dbd45e64a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 06:56:49.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHhDdeDRc/etKMUwyAOp44mt1k6W13y+WNKrHD8ABFnlDkH3RdcY4vDgg+l9TcKK+VHOdFiOYcdkwX7tIdhGWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com

hi, Yosry Ahmed,

On Mon, Oct 23, 2023 at 07:13:50PM -0700, Yosry Ahmed wrote:

...

> 
> I still could not run the benchmark, but I used a version of
> fallocate1.c that does 1 million iterations. I ran 100 in parallel.
> This showed ~13% regression with the patch, so not the same as the
> will-it-scale version, but it could be an indicator.
> 
> With that, I did not see any improvement with the fixlet above or
> ___cacheline_aligned_in_smp. So you can scratch that.
> 
> I did, however, see some improvement with reducing the indirection
> layers by moving stats_updates directly into struct mem_cgroup. The
> regression in my manual testing went down to 9%. Still not great, but
> I am wondering how this reflects on the benchmark. If you're able to
> test it that would be great, the diff is below. Meanwhile I am still
> looking for other improvements that can be made.

we applied previous patch-set as below:

c5f50d8b23c79 (linux-review/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231010-112257) mm: memcg: restore subtree stats flushing
ac8a48ba9e1ca mm: workingset: move the stats flush into workingset_test_recent()
51d74c18a9c61 mm: memcg: make stats flushing threshold per-memcg
130617edc1cd1 mm: memcg: move vmstats structs definition above flushing code
26d0ee342efc6 mm: memcg: change flush_next_time to flush_last_time
25478183883e6 Merge branch 'mm-nonmm-unstable' into mm-everything   <---- the base our tool picked for the patch set

I tried to apply below patch to either 51d74c18a9c61 or c5f50d8b23c79,
but failed. could you guide how to apply this patch?
Thanks

> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f64ac140083e..b4dfcd8b9cc1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -270,6 +270,9 @@ struct mem_cgroup {
> 
>         CACHELINE_PADDING(_pad1_);
> 
> +       /* Stats updates since the last flush */
> +       atomic64_t              stats_updates;
> +
>         /* memory.stat */
>         struct memcg_vmstats    *vmstats;
> 
> @@ -309,6 +312,7 @@ struct mem_cgroup {
>         atomic_t                moving_account;
>         struct task_struct      *move_lock_task;
> 
> +       unsigned int __percpu *stats_updates_percpu;
>         struct memcg_vmstats_percpu __percpu *vmstats_percpu;
> 
>  #ifdef CONFIG_CGROUP_WRITEBACK
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7cbc7d94eb65..e5d2f3d4d874 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -627,9 +627,6 @@ struct memcg_vmstats_percpu {
>         /* Cgroup1: threshold notifications & softlimit tree updates */
>         unsigned long           nr_page_events;
>         unsigned long           targets[MEM_CGROUP_NTARGETS];
> -
> -       /* Stats updates since the last flush */
> -       unsigned int            stats_updates;
>  };
> 
>  struct memcg_vmstats {
> @@ -644,9 +641,6 @@ struct memcg_vmstats {
>         /* Pending child counts during tree propagation */
>         long                    state_pending[MEMCG_NR_STAT];
>         unsigned long           events_pending[NR_MEMCG_EVENTS];
> -
> -       /* Stats updates since the last flush */
> -       atomic64_t              stats_updates;
>  };
> 
>  /*
> @@ -695,14 +689,14 @@ static void memcg_stats_unlock(void)
> 
>  static bool memcg_should_flush_stats(struct mem_cgroup *memcg)
>  {
> -       return atomic64_read(&memcg->vmstats->stats_updates) >
> +       return atomic64_read(&memcg->stats_updates) >
>                 MEMCG_CHARGE_BATCH * num_online_cpus();
>  }
> 
>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  {
>         int cpu = smp_processor_id();
> -       unsigned int x;
> +       unsigned int *stats_updates_percpu;
> 
>         if (!val)
>                 return;
> @@ -710,10 +704,10 @@ static inline void memcg_rstat_updated(struct
> mem_cgroup *memcg, int val)
>         cgroup_rstat_updated(memcg->css.cgroup, cpu);
> 
>         for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> -               x = __this_cpu_add_return(memcg->vmstats_percpu->stats_updates,
> -                                         abs(val));
> +               stats_updates_percpu =
> this_cpu_ptr(memcg->stats_updates_percpu);
> 
> -               if (x < MEMCG_CHARGE_BATCH)
> +               *stats_updates_percpu += abs(val);
> +               if (*stats_updates_percpu < MEMCG_CHARGE_BATCH)
>                         continue;
> 
>                 /*
> @@ -721,8 +715,8 @@ static inline void memcg_rstat_updated(struct
> mem_cgroup *memcg, int val)
>                  * redundant. Avoid the overhead of the atomic update.
>                  */
>                 if (!memcg_should_flush_stats(memcg))
> -                       atomic64_add(x, &memcg->vmstats->stats_updates);
> -               __this_cpu_write(memcg->vmstats_percpu->stats_updates, 0);
> +                       atomic64_add(*stats_updates_percpu,
> &memcg->stats_updates);
> +               *stats_updates_percpu = 0;
>         }
>  }
> 
> @@ -5467,6 +5461,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
>                 free_mem_cgroup_per_node_info(memcg, node);
>         kfree(memcg->vmstats);
>         free_percpu(memcg->vmstats_percpu);
> +       free_percpu(memcg->stats_updates_percpu);
>         kfree(memcg);
>  }
> 
> @@ -5504,6 +5499,11 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>         if (!memcg->vmstats_percpu)
>                 goto fail;
> 
> +       memcg->stats_updates_percpu = alloc_percpu_gfp(unsigned int,
> +                                                      GFP_KERNEL_ACCOUNT);
> +       if (!memcg->stats_updates_percpu)
> +               goto fail;
> +
>         for_each_node(node)
>                 if (alloc_mem_cgroup_per_node_info(memcg, node))
>                         goto fail;
> @@ -5735,10 +5735,12 @@ static void mem_cgroup_css_rstat_flush(struct
> cgroup_subsys_state *css, int cpu)
>         struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>         struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>         struct memcg_vmstats_percpu *statc;
> +       int *stats_updates_percpu;
>         long delta, delta_cpu, v;
>         int i, nid;
> 
>         statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> +       stats_updates_percpu = per_cpu_ptr(memcg->stats_updates_percpu, cpu);
> 
>         for (i = 0; i < MEMCG_NR_STAT; i++) {
>                 /*
> @@ -5826,10 +5828,10 @@ static void mem_cgroup_css_rstat_flush(struct
> cgroup_subsys_state *css, int cpu)
>                         }
>                 }
>         }
> -       statc->stats_updates = 0;
> +       *stats_updates_percpu = 0;
>         /* We are in a per-cpu loop here, only do the atomic write once */
> -       if (atomic64_read(&memcg->vmstats->stats_updates))
> -               atomic64_set(&memcg->vmstats->stats_updates, 0);
> +       if (atomic64_read(&memcg->stats_updates))
> +               atomic64_set(&memcg->stats_updates, 0);
>  }
> 
>  #ifdef CONFIG_MMU
> 

