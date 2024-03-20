Return-Path: <cgroups+bounces-2072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBB88104D
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43581F234ED
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C819439FFD;
	Wed, 20 Mar 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vy0bi5ld"
X-Original-To: cgroups@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2101.outbound.protection.outlook.com [40.107.104.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45987381AC;
	Wed, 20 Mar 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932122; cv=fail; b=DSb5FHeIFrs7l7OgnySFeqRIzuoDPlCpcZxvy4WsPaitStltg5Emhf4zZikyTeaz33/0zp926SldDaphm6EImSq2bchrCdkzt4Rn+Ygf7H9mPOg5x8llfWORqRvEHSNTtCoRUJ5HkWhgAflxeSCXCKztOqrqCL9vaDkrCVy+hoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932122; c=relaxed/simple;
	bh=NzvjaKLoqH2H9dQaFQkue56NAwZPYL70eUDEnYX2G/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CsZz42whCO3167s33Bu9OLSuwkNJ0fjvFN3jbIyM1EacBgtZDlRTxt5j5AF+XBbTmhcKYRVUY+8zru/6OXhJTzCpBDtAC0sbWqikR5ZnY/zOQG3HIAJrxiFGOng6L0ulwCgo/WEzC9MwgstBmUC2RXEaFgLI9/CVlFSUn5pWI2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=vy0bi5ld; arc=fail smtp.client-ip=40.107.104.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=monbVy1sP3JA6gWE7zSuAsPBZK44g34nNj32McsgFwqEg9UJq/Nx0SdAbTe3jQqKnKNM5V/ahfw74gI3aVugb9Hmvq6WHzTXWdH4plb1H/+f7MEbnBW5HZC1nG8TtUEq82h6o+plUHs98RzSjewkCPjsnwsl4xa8t8cfgltkC0GNJws/Dfgv1nAdg0R4JCkCAMxbLvD7LuqJ1MpwOHwadCasRv3th6magZjsmSIcaXzhCiT0BYjCGsBkV54kgzhLJ3tQ35aUkk8xuyIrCZt//ml6i5DRV+DwvVrPKuL2fsX+vHZWKkCcLR+DcIaMf9PWacOH3gDgV/pzzLVWoN8K0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Wn0hRJWYtMA2BHuz9foWcgH4fPaNPeLClzOhB/tZw8=;
 b=NqrwT+OGs4qkd5EOL6SyW56wvTnmTh+1H1pLVqCbY3uLY30oYiNk9/3e1UhMhaZ2yBGUmDKuPzT5rWp0BEWqUOvZNO3/bRSZw610SF+187/1l5eqjMt7lSDknNCcPOSk+wSna5Y5o815IJHfjaRlF8IFR79+JCZ09xRSDI/OalnbgEIBOn8cqbH/4ST4woZUIRhmwRrwTbk6u0NR09P0TFsXWSOwU3MkwC3g0qjgswVHF7LPXs/fpVZ4IinZnpiuwVOOJHmN6uzUEFgrb277/wFCB6VTYf2k73fMm8obMQWU3l+VgzOHLRAVrUc1xYHe6pJolQgF8/ttJwDDKHU/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wn0hRJWYtMA2BHuz9foWcgH4fPaNPeLClzOhB/tZw8=;
 b=vy0bi5ldpY0w2/enwCAgja2sdmrKAXGr0JaVpESIibN+V6wZvrfTAZwoQ6XjF9THVSItkC82BcPPzVzKEI3afgKLdX5XOhT303smUUfmgfkN+QEYYoCw3HP8nHkb1WZanCbReA0KblVgmXKgqlSR1r4Z2ZhLlMUXel9Kl6Kh9hUfpKpBSp7eCu5obbYyxu2jyiCtAaUQn3Rl/c/KmSI6FwRAGCSS2zau4TNGeaFLAWxjd4VEK6ELCL5ve8qhHocjIO0otb9TeD1skX93nx7wq3hwFB6In42KJgk/AheIte/Hn914lU+4IhtMQq8VchX1EJlH5wAGlFcNAjIP2UJ/6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PAXPR08MB7525.eurprd08.prod.outlook.com (2603:10a6:102:24b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 10:55:13 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::ade0:bad9:96bb:6bd0]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::ade0:bad9:96bb:6bd0%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 10:55:13 +0000
Message-ID: <be8cfada-f4bd-4894-848d-1b7706b14035@virtuozzo.com>
Date: Wed, 20 Mar 2024 18:55:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memcontrol: stop resize loop if limit was changed
 again
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
 <Zfq6XaACmN2JssTW@tiehlicka>
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <Zfq6XaACmN2JssTW@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:820:c::10) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PAXPR08MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a8df26-7ba0-41b7-cb45-08dc48cc381e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kWxVfZR9tuAlImmuqTKdXqbxzFdUH0Co6D4222bxrFVGkzQVsb+TOi+GNvFfMOqcbhW3j188w5uQmxVzTKp8iV7vAKoIciM6ej6uwtxOjpDALaVjgYouIcE6eEV0ovLr4US4RbTLX/vwtg0PsDKhxqDVahuvw2yswpYT1ZWSu3e5+1rdwm5O+uWhZSAbl4t/IYHC0t+4YyQd4q5lrpudEgz96QNHN2QwLMuXzDtdp9CeeJO1zuyQoaYRN2nT5PWFaLUdocOxcs8qxhe8cmdT++uRkoMdZLrDWaPbR6tfr6oQpkeAJgs1Ml2MERf0JBFIgRMJaWbqicUYLuq+Q08Gg64+WYrDY33S8x2LerGcNrTVT/zGug4XT7Y/QyBjEcjjWoLRKSmgbax6CVJRVglGwgEkNW4eppEXzGFOSt/IRTrgsslsmbxCNdrBgIT1NScxFt2LYuW9GW2if0BX/J+MylAjARH8uFT6mEpcZ5FN0ewcxAq4IZRILFhJlI3FnoF6usyYC/cScnZQPklkpYhFLXgopgfbUalZhmwCc1xBFqGVYqXvoZ5uf+W1mtCcH5wM4EyXKNaHM05QIu0Raa42jSTR8U9yEXCiYr0ya1OcfWshfG1tlJA9ub9UhUx6V39200OHllmJKxvtwXNRufecLuaBZTTJB6yXFe2liEB4BYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW16SWRlRmNYNmNQR1VyempsVmVPZ2lKdmdwdGJWdVV0OWpReXdxMlRQSXll?=
 =?utf-8?B?T1JMRWNiZDBwVTFiMnNzaFJGQ1pOVWNLdFo1eS9sK1JyTXN1aXNsMlZmeTBO?=
 =?utf-8?B?RzVvZ0JHWDllVDlDOWRHTmdja1lwWFFrbysvekpXM2NXN21ad0JXRlB5K3VH?=
 =?utf-8?B?VWZnTXN4VENIS1RieENpMjJHRHpWMEVJRnRoUTVDS0FmeE5qUUswc2FvVms3?=
 =?utf-8?B?ei8rOWIzRkI0MkNSTERFODh1cXlQeEpwamV5TTNmcE15N2hyb2tnTXc0cHg4?=
 =?utf-8?B?dXBKcENFUFZkQm9pUWIwalBUWmthN3ExN0tvdUsrMEpLNExVMDU2bHdTcTRs?=
 =?utf-8?B?Y2hzdVFJeklSYnc1Rm9LMndZZU9PNWdoTjQxVmVMQm1VL09ZdXFoTy9UOGg0?=
 =?utf-8?B?L0J1ZFduVDd6M1ZFQWF2OHhVbS9qamtLVnRxNDdZaVNPb2o3VXIya3RwZkY2?=
 =?utf-8?B?YVJIVE9CRW9EZGlaY3dCdzZaLzlYZjBvQ2dBVitQVHFKY25MdCt5QnNJMGdX?=
 =?utf-8?B?TzZEWFYzRUFDWkwrbnBjM0hEbGxlR3pJZUluUHdNU0xFeDZHdkJlYVBFdUg1?=
 =?utf-8?B?Tm91dUhNaFFFbGdyd2ZTY0dpSmpwTlRaQmp2MFBIVDBnQURCVEdZL1FFdWZp?=
 =?utf-8?B?QVl6YllMMDYrNHFMUndUTkRRME1iNzJocldNVlpxRXhwa2tBSytaV2p5d2xy?=
 =?utf-8?B?SFAvZ2dpVmhMbDllT0lxWkNJNHV2OUNtS3VoaTEwenNoKzFSMWFLemlXSlJB?=
 =?utf-8?B?Q1UyVUc1QStFdnlaYWRnWCtIeXNEN01SVmhBV3B0cGcyaVVqSEV4cGFTUmRa?=
 =?utf-8?B?cUE1S09Lb3R5Z0hCenVTWUdRdHhHancxV0orenRhYnFoUEFhWGxDU3VybFk4?=
 =?utf-8?B?VkQxNmRwazFVY3JVcE8xejdkaHdibnpDWUMvTlJHTE5QUjVRZzBQLzVZQUJG?=
 =?utf-8?B?TzZtem5iU2VJYVZFSUZDbXFMdzVrV0c4ZWZSNDhLYnExaktTQUZOUzUxeEFD?=
 =?utf-8?B?LzZ5MXpJbGkrVXNHRDZKK29NUUh4bXJuRktaaGx2bXdZMXhkK29QYStjYzVq?=
 =?utf-8?B?RmxENEpka1FMR09qbGI2YjcwV1podkdJcDhPck5rWnVJZ0RycUV6ckp6YXFZ?=
 =?utf-8?B?RHhHR2s1eG1FTlVDalpuOGF1Q1htYlVBcmMxc1RRa0FOZ2dJNitkQXY4cXgy?=
 =?utf-8?B?czJ6WFRyZHhtSlZWNFA2V0ovVC9pUFVYTW5rdVlPeXBNWGZqd0dTejN4YWZH?=
 =?utf-8?B?NzJ2RnZHWWhNKy9tYlIvZkVGcFR4OVFqZE0rTitDY0k5SDQzZkRZTUkxaEhy?=
 =?utf-8?B?UUhveGV6UGNaUUcvZEVFWExlYk1YeG1CUlFRVlFYTkUxRG5wTGJ6RVg0eXds?=
 =?utf-8?B?aE8xaEUvWkJkVUU4MGxGeDRoRzZLbHB1ZWpOQ0xxNEFzazdmQ3AyN2Erckt4?=
 =?utf-8?B?U1FjSDdtS2FDK1JxNElFdm5YQkc0bkl2VDNiUXBEK3ZPOUllZ3RtUzBiY24r?=
 =?utf-8?B?RmM0bTZFK09kNEU3TjRabHdYa3FyeUFtWUNaS1VWcjhHMGJnMUJxSGVwMld4?=
 =?utf-8?B?Y3Q5dzhnVW5pckVsWFdrQXUyUE1mMy9pbkRGKzhNTThKamo4dENZenR1US9R?=
 =?utf-8?B?bEdpUmJjU3NWbFFHb2xFeHJmd0lHSnZzdG81cTNrYUx4U1M0LzF3UXB2bkJO?=
 =?utf-8?B?ellFcHBVSEFpYnpKbnVZRDI5UjMwUW44UHZQLzJkR2hDNmZGZHNjQmlQOWlO?=
 =?utf-8?B?cFlXUEl0cnFjOWZQRzZiUzI5TkVGWVRKR3V3clNvaWhvTkJGV2lkakIvYU4y?=
 =?utf-8?B?a213TWhBVlFUbUpYeUlrb1BVaXFTZVQyT2pIYnRRMW5jaDVoR1BTTFhPd0Z4?=
 =?utf-8?B?dU02ZlJKTjNDZkVpZUJoYzIwdGlFOXptUE9pSkVLOVcxNzNjQmFBMmpsVkto?=
 =?utf-8?B?Wm1rRHM0eWdGRXZhS0RHbDJ1bjN2bTZCNG05ais0TmZOellOMjdoV0JDaW5I?=
 =?utf-8?B?dEd1TDZjSlNuQnR4aXBNQzFxZVRzR0ZlUytSbG9tVEpvc0FvT05IVEhFZENC?=
 =?utf-8?B?bUY2VU1ROFEvQXAweE5DSXF2dWxYRThZcEY5R3Q2TVIvN1lETDV5MHEzYTdq?=
 =?utf-8?B?ZkpLblBOdVd6OE15eUFTcXNUYTZZRjlsYlBoN25yUDBCQkwxQmEwZURlT2tr?=
 =?utf-8?B?eU9kb2RnbXd3ZVB1RlZwYjZCMlpaQTNiQVhOdHI0MU85ekhObkV3WTUvRG8w?=
 =?utf-8?B?MW1tN0lvUWlObmFQYlJ0RHhsSnpBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a8df26-7ba0-41b7-cb45-08dc48cc381e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 10:55:13.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2jDTyb6Kg68EY1LfgnFNhgHWuMmBeFR52AxAErQnENLIhm2VH407t9fyUgxX69/m7DEjyQlRkdyrEYwnVPICKXR1B2kL+B7zWVRH3pZjlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7525



On 20/03/2024 18:28, Michal Hocko wrote:
> On Wed 20-03-24 18:03:30, Pavel Tikhomirov wrote:
>> In memory_max_write() we first set memcg->memory.max and only then
>> try to enforce it in loop. What if while we are in loop someone else
>> have changed memcg->memory.max but we are still trying to enforce
>> the old value? I believe this can lead to nasty consequence like getting
>> an oom on perfectly fine cgroup within it's limits or excess reclaim.
> 
> I would argue that uncoordinated hard limit configuration can cause
> problems on their own.

Sorry, didn't know that.

> Beside how is this any different from changing
> the high limit while we are inside the reclaim loop?

I believe reclaim loop rereads limits on each iteration, e.g. in 
reclaim_high(), so it should always be enforcing the right limit.

> 
>> We also have exactly the same thing in memory_high_write().
>>
>> So let's stop enforcing old limits if we already have a new ones.
> 
> I do see any reasons why this would be harmful I just do not see why
> this is a real thing or why the new behavior is any better for racing
> updaters as those are not deterministic anyway. If you have any actual
> usecase then more details would really help to justify this change.
> 
> The existing behavior makes some sense as it enforces the given limit
> deterministically.

I don't have any actual problem, usecase or reproduce at hand, I only 
see a potential problem:

Let's imagine that:

a) We set cgroup max limit to some small value, memory_max_write updates 
memcg->memory.max and starts spinning in loop as it wants to reclaim 
some memory which does not fit in new limit.

b) We don't need small limit anymore and we raise the limit to a big 
value, but memory_max_write() from (a) is still spinning. And if we are 
lucky enough and processes of cgroup are constantly consuming memory, to 
compensate effect from memory_max_write() from (a), so that it will 
continue spinning there forever.

Yes it is not that bad, because memory_max/high_write() also constantly 
checks for pending signals in loop so they won't actually get 
irreversibly stuck. But I just thought it was worth fixing.

> 
>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>> ---
>>   mm/memcontrol.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 61932c9215e7..81b303728491 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -6769,6 +6769,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>>   		unsigned long nr_pages = page_counter_read(&memcg->memory);
>>   		unsigned long reclaimed;
>>   
>> +		if (memcg->memory.high != high)
>> +			break;
>> +
>>   		if (nr_pages <= high)
>>   			break;
>>   
>> @@ -6817,6 +6820,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>>   	for (;;) {
>>   		unsigned long nr_pages = page_counter_read(&memcg->memory);
>>   
>> +		if (memcg->memory.max != max)
>> +			break;
>> +
>>   		if (nr_pages <= max)
>>   			break;
>>   
>> -- 
>> 2.43.0
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

