Return-Path: <cgroups+bounces-344-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D787E9466
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 03:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F35B1C204D6
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 02:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A15244;
	Mon, 13 Nov 2023 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DrfeN92r"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618314C86;
	Mon, 13 Nov 2023 02:18:16 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755CC11C;
	Sun, 12 Nov 2023 18:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH51z7rYyrIlBpgJ7cAN6Dj5wv0GM6UKBTZBQXs42rK6+MIy/F8UQIkJQHMUhjyUuEzR2auYeKtNZ6EpDrnmHabaWSmc4qjj2FdNNsUepgspCznK/GCRUAvPube5haqqDjLMgN1HNOfxpSrkdDvaURKhivg0HSlWm5gJ3GrhiQ8dUIM9noHVnfbid8Q/JIhCMzqd9kY7qdCR08nu2+OU1yckJi/Hyvz6wVyRVqUbBWYBKdCg/rMYM+J5dKDKQAIwbxanvn07VN0eio1xEVu6Ho0jrjQLCeA6ERG6Octca7XzMEvXYYwVLpVLwQ2LdIL6echyz1joQy6AzkI368vDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szuIqKkd9yCYjeQoWjfALwwxcNt50ri+1wpUf3oBht8=;
 b=JTH9nxApg4nnOjCC0UiqMgD1vJ/QnqvliGmF5XGs3qKaL+A10MoUTOnYhQ1FvP38xHHJSEUWEEX5gH9xCXMtjimfbic6YblcKWQNkI45cgqpZZsZMOZKQ5VzIgVJiXPvHYWAV+RKUIBXR+QgNTWHw9rUs0L5lfQ3cEjrPXlwa0V6FH/ev6XG3IWZVzYQO/147Bxeg3xONCEgo2xku2EdXeYwG4Z2e60+KTUe2LI430QHZO+SmPalT+um77+tlKCYbGqZVNGtpC7mrMhghaKK4pmzxi5rHkvm+BS6Oa2xTqaWrwz5sgnyUyk2dfCEng8UXkkjGTobhh+rL3f0QVO/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szuIqKkd9yCYjeQoWjfALwwxcNt50ri+1wpUf3oBht8=;
 b=DrfeN92rjGET2REemuozYk8L86HDPhyFFX051mNAIO81cKW1VG827OK4VUfQFayAYqtI5+yS0tgQc2Ik/3GN4MT59c6lFMLKKSo2mftTb0Lgyqy1w+KCJs/Z/ikyrkEqMKSXzyjS760unbjD7VNBhfbI0sqjtolTYsCZeAmZk1SqZftY5B1fvDE9XW3N/i9KFmjHvS8ctB4lvC1DGZbU4PJaGFwmUcXMrzHVcjvGnE0Rr9dshodrKZpOkL5JPh5S0ME3HbECh3lnTu3zCyON5J8CoYItoeiTwPp9mf6vF4Wv2stVWt2coAbyIoxUeexYcmTQ53M2RBfPcOuH2Axijw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB7044.apcprd06.prod.outlook.com (2603:1096:101:1db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.33; Mon, 13 Nov
 2023 02:18:05 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Mon, 13 Nov 2023
 02:18:05 +0000
Message-ID: <b4694fbf-92df-4067-878e-6035df46582f@vivo.com>
Date: Mon, 13 Nov 2023 10:17:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Xu <peterx@redhat.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, Liu Shixin <liushixin2@huawei.com>,
 Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
References: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com> <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com> <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com> <ZUzTVgK_i05uiHiB@tiehlicka>
 <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com> <ZUziy-6QPdTIDJlm@tiehlicka>
 <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com> <ZU4g9XZvi9mRQD27@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZU4g9XZvi9mRQD27@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: c24aae22-41de-40a2-f588-08dbe3eec4af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zBOcfvYohemLo81bBCqpP5fBd1wN61VTzCKjwU2DzhFdrJsSyDR2gGUnLHbXuJhI3d4IAoQg9eVc28Vf5RQCkf8EE658X64K3v8saFI2SCYPlxEW97TgByhOzG9jY3tCZ7SCcfKxeGUNEmOpb4Yny3XQwYCVcark8fpKEYnClG6536p/riMlZpcWSHvfc6e6Yws9B6Ye5PzzExPckx8il5LquAH4Sq1esv7p4Y6giwUL4mx3sf9Uu9w34TYGix0frSuVstJy35reUA8fyFhx3heUdojGjiB+60vmezuJqckNucENO2etDaatu2hbbNOTwI4fK/4nFArGwZKeFQJitnDMEeZbr6zMl21meM4K6J1g/Gm0KUAKo1r1GTxqq+36r5+efRGZtXd8CrJrY0NwIj3QoHe2QRAsQZc5cI84dH+8mHGidv8cNwtTNhxSN11VxT0hKXj0TOwmvBcR6InYp/e7LHK5Q/ogkcrV0c+w4U2oq43psvS+NA8Rmf/IY+/FoxlUfVlusKfKq1BYABZsUsmJk7do45T6jPGWXGiXB+kXJOFAMOl4Hry6V6APYPFyxXFak2hRYEzYHDNVM4OhNV8Tb2kONA66lM6Vh4HxcXnLJu1VpWkXXVBk1YYTMGGqU5Jn9btM36vbGQnq30c573zy0oryydFu97EpsX3rkk8vt57rXCkCOCUTdzSk8sSk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(52116002)(8936002)(8676002)(4326008)(5660300002)(6506007)(2616005)(478600001)(6666004)(83380400001)(26005)(7416002)(2906002)(107886003)(316002)(54906003)(66946007)(66556008)(66476007)(6916009)(86362001)(41300700001)(31696002)(38100700002)(31686004)(6486002)(6512007)(38350700005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjU3RnY5cnp2NjNneGprYkxlRE5SWHpNM1FtWFl4b05UNkxIMWJMdjBUeDU0?=
 =?utf-8?B?cldhVUZrKzc2eTE0bWRQbkhaTFkrRjhYRXdyNFJxU1gwT3lvM28rdnRwU2xR?=
 =?utf-8?B?TXEyZjFSQVkxNTRHWlBidWhFQnRjMjVZbW03cEtkVWh6cGR1MDd4NE1tMExu?=
 =?utf-8?B?ZHBsOVNFT1JxSUxNVThMb0RSVDdLd0E0eTNsSnBuZW9XalEzWmNMOW1nQnBE?=
 =?utf-8?B?ZGVKNXk0eHNydit5a1ZuZ0F6MDZaK1dWbSt2amlFczd4ZnZGNWN5YStOWjJ4?=
 =?utf-8?B?UHlYSzludXp2d1duK3JXVTdRMzRuVk9iNmptQ3lOTlJrdUtkR2tRVmwrd1VR?=
 =?utf-8?B?RlhhdG1sdzhjbURsUFBVVjJpSEo4Y2tqZG5ySExBSHYyYTVmendvbUtyMzk0?=
 =?utf-8?B?Rk1EZXl6SHpFUUNKWHV2THd6TnQyRHNqRXBUVXpJcUJCZzhaaUpDV1RuSVcr?=
 =?utf-8?B?ekk4ZTNvQ3UvYWZtNFRHNk5MTnp2Ry80c1p2VGJXNm1YWE05WlZUcEVIRURo?=
 =?utf-8?B?eWJkdWpyTFloTVE0WEYrRlh4eElrVnpkVWxUMkgvU3o3RHNCRE80dWhHWGw0?=
 =?utf-8?B?c0NXQW02VlN6ajB5QzVZYVdPV05aSEpKNTJRc2xpQ2l0TGc3RzJGU3lBaEND?=
 =?utf-8?B?d055ZEo0bGdNRmNtT002d1VwRTVWaVZPMzdHSDRiMDFZcTljZzdBZ3Faa0tB?=
 =?utf-8?B?dE0vNFlzMG9IbkRLbmlqaHM5QXNCamhWWFp0UE5zdDZldGZqQkxLcFBoZ3J5?=
 =?utf-8?B?UU1ycGpNdjNMR1oyeEF4YlVaSWlJbnlPb3Q5cXlCcFB2YktLU1dOTUhINWdV?=
 =?utf-8?B?SGFwMms0eEpJMmxTUDd2TFVmcjNRUjZQdXBMRlRXSHE1S3NweWU1bE9qSVQz?=
 =?utf-8?B?dkVNUUc1czdZZTA2QjZBT1FRY1ptcE1NQTlTZzZqUUlvR2lhQ2hRZ2hnd3B6?=
 =?utf-8?B?SHdqdWRpWHdiZjNLMTd5UXkrSXpjZFB4Y2FzcUZHSi9TSGdwaHJGL2hOT2ky?=
 =?utf-8?B?WmdVU1JsQTZ3anJ4dlE2UkhIQVF0QzgzUjNWSkNKOWZKQjgyd1duYmlMUjFT?=
 =?utf-8?B?c0h4b1V1TXFoQkhIMjJRMXhrYWNaVUR5TEpwS0kxWE5hMm1JNFVmWUk1QnIr?=
 =?utf-8?B?dTN5azdqWjMvNTc2RFJxMHFrY2xSUDdzeS9xNlJFODNGTHluTzRNblpucnJ0?=
 =?utf-8?B?SXFyQ21MODhtWkZVU1Nrbml2UGVKV2NNTWY1Sm9na1pqTHZwTUd1ZVJuaWhB?=
 =?utf-8?B?VHM1YlJ5N2svenVJQ0ZHNGVkaEIzbkU4eWJsTXlPOW1HdkZZeXdxZ0VXS3d4?=
 =?utf-8?B?UFlvMkVyMUI3YUZXcEN5TkN2akxESXdzMmliZlgwbUluVk5Sc3MzMnhybjJt?=
 =?utf-8?B?cE5lYSszZTUzaHVkaTlNVklWVVVVNWhlcFRGbFdLcmFJM2I0UktBOTJvYm8x?=
 =?utf-8?B?dzE4MjA0Rlc0eVNoSEppa0NTT2pjNlBGdUN4Ui9vaHFSN3JxbXpTWjJvRnU0?=
 =?utf-8?B?VU54ZzJkRGM1MmNncllnRTJydVVOSVZlaEwxNzJ4N2FiZnhEV0tZbXBwbTBv?=
 =?utf-8?B?QlJFbWxSK0RPM0NIcWxJZlNOUlczLzcxeDhUbGZOZlo5Qmw4Wlh1a0V1Vmkx?=
 =?utf-8?B?b21lc0xHbGFvTzZEakhXL01tUVArT0xQeDFtaEg5aEVYSWkvanJRdndkbmFL?=
 =?utf-8?B?Y3AxR0ZHNkJIbG1nWVU2dG01RTZHYmVhMDlRdHBiM09oV2VURkpRQWRlTDR2?=
 =?utf-8?B?RFBlbU10eXVMZHcxckhXUFNUZWhnZFJLRzNBRklxTlptUHF5a1RsdG1uMkZu?=
 =?utf-8?B?MDk1REE3N2dnenJnYXI1V0ZHZ0g1SzJUbjljaW5xSWxYNVRaWkJndUUzYnEr?=
 =?utf-8?B?YnNINjNBdGROblA3bCtEdndaNXJrMW8ybGtzVkFHMTBDblhNVkgvaU1BUjZ2?=
 =?utf-8?B?TVNuK3ZDZjZGRVdLYy9LQUNyYTNqN3hFdFpDY01iY05XeUtzb3V5cCtSUFJF?=
 =?utf-8?B?S0N5THF5ZXBHZGZGcXdtVDdNbmFkMUZ2b2JEQjdHd2t4NitKWEVtWjlTVW8z?=
 =?utf-8?B?S2d0bGdhbDRna2dkTGpzcS9mbTlCS1FyRUxVMm5GdzBmY3FKU0tSVk83NWUw?=
 =?utf-8?Q?1z6LG6H0uqucpVdDrh8KT+R4u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24aae22-41de-40a2-f588-08dbe3eec4af
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:18:04.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR2xppzRSkBjR+/gu9av0ULRKu3QXVTaW6AheuK0nihNRZv/Gi2MlFovTgB3yzKyJPGdIW/oAvnajZH1KVMRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7044


在 2023/11/10 20:24, Michal Hocko 写道:
> On Fri 10-11-23 11:48:49, Huan Yang wrote:
> [...]
>> Also, When the application enters the foreground, the startup speed
>> may be slower. Also trace show that here are a lot of block I/O.
>> (usually 1000+ IO count and 200+ms IO Time) We usually observe very
>> little block I/O caused by zram refault.(read: 1698.39MB/s, write:
>> 995.109MB/s), usually, it is faster than random disk reads.(read:
>> 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I change a
>> little to test UFS.
>>
>> Therefore, if the proactive reclamation encounters many file pages,
>> the application may become slow when it is opened.
> OK, this is an interesting information. From the above it seems that
> storage based IO refaults are order of magnitude more expensive than
> swap (zram in this case). That means that the memory reclaim should
> _in general_ prefer anonymous memory reclaim over refaulted page cache,
> right? Or is there any reason why "frozen" applications are any
> different in this case?
Frozen applications mean that the application process is no longer active,
so once its private anonymous page data is swapped out, the anonymous
pages will not be refaulted until the application becomes active again.

On the contrary, page caches are usually shared. Even if the application 
that
first read the file is no longer active, other processes may still read 
the file.
Therefore, it is not reasonable to use the proactive reclamation 
interface to
reclaim page caches without considering memory pressure.

Then, considering the recycling cost of anonymous pages and page cache,
the idea of unbalanced recycling as described above is generated.
>
> Our traditional interface to control the anon vs. file balance has been
> swappiness. It is not the best interface and it has its flaws but
> have you experimented with the global swappiness to express that
> preference? What were your observations? Please note that the behavior
We have tested this part and found that no version of the code has the
priority control over swappiness.

This means that even if we modify swappiness to 0 or 200,
we cannot achieve the goal of unbalanced reclaim if some conditions
are not met during the reclaim process. Under certain conditions,
we may mistakenly reclaim file pages, and since we usually trigger
active reclaim when there is sufficient memory(before LMKD trigger),
this will cause higher block IO.

This RFC code provide some flags with the highest priority to set
reclaim tendencies. Currently, it can only be triggered by the active
reclaim interface.
> might be really different with different kernel versions so I would
> really stress out that testing with the current Linus (or akpm) tree is
> necessary.
OK, thank you for the reminder.
>
> Anyway, the more I think about that the more I am convinced that
> explicit anon/file extension for the memory.reclaim interface is just a
> wrong way to address a more fundamental underlying problem. That is, the
> default reclaim choice over anon vs file preference should consider the
> cost of the refaulting IO. This is more a property of the underlying
> storage than a global characteristic. In other words, say you have
> mutlitple storages, one that is a network based with a high latency and
> other that is a local fast SSD. Reclaiming a page backed by the slower
> storage is going to be more expensive to refault than the one backed by
> the fast storage.  So even page cache pages are not really all the same.
>
> It is quite likely that a IO cost aspect is not really easy to integrate
> into the memory reclaim but it seems to me this is a better way to focus
> on for a better long term solution. Our existing refaulting
> infrastructure should help in that respect. Also MGLRU could fit for
> that purpose better than the traditional LRU based reclaim as the higher
> generations could be used for more more expensive pages.

Yes, your insights are very informative.

However, before our algorithm is perfected, I think it is reasonable to 
provide
different reclaim tendencies for the active reclaim interface. This will 
provide
greater flexibility for the strategy layer.
For example, in the field of mobile phones, we can consider the 
comprehensive
impact of refault IO overhead and LMKD killing when providing different 
reclaim
tendencies for the active reclaim interface.

-- 
Thanks,
Huan Yang


