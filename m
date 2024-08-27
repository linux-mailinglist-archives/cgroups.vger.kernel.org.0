Return-Path: <cgroups+bounces-4503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4B096074C
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562F2282A21
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 10:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1379D19D8A9;
	Tue, 27 Aug 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8DsYkFd"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD91993BE;
	Tue, 27 Aug 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754075; cv=fail; b=L+/rftScMARk+t2dY7wN2H/HhGgQsUJbiU29p5BZ3mL6eZhVdVITODTrMAzrHZseuoGvyEWOHu6mASSHHtUNa36fkkRl60QHKX3T08MSAeHYd8tcLOD+0tIewzSPXLG5uskykTaYMEuuEXMJaOmps1ygcaB2XX4E2b7t/1BsPio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754075; c=relaxed/simple;
	bh=tN+TizRUp3D8HkM2uq4ElzOXWjhgi5HrIElLHdXBIy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mKmiJ/92rADTlt7quXxMp94ieTJEENFP8+DXJ6aFE3UExnvdH7gIPzuCeSgEsZm9knwH7PNxUnBzap5rccHng2PPpmgrVazOFH0A04RkrutljJt5RcdSnOhRslbRSPKzuPMyLZ8mad8xSOxOlsiwijgUBy59rY924xzIEAQTv0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8DsYkFd; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724754075; x=1756290075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tN+TizRUp3D8HkM2uq4ElzOXWjhgi5HrIElLHdXBIy8=;
  b=K8DsYkFdsoFFDuPqY8luYlU7vCbvkyWsdqRQjWKeTgHJNBw3vLngwi0e
   PY2GPVWbPOMmDU7q90Y77hqC33gs0vLtrGEGNGx6ZZy2y78H2d0ZxccU6
   hV+jF0PW/uLfDGucvX1wBraWS9pSd/Os9gc8WYdBlrv0Ff1PVvXvVPmaK
   Rg5ptbAiC5SLW1x8+vMANS60hCG42NF28OTxHBUuSfpPcJIUhbW25PgiS
   84kDd2suEIskKlYLs4LARhi8z83+/HV3yCgaeHzlp1YMroKs/CYiFTWg8
   c77dt7NIGniaEOVyl1QGIHJAzTTgZmA6YFZX1oha6RAs7/Q4zO0mgKnrd
   w==;
X-CSE-ConnectionGUID: 38YOsR8lTaOXXZMu/QrQSg==
X-CSE-MsgGUID: B8brjl9yRdGTm3O/ngzOUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23026511"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23026511"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:21:14 -0700
X-CSE-ConnectionGUID: nHzfU6VARc+pVYN3Q7TJ0w==
X-CSE-MsgGUID: Iu5hKJ46Q/WWg5uo87H++A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62979250"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 03:21:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 03:21:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 03:21:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 03:21:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 03:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePQPEqJqjh53YypvkkGm4T87Q9wNe0zdHdDVqGBhkMkX/OhmkLJ5A3/JXgthRH8CalYhLsIyu6KTsmP81KkKlb0vMlIh7EN6EHUzV5V2ijeGEG/LeSYbzEb0FSTf/3YRWLK1WMXzQBBOL2+kql37GWVyIEgSKjiQiuuw9we4i6NkWcLdzuUL1AgzUpMP5Z6WFmYo0kidmRUGGP9tQs5JIleiOs7kAL97wpGuYbABjwztTtba8xgX/SNBr1fJXBQ/yxtJgrgRYx7+VLluWS5Ag+MjZ0uqw/Qzvwk2cDzJPqPG35uAKdGxzEDl8hGgZ9lFPj1IOyZxYw8aB2lFOtH0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tN+TizRUp3D8HkM2uq4ElzOXWjhgi5HrIElLHdXBIy8=;
 b=kxnL7GJJs9+1BTzUjBYcsCE4d/1TsxkPCCvR9q4H2SK6Gr822S2ujiydkmz853DT/7N9mbvoyAyxZHwZ+pgLOV0FGHYpOk+QcvGba3kW5EWNY+dhJSVQ24RyRgCB0eHYctzaO4761nHAALgmMlzDnYH9JSS1pYoQKTvl8jSk1mcv6c1czW0lrnnTC+ZBDWXImdeUF5w6sgv1nCjxsoqD0+sRupRmaMhjihEK6g5SZxP3wxawUtDOj3FXPwXYCaEFOkcmxsetxPudaS2I83oWlUEFb9eoc8R20DPhulD6kXLopa7Kg4FD1hOMCzsvbunvcJgHlk8EL6JGnqNli2wy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by IA0PR11MB8378.namprd11.prod.outlook.com (2603:10b6:208:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 10:21:09 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::a5b0:59af:6300:72ad]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::a5b0:59af:6300:72ad%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:21:09 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "chenridong@huawei.com" <chenridong@huawei.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v16 05/16] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v16 05/16] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHa820bfFPegux5L0yH36REQOKR7rI67suA
Date: Tue, 27 Aug 2024 10:21:09 +0000
Message-ID: <ec3b451f727493fea87298e70aba7c281ca920d4.camel@intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
	 <20240821015404.6038-6-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-6-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|IA0PR11MB8378:EE_
x-ms-office365-filtering-correlation-id: d70f4a96-56da-40e8-6e69-08dcc681f808
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bEdJNFVRUUtWTnZxVmcyTTFzdmdTcENpcG1yeVo5djF0SXBYeUV2S3VqRDln?=
 =?utf-8?B?bE1xdTgvZGxjbmhsdzNjV0Q5YjhwT3plWXZtQXMxTERCVENpK21aUHdWdjZM?=
 =?utf-8?B?RXRBdVNITWRQVDFtZnVmWmRLdlp3NHhxSXNpK3pmRVZVOU1sajV1S01kcEdy?=
 =?utf-8?B?cFVrd0N0TnhNancxRWtESVNkOHI1RlJoQTdja2Q2cWpxMmNEamk3Q3ZTdWhq?=
 =?utf-8?B?UHVYY2x0NTN3UGtiSnRDMStBa2pPdWx5YisvdGpxTzJicW92LzlWbDFiODZX?=
 =?utf-8?B?UHQ2VmIrY1dSZ0g1NjdsOGwzdlR2ekpWa29MSzlOUVRLMFZ5cklLalYrV21R?=
 =?utf-8?B?ZU5QUGVhTkk0b2lRakJEWFNDdHg5ZjdsMHVSY1B4N1U1a0Y3WHp6WU9DY1lQ?=
 =?utf-8?B?dE01bGp4ZmRKM1lNVnl0alRJTGhHSko0cUhTaVFnWmZjOWRmSCtzQytWelph?=
 =?utf-8?B?azFRb0wzTFA2RHo1Z1VVTEcyMmVVbmRnUHJWZkV6dkllU1ZQTCswMFhlbll4?=
 =?utf-8?B?VUNvK0MxdHY5ZkRsSHJReFdQK1Y1cUFmeHFGY3dhT1NYdDFjT05IRys5UnAx?=
 =?utf-8?B?S3FRT1dwRXdNTFNsQVl3SHIwZXJISS9oQWN0ZWQ4bWwvWHhDOFZMM0ZsQWhK?=
 =?utf-8?B?VEJCeEg1clNtaWdJSUlsSzl3L1BVYmRCVTA4WFJUVWt6TnNIZ2Z0ODhOMFdD?=
 =?utf-8?B?ZmhzbFhVaStVVXBlMXdlMy9Jb2R6SWs2RFFnWmlmYVN1WUl3eEpNWlZWZm5T?=
 =?utf-8?B?VEN1R0h0SEFjNG9ST2Z3UHJlZXRsTnBiUVUrbHBsV0dZSHZaTUdFYnFIejk5?=
 =?utf-8?B?SjRmSEVmMTYxcE1CNXhwRXRCVmpaTVZBWWN0NGpkZitHaERPbDBMRFhGM01I?=
 =?utf-8?B?QWtnQzE3QmZOMGFhOTZnbkEzRUdUb1hSWlcvY2JjdVM1eHpJVGZTeU1IRDFu?=
 =?utf-8?B?TzhYYVE4VTBjbkVHMElDNnE2MkFOOUx4ZGhKd1Q4WjJWUTlFUDRqeVQvdkll?=
 =?utf-8?B?WTMvakcyOFB3LzJVaHNldThHQjRibFZRa1hteWdOTGpqdkpFMUN2MWMvVE9k?=
 =?utf-8?B?aUFuNFdIT3RMekJObENXeXlwVTJSalNsbkVDeUZKaU4wdkZuRUZSdjlrWUtC?=
 =?utf-8?B?MVVPc29VQ1htdWJzUlRLRk96dlovRDVVVTlCVURRWHUyN0RQdTkyaHYrSWdV?=
 =?utf-8?B?S0liTGFBYzZ1N2RMU2RCTHI0VTRtWUM5UW1ZdFFZQWQ0STh1N3ZHL3Eydm9S?=
 =?utf-8?B?alp4Rmt2Q244NFFyazRFOVZIZmdQNTdsVTZYK1ZaVUZab0p6a0kxbnUvaGMy?=
 =?utf-8?B?NEN0dDF5Nnh3ZDFjV1BTelQraXcwaW9rVzR6NHFCWjdmZXRzYndVd1lmNnRr?=
 =?utf-8?B?WDQrdnh4UkIyTDNCZjdxN1EvVHk0UXJab0RUd1MybGtNbU9idFpybGtYS1lU?=
 =?utf-8?B?Z1pLUmdFZWswTi9xOGRzVjJJb0hhR2lTT2hjY2wxQkp5dVRUWG56OXFUYkIx?=
 =?utf-8?B?MjdMd2tBRWhmLzdWcm1BRGl4M1RZdG9TZitaTDRoMjl4NlNqYkNPU2ViQlow?=
 =?utf-8?B?bnhiaVQrT0JiOWdUZ0ZxOWovSnZWbDlxa1JQMlEzQnVEampOaWdlTVlBdWJW?=
 =?utf-8?B?V3JoR09TcFZmQThCcmxxVEFqbnpOVmNtV1RZQklMYjhMVUtrbGxlUkVTMXgx?=
 =?utf-8?B?emNOc1pvcjgzNXA5Sy92SkJTZFpPRXQ4VGsrYklMQm9nTUk3TVhTcy9PRVdl?=
 =?utf-8?B?ajR6dWhGd2NPM0VNRFdBMURoK1FydExXK3daeDFUOE54QUZTY29kSkNYQmhP?=
 =?utf-8?B?bGFKZ0F0UGRLc1ZVdTZ3eHJZWURyaVVpRENPd3FtT2o2bFBPcElQTWtManIr?=
 =?utf-8?B?U1Vod1g0WlgvZzlpODYyd3diWmo5Q1lvOXJjcHdrOVlHaFF5Z0xkTEVtV1Nt?=
 =?utf-8?Q?NBOmCrvio+g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmlVbDJ2d2ZWWTFQVzRicnBkUGZBb0kwRXFJWWxEL2owd1NhZEl3VXJOOXNU?=
 =?utf-8?B?TWxqRmp3b294NWk3dTIwVE9wazhzMUpPWENkMkEzK2pZZFhXWWczQmpyVW9R?=
 =?utf-8?B?RjZFQjk4ZlVKbk0ydlFSbmFRYVhDSWJjOUk2YzhCbUtMMUtTRXlQZlIxeWVt?=
 =?utf-8?B?SnhxYlJZdkdGR1Y0RkNBMDJuaVpabjJJYmZlY3pTR01uYUU5NWxYMjRsTjBT?=
 =?utf-8?B?UER0MzRhUG1JRWVscEF2TE9NQkhsbFBMZHIwbXhrYmJENlZRQ3NpQmN3MHlJ?=
 =?utf-8?B?MzNUZXRLbGJrU2NVR1hISEIwVUVuc3FzSXcvd09EQkhraWlpa1ZRYnZQVXlz?=
 =?utf-8?B?SmgvZ3V3TDV5cHEyeU0zZmUyREpZbzVSd3ZEaFBDWXBXRm9CV1JySVhYdE5a?=
 =?utf-8?B?K2ZtYUk2V2E1Ynl0eGVFOUw4RTFVd0R4RlFvMFl6L0R2VEFzRGVteDdxMFdJ?=
 =?utf-8?B?L0FSYXpvY3JYM1h1WllRU1dkUzc2T0g4b0NDdmlOTEVyL21qcnhwQk1SL1dW?=
 =?utf-8?B?cGp2QWQyKzZ6WURBcCtoRldaVlNaMUpINVZYZFNrUmlzVnN3d1NkRzBXaGEz?=
 =?utf-8?B?bUVOVWp0WVV3cXZ3Z2Mzay9LcnlaNFR6Rkt4MkJXTldhZThYRmhXZzA0Wnlh?=
 =?utf-8?B?ZnNPYjNmeXY1WldyNWo4L3ZONHVxeVhIa1FJNnd1VDB6OUZKM08yRXptOGRa?=
 =?utf-8?B?S0JhakYyNEVSZGFRSkh1WnhOVzJraVZxaDBZL1l4ZFFneDRCMmo1RkhMUWZa?=
 =?utf-8?B?ckVkVFRFVnJNekZNLzB0akNKeHZUQU8rcTFFc1U2NkxJVi9rNHBLOHptbHZ5?=
 =?utf-8?B?aGlxL21PdVF5ZDRvNjlYRHdhcng5Yko4UkJPVEdIZUNPZis5K1F3cmRPMTBx?=
 =?utf-8?B?WkF6VFhkVGR4c3JTVGpPNzNtSVV3SDJOV1o4cmRRZy9UNXVIN0JUZkN3RUZq?=
 =?utf-8?B?L0ZxaXlCVzVQVVU0Zk42VzR0T1plM0pWL2Zobk5TYVlxQm5RNW5ZRnZnYXE2?=
 =?utf-8?B?cWJ1Qk5xVGZaODV3YmZKWUk4bE5yaGhNQjYwV0F1SWtmVjVLejVzdlhNd3g3?=
 =?utf-8?B?MnZ1TVY1Uy9mRXVYN1ZHUVBINmZpL3ZYS1FCT1k1akx6RGZoOGVuY3BIaHo4?=
 =?utf-8?B?ZEhRRWVrUzNWSm4ydkNGK2MzS0pNVmIvRG05L2RRTXFUSFg1aVJiTC9Ya2Mv?=
 =?utf-8?B?T2dJRDNpc0ovZ1VYWVkzWmFlQnFUZllhSnl6TnUrVWFKZWFUNHIrRFJKRmRn?=
 =?utf-8?B?emJZMGsrNUJBRU84T01FSmJTSUZiSld3dHp4ZnJWVXlrdEp3bFIvOTVFSS96?=
 =?utf-8?B?NXp3ZHlaQXl5SzdzT2VHazRvWXBCazFKYkptam5aUUdIVjFXTllFNnhkTDFR?=
 =?utf-8?B?MHdoT2Z6VjhBa1d4Z29YcFI3TUJ0Q2RwWjJvMVFscTFqTFdqcU8zZHBNT09l?=
 =?utf-8?B?SEltOEsycnVYU2tWUzIxZkVqMGFHckM3U3FkSWlEQjB2RU5WTURGK1FUenRs?=
 =?utf-8?B?QXZFdE1SMXJDWkpaeVBCVFB5V2VYOG50ZVpuYzdKaGoyQVZoc0UvRktCUUR1?=
 =?utf-8?B?bUdhY3o2ZHdyTmNHdmdsSjdhajVsT1Q0T3luM1N1dENUSlI0SmdZWEFYYXQ5?=
 =?utf-8?B?YUhCQkNiUWQ0a2Q0OHQzU09LYTNDQWpiU1pZZFJuUUZKVUFVWHlqMnpna2Fh?=
 =?utf-8?B?djljT0ZYUWhpTW5GSy8zZi9iSUF2aGlHWkxXWjRzUXdkU0lnYzI1OWc2N3JX?=
 =?utf-8?B?V3VsY3Z0MEx1Z1dydHl5emwzelR0c21RYTNhWlYzNG5adjB6RkV3TGlUTzBP?=
 =?utf-8?B?ZERWTGd0VWpJeElkZ2JSQnNJQUxRUzhGVWdaNTN0eWhQRlRoYkFwV1didlRT?=
 =?utf-8?B?TEVjVlA5WnNpK1BvTDViK1hFK1oxVjVmRG94WDM0RHp3WDhzaFpMUzJ5WUt1?=
 =?utf-8?B?U2xXN1k2em1IRC9GMFpUaHdHZnliQkxhcnJKWm11TFdRc0dPcXhESkpDVlFB?=
 =?utf-8?B?ZW5LUEdGd1U4bmJhMHBGWkxqY1JTU0xyRjUrN1N3aXF6amFhMEVSZ1ZyUjl3?=
 =?utf-8?B?eUJGdkp6R0ZFNy9CaUh1RmI4MS84dk5hTmNyRkZVU1NHanltdVdwQUs5YVNy?=
 =?utf-8?Q?4MjIs+UzURJXsVb22oSgHiRol?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8875A21F77F0B84D84D1B501D1099829@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70f4a96-56da-40e8-6e69-08dcc681f808
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 10:21:09.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPeCwrDCwjMr19kgDwkbSibjwIo96OuD4pR1tNJ4h2Mv7RPDvPPU5hgpGl3bsvK9uSi32ZDhU5ma6PtDee2Ehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8378
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE4OjUzIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ICsvKioNCj4gKyAqIFJlZ2lzdGVyIGNhcGFjaXR5IGFuZCBvcHMgZm9yIFNHWCBjZ3JvdXAuDQo+
ICsgKiBPbmx5IGNhbGxlZCBhdCB0aGUgZW5kIG9mIHNneF9pbml0KCkgd2hlbiBTR1ggaXMgcmVh
ZHkgdG8gaGFuZGxlIHRoZSBvcHMNCj4gKyAqIGNhbGxiYWNrcy4NCj4gKyAqLw0KDQpHb3QgdGhp
cyB3YXJuaW5nIHdoZW4gYnVpbGRpbmcgd2l0aCBXPTE6DQoNCmFyY2gveDg2L2tlcm5lbC9jcHUv
c2d4L2VwY19jZ3JvdXAuYzo0MjA6IHdhcm5pbmc6IFRoaXMgY29tbWVudCBzdGFydHMgd2l0aA0K
Jy8qKicsIGJ1dCBpc24ndCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlv
bi9kb2MtZ3VpZGUva2VybmVsLQ0KZG9jLnJzdA0KICogUmVnaXN0ZXIgY2FwYWNpdHkgYW5kIG9w
cyBmb3IgU0dYIGNncm91cC4NCg0KSXQgc2hvdWxkIGJlIGZpeGVkLg0KDQo+ICt2b2lkIF9faW5p
dCBzZ3hfY2dyb3VwX3JlZ2lzdGVyKHZvaWQpDQo+ICt7DQo+ICsJdW5zaWduZWQgaW50IG5pZCA9
IGZpcnN0X25vZGUoc2d4X251bWFfbWFzayk7DQo+ICsJdW5zaWduZWQgaW50IGZpcnN0ID0gbmlk
Ow0KPiArCXU2NCBjYXBhY2l0eSA9IDA7DQo+ICsNCj4gKwltaXNjX2NnX3NldF9vcHMoTUlTQ19D
R19SRVNfU0dYX0VQQywgJnNneF9jZ3JvdXBfb3BzKTsNCj4gKw0KPiArCS8qIHNneF9udW1hX21h
c2sgaXMgbm90IGVtcHR5IHdoZW4gdGhpcyBpcyBjYWxsZWQgKi8NCj4gKwlkbyB7DQo+ICsJCWNh
cGFjaXR5ICs9IHNneF9udW1hX25vZGVzW25pZF0uc2l6ZTsNCj4gKwkJbmlkID0gbmV4dF9ub2Rl
X2luKG5pZCwgc2d4X251bWFfbWFzayk7DQo+ICsJfSB3aGlsZSAobmlkICE9IGZpcnN0KTsNCj4g
KwltaXNjX2NnX3NldF9jYXBhY2l0eShNSVNDX0NHX1JFU19TR1hfRVBDLCBjYXBhY2l0eSk7DQo+
ICt9DQoNCk5pdCAobGVhdmUgdG8geW91KToNCg0KSXMgc2d4X2Nncm91cF9lbmFibGUoKSBiZXR0
ZXI/DQo=

