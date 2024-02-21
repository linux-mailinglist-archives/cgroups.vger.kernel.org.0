Return-Path: <cgroups+bounces-1730-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD10285D64D
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 12:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1A51C221B5
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656E3F9C4;
	Wed, 21 Feb 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlDMQPDJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC643F9C0;
	Wed, 21 Feb 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513233; cv=fail; b=uGYqfbNEgMtyIG/c/1RGS0OyG7WX/Mu2opNwX43pSoTDCa2gZ0ycQgARnmHscev1fmh2M/GHvffnT4pmfs7BJyU6Hi9EQNPPDHj4+pTzlIVE9qN5O9E36TMINgWOPbpdVxq++rprEjgedSohrk9+CrWeefgSC/cdAVdXqye0diQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513233; c=relaxed/simple;
	bh=4sQC2WhgjYZ07567v7kRYE8KGb9D+tmltcTmLp/Ng+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qILn3ZbOsw4tJvqOhNM03d2l+Ta6+ioQK8DG4C8545v0mW1iy2MC18eZqEJmtvEFErnwjMRx29jL8NDdaPqEv+Wl+fRiF1I/2SDq9ocbKdU+OeMpi0JHqE9Q/BDedAwU87aIJ3g6xm1gnIJ8nNPtMS47lgzz1C/xoIkO4KbmkZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlDMQPDJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708513232; x=1740049232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4sQC2WhgjYZ07567v7kRYE8KGb9D+tmltcTmLp/Ng+4=;
  b=OlDMQPDJEC/tJ/MtwtezvyjrNeklQn/xWV2YPawDFYvk8qsWzgddB87s
   lQSoP25Fw5Ia+wSDKctwSp6lBOlDBUIfBiyJHns0eUuTLo8QCGPbVPl7N
   JPTeZPQ5TYmWT4KsFQjSD0nokZZqoLQMXYL7hXbhDAr7ZDVhPteYpQlqH
   ZvK0qQwU+QNGUKOh+lr7io6fdqreJ/UvptLZvw1FZYjydidyxKxGlIA5P
   73kVFOW+Q53NEvyKRl/fcXsiFrpNFkyLjGZYBlA76Fmk+cfy315cC007w
   6OVOM/GRaT/ypfYKwjf8EYxNWsdVn8Oopmb7uEYdbpf+pUPsgVm5iE9+Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2816021"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2816021"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:00:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5032860"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 03:00:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:00:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 03:00:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 03:00:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdqXsxIiO9Pp7gVC/a7eCTtwLQPAbefw0c2PeSPPDXCmFOgH2Qi45XDJRwLXBf+fWvJ3AGVAueQ9+T2bErw3cVCSEq2uL0euXG0Td2TtA+03sGKUxNrR3Ta9Yyc7BWvqUMEv0Ad7h7+sjJ+pFq6y/HcxK8iT+7Cfb3UPC5dKLJoKrthbm90mBHK/+RF6OK3ibpRY99sPyUet5cyUunfrT63TdXPLPno1LDJ7ZHtgqiOIqw+vhlDOOjLqbWkOW9+J9vH90NYt8r2b2z1SYemwMtRj//S40bGoM1LZW5V4SlexvuWeKgLcsN0J7L6mhBgb+j7J68MLvVPSYLrO9JpoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sQC2WhgjYZ07567v7kRYE8KGb9D+tmltcTmLp/Ng+4=;
 b=CtX/bgyKoayjc+a8v+PCfTMKgwocCzcEmAYxGTPDQG2U6j+wCXWtzeKgnrp3FVOr4DbT72GjvLgEN1GT5URI9mKCZW0laUUdhpDuyCgBD0GcjH3BhBw+h9sIcqULVGNI0Mi8/9WtTSzChvAkeahY929+KYqRb7lIzrUQ6Rno6zhQAz98vWOLVu7BosNkQzZPJ4PvDZoJyN31XclUvjA0TI2O0r0XbLnTVnvaV2F4+re2oiUBSGtnVv7GmLvbiqdRHWyp44tzgHjTjLRW29+BhluEHESgynN8J9FSS8A1xAdK5obmxRQdnu7/W7dFyedRoJhQ56PPZLOCY9aOubCIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW6PR11MB8311.namprd11.prod.outlook.com (2603:10b6:303:241::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 11:00:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:00:27 +0000
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
Subject: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
Thread-Topic: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
Thread-Index: AQHaWH7Wr4F7uI4dL02icaTavGjkgLETFBIAgAFdrQCAAEeaAA==
Date: Wed, 21 Feb 2024 11:00:27 +0000
Message-ID: <d4aacbea13f0ff03ad94c31a4735746aedd009ba.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-9-haitao.huang@linux.intel.com>
	 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
	 <op.2jhbnui0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2jhbnui0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW6PR11MB8311:EE_
x-ms-office365-filtering-correlation-id: 0632becc-4572-4834-e043-08dc32cc4fa6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2f8ineX60atruAwwQoM43PhcZVq62lFMMUPwkQFXiVA7LR+bJsEBCm2ITGdPcrJBXT0tKKs8GjyLo5MhATsPo9CC2vJ1Sj05wMVVQAsOd6WvsJdBNMf4wi2/feqGIGr5s/O6vBuw2ASWJG1v1UKrJG8bnaqxxKy3/gE0+riO0kppVMFeo2gZweKT4rQzBiPJst+07k3lpG4mrIqKyyyTm+TzPsA3yAH+JC/rR9uQrLhlfHTaglC0KG1t55yuYJyWZfdyRvTstoe9DRjkw30X3y+jOaD0RnuIGctDT/qiHrQvFYjYDns/lJlhb++SNm10070DW59j7csVePyTRZGSgBUGHebFRpvoSPrIqGNl3YukWel4nxt4e5CaZMq86Ed/Cy9gv9Lhz3yQAWt3nHIgUtjXmPXKNwtxwbeLJt9v3OkgDBZR0MZMlQ3K/XECFga8M6TKqDpFlZW0s5ff1/3L4CXo5QeT5tLHgYezxhlXxbpRwtUGSTfUi/yFkOFNJbK53SQdEqtmpktn8UsS5Vu15J73aSqISOC7wU5ctqEmJqg/n1xDUYObj0rQkev5FSQ0PHEzmAeiRuk0DCk15lKj0ZWSzuWD9kuNCoYV0Kp+4BizdHkqIsoWSllgrVYqpyRlUO4pb4sSiWh4CWEPM8UNgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0NUMjB1eksxUVZNNUpGeFowL2JEb0ViMmxqU0J2WTRJbFFYeUdSamUxSkNH?=
 =?utf-8?B?VFFiR1JTWjYrTzRPYVdIRktRUXF2bVV2UlA0cjZicHlDT1E2MCtEOE9kNXY3?=
 =?utf-8?B?ZngwYlQ5V1FmZnUxaGVaWmVSMXkrQmZCOGgwaG9qLzRuWU9YMHJLZXJiNGRr?=
 =?utf-8?B?Zkg5SnZwczQyMFIvSlJWZ2x3OUdPTDNrbXdqanNkaUFlZUt1RjdkWk9rTXk2?=
 =?utf-8?B?c3daOFNQb2hjZTRRcEp0NW9yM2wzTXJjeXN0elpST0wrSlhpcUY1UlRQZTM1?=
 =?utf-8?B?TnNNLzB6QkRSOTBEYnhYV0xQUEhjMXg0TFdWdW9reG5vQTFnTDZNaUpKUE9s?=
 =?utf-8?B?dUVVdTlGVk03a0NqRDBIeHZQdEFGbTJXU3BxT2VsSmU3K01jNmpYRENqbCtH?=
 =?utf-8?B?d3M2ZUhaU1h5TFppbjlCSnBvdy9QRjJFakFWQ3lLeTNFemRSaTNNNEpuSnky?=
 =?utf-8?B?bDFTYWRCck43ZnpsWHA3czB2eVo3MnEzZVZXbVpKR09JeUI1OE9SNE1IZDZu?=
 =?utf-8?B?REdudHhNemNjRTJQYlZoY3IxVzZzUi92VjhxQ3Y3bDZYY1BKeCtIR2czR3J6?=
 =?utf-8?B?SzRYVVVkRUh5Ync1Z2FONW9UY25XSkkxMXRVdzJpNzhZYUlsLzdFR3FvQzgz?=
 =?utf-8?B?VlA2NGQ5ZFI4dlNRMzhXbmlVOHY1YVNNT2syUHhjT003WmJNN01KUXlDdzMw?=
 =?utf-8?B?eE5Qdy9BQ09JNm9hRDB4WUt1VG5VK0JudmVlek9TNnBXTjhKYWl1eVJWVWFt?=
 =?utf-8?B?d3dyZmgzVWptOHJzVkhNOHBSU0ZBamxzWm1FaUxRbm92Z25sUm96OFpZSFo4?=
 =?utf-8?B?ZzBHYzlLVWlQQTZwZFcxQmVibWkxNW9HWnhYZmFoRDNmeDVyNE5ybzYzZWVJ?=
 =?utf-8?B?WHNhK1VDMWExS3NFTlJZMkxXNEZkaGpEQkcvYURmUTcvSlNwRFFvOGkwVURa?=
 =?utf-8?B?UUdLK3Y3WGVHVDhycjYvNTY0R3QwNDYyeDdiQURVQjlqV0dzUjVJUlVLVFpq?=
 =?utf-8?B?eEVWbUhXNWNMUC94SDRrc2IzcFJySXlKWTJ3cXcwM3RzNDh5TTh5QkcvVWF1?=
 =?utf-8?B?clN4YnQxRnhpVzZCaHFUUFpoZVQ1WXN1UzNrS1p1Q3FtenhGUU9rUDJ0RGVk?=
 =?utf-8?B?YVZmYWhKMG9kRmRKbWFKSlM2KzF2NEl0TXJraTRkbWFHVzBwV0hkL0JoNVM5?=
 =?utf-8?B?ZDJaeGpaN2Qvb3VtdjVhbXl0WmxMOVJPYmdadkRmN1VFbVB6L2lzZkFqdlEr?=
 =?utf-8?B?bFhEM1d0LzlndWlFR2N2OWUwOFhiT2JoeFlkMXV5NDVvakIvaTdPRzNpandt?=
 =?utf-8?B?VEdwem5OenAwL1N4WWFLU0taYm1yQ0dRVml2eWpiNHhlOGtZM2tmeTJrSGNu?=
 =?utf-8?B?cG9WbkR0WldNUnNycGJxRjVVNFpGUkF3QldRMHVvcHE1ZWN0ZmZZWDRZTnpk?=
 =?utf-8?B?OGJIZjdkTEVic3pnZlZQWHZUNFRrRE0vNmF6V29oQzVCZ0VtdXlvMW5Fc0dh?=
 =?utf-8?B?YVFra1oyeGZ0emdDS1Uwbm40NjM3aFpkMFQyNGNOY1ozb3ZCYi90WVhReEZW?=
 =?utf-8?B?SWhoQ2cvQkpTQnpFbHd4R1M2VFF4aFdnYUE3aVFGS2t0a1pwdDJRaWRkSzNL?=
 =?utf-8?B?ZFFRVEVrZ2J4UVl6S2U4RG1OMm9yVUVpMDJUOXV3N1dRSnRMZkdlbGRVRFpp?=
 =?utf-8?B?WktidUxmeElmRjFEajN5OFV0WHZTek80VmdzQlF5UXhrRWNOZFVjdmY3Slg5?=
 =?utf-8?B?OVVzMy9yR2wrYXFqR3kydDhxdU1rMG9mSjFHcnZ2emdsdlZpc1F0dFdEOGlV?=
 =?utf-8?B?MVJsUkpqb1J3eEdrYXk0QXN0Q0JMYjRtMk9YV3gvSldWSFNiQXUxYnZvMS9p?=
 =?utf-8?B?MlhlR2ZkU0Q2bURYQnlhTkJJTEVvVVYzSTNTOWhwYzY1S0VubXU2UUwwZXF3?=
 =?utf-8?B?WG9UajZ0aGdRMkVORTZOMWRlbGJIbUNmWTVtNUNQL254N25WTkY4VjBiNXJn?=
 =?utf-8?B?MTB5QlZWMU4zalg4RTRVYVF5cmFsSjFwL0EwR3pvamZNZ29qYjlwdUhsY3hY?=
 =?utf-8?B?MG92eEFublgxbXc5RStCaEl1Q2E4bXdyT3ZFdnpxTUJHTTRLK2w2VU9UcGox?=
 =?utf-8?B?a2dpZzRSSnFXcFdxblNsek55T3p1ejdKR05SYVE2WlhMSjBUekRUNEtVcWxj?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54E8101179B2CF45BCD2D5839A08F1F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0632becc-4572-4834-e043-08dc32cc4fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 11:00:27.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O83JV4+YDgfzGlUFS/ajdZjPoUhBcFQsDsGW/A0xPgQfKddmboblYitlyjQXq7qr6uI7sctCM4vBN3lQNZjSwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8311
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDAwOjQ0IC0wNjAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IFsuLi5dDQo+ID4gDQo+ID4gSGVyZSB0aGUgQG5yX3RvX3NjYW4gaXMgcmVkdWNlZCBieSB0aGUg
bnVtYmVyIG9mIHBhZ2VzIHRoYXQgYXJlICANCj4gPiBpc29sYXRlZCwgYnV0DQo+ID4gbm90IGFj
dHVhbGx5IHJlY2xhaW1lZCAod2hpY2ggaXMgcmVmbGVjdGVkIGJ5IEBjbnQpLg0KPiA+IA0KPiA+
IElJVUMsIGxvb2tzIHlvdSB3YW50IHRvIG1ha2UgdGhpcyBmdW5jdGlvbiBkbyAiZWFjaCBjeWNs
ZSIgYXMgd2hhdCB5b3UgIA0KPiA+IG1lbnRpb25lZA0KPiA+IGluIHRoZSB2OCBbMV06DQo+ID4g
DQo+ID4gCUkgdGVzdGVkIHdpdGggdGhhdCBhcHByb2FjaCBhbmQgZm91bmQgd2UgY2FuIG9ubHkg
dGFyZ2V0IG51bWJlciBvZg0KPiA+IHBhZ2VzDQo+ID4gCWF0dGVtcHRlZCB0byByZWNsYWltIG5v
dCBwYWdlcyBhY3R1YWxseSByZWNsYWltZWQgZHVlIHRvIHRoZQ0KPiA+IHVuY2VydGFpbnR5DQo+
ID4gCW9mIGhvdyBsb25nIGl0IHRha2VzIHRvIHJlY2xhaW0gcGFnZXMuIEJlc2lkZXMgdGFyZ2V0
aW5nIG51bWJlciBvZg0KPiA+IAlzY2FubmVkIHBhZ2VzIGZvciBlYWNoIGN5Y2xlIGlzIGFsc28g
d2hhdCB0aGUga3NneGQgZG9lcy4NCj4gPiANCj4gPiAJSWYgd2UgdGFyZ2V0IGFjdHVhbCBudW1i
ZXIgb2YgcGFnZXMsIHNvbWV0aW1lcyBpdCBqdXN0IHRha2VzIHRvbyBsb25nLg0KPiA+IEkNCj4g
PiAJc2F3IG1vcmUgdGltZW91dHMgd2l0aCB0aGUgZGVmYXVsdCB0aW1lIGxpbWl0IHdoZW4gcnVu
bmluZyBwYXJhbGxlbA0KPiA+IAlzZWxmdGVzdHMuDQo+ID4gDQo+ID4gSSBhbSBub3Qgc3VyZSB3
aGF0IGRvZXMgInNvbWV0aW1lcyBpdCBqdXN0IHRha2VzIHRvbyBsb25nIiBtZWFuLCBidXQgIA0K
PiA+IHdoYXQgSSBhbQ0KPiA+IHRoaW5raW5nIGlzIHlvdSBhcmUgdHJ5aW5nIHRvIGRvIHNvbWUg
cGVyZmVjdCBidXQgeWV0IGNvbXBsaWNhdGVkIGNvZGUgIA0KPiA+IGhlcmUuDQo+IA0KPiBJIHRo
aW5rIHdoYXQgSSBvYnNlcnZlZCB3YXMgdGhhdCB0aGUgdHJ5X2NoYXJnZSgpIHdvdWxkIGJsb2Nr
IHRvbyBsb25nICANCj4gYmVmb3JlIGdldHRpbmcgY2hhbmNlIG9mIHNjaGVkdWxlKCkgdG8geWll
bGQsIGNhdXNpbmcgbW9yZSB0aW1lb3V0cyB0aGFuICANCj4gbmVjZXNzYXJ5Lg0KPiBJJ2xsIGRv
IHNvbWUgcmUtdGVzdCB0byBiZSBzdXJlLg0KDQpMb29rcyB0aGlzIGlzIGEgdmFsaWQgaW5mb3Jt
YXRpb24gdGhhdCBjYW4gYmUgdXNlZCB0byBqdXN0aWZ5IHdoYXRldmVyIHlvdSBhcmUNCmltcGxl
bWVudGluZyBpbiB0aGUgRVBDIGNncm91cCByZWNsYWltaW5nIGZ1bmN0aW9uKHMpLg0KDQo+IA0K
PiA+IA0KPiA+IEZvciBpbnN0YW5jZSwgSSBkb24ndCB0aGluayBzZWxmdGVzdCByZWZsZWN0IHRo
ZSByZWFsIHdvcmtsb2FkLCBhbmQgSSAgDQo+ID4gYmVsaWV2ZQ0KPiA+IGFkanVzdGluZyB0aGUg
bGltaXQgb2YgYSBnaXZlbiBFUEMgY2dyb3VwIHNob3VsZG4ndCBiZSBhIGZyZXF1ZW50ICANCj4g
PiBvcGVyYXRpb24sDQo+ID4gdGh1cyBpdCBpcyBhY2NlcHRhYmxlIHRvIHVzZSBzb21lIGVhc3kt
bWFpbnRhaW4gY29kZSBidXQgbGVzcyBwZXJmZWN0ICANCj4gPiBjb2RlLg0KPiA+IA0KPiA+IEhl
cmUgSSBzdGlsbCB0aGluayBoYXZpbmcgQG5yX3RvX3NjYW4gYXMgYSBwb2ludGVyIGlzIG92ZXIt
Y29tcGxpY2F0ZWQuICAgDQo+ID4gRm9yDQo+ID4gZXhhbXBsZSwgd2UgY2FuIHN0aWxsIGxldCBz
Z3hfcmVjbGFpbV9wYWdlcygpIHRvIGFsd2F5cyBzY2FuICANCj4gPiBTR1hfTlJfVE9fU0NBTg0K
PiA+IHBhZ2VzLCBidXQgZ2l2ZSB1cCB3aGVuIHRoZXJlJ3MgZW5vdWdoIHBhZ2VzIHJlY2xhaW1l
ZCBvciB3aGVuIHRoZSBFUEMgIA0KPiA+IGNncm91cA0KPiA+IGFuZCBpdHMgZGVzY2VuZGFudHMg
aGF2ZSBiZWVuIGxvb3BlZDoNCj4gPiANCj4gPiB1bnNpZ25lZCBpbnQgc2d4X2VwY19jZ3JvdXBf
cmVjbGFpbV9wYWdlcyhzdHJ1Y3QgbWlzY19jZyAqcm9vdCkNCj4gPiB7DQo+ID4gCXVuc2lnbmVk
IGludCBjbnQgPSAwOw0KPiA+IAkuLi4NCj4gPiANCj4gPiAJY3NzX2Zvcl9lYWNoX2Rlc2NlbmRh
bnRfcHJlKHBvcywgY3NzX3Jvb3QpIHsNCj4gPiAJCS4uLg0KPiA+IAkJZXBjX2NnID0gc2d4X2Vw
Y19jZ3JvdXBfZnJvbV9taXNjX2NnKGNzc19taXNjKHBvcykpOw0KPiA+IAkJY250ICs9IHNneF9y
ZWNsYWltX3BhZ2VzKCZlcGNfY2ctPmxydSk7DQo+ID4gDQo+ID4gCQlpZiAoY250ID49IFNHWF9O
Ul9UT19TQ0FOKQ0KPiA+IAkJCWJyZWFrOw0KPiA+IAl9DQo+ID4gDQo+ID4gCS4uLg0KPiA+IAly
ZXR1cm4gY250Ow0KPiA+IH0NCj4gPiANCj4gPiBZZWFoIGl0IG1heSByZWNsYWltIG1vcmUgdGhh
biBTR1hfTlJfVE9fU0NBTiB3aGVuIHRoZSBsb29wIGFjdHVhbGx5ICANCj4gPiByZWFjaGVzIGFu
eQ0KPiA+IGRlc2NlbmRhbnRzLCBidXQgdGhhdCBzaG91bGQgYmUgcmFyZSBhbmQgd2UgZG9uJ3Qg
Y2FyZSB0aGF0IG11Y2gsIGRvIHdlPw0KPiA+IA0KPiBJIGFzc3VtZSB5b3UgbWVhbnQgQGNudCBo
ZXJlIHRvIGJlIG51bWJlciBvZiBwYWdlcyBhY3R1YWxseSByZWNsYWltZWQuICANCg0KWWVzLg0K
DQo+IFRoaXMgY291bGQgY2F1c2UgIHNneF9lcGNfY2dyb3VwX3JlY2xhaW1fcGFnZXMoKSBibG9j
ayB0b28gbG9uZyBhcyBAY250ICANCj4gbWF5IGFsd2F5cyBiZSB6ZXJvIChhbGwgcGFnZXMgYXJl
IHRvbyB5b3VuZykgYW5kIHlvdSBoYXZlIHRvIGxvb3AgYWxsICANCj4gZGVzY2VuZGFudHMuDQoN
CkkgYW0gbm90IHN1cmUgd2hldGhlciB0aGlzIGlzIGEgdmFsaWQgcG9pbnQuDQoNCkZvciBleGFt
cGxlLCB5b3VyIGNoYW5nZSBpbiBwYXRjaCAxMCAieDg2L3NneDogQWRkIEVQQyByZWNsYW1hdGlv
biBpbiBjZ3JvdXANCnRyeV9jaGFyZ2UoKSIgYWxyZWFkeSBsb29wcyBhbGwgZGVzY2VuZGFudHMg
aW4gYmVsb3cgY29kZToNCg0KKwkJaWYgKHNneF9lcGNfY2dyb3VwX2xydV9lbXB0eShlcGNfY2ct
PmNnKSkNCisJCQlyZXR1cm4gLUVOT01FTTsNCg0KQW55d2F5LCBJIGNhbiBzZWUgYWxsIHRoZXNl
IGNhbiBiZSBqdXN0aWZpY2F0aW9uIHRvIHlvdXIgZGVzaWduL2ltcGxlbWVudGF0aW9uLg0KTXkg
cG9pbnQgaXMgcGxlYXNlIHB1dCB0aGVzZSBqdXN0aWZpY2F0aW9uIGluIGNoYW5nZWxvZy9jb21t
ZW50cyBzbyB0aGF0IHdlIGNhbg0KYWN0dWFsbHkgdW5kZXJzdGFuZC4NCg0KDQpNYWtlcyBzZW5z
ZT8NCg==

