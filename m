Return-Path: <cgroups+bounces-12791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37C8CE612F
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 08:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D83C3004D25
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821152D24A7;
	Mon, 29 Dec 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EyeBRxC5"
X-Original-To: cgroups@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021111.outbound.protection.outlook.com [52.101.70.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD92D23B6;
	Mon, 29 Dec 2025 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766991943; cv=fail; b=H8FhOOL5B1bzlkSjYFUIOdvatbwJEgMWZFWhzMyzvqyoN3K8B3BG9G1NgX9fdvbtnpG/2tmYsjhT2IFgn1x9lzG85+5ykhzSkC7OSoDU08nDr5cIancLZRpq6GZG/GLdcA+K8bdH41/zHMKPAmPiTm/1boYn5JxArRDzU9f0/co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766991943; c=relaxed/simple;
	bh=7UzYiQf3lUpxzXPolLqZxaXnyNYglsYXj1ipUm6vaY0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YCjVFvYWbBTBzV2RsF6KW2Y1NsRvMhD1uLsrMiQ5zuRbsPflgc+0+6JDttx00KIA6OSFoci9wnqLT8MJYWnqvVZd1riFHeWTCBb6ytm2/VUQB49XDYyzC7KEjEqHIYPV3Hs6g3xpmc7sTVQBCsCQK7IrRaOw8UtGtyQSG1/N1fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=EyeBRxC5; arc=fail smtp.client-ip=52.101.70.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrjfOMUkLFVNcCVRDdtvYFwc+7Yia4J/JRD2sq9zX5QOZMaw539KOXJzX1fN4JHD+57oehCgo4cBB9K8XTjLyYkuFkU5/xz91+QVmXd7qkKgKBcqRABuFrQ9NHrk5WCTy3nqzZwGsIeqFDTewblUbYs6zZUHOLXbcRKE2nWoix478n9IJMskuzYl6JcZmuOim0WyPnaZg8LXJFfhxHca3L0bK+ARpFwpScmr6ZiteEmNNcR5gUYK6YsboNiK63+JKA8wJNCIgth9Y7Sh4E+5DqXYRtiJ7J2Ls6L3eVJgSlYDu7NKOE3/njGAwzfa2HLIDjPXQFvujqfb2xNdHmSMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL2P8dnOWE98ACCSRgnHJ6zLXMDe/vSMCESoGFJ1J/Q=;
 b=ZepHGBnGbtWzeu1PajOrnBrpV865/fC5/HaaWADNutuiEkzZgvz/tjEP8yNrZ+B7P4dXnyrKDRHC8OkMp774yUNeeqddBReWncKtGEvlgZ59YsGGyz7ZBz4vba0hL6yBVFQuabuTkbOQPCDF3pjd1F8QMxPjBjhaBxFQE336XZiGUnUFsTmpEkhP9S+OelukayHGdmd3xGIwTPZtXLxDz7cKAxqm+vyWCGHqt22cNsMFPehIk28GpPf00wkGMfiT2pl1Zorh5K/bz2+Yt/QuizXoYpIfqDAue59cisW6cxJPkxUdslSUReIMqC56vY7+SnniKxc32niS/8yxHg6UXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL2P8dnOWE98ACCSRgnHJ6zLXMDe/vSMCESoGFJ1J/Q=;
 b=EyeBRxC5Mk3zi4pcm1jeWDzTlwfX9beDyG2sJFummztXHSSWvYhmR/VHBX9DeI1G4UT1wb47EKjdizP84VRLi80B6ASqgAXZvf7ukCXoVNAP6A3jrrBE3ZrXqZdqJDXHjb5Wla3WJX03STh28uJSv9PtvDX7v54psiFUOd6NG1AFGRT+fLxoLS43tg3y5eKZa9kQQY66PbkO4u7FTXst7XwI/W2nNQP4yBDmvpdpDPzkTrkNNSeyX8TxW69ykPo41RtgRhPXf3bQNYOwPjxN+0Ze5iQ4Z5ruLc+ng+Rh+CUmWoqtFxIYzZjhMjZ9FFc0kcmYthJ1QXi3PGEPq9vZuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PAWPR08MB10994.eurprd08.prod.outlook.com (2603:10a6:102:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 07:05:37 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 07:05:37 +0000
Message-ID: <41e07697-0d59-421e-a121-e6c91a8bf6eb@virtuozzo.com>
Date: Mon, 29 Dec 2025 15:05:28 +0800
User-Agent: Mozilla Thunderbird
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
 <20251223102124.738818-4-ptikhomirov@virtuozzo.com>
 <aVBjDYPQcKEesoKu@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <aVBjDYPQcKEesoKu@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0076.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::6) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PAWPR08MB10994:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3fd313-8459-4818-fbe6-08de46a8ab47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHU3K0JHanY3Z1BqUHFUSktYWHBLUkdHaHA1VXFYdnRhRWt5NWpINlVaeEhm?=
 =?utf-8?B?Qzc5RElQL1VqY3pDQ05Qc1lBSFIzY3c5MDA5TmJ5TnpiUmt4L3FDNzJvZDRI?=
 =?utf-8?B?YUJKK2dzczFjTGdIZTlxOGk2d2NROUVWL0tVaXFLL2FBd0ZaZnkxdERIVVQ0?=
 =?utf-8?B?SVpuNHpjWDlBN2w2c3d3SlRnaFhVK0tEMDNtcXFPazEyWEpXWDNGNjdlNHh1?=
 =?utf-8?B?a3NYMGN4LzlRbm84WmsvUmJOQ1l0SVc5OFZ2V2tPOHhyUXhkSk5idzZjNCt0?=
 =?utf-8?B?VFZJWTNVRUozVU1Xa3hOc0tjazAxSm1ldFpreWRaWFNpWFZEdUZvVXNLcnNh?=
 =?utf-8?B?Zm8zS2lsWGV3dlZBY1dBd2NzOHhOemRUT1E2ZzIrdHNlR0xwYzBNYnl5dVpr?=
 =?utf-8?B?YnlyaUtTaSttUkJPT0JMVlMxaE12ZG03bjB4blcvV0JLUEUrYk9ONFFOOE51?=
 =?utf-8?B?VmorcHkvbjdkbWZtM3Y2NUFoTElCd3c3UmhOMC9wZjZjSVU3Y0JQdzZzWmtx?=
 =?utf-8?B?RURsTGtCdnpFOVNIaEVqZUFtNEVEa2ovZ0wra0Znd3djY01RZFlmcFE3Qnhw?=
 =?utf-8?B?eGtmZTg5NW1ZYk5OeUY0NmMvQVd5bXd0NU13L1g2QmtlSms4ckQ0VFFtMnBR?=
 =?utf-8?B?MjVnVFpqSU43d3BuNVF0RlBaR09FbVBVemxJTFgzeWdKWitpNVNHQkVHSXVB?=
 =?utf-8?B?clZ3aTBoUFhncXhZZEJnSSs0V25HS0pwTThhK1FjWFpQTGVuaTN4SGdjeVlO?=
 =?utf-8?B?dXBuU1B4Szk2Qlh4dVJDRjBnZ2NZQW41SmhzQVoxdGE0bjhCRW00Tk1INmhl?=
 =?utf-8?B?L2lLVHVIT3c4ZmdQVEYxanV0R2pvSjFXUUg1K0N2Umx6c09KRmhCT2JZWFpC?=
 =?utf-8?B?MXZTamRUOXFTaCt1K0VDcndsb2ExTHFteWN3MXlzeEQrN2Z2bUtOTzgwZDFG?=
 =?utf-8?B?alArTjFLcmNIZlMxaC9SWENJSzJ0b1FpSUNpWTVzaEd5TEE1NllxY2J4UGNH?=
 =?utf-8?B?ZkNLVVR0SkkzRVVaYmVZdEVKbTJxTTdxY2pQOGk5RXgxWmNhdk5kQU96Q1hn?=
 =?utf-8?B?aGVtZzZIT043aWNHS3Ivd0IyaUtKWkhEUkNJVTI1MXl4cytTZmZ3Y2xWa21X?=
 =?utf-8?B?NExYc1pDVlAxZVN3SjMvUXRTR2tLTlNUSEZieFljQVhtSy9zTiswUktscXNo?=
 =?utf-8?B?enFheGVZQnQ3Yk5ZOWllcVhGU3RRYzdqM1prcGZhZWwxdlZsQ05mOVJIWXNp?=
 =?utf-8?B?YWtFL2d1N21FR0FTLzN0NHJuSmVrbE9qNE90ZjAxcVVGVEVEbmNydUE1WTBJ?=
 =?utf-8?B?T1h6Y3NkQUF6cUJ4OCtPVW5GYWZpOUU5N0hDeldYVTJVaTU5S2E2bnk5OXp1?=
 =?utf-8?B?VEVnaGNscVR2U0lZUHhaZ2FsVjltcktNTk1nSStKY1RQWXdObUNSODVubWYr?=
 =?utf-8?B?S09UQ0FnTnZ2TllmdE9WZEFaTTJXYTEvczB4RjR4clExeHUwdHQ3bHNiNkky?=
 =?utf-8?B?QndiMFVsR1lxZUpzV2UxVlZhT3RNbjBYZ1cwUk5yeWFTMW45YVErcW1KRzcz?=
 =?utf-8?B?S2w4dEtQUDlqZDJqWnJUdlowRXBQaWtqdTVIanVqc2l3SFBSMkhQczllLzUx?=
 =?utf-8?B?MUJXU2dTeGc3c2tWTEdWOVYxeU95VktBQkdaWUcyckFxeHcxdjF5NlY1TWFB?=
 =?utf-8?B?R0UxWHhqaG00UGZuTXFnNi96cko5VDlkSlJUcVl1VVlzMERPWWtyK0NOVkFX?=
 =?utf-8?B?WllQVGlzTUlod2hTbEhuNTBnQWtwOXBLMWdUTmxSRGx6VWdTVDZWdjFKblps?=
 =?utf-8?B?bW50aFFVRElxdTlQQ3BDTklWaDgycU5pK1c3cU9hRm1jZFpId3VSZFRhTjZa?=
 =?utf-8?B?Q3dtdGJhcTllaWdIMHJOYi9icjUzSUc5WlpFYnlLdFhpRVhNQ0NFOUZlcUl2?=
 =?utf-8?B?U2VUdmQvOGdvNHRHbGVhT1FYY0FzZEYyR2x6UWZvS2NTM2NaRUlVVWlVUkNx?=
 =?utf-8?B?eUFnNlFUeXR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTBZMUtsVExRUHgyMFk0VGM0VGZwSVZZTkVhT3NSMmhYTkhsTmtvNnFPcjlW?=
 =?utf-8?B?VjRJcjlQOU5haEE4b3dkLytMTWYwMjNRK3pGZkVsZnBoYXZmNmJScmk3V1JB?=
 =?utf-8?B?aHVma2xTS1VHcVZmRXhTQlJMYWI4S1o2TW9YcEIwOUR5NUpaUlBSTGM4bVNP?=
 =?utf-8?B?ZmN4RWxFOUdMSHdhNEppZDl2eG4yODdhMDAzL3FVQlJMeUVkRW1WUWxlTVl3?=
 =?utf-8?B?L3BQcHgyeGVYbGZEdm5HYjE2TEJ2OTRKYXJUY1BYcWxWTmgxQy9vVjRaVlJV?=
 =?utf-8?B?TTNsVktYR2hjZUhseU9iM05FOHRPSUlIWDdaRXE2ZWc1VEdDWk13djRva0lW?=
 =?utf-8?B?RlhWaTROcFJVcHFJVGpPWlhTdWhVbmVjS1JxY0swVWJKOUVHZlM3SnliOUFW?=
 =?utf-8?B?VURkZEczemt5emg0QldhRTA4b1VJK2FnQzJWcys0ZjRJeVBza0EvRTQ1Yi85?=
 =?utf-8?B?VHFid21zRjB0QzBRZHc2UGljOTRBakhGZjM5b1FwL2hLcjdMbXZVd3pxejAy?=
 =?utf-8?B?NHlJa0ZTVW55MWtXVXFJQWxwc0Q4L1Jva2RhVHZ1bFdJb0puNE12ZlIxMER4?=
 =?utf-8?B?ZWxubWU4NFI1M2cyWnl2NGJ6NmIyU1RROWpuR0I5Q2FTTzVUWEZNMWZQSm8w?=
 =?utf-8?B?VzNUbk9pelVEYU9ITit2RzF6L0x3L0VFajQ1VTl5dzArN2tDbGwwbGFCck4w?=
 =?utf-8?B?MG1vd2V4TngxVXVyeW56aVlGbitENjVjUWxCdzhIWVlNOWF4V3NiVWgvdVJk?=
 =?utf-8?B?NGJMSjJLd0NXUnZRMFFxMDhZVnRNT2J0ZG5RT0Zuai85VFNhQWRvbFZsVW1t?=
 =?utf-8?B?QWJJbm55dzNLcUdoU2k0VDliY1ZHekZBd21Dc215aitzMVYvTzVvVkFMYmxZ?=
 =?utf-8?B?WVRaZmhmdlNhaWdyUFdpWHJzcFJPUm4xOUVKOHFCcnhSY2RYc2phSDc3V09I?=
 =?utf-8?B?alh3K0hLWDZuRUFnTmRFbnJGVWJjMWZ0K2l1T1RRUzZBNWp0ZlNYWFo2dzFK?=
 =?utf-8?B?NWRMNGVXNm9JS21MMnFpTEdoMWN1QVlvdGRrQlFXRlJ2YUY5dTduYkttYlpZ?=
 =?utf-8?B?WVdxQ0FZSG8yeGdLVlMrUWxCRVNFSVZqQTltbHFWUmZXODY5TzhWbzRRd21n?=
 =?utf-8?B?Rk1xNEVrdEdzYll6ejR5N0J0bVFPWmZFWmcyellnajdxc09RaGFId1JjdGQ5?=
 =?utf-8?B?U29BNm1xRWhnQVUzVm9NQlVONEQ0Um5ickk3NXNYMkFTTG5xNFNsWEQ5SmE1?=
 =?utf-8?B?UitORGo1Y2lFTXp2c0loeGsveEVuWmxSTisvOG45blZ6MkJxWDhwNEk4UjMv?=
 =?utf-8?B?RlkwaXAzQWVmOTVwc1NUZ1FKS1J4MnBLY2tOZk1CYjJsamFIR0ZMN1NNR2NC?=
 =?utf-8?B?R0VlUHh4cWZPRVZtVG0yRVBWb3NIbndDOGhrbXg5MC9wVnh5RTQ1eHJHVEpR?=
 =?utf-8?B?TldIS0NXUVBnZUJlMk5PMC9iSjcxRWE1UHZ4aklOR2MzVk9xU2RoNEdNNG5F?=
 =?utf-8?B?QWFDVzlxbFNmME5tYi96RDZrRjdKZzF4dGlzcGRPOTVIaXUrUUY0Qlo1aUhI?=
 =?utf-8?B?ejFwajkrYTF5Zit2YnlmU2JzNWJKdDJMdzNkVHZVMUxUdzVrV1RvVWFrNDQr?=
 =?utf-8?B?L05YQ2dsQUxxeDNEV1N4NkJocXNMQXNJUkpTWjAyV1BCTFVIa05oQXIxVHcw?=
 =?utf-8?B?bml4UXFKYmsvL2Iyb0lGaCt3Z0FXVVh4Wkhvc3lKUFBEbDd1SnhmeDhSZktn?=
 =?utf-8?B?bDJhZitUMGR3cVBJMEtHaGdOd2grbWx1c1FTYm81QnFxNkUzNUF2aEJrd00w?=
 =?utf-8?B?ZDByQXczL1p4Rk03NFNtT2lBYkM3ZURnTUh2RzYxS3RkSXVXT0VMR0F3dDIv?=
 =?utf-8?B?YXoxUTNNWlVjdE9jdXUraHFMWVhrNCtIbG1uUXV2SGtXc291bFpIRjMyV2JN?=
 =?utf-8?B?bDU1dWNoc1hlVnFXWEpNYTd5R3ZrVmxoRklES0piMXhlSm81RSt1V2pzR280?=
 =?utf-8?B?UXp0ejczYkxHZlBWMXNNRVhjdkdiY0lmT0J5ck1sb1FLNFJTdk5XRUVGejd1?=
 =?utf-8?B?TWhpWnVXZ0NML00ra0VOenhmWTVTSVJIYXpta2JkRUdjUklkUWhOL01KVEph?=
 =?utf-8?B?WFhuNzErWTdZRmFnSG0waWxpcDBNNjJCTGRMK1FBS3UrT1RwSjUrVVZnR0J4?=
 =?utf-8?B?TVhtRlk1ak5QKytLdVAvb0d4SlBzTzB4WmVpZGFkVkxjakdibTVVYTJiK3d2?=
 =?utf-8?B?QUJZUTFzOUQwWHRXbWo3NHdmNDF1NUxlVkR1TGo1S2NldnhSWFo1eFJLV0Na?=
 =?utf-8?B?dkN0bW45RTVidWxDVnNLaXNXbEpORFljalJYekMwbGhwWEE4MEZKZUJDUURX?=
 =?utf-8?Q?kBf2BiUwhmYpqOUppbxkAz0sxtuPETDyEfBDZOe1+Yjdg?=
X-MS-Exchange-AntiSpam-MessageData-1: 4I/aL2vqUQCt7Lb/YqCa9vY37/1H4X21na4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3fd313-8459-4818-fbe6-08de46a8ab47
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 07:05:37.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: co8YLjeu18aj7Hcg2E9g1dZXzCXotuS6C/F3Tt34m9O4svkznNp+gBzXCqTPFUrWE1oQ+2vdiKFfC5WmKcVyKqeJlPqnOFF211JSk2LY6jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10994



On 12/28/25 06:51, Tejun Heo wrote:
> Hello,
> 
> On Tue, Dec 23, 2025 at 06:20:09PM +0800, Pavel Tikhomirov wrote:
>> +static void warn_freeze_timeout(struct cgroup *cgrp, int timeout)
>> +{
>> +	char *buf __free(kfree) = NULL;
>> +	struct cgroup_subsys_state *css;
>> +
>> +	guard(rcu)();
>> +	css_for_each_descendant_post(css, &cgrp->self) {
>> +		struct task_struct *task;
>> +		struct css_task_iter it;
>> +
>> +		css_task_iter_start(css, 0, &it);
>> +		while ((task = css_task_iter_next(&it))) {
>> +			if (task->flags & PF_KTHREAD)
>> +				continue;
>> +			if (task->frozen)
>> +				continue;
>> +
>> +			warn_freeze_timeout_task(cgrp, timeout, task);
>> +			css_task_iter_end(&it);
>> +			return;
>> +		}
>> +		css_task_iter_end(&it);
>> +	}
>> +
>> +	buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> +	if (!buf)
>> +		return;
>> +
>> +	if (cgroup_path(cgrp, buf, PATH_MAX) < 0)
>> +		return;
>> +
>> +	pr_warn("Freeze of %s took %ld sec, but no unfreezable process detected.\n",
>> +		buf, timeout / USEC_PER_SEC);
>> +}
> 
> This is only suitable for debugging, and, for that, this can be done from
> userspace by walking the tasks and check /proc/PID/wchan. Should be
> do_freezer_trap for everything frozen. If something is not, read and dump
> its /proc/PID/stack. Wouldn't that work?

Yes, that will do. I just hoped it might be a little bit more robust to detect it in kernel. Thanks.

Note the trace printing in /proc/PID/stack is a bit less informative than show_stack(), e.g. for my test module (https://github.com/Snorch/proc-hang-module) the stack in /proc/PID/stack will be just empty. (I guess it has to do with the fact that you need less privileges to read /proc/PID/stack than dmesg, so you can do a more informative thing in dmesg.

> 
> Thanks.
> 

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


