Return-Path: <cgroups+bounces-15854-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MYxDd5lA2oq5gEAu9opvQ
	(envelope-from <cgroups+bounces-15854-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 19:39:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CD6525EED
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 19:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E5A30277D2
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB413E0731;
	Tue, 12 May 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="YjZ5/4dk"
X-Original-To: cgroups@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023091.outbound.protection.outlook.com [52.101.72.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E73E0724;
	Tue, 12 May 2026 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607549; cv=fail; b=aXudfa8tJ+xrDSe4bDKlcHzUxlKicmzpeQ0ffbahV4q0nGlbX4/mXVFvatAiFwYxbjjFBAF0J6mg3HUlLSS8Q0XpcPakWPOK5sG61h2B7hIoPXwR0R8cVK856SfLK3L7ntUTsenLvNcjIZZ3WweBJxL+cCAlXEAqJHdSlOcj4ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607549; c=relaxed/simple;
	bh=z9WXWJhyz8p6KAroLUOlNzRGEvP6mS0o05SVV9i/8hw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B8iHmCTVYHc3MVk5HLy5bpqhpR2ttIoW58eyv37fFNY1Dq+edwZtVRaz8LjTVsTZYN66wiiqMgQjtvtBEIVOQC5geH9/D50DRNK/W048R0gSAHO7y7Nvo3V8AUSC/biZx40VX9+JkZdWncrfUHqrgH1ktE7yqTmMK80/bJ6KFiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=YjZ5/4dk; arc=fail smtp.client-ip=52.101.72.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uertgJ0/2AKSdurWCVueRnAkOHOhCdSA7WlInoNzVyE81vi0uI0nuQIZLMyOZLP3P0xhm8g6CCcra3O39B06xwBoVZIgP7KH0ZpAwrgL4JgMzlzKmf0Pj4aQv0TYZYR9vq9uXlcxk165Ff0VN8NaszNJOpv5LJV8hMewSVbxncT6/N+KcOnbqEpbJmxHhc2TH4b9Hn8n2rr2IGa3t2FkP+QDrunacLWlggmoYmLgH7nY+8gddRGdZiZRqT4OUsY/g9U+AHmHOKAKy3o1UTxXqUaTfQl0rdbuOgPYDmj4wJTMr9z9MGRRIJg5DDIUIjG143me+qW2omEhNqPV1qcbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EisQI8T2Jh8A1rdnhJdgBksw1XaKZCfY7W3zNGU7zY=;
 b=WCsOpDVtJSBpeyvCRH/zv3Q2fke2TOkVdQtpK5q8lyzjifw07p3BbBYYkrSKiS92lujxcI7baxHRzOGKftoGEosnhXNAmaIoyz0MW20mQXpnyJzcJeH1kfnjPOd/IK0cl7VZ8J8kKXrkVHMwJ+2NvUwgUcSYdGkBmMo/6FyN5kS5G8t8tPRHQ2aZ9OJ5IYTohCKA1M9oBNToJz6B14sApUX5X7YrEOZS126+pMUKT/06Lw+7U0xF56HKv7ouMQzYJ267kronZW7bzJPKmq65xL+BwZdV9iVTetDYP/P/HKyFfuO5JQhDdpy+tvCf7cs84HfcvmlX2UC5Mfi3Wu999A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EisQI8T2Jh8A1rdnhJdgBksw1XaKZCfY7W3zNGU7zY=;
 b=YjZ5/4dk76C7BjVJB0VgH4iuDWaWTMvvbHe3JDAbssvugdCu2oER56rHe0Pxfn5A7J/eaH98ibT7MXDJ0mdtDeX/5mUNh2k4/tLqM2n2fEkb//zYjOOSmw0X4aKebkasT2ZXiiFKP58v0EMQcdchx2icxqjUnFPy6cJnob3OmG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from DBBPR03MB10258.eurprd03.prod.outlook.com (2603:10a6:10:52b::6)
 by GV2PR03MB11815.eurprd03.prod.outlook.com (2603:10a6:150:36e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 17:38:58 +0000
Received: from DBBPR03MB10258.eurprd03.prod.outlook.com
 ([fe80::b7a6:58ae:c374:12d9]) by DBBPR03MB10258.eurprd03.prod.outlook.com
 ([fe80::b7a6:58ae:c374:12d9%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 17:38:58 +0000
Message-ID: <c446b9be-38d7-425c-9ca8-eda721fe1c9e@santannapisa.it>
Date: Tue, 12 May 2026 19:38:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
To: Tejun Heo <tj@kernel.org>
Cc: luca abeni <luca.abeni@santannapisa.it>,
 Peter Zijlstra <peterz@infradead.org>, Yuri Andriaccio
 <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org> <20260507163058.2c435922@nowhere>
 <agIfvZuvXEtK45em@slm.duckdns.org>
Content-Language: en-US
From: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
In-Reply-To: <agIfvZuvXEtK45em@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To DBBPR03MB10258.eurprd03.prod.outlook.com
 (2603:10a6:10:52b::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB10258:EE_|GV2PR03MB11815:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6fb816-35d3-4ead-40fd-08deb04d58fe
X-LD-Processed: d97360e3-138d-4b5f-956f-a646c364a01e,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|786006|376014|7416014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cQYFn+w2rZ5W6Po86IiFdqGZ7ff7IX49BVCWTH1fHstJVDD4cUlwWIcBjcaiWBXyiNLgf1BZm+zAmiBD881HHFyupOdJO6f/TdXJgraT35QoWKulGcvwse9+jrsgTZxfACdg7m0zd1AJtv7THEnB2S1yHdI9aLxAFam5lare10P4DamTq5I87DzPB/ZCQ5TOylayygVfieDc9fU3zwfTBDfKegGT4sJl9am1BAPUlghFuWdz2VxFQfwJrxa34lTNdVofgj8dOjqgWN4gIVqzublTxMRj7d/xDcAik/n0uKhyNiQaZ1c9wPzgzqalZ0URUQ9x2y2JL0f4QmBEtIX0DygYE8sn3jJ8Dc+TKcgUiaR3G7peGV3QTKk8ww32ItLCyxDV1FTt5Alachb2tsWFoFOcW/IfdAvfPuFXvQKMz4HC99paNRFkr/SgABDHxixeh9VfhqxP7nKT1Bp8oyH1Lg0+MGs6Wwqh4XgSnMsubquOiJ6+pTs+hn9NHy96v6xwmCilzdWg9Q93Ji+GqDTAw4l1gPdraYwmW1V8aCCdV3e49LedDzFSL4dnBFmZuz3sHCxBc8PUHpgWL4U4JUq7y4vz0RrQE58u6gv9BMPOc6eApT3drJf/3ZaRHvJ62d5pcjmKTSyLlP9NTziSNScL77u7NrjSjx7s48r3qSYA4xxQbIiXBHJ2Cx2UZd6RwJvS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR03MB10258.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(376014)(7416014)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWpXdkdDTzQ0Y01wbDhHL0hJcW9YU0xkbzBhc0ErbGZaa1BNVkJmcEl6WE5E?=
 =?utf-8?B?UFpmQjVlM1VERGkwVFdyQU1NMFNnaDltNVpIY3V1VjlVZEk4QlloR3Z0TExO?=
 =?utf-8?B?U2tSVnhZREtUZWY2TzhHSGFsenhKVlZUOHVkem9QeFBRYmJ1c2RzOWFEWXQ4?=
 =?utf-8?B?NmRRaW1Yc0YvbGZoTzJ1ZWhGY0VqUEZxeDNSQ3k5TUFWZ1NnWXJ6ZTRWbmhs?=
 =?utf-8?B?NW1BNUhEaGNkaUFEYVpnSGsxZmZnY3ltS0dqR2NWdTh4UXg2RFlsWDNmWWlT?=
 =?utf-8?B?LzVWOHhBK2dNTjJDbVArSmdFaWpmc1VqSFB4R09saTRURHpIOGx0LzZUYjZs?=
 =?utf-8?B?NzFaK0RidVllckg1Q1dzZ2FFbEQrQ2pVNVVKNURBUFhvQnRnczMxRHFsOExa?=
 =?utf-8?B?bFBDNlIzN0RIazZkbFpWUm9CeU0zN0hLSzk2T0JqRW40SHNGMEx5SE5ac25i?=
 =?utf-8?B?TVRsWENlQ08rT2V0WStCQ2dTdWQ5TVFQMFg2dVdEZWpzcit3UWVMMFNyOTA0?=
 =?utf-8?B?dVArM0gxOVlBOWRmMWZPT3V6ZldZV09CcE9wYVBjZ0xRcmxJRHpDN1ZiZldK?=
 =?utf-8?B?NWcxSTJhaDVTRkszeHd6TVpLVjlHWm16a2lwbWNYLzQ1bnk5L3JXOFJuZm5S?=
 =?utf-8?B?QjdZWitCU1lrYXRENlNDN1ZkcDhVQlg5ejNCcHdYVjBTRlE5OVp3QVNRSGJ4?=
 =?utf-8?B?RVdMOXpJMjk4Smh1dCtrd3JNQS9ISVdDVUgxZ2VWYWt3R0lsSTVOTlJ6cDV4?=
 =?utf-8?B?clFwc24ydU1uU1JCS3dOd2hBWnA4Y29MTi8rNHBkZ1BwRHdqYVJBeURPYUg5?=
 =?utf-8?B?OXlKVGpnVVoyeDQ4dFBCMXdrelpIWGNGam5UeS95dGtFM3dFbU1DcXRSZkVt?=
 =?utf-8?B?VlZwTE5rREs0VW9nd0Y5QzNldnZXN25MVmpwTjUyNUhBMUIzbWtGQnd4em45?=
 =?utf-8?B?RDNoLzF6SSsrWjg5ZXp3bmZUWXVjdGkzODBFK0V5U0piZ2c1VnJ3VGNlaU1k?=
 =?utf-8?B?ZlA1bHZFWFVld2xHV3BSc2srWHpiOTJhbnJSTHRCaFQ2NFgwQmlzdldkdnU3?=
 =?utf-8?B?SlNkWjQrVk9NRWJDdjlOYzJadkV5VzZ4VkdiaHFrelZra0V4dW1wYmw5dFdC?=
 =?utf-8?B?Q29JZzFxWUQ1TzdFZUw0SDJEMjF2REJvZlZERXRKSU1LUTFUMWNRZ21BbGZ0?=
 =?utf-8?B?dHNIRjJmZlJ2NW5mYXF2YStRRjc2WUM3WS9RWlVBZEJmcGM1QUpxdmRXdWFa?=
 =?utf-8?B?QnA5ZDcwNDU0M0YvTnhhUnZKNTVXQkdiN0tEdFNsL0wzZS9RZWt1UU9MNmFX?=
 =?utf-8?B?RzJKdWFLWldNdWlHTGF3QkNSZ0tmNUJ4Zzl2QnpZOTYyVjJ6ZHFhcjYyc1Ey?=
 =?utf-8?B?WEh1R1Y1cWg1RGRUeGFzVTd6Wjk4bFJqcEd6UmltVHVFQm1sNDRzZEh6emJN?=
 =?utf-8?B?Q0ZYQmt6a3MxK0pqNlAxUFNtb3lSbHpGQlBEUGJKSVlSUTRpRVFLb2I4bHAv?=
 =?utf-8?B?bUs1OVVBeXpUbzFEOGs4QUxIQ3BWUGIzbDBoZnRiTWdLNmhzVVNkaGF1ZUha?=
 =?utf-8?B?d1JqQzVQS1dNc3h6SjhSdEpZQ3UzNWZOdmhRcHhaVWZCVWlaZ0htN21lUWFE?=
 =?utf-8?B?SUF0dzhNMERMU29QZVZHYlVrS3R2bVRlcXZ5MHJMdFlZeXJ2RVBBeEYrbkdi?=
 =?utf-8?B?MUdITlQ0eXlYU3BhWkxSc0YvaU5zcXZNNThWSzBYOG1LMVJxb3RmejlTMnp0?=
 =?utf-8?B?UCttaE1ZazVvS1pTUkkyN1VyNXY3dURxSG5GQW5pOEowS0UzNzRjUWdOKzV0?=
 =?utf-8?B?WmU4ZXFaVmpzOGFTVXM4ZG5iMkRIbTd5MUM2MGExakJpeXRKTlBWTWxnMG1P?=
 =?utf-8?B?bUlldUhXZWpmSFl6TzlPaEE5VnFCNkZPYTZxTXY0V0tsd000UWhGVHowaHFh?=
 =?utf-8?B?c21aRUFzVFArdWhEOXE1dWpwT2ZQUFoyci9ZQ0xVTjI4ZFQ2U2Vvd1oyelZC?=
 =?utf-8?B?akxVRkVFVXRWcDdGbXhpOVgxaGxyVG0yUEVxVTJyTWRzYXV3TStFN2VYZVZ2?=
 =?utf-8?B?aFQ5YWtSVzZsRC9CSzE4bk4ySXlPWGxVWTFWR2ZubkErN3B2MUUxeWgwVGNs?=
 =?utf-8?B?OU53emtzaXorbFVNWDk2NjMrTEZqYThUUjFYcm16N0YrVWlXbHpHMGNvRHZD?=
 =?utf-8?B?QjZKcjdFZ0IyemxtT1F0SGpvUjFHK0p0N0dndHJjMHpkN2ozakVnSzJpQ1JT?=
 =?utf-8?B?ditPN0FuU3B5emk1ZjdkOUtNbjBvTEgyMm93VEV4c1B1bmd5SUlhQXozeHNn?=
 =?utf-8?B?OVBRWTlmL0F3K0FjeFJ0MW1zYkhGaWJCQ1A0ME0rRi9pcmxySW82Y1RaQjho?=
 =?utf-8?Q?m/FQ+Ka36XCnVkVU=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6fb816-35d3-4ead-40fd-08deb04d58fe
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB10258.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:38:58.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ijj9PX+/NXjj6ju1UuUu6bZnZcLbsKFwu13WP7aod7/iTr2BNCUkRaDTKO9UE+37hCO26Z514jBHFbxsUogsk8i0yqFBljDI6MfnsqD0xh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB11815
X-Rspamd-Queue-Id: A4CD6525EED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-15854-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[santannapisa.it,infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,cmpxchg.org,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuri.andriaccio@santannapisa.it,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

I've been thinking and experimenting with some of the ideas for the rt 
controller, and I've come up with the following interface, keeping 
everything in the standard cpu controller:

- cpu.rt.max <runtime_us> <period_us>
   Sets the bandwidth reserved to the hierarchy that has that specific 
cgroup as root, but does
   not set any deadline servers.
   The default value for this file is '0 0'.
- cpu.rt.min <runtime_us | 'root'> <period_us>
   If the runtime part is equal to 'root', the tasks are scheduled on 
the root runqueue.
   If the runtime is equal to zero, no FIFO/RR tasks can be scheduled.
   If the runtime is > zero, FIFO/RR tasks are scheduled under 
reservation/HCBS.
   This file is not available in the root cgroup, as it does not make 
use of dl-servers,
   rather only reserves the total bandwidth for the hierarchy.
   The default value for this file is 'root 0', meaning that tasks in 
this cgroups are
   by default scheduled on the root runqueue.

Of course you can imagine that all the admission tests have been updated 
accordingly, as an example a cgroups rt.max bw must be >= than the sum 
of the rt.max bws of its children + its rt.min bw. I'm also skipping 
some details which are only meaningful if we decide to adopt this solution.

What do you think of this interface?

Thanks,
Yuri

