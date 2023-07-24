Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25C875FF8D
	for <lists+cgroups@lfdr.de>; Mon, 24 Jul 2023 21:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGXTJb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jul 2023 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTJa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jul 2023 15:09:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45490F3;
        Mon, 24 Jul 2023 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690225768; x=1721761768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=raqKCCoVJKlq3uyn2RAKtsEI5VbNdMaGUoxBW9/RV1s=;
  b=dQKrD33WeA+foSm0iMCGvT2urf5I/KjwSOrLBQQXwf/oBF7q1QIEJ6Jv
   D1xOnwBXTmMNbg/5BJac0WdFId/rBw5v/wKuSurIqxUfwGIqWZasTtfRE
   sY5t6ZxbGV9To0/BJeJwPhRRKI/aWGAlpNPaBSayughyfE181W04n93Bv
   HHolJADtfkax9taENyhHdDQTWYN0L6O5VuiLxnlNQ+hw41zDKGtY959J5
   2OU20v6tjVGxNRoLwNzUmOA+Fzw8M3kVLHJjl5Dnk5C3cv9657xeiBKec
   pWtd5PSJTb00fbdG6Mpu/ynBuhA3hYE6+IV7z8nwZLB33eu4T2Zh06ARH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="352426767"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="352426767"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 12:09:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="815937687"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815937687"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 12:09:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 12:09:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 12:09:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 12:09:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UynGNcXOYxvk6AhFfuxRoj8MVMDp/7rdNeIJzMCqXZ3mhib9p7Ya2ATlQmyAWUaSw0IGs51Zaq7hewaa6sUhwynkvwxvQVqSLB6F3i8qv01jENiRdrx21WBqil944pjLE+tqTCVkcqxEapwZiwPBb6/+b9951O/XJ7EITs32O6kK3khyj97NEouziHrjNc3z6WXueEQDiKXXZHfFEbh0PRylam6tARLa332cvFF96RuGVtPjcT0ZWEbIMF4qURZD0OpiTaiwIZxMk8Tqx+gaFWLjGh4NTmjohe0ShZhqMb/BAfuPkoi7jJ2Uow7FCA3IZWH9GGmY+jwPZ+EaRZOD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSKZ1VXI7ohH1iXNMbPNijZ20mrL7+yaPz+Fk9BhXCs=;
 b=jDdYs2ynHqiBHl6KfCvlSv9KwJBB7GKB9DCH99XgNzbGq6fgijM6i1XSnF74WO5fqOaXPABXwHwZ1AbsfzOJ8cxEAK8XhKktZ0PrFgNlMJKJ0eNBbiMAbxoeS2GtwTImps4+IV9BztvrJ/ftz6KYs6K37hTn5F4Uhl/jrCKTKi9o4w0AOL39Mk6GX83uSJ4Bdt6MoYCbdlm+BkKegZ4sGIkgbrJxAQguhTMwBa4tyRLoq3ttp6E2xxkm5L+uj9wxZJ5gqjzjK5L4+Yn9+Xe1lEAZiSPHt3P7neBqfC4f20P/MTNPHBKoxMW7chfyeNEYZlEUilOpeV89WGYjZRaBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 19:09:24 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::1245:3110:f511:6f00]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::1245:3110:f511:6f00%6]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 19:09:23 +0000
Message-ID: <6bedc9fe-88b5-8382-aa65-ded66b58aa2c@intel.com>
Date:   Mon, 24 Jul 2023 12:09:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/28] Add Cgroup support for SGX EPC memory
To:     Haitao Huang <haitao.huang@linux.intel.com>, <jarkko@kernel.org>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, X86-kernel <x86@kernel.org>
CC:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230712230202.47929-1-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfa86f6-8f2d-493c-bec0-08db8c797d92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lf3rZSazeB6AHAHZkv8whE7o1TffVPBNKm9W5z9dwoqTa3eatXO7JsDRyqcBi1VjtBjbu1rYvOHszYquB4QQ5TaCuXUij9Z7rLp93BM/ZsxGRuCULiFBqs9NtSTKBksQ9mq3fo7IDU2LfG67xIS2rJvbgCm3Q2zQaUaKqkmAYjvy6RjWn5IPr2tzZ7Xyxu8CrWrBEv7fRNs7TTdP5jj0jZKyEDNPkH8pfYfNDQeNMsdUCoCY76BA8u1Ef1YBMthdKYOppwIxrQPAAE2r//PVnieolheN3+PpbWj3S9BQrLDdiIGRTbFB67+uw6DF6+iN7oY6R+v55HAs7wI38MsL5yEKYvZqOxI+L2e3VtBCjcj0ZRJnmukL4vBms01qdq0oZOexND9MIv50k3XIwcigbR15c8M9iwzyKeVv4EVOsuqgEiNll04C58NUnb84BZ8pR0JwKMlr1L1mQ/Cjmg5n41BEY4pTIpEpXu1ExaBGs3JCdn0Ahcb3aqA73Is32ju53KmVTSu2YFnrjCEDXAMCioUts/cnHOqFW5xrSP0T7TYYrMzG65Ij+01flq1uO8TWoeQgjcAerF+22kGv+XmJmZ9j6MC7aAzVnzzzReD1DzpsaU8zYUqW50nXSj6gH8ZiuUXT8ZthvtePTnLDpyj9CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(31686004)(6486002)(6512007)(478600001)(110136005)(86362001)(31696002)(4744005)(44832011)(2906002)(2616005)(186003)(53546011)(26005)(6506007)(316002)(82960400001)(36756003)(38100700002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(8676002)(8936002)(66946007)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm8xaEt1TVdrbUVyYUtGaDRMZjdsUVV1TVpyWmVGeTM3cS9DczViNk9xd0Zr?=
 =?utf-8?B?RnY1NVF2K2xZamRTdUVTTFF2VDJIUEtiS24rZ2V0ZDVVRGFxeGtnT1Y3eWs4?=
 =?utf-8?B?Q1NLZ0x6OXVaWUpqdnhhU3FLd21BT0k0UFB5QVdxUTZjK0xaUk82L2dPSmhK?=
 =?utf-8?B?MDM3NldJZ2g5a0RwajRrTUVTU3l6QldEU1RlemVmdXZqSXhYU0dsMDhRYmtZ?=
 =?utf-8?B?aXBiWEJHUmdWZzdsai9rSXhwTDBnRksyblg0M1FLOXJJRitnVzQyRzIyMXlp?=
 =?utf-8?B?ZUQ0cEJxSVlJL2FVb1FURENEbTJOWitEN3pNb3JQVGNVbURpT2l3QWwrRVdH?=
 =?utf-8?B?aUxaWHFGT1Y0bm1NRzBXbUkyRVYxcWxQWGJuK1ZkcEVUTUdHWW03bTl2bFBF?=
 =?utf-8?B?RHdwckxtWHBBQ1dSYUlMWFYxcHMvTGxkWW9JZk54Y29RYWw5TFhKY2Fybkxv?=
 =?utf-8?B?V1ZHMFBESTdveGloTlBYSEpWVXV6T2MvZ0F0Y0hsbFM1bC84MEVubVVyR1J5?=
 =?utf-8?B?SG5WWGJWeWV5QTk2ZlVwMmdXU0YwRTNlSDVBQzhHTkZtUnRwNFlJZkt0cmtp?=
 =?utf-8?B?VkpET3FCNVVCMFJmcWRRa0xXTGprS2ZnY3c4aWNqS0FPVkM5U3lsc0IvM0FR?=
 =?utf-8?B?bGMvMGV4NU1HTGZYMHd3TWhBZGJPVVpyTU5lQzcxOEdLZWJQUFh6QVpvOEI1?=
 =?utf-8?B?eFhBZHl3QzRBalp3ZTltWHFuaTZQcUdVRCtwTzRwOE0wSTBUbXJlOUlxN1JX?=
 =?utf-8?B?Q3pHNGp0WFNlNWhvTDFxdFBsTGNpZlA0eTZEUFZ2Sm56Zk9pNTlsTklhZ3VR?=
 =?utf-8?B?NkVCeDhNQmRrVEtId0NBcUM5UUtmYU0xRHdiN0tiVHlraVNsc2E5ZFRBOFZl?=
 =?utf-8?B?aGtVb1hrSGRPZm9PTFB5NmZnN2xadXVDQjVlbGU3blZFMHdFRTNFeVd3ZWF2?=
 =?utf-8?B?VzlRM2JEaVNaTWxpaGQ2THZnek1xTmRMdmFKd0VQd0FWNklRRTB5dFRNRURq?=
 =?utf-8?B?QThIOElGZmhMTlFBN1pLNEFRUnBXYzNPaXpzTlFla3RRQytRNndrWmdHOEx3?=
 =?utf-8?B?bWlzRGlhTGwrOWc4NUVTaWNXY3hqdDBYTEw2eGtyRFJVeSt2czNVOGRnclFT?=
 =?utf-8?B?ZXpqMmdlSFIrREdxNEVjNGZONUowKzZoSXB4Wjg1TnBMUE9JU1B1WFMzNDB0?=
 =?utf-8?B?bG0vTXdHbWsybXZzb3lKZFNMQXRqRXY4WXk4dzNBNzROYlhpbDhJN3VlSE5V?=
 =?utf-8?B?NUpkZ0V6WDBxaXBUNWR0MmhhSDVXZ0ppT0xpekpnY0hLQnJ4dURqMVozSnJL?=
 =?utf-8?B?ZXBENStUMDNCNnpXYW5XVG5VT2lLZndnQzRBbUF1bUpjdWRjQTAwSEQ3b21D?=
 =?utf-8?B?Zm4zN2R6M3ZFUm5BM3hVRTlEZWx6ekg0bithOXJKMUlnOFZJOTZiWFYwUkRa?=
 =?utf-8?B?V1VGcnZTV1FXcEc1Ni95YWN0Q2tHeUFoNGN5ajVENE51Y3NUbzBwdlJrYlBH?=
 =?utf-8?B?cmptRUJiVmN5WFNnclZ3MEk2bDE3VURBZGdGVlEvUlRRdFNGYzV1eFU0L0Nw?=
 =?utf-8?B?U0ZyWFY2T3FUNjdUaXdxeFRwTEs4NDdjTHNQcGRMcm5qREV3dlMvcE5mdDJR?=
 =?utf-8?B?VUQ4VWVReTZybXcwZmoyVFZjdm9aSlZ1YzdoMnVxbitjSzltMU9ZNXIxbUt4?=
 =?utf-8?B?RFFmaFMzR0FmL0ZlcFBQM1JUSW1aQzZNVGdONXl3NENxQ3R6Wm1KbllpbEtS?=
 =?utf-8?B?K3lDc3FBVUFRZEhqd1d1NmtvNllSaUtUanM5bUV1bXY3R3BJSTBLZWd2U0o0?=
 =?utf-8?B?di8zaUN0SWxEOVpSTWJIZGF0a1BKQ0NxTnY2VmZlZWdDb0FMSEdNZVNSY05J?=
 =?utf-8?B?bjhHTENSK2JhQXg5Um95Y1RUS1BlREhaMXE1QkVqN1BjSHc3VkVWTi9QZUtX?=
 =?utf-8?B?bkpHNHJwdVRSTWt1Rk9qRFhZRGN0R2t0bXhVM1ZkSTV3MGJHUnk4Y3RhYWYy?=
 =?utf-8?B?bXVFNjF4Slp1QjZMSXZLeWJTcnJBVVQ0akFnUFk4a3ppQVhHakpQejJzR2Jr?=
 =?utf-8?B?cUtqMEZ2eEVmOThkdG9BVzRLNm8zVFJFeVp1S1NSOEV0elZvVXV5SHZDNldU?=
 =?utf-8?Q?BdDjDpMWu5+B5lfHsS9U3RJD5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfa86f6-8f2d-493c-bec0-08db8c797d92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:09:23.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJrUscQgCNvd+VXE/HvWNtB9W0s2gi6KmckfMRtJpUqlQXMbWNUvhY1oRzqAOqR4Pch493fqVtPTOJjS4uYbUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6864
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Haitao,

On 7/12/2023 4:01 PM, Haitao Huang wrote:

> I appreciate your comments and feedback.
> 

Nit: You missed emailing the cover letter to x86@kernel.org. I think a
few other people included in the individual patches are also missing in
the cover letter.

In general, it might be useful to keep the email list consistent across
the cover letter and the individual patches.

-Sohil
