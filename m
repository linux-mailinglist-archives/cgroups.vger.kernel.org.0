Return-Path: <cgroups+bounces-2482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F68A5207
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 15:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F81284C2E
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5071759;
	Mon, 15 Apr 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3YZPygu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E473174;
	Mon, 15 Apr 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188644; cv=fail; b=NkboUOZrgeX5sQy3d1xu431iydUxP2jJ3Uqc89w01Gih2zNDntrsU9REY5VFnOXEXHwcuMLxll7HChn+kiOUBhgI/o6PEHfgLebelB3hTmIHnNFgxVkFtp9pa8i+bR4MVogerXV99PNOgWgHoVr9tiX/bIFaTefc5KHf698ZSyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188644; c=relaxed/simple;
	bh=8qlyoXLwP3AjQLWAKCJgiXU+FYWLMkM1mJqF6LjXRJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VKyINxnpFl4qJv85Gz6VJmVPMd0ACR3I9GKU4xpIkvfAlwiEUTGMtyZ/8jcGJokxcDqeDHjRiaN4jVTHUZacOBc3W6SeZbYx15mRMPPMpIEfKMt6jBZ9EFO5JxPWZ52j3/Riznw4X8vkZA9YwwHdCYBdNhgkVD0GCUYw0ltjRLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3YZPygu; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713188643; x=1744724643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8qlyoXLwP3AjQLWAKCJgiXU+FYWLMkM1mJqF6LjXRJ8=;
  b=N3YZPyguQgQ55JjHa372cTO44nk4+32aWt50OuV2XdqTS+TQywsES5ba
   13nKJsrYeMpMBzz5hG2/9uGrNx1WkbA4VjFt/1HZtfWJJo2cdQ586cSm7
   XVKRpZAhBKKQzNFPkjHpcHR+DDe/Euzjxl9gzp98m1BrKiua6wT1c/rhb
   y+uUuGZjSRD4A29lRub03UNIWsIfyy1xUOWE/4mhUN6nyc8TUYUB1Aeq/
   sv7zHy8ziRmf9XVcTI8SOPskAQNe+8Sh9uYmu7UL4iyIpSVgKL+2xjg2r
   f7GIGa8IHwuN6eAxknRYB783HMZu7ETL7ofyaOBtSXIraDcr7dYqUjj19
   w==;
X-CSE-ConnectionGUID: VDaslI1URseoO08CG3g7FA==
X-CSE-MsgGUID: r3lTKyWBT/mmt8uwxZC/Mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="33963467"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="33963467"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:43:51 -0700
X-CSE-ConnectionGUID: L61m+XbiT4a5WVZgP2G/CA==
X-CSE-MsgGUID: dqfMveWuRaGSvAs4Zrdw/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22001980"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 06:43:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 06:43:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 06:43:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 06:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIGiIYzDH7bIElBnomdNoOnIL51ZEW5f8ttYU5/jgAzP8tgeWeHFLKoSISyK5f2Je4b1rywLgE6ZnJUD8VfqAg8DDzmBPrkt34zh1swLZ1wqmKms76P7EhaoGvEby2ez+vQbGNYRLBDNb8JaegL+DIdt6u9yQHxkW4q68N/merMO3f3IDig1fZ1JxuP1jV9IQQYi3TcehYora/9mSNV3lzlBw9e9WLUYxL1M4UQKDF77WJZaiftlFnhPQkmhxyKCFB6/LwLdNFSRlkTbPci/+VtfcChjY+zzuVIjiGwSNLSjfAFNFvgmng6H2Kf6CkERoBoLfsllKJYlmLJRzXMyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qlyoXLwP3AjQLWAKCJgiXU+FYWLMkM1mJqF6LjXRJ8=;
 b=CogmqmxjzEhnFWTlmr4ZPeq0Y/QB57Bx5U8MlKQOJakBb7WTfJb8LXCEoGrUtuQtgkJTPXAdfkdFDDUbr+cPquaXNBpDAfVy6a16y8qL5vggqLaag0+SV/plDpgXA8cD4OrHZ9z7LzuuXHpsqP2M9XYr6DnusU74vnRLuqk+KWrGdOy8toblvQ4+zkn5vDtMFPfQFUfk/xmwZgPgwbdQjI4Z1l3zy4HquD+QdWCs1/mBroTSG0nlg01mHU/OAyUZN9SWl7qh2l6zgWAnHxQJBbtFn/iaxhbSc9TEjPs5Yawyp7bvBvJy8kmteInxk9YF1A2ERllS6dWYiAzP1y/Ovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB8297.namprd11.prod.outlook.com (2603:10b6:a03:539::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 13:43:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 13:43:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v11 02/14] cgroup/misc: Add per resource callbacks for CSS
 events
Thread-Topic: [PATCH v11 02/14] cgroup/misc: Add per resource callbacks for
 CSS events
Thread-Index: AQHai3SQAsJYKG+EO0K89QpExM95QrFpXu6A
Date: Mon, 15 Apr 2024 13:43:46 +0000
Message-ID: <90171f86cb3a4683e4ddbdf4a82075511a2f6920.camel@intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
	 <20240410182558.41467-3-haitao.huang@linux.intel.com>
In-Reply-To: <20240410182558.41467-3-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB8297:EE_
x-ms-office365-filtering-correlation-id: a03639d6-2dec-40cd-5e00-08dc5d5212dc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xAo1I8M/gTOoM1ArzSeTSAxFPtAh0YfwJcdlBV/E+sTSXoUxOHvmQqA01KOvYNK5P72anh38PBOlKloGSlTR9+KJ2TkTki5MsvifShUeELtHbY5oSgATTA5COkUepVTuHScxRpq2fK/pAtHhr6slp42BR5QZeXjwdBQ27tR/8Wa1reFtZF0hMW8pw8wbJp3aZ0xB9A8FYz1oy52M7DDc1tVfrI5aeP9ciJmxclothLqAwDJDwu/3KXa7rga9F0GDU0WhK8V3Jdgv2flb/3N+vSBZJ1XKh+olf7Onao9Btx0L+nCaHGaY5t2ZcqLpYy1gyk3YOjEm9GSarRJ8f/zswhqkXbAXLeJ5Uj8pp9DvLlnZ20hJyuGbjRH+IG6lAnJx9RSK0RxVIXxvL6if3iNLjF7CglNOlYVR5iCdWsnd8Qj0LaoKsrpDSuskfkg8CXV2VSfBkA5V/PE9LiZjyOAJ6pXnCbZVyqMeC1z4hny/HKc8nC14lfyswxb1KgRzUuxVHc4jxigvoJxMhKBM17V70x3F//6dtnSVhtIOcUp8S8DKLn/25oRpe8CNoPOzta/JaCv7F7wpz+SWbxMadLp6KsQ8doO8q4jN+kk4QOGTuIz4Fw7aU2MN4WyPbWhGD9NqNzTG0LrO6mQZJQaZOPzA+V7YyCFlDHtDuIPn2LRvD2W+zqBjepb3kxSjZ3nbv6fkTzD8kVEP4UX4f7htEKTI7LZsMeLVA6XMT0IDNTwS/I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjNkTjgzclJHa1gwZTI1NlRESU8vanZQdkZDeEUzMWJ2YUxJbGt2SUVxbThk?=
 =?utf-8?B?VnpZcG41UnRCMFdXQ2RvVFl5WU04TGw4QWh2K2hDSnZtK1hGanRSVzRIdE5K?=
 =?utf-8?B?cEJQM21GbGU3TXB4MC9pYTA5cWZtUXF6Mm1zUHpZbjZTNCtTeEFVTk9MU2V0?=
 =?utf-8?B?OHlnN1Y4Ylp6VDhSVXlNQlhQNDJrK3F0THlvcUdQdE13bS9veW80bW9tSWFK?=
 =?utf-8?B?OTFsOUlxN1pIeWtiK3dqZzVhdVkrQnZSTEV3d2krL2NlTmNGdGQ4ZFJITk9Z?=
 =?utf-8?B?N3lZZXhYK0I0STExU3ljNnhWRzRkaXJsRldhTmMrMHVHSGNNZlhTeVJSRUlU?=
 =?utf-8?B?UVNOemZVVTdJb29FR05RZjFmRmJlZkpyVzE3bWpCcEhJRER2RUI0VWpvUXFu?=
 =?utf-8?B?dkxWVlZtMFpvQXJhb2lGTUJlYVRQTFZmRFBnKzJLdk05RUZQeGwyZUI2UVJ3?=
 =?utf-8?B?b2ticVd2aE90bEVNUWNNSVkvOFdWVlNlczE3RDM1R3hMWjVjR0hjSk1ldUFG?=
 =?utf-8?B?ei9XTGRDVFNtYTdDSXBaL0htT2Zwa1BMSDhGZWtTNVc4Z21uSXMvOXNic0Z1?=
 =?utf-8?B?VU5EbVdtVXE2eU5nSU84cit5dHFZYWdjNkQvL05EbTJkV1ErdGMzY29ndUNX?=
 =?utf-8?B?cENGaFY2aTVJc1gzRE5TWk1RTFJ6WHc2NG9rVWVRUlIxc3lGZGNlWTg5M1JQ?=
 =?utf-8?B?dUpNRVU5cEVvY1cvTENzNXNFNEpPMmtqVGI4YU1GZTZra3kySjFqREczaHk4?=
 =?utf-8?B?eU9LOGZubXEzZWtjaGV1RzBUTFp2aEFQdHcxaGM4aU9VOVQ4Z0dmaUR2dVN5?=
 =?utf-8?B?TGp6eEhhM05EZjhOT1doSWRZOWg3Q1prUWVKYzBxOFljaWFnNmJLNnJManFL?=
 =?utf-8?B?YUZPNWpwdHFBUHFtSVhJVFpvYlJKSzBHRHpVcWsxNFBiYkN2RnVDK2RMb1BU?=
 =?utf-8?B?bWY4bE54dFgvai94Z1RsdVVFRmNpK0dDbWlJSDNVWE43VnZaUUhhOXlrcS9t?=
 =?utf-8?B?alUzaGNDNmd0UlU3ejMzWHFUYW0za0t2S3Z6d2tJYTdzZzJxYlo0cTlxSUVZ?=
 =?utf-8?B?VTAwZHZHWnFwQ2pPMEFsUm1yZkdyNnUyQ1VVZDQwQXd4dGQ0a2hqNTFFbzNN?=
 =?utf-8?B?bVBEKzFGMys3S2o5dkdOcndBMGo2MFpWRElGL2FTTmFjeUN0RjlBWWJITDhJ?=
 =?utf-8?B?M2UvbmE4ek9Db1dkVHlTQkVLMWM0dGZXa1A3SVpIU3RTa2JyYTZ6RVdVRWpj?=
 =?utf-8?B?MCsyWXJGWU9ORWtnMlRQUFo5YWREeEtmbEpsNjBkSkx6cWl5VjlQV09MU1VD?=
 =?utf-8?B?VjQxUUdJME8ycTcvNDJSMDdqd2ExazlKeEJsUG50ZjZkMGhQeU5wQ2MvVE1k?=
 =?utf-8?B?UHhBMFlVVm0zbmpsN1J2TFIyUnFsTkh1c2ZrcGpPVjBPOFZHalo3dnhsd1Ey?=
 =?utf-8?B?Zmo1MjlXelFlUHViaEluWCtXT3lOQ05xUFJtTDdMcUZXNVA0YlVoVDNCVHdF?=
 =?utf-8?B?Um9MVXNoY25aZGtpdXlTcmsvWVdSblJidDhYdSt5ZEpkNnpaYzJQbWhCZitS?=
 =?utf-8?B?M3JaemZCRmpMTDdYYitqeEE0UmV2ZmN1NWJRa29xcnN1S2RSTytBcUU3clFy?=
 =?utf-8?B?QlVIV2l6T0NNN0xTYjFTVU9kYzZvR1AyR0R5UVh3MDhETWhZWFVKbXBHQW5k?=
 =?utf-8?B?TlR5TGhtaGhWVW5iS3ZEQlZEUjRMVUZCNVZMRHkwb3RzYWtyM1hYSytYd2JP?=
 =?utf-8?B?UmdCc1VBbEl3N2ZwRVErdEFCRnljWE53SU80NnNpQmwxWmc0T2F3cUsvQzhW?=
 =?utf-8?B?QmlaZi9IWGpyTVprYW9NN2M3bEZiVDB1YmdrbnhtcVRUYkh5bzRFSzBPMDY0?=
 =?utf-8?B?L1YxajVKWkVOcEFVdVI3RjUyZ00rNHhlaW9KWHJhck1pWnArN3VyNGw2K0RL?=
 =?utf-8?B?bk9wR2NCd002bm1WcGp1c3FXZTJFV3BSM2d4NnRWRFJTb2FoMXFtUExFVXJV?=
 =?utf-8?B?UW81dm94dVRsNy9XRmVVbnFEMzE1bG5UdEVBcHRRMHdiRy9JS0IwQkhlVDV5?=
 =?utf-8?B?M2JtYkllTHN5WmZxSk5mbWJDM0VwTFRNMnZzNDdUYTFEZzBqREpPR2xhNk9w?=
 =?utf-8?B?dlJ3UE84K0QxenBnTUZzeTNJT0o3ZVFJTjNuWjV6dzVGendDMytiOWFsWTQv?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43785A92FC77BC4C8EF297248EB94CFC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03639d6-2dec-40cd-5e00-08dc5d5212dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 13:43:46.4541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEkKJP5C9tALOyKyFPcoSi1djQ7gSbpUpy9dWp13pWRGS+X0s5iKjJM3nyigDap3tkkbh3urR7tqWgJs8X8ouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8297
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA0LTEwIGF0IDExOjI1IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFRoZSBtaXNjIGNncm91cCBjb250cm9sbGVyIChzdWJzeXN0ZW0pIGN1cnJlbnRseSBk
b2VzIG5vdCBwZXJmb3JtDQo+IHJlc291cmNlIHR5cGUgc3BlY2lmaWMgYWN0aW9uIGZvciBDZ3Jv
dXBzIFN1YnN5c3RlbSBTdGF0ZSAoQ1NTKSBldmVudHM6DQo+IHRoZSAnY3NzX2FsbG9jJyBldmVu
dCB3aGVuIGEgY2dyb3VwIGlzIGNyZWF0ZWQgYW5kIHRoZSAnY3NzX2ZyZWUnIGV2ZW50DQo+IHdo
ZW4gYSBjZ3JvdXAgaXMgZGVzdHJveWVkLg0KPiANCj4gRGVmaW5lIGNhbGxiYWNrcyBmb3IgdGhv
c2UgZXZlbnRzIGFuZCBhbGxvdyByZXNvdXJjZSBwcm92aWRlcnMgdG8NCj4gcmVnaXN0ZXIgdGhl
IGNhbGxiYWNrcyBwZXIgcmVzb3VyY2UgdHlwZSBhcyBuZWVkZWQuIFRoaXMgd2lsbCBiZQ0KPiB1
dGlsaXplZCBsYXRlciBieSB0aGUgRVBDIG1pc2MgY2dyb3VwIHN1cHBvcnQgaW1wbGVtZW50ZWQg
aW4gdGhlIFNHWA0KPiBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzdGVuIENhcmxz
b24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTog
SGFpdGFvIEh1YW5nIDxoYWl0YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5odWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IFJldmll
d2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1i
eTogVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPg0KPiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFu
ZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KTml0cGlja2luZ3MgYmVsb3c6DQoNCj4gIA0KPiAr
LyoqDQo+ICsgKiBzdHJ1Y3QgbWlzY19yZXNfb3BzOiBwZXIgcmVzb3VyY2UgdHlwZSBjYWxsYmFj
ayBvcHMuDQo+ICsgKiBAYWxsb2M6IGludm9rZWQgZm9yIHJlc291cmNlIHNwZWNpZmljIGluaXRp
YWxpemF0aW9uIHdoZW4gY2dyb3VwIGlzIGFsbG9jYXRlZC4NCj4gKyAqIEBmcmVlOiBpbnZva2Vk
IGZvciByZXNvdXJjZSBzcGVjaWZpYyBjbGVhbnVwIHdoZW4gY2dyb3VwIGlzIGRlYWxsb2NhdGVk
Lg0KPiArICovDQo+ICtzdHJ1Y3QgbWlzY19yZXNfb3BzIHsNCj4gKwlpbnQgKCphbGxvYykoc3Ry
dWN0IG1pc2NfY2cgKmNnKTsNCj4gKwl2b2lkICgqZnJlZSkoc3RydWN0IG1pc2NfY2cgKmNnKTsN
Cj4gK307DQo+ICsNCg0KUGVyaGFwcyB5b3UgY2FuIG1lbnRpb24gd2h5IHlvdSB0YWtlICdzdHJ1
Y3QgbWlzY19jZyAqY2cnIGFzIHBhcmFtZXRlciwgYnV0IG5vdA0KJ3N0cnVjdCBtaXNjX3JlcyAq
cmVzJyB0byB0aGUgY2hhbmdlbG9nLiDCoA0KDQpJdCdzIG5vdCB2ZXJ5IGNsZWFyIGluIHRoaXMg
cGF0Y2guDQoNCg0KWy4uLl0NCg0KPiAgc3RhdGljIHN0cnVjdCBjZ3JvdXBfc3Vic3lzX3N0YXRl
ICoNCj4gIG1pc2NfY2dfYWxsb2Moc3RydWN0IGNncm91cF9zdWJzeXNfc3RhdGUgKnBhcmVudF9j
c3MpDQo+ICB7DQo+IC0JZW51bSBtaXNjX3Jlc190eXBlIGk7DQo+IC0Jc3RydWN0IG1pc2NfY2cg
KmNnOw0KPiArCXN0cnVjdCBtaXNjX2NnICpwYXJlbnRfY2csICpjZzsNCj4gKwlpbnQgcmV0Ow0K
PiAgDQo+IC0JaWYgKCFwYXJlbnRfY3NzKSB7DQo+IC0JCWNnID0gJnJvb3RfY2c7DQo+ICsJaWYg
KHVubGlrZWx5KCFwYXJlbnRfY3NzKSkgew0KPiArCQlwYXJlbnRfY2cgPSBjZyA9ICZyb290X2Nn
Ow0KDQpTZWVtcyB0aGUgJ3VubGlrZWx5JyBpcyBuZXcuDQoNCkkgdGhpbmsgeW91IGNhbiByZW1v
dmUgaXQgYmVjYXVzZSBpdCdzIG5vdCBzb21ldGhpbmcgdGhhdCBpcyByZWxhdGVkIHRvIHRoaXMN
CnBhdGNoLg0KDQo=

