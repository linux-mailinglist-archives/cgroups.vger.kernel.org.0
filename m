Return-Path: <cgroups+bounces-7776-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23C1A99D0D
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17B444142A
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBBEACD;
	Thu, 24 Apr 2025 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jC/YDepM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="drnaw5XH"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B75AD51;
	Thu, 24 Apr 2025 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455020; cv=fail; b=W3tcMjGzLx/MyBeY0ngLT5Nsol6KzWd0uqEvmPQzgv1FPL05nArmNW0xbwax9zqHS29FWlZvih9dmv5nuoVdKF068Wve6nz+0dV9z2fbsrZ3QLADQ4jz2tptw9uBwRYzhZGuRKA2Z7keUYo/zGP5iXuVbqncqHw1Id2HCKaIFkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455020; c=relaxed/simple;
	bh=4EXXJB2kWr+wT8hS55bk0rYouIZKQgmy7eCenwBtqYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CiDYsAOcQGMTVih8IKxQ50YWvN9C13dIv3i5BTVnpcnYBAf/rxgQgzpuL0DhrJifo/GRXbpocRz8OtrxqrC4DZ4rfJrQU58s6/cCfdvJqVNFMVuduHbNOULEgURimVxEFnPpWVpeHrSMIPE6GV3SM7SAkeIxVWDwMGBf/kK+890=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jC/YDepM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=drnaw5XH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLNCd3009730;
	Thu, 24 Apr 2025 00:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=s5UGXK6QUxebmQXCwlTevX7yYKyCfzSh4FZnYiWCAl8=; b=
	jC/YDepMVGPOxYwmE7pId3Je5rhpHpU+bAksBpSQPabZ/sypf52zE48Hb9+fm6AR
	2KqW+4IwlPAsW7sa+cEUMnYheiQhxf40WllQRhfud83fbQGUUkowGM5vrNvVIaHD
	C9hzPrlhwPm/f6bYw3TnWq6AmyG8jHQO7TUltlc1RoVRJiAZbsO90Sd3p2VIXiC+
	F92zqHCFhX++voi+2f/ENMYTOBqj7gPDknbfMSOYyK6JzbPK9BlvqmlP+6Qrp4Nm
	FaPhQ2oMr+g0+nS9IO9hmzNKka7C14IsFvVLqTptijxY6HTGT2ZzMShGVNsuuFnY
	xkVd9hpm0D/s3kTlrQtCJQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe2qpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:36:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NMY1Jt013879;
	Thu, 24 Apr 2025 00:36:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxpm8nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6ftJmS3cAfpBTZjpvmZaLpij/4x5sGq+DPQ8B27hB33eGAtijqfEj3ZQcLkT3cUPRNMTlo17Ymc6xRwFwbhQjhUOHcbDeYucIRpctuWiWB2jDH0iszVzRmVjTwXx08hzXgBhVOu3/TzauwfK4TD28VPOFYrLbxUNxMlLmGPlEX9Lx6gp/21IXMDxuYP1VNU5FSqVwyb9HzCzkCszI797oYUFxgNTlsMzwP4jhq3lDIYYN0/U4Gov5JKXQBKlhJ8MZuy8dEHOXlU6fLWTzUxjC62QowZAEYu1TQ5soEKnBTYh/iEAx8BodXN/rpR9dj4Edu/Z32d8TAjfG9WInBJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5UGXK6QUxebmQXCwlTevX7yYKyCfzSh4FZnYiWCAl8=;
 b=TlRIzBFOoYcfp6L+ExONM3tJybMzV534oULMJG1U/ajDYdZ0V8b1YbI6j61XCCgi2hgwGfF5MafZRECIOSt4vld9gor51cXRV2O8iwENOrLmpex2C0jJbVsTw78KRYzuXXRYcJdRm1R5yzOHt6Hf6rxnReR0xALNiL+sEUX9G4D1Ks6XroKWWwFZE8IIRKnALG+04gFjoEgJcxiDMatFPBQExPkpkOLxg//9jju7oeBNQyTe9jO8pXFRO/5IG/fu24YQUfNQtsuj/G7tA8iHtL63ZdE9pgL9tnPF6BtoKudUjtkrlEnhN1RL1/nYlI1aiH5BRDXlB4Nox89RR8m/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5UGXK6QUxebmQXCwlTevX7yYKyCfzSh4FZnYiWCAl8=;
 b=drnaw5XH+T768kFAJsLjsduqO+vvfhunv4fwUBVlIH2f+mEjuS5CAOTXlwRt/xtjrEa7ejDw78zf4OPhEtPTGeS/iIbsr9lO2mU0CoG2zLHvvs6tGWhxU94cVDKcsDeq+GI+k+UiIuKN84rgSCPnD2ACoil1aC8bG70qwQTW7kE=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Thu, 24 Apr
 2025 00:36:34 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 00:36:33 +0000
Message-ID: <d3a458d0-5f39-4374-957e-a2a3edf4983a@oracle.com>
Date: Wed, 23 Apr 2025 17:36:30 -0700
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
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250423201829.17d4c382@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::10) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc8fbf9-e40a-4b74-9a22-08dd82c8105e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk9oUW94U2txU3lpUGk3YXgrNTZ2WEs4R0Z6VHVYcWVDQUxRcjVmaUFVTWNE?=
 =?utf-8?B?WXBYaTduWjlzZ3BzYzdZTFNjMGxWcDNnTmNOS3lOYzVyYVgvRVVEbC9qY3FO?=
 =?utf-8?B?V1Q0RlBSQWV3ZGpRck0zMXdTZTZuekhHcU5kM3Y2SGhnVW5LSktvNEYvRHgr?=
 =?utf-8?B?ZEZOU3ZPM0tDcE5YN2x5a0ZPbDllR0hBV09XL3B6TGl4ejV0RHhHUDZhWFEy?=
 =?utf-8?B?Njg5eUxyMGNBTjR2ckZyOWE5WVZYcjVHYnU1Um5lTCtGTHZ1NGNPa0ROTEll?=
 =?utf-8?B?dXYxUldjOUxPd0c4UWFUWGExSStoS0NQODR0dmU1SDRPckh3V1phbTJHRWlU?=
 =?utf-8?B?QmthS1I0RUI5ekIxTWRRd3BwK3E1dGJiOW1WU29kTjFzMHhSUk5PZVZPT2lp?=
 =?utf-8?B?eGNyRllQZDN1SkY5dkc4ZUlMSXVTcW90NGRCQ0NnMk4xaDE3bWF5OWphUWhH?=
 =?utf-8?B?cEN0bG1oZFlUenE3ZG9VNTdKUFFKOWduSmlMd1B1d2lLemUvTDJHWEVSQ2lh?=
 =?utf-8?B?R2ZrdDd0aENrcGJSc2NLTnBPSE16T0VnVS81c21tZ3RhRHhUTGxabkNiUUtR?=
 =?utf-8?B?ekNWTkJVdGc0OHk0L0pLSDB0OUVCYW9RQXpScHFxMURiUGE0dStUQmlQWmlv?=
 =?utf-8?B?MVJ2RUVZdzZtcXlDTmZ0YWpnSFcwODdJSWt3U1A2eDNscklrOGVQaUVjSTVu?=
 =?utf-8?B?VTlMb2ovWVE3dW05K1NSOFUzYWJZL3pETEtkejlOY1dERzh4N1hwTE9TUWxY?=
 =?utf-8?B?dDJuWSt5dWI1N3IrZWJQTUw2dHN0V2puQkIyQk1qSFphd2FWVndtWTJCVkdC?=
 =?utf-8?B?MGJPTUI0RlNOYjlRdDE3bVJRai9rdzZvN1ZjdHZpdnBDZ3A2UUQxUnhmNEYv?=
 =?utf-8?B?RTVpNXdWNUd5SGVXOWVmVVNvMEN6RG9KUkpnUStwYnJOSTArTGhzRFkwaHNM?=
 =?utf-8?B?NW40SGh2Q2ZsL0l5ZjNvTU0xNmJSSmlsT0kwNW5Sa0V2T2JSSStQNjlwREFt?=
 =?utf-8?B?aFh5Uk1UZFUxV3ZsVnB5SXpsK1FIeWNMRHkwTmRDT0xZdDNGeTNGUGdmSCtZ?=
 =?utf-8?B?ejJ1T1k0L2JTbUdnOWpZRlMwWkVIaS8zZ0lRcFNEY05jc0ZIODV2TkM1eFow?=
 =?utf-8?B?dGlJVjY0OXZrZlBLN0RSd0J4SWlYSTFLMmttM1UvUEJBU3Myby80MUdtNDU5?=
 =?utf-8?B?ZElLeEVuUHorcnZtcHVkYnB5aTFxdVVtQkE1WTJDeDFWSXpvOGpWdkFMUHJX?=
 =?utf-8?B?akY5cnRiWmJRcW05bi85UzdjZEFvK3VtTnF2VldncWJnL0hnbFlmcEgzQzlB?=
 =?utf-8?B?NHdDeVUxSzRyQUNWOGVvcklWQ2RiY3Y3RUFNUWpSdWlkODhDUnQ3UXhxVUJ6?=
 =?utf-8?B?bWJiNFNweFZDbDhIZGhMTDZTRkhkcy9XQmljN0ZLcTluT205c2RlcWVubDht?=
 =?utf-8?B?VW9HYmRyeU5Ha3hET2s5UWFrb01LQW9sOWVyWUtSWHBJTmk5U0l3blNJMUUw?=
 =?utf-8?B?QTBWUTl2OUZMcnpCVHFPSU9jUTdaUEMrazVoQmV5M1VqblJpQnBRelpLNjZC?=
 =?utf-8?B?eFpxWTZueDdMaWVNSFRXdDIzampiOFJybTU1NlBjZDFWaXowZFVjRWE4SnNt?=
 =?utf-8?B?VDFObGRneDF3QnhDWFBjY2pzaE9wb1p6YUxxYTFnRWRLR1NZcHZuQ1JETlhS?=
 =?utf-8?B?TmhSWlZ5TDBUNGxnbUVnWk05MHJXbE5WQXBTeXhXNGdXK3p6TStKcFRWVURk?=
 =?utf-8?B?WTJrVk4rWGlzMlN4NEYvVy8yMHFNQUI2bjduc2YxWGgxNEhvazYxWFFSSFA2?=
 =?utf-8?B?byt5b2JPUmI5WUZLUTlhS1hFaG5PTW0yL3NFTlVjZnhYUXJjWVdXZWUxY3pW?=
 =?utf-8?B?c0ZRblJOK21NMWE0NXRIUkVwZURtQlpWeFI4cUI0bXJCa1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG5Db1VLSlgzc05TazJjU2NkbEVVeVdhbmpMN25RdXJEajZGR0EvWFNRellm?=
 =?utf-8?B?YXlKMkc4NzhZRHVzVHczdFFTVUcrcFY1S3RYL1VqSHhmSkU5K2c2RS9GTU9p?=
 =?utf-8?B?Y3c5aFRPWGp2dk5pMjRybEVEeGZSRkZWa1dUUk1MY2VNS1NJclk4VEh5ZFpi?=
 =?utf-8?B?V1RacTJuaEpYZW9sNkEvR0VFTUkrVmJnVStXMGJBaW5icmFWd284S1hIbis0?=
 =?utf-8?B?eHkzN3RwU0NobUY2Y05qMnZLVmhMUDNJa214SjJyL1NvLzlyc0NBNnV3cEtm?=
 =?utf-8?B?VWxSQW5iMVNrOUhpMGhqeCtMczlwR0RtL1FITTBsSkVlK2RRQzRES3RwaEI4?=
 =?utf-8?B?S001SjZScVhqRDJVckxMV29pTHd0Q0g5cTdxNmhGYVd1VUFTNXlnNms4akJ5?=
 =?utf-8?B?a3RhQUNYbE1YT0pvNjlxUXphSENYMGFvd0pVcFdHQkkydEpqaTFoNTZkbXdI?=
 =?utf-8?B?WVhYOFIxQXN6czNOMWRxbTlWZjNDN0w2OHlQZ2JxSHNJY3k0QUVZMnVqMkkr?=
 =?utf-8?B?cFBtOERWaGtSZU5NU28xUGJlcTVoS2d3alF6eGllWU5FeW8rSkpMZmhoUjVh?=
 =?utf-8?B?eHd4c0hMcCtod2c0dGQ2cVVVSWo5bWt1RDl3SDFaOFM4OGo5UndPRXZmbnFD?=
 =?utf-8?B?N1RjTHdtSzRnTFYyVWQ1S1grU0pnbTV4WEZ3MXFvazRMMFZKTndhNERBeFpY?=
 =?utf-8?B?ZzlhWC85SUZycE9uOCtxMm4rNTNXcGZFdU1CaU01K1Y3WVZES2pyVmlhcnll?=
 =?utf-8?B?MmlpNWFkK2VjSDBLVG04S241OFVxcUhSWS9NK3cxWURFUEZDdWo5MGFDSXZY?=
 =?utf-8?B?UVM1M2s1ZE1qRUNTU0JtVGo5d1dHc3dxK3Y4VGhrTXVFVkRYcWhSUVlXTFlE?=
 =?utf-8?B?eXVyd1puUWFJcDl6d0xRM2g1QzNoWFVNcDBwMHB5cnR3eno5Mk01Ylc4N0po?=
 =?utf-8?B?eGp1emJrcHNSdVJPbWxwaW5idWtlK1hrOVZmNHVkYzNGYnJNaDkwQzMwTG5j?=
 =?utf-8?B?SWxWNFE5RGxoZjF1L0lqYytMWFFmSGk2QTIwUkNqWnlsVmV0V004VG1lTXdM?=
 =?utf-8?B?akpkRmoyYlFHSlFzNnhYL2U1RUJxWjJuYktQY3pyVjVjWEZJVDNjZGtTeUE1?=
 =?utf-8?B?Ry9pdiszenRPR2s0bTNxUzZVY2IzYU5RUXRieG13VFI5UTRJaGQrWERJQ1gv?=
 =?utf-8?B?TXZ1UUh3UHdyeG5lR3lFb3l6SW5la2hHdlNjN3g5d0U5cVRjRC8xdVFRMU42?=
 =?utf-8?B?ZHFxcmxNUnI2aWtvdERoRWRKQ090clZsZUs1d3g3RUlrUUxaQmxXN1d5RUVO?=
 =?utf-8?B?TGpyZU5kSXBQY1VBNG5ncVp5Y2tlRld0WnZpWEl3amszdlR4VXZXTTZYUk1r?=
 =?utf-8?B?ZjdVcDErcFZnM2luZFpkTzZ5cmwvc05zVFJGb1JwVWVXWlNkNmdLWjZndmV5?=
 =?utf-8?B?UUtCLzgrOGxrS2ZFY1g5c3ZqNzI3L056bkVuL1RBeHZwRlJ6cTZtTjNBTFQ1?=
 =?utf-8?B?NWU1S0xlVjVvb0RoZjNlbGlYeHlNQUg3WmtZRzliTmV0SVN3bSt2ZlVYZzdo?=
 =?utf-8?B?WWpROEpoQ09iNzlHc0RFU0R3dFlqMlJnUHJPaGNrZFp1ODFPb2Fmc0FlTm4z?=
 =?utf-8?B?bzdnNFlGbnB1aGF2TFBHcFdmM0hScDkzYXB4M0Z1QU1NMDBmRUM2dUVXb1Ez?=
 =?utf-8?B?VEhHL3lsellqdFRBQ0lEL0hGaThlVFNGT1hSK1NjaGQ4eDhGZlpNcGUrTFdt?=
 =?utf-8?B?R0lEc0x6cW1jWFhIcWZTcW9TVDhha2dTK01oK3hKK3VJR1ZBOXNELzBTWGFp?=
 =?utf-8?B?U1NNaVRZMG5rNXVuc0JzdVlxekcyZ3JpMnI5REY5b2hyZExsZkRjUlhMb2M0?=
 =?utf-8?B?UmsrbThDVFZ1ZTBMQVpUVXcxUU9KODRMNnZiTkdxZk9YTlBPWHk5TkFJaHJq?=
 =?utf-8?B?bkg4Yzl4T0RhV0hFejBZQVZ2RmFpMGVraVR6aHFqR2E4U29Dc1p6U01UclVB?=
 =?utf-8?B?bDVkZUkzYjJvRFd1Q3N3VGhDWiswRkVSanlYdFRVYTluejh4OXhYVGltblVG?=
 =?utf-8?B?ZERDMkVjYTRtSmplMy81djJNdThYR25HRmhnZ2tyZXhWODlFbEFqaEVUQjBN?=
 =?utf-8?Q?bEHtDpLSNWKoyMPNjgeFms6l3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EjbchOpUv01UKl+9xdo9M4+s9AbSkVNIwOEv5MfTZZEkQ3KFf11G6ouWmGfNqbKMGSsw5Z6YHnF89wGSw5an3WjNWL8tnM2T3r5jLvpQ+GsdUSFwJEgcqgXSbf4hLyEEB6EnQ3t+vyY7bbY2UtiHO8m5YhySExTqHNbi4QvrmMMQ+v5jruDUP8VTWL2QiPzIdeJjiC0lis0rxobjCRwE5X3Dimjq6NorVZV/kwEnBxsrRCJ4S+8k33L1LteYbRQl75Vm6b4/6g8Z65TxHPpMNtjT2qCuSOhajJ0eQbGjPmsh+OSbAKfYjktzxNyFerXBpHwe/xTZloVeE70r3GF/CaARfdt0Foazf1uFaMcrEzEuc8JBko0vantoR0htKFbTTwUlTIi9BJGjs65QTTmrcqpoIhPHukIHxcdXitfHmiN9DrPGoLcaZ2laKNwV9RyBzeexPLp8l77opYHGYGM+s+LxrdDoyhNAEqdcw1u6RjSh7exp2A8Jp0FiGFsQ7D2NZSk0qnIyBqNoCaOfCNedOiiBbYtUxg+jAK/FkycZy6zd6Q1iGh+Lv4f6QJgh1+/sLQyrjkSr5PfpjSSsGaLt85RGX+GsHwBp9prgGBzkSKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc8fbf9-e40a-4b74-9a22-08dd82c8105e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 00:36:33.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V54oQZX/jWD35i493NJ1hhXKuPehHuYUDAKYz/DdcBR0UoQJGKjDWt1/9N12Qjaiy8o2h6up6g/PvTS98gRHpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240001
X-Proofpoint-GUID: T9m1NO2132Lj_S7J6gr4-F7EG_NbruEt
X-Proofpoint-ORIG-GUID: T9m1NO2132Lj_S7J6gr4-F7EG_NbruEt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAwMSBTYWx0ZWRfX2S66dnHAS8lA ZWX8nW+JnByEtO0DCoYtyRRgYAh1MPRzupBYt6Oj/dTnB9Mo8+TDcmmZkes7m4qKQ1AMMKGos6Z C6wK/1Xy++v8LYjSxkqv4Mc86XjHOdT/Nvnoe7ybS4BwoJcn8z9uoLcYQKl1aF/XTMVSN58vsw8
 rudu0ivrb665y87Y9mDbpEXgXGmnm/awsUXbwy5Ba9p28JuU6Uj5HJGpxvfT+fcPll/gZTVQUhw FjqYtbNr3fRvXr/1mDJi4LC9oWZV5fURRFDZRPX7LPTE+7bYXWH/4a8FWdCMb2n/Kukg4rXwnr+ JNL4YNZQeDB9Q4oKOn+zI6Jh4tp3X4EDUPfLbSTwmK3B3tpeOGQvDRkjNADEZEt4qZXwlr789gL vIEcwE+3



On 4/23/25 17:18, Steven Rostedt wrote:
> On Wed, 23 Apr 2025 17:01:46 -0700
> Libo Chen <libo.chen@oracle.com> wrote:
> 
>> +++ b/include/trace/events/sched.h
>> @@ -745,6 +745,37 @@ TRACE_EVENT(sched_skip_vma_numa,
>>  		  __entry->vm_end,
>>  		  __print_symbolic(__entry->reason, NUMAB_SKIP_REASON))
>>  );
>> +
>> +TRACE_EVENT(sched_skip_cpuset_numa,
>> +
>> +	TP_PROTO(struct task_struct *tsk, nodemask_t *mem_allowed_ptr),
>> +
>> +	TP_ARGS(tsk, mem_allowed_ptr),
>> +
>> +	TP_STRUCT__entry(
>> +		__array( char,		comm,		TASK_COMM_LEN		)
>> +		__field( pid_t,		pid					)
>> +		__field( pid_t,		tgid					)
>> +		__field( pid_t,		ngid					)
>> +		__array( unsigned long, mem_allowed, BITS_TO_LONGS(MAX_NUMNODES))
>> +	),
>> +
>> +	TP_fast_assign(
>> +		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
>> +		__entry->pid		 = task_pid_nr(tsk);
>> +		__entry->tgid		 = task_tgid_nr(tsk);
>> +		__entry->ngid		 = task_numa_group_id(tsk);
>> +		memcpy(__entry->mem_allowed, mem_allowed_ptr->bits,
>> +		       sizeof(__entry->mem_allowed));
> 
> Is mem_allowed->bits guaranteed to be the size of BITS_TO_LONGS(MAX_NUM_NODES)
> in size? If not, then memcpy will read beyond that size.
> 

Yes, evidence can be found in the definitions of nodemask_t and DECLARE_BITMAP:

// include/linux/nodemask_types.h 
typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;

// include/linux/types.h
#define DECLARE_BITMAP(name,bits) \
	unsigned long name[BITS_TO_LONGS(bits)]



Thanks,
Libo
> -- Steve
> 
> 
>> +	),
>> +
>> +	TP_printk("comm=%s pid=%d tgid=%d ngid=%d mem_nodes_allowed=%*pbl",
>> +		  __entry->comm,
>> +		  __entry->pid,
>> +		  __entry->tgid,
>> +		  __entry->ngid,
>> +		  MAX_NUMNODES, __entry->mem_allowed)
>> +);
> 


