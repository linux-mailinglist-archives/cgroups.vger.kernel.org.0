Return-Path: <cgroups+bounces-1731-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD9385D671
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 12:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329301F24488
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF7BE7E;
	Wed, 21 Feb 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyDFZi4T"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E03DB92;
	Wed, 21 Feb 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513569; cv=fail; b=i3n0tpIXgB3HNc5rbP004raIFJORcLCZ7kFVwToMvB29AvMtdkeRosEtNbXYK0UBc+rH7QYehjD0nq4i7paLiC8kCFzN96w9WYLRgCDg0RrTCqxgc0ZS3jLH2t5aiR6BXy7iUaBRmBgkecJeUknvsuadjPraGF38Po6qiQ4IIYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513569; c=relaxed/simple;
	bh=u4Y1Cr4mQ6ASwAoMWbxNtSo5FJr3T7aOeznnDXletAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m5ZSVFTrAjCqRotOOwv7joNcKjJtPfQC3IiPnX68h0WYPyQfIsLlSumJ2dFCs+xUtTAh4N7S7+1vSr+AM+oRLC969fqPs8ZTfq1jr5z3K8vFWt1Dq8Palr3Yos27jC6wnU71FWeF4C5lqEA5zXUhBdJT/zojTTv6U7siWZ6LfN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyDFZi4T; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708513568; x=1740049568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u4Y1Cr4mQ6ASwAoMWbxNtSo5FJr3T7aOeznnDXletAM=;
  b=UyDFZi4Tz8oXdukaTz4DgaR9T/IXZ+vIkth+H8YfjSKo4w8DGIS/vDiu
   vGPzCA+UvkzBCKnqZtNQTXEiAiJNKtb2O/pwtv0uDpqn6B9jxbbLfAgWU
   2CDw0DVHI3jgqJcMsJ+4/WYldMKtxHt1SAA3e+YqcKZQog2QxUbWSdmxO
   2TC01WtigNOImfLNtkqy/lBkTlwfULvs72xkPu1BY5d2fjPfIYQJFHDei
   qvkMzlPFxpnrn+th0dQnPRiL60K6zL9R1gQii5LI5Jl9hMwMRs2bStYw7
   e6NfnkX3PKlgaF+/64H6hn0t+QHlsaA6/NafbbXekKHq6ZBSEgopodRZs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2790374"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2790374"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:06:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="827329541"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="827329541"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 03:06:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:06:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 03:06:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 03:06:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJUAAy4VpR3//vcN3n8vatnsHTgdb4iQcMZmeyHQC9RlNoSPS/FZWS7Yyyj6ky6O7dYEpyi6b6AJ9gyieaHXmlavTK6XU+GsVejDHzSruPeD1iK/5TN+2ojeoSkVisPjNWA0JfpfG1XzIrmUsnQBV9LnijUaKCNQodvKgt/jofhyMB0qg5VeLYgVRsh1wJTZDXJJXUz0LqP5P10moCqu7y6cTQiETIdIHWnJmuI/gNJ50qONBkHxl2jN1udpAC+LLnV26YnaudJswczprNwMLGFZa6e8U+qwSxFLkhaYEVkDLwW7fhqDqoWr6H089HXyeoxJ7vRDWAKvD6Rqe/EG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4Y1Cr4mQ6ASwAoMWbxNtSo5FJr3T7aOeznnDXletAM=;
 b=cpCFTQPMrX2cCndOfllCauhqkbiP+eioX6tfKcujK+MqTYzxNsEZYvjFl7i4/XEhudbN//acNVdBO4KrFdmXIVLTmMofGaZloCZsCb8+jHNK3o5YmjgrPjve31eMQ7IzDIela5XftkCTXVVBbnt0ifUorBBrL4T7M5xtPDM1qzLtHNKhx04aiOkVbWFneTFcqCMMJcoU0tQ211Op43IowZA6tkYQkCRcsC9x7fhbIsCCZ/V1R8NZuG4hgqQEhJsJJZbnCZlYJt0YuFfA4FSzK+tfTbaRjilJjKiawbsm0oQv1h86VpGjmd3n6EpGan4GGngA30IQXBjcTRgUiJrB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW6PR11MB8311.namprd11.prod.outlook.com (2603:10b6:303:241::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 11:06:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:06:02 +0000
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
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Thread-Topic: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Thread-Index: AQHaWH7l75yVd20wEkCEiOebdvKVQLEUuuiA
Date: Wed, 21 Feb 2024 11:06:02 +0000
Message-ID: <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-11-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-11-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW6PR11MB8311:EE_
x-ms-office365-filtering-correlation-id: 1535a217-f57a-4f1b-6806-08dc32cd1792
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxcE86BDQ+nx14d1HLJ4xfiMhzLpQz/KglOYgRg6H5Pml83QekOVV89ggRxpFDIMMGKqf82vhN4T/1AN9N2G0luzamRMarzeC0vFT+9FwAn6ZLIvoEhzQp9LTSabN4MV4kCAKYxOqrbNi7YroNdOkNzo797skWjQ3fKXSmZdz4aeGGltrLeyBhtnbjVe/+JxjWUPyanjDdeP2bIw53Jim3cQ/w+dyr+uy9xtDoMstX0Mt9CJj+g1B+vKvSGanICe/EoxfnEN6NLEUMLes29KgtOPGqRyKBYtbDD1Pk4ir0zxmYzMtedFfOL+UUE2FwP3gwBXP0kyxjKLmgF9qez28w3/9p0gM3VnMYbHl/4jqfgECgNjRwupAiZTVLJG3MEOMR5YPp6Ne8ruSglJFiPa0EsLvjOxwCK2iPoe2ElNU6rlc65PVvg4TbxrEfpCC0kNg/9Sq09RcAl1g0crN44ckQ3GN6wyYkUO1ANi1F2qhrO81oHIpCtNk3IS60dExPyO2QpwMi0XiatePp9/bhED8C84SSQSXHBCyS6WM+CpVWWcWOf4iZsrNb16xdyzsmFo85boqBR1gcJI2OxY9BV+97UjnT/iQP5GT9eImriDrEfdH7xyCja9IjSHgoIA16y+EiY7zaqIXJZVhoz7eG/QFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEI2cURzSlh1Q0JLY25FODZla1hGY0ZtV0s3UUNkT1JyWDZZVXAxeXdkU1BT?=
 =?utf-8?B?Qm00cWJCQUtBOVd4N3pFdU1Cbzc5SWJZbDV6VTVaVENYaHQ1cGZqYXpKcEMw?=
 =?utf-8?B?cEhUbVNlWXZIbVFDYkRjQlVDeWZoeUZTZFB6RlpzTUlmV2pHb04xOUpLcklh?=
 =?utf-8?B?QllCYUZNc1c0Vjl0QlBSVXZMTkt0Y1c5R2JGR0ZCK09PV29Nb0xDeFlWMnFN?=
 =?utf-8?B?V0JsMUVvZk5jakthWjZvUWIwRVVKa0tGTE1rcGdmTVI5OGlFNnVudXJQamRH?=
 =?utf-8?B?Q2ZXbWdrZGFZSW4zcTFhSGUvU2E0SW11V2FGN3M2NmVOZzVUakZZMzd6Y1Vt?=
 =?utf-8?B?QzJaanhHV0tOTjJnQjhHRk90MCtYUngrTzN3OTN2QUJMQlFqNXZxWTZnUDV2?=
 =?utf-8?B?aTl6aVAwdkdwVjZMUVNRc0NIMHBWSlY2U3ZrN0dJTFR5ekVwTEc0UEdZanJE?=
 =?utf-8?B?bTZ0SGhpMFIvQ2E1SmdpTUU1WStweXo4NldOcEFrcjU2d3lhZkxCUWhyaFJz?=
 =?utf-8?B?ckNjODNOeEo3SjQwdE1yaGhoY21ZQzZqZG54R3R5MCswTmcvdjlwaTIzNXE1?=
 =?utf-8?B?UjFNQnIwVFlRYm8ybElzWml2dExiM25UQzArWnMwUkpiU2x1ZTdlU1JUdDQr?=
 =?utf-8?B?VHhrOU9Lbm5NeVpob1VzSmNXUmo5VnFNODh5ZENWZVBMYkVXOGZXaG81dCsx?=
 =?utf-8?B?eEM1S2Y0SXZzUDRBTW5oaSs3RTJaTkp6L3dmdUw2SE9yYzNtSlhnaTBSNWQv?=
 =?utf-8?B?YmZ6cFBwMXBMb1owUE1UOU41aEIxa1RzV3ZQUmdFRWc0cGFmRExMT0tJMzhN?=
 =?utf-8?B?VGgrSUZnek9NTEJFdlFZaW1IQ21OcE5jTjJaamtrZDVSd3hUR0lpeGJ6VHBR?=
 =?utf-8?B?aGo2NmNxaDJ0UDF4VnUrUU9qOTMrQllCQzVPNEl6K295M1diLzBLSURCWENt?=
 =?utf-8?B?L1BsTGpEaTZzZmpNWHhBRnJmcDRzYkJieVdZdUpCTUI2bHdHaHgxS1NXRi9E?=
 =?utf-8?B?TlNtNnFIbDdsZjRTczRNQUZ0dmJLVlhCb0kyQ2R5N2prQXFVcFJxTVRTeGxh?=
 =?utf-8?B?anl1em44bjRJMFI4NTBONnZ3bHNmU1d5YmNWYUlWVUlDbDFvRGxoUTA4MGZT?=
 =?utf-8?B?Rm43MUUzQVlkQVk2KzRrRWhQL3JyeDJhUFVvY0xwNXpQb3RHZXVQOThtMnZH?=
 =?utf-8?B?RzJqZGhabnNIVmhmaFNSenM3UTZtZXJsN08zeEpVN0lyalVCQ0EvTmFzTy9O?=
 =?utf-8?B?dlB5eGdaTmZ5eFlUOUFDczAxOEE4ZXp6bDZuWi9Na0laUVRkN0d1TERXd0pa?=
 =?utf-8?B?RkVVMzVZak15ekZrTEJHQVlibWN5dnRmN0dyMGUvTlZpUWZKVmVua3Z0WjF1?=
 =?utf-8?B?cnV4S2kvTjR5YXhFOWJwWFl1WW5JTVZ6UFhrNUV4M3FSNlJhbGVOWDhKWjZh?=
 =?utf-8?B?OWJBS0diNHRiVFdkWlpyTjR6dXpWT1g5Q1M4cDFJMTZUcCs0aDlnREtGVUNF?=
 =?utf-8?B?UlJHSFBIaGwrOUlmdzNSVXdYSHoralpacDRWMGxPdmlRSjlPeWhQN0VrQ0VN?=
 =?utf-8?B?WGZOTG5KQk9UTzArckJSZkRhYXFsdVFPUUxkQ2o1QzZtY2wxODRaWUUrbzJC?=
 =?utf-8?B?NnR5bmZaOWFHYjhIaUF1RjVoYmRNaVN4TFlWWDZtblg2NVNzREppVG1xTEZq?=
 =?utf-8?B?Y3pTUjVNU1JMQytuUHd1Z0tGdlRKNzhRQzl0WUdTblpRSmZRMG5kNVNtUlNr?=
 =?utf-8?B?MkUzWE1xNmpmVkhyS29ZZmU3NHJzQzgyL1hNcG1idXFqVUh3Wk1uMjIxcC84?=
 =?utf-8?B?WUh2WWRWRjNFWjRobXpDUGdTb1BuUytBWkJUVU5KeEYrTk5VbFlYNlVWT0VE?=
 =?utf-8?B?RnNuUXE0Z3pqVnVBUGxsZzVXRmg3dld0WHAzU2MrZmc1U05JNCtVWDRjSE1s?=
 =?utf-8?B?Y3RJOTljSGJVdVFuTXY3UXJ6U1NDaWZLekg5NVEvZGU0MVl4ZjBhWjJFN25u?=
 =?utf-8?B?TTlhRmxSU1hEK2Roem9yczV1WDZDODlueGJNMUg0UWJPZEc3RXV1c2g3Wkxu?=
 =?utf-8?B?MHhxZkVJNVpBQTlGb3Rtb29kRWs2T3c3TWxrbkNDU0xCeGJsR25zNHIwaDJv?=
 =?utf-8?B?WXNxaUhKRHB1VnFjWlpta3lMMDZCSlVUQ2k4VVIzVWJ6eFd5bG1iSlZINWJs?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83971FB4740A6A4A9497B88AD596BC27@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1535a217-f57a-4f1b-6806-08dc32cd1792
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 11:06:02.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHrp3XwU3iGy6SOMVrLvbvq17RlA2IehjSD5GXG3ZRFBGKtYJfSwQZjzHob0NnboWeUldAwNOb2eZR0Ifigjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8311
X-OriginatorOrg: intel.com

DQo+IC1pbnQgc2d4X2VwY19jZ3JvdXBfdHJ5X2NoYXJnZShzdHJ1Y3Qgc2d4X2VwY19jZ3JvdXAg
KmVwY19jZykNCj4gK2ludCBzZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKHN0cnVjdCBzZ3hfZXBj
X2Nncm91cCAqZXBjX2NnLCBib29sIHJlY2xhaW0pDQo+ICB7DQo+IC0JcmV0dXJuIG1pc2NfY2df
dHJ5X2NoYXJnZShNSVNDX0NHX1JFU19TR1hfRVBDLCBlcGNfY2ctPmNnLCBQQUdFX1NJWkUpOw0K
PiArCWZvciAoOzspIHsNCj4gKwkJaWYgKCFtaXNjX2NnX3RyeV9jaGFyZ2UoTUlTQ19DR19SRVNf
U0dYX0VQQywgZXBjX2NnLT5jZywNCj4gKwkJCQkJUEFHRV9TSVpFKSkNCj4gKwkJCWJyZWFrOw0K
PiArDQo+ICsJCWlmIChzZ3hfZXBjX2Nncm91cF9scnVfZW1wdHkoZXBjX2NnLT5jZykpDQo+ICsJ
CQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCQlpZiAoc2lnbmFsX3BlbmRpbmcoY3VycmVudCkp
DQo+ICsJCQlyZXR1cm4gLUVSRVNUQVJUU1lTOw0KPiArDQo+ICsJCWlmICghcmVjbGFpbSkgew0K
PiArCQkJcXVldWVfd29yayhzZ3hfZXBjX2NnX3dxLCAmZXBjX2NnLT5yZWNsYWltX3dvcmspOw0K
PiArCQkJcmV0dXJuIC1FQlVTWTsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmICghc2d4X2VwY19jZ3Jv
dXBfcmVjbGFpbV9wYWdlcyhlcGNfY2ctPmNnLCBmYWxzZSkpDQo+ICsJCQkvKiBBbGwgcGFnZXMg
d2VyZSB0b28geW91bmcgdG8gcmVjbGFpbSwgdHJ5IGFnYWluIGEgbGl0dGxlIGxhdGVyICovDQo+
ICsJCQlzY2hlZHVsZSgpOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiAgDQoN
ClNlZW1zIHRoaXMgY29kZSBjaGFuZ2UgaXMgOTAlIHNpbWlsYXIgdG8gdGhlIGV4aXN0aW5nIGNv
ZGUgaW4gdGhlDQpzZ3hfYWxsb2NfZXBjX3BhZ2UoKToNCg0KCS4uLg0KCWZvciAoIDsgOyApIHsN
CiAgICAgICAgICAgICAgICBwYWdlID0gX19zZ3hfYWxsb2NfZXBjX3BhZ2UoKTsNCiAgICAgICAg
ICAgICAgICBpZiAoIUlTX0VSUihwYWdlKSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgcGFn
ZS0+b3duZXIgPSBvd25lcjsNCiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAg
ICAgICAgICAgIH0NCg0KICAgICAgICAgICAgICAgIGlmIChsaXN0X2VtcHR5KCZzZ3hfYWN0aXZl
X3BhZ2VfbGlzdCkpDQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5P
TUVNKTsNCg0KICAgICAgICAgICAgICAgIGlmICghcmVjbGFpbSkgew0KICAgICAgICAgICAgICAg
ICAgICAgICAgcGFnZSA9IEVSUl9QVFIoLUVCVVNZKTsNCiAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KICAgICAgICAgICAgICAgIH0NCg0KICAgICAgICAgICAgICAgIGlmIChzaWduYWxf
cGVuZGluZyhjdXJyZW50KSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgcGFnZSA9IEVSUl9Q
VFIoLUVSRVNUQVJUU1lTKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAg
ICAgICAgICAgIH0NCg0KICAgICAgICAgICAgICAgIHNneF9yZWNsYWltX3BhZ2VzKCk7DQogICAg
ICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7DQogICAgICAgIH0NCgkuLi4NCg0KSXMgaXQgYmV0
dGVyIHRvIG1vdmUgdGhlIGxvZ2ljL2NvZGUgY2hhbmdlIGluIHRyeV9jaGFyZ2UoKSBvdXQgdG8N
CnNneF9hbGxvY19lcGNfcGFnZSgpIHRvIHVuaWZ5IHRoZW0/DQoNCklJVUMsIHRoZSBsb2dpYyBp
cyBxdWl0ZSBzaW1pbGFyOiBXaGVuIHlvdSBlaXRoZXIgZmFpbGVkIHRvIGFsbG9jYXRlIG9uZSBw
YWdlLA0Kb3IgZmFpbGVkIHRvIGNoYXJnZSBvbmUgcGFnZSwgeW91IHRyeSB0byByZWNsYWltIEVQ
QyBwYWdlKHMpIGZyb20gdGhlIGN1cnJlbnQNCkVQQyBjZ3JvdXAsIGVpdGhlciBkaXJlY3RseSBv
ciBpbmRpcmVjdGx5Lg0KDQpObz8NCg==

