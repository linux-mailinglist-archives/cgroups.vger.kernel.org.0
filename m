Return-Path: <cgroups+bounces-1832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FD86734B
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 12:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3401285E50
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267320DE8;
	Mon, 26 Feb 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBYvbjMK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD12C69B;
	Mon, 26 Feb 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947369; cv=fail; b=jAMCFOIS4JWDMe8Az/h4s7RMFtboamFZMY09XSfqmFPcL9KDyStCEJCmZKFPaOREnJF3g71sjGkmxjW398KhONRm2upn9RKR61jtbnj7QVGRQ/n9RVerWuVb1I2iI9K0C7DDRL//IYWM7V9h9g/j7mazw5p/XaAxVcvZ+TgGb9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947369; c=relaxed/simple;
	bh=gBi6+A5wXGKZm2rZ2gXLhwFHGFtI3DNX+XheU/0wCnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMsCGyZ6GbUcaA9Af5is5SAHu7LjXaGv2+ENNmtsUgJ4U+sPzcLcwjPUvYDMnjRUy9dgrF3r0Af8biBAMjHypZl+8h6nnC7oMZ03voQ40uagUlpJAyUIjnog8rMRulGdxv5K09nOQY0tHm8aE3yyz8abVqcjrKYIVXGd+guX3Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBYvbjMK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708947367; x=1740483367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gBi6+A5wXGKZm2rZ2gXLhwFHGFtI3DNX+XheU/0wCnE=;
  b=RBYvbjMKqbqDO3EmvCWT/RrTDbgCQ0BetINCKRqy29IcN1EGiVYE9eBj
   zzVT5RyyK6ZTAN2bRMcb3ZWCBUNFlwEm02SCXorubck6A15XxS1hfVXpX
   9xpdJIBpXDY5aeLKraTWUge3SPs9XeS4tMP1Q80rIXpRbu9A71DjY9NUL
   aBNLTEguzsLGYAwaMD8HHcIS46l5/E0186I6eziN0vG40tD6pmNhnA/Lo
   nQZe9KVJWRmG/huppjVaiqQ7Z6DmxdYiOesGDJ9SVx2/dulNzJoZBa9qO
   mMVHWebNsLT+IduCrl/9gbYDY2fSUlGxiDIttN1HY8d4XDBLOGq84c+z0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3145219"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3145219"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7066238"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 03:36:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 03:36:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 03:36:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 03:36:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KViNziaPP0lGIvbyQj1lRiil2Qn7zEbDRSi/DwRi9P+4Heh6Zk8IuwGNfJjTjwqCcpwh8PammdtHtVJIf05mVBG8GGWE/BfHzzKx0w2tD9cuflrdLm/ePH+RDhhhM0DZmlWXjs5eGYlVrHJH9AXpRjWLsK77E8yyzXxfCe+0wSi2/wbHwl5F7FOhQT5wXy+05R+5kdmm6Vglm9pDukUY2YB+WYVJU7Ty1MPcUqF8/+q18+dl8HT5VJplUo0ZtztZVpWEtBedstI1CKtI0f10KhFKN3fV+PO6Zdt+y/uStbTVhxljdIerFnz/KJI2GiAdSXIoxbfaCAJe7IeV0OrhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBi6+A5wXGKZm2rZ2gXLhwFHGFtI3DNX+XheU/0wCnE=;
 b=bgr6oUus8gqejX0a9lQeKtHMrNMsv47RFBeM6Ds7RABNrm5hEze4IBPWp4V1tEgh2KTXvLx0MNERnTB3AGYRFrehA3A1A9RN2bkclFGXrz1NFzKc+TNiE3lzqRDh0bGjSNDI8N5ZxrsUmAjSML5rRsHKlAitYz9pYLennuvTynKln5tizAh0iHYuPTnood2MgD0/y2kNYmntLL0Rr8phV2YX7zg78X30/B8RVXWDWKaRfMPpz3lB4TT6DoIS6I1JeAT+aMKSrByWh2HYuWKtcCX9m1mzVZgK4eLg3PYq7eyV2ABcKxf+uzily9lSqb7MLKstQb7/ntnFNneLR05Geg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB7093.namprd11.prod.outlook.com (2603:10b6:510:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Mon, 26 Feb
 2024 11:36:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 11:36:02 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tj@kernel.org" <tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "mkoutny@suse.com" <mkoutny@suse.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
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
Thread-Index: AQHaWH7l75yVd20wEkCEiOebdvKVQLEUuuiAgAH4AACAAEeWgIAAGZYAgAC+JgCAAHBnAIADtV0AgAAoboCAAH6HAA==
Date: Mon, 26 Feb 2024 11:36:02 +0000
Message-ID: <48faaea8b24f032baa6a858a2909a5b4ace769c6.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-11-haitao.huang@linux.intel.com>
	 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
	 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
	 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
	 <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <7b53e155-2622-4acb-b7c9-d22e623e4cb3@intel.com>
	 <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2jqdjjd8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH8PR11MB7093:EE_
x-ms-office365-filtering-correlation-id: f3925baa-f7bb-4955-6816-08dc36bf1c4e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2m4OxXJXvXpSbnD4LCWMGsvdiXxRZ8u1K0mdD3TqB/3x3AFGYaOdQ6jG2VuTVmiTivsYitg1Uf3ElKDUqTvvt4sD6o75Unop6NKH1rKMNKkEWxiCbNdz+80zyotlYExVl3RIJjzkWQn4o+6AGoXkbAYCDVgWFLU+Ocia//eXSi0smB3CNxT79VacpPv2w6Z8n9OtUjhJz8GI+QClaCrutHj8kWiI7py7RPS3RNDYlzS2OCGlbwx7Ou0juwK0Z7kkpCufFhOUo84pfKj6uRtVkEg8fXhH+i3I63wdZ475CNZhGdY7RqNY1qZxy7KxBpzADCm231QdSbZgosvECWvo2WoQ6sDfczCdX1rJicBlsQnQ0JlUl3A+qo3PQzj6bF9kvyy4J9Tso2532erWklPDjpGmbMkr4an/AswZUVsmZGhkuXpk8KyzPMBpzgvDFG/LixKGO9DxyGGfSiwYBakpFiXvTZK9cZ+XAhzHgxDhg13Q/XeQsKef8YnP8Zlud4mwcEgNEC86KHuwrdSHJH7Njns62OvTNGKlhRSbU/gtEdNCo/9jM2LQ3/GRWzIeclGlqPfabNtSURlO/ZvCHHrf9Q1dK1TD20tIA73xDMAo13V8RhasPMy74RJ/fUHydXvGrQvkpPOZHCRMsKy43qALRCZn5sdou/I0vZABQBfwdMu7Y3pc5qu8heAGNW6ips7de/zO+I7p7fyIWi/rGKroZPv3K/PQ+NBVKjPS5+FDQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU1SRzhFUm5leWxZSUdlN1NwdjJtVVJrMW4yT0YwQzVBZ2pSMXB5Sk1JL0Jm?=
 =?utf-8?B?MTJZQmNGNmQ3Qy9Pdit0L1Y5UkJvcjlMeXg0N2RQZ2NFbURIbnBQT3ZLTThx?=
 =?utf-8?B?T0JJT0E2NVFZWS93OTlXTU9LaGNSSVZtaS9SU1B6eG5KenNDUzl4ZVptYkha?=
 =?utf-8?B?UEw4SVZLZFVNVjdYNnhwVVZPeHd6Yncwc2l2Yy9IaytCR0JyMER6aS8vb1pX?=
 =?utf-8?B?RTNZcEtIR3h5WDIxRHVyWlVRaE95cEtLNERCSHdmSkdRb016cURQRUNnWkhl?=
 =?utf-8?B?TUNud3hoNHFmN1V5WHVESmEzcEEvRTQwZnA4N2phajhGVFBpRFZhTWdYSzhy?=
 =?utf-8?B?aDAwSW9IdFpDTXlFcFhJck1WVjVrc214bnkzSU1wZ2FJSXZ2MkFZSlhENHVi?=
 =?utf-8?B?dk4wV1JlQmZrMHhxMEpFOEFFNkF2RWl6Z01BMklUR2w2R0M0ZS9wUzJSQmJE?=
 =?utf-8?B?d3VmWkdVZDJMRDQ0MzVUYmVrZHBPQXRJWWREQkpWdENnTlp1NlNrM2w4aDNa?=
 =?utf-8?B?M1hBc1R2UTRiQnVhNFRPK1V6clpoem5VeVFpaEtaSDc1RTAveVRuZ0p1S1Uw?=
 =?utf-8?B?OFVlZEYzZ1cwS2dzWmxTb1hVVU1WdVZoQjVsSXhrNzlWRlpzR3B4M21mK3ht?=
 =?utf-8?B?Qk5vLzZVSHJJOGxES3E0M0ovTFFKU095OHFIWEVGM1dWWUpNa1JEeXRmeFAv?=
 =?utf-8?B?c3AvUDg5KzNCZ0RVR3VHU1UrbVhDMWRIYUhmbklYRW1XbFI2MENuczMvajRs?=
 =?utf-8?B?eDVscm4rTzFjdDE2RXhwWlBqeHdTOTI2NjhlcG4renQ1N1ZwM2cyS1RHQnFn?=
 =?utf-8?B?NmxYSkgxeW1mV3FQZlVqNkZuU1NvT1FWbmdrR1VtZ0ozck9JV0J6V3EzaHp0?=
 =?utf-8?B?UmZEd3FFbHBCSWNrMjAxd0tsUm1Dd2tuek1CdndSRmhuLythcmZLY0V0NWlj?=
 =?utf-8?B?eFNUMXFtN1gwMzhOV1NnSnJvM0JrR284YmRla2RPWlRwanVCVVYwUmg5b2cx?=
 =?utf-8?B?ZWNvNWI5TjgrTUVudm5QR2V2Qm90R3hXOVQ3VXMrbzRGcG5jeGtmZWN3b01O?=
 =?utf-8?B?Y2pYK0QzODVBdXVWbDFtc0FGTThLMjF0QzM0WXlrSHJjN1dpMTROVTh5dFJC?=
 =?utf-8?B?NjlyWW02MGcrb2VHOTZTTXp3ZzJhZlhKVlpLY1hHNkNqWGdtVG9FdjBvMVJF?=
 =?utf-8?B?bWxMd3ZGVkhDVy90blJURU04Zis4MjlCa2JKbVUzcWVaSTVPUGZoM3JPK1Fv?=
 =?utf-8?B?Wm15SzlkNnF2NFNaRU82L3d2d0FldHcxUmJwWEJxMWZRUTl2b3pteGhBMWd3?=
 =?utf-8?B?eGsrNWFyTXdpcEdlTnRKNWRYK0huNWdTcldQVllabVB1SnZxOC9VOXhFalh6?=
 =?utf-8?B?YWdETHVqeUtrdnRsVmtJbGZsZzJrOWY5TGp0N2c2TWVoSmdZL2RPZC90ZFBB?=
 =?utf-8?B?S1hFVkxUM0NrMjZqMkYySHFaUlFHa3ZFeFM2U1NIM05sektqU2YzS1ZPNEo1?=
 =?utf-8?B?NXJhTFp5VHVKdzhvREY4R0l1NFZGRmhOQk9zQWxudUhESGliaENvR2t1dVVq?=
 =?utf-8?B?WS9GSU56VG9jcWpYdC8vQUJnZXcyMjU2WHVqVjZzR3hXQm42MFRtTE04alhX?=
 =?utf-8?B?Uk1NMEhUQmFuWkNrRHNjWGVVbERFbUh3Q1BkWFl3T1RvTmtTc2JBQkJjYm1J?=
 =?utf-8?B?WnNhTlp6ZUhBVWZWbVI2WTA5Zk9HYWlreUgvSDVYa0FKVGV6OGN1MWxxZ01Z?=
 =?utf-8?B?WVVMZSt2T0d5ekZVQjF2cEVvM2U1Wi8rT29LQTg3TXFJLzM1Y3QrRzNaQkdY?=
 =?utf-8?B?K3kydGNKTFJxQk84YWZhc252S0JyK01KNWV2MElCTzkwcmFFQkhhd3pYNHk1?=
 =?utf-8?B?OWR3dHgwY2RhMEsvMUl6ck8xRzZhOFZrbGhlRWI2UnAzKzdVMkJYTjM5Tncr?=
 =?utf-8?B?WTJJUEx2TXZteTFEWWFzRlJNZE41aGVETGFoYnhjT3U0aUd6cTVaZGtXRWI4?=
 =?utf-8?B?QWJlTTg4SXE4a2ZKb1VWaFE3YUUzbWFOaTkrNUlRQmR1UG92YUJNcDIvT3Jm?=
 =?utf-8?B?a3VWRHh6dksyR1hob2hIY2Q4Wm1EVEZ5WnJXaXlNc2JTcmZtNStLZDBuVHFu?=
 =?utf-8?Q?aaYadfv1scnszxs5VgoYy05of?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <872BAB8C00903842A882794FD289814E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3925baa-f7bb-4955-6816-08dc36bf1c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 11:36:02.0847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJvPpjZrhtW8PdlgOOcr9gZ4vNh2iQVcSFrNjRVfv+EWzcVBUa8wiU4FdLW6jdq6nhZTiw775YJnNl3cKjRKjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7093
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI0LTAyLTI1IGF0IDIyOjAzIC0wNjAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFN1biwgMjUgRmViIDIwMjQgMTk6Mzg6MjYgLTA2MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiANCj4gPiBPbiAyNC8wMi8yMDI0IDY6
MDAgYW0sIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IE9uIEZyaSwgMjMgRmViIDIwMjQgMDQ6
MTg6MTggLTA2MDAsIEh1YW5nLCBLYWkgPGthaS5odWFuZ0BpbnRlbC5jb20+ICANCj4gPiA+IHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiBSaWdodC4gV2hlbiBjb2RlIHJl
YWNoZXMgdG8gaGVyZSwgd2UgYWxyZWFkeSBwYXNzZWQgcmVjbGFpbSBwZXIgIA0KPiA+ID4gPiA+
IGNncm91cC4NCj4gPiA+ID4gDQo+ID4gPiA+IFllcyBpZiB0cnlfY2hhcmdlKCkgZmFpbGVkIHdl
IG11c3QgZG8gcHJlLWNncm91cCByZWNsYWltLg0KPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgY2dy
b3VwIG1heSBub3QgYXQgb3IgcmVhY2ggbGltaXQgYnV0IHN5c3RlbSBoYXMgcnVuIG91dCBvZiAg
DQo+ID4gPiA+ID4gcGh5c2ljYWwNCj4gPiA+ID4gPiBFUEMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiBCdXQgYWZ0ZXIgdHJ5X2NoYXJnZSgpIHdlIGNhbiBzdGlsbCBjaG9vc2UgdG8g
cmVjbGFpbSBmcm9tIHRoZSBjdXJyZW50ICANCj4gPiA+ID4gZ3JvdXAsDQo+ID4gPiA+IGJ1dCBu
b3QgbmVjZXNzYXJpbHkgaGF2ZSB0byBiZSBnbG9iYWwsIHJpZ2h0PyAgSSBhbSBub3Qgc3VyZSB3
aGV0aGVyIEkgIA0KPiA+ID4gPiBhbQ0KPiA+ID4gPiBtaXNzaW5nIHNvbWV0aGluZywgYnV0IGNv
dWxkIHlvdSBlbGFib3JhdGUgd2h5IHdlIHNob3VsZCBjaG9vc2UgdG8gIA0KPiA+ID4gPiByZWNs
YWltIGZyb20NCj4gPiA+ID4gdGhlIGdsb2JhbD8NCj4gPiA+ID4gDQo+ID4gPiAgT25jZSB0cnlf
Y2hhcmdlIGlzIGRvbmUgYW5kIHJldHVybnMgemVybyB0aGF0IG1lYW5zIHRoZSBjZ3JvdXAgdXNh
Z2UgIA0KPiA+ID4gaXMgY2hhcmdlZCBhbmQgaXQncyBub3Qgb3ZlciB1c2FnZSBsaW1pdC4gU28g
eW91IHJlYWxseSBjYW4ndCByZWNsYWltICANCj4gPiA+IGZyb20gdGhhdCBjZ3JvdXAgaWYgYWxs
b2NhdGlvbiBmYWlsZWQuIFRoZSBvbmx5ICB0aGluZyB5b3UgY2FuIGRvIGlzIHRvICANCj4gPiA+
IHJlY2xhaW0gZ2xvYmFsbHkuDQo+ID4gDQo+ID4gU29ycnkgSSBzdGlsbCBjYW5ub3QgZXN0YWJs
aXNoIHRoZSBsb2dpYyBoZXJlLg0KPiA+IA0KPiA+IExldCdzIHNheSB0aGUgc3VtIG9mIGFsbCBj
Z3JvdXBzIGFyZSBncmVhdGVyIHRoYW4gdGhlIHBoeXNpY2FsIEVQQywgYW5kICANCj4gPiBlbGNs
YXZlKHMpIGluIGVhY2ggY2dyb3VwIGNvdWxkIHBvdGVudGlhbGx5IGZhdWx0IHcvbyByZWFjaGlu
ZyBjZ3JvdXAncyAgDQo+ID4gbGltaXQuDQo+ID4gDQo+ID4gSW4gdGhpcyBjYXNlLCB3aGVuIGVu
Y2xhdmUocykgaW4gb25lIGNncm91cCBmYXVsdHMsIHdoeSB3ZSBjYW5ub3QgIA0KPiA+IHJlY2xh
aW0gZnJvbSB0aGUgY3VycmVudCBjZ3JvdXAsIGJ1dCBoYXZlIHRvIHJlY2xhaW0gZnJvbSBnbG9i
YWw/DQo+ID4gDQo+ID4gSXMgdGhlcmUgYW55IHJlYWwgZG93bnNpZGUgb2YgdGhlIGZvcm1lciwg
b3IgeW91IGp1c3Qgd2FudCB0byBmb2xsb3cgdGhlICANCj4gPiByZWNsYWltIGxvZ2ljIHcvbyBj
Z3JvdXAgYXQgYWxsPw0KPiA+IA0KPiA+IElJVUMsIHRoZXJlJ3MgYXQgbGVhc3Qgb25lIGFkdmFu
dGFnZSBvZiByZWNsYWltIGZyb20gdGhlIGN1cnJlbnQgZ3JvdXAsICANCj4gPiB0aGF0IGZhdWx0
cyBvZiBlbmNsYXZlKHMpIGluIG9uZSBncm91cCB3b24ndCBpbXBhY3Qgb3RoZXIgZW5jbGF2ZXMg
aW4gIA0KPiA+IG90aGVyIGNncm91cHMuICBFLmcuLCBpbiB0aGlzIHdheSBvdGhlciBlbmNsYXZl
cyBpbiBvdGhlciBncm91cHMgbWF5ICANCj4gPiBuZXZlciBuZWVkIHRvIHRyaWdnZXIgZmF1bHRz
Lg0KPiA+IA0KPiA+IE9yIHBlcmhhcHMgSSBhbSBtaXNzaW5nIGFueXRoaW5nPw0KPiA+IA0KPiBU
aGUgdXNlIGNhc2UgaGVyZSBpcyB0aGF0IHVzZXIga25vd3MgaXQncyBPSyBmb3IgZ3JvdXAgQSB0
byBib3Jyb3cgc29tZSAgDQo+IHBhZ2VzIGZyb20gZ3JvdXAgQiBmb3Igc29tZSB0aW1lIHdpdGhv
dXQgaW1wYWN0IG11Y2ggcGVyZm9ybWFuY2UsIHZpY2UgIA0KPiB2ZXJzYS4gVGhhdCdzIHdoeSB0
aGUgdXNlciBpcyBvdmVyY29taXR0aW5nIHNvIHN5c3RlbSBjYW4gcnVuIG1vcmUgIA0KPiBlbmNs
YXZlL2dyb3Vwcy4gT3RoZXJ3aXNlLCBpZiBzaGUgaXMgY29uY2VybmVkIGFib3V0IGltcGFjdCBv
ZiBBIG9uIEIsIHNoZSAgDQo+IGNvdWxkIGxvd2VyIGxpbWl0IGZvciBBIHNvIGl0IG5ldmVyIGlu
dGVyZmVyZSBvciBpbnRlcmZlcmUgbGVzcyB3aXRoIEIgIA0KPiAoYXNzdW1lIHRoZSBsb3dlciBs
aW1pdCBpcyBzdGlsbCBoaWdoIGVub3VnaCB0byBydW4gYWxsIGVuY2xhdmVzIGluIEEpLCAgDQo+
IGFuZCBzYWNyaWZpY2Ugc29tZSBvZiBBJ3MgcGVyZm9ybWFuY2UuIE9yIGlmIHNoZSBkb2VzIG5v
dCB3YW50IGFueSAgDQo+IGludGVyZmVyZW5jZSBiZXR3ZWVuIGdyb3VwcywganVzdCBkb24ndCBv
dmVyLWNvbWl0LiBTbyB3ZSBkb24ndCByZWFsbHkgIA0KPiBsb3NlIGFueXRoaW5nIGhlcmUuDQoN
CkJ1dCBpZiB3ZSByZWNsYWltIGZyb20gdGhlIHNhbWUgZ3JvdXAsIHNlZW1zIHdlIGNvdWxkIGVu
YWJsZSBhIHVzZXIgY2FzZSB0aGF0DQphbGxvd3MgdGhlIGFkbWluIHRvIGVuc3VyZSBjZXJ0YWlu
IGdyb3VwIHdvbid0IGJlIGltcGFjdGVkIGF0IGFsbCwgd2hpbGUNCmFsbG93aW5nIG90aGVyIGdy
b3VwcyB0byBvdmVyLWNvbW1pdD8NCg0KRS5nLiwgbGV0J3Mgc2F5IHdlIGhhdmUgMTAwTSBwaHlz
aWNhbCBFUEMuICBBbmQgbGV0J3Mgc2F5IHRoZSBhZG1pbiB3YW50cyB0byBydW4NCnNvbWUgcGVy
Zm9ybWFuY2UtY3JpdGljYWwgZW5jbGF2ZShzKSB3aGljaCBjb3N0cyA1ME0gRVBDIHcvbyBiZWlu
ZyBpbXBhY3RlZC4gDQpUaGUgYWRtaW4gYWxzbyB3YW50cyB0byBydW4gb3RoZXIgZW5jbGF2ZXMg
d2hpY2ggY291bGQgY29zdCAxMDBNIEVQQyBpbiB0b3RhbA0KYnV0IEVQQyBzd2FwcGluZyBhbW9u
ZyB0aGVtIGlzIGFjY2VwdGFibGUuDQoNCklmIHdlIGNob29zZSB0byByZWNsYWltIGZyb20gdGhl
IGN1cnJlbnQgRVBDIGNncm91cCwgdGhlbiBzZWVtcyB0byB0aGF0IHRoZQ0KYWRtaW4gY2FuIGFj
aGlldmUgdGhlIGFib3ZlIGJ5IHNldHRpbmcgdXAgMiBncm91cHMgd2l0aCBncm91cDEgaGF2aW5n
IDUwTSBsaW1pdA0KYW5kIGdyb3VwMiBoYXZpbmcgMTAwTSBsaW1pdCwgYW5kIHRoZW4gcnVuIHBl
cmZvcm1hbmNlLWNyaXRpY2FsIGVuY2xhdmUocykgaW4NCmdyb3VwMSBhbmQgb3RoZXJzIGluIGdy
b3VwMj8gIE9yIGFtIEkgbWlzc2luZyBhbnl0aGluZz8NCg0KSWYgd2UgY2hvb3NlIHRvIGRvIGds
b2JhbCByZWNsYWltLCB0aGVuIHdlIGNhbm5vdCBhY2hpZXZlIHRoYXQuDQoNCj4gDQo+IEluIGNh
c2Ugb2Ygb3ZlcmNvbWl0dGluZywgZXZlbiBpZiB3ZSBhbHdheXMgcmVjbGFpbSBmcm9tIHRoZSBz
YW1lIGNncm91cCAgDQo+IGZvciBlYWNoIGZhdWx0LCBvbmUgZ3JvdXAgbWF5IHN0aWxsIGludGVy
ZmVyZSB0aGUgb3RoZXI6IGUuZy4sIGNvbnNpZGVyIGFuICANCj4gZXh0cmVtZSBjYXNlIGluIHRo
YXQgZ3JvdXAgQSB1c2VkIHVwIGFsbW9zdCBhbGwgRVBDIGF0IHRoZSB0aW1lIGdyb3VwIEIgIA0K
PiBoYXMgYSBmYXVsdCwgQiBoYXMgdG8gZmFpbCBhbGxvY2F0aW9uIGFuZCBraWxsIGVuY2xhdmVz
Lg0KDQpJZiB0aGUgYWRtaW4gYWxsb3dzIGdyb3VwIEEgdG8gdXNlIGFsbW9zdCBhbGwgRVBDLCB0
byBtZSBpdCdzIGZhaXIgdG8gc2F5IGhlL3NoZQ0KZG9lc24ndCB3YW50IHRvIHJ1biBhbnl0aGlu
ZyBpbnNpZGUgQiBhdCBhbGwgYW5kIGl0IGlzIGFjY2VwdGFibGUgZW5jbGF2ZXMgaW4gQg0KdG8g
YmUga2lsbGVkLg0KDQoNCg==

