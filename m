Return-Path: <cgroups+bounces-12627-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E12CDB368
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 04:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77397302B77F
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9634224240;
	Wed, 24 Dec 2025 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="clm2mMBs"
X-Original-To: cgroups@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022099.outbound.protection.outlook.com [52.101.66.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F71E2858;
	Wed, 24 Dec 2025 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766545624; cv=fail; b=keA8VFUevlIpJmBR5XW3hFd1Gw7MiJTlwj0c9tk6iG7XDETjxU3oj4p2NK5wO+CCUKm8Hw9AXu2xDLqgYWcpkQKcHfdfCSVrd+mZf/y5QxvUTdKAgLbPOr/GLPTJ6405etxQsc8UwdYnla1zHuk7nRehBkRvEh61VEQ91LJTFoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766545624; c=relaxed/simple;
	bh=QDO+WjgdtNdhTo/4D9x0Mk7OvUyvN9xXAR1L69A82vs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Or0FpVPD63g3n2U6Qoo/NLYX2iIyOl84vmbydhTTnET6Jyd9pDxxzjVxe09x+ldHPa3xmEya1khZLOdwpd6Z/2wVM+eMraWEX3MFv6+SwpMZYVGnWJY71MBpM6HtZy9T++WN/BTlughcRR6XiE7+P+X8LRk+ydxxCU8PsJM9Z/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=clm2mMBs; arc=fail smtp.client-ip=52.101.66.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOdYHOaKSFa/05kStHLk0XTV4+S1bEngT8oLoumM1jqlHooQj5DPq9WomQRLzwy9OL5uxMy9J9hCzSUQ2e+UcsAgSrCxTVH2h8Qp4HpUBiOfOPkWr6Vw595VLduWiZpG2M6U1+MbtNCAADcQ/Tqk/RsGfAbLH4iJ12qEXb6AB2BNea9kFC9WiNTqGeBx4NB9sQcsWb2KJ9syl+4VsWky0tOuSSlGL54BxQl6R8l+kXqjUqv4OlHw7kN2FYUU41Z7uNe5/bG1s1hefpU8SVMkX47ebO4zxCdlwdDbnwzhcQqjNW3rAvxHxmf7kMeUqi8h7zfxIq4F4UUzV9IOCfCodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la0WJ/43iDjZC+w+RvJA7deR+C8lORRF/shTnMitDy4=;
 b=uZ/in74BBmRxQ/ITG+s5J0iq6G3bfD1mY/AUvA/Psg3ZklQSZS7T8xUgc0Nq90n1I04zFZ1BfrkaLIhJccoSQBt+EhabUbDxGulL5fzVsrG3ndybvtAA36VVCCmRwI9xPCmqLhHU6oe8k5nSWmPpIwmzl9YxSUOYo5bFN15Cz0cN/qM9yX1E5NX+6DMj06Zw2NbpiLlzvoHV+C81dtvw/5WXkAhyDF4zTTIXrUrmNHwr9F6UAzdvD8qwk8OOl23KtipSpu+piRmmh5nvCkOHUjgD4b1Ke6Ni84z9KCiH4k3QI3kemgZzPehmnAr+AmBE4BQFbiYCamW2y2wMI1tzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la0WJ/43iDjZC+w+RvJA7deR+C8lORRF/shTnMitDy4=;
 b=clm2mMBsnxqsTx3BlIlVozBOlhfJbXtKQ+JzgjtTwzHXdN4jgIJUCSZrEpm+wd6VIQzkpsjHNquRVaUmOYmDbEAfAmCbQYtZr4sHrvue6Vakfv1OK9FxYMR4Np1cxwXJvQhxOU6SBXw55bsjSD+pWgZtoTUBlL6lV7X8w4/nnsATg2ZcNYWKG7waW9QMFt/BnKIfvs9uMs7xskf1/DghMWaJLaquK41JX80pcJfo3yFkNXdzxUZy63pC+pu0NalW210ayND7EbEVOoauGLOuyFaV18Z660JSR3Hoq8qz5PTNZbgG1usZYb2/4zLbBcJi0/ac5uVkDY/8Y/S7U9CmBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS4PR08MB7654.eurprd08.prod.outlook.com (2603:10a6:20b:4f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 24 Dec
 2025 03:06:58 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 03:06:58 +0000
Message-ID: <df449a6e-bbe1-4dba-9b05-c2ce746e9163@virtuozzo.com>
Date: Wed, 24 Dec 2025 11:06:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cgroup-v2/freezer: small improvements
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
 <eamvrn5wbcdydffxfxitphfdfv3wec7wdsni3ykzvrammayndw@ecrksjfijhkh>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <eamvrn5wbcdydffxfxitphfdfv3wec7wdsni3ykzvrammayndw@ecrksjfijhkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0032.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::6) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AS4PR08MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c141aba-acc1-46eb-8686-08de42998021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3NhSVBZOGQ0M1lXcXhCY2J0bXVicGV2NmFqVEpadFBqYUNMcDVpTGFKQ21y?=
 =?utf-8?B?c1hYM1lOM3NkK2lSWHlSVXk5L2doR3l4d2d4a2xCaitySnNFWjlZN0gzR2Iw?=
 =?utf-8?B?TVhSSWxiYmZJVnpSVVBPVVJDWVN0eTUzekhxcXUvc1M4UU1aTU5Sem9JZFAy?=
 =?utf-8?B?enFUYmk3YlJ6Q2UreHJoUnRaSE8zYUE5VWViVWNTVThoRERlb0Z5U2h0NG56?=
 =?utf-8?B?alNtcDlSc05DSzltZlJQdHcvTmE0Mm92eGVFNm55dDlEUG9GazkweTJ6Y0hw?=
 =?utf-8?B?NWl5V0xhbk05Y3E4MHpvZnpNa3JxZDNDaFd2ODcza0FtekJQR2d4MDk2Q29K?=
 =?utf-8?B?Y1Z3TmN4aG9wVmJVQjFORU50d21LcGpDeW50WDBON2FMUlJSam5VVHNvSnVF?=
 =?utf-8?B?TmQvMzRGYUpYU2tzaVNMRjM5c1NsbnJ2ZUFyYjlMdGhpOVNrZEU5alQ3a3Vt?=
 =?utf-8?B?WSswcFN3T1RwOFRqL3dFUkRuSXp6RlBjTFd3cnJ1MWdCS0E1VDBwb0Rjbktn?=
 =?utf-8?B?aDY3STZTaTN6UFQ5WXUwV3huTjIreC8vTmE2d1E4MnVkblVzdE14VDZFN2pU?=
 =?utf-8?B?RlJ2ZmRVYlNQdDBwT2ZsQ1c4RzFpMHlRUGRSVGd5YjJNaTVjdFM2NHFvaW9L?=
 =?utf-8?B?WDZ3WTgzNlE0MWY2djFUUjN0S2tXR0dNMUU1bXpQbzNzSk5tN3VQRHRnZVFN?=
 =?utf-8?B?U3g5SlRudFlHNXh0cXJBOElNN1ZCa1J0d2VSU3pJbHNjalRDTDdYRWdkUHNE?=
 =?utf-8?B?Q1RMYnEvSWIxdkROR092aDRHbU9xTTBBUzFaYm9jSnE3ZDZMOVlPUE1zN3c5?=
 =?utf-8?B?WlZXRkhpMldBTURINWhqZENOV0U0MHJjenhhNzEwRE1WeFJUVXFKL0JoOTM5?=
 =?utf-8?B?bXpnTlVhMlhhTS9VVitzMlB1cE5YUERjL25iU3JyM1QvYUJwK3NraThsOWVJ?=
 =?utf-8?B?TkpNOXBIZnY2NDF0UDdIK1JEMWZSR1U5YndpRURJQmZpYkJKK3l2cnc4dTIv?=
 =?utf-8?B?SS9wd2NBTU8yR29WODM5MmZ4OVBzWWdrQlR5M0ZhL2ZLTmdwNnlCYjdqOFNK?=
 =?utf-8?B?V0RMem1hMy83cy9IS2tHd3A2L1hTdCtLeFp3L0pXUnlYMmpXRWY5QkI5L0Nk?=
 =?utf-8?B?MndqVWF4eTR6ZmgxQmtSWjBKcEUrTGhCU0tscVVueHVnWmhxQUx6NzNGS3N1?=
 =?utf-8?B?azM5UTNmNmpCYi9jZ0xWK1JiOCtsN1pzUmxzV3VNTnpQNTRGYnhxRm1ibnkr?=
 =?utf-8?B?YzRjd3V1Q3ZXZzdSc2dDeHMwdnJaWE1JZ2FrdkpGa1dSUkxTNHZ5aWxPYUxU?=
 =?utf-8?B?WWhrMXBMOXlTL1dYeXBaeldBamFJeGZpeEM0amt4SEFYdHA5UzY4TXM0dHlj?=
 =?utf-8?B?a3JyNUlzMUxtb3ZReldTTXFQRlFLYTg4QUlYdkZZZjdKakJpZDJvN3pDb1Y2?=
 =?utf-8?B?UHh1bi9BV2svczRvampVdnVKTHFrSyt0a1plalBneVowNGdaY0IyZHdBNHBr?=
 =?utf-8?B?cHJwdjBvaXVWNmUvekZwZkxEQ0hvRncxZmRuNHA0TnlVbmRmSUpKWW1hSmQz?=
 =?utf-8?B?ZWhhSnIwY3kxOWJrUHpxVXV4L3NhVDd2REVldHYwWktFZFdpWWRTVXg1LzFN?=
 =?utf-8?B?YTF5SS9hSitEaU9ranhuZytodUMxbEtOdGd0RnMxQ0R5Z3h2NVNSeHZKNUNV?=
 =?utf-8?B?Z1RpMU8yaHEvMytvV2FLUEs0QzRXRFJucHY3WGl5U05RSHJYeXhEeU9udXJr?=
 =?utf-8?B?U0ZsUnlvaVVmNmh2T2tDSDBveVRwSjFBK255Vy92b3JxaDFQWlEvTGRCZEgy?=
 =?utf-8?B?NzVHTTZJTE5CbUxCbVNMQ2hxK1pwV2xDcXhsVXo0NS9lL2k1WTBpM0cwOGJs?=
 =?utf-8?B?bUovZ2ZJM2tsd2t6eXhrOWVyK2t0NEh1WmExbkpITU1oZkx5M1kxeVJJQXZK?=
 =?utf-8?B?bi9QVERmbFdpd290MThNc3FZS1dZQlJtekd1Sk42Y2N3QkloWXVGR0tKK29J?=
 =?utf-8?B?SFBPQTRaN3BBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUFwek1PbkVQV2ZrMWx3dDhvWUdQbmxLdFlUN1VLOU8rSk5xL1dISDVUKzhW?=
 =?utf-8?B?bEdGTVgxVlh5bVo2ZUthMlJ5Nng3YnZWQVhkWXN2OGVlaFNhdU9CSkNRMklm?=
 =?utf-8?B?cXlGdVg5ZXRzSWdJZWtkbi9LL0dFcjJGZ2RxTWtrWVlBMGc1UGczN2VmL0JQ?=
 =?utf-8?B?WEVyQVhic1djZjBRMDJxbXlqYWlFbXVQWnRwSFRhbFlQaFIzRG1ISVlSK0hi?=
 =?utf-8?B?c3J1c244RWFPY1VCTTdZYzBYVVFtL1BQNW9ST01HUGMzajhReFlYOEp4Wnp3?=
 =?utf-8?B?MkJtQ2syaVY1RkpjUDlmVUhrbVZzWk00NFBUYzJiYmNVdldDbHYycG1BU0RH?=
 =?utf-8?B?WnBKelk4U0lJRm5obm4zYlB3ZUtTRGxySnU2TWNyekRJQmQ2RVpMMERFMUo0?=
 =?utf-8?B?anNjc05GRFVPOUFLNVpSa3JCbVExRlFZYVhPSnkxaXBqdFZ0amVmNFo3dVFG?=
 =?utf-8?B?bnZRWE1lNUFjUU5lcmJSV1l0KzNRL1QxK3phaHRRODI3ZENjeTJZWXp3MVov?=
 =?utf-8?B?d3dqZGZaK0xZK0doQzBvTGM5Nnd0WE4rVCtqZk1RdVlaV0hKaGtZOHI4bzFj?=
 =?utf-8?B?NTFaRGRDdUdCZE84UGRCRitlUVhmWDFSM2xTU1poQ0pOSFNkNTR1K2VLK2Vr?=
 =?utf-8?B?blFEUjBNdmlsZjRiVGFTNHhUd3BNNlN0ZHVXSUJQQUZ1a2pDcUtLeU5uWnp5?=
 =?utf-8?B?NVF5UzUyRWJITjBPWjk2dUVrT3YrcTByeEZBV25ObmdUdGdkYythTGNXQ1BX?=
 =?utf-8?B?Qjg3QmlJZmpWQ0lEakFPNE5RVHpSK0daYVNxT293aGhsSk9IV3lvbGkyOEJP?=
 =?utf-8?B?eW0wTFI0Z0xJalR1eVRPMk94NkxiVmRTaXU4U3dRQm96WFBUMFFpR1VNRWlN?=
 =?utf-8?B?VVJIWDZOV1pISklNdTJ6YXpOV2wycUx4YlJidnpzUUYycDRXL3o3QWEvSkZU?=
 =?utf-8?B?aXZZVG5yM1VhOWpCZk1VYUtaNkROMHFHbjliUllYSlpkZzd3Y0lxcDgzVEkr?=
 =?utf-8?B?TjZZVFZGWGZQS1NkWWlRV2J1OHJrL28xWnlZbmJzUThhS2lONnB0QVVvSkRX?=
 =?utf-8?B?TDhuSmdUL1VUTy93elF0MlVLRU1hMEMwUmlwNjM3K0J3Vmp1TGlQWXRNdkRD?=
 =?utf-8?B?UkJCVHVMb0R2VUV3R2sva2VHbXFzeTlNRnAxaFhSZzhDSlRGUFRWREhPcDNr?=
 =?utf-8?B?MXV3S3ljT0J2K3ZBOStQNGpMQzFHSkVZTzJvVXowNVFDNzNiNkdFTkhnWHdH?=
 =?utf-8?B?VGhZTGh1S3N2ZTNzL1JGNUFDa0lOWjM0NnhyaTMyTlM0Zys3dGcwL2pFeEdL?=
 =?utf-8?B?Sm42WmFYRkhqU3p1WG96ajBYUVIxcFA5R2xkWXVUbW84RmZ6ZFg3ak1pWmZU?=
 =?utf-8?B?T3ZNM1lIQ0ZKUExSdnNKUnBVdE95b0FVYlZRL1J0NVBkQldQdXBwdkE0dUxv?=
 =?utf-8?B?cmxQeUkyY2VKR1hKUlpRaE5vanN1TzIxbGlNakovbmp3VDFCYlhkVjRoR0xP?=
 =?utf-8?B?V1pIMmJGak5sNHhWTWt3ZkN0YkgrRTdaN3g1L3ZReTM3c3FTdUNSWG9mc0s0?=
 =?utf-8?B?SFRlNWFtcTZSK1ZzUVhpKzIxcDFvcFB5RnhHRHl3a2c5Rkw0MWlPQ0dDVkZY?=
 =?utf-8?B?MG5CU0x1QW9aRHJSUWJJbEM3aStLYy9CSTJxVEs4OWdCb05SbXRDTWdvVjlT?=
 =?utf-8?B?bnFPM3MrazJoVXg0WjdzRnBtWTRrWGVnek1rM3ZOT2FoRDd6REhPaEVXdzA0?=
 =?utf-8?B?bzZCb2JSVTZwSnNhOEhUUHk3VzArWFdFTW5QNVJIVWJ4eUpxTDEyMTk3VE9Y?=
 =?utf-8?B?NDhWbmlzSTd1Tld2WUxWRCt4R3JBaDJRNjlySGM5RXBQL0tLU2ZEWXdmYWsr?=
 =?utf-8?B?SVR3WnRSZmxRWUV3MlN4dit2TE0yem11ZG0xTk8wL0ZGN0RaYTkyZ1ZHYnVJ?=
 =?utf-8?B?SkJQL3dleDE2NXZGa3g5eEdxYXlMSWdKWE4xWWJkbE1qZXRnWkxCcUgyWUQ2?=
 =?utf-8?B?QWhsU2dWZmt5eTd1Z290Zm0xZG1ZSXVEUXFEdDBZUTJLYlVsRERBS2RMNTlL?=
 =?utf-8?B?L1NpTGxjZm9VcSs4dFJUVWU5RW1jYWxjR3lzbWh6Sm5DaFdyL1k4UFVxdll2?=
 =?utf-8?B?VG1qeFFVWTZYSFlVMjlXMll4VHF6VVI2akRXOTBEYkp1MGN0a1J4T08rSHNO?=
 =?utf-8?B?c1poajNYK01oYUpjR0VSOVRScTRsVWRJeHFKQWRsQkpoTnVyeTVGaUMzSlk0?=
 =?utf-8?B?OXVSSGdscDYyd0tQR1BFSWtYUitNNlZ3cDl3ZUZzaXV0dVRnakQ5U1ZPTGRH?=
 =?utf-8?B?UzEzRTRrWGcrNmVtQ1QxcStYeVo3TnozQ0Rtc1ZNZjNpS3BQSzRkWXR1MWFn?=
 =?utf-8?Q?XDCpxQwC3Gdw0J4+PtIqaQFrnIvlmf1dM/WNzRMrZu4Ee?=
X-MS-Exchange-AntiSpam-MessageData-1: 14LosvDujFHL6XrPfgdoDn3eaFviPEtDrJ4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c141aba-acc1-46eb-8686-08de42998021
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 03:06:58.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93zfvbtML4pwnvBH8M1/qniJIaWe8hRsftQBTgXYrGp9WZoO21w4S9GFDp6zG9909dwkbzJEZjNndlRQbuBxOqwpXSDEiRWUiu8UZ7g9FRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7654

On 12/24/25 01:29, Michal Koutný wrote:
> On Tue, Dec 23, 2025 at 06:20:06PM +0800, Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
>> First allows freezing cgroups with kthreads inside, we still won't
>> freeze kthreads, we still ignore them, but at the same time we allow
>> cgroup to report frozen when all other non-kthread tasks are frozen.
> 
> kthreads in non-root cgroups are kind of an antipattern.
> For which kthreads you would like this change? (See for instance the
> commit d96c77bd4eeba ("KVM: x86: switch hugepage recovery thread to
> vhost_task") as a possible refactoring of such threads.)

To explain our usecase, I would need to dive a bit into how Virtuozzo containers (OpenVZ) on our custom Virtuozzo kernel works.

In our case we have two custom kernel threads for each container: "kthreadd" and "umh".

https://bitbucket.org/openvz/vzkernel/src/662c0172a9d4aecf52dbaea4f903ccc801b569b2/kernel/ve/ve.c#lines-481
https://bitbucket.org/openvz/vzkernel/src/662c0172a9d4aecf52dbaea4f903ccc801b569b2/kernel/ve/ve.c#lines-581

The "kthreadd" is used to allow creating per-container kthreads, through it we create kthreads for "umh" (explained below) and to create sunrpc svc kthreads in container.

https://bitbucket.org/openvz/vzkernel/src/662c0172a9d4aecf52dbaea4f903ccc801b569b2/net/sunrpc/svc.c#lines-815

The "umh" is used to be able to run userspace commands from kernel in container, e.g.: we use it to virtualize (run in ct) coredump collection, nfs upcall, and cgroup-v1 release-agent.

https://bitbucket.org/openvz/vzkernel/src/662c0172a9d4aecf52dbaea4f903ccc801b569b2/fs/coredump.c#lines-640
https://bitbucket.org/openvz/vzkernel/src/662c0172a9d4aecf52dbaea4f903ccc801b569b2/fs/nfsd/nfs4recover.c#lines-1849
https://bitbucket.org/openvz/vzkernel/src/662c0172a9d4aecf52dbaea4f903ccc801b569b2/kernel/cgroup/cgroup-v1.c#lines-930

And we really want those threads be restricted by the same cgroups as the container.

The commit you've mentioned is an interesting one, we can try to switch our custom kthreads to "vhost_task" similar to what kvm did. It's not obvious if it will fly until we try =)

> 
>> Second patch adds information into dmesg to identify processes which
>> prevent cgroup from being frozen or just don't allow it to freeze fast
>> enough.
> 
> I can see how this can be useful for debugging, however, it resembles
> the existing CONFIG_DETECT_HUNG_TASK and its
> kernel.hung_task_timeout_secs. Could that be used instead?

The hung_task_timeout_secs detects the hang task only if it's in D state and didn't schedule, but it's not the only case. For instance the module I used to test the problem with, is not detected by this mechanism (as it schedules) (https://github.com/Snorch/proc-hang-module). 

Previously we saw tasks sleeping in nfs, presumably waiting for reply from server, which prevented freeze, and though hardlockup/softlockup/hang-task warnings were enabled they didn't trigger. Also one might want a separate timeout for freezer than for general hang cases (general hang timeouts should probably be higher). 

> 
> Thanks,
> Michal

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


