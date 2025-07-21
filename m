Return-Path: <cgroups+bounces-8791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708AB0C39D
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42A67A5F85
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C72BDC09;
	Mon, 21 Jul 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnrBuYJ1"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9A2BCF7C;
	Mon, 21 Jul 2025 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098531; cv=fail; b=t36DjLLz73II3UFz5qOMWhTIUisaXOkA9S3vwD87hiQWE5fEixaA1sUgZlum9hCrbs5Hjw7TcfdHMKvgRryaKaMe2+exsWImXA6v24Zayfp2ek8GpesKkY5WYCGXhOc5GHrJZfmPc3mUAmzbVW2D7Zi3U0Lxya14kuAfP4OkT4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098531; c=relaxed/simple;
	bh=4laiQCPTVxa6IhCXhBgvoZ7d89j8T+b0cUNPjl3hXJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQ5CITbZ7X4eL0DQXgwz0JcIO22Njy0W4l+ltwFu+IXQLskcoHJXI3H/kC0RgfWSGX2V5RFVZE1qZcWNwUOduA325K+HZGNSv6Ewczq5Dr6Mh8peo+hXxm5Y69gcDeGqLSyrVrpr1PvfWIB/wzL2mXVOdNQ1BjJb0bYRNprdoiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnrBuYJ1; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753098530; x=1784634530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4laiQCPTVxa6IhCXhBgvoZ7d89j8T+b0cUNPjl3hXJ8=;
  b=bnrBuYJ1WlzBA3C1mGa3uhj9uFb5ifykuRUIKuBcLiLeleajoFcwYqcS
   ErXx2J4qd5afFx/HopKcIh/e4eUXRNhR7ztNX9bwwZjWOIzhxshOq6X0t
   lYDmTip1tgal2oiYao8jDkxR0zkFyEIIkIY3LVIUu8vFAqvix9QgCD/Xn
   UbnxPG2MPMTF/7EcLajJJuiOO93TAgG+t5NM8uqJ/TrTpvrcVtBj13Zej
   /qPL8m7Uz/6c21M+M04jyu2gF3MIi6UwvXE1u5yNJpTiIcuPl1Pi9JjYq
   YMr3FBYn2+oSnGIUSN93XZsTCDAK8CYXklDqlenYRJWqSO/MxH8fLk/c1
   w==;
X-CSE-ConnectionGUID: w78zrKsMSLirkqWYUBNX1Q==
X-CSE-MsgGUID: aaiZLbRqQf+3/ufiOUhcww==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55404434"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55404434"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:48:49 -0700
X-CSE-ConnectionGUID: e/2jrrlmQWOE8a6Pde9rHA==
X-CSE-MsgGUID: bGrl5KxzQ8+qYAzDUJ6fXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="159249166"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:48:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 04:48:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 04:48:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.78) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 21 Jul 2025 04:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiZkjj64V2xk7rhvRo1GkzI94eu/pn378/1Sx1P8eR3rTkjQawSRerez2l5kaYMVTBQJetsaslWF+0p7zXgjllChMLZeUA2xWgJ++QL7PELTKeQBPx5EdiviacjKCSnvup+VMnAttle4ImxDGelbMShTelcnfwQXAyv+skx6eMyjygOUzzwwzsx03jArgieYk1kRZedhJIWx5/GVkdnAVHu13lR62Ur8YWepMdWr6OqWGUeQF2565i5ZKM5w//+RGWGRz2S4TdIrO9DKU7qe6Q9yPfKoH7QUn55zn+/mqZSNMaT+IKX3p/IFoKMrT+mvYU8oOfqWd3DqAkOdGtfEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwSeY8ya9EV5VjINp9/G/GcY5+TkshWyo7ChDhfzZX4=;
 b=FuI/MuRPgDv2xvm82l9999pIv18V6dZfD6tAXWQxPBqzAIjO5otQslhxH6UZ8tD/Le/jWnGQI5+ZstUlp8blf2TdMA8dA9F/xGXYbyl0Jwi0SDl+fLpwDXghRG0amVuOHo5KQVhC4B7a0r5jvSydRngGxzAGWZ/+Pql4voplOpleRN3AQ2vsEaFVTc4+NvPn94k8UMzDwsdS8N7U+NdrjXCLcuYjcCGOCyvQMhCm7Q1PtCB3ewihyFZJ0a22rp7XGq4G5VvN2osU/PiDrF53myqApI1Cs2zmlNCjwrn5esAO2YSRK0mm/9zgUyvbI2Ow8o1oBUCV+auMKaaTHffzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17)
 by CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 11:48:45 +0000
Received: from CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a]) by CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a%3]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 11:48:45 +0000
From: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: Shakeel Butt <shakeel.butt@linux.dev>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"inwardvessel@gmail.com" <inwardvessel@gmail.com>
Subject: RE: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Topic: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Index: AQHb5RcNKOjgP8rvyEWnUhbN1DoTcLQV00mAgAEXB3CAAFLRAIAEgU7QgAAkKICABfAQIIAAfXeAgBpP8MA=
Date: Mon, 21 Jul 2025 11:48:45 +0000
Message-ID: <CH3PR11MB7894B117C6A19C547F28EDA1F15DA@CH3PR11MB7894.namprd11.prod.outlook.com>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
 <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aF7L8jRkWm1TrwSu@slm.duckdns.org>
 <CH3PR11MB7894D2570AEA9AB67DBF706DF146A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aGKxvQdAZ-vSd48D@slm.duckdns.org>
 <CH3PR11MB7894766BBF3A24A4174D41A5F142A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aGgWG_eSHVxntfEh@slm.duckdns.org>
In-Reply-To: <aGgWG_eSHVxntfEh@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7894:EE_|CH3PR11MB7868:EE_
x-ms-office365-filtering-correlation-id: 0b039cd0-2c15-4573-3390-08ddc84c8c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|42112799006|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zn63ke5IgVYtiuhkNakI3TXYBsBaGe8YFZ1PYI12TlyZ9xBsxU0ydD2KfnYE?=
 =?us-ascii?Q?QxbqlU5gljqeGCEnSi3qX/7sFI3CmZsDbebgr6PAyMkUwqTYs44Ig4Xc7Qkl?=
 =?us-ascii?Q?6KzNllnFDI9WunDOCbYq+24J9HuEM8XqJ6ctzs7Q/3GApJUqPamYygh4SS96?=
 =?us-ascii?Q?bVoDhOfE63ILTOO8XNecNmzlF4YFkKV8mZs3KCrEdizSmUXq6JOc4XsAa8T4?=
 =?us-ascii?Q?Fny2Hkm56wpAYDPwcM1Rf6HqZsC2Mn8oqRew4VTcuxBC4y6GLzWRf1fvTIPQ?=
 =?us-ascii?Q?+dUR/+uygmjtmyfINj6M0gmkmFfSZTNKWcrC4WEQkEVke7mXEVfEKbK9rsq5?=
 =?us-ascii?Q?ad7iWVJcm59HbodJqFpQ3BzBpWkJUV0u1JSOrQ8qVBfWolyI7frebUq1VhEI?=
 =?us-ascii?Q?S4bVq9oHoxi2jgAOZ6boSmZUrsx/LnPvR+UWKKuBA6bY8rseJ9xl/0ST0s3H?=
 =?us-ascii?Q?+VE5m79VZADHT6v2VfC33n3Epgk15PiO5gP60jDD8X4WsQ0MVWO+uVkAuBFX?=
 =?us-ascii?Q?bdNSa3mO2kdWdmmo6nrr0w1Y9pKX9BrSQENF5J+ph7ZXDSNS0N21hechEvgY?=
 =?us-ascii?Q?4DOKgH4F8hVS/NWP8kYC+6tNt1himARo4UItU7jZl29rEpH4TyiC2lozkoiD?=
 =?us-ascii?Q?oc1SpRA4chzkXgbMJYOctsFhs2c1NfpKDnKxPErmssdy0PGw5jaoo0qfsNox?=
 =?us-ascii?Q?5vyXr6Me5D5/ZLKgPmaMlvnACGeLZZTET3crhvPXsmppEpxqSBGTFeVsH1vd?=
 =?us-ascii?Q?8TYK7OVdl+5Tg1/xx6VpMvcMqJPieWWiW766jISu6Wi9QVKkrQ+lWZSRxzJy?=
 =?us-ascii?Q?Rdp9960uibqIefXVVciLFM3670ctsoTSPzfppFze+6rLZE9GGnu7LGwjYOLI?=
 =?us-ascii?Q?rSqE3v80emVVYMOIK6GmserwK5DROB2EtqmNDADUtVi9K9I8WWLt8/TGmryY?=
 =?us-ascii?Q?8dLrayQ+5ostJprxTmG89Li5JEWxHT9dEuY0m9upukG/BeOc+7CMkrDRaZyR?=
 =?us-ascii?Q?0WgV3nU3GnMQiHzg+Er6UUybipgadb5r7b1E6G+MTS95vCiEA8GG1MXjWM6o?=
 =?us-ascii?Q?KfnDcwtNOAnv5taYMYWf+stcEKZd2NKf0UKRgh4R8qIsqNmmm/0cCE76YC7n?=
 =?us-ascii?Q?H5dSQqI0LTS34KEMssdu++6txvurNCIgU1w9AMMIeCo5K5GxZ97zicJtEVWp?=
 =?us-ascii?Q?LVDv9KTPB76/bCf3CJW+hHi2TGrTIPLRG+MJCIM7lv9BMBH5MOfFzwHDGUQr?=
 =?us-ascii?Q?wtYXQlMAzGfS+TS2Fr0ZKtSYilgnka89Exq7Nt3DPNPtuMifmiaVDrmMgN8e?=
 =?us-ascii?Q?KGnnIcSRWxvj4JhutOnTa/ufDNcCSWJJiYEI0JEA3AZBWN6/dl7GT8DsYeFX?=
 =?us-ascii?Q?MfnahvEd9SBX4WWjvtCVJXFYUMcdJGM8Q3j/0tsy0B+BjRD3e7MTaw8ymzvg?=
 =?us-ascii?Q?foXYVW6NYanUm2E5oKwQRuWpO6Ip7cbcSQ0ZcBiXe8/joXpJ0E+FBeZK7rK+?=
 =?us-ascii?Q?GpOfDg782RFD3Z0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7894.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8307R1+tosRtRwSJn9M8ZdcPa+t6sGFTMb0sBRbkXjgMvwpe9uf4M67kGbpg?=
 =?us-ascii?Q?GDtAGP+0bo3xRW6xgSvlfkjOOGMF7f4X7JriVBtA5RiybxQZ5s0qjDT5/Ys7?=
 =?us-ascii?Q?Bg8FiFoDI7kWcfH9lDNGgdT9FYoiS1x0u8//oW3xIscZepYNdf+yomWsgh9B?=
 =?us-ascii?Q?GE5xjQJ4QNwUH9TDznVQ3aoKJdNxDGIj57UimeZgnKISQUkqa6GOeeREgYL5?=
 =?us-ascii?Q?ACbMDu1ObuzIyP1AeQjRbH3Tlto5TCVf5p2UlaMx1YTZ42C2n0npYxLxrak2?=
 =?us-ascii?Q?URuUtlUGUtLdxW3PltW9c0OHf3Gzz3wdKuf7VJpoNdEAW+ETEcfbDG+/cSen?=
 =?us-ascii?Q?pdTMrLXYWOM+c94L4YnB8+s9WFyf0+RSV4Q8ps+jP06dp40cxxUJhVptjU+5?=
 =?us-ascii?Q?rVAQk62JQjPNGTq/iH/Qk3mDXoLXM3Rl6k/OMeHpt/CiOi+6XzBDkCSYjPwa?=
 =?us-ascii?Q?dqCgtKRR5hWQ3tNnBuNJvasGh2pl1awxomDP4ZhQNHYa2dkOmOiThQIiU1fy?=
 =?us-ascii?Q?0k0GyMa8kt+qYKdfB1JYzF7N8//p6FT7FHhnfImTsdzhSWOCHASlZxEsg1CG?=
 =?us-ascii?Q?Wcd0qVVctsTS0eeJgxQmBx3/78Z1vIbFrA6FhRqJdRjKc78N5eAtEvF0FBEs?=
 =?us-ascii?Q?QXft/UdFDhTQQHuYbpQ5qELHUC0hqVSGlPO0lVQwunsn1thOoNhg2APA10hF?=
 =?us-ascii?Q?miNDQQPf+Rgiz6W+f6TKWdjLK8G3UL2N8nlAkOn+Pm2qSvlpitKFbr3mMpIC?=
 =?us-ascii?Q?YHznwgMZNE8UcdY+RmiaPVGWSHi3CkMb13XsK3e0+w5UwdVr6CRg2j4YHIHd?=
 =?us-ascii?Q?Cp50SaxlHrBZSMKKWGpkn8tpgxSDI5nNC5EdaPIClUAzu5sj8eV91DWfEnTw?=
 =?us-ascii?Q?US7GVPRUoZg5OxDj/K59myd2cWfcPxK8pJ2bhUCCpw6kq/oJQucsgjGsd7a9?=
 =?us-ascii?Q?lCdPx58OjiOtsaFm3vwk/QPpzlEncFgsZ70FFjx0Y4pKh+Ri/sM13z3Y4it/?=
 =?us-ascii?Q?ETtTQJ8i9Ws//HtFEMpV1v4FxaI5RrVs5nNXbWwnk4/la/tBRzksazhszKF+?=
 =?us-ascii?Q?dcE9JzTZYPixnQUVxiqNEAXmPbaL1jSl+EUtenV/J3sYqptu9ygmRSV837JG?=
 =?us-ascii?Q?L9mn1MmHNwWcVDeXNFm8I6B0zt+lXgmSpCgQi6MW5J/k2D0fbCdlfDlr3DmX?=
 =?us-ascii?Q?sAyDY3T3stKfbvrb/I0T4qDFU67lhRYcJJo+TRQjVQAT+ic1s6PKSQP1zDLu?=
 =?us-ascii?Q?P2NQJ0Orb46+emG9XFQw6ynAOn6l2K/pwrmPSXp4k/vlYgWoUHWL+3CPvLph?=
 =?us-ascii?Q?XyA5aEfovEtFXI2+zwWwVzzPH9Dw27rAWBL/YNMoj1pr8WORjJn+YoFn+Zm1?=
 =?us-ascii?Q?ogpxK85EWuhuT8nY5d0wlcKcQpSSSPScJbF/4FkSdVUcD9tjQW0iWx4MnIKt?=
 =?us-ascii?Q?UgJlLMwQhlBdl4+MN1vdGfDb2upIPTbZTQO5TSO7QULQeciv+PuzgmhHnACp?=
 =?us-ascii?Q?omzfR364eEUoema/VNY+Rq/XHZD2XbbF2lo8hrn0IjMgdR8uIAEmdqxwzQK0?=
 =?us-ascii?Q?hB79hWzEhoXpxtDePSqlOhb9et4oBn6dpqCBoTrrGm36GY5f+vZo1ioRL8AT?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7894.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b039cd0-2c15-4573-3390-08ddc84c8c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 11:48:45.3997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMeI1NzMrYinISbwBqF/UVIDWbZMjSTguZ8Pg5kOA6h6zElsiuvtj8XQr9hmW4QDoNubuJNQzdG29h4YotjbIWtHyF5lAmBIGMMr+ZHTylc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-OriginatorOrg: intel.com

>>> Yeah, I saw the benchmark but I was more curious what actual use case=20
>>> would lead to behaviors like that because you'd have to hammer on=20
>>> those stats really hard for this to be a problem. In most use cases=20
>>> that I'm aware of, the polling frequencies of these stats are >=3D=20
>>> 1sec. I guess the users in your use case were banging on them way=20
>>> harder, at least previously.
>>=20
>> From what I know, the https://github.com/google/cadvisor instances=20
>> deployed on the client machine hammered these stats. Sharing servers=20
>> between independent teams or orgs in big corps is frequent. Every=20
>> interested party deployed its own, or similar, instance. We can say=20
>> just don't do that and be fine, but it will be happening anyway. It's=20
>> better to just make rstats more robust.

> I do think this is a valid use case. I just want to get some sense on the=
 numbers involved. Do you happen to know what frequency cAdvisor was pollin=
g the stats at and how many instances were running? The numbers don't have =
to be accurate. I just want to know the ballpark numbers.

I'm quoting colleague here:=20
"the frequency to call cadvisor, when every 1 ms call rstat_flush for each =
container(100 total), the contention is high. interval larger than 5ms we'l=
l see less contention in my experiments."=20

Experiment,CPU,Core #,Workload,Container #,FS,Cgroup flush interval,Spin lo=
ck,Flush time spend for 1000 iterations (ms),Flush Latency (avg) per iterat=
ion
1,GNR-AP,128,Proxy Load v1_lite,100,EXT4,1ms   ,,Min Time =3D 1751.91 msMax=
 Time =3D 2232.26 msAvg Time =3D 1919.72 ms,919.72/1000
2,GNR-AP,128,Proxy Load v1_lite,100,EXT4,1.5ms,,Min Time =3D 1987.79 msMax =
Time =3D 2014.94 msAvg Time =3D 2001.14 ms,501.14/1000
3,GNR-AP,128,Proxy Load v1_lite,100,EXT4,1.7ms,,Min Time =3D 2025.42 msMax =
Time =3D 2044.56 msAvg Time =3D 2036.16 ms,336.16/1000
4,GNR-AP,128,Proxy Load v1_lite,100,EXT4,2ms,,Min Time =3D 2113.47 msMax Ti=
me =3D 2120.04 msAvg Time =3D 2116.33 ms,116.33/1000
5,GNR-AP,128,Proxy Load v1_lite,100,EXT4,5ms,,Min Time =3D 5160.85 msMax Ti=
me =3D 5170.68 msAvg Time =3D 5165.59 ms,165.59 / 1000 =3D 0.1656 ms
6,GNR-AP,128,Proxy Load v1_lite,100,EXT4,10ms,,Min Time =3D 10164.12 msMax =
Time =3D 10174.46 msAvg Time =3D 10168.97 ms,168.97 / 1000 =3D 0.169 ms
7,GNR-AP,128,Proxy Load v1_lite,100,EXT4,100ms,,Min Time =3D 100165.41 msMa=
x Time =3D 100182.40 msAvg Time =3D 100174.89 ms,174.89 / 1000 =3D 0.1749 m=
s
=20
It seems that the client had cadvisor set on 1 ms poll. I don't have any in=
formation if that was intentional or not (seems too frequent).

Thanks,
Bertrand

