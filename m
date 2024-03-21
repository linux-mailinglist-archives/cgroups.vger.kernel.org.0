Return-Path: <cgroups+bounces-2083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B796D881C18
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 06:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A9BB216CA
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 05:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2892DF84;
	Thu, 21 Mar 2024 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B+tYwAho"
X-Original-To: cgroups@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2116.outbound.protection.outlook.com [40.107.105.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D92BAFC;
	Thu, 21 Mar 2024 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710998165; cv=fail; b=KXEdUTKCKbM3c9xbIkGhlivTxIxRuU9zaLp2cu98XA0SjuXB6iC+kGukgBqs1ciKXcWnvB3ud38fc9Q1LhJxk0J8VXxjMH2uSLzFSmEpnWD3V+UGkTgS1NWIUl7ICBT6v2pmiYSRd3UXnptO+Q6cWinLU/IVqkobgIKwS9Y7ycE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710998165; c=relaxed/simple;
	bh=iEDeu6RIkb8cfJIUhUqTW3wjjFoh2ZYly4OoFPHzrS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QvhkbLC0C76BNvBjzIkp9KgG0DS0KWNKdLO29dO1sLoyoCGLZ2XqCPqs3T+5aP+/M08mZwcd5zyniJ9+AAhL8Qt4IMr0SrX8/CMI2NDk+jmzSY/rqQrxDk+VgWQDWuQYmAv+fHsK8xik3rfg6H3g+7ekuWhl9yPNLNeCmsdbxS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=B+tYwAho; arc=fail smtp.client-ip=40.107.105.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYLWd/TqKt+J9lBJyEpfFd4DpwUFlMxITvMeHeLhmCsYfoo/V+EhVzmO5WSP/avG4J9ySv+D8beuHe3IqFIlJFaV7BtQ0+4+V0BC188edZxJpTRVyRxS8cTjjWvq2WkkmCAX7rdPSSmPaD9ZMocSQobYJ7s3fHYsjHJPOw1tiuwjoMocTZzpJoMC+Pjouew/DnLer4L/0+E3sq+MuGIyslw1NkCiLjFY6rsalTZYrZUd5bNYXErnW0EO32cHGkXH/32ql42edsQ4SooSm0NSr/s4ie9infmeJnfgRtl7hFPMm2TkPUYcIuhLmD5aHrWRqwqocN2MsNZXtDdA/jVnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifKpRFYOFSu2iWP8ZfqmJ9iNJzm/I71w3gav264Brl4=;
 b=ROSpgfeyfu2ScYK2YL/OjteCbM0M7PlTJCxZ8WANSySoZ9Tom7ZVKhvRdadp5wN9pqueuTPizxZ7TRBInYPG95fBV7d170VOTsly3aHzWVxdhWykA8iBBQtAt7iqIqxNHYVAyy3/prsWK9OAz+oHkyrXbTaErlb4NqLH2ZsWLQAdA01dGhm1o9GJLi6KeGLwmusFqR0jmdm/q7UyojaDH0cRfJ15G3QcHMBXJG2MBu/77LPlQP6LZYFYxwxCj6pIbqjqtabWbVvnDiK4DwS2G3SQYdgJeyvI/uQhKkD8Dj0uRXxmNCxXp35/gW/ukqng6sM1HVs+yybCfdektr0J1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifKpRFYOFSu2iWP8ZfqmJ9iNJzm/I71w3gav264Brl4=;
 b=B+tYwAhoIRhcZvIGR4r0TcmBVOly1vZE6wXh9PZH5jGgIbp/pxaCL+X83AuH4iSHHkYvXZzv/USvHG5TEOmvH8Lky6Q0ImJvfXXoGoUlNNiXh0euvDYVgN20iausXw3Pj2VQ+QpGvJJjuVZM+/aTHTIZefnzeiJskj00NAjHDMoMvJgDGCG8ge0OlsDG/gZLaGmDbYtbOrPJXtjqGKB6LqWRdDS2/qn50lMbuwyUV2rK4KL8kBMg++DVlrrflHdwnNWcJSGUcr99F9GUhJJ4i63ltcO+780mhIMh5shk56cD6PMmRCWqFXnf3zTL92k2I/gL4xv113QAPrK28+vt7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PA6PR08MB10396.eurprd08.prod.outlook.com (2603:10a6:102:3c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 05:15:59 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::ade0:bad9:96bb:6bd0]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::ade0:bad9:96bb:6bd0%3]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 05:15:59 +0000
Message-ID: <18c39901-d1bb-45ab-86ae-1a74c3ff8060@virtuozzo.com>
Date: Thu, 21 Mar 2024 13:15:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memcontrol: stop resize loop if limit was changed
 again
Content-Language: en-US
To: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
 <be05a470-bb31-47ef-b786-557c347de429@redhat.com>
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <be05a470-bb31-47ef-b786-557c347de429@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:802:18::14) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PA6PR08MB10396:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a051618-168e-4db5-b5da-08dc4965fec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UDS9kcmX1+NURAUsBMc1nTpaI5tcaIelFouW/Hwct/M1o4dpgodZqFAHlWozNFUdEx782j6qZ6tVOR1c7TO9xNLe4sTcc+PLcyJGnX1LnP3+fJv6JCLtEPLqbI0SUk+3V4agkakUCpZl5j7adJVOYhF+SRVrjR4EszudQ4NTO5Jf54Hrp/5c8TMWEhaq+JJW5D+An71WavqK/Euvr8UxxMkWg6cQ5f16aa+ttDlrUJR36V16rL8e0rVj20qttJhfGJ5CBZrYWpr1LTG5jWb2ytloqpmNJ3ESJamsNCSRAsAIh5XjuUSPfvvkQSmwaqsMLBjZfxnMUIFAK/fGxdc0fEkRjVwDMAdKxFnBK/K7LVoA7vw1x2qObvj4LCaMkT90tDkV2Gl2cHVuboo5oG5w3bKYZ8n2NR3Hd5UrxtO+yGkLiwGX+7wjKP4bim/kp4i4n+jE7aHTEKZfSZ+ZoTS58RHQhcxmb+QqXPCMGyMzWDGFiCiuCwysvWZUF+KDsz538r3jcvY+oL/QvfAtfp1i+WvV99Tp/2iYhhhw+BMMGr6SBjuYhKSNSoG2PHF0R5/GJIt/t009RUD98D/dNRzzpGmA7KwDa4V8guc6SdTPTlzQgcIwh7kj6f9oDlQyLwApGwx+lLIfDHDR1/FRI7BoSRyDmwHBT3Yo40xt6ZMIN+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGNIelFCMFdoUUtRbFlVREJYQ1NOQ0VlWkpJcmFXN1lSSXJ0WDFGcEVjQWtv?=
 =?utf-8?B?VFNwVGxLei91Y2RMTUZpUjh3NmlEdHlubm9xaUI5NHV2U2Q1dk1kajZEZ05D?=
 =?utf-8?B?aytkTXNPMDFzNnRaWU5xRkVhWGlPQVhkNS8rd1NTb2dPM05idWNiZnptUk5r?=
 =?utf-8?B?TmdNaVVJSzhFc0RMVlhKc0FsUDBKbkowSlV1YkN0Q3Qza2dDbXlSbU4vZzhM?=
 =?utf-8?B?Yysyc1JDdlEyUklzdzdyZDFzM01PQzNjS2tCb3R3VDZYdnhyTFBpakpMelht?=
 =?utf-8?B?Ti9ISlFLeHpwSTFyVk0rV2ZFOWJjUS9qU2p5eTdwc0Y2cWNidjhLZ0lndHYz?=
 =?utf-8?B?NVlUK0Z1T3F4cGN3T3R4c2Z6Z1Z1WmZxZUE0dlBQdml0QU1Ma0o4b0JOZDVn?=
 =?utf-8?B?V04yWlpJYkRuN3ZiL1JlamVYUm1IYnB5SXBQNG9DUmJFMWh0SzlObWtkbXhQ?=
 =?utf-8?B?am8yNFlSWGdlNDY1K0ZFeFgvRy9pYWRXdDY0QzhQcGhIdVB1bzZWZjhwWDhH?=
 =?utf-8?B?OTVRbzhPLzFxRUluQTlYc0ZiSDdyeVltWXpIUWh4MWpPL2VpUExZWkhXRXJD?=
 =?utf-8?B?Q1JXQjNDWkNkTFVueVJTeXdMMnpKWGdSNDUzdTVRTW16UTJwcjVpdWhmM2ZL?=
 =?utf-8?B?R3JCamV3RG4zSTAzS0VTUU5JdUFlVEtTTHVZdG9NZzZBTFZpYkNzY2RzUllH?=
 =?utf-8?B?d0pCQUR3ZVZxYjNSV21ENHZxT3FZa1g0Ti9hYURubm9CR09odE9wTTdlNUZw?=
 =?utf-8?B?UHFYOThRSisyOHBWMFJYL21YOHpzbmlweG9uZkhwc0tJK3dwVjl4Tm5ObUlW?=
 =?utf-8?B?Rzc1NHBoSUhVS1F2K1RDNFgrRnprK25keitJbXZOWFk1NmhHK3JmM2plaG9H?=
 =?utf-8?B?VmpvSGhsTWRJbnBTa1RLbUVWb2NRZHk1TWs3bThSQTZIUEgveHRBaGRFVTUr?=
 =?utf-8?B?ZHFxRXdyRGRLQWtjQzkwV2ExNUh5M2xqWWV1Y3BKQUZFTDJ3MHIrS3Z4VXNT?=
 =?utf-8?B?YjFPUytQaXFBUWsybUpEM2RmT1NDaFlPcDJ3UWFZYjFlcWpaTFMyTW5CV3F6?=
 =?utf-8?B?dEYxaEV1UWtUaDJYVUt5aGVJOGk1RTNlUEE1VUVpNjRaWnIxS05TUDlySjlH?=
 =?utf-8?B?VTErSVRsUmNZS0Y0YWRHam0xM2YyUnhUTlNXZWhkYjFqZFpPcHNkMXRYTUQy?=
 =?utf-8?B?Nm9IQVpBUzNaamFLZnRUNC9DZnljc3YwS1pXOGtjbURyNVE1OWRvUjFnN3Q2?=
 =?utf-8?B?ZHBycnEwc2V1YzkzRDk2MHNGaUxyVnRIcjZadjBpQ0lndGdFTWtBa3lna0dN?=
 =?utf-8?B?YnA3cDNyZDVvZVdJZ1BLcFhqUkZobjBwTzhEYW5JQVdNWUJaVGp3Yy9SMWJM?=
 =?utf-8?B?NzVhUkM3bkNncHBWL1hGdEpRV1F4MWFJY3NIK05oNXRGSnRGbmxJVElxWU0y?=
 =?utf-8?B?QWllbTRqUVg0bUd3Z3BKRC9WdEF0R2FYWE5YQjlONnBPQVBvQWFHZTFlazJS?=
 =?utf-8?B?amYwM3NpdTdBU0VvcDVRSHQvN2lTSlg0cVpIZGRGMjdjWjliei9NaDNJeFJp?=
 =?utf-8?B?RzgwbmtqeG02elBJeVBXdms3K2tsL1pucEViWFBHa0licmlYdGQxcXExQ3BS?=
 =?utf-8?B?TU9ZSlpsOTlKcHkrMXJUS1J6VVlYUDNSVHhPYzZnQ3g1bGNpbEJKcFRoV0U5?=
 =?utf-8?B?cFlPa2NwK0pSbGNuSFFuOVNKY0tYM1YzaDlnSkxsaU5VWGl6aThHOHBFSndV?=
 =?utf-8?B?RmhzMEdLQ2NXR1NVeXB3K0tRSGlTdVlxNm9TcHZXRC9RNnF4Mi9ZbkhvOXRm?=
 =?utf-8?B?cHNuTk1PWWJqbCtJSjFJRjNKSHNNUS94VEI1c3d1a2V1VEF0NERUSWhqb2Q5?=
 =?utf-8?B?dXllb2xsbXFRZU5GV1ZLeXNsbXFwZ2M2RU9CUHd2R3F2ZU11bC9idGJBUkRv?=
 =?utf-8?B?UjZRSlhMRW5nZm95OENXcFJFZ0FRQXVZNFgxQXpORWVMc0g3SHpmRHJzblpt?=
 =?utf-8?B?Ris1c0Z2bTJlS2Y3MGNYZUd1dWtJS3dXcHVEaEF3VTg2YjVEYUtzR0oyeSth?=
 =?utf-8?B?S09VdTArVEU1b0hreXU0bWFneFZlS2ZFK2lXQitUYWV4bElJRUovd3E3WE0v?=
 =?utf-8?B?ZVNscCtLN1B4QVJLSXpYLzYxQXMxdWFhU3d6LzNkTHdMU016KzdjdWpWN2Q0?=
 =?utf-8?B?R0J2ZEMyV0x2YkxqelVXdUxuSXN0Y3BBWldYaVl6U1d5OTZhZWhIRHlJT0ZE?=
 =?utf-8?B?a09vOVNaeGtraU9SdUVpd0YvTDNnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a051618-168e-4db5-b5da-08dc4965fec5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 05:15:59.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g93jCpH2cZnrAGgmLNR/ztjyLC1+cnCJaj7JQNF0pKRhEq0Zs8RB6681EV1nABYXJP/3ZxiXjySIgmLrfrol05MjeDUFSWvgvr56Sg/5AD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10396



On 21/03/2024 01:09, Waiman Long wrote:
> 
> On 3/20/24 06:03, Pavel Tikhomirov wrote:
>> In memory_max_write() we first set memcg->memory.max and only then
>> try to enforce it in loop. What if while we are in loop someone else
>> have changed memcg->memory.max but we are still trying to enforce
>> the old value? I believe this can lead to nasty consequence like getting
>> an oom on perfectly fine cgroup within it's limits or excess reclaim.
> 
> Concurrent write to the same cgroup control file is not possible as the 
> underlying kernfs_open_file structure has a mutex that serialize access 
> to the file. Concurrent write to different cgroup control files is 
> possible, though.

Thanks for pointing this out, now I see it, in kernfs_fop_write_iter() 
we take of->mutex before ops->write() -> cgroup_file_write(). That means 
patch is not needed.

> 
> Cheers,
> Longman
> 
>>
>> We also have exactly the same thing in memory_high_write().
>>
>> So let's stop enforcing old limits if we already have a new ones.
>>
>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>> ---
>>   mm/memcontrol.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 61932c9215e7..81b303728491 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -6769,6 +6769,9 @@ static ssize_t memory_high_write(struct 
>> kernfs_open_file *of,
>>           unsigned long nr_pages = page_counter_read(&memcg->memory);
>>           unsigned long reclaimed;
>> +        if (memcg->memory.high != high)
>> +            break;
>> +
>>           if (nr_pages <= high)
>>               break;
>> @@ -6817,6 +6820,9 @@ static ssize_t memory_max_write(struct 
>> kernfs_open_file *of,
>>       for (;;) {
>>           unsigned long nr_pages = page_counter_read(&memcg->memory);
>> +        if (memcg->memory.max != max)
>> +            break;
>> +
>>           if (nr_pages <= max)
>>               break;
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

