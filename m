Return-Path: <cgroups+bounces-596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F357FAFBB
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 02:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309681C20A57
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 01:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FA1869;
	Tue, 28 Nov 2023 01:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaS8+ydL"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50CBD4B;
	Mon, 27 Nov 2023 17:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701135963; x=1732671963;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/HFqoqm0i7LSGu042/FEnbVNgWchAtyqdoGSWGKsLrM=;
  b=FaS8+ydLV+XH2qgRq4+y2qF+7XNoHT626bU9Y3MibDuCAhx6pbO3YF5j
   wuLvbUVv6GBAYV99Q86Wkh+LtppnypiizUhJPCjE0rzWybjlhzjTfu0lA
   5H7YjDpd/5WkBVtH5+/yRku9cRZOIS3USxl99xgMD4WiKiNHgqWgvSJlJ
   75OA0rcuL9DoqgMe779st8RqzT1LIFPX4VR32cZUFzrxWDSa2/Ea7fwHy
   VLnh/P/xWKi2qQ61YqAGwc3wKAkjDEuilMFOlT9UIWlAcdlUjFy+xQi9m
   Ep/7HN+xUgAc+DTvsgKDytX433t5njWMXX4x1AdLB0XJfUkyKvlN0e5GC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372201649"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="372201649"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 17:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="912280912"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="912280912"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 17:46:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 17:46:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 17:46:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 17:46:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPhzf+uXeueU31G6KOv0+ScdDVS1XkdRiDA0zKLkCr0U0Lrcp8f0dC0f0YtpfyVon6N9Zrt9Anlqw408hyrqG5/Vk/zPezPasDFA4VO9y34evGeFsj4gYKFXimbG/KF84rJQt5cl7qGoArSlcFtAzHGmZPqBMT4JxIVlhb8tkjis6TvmP2siv58RitnDgorGtR7bY8kOrx+rphIyYDgolmdjhk3LK/oWaC16+BrOV7B42nWPiqzxoy61/9PVEDIdLfHWj9Ugi0OdywAaCOm93I3Ql0z7vzK/5MLT2OrZV+BvBi3G6LFNdH1WVZLP5fUK0b9Myi5niV8YQ0K33ynYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsiwYbVWHThpHxGH/ZdsxwfIcwymL9jOGWWYBydh/mg=;
 b=fd9ntJ+qvWdsUPeH0hl3AtjsgSqDJDrUOLVi/0X7qAOAF7hmMvPX4aWi6PJihYmngN0LkkSjXUM9BzYC8P39FV/dx8m3AyxASkKpoExu8f5osdrpFzbgr+FwqU2LpmeJQqL9SqZ7y3lpgjMEJZzfpXw/a0/Prvbf5H0MClAJhuavJr26SEvEWuTENyIyQdaDSpNkr8vtm2rjagLOlNzALL4RbBihLi1Z5jdUs26ReD4O+eF1nVUwW8k8KieaDw6xyxfQZqyPyB3h0/Kh/pjM8/ZY7/rSff6x0UGw73iyERANjA6TFpXOBkALg3T4YMYuphhG/ESeSXCgetP7g8mHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB7005.namprd11.prod.outlook.com (2603:10b6:303:22e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 01:46:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 01:46:00 +0000
Date: Tue, 28 Nov 2023 09:45:47 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, Muchun Song
	<muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo
	<tj@kernel.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, "Waiman
 Long" <longman@redhat.com>, <kernel-team@cloudflare.com>, Wei Xu
	<weixugc@google.com>, Greg Thelen <gthelen@google.com>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <ZWVGS2rNgueGH8uU@xsang-OptiPlex-9020>
References: <20231116022411.2250072-4-yosryahmed@google.com>
 <202311221542.973f16ad-oliver.sang@intel.com>
 <CAJD7tkYnn6CxSJdo0QJ1hc6cFY_qWLuJ0=S6g_Pm=GBV+Ss-jw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYnn6CxSJdo0QJ1hc6cFY_qWLuJ0=S6g_Pm=GBV+Ss-jw@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: e90d6e89-0dcb-44d7-243c-08dbefb3c5b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQinupkmoHxAhq14+oOhcvPDy6THcdrDxXGomPXZHhIYbXWcWrQv1b/LBQHDl7xJrTyyGPFppDoCIi259vXaamGftIyExBfKoVNeeMYWCm7wVevPnGZwqXoIZMZrIo8iVarwiK10jVIaTCRJYVrwzeq4Ur6ykIUmhQ4r+U1SAhrbUOY01RFi7ZhcQME2yfBS7lvx2QYdeoIuvD+khUqfXArshXWDqGV2LdpHBMZAe2dwdZD6c8FVbo/x1NXI8UCJAdXo4nOhNmVmrL/s/j1Dl2yaS7bf5zv7qujpEPfCe5ww4kNBroFBYYAIM0HG1iRUrLD14njz6ySfQURbuLvY/5zclcU+A0CaD1HiCg/e7S3707QqVZWYuAkXrO8RvWAguO4RMKaEAJxrYkurW7c2tZVuGNUltYvObliccnFIye4Gbcj9hC2XOgZb/iKg0MojmxdzNCNmj8mavBms5PxbfSJ5gouCccLLgJLj6VGhu2MkndbSCq1ny8tNKsKLAtIu0bbcs5Bsp43Gtx9Hi7a2gYPTkVOL31xIviI3RJq0OqFNaw1qp0RR44HAFMDODhb9njODDpyKfPUfyX73ruDrgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(54906003)(82960400001)(38100700002)(86362001)(83380400001)(107886003)(26005)(6486002)(6666004)(6506007)(9686003)(6512007)(53546011)(966005)(316002)(7416002)(2906002)(6916009)(33716001)(478600001)(5660300002)(8676002)(4326008)(41300700001)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWp1bnlUMnFVSjN4cG9kbnpBZFF1aU5tWjJ4MWozck5YVGlLUWgwUk93SUth?=
 =?utf-8?B?dlRpa0UvZ1E0UXBiakJ3R21TVXp0TUNlK0lxOEYwWStnUC8xTDF1U1V3TmRo?=
 =?utf-8?B?N2VnTjdXV25sSEZNeTU1U0gvQ281YitnQWhWWE94SURJaDdZc3FpK3RQek15?=
 =?utf-8?B?YWg3MjJYSEU3QjlsS0VoMFR0bkVzUEdqTTlxOERienFCVWlGVGJrdHBwRVJu?=
 =?utf-8?B?aFBpbDAreGlrV3kvelNSYU9xenJiclYyR3hhRWRxckFxQVNVc1MyUWIxaFJj?=
 =?utf-8?B?NjNIdmJjUy9pYVYvdWxubVo1RmpNcXYyMHlFOTF2V1Fvd3dPZWFzVk0zV2FC?=
 =?utf-8?B?R2ZIYWFidVZHeDhuaUNqTDlyYmxjZDhraXVPclA2QmtBWUhiMVZjVnhkL01J?=
 =?utf-8?B?ZFg3WXQ1d2t3dmVoU1ZGWWZmVjVWQUVIZ1FNaExkRTFxZGE1UkZaNkoxZ0g5?=
 =?utf-8?B?MzlXQlVCeHQxblArRDhOZ3ViVC9vajhhK2JPdmZSNlRQd3h2QTA5VmY0ZG1O?=
 =?utf-8?B?emh6M0poQVVnRUhLdnFDTnNnVHQ5MkZhR09iK1VXWmFMcmIzb1orNW9UYTlX?=
 =?utf-8?B?WEI5K05wZEI4UHgyWmdYSUlvSGV0N3IzT001TWtWRlhXVldlN3BOTW9lOWZy?=
 =?utf-8?B?aE13WkxuczRHRkw3VUdSNFpEazcxdkFhbjE5M3lMQUEyT1ZkVC9BMWFySS9j?=
 =?utf-8?B?R3BCaVNxSnV2MVVRdWRJL2taOTN4TkJXNnBIT25pVnJMMnVZcG80VDgwcGVT?=
 =?utf-8?B?dmx5ZjVReWFnYmxCREY4WkdBdlJGeGw4U3FNMi9ac1VtZjZlb3BvQU95a1pz?=
 =?utf-8?B?ZFQvc2crVS9wLzNoK3UxQ0ZUenNxaUJoUHRqQXNaOWhORm5LMHlReXZVS045?=
 =?utf-8?B?dFF0RnBjWks2cUhsTTM3cE8vOUJTQmF1cWtCYXRtSC9tUVNSRFk5VnhwbVBU?=
 =?utf-8?B?MGRxZFR1Q1BDR01iOHR1NzdjM2JaRVVCNGJoalZ0ekFmSVdzVVlmTlRGeTFJ?=
 =?utf-8?B?WnJVWUIrOGUwMGNLZ0RaVW9Sd2pHWmsyMEZlTlZRa0Zick56UklPUVZ4L2hV?=
 =?utf-8?B?cDdYZXdpQXRkMmtiL2pwY0M0Z21wYm1qK3h4ZTdSYkl6eXc3bDNCTWVucUU0?=
 =?utf-8?B?ellZVWVrcHlmRlp5MWdTMXdrY0lEY0lEUWNyOXAvS0pTZTkvTVp5bllLR2FG?=
 =?utf-8?B?ajZQc1FJQ0VrcjhHV2N4SURkNFdCZGFFUUVmZG5RTW11OGxVaTRwNEorY1pJ?=
 =?utf-8?B?Uk5IUGdZM1FBOVRTS1ExUEpIVzJ6VDVJRDk4amZ6OE45ejNPTzRjakxPZXlY?=
 =?utf-8?B?SlR3cnBxamhYRExySjF4OUpYUnZaMGdpZFR0eEJKVDlwUHQ0YkorSFRtYjNk?=
 =?utf-8?B?eHRWWVJ4SlJzRVBvZkg1Zk5PeC8rOUJaSFJRczFDam9tMVdMRXhGcWpBNnZ3?=
 =?utf-8?B?NEM2T29CQjVOdVkxWVhGMWlqYkUwdURVWWVLNVVuZytQODZ4eGdtK0dwQVN6?=
 =?utf-8?B?U3dSM1gwblM2LzV0ajU1ck1nYnptMldISXNTSm94VUdFQ2MrSGdPZXh6NVNU?=
 =?utf-8?B?eTFZcWJYenptZ0lWbkR0ZjAzY29BeCtRU2tWbUw0N1Q0a1U2cG9nbWZqdjFH?=
 =?utf-8?B?ZmxEN1IxY3dOS2FRVW9sSUYrYUlWc2tEK0xwM0hSTUNFUEs5eTNyU0ZXeUo3?=
 =?utf-8?B?clI4RHJGS1hrVzdXTnIzamlsd2RISEtKYVVxNUZGcTBQdXhwdGsyQjduYkNy?=
 =?utf-8?B?dklmMHJQbG91K2FpRlpaUUtaVUFPUUNycDBicW4va1ovb1BRNmxpQlZ3aW8x?=
 =?utf-8?B?WUxKWDNmU25CWE5sY1VUUWxFZ3g3RndjSnB1emtEMlI4REFESkRKbDhrM0Ra?=
 =?utf-8?B?T0pXUVNXSDVlYTJYcCtPU2pRQ2ladXd3YkRsSU9KQXkxT3I4MjE3SEgrOVhr?=
 =?utf-8?B?NS9ZUEJEMkVRS3ZBaTlETzdQMUdrS1BkaUNhdkJ3NXp4QjlLSVkvSlJ3c09z?=
 =?utf-8?B?MENLeEVjK2duU1VNdmtKcDlpZU00cDhHY2lWc3o0T04zRlg5TXJ1YnkreThK?=
 =?utf-8?B?d1ovcy9KYnBTNGtNSXNIZ2VEdVRtNlBtRVhGTzg3Y1RpNjdsSGpQbThDb0c0?=
 =?utf-8?B?YzM0K3VJaytNQUlPajJxV0JoMVZOTm8zMjhOck1mMDlmR0NmZFhnUlhsMUF1?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e90d6e89-0dcb-44d7-243c-08dbefb3c5b4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 01:45:59.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZRUh/W+CoAzY6WeZwj1rYKupV/j4ezOD3See93pUkTfX6LowhxPM9fX7QsexGk4SmmPsjtE6lVqvYrsxn+KPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7005
X-OriginatorOrg: intel.com

hi, Yosry Ahmed,

On Mon, Nov 27, 2023 at 01:13:44PM -0800, Yosry Ahmed wrote:
> On Wed, Nov 22, 2023 at 5:54 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed a -30.2% regression of will-it-scale.per_thread_ops on:
> >
> >
> > commit: c7fbfc7b4e089c4a9b292b1973a42a5761c1342f ("[PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg")
> > url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231116-103300
> > base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> > patch link: https://lore.kernel.org/all/20231116022411.2250072-4-yosryahmed@google.com/
> > patch subject: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg
> >
> > testcase: will-it-scale
> > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > parameters:
> >
> >         nr_task: 50%
> >         mode: thread
> >         test: fallocate2
> >         cpufreq_governor: performance
> >
> >
> 
> This regression was also reported in v2, and I explicitly mention it
> in the cover letter here:
> https://lore.kernel.org/lkml/20231116022411.2250072-1-yosryahmed@google.com/

got it. this also reminds us to read cover letter for a patch set in the
future. Thanks!

> 
> In a nutshell, I think this microbenchmark regression does not
> represent real workloads. On the other hand, there are demonstrated
> benefits on real workloads from this series in terms of stats reading
> time.
> 

ok, if there are future versions of this patch, or when it is merged, we will
ignore similar results.

just a small question, since we focus on microbenchmark, if we found other
regression (or improvement) on tests other than will-it-scale::fallocate,
do you want us to send report or just ignore them, either?

