Return-Path: <cgroups+bounces-9990-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712E8B52EB6
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 12:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C933B8F80
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F242E7BAD;
	Thu, 11 Sep 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qVqPpvt2"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3712206A9;
	Thu, 11 Sep 2025 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587079; cv=fail; b=NrDpUcAN1smnxWHHrjrBL6EvDb6Crmv5g6l9reUgpz6wUtZSxgfXGfnHbnU2XHylRSuUIqqjQuTtpvK+JlsDPBTOWcl5hfJaIyV02x3Yf8kVkYwyecvF/yZcHEEOoGZ/XNu8pX9crxdjAXyFV6hK1iHUidYlFXWZ/eiX7OS4/tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587079; c=relaxed/simple;
	bh=BLO2hZrQsjITBD7Im2+Vv0sRraoHSBiStI5Y0gwenCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XfmQDR/xlUdDkOLaxOQuXJLWWcZ5jRYyJOa7woFkMppPYQ9okb3X51pvIU5UihRjvo/+ap1QPLJOXMPdS3rKkKk72fDTcUOuSSoePWHQFAbTVVx+efYPMcxdJ79oMmQbRcV3hZVCaPLwzDUXPBDfGxLY17kyem+vzcYJcxSGhQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qVqPpvt2; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWwRHFOHAQUCKzXBPfy3pfyIHNcUIBmGZM8OF4PKiGN6QImE1EftRC1Zalv0BZD9oKl4i1pghar/wvur3wQjder1XR3a149jBCDr9RNc5Hdta1t7LA+hUIf1ptDP++RDNAljHk925ndciwoBv/zoeu7J9bAVD5pd5ASihB59ppVSq542Do+dFgQnnByI1pR6U5wbwPYFKBkyadJgagHHC5mXiSeAfbRQOWlb6BAsa+RutlLHsJ4y9MzBntMpCECRTFZuxWe/rkUbRCxP0g9SvOg0jaKdpnU8MblnO7n810UwWukZ68p/Va98D+S/jb4H40bGp1Tnbvx95OpeCcH9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBr2zny4dhn8r/trGVFxdoLSX2rKE4JZze3sqr3bUE0=;
 b=JoQuQYdcAE3MKIrudjPC7Ein76FGsmx3vbEFhpiLQh9u+NFfUhovf+MxATJV4ZqjrIdxSCZpRO1N0IbAJ2BE98/2qv5TyoGBpPR9tVNktNVxkAqaO2OzUZ4FLh3yGKhxrNaFRhEOg1OCzRtP3hL+osID2hXuHAiSdR2WCaLV4JiiNJSxkRb0eaTxsROCuxNzmBP5l/1y4K0OZA3YkzZtbY+N6eWOotm6h0t7FeHj/vaWowYIHgxvfznnjN9f7KkCGMeJVqXDg83hq/bQQvnVxOaXn8AelBrz243LCGy0+F3ue+4yhK39+8nZPIaQ8IBbxso3Z7LdW4BzADvNJKMVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBr2zny4dhn8r/trGVFxdoLSX2rKE4JZze3sqr3bUE0=;
 b=qVqPpvt216Gwm6VuioP5gOVvNBwxkSpFVixen1FyuPRVMF3B76OAYnVIulDj5IyCRYHsg3KMs5pKGVHlJTswMXh4oJ6GfyystbjBBlTyA/fZl7vg+rew0v/PLiUo7gYfzSH+qfnA6p0NT5QsyGvuS6kflAgb31IurdrQ5QgoEoo=
Received: from MN2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:208:120::28)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 10:37:55 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::e4) by MN2PR10CA0015.outlook.office365.com
 (2603:10b6:208:120::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 10:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 10:37:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 11 Sep
 2025 03:37:55 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Sep
 2025 05:37:54 -0500
Received: from [172.31.178.191] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 03:37:47 -0700
Message-ID: <cdca0902-f6a6-406f-a52a-1172c02f442a@amd.com>
Date: Thu, 11 Sep 2025 16:07:46 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] sched: Employ sched_change guards
To: Peter Zijlstra <peterz@infradead.org>
CC: <tj@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <longman@redhat.com>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <cgroups@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <liuwenfang@honor.com>, <tglx@linutronix.de>
References: <20250910154409.446470175@infradead.org>
 <20250910155808.415580225@infradead.org>
 <c4955d95-8d23-49da-9214-da481f28f797@amd.com>
 <20250911095523.GX3289052@noisy.programming.kicks-ass.net>
 <20250911101008.GD1386988@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250911101008.GD1386988@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f95efb-c056-43ab-4da9-08ddf11f449a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wnk0VDN2N0RTQXJGNlBvNCtpNE1yZTZoMHd2eSs4bWNGcXlHWDgyTEdMTTBD?=
 =?utf-8?B?VUlPS1JHRjB6NDNFbDhDRUhhRXJSTVYvM3dWMU9KOUM5YlpsSXFKTTlRTVJx?=
 =?utf-8?B?WmlxZ25kTytWVDE4UEM2RGpBUzEyckpBZ1Fxa3NkNG0zaHJKRVRPVHZ0R01l?=
 =?utf-8?B?L1ZReFFac0dQYVVCbUxCWFNLMWl2WkdieDkxQ3ErNGF6bE5yV3VLcDN6TEdI?=
 =?utf-8?B?cnozL1MxYVZjMGM3WUlCRlp5VmFhZ0svR28xWEhRWXVOY09jSnNXTjltSlBa?=
 =?utf-8?B?NDFrdklQMHE0NWtsbUpDNUltWjBuM255UzA3emIvakhnWldQY3RIcDBHMmR5?=
 =?utf-8?B?bHVQbFZmS2FUY2VIeTJHMkdqT3hJSm1Va1c1WTdUM0dzRis4WW02NHFodGRl?=
 =?utf-8?B?dU1kZVAzbnc1emN4dGlSMnBmeWk4cTVWZ0k4ekVPTng4RU50TlA5SXNtMk9k?=
 =?utf-8?B?QmtKZTI5d0QvZ0VwUEwzRktac3NVeHBRN0hwSVdaWm1ENmZtK1Q4Q2Nrb3Ry?=
 =?utf-8?B?Y3FNSWgwckMycDNsazhyUUFkbzNCbVpQb0NFN1NUMU5NNHEwby9FZTlJNFJt?=
 =?utf-8?B?bmpXemtvVC9WUThha1MycERqZDlOVDdQTFQrdnQ1dXJlWGErcUgwN1BCbXJx?=
 =?utf-8?B?ZjNRMUZqYUJSSG9Ob0dtUE5od2FDUW1BMThSOGFmZEFqSVZ4RnM3M21FeHIr?=
 =?utf-8?B?NXh3NGNyT3huL2hQKys2cCtrYVhvS3A2N2Fya1Q5a01iSFU2bnBwSUlXSDhS?=
 =?utf-8?B?Z2xIbzl6cU9FdWlNSC8zd2xmRjA5SVBPRm9PK0tHU0xsRVl4R1ZHRDkwUjky?=
 =?utf-8?B?MzA4cU9OcTBGVEdTY1ZNYXVlL0NsWHJydld3NFBvbFdzRGhLYU5kQ3RCMEZo?=
 =?utf-8?B?MFUzb3ZPTVNxRHZkdDBWU0FOQ2F3cmV1OUhVeG53M0hLZUZncVpSa0xsWHhW?=
 =?utf-8?B?c09rd3RmNXRvNXRQVGRURFB1SXliRW9kbFhDWXNtZVJZcG8vTVdYKzREN29I?=
 =?utf-8?B?Z3NIdHlVQW9wUWNHMUJqZkxZRGZsR2xENTd6U3VBdUNYcE5lM0ZuMWZDY1g5?=
 =?utf-8?B?Rld6c25BNzM2T0pLaFArYjl4QUVSNk1TOWM2bXFOUWhXTFJnVHJGSFY2SnhP?=
 =?utf-8?B?SXJaMmtSTlQ5ekpWQkdNQnNURjU5d3U3SDBPdWV5eVdHRURLSm96N2ZLV05s?=
 =?utf-8?B?aHM4Nml3MG8rTTZHL0lya1FGMzhyNE5HT2RFUzg0bitHWVdKRkJNbCtaS3M4?=
 =?utf-8?B?bHRGeDRjQUVUNnlnYUZDcUtDU0NsMUZVeERJbGM2WmxYeGdiY0NpQ1dLNFF3?=
 =?utf-8?B?MGFCNy9NdW1UazY2S1lPdmphbjgxclRTY1JZSG1BTmVmQU1nMVZhcDM1V3da?=
 =?utf-8?B?bGdPMk1sb3MzdUtOcTczRlY2MXczZXZ4WHlReVZWUzFrSlNNdmRyYWl6cDNo?=
 =?utf-8?B?dzJWQzExZXN1ZGcvLzQrNmJIdnFXa3BWdHZ3c1NMMUVCZktUOEdZUkgraFFv?=
 =?utf-8?B?MmJ3WXR2eUFYcHVuTnVVSkRqdEFQd1QwbUdSMk1vcE1Ec3ljZGNOSzBqUHRL?=
 =?utf-8?B?SVF1ZGpMNHp0V2JBZnhKNE9TcjRTc3FqZEEwb1VVdkRHdVZxaHlHUDFnWm1J?=
 =?utf-8?B?d0lrVk1VYndyNk9ZMmxvY25TaU84WFJyYVo4NTI4ZVdPN0ZrRURPY0ZLS0tj?=
 =?utf-8?B?NmoxaWVXQnhad2ZweE5NL3lXRUdyRUZ0TER5VG9ZenZxUHZ5K052NnpiZTlz?=
 =?utf-8?B?SXQ1NWdCVDFHZzYvQVBEdk5kZnJLRHlDTG1PeE9kVlp6ajNqR2RCaHVaUWx4?=
 =?utf-8?B?blVwQm5jZ2dzNVJQYmZhWTU3Mnd2UUtpTFFpc1dUb291M3JxbVVKU1lGaVEr?=
 =?utf-8?B?TFNORXNXNWF4RjRDR2NtMmF4ekI3dDJwRTRrVkp1SGMzdzdwSUpuamxoT0pK?=
 =?utf-8?B?a1d3TjFRQUV5T0ptYWxsWm1FTHZxbGNQdG14RHlCd0tIa2NwUzBWVlBrbEZX?=
 =?utf-8?B?clRMeTdwekJENmR1cm9DTzhCNGFvMzhCWnNxOENQdm5OR09JdDVPemZnUUdr?=
 =?utf-8?Q?Mr/Zbj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:37:55.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f95efb-c056-43ab-4da9-08ddf11f449a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007

Hello Peter,

On 9/11/2025 3:40 PM, Peter Zijlstra wrote:
>> Yeah, I suppose we could. But let me try and do that in a later patch,
>> on-top of all this.

Sure thing.

> 
> Something like so?

Yup! That whole lot look better. Thank you.

> 
>  [..snip..]
-- 
Thanks and Regards,
Prateek


