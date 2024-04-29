Return-Path: <cgroups+bounces-2715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7F8B55C5
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 12:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F390A1C2337F
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471063A1CB;
	Mon, 29 Apr 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zwn0XTUj"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A822EEB;
	Mon, 29 Apr 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387761; cv=fail; b=TD77vw87TV7xBOHyaq3C9tLTaPjF1jlpLWc9bCZ8uctY3dsNxawnouC5+30G3p3Y2xboTdxglpMqAu3Ke6WbqBHzN7BBGQqBF7b1S5IPcCfU5xnYkwJ0LELi7PHHjUtVpyCEKSm5Wk9htLWHuge+7yxp/9Rtg5H5qmKaHA3O58g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387761; c=relaxed/simple;
	bh=ahMktf80p4dQ40h7Uq+7BZIU0+UT8oA28dZDdC8s+qs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IGKeSAqAPr5KPOqgAYEkq7pWiMu6U1B92rNANcRrglLgw0Xq2Z5qIa4RNsOZOvaSmWVS1AM5vcWLCIEmbD1x9lKmDbrL6Gw2TA3LljzATWEk1IItB8xkqV9piJhc4HpuV74c64AG5E5oXfmTlEdNC6TdBb47te/ei8bwA0qRU4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zwn0XTUj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387759; x=1745923759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ahMktf80p4dQ40h7Uq+7BZIU0+UT8oA28dZDdC8s+qs=;
  b=Zwn0XTUju0lK5S3jD2xUhGNgp70DhO4qdyLwcWpATKnLU+YFv1OHeSXE
   FMuIk8iLITmzd9Y+psXHVdFUWl40nHmIsFW34Fs7lFFJuzatyNazJkmOi
   Kx2pp8SgCudFO7uiq6Qv4yOMGj6zhrb8zGogm6Hxs5DfcvU3o/axouw6y
   dsBVB4dMtk8A1CAruMC0kSUQwm+G3EXcdpfi7jvbLDvTLqKYRU2ker3/v
   2hPC57a+34pyBfI5qFTbPz812mNItDndASMlIAr8cyZn8J+zkvUZ68/lQ
   siLYCd79qfC3wlbb7FvHeRdE+rAwiHSmm5ccpSw0N/xYt2AJEf5Y4iZ3f
   g==;
X-CSE-ConnectionGUID: YNtObQ50RseyXK4LXTD2Iw==
X-CSE-MsgGUID: iF6b3YAUSKaDRP8+LhW+ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27559254"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="27559254"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:49:18 -0700
X-CSE-ConnectionGUID: D1N63ZUFRVunXLvpamzItQ==
X-CSE-MsgGUID: Jx1jL1tRSpSDkKC6qXtYQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30896958"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 03:49:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 03:49:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 03:49:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 03:49:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHtgKRa7hjEJrI0+gg8Jwo2N6c8xT8gUazp062w6REwCe6b7NwxR7a/Z8Olwkc9V1t8TQrw++W96VavzE4JYEoqOfTrZ/uOPYk0Kwg5cUVvBltm3yuZBqlPgiHpEpuBsNRyTRk6/GG1m5ILGQ2YIW1a0EYa+CxK2wjol0Q/JQP44QFe4ZbFPO1TLfvlP1ULx2pHR9MXRbRNdwDh1BDM8OjLWnsdIadLkUw0Ip6aOe73tVfoksmrHAWzuqZ4dMssCrjadE9DvoG9OkYYZsClnqpcb9JLyL7tEvaOw7JuwBztBOTCEZthYcBXv9x8q3jAVygSwpjiWhwbKe6giLDOmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahMktf80p4dQ40h7Uq+7BZIU0+UT8oA28dZDdC8s+qs=;
 b=Pc95REWpTcny9iviglc/oq4f6IFds6aw/vw7YGtARfA2ItVTOCY2QC38EMsw1GZP4nCRqLk9ed1nO5yxi3L4+9p1SK7MtWt6i86cWyxxVyLAjWm1NgQcu+HcGQRTQnWkRFZja3qh+eo4r0dudaHppwlkj0mXmT6hBKZBmNnXalTCRZz7MYJWaLaRJAGuyyhDOQhZGV3+J9PO6PoJow9OX4TwDM6FEVfthLXkXORvZiJ08qey3vWifb16BuraIygfC5A0gfYmN6evMrHrAPp7AtiLo8I8eoElvm+Sm1dXwVTD/1+mdSayR4frHk358ocbuEIt3fpvZjQ9iEL0QZMR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 10:49:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 10:49:13 +0000
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
Subject: Re: [PATCH v12 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Topic: [PATCH v12 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Index: AQHaj60LgTBKy0QQlk6tHBw2IapFdrF/JmEA
Date: Mon, 29 Apr 2024 10:49:13 +0000
Message-ID: <524cf9b081d86ae61342fdfc370a3639d0010f94.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-13-haitao.huang@linux.intel.com>
In-Reply-To: <20240416032011.58578-13-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6523:EE_
x-ms-office365-filtering-correlation-id: 6c659aff-61b2-4156-f1a0-08dc683a0262
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bC8yMW5EOWpsR29lNk5ZMzd0a2ppTDUzRngyVzRYY2hqYTU1Nmw2Sk5wMHlS?=
 =?utf-8?B?cEgyNk1LNHlpOWJidlprMmYrcmtRRXhvNjNLRUk5cFIzK1B3eDZ2cFJseVNl?=
 =?utf-8?B?eVYxYXpUZVBUOFIydEIyakZlR1dqK2taZ1lXL3lLNjJnWldXWVQ1ZHA1bE5H?=
 =?utf-8?B?SGJsdWVpdWFOaEc0NVI1anpwM29WQ0ZYTGJWUWd1NWVLVzV6eHgrbEhoZDB5?=
 =?utf-8?B?VkUrMWdkYmhlalY1ZnM0U0QxZWdhWFN6NWN5NGhFK01YTWphVUJEMGY3Yko4?=
 =?utf-8?B?VE0vNkJrSHNrNm9tVGIvVjBRNTNkc2FvSEd3MzdIMDZzK0dlN1RZOURCN2V4?=
 =?utf-8?B?dW54ZXZ1eW1xTWJtcmpLVTVHQStMTVBJcStGTkNBN2IyeEpGK3ptTlJaRFJi?=
 =?utf-8?B?bnZZTVBCZ1RQaTVUbWNLd0k4ck5SclRLZmJLWUhzZ1JSQ0lGTE9aNGl0TUNW?=
 =?utf-8?B?amFYQm1WbHFFeFpXWHpCLzVjU0plSDZjVnF3THB6UFNzT0hTY2ZzV3doNDNC?=
 =?utf-8?B?bWRLKzJoWWdJcnI3MHJ1aklraG9RVVh4SjMzeXhDcEVERWFEMXh3UmdwaTQx?=
 =?utf-8?B?Z2gvZDNOWFd0TkU4aFdXQmNaaFpSTkNQZ3NyTCtpTDBEd2gwSGdhWFd0NzBV?=
 =?utf-8?B?VENKaHpINWJqM0MyRkNRQlpGOHBQOUhDOUVrNHRxQmpkQ0V0cTB0U29kTEww?=
 =?utf-8?B?VHo1UUNDM0oxSXdUY1dQcGRFOWUzZnRMRVE2bHFyTmFlTC9xeU5scTVrTEVl?=
 =?utf-8?B?aHhkN013dEYzQlJiWUhZcWd1Y1E0bStjemtqU3J3eG9IOCtZMmo3Z0JZUm1u?=
 =?utf-8?B?Q1ZtWkE5RTZELzF6NzgvQmtDZ1lGL2tMMEt1R21ZeW5mVVkvUmpBVXI3TXNN?=
 =?utf-8?B?TVM0aSs0dllNdUQyOEJJcnc3bW13Z3J0bUd4a0NoRHN6VUkyU0NGSjUxM2JQ?=
 =?utf-8?B?dFAzWXgvdWljTnIzM1NIcytWaHF1K3BYNEZoOVU4N1Avd05MRnB5cGVia3Rj?=
 =?utf-8?B?R0ZlNk1oclN6bWFSWm5NUUpsTkdvYXF3V2JsWW5DQ0JIL3hOZ0I0RFdkQmZJ?=
 =?utf-8?B?bERjWW9LSDlzUTlSeE1KNmdmeUl0OE9SNTBvam1nb2RINkp5aHpUQ1dIU2pl?=
 =?utf-8?B?akZqRFFiR1Y3SFpNbkx5RkdtRHdVNGxvVG5PQXVMOWZBUUQ5QkxWZGQ3NDI2?=
 =?utf-8?B?L0VRYmxnbkFEekF4cVlYVTJsMzdEZnhOOFF1djBqbmdRSWdWb0FWRjJ6SEMw?=
 =?utf-8?B?VS8xOFREZHdqSXpqYnpDaU5CaTVMd0ZWVEI1Y2tidDBnNWdEZFdOb3FMOHBn?=
 =?utf-8?B?Q2FkZ3VpN3RuZ3ZKS3pyZGp6aUkzdlpQVTZDejdyWGVWb2Rib09zQ0xzNFdz?=
 =?utf-8?B?RXpOV2RYUXk5T09mTkd0akI1WkFYRUtPYWNpbW9FbXdVUXhQcUpPTFB5OU5B?=
 =?utf-8?B?ZEhBd2IyNzlNczBhbm5QRGtDT2hQRTBJdWl4aE96N0hyT0Fyd0pIeFQydVpI?=
 =?utf-8?B?TXA0cDZQMUZCZklHa3RmdHNuRDBkMW5XL3gyZG1yOXJCQnhHR3VNWFVFTDd3?=
 =?utf-8?B?bGJSVzc1eFlqRm02NDhjVCttQ29qSUg1a09lWEdEUkJoZzBVVHhVcnlBVFcw?=
 =?utf-8?B?UUNDNmdFVUhSVkVZVEErOVZUMUFFVlBrSW8xOER0U0F4eWRscEpPdWszd0ZI?=
 =?utf-8?B?SFVXV0o0QU5Ub0MzY1RvNzVMVUtmeld6ZGo0UmcxazU4U1FHMFJid0J4YWow?=
 =?utf-8?B?YUU4bmN5R0RsNS9ubnp1VENZbUtyWUZJcGhjWWpvQ3NnOG0ycjhKa0Y3VXlE?=
 =?utf-8?Q?a5A7Vfk2k54cE/ewUi5CW9hYQ8UENRekTQ5tA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVJUbithRGhSa1pDT1k3R3JHWHpCRVNYLzJabTRhN25VeFJhSTVTNEtpZkVa?=
 =?utf-8?B?T0JYbHdPRkNjUHR0ZDhJZlNjRktPY0tqNVU1TTZZMC9wRS9zSlc4R3pyUkI3?=
 =?utf-8?B?ZXEwUlJKLytrY1l0Uk5tOUZ6ZVdXRUxxZ0lrNUdLN3V1TlN4QlZFVkl3ZTE2?=
 =?utf-8?B?V2NkSzBtOWozMThnMW5FblhiR3ZFSjBORmY2VG9IV3VPT0RIS1ozc29yOG9G?=
 =?utf-8?B?bFkzT1h5K2Z1cC9Fb0JpTDBnQmwyeFBsWm50MXNrWjhEMVozQVRqY1pYdkNa?=
 =?utf-8?B?eFlJWWRaRlQra1lWYjhWRTUza2hnMmpPeEIyb3UvMmlSQ0ZSNHRwV1pMN2Ny?=
 =?utf-8?B?dnZRQXVYOHpRUlBBNVFzMkhEWnU5amoxcmhyOFh6SVRVY0ZFYTJXamZBOTZ6?=
 =?utf-8?B?NE5lU2tKa2xOTS9oVEZ2ZVJrQ3JDVjJOWHdORnNrSmhFWjRvNFR5TGpEVDU3?=
 =?utf-8?B?bW96ZkhLQ0RxZnBkaWJ3YkptM25WanNFSUYrWGVQdzVCUk1Ba2JHV2IwaURF?=
 =?utf-8?B?RXFBeVdTR0Q0KzBtN1FZMzVoRGlaVnl1UUozQml0cUc3M1ZsSlpQS0hXZkQw?=
 =?utf-8?B?dElDRXZXRUsyNnFxMXdPZGFJdjNmdlA5Yjc1RWlTTmZOU01Yb2J6Rkt3Wi81?=
 =?utf-8?B?YlA4dGMwRkdrYXI5NlhPK3JIaFBKTE40elNDYlliSVdHQS9qaWtHMHJISWI1?=
 =?utf-8?B?UVBxVTRFaGlTNGc2bUZtVTFyd25EMHorMzRIR1piMTZHbFh6WWJnR29ESHht?=
 =?utf-8?B?anBuUmNhNFZSMVdIRHpOMFFkWjFzeC9YdWVGM0FWYnhOeVhwYWNwdG82N2kw?=
 =?utf-8?B?ZEF0RFRGQ3dRUktpMWY2R24xQmhpY3JCQ2FOU042azdKeHhBTHI4eXNMUTly?=
 =?utf-8?B?QU84cUwvOGQydHZZOWVJYlVlVkNkWlBSR0VFNnJQZUlhTnBkVmVSa1FKemRp?=
 =?utf-8?B?Z0trWjhZT1hhS1o1V3lhckw0MXFzVERDbVdDNlRFRk85STFkMi9qeVJJdElo?=
 =?utf-8?B?WFBKQWxVY04rU2RiUVdYMmszRWVTYkE5dFJ4c3g0cG5kTTRIdytpb2lpREdm?=
 =?utf-8?B?M1hFYjRDTGRSbElqdnpISkdiUDJ2QWplMVBPcnVMT0ZSVEhLNXJGblBEd0VL?=
 =?utf-8?B?bGVkVE0yZ0VVU3FqaUhhNU96ajcrRWs4ZEFvRzMwOTJHMXJWdVhaNUhOT29W?=
 =?utf-8?B?ZGptOVVQZzhUSUdsTmdsVVN4UEQxcW5pRG1YMW94SE85NVI4QW1oMTRlK2s4?=
 =?utf-8?B?SGNwQmtpM1Era3RHVjVhYnp0SzRCbTB3dGZITlBaZG1DWUJZNVpZU01MTTE0?=
 =?utf-8?B?cTZSR2JVd2VFT1U4RjMyVXRGZTFnSjhaaHFiOFA5WXJZYWN5Rkc5Skc3Z09q?=
 =?utf-8?B?ZExLN1N4akgwY2Yvakl0ZFhSc0VOWnJSSEVvM1FmcFQzN3Fjb1ZiWHA2M2Fo?=
 =?utf-8?B?TElvbC9NK0V6Wk4yMHZ3WU12YldOcWVZWGJKaWgwUndSYTFRbUF1VmRyZmVJ?=
 =?utf-8?B?SlZacHFSQWFCYjNBMEw0NnhYQkF0ZEk1amJlZGIyZ2ZUNEJQWTAzM1AwU2lQ?=
 =?utf-8?B?RDUxTy9ZTDVWSlRieHZ2MUZHZUlHSnlyUlc5eExka3ljZ3pyNEp4eSt5Y1E2?=
 =?utf-8?B?UCtyclk3ak9yVWE3QjE4SExFV2xnYXp2THlCOEV0YWVhOXJDOStScDBubFFl?=
 =?utf-8?B?TEc3eHd5K05DTVNBcU5GUy9ZZTVvRmdpQnRZVHVBRXlMTThxLzBmMFFJRGUy?=
 =?utf-8?B?UzhKSWRwVFhZVkY5bXhzRjF5OWN3L2d2SjAyMEk2eWxmNVNmK2V0YU9YTSt6?=
 =?utf-8?B?aHVsclFGanhUYktpK0FnR0l6dzhvbjhoOEtZc1d3MmNFUzFUaXVZRTJ4eDBy?=
 =?utf-8?B?V0xaOW1ORHdlRHVocnVMRXBFb1RQbm85SzlOVDVJTnhaNEtiNFIyKzJ3Mjhh?=
 =?utf-8?B?TDBMRTFjTEVoUmtLcjZScmo0ajBhcW1MeC9yREUwaHB6djA5V1BJUkVwQWha?=
 =?utf-8?B?cjJ0VWdPUjZzcWRrckw1Z1hTTUN5QU5rQzFiY0VsMXE4ZHZ0aFVONk5hZ2Va?=
 =?utf-8?B?WFFFTHh0dnRRWVdaTXJMRmRzajRrT3dsQ0xTQ3ZiSllvenN2L3lYeEZ1eEJ0?=
 =?utf-8?B?cEVtaU1ETzVEUEFJSDdzWXlsSGl1bzQ5NVZzZVFsYll3VXVnaGN5MEhOSEdQ?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE2C44349D34A14390D9ED58D196DCE4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c659aff-61b2-4156-f1a0-08dc683a0262
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 10:49:13.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeUioPQ8TfdEpFCabxXREDIpzvwyOCOoxLNa48u4tqMKYDZtEPMjLTrywl1o/7oykWqPDXgEIFucj0LqmvrJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
X-OriginatorOrg: intel.com

DQo+ICsvKg0KPiArICogR2V0IHRoZSBwZXItY2dyb3VwIG9yIGdsb2JhbCBMUlUgbGlzdCB0aGF0
IHRyYWNrcyB0aGUgZ2l2ZW4gcmVjbGFpbWFibGUgcGFnZS4NCj4gKyAqLw0KPiAgc3RhdGljIGlu
bGluZSBzdHJ1Y3Qgc2d4X2VwY19scnVfbGlzdCAqc2d4X2xydV9saXN0KHN0cnVjdCBzZ3hfZXBj
X3BhZ2UgKmVwY19wYWdlKQ0KPiAgew0KPiArI2lmZGVmIENPTkZJR19DR1JPVVBfTUlTQw0KPiAr
CS8qDQo+ICsJICogZXBjX3BhZ2UtPnNneF9jZyBoZXJlIGlzIG5ldmVyIE5VTEwgZHVyaW5nIGEg
cmVjbGFpbWFibGUgZXBjX3BhZ2Uncw0KPiArCSAqIGxpZmUgYmV0d2VlbiBzZ3hfYWxsb2NfZXBj
X3BhZ2UoKSBhbmQgc2d4X2ZyZWVfZXBjX3BhZ2UoKToNCj4gKwkgKg0KPiArCSAqIEluIHNneF9h
bGxvY19lcGNfcGFnZSgpLCBlcGNfcGFnZS0+c2d4X2NnIGlzIHNldCB0byB0aGUgcmV0dXJuIGZy
b20NCj4gKwkgKiBzZ3hfZ2V0X2N1cnJlbnRfY2coKSB3aGljaCBpcyB0aGUgbWlzYyBjZ3JvdXAg
b2YgdGhlIGN1cnJlbnQgdGFzaywgb3INCj4gKwkgKiB0aGUgcm9vdCBieSBkZWZhdWx0IGV2ZW4g
aWYgdGhlIG1pc2MgY2dyb3VwIGlzIGRpc2FibGVkIGJ5IGtlcm5lbA0KPiArCSAqIGNvbW1hbmQg
bGluZS4NCj4gKwkgKg0KPiArCSAqIGVwY19wYWdlLT5zZ3hfY2cgaXMgb25seSB1bnNldCBieSBz
Z3hfZnJlZV9lcGNfcGFnZSgpLg0KPiArCSAqDQo+ICsJICogVGhpcyBmdW5jdGlvbiBpcyBuZXZl
ciB1c2VkIGJlZm9yZSBzZ3hfYWxsb2NfZXBjX3BhZ2UoKSBvciBhZnRlcg0KPiArCSAqIHNneF9m
cmVlX2VwY19wYWdlKCkuDQo+ICsJICovDQo+ICsJcmV0dXJuICZlcGNfcGFnZS0+c2d4X2NnLT5s
cnU7DQo+ICsjZWxzZQ0KPiAgCXJldHVybiAmc2d4X2dsb2JhbF9scnU7DQo+ICsjZW5kaWYNCj4g
IH0NCj4gIA0KPiAgLyoNCj4gQEAgLTQyLDcgKzYzLDggQEAgc3RhdGljIGlubGluZSBzdHJ1Y3Qg
c2d4X2VwY19scnVfbGlzdCAqc2d4X2xydV9saXN0KHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKmVwY19w
YWcNCj4gICAqLw0KPiAgc3RhdGljIGlubGluZSBib29sIHNneF9jYW5fcmVjbGFpbSh2b2lkKQ0K
PiAgew0KPiAtCXJldHVybiAhbGlzdF9lbXB0eSgmc2d4X2dsb2JhbF9scnUucmVjbGFpbWFibGUp
Ow0KPiArCXJldHVybiAhc2d4X2Nncm91cF9scnVfZW1wdHkobWlzY19jZ19yb290KCkpIHx8DQo+
ICsJICAgICAgICFsaXN0X2VtcHR5KCZzZ3hfZ2xvYmFsX2xydS5yZWNsYWltYWJsZSk7DQo+ICB9
DQoNClNob3VsZG4ndCB0aGlzIGJlOg0KDQoJaWYgKElTX0VOQUJMRUQoQ09ORklHX0NHUk9VUF9N
SVNDKSkNCgkJcmV0dXJuICFzZ3hfY2dyb3VwX2xydV9lbXB0eShtaXNjX2NnX3Jvb3QoKSk7DQoJ
ZWxzZQ0KCQlyZXR1cm4gIWxpc3RfZW1wdHkoJnNneF9nbG9iYWxfbHJ1LnJlY2xhaW1hYmxlKTsN
Cj8NCg0KSW4gdGhpcyB3YXksIGl0IGlzIGNvbnNpc3RlbnQgd2l0aCB0aGUgc2d4X3JlY2xhaW1f
cGFnZXNfZ2xvYmFsKCkgYmVsb3cuDQoNCj4gIA0KPiAgc3RhdGljIGF0b21pY19sb25nX3Qgc2d4
X25yX2ZyZWVfcGFnZXMgPSBBVE9NSUNfTE9OR19JTklUKDApOw0KPiBAQCAtNDA0LDcgKzQyNiwx
MCBAQCBzdGF0aWMgYm9vbCBzZ3hfc2hvdWxkX3JlY2xhaW0odW5zaWduZWQgbG9uZyB3YXRlcm1h
cmspDQo+ICANCj4gIHN0YXRpYyB2b2lkIHNneF9yZWNsYWltX3BhZ2VzX2dsb2JhbChzdHJ1Y3Qg
bW1fc3RydWN0ICpjaGFyZ2VfbW0pDQo+ICB7DQo+IC0Jc2d4X3JlY2xhaW1fcGFnZXMoJnNneF9n
bG9iYWxfbHJ1LCBjaGFyZ2VfbW0pOw0KPiArCWlmIChJU19FTkFCTEVEKENPTkZJR19DR1JPVVBf
TUlTQykpDQo+ICsJCXNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcyhtaXNjX2NnX3Jvb3QoKSwgY2hh
cmdlX21tKTsNCj4gKwllbHNlDQo+ICsJCXNneF9yZWNsYWltX3BhZ2VzKCZzZ3hfZ2xvYmFsX2xy
dSwgY2hhcmdlX21tKTsNCj4gIH0NCj4gIA0KPiAgLyoNCj4gQEAgLTQxNCw2ICs0MzksMTQgQEAg
c3RhdGljIHZvaWQgc2d4X3JlY2xhaW1fcGFnZXNfZ2xvYmFsKHN0cnVjdCBtbV9zdHJ1Y3QgKmNo
YXJnZV9tbSkNCj4gICAqLw0KPiAgdm9pZCBzZ3hfcmVjbGFpbV9kaXJlY3Qodm9pZCkNCj4gIHsN
Cj4gKwlzdHJ1Y3Qgc2d4X2Nncm91cCAqc2d4X2NnID0gc2d4X2dldF9jdXJyZW50X2NnKCk7DQo+
ICsNCj4gKwkvKiBNYWtlIHN1cmUgdGhlcmUgYXJlIHNvbWUgZnJlZSBwYWdlcyBhdCBjZ3JvdXAg
bGV2ZWwgKi8NCj4gKwlpZiAoc2d4X2NnICYmIHNneF9jZ3JvdXBfc2hvdWxkX3JlY2xhaW0oc2d4
X2NnKSkgew0KPiArCQlzZ3hfY2dyb3VwX3JlY2xhaW1fcGFnZXMobWlzY19mcm9tX3NneChzZ3hf
Y2cpLCBjdXJyZW50LT5tbSk7DQo+ICsJCXNneF9wdXRfY2coc2d4X2NnKTsNCj4gKwl9DQoNCkVt
cHR5IGxpbmUuDQoNCj4gKwkvKiBNYWtlIHN1cmUgdGhlcmUgYXJlIHNvbWUgZnJlZSBwYWdlcyBh
dCBnbG9iYWwgbGV2ZWwgKi8NCj4gIAlpZiAoc2d4X3Nob3VsZF9yZWNsYWltKFNHWF9OUl9MT1df
UEFHRVMpKQ0KDQpMb29raW5nIGF0IHRoZSBjb2RlLCB0byBtZSBzZ3hfc2hvdWxkX3JlY2xhaW0o
KSBpcyBhIGxpdHRsZSBiaXQgdmFndWUNCmJlY2F1c2UgZnJvbSB0aGUgbmFtZSB3ZSBkb24ndCBr
bm93IHdoZXRoZXIgaXQgaW50ZXJhbGx5IGNoZWNrcyB0aGUNCmN1cnJlbnQgY2dyb3VwIG9yIHRo
ZSBnbG9iYWwuIMKgDQoNCkl0J3MgYmV0dGVyIHRvIHJlbmFtZSB0byBzZ3hfc2hvdWxkX3JlY2xh
aW1fZ2xvYmFsKCkuDQoNCkRpdHRvIGZvciBzZ3hfY2FuX3JlY2xhaW0oKSAtPiBzZ3hfY2FuX3Jl
Y2xhaW1fZ2xvYmFsKCkuDQoNCkFuZCBJIHRoaW5rIHlvdSBjYW4gZG8gdGhlIHJlbmFtaW5nIGlu
IHRoZSBwcmV2aW91cyBwYXRjaCwgYmVjYXVzZSBpbiB0aGUNCmNoYW5nZWxvZyBvZiB5b3VyIHBy
ZXZpb3VzIHBhdGNoLCBpdCBzZWVtcyB5b3UgaGF2ZSBjYWxsZWQgb3V0IHRoZSB0d28NCmZ1bmN0
aW9ucyBhcmUgZm9yIGdsb2JhbCByZWNsYWltLg0KDQo+ICAJCXNneF9yZWNsYWltX3BhZ2VzX2ds
b2JhbChjdXJyZW50LT5tbSk7DQo+ICB9DQo+IEBAIC02MTYsNiArNjQ5LDEyIEBAIHN0cnVjdCBz
Z3hfZXBjX3BhZ2UgKnNneF9hbGxvY19lcGNfcGFnZSh2b2lkICpvd25lciwgZW51bSBzZ3hfcmVj
bGFpbSByZWNsYWltKQ0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4gIA0KPiArCQkvKg0KPiArCQkg
KiBBdCB0aGlzIHBvaW50LCB0aGUgdXNhZ2Ugd2l0aGluIHRoaXMgY2dyb3VwIGlzIHVuZGVyIGl0
cw0KPiArCQkgKiBsaW1pdCBidXQgdGhlcmUgaXMgbm8gcGh5c2ljYWwgcGFnZSBsZWZ0IGZvciBh
bGxvY2F0aW9uLg0KPiArCQkgKiBQZXJmb3JtIGEgZ2xvYmFsIHJlY2xhaW0gdG8gZ2V0IHNvbWUg
cGFnZXMgcmVsZWFzZWQgZnJvbSBhbnkNCj4gKwkJICogY2dyb3VwIHdpdGggcmVjbGFpbWFibGUg
cGFnZXMuDQo+ICsJCSAqLw0KPiAgCQlzZ3hfcmVjbGFpbV9wYWdlc19nbG9iYWwoY3VycmVudC0+
bW0pOw0KPiAgCQljb25kX3Jlc2NoZWQoKTsNCj4gIAl9DQoNCg==

