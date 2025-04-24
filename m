Return-Path: <cgroups+bounces-7780-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F6A99E66
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 03:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075CF5A5690
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68EB1C863D;
	Thu, 24 Apr 2025 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NmlcTRqq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K2Vq9DKA"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31AD2701C3;
	Thu, 24 Apr 2025 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458941; cv=fail; b=ROx2Ym6DHe678s6eU38o1tBQBlPAvfaDThsmxq1I2BSdIfE8QGKXrtIzhhE8oQjg6uwksKEcpnt86a7RZhNT5RdWEpWqFM1XgfgcQwtlZHMhEGnoZ9jIUx4SUYgbbHkO/dm03siGQnFZL+WUGmuDO2fYplSBjNp0zC5qzBxMFr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458941; c=relaxed/simple;
	bh=wNsfffhEKteh1WAnnirsmPGBn3Ru+BI4S2bJCeYlpLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuekVnNIadLFiLBNKTzSyG25ZF1SXKhMGg6ncVv6HnDIfnu3wpyW9cHDA2bEg0RkvDCitO92DL/Gd68KSRE1+JD5v6Q87KdDQIc1pRQl/b/Ei8D8Oksm8dusV2YNQ1jwZXGHjsHSQSoBXVjsXTSVgR3ovo/KTyhckX13JQKpyWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NmlcTRqq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K2Vq9DKA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLNAvl018143;
	Thu, 24 Apr 2025 01:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KQvchsSMcKwL9MJKXNZma9e01YtQn7vHyfiey/0tiSE=; b=
	NmlcTRqqoAfDckDk1TcNCJbaDDiCGdn1+8a1qIQvkpMM6eG4TjrIcX/eHv3bIrTt
	EXCtOxGSHFfM8zDjgD4YX0pY4w+uXomBl458Gx/SYvD+9L70W7M6adkFQh+KyHHZ
	/Vdkg7quGbymz4V7CGf6QvW1e5a5vifpfvBCP64TXmVmfDIdgTRAV++U0oEa9gXo
	6z+Eg99iuAuv8EBfH8xvJxQG5hMCzZt7dh+8YLzdfagtze/XfdHDg7lrYyMx2TAB
	pbmiGTwbiMPqJVfxW32x3Pe+ZlGriCs8Zp4g2UxGlItBUWhONutTen6BsbZM21Do
	dQpwtJny+QbDSQWDzZloSQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jkjjvrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 01:41:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0KgNP028462;
	Thu, 24 Apr 2025 01:41:54 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx6wp3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 01:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDZjW4GiH6mx25k8U6EaoZ1fyr3wJdHIgmWYurj0WMAVdkUr+x6BxcUoTrBQQTLTOCwqtVrjVhtHqsuNsUthmqYhpm6x2EI0Gnby0/gjVz6qy049ihWLk19On3vdXmGTxw+WAaF7pIwEfVC0G0y1G6jgkPSdU8uyP4hnbWGlQQD+arZI1v6GVaOeUvKCq0vtwRVprl2KCmLFz9+wUDU86d4JhpvRkVMGurFDpaAmDurhlssM3hmmlxBYjcL2grQzueEh8bt9aCqJNRFgv15F/G3J1KbW8JlgOkdd5w7wLsLoFS+Wz9az4PiHhc5rT/YFGYG7ChEhgQRWkM+pQnSn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQvchsSMcKwL9MJKXNZma9e01YtQn7vHyfiey/0tiSE=;
 b=S/WFbEOyEdcqaJtLdS0JurIWbAFPDtd8T3JqnAfCeP5ITvHVdfoQkcGSvJpoGPLEAeXwH9lPMlACPiwioUROqTUE9focELwVU3H2/BqUVPXYiOk417B2rG4vcEWnp3oYv92y7M90jNik8fKDhEhCgek0m/0BxEv2BjHTVR32Wz6zpdr/FGiZDxw+RI9uwv0MVob17RpjdZDZ+xUqib9LqXTDncCN1YnHuwfbOzKVQC1ex+pDoAvXXDU51T/dCtmEM1pTyZkQ1eIFWg5HuDTF4mbv1KGcZE0jDf8oWqzDw+fC3uJx43QpauPUrwoNHKyh/L+jJ2niPwNZvlU7mYzh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQvchsSMcKwL9MJKXNZma9e01YtQn7vHyfiey/0tiSE=;
 b=K2Vq9DKAep6A1urQ/WXavNiA5M3TEC1IoSHfrXQ/4GNe4egFA/hpOUV7mR+zMmNNvCt0PHQEhS4tqtJg4iPo+9eAbCmSijmUn4VJKyyeKEiYIX/8bwdcyfjI2nn5MCst3/C+dVq6RlUN5HMxoT78RwLYD+HCR7CLIW5fGmuNeeM=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by SJ0PR10MB4734.namprd10.prod.outlook.com (2603:10b6:a03:2d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 24 Apr
 2025 01:41:51 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 01:41:51 +0000
Message-ID: <c90ee040-4d2c-4f52-badf-0ad9127e61c3@oracle.com>
Date: Wed, 23 Apr 2025 18:41:48 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v4 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, peterz@infradead.org, mgorman@suse.de,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        tj@kernel.org, llong@redhat.com, sraithal@amd.com,
        venkat88@linux.ibm.com, kprateek.nayak@amd.com, raghavendra.kt@amd.com,
        yu.c.chen@intel.com, tim.c.chen@intel.com, vineethr@linux.ibm.com,
        chris.hyser@oracle.com, daniel.m.jordan@oracle.com,
        lorenzo.stoakes@oracle.com, mkoutny@suse.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250424000146.1197285-1-libo.chen@oracle.com>
 <20250424000146.1197285-3-libo.chen@oracle.com>
 <20250423201829.17d4c382@gandalf.local.home>
 <d3a458d0-5f39-4374-957e-a2a3edf4983a@oracle.com>
 <20250423210108.5b2452ad@gandalf.local.home>
 <752119fe-b5fc-473e-8968-0b4a5ef34d3b@oracle.com>
 <20250423213343.6c5dd621@gandalf.local.home>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250423213343.6c5dd621@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:510:23c::26) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|SJ0PR10MB4734:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fbff2f-17ce-495b-ae7e-08dd82d12f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEUvT3d3dExGN2RBMHU1WXpSc2h5ZjkzdTBkclozajVwYjlIWnp4RFB3dXB0?=
 =?utf-8?B?eURrZTFWdnZkaWNBQXZTM01WdytLeVRHR2xQUU9ab3hCRW12R0hOQnhzWmxU?=
 =?utf-8?B?QTdKWjJMZ3hqTHNCV0s0M2djSzVyNWU3MGxXL1BHczRmTDcweDZFcStUSnJY?=
 =?utf-8?B?elV3VVRrRXRzMkZKbmNTNWF1WElCR2RHYTZMT3VNOXdBaFZzTkpLVWw3ejl6?=
 =?utf-8?B?T1JUSDErdlNrdmZOQ0NPRS90YXFZR0JpdFNzSk9ZalBYQUwreExrUXZ1MmF1?=
 =?utf-8?B?UWsyUXFuNGFwQ2YzL29FT2laWnAvREdCU2x5MEk5VDVGS0ZVclVLL0NtaTNy?=
 =?utf-8?B?b1daUC8wNjFtdEIzRzVIVVZZZTZrdkl0U3VvRVl4YmlDdVRUR2VUYWhINXQv?=
 =?utf-8?B?d1cxRjY4ZVExcnptN2tEL1B0WFQvVlNLM29hVUpCMEpoUGV5UVpUN1pUSWpl?=
 =?utf-8?B?dERULzQ4ckRna0tXSWF6UEhnaWF3bWVhaTJTMnk5Ym5vS21Rd3YvWlhWRytR?=
 =?utf-8?B?ZTZ0S3pZL2o2UFBxWmtMOFdTRTFRTHIvc3JUR0N6TkZaTFU3OUtmTFpLc1di?=
 =?utf-8?B?WmdDaWNxYVB1TkJyMHlwUmI0R1JMdmM0emtKdUVobHFITXdiZCt3eUFGR0lu?=
 =?utf-8?B?ZmtvUXVob0ZZMVZBMGhzby8rQm54VzRMb0Flc0FFNmwwSUpNWHYwaExRT0Fv?=
 =?utf-8?B?bGdwZHZ4K3JjZitpL1lFS0hXYWozT2g0ZVc1S2IzYWpXSGhQbXRjVTZ3YThl?=
 =?utf-8?B?N09OMDZva3hxRGxwZ0Y2MXFVYlE2U1BKb0FQclo1V2Z3aXAwaTB6Wm5YQXpE?=
 =?utf-8?B?VnlvZDRHQjZkQi9sQkh2WGFOckcyb1hBQ1hyejIrYmUvQ3dEcHlvWlFtQjNF?=
 =?utf-8?B?SlZ0Uko4MGNxTTZ6L1R6dm9mOHYyWThzeXZ6MFh6MjVoeWZtbk1sL1Rvd0gr?=
 =?utf-8?B?NFRhUzZmdjFwWTVyNHQvRzJZcTN1TytYY2RvWGVYdUUzUktSL0gzTW8rVzZR?=
 =?utf-8?B?anJteWhuRzVSOFJkS0pKY3VrdEZGMG9PMGdnajkybGU2RSszM3pMNTE4Zm5k?=
 =?utf-8?B?NnpMUFhHYUlQOHFyc0VNYUtEcmxRZjJVMHJ0dm1qNG0wTWtRWlVwYUg2WGw0?=
 =?utf-8?B?dnpwdzZSekpXem4zd0UxSlIzVTY3V0hCbTN1OUJjeXhsNEwyV1ZlREFrZ3dD?=
 =?utf-8?B?Q2tEdlc3YjRTa093YVBsTHZ2WkNndkpkTC9mdTN3OFlON2tRSXFSSEhkQ2o0?=
 =?utf-8?B?MitETDBHbzlGMVExNk1Ob1FHR0Z0VDRCT3BVaTVXcWlHK3VpNFpxSStBZTFS?=
 =?utf-8?B?eXd4UnY3WmFCcHVLamtwZ1VCTlZrRzdUT1lGbTduYkhOeEFUeFIxYU0rVUlK?=
 =?utf-8?B?VzdMSHhjOGtucVBSSUx4R2dEWHdITSs1dk5qRmRwK3VPNHFmdWNycVErVWIy?=
 =?utf-8?B?eVlqa3VucE5DT0V5bmd4aXM1aDRnY3hhSzRIb1h5dkVUZDIwMG15WHhNWUNR?=
 =?utf-8?B?clAwVzhPUm1pcUQwTHVnZDBiMlVqZko2QTRNNXJocUFhR0wwR1N5REZva25p?=
 =?utf-8?B?bVZURlZhb2pWOUd2Rk1qMmh2dTRGaitEUGJycTVLZ3Z1eXh2UWlSemQ2dUhV?=
 =?utf-8?B?eWI4NGdqckwzTG56blNoWFZIeGEzZGVQZ3NORERqbGh6V2NoTmFZTEZjbkRZ?=
 =?utf-8?B?UVdyOEVUWjA0d3pWWlE0bHQ3Q0tGSVkwWWNROG1leVB5RFZFcU1FV0NDS3BF?=
 =?utf-8?B?aGs3L1VXMGtFMDdyL2NVY2E4TTFqZUdyN3ZZQkVSTTVlaEtuSXprUk1DUUZv?=
 =?utf-8?B?Yk1DMzhkdGNod3htREdpWVVkdllCWjhGcHFBVk8zOVpLaEtuZmRsdnk5M1RH?=
 =?utf-8?B?WE1WMFh0UXY0WncycUFPbitsK2svblh1VEpDWVB2U014MS9GV3pwQjNNNEt0?=
 =?utf-8?Q?/bufG1F56yA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3BEOU1BcXArYWVBSVh6Z29yQjFKdlRlSHU1VW1Wek5TK1lmNlBpMWgyeEhp?=
 =?utf-8?B?VC9CVlFDT3pYWUV5azQ5VDZ4cXVPckkyc1Q4bENOYzdGSmIvMTVVRFVOTUpl?=
 =?utf-8?B?L3NTZVlvNzRVS29xTGhicFhtTFdkYWxSQ2R1U2NqU24wTlpZV0RXdU1wSGlk?=
 =?utf-8?B?TFJJNzltRm1TWDF6dTBKU29Ld29yZXpCc3Bac0VUN3pOMTBEK1oyUk9BbG9t?=
 =?utf-8?B?L0xZRmx1RzhzQ1NQcm1DbXgzNDE0UVNHREFhTlFNeEpjem1KL1RVMkorWnpo?=
 =?utf-8?B?MGcrNnRqbThWQWZxSzdXR1VabHdWcGpjQ0VyRENaakx4bWRIaDVYcEt1RkZU?=
 =?utf-8?B?Q3BrVUxsTzV4TUFKTVhMRUNTNWs2ZjA0WWpWZ0F4THpXaHpmWnQ4YkFkS0pP?=
 =?utf-8?B?ZG5SSnpkcGVjWmxDZGI4d1M3RXRxZ2YzMSs5emYydTlCTGYySkNYaksxUlZG?=
 =?utf-8?B?UDZqdjFmNzVIeFZUTHpkOE5wZW9BdlpaUXVPZ2h6VW9GMTlLQXZYS2FMenlS?=
 =?utf-8?B?VnJMU1NzQndHTm40QzRyb0lqQ1VMSm9RZEsxUUFIdnBhUDREMERLUnYrcXAx?=
 =?utf-8?B?UHltajBhc0xHektOL2RrS2c2bVg5MVZQM2xJcnk0TGttNHduNjljM1l2dnda?=
 =?utf-8?B?ZW9hRHNaamh0SThORGcyVWlJQVYweWszMHJaRjBIQnJEVk5rUlV0bjZtbUZZ?=
 =?utf-8?B?c0ZkcWhhUDRpdnF5WXhQem54TzZmcFM3RWZwMUp6N01ZNXpRMWFZNmMvaGNW?=
 =?utf-8?B?U1R4WU5yRE5sQ2ZjSWdIQmdQQ1lvb2JTRUptdThkWW1wb1ZnL3BQRU1xZUps?=
 =?utf-8?B?bkxYYk53UUs1UEZ3dm1IMEs4TTN2a3RKOE9UNEE3ekQ5WEZiV0xuS3g3VmtY?=
 =?utf-8?B?eVpmS3Q0VWFWeEpsYWJFZFAxcC9KWlBJZUYrTE1GSDQ1MTBLTDR1aExNUVpZ?=
 =?utf-8?B?R3lFbXMzM2UwbENMWnpVSlcra2crSHJJRjZmWHE5WFEvT0VjTzNWS01IV0t6?=
 =?utf-8?B?YzZvYk1RYTJYN1BjRS8vTGNvV2c1NWNtQVV5WUVNK2JodkZFNHI3b1pRZTFt?=
 =?utf-8?B?dXFZc3BEc3dJTHhEM0pHKzR6TGVBbENmM0hpQ0xtd1FZZTV0bnMrWGRwZUt4?=
 =?utf-8?B?WjMyeDNvbkM5WDBRL3llYUhmbktxeVU3My9Wb0Y2UWJtMmRkSkg1dGUvMUtV?=
 =?utf-8?B?Mm1ScGRFNnFDSFZ0eGNpYWdsdlFlb3BGWVZKNDFPMElqRGN2WXlCVlMwVllp?=
 =?utf-8?B?MVo0N01vdHZHM1hjTnpTRHFtQVdrY1k5QUlDTTFuRmlKNFNjVkh5alNEV2I5?=
 =?utf-8?B?STBiUWljSG1YUjJSZ2dKQng5bGYzdmQzdFJ2YUt1aU43Q2RockV1Y05iZnhz?=
 =?utf-8?B?U2FxcStmSlplZGlseGFMQkl6RE8wZFI3ZWNucG5oUFBMLzhMUXhGcEZkbjlz?=
 =?utf-8?B?T01DK2tpS0ptMmZpUnVQNDRlL1RRUHh4Rkk1dmx0cVMrSHpodkllaThCYjFu?=
 =?utf-8?B?WTB3d3kxRGxHczJ5UGhtcElISnRtZzNYb1pjVGpYRkMwSy8yeDdqaldXT1lU?=
 =?utf-8?B?cFF0V2RuWUdOcHhsdUN0VVN3dDJiaDl2NUpuMG1BaFc0cDErSGdKbUswQ0VQ?=
 =?utf-8?B?NU5jWU5sYWZYdVlsSFU4eWwyVFJ4eElQeExFT25SZUpUZWtpTUhwM3A5MWMv?=
 =?utf-8?B?UmRzRXJJRWJ2MndzejFXUXhBL1V4bHZVVHpPK0gxVXNKNjNRR2tNL1NSblUv?=
 =?utf-8?B?YUNITzZ3RENNWmxVaHUyZTcxa01MaXhXcld2UkpHSmZFV1c2TnFjTFp1NHZY?=
 =?utf-8?B?UUtjRU1URi9PZ0RqVjBxUlVSOG5GZlN4RnlUaVBuSU1NVmZMSVI0UkdGSmZF?=
 =?utf-8?B?TUh1VnNtaXoxZ3djZDBLczNtRlBpbEJPUHhweHhEdHdTekMxMmhPZmlGTllj?=
 =?utf-8?B?d1lEbkcwVGgvMCtFZXR2SUJWZ2ZnRXRoVEhTL0lvdkwybTNrN0h6TUVsS3o4?=
 =?utf-8?B?NVRMcS9PUXRNK05qRElDRkxQcjdiazBpcVZ5Tmd1OTdhM1RQV3V2RXBodFdS?=
 =?utf-8?B?SHk2V0RTRlM4NzN6TmdXa3RYeWkxTzJoT211NmVYOW5TV1hVME9ka0h5bGVK?=
 =?utf-8?Q?Lgtl/puErw0axRpGHCXVUD8Gy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uuv/SHp28kwKsCWPIeclLJecYBlwGSxkt3Mi6v9DyvJ/7UI+9y8+RRiPUOVnz8gyJq4+SbDLdrXkJz2JhkQFgryN259cLvomP662Ajqa7eFeQ4fSCCZa2/DLWa7bOichO7VU2sNrDDlgKJT5AVZIRKfqNqAs7hvGoS1qNtIkc1UF3d177DhLv2JSK/COymBJIeO/5KPLNCZhm8U9qreqRNhutxlckOuVQ2GLYIiWzdVn65P1MKX5m+1qY9hAotgXHWYpbIUGpLRuF3HFfltEYW9hDknWgdCz7f694HE1xmsgz2giTCbWcUlfpwuPjfQG4Ut+9jA4Uo+StCvwmLa1zXZKx4i9u7y5NXiORJsm/MV9tzwWj3rybLP5oVGvZ2FQZvbp7gu50dD1bCQepSTISQoty71QlVaWIblcLh/iWOJ8EDsRrGfpVnb2zGEZtRhVSmbPYayPd9/oma0UytJb00rNjGs3xMPEDGCxZjSQt+4JRDF/xDe6OfyPEe0iztF9El5QPNLm/mgEOIHWbYRxkFWluFA4cNzDO6UGhDVX7A2+QIIDm84xxs22mlFz4qoNhm2GVTUryMGKeiP+iHLbbh5m4BxHfEIvFhTAiZyvRfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fbff2f-17ce-495b-ae7e-08dd82d12f33
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:41:50.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf4nvQpvDyVogk+IH+q1PIHznSI5GYcyM0N6uKw4VfK0ws5dMwznDaxFS5RJLBAgqZp5A1td8Ehjh/Objz3Uhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240008
X-Proofpoint-GUID: FhTVFneAV6OTeVXYis3cvjPDeE0gz1f0
X-Proofpoint-ORIG-GUID: FhTVFneAV6OTeVXYis3cvjPDeE0gz1f0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAwOCBTYWx0ZWRfX3DW80CIbMARz OfX+I/w/8z+p+ZbPX3nzKO+32ADtcsW1KhIzrWktQP6gHD+CGhJL+RrcoC1SP6xvvzuxBCvW/tB n4L8npDGN1okbvGdzcHVpPb+rPZCsqcDRiOz/4Vf6+SOxlaiTcDXrW1HXqYt6tOKexCyyxZOkq8
 LzBYm0sGb08TR4LrUIXpzEuN6CTfGM1u+FCRei6IDcNSwyu42CIlrB1TvuRUEPfugRy/U7fEc1U P94QV8U774lkYcM9qyD73FY9uTcw/ZK86v1u8BsMwjyebRIkZ8YnQjkLAC39jgvtw4Z14/mHr5w PBUA7A+p5T/amKYi/8heubiD7q8d9OiGfGz1EKNBmiSB1ntto028fU/83z71Grkht/t8ffR5s0t ST8zpv+G



On 4/23/25 18:33, Steven Rostedt wrote:
> On Wed, 23 Apr 2025 18:12:55 -0700
> Libo Chen <libo.chen@oracle.com> wrote:
> 
>>> Hmm, I wonder then if we should add in TP_fast_assign():
>>>
>>> 	BUILD_BUG_ON(sizeof(nodemask_t) != BITS_TO_LONGS(MAX_NUM_NODES) * sizeof(long));
>>>   
>>
>> to guard against potential changes in nodemask_t definition? 
> 
> Correct.
> 
> Whenever there's an implicit dependency like this, where if something were
> to change it can cause a bug in the kernel, it's always better to have a
> build time check to catch it before it becomes an issue.
> 

Okay that's reasonable. I will add it~



