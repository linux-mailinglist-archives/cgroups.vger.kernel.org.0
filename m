Return-Path: <cgroups+bounces-11283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA0C15E40
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772F218959A0
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2660328D8E8;
	Tue, 28 Oct 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BAPuco3T"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D22BB17;
	Tue, 28 Oct 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669350; cv=fail; b=ctyA6yJ16RL+8vhOjDZgi0YJCdMLFy4k7y3KmDctZPZFF3H3Lx0jpgffL/L5Ci6BRNNPJtYfmfISSGYfEENS3G87GRRUPtnpAEEAv1wm1ZizBbbfuxRuQ+gQVEW5Ntvud7/mCs8L8c/Zkjr8B+uPhJdO+tPVrldE/Rw9NL5FqrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669350; c=relaxed/simple;
	bh=gEXJNMdxD/G50NorMZ5XoPK1i4qPMwraoPHq/Yj6wS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gGO+bk8wGuKPpqUDOFBwEM0g1VtkZz4gWnekHRFtJIwE8svvHU4TP11YK13mUPRFXur/g53mi8ass1pl8TETDoz3tEubgwyjNate08TcsKX0CuXU3oSibC/jDOYyER4Kyc2uJ//2ib8Dot4iuH1tOf0XCFmAVkoSMNV8K7iwpYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BAPuco3T; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SCtIxJ2340141;
	Tue, 28 Oct 2025 09:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=yjpcnGoHC3rDLAgwTDVECTnEh5DjsqzwrrQftzPIHMw=; b=BAPuco3TdU/C
	mJUESK131fTPPvmXABBm0KhFpTMDItl+IXnzwMde00bv93Ogt/hFx83vSxTMV13h
	7aLdr3sVhRwy08ojcZNKFeJJCS0rc1DR8HLUHvfq5siD7No84vDfaeR4ta6YD7lp
	UD/2viFIHCjpnHYus0/U+c4ZMAElxrabB4gi9MIf7oBiYtWLYIIwrg3nzUp/s1ao
	GSk8gzUk7+L99KbzGc1prmkbD8mIZzcg4dMrZ79DvEH3LEkxXOrKskfW0f6pe2KW
	IDkpZAUIuVd2rMKYco4bS+7ZF+P00mKz7IRzsKx9RvJggdOflVYPHwud2Odv18R7
	L78LR/XZdw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a2x8t25mf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovPvr4e45rDiNgBiRp6/3lfAaaypTMLLUasEoelKOu81O3SNcvil5+R//PyVz/Y4KxQgs1fwjz6kZEibjtf0Z1DvSf0MIAGUQmgqZhk1fC3f7CAK9Ei0ofvklfOa6pgC62m6EuCmwR+glZaH4RP3O0T9zB3FzULtL1h8QzKCAQwjB1OqWJ9spZeXPHbhUd1DhhOK9QnPO1rORKEtV70BVbtA6HunTyJpa1VcvzRKmTP6qkLoExc+g/fe3wGFkyzyqh9Cn4u3jnQI3opeNuhYPVlLKKQuTduaWGpy2dkCwV/QuBVD3Lw2m3GiiZcHSWOR/8oPzxTMtf6izSlj5YeJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjpcnGoHC3rDLAgwTDVECTnEh5DjsqzwrrQftzPIHMw=;
 b=Lo1Zwy7SHKMxb2MOh8sSPyGMX3vSsLzb1ksyQExPlTHG+U9IiLzUalP2eyQmB2iKzcFJNaQfm1aRwlPZFePE8Fic1av1cvQ9r/scUKPExVlkhX5nNWjKjV6Q6VUm0kY5c3BamvWwuEVQDCHJYu/BQrCteZ75yZ7b0V7Os8AdWBtHfevIu4izXQFyEqCd2wKBRd6hswLnLphZfkasw06ykkzupjJ5WXZDEoXaYUIq1upsZtJCYGlxUIYfcqsz0XAOo8PiI1IpUbYpVFxZIuxk2UOZPWA/0aAk86SvhTF5wTwJ1HdddmUO1r7iWeOmSeaXDiNQsBlj2TEX9SbS1i+GNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ0PR15MB4549.namprd15.prod.outlook.com (2603:10b6:a03:376::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 16:35:20 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 16:35:20 +0000
Message-ID: <52ac4439-781f-4267-a374-ae0643a2c36b@meta.com>
Date: Tue, 28 Oct 2025 12:35:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bot+bpf-ci@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, surenb@google.com,
        mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
        andrii@kernel.org, inwardvessel@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, bpf@vger.kernel.org, martin.lau@kernel.org,
        song@kernel.org, memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251027232206.473085-4-roman.gushchin@linux.dev>
 <634e7371353c8466b3d0fa0dd7ceeaf17c8c4d7b274f4f7369d3094d22872cd6@mail.kernel.org>
 <a1d4d200-5a35-4990-8499-6dc7ea6d65ac@meta.com> <87v7jz3smj.fsf@linux.dev>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <87v7jz3smj.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:52c::25) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ0PR15MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 256801de-9a1e-4e6f-d687-08de163ffbd4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXNlRDJKUjV6VWNnRnNLMUN0ZlNyQ2h5TGNMOVY1M3JLdFhFaUowV1U2WVdq?=
 =?utf-8?B?eWQ0Vzl0NW5aMUtlMzM0NG1KQUN2cEdjM1EyWjVBY3BmN01kTUhIRS9qazMr?=
 =?utf-8?B?ZEVsa005SzZuNGhmeVUwbW1KYWViTG1SZFZJc1hhVi9NdHIxcjFML0NLeHhE?=
 =?utf-8?B?alI3MEFSZU9VQTN1N01ZMTVva283WUF0aS9pcUZJV1VIa2pQUTNWeGM4RWlH?=
 =?utf-8?B?bE1FNnp6MStvUzV6dGFsbDZzRGRGcGVRUTFYRVZ4MTlDN2VRVmFEc1lDRDRx?=
 =?utf-8?B?RkZKVDhISU9KU0FnLzJoK0pqZmsxR0JmaXhDRUZBb2RvR0V4eDZqN2U3L0xq?=
 =?utf-8?B?TmZyMURoNllhY2h0U2JzK0xMVGNTSnNjOXRXY2lkWW9acDBGTmFyeTcyT2Np?=
 =?utf-8?B?V1lyc0pTR2tLbFd5NyswMkpOVWdxcExhdlJBN1EybkkzQTlIMm9GWjNvUk84?=
 =?utf-8?B?R3creTBjbDZGenA5dkN5MWhWaUF0ekxVZDUyZEROTVdVYXY1OGJuWnpKTWVp?=
 =?utf-8?B?OGdvOFpnZ0lJRThWSW85OE0wSkRJUy9mSHBuM3crT2J1SXVhdC9tbHNXQmR1?=
 =?utf-8?B?WW8zR2ZyTkd4SkV6UmRudmI1UUt2Wk5Ldm81NjNMeVhWQmMxZjNLdk5uRTFN?=
 =?utf-8?B?Smp0RDJFVm9HRDB6bXMxUitoQ3E2VFYzaThxc0g3Yk14TkNkQ21qUS91Vm9M?=
 =?utf-8?B?UEdCdmQ4cUhjaEIzVlNLQTJvSWxTeVdDWVBYemVBNy81QVJqZGlwakdWQ0FT?=
 =?utf-8?B?dHpqSnVBQzJpTFViZ3RGUkw3Zzg3c3BKelBOUWJUbkcwUGI2QVQvZDBKRTNr?=
 =?utf-8?B?QlZXaWN6ZTkxOXRLczVrMzNRK1MwRXp1MGZqbmRhMjhuSGRjd1JZNzUzaHZR?=
 =?utf-8?B?N1NJc0tBR0pTbEFtaEU1N25QWlZhU3VhUG9KbnVVMys4NUEvZkNDcFZ3ZDBS?=
 =?utf-8?B?WDlvcDdIbnJIVU43R2FxMEdNUmx3c0RUQjMwNnhPVFEvU09BaGFqeUhraWpm?=
 =?utf-8?B?M3JORC92anJMTEdlZlpkQlhwaEp0em1tbGd5QnkvWGx1TlFjNzdoM3l1d05G?=
 =?utf-8?B?U2ZERFBBbDZkKytHZUYyVmtlKzl0d2FDTC9rbUNvckM2OXk2VjRoU3pjWDNN?=
 =?utf-8?B?L0xiSENPdXpVUjVESlZlRFBlc0dLMDRiMEIyZ1dnOFF5bjFvN0VqV2N1QU5q?=
 =?utf-8?B?N3grZTFnQTQ4cUpxYjZKRU1aMjM4TTVaZzdvZ2VEdmxkeDBvMzUyc3dmOTVZ?=
 =?utf-8?B?MlhNM2phdXNmM2hsUWpVQXJpbXg3SjFZMGF1eUtYa0N5bTBwT3NSVEZDdzRM?=
 =?utf-8?B?S0pkVUZ3M2I3R2plL1NJUGVNaE5PL2JLM2pMREtJUmk1MEo5RXF0Y2FRc2VZ?=
 =?utf-8?B?NmNveGxHY1VnanFYTEZNVllYMzRaOGgwZnc5R3ZVcDhiSTNMUmJRWkJOZ0Ny?=
 =?utf-8?B?NUpJNWxsRjJvcXdLS1FpazdxcG1nbVVVUXl2Z3Z2QWhCdG03ZFhwZkpTY1dy?=
 =?utf-8?B?Y3hmTkY3Rm5LckZiT2VLMkdMSk1XQTY3UEhCR0dDNm1qSTBIQ2Vxb3F1UFpp?=
 =?utf-8?B?VHlxelBkazQ1VTl1Rk5tRDJXOGltUEYyckliSUJISEw2a3d4VlBnMy9UUEE2?=
 =?utf-8?B?MGFPSnNtSmtQcDd6VjlXOUhqa2JES3Z4Skt1cXhKb1U3YTZnMTUvaVVoRWlX?=
 =?utf-8?B?NG9xTTIwTDlzTEZLR0JpMG5pT0N2bHA4azRvMWNObDFZb285OEpzeXg3Yzk4?=
 =?utf-8?B?V2NNNVlPWFZCUXFzZkhqSU90MkxlS0JsVWhwUmZzRThWQXpTbURsTGhQdGxI?=
 =?utf-8?B?YUtYbGE3R3kvWDJ1TDhsRThabU40MVl5YXJ0ZExXSTNBdERxcTN6aVh1bEkx?=
 =?utf-8?B?QXU3aXRucC8rUGhzUE1rQUxNaXVGaHJyU0pUNHJTVWFhaFczYXNvSmxDYXhK?=
 =?utf-8?B?U3hVbGxFdlFQYmpocDVnTzFtTnhsT1ZmZnVCLzlsWG9RVFEwc1BOMWhubXlr?=
 =?utf-8?B?V2F0bmJQZVl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnNsWUxaM012dVBHK3FHYUV0Wnh2T1ZuUkwxNEdxQWtyUit6SDFLUmk1V3Mv?=
 =?utf-8?B?eEZ3ZnMrNXFMbEUveHJDOUl4Q05yckw2OVRZOVpKK0oxcjBHQmNsakw3ZFkv?=
 =?utf-8?B?MlZxK1Q3TmRpRFJUYmthOGo2NUlzV1pmTW5FbmNITkxyK1RTOUZkeVBKMHo1?=
 =?utf-8?B?Nmp2TXpUajJpSUtKTHlJTHc4TnBRTGVnNmk5ZmhBYUVoQklNd1NZekdmaUJi?=
 =?utf-8?B?RHJUTzVJNUU4K2hqR3k3TjdWV29tSzVXUGE3bWZEOWt6UzRxQnlyQjd1aUpz?=
 =?utf-8?B?d1lLSlZnRkExVEpTWGxpV1RQT3JpbjArZkVSbFdsNllNZ1lNYS82b1pFQUxv?=
 =?utf-8?B?aDJBWVJNUnQ1cXF0WlFyM1pzcFhrT2hMVzFlQmhiZ1k0TUJmQ1RYbFhiY0s5?=
 =?utf-8?B?MTQvL0U1eEhWL25SR2lZN3F2SHRBbTNJUGFiQmpJbkFaQis2bnpIZTVGQ3Nn?=
 =?utf-8?B?ejJkNG9HdXJFZXdjNWpHMm5WSDJONXdCeDJJVW9sVjcvMjJ6UVBlOHMvTkNu?=
 =?utf-8?B?Z2pEZHdyRlFlWjRnSldBbUkzb045NWhobDdveEhMYTlGNzNINlJjTFRqcS92?=
 =?utf-8?B?ZTM2V1VRTnI1Y0xXbG5FOVhVNjROV2h2WERBK0pjazBmeTJ0Tmg5SEMwSUpU?=
 =?utf-8?B?Z2MyOFpqMDgyelNPUjUrODdZcGQ5SDQ1V0Z1M2dzVy9QRit5c1E2S2l0Ry9H?=
 =?utf-8?B?Q09iV2czSndHbU1Vbm1zSVVidEQxbnhRc2l3UGdsWnNVZXNCdmVsanZBaVkv?=
 =?utf-8?B?MkUyUjJ0VGZZRWhjekIvZHR2ZXM2emp4bXRodUJTalBzNFVxOWY4VzdGdlo3?=
 =?utf-8?B?bFoyMWxFSmM5Q2RuSVgrbDE2c2hEUDdTRnY0dGp2SytVbHMvdHJGQjB1Z1Vy?=
 =?utf-8?B?bzUxN3BxU2swMUtIWk9SdVZvRmJGdzR6Rm4wOHdQbk5sL0p3Qnl6dlBJZ1Ji?=
 =?utf-8?B?QktOd0ZDbW9RdXIwN2h0cUR2dkI5Wno1VE44OG5FWDNiT2owVm94am4yeFNk?=
 =?utf-8?B?dndGTlpkWEJzeXpTSlh2cjdTRWlwYXhwbFUzM0N4cFBQK3VibTN5Slo4VHQ0?=
 =?utf-8?B?NlQ2ZWlXQ3diaDNMMjlRdnNydk9YTklKNWFscmJkSkVqME05cjhCMUxHZnFS?=
 =?utf-8?B?SHBtdlNrK1JyNURqOExOUlFaMzZNN04vYlFxcFVhK2JhRWEySzIrcTBORlcy?=
 =?utf-8?B?eWpkM1B6RGI2clVwcDdtS3ArSkR0d1c0VGNRaG5BVHhyWUhFbzBwcWdUeDRo?=
 =?utf-8?B?SG9GTWFpSFFOMFk3RnJuakxuV2xaM1haOHd6YWs5djBkbm96bXFIaTBxM2Nn?=
 =?utf-8?B?VW1nT25rYmxCUU9GNjVmb2Z5VFp3MUZjTURwNWVFakxPMFlpSCtWaFdJcHBB?=
 =?utf-8?B?RG1OY0NhcGROVjR3dWxPVWpQcHlQNmd6aTNoVi9URmlYcWRvUk0yelQ1ZDNr?=
 =?utf-8?B?ZTN3NDRFZXcwYmJjMlpBN1pKZHBic0RBai9OODhGWEY3K1FSaUdGMFBtQTVQ?=
 =?utf-8?B?WWc3R0tpZHl6ais4S2tyYldEb0hWc2tDcU9ITmRhK2J6R3dSdFdMNzErdjdr?=
 =?utf-8?B?LytwS0dCZUlxcUpBd3ZTaVg4RU9FUE03RWZrMXhkdUxGSlEvLzZNaDlheSs2?=
 =?utf-8?B?cDNDb2lLK2FoMTVDWHI0VzZsTkdjYlN6eGc3QUtVakxPd3dnaVpYc1hXcVE1?=
 =?utf-8?B?NWswZ2l4eHdjVnhtVFFhY2krSDFQK3BsSTB1MEFVd3ZOQ2diUmkvb3Z1YkNi?=
 =?utf-8?B?MU5OYXlIKzh4aUhpUWJhNzUzYmxPSkFjK1o4aWZJRTlLSDZvLzBuVWVDWEVa?=
 =?utf-8?B?TERXNWRDenR5NzJqdG51eGdxNDcwbXNkTFFUWmdrL1VpL2lDc2FNRXljZlpw?=
 =?utf-8?B?MkpUSlVaS0lTUHNLMGhGc1VHdWV3aENGbExCSDJKM3ZuK3ZWdEpkZlZZQ3B4?=
 =?utf-8?B?VG9JbGgyNlM4bVNNR3kzbkNqdVNWajJVZHNQUTVVaExYNm1MeEtKV1JwSVBL?=
 =?utf-8?B?MFpTL29vWE1DT1FtQlRqY2kyZlJwd3NNQm5mQ0R2V1E5aFlvWVFKRnZlWGRS?=
 =?utf-8?B?ekJCSVFXbE9VZE9HcTd2TjVOMXRxQTh1WHhGaDJ5cmFMU3Arb1c1OTA4eHNE?=
 =?utf-8?Q?7z8A=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256801de-9a1e-4e6f-d687-08de163ffbd4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:35:19.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZn1R/MgMT+C5fvFPiynEFIFxZvHguayPW+E2SJtlwtQaAG9XQTDAzghdPOHv2Hb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4549
X-Proofpoint-ORIG-GUID: pglfSkpTu1YsIU4CMBDhYUkQvlU5XbSy
X-Proofpoint-GUID: pglfSkpTu1YsIU4CMBDhYUkQvlU5XbSy
X-Authority-Analysis: v=2.4 cv=ZKTaWH7b c=1 sm=1 tr=0 ts=6900f0ca cx=c_pps
 a=5EMrObNM7I5xfgT5kXX3QA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8
 a=xu8wUCuQCvNfIwa3lZkA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0MCBTYWx0ZWRfX2+ru429RBS4X
 wPQJG11um4fAbZPfGZpLixYQhxFdCTH5KVIE97pkVHcl4+jNF8+QuFvM/taNjeyfAdPTJfMPHoF
 uzS6zd++UBo6mWdLrCce5mn0FJMfxmiptPe5rXxu2BcLkM5kPUDaN9JZtIaeXxvq7NbrLaozfX9
 N89jTECisIbHZbMi1qlBO4ntA4yX4TTfp5+M3QjRqHTMABzzOZ8dEXyOTLIx1PNvH4C16pTFohJ
 MPYuq7p6qgNyJ/jXWQ0wO6kTOoQ/TsTCcqh1w7O7sRB64XzawoRRLk8j1n6SMERqeIADK2rNKiv
 K6J48YowmQskFKDL1GmhG2fEcLsSi28MYi6ImJ3z89DqXJAhq8RewrSAlI01Dp2v1cY61GC88d0
 qXjOVwnSQWR/S22MMvT+cVeaRDDvag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01



On 10/28/25 12:20 PM, Roman Gushchin wrote:
> Chris Mason <clm@meta.com> writes:
> 
>> On 10/27/25 7:48 PM, bot+bpf-ci@kernel.org wrote:
>>>> @@ -1350,11 +1367,14 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
>>>>   * Returns a negative value if an error occurred.
>>>>   */
>>>>  __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
>>>> -				  int order, u64 flags)
>>>> +				  int order, u64 flags,
>>>> +				  const char *constraint_text__nullable)
>>>>  {
>>>>  	struct oom_control oc = {
>>>>  		.memcg = memcg__nullable,
>>>>  		.order = order,
>>>> +		.constraint = CONSTRAINT_BPF,
>>>> +		.bpf_constraint = constraint_text__nullable,
>>>>  	};
>>>>  	int ret;
>>>
>>> When CONSTRAINT_BPF is set in bpf_out_of_memory(), the early return in
>>> constrained_alloc() prevents oc->totalpages from being initialized.  This
>>> leaves totalpages at zero (from the designated initializer).
>>>
>>> Later in the call chain out_of_memory()->select_bad_process()->
>>> oom_evaluate_task()->oom_badness(), the code performs division by
>>> totalpages at line 237:
>>>
>>>     adj *= totalpages / 1000;
>>>
>>> Can this cause a division by zero?  The path is reachable when a BPF
>>> program calls bpf_out_of_memory() and either no BPF OOM handler is
>>> registered or the handler fails to free memory, causing execution to fall
>>> through to select_bad_process().
>>
>> Looks like the AI got a little excited about finding the uninit variable
>> chain and forgot what dividing by zero really means.  I'll add a false
>> positive check for this.
> 
> Yup, it was *almost* correct :)
> 
> But overall I'm really impressed: it found few legit bugs as well.
> The only thing: I wish I could run it privately before posting to
> public mailing lists...

I'm pretty happy with the false positive rate, and definitely appreciate
people engaging with the AI reviews to help improve things.

The BPF CI is directly running my review prompts github
(https://github.com/masoncl/review-prompts), so it's possible to run
locally with claude-code, and I'm assuming any of the other agents.

I've been refining the prompts against claude, but welcome patches to
make it work well with any of the others.

-chris


