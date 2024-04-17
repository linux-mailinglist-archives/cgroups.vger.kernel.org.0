Return-Path: <cgroups+bounces-2566-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5C8A8FB5
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 01:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107A81F21812
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 23:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF4126F11;
	Wed, 17 Apr 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlnNOOPC"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC72BAE2;
	Wed, 17 Apr 2024 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397907; cv=fail; b=uiebe2lhi0nLnnvSW0TlWIDGsugOc5+PluLzYRcHwMNDBC0BPz6KiqQ0sozH/WNerq0Fr+bo9X0jbeJCYDqF2AjCPOIkauEIW544tZS4Fs12hJ0Kk5YfHeHC24MiLUyE3fOfqb4kLRBXB7UE6XlwGb8iFWnDUkKWnUFGas6G6wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397907; c=relaxed/simple;
	bh=CdZzSm3wAPQxMhLgfxN7rXwlqT97VQob0z7JiUv6VBk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NBVvP+li3iTPd/h53obhBMPfB5mCFJoO+odRRzJyqVVlBaWY8z4b9ksBVdYmM2biahSDFV4gUkck2/kD0pke24sjW+SR9Q6Thdl12ks1oF4Bdnz+VjMK+8rXTScyKjnGT2bvuOwSwisSL870NvsHWJ7Ixo4MxKYpYW4pmqop3Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlnNOOPC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713397905; x=1744933905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CdZzSm3wAPQxMhLgfxN7rXwlqT97VQob0z7JiUv6VBk=;
  b=UlnNOOPC2wMWMvmqCj+xJWrlg72EDQCJyvXlq2qj6GdqrQtwyygO3n8m
   T7Nj0jK/TanSKNzPbGdQOQz93D1ZQHi4681AsB6XXITqiH1g7ajmtaT2d
   OzvIOcjZdhiinX0idX5RsvRuJZsfVq3rT1V5ocKR78NL5qh/3Fg23eBtV
   ZdSaUbkxfIwUru+yy0kDM1sFBp3o4qI201dAIQDBXPnN5PfX9EByk28uQ
   SdcgxPHx3MNrYubqN0zlGKidMEFPTAUu37Qdk9ZFBX2kib72HRTkekzFp
   XvvMY9hlsZX5dJ5/Mt5Y4VEnYWm4hZKyjLLmevFjXiuP+XACG8Yfgu3FD
   g==;
X-CSE-ConnectionGUID: +b+oULB1Q7aS6SaPgHOr4w==
X-CSE-MsgGUID: M8IoB6aAQ9eFnwEGSvBd/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20309862"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="20309862"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 16:51:44 -0700
X-CSE-ConnectionGUID: Rw9d4rXiR4aFpgvwt8g7iQ==
X-CSE-MsgGUID: PO39g53dT/qdzVQxhP37CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="22793256"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 16:51:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 16:51:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 16:51:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 16:51:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 16:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laBRB4C2tfKsnrs3FJBdzIcjBZGlLlJjcKkGJvLcej1ZQnR4+GQuWeVE0+mFYTcJWNcWADBtu0lP7v82gXpEpwTU0MftSe2ceQDd2iuF1al+8J/RC/XZ7GCxw8u21k9E04E1CYnrNYjdGAKWd3CHVZQGPMXLEpH/og44VISei0jofr/2oHC6dnhMDpkuAu8E9wOjHoQdUmlCbTvlQIIWxpURVYHlBm65ZllphT7WkwTTH1DaB+VP2HREGsRH9cIiQ4GM/duYLk0QdXfbQuIaB5Bcax4LdmJUKlhIrT8xYXPJk+5raqlGhWdEYKIfDVYjRy8hQfE9BBCfMsK2SpBjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOe1/oE8kG2Ny/U5gSew9+In+J2SRhS/USrG+6O9dd0=;
 b=n3VMlj+cq769ZchXh1a6uUSOnQfhfN6vCno2M5eR0omD8Ebz7Pj3pkmfkiVEleXLsCZDJzLGIMaMmz/ZP4979UunW1ZRI9xYRzEYDxhy2x8mlpdhJfRsGKrn8fyR0qEVcwu89nkZjtAuxRBGXAtzom0CcS+fpRGiaQj9y8HR8ONd9NN55DvmExgPBYZotvPx4I8vqQGuF9oDWTfgjpas0ibr9S8PbL0fzLRMoKZ9D6keqsR9nTdBm10SWl1b0gWA9MyhTKkY3INvQJgtE+0cPfoI29llYmUYDHLIwuIrVAU25zBNX4rxJIk8vECK7EtPTnVzDYD9v1jiqfalxrNJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Wed, 17 Apr
 2024 23:51:40 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 23:51:40 +0000
Message-ID: <8a9ae08a-c813-442d-9fc3-031a4c984700@intel.com>
Date: Thu, 18 Apr 2024 11:51:28 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
To: Haitao Huang <haitao.huang@linux.intel.com>, <jarkko@kernel.org>,
	<dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
	<linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
	<x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>, <sohil.mehta@intel.com>,
	<tim.c.chen@linux.intel.com>
CC: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
	<zhanb@microsoft.com>, <anakrish@microsoft.com>,
	<mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
	<chrisyan@microsoft.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-9-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240416032011.58578-9-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH0PR11MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f55cb4-09cf-42df-93bf-08dc5f39537a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvTqMUHAXTXAUCsCAad8qiL//p6tlJY3xs+Y9XCc+FsDCQ9ZMDe3VRIrMXlkCLzqqwm+CmLsXKbRdosSbBKR4UOWZtDhHPzL9olE41xQ6P1WorW/G67FN0xzuPKp3edaUHatJ7u+t7x+Y19rYOWNo3J8h8SRRdE5ZdjiiVs4Zb+vkYTWiw7BOz/je9ZDnU9Gu0NZWookGAn9GXoBPXYtE6LdJhivfOX7tKyU8fgip1I0zAgl2iqjs5U40WeIX+lyV4Fojsnhlk9HqwMfDS6xH95bKXYJGVVh/cKzmPPyqrmj1KV87vGWKO0Rh83wGrzzJFQGS18MNmdr//L0Y3i3AsXZp6soCutZafMInVQUTCkG9l6zZpsPN17AU+YDaIfyje2l+o9b4uVnLsC3ZZU3yjjxuxDf+/5Pm/NZQhTTSTdAsIKgK31d4Jiy7BtsgcyVrpUGQhVy0JfPFTFlRvkb8wMQkcWSBvN4QCh0d6/Gbw/q3MonWVZXUCpA8QYB5Axc7HaY96gCuaGPFOnhccEumKFZDPUp4dLx/gT0c/EnZGEafp4vDfLNb1CDs4WjOHnHWA6EdYUWQgI8kD9JyJEHpZ9m3QqMGaeH37MV2O99FthOfcbFvG0dpge5+hG+QncDQDK55HTbqa5mmIgQtEmA/0kNhR1vxdOgQI1U7zOm1QA4XZ3OU3DZyqnzn66XFa9wg8sqpIPyQuX3HFnaiVE6MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2pDbnVoWlBhR3g5Zk1ETWVPaCthNk0yTFBFckZGK24xUnNKeFVsQmg3bWJC?=
 =?utf-8?B?dCtMdGx1NTM3YmlZVDN2eXR3T1pjZU1PdVpGd3RObXR5bU52UXIwMEtDQk13?=
 =?utf-8?B?Z3JEdGtiRlowaW55Qk0wS0pEQTNDOXlyYlNEYlVQYytoMEQ2dkFIMDEzOFdP?=
 =?utf-8?B?YVlRaEdSL3l3d2tVVkdZcTJ0TlM4eDlSVVYvMEhuZXpSWmN6ZUxZYWpRUTJD?=
 =?utf-8?B?RTZhVTJ5VWNrc2tuTjNaQS9rTXZ3ZkgrNmJwNmF2QTcxS2JZTVZFSnYrcGsz?=
 =?utf-8?B?MUFnblRsNlFYbk4vUmlId2tPbTFjZVZrNlBMdmErc0oxZzNWWDI4c2p2Y0Na?=
 =?utf-8?B?bDdldk9XTjVQOWpmNE9KSlUvKzI2SUZmanFNbksvSnB6eW0rdS9IT3dHWjhu?=
 =?utf-8?B?SFN2cWYyekpTckFaeE95OEFWZzBQeVk2QUs5Qm5VVDJPL3JZOGY2Q1NqcFdG?=
 =?utf-8?B?bzVpcjl2RldRNnpCMG9wZ3ZOM2Zoc0JoN2doMzd0YU1xTFBUNC96Mi8yTWl6?=
 =?utf-8?B?RHBXUDBzMTBKWW9jamN4bTNIajAyVTVtdk05RDVvSEUzRFdYSk5NaWZ5d3JZ?=
 =?utf-8?B?WkpOVnE3UDU5RXpFemZqTXA1QVJhZXpYR1dlSzBNN1JwOHI4R0ZCWWlyUzZE?=
 =?utf-8?B?aWZJdjhjNkd4dnZjc0Z1MngzczM0T1NCUzJvTGJuUWgwc3ArNlR1MkZNWUdm?=
 =?utf-8?B?Z2lPU3VlelZhV0xDWE5VbVplTEdFaW9nb3E2aHhqMXMxWnZQZm5lWTZ6bGJN?=
 =?utf-8?B?MjBJVnljY0hYeGxKKzFJMjBuY2dlajNIOVFjRU1penVjc29xSGdPRmkrbzVi?=
 =?utf-8?B?Q3Fkc28rZ29uUm5oNkVhdHBacFNyNUF2bXdoMmdKNmtZNUFRMk5jak9wT1VF?=
 =?utf-8?B?Y0RlN1RORFF0Q3BKNllVR2ZPOEM1c3dhaUVacjlmYy93WFVPVmUwZGdCWE5C?=
 =?utf-8?B?Ylp5ZkFMWmxXYkYyZlhXeU9sK2NnYkJQZTduaWp5aWpVenVIem5FaTMxUjJB?=
 =?utf-8?B?U3E5d3VpN2lBZlpicU9Ud1Q0d2tPZXp0dVE0S1hIVlNiYTBzQ0R4RGx4RS9w?=
 =?utf-8?B?eHkxZjBLbjQ3N3Y0emN3UmpyRi9JQlVaQlBkWU05RTR4cElra0V0ckgrY0VV?=
 =?utf-8?B?SURhaTAzM3hINXhNRmZqR2Nia1J5S3FWU2V6b2ViM1B2K1crcW4zUkszL0d5?=
 =?utf-8?B?Y3d1Mk5UcUhEZXlqOVlkR2dtS3JGRjM5U1FlUXpOZHZEUTRpNW1qQWY4WFZR?=
 =?utf-8?B?azV5RHNoZU44RjFHcDkwSUEyaWhJNXRKWk1HMGx2b2lSUlRHTlpyNDlLcndD?=
 =?utf-8?B?bnpia2VBeVo4Y0dvdW1wMzNYM21pQVBLalUrbVVvOG9qNTUwYnM3RjJnWmRs?=
 =?utf-8?B?T29NTmFBTHNYbEJVcGhzRE42aWhjOU9hbkhCRlpZaXZKNDNQZXJaa0x6ZmNm?=
 =?utf-8?B?VGJ6TjVzQ3JyV0xXTU5odlBTQnJIY2ZmQXlDbUpnU0tlcDhSQ3M3Vjh3eTBn?=
 =?utf-8?B?MEVhZHdwMzNpTmNReCsrMUMwdGpqVllCUTIzZEVhZEx4TFNJTnhpYkYzMjNI?=
 =?utf-8?B?YnpRVXUxRVVmTWpQd1g2ZWhwL3B3eERTODk2MmpTUHpKRmI3Yy9lSDhBaW1n?=
 =?utf-8?B?ZnVFWEVpc2ltZXhPL3VyTkFPaHpuLzBrcTh6NzZpM0tNUE12Z1JQUnVFNjc5?=
 =?utf-8?B?SGFpWUtPRWpSWjJvWHptWWE3VzFPRnJQRGVBZnozcmc5VC9BL0xFVFB4eFY0?=
 =?utf-8?B?ZTVvTWkzZmlUTTVFWnI2cVRpdmxEc2lUYkdIU3hkanltRDg3QWJzZmtrSEFn?=
 =?utf-8?B?S1UyTHFZSGE4SGdGVGJ4NVVuaWVuQTlMeDYxMXoyT1YvbzgxdTgwQlNaRDhl?=
 =?utf-8?B?QWxRT21iVGpOVW1jNnNPeERrd01ZQjRkYUphODRIOGVQMitrVVh3UWxwaHEz?=
 =?utf-8?B?Sm9HN0ZLZGprd3FqVEhMRTBYMnRXUmg1WkVtb1dpd0pXVlhUbXQ4eC93dWFQ?=
 =?utf-8?B?ZFRSaUxxMUtlTisyOCtKa1dTYzhKM3VNdXNhYXhrZUtSdDQ3WkJ2amsyTDJi?=
 =?utf-8?B?ZXpFTVVtZW83Q0l5dUdDdi84Z0pkMXdnMUxTKzdIb2VnZUpIdHpXUm5FNUYz?=
 =?utf-8?Q?d2TTwASJTbsEBJvluW4UxcSM8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f55cb4-09cf-42df-93bf-08dc5f39537a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 23:51:39.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hhfr38oNHWrGN9FbtGCgqq4F6fN8k1Pu2cMPOnKaTQNJeiFxvjq+bu8UOxV6pBWkkCbHY49/e8n1uIit39UI5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-OriginatorOrg: intel.com



On 16/04/2024 3:20 pm, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> Currently in the EPC page allocation, the kernel simply fails the
> allocation when the current EPC cgroup fails to charge due to its usage
> reaching limit.  This is not ideal. When that happens, a better way is
> to reclaim EPC page(s) from the current EPC cgroup (and/or its
> descendants) to reduce its usage so the new allocation can succeed.
> 
> Add the basic building blocks to support per-cgroup reclamation.
> 
> Currently the kernel only has one place to reclaim EPC pages: the global
> EPC LRU list.  To support the "per-cgroup" EPC reclaim, maintain an LRU
> list for each EPC cgroup, and introduce a "cgroup" variant function to
> reclaim EPC pages from a given EPC cgroup and its descendants.
> 
> Currently the kernel does the global EPC reclaim in sgx_reclaim_page().
> It always tries to reclaim EPC pages in batch of SGX_NR_TO_SCAN (16)
> pages.  Specifically, it always "scans", or "isolates" SGX_NR_TO_SCAN
> pages from the global LRU, and then tries to reclaim these pages at once
> for better performance.
> 
> Implement the "cgroup" variant EPC reclaim in a similar way, but keep
> the implementation simple: 1) change sgx_reclaim_pages() to take an LRU
> as input, and return the pages that are "scanned" and attempted for
> reclamation (but not necessarily reclaimed successfully); 2) loop the
> given EPC cgroup and its descendants and do the new sgx_reclaim_pages()
> until SGX_NR_TO_SCAN pages are "scanned".
> 
> This implementation, encapsulated in sgx_cgroup_reclaim_pages(), always
> tries to reclaim SGX_NR_TO_SCAN pages from the LRU of the given EPC
> cgroup, and only moves to its descendants when there's no enough
> reclaimable EPC pages to "scan" in its LRU.  It should be enough for
> most cases.
> 
> Note, this simple implementation doesn't _exactly_ mimic the current
> global EPC reclaim (which always tries to do the actual reclaim in batch
> of SGX_NR_TO_SCAN pages): when LRUs have less than SGX_NR_TO_SCAN
> reclaimable pages, the actual reclaim of EPC pages will be split into
> smaller batches _across_ multiple LRUs with each being smaller than
> SGX_NR_TO_SCAN pages.
> 
> A more precise way to mimic the current global EPC reclaim would be to
> have a new function to only "scan" (or "isolate") SGX_NR_TO_SCAN pages
> _across_ the given EPC cgroup _AND_ its descendants, and then do the
> actual reclaim in one batch.  But this is unnecessarily complicated at
> this stage.
> 
> Alternatively, the current sgx_reclaim_pages() could be changed to
> return the actual "reclaimed" pages, but not "scanned" pages. However,
> the reclamation is a lengthy process, forcing a successful reclamation
> of predetermined number of pages may block the caller for too long. And
> that may not be acceptable in some synchronous contexts, e.g., in
> serving an ioctl().
> 
> With this building block in place, add synchronous reclamation support
> in sgx_cgroup_try_charge(): trigger a call to
> sgx_cgroup_reclaim_pages() if the cgroup reaches its limit and the
> caller allows synchronous reclaim as indicated by s newly added
> parameter.
> 
> A later patch will add support for asynchronous reclamation reusing
> sgx_cgroup_reclaim_pages().
> 
> Note all reclaimable EPC pages are still tracked in the global LRU thus
> no per-cgroup reclamation is actually active at the moment. Per-cgroup
> tracking and reclamation will be turned on in the end after all
> necessary infrastructure is in place.

Nit:

"all necessary infrastructures are in place", or, "all necessary 
building blocks are in place".

?

> 
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

Reviewed-by: Kai Huang <kai.huang@intel.com>

More nitpickings below:

[...]

> -static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
> +static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)

Let's still wrap the text on 80-character basis.

I guess most people are more used to that.

[...]

> -		epc_page = list_first_entry_or_null(&sgx_global_lru.reclaimable,
> -						    struct sgx_epc_page, list);
> +		epc_page = list_first_entry_or_null(&lru->reclaimable, struct sgx_epc_page, list);

Ditto.

