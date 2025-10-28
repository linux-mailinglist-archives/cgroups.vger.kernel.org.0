Return-Path: <cgroups+bounces-11278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD07C15ADE
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 948EB542718
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920D5346797;
	Tue, 28 Oct 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="obzFxSnr"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8D346774;
	Tue, 28 Oct 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667171; cv=fail; b=qH0JlD22TndHDc/aWvVHS4N/G5E+N24JdMq12dfXA3SH2tlLsrEI44IJRli7sJeymBjOchV3KyUFneigKRaq5an3BbL7mgSsTTKFIGqqer9ETBP7SHRlbwEPox37hYGvdnGEXMrVbT19kJztdNvSslIaBFAgspcQ5lGHrORQBkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667171; c=relaxed/simple;
	bh=ALu/2CTSnTwfQbqVI20muKp36joCtOtV5z+7UFGbZdY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DtRBc59leK3folfjHzeWPiOhyzZ96v+ab3ygf7PiQMAHPl82bLy4tXgwuI5Bk5VBZ9/whfGHT/qtfMdPSmGVL/O6FF1T9Tb/Jq89o5zl7S7XSIPiCECDM7IW+ylz2qOoR1SG+1e6ok14oibQG2zAjUP3knxumTZF22/zLrxndnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=obzFxSnr; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SFT37U3245792;
	Tue, 28 Oct 2025 08:59:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=WantUP6tHPomrrgfGpfQry8HxHWAoDwAelBa0MU+fH8=; b=obzFxSnrh9ac
	Rh/o80Yghy/Ss2H16zjz+484s/QXzBSAh3grJWOaUgu+zYXP9Tmlj9D9p0nTgfNl
	fAPnBh1l9KVBpkaPPtLj/DAc7YWbRb3tYXfip+JqxUQYyFYBr9TKZX8P3YGpwL5I
	JDHm4a62joUi1RYOl6YAJuMYrtN3mfLZmGGQ0g98MgZIJAb0jxM+Z3Esi+SngfoQ
	iV3fniozyzDu5V8CcrLjJSNTnSkZ3uqh7SOTJKgY9KKCVqRYXe+3ERpTqfeGERtq
	1i3eJ4ggr4VWXMaEutvTqB5J0FT+IaGQ9szxIUfK3WZoj1aIgKUBppqtAmK8H99e
	hONkGqEfwA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a30gxg8rb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 08:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No8pzz6clRCra57eN9gzfm/GnhKv6Xk+mRrg978OaLX1FIED1aJ3HYczjtIGtaWP5qQ8BebQPkBpWTuXtQb9VYZftuZaTinXrugTk44J2mGQeJZjS3CCqCKPNxKfBEjiiqBeEaxdLvcmiuvX0/MrYlhYz6ZcByKkbj93pT/95XCpDJELyf6LhBrapfEr5MdbfvpZ16kIIEjx+LhGl/27SxOtH5xXEDUxxmfqFXLyExHaUVSRxCUJLpdXx2uzr4zG63h9rOx/muHej4UuYZk0ZgfKGIVChuZXwfW3gBOg5hQ9gHSe2v2ltD4a2ifcZcxy6yP9vke0r6TU3cboJoFAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WantUP6tHPomrrgfGpfQry8HxHWAoDwAelBa0MU+fH8=;
 b=uWJDglYJZH6L7Kkp7xEGxd9g7c4QILdtC0wbY4IpFQv/N9k2UUC114Ra24jCe8bsMcxaqnwlMevVKlXfjgtT0VPrBwkfV04RBsH3S5D/RCSTuhKGwEOuAc1TfQprLRl3/Gd0P2zbME+BrCXLDowVjDLMQRrfqy+oJGOaZN3/qXnLccLH3DXUpuDOF6l7TKyUyXW3zuV+hQXHmvwEukSuvbRn/cUxamD+a5glKpOiwvlD7eI3cmRighmVG4aL+gv5iAhxbhyXvKjoqAIz/qaeo4XK83Vt+9j2eeCcKfyWMSArQO5M5fcpGD/Uolz0QwzlQkdkk1bk+v74bWnyXLLl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BLAPR15MB4049.namprd15.prod.outlook.com (2603:10b6:208:271::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:59:03 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 15:59:03 +0000
Message-ID: <a1d4d200-5a35-4990-8499-6dc7ea6d65ac@meta.com>
Date: Tue, 28 Oct 2025 11:58:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
To: bot+bpf-ci@kernel.org, roman.gushchin@linux.dev, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, surenb@google.com,
        mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
        andrii@kernel.org, inwardvessel@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, bpf@vger.kernel.org, martin.lau@kernel.org,
        song@kernel.org, memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251027232206.473085-4-roman.gushchin@linux.dev>
 <634e7371353c8466b3d0fa0dd7ceeaf17c8c4d7b274f4f7369d3094d22872cd6@mail.kernel.org>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <634e7371353c8466b3d0fa0dd7ceeaf17c8c4d7b274f4f7369d3094d22872cd6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:52c::35) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BLAPR15MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0f9a5f-bb01-4961-5cce-08de163aea75
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlNrcUp6UHNYb3JyT0V1NjlwaWN3R2I0RXVyUkdmQVk2MkM2blY1bS9tNWZU?=
 =?utf-8?B?UlNLYUdueW1kQXM5cDF3RUFKd2JDTDZ6bFE0L2owb1lZRklTT3BGeUtITXA2?=
 =?utf-8?B?K1ZzN2N1OE5CVXVMR1l0bzUva0hOeDJ3Zko0WFkyY0RyY05WdjcweEZBSWtZ?=
 =?utf-8?B?MFdDd243bWdhUlpKMkpzNG0yYk05ZGtXSWpGVHp6SW9CVWk2UGxWS2kwWmla?=
 =?utf-8?B?L2JZck9YYlVtKzJPK3JhaUZHa3h1NEdadHIxS2IzYk9LbUQxYlVNZW1qQkh3?=
 =?utf-8?B?alVCT21idzVpNWJEaTV5dG5xTC9pTDY3enlCeWU2LytYYkFRMlgyS2wxckVY?=
 =?utf-8?B?bXBjU0xIQWRiNTlsU0toQXVnSkZOSVVVbHpZWGQ3UXpVYk50amsxak5tWkda?=
 =?utf-8?B?bzF6MStkN2liclJBd2ZDV1pLUDJiWE9Db014dWFja0RvVkZncmN5d2k4aXFt?=
 =?utf-8?B?cWxld3dxRXc2SWpkejNJN1hKSDc5TG1sYXY2VHRYdE56YVVqZ3FpY21wMUd1?=
 =?utf-8?B?cElTOWVOenFKelV5Q1BIcnRkZVREZy9zdTRZQ25BaDJkYUd1SVBhMis4ZUJ3?=
 =?utf-8?B?T2dsUCswbTFlVUx5bFZlUXpxUG1HWmdDeVBsMnExNWw0MEgrNnBwbGZRejJ0?=
 =?utf-8?B?ZFZuY0htS21vZGxnSURTTW5ZY1FUZjltRTVqZndUMFhiZlBkcjhCM09JcHRQ?=
 =?utf-8?B?cmgxN3RQUXNsNWRsazNPeEZwVmFIL2E3VmxKTHQ5WmovVEtZd2wxdC9rOU1E?=
 =?utf-8?B?dkdjWTlzRXdCYkRDcWdtcklENVhDSS83YnJRamZ2am5aZ2puS0wxSjV3UDBR?=
 =?utf-8?B?NHgzS0t0ajVHVC9DYzRVN2FueVgxdVQzdUpHOW5IME1NZVg3TVRUYmw0V2RU?=
 =?utf-8?B?cUJyTVJQRE0ra1BpNlhxNmZOR0RDbmd1NXRocm10REJKb0VRcStveGluK0N4?=
 =?utf-8?B?bUFWMDgvaFdCU2JwL3RjaW1EeEtUZmdKT0Q3TzNLK2p4Mmh2TGJNa0tOSjcz?=
 =?utf-8?B?ZEcvb2o5VGg1ajY0Z2J3SWMwR0tZa1FHS0ZnUjloVGlsZ0pZL2o3Lyt5U0ZQ?=
 =?utf-8?B?ZHFTekFtRllQa0U3cnJPY00xMldEY3ZNdktYTngyQ0pMbzJ1UzVrZTFIUzIx?=
 =?utf-8?B?THJMdk1VZ0cvNzFkUmxBWnFjT29KWE1vZCsvc1FtejNrMytBTHphQVE3Tzky?=
 =?utf-8?B?KzRGY29kOVB0K1gwcWMzTmg4YWwrcnY2bTVFc2V2M2hxdDJWY0hMeVdkUWtY?=
 =?utf-8?B?TDRnR0VEcHE1RVZtRHEzQThqMmE4Q1Y5N2J1NEZJV2FwL0EvS3hkYnBaS2Y3?=
 =?utf-8?B?VHl4Sk9wTTBDZUtmZ1d5aVlpVU82ZXdFSTF4aXJXQmFPc0h0U0NPRTZkREUr?=
 =?utf-8?B?WjJZajFNYnVwcUpLVnBzUTlhQnZ5UnpRUS9PUFNVeG9LV0VmM2Q0eVh5ZXBv?=
 =?utf-8?B?N2VwMmV1cVphR3c3R3BHQWcxVDN2SmhxdUVRVkwxWGpxclp0UzRta0liVjNw?=
 =?utf-8?B?OE4wM2p5amgvN1B6bldzQXUySlN6Qm5VWm85UEdMWXBRejJYamdYTTdQNVdn?=
 =?utf-8?B?b09SYWpmNXk0TURoUkZTUkVta24yQ1hKYlZuT0RwUUsyQXZXOUh2bHFoRnlk?=
 =?utf-8?B?cGF5cGpuUUh4MUVkcmdFdHAwKzRrQ0k5c2QrelhJQkgycFB5d2krSGo5N3Y2?=
 =?utf-8?B?YmtJb2ErZHVXckxTanRJVlpEM2FhOWJtZUo4d3lSdzN0M3ZmNisremhoOVlB?=
 =?utf-8?B?OGYrbiszMFdqN2FlRGNNbm55YWpvUlEwQWdZbXBkeHdSa1IvcktIOGRzYytQ?=
 =?utf-8?B?a0xSY3owa3h0YlgybEtDVCtqbTRuUmtPYU1XZng3UzA0NlJGRGRUaTJtVUdt?=
 =?utf-8?B?VjZDd21JdFNVWHhlQVpDejB0Mm5tekJ4U1FTRWh2Qm1jZFNOZ01Pbm1CeTNt?=
 =?utf-8?Q?n32QwdGzpeAIcrtQjjzWdHZPI8sZjdQr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWI4ZDNQVmFQVzRobVRkNXFXKy81YjdhdzZBY01ac0VKTkFQTDlNWHNMTFFw?=
 =?utf-8?B?WThhODVKSmRENlkzdG1rVlY5cE1oS3NPd2I5bFlEQVJQM0lHQWxRSnVYTENa?=
 =?utf-8?B?ZWxPeGFVRVZ0aU56ZWZXaUkvTkRpSmV1WEhvakJ4ZHh5MFYySmRBckl0Yzkw?=
 =?utf-8?B?K1dDaDhEaUFaQ2xNSGljZGJXRjFydW03ZkowYWExV3VKbTU1VytyUDBaSzhN?=
 =?utf-8?B?Q2F4OWpkQ01XUmw2YlBlYkR2bzh6aFRWdzJsY1NlTjR3R1ROMmxHc2pEK0VI?=
 =?utf-8?B?V0k4RlZlWm0zcTh6bkJmWWlTMENRejB4eDJJbWkyMkE2MFEzTFpINDJPcmR6?=
 =?utf-8?B?OHFWWnQrUDJKR2grTm1jSFZqYkRWQkhObVJRY1FVcWd3VTJzZ1RNRzQrcTUr?=
 =?utf-8?B?eldRcXFYV2tsMGRqV1QvNjM0N2FRZHhZbmlLYzRaQnBFVUY0VWFPb2ZRdmtW?=
 =?utf-8?B?K3duTWNmcG5wWHVkZU16NWU3NW5JYTJicERJSlB1d2tKbTFsV0t2dFZ5a2xQ?=
 =?utf-8?B?UEl1VFQ1SWdhTFh5dDZvYXNUNVZPOUFwUHB5YnFYai93cWNtUFBLdUlnYWo3?=
 =?utf-8?B?TktGU1k4V1hiVWQrVHFTancvUS8vUExPeXQwL0Qvb2dOYnlGeWpCbUtzWkJH?=
 =?utf-8?B?cXg5eElSYS81RXljYXAyaHJ5M0htMzM0OTVxRWcrQkhtR0tGMVhYM0trVWVB?=
 =?utf-8?B?dDMzOUdYcW00SVoxRms1YzdLdFlObUM4WEMyUnFsRWtTb1E3eGhqS0F4SDR0?=
 =?utf-8?B?dVpZK0JIb1ZiL2N2ZUhiYm5GN1Myc1UyVStqMDdQcHZMWVhBRk9KZ1hQNDYv?=
 =?utf-8?B?UGE5RlhoaGxYYkpFT3Z5TG4wSzRCK2ZLU0c1Z2t0aG53UkNXS0dGREs0WnE2?=
 =?utf-8?B?VWxLNWhnQkpaME5JSFhla21nT2RjRWp5YVhhTCtXdDZJeGFZQVUxUEpBTXpq?=
 =?utf-8?B?QVhyUTlBcXJ5bWVzbHpSOGdKcElJNjRpSk4zN0RHOEZVQ1p2bTBIbW5qSUo5?=
 =?utf-8?B?Rk51alkvcVBuRmQ4U1ZwSW9mQUZUR0ljVjVyVU82cEFCKzVkNjFycFIzZjFU?=
 =?utf-8?B?WWRYVjhGLzRab1BtdHN6QmVOb21pNWpJWUZkVm44ZWhWdld5c3M4OEt5OTF4?=
 =?utf-8?B?VjZ5N3V4TzhiUmtrWVJKMmthemNLeHdRa0tTRlNRN1ZPVGdySFZuZFJQdWhx?=
 =?utf-8?B?eXUwaWljcXB1UjI0b052bXI1VS9QRmxrUG9CZHF6SjZxK1lWaGU4ek9TYXRl?=
 =?utf-8?B?UWs4K1Y3MmgwZ3J0N2tDaVRYMjhZNWxwMEduaGQ2U2RRM1A3M0kwTU1rNFRx?=
 =?utf-8?B?ZnZIQm94cHUyWlVWeVlTOXZ6WkVqT2tGRnRORGZ0UUJyTnlqaW1LczZPQnBO?=
 =?utf-8?B?MjZTbW9wMjg0c2tLY0E5RVh0UDlZTTRnNHo1cjUvZ01reDJvOXExb3B6VEtO?=
 =?utf-8?B?M2tZRFAwMC9zVERkbm9HNFNhYThUUERtSzJ6TVlUZWc1enNpVmJ4Y1J6UWUv?=
 =?utf-8?B?YUFTdzkxckF1OE9OejVSNW5FUVdLWENjVXI1OVlvbC9JQ20vdnBIT1lTQUlH?=
 =?utf-8?B?WXFFRDFqY2RDaXIvT1NKcU9aSnVCQklUZm1GU21McFNqdE45SVJmNTlNc3FH?=
 =?utf-8?B?SElzQzlvaWVhNXpKK0xhVHZ1OU1kUTVQcGl0NENkYkczVzBhYzNZdXJMdDBE?=
 =?utf-8?B?OVNGRTBqTnJCUklhallVVzdPQ2svdjRQeHRRWHA2TStnRnFmejN0MlZvRFEz?=
 =?utf-8?B?Zmp2dUpDbzF6cGNuYmdCbHlNSEtQcEpGcHNoR0FvazdXQ2FHbXJHSWRvSkFn?=
 =?utf-8?B?MHFKekdQbmYxb3FqTXlUR3lORWxWS1k5YmRFYVZIZmRMT2RkNWRTUUZxamx0?=
 =?utf-8?B?NEpreHlVcFZDdXU5T3BqNUhhUGZEeFIwVHpRYWtDMkhqY2FnRk85UEhaVnBz?=
 =?utf-8?B?NzRyaHdGVXJsVDB1K0xHczFzVVJDeHIyL09YMVN4dkFrZXJ6TFhieS8ySDdv?=
 =?utf-8?B?am9uaytyT1RTMUlYUXk0RnN4VUJPNENJY0ltUVl3cUFyZ2NaUkpCSlFIRHh4?=
 =?utf-8?B?UnZWQjJ1WWkzY1FNWjBrNXNoWHh0enM2UFplTm1Pakk4bGlhZyszN0RoQmtT?=
 =?utf-8?Q?u0Xg=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0f9a5f-bb01-4961-5cce-08de163aea75
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:59:03.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnikrYGFGU4q+26fMHVT0c3aw7TdHqGmGKB5e7c4uDrKQ6IlgVxPQIpC7cO1jrWv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4049
X-Authority-Analysis: v=2.4 cv=Dp1bOW/+ c=1 sm=1 tr=0 ts=6900e849 cx=c_pps
 a=hjCSP9ZXGz/ZSNNiZYHiPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zVkyJDCJO4fTJCsB6y8A:9
 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: GKX8zOHdSV00Bm5wqSi5ksfFbtnrgzqd
X-Proofpoint-GUID: GKX8zOHdSV00Bm5wqSi5ksfFbtnrgzqd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEzNSBTYWx0ZWRfX7U85ahkf8VYB
 NfBwDK6cambTyYjUDBcU+M9WNKaUtA2LYYDKIkWibTGtBxGT9u9U0jpRRQrgpABGDWQhvJVyMF/
 JChetuXo23h3nHHYw4pcZbeNJetslxE/UIrRFHG2FWBkXVi5c2eRZAiUvanhgghmU0Ted1/Elbz
 ArtN6myRuvtFAATXKtQluZiPMBpa9lxnuSAWPLGiSR3QY55HDn6isdSQTR+Qt8ZthAWMXW1xxnU
 XYtGoLIsSo7AJTn2OpUQnEZ+kq8lr4LFyP/3rXP1yellNEvXCgwhdiICdkD92x+BOvdQBl4Hza0
 18OH1xqlxC5heom8Ku7WVIHx6hmUTgy6Bu3VPIP36n8o3ItQuj2xpDqPoQlqA0MM3zXu+5AFXmS
 DkEwjqNbvZdkgE0isLN6jJM1Xk8U6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01

On 10/27/25 7:48 PM, bot+bpf-ci@kernel.org wrote:
>> @@ -1350,11 +1367,14 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
>>   * Returns a negative value if an error occurred.
>>   */
>>  __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
>> -				  int order, u64 flags)
>> +				  int order, u64 flags,
>> +				  const char *constraint_text__nullable)
>>  {
>>  	struct oom_control oc = {
>>  		.memcg = memcg__nullable,
>>  		.order = order,
>> +		.constraint = CONSTRAINT_BPF,
>> +		.bpf_constraint = constraint_text__nullable,
>>  	};
>>  	int ret;
> 
> When CONSTRAINT_BPF is set in bpf_out_of_memory(), the early return in
> constrained_alloc() prevents oc->totalpages from being initialized.  This
> leaves totalpages at zero (from the designated initializer).
> 
> Later in the call chain out_of_memory()->select_bad_process()->
> oom_evaluate_task()->oom_badness(), the code performs division by
> totalpages at line 237:
> 
>     adj *= totalpages / 1000;
> 
> Can this cause a division by zero?  The path is reachable when a BPF
> program calls bpf_out_of_memory() and either no BPF OOM handler is
> registered or the handler fails to free memory, causing execution to fall
> through to select_bad_process().

Looks like the AI got a little excited about finding the uninit variable
chain and forgot what dividing by zero really means.  I'll add a false
positive check for this.

-chris

