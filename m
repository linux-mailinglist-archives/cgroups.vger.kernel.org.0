Return-Path: <cgroups+bounces-2631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3365F8AB759
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5748C1C20B1E
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0826113D511;
	Fri, 19 Apr 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt1lFiEe"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D82BAE0;
	Fri, 19 Apr 2024 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713566706; cv=fail; b=izE23XlfSy9E8doDQMM83M5iq2yLqZwe1Ru08++M+L80q6sdSotzlHnIPT9YF9E/F+bxh7N0JKcbPHfHw0/BSFXsCevKAD9CeAFKa/Iw82ovjppcl0f9lZaBQpZGPRaDtzh57h/vqxJq3tGdwpSsxSVYgSm+Uh5inS2hk8TYtZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713566706; c=relaxed/simple;
	bh=QwEDDkHg7hzaKo1soGaltqbRVnW+UfX2thimVszIYcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pEyf4Ra3f81qJdSuK/m6V1fQiU85xpZOdKyrY/pgPdc4XYqLbWYVzIDPth8PoJDWQSmGMcpaWiMqXbYEKY77gFRJftRd33+RlTeHpvY+7t9/WQvx5cDRafR1v2VHfAUECuwADmTrLu/S9E7yA9Q+lG7n8rwfPmvIADLlNVn6Cg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt1lFiEe; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713566705; x=1745102705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QwEDDkHg7hzaKo1soGaltqbRVnW+UfX2thimVszIYcU=;
  b=kt1lFiEebz3CkAVBrNgIcfWD+aN9zEeAKpGoZybODPOXNMLppvvwSaU0
   ZsoLwPyy/Uqre6uJ1JI9YlwiQpk1XqYCFxX/Ft79CBy5SgXDS7fKkcJ9S
   4sA3r/h095PaXoVvsZtRrjvSTguBbZzYm3EuzdBYv4Gjp3rJd1OtoZ5GE
   SopgWee1FmaMquqqFGyER6+szQuH+IC9XbNFnIOJXguugAAmCuvF3L6EW
   Bmq1+XHsN645/ABibp1sTULfE0q+xQV+DnWg7U382+EC71D8Tj0rrjpI5
   Knm3VzXGVVPXexGeb+eNR2JBipgN1xuVC5ZURU77u2FOFFodIzY7armdI
   Q==;
X-CSE-ConnectionGUID: AEP/PR2VQPaQseKYVt22fA==
X-CSE-MsgGUID: u9jHSloiQJGR3fvR2LhpGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34586351"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="34586351"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 15:45:04 -0700
X-CSE-ConnectionGUID: z1IiAK4ZQlGfGiirU/uohA==
X-CSE-MsgGUID: T1WMYX88TDKESQfMXzptgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="28119580"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 15:45:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 15:45:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 15:45:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 15:45:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPc2BJue4PlPqXF+nYSNkUNeqkyP1H4meGA3pXFELjinKHJUYoMmp9YKPVsA8WUtSlMymtgpNV38Uubnq0jsnADsv+VPBrzYAynla7vh31QDzrmTauU4fjzVP5YOjrAN70kEUsbZD+9VXvPrwaHS90IMt/4W/QWspKYQZH5RZ9seKNhZzlbr19hL8qWq/EaxLgzZ4bLhrK/caCkZuxUWuo/NtR0fNzvRRKO0xvsjHQYwB7jyeji9SkUiTegy/I1IGNfiB/Z+dtBkonkwIFBD3/wNjLbMuGcwc9h9i91xcpibFK2B6K04/4jNnr3IuBUCL8g28ETQeyKxLi4SGu4Rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwEDDkHg7hzaKo1soGaltqbRVnW+UfX2thimVszIYcU=;
 b=box9DGLS7MbJ/AdI5W+r4w3deR7RAqyVeBKvyaLA6bcK7aI7iQv0XeV6KG/i8edShPUhwusPi4DSKBu5lsz4q5SfAh+YCesYhVlHQccqeVympn/jwiSDjUeBSNYF6yox+vZmtlUBw2vJqq0I9o9s38tIwfGAYw57kids9MEir2DGUqB33gphm2f6kQU2uw9giYsi+QYOTfHkUHXLjcXEh93KpAMUJ4ht9eZHkJ3ti4MX09zLaRnJkK7f6meVgcwkJK6+d9Ofdi15VSMNM9ZRVddS8u2k5ecxKGw2LQ0Q/OcdvQqHAnyHg9GQQw4BFkmr+nnx5BThHKPJ5LxGNfLhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 22:44:59 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 22:44:59 +0000
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
Subject: Re: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
Thread-Topic: [PATCH v12 09/14] x86/sgx: Implement async reclamation for
 cgroup
Thread-Index: AQHaj60Hm4kuVj4TEkStIzrrR8Dgw7Fu03YAgAEjfYCAAEAagA==
Date: Fri, 19 Apr 2024 22:44:59 +0000
Message-ID: <4be309656cb4e03793703098bbebab3dee93077e.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-10-haitao.huang@linux.intel.com>
	 <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
	 <op.2mhn6ti6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mhn6ti6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6358:EE_
x-ms-office365-filtering-correlation-id: 14fd6abb-e37b-4766-029d-08dc60c25805
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005|921011|38070700009;
x-microsoft-antispam-message-info: JrdJVmKqpdPZZCkK6BVF8gxeHIA7jUV9O92ZOdxzdLUZO2mWgchQGhRuNu5LCFr/jnu9yf/EHAiyImPZSA+14y3JhV88549DHpShPKOEja+n/+r+wbI/9OY7WU8YBDS4BmEl3JAl7KrVWkHAeSgk/0KA5QZ2xyR33Ub+e1dEc4+g0BU7X+fFfd90KJFdu5J4zoQX13bCO4omt21JnldlRlYovsyKOAO41vGjiYclj4A8VEZ3umDz7MVttZocZBMa2RCBaUTL2h8YzVAMfNIW7+OBeGdOT55nQvGTwgNIXHaflh18dBv5UENRykPvtMXJLJ9qhBrahaLlp+vdp15+c6JEVTy2/YDUpk7JkuRbtTzpPTrAR6jkHlQ70VnCHPwQY4LP0DVynjt4e/eLNKLGXo7fG/JwU0HVLK6WkOGzL4piD3vhRkGgxoRX/X/7amry3i8nRKwmeb2HZbu0nbFOpvYIRQcCCtgKLGoo12EN2VxBJ4I5jwk44z9H2h88bwlf5HiVjxdp17gpJRFdAZXZoInR6MvfEq15BGr5w2bs+G1sWjKtSkeZUqthztciLovxf4+w++8pZ1R/kTOEMohMdarlwHugJrsIos34PH8ezlH8rAHEjdYZyCmk2eOKqS63ReWyZKUEtaIhfZcu/ncYxrwJSmeO0/UbYUbtH7H4GKWovH2L3+6nIduYQfJ/6LbFiIPTAQXlD0J/2GCvP6C2roaD7NKg3ZBZfTDW2oFNgKQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFnSTNya09NRkJ6Wmg3VWIwZUQ2SWI3NUhjSG14N0xSMzhjc0hkWmkxVE5X?=
 =?utf-8?B?L2tRYW84WVFLcjRvbWZPVVkySkRYRkpMY2h5WDFWVzVZOHh1R3QxNC9GVjU4?=
 =?utf-8?B?eWQ5Vk5BMjJ1ZE9UNkkyb2VqSWVkTDh1VGRmamRMVTdLT0dlVEhlek9DOGdW?=
 =?utf-8?B?bTdFc0lIWnNBTkVzUEdWV0xuTE0rdkpzUU5Kb1o1TlhwZGpRTnlzNTgwT1RF?=
 =?utf-8?B?WlFUei9PMW9veU9mdVRMYWsvSm5RZXBPbE9XbnBzUXpRSi9NTUhkR0NJamw3?=
 =?utf-8?B?dWNFOHp3N25oRWN3OENHY3B5c3pVRGJpNEd5ZTZOK3p5cGplYXZ2K1V6MzFC?=
 =?utf-8?B?Ky9MU3JRbmVYV2lrYTBIOVFEd0JoS1ZtczBuQXRZbkc4bzBGYmRUSHdKdVk4?=
 =?utf-8?B?Sis5WDQzSzFVZnZHNERKNUcrampST1NpdGthUHQ3ZVVaeE12a2hiODF1V2pV?=
 =?utf-8?B?OFIrTmYyTE5vWHVnL0VPNUUzSmdENlZMTXpSWTgrSVU0c2M1WitWZEE5Kzdn?=
 =?utf-8?B?VVZEbFd3Z0p1dkRwYzFSQUVGTXJhTzZ1SnBHOSt1bzU2ZWpDcC83VUNpTjY0?=
 =?utf-8?B?NWFDQ3hJc3M3TDl6TSt4Z3FjSExEYlZSTmFGOGMxSjVrTTNPbWttTkErbHdY?=
 =?utf-8?B?SlJTZ3dXQ1l6VWtpU01FbmE1RzBEL2VjY0huTjAwVUJ5czRsU2d5djNiRWhh?=
 =?utf-8?B?S2c1aDgvMkJxRHd5K0tHcXNGdWFNZVVxMFBHQ01pR0I4TTNVRTRISTR3UHFV?=
 =?utf-8?B?TGgrbnhySGtOSXdPZUlPaU5UdExwbG01UFMra0Z4UFdvMWt3UCs0c3c3MTZ3?=
 =?utf-8?B?V1dqUWlBbjFFVWFPVDl6SEgrLyt3cDdyY1VjT2JIR0xNa0pnUkF2bUZNYnFF?=
 =?utf-8?B?VHllVEROREw5b29hVTlsRzhXWm9QbXNTUEg4czh2ZGNOaDZaaHptUFdJdjNS?=
 =?utf-8?B?dWcvd3hpbzJsRkxuNDBaUUJJckQ2QWRid3FmeWdvQkNIN09NamppNVlmSW5U?=
 =?utf-8?B?c2s3RWtlNldocEZkcHVmM01XNEc5d0JaVXVQUDRadnB6dUFhbitNanZ1SHNR?=
 =?utf-8?B?ai8wTE54UEpIQllSTEIvcVJOaHJteGRXK2xiNjdmeHJyTTg5VTdkbnUzUnJh?=
 =?utf-8?B?WXlUcUlzTGNhVXdnSG9DL2dwVUN3RkgrbG0vQ2YzWStsZkcvdUFOb2hQNDc2?=
 =?utf-8?B?dmxRVWFuc2J0NFJDOHFqMDZ6cnNkT1ZZeldJNFJodUg5UnZHK01tTHlKWkl1?=
 =?utf-8?B?YURETm0vVnFGcUxHUnJ0L2x6d2VFTnl1NFljTmJ0Y0dYSU51MzlQQzZUdUYw?=
 =?utf-8?B?LzA5QVBldUlBY2VLRzc0M2VMNXVkZm1lMHpzT2JtS3JmR3E4cldLVFlxYmZH?=
 =?utf-8?B?UmNRR2RleEFVUSs5bmk0bS9DNkVlSCtOVTMvWEJnckNwdnNpZlVDU3JRUzV4?=
 =?utf-8?B?TXlpdG9GWHNMdHlFcGV0RUZoS2toY1djTndPZUFLRXZjdnB3U0JBNFduRkNK?=
 =?utf-8?B?T0hPT0k5dFlRSW5ZNmtEZ1EvRGZid2o2YnJsWlZvQ1hudW5rZVBGcDRwb3Ar?=
 =?utf-8?B?cTBNNldNdVhnZDZJY29UZitaVW5GcXJ1WWN0M3M0bnpkcTBzQzUvQXAwWm1m?=
 =?utf-8?B?elV0RGREQXZjSHJqUm96RFVyeFhTYy93VnNsa2tvbWxQUHZjNXFnTUNFdGVw?=
 =?utf-8?B?U1NPUEVxdVcvelVFZENQMVhxTE1rOG4wRkhoRWMvWjlWazNJVko4SExCOU80?=
 =?utf-8?B?bE83VGN1UUlPQ3g3U3JtYTJ4YVg2dlcxRytCTGliOWlpRjN6YVJ1UXFKNE9B?=
 =?utf-8?B?WDBPRlhzbkF5Qy83R3EyUzE5SmNOenZGcC9XSjlsY0dCVkt1NnhQbld6S3do?=
 =?utf-8?B?SHJjYnZ6WFFaYzdrRmpFQjhDUjVvajdZajZBK0dpUGg2NUovUjE1OUU3RWQ2?=
 =?utf-8?B?MmpMV01Dc2RUZ003aTEzZkZoaWhIeGs1Q3JUeS9uU2c0STBKNDZnMTJXOHlt?=
 =?utf-8?B?KzRSWmpBNlFSQkVVSC9DL3IwRENMdUxqZFF2QjRmQWtYZDhsRUUrbXlwZnZX?=
 =?utf-8?B?dDZkdXhKb1ZscWova3dHbkxoeFpnVzFSYlVER0tETExEck1lZVdvRXlrdW12?=
 =?utf-8?B?RzZKbHRLWFZrc0NRaUtmUU41UWVTb0tpcnFFYnBQa2YwS0JVT3BBaThkb2RQ?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F8D1E067E5C7B47980E9D1F60193B0B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fd6abb-e37b-4766-029d-08dc60c25805
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 22:44:59.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRpgKHhFce7OOMCJ57HZpuGkngeUA//aEBI+OqFCRT26Tbn1GNvXzNVl6nT2GqmH5eefInq8LXC9O48OtdGNbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTE5IGF0IDEzOjU1IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFRodSwgMTggQXByIDIwMjQgMjA6MzI6MTQgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiANCj4gPiBPbiAxNi8wNC8yMDI0IDM6
MjAgcG0sIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBB
Y2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ICBJbiBjYXNlcyBFUEMgcGFn
ZXMgbmVlZCBiZSBhbGxvY2F0ZWQgZHVyaW5nIGEgcGFnZSBmYXVsdCBhbmQgdGhlIGNncm91cA0K
PiA+ID4gdXNhZ2UgaXMgbmVhciBpdHMgbGltaXQsIGFuIGFzeW5jaHJvbm91cyByZWNsYW1hdGlv
biBuZWVkcyBiZSB0cmlnZ2VyZWQNCj4gPiA+IHRvIGF2b2lkIGJsb2NraW5nIHRoZSBwYWdlIGZh
dWx0IGhhbmRsaW5nLg0KPiA+ID4gIENyZWF0ZSBhIHdvcmtxdWV1ZSwgY29ycmVzcG9uZGluZyB3
b3JrIGl0ZW0gYW5kIGZ1bmN0aW9uIGRlZmluaXRpb25zDQo+ID4gPiBmb3IgRVBDIGNncm91cCB0
byBzdXBwb3J0IHRoZSBhc3luY2hyb25vdXMgcmVjbGFtYXRpb24uDQo+ID4gPiAgSW4gY2FzZSB0
aGUgd29ya3F1ZXVlIGFsbG9jYXRpb24gaXMgZmFpbGVkIGR1cmluZyBpbml0LCBkaXNhYmxlIGNn
cm91cC4NCj4gPiANCj4gPiBJdCdzIGZpbmUgYW5kIHJlYXNvbmFibGUgdG8gZGlzYWJsZSAoU0dY
IEVQQykgY2dyb3VwLiAgVGhlIHByb2JsZW0gaXMgIA0KPiA+ICJleGFjdGx5IHdoYXQgZG9lcyB0
aGlzIG1lYW4iIGlzbid0IHF1aXRlIGNsZWFyLg0KPiA+IA0KPiBGaXJzdCwgdGhpcyBpcyByZWFs
bHkgc29tZSBjb3JuZXIgY2FzZSBtb3N0IHBlb3BsZSBkb24ndCBjYXJlOiBkdXJpbmcgIA0KPiBp
bml0LCBrZXJuZWwgY2FuJ3QgZXZlbiBhbGxvY2F0ZSBhIHdvcmtxdWV1ZSBvYmplY3QuIFNvIEkg
ZG9uJ3QgdGhpbmsgd2UgIA0KPiBzaG91bGQgd3JpdGUgZXh0cmEgY29kZSB0byBpbXBsZW1lbnQg
c29tZSBzb3BoaXN0aWNhdGVkIHNvbHV0aW9uLiBBbnkgIA0KPiBzb2x1dGlvbiB3ZSBjb21lIHVw
IHdpdGggbWF5IGp1c3Qgbm90IHdvcmsgYXMgdGhlIHdheSB1c2VyIHdhbnQgb3Igc29sdmUgIA0K
PiB0aGUgcmVhbCBpc3N1ZSBkdWUgdG8gdGhlIGZhY3Qgc3VjaCBhbGxvY2F0aW9uIGZhaWx1cmUg
ZXZlbiBoYXBwZW5zIGF0ICANCj4gaW5pdCB0aW1lLg0KDQpJIHRoaW5rIGZvciBzdWNoIGJvb3Qg
dGltZSBmYWlsdXJlIHdlIGNhbiBlaXRoZXIgY2hvb3NlIGRpcmVjdGx5IEJVR19PTigpLA0Kb3Ig
d2UgdHJ5IHRvIGhhbmRsZSBpdCBfbmljZWx5XywgYnV0IG5vdCBoYWxmLXdheS4gIE15IGV4cGVy
aWVuY2UgaXMNCmFkZGluZyBCVUdfT04oKSBzaG91bGQgYmUgYXZvaWRlZCBpbiBnZW5lcmFsLCBi
dXQgaXQgbWlnaHQgYmUgYWNjZXB0YWJsZQ0KZHVyaW5nIGtlcm5lbCBib290LiAgSSB3aWxsIGxl
YXZlIGl0IHRvIG90aGVycy4NCg0KDQpbLi4uXQ0KDQo+ID4gDQo+ID4gLi4uLCBJSVVDIHlvdSBj
aG9vc2UgYSAodGhpcmQpIHNvbHV0aW9uIHRoYXQgaXMgZXZlbiBvbmUgbW9yZSBzdGVwIGJhY2s6
DQo+ID4gDQo+ID4gSXQganVzdCBtYWtlcyB0cnlfY2hhcmdlKCkgYWx3YXlzIHN1Y2NlZWQsIGJ1
dCBFUEMgcGFnZXMgYXJlIHN0aWxsICANCj4gPiBtYW5hZ2VkIGluIHRoZSAicGVyLWNncm91cCIg
bGlzdC4NCj4gPiANCj4gPiBCdXQgdGhpcyBzb2x1dGlvbiwgQUZBSUNULCBkb2Vzbid0IHdvcmsu
ICBUaGUgcmVhc29uIGlzIHdoZW4geW91IGZhaWwgdG8gIA0KPiA+IGFsbG9jYXRlIEVQQyBwYWdl
IHlvdSB3aWxsIGRvIHRoZSBnbG9iYWwgcmVjbGFpbSwgYnV0IG5vdyB0aGUgZ2xvYmFsICANCj4g
PiBsaXN0IGlzIGVtcHR5Lg0KPiA+IA0KPiA+IEFtIEkgbWlzc2luZyBhbnl0aGluZz8NCj4gDQo+
IEJ1dCB3aGVuIGNncm91cHMgZW5hYmxlZCBpbiBjb25maWcsIGdsb2JhbCByZWNsYW1hdGlvbiBz
dGFydHMgZnJvbSByb290ICANCj4gYW5kIHJlY2xhaW0gZnJvbSB0aGUgd2hvbGUgaGllcmFyY2h5
IGlmIHVzZXIgbWF5IHN0aWxsIGJlIGFibGUgdG8gY3JlYXRlLiAgDQo+IEp1c3QgdGhhdCB3ZSBk
b24ndCBoYXZlIGFzeW5jL3N5bmMgcGVyLWNncm91cCByZWNsYWltIHRyaWdnZXJlZC4NCg0KT0su
ICBJIG1pc3NlZCB0aGlzIGFzIGl0IGlzIGluIGEgbGF0ZXIgcGF0Y2guDQoNCj4gDQo+ID4gDQo+
ID4gU28gbXkgdGhpbmtpbmcgaXMsIHdlIGhhdmUgdHdvIG9wdGlvbnM6DQo+ID4gDQo+ID4gMSkg
TW9kaWZ5IHRoZSBNSVNDIGNncm91cCBjb3JlIGNvZGUgdG8gYWxsb3cgdGhlIGtlcm5lbCB0byBk
aXNhYmxlIG9uZSAgDQo+ID4gcGFydGljdWxhciByZXNvdXJjZS4gIEl0IHNob3VsZG4ndCBiZSBo
YXJkLCBlLmcuLCB3ZSBjYW4gYWRkIGEgIA0KPiA+ICdkaXNhYmxlZCcgZmxhZyB0byB0aGUgJ3N0
cnVjdCBtaXNjX3JlcycuDQo+ID4gDQo+ID4gSG1tLi4gd2FpdCwgYWZ0ZXIgY2hlY2tpbmcsIHRo
ZSBNSVNDIGNncm91cCB3b24ndCBzaG93IGFueSBjb250cm9sIGZpbGVzICANCj4gPiBpZiB0aGUg
ImNhcGFjaXR5IiBvZiB0aGUgcmVzb3VyY2UgaXMgMDoNCj4gPiANCj4gPiAiDQo+ID4gICAqIE1p
c2NlbGxhbmVvdXMgcmVzb3VyY2VzIGNhcGFjaXR5IGZvciB0aGUgZW50aXJlIG1hY2hpbmUuIDAg
Y2FwYWNpdHkNCj4gPiAgICogbWVhbnMgcmVzb3VyY2UgaXMgbm90IGluaXRpYWxpemVkIG9yIG5v
dCBwcmVzZW50IGluIHRoZSBob3N0Lg0KPiA+ICINCj4gPiANCj4gPiBTbyBJIHJlYWxseSBzdXBw
b3NlIHdlIHNob3VsZCBnbyB3aXRoIHRoaXMgcm91dGUsIGkuZS4sIGJ5IGp1c3Qgc2V0dGluZyAg
DQo+ID4gdGhlIEVQQyBjYXBhY2l0eSB0byAwPw0KPiA+IA0KPiA+IE5vdGUgbWlzY19jZ190cnlf
Y2hhcmdlKCkgd2lsbCBmYWlsIGlmIGNhcGFjaXR5IGlzIDAsIGJ1dCB3ZSBjYW4gbWFrZSBpdCAg
DQo+ID4gcmV0dXJuIHN1Y2Nlc3MgYnkgZXhwbGljaXRseSBjaGVjayB3aGV0aGVyIFNHWCBjZ3Jv
dXAgaXMgZGlzYWJsZWQgYnkgIA0KPiA+IHVzaW5nIGEgaGVscGVyLCBlLmcuLCBzZ3hfY2dyb3Vw
X2Rpc2FibGVkKCkuDQo+ID4gDQo+ID4gQW5kIHlvdSBhbHdheXMgcmV0dXJuIHRoZSByb290IFNH
WCBjZ3JvdXAgaW4gc2d4X2dldF9jdXJyZW50X2NnKCkgd2hlbiAgDQo+ID4gc2d4X2Nncm91cF9k
aXNhYmxlZCgpIGlzIHRydWUuDQo+ID4gDQo+ID4gQW5kIGluIHNneF9yZWNsYWltX3BhZ2VzX2ds
b2JhbCgpLCB5b3UgZG8gc29tZXRoaW5nIGxpa2U6DQo+ID4gDQo+ID4gCXN0YXRpYyB2b2lkIHNn
eF9yZWNsYWltX3BhZ2VzX2dsb2JhbCguLikNCj4gPiAJew0KPiA+IAkjaWZkZWYgQ09ORklHX0NH
Uk9VUF9NSVNDDQo+ID4gCQlpZiAoc2d4X2Nncm91cF9kaXNhYmxlZCgpKQ0KPiA+IAkJCXNneF9y
ZWNsYWltX3BhZ2VzKCZzZ3hfcm9vdF9jZy5scnUpOw0KPiA+IAkJZWxzZQ0KPiA+IAkJCXNneF9j
Z3JvdXBfcmVjbGFpbV9wYWdlcyhtaXNjX2NnX3Jvb3QoKSk7DQo+ID4gCSNlbHNlDQo+ID4gCQlz
Z3hfcmVjbGFpbV9wYWdlcygmc2d4X2dsb2JhbF9saXN0KTsNCj4gPiAJI2VuZGlmDQo+ID4gCX0N
Cj4gPiANCj4gPiBJIGFtIHBlcmhhcHMgbWlzc2luZyBzb21lIG90aGVyIHNwb3RzIHRvbyBidXQg
eW91IGdvdCB0aGUgaWRlYS4NCj4gPiANCj4gPiBBdCBsYXN0LCBhZnRlciB0eXBpbmcgdGhvc2Us
IEkgYmVsaWV2ZSB3ZSBzaG91bGQgaGF2ZSBhIHNlcGFyYXRlIHBhdGNoICANCj4gPiB0byBoYW5k
bGUgZGlzYWJsZSBTR1ggY2dyb3VwIGF0IGluaXRpYWxpemF0aW9uIHRpbWUuICBBbmQgeW91IGNh
biBldmVuICANCj4gPiBwdXQgdGhpcyBwYXRjaCBfc29tZXdoZXJlXyBhZnRlciB0aGUgcGF0Y2gN
Cj4gPiANCj4gPiAJIng4Ni9zZ3g6IEltcGxlbWVudCBiYXNpYyBFUEMgbWlzYyBjZ3JvdXAgZnVu
Y3Rpb25hbGl0eSINCj4gPiANCj4gPiBhbmQgYmVmb3JlIHRoaXMgcGF0Y2guDQo+ID4gDQo+ID4g
SXQgbWFrZXMgc2Vuc2UgdG8gaGF2ZSBzdWNoIHBhdGNoIGFueXdheSwgYmVjYXVzZSB3aXRoIGl0
IHdlIGNhbiBlYXNpbHkgIA0KPiA+IHRvIGFkZCBhIGtlcm5lbCBjb21tYW5kIGxpbmUgJ3NneF9j
Z3JvdXA9ZGlzYWJsZWQiIGlmIHRoZSB1c2VyIHdhbnRzIGl0ICANCj4gPiBkaXNhYmxlZCAod2hl
biBzb21lb25lIGhhcyBzdWNoIHJlcXVpcmVtZW50IGluIHRoZSBmdXR1cmUpLg0KPiA+IA0KPiAN
Cj4gSSB0aGluayB3ZSBjYW4gYWRkIHN1cHBvcnQgZm9yICJzZ3hfY2dyb3VwPWRpc2FibGVkIiBp
biBmdXR1cmUgaWYgaW5kZWVkICANCj4gbmVlZGVkLiBCdXQganVzdCBmb3IgaW5pdCBmYWlsdXJl
LCBubz8NCj4gDQoNCkl0J3Mgbm90IGFib3V0IHRoZSBjb21tYW5kbGluZSwgd2hpY2ggd2UgY2Fu
IGFkZCBpbiB0aGUgZnV0dXJlIHdoZW4NCm5lZWRlZC4gIEl0J3MgYWJvdXQgd2UgbmVlZCB0byBo
YXZlIGEgd2F5IHRvIGhhbmRsZSBTR1ggY2dyb3VwIGJlaW5nDQpkaXNhYmxlZCBhdCBib290IHRp
bWUgbmljZWx5LCBiZWNhdXNlIHdlIGFscmVhZHkgaGF2ZSBhIGNhc2Ugd2hlcmUgd2UgbmVlZA0K
dG8gZG8gc28uDQoNCllvdXIgYXBwcm9hY2ggbG9va3MgaGFsZi13YXkgdG8gbWUsIGFuZCBpcyBu
b3QgZnV0dXJlIGV4dGVuZGlibGUuICBJZiB3ZQ0KY2hvb3NlIHRvIGRvIGl0LCBkbyBpdCByaWdo
dCAtLSB0aGF0IGlzLCB3ZSBuZWVkIGEgd2F5IHRvIGRpc2FibGUgaXQNCmNvbXBsZXRlbHkgaW4g
Ym90aCBrZXJuZWwgYW5kIHVzZXJzcGFjZSBzbyB0aGF0IHVzZXJzcGFjZSB3b24ndCBiZSBhYmxl
IHRvDQpzZWUgaXQuDQo=

