Return-Path: <cgroups+bounces-8033-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA254AABAA3
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 09:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DA516C526
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183A527A129;
	Tue,  6 May 2025 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uIu7j4tj"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFEA27F754;
	Tue,  6 May 2025 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508010; cv=fail; b=IjSW8Ey2ddjXnLQwlhiSbgkVk+cHTxZizLK+mZ6r9u/wzgktRud10y3b1pz6ePXHJLl/3ICIKsFEO7YYFpPzbhw5XVlevlKw+wE65sFznmE5qx98PkWJtUBfrJefto2jPElYf644f6uFI4X3GjITcrGw3GV+HbHyYrLV7f8ki+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508010; c=relaxed/simple;
	bh=uHUrg9/L7OHsXb/3Js+oq7XX61NAeG2xsLFnuhKROkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lLR6V3TGkBb17yCsUfHtlcs3XEuSRBgVwxbDn0oIqms4l1oxEQPuVoabaN8Wxx9WODxUA1PK6g26S3eWaC2lfAbI6/662YieqqhAU7wMe9LkQD6EKlqxhFSmCDK1B119eiX0OFKwyEvlqMtI/rQbOpj6g0J2hinK9XYsgYhPmUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uIu7j4tj; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siGpRq/SyGTiHt2VGrWrb7gnOPk8/2ZNUqhOqwv++x8neiXbldojxvjcbggAHiztSOmeb12fI1t+wHNpz/UFgSFyE+kboN9o+JJKd1Bbj+V+Hq884W24Lp7w14ebJvJNUWzbJHZYa75DvaHrY46XkVSVj23t2wpG9HVSw8THR2Bha1B/feecFiQxK6tpHglfrh6LRFab/6J1sHh8VOuPXj6g2MMkzAZ6v5Z0iG0No7qQjwEIBGAHlpnckjWrWiVeChQ7FR/F0EW2g/6e5lzGm/BGraNY/Tre0pM4ANkihT2pum+RGeLzKP06ojNXOsa4Z64qTIiLmeyzjhBPH5PnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yjB1+yLC/NaS4d36hitfV2brNzOG2h/mOwgqUgMtUA=;
 b=C1LlrxEcX7xsccwQh8nIh0GO01DS4mMcCj4M++RIDfJdwzXOqW1T2MyAbzenKSI+L/KO/agdfZgceFy+oWymvQizmuKzzZ0OIX0DFAozK9/aZcYFgGIfKE5EeaS3b1TCJV2iz8o9CukNZ56Es4DDCglZXl1dzUOrkPENwFXvF+VKcE5NnuMf19H9e9/xbNFTpdaAovjUACxTRxGbU9oILeDAqu7eNqJWqovmFqYVXI/l4tnVTGLUYFowESO1vFAA/VtrswbtLy1p/74g+eaZ8fiyWQXP41qtpJj632aVu/kYqVMMgqQZMqJOPakHYY/9rfjJyz8BN0ODUtxi1EHCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yjB1+yLC/NaS4d36hitfV2brNzOG2h/mOwgqUgMtUA=;
 b=uIu7j4tjdV5D2dMEqqaAtroNx4nJOMPy2QH8lvNFG8C6LChOIdPBKTSlcyu6Sg8sbqUr6kLptSDZd96JyD/7SeH5DWZhpq759LGt5417lA/cFB0K5NnO2jzrwYXeX8YhzM7Hdz6CzEmTzHI1DSw+X75tVPPrQ+DysaHu2nAfaQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 05:06:40 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 05:06:39 +0000
Message-ID: <4bf23d62-65a1-439c-991f-365b0612da9b@amd.com>
Date: Tue, 6 May 2025 10:36:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: Libo Chen <libo.chen@oracle.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar
 <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim C" <tim.c.chen@intel.com>,
 Aubrey Li <aubrey.li@intel.com>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Neeraj.Upadhyay@amd.com,
 Peter Zijlstra <peterz@infradead.org>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
 <tkfh4h5ntl42jc2tnwyj6dhiqouf6mowin7euvrnbs2tyiqlay@bpzdptv3plsf>
 <0bdc72c0-8f4a-4d91-8e67-f8d56dc26788@intel.com>
 <5735cb9d-86ae-4c8d-b0b0-5b0365843707@oracle.com>
 <c7444174-fa5e-44c1-bd16-c8971d118b1b@oracle.com>
 <c20fbc3b-5adf-488c-b6f3-0d4e3c9da5c3@oracle.com>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <c20fbc3b-5adf-488c-b6f3-0d4e3c9da5c3@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: de5c8893-37c9-4bc5-3bb8-08dd8c5bc88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzdwR2NqSGllWW9MazkwaE1CZHVGSjJGa0JVUUFvZXh4bjR3MVVpT1V1NnFU?=
 =?utf-8?B?TDJPWlNzMXBTdzI3eDZLTXYrdUt5SFJKejZTeGUvMS81NjEyZGNqLzZQU3F5?=
 =?utf-8?B?eTdTR2Q1aVBZNlZ0anp3bkxUZ0F2cDFPeXhZYkg2aXZrVVp0U3VtUVkyTm84?=
 =?utf-8?B?R09RanNhM1hyaXZSTEh1YWpzSGlQZi9KS0ZxdHJwdUI3ZFcwWUxlYlJnYVVu?=
 =?utf-8?B?UEhqN0xVdjY1MUFHUXdiMVM3UzFzank1R2dpVDdQdW1zY3RhZm1KUjFtYnVv?=
 =?utf-8?B?MVcvWDN5R3lWWFVVbFhMaGw2dUxDNHpJcGlnMHY4UmdNNzZERWREdExpbGIv?=
 =?utf-8?B?KzN5YWplV3g1RnlieGtUMDdHL3dEZzB5dS93Y1pUd0Y1VlNXdWUxbVBQVlhD?=
 =?utf-8?B?Q0M4WWJ6UGxmNFJUZ0tlQ1lrVEk5cHkzKy9nSE1aZmJLTFllT1hSK1NoT1VM?=
 =?utf-8?B?bHVRQzluTGJpVFhzR2NlQVB0bklUeldZR0RPT0lBVHhNd0tZZU5DWVZUdmxL?=
 =?utf-8?B?Qy9GU25ycERXSndhQzdwM1h0WGFHNzNWSDJlaDZ3M3REa2I4ckw4RUxpaEFx?=
 =?utf-8?B?dHRsSjhvNm4vOUdlV1B2ZmkzYnViYldja0VRSmRGTHJGUmlvMk80cmJpMGdw?=
 =?utf-8?B?eXVmNDZZcXkrTXIrenpVdTdCdkExZEUzVXFYK0xaU3VIR1huV0Z2Z2xsbllU?=
 =?utf-8?B?V2xCMitlblRhdy9uTENmVEk0N3poUmltVVpHYysvdWVOdnZKbDBBQVBuQXdk?=
 =?utf-8?B?Uk1pR2kvRjdrUzhHQmVaMDJ2ditjQ3M2MWVtK2h2NUR6RmsxNVlnUjc5WDVM?=
 =?utf-8?B?c21MWnBZbVJTcFJmM0dWUGVZWDQzNmRRL0lVRll1SnQ1c0c2b2ppaHhJc3JH?=
 =?utf-8?B?VVdBSzNmNzRpV2FYYUZuQmFDQzBvbzhURzRqOENWR2ZIMlpydjZweWZLUHJP?=
 =?utf-8?B?U2twcmkrbFlQU0lDbmEzU0Y4UHZhb1I4d3djOU1OeVpkV3c4T3B1QU1QSUlR?=
 =?utf-8?B?aXZlNGNMaVlEMURWTjJNVnNYK2VGd0MzMWlXZUtZc0pIa1FNZm42N2pHcnRF?=
 =?utf-8?B?eDcvcTNVZkFFZTgxcGVURkl4NENXWHlGVjF2cDhzT0YzL0ZqTU8wQnhocnNG?=
 =?utf-8?B?NWE2R3lMVThwZ1hkeGlQWlhGcHRJbGxCMHh6MU8vemF4NHBZQTY4Y1hWSnVt?=
 =?utf-8?B?NGF5Z2MxYk5KOWp3cld0UnFKU0IxK09tVmErVFYyWlRuTng0QkFEakdyS2Iz?=
 =?utf-8?B?dUxRN2lvRUpnRXlwOGkzR3lUYmptOXFoM0d2VHcrc3JtTEZ5d0NpZll1QzAy?=
 =?utf-8?B?WEQvb1UyOUtFNUltalRxR1RkcjdTclVneHVLNUZJanUrcUpJZ3FOSHQ4NXNY?=
 =?utf-8?B?UGpET254SE54U0xHOVovTnk5azJWaDdibGtMMllranVxN3VsZW9HbWxmb0Vp?=
 =?utf-8?B?M3FkYk9WcStFVitVVWMxV09iVzFoZktVRnExWWsxZ1p4UGdJem9NcHpic2ZQ?=
 =?utf-8?B?K1FzanlneldRQlIzM2dybXV0akdMSEI0TnhVblNpTDZKeFBZQVJSV3lzV09h?=
 =?utf-8?B?dllUKzROdDFzL21oQ29mRXJWZjFzZXY1NHlFWjRMaEhEL1NVU2IySU1DNEd0?=
 =?utf-8?B?YlVZUUtxQWlnWFpIK3YyVG9nclRZd1dGb250NXE1VlFMVEE4TDFPNGthSEV0?=
 =?utf-8?B?WVdoT01Vdm1SZlhqR1lFM1o5OXpWUmErOGxPKzlRMUZCdmtKVEZHZTMrM00z?=
 =?utf-8?B?UWRHL21XOFRsNGdjcDFtdzZzSkpqdHhOMVgvaWVjWHRiNjlERG0wTGVxdlJZ?=
 =?utf-8?B?Y0lybE9KNmZCWDNyVHppOHVXdGdObmhPTHk2QktRU0lZYXp2b1VDTVZHL0My?=
 =?utf-8?B?NGsyNWlZT2EwV0Q2RFJRenJjMHZrZ05xVm54dlBlYmZXVGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUtDZzY1MVc2MEVESWZnTmF5em1KbFUrM1J4Y0hGdGxEODl0SVZQSzk3OU40?=
 =?utf-8?B?VFFJd00rRWlZNFBsMnFlV3IrLzV5Z2dyV0FJSmovejZ1SFBydXdobWcybStl?=
 =?utf-8?B?M2VaYzN0dFpKcURrWlhNMGc5SEJoK0x4ei9TeUhqNXorMjVTajFTMjh2OXJY?=
 =?utf-8?B?dzRlOXRFdzVxdk05YXlyajJEZ0lGaFN3R09TaDNJUFBtRStNVVdjUEtvN21F?=
 =?utf-8?B?WEtHTllzaW0zUEFJMXcxMmJsSGptYWFyWDR3TSticmZtbWFIRm05L3FCdHov?=
 =?utf-8?B?RzU3dGh0L1RsOFlLNGFVSFoyNVdMN3NIWWR6SXhVa2oxMCtwYTNYKzdza2tr?=
 =?utf-8?B?Sk9XazdoTjdYcGE1dVNVbE1mejhSdDJNcisyQm9HUnNUY2dpMHlwbG45ajcx?=
 =?utf-8?B?NmFvVEVZVzNBeTdsWm1VKzZMYWthQ3VpdUdVVXZsUk44dGVuUzRpM2ZnbElI?=
 =?utf-8?B?WDJYeEF2bTNrSFJOTHdORFRKSEFnZE5RNEo5SzFkZmZPYkJwZHJNdjBoQ2RU?=
 =?utf-8?B?SDBXekFPTlRUOFhUQURYUHhDVm5FYTAzNDNNZHVpOVFJK2N3a3FXWGVieTYr?=
 =?utf-8?B?d2RWa3FaVmVCUUx4K3NyYzdSZ1ZKc3lqQ040c2lHaEpsaVlySmVhN1Z2SEw4?=
 =?utf-8?B?dFB4Z1lRMXNwVDFkL1dhN1hSN0FuSmIxS2JCSjJkcFFiU2lyTDZXT212TlZQ?=
 =?utf-8?B?U1BQTXpXNDN2RHNlRTVoVmZ3eGNGWkloVVNGWjhBa2tTd0ZmdDcwYU5sWnhU?=
 =?utf-8?B?M1NwWUVqM0NtaS9EeEYyUzQ1ak8zQTEweXRWZVZBeHpWcEFWQlNjWFBYWmpo?=
 =?utf-8?B?S0l5b1Rlc1VsUVVram9NL3FLaG9xOTlSUkRlNjVhdHpHTXJDNmI3MktzeGR5?=
 =?utf-8?B?cFd0MTlyUFR1aTIvcXcyOW8rM3AzVDl2UW9PUGJhM2FQNkxGN1hTNVZrSFFl?=
 =?utf-8?B?VXBXK05EQ3F5UW1NRW1BU0VLYytjZUF0VThGOWZlZDNvcjg3dVJPNzlsMUd5?=
 =?utf-8?B?VjYzZEVycHhBcVMwTFN1d1FqYk5KZ2UrMnhHRjh4Wkhoa3dXS3ZQZ2JPWHNx?=
 =?utf-8?B?QVJjcGZLeFl0MXJ0WFNHaVRmbnlNVy82SVdYL2lhTjRIc1VWQytScGFqMGcw?=
 =?utf-8?B?a1Z5bjZtSjBoLzU1Mzg1N0JDRHZJNXhONEZJU0FKUjJKUDA0aGQ0dWQ3UERT?=
 =?utf-8?B?UytuNlBpN1J1Y2tvUDdHdzRVM0xVTmFXZHlyb3prcVdiOEE2MFluRWpZbjJQ?=
 =?utf-8?B?Mi9ZZlB4Y2h4UWYyb1lqaEtoVk16L3NvMTdlSmtIbk01R1VFNWpUMGt6MWhT?=
 =?utf-8?B?Q21ZcngwYjB1czNUNE5Pcnd4dXpnMU1idVA0N01TZldYeWwyY3B5V3l0cGJW?=
 =?utf-8?B?V2IvK2lQd21qNnVjTklJRkMvdXY4bS9PaWQ3Q05KakdTekg0T0ZnYmljaS9P?=
 =?utf-8?B?T042SGU4aS9YU0FTdCtiRmR5eGM2aVRwOVlhek5XQXZqdUFkVTczdldVR3dF?=
 =?utf-8?B?Zmt2MGw4clE4WEZ1VllvWk9Gbk1mN3E0RkZ4dEtnRFZpM3VZQW9ydFkwbEhi?=
 =?utf-8?B?b0x3WlYwcWJCM2R1K0R6bkhSYXFqUXlBWFhDZ1g3YUR0ekxnQ2R2N1JCODJV?=
 =?utf-8?B?YWtubkNBclZ4L0xDS3JEcHJVRVA4QlcxM2QwSkFubS9kSkZFVUlJaUorbk1l?=
 =?utf-8?B?andUVXhwM3ZtT0xXcUwydFBpTmkzc2Rsc2xxZUVRN3VSc2tKTTdweFJncjZP?=
 =?utf-8?B?bE9HeUhFY1lzeTFaTWlQRVl0V3M3Z3FmTEIvS0g1akp2UmtLeUVaWGhNUmJt?=
 =?utf-8?B?NGFodkw2OGJFNlJ0RDAzSytwb0pUTGtocEtTbGpxelY5WFNZV0ovKzlQTWl0?=
 =?utf-8?B?L3hybDc4YjIrK0N3bUw5UUNhMXMyaXQxK29Fa1IwUlNzMmtPbVJpRWVBZDBX?=
 =?utf-8?B?UjVDSHAyRHpiMnFJbGlaVDlsYUF4TFFOVnh0NVZ5QTdHcHYydkRIdUxlSk95?=
 =?utf-8?B?VUErK0wrYkl5SkZtUVh4ZWhPSjYrdFZURWNwV3JqWmdSSnR0YWxTYWp2N0c4?=
 =?utf-8?B?UVlaTEFIdXJSMUt6Tzc3eFVFMHRzS0JCNnp0UzFyZGhxd0lFRVhXSWtHOWFU?=
 =?utf-8?Q?1RpfR0q6uOXSL4nQqdyWRDaox?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5c8893-37c9-4bc5-3bb8-08dd8c5bc88e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 05:06:39.6280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCh2GhrKVRYot9EezHXK9ViFRhGby5FtqC+qKFQrgosth79RyaPUFapj3sxMUy2y0wLkOoATdo4eNQNAzIqdxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701



On 5/6/2025 3:27 AM, Libo Chen wrote:
> 
> 
> On 5/5/25 14:32, Libo Chen wrote:
>>
>>
>> On 5/5/25 11:49, Libo Chen wrote:
>>>
>>>
>>> On 5/5/25 11:27, Chen, Yu C wrote:
>>>> Hi Michal,
>>>>
>>>> On 5/6/2025 1:46 AM, Michal Koutný wrote:
>>>>> On Mon, May 05, 2025 at 11:03:10PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
>>>>>> According to this address,
>>>>>>     4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>>>>>>     49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
>>>>>> It seems that this task to be swapped has NULL mm_struct.
>>>>>
>>>>> So it's likely a kernel thread. Does it make sense to NUMA balance
>>>>> those? (I naïvely think it doesn't, please correct me.) ...
>>>>>
>>>>
>>>> I agree kernel threads are not supposed to be covered by
>>>> NUMA balance, because currently NUMA balance only considers
>>>> user pages via VMAs, and one question below:
>>>>
>>>>>>   static void __migrate_swap_task(struct task_struct *p, int cpu)
>>>>>>   {
>>>>>>          __schedstat_inc(p->stats.numa_task_swapped);
>>>>>> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>>>> +       if (p->mm)
>>>>>> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>>>
>>>>> ... proper fix should likely guard this earlier, like the guard in
>>>>> task_numa_fault() but for the other swapped task.
>>>> I see. For task swapping in task_numa_compare(),
>>>> it is triggered when there are no idle CPUs in task A's
>>>> preferred node.
>>>> In this case, we choose a task B on A's preferred node,
>>>> and swap B with A. This helps improve A's Numa locality
>>>> without introducing the load imbalance between Nodes.
>>>>
>> Hi Chenyu
>>
>> There are two problems here:
>> 1. Many kthreads are pinned, with all the efforts in task_numa_compare()
>> and task_numa_find_cpu(), the swapping may not end up happening. I only see a
>> check on source task: cpumask_test_cpu(cpu, env->p->cpus_ptr) but not dst task.
> 
> NVM I was blind. There is a check on dst task in task_numa_compare()
> 
>> 2. Assuming B is migratable, that can potentially make B worse, right? I think
>> some kthreads are quite cache-sensitive, and we swap like their locality doesn't
>> matter.
>>
>> Ideally we probably just want to stay off kthreads, if we cannot find any others
>> p->mm tasks, just don't swap (?). That sounds like a brand new patch though.
>>
> 
> A change as simple as that should work:
> 
> @@ -2492,7 +2492,7 @@ static bool task_numa_compare(struct task_numa_env *env,
> 
>         rcu_read_lock();
>         cur = rcu_dereference(dst_rq->curr);
> -       if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
> +       if (cur && ((cur->flags & PF_EXITING) || !cur->mm || is_idle_task(cur)))
>                 cur = NULL;
>

This fixes reported regression.

Tested-by: Ayush Jain <Ayush.jain3@amd.com>

Thanks,
Ayush


>>
>>
>> Libo 
>>>> But B's Numa node preference is not mandatory in
>>>> current implementation IIUC, because B's load is mainly
>>>
>>> hmm, that's doesn't seem to be right, can we choose B that
>>> is not a kthread from A's preferred node?
>>>
>>>> considered. That is to say, is it legit to swap a
>>>> Numa sensitive task A with a non-Numa sensitive kernel
>>>> thread B? If not, I think we can add kernel thread
>>>> check in task swap like the guard in
>>>> task_tick_numa()/task_numa_fault().
>>>>
>>>
>>>
>>>> thanks,
>>>> Chenyu
>>>>
>>>>>
>>>>> Michal
>>>>
>>>
>>
> 


