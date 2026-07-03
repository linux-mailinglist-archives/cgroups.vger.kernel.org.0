Return-Path: <cgroups+bounces-17471-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MYAgH3u2R2qudwAAu9opvQ
	(envelope-from <cgroups+bounces-17471-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:17:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7C702C35
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:17:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=VZUvTzs8;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17471-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17471-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4177300E17B
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF43D411A;
	Fri,  3 Jul 2026 13:08:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0691E5207;
	Fri,  3 Jul 2026 13:08:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084126; cv=fail; b=LoXvJzhqfrZsVdzgO6/5vozrxKGrKJsP3DtJE5vZhoiICIsSA1yZyjTT90EjqlpfO/k+TzotbwcwefPBgGM9uDpjBuCDGTMiJsjqnRQDFntTbLXL6ghm1tXxQw6ZP+HMkt1X7Tn8fNp3PVG6hiCExAupGnB3mpmPhnn29XPP6LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084126; c=relaxed/simple;
	bh=2lcy7mE2TTykYmmPEh8PbhAkxqjO2nTIVyeYVjuSTWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XB5uzCjPFp/W97f81ax7oNQ1/we6CEYOAKjBFZUKV2C/HzhhmYkpZgIyHCbqIRmZzgnLAYq7fcZbO15qaDPHnyhoLPVFWVkBwQxUSkluuQ5NakxhreNvht5MrvnquKKG50bRoJOTYBRZq1rTG8s8aHi4jSEgomkW9oByWpexsyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VZUvTzs8; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPTH5xQSirnA6KDk8PHo9QhLSjvQJBDFBAEi87wOVclfCLHencsxQz5w3Q8Dzvgm4/A51kx9yp01yeLDitb3L9kHLQk77inRDmGNcZj1lPNiocjxz+6oYAgdDp4rhrSOboIszD4e1RdS6bTUlKArEEZztg0QAmWr4OhRO3EL6bXsKMae3za5xIEK0uwUoXMfGe4xI6X7xI5uPtA5iigkWSCSbEWrcPsLlIG8/FYGdkLU+RG5MPU3nU8tt+elqbiw925njGeUkd1L+kSDP0ChQY94Z4HHC+05RH3YNQVR9Jt1nG7/AUDjywztj6Q5cerC9xit2Z0fUwEDEsv0iacsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdJDhUPiCvW2ifhL67b9HmiL62tzwmVvwU14uRS0dcA=;
 b=COJbUc/FUTqorNryL6YUZmR66gqQqfcrhj2qTkYlNVASqoODyomsKsuwBcZhgTVuhhKspUGcH6fmDPcMgavBAH+6h06HbKkrcJ2jj0Nfjf6oItNVoGWKcMr8c2UA38XjZ8xTwGstVTZO83OI0mab0zef2Z16G+LEJvpm0k3AukiOgLkE/oxYPwiF8jZHRH/S17jeahcr6QYuLsYXGOowVq6qp+fg9Wf7ZBuAgZFtQm2duV3uRiem/eK01nRblXiEuZSwmaAJA7g5lsUNCcmF/pUQfgsBnWKB9ZhU828oXpcB9x/EmCvruzMyUemSzLiY5OmoeSQ/TOSdq3pbV34yVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdJDhUPiCvW2ifhL67b9HmiL62tzwmVvwU14uRS0dcA=;
 b=VZUvTzs8lKxsKSRWpE/Y5qI4tFTfn0fpzZTXWzwQT4YpleBsyotcHHocCINlf1MrWcf6+4SIXWukPdsdvpVBZwTDpJJRdkSBIXcPeTLMLbdZ40sm0HSyTtvdADt+hBR8SUBoGFFrNq9vTZoW2VY0Ib97tnLT7Nj7eBlGzI8D0O4=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 13:08:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 13:08:40 +0000
Message-ID: <9eae1a5c-d2ef-4d75-a581-58299ca37a1f@amd.com>
Date: Fri, 3 Jul 2026 15:08:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] drm/amdgpu: Fix init ordering in
 amdgpu_vram_mgr_init()
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: Sashiko-bot <sashiko-bot@kernel.org>,
 Friedrich Vock <friedrich.vock@gmx.de>, Maarten Lankhorst
 <dev@lankhorst.se>, Tejun Heo <tj@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-kernel@vger.kernel.org
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260703130541.2686-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0949.namprd03.prod.outlook.com
 (2603:10b6:408:108::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8f7a5f-a502-4ffe-26e5-08ded90433a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	reqhboUdFovLK5+C99ScLf3ygC2vAHvlCbppZe5pO4z2E0SLc8fo3EgsWrW1e6/lAaNJlV4t9QHsfCDGZ0ju3T1AFdi+NKo1HgchbhQBVX7yHA2Ijg79vQ7P1PjawNa3LWd8nrhFfOTZ+Wy7JpPwRhgr48EjqC+TnlizCmoGkvC/HVsj6Vcs+W6qW5ukdshJ4kyfRAHSD3ETf7tTELYK+rL0ZCXkLa8XNRDLfLkADYju7qUrWDnMGPG2hJCsLeg19OzvNkmn9gQEVqCRdblvGL0NROSz9w1bukCRzLn+EohvpCmdnd8+34qbeylfHFHiDzLR8+SxOM36LtqkF4BV9FxSbPWVGAlpBQRf6YGiw+rMdra2zr00fFntL1y7vzfWnz+MBQRvtRMKm1Bxue9Oy+OQ0CEAbYBfw2urEwba6jMl5b9/dJSLpsjMfk7SbsCWo3mnYXU4jx2LhEEZnxRkcrwnsfCCsZnz9o/9LRiDAEUiYRaTZ+COokJ3RV2jlHpRT0irEuQrqppODycu/EqwwP1trc90MpnEFlYfHfSqnqbadEMStjeYE3qkduDCU9IHzlz0TcnVwzSGb2t0LdVLFsclyUzlAtWrd13Jr9gbfJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHNlUm1CaG9ETkJERmYxek1pWG0wWmdEQnZVNkszL1BwbDRkc1BxdlIwV05F?=
 =?utf-8?B?Q2d6VWplcHlrSW9HcU9jSVZZYmYxUk9rRHgxRU9FQXQyd3h3Q2NEUmE4b1BZ?=
 =?utf-8?B?ek5KdHZsOGxXNXBJdDdsc3hFMkl1bWJGZWUvd0JSbFdiMHlucGRFY3NQSXp5?=
 =?utf-8?B?VS90NGtaNlFkeUhzdnB5WkFaK3BQa05OMkQxbVdncGF4a1pWTGxYdXYvQzFX?=
 =?utf-8?B?US9yWnYxVlZuMjAzbzJILzRqOFoxRlAxeFB6RXozcU9Vc0dkMWJPSUJXVlVi?=
 =?utf-8?B?TGplUlVZanBSRWNodHE5SWZLOEJPWG55YnRsdm53SW1TZWF6YzkrMHdyaG9i?=
 =?utf-8?B?WkRNenBJRmFRUTdnSkxVVlJkUmpya3JHdDl0ak5RZUtJTUc2a05mSTBvSXBU?=
 =?utf-8?B?dmU0STRPK2NBRGpSN01yTTAzR0ErdUVnVG5yOFdJOU1aN055VFgwdllid0JM?=
 =?utf-8?B?RkFUc0JxaldDQzdMdTRYT25FNmNCS1NZUmhmSXVMT0oyS2tXWUNQOU1INjls?=
 =?utf-8?B?dDJiN3czMkpoOUtBaDZLNTZ5aXNVeEFla09iYWpUV2dJdU82Y0krbitJQnBm?=
 =?utf-8?B?MG45ZGt5djl3bk1BSGNUekxsUCtlcGc4U2dIVXNuSys2ejVqbFQ0ZEt1ZUt0?=
 =?utf-8?B?emdYVzJweVVIci9JMGdXekFpaC9TSXlxdWxOblNGWlhyTEpzWm51bk9kNzRL?=
 =?utf-8?B?Q3J1cWZFMWZHa1pOS01KYXRxOU1jNmdZK3puVmFPSmhET1hkWXlhRG0yMmVm?=
 =?utf-8?B?WGdJeTZuWFEvN0xaeElrMDNldzBXK0Q4WGY2MnFZZTg4MWhCTGdnSURJTDJa?=
 =?utf-8?B?SG9zR2xodnFoVk9CL2E2c0ZXQnNydlAveFNndWt6dVREVHNGNzRFMzVHdHFk?=
 =?utf-8?B?dWdoczRBYXhYNmVLQlNUUk1DRTZWWkhHUHNFV01GcXk4eGVUeWlFWk83N2JX?=
 =?utf-8?B?OUw0Zmt0THFWY3ZuTnp3YW1SSm1hdmVpWHpHenFzSE5adlJIeElKOTJFUkRp?=
 =?utf-8?B?S2xISzlGc2pqZ3RXQ2tQVFliVFNVYWV1eDhUWmtaYXcyN3FYeEJHMzV0d2hS?=
 =?utf-8?B?bzBIUzFuTHQ4VVR2V0p6M0RyM1pXTzcybk9GSG1PbVE2R2VINDZTVUROdjZ0?=
 =?utf-8?B?REtZUTJsVGMxOVdvcWp1TXpWd1FkOGxzK0xhZW02NlpUVFIyTnlWTVJ4cXJR?=
 =?utf-8?B?UjJiNno4bWFnNy8rMXdoSExkZFd1MDlYc3ExeGZGdjRDdzFjWTJZTUJzS0hh?=
 =?utf-8?B?dzNTOTJCSlRyYUJSMzkwNU5SVWhjY3RsY2M0MncvQ1l4MFQrWjFoU0NkRWRK?=
 =?utf-8?B?TzlYVktpdHQ1Zm5YL0QxUm1NL3FkZm1qOVBMcmVSbUhnaTQ4VDV4Z05Pb0Rs?=
 =?utf-8?B?OE9oUjJVVEI1UzQzOHJUNGIyRHlaYW84UXRlMlRqRm1qMjhtWFdhU0lWajNG?=
 =?utf-8?B?ZjVKWG9ReFJkV3hxamF3TXJscnlFZzNtUDdlSkR6R1hWYlVTbzNqYW81U1BT?=
 =?utf-8?B?U1RSUWE2ZUphNFl2R1JxQmZWQ2k5YzFjVFlwLzJUd0hiakxPaFJBREI4WW16?=
 =?utf-8?B?K2xvZHZZTDZnU0pIZmFJNG5NTFJNaE1EUXcySzRQSFYzWTBkWUs1dForYmFp?=
 =?utf-8?B?bHVrbklwblBBbExLbUpvcXlQRjRCa3JGT3lHK3RJTVRuVnNIZGNmUk04Y3Jt?=
 =?utf-8?B?ZG9BeDkvQ1JqNVlHbjNqaWlHWkJRc0VIam9MYkV6QjhralNYbjZFcXpyMEgw?=
 =?utf-8?B?ZStWeEFaRThJb1IwQjBvWGtlVWZWVERnU3k4WkpuNnJpZlIrMm9vemNrQTI0?=
 =?utf-8?B?MW9vSUlPWW51TmZuaEJSS1NpQ21COFUyeWVrY0RsMmdGaXdXbXVwbFA2V2k3?=
 =?utf-8?B?SWIyM1luN2Q0aTI3NzhHYzBWZ3V6anFGNWdIQ0lrUGJCZmg1VEtmQXR0ZVlK?=
 =?utf-8?B?ZEdKQ0V4M2Fta09FWDJuRThyYXljUmF4dk4ra3ZXRUNMYmpjT1JlVXl6ZGhp?=
 =?utf-8?B?Zis4Qitkb2RjMXU3K1lETWhyVWh2MWxkVGJrYWRqNHhiL1EyZEJZazF2dVF5?=
 =?utf-8?B?dFNiWTdOdlY4RE5NSW9iVldnVCtqa3RoVHpGRHNoK2Zkdmo0dXZiSXhXS29X?=
 =?utf-8?B?dGo3U0FIUHFZL2xaNzFYanBOMUVhMW5ZNUdRR21OZUR0azhwV2w0TXEzSndz?=
 =?utf-8?B?SmRmbllqckxnNzVTRTdpWHRDVW9JU25uc2hZd0xtK2daZ3o1bzlDWkJuNXFN?=
 =?utf-8?B?TGs1V2x5dCtZU01RdE9McDJJZjN2K1Nmek5peDk5TGtXMm5xNlcrZkZxTGNF?=
 =?utf-8?Q?cstJtxyDyr/nd96AOZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8f7a5f-a502-4ffe-26e5-08ded90433a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:08:40.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLqfMghh+0qa9VKsqCOxh4U1jNRHQ7AZ4sz+LAhaQj6/QjF0Q/wF1YkCHOB8Vh2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17471-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thomas.hellstrom@linux.intel.com,m:intel-xe@lists.freedesktop.org,m:Arunpravin.PaneerSelvam@amd.com,m:sashiko-bot@kernel.org,m:friedrich.vock@gmx.de,m:dev@lankhorst.se,m:tj@kernel.org,m:mripard@kernel.org,m:alexander.deucher@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:stable@vger.kernel.org,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:cascardo@igalia.com,m:rodrigo.vivi@intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,lankhorst.se,amd.com,lists.freedesktop.org,vger.kernel.org,cmpxchg.org,suse.com,intel.com,linux.intel.com,suse.de,ffwll.ch,gmail.com,igalia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70C7C702C35

Arun please take a look at this.

Thanks,
Christian.

On 7/3/26 15:05, Thomas Hellström wrote:
> drmm_cgroup_register_region() is called before INIT_LIST_HEAD() and
> gpu_buddy_init() in amdgpu_vram_mgr_init(). If it fails, the function
> returns early and bypasses those initializations.
> 
> Since adev->mman.initialized is set to true before amdgpu_vram_mgr_init()
> is called, a failure triggers amdgpu_ttm_fini(), which calls
> amdgpu_vram_mgr_fini(), which then:
> 
>  - Calls list_for_each_entry_safe() on reservations_pending and
>    reserved_pages, whose list_head::next pointers are zero-initialized
>    (NULL). The loop does not recognize them as empty and dereferences NULL.
> 
>  - Calls gpu_buddy_fini(), which iterates free_trees[] unconditionally
>    via for_each_free_tree(). Since mm->free_trees is NULL
>    (never allocated), this dereferences NULL.
> 
> Both result in a kernel panic on the module load error path.
> 
> Fix by moving drmm_cgroup_register_region() to after the list and buddy
> allocator are fully initialized, so the teardown path is safe to run.
> 
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260428073116.15687-1-thomas.hellstrom@linux.intel.com?part=4
> Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in TTM")
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> Cc: Maarten Lankhorst <dev@lankhorst.se>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.14+
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 2a241a5b12c4..ac3f71d77140 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -918,9 +918,6 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	struct ttm_resource_manager *man = &mgr->manager;
>  	int err;
>  
> -	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
> -	if (IS_ERR(man->cg))
> -		return PTR_ERR(man->cg);
>  	ttm_resource_manager_init(man, &adev->mman.bdev,
>  				  adev->gmc.real_vram_size);
>  
> @@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	if (err)
>  		return err;
>  
> +	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);
> +
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);
>  	return 0;


