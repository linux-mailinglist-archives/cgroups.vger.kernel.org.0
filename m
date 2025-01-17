Return-Path: <cgroups+bounces-6218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5FDA14D7A
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 11:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2585618847CD
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25F31FAC59;
	Fri, 17 Jan 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bPOxGz3H"
X-Original-To: cgroups@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010034.outbound.protection.outlook.com [52.101.128.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35501D9694;
	Fri, 17 Jan 2025 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109520; cv=fail; b=OVmxM09uReosvFDWNp7j8ZRUwzTHPIU3b1Z4rmPptMirgIHrAAKKYKDpcArQ5qJ37yKHzTxeVJrsJX7oQhFSSJ6oWMkfJr0OOUx62/8p+x95kAJXvL+VeSlWPqNyxJlIf8y5Vcmli90LqExBS2jc8YiuuESA1p1JhjuiIeureFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109520; c=relaxed/simple;
	bh=0352mE9hhmrJKtFjHj5U0HkO1UmlxZWHoj+UZAF7W6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NTt5orZL5bKjZPidIrGuAq8TV6fOOeO8X9PoBCasLz3PHlQp2q0moEBu0s1RnS1q/d3Ls52dkVh3O3pc2+teLwyXIqCQmMln9mzHYNZiqTakBGwMYrRSqoUk2NZ+CMmDYXiWCPy0nN5sOheRRLrSC5ay+rA5N/4xztCHO/HHxPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bPOxGz3H; arc=fail smtp.client-ip=52.101.128.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJf3mZcsZ2v/E/K6uyyIdOWQQUN79mX1h1RJne8trtUiEELjJsqbx7YgnbCkL1bq0JgJjdWjturWT8i3MMxvHMSbZqlihHIUI4ipbdDVNIV8cLRvX9GHTd7aYZmajCKCWZ5/eTvN4SPbfX0aqlGdf3yyUDk3Vl8a98bOZOHKV1aKgK5he0TfaFF31nkq01fURFkm8YUBllowj0oAgFDswNfffTC8EP2I6RQAMDNlAMqROZVCdz0CQIRsqlbDGcwQo6IeqUEun0dZB9z0xzLYlcnXffnTcjLI7YTm5LMYAqdvqsx/0tlr7L60LcfaeVolDeQWGh4tmFuVqktHoj5/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0352mE9hhmrJKtFjHj5U0HkO1UmlxZWHoj+UZAF7W6s=;
 b=I0nfnv3wueeGqpKDpCqRelQWqbBk3H6W+Ochvse6wvePyJtf5mjxa5xHrUkuBgFW8ulMLo2SyHA4W2YANoYNV2JAuHrtluyGvF7Bifylj1obih+OcOAHI+eAAkYPQO6Vj+PgbYO5rPgXTe0fYeLCE04gvLejw97mZT7yDQMR7B82K04Tud+RddV38AU4q5c+jctHFUAoavpt0maleuLyw5llIPMtdfo23dEfGusuXIRMbo+EgIiwwGwQBSG9AgrDrW/pJjpOPyuKI1RS5T91zpJZKBsYY71GRlNbwJ0j7JXZ24AevREe8JTr+TucAV0/EZCSkwi7n5rp/3ktGC6Wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0352mE9hhmrJKtFjHj5U0HkO1UmlxZWHoj+UZAF7W6s=;
 b=bPOxGz3HGd3effxu6/9vdnlshPjlqud+k9ssOM6dbBdMO7m9J+zjgpi79AbunEne6x4OyAUxDHd8UTvVRw329fIQ2LTD/9LzVtnAV34izCdmeVAn3qOwWZbq6RhMYB/p/cwnPaGA9KjlNnlmiVrF3n6AuFAZ16w1pfPbQ+Xpdb0CsWUgASbzaAYuhHUUS2vIFpLnoAKK14tdMXeSKy/IIOUT3oakK6/IE31InE8cxS3otGpI2u6lY4yg637vaT+to/Ny/QjNCOyBA/WAW7SwBURCrcYJ0uY+nwJRFWA8YXWpea3L/UPP0A0ImRH9aJH3YZag3CZzjh2zDVFGTPpTLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB6094.apcprd06.prod.outlook.com (2603:1096:400:33c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.6; Fri, 17 Jan
 2025 10:25:14 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 10:25:14 +0000
Message-ID: <3156c69f-b52d-4777-ba38-4c32ebc16b24@vivo.com>
Date: Fri, 17 Jan 2025 18:25:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memcg supports freeing the specified zone's memory
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20250116142242.615-1-justinjiang@vivo.com>
 <Z4kZa0BLH6jexJf1@tiehlicka> <a0c310ba-8a43-4f61-ba01-f0d385f1253e@vivo.com>
 <Z4okBYrYD8G1WdKx@tiehlicka>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <Z4okBYrYD8G1WdKx@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: ee51d5a2-0e6b-4eab-3109-08dd36e13b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anBnV25ha29KWDJNd3krTGtodE5aVnYzamg0S0paWWtHTEVTTm1xR3pac2pE?=
 =?utf-8?B?cnlmSVg3L3JNaTJ3Skx0b2VOMUVBVWR1ZEUvRGIwaXArOGJBT2FBSkJSQUxo?=
 =?utf-8?B?aTYxVUpieDlhZzc1Z0NmMzJiQUR4R2tzWU44eEZMSUU5dThwV0pTNDRqTm5j?=
 =?utf-8?B?WnhJYnFpemJ6alozZW1jUWxBR0d0MkZObHgyb2tRRjhjMlNIZWtDS3JpVE9u?=
 =?utf-8?B?MGg4TS9OQWk4MVhpQ0ZqazFINk1pVU9OY255cFVIbjg0WFJ0eHZoSDB0b0Qr?=
 =?utf-8?B?cEd2SVpLOURxOXJwdUQ1QVJOZ0o2dVp0dklWL3lEMnZjUWNmaXB3aEd1SkYx?=
 =?utf-8?B?UW9kL0Z5MUhLKy90d05GNGcraXZCYm1DNHpOellQYzVyb01nb0RrQ291YzV6?=
 =?utf-8?B?RW4wdHBnd213NDQ0VE1rcldpaHZBNHhscXlpMWZxdDJFZ2Q0Q2N3UkpPNkRU?=
 =?utf-8?B?Z2lMU3hBM05obXVzWTcwVmt1UE0wZlFyaTV5c2ZXdWJ0dlMwaTRISW5RdVVw?=
 =?utf-8?B?cFJEdmlkSE9wM3M3U3h4aUJ4blZYTzRVbmdzclM1WU9EUW4ySXdXVVNrd2Vv?=
 =?utf-8?B?L3B2ZGxDeG1QeGZHSzFnU2JzM2tiR08zVnNCeDZXTm1VRm9ud21qczNrcFgv?=
 =?utf-8?B?eXd0N2pLZWcwTm83eDRCR0RjSzArV1h6d2M4aXlud0RHVWJiM2xENXFPRDZC?=
 =?utf-8?B?N2k0WDNvWTE1NTRnSnJXNXVyTFpSU0V3NVFoYzRBUit5cjM5QlF5N1JSbDZ1?=
 =?utf-8?B?ZjQ3ZVpZdG03SjNhOXRTb2dRcVVjbXEwUDRYVGtlZ0tYL25qZVhIYW16OWdt?=
 =?utf-8?B?MjhIelowM2JJdHBqWkZxckRIZmxPaHYxc1ZWcVl0UnBDelhaV3RrNXpVMTR2?=
 =?utf-8?B?eS9EMlpmYjBhaE9mRHEwd2dMbjRlSDFoSWVYWmh0VGluLzh6d05MbkFPeUFl?=
 =?utf-8?B?T08xK3FUdlRUSzB4L3BWWnlPLzl6RVQ1djM5SkttdE50Uzk2SzVMamJLeVZU?=
 =?utf-8?B?N1ZKcUNRbGd0cnNRVkVHTjFmUllLM0NLSHZHT1pScnU5L1B2bHVnQzR0UEE2?=
 =?utf-8?B?dHFrcDRHSUFtM0didVdnaUNJMW9xREdybUsrM2pqMWxIMHl4ZGdWWUtGSkpO?=
 =?utf-8?B?enhuVlNUZ3lubUFoREp5WTAyWU93VXNnRGpUTmF2WFRHTFdlbHNCY0pvMEJm?=
 =?utf-8?B?OFNGd0ZPMS85RVU2TU8wdzBXTGxORGhOSGo0WThLeWNQWENHUXVwZWJ5b2Vm?=
 =?utf-8?B?NlA1WFJGTFpGbk1xTUFBZ2gvSSs0TllLL3c2YVVzTER4aWkxTWtaMG03b3dk?=
 =?utf-8?B?bFBCUHllSzRnU2xhRW9XckFHSWpqNDQvV0RYZHVyNHZJVU5GMVhSRk5LVTV6?=
 =?utf-8?B?VzJiRnVlZjYxTGZCRnFsRExUN29KUHpabjRDZERsYndOYmpIUnhlU1Eyc3dI?=
 =?utf-8?B?a3R6UElsZm9FNWJ6MDRRT0JTd0dyMG5ZSDlIenJUN29LRTNzalVZUzRWdHlz?=
 =?utf-8?B?TkJETTRLbXphWGVXOHJhTHM3Q0dvTXRtb0FOczZxR1dJSUJnVjZrejVrcHV3?=
 =?utf-8?B?WXBiNUh4WXhOUnJtbWVreHMvSzZvQklnUlpIcFlhS1R0VWtpanNXMDRtVlBG?=
 =?utf-8?B?QlBhWDg4UVpvWFNFeVMvaU1RcVJXMGY0RllrOUhoZXg2UFhlTWFsZ3pDS1dC?=
 =?utf-8?B?SmptWXlUanRzRzV5UXE2RWpwbDVUQzk5VmV0MlFhU1V2VzVRd1NBZFJEaG9q?=
 =?utf-8?B?K1NidmE3SGUySFdxN25EWDZ0cThBd1NicmZjdG5EaUVGUUpnbjEvOG9QRDBL?=
 =?utf-8?B?REMrQVlrZFFWUnBNOTRHdHROTHpvZDJSbGh1T3V5WTBnR1FhVFVraVY0UE5D?=
 =?utf-8?B?OEhSbE5RemttdGRDeWJQMnNYQ1g5U3NwTm5xZCtvQlk3MEVVaXJMS1p1WDJU?=
 =?utf-8?Q?sDhrHQ8aMzns3eRlTaeZeVOboCQBmC8a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmRFbGx3ZUpLbDhoajRVeUhqYWxDOGZJSVZ1MUM5WTRZSzBsZDQxR1VGMnFY?=
 =?utf-8?B?QmxMNk55N05GZjkxd3VWKy92dGxKN1RoV05WeTNkeEhJYUxCdXJTYjhRVTA3?=
 =?utf-8?B?NWhlOERQTWpjZjBXNGFWQzdBQkRneC9yL0hmdGtPZmMyTGs5YUZNT292eCtX?=
 =?utf-8?B?WnN1clRvSWxBSnFtUUh0R3NjWmhZRXhXb2plcmJQZys0Y3NEZGFqKzdPUTdJ?=
 =?utf-8?B?cUg4SXFUcWhPQUhRVURTWXVaTzdSZHZlQlQrMlF6Y1FheGtDVG95Rlk4Ym55?=
 =?utf-8?B?WUdZMmZybTcwYjIzWXVhRCtFVis0V2pnZW5NR1ZXd3pZcDZ5dk5CS011QVdk?=
 =?utf-8?B?T0p4dVkwSDFnNnBjbVJmWGxkRDRGVEtoVHNPV01RTHUxNnRkMVNyRktVRHI2?=
 =?utf-8?B?YU4weEJ3blAyYjZWdVM1NVA4VXAwOHo4dGV5QkxSSXRHdzk5SW84MWZvOWNR?=
 =?utf-8?B?SXVSVTllMC90SGN3L0xTVjhPUjRHQ0kzWG5FWU1zb0UreEpSUm1OR0hRaXZx?=
 =?utf-8?B?OGY3QTdzWTBRdnk1cDUzSllGRXdkdkpqK241clJMR2NONG9IOTlpV1BwWHA3?=
 =?utf-8?B?Z0xaSUNuUmIrQ3doODdqWW1QVzRFNFk4YW04RnVsMXlsOVBmcitZVnlQaER6?=
 =?utf-8?B?NWptSXVwVExsRS96Y1h5aEJ0QVBFQS9aejJDT0Q1WUV5ekFMVjNLWVFESG5T?=
 =?utf-8?B?VGZlNU5EWlllam5KTm1YZG9RV3dRYUJmeWd5YjQ2Mm1uSlFldmF0cEpyZ25R?=
 =?utf-8?B?bTRaQTZ6bStOOGl3eHlPZWZvTmtwc0dOQlAvQ3UwOVNCNEpXK2NxMjFvR2l1?=
 =?utf-8?B?RDNqbEc0RHJNcFVGcm51dkFKUVhlY291NzAzM28vN1ZGTU9kVkJpVmFkVmIy?=
 =?utf-8?B?aHlEWFMzOEdqK3ErYlBoVmFyaGRmaDZ1VkQrRzg2RXl4enNkL2JuaHFOK0VW?=
 =?utf-8?B?UWd6OERGcG51MFRzQTViWFhPWnFnOGx3ODBDWUQ5amJQWGh1T2p5MnBoYjdq?=
 =?utf-8?B?ZHlncTdCWTlQRXdSbGY4V1VhSXdic21KYnRzMEEyYUtwUXlxUEY5VXBKSHBv?=
 =?utf-8?B?aS9jN0pyUE8zZTdXYk53Q0JWU1dqZEdhME16S0RxSGhoNmVVUnVERnUvKzZM?=
 =?utf-8?B?RGlXRHJnOGF4V1VmRFRISmVpdmNoUzc2ZUl3eVBWMXJqQ0FlRGJHZmQ1TnRn?=
 =?utf-8?B?eFR3UncvSnhYMFFkMnVUK1g1SXY1MUlCL3F3RDRYVHNEYXFEMzBFYWNPQlVG?=
 =?utf-8?B?UXU3MzNFZXdud08xN0hqZUJpMU1veHg0cklNZGViaGkwUlN2U21XcEEwUEY4?=
 =?utf-8?B?bVh6SjNTWkV2RDF0QXNUb0tYSG0rYTUydi9TbXVsNFVXSVdXd2lISmxramhj?=
 =?utf-8?B?NHdaRjVPRENpNzFnVEhmTllRYkU3ZlNET2VzcDFCdWdjTmdFZlIxYzJUUmhr?=
 =?utf-8?B?dXJkMVlUQ3cxbWpEZmg1dFRsRElpZldvVmdzTXNCQllDTEVwRysvR1pCVElX?=
 =?utf-8?B?VVhSeFdvOWhRbnM4UVZmQ0xCdzlaVUlrZ1lvMjkzaGo5SHdReFhDWEJNT2kz?=
 =?utf-8?B?ZUxhOStCYVErbkhCU1hRaGl0ZDEwdGw3THZwK0NSaWM1b0ZvK0JlcDgvOGhY?=
 =?utf-8?B?UnFXSkZJZDllZGdNekhyeUlsSEx3UVpxSHZsZzh6bCsxSUVCaFdFeWJoS2pq?=
 =?utf-8?B?SFBjTVVVK01GK0t0N044ME92UndGOFNvQ1Bjb3dsZmlkMUYvL1pPL3hZVXRP?=
 =?utf-8?B?TlRjQkVSRG9icnJWODRicmJnaFk2QWZIZkpBRUpjSHUwcnlHVXlrSzk0TGlF?=
 =?utf-8?B?dEpCZ0dTenk4WUgxbUpNaW9zejA5Mlc0MUM5amNlM2t4UVJsangwR0dCQktM?=
 =?utf-8?B?aWZ4dXpZVUIwSjlkZU5IZWs4UUxueU40ajNubGU4R3RRQnRSRi9LYmd6UlNk?=
 =?utf-8?B?MmpUYVNxWWoyRno3S2F3bFhQdGdJTHNwaDFKZnhXcmZzMTJCWE9WVnlVUkx6?=
 =?utf-8?B?WUJNRFpYVnFvcTIxazBrVkVWYkl2S1ZpYzlxa0R5eCtOVHYxYkxobkQ5V1Qz?=
 =?utf-8?B?dUlIVk9IOTkwWW1UMlVwdVIvNFpKV0JrcEVkVGRmOEtIS0txU0ZROVdZZCs2?=
 =?utf-8?Q?pIPH397c7QFyg/TFiCGMDgubH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee51d5a2-0e6b-4eab-3109-08dd36e13b41
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 10:25:14.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYP73x+XLrqv/2Ndf0ngW1K6fip4ioRmZpOqMII19FLqOdfirnbf0d3+IudSkyt6VbgteFhbA1XNaUtbxutjRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6094



在 2025/1/17 17:33, Michal Hocko 写道:
> On Fri 17-01-25 12:41:40, zhiguojiang wrote:
> [...]
>> In response to the above situation, we need reclaim only the normal
>> zone's memory occupied by memcg by try_to_free_mem_cgroup_pages(), in
>> order to solve the issues of the gfp flags allocations and failure due
>> to gfp flags limited only to alloc memory from the normal zone. At this
>> point, if the memcg memory reclaimed by try_to_free_mem_cgroup_pages()
>> mainly comes from the movable zone, which cannot solve such problems.
> Memory cgroup reclaim doesn't allocate the memory directly. This is done
Yes, what I mean is that we hope to reclaim accurately the specified
zone's memory occupied by memcg through try_to_free_mem_cgroup_pages(),
in order to meet the current system's memory allocation requirements
for the specified zone on the memory allocate path.
> by the page allocator called before the memory is charged. The memcg
> charging is then responsible for reclaiming charges and that is not
> really zone aware.
>
> Could you describe problem that you are trying to solve?
In a dual zone system with both movable and normal zones, we encountered
the problem where the GFP_KERNEL flag failed to allocate memory from the
normal zone and crashed. Analyzing the logs, we found that there was
very little free memory in the normal zone, but more free memory in the
movable zone at this time. Therefore, we want to reclaim accurately
the normal zone's memory occupied by memcg through
try_to_free_mem_cgroup_pages().

Thanks


