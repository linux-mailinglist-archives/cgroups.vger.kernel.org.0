Return-Path: <cgroups+bounces-2375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D689CE84
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 00:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F6DB214DE
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC26D1D52C;
	Mon,  8 Apr 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQmRv+5P"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C928389;
	Mon,  8 Apr 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615852; cv=fail; b=d01sqmiIc1r2NukyU3ozwz62jx7P6tfihY3x9kt7r0MAPUXrKcGHAGw65i3q+0SpBqWxg0v6DzhiyVFYKijXEREfoB5yKfCRgKaUw1oCz1tDWukXi6Gi3a4hEIkpaRQQDS944qq9MwXPOYtrfy6QByQDINgB9U91p6NvC3YrpmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615852; c=relaxed/simple;
	bh=CbjlbbmfZNd51ns/zJhNu8NuB6ObTzYxII/cqtqaIr0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JsfiovN4xKpbKLSZurx5iu8Xe2koGvMm4ET664B8m8M4SOk6UzhyahboVPrqtTnbPJUcHRLUa0xK/pbsrZ9Oky0C2d71PxAC6np/xCOKH7kznX8MZ13VdCgPhkPTmUgstIymk7i4mDr1zvR1eQhFNTeUpUxescwG1PcQj3MQ+mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQmRv+5P; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712615850; x=1744151850;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CbjlbbmfZNd51ns/zJhNu8NuB6ObTzYxII/cqtqaIr0=;
  b=lQmRv+5PceybBfuFcZi45WTrnieo98uQ7LdYo3wurWvh/o7MpX/V0zNq
   XlnUD/GRxP6wcnoxG/4BkJwTwTtUa3rJG6RrCbTzYL8F1foZMY50ME1T5
   tlnqtOCPnIhnXj/FtV6SJkjW3P/1nN/j1Bu5IIBbdsWGMoLkvs9sfKrgD
   odjLQianGDSTFZqcN2rWp+BwhXM5eJrNMRtcoGUaZLSII46CJxUeLTutu
   z+Q8kiprFJp3vRG7N14z3PLaGX2GCeLgXHXdVq2dImdTxEtSaHT7yySgb
   AlyVtoYcSfj1kGYqOVzuPyLnuR9g9lE1KaFAfPkwKwNjk55jSPwdkklWs
   w==;
X-CSE-ConnectionGUID: Von/4WuVSQ6hX4NAL9lErw==
X-CSE-MsgGUID: Ykay/jjfQii752oIYEOufQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19345834"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19345834"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 15:37:30 -0700
X-CSE-ConnectionGUID: IqQA/edUTxa8na7LuEaabQ==
X-CSE-MsgGUID: d/4lH98OQxWluJ1lTE4g+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19981184"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 15:37:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 15:37:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 15:37:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 15:37:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 15:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6U0iOB4cn+qpuvdDpnXO+CURNh77rgp6ydogVOKd6WUwKHur4kYvT37R81e8BXLobPhvCho3+ISfscRp0qQb6pF92Qze5zvX9sEKGF6K9vuAlpwoiA+Lax2/MVJKw6HAqTi/Irhsx6zRU8TlxLTudWmoj4gLJfEOsTKY/6p4//BdiqttxYXRyO2w21eHIDo8T/Z61n4BEQRPy7PEmPXKUSWljUh4frS2cqBxhl3YDExytJ17l5oNzAoskzHVmz8v4fJT1NiVpIX+daPeL0Qaa+xX4KiiMoZhq+X0hYb/9tbNAlhrZz0X9WJyiDStUWHX56mnu5uaXZ2ktN9FqeI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nqvVIRqHKbIK1yveqi3jBm0DFtrGyXvVsT4OnQIpfY=;
 b=KHI4qjNoWJD5UzXQDznDjflqxZZVZ8NWMSM/iZ615rYD2jbW/Fwxq9VsoWXTbQUzPyLwQ5FqWvOWNFZmVZ3YbTTMUOQT1p2hYeylpwiSFNCuNz8OCPmXOGdIBpRinOB+Dqd6wypAqW626+yKzThjQCMkRFd8DWZGmuPsx8QfbvaO4IaDAguo3BP5wpiesGo0wYjUAASykNMx30mLVD408Bse/din53kitKhAoXSKWOA5kWwJ6se74WdNf+ltVMcobnRbTm581X/K7JKlOlXJl3+gPisLNscKLqMs5de4x+kQUbrtydJPP+TTjMrEPGctGWIzJUSaIT3yg9U9UMC7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8548.namprd11.prod.outlook.com (2603:10b6:610:1ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 8 Apr
 2024 22:37:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 22:37:24 +0000
Message-ID: <7a21c0de-ba59-4e76-8d67-70957f9db581@intel.com>
Date: Tue, 9 Apr 2024 10:37:10 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
To: Haitao Huang <haitao.huang@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Mehta, Sohil" <sohil.mehta@intel.com>, "tj@kernel.org"
	<tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-13-haitao.huang@linux.intel.com>
 <d25dbe76d48a0b6c74fa09b06f1ca3fdf234a190.camel@intel.com>
 <op.2lw8gfg2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2lw8gfg2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH3PR11MB8548:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNTBH7wOJEEQIAoXpOaFNXFmLYVcbn4EnRW7wfRtbQkkYp0U5q3a9FcsEFMIVX8SNwUS+eo/Fe3Ec5W/c55UUYOCwsvg4KgT+3bMny4KbvyDYCAaxjeUL2pQvZCOl9xL7Jna4NzJWKedqZkOHCJppTL9jJUwfrkJn1v+vcVjdjx6+7PfkWzpDNVDH6MzZ1QNkeyr/qdudOB6KtnktRl6F6GgGBtRgfdB9vrVt0giCJ24p/ZSPa21ralYeikNH20XOCSy8cHi0C8ZGyEHmCxp+U/RRu8FETBpI3DTeCK4l/097Rk7X+LKGvlVwnu6yaUEIGcyVoLvbaItN06L5a8yKVLX56e2opodYFXj201Q+Gchgv3pQU69RS4EQgty8fQapS2K+cXO73m1nRSUaDDifxzZqntCPdndfIGpG3oME8gwX1BpcYDQytg83qBAcQsNwiPKpuaD1O5vXvZg6q2G5x71k40TQeoNKOC/eMD+Tk1RyHMzf446aC2kJ6pT6Zm29qJaX4gUNgKayTXY7iXxP9hOE3zAnKM3i0skBh34/sdqL+f65jWHqy1R4Qtr+nPDwoSiHkUhRCqfjWynHLwFFLBT7kcNJUdlJvTfoHwXA+dXps06QDBS0QmWNb4hi/sor0m8lOyEswGXIeVf2RmyoupwhiPeSMKlAM8cf56pMhvLi/ayYwEWQlK7ahhI6ZWW/aaoeGMUPepnwlIGtnryJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1N0NURDYmViS0RqajQ2aHp1cGZwcmZ4aEduTnFjb0g3THdzOGxxZVlURE9k?=
 =?utf-8?B?TGNwcmNjV3p1MmVVbGEwcVdtY1Q5SmxSR1hickpHOW51bkZwdUIraTd1MlFS?=
 =?utf-8?B?L2VuQldoWXExSnVmTEhoTWlvSHdkZ00rS0grY1Z4dmZyZ1QvVUxONlFDZlBs?=
 =?utf-8?B?NzVoVjhpWkFUK0prc2hOY2xFV1ozZnNQZ0QrUXloTjF3OVFEeHlQMnhmdk94?=
 =?utf-8?B?Qlhmb1lINURxWGZxK3g0MkxXUDZWR2ZpU3BDQStmclM3SHVLU1kzTmtsVXZk?=
 =?utf-8?B?S3hiRkNMNFlsaytzMlZtMlRSc1d3UWtRYnVKK0F5UUorTnRqQ1gzSDhlREp0?=
 =?utf-8?B?ckJoZ1VPRXR5R0pyTWN6M1Fweng2ZkF2cVFENGRHZG04dWFwdTJlL3FxdDEy?=
 =?utf-8?B?OWQ3bkxIaU55bVBzUENiNklXNzMwZm13UlJMV3ErdFVPWitVZHp0aklVM1FN?=
 =?utf-8?B?d05velhCQWY0MnBLVmxiM2hGd1FHKzB6NFdMZk9vQmVueHlLY0VadU1lZzlm?=
 =?utf-8?B?aFg2M3lCbisxUjdMVlhVZ1ZoRVBPbktScUxQUEJvZkVhSlIrY3Q3NWZtQTZY?=
 =?utf-8?B?SmxHc3VMTTgvMTNvWFRYMDNIY2hmbDBmRFNoUmhkVk1SZ1hqNnBITnNCc1My?=
 =?utf-8?B?aWRiM0V3ZTVRajFMT0RxRjZyWkVvbXlzR0VpYUtydDIxdGV3TmxlSXlzU0FL?=
 =?utf-8?B?Z1BTdWNUdHU3a2JPRUM1dXlOVnhJTS8zZCtVb3lHaTc2dDVteFZESy9KNW1C?=
 =?utf-8?B?Q0tWN1NlM3lRajZlY2ErandqL3l1WWFzb0dtUU9JZnQxU214VDNKZi84aFR4?=
 =?utf-8?B?ZXRoa3V1QWx2WUJGNXl2Y04ydGNEdnphSlVxT3ozallUWkZQY2QxRjRGMld4?=
 =?utf-8?B?UzROWEMvSVY4L3lvYW1ia0dxaS9uVVVrZDRUbDUrR3VKdlB0bWVhZHhSMm9h?=
 =?utf-8?B?SXl4eC9SVGdROWNJOUZ1YWRuMTBJU2I0ckhJSTZnTkRFZU84ZzdpTDd6U3RD?=
 =?utf-8?B?VEJ6bDZtUnMxcWdhQnUvc2UyL1hidFljaEJUeUZOZGVoeUtVTVVxSjdnOUE1?=
 =?utf-8?B?Zms2RG9ETUkwdUxrMytlUG9ZQ0RBQlUwaDZ6RXZSazNod1BFS2JwcXhXTU1C?=
 =?utf-8?B?a2VqZ3ZZSnpNL3F4VEl1QStYZExROTdXSFhZZmlZVnBUZTZLTVM3RDRIeWJL?=
 =?utf-8?B?U1VNYldvUjk0cjM0cDFmcGtRalZvMUhxM1pvWWhVeWU5OWxMUysvdFVhVkJZ?=
 =?utf-8?B?TUlwRzhwbVNjd1dWemhKcnp0YlA1b2Y3eW5JaWFuRGVjRHVNY2p1aTZnNEVO?=
 =?utf-8?B?SitGc0JXQ20zaHFIVTlUNkJHTjBUN1FvOFpuVXh1UlF6WUp2SEZKYkdWcUFz?=
 =?utf-8?B?ZEZwQll0K0pxcFdLN0kvS3Fsd2dGcGZRY3FjUmQxQ1hzaS9nZEdzOTc2YzVa?=
 =?utf-8?B?SXp4K2JwMzhrSFo0V3Exd2hiaFV1cnpxVThoWmpWZHh2WUJXZDJuWmd4OHdm?=
 =?utf-8?B?cVJTNFVtMUlQQUszNUlDczNQbnNORGhlSFpTRkpKOStiWHg4ZjBCZERBcU9s?=
 =?utf-8?B?U1Z2SmloQ2ZGYkZDM1VUVVpTWVFkQTF3VFdmU2hDalo3NEFBaFdjbHo0VHJN?=
 =?utf-8?B?ZUQwM3FYZE5yVDdYZytOeWRvam0vclZFN0ZzS0ZMRHNwbHl6UHp0Yk1jZkdW?=
 =?utf-8?B?Q1RzL0VqMUR5aHFhSUZSeFFmR21Lc1VORkFHZjFPOWdObGFGM09iYVExU1Vh?=
 =?utf-8?B?MGVicHhtMUs3UEVtMGhlei9iRmdaTHkwYlU3WWJzYXNDZWJHbjdHMEo1aWdt?=
 =?utf-8?B?Rllxc3VZUXRNKzVmb0RFMTgrUUNUNllMa1IvU1duRGVuaUtzcDFMOXZINjNq?=
 =?utf-8?B?N0JRSWkrTnBRa2J2QmZTU1h0Q0FLcVFFa2hicGYxYld5b1dnVHUvK0lUTGs1?=
 =?utf-8?B?bGc3TVA0WVpSVldMMXF6QTMyZmovNnZhb1FpR2drdFd5NUwrbVdFMkI3MUxC?=
 =?utf-8?B?aUtiZzNReTBqeHlCb2hxMU5lSXVyYytlMUFUR0F0VUlTTGpGWXg0bHRQWTdX?=
 =?utf-8?B?OTdLdDZWaUVFbDMxZys5cFZseTZEbnRYWFBCcVEvWFJwVExXbDBUUEU1NkVM?=
 =?utf-8?Q?lWzzcJYi+6Vh0bMWL6OBiCVBN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 572f6410-a821-4958-94be-08dc581c7612
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 22:37:24.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bukAWrsmjQLh4phC02ACvzzDvvmMjFN4KW7WEUjbxq4+KDaCauLdDFSd+S2rbC4Xxo2uardzIIlxIqszbmyv0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8548
X-OriginatorOrg: intel.com



On 9/04/2024 6:03 am, Haitao Huang wrote:
>>>
> 
> The misc root cgroup is a static similar to sgx_cg_root. So 
> misc_cg_root()  won't be NULL
> However, based on how css_misc() was check NULL, I suppose 
> sgx_get_current_cg() may be NULL when cgroup is disabled (again not 100% 
> sure but we handle it anyway)

Could you help to check?  Sorry I am busy on something else thus won't 
be able to do any actual check.

