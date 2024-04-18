Return-Path: <cgroups+bounces-2602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72A8AA5CD
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 01:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60207B214EB
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8CA7172F;
	Thu, 18 Apr 2024 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhX6OEk8"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC405FEED;
	Thu, 18 Apr 2024 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483034; cv=fail; b=m6+GbMmeJ+G/5snztHq/4/NLHW0MdJGyaxUqbi49OTaBrsL/axveidq4N0uw4sVfMFc2I7Nb07Hot84bFt/Ac5cNyA3AzLb4DDHvxfqB6lPN0Us9yCYpUuRFRW9IH8atADQp0woLnb+tl04jBpiOFx2lDqlaolatCC2Gvv0MRZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483034; c=relaxed/simple;
	bh=O8hV6foiXK0K++IRFdut4bERqx52Br2bKHO8V6Kl5TE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bf6TyDJcF4jHvMKZHaJaeUP2+C/6zOF86xYF2XPE0uAE6nEy5TV5Gc4lm1fVXxTSIWYAx5y3VANvjPvDa/7OBsIRF1a0ZeLJv9Ko2fXE1603keJXnPFBNa0P6xbJaBWVVwbbIM/bzqcTuBu0SLj+KBFnDmNoR50eY7h1oteClaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhX6OEk8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713483033; x=1745019033;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O8hV6foiXK0K++IRFdut4bERqx52Br2bKHO8V6Kl5TE=;
  b=ZhX6OEk89U8pmB9PShk6S4VSjzYuKI6N/puwdLJ/8y6iBZITE5OlHTLR
   18eCh5N4TmzG/7hgWm5QWy3kq6TxmUNvYZ0d1nbIuKGqWfxFwwo+qEI9F
   PpjhZXs21p0uksgl0CEldUTgiWxZIJw6HmAFeQhyl/KDT1ighZSJCA/T2
   F0oDFdws9NsC4HyF+QA7dnrx2l+IWkUsCCJmgtUjqN/YV449ELW2xnNFQ
   yOnKu6y+D9MEphUAYIOohw6W9pqNddbm/+m7cqBMA8Z2CfSAysMPNrRZF
   42QT9d6MjiXO3w0QjxjncIlCvTztB5b2silYIDsFD1yXroonRVzrprFof
   Q==;
X-CSE-ConnectionGUID: h1ytyDRrRgqWZgLMHr8dpA==
X-CSE-MsgGUID: s/SkIpGASnu0uTlahJBChA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9191257"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9191257"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 16:30:32 -0700
X-CSE-ConnectionGUID: W0BQbGVKRfObLz0FIIJqoQ==
X-CSE-MsgGUID: NK960GmjQ8uMexdfvnUQsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23201003"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 16:30:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 16:30:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 16:30:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 16:30:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 16:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQuAvw2ME/KgSaC8gyYI+8J61uzOqXMk6Np6EIEXr+GO0ZB4II8uNWYD4lTQmSMwjYbOTPb5YrAC7tEx9SDuNs0cVDXpNUkUhX9QxLGN4CyuwVtnpFRNU4cmDQafZfsLhdGHa9FJ9r28vHFyJKkT4ElwPaf4m+KyVLZvxdq3LYTxxRevnIa+YmzqiwbpfjJLD0/0/44o7UoUCmErDjgEMNyRaYqow/wSLvOUpydabUvNXXCJJyH33EpXxiLqz3fnArCVVP2ONZeu1+G8yPrGizUwk97H5FVQ1gLAy9epffueIhAiGclC6hT3/r4kmcDDW0jU0Nsbe7GpaR440xi04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsGj3VAGnfeq7+uYgCBK0QNLuE0MmLKDAzHxEzPpNgw=;
 b=CvS12HO9zObiOcXL8opfhZwfAI3hwpki1hizLkakU4Z7E6OslnElmwYbKS8DjZ3JcX2GndDxlkZFYw2ojOAOWehcvWsQTSw1iQWSXyUO1LgRfeVuP246ytJBFcgZU5RhnaOiJRrPqZWZsFyIy5eSB4IPnCsinAmuZ6mum0UNUXbi6GSmXIoJ6EaqNkH8TmB8M05BV8oFCy2roU7/H25eJI5y9mwpbp46NMbe7LmyoSsscIpZmX6WH3yJsnYRMUQBp4UTbugC7xQUJBg6b1nzYeAt87c/wnwEM8AA6HBMpO7sByEEd/Zj5aIxMzvg6qYmadmWgeizaHEw03lSQ+eNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.30; Thu, 18 Apr
 2024 23:30:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 23:30:17 +0000
Message-ID: <d401e7a1-44fa-44b6-9c6e-c0abdabd5111@intel.com>
Date: Fri, 19 Apr 2024 11:29:53 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
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
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-6-haitao.huang@linux.intel.com>
 <a5e009636c5144622e0a910a459cd9d05976715e.camel@intel.com>
 <op.2mf3ykfswjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2mf3ykfswjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CO1PR11MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: d40007af-4ec2-4f23-6ced-08dc5fff81c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yl5xOBLsLh06cDiiqkgxwxegshUMLuke1bsGggtB6y98lLSVybePw1IYxZympQTC+fxT4WQBu/9EQGxR5LLF04crjNo1e5z83yZuLKtiWFVu+GVkoLEIL6IXua+MULY8tH8SQ/akxIIUaO0p86PkPqCz7JMLvdeeBEfJZTAmH78SByvI5COrslCOxg3TM4brw6H8eIKWb1MxT+RDA+1AXJjJsukM9UBerM4nIRYQWl7sGEj4FdP35R5WNzloIFbjxdYLP3onlBOq5rk7gQCmCSyODQAiKKfY4tgHlKp+HossOwz12X0uFQVSdiQkwoxKIlrBp5uwDKA9RXr2BlGGyOt1PnYay8CjvEWing7tGduA9BW3lyavqeVDVSvn8V13u1Nwm9aQzr6tOSWHCZpmN+3bkOQlp/wp/BADvVR8pdIMoa2o3q/ZxWIha2imhtMfn8/ZZo9oCkOH3vZjxf2/OoBWJ1rvpiuMxkoJSPQt7qLA7nJeNJuPtUl6BzVLIxc2v6Kr9ej81+G8Iy7EkZ0D4h3+kTK/NwY2DAzuuVZtgDrXOpCYnCJUZ2EGk0W5UluPd4IdbkSVNaptl6GQTvZLCID1b3Snq7olSCfBxiorZU/nTW0VAKW/2eMA5l6rYC/I/puJiZhtbGJJG8umN1gSEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzZoNE1XTGZPWEg1c1l2cGlMTjlnY0dxUTN0dEZyQk1pUjRqZzYwT09leTFB?=
 =?utf-8?B?N2dxUHo1Q2Y1dS9YSkgwYm9QVzZJenBCcis3SCtQNktVV25MaGRleEZiQzh3?=
 =?utf-8?B?NWJSTjkzcjhnMmV2T1ArNytUZFpsMHZzd3U2N0ZkRExNb3Y4bHlkcWNDTDZB?=
 =?utf-8?B?aFJ6TE51VmVJRUxIbDZpZ1NsSkp6UnNqTzVFbmZETFRTejZjaFFKOWFvb3hH?=
 =?utf-8?B?UjIxb20ycUxybWw3bHEvNEpZUmR4U0hjMGJ2WUZEdTNpUC9CY1lpa0ZTSHY4?=
 =?utf-8?B?L3VJNWozQkpZUnpkaFZxTGFJU25tYmk1QXRkTURXUGtlNUl6OTlvT2RsMzI3?=
 =?utf-8?B?TTNseFhJL2xjcE41TDFxZG4xSkN3SWFaMTZsL1N6MmFZZ1NlVWVVUlR2VFg2?=
 =?utf-8?B?T1oyUmhoQUVvY3BTWDcvRnJCOElBQkgxNExjZ29vMEJHdUJvcDZDY3JRSXVN?=
 =?utf-8?B?OFZlclR5MytTTmc1SytiemRkMHcyOWhDNVd2cVN5WG9nZTlpeFlBWDFicysy?=
 =?utf-8?B?YzEwRFprRHJFcTBHd0VmaTFKOWhsL2FBRGdjbjRpTUdLNWF0N3VpOVZXY21Q?=
 =?utf-8?B?Vmxkb0F6c3d3TmlEVEtiQXhrT3NhZkFkVDRBQTlhQXk1Ri9aS3ZpTXg3TWpU?=
 =?utf-8?B?TlA1RE9TYjMrOWhCSHVQdlJTamtKZ09USUlaREpjMStTV3J4cGRuaE1aZlFO?=
 =?utf-8?B?WmlxNHdRaVhlSUtiK1hSWUxGZVU3UDRnTG5WUnFsSStPZEtHMVdWeVNFTjBK?=
 =?utf-8?B?cy9mVjNHeFVOZTNld1I2SGdhRFp5Qy8zNEc1WEo5ZWF2SDVLUGU2VnV5M3U3?=
 =?utf-8?B?dHN0RytOUXFNZWZzOUNEOWFTQ1IrSE5kNXF5OGlZc3Rqc014aGNCekRlb1Fn?=
 =?utf-8?B?dEJZRnRGOVFZNnVFYjFBU2hkQm9oUkhsdUVreDYvdkhjZHkvZFFUQTFHZFVD?=
 =?utf-8?B?SElNdHEzS3gvc3FrbEp2dWxnZ3VodzgvY3BTNm5yZTdRWFdnaC90WXZpalVG?=
 =?utf-8?B?NFdSN2g4TFp3QW1tdmZrSVp5ZSs4cDArYndEVFEzb0p3QUtkOU9yaEwwRVFY?=
 =?utf-8?B?dnN4aWo4Zm9USCtpZE1OemN1TVQyRkxDQlBHakE2cmxBenk4dWxqRThyRmhO?=
 =?utf-8?B?Z3dBSnlUMXh2NmVNc29EYjQzcHoxRWMwMlRpNTJ3NWVqZHJ4VVNlbUd1NjJw?=
 =?utf-8?B?bEVEbXJGenBPTmR3UW9JcnQ2cGFsUGZvSkNWNUZwQ0RlZDM1alhxa0JOODh5?=
 =?utf-8?B?dE5VKzBkTWE2OWhHRnJTbHcrOFEyNld0cExmdmlBcFNONzl1Y1c5ektQaWk0?=
 =?utf-8?B?end2Z0RkajRXbTVYbytNelAzWlJvalpqQWt1aWY0dDF6Qm4zdk9vY0xlTGdH?=
 =?utf-8?B?OUM3czRNSVZBY1J3bVJFWVU2anpaWmxQRWNDT1NHWmRaU0l4aStWV05US01Q?=
 =?utf-8?B?NDd2VllwZlpna1hJajVYQjBWRGV3VHovcytIOVphS0RLR0tuTVlpbXlja3B5?=
 =?utf-8?B?M0R6SXBQK3ZuazRyVFRHd3FKQkJPcUlaa3ZPcHlzcjNtWFBBWEpOVy84NVg3?=
 =?utf-8?B?QXlDdXhTWWRvSEZGMjhSWUwrK3VvNG9KUnJmZ0lkbWVJd0RRM2dRNGhpaXd5?=
 =?utf-8?B?RmJHZ1RhM2JiRDJjemRVT0pLRVdTNGtWbVFENzZmTk1DdEVrSTRyZHNPcG0r?=
 =?utf-8?B?OXRFUEJaZVBJWHRWdEVibEJlcWVJelFzUlFGWk9nVXdGK09DU3RzbllGbGU5?=
 =?utf-8?B?Wm40TUlmWDdISVVJK1NmS05vU3FqZEU3eXhodEk5aE1kb2lIVjZweDVvWEM1?=
 =?utf-8?B?dXZnZmVaRlh3cXQydjg4ODlXY1FCc1lXdi9Mb0JmUzM0S3FRL1BGMFlQejRj?=
 =?utf-8?B?VE96cWUvb2I2Vk91Q2M5bUJLZ2x1K21RSFptcWhaQ0tYSXRGQ1pXQTlDRzA1?=
 =?utf-8?B?dWRDZHJnUFFLUWs0S0twbDd2bzBPTmU5MHNCWXpVNUxacklnVVNsWWJVRW9B?=
 =?utf-8?B?Nml2TTk1eU1JQjNzUGxVbGZ2cCsxRnd1R0JtUW56aGJKRCtUQnV4UnJLTHNJ?=
 =?utf-8?B?aVpScGpvR0pveFE5cUZWTUpIT2J3dHJGc1dEV0c5NlBJYkROcEczUU1ieG5q?=
 =?utf-8?Q?BvRAdzE6K++3a45l4bP/GLRu/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d40007af-4ec2-4f23-6ced-08dc5fff81c2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 23:30:17.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bOoIfDFT0shuCeyvZn8QSBhwt44rhL17oRkY7iInKL/6stN+gcgt0Hmb6Bco/7ecESA1jUNGnyrB529xGiOkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
X-OriginatorOrg: intel.com


> Was requested by Jarkko:
> https://lore.kernel.org/lkml/CYU504RLY7QU.QZY9LWC076NX@suppilovahvero/#t
> 
>> [...]

Ah I missed that.  No problem to me.

>>
>>>
>>> --- /dev/null
>>> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
>>> @@ -0,0 +1,72 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _SGX_EPC_CGROUP_H_
>>> +#define _SGX_EPC_CGROUP_H_
>>> +
>>> +#include <asm/sgx.h>
>>
>> I don't see why you need <asm/sgx.h> here.  Also, ...
>>
>>> +#include <linux/cgroup.h>
>>> +#include <linux/misc_cgroup.h>
>>> +
>>> +#include "sgx.h"
>>
>> ... "sgx.h" already includes <asm/sgx.h>
>>
>> [...]
>>
> right
> 
>>>
>>> +static inline struct sgx_cgroup *sgx_get_current_cg(void)
>>> +{
>>> +    /* get_current_misc_cg() never returns NULL when Kconfig enabled */
>>> +    return sgx_cgroup_from_misc_cg(get_current_misc_cg());
>>> +}
>>
>> I spent some time looking into this.  And yes if I was reading code
>> correctly the get_current_misc_cg() should never return NULL when Kconfig
>> is on.
>>
>> I typed my analysis below in [*].  And it would be helpful if any cgroup
>> expert can have a second eye on this.
>>
>> [...]
>>
> Thanks for checking this and I did similar and agree with the 
> conclusion. I think this is confirmed also by Michal's description AFAICT:
> "
> The current implementation creates root css object (see cgroup_init(),
> cgroup_ssid_enabled() check is after cgroup_init_subsys()).
> I.e. it will look like all tasks are members of root cgroup wrt given
> controller permanently and controller attribute files won't exist."

After looking I believe we can even disable MISC cgroup at runtime for a 
particular cgroup (haven't actually verified on real machine, though):

  # echo "-misc" > /sys/fs/cgroup/my_group/cgroup.subtree_control

And if you look at the MISC cgroup core code, many functions actually 
handle a NULL css, e.g., misc_cg_try_charge():

	int misc_cg_try_charge(enum misc_res_type type,
				struct misc_cg *cg, u64 amount)
	{
		...

         	if (!(valid_type(type) && cg &&
				READ_ONCE(misc_res_capacity[type])))
                 	return -EINVAL;

		...
	}

That's why I am still a little bit worried about this.  And it's better 
to have cgroup expert(s) to confirm here.

Btw, AMD SEV doesn't need to worry because it doesn't dereference @css 
but just pass it to MISC cgroup core functions like 
misc_cg_try_charge().  But for SGX, we actually dereference it directly.

