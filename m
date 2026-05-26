Return-Path: <cgroups+bounces-16292-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLYmBNVOFWpMUQcAu9opvQ
	(envelope-from <cgroups+bounces-16292-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:42:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E835D1D33
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73C0303EF43
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0275A3CBE9A;
	Tue, 26 May 2026 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hVpWEfV3"
X-Original-To: cgroups@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177C3CBE74;
	Tue, 26 May 2026 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781260; cv=fail; b=p34vfB2+QtGYDEt8n/JIgAwyF0IdTLJp0SuV0XAb5ZHhyVhHneiU8fwAsfYDW3gbQ8/akulDD/n+5neD2VaHjKT4dHtzIiGpFw7GSEIs5+HmZxshDTs3hXB9v2irctG1vxaaSvpnm0NzJsBkymBkeK3M+Nwd5xWO5wyIR6l8I9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781260; c=relaxed/simple;
	bh=NvfW7tP56YyH/QLAuwKCSIWMbDYMeJ9pkdQXgjpdw0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LkBB7+zKDvrZYIluYS5oHcRsLRoz9HwFJUTrWqvrOa3jd2Xh6mFdBYjTee9p/lHnE022A/e74azJkctn75OkYlUJdSoYWFxZJnjU3mUiTsCSTUEpY2BBT81lXAd0eOf5g7ujbSH/AHSNssZdpDgi3eKh+7fOCsU02v0iRk8W9O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hVpWEfV3; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMw1RFRX67x2QZ78z20+PMMZLG3we0rBnUOxOI5mwPk/KvubjxtAXI27hk0PUTZ6s0ukkJm8OqS67TfeppQrg8bcFbGCgwXsoc5Ley2609TCtBb7J26ffgVThdslLdZeExalcJi34xxUILPeW7I2/lVumoWKtcl7MMiIQvCPymA0tTbWMECYBo3LgCecymdSqscwBh0C/MA5eAvcaFIjC/62lH+BUVx3k243DGSsVt9DLPYb1hmD6gkzBKVdaXyqdEh6gFB74F/DG4V9s1ZlMSqGo8JUvnuJ4lEPqfEocn3EjKGa4lHTP14JMH6bQsp+CbYJXjFTsY07w++WVQiPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L00bC2FWVEsDKy39rNP4ADjdZTbejRfUMppkBttYpVg=;
 b=QHW/A40SLgDkW/BlMizdDgUOTkCil88xn15FwTFQmuB1spjixuxfMSkJBdlp6cqVls3cEytq/t4qf7o6Q+0exhxBujwHuZ2s5X1xy/7Il+Xds+oFkOJlnRpc5ONVnNBfvbSfs5AaUCQhuGI9wRYGFIGT9IFnys9y2tfCor5PEcE7YI034SzOSoa2l70a0935fdDkjybHmKAUofWoqI1EitHU70iPPgvOALP+i5U/q8M16KpW9vSoQr7ZyChAmMWm8cjLRp4rzENF5ypgbnVh0j4AJGIpTkXslUYAOi9TrEfFyvwI3Ld3ohV8YQtnmUIyInEwQQLkumNuLrg2N5vHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L00bC2FWVEsDKy39rNP4ADjdZTbejRfUMppkBttYpVg=;
 b=hVpWEfV3/1vcs6AbBZnDBdUPGl7g7mmdcQF5aU/FK0l+1kq7tuPRYlE2HW9UXNhNZG1XiNNHtj5//ysAVzRCACVcL4xFdEwDkmNXK1swRC5YQPUOXo9X700t5cCWirIbtR/XyUIDdVMgK4Zj0ijifdSvB0Rs5tY5/CkeZCk9ElM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 07:40:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:40:56 +0000
Message-ID: <4ac138d9-fa24-432f-b2cc-78c3fc58f0e3@amd.com>
Date: Tue, 26 May 2026 09:40:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
To: Shakeel Butt <shakeel.butt@linux.dev>, Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
 <ahB7pCu_G4vuswc0@linux.dev> <ahB8OhgdPgOkzuS9@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ahB8OhgdPgOkzuS9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd3e3f8-a34a-432a-a1a6-08debafa1f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|11063799006|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	7dE+6M6317zRY56ryNhsr9xb6e2WOAhu5pscx/nZpd0R01RFb9DYkbX4LJGSpMRpcZ9RgXo8uStN8Yz0/3JFyKjCrgWkHlLp+NPGHsSsWDW2vhZEj4v016c6//Ty5CSxccn4NMlRpfXR+O/l0YLIJlPlLvl5jub1/orSppVQ9VChd+CQTs9lgleBM2XMiHtCvzuc/d7kDCRCVMECuWgRzW/OS5mK8oeUZ8RXZo/D35elAra2/GWqikzcX0rcBcTYyE9WDDJoKHskEh8DlwA+5tFsYeZ6W2qEitgt5APTyf5c3PxrM7ckIiWXRD9Ezo4SRj+jsGv9GOjDRjBEFgAbOhVCFcqsfEycuUJC6QNXyE6oHlsGmAsJUniemeUFcuIE7trvzFuHnYLq0Jl5At8+cFlD0DOfeDS3dtAWdhYDLg7gq/e1mgS3z5IEGQtEnxLaw09ok5525VX+jIp/ccvDtfkpue3J6WRkBwnA053YnB1z6iVxIikKBUKmWO44HNdfa3/4dkdJmZdj7x7EFamsGWAg0eZ0K3xo8Q/yaoWz1Tq7xgaAWrYTCr7m7Lo7WRTeL/Vct1gECqbKdrJDMbTauqFqGT7fIz3EXp4sPrHOoS/bVPnDlyOfosIwaE74l2bldOyl4zdWiUarLH9Ov/1Fh00SawaxObN4iQRzdXZ5bMkg0t5QJ3Z8gjDzLNOZGgvM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2I3TXJCeXBOV1c4RFFVUG1ZVzNjSGlCTkRDL1NrSmFnc0hQZ3p3dmN6RzN0?=
 =?utf-8?B?bnVldC96czNhdzFVMHdMQXdoTDVwWGRVeERQaFYrVlM2bFA3RFZ4L2xVL0Ra?=
 =?utf-8?B?aG1qVmM2QlR5M0NramlubGtPb2tlYUZvSHNjV2JVUGN4ZGtXZ2Nzem5OdTBB?=
 =?utf-8?B?UlVGOW8wZGJhY3RoR2JVMkprcFdjWG1GeDZLVjgvNjFuNmVNSjBRK3FWSTV3?=
 =?utf-8?B?dExCSFRxbXg2UUZId1M0bVdIdGtZdkNOSlZBajZicjhzeUdzYnN6azJLYktU?=
 =?utf-8?B?VGQzcERaZUR5MzZJa3U0QlZsd0RLMHZEVmVGTEdNWDhqMGd1VXg1bm1BNjkw?=
 =?utf-8?B?TW5RTHMzZDBPaDZMZTRnMGtySU9Sdmc4eFdzeVZnV245UXM1b0U5QWRqUjI5?=
 =?utf-8?B?WmhoQ2ladmJEVHpJQ1ZWamRneVpoS2I3MzR3WXczY2c4ekZBR0dTOTR4NVlU?=
 =?utf-8?B?dCt4V1l6d2RMNGVPWkFPb29zUi9NYkNDNWdNRkdZNlY5RWZqbFlUV3B0amV0?=
 =?utf-8?B?TG54NDBoWXROL0lObkZYVEJLWGxrVWtPV3VaalVwcmJBMHp6R0pmN0F5c0lR?=
 =?utf-8?B?M25NL3FyWWwzOVJvVjYzak1wUTNMVzRROVpyTGh0RjJ2UXVGUVN1c2tBVFVN?=
 =?utf-8?B?TjlldHU1cXppalE2T1JMK0VYeWxhaURpSUZTWnVEUXZaRnB1Rm1JbGlCUWhl?=
 =?utf-8?B?SlUwYnZsSDFoTTYvNFA3aXVKem1lNGpVVVlDeHhsUDU0SE16cDlWMElvSjFD?=
 =?utf-8?B?Q1JweWU2MzlaVXNVZmFZd2FXblYrMTZnYWNVWG1GaWJnODBxNFlma0VUL3Na?=
 =?utf-8?B?MllXRjd5ZEJzei94MzRwUi9TTjBja0hsMVZxMENZUkhDek11V2RGKytTNmhs?=
 =?utf-8?B?MU10Ulh1Q2Q4ZVhDQ21qYUdhS1owMmlIb2tLUWJobWVDcnc2RXpIZHhzcDNj?=
 =?utf-8?B?TXVYWlh3d0xPbXBPQjE2R0NXbnlvekpGa05tZFJZeGNmTGVDakIyM1RLUWx6?=
 =?utf-8?B?RmkyVWFiYnpEOWRoZEh6KzRmSmNnVTVac1FXRXdlU0NrUGVvTkU3NkVYM0NU?=
 =?utf-8?B?T0JmWDNLNzQ2Tys2U1ZaY2JBeHBlOHZBT085TWF6cksybjhGdTlhaHZQYmMr?=
 =?utf-8?B?T2ovMTc5TERQVXpvN2FKbVJYNVRWNlBTRE56dnJlV3RQdW5VWFN6eXlsZ1pu?=
 =?utf-8?B?a3pmbVZkSEwxWWdXcGRuais4ank2UkYwWERXd0NNZUZyd3dZK2Y5VEdZells?=
 =?utf-8?B?UmoyS0JrVm93OUNPcHpDdTNHWkJLWWt5VU5qUWl5VEJQN1lSOExnSytDUDVo?=
 =?utf-8?B?OEVpcGhNZHJ3SmthOTRiTUxhZk9ObGNhTC8wYmliZkIwUmdKdFFSRUwvcXdh?=
 =?utf-8?B?V0VJWFVid3hDYmJOMW1kT2pFK1R4NlZDdDRNRms0S0pBWDM2UGU5Y1EwU1or?=
 =?utf-8?B?MEJpSTB4Y21NNGJ3OGdLbkZRUVhuS2ZVSG44d1RCazN0ZHo5WGRxMmxuSnY1?=
 =?utf-8?B?NGFsSjcrVCtLajZjQ1FkYlM3NHJGc0FnSk8yWVdDVGZIOUs3VWNhOE90dEVX?=
 =?utf-8?B?cG01dWcra0svK0xIRHRQTHZoS2FYdWVGeEp1NE9BTUF5bFdENTFVNE9vVThY?=
 =?utf-8?B?aExaNWFkNmN5dmVDUllJM0kyQXU2QlNodVhHK2EzNGVOekd4dGZtS3V5Vitt?=
 =?utf-8?B?VGNEUWNLcDhTODBLL2ZoUk0xMDBWTXRBTTJ2VFg2VnNsUi9CZlJjc3JUa3lO?=
 =?utf-8?B?d0tldVU5Y3BlYUs5NEwxVTM5Zjl1STl1ZlZCVnFQSU9jZGRVRk8vTS9NR2hq?=
 =?utf-8?B?THNTWnpQNGJUQ1ZjVm5Fc3kxSVhMUXByWkdFQjlmakRSRGxBSXkzVjBzQ1lp?=
 =?utf-8?B?WlBRTFFRQnpYaHU0czgzNHYyTGxMY0h0UmtHQ1RGaUQvTXpIY1crZWJnaFd6?=
 =?utf-8?B?cmQ5WkRGblY5V21wd2tZQS9GUm5aelFKT3lDSVlPVXVKbUxxZTFMc3NDQzBr?=
 =?utf-8?B?elY0MjNzZ2xyZFRDekRsWjBYbHg4OVo3S2puSnkyWllNZHpCVzZ3Vk9NdjZx?=
 =?utf-8?B?Q0tXcFZjRDhFdzFxZHpJUXREci9OZ3ZJTlJkTlpVQitwSTRRd1g5bU4wbjlY?=
 =?utf-8?B?Y2JjTE1MTGRQZXhxOHZrZkZhNmZKR2ZhcGR5S3dPd1RkYi9kaHFQaFduckVP?=
 =?utf-8?B?RkJ3STBNTmpXKzJmeUJqTkxsaERPVDkrWUpJOVB4K0J1RzhvZ3lab1pHNmRJ?=
 =?utf-8?B?NVJ0Vy9KRlhHMUJFUy82VjlSSmRwMFBwV20yU3h5Z1R3S1VyU1hnQ3NGNUo4?=
 =?utf-8?Q?ZVek5xuhxm8KCGBP+p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd3e3f8-a34a-432a-a1a6-08debafa1f2b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:40:56.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwSFg7t2L7MSCPsgx/+Vjn3Prp6MCNlu1l+bmWs1epUTtuBwKre8WfezhTddikSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-16292-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68E835D1D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 17:55, Shakeel Butt wrote:
> On Fri, May 22, 2026 at 08:53:10AM -0700, Shakeel Butt wrote:
>> On Tue, May 19, 2026 at 11:59:01AM -0400, Eric Chanudet wrote:
>>> Add mem_cgroup_dmem_charge() and mem_cgroup_dmem_uncharge() to allow
>>> dmem pool allocations to optionally be double-charged against the memory
>>> controller. Take the struct cgroup from the dmem pool's css as there is
>>> no convenient object exported to represent these allocations. These will
>>> resolve the effective memory css from that cgroup and perform the
>>> charge.
>>>
>>> Introduce a MEMCG_DMEM stat counter to memory.stat to make the cgroup's
>>> dmem charge visible.
>>>
>>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>>> ---
>>>  include/linux/memcontrol.h | 16 ++++++++++++
>>>  mm/memcontrol.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 81 insertions(+)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index dc3fa687759b45748b2acee6d7f43da325eb50c1..8e1d49b87fb64e6114f3eb920293e14920290fe7 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -39,6 +39,7 @@ enum memcg_stat_item {
>>>  	MEMCG_ZSWAP_B,
>>>  	MEMCG_ZSWAPPED,
>>>  	MEMCG_ZSWAP_INCOMP,
>>> +	MEMCG_DMEM,
>>>  	MEMCG_NR_STAT,
>>>  };
>>>  
>>> @@ -1872,6 +1873,21 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
>>>  }
>>>  #endif
>>>  
>>> +#if defined(CONFIG_MEMCG) && defined(CONFIG_CGROUP_DMEM)
>>> +bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
>>> +			    gfp_t gfp_mask);
>>> +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages);
>>> +#else
>>> +static inline bool mem_cgroup_dmem_charge(struct cgroup *cgrp,
>>> +					  unsigned int nr_pages, gfp_t gfp_mask)
>>
>> Please follow Johannes's request to pass the actually memory object instead of
>> naked numbers.
>>
> 
> Also what exactly is the backing memory here? Is it system memory? If yes, then
> you need to pass struct page. For non-system memory, I am not sure memcg is the
> right place to charge such memory.

The object might be backed by system memory, but might also be backed by device memory.

The charge is there because when applications over allocate device memory they get swapped to system memory.

Regards,
Christian.

