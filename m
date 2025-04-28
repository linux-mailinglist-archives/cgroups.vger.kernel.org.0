Return-Path: <cgroups+bounces-7872-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D8A9FD9A
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 01:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99E47A7982
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 23:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1592135B2;
	Mon, 28 Apr 2025 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a2BFcTGe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FZl3pK+r"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BC1FDE33;
	Mon, 28 Apr 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881904; cv=fail; b=gVuJxdVYwIQG47H6NI9PnQVcIInAevlEEvOmqcol67yBr3yy2R9pLiRIQebjqduwY/bldrzI0qt82mw0Whss3qCW2PfGlcA3menGU0qMtPvk3MoHFALW+RKrseh6sxX30eY27FNHf4XkMd/aCZB6qYrA+JqIktT5gE/doVucI9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881904; c=relaxed/simple;
	bh=HLLzhuotUKXKyzVFGbyw/y/kMrt2KjoKB/MbhjLkwts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=akIQg5EqhtGzNrHcK5eMFbAG7ccNI60TGG3LcQIfxU3xzO22eV0UH7eoXWR3283uxzHBgoQfVeKEymN+pfxUNJAgZ6TCb81Ph9aXv12EiFTY3vVEY/Q2yuJUw0re4636lPe1srB+FsMas07XicJugYoO38LncB2OF+ia3jJykVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a2BFcTGe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FZl3pK+r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SMpmiR031053;
	Mon, 28 Apr 2025 23:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0Rfp8CxKp+hQ000XsaFTuir0OkNZSv2CO5+F5YoTS00=; b=
	a2BFcTGei6RA+/VoJ5PmDtr8XMZD4gQVW/Z37vT9K33ZEMlc+Z8aKXp6NxJwcTD/
	yd+Z03Bj8uTMD0WUpi1SFPHfr8TzYtzyRDehZmRW7LqpcNV3qDXv3LmSzteG6LSm
	T42js7/w5ezgLwgeAH7BJXPIphNyIL7p0AZsfFRLqNYAM6B1bggPEvars21TRrWI
	sFWyF5iHai1n9DUZXA26fEcfoimtFXLmrDab2Je7IKmtWKA1dgE7fgttIx8b7nrz
	UjBj9h7W/0Co+mpUZi6deneeiFlTYdpRDx1ZU7LaJgW4n/wnCKdujbqSWVqt4Twl
	3SZ+pTMDdRCkbwzmKFRz8w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ajdcr1ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 23:11:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SMmant011251;
	Mon, 28 Apr 2025 23:11:01 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010004.outbound.protection.outlook.com [40.93.10.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx9k3qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 23:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM/ZE8owhEOxqi1UIaMumyZTSph1YzkCJDFBc/D6I6mo3ADAOD1U/s3eRjYVVLHHFDqbViE9DbMy5cGKhb7xcZheLPpISFpMXF/Q1PtYJXY+ZcPG8MwE7FiuMLozq83C6eCFxhWQrDpoN9qBnZ5kJftGP5xC5Ey/Amn4RTbPp8TsdIO6TS4jaCboYgZB+y2Bgwt3I8iXW7bKPis/rWrmycFWRcTbIsBU3yqyjcQ+Bg97fYLuBeDJgmCArWEKtbJoI7wrMvVNX16sEOnnK7xUgUBbD2EXPbueZE0FITdi5ogsil17pdSRF99VywCTiLI+PscCpxb7CNXY8KHggKm9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rfp8CxKp+hQ000XsaFTuir0OkNZSv2CO5+F5YoTS00=;
 b=CA58SXwX1EEy5WTssnSAE4JcsfEEXBKCp35z8Ig7li7oISxY8Cpq72n9dZCyoACHVgUdRm7bIdJAlltvrLk0MCObTpa8uKU+zdGOsrT6O4bM6oGP6jcA8ewTNnO3GLHedFEFVeS5polam3X2sQ7awrKAqQUiG7dUZT/+jl3fbiffYoN+QN0A2cndi+bM8ELzSaG4ewiulj6I8kyeeZUMlVpmUKhSaPeT3K7Jlqt4J9MZJqzSXXvDL4JhVxxmOGO55n+TmDy0dZhBIZeOuaiwmYrpXw9kLrJSHlgcIelX09/KAa7dVKNxfcAGCo8NUQCnQg4ByGom677S1KeerimEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rfp8CxKp+hQ000XsaFTuir0OkNZSv2CO5+F5YoTS00=;
 b=FZl3pK+rqtfVOJ6X7gBaIrcJScW/WhKh8QB44fWeI6MqIAXcXoFaRCZDPKzZ3d8RaedU2RCWWwzLpOUV8YBTPE4MDKtXwL33p0jSzP2VtdunvM09IMqVilhzL+bXVRif7WR7zB+RVqhUn6c+IC50X9IZbkm8oEalTnk0vRD238o=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by IA4PR10MB8448.namprd10.prod.outlook.com
 (2603:10b6:208:560::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 23:10:59 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%3]) with mapi id 15.20.8678.033; Mon, 28 Apr 2025
 23:10:59 +0000
Message-ID: <9b64be76-b5b1-4695-97c2-bd2af777ec71@oracle.com>
Date: Mon, 28 Apr 2025 16:10:55 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v2] sched/numa: Add statistics of numa balance task
 migration and swap
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Michal Koutny <mkoutny@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, Chen Yu <yu.chen.surf@foxmail.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250408101444.192519-1-yu.c.chen@intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250408101444.192519-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::22) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|IA4PR10MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: d5419867-fa0e-4318-5ebc-08dd86a9efbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um9jaHdyMUo2TzFaMVQrU01ZY0JQZWpWaUx5V2dKNXZnL3Vyak9odUVrTVZq?=
 =?utf-8?B?WnRKUDNiSzJ6NUtkWERLUjVDQXNlQUtmNUpwMGZVbEcvSEFLbzJ6eDZ2Mjhr?=
 =?utf-8?B?T2JGdmlRQURXdFNndUFpWVNVa1QrNkJmbTlYd3U1VTAyMFpqcmxSV0htaVp4?=
 =?utf-8?B?emJ3SjlWVS9LY3h2b0VCQXROb284Q1lrUjdnaTlxVGlFZ0RSQWc4V242YW5r?=
 =?utf-8?B?ZTN5R1RFVUhXSDQ5RXpDT3dwcGRrNGV5UzZtR0Q3WWs5SEExK0UvUSsrSFJY?=
 =?utf-8?B?cTJyL1daNVQ5bHpibnBtaC9DWHNmUjgxL2pBM1BzSDgzVHBpZVdJVU54N2Nu?=
 =?utf-8?B?WFRLdkNKVUJSWVp0ZW85UjdHeDNHWFBYbkE2L0l4Q1Y1UEVKSDg3aGUxS2lo?=
 =?utf-8?B?K0Y5d29oQzErWll0NmtjQUxOQ2pUZ0xKeEZPRDJhaTU0bmtMN291UU04d2dT?=
 =?utf-8?B?QlhQUGJSeDdhMjBvRnNRVkVQb0wzdW4yelFLRFZkL2k4am1SazhzYm1mMWIz?=
 =?utf-8?B?ZVQ1LzlFbmNxSWM3YmdwN0E5UmJtMXk2YkdPR1hZZkVpYmlDTEFPUHNHcjZt?=
 =?utf-8?B?d1djVXY0NWUyekJDelNoVW1oY0JGOVc1alhjdkNVa1VSRWJVNEFENnMxT2VW?=
 =?utf-8?B?aDk3c3VtV2hFU3VhUlZEV3hKKzJ1cGhEY2xrQjdUUzFFem9PWG5OazJzcWlp?=
 =?utf-8?B?T1R6VFVYcHVBQ01xRktJYWdDRkZHTkRobnZnUSttODZLSVNFOU90TE5iWExP?=
 =?utf-8?B?THM1aGhaVURacjZIWUZGMkJHUEw3eGxHWmlWbTNzUTR4cFdIRm1wMFl5RENa?=
 =?utf-8?B?TThTU3E3QWQwNjIvUXRmODRLcjRBMnp0ZmVmMXEwdlhxcmI3VUJVdXNxdWE4?=
 =?utf-8?B?QmdGdEN0Q1FTNTBjZ3hDNDhXUFozQld1TnMvQ3FxQVVQMEtCV29QTDVjN1Rq?=
 =?utf-8?B?MnRtbUd4ZElNcVR1K0xBdUZGcElWNHd2RlRVNWNXbG9YcS9DWGJVeHBQVzlF?=
 =?utf-8?B?TDJ6c2l3R1JLbzhUdW9ldURZZEw4QkhaSEV2YU93VVN5aFAxYit2MWdocU9R?=
 =?utf-8?B?SDFSM0ZtL3huK2hqOW42dWRPNk5zcnZPdlJYODhSWGZLL3hLUnhpcmJMbFIx?=
 =?utf-8?B?bC9VUTFEc1V1UXRleGpZNEk1RlMrOTBrQW1ZY09BakY1dHoxTzhLNm9SNU1G?=
 =?utf-8?B?QTFjT3Q5RmlrejZlSlRVV0FaazV0QldBVVIyL2svM2VYRVpjaEowa2J1Qy96?=
 =?utf-8?B?bCtpVkZPSEhjUG1YZm9aY1FBVnRDeGxaTm9UV28zTXpIbkVxdkY3MEEvRUZl?=
 =?utf-8?B?bk1ZdU9PRUpiSzduODJvZzhFT2JvVzdreVZJVngyZzl6VUZkV2hBYk9FTVBZ?=
 =?utf-8?B?RkYvNEdJSmNyaUk2L0lXY0wrRTBIWkwvdm9vQlNMcFB5Z0dmand0Ykpzb0th?=
 =?utf-8?B?ZmlTd1VSTlFEc1VYK3pYSUZ0TmUzc3g4VURuTHA0VGpKTzdXTS9TOEt0SjA2?=
 =?utf-8?B?Z0ducUVCa0h0TnpoeHZxSkY4TDZEN3F0NTlDMVJ4SGtRRlNaSWhwTzgyL2lS?=
 =?utf-8?B?dVpqQ044Z2FjeCsvNkFHZnFBYllDRkMxZytQUUhxTVBieDFSU0VpNXY0ZTBH?=
 =?utf-8?B?VXl4TnJZMktMZXZpZmhEMEFwK0w0RFNnNHp1YkZFRG5IU2RyMGtLcnNGRGJV?=
 =?utf-8?B?UGRXWUMwY21ZSEtHaU4yRzZQWkU2Q1VXRVhtcmJ4MmttL1ExZ3FNUWVpZFZr?=
 =?utf-8?B?b0lOZ1BHbGZBRFBZTmRrQVVVcXhBeG9GUXRaZHE3NHN5WTdDaW9waHhHOUIz?=
 =?utf-8?B?Y3RMVUszaGlKQjBsMGorZUxobnRxTDN0N3J6VERPRUlXWmdFKzBNb1JQOHA1?=
 =?utf-8?B?a0ZZOFVNNHBCblNTNEdUZ3daRk04djJDdlZPY05IY2tFc1ZnSTg0cWE5TGJy?=
 =?utf-8?B?ZGZPZjREZ1VrSGs4MjBRUXZsTW14dmFZQytHVjd6RFBFeVpPcXBpWFRWZ3ls?=
 =?utf-8?B?UnpFNHg0UFpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2pUZEQ1aHBqeDBPTmJVRTFvc0VELzkwQzROUTVLdUI0TjFWeUpRK1F2S2RE?=
 =?utf-8?B?OEFJNTN2UzZVYlY0dVFGenp3NVcxcmlQWmxmTVptMWFaRlZacFRqOFREMFF4?=
 =?utf-8?B?ZmJwMTd1Smlid204OU9ZYWdCT1A4VzhQZkxublVXVGZ1bzBTWVJ3Tkd0UXds?=
 =?utf-8?B?NW1aM2F4STE0ZEJKV0hVN1RSdW1sb2NIcWUzV1Y5U2Uxc0dIV0lLZXh5OC9U?=
 =?utf-8?B?UnZFZmVFcEJ6T3dhd0tJWmNBU0c3U0U5R0Zpc3ZFT2IzYVl3UWVpNWl0WGRS?=
 =?utf-8?B?dVFJSW40ZjBiUUNYajZnSWFpWDE4QzlXbTV1YldCQXpNNCtzYXJhU3ZwREdo?=
 =?utf-8?B?cFlmMjM1cnFHRGREUWFUVUZiWThWVGhLSENWc0JlanNiMEdBNTcxdVBmd0sr?=
 =?utf-8?B?SUxRWCsrc2YrelQ2NnN6c2ZRc2Vjd0VDOUltK2QzU2R1SmsyQ1c1L0JPSTZl?=
 =?utf-8?B?NlZDQU9Zb1hxdjkwWnhrTEVWRU03cWVxalppRGMzbmtadC9lSzlSMklSYTBi?=
 =?utf-8?B?cmNhU2dLYk9GTitlTUdyNm9HRGFQNWwwWExzby84QXgyb01oVy8vOU9wcy9o?=
 =?utf-8?B?WnNvSEpMYTVZK3dTTGgzY1UrL2hiUStYajNYR1lYcEdqalNBaVFESzhsQjdV?=
 =?utf-8?B?RGhTTnVLNitFeXpKeGhrRktNTDNqTUZvZVhCSHpMam1LNC9Hb1BCWEM5RERy?=
 =?utf-8?B?czByQjd1RWJ3Zkx0SUZ5a0JvN3lyWFdKSHhXY1poNVJjNllYNU1NQzZkenZG?=
 =?utf-8?B?T3BqMXIybFFGT0ppcFljUEkvWXZSVUdyQzhGY2wySUhXRStCeXZpbFQrUXQ4?=
 =?utf-8?B?Ly9aeUwvanBvRzhlWWdQckw5bUtYaGdTSm5MWWIxdnoxbW5vSkM2MHFjY2dU?=
 =?utf-8?B?K3RycENYVEdKc2tkYk1UVEx3RXNlRHkzZGhXbHFrK2tETTJPWmV5eGdwbERX?=
 =?utf-8?B?YzBoNXNqdGMxc1J1SEtFMFFFWXJlUlV1UEIxNWRmZExobndwUkdQNXJQdHIw?=
 =?utf-8?B?cENGVU5WMlA3Z2dzcnlhbk4vbkk3NFovb0lhL3JpRWttZkt1WW1IRzJpdDVD?=
 =?utf-8?B?aitDQTYzQVM2VTBzRjcrVzJzaUc0bjVVMDN1MzB0ZWpBcmNmM3ZPeDdsNGhW?=
 =?utf-8?B?eWNMazZBaTAwZzVhMjVmczNWTC9uY21sYmxlRFdOend6KzhGaHVXTGVDWGdV?=
 =?utf-8?B?bnVPcUpMakJhWjh5a1JnN244QldoOFFPQ2VhcnhWTUVEZ1EwalArVnNpaGNn?=
 =?utf-8?B?STlnNUlNWnNGeFIzMDFER1ZpWlpvR1dlNDJNM000RFBkWEdLdkhOck14Nmpl?=
 =?utf-8?B?VkNaRHUrZGk2V09JbmkvbUlxeGd5eGxYVlpMOGRLUTZ2L0xBcFBpdFBlOEJ5?=
 =?utf-8?B?a3BtWGhnSUtmdFFwSWRVcU10eTJ4ZXg1T3QzQ3VYeWs4WHNPWElmWGJzWFlI?=
 =?utf-8?B?VUU3SzhMd2cvcDhpTjA2cTdGY1o2MGRqWlBtQWVJR2pZR05NYWxOS04wcWp4?=
 =?utf-8?B?eThiUTNsYng1bFQySWZiYnF4MnE3a0YwQ1FMb3NUVDdmcTNHSis3VnNzMitP?=
 =?utf-8?B?eGlhVGRXQm9sRXdWUXl6bU54eVlHdVd4UUhaeTdSSzVDWG1MdDg4WTdmOUkz?=
 =?utf-8?B?cGxFTU9IcjNvTjlvQ0toQnQ3d3hBM1FCSTVxU1hwbDRWVjFzUlJ1WG9WZ3RM?=
 =?utf-8?B?UE93MGZsbWJlR0hXSTBsVlY0c3JYVWZrSjUrTjFIVXIrbHRFWU1ENUplSnp6?=
 =?utf-8?B?WUUrcXIySTF3dG5DMkpRTHRycDJQR3ZLUWVWelpkNWNWR2R6TG92bXFmSVhP?=
 =?utf-8?B?K2tvbTFaOGowcWkwZVFtaTd1YjBoNmtSNTlLZkFkQklHRkhoaEhGWEJ2eUJ1?=
 =?utf-8?B?OHo4VlJhMjMwMi9wMnhkVmd3WjJwb2g5Yjk3U1pEazlGS2RFN2t4YzhDNVp2?=
 =?utf-8?B?MEJNVUhteWdtQ3l3ZUhhNUVhWE9mVHZxUVVvRElxbGtMclA4RWNObW4vQ3Jj?=
 =?utf-8?B?bWJlUGw5YkI3MjhOdnFvNS9ycytsR2ZXUEwzaCt3YlZOVXorc01WY3FmbFpF?=
 =?utf-8?B?eHJhUVU0c2prcWpnb1JlZnltRm9XaGcyRUVuNm9PM3Vvak5kc3RGQlJRZnhu?=
 =?utf-8?Q?zIS8iK/6Gj3RuMoly5kBPcC2E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	djA4e86o0wBtAoDNOcMybVO13UagaNL4vgbyouYaeA6Xaq8+ykNS4E/q5ZpMLrFWCtPvyFJFxvYE9uFpceyVnIx0Sd3KnkHXoO6nX93JUv+71CPKjJsfBLVy7yvuxqWXfwEQvjLVlqpL5Ta0N8VU/656v1K83gmk3dyA4zbDCQIdASNOJIdsAPZipSuoPJwahlivPjGIensxsNa88SsMMXFnRJMJk+EQ8+uCWIrR4KilApoLN82BRwp5Tx8I9PmPt7jJ/ztdyxRtUryEySKMzG9F3UKQwK5Do7Tf/F2gm9wxijfqkaMKT2Txgz4GygMcxiLwAQq480JSdVkWfW7uJhQFfpM/M0vat0NFkm082UTe4d9ZrOoTdml1v2OWy2xmyx/Gc2JbDOv6kG0MSHD0MqfYAZG8jRFa634TBJId/Rx6qjbsSw+lllztmS81kivd7GKOg2t2MdXw4MvAoigVxcxbkywFbZI289IBnQO8iWl9CHod/fA1M2Gnev1GnbCj2IpWpwWDCAOvKUKIbAFUCSIzXSoMOs/u6Qi779etzYFK562RzMJZf3TnER3swAeWPLVxlIX5DMqOL3CqwZ847URoe8IHal1zHjLImN3GJW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5419867-fa0e-4318-5ebc-08dd86a9efbe
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 23:10:59.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIg+QpjumaSnlWS9clRBYDycbmxOx7dH0n9ceIaafjr1IdBzuSvamqRqJpKwJ4ogUdVtJWXx4Z7xuc5tiDJS9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE4NSBTYWx0ZWRfX3ZtyZhBLOaFF dYZrQJbtOS7TIe+QbZMlG4segJEtk8uJGRV0LY5xi5kHNkQ026KZG0eu068jVyroCTuQOggWXgr aAMzIqsmL3KVc2xSmZj5azMULFBiV24c2dCQTVSkAbxHCBaiUEMJyGHn4a2urxuEt8sZaqehW/1
 QsYk4pCUN3RgTfKuQYks6DIw+A4qAY/kSKmrumd1dMq/CeahcWwEMs9NV1WfaL8i2afLo/shdTc 1kNQEupysNYaC8VsTXuAzUw2UXXZYHODqeCoGApNr07mTNeNt8F1ExqbZq8D4S0yvFIu/SkzZkH pywtrNA9GKt0oaiSM6m/FJRo+Ii/sF2qhGdflNU57eOiCWQ4SvLwJSLBhXSZWqYCUw4BwFcpoUs VeKAEpVx
X-Proofpoint-ORIG-GUID: E39JeK6181W9rpwPHwrlCIIi_PGbzCSx
X-Proofpoint-GUID: E39JeK6181W9rpwPHwrlCIIi_PGbzCSx

Hi Chen Yu,

I think this is quite useful! I hope it can be picked up.

I have one comment below

On 4/8/25 03:14, Chen Yu wrote:
> On systems with NUMA balancing enabled, it is found that tracking
> the task activities due to NUMA balancing is helpful. NUMA balancing
> has two mechanisms for task migration: one is to migrate the task to
> an idle CPU in its preferred node, the other is to swap tasks on
> different nodes if they are on each other's preferred node.
> 
> The kernel already has NUMA page migration statistics in
> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched,
> but does not have statistics for task migration/swap.
> Add the task migration and swap count accordingly.
> 
> The following two new fields:
> 
> numa_task_migrated
> numa_task_swapped
> 
> will be displayed in both
> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
> 
> Introducing both pertask and permemcg NUMA balancing statistics helps
> to quickly evaluate the performance and resource usage of the target
> workload. For example, the user can first identify the container which
> has high NUMA balance activity and then narrow down to a specific task
> within that group, and tune the memory policy of that task.
> In summary, it is plausible to iterate the /proc/$pid/sched to find the
> offending task, but the introduction of per memcg tasks' Numa balancing
> aggregated  activity can further help users identify the task in a
> divide-and-conquer way.
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v1->v2:
> Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
>  include/linux/sched.h                   |  4 ++++
>  include/linux/vm_event_item.h           |  2 ++
>  kernel/sched/core.c                     | 10 ++++++++--
>  kernel/sched/debug.c                    |  4 ++++
>  mm/memcontrol.c                         |  2 ++
>  mm/vmstat.c                             |  2 ++
>  7 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index f293a13b42ed..b698be14942c 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1652,6 +1652,12 @@ The following nested keys are defined.
>  	  numa_hint_faults (npn)
>  		Number of NUMA hinting faults.
>  
> +	  numa_task_migrated (npn)
> +		Number of task migration by NUMA balancing.
> +
> +	  numa_task_swapped (npn)
> +		Number of task swap by NUMA balancing.
> +
>  	  pgdemote_kswapd
>  		Number of pages demoted by kswapd.
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 56ddeb37b5cd..2e91326c16ec 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -549,6 +549,10 @@ struct sched_statistics {
>  	u64				nr_failed_migrations_running;
>  	u64				nr_failed_migrations_hot;
>  	u64				nr_forced_migrations;
> +#ifdef CONFIG_NUMA_BALANCING
> +	u64				numa_task_migrated;
> +	u64				numa_task_swapped;
> +#endif
>  
>  	u64				nr_wakeups;
>  	u64				nr_wakeups_sync;
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 5a37cb2b6f93..df8a1b30930f 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -64,6 +64,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		NUMA_HINT_FAULTS,
>  		NUMA_HINT_FAULTS_LOCAL,
>  		NUMA_PAGE_MIGRATE,
> +		NUMA_TASK_MIGRATE,
> +		NUMA_TASK_SWAP,
>  #endif
>  #ifdef CONFIG_MIGRATION
>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b434c2f7e3c1..54e7d63f7785 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3352,6 +3352,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  #ifdef CONFIG_NUMA_BALANCING
>  static void __migrate_swap_task(struct task_struct *p, int cpu)
>  {
> +	__schedstat_inc(p->stats.numa_task_swapped);
> +
> +	if (p->mm)
> +		count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
> +

Is p->mm check necessary? I am pretty sure a !p->mm task cannot reach to this point,
task_tick_numa() will filter out those tasks, no hinting page fault on such ones.
We can add a likely() macro here to minimize the overhead if there is a reason to
keep that check.

Same comment to the other one in migrate_task_to().


Thanks,
Libo

>  	if (task_on_rq_queued(p)) {
>  		struct rq *src_rq, *dst_rq;
>  		struct rq_flags srf, drf;
> @@ -7955,8 +7960,9 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>  		return -EINVAL;
>  
> -	/* TODO: This is not properly updating schedstats */
> -
> +	__schedstat_inc(p->stats.numa_task_migrated);
> +	if (p->mm)
> +		count_memcg_events_mm(p->mm, NUMA_TASK_MIGRATE, 1);
>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>  }
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 56ae54e0ce6a..f971c2af7912 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1206,6 +1206,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  		P_SCHEDSTAT(nr_failed_migrations_running);
>  		P_SCHEDSTAT(nr_failed_migrations_hot);
>  		P_SCHEDSTAT(nr_forced_migrations);
> +#ifdef CONFIG_NUMA_BALANCING
> +		P_SCHEDSTAT(numa_task_migrated);
> +		P_SCHEDSTAT(numa_task_swapped);
> +#endif
>  		P_SCHEDSTAT(nr_wakeups);
>  		P_SCHEDSTAT(nr_wakeups_sync);
>  		P_SCHEDSTAT(nr_wakeups_migrate);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 83c2df73e4b6..1ba1fa9ed8cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -460,6 +460,8 @@ static const unsigned int memcg_vm_event_stat[] = {
>  	NUMA_PAGE_MIGRATE,
>  	NUMA_PTE_UPDATES,
>  	NUMA_HINT_FAULTS,
> +	NUMA_TASK_MIGRATE,
> +	NUMA_TASK_SWAP,
>  #endif
>  };
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 651318765ebf..4abd2ca05d2a 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1342,6 +1342,8 @@ const char * const vmstat_text[] = {
>  	"numa_hint_faults",
>  	"numa_hint_faults_local",
>  	"numa_pages_migrated",
> +	"numa_task_migrated",
> +	"numa_task_swapped",
>  #endif
>  #ifdef CONFIG_MIGRATION
>  	"pgmigrate_success",


