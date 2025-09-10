Return-Path: <cgroups+bounces-9873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E0B518BA
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEDD3B5AA2
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43E322C80;
	Wed, 10 Sep 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oauGPOTr"
X-Original-To: cgroups@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013014.outbound.protection.outlook.com [52.101.127.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC749322A08;
	Wed, 10 Sep 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512954; cv=fail; b=PJtBhsd+5/N1P5n8KD6zBbMOi2ZLJ/4pYrynO/SeQl/PDi39HOmkrt+x1KblVr9nMpsYxv+6+kv9bBFn1k3imoNKmRWfY8BF5lhs1ptlnD5aUKPP461W+mQ1pxpgDdDK+IB/llCwLSuVn7mLzJkn8rrFDgf9svrPcXU948ia1JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512954; c=relaxed/simple;
	bh=4RDRDLlraOIOClcfUFXOadqR+dsYuY5VTwZWqNn87pI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ftm/qsyL6lWxA2fPKkikyCmEK5axcmUSA21qRIzHbX1dNo1Y/iUUav7CNnDj3ufzwCPL8ab+13WAXmXlol34V3E9gE9rSJC/so3eoj370isDOKHeJD5aoKgMp30KugMsPUOSdxEqPlSpoPdT+Ly3jS1Dbh8iJ1ssQlS193Qa3Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oauGPOTr; arc=fail smtp.client-ip=52.101.127.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q087JwwTIjOqW0x6cMJXKdwl9zcu2lhssbiRczz1v029kUR0NM1VGTcdVGnAIAOzuX+4+FrkHaUHdOIhglaDFAPdyx/RSN+YZbt5qiYoaU9taXPtisD8L6j2dnfQBSM6hx2aGpL+h9/Y9SqO49YeyZ080kOBMj8ylx7CEwbZ3G5o1s+Oy1JvxzdgCTsbYaDQGr4JetUKXxiQSXyaRQ6pTObgoGlTfPAXTlgrmnQpa/RMgCuSl6CgPVViu6whW2GDoE8cwUNjAc9quL+li0CmWYnl+E/ADNV/a7HhzgJg40JdVR8CH4m4YXOfWrpQOaFrf8P2tFwFN/DCTAFpIGi4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ7z7yywRlpeNvwinQC8avV4Eq8c4/ukVN7VXeDc7HU=;
 b=JGf7NPD2e/RiLQL5FvFUQj49Kcs0GclYwdtwLB4TZbvxfIh8SMfdBgv1XUjY69yrxhO89QJPoSUaSJUosRYjZzOv1PiclTKg8jPS8GdYOolP5vD53hnCWK12Jh9D+Nft5ax95x6geh2d0rZ2pFk4ACz/AfZ4NHTRva0o2C0v8lRXrXn54AV4gy8kU8WG8W7jilLBSpacdLl9c0+w3fp688OS01ZKabutkNta8gDANrYPc0PDiS7ShRth7eP9UGYiu6cTfyZq3/RFuFIxduo0786KOJnKuEclRiD9DxvwKDPC21KFhIntCsrmvH722Ri8OpQFvv0hbAMhCH1MOEMzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ7z7yywRlpeNvwinQC8avV4Eq8c4/ukVN7VXeDc7HU=;
 b=oauGPOTrMhQwpDnFNiFjkqUYEZABmvGq29kgiUClPihWmzUw2QR11RaqeaFjRMILu1ACcph4BBKgRMx3m3clbOXg42ahYN1lhtggnz64c1aM4GL4Rs8AeBLX2WeWmMf5jtFKGRmgd+tjwUUZr0wQy3jOLWunlIFJhFEYyRJJfItmY6wNzvuYHGxPlWIDzOE4S6KN+r6oPphM7xzAQm+HYZBkpAQubJO+FSOkbClmdlIxWU5FWdbF3mIoHOMVp6Uy3UUtaKX1c1oRIns7xhod5h3SdGKphyAQwFFWXTPJHAFmWlexljICg66275HcgDMEvKkcb5wLr5l0OTyzHe42KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYZPR06MB5931.apcprd06.prod.outlook.com (2603:1096:400:340::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:02:27 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:02:27 +0000
Message-ID: <eee7d740-cf71-40d3-a037-543ae28c187a@vivo.com>
Date: Wed, 10 Sep 2025 22:01:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async
 release
To: Kairui Song <ryncsn@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Brendan Jackman
 <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, Hao Jia <jiahao1@lixiang.com>,
 "Kirill A. Shutemov" <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Fushuai Wang <wangfushuai@baidu.com>,
 "open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <cgroups@vger.kernel.org>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
 <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYZPR06MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca30624-262a-49b5-19d2-08ddf072ac4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|42112799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2diU2FyenArSkxsQ3JoSG5nQ1VHYkNwd2gzVmIwZTl5ZldDRFlkRkZUeXVl?=
 =?utf-8?B?UC9YTVc4WUFqVUkwQTQyTFUvMDBaVEdLUzU1OWN4cjVXM0c1WlllYjdDWGQr?=
 =?utf-8?B?TVJRWlpuaDNTRWNQTkVGUDFyMlVmTzRhMmhwNGtHbzdCSE1ETE5OWmtUTFhO?=
 =?utf-8?B?eXI4aHVQR3RWRk91NHByajhXOEgrcUFEL1d1NlVNUjJTOXN4RFRBSld4OGlz?=
 =?utf-8?B?TUY3dGJTUmgwNWE5bE8xVlAydjloOHpGRVhRdVozcldpMXVBc3hPMVhzVzUz?=
 =?utf-8?B?cnd1WUZWam5kSGNsNUZ6NTZpbEx4WllsVEV2N1gvek1IOXgrTGJadnV1dVlN?=
 =?utf-8?B?Q2JNY0hkS2hqYldZbzN0aW9iWVdycXdOV3ZEOFBKbitwREJzZkgxcDVrcDlj?=
 =?utf-8?B?Qk9CdE0zVkYvNHBHWnpLWEY2cTBmYWRyMnExSjcrdEp5bTd2QTU5VC9yc1Mv?=
 =?utf-8?B?b1hoUFRtUUFCYzhYMFFCdVh0UnNlSmZqNmpaWmxhaHpTNDlFYjBxMUFWaUwz?=
 =?utf-8?B?dzIrdEUrUk0wL3NHbHpFclkyQVBHVjRiaFZyc0JKVUM2NXZIZkZUT0ZLTDJD?=
 =?utf-8?B?cmV1MmlUQjRhSlQ5SzdQWW54YUNPczQzUStwWXEzQ3k3U1FHL1d0VnJIMjlT?=
 =?utf-8?B?VXovZ3hXN01adFFmWE5HTExQY3RiQTcvbjFTM1JqYm8zSFRGUkIzZ0VFMUsv?=
 =?utf-8?B?NDZlU3BPZnJXbnoxQUNpUzM5RGE2MHlNV2wxRE5FdnNCdlVGMjFwTXdWVnVw?=
 =?utf-8?B?UFZrakRpVFZDbzFMZCtUL3JUc29mOW4yRGZCVmpPcmtHK1hOQU5IczZrRkRi?=
 =?utf-8?B?THBRMmxoRDE4NDNJWTR4SVJKdHN3WFZZdEFzcVQyVnVkc1IxOE84Wm5BbTFy?=
 =?utf-8?B?NUhJYUc3RmdKdWJSRHRHUDl1K21LN3BXTWZPUVlaMWN3ajZndXlPdktNM05U?=
 =?utf-8?B?c2oycnFnTW13bTNIQ1NDbUdkMU1ZZjV3NEJ1Z0YxUTh6aDdpRGRNcHplZ2c3?=
 =?utf-8?B?dTdQVFJOZ2FaUllCOE91Rk51T3I5bHRVSitnamg1d1ViY0YvUUgwaDYzd2lH?=
 =?utf-8?B?WmdHeml2ZGNXVzZaY0RsQWtVTVdaZStsM3lWdXI0N0F6bXFmSlZJRjJIdjFz?=
 =?utf-8?B?OEt3L29BMTdqS1hGdGU3MWlqeG5vZzROUUJwN0FqSDN2b2ZvbTdEMmZQc3VB?=
 =?utf-8?B?aTFBcDIvUzgvQVpvRmIzbGxWc1JUNDlVRTFSSXpFUlBNWGJZeUpnM3FoMTdw?=
 =?utf-8?B?dmlnRU1kTG4wNDlqaXBFLzNqNUtNNDI1dE5sSmV3bFFxVkJPL3pGUEpUOStR?=
 =?utf-8?B?VGkzdUV0L0srMjZaVmdxQTZObmdPa0tPSkV5d0lTT2lNb215TEhCejF5RGFq?=
 =?utf-8?B?QyswY0p6b1JWcUxGK1NIRDFDdStIVk1WSFNvNFNoQ0dMNFFIVmlYZnZYeXlM?=
 =?utf-8?B?K0dTUjl3eW5ZbUg0T0VTSjk3R1lqbWpTWUJGUkFHRkFQTGxEMFpyeDNiSlIz?=
 =?utf-8?B?djNneFp3dktza3hLcnF4TjROcEJ5ZDJLOXZsVUQvaGRrb2J6d1kwd28wdWNt?=
 =?utf-8?B?aFAxb1RhVFhVL3hZajhQUUZNNVV5RTVMOW5yTmhZVTRIemNHK1ZpWVpkY2dY?=
 =?utf-8?B?Wi8zZHdlTGJrZ0lQeGtUU3UxT21Eb3FxSlJPTlU4ZTNJY0dHMmtWd1hKOGdJ?=
 =?utf-8?B?NFROZ3M5ZUFNWno4WWdHZnNtV3J1UmdmOVNjR28wNTdaeU1aR0d3Y2x6eWM1?=
 =?utf-8?B?V01BalhSQ1NxQWdnU1E5eXgwRjJKNEVkQlV6dWpNTkQ2S3RQWlN3WEZvOHIx?=
 =?utf-8?B?WHlSMW42ZkRsVU9EV3lwTkExN0JpTTVRK0xFdUsxR3YwYllNU1o5ZkNlTkR4?=
 =?utf-8?B?RFR5RUU3TlVqSzRCUTZsMEVoL0RqMkdMQ2doRzFHU0s1dWdYRzhqd0dCOFhu?=
 =?utf-8?Q?7zveEMoD4p0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(42112799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFNZZSswZ0k4bTZFTkRwbUhPNDNvYW12TEZ1eGZZZlJaVzVjTEE0cWFLVWpR?=
 =?utf-8?B?azJLeFRMYTFUK01naG0zRGtwSk9rYWJSNFpIYmJ3TXRGU0FBK3UvZmxwOG5X?=
 =?utf-8?B?MWYzWVpFY2Nlb3cwb0JyUUowTXRPeHB6YWtPclp6T1JQQk1mR3RNZVlJSmpU?=
 =?utf-8?B?QlUvWWE3S2RpZ1BKbWFCdkREY1pMRG83UzJaNm9kQ3F2LzArZ01yWng0bWpH?=
 =?utf-8?B?K1ZqSDdMWnEzYUlleXBwbmJMV0dsVFBuN1A2bHVRSXBLTWVhalhXbUtkdy9H?=
 =?utf-8?B?QXhoVktSTHM0RytXNktISHNWZmJUV09YbUZ1c1VOaVJIWFRqVUNjTkFrcUVC?=
 =?utf-8?B?OTl6VTlhbGVJa2xBNk5Wc1UxT1ZwK0RUd0VlUG0wMGpXSlo1amZZSnN1ZUdM?=
 =?utf-8?B?UWZIRHk1YVgyQ3lTakNac3pnRGJ0bkwyc3FnQ3kwVUhGSmx1RmpOUjRMQmNr?=
 =?utf-8?B?eXRZdlVER0p3cm54ckFpZTgyYzBTOWlLRG9WbGJEdmNUYVM4TGlEMlowZzBG?=
 =?utf-8?B?RnJLMzA5eGp6N2xzdXlrQkVuNzY4cVpadjB5M282emV5YnBJTWltMDd3eHBS?=
 =?utf-8?B?ekpVMlQ2ZU84WG5XU1dIUkxKOTRvV3V6WnRiUkVWcjZPL01oNTg4ODJmSnBU?=
 =?utf-8?B?OGpmdnNIbndEMUUzeTZnKytlWUJCdTlHQ3Y0T3NSbGt2UFdwenJjbGtsT2JZ?=
 =?utf-8?B?dm9kUUNQTng2Q3pRcjFlU1p1aUJ0TndoOWFtd00wMWxHeGh0Z1BBcDNQWGNW?=
 =?utf-8?B?cTA2QUNGMUFkOEg1Y2JaZmxDc205NlpmVEJDU0k3TjdiTlZCVFRCcTBqNkN3?=
 =?utf-8?B?QUkydjYwdjNjcGt1L2JlZlRPS0NjWnNaNEZHZGtSa0VNYWJxWTNCWnhBbllh?=
 =?utf-8?B?SFRvaFZEdzFWS3VyL0o3T09IOVZvb0FiNmdCVFpoNkNCSDNHNTUvUFVkQjVE?=
 =?utf-8?B?a2hRNElTL0hBKzJXVEdkaHZ6UUlaWmxwUjVRRVU5KzZqczdKRmZ6Z2U4OXAz?=
 =?utf-8?B?MWJhQlhCWE54SkdlQUorQnMwZFZnL3d0UTErZDNzbFJMV1pGdXhVbDBJNDJG?=
 =?utf-8?B?elVaUnNKMlEydkhSV1dWSzZVcXh1WFJSL3poQXR6RXlTYXpZQUxrL3ZxQnpY?=
 =?utf-8?B?TXZhSWV4VytXcE1Yd095K0tFb0NQR3EvU1VMMGdzWG1tZEJRcWl4VExJWHZ5?=
 =?utf-8?B?aDVpZDgrTithcXJvMW1TMGhjZVVSeHQ2WWJSeHhjaUJZRHc1cWNVUEZXVThr?=
 =?utf-8?B?b09ORG9nbDZNZVBleHpxdHNLSmJrRlZiNTR5YVRpby9PTm05bU40anhGaTV2?=
 =?utf-8?B?alhVNm4xNWNEc0w0b1pIcmVKQ3ErQW8wR2ViSSt3Njk5VGhBTVV2d0hUcjZS?=
 =?utf-8?B?WUtGRjgySEJKVWZWNzF2b3g5Njh5b1FHQytScTU1VjVuTFZVQ0RwaS9kUVl3?=
 =?utf-8?B?MTdwZythdmhTb2QwUmxwZGlLdlVIYlhPam83UU1iS3IvUFEvRkVIWWZkVFFT?=
 =?utf-8?B?Rngydm8rTzgvRVZYM056UVYxY2hyaU9sdS9MTWNGN1JoRVhmaktQeWJleTRV?=
 =?utf-8?B?VjhsbGszYVpuR2pmUU4wOWxpWTBhNjN2SzY5djVLZVNLK3MyNnhkOEVPZ2Iw?=
 =?utf-8?B?aVRWYWNhMUFKQUplYVhxQTNqNDRNMGtHNDljNmZyVzQzZzM5UENZK3MwOHNJ?=
 =?utf-8?B?UXB3dXdZRGNMTGxTL3V2aHBOUmtBWG9PeUh2Y1dUY3BOMG1Ld2xTUWlvU2JU?=
 =?utf-8?B?VFFvb2RTSVFLSm5UWC9XaGxFWktidUF1c24rZ1AyRU1lNEV1SGRDR1ZWNHRt?=
 =?utf-8?B?UzFWaEJYRnF2bzRCSkMxUllTRW51QlNOS2FvWVVUNG1qNENaYzFVbUpiRE9D?=
 =?utf-8?B?WXMrWHJPUm1saDZmVDlscjFsWVltWFpnWEVRKzFmK29CR3orQkcyWEx5SFhu?=
 =?utf-8?B?SGZlWTFXZFhvRmQ4SEJVQWhidDVwWnpJeTVsRFkzd3JyN2xFRkdTTHhmVkla?=
 =?utf-8?B?bTlDK3hWRFJJd1p4ZDZ5UjQycE1rUmt5dGVjeFBsZ2UzemVmajJ2bGc3cjZS?=
 =?utf-8?B?T0Z3S1Q4R0hzOC9Tdnc2V2tCbTVsTTU5eE1qaDJsNHY5bVJpSFJYVkdRWXRI?=
 =?utf-8?Q?9Ru0OsS6kegS6l3l9hWJGq5Hr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca30624-262a-49b5-19d2-08ddf072ac4b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:02:26.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zt+3HrTtQykrY1Zyon/vbq/bBrLHKczm8mDq0ORAzQYNHp3Rbo58jS7fsX6feHLowGtRDhUf/q9gIE88ObwBfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5931


On 2025/9/9 15:30, Kairui Song wrote:
> [You don't often get email from ryncsn@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Sep 9, 2025 at 3:04 PM Lei Liu <liulei.rjpt@vivo.com> wrote:
> Hi Lei,
>
>> 1. Problem Scenario
>> On systems with ZRAM and swap enabled, simultaneous process exits create
>> contention. The primary bottleneck occurs during swap entry release
>> operations, causing exiting processes to monopolize CPU resources. This
>> leads to scheduling delays for high-priority processes.
>>
>> 2. Android Use Case
>> During camera launch, LMKD terminates background processes to free memory.
>> Exiting processes compete for CPU cycles, delaying the camera preview
>> thread and causing visible stuttering - directly impacting user
>> experience.
>>
>> 3. Root Cause Analysis
>> When background applications heavily utilize swap space, process exit
>> profiling reveals 55% of time spent in free_swap_and_cache_nr():
>>
>> Function              Duration (ms)   Percentage
>> do_signal               791.813     **********100%
>> do_group_exit           791.813     **********100%
>> do_exit                 791.813     **********100%
>> exit_mm                 577.859        *******73%
>> exit_mmap               577.497        *******73%
>> zap_pte_range           558.645        *******71%
>> free_swap_and_cache_nr  433.381          *****55%
>> free_swap_slot          403.568          *****51%
> Thanks for sharing this case.
>
> One problem is that now the free_swap_slot function no longer exists
> after 0ff67f990bd4. Have you tested the latest kernel? Or what is the
> actual overhead here?
>
> Some batch freeing optimizations are introduced. And we have reworked
> the whole locking mechanism for swap, so even on a system with 96t the
> contention seems barely observable with common workloads.
>
> And another series is further reducing the contention and the overall
> overhead (24% faster freeing for phase 1):
> https://lore.kernel.org/linux-mm/20250905191357.78298-1-ryncsn@gmail.com/
>
> Will these be helpful for you? I think optimizing the root problem is
> better than just deferring the overhead with async workers, which may
> increase the overall overhead and complexity.

Hi Kairui

Thank you for your optimization suggestions. We believe your patch may 
help ou
r scenario. We'll try integrating it to evaluate benefits. However, it 
may not
fully solve our issue. Below is our problem description:

Flame graph of time distribution for TikTok process exit (~400MB swapped):
do_notify_resume         3.89%
get_signal               3.89%
do_signal_exit           3.88%
do_exit                  3.88%
mmput                    3.22%
exit_mmap                3.22%
unmap_vmas               3.08%
unmap_page_range         3.07%
free_swap_and_cache_nr   1.31%****
swap_entry_range_free    1.17%****
zram_slot_free_notify    1.11%****
zram_free_hw_entry_dc    0.43%
free_zspage[zsmalloc]    0.09%

CPU: 8-core ARM64 (14.21GHz+33.5GHz+4*2.7GHz), 12GB RAM

Process with ~400MB swap exit situation:
Exit takes 200-300ms, ~4% CPU load
With more zram compression/swap, exit time increases to 400-500ms
free_swap_and_cache_nr avg: 0.5ms, max: ~1.5ms (running time)
free_swap_and_cache_nr dominates exit time (33%, up to 50% in worst cases
). Main time is zram resource freeing (0.25ms per operation). With dozens
of simultaneous exits, cumulative time becomes significant.

Optimization approach:
Focus isn't on optimizing hot functions (limited improvement potential).
High load comes from too many simultaneous exits. We'll make time-consumin
g interfaces in do_exit asynchronous to accelerate exit completion while
allowing non-swap page (file/anonymous) freeing by other processes.

Camera startup scenario:
20-30 background apps, anonymous pages compressed to zram (200-500MB).
Camera launch triggers lmkd to kill 10+ apps - their exits consume 25%+
CPU. System services/third-party processes use 60%+ CPU, leaving camera
startup process CPU-starved and delayed.


Sincere wishes,
Lei


>
>
>> swap_entry_free         393.863          *****50%
>> swap_range_free         372.602           ****47%
>>
>> 4. Optimization Approach
>> a) For processes exceeding swap entry threshold: aggregate and isolate
>> swap entries to enable fast exit
>> b) Asynchronously release batched entries when isolation reaches
>> configured threshold
>>
>> 5. Performance Gains (User Scenario: Camera Cold Launch)
>> a) 74% reduction in process exit latency (>500ms cases)
>> b) ~4% lower peak CPU load during concurrent process exits
>> c) ~70MB additional free memory during camera preview initialization
>> d) 40% reduction in camera preview stuttering probability
>>
>> 6. Prior Art & Improvements
>> Reference: Zhiguo Jiang's patch
>> (https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.com/)
>>
>> Key enhancements:
>> a) Reimplemented logic moved from mmu_gather.c to swapfile.c for clarity
>> b) Async release delegated to workqueue kworkers with configurable
>> max_active for NUMA-optimized concurrency
>>
>> Lei Liu (2):
>>    mm: swap: Gather swap entries and batch async release core
>>    mm: swap: Forced swap entries release under memory pressure
>>
>>   include/linux/oom.h           |  23 ++++++
>>   include/linux/swapfile.h      |   2 +
>>   include/linux/vm_event_item.h |   1 +
>>   kernel/exit.c                 |   2 +
>>   mm/memcontrol.c               |   6 --
>>   mm/memory.c                   |   4 +-
>>   mm/page_alloc.c               |   4 +
>>   mm/swapfile.c                 | 134 ++++++++++++++++++++++++++++++++++
>>   mm/vmstat.c                   |   1 +
>>   9 files changed, 170 insertions(+), 7 deletions(-)
>>
>> --
>> 2.34.1
>>
>>

