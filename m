Return-Path: <cgroups+bounces-3508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3CF924DBF
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 04:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AFA282908
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 02:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8F1FAA;
	Wed,  3 Jul 2024 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bgIA8hh1"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22628804;
	Wed,  3 Jul 2024 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973431; cv=fail; b=pXIfJ6ZzKhcoQWrAl229gWXqzVCv05ebbZwSfaZWi41neJ1/EOrZAmP8vLoYG1yxjzaLc8B7SseA7IH8Anvi3/Ci7GjjSmFLSlFsbg1t12hc0URfR+f8+UIyCiGtJf5thJ9GZOVY+/m3e2xY9m3lnU3eqBmOkRECquZQn77eC+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973431; c=relaxed/simple;
	bh=yjJHuzcRqutjH5eJt3yzJQ08eK/5dJme6XKZtsbU1WI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oqxoz7O1rnzrL6eMgi3e7BvXU61Mq+meZpQeTCc6f00ksUpUf4aK8fNy0216hW7gY4/QrZ//Xh3VM6VVQmicY7SvSGkfUZVG9FnR8BxL82NwgFcCTHfvubVJilMUG0gfYZDxdrIQgV4Zj648lLWJS2bUcAItVgGtOV08Z9mh1ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bgIA8hh1; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq2L0n0i8fi/AeDNOe3sXrsMQIFhQymuLMhQNVmP1fEz8C5kDusI0LdH3vBj/8y7yhBn4mey7M2tKsV3GF1oxufgGdE3D3sBEPvnUInHAEeGavot6EqnNjzCJriU9V4aC5YMa4Pb9Hqg9MYcMoN50M/Bmzc+To/HI15HFscSCpWgw4x+5SU3idU3gVYSXc5MeAS3wqz7g3rGZZYmdhutvwmhHWd/8pDILSl7ksGfIm8gkkKJpW9sSDJzfhU7JPKPdZh88dcsPMFSFa2ugEBcRsOcwlzfSRVXQTH3JS/LvD2Z61Hz5IZ3CrW+uUKQcatU0yc2KmJy3FLRK/5mpiAryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDCozQ2jcPx1EOd4Fi3ITK9I0GOCoMvlVQRfA7q3B+c=;
 b=jxsjTje7aYF/D58fCktVhyrXO3KmNHIaN+VH7dznmNbNaELS3bz4FemCsb7JZ286FUVlzkiMqmVSD6+nBtYfogxS3X3PFPSr6u3mCf5cgJySXaxc578JXGKflyBu0EQU2qGsTyFBnQmKLK5Z7Ln0l0qc5IeKm0vi88j3toBY3Z2whl2WCeC9s2oAXlQSGbLibfHALV0MjpnBcvICUFIaO3mhKhD56DwRMTjT+zDABHGhf+zh9T/xqKZd6FDn4vh0xC8XupCiHsjxes05nsOBbnUWuw1usy3ztEH8Zf8qXRbozRav38qGHs3gp+BdiRxsz3IGB5l8xwpvZWNttPHz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDCozQ2jcPx1EOd4Fi3ITK9I0GOCoMvlVQRfA7q3B+c=;
 b=bgIA8hh1SCF1DZcGfAHBx1kWNFNRsVJy9umkjJop1EWqUrrDR7dSsMaLMH1ZXTydihgFLKEXsunTr15M8Nsr8XtMDNdUv15qmXUQsohZVSiyhXcH0FQiDfg366+mhq6CyFdJZ/fb5xt/3D+0KHachjZPO9VNHHTlN80zAAiLLUfAbzs1cTmTU6ZQ40ulPbJx2b8W8V6ayU7kQ9bOnnbhIqs+e6tDzjWNLo4KyFCkLJMVr9s2ZmDcSLIZd33LDM29iNuEx8Kp/9a5HoKk875sWb2AnRZqra6t+ZItwZAp5EHGg7ts66efsq6QXbc1N7Y0emNbj+IewZDb4NerPf+aKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB7151.apcprd06.prod.outlook.com (2603:1096:990:8e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 02:23:42 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 02:23:41 +0000
Message-ID: <27a62e44-9d85-4ef2-b833-e977af039758@vivo.com>
Date: Wed, 3 Jul 2024 10:23:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Introduce PMC(PER-MEMCG-CACHE)
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Chris Li <chrisl@kernel.org>, Dan Schatzberg <schatzberg.dan@gmail.com>,
 Kairui Song <kasong@tencent.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, opensource.kernel@vivo.com
References: <20240702084423.1717904-1-link@vivo.com>
 <ZoRUukQUNqGHn_x1@google.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZoRUukQUNqGHn_x1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1952bfc1-334c-449b-b286-08dc9b072780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmt5VTlhMnJGMzZQT2tVU2xzR3lScUZaeHJIdG1tQVFWWnBsd25sNWNzUmoy?=
 =?utf-8?B?MXpMTWpmUW1zRWpKNE9uQ2pKc2N5T3hjMTlmMWlodVYwdjZoS1hYcnkwandR?=
 =?utf-8?B?N3FzYnQwOFNDdzMzSjVZY0xzeVNJQXhZQWdQcXo3dDM4S291MWpEUlVnREw1?=
 =?utf-8?B?MTJWSFhIT2FqcUVKd09zVHh1ODlHbWtwOEhBQ09BQ0M2Q2RvbjZSZ29VdnBF?=
 =?utf-8?B?RS9uNGdUNXlnUnlMU1luR0UxcGU3UW5BVnlFVGxxNjQ1a0RIVEc2TFJtam42?=
 =?utf-8?B?TUE3UkwwenJUcHBKNXVOMnoyaFM3ZFFxNHRCcDJUZVJ0bGhmdGIxSHF2UXNR?=
 =?utf-8?B?VmZteHFTUUgzQXdMa1VBWWx3bFUyM1o2WkNJKzlDLzBnTm0ybERJbVI0RTRh?=
 =?utf-8?B?QnREbkZIVGlEczJHbktBUTF3Nng1NDB4alJSTFFwQk5tQmh3eXlvRjZJNXU5?=
 =?utf-8?B?cWwxaG9sQmw2MVhoT000QmRIUFlwQTg3WVEvVWJ3c05BNm54UlByTzZNek4y?=
 =?utf-8?B?Nzk3Qkh5UE9YNW4rejBIeFhGZDB2ZWFaQmpwSmcrK1BCeGYrMm82R2JOZkF6?=
 =?utf-8?B?OVgzNk84UzV4MEdRWlptcHpKVnU3L2pzbm03S0V6WU04bXNGeEEySDlUSDRa?=
 =?utf-8?B?a3MvQ3hYQmZPZ2RTR1RPUGttNENKVEtWUFRhSW9tQWpEVkZIT0xQQUlIdllZ?=
 =?utf-8?B?MzFNWmgrcExEWk5lTVZ6RmkvSjR3cG9VWkgvUEJra1psY0t4RUpqWHVKdmR2?=
 =?utf-8?B?UVVIdHFVZTlBT2ZYUWl2NzZQZTdiY2FXZlYrL25Gd3dtRFBtaFpaMXNJK3J6?=
 =?utf-8?B?UlJWNTBmUVNBemxHd1owK2dIaTJoVlNyOSs0Q2M4QllxREdVTG9EVkNEUWpp?=
 =?utf-8?B?RDlZY1ZaajY4UVdZbjErMndBeVpXbXdxUERseStzbEVqbXN4M2tGMWVLRUhI?=
 =?utf-8?B?azdZcWRNZWI1ajNmaEVqMHY0bzI1Q0YrZUVmNzd0eE4xaHVHeDFnMUloYjB2?=
 =?utf-8?B?N3JWeFpCcjdudmh0UlZ4Qzd4U3EwUjM3QmlUY3k3U3dKUGowV2ZIL2J2K2RR?=
 =?utf-8?B?TUg1TVZJR2FKRFBGUFIzRU5tb2NOcldoZ2I5L1huUzVtNmIwb0psSFBmdk9J?=
 =?utf-8?B?RmRRM3NITjExZk1GbjNDNXBRTHZXTmpLOThRNjd3NXRYZGtCd2lVL2txbW5T?=
 =?utf-8?B?bHBONmtYTVI0Vm5zRXU1dEYxSWxTb1p0eE8zUTkyNElHMWhjNjFRdE9ISXds?=
 =?utf-8?B?VEdwdkZ1SzRoSHZySy9GcDFPVlZ2N3hwNVlERW1WcDlZU2tCOFdKdVVaV1hK?=
 =?utf-8?B?TnU2cE44MzdGdXZEeXk5cTBNNjBuVzY0bUpDZXB5ak5GYXdSVHQ1NTFGR3gr?=
 =?utf-8?B?OVkrSXVlQmpQVDZNVkQyR1hUVXZQNE1BSGk0ZmJNOVpBTTNHZWI5ZStqV3pI?=
 =?utf-8?B?eDVCNDVtQUZOb3F1RVdPT3c4VWgvdU15cGRZWmZsS3Y3SFFzNlhpQi9xRjlG?=
 =?utf-8?B?VWh2TWtvczlJRUMvZGtIODhBOUN4R0FYaEdWdXJkejd4SGFXU1RtQldleTBI?=
 =?utf-8?B?eGpsTWFHMWR0akZmdzFrZ01xU1RSNHpkSk9IcjN4UjQvWDBMWjFRSDRCcmFx?=
 =?utf-8?B?YnE5R0pmZzJYS2Q5R01QN2FTK2pOdkpKT3N1UWhpWExtNTJXeEJhSkNMeUdI?=
 =?utf-8?B?WTZPTTBJUllqMzZ1Tk8wclVKaS8wcWJCdTUxK0V6S3lWYmYyUXRCbHZkNGJk?=
 =?utf-8?B?aDlndk1RZnZPUDhHTzBvak1RZkJ6cmNHRGZTWExQZGJteXRDckhHK25PU1Fx?=
 =?utf-8?B?WFliVUFTbUNyVVNjRkoySkVUOVMrVHRBNVVVT01KaEhRdVI0QWU0cTN3Ty9E?=
 =?utf-8?B?MEYwSzN5LzlVYmNVZFVxVHV4OTg1MWg0eUVFRks4Z1FEZ2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1U0SlhGOTMwUlh4NDd0eHVXNExIUzRCOGpzS3dUYUdBdEszVFg4cDZWOCti?=
 =?utf-8?B?YXorUFJJRWZYbHF6VEs1ODJHRTdydm1TRlA2a3M4V3lEamNzZ3hXRHBXV0NC?=
 =?utf-8?B?Vk1ESTZ3ZTIvSGNOMkNpalMyWU16RzZTbWkvVXU0WCszb1NHcDVncG1mR2VM?=
 =?utf-8?B?N3FOckVFWDNBdE1JdjdkV05JMEpLRFAvYWZHYXlHQXdqNVpucW5mYkN0K1lw?=
 =?utf-8?B?K0luR3psTFhOZG4zTi9KamVnS1ovcFRxeDR4U0ZsUGRjU1pZSGJMSG1WVWZr?=
 =?utf-8?B?TEtQQnpVTE1NWUdVQ1hpcUVONWVOelZSMk5Zd1FzaHlGWlhpZzV0Qmlab3ZP?=
 =?utf-8?B?bGxTdVg0QjNhMHUwekJSU3N4Mm1Wa2tZN1dROFFIQUluWHpRSzR2VFJMR3F6?=
 =?utf-8?B?WXN3eGVNNnJJNVYwWm1iMWU0NlExN3Q2SVJmanRBYlpKNGFraE81c1FPelBR?=
 =?utf-8?B?SVVlWGswbksxMU9mTzhseEFlSDNYeVV1YUVuV3RqVWc2UkdETUc4UnhSbVd4?=
 =?utf-8?B?QXFQSURMMGt0QmNMWDF0UGdvVXczS2F0WEpDbk9mY1A3NVF1Rk1kdzkvRFZT?=
 =?utf-8?B?ZTRVeDRab05TUGNwUUs1U3NQZlRncVdkQWx6YW9jUU9qTHlJWFhkNEk1Q0FG?=
 =?utf-8?B?b1BXMzAzUEkzMFYydjZMU3pacURhajhEZE04QkVkOTZhTU1Kb2RvUStqUXVV?=
 =?utf-8?B?UGFJMUhmL1JVV2ZaemFUempVZVBmcXg0YUhQKytXUWZhRFZQdGFyUmk3Mko1?=
 =?utf-8?B?Sm1BQmVYTTVRWUZKQXpvREpOZTBvSUFUaEg1eXdVRmE3a0hjdEw1ZFh1MGJ2?=
 =?utf-8?B?UDc5dld2U1laemFVbzNta242cU5HdU52L0hwMkRKdlRRcUVVWWcrSDVldWpC?=
 =?utf-8?B?WnM5RjIzc2IwUHdoaUt1R01TQXduZ0JrbStFc1I4UWZ4U3pCVnpxZmk5RmNL?=
 =?utf-8?B?aU8rV094RWtVNm8rSzltMitNSWZrRVd2RC9xRnZONGdKSHR1MmtIUms4RTZK?=
 =?utf-8?B?ZUE4RXdMWks4YlpDd09SckRuN0doY24wb1Z3V1YzL0ZWRjhkOWhzYWR1QnJq?=
 =?utf-8?B?SVk1Z3ptOUlRTTJ1czRvZVRwRGZrOXVJcDd6L29jd3R1eHExVms0VWVvck1Q?=
 =?utf-8?B?eGkyY0xBcjBWdGhIbzBmV0h6THhxaVlDQXRyZUlGS04rSXhZNldqM24xR3pw?=
 =?utf-8?B?eHRjUTVhYWVXZmcvbW0ybkxtTEQzWEcvRE1Nc2lvK2pSanN0dHlUcDZVRVBS?=
 =?utf-8?B?NWQwQzhyTGttYXVNK0hNb1M3N2toQzIzL3hOUUZKWWxCc1JteEd1clhXV29L?=
 =?utf-8?B?M0gxRFRvcXVzaERwUzZoWjRXMzg4S3Byc1lFVng3UiswNVBJdVc1SWdjRGZ2?=
 =?utf-8?B?WmIvK05DdzYzOHhUK1lvY0d2TzBtamFEaVRYVW92a1BScXUzZHc4WDAzOWRx?=
 =?utf-8?B?Qi9kZlBBYnB6cHZ6UFBoeFlKVEE2QkFIK01uZXo5V2R5ZzFpRzQ1UEgySmFx?=
 =?utf-8?B?emNKeGw1RkpWQ1FleHdmZWs1czFVMGcvSStvVzZHU2FHRU1NbnBRUnhqQ2t2?=
 =?utf-8?B?UzNBWnphSTNzUUlqQzZCdjRnbmZKZW14TE1Qa2tBSHRBaTNubXBPZTlUTFF4?=
 =?utf-8?B?cFV5LzRndkZqSG5KTTJsWEhSMmlwZ3U0WUlDQXVXeUtNNkZ4SENDRjBUK3pB?=
 =?utf-8?B?b1JmTUIrUGtBRzlTcm9CK3dydDIra0hmTmJsR29XNnoybE5Ham5TVUI3TEtq?=
 =?utf-8?B?RWRiTGFyaTl1TW9Bd1dZcDFkWDlNWlFqODdHdzBiSDZHZGpMcVI1U1g4M1Ay?=
 =?utf-8?B?RUpXQmFBQmR3NFdKWFdmeU1wRzJTR21NSTVzalhjUjlRUTRHV211ZGFrdjFy?=
 =?utf-8?B?M3R3N241Y3VkZE9tcDkrT2RjTVB0OWtyUmhldkgrME9UTS90SFdCTGpZbXIz?=
 =?utf-8?B?a0p0UDdlUXhBVFJoWlNlcTR1czg4VEpGV091WVZTM2hGa2hOeEhEZUoxQmdC?=
 =?utf-8?B?RUhFcWkwcUVjRVV4UWhaVVJOcHRNU1RMLy9JcDRrb2w3cDROY3QzNWVublBu?=
 =?utf-8?B?WVJqc3VIbmFZeWMrSVRBQU84cXR1ODg2ZzBiQ09sdmJuZ0VOcWpJYXUrd3RU?=
 =?utf-8?Q?XFshXp9khDVArlNqBGWOAcNgx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1952bfc1-334c-449b-b286-08dc9b072780
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 02:23:41.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m25IRAJfDREyGR7vQBVOi5Cpy6+fALCSTCNACurBZXxGxHUblsZr4HubHS3B2PguxynwXXbyWSm0+hdFVPBKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7151


在 2024/7/3 3:27, Roman Gushchin 写道:
> On Tue, Jul 02, 2024 at 04:44:03PM +0800, Huan Yang wrote:
>> This patchset like to talk abount a idea about PMC(PER-MEMCG-CACHE).
>>
>> Background
>> ===
>>
>> Modern computer systems always have performance gaps between hardware,
>> such as the performance differences between CPU, memory, and disk.
>> Due to the principle of locality of reference in data access:
>>
>>    Programs often access data that has been accessed before
>>    Programs access the next set of data after accessing a particular data
>> As a result:
>>    1. CPU cache is used to speed up the access of already accessed data
>>       in memory
>>    2. Disk prefetching techniques are used to prepare the next set of data
>>       to be accessed in advance (to avoid direct disk access)
>> The basic utilization of locality greatly enhances computer performance.
>>
>> PMC (per-MEMCG-cache) is similar, utilizing a principle of locality to enhance
>> program performance.
>>
>> In modern computers, especially in smartphones, services are provided to
>> users on a per-application basis (such as Camera, Chat, etc.),
>> where an application is composed of multiple processes working together to
>> provide services.
>>
>> The basic unit for managing resources in a computer is the process,
>> which in turn uses threads to share memory and accomplish tasks.
>> Memory is shared among threads within a process.
>>
>> However, modern computers have the following issues, with a locality deficiency:
>>
>>    1. Different forms of memory exist and are not interconnected (anonymous
>>       pages, file pages, special memory such as DMA-BUF, various memory alloc in
>>       kernel mode, etc.)
>>    2. Memory isolation exists between processes, and apart from specific
>>       shared memory, they do not communicate with each other.
>>    3. During the transition of functionality within an application, a process
>>       usually releases memory, while another process requests memory, and in
>>       this process, memory has to be obtained from the lowest level through
>>       competition.
>>
>> For example abount camera application:
>>
>> Camera applications typically provide photo capture services as well as photo
>> preview services.
>> The photo capture process usually utilizes DMA-BUF to facilitate the sharing
>> of image data between the CPU and DMA devices.
>> When it comes to image preview, multiple algorithm processes are typically
>> involved in processing the image data, which may also involve heap memory
>> and other resources.
>>
>> During the switch between photo capture and preview, the application typically
>> needs to release DMA-BUF memory and then the algorithms need to allocate
>> heap memory. The flow of system memory during this process is managed by
>> the PCP-BUDDY system.
>>
>> However, the PCP and BUDDY systems are shared, and subsequently requested
>> memory may not be available due to previously allocated memory being used
>> (such as for file reading), requiring a competitive (memory reclamation)
>> process to obtain it.
>>
>> So, if it is possible to allow the released memory to be allocated with
>> high priority within the application, then this can meet the locality
>> requirement, improve performance, and avoid unnecessary memory reclaim.
>>
>> PMC solutions are similar to PCP, as they both establish cache pools according
>> to certain rules.
>>
>> Why base on MEMCG?
>> ===
>>
>> The MEMCG container can allocate selected processes to a MEMCG based on certain
>> grouping strategies (typical examples include grouping by app or UID).
>> Processes within the same MEMCG can then be used for statistics, upper limit
>> restrictions, and reclamation control.
>>
>> All processes within a MEMCG are considered as a single memory unit,
>> sharing memory among themselves. As a result, when one process releases
>> memory, another process within the same group can obtain it with the
>> highest priority, fully utilizing the locality of memory allocation
>> characteristics within the MEMCG (such as APP grouping).
>>
>> In addition, MEMCG provides feature interfaces that can be dynamically toggled
>> and are fully controllable by the policy.This provides greater flexibility
>> and does not impact performance when not enabled (controlled through static key).
>>
>>
>> Abount PMC implement
>> ===
>> Here, a cache switch is provided for each MEMCG(not on root).
>> When the user enables the cache, processes within the MEMCG will share memory
>> through this cache.
>>
>> The cache pool is positioned before the PCP. All order0 page released by
>> processes in MEMCG will be released to the cache pool first, and when memory
>> is requested, it will also be prioritized to be obtained from the cache pool.
>>
>> `memory.cache` is the sole entry point for controlling PMC, here are some
>> nested keys to control PMC:
>>    1. "enable=[y|n]" to enable or disable targeted MEMCG's cache
>>    2. "keys=nid=%d,watermark=%u,reaper_time=%u,limit=%u" to control already
>>    enabled PMC's behavior.
>>      a) `nid` to targeted a node to change it's key. or else all node.
>>      b) The `watermark` is used to control cache behavior, caching only when
>>         zone free pages above the zone's high water mark + this watermark is
>>         exceeded during memory release. (unit byte, default 50MB,
>>         min 10MB per-node-all-zone)
>>      c) `reaper_time` to control reaper gap, if meet, reaper all cache in this
>>          MEMCG(unit us, default 5s, 0 is disable.)
>>      d) `limit` is to limit the maximum memory used by the cache pool(unit bytes,
>>         default 100MB, max 500MB per-node-all-zone)
>>
>> Performance
>> ===
>> PMC is based on MEMCG and requires performance measurement through the
>> sharing of complex workloads between application processes.
>> Therefore, at the moment, we unable to provide a better testing solution
>> for this patchset.
>>
>> Here is the internal testing situation we provide, using the camera
>> application as an example. (1-NODE-1-ZONE-8GRAM)
>>
>> Test Case: Capture in rear portrait HDR mode
>> 1. Test mode: rear portrait HDR mode. This scene needs more than 800M ram
>>     which memory types including dmabuf(470M), PSS(150M) and APU(200M)
>> 2. Test steps: take a photo, then click thumbnail to view the full image
>>
>> The overall performance benefit from click shutter button to showing whole
>> image improves 500ms, and the total slowpath cost of all camera threads reduced
>> from 958ms to 495ms.
>> Especially for the shot2shot in this mode, the preview dealy of each frame have
>> a significant improve.
> Hello Huan,
>
> thank you for sharing your work.
thanks
>
> Some high-level thoughts:
> 1) Naming is hard, but it took me quite a while to realize that you're talking
Haha, sorry for my pool english
> about free memory. Cache is obviously an overloaded term, but per-memcg-cache
> can mean absolutely anything (pagecache? cpu cache? ...), so maybe it's not

Currently, my idea is that all memory released by processes under memcg 
will go into the `cache`,

and the original attributes will be ignored, and can be freely requested 
by processes under memcg.

(so, dma-buf\page cache\heap\driver, so on). Maybe named PMP more 
friendly? :)

> the best choice.
> 2) Overall an idea to have a per-memcg free memory pool makes sense to me,
> especially if we talk 2MB or 1GB pages (or order > 0 in general).
I like it too :)
> 3) You absolutely have to integrate the reclaim mechanism with a generic
> memory reclaim mechanism, which is driven by the memory pressure.
Yes, I all think about it.
> 4) You claim a ~50% performance win in your workload, which is a lot. It's not
> clear to me where it's coming from. It's hard to believe the page allocation/release
> paths are taking 50% of the cpu time. Please, clarify.

Let me describe it more specifically. In our test scenario, we have 8GB 
of RAM, and our camera application

has a complex set of algorithms, with a peak memory requirement of up to 
3GB.

Therefore, in a multi-application background scenario, starting the 
camera and taking photos will create a

very high memory pressure. In this scenario, any released memory will be 
quickly used by other processes (such as file pages).

So, during the process of switching from camera capture to preview, 
DMA-BUF memory will be released,

while the memory used for the preview algorithm will be simultaneously 
requested.

We need to take a lot of slow path routes to obtain enough memory for 
the preview algorithm, and it seems that the

just released DMA-BUF memory does not provide much help.

But using PMC (let's call it that for now), we are able to quickly meet 
the memory needs of the subsequent preview process

with the just released DMA-BUF memory, without having to go through the 
slow path, resulting in a significant performance improvement.

(of course, break migrate type may not good.)

>
> There are a lot of other questions, and you highlighted some of them below
> (and these are indeed right questions to ask), but let's start with something.
>
> Thanks
Thanks

