Return-Path: <cgroups+bounces-2517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB358A6D5F
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8ADCB22144
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8B12D743;
	Tue, 16 Apr 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxqOeF5p"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47212CD81;
	Tue, 16 Apr 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276479; cv=fail; b=Zcs1g1n0lZp1hHGH7yG7ldPZcIBDEAuuoq5qbnaqJS2bkWo/aOFeJFFtZOMmI3arkMXWouB9f3PUrsLrZ6F7r+su0l/oJRMJh1vUKQWpSxG6r+gSz1wqkdX0EfarreCfjmptFW+suWAYNb9smAn4i9fjRqHa0ViKSoBPDsjs2R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276479; c=relaxed/simple;
	bh=l6Sm3Yn8F7c2B8HtICNkRu88ALQsTtD0gs43qDmTlZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IcectQA1dWlR/SmBcPs7hqhhcM77wfI66dep26vGfhQQ0o4yondj8T+w3OyyhZ8MN2jO08wx288DA15u/WBgQdrrvWZqiA45uWJmL636fRiLjngAbMNh4y3wICizRuGuN2cUAM2iQIub0HWtZ6aVWTZGami1dIKNwThsuz2YoR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxqOeF5p; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713276476; x=1744812476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l6Sm3Yn8F7c2B8HtICNkRu88ALQsTtD0gs43qDmTlZA=;
  b=mxqOeF5p6p5vwj5GSWfi+rRt+tqQ2UAyEDcUaBYh4yRWdiUVrLexUkbq
   TxENEgnzwFPc2rP9QzBBnkuqSrHA9c/J6C289vxQUMMOU8ylk7NxFRDdn
   5SDm19CBgAsK9v8APC664kDPgblYbHU84d/TblI6vOwswActHEVJEMAuL
   evpSWd2wz7r3IOjmcEnsJY8uVW/xRhxKKrSSWcJlclPQAueO1Gj5cxcz+
   Ow+UC4WAl6fINvw5E/nqDNU66kktH3+M93XnR1ymHraiCloCvURMXOHo3
   1P2+pm2b8HuyqJVn2Jr74yyA2Rs91/R0saSWZvzVe2pqei3STNj2qLmj6
   g==;
X-CSE-ConnectionGUID: lFs3+nrwT06VgcDZ/pmdhg==
X-CSE-MsgGUID: qw2fnH7FQQS3eUyxZT9Ilw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31196285"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="31196285"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:07:37 -0700
X-CSE-ConnectionGUID: SCfyy8N1TVWZVtelYXIsGw==
X-CSE-MsgGUID: 55dF4GQbR/aTDmwZ3VsM2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22745738"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 07:07:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 07:07:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 07:07:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 07:07:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 07:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VczBqK7cUf6l1dLHH1H5MxWwrNNBLhoJaidivLL14UFvxsxrc75SGx9HMyuV+4ix0kPGGmg6z6gCfDmeSNmInKfvKFq6ZBE3m5zKqyNqXf4N9q42klENRZ7fM60Xc2FsnSrLmThSIMfKE4qPoAnZWJhhNqsQmgWJoHKey5K/Hg6M0VmyaYKMHXDy113qBu/m8eOarXH7Z/KWadek+2Qyp83uMHwFaGiOS3khf/v0WK35uGspjobOaCgkPOsYNAIb3J40pPMSg9vJsm6e+fa36U2ernR2MfOFol8usuD/NwcYzogkXi2cACzn1dW2a6xI4VSCbXFQiu2hXeuiAHthPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6Sm3Yn8F7c2B8HtICNkRu88ALQsTtD0gs43qDmTlZA=;
 b=iMbjID2LzUCGJKL/XZ9I0eW+CuHeJegtxDqI6oCcafITJM/N/ycubu1YR5aQ5C5CXdDz3ptjNvnBkceXsBzmtpfm+4mc7fFv9dXce2AktafC3LNbC/P1/LBbsWXhlsUQkBEI6UdMFjHkFdc7Da2OniWF3GbZQJjkm5GvKZJrY+Gh7rlqcbCIRDqffmIqPuEs8s0UZmv2m0Um+jgbasVeDFOVd9EVIkXGxLh2EQ2bqrDVOlAF5eXEr7acdM8kEhNYKuuM0bbQ+Y0MC2Sf2EDt5xEnmS6j0Sg9e7c1Y2dlF74sMGxgdG4RuIzl9v7SCMepjwOXCYOlSk4saBR3kxmBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Tue, 16 Apr
 2024 14:07:33 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:07:33 +0000
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
Subject: Re: [PATCH v12 07/14] x86/sgx: Abstract tracking reclaimable pages in
 LRU
Thread-Topic: [PATCH v12 07/14] x86/sgx: Abstract tracking reclaimable pages
 in LRU
Thread-Index: AQHaj60GXySDSr2JmkaUVFOThKwPk7Fq73oA
Date: Tue, 16 Apr 2024 14:07:33 +0000
Message-ID: <e218d2aab5d793a3b4c64f90f7bad997c745ba91.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-8-haitao.huang@linux.intel.com>
In-Reply-To: <20240416032011.58578-8-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4705:EE_
x-ms-office365-filtering-correlation-id: c0cb4196-6059-43d0-e582-08dc5e1e8f93
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7wjol/5BZkvD7yjGSX7izjaVkyHrlXIGtXW9/tEc60LBortftLM1YkBhwaRUtjXohA8H+TXO7EzzaLtO9Sl3amtJHJ8+vR1HjqCX9mQi2NJQwSUvLWK0fqkPUjLKO9jkdlTUTbbLuaWsLoofugX+xittaVtHNBxk+DGa6RTVhu2ak6lAPQS9BxHXHZBqaMEXBWiZqFBLvk4p9+32Kuhb+FeopRszv4CJPDVcuvyPBWe/VOGH857e/ZBEAuGDsKuXp6Bv/rORhDtacbXFzV6ttO67Mo5j0NH35ZVvS2QA0Ss6QZ9xSQKm8RLlnSRh94cHEA4U0zAmoCFz1HgFmPdw7v73nYCH2IoPKg2xiye2zPeV5cfLdax/9VQPdU7DlVfgCGXLpI7niLwPgCiKyiogAsVHwH1SZdk9vixjR13I5qLz92wGtYM1jP9EeGfM5QuJmSG3CK4GAr1gnwxWqQkzVX9OcxjOMJKc1sSrtEDc+5xvBlL5UKXkXDhvipEaICKlZ35VZiAJS4Xc/mpCVQL8au2lfGDVWqkrm9MqQkM/+tpb4i5LohAOL1Vg2MVWQbISZr8w+YfLWzc6T0L+nQJtkxjsFsgj/5biR7/4RClVRfBMrcLRcCTLhtCDFbJ1kn8l+qfCNP7yEP9y0UU4zWg8y1+7PAVvDaSGMopCls1hRvQG8OIXPDvHzuDnXWeEAxGvakCE3VUA3UttHptzxRvq10PwtQu22s/xkwVOpMXcQcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXRwN0V6R2g4TGJlQ2NMRUIxeG4xNmg5YnF0eXlBdmY2ZmxJNng3QUhJQ2M2?=
 =?utf-8?B?SHRVbVkzc3Jsd0RFTzEzNHZWd0ZYSytZTXU4SklSRzJPY2x3ZzltVklCc2c0?=
 =?utf-8?B?bDZiNyt1WERuZ01OMkVyR2lIWU1UTW5RRUF2VWdwUmNoMkxsNFdQREY4SUFE?=
 =?utf-8?B?VmZnWml4Z2FBelViNldFQWpkNWV5cW9uMHdGcytLeHBxT1Fwbk1NU1E5VVhE?=
 =?utf-8?B?Y0lNd0ljV2xoSUxzWFBiWWg5MFlKQTVHa09HWUw2bVA3VUR3c1llZjFQc01p?=
 =?utf-8?B?ZTVlSjBDS2paZjlFcHkwRUxDL2piRm9kcTZBSXZ2Q2d6TkM2cXJSNlFtMGNS?=
 =?utf-8?B?NzA0Y0hzMnZEOEJ3OXRTTDR1TTRUSDdTZjhVNEp0ait2ckdLMVRDN3VhWlZk?=
 =?utf-8?B?TDQzeDlXTTR1SnoydXJiTmVxK09ybTBtMUI2ZkJxb2tMK1Jqam9nc0xWaktQ?=
 =?utf-8?B?TTFZTWdXNjZJTlZOQ2x0WStBa2ZyMUlGNWwxa1BKbEZZWlpzTTlnSFJ6VXBl?=
 =?utf-8?B?UURTeUQwdFhDanNpbERrTDlRZjJyMGFZY0ZMLzBBbzgyc3FSZTc4cjZLSnZ3?=
 =?utf-8?B?NjZFQnBEOTJKcFdnTWRYWkQxVjRaUVRTcGVJdmdWdHY5bWoydVVUWThXZWsy?=
 =?utf-8?B?aW1zNkI1cmdueW9lZ09XV0hzaTRlb0JaSWNqM1Z2ZjZhcFNiRzYzMnh5RmRY?=
 =?utf-8?B?V0UwUWJCZjV5N1UzUXptcWtxaUttazFLNUtUc2trYXdwWlBLbEdKMCtjdS92?=
 =?utf-8?B?V0lUTFNoUmxLa3RJR1NVZ3V3U3ZLcjlnZkZ2eC9FQWVKaEtNVHNMZXNXdmc1?=
 =?utf-8?B?bGJqSTRnNnpXQ1IyWDlDYjBjcDJUMjJnRDV0QXh5a3V1Y2Zaa3VyUXZUZkp2?=
 =?utf-8?B?WXU3TzRIMk9CK05pV3BWNGloVFRyTkVmOUJnN2xxdGsxWTZCczlPMExlL281?=
 =?utf-8?B?RXhSVWJXN3BIOWVlSVBwUWVyY3prOVBCcS83UjBvRlIrVElYZEtHNVNmNjZG?=
 =?utf-8?B?ZmwveTBNNUd3UHZ3UE93VUFXL3k5aWdwNDlvditRMUVSVE5iQnRYNWJnWXNO?=
 =?utf-8?B?UVU3cEMrQlk5d1NmUU9XREgzT0hiUWsxS2JOejFFVzNLY0s2L1VlVlZ4dFZO?=
 =?utf-8?B?REQ4YTczbEVnMjBmRWRLTEJPM3VXbm1mRUkwa3ZraDg1aDNsbE10MG9vckRZ?=
 =?utf-8?B?ZFBNYVl2Qm1HME5sWCtDMDdvR3BET1RJTEJYK2tud0VGdTQra092eVR6M2Zz?=
 =?utf-8?B?czQvNkVJbVVWWjdRdHkwdlRwRWhTSDJnVktQandEeVBud2lYcGFRckN0cFg1?=
 =?utf-8?B?YnJMb04zMlBEaHRCVWJqQ05OV2lFYWRHeURmRWhWaHdKUjBUdUxQZmFOZnVt?=
 =?utf-8?B?a2wrSkExNlNkVzZ1WklzOXJ1SmhYcVU2UFJUaE42akh2c3JydkEyUWVZL3I5?=
 =?utf-8?B?cEU5V0FvaUJEeFNFTjgzSWJveTFPZjU3cjF5U3ArNVlQemdZYTlHN1NTejhj?=
 =?utf-8?B?bzFXMTRyTFV2eDQ0WVdYcjcxU0lXQU5aTFM5T09zakZSb3NHV1hKU1podUZ1?=
 =?utf-8?B?VmlpYTJCRmU5anhhbWNLL1RBLzNRMnV2eHdNQVR1Q1UwMjJPNlBHeXpldzZs?=
 =?utf-8?B?dSt1ZU1UdGtoVVZVbjRXOUFJS1NNZFNGTzBWdnQrWGtudGRYSGZTc1NERTJj?=
 =?utf-8?B?eXlXemRDYVg1L04wdU10bGZ1WTE1cUVid0F5Qml2YzJ5WU1LNE54UGp1bHk3?=
 =?utf-8?B?eTVzQS9ZbU1CTFE0SERqQzd3cFlRSXlIRWxoR05sUkI0WHJsSXdtaTBUUmJY?=
 =?utf-8?B?Zzhaczdobmk5ZzBXNjJ4MXFuaEtzS3N1VHcwUk9tM2Z6VDNsUW5lSVZQb0RH?=
 =?utf-8?B?QzJDQnZ3ZktqRFVUUGNqLzVIY1NaNHlwcDEvVy9oUW43R0FqR2RhVkpKd3pN?=
 =?utf-8?B?MERiMEtDNDJzNTVtRDhWbE5kQU1QdGhkQzRaamZjczgwZDVGRXVUbWs3K2Nq?=
 =?utf-8?B?Nzc1S3I3aXlRanhXQkVZdFNkcFlrb2lvL1ZNdDAzSUpaSG9OYnBhdEptVUVm?=
 =?utf-8?B?aDgyNGUyUjA4MjRhczBxM0Q4aGtCUjZXYWFWeVhyaldDZTNQcy83RUhldTg2?=
 =?utf-8?B?allzUEdoZVBXUXB1VDlrMUo4dFc3bjlqZ3dSankwRzlYcm5yQ0NnZGEvNldF?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1758729CA3E1D644BA779F15B954BE9D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cb4196-6059-43d0-e582-08dc5e1e8f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 14:07:33.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlF9sRPxmJ3rZiXegZsq8eVZYzRxdu1RNr0RK1nukxet6pK5/THMN/ksV3flnSclIWbDvD//fUuU5Vr8fE+SzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDIwOjIwIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFRoZSBmdW5jdGlvbnMsIHNneF97bWFyayx1bm1hcmt9X3BhZ2VfcmVjbGFpbWFibGUo
KSwgbWFuYWdlIHRoZSB0cmFja2luZw0KPiBvZiByZWNsYWltYWJsZSBFUEMgcGFnZXM6IHNneF9t
YXJrX3BhZ2VfcmVjbGFpbWFibGUoKSBhZGRzIGEgbmV3bHkNCj4gYWxsb2NhdGVkIHBhZ2UgaW50
byB0aGUgZ2xvYmFsIExSVSBsaXN0IHdoaWxlDQo+IHNneF91bm1hcmtfcGFnZV9yZWNsYWltYWJs
ZSgpIGRvZXMgdGhlIG9wcG9zaXRlLiBBYnN0cmFjdCB0aGUgaGFyZCBjb2RlZA0KPiBnbG9iYWwg
TFJVIHJlZmVyZW5jZXMgaW4gdGhlc2UgZnVuY3Rpb25zIHRvIG1ha2UgdGhlbSByZXVzYWJsZSB3
aGVuDQo+IHBhZ2VzIGFyZSB0cmFja2VkIGluIHBlci1jZ3JvdXAgTFJVcy4NCj4gDQo+IENyZWF0
ZSBhIGhlbHBlciwgc2d4X2xydV9saXN0KCksIHRoYXQgcmV0dXJucyB0aGUgTFJVIHRoYXQgdHJh
Y2tzIGEgZ2l2ZW4NCj4gRVBDIHBhZ2UuIEl0IHNpbXBseSByZXR1cm5zIHRoZSBnbG9iYWwgTFJV
IG5vdywgYW5kIHdpbGwgbGF0ZXIgcmV0dXJuDQo+IHRoZSBMUlUgb2YgdGhlIGNncm91cCB3aXRo
aW4gd2hpY2ggdGhlIEVQQyBwYWdlIHdhcyBhbGxvY2F0ZWQuIFJlcGxhY2UNCj4gdGhlIGhhcmQg
Y29kZWQgZ2xvYmFsIExSVSB3aXRoIGEgY2FsbCB0byB0aGlzIGhlbHBlci4NCj4gDQo+IE5leHQg
cGF0Y2hlcyB3aWxsIGZpcnN0IGdldCB0aGUgY2dyb3VwIHJlY2xhbWF0aW9uIGZsb3cgcmVhZHkg
d2hpbGUNCj4ga2VlcGluZyBwYWdlcyB0cmFja2VkIGluIHRoZSBnbG9iYWwgTFJVIGFuZCByZWNs
YWltZWQgYnkga3NneGQgYmVmb3JlIHdlDQo+IG1ha2UgdGhlIHN3aXRjaCBpbiB0aGUgZW5kIGZv
ciBzZ3hfbHJ1X2xpc3QoKSB0byByZXR1cm4gcGVyLWNncm91cA0KPiBMUlUuDQoNCkkgZm91bmQg
dGhlIGZpcnN0IHBhcmFncmFwaCBoYXJkIHRvIHJlYWQuICBQcm92aWRlIG15IHZlcnNpb24gYmVs
b3cgZm9yDQp5b3VyIHJlZmVyZW5jZToNCg0KIg0KVGhlIFNHWCBkcml2ZXIgdHJhY2tzIHJlY2xh
aW1hYmxlIEVQQyBwYWdlcyB2aWENCnNneF9tYXJrX3BhZ2VfcmVjbGFpbWFibGUoKSwgd2hpY2gg
YWRkcyB0aGUgbmV3bHkgYWxsb2NhdGVkIHBhZ2UgaW50byB0aGUNCmdsb2JhbCBMUlUgbGlzdC4g
IHNneF91bm1hcmtfcGFnZV9yZWNsYWltYWJsZSgpIGRvZXMgdGhlIG9wcG9zaXRlLg0KDQpUbyBz
dXBwb3J0IFNHWCBFUEMgY2dyb3VwLCB0aGUgU0dYIGRyaXZlciB3aWxsIG5lZWQgdG8gbWFpbnRh
aW4gYW4gTFJVDQpsaXN0IGZvciBlYWNoIGNncm91cCwgYW5kIHRoZSBuZXcgYWxsb2NhdGVkIEVQ
QyBwYWdlIHdpbGwgbmVlZCB0byBiZSBhZGRlZA0KdG8gdGhlIExSVSBvZiBhc3NvY2lhdGVkIGNn
cm91cCwgYnV0IG5vdCBhbHdheXMgdGhlIGdsb2JhbCBMUlUgbGlzdC4NCg0KV2hlbiBzZ3hfbWFy
a19wYWdlX3JlY2xhaW1hYmxlKCkgaXMgY2FsbGVkLCB0aGUgY2dyb3VwIHRoYXQgdGhlIG5ldw0K
YWxsb2NhdGVkIEVQQyBwYWdlIGJlbG9uZ3MgdG8gaXMgYWxyZWFkeSBrbm93biwgaS5lLiwgaXQg
aGFzIGJlZW4gc2V0IHRvDQp0aGUgJ3N0cnVjdCBzZ3hfZXBjX3BhZ2UnLg0KDQpBZGQgYSBoZWxw
ZXIsIHNneF9scnVfbGlzdCgpLCB0byByZXR1cm4gdGhlIExSVSB0aGF0IHRoZSBFUEMgcGFnZSBz
aG91bGQNCmJlL2lzIGFkZGVkIHRvIGZvciB0aGUgZ2l2ZW4gRVBDIHBhZ2UuICBDdXJyZW50bHkg
aXQganVzdCByZXR1cm5zIHRoZQ0KZ2xvYmFsIExSVS4gIENoYW5nZSBzZ3hfe21hcmt8dW5tYXJr
fV9wYWdlX3JlY2xhaW1hYmxlKCkgdG8gdXNlIHRoZSBoZWxwZXINCmZ1bmN0aW9uIHRvIGdldCB0
aGUgTFJVIGZyb20gdGhlIEVQQyBwYWdlIGluc3RlYWQgb2YgcmVmZXJyaW5nIHRvIHRoZQ0KZ2xv
YmFsIExSVSBkaXJlY3RseS4NCg0KVGhpcyBhbGxvd3MgRVBDIHBhZ2UgYmVpbmcgYWJsZSB0byBi
ZSB0cmFja2VkIGluICJwZXItY2dyb3VwIiBMUlUgd2hlbg0KdGhhdCBiZWNvbWVzIHJlYWR5Lg0K
Ig0KDQpOaXQ6DQoNClRoYXQgYmVpbmcgc2FpZCwgaXMgc2d4X2VwY19wYWdlX2xydSgpIGJldHRl
ciB0aGFuIHNneF9scnVfbGlzdCgpPw0KDQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6IFNlYW4gQ2hy
aXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxp
bnV4LmludGVsLmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5o
dWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEhhaXRhbyBIdWFuZyA8aGFp
dGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEphcmtrbyBTYWtraW5l
biA8amFya2tvQGtlcm5lbC5vcmc+DQo+IFRlc3RlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJr
a29Aa2VybmVsLm9yZz4NCj4gLS0tDQo+IA0KDQpGZWVsIGZyZWUgdG8gYWRkOg0KDQpSZXZpZXdl
ZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K

