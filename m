Return-Path: <cgroups+bounces-17812-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kJKVLsnfVmoDCQEAu9opvQ
	(envelope-from <cgroups+bounces-17812-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:18:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0BD759D6A
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:18:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TuJ7rZeW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17812-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17812-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A5B311AB43
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 01:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB85371D1E;
	Wed, 15 Jul 2026 01:16:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A59372B2F;
	Wed, 15 Jul 2026 01:16:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078217; cv=fail; b=VzECEyA5q6aARgo/COILqsrlYGBZLiMnBZGc+VIwiUHlME+srstsvDF7Mct5lfZoKKVzBICP4TvxeCh1kCsuFJl1+g9jr5eG8ITu2AIo0x5GRam4tRaBdSA838YQ5jYwx+wU50fXUFUk/Kk3l/wIvC3W6k5lIwTKrl8RT39wLVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078217; c=relaxed/simple;
	bh=zewQkyxltJZbrQR7d/me7BtZhIcOwydVkWwIYTqNcWU=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=VO0TADmSitXMDSTQHKlQ3OOLitpQ8VjlZw9zg0RAi0Un41p1L3YgB2VvlXCNmFaRFuM2lHAZYYLV8Ep2fFhzM2SpZEWfQf4TpeInVgSqSWBxJSG1UGY+uo0ZTm3mrZVRuUBa54DVeF3clSlmaw+952KjbtAcVgzETwHYNwF+2n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TuJ7rZeW; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWLStSg4FNqvX29//Noae9qj7tGK5tbPf9OEtnPr7NJODWQ03DbsXwyUp1182x3JgwKIFy4EhbyQmU0W+x0djNBDeebH+RsT6t8KZkDI3EkJcW5GU4jItYJSS++/VoXqeQfzt4A5rQln4VxwSHcYaNPao7wAfeL6Ho0T2ySneSyHwIGz3dWvr6FMoR8QQfJOto7QY1W+20GrGJrq/gMd6t/+JGevjt1ZlnhtilcLOelePJjDDkPvNW0mCVfLbf2B4hz43jN27K+S1g5zIpuDbJTw/5wjtKs9+GJojaVOWs3zv9VaZZTiJmX7o8uDyB/idlay7q2NjMbrCbbXfwmhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzyDOpQhFiXIWRTcIo02OD5rpJAI7CSFH5j/ALKYMGY=;
 b=URwCSbWYkyB84puDBWtyffFiwJ36zE7T8W52pwdeQC68aYg43+JNCPluMHwchISxMN/M05OJIxUeFXaM9qNKzxvZ2rsK4YDbytWp6LhEdDUDvX2vDltEfNx2+v8vXRDH70T1Srf0ze0nkn8Qsp2puoqYQfIQPPQMcdQrv18PcPVY9h5fhI+iSUQlF10/P8GmXVfUHzs04qe7p0S7HNDyqV5nuYV9rc3YF8JdRlou6XODNyQpVXuVgxjmNPgYgpocfNvfpofIoTJEe75RltDopORJ+IKFgTcUJQtRTneRkVqGKb/IqNPVWx195+X0oKSP3cvUE8bDDuKMw/fkm9U11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzyDOpQhFiXIWRTcIo02OD5rpJAI7CSFH5j/ALKYMGY=;
 b=TuJ7rZeWpT6AV4HRXd+R3SE4VGWhlFHJzjDsLHQUBIE32BGMHWoMg5jykEj5P/G1MkY7ZYfoizMDzlpZiugmTMK7ZDUzVANqGewYgM/XmcuhC4oFtD3ln/ga2ND0VKS48CNCI5HLfAVZ7A3DfwH4u9km9H3lTOE+ipLqCMCEfBW0PW++93YTRMwVGyQlLqaf2bYuM9A2bDZ5ulyR4gAuDd+KvO1th89hslHnLdqzx/nNUPQBpbhscoLqHiL9QkWggwCAlqvC/HCJIC66rK2V1DjTdnUgLlzpmRPbLN/MLnU7s6NAozDRQvxXaHyY7EIzkcBO749o3MB8rH0+z29fGw==
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Wed, 15 Jul
 2026 01:16:51 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:16:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 21:16:50 -0400
Message-Id: <DJYQXZ52392V.3ALH1EFW0CXMB@nvidia.com>
Subject: Re: [PATCH v2 2/4] cgroup/cpuset: update some comments about the
 page allocator
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <cgroups@vger.kernel.org>
To: "Brendan Jackman" <jackmanb@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Waiman Long" <longman@redhat.com>, "Ridong
 Chen" <ridong.chen@linux.dev>, "Tejun Heo" <tj@kernel.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
 <20260714-spin-trylock-followup-v2-2-3c20ed032b14@google.com>
In-Reply-To: <20260714-spin-trylock-followup-v2-2-3c20ed032b14@google.com>
X-ClientProxiedBy: BN9PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:408:f5::16) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 7675d0da-f629-4001-90de-08dee20ec030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	9Cj5NMNIfzinKMwNvcsHDP/OU12h3+JQ4bWkLq/NRuwkTGHyJ0ghBKLX3OUMEnfQ+S1BOx6LwrSWxNJLN/bi9Io8FbJv8BDNtVXxtliExqBfLcqwnMR17TVWZGT9rs+bAU1XCCT/jF0gcD8WTWl9B/2I3S43wkfpF7pKUU85Hs42zWeTKMuQSjfiPW4mtP2fEdne9jf+wgC76V6Ym5p+f5l5uHEx/xdGCMjpwpvfUx+sIY1BiPXwTdu2Iis4Z168/4fP1CufGB+4Q1DgZSijgOyTrMCyzFdQDx8A8/zIN/XezalhEJ019Q0NYY0eBuK18aEN7y38PkQBHFhIHrNm3Fy5aaQtH/9/NubasBygRQvHPu3TrTBNaFy8tbN3cjUjmO3TbuJo/5P9PhiCihr57ylJtl/wKh8u4NND5R5O4v1NJaBJC5nN9JhjfF/sTJbWWHh58J0fENUjqZ9tIdQ5mp/kLKLS5P16JdEpRycuU1P7AkmEuJaxR/czV/yky6z9/ve62Qve85uK/wtFZ3Y87zsP0d+A9gUXOZ7CUmGWIuW44lqSG1ay6i/0SjKNSbEaKAz9/LAOom4/pweDoW2YszV0mUCkW+HRIGlakiGxvGdw5chEWB2hCl2PSIManQv1aQYMBvol11cZ1nT6J778fCTZVvuGCfFiRUFlxdeM5YQ68OcumIerYOTR2vmg8rR9KUugXNX6MJUgTgNecoYtoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alYvNmQ1blo1dkRxeVZWUjNyWHhZYTFibjdhV2Y2MVp2QnpXR0p5bk51VjBH?=
 =?utf-8?B?SkJHa2tNV1JFOEtadE1PcWRrQ3hQQmc2K1pncXk3citpOHhhWUZCc0FvdmFM?=
 =?utf-8?B?Tmo4S1h3RjVTbUgyNWF5dG1yU2ZhTVROWHVFMVNYY0NPazZhRlVqd0VwanVE?=
 =?utf-8?B?aUVyQ3hTZHRmdStPRy9GalMzT1k1UERWTDV5TEk5d0pLSG10VitHdnNrVmd5?=
 =?utf-8?B?UFlGRE1IZUljQ091QXRjNjVubzhxczZjL2M3dFQveXNwcWJUT0NVSnp4bE1K?=
 =?utf-8?B?VXlpUXc5Vyt6RzhoZkxnTGNTUjM4d0ZlZXNOSUtZYkxYRCs3aE1yRzdSYnYy?=
 =?utf-8?B?V0Jrd0N5cGp3Y0RtVmdsdlZTeXRiSXYvelVmWHpaMWd3UnduWXRzM1dmdlhj?=
 =?utf-8?B?QlV3ODVqVVg3NFRmajNJNi9XNStENWt6V2l6Ymt4RGNtWkFMOWhvbGFnMWI2?=
 =?utf-8?B?dTRYMjBoc01GSGVQSGRJWmxvNmVwc3NXNC8yUnpJSDNFUTB3UFBLNkxla3lx?=
 =?utf-8?B?MTZiUEpvWDkwdHMyVVJxSkJScXZFMWRxWDM2RUZzdjEybEhreG9rUkNDWXEv?=
 =?utf-8?B?YVVkc2ZvSzNkNE1VRVFNeVlSUTBNbVNzbCt2R0dqaWxWK3JhU2ZFaTdTVzVs?=
 =?utf-8?B?WDRtdWNrZ3U0WEdDaGlnZGVnODQ0N0ltWkt2RFBrekRsTEtUOHlaSjRnbm16?=
 =?utf-8?B?RzJnT2VOSGxIMnBXL2NFeFlwNUNtc3RoOUkrTm9TbWlZSWtHVXlDSiswYWNQ?=
 =?utf-8?B?cCtpeGdYL3N1ZlZlSy9ham5mTXZOTWF2a2tTVEpEV0ZuYjJHTUs1SFYvVUly?=
 =?utf-8?B?UVFQZHgwZ3A0RERaMGNvWEJSL2FZOFF3U3hkNWVOV2RCRWJRR25pTkhHMXJR?=
 =?utf-8?B?eW9IMmxCTWFEbFBySkVKS09oVWRGamYrME5teGNXQzBrSThkUEloY0VHK2hQ?=
 =?utf-8?B?eWpHZE00K05ZWXBBR0hHNVlUdmpFRnRLeWVPWXdSdnJHOWlTdTN0QUlaaHFB?=
 =?utf-8?B?MmFwZHlwbWlYdHI2NFpCVXptdkZaV1NUQU1GbVQ2MW5lZ3FpS3lESVVkU1o1?=
 =?utf-8?B?VlBRZWdPWStnUFRmY3RiQVNVY1FEbklPaytGWHorbW9rU3JlQlhzbkVnOWZw?=
 =?utf-8?B?SmNOTzdJY3Jva0xSOEdGRmxxSEY0dHFyVHd4WmZqRW9ONm80YmxMZVVMc2dy?=
 =?utf-8?B?UmZlb0tvdldBenV0alFRYitmOStTc0xTbnh6MVowTnpKdmdoMHBOeDI1ZjI2?=
 =?utf-8?B?YW5sSzZvK2huMXJMWGpWS01RcXY2dFJlYm43Q1E2YkNuUDQyUndzL1hpZ2R4?=
 =?utf-8?B?K2NubTk4bTVZczIxbHhzVWRmcGtoamdWZGlhWDdMaGl3WGdUZkM5Yis2VUU3?=
 =?utf-8?B?c2xudjVwVmZvS29jTHUrNk5wRFpEN0swNnllMDN5V0lIaSt5a243QjlsS1lS?=
 =?utf-8?B?ajZuMUJGb09BYW9kU0EvOXJHNWxTanRWL1BrTzBQQjdXeWl4K1dTL0lUNm9w?=
 =?utf-8?B?SmVESExTdnhpQ0xwcDZrZWltOFUrVW84Z25ZMUkrR2ttZEpTUnRyLzQ1QzJa?=
 =?utf-8?B?OUFJQWIxZGh1QlZ3OVVEbyt4T2dRbURoaS8wWi8xem8zT0txNksrTUJROW5y?=
 =?utf-8?B?WlhGWGgvZFNoY0N2MjJsMEhCSGRXNEZMN0tMS3NOY0k0NTZrZFJqQlVUTW5S?=
 =?utf-8?B?ZlB3MXlOMkpKKzBQRDlaekR6TGRkQnJWUnVMNkhOTFNmK0lSK2JjMGJZQkZK?=
 =?utf-8?B?L3M1ZjJOVDJUVndKY3pxR1o1Q2tvVjJkVU5JUFlsR21oeHVFQUxEQXBEYmxi?=
 =?utf-8?B?ZlJGVDhzYVdLVVlsa0ZlK0RPZVNadEpvYU8xL25iRy94cGpDQ1lPSmdYOU9m?=
 =?utf-8?B?cGxFR3lnNjhsaXkrMUt2Q0hlbVlwblUxVE9KZlNDWmorUXptYSt3WDl2ZW0y?=
 =?utf-8?B?cDdiS014dDhYSGNjWTZXMkF4ZmdSaGEvZlZHRnZSb3FvL2xVYjU3cXhvNmNy?=
 =?utf-8?B?NzVyaFVqTmo1RnNHVWkzS2F1bzJwWHh2cGpKTDlZaXBiNmswdWxQZEU5dVdI?=
 =?utf-8?B?QXZqa3VFUzFaU2UwelJrcFVUaFBVVG9PK2xOY2FUYXlHWC9SYlcrSXYzbWhm?=
 =?utf-8?B?Q0xuWkdzNEk0cFFTTFdickxkaDdoQU5mc21uR2hhZnY0UVZPN1h6bGhjd3RN?=
 =?utf-8?B?YWx0Ulh3aC9QTzk2TVdSem03Zk51Wncyc0tLOVVydkhGOU9QUkhVUlh1OWl6?=
 =?utf-8?B?dm1aaVJnbElCb2dnV2l6dFhKVVg4eWIzSkpDU2hsVmNFRUJ5MFFoNG1KNWsy?=
 =?utf-8?Q?6c6kQNDEXIprk3SE4y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7675d0da-f629-4001-90de-08dee20ec030
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:16:51.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dztXRF9nag/7DKgQtg9JFl6r4ydAupw0uE80pq27k6eCPpYyzrR4xhJIzX00NZHB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17812-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:jackmanb@google.com,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B0BD759D6A

On Tue Jul 14, 2026 at 5:32 AM EDT, Brendan Jackman wrote:
> These comments describing the page allocator are out of date:
>
> - __alloc_pages() is no longer a public API and has no business being
>   described outside of mm/.
>
> - The `wait` variable is gone.
>
> It may be out of date for other reasons too but this patch is just
> fixing the issues that stood out.
>
> To fix it:
>
> - Instead of referring to a specific function, instead to "the page
>   allocator"
>
> - Completely drop out-of-date details of that function's internal
>   behaviour, since they were irrelevant anyway.
>
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Link: https://lore.kernel.org/all/DJP11T5V7BDW.2FZZZ8R6LOY4I@nvidia.com/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  kernel/cgroup/cpuset.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
Thank you for updating the doc.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi


