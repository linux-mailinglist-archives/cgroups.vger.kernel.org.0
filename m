Return-Path: <cgroups+bounces-2667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C948ADE40
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 09:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D701F24595
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A094653C;
	Tue, 23 Apr 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBmdHWOh"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D628689;
	Tue, 23 Apr 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857416; cv=fail; b=IZHHwcD+AsyQdyk4801lG5IQgI94ahdWFFc3CrbsCat0CSJyFqx8kj7Gt6VImW2W63hZxsvYbQLyM1JTJfsd8gbQ2P9jJ3Yqu+8b9j6bZVd0uEMdv0RaxFgDKHjsQLlUbvn4ifs5QaqY0Z04rEvxb7hWvBW0SoNJOO4d1EMZl0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857416; c=relaxed/simple;
	bh=EZ7va/0Ck4c0vjHC/mU1uzcAbuY1cCVduhbG6/8OBUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pbADpqyF3ZkMJjFbEbV7wJQMFwxduGFS2qr4yNgshI16RwnsKC4ty7PiRVD5m4Af1rCfobFSkmxLSpSFhRtA0l0Nvr6yWxJMWIvt6V9IUIrtLrUHlOpAA2FCsTHxvM3JUflEU+QCDmoQ98GW2W/8hMmmxQ8utN+SggygGDjtSfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBmdHWOh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713857415; x=1745393415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EZ7va/0Ck4c0vjHC/mU1uzcAbuY1cCVduhbG6/8OBUQ=;
  b=MBmdHWOheJaPuBzI7HDlQstlZax8zinwFAUWDydgaxvxrjcF/gvLJ/j7
   PvYtpfYlvVwGLnqk3DqBdwKGGFmqbgHim4QVFd3iOdys26jN2f0PRAuGt
   8U+P2gVPiPx1wqLGVYecyT2FWs1goqCYa6kOdfvDzlJRDI/6K2wp0k56i
   7nlbNw58bVaiszmqQ2uxytu98tnRriTyPTRbAz/02SKsloVI0M48SMksS
   u3sWI+nHaiRDNHQg3lEmwfeDfbkytIi9JbFbGGlHf+Kbj8FM4CmL0qnlE
   4fWqFBjU+X75UelXd7VIPgwbM8VHh5SVpEj4OC7wiYLneb/t3wwq5xLNz
   A==;
X-CSE-ConnectionGUID: kq+bLdJAR4agB/BCbA0YOg==
X-CSE-MsgGUID: bxTM21iMQsig8N1u+lInpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20122606"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20122606"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 00:30:12 -0700
X-CSE-ConnectionGUID: TkEzTutmSxCb2aPDNGVL/Q==
X-CSE-MsgGUID: 2ZPm9TgzR4qmBkaNMD41rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24255181"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 00:30:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 00:30:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 00:30:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 00:30:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 00:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSBJBEds+BcI4fWXhRXfpQ34DMDwCeNhOT+Wha75k0TV8I+mriMNigIxS3VljO+eFUnOuCWa5hf9JF8MWcIjcLsbKuGCGwgzHKGnoabV6q7g28SsmdIyRpxG62W66quI9iSdz0lA8U9Xak4teISnN6M86s2g4Td9MyEmZuSiQ0cCn5HZ5Vx9QriPjINRJ7kktunx926WZhd3MSeTQr1tTEtcPFd2tET4zN+yF2iEupBgPEHFckiIUURCSKOlIJVtLISGXGpHk0gEb1Vebmxko7y0VSPXv4TXP3u/ZxcWL3Cv9MchncuWzr4TcRPPOxpIbqS68qJFPtXhG79oT3K1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ7va/0Ck4c0vjHC/mU1uzcAbuY1cCVduhbG6/8OBUQ=;
 b=hSP2HmGMiQ0/5O2bSPg0j/oUeIoVixLukxDY2jS7Pm044K9c48qAdXPV2IzFVuUmRqFpyGzCXTw+640MrkTyjj6hkqMC6T3DKPtmpFNXOd3eFnlvyO6n24dHBhWIfHHXPivMMX7RoyrHw7Mn375h3uru1HGr7MmqEGVFbKFLUUVmlR+rr/0Z8M+5Omu4FE8UgrX6yqEo2acHjEgC9Jk5JZYLHf9+y8ZMhbHKSV3SguRl9+N8MEhC/1/h0kEmhSwJZzdg98bV+GCuGPc88s5E3GrDQkLJ8MveKLv8oGIPQ0YeuyVV3AHbALHobYw/KROuUsq78zBHfQ9AiBXIPjZpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB8544.namprd11.prod.outlook.com (2603:10b6:806:3a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 07:30:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 07:30:00 +0000
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
Subject: Re: [PATCH v12 13/14] Docs/x86/sgx: Add description for cgroup
 support
Thread-Topic: [PATCH v12 13/14] Docs/x86/sgx: Add description for cgroup
 support
Thread-Index: AQHaj60LTKabAAIJQE2h1vS5n2oKnrF1gLuA
Date: Tue, 23 Apr 2024 07:29:59 +0000
Message-ID: <51a2d88dedb3431b3bcd3557eaa5c938ab466b02.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-14-haitao.huang@linux.intel.com>
In-Reply-To: <20240416032011.58578-14-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB8544:EE_
x-ms-office365-filtering-correlation-id: 944eae15-551f-42eb-f702-08dc63672eea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?eVhlWnlEVjNTNUxVSmdsekdoZ1RPQXhIT01uQWZ1YXpZV0s4MERMSzl3Nzdn?=
 =?utf-8?B?NkZXUnVIczJPYzNwWU1QMXlUOVNLL3FxcUNPVWNOREhMc0hsL2s3N2RxcEdi?=
 =?utf-8?B?dE82bU5TckZZTTd2MEJjbnZKWHFuaG9pY0lsaXRPeWNRcWk0Tk9tREE1U3FY?=
 =?utf-8?B?T3o3TjltWW91dmlzekJDRzJlN29KTzdEQ3JrMG42QUkrWldmVWNROHVPcTdr?=
 =?utf-8?B?S2VaZW1HK1I2S3czTEIrYlU0SnY1OCtudW9RNytuNW9mcUpxY2ExSU5CVmtm?=
 =?utf-8?B?TEtSdjRwbWxZSnJVdjZYUmVWKzJsVlJNRzdYVjhvbEZiUHpnRVJiSXFVZExQ?=
 =?utf-8?B?UWNjdy9oUW0ybDcyTm8wK2Y4a0lwRWxXa1V1VlBaaXNLUFlhRnZXaXNiV01m?=
 =?utf-8?B?U2hDSnFRVldoUGpwaVdaUjBzcGVMd0IxSlE4YXZXdmNnT2hIOWpzV1lqc0pl?=
 =?utf-8?B?d2lsVlIvYXNEckNxVkh1UUZjU0pLTC9zSWZVUE9HZXRhdVZkclJKd1FqMitz?=
 =?utf-8?B?UFloT1luZGd6V3Q0TWJVZjgxZHdXYjN3aU82c1pqVEVoelE5U1pvUzhpR2t3?=
 =?utf-8?B?d3hMSUVjZEg0U29jZ2xId0pSTnpTcU9LUkFlS1FGQ2RNT0lDYjliekh3Rk1N?=
 =?utf-8?B?Sng3aU5vMmNFV3NZTFduaHVnc29nSFlZdUlpZkFOTmxLd1QvM2lKWHVrcDdV?=
 =?utf-8?B?U21oUk1DOTBpdXNNTUFzbnJ2Qk9sOWNLaUprV0FUYVBHREJ0UnMvMVZqUHJp?=
 =?utf-8?B?S2d5OEVtT1ljK1Z1d2swTUlSOCtLTjRtcFhyaTRDbzlpWC94L1Mrem9wMTNT?=
 =?utf-8?B?YzRId3B4OGtTUmVPSHB0TlNmVzBHVE5LWmhXaEp6S0JTdzEwRkltdHVtdWV4?=
 =?utf-8?B?anUwQ3Y0VWlFeGV3eHk5TzIxQ2dXdXhUSDdzN29oc2YyOXJvNE1MdjFvaDBP?=
 =?utf-8?B?U1hxb29YeEdGMjhKVTNyeVhSOVhONnZEMHNnSkx0Y09EZFFnVUJCMXNIZnZJ?=
 =?utf-8?B?dEFNLzBKVUJ5Q0w2cVVGS3NrWjQyWFNoWko5OUV3N2xXdzRON2xRYzRyZEtB?=
 =?utf-8?B?VFZkWHE5REVpUlVDQTc4TCtxYm83bEo2RzkrRWpLamZIZWE4ZFVaa1BWZmN1?=
 =?utf-8?B?SEFjMStXTEs0elNlSCtmWk5EVzcvd0JYMWd6N1lCbitGNkh4eVoza1RoNTJm?=
 =?utf-8?B?MkNHSXFwOGV1Z2V3czM5RnNSbXlhejhqY29rV3ZRcG80dGtZZUxiczczWEV3?=
 =?utf-8?B?ZWQwWnVpLzhHKzQ0Q0ZTMXVCUnAwempoVGJlcmNJbGNCWlkrTDdGLzZVS3Ji?=
 =?utf-8?B?Q29DVUlSQjFVM2dDeC9IalhTTTl4Z3lBcVJnMTcycWFLQU5tY0tUVFNBSnRQ?=
 =?utf-8?B?YTdvaDR2M3h2OEdud2g5bDMyT29iQTdPamgyK2YzYllyR3VtMVhKWVB0dVhS?=
 =?utf-8?B?WVJJQUcweFFiOGRnRXB6bmNOYnRSMElEQ05tTzYrdExTOFJKVEtiR1FFOWQ1?=
 =?utf-8?B?QTk1NGJGWlhOM3VwVGJKK1NrT1lLTmJ3MXY3RjVSb1hhNDlGNmNoUXlTaHZE?=
 =?utf-8?B?NXBzQ0M4Y0F4RER4cGl3c0oxalFOOSt4bXFyb3BvaURYVHM5ZXp3U2d0a3B3?=
 =?utf-8?B?L1dXMUl6bUo2NlViTEtsUGtIS3FGVVAzeitpT2hBYmpaeUhrR0J0NHFEZGxW?=
 =?utf-8?B?eG9GOVhpM1VDVTlaUHZJYnVlQXJWMHhNRUNIdGg3dUFoUmY0dHk2eU9NZHd6?=
 =?utf-8?B?S0RpdTExMWFhWVgzUDVvbDdmcXQwSTNZNXVpcWFRendvdFR0eVQzYnJxZDNE?=
 =?utf-8?Q?rxiP1NDotRXBknBy7JtETTODbZstv2Am2hgw4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHhtUklXaGxRcDk3VWpwZWVqTGR0dUk0TDlXdkhTeEdzUkhOajNzK2FTVUJp?=
 =?utf-8?B?OFNXWDQ2QWZnV0dibWQ4Y21PNW02amQ2NzZtRHF6aHNPT2pYZDBmTUkwQmlN?=
 =?utf-8?B?eHMvc1VUK0hBd1RMajZPYTlScEprMDk3QWNXK3NIT1FqZ3ZnWEQvbGsyWVZv?=
 =?utf-8?B?ZHNIUWJNU0tkVnFJYmhlL1M2c2xjMUZwOFVHUGp4Z3lzdEtMVjg4V2dNUnQ5?=
 =?utf-8?B?QXJHN3RNYXF0bFVLRUEzWUdiUlNLSzZyUEk2dy81OVExay9VQ0RJZXkzNEtT?=
 =?utf-8?B?eTBnelpoeFZqSSs5YXRXdEdsbmYyQnJOaTJQV1ZkcWU1dmt4WVFlSUI0QU9o?=
 =?utf-8?B?eTZwTk11a0FaLzhxUERENW5rbWtPRjUyaWhPOXFNOGd2NzF6TURWcU9hM25L?=
 =?utf-8?B?eE0rNG9qM3dxWnFQOEtTcVBud3FpUEJGSzVWSzBSc21IOGJOY0owdVA2TVZY?=
 =?utf-8?B?QmxHMGNDMUZydzUzSFdPcW15bm5ZQy8yY0JzWGJyT1AzZ3JReFk2QXhMUndZ?=
 =?utf-8?B?SUpGRTd0Slc3L2pRMWkwMTBQRGpYdFN5cWVyNmNRd0dzdTVKcVhCWUk2cGlu?=
 =?utf-8?B?LzUxYzZpdHZxVm15ek91QWtkRjlTZjdOc3ZPYmdDQjc5WXM3UllyQnlYdUlP?=
 =?utf-8?B?ZTkrai85TlZKMGx1ck82UzVnQjl4UERzRWIrakhNM044K0l5YXVxNEIrN2p3?=
 =?utf-8?B?Nk1La0J6NFVkdGdseG93Tkc0L1ZPakoyZDBGbHc3dlZub21vZ3ZtcHhxL3Jk?=
 =?utf-8?B?UFQyWXY4anNUVFQyL0h2cU9kWHFDT2VuK3NBLzhPUHdkYTQwcE4vV3ora1J4?=
 =?utf-8?B?bEkrc3hrQmNJVkZLNnppQ3RqVUNpWGV3c2NRQ04zTG9LMGlJb3ozSHVwbnpj?=
 =?utf-8?B?Nm1Vak05RTRWMHlHd1ZqZzA4ejhlN0o2aG1jWk9KelEwNTRnS3dMeFRZWXdO?=
 =?utf-8?B?ZFEweHNLZVpmakRDWjlLZW9nMXFwbllrbVVWdndVNWloYS9lSWlyeXRnK2Ur?=
 =?utf-8?B?TEhDWTFSai9mYWlaWGp1dHNPOEk2dGFPY216WWNqMDVmb2hUMTRPUjk1WWlO?=
 =?utf-8?B?UWVYZk9DMTVwUCtENTlFbmVVbk80ay8vZVhtWmZrV0RuSGdiSmZDUzNBQk5p?=
 =?utf-8?B?VWdlM1IyY0tJTVRuaFhLMUt5TlJLcW5ISzEzK0tNT1l5VlJsZDRMNG9MeGZu?=
 =?utf-8?B?N1k3SlJjUURTeWJQUUdOa0gwRDBtTzJObXlzZHFqbCtXMlBpS1M0bHM5c0pm?=
 =?utf-8?B?M3lxYTJZMy8zUGFMT2ZWWXNvRDdmZkUzUUFnT3VvWk92V2NlbjlnYVluSmxY?=
 =?utf-8?B?SmwwUHBsWENCMkxwaEYzNHE3bXhaUFlQU3p2bTQvZzVQUDNJWXpRVTh4RC94?=
 =?utf-8?B?Z01uUnl3TnUwZ1BYZHVPdnVDeS9QUkppYjBCclJVME91WWtCRFlaT2wyZGlS?=
 =?utf-8?B?bXBRWTh3SGVjdjhjNFc2bXpMRFZtaHhhVTdLZFU4cHJZY0xtd09BZDRLakd2?=
 =?utf-8?B?Vy9USmludnF6aEhqTmNlUFhPdURJNUxXM2RwaGFJVTh4RnBvQVhqK0c0VlE3?=
 =?utf-8?B?amRIc3REOC90QVhtMHVpeGUrb285WkhKT2Rvek9pVE5nTThXRndzZWozazZU?=
 =?utf-8?B?di9YM3ExV2ZGU29MZ1hZamZjZm5JcU1KUDZkRlFsRFA0YzR4aGJOY0kzT2JB?=
 =?utf-8?B?TWVZa2o0ZXBPTkdTenAwaDJRUUEyZEZrdVNNUUplWm9BM2pSamVZQUNUTjBG?=
 =?utf-8?B?K1FkcUVSRkFES2NSd3FRTUtrMi9zZ1ZncDBRcXhrNkRNWHBDUmkxRXY4L0Fh?=
 =?utf-8?B?ZmIxL2FUMnNMVU5iaUdFUHRsYkFyRXJmOEN6V3JDb1E3WE1idm5xMCttcTBa?=
 =?utf-8?B?Vmh5d1AzOGZIUWdrYzJqMjdBVU9PMEhYVXo4a3JkMkpTd3lMVllHS2RkeVIr?=
 =?utf-8?B?b1hpdEpJSDFadzc5MnVnb1NSU0ZmTlI0N2tXeWxEQS9nMW9ZeXR3QmFEaVYy?=
 =?utf-8?B?VTB6cTQ4MFl1RWxWQTNINDNGUGIxTWNHdDdLRE5zdUhPWkZLblNueHVEbkVr?=
 =?utf-8?B?dW1tZzkzMHJiY0pqUnlQMVF6OFRISmdqZFhXcXljR2ErMjBMTmYwTjJseGNV?=
 =?utf-8?B?bW9mNXgrS0FnRmJmTFRlaE8wb3Jma2xrM0ZkS0tjYk5LSURFeHhrNHc3MnI2?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC0C6233FD99C648BB9311AF2BB2B67C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944eae15-551f-42eb-f702-08dc63672eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 07:29:59.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veida1ZoIZ4ViUvvr1iykZDTD2DMbOwHfFN/AoPSwKDdAoFLAZn+tSYS8VldB6oUzM5Ld3xsdWUbFEwPcwrj6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8544
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDIwOjIwIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBBZGQgaW5pdGlhbCBkb2N1bWVudGF0aW9uIG9mIGhvdyB0byByZWd1bGF0ZSB0
aGUgZGlzdHJpYnV0aW9uIG9mDQo+IFNHWCBFbmNsYXZlIFBhZ2UgQ2FjaGUgKEVQQykgbWVtb3J5
IHZpYSB0aGUgTWlzY2VsbGFuZW91cyBjZ3JvdXANCj4gY29udHJvbGxlci4NCj4gDQo+IA0KDQpB
Y2tlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K

