Return-Path: <cgroups+bounces-3535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D5926D6D
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 04:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163E91F22D86
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 02:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C80125BA;
	Thu,  4 Jul 2024 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FU2Edfxk"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4B14F90;
	Thu,  4 Jul 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060164; cv=fail; b=MoHAHU2SRDqCpXFLE7l84+x3TwPtz+LbwqU5j5wOfGNvSrbOjHsiwFdvRtZ5kqND54vdPJ1XwJkRgY62k2tURrn0QmSFKWC4arf6lEinr10PFSml5iQWgeCDuhB92TrKQm7t3H+W5orM3V+OgHSFBbdIK/zBkfhAzSoVjMrtAOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060164; c=relaxed/simple;
	bh=AVOEo7k90us99XbSgZBytNuAUHUCp+Y3hLhZItgd+5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A/oClp4dNozmnCezX6WAvRWz8H9CEMMB6DTV+oajGIOjnPlWSY0tmXtYmAGSC+OWnyfFRRYd6Oow04WXeyzJUHTIfP1Yods69w0z9QqAQegr6TMJxa6mLbx9XgsYnYx/ZV3WefSE19RYB+2pJAx3CGf2m74KAmwsiA/Dm9rqS70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FU2Edfxk; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqmMY4FrhlJVAjeX/AyuM2l9THPneoCS1IPl0rIzbN4bu2ylqDzfijtZyrKOHSBz8ZGMg61J4woUdu9iBeObWUSfp3UTrPISPG2f95GTqnH3XaRDR6Nr3NsV8IFF7Ciw+CpoeNvRWb3mUsM01fYFmht9QYv5zYf2j4ZhtCZsZ3mZ2pHvpmM8s/yVL7SQiAKelQ+ceXT7VN/FwFewhlm1qBJQMMyoavLaTkx8qPUmcMhDuolw5LbwXjI83F1T1s+38b3B6fQy9l+YlALUKLnpSm3/OmYGzvsLLLkjkKVnsXj3FCBVuAGgQ8NWCtAFSEdBOMZ0BX7eNimDKTmI7RT/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70h+1z3IuLP6kn4AZ/1QygZ4ZUApyiIUn8eTep4HB2I=;
 b=N/pamYuoBK+SRYDh0LF3DCT363XiFXq+baDhNzFTB2huXR2gwLr3BKO5jL7aD8tgZ1zydz1mNK6Sd7JZlV/aRb8AUktAK30ityc5mo8WFlsHRUZ8iIq/qesIl0bObxk+MmYSIFdtnpPa6u6POX+s2OG4yG32qWl/JyEKeN26VuQScBSntpxc560hkdLvdtJcDWOn1OIRBvwMTGNsH12XPIJlQSBFnCkZe8NF99iqf6MdpnyY8DxJlp85WRr/Q8MGhbY776r8RDoQjMKYi6nlht0ExVHHtAAzoE/BFDRKeWTCzuQOzYPl7eIwpFV4JOUBE41HlZURlifiSoJ1E/N7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70h+1z3IuLP6kn4AZ/1QygZ4ZUApyiIUn8eTep4HB2I=;
 b=FU2Edfxki3PnBA10nk1OvyQJTjZNioePUwm1WVbfw13m5lFZ253YQly3Qp0eVgMNh4gP6oCIDBuGkapWClNN/cQ7SmcO29/YPsZIjyZ9yopu4FJifxuIj5xYBhvSE+bP4HgypGMI1/rgCL/O4NpyY5A3a6pulaRY+GbgLwPswO1rD5QR9pE1VE+FRuIb0vOngd3h/U04mzj01Ghl8350107y5lIez6g9Cki9PLQ89Yzp6MnVRWUfLY42zutJy7vXvESMR7H92j3RU8EpIGtHPZfaMbNL8qAZk9yUTtO8lSuQqP48vWKsnjQrn6CO8fFZX/12kX1cSyn5p7AaOjDJTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB5958.apcprd06.prod.outlook.com (2603:1096:101:e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Thu, 4 Jul
 2024 02:29:17 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 02:29:13 +0000
Message-ID: <ff1e3407-d8ee-4696-bd8d-cab4e162f42c@vivo.com>
Date: Thu, 4 Jul 2024 10:29:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Introduce PMC(PER-MEMCG-CACHE)
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Chris Li <chrisl@kernel.org>, Dan Schatzberg <schatzberg.dan@gmail.com>,
 Kairui Song <kasong@tencent.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, opensource.kernel@vivo.com
References: <20240702084423.1717904-1-link@vivo.com>
 <ZoRUukQUNqGHn_x1@google.com> <27a62e44-9d85-4ef2-b833-e977af039758@vivo.com>
 <CABdmKX3+3YQMOynNyKgE-+XbS8Et4o-_s9ieWGwvUnWUUtSYqg@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CABdmKX3+3YQMOynNyKgE-+XbS8Et4o-_s9ieWGwvUnWUUtSYqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: f445f53c-9c79-4e97-0c68-08dc9bd117ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1RHcnFnWno2N0dyaTMvUHhMb0J2bEtIaFlIYnNWT25YeFdVbWhvM1E2bTc5?=
 =?utf-8?B?L2haclNlVXFtWUlDNW53R0FBcDFiVkEwcE1zMXQrZ3V5c0psTUtERzNMdTds?=
 =?utf-8?B?S2w4RTdBZWh4cW5QSE1OTWRZV0FaUmNwMUFhRU13S3grVVJwbjlNS2hSbXJG?=
 =?utf-8?B?SjY5NFJqV1hpK00zNWw2NUduaXlZN29uRXZ4U2ZwVE9kVGNMZ3FvOXdGTEJC?=
 =?utf-8?B?Z2Rac3FUT0lrZnBNdVh5YzdHZGZudjI5NjZ6QktiMmNtSFk5S2lDNlR1N2VK?=
 =?utf-8?B?ak94MEVaSGhoc2pyaHhxSXlac0NCWi85ZjFJR1NRclA1K3NRYTNQNXgzcWVr?=
 =?utf-8?B?RUo5S1pzRkRvNGZ4SzdXQnRRWGV3aFhhaFpwYjRBWlFFcWREaG9YLzE4cE9h?=
 =?utf-8?B?RzBPbjRTUGRjRGtUckF6RzRidGNvUG1QclZFV0JFQjRxcWRHNTUybnVCZjRl?=
 =?utf-8?B?cVVGUWtBSTVraGIrMUNTekR0ODNEUEpVNEw0LzQzRlhjZUphMlMzR1RIUmVY?=
 =?utf-8?B?dnBMNkVQOVFFbTdiMkZHSG1LU1RhQStYU1E2U2xMUkVLZHNDOGp4TWtxU2Y5?=
 =?utf-8?B?SEZoV3Q5WU1TYTVzSWUvMWY0VEl0b3htU0dhMlBhdHNPUFRoTGF1bGdTTnB4?=
 =?utf-8?B?RTdlVEp0L1kxUGFyVW5oZWFZSS9SZFdQdU1CdkZHWkVOVmR2MlpiQ3IwTmRV?=
 =?utf-8?B?Q0MvSk9MNnc4UzkvK2FheTQ4dWxGek9oZUltLyt3YVROQUdwTytTSk1CVW4v?=
 =?utf-8?B?SnNhWGZmcjhSZ2djMHpkK2c0YXdESGpMY2VONEVja1EvWWlFTjZERDh2d1lx?=
 =?utf-8?B?RnBCY1lMbnJxaEtGYmErampoYi8vbDhMZUxEWS9PSTh4Y0Y4QndhWnZLMmpU?=
 =?utf-8?B?V2pvYWJPSDdybE8wNXlLOFpoZkdZeXFqb3BoYkJNVXFrWjNYa2NHejNybUJD?=
 =?utf-8?B?TGJGS0Q4Ujg2OUp3L0JST2pEZUZvK0pKUmNoWnpmQUxQRE9ZZ0xQOFJxU1Zr?=
 =?utf-8?B?c2gzRnovRXN1L1NSREc4MmF0Uk9Xdkt1T0hOUDlQb3lvYlVTNGYzU1NKZCs3?=
 =?utf-8?B?L1ZlcjVOc25IUjBzb0xyM3pKV2ZtUHlxbXpjVlZ4bmlSMzh4WTFZeWFGUjNo?=
 =?utf-8?B?VSsxYlRHSjdRQzIxbEg5S1FjcEtIWmVBUUVNNUlBejcxSVNDdzB4RklVaVJ4?=
 =?utf-8?B?Q1lZeEd5RHZrcFBQRmRaM3E5YXpwK1MxZnpIbk5NYzhnS2pDSDgyd00xSk91?=
 =?utf-8?B?Zm1JUTFCWkxyZUZkbFVXOU5jSXNMOWkyalRDT3o3c3FTSmt1TE5xRGZkVmc0?=
 =?utf-8?B?ckNlN0RYTWVkbEh4bW1ERUc2c0YxR1gzQWRFaUpyZmhaMlgwZ3pnZVFBZkJ0?=
 =?utf-8?B?N1lQVU1HUEVCdEhBM3MvR2ZRSHBrTHNLa2kwOGl6dW5Rb0NPek0wejRTYWtN?=
 =?utf-8?B?bkd0SHlhbUk1QmhwWmM3U1A4UG5vUU9palp3OHlVb3NRRTVCcng3YzBCcGI4?=
 =?utf-8?B?Z1dNZWswaW1GcTN2MndqcWEwV1VPamhnbjVuQnVkZkpHVHFRaVdhMXo2VlFV?=
 =?utf-8?B?dWpYWmdnMlY0dHh0bkhTaGRTY3JZaE9YanB4bWVtYXVDS1ZQVzRHR2Z2UXpY?=
 =?utf-8?B?K1RGT3NPK0xMbEVFbDhYZHZmNkVZVWVoQzZzQUU0SmtDTWovTzdBUFIyMDI1?=
 =?utf-8?B?NW5waDhYbjV1MWJWNW9mQzZnSk80Mmo5UXlyNS9ock02dFcwSU9OYjlSZzFj?=
 =?utf-8?B?Y2xJWjN0bUorYjRKdnp0am9LZ1JKWjVlVzUxdlZybXgzb2pCdHZGclI1N1Vn?=
 =?utf-8?Q?HLXQQ0ZZcNLZfHOviK3z3/QW3VaM2w9FsxRDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDB6aGJRS2lZbjZrTUJJcFlHM1kydVoxenV0bEM2OGV5b1ZldDBYcjZweFNj?=
 =?utf-8?B?M0hVWHJpTTBKU0hseUhURTNxS3FTS2JiSFRXZ1dxR2cxUW84MFdhTDl5NjNP?=
 =?utf-8?B?SGFQS3pGYUsxbUQzb0V1U0Y3NGJpakZTRjJ0Y3lMY1ZzYVhiWFVNaTFmRWhn?=
 =?utf-8?B?T0k2RCtEc2RRVFl6aXlwOEJISjhnMW9ldTVFR3BUSkk1NUZ0Rkt0S3Fncmwx?=
 =?utf-8?B?VWJtMG53bkxvUTdNc0M3VE9RRUVrYW84a09hdkVRL1dWSnA2TEV6VmhMU05m?=
 =?utf-8?B?NEdhbk91c1BTajFNYm1NWkRGd2swZGJNQ3d6enE0L2NhNGZIOWk1YnZRd09L?=
 =?utf-8?B?b09rOGpkdFljY1VidFgxeGxrV2NxZnN1d2tMODJCaGZZSUpwZnlHaUY4TFM0?=
 =?utf-8?B?eVJWN1JuSG5JMXMzS1FjL2xoaW1XOVhXdmRXeHpTZ3VFQVNCbm43OC9pRFdC?=
 =?utf-8?B?R3JTNG45QnlEd2lUS0twRFR6a3dyODV1VEtPM0cySTFZWDdRNUdHaVZrWHNi?=
 =?utf-8?B?NU10S2Z4RzlSUkE5NVo5aGNHdFZ6NVA1bTNOZDByYk9Jd3NiNUplK05lcXNE?=
 =?utf-8?B?V3NScWYwUmJyV0twZDlxNTZieG9jejJRbVYwTkFNZWJRRFlPYjRBZFhCK0tK?=
 =?utf-8?B?VEd2aHJXWXVmdzJIWElYb0FjdVhrMU81LzBuZjJDWnRRNWdjNldNdE5zL2cv?=
 =?utf-8?B?WS8vUGhFQVJIc0srL01XMUkyeUM5VEZNZHhHNGhZYzhmVjRrbGRCQjBUMXNJ?=
 =?utf-8?B?ZWw1TmFvRVoxODZzUm9CeE40dUJhcUNFQW5ESEM5SFkyOXZtbGhoRGZIbFl0?=
 =?utf-8?B?YitJcWlkZGFSNnNyY1Y5NkdScC9xWWN3d2Jjc0tsS1cvbFRrZSt3d3N3aGkx?=
 =?utf-8?B?RFZOc1d3M3dSaVlJL2lJcDJQc1dRc25Nc0FBS1FlZ3hTY3YwT3FvaVAyZWsw?=
 =?utf-8?B?dnBkUENhU1UwaHh2Q3BNQUhtQ2taUVNPWkZ2YXcrTlY5dm5TaUZoT0hsMjRI?=
 =?utf-8?B?dFgwcVNjUlBEclkyYUt6OHhpK1dleWU3M01PTTIyb09TU3h6NkwyRXprSzl5?=
 =?utf-8?B?bjAwTXllK1BGZ2c0WlltK0FMckVEcHZ3SnJOSXlvU0VLbEhpK0xIajh6SmNG?=
 =?utf-8?B?c3pkSC9iNTErdERQcU9LZnJ0UG82MFZxaXhCc1Q4U2c0Njc1dC9OS1dZQ1p0?=
 =?utf-8?B?b1Nxamp5dDRHT0o3b2RRRi9hZFN1N2JtL1RXYnRDaHNzNGV6VEJya3Vtajcw?=
 =?utf-8?B?YmZRN2Jpamw4bklleElZdlpDODNhTWpsL3ZRRzQxWXArZFQrUnFudktrM2NT?=
 =?utf-8?B?THlrQ0Q3MjZsQ2xBZURCQy9ZMkJBU1RleVJlY3J1VmxCOCtaRmhjVFQva2Z1?=
 =?utf-8?B?UVA1V2JjNjFKbS9KSEwzWkdTeDl6Tm5nSThOcW93QzhaMFExWGk3dEVmNDRT?=
 =?utf-8?B?R3NYQTV4aEx2OFFZb1dGT2w0QXN0NmtjV0lCWERnZ2pubjc0R0F6Ny81b214?=
 =?utf-8?B?V2E2N2lKUHB2QjMzZWZYYnB3T0h2RnpybFR5NnVibitHNGJrMHNBRzdJWS9q?=
 =?utf-8?B?ODh0SkJRQlgrcmhLT3FxcHBMS3V2bXMvc0QwQlkzNkp3eTgxZzhrT05uanNU?=
 =?utf-8?B?aUFJOW9TTVQ0UytKYk5mSjNkN0duaE0zdFFVbG43LzFyZjZwdW4xbEtDbng5?=
 =?utf-8?B?dDdsanMrNmFlVGtWbExwL1psSmpRdXozSWtYUGNmbElsSkR2TkVlUHV4SkRD?=
 =?utf-8?B?dnZpaXlEZ3pNWlFHTC9yaFExS3E2MzFKU3RLWnFyYTZoazV6aGFRamZLQ2Rq?=
 =?utf-8?B?MUhRSDJNYmNsR1FIbWpBU3pKQVBqakQvZEJqM3N0LzlFZTNQQTJqemcrZmx1?=
 =?utf-8?B?Zy94RlpnVGhLbTlOK1RiR0xyeW5iZmsxWjVleVhrWFlQQWJLTC9aZ3BoNEEw?=
 =?utf-8?B?ZVZkZkl2eGd6SVFEays5Z04zNG5QOGJKR1hwakZhWXFTU1cvc0pGSkdaWXFa?=
 =?utf-8?B?SUM2MEViT1FpeXJRZ3YwaFVTZTEwQU15aEdlMEpsUGthWlAxQnhsODJtNVlz?=
 =?utf-8?B?K1hQVSs5a3RTTVRwSzJkQ1NqUkhlRU0wUWJEYjZxeGdaYkk2WFF6eGVnUHh1?=
 =?utf-8?Q?SyNXD4Nj6MAzf6U0xeVQVAPfc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f445f53c-9c79-4e97-0c68-08dc9bd117ee
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:29:13.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUETr51BrUpHM743kCfgw9l5rCQeYm3N7J2z/ahpD/C+571dWM3ehsoLnz8L/IhQHvUaowdWCIH56HarmCebaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5958


在 2024/7/4 6:59, T.J. Mercier 写道:
> On Tue, Jul 2, 2024 at 7:23 PM Huan Yang <link@vivo.com> wrote:
>>
>> 在 2024/7/3 3:27, Roman Gushchin 写道:
>>> On Tue, Jul 02, 2024 at 04:44:03PM +0800, Huan Yang wrote:
>>>> This patchset like to talk abount a idea about PMC(PER-MEMCG-CACHE).
>>>>
>>>> Background
>>>> ===
>>>>
>>>> Modern computer systems always have performance gaps between hardware,
>>>> such as the performance differences between CPU, memory, and disk.
>>>> Due to the principle of locality of reference in data access:
>>>>
>>>>     Programs often access data that has been accessed before
>>>>     Programs access the next set of data after accessing a particular data
>>>> As a result:
>>>>     1. CPU cache is used to speed up the access of already accessed data
>>>>        in memory
>>>>     2. Disk prefetching techniques are used to prepare the next set of data
>>>>        to be accessed in advance (to avoid direct disk access)
>>>> The basic utilization of locality greatly enhances computer performance.
>>>>
>>>> PMC (per-MEMCG-cache) is similar, utilizing a principle of locality to enhance
>>>> program performance.
>>>>
>>>> In modern computers, especially in smartphones, services are provided to
>>>> users on a per-application basis (such as Camera, Chat, etc.),
>>>> where an application is composed of multiple processes working together to
>>>> provide services.
>>>>
>>>> The basic unit for managing resources in a computer is the process,
>>>> which in turn uses threads to share memory and accomplish tasks.
>>>> Memory is shared among threads within a process.
>>>>
>>>> However, modern computers have the following issues, with a locality deficiency:
>>>>
>>>>     1. Different forms of memory exist and are not interconnected (anonymous
>>>>        pages, file pages, special memory such as DMA-BUF, various memory alloc in
>>>>        kernel mode, etc.)
>>>>     2. Memory isolation exists between processes, and apart from specific
>>>>        shared memory, they do not communicate with each other.
>>>>     3. During the transition of functionality within an application, a process
>>>>        usually releases memory, while another process requests memory, and in
>>>>        this process, memory has to be obtained from the lowest level through
>>>>        competition.
>>>>
>>>> For example abount camera application:
>>>>
>>>> Camera applications typically provide photo capture services as well as photo
>>>> preview services.
>>>> The photo capture process usually utilizes DMA-BUF to facilitate the sharing
>>>> of image data between the CPU and DMA devices.
>>>> When it comes to image preview, multiple algorithm processes are typically
>>>> involved in processing the image data, which may also involve heap memory
>>>> and other resources.
>>>>
>>>> During the switch between photo capture and preview, the application typically
>>>> needs to release DMA-BUF memory and then the algorithms need to allocate
>>>> heap memory. The flow of system memory during this process is managed by
>>>> the PCP-BUDDY system.
>>>>
>>>> However, the PCP and BUDDY systems are shared, and subsequently requested
>>>> memory may not be available due to previously allocated memory being used
>>>> (such as for file reading), requiring a competitive (memory reclamation)
>>>> process to obtain it.
>>>>
>>>> So, if it is possible to allow the released memory to be allocated with
>>>> high priority within the application, then this can meet the locality
>>>> requirement, improve performance, and avoid unnecessary memory reclaim.
>>>>
>>>> PMC solutions are similar to PCP, as they both establish cache pools according
>>>> to certain rules.
>>>>
>>>> Why base on MEMCG?
>>>> ===
>>>>
>>>> The MEMCG container can allocate selected processes to a MEMCG based on certain
>>>> grouping strategies (typical examples include grouping by app or UID).
>>>> Processes within the same MEMCG can then be used for statistics, upper limit
>>>> restrictions, and reclamation control.
>>>>
>>>> All processes within a MEMCG are considered as a single memory unit,
>>>> sharing memory among themselves. As a result, when one process releases
>>>> memory, another process within the same group can obtain it with the
>>>> highest priority, fully utilizing the locality of memory allocation
>>>> characteristics within the MEMCG (such as APP grouping).
>>>>
>>>> In addition, MEMCG provides feature interfaces that can be dynamically toggled
>>>> and are fully controllable by the policy.This provides greater flexibility
>>>> and does not impact performance when not enabled (controlled through static key).
>>>>
>>>>
>>>> Abount PMC implement
>>>> ===
>>>> Here, a cache switch is provided for each MEMCG(not on root).
>>>> When the user enables the cache, processes within the MEMCG will share memory
>>>> through this cache.
>>>>
>>>> The cache pool is positioned before the PCP. All order0 page released by
>>>> processes in MEMCG will be released to the cache pool first, and when memory
>>>> is requested, it will also be prioritized to be obtained from the cache pool.
>>>>
>>>> `memory.cache` is the sole entry point for controlling PMC, here are some
>>>> nested keys to control PMC:
>>>>     1. "enable=[y|n]" to enable or disable targeted MEMCG's cache
>>>>     2. "keys=nid=%d,watermark=%u,reaper_time=%u,limit=%u" to control already
>>>>     enabled PMC's behavior.
>>>>       a) `nid` to targeted a node to change it's key. or else all node.
>>>>       b) The `watermark` is used to control cache behavior, caching only when
>>>>          zone free pages above the zone's high water mark + this watermark is
>>>>          exceeded during memory release. (unit byte, default 50MB,
>>>>          min 10MB per-node-all-zone)
>>>>       c) `reaper_time` to control reaper gap, if meet, reaper all cache in this
>>>>           MEMCG(unit us, default 5s, 0 is disable.)
>>>>       d) `limit` is to limit the maximum memory used by the cache pool(unit bytes,
>>>>          default 100MB, max 500MB per-node-all-zone)
>>>>
>>>> Performance
>>>> ===
>>>> PMC is based on MEMCG and requires performance measurement through the
>>>> sharing of complex workloads between application processes.
>>>> Therefore, at the moment, we unable to provide a better testing solution
>>>> for this patchset.
>>>>
>>>> Here is the internal testing situation we provide, using the camera
>>>> application as an example. (1-NODE-1-ZONE-8GRAM)
>>>>
>>>> Test Case: Capture in rear portrait HDR mode
>>>> 1. Test mode: rear portrait HDR mode. This scene needs more than 800M ram
>>>>      which memory types including dmabuf(470M), PSS(150M) and APU(200M)
>>>> 2. Test steps: take a photo, then click thumbnail to view the full image
>>>>
>>>> The overall performance benefit from click shutter button to showing whole
>>>> image improves 500ms, and the total slowpath cost of all camera threads reduced
>>>> from 958ms to 495ms.
>>>> Especially for the shot2shot in this mode, the preview dealy of each frame have
>>>> a significant improve.
>>> Hello Huan,
>>>
>>> thank you for sharing your work.
>> thanks
>>> Some high-level thoughts:
>>> 1) Naming is hard, but it took me quite a while to realize that you're talking
>> Haha, sorry for my pool english
>>> about free memory. Cache is obviously an overloaded term, but per-memcg-cache
>>> can mean absolutely anything (pagecache? cpu cache? ...), so maybe it's not
>> Currently, my idea is that all memory released by processes under memcg
>> will go into the `cache`,
>>
>> and the original attributes will be ignored, and can be freely requested
>> by processes under memcg.
>>
>> (so, dma-buf\page cache\heap\driver, so on). Maybe named PMP more
>> friendly? :)
>>
>>> the best choice.
>>> 2) Overall an idea to have a per-memcg free memory pool makes sense to me,
>>> especially if we talk 2MB or 1GB pages (or order > 0 in general).
>> I like it too :)
>>> 3) You absolutely have to integrate the reclaim mechanism with a generic
>>> memory reclaim mechanism, which is driven by the memory pressure.
>> Yes, I all think about it.
>>> 4) You claim a ~50% performance win in your workload, which is a lot. It's not
>>> clear to me where it's coming from. It's hard to believe the page allocation/release
>>> paths are taking 50% of the cpu time. Please, clarify.
>> Let me describe it more specifically. In our test scenario, we have 8GB
>> of RAM, and our camera application
>>
>> has a complex set of algorithms, with a peak memory requirement of up to
>> 3GB.
>>
>> Therefore, in a multi-application background scenario, starting the
>> camera and taking photos will create a
>>
>> very high memory pressure. In this scenario, any released memory will be
>> quickly used by other processes (such as file pages).
>>
>> So, during the process of switching from camera capture to preview,
>> DMA-BUF memory will be released,
>>
>> while the memory used for the preview algorithm will be simultaneously
>> requested.
>>
>> We need to take a lot of slow path routes to obtain enough memory for
>> the preview algorithm, and it seems that the
>>
>> just released DMA-BUF memory does not provide much help.
>>
> Hi Huan,
HI T.J.
>
> I find this part surprising. Assuming the dmabuf memory doesn't first
> go into a page pool (used for some buffers, not all) and actually does
Actually, when PMC enabled, we let page free avoid free into page pool.
> get freed synchronously with fput, this would mean it gets sucked up
> by other supposedly background processes before it can be allocated by
> the preview process. I thought the preview process was the one most
> desperate for memory? You mention file pages, but where is this
> newly-freed memory actually going if not to the preview process? My
This was discovered through the meminfo observation program.
When the dma-buf is released, there is a noticeable increase in cache.

This may be triggered by pagecache when loading the algorithm model.

Additionally, the algorithm heap memory cannot benefit from the release 
of the dma-buf.
I believe this is related to the migratetype. The stack/heap cannot 
obtain priority access to
the dma-buf memory released by the kernel.(HIGHUSER_MOVABLE)

So, PMC break it, share each memory. Even if it's incorrect :)(If my 
understanding of the
fragmentation issue is incorrect, please correct me.)

> initial reaction was the same as Roman's that the PMC should be hooked
> up to reclaim instead of depending on the reaper. But I think this
> might suggest that wouldn't work because the system is under such high
> memory pressure that it'd be likely reclaim would have emptied the
> PMCs before the preview process could use it.
The point you raised is indeed very likely to happen, as there is immense
memory pressure.
Currently, we only open the PMC when the application is in the foreground,
and close it when it goes to the background.
It is indeed unnecessary to drain the PMC when the application is in the 
foreground,
and a longer reaper timeout would be more useful.(Thanks for the 
flexibility provided by memcg.)
>
> One more thing I find odd is that for this to work a significant
> portion of your dmabuf pages would have to be order 0, but we're
> talking about a ~500M buffer. Does whatever exports this buffer not
> try to use higher order pages like here?
Yes, actually our heap configured order 8 4 0, but In our practical 
application and observation processes,
it is often difficult to meet the high-order memory allocation, so 
falling back to order 0 is the most common.
Therefore, for our MID_ORDER allocation, we use LOW_ORDER_GFP.
Just like the testing scenario I mentioned earlier, with 8GB of RAM and 
the camera peaking at around 3GB,

the fragmentation at this point will cause most of the DMA-BUF 
allocations to fall back to order 0.
The use of PMC is for real-world, high-load applications. I don't think 
it's very practical for regular applications.

Thanks
HY

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma-buf/heaps/system_heap.c?h=v6.9#n54
>
> Thanks!
> -T.J.
>
>> But using PMC (let's call it that for now), we are able to quickly meet
>> the memory needs of the subsequent preview process
>>
>> with the just released DMA-BUF memory, without having to go through the
>> slow path, resulting in a significant performance improvement.
>>
>> (of course, break migrate type may not good.)
>>
>>> There are a lot of other questions, and you highlighted some of them below
>>> (and these are indeed right questions to ask), but let's start with something.
>>>
>>> Thanks
>> Thanks
>>

