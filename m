Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643467D2809
	for <lists+cgroups@lfdr.de>; Mon, 23 Oct 2023 03:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjJWBeo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 22 Oct 2023 21:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjJWBen (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 22 Oct 2023 21:34:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3EC114;
        Sun, 22 Oct 2023 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698024880; x=1729560880;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wosFIAbG88UlMRFAmd1nOyQWoKJ7if7tiLwxbLNkGVg=;
  b=BJ/Ts/hQcpnfJt+bUzpcJoeSjC3PopxyJhCbUCNZDW7/sAaiYmdU5oyT
   WMnIKInchN+JTDW7v5UZb1vK73neapJUyOd04s5N/HQ5kXRulqsjKPZJl
   Htgd38NiuVqCU5ElSPAfz/dEfiJk/lvs+7qJ32eLb4JONczFF/enORyF/
   XHpjRQAR/8fSwYSuSrxsH00UHoYBt/y3gphkPDZ4acTdixql04De+2Lqp
   2yslu5cJiUCBsM+MkgwMyEvUGfH1wb27DH9ij2oHEeb51gYwD365vLU7E
   QM3V45xkJ+pvWzk+n2RdyXrLAS3+GvirXbuEJXDvQBUD28RJzCjNlFC8c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="472959513"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="472959513"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 18:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5909423"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2023 18:34:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:34:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:34:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 22 Oct 2023 18:34:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 22 Oct 2023 18:34:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9dSyP1I1VSDTlk2ZdS/gESjFYXf88p71ocqc1VLpWHmljAwQCZbsP45u0ETWGuWoTC8SuAVBw1LaHsnqIY0d8ZXBWX/028OCK9oExuSLOXEBfThb3IEt/x6g0W87PUA05xuDgU7OiGq1qkHx160d6vPfysWNXyfdZPTOxSd2klh3CCe07ayr6YDIxVJCwwmRsqyiu9f6cU+Z+Hxi+up7748gGMwnDq/kPz0hAAOzWIRNWqCRqFWv/9ViLaJV5D7nV3A1iPubL9CZtrIj6H5ETppX55A3MY40s+naFl4A0W5+14UfDyYDZtKhTsh2q6FkVESj7ECNJAwcsAyZQCB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUq9end3n/+EmJy9sS5lyEjEsa0JIbxbTMorlNJ+HXY=;
 b=nsnWi/AlKPy9ak3G+moDnsxGna9SHR1HlzWwkW6Nyb4UsxzrqIRJ2lg7sSdk21PNbd/ggKwOCwJflv6DTmYfWn2ZqIx5LqIZxOfJ4lx0sKKE+mjYDIaYbGkK48AKUyiFbQS8nEEvasGgOmvNfkmSpo5Na+fQXmfJhtVC8Eb0e97cNlQNKgxNPAee8qstKXzpBebivR+Ul+6v8IncuXUdsgqh5lh6Em92z/O164nFEFr6j5X3fHv6HOJHsGmNaCqUAapBH7q6A36boQzQT1fa/14sYsH0HfaNcJuRLTMrArNsW5ThEVHTKIz0eZj3LNu22hx1/7slY9q4oQqDcyDIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB6746.namprd11.prod.outlook.com (2603:10b6:510:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 23 Oct
 2023 01:34:31 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::24ce:9f48:bce:5ade%6]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 01:34:30 +0000
Date:   Mon, 23 Oct 2023 09:25:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Michal Hocko" <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <ZTXLeAAI1chMamkU@feng-clx>
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com>
 <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
 <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: c69c9c30-d005-45a5-9a28-08dbd36833a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJoja/VyXCnDCorWqIROeDudhuajvdpKTJw6icSZ2mdkZDe0QuxDxdMDWcMb93YfjdRa4q0egkRjuSNgW91U7tSFD0mYfHXEWgNZFLb7xNvkFvVSa38D6fnrzzpdlHVfu90wVJgXHBX3y1m2jcaV7HXJZaIT8mvgIoFH8wPHgKooeHP565F6nCWi2mjdzzha4Jn9dzcYleManf89Eo9mbNiVjY+LvRjSEE7eIEW51De4z7HfIwxhsD7LD8RLYwi6O8fJ8pEMSZkKZ7adgs1fsy3gos8n04i672QeZoX+w3bqlgbFaKt0vxoRVbfNctsh3/CpCS5MzYJrXU78TbE94XuC9bcxLKItYajbaY0pI96bVf+nauVXjsKhWaXikpA0nN7POi3t8B3EC6KxhnKUYnWxhot1Elykh48AnE9YfZ6236c7ISYO9KNu2oePb7blYKLyI8oCIDNvv2xfns9fp4Y8QahJ79KUkW6Vl8BIx7TbDpDOTyPRtmOnokU5naYwKH1MLOOdHbzsHJvdWEDCZrcPxFyflF2UOUDbSQcH+p4Qihk7QV5sgry8wcdxVu/1VW5d3pPZ3opxyNlH2QVm5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(7416002)(26005)(54906003)(478600001)(6506007)(9686003)(53546011)(6666004)(4326008)(5660300002)(66556008)(6916009)(66476007)(41300700001)(66946007)(38100700002)(83380400001)(2906002)(8676002)(316002)(82960400001)(6486002)(8936002)(966005)(86362001)(33716001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0FLdjhqL2pIRG9RdzZEVnpYZ1cxY3A3T0xPUVBEcDlrS0xtU296Zmc1UDFU?=
 =?utf-8?B?SnZpN096T1NJazluVFFRTk82d3dueWtadUMwN29kTDFOblJXT00zVndYaUQr?=
 =?utf-8?B?SW9aZDBCeU90V2lUWFhnWm1GWExZazFsNEV4WEVpTkEvelNrQUdSSUJTNWdK?=
 =?utf-8?B?VTNqREgzNm1wY1N1Y0JwSnJUR0hsRE9QZVo3K1ZBN1k1REV3aW9qTnBsTktY?=
 =?utf-8?B?Q3R3VXVnQURhSHFJMDY2MW1qTy9tNnRFSzJjRkl0VXg5czZLc1NveUVOOUZi?=
 =?utf-8?B?RW5WQW9QdTNJYlIzbC9zMW1pN0FqR3A1VFZPU3NIcERqdlhiaXB3a3IybGtx?=
 =?utf-8?B?QUxpTmF5MUpCY3lWTHYvZm9lME1nc1FsL1E0ZnlDVHo5ZGVhZHRFZG93djlJ?=
 =?utf-8?B?SUdFNmRVWlhhSmw2Q2l1MHpSTTROU2NtMk82U0FaYldTMVJxYzFQZXNZbHNB?=
 =?utf-8?B?MzFLUTFEd0NIeTlBem1iVGFRcTlZeHhkVW5jbFlOUVlpcnRMUXlSSXZqdFZ6?=
 =?utf-8?B?ck5iUWEwYmxXcmhwNWdzbHAxRXZlTmk5cTNsd0NNSnE4UFc3OW9lMnFwQVdY?=
 =?utf-8?B?Tkt2V1MyUFRjRmM2VTlqUG5DRSs3VEM1NEhYUUtRdTZRQ2wza09HbzhkYzZS?=
 =?utf-8?B?djNnbHliVi9JQkFiemx4dU1MOTNWbE44MkkxczhqcU84a0Z5SHhjZE9QVE9m?=
 =?utf-8?B?UmV4T3gvdVpVVkFTR1k2WlIxdTJPbWJYaUJPbS8yMDRRZnRPaXludmVOU2g3?=
 =?utf-8?B?MFZWaHZ5YkJ1NWVjM0ZyZndCcmVReCs2OGhIVTUvTmVlN2s5bXgwQUFBSXR3?=
 =?utf-8?B?dVZOSTdhQ2xUZW8wOE4yN2laNktDeDVjOGVSRTRDdnBVYWMyUWtCYXlucGRO?=
 =?utf-8?B?OGFvT0g4QjZlbE1lUktTMEhQUUNnRE1DZ0R1QU5UQWRQNHdaTW4wMTNMOU01?=
 =?utf-8?B?Zk5KbTU5NHNwOUJ0Y3JBOHVCZTlTUzZqdkI1dXV3YWkwQlAzN2UrU1pLckMy?=
 =?utf-8?B?V2ZoUC9vSkhvZnlBTG1BRkJoeG8yY2ZTVFdXU2pQZFFDMjlRYWVzMFkvWWxC?=
 =?utf-8?B?YVg5Q2VsL0RxR1Z1ZjN2U0xRc1ZzUGpYZ0ZTOU83Rlk2RFJqRDNGVERYcVls?=
 =?utf-8?B?eitBMnVNNjZOVXk4SWl3aGw0dktWalVkcGw1ZXQrUnJvWW1sbWJaK3Z2YUNp?=
 =?utf-8?B?bFhiSjF3WTRqZDA1aXlzYUtSaXhQZWNLa0ZrQnNMMXFhWmtkQm9MdDczaVhs?=
 =?utf-8?B?OElnY2VEbmJVc0JPdjdFVXRVVk1HTXo5VkpVOFo1QkZVSGpZQjNBbzZLOVR6?=
 =?utf-8?B?TjB4cG82WVBwcWNhK0ZRU2duRHZkd0JjMnYzbEU4ODJxWkVTT3F2RFl4UnZX?=
 =?utf-8?B?UHppVkhjNDd6TFZHNk0xQ1RTSFZVM1NTSHQ4V1NRelJyY0tGbGJIVHBTYWlF?=
 =?utf-8?B?UlE1ZVl2SmdmTjNlQ0NjQVFwOFNSQTErUW5aUnN5REcrWDI3VzJvcUxXcnY1?=
 =?utf-8?B?eTFrNGdGbVlOb3ordUZZdzJIc1dORjdqV0N6eHJybmoxR3RkdXJXREErL0JZ?=
 =?utf-8?B?UjhBcml0TVlueWxTaGs2ejlSQjIwVXBrNS85SEh4UXpoNkg2NjJaaHlObkpV?=
 =?utf-8?B?OG5BdlVXTTJiQXpMeDlMT245VTkvampldUZYQ2RZcVZnUHFPQndyN3hSUEp6?=
 =?utf-8?B?anpNeGsvdlB5MnZZQWxCcDJYRnROQ2x4S0lQUUFOQmh4M095cFNxbzJ6WGc3?=
 =?utf-8?B?bkdhcUdxMzlkTHAxR1l3ZkNIRGtwU2JrenRVZnVaTEQ3WGdWRllwRnJyYlpG?=
 =?utf-8?B?cVNJVC8xU3ozZXRnMjVjcnVrSlVFZXlRWnJaL1pyYno5NS94aVUxNzlVZDdD?=
 =?utf-8?B?Y3ZJRXllMDBwbHc0WnZ1OEF5RWVQZzYvMm5JSllNeG5Fek9Kdkh2dE9ncytY?=
 =?utf-8?B?dzIzbEVaMndvRm5vUXdud1A2cFljWmY4NUVHQkpHR1Q3VUl2aG10aFNwVUY4?=
 =?utf-8?B?ZklxOWRkT1NZUjZFbHB3YnhGQi9QV205UHB2RzZZR3NvdUNrM0dESGFoOFBw?=
 =?utf-8?B?cWVzTjEydkcwUDRFeWVkUXRuRGpqcEt0b09HNVplRi9pVEVMOGcydDI2R0gv?=
 =?utf-8?Q?nQtfcTT50By9YwLygW9dag+bd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c69c9c30-d005-45a5-9a28-08dbd36833a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 01:34:30.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjfLaqO8ldqQcPm4CTEPRH+iHRZ52LLpAt5+h/IMfyWhCDB6jt8dJUaFLoM1Ig/4P77COtR+NTpE0RSLDruP7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6746
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 21, 2023 at 01:42:58AM +0800, Yosry Ahmed wrote:
> On Fri, Oct 20, 2023 at 10:23 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Fri, Oct 20, 2023 at 9:18 AM kernel test robot <oliver.sang@intel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed a -25.8% regression of will-it-scale.per_thread_ops on:
> > >
> > >
> > > commit: 51d74c18a9c61e7ee33bc90b522dd7f6e5b80bb5 ("[PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231010-112257
> > > base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> > > patch link: https://lore.kernel.org/all/20231010032117.1577496-4-yosryahmed@google.com/
> > > patch subject: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
> > >
> > > testcase: will-it-scale
> > > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > > parameters:
> > >
> > >         nr_task: 100%
> > >         mode: thread
> > >         test: fallocate1
> > >         cpufreq_governor: performance
> > >
> > >
> > > In addition to that, the commit also has significant impact on the following tests:
> > >
> > > +------------------+---------------------------------------------------------------+
> > > | testcase: change | will-it-scale: will-it-scale.per_thread_ops -30.0% regression |
> > > | test machine     | 104 threads 2 sockets (Skylake) with 192G memory              |
> > > | test parameters  | cpufreq_governor=performance                                  |
> > > |                  | mode=thread                                                   |
> > > |                  | nr_task=50%                                                   |
> > > |                  | test=fallocate1                                               |
> > > +------------------+---------------------------------------------------------------+
> > >
> >
> > Yosry, I don't think 25% to 30% regression can be ignored. Unless
> > there is a quick fix, IMO this series should be skipped for the
> > upcoming kernel open window.
> 
> I am currently looking into it. It's reasonable to skip the next merge
> window if a quick fix isn't found soon.
> 
> I am surprised by the size of the regression given the following:
>       1.12 ą  5%      +1.4        2.50 ą  2%
> perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
> 
> IIUC we are only spending 1% more time in __mod_memcg_lruvec_state().

Yes, this is kind of confusing. And we have seen similar cases before,
espcially for micro benchmark like will-it-scale, stressng, netperf
etc, the change to those functions in hot path was greatly amplified
in the final benchmark score.

In a netperf case, https://lore.kernel.org/lkml/20220619150456.GB34471@xsang-OptiPlex-9020/
the affected functions have around 10% change in perf's cpu-cycles,
and trigger 69% regression. IIRC, micro benchmarks are very sensitive
to those statistics update, like memcg's and vmstat.

Thanks,
Feng
