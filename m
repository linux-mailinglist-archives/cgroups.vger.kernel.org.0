Return-Path: <cgroups+bounces-8641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB291AEB89E
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311817A43C3
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDC52288D5;
	Fri, 27 Jun 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fE5Q6aHq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616742F1FDF;
	Fri, 27 Jun 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751030146; cv=fail; b=Oe+F4kTM6ej9LLj0fv76M9C2mQwNuQE1UL4knwMmeEWqDAPh1F21yF3qMbpasoDZPXrFM5ZV/QC9rQ2PGrM7B6glTSC71gjpkLbCsXlTikUL4q0vHM6GfOr+9rPHsbCHXosQ8ffm3gx3eAQXuELy/8vFujmh6XsH5mWXks3DzKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751030146; c=relaxed/simple;
	bh=eXNtGd2py1Rw0KEs+VFnX4MjOtM1A1Q5LyVYd7jKpdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l3meu3blUitxPXoNCZ1VGtJV6NqLTjfFqsjdDnKe0LOtNkc5DPYnoXVOuFHHQaEEoO5KQb1CSmHikmw4Me+AZUNEbR02DMjsgLWsRzygvZsm4oWgByCQ+E3NZh1Whcfa1HGu2UBsWxdSRWAJ2QgisJZq3v6LlEB1omzFgLOB4kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fE5Q6aHq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751030145; x=1782566145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eXNtGd2py1Rw0KEs+VFnX4MjOtM1A1Q5LyVYd7jKpdk=;
  b=fE5Q6aHqWdHJ5zw9HH/iTr10Lg+KTU4/kI5FHh5gDugq5Q/s6LCKAKtC
   InD1PWsCh5VhZzV2ueF42D5Wm22JGNXGn4ZsRlV1trT2q+7YeaOBHjST6
   x4PuQcSdtFv7ZyD2cVgHGOokbdrlPGmBHXJaGn7vyChsG/flZD2KEQq1q
   orli8YEIhgW5DfI8USq1gILkqVl0wVU3lcPSzZnGTlOTbtSY2fffktHNA
   ETFYduGDDnlxodljozoDI2wj0VZ9qJq5LY6k3xmKhINKUpjExANnQHXjI
   ujFkBv//zXUlN6DsHBQr2T1OK7IPMDjE3pgqJ/KEBxzue7Z4K6oZS6I+s
   A==;
X-CSE-ConnectionGUID: 0Mui5pdyT1CENO7f0YFZtQ==
X-CSE-MsgGUID: S/5kosYMQgarKYp21B33HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53308966"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53308966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 06:15:44 -0700
X-CSE-ConnectionGUID: pQepWUtbSZ6B3RfBYNy6dg==
X-CSE-MsgGUID: tp/FHxpbRNKMydHCnS5r7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152976333"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 06:15:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 06:15:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 06:15:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.77) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 06:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXap2tForK0GB5cLxc60Q3kW1GOLCKHIjxXak12O4WcHoWBu+U4bN9odLELzN2LRRDF2KX29aoq1gyOD/rQDL4Pg/pPOnGPGGAMzdILo4bRzQHlnUWNfP84D4E/4FcMW2F2okG94j5nEXuj70tiFnCrJLvnybzfq6l+s5M78OK3QDzQU0IrVg3aj+QEcCI3FqhjT5IgBpTthyepnLb3mwrZx36Zoj/myENvpwa30LruHMPGkA2tvYMVkTYPENvK5wFP/ssJ5fiKCnCAiFyHU2ibkHsMWALn3tTcWkhMb7l6YLKZOjCIbxsVw4lE44mAn7naYxTbhLAF+fk4GDXhcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZXSeKOXxAeZ3KLeUM91Bm2PL2I3I39ga061OTD3MTM=;
 b=C7kX5wyBMD64jWrYAmUVH9kDbzL4qymxo3N3mz8oigpZsJE9TtfL+axwf49i1u7AAoc8399xiGg8c5er2SgrE8rBucPsEOs0yn3mMy3pRCowBoVLPhllo1mJi1yKmP3WCQlqkrCfdBDfarSUIRbc/9eO3Uc5xDOFQJxLqwxF8daD9RJhnx4ZnlI2dayhhyqerAtN2RXOjbCecdMLow+5exAS/34Ik399ESo3zQY8yQw0C0nc9Y/zdNeV4Ke7ZCAI8lI9VrmEg5xgxwnDIWiUtnGnkLtFv8qVjg+ZqMxAli9T7ui7hiyLH4hiVLLAj5IHdjgxSKn/d3tHMVTgI/ZLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 27 Jun
 2025 13:15:37 +0000
Received: from CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a]) by CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a%3]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 13:15:31 +0000
From: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: "tj@kernel.org" <tj@kernel.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"inwardvessel@gmail.com" <inwardvessel@gmail.com>
Subject: RE: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Topic: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Index: AQHb5RcNKOjgP8rvyEWnUhbN1DoTcLQV00mAgAEXB3A=
Date: Fri, 27 Jun 2025 13:15:31 +0000
Message-ID: <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
In-Reply-To: <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7894:EE_|SA1PR11MB5803:EE_
x-ms-office365-filtering-correlation-id: 81508a53-1862-495e-0532-08ddb57cb173
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GsU+AkFHq9tfH9I/+6q3gD6n55+M2bRGGhGUjjs2NHHjmvsgBSLAKi8dIv2A?=
 =?us-ascii?Q?jVg816rTd9NlYTr8BvpJNANM3F6AbLdcJljQtW60LUDoXNxQqC/ZdCnUfYIM?=
 =?us-ascii?Q?oKzNlJ7l9RtYFtlnCzqgRQQxw+9OCmUZJJE6ApiJFKDnn1S+UOgmCq5P7dRK?=
 =?us-ascii?Q?PPEWJt9rsW1c9qegywDTGzWqDcaFEzkUaKdfmkOzx1D4JtBUQUc+jAs5DfKX?=
 =?us-ascii?Q?ywh3h46NqwkE/2agjfk56htg28XTsmTPVhh6H8N1ouj7lJsJoce6HyvgicKH?=
 =?us-ascii?Q?l/JoGetytw7Z4BqwxF91qEYFc3cZvwiVmzG949KAPP7TrwPYtPsDUWXbWTAC?=
 =?us-ascii?Q?vGxAzRQXZ/nT8dmSYU9yPnMZ3i7kn+a13nYKjAGvJ4jJ6niBo0mYa0fVB5bE?=
 =?us-ascii?Q?iCtv3pM0nW8zhjvdeXrmhSI6U18R4ubgqeIhwkA7NeRgcEZHemLD6BZD2mkH?=
 =?us-ascii?Q?5odUYvVQP1qyUsKRrHK1aqX8yduvAddWtsUGHbJ6qpxzTLunZqlNlik2exg6?=
 =?us-ascii?Q?I/pG0RyNeHAbjJrTPGdwgA8NYTFTPA/MEn64ON7L5gR6XhWC2w1vst02yVmO?=
 =?us-ascii?Q?S09gTjiIdAbJ2E0RGhcntD2O68uAmKDViZMoJyim+nHPe6pq1krFZvetqRuo?=
 =?us-ascii?Q?MV1oTgUf/Z8SBgH0AOJArdhaJ1qWYwx10nwbrjqqh7UGzkpX7TA9GVGdTCaN?=
 =?us-ascii?Q?X8oF1I2d6X6NHsJnt1oxmWCiSK3bC+ZX9qncjKb6ASAamLGjJbPMA5MEwmkE?=
 =?us-ascii?Q?LrH8Wo98hvuLX8+IwmlPfrQneADyLceWoBSRMB59UeskMF/EJTES1qP7awWr?=
 =?us-ascii?Q?lCTBtNq1hQD2vTDMfnBf4ir4+lRX/ARyAicl6lbuknUtf3BK27oDE3CJWZY7?=
 =?us-ascii?Q?7bU/170gWN+kPaGkK8opQJUQAOZ7+6qhXsbfaU0c5+iMFI7Aro+KeF/xKbUi?=
 =?us-ascii?Q?0elWlRHDMqjk+bzqXj1r3cE443vDkANij6MPA7nJlEcjaoItUV5tYL1p39P0?=
 =?us-ascii?Q?odaihBPQpm5+eSBFcaQGjleq/0+eT79B04wPdIfNknlsWaNgKyW33Uc1TveM?=
 =?us-ascii?Q?PlbgkKPbME5Azpqfda5caK4DIjluZt8kaWUfvdelW0ELo3ox04uKUN2DEhM1?=
 =?us-ascii?Q?wGPVUk3rXLvinSz4CuRKIZewvghaPelfPiBYcQHQvhkkNCI4N0rlcKBLqq8f?=
 =?us-ascii?Q?cHgGs6me37KIM+GxqxOC5WBXwgm6fK4Jz2GxXoIniG0WKxJxRuxXbiqSbOeE?=
 =?us-ascii?Q?ozu8eQ29D9yeKv1hA+IcmQoIqyIfD0Qxb9f0ounsMRVTE3ubCPo9qYr47t9j?=
 =?us-ascii?Q?7Sbh1VwfLvMQ+w8m83R2eo+nO/fQR+F58OsW9J4VZBCHBuWmlQ1Qrij/E4/q?=
 =?us-ascii?Q?uWhK/+QWvMqWxvgZm+WM/AiYxeuWa92oFUKBUlVrAwYS3Mpo/XwGXNpc2gf+?=
 =?us-ascii?Q?B9untGaz3bd17DhYsLaC1M3fGK0znIp8pldl7v29rFQych/rflUkwg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7894.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qzzMnBsooFNwTgy2My15qK4n1GZX3i4w1buTcuDW6oiTDb51mVkSl8Btr9OU?=
 =?us-ascii?Q?LqIyz2W21wtkCWhirh6hp+cYL9aaVWG7Hsgk6uM+/2dKtV86zVIrx4dqiP/f?=
 =?us-ascii?Q?jZWymTnMTjqxxxH6C5kSry2Sufrn0SHs9LFGcd/DYF5RRB9gX5/X6qf955XH?=
 =?us-ascii?Q?Ns9jhV6Y7cBhSghSMmMSLeNIC7J5T8s5nWM5FvhYIdnD2Bf5hbRu/1c42W3n?=
 =?us-ascii?Q?sNvYR2/TeLfg2Bfa6Y57TfeRfbS6gs287kxt1X0ho6BuThR6zOILX2IjWvFT?=
 =?us-ascii?Q?lXsb3iQIwsy6jnwwhOhS9XyHTaezr74g115qyru+MS+vfiZOEp5Z4FfX4E8p?=
 =?us-ascii?Q?tFvMXmR5V4wWanJRFPmyPFvGvQjdb53ojSEMFqWItllZbu/+sMuK2pHjNCSb?=
 =?us-ascii?Q?/2iq3ByorEdZk84BgU+rIg1kag9NP9WgSVwt/+z4B4bN9Qo6LR1PxlJKLqOV?=
 =?us-ascii?Q?8jkeQatYfWz55NCHjjDaJ3G8HNb+Y0ssW7Xllo/mEgajr7nw/t90SDmq2U9g?=
 =?us-ascii?Q?VaNt+sMqEpeuN2cDCLNxnuBtL8ufb10PL/c8ZgpVg4PlqLDGRRMB52dNx5tA?=
 =?us-ascii?Q?2IcJ0L+21qz3UgVBXoaJX4HBnsYCQSVr2u0nExotjABkCDOmmff0r6GINOHy?=
 =?us-ascii?Q?NArkhCfyJDk2bGpDDPBygHCiHmWECSfOzlbmBxvl5t7YxvbwIC98oCgU0bk2?=
 =?us-ascii?Q?w2IU2A6rcs1r8Kzj/FIuagD9YQLeRm1Kfe9f5e+iBmjG29V/a36yX1xDBNcR?=
 =?us-ascii?Q?fQBU5LqGV8PxWuiccC74//YYkt1bbjQ9ZrwOC+w0IzEgm+Y0+SXQSDkEAxWt?=
 =?us-ascii?Q?P5jbCZK2z7ASvfoMu1h6B1aY6ODzhbAYogFqsBhXJKwoYulvEno1/Wm7J35L?=
 =?us-ascii?Q?mU89PGCYjjD2GEOHNEU6CXpqj6hvMDHQ+ii1kAC9oIuIA21/OO0K6onzZVZB?=
 =?us-ascii?Q?1dLi40c3B5MQav56CfF39/HZxglmEEt6Ocw5yBeVy9Nx17KkfLGQOH/3KFb0?=
 =?us-ascii?Q?7Jgqgx3yW035IzYpRnjdMpyDkvnNi2znV4kF998i4fLt76zhQ1WN6ShQ+cQV?=
 =?us-ascii?Q?xHFCsI2xfc0+hoBDLrFgWhNVWXcPOV7MnkjZUrjQUqAFVBmr7uonJ22zrcRQ?=
 =?us-ascii?Q?8GAhAYlMMFPkFdNfdWaRj+3HLXHOd5eVIDu00ODX5SY18cm5I0KR++1nTAyQ?=
 =?us-ascii?Q?3dWCoxyU8lLWPxXFB6dLqjXJ1xDtYBvsRa+57YoHPbflkK3jaawsgGvL28s/?=
 =?us-ascii?Q?Wlzj4xgvKekeyCYsrnpFvFtbOiIBv05EZUCMooX9tKPPmUw6FvehDCAdyH5p?=
 =?us-ascii?Q?qPUqKQ7IHyMOyeqbl7CTWsYkrriXQofrJBfX4rRDgtvp0YEdKlHr/B0EXChm?=
 =?us-ascii?Q?Q/yIEe8dxMME2yUFQU9PXoLPI1FLvregJH9E4SnuN9KURZ7snn/mbTdZJPGV?=
 =?us-ascii?Q?TvBSYY7ZllurUa1bdRrDc2U1k2Y5TfKZ1X36dnIkZ7aJZEZqY9oRZZGjWaF1?=
 =?us-ascii?Q?19vapI4efdMQk43OO0upQNaiEYHcYSrcqU9t7MQTJh2JxIF8HoWmr3/KCQL2?=
 =?us-ascii?Q?yV3+3P/tgy+nBSmMO/D6FFp8Zm3FVLcQSrxN8lq48M3qXEihLlQonR+RG7uA?=
 =?us-ascii?Q?yg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81508a53-1862-495e-0532-08ddb57cb173
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 13:15:31.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ql/Xjte/MOdVTS/MgCcNESRKqSMeKQ7wSVF3fUvxVzQVAc4JERqFMwJhJWgftzJn77zGC+TO2ePLlgQEHZC59fKrDA6DPwcdZiZDzQYe1zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com

> The kernel faces scalability issues when multiple userspace programs=20
> attempt to read cgroup statistics concurrently.
>=20
> The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,=20
> which prevents access and updates to the statistics of the css from=20
> multiple CPUs in parallel.
>=20
> Given that rstat operates on a per-CPU basis and only aggregates=20
> statistics in the parent cgroup, there is no compelling reason why=20
> these statistics cannot be atomic.
> By eliminating the lock during CPU statistics access, each CPU can=20
> traverse its rstat hierarchy independently, without blocking.
> Synchronization is achieved during parent propagation through atomic=20
> operations.
>=20
> This change significantly enhances performance on commit
> 8dcb0ed834a3ec03 ("memcg: cgroup: call css_rstat_updated irrespective=20
> of in_nmi()") in scenarios where multiple CPUs accessCPU rstat within=20
> a single cgroup hierarchy, yielding a performance improvement of around 4=
0 times.
> Notably, performance for memory and I/O rstats remains unchanged, as=20
> the lock remains in place for these usages.
>=20
> Additionally, this patch addresses a race condition detectable in the=20
> current mainline by KCSAN in __cgroup_account_cputime, which occurs=20
> when attempting to read a single hierarchy from multiple CPUs.
>=20
> Signed-off-by: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>

> This patch breaks memory controller as explained in the comments on the p=
revious version.

Ekhm... no? I addressed the issue and v2 has lock back and surrounding the =
call to dependent submodules?=20
The behavior is the same as before patching.

In the long term, in my opinion, the atomics should happen also in dependen=
t submodules to eliminate locks
completely.=20

 > Also the response to the tearing issue explained by JP is not satisfying=
.

In other words, the claim is: "it's better to stall other cpus in spinlock =
plus disable IRQ every time in order to=20
serve outdated snapshot instead of providing user to the freshest statistic=
s much, much faster".
In term of statistics, freshest data served fast to the user is, in my opin=
ion, better behavior.
I wouldn't be addressing this issue if there were no customers affected by =
rstat latency in multi-container
multi-cpu scenarios.

> Please run scripts/faddr2line on css_rstat_flush+0x1b0/0xed0 and
> css_rstat_updated+0x8f/0x1a0 to see which field is causing the race.

There is more than race in current for-next-6.17. In faddr2line first line =
writes, second reads.
Benchmark is provided in gist - it's exposing the issue.=20

[   30.547317] BUG: KCSAN: data-race in css_rstat_flush / css_rstat_updated
[   30.549011]
[   30.549483] write to 0xffd1ffffff686a30 of 8 bytes by task 1014 on cpu 8=
2:
[   30.551124]  css_rstat_flush+0x1b0/0xed0
[   30.552260]  cgroup_base_stat_cputime_show+0x96/0x2f0
[   30.553582]  cpu_stat_show+0x14/0x1a0
[   30.555477]  cgroup_seqfile_show+0xb0/0x150
[   30.557060]  kernfs_seq_show+0x93/0xb0
[   30.558241]  seq_read_iter+0x190/0x7d0
[   30.559278]  kernfs_fop_read_iter+0x23b/0x290
[   30.560416]  vfs_read+0x46b/0x5a0
[   30.561336]  ksys_read+0xa5/0x130
[   30.562190]  __x64_sys_read+0x3c/0x50
[   30.563179]  x64_sys_call+0x19e1/0x1c10
[   30.564215]  do_syscall_64+0xa2/0x200
[   30.565214]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   30.566456]
[   30.566892] read to 0xffd1ffffff686a30 of 8 bytes by interrupt on cpu 74=
:
[   30.568472]  css_rstat_updated+0x8f/0x1a0
[   30.569499]  __cgroup_account_cputime+0x5d/0x90
[   30.570640]  update_curr+0x1bd/0x260
[   30.571559]  task_tick_fair+0x3b/0x130
[   30.572545]  sched_tick+0xa1/0x220
[   30.573510]  update_process_times+0x97/0xd0
[   30.574576]  tick_nohz_handler+0xfc/0x220
[   30.575650]  __hrtimer_run_queues+0x2a3/0x4b0
[   30.576703]  hrtimer_interrupt+0x1c6/0x3a0
[   30.577761]  __sysvec_apic_timer_interrupt+0x62/0x180
[   30.578982]  sysvec_apic_timer_interrupt+0x6b/0x80
[   30.580161]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   30.581397]  _raw_spin_unlock_irq+0x18/0x30
[   30.582505]  css_rstat_flush+0x5cd/0xed0
[   30.583611]  cgroup_base_stat_cputime_show+0x96/0x2f0
[   30.584934]  cpu_stat_show+0x14/0x1a0
[   30.585814]  cgroup_seqfile_show+0xb0/0x150
[   30.586915]  kernfs_seq_show+0x93/0xb0
[   30.587876]  seq_read_iter+0x190/0x7d0
[   30.588797]  kernfs_fop_read_iter+0x23b/0x290
[   30.589904]  vfs_read+0x46b/0x5a0
[   30.590723]  ksys_read+0xa5/0x130
[   30.591659]  __x64_sys_read+0x3c/0x50
[   30.592612]  x64_sys_call+0x19e1/0x1c10
[   30.593593]  do_syscall_64+0xa2/0x200
[   30.594523]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   30.595756]
[   30.596305] value changed: 0x0000000000000000 -> 0xffd1ffffff686a30
[   30.597787]
[   30.598286] Reported by Kernel Concurrency Sanitizer on:
[   30.599583] CPU: 74 UID: 0 PID: 1006 Comm: benchmark Not tainted 6.15.0-=
g633e6bad3124 #12 PREEMPT(voluntary)
[   30.601968] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.3-3.fc41 04/01/2014

./scripts/faddr2line vmlinux css_rstat_flush+0x1b0/0xed0 css_rstat_updated+=
0x8f/0x1a0
css_rstat_flush+0x1b0/0xed0:
init_llist_node at include/linux/llist.h:86
(inlined by) llist_del_first_init at include/linux/llist.h:308
(inlined by) css_process_update_tree at kernel/cgroup/rstat.c:148
(inlined by) css_rstat_updated_list at kernel/cgroup/rstat.c:258
(inlined by) css_rstat_flush at kernel/cgroup/rstat.c:389

css_rstat_updated+0x8f/0x1a0:
css_rstat_updated at kernel/cgroup/rstat.c:90 (discriminator 1)

---

[  140.063127] BUG: KCSAN: data-race in __cgroup_account_cputime / css_rsta=
t_flush
[  140.064809]
[  140.065290] write to 0xffd1ffffff711f50 of 8 bytes by interrupt on cpu 7=
6:
[  140.067221]  __cgroup_account_cputime+0x4a/0x90
[  140.068346]  update_curr+0x1bd/0x260
[  140.069278]  task_tick_fair+0x3b/0x130
[  140.070226]  sched_tick+0xa1/0x220
[  140.071080]  update_process_times+0x97/0xd0
[  140.072091]  tick_nohz_handler+0xfc/0x220
[  140.073048]  __hrtimer_run_queues+0x2a3/0x4b0
[  140.074105]  hrtimer_interrupt+0x1c6/0x3a0
[  140.075081]  __sysvec_apic_timer_interrupt+0x62/0x180
[  140.076262]  sysvec_apic_timer_interrupt+0x6b/0x80
[  140.077423]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  140.078625]  _raw_spin_unlock_irq+0x18/0x30
[  140.079579]  css_rstat_flush+0x5cd/0xed0
[  140.080501]  cgroup_base_stat_cputime_show+0x96/0x2f0
[  140.081638]  cpu_stat_show+0x14/0x1a0
[  140.082534]  cgroup_seqfile_show+0xb0/0x150
[  140.083534]  kernfs_seq_show+0x93/0xb0
[  140.084457]  seq_read_iter+0x190/0x7d0
[  140.085373]  kernfs_fop_read_iter+0x23b/0x290
[  140.086416]  vfs_read+0x46b/0x5a0
[  140.087263]  ksys_read+0xa5/0x130
[  140.088088]  __x64_sys_read+0x3c/0x50
[  140.088921]  x64_sys_call+0x19e1/0x1c10
[  140.089814]  do_syscall_64+0xa2/0x200
[  140.090698]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  140.091932]
[  140.092357] read to 0xffd1ffffff711f50 of 8 bytes by task 1172 on cpu 16=
:
[  140.093877]  css_rstat_flush+0x717/0xed0
[  140.094791]  cgroup_base_stat_cputime_show+0x96/0x2f0
[  140.095989]  cpu_stat_show+0x14/0x1a0
[  140.096866]  cgroup_seqfile_show+0xb0/0x150
[  140.097817]  kernfs_seq_show+0x93/0xb0
[  140.098694]  seq_read_iter+0x190/0x7d0
[  140.099625]  kernfs_fop_read_iter+0x23b/0x290
[  140.100674]  vfs_read+0x46b/0x5a0
[  140.101529]  ksys_read+0xa5/0x130
[  140.102382]  __x64_sys_read+0x3c/0x50
[  140.103290]  x64_sys_call+0x19e1/0x1c10
[  140.104252]  do_syscall_64+0xa2/0x200
[  140.105157]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  140.106343]
[  140.106750] value changed: 0x000000032a8e1130 -> 0x000000032ab08ca6
[  140.108251]
[  140.108670] Reported by Kernel Concurrency Sanitizer on:
[  140.109910] CPU: 16 UID: 0 PID: 1172 Comm: benchmark Not tainted 6.15.0-=
g633e6bad3124 #12 PREEMPT(voluntary)
[  140.112075] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.3-3.fc41 04/01/2014

./scripts/faddr2line vmlinux __cgroup_account_cputime+0x4a/0x90 css_rstat_f=
lush+0x717/0xed0
__cgroup_account_cputime+0x4a/0x90:
__cgroup_account_cputime at kernel/cgroup/rstat.c:595

css_rstat_flush+0x717/0xed0:
cgroup_base_stat_flush at kernel/cgroup/rstat.c:546
(inlined by) css_rstat_flush at kernel/cgroup/rstat.c:392

---

[  156.387539] BUG: KCSAN: data-race in __cgroup_account_cputime_field / cs=
s_rstat_flush
[  156.389371]
[  156.389784] write to 0xffd1fffffe7d1f40 of 8 bytes by interrupt on cpu 1=
5:
[  156.391394]  __cgroup_account_cputime_field+0x9d/0xe0
[  156.392539]  account_system_index_time+0x84/0x90
[  156.393585]  update_process_times+0x25/0xd0
[  156.394544]  tick_nohz_handler+0xfc/0x220
[  156.395517]  __hrtimer_run_queues+0x2a3/0x4b0
[  156.396544]  hrtimer_interrupt+0x1c6/0x3a0
[  156.397515]  __sysvec_apic_timer_interrupt+0x62/0x180
[  156.398660]  sysvec_apic_timer_interrupt+0x6b/0x80
[  156.399769]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  156.400937]  _raw_spin_unlock_irq+0x18/0x30
[  156.401902]  css_rstat_flush+0x5cd/0xed0
[  156.402774]  cgroup_base_stat_cputime_show+0x96/0x2f0
[  156.403940]  cpu_stat_show+0x14/0x1a0
[  156.404763]  cgroup_seqfile_show+0xb0/0x150
[  156.405724]  kernfs_seq_show+0x93/0xb0
[  156.406643]  seq_read_iter+0x190/0x7d0
[  156.407522]  kernfs_fop_read_iter+0x23b/0x290
[  156.408549]  vfs_read+0x46b/0x5a0
[  156.409386]  ksys_read+0xa5/0x130
[  156.410176]  __x64_sys_read+0x3c/0x50
[  156.410973]  x64_sys_call+0x19e1/0x1c10
[  156.411862]  do_syscall_64+0xa2/0x200
[  156.412673]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  156.413814]
[  156.414249] read to 0xffd1fffffe7d1f40 of 8 bytes by task 1140 on cpu 85=
:
[  156.415718]  css_rstat_flush+0x6fe/0xed0
[  156.416669]  cgroup_base_stat_cputime_show+0x96/0x2f0
[  156.417855]  cpu_stat_show+0x14/0x1a0
[  156.418684]  cgroup_seqfile_show+0xb0/0x150
[  156.419637]  kernfs_seq_show+0x93/0xb0
[  156.420519]  seq_read_iter+0x190/0x7d0
[  156.421395]  kernfs_fop_read_iter+0x23b/0x290
[  156.422413]  vfs_read+0x46b/0x5a0
[  156.423228]  ksys_read+0xa5/0x130
[  156.423974]  __x64_sys_read+0x3c/0x50
[  156.424773]  x64_sys_call+0x19e1/0x1c10
[  156.425704]  do_syscall_64+0xa2/0x200
[  156.426600]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  156.427723]
[  156.428217] value changed: 0x00000004be5ffd29 -> 0x00000004be6f3f69
[  156.429575]
[  156.430024] Reported by Kernel Concurrency Sanitizer on:
[  156.431227] CPU: 85 UID: 0 PID: 1140 Comm: benchmark Not tainted 6.15.0-=
g633e6bad3124 #12 PREEMPT(voluntary)
[  156.433406] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.3-3.fc41 04/01/2014

./scripts/faddr2line vmlinux __cgroup_account_cputime_field+0x9d/0xe0 css_r=
stat_flush+0x6fe/0xed0
__cgroup_account_cputime_field+0x9d/0xe0:
__cgroup_account_cputime_field at kernel/cgroup/rstat.c:617

css_rstat_flush+0x6fe/0xed0:
cgroup_base_stat_flush at kernel/cgroup/rstat.c:546
(inlined by) css_rstat_flush at kernel/cgroup/rstat.c:392


