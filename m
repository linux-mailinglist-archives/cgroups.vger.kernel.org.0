Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B64E45BC
	for <lists+cgroups@lfdr.de>; Tue, 22 Mar 2022 19:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiCVSLg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Mar 2022 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiCVSLf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Mar 2022 14:11:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CD51E43;
        Tue, 22 Mar 2022 11:10:07 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22MHaMsT029931;
        Tue, 22 Mar 2022 11:09:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0R6AdsNxQYKtlx7c+ZJCr8SBiOh+ERMXe+tI/ibvU3U=;
 b=GQ/WaR9OUbPS7ycajmt3WsfD633j0J+jJdANZ5ANXOOY6+e/YkR2dzq4iyMMWOBQ6IFV
 MKiyZFlS2A1OF9KDEFwkmm1/4lG0arcapo4qQoKxsXYNnKvE3rfL47WqruoThvoezcBi
 ZYaxh13DHA8iYyUOlmyh06E93QdErsA4Ba0= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ey43ye1uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 11:09:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAJYFGu5lepuxHIZvXpNZ+PYyTMt7FoNdm4abdJ8XOq6l2XACxt2Sjn2DRHrKuafaE2Wkel2GvwuCdfmiZPNWxT2jd15phnQuJTlzt5kju0DGhlp8WoCxdt3RHcDtdQvbyJKIh2PWnze6z0jwHGh1gvY0TIKjYG4xxdbtKbTI/Yp7XLr+PxZ2j0ansp/a14kH30N3fr4KgHKut5pSUeH3kNVVy1MzOSbT5qEszLuoKELv7r8ywB5ix/UYY0ZWaQJXZzRChY3Sg5kJKHhdYMdYTPKjxjzSfNK19NePYoGP4fH8aEdVgJR7P9W4/1CvxZKnrJ5o5LiwhoIJyw7/z86QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R6AdsNxQYKtlx7c+ZJCr8SBiOh+ERMXe+tI/ibvU3U=;
 b=P9Qr7/8i3p7AaM6xcxsBFAKJAhuUt4SZ2GymuVoKSsyl9vStUjtpypIqcyrR91T4UPjnj7/RY3iytV8erBdNojF6+laiDH/ZnediiHXNG5R8EV+uP8s6VjY9wB/T8PZCEQaVwuayoUCe5rh9i+1rwVhMP1M4dCiwwsrFK0DpxQdl/da7c02n5XL8JtPxjJK+YfiQ5aJAG+IjuSo/+0OOlzbDKkl46NrShDBR9RypHkoQNIzzZToATCUSDLi7AY7aZKXp5gJQfujwxiVt7FYTODeuP5ZW00ifBQBsDtcfcyn8IKOIXPPE6u/V3RnMZtB9Cx/1dL8y6bi+Xndb+UBo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5029.namprd15.prod.outlook.com (2603:10b6:806:1d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 18:09:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 18:09:45 +0000
Message-ID: <f049c2f6-499b-ff7a-3910-38487878606a@fb.com>
Date:   Tue, 22 Mar 2022 11:09:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
 <Yi7ULpR70HatVP/8@slm.duckdns.org>
 <CAJD7tkYGUaeeFMJSWNbdgaoEq=kFTkZzx8Jy1fwWBvt2WEfqAA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAJD7tkYGUaeeFMJSWNbdgaoEq=kFTkZzx8Jy1fwWBvt2WEfqAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:300:ee::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb5d467d-9a21-42e0-ce46-08da0c2f2538
X-MS-TrafficTypeDiagnostic: SA1PR15MB5029:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB5029463957B1D9C1BECD7410D3179@SA1PR15MB5029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UserMW+sEyFV5NwAjgVpqMeAfrVmirjdOJW1QMGgI5DuokwrVy1EPeRg/TK8sx50HHPvqjPTIAIzwp0+/mdnVcVsUzYeunbF8Nygao35SQkP5X/KpcA+RweWvhg9Qaza3Jgt80c2ZeMA33gMIuL53EyV/uUvhM0MuaZzgYXVFDAEJRlzXoF5BpUYBGOf5a6VDiW953WOES4bY4m3C7dIUQDWExvtkOWa3Q8a50Gje4dWVRu65sKJ9t6Ck07L8WsBUP1aE0InV9OG4Ukwf53PHV2mYSmpjswRq0UpG/D8MtNC2VkZ8LCZFZFwkLv/LJxsZymlB8thLJeTlUcdtnX8gdygxNREWDrWsX8LxMAOCzOCzIVHupgruxwtkXe5Dc53qAOwuzaQbN2K/TkTFGidIPyRhntklJHGBgjoY9P+ulirM+zEk9z2gCYmI1dd7Kp9vS3pP/+GismU098/NQIRfThMcQt3V2QPtjnHYOhoEWjhgZweZXz9fzK8YhIGs7mX/GtpxzOmV9HS1Sz+vyFCNaFl1I14fybPIdYcgLiNU9+tF9BNz5G3P18EfAnygo8MkXRPZai++xSxpkZJ38wTMQBHjoEJijvVfunAzVSZCRoiB/Y1K41K2Spq4yYEMe0/RSURvWrLiR6Tf5L+H2qZQlxG6N6iXG1yj2CHhE251NqPIphCevuqNCYaMuBrNgQ8QMoUWWAEZiTdDsUmfz1ZX4G57XG312FtD42Wk9jfXH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(8936002)(5660300002)(86362001)(38100700002)(2906002)(2616005)(186003)(83380400001)(316002)(54906003)(6486002)(508600001)(31686004)(110136005)(6666004)(6512007)(6506007)(4326008)(52116002)(36756003)(53546011)(31696002)(8676002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWM5UnliOXI0VmZLSzV2T3c0U2V1UFlmK2plUnR4NnpLNVBYQ0dWWFovQkli?=
 =?utf-8?B?QUNwMmxuR1BqbStzWGpTOWRQd1hMU2ZnL0U4bHVXb0IvRzRNYTArelFZMFJH?=
 =?utf-8?B?bUw3Rkw0MXg5T2R1N2R5UTdwTFZtTkdJTndsOXpaMVNvcXI2WTM2eWxVaG43?=
 =?utf-8?B?Z3U3U2FuaEhhY2ZzVVhoMTdoR2N5R0pDWklDbEpZd2lJZU1SV0lGblVsU0d1?=
 =?utf-8?B?MG0xWFR1WW92bTkvUk1WdlZjK2drVzNDNVkxclk2OE03akVIZUxNTGIwdVBD?=
 =?utf-8?B?Y3BGeWNwVno5TmdjWUYrbzVBUmVUUUdvUFNzZnJiVVZpRCt6WmtFc2p6NnJP?=
 =?utf-8?B?c0IxVjhaV1JPb2R1cThrK0YxQUtlWSs1RGR3aTNTMVNaeXdqaFpFRjc3UU5D?=
 =?utf-8?B?QTA0VURpcXJDYkVPZFpSbFkwWTZUeG5BMFgvalZFRXZwb0Vyb0NKSmxpdVZq?=
 =?utf-8?B?RHhzejdTbjlVa0JqWlRnUlMzWWJQeXQyL3Z0dlAwcGQyVWhKU0RjbUNZZnJm?=
 =?utf-8?B?SnVOeEc2Y0JMRldJMG1QUlpDMWU5N0VlenFPRjh3azZNWWpwWmVwY2tyTTN4?=
 =?utf-8?B?dFVFMVgzUk5qdEhYUzU4bWNsNkQ5b3JuZGV0L205dXkxWWJ2Z2RqcnBjRTEr?=
 =?utf-8?B?M1VOb2VDUzdnTGozUS9XZkloK1JsenllRGdmSjlqM2lLSEQzcmdWNXVHZkRw?=
 =?utf-8?B?bXBRY2RzSEhIRlk3c1hhUHhVakRxSExJL3JBVUxCUUszZzZleWlXaXdtTlht?=
 =?utf-8?B?Vi9EZnd1SUZxZ2YvYkhZalZsN1NRZTRRRHVHUTFTa0s4VGNWSXZPMTJrcjZw?=
 =?utf-8?B?VW9zT1RtaTFMLzBsZ1dZVi9nRXZESGZ5clJkSFQ5YW9QbjRscC9mek1YNDhR?=
 =?utf-8?B?WTlGOCt3Q1drcWsrdFo5L2RZUU0vQVBvWnVFK1JaY21uekdsMkVzeGZQNmp1?=
 =?utf-8?B?YXBjV3JGU0lCL2FLL3A5WFRNa2lYNkVwQms1enh5N3FvRjlLVjNCc3cvUGtN?=
 =?utf-8?B?WkRUR3BTSmIzdFVxY0ZVR3pmeXI1bko3cXBqVW9sOHEyVlNMMFQ1Z0dNaHpB?=
 =?utf-8?B?M2FZY1Ywa3dGS2NsVk05bDhvczJhYXFXZHZpN1B6UFgrbW92NGk5dGNuWkNQ?=
 =?utf-8?B?M05uVTlYTmtaV1dRdXN5QjdJaHZ4VVVtSitoalM5V3lkdklEV3F4Y2tPYkhl?=
 =?utf-8?B?V3dobnlvVVJTTkxvZUt3TC9kU08rUE8vNmMzbGFXYWdoRkZ4UG45eGVqYTBl?=
 =?utf-8?B?Q05rMjJLZWRoYVZrbzFwbEZNUy91V1hSbUp5YzRBQzVOeG1YaUF1dGhHRnhm?=
 =?utf-8?B?bG85Vkx2bmtqa0ZJLzBQVWlXWngvdlF3K0c1bEp2RUliWnpHK1BPUjkxbVNk?=
 =?utf-8?B?L1cyamNrQVR0azB5L3FPS01WT215ZWtaT3FyTTBrTCtkekc2emdrN20xdzV0?=
 =?utf-8?B?ZHJwQk1tb1RBNkYyK0M3bndLRS96cDc1RTVlRmRzeFl5OUpRYnRZU2habUNY?=
 =?utf-8?B?d1VpYy9EVlNJN1RpNi9zNTgrd0NVbnlBYUZqcUFaOHVkSDNxUmdQT2lhYUZU?=
 =?utf-8?B?TDB1VHdwYWNqR01DYWNNNFFTaVdoYnMrTnBwWFgzd3NOM1lSZ2M5d0hFK2tK?=
 =?utf-8?B?Z0xGMCtSQkt5VFRxWVhKc3RvSDJxVHJ6VExuS2ZHeXFvdERuMTFkWjVqMmhM?=
 =?utf-8?B?SlFuMGx0Tzl6bnNxTmdlZ210emdYSmhMZmRwcXIzQ01JV1lseG9ubGRSNUlV?=
 =?utf-8?B?VCtQcmRUMXlFVUdyTWNSRlJEWXVZVklLc1NiaTFuL1pNWk1pakI5Q3lLY3Fq?=
 =?utf-8?B?c0psbmRJMVBpOStrdkhIZDRBWFdCa0Uwa3NFMEp5MVYreU4wQ3podmpoVmJU?=
 =?utf-8?B?SFpyMUl1WWZ4RU92elBsWmpxdzBPNjZ1aEMrSE9VZFcrSSt5YU1ZRlcrcXFv?=
 =?utf-8?B?d2lRVWRkUkNUUFFoVG9FQVV1cFJPVWtadVh5UnRwWnlVZyt5cm0yYlE2Y2E4?=
 =?utf-8?B?NmNmV2htaDl3PT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5d467d-9a21-42e0-ce46-08da0c2f2538
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 18:09:45.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1hiGgGf5hPvQCS4syRM5gD44KiJNO5d87IVBwJmbZwxi2rWLfhlpG6OIPy4sY9K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5029
X-Proofpoint-GUID: yCbdyllTJZQQLo-g41aUf3A_UWS9HxlB
X-Proofpoint-ORIG-GUID: yCbdyllTJZQQLo-g41aUf3A_UWS9HxlB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 3/16/22 9:35 AM, Yosry Ahmed wrote:
> Hi Tejun,
> 
> Thanks for taking the time to read my proposal! Sorry for the late
> reply. This email skipped my inbox for some reason.
> 
> On Sun, Mar 13, 2022 at 10:35 PM Tejun Heo <tj@kernel.org> wrote:
>>
>> Hello,
>>
>> On Wed, Mar 09, 2022 at 12:27:15PM -0800, Yosry Ahmed wrote:
>> ...
>>> These problems are already addressed by the rstat aggregation
>>> mechanism in the kernel, which is primarily used for memcg stats. We
>>
>> Not that it matters all that much but I don't think the above statement is
>> true given that sched stats are an integrated part of the rstat
>> implementation and io was converted before memcg.
>>
> 
> Excuse my ignorance, I am new to kernel development. I only saw calls
> to cgroup_rstat_updated() in memcg and io and assumed they were the
> only users. Now I found cpu_account_cputime() :)
> 
>>> - For every cgroup, we will either use flags to distinguish BPF stats
>>> updates from normal stats updates, or flush both anyway (memcg stats
>>> are periodically flushed anyway).
>>
>> I'd just keep them together. Usually most activities tend to happen
>> together, so it's cheaper to aggregate all of them in one go in most cases.
> 
> This makes sense to me, thanks.
> 
>>
>>> - Provide flags to enable/disable using per-cpu arrays (for stats that
>>> are not updated frequently), and enable/disable hierarchical
>>> aggregation (for non-hierarchical stats, they can still make benefit
>>> of the automatic entries creation & deletion).
>>> - Provide different hierarchical aggregation operations : SUM, MAX, MIN, etc.
>>> - Instead of an array as the map value, use a struct, and let the user
>>> provide an aggregator function in the form of a BPF program.
>>
>> I'm more partial to the last option. It does make the usage a bit more
>> compilcated but hopefully it shouldn't be too bad with good examples.
>>
>> I don't have strong opinions on the bpf side of things but it'd be great to
>> be able to use rstat from bpf.
> 
> It indeed gives more flexibility but is more complicated. Also, I am
> not sure about the overhead to make calls to BPF programs in every
> aggregation step. Looking forward to get feedback on the bpf side of
> things.

Hi, Yosry, I heard this was discussed in bpf office hour which I
didn't attend. Could you summarize the conclusion and what is the
step forward? We also have an internal tool which collects cgroup
stats and this might help us as well. Thanks!

> 
>>
>> Thanks.
>>
>> --
>> tejun
