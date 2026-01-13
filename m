Return-Path: <cgroups+bounces-13120-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1880D16992
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 05:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BAF5302AE0E
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0034F48E;
	Tue, 13 Jan 2026 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JRwxi2i7"
X-Original-To: cgroups@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408C34F253;
	Tue, 13 Jan 2026 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768277557; cv=fail; b=AX1zf8wD5cXU53dMYsOcsbhzIghPvTwhR9LLrEvXp98n7HsdD/XbPO/qWgf/cjBBKzbFJbS3isE8eGfawkCCuJF2Q+uIU/D5MNYjPQogGjBK6HGKMDy/IhMiW+hiJG4TMqzRRItrxn8I52wIw/X2HY2xm++54du/lHP+ZFYy4sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768277557; c=relaxed/simple;
	bh=WE8TDkY/rC8WJBSIpblX5a1CaG7TSCJ1QnLlu4hPnOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LBZz2i7B2JVI3woqkL1KvVtrL+PJC6lmzIg72qGV9IrJRNNBRKQtRBwM1hKa/p3VGs+45F18F0GdE9gQvKPKs0Rtv36V54riTm2ECHUuPZzqAJeu25pi4CjKZEBJOOwsyjNQAHxbMNKBd6lrs5eBLERIILgsMUZSBFm7NNoW5IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JRwxi2i7; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX1Y+5AYzcUV7RL9Xmvp7XF5qMnapz9ceZGRUo+tYDobLdUy/7UOEY+/nPSGIM+o0vy0IErzmkz5f0wglUFtM0aSirEC/+Ravs9Eu5inTg/q8gq34a8NcC05fOZwUYA6d9e5UEwOTKvq9cr53T0Vn5htf7vC9hZEOTXwv5KEWGw7kYWnipXCfTraOZST+jx32NmZtLs4+HiBFQQ4VgkVs4AXIplA/Mu/AEjWne8VzJJ3ORkjK+EctxOV9E6u2XP1GbnMruJ7NK6jOzKLTxRDBbqjhwhjcBAqhKfgfbTF+fHIV4nHJZ5gzuroAzZroCrCcdJSwS/0tQTM4bShdrfUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCa8vtqPMoHScms9Vj5pQN9KXAR7Eegxc0Dm58jbcuI=;
 b=p1i6ZGMoxgI/FDq7b5tevuyPDDFShPAioXjHdOcMcFoDgh9hBLPmS6qbhjjM2mV9b1931BCtkNPhU4B493eIrUMcS+hVOe7j4OHnoj9Z9xss4xx+Pve6IBBh1aI06WPn5h9mY7hWSzvljFOLrfMvIM2Eb1NQAeJ6sZz3Ne71gcgVS/kwxKAbbt/mrwHyKXtHDCW7U0d22LUlWlove411eGFsMh/LBZUzPX/YHBlP/ElfuSIhf8ekPM4BDJHZo2g0aZ+WOlIuS3keENpgngCS7JHzeAfe2cxEveVrYMM4tXsX3TFCNt5T8R9nxbzmItpiinqVPa/7BJWTKHps1BPwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCa8vtqPMoHScms9Vj5pQN9KXAR7Eegxc0Dm58jbcuI=;
 b=JRwxi2i7M19Fiwa3jEw2tVrqQ1MSnLN7CJ4Wi7vjEyuTPTaZBXcm34HuZUyDQ/kuhWSeLJiR1dNpCZZifEd2EI7mTxqTV92mJPb0vAs9ymn6pBGAxPD6ss0paVTnpZ6s2jqcZ4gPdLMq4PkP+s2ldmEcnCyfBf56bep6nkKHVwk=
Received: from DS7PR03CA0058.namprd03.prod.outlook.com (2603:10b6:5:3b5::33)
 by LV2PR12MB999074.namprd12.prod.outlook.com (2603:10b6:408:351::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 04:12:33 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::b1) by DS7PR03CA0058.outlook.office365.com
 (2603:10b6:5:3b5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 04:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 04:12:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 22:12:32 -0600
Received: from [10.136.46.14] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 12 Jan 2026 22:12:26 -0600
Message-ID: <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
Date: Tue, 13 Jan 2026 09:42:25 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
To: Pierre Gondois <pierre.gondois@arm.com>, Peter Zijlstra
	<peterz@infradead.org>, <tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <mingo@kernel.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <longman@redhat.com>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <cgroups@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <liuwenfang@honor.com>, <tglx@linutronix.de>,
	Christian Loehle <christian.loehle@arm.com>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|LV2PR12MB999074:EE_
X-MS-Office365-Filtering-Correlation-Id: 33dd4a47-553c-4312-1e1b-08de5259f9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkZZWFpSdU9FY0NPaDIvMExWUVJIWlgwejM4QTFlYncxRm03dEhncmhCZW9B?=
 =?utf-8?B?NDJ5MW5aUFBBVzM3Szl5V1RYeXh0aVJJcHV5eFFDTXFGOWpLZ1Y0Qmx5ay9W?=
 =?utf-8?B?QzNkWE04Z2cvUmpxQlkwSlMxRGw2UHg4Q25mbUFxWmN6NnhkNE5KdFlVdzdC?=
 =?utf-8?B?MGZiblRWV3dmaStvR0hXRzlTTVk3aVJqUlhVdXRNRU5MNXdiYUdiRkEvNUN4?=
 =?utf-8?B?WWkrMDdkUlZ4T3N4a29RRkU2S094LzNqbUR4ajI0R3I4bUxhSE1aRGRrSDZp?=
 =?utf-8?B?ZzhWN0owSHpEQ3RPUUNmazFIeWRWbGdLTDJxZW5CUzhQZGU3ZXdzUDRDTWxX?=
 =?utf-8?B?VSszUEJweEE5WVkwTXVKbzRQZERLNW9BYlZhRDhxOGZpazZtb2l0TFV3Y3Z1?=
 =?utf-8?B?OTF0ak8zTW83bTZrd3Fsall6aEswS3AyaWE2SXlPRDJoalZmNkNKdWRmMmEx?=
 =?utf-8?B?OHMxeGN5S3B0cE1DNnlHWnozRHlBT0NRUWJ3aEFmeVJXRW1EelFveDgvaGJJ?=
 =?utf-8?B?TzlGUk1QaDJHSW1BbkRnWUNrcFFjVERtaENhQ3pWeDV3czRaR0RmRjhMUlZv?=
 =?utf-8?B?SmhRYUQ1Ulg5NUFJNHRtZ1VZdFZUbEg4aUpiTE9NdnVNTUJvdS9paW91NDlP?=
 =?utf-8?B?TG5wZ2FaTTBlRjFmY09wY2dsdkZGL3Z0WDVRNlpLVmQ1bnlxN1FhYld5R3dh?=
 =?utf-8?B?MTE0U1FvNmg1Z0pmZXl5dTdqMjZNZUhxdkZzY000dUhZY05PaGk3emlKYm9Q?=
 =?utf-8?B?b3FRUkpGSFdYRm51eXBkWjdESVRjYTRIWk5zVmJjR2ErRlJKV2tsY203RnZn?=
 =?utf-8?B?SVd0anpTS1dHdlFYdWtKNEpjZHpxTkEzNm9RYWtvT09uZVdZcHQybVZSV1FN?=
 =?utf-8?B?YTBXOEdKN0duaDlrenFJeG5BVFBDbmRCTVZhTkt6OVBkUlIzeFZlTm55S01j?=
 =?utf-8?B?dDhmUXQrbmtsUWdCL21ncWFOZlhna0FSMG41RWxIZUxLdjh5ZHA1K3hRLy9Q?=
 =?utf-8?B?cjlDeVN3eWJoVWx3K1ZMMjM3aThlVnVDd2wxVTBiMHZsOEdZQ3M0RXgzbGZr?=
 =?utf-8?B?OWo1QXNsVlE1dHI2ODNEdWg2bitMWjRDZHd0dDJNNDc4Z2FJUFJPZ0REdUZm?=
 =?utf-8?B?enN6Ky9JRmw3QjBNMks3QTAyVDNySGFEK3h6M2UxNXhOUWR0SzljeDZ3c3JI?=
 =?utf-8?B?TzFqMDVFeDRRbk5GdlRQelpFTnJrYWNKQUFSc2FxSTJ6Q0JNZVdZdDNDWUdJ?=
 =?utf-8?B?RVFpRWlpTDRUQnYxcE1FMG9iRDJTME4zMFNpdmVLeW4yS1ROOXBWcHZ0Mzln?=
 =?utf-8?B?bFRhMGI2NXhRUFJYTC90U0JuZnNqeE82Vy9vNldOMXZyYTJOcHBOOGpDREpv?=
 =?utf-8?B?ZkJ3a2tWQk1GWHQrVy9LT0JwVmM0Z3Z1YmRZSVlUWFJjNTd1d2tsRjFoaUdh?=
 =?utf-8?B?RkQ3NTAyVS95QjBXd2llYzF2Z3B0QWRXTnpaR0xSQXgzVUVPaDJydEJOOXlz?=
 =?utf-8?B?U2VpYS9FNDlPZVR0bVFqWTY0RHVWd21zdFB1OWQ3QzZUSlU3ODZpY2U5Y2x1?=
 =?utf-8?B?Und3UlVISVdOMUI5NDRUTFpkZllHSStCMDRqb3k1RWpmUjVoTGFwNGhEQmtv?=
 =?utf-8?B?eG9xZ0pEUEdHT0tiNlE2WGFDSGx4NEZFWjQ1VEZHRmIwM0g0UnZpMGhnRGNE?=
 =?utf-8?B?M1ozOUQ0R2NzZFdoS0U5Vzd1SnBlTit2eW9nbmRTUGprSzZJeHUzejJ1MVNZ?=
 =?utf-8?B?TTFacVgzSGtXNzVqR3hGckZDRC9CbTJNTXdPMlhiSndJYjg5N3IvaVFnQm5J?=
 =?utf-8?B?azZWK2FITGtuN0FvWVRscE9tNjRWK3dNVXVFMFNFZnB2dkZwKzlYWG92eFpt?=
 =?utf-8?B?Wi9ZbndUc004TlRhaXpFdlE5SGZTV1NYU3JkREdCNE9IR3VDdlBJTVhJTG1X?=
 =?utf-8?B?RlpPdDJHQkg0ZDFSK3NiMmZROXFzMDhkcjZKcm9sTUJkdVkxaWJWR0k4ZmY2?=
 =?utf-8?B?OGUxV2MwaGpmcXhCMnBnZFFIWG9aZ05JcXZCcGVsOXc1TVE1UUswdm9GckNp?=
 =?utf-8?B?T2p5QXV5RVJ2Qm45WW5Na3ZnVk1zOTBtRWtuYVU1YWxiYURRekNVaG5nWk0r?=
 =?utf-8?Q?zM9k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 04:12:32.9157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dd4a47-553c-4312-1e1b-08de5259f9cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999074

Hello Pierre,

On 1/13/2026 2:14 AM, Pierre Gondois wrote:
> Hello Peter,
> 
> It seems this patch:
> 6455ad5346c9 ("sched: Move sched_class::prio_changed() into the change pattern")
> is triggering the following warning:
> rq_pin_lock()
> \-WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);

Can you check if the following solution helps your case too:
https://lore.kernel.org/all/20260106104113.GX3707891@noisy.programming.kicks-ass.net/

-- 
Thanks and Regards,
Prateek



