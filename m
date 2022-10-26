Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745E060DD06
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiJZI0v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 04:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJZI0u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 04:26:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B78A598A;
        Wed, 26 Oct 2022 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666772809; x=1698308809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P9ljhWs/6ea/3mP5C4ce0B5xNmKPWIO0VfpQwSzTbuU=;
  b=AcrDuYQRoT3tCvkjCxGn5k2ptEpJPobvyOyVPuI6Ev4vzBYUt6fQNVej
   fkedXdfhtca3oz8zglYSZUHiD2aHJvam/eTxGGlsfNj7dgwdsJT7EhWvh
   J8O2s6iUinO1a9PNuXxthhhWf5lPtyhCBlv48PGIyVejhlqmbCfeUzIsZ
   VNxW0Q3ETus1fP2ICyp4FnRe9yL8EweWC82J36zTbulpTzIr7arlEU02L
   3Bzwcnbqq0Ck0zq2q25tFiXluAinxxquFb69C0uFV15dqJLsyeun0bm4q
   2o/mFTSxti4vuR1BFvScYUBA1jEK5xlMp43dzbjkV7MNtLODfQ0xYglE1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="369958737"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="369958737"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 01:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="634411810"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="634411810"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2022 01:26:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 01:26:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 01:26:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 01:26:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 01:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyln3MQKseZg7VhfI4F7tZxZavpLARS/NXUBfbFaBqXuyW3A7T+/WTMHfzCNGv+42BEE6j7xMhvVkU/uCeQMlvA4Bp/dtbOHWCsIptq5BEFnL3xEEpM3i/MAJqNXO7xlS1u0vRluKxNTSKqmqy/lYJ4yshvuvpgP8xKcgEcpaSxXikMp7Tjgr3JfLjPOe/wb7v2Qt3Pr4hpB7vnTfXaJ/LS4CTqLS45/coiPEO6iyF5uUpzzgyxMYrALRG3cIGyN3Tv2tPSAxS0FxLPWXHG3ikAPnRQtsb6E49ZX9L3kID6ZaaNsCEvBTifaoUQuokEUyX8jCEDjzUWpT/pVKedDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUFQzrUCvpQXlIJhthKOM1lrL2HtB8ZBak9qrhj77/M=;
 b=KNMAp+eiKRKYcWAuARIuhfG8wpFS+wo6l4nrFhq3RNPyOQ/zcAg7xtfYpREKZN0Tx4SnRfLFc1KHf40laziwFyYkeGyRR8i4QBKaPlCBmQ3Ci5Xan7SNywF2u0mdoAZd3WXpaLRZZxUU/53k+72RVYuUioHMgcClX3N4ND+QuXk2TACusr/nEt1hFz40iTbvFJG4ipqm6dNXeAUz+OnNi6fv9tvFHjSsC7hpZOZpw/Gb0q4YWbTURWcGUzFUqAPRtcVZvkx88lWaTxeHMeacsRPlU+/GUoaz0Q/eaZSjU9RdDAHmk2tLLCZwFUdKL+04LmonIjuQfZ3IW6ssV1ueUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 08:26:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::982a:b36f:967f:257c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::982a:b36f:967f:257c%9]) with mapi id 15.20.5723.034; Wed, 26 Oct 2022
 08:26:38 +0000
Message-ID: <22f86189-76fa-61ab-4e80-9c2740ec8e8a@intel.com>
Date:   Wed, 26 Oct 2022 16:26:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Michal Hocko" <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>, <ying.huang@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dave.hansen@intel.com>,
        <tim.c.chen@intel.com>
References: <20221026074343.6517-1-feng.tang@intel.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20221026074343.6517-1-feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0822c7-3e4c-4b3d-fe92-08dab72bcd27
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfTXJvSkNHml4g54lzx/CA/PdC7QCXQpxxtoSfI18+VBCkOrzzza4W4pTT+zcqFZuT7PvqgL/UB4Fyvp7/4zNXstFBrK+yz/rOYOKwG+kIG06fb6YZi3bsUhVfpTowNwOkTwDqfnbKBdF4ovia0WC5MaEzaQHByPRFRqwwmnxdb6rTNshdlpjviX7qUjZSToC2hqeY9jNyjvaNWhQPv659/iVEvZXLOs0WbGOfbVUoU8vsElb2nQE9udQ7IdmK/cVqfW0fNNaO7DNXeNMbLJP0u2IM6WtsL3T5cXRb02ex9TXG4Iy7eUE0+n+QnwG67gLAmkkSj3WwEVj9KbrLu2355rJjAKgDyyj9KhMgl9/dT2XYyaKYpOoEDnb4ObmLpWtEJoJUuKL8fbTy22sHSAbcBEqDml7GYZvKjF3SR/gMKZdztR6VVs/Fs3GjsnWUug9kmOmlRiSGEPIxxO0gSGuGqtGBFvgC15ZtyY1ragyBX/U2Bdp7SFnBDONgjeZb7kkWqa309uuzsKFtjTd8JMIoAGhvHlwrINOyUSn8xoZrfU8CPx3COvhv+95coUuCPxsrJyIJE3rMDlUq60GrSsKDmGHd5N9rKp8J/lP0eoSZsP3KazaD2oKPhkiz1V5PPiKFI9gCcBjyR34OcvFZC7QmfTWNTDb89nUAFGo55m0zWag1ZBgyN3KcBGckG5BWC4TUYj7YSK/m4kCu5zH3LqISvK94Nzw89MtkgkXbw/3IvO/tvwHvTYlfgcv8V5qD/YAjlfLeGsQS9o+A66I3Wtyvl3/S3Pn1BhUnl0ctJAV+Z19Fep1sIVRArqubMQ80eE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(8676002)(82960400001)(36756003)(4326008)(478600001)(6486002)(8936002)(107886003)(83380400001)(6666004)(2906002)(316002)(921005)(6512007)(26005)(41300700001)(110136005)(38100700002)(31696002)(6506007)(86362001)(2616005)(31686004)(7416002)(5660300002)(186003)(53546011)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjFNK3NUZWJyYVpsNEFMOUpWdFFjVTV5QTlUMjlEc2l5STk1NklOaWxDNk01?=
 =?utf-8?B?c0owNmpPU0VqdndNdHJSNG01eThUeGFEbU0vZnlIdVMwSGxHNVF5R3IwRklu?=
 =?utf-8?B?UlpzNXhPSU1jSlR6U0hKZnJOMkcra2l4a1FYdWJGTXhCcVkvSUtCQkgxenE5?=
 =?utf-8?B?S2kxV1N2NzZlejdTSkZpT0JpcUpmQjB1QS9KRml6T0k0SjlSdHVNOUxaSkVG?=
 =?utf-8?B?cDZ0czRobS82bGsvbnpBekM3cHNWaGZnNUVvanFLY2xkUjI0QjBEK3BKTXN3?=
 =?utf-8?B?ek9wOE9ZVExVWktBNi80aTVOSXU5YnZIVGlxZDI3d01SZ01DdlZpdCtDSWRR?=
 =?utf-8?B?cFFVT3pLbVFmZDlrSFN3QndqYUJGZ3ljNkVTbG5XcFVuVHdNU1ltQU1jUnpF?=
 =?utf-8?B?WU5BbnVhR2VNWkl6dmRYRjNmVDk3V1ZWZVYyOXU2dmxnc1N5aklsMW90WXRr?=
 =?utf-8?B?NUNBb0g1VTdsVXhZaXRBRFRVUXVPanBqSVdHaWpCWXJSTjlFaXJGdWtEa1dV?=
 =?utf-8?B?YmN0SHdNK1JaY2U2T3gvREFVL2ZCZWJQcjNxcmNiNHJqcnJXQ2NtSlkrcm1s?=
 =?utf-8?B?Tmk1dlk2OXhMZU0vblA2aGZyQnFrek0rNXlCaUc5T1BjZWpPMVBVcmt6dmtp?=
 =?utf-8?B?Q3NCQldNZWNzeUEyNi9zanJtMU91ckh4U2JkbjVhUnBCWDNvODFxRzVvMHV1?=
 =?utf-8?B?Mk96UDc2MUcrSm02S1BiWmkyVCtGejFjcFhwbi9VRjhGK3ZaQXIvcHNyenFt?=
 =?utf-8?B?Z2puc1U4bzMvZTE3TlM2aXhrS1lZeUVIcTV5Sno1bXpyRk1LYTlUTkMvcEtv?=
 =?utf-8?B?aUIybGt3RUlRYmxzcHJ6UHpkZ0ZoWHF3NEJIaE1vWlQ3UCtrTXdBSWgycDBr?=
 =?utf-8?B?U0FqMjBYTVova21aekZieTdPRUFHWDY4b1l4R2x0MGV0WGxEZDM4dU45WENB?=
 =?utf-8?B?cWhubFY3YjEvWm5scm1LUXV1cEZRS21WRDdIMndKeDQzTVlySy9sM3B5cjRB?=
 =?utf-8?B?Mm5aaFIwVEpuTXJIdmZLOFBYN084YTdZc1ZYRmF5eEtLZjZaNC9mWjVCRTZx?=
 =?utf-8?B?aHJlRWErRXlMeFBaUmJzMGRZMUxwblB5eXdpQW1hL0N0eGFHam1rZEQ5UHYv?=
 =?utf-8?B?VjIzN3RRSlY4aHR0bVV2Y3dEWVdaVTk2aHBEMVhUUC9Id242M3hqN2R5SkdE?=
 =?utf-8?B?Q0l5UWx2ZCtuS1lSREQ5WWJ5aVhiaitWZXAwalc5Q2RqWXU1MGR5MWVULy90?=
 =?utf-8?B?YnMrQXBEdnY2U2dRaHJ2bnZzeS9qZnVDZlp4T1lRZWo3T1hOTU9BYnh4WnpW?=
 =?utf-8?B?WEZiZDZtcHdKUjJ4ZWF2YWFVUGVWc1c1b212UmZEK3RWZ2F3bUwxZjZzOXFV?=
 =?utf-8?B?Tm9YbEdGN01TQW5GZmZNaFdRWGdwL3ZrRm5xNmRTbm1lQ1ZFbmhtcVJVTk5s?=
 =?utf-8?B?RUJWdm12TzNpdmMyaUl3UHZUR3N5Y0grODBLVC9IdEIrbkZ6SFNrclBuZWhx?=
 =?utf-8?B?MEVVenVlb1BLVVVjc0htRzRVNlFzZitMZmlnSHQvWkVuQ2ZxbDVrOFFyOUZP?=
 =?utf-8?B?ZmhEZFpDZk8veVk4cFhnTE8xN1VSOHY5azlHM1I1Q1NndmNNNFdxSHg0Tk9U?=
 =?utf-8?B?K0loWGJ4SmRFSnFQODVVSWRMTVlJczlBUXZ6L0ZTajNwUkI1akJGNUY2UXlF?=
 =?utf-8?B?djd5bjl3cHBOWXd4Y1hXdU9DOUxKRStmUXlpcFpXeWY3TXBPQ05oOUpRVHFQ?=
 =?utf-8?B?eHpibGVHYzVnVDFoSzQ4Q0cvZlJ1UXVyMWQwZnpjY1Q5UkYza2RhbHFqZjln?=
 =?utf-8?B?NDg1dnJSMEd5Ti9iSTgrSUFYUUJtbFgyK0QyUzlMOXNETmFSU29PU01IR0RN?=
 =?utf-8?B?VHBsSDlwQ1puR3FWOE94MS9DeVJ6VndMUEthdmhVK2piSGRoK0tMdm9ZV0p4?=
 =?utf-8?B?MFhHWkNDRGgvQkxCTk43Mld1eWs2czhVSDAzNEI1TEtRcTJBMHBZdUJxSWQr?=
 =?utf-8?B?N0I3aUZYNzFvVlhxNDJHUzVCNmVOYVZRbEJZMnNzUWdpd2hwOTNVNUE5K05N?=
 =?utf-8?B?UVhGbDUzUWlsalFnajUrRHVVN1R6akNwREwrSjZRSDN0aFZkek42UTBOcFFm?=
 =?utf-8?Q?oxTZMw/AySPm6gGNa3iv67tAc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0822c7-3e4c-4b3d-fe92-08dab72bcd27
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:26:38.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiGk3YeMcxKD/kjsaNUiCLzl0uXVoJxa1NmRZFINlebJ2nrWimI2rwnUZsXJ//oEp/IuqQZJrZhI0ObgT1AbyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7408
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Feng,

On 10/26/2022 3:43 PM, Feng Tang wrote:
> In page reclaim path, memory could be demoted from faster memory tier
> to slower memory tier. Currently, there is no check about cpuset's
> memory policy, that even if the target demotion node is not allowd
> by cpuset, the demotion will still happen, which breaks the cpuset
> semantics.
> 
> So add cpuset policy check in the demotion path and skip demotion
> if the demotion targets are not allowed by cpuset.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Hi reviewers,
> 
> For easy bisectable, I combined the cpuset change and mm change
> in one patch, if you prefer to separate them, I can turn it into
> 2 patches.
> 
> Thanks,
> Feng
> 
>  include/linux/cpuset.h |  6 ++++++
>  kernel/cgroup/cpuset.c | 29 +++++++++++++++++++++++++++++
>  mm/vmscan.c            | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d58e0476ee8e..6fcce2bd2631 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -178,6 +178,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>  	task_unlock(current);
>  }
>  
> +extern void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> +						nodemask_t *nmask);
>  #else /* !CONFIG_CPUSETS */
>  
>  static inline bool cpusets_enabled(void) { return false; }
> @@ -299,6 +301,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>  	return false;
>  }
>  
> +static inline void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> +						nodemask_t *nmask)
> +{
> +}
>  #endif /* !CONFIG_CPUSETS */
>  
>  #endif /* _LINUX_CPUSET_H */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3ea2e836e93e..cbb118c0502f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3750,6 +3750,35 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
>  	return mask;
>  }
>  
> +/*
> + * Retrieve the allowed memory nodemask for a cgroup.
> + *
> + * Set *nmask to cpuset's effective allowed nodemask for cgroup v2,
> + * and NODE_MASK_ALL (means no constraint) for cgroup v1 where there
> + * is no guaranteed association from a cgroup to a cpuset.
> + */
> +void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup, nodemask_t *nmask)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *cs;
> +
> +	if (!is_in_v2_mode()) {
> +		*nmask = NODE_MASK_ALL;
> +		return;
> +	}
> +
> +	rcu_read_lock();
> +	css = cgroup_e_css(cgroup, &cpuset_cgrp_subsys);
> +	if (css) {
> +		css_get(css);
> +		cs = css_cs(css);
> +		*nmask = cs->effective_mems;
> +		css_put(css);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * cpuset_nodemask_valid_mems_allowed - check nodemask vs. current mems_allowed
>   * @nodemask: the nodemask to be checked
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 18f6497994ec..c205d98283bc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1537,9 +1537,21 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
>  {
>  	struct page *target_page;
>  	nodemask_t *allowed_mask;
> -	struct migration_target_control *mtc;
> +	struct migration_target_control *mtc = (void *)private;
>  
> -	mtc = (struct migration_target_control *)private;
> +#if IS_ENABLED(CONFIG_MEMCG) && IS_ENABLED(CONFIG_CPUSETS)
> +	struct mem_cgroup *memcg;
> +	nodemask_t cpuset_nmask;
> +
> +	memcg = page_memcg(page);
> +	cpuset_get_allowed_mem_nodes(memcg->css.cgroup, &cpuset_nmask);
> +
> +	if (!node_isset(mtc->nid, cpuset_nmask)) {
> +		if (mtc->nmask)
> +			nodes_and(*mtc->nmask, *mtc->nmask, cpuset_nmask);
> +		return alloc_migration_target(page, (unsigned long)mtc);
> +	}
> +#endif
>  
>  	allowed_mask = mtc->nmask;
>  	/*
> @@ -1649,6 +1661,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		enum folio_references references = FOLIOREF_RECLAIM;
>  		bool dirty, writeback;
>  		unsigned int nr_pages;
> +		bool skip_this_demotion = false;
>  
>  		cond_resched();
>  
> @@ -1658,6 +1671,22 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		if (!folio_trylock(folio))
>  			goto keep;
>  
> +#if IS_ENABLED(CONFIG_MEMCG) && IS_ENABLED(CONFIG_CPUSETS)
> +		if (do_demote_pass) {
> +			struct mem_cgroup *memcg;
> +			nodemask_t nmask, nmask1;
> +
> +			node_get_allowed_targets(pgdat, &nmask);
> +			memcg = folio_memcg(folio);
> +			if (memcg)
Doesn't check memcg in the change to alloc_demote_page(). What's the difference here?

> +				cpuset_get_allowed_mem_nodes(memcg->css.cgroup,
> +								&nmask1);
> +
> +			if (!nodes_intersects(nmask, nmask1))
If memcg is NULL, nmask1 will have an uninitialized value. Thanks.

Regards
Yin, Fengwei

> +				skip_this_demotion = true;
> +		}
> +#endif
> +
>  		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
>  
>  		nr_pages = folio_nr_pages(folio);
> @@ -1799,7 +1828,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		 * Before reclaiming the folio, try to relocate
>  		 * its contents to another node.
>  		 */
> -		if (do_demote_pass &&
> +		if (do_demote_pass && !skip_this_demotion &&
>  		    (thp_migration_supported() || !folio_test_large(folio))) {
>  			list_add(&folio->lru, &demote_folios);
>  			folio_unlock(folio);
