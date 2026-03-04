Return-Path: <cgroups+bounces-14598-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMn0A74TqGnUngAAu9opvQ
	(envelope-from <cgroups+bounces-14598-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 12:13:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB511FEC7D
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 12:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 563DC3199DC5
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF63A6F01;
	Wed,  4 Mar 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DVdWkI3g"
X-Original-To: cgroups@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D73A4F26;
	Wed,  4 Mar 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622490; cv=fail; b=mtaNGPNijl1IRNAOLC4MOYAVEh/wNzkFL6ksx/VuU137KJx7CLR1zhvGoDdlG13NaGnHzFr3ltIVU+ceKqqFt4770UlkWT0GNJXGoCBrPf30kitujJPJjnaoeoNJpu0P12TTSUtYIEmnCc6fjle2Mtzo/8Dgu51W2/6Te9aIGJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622490; c=relaxed/simple;
	bh=LGU4niA6oxUGFVqMfl9kqNCnGy2gqaLSYmdj9iR4iyM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mt7Q9Ukm3z0253kLXbUcXQWyHKEEk5jVYQazNefMKPwkoyYlzoQq6r5Z0jesYkctEq+/z2SbV+sa/LxR+q3aAbZZxxDnXOFw2h5WnuppEWdJip0Mdc+AQoHpBr48ASdM3UF3XACPnn0oiJYVeHdAA05RU7ez2++u8Rta1ARRrmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DVdWkI3g; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdDO8VGdNpgkfVQLyQJO35EBuC7swecWFtdKEnPMI9ohonKMnDKEMeatPAZ40zJbz/mAwF3GFsLpLbg4rlJGWmQNenvAiY0G49qkaSgoqVz7sczfQxkyExvgW6nlgcVql5epwZwRgrJ43id4WFOgEeoqzoXItg67z2Q993Lo86sOSHK2ztg2eP3v0RsrexR69tcsEHr+T7pdqMa8S+MsBbIGjtXVpJiaXdeK2oYVFcJU+JnGDSsGvTgc44waxda6BgfIvAoPQ/wCsGmTc7yWRXb4SJwCG2ClRMEAsn8OYUSdkQxXL2tvKA4Zn9+ZO3DNLBusgkV1jPAcEAXmKkB0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsjJJaoqPt01PiUxU+4/DzgKWsuR6tsYnAhRLZRi5Ck=;
 b=EvwMRpGBll/NTlVuLyKYIkjSJPKs6VJe4afAIcUbKSKNgzua+XOOTk5PVlhB0RnAoMiFzmro9LdeejRx1jzGtBUjlzYqScIqUno0ie14z7sIc8b4+Y+XjfMkoM/DZMTg4RG8mILySfxiwW6n7YMvJ3qPucVl+9zRq90JIDco7DgcagK/kX25KrOBPwOVIxVqrhhlm0l2P9g9j2bvAnvifbL+kdbmuyy1KTILGv2jQeaGZ0k64VdyKkez8uV6bzGQVmwOJOkmZhP5nUmVee9itUf7/Z/PszErI14Z4hxZIcLWc2SVgM99p8b599h7yoPLjYD9lA2COU/rP35mQvtZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsjJJaoqPt01PiUxU+4/DzgKWsuR6tsYnAhRLZRi5Ck=;
 b=DVdWkI3gWTCqEPyStYw22c028p6XmhpzwVUK2b8zWv7RqJpKZ29NIW+yJ1yra3RR8Dimd7rqUeDyb645n41Y9iKrtIkhutO7zILsmpx1WATr3oaAxdxVv1Mdn1TtqzDQE0goGZGh3NR0JY2TZJZyedk6551Ip+yySzaUSywb7e7B3YcqPPU4NNs7TZwQoHXq0GVvMnkL9dEBTIMoSZnDyh6hnfx3/S059b+yx/55akwtWhAZYxzsUyTa/dKOVbv6Ex9r8Q/hr2ip6jlSMEuDuIcDELptPD7n3ZJ/LikdfSGpBnLdui4yWpDMR/4PMbQyVBDbnSfeJHTDRJKu5TAH8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 11:08:05 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 11:08:04 +0000
Message-ID: <d0695355-87bd-4d05-ad4e-8e591e226108@nvidia.com>
Date: Wed, 4 Mar 2026 11:07:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls
 from CPU hotplug to workqueue
To: Waiman Long <longman@redhat.com>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
 <1a89aceb-48db-4edd-a730-b445e41221fe@nvidia.com>
 <8ad885a8-be65-4d1b-b8c4-dabe50fe3788@redhat.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <8ad885a8-be65-4d1b-b8c4-dabe50fe3788@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::10) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 10013708-0ac7-49a8-9717-08de79de4ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	jiINDewGwWZH5qAr8GZS+cKV9iQuw4Q/RzmZX977zG5F+hSFhCZzWWmDmPW+yFRWlCQiiUHXlGqRXVj3Q1M2s4tXSp8minjtcgcv/EEZ2iodcoPTitIhnXSnoBh8wJh9b+b5kqc9hIjdQlU2gYrNdgPfL35rcD5p22sgQ1fesPAOGkNwkYvjFTHIZPmlSWybxLnm74iDBsFtsg+seunfXkB691hyUYCyWqt70RPM0eCen171Uvs+8WEk5Or3wB70OtE2GQARHCYfXr25lxjrfGmkH3M38qd9m9w84BFIyKpykpK+2zme9q/BO2goxcinnN43ULosRZewAf4mphb86EezOR3NJxw4MX752afZ2qppWAtvVIHeVfGSbR2K93j7t3Cao1Uyu5A9HcLXS50NRNdvXIVQRNBaS4k/si3KLOvZ/CK6j6OS7B6SVup9UQ0icTF9AnRVfSo6KkL+yQrw4FGEykCcJjuro8MtWTkWnXgTfRI+cVvLKvGtPnw7R2pBJt10roLiUe4XgbfS09V6AdkJ4VINNsAvRwlkdrMLJLN9CN2ZSeaoIJHue8blMFLtKy6r+oOs9zLs9q2B7KI6H9MYAsCt5giDMkjrO3wccFy073s0eFQ4oAi77a9kjj7r4UzVzGHJjbhUbyUOuRbXheNhbV3JfJdTAYsDdy+KdscHC9CUYOANegj3V35YEawBG5QJN3xrf45Njacg+SzG+pFBa67LDiAdqyq+7Gmisyh5p6ZyF6VMdpiaj07j8XuheMjtpq/CExvGDTNnV46uwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVA4ZTdadUx1WnJHQWYxYlFzRnBoTUV2TEpHMFpFK3hiQWREYlNoZldlWjhn?=
 =?utf-8?B?Njlxdm9CMDJod0c3YVRrQ29ZV2ZQMHFSMUdMVFFUaGh4VkpLMGRad1dOWDhI?=
 =?utf-8?B?RnZoMk9nOUZiQ2hMcnJkRFVkaGIrRkE0c2NQWHVoVkZKUHhkS0xyaE1NUnAz?=
 =?utf-8?B?WWYwUytHVFpEQmpYZ3FoektNdmxWdXREVTlubzc2N1E4Q0xETHhRV281WTk2?=
 =?utf-8?B?OExBTWtVTkZvR0RTOHkxRWpxa0liYUcwZHc4RTQxUXhHdU5LM2pqbVRvY1g3?=
 =?utf-8?B?eDhSL2Flcjl0QnlTQkVSYXhkenFZQkQxY3RvOGM5eWoxYXRjUkZYVVNKbzBy?=
 =?utf-8?B?WFhuV2ZzeVFXY3Q1cWNoRG9aeDBObmhaRmhER0ZQZ1lwN2lmb3VWaVp5Y0cz?=
 =?utf-8?B?RVVWN1BNcXBOVEJzMFFHc1h0aENvOXdmb1dNUlFHWEhEdXRnSEcrTzFCb3Fs?=
 =?utf-8?B?TUtLaThjczJ6akFRZHRPWUJjZVNFVDBFdVFXMiswTENFbytMMlA3NzBqZDNK?=
 =?utf-8?B?MVFGS3BWb1JxT3MxL1NvZlRJUFp6VVdlZngzaEdaWUZ4TXVYSEgwOERITFRJ?=
 =?utf-8?B?b2FoWkpJQ05VUFloNi9HUS9GVWNZS2RVNkhlM0FkUk1FbTdKVENCejdrNndk?=
 =?utf-8?B?dkFOWnFTdi9ZNGwxbU5Vc3lXT3BzTGpOZnZ1NW9ZMHNyKzB3azE5MXQ0clVo?=
 =?utf-8?B?anFBUnFrTmE2RVRnNk9GSWUwV0lVNGJKUTgxM1ZpYk1RQnQyK1RWTzA1UzZr?=
 =?utf-8?B?UnROS1BqMWVWQTJEdklJdjliVzh5aGIzWlcvcEwzdWxFUFk4UzlBbGhCVmRz?=
 =?utf-8?B?RXJCcFBabHVGbDZWK3kvRmM0VXhQeFhtTndvQlFyWW1HM29SbEY0Tm0xQWdk?=
 =?utf-8?B?ZXNpMEdlU0p4dzR4aW1aTEpaS0c1c0hEY1JEeDNWUUpGcjRmaG9ua29vaFNY?=
 =?utf-8?B?cFZWMDNmMFJtSVYyNE52RVdwZ2hvMW9kenBDdmdDSHVZNVFHUnFHaWx0L2kx?=
 =?utf-8?B?RlRnalpwSytWN2MxN1RpMG83R01SWkFIWVBJNnlvMTdNekR1YmE4dnQrcXMz?=
 =?utf-8?B?OVBORUNkbnNtVFhzZnpYNTlrVy9WOGNJRzRRcTNFUWJNbTdBRWd3a3Yzc2ty?=
 =?utf-8?B?ZitOb0VmNU9GZWY5OWFFRG9MVytyVWRyTkNGd0FZM3orWDFkK29McWlqTjcv?=
 =?utf-8?B?M1lJTC9pVGNIK0thRFRBdjlpU2VDb29sVWl5ZjBNRXprYVFKeGRkR3RQYW5C?=
 =?utf-8?B?V2RRa3FiTEJVQjN6UWpqeHhJS1R1NEFlTWJzNTUrNFBwM1d0LzJXS0N1WkJX?=
 =?utf-8?B?bzI3ektsekZJMUV2WmJMYy9uYjJYd2xQbEU4eXoyNVJuSDlMZFV0eGloL2Zh?=
 =?utf-8?B?a2s1TU5DTHJEMUxIWWdFbzBuSWZxRHFJQjFUdmxKWU1icVlmT21GemNLSmZB?=
 =?utf-8?B?T3N6NlJrZnpMWCtDTXBLRmJycGduRGhUNHNQcjlLaW9ud1FWYk1MNW1oSCtO?=
 =?utf-8?B?RGVzdC93eHMwK0kzWExQamNIVzdDOGN6ZE1JU2NGT1NlZXFoN2tQSlVCR1lM?=
 =?utf-8?B?OE5iSWlQU3Q3NGlLVTIvSVp5a01tcUJFV0cxSGZaWWpSZm9BL2N6Q01wL2hw?=
 =?utf-8?B?eVdhWmIwcEdvS1FYaU9RSWloMG93NCtyT0J0djNiUFVQRjQzSXZiN0JtL0Z6?=
 =?utf-8?B?UGhNdTcrOEhKSkc4bHA3NE05SkFheDNPaXpzcnB0d0g4NjVrbHJ5bG4vWlVS?=
 =?utf-8?B?Wm5lVnh0aU5oQ0VWRnUyTVJWaHVWUGJnRnBYcnQ5T3h1NUNsK2cybFFQSjAx?=
 =?utf-8?B?aGVBb1pJQWl0d1k2bHptbFIybmllL21mZ2ZUWU1GaEZPTEQ5dTc4cWx2Y1JC?=
 =?utf-8?B?S2o4RTVLZ3M5eHpWMk9lRFd6cUlRTzQ0WmVUOVUyV0VlaFArb21KMmcvSDhE?=
 =?utf-8?B?ditwL2FUNnRsdWFxSnc3dGZBR0ZqbjQ1aHFVQU1QTjJpb3Q4OFdyVlFoUDBn?=
 =?utf-8?B?NTJSbStBeDhsV2s5TGEyMXpWd2ttRGI4bDBJY3ZmOXFwSUExY2hLQ3FmcVo1?=
 =?utf-8?B?ZG4xamJMWjBnUW1vaHJhQnI2K0tMSGFFaUt0bGV4MTNSZ1JWRzJocUhTaG1S?=
 =?utf-8?B?VklqR2t4eFg3amw2RTMyTk9zV295ZEhnUnovT3pneC9VUjAzK3Jja2kxWGtD?=
 =?utf-8?B?eUQvNnV6am84TzBmeElrSG1YMTJxamh2dS9yR09NdUp6d0FwMVBqY2JMSkpp?=
 =?utf-8?B?TnJUTFczSTMyYllRUHVwbE5CUjlPTWcwYU1NUDdJZFB2Q3RkZm5GNklWQVF4?=
 =?utf-8?B?YVltUW9mZnJPMCtzQVNaV1BaZzhhMHBuNUJoTjZ0QXZWVFVnUFJQZWNOK0RZ?=
 =?utf-8?Q?VPNcYKVck7i1MKMjljxzX+d2RdDNNxRuPkVNmEk5QxhF2?=
X-MS-Exchange-AntiSpam-MessageData-1: AspCzMZcReoXZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10013708-0ac7-49a8-9717-08de79de4ed6
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 11:08:04.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMBA5YG2mSb0gLhsCC1ybte6s5U9ZgGwkhqj1HZ1r30lQHSwTF2PIPssbTEi6uSO2t8z3yIijhEM/56gGOAaxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
X-Rspamd-Queue-Id: AEB511FEC7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14598-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 04/03/2026 03:58, Waiman Long wrote:

...

> It looks that -EBUSY was returned when the script tries to online/ 
> offline a CPU. I ran a simple script to repetitively doing offline/ 
> online operation and couldn't reproduce the problem. I don't have access 
> to the tegra board that you use for testing. Would you mind trying out 
> the following patch to see if it can get rid of the problem.
> 
> Thanks,
> Longman
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e200de7c60b6..5a5953fb391c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3936,8 +3936,10 @@ static void cpuset_handle_hotplug(void)
>           * previously queued work. Since hk_sd_workfn() doesn't use the 
> work
>           * item at all, this is not a problem.
>           */
> -       if (update_housekeeping || force_sd_rebuild)
> -               queue_work(system_unbound_wq, &hk_sd_work);
> +       if (force_sd_rebuild)
> +               rebuild_sched_domains_cpuslocked();
> +       if (update_housekeeping)
> +               queue_work(system_dfl_wq, &hk_sd_work);
> 
>          free_tmpmasks(ptmp);
>   }
> 
> 

Yes that did the trick. Works for me. Feel free to add my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


