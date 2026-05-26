Return-Path: <cgroups+bounces-16324-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GuZMGn6FWq/gQcAu9opvQ
	(envelope-from <cgroups+bounces-16324-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 21:54:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B365DC280
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 21:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF2893038A4B
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3327F3B895F;
	Tue, 26 May 2026 19:54:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022116.outbound.protection.outlook.com [52.101.96.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B023A8739;
	Tue, 26 May 2026 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825249; cv=fail; b=OtTaoRAdqhVw1nmN0uWcPhe8INeN3KUXATbERah5mVDecsMFv/fTdELBY2zn1Gq3TMy6hGHw2v5UUUW9GSkskLhqCvB93JgWgdqE5rARY2vi4yevQj1A2XhwW22hSkvVxNkaY+sQFHtRn3vyggjPtApX2xAB8yZ8zvpFRUQBT3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825249; c=relaxed/simple;
	bh=F04yg50kkwW5Z04Jn7RhChGbff16mHs7D/aLlMY6xnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rlNKS3G8UeFIIhnXY0HG45uEcz4HxXXxl4JWJGNVf10QfIcn+YavafbODJMYeplhHZiwzafiTl2TynWwXlzAqs5eSV3D13lsd06y8J+uikjDQAanoVjzOK0e3A8bYpqJ0H6bFC619eeQUSO5DL0t5wqtBogRvV45T41NYJr2OoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKgRl4fxvXF6RTTOV/esHj1vhUk4VpDX15UrQ63FVe8ze6LB0OcdNaRDDtI02zT+6xYkN17+5amuDHRMpzYMgl8j8gsCizU+x64jEBge91Jfx97T9FB/2OLn+Exeq1sSIq00JBXn1BAAbrzLjXjwmabOKJE/SjgKcqf2DW1vFydgECH1Ay4Q2hDc5JmKd9oeg1mvkuldVSLGzbcx3JuABKeOr9zOCfxzTlMscXfFKBT36aAxiHPpZ5aZ5tBXIes4AlesGvt1djJAZ5FjxFneRAzEZVoiwZc2gObXNjTM49hr4hD5D16HigsfpPhIXkn+vKUYTgKb3atiPEEEanc8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=h4yEGomEertXpe0CX0e4veY5Abj3uCdyn95vK31y4cg=;
 b=xaWscIOkvDviCNpYWFrwRhhNi4COsPOB6DiqjWYjYJJdPzS9FTh2zD6Th0OOfKh9oyrNYGJDM6LUUcNnu+cfjD/PppakDOu2avfgV9ferSIjwQ6+CQ6JDioNzZAtlUEHqmr6Vizd0nsKYs580rCYk5vqjS7QnHKu+tgWvay617RnmOiU2+FK24HfBuwcWvwdOrJFky5I/9leR+wuG+dzHXksUAnNcYvCX8pzHFvUB1AWqjKK+BoWOV4tpKsxkKa7mjKt3VwpQKJpkBT9wODY8QdNen4QRMm5fwioJQZnA64Hrt2eN3re3/tQ+imNo/l2TPCVUUEHT7N1fZMRYVC6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8017.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 19:54:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 19:54:04 +0000
Date: Tue, 26 May 2026 15:53:59 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
Message-ID: <5adzrz2gwuyihwcxksok2ix3k64qxhczpbxefl35lohkdt7whs@jclqteh3yr2b>
References: <20260526142838.774711-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526142838.774711-1-atomlin@atomlin.com>
X-ClientProxiedBy: MN2PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:208:23c::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d94856-5663-45c6-cc58-08debb6089be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|921020|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	JELgg8RCiylCfEeTlfop5PEOC+g6gY5tC/iE4AiB8iPoRaLLh611qr8ihzBupPqYjHBRktPxXGSibKETJStGwpk/u3glaFR74TLT2qHFgARHcFYXjirQNHmQ09sJmvUIWCo2LRgxjSc5gzjCjfkNTjFw9/Blf/blEWE+7qxjANMxJ7QNQOLsF2qKWhRB1+iYLEcEc6uDEgMk1vMVEAjbJ2GbFyP/civ5bP6fuyQGLNSWpIQ9mAX73I2FeAv+xhlIN0bI3Nuc7Qgx2LbyHPFLQcYrAd//RtUYg7rg04MM+JwOWOaE4wTZ53ZYB45kGp4UL01gT19+Tc7BGYdYSe1BgOdE9NFv8hOLLzBPfMUyUxMDEo1gx5uwpDW7TXh/QfIlZerhOvyj9RYonU52tTSYZWMH0mtRNDa4yNQxuO1ZwlMRhkrLoZt15IdHPsU18ymAkczQDLVBTLCF20iSE0e4RHtms60DmkYsS0TwO8bgh/6ExescqLEariN40Eci8c6HqceJB1hFNzgF17QgpKFwV/p87i4ceq0TP03nSYzs8L/VpiFNzP3XAf7XFSnwHkUoeCWdZc0IDHC3xIQsRKuHLngkeOyikLJxbWdMhiLn3FBLG51/lTkH5GxIH+7axIt5Cz2+Fz19k7AQKmoBUIxoyT3aCnNXlJ+Dg8BOjJlbkyoPaC9w6ZUyoZqaHc6lSd0GcbpOuTw5hFgFp3TC+kHuqBuT8IlJqtfTUYIlGcjCdao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnVZT1dyRzZucmNiRUkyeStXY2xBc2lTNDdyZUhvVGx3RnN3TXBhVXBIVEw2?=
 =?utf-8?B?QkF0YVd4NS85dWVYY3loUEJkNlUyTEp4U3RuL1I4bGtHcUtWSTB0am04SENk?=
 =?utf-8?B?QkppSHdpNWM1bm5jRmpYanFYMmcxNUZocHN1cTJrMjlOQ2hJbHpWRytBN3Zw?=
 =?utf-8?B?SEFPTVZDMExRajlEdFR5Yy9tUWo1RjhVTmVxampHYWZsVkExZGlHVFNTWWR1?=
 =?utf-8?B?NThrWGFMaHVKbkJtTkVIK0lHcENNU1pmZktsWlhWUnA3TU81eHFNSUowSlBQ?=
 =?utf-8?B?SThYcHJmUzdLUjdGZlI3dCtGSzlKVU1vajVVRzU0clBUTFFuY0VOL2hGNHl6?=
 =?utf-8?B?aEtzbEZ4THkxTExDL3YvTlU0RzdNU01CNUpkR1NJa2E4TzdwYXNGTENtS2No?=
 =?utf-8?B?NFRmYVVuSi9McStVSjJvOVI3MDVhOU8vWDVxWWhuOFU5ZXhBcDdhYkxxaFk0?=
 =?utf-8?B?RnBsZ2FlYXFHeWFmb3RRaHN4ellmVXNzMk8vZVdJUUl0N216UzRVWDNLR0FG?=
 =?utf-8?B?MCtUcTMxSFB5MFBEZzhGUGQ5OTNjRWRiTTkzeXN2VFRXSXQ3bERyTHdGT1Nm?=
 =?utf-8?B?d0ZqRDY1aHFwM0J5ZXVQYmI1bXpUbDI3WmQ5Mm5pYllKZDBXbC96QUFGMXpi?=
 =?utf-8?B?MThhV2RubklGRUxhN0dNTEkxYjBVREF4dC9VdGI1TUJNVTkzenY3RFFnbkdi?=
 =?utf-8?B?aDhyV09EWUlXckpyR1VrMmlxRitmZWFseHVIdVFaSkk5eVpxVUtUb1lkUVZr?=
 =?utf-8?B?QVRkeHRvOUZBOWRKY21iQnhROW5sdm5kYTNwU0VPUG44NTlzdThxNkVSTGFX?=
 =?utf-8?B?R01HT1dwZE9uQ05hVU45aFl0SEdpVmN1Vmp4RGE2RGN2blBLNWNoUDk5dVox?=
 =?utf-8?B?QnFtTzV4QW8zOGh6dEl4c2JibFZLYlhxdktWL0luUklKbjU4RHpDNUJMa3FI?=
 =?utf-8?B?SkpqbDZldDRsMWltRmVxSFFrejRNWGJPeWRtdEd1c2N5M2R3dTBvVGxBbFNt?=
 =?utf-8?B?L2toaXF0d1pHb0FyZlBOaHZaK2FkV1BpMlloVkRHRXpUbnp5d1JDZWc3d3dj?=
 =?utf-8?B?d2NxZWFlc0hSdDJ6WTVpMnZaVUFuc0JIUHFtS2FmL1pQZVIvQW9ncC80dlNE?=
 =?utf-8?B?M3hLdlZSQmFaZHA0dWxDcm5PaTd1L3YyTjNyN0JqV1hCZUpuQnZUSkw4Qzcz?=
 =?utf-8?B?R3MvQ3plTnQ1a3VrZTlkbDFicUxVSGNFYTQvSlpXa3FpU1hsYitNcHVDUmZG?=
 =?utf-8?B?SGY2QjZhdUNJd2JreUpab25WSFNQWHVic0hQT1pCcGFpV2p3WEc5d1Bzb21D?=
 =?utf-8?B?cDIwQ1ExL0tRZVpTaVlBNWQweEN1TXRJZHBXaDk3YUFmZ3hvWVJsSjBKYlhn?=
 =?utf-8?B?d3IvdjBSRWNzSEY1U2ZLcE1kTUFHaVhyYlFQcFVZbWh2WW5OUE9nZ1ZLMURN?=
 =?utf-8?B?ZkFBNy9rYnlaa0gvTWpHUUV0cXd5RXFjOHZlZTVIMldLOWNuRHRuRTdOdWlJ?=
 =?utf-8?B?VXFzdWtGZkVPbWh0WWNQcmJqcm9IL21sUnNpYWwzL1BrcGJrOXFxU1pKV0cw?=
 =?utf-8?B?TEVDV3VYc0l6NWxKaTRZcTNSSzFTSzdrU1kyOE5OdGxDSTJ6WjRkMVZ5N2ll?=
 =?utf-8?B?ZUV6OVhVZXQxM1Z1UWE0RGFMZEpVTDVBZWxVRGtMSVhTL1N5aVFpSzFJQzRS?=
 =?utf-8?B?WTQyM0V3ZlBjM0czcW9JaFN5NFBKVE5xd2V4VnNNZ1BvVUErNG9xcjFQS3FJ?=
 =?utf-8?B?UnhaT3FtLzIvNlI2OE1EYTZBTkVJenBkd05oNjFUalM4U1lQMnlldWxnVzZU?=
 =?utf-8?B?T3UvbmJ3NnpvQ2tCTFNLOC9lRm51VW0zanpWWThZV25XZnRKSG8vRFZwWWlB?=
 =?utf-8?B?WWxzM0srQUtDTFNrSTVYU2N3bGNnOE51V28zcUloU0Rjd1g1WWUwbmMvYUM3?=
 =?utf-8?B?c3dBaGJGSzNmckVIVGpjcEVtZEM3Q0lYS0N3U2c2Mng5Q0xOcDV1RkZSaEli?=
 =?utf-8?B?N1hXYTlMVE0vTVhzT2N4VUFJME41T2U4a1RscWFxYVF6L2FWVmQ1SlRtZDN6?=
 =?utf-8?B?K3RnWnNzUlBIVXFCcmtDL3c0RlVtc0hPLzl4TFFuOFViYXN4UTgzTVM3Ujhk?=
 =?utf-8?B?bjJyRGhHMHl6WnFFMklEWTFMOGU3amNaTktLLzc1Q0NyVHlDMUV6WGFmNnAv?=
 =?utf-8?B?TTByR21XK1RHcUVLMHJuc2F2YlR0MVdQUG42Qmh2Y2hZUkRZQldOZDJydVM0?=
 =?utf-8?B?Y2Ztd0dZckxjRkRvWWVPZC90OGdTeWdSTHVUZEg3aEd4ZHg1NjA5K0pyWkJy?=
 =?utf-8?B?WmJHUVNwMk50eXljQW1UanFRbU9WYzcyaXRuR2dLMkl4QWk1MDNPUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d94856-5663-45c6-cc58-08debb6089be
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 19:54:03.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oGWu3ngG5NzxDfIhcPKf6kRnyrffM0ngMiuCKrJqZYnkSiOckQFIePA4WFskt3nqqNTLqPIdqV9Gd2lqAPhSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8017
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16324-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	DMARC_NA(0.00)[atomlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.812];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 78B365DC280
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 10:28:38AM -0400, Aaron Tomlin wrote:
> At present, the task_setscheduler LSM hook provides security modules
> with the opportunity to mediate changes to a task's scheduling policy.
> However, when invoked via sched_setaffinity(), the hook lacks
> visibility into the actual CPU affinity mask being requested.
> Consequently, BPF-based security modules are entirely blind to the
> target CPUs and cannot make granular access control decisions based on
> spatial isolation.
> 
> In modern multi-tenant and real-time environments, CPU isolation is a
> critical boundary. The inability to audit or restrict specific CPU
> pinning requests limits the effectiveness of eBPF-driven security
> policies, particularly when attempting to shield isolated or
> cryptographic cores from unprivileged or compromised tasks.
> 
> This patch expands the security_task_setscheduler() hook signature to
> include a pointer to the requested cpumask. Because this is a shared
> hook used for multiple scheduling attribute changes, call sites that do
> not modify CPU affinity are updated to safely pass NULL.
> To protect against unverified dereferences, the parameter is annotated
> with __nullable in the LSM hook definition, ensuring the BPF verifier
> mandates explicit NULL checks for attached eBPF programs.
> 
> This change updates all in-tree security modules (SELinux and Smack) to
> accommodate the new parameter mechanically, whilst providing BPF LSMs
> with the necessary context to enforce strict affinity policies.


Adding BPF Core to review the use of annotation "__nullable" in the LSM
hook definition.



Kind regards,
-- 
Aaron Tomlin

