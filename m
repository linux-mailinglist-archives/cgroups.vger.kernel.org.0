Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83D3DE4BC
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 05:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhHCDkt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 23:40:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233519AbhHCDkr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 23:40:47 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1733UYpo031535;
        Mon, 2 Aug 2021 20:40:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=kmMdd7tY7zbfnCesS+60VWwPMXzWClZuK+uqJJzvkw8=;
 b=rh24/XUlIF6iRjdTE9NMoheJFdUL0GALOJFuFT+eebIOzDSMKiVoxERqzgeKyIqAi8D+
 XsZ8OQx/IQBiFGYd7ZoDDplzNX4ti9rNt/9SpzZWTEGdpxWrkP910TLDGmCxLwxWMYJE
 OL2eSrKaLJAccubs9nebgN203GB9db0PyEk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a6nkctss9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 02 Aug 2021 20:40:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 20:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1QIVtVxlGnwbewyLZLQhRou9CUbWH61i0yhhjQckd0m9WQJl8xixNGkA5ip4TZRYqED6gB6izXVNMf3zpDpBZa3BjaRYl1vOBfb8yeInGmHmNc/9bq9XpNIKOGAlnX037IRcYafzXr4UDLeb1Hzqweg9+WUSphcSY24u0JfqOAKIwJDeYxheitl0zKMTbtGakfkppVHIc64DBakxNo3z/7oZnKCduYXxPGrEXC/tnjFRn/wdSG/FQ0jhGCf3Dmnlu5oe0kzmylpR+g0VPhEgXJqT2rJrDiVr5furl6KJWCNKMojmixvJNmk5ELs092QLcskHBJqgsBNtgvzDWZfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmMdd7tY7zbfnCesS+60VWwPMXzWClZuK+uqJJzvkw8=;
 b=CT8sZGFSOo16l2j/E+CXZRheCWWJ4v1fe55KsajvxuoKQEuEqhwSdxlPARvsHhqA4kLj0mJK4yLLXMt9i4LQsPuc0SkAIx2ElwNHndHTR7tN44V/WNjjG3Us1ufFloJtqVHuu0aWcqelTxKjBX/FE6V6FrxgbUraVG9x3iT+D1wMqCQLxCjqXeZ4oxD5rPmftrd787SyyLGjvPS1u9dzFQ+S3Vxe0b0bsyMQn9gm36g+eElX48zbLGVChB+O6eJwjkwjDTgrRk+xcdAXXDlTICr/pR9WjHqpq6YKmDuGS4sDQZM+qmRHmp6QXXRtN29vPCWEX7ewzyS6lQsAepvZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Tue, 3 Aug
 2021 03:40:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 03:40:08 +0000
Date:   Mon, 2 Aug 2021 20:40:04 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Michal Hocko <mhocko@suse.com>, <hannes@cmpxchg.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQi6lOT6j2DtOGlT@carbon.dhcp.thefacebook.com>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
 <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
 <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
X-ClientProxiedBy: MW2PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:302:1::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e78d) by MW2PR2101CA0006.namprd21.prod.outlook.com (2603:10b6:302:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1 via Frontend Transport; Tue, 3 Aug 2021 03:40:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1989688f-cb3e-43de-30c3-08d9563063b2
X-MS-TrafficTypeDiagnostic: BYAPR15MB3141:
X-Microsoft-Antispam-PRVS: <BYAPR15MB314185B3EE6DE6D2A8BCBC6CBEF09@BYAPR15MB3141.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9YIZhe6Pi8zW8CZihW2cCOpVnwCpCMR+bOScSymNwVoQLsTKGGfs/K6REESm5KlC/ZIeVS2pvVTzWlz4AXnYqtrL1g+Pk1ZDjSeAO8jibX0Nd6cDp131svTUwfX/bqX+V1b86gO6NQzQwjdZ3U+QZZtBcvLNbTPUzv+10nPI8wUnWQ4dh029RP72/jUuDAcGx8zK2oNfpiha9B2vUMdvhK2N0AktutBW8+6Kp3HBCTQu3LtdxPhm88HQsM2wg9S0mvOHsVNVmr3T2b5vNJs6G9dgV/b1kvQAQxGhRhHvt6uNj6mjixj8Z/kof/9IDNIJBaXoBKuWWiwHpwobti1kj49pDz1CtUYkrRAew2feKJr7O7DMQoe7mveGFeX0vdjmb0cUXP8VjcJ0YHXkJmoii97rT79xHRmIaSubprCWuqc6Y3iOyLBdaFWLgmmMB4gpW8jWcFStfFwjrfrBB8JKlBegoG6VgFpHRvW4/4bIS8CfjT7Q07N3UHZpcGFG1keJGFmaszezEcBANeiN800kf4LMDSvM2CX8Th4BZOlEBOYOelteVXOSncg6SgesnOzFUjYVh15GwA7fX9Bb0VBCoZ7ZcYHAb+wOOJIwme9YgYyVgV4rReuoYfbz4AFQ6DYOKl9j9uwhbbRfgFuabnBLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(6666004)(53546011)(52116002)(186003)(6506007)(86362001)(7696005)(83380400001)(6916009)(7416002)(9686003)(2906002)(8676002)(66946007)(55016002)(478600001)(66556008)(66476007)(5660300002)(4326008)(316002)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZQNXdrcklPWHJWd2JLandyMVJjVXFMZEErRHoyd2xuTE5hMXVnT2IwNzJD?=
 =?utf-8?B?TWlBUThkdEFEUlp1a3l5QWIyR25RNkpqNDdrSTNwMUY1WnIrNUhVVDVkWVZD?=
 =?utf-8?B?bFpiVEF6ZDdDa0x0Z01GMHRDNk5ic2xxUldBVm4xNlhEcnNkVFJmbHdCZERE?=
 =?utf-8?B?OThzaXpIN1V0emRnUzFjd0JJTlJlNGtLVnlxN1J4MDV4RnpGbFEzdGpDWjdF?=
 =?utf-8?B?MkduSjZ1QkJXbWhFaDdWOFAyT1l1bG5zdWZxZ1NsSndHaTJsM1RERHkrU2l6?=
 =?utf-8?B?UnUwc3c3UGZsKy91T09kKy9ucVlpUFlaQU1VVmY0OTVUeUhFUWhKMC9aWXNL?=
 =?utf-8?B?MHpnYS83UXZ6a0x4NS9tK0p6VzVGUXJaR21MemxZU1JHY05vV1lTbFVsLzBz?=
 =?utf-8?B?Ly8wWm41RDVqV0p2NU11WnoxRy94MnRyczl6cWNTaGxWYU9zK25XVnBMMGtY?=
 =?utf-8?B?SVEvMkdEMERnZ2tDWWk1TUcyZUpQR0NJcDQxYUlMbkFkZ2FrQklvY3daK2NB?=
 =?utf-8?B?dk9KNzlvNnJWaFV0d0ZnVVFkUzNiK0hmdThxSTllbnBZZ0ZKOFpRWGlNS3lM?=
 =?utf-8?B?UWMxMGJTYWtVWXFEWFVQNWpxekM0eXI1WWZONmlXb1JTb3ptTXo5UW5ZMzhK?=
 =?utf-8?B?d3ZObjVJY3RZZnY1YmxYaGkzS1V0T1UvMFU2aFdValZDejRDSmFWL2w1OVBh?=
 =?utf-8?B?UFM2SCsyVHhwNDNiakRPMkFpVlB4S29lNUZhdEVWZ2RFMEp3VzlYbVd5c0JB?=
 =?utf-8?B?akpOTVpQanpEejBwVVd1SWpLNWc3cERMU3Y5MExCRUh4RDRXNTlVVVFHVGw1?=
 =?utf-8?B?RXBKZ0E5bEEzQXc0TEJhMUJCZEFhSVBVcUxRVTBvM3h0NHdWbFlXTjVIbStX?=
 =?utf-8?B?VW5JcTU2MEJRT295MXBKZm5oblJMVFp3UHpSSFM3OVFSZGszMFVnQm1EdWo1?=
 =?utf-8?B?SW9rNHlYZXh2aWIrTEZSZW9DeklDTG5raDBVNVZKZkxiRFJ3aXhMUmI5UWxu?=
 =?utf-8?B?Vmh0ZnMwbS9uY1QzQ0Y0TzBVQXhHWmxGYS92aWJ3WnhvK2ZpVEtmVS9FZENT?=
 =?utf-8?B?MDZBMkdWS1M4OHVIV1hTRG5jUzVLYzJKR3JyT0tGdTBkdE9MM0xscU5qMXlE?=
 =?utf-8?B?cDNwcE1XV3ZkVmFDYWRPZis0aHk2MjlqcWRsQlZFZ0FUTDZUbWZMamkreVJY?=
 =?utf-8?B?MG1BR1R3alZxb2VBMVRrbmFPZ1ByZGFBTTZORXRzRTcxYkJuVktUcmJLVEtT?=
 =?utf-8?B?MGdSQzlqUmdSeHhNSlRjZFNncG5CKzFDY2NUSjcwV0l6SEFPNVBHSFRiRnZO?=
 =?utf-8?B?c0pnV0RkdTZnV1c5ZnZ1QTgvYnZZSGgrUWVUZmg0eXFXVVI1aStJOEQwRXVO?=
 =?utf-8?B?Ynh4UmNoeTZvaEdwOVkxVncxbTlPeGNhSXFRM1V0U2JodDY4MlZBVG9zNlZD?=
 =?utf-8?B?Yk5FM3pJbUFwQmdXVGcxYmM5MTNIbUIrU2ovdkNqV3VwTTh2UXhpaW16T2JE?=
 =?utf-8?B?UC9jNmRad2V6ZkN4cGJyQWpOd3FPQ3lST3g4M2VmU2JRMm84SkdTeFFQMUZ2?=
 =?utf-8?B?cUFNYlZ3QjdJa2hWeDlWRUtNWk80d3BHOVY0M2svUnlWU1V4Mnp4UFJyQ2xX?=
 =?utf-8?B?c2ZnWXppRDYwYUYrMGZKUkhpdy92V2tZRlR6VmlUcUtGbElFaGxIU3RCRWVO?=
 =?utf-8?B?cWdkK2Z3WXRWQXFHR0kzZFpFZzUyc3N3QVZ1a2g0L1FZK1dTSGt4UmVKVUI2?=
 =?utf-8?B?QStpVGdQL1hhemp4YnQ4Z05MZWM1QUREdkFwaUFaQStTZXQ0UHlORCtLSWJa?=
 =?utf-8?B?aFlFRE0yLzdTM043WTVldz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1989688f-cb3e-43de-30c3-08d9563063b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 03:40:08.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7Inm/BgcrDlUFH7oyY90TkB6pEI0T3KFIonkJP392X07aXacatNTQK34NCyyBwB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: kNUfPUgwOiS40VVIs1hAc1ZavIjb_OGx
X-Proofpoint-ORIG-GUID: kNUfPUgwOiS40VVIs1hAc1ZavIjb_OGx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_10:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 mlxlogscore=646 bulkscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 31, 2021 at 10:29:52AM +0800, Miaohe Lin wrote:
> On 2021/7/30 14:50, Michal Hocko wrote:
> > On Thu 29-07-21 20:06:45, Roman Gushchin wrote:
> >> On Thu, Jul 29, 2021 at 08:57:52PM +0800, Miaohe Lin wrote:
> >>> Since percpu_charge_mutex is only used inside drain_all_stock(), we can
> >>> narrow the scope of percpu_charge_mutex by moving it here.
> >>>
> >>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>> ---
> >>>  mm/memcontrol.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>> index 6580c2381a3e..a03e24e57cd9 100644
> >>> --- a/mm/memcontrol.c
> >>> +++ b/mm/memcontrol.c
> >>> @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
> >>>  #define FLUSHING_CACHED_CHARGE	0
> >>>  };
> >>>  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> >>> -static DEFINE_MUTEX(percpu_charge_mutex);
> >>>  
> >>>  #ifdef CONFIG_MEMCG_KMEM
> >>>  static void drain_obj_stock(struct obj_stock *stock);
> >>> @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> >>>   */
> >>>  static void drain_all_stock(struct mem_cgroup *root_memcg)
> >>>  {
> >>> +	static DEFINE_MUTEX(percpu_charge_mutex);
> >>>  	int cpu, curcpu;
> >>
> >> It's considered a good practice to protect data instead of code paths. After
> >> the proposed change it becomes obvious that the opposite is done here: the mutex
> >> is used to prevent a simultaneous execution of the code of the drain_all_stock()
> >> function.
> > 
> > The purpose of the lock was indeed to orchestrate callers more than any
> > data structure consistency.
> >  
> >> Actually we don't need a mutex here: nobody ever sleeps on it. So I'd replace
> >> it with a simple atomic variable or even a single bitfield. Then the change will
> >> be better justified, IMO.
> > 
> > Yes, mutex can be replaced by an atomic in a follow up patch.
> > 
> 
> Thanks for both of you. It's a really good suggestion. What do you mean is something like below？
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 616d1a72ece3..508a96e80980 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2208,11 +2208,11 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   */
>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>  {
> -       static DEFINE_MUTEX(percpu_charge_mutex);
>         int cpu, curcpu;
> +       static atomic_t drain_all_stocks = ATOMIC_INIT(-1);
> 
>         /* If someone's already draining, avoid adding running more workers. */
> -       if (!mutex_trylock(&percpu_charge_mutex))
> +       if (!atomic_inc_not_zero(&drain_all_stocks))
>                 return;

It should work, but why not a simple atomic_cmpxchg(&drain_all_stocks, 0, 1) and
initialize it to 0? Maybe it's just my preference, but IMO (0, 1) is easier
to understand than (-1, 0) here. Not a strong opinion though, up to you.

Thanks!
