Return-Path: <cgroups+bounces-2608-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889A8AA867
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 08:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C32B1C20D11
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F8199C2;
	Fri, 19 Apr 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DI74vwIN"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A7883D;
	Fri, 19 Apr 2024 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507919; cv=fail; b=MVsGoW1kmeuTNd2H6NHqBWngx0/AN8vFsTVSTa8l+/noOrpHDJ5bjMD7/FBzKHfzwngU9l+PllCsb2VAn9a68MR405soAc9taL99KKJLJK6DpTqRMu6rvCcjkjzPYKtkfYeU0lPWFj3UrrwyNQcxoZ9svDXtjUdtRdoYXapNE9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507919; c=relaxed/simple;
	bh=i9s7KmL/Og66uv5q3reF5HL9g45LoS5kGuwr9uGSaoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsReDQAlHQwxloMyM8it2PycCy7e22mQ1FDQcRCn+om4PnttiRwMiuE1olrS7oYB58o/cOpsv2pV6Iylu76tZfoUUwD5U3wi7ymtEp8tHZD0EMpSTfj1BjSU//lIhhjdo7vOnUctVvuMyQpv/Cdu4/O5FOXbbJncd9yyJ2z30SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DI74vwIN; arc=fail smtp.client-ip=40.107.215.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrks1KLjh3WmCgrNano2fUi57cYQihvGQxqSC8ap6u7/mj30UsP07kyVf5yCAyiO7rOM1sVnfgO2JoG04udGk4fxhLXxS7sqWaURDyHSB//A5WM+HSKBbjskbA//U+aiTMfWnyzI34OoYY8dpULsThh5ht0c3sKLekjcfC4YMfye2tOK9seF3NlsGqf9sKzREQlh892UlzF9i52TV3Sbu6VQhH2JHO5v5UEOjyaB+f9OaBP6vE7B5smi7m8s6D+NvcTi8QIFb8zK4mjlI3xiFA4iW/7OuwiKczGhkC/T1G3bprsdeYkGzjHpWFhwANmMWyM6SPOKPUwtw5EnOyMqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10u1UPe9mZs70V9VeMGoKD5ZJWh+qDfNwaySPf6cRJE=;
 b=kvQUxv50GilBsL1cKFTsXQcrS/XvD9G/q480Q2SCq93NdMDRpB3Tz0JAT6lqkxBNLJfLa042h6rmB11KI9a7Q5aMoE0F/DeAdASH3hDJzkiaaDHnTfsCrouWDB/oc79ARyCqfMhqwpE/SFBEtlHQEekpTJyyp/m5ryZ82wub8fMdMrEj31U3YOqRPwEBWc+Ao433rzvt9wuWvflf6NljRsAddPXSBBDvv7FaeaU2pyV4T0nNl2c45B4eR9oQmuezwDh4C7vcfSjq1Mw6eKmdEePqx0iQShDMVgJoSbLbzhxHtNU5NpWXpphA/iNtErts6z7IrQUMZ+TwjDYP+lNg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10u1UPe9mZs70V9VeMGoKD5ZJWh+qDfNwaySPf6cRJE=;
 b=DI74vwINq9rd743gal+FoYjdQ1cBbWU01Afy9NJTpLv4xoWuFPL3Qhex9VJlszV8i3N1Wk9tx2fw1YVrs+X9psG8YuhiI392klXihILBBD310L9xaEOA4DOwue5oq94+vos5KxC3JW5J5gs4of4Sr/d52z9V5xqCTRssIh00CAlYsb5J0HiZ/p3p31v4zLlCD2Dix5SN8SwQGf1ThgyRFhctVvEfxnwnHO2J8WdhT3RcIRbODwy1sQAx4/vBFjdREtg019iYjT3ONzxB0aQ45zJrC3OD0I9VcAvK/UZWETQBJjG4xL+/REVLmYuLqcyl1J3CJcsgMvo14nlNJxUEhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB5898.apcprd06.prod.outlook.com (2603:1096:101:e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 06:25:10 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::ad3:f48a:aa04:e11a]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::ad3:f48a:aa04:e11a%7]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 06:25:10 +0000
Message-ID: <945d1e73-21f6-4a56-81ee-9625491f3b26@vivo.com>
Date: Fri, 19 Apr 2024 14:25:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: make cgroups info more readable
To: xiujianfeng <xiujianfeng@huawei.com>, Huan Yang <link@vivo.com>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240409021826.1171921-1-link@vivo.com>
 <9d01ab99-bbfd-536b-a375-9c44f988aa9a@huawei.com>
From: Huan Yang <11133793@vivo.com>
In-Reply-To: <9d01ab99-bbfd-536b-a375-9c44f988aa9a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:4:7c::13) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 98369be3-3e5b-4c5a-bad9-08dc603976cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ok08DFCdJmoFYPVAd5DPamAnXBdBHrgZDX3zPkWP63UudWgjUH1vQQxwpKiYDV5thUDhvVt+y6UfBA7wF0WdIi6+4ccObXfg3MsJGyBE3cX9jcika7d7y3jaYpXX2qnpiGOWtus0k0Q9q9v6OeWbemn95R0UbrB9vDvB8tIYw2N8YXJhSGXFThbosh5wD/nbh6tDCo6w/UaRwDlPnnInUIUdBSOWQuE6z13/4izRTodcsupGGLkvTcASL716+O6RiucktL5vC/ZlmK8LmFeBCufKaaqrGPpu19XyFx1r95pUNTqIr7mUNp+P4GDShNcabBE2cISgWFsd8flXkYXOtWeew0PT7TVrFkAKFX/GBh5LmRnJOsk22mc2zqhSNKL5+xOdkJ5hRZHahtapYid9zDw3arErKg5izNrznDxQ06gjb4VQv+J/wpWw5SuqMTyFS0kaKNl/V+ZawBqc8bWYAas+ESrn/0ySxvVGgV9VVGbXCcb+Ob4OpmF0pawGPklYwKWssMN0RG8nWMOKUO0UaN/fPRj+rVJXpMow/jL1aWYABWA5bDi1qzLZDYVifPV1+VGCczy/uHeh1naQtTmwaHTodrtfwJp0mzlrFEIhBDUILcijzKOppsJQ9sMlE7k76ui3yjbT2KuXFdM7UM1AYNs099n+a34z6O6fwcac6hQu1EoEFJNbssdZKhvDxXViu62386zyoGXGktN0tP5uRRPYxmpFtQaM5u3eZFaT2uJhXR99B36E2hhOOI+rLfnI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LytGTVErMkMzTHNxNTZ3RC9zVWhXaG94RWVrTkdJZ2hrNGFVcFo4MFR1Ti9x?=
 =?utf-8?B?VGFJQ0RwdmVnWGtBUkpYd0pzRm8zTkdkTTZhcDRyWXlFeWxweDVhTGZNYlRH?=
 =?utf-8?B?RkMrakROMVpXbkJyekorMTlOSFNScE5xelpZaU5PNUdMNXZXVVNIQkJiSmNG?=
 =?utf-8?B?UDJZVklJdGY2dUJKaVgxZUtyejBzeVQ0Tk95MlU4WHhTWVM3c0IzWW5NR0cr?=
 =?utf-8?B?TEk1YkFJdHJyS1p4OUtXazVXYmpNbE5yYUkvUkFSbW85UDJ0K0dKSFFUV21E?=
 =?utf-8?B?RTRWVzhLVk5yTlJuQnNKb0h4ZHNLd29FSGVZK2k4bU95cGtlMVRkSDIwRGNt?=
 =?utf-8?B?Ym96Ris0T0VVaTdja2RyY2NyVnAxa2FvMThIUVF6SEsrRTA5emJ6WFZQQy9y?=
 =?utf-8?B?WlBPVE1vQjJSbmk2Z0FwdVQ0OFZFK3hzWkFDMkFxRnJFMm9oMEFBTmlFNmt5?=
 =?utf-8?B?TnR1UUIwZ0Mzeld6bjIzZGNNRGhTQXJwK2h1U09SWTY3aEwrekJGVnZLNmoz?=
 =?utf-8?B?UThsUTkyN2M4OG5GQis0K29UWjV0enpjUmprTWt4cjVYQk9VZmFIbFcyaWd0?=
 =?utf-8?B?U1FTa2ExeEZ6QmxTVm1qVFA2dGZ5L3B5MGJ5Qmh6UjlTL05YR1hWcDJkSTRm?=
 =?utf-8?B?MU9qdW5JaHVGWEEyYVFOYjZHbWlaTmhvR0oxMkhsU1UvNnRyamZZSXRZM0Y2?=
 =?utf-8?B?VDZBRThSZDNnSGI0T3hPZVN2V3MxYzNBa2d4cC9hOVRaWW5TaklacG1ubXNP?=
 =?utf-8?B?ZTE0ME9XeGFQbUNqYlVucEh5RVNxbjdvT2pCZDhBb1YzOXNXNHM4dHBMYmVu?=
 =?utf-8?B?ZW5BUEVtVWNzSmtKbzlBV1llanVHL3FFVDVGblNkR2ZWd0JqL3UzMDJyNnlo?=
 =?utf-8?B?NDlGL3VUVDgwTEpTWkFoQVJDUGJNc3MrZHdweUZDOGlnaTFrQ054QVZkUUpO?=
 =?utf-8?B?UGRBV3ZOZGUxS0RVS29kRjJYdEdCY3RMV1IxMFAwMGNIUVBPZFlrVHZiZWcx?=
 =?utf-8?B?UFQwVytMSUhFWldRN2MzU2UyMFU0Z3JzTWVNaXRzRkRlMG9WZGwxMm9Da2xR?=
 =?utf-8?B?cTJlcmM3a21lZy93QWw2dGF5STBWYzR1WWI4SEZzWnlDWVUvNU9PNFlpcVow?=
 =?utf-8?B?ZVlVMk41cFBnSVNuZ2srTmp2TFhRNmdIeng5dmFiajBESml0VFlUYUdGRTYy?=
 =?utf-8?B?TXRWS3BPb3N1Q08xWVdwSTRaNWE3d1N1dzlSVlFxRmROZkwrd1pDM2JpZldk?=
 =?utf-8?B?SlhuampwZ2NRZWlsd2R4aDh1ZkQzSW03Sjk5OGtwMFA2N2licm5kNUh6RlFa?=
 =?utf-8?B?WGkrTGNzSmVaVHNpWDZBbGxYS0JKTGVNdGhmZWEzbndYV0hMVEdVUmtyUG9m?=
 =?utf-8?B?R1krcXRoSjhwSEVMblZEVFhpR0gzWWxWemVEM09IbWNUK1V6K3F3eGhOSldk?=
 =?utf-8?B?QllrczdkL1dLblJmY0tkbnZRcTNFbDF6WDdneEhWYno4NEFYSitHMEMxRFJ5?=
 =?utf-8?B?d0ROZ3lEbFJFdFFHWnhjWHlWY0NhL1VQdk9EL2pWRXVZTEtCN2lGSlFScGRB?=
 =?utf-8?B?azV3dmkyc20vamd0N21WOHhKanlZWm43RW9rN2g2bUNSSnBXR1BudG1WZmkw?=
 =?utf-8?B?YVZQc3h3QnlSL0N2eldTQ0ZMaUMzZHd0czY5aHdzclhVSmtRRXhaWXJlcWo0?=
 =?utf-8?B?eW1JcEFaT1JnbW13K1BNajlCMDNVSWUrckFraHdKVVdmVXRKQ09CMjZPM0ZI?=
 =?utf-8?B?Uml4aU5OMW9RYnVPeWhneWNXdzhiaCttb1FtclhJM0RVRDNRRWNjOGd5dnFW?=
 =?utf-8?B?dTh1clU1eFB3ZWpMdmIvV1ZsaDkzVU81YmQwZkJBOEc1L25xUnFNVFNBNEZa?=
 =?utf-8?B?bzhuUEFpOEF0VlBScGlQcVEvaWtla2JUeHk2a0sxZXVkUWxCS2M3dFZUTTZu?=
 =?utf-8?B?WGtySDQraHM5bW5XRHR3QUtnNDJLMXRhZXRHTEMxTEdZc0ViSTVQQnZISU4v?=
 =?utf-8?B?UFdLeGs3Y1had0VTU3I3Q1pUY1VjdnJ5bXdSWlZrU3pBMHdRSDN1ekhVSzRu?=
 =?utf-8?B?RnJ1cUhsOWR6ZjdGRk9YYlE4cmRWV2FYWnZ0OXVDMFVFUEhqb052VHJ5R0Rk?=
 =?utf-8?Q?oVyV+P6jvVSFhKx4MlZ1JY46Y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98369be3-3e5b-4c5a-bad9-08dc603976cd
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 06:25:10.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bZ3PnLN7HFKMRIDACvOhW1bTYDhpEPxiCpQHRwWJQ9yudW3leZ8LMBbXYKSNbMz0TCxU77wwf73e/wJRRQvmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5898

HI jianfeng

在 2024/4/19 11:33, xiujianfeng 写道:
> [Some people who received this message don't often get email from xiujianfeng@huawei.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi,
>
> I found a discussion about this change in the email thread bellow, and
> hope it helps you.
It's helpful to know why this patch not need, thank you.
>
> https://lore.kernel.org/all/YwMwlMv%2FtK3sRXbB@slm.duckdns.org/#t

I have a question, that, now that only for cgroup1, when I running qemu 
ubuntu, I got this:

 > mount | grep cgroup
 > cgroup2 on /sys/fs/cgroup type cgroup2 
(rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)

Only cgroup2 mount in my system, but /proc/cgroup also worked, maybe 
better to disable this when only cgroup2 mounted?

> On 2024/4/9 10:18, Huan Yang wrote:
>> The current cgroups output format is based on tabs, which
>> may cause misalignment of output information.
>>
>> Using placeholder formatting can make the output information
>> more readable.
>>
>> Signed-off-by: Huan Yang <link@vivo.com>
>> ---
>>   kernel/cgroup/cgroup-v1.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index 520a11cb12f4..c082a78f4c22 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -669,15 +669,16 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
>>        struct cgroup_subsys *ss;
>>        int i;
>>
>> -     seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
>> +     seq_printf(m, "%16s %16s %16s %16s\n", "#subsys_name", "hierarchy",
>> +                "num_cgroups", "enabled");
>>        /*
>>         * Grab the subsystems state racily. No need to add avenue to
>>         * cgroup_mutex contention.
>>         */
>>
>>        for_each_subsys(ss, i)
>> -             seq_printf(m, "%s\t%d\t%d\t%d\n",
>> -                        ss->legacy_name, ss->root->hierarchy_id,
>> +             seq_printf(m, "%16s %16d %16d %16d\n", ss->legacy_name,
>> +                        ss->root->hierarchy_id,
>>                           atomic_read(&ss->root->nr_cgrps),
>>                           cgroup_ssid_enabled(i));
>>

