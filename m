Return-Path: <cgroups+bounces-2722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85C8B6596
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 00:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82E52834D9
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223A181BA9;
	Mon, 29 Apr 2024 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip9RiSMC"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D22177992;
	Mon, 29 Apr 2024 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429178; cv=fail; b=JZTRSlfmmJwKPO9553DEq1owfcuXIE0xEZsMKspK5RtTHfWh320tCKvZXcc7f1n+czaAD3dnQnTetKf7rvInX77v1mIt16tIFuvh9xiR3Y7DaRyH+MPUywVW7Gd9Qvh2egYPf3VUMfu1woh+zzkRHQ8fxGec9P6hwnn3yX1588U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429178; c=relaxed/simple;
	bh=va20tlK4Nw/anwFh7V7ge633jtWa5g5qiVRXp6DArEc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jCrg7dKYas2sanPNrWTPGOZfcxm2sbDRYlPxNeQQT1frm6mZJWtyRXfGbpYXyBccMZkFU8NFSXTO1jphjtDepQk/fC22PkqW5KZy/0L5X01qeeS86s3egv8wjIV4eYlkM2wQjSa0nveYz9tC3zrXTVJjv4BpKQb69VaZdJdIcUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip9RiSMC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714429176; x=1745965176;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=va20tlK4Nw/anwFh7V7ge633jtWa5g5qiVRXp6DArEc=;
  b=ip9RiSMCF58bmCtzgLrGwIO/oMmty+QVM2EVbsyEE2uEvQe3SWLiVYY6
   qQEw6Q9Uk5Az5O5S3rNYyA67dxODTQ57p/JaCpvEehqKbhtdKvEgJq8+n
   Q57pZMtN85DHbFtjcP+/s9o7Ac/WHP2Y6WUPSb2Jo+uJZ6fA7CzhEcVU8
   u0lDgR7Y2fOWhoJs87FRxqzaKYyT0zBSuO+YexKyYy2pYSnASR5+KdXhr
   CR7GS9U5vZGwb01RQhzg13Rrxd5hq7oLnnBa/mJxZbQkLng+awsrdLo/W
   Nm3RND7+JUEHDUF/h5DxdGoaPxwJ7WK/77U08kgiaaVRN1tL52DsvNT6T
   A==;
X-CSE-ConnectionGUID: oaVIbAlgTGeTJwrUMvus+w==
X-CSE-MsgGUID: X6EZVEhXTsqTXoNUiHBN5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21262188"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="21262188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 15:18:28 -0700
X-CSE-ConnectionGUID: LAEweuPJQ6eY/IfaD8eKTw==
X-CSE-MsgGUID: qyBG2skcTpOGybokJjrWmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="30938040"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 15:18:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 15:18:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 15:18:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 15:18:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 15:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbnLyItjNEfIqJVEbodxkguScuJDU+ww91NmKm0oiwQZaaDAe00TqUI+4n5cwcZeSB3+eraOFheyb7QcomdAJUcrsuYS7GrRfQ+bvsYOy7k83f7jL8ly/E6aAdaLam0vQALh+buHFA+reWFzl976B7qXyyuBOcza7bNFznLx7nGxS/PFXmbXTEhJotdpTcT4+MklxAe6G7UtU5CwoDkpX3YWHUZyLEChl/dte93/K2ho8f0HqXZYkVq4GzgjvbcvvOjY5gyazvyn+tQgVUm6rFqLhgWGJwDFpkncgu3kkHK3FWC7bx/zIE4lpL48rJ7LPPnYxYe2PIwWZ9a2snsDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbCf9sqvL3uR597l6quNkdQvQWGZNZm7+WLcRX2W+Bk=;
 b=Ql3VuNCoD2aScPIcfSL+PxLIB4yNPlRitKEWTAW2RXKNKMh5QUaXag5oYHGQwIWuTZcyu5K4rcv5Q/wgKW0HHkbL+fdLDQcOls7WK67k6ODhEimJJ7OhgV2do4r/RZ1tX3DREm9rOtRBJbzIHBHBABB84dbkfbBCDD0FGd9b28kp75uW1BpDkNRJ7IH0tT74cBX9XhTuaUgGOgJRNV4AzR6AM4RhSzKiPuBs+sVE4vvxwUMcja73GrbICrvf24FMEzZBWarcTbgZNSZRJcmenzKFMI99fcBDdC3Xt3Ygfs8O3cikEs97Fwhdqbt4Qi8iic1fTUqz1dCptc/8zW+B0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6503.namprd11.prod.outlook.com (2603:10b6:8:8c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 22:18:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 22:18:18 +0000
Message-ID: <5836260d-600d-4802-9f6a-b0bdb19ddbac@intel.com>
Date: Tue, 30 Apr 2024 10:18:05 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
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
 <20240416032011.58578-13-haitao.huang@linux.intel.com>
 <524cf9b081d86ae61342fdfc370a3639d0010f94.camel@intel.com>
 <op.2mzyy7ktwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <op.2mzyy7ktwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM4PR11MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f208891-fd8f-42f7-c397-08dc689a45ec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk9DY2F2WjVMV3VQaEtWM3Y0L2tkTUhWY2tOSWlOdytHc3JJUUU4WTg0MVNn?=
 =?utf-8?B?QjJPZmY1V2szbkZ5aTJhN0Job0RrWWpuMCtLc0VjdzRFWFgyK2RsWnIxYzlU?=
 =?utf-8?B?M0VHdE9Rb09VREdrdWhmMEFYQ1A5OE5Lbm02RHNaSnFEc2l1dWp4bC9UQTRh?=
 =?utf-8?B?bTFKbmh2Q3dkZFFFYkhWMVp5VXhrTThQK3ptd2ZZR2dBSmpXbUQyeU5HUTRk?=
 =?utf-8?B?NVpSNzBWZmpCelNCZk5vckt1TW5UaGtqd3ZYRitJcm1hT1JpQ1pkTVIzMFQ0?=
 =?utf-8?B?aS9xWW5rb2VadUNGZXJvRzI1Z0pScW9mWVF5bzcrOFpLVEl0bzFVNk9nT0xT?=
 =?utf-8?B?QjNLbW54WVFEUnJPV01FU0U2MkFxSDhxVFkzMUhjOHFzNlkxV1JrWll4MU03?=
 =?utf-8?B?c3Q4VFR3U0R0TDFRWFh5dU1IOERtMFBpb3h4Y3VxYXFyT3E5ZWRJSlBxVzZU?=
 =?utf-8?B?TlFxVTJ6dEpnT0lnWDFyK2g2ZWdDYkE1L01EeTE2WlRBRmdUeGpnaG9UNCtj?=
 =?utf-8?B?TVhtSUFKM2hDYURjb0MrUEhhdDhpQkFRVlpGU1NpWVhJZHFPcm5VRjQ5RUV5?=
 =?utf-8?B?ajFnc2czWmJGbm5HY1JFRU4rVitmUjhaR1J4V0VITUpjRjNHRHlyQW1rTzV6?=
 =?utf-8?B?VUpIRWVJaXBodzl0UjJDMFYrdGdPdGJrU1l3NU1NWElQVk1zdVVMY0RNaE8z?=
 =?utf-8?B?enQydjlTNGhHQkFZajBLak9vY25xakNkK2F2ZjJJb2E2ZmJqY2UvWEZ5V3Vh?=
 =?utf-8?B?eUV4SkI5RXI1aE5FNjFjZGp2dTArdnFHejI0dDBQT1UrU29hZ0FEd3I4MzN5?=
 =?utf-8?B?OUY4bWVkN3JjcVJZZ1dlcWZaOStQQ3B1NTlUMUZPNDloYklscWlkcEIwMDls?=
 =?utf-8?B?ejEreXRvYXFHQzN6aGdodWg2L00xRkxoaVlzeG1uU1pHTzl0MVpGOXMwMjE5?=
 =?utf-8?B?bElqT1VzMW9pUWg0alVQRGFVTXozRkgyNEFTdjNXTmlFd2U0aUlLUjJvZUdV?=
 =?utf-8?B?VHBuSWdEUHBORTBXbnJzcmRhWDVnM0NPY1RyTWJmUXhGWDhXdGxEY0NLU3Zp?=
 =?utf-8?B?ME1GTXQ5endQcnZKdGJka05zRGlxQjJEeUdMaG1nU1Q0a1pzMTFFWFk3VXV0?=
 =?utf-8?B?WmJsNzBTRGNsM2xJdnRGQnhaSlo4aTNTTWdWZ0ZodzhHY1NPcGRuS0l6Vnhn?=
 =?utf-8?B?S1grU3pFUSswQzErckdmTGVPclVWTzJFSXowM2lXdTJvVlVoV2JNcWVwcEJm?=
 =?utf-8?B?VjB6NUwrSmZWVFFjZXVwU1VxSmxENzY1cy9DSEl3NnArYjBCUXloaUdlWWJL?=
 =?utf-8?B?SzZoVHB6N0FwZlh0V3FwNDBRVzA3c2FYUk9GZmFtQnlMazhXaFJnUzA1eWU1?=
 =?utf-8?B?ZUxBKy94SnF6bGZqcjZZa3ZwbnBVQ2RQQ1RWR08yWWxzT0hHMitvT3lKUlJq?=
 =?utf-8?B?VmhIV3ptcVJDbXg4REluSTNBS0QwNmZLUGxaWmphaExCVDFFUHB5eEVLVVpT?=
 =?utf-8?B?TkJ1WUttVzVCL21TTFRDMWFTUGJMd3l5NWxoN0xXSWExUTZJVDRxL09JSzhH?=
 =?utf-8?B?WHlNWjRXZUlpaDZHMjVYMGNSVmdrbWM5cUM4Wm9weWY2VDBpbVJtaC9OWDJr?=
 =?utf-8?B?SElvZDJPRFlrWFY0UWhENlZhdHRHeTFGcHV6RDl0bWxoOG4rYTVXUXVKSW94?=
 =?utf-8?B?OXJnYkhVNkJKdk9NRjVzVWVqOWM3OEJLOWFUWURTbTZ3ejhxSkU2cCtnQjRp?=
 =?utf-8?Q?ASXgGvWfRIjDAjm72W4EvqL1HEMrK1LfoD37CNv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVta3BhRW45S2ZGY3RnMjQ0a0hscEZPRktIWHhJMDJvaTEybUo4VE1OV25w?=
 =?utf-8?B?cFFsOElReW04Q2x3NFpDb0JqbnNwREdiRE15ZHFISnhOUzVBc0c4QUdjbUNa?=
 =?utf-8?B?V1VITWxQVFA5UzJsSkk2dXhCWVBjN281VmI3MkVNTzlhNFJHQkhOUVFTSm1U?=
 =?utf-8?B?b1RLRzdOTU9mSkF2bktjNjdXMDhET0M4dEU0NkZ4WFRBYTg2eVdWaFBVUmVU?=
 =?utf-8?B?aVBBQzVyOGppVUxuMlFDMnFhZFlsZStnbFVCYVpDTlZyMVBQV2UwcmV3T3lQ?=
 =?utf-8?B?aGlVanVYOGhSZys0SjBZRGZ5aFRRMDRJOXVKS1hKZXNJbmxDby9ZN21Vb0N2?=
 =?utf-8?B?M2FUSm42Y1VkR0tNbEsxcWJHWnZ1WG9OcHE2eURkdDhyelBwN29xOFRMTFl4?=
 =?utf-8?B?ZEJUUDFHNG45bUVmTS9EaGJ3dXA3ODZFQkpvTGVzTnBTOWVnbkZkQnhKNUhw?=
 =?utf-8?B?REFBVlQ3ZHNzdjRBUEZrakFzS1VzalNOV0FhRUZmUjYyU29ONktVeVVSd25I?=
 =?utf-8?B?TlduVVJkU09rK2Nna292Z2tkUVhYQzAvQXR2ZEZGVTBnN1lzM2RxRjFGR3Q3?=
 =?utf-8?B?MTJKWjduSG9uc3dibEdla3JGOG1KQ3RIbyt1Ry9wMEdDeW82d2NSUm15TEdH?=
 =?utf-8?B?UU45SjgwcStWaTRFakdPL3RXVkRDS01ZcGZwWFdNbDZPbnpCU2x6dkE4UmlY?=
 =?utf-8?B?alBjZXYySlVBNG0vc283SXMzOWhXRmpUYmR6UldrblgrOW1hd0FCTzFidzE2?=
 =?utf-8?B?aUtNeVBaNVNRbkt5QjAyTHUvbFluWVovRlpXSDdXeFZaSHNiWG5mcUQ3MlV1?=
 =?utf-8?B?UWhlNkZZWlB2ZWhYWGxDWE5MUEo4V0NiNlVIemF3R3BzaU9ZQVBQVjRmU2FZ?=
 =?utf-8?B?aXFiS2xrREFHN0xiZWoweVUwaEZ5REQ3c29naVdEWU1wc1I0QytLT0pRb0VD?=
 =?utf-8?B?MWIwaEp3b21SVDZRK2piOWIxYXhpSFVLZ2g0bjdlRDFPeE5LdVY3am5nSyt6?=
 =?utf-8?B?cE5pMzAvSEoxeU1vaEtSTTZJMTIwMHErZHZqZWcvZ0wrdy9MMHk1NVJKTEZJ?=
 =?utf-8?B?MkVlTGFUWTNGWWxuQURRZTBrZ3FRVjVFSzlIZkpwRTFTdFlUYk5CVHhYeVkx?=
 =?utf-8?B?RjVMOFlMK3lSTjY5T1M0Sjg3OU1xV1o4MEYxSnRYNFRvYnNJUDdEcXE2V0ho?=
 =?utf-8?B?Q2VWSEhoV25uQUxJdng1bDNaODQ3NHd5RlU0TFkvSU5ZdW02Y2pWQ3lBWkI3?=
 =?utf-8?B?bDdtRDZkM0VVZW5VQnMzaFpPSU9kMmpZSUkxK052UzFmSXF6RmV6a2FZM3JQ?=
 =?utf-8?B?dFFtOXp3dUN5S084UmR3Z09KYzJYVFJQRXYzS3N2Vm1qaTJXaFNDN1cvL2tU?=
 =?utf-8?B?ejNxOXN5bUJzN0ppN2RGYkFjN2N0MU5ZODJ3YkVkTGpvRTZUR1Mxb1dFclpl?=
 =?utf-8?B?QXlxRmJkYlhUd1BhNDdnT29FMy9oaEUwTTQ2ZCtYeHgxQ2lMMk00ZHJKWEJ2?=
 =?utf-8?B?K3ZOU1krL2ZYZkYxYmc5bGkrcS9EblZVOCt0Vkk5RWVlTTJwTHJZYnNKaTEz?=
 =?utf-8?B?MEU1dGh1OEpsOWdWRVFtc240QXl2eURlaDJaR0ZCc0ZQYTRVai9HSjJ1dVZM?=
 =?utf-8?B?RjBjeHhlL3VONW8vRFFpM3JKbjRtRWJ1V2w3YXRHbUowVjl1d2tFSEFjSXli?=
 =?utf-8?B?RUdNcWNYeUZXT2R2MytRV3RSaG53WHF6bkdic1ZBNW5HTzVIUGViTFZJMDQy?=
 =?utf-8?B?SFVrUjZIbFZkQTBiVG9tNGlDSllTZnNTNi80M3ZwaS9aWkNNVTVzWE11QlRW?=
 =?utf-8?B?bldrMEs5UHk4RUlsNFArdk1lcy94VG1VMkFnL0V2cmtXdjE5K1VZZVRjM3dr?=
 =?utf-8?B?ZWFLWCtUOVVIWGZKYmU4a0ErTThqa01ldUh1QjZZOTVwd3RuaC9LUEhvS2VD?=
 =?utf-8?B?S0ZMZmo5VFhrZGVrTXJJWDhjSUtWcC8raXpkendkVUVHMGtNUGVlSmVEelpS?=
 =?utf-8?B?eXgveHNJSFFiNnp1dVlZaThCWU55NFFFbzB3bkRpOWhPd0pnWVlOenp6Q1VH?=
 =?utf-8?B?NDZNVDllUGVwbGxuN3ZQV3VySzd5cXpDUlZXZWFkZkpjcS9GMGFJeE9tYkdW?=
 =?utf-8?Q?PW8dtJqfaTNVYcxTQY1Ya9UNj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f208891-fd8f-42f7-c397-08dc689a45ec
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 22:18:18.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3USyOwrzDYB2wfzuL9kS7OZSqd6SaQ99d4/0EPuqhH90IKrT7AFghjOgGRa/i1XJbILyJxxUvdu6vhohYcil4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6503
X-OriginatorOrg: intel.com


>>>  /*
>>> @@ -42,7 +63,8 @@ static inline struct sgx_epc_lru_list 
>>> *sgx_lru_list(struct sgx_epc_page *epc_pag
>>>   */
>>>  static inline bool sgx_can_reclaim(void)
>>>  {
>>> -    return !list_empty(&sgx_global_lru.reclaimable);
>>> +    return !sgx_cgroup_lru_empty(misc_cg_root()) ||
>>> +           !list_empty(&sgx_global_lru.reclaimable);
>>>  }
>>
>> Shouldn't this be:
>>
>>     if (IS_ENABLED(CONFIG_CGROUP_MISC))
>>         return !sgx_cgroup_lru_empty(misc_cg_root());
>>     else
>>         return !list_empty(&sgx_global_lru.reclaimable);
>> ?
>>
>> In this way, it is consistent with the sgx_reclaim_pages_global() below.
>>
> 
> I changed to this way because sgx_cgroup_lru_empty() is now defined in 
> both KConfig cases.
> And it seems better to minimize use of the KConfig variables based on 
> earlier feedback (some are yours).
> Don't really have strong preference here. So let me know one way of the 
> other.
> 

But IMHO your code could be confusing, e.g., it can be interpreted as:

   The EPC pages can be managed by both the cgroup LRUs and the
   sgx_global_lru simultaneously at runtime when CONFIG_CGROUP_MISC
   is on.

Which is not true.

So we should make the code clearly reflect the true behaviour.

