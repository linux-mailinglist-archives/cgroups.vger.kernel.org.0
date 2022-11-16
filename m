Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6FE62B055
	for <lists+cgroups@lfdr.de>; Wed, 16 Nov 2022 02:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiKPBAa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Nov 2022 20:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKPBA2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Nov 2022 20:00:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009CE22B0E;
        Tue, 15 Nov 2022 17:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668560427; x=1700096427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QXTMzqqZDlGjkoTzfjYcmLuBmOWujGrc3tQIGgZRAH0=;
  b=Lb3Xp391zDwO8OZW7Wf6CZeqXEXhghkaAUu70amTgAQDChrxksIAJczf
   wJr3qJjYXxX89XA1u5S9wYCkRZ+WUnAmOh8QgInn0PjYA1Ca6Ppyq6lUk
   izjP7ZtCsii4vdB9Ge5QEjcePH/cJtmMGwRNxKY4CjVfmrlnBjTvoMyPw
   7ax0rzvX04VJPb0GPMzdt3WWmzPxd3p2OVU5duASm+JdcWb6TYs1jrdvb
   D0edoCMpsUPrGDmhHpkoEYtQfT1rBSNEt9rlGIEHSsz0ldWtJ91I3N9Sz
   aODUngbtCdKK6tBAZGYYhjKi9J5bqxF4GVUh8TA2QMKQ9ECTYO/CuByn3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312418125"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312418125"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 17:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="589996449"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="589996449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2022 17:00:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:00:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 17:00:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 17:00:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6odERXfGoklyYYA29RUZGBD0JzmOVkikVAsksn0zZ63GJ6w53NbuPRACGkMKQxdCI9RpsHWYf0kSjqPSraizQlz1p8GZKnDARmYPQAKr3+XE0bbVniSqFE9+6oX9FwyFMg8QAcyAFzMEDPzaZQGGJgWD20Gskjf11O46vQAqeI+mK4js/ya0BuHfP6hDBTRTolPjA4D+M37f4OA2JW4pDJVuK5JQPOZzoGF7m62+T3ka9JMzUWLKuWT6jBusJn7c0/Qi95KXR6q/Uf13v3FamRh1UAcTjUByGLrIPICIZnrArjicYn0ZU6076gCdgZ6Je0g168MMpBWyGdI0o5fEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFUzM6OQ33d3eKcxFpI8vZG/yrmFQWgD81haoQCshTA=;
 b=nNd5W2nLh3/zP9SL3ympVPzkGh0O60g2i1TvpVDpbrtvWROIzox7jnQ5Wvz7A/bZvE29M0ByXVisH/X5/gGV+FNlJXYifda3gNfizWtLo+xj/DQeJV2hZohb20wRQ6LmLelo/ufnhrep/YEE9P/Rpi2WmWojG9kkGrK696UICcPH8YkasSlCDnYP3XkcjLRRnnQM3gjeeosVtOFpFycK2im1EKp/dmCdk8WzI5zFlstDZAIlkj/S21T7uZxeWtY754iHHq9Hj/drih9NnpSuxKgTSrmcRLUILbNsY/Xw6ZFDZ2kk2vzOmoXK7QJ0twYhzDxDH2Z9QefqSX0FOyPj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 01:00:13 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5813.017; Wed, 16 Nov
 2022 01:00:12 +0000
Message-ID: <a4eb5ab0-bf83-17a4-8bc0-a90aaf438a8e@intel.com>
Date:   Tue, 15 Nov 2022 17:00:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 01/26] x86/sgx: Call cond_resched() at the end of
 sgx_reclaim_pages()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
CC:     <dave.hansen@linux.kernel.org>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <zhiquan1.li@intel.com>,
        Sean Christopherson <seanjc@google.com>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-2-kristen@linux.intel.com>
 <Y3QgZ+ZKAfJ92U5L@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Y3QgZ+ZKAfJ92U5L@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA2PR11MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d674a80-d4e3-4825-410c-08dac76de9dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyF3txn9yDL/hjaWq9W6uKuPA6AH1WYzsW4VC64Xlg4ZdMrULTGwYAUHP9S6+1nWuad+UM+PEdcOngkuB1m52dfIECA6e8ZgcVQUyrLZo+rLOEIo5cH9lZ3WT0C7UsiaHaDJQ2wA35NM+X/bmaKdnnC07ofPcwoGKheTEEbWyHq0occtfbg6bvc91QtsvkC6iYxSRAn94X8ZuLnglR5Z864c4pcTWGW1neuv5l+Eq/SfF6HdgP0j7xiQbuagbFe3315h1ZAfu33o+UiS25kjbQ/oseTZBOITAq5qH6z6/XL46R7XzKgi+Vkyd0th1ms80tOl3ZPcPNE5Psyni9ooPEgwJM8KJ0r7K6nB10T/5y58H0NJK6DPzGLPoJTPg9Jv8WK+qGaus2chp7uVJDkDx+GHosd5ZmCyE3U9HNAWr8Dv6L2uYk6sd+Sd2MOYEFvzDNuJWNXaiiXxgwfzPjKNhD0rJnVIncvRiDzH4M5ceY9Hoqn0l7N4A9EkMlNvzWmqd4tx16sgQKGdmTMpmPrmTI7TYQLaaCYszBghQg2VEeRxVemHy/B+E7+cGMrjluOtBLegUFoqJ1rz9SaVOouPKi3kNRs9gpcHX68wolRlmTSBKTh6dI8evrDvJ/BLquwTLv5narLlIb2TwxpOJWl9jMRPGp5yXDQrZ/0n9ogfje1wJugNsNRafQFA3dVa41qICdQMHYjAWPWIL6+R6Og6nElqbCft1zHSS4GV3ePRxaDiIAPBvorYJ4801TtEyDyZ9S8V3GuUTgvFgheigq9sbNpJzFCAdEMuv1wOiA7RpO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(66899015)(478600001)(2906002)(6666004)(53546011)(31686004)(6506007)(6486002)(26005)(6512007)(186003)(36756003)(8676002)(4326008)(66556008)(110136005)(5660300002)(66946007)(316002)(54906003)(66476007)(41300700001)(44832011)(8936002)(7416002)(83380400001)(86362001)(31696002)(2616005)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGUwYndra3lQM29RTWEzU1RFZm9LUGxDWWI0V282cE1ZTk1zMWRYL2lnT0Ew?=
 =?utf-8?B?MkVwRWhWQ0MyL1ovZnBoaWxKRi9FQTBHb3RRemdidmtXWno2TjNaMlhRbDV0?=
 =?utf-8?B?ZFFlNU9PMk1XSFFDTW9Xdzh4d2MzOHJSaitNOEVhN3J0WWtmL2tpdW8wTkRM?=
 =?utf-8?B?NmlkQytOcjdUQVNkc1U5YlVTT2E4K2h4NnZkb2xVdG0zbUFkK0ZOdHoyV2lr?=
 =?utf-8?B?NWJlMFJWUUU4K3VoYWRINWVGeStrVmhxeTQ4Mk44ZmZ6ZTVJbysyMlM4Qzd2?=
 =?utf-8?B?TXk4clpoVk5MVDVBdVNFMnNlUkRXUk1Fa0NrQmE4U1JVN3RDUEZnRm9yUzdx?=
 =?utf-8?B?aHpxUmlJcG1NSDJJVTJiZVdEQXQ4Vmc0Z2ovb2Q3SjFoVHMxZzBSK0sxZk1l?=
 =?utf-8?B?QUFDTDN6RHhTdmdIYy8zVFRMTFdiR3EwNFVxOHhDemlib2VjQnM3eDJVak9V?=
 =?utf-8?B?RlkzQWN4SlYyWjFIVjNidHJOY1AyNk02ZEh0VnFyVk5kYmloY1hrb1ZDVFFJ?=
 =?utf-8?B?anYzRFhzZ3JOUFRoQnpNOU1xWS9reHlzcGZES2t0N2oxRHNZeVcvL2xRTVY5?=
 =?utf-8?B?SmtHMUU4akM4a2ZtbHh6di9vUHpUYlprdXR3dUNKY2dIY3d5WURWcU5IL25K?=
 =?utf-8?B?b2V2NjdoYmZvV1VHVGtGckpYbVpycjFMUFRKdTF0UjZ3MjlQUzNHdDdKWjNx?=
 =?utf-8?B?YzRtS1dhNXgyYzRHN0ozVEdmenUxeVo1MW5PM0xNRjhJSlFLM1JmblptT21v?=
 =?utf-8?B?dlFhWHV0S1pMOVZ3dW5CRDFIUlY2dStDajNVQnBrYkhTSEpYeGhPZnNodUE5?=
 =?utf-8?B?b1N4UXlsa0UwalFYNEhzMEN4NHZvMHJWNGxaOExVK1dYcVVDaEFZZmNjT21Q?=
 =?utf-8?B?bnJUanlEY092Z2t1bldxc3RHb25mRjc4aHNCZU5mbkNOcEFjZTh0WVYrcmxU?=
 =?utf-8?B?NzdiR1k1VllsaWwrSm5CTlF6WVpxMDc3UDZHN0ZWYlN5dHR2UG5UZnQ1RjRJ?=
 =?utf-8?B?NENJRmpuYWJ0elpnNHhFU0JhM2dlNjVzUlRzL2pSMVFoYlBkM0dqblRxTnNy?=
 =?utf-8?B?bFdBYktiN0RqT2VSK3N5ZkYzUjJ1UHFiOUhlK29YVU1nMWFqU2lkK3Nrazdi?=
 =?utf-8?B?Sk5oOEg0VlFJWlVRQWhiOTFNYi9rNnFDZEdlR0ZoVytPS3BLSmJpZ1E3N1RO?=
 =?utf-8?B?TjVDcm01bjZuRFNYK21HbERjZlArOW16SlF2dUNlK3laRzRZLzd5Z1ZwVVdl?=
 =?utf-8?B?alE5MS94OG5IN0hYejdzVTJqSU1MQ3ltT0dLWVJpWkRXMGpEQWc3ZnBlT2tL?=
 =?utf-8?B?MXI0UjhndTFma3d5dklWTjljTW5jaGRBNE9hMlFNSVIrb0ZMUEx4YXl3Z2t6?=
 =?utf-8?B?SGo2RXRkd25MOUVCRU1YVC9yNUlZZitTVUlSQkRKS0NwTWRIbUJ4ZDJFblp0?=
 =?utf-8?B?QXdXU2k4eHJNM2d0dUhzK29ycjVCMTE1U082MUJkZ1g0d2VITWN3bTlpanR4?=
 =?utf-8?B?ckZZTFA0TDZKVCtXWW5zOVU0ekcrakwyTlJ1NUFnVDJrUXJyOGVReDdpZlZK?=
 =?utf-8?B?SXVTdExjSlRHQ3lsZGlYcUZ0akxUeHoxZGRzSTdLMGdHU29sc0tpQmx4a1Vn?=
 =?utf-8?B?RGNkSEJuTFBMb3ZJQ1Fkb3Z3NldhUnV3NXg5QXZ5VzkxWnRmbGxHVHRYSzRU?=
 =?utf-8?B?aFFUb1NoY1BCSXQzMEpNbTludlhiSUs5UU5QblU3TkxKU3UvYlNMampGSG42?=
 =?utf-8?B?QjEvY1FUcUtKWnFOVzVleFcxN05KTmpIc1dJRE9tczdqdWk3ZDZpK001S053?=
 =?utf-8?B?WVlCcm4zY1BoejJybDNveGk1SURDQ0U4ZFlNenNwbmhoL1dzeCtUWmZLWHA3?=
 =?utf-8?B?U2h0MkhrRHphWk9YK29YWkVIMGFuNjBEZ3huT3VOWUFvTmRMeXZQaWRUNGhM?=
 =?utf-8?B?U0c3L0N4REVZd2pKdTJjc3Nvdk9KVzFXSzhqL0J5Y3JuV1cvY3JZYm9Ka3A0?=
 =?utf-8?B?UHk2WkV3amloM1ZyUUxoZDFTZEVXcjVaekVKMjVtWCtRTGR0eEorVmRFK3FV?=
 =?utf-8?B?ZDNTZDhtMHp4UkFpTURVeUlUdHZIMjBzYlk3aUlrb1pqY21GSXZwY1VTUmJr?=
 =?utf-8?B?UUFFUTcxZkY1NjhDbkNwQk5RR25nUllPTUFzamY1REFwallhVi9nVkFGTGhY?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d674a80-d4e3-4825-410c-08dac76de9dc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 01:00:12.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0u09Jd0zvDryQLDEl/IDn9CjQF9ESljZYnlkssMN9L3IfEPzG11qto68uQbXaJSNVTr/UUnCd+imqbO/MXACSHvBAtDBsZXP4VuPA1A+56w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jarkko,

On 11/15/2022 3:27 PM, Jarkko Sakkinen wrote:
> On Fri, Nov 11, 2022 at 10:35:06AM -0800, Kristen Carlson Accardi wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> In order to avoid repetition of cond_resched() in ksgxd() and
>> sgx_alloc_epc_page(), move the invocation of post-reclaim cond_resched()
>> inside sgx_reclaim_pages(). Except in the case of sgx_reclaim_direct(),
>> sgx_reclaim_pages() is always called in a loop and is always followed
>> by a call to cond_resched().  This will hold true for the EPC cgroup
>> as well, which adds even more calls to sgx_reclaim_pages() and thus
>> cond_resched(). Calls to sgx_reclaim_direct() may be performance
>> sensitive. Allow sgx_reclaim_direct() to avoid the cond_resched()
>> call by moving the original sgx_reclaim_pages() call to
>> __sgx_reclaim_pages() and then have sgx_reclaim_pages() become a
>> wrapper around that call with a cond_resched().
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> ---
>>  arch/x86/kernel/cpu/sgx/main.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
>> index 160c8dbee0ab..ffce6fc70a1f 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -287,7 +287,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>>   * problematic as it would increase the lock contention too much, which would
>>   * halt forward progress.
>>   */
>> -static void sgx_reclaim_pages(void)
>> +static void __sgx_reclaim_pages(void)
>>  {
>>  	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
>>  	struct sgx_backing backing[SGX_NR_TO_SCAN];
>> @@ -369,6 +369,12 @@ static void sgx_reclaim_pages(void)
>>  	}
>>  }
>>  
>> +static void sgx_reclaim_pages(void)
>> +{
>> +	__sgx_reclaim_pages();
>> +	cond_resched();
>> +}
>> +
>>  static bool sgx_should_reclaim(unsigned long watermark)
>>  {
>>  	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
>> @@ -378,12 +384,14 @@ static bool sgx_should_reclaim(unsigned long watermark)
>>  /*
>>   * sgx_reclaim_direct() should be called (without enclave's mutex held)
>>   * in locations where SGX memory resources might be low and might be
>> - * needed in order to make forward progress.
>> + * needed in order to make forward progress. This call to
>> + * __sgx_reclaim_pages() avoids the cond_resched() in sgx_reclaim_pages()
>> + * to improve performance.
>>   */
>>  void sgx_reclaim_direct(void)
>>  {
>>  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>> -		sgx_reclaim_pages();
>> +		__sgx_reclaim_pages();
> 
> Is it a big deal to have "extra" cond_resched?
> 

sgx_reclaim_direct() is used to ensure that there is enough
SGX memory available to make forward progress within a loop that
may span a large range of pages. sgx_reclaim_direct()
ensures that there is enough memory right before it depends on
that available memory. I think that giving other tasks an opportunity
to run in the middle is risky since these other tasks may end
up consuming the SGX memory that was just freed up and thus increase
likelihood of the operation to fail with user getting an EAGAIN error.
Additionally, in a constrained environment where sgx_reclaim_direct()
is needed to reclaim pages an additional cond_resched() could cause
user visible slow down when operating on a large memory range. 

Reinette
