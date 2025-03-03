Return-Path: <cgroups+bounces-6758-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1A5A4C333
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 15:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4621713A6
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B71EDA32;
	Mon,  3 Mar 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TIoUm4jY"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C82139CB;
	Mon,  3 Mar 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011478; cv=fail; b=p6SX+LbKXlP+vXU/4V2A+l4OoLsDuhHblAKutmgf/cjr5STCBx7cUtwD487sgYNhQ4/Ozyt6J8ClCCBhnGbFUTntPHl3koajYJrtZp6QVh76agKh78Isr2sj0oNYouL30xn7ZkmrgZ83wDntwYMGibUqG3R0WQGt2LJh3Iminps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011478; c=relaxed/simple;
	bh=MwPWOT96XkJUZ4cSdLJVC8gv+V9yV7ketgPVhsKdNG4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pwwy1FGNL0zv/qW5KAvCxFmzzWHhi9q5A/4GUGzgt2T+n2gNAqs5X0sdDY3LXXt/XFHBCTH7+96+kXGVP3A55laTqZkM8LVcGPorCqH+ZzBLmqXt8J4AZ0Xtg2ry9Wnia1wHIIFcBs3B2wWVzLuQg3PkreLKUbQ5cYtF9fa0nz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TIoUm4jY; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5su3yAtEBbHJS9i3PC244OYdxiZD71/eSuAp/Bc5x/lZrH6qrn/q67f0DmhNmIZ+OuHN+a8JCha+xTfdXWHFjCR5NIHjirOTDwgofIjNtyqKgxQ2n/esQwHGIuIcKvxgVDTMVmgfVN31TF/AlyZyySQVr/5E2wU9S6+h4UVMlopY6CgFGrJm1pTRMopbVxnGvPrI+rM6stVKOYx1sK6uhaOiHEhBIScQX7ky32x8KF8zdKEENIA+hl75k4AP6mn5QqpFj0Uk4fiR1bC6JX8tU4ZqUlTZTMw1Q3dqvmUejkHGHrRUzDR4lppIZUDhLttdzFCYY5aWfAh4cLoy+qdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ivWChZdyyFDEEw2U2FaxRAwN4L5YezizqCH+C+v8RI=;
 b=AOvKlPvEeljOw1vA1PXYENOrU+aGeQwNC48uv4S0td+NL0sh3hBBnq6Ekh3Aftw5IKMqegIu/FRRcnEGnQEsXhPpcVcc8iSEZ+fwZTYQmCBZ3FekzbkBcRjX1jbEZabYcUuq6DyjmI+q++We/3kKMzGzeoNmHmCiLLUDe0kSOv71Yztq/H4v/MR7EMk2KiME1mW9lb149l/B3JGhA3XLHdHAi3CC3uoP7wFco19tHf+q6H+o/303hLgrPbESIcEqhcC+Zxqj4dKy/QD+4vW8KV3iNYvIqzncfKELzEqo0j3eg1F2geOKAzBuiaDMA04qxCOkpKmmTBPBKQjU7493EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ivWChZdyyFDEEw2U2FaxRAwN4L5YezizqCH+C+v8RI=;
 b=TIoUm4jYB2mTurVoBtYQd7QepR5jheRK6eGRT2emqcxolDnFZOa3gNxF9CAEGYFttXD6EL3ghSfkL702AmuyheboD2Nav7CA0SvQkw1lHXXio3YuPr8sk/ZeTqPdw8pP/Nt2X/0IyC68hM4VpKbWFera6F8UdCduMjOo4bP6zD0rOoScWdkNqA7/yEIUHZ/4mNOTRlulzFuYucKQwRVt35t8O3QNub3XHxNyYJQoxFVXOJAMG8IW5DATZVCeyvMAai9USgMSJvoh8zmV59918hhWewtEYKmdBK6FLs+q5nT+MtqFnY5C1ehq6Kz6BkRQjSHLj7/oBn6uKVsDOZHmsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 14:17:52 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 14:17:52 +0000
Message-ID: <bd9eb72e-5c67-44a7-ba79-1557eaa319e6@nvidia.com>
Date: Mon, 3 Mar 2025 14:17:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
 <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
 <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>
 <Z7x8Jnb4eMrnlOa8@jlelli-thinkpadt14gen4.remote.csb>
 <4aa1de5c-4817-4117-b944-4b4c8f09ac40@nvidia.com>
 <Z72R5-I91l5FOJK6@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z72R5-I91l5FOJK6@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bd1ea5-2af5-48ae-879a-08dd5a5e2ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGdhRWpXY2JOUjh1NTVrMUJ6OHpJakVhMkt5bldjRUlQR1JhTnJ1VHRacVhX?=
 =?utf-8?B?c0pSMDVZTHdVWE5vRWJJeEhUNGIrNEZrWldoU3V6cUVVNzc0MmhHTC9hUjB6?=
 =?utf-8?B?R2FQMmtkcnY5cVhyWHBJbmQxbDV1ME02U1p2bXpUUi9pYnVXWC9PcnhISlpu?=
 =?utf-8?B?bVVRRkVyYkg0em9yN0oxY0lmYmtKdlpaMkNyKzB6blFmWmFsYitRYlJEWjB1?=
 =?utf-8?B?aW8wME15Um40NG1uMVliQjVMdEI5WFVacUYyWE5uZUxMSjAxM1VkeEttL1l3?=
 =?utf-8?B?WGpkSDdmcGZaTG1rZWQvaDJ3aGpsN3l2ZlJselQraFhUZ3FlY2YxY0N6V2RI?=
 =?utf-8?B?eXNqQThXR3V2TndjOXd4c0Vqc3hLNVY0ZzMrYVBhRVRGWURwZG5zdjBDcVBr?=
 =?utf-8?B?ZVBWeTQ4dFZCZlQ2LzZMYnhvNmR3bk05dFNFcnk4TzNaRFVUWWVjczd4bWxK?=
 =?utf-8?B?L0w2cUlVRWFYRzRScEtCa1E2aWtBSk42WlNJSkN4WHk1NkFvT0ovS252UGd4?=
 =?utf-8?B?c1pCODgrZkhOQUxXVDZHaGxnSk5sc2c2d3FBY1B5RmdOTjhwSEQzM2J5K05a?=
 =?utf-8?B?RFBxWVlSa1NXV2pHdFcvMnRza21WeXR1c05odGJvMnJMQUtVcERkRzdJanRh?=
 =?utf-8?B?bWJHZ05rT3JSVWNhWG8xR1E0STdQTit0eWkwc0p2NmpwaU1xb21TRy94a1Jr?=
 =?utf-8?B?ZmdIVG9tUXhJbFIrSDZOcktoRjE3a0Yzb3hyOHhHZmZ0eHVkL21ReEZxbVJh?=
 =?utf-8?B?eFdOU2tIQnBIR0RUeTNETDNsN3lqd1hGSEFHYUo4dDdLYVQra244dFFReTZQ?=
 =?utf-8?B?UEhXemtTTnhGMGEydW1UMDNnd2pBMkduZkt0dE9LT2tRR1dJSUVLTEtIb1V4?=
 =?utf-8?B?QWRxdWR3OFZadmltWUhBZU5TUnR0WU53b3VEUytTVm05Tmt1TTB5UVhLMmVa?=
 =?utf-8?B?QzNKWGZHT09NckoyRjNqb1JnMDRvTmw1L3ZzMHFuV0tVV0V1dmhqWXJuV2pE?=
 =?utf-8?B?TURoQ0ZJRk5GbmY3SzU0a2hSZ0c4N3l6TzcrK2hkNVpYRjJINzN6UVZUTEVa?=
 =?utf-8?B?YWFwRlVhVUZLT2dvQkhqVHpqTGx0S2xMd2JvdWNybVlXNmZseTQrTlBPcjJw?=
 =?utf-8?B?Mko3KzZvb3lRZmp2bEs5RGVjenQ4RzdWK3hCWjFMa1JqVGVwTmZUNytaUER3?=
 =?utf-8?B?cDBJQnM0ZDExQzcwSkkxU3QzdnVBS2t3ZWIxWHBlUGxTQjBGTjRtbWFlMWxS?=
 =?utf-8?B?TVUrRU5VMEJUOTlkYXlaK3kybTdiNFI2SkRsdkduRS9wdStGV3JEM1VBOEtW?=
 =?utf-8?B?WDBnQW5xTGxBWVBhOUpQeUlHaUtjaGhWU2pWYzhFU2hkOStkdzRDcTJKSUZC?=
 =?utf-8?B?M21RckJncVdwREdaaitkRVVJdmRubFRCVjRPNEFVREQwOGZkRGZVVzB0QzJY?=
 =?utf-8?B?RWFzdWorMXR6VXNJWG1TTURPa3NKM29zVTFrWlZxSkViZkVJaW9oWXlJdXRw?=
 =?utf-8?B?OFRqNTZIZm0zN0xzdHpndVBUNWtMelQ0S2l4MW9OVEIyckFGcE5TeHJtOGla?=
 =?utf-8?B?eWxXNkwvOTZBajFiTUE2MDNTbEM3d0hVdzMvUER1M0FBamVob2UxYUk1dGlZ?=
 =?utf-8?B?Q1d5cW9va0lmbFkvOVErbUNwL2FkbGFsaks0WUZ5TjM2dnNxZHFWSWFQMjJC?=
 =?utf-8?B?c2ZMSGVVV1prcERYYWdVVTJFekFEMldEZ1ZmZEMya3RqY0srOTA0RWpDUW1S?=
 =?utf-8?B?VGNiM0JHb0NyRjBxZC9oS256ZGNyMTZVUWdWc1ZqclptNGtIRE04ZlVZSThm?=
 =?utf-8?B?cnA0aHBGNm03dDUrdWhaZnErQ0VSTFdwWUU4QmY1UkJuK0k4SGdVUU5NWkRB?=
 =?utf-8?Q?zd4We40hoNceU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFh3UlpHaXhNWmM4V1QzdjJCQlhtaVhJV3V4cm5ENUMwdEx3Z01yTlN4M01T?=
 =?utf-8?B?WDZIYXppQXpYbXhrT05OcTBjQmpMa1NhZGV1a1hlOTJlWGJSWmN1K0VYcDh4?=
 =?utf-8?B?NFE3TlpmUEtqWEFGTDBLS0JYMG1pRjQ3WjdJNmVPbmFpYm1yUFNkRzllVFAy?=
 =?utf-8?B?QXg3NVhqQ2ZYN1Y5eTFKc01oRXkxelgzTENoTUVkTkFFNlk4TUszR0VNN29R?=
 =?utf-8?B?aWVhODFCRTVqdHl0NE5iMC9XME56RjE2aXl4S2dLeVFnMzVRdWJqSkZPdjZ4?=
 =?utf-8?B?bEVScGZzVThIaHJtdHNJRFdvbTVrdWRUN3lWMkdEaVVieTI0dXpZSHFUVmp1?=
 =?utf-8?B?ZUQ5eUdkLzJISFAwcDI4eFRkNnMzQm42bEhHc0lUOHpWUDR3alFnM29EckhS?=
 =?utf-8?B?S2hGMTRITFFKTTdvc2UrTXkyak1TUURVTHVMTTN2bU0wTE1TKzB4TFRWN3dN?=
 =?utf-8?B?OHNzalhnN1MzalpPQzhyL3BUaVhNNFVFQmFudTVUL2Y2NTEvdXhTU1EyZ3BE?=
 =?utf-8?B?M2lxTGJid1ZsTUNHWk1KL1N3dWlOMkswNE1kSXlCYmR5SnlZSko5SXNsUlQw?=
 =?utf-8?B?K3FrbzhZNGZYdElDR3pVMjdkM3JweDY2Z3owU2RURlV1dVE2MmVUd09OdDd3?=
 =?utf-8?B?WjQySzhOTm1Samtjb0ZEQUR4K1ZscVVJRnJXUDltaTVBclp3MFVWKzVNOUFI?=
 =?utf-8?B?aEFTODBQTlFheklmWjRQQTY0S1N4NVI0Z0trT0pXN0ltNGF4M3ZqMWw4YVZk?=
 =?utf-8?B?Y280VmNnYWRpMFpCaGlHWm5ZNEcwb05aQzUxR1lKL08rWG9VYWI4Wmx6QXJ1?=
 =?utf-8?B?RlJ1VzA4RTEwU2gzTEhTZWxYV0lJT0RDVTlSa2tpOW9LRXlJWVJwMHJabngw?=
 =?utf-8?B?QWZnQlErdURScVdFMW9jTUhPcjlLREJ6R3l3NkhQejNBQmowME5iYmxxcXVE?=
 =?utf-8?B?M2J5Uk8wQ3hQVWtsaDJRdW5pRlpTUSthMzBqSlBTT1ltK0RtUUxNV2FYOCtZ?=
 =?utf-8?B?VnlsTDNGTnFncDR5Mnc1T09KUUJxUVVSMzhGNjZHOTc5ekpPUWRVVDRJNFAx?=
 =?utf-8?B?dis2RWZEVWkwWTV5WnpJQVF1Q05OeDM4K1VoSE5yemUvK3UxZU5qWFJqUUgy?=
 =?utf-8?B?ejByUFRQeEhvaUx1NGthYm42a01JcVVWMTdsMzR3VHdPejRySGxGSWtyc3VH?=
 =?utf-8?B?Mkc5Y1Q1amRlMVFiS2x2enN2a2diY0hGcWtyM2NoUzlTZWxXams5c3ZPb09j?=
 =?utf-8?B?dzFudmlMQWJwRHYvUWJGWVFxM1dFc3FzYjB0bkY2blZsWXMvSEw0Vmw4Tmxo?=
 =?utf-8?B?RGdzOU56d0tYVUNETEZydWZQbGRLT2xyN29PcVpyTzM3SWhRM1pQYk9JWHFR?=
 =?utf-8?B?TEVFUlZ1Rk9JdXFiT1pkdjlZL0ZYY2cxYk9MVXRJZjF1UHVOQk40eUFhTXZo?=
 =?utf-8?B?VVlZb0lnaytrbVljTldpZzk2eVhlcU9PMjJzdkdraUF1K2dza05CdGlJc0tW?=
 =?utf-8?B?dTlCNG1ZUUxxZi9xUEgyMWNmTkVyWUo2anFUTkYxRmNEOEMxOHlFZU5ZTlhZ?=
 =?utf-8?B?MWdDUDhLYXMrOTg2YkpQQjRibG9UbU5TUXJNRS9BN0lBTmMrMWZncVI3S1Jx?=
 =?utf-8?B?NVFSeWg2YWVhc0h5UENYaFd6RlRYdlB0WDgvOVhVWXpST0YzbGVZZG52RUNT?=
 =?utf-8?B?elVoYzExdEs4YzBSL3AzaTVpaEJLRHZRL29iTlY5UlVJTVB2Z1ZZTkFpamRJ?=
 =?utf-8?B?c0pwMjFTS1FPTEdMQUwvdDcxTXk0RlNPenJPdmg4WlhLMWhPbDZKanVLYTNQ?=
 =?utf-8?B?Snh5VUJIdEo5TGgyK1VpK3VHblhRU0ZFNDB3STViSVY3MHhXZE4xTzM5QXZ4?=
 =?utf-8?B?RUN1YnpvWnUyS0d6QWxzU1BvZVNidEd6NnpQSFlUV3RHYWZqaHFmTldTbTMw?=
 =?utf-8?B?cTYvaWNTTDJpVERPMlNScEtvSExubXZDNEZ4WTVscUpmc3RUM3I0aW1qNmFq?=
 =?utf-8?B?R3o1WWRYMWZjcWtKVWZreXAyeG94RE5CQndUeE8ySzFsbEJNSDZtd0pURW1H?=
 =?utf-8?B?eEl1YkpSU2JUdnNhS1pObEg3NnFjc3lPOXFvS1pBYk9rT2hyc0hMWVNFVWlx?=
 =?utf-8?B?U1RQN3lPTzZlRlZNVnJJN1VRdmduUHdsVkVxZnJZZ2tBaWszbzhpNG9iUFRm?=
 =?utf-8?Q?/VBBni4HBE9HfWEI+LhuIM+P9HlYYLKeqKitguWHG3jh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bd1ea5-2af5-48ae-879a-08dd5a5e2ef6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 14:17:52.1330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwRzV/MRP5qhvlQUBeRCbWZ0t8r0gza7eO9LFCrXsBhFsH8ajVgPaR2v41cwVNcWqOw0vIK40gXv++RKf/AMaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484

Hi Juri,

On 25/02/2025 09:48, Juri Lelli wrote:
> Hi Jon,
> 
> On 24/02/25 23:39, Jon Hunter wrote:
>> Hi Juri,
>>
>> On 24/02/2025 14:03, Juri Lelli wrote:
>>> On 24/02/25 14:53, Dietmar Eggemann wrote:
> 
> ...
> 
>>>> So DL accounting in partition_and_rebuild_sched_domains() and
>>>> partition_sched_domains()!
>>>
>>> Yeah that's the gist of it. Wait for domains to be stable and recompute
>>> everything.
>>>
>>> Thanks for testing. Let's see if Jon can also report good news.
>>
>>
>> Sorry for the delay. Yes this is working for me too! If you have an official
>> patch to fix this, then I can give it a test on my side.
> 
> Good! Thanks for testing and confirming it works for you now.
> 
> I will be cleaning up the changes and send them out separately.


I just wanted to see if you have posted anything yet? I was not sure if 
I missed it.

Thanks!
Jon

-- 
nvpublic


