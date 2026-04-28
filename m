Return-Path: <cgroups+bounces-15529-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF3kMhiC8Gn6UAEAu9opvQ
	(envelope-from <cgroups+bounces-15529-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 11:47:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED7481CC1
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE211307777C
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7013CBE7E;
	Tue, 28 Apr 2026 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4DBQ3Um"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30E2F5474;
	Tue, 28 Apr 2026 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369136; cv=fail; b=VmlFz84WfES/tLfwJ8rSFK5jX+WtWAixMtJHXl9/ioTTzuWgdegIjkXNpWfOOm3xey2nQXZ2pyuSAtCL/UghB/YxIfw+c++oNiCxbp+kggWHZ/u4cubsjCALz48RfgFfnMOgUcfsOGdv70Ste4WG6dKiZ5133129Ai8JZlCAhBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369136; c=relaxed/simple;
	bh=Vu/evHjS+I0jlDg2co6amQ2EzktiBhYALW3VU1PgJP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFa+opnzz8X+FqYwAycsMcBN+UrRoWziRR6yagQxqdXffSsY0I/FV3I6uL/THmjbsZW/v+bb3GhJeL+2MIGYOLqfdDpGkeMHZyF5J0SsMYu7zUpE4xBxtmTCyTkQ010uPikM92oqR8IURoWXYgM6eJXgUmXRTVg3OHFsZDyvYek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4DBQ3Um; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777369135; x=1808905135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vu/evHjS+I0jlDg2co6amQ2EzktiBhYALW3VU1PgJP4=;
  b=n4DBQ3Um34wIslhy9k9Pyx43ACrj2zcNVqW8Du+q+9hJEkFwEhlTvMD9
   aRpYVXmeRhvRU1kDv4PETnW6xn+0Y7hRCF1zDk5txl2jU8eBBTnk8MjFT
   BjQ7k+7m8HdH0Fr1JMbvbquof9IUj69J362VxcGLjE3BexNc9r1Wu8ZDj
   wer113BqJvaZVAvugDZVTdj/cH+qLaN2qyIhNFNafGWDJIQV+8ThKuThC
   +J75WrnA6EfJ/mtw2sxfPlzJe0MVGmlCrIsuec5ZQgrO3sRi5Q5l5WKt4
   X5GTNHTOAic0mmuI28p0RW0OzPLegnF5t3vBQlwlSk63OrBOcoxL0c6XQ
   A==;
X-CSE-ConnectionGUID: +qouMBdQQxiJGAJisxoN6w==
X-CSE-MsgGUID: txklAN8ARHGsn9RkmiRWug==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77302814"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77302814"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:38:54 -0700
X-CSE-ConnectionGUID: 4hlUWpbzTG+Zr6z6GHfc7Q==
X-CSE-MsgGUID: XokshLwpQPy29fNA7penug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="235666491"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:38:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 02:38:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 02:38:53 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 02:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aodsFF1GPdxTS/vl6mqG4bD4Eowj3yPLX22J2D9dD57z0S2tsvsvQ5IGq1c5XSJd+btaHUC9/sdSCkQvOIHF0X0F32Za7ce9kvU5/8AfydNqvKzzA1kKoBwCNADT7/qEBmdq04r4Hom60VvuZrT7AsgqoE+qxaE/zYUNXBs7Nyv8QnRTp2TY5yRHD3DSpnap8X5GG6Nd/+lB/lJNPskA6stMLqcLuLgqd7zLp7fQNXUxUPqDVexbP+x16UI9dOoKpWv8zsbItQLoDt+0/h16IRcYQuQf+78RRovGbgJ1d7ZpSxD4a7NE/kTUKP74a4wTK2YD+h/FItpnRIQD+SlJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu/evHjS+I0jlDg2co6amQ2EzktiBhYALW3VU1PgJP4=;
 b=UdzssOIf44uPUkZMvt41u5BuEaLuOeJlz15PKnLxB4mJj87W0mUURcRj5T5buLYFmvjP4XHx5Q4wR1Z2iZbgKi+egOSNG1tyGz/u401qO7wLKG2eg/SV6pZLqqRQP0qK9GGU5DOjsMABdIhOxopbuRXd1dXJVRLX2o43oWPMGOZTh1rDJd1TCDmxVDn1bc5wlo6TDs4JKC1QQ1dihdOYUJHEWMDB63e1PMzN40sBz9bIPlnYNbisbXz/+XoQHNAIYbq/36UboZjIt9+sSxcCxUWA99GxHXKagjKk29G7dJKr8E+jxnt3Um2D4Jv0kNfRMThO5P7oGH7NPfuzRqMPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3227.namprd11.prod.outlook.com (2603:10b6:5:5d::16) by
 DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.15; Tue, 28 Apr 2026 09:38:48 +0000
Received: from DM6PR11MB3227.namprd11.prod.outlook.com
 ([fe80::2666:d656:48ff:cc9a]) by DM6PR11MB3227.namprd11.prod.outlook.com
 ([fe80::2666:d656:48ff:cc9a%4]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 09:38:48 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>, =?utf-8?B?TWljaGFsIEtvdXRuw70=?=
	<mkoutny@suse.com>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	Huang Rui <ray.huang@amd.com>, "Brost, Matthew" <matthew.brost@intel.com>,
	"Auld, Matthew" <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] drm/xe: Wire up dmem cgroup reclaim for VRAM
 manager
Thread-Topic: [PATCH v2 3/4] drm/xe: Wire up dmem cgroup reclaim for VRAM
 manager
Thread-Index: AQHc1uE0dzjdUYsBp0eq7ilL7jWoXrX0N4eA
Date: Tue, 28 Apr 2026 09:38:47 +0000
Message-ID: <DM6PR11MB3227E09A268BAFABF7E0A2F081372@DM6PR11MB3227.namprd11.prod.outlook.com>
References: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
 <20260428073116.15687-4-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20260428073116.15687-4-thomas.hellstrom@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3227:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: 66a2ced9-f5e5-4b65-e7e7-08dea509f2db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: J+ZZKq6pBAALSZrBwg3WcMohRGsDGS1Hbgs97cnTOmiD+fLjroG3J6AyED+rE8RAbFP0Y0PHpdZe7v2CP+ldzj40rx8nsv32NQBCkAzh/l8GmGBMjFlGe5kUgaBe//8Q+hj/4ZeF0V9jEbdlj5bq8Rod7u3EY1apgdY1Bf8xrJxpYQe7pqmaTfu2mq64aMgX9dVQmKoJ6MX//ZjNbPl7EWRchB7dksUgnOLiAyqoqPjiZRQ9TRIJ31Gq3iwSTnymB+0Pv2ZqKw3/GFefYaWcaDcdLpkCkDwjotOkxOrfH3fR4oMWwlkh7qb2r83sB9pKsLoso5T4syimosSQGigFLjhXO07HG9AQtZNC55mldSOlWozTKRMKk4RIFc53WDJ5pJpJliUOgEC3dg1ciDU+LisC6kuA84/579yC0J5r3r6JO64Vx7QDik7/nBX2ZdvivU6wtWkkgghzVjcRc5YEkZZNc2RHJFOYELdxHpIL7Qxb4xRfrhHxngxT4E7Fk9TbnPJJxn63b7wJ3FrU5XOnmSC/m2o1Jx+2h9p4ZFMJ1lDDaGxM5AKXfhy0dmVhQYpjgVF95d/rXWFEYq/JTxWGyQFNHu+HNCcFsaDJih/ohDI8K3BMdoTni8DeBYyhmtZgDCLAPqKe1y6859Z8YXnfwNBltkkhWmi1MLgBSA2WFNjfwqdGzJ1PHIUQub0P51YMwcsuJ2t00aeiZWZTtk59l1+eehCNCpn9psxEzZPGhQMuohdSSLgJ8vGfCLQweImi2hDHIibIDDR74Yr9enFcv2uw61z+eCW1GNsevRSd6Xc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3227.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajd0WGNpK0tYeGNCZjY3UG80bVhpZXQ0SHRVZWVXSUFZTUU5ZWVxUjhaSFNO?=
 =?utf-8?B?THphNjVRN1pqMUE4bkJEM2ZtRG5Ucmp4WDkrV0M2V0dsQ01BdzdqTy9IVTB6?=
 =?utf-8?B?ZnBzckFCZU5XTk5yTlY5TWhRTFZWSDF3ZG5EMkZxcld0cjFJWkE1ZDJOZTZa?=
 =?utf-8?B?bkhBczI2LzhyQk03c0c0bGp0dDB2K1VCSEREcDRrZ1pNMU9DeGdlNnM3Y3NM?=
 =?utf-8?B?VEVxcDZUKzl0eDdKRnVRV0lPUHFGUjgvVU9WVW1zM2RCVm1NblJWd0xsUHFJ?=
 =?utf-8?B?VGZVVFhUTldMYTFrL1NxR0dOWWt4NDZWRzJRSlFMN3ZGeWRTTkdxY2txYmJV?=
 =?utf-8?B?VDg5VElSZWNnNmlkT21CMmM3aG03UkZTMGRxNlVYQ3V4OHVHVG1URFFkeUFx?=
 =?utf-8?B?N3dnUmVLN1pqbThwamplMFBGa245R1dyZFN3RVpnNy9OblFZT0h0ZHVPM3Ju?=
 =?utf-8?B?ZlUzMW03azJpbjhNS3FEU2NOajh6bWVnU1B5aXNNRzY2bTFDQjFxVWR6MVdK?=
 =?utf-8?B?bUFPTmdoVEEvNHV2WkdEUVVwMnBuVGVRbjEvdFkvZEhteHgxKzFRZVlUWGsw?=
 =?utf-8?B?ZE5QSnh2cDlDd3l4dG1XRk9Mb0tDdlRnc0RQMXRqdHpaTzU1TnFqdllTcnI5?=
 =?utf-8?B?bEtNNDlKSVROUUN2RkczR01BdGlXVC9Fa0pxaktHajduSFBvWjdSdUhoUzg4?=
 =?utf-8?B?dG96S1dJN0JldDMzM21wSllQZHFiczJjN0ZaWUlJOHBFdERoS2J1d1dpcnRn?=
 =?utf-8?B?MCtSeGhOQkpoNlUxTnRhRzJZRTdVNUNxOFhEaS9YNE1BR3VpYU40aTgzRUZp?=
 =?utf-8?B?a3NnS2xIWE1GUnhIYXVXbnM3c3RzWFZnRm9SNkplSWFONk9XTVNzZkdEeTJ3?=
 =?utf-8?B?R1ZjQWlYaUtsaW1nbzYvaVVvK3JxbUpzUWdVdFFOekdzcUFHQmRWK1FpbDZT?=
 =?utf-8?B?YTErYUNTRjcwZ2cybmJMK1dYRVQzOC9WR0Zod3N5a3pJVnlVZkcvbllDMWVt?=
 =?utf-8?B?ZnR0cnhQRXlodkpBeDBxSEZCRklSblRNV0VBRFByOXdRcEVWaVJ5bExrcDlH?=
 =?utf-8?B?eVQwS2dsM0h1b0MydEpxdmtmR3VyY21wcGRTUE8rMlJ3UnMyVTVCZzI5aW9a?=
 =?utf-8?B?cmFtaC9DRGZvbSs5bWhpRFRnZENtQ0FKT0lRWkMwcktZM1NRZzQ1SHQxU0Rn?=
 =?utf-8?B?WSt0WWlnMllWTFA2MGpDVHp2THpNa012dkhIOFVPRmYyOHNTWjVSbDhOYWFW?=
 =?utf-8?B?Z1hYRE91RG9iOTg4UWN4ZndZdEo2cktEVnhkUHFiL3JtaFBxSlhMdHo0OFpR?=
 =?utf-8?B?UjNIWjBzaWVvc2J6YS91dkE3ZEhJc2RxK1hPTGZKSThMWGgxVmRiQm9GWmdH?=
 =?utf-8?B?NlFQYUlJN3JBY1d6NHo5NmhWcWhvZU80b21NYUxEbnN1emVXd0t6Vnd1T3k3?=
 =?utf-8?B?dWVrZ2NaRkNiVm8vRUhpcXJlYVdlTW1HSGxkbkFKblUwZXI1NTVKamJ5RzVW?=
 =?utf-8?B?RHJoQm1GeWQ4Mm1vVStMMlhYYlVoQ1FDZ1NvenRZNGs3dDVPQXEyVkFiVWpK?=
 =?utf-8?B?OUZDNUZtQnZuc2pqdEtrOU16U25EUTRNRS81OEk3ZEMvcTFZZGhucGNwWmVB?=
 =?utf-8?B?Y2YzS3hmQ2hCL1NNcmtUZDBmSXRJOVRoN2hSS1pVUkxwMFhaODgwcXlHT1pR?=
 =?utf-8?B?TkpJTStKcDBEZjlUWk5QKzNzSjFqZU80bkNXQVZ6MnNzR2ZkelhQVXZQMldB?=
 =?utf-8?B?L09hR2Q1VUs5US82RmM1SnJrUkFsTEFPSmwySzJCYnRtb2JCQVJ2ZElxSzJa?=
 =?utf-8?B?cHdwWWx6aXRjalZQSTZqdjVxU0VXNUl3RHBBeHpKZjVjalUvanoxNWV6b2g5?=
 =?utf-8?B?SUNwSVNweS9mdmZtbVA0UEVvcVVLT1gxK1pYK0NVVjJuM2ptSTlKeFFvYTFz?=
 =?utf-8?B?ZGlsZENHSjVOd2RwVjNTMUQxektCS1MvZDdjaW1YVDhWY3dOQ1RwWU9rNzAy?=
 =?utf-8?B?QTZZM1E2MTVNeGxoRzJhemlySTVnYlgrVHpTSUFvQWVnVzNuSHV2VnJILzhF?=
 =?utf-8?B?WU5QalhLL2V4NDdsaTJERkpFNndnb0dGTFlFb2JELy9waU95d09udUtENk4y?=
 =?utf-8?B?bzVmbURMNnBqUEk2TkpoczlDcEV1c21FOTcraHhNM3hwK0laR050TTVEc1dP?=
 =?utf-8?B?eFQ4UWpEazJVTldMa2dBcHlVUURGQnJsY3hoa2FkS1hOby9ieEpqMExza3o0?=
 =?utf-8?B?RDRoQmc3ZWtjZVdPUjNEVGNqWDVOa1VCL09YdGlFRWxVOXJubGo1NzhaL0JX?=
 =?utf-8?B?ZWVYcG94L0YzOWdKTmtWaDhNQ3FNYllDb000SWdGZWxWWno5SyszM0pXc21N?=
 =?utf-8?Q?hp2f2bGI0BjAQ8nRlq7Pqv4+HXYanib+A1oWRsTXfeqJF?=
x-ms-exchange-antispam-messagedata-1: hZH5MgXudukAoA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: peFTr0Vr38YPhMnZihd5to4vQWb/yS+4za+ul7Dt8uXSCwLVtdd7U0q2h3yRkmFpD7JVLZmU6PVHZ9Mx6wN6/cEwXSAbKPXHKw9DIAHq8dKvmOdsGAKXscgxOTuRqP37zp7S5TUMHVR3fungbaUqtG+4wfQbuzvMq3ZcEbRjr3sq4ZSzIfseKpX+IurOiW6mZ5P6EgytbDkq1gKiFKAp4dy4IWk27pLtsKoUZkHDi+WAR5ofSAKS+tH/DktPsz/qrnlMyBWZ41ieE7lpj+JksJc0ArDMQe6RvZfyNCNkhTgDVEyI8jQLQqEdVt9nwSJYLdXV93/98Y8XqXhkGUx1og==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3227.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2ced9-f5e5-4b65-e7e7-08dea509f2db
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 09:38:48.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfoSqNIDSPlsEhTRGQHCOjBLVb9X7N8nnF9sk+fK0qyEdCrqDsp+iEsIR3txvaPAudgLIS4Zn95L0r0Kk50E6/wYeYrw+NDYv7b3rSWVrek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 45ED7481CC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15529-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,linux.intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tejas.upadhyay@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwteGUgPGludGVs
LXhlLWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgVGhvbWFzDQo+
IEhlbGxzdHLDtm0NCj4gU2VudDogMjggQXByaWwgMjAyNiAxMzowMQ0KPiBUbzogaW50ZWwteGVA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhl
bGxzdHJvbUBsaW51eC5pbnRlbC5jb20+OyBOYXRhbGllIFZvY2sNCj4gPG5hdGFsaWUudm9ja0Bn
bXguZGU+OyBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz47IFRlanVuIEhlbw0K
PiA8dGpAa2VybmVsLm9yZz47IE1pY2hhbCBLb3V0bsO9IDxta291dG55QHN1c2UuY29tPjsNCj4g
Y2dyb3Vwc0B2Z2VyLmtlcm5lbC5vcmc7IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+OyBC
cm9zdCwgTWF0dGhldw0KPiA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+OyBBdWxkLCBNYXR0aGV3
IDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPjsNCj4gTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4u
bGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT47IE1heGltZSBSaXBhcmQNCj4gPG1yaXBhcmRAa2Vy
bmVsLm9yZz47IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPjsNCj4gU2lt
b25hIFZldHRlciA8c2ltb25hQGZmd2xsLmNoPjsgRGF2aWQgQWlybGllIDxhaXJsaWVkQGdtYWls
LmNvbT47IENocmlzdGlhbg0KPiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT47IEFs
ZXggRGV1Y2hlcg0KPiA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT47IFZpdmksIFJvZHJpZ28g
PHJvZHJpZ28udml2aUBpbnRlbC5jb20+OyBkcmktDQo+IGRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAzLzRdIGRybS94ZTogV2lyZSB1cCBk
bWVtIGNncm91cCByZWNsYWltIGZvciBWUkFNDQo+IG1hbmFnZXINCj4gDQo+IFJlZ2lzdGVyIHRo
ZSBWUkFNIG1hbmFnZXIgd2l0aCB0aGUgZG1lbSBjZ3JvdXAgcmVjbGFpbSBpbmZyYXN0cnVjdHVy
ZSBzbw0KPiB0aGF0IGxvd2VyaW5nIGRtZW0ubWF4IGJlbG93IGN1cnJlbnQgVlJBTSB1c2FnZSB0
cmlnZ2VycyBUVE0gZXZpY3Rpb24NCj4gcmF0aGVyIHRoYW4gZmFpbGluZyB3aXRoIC1FQlVTWS4N
Cj4gDQo+IEFzc2lzdGVkLWJ5OiBHaXRIdWIgQ29waWxvdDpjbGF1ZGUtc29ubmV0LTQuNg0KPiBT
aWduZWQtb2ZmLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5p
bnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3hlL3hlX3R0bV92cmFtX21nci5j
IHwgMTkgKysrKysrKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX3R0bV92cmFtX21nci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3R0bV92cmFt
X21nci5jDQo+IGluZGV4IDVmZDBkNTUwNmE3ZS4uMWJkY2IzZmVlOTAxIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0veGUveGVfdHRtX3ZyYW1fbWdyLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3hlL3hlX3R0bV92cmFtX21nci5jDQo+IEBAIC0zMDMsMTMgKzMwMyw2IEBAIGludCBf
X3hlX3R0bV92cmFtX21ncl9pbml0KHN0cnVjdCB4ZV9kZXZpY2UgKnhlLA0KPiBzdHJ1Y3QgeGVf
dHRtX3ZyYW1fbWdyICptZ3IsDQo+ICAJc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4g
PSAmbWdyLT5tYW5hZ2VyOw0KPiAgCWludCBlcnI7DQo+IA0KPiAtCWlmIChtZW1fdHlwZSAhPSBY
RV9QTF9TVE9MRU4pIHsNCj4gLQkJY29uc3QgY2hhciAqbmFtZSA9IG1lbV90eXBlID09IFhFX1BM
X1ZSQU0wID8gInZyYW0wIiA6DQo+ICJ2cmFtMSI7DQo+IC0JCW1hbi0+Y2cgPSBkcm1tX2Nncm91
cF9yZWdpc3Rlcl9yZWdpb24oJnhlLT5kcm0sIG5hbWUsDQo+IHNpemUpOw0KPiAtCQlpZiAoSVNf
RVJSKG1hbi0+Y2cpKQ0KPiAtCQkJcmV0dXJuIFBUUl9FUlIobWFuLT5jZyk7DQo+IC0JfQ0KPiAt
DQo+ICAJbWFuLT5mdW5jID0gJnhlX3R0bV92cmFtX21ncl9mdW5jOw0KPiAgCW1nci0+bWVtX3R5
cGUgPSBtZW1fdHlwZTsNCj4gIAltdXRleF9pbml0KCZtZ3ItPmxvY2spOw0KPiBAQCAtMzE4LDYg
KzMxMSwxOCBAQCBpbnQgX194ZV90dG1fdnJhbV9tZ3JfaW5pdChzdHJ1Y3QgeGVfZGV2aWNlICp4
ZSwNCj4gc3RydWN0IHhlX3R0bV92cmFtX21nciAqbWdyLA0KPiAgCW1nci0+dmlzaWJsZV9hdmFp
bCA9IGlvX3NpemU7DQo+IA0KPiAgCXR0bV9yZXNvdXJjZV9tYW5hZ2VyX2luaXQobWFuLCAmeGUt
PnR0bSwgc2l6ZSk7DQo+ICsNCj4gKwlpZiAobWVtX3R5cGUgIT0gWEVfUExfU1RPTEVOKSB7DQo+
ICsJCWNvbnN0IGNoYXIgKm5hbWUgPSBtZW1fdHlwZSA9PSBYRV9QTF9WUkFNMCA/ICJ2cmFtMCIg
Og0KPiAidnJhbTEiOw0KPiArCQlzdHJ1Y3QgZG1lbV9jZ3JvdXBfcmVnaW9uICpjZyA9DQo+ICsJ
CQlkcm1tX2Nncm91cF9yZWdpc3Rlcl9yZWdpb24oJnhlLT5kcm0sIG5hbWUsDQo+IHNpemUpOw0K
PiArDQo+ICsJCWlmIChJU19FUlIoY2cpKQ0KPiArCQkJcmV0dXJuIFBUUl9FUlIoY2cpOw0KPiAr
DQo+ICsJCXR0bV9yZXNvdXJjZV9tYW5hZ2VyX3NldF9kbWVtX3JlZ2lvbihtYW4sIGNnKTsNCj4g
Kwl9DQo+ICsNCg0KSSB0aGluaywgdGhpcyByZW9yZGVyaW5nIGlzIHJlYXNvbmFibGUgY2xlYW51
cCwgTEdUTToNClJldmlld2VkLWJ5OiBUZWphcyBVcGFkaHlheSA8dGVqYXMudXBhZGh5YXlAaW50
ZWwuY29tPg0KDQpUZWphcw0KPiAgCWVyciA9IGdwdV9idWRkeV9pbml0KCZtZ3ItPm1tLCBtYW4t
PnNpemUsIGRlZmF1bHRfcGFnZV9zaXplKTsNCj4gIAlpZiAoZXJyKQ0KPiAgCQlyZXR1cm4gZXJy
Ow0KPiAtLQ0KPiAyLjUzLjANCg0K

