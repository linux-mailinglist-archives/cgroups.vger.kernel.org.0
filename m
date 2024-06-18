Return-Path: <cgroups+bounces-3234-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C190DFB8
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 01:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E37B1F21F28
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E58715279C;
	Tue, 18 Jun 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgVibELk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457E13A418;
	Tue, 18 Jun 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752550; cv=fail; b=cC9LS8FHXYpHwd3cpkwQ2bxsUJZIyP325D6zaAPqLZ9xsUpdVc0QR1/Q6XVaERQI0mAwHWAdISeJiydFhXlcSb3MsJDKPa233k3f9Uk/lVkTrpyGG7TGLgHAKLwTLvvngBKit26xaX5EKuqnU2s9HeoI6haegjv3laLwDjospjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752550; c=relaxed/simple;
	bh=nbhJwmNKrbctPbB7IaHoS0wktAAH0AuAWcQH9T93d2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UoWAbdiWwlKMi49Ij8eJDNs9UJIlMPOvT6yIvm1CT3lfXeX6X/CJNmfnLkFHbpfHsqrpgh/qAGtfiL+4umn1sxiDNUHS8QN20Uqbae0clQk1ab4qupP3BtDd+WbvhvsXvtGNsO47neyuzzNAeIoN3qSx9iVAdounXoccFLAhxp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgVibELk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718752548; x=1750288548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nbhJwmNKrbctPbB7IaHoS0wktAAH0AuAWcQH9T93d2Y=;
  b=HgVibELkMTFH5rEJI+B4y2Pq2yclcfzHuOy6ych7MAaRNIZB/X6HjLol
   fh8UqXDTD96PZNPuMsuNbWihJSX5tmIGGzM3/nAzUo6sTCDzWo4sLu5Q+
   piInxBTW70kcv5/2o0CBaN+egGASpOQpaY6VmzPOyw6BnIXDYIwvshSkz
   XQTjpmGTBNwI2vqaQPUkggZYJ2Cdp5z18fBVM/8Dc+aOx7lXqJg8M0Uh0
   TyqwzTJpcG6fMGEOA01m50IrYDJS18E44g6PX8dPtmP1PXO4QWgnDjvvg
   KcHz7VaME0SX8nREDPmIwGrUBtK4+H/APjY9na8/ncbsJlvbb+1K6xNga
   A==;
X-CSE-ConnectionGUID: 6NZXW7SqToCHrl4QAHgPSA==
X-CSE-MsgGUID: m8urXUpTSYKrw5SzxwL8Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15427869"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15427869"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 16:15:47 -0700
X-CSE-ConnectionGUID: igF75uRgQP6lYcjEQJL5SA==
X-CSE-MsgGUID: e6RD4wDVTjKCraGr5xirjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46151961"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 16:15:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 16:15:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 16:15:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 16:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs5lJHPoUCYR4fR73TrP15dH1BX6b8dqFNxogYkifL18lJMfPZXTamgH4x8JO4YOUyEH1cA9D/BPjl82qTW+k0I5wr/sfe6v9p84rK1wSEqxpjoPz4Jq5/vWgk8qmpnHy9MNOh7xIWi3khkPzEbjJborhgWaKSsZ24bZ2JjcEHneTh5/9CHb+Eh8Nl/0g+7oGH6j4A15C0/mimZCzOsCw5jY/5qJhY2rIlFKC+04Gxc6HkRTHO2T2eTT2D6dUx2bMx8zXaT7UK+n14npDIohYnKRusAoy7VD1CCsF+LJ94TRqcrknMnK+EwJZ/LPu9ZtRJiZkhqRf7UqHMWehtr6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbhJwmNKrbctPbB7IaHoS0wktAAH0AuAWcQH9T93d2Y=;
 b=fmRgRG8PG6+5bxEMVimR5Kky2NVS6qA13AM9dBwtUfdrbHetTeCE4k74bjmxpQs54HyYmAIBqi+m0IerWUIopoWfAjGwU4Py64yiRREl0cQJL5I4ZKPFkcsr8WJYRLzU8D9qE1p2i8bDLsrC8tvFY0yNM2TuMjrISpNjcbXM0QlOygVMh7NaxcOCfcDkXclets7mIyH8DNJNE7mpdnCSMyvS7Xy0ezMcOfLffl+X0+PG+QOcCblDeMTi7F8shfRm3bCLjnOw9e8KeWGLpykveZ8CQ5Cv+9PmZeey6nDOQSEYp7+8BtlOZyRPIWCP0fLkiQjbQ3yJPO3e0RVUorMaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 23:15:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 23:15:37 +0000
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
Subject: Re: [PATCH v15 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v15 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHawLVpCFAs5aGEAU+I+soWZvGHW7HNZJYAgAAX1QCAAKz/AA==
Date: Tue, 18 Jun 2024 23:15:37 +0000
Message-ID: <b2ee67d2d1540c1eca1545a4121a4f9b34036e06.camel@intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
	 <20240617125321.36658-6-haitao.huang@linux.intel.com>
	 <aa686e57fad34041fb941f87c10fb017f048d29f.camel@intel.com>
	 <op.2pkbj8lbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2pkbj8lbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA0PR11MB7187:EE_
x-ms-office365-filtering-correlation-id: 0565004f-be4e-4446-9fd5-08dc8fec9055
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015|921017;
x-microsoft-antispam-message-info: =?utf-8?B?QmNWa0dqN3ZNdFQ0L1FoTDMzU1ZGN1RkL1JQa0pvNjJPSFlGOUxKZXI0Tzcz?=
 =?utf-8?B?Wlg0c0NNL2YvdmFWNHR4ZmgwUytJa2d3L044bHdyYm53VENOaWRMaEdObS9Y?=
 =?utf-8?B?RG16Y0tSY0tzaktxZklKZ3VsQXVERXRnTFRGRG9WaHo5a2R2MUdRclR0aDVW?=
 =?utf-8?B?YXF2MGdqc1hLS0VkeER0VzNKUCtObUlJOERMcUlISGIwL0VFNk44N2Q1dGl0?=
 =?utf-8?B?bUY3amtCbVRrWkVrSUVQcVc0VlVaVkhXL04wUDljbzVGZ1QrM0h2aFl1WnNF?=
 =?utf-8?B?b0QrK1pIMEVRc1dIWWMwK2VYYW1RRjgrTnFOUFZZT1Q5NjRaMndBSTBVNVN5?=
 =?utf-8?B?ZW84NDMwT0dZUlVPZmxPbG1YYkFnOGNBNjNKK1NLaDhRZzJYQnRzSUdnSTda?=
 =?utf-8?B?b2tER3l6cFpCNGZ2dnlUcUI3TWhOVjhUblhOTno2dUZjbnd2cG9rQkpIQWph?=
 =?utf-8?B?ZEt0SXB3RW5Yb09yUGRTa0djaHVjNmY0cVE4VFpMT0FpcHJaRExpd1hSbkZM?=
 =?utf-8?B?Q2owdDR3TzNHVWJMYkJFMy9BMURqTmVLbDlqYkExclo4VitEN09Ja1UveUM1?=
 =?utf-8?B?QjI3dlRnenJwdFF6SmFWV2Y1ZkhCejVZdzgreXlMUUlMaE1QNnUya3hDdmdh?=
 =?utf-8?B?dUhkMFpGWUljeFJVbnhpRWZXMWpGdFVmOGRqdCtaWENYdTZQVi8wZXBMRnl1?=
 =?utf-8?B?U3FPb09idlhuQS9ISDIzWDBqNnp1TGhYZFRBY2U3ZDdjNi9XM0lxOU80VkFi?=
 =?utf-8?B?ekRhTmJFcmorNHMveXNKVGpVWUhFdjJQMmhpR0RuUFhZZGdzc0Q0MjNodUJD?=
 =?utf-8?B?RUMvQWxURVZ0L2RDcHNVZXpUWm5ucDRRT3ZVK2JzbUtEcktrbEd6eVNlczZW?=
 =?utf-8?B?b0wyb0ZxVS92Kzc4MTdUdW9HWXlPb2FVaFJzTStIOXYvM3k0Vi83V3RqWEhK?=
 =?utf-8?B?VUwrdjJUdFFQSDBHU0d1SWQ2MEdYUmZNWVAxLzZBTk1PcFJ6d0xUQnJRNHdh?=
 =?utf-8?B?b1lnQlJ6Q29KaTlyWVNPWUJTVDZPVnFJeVRNRkpLYXdJY1JOaFpnRUZpQ3U5?=
 =?utf-8?B?dFBHbmpMRDQ1TGsxVUcxdFRCK2FUNFBoMEVESm0wclIzRVpGWlNDYkFqSTZG?=
 =?utf-8?B?ekZQTVBIR0pncDVpNkFqWGtvVUlXYmpLVDM0WXdsTHBxV3piUGNTSjVhcllo?=
 =?utf-8?B?aitQcndNbElIWUJ1VmZ6TEJGVjVDYXdsOWtETndXQitnNDNwQ0hVczlQTDEy?=
 =?utf-8?B?blV5TnQ1N1M5QWpscVl4M2NyZGE2dncyaHBUbzFIN0ZBR2FyRElXMzk0OGRB?=
 =?utf-8?B?OHJ3L3d4aTBJTFFVMkl3ejFISm9Sb2dPNXFhR0gzVWRGNnZjUWhkK1IzQ2hr?=
 =?utf-8?B?MWpKMVQraXRZQ1U2VDVYdENqTDFTQlBDMitKem9neWxmVXpZWDBqRndXOUpH?=
 =?utf-8?B?N1VXUS8xSXRyVDQ2L2psUXdWL1Y2Y29HVU5pUFZvNFp3aVl5Q2lTNlBybUNQ?=
 =?utf-8?B?ZUlFaUZWd3V1TFRDUFdhenZLMGd4ZWFvVHQ4R3plNlBjNnI2bzJCNktDSzZP?=
 =?utf-8?B?UE9EbUYxbjJrbmRPOXpuUlZsRWJpYmF4RXIxak5nZXdpaE9tS3UvWkFUTi8v?=
 =?utf-8?B?QTVlQzdvMDR2TUN5YW42S1JJcU5naUFjc1NJSzJoTHcydUhQWStSZWJyZ2My?=
 =?utf-8?B?QWNlV3lVTW81dXFDeUhscDhIZDdVWloxL0F0eUJHOE9Iem1QTnl0d3JNUHc3?=
 =?utf-8?B?WWVhd3ByZWhnWldieFpkdWdnTjdRSmMzVHkwblRENlBHRDlSSzFGaCtyRU1N?=
 =?utf-8?B?NXE1bmZhSmVXTGpMaGxKY3FpR2pRQnM0ZGgvbXVJSWNlMkJXWFVid21nVlpp?=
 =?utf-8?Q?WDs1BP+WclJkT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXNmUERPQXZDanNnNnpuOFQrWTEwdHRDeHU0NVFJbFRtbjVIQkV4ZEZKZ0M0?=
 =?utf-8?B?RERkay9OTlZzWno3Y1ZUZFQwcWR2NWRPVmZBRDg5TFRhQ0h3bVJoTUdZR2Y3?=
 =?utf-8?B?NmFpb0xTTkVrV29Lc3B1SVJvWFQ4SFFodHBsN25sSDFoZExVeVBRRDNtR3NP?=
 =?utf-8?B?aDNnQy9kZTVoQnl4aGNwSkpMUUhYbmpkSWVCbWE1djZmNkc3RThYVGUrVFVL?=
 =?utf-8?B?RjVzSnVpVkxBRUhRN3hXVmVHTkZxRHU0VGlpRG4yRmdaWGlOZzloT3ZGOXF5?=
 =?utf-8?B?U0xSVGI1akt5OG5ob0pHcjN5U2JSTVZsVW8xUm4wTFpwdmx4bGJLVTVRMHpW?=
 =?utf-8?B?cUlaK3VQS1FtRkpMaFJCaFQ2QUI3dUx4WVEzSHJJNFFUNUJUZUovN1ZTR3Rq?=
 =?utf-8?B?ZjcvOU5qaWN6ZEM4LzhTVTNpaGRyS1JCeG5UeEJiRFVKamlnaysyME1LVGYz?=
 =?utf-8?B?dkI1NURhdWxnVTZQeldCRGprejB0dlozVlJNUTVpaXY2ZEsvNXNMc0tlTThB?=
 =?utf-8?B?Kys4eWlCRXFmWWI0YWhnbC80TTJ2cjdUTnA3b2hvVXNDcFJSbzFGZVBiYkti?=
 =?utf-8?B?SmdrakpuRHhwZVFzMXpaMlE4dWorM1FYaEpKdkxqbllIS2U3QmE3emRqTXBS?=
 =?utf-8?B?VmhJWWwxTTdlakwrSmg4QTBCa0xvMVVSdnliQ1VyenEzNEtTUG8xUVRYSk8r?=
 =?utf-8?B?bS9SOFF2WEJReFoyOThqZmNRYVBQZHBoeUdvcFVoVW50clovOWJjZ1dZQXBk?=
 =?utf-8?B?UE5vaDdibmx1ejJJL2FNajVFNlZMMkZCSXE1VzlvT0JjVWlTbnZrNFZJMTBQ?=
 =?utf-8?B?Q1I4ZHBSbnh6TGZ6ZTlwT2x0bm5hWlVmMjRNUnNaVkJsV2k1T1NjbnQvV250?=
 =?utf-8?B?bUdPYXNlUjhmMzQyT3Fuak1lKzhGdldjRHl5dWlheENSbjdQbVA5Tlo1S0da?=
 =?utf-8?B?TXd0WjhSVnVNZHJPVTJ0QTl6UGpYZ0lBK3RBTjk2WE14MGU5MjhDMXhIWFlL?=
 =?utf-8?B?a1c1Sy9aTnVyM0I2c2ZtdHZUc2ROQUUvRjBYakd3bEx5NUJ3SFd2eC96YS9H?=
 =?utf-8?B?T0E4cVcvTmIyZWF3R2V5VkV4Y3RkaFVvUHZ5L2ZYZFpYNTJKTDdQSUdnVUh4?=
 =?utf-8?B?bTBNYjQyNmJ0amtUZXFMeExsSjd4UUlQdy8xKys2MzJDT0ttbDdTMCt4YUNO?=
 =?utf-8?B?YWsvZXJ3bnhCREJqWituT0ZITStpMW51MTBUMkdDbksxZFRIeXBLbC82cXVp?=
 =?utf-8?B?RXRkSGdCb1hhOVU4MmNPM0lnS3V2a2FUYU5CU0VoaWNUcjlSN3N1RUZTSkpY?=
 =?utf-8?B?MS8vR3M3akVOWExRbnNqVDBWakRqcHVnMm9kVUhpSDhhR0ZQWXhVOGNzQVdO?=
 =?utf-8?B?OWQvOCtOU0M0b1hqOVdtamxpazVQVVNVUm9hcEd6YkhHdTIzTWhDVis0Njdz?=
 =?utf-8?B?bXh6Rk5HMHVEL1ByUkdvZk9QYU5tZzlZTUdKa044dGNONWdUaVdpL2pEUVVj?=
 =?utf-8?B?YytsTHVRakxKaEFxWGJoaENBVmFqZDVqNTdGVm1mN0xhWWRFbllZUzNGNUlu?=
 =?utf-8?B?WHhrMWs2U1ZSOTB4anNRZmYrUDFhNDNLamZQV3djQVdSTk9ib25CQ2Yzb0t3?=
 =?utf-8?B?T0Nla204d2Vya2lxdkhPOTJBUzM5dGZiQ3BsVHhvb05GSGU4YlR0OFFrNW4x?=
 =?utf-8?B?cy9IUDErSzMyeFREc0xjclNNc1VGYUxJdnFOdWtvRXFvYVREaWxZOVBqSFd4?=
 =?utf-8?B?dzVyUzE0RTFFeHlOZ1J6V254ejVUdGpSWWpIR3BuaCt5Q3ArZHk2aGxBM3hu?=
 =?utf-8?B?NVJRdjc1ZWxxd2tpTFF0eWhua0p6b0pGWVdQRWlVVnZ3NDVrOVFTSGZoSXQ4?=
 =?utf-8?B?ZTU4cFRQKzZoOXhBazVJNGEwZlpyY3kzWU16eUpEU1JRcDduM1VtT0NCLzRP?=
 =?utf-8?B?a3pUUHlYUjJGUjBUNWVHUmZZek1zMklRUkJtejVid1JzZU5FTzh0N25adllq?=
 =?utf-8?B?RXVtV0N4Sm42R3ZzNUVJZTQ5M2tUUC9Rc0Z6SEdhQVZVMjNRZUF3cFJnNzEz?=
 =?utf-8?B?YmpCZm5ScGNqK2d5WnpCVVpiV01pbFBQVm1Rb2VEaVpOZ2FCMGdjb1VPZmls?=
 =?utf-8?Q?YO/sUdvD2k29EZnCT8KGS6ad8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA413FA25DA5D499D504DA335147510@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0565004f-be4e-4446-9fd5-08dc8fec9055
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 23:15:37.6210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9y/TkKeBsDY/A+ZGZSSAOjwAPnEnTsbx42ISJJAGpuBqi0Iv9HYBLn2gmlxQKd872J2aO8IDFN7BelCAmQiZYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDA3OjU2IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFR1ZSwgMTggSnVuIDIwMjQgMDY6MzE6MDkgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiA+IEBAIC05MjEsNyArOTU2LDggQEAg
c3RhdGljIGludCBfX2luaXQgc2d4X2luaXQodm9pZCkNCj4gPiA+ICAJaWYgKCFzZ3hfcGFnZV9j
YWNoZV9pbml0KCkpDQo+ID4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+IA0KPiA+ID4gLQlp
ZiAoIXNneF9wYWdlX3JlY2xhaW1lcl9pbml0KCkpIHsNCj4gPiA+ICsJaWYgKCFzZ3hfcGFnZV9y
ZWNsYWltZXJfaW5pdCgpIHx8ICFzZ3hfY2dyb3VwX2luaXQoKSkgew0KPiA+ID4gKwkJbWlzY19j
Z19zZXRfY2FwYWNpdHkoTUlTQ19DR19SRVNfU0dYX0VQQywgMCk7DQo+ID4gPiAgCQlyZXQgPSAt
RU5PTUVNOw0KPiA+ID4gIAkJZ290byBlcnJfcGFnZV9jYWNoZTsNCj4gPiA+ICAJfQ0KPiA+IA0K
PiA+IFRoaXMgY29kZSBjaGFuZ2UgaXMgd3JvbmcgZHVlIHRvIHR3byByZWFzb25zOg0KPiA+IA0K
PiA+IDEpIElmIHNneF9wYWdlX3JlY2xhaW1lcl9pbml0KCkgd2FzIHN1Y2Nlc3NmdWwsIGJ1dCBz
Z3hfY2dyb3VwX2luaXQoKQ0KPiA+IGZhaWxlZCwgeW91IGFjdHVhbGx5IG5lZWQgdG8gJ2dvdG8g
ZXJyX2t0aHJlYWQnIGJlY2F1c2UgdGhlIGtzZ3hkKCkgIA0KPiA+IGtlcm5lbA0KPiA+IHRocmVh
ZCBpcyBhbHJlYWR5IGNyZWF0ZWQgYW5kIGlzIHJ1bm5pbmcuDQo+ID4gDQo+ID4gMikgVGhlcmUg
YXJlIG90aGVyIGNhc2VzIGFmdGVyIGhlcmUgdGhhdCBjYW4gYWxzbyByZXN1bHQgaW4gc2d4X2lu
aXQoKSB0bw0KPiA+IGZhaWwgY29tcGxldGVseSwgZS5nLiwgcmVnaXN0ZXJpbmcgc2d4X2Rldl9w
cm92aXNpb24gbWljcyBkZXZpY2UuICBXZSAgDQo+ID4gbmVlZA0KPiA+IHRvIHJlc2V0IHRoZSBj
YXBhY2l0eSB0byAwIGZvciB0aG9zZSBjYXNlcyBhcyB3ZWxsLg0KPiA+IA0KPiA+IEFGQUlDVCwg
eW91IG5lZWQgc29tZXRoaW5nIGxpa2U6DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFp
bi5jDQo+ID4gaW5kZXggMjc4OTJlNTdjNGVmLi40NmY5YzI2OTkyYTcgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jDQo+ID4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL2NwdS9zZ3gvbWFpbi5jDQo+ID4gQEAgLTkzMCw2ICs5MzAsMTAgQEAgc3RhdGljIGludCBf
X2luaXQgc2d4X2luaXQodm9pZCkNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gICAgICAgICAg
ICAgICAgIGdvdG8gZXJyX2t0aHJlYWQ7DQo+ID4gKyAgICAgICByZXQgPSBzZ3hfY2dyb3VwX2lu
aXQoKTsNCj4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJy
X3Byb3Zpc2lvbjsNCj4gPiArDQo+ID4gICAgICAgICAvKg0KPiA+ICAgICAgICAgICogQWx3YXlz
IHRyeSB0byBpbml0aWFsaXplIHRoZSBuYXRpdmUgKmFuZCogS1ZNIGRyaXZlcnMuDQo+ID4gICAg
ICAgICAgKiBUaGUgS1ZNIGRyaXZlciBpcyBsZXNzIHBpY2t5IHRoYW4gdGhlIG5hdGl2ZSBvbmUg
YW5kDQo+ID4gQEAgLTk0MSwxMCArOTQ1LDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IHNneF9pbml0
KHZvaWQpDQo+ID4gICAgICAgICByZXQgPSBzZ3hfZHJ2X2luaXQoKTsNCj4gPiAgICAgICAgaWYg
KHNneF92ZXBjX2luaXQoKSAmJiByZXQpDQo+ID4gLSAgICAgICAgICAgICAgIGdvdG8gZXJyX3By
b3Zpc2lvbjsNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJfY2dyb3VwOw0KPiA+ICAgICAg
ICByZXR1cm4gMDsNCj4gPiArZXJyX2Nncm91cDoNCj4gPiArICAgICAgIC8qIFNHWCBFUEMgY2dy
b3VwIGNsZWFudXAgKi8NCj4gPiAgZXJyX3Byb3Zpc2lvbjoNCj4gPiAgICAgICAgIG1pc2NfZGVy
ZWdpc3Rlcigmc2d4X2Rldl9wcm92aXNpb24pOw0KPiA+IEBAIC05NTIsNiArOTU4LDggQEAgc3Rh
dGljIGludCBfX2luaXQgc2d4X2luaXQodm9pZCkNCj4gPiAgICAgICAgIGt0aHJlYWRfc3RvcChr
c2d4ZF90c2spOw0KPiA+IGVycl9wYWdlX2NhY2hlOg0KPiA+ICsgICAgICAgbWlzY19taXNjX2Nn
X3NldF9jYXBhY2l0eShNSVNDX0NHX1JFU19TR1hfRVBDLCAwKTsNCj4gPiArDQo+ID4gICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgc2d4X25yX2VwY19zZWN0aW9uczsgaSsrKSB7DQo+ID4gICAgICAg
ICAgICAgICAgIHZmcmVlKHNneF9lcGNfc2VjdGlvbnNbaV0ucGFnZXMpOw0KPiA+ICAgICAgICAg
ICAgICAgICBtZW11bm1hcChzZ3hfZXBjX3NlY3Rpb25zW2ldLnZpcnRfYWRkcik7DQo+ID4gDQo+
ID4gDQo+ID4gSSBwdXQgdGhlIHNneF9jZ3JvdXBfaW5pdCgpIGJlZm9yZSBzZ3hfZHJ2X2luaXQo
KSBhbmQgc2d4X3ZlcGNfaW5pdCgpLA0KPiA+IG90aGVyd2lzZSB5b3Ugd2lsbCBuZWVkIHNneF9k
cnZfY2xlYW51cCgpIGFuZCBzZ3hfdmVwY19jbGVhbnVwKCkNCj4gPiByZXNwZWN0aXZlbHkgd2hl
biBzZ3hfY2dyb3VwX2luaXQoKSBmYWlscy4NCj4gPiANCj4gDQo+IFllcywgZ29vZCBjYXRjaC4N
Cj4gDQo+ID4gVGhpcyBsb29rcyBhIGxpdHRsZSBiaXQgd2VpcmQgdG9vLCB0aG91Z2g6DQo+ID4g
DQo+ID4gQ2FsbGluZyBtaXNjX21pc2NfY2dfc2V0X2NhcGFjaXR5KCkgdG8gcmVzZXQgY2FwYWNp
dHkgdG8gMCBpcyBkb25lIGF0IGVuZA0KPiA+IG9mIHNneF9pbml0KCkgZXJyb3IgcGF0aCwgYmVj
YXVzZSB0aGUgInNldCBjYXBhY2l0eSIgcGFydCBpcyBkb25lIGluDQo+ID4gc2d4X2VwY19jYWNo
ZV9pbml0KCkuICANCj4gPiBCdXQgbG9naWNhbGx5LCBib3RoICJzZXQgY2FwYWNpdHkiIGFuZCAi
cmVzZXQgY2FwYWNpdHkgdG8gMCIgc2hvdWxkIGJlICANCj4gPiBTR1gNCj4gPiBFUEMgY2dyb3Vw
IG9wZXJhdGlvbiwgc28gaXQncyBtb3JlIHJlYXNvbmFibGUgdG8gZG8gInNldCBjYXBhY2l0eSIg
aW4NCj4gPiBzZ3hfY2dyb3VwX2luaXQoKSBhbmQgZG8gInJlc2V0IHRvIDAiIGluIHRoZQ0KPiA+
IA0KPiA+IAkvKiBTR1ggRVBDIGNncm91cCBjbGVhbnVwICovDQo+ID4gDQo+ID4gYXMgc2hvd24g
YWJvdmUuDQo+ID4gDQo+ID4gRXZlbnR1YWxseSwgeW91IHdpbGwgbmVlZCB0byBkbyBFUEMgY2dy
b3VwIGNsZWFudXAgYW55d2F5LCBlLmcuLCB0byBmcmVlDQo+ID4gdGhlIHdvcmtxdWV1ZSwgc28g
aXQncyBvZGQgdG8gaGF2ZSB0d28gcGxhY2VzIHRvIGhhbmRsZSBFUEMgY2dyb3VwDQo+ID4gY2xl
YW51cC4NCj4gPiANCj4gPiBJIHVuZGVyc3RhbmQgdGhlIHJlYXNvbiAic2V0IGNhcGFjaXR5IiBw
YXJ0IGlzIGRvbmUgaW4NCj4gPiBzZ3hfcGFnZV9jYWNoZV9pbml0KCkgbm93IGlzIGJlY2F1c2Ug
aW4gdGhhdCBmdW5jdGlvbiB5b3UgY2FuIGVhc2lseSBnZXQNCj4gPiB0aGUgY2FwYWNpdHkuICBC
dXQgdGhlIGZhY3QgaXMgQHNneF9udW1hX25vZGVzIGFsc28gdHJhY2tzIEVQQyBzaXplIGZvcg0K
PiA+IGVhY2ggbm9kZSwgc28geW91IGNhbiBhbHNvIGdldCB0aGUgdG90YWwgRVBDIHNpemUgZnJv
bSBAc2d4X251bWFfbm9kZSBpbg0KPiA+IHNneF9jZ3JvdXBfaW5pdCgpIGFuZCBzZXQgY2FwYWNp
dHkgdGhlcmUuDQo+ID4gDQo+ID4gSW4gdGhpcyBjYXNlLCB5b3UgY2FuIHB1dCAicmVzZXQgY2Fw
YWNpdHkgdG8gMCIgYW5kICJmcmVlIHdvcmtxdWV1ZSINCj4gPiB0b2dldGhlciBhcyB0aGUgIlNH
WCBFUEMgY2dyb3VwIGNsZWFudXAiLCB3aGljaCBpcyB3YXkgbW9yZSBjbGVhciBJTUhPLg0KPiA+
IA0KPiBPa2F5LCB3aWxsICBleHBvc2UgQHNneF9udW1hX25vZGVzIHRvIGVwY19jZ3JvdXAuYyBh
bmQgZG8gdGhlIGNhbGN1bGF0aW9ucyAgDQo+IGluIHNneF9jZ3JvdXBfaW5pdCgpLg0KPiANCg0K
TG9va3MgeW91IHdpbGwgYWxzbyBuZWVkIHRvIGV4cG9zZSBAc2d4X251bWFfbWFzaywgd2hpY2gg
bG9va3Mgb3ZlcmtpbGwuDQoNCk90aGVyIG9wdGlvbnM6DQoNCjEpIEV4cG9zZSBhIGZ1bmN0aW9u
IHRvIHJldHVybiB0b3RhbCBFUEMgcGFnZXMvc2l6ZSBpbiAic2d4LmgiLg0KDQoyKSBNb3ZlIG91
dCB0aGUgbmV3ICdjYXBhY2l0eScgdmFyaWFibGUgaW4gdGhpcyBwYXRjaCBhcyBhIGdsb2JhbCB2
YXJpYWJsZQ0KYW5kIGV4cG9zZSBpdCBpbiAic2d4LmgiIChwZXJoYXBzIHJlbmFtZSB0byAnc2d4
X3RvdGFsX2VwY19wYWdlcy9zaXplJykuDQoNCjMpIE1ha2Ugc2d4X2Nncm91cF9pbml0KCkgdG8g
dGFrZSBhbiBhcmd1bWVudCBvZiB0b3RhbCBFUEMgcGFnZXMvc2l6ZSwgYW5kDQpwYXNzIGl0IGlu
IHNneF9pbml0KCkuIMKgDQoNCkZvciAzKSB0aGVyZSBhcmUgYWxzbyBvcHRpb25zIHRvIGdldCB0
b3RhbCBFUEMgcGFnZXMvc2l6ZToNCg0KYSkgTW92ZSBvdXQgdGhlIG5ldyAnY2FwYWNpdHknIHZh
cmlhYmxlIGluIHRoaXMgcGF0Y2ggYXMgYSBzdGF0aWMuDQoNCmIpIEFkZCBhIGZ1bmN0aW9uIHRv
IGNhbGN1bGF0ZSB0b3RhbCBFUEMgcGFnZXMvc2l6ZSBmcm9tIHNneF9udW1hX25vZGVzLg0KDQpI
bW0uLiBJIHRoaW5rIHdlIGNhbiBqdXN0IHVzZSBvcHRpb24gMik/DQoNCg0KDQo=

