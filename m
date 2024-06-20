Return-Path: <cgroups+bounces-3261-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668C911709
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 01:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660A11C218B8
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 23:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB8158865;
	Thu, 20 Jun 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMgPkupj"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB54156F3C;
	Thu, 20 Jun 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927600; cv=fail; b=L5BDZyKn+ZJcufDIYDQostZ8aEpc90Am3JH1BIU1yHkPQQ8DUCxgy7FKz5nqh5RLtG9IDefSKI2mGYXmJTAe3PNI85N2b/BDYE8YZinv3kgM4NkOiIPOJz5Y/1eVZl06E1LiasZ8C/jnfeGNEyXcuZmk4O9hlNFj9rmojyzC36M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927600; c=relaxed/simple;
	bh=W1mlQhl1dUQnn/rj7KOCrScBzF7t0K1GBBOS3S+X7+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FMVG3Mp5UGD07SxERkRQgEft5MIsLIYx6fKWI2OS2ur/QsJMFB/jF7XNagT+3vW7fNUetGiakWov5mZVTHxSxoIKcT9xv2YTcKyVF6ge0QOyuhnxcP3h6G2UceB9ZYeommnntyEampVTNqx37j72rx5QGPgwxLQ7gKTatUhd2Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMgPkupj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718927599; x=1750463599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W1mlQhl1dUQnn/rj7KOCrScBzF7t0K1GBBOS3S+X7+w=;
  b=ZMgPkupjeOriFCInzB4Q6OiBwlYCfqExujBiMLarsQyp4AOYGuMDxD0o
   SJksylsfy/VhWMfocBa0QmBmJ9fTnPk6C8BJj/p1cWWK3xg1iBgKrSjOg
   KVgUIFxhqioRfTbUVFyTNEMEgK1kJ5J/oG3uULRELSJ6Lc8jD2KTIzoRN
   9DyA0HEeqvDjoPah4S+Dpe0cFuune9Q7+ujErRgxChMJoR/PWJ1YssPuk
   P1qhNXp/ygWGEJsqgc/7N1iWHQPj49/2ypP8hN0oyQ8POlPBwClfEzV/y
   biXc28G2mWvq3rSd/8WgRnuQOvHI5dz+lap0CWMcubYeV/6AKhvAyXd1f
   Q==;
X-CSE-ConnectionGUID: oJQf+glSRqGdPo2DjY067Q==
X-CSE-MsgGUID: OWPypDnxSO2Wl2FwDpHSPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15644178"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="15644178"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 16:53:18 -0700
X-CSE-ConnectionGUID: S+rudCzCRh+PmWoqVKDhPw==
X-CSE-MsgGUID: NklwxTXeSTCXhH292X0SgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="47598634"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 16:53:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 16:53:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 16:53:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 16:53:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 16:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQ240q8r5vbC+74U8+YPzg/l/IEzFrmcqRhRG4mPzfCYY1bLymLhMrq+fffLQz5Yhss+7u95Me6p+LzpUMI45NJ3tC9zzh80tErDostSBgsu/cJs8jODUXULxsPx9VsMgo0A+8DAce+i3sHRCrxWL8xx/kpVBdOZAXqHRKgWZQQfoE0M+r3x4eweISes1uXrXk4BZRFIqqdO16OkqLJCYF9rbcL2MMnlnli8m0HJiZTYx27fOJs8VCK8ePo/IX3NjgWL6ofz067hkyXc439QwXkDpMNeba2IS0V6I0qrxg67ylCfZcDn5yy/wnx91YP6uKb2n8BC8k8Q4vINrhppcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1mlQhl1dUQnn/rj7KOCrScBzF7t0K1GBBOS3S+X7+w=;
 b=MBT3Kf/T5OzC5CZdPBUILmw4oX9hcHOb8BRMeMFLkMKng8i2RCgsgyeknIfiIW+YLK2nH00m5AAs8uKs1x9rqVxdoAoANxSa63Y041fJ362DzLdb//BniQlHJrr12BTcrP06fB/ezS5wt05MsSnECmsKZf2quPwB34gd6NARrV9kBueQ/ljdX7Bd6QTWPpSHguOpRcO6glSR5d/YeIcx2ylcbuO+urYUikVEdyLmTpsK6M0Pq5AqkJudkBq8imvSMDx4+FPOjTLYffEn78cp324OyVOoFPzBQHvJJ8htQRaxkOx9M8CIpu+Rzq+ZdN+RFqDIW0IiG3BOwH0Dq55obw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 23:53:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 23:53:14 +0000
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
Subject: Re: [PATCH v15 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Topic: [PATCH v15 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Index: AQHawLVstZrzD55ABEe7Fnrv4pe8t7HQeD2AgABNEYCAAJNJAA==
Date: Thu, 20 Jun 2024 23:53:13 +0000
Message-ID: <0c657bb3de56ecd22c67193714a4de45875f36cb.camel@intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
	 <20240617125321.36658-13-haitao.huang@linux.intel.com>
	 <103f18636f0d65e3bcb0ca5f1008c0c7df0bdfd7.camel@intel.com>
	 <op.2pn6wbdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2pn6wbdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5119:EE_
x-ms-office365-filtering-correlation-id: ed3a6bd0-aaa4-4a03-fa3e-08dc9184260c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|921017|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?emFEMXRDOTJyUzRxODJEWlV6T2JYUk1KK1F4bEdzdHFLQjZIUVFaZHRJTzQ1?=
 =?utf-8?B?bEJlUDQvT3RjMUQ3Z01jQm9HMFJpSzRMdlViaEtyNzNOS1d3ekN6dDE0MmF4?=
 =?utf-8?B?M3gvOURFWW8yM1ZYMUdzOGhOVnBRVjVqKzEwYitRT3NDL2Q2S2VZREZJUnZw?=
 =?utf-8?B?NWdEVFl6S2JiOWJXb3M4YmhQTmRqQlFpT1hFeGFYbUw5VzdNdjF5VVBPRTVF?=
 =?utf-8?B?RXB1cEt6cStGSVJKT3hqck1RakVabE5rNWdOSU9oOGlvOXR6WEZ3NERDbGRo?=
 =?utf-8?B?UDZjWGZaNkhDb09XVmkzUE5VUFIvaTBlTVZSNVR2TFBiUURQajNlZk14ZXEw?=
 =?utf-8?B?Z0xhYmk3eFhsUElFZ1dOVUNPZU5WL2gzaS9aZng4cHlPSXI1U3Z2MVhzM0lQ?=
 =?utf-8?B?K1F1NXJwVS91c0djU0RxMGltSTREKy9PNHNlNzBiT1JLM1lRR2trZmJwb2xn?=
 =?utf-8?B?aXVHNkJpUTZmcHczTzV1Q3Z6L3ZyckFGYkJGYjcrbW5LZ2o5ek9yTlVRVmNX?=
 =?utf-8?B?M25vMnlVbk5OQmh6NUcrR05xVUFKa1FxTWZQVk5MODJKMFZBNXZKR1JwMDdw?=
 =?utf-8?B?eXlWL2ptVHdWNG1RaVBMa2pBM1pJNWNZM0F5b1VROTdYeTMrSWRNYi9yNlpv?=
 =?utf-8?B?eXF1eGZOcXVlaWZMb1NMS09aaFNQVktzcWZxSzVBT2lPSzhhMTN4R045NDl4?=
 =?utf-8?B?bzJITS93aFlyb0ZJN1UrdjRWemI0VE5OeWplWGdZZWhxNVFOajhuUVZjQlFm?=
 =?utf-8?B?T05pWVN1d2Z2WVVidkR2ekY4WEc5NkV2TDBrOWU1ZG9IZDZmUTFCQitMeUtp?=
 =?utf-8?B?MldhZE1UaTlVNTljTzFyYzMzMjVTOUttcjgyb1BjWThqZndFZDh4cUNkcXEw?=
 =?utf-8?B?L0txWVROdkJ4SUxBTVFoajY3WEluRUFyV21OMk1wKzg1N21LbkVLSEJpQy9B?=
 =?utf-8?B?amdhcU56U3pOSitYcmtzaU1HU2wvZ0xTaENuM1p2UkIyRWk4Z1VVZGlPTzJK?=
 =?utf-8?B?YVI3aVcvQVNLSjF5bXdXNW15d1BGNU16ejZZV2FMYnZVaWFMM2JWanRKVk93?=
 =?utf-8?B?cC9UVGtVY2FKa0dnWnBSeVNMZjl0UHNmc2ZKWUtXL2w5V1Yvc3pHTzRBQkNs?=
 =?utf-8?B?cmJxcitLbEx1azFZTGI4blVySklwYmFXZlExZVg2VmM4Vzd6VDBlKzdjZ1B4?=
 =?utf-8?B?K1JmeThlQm41UUhJekZSa0kzQ3JqaXNsZDhjZFk0b3A1WjlJMGdYWGRhdndQ?=
 =?utf-8?B?amhEbFhkN1phU2R2RTdSdWlTUHBSVmsyV3pUTFphRjJ5VklWekRhQmEwdmtR?=
 =?utf-8?B?UW9ZRU8va1lISHppQkVVVFZIalJRWS9vamlFcDlZOEhWTm40d2tobVpCNVQ5?=
 =?utf-8?B?bUpKbnhMa010bjQ5dmpyKytWYkJTdnBtZ0ZoVGlKTTFXTksrK0pJazFJRHhn?=
 =?utf-8?B?aWxWWFJRYzhFZUJJRHNsallKOVFLYzJNUVhkTHFwQjgrRGp0T0lWYjA1Wlpv?=
 =?utf-8?B?eUpvZnM1QmhkaVNENktKNDJ0a2J5MFdhY0lTdE55TlNPVEczbE5jTEZ2TWp3?=
 =?utf-8?B?T0NNclc2VEZiSjFQczN5T0pMaUhJYkFaUlF0MnpEQjQ5KzNSTyszWWszQTdj?=
 =?utf-8?B?cTNiUk5TOHc3aTNJUk5ERGNwZjVkZ3BtbzlNVWFwNGc3OVlnMWhKYUtRTDly?=
 =?utf-8?B?NzhkM1RkVHoyM1J0WWFJVHBudGNPZm4wRGhZS1ZlSCtFQ2J2SUhHaERJRXN6?=
 =?utf-8?B?L0JORVpUampka0FBQngwZWUwTkFvQnl6c3QzT3lPcm5wYkdOeXVlKzFLWGlF?=
 =?utf-8?B?MXZsOEhtMWxRKzY0UWN5VzlKVXltSGNQb2IySkJQelVjRjVWYTcyaU9IZld6?=
 =?utf-8?Q?RcXWy4bDShX/e?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnF6WlpDWXRYNWt5Q1o2cVZsTnlZaDJoNUp6VUlXS2lkRnBDMWxYYkh4YTY0?=
 =?utf-8?B?YncxVGdHL0dVYVNTbVhwbG9iTjRPZ3U0ZWdrRGNXR2d3MG5Odk9nZUEwSGc5?=
 =?utf-8?B?d1J4L200NXNuNDdueGVYRWNXbm5XSmVoQlZJL1k1eXVlNjUvbDl5OFhOdlZJ?=
 =?utf-8?B?cVZ4WXFJZEJQdVZvVWZnVkJ3SWtmaXNOVTJad2l5QWpwbTZlVDMrQkw1Y0dL?=
 =?utf-8?B?K2xJL1VIZENSbnIvbG9EK3RQNDF2L0ZiWHpzc0tVeUxnVnVLUUgzaCtSUmtF?=
 =?utf-8?B?SkY5VmJEUXp4WWVxU01WRVp5WDlYcjhWcGdPNWU5aVFad2I5WThvSWs3c2Jv?=
 =?utf-8?B?SS9UWDhYNzR6VFlOekl1b3h5YVJkSmF1aVVyUUlLNzVTbjlzd2c1OTVkSXhn?=
 =?utf-8?B?VGhNaXkxbEIyQjlEQ3BMZ2dBeE52cnBjWGRzNWtxSFVDZ1JTY3V6NTBtQktq?=
 =?utf-8?B?UlllQm0rck9qYzc4U2dSZ0h2aEFSU1R5NThYS2p6czFkK3Q5YlVBUkM2d05y?=
 =?utf-8?B?aW1XSXRlc21NNDc4RmtYU1hGbE90cms0Vms5SjVBbC9NSExSU1djQzFxMmFC?=
 =?utf-8?B?QThRTnBxOE9QU3pOcFU3TWwzTHpLa0xqM1F6QjQxK09XUm52T0VrZDdHQXJp?=
 =?utf-8?B?ZTd2V1c2OEgzKzdLdG9RdDlneGhDek1CRyt4U3l4RVU4L1gwajZLYzRueERx?=
 =?utf-8?B?cFFLejNPWjIrV0VkMFp6a1N5VGdHVDFLRGZCY0U3UG1pWHZ0STM3ZldKZDRY?=
 =?utf-8?B?KzJycFBaK01DQnA4aG1rZmNNR3BOeXJhSXdKM1RkWEp4OWpNR2k5TEdzTW53?=
 =?utf-8?B?eE5NaEsvM0lQZ3lJUmlVaWNJTGNDWGJ2TENxN2JULzF4aVQxVzN1OS9Qdk1K?=
 =?utf-8?B?MGhIMHBPUjBrNUxybDR1NVY1eUVlMFZ0TSttRjlWWkRJU0xZQTNYMGlrOWZV?=
 =?utf-8?B?cUxNY2czc3lZQ2tYYXJJcUFTdENPaXZsUHhkS3crM2szWE9KYTZPWXVrOC9H?=
 =?utf-8?B?UGdmTUQxamxaaGJJQVJyVUl6bm1Rd0FaczBTTDg4aVhtT1BuWjF0VE43TG12?=
 =?utf-8?B?NVhlUmJrb3Rnc3ZMSWhmUkttUGNnaUNkamp0TUR5NDFpOXhwWEdUY01naFhU?=
 =?utf-8?B?M3A4UEpkU1lxenlzMy9ab3dOODNUTjV6bDlsa1g3dmkyZVNmRGdWelZ5K2FF?=
 =?utf-8?B?Mk03TGZwTkY0WjJXNG1PYURTZ2JqU3FBR2dtNnhsUG9oS2xWcnMxRUlSa0t6?=
 =?utf-8?B?TTNqU2dpZzZTMDFXK2JncW5RREVIOVdnK29OTlNSTVYxZ202QUlLUWNENlJj?=
 =?utf-8?B?bDNhcWltb3p2Ukhja3ZHNU9vakdRVE8wTURoSThMWE8zZ2N3WnBGVGpNRFdv?=
 =?utf-8?B?enFDQk1tNEN2NWNSQUhpV1JJL3U0RnUvZDJxSC9MMTN5TXVremxiRm9VRUZx?=
 =?utf-8?B?WlBSUTVoSFBBek1vcy82cmdoalJIZDJ2dWlFWE44VUpvVTJTcHhEb2tCaFI2?=
 =?utf-8?B?QWt6NVZnWk5ON3lJaGJMa2liMFB4RnFrenN0aStSNmNHNXovbUM3ZnFZSSti?=
 =?utf-8?B?UHJpK3NNUkUxNE9GOE03dVNKTEJvTWxqK2pLSEJtYmNlb0FKMmhpckRKQTlQ?=
 =?utf-8?B?OWFvMzVaVHNicDB5KzdSOGxXR00rZXZoR2pZQWlVV3Bvby91YXhnbXFleCtO?=
 =?utf-8?B?c2RHU2xTTm0wVGhhaFVtZzhvK3hKUjJaUWIwV0FEVW1YNlk2dlV4Y3k3dnhw?=
 =?utf-8?B?YVVhcE1uR080R1hsRVBZQ2lPVk0waW5va0lFdzR4ZkV3Rndod1lReFhabVo3?=
 =?utf-8?B?WitsczU5bnhjS2p4clpVQUtDbUZmZUtmR1lxMklBbjN2QnVCeHg2K3Y0dEQ3?=
 =?utf-8?B?allFcnJmVmdZQTIzaW9KVWlxb2I3OE0wOFY2emJ3OUx0ckthZlNEaGh0ekJV?=
 =?utf-8?B?WXpnZVhSMmxDUGhtMGpwMEhmV2U1WElnSUdIN09adXRtVk9rRTYxczJCSVZJ?=
 =?utf-8?B?RWw1QitNbVhieXRUcWlEdVNscEpTVkRxWjdUMkNhaEpyYmJzUjhENXgyeFFW?=
 =?utf-8?B?TVNhOVdjWkFVNUsyc0lOZnB1Nk1VTDNuK25rWlhaRC9SYXp3ZXdrWHE1ajgv?=
 =?utf-8?Q?L8/DQAGS/E02xmOry0t/nJ3e4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24B7950763273C40BC4E2A0C4AD4CAFC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3a6bd0-aaa4-4a03-fa3e-08dc9184260c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 23:53:13.9675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYKUsymWHKke6KdOk8xcVLVmuuQMsGylYR1NyIj/mLiXUR5idUll/fCwXC8gWgZUic4qUqL425ioJt1ueT6LRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA2LTIwIGF0IDEwOjA2IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEhpIEthaQ0KPiANCj4gT24gVGh1LCAyMCBKdW4gMjAyNCAwNTozMDoxNiAtMDUwMCwgSHVhbmcs
IEthaSA8a2FpLmh1YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IA0KPiA+IE9uIDE4LzA2
LzIwMjQgMTI6NTMgYW0sIEh1YW5nLCBIYWl0YW8gd3JvdGU6DQo+ID4gPiBGcm9tOiBLcmlzdGVu
IENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiANCj4gPiA+
IFByZXZpb3VzIHBhdGNoZXMgaGF2ZSBpbXBsZW1lbnRlZCBhbGwgaW5mcmFzdHJ1Y3R1cmUgbmVl
ZGVkIGZvcg0KPiA+ID4gcGVyLWNncm91cCBFUEMgcGFnZSB0cmFja2luZyBhbmQgcmVjbGFpbWlu
Zy4gQnV0IGFsbCByZWNsYWltYWJsZSBFUEMNCj4gPiA+IHBhZ2VzIGFyZSBzdGlsbCB0cmFja2Vk
IGluIHRoZSBnbG9iYWwgTFJVIGFzIHNneF9lcGNfcGFnZV9scnUoKSBhbHdheXMNCj4gPiA+IHJl
dHVybnMgcmVmZXJlbmNlIHRvIHRoZSBnbG9iYWwgTFJVLg0KPiA+ID4gDQo+ID4gPiBDaGFuZ2Ug
c2d4X2VwY19wYWdlX2xydSgpIHRvIHJldHVybiB0aGUgTFJVIG9mIHRoZSBjZ3JvdXAgaW4gd2hp
Y2ggdGhlDQo+ID4gPiBnaXZlbiBFUEMgcGFnZSBpcyBhbGxvY2F0ZWQuDQo+ID4gPiANCj4gPiA+
IFRoaXMgbWFrZXMgYWxsIEVQQyBwYWdlcyB0cmFja2VkIGluIHBlci1jZ3JvdXAgTFJVcyBhbmQg
dGhlIGdsb2JhbA0KPiA+ID4gcmVjbGFpbWVyIChrc2d4ZCkgd2lsbCBub3QgYmUgYWJsZSB0byBy
ZWNsYWltIGFueSBwYWdlcyBmcm9tIHRoZSBnbG9iYWwNCj4gPiA+IExSVS4gSG93ZXZlciwgaW4g
Y2FzZXMgb2Ygb3Zlci1jb21taXR0aW5nLCBpLmUuLCB0aGUgc3VtIG9mIGNncm91cA0KPiA+ID4g
bGltaXRzIGdyZWF0ZXIgdGhhbiB0aGUgdG90YWwgY2FwYWNpdHksIGNncm91cHMgbWF5IG5ldmVy
IHJlY2xhaW0gYnV0DQo+ID4gPiB0aGUgdG90YWwgdXNhZ2UgY2FuIHN0aWxsIGJlIG5lYXIgdGhl
IGNhcGFjaXR5LiBUaGVyZWZvcmUgYSBnbG9iYWwNCj4gPiA+IHJlY2xhbWF0aW9uIGlzIHN0aWxs
IG5lZWRlZCBpbiB0aG9zZSBjYXNlcyBhbmQgaXQgc2hvdWxkIGJlIHBlcmZvcm1lZA0KPiA+ID4g
ZnJvbSB0aGUgcm9vdCBjZ3JvdXAuDQo+ID4gPiANCj4gPiA+IE1vZGlmeSBzZ3hfcmVjbGFpbV9w
YWdlc19nbG9iYWwoKSwgdG8gcmVjbGFpbSBmcm9tIHRoZSByb290IEVQQyBjZ3JvdXANCj4gPiA+
IHdoZW4gY2dyb3VwIGlzIGVuYWJsZWQuIFNpbWlsYXIgdG8gc2d4X2Nncm91cF9yZWNsYWltX3Bh
Z2VzKCksIHJldHVybg0KPiA+ID4gdGhlIG5leHQgY2dyb3VwIHNvIGNhbGxlcnMgY2FuIHVzZSBp
dCBhcyB0aGUgbmV3IHN0YXJ0aW5nIG5vZGUgZm9yIG5leHQNCj4gPiA+IHJvdW5kIG9mIHJlY2xh
bWF0aW9uIGlmIG5lZWRlZC4NCj4gPiA+IA0KPiA+ID4gQWxzbyB1cGRhdGUgc2d4X2Nhbl9yZWNs
YWltX2dsb2JhbCgpLCB0byBjaGVjayBlbXB0aW5lc3Mgb2YgTFJVcyBvZiBhbGwNCj4gPiA+IGNn
cm91cHMgd2hlbiBFUEMgY2dyb3VwIGlzIGVuYWJsZWQsIG90aGVyd2lzZSBvbmx5IGNoZWNrIHRo
ZSBnbG9iYWwgTFJVLg0KPiA+ID4gDQo+ID4gPiBGaW5hbGx5LCBjaGFuZ2Ugc2d4X3JlY2xhaW1f
ZGlyZWN0KCksIHRvIGNoZWNrIGFuZCBlbnN1cmUgdGhlcmUgYXJlIGZyZWUNCj4gPiA+IHBhZ2Vz
IGF0IGNncm91cCBsZXZlbCBzbyBmb3J3YXJkIHByb2dyZXNzIGNhbiBiZSBtYWRlIGJ5IHRoZSBj
YWxsZXIuDQo+ID4gDQo+ID4gUmVhZGluZyBhYm92ZSwgaXQncyBub3QgY2xlYXIgaG93IHRoZSBf
bmV3XyBnbG9iYWwgcmVjbGFpbSB3b3JrcyB3aXRoDQo+ID4gbXVsdGlwbGUgTFJVcy4NCj4gPiAN
Cj4gPiBFLmcuLCB0aGUgY3VycmVudCBnbG9iYWwgcmVjbGFpbSBlc3NlbnRpYWxseSB0cmVhdHMg
YWxsIEVQQyBwYWdlcyBlcXVhbGx5DQo+ID4gd2hlbiBzY2FubmluZyB0aG9zZSBwYWdlcy4gIEZy
b20gdGhlIGFib3ZlLCBJIGRvbid0IHNlZSBob3cgdGhpcyBpcw0KPiA+IGFjaGlldmVkIGluIHRo
ZSBuZXcgZ2xvYmFsIHJlY2xhaW0uDQo+ID4gDQo+ID4gVGhlIGNoYW5nZWxvZyBzaG91bGQ6DQo+
ID4gDQo+ID4gMSkgZGVzY3JpYmUgdGhlIGhvdyBkb2VzIGV4aXN0aW5nIGdsb2JhbCByZWNsYWlt
IHdvcmssIGFuZCB0aGVuIGRlc2NyaWJlDQo+ID4gaG93IHRvIGFjaGlldmUgdGhlIHNhbWUgYmVh
aHZpb3VyIGluIHRoZSBuZXcgZ2xvYmFsIHJlY2xhaW0gd2hpY2ggd29ya3MNCj4gPiB3aXRoIG11
bHRpcGxlIExSVXM7DQo+ID4gDQo+ID4gMikgSWYgdGhlcmUncyBhbnkgYmVoYXZpb3VyIGRpZmZl
cmVuY2UgYmV0d2VlbiB0aGUgImV4aXN0aW5nIiB2cyB0aGUgIA0KPiA+ICJuZXciDQo+ID4gZ2xv
YmFsIHJlY2xhaW0sIHRoZSBjaGFuZ2Vsb2cgc2hvdWxkIHBvaW50IG91dCB0aGUgZGlmZmVyZW5j
ZSwgYW5kICANCj4gPiBleHBsYWluDQo+ID4gd2h5IHN1Y2ggZGlmZmVyZW5jZSBpcyBPSy4NCj4g
DQo+IFN1cmUgSSBjYW4gZXhwbGFpbi4gaGVyZSBpcyB3aGF0IEkgcGxhbiB0byBhZGQgZm9yIHYx
NjoNCj4gDQo+IE5vdGUgdGhlIG9yaWdpbmFsIGdsb2JhbCByZWNsYWltZXIgaGFzDQo+IG9ubHkg
b25lIExSVSBhbmQgYWx3YXlzIHNjYW5zIGFuZCByZWNsYWltcyBmcm9tIHRoZSBoZWFkIG9mIHRo
aXMgZ2xvYmFsDQo+IExSVS4gVGhlIG5ldyBnbG9iYWwgcmVjbGFpbWVyIGFsd2F5cyBzdGFydHMg
dGhlIHNjYW5uaW5nIGZyb20gdGhlIHJvb3QNCj4gbm9kZSwgb25seSBtb3ZlcyBkb3duIHRvIGl0
cyBkZXNjZW5kYW50cyBpZiBtb3JlIHJlY2xhbWF0aW9uIGlzIG5lZWRlZA0KPiBvciB0aGUgcm9v
dCBub2RlIGRvZXMgbm90IGhhdmUgU0dYX05SX1RPX1NDQU4gKDE2KSBwYWdlcyBpbiB0aGUgTFJV
Lg0KPiBUaGlzIG1ha2VzIHRoZSBlbmNsYXZlIHBhZ2VzIGluIHRoZSByb290IG5vZGUgbW9yZSBs
aWtlbHkgYmVpbmcNCj4gcmVjbGFpbWVkIGlmIHRoZXkgYXJlIG5vdCBmcmVxdWVudGx5IHVzZWQg
KG5vdCAneW91bmcnKS4gVW5sZXNzIHdlIHRyYWNrDQo+IHBhZ2VzIGluIG9uZSBMUlUgYWdhaW4s
IHdlIGNhbiBub3QgcmVhbGx5IG1hdGNoIGV4YWN0bHkgdGhlIHNhbWUNCj4gYmVoYXZpb3Igb2Yg
dGhlIG9yaWdpbmFsIGdsb2JhbCByZWNsYWltZXIuIEFuZCBvbmUtTFJVIGFwcHJvYWNoIHdvdWxk
DQo+IG1ha2UgcGVyLWNncm91cCByZWNsYW1hdGlvbiBzY2FubmluZyBhbmQgcmVjbGFpbWluZyB0
b28gY29tcGxleC4gIE9uIHRoZQ0KPiBvdGhlciBoYW5kLCB0aGlzIGRlc2lnbiBpcyBhY2NlcHRh
YmxlIGZvciBmb2xsb3dpbmcgcmVhc29uczoNCj4gDQo+IDEpIEZvciBhbGwgcHVycG9zZXMgb2Yg
dXNpbmcgY2dyb3VwcywgZW5jbGF2ZXMgd2lsbCBuZWVkIGxpdmUgaW4NCj4gICAgICAgbm9uLXJv
b3QgKGxlYWYgZm9yIGNncm91cCB2Mikgbm9kZXMgd2hlcmUgbGltaXRzIGNhbiBiZSBlbmZvcmNl
ZA0KPiAgICAgICBwZXItY2dyb3VwLg0KDQpJIGRvbid0IHNlZSBob3cgaXQgbWF0dGVycy4gIElm
IFJPT1QgaXMgZW1wdHksIHRoZW4gaXQgbW92ZXMgdG8gdGhlIGZpcnN0DQpkZXNjZW5kYW50Lg0K
DQo+IDIpIEdsb2JhbCByZWNsYW1hdGlvbiBub3cgb25seSBoYXBwZW5zIGluIHNpdHVhdGlvbiBt
ZW50aW9uZWQgYWJvdmUgd2hlbg0KPiAgICAgICBhIGxvd2VyIGxldmVsIGNncm91cCBub3QgYXQg
aXRzIGxpbWl0IGNhbid0IGFsbG9jYXRlIGR1ZSB0byBvdmVyDQo+ICAgICAgIGNvbW1pdCBhdCBn
bG9iYWwgbGV2ZWwuDQoNClJlYWxseT8gIEluIHNneF9yZWNsYWltX2RpcmVjdCgpIHRoZSBjb2Rl
IHNheXM6DQoNCi8qDQogKiBNYWtlIHN1cmUgdGhlcmUgYXJlIHNvbWUgZnJlZSBwYWdlcyBhdCBi
b3RoIGNncm91cCBhbmQgZ2xvYmFsIGxldmVscy4NCiAqIEluIGJvdGggY2FzZXMsIG9ubHkgbWFr
ZSBvbmUgYXR0ZW1wdCBvZiByZWNsYW1hdGlvbiB0byBhdm9pZCBsZW5ndGh5DQogKiBibG9jayBv
biB0aGUgY2FsbGVyLg0KICovDQoNClllYWggb25seSBvbmUgYXR0ZW1wdCB3aWxsIGJlIG1hZGUg
Zm9yIGdsb2JhbCBsZXZlbCBidXQgaXQgaXMgc3RpbGwgZ2xvYmFsDQpyZWNsYWltLg0KDQo+IDMp
IFRoZSBwYWdlcyBpbiByb290IGJlaW5nIHNsaWdodGx5IHBlbmFsaXplZCBhcmUgbm90IGJ1c2ls
eSB1c2VkDQo+ICAgICAgIGFueXdheS4NCg0KVGhlIDEpIHNheXMgaW4gcHJhY3RpY2UgdGhlIHJv
b3Qgd2lsbCBoYXZlIG5vIGVuY2xhdmVzLCB0aHVzIG5vIEVQQyBhdA0KYWxsLg0KDQpJbiBvdGhl
ciB3b3JkcywgaW4gcHJhY3RpY2UgdGhlIGdsb2JhbCByZWNsYWltIHdpbGwgYWx3YXlzIHNraXAg
dGhlIHJvb3QNCmFuZCBtb3ZlIHRvIHRoZSBmaXJzdCBkZXNjZW5kYW50Lg0KDQo+IDQpIEluIGNh
c2VzIHRoYXQgbXVsdGlwbGUgcm91bmRzIG9mIHJlY2xhbWF0aW9uIGlzIG5lZWRlZCwgdGhlIGNh
bGxlciBvZg0KPiAgICAgICBzZ3hfcmVjbGFpbV9wYWdlX2dsb2JhbCgpIGNhbiBzdGlsbCByZWNh
bGwgZm9yIHJlY2xhaW1pbmcgaW4gJ25leHQnDQo+ICAgICAgIGRlc2NlbmRhbnQgaW4gcm91bmQg
cm9iaW4gd2F5LCBlYWNoIHJvdW5kIHNjYW5zIGZvciBTR1hfTlJfU0NBTiBwYWdlcw0KPiAgICAg
ICBmcm9tIHRoZSBoZWFkIG9mICduZXh0JyBjZ3JvdXAncyBMUlUuDQoNCiJtdWx0aXBsZSByb3Vu
ZHMgb2YgcmVjbGFtYXRpb24iIGlzbid0IGNsZWFyIGVub3VnaC4gIERvZXMgaXQgbWVhbg0KbXVs
dGlwbGUgY2FsbCBvZiBzZ3hfY2dyb3VwX3JlY2xhaW1fcGFnZXMoKSwgb3IgZG9lcyBpdCBtZWFu
IGVhY2ggdHJpZ2dlcg0Kb2YgZ2xvYmFsIHJlY2xhaW0/DQoNClRoZSBjdXJyZW50IHBhdGNoIHNl
ZW1zIHRvIGJlIHRoZSBmb3JtZXIuICBTZWUgdGhlICduZXh0X2NnJyBpcyByZXNldCB0bw0KTlVM
TCBmb3IgZWFjaCBsb29wIG9mIHRoZSBtYWluIGxvb3AgaW4ga3NneGQoKS4NCg0KVGhpcyBlc3Nl
bnRpYWxseSBtZWFucyBlYWNoIHRyaWdnZXIgb2YgZ2xvYmFsIHJlY2xhaW0gd2lsbCBzdGFydCBm
cm9tIHRoZQ0KUk9PVCwgb3IgaW4gcHJhY3RpY2UgdGhlIGZpcnN0IGRlc2NlbmRhbnQgKGJhc2Vk
IG9uIDEpIGFuZCAzKSBhYm92ZSkgd2lsbA0KYWx3YXlzIGJlIHRoZSB2aWN0aW0gb2YgZWFjaCBn
bG9iYWwgcmVjbGFpbS4NCg0KSSBhZ3JlZSBpdCdzIGhhcmQgdG8gX0VYQUNUTFlfIG1hdGNoIHRo
ZSBleGlzdGluZyBnbG9iYWwgcmVjbGFpbSwgYnV0IElNSE8NCndlIHNob3VsZCBhdCBsZWFzdCB0
cmVhdHMgYWxsIGNncm91cHMgZXF1YWxseS4NCg0K

