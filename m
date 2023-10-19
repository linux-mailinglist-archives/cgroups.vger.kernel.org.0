Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A647CEE1E
	for <lists+cgroups@lfdr.de>; Thu, 19 Oct 2023 04:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjJSCdG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 22:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjJSCcz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 22:32:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA5D71;
        Wed, 18 Oct 2023 19:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMcrAb19ho4o84FfMuIIErQfnWu3u+H9RY/IXULCNOz0kZV/0fuGvFrxNWjS3vEDbfqTPx5VtCm9H6UGZGfBmYcX4fVDKEh9PCpFR9dLQsRWLuZsKYkHvLkOvdAgfV5FvctRepHeYyQ4Dt8MaNjvqQGOxLG30aY7Ild0MI0hJqP8kdeGlQaCXra+hmivxiKwnO855M5/KcUhx9hfqNPBNBAGbpTOompPl+YzBadibqTttx6GZStul3dBKo+L+3wkDqSXeO3zqVXWJi8+QHuiBntZW1aBL9ye8DLU3vA/rou/pC4SeRQ2pT+JqHNvbHos+2FZhvoq7DhyoJ9inYIxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvMaeYR4txS+Qyh65EZnNk4KCVOxaq8GMP9qckkYsOE=;
 b=hevXL5f9tsThqCb59qlIB+ZfkF9v0vkDk1e+RqEvvkGoMq/FNJKyAbVAA+JVptml35aYRpPleP1jukBiQWHOKsNkiCbEO68KrDh2EhaaQmeio6E1Db1O+h8W+01ElxnIa+26qmc6uYaphS82uouA8L7QtPoXK/M4sBJmILwyxK7+elaKtZWChmC9LQBsdLSk8lrZz3BIuz9s/VVFbgZV7EZs43687jcJg2tiH/KVStw77U8HvU2SuvxvdgYYb81ra4VhogGhgINcea0qO7W8XnSelF+0TvQzTseMeTNbJZdWlfcS0ClJKlAAYr+4hwI366AJ4nV6nG4T2mGlUFcD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvMaeYR4txS+Qyh65EZnNk4KCVOxaq8GMP9qckkYsOE=;
 b=NfDw7bLJrznNZ223gquXsGfP9Jl32uUse1cYzbmr5ZtTTzBBTWn1k8kdHLSE2uwpTqGse+Lwmag91z497EJSkP823/RAV6QLa4zGhDndc31+BxpH4nnPaG4yEt0FiNxiLVaLx+wMc/9SKMYLtwTur7hxVkQrMm3YPXvUVLQThbJBaW1tcrnMOAZ23DZPs/UF/3U4oPO45YkTQ6GrYIH4e821cs3MfsgnPf9/WNwx7riOYuW1Af3P1U6EeN4898ddXMvIERDuTnIb3+4+5J8d0BzkoqzE5O4+lpcex1MqmQ21rw3Zp2deByZxUTNtdnFDbVaO5JrRRNNw/KJ14e0PBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TY0PR06MB5756.apcprd06.prod.outlook.com (2603:1096:400:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 02:32:22 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 02:32:22 +0000
Message-ID: <d9b31019-9374-4531-8967-d289af3f4f06@vivo.com>
Date:   Thu, 19 Oct 2023 10:32:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 RESEND] Per memcg lru_gen node stat
To:     "T.J. Mercier" <tjmercier@google.com>, Yu Zhao <yuzhao@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>, opensource.kernel@vivo.com
References: <20231009025726.5982-1-link@vivo.com>
 <CAOUHufaX35Y6MfwKj_XUWXJwdC=9M=g1gXpQpQghBZ2fXrkEAw@mail.gmail.com>
 <CABdmKX0xevnJfcgsDEWsfX9J5T2x0EV7x-p4ommq_Deg98WwYA@mail.gmail.com>
From:   Huan Yang <link@vivo.com>
In-Reply-To: <CABdmKX0xevnJfcgsDEWsfX9J5T2x0EV7x-p4ommq_Deg98WwYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TY0PR06MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 097ff8db-c5a0-478c-abff-08dbd04b9f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gr3NamqVEp4UaeRpQ45LO2LpqoPIDxkCE+ZhaUkO9eJlFX2SHxMgemau90CtGc94YyVVGsaA/S+seGtXogF9sHrt4eU6Ll8nEip+YR4hkyeE5lNiz0/x9RPCjljIpoAt1xNu7koAezNSZxP7mOv4hbeInBOEY141Ep2x0pq4pO47Hh0sh38VFFtj7K26dcDC82LkhSsRagNpQG2gZ60wRHL2w3vrke3kSBvAQ42iTmfrc+I1oAMDH1t7pe0hNnjbRKuHyNuRj5qntDOIKX3b4SsxfHqCAArq0FQaia3P51KOA8ZCnQR++Pr5L8vqof8bBsngFu4nNfHKoI1et8f9qdjR4d0WgbLELdw6USI8xKwbw66p/26vk7OrSG/NDUniyqj6NeXVztIYKQkZrjdSX1DS/cgx1kQ0b1w/hLTnxp5RHL+RuYh7l5kxftOE1u0M2RTt1QuMJEvSFEJeHxdnWzOGKmm42T3pB7xKQH7/wMpORJoxQa0WaJuuuM62UUpv9EZO+cLbNiJrEiK2AY3wRpw6cwKAzPMXfqtRSsOQF6YxUMqhgoYkExCTaXseaQo/G5kpZC5VvNSoQFGmkTTHNToP/v1LJ37YLRY2oOQ1QJmJQjoHgmNK83PTXQUNVPc3bPCWllkh4BfXmoptxzaZrux8ualDQWet6nTE36z3r3R+xGW+oc6VK69/RWE+MefA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(66899024)(2906002)(7416002)(26005)(5660300002)(36756003)(8936002)(4326008)(8676002)(38350700005)(41300700001)(66946007)(54906003)(316002)(66476007)(66556008)(110136005)(86362001)(478600001)(966005)(6486002)(6506007)(31696002)(6666004)(52116002)(53546011)(6512007)(2616005)(107886003)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWw0YWp5Y1diZWtnd3A5VUhQby9ZRjdLSzFOVDYydU9tM3FIaEowZXV4T2lX?=
 =?utf-8?B?a2MzWlhyRkt5M2d4eVJJb0FWMnZ3WXRtN1BJY2tzZjgxUUlGVUU3bkkzZE5M?=
 =?utf-8?B?alRva2VMWkdKMldHMzZVb01mN3N2RFNsMUtqT2cyaUFXZFBMUmg5YkJSZDBE?=
 =?utf-8?B?bEM4aDFpd0tuMmg1ODNEcXdPQ2lyeEVWVXZPTmJqNnl1V1R2a1gvR3Y2VzJI?=
 =?utf-8?B?UGFxdHpadzFlQitiNUlhUGpUeXlkQWxNY1RyUnNtZ1JvZnBMTlJGMnltRVg5?=
 =?utf-8?B?eEZadVJuMTZkSlFUSzY4bk1EU25VMmlCMTVRQndLOThzVks5SGtsQmN1WjZm?=
 =?utf-8?B?ZUpsdnc2UUtZRU9FWTJVSjRJUmdPVDVpeU9vS052UWNsZUhmNGVhZnN6a2E4?=
 =?utf-8?B?ektoK1M3anZiSU5sbkprTFhkcXpKWTlhZFNQWXlndFlGKzI0bHlYbHhIMUov?=
 =?utf-8?B?ZklwZDJhY1BwdGhMS2ZLNitBSVZQTW55T2tNQStNQ04wbTVGd1I4VUErMmtO?=
 =?utf-8?B?L3lYYi9KQ1c4bTFYQnhndE1rYVlJVkNxc3pYOGRMd3lxRCtYeTV1a1pqbGtT?=
 =?utf-8?B?bmQrbWNzQ0lQUTR3VHBMVUVnYStpK25qcy8rMUlvTUxERUxWUlpqNjlXWFFs?=
 =?utf-8?B?MzFTMDZnb1V4M21wb1ZEYnY0NEFJYjE5OTMvOWo4VFlKRW52SFcyQUoyVmxG?=
 =?utf-8?B?bVJCbi9Za1Fwc3R5Z0tJQ01xN1g5L2p3RGE1dkZoTlo0Wi80K3N5SGV5L21O?=
 =?utf-8?B?WU1wdlFLM3lKM2oyVzc4OXYybWp1UWs4cFlWUnNTWXNKcFA3d0tNS2VOenhF?=
 =?utf-8?B?UnJzS2xVZkRWVllvU3JQK3R2YUs1TTRxdnV1c1Q1dlQ2UHRVSTRGYjl6K09D?=
 =?utf-8?B?eVFTcWFiZThiTjFIUjlmN2FKeHlXaWtFOXF1OXVydlJ4YVM0NGljOWpTZG9l?=
 =?utf-8?B?aVVhL1lTODBRbUlHZVRLc3pta2tVcnpIS0ZsRG95b0IxTThuejFJYzdLYUxO?=
 =?utf-8?B?Umptbyt2YW4yZm5zZ3N4QTN3MkhXajBRZ2hoQXNSeTgzK25xZlVHMFNpMHhM?=
 =?utf-8?B?UHNNU1NwcTR5Si9NQVVCaHZmMGlkQ3BnVis4R05rYWZTd1c1TTd2Q1VXWC9u?=
 =?utf-8?B?R0hxU2YyQklVamE0ZFNkaVppMndORHRmT0FIVWdsUnYyYjZEZ01ZMS9SbThF?=
 =?utf-8?B?VDkvMXd4SVJRU0F6WFI3R01Bc25UWDlSNEVkTzJrOU1ZdEc2MlI2Q29BMldp?=
 =?utf-8?B?aGhJOWdQNnJnYXdLWGVMMDJiT2RnenM3ZHZGREhLWlB0ejhnUzBweEtMYk9H?=
 =?utf-8?B?d1E5WGRsUnh1cloycE1DcGpYM3M2VlB0TW5Ya1lXSFgxdkZEMWwwQTVBSjhW?=
 =?utf-8?B?ZTl0cDRManhHSDN4bkk2bU1MRGdSalB0M0Ewc0duUEIvQ2JhNkM1TG1QcWhY?=
 =?utf-8?B?Z0lGZE9SNE0zem5DZUFnMXBUYnZJY1ZCRjJwdlBpMWpPSTVWWXZ1VTR6SGxF?=
 =?utf-8?B?RVZVOURhaFdGTXh1MEY0enNKaWdteWJNK0RPYlI0WlZJMXpTQkZBeG00UHBD?=
 =?utf-8?B?SjdqQWVBSkp4WG1SdForR1NyY0xnYkNFbytCRXVEd0o0S0E2TU9XYlUwWkw3?=
 =?utf-8?B?NzMybTQ0OE5ZM2tWRHhjdDdVRDVWM1ZlbGNGWlIrTmhkY01XVm9Ya2FjMjFn?=
 =?utf-8?B?eHFzU2NIcFc1UmlUNlhBOTF0a1dLTjBQUEsxSGpDdWQwSmpkQ1ZVaGt4eE51?=
 =?utf-8?B?ZzZrenpzOUtEdG1PVjNvY29XakR3aGYyeEtNVER4Y2R1QkJnNi8wVWdYaW44?=
 =?utf-8?B?VzlLUkVsSlpZOGZkaE9IMjhCMkhCVWwvN2hUZXN5a2orWnlncUhDOFJoeE5W?=
 =?utf-8?B?eFlGbTlHOGhnWGx2M3FjeEJDVFVJa0dGUGJRcUpjOWV3eUNCR0Q2NU5RTjF4?=
 =?utf-8?B?US9ySU45bVU3N0R4Q0o3YzhHWEpsUzA0NmNvVzZNUE5mVCtZVlZ6cTFxd0tB?=
 =?utf-8?B?R2dCbllwMldJK0kwQnhBSDh3aE1vVVVkeGxWZ1VsK01NRDRwUlNkWEZwWUJP?=
 =?utf-8?B?OHYrUHl2bkg4aUl1aGdtQkZqS3J2bmEvbTZDV3poM1pKdWJHTERUajRvcEpV?=
 =?utf-8?Q?3X15lRu+XZcNpNxmt1PhB6bMz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ff8db-c5a0-478c-abff-08dbd04b9f8e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:32:22.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVQpWOMLi6FPXTs0A6lqvvrhvRHArYI7A8UgQQs3BLLtDi085LwcG7YCdPSKowBbE7jU8GhROoVaO1x4PUndaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


在 2023/10/19 3:59, T.J. Mercier 写道:
> [你通常不会收到来自 tjmercier@google.com 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>
> On Wed, Oct 18, 2023 at 9:34 AM Yu Zhao <yuzhao@google.com> wrote:
>> On Sun, Oct 8, 2023 at 8:57 PM Huan Yang <link@vivo.com> wrote:
>>> On original global lru_gen node in debugfs, it can all show each memcg's
>>> lru gen info in "lru_gen" or "lru_gen_full", and can type cmd into lru_gen.
>>> But which show info contains all memcg's info, and cmd need to
>>> know memcg's id.
>>>
>>> This patchset add lru_gen node in per memcg, with this node, we can
>>> get lru_gen info in each memcg.
>>> Also, we can type cmd to control each memcg's lru_gen seq, but, this node
>>> don't support multi cmd, single memcg just process one cmd once time.
>> Adding TJ from the Android team. (The other TJ you CC'ed is from the
>> ChromeOS team.)
>>
>> This series introduced a new ABI, which has to be maintained forever.
>> How exactly would it be used in *production*?
>>
>> Android doesn't officially support memcgs. So I want to understand the
>> real-world use cases first.
> Not sure how Android came up but I'm happy to chat. We want to turn on
> memcg v2 for Android but I'm currently working through perf impacts
> before that happens. Android can't use debugfs in production, but I
> think we'd prefer to use memory.reclaim for eviction anyway because it
> respects memcg limits and reclaims from slab.
Yes, shrink control this actually can use proactive reclaim.
>
> So maybe it's possible to add just aging functionality specific to
> MGLRU? It'd be nice to know how you're going to use the aging, or why
Due to debugfs not always mount, if we want to now lrugen's info, maybe
nice to offer a memcg's node to show per memcg's lrugen info.
> you want this version of eviction instead of what memory.reclaim does.

So, this node not want to instead of memory.reclaim, it's good enough. 
age or other control just flow debugfs global node's behavior. If no 
need, delete write is OK.

Thanks

