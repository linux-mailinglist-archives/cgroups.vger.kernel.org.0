Return-Path: <cgroups+bounces-10775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B85BDE4EF
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB13735774C
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3AE322A18;
	Wed, 15 Oct 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X96a4lmF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hbtu52RB"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06208322A09;
	Wed, 15 Oct 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528505; cv=fail; b=OQ4U+3AfqroxsnTkXlzc4Dqtz17c55VKH42g2ItwOAlZ9scwOrFNLEtNZZzncffTOKNVu05VqvZewigMsSobe8smewIbNcxoqQPktzc8i8Zh7BQIAmRgVIAVSoqcgpZlkDPFtzYytSZUixjlp10huBSAtOJSXcfY8qhdJI7K34s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528505; c=relaxed/simple;
	bh=yzMimtBAGVQazHY5re1zp/o14jTD06GtqDGg/wWc/Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mbc3iRjF+JQ6W9Ijr6hlEGOoDVSMPj0t+LKKm2EmB4YZEReK2X7TVmWUD1iX33SoJ0oGaXSKKqro+3vte5OVP1HMAYv4xRWU78fo+ZzJUagBMZDUSc5g8quNx0SZ+irSPxCvoc3tD6bwPXmEwoQGqGCAqsDWeOiwjiLnCQolar4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X96a4lmF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hbtu52RB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F9nh5U023868;
	Wed, 15 Oct 2025 11:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LVuzkp0LM8u8ZgxV075nNDMfxIN4m1ywUuIYgyupIow=; b=
	X96a4lmF+nslKtuBpDc2A0d/rJZq6F1eOPLqmX9UXGFjFq37TeKmxVhQ4+i8g5EI
	7PdiVl9Rg883IckDd8sHUINvZwaKFDnPrXCVpswBLQUJYgTNJ8gl/Kf8lFVerXu4
	VZbM+aY2JpA728GMO7mNgt/9L8WxEeqS2wNl/16qxKzVz8SChj103QQW/Hf/Vfvq
	Y+UUqU4VGtCqb0yfYcIY9oa5cZ2eP1M9dak5eBSD26p5568cthNsJQe58qpO+uH7
	xAqvS4854ZCGsWMX22wsNrq1RBdOT7ZWhiGkmRi8AIqHhx7TOACUQ2CX3kRhptW5
	8TWeklbuv06DclbrZMBVbw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47pb7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 11:41:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F9DuP1036619;
	Wed, 15 Oct 2025 11:41:10 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpa7xrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 11:41:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfTVUfERuXt+NPRaOVIJxNs2gZUdcJEj0UWvgrwf+dEaLSxHm8b7Ph16dG4rqNaM7rMenvEvPP2kFoqmj6iP7SAxFbMdari0VnoTuyuBsTxDsGzr9RNiIP2Qr8b4XOBziMA/5YL11rxtCoiXliuN8L3yCNEVQ22QOg9b4nhMw5GEyXGED4c5wkg2wF5XUzzlFIhQZCxC9Enw3rggPvJufSqe8FSFiWvDiLi9a8vRZY+vnFdBo5WPkqqVoNCW9CWjLgjCyYiFmF0HwFLHg8Q7iBy6NyMeYlz3odYD7eyvhUXxOTi/3RA7QD9k53yZIsj8f/PSrqxb9V+Ja+1qSL94ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVuzkp0LM8u8ZgxV075nNDMfxIN4m1ywUuIYgyupIow=;
 b=fce1RAjy4/cKFdrHkv0IebmELuFn2BllGfA3Uksmz88pMkrPc3S7pm1RiJCv+AfH9u+oefFrYwJmj5zUzn3ImjGi9wW4P+5fYRf9y8zT0b1coMTASH0lhehhwf8NbHE1iZfE+E5RsPVpHmR619b4NHZ6toNd88+t+oc2H/ouDlQpM8UEeeLJdjJsyBj4R5FVOMeU1J/aciZG1mEq0fPJhJNZ0nhAT6Kvr8/uf4Eha2JH3PlOIhDSsfJ3XgFX9KoVT9AQYRMdwKb8Pi96KUPJZI8CiXx+DYyOhgcVeDua5AMKZugJCx6TI9STJB2NEMZigOcXiYCKmYELEEKtJTy81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVuzkp0LM8u8ZgxV075nNDMfxIN4m1ywUuIYgyupIow=;
 b=hbtu52RBx+uYG31DK1546Owac0Hc73UAOs/9pEqh+d+Is8S6IWx5ugAAGenC1iNru/jRgxz5v1l36tCtzfy2dEhLv4S6RrqaT5UDJzZcOW3DHuUXghaQC+g3mPazylpjIbBSA1HYGmJl2x/W4ql4QIrbMpzfjmQdqX744oGuyJc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPFFE6A35993.namprd10.prod.outlook.com (2603:10b6:f:fc00::c5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 11:41:07 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 11:41:06 +0000
Date: Wed, 15 Oct 2025 20:40:57 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
Message-ID: <aO-ISd4W-6cl49OO@hyeyoo>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
 <aO9okBEZiA4pCNku@hyeyoo>
 <c07838ca-4e6e-4837-b99f-09fd44c7801c@suse.cz>
 <aO93GHNR_32-Pmom@hyeyoo>
 <6194b6ab-6b43-468d-ba78-a95594c48798@suse.cz>
 <8f161ba2-6d0f-4dbb-85bc-ab4bff04f24a@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f161ba2-6d0f-4dbb-85bc-ab4bff04f24a@linux.dev>
X-ClientProxiedBy: SL2P216CA0093.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPFFE6A35993:EE_
X-MS-Office365-Filtering-Correlation-Id: fde77404-82b2-4096-9922-08de0bdfba6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yy8rQ3hFU1F5MEovTFowb3V0ek9GbHhRN2JsZFVOaXZXdnI2U3ZuWXNvWm5K?=
 =?utf-8?B?ZUpoL0EyZWtZUVprdm5tazJYSjVjTVA2Q245aUdUckpybTZqZXpuV1pvZTdB?=
 =?utf-8?B?K0hhUzg3TWNaL3pjcVk0SjhHWURVdWJFRFFBSXorZS9rK01yN0pqQU1wTmFm?=
 =?utf-8?B?UzdHRDRzc1hOTVpsaG1Oa1dQTW55cVBiL0FkbDQySGtCU09rUTBKSmNWRTJq?=
 =?utf-8?B?aUhHb0hsNmc0UnJNQVpXcWpnbUN5ZDRsaTlRV0pNQmExdllFSkcrQSthSGNJ?=
 =?utf-8?B?RUFCUlRuZ1lhLy9rTzJ6cXZ5TFdNZW5ra2dkRFlXZlh4aEhSUURZZDRvcG43?=
 =?utf-8?B?VHRCNUZuci9OZm5vSG8vWVJwSXlLMGQ1NHoyMDNSSDRYOU40cnZEQnRFMlVi?=
 =?utf-8?B?Q1V3YWhzZ1FBREgxbW84c1hWaW9ZRmVFYnN2U3ptSjR1RUVVVUxJb1BpMVBC?=
 =?utf-8?B?MzkrTm9IRWcrZU1OcWhpOFU2OVdITXdUSTZrc3JYRUlqMjJrRzlUSFFWL2k0?=
 =?utf-8?B?V2N4cWc4cjgreDhWZnpXU2NYMzNNOURYVXNvUnlDeHR4ZjgzWktIS3BKN01F?=
 =?utf-8?B?Q2hFWTFnZmxVMGgyWGlKcDhhTmI5aWtSSFBUWU04TVZod2pUYzNHTVJNK0tJ?=
 =?utf-8?B?TGt3cTQ5VTF1WmZ2QUtwK0duSXFlR2I5MGd0UDV6azBpZlZLdFlMcWlwcUc5?=
 =?utf-8?B?MGpvazBOWWh2TkEwOUthMlVMNG9RaVVFQytIMkxlSGZkNlBhcEpkU0VZZFhX?=
 =?utf-8?B?SHBJdmQ0TG9xVnRyZ2txT0xNWGJua3JnWW53OFlaTzlWUVNPdzA5UHJtcWdx?=
 =?utf-8?B?dU1ZSDk2V3hXcmwzZ01qVTlvWUhHQ3AzOVRIU3FiUWMranM3MUNlYmc5ZHdO?=
 =?utf-8?B?SS9FeTg2d2J6TVErMUgxT3QwcHRGb2Jib21GM2piRVVsZHorMHEzM2lQWEtE?=
 =?utf-8?B?d3NXQVQwWisrakx4T3dFQnJwNjJnTGdJeXdOclBTeFJ1QkNNTlRNOXRNUUt1?=
 =?utf-8?B?alNleXdxN0F6Y2cyQnJHRFhqNmc4MDBxQUZsemJVQXUxdktGWEs5bHlwZ2Z1?=
 =?utf-8?B?OVV1UjFEdjJKZE4vTXNPdGZPZkdxQ3BPOERvR3pVRXJZcHIvaTh4Vm91YjNs?=
 =?utf-8?B?N21JekFaNWd4ZnVZeVVocUFlcWdZZWs3NzJHb0cwZ29CSXlUNXkwVlNkNVZv?=
 =?utf-8?B?Z1BKcnh3SVZ4cE5CWVc5enhMU3NobW5Kb1lFcVZHNlVoU09iY3ozZVFwWVNp?=
 =?utf-8?B?UkZFeDJhODVpQ1BFdk4yeVBtNXFaM0FtU2VzMjFsejBDWm5BZG95L3kyWWtQ?=
 =?utf-8?B?dTgvd0lZR1pZMjVQbG1POW1tN1lFaTV5Um54a0NYSHNRSUdVK2FMWm9yN0Y2?=
 =?utf-8?B?M2hsaGMycENwQ3lhMjdkNWtoZWtrWHp2c1JHQmowS2hHZm51cDEzakRISDU2?=
 =?utf-8?B?bjNHRFoxSXdIdUhQNjNYbGNrMmRNbmdMU3ovOFBtOVpyb2xHSGtRbkZDN0lB?=
 =?utf-8?B?SlZsaDl2S1VjbWkweTZCY0R1YlVXVUo3WUVoNUN4ZzFnajNhNlBCQ1NGZ29K?=
 =?utf-8?B?TE5kM3VJM3JRM1BLT2ZlK3NaQU5UTlVWSXlBMm5XTkF6R0xleUo0aTJtNEdl?=
 =?utf-8?B?aFJHNVh2NDVvcFhRcXllc2tQNXpoVUhxNHB6cGdxOCtrQm9EUFkrSUNQMDQ5?=
 =?utf-8?B?SENEVjJzWGtGOUVGZzdkL1ZrSGVnMVVyNlJqekViK2szcVVCWU1qQ0xPcnMw?=
 =?utf-8?B?VGU1SjBTWnV6R3dsK0Vxb2Y4Y2VBb3FMTXFvNGF2VDdNMmpucHRXMHdTOVJw?=
 =?utf-8?B?ZEFrY0Y5T2pvZkJkdWtaOGFmT0VBTHhZMG9ielorOGh5WTc5OGplZGcwOFNY?=
 =?utf-8?B?bm9yVXJoUjEwdWZGL2VpcXB1S0NjTUdDNEF1eXd1QTloNGlTVDh3MzFjaFZ6?=
 =?utf-8?Q?TrkgC1KCtd3P+vcVYJ6JSZo4fdg2IKCm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R21ucU4wUjhRUDVGOEJWY290SVgrWHZOQmE3TWhVU2tMOGY3akhUbkhGbUNW?=
 =?utf-8?B?STV5WGpWdFBQREtSbHk2KzI5Tm1FRmlkYVFXTS84d3JlYXdZR3ZaNGFtQUJq?=
 =?utf-8?B?TmJxNThpOFlvOVQvNzcvemZNYi9STXFzVTZUQ0xoQzltYThVQmNqTlUzNVlq?=
 =?utf-8?B?cHdWNzBBNDdXcUhyZVVwSVRaRisrb1NVRm05RHVyanI5UnhlOXlUdzNKSHBv?=
 =?utf-8?B?T0MvdmZZdytTT2ZVZDR2VUpWVlVqSktmY0pXR0k3SjFCQlRISkJtRUFhU0U5?=
 =?utf-8?B?dmMzREphcUl5Z0VlMDJSSlFiV1pkQXpYcmU4TFg0cWNNajErOURjRE1Ib0xj?=
 =?utf-8?B?WUVsOWJGc2RWRFRlN0k0Q1U0alZPekJOeEhtTzdSOG0xdDROZ1FCenlFODdh?=
 =?utf-8?B?dXVrS3hONU5NMlNmd3VFZ25zWjVLL25BTTkvdEVGNkVEeHl2MjBwb2w4NlRJ?=
 =?utf-8?B?bXhFZzdOYlpTN0t2Zml4WG9zdVNaMTcyTUkxdHFUNXdmT0NJeUUvVVlNUkNK?=
 =?utf-8?B?c2orelJpZ0lSaWJLVTltR1BJQVlNWGRMeTJkcmt0Vk5JMEFEZlhvWGpyVS9S?=
 =?utf-8?B?dDdadzJCUFRjTEVRT0R2L0toQVVieHJQQ2hSRmpicXdmLzlRSmN5UzRCak9T?=
 =?utf-8?B?N0FOc1RLMURZeHAxeEJaVkNMNzF5ZXgveUY0UElWbi93RGtaMDdvQ1huSHpT?=
 =?utf-8?B?Q1JvV25aZDBSZmQwakpYWVNrSzUyYnNXczNnL3lPZnFTUGRQSnM1QVQvVkxp?=
 =?utf-8?B?VzZiNnZTNVplV1FFbTVpVU5OMmdHUkxXUHhHS01UQnlQSm5qREJudGRTa256?=
 =?utf-8?B?ZW1IZWRNWDMrbUp1eFRtWTdwRWY0bUdwSU1OWkhVY0twMW5FejhkeGl6TklB?=
 =?utf-8?B?TGhwc3p4clVFT3JuS080UHBLY2ZjYm90ak5CUXpZcFRONGN0TGRwUHNEQXVH?=
 =?utf-8?B?SU9kVnRrMkNFdjVJUS9UMHA3aExDeVRudDF6Ty82MGhNckJvNm1zS3VjcjFz?=
 =?utf-8?B?Q1lsOW5YbUVRK0ZicnpJdUlpV0ZNM2NHZVNjZ0ZZZzN1bmltcXBaelo1NHh4?=
 =?utf-8?B?Rkp1czNGZlpWZDV4a0xsbTFvbll1OUdnK21IdmxLeFJoQmdNaHRKN1crSjh4?=
 =?utf-8?B?UitzUHpGS3R3ZVFiZ2c3c3h2Q3djUXBLRld2azZKUU9rTElRZGJVenhOS2cr?=
 =?utf-8?B?YkNqT1JKSUdWa0kxLzJZMk0vZm4rc0FjL1RULzBzbUJ6RnRxUkxUd2NqOGli?=
 =?utf-8?B?Zzk2UmgxZWVzVHZwU0NEL2NrM2Q4ZmtWZnhRbEI5V0s3ZWZLdi9SUGVyZGdG?=
 =?utf-8?B?OGJOaUlMbUtoa3VuM0xheDVmWHpSbGdpbks4OGFGbnBzYVl2anJRZVFobm1K?=
 =?utf-8?B?WnUzVHlZeWlUSUJDQjVOZ3h6MFQ1bDk4MlllRDlCQjE1a3FWM29pNzloNzJl?=
 =?utf-8?B?bWxXNmN3TWNvRnhJdE1nMkdndURmdGM2RGM5ZE1aQnRSYXZKbUhMYTBwbW4v?=
 =?utf-8?B?eXh5UGMyUDRsaFl3dk9xNFpmMUpjS0R6Q1NrUldNRXE1M2JML3U5TWplblNl?=
 =?utf-8?B?YnZMWHppWjlaSGpHdkR2Um1Pb2NpWHk2bDZGN0pCUERLN1YzdTB1UFNaV0E5?=
 =?utf-8?B?OUs2UnJMRzJJdlVVZHZyOE12Z3MzSUNtem8yNFQ2emFwOUd5UW5GK2trN3pH?=
 =?utf-8?B?cUZmZThVZnFvZzljQ1BQT1YwVnNLYTRFNUQvRHNVY0JWK05qTDBFOFd1bFlS?=
 =?utf-8?B?SHE5eFAwUlJsMDAwMzRzcFdsVTZWcHpPOUJncC91b2UzUlpXL0VKQk9YejEw?=
 =?utf-8?B?d1hLOGlWRVpJS3QyQWlxditPcGpGUng5VVc3MHhUb2llMm1LZVhaYk1XaFpt?=
 =?utf-8?B?Tm1uZDNDZUF4NEtlUEorOUNJc0YwRGRZaFRIUm0rdXlSQmhTOWVuZVN5WVg2?=
 =?utf-8?B?SVRPcS9uUGRrTjU4ZjVpTi84Sk5tRWRaMTJFMm40SUEvUVdFY2YxVllpL1Ur?=
 =?utf-8?B?dEJSQ25pYXZNQms2TCtiUVF0L2JmYUhlQW1lZndvRnBoUm41WVFYRTZMc2RY?=
 =?utf-8?B?dHVVSnJrQlQ3aWdCRWFla29nQ1RMUElwYlVjcGlBeS9iakVLblAxV3lhVlVQ?=
 =?utf-8?Q?OxFgHg/V/8Yl3QuRxP3C+2Lmw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2hsWYp3lS0LXU5koSKC9r4iOK77bUad/ilujk8vowgx8ChUEl3n1vME4oqjZuaabIZyNwVA0gJ2/IXhkJBmDnAttOISSZv/Zohnol92Cff3nNk3OKNng4fkw0Gm0n3kFcZUf1IYeZR8CjK3U2Ll901Qv4sxmlHwgA7uHxlG1ES4FXka4yQBWRbY3j7kVgyFkucpDQcJMbdJx4Mxx7Tnvr145y4l6ZQ5BqXTWmgiZlN3QiE7kHCK6beXWCqCTN0FDWjLPQtAw23b7Rj8W9f/Drm079em0eQvR3lwRUMUTQqtFqw5ZSYebg2JTTwQ8UruNREwZjwvOTZEMvcBXOQRygMyCAwoQsecwV2y02J3Fz+hjDt70E6iOEhXAOy36cshxSap26djZwcgMtPi+uSYJBfykr/9UZg/qtmPcZtyD6BdyMM+cRET7q3skcSzElJxJAxljKQeTdIor9fbbpqIQc00LaABB46KsgxvIdYDLMjsR2Eq+pexdbIqfKJefQUUSPrY8vHTsKTbHz26rd6pUjY9NIdsb0sjkGqU1P+KCjN937ihsYPuDFd1fAkC283C4b/fQ677BrXeXt2RRxnOFg3oMQftLFPEpdriHwppEuZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde77404-82b2-4096-9922-08de0bdfba6a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 11:41:06.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4dWtuY3fGVmE9ITXTAN+48DhU0IujiibCw31At6cnfvnpvzyOM56UyRqKUsNpd4A3TBsfYnbtHUiP0uVbLepQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFFE6A35993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150090
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68ef8856 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=G_yb82s2WI6yuWXeohIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: cYV8ixIaPSZHaLbn1rKfw8pgpZHDRB2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX5IUuOOwr1zGT
 Bfm8f5SlLamNNzrcmlU0wLoKBbE6weiJSj+wCe7u1uk/dsc6s1xtyc4pwknKz1QU8V29iFjJ1Ak
 eKDQ0R0Q19J7evHqn+MX9hwHwT+YRXyNZm1MyWQ45W5EXLduTRV/LaFlBjo1ydER9pfQOaCCznv
 rNC7izxSR0kWcHJbHomOLZxvsiiJe0Em37q7OELM1r5Yz6z/4DV/is2NWXpeTWZm4vGObZmkjzl
 95dLtj/9lHjuVcQph21xPve/rkdJ4ZjHqT6SqEIr32jR1Sr1QyQIskbJGDMd4/twk3MReezTLEq
 PCQVFkQF2eTVMCL6bnFFJqwWw2AYBhFl2nBuaICztRdjIfjbZEeL1eTBMjxp0N4/13i4jITtYk/
 iO8ffHIStA+k5gtn0ZW4EzXTm9II+A==
X-Proofpoint-ORIG-GUID: cYV8ixIaPSZHaLbn1rKfw8pgpZHDRB2S

On Wed, Oct 15, 2025 at 07:22:59PM +0800, Hao Ge wrote:
> Hi Vlastimil and Harry
> 
>  Thank you for your professional guidance.
> 
> On 2025/10/15 18:37, Vlastimil Babka wrote:
> > On 10/15/25 12:27, Harry Yoo wrote:
> > > On Wed, Oct 15, 2025 at 11:54:18AM +0200, Vlastimil Babka wrote:
> > > > On 10/15/25 11:25, Harry Yoo wrote:
> > > > > On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
> > > > > > On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
> > > > > > > From: Hao Ge <gehao@kylinos.cn>
> > > > > > > 
> > > > > > > Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
> > > > > > > the same bit position, we cannot determine whether memcg_data still
> > > > > > > points to the slabobj_ext vector simply by checking
> > > > > > > folio->memcg_data & MEMCG_DATA_OBJEXTS.
> > > > > > > 
> > > > > > > If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
> > > > > > > and during the release of the associated folio, the BUG check is triggered
> > > > > > > because it was mistakenly assumed that a valid folio->memcg_data
> > > > > > > was not cleared before freeing the folio.
> > > > > nit: yesterday I was confused that this is sanity checks in buddy complaining
> > > > > folio->memcg_data not being cleared, but it's actually folio_memcg_kmem()
> > > > > complaining that MEMCG_OBJEXTS_DATA flag is set on non-slab folios (in
> > > > > free_pages_prepare(), if PageMemcgKmem(page) -> __memcg_kmem_uncharge_page()))
> > > > > So the paragraph above should be updated?
> 
> Hi Harry
> 
> We don't need to update the paragraph.
> 
> We did have cgroups running at that time, but they had no connection to this
> page.
> 
> The entry  "[ 7108.343500] memcg:1" can also be seen in the v1 logs,
> 
> Therefore, the situation at that time was indeed consistent with what I
> described above.
> 
> As discussed below, this only occurs because the OBJEXTS_ALLOC_FAIL flag
> 
> was not cleared when the slab was about to be freed.
> 
> Or have I missed anything?

Oh, I meant "the BUG check is triggered because it was mistakenly
assumed that a valid folio->memcg_data was not cleared before freeing
the folio" is misleading.

Not clearing folio->memcg_data before freeing is considered an error, and
page_expected_state() indeed checks if ->memcg_data is cleared and reports
an error if it's not cleared. But that's not what we're talking about, right?

Instead, what we're looking at is that "the BUG is triggered because
the OBJEXTS_ALLOC_FAIL flag was not cleared, causing it to be
interpreted as a kmem folio (non-slab) with MEMCG_OBJEXTS_DATA flag set,
which is invalid because MEMCG_OBJEXTS_DATA is supposed to be set only
on slabs."

> > > > > And as a side question, we clear slab->obj_exts when freeing obj_ext array,
> > > > > but don't clear OBJEXTS_ALLOC_FAIL when freeing a slab? That's not good.
> > > > Hm great point. We should rather make sure it's cleared always, instead of
> > > > adjusting the debugging check, which shouldn't be then necessary, right?
> > > Yeah folio_memcg_kmem() isn't supposed to be called on slabs anyway
> > > (it's not a slab at the time we free it to buddy), so we don't have to
> > > adjust the debug check.
> > Great. Hao Ge, can you please send v4 that instead of adjusting the
> > VM_BUG_ON modifies free_slab_obj_exts() to always clear slab->obj_exts? Thanks!
> 
> 
> Okay, I will send v4 as soon as possible.
> 
> 
> Thanks
> 
> Best Regards
> 
> Hao
> 
> > 
> > > > > > > So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
> > > > > > > 
> > > > > > > Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
> > > > > > > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> > > > > > > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > > > > > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > 
> > > > > > nit: I think it would be helpful if the changelog explained why we
> > > > > > need the additional check. We can have the same bit set in two
> > > > > > different situations:
> > > > > > 1. object extension vector allocation failure;
> > > > > > 2. memcg_data pointing to a valid mem_cgroup.
> > > > > > To distinguish between them, we need to check not only the bit itself
> > > > > > but also the rest of this field. If the rest is NULL, we have case 1,
> > > > > > otherwise case 2.
> > > > > Agreed.
> > > > > 
> > > > > In general LGTM,
> > > > > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > > > > 
> > > > > By the way, maybe it'd be nice to introduce a new helper function that
> > > > > properly checks MEMCG_DATA_OBJEXTS flag.
> > > > I thought so too at first...
> > > > 
> > > > > > ~/slab (slab/for-next-fixes)> git grep -n MEMCG_DATA_OBJEXTS
> > > > > > include/linux/memcontrol.h:337:	MEMCG_DATA_OBJEXTS = (1UL << 0),
> > > > > > include/linux/memcontrol.h:344:#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
> > > > > > include/linux/memcontrol.h:358:	 * MEMCG_DATA_OBJEXTS.
> > > > > > include/linux/memcontrol.h:400:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
> > > > > > include/linux/memcontrol.h:421:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
> > > > > these two,
> > > > > 
> > > > > > include/linux/memcontrol.h:492:	if (memcg_data & MEMCG_DATA_OBJEXTS)
> > > > > this,
> > > > > 
> > > > > > include/linux/memcontrol.h:538:			(folio->memcg_data & MEMCG_DATA_OBJEXTS),
> > > > > > include/linux/memcontrol.h:1491: * if MEMCG_DATA_OBJEXTS is set.
> > > > > > mm/kfence/core.c:624:				 MEMCG_DATA_OBJEXTS;
> > > > > > mm/page_owner.c:513:	if (memcg_data & MEMCG_DATA_OBJEXTS)
> > > > > this,
> > > > > 
> > > > > > mm/slab.h:541:	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
> > > > > > mm/slab.h:543:	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
> > > > > > mm/slub.c:2137:	new_exts |= MEMCG_DATA_OBJEXTS;
> > > > > > tools/mm/show_page_info.py:55:        MEMCG_DATA_OBJEXTS = prog.constant("MEMCG_DATA_OBJEXTS").value_()
> > > > > > tools/mm/show_page_info.py:59:        if memcg_data & MEMCG_DATA_OBJEXTS:
> > > > > and this do not look good.
> > > > > 
> > > > > I mean technically they are fine since OBJEXTS_ALLOC_FAIL is set on
> > > > > slabs only, but that's just a coincidence.
> > > > And checked the the other debugging checks too. But then thought it's better
> > > > that if these are not expected to see slabs, then they should not be
> > > > adjusted. I don't see it as a coincidence but as intention to keep it slab
> > > > specific. It will be also more future proof for the upcoming separation of
> > > > struct slab from struct page.
> > > Then we're intentionally using (folio->memcg_data & MEMCG_DATA_OBJEXTS) check
> > > as a way to determine whether the folio is a slab (either slabobj_ext array
> > > allocation succeeded or failed).
> > > 
> > > That makes sense to me!
> > > 
> > > > > > > ---
> > > > > > > v3: Simplify the solution, per Harry's suggestion in the v1 comments
> > > > > > >      Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> > > > > > > ---
> > > > > > >   include/linux/memcontrol.h | 4 +++-
> > > > > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > > > > > index 873e510d6f8d..7ed15f858dc4 100644
> > > > > > > --- a/include/linux/memcontrol.h
> > > > > > > +++ b/include/linux/memcontrol.h
> > > > > > > @@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
> > > > > > >   static inline bool folio_memcg_kmem(struct folio *folio)
> > > > > > >   {
> > > > > > >          VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
> > > > > > > -       VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
> > > > > > > +       VM_BUG_ON_FOLIO((folio->memcg_data != OBJEXTS_ALLOC_FAIL) &&
> > > > > > > +                       (folio->memcg_data & MEMCG_DATA_OBJEXTS),
> > > > > > > +                       folio);
> > > > > > >          return folio->memcg_data & MEMCG_DATA_KMEM;
> > > > > > >   }
> > > > > > > 
> > > > > > > --
> > > > > > > 2.25.1
> 

-- 
Cheers,
Harry / Hyeonggon

