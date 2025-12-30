Return-Path: <cgroups+bounces-12824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A42ACEA881
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 20:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 814C13005309
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 19:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAC2DAFB9;
	Tue, 30 Dec 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vdM6MLkC"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34580AD5A;
	Tue, 30 Dec 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767122389; cv=fail; b=HpCsCWZfkbF29/99Ulj/JQ3eRPw2ifmp+XpnTaLvVonfTg46RI6zq0fKQjofnfQBm7c6v+F/wYxC4WAzLw0umrlx0V2f9NVzaoCCBh1L7VFMPSvRfbh1Cu0u7SAmSoCGFnEIm5fHJwmgbsad1cLovrRoredWymG4LWpBnqsz9mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767122389; c=relaxed/simple;
	bh=TK8iosyqhzR6UJXJXHjnSBu62Ym4e6N+bUBPv1J1FB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iVrkwejhs253yHqidaQxCP3KM4gJHb+xZJa2mmzSPSVPNFGHqDifnAoTf172Nz9GlG0A9oISyxrw2Gr41mIRj55HCMXyGnre3sUDA8Izji3MC/Jk4Es7WU+DzEEIdDSfHqM9TPX8AurdjLlTHSajh3gv79QfCOBsoTVsE9GiOnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vdM6MLkC; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU9rjGi4031830;
	Tue, 30 Dec 2025 11:19:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=5OaDhmM4lYdRy131aLewFqgvPDaCO73tNcLBdeNPuZs=; b=vdM6MLkCQzSM
	sg76iUHG8qqQpcyUvekPXxRq9K1N1COs1ggzBLNuUCLf2THxoQBJjDD2xO+wOZHa
	Wn9sfYchkgHdw6DRbjZou8mZBCBvnBjl56Ho6vxBo3EBC/JNST9vd7R0PenOheRf
	lxWoO7JvfJi5Qv9hKrzNosjCLe3bm5lxY8HwXim1/RIw/biwqkQKIYaRBvvFlthk
	02GiP5fvA6gbN2h3WTkVrKRiM3xsWwEh4VXKxxYZrO8kVPv7P2HSdLyDiRmmETwf
	JP1uMXv6LPyVf+Hj7P+ldDhmWRBzahaytIpnp/DCg04P8T5/Ige6eqTnfzQLhwEg
	lOouqshwEQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bccgsbmbh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 11:19:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbdTQH+XDYHEM3z52M8zPH6+hgAHzBLI867oyXZZnDUWWU+Rhw46abhW889N1Sh5flwZnij9oUTLOcA2W11Uhb40hlvuKBak3JbFeeT3IZ1A+Dvg4GrbX7ursE6NJocikb1nF09PxCZId9xuhzYjc27HCi5xymLt1NMvQ9lqFgeTsh5Z+xSpX9kTi4idSxwb16qTAAGIWqTNLRti74C6SoDbCQYmUTnsuxIPXkmjrva4fOXBqmrcxIi2T10ahP0kXlNWqoGAm/WT4PVTI0tFr9PThhLHYjzMrf+Gf9rQRUqSEZQKHfmOy/2U9WVBhW34IdID6kEp6mF6kJB/HtuMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OaDhmM4lYdRy131aLewFqgvPDaCO73tNcLBdeNPuZs=;
 b=f/CbRmbUGAOklU9fHTA1IqOgHRl44tr9RDHdcA3pBfsQoJ/1lDuwPrz5+cFpgaDBxZIZgKXgEnOi8FrN0qjdDsiXB1vAU4XIdE/2+01BpYxzmNzkI/1j/wFlSjmGnXJ0bBw5S+Z54UUz3j2Sdimq370VjiwXzBtcrzY4RJHIlrYyKanZet0fjf9LIVNo3jQJaPvARnDyMLEQdQlQKfnGnVfMgFPLzWZz3l9E5N0kNlDhs1pp3R1iNBSO7HrW2R9sG3ShVNmsIzKfCoyA0uXwEX69zcV8EqNgVU8wosVvFSREirStWucXWi5spb27dh+WjD04XAx/XWV73LFoG73E7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by CY8PR15MB5778.namprd15.prod.outlook.com (2603:10b6:930:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 19:19:07 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9456.008; Tue, 30 Dec 2025
 19:19:05 +0000
Message-ID: <59098b4f-c3bf-4b6c-80fb-604e6e1c755e@meta.com>
Date: Tue, 30 Dec 2025 14:18:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        harry.yoo@oracle.com, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Chris Mason <clm@fb.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev> <87tsx861o5.fsf@linux.dev>
 <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
 <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
 <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
 <slvvzxjhawqb5kkgfe2tll3owxjwtq2qkwd7m3lmpdslss73lo@hkewnkbik3qr>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <slvvzxjhawqb5kkgfe2tll3owxjwtq2qkwd7m3lmpdslss73lo@hkewnkbik3qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:610:75::7) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|CY8PR15MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: d729d0d1-fd9d-4cbc-b755-08de47d84c47
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU90OE9HdmFpQzdJM25ML1g0Mk5ZL2lOcnZxc3JjQktBbHFidVZ0d2t6Rno5?=
 =?utf-8?B?cVl2UjBwb2pxSVJpL2x6SlpHS0ZZcXRzWWtQMGhkTGxmQzFIcldualhJeERN?=
 =?utf-8?B?R25IM0RMbkFEcnJmeFhLK0xOTk1zdUZnL3VxN2NnWE5iRGFGaGxHU0JLKy8y?=
 =?utf-8?B?bDR6WGo2RGUrWU5RWkJkbjRhOVg4bnpVVythUzJGSEdWcGx4eTg4YmpESEVk?=
 =?utf-8?B?ODNDcWRmUU00TFZMZWhxam1NNnNNazJDZjVWcjU5RVJPT29UTGU5RzZMNmhr?=
 =?utf-8?B?Yzk1TGorQWVHR1MrU3QzUGt4TjN4aHk2ZVdwNWhFZ0JGSm9ySGpHL1dCTGNF?=
 =?utf-8?B?RDVicU5UTkJSbStxRTBORmZsOEdvMnRTZ2lvdmpKVjlyMDU2OEU0RWppelJY?=
 =?utf-8?B?a3R0TXlqZ1lzSndDZysvMDVJbXdjMVZNRFZQYnF3aEhGNGNPMWlFMCtvWFJq?=
 =?utf-8?B?dyt6Sk03K2ZGNTZBTVZRcGUwait3b0NJZ2pyRW1XdVlxbkMrQ29qcGtYTzR6?=
 =?utf-8?B?aG9SS0ZWdlQzMlVyTER5SlJPbTIzazM4b1BCWUk0eUZjTStKbjZxNDVONnJ6?=
 =?utf-8?B?SkFmaXRkVC9JYlF5anlPRFJpMUtJV2lyand6dGxINWsxdlNjVzUyMkx3cVZB?=
 =?utf-8?B?d2FjNWNkQUtaMVczRi9LdVZwWDI0bHJvWkNVaDkxRXIwRGIyTEc4NU5GODJI?=
 =?utf-8?B?a3NFRHFacU9QVXMrb0h5QkNpWnMyZk1mTEdCQVhHWWFOYndLbklXakhuWUxK?=
 =?utf-8?B?dnh3QXdUOUFRcEcvdHNpQlBJSW8rN2pjZGZ1ZGhlbWFjTWw2S0tueXJRMFBG?=
 =?utf-8?B?RFp0TmU2ZElVc3czRWdJS0VqdGlqNWxpVHBIbW1KelgwWElzN0xGWkJMOVR2?=
 =?utf-8?B?UFFWbC9uMVN3VzRzekVOVDNvZ0tkYmxjY1dsbWkyTzJwOWFKdDZpd0JuTnNm?=
 =?utf-8?B?SVk3M1dvaEhjSlRNUGptL0ExeTRNelBpLzZIeGdmT2ovMGVlMlNLUmN6NGZm?=
 =?utf-8?B?K0Q3bXRFdi91YlhjUncvRmJFVDZWZm1DMUtqc01QbStxaFZxK25yb0R1UHVw?=
 =?utf-8?B?RzFhVDVHRzNWTnEzSzFBZEMyb1FQQS9PMncrMTdIVnFjSW9PNUwzdHpJcEE3?=
 =?utf-8?B?SmJ6WFdPbmdXYVFRcnlhbmNsLzY0VVllay84cm5GT2ZTYyt1c01OdnhoZ1ZU?=
 =?utf-8?B?VnhKRnNlazQzV3NqZlNKbExyREU0WExXMVdsRGRDY20yNE1TQzZ5V1hPZG1k?=
 =?utf-8?B?b3ZCczJlWTNFUVo2UHJPSXViSlVmeCt1RHNDeEt6WFE2NDV2RFV0NnVHSEl3?=
 =?utf-8?B?cllwcjN5YTl4Yi9nVTdNaGo3SmJ6VWVnUEh3MFdHZWdTRjFuMlBZdXpYUlRt?=
 =?utf-8?B?bDNESjdLNkc2cWlNL0F0cks2aHJLTU9sc1RzM0E4M2VFc2RQMWFZZHk4TE5y?=
 =?utf-8?B?Z041MWUwdEt4NFJOTkZaQ2syWGF6VTdaWWpxd1NDdUFoQndxSUdUZ09KNE96?=
 =?utf-8?B?dHM3cW93bnB6K0FzOERpeE1NVDVJbGpmSVREUkR2aU1DbU9OV01YQlJNTEVN?=
 =?utf-8?B?MCs1WjRkclRzSWk3QkxiZVBmaktOMFBiTWxsY1BUUzBCNEZPRWtKcFF6ZTR4?=
 =?utf-8?B?bXRCV0dsUXhqT3VwVUZZdkQ2ZU1aeG95bWNqejhwNm1FUTlDRmhBZmwwTzB2?=
 =?utf-8?B?TjBCL3B2OHhkZm9iQ3h2bGRCVGx1YkQ5Sno2VnJTUWdWSmFsTEpocXJ6aEdl?=
 =?utf-8?B?NkNONVVzVWRTVmlmY1VLQjljcWpSYlpsUVZUNkl1dlFwQ1pMbFB0NjF1Mk5E?=
 =?utf-8?B?UzR3bytXdXVHckZxcU43ZHBuOGFNMlNVdWlDR0hVMnJwNFdPaWF5cTNTbWNP?=
 =?utf-8?B?TDI4dWI2UnY0YWgyVXVWK3prRUxIWkNWNVFrTFlOK28ycThCaTdzdUJSREwr?=
 =?utf-8?B?ZE44K3Q2eEJqbk1nTzVXSlFXV3pyWW5Cbnk3ZzdUQ2lMZ1RjV3ZZZ0l1L1JM?=
 =?utf-8?B?SXE1S0N3dGx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmdqUGRjYll5MEdBbzJ6VUpCVXhQbkE4cG5qVE0ybVlBQmZJT01pTS9zTUx1?=
 =?utf-8?B?MmUwaSt5bGxGaE9tQldSNVJFUjVSOFA3NFNOcWV1ZmhqODRTaThaYUx4NjYv?=
 =?utf-8?B?ZklBM0lHT2dWRE1SWFpMSEozNDVVUVVQUVVDeHlNSDdFakFEcFdQY2hhMTlF?=
 =?utf-8?B?TlRwOFFYMEtQbHZndmZJMHZNbFVQblFsY1pyQU1VK0k2QmF4c1AyVUE0Nkh5?=
 =?utf-8?B?eVBra2JUVEplQUZpRjdvbUZRK3VmT3hFWG1iWU5DVnNhVXVtcjllVGtJUjFm?=
 =?utf-8?B?blI5SWFuMlFZSzh4QjZGcjFXN1MxZHhNNmFiTTliVm1NY2F2WjJtaG1sZWl2?=
 =?utf-8?B?dnFja3lmQlluQzg5TGoxa3BNN1pGVkwwRVNpdkhndmp4ZkR1YWcxayt1ZWtY?=
 =?utf-8?B?WEZScjRDelhkWEZvbXRXM2pBSjBlcC9zUkNuMGhaVGp1WlNqSXhYMzZIdVlj?=
 =?utf-8?B?Tm9sbm55ZjlVQ2RjcndPLy9nRkNQa2NHbEtUTndpbndSWDFSdWV6M3Vyb3l5?=
 =?utf-8?B?eUp5eEE2bWdXbTJlRmJoZ0R4Tm5CdW1na2o4dGIveTlEKzhrbDB2bEFiZWIv?=
 =?utf-8?B?VTREcm9Nc0NOZlJWajh1TGs2NlczUnowMmxxMUpIMGp6YmlBejIyQWJ4ZHp3?=
 =?utf-8?B?Z3lrQ0Zrdjl1OWdRTFNIcGZOYzNpUmt5cjJXWFo0ZDI5OVM3T1RuVDJxSHB6?=
 =?utf-8?B?VnhROUNVY1o2R3FZRlpVZ3NxVkFUSnZTU210VkxzenB0N3Z0Y3Fmc0pYUkUx?=
 =?utf-8?B?a0w1WFBrL1c2Y1NaTXlaKy95TlU3eWNYd041NTk0a0VObzBQa2VnK0o3QytG?=
 =?utf-8?B?T25BYWUyRWNjQUVCd1FEZjZNNEZRVUMxRHAyRUdITWJpNitPN0phU21BS0oz?=
 =?utf-8?B?MmNDY1dXY3NDQ0ovaXUwMHgybENqYmZnL2hUY0g5cmxYQnp5dWoyWHVuYTln?=
 =?utf-8?B?TTVXZXlMKzY2N3h6SmJ1OVlVcWF3K3dUN2h6WElFdFpweXFCNkpqaklrZUZv?=
 =?utf-8?B?SW9LRmZsSWlqaHpzMFdlQU96SVNaaWUwcmZSZDFIRkoveC9Nb0dUWlkrdDQ5?=
 =?utf-8?B?ZlBxMGdJaGxST2U5ekwvTVlnb1NxOXFLTm8rejE1NFVtM0FUTGdHUWdBZ3NI?=
 =?utf-8?B?eXN4WFR6bFQ1YXAySTluTEF4QVFGckxLeXNoTy9KUDJwUGkvaFJrMWhxMmEv?=
 =?utf-8?B?cWpNdU5ja3JHV2pwWkpWbHZBSktHM1loRzhyd04vOFVBeHZLa1N2UzdRTVJL?=
 =?utf-8?B?TUtsUGQ4MEFZWVdLOWcwTGxNSDJTMnZOR0xpT3Jyc29mYUt3UCsvYnkyM1pw?=
 =?utf-8?B?OFBrTkc1VXp5VE9lOWFmU3VmdTVGcU1HRXFGZnJrNHU3ZGt0Skc3cS9lUE5t?=
 =?utf-8?B?bmN2TmF2LzZsdDRhYkh6eGlNZ1d2eGxhMUtUdmQyTlZFc1dtZUw5U3lnSkNw?=
 =?utf-8?B?QmQ1UE5HY3hZaERRZUtuWmRsMTM5d3pwcGxqMm52RE12cHNaMzB0c1ZRYm9k?=
 =?utf-8?B?YWdacElYNlprcStXNy9DRjRuTGRSdjNnUjJHNDVLNSszQnBHT3RkdmdDblV0?=
 =?utf-8?B?UUlsRUpLdG5ydjRCZkdjRzBEOTM0Zk1xWDluakc2UjM5bmVJUEUzQUxEKzcz?=
 =?utf-8?B?bE9ndGI3cytMb2t3OFJhdy9rTzFBREt2emhSWjRiWjQ0dFgxNEowMlE2Y0x5?=
 =?utf-8?B?ZEhLdUdZb0dhR09hOFgzbGM1bHlobHZQeERzV202bmRuSUg0ZGJURDYydDNy?=
 =?utf-8?B?MnVaMllXUDkwWHZrUHBWZmhJaGpwVHZXdnFNdHVLcmNsR28wRWR5MnBYNDRH?=
 =?utf-8?B?WVB1b3NpTm45Zy9NTXlmb1FaOEtnMDhRVVVsNUFTbzRhNTlZT2gwQ1lyc2RZ?=
 =?utf-8?B?MlNhQ1d3NEpQOEl6UjhVOVkwRjJHZzVISGg0N0VpZzBLWWMrQVd6Sk9kSmVW?=
 =?utf-8?B?YWpyMXlkVElMakd5Z1ljdEJqcXlicytBNDBrVGZldWNTaXlDaHRJY1QxZXR1?=
 =?utf-8?B?Z0tjcStsTlJGc2g4NnE1MGFHYndvY0ZuQTE4c3YzeFlzVzduZUJwYk5Sa0Mv?=
 =?utf-8?B?dlVJcHpJdCtxcDE3S1o0ZmlZNkpCa2ZNeFh0S2JvQmgwSVhhNmRROG5YN0tk?=
 =?utf-8?B?SVZKbEVyZnh6WUNucENGNE1FNkVUeWdaV2N2L0liVFZUV05uenBZWUNRUXJ4?=
 =?utf-8?B?TEQrd3RibkRWQ0J2K0FZSnJBVU0wWS9wQ3dJdTFhU3NJOW84cVZUV3JKSlhX?=
 =?utf-8?B?Q0d5dndxcFVhUXRPZUNrTmEzbHRobU44bVZYKzJsNXRacE0wdkJTVnNSNnQ0?=
 =?utf-8?Q?vBGEAzvA7BXZtSfYQ4?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d729d0d1-fd9d-4cbc-b755-08de47d84c47
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 19:19:05.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OM+5J2leU+8HgzZ5wUOk/1p8xW+PZlXd+ociqJx2sPMeJPhAjeZTLIV9kopaXqjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5778
X-Authority-Analysis: v=2.4 cv=HdQZjyE8 c=1 sm=1 tr=0 ts=695425af cx=c_pps
 a=x8GZ0b2gSoXatiKXRdBC2A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=e8O0uTMVAAAA:20
 a=EeGlbS3vmo5X-y0tmT4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bn7x_FpfJtc3yKQXRW3z:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: CzDC5mdM614Nr--YKKNfhI9AbE2bRfqh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE3MyBTYWx0ZWRfX6dDU52MksJpT
 sXKo2UNW/RQPv/Tfz7E44SvfyST6WG6h8tStozpdw9qe29mGBw9Iy9ozWIRIwqOzeX/5TM3jN/4
 Rp8gTYOoR2yKHRbLOL4GkNywwnS+P3rTwKkFz6GwctrS1e8OlDHXqolWhUOig9aKCu/c8YhxfIH
 v80mH5A+/7RjWe1L3hMq9lq3PkDJhfFpNBD68Jif8AxtJ8kgDRz2BU6QdimiCncJZe4M1IzudzF
 3JKH6Awac3OorbQkkNWQSCAuNZAgp+w2AQ+YCQdUtoos+Lv+5GSDKgXyTDTZKbHH+bN0bfuGusu
 akKPOP+fjHZycP4WBvHL3u+aeBULr5sTOAAcENLB0+I1fD/17sTL3sNAneHNt+ioYkJoiof6Z5v
 efvrObuJz1fO5slsCycSQESZDiCdgLql7vZzsIeaOx68y31O3Vq+RHrpcjz3rLSe51cfN3zjsxl
 iwmXuUsAnj4zSSIS5Tw==
X-Proofpoint-ORIG-GUID: CzDC5mdM614Nr--YKKNfhI9AbE2bRfqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_03,2025-12-30_01,2025-10-01_01

On 12/30/25 1:13 PM, Shakeel Butt wrote:
> On Tue, Dec 30, 2025 at 11:46:02AM -0500, Zi Yan wrote:
>> On 29 Dec 2025, at 23:48, Shakeel Butt wrote:
>>
>>> On Tue, Dec 30, 2025 at 12:25:31PM +0800, Qi Zheng wrote:
>>>>
>>>>
>>> [...]
>>>>>>
>>>>>> Thank you for running the AI review for this patchset, but please do not
>>>>>> directly send the raw data from the AI review to the community, as this
>>>>>> is no different from automated review by a robot.
>>>>>
>>>>> Hi Qi,
>>>>>
>>>>> I don't know why you're so negative towards it. It's been great at
>>>>
>>>> No, I don't object to having a dedicated robot to do this.
>>>>
>>>>> finding pretty tricky bugs often missed by human reviewers. In no way
>>>>> it's a replacement for human reviews, but if a robot can find real
>>>>> issues and make the kernel more reliable and safe, I'm in.
>>>>
>>>> I just think you should do a preliminary review of the AI ​​review results
>>>> instead of sending them out directly. Otherwise, if everyone does this,
>>>> the community will be full of bots.

I do think it's awkward to dump the whole review output for the patch
series in a single message.  It looks like there's a sudden jump to XML?
It's better to reply to the individual patches with the comments
inline, which I think is where Roman is trying to go long term.

With BPF, it looks more like this:
https://lore.kernel.org/bpf/?q=AI+reviewed+your+patch

>>>>
>>>> No?
>>>>
>>>
>>> We don't want too many bots but we definitely want at least one AI
>>> review bot. Now we have precedence of BPF and networking subsystem and
>>> the results I have seen are really good. I think the MM community needs
>>> to come together and decide on the formalities of AI review process and
>>> I see Roman is doing some early experimentation and result looks great.
>>
>> Do you mind explaining why the result looks great? Does it mean you agree
>> the regressions pointed out by the AI review?
> 
> The result looks great because the points raised are really thought
> provoking and things I have not thought about when I reviewed the
> series. The lru lock without irq or the possible infinite retry loop in
> get_mem_cgroup_from_folio() are two such examples. Are these real
> regressions? I am not sure.
> 
>>
>> If we want to do AI reviews, the process should be improved instead of
>> just pasting the output from AI. In the initial stage, I think some human
>> intervention is needed, at least adding some comment on AI reviews would
>> be helpful.
> 
> Yes I agree and therefore I mentioned we should discuss how should we
> (MM community) should adopt the AI reviews.

What tends to happen with BPF is the patch author or bpf maintainers
point out problems with the reviews and I fix up the prompts over time.
The false positive rate is ~20% today (measured since late October), and
it's generally declining.

> 
>> Otherwise, it looks like you agree completely with AI reviews.
>> In addition, “50% of the reported issues are real”, is the AI tossing
>> a coin when reporting issues?
>>
>> When I am looking into the prompt part, I have the following questions:
>>
>> 1. What is “Prompts SHA: 192922ae6bf4 ("bpf.md: adjust the documentation
>> about bpf kfunc parameter validation”)”? I got the actual prompts
>> from irc: https://github.com/masoncl/review-prompts/tree/main , but it
>> should be provided along with the review for others to reproduce.
> 
> I agree and I didn't know that Chris's review prompts are used here.
> 
> Ccing Chris for your following questions.
> 
>>>> 2. Looking at the mm prompt: https://github.com/masoncl/review-prompts/blob/main/mm.md , are you sure the patterns are all right?
>> 	a. Page/Folio States, Large folios require per-page state tracking for
>> 		Reference counts. I thought we want to get rid of per page refcount.

Early in prompt development I hand picked a few hundred patches from
6.16 fixing bugs, and I iterated on these adding subsystem knowledge to
catch the known bugs.  That's where that rule came from, but as you say
there's a risk this information gets old.  Do we want to get rid of per
page refcounts or have we done it?  (more on that at the bottom of the
email).

>>     b. Migration Invariants, NUMA balancing expects valid PTE combinations.
>> 		PROTNONE PTEs are hardware invalid to trigger fault.
>> 	c. TLB flushes required after PTE modifications. How about spurious fault
>> 		handling?
>>

AI generally uses them as a starting point and fills in details, but
I agree the MM bits are pretty minimal.

>> 3. For a cgroup patchset, I was expecting some cgroup specific prompt rules,
>> 	but could not find any. What am I missing?

I think the only cgroup specific information I've needed so far is
explaining css_get() and the section on __GFP_ACCOUNT.  I actively try
to avoid adding details unless we're missing bugs or generating false
positives.

As an example of how I'd fix the prompt if the per page state tracking
were causing problems (and if we didn't want to just remove it), I asked
claude to analyze how it is still used.  The output is below, I'd double
check things as best I could, shorten into prompt form and send to the
list for review.

Per-Page Tracking in Large Folios - Analysis
=============================================

Based on analysis of mm/*.c files and commit history, MM-004's claim is
still partially true - large folios do need per-page tracking for some
bits, though recent work has significantly reduced this.


Bits That Still Require Per-Page Tracking
------------------------------------------

1. PG_hwpoison (include/linux/page-flags.h:118)

   Defined as PAGEFLAG(HWPoison, hwpoison, PF_ANY), this flag is set on
   individual pages within a large folio when hardware memory corruption
   is detected.

   The folio_test_has_hwpoisoned() flag on the second page indicates at
   least one subpage is poisoned, but does not identify which one.

   When splitting a large folio, page_range_has_hwpoisoned() in
   mm/huge_memory.c:3467 iterates through pages checking PageHWPoison()
   for each:

       static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
       {
           for (; nr_pages; page++, nr_pages--)
               if (PageHWPoison(page))
                   return true;
           return false;
       }

   Used in rmap code (mm/rmap.c:1990, 2070, 2473) to check individual
   subpages when unmapping or migrating.

2. PG_anon_exclusive (include/linux/page-flags.h:146)

   Per the comment at include/linux/page-flags.h:139-145:

       "Depending on the way an anonymous folio can be mapped into a page
       table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
       THP), PG_anon_exclusive may be set only for the head page or for
       tail pages of an anonymous folio. For now, we only expect it to be
       set on tail pages for PTE-mapped THP."

   Used at mm/rmap.c:1408-1416: when RMAP_EXCLUSIVE flag is set for
   PTE-level mappings, it iterates through each page:

       for (i = 0; i < nr_pages; i++)
           SetPageAnonExclusive(page + i);

   HugeTLB stores this on head page only (see PageAnonExclusive() at
   include/linux/page-flags.h:1153-1162), but PTE-mapped THP needs
   per-page tracking.


Recent Changes - Per-Page Mapcount Removed
------------------------------------------

Commit 749492229e3bd ("mm: stop maintaining the per-page mapcount of
large folios") by David Hildenbrand (March 2025) introduced
CONFIG_NO_PAGE_MAPCOUNT which:

  - Stops maintaining per-page mapcounts in tail pages of large folios
  - Tail page mapcount is now always logically 0 (-1 value)
  - Removed _nr_pages_mapped tracking

This was a significant simplification, but it does not affect the
per-page flag tracking described above.


Flags Stored in Second Page Only (Not Per-Page)
-----------------------------------------------

These are stored in the first tail page (FOLIO_SECOND_PAGE) and apply to
the entire folio, not individual pages:

  - PG_has_hwpoisoned  - indicates some page in folio is poisoned
  - PG_large_rmappable - folio is rmappable
  - PG_partially_mapped - folio is partially mapped

See PAGE_FLAGS_SECOND definition at include/linux/page-flags.h:1218-1220.


Conclusion
----------

While per-page mapcount has been eliminated, PG_hwpoison and
PG_anon_exclusive (for PTE-mapped THP) still require per-page tracking
in large folios. MM-004's claim remains valid for these specific bits.

Key source files:
  - include/linux/page-flags.h (flag definitions and accessors)
  - mm/huge_memory.c (folio split handling)
  - mm/rmap.c (reverse mapping with per-page exclusive tracking)

