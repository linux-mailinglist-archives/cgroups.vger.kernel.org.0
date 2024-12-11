Return-Path: <cgroups+bounces-5797-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D169ECB84
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A860283669
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F8211A28;
	Wed, 11 Dec 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="erCoq2Qs"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183D238E0B;
	Wed, 11 Dec 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917502; cv=fail; b=I9mlcyN2lRdWwmHZGAIv7k+vHgkinST/7WyDhhHW6pHbrb9/9PWiWcY0SjtDZhkx6rp0gZsE3gn28EIrvb+SFUUxAmeyXSt2D2m3sxd5s6ZJCZ1slC5QuYQGKP+irDR+JX3k1xpKHrJqsvvB/69uvPaxAYocqxYnTGjDjcnCoK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917502; c=relaxed/simple;
	bh=buOhCy5ZDS/mJNhFyA4ETqqURUmVLYPY+M23yYglWEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6XLUQhTa1sDhZRt7VP2oHHIGfKjX7YGXftcojsy4dfZMsdra+cAZYqdRb5do44Yf5JMFW58MFbt1APFdh8QpS+fynA8Z2xa2Fw7JbI+1cALosDSrVzfG4LKEFKopX15nzW1GVpIIN6fXZMlh2J9DUsohJmZ+yNtNUSIrx7mO8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=erCoq2Qs; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wf8B0ScfBj7lTPqFTjt4y4rlXIsRS5x0PjR0VDm2LE58kwFuauG6HrwORLQQUY8KXCyQoi49shvPa6wJuYnuEVV3QDDlagD4GrZknA5uR/Qeiu8PsoU0Hn+wJFWXTRlD/fj7kdZIg0BB4Km4H8vWyr9OcOKOsTBiU54+j5EWMitsqLdP1QG2wDXrWGlb7rUBag8w2u5Wqkz3CV3QSQv13tZHtAr/vW2l5wN3Cf58laXX+/So/KD/qVuNWUaFXOg00tJT5ZymoFp+EkEDocj6NH+mnMwLeHC1Kt2yxokKI8NekJ4eWMw55Cxr2tG/A0MAMA9txM7boGuxSAEzUo5ygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H9HvrSVlByvr+Q8/mq3aDEX7dWX8y64c9BuRIiHFSs=;
 b=orx0QY36E96a/vPz0tZ75P8AMoVdhlIpiCc/oMXPdjUY1fIT0l0p67Up51aZabuvEULJNQFlc4SP//1sXBFY2ow//MxqsAIbJhSL3Ja33NdaFM/iUl8T/aN20BTAUuArzoxIyzXukqmYEqki7Ujq6JkQr2AFnkeKBa3VaEvxAFs5b3j+p+oFacfOqWPIy53mlatvHxdkNavg/DVo/2pZBXiAmUiGYZMuoNAUvTn21yxnNfRIHgk9CQSrxn/FIU+hKNojAZC7FWSKCva97KgDp5iJehMiIGAVUOzZmGJMMNcVb/8UEYousUQt9lbn0eWs0jJs9DDbbyRVfuA8h4n5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H9HvrSVlByvr+Q8/mq3aDEX7dWX8y64c9BuRIiHFSs=;
 b=erCoq2Qs7S+r+T3hirRbN/vShzhe/b/kb8JE7oRBSrOCIyT1YGWXjatKN+nM+lo6LrV1SJDPLKtWcnI+eMxthOoDgYtqsh82y/GDAUPQItAI2Qenb2KOOtEiFeXFXJjUoL4EoWfut+tDxCfxtmGvvNm1Uh27QSfPg/d0ZRx0XqFdZQd74SFyXp/2v/G5eLh8vofzRRJPZkTgQm+nba0bIAiSmT8pe42i+tWsysOZBaHdie3K2YFpAZO39uHb0d4XAtamVnkzrXaeWpbyfYpRIficQ8V0ot7NBJuIvSAVBZdIElUBg1ZDssllk6aiB9FhRgUj0iBHZ6OFbsd4mrs0Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 11:44:57 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 11:44:57 +0000
Message-ID: <36e2b7d0-6a48-4ad3-9f1d-bf0a7ee10c0c@nvidia.com>
Date: Wed, 11 Dec 2024 22:44:51 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmalloc: Move memcg logic into memcg code
Content-Language: en-GB
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, stable@vger.kernel.org
References: <20241210193035.2667005-1-willy@infradead.org>
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20241210193035.2667005-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::13) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b0e311-4e48-4aad-15e8-08dd19d93c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3UwK2w0VEVCZ3ZJazZrS0ZIcDFkYU4yMzRobEtJNkc0aE1WTzRQRW9nZE1D?=
 =?utf-8?B?VndEUktkakVCWU9MYThqOWxxQ0JaUmFpcVVkbjIrTWhON2VXSW1LNlE5d2k2?=
 =?utf-8?B?bkljV09xYXRNZEFLYU9qWVFVVzA1ald4N280MytmYXl2bGtVNElVdGRDSEo5?=
 =?utf-8?B?MG93bU9INjFtRXdzTnk3WFVhQTFEenFYR1NCZUt6V1h3RHpGYUw5RkFFVXFV?=
 =?utf-8?B?MTYwVlMybEg0R3FFOGIwT0pGWGN4K1VDM2pneEpXQ3BsN3A0Yjd1L2ZLZG12?=
 =?utf-8?B?YnNlSGNCczVKZzZWeFpwOXR2WENoWERyWmQvTTZvOHhwYlVlanNHM2NwWG9U?=
 =?utf-8?B?WlZGSlFNQUs2dm5naW00VWc0NkZNa0xsV0tvQ2NLWUZTNTg1c0lmYTRVWkVn?=
 =?utf-8?B?RXFNTzg3NU5DODdVd2kwSHkraldPZ2c5cHA2aWhtNEx5a05OSnN2Nnd0WkRR?=
 =?utf-8?B?MVd3Nk1uUHRkclZRVUV1NkVvejVCbXVJSGpzU3FXL2VTdEdXUEljbnhCLzls?=
 =?utf-8?B?SFRrUGhrMFJNN0xzRnp2Vk5rZFo5a3ByTWw4dkNLbkFHVWJzS0ltZU9JcUMy?=
 =?utf-8?B?U0dRRFUwdXcxakpwQ1BybUtuYUhTSGFIZWFpMVRRQXlDTDVLM1dUZkgyUytU?=
 =?utf-8?B?Ty8yWkErSFAvQ1NCdmtCNWdPNHhXazNwSDB1ZGZEMVpHTzJRMUozVi9nN1lj?=
 =?utf-8?B?bUxFL0JkNXZudzBPa2ZSNnlCdTNHMG9Kd3BqQ3R5anhqM1dteW9DY0dDWjBr?=
 =?utf-8?B?clVNOWZGTVpvM1VMVUVqVW5zK09maDVaOGZ2RmVxcGJpS0JwZmR4ZGVCZ0dw?=
 =?utf-8?B?WWg1dlNlVTF1TnA5d293NERITndPOFZ4a1gzQkFod0lDaU05RHIvanRaNGVP?=
 =?utf-8?B?dnRuWmVRMlVZRkdoYlF4YnlrT0UyeGNySVB5SGc5aGhPNU83VFJSelcyRWUv?=
 =?utf-8?B?cDEzalJsdTdhcHN1ekdkMEdwalQ1R1VvUHorWFg3aTFLVmlsLytEQS9LdWZE?=
 =?utf-8?B?MEtaMmZDSWc5SnBCMnliN1BZSmVIbXpraGhXVUFEcm1XdSsvSzdPb3pyeTNU?=
 =?utf-8?B?WkFIT1Q5MW50VTduelBCcGc1a3lIWWlnalZLN1RuQmlGL21YbDFDVmZtOERP?=
 =?utf-8?B?R2lpMnNNMEF6ZWZCbDhxdlJaOEcvV1JYRUdGbFNRZFpBUW41M3ZyVk4rdmpm?=
 =?utf-8?B?WFg2WW5tanFGN3NSUkJ4M0xYMzd1Tk5aMUptbUhsMmtVVGhydVRNeVp4eGZk?=
 =?utf-8?B?VVZWKy9KQmpIMVhRdGdjOTdMWnFHUzF6bGRNell5cno5eE5JbkpRd1dLVUlx?=
 =?utf-8?B?TTl4c2Q4UDFFSXN0ak1vSVVHQ2g0cWVIZDB4bGhma2hqNGR1RWVoV3FCWDBW?=
 =?utf-8?B?cVE0UjJ2bGZwK2swN3lGYlJOYmxreVN6L2tyM0k1ZUQzcURCc3VDTmZYMk1I?=
 =?utf-8?B?WFY3MmdwTSttN2VtdnJjK0pPWTlTaHQrVVJMK2ZZTjFvMU1OMnNEZmk2OU1Z?=
 =?utf-8?B?NXk5RHdWeGZZRHZkTTNIMHZ4dHF0WFhicVlRUGRrYXN1ODNrYnRwdGV5OWxs?=
 =?utf-8?B?RG5vL3pqQnJSckVPWW13OTRDeTVlY1hrWjMxcjMzSzF1Vy9QUTJSU0FmMllN?=
 =?utf-8?B?MmV2Y0I0eDdXVndqUk1PcUUrc0t0c3Z2V1I3TWdoeU9rVTIzSGlpeVl4T3NV?=
 =?utf-8?B?NUhqUTBWclZaOU91aUtpaFd4RzRRSnVVaStHM0ZNRGJFZ0EzTytzM1A0b3Yr?=
 =?utf-8?B?enoySVU0RGVXK3dzT3YrSGxsS3JXL2JLVWhYVG5kbTIyUlNjaXdaZlY5WGE1?=
 =?utf-8?B?ZDcyNXJQR3pxTVc5czdYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1FDRDYyazJpSWNWUDNLTDFrdVpkRkdhcTA1eGVnTUVPL1VxcEMvRWFFaWdt?=
 =?utf-8?B?OXEydTJDT1ZqdUNyUzAzd3dYdnJtNWtmaUE2T1BTbm5TWjU0TVFReGxjaTZ5?=
 =?utf-8?B?MWlEMkNoU3Awa25Xd3pVOTczUFFXQ1Jwc1pOS2JzRjRpMGJHUlFwdXBvUy9z?=
 =?utf-8?B?WkdQOE1pS2hoVloyZmFCV0ZDdDc2Um82MzMyUG9kcFdFR2FieVlLdUNjc3Bl?=
 =?utf-8?B?QW9SMTVVU0NvZVA4aWthazI4ejlzczVSL1JPbjByeW55Ny9ONEZjS25PN3Fz?=
 =?utf-8?B?b01vbHNFWHVJelJtQnp5L1F0L2w2V2tLT2dWK1BaU24rTGwzcE90VThjbmZM?=
 =?utf-8?B?aUdRNk9mbTBJWG5lMlhUWFgwY0MydjBGWXEyVUEwQVA5SURHY01IZ1VWcUxv?=
 =?utf-8?B?azNUd2pCbnh2aEdMZXU0OHZxbytLRmhENWNIaHBmWWtacFl2b2MveVJDRnJH?=
 =?utf-8?B?SG4zNkt2QW03SFM4VHlMWExxemVTVllvSUd3ZTNvQ3NJU1hJMnVGNzJEQVcz?=
 =?utf-8?B?LyttMHBmbnV0d0VKNmRtK1B2dXVETkxia1BrSzhIeERHUkYrTmlpME9UWGdy?=
 =?utf-8?B?cG80V0pheENiZE5WbDAwamFZZm1pYVhXSXJQak5heGZvWWFjUlJVamFKRXFq?=
 =?utf-8?B?NjllWS92Sm50VG5tNzRrcWJVeWpvWE9RcUtRbGFlb3pFNkRZa2xtUXVMUVdm?=
 =?utf-8?B?eXNQdzYrN2pWWHFlTDlJNFlVcmZzcjVja21mSVdrcDE5M0FLRTRTSFgzT1ZB?=
 =?utf-8?B?d1lvUGZ4YU5acTA3b0t5QXFsai9nTHJvMTFKYTZGQ1BNK1VDamRRaCtYRjky?=
 =?utf-8?B?bUxrWnlxOW9SdisxVHRGY0duM2pnZnJ5M1I2ZFpkR2pjQzNaQjJTWFBSWStS?=
 =?utf-8?B?UzhkWjFsZGd5RnBFRVFWcEE4N3lBSEx6TWlzWGZBaGdlQ1JuZkFEcG84cWYr?=
 =?utf-8?B?WVFCS2N6N25vQkJBMFliTjlVZWdnOVVLdDc5VGNOQnZ5T1prK2VOQ0FHQnRU?=
 =?utf-8?B?VkZLcEI5TE4xWUpvcmwyQzYvNFZxendZbmpuOFluVG9jQ0F5Rm9RMmZvMVZD?=
 =?utf-8?B?NSthZG5mbi9NQmgwaHRKVEhIOUxxdklNWGFmWHNQRWZHRWVMZVplbDljWm83?=
 =?utf-8?B?Q1UrWnpsVW50bGZ0VTJnK1hOV0Z5aExrUGRkR1VKTmlISWdEWlp5Q1VuTWlM?=
 =?utf-8?B?YkttNTUyNnVIN2t2YjdWc0xrMVBVUlNXSksyQkk4cVF3eVZXTklaYVVWWUFU?=
 =?utf-8?B?ek5nRlZYRHIxRkozVnlma3hRQ1ZGNGI0RG5IMWhwbjU5RUYzdk1kejVuY0NP?=
 =?utf-8?B?cVNwd3B3aDdCQ1p0aWNkMUpuS3VlaXdqYitsc0I3M1dOWWtaalZqbEVqMmRj?=
 =?utf-8?B?dmRwZGdIRVJaQXoyeHZaWG9JY3BlOEpNb0tRSzIvT2dHNUNKYi9uWnVOMXB2?=
 =?utf-8?B?MmlmMFVURnpqVEpmckZrM3pLOE0rNEp5bnlNYjE5cXZ3dUFCWVZTcHhmUy9T?=
 =?utf-8?B?aHBFbnZURW96VU5wZXprQlhsL2t5Skc1RzVPVXNRVkQyNHg1NVptUUNyS3E1?=
 =?utf-8?B?ZmJ1R1hCc3lSWUJKUjZFQVYya1QvVm4yd09ZZ3dtRHVCRm01bEhGNEhGMmVC?=
 =?utf-8?B?K3hBVFJIaUQwMG1VNlUwS3J0OUkxN2l3U1QySXk0cWFxMWNuemFDZm1xdlox?=
 =?utf-8?B?MkFaZHpkZWh4VzhJNlREUGdIWDdBclkwQnZVcGttYmpqZUZDWnl5UG9tVXho?=
 =?utf-8?B?cXJKNDVuZDAwMGM4MG91ajVHc20rMGxldGo3SmpENmpUeFlvMmtIQmVWQ3FF?=
 =?utf-8?B?OUZtSnc2UlJoZ21HWmdHWG1SUWRvWkFlaHhBRWtlMW1CajhadnVRRTIwTVBJ?=
 =?utf-8?B?Mm1ZeTZpYzdDSmlBVFhGVXZNc29ieUk0bjVKbW56ZEtNVWlPNCtrRUJGOHcz?=
 =?utf-8?B?RmVLZXJLVzFzVU5jbDJHNnMvSUNWRXlHNFBRaHEyK0VuMUp3dVB5c2hoSEEv?=
 =?utf-8?B?ZStmMHd1WVRqS0k1c21iVkE3WjhpZzFPRUE2VnpnSlVaYWtUS2hZR2swd3hP?=
 =?utf-8?B?bE1NbXJzdkhtZEgzajhtdDIxSS9ZcXg0eWdHTWFLUGgxWnFoWGhMY2VJdUVN?=
 =?utf-8?Q?0kIt319Mqok1N/uiGIROKrT/+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b0e311-4e48-4aad-15e8-08dd19d93c01
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 11:44:56.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+2znwDjN/ngIIDdU3hhtX5HgCLMOAtNCS5sNYMawO22gboPUBAM2EeCKaeQB+V1t8qCzWACpImskeHdXu+4TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

On 12/11/24 06:30, Matthew Wilcox (Oracle) wrote:
> Today we account each page individually to the memcg, which works well
> enough, if a little inefficiently (N atomic operations per page instead
> of N per allocation).  Unfortunately, the stats can get out of sync when
> i915 calls vmap() with VM_MAP_PUT_PAGES.  The pages being passed were not
> allocated by vmalloc, so the MEMCG_VMALLOC counter was never incremented.
> But it is decremented when the pages are freed with vfree().
> 
> Solve all of this by tracking the memcg at the vm_struct level.
> This logic has to live in the memcontrol file as it calls several
> functions which are currently static.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/memcontrol.h |  7 ++++++
>  include/linux/vmalloc.h    |  3 +++
>  mm/memcontrol.c            | 46 ++++++++++++++++++++++++++++++++++++++
>  mm/vmalloc.c               | 14 ++++++------
>  4 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5502aa8e138e..83ebcadebba6 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1676,6 +1676,10 @@ static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
>  void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
> +int obj_cgroup_charge_vmalloc(struct obj_cgroup **objcgp,
> +		unsigned int nr_pages, gfp_t gfp);
> +void obj_cgroup_uncharge_vmalloc(struct obj_cgroup *objcgp,
> +		unsigned int nr_pages);
>  
>  extern struct static_key_false memcg_bpf_enabled_key;
>  static inline bool memcg_bpf_enabled(void)
> @@ -1756,6 +1760,9 @@ static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
>  {
>  }
>  
> +/* Must be macros to avoid dereferencing objcg in vm_struct */
> +#define obj_cgroup_charge_vmalloc(objcgp, nr_pages, gfp)	0
> +#define obj_cgroup_uncharge_vmalloc(objcg, nr_pages)	do { } while (0)
>  static inline struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
>  {
>  	return NULL;
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 31e9ffd936e3..ec7c2d607382 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -60,6 +60,9 @@ struct vm_struct {
>  #endif
>  	unsigned int		nr_pages;
>  	phys_addr_t		phys_addr;
> +#ifdef CONFIG_MEMCG
> +	struct obj_cgroup	*objcg;
> +#endif
>  	const void		*caller;
>  };
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..629bffc3e26d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5472,4 +5472,50 @@ static int __init mem_cgroup_swap_init(void)
>  }
>  subsys_initcall(mem_cgroup_swap_init);
>  
> +/**
> + * obj_cgroup_charge_vmalloc - Charge vmalloc memory
> + * @objcgp: Pointer to an object cgroup
> + * @nr_pages: Number of pages
> + * @gfp: Memory allocation flags
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int obj_cgroup_charge_vmalloc(struct obj_cgroup **objcgp,
> +		unsigned int nr_pages, gfp_t gfp)
> +{
> +	struct obj_cgroup *objcg;
> +	int err;

Are we also responsible for setting *objcgp to NULL for return
conditions (when we return before setting it)?

> +
> +	if (mem_cgroup_disabled() || !(gfp & __GFP_ACCOUNT))
> +		return 0;

Don't we want !memcg_kmem_online() instead of mem_cgroup_disabled()?

> +
> +	objcg = current_obj_cgroup();
> +	if (!objcg)
> +		return 0;
> +
> +	err = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
> +	if (err)
> +		return err;
> +	obj_cgroup_get(objcg);
> +	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_VMALLOC, nr_pages);
> +	*objcgp = objcg;
> +
> +	return 0;
> +}

<snip>

Balbir Singh

