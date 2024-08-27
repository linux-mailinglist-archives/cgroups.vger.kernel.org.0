Return-Path: <cgroups+bounces-4507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A8960841
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A321F236BC
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED8819E802;
	Tue, 27 Aug 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2hStUEi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B3155CBD;
	Tue, 27 Aug 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757234; cv=fail; b=PZFSVuf4iDtzWF9qlD6gqOWgBYj+wEMbHBZ3EYQjF8i6g5drhozc531r64XHBpScZGjpF+8l+vw2LSof206rJatXSmYRe/TBWXardhExGORO7uJw6GhEXFixiJ8tF0dMDTvYIuECj0IoBRQNkXsokRhR71gLun9JKzwL4gEyOYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757234; c=relaxed/simple;
	bh=Q5ttg/hbDpb61y/fPMPoDyntq9F6GqSGk2abD8UUPCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NlCV4P2EaidwfP8y/nzDWKGSiUU9mc5Uxpqh58uHbCTUgNg2BhyvgUoPQ8OHvR502ZhbEnQfQOGj8rgv5GNRoz5SXg/AnQcwHgWBdNcCvQa/ORvEnpc8qBaQspLp1kgjy6EE9Z+mMYD3DMORJKADBzCZk7CXpk1khPKxsbRB6S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2hStUEi; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724757232; x=1756293232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q5ttg/hbDpb61y/fPMPoDyntq9F6GqSGk2abD8UUPCw=;
  b=E2hStUEiwudd0ooyYJoBAsV1WcPLM8oUlbPBVawSPT5tI3O1//om0T1e
   iwXnZ3B6CYRJRCrcdifPIWv63h3E9O46mhQmrznKDqD8SC2NVtO/ZlYU1
   nb2smRnJFHuheKzevBgwYnG5tnwBr4wTwE9RrBKreHQavNF2yL53pwVbb
   namSh2sZG4wwq0qIqmpKuja2VAvHg1PQaFepGG42s1uMq0Ov57FmIvViU
   DWIk4HeXMygADOnQjXJQQXoriee4mUIPgnKEVYqW1bEykbTBZgj5KUREv
   Va/rCG8r9ax4FHj04w0Ntz3X/2Ct7nMqk/OqNRfDtaMkWEMGMKqoP0yoQ
   Q==;
X-CSE-ConnectionGUID: ZnApBIufRX2Fi3QdkQoDtA==
X-CSE-MsgGUID: Nk7pErAnSH+hWJSvr1OZ1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23406470"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23406470"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:13:51 -0700
X-CSE-ConnectionGUID: rqPA0m8WTjOvnDJbWtAZog==
X-CSE-MsgGUID: JStut+wnTQaZXDLLp0x4IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67658881"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 04:13:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:13:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 04:13:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 04:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFwLb6W1fqEUSfUbESimibVT26qPA1UT2EChap2OnrPUFQiPMVNr7Wtl3W4bhp67oBin0d0+VUwvPIhC03PlVHoBhiuyfPOOQFNoApAevjhcgYou7EEkHgjzd7ZiNK+SgtQiaw4+anGQcn08eQPwIUR107/vP5YjdfM0MGvtCkjJaPS45CgX07fiYccKKQjhRT0d/ZlTAABT31w0Orgv830uEpFWibNiIltnZMD1pRy/dyz9oFXLUwndC80EfzbwBp8TlvrHK0NYUMHB7II7SCRXxyHfa6kHhoYhBzm7VcG4KqMjznot0gsMbGl5QF/F5he1jXUtNQTVnuI8WYLYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5ttg/hbDpb61y/fPMPoDyntq9F6GqSGk2abD8UUPCw=;
 b=RILef3V1aYLZnuBQM3nDuhmnXs25u0MDHcXun7jy6owwVjGBN8R2UpeQ3mSc3P423LdvwMU4e4zABWF62w2HWF/8wpUQ7LYTIvU7ggk3mA+XkEGuM7I5PXlCjAxIbvx48OZMN9irAl2Y/zEFG+jqHJVk+oJ3RUJwnDcvUZaMbG6ETbK2HVFA32GheSuBPDetF7NAnd8kkVwfgx/ZvfSXBfrLs7YrgJeXDro4BQUDNMSrcVZf+t81YShkToOnPKdo/k9+Ixr3BHa9we+mVIQ6cg2Lk++WEFD4DdueFVGBMWDa0QDzgGctoSkRfPFl2rfE9QE0OveLxU4o8YIhNkj/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 11:13:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:13:41 +0000
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
Subject: Re: [PATCH v16 08/16] x86/sgx: Encapsulate uses of the global LRU
Thread-Topic: [PATCH v16 08/16] x86/sgx: Encapsulate uses of the global LRU
Thread-Index: AQHa820aknvFBU6Njkq9GFBKIp9Q+rI6/XuA
Date: Tue, 27 Aug 2024 11:13:41 +0000
Message-ID: <b91e6636ab7b6b96a723c9ea78ad5119ea1502c9.camel@intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
	 <20240821015404.6038-9-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-9-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8137:EE_
x-ms-office365-filtering-correlation-id: 9e7e6882-1742-42af-db4a-08dcc6894ec6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U0d2WDV1THVBRXg5NWNaY2RrNjRrR0hCQmVZdkRUdUZZWWxDc0pWR1JzRlBG?=
 =?utf-8?B?REl4MUxWOXJxbGJPWnUwamJ2d2wrR24vb09qM0dxV0tZTUtTUURaYVVqbjBy?=
 =?utf-8?B?b1YycXlEajBSb3BPR0JCK25UNDZkQUN5RUpPRDFBLzFFdXZNLzRvSWo3Nmt1?=
 =?utf-8?B?c1JDaE4rV09CWDR4SnpOZ1VZdVRlQUFnRjZUR2d3dVhTcXJ4ZStYL0Y4YkJR?=
 =?utf-8?B?dGZJV2FHZmVUS0lFdXUvZ3VaNy9yWFhZSXNrSU1kaVdtUC9HZFdnUGRmVlZ5?=
 =?utf-8?B?a1d1a05Pa3Y0QTFlK05Sd1J5YzYzOHpsV21Ga0h3MzZmdjBUVG5jc3FHY3VS?=
 =?utf-8?B?R28vUnNOQWNHTWppM0kwR2JaTU53aUNqVlVqaTJaR3NSTXRaVitwTWlRRi9G?=
 =?utf-8?B?NEhwRDBlYmZTVVB1MG8zbEtwRXRYNk1iR1JHa2pwZS81cEdySnQxRjVoSGVQ?=
 =?utf-8?B?V1hhUmVrdnlXQ09JaXc5am9sYm5wbjMzcFhPaHRYS3FyZDM2VWlDN1RzMXpz?=
 =?utf-8?B?cmZJQXlCU2UyR0FtNkI4N3U1K2ZEQnJyNlV6NnorNUpJU2hnNStnME1KNGJ4?=
 =?utf-8?B?SGtCcUlnVE10RXl5UzY5MmtNOFJ0M3dRQ3hyK0FpcmhENUVmVHgvN2N1WHd4?=
 =?utf-8?B?K3pDODJmT000bG5uZU9KUTZyVTdkU0pyZ0MyYTlob1hkVEtYT3hQN0t2K3py?=
 =?utf-8?B?cTJEVG5xdWhDRDdwQUZCZkpHWStVQnRPelVwQlNFSGNlaEJrdlg3bnpvR2FZ?=
 =?utf-8?B?SXFSTXJsTk9TK1MyaFZzRGV3Q1ZyblBIRDdvcXBSMWpRZ25uT2JLRjh6ZGxR?=
 =?utf-8?B?QmdpYnBnVHgrU2ZzN2FXRGYwYmVReHFJb2xVVVBoSzZqbVBGd0Z1U0YvT00w?=
 =?utf-8?B?Z0t0WjluYXRmZmJmR2RJMk52SFNDU2M1NGxVZkMvTVcrdmtpeTVZNlVIQkxT?=
 =?utf-8?B?SzBXU1djL1MwRDVhSWgwbmtaTVlZQllyQ3FDMS9mS2puS3ZvVzYxZWw2WlNx?=
 =?utf-8?B?c2c0N3NlbmltWG0wUWFwcTRlaCtpMnpoSGR4M0tWRkg4Ni9NcnNMRjRUOXF2?=
 =?utf-8?B?aDcrWUJjU1VLWURESFVxUExTRWF2dDNod01sU2puYzNzTEJ2NjRBRFFjU1Iz?=
 =?utf-8?B?QTVpTFdteXkrMHhmdFdtOElFQ2ZKZDhzSWNjMFBpaHBxUGQySmV4UVJKd0x0?=
 =?utf-8?B?QmticUZKbzZ6RXJUelFzT2x5c245OFFIekFOamdGV29XcFkzOTQ1ZmZmL3pQ?=
 =?utf-8?B?aGg4S0x6aTNpR3UwdGJsbHJlK2VoQUVGSjNhMldLeWJiV1lESk1Ldi9SQW1p?=
 =?utf-8?B?UU90cE84TUVRMWo2K2hxcXI1MlVIcVFVK3F6dFBIZDcvL0VDM3Q3akc0bnR3?=
 =?utf-8?B?eEcyVTlqdXF1YVdHK1ArRTVjdTlaTTdXTUZVVUhwdmdLK1ZmbWJmME43VWRh?=
 =?utf-8?B?MzdQamFyajlOck1PWjFSb1pIeVFiYXVReEZodjBJRTZFbzdLKzQ4SmI4UW1y?=
 =?utf-8?B?bnFhQ1dMYk5XWGRHSHNtQzkrREtKMDdGZ1BnamdZcTMraXpKSWtIVkRuWFBE?=
 =?utf-8?B?K2lKaW9lQUU3SnROMUtTblpFTUNHR2pPWHM2dkY5VkF3aVI2eXBDZklydUU3?=
 =?utf-8?B?a2MyVDdySjRyTUZ4WXNyazlvSGpidWoxOG1lQ3RmTSt6Q0t2OXp4Z1ZHK1d2?=
 =?utf-8?B?cVYvNWJrQUswdFdkd3Y2TnBzQk1VY3ZVczhjeGdBNW9IWmF4Tkp3dXhuMkph?=
 =?utf-8?B?OFRPZ2h6NWhOZTk4K0xtNVI1VkhZajV0SE8xWVJOT05SSFc3MU14MGk2eGpS?=
 =?utf-8?B?MCtRdi9lM0JWcUpoaTV2cmRXMHhrR1F6Rmc2a2tVekV0a05sVUtBTFZlZm9Y?=
 =?utf-8?B?OFVQZGQ3RDdxR0dsOEQ0Mys1RHdITGphVjNwWGYrSm9SWnhsL082RXgzUnJj?=
 =?utf-8?Q?yK84lZTrngU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUdCZjkwR3k2ZU9hWXluRzUrQ1V3d09UZGxhcm4rMWxINFE0L1RvbGdNTnAy?=
 =?utf-8?B?QlpSL000SklaNkRkb3hVbVJOWlBieGlKRGJlRGpaWGQvWjFiUXAwYUhjZW9z?=
 =?utf-8?B?bHJoK2t3S0laMXdvcWd3YU9GcVp2SlBvcmt6Zzl4Z1dDK2ttaEZUUytyNTBn?=
 =?utf-8?B?MCsxRVBNYVYzOUQvL0ZrWlBERkkwQ2Q4cU93WVJzUWxjb0RsN1lhQk5NcTYw?=
 =?utf-8?B?Q2JJS21jenhCRlZ1TCs3WFFjSmNjT3grZG1Wc3Q2c1lCWW0ycUNkNStMakpW?=
 =?utf-8?B?aG5sYVFXcGQ1b1RPTHdIZ2Y4cDlVZ09RNnNwOHNvb1N2V2crSk9LRkRiajZJ?=
 =?utf-8?B?OHlGVjZ4YWpvQVdLT1lFcUh2V0tBSlhsV3M4d1JIVlp0OE1sWEFJejk3SGNZ?=
 =?utf-8?B?NVAwYzZ2Nm1lcm5PTG5VZmMwSFhTN3RRaGdjZXA3Z0hpWXNrS005VVJGZkpp?=
 =?utf-8?B?dVVpNmhnUmxIbDV6T0ZDWFFDTDlDdDlaN3hpU2hyeFhFMmNBT0pXSWQxR24z?=
 =?utf-8?B?RmVtRkJKZngxSjMveTc2cTNVbEZvNFhVb2JNb3VRR3RhdGc3ekJPaVR2WlE3?=
 =?utf-8?B?OURETnIvQ0szcVgvQUJnRlVWTEgvc1hjVWNuZ3lnZ0wydGQ2OXBXZXdLdGs1?=
 =?utf-8?B?bUh2L1pzYmRYM2lTM3AzZHN3ODFHOWhaY1pyZHUvR3NHQ05RcUFVbTI5Nm1Q?=
 =?utf-8?B?eXJYTUFLbm9NZGJPSm1LbURNRVZKYS9ZbEtiSVdleklxR21BeWN5dVZsZ0F3?=
 =?utf-8?B?a1BoNnhYTDhVQW40aWRLMHdiR2NxYkVDRjJqSzByaEtKeGNpNXJJdXBtaUVx?=
 =?utf-8?B?ZXMxMVZwWmsvZlNnbHhnZjVDZUFBc1VBd1RyTGtpUkhwMVAvMTlSd2U0aEl5?=
 =?utf-8?B?blkvL0Y3c1BMQ3ByRmdZendTS3J2Zm1ybWFqQTJ4UWN5ZTV1UjZwNHZCaUZP?=
 =?utf-8?B?NTAyeElRZDJZRlk1SHpUL25FQnY5MWZyTjF0TGQrSFZnTnd4WEVlK3dFZmIv?=
 =?utf-8?B?NTdhUTIyR29mVGM0Wjh1Wk45RjBoUmZ2NzRFV3p2MmNUaGFpSnAzS0w1RFZi?=
 =?utf-8?B?MlNQZk9HNmw4cUhiUkNMaXphcS9tZGNWNG9HVm9QYUhvUm96T2hYOERwOEI2?=
 =?utf-8?B?Q3FaeWFhUVpMZVFieHN1M1o4TDFQRWlCdWh1SnViWWpFOUZ0OXV4K2ZZME1G?=
 =?utf-8?B?OG5tMmZSaTBFR3NMWG1KQXVObU9lcFozWDVyaEF6SDJEeWRQTVk0STVzUXFr?=
 =?utf-8?B?d2k3bnpzZkh4QTIwZUsrZDZ4V3NyOEtlcURraktJRHZCSTd6R3dHQU9vMUhT?=
 =?utf-8?B?czVpODdXQ0xLcXRVOWw0dVVNMW1mZEdMR1Y3dFpGRGs0RDlNN3VSOVdteUph?=
 =?utf-8?B?MWtoTkNiSFlQMEdyR3F0SGRReE1RelE1T2d1MmhpNVJFT0dxRHFJNUlDZkJN?=
 =?utf-8?B?QTVZUjBiK1FCTFJIWnBXUUloWmFUV1FPYS9TY1lkSGFnWllFMzBpMGFUZHRs?=
 =?utf-8?B?Y2lhMXNNbjVaaHpyQkszenlnNSsvUE1WWitoUm1xS2ZvV1lXN0xabnloOU9R?=
 =?utf-8?B?Z0MvMmpaVitjNWx3T3FTRytXZ04rVW1jajZ0ZDZmdW5RMlczeDRVQ3dCMnFW?=
 =?utf-8?B?cHdQa2JVOHJWNExMTmxpeno5S2luNmp4MmFLdmhicFJ2dFczTWVnaHE2QUFn?=
 =?utf-8?B?REhNNmMzdjQ2VFpRN1RBaHQxemgvcEVGUm5xRmNuUjM2aDBzZUJjWlJLUkVo?=
 =?utf-8?B?YmNjRHh4WUZBeXg4TVRxV1NFRmNjd25UT0l4cUZvaTNzWmo1U0h0VVZTODho?=
 =?utf-8?B?L0pZRTBoMnUxT1cvcmFtdjQzR2pMVWhoeERWY21GYlljRFhjcGU2TEUwYzNB?=
 =?utf-8?B?Sml1NDZyYVlhYjllTU1pWElEc3BaZmhZclpzU2pCaVRKV2QwSlF1L21EWEth?=
 =?utf-8?B?cEM2dTdVVENFQUNNUzlPTWtVVU1rQVpDOUxTczBDSDV1MHplTVd4dVNXR2I1?=
 =?utf-8?B?TEhuNVZ3d0FBZkhIQU5TVGxBdWJvK2QwWjduRm83TXR3bzdlTmRRRTcyNC85?=
 =?utf-8?B?d3V1bTNBallYbi82ZmlRSTF3SVhlTTJScjFQeGp3enlwQUhoNWhpUDZncGJH?=
 =?utf-8?Q?7hiatGmR8KaGrG0fdxHyQTLWD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C753CD064D5F46B3C90955B553D9B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7e6882-1742-42af-db4a-08dcc6894ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 11:13:41.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7B4uTztbpq83tNE5jdPpR/TWtFc0qhSkJ4RzWQXEnheRII+ZOpQgXL3cgnvFpnq3oncyvWbsoiQLzqRFQIDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-OriginatorOrg: intel.com

DQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgc2d4X2Nhbl9yZWNsYWltX2dsb2JhbCh2b2lkKQ0KPiAr
ew0KPiArCS8qDQo+ICsJICogTm93IGFsbCBFUEMgcGFnZXMgYXJlIHN0aWxsIHRyYWNrZWQgaW4g
dGhlIEBzZ3hfZ2xvYmFsX2xydSwgc28gb25seQ0KPiArCSAqIGNoZWNrIEBzZ3hfZ2xvYmFsX2xy
dS4NCj4gKwkgKg0KPiArCSAqIFdoZW4gRVBDIHBhZ2VzIGFyZSB0cmFja2VkIGluIHRoZSBhY3R1
YWwgcGVyLWNncm91cCBMUlVzLA0KPiArCSAqIHJlcGxhY2Ugd2l0aCBzZ3hfY2dyb3VwX2xydV9l
bXB0eShtaXNjX2NnX3Jvb3QoKSkuDQo+ICsJICovDQo+ICsJcmV0dXJuICFsaXN0X2VtcHR5KCZz
Z3hfZ2xvYmFsX2xydS5yZWNsYWltYWJsZSk7DQo+ICt9DQoNCkZpcnN0bHksIHNneF9jZ3JvdXBf
bHJ1X2VtcHR5KCkgaXMgb25seSBpbnRyb2R1Y2VkIGluIHRoZSBuZXh0IHBhdGNoLCBzbyBpdCdz
DQp3cm9uZyB0byBtZW50aW9uIGl0IGluIHRoZSBjb21tZW50IGluIF90aGlzXyBwYXRjaC4NCg0K
SXQncyB3ZWlyZCB0byBhZGQgdGhlIGFib3ZlIGNvbW1lbnQgaGVyZSBpbiB0aGlzIHBhdGNoIGFu
eXdheSwgc2luY2UgLi4uDQoNClsuLi5dDQoNCg0KPiArc3RhdGljIHZvaWQgc2d4X3JlY2xhaW1f
cGFnZXNfZ2xvYmFsKHZvaWQpDQo+ICt7DQo+ICsJc2d4X3JlY2xhaW1fcGFnZXMoJnNneF9nbG9i
YWxfbHJ1KTsNCj4gIH0NCg0KLi4uIHRoaXMgZnVuY3Rpb24gKHdoaWNoIGlzIG5vIGRpZmZlcmVu
Y2UgSU1ITykgZG9lc24ndCBoYXZlIGEgc2ltaWxhciBjb21tZW50DQpoZXJlLg0KDQpUaGUgc2lt
aWxhciBjb21tZW50IHRvIHRoaXMgZnVuY3Rpb24gaXMgb25seSBhZGRlZCBpbiB0aGUgbGF0ZXIg
IltQQVRDSCB2MTYNCjEyLzE2XSB4ODYvc2d4OiBSZXZpc2UgZ2xvYmFsIHJlY2xhbWF0aW9uIGZv
ciBFUEMgY2dyb3VwcyI6DQoNCiBzdGF0aWMgdm9pZCBzZ3hfcmVjbGFpbV9wYWdlc19nbG9iYWwo
c3RydWN0IG1tX3N0cnVjdCAqY2hhcmdlX21tKQ0KIHsNCisJLyoNCisJICogTm93IGFsbCBFUEMg
cGFnZXMgYXJlIHN0aWxsIHRyYWNrZWQgaW4gdGhlIEBzZ3hfZ2xvYmFsX2xydS4NCisJICogU3Rp
bGwgcmVjbGFpbSBmcm9tIGl0Lg0KKwkgKg0KKwkgKiBXaGVuIEVQQyBwYWdlcyBhcmUgdHJhY2tl
ZCBpbiB0aGUgYWN0dWFsIHBlci1jZ3JvdXAgTFJVcywNCisJICogc2d4X2Nncm91cF9yZWNsYWlt
X3BhZ2VzX2dsb2JhbCgpIHdpbGwgYmUgY2FsbGVkLg0KKwkgKi8NCiAJc2d4X3JlY2xhaW1fcGFn
ZXMoJnNneF9nbG9iYWxfbHJ1LCBjaGFyZ2VfbW0pOw0KIH0NCg0KU28gaWYgdGhlIGNvbW1lbnQg
b2Ygc2d4X2Nhbl9yZWNsYWltX2dsb2JhbCgpIHdlcmUgbmVlZGVkLCBpdCdzIG1vcmUNCnJlYXNv
bmFibGUgdG8gYWRkIGl0IGluIHRoZSBsYXRlciBwYXRjaCB3aGVyZSB0aGUgY29tbWVudCBmb3IN
CnNneF9yZWNsYWltX3BhZ2VzX2dsb2JhbCgpIGlzIGFsc28gYWRkZWQgSU1ITz8NCg0KDQo=

