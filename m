Return-Path: <cgroups+bounces-2314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BB8985E3
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242082880AD
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB18174C;
	Thu,  4 Apr 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVNWw9n+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162E6D1BA;
	Thu,  4 Apr 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229592; cv=fail; b=LKnvGosFzG8yWvPk/nb1FaQ1GIy3YwHEMGk9cy7dsJYoQJ+hHmJSGB35++GXWoXCiXDU96jKCX9gutgQKnXLgOSGNOWpsTu872TcvGsKuST63ndXdEWkCqkNgjggLRixSN7NAFy/MTh5Z2g+mnuG2CqxAtNoAFgTosVGzafdkbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229592; c=relaxed/simple;
	bh=tD4RG6UdU3/OgxayAKODzP/77CjdlL+sf4xTYDKvOuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EENOQPnZqlAm/zAF/wFyvnXaDLAocwSVXZEaRlaP9eUt/2D8jyvg1t5bV3mPGTW5/0ZH1OzWCwXKhjOrD14wQKlQQplCUY84O4o1oiheCPxe1fp5rJmeoteTKRaQm4W7DNZ6L6xTLxh1lbJiet1y/+fQJ8HxXbRzA97D6mXDoLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVNWw9n+; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712229589; x=1743765589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tD4RG6UdU3/OgxayAKODzP/77CjdlL+sf4xTYDKvOuo=;
  b=VVNWw9n+bII3s9cp5j5fE+qajTxFupiU/17Tnwxf4Wsb0LhhmwLKWCMm
   yxyb3zPkVcViYwh/8T/iDyEsj+Mrw4VBx/2MmGai+5lSLyRGq0ZmhSf7M
   5cM1KIWXqyVBHggsJZkA46ddImRRk+8sT2yPrafyrPYJ7IDi7nwjvHCFf
   e89AcFgTyQdP63K5ML0BnR96qrX+wOh4dVJd1p/CdlPXV14Rhk13Heob0
   LI0sWL3XImdeBAuYq4LR8W4cusU4W5O/+Z7YK25++pHmqIkBXaAC/1Ay0
   uzLjmyPAGTAl4UllGyshaH3aAQlK5zk75d1bl6Js3ZCfveNO8zb7Pb3xd
   g==;
X-CSE-ConnectionGUID: 3Q6gmsTfTf2O9wIzkBHkcA==
X-CSE-MsgGUID: nNZZqBU3ST27pjyK24524g==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7356350"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7356350"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:17:30 -0700
X-CSE-ConnectionGUID: rDhNKBD0QTCpa7h+h7745g==
X-CSE-MsgGUID: CXevjt56THG2rxqckkz8Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="41917859"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 04:17:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 04:17:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 04:17:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 04:17:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 04:17:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcHEmoiGu6PDKeX1FJf+fMr+W1yxLNlmD7bippGokn5RbwNIffcyQi65mhzhHviETmN0NX1ilIOW+XJYukJjo97vk9E82Xtn6nEYt/I1ZBCDDnacaqV9AlBSdy63Mfns+Ayfq77CvpxvMdEvyijE9b6thsoiL+PoSG7TewjWP0xHs2aK2jHykh6D3+54crsoboIBdeljDmprfym16j4FFWaCM/dGTdoyldf8rnAwMxypu7QA8aNCRMM4B+WkJfE+5Qf30pzotd7dRj84z/QuJ81diJ9KBoaDNkMr19ChEY7wqeZOvb/ZwmB26k5nE4AoUU8R1L+PAbGIWAIRu8xohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD4RG6UdU3/OgxayAKODzP/77CjdlL+sf4xTYDKvOuo=;
 b=VxlMPER93+f75xzGMb8Dj+oYYVfx7VRV5u11yg60Vdc8jFh0huQHl40NsREcjh49ZPSwDMvQ1vQr8s1gC3Ac8Mz3lhZHi1JKGrL6Iz8UT1ytavNgvbm5H1/IL3xOT+1wVEsvckKyr19X4EZ8aNwrF2TI+boXHEQHaXVNBlC8UnZTfcaOD5x0kjL9pqr+q7M+VKb1XQi1jiWY9LOptlzWiJ8VaQkzWWgonIwoD0DNH6u8m8m2/GYK/+iaz+a89eftuqNtAG+MvSBAQGSbHwZOoQJakhoKwnbtDo9aYAsLyFS59fk4J6oppzOz/c41fG4Bi+cFauSyovvH6TaXbffJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 4 Apr
 2024 11:16:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 11:16:55 +0000
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
Subject: Re: [PATCH v10 09/14] x86/sgx: Implement async reclamation for cgroup
Thread-Topic: [PATCH v10 09/14] x86/sgx: Implement async reclamation for
 cgroup
Thread-Index: AQHagKYLcT2mglD0z0mJ5usuVyn07rFYAeKA
Date: Thu, 4 Apr 2024 11:16:54 +0000
Message-ID: <cb5a76983bc195e1cfb2a4e2c96c31d694e5b777.camel@intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
	 <20240328002229.30264-10-haitao.huang@linux.intel.com>
In-Reply-To: <20240328002229.30264-10-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB4915:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkWNDC/7/e9SHmlKKSZnJLwKQYTA051bU1rrhCVlCOpNOAWP9O3+EbcWZXWaCs3k/gUuV5FwBHZHjjf/iirgyYPQ/M+sDBCbINqCy8N7D8tn+97YAQHXnG0MJr5tURT/5EmCU6DTO+zdCS3XpG+XbYbfiIUCWo+vAhE1wxRFgcWypH4q+4MMAozkkRT2RJPfNDTVfvakOLZk+G7iP3lgWuQ9oIs2iaFks9g0+qyD1yoAlsiAiGtlNQ2RT99aQvt2yLL3YlQsAj2SmhRG0/bjRlDw/VANkrCayC8Oxg8Cq1g+eMXNWszy1PqJK6Wis/qmIhrebuU1y521ILKqWhnLGZwaFHJdwFsr6+8mrHqlvn729uMo37H8zTLXquqfyTSCYYEYLNBwkUhrPRIuVSHOijjslIlYMQFsWGVb6r/0eC+EMTXCDz0HlwpXsaiMeOV1Gunh947d1PGHjhg4g92sPn5voNtEwfTBpq0oNEr2pkf5P6BIVoIfig42opbDe7NHH5I/+PAWoefk8okGNLUnhXd2d9JjdLCSMh+n+9mAD18soe9zbD7I6F8Ugl0syPyvLOKZbr40QkoT13mo/xL1O4m0RKZYflBKVG+zu2LXJ1hlR0lQHsKmM7g0ji91W77FAC8flON0mRqi9ig8bQF+t206KR9f9qIF7fTjUHZ7+0iMgEOVMaGHYHq5CDUSyi10brA62IyAYZHnw3263Ni+eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkJrVWprUENqRExHb1RjWlU4RVcrWko3MGZ2QUMxOWRBTCtPaGR0S250T1Rm?=
 =?utf-8?B?NldQbnUxU3FsS05NSVhJK3JSbTQ3ZEZpUlhmalp0bmJQclp6dnNKM0FsSDMw?=
 =?utf-8?B?anRQRmxEZnpjbHp3elBsanY5ZTcvay9lWjlMejJZZER1Uys0L0IvQUFNL1Bn?=
 =?utf-8?B?K2N1NkExL1N4ZUd3Z1FYRWwrNFVBTE1JQklEWk1SQ1VtUGoyT21tZE5BTDZK?=
 =?utf-8?B?b1duL1pmbFh2aXlkVzlmTDE3TCt5WmdpL21sbVRRWStYKzVZbTFiUGc1anh3?=
 =?utf-8?B?TVBWWHhIYktHWWpNNXdGUS9jZGVoRDN4QlBJbWEvY2d5cUVqM3NIa3pvejBk?=
 =?utf-8?B?U0tpRlp6L0NpL0w1Z1hMajZkb09TV0oxSlpuKzJHaDJ1MHcrMGt5Q0JxbVBk?=
 =?utf-8?B?M1Jobzc5TVgxQ3dFT2dmREM2bnllV3VWdy94dnBBNG8yeDY2WHZXVDBtZ2JT?=
 =?utf-8?B?TjNpWm9BdkR2YzBoSEFFSFYyQXhONTBvWS9SRXdMQ0krYmRHcE9DWXp6Tmtx?=
 =?utf-8?B?VG13Q0FCczRhdFFuajQzaXpMZnRzMnpUQWhVUDRiVzhCMnBWazErczR6cGwz?=
 =?utf-8?B?bFRKeDUzWERSZUc2dmE1VjdwTjhHVVc3UXJMajJZU3JWSitQYllLdmd5bldz?=
 =?utf-8?B?VDV4WU1NNjhWSURUOUEyNWZsb3VMb05IelQ0Ykh5bys2ZThXUy9mdjl3ZENy?=
 =?utf-8?B?djRLM0VLMi9yZFYwamxXd1RwL3c3WDNXMFJ3bHNVcG0wSnZLTXpqaXpaQmFk?=
 =?utf-8?B?VTN0OWthRnJvZnpXYnpFQzN0VGpEM05hYUZwcEdjSHFtV0JXT1JJVThJMXkr?=
 =?utf-8?B?V1pjWTBEN2pqRUxnT0QzK3h1N09LTGxGWlZ4MXhrS0xJTmxyRHNlMlhzb1pk?=
 =?utf-8?B?YWpaT0VKaWFxMkRmek5xL1dTWWMrMVQ4b3Nzc0hqUURqY2dCeWJVeGpWaHVM?=
 =?utf-8?B?SVB4K1pqV3g4QTcxZXdRdFdFOW9TNThCdTQ1bVBXeFBEVlZzVWFuamc1T2k4?=
 =?utf-8?B?WjdnMEk1VHoydUM0dzg0TVBJTVMwWmp4a0thOTFSQ3ZTZVJocGRyR3k0a0g5?=
 =?utf-8?B?b2tNRm5XRlRhZXNHZVVJb0RpbDlCQ2hwaHdkYXhOd2VsU25IRlNaVnNjVS9Y?=
 =?utf-8?B?emhPVEFXWUc4dE81V0ltZUNENXdSbFVpMUc4K1ZLNXJMOGYxTXlxWEQzanZa?=
 =?utf-8?B?RFRIVkNtcUlpQjNSV3I5c09QT3J0ZVJiUXN4VE81Z0l6VjljaUxEamo4UzBB?=
 =?utf-8?B?T1hJRnZzYUdqRm5sUnZVd2VNbzlpNjNoYmp5L0k3QnFiaThYUWVrVVduejNU?=
 =?utf-8?B?eHlwaWEzRXREaFlFOGV4aWRHajdsTUVsWExmQ2hOakhIdGJERk4xUTRaQThw?=
 =?utf-8?B?TVJQZFo4NWFzeVdWTWsrMEtXeHZCZDdsdW5odGdUWmh4a2w4Q05JSWpPek1Y?=
 =?utf-8?B?cWpCbkl5dUxzTm1ETlZ3M29PN3Y2dTBFNTViRFFBQzI5YStFdGdWaUJ2eUhZ?=
 =?utf-8?B?ZFNpVldWNFNXeUhhR2xtaG5aMnA4TjhWL2k0QnpzS0ROVHdaa3R5SnpiT3Q5?=
 =?utf-8?B?NmZNVExLeEdiQXVtVHd1dDcycVNzamdqWGdCS3hveTdSR2h6dXBtVzRDME5G?=
 =?utf-8?B?MXJORTZQdCtzZVg0aVhlMVQwTENlYVJIRGlpZXBhbWQwcmRIL2NhYVgyMytt?=
 =?utf-8?B?NDRvekNLdlp3Rms3eGhJL21sbFNoOEw0djRaY0w5TWY3d0Ywdzk2Mll0VVp0?=
 =?utf-8?B?SXJTQjJpcTNKUUJUU0xydXBLRlpyZ1doWU8zZWs2eEY1Y0tKOVhnR25Dc0Jp?=
 =?utf-8?B?SmV4QWJXRFM1cWgrcmNTazZnM3IxdkZCNGtaWW1MUThXSGJieGhEQmJheXRY?=
 =?utf-8?B?NE5PRFZQVXIrSG5rdE9YZWFsVU1TTHp5TFJPbnc5MWpDbS9QSzRQOVg4SHdu?=
 =?utf-8?B?ZE9Od2FPMmtqVXI5d09GTFJOdVYyTTdvajgwTkpaRXpVU2krckFIMlFnYzNa?=
 =?utf-8?B?emxxQzJ1THRpTmx0MUNoYTFZUDVCZ1hxN0NEMUdKVnNUNGxNcHZnYXNWd2ZP?=
 =?utf-8?B?bjN4d3dNdTlpUkYxRUlFYVBJNCtjN0VNN3VwLzUyWkZjQVhINHZib25TMXNJ?=
 =?utf-8?B?azBlUU9UNXZOZHpwTHN5WGxFUGlDWFcvdTNGZ0VuRjNNeGVmbzFsaXVEWnlZ?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2770B2374DB47E4999DFB9952BF8225B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40662030-bcca-47ab-0e76-08dc5498bbf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 11:16:54.4934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIz285Ww3jjMMdIOqxa0+8xTd5acpoRAPAJqju9XrO4/lFImuIBgNzR+4aL0d4IwCFziVOoUAjca3oJvYB0DSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDE3OjIyIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IMKgDQo+IMKgdm9pZCBzZ3hfY2dyb3VwX2luaXQodm9pZCkNCj4gwqB7DQo+ICsJc2d4X2NnX3dx
ID0gYWxsb2Nfd29ya3F1ZXVlKCJzZ3hfY2dfd3EiLCBXUV9VTkJPVU5EIHwgV1FfRlJFRVpBQkxF
LCBXUV9VTkJPVU5EX01BWF9BQ1RJVkUpOw0KPiArDQo+ICsJLyogQWxsIENncm91cHMgZnVuY3Rp
b25hbGl0aWVzIGFyZSBkaXNhYmxlZC4gKi8NCj4gKwlpZiAoV0FSTl9PTighc2d4X2NnX3dxKSkN
Cj4gKwkJcmV0dXJuOw0KPiArDQoNCkkgZG9uJ3QgdGhpbmsgeW91IHNob3VsZCBXQVJOKCksIGJl
Y2F1c2UgaXQncyBub3QgYSBrZXJuZWwgYnVnIG9yIHNpbWlsYXIuICBKdXN0DQpwcmludCBhIG1l
c3NhZ2Ugc2F5aW5nIEVQQyBjZ3JvdXAgaXMgZGlzYWJsZWQgYW5kIG1vdmUgb24uDQoNCglpZiAo
IXNneF9jZ193cSkgew0KCQlwcl9lcnIoIlNHWCBFUEMgY2dyb3VwIGRpc2FibGVkOiBhbGxvY193
b3JrcXVldWUoKSBmYWlsZWQuXG4iKTsNCgkJcmV0dXJuOw0KCX0NCg==

