Return-Path: <cgroups+bounces-8019-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EE7AA9E33
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 23:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195CF1783E1
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEFA1D63E6;
	Mon,  5 May 2025 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ny89cIVH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NTKdSdEL"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46A16D9C2;
	Mon,  5 May 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480774; cv=fail; b=gkq4bB2uvcwATM04P1K3CkoT9w8620ecCvQWcscaJggjdWD6Og3qQdHYZ0abZ8UwgTUUuOObiGtvnvl0aFQJ9vIZnkvezuoVIkUCwdSjGrjCk1SJ/ns/v8oWJjPxiwfS6EryqRX6H0el+iXqKkNt87QUbMyxJ8an1kGIAihIDJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480774; c=relaxed/simple;
	bh=ktx0wf5Ec6PxFb5QzuaWseOIhUTy+YIj2hF3PmJjofs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ud/86Pm82bf0ggasf50eKiR4qRL9YkvpeWbGsWWadxm1Oio2YpNkWE35A18PmaeVl9FeoFnxlPHCwJKfjn28jkM0v9nvwoKJRplu6IGk76bgRkcUdxn9AVgfKvjkfdclUifBbrNMOtJOpNBTHwPCCJAcPhxzN7cWAksFmESKxfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ny89cIVH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NTKdSdEL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L2876002728;
	Mon, 5 May 2025 21:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xJvnUV0ic6m593caESdXk3vCeYMERRUoGP63VB33fCY=; b=
	Ny89cIVHApPmhdHb/jfLOwNbncui7dzeXkcA7u52gAasUqI6lIrpmXaYYCw/7PtZ
	nGSUj5e0rlAJ2CFFc5BbEnIgHds39ZbhxuuHTkniSMOl6Ft0HIv+lDdI6I2Gx0V/
	V6uFjI5DsBWgXjQfxR/UXY/2bmkmWCMONmG0iKcfI3k8lhO03FxcXtZT6mV0OWfv
	pvhVwG3lXoQrEjzUxN+mWTcKZnot9Og2s3RRhCmaDzRXAFydAYCaTgT8Erspk2Zk
	lV9zbrK2sAhNy3tyZxCxMf3awj7b0FVkz61ddprFXjwnXhlp90EHzoYX/MqImMGt
	ieRQpIuvrQgbfEU4Cfir3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46f4vw01kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 21:32:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545Ksq2p036101;
	Mon, 5 May 2025 21:32:24 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012014.outbound.protection.outlook.com [40.93.14.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8xxfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 21:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3QYvclJGHx8O4770b2qP4h4X93L8H2cfewezEVgJP3vD4cx6dJE1k6IoByS22y//MNbAfETGNHU2J1NkGEz9QCWG9mBJQqGWsmKePI6xmTok7BH4Xqyt7l8BQU8KCORao5Qm4LzM/7oNE3Js+qeHRcp7gQkvK20wadtjWu/TIGQ4VlwmntnJ7gV8oLboGLhLr6nRSrUDlZFSsko4tlzcTMX5nVTfffaIq8tT8RFRZ3qW1fhomY8Ki7+TCedyxphUQO3YCpftNXFKhB7L1pMI3dkaQzJyv6iSqHrcS5GUw/Jsp8FQ8uMeLFPlys2O7Y15IUk3JefYP4xYSWnXCAFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJvnUV0ic6m593caESdXk3vCeYMERRUoGP63VB33fCY=;
 b=Nr59K7wa2xz+no+jmMTNW5bLlgeFWg5jTCSJ6Q2/bXvakVp0mnU/FiFrwIEbYVq6ltz7iatQ9GlkF/5cZS6EXiXIk7u9U4igUqVA03jx3kceAvalTZ+fCklVlIjo1JLwwLhyBFXiTv9F6wwxO5Rjm2Lp7tNnS0b6dWMXdAqejARzdmM4cFvJ8kEO8CsJPrTQo51DlpqS2MMYnM2CrP2yAejIk6qozCgwB6YkjlRNX++hGIz/MvbCcgEl81abmEXG4jLcxVKBauv22zUTOe8NvROI0dLt5s7vj3YvpWpp+7YAv3Oq/vbhDfFAZB8efo9oOO5yXhmwNC1mouG4et5mdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJvnUV0ic6m593caESdXk3vCeYMERRUoGP63VB33fCY=;
 b=NTKdSdELeysTLP8xB7GQcnxocz4ep8ljVuQ/ryc1OIoBshwi/ZddvwkkJodkKWH2JsUJfEWxNXQ5W7Tss/yLKhS+/NA6H3LZrYcP7jXMsAI2mUEDWMCfTIJqnTM09fI+mwiyudeaIChSEe/e7Q4+GzbnS+0clM0eepSwZO/7JmE=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by PH7PR10MB6130.namprd10.prod.outlook.com
 (2603:10b6:510:1f6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 21:32:19 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%7]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 21:32:19 +0000
Message-ID: <c7444174-fa5e-44c1-bd16-c8971d118b1b@oracle.com>
Date: Mon, 5 May 2025 14:32:16 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
From: Libo Chen <libo.chen@oracle.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: "Jain, Ayush" <ayushjai@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Chen, Tim C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Neeraj.Upadhyay@amd.com,
        Peter Zijlstra <peterz@infradead.org>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
 <tkfh4h5ntl42jc2tnwyj6dhiqouf6mowin7euvrnbs2tyiqlay@bpzdptv3plsf>
 <0bdc72c0-8f4a-4d91-8e67-f8d56dc26788@intel.com>
 <5735cb9d-86ae-4c8d-b0b0-5b0365843707@oracle.com>
Content-Language: en-US
In-Reply-To: <5735cb9d-86ae-4c8d-b0b0-5b0365843707@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::20) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|PH7PR10MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 14026515-9e6c-479f-7072-08dd8c1c5062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S09acE5OTG1PRmk3cDh1U3Vzc3d0MDVXV1hYeXhPaE9tcXZDVTBPZjRtZDkz?=
 =?utf-8?B?MjV6a1VPSkFuMlkxU1BBTVdXUlJTU05FdHdkK0Z4QXNtTnp5Q0wxQklLV3ds?=
 =?utf-8?B?YUFOZHRrTXFzUDFsTlJUb3lrVTIyQjd6QnJYMVJVdkJWaHUvNEh3QTE3T2xR?=
 =?utf-8?B?eEp2Y1NIdUk4K3BxRHh5aTVLZzh1aWpDQ1RHNUJLL3IyeHQ5bHN1TlhVcjB1?=
 =?utf-8?B?b3U0YWptSCtYMFRJcStHTXZpZERibDkrMGY1NTg4cEVOdkJ2WEJRL3dtRFg0?=
 =?utf-8?B?MkUzZnV3OGRDWnV2VkN6RGFRRkpCNkJSRkxydkU4YTR6ZXh6TXBqb1JTa2hX?=
 =?utf-8?B?UEJsU0dDVXMxTTJ5R0NYdnVNWHkya3h1ZEV0QncrUHdVYlpqbk9ZMHlzRXNk?=
 =?utf-8?B?ZkdDNmd1cm1zVXNobGwyVWs3NFYvZEZnTjRMWWpQUU01U2EzNFk2UHJyOHpO?=
 =?utf-8?B?SG52QlJQZzdaek5Ib2d0WVBRQjVMRjl2c2xBa1JBTENyUkR5TEl2TXVpdkFh?=
 =?utf-8?B?dS85VWw0eS8rWW5rOCtTNlYyeUJpTkhJZFMrd3J0bFMvOWloSjYwZG5sV1Qw?=
 =?utf-8?B?K0Y2YU9kdXFVY1Rqa1l6ZzFNTVg4Ym9NeXpSNzIwRHh5cVB1Yjl0SGVXZHg3?=
 =?utf-8?B?K3lXZGFRM1llempWNnFPZ2VQSzNGdHRVaEtIZWVrbXVha0VZM2JrNllNcGlE?=
 =?utf-8?B?VUowSEdZTGJaME80THlmUEYyeXpZUEcxa0dLYVl0MlJZWXltdWhDWFdpNmFN?=
 =?utf-8?B?aG00Z1k4R3VPa3Y2VkN6VEYxSDQyemNwOVlMOCtrcTJJSFJYcFNlSGpUV1Zs?=
 =?utf-8?B?Z2cwTHRZVkVSb2pZQVpaVWRKQ1VmcjV1MkJaWThxRnRLcXZBNnhvZkduSjZX?=
 =?utf-8?B?SDZqdjFlaEc5ZUcwTWd0VnA0Q2VIYXFmUG91dEhRM3Mwa2R3NlNSWFBpNTNh?=
 =?utf-8?B?N0hsaVBOUmlLVmtwMEltaTVkVGd5S1EzWE5VRm5VQXhBZUJvOWhabWhPbHJP?=
 =?utf-8?B?Z1lHWnl4Y1V0ZmV1ckg2L2tudGEzTW5Xd1B1VFFFbFUrYjFFbzRLSjF6Zm9C?=
 =?utf-8?B?UHQ1RDJ1cEpRdlNMNml0TGtuclFIT09udFhVR3Z5SEFRTFpFTjFhTWJSalFE?=
 =?utf-8?B?ajZRTzJEN3NTMGZFWEdEeW56SnZkcWJqYWxZNmZzL2JMbzlWN3hPRHFURWNl?=
 =?utf-8?B?K1U0MU1UdmNZcENQUTE0YjBNcWdtOGJRVDF2c21kK2N0QStDNm5zaFFLd1Iw?=
 =?utf-8?B?UDhYTVdlVC8rUGRERnp1T3lqVFBnTjhYTFNvaWhvQjQrQWFrWUViRWxuSDVq?=
 =?utf-8?B?T2xkWnpMMS9VSzdoUHZYTFZWcEFrN3dXNzY2Q3V3a2RPOFVZaStTZGhXbXZM?=
 =?utf-8?B?UGdGN245bjk0RG5FdCs5UVA1ZUNrVE1SZmFhSDRLSTZwUDZtN2pDNjBpN0or?=
 =?utf-8?B?V3BQb1BOeE1xRFRVM1Q5S3NHemwzOWpDM3BOTG5mcjd6RHpPcERlRGpSWnAr?=
 =?utf-8?B?UWFoSDRGZ3c0My9tNEc0alkxaGRDbWFHNGM2RFM4dS95NXg0SGd6Qm9TK3Rz?=
 =?utf-8?B?ZGU5NTdmRXRiL1N3UW8ra0pOYW42WTJNQ3dHRytQRkFSMDQ5TzN5ZzlLN2Jz?=
 =?utf-8?B?elZ1Q3h5Z3U0TFR3eDNGZk1yeC8vakh0aUN0NVdpRnMwcDl5YlJncGxUNHhK?=
 =?utf-8?B?Z0kxRlA1ZzljNDFSdG0zSGczd2tIRTd6eTBhSWN0cC9MRjR1THVBc1MwVUxj?=
 =?utf-8?B?VXBxQnQwQ3NNYkptakRJRGFNMlhkU291MHlydURwQmwxYjEwMUVqaVljMzRo?=
 =?utf-8?B?QlRlQXgydjlGL3prUXZTRFZEWXA0emdMNVBKUVJ1VmlvVWVwbHNVdjhZa285?=
 =?utf-8?B?cjNxMUNoVHJLOUFhRVVRSEpKcnFoNzRCM3pjVVpXSGUrc0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVFCM3M1bWRsWkRoT1U3T0EzcGdTUzJXYkMzek93dnp0Nmh3QnpmdDJEZzNB?=
 =?utf-8?B?RVBURkt6b1BNRFdPMmgvQlhxNmU2dE84blg3ZW13VHhqaGpGVjExaFFocDUr?=
 =?utf-8?B?eVVyV1NTY1FyZWdHQ0hzbmVxckc3Z281bTM5Z3NpeTZ1VnZEZ3diY2Fwa3lX?=
 =?utf-8?B?eHJESnZnaC91ZGVBMzkyZU91Q2tZOXExcEdCYzJPN3FrWTMrZ0U5VC9aOGwy?=
 =?utf-8?B?TEg4OEFQN29qVlQ1S1dGUTlZRStCVFArbDV2NjdDNFdNSVJsN2xyMGRKN0tO?=
 =?utf-8?B?bGxCZXdZelZWbTJmUVBKMXdjdWVjd0czRTBJMENKTVlEV0Erd1pYZUM1ZmxX?=
 =?utf-8?B?cnloZGQzVzZoRkxVRXRSZjB4QWt6RWl5QUJBRlZGT2FnSXRKQUNvZWdtci9t?=
 =?utf-8?B?SGpHbnVXK0hBVmxYUS9TK1VINy9iUU1ZNEVOd3hEeE9XTTdaY1JXV3JkUkh3?=
 =?utf-8?B?bytSaGd4Z05jdkxRVUcydUw5aHlya2x6c2hCRmhaa1pXN0FHMDYvenFoTHAy?=
 =?utf-8?B?RzZjUzN5WXR6RzNKSjNobExsQWVBdTNPU3k4aE9xRUpKd1czY0l1OGU4MWs3?=
 =?utf-8?B?dzZkOHJyUDZ3R3YxMng0UzhjOUpTR0xldVVQN2dsT0pFSUEyR1BDWS9qT0NK?=
 =?utf-8?B?UitBL3c3aDJ4Sms0Z0hTSmJ0TkttK0Z2a3hkVTJ3azJPQkZMbVplNENlVG1U?=
 =?utf-8?B?OGpzVGJ3ZzRjTE5EYVVIU0t0aDJWSG45amd5dUUxVEs5a0hGTldGcjJmZTFt?=
 =?utf-8?B?NHZDeXJSRWVlYkhYaURiWVc5cm5VMDQxOXZldUM2ZEpyV29URS9FeThJcXdG?=
 =?utf-8?B?SGE5M1I1UnBiUHRsMkYrTVBTMHFBbktCTEFxNUUyNlcwYmNXSmphdngzQlhi?=
 =?utf-8?B?UUhhTFZyb21vTzZGZXptVnUwSGZsenIrTkdqRmhDdUZ3dTB5T2gxNFJCejc1?=
 =?utf-8?B?emdwc2pxc2dwMVBoaExXYXBWRHBYQUNibE5KY2VtTTB0L3FkdWRvWVBkTWdo?=
 =?utf-8?B?NzFIbytyZzZxUHh0bTdoS0sxajdtY3Y0eThEUWlpSitaOSs3c1ZCRVYvbXR1?=
 =?utf-8?B?SS9RcnhNZk85MWp6WndpSHByb2J6bnErcVBGTVRTWjEwY25PK0sydG02UERx?=
 =?utf-8?B?elRpT1ZsWDNrcEVXcmJmUTBqelpBUnZ6UFRTWHZ2T1daTFJIV0pvTjhDcjEv?=
 =?utf-8?B?OGdyMEdJTmhnaEtjZnNrNjExYi9jajl5ckR1TXdHUTU0SkI1QkRyY1dlZGlw?=
 =?utf-8?B?Q2UxaVM1UEZZb0I0YjRxUjNnak5kSkloV3ZFckZqSFRmRURmMzliOGl4STdM?=
 =?utf-8?B?Y291a2dodTVzZ0YySFp2K0NHRnRhbksrL3hBYU9NUm5XRU9tYUhDTTdaQkpY?=
 =?utf-8?B?a0R4ZUNuWEpDbXZNbWVONllCdklhV3VJdndHbTU5TC9VL0I0WU1UU1ZEODBK?=
 =?utf-8?B?WUFhMzE0Y3JFVnA4Z2VBS1IwZktDNU9WTUtEOGtoa1crZDkwSGFpTEZkSlM1?=
 =?utf-8?B?Y0RMS202KzBhWVNWdDV2SE1MUFk0aUc1b3A4SjRuSnVHOGo2ZEVWL25EbURX?=
 =?utf-8?B?L1RwMGN2MEFublpmN1VkTGZpdlU4QllRK2wyMGhuZmRLMEl0dnJvNi9vZVlO?=
 =?utf-8?B?eXR0TXZaeDIyRUM4c3BqU1l2YkV1NnlYVTd0MzFPMEFaT2ZyRzRNUWFnRkNa?=
 =?utf-8?B?TXdDNUU5Y0RvaXZVZVpQMXpEaGdTOUVlZE9tc3dhbytVaVpiQUg0bXZwU21u?=
 =?utf-8?B?ZUF4S1kwSU1WbllpOWp3UUZPeWVIcEhidWpFcWNYdkNmL0V3VHFGZGtndEhY?=
 =?utf-8?B?NHM4VmJsV0pUcU1DTHQxRlMrT2liUUtIWUZDM2RlMzZlRUtRcnVodVhWZCtY?=
 =?utf-8?B?dkdQeElpQ3RKVlEzQXhBRmd1T3ZTMWc1YjhrUlBwRVNQUXJBczRRc2xoQUs3?=
 =?utf-8?B?RDMzZm81dHpJSkU2N2NtRXVybXdvaGpxY0d0OGU2Tm9wZ3MxSzk5cE9RMDJ1?=
 =?utf-8?B?eG9wK1RYeXJrTm80S0VmaU5nb2lLYTd4cktMZzNFZ3lIVHRkeURPNzcrS0dO?=
 =?utf-8?B?S05sRUtWN2VUaUNxWTVsS2tQOFFRQ3FZSE9tV0lFR0dZbG9BYWJCWnd5ckVv?=
 =?utf-8?Q?uNZNuJLjpWcbIGvxe9J1HTIoU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ApY5VRrioQow/a7KiLwXwFa5AsMELdUFYBVc75/ss1ZypzXZqYSCcRNNokKaEfsg+usSGh0DY3xuxeF4ZNxgvOrhrF3YCrX8cBgoXiWCck7NWYII6dhpTibujos809Anv4kQBy2tkiKl5WNp/bkAJVvJL9VHPm9deyScMtMOtZJ+5sMWe9MnEziNTjJaoQB3xLcGSdqGaVeUrtKuz4jBdi91dpjoAsf8rBXxbAgZfv87a/BVdocOz3/Rv8H6vYgiMcZo6sHdURPY1VM/w11L37ZlkDmMJTFiBb5BaE9wNuZjxMaGLMZv2ADrLUtA0JipJh7IlCY2bf/pt41K9mF7wDXXgb0gIW0BcasC4BjZSrBuNHK1VWXZaUPF3ZFV/PNkhO9OgFd8zIJbNLroOHyK69onKxrM21Xy48dJHlBQYi/FEqC7j5FkhTTb+M2/EMt38amfXeFuLonByVq8h6WFD+K7xfR6JzoEozOT0T15+QNqPrYN8q01wadZY74lGpgDZo5dl9cU+e5aGayvP9pWflVjMsC65D78L24l7fNgdFkEujgex53CR6tm6wQO8N8dkAhNRLZFOGo0e8i6yXx4Xvi5vz3B87ZhyAnrm7Q5FyI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14026515-9e6c-479f-7072-08dd8c1c5062
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 21:32:19.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8iEmHHkfyGrjPc+js81juwGjP2zl0YGL4N06iOhRFAZOU3sWIQMgGBFVEbvUcdm1BNU6UoWjejRa8k3ht7CIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_09,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050203
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDIwNCBTYWx0ZWRfX+j8r241XpgPJ iN0/yQbld0w1TKwtcu3euWbQeLi//LQ4GowMBFi9rwh0LTMj8rtzgVQucDSaQvQAAyQQ5Cj096f n1DLr9uoC2vUddgs0sfouGPmG7PrqSwit4Z1mqU59SEchG93N1h0D6oMie3Ign7ybQkSat7hkY0
 Ma9hq/riKDt57m9n9ksiayyK5tiG6pPpn8buY8sc57psLFZNYNR8rO90SpGSQYPrFMZeiMfCMBq 454npFe9PzOosTAOSQAZOx7PQCvvyp561RdEWrw1kq8DDZmYh/Em025wQiODRV2o3Dtb7I41BMn X8aJ55Je3jvrKrgNLIu/8qDqQGQ6xhOY9JKA/B77+pP9NVri4LeofoQQCKKK4UvKsixVj+MihLn
 80+6SDhyA4KsbvrJCV1RznXXkRYdeQ+SoEopJsoGK0HnCnR6GVFb7eIMAodzVAGdPab731Eq
X-Proofpoint-GUID: 9DeGW_ZppDYj51MmjKufaJ9vpl8lf7Hr
X-Authority-Analysis: v=2.4 cv=AvPu3P9P c=1 sm=1 tr=0 ts=68192e69 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=B4dTbynIJPF5XUvCgB4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9DeGW_ZppDYj51MmjKufaJ9vpl8lf7Hr



On 5/5/25 11:49, Libo Chen wrote:
> 
> 
> On 5/5/25 11:27, Chen, Yu C wrote:
>> Hi Michal,
>>
>> On 5/6/2025 1:46 AM, Michal Koutný wrote:
>>> On Mon, May 05, 2025 at 11:03:10PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
>>>> According to this address,
>>>>     4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>>>>     49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
>>>> It seems that this task to be swapped has NULL mm_struct.
>>>
>>> So it's likely a kernel thread. Does it make sense to NUMA balance
>>> those? (I naïvely think it doesn't, please correct me.) ...
>>>
>>
>> I agree kernel threads are not supposed to be covered by
>> NUMA balance, because currently NUMA balance only considers
>> user pages via VMAs, and one question below:
>>
>>>>   static void __migrate_swap_task(struct task_struct *p, int cpu)
>>>>   {
>>>>          __schedstat_inc(p->stats.numa_task_swapped);
>>>> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>> +       if (p->mm)
>>>> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>
>>> ... proper fix should likely guard this earlier, like the guard in
>>> task_numa_fault() but for the other swapped task.
>> I see. For task swapping in task_numa_compare(),
>> it is triggered when there are no idle CPUs in task A's
>> preferred node.
>> In this case, we choose a task B on A's preferred node,
>> and swap B with A. This helps improve A's Numa locality
>> without introducing the load imbalance between Nodes.
>>
Hi Chenyu

There are two problems here:
1. Many kthreads are pinned, with all the efforts in task_numa_compare()
and task_numa_find_cpu(), the swapping may not end up happening. I only see a
check on source task: cpumask_test_cpu(cpu, env->p->cpus_ptr) but not dst task.
2. Assuming B is migratable, that can potentially make B worse, right? I think
some kthreads are quite cache-sensitive, and we swap like their locality doesn't
matter.

Ideally we probably just want to stay off kthreads, if we cannot find any others
p->mm tasks, just don't swap (?). That sounds like a brand new patch though.



Libo 
>> But B's Numa node preference is not mandatory in
>> current implementation IIUC, because B's load is mainly
> 
> hmm, that's doesn't seem to be right, can we choose B that
> is not a kthread from A's preferred node?
> 
>> considered. That is to say, is it legit to swap a
>> Numa sensitive task A with a non-Numa sensitive kernel
>> thread B? If not, I think we can add kernel thread
>> check in task swap like the guard in
>> task_tick_numa()/task_numa_fault().
>>
> 
> 
>> thanks,
>> Chenyu
>>
>>>
>>> Michal
>>
> 


