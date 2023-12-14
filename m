Return-Path: <cgroups+bounces-955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE88124E0
	for <lists+cgroups@lfdr.de>; Thu, 14 Dec 2023 03:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B321F218A1
	for <lists+cgroups@lfdr.de>; Thu, 14 Dec 2023 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F27EE;
	Thu, 14 Dec 2023 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Jrw2Cmwp"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912085;
	Wed, 13 Dec 2023 18:00:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCR5A9OqoDwJEDRPSyMOy1Bb0BaIutvs0JKvYznb3I7n/T8/M0J4pywp2eLptZbjcfRxYIUhaeTPRS2xEcDyAA70xUWDC28reMfzA9+0p9E7Kp1xb79Sri9xsJlEakxmMs+HfQ/lumBdtzdG7dy53QE7JHAgw3cI7OEmXtD+pNfHUiOB8KQCvV2cFWzsxq/vvnL+tWktGz2L0pQFo4koF2VpiwODHwDaR4RQnDJQLZAT8fj2aRt/sp1NMsaEZFxr4v2V8XHrjFJ0jHmrlp6UXvvaed64gCVEwuD5k05YH4niNOPsamo8Hht7Z2nvcw3iu6GbaZb7QRleODPtm2mp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y82Nd/YJx9qdkMAGHqRyRRsCkFlY4IgWXddrILjk7b8=;
 b=A5kFEvME5JaE4kL7rLdsSASob4fPBNoK61alFxRNPGYzBT38bhjQPFuiKRqOd1JODF9zH3nyECa1v51rLtprNWEdailhg9TDV7JbWrnAsR6I+YU7QW6E5wasouT1vwtrm8Us6lZ1IxnNOSgQyCswYNHnlHaxCc9mPijoSa4bnlaRyu97IbmYddYF4TJuxEPZlOatg/bUelEjty2MtPgXYAzvc0DwcfwrAUPa7GySYEYcEDygL7aNYaviA7qO5uawz/xatprdhc9dzwaBu70moX2VItqc8/dAmT7X27sgzSrhzx4FLg5rKnxLq5suyVnf0QMHCJ3tnemsgsLp1CERNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y82Nd/YJx9qdkMAGHqRyRRsCkFlY4IgWXddrILjk7b8=;
 b=Jrw2CmwpCzoecRzH6ue10BbZGoDWB3ZterBaWrpH469bRfuEITGpdJJNjDGlfoSQB5ZuJ/mnXwWMJT8Lv1vQDB25SE6EQ75FrQ0WAYE7cOluTUnGJsdaaKl6SJCcESW2YbTVAvDIHPqVKzIVfJ9swMiWuF9Ma8SHHjEP5MI6l0AOpCBaaOgcZXFXYms+GMZgv9xH9Qp2o1RYLKDwvaOJztHnUseCHMUtbYpjlXQOH9+xbPGXHtPAr4v/usbCDmhL0TccsfqsKjc3E9iSEmLghLzlUKGvUYmI1v6fRp4/9ORWinPwNbyWoiZH/97u3ss24a3kTkYft7bxjfZ2+uS9cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI6PR06MB7562.apcprd06.prod.outlook.com (2603:1096:4:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 02:00:11 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%7]) with mapi id 15.20.7091.022; Thu, 14 Dec 2023
 02:00:11 +0000
Message-ID: <e40aa928-4bcd-4acd-924a-d2f154845908@vivo.com>
Date: Thu, 14 Dec 2023 10:00:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] mm: add defines for min/max swappiness
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-2-schatzberg.dan@gmail.com>
 <86984d9b-c955-4b06-9097-2a757b1bacfe@vivo.com>
 <ZXnexTxt3JE8mEMV@dschatzberg-fedora-PF3DHTBV>
From: Huan Yang <11133793@vivo.com>
In-Reply-To: <ZXnexTxt3JE8mEMV@dschatzberg-fedora-PF3DHTBV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SI6PR06MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c17c09c-c7be-4ab9-10e8-08dbfc48673f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V7PqWeog9BnIO8SseitkBlvIYc7GPyoQz31Lub450X/iUMukE+sR1iZJ35JfwJbthckDKJuX0ZQpN9Dd0YEIt5ahRWMYQ3EzSWRaV5jZhFWJFgJ2nnrDxqsdz9+PItnntLkdeglJgP1mqkO22EavlBzonfw2RUQdTMucHfRMrjbAzrscPqTAH/hrtEqdf2T7iMkFD8KNqzR9nqhgcMsA1UbDJeyJvAmmYN0Z9hUgSGAyRDUkywideIZ9zLKpG4S4nveF7C1yJEZPexgbJ45PLzuc9t2JkloasmC0zDjnK4dfxPeTCzJJBVvdMH6pczTGUw4mYzhYtUiP/BO487Lj5c/yscHQ1wbJF3pdHga5p7/D6H4mOJw5rJvqdBlkrCbUwKjObmOorzDiOhH/2aMAikhb9ZYLz99dDmMYvir/euQv/0MaRq/vSCRUBFUFmC+Lsy1KfNkiDvWzVwwwt3XJLDwtrXBdUJnjNQwv6QiiheEU1nFkrQjACo0QVbeC3zSpnhluoZfxqgrU1tGltpPN1uU0UlFXv3jecLOCtRsdTEfdXZ76P6d+e9BGldnjoKLt4n2BEbpUqD1fJQB4NH7oIfchWTxiBZHkbUweLjovQGcmCrksnf91H2rXYr8xZLQKuCnBPxOh74lIvi6AD02q7N7VPOqdGGUKOtwprPgqlHhHzjLpJ/xrpN3YfeyWX2IQBBBT55yzSVJaPhaatmrZCGc+BOo6XWEOXdmI2ydjstcmPHrtwc3OU2MQnWC7J9dW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(52116002)(2616005)(6512007)(38100700002)(4326008)(5660300002)(7416002)(8936002)(41300700001)(8676002)(2906002)(966005)(6486002)(478600001)(6666004)(316002)(54906003)(66946007)(66476007)(6916009)(66556008)(36756003)(31696002)(38350700005)(31686004)(45980500001)(81742002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVpTNjNFWHpvbEFvVERGSGdmcW1tUGhJaW1MUHY4Qzh3TEsvWExwbkxhVUlO?=
 =?utf-8?B?dm8zRkcrTC9UV2hCNldNa0gvRzUvUGFubEdvYXVLbnBZRlQ1OU1SUkNmT3dl?=
 =?utf-8?B?Qy9WQ054WGFKWFk2OGVPOVRXclM5VHc4VTFTNkpxN3RrYUprcU94NUFQREVP?=
 =?utf-8?B?Z09iaTRyMXQwayt2WnZrU1RUOUlYN0FVbEVlMkg4cTNjdi9McUllREkzaEZX?=
 =?utf-8?B?NkZ3NHBoTjlodUpWbWJ1U1ZXTUx4SVo1QUpJMjJuelVKQlExb0lOSlVPaFk2?=
 =?utf-8?B?TVBYMTdadGxlT0hSNWxpVE1jbXB1TDZaMVNReHVYYTFyQ1F1ZHJFV2pWRURZ?=
 =?utf-8?B?S0g4Q3BLUWpuZXhBNTNlOWhMdlhGU3hNTmpDbWhHeEE0SjI0dzlIRjV2a3NQ?=
 =?utf-8?B?TW9WNlcvdGdIbnhKOTMwWWc0dGdBK3NIQXhPWGcrOGtoWkxZalh2d1hqdzRW?=
 =?utf-8?B?N2o0ZXd5Zy82Ukg5RWREZWk1ejd6N3pTNWdNSFdLQVAzT1BTMHhyOE5ZWGFO?=
 =?utf-8?B?Tm9yYUE5eWUyMEhvSzFQTFBCc0xBVTFOZHkrZXdZR2RrQnQ0eElRVmpKbHpk?=
 =?utf-8?B?RWNxTyt6ZnlYZFo5TXM0MTlVVUkxR01XL3pnYWV0UHJQSzNSNjhLa2dEb0lN?=
 =?utf-8?B?anRPMWMvTEhGcThmclM0TjRuM2xNTkxsakVnODkxNkdnUXZEYjM3SCtVRVhK?=
 =?utf-8?B?V0JaeUdhTWlyNlljam14am02Q2s3Z0pzR0NSUHM3MCtrWm02UGhzQmF1ZHRM?=
 =?utf-8?B?WGQxZU9rMkgrRU9ra2hFRitIZElsWUtkd0Erc1Y0S0lzMmhoaklyVzBZMEJY?=
 =?utf-8?B?YkkrMVNtQzNiazhGdkZFaXNMN3RTQ3FNc1FwT3A1bTdjMGdlWU51WG1OVVFQ?=
 =?utf-8?B?OVhRaWtjMXhJRXhUSDRtTUcrOVlMcm5VTXdFUnRZTHNDeUVmeFdBWitIZ0tz?=
 =?utf-8?B?V2tBRmYyaEJvQWhYczlvYk9GazZTY0kvS2lITnBNMTZ3enhoMW1LRWErOGtz?=
 =?utf-8?B?dXF0NjhXNC80b2hLajVwWk9UV0FCb1RBWDY1cFF3K0d5R0hPdklzOFJWeTcx?=
 =?utf-8?B?K1ZPeWRmRDdrWlhFL2hHaXhnckEwaXQyRHRkNEpEY3ptd2Fzdk0vZ2xWTUZM?=
 =?utf-8?B?aTgwUnI5WmdhalhtQUoyTmp1dEFWWHlqbGovRHVsbkRIU0o0TVhBN2t2QWVt?=
 =?utf-8?B?WGo5RzRkSU9RbWZGT0FZVlIyeElUMjNqQW1NWGRXS3IzYXJVZVFvL2JhTXU2?=
 =?utf-8?B?bGxnZTZZeFgyMGFZR3pseEpxaktxY1AwZHFQNllEUUd0dXVtU3grZktWd1VK?=
 =?utf-8?B?YmloSmRXZ2pEczlMZVg2QnJPa0R1SUNJRU9VZVhrankvcW9RbjVsVUF4UTNT?=
 =?utf-8?B?ajNWcE56ajhJRTBKditLajFoMUhwcXQweHBZdnMvQStHa3N1bmRtTTY3WjFF?=
 =?utf-8?B?N3Q3cXBweTFXNzlTZEhRdFFoSWVMSUNSRmdzbG9UNG5VVzN6OVM1eU5meVdW?=
 =?utf-8?B?azdDbU1UVkJoYVRveFZSNVpUdzhBVC9SL0gxS0gyV1kzdmxRa1phNlJjdXhM?=
 =?utf-8?B?RXR1VkFpNTdhYmhkZURSdktOZ09obHdRUlRSOXMweXVxYVJ1VjlwQ21TZEhn?=
 =?utf-8?B?ZHpVZEVwOE5JNzI2bHdpYlM1RjkyVnRUdWV0WHdYUUxKWFFacjM3TUxWT3NE?=
 =?utf-8?B?UUZIUVRHYXJSUDA0QUlIeWdsK3REVjVoZ25EaVIrbzBJSXFhcElIRTE0S0Z4?=
 =?utf-8?B?R3Z5djY5VGZiK2t4WmVrRTJCSEFMS3Bnb3BGNVV3dXZQblJBYVNoVmZ4L3Br?=
 =?utf-8?B?WVg5aVBES3JLT1R1alFmVjlQLy9CUDlpRXBnUlZOSkxpOVBtcllPajFFMGYz?=
 =?utf-8?B?K2x2R0t2eGhmRzVkYThXS2Q1T3gzWWhwdjJhSTkzRDBoUVNnMFBrR3IzK3A5?=
 =?utf-8?B?T0srN0w5bE05NFpQQzFEUWNJUmM4a3RuRlR4L1NCV3VQSDZNZjROeUpPZlRy?=
 =?utf-8?B?WTBhemNyQldDRkk4bzdHYU1QdG9ldzZOZUZVMTU3V3hzRENJaWNzVnlKVzB3?=
 =?utf-8?B?T0JRVU9Gd3JBZTI3aHRkWFBad3llaFVSL1NhZmJsZDBCeHFXUXBLYjZPQVB5?=
 =?utf-8?Q?kA2yxE5vZkk4LsM0CzYh2NsNW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c17c09c-c7be-4ab9-10e8-08dbfc48673f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 02:00:10.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVE252FprsM52cLzBXfYdEoTmZgJMUz2GVP3D7uqgKK+u0eGuF3n+fsXkzYB54wud7VlV+RuO31O1uPjg+smAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7562


在 2023/12/14 0:41, Dan Schatzberg 写道:
> [Some people who received this message don't often get email from schatzberg.dan@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed, Dec 13, 2023 at 09:58:26AM +0800, Huan Yang wrote:
>> 在 2023/12/13 9:38, Dan Schatzberg 写道:
>>> [????????? schatzberg.dan@gmail.com ????????? https://aka.ms/LearnAboutSenderIdentification,????????????]
>>>
>>> We use the constants 0 and 200 in a few places in the mm code when
>>> referring to the min and max swappiness. This patch adds MIN_SWAPPINESS
>>> and MAX_SWAPPINESS #defines to improve clarity. There are no functional
>>> changes.
>>>
>>> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
>>> ---
>>>    include/linux/swap.h |  2 ++
>>>    mm/memcontrol.c      |  2 +-
>>>    mm/vmscan.c          | 10 +++++-----
>>>    3 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index f6dd6575b905..e2ab76c25b4a 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -407,6 +407,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>>>
>>>    #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
>>>    #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
>>> +#define MIN_SWAPPINESS 0
>>> +#define MAX_SWAPPINESS 200
>> Do MAX_SWAPPINESS apply for all swapppiness? If so, maybe better change
>> swappiness sysctl define:
>> ```
>> sysctl.c:
>>
>> {
>>          .procname    = "swappiness",
>>          .data        = &vm_swappiness,
>>          .maxlen        = sizeof(vm_swappiness),
>>          .mode        = 0644,
>>          .proc_handler    = proc_dointvec_minmax,
>>          .extra1        = SYSCTL_ZERO,
>>          .extra2        = SYSCTL_TWO_HUNDRED,
>>      },
>>
>> ```
>>
>> Here hard code swappiness in [0, 200], and now add a new define.
> Yes, MAX_SWAPPINESS is a hard limit. I'm not sure what you're
> proposing here - the SYSCTL_ZERO and SYSCTL_TWO_HUNDRED values are a
I mean, MAX_SWAPPINESS and SYSCTL_TWO_HUNDRED  all limit swappiness,
but  are different definitions.

If swappiness change 200 into 400, you need to change here extra2 and your
MAX_SWAPPINESS. It's wierd.
> little different than the defines I added. I think most of the value
> is just consistently using the defines in the core mm code.
>
>> And many other code hard reference 200 into max value of swappiness, like:
>>
>> ```
>> memcontrol.c:
>> static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
>>                         struct cftype *cft, u64 val)
>> {
>>      struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>
>>      if (val > 200)
>>          return -EINVAL;
>>
>>      if (!mem_cgroup_is_root(memcg))
>>          memcg->swappiness = val;
>>      else
>>          vm_swappiness = val;
>>
>>      return 0;
>> }
> This one is already fixed in my patch.

