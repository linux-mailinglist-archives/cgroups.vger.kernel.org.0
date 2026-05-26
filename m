Return-Path: <cgroups+bounces-16293-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B7lIvFQFWqmUQcAu9opvQ
	(envelope-from <cgroups+bounces-16293-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:51:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDC5D1F00
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04039304971F
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016D13911B2;
	Tue, 26 May 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1FLFhHBQ"
X-Original-To: cgroups@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4343CC7D5;
	Tue, 26 May 2026 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781705; cv=fail; b=i5g3mRcBhW38eZaGDbMv0kFXsFoJgVFSc+Eh1cZ+2mbwwoMkBNrEhpQjMbeW6NSZ+ycl/iykIdNafCUbEGV5fY3Rwu3RJnUPVdlef3Tkp6SJjFiTN7o+QP+N2ucjN1I71616ArNMCG4cXc50vFWm3xfcKZbWda8nKUbkF2BMROE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781705; c=relaxed/simple;
	bh=lno7zle2fANiCK2mPq2+3rCthhZuCpevqnmRShK7bZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rqHeodz3EZSC+KiCf3rHd5Bmf63bLiYeUm/W6iFK4AT0xpsgoJK7U6O+FXFVd0PCl2Oqjqf+TtLIVO9Ewecogpk6B5sHTn5uIV1mUMlyD9IHNSMr6BJhiKyuf72TMmEjIPlpeFquNXFXVw5e1kgljJ5fzHtY/UnJz8weciyk5nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1FLFhHBQ; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO7zBMaGYUcky4/eeXgmhHlCsKV0xpZUUJ94sUN2p+q6ujlVrIbD7M8wKhtksPIJ2x01qSoI7iuHEpkm6OPwbcsCtSpcXAvmXANi8c8tUK4QMul3BLA/Dzpvyc/H3sWU3BLA1xCy66NvcUsytoMs/0m1XqpGwysofXdKi4lmx76RsdE5rcgSLC67vi6ugDxA/q62QNOJ7TePOFHRWZqNvpG6xfhRidwAPMlyMUdz6Wkk/3tW7ByWSEqzxQxnO4M0QUrOx8oWUVG/QeSZJch/ES0JqECPgU9So99sMyw6MxZFafXqfT60mo7ngVgMJJOfkWptcz7lGUrV4dI4OclVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzqMnktG7VGvtBCjcsnphYZbqvQVpIRvaPpbrAj+AD0=;
 b=rdR5AeV1tPQP2jlV6oC18M8SFHG09n/FDda/3PVXE9voS3a4HWmUQFQ+iCxGPHkpxip40xfBoVKEwEvbmetvePdbTG3jkzF8q9WY2Z12KmUqC0hC6K1eEDTe7nT+LgEmxkRNQKH0c6tV+4KChGjaFVOyCqRnKvmJvnQwEaf0+ukRBqO2LxSEK6v6x7NhgMEoATUSXVyWNfRE7gNfaSiClDnDgDJLirbo9jZZzTyscKbFyr5H/tMVDFs4sTx4t38LFTW6AGWyGtS0uUgZU4dTXPtz8TmOun+6o930vIz/7lkjCgTZjmbsN5hsRU4r3IZjFmXqdnAO+XV+4s1Dscc8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzqMnktG7VGvtBCjcsnphYZbqvQVpIRvaPpbrAj+AD0=;
 b=1FLFhHBQj1bDgf3FvfUL8pyljFL2DqMvS04etW1Dzy/l2/RcfQshgA3KBBSihkoPrU1LlFuVwjuVuFpJM5Kgck6SWI/FJ/Bh4wwwGBKMRGUIJbTSt4j9fKRlcoc1es7N6pm/OlI65anXpNtXTFJsbWJRNnqBZK6gEgsU14/X81M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 26 May
 2026 07:48:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:48:17 +0000
Message-ID: <5d1a20e5-49b7-4aa0-9473-c978f061b717@amd.com>
Date: Tue, 26 May 2026 09:48:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Eric Chanudet <echanude@redhat.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
 <ahBxB5a9sX9DEWvl@localhost.localdomain> <ahCBrNfiLrh10Vtq@slm.duckdns.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ahCBrNfiLrh10Vtq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: c5503d61-20c8-4a48-4c6a-08debafb25f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4143699003|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0e6EUWWX4NYSh1E6k6ETPMHHxUm9KIXuh+D6tSkkdEN/UnAfEvNR8PTUdr0+UYcbkEjv5oRWIl/YpjYj0b8odyGu63+kP3lKWFPJKAmga6RYM66aDk/EVICTriQAwM/wNozhVyCuktbzvj+sl91L1WDWniUfVXF4PecxfweuIqXUARtCrGZFf4z9pQWkFM/yITxjuyiGE1HO66ZUd0XuorgTuIVm6B/yXWa/TnpGisB2EtGIPRujghuUmxMoTPeBLdOJbGa/r6Is9qYcR+RD4p8ETW2yrTaKOgqtmuY4PNpVWtO39/Mr9Kojxjw4FN+nWz8QOjUrMrcSo2KeYO+53gg2ds9rpzmdOHHCfu6tkTDvljntjf+5zqODVHqdRmzXb4EVF0cMy4/x520LNUC3wprS7KbWl+TKpDOWz0QG7oKxt4R5xlMefWVEwsgHb2OJ6wQLddu0Uu/acnogEXQtb3W0YkGxCJJmBjbBJpCtwntT2Og1OxmAW8KBmqCeeX15ukYH1WC7+nomi2Pnx0xfujI4kEtpFpn/HvM+Gin3j7JIsa56AV9GV3Fky2zb4oCF+0s1ZLX23dTgc0gUtBom1+EDgm74LqR0bgVWOThZMTp7vLRyuIj2iAF6LbGuo1k8mEvahQqEqcyaz26T9XrMm05tH6ODQ3i6C23CT3G4EwWQjDgjURqxDkjVHEp6hta2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnRZaWkvdCtmNk00M2VpTFI4OC9JV0w2QU41Q3FVYVlvRFFYc053V3JVaEtv?=
 =?utf-8?B?Z1VOSmhoRXFya25SbGJJVnJWbGdQTFhGY0h2MXZRblFvOURWWkFBTGg3RlMy?=
 =?utf-8?B?L1lJUW5CS1YrU05iU0dnd0lhdlVkQVhVNGhhVzFYOW82TmNwVEc5RlVjWk5G?=
 =?utf-8?B?RHNRbE9YOGhRSjl4Q3QxYU1JQS9aMS9jamhkbjJxNGFOSzV5RVBtbXpKQll0?=
 =?utf-8?B?NjdVRG81dGlBMEFaVjZvSU5nOW5jTkRBNW5BQWZSR2NZM1VFYnZYblFTaEJo?=
 =?utf-8?B?SVh0WmREaCtJS2FCa0JxVDZpbHd2cGppcDlwVjR4M1hFOXJEM1ZNMEcrbVZ1?=
 =?utf-8?B?K3lWN3YrVWwzcUx4UDVjN0ZkbXVnYVRMSzFJbWZQaEFnTWk3bUdkSklGcGxC?=
 =?utf-8?B?VXp0S2RUaE5PVFJ2YmtIK1NvaWkvT3pkVlFCOUtKM29qVkFRVVpqWlYrOEdJ?=
 =?utf-8?B?UGdzRVdBdWwwN244VmMwODJmaCs0Y3BqSGRTL3cyZzFmdUxJYVJaYm9qTmdI?=
 =?utf-8?B?R3RGejdmMXVNMW1YWHJZR09DcXA2SFdJYk1ydDhWWC9vY2ZDWUZPZ2tJYXBi?=
 =?utf-8?B?ZlpHZm9FSlBsamI2VFFLZkI4bEI0WDY0bHcrUUJtTmpmOGtiRHBjWEthQmMw?=
 =?utf-8?B?RHF3MU9lbnZ0SHFReXp0bVZxSG1SSFZZbkIzNzJpd0ZyYXBjV3JDbG95T1dk?=
 =?utf-8?B?enBWWFZQYzQ0NmMwNDNoWUVyRUFKNXo0VTR1NVhiYzRvczRRVkwxa1MyVFYx?=
 =?utf-8?B?blF5SCtZZFExb3JQcHdySGNVUmlmNWlZU2dkaHZHSGQxbW16a0J1M00rc1VX?=
 =?utf-8?B?NkE0UDhLUjlnRXdQZENRSmVCd0JNL1IvcjNBZUtsMEhRZEVHRlpYc1p2VHds?=
 =?utf-8?B?M0hlNkpVMVBaK1UrRkQyZVVySFRqWVU3Qm5vcW0vRzBONWxMdmZXTy9XaVcv?=
 =?utf-8?B?Nzc5SUZuYUV5NWFienFKWjIwTUl5WFZ6QkpQcnE3VXl3R09yZmN3WmRON01D?=
 =?utf-8?B?amgrN1lnQ3lxSzdRd2t1YWo5aHp5TTMrSDRmMjF0UWdoVGpUUnlQOG5BbXo5?=
 =?utf-8?B?V3ByWnNtTTF2UVJwczdKaXpBcmhtMElpcGlYdlFaQXZJWHBBV1dwMnpVMVBZ?=
 =?utf-8?B?TFpHcEZFcE9oOVQxQktPRi8raUNBZkFneEZHUW1mSFYvb2MzSUU4eGRBV0w3?=
 =?utf-8?B?TjJVZlR0MFlHVlUrSWRBelVJeXlTNFZMNXgwTGZRSkFjNUJ3bmFReEtuV09u?=
 =?utf-8?B?ZDl6Q2hMVml0bzVZOThjZllCa0RwUnJzdFF0dnlobEkrdjNFRlBDVXJlL2Mx?=
 =?utf-8?B?Rm1taFY0SDNLT1ZCbWVURTBCZWFjZjlHMlR3SE1WZkVEMll2cWRqVmZTOHhl?=
 =?utf-8?B?bjVZMG1VK0diOEl1VmlMZ0VkbWI4VTNNVHl0TENKbHdKOGZoeTZaSVNNS1VV?=
 =?utf-8?B?V053c2FqbjdXeko3UW50VGM5RFpIY2JiYmIrRkVKbWVkRUZaY21OQ1hCbnF2?=
 =?utf-8?B?Y2FweTdWMzNSL0R0azh0YTVaM041S210aXlReXp2eTJ4eGt4emhiVzJLQUow?=
 =?utf-8?B?dk1qSE1WaVZxaXdtb0hzTlJ2NnYrQS91bkNqZEN5M0M4a01sa1BkdVdZQ1ZQ?=
 =?utf-8?B?dSs5K0lNTTIzQXN2a1Q2Z1J1QWJxTDQrOS9WS1FqeU5kZnRFSGZydVVZdEtE?=
 =?utf-8?B?Z0wzRFNtODUxUjdCRXhqNXliU01qQllNSUZ6VWVpNHl3dEh4S0VjM1FuQnVJ?=
 =?utf-8?B?bDBpY2Q2dzNDZVR6SklJaU1oVjE2NkFVeXI0SFJ6aS9XUHZmWVlEeXR0VGhO?=
 =?utf-8?B?djdVclJ5eDRRM0E5NjY4VU8ra3lmK2l1b3NpVUg1Vkhkb0JuVUdiQjFjL2Nx?=
 =?utf-8?B?OVkrcTRzcUlPNTVseFd2UzhyNlNTNHREUyt0QTRpbzNOOUF2SFFhKzVXOW9m?=
 =?utf-8?B?WlJwNEc1aURnL3dZV0ZyOCtRa3drR3lTUzRab3ZsVlJwdWplcEVLODNGYkx4?=
 =?utf-8?B?aHRkbmNOL0JyVmQ4RHRndjA4N2ZPK3Z4cXM5WjhESVBpMG9xQktmaDQ3OWxm?=
 =?utf-8?B?TU1iclNXcmh3Rk5qNERPcDAyaVRaYkJMc3M3UmNjelF5aGM5a3NRdFlQTDNE?=
 =?utf-8?B?dkRDM0cyZGFJaUtydElPSS9TNVZWcTBpVkVqVHVCT3RVT2NWSUVlclZsUVoy?=
 =?utf-8?B?ck1hakhybDduZHJLOSt6eUc4SC9BS2NrNEZtZmxDdjdnWDBKTFJ5R2EyZWx1?=
 =?utf-8?B?ZkU1WlY2K1pKZXR5b0FhMmMrSStUT0dpM29pYnRNWmtySzZWZFVYZWVONm1q?=
 =?utf-8?Q?mxIPyUlKIGg6hwo/sX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5503d61-20c8-4a48-4c6a-08debafb25f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:48:17.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhZ3o6irGAnDgF+V5U7VopQTzq1RBVXmGC4yw4uh6ZzlaSdZvvWPHJpB3Bq1tmy0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-16293-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7FDC5D1F00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 18:17, Tejun Heo wrote:
> Hello,
> 
> On Fri, May 22, 2026 at 05:26:16PM +0200, Michal Koutný wrote:
>> Hello Eric.
>>
>> On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
>>> Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
>>> configure whether allocations in a dmem region should also be charged to
>>> the memory controller.
>>
>> This kinda makes sense as it is not unlike io.cost.* device
>> configurators.
>>
>> Just for my better understanding -- will there be a space for userspace
>> to switch this? (No charged dmem allocations happen before responsible
>> userspace runs, so that the attribute remains unlocked.)
>>
>> (I'm rather indifferent about the actual double charging/non-charging
>> matter.)
> 
> I wonder whether this would make more sense as a mount flag? What's the use
> case for e.g. having different config for different devices? Wouldn't that
> be really confusing?

From the cloud gaming use case I can't fully rule out that we need mixed settings for different cgroups.

Making an educated guess I think the best approach would be to have a default value per dmem given by the driver who creates that dmem.

Looking at AMD GPUs we have the APUs where VRAM is basically stolen system memory and dGPUs where VRAM is dedicated device memory. So what the driver detects as HW config should affect the default behavior.

Regards,
Christian.

> 
> Thanks.
> 


