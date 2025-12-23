Return-Path: <cgroups+bounces-12607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B3CD8CA0
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD21E300E806
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CBB357A33;
	Tue, 23 Dec 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ivkTU+ly"
X-Original-To: cgroups@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022107.outbound.protection.outlook.com [52.101.66.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8623612FB;
	Tue, 23 Dec 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485588; cv=fail; b=Z+TwNgFYIK5QxwMKzj6fxjbzevepr2NMw47v6X/rGMmafSnBg2W2FHwYlvqfjBr523jp5zJrUasSiTE1HNkfH4yWVcf14oO5ZfSvejcorWn0RvemQ0jW7Zb81gAsJE8w+tG1/3LS9fslm+gj6iZuBsNuOUn8J1AzGDib97s1Ejk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485588; c=relaxed/simple;
	bh=5ycFLKF8eDr/fy88E++8lEgBWk4n7mR26KX/e5UDOFc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OBaYzsc6xDmWmnwVcCIF4WY+RFBRRCVtJO+UQ06BM4FQIwayV+GTSczTcbRi3xoYMb99n7husz92OX7sjA90GwlACR/joOxnF8T/W34OqfAw4wANLyHJouqnfZp7+ZhCS3UcS6GYKZMWp0C0FcrmWhIW5khhN0cEorxoP69OSS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=ivkTU+ly; arc=fail smtp.client-ip=52.101.66.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOtF/H9Nt7yU6wAxJrXUwB46YJQVKaKr6m+2+4Zl28p0ImLvYwNVbAUfhbO/mAcaFo1rODFlWopV1ECoqi4PnlD2OjxBfDcNBXaRIUVk1aCREVxwy5YWY8pYnDLtGqkvmqHYs3eOZ+yvR0pYWjFirtIbLAgGFR4MHpYUpypRX60RV6wBzTrGDCIupRh5uyrwT9vendbldcXCAs/kCetCyxmotHbxxtas8chmHo0Bn/pMzYvlG1XCQQ8R15M+2H0RGWm8btNl/oYPFiYPa0dMknu4wtmfbBsSHPGpEZ42m32oCqRKWHv7n0530yd8Tl8Lp+vQ1wyn+OZI387bowcMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kjVW1KoI2X3SsBsnWnrhAnVHy2lc2X6IOX0ACkLMfw=;
 b=BkvxQTjm/X8g09aye/1A/cXAlrgsxNxWD2ZkqnOs9ueOwpZ1rAnhjqhK460bzTaZpx0KziRt6QgNBFXKeht+VR/ELZDq+2JNA2T3CChdm1QVhd9aEyJgfwPPh6AKO0mqdMH4EmiCMgSmSqzD2kGSDQ1I+FSpSh3LVMciGX7Db0X4YwhVQrgpvYu0Ve2rERj/B9aUYcw/+ja3RFMpg0I6foXFfBonGndoFqUj9yUG7DnGaa7wJAsEFrIafEq3xI3WKf3fyqolyJgJxStY0wkOIQWtPfdvGDn83HcztT+UFFc92fMlVdwcBL73qX8CRmEZrWQMIOkWxFQd3hwns4IcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kjVW1KoI2X3SsBsnWnrhAnVHy2lc2X6IOX0ACkLMfw=;
 b=ivkTU+lyMy/EJf2Oq7Ri5Da4BWE466hIBtiLu+Lg14cycabKg1yjxWXhRH8mQDH0FpANkUutcqwjMKqj4FyM0Hh0EaeqZO0Wqua199gtUR0gDVl5OH0AodqylXcv4+UyoRwarBQBwSGorzL3dzLZjPLtNnodQ07G+Q67gCEHKq6hG/W5GaI9F4CRFFC191FGO1zItQ8Qvo+ZXcKDcer6CK9u3w668EnpD/lmL95uJFPutYQ6Ap1hctKUYjMSEAZvuE1p2aI70JP9xK4zumu0UQPL5AloxoBSxbFMLVhPSl3g5s5tpF7zISUf2epk8XNeubc4NhQVsiCuACCw5czxKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM8PR08MB5569.eurprd08.prod.outlook.com (2603:10a6:20b:1de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 10:26:22 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 10:26:22 +0000
Message-ID: <41787594-3571-4938-a3d5-fdd20587f6ca@virtuozzo.com>
Date: Tue, 23 Dec 2025 18:25:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup-v2/freezer: allow freezing with kthreads
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
 <20251223102124.738818-2-ptikhomirov@virtuozzo.com>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20251223102124.738818-2-ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:820:c::14) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM8PR08MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f610946-ca24-42f8-a468-08de420db7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnJHZGlqa2I2R1RCNTVnYWFuaGgyL1RVNmI2cEtYQ080WWVGdTVCUlBZY0ZE?=
 =?utf-8?B?V3J1a1g3bVdjNnQxcm5kZVI4NUNuRkFBQnpnTUhhc1NvRFkrVWdQOWN5aUgy?=
 =?utf-8?B?cmhCb0xkckVqbTJiY2dKTW0zTmE1Um1JT3dYUnp2OGJ6L1pFb1pNbTdlejVk?=
 =?utf-8?B?QTVqeDFzcTZydmZMK3E5UUtNcEQrK3NwOVNCOVdrbDZJa0l0VnRBc0J1SThP?=
 =?utf-8?B?TjRVZ0x5YndVUmZIalZ1MmJmZG9GUVdLRHY4RnVqYm42NUt1TkJOczlISHZH?=
 =?utf-8?B?MjNuQ3c5YmpMcFB1RWkzNE9LZHg3QXpWcmNGSUN2WXJxOFdiN2xOeXlOcHRt?=
 =?utf-8?B?MjR3Qm9OeTQ5VitEZDBQWDhzREZOWERQTUg3ZVlseXRieHhtQkFPbmdCMmw1?=
 =?utf-8?B?Q2ZXR2JXNTVlM2cvOU9xUCtreHowQkRKdmZrSzlBNkpoQk5Bbnl0Ty82RU94?=
 =?utf-8?B?MmtqVVdxaThIUTRMdG1QdkFZendMeDR4dE5aUjFqZTJLbUM5RTNKTFFRZHp3?=
 =?utf-8?B?cU5IME41RmY2WHVoVVA0alU1bmw4eFN6MTh1Zk4zRlV5RGZqRWRpUEFka1Z6?=
 =?utf-8?B?RUw2QjlqaDlPRzdTbHIvOWQ5aktmd1Zwb3VUT1NHdWROZG8rdWpKSnAyZitY?=
 =?utf-8?B?QWhPcUJtWGU5ajhCa0VMN24zNDRZV3YvRXlHd3FLeVRRcXJMZUt5cDVHZzI5?=
 =?utf-8?B?ZG9mNTVLeVV6Ny8wdjU2Z2RZTnpIZDFRSHh4d0FneTdJMFpUQWlpTitESjQv?=
 =?utf-8?B?aTcweWRWRHZ4VGg0OVg1WWZCVVJOOW45VFFJMm5OQ1haMjR2dDM5eS9HcnFV?=
 =?utf-8?B?ekJUMjBwQnlyeVd6Slp4T2ljaXZHa2h4eHRsSlNQTURwbTN5UGUwaTRZWXZG?=
 =?utf-8?B?Zmh5UndpZjRMVC9DRzUxaHZHeFVzN3NwbXdLQ3JlUXFpMXBLcmRZdFZRV0d4?=
 =?utf-8?B?dnJlRm1lRHJSU1dlWWlleGYydE1KQTNWZ1JOU0dkVG5hbmdiRWxLTzlSL2Jn?=
 =?utf-8?B?Zm1XYXJqVDN3VnhOY3YyK21PWENDeEJseW9qREN1LzVLUHZZL3BGcmxjSEM3?=
 =?utf-8?B?dzdtWXVtWlovaWFOOXc5YTBCcTVLRlNEL0VBYUplQ3A1L3lFbTB6ODliYjla?=
 =?utf-8?B?cjdnaGpNT2t6VnZmWWlTQXVlaHBJRjhhNWl1Nm1RTjk1UTRlYVFzckpBNG02?=
 =?utf-8?B?K3VXQlk2NHpNRFVzb2Z1LzBzb3pOWmM0WDBZTjU2YUF2VXRVRzdBRjNDNVlM?=
 =?utf-8?B?MTRDZytoY3BuN1RKMGZhbnFDSlUwaGtRc01jTVpFbUcrSUdzT2tRRXA2RkVs?=
 =?utf-8?B?QXNXSHg0V1RZZ0VlUWowQ1daZUpmS0NkN0FrV0d1Z3VRNzFhNkRBcFAxZXp4?=
 =?utf-8?B?YXd4N2NsYWZPak9qaGExTGsrbzNiY3IvYUhDUThkZEtzQXExSE5HWmQ3R1Z5?=
 =?utf-8?B?R0RKak9Na2VzZU40RE54cHJ0SEdBVDNJczk5bktubVVYbXZlL3J0N2FFWFM2?=
 =?utf-8?B?RkoxOGlwaXVYMHEvam40UjJsMC96REh4QjBVNDdZYlVVWEpnYXZUc3pZRVB5?=
 =?utf-8?B?UTh4R0JrTFpla05kUGNNWTM5MUxVeXV4b2ZZYk5nQWF4RmkxQW54ZFNjcUhN?=
 =?utf-8?B?V0JlMzArb25sLys4Q212UEtMMzFNV1EzV0RrdEx4UDJYbEdUM3F6UHJKRGtJ?=
 =?utf-8?B?SVl1VFBzcWU4Wk5FejBZaWVUYlYzeTcvNGZaWkRNQ1MyOVY2UmRnQmZUc1lj?=
 =?utf-8?B?YnBtQ3RwNzFSUG9Vc1V1a0EyNFZLaENCaks2TkhIcUdGSEVxbUUrVnlrd1FN?=
 =?utf-8?B?Z0hsY3V5YThQQjJHbVlxMXZvd01oRTFjNSs2S3YzSGR4K2lGT2xHZDhaZldC?=
 =?utf-8?B?Q1NKNjdQQTgzelNleE5DR0xVbmp5SWlCYWRuUjY4b1RVaW5pR0NlTjNPcTh4?=
 =?utf-8?Q?epzuuOEdZeUfQz48KC0VTL4BcPym5iZv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1dCYWZkTXpOOGFrbWZRSzVxUmRxUHhBcnVHcnBOLzZZRkhRMDBvdUNmL1FQ?=
 =?utf-8?B?eW9LaUd6WlBBOFBmTTIrSENBczN0bWN5cVhuRXltRytxajhTbUZqdHBrZzFu?=
 =?utf-8?B?bXpnK20ybGVTaGZaUHdXeGxDdzVOS2RGclBRVzlueXltSk1XK0UvaXo0MVRJ?=
 =?utf-8?B?TFZCc2lBb2NGK2xIVzZ6RlUvRXk5NG1Dd3NBSTM4OWUwLzc2cUFkL3hpV2oz?=
 =?utf-8?B?eXZ5Mjh2Y0ZTREM3Y243TmlhQW9rU3BkQ01TYVRvSzFuSUM2NTlDaEwydFVI?=
 =?utf-8?B?bk9FRGtJc01xRnJzUXEyZjBkdWpNcE92a0ZTM3F1YnpheVkwQ1YycmpFY2w2?=
 =?utf-8?B?QXpVSDlWSE5GOE1RNmN6c3piSDJOeVRmalNMblRvS1p2TnozYXNBOCtPYnlU?=
 =?utf-8?B?aTBZcWFIamlVbVN0TkdlUCtKWXhiK0FXcGRsc3F1VFhGZEZOMnNEcFkxTDhF?=
 =?utf-8?B?bzVVaXZXenhuRHlzQzR1dE4zTHlFNHRtamkzQmVsTTh1TFUxTWhKYTRoMGND?=
 =?utf-8?B?WDF5RjFxRGxHNmJTQmNmYmtFSnRYSWFOb3EyOVM3N1pGZjVpazNFUEcrRVAy?=
 =?utf-8?B?YTlqamxEdWNEWW0xQXBRcG9uRkJvOVdHUkdLT0RkN1Jra2dCR1dwN1V0czVS?=
 =?utf-8?B?dXZBQ05CUjhycGszWC8yM3VxNnlNS0tvVEt5b3dicDI3VzFnQTJGZkxLOTBR?=
 =?utf-8?B?Rm1IVE1IWkd5M2k5eEdpTmYrUzBQVTlqdGdBblpnWER4OHpSY2VKblEyZDQz?=
 =?utf-8?B?WHY2VENaYWhIU2YyWXhOTnlIKy8yTXhyckhvSUtHT2g3UHN4QnkvY2dBY1Rw?=
 =?utf-8?B?NjVXTjhGMHhsYlJsbVBFRlg2L094eUEyS3lkMnFjZDBrYVBoaEkraS9qcVhr?=
 =?utf-8?B?OW1CbENoZG8yWkxQa2RwMThsYUZnanhXYnlGWWhXZUZ1M2szZG5LNmg3WWZt?=
 =?utf-8?B?TTBya0ZzMGd6QXQ2TU12T1dxam9qZTA0T3hoTlhSOFI3ZFJsYnRzSko4WERo?=
 =?utf-8?B?OHNKY0Y0NEw1MWVwcE1qMVI5WU9iRXFmN2dUVStsRmZiZzRoYUJnZlF2c1R0?=
 =?utf-8?B?bW9zMi9UREVPbzVjRlFTcUZzM3ZneHhNSmgwNzdXTlkvbUpxT3lMTzFVWExz?=
 =?utf-8?B?N0ZialY0VUJZb3NwVUJVVlRnQjBIMEgxUXYyU3d4NkRpSUpmdjA0VGdRUG5s?=
 =?utf-8?B?RTlEMWk0bnRwN1pkZ0l3UmJEK2gwVU5mdlhFVWFXNWVOVGJEMDFyUkpHV3d3?=
 =?utf-8?B?cTBNTGFPUFkxNmM4dWdMKzZnQTRlMnI4R3Q2RXdHQldEK1NuRFk5K0Y0V1c5?=
 =?utf-8?B?VmJObXJBaCt0THcybzBWaW5FQXR2ekc3ZkYwd0dhTUhZdzRzdlVsSm9DZW54?=
 =?utf-8?B?akpuUUFaT3VYcDNUQkJHcUhEZklpN0RRYWNUbzJVR2RIQXJTUEpDVmJiRTg1?=
 =?utf-8?B?Qm9oelVTZUNlRVZTQWpDTXkvWE92cENLdGJoSDNsZFFabisyY2lEZ09YLysr?=
 =?utf-8?B?S1FjbEdGNVRyWG92SVpHVkdCMDI4bjM2U3JKUmR5TFdKNlpGZ0luTktaS2Fl?=
 =?utf-8?B?WE9tRVdQeDc2Nk1YRVY4YVppcllUa2FrNGVZVVRIbnE4UFMvb2tkelBzTzZk?=
 =?utf-8?B?Q0hpUktVRDlybXZ5cllUS1llVUxUdVNvbWtlYTQ5RjNmOEFRbGdkRnZMMUJF?=
 =?utf-8?B?cmNKMjJHZCswRlk4TFVWSUdSM2FYYVlMNW9CUU93T0UxeHNsblhjWVdUUU1N?=
 =?utf-8?B?U0RLOGtmbEJWaE9nb0NTTWR4eE9BMjFyQ0VjL3U1K0t6R01HVnpXdWdsMysz?=
 =?utf-8?B?VWZ2bU5NS3NnSHg2ZlNGTnZrTVY0QW9Fa3R6K3V6bCt1VUxzSllnRFROQytP?=
 =?utf-8?B?SmlncVl1UWV4dFdFQlFvUXdkRG5Dc0JhK09jWVhpRUpoeFNHcy9lbEd5cm91?=
 =?utf-8?B?VEFWQjlBL1N5MXptTnBDOWtPbWxjeDdpd3lWVEs4YUhtbGgwOFRIQzE3emlE?=
 =?utf-8?B?U3J4UlJJWWpIRnczUXFyQ0tSS2hmbTBScnZnbjRjM2RUb1ZIaFdhQW10bGc1?=
 =?utf-8?B?K3dseVFXM24zNUN4Uks3d1V5bTlJN1R4Rm15aTJZOVY2aDB1dEtIdUtHUzlZ?=
 =?utf-8?B?Kyt4WllFaStrSTloenJxM0pQWERDd250TFMzOW1jM3hpOUxiMnFsOHZmZEYw?=
 =?utf-8?B?RjdSanZZNEc0SWUvbGEyaTVrclJEZU1OV3dHQngyMGs3ZzNONDhxdDhqWlVw?=
 =?utf-8?B?RnIvdmxmbjFXQzlPRTl0R1d6bUs3TmhFR1Foc0FXdHpCc1lZbGgxemtCcnpE?=
 =?utf-8?B?SXFCWkdQdThmM2UrQ1BHM1dtcXFVaWk3NlNGbTJsOW5oK1o2YU5PczhaeVJL?=
 =?utf-8?Q?adFk+wgHsg+e4qwPnSgiOlvSR7rz9xNcDlerdk9Xbc5S5?=
X-MS-Exchange-AntiSpam-MessageData-1: bjnddcsWuuUJhnKu4E0hFDP9YnDtNIjNYu8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f610946-ca24-42f8-a468-08de420db7ed
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 10:26:22.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z/FWSsjsK+2HnTKU3dQc0iQJSvG9JhrVloagZSasEUzWhz+fnuHK58juOgX8K4lZ7a6VKcwDQkWmzM7LSz70QCMb8T1sGObU4Ul2bX4kbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5569

This one is accidental, please ignore.

On 12/23/25 18:20, Pavel Tikhomirov wrote:
> Cgroup-v2 implementation of freezer ignores kernel threads, but still
> counts them against nr_frozen_tasks. So the cgroup with kthread inside
> will never report frozen.
> 
> It might be generally beneficial to put kthreads into cgroups. One
> example is vhost-xxx kthreads used for qemu virtual machines, those are
> already put into cgroups of their virtual machine. This way they can be
> restricted by the same limits the instance they belong to is.
> 
> To make the cgroups with kthreads freezable, let's count the number of
> kthreads in each cgroup when it is freezing, and offset nr_frozen_tasks
> checks with it. This way we can ignore kthreads completely and report
> cgroup frozen when all non-kthread tasks are frozen.
> 
> Note: The nr_kthreads_ignore is protected with css_set_lock. And it is
> zero unless cgroup is freezing.
> Note2: This restores parity with cgroup-v1 freezer behavior, which
> already ignored kthreads when counting frozen tasks.
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  include/linux/cgroup-defs.h |  5 +++++
>  kernel/cgroup/freezer.c     | 37 +++++++++++++++++++++++++++++++------
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index b760a3c470a5..949f80dc33c5 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -451,6 +451,11 @@ struct cgroup_freezer_state {
>  	 */
>  	int nr_frozen_tasks;
>  
> +	/*
> +	 * Number of kernel threads to ignore while freezing
> +	 */
> +	int nr_kthreads_ignore;
> +
>  	/* Freeze time data consistency protection */
>  	seqcount_spinlock_t freeze_seq;
>  
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index 6c18854bff34..02a1db180b70 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -73,7 +73,8 @@ void cgroup_update_frozen(struct cgroup *cgrp)
>  	 * the cgroup frozen. Otherwise it's not frozen.
>  	 */
>  	frozen = test_bit(CGRP_FREEZE, &cgrp->flags) &&
> -		cgrp->freezer.nr_frozen_tasks == __cgroup_task_count(cgrp);
> +		 (cgrp->freezer.nr_frozen_tasks +
> +		  cgrp->freezer.nr_kthreads_ignore == __cgroup_task_count(cgrp));
>  
>  	/* If flags is updated, update the state of ancestor cgroups. */
>  	if (cgroup_update_frozen_flag(cgrp, frozen))
> @@ -145,6 +146,17 @@ void cgroup_leave_frozen(bool always_leave)
>  	spin_unlock_irq(&css_set_lock);
>  }
>  
> +static inline void cgroup_inc_kthread_ignore_cnt(struct cgroup *cgrp)
> +{
> +	cgrp->freezer.nr_kthreads_ignore++;
> +}
> +
> +static inline void cgroup_dec_kthread_ignore_cnt(struct cgroup *cgrp)
> +{
> +	cgrp->freezer.nr_kthreads_ignore--;
> +	WARN_ON_ONCE(cgrp->freezer.nr_kthreads_ignore < 0);
> +}
> +
>  /*
>   * Freeze or unfreeze the task by setting or clearing the JOBCTL_TRAP_FREEZE
>   * jobctl bit.
> @@ -199,11 +211,15 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze, u64 ts_nsec)
>  	css_task_iter_start(&cgrp->self, 0, &it);
>  	while ((task = css_task_iter_next(&it))) {
>  		/*
> -		 * Ignore kernel threads here. Freezing cgroups containing
> -		 * kthreads isn't supported.
> +		 * Count kernel threads to ignore them during freezing.
>  		 */
> -		if (task->flags & PF_KTHREAD)
> +		if (task->flags & PF_KTHREAD) {
> +			if (freeze)
> +				cgroup_inc_kthread_ignore_cnt(cgrp);
> +			else
> +				cgroup_dec_kthread_ignore_cnt(cgrp);
>  			continue;
> +		}
>  		cgroup_freeze_task(task, freeze);
>  	}
>  	css_task_iter_end(&it);
> @@ -228,10 +244,19 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
>  	lockdep_assert_held(&css_set_lock);
>  
>  	/*
> -	 * Kernel threads are not supposed to be frozen at all.
> +	 * Kernel threads are not supposed to be frozen at all, but we need to
> +	 * count them in order to properly ignore.
>  	 */
> -	if (task->flags & PF_KTHREAD)
> +	if (task->flags & PF_KTHREAD) {
> +		if (test_bit(CGRP_FREEZE, &dst->flags))
> +			cgroup_inc_kthread_ignore_cnt(dst);
> +		if (test_bit(CGRP_FREEZE, &src->flags))
> +			cgroup_dec_kthread_ignore_cnt(src);
> +
> +		cgroup_update_frozen(dst);
> +		cgroup_update_frozen(src);
>  		return;
> +	}
>  
>  	/*
>  	 * It's not necessary to do changes if both of the src and dst cgroups

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


