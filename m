Return-Path: <cgroups+bounces-2483-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6598A5213
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA181C22A7F
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B671737;
	Mon, 15 Apr 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4S8Adig"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97BF5A108;
	Mon, 15 Apr 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188714; cv=fail; b=s29JvTGb31krvXNd0j7R5OcknSYYtADgEM6IoT/jwY6+W6/1jbo26zyUN1Wbf+0DZt9xmgz5w6aWTW0Op+4V0vS1ixT9HW3RLODlV6q7XoJ5qcV5WIGiQLTWcOUtCJZFlPT34B43bwCNBFj71cUX0aiShSA7ImX3/LFhn2MVqXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188714; c=relaxed/simple;
	bh=DsVxZIBeTyt1kPu2bPZeHF3oKak6tgyehJhwnXc1Q0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CSz02gBNrziYSWs/rtX46XKVol83Xj+5SElgU/MbQ71YVllX1hSQ0A0z/Lg383Vc1oi+QTnUkj/EetCpmfCVvs1ULpRVFNtrLNBmC2inSM17Kj6oRequKFG1P0X+cqGE7cig4LfNNNZLgUWyJO9Ppix4bUSmevZIkPlBQhsEdc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4S8Adig; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713188713; x=1744724713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DsVxZIBeTyt1kPu2bPZeHF3oKak6tgyehJhwnXc1Q0Q=;
  b=S4S8AdigqBntLonAaQ9+N6yTwaVu9rOXph8ZQc3nOnYnFhJHhbSfJ+T9
   xtFIXfj4l6eMkN2qN/myNEl8J5GSaygRmzcVM5ElwGUX1x000ehEllugD
   yDwsBCEJ7fv+vtGartDrTJWH8elEWah/Cx4ZmRK2LGvsjT0GJPVfLF9N8
   ycdZegO7l2IGbftc2fufiN4P8MfPyJpUdd8c9pi4aXU882A9jx1H48+CB
   0OvkuPGHXiIhlNPlvMZVWeBM8G22LaaNmjhx7ZlJ9l8NjV44Cr4dO59D6
   WRzJ6CEpVWu7VXONeiEgh0i8qoh8ST/Yv+M+F3hbcbVkaPG52B0gyHn+D
   g==;
X-CSE-ConnectionGUID: 5KG2oJK1R9CtJth8Bdhjww==
X-CSE-MsgGUID: xXhz0PiySA6OJMFhz6rqQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="33963673"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="33963673"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:45:12 -0700
X-CSE-ConnectionGUID: h2Khk4kLSnmZuqrYwm5ABg==
X-CSE-MsgGUID: OY1Xa7AoTpG4v8aSoAsSdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22002384"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 06:45:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 06:45:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 06:45:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 06:45:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 06:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbfNztF5tVmPzkND6F+2wEpbPj7L9ndxC+Y88Rby0JfxF6uW+4BNh6+oDuwnCK8dTKt22BxJmTNXFOnI95WfI6A/UxFpu/KbjBYmX+45pJkSYzuLp4LIBXu0K0q1I+v71DMPCk0Fb62jugpRT9lZv+3esVN7psG4WkmUXtY6tKXGwYCOudhBUJB5479p4ZRgyw1JRMJyCI51t5aajxsOCFcsl620wIK+Wkrz3m9yVNhktVcNZeWVjLCAiiwusMv0JLQ/3jkECkC1nZErdv1SlnHL1GHoZJ/9j3LEdtazoV6gHaSPPU86YoMhgXOByyG7+QrYUiY8ZYLffwXWtoZvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsVxZIBeTyt1kPu2bPZeHF3oKak6tgyehJhwnXc1Q0Q=;
 b=NO3tf4Yc5lMtcWzWoG1I8qjbxf+fHGgVUoHzYC+zBmHzQQJIoaZU7/92vmbKAKQwrwaEPsnVYyKLhPOLvUE9pc9ugNR2HeIoj1SImQz2yRzVQ83WtWnBNc+smbwIiLCIWr0rxbaFO4jRJO4S2mGvloe7XxwbYD3dDxI9GVTEd6BlMey0e/l/pbTyUFW4WZsJF8noNlNipgCbeaFv8x6/G2Bs496QN0eij0ViHPidTk/20XLMa9pqbhuwz6vVR7Kmy9GozXk7zT3tb4mXSpEt+IV/bKIEPoMzAsGWnSA5B7LobzPl/kiMCeTwumM7yvDs/qCq1oqbslIxePdv9saulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Mon, 15 Apr
 2024 13:45:04 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 13:45:04 +0000
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
Subject: Re: [PATCH v11 03/14] cgroup/misc: Export APIs for SGX driver
Thread-Topic: [PATCH v11 03/14] cgroup/misc: Export APIs for SGX driver
Thread-Index: AQHai3SUciT1T0g/z0agWTP3lhL3sLFpX08A
Date: Mon, 15 Apr 2024 13:45:04 +0000
Message-ID: <1675728ba7af1ddd7e9fe947e4a371bcb33b6558.camel@intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
	 <20240410182558.41467-4-haitao.huang@linux.intel.com>
In-Reply-To: <20240410182558.41467-4-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN0PR11MB6110:EE_
x-ms-office365-filtering-correlation-id: dc37c20a-8af0-4d4d-3803-08dc5d524159
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7knWour4G0x4/hNVT0qfw9NvOLL+GzLSxRJ0hYAbt/NyYMG+kg6QWwfutd14kzlnldv68rx+GlGwUauYOr7+hEUcIY64OxWMDE5MH1OJeyCFIz54fX3+tjV79IvTyK47A2lsqWMTDPEilPUCWYdfB0qKdbzdqsqZRg221ial6FN4BdhoScPEiP+BORysX5Cpm80vOtJFkE2+lQDKdTAPpxv/6orMa95kRUqRYQ+S6jRgwwdAT4LVlshEqU63UdprLPogpFxN41Z7/LWwGL266ZuM/HxT1g4Tt1K6UdBFaL0MeQJZyJxaUaH/x0rKFc6hrUfxUA7ScGQuWIiG0EvV7zJ4g/W5uEGWkfu/4Hyzmy4j9N56uMJJVKabBcG0BiaVTIujtFMQARLVa2dM40QofNWO1rcbF85nsmJ9ooR1afKfWUV5RuicswCv98XocN7rjUXM+qs04Tdfsvq4xWh+QJRhx9VcRi9noS747WSS1HJOtrbbOXl9jOskkHBIi3AMn3fhyQPDA8ztoCFj4+rkuddExgwLqFPBt8gzvd6LwqO0/f1dApx0yhzUZsB+3dWYtKvw+3FfAhVJikkBRWV+BEXU/j5wYQA19r/jEH9evHRqYu6X4sZ4g7HhTsj++QqsqD8mxWjTW+ZGG08ubONQ+plZ2wnDecAXb8y+98CMuZgaxqv9CBpblWNsn1CKpa2Fd01EbDPA6M7gDCu40R0dxxiHBjuCRmxqkpEERSzhdnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azBlZGx6ZzVLQ0NaQ1lGT1VFOS9MZ2lLdldMTit1aEF3dURyZXc3TzIwQjQw?=
 =?utf-8?B?VmQwcmhrNVRXZjBVVk5GQzh0YVRBOG54OCtOU2FOOU5FbGpCaXYvMmNFK0ZP?=
 =?utf-8?B?cTkwRE5neGg5KzRQOGZTQW1QVnJmWEF5MitiQnQwRTBJcXluZnMxVGgzU0VZ?=
 =?utf-8?B?OUluWlQ3UXJ1OFgxZTdhWVg2czFLUkxJRjlPSEZhUUpxS0NLeE1tUmJ2MXJ6?=
 =?utf-8?B?Y3BTajVBYUZMRDVjck9aRGdZRlJoZ2c5dEhYL1FDY2NvdWtRd1I2TVcxL1RQ?=
 =?utf-8?B?MTB0R2x0ZFZ0eitFKzRmRTlQNnRYQ0JMZEZiUGJtYUw3ZjdidjRuK0RvKzN1?=
 =?utf-8?B?UFdONWtScldYbFdkRjJYWlZCTDdhUW5YNXpEUXdXVERtYTlCWGVMN2M4L2pl?=
 =?utf-8?B?SHdBSE5COFNuSWtvMTh6QW5HWFFzbkVYMXRVeHNUS3c2UWZrMTlMc0FiZFp0?=
 =?utf-8?B?clM3TlVZd2NYeVgzL2U2Q2c4WjFWZERzMVdleGwvdFVPMW96VElrSlZIMis5?=
 =?utf-8?B?QzhxVk04RDVGUHR1ZU41NXovSEx1b1hJRFpFR2hlM1VidnVJbzltcWVxVWpW?=
 =?utf-8?B?QTl4eWFVZDV4L2RFOEpRWHJVTSt6eTl2WC94dEdWVG83U2o4QUpiQ0VSQ3dF?=
 =?utf-8?B?bVIrY0FvNm95MStxZUZLWXhkL25mcjJ3QytIbVdxRFFHMXJwVUVGQ0VRVkpo?=
 =?utf-8?B?a2lXaFVvMmUzUlFEUDFadGIzeGFnN1NSOCtkOEZiL1VXMDl6cW1lRUlBSm5t?=
 =?utf-8?B?Vm1HTVdad2ZpanZiTjZJK2hPTis5WitkRkNoL2FJcEZUdWhod2hYVTIvU2ZH?=
 =?utf-8?B?MHlqWG03R0p1dTZlT1puM1k1UGd1dzROL2RuOTFmWnNZRW1meWltdVIrZkFJ?=
 =?utf-8?B?MnZOc0tzaXJreTg5Tk1RSWJBRnNUMit5OWhrTVVZWTZyM1I0TXJza0VUWXZq?=
 =?utf-8?B?K09EOU1KZmhWb0w2Y2FWdWw2aWQ1QUs1ZWJ5WkxLT3dsYnl0V1dvT2dwN3kr?=
 =?utf-8?B?Y0IwZ2hodmdETWgrZXN1MEJiUWc3elNmSm5Xd3RjbnB6UkNBR0NScFZsTXE4?=
 =?utf-8?B?ZWtMUmFLQ1RvUG9TY0ZSSDdmaERiY0VoWTBZemVtT1Nka3BwMWRCRkZmYmIw?=
 =?utf-8?B?NEJZV2ovdUhyaTFUeVZ0ejdRaUlXYUlwM1hQNnJpQWhXVFpWQ1RpZm1oOHF6?=
 =?utf-8?B?Q0NUdU5CMVNaOWpIejBBNGRlT1BlWnk4dDVIcWYwdHVlWGR0OERaVXBld0NM?=
 =?utf-8?B?TzlXMGZMblZUbzVYcGJKMzk2TDcvbkFHRGpPK3FGZ2NVaVFRSlZPSHpvS1JS?=
 =?utf-8?B?MHU4NlZMRW9McjlFdkVhR1ZvSGF2c2wvbENXLzB5OGlNWDc4VGQxUDBXdnU4?=
 =?utf-8?B?YW1DUzlkbmM2TkFMcTFwbVJTYWF5TU9NYTVpclR6S3hmMG9wczNKNjhabWFN?=
 =?utf-8?B?NnJlc2FhM1Z1emcwVXp5RzlOUzVSbmI1TkVzU3BISjl4Qk44U2x0R05JNnJi?=
 =?utf-8?B?aDlwM1hzNjk0MHZTSnBvd2Vyb0h3NmRTdTlpNUlwZ0RNbUFpVVFBbUdnWkkz?=
 =?utf-8?B?bllsS1hhbHNGZ0JBbEorYXdRWFBSRVMzb25YUndDZjBBN1o3cTNVbGZRbzBZ?=
 =?utf-8?B?eDZlak5nR3ZpWHgzRE9xdngzanZzRS9rZzFSRE40K2grZ2kwQTlYd2ZxZTJY?=
 =?utf-8?B?T0cwb3pjaWprZEc2YXd2dVRQTzFsMkFqSWMxc1Q4Mi81am40Q2ZTbUZLNW1x?=
 =?utf-8?B?K2NqYXZubVAyaXFERFdQZUl6SzhWdkN5RVkxamJYSVpUais4WXo5aTkvSitv?=
 =?utf-8?B?Z0tQZnI2NkEwdSs4R0JPbStUM09kL1ZJcGlXNnlPc0hwSWk3MStxY2lEaTVR?=
 =?utf-8?B?V2ptcnlya0cxUWRsNk5TSnBxNm95RGEyOTRQSGdQWEF4b0hNa3gwcUU3Nlpr?=
 =?utf-8?B?LzdnWFM4dDlvTUxJV28xRDV4NFY5VFZJSUF1S2NGbFpobGdzbGxaTzVQbzB4?=
 =?utf-8?B?YTB5ZFY1cmRrMmwxcXJkU09icU9tL0lIaGpMK3JENnJLL2hJSm9DampVcW0r?=
 =?utf-8?B?Z0t0ZmI2NkJHSGgzdVBUU3A5RGtXWm9TamJhZ1ZGV2VGeWFQWUd0a2FRZHVH?=
 =?utf-8?B?UStHM0orUFdLeUR1WWE5MjIrQ1hKTzE3WGEwcHRoNTJydzBTcytGb09Pb2tU?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91EB1AB7049B2042AAC57456A86D0E01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc37c20a-8af0-4d4d-3803-08dc5d524159
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 13:45:04.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjNAbzP/ned+UwKf74CplO8ixRN56nCLZoccgSNHQISKtKsjhFlTvQ383AUxDTaAYnmWjXjmx1I9vCjtQlA7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA0LTEwIGF0IDExOjI1IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFRoZSBTR1ggRVBDIGNncm91cCB3aWxsIHJlY2xhaW0gRVBDIHBhZ2VzIHdoZW4gdXNh
Z2UgaW4gYSBjZ3JvdXAgcmVhY2hlcw0KPiBpdHMgb3IgYW5jZXN0b3IncyBsaW1pdC4gVGhpcyBy
ZXF1aXJlcyBhIHdhbGsgZnJvbSB0aGUgY3VycmVudCBjZ3JvdXAgdXANCj4gdG8gdGhlIHJvb3Qg
c2ltaWxhciB0byBtaXNjX2NnX3RyeV9jaGFyZ2UoKS4gRXhwb3J0IG1pc2NfY2dfcGFyZW50KCkg
dG8NCj4gZW5hYmxlIHRoaXMgd2Fsay4NCj4gDQo+IFRoZSBTR1ggZHJpdmVyIGFsc28gbmVlZHMg
c3RhcnQgYSBnbG9iYWwgbGV2ZWwgcmVjbGFtYXRpb24gZnJvbSB0aGUNCj4gcm9vdC4gRXhwb3J0
IG1pc2NfY2dfcm9vdCgpIGZvciB0aGUgU0dYIGRyaXZlciB0byBhY2Nlc3MuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLcmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5j
b20+DQo+IENvLWRldmVsb3BlZC1ieTogSGFpdGFvIEh1YW5nIDxoYWl0YW8uaHVhbmdAbGludXgu
aW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5odWFuZ0Bs
aW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0Br
ZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPg0KPiAN
Cg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==

