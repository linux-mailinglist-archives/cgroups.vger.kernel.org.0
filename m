Return-Path: <cgroups+bounces-16035-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOcyHEweC2q8DgUAu9opvQ
	(envelope-from <cgroups+bounces-16035-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 16:12:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE456E727
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 692853024A33
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C448AE02;
	Mon, 18 May 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UdbplvIQ"
X-Original-To: cgroups@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B923339875;
	Mon, 18 May 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113231; cv=fail; b=Pk4BY+br2d9edQd1+VqgxQt/6rsNX7x+y4w6cXj4R0YN1BgDnT0/vIHOiS1nySpgEbjQg2GVgoXkHzXqODajMVYXv4NBF2ytNjvxQKro1NpHUYUM4plcQIpy37Tx069mhde/VsOoycf4vnIDtSh9SmQMx75oUNKUkeHZ4AyKTIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113231; c=relaxed/simple;
	bh=DcBBcDz+RZYXF4N6fXmG+KWYDZr0jZZeuEfDwlDrOxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0P8MxWSzMBhVjusTvGdhw92GoFbpE10js1h27xuyyvzw3BHKqcnHry8CsSo6hw3au+ToVLva0Skf0hAE9f63paO7yR8eDbLV4m9/Q+GWJaI8SQBSVn+ZlmW2aKEsIefuq0CiupcY084VKrbh/s/yUN3Oh2ruIEVDza+yfAmK0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UdbplvIQ; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbS+pGiBrCmW11GoHj0NOa2GVMLVbzqm21AK/8ZOxsXGk1r9RY5f2fheQ35cjrwYAnzEBgi6RkpNtk3iAz4VmE/8ExBEZoNsW4FwLthvofeOjyUJhThIwMaBAcI4DU6b+fMZlsd2Rn1c7vcTNEZfZjVHCuspB9bRYn3306sQ2pLjsQWig50ZrOeoQXFJ7TmMVVp6hQ86VoTrqO5rxYVDuNXVJmeeR/LZe6AYocRQp9/8Ha+46yfvyvFG4ma3JjIE55gdaPnyJVvwak6X2jV/nmFCX424Yr9jVgAhHvj3B2kNPQRWOcLtHQ4ds8OEKtYRUDdgUOfvwYJJERzQyqQ5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWOQllWq8tBdwYD97bk8HHpRxY8kZ/JxczwmHc/UYK0=;
 b=EKSKvuTXrlW/YTKFTv5jMZVQYSwSxxV+UIEV3ygsgZ5Q1v2ycVscjj2I1O6H0KtGlbz33rZSsTApioTTVdY0DwSZll5B7yrlMYZTip+zaFapoWSvvOL1zZqfjD/GqrvLLXVe7Js/zlw+2CTDqGAEJXqfo4dHZdXQCgwHt1KI9mS3Ow5Vqc3kc18yaChEok6K9d7bknjR4bGKlx42DneAbDADNmCnAUZfir3LGCpJ8VhCgwkWg8CEkHSrbZsIblxMiDtfsDjm4txzjNRaLXBgtRYZqGnj/948ZIl5o7K7/pZtAzRdn03mp5V9TCe/8bh0rXVV66xjRVRJFHESUwzJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWOQllWq8tBdwYD97bk8HHpRxY8kZ/JxczwmHc/UYK0=;
 b=UdbplvIQCCTtVxnGyLICMhL4tTLbSrEbOl8JZZ8+GcBCJp7xfuLxHnoA/phkEmaimw4b8AsWOmB/M3Mx7I1GoTACUcOeFk3l1bE2Acsb8vzDex3Y+tOTEy0T4OIh/3fArHvSREd9R1JnCR/sL//XOMulnRO+XpV6slWnVt26H80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 14:06:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:06:58 +0000
Message-ID: <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
Date: Mon, 18 May 2026 16:06:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit
 memcg
To: Albert Esteve <aesteve@redhat.com>
Cc: "T.J. Mercier" <tjmercier@google.com>,
 Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mripard@kernel.org, echanude@redhat.com
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
 <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
 <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:36e::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a92aa7e-30e2-41f0-08d7-08deb4e6b95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	MTxVJYUC6oD2/Jyu9bmX1RkSfALK/i20sOCExY9n6J5g8wOv4uRJOs9t8l0K/wCNa9yEkTnLOLLn86+ew0caGK4DowXN1YABNzoY4sn1Mgzs8DyIqygxfR8c8CfzcEFBf0AjU125YFLsnit9pCo/ARfIbZCzbrt4X8pa1bDpzNolb1YNFlhk6b3Q4TLmSgDHfac7yU/y5j2td+gd5HNwi2qWhYCICI3dqZgy1cD80GvqoS0d3un9yTLXq+/oVqwhFm5yJAjh0KDff1MAX1Dr6ZRy6PtOKYWN37YfORRtVGcCR3SxsK7Kl1I/pGEITEvvlg1FmnEEL+6TDoB8/Rmq7kVmt2KE/jL6wA0t9j7rzshk7K5j1UbBNas2JmejFtaFQD/U8lrg+4Px6QFcf148+QPr+oyDiEr4Wg4jGDFJBy1m3vlfnX9i2RXoPMqdpQ45GeWfmYV6balclpP94tjoqLYWi4KGlY2bzMKPdN9/tJCVwjc6U01Q8EJnAIhZE4/3lPw6ha+NBTNIIsTYD0Q3hN3ALY3YI29SUSh9/WKZtKsBoTZiUo/5SKgwiFIwe4WHMs9R5nU3OuRAjrd5BTqt/Gtz852k7cS80KSFw3Tqm8vp6FW/4lXHb990yXYQawtyh1D6SN4MJBx3pCyof8+QHsJxAyWnXPS0jwjinGCWzz2tj7kX0I/XQ461sgk4JTYA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NStXMWw5YzJEYjRDL1hrTWlSVkxRRjJ1MUEzOFczbGozUHF3c1N0RVFESGNk?=
 =?utf-8?B?MWdTS3c5cjlWaGFES1V3dXJvVHcvMS9Nc1ovU1dEWEd2SlNVMGttdzNxWjJJ?=
 =?utf-8?B?ZGpQaUd2RGYrRTMySzJMTElvNFhMYkdsMEwzUHVGY2pvWTY0UkZjMyswUFlW?=
 =?utf-8?B?OEU1YWFvaS9lQkFyWkxGWEJOZVVlQTQvcCt4QnJIRDFjSlRjUkR2K2x5V2d5?=
 =?utf-8?B?UHBvSktEM0VwWVpXL0lTRFdXTTRMRmdvaU53TzBMRlI2QTVLK1RiUGNGV1Jt?=
 =?utf-8?B?UzZiZUtEdUFza0VjT21yNWJ0WHRSOTYvMUd5V1NxZm1vRGNZc0NNOEtCTGVR?=
 =?utf-8?B?a1RyejFkMXNnZytCcUZRWTExOTdzbTl0OEdCanVYekdGV2pwKytRanBOWE0x?=
 =?utf-8?B?K3NiZWFWZ2tmSzJCdVZxWUdXWGtzNW5aRnZiZGRCUW9IT0ZoTkUvK1hreVAv?=
 =?utf-8?B?Y3QyTFdBSjcwMWdjZis1RG11dVBUWXNLK204enNTK2VQRWR4dTRBRnVQWFJI?=
 =?utf-8?B?RW5KU0xXaytadEswQkV5dytlNWM2U1lwc0FHUWhDSFBncHFXY3dCMmxlSklL?=
 =?utf-8?B?R01td1EremVWNXRNRFBIaU1PM2RFT1F6NW5qdnFRU2NpayttOTJ5YnRoTVpz?=
 =?utf-8?B?TEIzUVgxSEJjMzJwa3lXWkNOemlYUlFYdHpmUTVMbmF6a3BvTHNFRk9RUTl4?=
 =?utf-8?B?bTNiRmhKTnVGY3VTaFZXS09PNzVyb2Y1Um9TNzFLeDdpVGh3aU9zL204ZHVz?=
 =?utf-8?B?ZkR5YmEzMFRobWVpbW5BMDB5Z015VzBwQlFOU01tVE1yendFdXlYT3cvS3VZ?=
 =?utf-8?B?cWlQQjl1b1Z5OEthMU5QTkw2Tzd1L3dXeTFDd2N5eFRhZkJpd21mWUd0RXc2?=
 =?utf-8?B?bS9VMGRKaFJJL3dLcjdZREJISk5aNHVTc0xOOFo4VzFXS3RMK01RTFQ1MktV?=
 =?utf-8?B?SWMwV2dYaW9EVWNabWovMGw3VUtwMDVFaEl5L2RrR3k4MDI2VWp2V0t6Z0Qx?=
 =?utf-8?B?SlowQmNDWmhBY21ubnhra2VRQ05sckNPaXVXcXpGcUtkamNNdHZOVG44OTB1?=
 =?utf-8?B?N0hTQW8xcDYzalE5VkxSejU0MlhEcWd2OFFhc1Mwbng5d1oyU2F4VWgzdXhr?=
 =?utf-8?B?TWtEaWNneDQrcE52U29vSjJLd1pRZjdTTWVOSmxKZGQ0ZGFFYXRPd3N6ZjV6?=
 =?utf-8?B?aHU4c2hROTFENHNYQ1M5SFVTdUl2dyt6VGpvRnBJSE9mRnZRK08vQTI3Qmxi?=
 =?utf-8?B?U2x5U3RJTGF0Q2N0d3Q2TDFqV09oYnNrSi9mKzlybncrQzBwcmFmY0NkVlIz?=
 =?utf-8?B?R1l4T3VOMURpSWZMelJWQkthSmxZYU5iQjRjL05hQmpkTGVkc3JoeW9xT1Q0?=
 =?utf-8?B?UUM3SUR0Tmp6OC9TVWJGRWpBcDdRQ1Z1NzF4M0JvZ1hjTEtYUU40RWlSNW0z?=
 =?utf-8?B?L1IyM1BXOFlzdG91RTJGaXlpd0hVQkNhSVowaTVRQ1lETW0xTitveTRiMDVO?=
 =?utf-8?B?dW9xQjFnSmxRTGdaWFF5Q0dpL2dHVmUvTUJpUm44MDZmUmIycUowUHRmd3Fw?=
 =?utf-8?B?U1YzcjRpamVFeDFqWFB1TEFZbFhudTJncEhFYzJ0YnFSRndUa3hWZ241eEFR?=
 =?utf-8?B?Rkk0OFJ4MlBmSWNzZThzbnVLZDd6T25qUU80RU9TYlZrQmRhQWZOVkorMVBp?=
 =?utf-8?B?dm0wK2V5TWs0OGw5dmw0ajM2QXJ1ZnZVR21WTEY1UkhiS0dyWE1JcnV6TkY0?=
 =?utf-8?B?R01NSzZuSENzR0VmTGJxN1BydUxHM2p4RlBCVy95TS9nOEYzb2ROUDVuSk8x?=
 =?utf-8?B?MCsvdG9IdVV4MVhYU2RTU1ZhK3FmczRUMFpIUlh3K0l4aGdwVGRwWHdDZW1V?=
 =?utf-8?B?MFgwMCtJdUFjekFtUW5OOFYwRTd2N0FsMWlydjJxcUZWZkEyNk0vZGszb0Rh?=
 =?utf-8?B?cFkxUUNVdkJMdzlXMkxYMWVZbnljTTN2bjM0RVVxNVMyb0NVZFREUDJzVkc5?=
 =?utf-8?B?R2N6Q0JQK0FkV0RacUpReTNneDhDN3N1TDVyMEhqMldJaTl6dFREZnNPQ2JG?=
 =?utf-8?B?RVJGdGJWdkVIK2E2QUlENzlzRmxQMGQvVzJyWGVBQjE3RjhtUitLYjhOR1Ir?=
 =?utf-8?B?TzBhTHhtQ21sajRSVE01Rk1wbDlwWURYNFM0SHhpeWJuNjJhcUg5Wi9IS2xG?=
 =?utf-8?B?bnNLWWcveC8zNVFJMHRCVTJYUXJPQU5WcXN4K2Nhc2I1MFpLRkMvb0dBSmEv?=
 =?utf-8?B?Uy8ydHNWYUVmL1pnN2xqSUI2TFAzTUl3MUNENU5SM3FiOGNyZGVtUDYzS0h2?=
 =?utf-8?Q?jUHU/iD/wzuKjSwUnO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a92aa7e-30e2-41f0-08d7-08deb4e6b95c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:06:58.0561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k3s3qo2Bg6F0UBvk/Ct9DU87/kj8vMhOFM+3Bq0qWDZ2rG2ZTvbXz5rF9eIep1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16035-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 11DE456E727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 14:50, Albert Esteve wrote:
> On Mon, May 18, 2026 at 9:20 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/15/26 19:06, T.J. Mercier wrote:
>>> On Fri, May 15, 2026 at 6:53 AM Christian Brauner <brauner@kernel.org> wrote:
>>>>
>>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
>>>>> On embedded platforms a central process often allocates dma-buf
>>>>> memory on behalf of client applications. Without a way to
>>>>> attribute the charge to the requesting client's cgroup, the
>>>>> cost lands on the allocator, making per-cgroup memory limits
>>>>> ineffective for the actual consumers.
>>>>>
>>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
>>>>
>>>> Please be aware that pidfds come in two flavors:
>>>>
>>>> thread-group pidfds and thread-specific pidfds. Make sure that your API
>>>> doesn't implicitly depend on this distinction not existing.
>>>
>>> Hi Christian,
>>>
>>> Memcg is not a controller that supports "thread mode" so all threads
>>> in a group should belong to the same memcg.
>>
>> BTW: Exactly that is the requirement automotive has with their native context use case.
>>
>> The use case is that you have a deamon which has multiple threads were each one is acting on behalve of some other process.
>>
>> At the moment we basically say they are simply not using cgroups for that use case, but it would be really nice if we could handle that as well.
>>
>> Summarizing the requirement of that use case: You need a different cgroup for each thread of a process.
> 
> Hi Christian,
> 
> Thanks for sharing this atuomotive usecase. If I understand correctly,
> the actual requirement is attributing dma-buf charges to the right
> client, not putting each daemon thread in a different cgroup?

Nope, exactly that's the difference.

The thread acts as a filtering agent for both memory allocation and command submission for somebody else, the process on which behalve the daemon does things can even be in a client VM, completely remote over some network or even something like a microcontroller.

Everything the thread does regarding CPU time, GPU driver memory allocation as well as resources like GPU processing and I/O time etc.. needs to be accounted to one client which can be different for each thread of the process.

The only thing which is shared with the main process thread is CPU memory resources, e.g. malloc() because that is basically just needed for housekeeping and pretty much irrelevant for this kind of use case.

The problem is now you can't do that with cgroups at the moment but unfortunately only the kernel has the information you need to know to do this.

So what you end up with is to define tons of interfaces just to get the necessary information from the kernel into userspace and then essentially duplicate the same infrastructure cgroup provides in the kernel in userspace again.

> If so,
> the `charge_pid_fd` approach achieves this directly by passing the
> client's `pid_fd`, without needing to add per-thread cgroup
> infrastructure.

Well it's already a massive improvemt, we could basically stop doing the whole duplication part for the GPU driver stack and just use cgroups for this part.

Doing that automatically for CPU and I/O time would just be nice to have additionally.

Regards,
Christian.

> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Checking the flags from pidfd_get_pid would be the best way for an
>>> explicit check of the pidfd type?
>>>
>>>>> a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
>>>>> memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
>>>>> inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
>>>>> the mem_accounting module parameter enabled, the buffer is charged
>>>>> to the allocator's own cgroup.
>>>>>
>>>>> Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
>>>>> system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
>>>>> page allocations. Keeping __GFP_ACCOUNT would charge the same pages
>>>>> twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
>>>>> all accounting through a single MEMCG_DMABUF path.
>>>>>
>>>>> Usage examples:
>>>>>
>>>>>   1. Central allocator charging to a client at allocation time.
>>>>>      The allocator knows the client's PID (e.g., from binder's
>>>>>      sender_pid) and uses pidfd to attribute the charge:
>>>>>
>>>>>        pid_t client_pid = txn->sender_pid;
>>>>>        int pidfd = pidfd_open(client_pid, 0);
>>>>>
>>>>>        struct dma_heap_allocation_data alloc = {
>>>>>            .len             = buffer_size,
>>>>>            .fd_flags        = O_RDWR | O_CLOEXEC,
>>>>>            .charge_pid_fd   = pidfd,
>>>>>        };
>>>>>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
>>>>>        close(pidfd);
>>>>>        /* alloc.fd is now charged to client's cgroup */
>>>>>
>>>>>   2. Default allocation (no pidfd, mem_accounting=1).
>>>>>      When charge_pid_fd is not set and the mem_accounting module
>>>>>      parameter is enabled, the buffer is charged to the allocator's
>>>>>      own cgroup:
>>>>>
>>>>>        struct dma_heap_allocation_data alloc = {
>>>>>            .len      = buffer_size,
>>>>>            .fd_flags = O_RDWR | O_CLOEXEC,
>>>>>        };
>>>>>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
>>>>>        /* charged to current process's cgroup */
>>>>>
>>>>> Current limitations:
>>>>>
>>>>>  - Single-owner model: a dma-buf carries one memcg charge regardless of
>>>>>    how many processes share it. Means only the first owner (and exporter)
>>>>>    of the shared buffer bears the charge.
>>>>>  - Only memcg accounting supported. While this makes sense for system
>>>>>    heap buffers, other heaps (e.g., CMA heaps) will require selectively
>>>>>    charging also for the dmem controller.
>>>>>
>>>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>>>>> ---
>>>>>  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
>>>>>  drivers/dma-buf/dma-buf.c               | 16 ++++---------
>>>>>  drivers/dma-buf/dma-heap.c              | 42 ++++++++++++++++++++++++++++++---
>>>>>  drivers/dma-buf/heaps/system_heap.c     |  2 --
>>>>>  include/uapi/linux/dma-heap.h           |  6 +++++
>>>>>  5 files changed, 53 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>>>> index 8bdbc2e866430..824d269531eb1 100644
>>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>>>> @@ -1636,8 +1636,9 @@ The following nested keys are defined.
>>>>>               structures.
>>>>>
>>>>>         dmabuf (npn)
>>>>> -             Amount of memory used for exported DMA buffers allocated by the cgroup.
>>>>> -             Stays with the allocating cgroup regardless of how the buffer is shared.
>>>>> +             Amount of memory used for exported DMA buffers allocated by or on
>>>>> +             behalf of the cgroup. Stays with the allocating cgroup regardless
>>>>> +             of how the buffer is shared.
>>>>>
>>>>>         workingset_refault_anon
>>>>>               Number of refaults of previously evicted anonymous pages.
>>>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>>>> index ce02377f48908..23fb758b78297 100644
>>>>> --- a/drivers/dma-buf/dma-buf.c
>>>>> +++ b/drivers/dma-buf/dma-buf.c
>>>>> @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentry)
>>>>>        */
>>>>>       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
>>>>>
>>>>> -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
>>>>> -     mem_cgroup_put(dmabuf->memcg);
>>>>> +     if (dmabuf->memcg) {
>>>>> +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
>>>>> +                                       PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
>>>>> +             mem_cgroup_put(dmabuf->memcg);
>>>>> +     }
>>>>>
>>>>>       dmabuf->ops->release(dmabuf);
>>>>>
>>>>> @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>>>>>               dmabuf->resv = resv;
>>>>>       }
>>>>>
>>>>> -     dmabuf->memcg = get_mem_cgroup_from_mm(current->mm);
>>>>> -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE,
>>>>> -                                   GFP_KERNEL)) {
>>>>> -             ret = -ENOMEM;
>>>>> -             goto err_memcg;
>>>>> -     }
>>>>> -
>>>>>       file->private_data = dmabuf;
>>>>>       file->f_path.dentry->d_fsdata = dmabuf;
>>>>>       dmabuf->file = file;
>>>>> @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>>>>>
>>>>>       return dmabuf;
>>>>>
>>>>> -err_memcg:
>>>>> -     mem_cgroup_put(dmabuf->memcg);
>>>>>  err_file:
>>>>>       fput(file);
>>>>>  err_module:
>>>>> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
>>>>> index ac5f8685a6494..ff6e259afcdc0 100644
>>>>> --- a/drivers/dma-buf/dma-heap.c
>>>>> +++ b/drivers/dma-buf/dma-heap.c
>>>>> @@ -7,13 +7,17 @@
>>>>>   */
>>>>>
>>>>>  #include <linux/cdev.h>
>>>>> +#include <linux/cgroup.h>
>>>>>  #include <linux/device.h>
>>>>>  #include <linux/dma-buf.h>
>>>>>  #include <linux/dma-heap.h>
>>>>> +#include <linux/memcontrol.h>
>>>>> +#include <linux/sched/mm.h>
>>>>>  #include <linux/err.h>
>>>>>  #include <linux/export.h>
>>>>>  #include <linux/list.h>
>>>>>  #include <linux/nospec.h>
>>>>> +#include <linux/pidfd.h>
>>>>>  #include <linux/syscalls.h>
>>>>>  #include <linux/uaccess.h>
>>>>>  #include <linux/xarray.h>
>>>>> @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
>>>>>                "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
>>>>>
>>>>>  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
>>>>> -                              u32 fd_flags,
>>>>> -                              u64 heap_flags)
>>>>> +                              u32 fd_flags, u64 heap_flags,
>>>>> +                              struct mem_cgroup *charge_to)
>>>>>  {
>>>>>       struct dma_buf *dmabuf;
>>>>> +     unsigned int nr_pages;
>>>>> +     struct mem_cgroup *memcg = charge_to;
>>>>>       int fd;
>>>>>
>>>>>       /*
>>>>> @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
>>>>>       if (IS_ERR(dmabuf))
>>>>>               return PTR_ERR(dmabuf);
>>>>>
>>>>> +     nr_pages = len / PAGE_SIZE;
>>>>> +
>>>>> +     if (memcg)
>>>>> +             css_get(&memcg->css);
>>>>> +     else if (mem_accounting)
>>>>> +             memcg = get_mem_cgroup_from_mm(current->mm);
>>>>> +
>>>>> +     if (memcg) {
>>>>> +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERNEL)) {
>>>>> +                     mem_cgroup_put(memcg);
>>>>> +                     dma_buf_put(dmabuf);
>>>>> +                     return -ENOMEM;
>>>>> +             }
>>>>> +             dmabuf->memcg = memcg;
>>>>> +     }
>>>>> +
>>>>>       fd = dma_buf_fd(dmabuf, fd_flags);
>>>>>       if (fd < 0) {
>>>>>               dma_buf_put(dmabuf);
>>>>> @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>>>>>  {
>>>>>       struct dma_heap_allocation_data *heap_allocation = data;
>>>>>       struct dma_heap *heap = file->private_data;
>>>>> +     struct mem_cgroup *memcg = NULL;
>>>>> +     struct task_struct *task;
>>>>> +     unsigned int pidfd_flags;
>>>>>       int fd;
>>>>>
>>>>>       if (heap_allocation->fd)
>>>>> @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>>>>>       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
>>>>>               return -EINVAL;
>>>>>
>>>>> +     if (heap_allocation->charge_pid_fd) {
>>>>> +             task = pidfd_get_task(heap_allocation->charge_pid_fd, &pidfd_flags);
>>>>
>>>> Will always get a thread-group leader pidfd and will fail if this is a
>>>> thread-specific pidfd. pidfd_open(1234, PIDFD_THREAD) can be used to
>>>> open a thread-specific pidfd.
>>>>
>>>>> +             if (IS_ERR(task))
>>>>> +                     return PTR_ERR(task);
>>>>> +
>>>>> +             memcg = get_mem_cgroup_from_mm(task->mm);
>>>>> +             put_task_struct(task);
>>>>> +     }
>>>>> +
>>>>>       fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
>>>>>                                  heap_allocation->fd_flags,
>>>>> -                                heap_allocation->heap_flags);
>>>>> +                                heap_allocation->heap_flags,
>>>>> +                                memcg);
>>>>> +     mem_cgroup_put(memcg);
>>>>>       if (fd < 0)
>>>>>               return fd;
>>>>>
>>>>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
>>>>> index 03c2b87cb1112..95d7688167b93 100644
>>>>> --- a/drivers/dma-buf/heaps/system_heap.c
>>>>> +++ b/drivers/dma-buf/heaps/system_heap.c
>>>>> @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsigned long size,
>>>>>               if (max_order < orders[i])
>>>>>                       continue;
>>>>>               flags = order_flags[i];
>>>>> -             if (mem_accounting)
>>>>> -                     flags |= __GFP_ACCOUNT;
>>>>>               page = alloc_pages(flags, orders[i]);
>>>>>               if (!page)
>>>>>                       continue;
>>>>> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
>>>>> index a4cf716a49fa6..e02b0f8cbc6a1 100644
>>>>> --- a/include/uapi/linux/dma-heap.h
>>>>> +++ b/include/uapi/linux/dma-heap.h
>>>>> @@ -29,6 +29,10 @@
>>>>>   *                   handle to the allocated dma-buf
>>>>>   * @fd_flags:                file descriptor flags used when allocating
>>>>>   * @heap_flags:              flags passed to heap
>>>>> + * @charge_pid_fd:   optional pidfd of the process whose cgroup should be
>>>>> + *                   charged for this allocation; 0 means charge the calling
>>>>> + *                   process's cgroup
>>>>> + * @__padding:               reserved, must be zero
>>>>>   *
>>>>>   * Provided by userspace as an argument to the ioctl
>>>>>   */
>>>>> @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
>>>>>       __u32 fd;
>>>>>       __u32 fd_flags;
>>>>>       __u64 heap_flags;
>>>>> +     __u32 charge_pid_fd;
>>>>> +     __u32 __padding;
>>>>>  };
>>>>>
>>>>>  #define DMA_HEAP_IOC_MAGIC           'H'
>>>>>
>>>>> --
>>>>> 2.53.0
>>>>>
>>
> 


