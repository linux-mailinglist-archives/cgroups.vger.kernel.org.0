Return-Path: <cgroups+bounces-7984-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A2AA6E28
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312694655C0
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B622652E;
	Fri,  2 May 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajZ48uqK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0A18024;
	Fri,  2 May 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178268; cv=fail; b=aO/Ij/JPLYuyRo9RPCv0OzMEjM+78XrjZMNZrwmGrydeDHfvzLOEXLNF4AToUIyWIG8mvE1TtfgPaBlVWcXfQvh2PyGUqFByF2or9SENnCqNcm9aWmNE+hBoy6P0Wpko+JgOiefyrRsEvKpBwiaonJ4s0FZLqBVDij6Xj3AIcVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178268; c=relaxed/simple;
	bh=zOz5iXbxQjec2+VMoUkog5bMrAHiaqqgrEiD7tz3Rqo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O3RexSJbuoS6AZ9uKZyIKXDRkl8FIuWP+PmxgJhBwjUmgOg7RSwsr0HGYem7hx5LE6Xjt+4InrvlpmTw8uOlMNm9Q5AODfdeuY1Iq6KOhKYKVHKqc2z4YFIMafgawzp+NbcvvEaPD9gtDHgjqoG67tv/cOUfNyyQGbcyMa9vmvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajZ48uqK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746178264; x=1777714264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zOz5iXbxQjec2+VMoUkog5bMrAHiaqqgrEiD7tz3Rqo=;
  b=ajZ48uqKmaGwCEtS0Vx33ks1nONltvJLbSyojIfNvcsCHn8o+WF4M17M
   Y2N/8ZZLBPqt9SEbeuIpz12qT12aNqWfcOZ5zSRKL4uWyYI5vvYy5X3gx
   c+6hcwmKVx8Fcj/1vheo3ZjrqM1d6GpEbvova912bZYdSRO6VG6yHG04r
   gaycfNVILEb6H1FXPj1HzQrH7nY6Vo2J5oiPMkEef+E58Uo4wZUmlwsbk
   DkAbxT6Gmq/5FiR1Duf3UMTUB4qWua79kxmMT0as9E+OwqCHMgcI+EPnH
   ScJ+AIc80VWqG/g889iptkWSttwJGYl+sLVvo44x9hrf6KxACqR1Nd2v9
   w==;
X-CSE-ConnectionGUID: vMwL7qNFRTKaduPZ7I5P5A==
X-CSE-MsgGUID: WPGd5w/6QdKkYgHDWnVSTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58525559"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="58525559"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:31:03 -0700
X-CSE-ConnectionGUID: 6r7DiWOqQ66z4Xk0LZ2/JA==
X-CSE-MsgGUID: GkZQv/SvSEWWQOQPP8ZScg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134515041"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:30:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 02:30:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 02:30:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 02:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFRbgH0vP5PuWMjKqEqtCC+BM4mXA7HE380zFpOA3Ec5mxfpWp3aV7lWmrXk+LGuV1UTeiLoQxt8LJM5WiAwa8wxKTJtLzdcqT2tzsRR4HpWxnrsh4+VRyOiTZkzLOPqmKF/eoadhvylIGwOL24n776oHQqm+jqSSpnmrkzD6FMSSRFCeULJsO+NAy/8OLGLaGAnzNEDNbCj9VA8fWYK0yc/H4ym1pKpq4t5qAPtLvlVu+WZgMuP7Sb/0ujpY3ed5mqWVXuZ+qLAQjS6wzPQmSSeFkUFQaauAlZHkkux4NOtVNKT9L8SC5bRVPug762NbY+y4tmTcyKYCBaECYLHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dqn4KCaWhgaRiXjN2HiUP1ZL3p32YyBQVlPdfhWj2Q=;
 b=gaWOwhnqSKU/srHB9f4eYcLffPuco+QzX94giWIFTQjSyXi3/iKPs+/kiNn7MsQZFKDi3NECA2B+FjlIEO105gVi+6w1i3Ek5+3LGuWac3J4Mi2qwhIlSIT9u7saO4woZPWYKGbGaTmNPgwjKjfrZ4FyX1CzFhK9ODIHx2otV6n6sT3ZbWC6zWeDOlQldikYUt8k/LpfPmzVUj/4m9ENJQQPP9kiX1dvehKsGRYANYIbX1JyTt2ujh9wmbJCQ92ZREjKH9cH8t23Cac0M3LkBLrJRj0xeWQJMaor87PF+ALcX+sLXclFqqQQ3J4LvbvsfgtORq+pH95o0wTfCPD7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 09:30:26 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 09:30:26 +0000
Message-ID: <f024ebd4-2b18-4af5-8fc3-7b057501444b@intel.com>
Date: Fri, 2 May 2025 17:30:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: Libo Chen <libo.chen@oracle.com>
CC: Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Mel Gorman
	<mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, Michal Koutny
	<mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim
 C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
	<cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <9a6402ca-ce63-430b-b60b-1a36971e37e4@oracle.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <9a6402ca-ce63-430b-b60b-1a36971e37e4@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8800244d-c468-4730-042b-08dd895bf878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE1LeUQvSVV2cnlsYUlXRHNUUEVQRUZIR1l6Mm9xVTJTU0ZoaDgvMVo2ZEg2?=
 =?utf-8?B?ZzUxYnlTVUptdmZBVFZFMWl0WTcvRmFBaU9PQkpxeVpzMGRoU0xQclJNSnVm?=
 =?utf-8?B?SHpsV1NVQkJGY3JHZGNRSlhRVDNYaUF4dUdvdmNZTEZyWXJweGJSN0VSZ2Zq?=
 =?utf-8?B?RWo1Q1p6SkxQUVliaitzaW5KVHYveWZRei90SWJvRC9rd0s2RWRuQ00xRHJq?=
 =?utf-8?B?UGl1SWZwaVRVT2QrWDBHZFMvRFFORk5aQUVCRU1vR0w4SHN1akdhNU0zaDV1?=
 =?utf-8?B?RVErU0w0NVp0T1Yxa2VJV3JYL0RVb05xU1hwcGIwTWVxc2tRS280dlZxWnBK?=
 =?utf-8?B?YXZCSGk4bkg4UGc2SDluZmc4OCt4ZlBIekk0Kzhsd0RHcHZLZXNlYWM3UFI0?=
 =?utf-8?B?aG5HSWdFNUVmMmJabkhJVk5ockl0ZnkwMG8vTFk1MWdybWFSQlpvNTFjQUlv?=
 =?utf-8?B?K0lTMFRVRVRBVzhkblFhWmthcjdCaXhzZzMxVHJVNUkyb0E4b3F3RkNMZ0xN?=
 =?utf-8?B?QzlBckxROW5DaXA5Tk5kVFUrV1AzR1N0MWFkdEpkTnp3YzlhdTlBUkI2a0VW?=
 =?utf-8?B?L29uRTZPL3NoYU5DQ2c0cmhLeGlVeFlENlQ0ZzRzSjBjUkVxOWZrZXljRlI2?=
 =?utf-8?B?M2RkL2Y4QTIyTnRYa3FaUXB2ZnJhRzRocVFTR0RhRk9SU24yNXBhb0s1SW5L?=
 =?utf-8?B?MWpuL205V0JRc0FXRkhRMlNRQkdXT1V4dEZHc1B0NnR2aklJU0JkMlhVUk80?=
 =?utf-8?B?SE4rU1pxbEtDam9EOTZVMk5lQmNpMnhXc1oxMVRIbnRLeWVtUUYrZUhPOXR1?=
 =?utf-8?B?aVB3dXAxc3dQNS9XZ0FJS1dEVjJxUGprODdVL1d3ZFJ2RWdvTFREWU9Fdi91?=
 =?utf-8?B?SmFIVWppcjZjUFJLQ0VpKzlzRHZkUTZxOStuZTBCbHlESHk0UGs0dUhwcVFn?=
 =?utf-8?B?RVFuLzE0NFlYQkJGM21GbzZGRlpZWjZWbXp4SHhFVTJhNWFLZmVUUmtPVjBW?=
 =?utf-8?B?RGRHT2wveWRXbUV4Y2EwK2xxUXRnWkRwY05ySzV1dTY5ZG03clhjSjZrSzN2?=
 =?utf-8?B?OVB0RUZaQUZZNlJMOUdzbXBkNEVDOHJvUzY0UmdublpaTVRXcHplVkFDaGtJ?=
 =?utf-8?B?d1NyVWtDQXB4VDhTcEJBM0RSWjRFbE5HcWxuaGZaS1hVckh0OHRCWWFYZVNB?=
 =?utf-8?B?SmZoa083Z1ZxK1NQMlJKajdyam9nck1aSXBtWEswcE9tRi80c2pibG03VitL?=
 =?utf-8?B?djFML1Q5aUh0ak9tZUpySFg1UEo3UkUwMEE4bklGdVhFNVBEK3BuSVVBMisz?=
 =?utf-8?B?My9rRGpsVlBRM3dHUU11RW1BY3JsZTZXSHFoUEtTelZUODcya3JtbkgvMVZi?=
 =?utf-8?B?RVp0LzA2Z0c1bXFJUGJGYzZDdXdCYjNBcjMyV0FZU3k2cWhSK3lFaHhlSHUw?=
 =?utf-8?B?bTd3aGw1anhDOXNJWTlOUWRWa25KZUFoaGZXTHN1aHU4Uk5XbmwvR0FlbG1q?=
 =?utf-8?B?c1BBYmVaVDFOMXh5RE1KNGNrWGJIZW9yNkl5SjNLQ01sTm9NK2dHZTNUeEtV?=
 =?utf-8?B?aTRkRDJ4Y0RldlgvVHU4RW1pTVZ2eTBxZWpHMkVsb0NRZWlocFBiWjM2aFlv?=
 =?utf-8?B?SC9xTHZNMTk5ZDZSNmZRRHJBb1ArT3UxcG5XR3FGVzU3WVhpeCtGR2s0V0E3?=
 =?utf-8?B?U0M1ZDBnM1EydGw0aUNRRDdqc3BGMy9MTllsY2hMSExJaFd5TVZUOXdKKzFF?=
 =?utf-8?B?LzZHMmQrSTNZa2c3TFdLdlpucjk5eFU2aDZHTTNOdGgrV0xrZ3FSQ2xZSlBw?=
 =?utf-8?B?NnRYUWJvK0tyU2lDcXExaXJsSkhFdXd5eTFFaEVvRlVPY1FycTlIVUpNR0F2?=
 =?utf-8?B?Nk5HSmpwdU16d3ZtV2lQU0RGalFhVWdZVS9YYk4xaE1ZNldocmZxMFRRTzZm?=
 =?utf-8?Q?Fo+FNQH3beE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDk4YlhDOC9Yd2o3RlIzeVlGMU1kRnUzVXFxN3haeHJnVW5sQ1FDUGNZVVJP?=
 =?utf-8?B?SFc4a3B1RGg2MVU5bi9sZ0xLVU1wZFlscG1idkpCYWw0ZWFhcU00SkdiWDJ6?=
 =?utf-8?B?dFQvN2cwSWpYR2FLakh4U0VRYlZvVFZTZGdYMzd6cWd3ZHNYUmorNld2ZjJ1?=
 =?utf-8?B?S2RLQWtqSjNzcjZ2blhaSGdZZnlxaXNRMkEvZmlySysxQ0tjbGJlWVg4ZUhw?=
 =?utf-8?B?QjFwdVF3MGRkZHVrYitHc3ZqdEE0YnlZM3FWeFhtbEg3UmdwMTBxckZJUlZy?=
 =?utf-8?B?aUY1ZHV6U3dFUCtXZXU2cUJmTmlRa2U2QmszQzFWbC9uelhLZUR3cVAxZzhm?=
 =?utf-8?B?b0dFRjRWdlVJczdsamZVeUtMUWpaUWt4ZHFGTjVkeDZQdmt2aW85QW8vZXpJ?=
 =?utf-8?B?eHJYWEt1aXlqaFRGQktOb3gvdE83WEpuSENIdk45eEt3Y1hwOWczeXJNNXJu?=
 =?utf-8?B?aG8xcGMzUEcweDNKb0x0R3M3NHVqMlVzMmkrN3RlV0hCaU8zazhFNFFGZjJl?=
 =?utf-8?B?VXNMbGxKSERBNXgwYzJKOU95VEdlcy9sWlVZYmFOUjQvNUt4bk1VRG1ueEUv?=
 =?utf-8?B?SEU3bDJUVnREZGxnY0g1Sm9aTm1kSzMxZWdjaTRoSS9qWnR1dmZTTlhsTmlI?=
 =?utf-8?B?OVcwY0hOYXdMOGVucHlVaER2ekVjU0UzWWRCaG42TEFIdFU5ZGJheUhDazln?=
 =?utf-8?B?TGhpWi9ubFcrWHFIVmx2Y1Y2ZTcvdG1RQUdWM09SSUNZRWJ3eG9CUThJaHIz?=
 =?utf-8?B?VkV1MXI1VmZZOWF5QmI0MC9rR21EcG0xRGcwYURDUWMzTjZiRFh2R3VEQUtx?=
 =?utf-8?B?TDFxV1RqV0RPOGdLcVRLc2JadmxoLzllMUdwU1dpaWhRWDR5Ymsyb1ljb085?=
 =?utf-8?B?a3ZHbDB0T2JTYWZWam5wUjRJSWt2amtkOVdVQjBxajF5RGdpaW81VjFlUUJj?=
 =?utf-8?B?WnpTWC85bHlrcGI5S3d5KzVpdUJLSklZRGVBOGdLSWZHbTEwVDZRSk16R1pH?=
 =?utf-8?B?YmYzOGREMWtra0RDUTMxWWVrWFdaTHBsWHI5L21MU0swUTNla3dFdkl0YW54?=
 =?utf-8?B?UHpNSTkyOTljekdUMWwwUmRUVDhDUEh0NHNzays5NXg4V2RwS1pXRlhSZ2Zx?=
 =?utf-8?B?S09UT3JSdFo0L0pyZXVSZW9sWjlvNklvd0lZeS9QQnFjSm1GUE8rRDdwUzRy?=
 =?utf-8?B?NzlKZ1l2cWlVK3E5TW5EbFJDMitJZW5JcEV6T3A5NCtnQnBnbHZWbkFjSURM?=
 =?utf-8?B?U2J6RU5sY2I0ZXFMaWYyVHJPYk4yZXZVUmtLOFQ5RFk1dzlabExITTFMdVRE?=
 =?utf-8?B?UzRWNFJ6S0J6eGlPU0JtcVFZK1hqZGI5ais0VXVMU0ttQml0YzEzN2hNV0VP?=
 =?utf-8?B?bUlQaDZuV1RyMjRaZmtCWXlWTjZ1S3RxQ2U2bXRUbDhpSm9HMG1GMTVacmRn?=
 =?utf-8?B?ZkNYNzA1S3dlR0VvQWlxT2dDU2VvN1NFN1NuTUc0a2lvd0hXOFZMdGY5SklS?=
 =?utf-8?B?bTN0WG9aUUZjV1pldC95STQwMVNFU2NodWMwZnVwWUhZREZ5ekNsQ2xDSDl5?=
 =?utf-8?B?a1ZJYTF5WWYva01JbVUvcnFjREFJa3NwZkVaZTJQSnc1Tm96c0VzZko0b2hF?=
 =?utf-8?B?UnJCd283RnNSTkVPRURVaXNnRUVNbWVRUXBqN1VKb245M2h3SFJTUWQxMlE0?=
 =?utf-8?B?WGhNL3FrdFVIYy9pZnN2UXczazhGUGNpNVY0RFpkQVhONUlYZVVEcXE1MlRp?=
 =?utf-8?B?UW1Dd1RDSUZ3MEZLK3BwZWY0alc5Wk5VRzI3R1QxL0NkR21nN3c4YVVUL2Y2?=
 =?utf-8?B?Nm1RbkVXNHhsVWVJb2RHcmt5bnJKMnh6dWoyTkpYeUNrU1NpakI5UzZvenRI?=
 =?utf-8?B?V0hhalBnWEJGL1JLZmJGSHRLQ2M1b1djM01VZnAzVVhHYjZUR0hGTjVuOUVx?=
 =?utf-8?B?MnpHUWZKY3ZHMFZvd3N2aTdISDB6Znlnc1RmaThSZGE5NFB4aTRqRUZxaVFj?=
 =?utf-8?B?R0ZJSHRVNWJoQjlFQUVrRHdlZTBXNXEzQVpMcFl5a2hGM1BYdTBGd2xsNkVO?=
 =?utf-8?B?Y3BIRlVhUDZZSHQ3aWxtYUEyQk0yUTlqSlBtMzNHOERrUldWTnBVckI3YSsz?=
 =?utf-8?Q?bvpynHMNBY0WWnRWmvoHI7ZaV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8800244d-c468-4730-042b-08dd895bf878
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:30:26.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUMRrjEXODDfgvffWc0mE20bvmGLrVQ1ga9UCm+fQSDD6BwAMOUL4n6X/ypd7n5NEcOCbIISdqKxT8DO9nNHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com

Hi Libo,

On 5/1/2025 3:00 PM, Libo Chen wrote:
> Hi Chen Yu
> 
> On 4/30/25 03:36, Chen Yu wrote:
>> On systems with NUMA balancing enabled, it is found that tracking
>> the task activities due to NUMA balancing is helpful. NUMA balancing
>> has two mechanisms for task migration: one is to migrate the task to
>> an idle CPU in its preferred node, the other is to swap tasks on
>> different nodes if they are on each other's preferred node.
>>
>> The kernel already has NUMA page migration statistics in
>> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched,
>> but does not have statistics for task migration/swap.
>> Add the task migration and swap count accordingly.
>>
>> The following two new fields:
>>
>> numa_task_migrated
>> numa_task_swapped
>>
>> will be displayed in both
>> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
>>
> 
> Both stats show up in expected places, but I notice they are also in
> /proc/vmstat and are always 0.
> 
> I think you may have to add count_vm_numa_event() in migrate_task_to()
> and __migrate_swap_task() unless there is a way to not show both stats
> in /proc/vmstat.
> 
> 

Thanks for catching this. For some reasons, I added these
"placeholders" to the vmstat but didn't populate them. Let
me remove these items from vmstat because we mainly care
about task activity rather than page activity(not a vm event
I suppose) Let me have a try on this.

>> Introducing both pertask and permemcg NUMA balancing statistics helps
>> to quickly evaluate the performance and resource usage of the target
>> workload. For example, the user can first identify the container which
>> has high NUMA balance activity and then narrow down to a specific task
>> within that group, and tune the memory policy of that task.
>> In summary, it is plausible to iterate the /proc/$pid/sched to find the
>> offending task, but the introduction of per memcg tasks' Numa balancing
>> aggregated  activity can further help users identify the task in a
>> divide-and-conquer way.
>>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> ---
>> v2->v3:
>> Remove unnecessary p->mm check because kernel threads are
>> not supported by Numa Balancing. (Libo Chen)
>> v1->v2:
>> Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>>   include/linux/sched.h                   | 4 ++++
>>   include/linux/vm_event_item.h           | 2 ++
>>   kernel/sched/core.c                     | 7 +++++--
>>   kernel/sched/debug.c                    | 4 ++++
>>   mm/memcontrol.c                         | 2 ++
>>   mm/vmstat.c                             | 2 ++
>>   7 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 1a16ce68a4d7..d346f3235945 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1670,6 +1670,12 @@ The following nested keys are defined.
>>   	  numa_hint_faults (npn)
>>   		Number of NUMA hinting faults.
>>   
>> +	  numa_task_migrated (npn)
>> +		Number of task migration by NUMA balancing.
>> +
>> +	  numa_task_swapped (npn)
>> +		Number of task swap by NUMA balancing.
>> +
>>   	  pgdemote_kswapd
>>   		Number of pages demoted by kswapd.
>>   
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index f96ac1982893..1c50e30b5c01 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -549,6 +549,10 @@ struct sched_statistics {
>>   	u64				nr_failed_migrations_running;
>>   	u64				nr_failed_migrations_hot;
>>   	u64				nr_forced_migrations;
>> +#ifdef CONFIG_NUMA_BALANCING
>> +	u64				numa_task_migrated;
>> +	u64				numa_task_swapped;
>> +#endif
>>   
> 
> This one is more of personal preference. I understand they show up only if
> you turn on schedstats, but will it be better to put them in sched_show_numa()
> so they will be printed out next to other numa stats such as numa_pages_migrated?
> 
> @@ -1153,6 +1153,10 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>          if (p->mm)
>                  P(mm->numa_scan_seq);
> 
> +       if (schedstat_enabled()) {
> +               P_SCHEDSTAT(numa_task_migrated);
> +               P_SCHEDSTAT(numa_task_swapped);
> +       }
>          P(numa_pages_migrated);
>          P(numa_preferred_nid);
>          P(total_numa_faults);
> 
> 

Previously, the numa_task_migrated and numa_task_swapped were
put under the scope of schedstat_enabled() in
proc_sched_show_task().

We mainly care about task migration activity, so it is put near
the nr_forced_migrations. When it reaches sched_show_numa(),
P_SCHEDSTAT has been undefined. It is just simpler to do this
directly in proc_sched_show_task() IMO.

Thanks,
Chenyu


> Thanks,
> Libo
>>   	u64				nr_wakeups;
>>   	u64				nr_wakeups_sync;
>> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
>> index 9e15a088ba38..91a3ce9a2687 100644
>> --- a/include/linux/vm_event_item.h
>> +++ b/include/linux/vm_event_item.h
>> @@ -66,6 +66,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>>   		NUMA_HINT_FAULTS,
>>   		NUMA_HINT_FAULTS_LOCAL,
>>   		NUMA_PAGE_MIGRATE,
>> +		NUMA_TASK_MIGRATE,
>> +		NUMA_TASK_SWAP,
>>   #endif
>>   #ifdef CONFIG_MIGRATION
>>   		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index c81cf642dba0..25a92f2abda4 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3352,6 +3352,9 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>>   #ifdef CONFIG_NUMA_BALANCING
>>   static void __migrate_swap_task(struct task_struct *p, int cpu)
>>   {
>> +	__schedstat_inc(p->stats.numa_task_swapped);
>> +	count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
>> +
>>   	if (task_on_rq_queued(p)) {
>>   		struct rq *src_rq, *dst_rq;
>>   		struct rq_flags srf, drf;
>> @@ -7953,8 +7956,8 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>>   	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>>   		return -EINVAL;
>>   
>> -	/* TODO: This is not properly updating schedstats */
>> -
>> +	__schedstat_inc(p->stats.numa_task_migrated);
>> +	count_memcg_events_mm(p->mm, NUMA_TASK_MIGRATE, 1);
>>   	trace_sched_move_numa(p, curr_cpu, target_cpu);
>>   	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>>   }
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 56ae54e0ce6a..f971c2af7912 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -1206,6 +1206,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>>   		P_SCHEDSTAT(nr_failed_migrations_running);
>>   		P_SCHEDSTAT(nr_failed_migrations_hot);
>>   		P_SCHEDSTAT(nr_forced_migrations);
>> +#ifdef CONFIG_NUMA_BALANCING
>> +		P_SCHEDSTAT(numa_task_migrated);
>> +		P_SCHEDSTAT(numa_task_swapped);
>> +#endif
>>   		P_SCHEDSTAT(nr_wakeups);
>>   		P_SCHEDSTAT(nr_wakeups_sync);
>>   		P_SCHEDSTAT(nr_wakeups_migrate);
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c96c1f2b9cf5..cdaab8a957f3 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -463,6 +463,8 @@ static const unsigned int memcg_vm_event_stat[] = {
>>   	NUMA_PAGE_MIGRATE,
>>   	NUMA_PTE_UPDATES,
>>   	NUMA_HINT_FAULTS,
>> +	NUMA_TASK_MIGRATE,
>> +	NUMA_TASK_SWAP,
>>   #endif
>>   };
>>   
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 4c268ce39ff2..ed08bb384ae4 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1347,6 +1347,8 @@ const char * const vmstat_text[] = {
>>   	"numa_hint_faults",
>>   	"numa_hint_faults_local",
>>   	"numa_pages_migrated",
>> +	"numa_task_migrated",
>> +	"numa_task_swapped",
>>   #endif
>>   #ifdef CONFIG_MIGRATION
>>   	"pgmigrate_success",
> 

