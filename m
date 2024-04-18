Return-Path: <cgroups+bounces-2573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F48A9109
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 04:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42836281CD0
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 02:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238F63F8DE;
	Thu, 18 Apr 2024 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="O/VoHriE"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2073.outbound.protection.outlook.com [40.107.255.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82F29A9;
	Thu, 18 Apr 2024 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406333; cv=fail; b=IIt9/2XlS6ys9QScV0ZXjZJ3op1V9gsBe0RvxHX3TyQjgt2E/CBR+DsBB5zrsirA96WlI+2QyIrxgUxywmAe7/I+ITEu5kIbTzm9ZE00KMsS9nZ+1MqBz7ArN8bc9nZ7Cn6kiwR0zGfzv/c9tS66DJ/LxBNcRdMQFJx+1AQ0Btc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406333; c=relaxed/simple;
	bh=jtR0z1WHB6SrTSxevn4+eIbBcEBrl72Jtsy/uorbDRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GUY8HMOpITlZkSPr1p8WWy0K9G31L5eLZT9o9gcyrNXI6md9Rurxz3Iyo3nLA81nr7EdLk0DxnA4cUMFECbkKkfLbVcJDPv775clZOmCRK7Swc9Eg9ToMEBJG0yu4IlIJbh/6AtwD/yz8MRVrZmEmFdeP4EBWA7JVc5lgSk3IyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=O/VoHriE; arc=fail smtp.client-ip=40.107.255.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES5QTOLHosRFjIQcqPyua3XdBGKoTFMpmE8U2UxCUjQ9e9hSj+5/MitgjiZw7Yv9OXmvA+LHJBjNmv9OQdT6k1vxudEhNhFPT3eafs8AdXhKuWTJRgKjTJWsDjNB2VES1QhkbzY417sSoKGUOeVZkKt6FjqRk/DTl+MIIa9ps9N4+xQSZwDJbbiXzknNoWwaNxu0tiSVwn98LjrdaLUWhQzuH1DPyzofL6MU9oUrTCgN06ejhnT2Mi4k2l/V1f1mrsPi4+tWn55UKz4sYaBHSqTpQF2bLEFGNPsYtrw+f3RhIA8OlVmnroNIx9BnN5Z+4BBb7gMq3vgbW2ipRsUlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXB+9JOg2S/zyYJ5obQ+4xXc8Xlo6LakCs486dc/xq4=;
 b=LEzOHK1E/4N5di8rdvNoXK8ycxauT8ktSIzUD121PJldbdgA7P7hgJx8ykjn7YTmj8E4ujxEo4WrcEQUJUN8zP57mc+u9h4tHYKLQLoVySxUSVvX8Xjs5hReKD6N1iEG2qdQV4Y4RkQhcTS3tynXos5E78cu3Iq251yHYfoYxwZaqOMREV4ukxVudDtCSPLgLjr8zTqH3zUlGAXP6Bnoazzo4+j7DBgHe3Dtmd3EaDKxZhLaE2Hz0KzC7nouEPudvakZk0mBnjtl5eA9i6mGXEm8poa9uw5wxD/XE8fHJw6r7i+Pb0BDvwF2xXsbPezP/28LDnrYNGyogk4dd+KLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXB+9JOg2S/zyYJ5obQ+4xXc8Xlo6LakCs486dc/xq4=;
 b=O/VoHriE3Vm4YjXj3vFzlLZeNFkcgx4L1rItsAfk83kwSQbDLvlnCFD1TtQHmxU9aoznhc2pTJHmURz2euGYVC8fDAy+Dh2Y6d2q9ZkZnLTEV+25cfsutEdWFOi+qmEzqgjiEFVJIbmNXY+Bmjfa1Mzp+/NjVchkHti/oLzzgy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by KL1PR02MB8167.apcprd02.prod.outlook.com (2603:1096:820:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 02:12:08 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::b075:bc43:3d06:c6eb]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::b075:bc43:3d06:c6eb%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 02:12:08 +0000
Message-ID: <250e3c60-812f-4b5e-9831-bd8de57bba04@oppo.com>
Date: Thu, 18 Apr 2024 10:12:06 +0800
User-Agent: Mozilla Thunderbird
Reply-To: lipeifeng@oppo.com
Subject: Re: [PATCH] mm: fix the comment error of memcontrol.h
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, muchun.song@linux.dev,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417121645.25355-1-lipeifeng@oppo.com>
 <Zh-_jOtSyv6DoETP@tiehlicka>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <Zh-_jOtSyv6DoETP@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::18) To TYZPR02MB5595.apcprd02.prod.outlook.com
 (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|KL1PR02MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5d1fcd-154b-4fed-4ced-08dc5f4cf35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2E9LHcYpdXxOJNI/Z5e2JJGB21sZViPHyUrOCfMxmAe48Y+1o1IYGnleunUIFcUvx+07o6wDcX5zhC6ecBEsMABOMgQ87JCJAO/XfZm4ET4fQI4zUT3CMRQozpk/BoSYMC0bM5Eq1FmhVzksAiezBrf0P8ejUOuSJi80Cv6Ht7vqmL2RPDDg8magHjdh9zdv4wQKVPe7MOMpskOR/XARwnn7FMTob2kuiuozJw1n9tgS7GEMkDdSEIhTHbRMzhR1XaKZeEFr5CjC0nd3cjtBpvZ9CkD1rRVDG4FJx7X2Kuk2AkyNqRtBKpJ93lyzo2Tvm8RUlgwMX480zBMugi6W1Co7v3CBSOakmBD8KsY+bP+wvMwV8jWBvup9PNo1mJTTgbzi3fIKcj8UTqqR+zzcWQ9/3aG1rZ3CPSZIfL5ZYEH/L9itx7raJ3GH0jGUjW3LkkEDiR0fRbHeacpKRbva5OrOIiR3aEUO9N22Wg02FbsMe9jOCIObfnFBsaV95OX3hTIEiyAxvOdXomKowIM9Vknd3cepImXrf55gxfXoEnm8jRo4loamyQ2/AJx+4KJhFpDcxKJJtzoCoMsVgGSMq39ZnXd3zfefHzp681GotUyJTu8IxhsICqavetpJdBJfxRGTdrxCpTEP5exAO+JZf2Wkq14bnIktqQtnIQbPxMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW5XM1lSdUpnQ0pBQW9xSmdUWGVFQnpUVTBEOUVOMUpNMVhlNFB5YUNJcTU5?=
 =?utf-8?B?Qll1UnRxVHFZdEVIODNySjN5M2pzU2lKajlKSlpVTGVuOU8rUFEwTzJyVXFa?=
 =?utf-8?B?V2hFTHVHbGYvRzRhZE9FVngrNlJmd2IvWnljYUk2UHVPY0xWN2g5b1VGNS9U?=
 =?utf-8?B?S2tieUNYc05zbjcrTjVMc0h1QW84eGl1N2Y2Z1pGZlp2cDgzVWpEUmtwVVVu?=
 =?utf-8?B?WmJBWHBKZFQ0VFF5VTJpRkcyUURWdHVuT2d5Q2x2SjBpa1o0MWpZMFluN09s?=
 =?utf-8?B?RFBEZjN1bUtOdVVRZ1c4OVJnTytISnMzQnMxRW5rdCt4YkNjR29ibnhGQTd4?=
 =?utf-8?B?WTdleHY4aUhQV3F1bjJJMng4TDdyazdKVGFuYWJuK3hZVytyYnlyVDBZN21K?=
 =?utf-8?B?ZWU0eWJnOGpGTzdMU0M4NVZ2WEwyOTl1RE53NnFtS3RKTEhhUnRUNkMwMXRv?=
 =?utf-8?B?a0s4WFRhZFE5anFqS29aU2xENDFtTjZycVVtQlU2UHIyRjFSalpJTG0vWmlX?=
 =?utf-8?B?V3Ywa21rRnp2UzJCenJqaFdkUkIyUTk1RWxPWTc0MjBOaERXYkNyd3NHWFNJ?=
 =?utf-8?B?ZjVKSk93NWZwWngyOWVDTG9XVTVFTm4wblM1N2NBSzBqMi9SKzBZNTY3STlw?=
 =?utf-8?B?ZWNJeDVxOGdra0lsckZ6b2hmVUljQXV5TFl1WDBMclpENmhpMjBNK0IyOVUz?=
 =?utf-8?B?V2ZadjY2YUtVNThWbXpjc0g0SWF5NmJ4SWh6NHoyZFMvUWJ0QXM3L0NmdFZJ?=
 =?utf-8?B?OG1oUEkza1FXQ2tGQTVrdEMwYS9rUFB6Rms1Tisvc01UbDNKTUFPMml5a0dI?=
 =?utf-8?B?SC9hNHBMc2tjTXA2OXFCVkplOThYL3hoNHFIZ2g2UWJ4ZG5TMHR1M0RIT2Fp?=
 =?utf-8?B?NmFZd25SdDhGMGxhVUdObGhMeTVMNFBqbEsrYm96RjRkVUF4N25TUVRPb1N1?=
 =?utf-8?B?RFlQQ2xtN3krajhxeVhvNTBKbndYKy9VZ3pVeDM0dGl3NGFGNHFudXRCSmk3?=
 =?utf-8?B?V0djUk5BbUlQNmVZRkkzY28wTi9PNWZzYzRmS0tlWXk5eVZuNnJ4TS83OElU?=
 =?utf-8?B?bGJSZmYvZEV2RUZjcmdZSFlBZ2ZHNDVSWjhLQW14N1lMdGIrTHg1bEdMS1lM?=
 =?utf-8?B?NXk5cG1WS1ZSYzl2dnRYbXJGM2RXeGlnOHBSVTFiQi9LNUtCbzIrZzAxaldZ?=
 =?utf-8?B?TVRJcFlNOGJwTitqR0Z0MFBFSnMycHZvaWNoSE92QVI2Qy91OVN5QXFVNktE?=
 =?utf-8?B?VGpvUG1zaEQyVnJrKytELzU3bFhVRzV4cXZxNnltejNtOG9vSFRmUURHOXRF?=
 =?utf-8?B?VHYrQmQ2ZjZ3SUlyUjJhWkh2Yjc5OGJXVXBGT2ZGbnhOWmhlNVVtb3REQ21V?=
 =?utf-8?B?bzhKcGlldkgvM2NHd05xTWdENzlHSjh6Zm42bW1Nb2VzbkNHcWJaVTV3SG9t?=
 =?utf-8?B?dUpZeGY1aEFiKy83NWxGc2hZM0NudjAxcnIvd0xWNzN0Q2k4YnBnS2gyL0to?=
 =?utf-8?B?blV6Sk5NcVpDVDhtRllmUXF5Snk4RWF0L29pR3dLZ1hGVEw4QVFYTVV0RWc5?=
 =?utf-8?B?dkJGZXRla2ZUQTdOaG1MaVZBRXVONUZLdGdTckdXVUo2YUpJcW1GWlhxdHJQ?=
 =?utf-8?B?c1FGVWtCdEk1b0FEVjRxcFl5cFpQUU1XVG5KbHFPWHBHd1J3MHRBazVmMUYx?=
 =?utf-8?B?cENlNEptU1ZsY0VKcTF0ZFVNNENsUzJmdmVmdEh1SmUxdWF1T3VPc1c4cjY4?=
 =?utf-8?B?WlIwdzY3UzBmb2VhMlJvSGpPRUluMWJ1UEhLOStlQjkxTXJodDZYTllmRjJW?=
 =?utf-8?B?My9nTHYzOUdWdU5yZjZCQktzcW8zQ3hmRUVENVhJSUowY2VNcHRvMERTQ2JH?=
 =?utf-8?B?a2syeWJFa0lwOUdGZkRQNzZuMTlRODlhNjg3QUVlOXlld2JxbS9Jb0lVYmJs?=
 =?utf-8?B?UFYyZzAzaHhIZDVmOG9SNnVSenQyOGhSYjUwVlZueW0rRjRBZHlWT3U3RXJk?=
 =?utf-8?B?dDNWbVZ5WjdvbG1NSEFtTmJwaEZZQjJ1cDhjUGxuZlVRQ2NDZFZoWmcyVklX?=
 =?utf-8?B?Y1ZMMHJMTVJTRGZtMVV4MDBNQ2pISWhyVFIxTHpJSEdGTjdUUmRvZDBGQis0?=
 =?utf-8?Q?I/ibQxhU60HZDBRJ2nvE9gGYW?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d1fcd-154b-4fed-4ced-08dc5f4cf35c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 02:12:08.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfiKN8nqR7gE2YDyWm5kzVxsmBowUJ6oqmqYUtvw8Cz0Wxu6RdCw3JhdvobVwcvsjx+Xxux67517YLF+Y0hBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB8167


在 2024/4/17 20:24, Michal Hocko 写道:
> On Wed 17-04-24 20:16:45, lipeifeng@oppo.com wrote:
>> From: Peifeng Li <lipeifeng@oppo.com>
>>
>> Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
>> ---
>>   include/linux/memcontrol.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 394fd0a887ae..07d08be706bf 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1679,7 +1679,7 @@ static inline bool folio_matches_lruvec(struct folio *folio,
>>   	       lruvec_memcg(lruvec) == folio_memcg(folio);
>>   }
>>   
>> -/* Don't lock again iff page's lruvec locked */
>> +/* Don't lock again if page's lruvec locked */
> Not a typo. iff stands for if and only if
Allright, thank for your response.

