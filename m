Return-Path: <cgroups+bounces-16028-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMjTNrbDCmoI7gQAu9opvQ
	(envelope-from <cgroups+bounces-16028-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 09:45:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 298A45680C6
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C5E03024013
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 07:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD93E0721;
	Mon, 18 May 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uBIVhf/f"
X-Original-To: cgroups@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0C38BF63;
	Mon, 18 May 2026 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089663; cv=fail; b=ZFTWUCAZvpndbvwxUbvL1WGThb1YW12XdR11vTVQJlcBMjmpT/W31yvIfvizWKY7r/riz91cHDHdPZ5VwTgIuZC9RQA4u8kAie88oxeQfuvvw1hfTfl08LHbzz67Jp30LmenfwI5ikEb1lGnqxuioqZXmXLzIpzXs7YhIFGPldM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089663; c=relaxed/simple;
	bh=I+T57Ilzv2uUwgXRJxE/kfQTKDjtTaleYykfycqGrYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eh9SmXUlcSHg33p2WZwX999Hq5xygNNeqsus6b37ibGSgWlrCuFyKFLelZo3LyGGTQpJILhLPgQ7qntqwJDhd6HRYbUSJ6kDmk6CP/VeSx1RswbeZnbHKcEYLZ/0yrLwSoTdw8QLUw4iBpNOcm96t57/N7FmXdTXDzTbEqhkPOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uBIVhf/f; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6jShW/h+ZKD6v5odz7fpHB2bXt0+WrwsafEIyoBSkElbEst7rkFi+PafGPFFJ5UeMwGJoaK0l4ZXWBwprmnMEUAbCXlnN+yyGWxLQH4zBBx/th1wElc7PABELauC7Fm8Y/73VfmzD9TztzheE62TicN/4dIFZTa1fwrHdXAiPWWpHh6hBFU+T5hxQw1PH1mBYRR7JCTJgcbO4PXwq7KSdWjdjVmlZiyx4mhSOY60deVXGRDjgQ/1G8pUdLcH+w31EgYDsnGVN6tdN8LzXoAsRUK8fl/dbv6x5GgnsqyS7ATucfOssrLN9h2gg11VLfYTrnGueqjVysVnHZQk5/Wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGK1Fc3IZVi27vk7jBfZylC+6MP/Pejak+VnOxftD/s=;
 b=KnCNPPqGk77rPsFRDt7FgF8XbnK+php/4O/Fs7ToF3fpS150qzmUQvxqqbzmHPtAXwqKXK6QpLh188F1CR7TvqTBnN9b71Bmq4rq6zDIiRq+NiudP0U1/HIQsYTC0yDpQoR02m4YdMBTg35BJA2xyCVQ7JoLNg6x5bykxswTwBQ2YyQG3j/g2llbG4wPTevI9g+tFDSrrtozrT8PGJc5944oIQ9qiPmnDuFTwUE1hzbaCSZfQXy/z1CDx4lZhUZCbVzaeCa+FYoAoydubEllEb4E3njoznDZhIElmWSwKTw8xMYI2gQjOp8JBQOmGqyLzLAHOy5JkPwZ8NVZYpmGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGK1Fc3IZVi27vk7jBfZylC+6MP/Pejak+VnOxftD/s=;
 b=uBIVhf/fvieTFEFZs2OVD6895O1RoTHheTs8tsTxulsReZ1Dh/LZOclWzSOV/hWZrKqflLyD0hCqcWGIdZ6DEd3v1b12uJvIEQRCgqKKQItgTu0lK0lwKCwJujnPnrP7IUDVbydFqZWWzLzjs7wUeXKtIx8FVZZa9zFMuluncMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 07:34:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:34:17 +0000
Message-ID: <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com>
Date: Mon, 18 May 2026 09:34:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: Barry Song <baohua@kernel.org>, "T.J. Mercier" <tjmercier@google.com>
Cc: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri- <devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mripard@kernel.org, echanude@redhat.com
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
 <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com>
 <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
 <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba71726-fef0-487e-f64e-08deb4afde19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Rz36V3JIkquESeE/DPFbosgntqxhqt/jDujZFBZDb1Ogtbj4OQgLJtz7mdlR0MxOIWkOqmgfPsgIdYqDlbubBariIyQ8R2hiHPfnEWeiA1D27vD/p53H5MorgRfXzx7U8tq/9gSQ7kW+xlOjOqV3lWeX7HPOEsPQSAW4ikR/bxFa4iBrqT++LedFyj2moTbKttnCN5ZB3gXLgWMqTgZqcBGy8GaU8rVpwxF8ZzP07gE33ZwcO9VWm9eYrPQ8LCYACE0gWNCwxZZA9XeNpz2Fmt+WTDB7/53UJAJDk+NPYMfd2LSlkB8vE4dCLQRmMNJxh5sZjbugmsqMK6NMsJw+CbD6mD2K7sRdsrkRRkrCL+Bc2GyN21ZJVuh4xIptIWlIGA5SD2iXVBJ9iDp12SttiupFOecfp5gmYwvdW/HWedT0GUdhLI6Cp2H5XZUt/js1WvDMUi04ZK41VPGHxS4X+Yx1daPSVec1+0rngORI+lzQo75PnL0vHvxwoMAZybtnrt5VmpvtSjEsB8nrhGC0iZ0l3br7WrpWDoc5xHX86LUtonTGY6u3+GdnADPQ/B2M5tixXduShHOpJu+zzgYT+lxRNuDwW2NmRZ2czjcgh1KA2X5DejpxRFZz57VF1oqMjLaMO7MxAhpcTdQwd4bvCKn5MS6rXJwIGYBktHP0GdzLmX6NKcjB2HVS4PeRqAu9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjN2QVN5WW4vRzViUFZ0dVhsT0Q3RnRvU3pVU1h5NWV2bnJST2pBbkxyNWo0?=
 =?utf-8?B?b05KZ0JjVnAwUzhXWnEva0hSVk1Db29JVmtqZlJhbDd3T2twd0FrYk1TZVQ0?=
 =?utf-8?B?NWxxbU1kci9qN1pnV0JEVjlKSzRuZWRpUHRLRDgzSjVoTENPVkp3YmhMNDBi?=
 =?utf-8?B?bWZJb3pMN2hsemE4TG9RRkZQMXVkWDE1OG9HRlBBS1lrZmthczhHa1dzWEVJ?=
 =?utf-8?B?NVZrdkhtYThVd0Z4Tkd3SXNPL3lwTEdwbkM2TSs1V3gvYS83N3U1eXF2NHh3?=
 =?utf-8?B?QTdHUFhaQnMwU0xmd2kyWnhxQlhsOWd5bkF5dXRqREVXMWdrdXY0Q2ViUlZu?=
 =?utf-8?B?QlRDdWtLUm1UQkdaL2RFV1kyNGQrUlRzS21RVS9XWUxzdy9vNlNMcTY1UnRq?=
 =?utf-8?B?b1RwcGFKQ1pmS0EzMkhVUUw0TWg5ZG84dllYczc5UmVvSHJUeExJTzFKaWxM?=
 =?utf-8?B?anViZDZUaldVNEIrYXhtUEdzUDRXK05LL1pncUdBVHFDWTNIUFlDaC9BNW8x?=
 =?utf-8?B?WU5ESTRRQVpQdkhNVzBQcVAyNUMrL3oyakNHT3dyV0YzQXI5Q0hzWWVzUjAy?=
 =?utf-8?B?NjFyQ1kybk1WNE9GY3Q5WGQ1VlJtejVINGUxaUxOeThkRlIwZk9ZWUwvVVky?=
 =?utf-8?B?bElhS2NqWHRYNkR3MzBYQzYvQnZZQldKTnJtR21OOUhHMlRDM1BPdHVSSXQx?=
 =?utf-8?B?NlNObERhTE1DckRmZkRJalFldm9GZk9NVFd0dXBhdnBvMUNxeWlNVS90d1gr?=
 =?utf-8?B?dFRYNmtxdlVXSkN1cnBHT1J1UDc3dXNnNkIrV01sazZFeVo3VVcvS2FlM1Jr?=
 =?utf-8?B?L2hWbCtHRU5WZy82aGx6OVVxTThLR1hRaURSNlo5MTNnOTdYVk5NUVI2WHR1?=
 =?utf-8?B?K0U1WE5xdGtMR0wzRTJ2STBQcXk4YkpqemJHU1J1M091Q3JlVk9yMVp0dDAv?=
 =?utf-8?B?S2FPcDVMd0lDYmhLU2RXVUM5ekZxWE9QWTFmeURaciszdllyUGpWVVl0Y3dl?=
 =?utf-8?B?aElnQlNJaTNwZmhnTlpDRXd3Q3QrVW9nQVFzKzhjYTZtc1NoSUFXeGxrd2pJ?=
 =?utf-8?B?cG9WQjUyencxSGRyclVhUHllYjFLc0kyd0UxTlRTZDlldnlyU1hkVkFCRjZJ?=
 =?utf-8?B?RC82VDlDaUY3VFVMb1JWS3h3eVBpcHpWQlZEcXBBcjQ0TmtzeGZJZnU4bHhH?=
 =?utf-8?B?UVBBa2ErWFh1R0xEaEpBZ0lxeTU2T2p0ZythenlPQXMvVlZkZm5rc3FUNXpB?=
 =?utf-8?B?VmRaazdTY2JoZ1NvL253eEdXVHR1K3RtQXZaUlcvZDlhaTdVbmI4WlJYVG1E?=
 =?utf-8?B?dDZ2d28zSStsYWpFVklOZVZmR2NnUDgzWVRTZHgxOUNoM2FlMzAxQjFJL293?=
 =?utf-8?B?SUtEZTRzcjhnd3MyZ1ErekpONWZZZ01aMXg5TThURWhiWmNXM3l5dHdvTzMx?=
 =?utf-8?B?OEJwd2xYaVJoWmdhTFYvVzEvV0YwNUdpUmdUVTVYZ28xaHgwZ1V2TzkvVlNX?=
 =?utf-8?B?TURZZXZjTURRa2dJKzdyeHRQejdzdktaM1dVZ3I0VnVvOXFBSHpNRWZGMURL?=
 =?utf-8?B?d0ZFYUpkOTJhQVhCMllwdEdYZ1NOc3NYOTh5RDRJUTJrMS9lNHN1VFZrb0hL?=
 =?utf-8?B?SXljSlFVL0d2ZGhJaDJxNVBYbVdRRzdaY1hhSTZ6ZGpzbGJjSC9VMldPUUpZ?=
 =?utf-8?B?UThJTnd4Tm02UE5lbVpkK0kyVWVPM2Nma2dTVk1kVmFDMWU5R1ZJem15bXNL?=
 =?utf-8?B?eWsrY2RyL2wxWUpiOVRoQ0RwdHZFYXRqMmFycHlhdjBvRlFtN0JJWDVsdTlV?=
 =?utf-8?B?aXY5em5GVnJuWHdDM0FJVE5lQkRTV0xuNXVkV1ZNczZTTk1QZ2ZCWmw2NFpz?=
 =?utf-8?B?SVJrTXlxYTNhMm9vSWR0bUdUeGwxa2x2NldLVEhBNDBFY0JmY3ZIeWZaM3dS?=
 =?utf-8?B?SkZHYW1RMXlzekVBU2diSE5CT1RKVzdzT0NGcUNkSm1tREVNVlJJNHdHckoz?=
 =?utf-8?B?NWhITFlLN01JQTBBdGpFM2lzUCt2bDRlUFltTzVMMnFqSjJFNEhuRllRRzBS?=
 =?utf-8?B?ejZDZ0pTZjZTUG9qdFRlcThGSUhFVU16NlFyRjRxeFY4NUovcDExSWxLQ1V2?=
 =?utf-8?B?ZGZtN3lTT3BtTnY4OHI0U3A3NEtUUDIxN1J2WmZSSTl0eFd1ZWdlZXpObE82?=
 =?utf-8?B?TjRoRUhpK3VXL0pHNDkrd3hrNlJrUW02MmxQRGlNYTRQK0dyL2l0QmlHekNJ?=
 =?utf-8?B?M2xEclNLNjNTVzNISXAzanZReHpEMGxxd2d6Q2dIOCtacWI4WWlacWFuR3l6?=
 =?utf-8?Q?izuDB4c3QEpID/cTUJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba71726-fef0-487e-f64e-08deb4afde19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:34:17.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTYc+kXojVBuwAvXkRpJsgRPNSmUM5Y0Q5JghRCK9k9Y4iDqIe+OiSYcXx9z1Gqk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
X-Rspamd-Queue-Id: 298A45680C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16028-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/16/26 11:19, Barry Song wrote:
> On Thu, May 14, 2026 at 12:35 AM T.J. Mercier <tjmercier@google.com> wrote:
> [...]
>>>> I have a question about this part. Albert I guess you are interested
>>>> only in accounting dmabuf-heap allocations, or do you expect to add
>>>> __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
>>>> non-dmabuf-heap exporters?
>>>
>>> We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
>>> controller are on the radar for follow-up/parallel work (there will be
>>> dragons and will surely need discussion). For DRM and V4L2 the
>>> long-term intent is migration to heaps, which would make direct
>>> accounting on those paths unnecessary.
>>
>> Ah I see. GEM buffers exported to dmabufs are what I had in mind. I
>> guess this would only leave the odd non-DRM driver with the need to
>> add their own accounting calls, which I don't expect would be a big
>> problem.
>>
> 
> sounds like we still have a long way to go to correctly account for
> various v4l2, drm, GEM, CMA, etc. In patch 1, the charging is done in
> dma_buf_export(), so I guess it covers all dma-buf types except
> dma_heap, but the problem is that it has no remote charging support at
> all?

No, just the other way around

DMA-buf heaps can be handled here because we know that it is pure system memory and nothing special so memcg always applies.

dma_buf_export() on the other hand handles tons of different use cases, ranging from buffer accounted to dmem, over special resources which aren't even memory all the way to buffers which can migrate from dmem to memcg and back during their lifetime.

>>> udmabufs are already
>>> memcg-charged, so adding a separate MEMCG_DMABUF would double count.
>>> Are there any other exporters you had in mind that would benefit from
>>> this approach?

Well apart from DMA-buf memfd_create() is one of the things which as broken our neck in the past a couple of times.

But thinking more about it what if instead of making this DMA-buf heaps specific what if we have a general cgroups function which allows to change accounting of a buffer referenced by a file descriptor to a different process?

That would cover not only the DMA-buf heaps use case, but also all other DMA-buf with dmem and whatever we come up in the future as well.

The only drawback I can see is that DMA-buf heap allocations would be temporarily accounted to the memory allocation daemon, but I don't think that this would be a problem.

Regards,
Christian.

> 
> Thanks
> Barry


