Return-Path: <cgroups+bounces-4667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E1A96868E
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B734281611
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802DA32;
	Mon,  2 Sep 2024 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te6cnvzK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCB1D6C52;
	Mon,  2 Sep 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277670; cv=fail; b=ByF6bpd8FojqWJdBIbUFBXhWJ80nUumiTXoOTb3doaTF/u66gU/pwdmtMC2Ie3DSSN3AWG+8FN1zpUwz4CDyBOkTM8FTWpjNgB99xMskctr5xh1z6NQ+ZMnh/Wx35zNkzY0YhUEBUKnZTB5vPJ/igpzMGimHuKTSZOfhNjZUerY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277670; c=relaxed/simple;
	bh=jxbs3GOWwp2HgQit9c0gk3MZ08fcyiRtC83FYDw6I6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fLzHtQAmQ+/4Oh13rGTiMCd4Dz8ifg0yOt55sv6KAZIvYkzLzKJTeD/BHR3OQ8SL1E5K9/v9VgeE18it8GyOyqe38ZWLZRlqv08bfdHjYNJpa56qzXlBPmF4eBqk74A8QI61I1xPx53ew4EHXAUI/Feuj324G4892KqVhwXWIJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Te6cnvzK; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277668; x=1756813668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jxbs3GOWwp2HgQit9c0gk3MZ08fcyiRtC83FYDw6I6w=;
  b=Te6cnvzKYfyC3HBdhIwuqkruGQPCJkGE0iVW0V+MJHd8s1up37IkAbfw
   6BDZ8MWMAzB7opeMWBWMrLGuBkmEbj9EaI5VBjuICXMYqSkQpxHSPgJrB
   ZZ8YBdcDd4seGAluRcdb2lmIn0EBDP0wnELlJDTOEc+W7E3P+6aIDQ1Em
   HesGr+aXH7M/VRqEUQwBKlbne6DVsL9XXhHQD/O4YixoHdlY/Lu9lGCSI
   7Yj8J7rLK6pNCYjSXsn2w1rv4oFObvhPV3ySMm/W5y1Cpx4OGuidvZXLY
   GZxfQA7/vZMBPzn9h5SDV/Z0IFNhEHhdiPOiR+LxJ9zhyC4dwxOEgU9yG
   A==;
X-CSE-ConnectionGUID: HHf3yJ/tRK+5UTOo4URR3A==
X-CSE-MsgGUID: FliqphI6SIWVceCA2F4zRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="46368191"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="46368191"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:46:59 -0700
X-CSE-ConnectionGUID: jHIoYXNASPiT0wanToqGkw==
X-CSE-MsgGUID: CEu5ZsA6QGmUJAhBMrVTdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64591451"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 04:46:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 04:46:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 04:46:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 04:46:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLXte1qGC7PbhAck/uxzVYdDUw166wxPpntr/hRhyCxzIZ+p8YlzsH7CggI5iw8/t1Tsmux8kvg67HWLTn0nYCt2pGpH18ml9Pi3/Br5Jl7TZ6p27ujjK88F7ABwRfLjsMS4sLtQrf89vlGKmBblls3z4cW/pBLI5eo/CwkCZxs2QIoIC0hpY/9aC7WQPn4HFo0m6F6sMtlXH83TOBeLDJyX43ebT8BhQzoz4SogwN6ibFu+bOMvPiyvBDu8dSQdl9Z4RQx7/VIGjp2DHq0pa2tknPp2UQ0T21Ou1Z5qW4ANXOv989Qn1cBhZBnfX9QAjXTsn8rMoTd4aR2MtVN/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxbs3GOWwp2HgQit9c0gk3MZ08fcyiRtC83FYDw6I6w=;
 b=QzJcR07P8Tkn1KJGn4bDVnsm/jZj4Cuh9uhNeGB1BWm/a1+EBr3j7g0soc5hL8Fq9i9TYyIl6inYIXjSxqvs2AIxSlN8POEVh+KUhwhC2Rr273dFLjdFA0TRpSliOperc8jQHG8l1N58jln33AqtBxaUqNQ4TzKDlPyspgwHdXVQ7d3Pv0vFY3ZywSFyAUaTmPKL941OEWlgqXdH4iidf7jvHvB8qPpV0cwxNSqkwsfNMaXyUA4B/vl35gd+WRz6CIYvxAPknOCy0T1GNaPBJFbx6L/US40tkErzlSNhQgWDlWdX8Xoc3VJ8uzSfaYcFEPNywXJ1tu0yY44/+L7rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6979.namprd11.prod.outlook.com (2603:10b6:510:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 09:43:22 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:43:22 +0000
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
Subject: Re: [PATCH v17 02/16] cgroup/misc: Add per resource callbacks for CSS
 events
Thread-Topic: [PATCH v17 02/16] cgroup/misc: Add per resource callbacks for
 CSS events
Thread-Index: AQHa+vt56x70KIMAX0uIIm6RnFT2XrJEQx6A
Date: Mon, 2 Sep 2024 09:43:21 +0000
Message-ID: <1fe27f4dfbfbdc887458df88b2ebedc9cbd2d566.camel@intel.com>
References: <20240830164038.39343-1-haitao.huang@linux.intel.com>
	 <20240830164038.39343-3-haitao.huang@linux.intel.com>
In-Reply-To: <20240830164038.39343-3-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6979:EE_
x-ms-office365-filtering-correlation-id: 88ac4b38-4451-43ea-4152-08dccb33af0a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?ZkF6Mk9qRnVybEZ1RVc3WkRyQy8xWStWZ0dmUjIvK3BWQmJ3anpacU5uL25I?=
 =?utf-8?B?NktqZzA3dktKY1lBbGNOdzhPdnN4ZVJXekcxbzRxVU9ocnhvcWt3Vko3N3BS?=
 =?utf-8?B?d2RkSkxVaUtUZGREQzNrNkJXUCsxOVJkb3l2YU9wZS92bVlyVUlLTmQ1ZVRa?=
 =?utf-8?B?YUxvMndCd1ZTdnZidllZY25FeldMY0x0QjlFN052ZVdZWDRmbDFSeXRFL29C?=
 =?utf-8?B?L1NQb0wxYlVHWDZkSXA1c3lEZWVpb1plTC9zSnVVWmV5YytBVlIzQmF6RTUy?=
 =?utf-8?B?dEQ0citPTnZ4WDV6MmFldk5ZbjZDdEZITkpMaW1SYThxd21LbXYwRWx2TW1Q?=
 =?utf-8?B?eGVwTVlVem42RXdEZ0RVdW5Ybm8xSEhnSy9QdFRDc2VMdGRYQmNlVFZvdm5x?=
 =?utf-8?B?UlVOOSs3SG1aVHloSEgrTVlvMUZ2MW5oVVcyTlVoejdlL0lNbHo1YUprMFNr?=
 =?utf-8?B?Q1F2UkFHQlh4U3hNUDY2MGpnNWRLWnNPbGN2RjVuMjBHYkk5aDFZRlFnazJQ?=
 =?utf-8?B?RjdrMkRralFxelJzMThqRzQvYnFGMFl5TWhtZVBhK3NHUzBwem51Z1VGYUdX?=
 =?utf-8?B?QkFLbDJ5ZERTdDZ5MDhOVERnajBlMnp1SkltZmZZQ1VwemRPaUF3ajExZXBj?=
 =?utf-8?B?eko4bStaNWliam9nOGZFa2xjckxZVStiK2szNjBmYUo3L01qeHJiMTQ3RUZR?=
 =?utf-8?B?VG53WFpWMlZ0TEo2Uk9TVCt0QUV2a21HUndDSk83bTIyaTR3L3ZDUElIV3Ju?=
 =?utf-8?B?NnR0cXZpRWpyWU9HSnJNY043MnpqWVNFZG05MmVXZFMwNVQ0UUJHM0VUY1VH?=
 =?utf-8?B?THVmSDJkUkloZUdPUUtQSXNPOHg5aXRpY2RNNDZVRmRMNm9yWEhTSmEyVnpQ?=
 =?utf-8?B?Q25wWUhrMjc3WFlCbG1QU2Q3bzlBUzd2Q1BCUjQyT3VUUjBTVnltOWgwdTBn?=
 =?utf-8?B?U1EvYnNXRmkvdDgrVVlZTE9KQlQvUkhmU1o3ZkJVaDNaSHloZnNNM1UwZHly?=
 =?utf-8?B?RTdtT3VUM1lPanprS3Ezamt4RHUvUEJOQVRGNGV2L0VRSEdsa2d0RE5pcktF?=
 =?utf-8?B?cG0rMEhhek5kTFNTS0MxdDBZVWxFVE1uMVNicm1aSWVxeDYyN3FVNkRVMXox?=
 =?utf-8?B?SDRQY1krNWJxRzRCL2NyNCt4Sll4VGFMakgvWFhlYnJ6eUg1clBMUnJGYmh5?=
 =?utf-8?B?dzY3aUYzTHZMOGpCenU2NGxmRHRzTTZFQU9vUndlZllXdlJJa1dGMFFjLzhF?=
 =?utf-8?B?NDZzUDUyWDZqVTR4UGlCVXVoblJ4ZWg5WHpLalBvdERLNTVsZXRib0lDMzF0?=
 =?utf-8?B?Si9SWDFaQWFBRTBEZnU0YTlsQU9NMWp2cVl6dXZmbU1EVGZMSlhwS0FRVFE0?=
 =?utf-8?B?cy9iVnJKMUhrdkZLSFhlSndMS3ZTZkZSbUVncTZucnNsNVlYcmlFN09lV0lz?=
 =?utf-8?B?QmxpYTA1UjNOM05OR0lid09wSmc1WFBaM0h0NU16ZFFtWFp6b0RFdlBoL0Nr?=
 =?utf-8?B?TmxYTVBJNlZ5VHhCeDNxblRyd1Q1VXJYcmRrTjFSaXk2M2NqUHBDeTFiWmZh?=
 =?utf-8?B?bEdjTnpCQm1kbFRuSytNYTBOUWpwbHFCUWRJUnp4MnN6MHNpR1Zvd25vRE0v?=
 =?utf-8?B?L1pYN2s3UElwZEZTM0R6WFRtSVJqakRNWFllME5zb0RlaDVraGIrcnJXSU1O?=
 =?utf-8?B?MEt0bkhnZ3hBazJZTjMrek5USkV1bUFnNWx0eEVQejBrSnFwVFZpdWhuMnUz?=
 =?utf-8?B?NjBtY251cjZUaEU2Y2RlMnIrMEFUdmRyVGdDOVh5M2JSODlIN3JhbWt5a1Bs?=
 =?utf-8?B?WEpNUHhCai9mRW5leFdGcVVRZXNURFc3UUZiQTk4SjB1MG9sWUdMQlFqOGp4?=
 =?utf-8?B?aTdDK3J2REt4dGFOaGE2VEJJa2JFRXExbi84N0NUdUJKRkZueEFib0VPT3Jv?=
 =?utf-8?Q?7po5EjkAYDI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S09YOW5yTkJqSE1YalhJaGFTUkp6cE5mTDh1bVU2aUFEb0FZcXA2cmtWSSt2?=
 =?utf-8?B?bDllV2ltbkhwZyt2d3lkRnRIbDlmeXJnNjdiWWxjS2xSVXA5dU1ZUHRRdnJr?=
 =?utf-8?B?cDVGZkpkVGVDaW1SVEMrQlJvMXVYL0UvM3BQS2E4Yy9SUTVMajJ0dzgvcVNH?=
 =?utf-8?B?QUwvck1qbWwyMzFvbitzMWx3SGtPMjJ5KzJtbFNtRWtMalM1L1VTdE5ENDZE?=
 =?utf-8?B?Y3Nza084OEFrcUYyY1d6ZmlMVlFISU9EN0d1OGp5NVNwMjdpTlVBK2d0YzNM?=
 =?utf-8?B?OEJSU3N6R1Y3MjdSTXJHemFVNHY2RVRNMTFoZ0VLaGhuQmx5SENkbnNMVW9F?=
 =?utf-8?B?bUo3SlhxbWJqYS9PT1hHWityR1dsNEVQTkdVVFljdzVYY0pvUmFENHN1SGdv?=
 =?utf-8?B?RXlqMmRLRVVhd3pHcjR4K1NNK09ibW1RRFIwL0F4SEIwYUFsakZaU2M5NmFL?=
 =?utf-8?B?QVdoNG9wR2tMdU45MFF0QzRZdllrMzQ4SHQ3dlF6blJwUW5RZVRkam9xZmZX?=
 =?utf-8?B?bk1HYnZ2VnVxTlVqWFdMNGVrUHdnL1BIUmIva3JTZEFLQmlYcysvdjVBU29i?=
 =?utf-8?B?R0tZdm9IREIyNUlRZnZIYis4NmE5MXFpdmREZ0hrRkhiL1J6NjA5NlpSRnlZ?=
 =?utf-8?B?WUF0cnU5bHpnT1ZGaUUxUWNOc3FTazBZOEhhMDNWcnBycm1QQjlLcy8wVnU2?=
 =?utf-8?B?Y2lXd1p1OVJISktmUjdYc1Yxbjd4aHFIY0FYMGs3aWk3Wm5tOG1pa2kvUlJz?=
 =?utf-8?B?RUk5Y0ZHZENaZk44c2ZTSitPN2MxWEVzMjlYV0wwMk5ZZk9lU3NTbkpidE1V?=
 =?utf-8?B?VzgwTWhVcXZ3cENnNXR4VnlqWTUxMzhnaDYyTnI2dUg2dXhTRkE1Z01GWU5t?=
 =?utf-8?B?aC9oNmN0QUEzTWRYSzFoTFdyRlBDakF1ZzRvckNBYTJNZE9oWVV4OTM2eGxn?=
 =?utf-8?B?V2NqVjRneFRIN2d6aFdYZzFYZEEwd2lyTUVWNEhVQlFpRHNzWEVtNEFITFUw?=
 =?utf-8?B?eVAvWjFoZVNkSGJTTWNub244SzAzRG1ZV2kxbjNlTXhtbFJ4S3ZKaE5IWGxK?=
 =?utf-8?B?OFVjcmZhSWhtYU5RRlg3Nk8vWjhWMEZCNHdORmZXc08zK2ZaNFFhanRkNEZR?=
 =?utf-8?B?dU1vdDVVeWlFVzB1ZVMwaHA3R3JPNEp5NTJFUVZrNGZ5OTk1NHFYS0FsOWlh?=
 =?utf-8?B?RVJMczhEc0M2bUgrY2xqRXo4RkU1eTFJZDc3Q3BXQW96cXN5czVpdXhCRDV1?=
 =?utf-8?B?VnFkSEpJaFpIWnJlbkJBQ1hiVGQvemU3Z0pjUnk0UUhCeGRhUjVSRHZrSzFX?=
 =?utf-8?B?TmQzSjU4dk5paUd5dWpXUUFyc0FIZm1yTWQ0RENNZEtHMTVzQTJDRi9wVWl4?=
 =?utf-8?B?T1l2WGc0cm5PMks4QU53SSswbEdLVTZSV25RaVFwYnVZSWtjQ25UTnIrcXM2?=
 =?utf-8?B?N3JQZWI1blJzVlVpMVhWcEI4WHJ6cXoyYXdhRjFvSDZibGdGOWxEa3NNYlN5?=
 =?utf-8?B?azRwUjhTVjY2b21iTWpaZis4S2VmNHdrR1J6LzllSWhzK1RZRk5peW43Nm5P?=
 =?utf-8?B?WCttTVppK3ZHSWxlK3F0cGlYR0RSakJnMDR1RzhtdENjRlZYWDZMUmZEUzFy?=
 =?utf-8?B?YjR3UjZUR1RKeGE5bXpabzUwaXZpRTRqVC9VaHJsU3FKRmFjRDdwWjdwd0JL?=
 =?utf-8?B?UDlTdXNlQTM4VlgxdTZteWwrMTN2aDcwNXVtWlVFRFVyWFpuR2xtUTNzVENj?=
 =?utf-8?B?Z3RhZTdOT0JodGU3RGxQYmV5N3ZObHAvTDdwZ2NkQ0RhMFNFT2NRcFVxRE9M?=
 =?utf-8?B?TmdyOEFheU0rMm4vNjZDRmdtMVMzcS8rZVVjTkJ1RjhobHlrUlpSdmxGZHEr?=
 =?utf-8?B?Sk1ocHJzYXNrclVWS1hkeDJ5Q0ZZRUZpNjN2RFpTU2VHd0h6T2E3QjdUdnFN?=
 =?utf-8?B?QUVwRVovSHc0Q2phY0t0di9GVks1Q2ZNbjNqV2ZrSk5lZEhLQ21lWEJjVXhJ?=
 =?utf-8?B?V3ljM0hobzAyb3NHT0VBZ1ZNTTZoTmFWNlUvMkljNFR1ZUlBUjZuUjFuM09C?=
 =?utf-8?B?TVdCYnNvbVZTSE5LMFZwcHJGbXVNRGp1b2wwN3ZvYTc3VHg1S2lnNXUvVUpv?=
 =?utf-8?Q?+ONVmdgS0Xm7Ot0VjI2z9R1vs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <153824735D061545A496F525050C2E39@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ac4b38-4451-43ea-4152-08dccb33af0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:43:21.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ospfbFYJGF67aSYj3x8aJCxhWOsSG6K8tlJgrlp22pLCtjsuffDR7zpfckLOzfizdCLexV8XCm9pvPWYYfxSgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6979
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA4LTMwIGF0IDA5OjQwIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFRoZSBtaXNjIGNncm91cCBjb250cm9sbGVyIChzdWJzeXN0ZW0pIGN1cnJlbnRseSBk
b2VzIG5vdCBwZXJmb3JtDQo+IHJlc291cmNlIHR5cGUgc3BlY2lmaWMgYWN0aW9uIGZvciBDZ3Jv
dXBzIFN1YnN5c3RlbSBTdGF0ZSAoQ1NTKSBldmVudHM6DQo+IHRoZSAnY3NzX2FsbG9jJyBldmVu
dCB3aGVuIGEgY2dyb3VwIGlzIGNyZWF0ZWQgYW5kIHRoZSAnY3NzX2ZyZWUnIGV2ZW50DQo+IHdo
ZW4gYSBjZ3JvdXAgaXMgZGVzdHJveWVkLg0KPiANCj4gRGVmaW5lIGNhbGxiYWNrcyBmb3IgdGhv
c2UgZXZlbnRzIGFuZCBhbGxvdyByZXNvdXJjZSBwcm92aWRlcnMgdG8NCj4gcmVnaXN0ZXIgdGhl
IGNhbGxiYWNrcyBwZXIgcmVzb3VyY2UgdHlwZSBhcyBuZWVkZWQuIFRoaXMgd2lsbCBiZQ0KPiB1
dGlsaXplZCBsYXRlciBieSB0aGUgRVBDIG1pc2MgY2dyb3VwIHN1cHBvcnQgaW1wbGVtZW50ZWQg
aW4gdGhlIFNHWA0KPiBkcml2ZXIuDQo+IA0KPiBUaGUgU0dYIGNhbGxiYWNrcyB3aWxsIG5lZWQg
dG8gYWNjZXNzIHRoZSAnc3RydWN0IG1pc2NfY2cnLiAgUGFzcw0KPiAnc3RydWN0IG1pc2NfY2cn
IHRvIHRoZSBjYWxsYmFja3MgYnV0IG5vdCB0aGUgJ3N0cnVjdCBtaXNjX3JlcycgYmVjYXVzZQ0K
PiB0aGUgbGF0dGVyIGRvZXNuJ3QgaGF2ZSBhIHBvaW50ZXIgcG9pbnRpbmcgYmFjayB0byAnc3Ry
dWN0IG1pc2NfY2cnLg0KPiANCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9v
cC4ya2R3MzZvdHdqdmptaUBoaHVhbjI2LW1vYmwuYW1yLmNvcnAuaW50ZWwuY29tLw0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS3Jpc3RlbiBDYXJsc29uIEFjY2FyZGkgPGtyaXN0ZW5AbGludXguaW50
ZWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxp
bnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFpdGFvIEh1YW5nIDxoYWl0YW8uaHVh
bmdAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJr
a29Aa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IFRlanVuIEhlbyA8dGpAa2VybmVsLm9yZz4N
Cj4gVGVzdGVkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPiAtLS0N
Cj4gDQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=

