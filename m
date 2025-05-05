Return-Path: <cgroups+bounces-8015-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8FAA9BEF
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 20:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1617C320
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4E26A0EB;
	Mon,  5 May 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5ClvcKG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A/n57u+Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD91C3C18;
	Mon,  5 May 2025 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471032; cv=fail; b=dvJCFYjVxkmxXrhpGX9d9LRaVU29vYmANy7BVfemzrsYgB/NRSqpAu4kTAT8AbXDBUUOCYPgVoLCnl8RBwQqS23GimJNABDCUNiwOTkmPlT7Px/eE78IqDje/6aXPYmjKEAD0r+RaCwiHorNQ2t8G2Cvv5z1eCU+1hoaiRY0Xwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471032; c=relaxed/simple;
	bh=ignUwNDyjSU5aJftjS23GWWin6TAgMR4KNu+toUadtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ggzh3RhFUFLtdYhEarqj3L4aXoKI1irqUesghDf2Zr3Ge5UULZ3misXvxFuYSL8XGcTXeNfNKKTlwfL84+m4w2yzuSewsGIS1nr2317ad8YlUbZnoxsvsUY2N9ObusOqRAAJcUvczga+HoZc/vJR0Lc6JjLmQvGLus3PO5HkcgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5ClvcKG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A/n57u+Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545HY3dm013006;
	Mon, 5 May 2025 18:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O7T9kI1kNTowEtZ7sU5vhKzlPi276X9ePzC0D2XV8CA=; b=
	m5ClvcKGODQlbDy0W0j98Kuwrsn7TUYb7lZw2jdxIZfqWEXZO6pY7KhAGgI5DGqJ
	fpV95xa7470dJgh43u+dvduO3s0CFtvxInKPwqJVPNoR+CP5qqEdxXerPqhMO8vO
	YFmBwr2hbQihzOt2RaQ93fQbuacRrmzJn3rdEGBR3GgJFmoKsp/lGXR6nwKy/WRs
	eFWyKk90jEJf8Umnb0uWqYbn22yyKUBTKE5k9NktIxs9DY3rVTJqWtoewR+/b3XX
	n2ARseSMc8AqA5DXIlO35DBuFTsiTnnSK6ZJlfSNe9c4ketO0PCCY9tXgraJxqWx
	QrPMbR2AuJZQRqXX09mYTA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46f1u305f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 18:50:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545ITJLZ035324;
	Mon, 5 May 2025 18:50:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k82brk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 18:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0U/Ap6rqnBTy7xE/LcNDCw16Se9wEbCueWJnIkVlfwoovZm6jNWxpyQkKsQOQ4J+wYQRi1Z0RNMGd1wcaDHBQmMvOjWaoTUoZYBOlEUNMpNYrarBPI4kZdBMZBDSAZhvVkpNKnpBlw2GKanjrn1xv6okdfTgacsYQ/eyKixZZ8GTFK1ocEiAm6xr1ZBHy6kGXObP6T/U6d5ViIjQi3LKztCRD05wuwB8xnpBawsgaNn3xbxo57US6JBEWnYlKlKnfPw62Ugy8JMulL2nAriCJUwPXdDIYaBTIqvF0/kt50acxY63ZOrRRIA2ajIuSqCLt8jqdKngM1CgZ0nFM1v7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7T9kI1kNTowEtZ7sU5vhKzlPi276X9ePzC0D2XV8CA=;
 b=XYH1hpvWiAOsmsiLjaRkpr4JIOZZ3MkO+2t5UdDqAWkJxTSTmCczjVLK4YejxXnAdPt6Jb1+swKmB8fPje5BnpDpJdgD+fsy+7eKzggkmBhhX3mV+BrClbVUBSmOkz/p14taFMxxG0pDIA1o1Ilo+8JQRVECzNGex5KjSqKhfXWMLJZislgyNdQCnTHd2rHX44YHhGYT9QG0dGkUvbXe4XsHy0jHn79nastrhui7it6Op/+aOwKHeYBYFay1nbN7bQ7Tl3PC5m0L3a6PKCgqnaQwMjdKN3jejE2pILSv6Fllpnw0ChXDNeFLw/oMWxHfoA7srN+GipCOjXPQf5TaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7T9kI1kNTowEtZ7sU5vhKzlPi276X9ePzC0D2XV8CA=;
 b=A/n57u+Y1GlvFKdkyBzhWouZC0l3X8j+lkVRzNZWLI3K1nRHa6zCla5vN6PaaeF93hx4m2ZpoDdqfr9EqBOwr7Qo2NHc17hhvlArTJuAFLx7aq80AgmUm1AEw5tJ7YUDf6w32IMc3Cg+bbi2GVSnwkof1amQha12nErJxMI8T3M=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by IA4PR10MB8327.namprd10.prod.outlook.com
 (2603:10b6:208:560::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 5 May
 2025 18:50:00 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%7]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 18:49:59 +0000
Message-ID: <5735cb9d-86ae-4c8d-b0b0-5b0365843707@oracle.com>
Date: Mon, 5 May 2025 11:49:56 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
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
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <0bdc72c0-8f4a-4d91-8e67-f8d56dc26788@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:510:339::18) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|IA4PR10MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 12223088-4aee-4e84-0f36-08dd8c05a31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRxSzloYVBVZitTN2p6aUtpdzZnWTZzZ1RIVi9DcGpYamhKQWdlZS9LMXA1?=
 =?utf-8?B?NlcyOWNTZm16ekdFQWNzVTU2ZGtCcTJpNDJXem1KeDJTWXc2VGk2ZXBmRkJJ?=
 =?utf-8?B?ZDcwNlpnYXl0WWF1MUhmUHpuRVVlak5TeWtNUFQyNXZ6R2x3bTNuNHEyZVRO?=
 =?utf-8?B?U0hyQ2ZmQ0Y0b1NOMi9aZkpLMTdpQUt4RExCSzI0Tmw3Q1pabWpqdXIwZ3hR?=
 =?utf-8?B?aHVKdENFbTBiL3B1MXpGSXpvT0d2RWxjY3BUMEtPNVRlVnJ1ck5EVzU4bW91?=
 =?utf-8?B?WGNJOFFIcCswbHNIdEZPNU9pNGVhMHYzbUYxREY4TVFoRDVGMEtpdDF1M2F4?=
 =?utf-8?B?NzJzSzhVbm9nMGg2YmxzVnptSGw4RDlDd2NYbHM1ZC9zS3VBdnlZSk9FeUVR?=
 =?utf-8?B?Qis5WkZUb3NHbUhVTzVuRWZjQjJvaDNCNWh0RmJnZ3M2Tm1HRG1TWFpQWEt0?=
 =?utf-8?B?dE1wd2xUMDFhMFN0SVZuYTd6YUhLNWVCUmNGL2V4YkZ6em9wbVRZTHkxQjdI?=
 =?utf-8?B?R1Nvb21pell6MlVSUXQ2MGEyN3g5R3U0RnJnS2dhRGNzckhrNjBUNnFqN0h0?=
 =?utf-8?B?OUY2UGg2SXFMWDFRMzVJQUplNE1uZkxOck5Qc200bDE0a1Q2dVlaZW03RlJm?=
 =?utf-8?B?bTdWcGgyVkRZWjlhWFFGeHAzeHpyZTNqVzRzLy9VSHYzSzZMcHZSVXVSSFFU?=
 =?utf-8?B?d0dBSFo1RjRIOXdYWjVwdWVEa0xPdHppa0tFR08zUlFqUEp6WDdjdGZhd0xy?=
 =?utf-8?B?aE1GdEJ4ZlRZT1BxNm05MDJEclJlRDJYTGx2TFlCckpJVmhWV0JBTGhHMUdw?=
 =?utf-8?B?d1ZMeWRvZFgyVFF0U3VEcmVuQ1NjYmtFcHdvMlUzaHVkOTdXMFNZSnU0bjIy?=
 =?utf-8?B?QnVKUUlRRGh2OVpPeitsVm5BSm1rWU5GUHhJU1l4eCtDN3dEWGZibzdKU2Nv?=
 =?utf-8?B?Tk45dVlBT01JSFR2Unh2Z3A0VDVDdmkzV1cyZVhoa3c5dFJ1bEJOWUIwK3Fh?=
 =?utf-8?B?blVuRUtaMkNvd1dla0hxaXJiVVZQa1JwVnlveU4rVlFNcnNmNUJ3TUtzOTVx?=
 =?utf-8?B?ZXpQdElEVkorZUdnMS8yR3B1ajkwNDRtVHZzSWo0MGxCU0xkZ1VHODFRUCtK?=
 =?utf-8?B?NGhTZ2d2amE1U2pWVmJhY3BLOERyOXdkNEFxcVU1RnVTUXNiTUJtQVFLeHkr?=
 =?utf-8?B?am9ZOXJCM1dlY21veWpDQm8yblc3TXRJZFViWnVRbHcvdTRWRmt5ZkZzOTEr?=
 =?utf-8?B?L2pRSWFuaU5WNGpiS3UwTG1ISU1MWWNHMzZnTEpNcW43eTJJb3VUR21oeitn?=
 =?utf-8?B?cFBzZjhRWmtGbmlSM1MzeXJXRWJFQnNuZFlBcWxKa2NERjM3dkErOWNLTHh1?=
 =?utf-8?B?U2pGaGJkWDI4ZlduK2RIUGRCZzRmUEdMbWhoSlgwYXkyL0pKRWxwUk5uMlpp?=
 =?utf-8?B?M1FXWnFFTHRES1puWXhYeE84NU5iWEJTdkFibmJacFlVNzIrVG8wY09HMXQ5?=
 =?utf-8?B?K0Z0TUlOK1ZLeURicXZnZjREeGxBNEJWbEF4Ti9maXZzR1ZNZkxuQ2RmaGU1?=
 =?utf-8?B?ajBFNld6T1hiWXdvNWs0citoekVTang1S1RwM2x4MjNaK1k4aUZuMlMvZDlB?=
 =?utf-8?B?bm1aUFlNNHF3THdNQlJSdUpZaFhwYytiaUhKeVhwOVcvZ2haUkwvOTMvU2pz?=
 =?utf-8?B?ZEJORXlaUFVXNFBmSjllZ21Sb0VDK2JTN3ZlZWIzL29aMWx3dW93aGhMUWhK?=
 =?utf-8?B?d3VwRUVuVVlYSUVhQ0h6MStMeG5IS3ZtK1lqSE5ZV2E0VG1RYk5yQ0Y3Nlpp?=
 =?utf-8?B?bVRhTGJwU1NFNTlTaEdOU2U2RHpzTGlRbGYxbHFwOG5sTlIrbjV5KzhPVWdy?=
 =?utf-8?B?c0Z1U2N1UlJIRnNIYjBSZE9ab1VTVENGbEZvMUJ2c3JndVpMV01leEZpZ0Ry?=
 =?utf-8?Q?0zSM4FewzcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHpuOWNHb3Q0Y3Ezc3l1c1lTRTJXcnVIM0Q1UE5RR0pPTDhja3Y5cVFsTUJw?=
 =?utf-8?B?MU5Yc0JEeVU0bG1ZMHZMSnF2VkQzanNmN3RuUG5hTjk3eEl2ZXcrSzlmNnlh?=
 =?utf-8?B?RmZnbjB5S0R6STJvbG9DNDQ1SHpwRlhOa2tFZ1ZLbzdFL25CMDVzczNmcHhO?=
 =?utf-8?B?NFl3ZGJsV2gzaDJJaFhmdnRWTmFQYXlTNXRUMTcrRTJUTGpSeWwvRURKSTlv?=
 =?utf-8?B?TDVmeWsrUVlqMWNzME9ObTZWQk8vUmVLTGE1a0VvU3dWTmFISU1aQkJYQVl5?=
 =?utf-8?B?S1ZMd0NBaFpXNGQ1YnE2cGxPaURZdURpd2xGekEzRWRZTjZCVjc0Wmd5SHJv?=
 =?utf-8?B?YVlRREEzam5LSGZpWWhhc2M3WCsralljS1RSL1kraW8rMzk0am0vbldpZVdt?=
 =?utf-8?B?bXJxc2ZpZ1lqT2tVcGdhajcvOTVQc29RSWlsVWpJRXFhZVhzMUV0V1VvckJh?=
 =?utf-8?B?dlhxTXhpS0ZuOTZDWVdNZWRMaURtbklnMko5RlRxcmlVNmZra1RabXcyREEr?=
 =?utf-8?B?MVlLVUhvUWIyWHdwaXcyamU1Tkx3TWpFN1R2eUJPbkp1VDV6S04zellGSGFC?=
 =?utf-8?B?TGt3RUNSZFJiYUNORy9nMXlHbVZhRU9OOTBVQVZpc0pubGVqMll0d0V0NlRx?=
 =?utf-8?B?cm81YjZmWE96VGgrazU0LzJtc2t2OTJsM3EyZFpQS2FBdnFoRVBodTNMSW9R?=
 =?utf-8?B?N2hiU0NtMTdrQ0xtdDY4c25VcDNsZldYZjdhR3BhRlpzV2hYVlpkRmdjQnVN?=
 =?utf-8?B?VFpBZjNZSVZSNmZNdDFNSHNuS1pjQXRrd1BlV2Q0Z3ppTENHbWVzTTNXcDFD?=
 =?utf-8?B?dENYN2FlUTE1cXRZcUlYTkFhTEVtNlE4REZ6RWNOdFNmT21Lb2JhdE9OeUsr?=
 =?utf-8?B?RVNhcVl4MTJWL3U1YXhXU1lrd05QOElUM2hVUXBGdDJMUkUyRmQwVjJ5QjVE?=
 =?utf-8?B?bkJROGJOaExZRnIrRFJwdzdiTGZVYzdyNkZJNzU1Ri96cGVNMkVNUnlFalJU?=
 =?utf-8?B?TGtWaU5yV0dxNXF5cHBLTFEzNHBrRWx4bWpQQnh3ZGRlQXdQd01Eb3pGRHNJ?=
 =?utf-8?B?b21OYmpQdy9sOHdlSmVZODRVeGlTTUFxUGwyVFkvTUtJNzZDczcrSWh1MVc1?=
 =?utf-8?B?T2NjUFNwS2NRaHdrZUpwN1ZOTGNKTGlHbWRWV1Jvek11cGhidDlQTVVsL1pU?=
 =?utf-8?B?bUgwTTgzSVhpWXY0Y2syMHhQVExvRWpsR1JkdXZHbFhIdTZ3ZmVPbHlVb1Ix?=
 =?utf-8?B?bUpjM29PM3RrQk0vc1RZUStiVytxTmNXK2syQk9KY2NJUzhyaDNaRWVYa09t?=
 =?utf-8?B?TVBoZUlFOHhadCs0Y2RwOXlleXFyT0pwaTg1WUszVzNmdndjQXkxWWw2WkNL?=
 =?utf-8?B?NlBCYlM3bWF3UmxTU2Zmc3czKzZtSG5OZHZQaUFhcm0zdmp6YVQ0K1daME0z?=
 =?utf-8?B?ZmY4TCtaNUV3bHAzNm1zQjhJRDY2ZDgwMDZraUZlOVViT0R4YjZVaWkyOHdu?=
 =?utf-8?B?andtbHJySDd0eUxZUUR5ejBvNm1sNit1cHNFbkdNZjcyZnAxVEhkUXdMUUR1?=
 =?utf-8?B?c1ZWc1FLNzVNcjJXbERFdTBwN0hzZlE3N2UrcnRTNGN3Qy9lakxSd2pPc09y?=
 =?utf-8?B?UXBZTVhkVXBuV1p0aEZCWVRqaHNwS0hwM2FxREk1VlJXRDVEa2d0Q1ZMcHpX?=
 =?utf-8?B?cGlFb1J0OGlRN0piRS96V2RZNkNNLzNxV1IwSXRXc3pWMWsxdFdYSnlGRTFJ?=
 =?utf-8?B?ajlQemY2WkNhUUxEZzhBMXZ1Vk5uaWZlRGJkNWhzSXc3SnZuemRhelRsalFa?=
 =?utf-8?B?QWtZUG9ueHpGSUpKRUhCOENEYk5UTUNsRmw5WTlCVFpCa1loNS9LY1hjbEUx?=
 =?utf-8?B?Y0QxQW1rZ1RsNE51b0k4eTdpR04wdHZVQTZBSTFqMGtrNlY5SzhCL245SjBp?=
 =?utf-8?B?SnpXOVQ2UGs3TzB5aXdFNDdyUWt0Y0RubElUMFpYV1U3aldlR3YzRDR1Y3Uw?=
 =?utf-8?B?UHowbGdzaGJMWUUyOGVzWk1MSk15RjN2ZGNOSFJ3WFVuSk9NVEttTk1DdDBY?=
 =?utf-8?B?NUpCVEw4VEpieFEyK1BQL3NCQ3RBSXdLWGFjOEpHWXFrRUtzVUtRa3U1Tzdx?=
 =?utf-8?Q?Q0QnsvinDmVGPcLD5biwn7eJL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2akN8v+cZJ8DQx/mI6P1Nv+QRZVg1W/oz08BXtB9rUYm7stwtdL18aLxS87oc3xgivBkDf2JxyeeZD8ECHlmsFkUzPlN1CvjyoyfaFFTK4qwrCFqsXY0lV5zxDKH6SjoF0MjcTT6W6sa++Cxm8XmUiUIuVrG5g2nu5QklgqkYzSFwxibCkBEgbxp7zzF05ulC+b48J9+vyTp3ZhIGxBYxL/0xHL8caY96EqtnhQcXsu0jCDFdxyE1BMrzto4Q72lFX/PnPcG1gvOJqD2AjvMj08YfNCshN6uEZMYKm/ZizKJDdKbkx9IbcPAE3MGeZeJ30r3WBbhBaEcYnMRL4U6bSpBlA3mINHOC5ux0Bq7shxiMO471Z+vwTBAUpTNag7H3f3PEwpzXAVXoUlzSBh/pbX65aYyTtCFxgG0RLoIQQWQdILJ2kFQpe2/5g03XhMYD5pGFDvghtX68Mt0zn1pQhP7D1ysmVRHAyn8GOHH3pEOJCwIh9VgqJ1QSiPL6Hr1GzZev5JH/8FgoEhe4+jQExQgMgOx8KVY+K9KCRfw6xJveoOuwYgQWLTZBoB62q4Uz9xEzqMJoob7Dajy0f3akLBpJQnbm5CRB2+3aRzgd0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12223088-4aee-4e84-0f36-08dd8c05a31f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 18:49:59.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtTlLAB96HABdfmUj2QpB0S2PE9vbm3UAw1LE8vuoyxVUT5XkssL0fCwqCJq9VGQtCISuwQwytA3Depj57GGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_08,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505050176
X-Proofpoint-ORIG-GUID: kwrEOI7NaOYu-2-aK94T_IYePq1x0DU9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE3NiBTYWx0ZWRfX3vKH5n7ow9YA 0X+wv3XfQgeCyHXYgddvuZNcpPlXv+gIReeCmepNcI+2FqQSD1BcGNOGWlLYcOzaFD1G7fZfsCm TiD/mCeUq6vnF7+Loy85sIjsYPbWv80x8n0/hfFUSH+CTBORyJpIxhYMnegNRm3uLtIBEz1w/v2
 UJQIusUpd3gsbbQ/rDEOP4Tdw9gmYlbxdlcV/UKfGZ9wfCfkyTU9qBEMH5sPA7HOB3bnlC1B8Us 00egdb0e1ZAloIG0MHY6Jy/NBuVcMuIJVEmTAYhAgM51sD+HtOFKHFR40ta0lGJVow7oiVhlV+d DemXItBnlW1tuv6ZE6KbbHh4hDSwz8+Yy5OagHUk+JutV518V8nQe4dHiue5igMwgmZSwzOmnYb
 Ase+xIXDN7HhTIKt/YXAHzqSxHVFjGGMkdBM/6zvwG1m/nRwWfkvVEcdmRp5QjXq7RNOZ+Pq
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=6819085b b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=OA0HRqR1MKBNbkBWOHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kwrEOI7NaOYu-2-aK94T_IYePq1x0DU9



On 5/5/25 11:27, Chen, Yu C wrote:
> Hi Michal,
> 
> On 5/6/2025 1:46 AM, Michal Koutný wrote:
>> On Mon, May 05, 2025 at 11:03:10PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
>>> According to this address,
>>>     4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>>>     49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
>>> It seems that this task to be swapped has NULL mm_struct.
>>
>> So it's likely a kernel thread. Does it make sense to NUMA balance
>> those? (I naïvely think it doesn't, please correct me.) ...
>>
> 
> I agree kernel threads are not supposed to be covered by
> NUMA balance, because currently NUMA balance only considers
> user pages via VMAs, and one question below:
> 
>>>   static void __migrate_swap_task(struct task_struct *p, int cpu)
>>>   {
>>>          __schedstat_inc(p->stats.numa_task_swapped);
>>> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>> +       if (p->mm)
>>> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>
>> ... proper fix should likely guard this earlier, like the guard in
>> task_numa_fault() but for the other swapped task.
> I see. For task swapping in task_numa_compare(),
> it is triggered when there are no idle CPUs in task A's
> preferred node.
> In this case, we choose a task B on A's preferred node,
> and swap B with A. This helps improve A's Numa locality
> without introducing the load imbalance between Nodes.
> 
> But B's Numa node preference is not mandatory in
> current implementation IIUC, because B's load is mainly

hmm, that's doesn't seem to be right, can we choose B that
is not a kthread from A's preferred node?

> considered. That is to say, is it legit to swap a
> Numa sensitive task A with a non-Numa sensitive kernel
> thread B? If not, I think we can add kernel thread
> check in task swap like the guard in
> task_tick_numa()/task_numa_fault().
> 


> thanks,
> Chenyu
> 
>>
>> Michal
> 


