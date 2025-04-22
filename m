Return-Path: <cgroups+bounces-7737-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C495EA97A5A
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 00:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A143AF22C
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78691E2606;
	Tue, 22 Apr 2025 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f7h7Hhxk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QAv6moAq"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092D1EF094;
	Tue, 22 Apr 2025 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360476; cv=fail; b=H8WBS5yIL3sdIdcgvqiDb1w1+NquFZi0NhHXceq++BVT5bm+fT/aBIZezEULcaXqtZEERFs0oYJRDr5Ees9aQZwEHdXES+8TSIYjottXfhEuVYb1t2d4z1uqngSd7f8j1A9C63GXE1DAyu5Z0A++oTZ5vKbcHyqCzLV+/08vlUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360476; c=relaxed/simple;
	bh=+LN7rTBfC6pXPQNJA3fKIAIDcdXqxCaHKhr9QsogQbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rWLn4+q/Tm+T+/AC338VxF401ZXA1NGyF4KtcP6CY2S52r1k3miB0RT6wkCy9difEpUSvlpzPVsdKAO/471AOZ0CA8oMNg/8k+vbpk6ZsGfE0VlhysdAaHUlsPULKXtnCmBGg5jONDQviKASE0WKiq6q+N/wTDhcyQx0r4MxMA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f7h7Hhxk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QAv6moAq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MLMx9N004121;
	Tue, 22 Apr 2025 22:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A57ovBQteWLuCioao+8JiZBDK7eKgtCzyOlGcNEe3+M=; b=
	f7h7HhxkP8bm7JQlvkHHNFqt4qnEFiNwWkw7fmdSKnFPXYejDP/qBPcq6Xp/2iRX
	2Sl8lZBP8aH0IuDigA4BoqbV6uSjOP6Vtu3JqR46voiXz5TDldssJAPjaYhce3Di
	EaSBmJbXBcvUp259s4/1k/cSy+XBB4Jbn/V3kFUP866vBVkndC/D+NntSGto20ey
	ozIcLaAyGLWC7AAql0gwlMtvFZri0l8tkwY2UnZ0bDwNc6V05plXdg45QrfpS29x
	oRlCTFgHfKXHkoEih4LyX2T+/RuWUnYMv/aGShFd6cyolk30ZzAcZDR5ZYSBh3Nj
	IH+hS4vfc+kVeq7/cuY2BQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jkjg487-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 22:20:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MLKZ2B013940;
	Tue, 22 Apr 2025 22:20:46 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010006.outbound.protection.outlook.com [40.93.20.6])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxn1m6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 22:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2TjI9uMZCC9Ab2PK1H8GJdLA1jfizoSjNgzwXsWueI26qAQ2NaDwSyKaovTGXuWvFP+jdq4LkXxQ0FKyVpi+cdgyMQrwyz/P3hY+l9+qjCXX1HUg7ZJRQZD4GVLKgj8OUMCx/h+dWyAdN+ldSNUUHRcj8Axx+UheISnApP6qbj5LLI19vUcTOhrUkWf+bWE6A9evFir9rXs4da5vDcHABrTn0J0Bb3zcxYYFd16/v2cpWeaquRBPKMM158JU4AfPG2MqT7g5xZHfLL2V7nyNMdTaKYR2EQQFp2r/TgdEd8PD/nSziDs9g/+8q8Ddx5wQ1hnRRQVwkk/4vDjBjgzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A57ovBQteWLuCioao+8JiZBDK7eKgtCzyOlGcNEe3+M=;
 b=V5a2Adz9pRmfrewCVy4Uf2rWVgN5bm/1WsC4IZnJdxGjw53eorvFHZqC3ytaMUqqtDynjcm/e8qfX80K0mioHCAo86Ch29BiVvPqanYh8RCbdlBodYXwn/Ps1+ZeHUabvNM+fcjiddaZTSDOmKYPzpt0zwZlH5VkXTPAT84ckiJz4rHLggqD9hcHPiTMEEVnUUqthyX2lBpWOK9zItAE6I8iIg7+fiT8m7wcKmcVHfArZDlAqb/eLgLn/sWhElSChWgX6ZP74ipW3Ng0VFYvDdu45Xth/0LMITmGFsyxpctb6JGBhxT+rYuCvL+n1AnwinIrZdtuGOBEMwyPL3p3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A57ovBQteWLuCioao+8JiZBDK7eKgtCzyOlGcNEe3+M=;
 b=QAv6moAqFpVedJK9RsNeB7kohxIejZWUFEeitWGSdndIUCXrUpCmMz+ov17QIcK8+YdaQ7XGPUw+beof/Kw8nupsWIN7/022H5MlyfwC6hH2vayBuJuQid86nHk+ZfUxCHgFHRT+llin0Xivr8ssRK1hvplsgrd0kSO+wM8aWJc=
Received: from PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14)
 by PH0PR10MB6957.namprd10.prod.outlook.com (2603:10b6:510:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 22:20:43 +0000
Received: from PH7PR10MB5747.namprd10.prod.outlook.com
 ([fe80::7a1c:5516:7671:9024]) by PH7PR10MB5747.namprd10.prod.outlook.com
 ([fe80::7a1c:5516:7671:9024%5]) with mapi id 15.20.8655.030; Tue, 22 Apr 2025
 22:20:43 +0000
Message-ID: <2ce24cae-12fc-4a28-8396-c5b46a5f76d3@oracle.com>
Date: Tue, 22 Apr 2025 15:20:41 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v3 1/2] sched/numa: Skip VMA scanning on memory pinned to
 one NUMA node via cpuset.mems
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: kprateek.nayak@amd.com, raghavendra.kt@amd.com, tim.c.chen@intel.com,
        vineethr@linux.ibm.com, chris.hyser@oracle.com,
        daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com,
        mkoutny@suse.com, Dhaval.Giani@amd.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mgorman@suse.de,
        vincent.guittot@linaro.org, rostedt@goodmis.org, llong@redhat.com,
        akpm@linux-foundation.org, tj@kernel.org, juri.lelli@redhat.com,
        peterz@infradead.org, yu.chen.surf@foxmail.com
References: <20250417191543.1781862-1-libo.chen@oracle.com>
 <20250417191543.1781862-2-libo.chen@oracle.com>
 <244cb537-7d43-4795-9cb6-fc10234c68a1@intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <244cb537-7d43-4795-9cb6-fc10234c68a1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:510:5::22) To PH7PR10MB5747.namprd10.prod.outlook.com
 (2603:10b6:510:127::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB5747:EE_|PH0PR10MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 27640efd-b5bf-467b-3461-08dd81ebebee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tnl0d1ViLzhVYlFWNFdqeTEwb0pyWVJ2ZVZDM0l2d25UT3hGYzJjaHYyUHBO?=
 =?utf-8?B?VG0vOENtam9wWlBQdFVsb3VPS2tEVzhBR3FyZU03OUJkSTVabTNMbEFzMkRJ?=
 =?utf-8?B?R2REQmIyNENrUlc1SVdvVWFuUEh2U0NucGJXNWxiWFloSSs2V1dHdUtLTGRJ?=
 =?utf-8?B?bGRId2h0Um1Ia0RNNGtlTEhzWm9xdjgvSDY4eDZBb29MQkpuUUF0NjRZQ2lO?=
 =?utf-8?B?aUtBa0pDN2luenRpN0F3VjZEcDZHUEVqSXA3NWtUSlRoOTRCVnpXQTg3NU1L?=
 =?utf-8?B?RFMraWliRWpiNmFpME5scEJFd0JQa2hFeDk0WFRDcXZLbkgrMEw5MWZpV1ZD?=
 =?utf-8?B?NWxpZXo4STJhRGVNblFMWGFLUGpTcExidjVCNFJ0Rk1XOEM0WXlPYk5vVFpi?=
 =?utf-8?B?QnROVlU5a2tpcElpTlFaL1lRYzd5VTBDd09ZVE9IOVNoTklYRTFJczJHM2Rh?=
 =?utf-8?B?ZTBtQ0NwVnhHUzViczN1NVhZdURMclZZdms1Ti9wRGpuc3ZpU2tHclByQlEx?=
 =?utf-8?B?U0RYN3NseTV4ZTFHeXhLcDMwbWpxZDVSZTdKTFByZ29KTHFLdjNDNWpUcGJ1?=
 =?utf-8?B?NlpzUGtIbzd2N0Jrdy93S0dudUFWcGZGRnBWRklEQUNTQlFQN29EdkV5MEZP?=
 =?utf-8?B?anZWMVlRd000Zk1vcFBCLy92MWdGZ3hnSlQ0V0ZpREo1ZFFmSUx0TjR4NHFZ?=
 =?utf-8?B?bDZpZnl6bnIvdDJHa3JOT1UyUlM0bWJ4NTZzdnRMbk1PWGhBVkViejN0ay94?=
 =?utf-8?B?eDhzdUNuVlFNZUorY3dSNmtDd3VGVmY2N0s1SzFRdnp6U0NzRkNORnF3ODNC?=
 =?utf-8?B?YU92eWZSSHliK0tXZFBoZmNFL0xZdy9mNE1BSGl4eW96bjY2L1dBUTlSWFly?=
 =?utf-8?B?QUVGRGtCMVlGTCs4THZ6QmhSbCs4MTZMWHZLZGtNQXdPRTg4dU9WSm4rcWZy?=
 =?utf-8?B?WVY2TVdna2kzYk4vT2dMb1ZCcHFUWVJJc3NZMFBkeDNOcmMvbytDZ2VVaW1X?=
 =?utf-8?B?MEpXKzJKMnR6RmlHYm43NnplaW5lNUExdC83dUlsTUhRTGYzRWJnRE4wK1Ar?=
 =?utf-8?B?SkVoc2V5U0xON216ODRqQWdLSWx3TnY2UUsxd01CeFlVcHlCZlhxZjMxejVI?=
 =?utf-8?B?VitFT3VubGdKTlYxOXRCVHBkaGoyUnRZVE0rVGF2ejAwUFZnQjhUTjE0OHZs?=
 =?utf-8?B?bFA2TDJLenhXME4vN2JYVU1ZYlo4U2lqUVVsM3Rra2R2YzVKVWN5SXhhdytQ?=
 =?utf-8?B?dGd0SlNVZWNhaFFOSGl5c3NQMTZxVVp3N0NQRHdhSTRpd2ltVkVsVStiR1pK?=
 =?utf-8?B?MERxdnBiM3ZqbzJsdk5XeDBpZEZWUFdnczZYQ1RzWGtaR3hteW4xOGJ3V05R?=
 =?utf-8?B?N0hNV09tZ2E1UFJDK0xjVExvRU5rZmhEenNRY05aNnp3TnNDQ1FMREFOeU9y?=
 =?utf-8?B?S2dEYkF6NEg0aHlpaW9ENHBBRHl2bTdmWHpIVHBKMDcwUnFaUC9NMHJxNFVK?=
 =?utf-8?B?MXEyQjF0TFloRlBXZkJZTzJLQkR4b3hJblVuUHA4S20xaTAyLzN3aTZ4ZFpD?=
 =?utf-8?B?MXNON3hxS1J6djFRUldwZklWMVNEYUp0L1NDMXRvbzlIYXBhdU44RG1PbzdB?=
 =?utf-8?B?eHQ5QUlycWx5L09hRU1icGlmTEkyQy9RSjUxWUxJZk5aOVovVVFvR1NQQzMr?=
 =?utf-8?B?YlE5QWZDbG5yMnlpOE9LZGZ6UXo2UTliL2N6cFB6d3cya0REWFl4MVZLUlNs?=
 =?utf-8?B?U2IrTDdNSFM0ZDhqT284RXgrb2tHSktITkhwdkZ6bVlhaDErUmgyYVdUSGE2?=
 =?utf-8?B?RDQ5ODgwaVJ5SFR1dzZlQldKc2xQZTloczRFcGRrY05ORGlXS1BaL0NuQnI5?=
 =?utf-8?B?amNZL0ZjZVRaazFta1NRQmpYVDd5NGQ3WGdtSWU4aVlkaDFndFpwMm1qL1R3?=
 =?utf-8?Q?j0PsaqdhnVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB5747.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEFEdnNXUWdOaVVKcFNEOWo2T1lzdXBnT2tGMDhDOXpTS0xrR1dIdU9hd2Jq?=
 =?utf-8?B?amVSb0g5UUJzSWVwd2xNVlFoWFVyYnFySXJmTzA0aW03ejFadDRUc0Z0NUVC?=
 =?utf-8?B?ZmJhQ3AzT0VkN1NQWFdOamxmcFhBTmcxb3A4SHdYN0oraGtDaFdtNWcwL3JN?=
 =?utf-8?B?eXRoQ3ZuS0V2NlpFNS9aKzZmbGpaSlRqeEZjSFJzMGN2TXhZcHNUdHJ5allm?=
 =?utf-8?B?QjVOTmYybEVxNjQ4NnYrZVJmUW0rNjREbXlqdU80M0dvenovMHM2djZ6dURi?=
 =?utf-8?B?N0VPOVRLK0FYR2VGWUx6MjRWVDN2YWdGWGJzRDRaTDc5WVpXUTI3Nyswa0N3?=
 =?utf-8?B?Z2FhRUZHemdCUFZpUjJWZGw5K2d6ZkxIWU5wRk9wNXh0cmtvVWNtSlZjZldP?=
 =?utf-8?B?NVc0UGF0QW9pOXZMVVZoTjNxMkRNQWptSzlBZENSOFpGbTVqdGNRZ0l2Z2E5?=
 =?utf-8?B?djBrRW5LdUEvSTIvNndaSStWdWIyOW5vZmxSelR2TGlqV2FCUGlKcStzZmk2?=
 =?utf-8?B?TlFYeEZpOTZ1Q2hBQ3Y4akpycW1ERmczaHkwWkk1aWVrMUd0SGd2Lzl0R3da?=
 =?utf-8?B?YXNtRVZWTXRPbFYrNDJaZFZmdGFTNTRXQmFLQzRkL0FucTFrVGlhL2MybXFZ?=
 =?utf-8?B?TWM2SHlOTG0wZnMzN0tQRjYvMlFZQVJpcitaakhQQjZ4ejhpaTY5TmhmcUhm?=
 =?utf-8?B?VS85MEhOak84cm96VHY2end6WXBCZjVwZWpLTUpkNzAyYjlVdzhJdTVlZFp1?=
 =?utf-8?B?RktlYTFadVA1MlhERjhxUC82UVpkTDN6aXA2Skp3RG1RcGJjVmdqTXdEWlNC?=
 =?utf-8?B?aHJjaG4vbEJPamk0cGlza2JvTzNHVGg0WDY2R0tDdERndkI4aTZYUEtpcHJi?=
 =?utf-8?B?cTAxZGVzWGEydUNkMHpRa1h5VDBtWlpTdnExdUJNZzEydHBEMmJvNFJpMTZr?=
 =?utf-8?B?elhoMWFDYkJSRDhweGg5WDA4SE9QUTNNMFlvVzA4d2E1ZFFObEZLU0hsbmhh?=
 =?utf-8?B?aDR5dUYzaTVEcGFkb1JPYUxtOENFNktRbmRWZ21zbVYwem9aSDZQNFdFSFcx?=
 =?utf-8?B?MVZJRmUrSEFOeWxwUmhpZkNNK2YzY2NoaUYxY2RIWHdHZnd1Mm1yOTkwZzNI?=
 =?utf-8?B?Wk5BVnZPQlJDYXhUcEpUWEpXd0MxaDAwSDV5UTV5VDRHdTlZOTlHeWRXUGE5?=
 =?utf-8?B?MFVFakFDUTRWM2h5TGJwaHBEajBpRytWODNwYlFlTG5XVUFkTG52a1VlWEgz?=
 =?utf-8?B?c0tqb3dEUzVMdnFua0F2VGwzcjM1OFhJeGVBWjhWeGJGcUNNZzlnVzdmdkVU?=
 =?utf-8?B?RmRieWJieGpxUExpYkNJSjBxSldkNElHVjJmTFYxTjBWRzJWWThTcVh6UXVB?=
 =?utf-8?B?L2NrWHI2Q004eUlpY0FPVm1BWExWWEgvaHNDRmxNZkJoQlJjbUxYbnlpdzcz?=
 =?utf-8?B?V0JDLzF1Vk1ock9JWFFxd0VpT1Jma1k1L3dURkRIcEdnREZ2eStuejJ2cHYx?=
 =?utf-8?B?aWdCajZIQmh3SnNxR2JadXJ5b1hYOGdHcXFueFNRNnVFSHRQVjhqcUpab1pV?=
 =?utf-8?B?N05MTmZ4ZHgzeXRUaG5sK0o3SG1yRG5LNUNtZDNOLy9QM2U2NTBYQnp5czJs?=
 =?utf-8?B?REZwWGpLRG1EWktFNkkyakZ6c0Z6L2RuRnlOeVFmV3pnaG5hVkFqQmNNL29y?=
 =?utf-8?B?RVdJRGdYZVUrRVRQYnowOE9WY24xZU5RVzlHMUZNOXhIc21nNzR4cHB6VG1z?=
 =?utf-8?B?Q1g1Z01Dbkt1T3FQbjJJRjlDcFFJS1B4cWdpa0ZKekZZdGV3U3R1YVJrRTNJ?=
 =?utf-8?B?Mk5WTUpNUFhtbmVINVJaM2wyNUhVeENaK2xiTjBpNWlIRUpuelNFelRaSWx4?=
 =?utf-8?B?KzZDOHBncWpaYnFvRmVpaGJtMUJIYVNYb3I3OTZFYmFoUHlYVlRsM0dHZ3FN?=
 =?utf-8?B?Tk9JbGlzL0psOU11WEFJYzZDNmxCaFZLek5WdVBxNmpDSmVnbU5XVDB2bmdt?=
 =?utf-8?B?dmhiN2F4RWVnRlVtTlliNUk4VUkzTXNLNTg4bE9SZHpFaDNLN1ZPT1JCa3Bs?=
 =?utf-8?B?b2JlN0Rmek1lNEZjb3d0VUpDK3oxZFhGcTN6UzRwSjYyL3hzMEFOZEdCbU02?=
 =?utf-8?Q?eCfEBllAXyyeUiLKvdczJ0Rm/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XkBL6wACePppGRYRXYc1rGuOMFheo+EpCfqE//Hnr7uv0+BU9sfNaMxVMd5oHgKhulxxORkpGt7nnv9YtBZZKlszhjMp/4YLXP+W48Vif+EFezXN3DRwOIZ4ulrLmKraolIVFBVsno4daSkX6vpVbr+OwgDt1H2EoDMK5HHh+gluMgveK1muVM9dO2b5gcbk1ri8qaNfPSvdD7DVmFZIDqKYQ95cYPIVRC1M0uFC7mlVPqoiBL+28Nuw5XvrybPgQsYAJ49J2WGkJN0fyLIfGLOtnxvyRjwaUtwhoS46VnR6oKda8zo9a36MfqCGLsacaE2E31TAXQWWQNfo0eSzzDmdorRH5yKs146v5OOQVws3tYTOnDgVh9BRSQlcGh4eaJPUlUNx1TI0FKWlBQQxl1SnBC9F09Ah+VLJZn0Z5ncXS9Ejn8XhpBvfkivlYFlp4OIPsm9giyyo4sKh3wnZCyze+p47c0nfkWlBa42qg/ab1RQt0TY4u2MzTruSJEOG69cUbVBidGhd7zytwdPKOZ4sQ0SJUiHC/qyqrqBH8t44Ea033WND2BRV9MTZ+KrapFoxy+nHRZD2NBptQu4N1v8MgmvYpWNpTphsFrvT9Wk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27640efd-b5bf-467b-3461-08dd81ebebee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB5747.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:20:43.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yLPkiwKtgxAcZ7L5uBD4xsBuVWGD+IisVrK6qxjBIxdXHebJfNRqPcj4xPGV+iK4npKs9XmBmUBYI48F6lzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_10,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504220168
X-Proofpoint-GUID: U0J9RCIMyN4acx5gxyY79KyFIgsyLQfs
X-Proofpoint-ORIG-GUID: U0J9RCIMyN4acx5gxyY79KyFIgsyLQfs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIyMDE2OCBTYWx0ZWRfX2IrjGCu+Xqt7 s4SgXtSIek3hdl4igOlhI1/LezLjeIi2Gfw5rSbbRNcAggu3G3uvvh5vYPJnps0phSNFRx6tIbJ UolO1J9BitdRFcONwmy2OjSL0fMV/vpY9op0fY1Js2zeyC4rStcIqM6PyHFNiINu7zv+JQriJV1
 5IE4lzZ0vpxlwov+sl465aKFOT6fjfFb/pFgZyuBPUi5wWiOHsEzWbSHD98iZ062+ybpPdrlV9K xq3cBhcaZ9L51b+/zApriigcflSVGLsshT9t+qNqHINYYD6kYyOdlmurIlo16HbpznwGKKHVxFr BCrVsifq3zTMoqoVb6SVuXqxPNT+/lU8KpJ31cmxnDY+kT6KWv/CV9Cl6wWpSjuuVyOmgBCQ+pl UHHbqzxE

Hi Yu

On 4/19/25 04:16, Chen, Yu C wrote:
> Hi Libo,
> 
> On 4/18/2025 3:15 AM, Libo Chen wrote:
>> When the memory of the current task is pinned to one NUMA node by cgroup,
>> there is no point in continuing the rest of VMA scanning and hinting page
>> faults as they will just be overhead. With this change, there will be no
>> more unnecessary PTE updates or page faults in this scenario.
>>
>> We have seen up to a 6x improvement on a typical java workload running on
>> VMs with memory and CPU pinned to one NUMA node via cpuset in a two-socket
>> AARCH64 system. With the same pinning, on a 18-cores-per-socket Intel
>> platform, we have seen 20% improvment in a microbench that creates a
>> 30-vCPU selftest KVM guest with 4GB memory, where each vCPU reads 4KB
>> pages in a fixed number of loops.
>>
>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> 
> I think this is a promising change that we can perform fine-grain NUMA
> balance control on a per-cgroup basis rather than system-wide NUMA
> balance for every task, which is costly.
> 

Yes indeed, the cost, from we have seen, can be quite astonishing 

>> ---
>>   kernel/sched/fair.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e43993a4e5807..c9903b1b39487 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3329,6 +3329,13 @@ static void task_numa_work(struct callback_head *work)
>>       if (p->flags & PF_EXITING)
>>           return;
>>   +    /*
>> +     * Memory is pinned to only one NUMA node via cpuset.mems, naturally
>> +     * no page can be migrated.
>> +     */
>> +    if (cpusets_enabled() && nodes_weight(cpuset_current_mems_allowed) == 1)
>> +        return;
>> +
> 
> I found that you had a proposal in V1 to address Peter's concern[1]:
> Allow the task to be migrated to its preferred Node, even if the task's
> memory policy is restricted to 1 Node. In your previous proposal, only if the task's cpumask is bound to the same Node as its memory policy node, the NUMA balance scanning is skipped, because a cgroup usually binds its tasks and memory allocation policy to the same node. Not sure if that could be turned into:
> 
> If the task's memory policy node's CPU mask is a subset of the task's cpumask, the NUMA balance scan is allowed.
> 

I guess fundamentally is this really worth it? Do the benefits of NUMA task migrations only outweigh the overheads of VMA scanning, PTE updates and page faults etc? I suppose this is workload-dependent, but what about the best-case scenario? I think we probably need more data.  Also if we do that, we also need to do the same for other VMA skipping scenarios.

Thanks,
Libo 

> For example,
> Suppose p's memory is only allocated on node0, which contains CPU2, CPU3.
> 1. If p's CPU affinity is CPU0, CPU1, there is no need to do NUMA balancing scanning, because CPU0,1 are not in p's legitimate cpumask.
> 2. If p's CPU affinity is CPU3, there is no need to do NUMA balancing scanning. p is already on its preferred node.
> 3. But if p's CPU affinity is CPU2, CPU3, CPU6, the NUMA balancing scan should be allowed. Because it is possible to migrate p from CPU6 to either CPU2 or CPU3.
> 
> What I'm thinking of is something as follows(untested):
> if (cpusets_enabled() &&
>     nodes_weight(cpuset_current_mems_allowed) == 1 &&
>     !cpumask_subset(cpumask_of_node(cpuset_current_mems_allowed),
>             p->cpus_ptr))
>     return;
> 
> 
> I tested your patch on top of the latest sched/core,
> binding task CPU affinity to Node1 and memory allocation node on
> Node1:
> echo "8-15" > /sys/fs/cgroup/mytest/cpuset.cpus
> echo "1" > /sys/fs/cgroup/mytest/cpuset.mems
> cgexec -g cpuset:mytest ./run-mmtests.sh --no-monitor --config config-numa skip_scan
> 
> And it works as expected:
> # bpftrace numa_trace.bt
> 
> @sched_skip_cpuset_numa: 133
> 
> 
> thanks,
> Chenyu
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/lkml/cde7af54-5481-499e-8a42-0111f555f2b1@oracle.com/__;!!ACWV5N9M2RV99hQ!OvO0A__dCkeSB4eze2TYZYDHWGg0ubi04-u8lW5NCQGRE6vZkCGahdWMzHtpKMMDSt-L1wCkM8ILMIP3YA$
> 
>>       if (!mm->numa_next_scan) {
>>           mm->numa_next_scan = now +
>>               msecs_to_jiffies(sysctl_numa_balancing_scan_delay);


