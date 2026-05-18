Return-Path: <cgroups+bounces-16027-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GawFJ++Cmrb7AQAu9opvQ
	(envelope-from <cgroups+bounces-16027-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 09:24:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E24256771A
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 09:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 227CC3048917
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A4F3D091B;
	Mon, 18 May 2026 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ztHTSDCC"
X-Original-To: cgroups@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE626313E3F;
	Mon, 18 May 2026 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088816; cv=fail; b=vDdFpbVcDRNThbsFng/2lKWymzOBfMyi+CLJp6Tl5uS1tcUY7IyuMg37dPo9FIrd+PcdeosDYQ5U3dM4DIGrqxU/k5t5X06y4WsTf2oSCHG6MyY1V3Q2b+N6rNgqlnIM4ahi9tHn+De64v543tMLAF6iJ1V0nMkVTLhUE8+UHBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088816; c=relaxed/simple;
	bh=YQjvA+EbAkReaLSXaca9Gb2mDI2gUKTqBIEs9UHjP6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGwt/pdvQZuGBj8QS+VUfeX91EwCcaAUZCt5wTA4yIcYJjv7JZSykHr9oMb2+LngsxkMBzfzUjsDJz5YZAnnVKoNuD7Gl7vNurc+HTD51Qv+1OzX2uzSStQnu7eLo6v2owLKzmaNOXKdTbttrA5j1F20EL7TAyJWfyXUSwFupwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ztHTSDCC; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ybdrf3Eso2IvQLhmULTpAgQVfEhtQbYtaSKE6g52msyeOqM4vJBKjLtvK6TjVOtafSfJ8e83VBMUjM8EjNAXYBW0ZEBlCGfVcW3NPtBJnDeBSdnCfQIXI5sIFPHRSLX9QLLAZoM4OBynMwB6uoS6FS5Jl6rElyKn7DwhvPKj0q2HRRqeQsD15Ux9ZmebybUabM3aju48W+kdSaQ1pN/CfNGXmA3eYK8gjCgpeVzs61sAH4eEgh00Mld1SlUBgK4bMVqX+7Fct4OwLKcZbXqXZAX+SrhAyoY8xFSKURxaquz5lTg+g1rb5Fns7J3SIuSTWGRhJzeyqshFW+dLcLPv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdHlAjz1dUcc5xSLHj79t/Nc0G6EXASwZQIE4e1iYzc=;
 b=R0xiQC3Yn1+BfEmXfY1tu7qpKO6QWnll8GPwUR/6H5LLWnsrBzFJIRLZqhC5brWWqxqVT2kMOaUEsuXh4BTB7Vr+6NVrWQsITaNSRRjlIy06u83f9ydDBDS1zWS9wEtm+m63q5tSgQyA/a06Q2sr+RTq5nmFQC6+X7OLWX5xJgpe89GazZGeA9Pc3nMMS2Dzv1Kos2l2nGiKuyGRqAYhWE7pVO7Ri12r2bgwMvNCVtxquoIqy+gEQPgbQEUX77zBEO+rZ85a2in8IO2zaAFHoH6hdyKUIstr9bJd6VKZXVpgc1+LSx1y7GXx9L/2Pg9OyzJsRhRgfCHk4VtF50YOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdHlAjz1dUcc5xSLHj79t/Nc0G6EXASwZQIE4e1iYzc=;
 b=ztHTSDCCq9V6kh/VMepxTSVNpxZPPy3X6fCgKUlISlvoVrN195hciNSnkuqEmgZ9QaeO5AHcssNgWFnfZ7M/2zHAQDJuEvGh9DCquKH96u/6G13JMHf5t8YUvzO09dggFk9/UzxkFGx2VaIboD1zhX4vIwbaVJXQgMBNun1+Kjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:20:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:20:08 +0000
Message-ID: <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
Date: Mon, 18 May 2026 09:19:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit
 memcg
To: "T.J. Mercier" <tjmercier@google.com>,
 Christian Brauner <brauner@kernel.org>
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 285bfd6e-1bfd-4a14-2988-08deb4ade453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|11063799003|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yjsUDcDuMt9PCbWqzsNdE8071acwTo9/EMqY3ZQ1LecnKmtdovH8COz9WS/q4DAhccL3CtG3YJ2bSXv3kCyrXo5T69ArVBfZB+BNWJJNbWZJqqtfpxR6yZJAIXwBBpa7J/hFccCebz/Sed8aCRHRU27Nv47Jr4GfKV8L3IOaA1JQLe+0nTefY6D6n1l+QKI42HnVSUOstpEOkdwsDQohXPFrmqQebUVdmbNmlf541KLAZC9GG0bqvro9loVA0HjEJ4lEjlSeXhUIOAKrjLwFyjMFad6vIXya0cuqiKF5/iNjLb0Mrr7B0sla9WkWn2li5QlTIVWchNT5VKE4IBtXxWJqIq+j8WKYPfP0zIuG1JvyaQIbhG5FauTG90ZaLl7fDtdAvSLvcVLsrQIrmSUFe4qDlk9CjKKNwi4D8h8axZ7DQBT8zEetO1dEB0dUY/6Xmy26eQVVUzQPfrPHv5LrzS3852xnL8w+jBwUsY1rQkXWjLkWK2gJDdtm3R5uVv/viUqw1jKyVMlTF8T+Az2btuzfg4VHsjBHNKYqvjatDszL+FWAN8ABhz7Nbr4jdpGWwiWfyqarE4ZZySm30/w4X2Eg2bu3hXBWBL+BnhPSiO0llm10hKZlh59mxwKQM3Nuc4gmDvdEfqwzZVnrvaGdF4Rs7zVmBcl4ugFCfdwNafijZ6Sg/1TN7ozAoBORPzaL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(11063799003)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVxMmMzVi9TMXI2dVhUVEpEMjlDVU5UK2M1M200c1VGMDhZb2paYlU0MTV2?=
 =?utf-8?B?T3NsK2F0UnFxZW4vR0IzSUVFWG8rR0tXTDN2eFY1QWtFNEhnR3JNK05jajE2?=
 =?utf-8?B?YmRoMVNhRGNScDlINGI3emJvUTZBK1Fxckh1bVBSdlFObGRjM2dBemV6cldY?=
 =?utf-8?B?a0JhYlNSZEw0MkpiSElwS1FwUW1PZlh6RzlCOHNsYW8vb2QvOFVpeUxldmZh?=
 =?utf-8?B?VzhTTVFKckdDUDNtaEE1c2F3U0dsbVR4blVpMi9uZ2N5bzhSU2gvOFNmV05Q?=
 =?utf-8?B?WGxhTGNWTVd6bHhOcElrWW1PYlMwYXljaUZvaTZMdVFPaEtEeU9vb1Q4NmZC?=
 =?utf-8?B?OHJYNUhHZTUxVWcvT0Ezd0hDOFBJeFphT0VzbzQwOVU0cEovaTkyY1htSXlM?=
 =?utf-8?B?R2UrRUpKV1ovK2p5dytlOWdYNnpGOUk5YjRhRU9jOVg5ZnNJc1ZiOU5qb2lH?=
 =?utf-8?B?VUF5b3lvTGxKL0xWcEFFL1B0ZkpOOTc0cVhqSlNuM2VSZXBHUnBVMm1MY3Np?=
 =?utf-8?B?TklVQitBdFpkWXFSdGtteVhEQXFud2ZkSFY0RjY1WDVHanYzMzNFcW5TQmNj?=
 =?utf-8?B?WVhWeTd3Y2dtekh5L3lTL2VEZ2FOYzc0bGliMzh2ZVMrdW9YQnN2b3AwN0d6?=
 =?utf-8?B?SHRnb3lpSCs0cEd5MUJFcUJFazZ0TWNKZGo1N1pFOVN5bTZaaWRZVFM3YnUy?=
 =?utf-8?B?c1ZwQk1lNmtweEF4V3ZNSkpTRStnWitzemJrVktxa0RvN2NUZ1RLUFN6SGNq?=
 =?utf-8?B?MEN0dDdYYVh1cDFoZkdGdnNiTVdHU1RhTkZYWjFyVEI4ZDU0VzVnSTR4ZFRn?=
 =?utf-8?B?MURybllYSVMyVHFhY0JyT1ZBSnU3cVQxU0VJLzhrTGxCTmpyQmtEVGNYTzlO?=
 =?utf-8?B?L3Q2Wks5ZnlueER4a0NWNFpGTnJFclNjVjdrb09mSlBDTEd0OWlpdnFVRmw1?=
 =?utf-8?B?YUhmWUxUT1UyV2xaZ093ZTVHNklwM1BCSG1GKzF3YWRXait5d1FUaHQ1bGdw?=
 =?utf-8?B?d1F3cW9kbkZBL2xKNUpHN1R5ck01Q2tqUVkzSmIwMGUyQ3gzZzhNN1cyUnhs?=
 =?utf-8?B?UlB4OHdNRFBqN282OHRCUEd6c1ZzZVlpMGpsMitKanJLeFdBeWVwZGZCMG5D?=
 =?utf-8?B?SU53TFFlSytLL3JzRi9DRkhlYjR0VlVudlk5TmNEOHo3TjNJcWtDZ0VrUjlu?=
 =?utf-8?B?aVhsci9UNjZSeFROM1hWalc0QUowRnhIQnZvKzhLS29Pc1BIZnlSdENVYmF1?=
 =?utf-8?B?Vk1SL0daUTVyUkEvNDdpdXVaS0lIOXh5dnh1Q1pHa0pudkZGdWJmNlo4b1JE?=
 =?utf-8?B?Y3NxYjd5L2g4TDNMa3UyUDJTVkU2S3BSRktuWExHM0lraVByNE92eW9PVWNw?=
 =?utf-8?B?dmpYOWZlUnB5SUh2UmRmWHVicFhyZ3dBaUJ5dWY1dmNUMllxYnBrOHU4NmRi?=
 =?utf-8?B?R2dpR05Vclh4dHVoZ2p6UWxqcW41Y1RFbWVkQmo2d3Fyd0VRMzY1N0ZQSVdD?=
 =?utf-8?B?QmN4L0ZxeUFIYmhINUo2Qk1CWFlwUG8xc0VFd0hNMkt0d0owd0N2STA3eitG?=
 =?utf-8?B?eWZ1KzAvcEFZdUdhb2N2WGJwa2tnaFUra2NmRHFBcmZuMUpSZ1gyVHNnckQ0?=
 =?utf-8?B?aUJsNU1FQmp1dW9GU3ZCcEdWQUVVMFQvK056Snc5MTJtR090Y3JPalZjOXRt?=
 =?utf-8?B?OFlUbUJoWElWdEhYd1ZVWXBVMXpVUmZFZXdaU3hENWUrc3Y5U3pYdWN4aXhU?=
 =?utf-8?B?dFh4bDJJWUV0RlRLMzNXTWZrWkdjSGxxa0pWKzJXemtCTS9wcGNkZ1dBOXdz?=
 =?utf-8?B?eExSbVpWKzVydktvcUFvVUY5M2FJNTZCMlUzbEcwVTV5MjBFeWFFRHZBZk9L?=
 =?utf-8?B?UmhjeHZNblBBUGxNNjdockF2Z1QyZ0ZRWUVzZVZ2QzA1eXFuYlVYMHFaRzA1?=
 =?utf-8?B?b2VBUGM2VU9MbzRtVVduVTFSL1pPeWdoaW4yMm5aL3A4OElML0FnWXA1WFhP?=
 =?utf-8?B?Rk9BM29xM05RMlNTcDdjQjdWQk9XOVRTWVowWWVjMXRGTi95SUtldGN6REUw?=
 =?utf-8?B?ZHR2bFBFOXZKUmduYjllNFNQU1RTL096U1ZtTThaQXZwRTRmM1k5eUJXVTNy?=
 =?utf-8?B?eDZBK1M0Q0Y0Ujc0RmpEQUREVkFmeFNTaTBla0hVYjQzRFB1YjNhRmQ0LzB1?=
 =?utf-8?B?Z3JLb0hMWGMxbkV6WE02Tnc1VEdtdVh4SjdTcHE1TE1ocnlkYzdiZWpUZVIr?=
 =?utf-8?B?bUowUHdHWGFpcHpNVEtpNnN5U2phOVhMY2NKVW5PcmlxN2tBdDI3TEJaT0xJ?=
 =?utf-8?Q?fZa70r6TiPnkTuOpNF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285bfd6e-1bfd-4a14-2988-08deb4ade453
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:20:08.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cbd7eStJFMn99DUvoA4OzcXT3cJEPYutLptmpaPgR8ir7Jg0DmEgPB7dqfINK2Wd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
X-Rspamd-Queue-Id: 9E24256771A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16027-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 19:06, T.J. Mercier wrote:
> On Fri, May 15, 2026 at 6:53 AM Christian Brauner <brauner@kernel.org> wrote:
>>
>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
>>> On embedded platforms a central process often allocates dma-buf
>>> memory on behalf of client applications. Without a way to
>>> attribute the charge to the requesting client's cgroup, the
>>> cost lands on the allocator, making per-cgroup memory limits
>>> ineffective for the actual consumers.
>>>
>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
>>
>> Please be aware that pidfds come in two flavors:
>>
>> thread-group pidfds and thread-specific pidfds. Make sure that your API
>> doesn't implicitly depend on this distinction not existing.
> 
> Hi Christian,
> 
> Memcg is not a controller that supports "thread mode" so all threads
> in a group should belong to the same memcg.

BTW: Exactly that is the requirement automotive has with their native context use case.

The use case is that you have a deamon which has multiple threads were each one is acting on behalve of some other process.

At the moment we basically say they are simply not using cgroups for that use case, but it would be really nice if we could handle that as well.

Summarizing the requirement of that use case: You need a different cgroup for each thread of a process.

Regards,
Christian.

> 
> Checking the flags from pidfd_get_pid would be the best way for an
> explicit check of the pidfd type?
> 
>>> a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
>>> memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
>>> inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
>>> the mem_accounting module parameter enabled, the buffer is charged
>>> to the allocator's own cgroup.
>>>
>>> Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
>>> system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
>>> page allocations. Keeping __GFP_ACCOUNT would charge the same pages
>>> twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
>>> all accounting through a single MEMCG_DMABUF path.
>>>
>>> Usage examples:
>>>
>>>   1. Central allocator charging to a client at allocation time.
>>>      The allocator knows the client's PID (e.g., from binder's
>>>      sender_pid) and uses pidfd to attribute the charge:
>>>
>>>        pid_t client_pid = txn->sender_pid;
>>>        int pidfd = pidfd_open(client_pid, 0);
>>>
>>>        struct dma_heap_allocation_data alloc = {
>>>            .len             = buffer_size,
>>>            .fd_flags        = O_RDWR | O_CLOEXEC,
>>>            .charge_pid_fd   = pidfd,
>>>        };
>>>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
>>>        close(pidfd);
>>>        /* alloc.fd is now charged to client's cgroup */
>>>
>>>   2. Default allocation (no pidfd, mem_accounting=1).
>>>      When charge_pid_fd is not set and the mem_accounting module
>>>      parameter is enabled, the buffer is charged to the allocator's
>>>      own cgroup:
>>>
>>>        struct dma_heap_allocation_data alloc = {
>>>            .len      = buffer_size,
>>>            .fd_flags = O_RDWR | O_CLOEXEC,
>>>        };
>>>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
>>>        /* charged to current process's cgroup */
>>>
>>> Current limitations:
>>>
>>>  - Single-owner model: a dma-buf carries one memcg charge regardless of
>>>    how many processes share it. Means only the first owner (and exporter)
>>>    of the shared buffer bears the charge.
>>>  - Only memcg accounting supported. While this makes sense for system
>>>    heap buffers, other heaps (e.g., CMA heaps) will require selectively
>>>    charging also for the dmem controller.
>>>
>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>>> ---
>>>  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
>>>  drivers/dma-buf/dma-buf.c               | 16 ++++---------
>>>  drivers/dma-buf/dma-heap.c              | 42 ++++++++++++++++++++++++++++++---
>>>  drivers/dma-buf/heaps/system_heap.c     |  2 --
>>>  include/uapi/linux/dma-heap.h           |  6 +++++
>>>  5 files changed, 53 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>> index 8bdbc2e866430..824d269531eb1 100644
>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>> @@ -1636,8 +1636,9 @@ The following nested keys are defined.
>>>               structures.
>>>
>>>         dmabuf (npn)
>>> -             Amount of memory used for exported DMA buffers allocated by the cgroup.
>>> -             Stays with the allocating cgroup regardless of how the buffer is shared.
>>> +             Amount of memory used for exported DMA buffers allocated by or on
>>> +             behalf of the cgroup. Stays with the allocating cgroup regardless
>>> +             of how the buffer is shared.
>>>
>>>         workingset_refault_anon
>>>               Number of refaults of previously evicted anonymous pages.
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index ce02377f48908..23fb758b78297 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentry)
>>>        */
>>>       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
>>>
>>> -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
>>> -     mem_cgroup_put(dmabuf->memcg);
>>> +     if (dmabuf->memcg) {
>>> +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
>>> +                                       PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
>>> +             mem_cgroup_put(dmabuf->memcg);
>>> +     }
>>>
>>>       dmabuf->ops->release(dmabuf);
>>>
>>> @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>>>               dmabuf->resv = resv;
>>>       }
>>>
>>> -     dmabuf->memcg = get_mem_cgroup_from_mm(current->mm);
>>> -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE,
>>> -                                   GFP_KERNEL)) {
>>> -             ret = -ENOMEM;
>>> -             goto err_memcg;
>>> -     }
>>> -
>>>       file->private_data = dmabuf;
>>>       file->f_path.dentry->d_fsdata = dmabuf;
>>>       dmabuf->file = file;
>>> @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>>>
>>>       return dmabuf;
>>>
>>> -err_memcg:
>>> -     mem_cgroup_put(dmabuf->memcg);
>>>  err_file:
>>>       fput(file);
>>>  err_module:
>>> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
>>> index ac5f8685a6494..ff6e259afcdc0 100644
>>> --- a/drivers/dma-buf/dma-heap.c
>>> +++ b/drivers/dma-buf/dma-heap.c
>>> @@ -7,13 +7,17 @@
>>>   */
>>>
>>>  #include <linux/cdev.h>
>>> +#include <linux/cgroup.h>
>>>  #include <linux/device.h>
>>>  #include <linux/dma-buf.h>
>>>  #include <linux/dma-heap.h>
>>> +#include <linux/memcontrol.h>
>>> +#include <linux/sched/mm.h>
>>>  #include <linux/err.h>
>>>  #include <linux/export.h>
>>>  #include <linux/list.h>
>>>  #include <linux/nospec.h>
>>> +#include <linux/pidfd.h>
>>>  #include <linux/syscalls.h>
>>>  #include <linux/uaccess.h>
>>>  #include <linux/xarray.h>
>>> @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
>>>                "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
>>>
>>>  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
>>> -                              u32 fd_flags,
>>> -                              u64 heap_flags)
>>> +                              u32 fd_flags, u64 heap_flags,
>>> +                              struct mem_cgroup *charge_to)
>>>  {
>>>       struct dma_buf *dmabuf;
>>> +     unsigned int nr_pages;
>>> +     struct mem_cgroup *memcg = charge_to;
>>>       int fd;
>>>
>>>       /*
>>> @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
>>>       if (IS_ERR(dmabuf))
>>>               return PTR_ERR(dmabuf);
>>>
>>> +     nr_pages = len / PAGE_SIZE;
>>> +
>>> +     if (memcg)
>>> +             css_get(&memcg->css);
>>> +     else if (mem_accounting)
>>> +             memcg = get_mem_cgroup_from_mm(current->mm);
>>> +
>>> +     if (memcg) {
>>> +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERNEL)) {
>>> +                     mem_cgroup_put(memcg);
>>> +                     dma_buf_put(dmabuf);
>>> +                     return -ENOMEM;
>>> +             }
>>> +             dmabuf->memcg = memcg;
>>> +     }
>>> +
>>>       fd = dma_buf_fd(dmabuf, fd_flags);
>>>       if (fd < 0) {
>>>               dma_buf_put(dmabuf);
>>> @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>>>  {
>>>       struct dma_heap_allocation_data *heap_allocation = data;
>>>       struct dma_heap *heap = file->private_data;
>>> +     struct mem_cgroup *memcg = NULL;
>>> +     struct task_struct *task;
>>> +     unsigned int pidfd_flags;
>>>       int fd;
>>>
>>>       if (heap_allocation->fd)
>>> @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>>>       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
>>>               return -EINVAL;
>>>
>>> +     if (heap_allocation->charge_pid_fd) {
>>> +             task = pidfd_get_task(heap_allocation->charge_pid_fd, &pidfd_flags);
>>
>> Will always get a thread-group leader pidfd and will fail if this is a
>> thread-specific pidfd. pidfd_open(1234, PIDFD_THREAD) can be used to
>> open a thread-specific pidfd.
>>
>>> +             if (IS_ERR(task))
>>> +                     return PTR_ERR(task);
>>> +
>>> +             memcg = get_mem_cgroup_from_mm(task->mm);
>>> +             put_task_struct(task);
>>> +     }
>>> +
>>>       fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
>>>                                  heap_allocation->fd_flags,
>>> -                                heap_allocation->heap_flags);
>>> +                                heap_allocation->heap_flags,
>>> +                                memcg);
>>> +     mem_cgroup_put(memcg);
>>>       if (fd < 0)
>>>               return fd;
>>>
>>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
>>> index 03c2b87cb1112..95d7688167b93 100644
>>> --- a/drivers/dma-buf/heaps/system_heap.c
>>> +++ b/drivers/dma-buf/heaps/system_heap.c
>>> @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsigned long size,
>>>               if (max_order < orders[i])
>>>                       continue;
>>>               flags = order_flags[i];
>>> -             if (mem_accounting)
>>> -                     flags |= __GFP_ACCOUNT;
>>>               page = alloc_pages(flags, orders[i]);
>>>               if (!page)
>>>                       continue;
>>> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
>>> index a4cf716a49fa6..e02b0f8cbc6a1 100644
>>> --- a/include/uapi/linux/dma-heap.h
>>> +++ b/include/uapi/linux/dma-heap.h
>>> @@ -29,6 +29,10 @@
>>>   *                   handle to the allocated dma-buf
>>>   * @fd_flags:                file descriptor flags used when allocating
>>>   * @heap_flags:              flags passed to heap
>>> + * @charge_pid_fd:   optional pidfd of the process whose cgroup should be
>>> + *                   charged for this allocation; 0 means charge the calling
>>> + *                   process's cgroup
>>> + * @__padding:               reserved, must be zero
>>>   *
>>>   * Provided by userspace as an argument to the ioctl
>>>   */
>>> @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
>>>       __u32 fd;
>>>       __u32 fd_flags;
>>>       __u64 heap_flags;
>>> +     __u32 charge_pid_fd;
>>> +     __u32 __padding;
>>>  };
>>>
>>>  #define DMA_HEAP_IOC_MAGIC           'H'
>>>
>>> --
>>> 2.53.0
>>>


