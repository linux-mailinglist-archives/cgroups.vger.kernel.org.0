Return-Path: <cgroups+bounces-7702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09C0A95C9B
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 05:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E29176CC3
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 03:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A72F2F;
	Tue, 22 Apr 2025 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VCy1IemG"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161410A3E;
	Tue, 22 Apr 2025 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745293678; cv=fail; b=GGnzO2M5LwL0zS1MyOCtyKP/QYLNSIVonSTxWSVWvYpgdQGlorS2kHezqwK4g9xcBvZJ98MWe13XuaXkHeZ7uXlJ9U/p9fliRvf9xUqjvNWXNEnQ7WBybsvAcTYZpx4KZz6TKdkIthNT3kmFElsEgMGQRYEm2+UL09GeZF9KCro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745293678; c=relaxed/simple;
	bh=odXtKzRLM7h2GGh87kaO3TI3/beqblewKzf2uFgrfOE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMBauIEtap84PK7XSuf2vuNziMSGWWx8+UaTvSEBSehfXOAc0j+apBLFW4gCcfxE4XijDTW/4kCTQoHSJSlC5N8FOKR1xnD6YcoBwkSg2VUJDEl2A+AFwMlkhxh0I0MPqhKlHrNDhSRcOqJL2SBoTJgC08/rarEvN0O+OTCnDYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VCy1IemG; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSQgDODtX6ZxI1zLBswMrEVWj5dHKkd4pYMLXMbSxW6+7/ZATW5PegAO3uNfV3GaNQBreBR9km6o76c/rH9Bvdkx/lKWntOJYUCRGnHU7M7I4fwkI4mMh1vV9bHUGD5C36GdXpwVsCeevSSVVSLhLVoROH/oxQBLCJKcXgNedFrWdYbM5tpiJ9Lb/C17H6ngpAGHVKH+3fS71lVbM4B3uIyhH/LECGiRQFANH2zqVB06NWxZDf4gJL1gMoVrFJj6TdubmoWG/gD7oFr3nx8Eky5xEXASgAOtrTUQLsR3sdv3TUMsgdLyobpY6Nf1n6ZXXOz30O4vn2JtIdpPHGJRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svBat+KvbtCS5tFdlM0l6BHugYtkZfzrKJHRyVrs3cI=;
 b=MbwJ4hMd6w1pZFaeZE2YTCt5esfQ+sDMzYtk2qPO+IBiEY9dvyfHTqklOdzLgGLHo60fGhrOCfknNGrB61foe2El2vdJASS+42YSQhEQV6zFBUi2jXxNnMnjXn18pnhc2p/iEhfI2s6RcBC5FpACEnyT5J2AawxLFM890E0s9RdbYzDYspc8QO1KrEIiXEEpD6vVrDcgnAKfQcXkNRBMq2+PDo/VTwhZ4hqKwfMCV3BzBHbH2yjb1Nhw6N6mgGjOWi3Szx35HLdPKd+6scNcDHFf26AaXfVfl4L3BqCvITS1lr4YhN/pBAfgMULFyx1tZzqFcijqtMObm9RMNbvz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svBat+KvbtCS5tFdlM0l6BHugYtkZfzrKJHRyVrs3cI=;
 b=VCy1IemGtZhsACVlRAiOkaWkG/7U3ouWQtvYySYYhirkjzX00n3xHg31q14P1s9ZXIgp/NAbCBzFJq/qKbEz+dr11gZ9qsM3UKInCKc4Y3VZfLQmSRbRkEZolVXZDoAbtLYQG/0JD8a1mhLj4yzJGE5vr0cU0FQ2oX4DYlc5WBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 03:47:52 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 03:47:52 +0000
Message-ID: <efddfef4-863a-4f5d-a093-eda41168b462@amd.com>
Date: Tue, 22 Apr 2025 09:17:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: RIP: kernel/cgroup/rstat.c:231 cgroup_rstat_flush+0x4ea/0x7e0
To: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <4cacaecf-615f-4664-ba48-57a9e6fac551@amd.com>
 <IA1PR12MB6460336FDCFD3183FFB5474DFAB42@IA1PR12MB6460.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <IA1PR12MB6460336FDCFD3183FFB5474DFAB42@IA1PR12MB6460.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::6) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ba39cc-3ec6-4801-e18d-08dd8150755a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b04wZWdHbE96bENrUitTR3E3RFhneVdqQUI1WEJoNGJBTzAvWVc4a0M1SEZj?=
 =?utf-8?B?b0txOXYvdlJPZUpSV29ZOWlWaDdWV0JVK3FGQTgrS3FLV0ppenhIeEtGOVZ0?=
 =?utf-8?B?cTVBWktQVXNxbEMweHVaaTB5UGNBOVBBZnF5b0RsYTRpMEp1N0FHVFlneWVm?=
 =?utf-8?B?SjF0cDVVUzQyWm94ZWdhR3pmTWY2TXN0WmJrS2UxV24wVm9KZ2RFOFFUWmMx?=
 =?utf-8?B?dXVtVk4velNBM1ZvWmphT1ByUG1iNlUxekNNaEo5SVBUQSt4RGVXT2I3Wmhv?=
 =?utf-8?B?ZDF1TmhzSlRLZ2RsMDBqTUcwTHNBUFY3dDFWRmJUTUtyVi9NNmZieXpMdFBD?=
 =?utf-8?B?MjNmUUpaMmJBeXRUUks4elVmTGpzN21zZGcxZWF2OTdqY1ZDWkxId25oL0Rq?=
 =?utf-8?B?SVM5bklMNGVsbVFxcDRlYjdOWWRDUlRjRlM4Y2Rzc2RXOG15M1podDdPSzJB?=
 =?utf-8?B?Mkg0UENsY002MGhNSC9oWGNleU1SVnp3VmVEODJ2UWRSdjlJaGZYYmc5Y3Az?=
 =?utf-8?B?V2xVWUNmYmhvMlVUV0xWcUV2cWJsRG1FMktGeXhMc1lBZjNLU0lCUytoOHdC?=
 =?utf-8?B?MUJuc2ZlejJTeC9wVlkzYW45ZEJta2lsWGdybHZ4Z0hYcllCTCtYS2RYS0hJ?=
 =?utf-8?B?R1VqZEluL1I3Rk9yR1VjMGJ0eU4rYlZNMWlGREV2STg5Z3dvdzBnTk9HWVo2?=
 =?utf-8?B?Kzd0dWNqVmYxSjlvMTdycnE0bmRmMnhKcGM5RU0rRXgyRjVzQUxTTTJLMHJw?=
 =?utf-8?B?UytUR25vNjlkYnRYUCtoUmZkeXo4aUJyR2hHL1g1aFlaZEd6U2Y4U3h0OTVV?=
 =?utf-8?B?M3FoVTdNb0E5ZG5JWmtLaTN4Y3NDYVhkM2xEdGpPYkdTbytBUWdMcDJ4K2Fp?=
 =?utf-8?B?MmF4cWtVWml4em5QS3hzVWxkNnc4SG1HNElRd0w0V2kvcFFuNncvRmhEdEFN?=
 =?utf-8?B?Y0VlUHN3VlNOQVRGNGF5MXhJcU0rUlo3VnR1bHc5b2k1R1ROZTcwYVZ0a2Vk?=
 =?utf-8?B?dlNCalFvcEtSMVJOYUhZSVh6MFZPNEc2QjR3Z2NwYVlCcjlkbnZrV3pFb09j?=
 =?utf-8?B?dDFCYXZ1alBvZzd5dnFPRlFYUXNMV0VoeU5SZ0N4L2FQKzlscVc5THhXcVJu?=
 =?utf-8?B?amI4Rlh2TERpa3VSdi96WThPOXJnb3hnWnpNVEcrRzlZVnBVV1hZTXVQWUJk?=
 =?utf-8?B?Yk50TytpUEFiYmJ0cVNNRVBQVmFqNWNoSW9pYldCdDlJZHkzV0V1TStGYzI1?=
 =?utf-8?B?S1p6eldGT3VvMG9GL3JkRU5nYmk2cEJPRjc0MWJRR3dvS2FhU2wwS0JORWxa?=
 =?utf-8?B?bjVvbXZDTmdkb2sxU2JQcVVhYmlBcGNtZERHVDJyMUlGOXR5MytDSW5zMlJE?=
 =?utf-8?B?eE1xMWp5UjZMY0lkbXY0aVNvMk15Q1RsYzhXTTB4Z1M5RWtjM1p3MHpYZG5I?=
 =?utf-8?B?ejhUSnJlejFHNWgvMzZDWUdZS1Nid0Z6QnQ1a1dqR0x0UDM4Lzc2R0VFUWt6?=
 =?utf-8?B?TGE5ZHNrOHZNRXd1SjBDRjdnc0E2S2FoWTYzRzV3aHR0YmtlZFNHZ2wyTkR4?=
 =?utf-8?B?YjY1TXZPeGoyNVFJTVpFZVc4MFV6THB1VzBKNDhwTTRTcjNSQ0d4UUJQMWpP?=
 =?utf-8?B?dlIxOHFjYlEraU1JQzZVS2JSeVVyV2tDYjJITXFvT2VEOFhCSnZSVmljbC9y?=
 =?utf-8?B?OTVieENCcWE0V0d4dXN0Q25pNkJFejRRZGZrMVphQ0NlQ3hGUVpIcmVoaitz?=
 =?utf-8?B?Q1dudDk4bmZKOTNsOW9YMVhrWTlpWExYL0dxbnBIMWt3dVJaTkdQRmp6dHhM?=
 =?utf-8?B?S255K0M2UTBXc1JSTDhhS2piQllzLzZmbzBCM1UwVFhzTXZ3OVdxMHV6bldn?=
 =?utf-8?B?YnRJc1R4bWxlbVNTdXhOajhZQlQrUlBsd1FkRlA1b3VwR2JwMTdYbWNBR0cz?=
 =?utf-8?Q?4vcUTXPLNiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzVGcS9iVnhSUFYwTGJVdGE3UndVQnRYWE9nZzZxVGV3TGVkcngwcFlOUUsy?=
 =?utf-8?B?NnhPbHJ1aW1OWEVkMm4xYitHd1pORXcreWlJcmRoYm9pbTBRWEY0eThtMmZ3?=
 =?utf-8?B?NGZWTUdPWjFmOE1TeXRuazRlektuMlhFWVBCd1FYK0h3bElKTUNlUUlRTE0z?=
 =?utf-8?B?TXBnRnVwNVNHRGoyWnVETy9CeGJIUEtPYUgzaE9RUGcvV2pFKzFBbWhDVmta?=
 =?utf-8?B?bmUrS2tYODl2VGJjbmpLdWdNbnpkZG9yanExM3c4QjE1T1JpWTU5VDk4Q0Rm?=
 =?utf-8?B?aWgrSXQ3dFlrR0R4Kzd5T1JvbE1hNFBmTXNPS0dDVHhodExhQWtCa3ZDbEtv?=
 =?utf-8?B?SzhIYTVUczVYd3lTSWYzWWx0NEZjK3I0dkNxT1NROTN3Z2RKY0g1Z0d0Vmls?=
 =?utf-8?B?TVNhb0FQQWZGbmFMSWRoai9FQXo0Z3NGSHN4Z2lKWDRhZU9kVEphR2xYVmlv?=
 =?utf-8?B?aEFuR053THF2VHhBOGhHblRBenIwa2tXMFFXa1pLa1lYN0ZXYUpsaHpNT3pj?=
 =?utf-8?B?cVVVdW9tcExBaGZPeE9CVVBKY3liTlJ2SldYYWc1RWYzTXRrUjRVYm9LckpE?=
 =?utf-8?B?b09OU1c1Sk9iZUJNeVlKcS9JZithUGZyRVdwNVVqQkxveHRSUGFzd3NjNTBY?=
 =?utf-8?B?T1pxcG10Rmo1L0k4YTBLa2ZRcVhBOUpQemx5YzVCUnZ5RmFpMVY2enQ4QWFX?=
 =?utf-8?B?SU01UE4yRzdGUXY2MGxCN0lGeXM5YlRyV3BFb2pvQ1ZzN003ajd6RFY5enhk?=
 =?utf-8?B?K3lxeWtybklPMjZLaXl6aWtTTDhOQXJBL1RaQ1hsSm5QalBnaTMwVm9zcXRl?=
 =?utf-8?B?cUE3Y29EUFhiQWIvcGRVZEYyQ0FiODgyemIrekRCNTBWWjlpeklGTHJXQnV0?=
 =?utf-8?B?K0V1RmlMNXB0TVpNZnhSNGJuL2pudHpjR20za3JZNHlvbnh3N1ZxM3N4Mzho?=
 =?utf-8?B?aWpkWnpMc0pnblowa0liNjl0T25tQjNQMHVnRVloZmx4a2owRlZQWGUwVFBL?=
 =?utf-8?B?a3htNWNLWWxHaGJWREhtcSt1Rlp1OEdPNHNXbmRKQXU1a2xZcXRxSXNJSEtw?=
 =?utf-8?B?VkFtNHNLNVc1RDVuR01YUHplZkRWcExMTmQ4TkNLdlJjbzBaSEJ5OUdVRVpI?=
 =?utf-8?B?YmhWdHRtdjdTNmR5ZFc3ZUtiTmRVc0ZKaUFzRnZ2YjUrUU5OZlVnNEFFSk1E?=
 =?utf-8?B?MXgwWkFSMkpYZDB3N1lGOTUvcG1YZlp5TUZaZHhlSTZtSjY0WGdYckRXNDRm?=
 =?utf-8?B?RmN6RjdrdEhCdU56amVLNGdpRnIrZHI1Ui9ldEZYNkdnaVo3TXQ4dzZpdjNE?=
 =?utf-8?B?NnJHY1NrUk5rTHFaVm45TjV6QW1WclpIOXE1VjVuazQvQVlaMW9qeDZTWjJn?=
 =?utf-8?B?YmJRay9kRGhaNUJtL3FycEZZUlUxbjhVZXhxbmt4OU12K2orS1RqdEtWcWd0?=
 =?utf-8?B?c201YU5sL0pEcXl6L3dzSlhPQmdNcHRvYnhuOXF1YmlSYkpCYzdsZTE0NEFP?=
 =?utf-8?B?c0dPdFVkcnhKVEE2YlpJT2tRM1JmeTBXWHZMamFheENZUU9hMUpVMDBIejZD?=
 =?utf-8?B?ekZ6RHp0cGVtcWwyb1ZXMXVBM0JLdTdWYTRKKzlhV1JHWE5Pb0dvY1hJbEM3?=
 =?utf-8?B?V3EzOUhja21WNFpkODlNUWZsL0YxTkhvNGhHQU5GY1h5TEk4eXRKVFZzS1hU?=
 =?utf-8?B?WDBxTG1sK21NTjhoYU55OHkyVk0zV3g1cUdxcHYwaWYxL0FhNXBka0ZHUmpS?=
 =?utf-8?B?UDhDMmEwTFBuR2pHRDhsczF2T1U2TWZ2ek56Zjk2OUdLbXp3UXFVWWtrWDJS?=
 =?utf-8?B?UHRIMWhrL2IwZnFMdkNRTEFaSVFtdWhZS0lhT0lkcENxeHoxbFJ6NkZQd0tU?=
 =?utf-8?B?Z25BRE5ZNXRtclVzMzNJRnB2WHFaeisyd2l6d3ZPUk1rSGxpTHJLa2U5TFBs?=
 =?utf-8?B?c053RVpDZkszVng3eG11ZDlOSzU1eXZJZjFtcWhJVnF4VnVwSzM0M05wUWc0?=
 =?utf-8?B?NTdNME5hTk51aWdURnVHMDFmSVk1TnBwUjBDcmNkeWNrT0haZFFUcDVuOHg1?=
 =?utf-8?B?K0R6K2d6NWpEMEVkeW5aN3U5UVhyek5DcDdjR1F0VGpPNnZ5dU9Ga1dFRGlG?=
 =?utf-8?Q?3CO5zFvv6gwx1G0EmQMgvMKIm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba39cc-3ec6-4801-e18d-08dd8150755a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 03:47:52.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7WMSrzhEUXoJ0rjfacr56SjYQs9B24LBjJ5czhnmTRmKaOJuYtEndQW5DaKFu4PJ9cTX4uq0UfThmDTCMyE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132

Hello,

I have hit this issue again while running perf regression CI in our 
environment.

This time, the issue was hit on 
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=c70fc32f44431bb30f9025ce753ba8be25acbba3.

The recreation steps remain the same.

However, manually recreating this issue seems to be difficult. If anyone 
has any hints or tips for recreation, please let me know.

Thanks,

Srikanth Aithal <Srikanth.Aithal@amd.com>

On 4/9/2025 11:17 AM, Aithal, Srikanth wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hello,
> 
> The earlier email bounced for some reason. Resending it again, sorry for any inconvenience.
> 
> While performing a kexec with
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=3e816361e94a0e79b1aabf44abec552e9698b196,
>    warning was hit, followed by an oops and hard lockups.
> 
> Recreation steps where the issue was observed:
> 
> 1. Built and booted
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=3e816361e94a0e79b1aabf44abec552e9698b196
> with attached kernel config.
> 2. Installed LKP [1] and ran autonuma benchmark via LKP. Below is the job file:
> 
> #! jobs/autonuma-benchmark.yaml
> suite: autonuma-benchmark
> testcase: autonuma-benchmark
> category: benchmark
> autonuma-benchmark:
>     test: numa02SMT_numa01THREAD_ALLOC
>     iterations: 1x
> job_origin: "jobs/autonuma-benchmark.yaml"
> arch: x86_64
> 
> 3. The autonuma job completed successfully. Afterward, the test kexec'd into the same kernel (sched/core[3e816361e9]). During the kexec, the below oops and hard lockups were observed. I have attached the full log.
> 
> 
> [  OK  ] Stopped Remount Root and Kernel File Systems.
> [  OK  ] Stopped Monitoring of LVM2… dmeventd or progress polling.
> [  OK  ] Reached target System Shutdown.
> [  OK  ] Reached target Late Shutdown Services.
>            Starting Reboot via kexec...
> [30880.154233] ------------[ cut here ]------------ [30880.159530] WARNING: CPU: 60 PID: 1740 at kernel/cgroup/rstat.c:231
> cgroup_rstat_flush+0x4ea/0x7e0
> [30880.169808] Modules linked in: xt_CHECKSUM ipt_REJECT ipmi_ssif
> nls_iso8859_1 intel_rapl_msr wmi_bmof amd_atl intel_rapl_common amd64_edac edac_mce_amd kvm_amd rapl joydev input_leds ccp k10temp wmi acpi_ipmi ipmi_si ipmi_msghandler mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efi_pstore drm autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 hid_generic usbhid ahci ghash_clmulni_intel libahci hid tg3 i2c_piix4 i2c_smbus aesni_intel crypto_simd cryptd [last unloaded: ipmi_devintf] [30880.227826] CPU: 60 UID: 0 PID: 1740 Comm: kworker/60:1 Not tainted
> 6.14.0-3e816361e94a-3e816361e9 #1 PREEMPT(voluntary) [30880.242015] Hardware name: AMD Corporation VOLCANO/VOLCANO, BIOS RVOT1003E 12/11/2024 [30880.250988] Workqueue: cgroup_destroy css_release_work_fn [30880.257172] RIP: 0010:cgroup_rstat_flush+0x4ea/0x7e0
> [30880.262848] Code: 0f 85 e1 fd ff ff 66 90 48 c7 c7 60 ad a7 aa e8 0c 0b f9 00 e8 f7 92 f8 00 85 c0 75 02 f3 90 8b 55 c8 83 c2 01 e9 46 fb ff ff <0f> 0b e9 8e fc ff ff 65 8b 05 0c 40 48 02 48 0f a3 05 b0 d6 f5 01 [30880.284380] RSP: 0018:ff581bf4d4057da0 EFLAGS: 00010046 [30880.290362] RAX: ff8a1bf4b547ed20 RBX: ff8a1bf4b3443fe0 RCX:
> ff3ea4ba8bea4000
> [30880.298536] RDX: ff3ea4ba8bea4000 RSI: 0000000000000100 RDI:
> ff3ea4f9460616b4
> [30880.306703] RBP: ff581bf4d4057e18 R08: ff3ea4ba8ba71000 R09:
> ff3ea4f9460616b4
> [30880.314879] R10: 0000000000000282 R11: ff3ea4f99b6b1000 R12:
> 00000000000000d9
> [30880.323054] R13: 00000000000000d9 R14: ff3ea4ba8ba713e0 R15:
> ff3ea4ba8bea4000
> [30880.331228] FS:  0000000000000000(0000) GS:ff3ea4d9a4771000(0000)
> knlGS:0000000000000000
> [30880.340491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [30880.347071] CR2: 00007f4320220b80 CR3: 00000002eb2b6004 CR4:
> 0000000000771ef0
> [30880.355246] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [30880.363411] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
> 0000000000000400
> [30880.371585] PKRU: 55555554
> [30880.374677] Call Trace:
> [30880.377469]  <TASK>
> [30880.379865]  css_release_work_fn+0x6a/0x280 [30880.384654]  process_one_work+0x19e/0x3e0 [30880.389244]  worker_thread+0x2ad/0x3c0 [30880.393533]  kthread+0x108/0x220 [30880.397225]  ? __pfx_worker_thread+0x10/0x10 [30880.402113]  ? __pfx_kthread+0x10/0x10 [30880.406402]  ret_from_fork+0x3d/0x60 [30880.410495]  ? __pfx_kthread+0x10/0x10 [30880.414783]  ret_from_fork_asm+0x1a/0x30 [30880.419274]  </TASK> [30880.421767] ---[ end trace 0000000000000000 ]--- [30880.427054] BUG: kernel NULL pointer dereference, address:
> 00000000000003d8
> [30880.435030] #PF: supervisor read access in kernel mode [30880.440914] #PF: error_code(0x0000) - not-present page [30880.446797] PGD 10c466067 P4D 0 [30880.450489] Oops: Oops: 0000 [#1] SMP NOPTI [30880.455275] CPU: 60 UID: 0 PID: 1740 Comm: kworker/60:1 Tainted: G
>       W           6.14.0-3e816361e94a-3e816361e9 #1 PREEMPT(voluntary)
> [30880.469630] Tainted: [W]=WARN
> [30880.473020] Hardware name: AMD Corporation VOLCANO/VOLCANO, BIOS RVOT1003E 12/11/2024 [30880.481993] Workqueue: cgroup_destroy css_release_work_fn [30880.496263] RIP: 0010:cgroup_rstat_flush+0x15f/0x7e0
> [30880.509926] Code: 00 00 0f 87 06 06 00 00 4e 8b 1c dd 80 0f d7 a9 4c 8b 45 d0 4d 01 dd 49 8b 95 a0 00 00 00 49 39 d0 0f 84 2b 05 00 00 4d 63 ec <48> 8b 82 d8 03 00 00 49 81 fd ff 1f 00 00 0f 87 68 05 00 00 4c 01 [30880.547238] RSP: 0018:ff581bf4d4057da0 EFLAGS: 00010086 [30880.560939] RAX: ff8a1bf4b547ed20 RBX: ff8a1bf4b3443fe0 RCX:
> ff3ea4ba8bea4000
> [30880.576665] RDX: 0000000000000000 RSI: 0000000000000100 RDI:
> ff3ea4f9460616b4
> [30880.592201] RBP: ff581bf4d4057e18 R08: ff3ea4ba8ba71000 R09:
> ff3ea4f9460616b4
> [30880.607522] R10: 0000000000000282 R11: ff3ea4f99b6b1000 R12:
> 00000000000000d9
> [30880.622685] R13: 00000000000000d9 R14: ff3ea4ba8ba713e0 R15:
> ff3ea4ba8bea4000
> [30880.637740] FS:  0000000000000000(0000) GS:ff3ea4d9a4771000(0000)
> knlGS:0000000000000000
> [30880.653936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [30880.667349] CR2: 00000000000003d8 CR3: 00000002eb2b6004 CR4:
> 0000000000771ef0
> [30880.682262] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [30880.697046] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
> 0000000000000400
> [30880.711708] PKRU: 55555554
> [30880.721341] Call Trace:
> [30880.730617]  <TASK>
> [30880.739413]  css_release_work_fn+0x6a/0x280 [30880.750598]  process_one_work+0x19e/0x3e0 [30880.761488]  worker_thread+0x2ad/0x3c0 [30880.771986]  kthread+0x108/0x220 [30880.781791]  ? __pfx_worker_thread+0x10/0x10 [30880.792795]  ? __pfx_kthread+0x10/0x10 [30880.803225]  ret_from_fork+0x3d/0x60 [30880.813347]  ? __pfx_kthread+0x10/0x10 [30880.823693]  ret_from_fork_asm+0x1a/0x30 [30880.834279]  </TASK> [30880.842867] Modules linked in: xt_CHECKSUM ipt_REJECT ipmi_ssif
> nls_iso8859_1 intel_rapl_msr wmi_bmof amd_atl intel_rapl_common amd64_edac edac_mce_amd kvm_amd rapl joydev input_leds ccp k10temp wmi acpi_ipmi ipmi_si ipmi_msghandler mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efi_pstore drm autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 hid_generic usbhid ahci ghash_clmulni_intel libahci hid tg3 i2c_piix4 i2c_smbus aesni_intel crypto_simd cryptd [last unloaded: ipmi_devintf] [30880.936605] CR2: 00000000000003d8 [30880.947860] ---[ end trace 0000000000000000 ]--- [30881.217743] RIP: 0010:cgroup_rstat_flush+0x15f/0x7e0
> [30881.230964] Code: 00 00 0f 87 06 06 00 00 4e 8b 1c dd 80 0f d7 a9 4c 8b 45 d0 4d 01 dd 49 8b 95 a0 00 00 00 49 39 d0 0f 84 2b 05 00 00 4d 63 ec <48> 8b 82 d8 03 00 00 49 81 fd ff 1f 00 00 0f 87 68 05 00 00 4c 01 [30881.268075] RSP: 0018:ff581bf4d4057da0 EFLAGS: 00010086 [30881.281948] RAX: ff8a1bf4b547ed20 RBX: ff8a1bf4b3443fe0 RCX:
> ff3ea4ba8bea4000
> [30881.298015] RDX: 0000000000000000 RSI: 0000000000000100 RDI:
> ff3ea4f9460616b4
> [30881.314116] RBP: ff581bf4d4057e18 R08: ff3ea4ba8ba71000 R09:
> ff3ea4f9460616b4
> [30881.330209] R10: 0000000000000282 R11: ff3ea4f99b6b1000 R12:
> 00000000000000d9
> [30881.346333] R13: 00000000000000d9 R14: ff3ea4ba8ba713e0 R15:
> ff3ea4ba8bea4000
> [30881.362294] FS:  0000000000000000(0000) GS:ff3ea4d9a4771000(0000)
> knlGS:0000000000000000
> [30881.379255] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [30881.393613] CR2: 00000000000003d8 CR3: 00000002eb2b6004 CR4:
> 0000000000771ef0
> [30881.409535] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [30881.425335] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
> 0000000000000400
> [30881.441045] PKRU: 55555554
> [30881.451577] note: kworker/60:1[1740] exited with irqs disabled [30881.465615] note: kworker/60:1[1740] exited with preempt_count 1 [30893.634139] watchdog: CPU156: Watchdog detected hard LOCKUP on cpu 156 [30893.634143] Modules linked in: xt_CHECKSUM ipt_REJECT ipmi_ssif
> nls_iso8859_1 intel_rapl_msr wmi_bmof amd_atl intel_rapl_common amd64_edac edac_mce_amd kvm_amd rapl joydev input_leds ccp k10temp wmi acpi_ipmi ipmi_si ipmi_msghandler mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efi_pstore drm autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 hid_generic usbhid ahci ghash_clmulni_intel libahci hid tg3 i2c_piix4 i2c_smbus aesni_intel crypto_simd cryptd [last unloaded: ipmi_devintf] [30893.634169] CPU: 156 UID: 0 PID: 91861 Comm: kworker/156:0 Tainted: G
>        D W           6.14.0-3e816361e94a-3e816361e9 #1 PREEMPT(voluntary)
> [30893.634173] Tainted: [D]=DIE, [W]=WARN [30893.634174] Hardware name: AMD Corporation VOLCANO/VOLCANO, BIOS RVOT1003E 12/11/2024 [30893.634175] Workqueue: cgroup_destroy css_free_rwork_fn [30893.634183] RIP: 0010:native_queued_spin_lock_slowpath+0x80/0x300
> [30893.634191] Code: 2c 24 08 0f 92 c2 41 8b 04 24 0f b6 d2 c1 e2 08 30
> e4 09 d0 a9 00 01 ff ff 75 69 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3
> 90 <41> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c [30893.634192] RSP: 0018:ff581bf510c0fd08 EFLAGS: 00000002 [30893.634194] RAX: 0000000000000001 RBX: ff8a1bf4b747b8a0 RCX:
> 0000000000000000
> [30893.634195] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ff3ea4f9460616b4
> [30893.634196] RBP: ff581bf510c0fd30 R08: 00000000000000d9 R09:
> ff3ea4f9460616b4
> [30893.634197] R10: 0000000000000286 R11: 00000000000000d9 R12:
> ff3ea4f9460616b4
> [30893.634198] R13: 0000000000000286 R14: ff3ea4bad765f000 R15:
> 0000000000000000
> [30893.634198] FS:  0000000000000000(0000) GS:ff3ea4d9a4f71000(0000)
> knlGS:0000000000000000
> [30893.634199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [30893.634200] CR2: 00007f4320220b80 CR3: 000000404a660001 CR4:
> 0000000000771ef0
> [30893.634201] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [30893.634202] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
> 0000000000000400
> [30893.634202] PKRU: 55555554
> [30893.634203] Call Trace:
> [30893.634205]  <TASK>
> [30893.634208]  _raw_spin_lock_irqsave+0x46/0x60 [30893.634211]  cgroup_rstat_flush+0xf4/0x7e0 [30893.634214]  cgroup_rstat_exit+0x20/0xf0 [30893.634215]  css_free_rwork_fn+0x12e/0x400 [30893.634216]  process_one_work+0x19e/0x3e0 [30893.634221]  worker_thread+0x2ad/0x3c0 [30893.634223]  kthread+0x108/0x220 [30893.634225]  ? __pfx_worker_thread+0x10/0x10 [30893.634227]  ? __pfx_kthread+0x10/0x10 [30893.634228]  ret_from_fork+0x3d/0x60 [30893.634233]  ? __pfx_kthread+0x10/0x10 [30893.634234]  ret_from_fork_asm+0x1a/0x30 [30893.634239]  </TASK> [30940.158820] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [30940.172867] rcu:     156-...0: (0 ticks this GP)
> idle=e8f4/1/0x4000000000000000 softirq=427128/427128 fqs=4630
> [30940.191257] rcu:     (detected by 12, t=15010 jiffies, g=639685,
> q=26165 ncpus=256)
> [30940.207160] Sending NMI from CPU 12 to CPUs 156:
> [30940.207166] NMI backtrace for cpu 156 [30940.207169] CPU: 156 UID: 0 PID: 91861 Comm: kworker/156:0 Tainted: G
>        D W           6.14.0-3e816361e94a-3e816361e9 #1 PREEMPT(voluntary)
> [30940.207172] Tainted: [D]=DIE, [W]=WARN [30940.207173] Hardware name: AMD Corporation VOLCANO/VOLCANO, BIOS RVOT1003E 12/11/2024 [30940.207175] Workqueue: cgroup_destroy css_free_rwork_fn [30940.207177] RIP: 0010:native_queued_spin_lock_slowpath+0x80/0x300
> [30940.207180] Code: 2c 24 08 0f 92 c2 41 8b 04 24 0f b6 d2 c1 e2 08 30
> e4 09 d0 a9 00 01 ff ff 75 69 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3
> 90 <41> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c [30940.207181] RSP: 0018:ff581bf510c0fd08 EFLAGS: 00000002 [30940.207182] RAX: 0000000000000001 RBX: ff8a1bf4b747b8a0 RCX:
> 0000000000000000
> [30940.207183] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ff3ea4f9460616b4
> [30940.207184] RBP: ff581bf510c0fd30 R08: 00000000000000d9 R09:
> ff3ea4f9460616b4
> [30940.207185] R10: 0000000000000286 R11: 00000000000000d9 R12:
> ff3ea4f9460616b4
> [30940.207186] R13: 0000000000000286 R14: ff3ea4bad765f000 R15:
> 0000000000000000
> [30940.207187] FS:  0000000000000000(0000) GS:ff3ea4d9a4f71000(0000)
> knlGS:0000000000000000
> [30940.207188] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [30940.207188] CR2: 00007f4320220b80 CR3: 000000404a660001 CR4:
> 0000000000771ef0
> [30940.207189] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [30940.207190] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
> 0000000000000400
> [30940.207191] PKRU: 55555554
> [30940.207191] Call Trace:
> [30940.207192]  <TASK>
> [30940.207193]  _raw_spin_lock_irqsave+0x46/0x60 [30940.207195]  cgroup_rstat_flush+0xf4/0x7e0 [30940.207197]  cgroup_rstat_exit+0x20/0xf0 [30940.207198]  css_free_rwork_fn+0x12e/0x400 [30940.207199]  process_one_work+0x19e/0x3e0 [30940.207202]  worker_thread+0x2ad/0x3c0 [30940.207204]  kthread+0x108/0x220 [30940.207205]  ? __pfx_worker_thread+0x10/0x10 [30940.207207]  ? __pfx_kthread+0x10/0x10 [30940.207208]  ret_from_fork+0x3d/0x60 [30940.207209]  ? __pfx_kthread+0x10/0x10 [30940.207210]  ret_from_fork_asm+0x1a/0x30 [30940.207213]  </TASK> [30970.132112] shutdown[1]: Unmounting '/oldroot' timed out, issuing SIGKILL to PID 147876.
> [30970.147562] shutdown[1]: Not all file systems unmounted, 1 left.
> [30970.160653] shutdown[1]: Deactivating swaps.
> [30970.171832] shutdown[1]: All swaps deactivated.
> [30970.183280] shutdown[1]: Detaching loop devices.
> [30970.195215] shutdown[1]: All loop devices detached.
> [30970.207077] shutdown[1]: Stopping MD devices.
> [30970.218370] shutdown[1]: All MD devices stopped.
> [30970.229857] shutdown[1]: Detaching DM devices.
> [30970.240989] shutdown[1]: All DM devices detached.
> [30970.252245] shutdown[1]: Unmounting file systems.
> [30970.263405] shutdown[1]: All filesystems unmounted.
> [30970.274714] shutdown[1]: All filesystems, swaps, loop devices, MD devices and DM devices detached.
> [30970.296039] shutdown[1]: Syncing filesystems and block devices.
> [31000.308656] shutdown[1]: Syncing filesystems and block devices - timed out, issuing SIGKILL to PID 147892.
> [31000.325333] shutdown[1]: Rebooting with kexec.
> [31086.440252] watchdog: CPU232: Watchdog detected hard LOCKUP on cpu 232
> 
> 
> No luck in recreating the issue yet. In addition to the test scenario mentioned above, I also tried running stress-ng with cgroup stress for some time and performing kexec in a loop, but I could not recreate the issue. I also see similar issues reported here: [2], [3].
> 
> If there are any pointers to help with recreation, I would be happy to try them out and report back here.
> 
> 
> [1] https://github.com/intel/lkp-tests.git
> [2]
> https://lore.kernel.org/all/6564c3d6-9372-4352-9847-1eb3aea07ca4@linux.ibm.com/
> [3]
> https://lore.kernel.org/all/tencent_084EDA1878C098FFB951DC70F6FFCC896408@qq.com/
> 
> Thank you,
> Srikanth Aithal
> 


