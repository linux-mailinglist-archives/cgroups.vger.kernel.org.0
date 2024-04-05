Return-Path: <cgroups+bounces-2332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80922899397
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 05:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECE028718B
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 03:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DA1134A9;
	Fri,  5 Apr 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh+D/E48"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934491B94F;
	Fri,  5 Apr 2024 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286479; cv=fail; b=J8jeYwYuXKZF8r7MCdGZl6aR6EubguOfp5at7k2oAL9jWeOWvq+Mi5vKPQR3yBHRkJnaenndKb+doYqtXYYy4HPwNP14Uv7j3lMXTjTjGetEaARua9ABQYh2rKB8S+wbiHRINzXpQPp7fGmxaWBYCiq0Zbxz5LQY9PyQrUXil6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286479; c=relaxed/simple;
	bh=1AvLz4qdT8G08VQVf8iy8gPZxX/rmeCeIxj8OjnTI+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/97q/+gwRag6hOj8rlNkRQT/zH5rIRS3g2a0cE+SKtJqlOccXZHBtPe/8/evnNgpruDMIQ0Tw016Lfpw7nHLst/LpTJLMUQsS2H5OtW7TInkwRYAO6XiDv8VUxdso+MEc5P6a8cuip83Zq9ir6ZqjbzYZW3FklzjCGdzo3YNfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh+D/E48; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712286478; x=1743822478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1AvLz4qdT8G08VQVf8iy8gPZxX/rmeCeIxj8OjnTI+c=;
  b=Nh+D/E48QkqscJXGATSCxes9pI3+86CTi7yKgL0GKEnLlJ0EzVJ9fbQU
   WouLSaPaeu+zkQ5tvL6ZSM6k4wzuciiLYIrSk6HxDqAWrn0JWlskzaUU+
   nDxpwcH5kUeygCtF7+eyuT4Twi9vvdfusLrKHHu3v2yR9lyVthpmNtT9M
   bcJ94mxOiJ9owJi9TG2i8bK77gPLG29EPIK+22qQA1nVUG3qYzQwKGlw2
   eWKtFlIOt5BuzJACRIR6y42NlOJCOLddR+/v4uc7RtBa45EYtdWRyEHF4
   bwbaP8qODU+1YTxjBvWAeXVtHPBL9TvIUdFEwLOaQM38RTXXEwV/P/M6i
   w==;
X-CSE-ConnectionGUID: otVGy564Sbiwa81xv8+0og==
X-CSE-MsgGUID: g5NugnkYT+S3KL9MWrXOcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="19037570"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19037570"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:07:57 -0700
X-CSE-ConnectionGUID: f6/MGBpBSaqVJUYb/UD0NQ==
X-CSE-MsgGUID: qm6YbOGOQZ6mBivmVx4Q+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23749711"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 20:07:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 20:07:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 20:07:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 20:07:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 20:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSyq+Ucb4PjSg2mNgeg2ttqP3hvnwjtftknMiuaWcbWEqAvxmkp33z3O7w0SZzewsr0hW0e49ESRtoDjWf57Mou3ISYPmBpQVqm1vvQOQzThTLkptXI+4MDmGY+PxADYgqkZjWnLEvyTGD7i8O2Gyp2AAKpkuKMSPzOHMiW6nIFN85zWJpToD+TxJ+b6FOSTkm1ibJvTefw5W0tnLK3iprhJ/f4JEa2wUl/uuUeX9NDCXzEt1ShC5Xu9l5Ad+fSBGI7VKVX15nhghx1u52rmXBM7Ta83mol4lDZP5jh/7EKPyRMTFcRzonZqrplMIiVCZgpBFuTN2HDi4BpHyO6iKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AvLz4qdT8G08VQVf8iy8gPZxX/rmeCeIxj8OjnTI+c=;
 b=F0Pp94KJMe1SmbYoe/A2l/xZfmawzNpKuYvaVvxoRXvI+PO/xaXudfN7U2m3pXzeWcHh2Fp7B92RWoVl8PYM0jdlyGzAoum4RU1uwYZgWIdWHkBLvVs9F+rcAsLXGOZSTrQTwZcPZ7AyQfV1yeUdODJkJ6dXavv48hqmo5rMlhtD3x54fV8hcb5zt2tUuvBS8Crr7nNvWk9YgNsGMAn9jHo4ZgyDPPzHfmaEr8JpF1jOMLjgQMu8KYpaIWaTZoguKcYU1AWAc8YjpfNJxFpNExSC3lr3uCjwzX4DrmRKE1eoVHmSIrFznXcWsDtYI3TQsGs3TZuJgknEE4xIMtw1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 03:07:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 03:07:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Topic: [PATCH v10 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Index: AQHagKYK1xl+sWyc3ESn0fLYsxjIorFWjreAgAHUcQCAAKhvgA==
Date: Fri, 5 Apr 2024 03:07:52 +0000
Message-ID: <0e406b207c7769359d45ba4e4594174e64ec3faa.camel@intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
	 <20240328002229.30264-9-haitao.huang@linux.intel.com>
	 <e616e520b021e2e7ac385b5b1c41febb781706de.camel@intel.com>
	 <op.2lpq2mtswjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lpq2mtswjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW3PR11MB4650:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AahcGzIXvqHWZGSbJwC7Ds4f52DFQ5CGDWh5zfuB7mOE1r/YRe4AdiRxJuGHJIPyj9UQU4JQa3wvw4z7yp5+X0q0padlKX2Xz839lS5dSB3eIUYA0rVzdgHp7Q/uB7KCXCXOAe+dAEdC1un54hAv7O68AJSxodtOIGJQcZF0MEGGiRw9QaPYI2ZYcPUmFIv49QNJtp3ygLrlth1Oj7KwwDDQ/u2DJYV3Ig0LKdrNYn4nGDnOsx63jYni/Bo00aoYZivDvBt7Tjmdpe4J0+YReVMnSIUFhcbLkZDpxh9Opfu4FbqBjz7sTeW/81aV8oIW54ziH8b2oBjjPgQ1/LPTKNEargjMngKgh8coaFjkLXHuIt3TXnpHt8Xi5oNGvzb5Mz+MCMsvU+1Lik2jzZfb25SeP8naX9CpkPQIGYE0kTRmrTT9bVIFziC2FdEjtELwH3mIaTdEMOhXqDDqBlT4UL+OptWTQQN4k6F7d+meLOm40s+Xp0V55R6Or4Qav+HZm3QgO3J15TekGv9qS3P5OrPKmugyaZ3LKB7XnFgqk0p3tyiszaSHxPnig9mg4EYwdd4/1x95XK3zVGLIAdYdlTh+xzVSXilrmXvoq0sdd434Jj6LYMq+9uvkb6kyO7b6hh0ZM6BnzZh9vYM8MZ6Nj1Qjwnawxy/ye9ZCIcshe1dJTOTamdyE2RpBYOckoN7xNJwks8w6bQGELOdf5y1XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkhTVTNnbElDQlN1a01tMEdiRTJlWXpEcUpOWWZNUDhldjFMVC9oOVB5QnBi?=
 =?utf-8?B?OU5EL21IRUZlWWVJa3d1WWxaQ0xaVm9WYTlxSUEwWXN1MklGbGwzS2RRK2JU?=
 =?utf-8?B?VDNlV1JUdjdpU0xNOEdnVXpBZ0ZockxZWWVQVW5FdEJSelVSdk95U1JLKzRl?=
 =?utf-8?B?c0FqMEdiR2FoclFYcHZtRkYxbmxSSVlVWDlqWmYwcGo0WjRPWHlNUVJOanpW?=
 =?utf-8?B?R0lHQlN4Ym9iRjh3SDZuU08wMEJybWZlZEhDMHptQnkraTlJQXZTMTJoRGJu?=
 =?utf-8?B?RCtyN2x4RVRPM2VrRFJJb2RSNlZ4emJ2VDlXUTlLZlVSZnJOQWpmWDJYWnBM?=
 =?utf-8?B?THF6SFRXMXVYalFKYTNFQnBUYlEzcTRHdXY1VXlKY0xIenpZelFEYnptSjVM?=
 =?utf-8?B?cFk2cWZZVGdvRDV3SlZKcEhjRXlMam04NTBHRDRqMmhLbzdtRG9XWnVUdWVT?=
 =?utf-8?B?N0pMYWJoR1ZnL21KUkhpMzYvSDZ2N2tlbjFyVWpRU0hkejdZQWpHay92bzJt?=
 =?utf-8?B?Skl0N3RUNFZwVmxjWXlTTjBMMUZSM0lWTFJHT2JRT1RPQnZHWFF0aDYzejlZ?=
 =?utf-8?B?OGRiKzdLQVNrcXM1RVBrRUpISy9rUmRMSnZjMHA2T3pKV1RYRmFoc1A1TVdH?=
 =?utf-8?B?YVg1WkJrSnBwQVdUSVFNaGh1VHVrK1V4R1hkTm9OcFV6QXE1Rlh4ZEFnQlYw?=
 =?utf-8?B?SEJPY3MybWR3NGc4WWltNnZpWUx2UGZKZnR2QlBNd1FNY3RIdXdGaGdURUpG?=
 =?utf-8?B?V2phY1VXUFpPNmRscWxLM3R1VzVJKzQrZ2c0UEJYd0hjVVZVVWtaMllUaUJi?=
 =?utf-8?B?a1hTbWJSM2Rranh4V1RXWEd2SDFPMFRSYUhFS3FWLzZGRi9sdnpxS0psbmlL?=
 =?utf-8?B?WjF1RFZNenJjeGx0My9oNk5LY2lHT1RIVjlDTEVWUmhBRmRmdVUrcjd0YjdM?=
 =?utf-8?B?aTJwZTd2aWJmMlU4WEVZSUx0ZmFZUlVBQ3NQOEdzQ2V0NnF2WlFTZmZ6OHJr?=
 =?utf-8?B?OEI1TGFvdjZvOHJKMHRCeGkxUE8weUc1NWg2MW0wNDk2SUZST2ZUbHpUb3U0?=
 =?utf-8?B?NGJyL3FiSndHejhWSVU2NytJWHZyalVCUWxJblpYQkdjTDQ4RWVlYXB5NWlK?=
 =?utf-8?B?YkpldG5YMlJzZnhYbzJVeXhJV0RSMitYQVFGa3d1TXhvNjVPNVdzcEV3TndL?=
 =?utf-8?B?S0ZJV0R0WmFJM2NRTE1GVU5YSGNTNjg2cExidWVCeCtzNlVtQVcyZkdDWVE3?=
 =?utf-8?B?N29kMHFnaDNtRU0rb3BVYXFHV1RXSm5TdlVFd3liQVZvMWRlMExBNnUrNU5j?=
 =?utf-8?B?Vk5JL0J4akx5cWE4aGFNZGV1MHpUeFNpQlV1b2RkZUdZVE0yQXVidElxd1JR?=
 =?utf-8?B?VE8xT1Rnd29qanFWSnhsSVVyd215ZW51Z2NoZ3l4Y2k2Z0hNRzNGc1BkMUQ4?=
 =?utf-8?B?MU1MdjNFTm5Zd2JWSlNEVXV1WDV6N0FKd2h0WnJ5U3RoRUhpSnV0QSt0aVI3?=
 =?utf-8?B?UmV4YTlzM2lOTEVqb3hGc2l0SHpPWm5JWHV6MDc3NThXZ3NRS2NaMzFaWEtC?=
 =?utf-8?B?dXJsRXczUVZKMW5sWFA4RTdLa2haeXBWbU5LU1RTamFmbTdadFhqeENIZHBr?=
 =?utf-8?B?bGV1Sis2MXdnbUw4YWcxZ1BWRFdyVTZkaURtOWljY2ZMa2RSVHRwM2s1alBU?=
 =?utf-8?B?ZFd4K201VWJTVXlGQ21waHVLZnYyNmJUYkdVUkdQeWxXdVNScVB4RFA2MllP?=
 =?utf-8?B?bk1QN2xYTk5rTkhXS2tLME84YzlncXpReVkxaTNLbHorelpzRkZvalc0ZEJt?=
 =?utf-8?B?VkxZN21KVjF6MTFQYTJYdERxT0o1Q0NCUU5QQ3dRWHBqYmx6aEFuZGlhcEFF?=
 =?utf-8?B?SXJqYUs5bGdHcUhjVVY1WTQ1c1FwYThEa0Z5TUd2OFlZMDB0QkVBZzlOMlB4?=
 =?utf-8?B?VHhLdjJnUVNCT1d5RFVjOHpjSGtkZmRmZGk2UE00VDJkQnQrOXNXRC9UOTM3?=
 =?utf-8?B?N1ZvMCtJbG12TGZpT1VTMjdPNDhyQkRCWVdjOThGbEZJS0VSVS9PRzdHWVhF?=
 =?utf-8?B?eFJhekxHL3BaOURuc0QzTHdnVm5tTXZEdjB1WDBtK2VqSldFVXRHM3N2Qmpl?=
 =?utf-8?B?azJRckpQdWp1dzcrR3U1OXJKUHc4eTkxdWFVNmRmN3pacHdHRkVtcEtRb2ZD?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <054EB24694E10747B0F79A2F4F83F9D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5adec3-4c1a-40fa-8751-08dc551d9570
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 03:07:52.9258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3KEz9zT3w0xQ2fUX45GUVNV7E9KMv5Vnwa+pPaYTkPSX1SPcO3mBR+Bnpe/Mj7xzOUEygXgCzrXMTxtPb7nag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTA0IGF0IDEyOjA1IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ID4gPiAtc3RhdGljIGlubGluZSBpbnQgc2d4X2Nncm91cF90cnlfY2hhcmdlKHN0cnVjdCBzZ3hf
Y2dyb3VwICpzZ3hfY2cpDQo+ID4gPiArc3RhdGljIGlubGluZSBpbnQgc2d4X2Nncm91cF90cnlf
Y2hhcmdlKHN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2cswqAgDQo+ID4gPiBlbnVtIHNneF9yZWNs
YWltIHIpDQo+ID4gDQo+ID4gSXMgdGhlIEByIGhlcmUgaW50ZW50aW9uYWwgZm9yIHNob3J0ZXIg
dHlwaW5nPw0KPiA+IA0KPiANCj4geWVzIDotKQ0KPiBXaWxsIHNwZWVsIG91dCB0byBtYWtlIGl0
IGNvbnNpc3RlbnQgaWYgdGhhdCdzIHRoZSBjb25jZXJuLg0KDQpJIGtpbmRhIHByZWZlciB0aGUg
ZnVsbCBuYW1lIHRvIG1hdGNoIHRoZSBDT05GSUdfQ0dST1VQX1NHWF9FUEMgb24gY2FzZS4gIFlv
dQ0KY2FuIHB1dCB0aGUgJ2VudW0gc2d4X3JlY2xhaW0gcmVjbGFpbScgcGFyYW1ldGVyIGludG8g
dGhlIG5ldyBsaW5lIGlmIG5lZWRlZDoNCg0Kc3RhdGljIGlubGluZSBpbnQgc2d4X2Nncm91cF90
cnlfY2hhcmdlKHN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2csDQoJCQkJCWVudW0gc2d4X3JlY2xh
aW0gcmVjbGFpbSkNCnsNCglyZXR1cm4gMDsNCn0NCg==

