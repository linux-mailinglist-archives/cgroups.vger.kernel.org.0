Return-Path: <cgroups+bounces-7849-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3EA9E638
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69014189BF89
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 02:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6C13C914;
	Mon, 28 Apr 2025 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AKgfrcKA"
X-Original-To: cgroups@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011039.outbound.protection.outlook.com [52.101.129.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68FA86352;
	Mon, 28 Apr 2025 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806827; cv=fail; b=TETX3junv2Jkfst5qIufmZtC4WgHx8S4TgXBrzL93J/mfH8ELYHz3idG+vsSp6FvWjz2/G8kXFRb2sVIwwn3tcsemLcGo6vW0FT9+IsaWUTM4jH6X4sDrPZeMPLh4a70wK0tJPlDS/6LonV9A5CDnr6ScmUWxFdwc7Cp8+pU4mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806827; c=relaxed/simple;
	bh=aAUsIvU2NRrqv+d/ofhVN+SBFAmHOXw321zcbvzVS0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W01Mg2VFEPqbFvDEm24vN4HtVZk3E/ujFXAzBVwzaAhw1rE9v+59suugHOxyUB/ad6TtSsaS4SpIsOAmifgeRtGFKnIDYl5KjL4h+SNnmJS1+HoLPnVeYyTq+JRr2Bmbp7exSdoVHiMeu3hzpImpoULHIEEdIrbOrOmquY6pL0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AKgfrcKA; arc=fail smtp.client-ip=52.101.129.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnH3keZ//VN6j05k56Xdnet7OPuIB9rEzlXkL1a+eRdN8t2EGqUmVA1sSHaI6WLIfDSoG72bKMrDdxTw9xRqF0sZeB95+PLCkcPyTK1oqF/B8KQIeQKkzdmFE9CrmsHmX6HgutewTjPloVOkoXpYHEQDkCNstv3qAlFxtn0+3ALxrBDHc8YgJN/EJXUZIXtey/Tb+Btka2SaVYZhtHXzff5g6iDq0nFAbp8tDB5vo61DhiO9BkJ4fszE8wMRj7g22NX/HIAw/eolQJ2A8YnDLTGcjkr831iSzRv78dCAoM9JvtleOvtGx1PM4AMJaFj/sxNYxtkbK6Qd2+djeoAuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAUsIvU2NRrqv+d/ofhVN+SBFAmHOXw321zcbvzVS0s=;
 b=AaSiU5cJh1GWdvzb5JYt7MSp9mRIlXEN7xVHx8zR1xhkH2uovXId3odPlDbjVKzt+6NMge013/nPAmIgjjX5yQ5f/vJduRP9ay5xBfNJw6acQ/h/sqLml+rrzpJN2kobKJQewQkUP2dWefoCzYivLVk8ewdos1uUnwpRLnjL3D2N+F5xG+v5LVz4Ksry3OFWpPWai8tF+4ocdApa9SBgneXvBgSPuE8QPuQ0BZn7ucJfMKMoNnMunhYYzeI3Ois72pRB4/g7gonqJ5qdWjzKtwP+/mHNvgp3xzKpYUufF15HqcF0W1Ctay2I1UnZPc+RSZwMyS61h2zyaRyDf2xFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAUsIvU2NRrqv+d/ofhVN+SBFAmHOXw321zcbvzVS0s=;
 b=AKgfrcKAtaAXsu9F35vNaegjHPsr7ReJ+F/zVdba6nu8hWWnaM50WIYdXMN5GYzp3BZDSNr7LDBHbnWSTLQhJOR20w8W5g/4TemIPCqArtf/mV4n3VwR1quiygBWCPD4BXUGK6c3p52hBAYN6QvYfwneOhyODtgmY8H6NGJmjR6Xi1WKrJNpofQrWNxLZx8G2UADQOpZNJzfA6X+Jet03XfBndGJpr8sokKBpwFWOpwZ3a8K3uW5tWz35Cxtd1Htlxa2helu1usIeayv6jJIh7IfRqrVEoMg7c9qWh8gk6gidhxo7h/BNHBGEtwLEl0t/kAahBG9+jLsyhWhm5RE7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYSPR06MB6607.apcprd06.prod.outlook.com (2603:1096:400:474::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Mon, 28 Apr
 2025 02:20:22 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 02:20:22 +0000
Message-ID: <e0fedbec-be1d-41f8-9af3-e024a5bc18c2@vivo.com>
Date: Mon, 28 Apr 2025 10:20:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm/memcg: move mem_cgroup_init() ahead of
 cgroup_init()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Francesco Valla <francesco@valla.it>,
 Raul E Rangel <rrangel@chromium.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Huang Shijie <shijie@os.amperecomputing.com>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, KP Singh <kpsingh@kernel.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>, Boqun Feng
 <boqun.feng@gmail.com>, opensource.kernel@vivo.com
References: <20250425031935.76411-1-link@vivo.com>
 <20250425031935.76411-2-link@vivo.com> <20250427114609.GA116315@cmpxchg.org>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250427114609.GA116315@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYSPR06MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c68b50-2b68-4b30-2fce-08dd85fb3a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkFDVjh6YU9CUWt1YVJkWm5tOHFSNHBUZlFYQ0kxbHpMbzNGempLVHVvSXpz?=
 =?utf-8?B?cGViWmwwVGtndXJ0ZzIwVFlHMmlFSVM1eFpDdUg0a3lIdVdCd0xZbDZ3cWJL?=
 =?utf-8?B?Z2VDWWp2VWI0NW5ObHk1TEw4VDRwbzBjNHNHeXZaRHBoTUlkcDI5UjRRR3py?=
 =?utf-8?B?bHFZTEhBb1A0NjJXRjhXK3JYYXlFRmpFSGhsVUdWUFB2MHFpdlZNbjdBTWZV?=
 =?utf-8?B?d3o5WEVhUkRpZHpkUnhuYUdkTXZ2UVQ4SDFKVGZIYmYxM1o1YmF4a1BIR0Fi?=
 =?utf-8?B?SDI3SEUvVG9vQnZwVDRVRU50UWRObk5VYlAvck80TGV0bTFEdGk5U3RSckdX?=
 =?utf-8?B?T3FBNTFVUHc2Y2Ewb3N6QkwvbUtwUVhraEFWZkp4dC9HeXJKV1RvMlVVOE1J?=
 =?utf-8?B?QXdySFkrdFh3VHlHVTlkc1g2UGxCWVJwcTgxekFQb1dLdWg2UDNrbjE3VlQ0?=
 =?utf-8?B?NktOdjBudEJYVnRicTA2dnkyaXM5V1BoczA3Qm1BOHRNZDNCckE4bTV0M3ZY?=
 =?utf-8?B?c2g2WXhPNHRXN2N6cHMwbnBMbWdBVXRrZmloWG9uc0hJWVdhcVd4MHVjb0Uw?=
 =?utf-8?B?K0pId29ac3I4dlMvWVllS3lDYmJGTDUzb3kvUnU3MktBZkZMY2VRdTRLbmU4?=
 =?utf-8?B?RTRuSlh4ejU0b1BTbGdwY3h1d1o1Wk5Xb2lwajlFNGxveUFISWJ1bXQ2TVhU?=
 =?utf-8?B?US82QUFlWTZSS2MrUzB6cUE3OWhXRGZ4S0tFNUVYMkpDYzJXZzNyNEZSQ0hN?=
 =?utf-8?B?ckQvT2FRYXJTaTN5UEl2cWJNbmVlYmMrZlR0MXZPQkVZK0RvOU5MVUo2VmxY?=
 =?utf-8?B?RUl5VE1KeENVV0tpMHVYQm1PZTBibWIxaFBrVG9LaEhKUlNoM09LNEFQSC9S?=
 =?utf-8?B?NDVxWnNiMHZuVEl5UVJpYm5ySzBCY3Urdll0SnYydmxHd2NBU2hOYlY5R0tn?=
 =?utf-8?B?UFFmbnJLTHlpaXk1UjdxL0RJUWc3NEE4WWsxSTJwSHNSQzB1RjJ0NEovN2NH?=
 =?utf-8?B?QkxXbTUvUEV0YjRPbGh0YzIwTXZYR0cvekV0d3lSY2wzVFM1UUtabU5wb0hl?=
 =?utf-8?B?ckFoc0JubTR4NU1wdTd4OXI4N1RvbUNtbmkvQ2lIZC9PZW1JUjEyN0Z0dEx5?=
 =?utf-8?B?WmNUTmJHamlQVmNId3JQUFYvYnpMY3Y5VHRJcThxd2N5TE9IbWp0aXRNOFFi?=
 =?utf-8?B?dGpZQzdac1h1TkMrRkk0NVhjYjlQaUFqbVRUSnFteTFVRUFmcm5pMGhhVENL?=
 =?utf-8?B?T1Z0K3c1dHlVK1Q2ZUdvejI2Ly9UUFNtVjc0d3JNNXFwaTViZ01LZnEvOE4y?=
 =?utf-8?B?NVdnN2xaL2s4RFg3R3Nudm4wbVU5ZnRKREorNXliSEFRNUw5WUkzdjgyN0lj?=
 =?utf-8?B?bWJxMXpPN2FkRUVTRnZQeitaUDNDRGxiSTlSTSs0cUZKRVBxMUNISWlOZklo?=
 =?utf-8?B?SytYZ1M2NG9iRHZEZE1weWx6bFBxdU9yWmR1VDEzMzliT1MrK0NSNEhrT0c2?=
 =?utf-8?B?dFRyVWk1N3NxMlNTQkE4QVljODRyOXFGRzIzbFcrckR4Qy9CTit5Qm1MT3F0?=
 =?utf-8?B?WEQvOHYwQjY4REJYWUZNOE1XbEFRWHNFeDVPVUFpTUhodUtEOVNqM2dXVG9V?=
 =?utf-8?B?eDhYalBXbkl2d0diejhiOVNiWWNnVDh2aEYyZFVwY0g1VEltWFRWQVpjdTNR?=
 =?utf-8?B?L2hSdC8rYjZTbEFPQmlXQWJMTGRLSlNoSjRrdlRTTENFYjBjdzFjRStyRHh5?=
 =?utf-8?B?WFM0MTJMdDlKa0ZobjRneWpMOGRwK3FOdWcvN0ZHNzRDcWNQeHRqbndRaVNQ?=
 =?utf-8?B?ck53RFJQc1dNYk50Y29TbzZ1ZVNURjFJTGFTRk9JMTJTTkg5eDh6bmY3L0RN?=
 =?utf-8?B?eW45ZDdzODdEQVorS085S1NyS05BYm5xVWY2STNTQW5jQjR4QzRPQ3VzWlpN?=
 =?utf-8?B?MitkZzVhMmN5YkhNSFV6NWYwQUJjdnE3eFhGY3l0TlpXQURINU1GUVVlbE5m?=
 =?utf-8?B?R1BKeXdwaUR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHVobE1DWVhqekYvZ0RKOGQ4ZUxFOHR0aEdISGpWS2tMODhrblhoRzhlWE1m?=
 =?utf-8?B?NGF4d1Y2SW5jYUg4MU1LOHdPSW9jaWt1bUFjUjVDb3kxeG9rQW0rMmxxdk03?=
 =?utf-8?B?WEx3d0Q1eGI2dEREMy9Wb0NSOElzdkRVYW85SUxZNTdqYWpldWdLbHhCMSt3?=
 =?utf-8?B?VElCTnE0MDdybmhXVEczbkFDVDlIZ2wyV2d3WGNraGsrWG9CYkZKaHZkbTBj?=
 =?utf-8?B?NVF4OGcyUndSV3hOOEJnVE43RkxaWTFuLzlGWHdUalNjQ0ZvK1h5UlBYTmpJ?=
 =?utf-8?B?Y1dxNE1ML3dyL1Aybnp5S09WSXRhL0plY1FTRjRRTytjRDZQTDk2aU5OMUhr?=
 =?utf-8?B?dEFzTUsvTWRWUHFtMVl0RE1kMERUSjBDTVZwbU9Xa3hZMHBmMWlwUXdWam1K?=
 =?utf-8?B?VkZFRHpDaGdoL1JkRUlCYmpBMG9Td1BCMGllWDE3SmkwWGMrcndxVUJQU2Zp?=
 =?utf-8?B?aVFqVW9pbkhKZlNUZTFJS0Mxd0pQak5Qbm9JbzEraUFOOGVvZTBBQTNYa2hq?=
 =?utf-8?B?dHJ4SlZLZitWTUZIRXd2eXVXa2hURzExV09Tc0k0ejZVZ3BJQ2JiZ3o3dVM4?=
 =?utf-8?B?ZlRBbUJSS1RoVzVRNFBBdWY4cHlTMEh3SG5FWHNXb2d2a1Z2cTVrRUt3WVFp?=
 =?utf-8?B?aGdzNGJHWVlOOEQxTEVxSUdkMFJYKzlxZUZ5YllNdmxxeVJ0MzVSdDNsOG1y?=
 =?utf-8?B?azlnNmp6SHJYNEpSRW9SQXNHRElpRno2Njl4Y2NxRzV5a1FVTzJvYzgxWVBk?=
 =?utf-8?B?TFQwcDRHN0ZLa0FsaHdxM2dCTlA4bTd6cW9DVFNjcENpakx1aENrYTVDUjA0?=
 =?utf-8?B?SjJKMTBHMjNWak52bS92aERvY3hBVTBETXZIcUM5dXM3UHUvM3dVbXp5ajNr?=
 =?utf-8?B?S2FkWUt3T3hBMHVkaFNwYXhqek5aMStGcWdCeVVCSVcrUUM0OENSS0d4ME41?=
 =?utf-8?B?ZzQvVDVTaUp0TSs0OGc1amtMek5DcnpuTnVlVWozSUJxUm5XZVNtM05oY1RQ?=
 =?utf-8?B?QzJaOTlWTTRtVE93Q3kwRU51WGs1VDNUbk9lSHFCUHRMRnl6WHhwRFordzlm?=
 =?utf-8?B?RkFiYkRYZU1ESmZQSHo3S2xoaFEyU3Y3Q3ZXK1pSVGlVSEtybU53MTBjSjJt?=
 =?utf-8?B?VTBPRUcvZXhycjhabXRIZm8vQlNpenpWQ1NRV1RoK0FVd3pwWW5qcUFCUXJP?=
 =?utf-8?B?U3BRVUg4TElXWTBHaVNvUnU4d3NYWnc0TXVsQWxqQ3JXdEtUR0kxdTAzMnZt?=
 =?utf-8?B?SWRGckgwYVhDQkdtNHBGNDhoR05BYUdIcWRSb2RDV3BYUXV1cUxiU1lLbnFi?=
 =?utf-8?B?andCSE55TzJ1OWNhZ2RsRGE1cWtLdyt3Y0ZwUngyZHVqbzVZY0RBWE53RTRY?=
 =?utf-8?B?RWVVcUhZS3R6cWdoenBUQjVFUDdPenI2amw3aG4zRDkrMUpleWRaSnhUMHh2?=
 =?utf-8?B?RmZuT05RMG9NNVVhRXZ0T2ZPQTZMV0VSZ2liS1UzbmVjeFBwWFcwNWNmU2I1?=
 =?utf-8?B?VUljT2drZU10MTNSb1JRUmNGUDJ2K0tncktWbVNOY3JFcUl2NytGYXRXSEpw?=
 =?utf-8?B?SjJ5eVNhdllIM09BckhxYTVnMDh6VWwydWRTaXZVN1lTQUZ2S3pGZVdSaWhr?=
 =?utf-8?B?d3lLcUZxK3FlSFpxSlg2NjdQYjZPMGllcmxmYUxwek40OWU0c1hWdFY2cnBv?=
 =?utf-8?B?VTI0bUtFVFVaSDkwVTA1TUg0OElwUC82M0FxZmZESGFqMVpMRm02U1M0ZTEx?=
 =?utf-8?B?MmVvZ0cxK2lneW9JRmJuVmxvTFIzc3cyK2xNSW4vUW1iN3lsd3ZyL3BnckZq?=
 =?utf-8?B?U0hRRjBPZURIZWdQN3o2OWRuZ2YzT0dQd0o4c0dEWW1ZUk9rS3hXZ2JRS2ty?=
 =?utf-8?B?NXJWS2xlaTQrME8zWlpFbmRZTURjOS9uTmpEbVEvMFRhdDJZVHZlQkh1WG50?=
 =?utf-8?B?SDgyL1JXMGVQM1dPeWxsVmxwOUkveXJXMFh1QmluRjJSNExyUllmbnpTSUVD?=
 =?utf-8?B?b3RyL3o1N21GRG9EMnpud0JLcFhNREphaW8zNjNoT3VSdFJqdlpwVytreGZT?=
 =?utf-8?B?Yks2S28zS0VoYktUUmp5dzM3Z1ByeDBIRktSRnR1UHJNM1RCRUlBb2pyVGRx?=
 =?utf-8?Q?LL5bmiOxqdiVqMh10KUQCpMZo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c68b50-2b68-4b30-2fce-08dd85fb3a97
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 02:20:22.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ie7PZhUi6UxM0klMtqU3gcAmg8IBp9i+YZc5qQfw46zkmkbQpq7/4CgmnigJ5OKTTdMVEIst5UYrXnZyoBdLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6607


在 2025/4/27 19:46, Johannes Weiner 写道:
> On Fri, Apr 25, 2025 at 11:19:23AM +0800, Huan Yang wrote:
>> When cgroup_init() creates root_mem_cgroup through css_alloc callback,
>> some critical resources might not be fully initialized, forcing later
>> operations to perform conditional checks for resource availability.
>>
>> This patch move mem_cgroup_init() to address the init order, it invoke
>> before cgroup_init, so, compare to subsys_initcall, it can use to prepare
>> some key resources before root_mem_cgroup alloc.
>>
>> Signed-off-by: Huan Yang <link@vivo.com>
>> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
thx.

