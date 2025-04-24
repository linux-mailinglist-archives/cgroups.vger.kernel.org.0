Return-Path: <cgroups+bounces-7790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC3A9A4AE
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 09:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1061B678CB
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 07:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE411F8733;
	Thu, 24 Apr 2025 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+v9g6VG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S34KRA6o"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067491F2380;
	Thu, 24 Apr 2025 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480824; cv=fail; b=NSbMXKdlAjHHycA23RAcUOiI2h36NWw+Lr97B6SLoNbqsEuEp/V6688gjh/SQgVU5/RX/7hoZqZYtkGFFEzHwQinWSJX3TV8bGaWeMhVjEsdrarCeiiOClPxQFXz8rh+t0CEwpPv/z0ziwnDhCxrkOKFQG+jwtvTsdwkiJiUWuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480824; c=relaxed/simple;
	bh=NxCYeCZWX9ONFyDYsQ60m3juiYPXmxEs2/TKH5ezAwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uO6tD0IdY3XGmF0DDmySc7yuyKa5kAKPYXFPtoSt+1Z0Akp+ZpeB8WShm8Sc89nzVd4E78OS/H/cz4KKAbuJZWyA8DIVZfGIGBbak1nZ2u5Il60Mgtn7KRGmVl7Vx/GVvH+usMwmPETT9qOMcU7rQNTPMOz9JHMySj+Wrbp85iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+v9g6VG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S34KRA6o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7b0Jk008942;
	Thu, 24 Apr 2025 07:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3KmieSO/qSeCUBcWinQm2TrPP5StX80jkj/vOTTJNYI=; b=
	M+v9g6VGKIFJcnq+B9UoRoj/bpOBreJM3savi2Q6pLMcmzCDpQ0Zxaxhak5DkiQx
	r7k4kZs4f+6mQeu3efKUtgX+KL2N50VD846ktnB/f3fQp094SLQ1x3eliff7d/1e
	DTCfnV8PuXBSDM0lhwbyt56Xs44xcc/8tN3m+lwPx/kGi/cyi90KcFosBAsDfGwO
	b7Qq4ZC/cmoB74z5JvQWaYnUM0+ivexfuJHhXppnRvjQwNtsexuKMvYrXgXjc8iD
	/oTQODxM0g2Vi0VGnzdcPYS8vXSIMXtGZkZLNARo3RiNoZoSawST1bSQsFtiprYp
	4xmtAdS68HMzxYalcZozqg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467h2kg0ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 07:46:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6ucaC031635;
	Thu, 24 Apr 2025 07:46:39 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010003.outbound.protection.outlook.com [40.93.11.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfr1g78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 07:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8R/XhX5INbfjasEyt/W6r/aAhAFL9lFfRsTyxW0iy+O78CcArhOfNKgkV1SqG5RUR33h0tV+jGmKddck9doGLx4XUFqRZgEwEf9INbOcJRUnp2WhLP/oQH6XM5NJpKCFpY1/eOxD9jC6yGAyOvgoet7+Znw6SqW6qSDjVFnN8Gsmkiq7yGmiSUQrq7IcCiCJpkR0lvX1AvL5Bud6KmtI6CIvMozsl75i1G2ZGG7j5zc62c4Mxx3Gl+5cfpvSK5wlLWCJmUfARkoKU2BnK+phwnyOayQUBxxFFKTbwZU6d3Wof85No5bs2KaVboctXmmTfMxiZnsCh93TZymyVPWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KmieSO/qSeCUBcWinQm2TrPP5StX80jkj/vOTTJNYI=;
 b=tEc10S4vVi9FdL7MMyYTtCWvQDhI6KCbX3p1FmWMtqTBwyF9+tpUrHuRaXyNwwOZkLuBMJLviMa/A2fSAPfoJbp3RImahS7d2dKrIzDwJ5nBbQoOlGXv3XIzeT96VQ3UF2IrrK4nYQLzXn2Z8AjjSguhV4kgqE35uT4Ui5SCZ+HYVTV8LMBajDe7zqu+3Dnuv7LCCvvc4zzkQPW49qh9YdXGuQScS8Bi0zIrDxLOEQlYKJDCV1MeCwKeCIqpZbIysQX+rdGjlVEp2Qmlu140WRWojkgzNmvNjmqxpQB1WKB0XwBKFivyn4jzc/yzNJIiPnFnSf/eC6u1Ba+m+yYAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KmieSO/qSeCUBcWinQm2TrPP5StX80jkj/vOTTJNYI=;
 b=S34KRA6oheF57U8rxL7MxI61dhz+BKDwX8UVm+ktqGEUQQoRAbR5vTJE4gsTjvfZc1Bx/qsA2ijjwARXdid0Fy+iJ3ioTDG6KiWiw5peCBQTTl0vbT3LMw8GwGTvNqlvpbB/FAk5N1by+gnIuNVtzWhV0YZ8+tAFKYPkYET480Q=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by MW5PR10MB5713.namprd10.prod.outlook.com (2603:10b6:303:19a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:46:37 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 07:46:37 +0000
Message-ID: <ec69adf2-4eb5-4e38-804f-804d1dde0e84@oracle.com>
Date: Thu, 24 Apr 2025 00:46:34 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v5 0/2] sched/numa: Skip VMA scanning on memory pinned to
 one NUMA node via cpuset.mems
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, akpm@linux-foundation.org,
        rostedt@goodmis.org, peterz@infradead.org, mgorman@suse.de,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        tj@kernel.org, llong@redhat.com
Cc: sraithal@amd.com, kprateek.nayak@amd.com, raghavendra.kt@amd.com,
        yu.c.chen@intel.com, tim.c.chen@intel.com, vineethr@linux.ibm.com,
        chris.hyser@oracle.com, daniel.m.jordan@oracle.com,
        lorenzo.stoakes@oracle.com, mkoutny@suse.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250424024523.2298272-1-libo.chen@oracle.com>
 <57892439-7683-43b7-9b03-4553737273b7@linux.ibm.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <57892439-7683-43b7-9b03-4553737273b7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::16) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|MW5PR10MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 4581b94f-5363-45c1-aa88-08dd8304246b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NERlNnlOZEU4aUtyMEpIVThoNThxa2ZsOEVBbndwbER2ekZ0SmwwU3UrMmkz?=
 =?utf-8?B?NlVQdDRTZW43TnlYaWRGVTczaitmNDEyYkhLVDA1QTFhYWRKaHBrTFFUbHVO?=
 =?utf-8?B?N1FKYVRKM2tRVjdIMHY4SzdBdFpZUnpkNWk5UEc0L0x4a2NYYm8ybHJ6SUlz?=
 =?utf-8?B?MmZNK1VIbWRPUjBqUXBhMFFWOXVPWU9uenRwRVIwci9kY3YrdzYrMVllb1Bt?=
 =?utf-8?B?bitLaE1QK2hCM3EwRzN6NjREM0ZQeFhJelBpQmUxZUlFL1BySjJkeUdNNUtG?=
 =?utf-8?B?OHk2T1dZWDNNVmZBUlBwNHJuT0JHd0x4TC9JcXJFNmxwR2R4R2FReDZ6QXJu?=
 =?utf-8?B?cHVTMGsyVGFFMGN4SjU3eGtDU2FqbGNvN0U2SW52VUh5dk5UdTQxNnpISnNB?=
 =?utf-8?B?NnU5ZUR3Y1Q1VngrRGxOdjNiRjRLeUxJd2JOYWZQdENROUlQdFh3UU9ITU9B?=
 =?utf-8?B?RkozcHk4RUtWUTlzVjBkSTBHejFOdEpCWGtGT2dCRmtOd2djQzV2RlpFdW5k?=
 =?utf-8?B?N0thZ2J1NWRteHJRWk5JaWlmTmJnSnpJclNudURVbG94bzhSU1NiQ3dpSUx4?=
 =?utf-8?B?TWpZOHowMi84b3lVcWV3LzM1ZDlQMWpweDcrUmlYRHltQ2kxZUFQcE5KVzNZ?=
 =?utf-8?B?RmVOYWlPVlEzaUMxRW9hR2lZbTVNOFRHMDNRZjVzb001SmlFVTEvRDl4VTJi?=
 =?utf-8?B?WXNUb0xRVW1kMnUvNS9aS1czU0pRb3UyanloZEcwUnYyYVpYM1JMd3R4dFVm?=
 =?utf-8?B?NVFxT1dQc2tuWUQzRFdud0VHMXlFaUtQZGNtaTF0QmduWW05QStRaklqTnVn?=
 =?utf-8?B?ZzRRWUIybU4zWmxhaGxlZElFc2hocXVmOUlWWFpnd3F4NUVsV3FLajNwZUVk?=
 =?utf-8?B?Mmd0ZDlPOXlWOThRbTdPVFIyZ3J1UGhSSzVnTFZ6dkFRR0xnUEwwTTJZczJ0?=
 =?utf-8?B?M1BrTld4ZlJIQy90RGthS1pwSzZwNC9hSUN3NlF6a2RUME50TXNoN2E3VXRT?=
 =?utf-8?B?NUZSTldNZkhrdno2MTRQbHl2Z2Vja3FxdE9WT0wwcnNVdkdTZ1RFMVFmOVJa?=
 =?utf-8?B?eTA1U05HZzBJRHhHY0xlM1ZmRytuZVpSYXhCOW5UU0tVTkFSS0xjYWR2T3NB?=
 =?utf-8?B?N0hYWGZFRGlwZC9kWjhqMEEvclJqNy9NV0hXb0p2UGN0aVhHVzZHYU85cC9l?=
 =?utf-8?B?ai9PTWI3MkdKcy9HdWljQXU1S0YyS0R0WE9YN0FCS3FqdzFmOGZRRkt2Z2Z2?=
 =?utf-8?B?MmFKTFZJM0VqaU80Y0hCM215MENzbTU5cEJ4b2tXSHBzWnk1eURjeXo1R2pK?=
 =?utf-8?B?ZWwyUVViUUk0QnBVakVsSTA5aUZkYVVsVlNJNENOSUpXQWZDRithYU9zZUhP?=
 =?utf-8?B?V0dMUFpQZnJsbERnOWt0VXhqK29zcXdCQzk5ZkZxNUsxUzBCaERLaHBUNXlU?=
 =?utf-8?B?Nlk3OU9lV3o0dFl3QU1tYUdZNFlCZTVvQVBINUF1aWlYeFI4bURNdlR6V3lT?=
 =?utf-8?B?ZFhxdmQxME5IbzYyY3oxY1Z0b0NZNVZkRkFBTVdyMEJXVTZ4WXBaWGFvaXk4?=
 =?utf-8?B?YmZ2WEJGY3B2U1VuVVN1cHl6S21zR3R1RGpwZzhUd1hkd0hham5FZW5Ddk9a?=
 =?utf-8?B?bVc2RWdIRHZFV3JTK2p6dGNyT0JrNDZJUEsraE5YOXFhRExKNEcwYjdsekpn?=
 =?utf-8?B?VWpSYkh2cjhpMC9BWlZHYllJeGRXSHRrdHc5Y296dmlRRGNYTUI2aVY2MnVH?=
 =?utf-8?B?aFVuNTk4SldkRWlnd29MOXd6VWtPdzlhNTlOOVBkZUFFMXFtbUVvbTlWczRV?=
 =?utf-8?B?NUlONUlpRGFZMW9IVXphaGVmblZRNThHQzhLMGZmNUZLaUttbWVEV2c4eGVw?=
 =?utf-8?B?TytpYThtVExTaEJTWTBtN1Z2emRxODZOZ0MzaTJWZDFRSmQxbnZISGpRaFJl?=
 =?utf-8?B?a2Vsb2ZYdnVJVFZodmFLdm1vNERXdnZRUEYrOVRub2ZkbGRBczNEUGVtTVZP?=
 =?utf-8?B?ZFh1YWI0ZEZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEplWncxVzd6VmtvMksrUllmbi82VEtrMEV3ZmpITlN5YlluUnlYQzFJRDIr?=
 =?utf-8?B?amhFNjg4QUdBWnVnMFQrcklNVlFaaWkrcXkzZlA3UHZjQU8wbnFiT0VEN0da?=
 =?utf-8?B?SnI0WWNGYk84WFViWjAzN21CTXFRRmYwbXlRaFhTU1FxL0xJdUhvVnRocHR6?=
 =?utf-8?B?TExZOFpyL0lPRkEwSWNIY09ZbHRvcmZ3WlVUYThpc2o2ZjdoQU42SG51cmxV?=
 =?utf-8?B?Mk1CTWtaZ2d5QkhOZzZOWjJKQi81SUpsczJ6bEx1ekNJMC94Z011ems4eDZx?=
 =?utf-8?B?Y05YMlJzWW5FWERoQ2dBemZsaURZc0M2b2oyYmhGcUwzQzVCWDJNVkpIMkkz?=
 =?utf-8?B?Nkw0eFZBY1JEa202R1BJYWg0Y05RTDNpR0o2Vm16cExTazBBdFZ0N1NqdExB?=
 =?utf-8?B?NEJZaGsvajY3S0dwbDdOVGs2NTlIMkJNdEtNTkJjOEN3dDllWTd6NkJJMjcw?=
 =?utf-8?B?clc3cjFydksxdTRCb2VDVXNaUmlybnJGMXN4YlpEKzhORHRFbktNOTJuK1hk?=
 =?utf-8?B?WFVzYlVEZmhIVW1qQytBc1FXd1F1eStYa241QjFNOEluajF3R0tNa1BMekVN?=
 =?utf-8?B?dkV0WktVZEszL1FZZzN5dXNjUzJaN2xBby9DcWFiNk9MTzc3dm5Yc1dLcUp1?=
 =?utf-8?B?Zkp4SXZ0eWIycU9oVWovNy9XdVpWRmtLRkZXUFZHU2ZvdVFSSEN2Si9LSXlE?=
 =?utf-8?B?S2tFbGNaS1A5M3ZlS0UyNDdvYWxva0RRL01aSGwrNnRmdjFHbkVGVWozd2lT?=
 =?utf-8?B?Wm9LdGh3K2lkNHU5U0NmMnFrT0RxbC9ZTnhYd29lRFR0Y0lUNXJCTXhya0Ex?=
 =?utf-8?B?M3JObm9KWHRrYlZVbXZzZ0FaK20vZHpLNEdobXlFME1CMSsxWGxsNlZPYlNI?=
 =?utf-8?B?SVdmdjBQOGoySEFUU0syYVhCR3lISVhyRnQ1RDBMeVVKcGorbXc5eFU3eCtJ?=
 =?utf-8?B?WEVUeDZGQnBLamo4c2VUS0h2eGdNYUxQQnNJYjJpMzNDNTBxWUFldGhrdnhD?=
 =?utf-8?B?ZEdzN3p1M29ZeEYzOGtEQkI2MnRWVkw5dllnckV4MExUNjlmZzNSa29sL0Rk?=
 =?utf-8?B?M2JvZ21JZzhmR014Y1E2eHJIa3hRN3lKOUFtb2xjNTZvTEJEVmZieVVmRU82?=
 =?utf-8?B?RUdQdHh6OFZ3a3lTTm1NbE9OMGVqblRlSzl1QjArcmxMMnZJSUVPaXVDOW1C?=
 =?utf-8?B?dmZ5c1pBY0hQckc1L1gvM0g5V2ZKaG1zWTcrRWdwdXExQmxEU3NjNnJibVhy?=
 =?utf-8?B?aHBtLzhTMDFkdUVGVHMyQmpOdlNQcUFpUGZqNW5PZm52ZlFQVGx6SWdGa1NO?=
 =?utf-8?B?U0dkc0dxTWI4UGFoTy9XaXZxVGtOQS9xeTF1UFhRb0xvT1NYdEhaMFczVGJV?=
 =?utf-8?B?aXp6dEZWeTBGT0VXcjQrSVlCdDRIRjRld3FrUFdqeW13bTAyeXdDaVR5dHpW?=
 =?utf-8?B?YXpwWWFKNnN5Q05OVHM4ZkdRajArc0NXYks3OWVNWGVDTnAxSmsrcndpb01t?=
 =?utf-8?B?VjdVTGJVKzczMUVSaUNYNmhRbFJvU1ZiWTIxVWdTV0c3cDlMYmFOelNaRHh3?=
 =?utf-8?B?a2kya1p3cisvbFdQNG1xUFVBVERKZ1M4Y3R1bzlZZE90bTZnZUVVVUtZR3dK?=
 =?utf-8?B?Zm9kTkdFVmJ5Z1JyWklDQ0pTZDR6NUJwT2sreWlLOHM5c3JiZUZkZlhPOWlC?=
 =?utf-8?B?cmU2YXlXS0ViYUI4cEpjazV5Z1h5ODF1YkNUaG9xRzdaeExWZFIwYTFVem4v?=
 =?utf-8?B?cllYWWY5SmlXU0wyWlBWRVBsMjRFS25ObE1WZjZNN0FUMzBaOEYwNGZtdUdQ?=
 =?utf-8?B?UWJBZWNPcnJzZGV1OFdaRzd3R2dxOHNwRmNiK0RxUlMvc0RCYzI3R2dkSVoy?=
 =?utf-8?B?L3lsdllGdDZqV2FqZStVY3R6d0g3L3R6cHBOZjFoMjZERHNMY3ViamRiUEky?=
 =?utf-8?B?a2swdG5pMmNINXNsbEdMY3RYSWJ6VmFRY0RjODl1WWIxS285a3c3VzkvZ1Ur?=
 =?utf-8?B?eHJzTGdCalJ0YkJ4d3pzMm1FMnZZMUlDYW9qeDNWU1FtUldtODI1RkRJd1hL?=
 =?utf-8?B?RmZ4dHB2NGdoSWN2cVg3L2F1QTJEalIvbjdWM25tbzRTYmtQeG1aVU8vK3dz?=
 =?utf-8?Q?48e2Ykn2W9TIVGQrX+/yBtdFB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8UGxuJW+q6R0RAn4ADyF7uOFfGlmj8TUTOBf+nquxoH42CVja6G7z2miroe2VzIE0abyVaz6/6UNv1P/uDKm7/Y5dHsHLumPw14GQhFUKaoPCtHGjtHazMWtbx6+9ZLtb6d9Oac3TiWw9+BYz3HM+yVWoHyfwmMhfnWkpETsY5fAu6Cx7WcnkFcb2ymJLFjFIh34utCqvZapLbrXLoryxHbeKqBPPIiwZXXCM/I0IHfUsTbGkL0zy4E/7iAnI0K2YrmXHd+aha2JcihQdUBq+Ry54CeOy+BiMbICtsdLX2vpNSk2txcmsoqubhCXpqIfKrySPkLJXglvaDvm6q+2c9PQPw5wbf0YTqhj+lpxeEf+rre6DE9/BdP+NM/RrsUjiY7stBDHvXTiw0i7OB0mMTpT+o36vFLstRiM/V+HH7EHi4Cisxpl+8eviy3Ow6z0e3NobAcv7arPyJXzuJZ5qk3M0ZcHB8NC/3SHUyPuHtshHY94o7Uurpm96htIklncSdMDhSuk6hhWyweFtjXfwdUc9/2sb6O+SnVzRueJBIG7gLYNYGJOKoMniFXzysSpgmU/3xt/qsTyQN3oau970eRCs82izrstyv5BEyD5voE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4581b94f-5363-45c1-aa88-08dd8304246b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:46:37.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZe2Mt7zdbaG/hzu8Mm0eqnNXC/IuHVFmCLJrK+ZCWML9MUy14sHw5EjweiDIvacJfq0yIL/2Z/Zhvmua/vt/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_03,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240050
X-Proofpoint-GUID: LJ6scat5pLOTLAw5Uq-pxl8Jw5NrL6uQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MCBTYWx0ZWRfX8eFb1T6uSNnY dV6vWFn8M2JiQkSqJ6u8j47nEgJf4bxo75vE217sM/FNTgLhge9xcUp8efJQ3Ut1S6eVenSUQOj sNeY0JkthX2ZLeQaAUE9hcNYMdXiKAY2ZX/sScXMhCS/IKgdBarEQ8qzgN0hkTHawy/BEpU2bNt
 9InLb7gS5P82df5yKPl1r6GEdfltNmkNHN0P6hjbM2N0RVYDEC4yMZ3sWzcqqvsID/dUydoc3Vm kXU0ytJQxedRpRBXgH+H1d0GrUulZu/EeTgFUIUkxTKgbfPE0b/p1s6fKl43iSsOPZ2iDfiivxK hNahf/SywlanGxNQZLRV931JT8Et8PqRtrZeFPfUQnXsXvHuJgVfNC8ormFw3MIGf1/z0xbCLTq XlwcKwB5
X-Proofpoint-ORIG-GUID: LJ6scat5pLOTLAw5Uq-pxl8Jw5NrL6uQ



On 4/24/25 00:05, Venkat Rao Bagalkote wrote:
> 
> On 24/04/25 8:15 am, Libo Chen wrote:
>> v1->v2:
>> 1. add perf improvment numbers in commit log. Yet to find perf diff on
>> will-it-scale, so not included here. Plan to run more workloads.
>> 2. add tracepoint.
>> 3. To peterz's comment, this will make it impossible to attract tasks to
>> those memory just like other VMA skippings. This is the current
>> implementation, I think we can improve that in the future, but at the
>> moment it's probabaly better to keep it consistent.
>>
>> v2->v3:
>> 1. add enable_cpuset() based on Mel's suggestion but again I think it's
>> redundant.
>> 2. print out nodemask with %*p.. format in the tracepoint.
>>
>> v3->v4:
>> 1. fix an unsafe dereference of a pointer to content not on ring buffer,
>> namely mem_allowed_ptr in the tracepoint.
>>
>> v4->v5:
>> 1. add BUILD_BUG_ON() in TP_fast_assign() to guard against future
>> changes (particularly in size) in nodemask_t.
>>
>> Libo Chen (2):
>>    sched/numa: Skip VMA scanning on memory pinned to one NUMA node via
>>      cpuset.mems
>>    sched/numa: Add tracepoint that tracks the skipping of numa balancing
>>      due to cpuset memory pinning
>>
>>   include/trace/events/sched.h | 33 +++++++++++++++++++++++++++++++++
>>   kernel/sched/fair.c          |  9 +++++++++
>>   2 files changed, 42 insertions(+)
>>
> Hello Libo,
> 
> 
> For some reason I am not able to apply this patch. I am trying to test the boot warning[1].
> 
> I am trying to apply on top of next-20250423. Below is the error. Am I missing anything?
> 
> [1]: https://urldefense.com/v3/__https://lore.kernel.org/all/20250422205740.02c4893a@canb.auug.org.au/__;!!ACWV5N9M2RV99hQ!IQpY9WDL1O3ppDekb1PpaTYJ98ehOXL6dNIkx02MPN84bCieT18zCh7WSouHctEGpwG2rtpZB42l7b5mkMFb$
> Error:
> 
> git am -i v5_20250423_libo_chen_sched_numa_skip_vma_scanning_on_memory_pinned_to_one_numa_node_via_cpuset_mems.mbx
> Commit Body is:
> --------------------------
> sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpuset.mems
> 
> When the memory of the current task is pinned to one NUMA node by cgroup,
> there is no point in continuing the rest of VMA scanning and hinting page
> faults as they will just be overhead. With this change, there will be no
> more unnecessary PTE updates or page faults in this scenario.
> 
> We have seen up to a 6x improvement on a typical java workload running on
> VMs with memory and CPU pinned to one NUMA node via cpuset in a two-socket
> AARCH64 system. With the same pinning, on a 18-cores-per-socket Intel
> platform, we have seen 20% improvment in a microbench that creates a
> 30-vCPU selftest KVM guest with 4GB memory, where each vCPU reads 4KB
> pages in a fixed number of loops.
> 
> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> --------------------------
> Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: a
> Applying: sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpuset.mems
> error: patch failed: kernel/sched/fair.c:3329
> error: kernel/sched/fair.c: patch does not apply
> Patch failed at 0001 sched/numa: Skip VMA scanning on memory pinned to one NUMA node via cpuset.mems
> 
> 
Hi Venkat,

I just did git am -i t.mbox on top of next-20250423, not sure why but the second patch was ahead of the
first patch in apply order, have you made sure the second patch was not applied before the first one?

- Libo
> Regards,
> 
> Venkat.
> 
> 
> 


