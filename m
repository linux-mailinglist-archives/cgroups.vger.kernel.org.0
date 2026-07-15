Return-Path: <cgroups+bounces-17811-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A6IHNljfVmrhCAEAu9opvQ
	(envelope-from <cgroups+bounces-17811-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:16:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 346DC759D37
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:16:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=M3mxe0RY;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17811-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17811-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78146306C211
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 01:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DC23542F6;
	Wed, 15 Jul 2026 01:15:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550633C194;
	Wed, 15 Jul 2026 01:15:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078122; cv=fail; b=oyJMLvZ6ReJd0jmGcZXaiKjD3h2+pbAHZ7+QgdoXT03KxJyt4dIvkQVLmeDqcij+hq7ENpL57KDzB/ZYwUo3AaC27axZGTz8oePwT16wshY7cyCXR0QomY+Kl1wmg0358uiUiloWbmEymwv6aUUj46IvDJCn96+iwWPmLB3cZSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078122; c=relaxed/simple;
	bh=JaU8cAIc5D8TX88Xn/Y5ZFZOnQ1YsS8QSUjZ57pYxEQ=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=rOyHmEQIiHtUc3kVdnC1SNE9UikHP7mGJQA+yKgbWjWD3bQR3lQJylIlAW+m345oJeJytv4fYUHqhrSFwmwAOktxnACSf5wKn74c9DRMJqLbt8jcn4I/Yl2Opu0OgOdWzS4hqYVXwrQ5nePsa3pZTS+LVI2TW93kVaHxqja24/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3mxe0RY; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvWJFBW4urquaW7jPErIEhQRTjv/+Ct13pvzU70lB3wavm7wX/md673C0Vzh0y0/HRP/hks+XOaRf9qevaIwGL6hIlA2NQle0sb6eqeSRuoe4Y3G5X2IB5lcPZ2WkmJemtc+dK/HpPdcTE3eeVyYkeEqdGmGiiVaQTtzmbdSGIviJjWov0c9J2V19oD5r+5rv8huX9cBZIjT8O4uQsyJA2g/RXTUv1ghRiFEi7WgJR/UAze/dmxHfqyfrvdAkQN0UAzq4uBWEcRkyLJ5qrM1coA4afBUorRnvdgWxzfH9+ph6MSRDdBtsF5SGvW8JZ7FEMTgH6bWLpfUzB6gH/aNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d58cLEwT5S8YdO6oKhlDJOhN0OeN/q52WGaF4PDwQ5Y=;
 b=iGx6pherJeTZCk6okgrgWtHITSSTDWREiwWqHge+thS6O6+lCPdNOpmB+DZp72Zx8Otp6QaCFFQf0AmgnUcyU4mpduszpQhHmJxnEUlmxeUatEzN/hYSkaf3L+TkpWMwKnDKYI0ZLMXW6Poe4MqKG5e7/jTo9qSR+jab/YS07wRC1RYHPs+C59i1VJ1h5swIjWho8juQVB6EYlLSl6nPCv/V4AjfzMIAPpLd2ncoVHuDsIOHi1+/vdN2Tb076qvyB0Aw3Rbt5ECRNW0PZ8kqF3VGYC1/n4PmwkDsJoZ2jBPpjAovqM/xY6gPdjbrI0a7CZtgw1WVNYksDpgXfxOVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d58cLEwT5S8YdO6oKhlDJOhN0OeN/q52WGaF4PDwQ5Y=;
 b=M3mxe0RY7pO9T/MCZaV91HgG9FBkKQtJ0usB/M+FP3VpbQLN2XjmQZB20R+SVSPT0Mz6lWgJ5IJh1Xm/2ZbLj7GZodSP6Vse6hROkNGUKHanL+rI37ctXe/QquQWPmcjo3eHkPae+zAok9h4qH4W55872jiBNIXYlGPT8sYB5WOocYsxdLBkAor31LELPND2XKhac88il0U1KeO2/ZE/uNF0ozRZS3beA1AG+1F/rfZIsDB8fiqHeTOQu6zaa0igbghJliO8j8+emvMQqiQQc2ISDtINgrUw81ttATGNY8P1xsfacJZSZXTRGjCirpycghhBXPLKyiDqxUQdVS5mUw==
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 01:15:17 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:15:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 21:15:16 -0400
Message-Id: <DJYQWS1Q489H.2PE0HYPEX9OQ4@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v2 1/4] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
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
X-Mailer: aerc 0.21.0
References: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
 <20260714-spin-trylock-followup-v2-1-3c20ed032b14@google.com>
In-Reply-To: <20260714-spin-trylock-followup-v2-1-3c20ed032b14@google.com>
X-ClientProxiedBy: MN2PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:208:238::21) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: f85260d5-8291-42ab-fd2c-08dee20e87fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|56012099006|11063799006|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	CF0DFdNGRBaWn82p4M9ixWygYtSIZL6sVWD9dLjsy4ZXwJD9016GF30i4U4av0HYxLphsaCSEl/hlqQ6sHnZWGZklriGD6qYUgKlp2ttxjvjyIc/OerA5H7znZlP9XsGK/Rqi7mLvEyv35+1v51sbvTyZ7Cjrvh6Vp2K2bNjptRq1aiVr2YjVcqiA4EULvPeq5ZsxrGerZb4CSB656toVEzbEcEiSydzFiFeh2E1wpuI2qAee222fOf/nO8xUZCfuwwvnDg84NrQMLa+XWANjJDCv9JYMQypNRUhC4QMOKjSRQ33XRtnfRActXINAEm9hFtEg8+wjxg3YrEZJFl8QNzvDbeJRhQCj92Q3tQU95rDHjBHBZHDydqdVVCOxyolBT9RuYGb++RqnorEKUth7ZIBj8/lZOE9ICFEZoswmOUIecu36SD3+9NMTQyrYc7Ezv3p7vrDhdLYhfYwEXcKswFSHwQwNWqIyA9auxoMVY6v4LFvFCXASUwQdWH0DizqrKY99CYjIF53Yce8MwSor6meDf6aVm38Htjd0V8KnL2Y+hMYG4sWKdOrsSBacWbZg8I6KISzQ3ZO67zG0W81oznJEZyy64BCPZjERUUeqnLg6YzHeZgwVHKwQFrM6U4/XuxUcVbtxwc5bw8jOgGA3RnWwq1MO2m/kCCvP9ofVvBpooI1MXgo2iBAGaTjithKHOmkSQcImF+QReMc1rupnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU0xUm91ZFFxQis5MkxQR1ZaQ1oxWE9kQjJla01iR0hNQ2VEa0RnVEtOVS9s?=
 =?utf-8?B?TkZjaFQyZTBLclg3c0ZMQmFkcTUwZExvbXY2TlhHOXJJQlhWVHBrT21VRUlW?=
 =?utf-8?B?Q3htTjMxcjdBemIrQ3hkMDFRVlJibUwyUUpJV0c1d2dHVmRNTklpWHhMSHRk?=
 =?utf-8?B?bUJSdi9vQ3pHOFdoUHY3L3ZSeW82YVlkQ21mMGxlMVRGdnByclRqSDl0YVha?=
 =?utf-8?B?OFZ3U1p6cW1CemRmSE4zcXdiNm1ORnYrK2lscVRLVi9yR2NXVlJKd0puaUhO?=
 =?utf-8?B?RGhMNkxqZXMwK1U5bWtzZndwREFxUkl5VXBtdW1JaTNUN25JSUlzZ0FVelN4?=
 =?utf-8?B?di9YVjFocVRRdGtyRWRrajl0Snh4VUtUamY0VG5Gd0dQalgwRHVUdFJWeGlT?=
 =?utf-8?B?T1Y5Mmd2blp5T2toZUN4a3NKcTUzR0YzM1E4U3JmQ0dlMmp2VlpwdVRqcUUy?=
 =?utf-8?B?dExCT2V0SjUrbXlMRTZLZ0hVWWNaQWJ4eG45SFRPTWRURWdOY25XbWZPSWhO?=
 =?utf-8?B?cG9MRnlleU1EQ2FOemlvTXlDdFNRYTNaeFB4SkNxS1prbGlnMHpkTmlKNnJz?=
 =?utf-8?B?L2Y0WWlpWWh2ejZEZFZ4cGNXZVJLZXNUS1B5TlBQMTkrcDJhb1MwQ2liVm4v?=
 =?utf-8?B?NGIzZmg3SEpMazRnSjAwTnk3U1pCRFFoTU5wRFJKeDA5bG9kS1VBSHFCaUFu?=
 =?utf-8?B?MnR2YjN3ZUpFNGNjeWRFNGowQkZaYm1OdmZzcTdsOGsvcXE5UEsyc21mVkp1?=
 =?utf-8?B?WVFHdXhpQ0FkZ05HZVUxY1l0WDV1bGorM0c3cGlUNzZzcmltN0sycU1FaGhI?=
 =?utf-8?B?K0dkS0lOZkNQU1JzbWtCT3lZZEtHdW9xUTJkc1NVYWdYcDJxN3BBMG9wYVZT?=
 =?utf-8?B?NTBUSUVmajdIemMrQ1BZRDk2cVMvNXlpd3o5WkFJdGdJYkh5Tk5VcjZFakR0?=
 =?utf-8?B?QzNVclpSbUNYbkJaWTJUVlZ4U1NGWElSM2xNeng5dnRGenYxSHJjc2xIcjBX?=
 =?utf-8?B?OW1palNpVHhGbE1YVU9IS0EwTVNudDNYVmZEM2xvbWw0ekUzVXJ5NjNYbXhn?=
 =?utf-8?B?dlJIN29weXl1MVRObGx2R2t3OTBoU2E3Rm5ZVG1PazJPNGdYMThVZmNnMzFz?=
 =?utf-8?B?ZkF3TU9oeHZGS0c0cHBvcXlUcjdiTDNGWXcyVFVTbGswRFNLbjgrMWlsTTM3?=
 =?utf-8?B?YkNVRmExSkorWStNUkVTWFBSdGNMZWN0ek1HNG9aWGpKYy80NDBIUThhd21o?=
 =?utf-8?B?dW4wQVZVcVVQdVR6WE0vMjdqWWc3Wk5jdHJGRDJTRU9vb3FxWm1MdW5xcnpV?=
 =?utf-8?B?KzdzT1dqNnVmWWxCV3FWanh5TlFzazJQNWxzS3VVeEYxTVlYakpDTnZFU0Vl?=
 =?utf-8?B?VHQ4Tk9DcXY2Y3doMDFSc1NvSDZ1R3ZUbTIyRnBuT0ZQNmNRRHlxei9Yd1VL?=
 =?utf-8?B?TjZUblJpWVZGakZpQWlWNGprUVVxK3V5QTNmQWV4UUZpQXhGM2FqNlIwVXNZ?=
 =?utf-8?B?MTNVZGQ2YXdLVE1BYWthU2tkT2xDRGVxYjYzbWFuQndPZ2NLOEg1VllYT1BN?=
 =?utf-8?B?djRRbW90WVhjNTI5MmRkOUVQVVhDd0FMRG9EekF1cjZiZVRMNjRGTmJWcGN6?=
 =?utf-8?B?RGZRSkNOeGgwUG5tUUNUZWVLKzJ2SXFxZENIeForSmVUYm5uV1FiTW5Jbmtq?=
 =?utf-8?B?SGpkL2NLOGZodi94YUpqVmdyNFlKeXRoeTlFaGpESXNzeFhhdTY3bWlTemJQ?=
 =?utf-8?B?S1JOVzdmZU9ZRC9rL2VGcms4S2RtdGM4YTJpdlZPdEYzUEtWRFNTTTJLSWlD?=
 =?utf-8?B?Wit5ZXpSRERtSUliSjBwbkxqMTdzdmV5NTh1bFdzVUs1YnpuRWxYc0ZNRFZz?=
 =?utf-8?B?ejNHbTkrQzd2Wkw0NndSTXNTRUQreGFnZU9VQjV0cEdEcS9kaVRKY3FFbzBL?=
 =?utf-8?B?VUVLR2lUanV6bUdvNGRKQ0JvMXlMa09CYWYzL2JSWXdJaVV5UHViQzlmOUp5?=
 =?utf-8?B?UE9QN3p3MFR3WFVCZk1BOWdZUXR4WjlidHE2aXBORjJmdDR3OVQ5L01mZllM?=
 =?utf-8?B?K2RKL1lxVFlyQkdnRm82M2IrS20wTmZWY1VLN3NFcFFOaGxDbFduSGUvanFU?=
 =?utf-8?B?ZWhTZ1dYZGRtL0ZDNUtBbXp6YXBaUEkvVEprUEc1dVBhZFdRbUIyT3NoMmZi?=
 =?utf-8?B?aHBhM3RQSzc0cUVPeDdNV0J6R0JhSDRiZ2FhY3FxZ3VocU5HSDVtQWl5elNU?=
 =?utf-8?B?KzhmT0c2M0o2cno5Vi80K2xKdzQ0a1R6bGNDcWZOYm1BWFk3OWlFSWsvcVhn?=
 =?utf-8?Q?5xvH5zb/5Tiz8Mn69Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85260d5-8291-42ab-fd2c-08dee20e87fe
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:15:17.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bI9VnfmH5CJXfpmOdALNhD19aIBhRiJL6rBknOliMVbl8Fz/Xa5avJOIasf8UXuJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17811-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:jackmanb@google.com,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 346DC759D37

On Tue Jul 14, 2026 at 5:31 AM EDT, Brendan Jackman wrote:
> As discussed in the linked patch, the there is some inconsistency between
> "trylock" and "nolock" nomenclature, let's align it. Since "nolock" is
> used in the public API it seems to have more mindshare so do that.
>
> The linked patch did this for the ALLOC_ flag but forgot about FPI_.
>
> Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714e19d=
3@google.com/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/page_alloc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi


