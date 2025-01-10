Return-Path: <cgroups+bounces-6090-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2F5A099BB
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 19:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC5C169477
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D62144BF;
	Fri, 10 Jan 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DdJPrPfG"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26C214A78;
	Fri, 10 Jan 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534460; cv=fail; b=rLA5ie9ys/kM5atfAKAxQe2Zrl8pRwimbmp7pN90s7vrm0AVfZDGHRRN4fGWtXYyAe2CfIhI+AiI/RC7Tl6M6IINp2eSr8qfBVpYFHCCaGJ8mXU1VAYdT5aWvGMGk69DUAatOA1ijhuXc+YtN+BgG9i/J1AgCdkKDZpT73mTpBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534460; c=relaxed/simple;
	bh=p3ACmv3s+ySxFCXmzoxH0E7mO7HZnzxRdSqNKbGLTME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UcLjA42X2MavQQ8bqTerMrvzcz0Cz0Dq1/uuPmXvOYdKEK4AuEwEFuoHSd0qR/gmy7sMpmkyGmTM7qSW0HYKbj3rkgMrT7VJN1gMGg9vHAmRgKc9A1qTPr3N1oVWx/NXAWiMj0scQMSTnsAKrVo7YuYhfYxfT46a7iXQsfhLRmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DdJPrPfG; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHlZKxxVsLAIvvhd976XP25+nVMLZlSeKFp97LBZGVYCtNqaM4GC9t2MNmkCyyKJZ/0NT/LOfA9wJXHHqYuOTjvJpHkDSNpeulOE2cG/uA/ChLXSr+4bBy5AB8n33ouO/iuO84vSUQvd4EIbEOKFsOe5mRHZZMFmJEJp2sESd+4IL+t7nSmPpEYmeoesZ9m+2VvGw1GaNWZovpnW49cY9rz210hlVm5OOkeOhctSeABgnbnxdvFPLd6tBftzwHa6yXLwy99bMirDU/q4ifQLZ9g/FYvB3biamh0c4sPy0U9Z+lTdjy6RZ/duEZLn07r312y4DbfV5Kz/HKvUtn6pWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CUMsflQcEvwT/y9TSCKpcKlNqJeKuEBXvlK7vyqpR8=;
 b=tTYTYdiR1rKPkwqYthd4uA3PQfVcUd4xF8n6rjbhkh8cpP9208jsOSZL40I2mGBuVX5WFfvGDRX1AOX425o77lURyIovDD+w7OkfTpCeQVAPSbCah+SweAuBdUW8uij3DqN26kJt975TsaHc6oiZC7HAlbZjpla4mIAZEIfe1iMCPjBfm2vL6GgOIrnV6r39S9a7NPwRBYEZJ1Y6dqTQUnF/x5sf+sU0PhErEJd0X3kdNDSkbAvE+h6+0UpNBv54FAQrFoWnc2OcgRAB15cUYQQZAlCGAbrT5XHHNnHH8SZpIsmreAPNk7Xg1KcRcK7quprwh23MSwX6UOzOLdxcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CUMsflQcEvwT/y9TSCKpcKlNqJeKuEBXvlK7vyqpR8=;
 b=DdJPrPfG3W/tUVkDkaHQlq/tOW7IbOXLfAcQv3c4j/xURcoBFRenaEXjBXhF6zo/NYOin5nkLuC5TufmWJDUJLs6ITc9dWqO4NfkSuDz3Ip2SKLVvqzAgvdujwK4naIVSz5oLbZjX/wqwZTYoB/jonLXky5+21BI995fw4ncjkn5n6+D9g3awpW9OwiYBIydXE3sGOP/wU5+WIOEohzJwgZOw9TJ+Rk8YkzUHLc5IFi3KrFT8d07D0KWx1/Ap357SEH1kvkFvmQj1I05JrLkTKzhuaFOkEFUNhDG9b8dHtWca4AutDYByHXEbfRITy53LEJ2q/eJuKTSHbj5T34sbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 18:40:50 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 18:40:49 +0000
Message-ID: <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
Date: Fri, 10 Jan 2025 18:40:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
 <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
 <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
 <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d659d07-671f-4850-02d6-08dd31a64d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkxuUHYwY3dIdENKYnlLSEk2WEtUQmpkU1ZpYXozVVR3SnNUQy9waHdZVHpK?=
 =?utf-8?B?cUJtTThNMjNOeVJ0OHRTVWdYcnlCREhINnhWWGJuRVNhTVZZY2kzY01LQjl6?=
 =?utf-8?B?N1pIOWJJUkFST1EvbkNaU0x1WXdSMTZZUDk4Mk12N0hiOUhlRkVycEwvWFpu?=
 =?utf-8?B?anRzUWN2MStHZUx0eVExS3hRTGpPY1QrSXJtam1jajZaYXJGQnpQRFROZDlQ?=
 =?utf-8?B?Tk5HbXo1K0Q4SmE1OFBSZFE5Y1AyNXBoSkNZZ1pJQWlad3JQZVlBdUc3OVdu?=
 =?utf-8?B?cVpWWnFYaUp2OEhxK1hyMU5LbW9rTldZKzBsVzYydmZlYkE4S3J2VngvVWE3?=
 =?utf-8?B?aE15QlJUYW5qbzI3eEVsOTQvTzFXYVl4ZjZpcURGREhTeTBMVm9vT1NoZERF?=
 =?utf-8?B?ZzU0VjFlOEQvM1pjYmVkWWxEa090dS9jazFJNkJzMGZySmhYbkNnSXZ2d0pv?=
 =?utf-8?B?dllKOGplQVFKbEEyNFFhZEVEV0dUSjI4Wk1HT0RHd1JoUzUvRVp6cmQwTU12?=
 =?utf-8?B?WnVGMUtmeXc3cDB1UUNMYjlBbzNTYzBKbDNXUTVLVFl2b2J6M1g4Z29qWlUy?=
 =?utf-8?B?eXB2WENWWEYxNU8rMzRhN3dwWVRpeml3bW52VmsxMmdDVUp4ZWJPbHVVS0Vo?=
 =?utf-8?B?YUxQSlIwSHlIU0gvNE5IU0tueUFJK0s4MGVVRWVHd0lYL3J5ejlISzRYR21W?=
 =?utf-8?B?N3ZGb3ZzNEVVU3RveUttWmxYQTRURGtGbzhEQ1lUM3ZFODREUDNEUU4vSVNF?=
 =?utf-8?B?YklvcEJHRWRZeld5amRYMXBlOEZoZEFPbW1KdllxcTJlbTlkNlNsS2wxdlR5?=
 =?utf-8?B?NkIwM2l4RitzdGV3RGRUT09qekxMMHpva3pYTksvamdiVFV5akl6dmN5S0RB?=
 =?utf-8?B?cjQ0ZTFpTjFvVDluYUowZncrM0ZOb1BUaFV4T1ZRYWY0NTdaTnovNW1iMjQ3?=
 =?utf-8?B?L3Y2QXI1QysvdU5RRkZDU09iVmU3WmdBak5BazZIMzV5cXgxZW1EeXlta0M5?=
 =?utf-8?B?QXllQVRmVE5PMlByQ3ZOQTROOVVpb1FGTFAxQXBXK0VFSktkRE4reE9QOGF2?=
 =?utf-8?B?UTcwNTFHekdjYmlpREtNQWxaZGdabjgvNjQvSE9iREtXR2pnUTkxN2ZRNnZq?=
 =?utf-8?B?SG01ZmVvV2VGSEpXV2M3OVZxU2krcUxiWHppTkJac1BJeTNaUFlhbVhmSHdx?=
 =?utf-8?B?cWY0S0FBOEZYT2xzS3ZRY3R0RWVJb2tYelZrQTllbGtZai9kM3Q5MWFNUFhU?=
 =?utf-8?B?V1cvZ3pCcUEyK1JMQ3p2OGxncDZDcFBTVTlRalF1dEdINEJSSFVzU2VTeTJY?=
 =?utf-8?B?YXJUeThaYTVOMFVIaUV3akJPbXVIUCtrYVBUK3UzQ3BHV3h3N1VVYUxxUHJq?=
 =?utf-8?B?MXNNSHZTTU1uak9rSnUxcnp2ZXJqajZiQytFdWdwY05xMHlnZlNaQlFGcmxW?=
 =?utf-8?B?RTFDZ2FSbktsT3JmOFU4a1k0b21pWGNGNEVleEd5VGlTZEdJcGdEVTBNN1Nl?=
 =?utf-8?B?dmpPSlBacU1Pa1VtaTIrSXp5MWQ2L21HTG12c3dHM1VXSUJLQUk5Uzh1TmVC?=
 =?utf-8?B?dWRHY3k5TGZrOWtnOFhVQWN2UW80QmlMbmVJODhIK2ViMFQ4R05HUDFEb0c1?=
 =?utf-8?B?V09mRDE0TmcwM05jWnNEVDJWNGhvNlZsVUFJdjhCaU1waFdtNFE1SzI5c3RC?=
 =?utf-8?B?dTY2UFV0R3lOZ29jT2UwWm1GWWZvelI3bk8wbHN2Sk9yWEZ3UURhdWlFeVF0?=
 =?utf-8?B?bXlCKzB5bm1DbU1wbzhYVUtXWHVEaUVkT0c3anZMUklKMWtLMjNVeHpoNk5J?=
 =?utf-8?B?bWl2bEVjZXNSNUFrN05WUUFYZ2dFa2FvTk1RM2E3RzBLR0FWRFpvRmpMTDBL?=
 =?utf-8?Q?uP1dS0fEHrp9M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmJQSk1ua1pVQXhHRnI4SWhqTkk5a0hrc0wrWXZzS1BRRzNtRzY4Ty8wa216?=
 =?utf-8?B?UVhrVzc3cDI4djQvUlpKNnVVeXF6bE81U2NPaEY0QnBYUWRpS3hEZUFXc3hE?=
 =?utf-8?B?Wm14aEkva1NVT2FQaG1iZ3B5YThGRnR4WXBuWjJ2cmhqZnlSYWVlZlcwc1ZH?=
 =?utf-8?B?bURxR3dSdmw5SEVuT0cxQk90eG9DSG0yRkkrTjI4ZTJiNFI3TnJjd3ZXUWs2?=
 =?utf-8?B?MXBJTDZJUVFJSFM5UEY4dlNHQWNYWkhlQ3lkMDZPcnJXQk1ua0pEWkZ1bWV2?=
 =?utf-8?B?OW9sd1hmdjJWbUl0YldhQ3kzSW1wMEpTSG81Ly9EWC9FVTk1bW8vNmRZMVJ3?=
 =?utf-8?B?RVM4bFBDbVQ3Z0tMaXRjNGRPRE1hZTcwQjgxQ3FwOFQ3b3ZId1JXbTFCL0RS?=
 =?utf-8?B?d0JLb3R3bHR4VHd0NXRjOERqYUwrNEU3UTBuQmJHekU3SlkwWTZnOE0reVhW?=
 =?utf-8?B?VjZlNHVEcDJDUDZVWHIrc3dEVlJlT1hRdFBJOVJzSUdNSG5oWCtGdklaZlBR?=
 =?utf-8?B?UXR3UDdKbDJsTEI5SGIyd0h6QnBnT2FLUllFRS9kTmVGS3hKTG1aQ0xOdEVt?=
 =?utf-8?B?TTVmdjQ4SDdGeEhuNWVjNGt3dGR0blV6WGNic3VpRkhSR3dvdVl2dFY2bU5v?=
 =?utf-8?B?cTB6MEp0U0hWRzVaWXV0aGpydXp2U0VObU9hU0E2WTZpSHpxRmVFOHdSWGRx?=
 =?utf-8?B?c0I2bnhMMStZNFFVWDd5V1RrTXp0cnVkdHJzcW1LeTlkYkY5bmxvcXg2LytY?=
 =?utf-8?B?L3FERVArb0gvaVRqTkV4bmwrTjNtWnpOYXAyVGJsbUxLd09pbkdkc1ppOEFB?=
 =?utf-8?B?ZFNUeXEvSm0veERGQmxTN0hsL1lVY3dDZEgxcWtFcHBPMnpWVUNXNXJhcjBN?=
 =?utf-8?B?UXVSUWFvaHptQTM0UmtOYTRpT0NKcTIxUG9uYnhWRlRaOVQrWmhMTGcrUTln?=
 =?utf-8?B?eFNnVTNCTjVZU1QySUxXL3pCVFAxbm1qMytURFJ0eGkzVHdBN0J4WjFmbFVP?=
 =?utf-8?B?Yy9mbHdrdGh3NnNQem9WaVp5VkFzL0pxQ2ZsaVpRVjVQc2JWM01MTHluTDBM?=
 =?utf-8?B?SXZBdnFxS1pOMjdwQXRkU2dFY3pUWWlURmlNVWt3QjFISmNyQnA0bnEwd0JX?=
 =?utf-8?B?blRIcVFObDRnQ0NENHpFMEpSWHcvWWRocXgrWFcyenBudXY0QU8wSmxURFpx?=
 =?utf-8?B?Y1NZeVVvaEhweS9RS3pLdk04YWsyd09KV1JpRWVRNFZ5dEROUm5KcjVXOU5U?=
 =?utf-8?B?Y3pkR3lnL1hPNmdMVDRyUzd3Z2pNVnQ2aGg3VkhSZ0l4YWYvNDVOS2tLU0hs?=
 =?utf-8?B?RC9OeXRNRkdLTDBHakk3NFVLUjhtM3JpS0tGTFRjU3ptR09KTTFOZEJvRm9F?=
 =?utf-8?B?ME9zQXZQZnZ4OU84b1JHOTVFNE1KeDJEK2gxcnkyYXYyR3JIbVdkQnFkZTdT?=
 =?utf-8?B?UGNsNG5NT0V6ampYby9xM3lyS3MvK0huUExFbzBZMVNXQ2pDYXlXeVN6L2Jk?=
 =?utf-8?B?MkJ2OGR3RFNnNDNDbGlrOGI1Nzc3RFRBK0ViRlhhRnZVWm5lVEkwZ01yS2NZ?=
 =?utf-8?B?eHVMUmJjelVXbWlyZW95dkZSWDYxMHhVMXlGRUNoTmJWS3pudy9mV1pNRDc0?=
 =?utf-8?B?TGpoVHNkZlJvRVdRZ3paQ2VXUnF2bHkzZWxUT3FxT1ZFRW1RKzlpWkZNWERn?=
 =?utf-8?B?WnRXR3JyaXRUODFYT1RhZjMyS1c4WkdqUVNVa0s5UHhGckQ3ZFRlUW5Fa2Y3?=
 =?utf-8?B?MXhlTG1XQTVVMk80RWlLa0tRTHdVbjdGVmlZNHNDUXJ1QWJZeVJ4Q3A4ZElq?=
 =?utf-8?B?dnFkMzNGV0FaOVlzTnhrMGhGUGFwSlNnalJDbXc2ejgyelhiUSthVUNFZnVu?=
 =?utf-8?B?OU93SGpIMS9jaGZwR0xEN1dlaWhuNEoxWXZDZHlVY0VYanZFbmt2ejNId2tK?=
 =?utf-8?B?cjNERlY3QTBPRG92ZUE1NFUxQU53QXJvMXFyMld3eThyRUV4bmJldG14eXNR?=
 =?utf-8?B?ZFY5MlBEVmI0MGNxeGwrSHgrMEl6RHVzSHZLNVF4YW5XdG5hNWVUcWVVMFNQ?=
 =?utf-8?B?cENMemUzeUZDTHlUdTV1VlRGYlYyZjBFZGpsb3IwWkJ5UmRWZ2syYktFQjJ2?=
 =?utf-8?B?a1FOY3hVQm9DUUFPOE15MVp6ZmwyWklhaFE0M0tUN0J2V3A2NHpCeXBSQ1Vs?=
 =?utf-8?Q?XSKlp2afbSJWdxfznceeBl7qz10SRSH9w7EJQZKub+hH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d659d07-671f-4850-02d6-08dd31a64d98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:40:49.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2AegEVyyOSQ0SwVHX3QEUtwBRQXsy3bj856YQzaCbFFVk8kGjSVgMrahDuG1r3ViehlmKG7iCj/pIkMVBpZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

Hi Juri,

On 10/01/2025 15:45, Juri Lelli wrote:
> Hi Jon,
> 
> On 10/01/25 11:52, Jon Hunter wrote:
>> Hi Juri,
>>
> 
> ...
> 
>> I have noticed a suspend regression on one of our Tegra boards and bisect is
>> pointing to this commit. If I revert this on top of -next then I don't see
>> the issue.
>>
>> The only messages I see when suspend fails are ...
>>
>> [   53.905976] Error taking CPU1 down: -16
>> [   53.909887] Non-boot CPUs are not disabled
>>
>> So far this is only happening on Tegra186 (ARM64). Let me know if you have
>> any thoughts.
> 
> Are you running any DEADLINE task in your configuration?

Not that I am aware of.

> In any case, could you please repro with the following (as a start)?
> It should print additional debugging info on the console.
> 
> Thanks!
> Juri
> 
> ---
>   kernel/sched/deadline.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 62192ac79c30..77736bab1992 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3530,6 +3530,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>   		 * dl_servers we can discount, as tasks will be moved out the
>   		 * offlined CPUs anyway.
>   		 */
> +		printk_deferred("%s: cpu=%d cap=%lu fair_server_bw=%llu total_bw=%llu dl_bw_cpus=%d\n", __func__, cpu, cap, fair_server_bw, dl_b->total_bw, dl_bw_cpus(cpu));
>   		if (dl_b->total_bw - fair_server_bw > 0) {
>   			/*
>   			 * Leaving at least one CPU for DEADLINE tasks seems a
> 

With the above I see the following ...

[   53.919672] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
[   53.930608] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
[   53.941601] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
[   53.952186] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=2
[   53.962938] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=1
[   53.971068] Error taking CPU1 down: -16
[   53.974912] Non-boot CPUs are not disabled

Thanks
Jon

-- 
nvpublic


