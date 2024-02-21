Return-Path: <cgroups+bounces-1729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84C85D601
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D694628357C
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DF83A1C1;
	Wed, 21 Feb 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ej5agHkF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F2376F8;
	Wed, 21 Feb 2024 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512554; cv=fail; b=HA96YlvrHHUzETjIjwCBDwpI3YniZBu0Ey2S3jR63PDQUZqgWgcjZJXZlWp4cip+6vmppPTLuvqexWnWiJ3hJGRWsvCqcDWP9yCN0jJFoYzzgLa8bT662EoXBeL1p7iaXOILW7lTEoGE4LkFi9ODHPZg81ZkdxehSPXrXAi6It8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512554; c=relaxed/simple;
	bh=7DCdAj95K83QVFZRCn6mEAnbWku34EM9bU1bZVna7Lw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXOKuYydml22uwRTijh55fBhIiM4IKdSagA67g74lwbudwrFihpwjLdBqokN+1iyUs+kVCaBWbeai4MBbTHAEIdmo7GcqBqS/cqGQHqnJ+kJs6cVzd3doJneSWVL9aAnee1I6/s10OM92RPIEFphPYvHBi/alQB0Bwi00sR4g0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ej5agHkF; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708512552; x=1740048552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7DCdAj95K83QVFZRCn6mEAnbWku34EM9bU1bZVna7Lw=;
  b=Ej5agHkFP7Cr//8QiCzGzAyhj5y4rnI+xF6l9edZAXihlOdCPVMjqtBT
   Fp0sQ1Mbq8LpJZVSgYRiZbOw8C8cS9wtxkAfFeev1t6hH1K8KpjXF8XnG
   o8NLhv08kEnUH53D86U6vTWZwW8GB6NeHVphn1XMgRrvwNs1PBMqhfu8r
   Jj8h8Dq9HHh65uF6A8VqNsj1Y2vwXtGo3EEGDKqTr/iI9SrMvFcU4t4Hh
   kdM8uTOf8m/UZCZbuXDfuj2/OA8HwtmpBx2Nn+TWV3oThHGMN84+sfExv
   bQzvSzxlLEB+3xxBq+Z1vyzj/r10cliaOuDarX3dQzoSgtuRq6oxjYckI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2534087"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2534087"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 02:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5030471"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 02:49:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 02:49:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 02:49:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 02:49:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 02:49:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSIwtB9rCfpiGElf5OrAJvxUn2uMQDYxCke1ez49PtBwPsnjf2QzASsebhQpXbQFLGpOrmL8/o4HDJIFpK1k64jIPURTp/9+hptYDKgZdWP4bI8lwcrJGoObqjxmBL5IEZcsLmxYO4iViCE7ZHZdZSPp1F+PvP+OSoDVItRct7BJKezwMV3SYu6A2CmZ8vdni1difRxhd8huHcx0nzPhcCKVBS53kLnh3Ql1XukCLtjR6rruBMGofIcDssscCtw31GsxDQZB3aCWJWCTHzrlWDSXN6F60rPWcXBKNSao15UkqjU+7IEC2Yg5pYwuykYM6/lHqZPrPLUtOymMZHj0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DCdAj95K83QVFZRCn6mEAnbWku34EM9bU1bZVna7Lw=;
 b=NaaHAkEKZyxP2vA6spsVfrGEywDDx/3LrvigxSPDQ420og7c5rHiuZ8Jq1AtxE90zqxKr/n7FIzcI/Z6S9oCK51kcbWytUAr3Wq/dERwDpq+5Z2nd7RKWABmuXwQcLPyCgEBVUOra2ETKMakqmcED0mOmKjsWzvGIbKSol4ktLuMcmTGRL1mfziX+V9khY3fngGpPAA6h6mMvC0K7GdqobrN0CwGrVM2iFsvKnDR469UAgRsGg8jOvrZ+czXIIEOnFQi9JvDVJ+mLtD+EyPiFdwzKgqiVrUF2tX8fqMf0elbj0bmQpfFbk83AxsJhPiUZaAG7xY4H/iXUyDZN6C/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB6853.namprd11.prod.outlook.com (2603:10b6:510:22e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 10:48:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 10:48:58 +0000
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
Thread-Index: AQHaWH7Wr4F7uI4dL02icaTavGjkgLETFBIAgAFX3QCAAEo0gA==
Date: Wed, 21 Feb 2024 10:48:58 +0000
Message-ID: <bf21f955c1b56ef836ad03bc42d522b6d020edbf.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-9-haitao.huang@linux.intel.com>
	 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
	 <op.2jhao6nzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2jhao6nzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH8PR11MB6853:EE_
x-ms-office365-filtering-correlation-id: f839c50a-b2f7-43c8-136e-08dc32cab4f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvwGRIAXHxQORkYlATu6XzKo8Zly/2+a1wV1EggVPC/7pqpXovZ49L3wLRcX/bgd2R/ogVw8xrbM8r9X7c3HbHPnCSu4iVjvUc/nXPnGk4FvJflJaRW+dmDbO272JCqwHPz6tJhTsmBVAq9KQkf6t8PiPIx5AfzBX/5tzc9UjWFHNy0GzuXLBtfQZjgByWNmDvzwks98tCYkKIxrJQ/rqH3HYzymVY0q16E068DGZ300daysw5EUHCNkUi/sDMezfx1Eyw/zTihSCCMxuyUMilmHDfU/Oihve5iKmkiE/2ulpbFtY+ns+GnYyW4NmGB5DMkTARWQRNwWoRlOD5eEsT3oKDPsS4nbQrOh4N5UFKy8ueDJE32DJq52eQ6rXzo8+XKvnyur1aU0Rc709kKZAsYDw5UB7DYYahuu6Q4B2tyJnyIZCnHHZWvUTA343EwOXVdD2DgJ3mF64qV2TVtiWhPoHq0N85VHijuqGcln0cac2HFHc4Volgq2+i0WeVkvC7+nHYESRL2GKdILU/NksYC7PNbSBoLH1JFR+FTrGSgxQDj1hkF86w5NWzjbIEclzltTkPrBIygGjoPKJwGv4yxMTzOGQ/YF9Kjj5qwrSAGkPhyMNae5kzw0GZzsA6G2Y1IhblaiebuJYnjvShcR5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGE1V1hpNXkzWkZtMGgvLzBRUkZCMkp6Z1ZOb2pJd3ROOGNpTy9FY1o5Um1G?=
 =?utf-8?B?OFlkdlY0S1VJcVI4UGI4YmRKWElaVFRyVGpHdTBzOHU0elk1bFNiVGl2dGdo?=
 =?utf-8?B?Tkc1Q1pmajh5VGF1dCtEMUxBR2hzTXFBUGlhd3hUUnFwTS9NdHkrdlhkRmVT?=
 =?utf-8?B?N2Nhb1VqdHhOa1cyRk5TRlF2UnZNeGpJUjVVTit3ajZrT0EwT2lMNE81WVNR?=
 =?utf-8?B?eDhtVnQ4M0J3eEc2K2dQbmd3OUdwYkxKRy9lNTRYQ1NNeXQzd0wrbVlFbndF?=
 =?utf-8?B?ZmVVV0ZWSDJzMXNVekhyWnNqMVBJZkhCMDBweXlMVC9VQVdmTEMxQlNMSUQ0?=
 =?utf-8?B?RE15RVZndEo3RjVxOTQzLytWWUpNUWtmdmxvRXYxOG1kYUttczQ0Si9qY2Mr?=
 =?utf-8?B?OHJDUCtzS0ZjNE5BMGZFWmI3Uks0a1EyOGJzNWlGVHNjUGx4RFVObWoxcWFw?=
 =?utf-8?B?YW80KzZPeWZuOGxaUGFkN0E2ZStVVkhhTUt3anl2RVROSjhrVnpPc0UrMDRL?=
 =?utf-8?B?cTEzOUxvelZhNjQ0WDY4VmRjKzlubGgveWRhZnRuOVpINEZKTENjQ3liTnZH?=
 =?utf-8?B?OTRFMEdxaHlTTXJnZGFLOEd2aDQ3bmdzWHFKZEgwNG9sN2JCbGJYUWZvNnZj?=
 =?utf-8?B?SjBPcUdHK0xDMXhtelpsRjlyL0huWlo4Ym8wTXNJMG5pWTRFUzZPaExWTVJ5?=
 =?utf-8?B?Nmp6UGdKN1ZjTEFGSGJPWURadVRBRm5EdFg2S0RxR2VkQmIzdmxHK1hnZ2RX?=
 =?utf-8?B?QVVGY295M2xHaGNiZGJtRjB3eE9JeUt4ak10VkVwVml6T3BkVDQwNlI0ck54?=
 =?utf-8?B?ZDFmcGZCallIWVVWQ3FzUndESTV1cXA5L3d4ZXFmcXF5VHowT1FVRlNpVzR6?=
 =?utf-8?B?c25udmxNY2w4NTVrYXgxOXdEOWZjVGJRRFZoNVNEbEVocEVvZ1VqV25hZXJr?=
 =?utf-8?B?dlQ0VFF5ZlZzRjFZZWlwYU1vTFhiT2VyYnQrcGI5S3Z0RHJMZnk5Y3lYNE9U?=
 =?utf-8?B?UnU5ck1PaGlmUnQ1dUxaM0IzT2NDcStScFJJeWs5MCt0clhJUWVXZUt4UFRq?=
 =?utf-8?B?ZTFmQWhPNUhKSjcrQlhvbit1NTBqK3ZnZ0lMZ0w2Q0VFMkliN1lVVi9odE8z?=
 =?utf-8?B?bzJSK2wvbUhqbTJET1gwS0hmTGFSSmJLdUtubGROU3ViTmdxc0gyNkdGcEtE?=
 =?utf-8?B?ZVVsSkcvU3JSNGlpdFFpSlVxRWEvU3grQ2dtbXlqclRoall3clFmYXplOGZh?=
 =?utf-8?B?VVNmVEVIRTNqVlZTSSt1ZFdDc0RyK2dKRDhVS3JCWURNNk10NUw0NkFYOEp0?=
 =?utf-8?B?Q2Y3b2Z3b1JtaGxjb20wU3d5VVluLy9HODlMVURsRm9paTd6KzNrSVUzZE1n?=
 =?utf-8?B?WXE1aTdGbWNid0ZxY3cxN3lqQXpGVDNRYkhOZkxJRXNURHRYMlJCcXNNLzgw?=
 =?utf-8?B?MERMR2I1dC9McHpIak1mS2ZMNjZTS3RmbFZDdlZNVVg3SEZOL3NCelJFenRj?=
 =?utf-8?B?Z2ZqL2N1WVpjbUU2WlJFVzd3SGJPL25xeHBPVDdBR1ZUbUFUdklyOTZDbW93?=
 =?utf-8?B?THhpUG5hUXBvcHRFN21zVm1kYU1rbVZMYlNsZGJab3NLZll1a1BHcXkxbUxJ?=
 =?utf-8?B?cEVyTDNMeXo3T2d3ZStnaDQyVUNqMEt0RzBXa3lrNTd2bDVBV3c1WlN0c0ww?=
 =?utf-8?B?WmRxeFlsWFpad1BJNVRhVDBxc2JEYWh0VFd0MjhjSlZXa1RvbWVJdWtiNHR1?=
 =?utf-8?B?clFmNXk4VGpIMUl2ZUlzQmlMeXdpSGxpc1V5cDgxTzNpTGR1MlR1V0xybDBH?=
 =?utf-8?B?blFHSHRVQTNDQzB1MTAxMUtPSGNxZDBCL0pXSlRyWmdONVNRTHNpM2lSWkZn?=
 =?utf-8?B?NmI4eFE1eUx4cXVGZ1NEcXdQdGhaVUZzTzN6VXFmc0NOdDFVMjN3dzlBd2N5?=
 =?utf-8?B?aVZnMXo3eElDcnlGUkd4MmcyL0dmK3I2QTVwOHpTSkNBL1U3RUE1NksvUjBC?=
 =?utf-8?B?bGdXQVhRcWM5K0ZDMnNmODE5WlRzeE5PMDBSVGc3Ym5lMXhuTU94N2NFakxI?=
 =?utf-8?B?eURMSEZkWlJ2NGo1VXlOaHFJZGNhamNKQXVxY0VaZXJ6NEV5b01MTGowRVdP?=
 =?utf-8?B?T1A3aWxTKzNDcU1yUUc4aUxrVis0aG9VTS9GajBpRjlQSkhWR0RiNC9Ec2sw?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A93C6B344157D45AD1A027474CA42DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f839c50a-b2f7-43c8-136e-08dc32cab4f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 10:48:58.0294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBUj1S4AvUlSQpzMJKgTk+7DlkwAdoWeWQqba/wvHSdniGiS2KTKmb/s6cIyLsfj9zZm9lDAajvK//bs1+4BEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6853
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDAwOjIzIC0wNjAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IFN0YXJ0SGkgS2FpDQo+IE9uIFR1ZSwgMjAgRmViIDIwMjQgMDM6NTI6MzkgLTA2MDAsIEh1YW5n
LCBLYWkgPGthaS5odWFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiBbLi4uXQ0KPiA+IA0KPiA+IFNv
IHlvdSBpbnRyb2R1Y2VkIHRoZSB3b3JrL3dvcmtxdWV1ZSBoZXJlIGJ1dCB0aGVyZSdzIG5vIHBs
YWNlIHdoaWNoICANCj4gPiBhY3R1YWxseQ0KPiA+IHF1ZXVlcyB0aGUgd29yay4gIElNSE8geW91
IGNhbiBlaXRoZXI6DQo+ID4gDQo+ID4gMSkgbW92ZSByZWxldmFudCBjb2RlIGNoYW5nZSBoZXJl
OyBvcg0KPiA+IDIpIGZvY3VzIG9uIGludHJvZHVjaW5nIGNvcmUgZnVuY3Rpb25zIHRvIHJlY2xh
aW0gY2VydGFpbiBwYWdlcyBmcm9tIGEgIA0KPiA+IGdpdmVuIEVQQw0KPiA+IGNncm91cCB3L28g
d29ya3F1ZXVlIGFuZCBpbnRyb2R1Y2UgdGhlIHdvcmsvd29ya3F1ZXVlIGluIGxhdGVyIHBhdGNo
Lg0KPiA+IA0KPiA+IE1ha2VzIHNlbnNlPw0KPiA+IA0KPiANCj4gU3RhcnRpbmcgaW4gdjcsIEkg
d2FzIHRyeWluZyB0byBzcGxpdCB0aGUgYmlnIHBhdGNoLCAjMTAgaW4gdjYgYXMgeW91IGFuZCAg
DQo+IG90aGVycyBzdWdnZXN0ZWQuIE15IHRob3VnaHQgcHJvY2VzcyB3YXMgdG8gcHV0IGluZnJh
c3RydWN0dXJlIG5lZWRlZCBmb3IgIA0KPiBwZXItY2dyb3VwIHJlY2xhaW0gaW4gdGhlIGZyb250
LCB0aGVuIHR1cm4gb24gcGVyLWNncm91cCByZWNsYWltIGluIFt2OSAgDQo+IDEzLzE1XSBpbiB0
aGUgZW5kLg0KDQpUaGF0J3MgcmVhc29uYWJsZSBmb3Igc3VyZS4NCg0KPiANCj4gQmVmb3JlIHRo
YXQsIGFsbCByZWNsYWltYWJsZXMgYXJlIHRyYWNrZWQgaW4gdGhlIGdsb2JhbCBMUlUgc28gcmVh
bGx5ICANCj4gdGhlcmUgaXMgbm8gInJlY2xhaW0gY2VydGFpbiBwYWdlcyBmcm9tIGEgIGdpdmVu
IEVQQyBjZ3JvdXAgdy9vIHdvcmtxdWV1ZSIgIA0KPiBvciByZWNsYWltIHRocm91Z2ggd29ya3F1
ZXVlIGJlZm9yZSB0aGF0IHBvaW50LCBhcyBzdWdnZXN0ZWQgaW4gIzIuIFRoaXMgIA0KPiBwYXRj
aCBwdXRzIGRvd24gdGhlIGltcGxlbWVudGF0aW9uIGZvciBib3RoIGZsb3dzIGJ1dCBuZWl0aGVy
IHVzZWQgeWV0LCBhcyAgDQo+IHN0YXRlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCkkga25v
dyBpdCdzIG5vdCB1c2VkIHlldC4gIFRoZSBwb2ludCBpcyBob3cgdG8gc3BsaXQgcGF0Y2hlcyB0
byBtYWtlIHRoZW0gbW9yZQ0Kc2VsZi1jb250YWluIGFuZCBlYXN5IHRvIHJldmlldy4NCg0KRm9y
ICMyLCBzb3JyeSBmb3Igbm90IGJlaW5nIGV4cGxpY2l0IC0tIEkgbWVhbnQgaXQgc2VlbXMgaXQn
cyBtb3JlIHJlYXNvbmFibGUgdG8NCnNwbGl0IGluIHRoaXMgd2F5Og0KDQpQYXRjaCAxKQ0KICBh
KS4gY2hhbmdlIHRvIHNneF9yZWNsYWltX3BhZ2VzKCk7DQogIGIpLiBpbnRyb2R1Y2Ugc2d4X2Vw
Y19jZ3JvdXBfcmVjbGFpbV9wYWdlcygpOw0KICBjKS4gaW50cm9kdWNlIHNneF9lcGNfY2dyb3Vw
X3JlY2xhaW1fd29ya19mdW5jKCkgKHVzZSBhIGJldHRlciBuYW1lKSzCoA0KICAgICB3aGljaCBq
dXN0IHRha2VzIGFuIEVQQyBjZ3JvdXAgYXMgaW5wdXQgdy9vIGludm9sdmluZyBhbnkgd29yay93
b3JrcXVldWUuDQoNClRoZXNlIGZ1bmN0aW9ucyBhcmUgYWxsIHJlbGF0ZWQgdG8gaG93IHRvIGlt
cGxlbWVudCByZWNsYWltaW5nIHBhZ2VzIGZyb20gYQ0KZ2l2ZW4gRVBDIGNncm91cCwgYW5kIHRo
ZXkgYXJlIGxvZ2ljYWxseSByZWxhdGVkIGluIHRlcm1zIG9mIGltcGxlbWVudGF0aW9uIHRodXMN
Cml0J3MgZWFzaWVyIHRvIGJlIHJldmlld2VkIHRvZ2V0aGVyLg0KDQpUaGVuIHlvdSBqdXN0IG5l
ZWQgdG8ganVzdGlmeSB0aGUgZGVzaWduL2ltcGxlbWVudGF0aW9uIGluIGNoYW5nZWxvZy9jb21t
ZW50cy4NCg0KUGF0Y2ggMikgDQogIC0gSW50cm9kdWNlIHdvcmsvd29ya3F1ZXVlLCBhbmQgaW1w
bGVtZW50IHRoZSBsb2dpYyB0byBxdWV1ZSB0aGUgd29yay4NCg0KTm93IHdlIGFsbCBrbm93IHRo
ZXJlJ3MgYSBmdW5jdGlvbiB0byByZWNsYWltIHBhZ2VzIGZvciBhIGdpdmVuIEVQQyBjZ3JvdXAs
IHRoZW4NCndlIGNhbiBmb2N1cyBvbiB3aGVuIHRoYXQgaXMgY2FsbGVkLCBlaXRoZXIgZGlyZWN0
bHkgb3IgaW5kaXJlY3RseS4NCgkNCj4gDQo+ICMxIHdvdWxkIGZvcmNlIG1lIGdvIGJhY2sgYW5k
IG1lcmdlIHRoZSBwYXRjaGVzIGFnYWluLg0KDQpJIGRvbid0IHRoaW5rIHNvLiAgSSBhbSBub3Qg
YXNraW5nIHRvIHB1dCBhbGwgdGhpbmdzIHRvZ2V0aGVyLCBidXQgb25seSBhc2tpbmcNCnRvIHNw
bGl0IGluIGJldHRlciB3YXkgKHRoYXQgSSBzZWUpLg0KDQpZb3UgbWVudGlvbmVkIHNvbWUgZnVu
Y3Rpb24gaXMgIlNjaGVkdWxlZCBieSBzZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKCkgdG8NCnJl
Y2xhaW0gcGFnZXMiLCBidXQgSSBhbSBub3Qgc2VlaW5nIGFueSBjb2RlIGRvaW5nIHRoYXQgaW4g
dGhpcyBwYXRjaC4gIFRoaXMNCm5lZWRzIGZpeGluZywgZWl0aGVyIGJ5IG1vdmluZyByZWxldmFu
dCBjb2RlIGhlcmUsIG9yIHJlbW92aW5nIHRoZXNlIG5vdC1kb25lLQ0KeWV0IGNvbW1lbnRzLg0K
DQpGb3IgaW5zdGFuY2UgKEkgYW0ganVzdCBnaXZpbmcgYW4gZXhhbXBsZSksIGlmIGFmdGVyIHJl
dmlldyB3ZSBmb3VuZCB0aGUNCnF1ZXVlX3dvcmsoKSBzaG91bGRuJ3QgYmUgZG9uZSBpbiB0cnlf
Y2hhcmdlKCksIHlvdSB3aWxsIG5lZWQgdG8gZ28gYmFjayB0byB0aGlzDQpwYXRjaCBhbmQgcmVt
b3ZlIHRoZXNlIGNvbW1lbnRzLg0KDQpUaGF0J3Mgbm90IHRoZSBiZXN0IHdheS4gIEVhY2ggcGF0
Y2ggbmVlZHMgdG8gYmUgc2VsZi1jb250YWluZWQuDQoNCj4gDQo+IFNvcnJ5IEkgZmVlbCBraW5k
IG9mIGxvc3Qgb24gdGhpcyB3aG9sZSB0aGluZyBieSBub3cuIEl0IHNlZW1zIHNvIHJhbmRvbSAg
DQo+IHRvIG1lLiBJcyB0aGVyZSBoYXJkIHJ1bGVzIG9uIHRoaXM/DQoNClNlZSBhYm92ZS4gIEkg
YW0gb25seSBvZmZlcmluZyBteSBvcGluaW9uIG9uIGhvdyB0byBzcGxpdCBwYXRjaGVzIGluIGJl
dHRlciB3YXkuDQoNCj4gDQo+IEkgd2FzIGhvcGluZyB0aGVzZSBzdGF0ZW1lbnRzIHdvdWxkIGhl
bHAgcmV2aWV3ZXJzIG9uIHRoZSBmbG93IG9mIHRoZSAgDQo+IHBhdGNoZXMuDQo+IA0KPiBBdCB0
aGUgZW5kIG9mIFt2OSAwNC8xNV06DQo+IA0KPiBGb3Igbm93LCB0aGUgRVBDIGNncm91cCBzaW1w
bHkgYmxvY2tzIGFkZGl0aW9uYWwgRVBDIGFsbG9jYXRpb24gaW4NCj4gc2d4X2FsbG9jX2VwY19w
YWdlKCkgd2hlbiB0aGUgbGltaXQgaXMgcmVhY2hlZC4gUmVjbGFpbWFibGUgcGFnZXMgYXJlDQo+
IHN0aWxsIHRyYWNrZWQgaW4gdGhlIGdsb2JhbCBhY3RpdmUgbGlzdCwgb25seSByZWNsYWltZWQg
YnkgdGhlIGdsb2JhbA0KPiByZWNsYWltZXIgd2hlbiB0aGUgdG90YWwgZnJlZSBwYWdlIGNvdW50
IGlzIGxvd2VyIHRoYW4gYSB0aHJlc2hvbGQuDQo+IA0KPiBMYXRlciBwYXRjaGVzIHdpbGwgcmVv
cmdhbml6ZSB0aGUgdHJhY2tpbmcgYW5kIHJlY2xhbWF0aW9uIGNvZGUgaW4gdGhlDQo+IGdsb2Jh
bCByZWNsYWltZXIgYW5kIGltcGxlbWVudCBwZXItY2dyb3VwIHRyYWNraW5nIGFuZCByZWNsYWlt
aW5nLg0KPiANCj4gQXQgdGhlIGVuZCBvZiBbdjkgMDYvMTVdOg0KPiANCj4gTmV4dCBwYXRjaGVz
IHdpbGwgZmlyc3QgZ2V0IHRoZSBjZ3JvdXAgcmVjbGFtYXRpb24gZmxvdyByZWFkeSB3aGlsZQ0K
PiBrZWVwaW5nIHBhZ2VzIHRyYWNrZWQgaW4gdGhlIGdsb2JhbCBMUlUgYW5kIHJlY2xhaW1lZCBi
eSBrc2d4ZCBiZWZvcmUgd2UNCj4gbWFrZSB0aGUgc3dpdGNoIGluIHRoZSBlbmQgZm9yIHNneF9s
cnVfbGlzdCgpIHRvIHJldHVybiBwZXItY2dyb3VwDQo+IExSVS4NCj4gDQo+IEF0IHRoZSBlbmQg
b2YgW3Y5IDA4LzE1XToNCj4gDQo+IEJvdGggc3luY2hyb25vdXMgYW5kIGFzeW5jaHJvbm91cyBm
bG93cyBpbnZva2UgdGhlIHNhbWUgdG9wIGxldmVsIHJlY2xhaW0NCj4gZnVuY3Rpb24sIGFuZCB3
aWxsIGJlIHRyaWdnZXJlZCBsYXRlciBieSBzZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKCkNCj4g
d2hlbiB1c2FnZSBvZiB0aGUgY2dyb3VwIGlzIGF0IG9yIG5lYXIgaXRzIGxpbWl0Lg0KPiANCj4g
QXQgdGhlIGVuZCBvZiBbdjkgMTAvMTVdOg0KPiBOb3RlIGF0IHRoaXMgcG9pbnQsIGFsbCByZWNs
YWltYWJsZSBFUEMgcGFnZXMgYXJlIHN0aWxsIHRyYWNrZWQgaW4gdGhlDQo+IGdsb2JhbCBMUlUg
YW5kIHBlci1jZ3JvdXAgTFJVcyBhcmUgZW1wdHkuIFNvIG5vIHBlci1jZ3JvdXAgcmVjbGFtYXRp
b24NCj4gaXMgYWN0aXZhdGVkIHlldC4NCg0KVGhleSBhcmUgdXNlZnVsIGluIHRoZSBjaGFuZ2Vs
b2cgaW4gZWFjaCBwYXRjaCBJIHN1cHBvc2UsIGJ1dCB0byBtZSB3ZSBhcmUNCmRpc2N1c3Npbmcg
ZGlmZmVyZW50IHRoaW5ncy4NCg0KSSBmb3VuZCBvbmUgcGFpbiBpbiB0aGUgcmV2aWV3IGlzIEkg
aGF2ZSB0byBqdW1wIGJhY2sgYW5kIGZvcnRoIG1hbnkgdGltZXMgYW1vbmcNCm11bHRpcGxlIHBh
dGNoZXMgdG8gc2VlIHdoZXRoZXIgb25lIHBhdGNoIGlzIHJlYXNvbmFibGUuICBUaGF0J3Mgd2h5
IEkgYW0gYXNraW5nDQp3aGV0aGVyIHRoZXJlJ3MgYmV0dGVyIHdheSB0byBzcGxpdCBwYXRjaGVz
IHNvIHRoYXQgZWFjaCBwYXRjaCBjYW4gYmUgc2VsZi0NCmNvbnRhaW5lZCBsb2dpY2FsbHkgaW4g
c29tZXdheSBhbmQgZWFzaWVyIHRvIHJldmlldy4NCg0KDQo=

