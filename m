Return-Path: <cgroups+bounces-2673-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8AC8AE94D
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 16:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1831F22C22
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205713B293;
	Tue, 23 Apr 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtptX9/z"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527E135A73;
	Tue, 23 Apr 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882004; cv=fail; b=pIksZNjI5HMm7WrZjOGS8R8si5xK9tWw/WpnriqFj6K0sfCx7GIygth8LnnukqnUfyCq2irbNptZAir+YqSfxxUBRRYYJZD6aNqAczB1GUYgRehTrJhhuAxcE4ORGC23108ghhbSPwhDYqRntc8PW1QFXj1Ox+Kpm7W/43HlJCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882004; c=relaxed/simple;
	bh=3v4MaDUjDVqIdgtz4iwfU+xCrWhGUIqvA2BQc+9m3lk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VW34+Kg/vUscR9wJRZrRqKg17/nhSN1AqY/ZHcb9B3dFrm2+8q5sAM0JClz1UcguVyB52Wyyjx43smx50Hc6OK4Mp3a3ZHbGSebN1cfBJNXqqfwDcK23llzbeiO7tjkjh54TM/aira4chszgswyg4cQdNumoIhIIpTLMSQQmADM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtptX9/z; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713882003; x=1745418003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3v4MaDUjDVqIdgtz4iwfU+xCrWhGUIqvA2BQc+9m3lk=;
  b=MtptX9/zuzVPEMGu49CpAwwwHw/pYGsgOy87HMCHvj+ekj0N3b1apooD
   anhbXweOz00CHwjRdNJ7wKeBkBXkcp2YkRU6VbKEf7apUjhLu+6fLXXdc
   QGZs3yTZ2gXJcX+1YiTeop/QlBB67j3IkFr0mRLyWI03vT/kdQa4DPUqG
   IArBxFwUc4wuo2npjglA662M2dq1n4FX1rLSHh1zy3iVQ5ZiehbuJnk0/
   h1FgZVXkxtfiNKKbVOBCeLiGvo43iybBYA+JWUbChkOCmZLT8SHLHh6sL
   U+XAF5EvdhVOMwT7Fq6JltaxdIn8xcA9weHUk/UM3Dyi+DvTUYBiGshoM
   A==;
X-CSE-ConnectionGUID: APQF8SmuRmKWmpXcY65I4w==
X-CSE-MsgGUID: r+EJCwdeSy+0htwypDgCNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20615679"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20615679"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:20:01 -0700
X-CSE-ConnectionGUID: 1bm/8CHYRZq7jM4Ay/N0Vg==
X-CSE-MsgGUID: WMqTTYWGTquw9MwoENd1bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55578019"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 07:19:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 07:19:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 07:19:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 07:19:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 07:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWplIZECN/010BboXNQfIG6CIU1+yFRzOu4OnouyLzqXBYbPpnYnpPPE1NAGBqUPJutxg9T+AMHiEioGlLGDYZBZWvxwUc6ODKXcEsrLUlvizKlVUQjS/TQN/X1lazAuNjx/9dgXIVgepCYPQLNIWpNtpyGlkcHLD1kP5cMDwdJXjvmIBN/fZNVwMXJPJ8/o9iPHScrhcbx6f+2drJ6Y1LVFAR3csNgp1BroAo6DbI9kMYHCD8KszFuSmJ3EO0O2pcp+tdxUalXE+5l0swZYgpt0RvGqEVE2CD0ij8CYaaxR7WCfphWq2eQ32SsnQgzz5z1qyG/icmvl8ufI/SFtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v4MaDUjDVqIdgtz4iwfU+xCrWhGUIqvA2BQc+9m3lk=;
 b=fIqR7x0j1vhFeQXMlHRUh87elhicbTvrjvbwTi3G5QQB5e3pfJPyQV1kPkeB2U27met5JQlypsZVD1TdZmSRyitKxL9z15J7VIzHvQLwQgZ3FMv5CBx4T5nZkddAJT5VPo9STixh5sufNEqzfX6arJurVZhYQEthcvHj5hfx+cWnXYFBLfkuSO2zJFtul9Xd2V4LBvwLDqgh+wpWrdiVxSvYNEi93/X4tb1NRR5S7LyYJl02aQ2okJStnIhZDuWAVgNWaPI3KdH98NXrRytgpa/5E2viU8CjElfZcTWlOhnlE5aqfceI51ckU2TLa+vk+ru3RL+itIJ2liBENIwI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 14:19:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 14:19:53 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
	<tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
Thread-Topic: [PATCH v12 09/14] x86/sgx: Implement async reclamation for
 cgroup
Thread-Index: AQHaj60Hm4kuVj4TEkStIzrrR8Dgw7Fu03YAgAEjfYCAAEAagIAAKb6AgAMWJgCAAQrQgIAAZFmAgAD5LgCAABP4AA==
Date: Tue, 23 Apr 2024 14:19:53 +0000
Message-ID: <be1b1198e05a91b16677acf4037cd52519273529.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-10-haitao.huang@linux.intel.com>
	 <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
	 <op.2mhn6ti6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <4be309656cb4e03793703098bbebab3dee93077e.camel@intel.com>
	 <op.2mh5p7fawjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <e8d076fb097774f1f0fe3365883e6cf5a823fc4f.camel@intel.com>
	 <op.2mm0u7uswjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <914371bd0673870c03e5f4c37db5a2a08fc50aa4.camel@intel.com>
	 <op.2momr8oewjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2momr8oewjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB6538:EE_
x-ms-office365-filtering-correlation-id: 7824e478-6210-41be-7e9d-08dc63a071c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SDE3VE1XZ0dmNFhtTGcwdVN6clUyQ0xPV2VXODJoMjJVZE1qaU9teW95M2pJ?=
 =?utf-8?B?NE5KNzFGejNTUHEzUCtEV2dFSS9nSnBZU295dkZxWjNpYW5TYjRtOGFJOXlS?=
 =?utf-8?B?dFJrUjJsMU5OQVJESXJYdzl1MXhhUU12bTIrbFJMMzVIWUlUclNtT0UzL1Jq?=
 =?utf-8?B?N1dBWDJQNFAvVVY4ZHpxeGNISU1yWXJ1eHpLdXB1L3lUb0lUSGQ3KzNUWWgz?=
 =?utf-8?B?SnhCMUdFZTZ3OE96eVN2cEpFTzdQVGpQRVBJdTBDbklDWml2c2FmN0g3OVJG?=
 =?utf-8?B?NHFCNkllUDNGMVEvajJGU0dtcVN2bm5IdWRhYUo4N0FQZkRybXhwL0psNytH?=
 =?utf-8?B?MEdhVUs4YU9vQUdRZWVSMysyNEFzdnJFcE1tUmc1bHRSajlFc2xMMEZIeHRP?=
 =?utf-8?B?eUtnUmtrZ295cGRHRm4rc0xob0NyWjhqbHhWVGhrVmFiaWVBdDN6QURsVjlC?=
 =?utf-8?B?bFhQNVdNSE1oZTgvWCszc3puNUgyOHZIZE9RT2ZrbzVxNXpkb0RjR3B3Ui9R?=
 =?utf-8?B?T2Z4ZEhBWnkwd1BXMHhwTTdqcnpyTzBmSFZ4VHd1QTA5eUtjenU1MVBCcnpJ?=
 =?utf-8?B?M1kxVDg1R1IvZkxxQVJ1ZkZ4ejFNajYrWlhCaGRvZmkvSDIwMSsrSVRQS0Rs?=
 =?utf-8?B?a2RKNUtiRThvWHVIU0ZpUGp5Y0V5NFJxTzNUL1lyNWpMaTgwNmttUUJHdVVC?=
 =?utf-8?B?UENpRDI4RWZneStqb2RVY0V4Tko2dytaVXJnY2kvajJyblJwcnFsQi90blpB?=
 =?utf-8?B?QTZpQjN6VjZ1QkxqZlZHMVd5LzVDZmJmcTBVY2NHVGtFS3I4cTl5WXNBcDFN?=
 =?utf-8?B?M1lidkc4NlUrSWV3WncrMWNyTWNWKzIvMmRGWnpkcmpEKytMY3A1YU1IbjhJ?=
 =?utf-8?B?OTQwR3ZSaEx1NXZtQitiNlFMdVJVUk9QNEliVWFDcVJzQkFLWURGSy9SRmFU?=
 =?utf-8?B?UytyZDBPeEQybEQwSU1oWmFudlI3bHFzbTRpTVc5NDhQVVRYM3JtZTlFdHhj?=
 =?utf-8?B?YW1GOTNMNUI3ZGFQYWM3eUNoNGFNbWQ1NHVKRnhtRklROC9UbFFFYTNud1hJ?=
 =?utf-8?B?b2EyTXV0dC9nVWIwV0UvSDkvb0hhdUFEcnplR0dVVGJUbXpDYnRhUWMwZm5C?=
 =?utf-8?B?ZTJab1ZQSjV6TU1Od3h2dWtQNjBKNFdpbFVlcDBaVm91QXlxUGpLRnlvOS9P?=
 =?utf-8?B?bFJISURsVkkwUlhDOUhHRzRrWmUvLytnWTBjbTA2bG8wTE10UW1vOE9RMUNh?=
 =?utf-8?B?RjBTK1FFOUdGN3Q0TTZzR2thbVNHQmg1U3JYTkJFZlRWdWZ6LzYxQXk5NmN5?=
 =?utf-8?B?UzdxaXk5ZzlwVE5WQmxmMVRsZkhleHl3MmZTNVNUS0pYY0tmZHdUMXBaSThV?=
 =?utf-8?B?NkxUcEJOdll3WlplZUhlYk9GK3gyTTR0VVd1eWVTRmFjbWZ1aXhoeHJSTk9o?=
 =?utf-8?B?OGhHVUdIVHhuVy9WcDFSY3l0V0FvSXF0YkFhWHk0RlZ0ZnJWeTJjakRHa1Ba?=
 =?utf-8?B?aUNtNjdLZXBueElpWmh2a2l2MW5idm9IdWJjVlNVZHhMSlZyTjlzWW95SDVC?=
 =?utf-8?B?MGRSQXkzVEVCTUMxMzhwY1JoUTdNcTNvSlgwSHdXTXhhWUEvTnR5T1BERWZL?=
 =?utf-8?B?dmxuZSt0UTkxclBWU3VqRnZKbXBSWnRHQUN2bzd0TFB6eXlVSHhhaFFKYi9h?=
 =?utf-8?B?TGJLWmczYUthUW5tQzdhT1pndHMybk5ELzREZTA5MUpyaXFuZkFYWlBxSFdB?=
 =?utf-8?B?Q1FZdWU2YVJPUUF1am0yUGdhejVQSHlpRDh2OEJHWjV3V3YyUU45UHJwd2Rv?=
 =?utf-8?Q?nsreXh5Xmbv3JwhpfF4vsw0Flv+iSR1oOavBA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGJYbFY5Vk1ybzVMZTVEM3Z4S1NCV0V5NjJ3NVBTVG91M1RDNWg5dlhsZlYv?=
 =?utf-8?B?UDh4RmV2QmJuZU1rdW9CQVpXdHF1WE1MTitKR2ZFWVlmNXp2dVp0dzRpYzQ5?=
 =?utf-8?B?c3k0OUt0MjFZNStLWjVqamYyUkhZaW5qcDN5MWRhMGhRU0g2QXRxWlo2clBF?=
 =?utf-8?B?UjNZV0pQcW9GWHZFb0NSVkxOV3gxQUplRzh3a1BuZ01saVJqMHhBUHJKSlR3?=
 =?utf-8?B?NjhWcmtUcnE3SitvNFBNdk9QSWh1Vk00QWlZNjZ0a3hDcUdEbEtyOS9tWXgw?=
 =?utf-8?B?N3dhUHdqdmtERjhrdW9ITkkwaUdJZmVnNFh3UnY2Nkk2M0E2SVVVY3U4ZEx1?=
 =?utf-8?B?YTRmVXhNMU5IOEVQS0JleWFtVWVmZStpOTZsb2t3eWtNS1NKZ3diYjNUbTB1?=
 =?utf-8?B?L3RmMjhUUFd6Z0Z5NWliNTgzV1E4eWVhSXg2d0RTUFJWK2ZpSFZubmpPdXlU?=
 =?utf-8?B?akRTS0h0aVk0Y0NoaXFPM0Y4WVdwZTJNSVVaT1huM3dhTlk1SkJIWDZsRm1j?=
 =?utf-8?B?eGJHeG9TUlpRUjhlckpXWHZoOHVzdk56Qm53a1VhbFJ1WWFGNGJkOHp3aHpD?=
 =?utf-8?B?bTNYMWhFRmZWYXJhVjNvY085RVduY3p0U0FtN1VYd3l2dHpDSFh5dFJONFc5?=
 =?utf-8?B?KzRzR2ozRjlJVGdMZVJCVk1SK0JDYlhGdmh5NmJiVG9RMzBLZ3NOY0hqZmVy?=
 =?utf-8?B?dlRrSnppOVNsUXZGSHE3bmlBVUJjOXI4bVU5SjVBM2ZKV25NZTE4NmFSVlpY?=
 =?utf-8?B?SkFKUkM2TWFET3Z1VXBPQUEwekF3Ti9NOVowU2VFOGFHNDNWdzExM0RsRVBi?=
 =?utf-8?B?NkFWV2ZKbGRVSW9UYzBJb21vY0Jxd0FTcVRvdmlXNkRFem1KRXV0bndreFNw?=
 =?utf-8?B?YlJESVdqRmhJeTc0THdPZERvcmovci9FQTJxNGdGU3JNWE15aDRYVk5OUEJY?=
 =?utf-8?B?ekp0c0ppUEcxdStndnFpcVNqKysxSkV5b3A3WDd0RDlLcHVIcjNHZmh4N3h1?=
 =?utf-8?B?amd0VTM0V0tWZjZUaEtDcFc1b201cllrdHVwc0Q1MWFieUZpZDR4a1lvaCtX?=
 =?utf-8?B?SnR1WDNoNzRqUi9BMzQ4WURoWFEzQ0tDR1JwazVUZG9XSGZaMndwSkR4Z0dD?=
 =?utf-8?B?cy9wSnRrMnJmdmhwV3J4ZlN1MjU1NDN3b3BKOCtKd1NMQisyd1UrMVVUVzMz?=
 =?utf-8?B?K1ZJQkZZSFBkNEdJZ1NDOFZ1L0tGb1dvYnZQc05oblFoaENpWVgwTnlnbTVP?=
 =?utf-8?B?ZGRBQXJ5NWw0ZXNGNnA0VzJpT2IxMm5DdU5tZTJVeUF2dUhEdjVKSklUWTU3?=
 =?utf-8?B?NjVnV1h1ZWd6WXJGMlBGM2JJWUNvWUcxWUJ6UjJ0UHpwUWtDTWNBa2w3b0Ft?=
 =?utf-8?B?OVRqM09ReWZtL0NzeW9Vd3kvVE5uelBRaEh2MHRBZThBbzhNK1JWOWdqdmpD?=
 =?utf-8?B?ZFV0bDJLVXpXY0pVN3FOTUYrWkJJVVorYVM3Y1ZxZE90V1o5VEtWR1FhWjZl?=
 =?utf-8?B?WVNSdU5SelNacFJBZlFNcnVaVElFM3JGZ09uUDF5OHZ2TkZsMldVWGI0Qy96?=
 =?utf-8?B?aXEwRVNsSEluTHQxeUpac2Y2aDYvdUcyUjNETnRjRW5hTElvU2o5OEEvRGtV?=
 =?utf-8?B?N2hXODNjM0pydmFrUG5ESHBqb0tFS0hjVGhVOGNKSzdKSGRDR3lBU3FqaXJq?=
 =?utf-8?B?RHVVN3U2ZlFCMTF6aVA0cDM4WWpCMlBKUG1SU1lSV3FmNnJwcWUvaDYrOEFK?=
 =?utf-8?B?OHNPNmhhdDNhUjZTOUxpcnp4QitrTG1GOUpJWk41L2RZVGRISVNpNmN4MDZK?=
 =?utf-8?B?bjFDWUlVY3JmMTRFRnptY0lBRm85RVlmWmd1N0oxNnRYaEgrUXdHNFZoa3Iy?=
 =?utf-8?B?anZJUG16aEdROHcrQ1NBTEYzbXk2MndlWWVaQ0JSc2hteXlzd0xTTG9qMEVM?=
 =?utf-8?B?dTRhajVaZysxb1pIazNoN0Y1VlpYbjdtQXQyOGVycjNkTXMwY3c1bk5UbmI3?=
 =?utf-8?B?MDFpeXdEZ3JTWDB3UlpxdEozUGtpL2x1WEFBSkZSZFF6T282ME9oM2t1NGg5?=
 =?utf-8?B?NmRNYWdHWGtFYk90ZjRGTEt0SkU2MFdNMGFxQU1RNDlHTEFjQW55MmREaGxC?=
 =?utf-8?B?cHlza0xZZEs3NFZnblpCRTUvK2lKMS9iWTl4UXdDMWtwYm1rVHdpRlV0ejZ5?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <236CCAA07CCE0440AC3860864EBD66BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7824e478-6210-41be-7e9d-08dc63a071c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 14:19:53.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7mX3Xbckg6DTdyvGk4LahzTdFpBYkpCwR6vD6VVNwkcG9mEhB578isP3X4mbeRo08JPMMU3Iz43d2bDcuy4Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDA4OjA4IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIE1vbiwgMjIgQXByIDIwMjQgMTc6MTY6MzQgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBNb24sIDIwMjQtMDQtMjIgYXQgMTE6MTcg
LTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IE9uIFN1biwgMjEgQXByIDIwMjQgMTk6
MjI6MjcgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFuZ0BpbnRlbC5jb20+ICANCj4gPiA+IHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiA+IE9uIEZyaSwgMjAyNC0wNC0xOSBhdCAyMDoxNCAtMDUwMCwg
SGFpdGFvIEh1YW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBJIHRoaW5rIHdlIGNhbiBhZGQgc3Vw
cG9ydCBmb3IgInNneF9jZ3JvdXA9ZGlzYWJsZWQiIGluIGZ1dHVyZSAgDQo+ID4gPiBpZg0KPiA+
ID4gPiA+IGluZGVlZA0KPiA+ID4gPiA+ID4gPiBuZWVkZWQuIEJ1dCBqdXN0IGZvciBpbml0IGZh
aWx1cmUsIG5vPw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSXQn
cyBub3QgYWJvdXQgdGhlIGNvbW1hbmRsaW5lLCB3aGljaCB3ZSBjYW4gYWRkIGluIHRoZSBmdXR1
cmUgIA0KPiA+ID4gd2hlbg0KPiA+ID4gPiA+ID4gbmVlZGVkLiAgSXQncyBhYm91dCB3ZSBuZWVk
IHRvIGhhdmUgYSB3YXkgdG8gaGFuZGxlIFNHWCBjZ3JvdXAgIA0KPiA+ID4gYmVpbmcNCj4gPiA+
ID4gPiA+IGRpc2FibGVkIGF0IGJvb3QgdGltZSBuaWNlbHksIGJlY2F1c2Ugd2UgYWxyZWFkeSBo
YXZlIGEgY2FzZSAgDQo+ID4gPiB3aGVyZSB3ZQ0KPiA+ID4gPiA+ID4gbmVlZA0KPiA+ID4gPiA+
ID4gdG8gZG8gc28uDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFlvdXIgYXBwcm9hY2ggbG9v
a3MgaGFsZi13YXkgdG8gbWUsIGFuZCBpcyBub3QgZnV0dXJlICANCj4gPiA+IGV4dGVuZGlibGUu
ICBJZg0KPiA+ID4gPiA+IHdlDQo+ID4gPiA+ID4gPiBjaG9vc2UgdG8gZG8gaXQsIGRvIGl0IHJp
Z2h0IC0tIHRoYXQgaXMsIHdlIG5lZWQgYSB3YXkgdG8gZGlzYWJsZSAgDQo+ID4gPiBpdA0KPiA+
ID4gPiA+ID4gY29tcGxldGVseSBpbiBib3RoIGtlcm5lbCBhbmQgdXNlcnNwYWNlIHNvIHRoYXQg
dXNlcnNwYWNlIHdvbid0IGJlDQo+ID4gPiA+ID4gYWJsZT4gdG8NCj4gPiA+ID4gPiA+IHNlZSBp
dC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGF0IHdvdWxkIG5lZWQgbW9yZSBjaGFuZ2VzIGlu
IG1pc2MgY2dyb3VwIGltcGxlbWVudGF0aW9uIHRvICANCj4gPiA+IHN1cHBvcnQNCj4gPiA+ID4g
PiBzZ3gtZGlzYWJsZS4gUmlnaHQgbm93IG1pc2MgZG9lcyBub3QgaGF2ZSBzZXBhcmF0ZSBmaWxl
cyBmb3IgIA0KPiA+ID4gZGlmZmVyZW50DQo+ID4gPiA+ID4gcmVzb3VyY2UgdHlwZXMuIFNvIHdl
IGNhbiBvbmx5IGJsb2NrIGVjaG8gInNneF9lcGMuLi4iIHRvIHRob3NlDQo+ID4gPiA+ID4gaW50
ZXJmYWNlZmlsZXMsIGNhbid0IHJlYWxseSBtYWtlIGZpbGVzIG5vdCB2aXNpYmxlLg0KPiA+ID4g
PiANCj4gPiA+ID4gIndvbid0IGJlIGFibGUgdG8gc2VlIiBJIG1lYW4gIm9ubHkgZm9yIFNHWCBF
UEMgcmVzb3VyY2UiLCBidXQgbm90IHRoZQ0KPiA+ID4gPiBjb250cm9sIGZpbGVzIGZvciB0aGUg
ZW50aXJlIE1JU0MgY2dyb3VwLg0KPiA+ID4gPiANCj4gPiA+ID4gSSByZXBsaWVkIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgdGhlIHByZXZpb3VzIHJlcGx5Og0KPiA+ID4gPiANCj4gPiA+ID4gIg0KPiA+
ID4gPiBHaXZlbiBTR1ggRVBDIGlzIGp1c3Qgb25lIHR5cGUgb2YgTUlTQyBjZ3JvdXAgcmVzb3Vy
Y2VzLCB3ZSBjYW5ub3QgIA0KPiA+ID4ganVzdA0KPiA+ID4gPiBkaXNhYmxlIE1JU0MgY2dyb3Vw
IGFzIGEgd2hvbGUuDQo+ID4gPiA+ICINCj4gPiA+ID4gDQo+ID4gPiBTb3JyeSBJIG1pc3NlZCB0
aGlzIHBvaW50LiBiZWxvdy4NCj4gPiA+IA0KPiA+ID4gPiBZb3UganVzdCBuZWVkIHRvIHNldCB0
aGUgU0dYIEVQQyAiY2FwYWNpdHkiIHRvIDAgdG8gZGlzYWJsZSBTR1ggRVBDLiAgIA0KPiA+ID4g
U2VlDQo+ID4gPiA+IHRoZSBjb21tZW50IG9mIEBtaXNjX3Jlc19jYXBhY2l0eToNCj4gPiA+ID4g
DQo+ID4gPiA+ICAqIE1pc2NlbGxhbmVvdXMgcmVzb3VyY2VzIGNhcGFjaXR5IGZvciB0aGUgZW50
aXJlIG1hY2hpbmUuIDAgY2FwYWNpdHkNCj4gPiA+ID4gICogbWVhbnMgcmVzb3VyY2UgaXMgbm90
IGluaXRpYWxpemVkIG9yIG5vdCBwcmVzZW50IGluIHRoZSBob3N0Lg0KPiA+ID4gPiANCj4gPiA+
IA0KPiA+ID4gSUlVQyBJIGRvbid0IHRoaW5rIHRoZSBzaXR1YXRpb24gd2UgaGF2ZSBpcyBlaXRo
ZXIgb2YgdGhvc2UgY2FzZXMuIEZvciAgDQo+ID4gPiBvdXINCj4gPiA+IGNhc2UsIHJlc291cmNl
IGlzIGluaXRlZCBhbmQgcHJlc2VudCBvbiB0aGUgaG9zdCBidXQgd2UgaGF2ZSBhbGxvY2F0aW9u
DQo+ID4gPiBlcnJvciBmb3Igc2d4IGNncm91cCBpbmZyYS4NCj4gPiANCj4gPiBZb3UgaGF2ZSBj
YWxjdWxhdGVkIHRoZSAiY2FwYWNpdHkiLCBidXQgbGF0ZXIgeW91IGZhaWxlZCBzb21ldGhpbmcg
YW5kDQo+ID4gdGhlbiByZXNldCB0aGUgImNhcGFjaXR5IiB0byAwLCBpLmUuLCBjbGVhbnVwLiAg
V2hhdCdzIHdyb25nIHdpdGggdGhhdD8NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiBBbmQgImJsb2Nr
aW5nIGVjaG8gc2d4X2VwYyAuLi4gdG8gdGhvc2UgY29udHJvbCBmaWxlcyIgaXMgYWxyZWFkeQ0K
PiA+ID4gPiBzdWZmaWNpZW50IGZvciB0aGUgcHVycG9zZSBvZiBub3QgZXhwb3NpbmcgU0dYIEVQ
QyB0byB1c2Vyc3BhY2UsICANCj4gPiA+IGNvcnJlY3Q/DQo+ID4gPiA+IA0KPiA+ID4gPiBFLmcu
LCBpZiBTR1ggY2dyb3VwIGlzIGVuYWJsZWQsIHlvdSBjYW4gc2VlIGJlbG93IHdoZW4geW91IHJl
YWQgIm1heCI6DQo+ID4gPiA+IA0KPiA+ID4gPiAgIyBjYXQgL3N5cy9mcy9jZ3JvdXAvbXlfZ3Jv
dXAvbWlzYy5tYXgNCj4gPiA+ID4gICMgPHJlc291cmNlMT4gPG1heDE+DQo+ID4gPiA+ICAgIHNn
eF9lcGMgLi4uDQo+ID4gPiA+ICAgIC4uLg0KPiA+ID4gPiANCj4gPiA+ID4gT3RoZXJ3aXNlIHlv
dSB3b24ndCBiZSBhYmxlIHRvIHNlZSAic2d4X2VwYyI6DQo+ID4gPiA+IA0KPiA+ID4gPiAgIyBj
YXQgL3N5cy9mcy9jZ3JvdXAvbXlfZ3JvdXAvbWlzYy5tYXgNCj4gPiA+ID4gICMgPHJlc291cmNl
MT4gPG1heDE+DQo+ID4gPiA+ICAgIC4uLg0KPiA+ID4gPiANCj4gPiA+ID4gQW5kIHdoZW4geW91
IHRyeSB0byB3cml0ZSB0aGUgIm1heCIgZm9yICJzZ3hfZXBjIiwgeW91IHdpbGwgaGl0IGVycm9y
Og0KPiA+ID4gPiANCj4gPiA+ID4gICMgZWNobyAic2d4X2VwYyAxMDAiID4gL3N5cy9mcy9jZ3Jv
dXAvbXlfZ3JvdXAvbWlzYy5tYXgNCj4gPiA+ID4gICMgLi4uIGVjaG86IHdyaXRlIGVycm9yOiBJ
bnZhbGlkIGFyZ3VtZW50DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgYWJvdmUgYXBwbGllcyB0byBh
bGwgdGhlIGNvbnRyb2wgZmlsZXMuICBUbyBtZSB0aGlzIGlzIHByZXR0eSBtdWNoDQo+ID4gPiA+
IG1lYW5zICJTR1ggRVBDIGlzIGRpc2FibGVkIiBvciAibm90IHN1cHBvcnRlZCIgZm9yIHVzZXJz
cGFjZS4NCj4gPiA+ID4gDQo+ID4gPiBZb3UgYXJlIHJpZ2h0LCBjYXBhY2l0eSA9PSAwIGRvZXMg
YmxvY2sgZWNob2luZyBtYXggYW5kIHVzZXJzIHNlZSBhbiAgDQo+ID4gPiBlcnJvcg0KPiA+ID4g
aWYgdGhleSBkbyB0aGF0LiBCdXQgMSkgZG91YnQgeW91IGxpdGVyYXRlbHkgd2FudGVkICJTR1gg
RVBDIGlzICANCj4gPiA+IGRpc2FibGVkIg0KPiA+ID4gYW5kIG1ha2UgaXQgdW5zdXBwb3J0ZWQg
aW4gdGhpcyBjYXNlLA0KPiA+IA0KPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZC4gIFNvbWV0aGluZyBm
YWlsZWQgZHVyaW5nIFNHWCBjZ3JvdXAgaW5pdGlhbGl6YXRpb24sDQo+ID4geW91IF9saXRlcmFs
bHlfIGNhbm5vdCBjb250aW51ZSB0byBzdXBwb3J0IGl0Lg0KPiA+IA0KPiA+IA0KPiANCj4gVGhl
biB3ZSBzaG91bGQganVzdCByZXR1cm4gLUVOT01FTSBmcm9tIHNneF9pbml0KCkgd2hlbiBzZ3gg
Y2dyb3VwICANCj4gaW5pdGlhbGl6YXRpb24gZmFpbHM/DQo+IEkgdGhvdWdodCB3ZSBvbmx5IGRp
c2FibGUgU0dYIGNncm91cCBzdXBwb3J0LiBTR1ggY2FuIHN0aWxsIHJ1bi4NCg0KSSBhbSBub3Qg
c3VyZSBob3cgeW91IGdvdCB0aGlzIGNvbmNsdXNpb24uICBJIHNwZWNpZmljYWxseSBzYWlkIHNv
bWV0aGluZw0KZmFpbGVkIGR1cmluZyBTR1ggImNncm91cCIgaW5pdGlhbGl6YXRpb24sIHNvIG9u
bHkgU0dYICJjZ3JvdXAiIG5lZWRzIHRvDQpiZSBkaXNhYmxlZCwgbm90IFNHWCBhcyBhIHdob2xl
Lg0KDQo+IA0KPiA+ID4gMikgZXZlbiBpZiB3ZSBhY2NlcHQgdGhpcyBpcyAic2d4DQo+ID4gPiBj
Z3JvdXAgZGlzYWJsZWQiIEkgZG9uJ3Qgc2VlIGhvdyBpdCBpcyBtdWNoIGJldHRlciB1c2VyIGV4
cGVyaWVuY2UgdGhhbg0KPiA+ID4gY3VycmVudCBzb2x1dGlvbiBvciByZWFsbHkgaGVscHMgdXNl
ciBiZXR0ZXIuDQo+ID4gDQo+ID4gSW4geW91ciB3YXksIHRoZSB1c2Vyc3BhY2UgaXMgc3RpbGwg
YWJsZSB0byBzZWUgInNneF9lcGMiIGluIGNvbnRyb2wgIA0KPiA+IGZpbGVzDQo+ID4gYW5kIGlz
IGFibGUgdG8gdXBkYXRlIHRoZW0uICBTbyBmcm9tIHVzZXJzcGFjZSdzIHBlcnNwZWN0aXZlIFNH
WCBjZ3JvdXAgIA0KPiA+IGlzDQo+ID4gZW5hYmxlZCwgYnV0IG9idmlvdXNseSB1cGRhdGluZyB0
byAibWF4IiBkb2Vzbid0IGhhdmUgYW55IGltcGFjdC4gIFRoaXMNCj4gPiB3aWxsIGNvbmZ1c2Ug
dXNlcnNwYWNlLg0KPiA+IA0KPiA+ID4gDQo+IA0KPiBTZXR0aW5nIGNhcGFjaXR5IHRvIHplcm8g
YWxzbyBjb25mdXNlcyB1c2VyIHNwYWNlLiBTb21lIGFwcGxpY2F0aW9uIG1heSAgDQo+IHJlbHkg
b24gdGhpcyBmaWxlIHRvIGtub3cgdGhlIGNhcGFjaXR5Lg0KDQoNCldoeT8/DQoNCkFyZSB5b3Ug
c2F5aW5nIGJlZm9yZSB0aGlzIFNHWCBjZ3JvdXAgcGF0Y2hzZXQgdGhvc2UgYXBwbGljYXRpb25z
IGNhbm5vdA0KcnVuPw0KDQo+IA0KPiA+ID4gQWxzbyB0byBpbXBsZW1lbnQgdGhpcyBhcHByb2Fj
aCwgYXMgeW91IG1lbnRpb25lZCwgd2UgbmVlZCB3b3JrYXJvdW5kICANCj4gPiA+IHRoZQ0KPiA+
ID4gZmFjdCB0aGF0IG1pc2NfdHJ5X2NoYXJnZSgpIGZhaWxzIHdoZW4gY2FwYWNpdHkgc2V0IHRv
IHplcm8sIGFuZCBhZGRpbmcNCj4gPiA+IGNvZGUgdG8gcmV0dXJuIHJvb3QgYWx3YXlzPw0KPiA+
IA0KPiA+IFdoeSB0aGlzIGlzIGEgcHJvYmxlbT8NCj4gPiANCj4gDQo+IEl0IGNoYW5nZXMvb3Zl
cnJpZGVzIHRoZSB0aGUgb3JpZ2luYWwgbWVhbmluZyBvZiBjYXBhY2l0eT09MDogbm8gb25lIGNh
biAgDQo+IGFsbG9jYXRlIGlmIGNhcGFjaXR5IGlzIHplcm8uDQoNCldoeT8/DQoNCkFyZSB5b3Ug
c2F5aW5nIGJlZm9yZSB0aGlzIHNlcmllcywgbm8gb25lIGNhbiBhbGxvY2F0ZSBFUEMgcGFnZT8N
Cg0KPiANCj4gPiA+IFNvIGl0IHNlZW1zIGxpa2UgbW9yZSB3b3JrYXJvdW5kIGNvZGUgdG8ganVz
dA0KPiA+ID4gbWFrZSBpdCB3b3JrIGZvciBhIGZhaWxpbmcgY2FzZSBubyBvbmUgcmVhbGx5IGNh
cmUgbXVjaCBhbmQgZW5kIHJlc3VsdCAgDQo+ID4gPiBpcw0KPiA+ID4gbm90IHJlYWxseSBtdWNo
IGJldHRlciBJTUhPLg0KPiA+IA0KPiA+IEl0J3Mgbm90IHdvcmthcm91bmQsIGl0J3MgdGhlIHJp
Z2h0IHRoaW5nIHRvIGRvLg0KPiA+IA0KPiA+IFRoZSByZXN1bHQgaXMgdXNlcnNwYWNlIHdpbGwg
c2VlIGl0IGJlaW5nIGRpc2FibGVkIHdoZW4ga2VybmVsIGRpc2FibGVzDQo+ID4gaXQuDQo+ID4g
DQo+ID4gDQo+IEl0J3MgYSB3b3JrYXJvdW5kIGJlY2F1c2UgeW91IHVzZSB0aGUgY2FwYWNpdHk9
PTAgYnV0IGl0IGRvZXMgbm90IHJlYWxseSAgDQo+IG1lYW4gdG8gZGlzYWJsZSB0aGUgbWlzYyBj
Z3JvdXAgZm9yIHNwZWNpZmljIHJlc291cmNlIElJVUMuDQoNClBsZWFzZSByZWFkIHRoZSBjb21t
ZW50IGFyb3VuZCBAbWlzY19yZXNfY2FwYWNpdHkgYWdhaW46DQoNCiAqIE1pc2NlbGxhbmVvdXMg
cmVzb3VyY2VzIGNhcGFjaXR5IGZvciB0aGUgZW50aXJlIG1hY2hpbmUuIDAgY2FwYWNpdHkNCiAq
IG1lYW5zIHJlc291cmNlIGlzIG5vdCBpbml0aWFsaXplZCBvciBub3QgcHJlc2VudCBpbiB0aGUg
aG9zdC4NCg0KPiANCj4gVGhlcmUgaXMgZXhwbGljaXQgd2F5IGZvciB1c2VyIHRvIGRpc2FibGUg
bWlzYyB3aXRob3V0IHNldHRpbmcgY2FwYWNpdHkgdG8gIA0KPiB6ZXJvLsKgDQo+IA0KDQpXaGlj
aCB3YXkgYXJlIHlvdSB0YWxraW5nIGFib3V0Pw0KDQo+IFNvIGluIGZ1dHVyZSBpZiB3ZSB3YW50
IHJlYWxseSBkaXNhYmxlIHNneF9lcGMgY2dyb3VwIHNwZWNpZmljYWxseSAgDQo+IHdlIHNob3Vs
ZCBub3QgdXNlIGNhcGFjaXR5LiAgVGhlcmVmb3JlIHlvdXIgYXBwcm9hY2ggaXMgbm90ICANCj4g
ZXh0ZW5zaWJsZS9yZXVzYWJsZS4NCj4gDQo+IEdpdmVuIHRoaXMgaXMgYSByYXJlIGNvcm5lciBj
YXNlIGNhdXNlZCBieSBjb25maWd1cmF0aW9uLCB3ZSBjYW4gb25seSBkbyAgDQo+IGFzIG11Y2gg
YXMgcG9zc2libGUgSU1ITywgbm90IHRyeWluZyB0byBpbXBsZW1lbnQgYSBwZXJmZWN0IHNvbHV0
aW9uIGF0ICANCj4gdGhlIG1vbWVudC4gTWF5YmUgQlVHX09OKCkgaXMgbW9yZSBhcHByb3ByaWF0
ZT8NCj4gDQoNCkkgdGhpbmsgSSB3aWxsIHJlcGx5IHRoaXMgdGhyZWFkIGZvciB0aGUgbGFzdCB0
aW1lOg0KDQpJIGRvbid0IGhhdmUgc3Ryb25nIG9waW5pb24gdG8gYWdhaW5zdCB1c2luZyBCVUdf
T04oKSB3aGVuIHlvdSBmYWlsIHRvDQphbGxvY2F0ZSB3b3JrcXVldWUuICBJZiB5b3UgY2hvb3Nl
IHRvIGRvIHRoaXMsIEknbGwgbGVhdmUgdG8gb3RoZXJzLg0KDQpJZiB5b3Ugd2FudCB0byAiZGlz
YWJsZSBTR1ggY2dyb3VwIiB3aGVuIHlvdSBmYWlsIHRvIGFsbG9jYXRlIHdvcmtxdWV1ZSwNCnJl
c2V0IHRoZSAiY2FwYWNpdHkiIHRvIDAgdG8gZGlzYWJsZSBpdC4NCg==

