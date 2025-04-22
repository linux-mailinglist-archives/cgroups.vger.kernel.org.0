Return-Path: <cgroups+bounces-7738-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35CA97B00
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 01:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E607AB5CD
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 23:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99620F09B;
	Tue, 22 Apr 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG7cVW5p"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571B1E1308;
	Tue, 22 Apr 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745364490; cv=fail; b=sx1b28OqJOvjPcLnWYx39CrF7sRdcX0/bX77TeBB1lK/O7aQIMwZgFime670VCp0Bbs8mIIBBwa4xE6ov4iIzKHT67LWkAMlVIz6xW38fQZENmHOynBg63dbYYrIsGEKiFlEgnpMRRLIrPc3++FqsN2OZJmFYiL6JhuNe/UMW40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745364490; c=relaxed/simple;
	bh=BaubxdhZwiwuI+GW/aA8w7E7n++Z05/Cqk7GhMnjC6o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htysYWbLd1ViB4sNVn5LZJfLpeCaG5BPpiEM+ykVn9zLN99j6tVN/cFvdChLescPeGugJQIVvV3c5xRiexIXhQmFvLREtE0FG7kofGnnZlqppINZIcNkGeFSJ2ltfrU4F0RW+h3CzucNuO2iKOUf7MC1ST4dQOhxeocvYd3WApo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG7cVW5p; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745364488; x=1776900488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BaubxdhZwiwuI+GW/aA8w7E7n++Z05/Cqk7GhMnjC6o=;
  b=iG7cVW5pnaIq8PvZSuGJ4JlUzj6JWj9Kk6j5Ev+NVojtxkQde8NmMkyi
   1SNDJpeKzAB0LzE89RksKmAiTEOBPxfZ2jqK0/BT812JDjqtGfhdU3qMV
   Gk81BbSfk0qM3n7wDZJErBb69y8nFGH1gMfbRimLogq5HoEN/q6XgPoX+
   0kbS0kfQ4BAQfW7hADZHiDnniMfUgkhs85Nj+dLLNnQ3plTHUZzRUllVf
   d+G3L1y2IcT6941xfuIeyQOwpT/NxwW9AtWHn+pAjc3e1yUAcvvt+54Xg
   VedOYC9c30TP4wFNfAtyv0NQuVC8xkqAF/qTa822oT1XdrYbDSxiuV6h3
   w==;
X-CSE-ConnectionGUID: AE0JwjbpRQ+gK4ABk7MR7Q==
X-CSE-MsgGUID: 5y+ov9/wTneLBCaT1U+wZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="34556370"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="34556370"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 16:28:07 -0700
X-CSE-ConnectionGUID: dV67U02eRCmgOk0HN7xTLQ==
X-CSE-MsgGUID: 9UBIqoIDTzaBxy2Q/SZX8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="132687670"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 16:28:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 16:28:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 16:28:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 16:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNJBKFfsvg1tYCQuo+9Kc18WvL3sP7S4ecKVo+41VdJ1Y4ICRMvpjkNO9WB0gA6yCfZKFmBAzZOkFcZ1kWFpvwTRhvIcvEzqJbYYvZB+6OZiY/2UQgppMT2kgP2U8Zi8OVWnWZaB594gUuNZ0aIEFcFVlut9sjatp+KSNSARvBtKetoIm/SCsuU0oQnyJTFy8hPIZaFZh1GDHL6NPsyrIDJGEY6vx2oj2tC8xoSLLqPgOhN0TVN7HbF4VcMSCylprLDpNoArddM2mSTG+AG1syM2kGW2JEpS1sVqWyrR1McgmTyL4LoitcjNihTLilW1H3PhYFnEIHWHTh/7/aQ4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0AuMXgOLhr0vv5RaB4IMtzAP5bDKixPRsCLu+K+w5I=;
 b=RyOtSs2vvUyK4FIRxXrfvWWZRMBv0EajzjEckztgk/tsbOECLocCULaYG5Qji6QOQy1kYU3DBjnkVxaw21ENOL8PzcvCtLcXEMPuHY9Kh1j0wcJLdfoVQkzTKpVE/dFToCc0RTy9VAPiEFq8OpiImEwzvrQQq50l31lvRBPPuEW4Wfl0+6ivnZvQ+6gUrEc9kzfCiSWxZZZEB125cQzoNt8ydMcnT9bYQsnkh19Me8eKo3W+gXfZYx0sccGkWqG6QM45Nv8btaknKwJk53jXoSQKqoqv/t1G+vcD5YEqI9gPZUAKaGG0YOijonJT69O0HF/jT+84UGeIFpoea70Orw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 23:28:02 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8632.030; Tue, 22 Apr 2025
 23:28:02 +0000
Message-ID: <b3661d40-536e-4a07-8872-7c5ae5e1166e@intel.com>
Date: Wed, 23 Apr 2025 07:27:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sched/numa: Skip VMA scanning on memory pinned to
 one NUMA node via cpuset.mems
To: Libo Chen <libo.chen@oracle.com>
CC: <kprateek.nayak@amd.com>, <raghavendra.kt@amd.com>,
	<tim.c.chen@intel.com>, <vineethr@linux.ibm.com>, <chris.hyser@oracle.com>,
	<daniel.m.jordan@oracle.com>, <lorenzo.stoakes@oracle.com>,
	<mkoutny@suse.com>, <Dhaval.Giani@amd.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <mgorman@suse.de>,
	<vincent.guittot@linaro.org>, <rostedt@goodmis.org>, <llong@redhat.com>,
	<akpm@linux-foundation.org>, <tj@kernel.org>, <juri.lelli@redhat.com>,
	<peterz@infradead.org>, <yu.chen.surf@foxmail.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
 <20250417191543.1781862-2-libo.chen@oracle.com>
 <244cb537-7d43-4795-9cb6-fc10234c68a1@intel.com>
 <2ce24cae-12fc-4a28-8396-c5b46a5f76d3@oracle.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <2ce24cae-12fc-4a28-8396-c5b46a5f76d3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::32) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|LV8PR11MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4b99e0-4f6e-4450-e455-08dd81f55350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2k4aW42S0ZkUThnRG5lVUFCUDl5RDVvN3ZSWE5uRkU5dmtuUFJXcEF1eUlY?=
 =?utf-8?B?Vk83SlpnL3Z5YWhCcWtBWDdmcTlIcVNKWGRRcnJTT0VzRWRDTGYyRE5HN3JF?=
 =?utf-8?B?U2R5dTVJUXM4Qmh6a0hyOWJ0U0tJSk9sU1FqVEVreFRlRUJLajdKSWM0d1hp?=
 =?utf-8?B?VEVMbTNDM3k3OXd6MGJmaThxSDhRcURTb1JHN1JBZzhwSDh5VWRDMDVxT2pw?=
 =?utf-8?B?bU0zQUcxRXNDa253R2F4OTdyd3RvR0dseDcwNi9wTGRDc1hadkRpdnpHeEFX?=
 =?utf-8?B?YkIvUUR2c3dIaHVNWE82QUViTkl5U1N1K0dLN2lYUzJOOGdzaUFMMXJqMGtp?=
 =?utf-8?B?WGhqU1dTRjhYY2syUGJOaGJHVUJhUkVEUlhpNHM1R0tMd1NiemhtczVMdjha?=
 =?utf-8?B?QzEraEtkMDN2ZEhsQ1hnb0JiaFNKRHBLRTdJbXNvbW9MZXB2UlMwR2ZScmhj?=
 =?utf-8?B?RG5jdHFjYmpwaTFWQ0tkUXo1VEpDQks4OXFwbGFwTk9YSzJqbTNXNmhpNmRl?=
 =?utf-8?B?SnczZXVTREFOMElpWlZJbkVIaThCZzFiemNmaWFiMEZEOGg2bWx2Ukd4N1J2?=
 =?utf-8?B?eXpUSy90bEZLM01CM3lxdXhnSHE4bGNBYkF5bnFOYnpGeDQ4NGY3UExaWWRH?=
 =?utf-8?B?clVUUEE1RU43RTZZb1dkWXEydWxaM0prd2Y3WmRvNnFxdm9MZFdyL3dEKy9O?=
 =?utf-8?B?WjFDRGgrbVlaNnV0QXI3R2poZVp1blZGS2dFRDdjSmRWWjJpY1JSSmdXNTNL?=
 =?utf-8?B?NHAvVGtsTGhEbStVK29SS3ZxU2UwbmxuMUIybU5keUJIc01tRFRqcERHWWdm?=
 =?utf-8?B?dlloZElOdVpoSitUV1JVUTdURzRCdmZ1MkJLM3dpK2lPT2t6dzdXQ09NRVhS?=
 =?utf-8?B?cWJNZ0NrVjJnUzllTEhDSHQ4YkZjUEp4ZE5iSEhscmpvVVViNDlGRTAvMTk3?=
 =?utf-8?B?V3MxWU5YMEtIa3FtbFJ6MVd5TGRvR0luS2lHbjhtTHlsa1ZhZm1jRUJBOTdI?=
 =?utf-8?B?aklNeUliZ1JMd2tvMmhoRmtIdm9XMHorSXZUMHoySHhoelpPenA4cUFBYlVp?=
 =?utf-8?B?SWRzTThWY1NFWldybEtlQ0dZS1M2TWZvL1hTOTVIbWZkYlh4dERSVTJrNU5Q?=
 =?utf-8?B?OHFrZnVVOWFLUXI5ajU1WXZ0aWN0Nmg0ajRlT1B5V3JLYjRacDZFS2NlUllV?=
 =?utf-8?B?RU5lMVpTcEJ0YlpPUFcxL0FCZFJqQVlCYit1T0dDZFpFMVB0ejJkUlRTOFdy?=
 =?utf-8?B?T2kySGRJWFZHekRhLzJ4MFEvejVRWTljcU5ZWjJNcEl0YytwaE1iNmQ0STN3?=
 =?utf-8?B?WGhYODVpQVJKMVdNVm9iOVoxUml0Rk1Lamp4NXNnV2hqdngzeEdPT0JrSkV3?=
 =?utf-8?B?bVdONUJvUmdVOXJsNnpOMzZtb0NsaGJGQWNpNnlScFdKczA4WGtZbUZaeUlM?=
 =?utf-8?B?cUM4Ymc3UHBucHRzUURVT1RkY25HRnpNZEdQdVpiM0VQU2wyTGNHdU9CRGNq?=
 =?utf-8?B?VlpGZ3NLcFoyZzBiYTdQN2N5OTVQTnduL2R0ZXJUeXFMQ1R4Q2pIVVdCcytL?=
 =?utf-8?B?ZkRqbmUzOUhpQm8vYllLbWpTZUNObEJncmh4UDlwMUpTRE45NVBqenM1cXoy?=
 =?utf-8?B?elZWckVGUGNucndXMU14NVNlZjZlMlNqR2lNYnhLenVVZzZNVUlTZGNONmJl?=
 =?utf-8?B?WU5xcFhJdFZlczFTQ0FkWGVPRjQ1NUhLOXd2Zk0yWEJxVFo0VEZZbVNkalkv?=
 =?utf-8?B?TVg2UGR0blB1MlVyKzhtVDNNQWt3UkhxcHNzSlNYTTRyRnRnY0NlTmdabnA4?=
 =?utf-8?B?QVllbUFKdTF4VE9JRTE1NjZQSUE4ZjFGcUQ2MmtnQVZMRU1xdTNQQ3cwV3Rq?=
 =?utf-8?B?N2pIY1JIUVI3WXAyZ1YwRDYzcG9pT010Y1VCbWFkNTUybXBBOTBaK29UbGli?=
 =?utf-8?Q?hzOgC3xria4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTl4cEw1cnZaajRUcXNWNE8xYTIrVU9BdU5GSFRVWDF1OXZlQllaRjd6UXNW?=
 =?utf-8?B?dHhYM2dNODFnRVVqR3dsV1JUMWxlMVJwcFBaMkxZbEZtckJxMjNSWnZDL2RY?=
 =?utf-8?B?TnFjSWJ5NmlvZVVkSTZEWGloSUhqUEFzTldOZ01hMGxVVndPSi9Jem1OMGJ6?=
 =?utf-8?B?M1FSVWpSbnJjSTRpRWFBaExxcjd6V0trYnlDUnZ2Q1FZa1F3WkhBTUlaajRi?=
 =?utf-8?B?aHkwRzhGWGNESmdwdW03c1hvQS9MUWIzN2o1ZUVHc1lUWGVnTFlEQ0U3a0Zh?=
 =?utf-8?B?NFlOQmJFbGV3WGg5UUlYYzZCd2FBd29iMzBhZS8xT09ZMjc0eGhtY2NkbjFl?=
 =?utf-8?B?YmRYSlNGK25ZMzNkRDdLRFFRZXg0SkZyMTFGUHFkVlpTOUFyY3RET0Z6VmRa?=
 =?utf-8?B?OEg1R3R3RnBGNjk3VWJPZ2xjUHZKaENjcG0zQzBkdWxGSHdCaEhhdzVCcTFx?=
 =?utf-8?B?b25IbGc2VldoRjFiOXY3N2EwTldyS1VDNFV3djFQNUdZWnFTUG9mRFBYQVRy?=
 =?utf-8?B?S0pHd21EMEdhTlIveloyZWlVc29oRy9zZGVTajZJQ3NZbXlMcGRjQlNPcHFM?=
 =?utf-8?B?OGYrR0gydlFuNUp0MnJEd1JYWTFsTlEwR2JuZWVzZWdWK3lIbkRIZ2plT3Zt?=
 =?utf-8?B?amN0cVI3MzVQMG5zTWF4YkJON1ZuNFdTUzdZVUF6aUszejdGOWdKWG9CUFJB?=
 =?utf-8?B?TW9aak1uWHJxMTAvQldoZWtVTGdmbmZKendQODZjRi9sQ20wdHp2OEd5cGlE?=
 =?utf-8?B?WXNNN0JpSkt1TjM2Z202UVpGK2xhOWtNVXNXcmxXYXdSSjB1SERKZFFxNk1x?=
 =?utf-8?B?MjJXUUhKWi9nbk9RN3FObzU5S3RpWUxhODJUTzlTbVBCMnZvY1hZanI5Ylgz?=
 =?utf-8?B?RFdqb2VzcWUwQVFyZ0VOT3loSk5UbEJTNlBCYVIyWS9UNG1kY3V3ODlueFc3?=
 =?utf-8?B?QnNOWHRBQ1ZOOURCWXdOQlhsVklyKy9kOHBrbGVtMGJpd0I5YXpOOU5hdUp3?=
 =?utf-8?B?NlVHL0tYY3VJaXVSWHF5RGkvWXBNQ3lCdHhETjhWcDVzd2ExWmpzWjFNa3NP?=
 =?utf-8?B?cllHdTJjWkQyOWNvdWhoOTZnNk1lQUwwZS83aTRWdUI3eXN5OVg0U2hWZlcw?=
 =?utf-8?B?aDBvSlNOaWF6UmdxcnpZTkM4OGNkaktjcVJoZnRQZzVTNXg0YUVpYkhhMDhI?=
 =?utf-8?B?a2FOdUM3Mzd6amg1aWtPSjlac1ZDeTJqQ3hEa2RGTkZqeCtvZjVkS25TbWR3?=
 =?utf-8?B?dXFBMlpGZ2d6ZTN4Ymh3NVYxSmkrd3FpRWFBczVnS0paUEtrQXk3QzZKZXlK?=
 =?utf-8?B?dVRIVlpIb3dteHU1YzAvUUJoZnNKSy9vMTFIbUtBallyMHdSWHhPd2p6REwx?=
 =?utf-8?B?RmNIUUlVZnNkZWgxMTJGcUMyWGg3UW01ZDE5UXNJcURNcnNEU2JhbFU2dkNx?=
 =?utf-8?B?OFozNDFhYXhsMlI0WWZDNUlkb3lOSnk0SHBpaDFDbDJsYm5yTFNEYU1kL25k?=
 =?utf-8?B?QjJjVzhhbjA1eFlwZnhQRjBrd3JJOTZrUmxxNENYNmZYdkdxN1Y4UFlxWXhM?=
 =?utf-8?B?UHVwdEp2dENhenBVVTJyWUxFejA5NDJIcS96amZJdytXYytIV2R4RU9mSDFk?=
 =?utf-8?B?M0RKZG9FK0N2UFA0bHBUMlVrcUVNZnJEQ0JHNlVRNjNIK1loWUY5QmZGOFc4?=
 =?utf-8?B?ZkVRUlZGMDhDbFQ4c2huUnNKQ2hGZGVzMlVpUC84WTlRcVYxWWJjajZNVXpw?=
 =?utf-8?B?Ylo2SWs5bGJwVmhFUFlkemplQzNhUjJYNE14YkhFbE9DaE9FTmdUNWtFRi9h?=
 =?utf-8?B?dmRhR2VQNnRWUEx1K2QyeWpBbDJaZFNwcWZjdUgvVFRDa1RqVTM0bERPTHVJ?=
 =?utf-8?B?V1RSS29BZHh2aStHT3IwNCtuQU8vTkF4VHdQQ2lxRzF6V3YrRVBpQzhBQXd1?=
 =?utf-8?B?a2FrcU9BL1RpSDM0WVZpemRjMFlQbWt0Ly9UaFNLQXhrVFNYS0YrWWtBY0wr?=
 =?utf-8?B?TDI0TFdYdEh4MmIrZjFXSzUzMDNDaExXcUE5TW1qZi9WSlg5NnpmUTdSZkpi?=
 =?utf-8?B?Z3lvMDQ3VTExSy9FRTFySlFYbHRuMWtnUDlVbTA2VnlEY2VuTW5qR2syNnpE?=
 =?utf-8?Q?YJc4rrgBO+iXhaHhGxkx95R/8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4b99e0-4f6e-4450-e455-08dd81f55350
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 23:28:02.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1boi+bHfP1wlAwqZx4+EJ97vx58Z++3fcApwtgMRk91n2GyiCH1Efep+IV09dpzMG37pfreDrRYT/0tuFuR2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
X-OriginatorOrg: intel.com

On 4/23/2025 6:20 AM, Libo Chen wrote:
> Hi Yu
> 
> On 4/19/25 04:16, Chen, Yu C wrote:
>> Hi Libo,
>>
>> On 4/18/2025 3:15 AM, Libo Chen wrote:
>>> When the memory of the current task is pinned to one NUMA node by cgroup,
>>> there is no point in continuing the rest of VMA scanning and hinting page
>>> faults as they will just be overhead. With this change, there will be no
>>> more unnecessary PTE updates or page faults in this scenario.
>>>
>>> We have seen up to a 6x improvement on a typical java workload running on
>>> VMs with memory and CPU pinned to one NUMA node via cpuset in a two-socket
>>> AARCH64 system. With the same pinning, on a 18-cores-per-socket Intel
>>> platform, we have seen 20% improvment in a microbench that creates a
>>> 30-vCPU selftest KVM guest with 4GB memory, where each vCPU reads 4KB
>>> pages in a fixed number of loops.
>>>
>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>>
>> I think this is a promising change that we can perform fine-grain NUMA
>> balance control on a per-cgroup basis rather than system-wide NUMA
>> balance for every task, which is costly.
>>
> 
> Yes indeed, the cost, from we have seen, can be quite astonishing
> 
>>> ---
>>>    kernel/sched/fair.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e43993a4e5807..c9903b1b39487 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -3329,6 +3329,13 @@ static void task_numa_work(struct callback_head *work)
>>>        if (p->flags & PF_EXITING)
>>>            return;
>>>    +    /*
>>> +     * Memory is pinned to only one NUMA node via cpuset.mems, naturally
>>> +     * no page can be migrated.
>>> +     */
>>> +    if (cpusets_enabled() && nodes_weight(cpuset_current_mems_allowed) == 1)
>>> +        return;
>>> +
>>
>> I found that you had a proposal in V1 to address Peter's concern[1]:
>> Allow the task to be migrated to its preferred Node, even if the task's
>> memory policy is restricted to 1 Node. In your previous proposal, only if the task's cpumask is bound to the same Node as its memory policy node, the NUMA balance scanning is skipped, because a cgroup usually binds its tasks and memory allocation policy to the same node. Not sure if that could be turned into:
>>
>> If the task's memory policy node's CPU mask is a subset of the task's cpumask, the NUMA balance scan is allowed.
>>
> 
> I guess fundamentally is this really worth it? Do the benefits of NUMA task migrations only outweigh the overheads of VMA scanning, PTE updates and page faults etc? I suppose this is workload-dependent, but what about the best-case scenario? I think we probably need more data.  Also if we do that, we also need to do the same for other VMA skipping scenarios.
> 

Overall that can be a future work and I agree for now this patch is 
simple enough and feel free to add:

Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

