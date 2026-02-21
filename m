Return-Path: <cgroups+bounces-14080-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD6CJ1AomWkQRQMAu9opvQ
	(envelope-from <cgroups+bounces-14080-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 04:36:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A316C08F
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 04:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D367A301C934
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 03:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8FA29994B;
	Sat, 21 Feb 2026 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFdeXPXQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E933987;
	Sat, 21 Feb 2026 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771644966; cv=fail; b=QCFWpBv3HMfD1gI7NcGOBAIYCRcmdaYihXH72FvaC6JUsmpoWSB9FVjWm9SKqJFuIz352D6qGMCiKePrdf2SL+JAOzF3xK4y667AOBLmqUsbagdbIhhI5bCNRKHMzT1xIH6eUq/3WGPqmeykxPkp/S+77LrBYbjiB3yt31aj/fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771644966; c=relaxed/simple;
	bh=4pgRcjlSmdZirtxlQ3McxpYi8u+6slGCxzBudlodw94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQ8GQZLCk7gIg1hfBUUbNxlJ3NtmiqPzLapfL5jVSHO77zDGuWLE1AnnBf5ng83hD+AHBU0Liq0Zx+ZK06NuCg2nyyCLLiVpiUmf7C5NZ+nxWioMK0/LgiF0UDV9thKGjWi+4PVzyjzVtTEXypf0EivYmc5r1RD3a0dmh/zT2iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFdeXPXQ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771644964; x=1803180964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4pgRcjlSmdZirtxlQ3McxpYi8u+6slGCxzBudlodw94=;
  b=mFdeXPXQjXPzl3RaeEqIUVJnmQ9B6w4ZI4yxRrW9pdDbmtcTOGHg88Ji
   5KpgM/yhzJmLKexwJEftP9OcPoT3o+XlaCtuyrST2A+HlzJLRA7JZc25e
   gU7bPL1YwmxD5HhAA9Pc1tKV8ZsZScGijJqJIAt83u8hdbzxVSxg8R6ZT
   0PYcN4BQkGaL4jLKyvGlk8PKFKUYOZomxjp2A8X31okFj9CvVPac250Ia
   m3WFFcKKXexLrc/viLR+NrnbmVzR8nskk7ymWopXYDgPmXEV1RfbWAwuV
   9HpP7lyLsHXMg1IxgdehLnECfaGB2lQxVTuSSa/sB3QqJZt7g4EjjZVeK
   g==;
X-CSE-ConnectionGUID: uh1NtCJVTXyC4lJadgw/Qw==
X-CSE-MsgGUID: IpAeDrywRESOj207KPAqjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72911793"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72911793"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 19:36:03 -0800
X-CSE-ConnectionGUID: DMqNVA/URrCGdsYVT7bBDw==
X-CSE-MsgGUID: ZVQ8iiWGR8K39w5UzshotQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="215156127"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 19:36:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 19:36:02 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 19:36:02 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 19:36:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pj+o9o7urKeHDdd3l7mHLNMEK3JP4uBVyG0YOIFWOVR8I0H/06mPnLE57IC+fJNCJFk4WYHXM9nszauyLw8tWyl8P82vypjpXQVMamhxuH2l39wpY4GBKS6aVlov35hXkOfwbXJHsmlmEfaWDmVlLaxV6uLwQ+ANDUaho69oJT1UM95xvK/FnTShH23PjI1qYSuPu7PS9OFC0hLPpR+jonw6Ts0RYNpT/aEKhZORfNfa6llgLDL9OR2qDd2wEk3hamrm7v+RP12bTLcAZi4dugWEmDSUnGAEMRx8YDDXUQURK6Zv9WaKPWNliiYfctitK9khfCdvqr7V0klHvhJpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pgRcjlSmdZirtxlQ3McxpYi8u+6slGCxzBudlodw94=;
 b=jVdV4yn1rhUPQmKhL0sHEcPIjwXIPpGlsOrGa8z5p552pQFTQ2pm/t1lGym4u8Uq7gJgOFgWJzTBlJbeqqfcn3uMmiT+bbfpg967N6tUj/0iabd0k06Yre/8SnaqDOT01Ik2HTBDfNznTm5FUHMozgb6ySydUXO7ojDZ8/C1xHgS565faT5NMNJ++rPE/V/UAmoU7sbTSPYfXsh0h93fxcMrd+GK68cVhq0VzBAoxrJIHNrAkD1ZcwdUfiUdwD/CLyhCuX8MJLuPsRvLk+3PAxYCTqJ6h+PyHyCR59bb36BX3M4el4VX0vqP58aPD5kJQsi9g0101M9qfj7CIv2Wyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA3PR11MB9225.namprd11.prod.outlook.com (2603:10b6:208:570::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sat, 21 Feb
 2026 03:35:59 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%7]) with mapi id 15.20.9632.017; Sat, 21 Feb 2026
 03:35:59 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cgroup: free cset links on find_css_set() failure
Thread-Topic: [PATCH] cgroup: free cset links on find_css_set() failure
Thread-Index: AQHcoPidI33ZxYui4EG6ppeBnKRiurWMg8MQ
Date: Sat, 21 Feb 2026 03:35:59 +0000
Message-ID: <LV3PR11MB8768603788F159516EEE7FC9F569A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260218120543.1113594-1-kaushlendra.kumar@intel.com>
 <9a26e18bb0ff00bc6cf894dab8443242@kernel.org>
In-Reply-To: <9a26e18bb0ff00bc6cf894dab8443242@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA3PR11MB9225:EE_
x-ms-office365-filtering-correlation-id: ffdb976d-f7af-4207-c3b0-08de70fa546f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?skgTqHyGZEhdRLLG0KvBEuG9zFRU/TASL70+PFsZrhj4A9pBjk+hLgNhb9cP?=
 =?us-ascii?Q?nSRWmr+oIH7OJumZTgmZE29LCfexQCqpOCWLUobGvF4603ASDTTIlxpbHm9i?=
 =?us-ascii?Q?KSrh0XUzRewiwdMy2VKAI/2zYZQlxjE0XWGSYxjOObuFqD+lXIETtocWspeI?=
 =?us-ascii?Q?7idAdvJzNwfsJ8PIxCwKBGidxyS4Zxbirn5vvjVBT3suNNmbx2JK1BsY6lJ4?=
 =?us-ascii?Q?Yc+CUrS96L+bf/jYn7aGBIxl/Whuj8qKt/GLVc60/OLi1lzWexqWORg7lqLx?=
 =?us-ascii?Q?gAPDMF7G+GEfB5v9xHTVyW1g50RQPTv1GHPt09K+/ukzKMik0yTsYFQ1qr/X?=
 =?us-ascii?Q?e4gt6w2J8cMkPLJsiUEYk9uMSJQmPfH9IlmMxs83iGQ27UE6qPfsdgkEh19Q?=
 =?us-ascii?Q?nO53CE60Ilyi+Y16TNQBTeVLfVsj1aG1KDbBfHbIJqOQfaB2Vf0yrM6dq5Fz?=
 =?us-ascii?Q?kUQVjON6J+KQc9qWrkUkVrMeF9M//+D0GykkB/RHpboLk2ZjxJX3g+s+J89T?=
 =?us-ascii?Q?EGLPQs2tfmQuMJeDcpr3ymV2WBlimWir5YTMJHuJCi6X42dGvdtZnIwz/plo?=
 =?us-ascii?Q?wl5C83pEaVazvOrEr8qabI2RZoiWZ7IL+ftAH2l047Oz1mN1FbMJSaGc4+lP?=
 =?us-ascii?Q?wSpdn4aRgb3R53SbqsuVhFAK/dxaoEuCZuXXIzgRioxDMzsM0C7yxv+XFIFe?=
 =?us-ascii?Q?gGS/ykAWM/XUCr6ytVDqGS2XSPM3Ht213iOvIMYSmCr+q7/DysFKg7ssGpCY?=
 =?us-ascii?Q?Z3XU7QZClvT2AnEKcxaR1dhZcelHYFPy/2T0biyEFY+ucpwaan/yxk0cQdHX?=
 =?us-ascii?Q?L4cv30eEekOpePZwpLxhhGlHaj/ZWU0uq0VcU5+Oj3Tcd+u6N2AlN5FzjizQ?=
 =?us-ascii?Q?UFec6OZqwcOGh7KOZasRWmsIY//7JuDwyocDScD0O0uuLbQPUJfCMafzNmBx?=
 =?us-ascii?Q?kG2Jnivba7esoND99gyzu7qK10fdOPSIak+iWUTw2gy9+elFDV0XelZOd3OI?=
 =?us-ascii?Q?DMD/h3WmsoilxJOS6M6XBC64kXNhKDnb1w0OB9mcX9Ksu8lpTiJ3DcHOgTpq?=
 =?us-ascii?Q?N07abKd6Kvi9ojoOnuZApMfxvyoY1K1y/h09bQgeFep3hvz9wl/d49fQH1Mw?=
 =?us-ascii?Q?eWdH6E7ozzAzEaYj+PNymo7EuhUUn624CBxnd5EgHw0odnFpearGR0+vKojy?=
 =?us-ascii?Q?zEia0Vs/De9V/rEAYdAn4ACKSS/y833HCcUE8cSWt37iQGpsCQpH5rI2D5d2?=
 =?us-ascii?Q?noDjOt0UguL3jpdWD0ennVvSUjy6bJAu4a/h5TnSEfHP+lG4Dj2tSpgYSCCf?=
 =?us-ascii?Q?c2SjpijLXM5A6KD8SUjfEJBeyLbKkgMT1Hv3IfRCmVq6b+a3QCFA5IKde5il?=
 =?us-ascii?Q?/4348O94r8f5HSLS4RDBcJIMDo/D6sIylTkEs9gwKuDV7EyAxniaCBSaKhSi?=
 =?us-ascii?Q?EYKv+hehd08Vxnl+i5V5LTZOBaTbThiQ6Ch3s3wQtvhToOionu82i7yhhMwq?=
 =?us-ascii?Q?kILU+oRlyJ1P8aYdZIaZS5ek35hgsGr6Liedn8ELm1LOwovjZUZhD9L1ahut?=
 =?us-ascii?Q?DSWYBv/JDVZDyJFD+qDXuHu/A3xM+AFUCjov0nyJAY24XZjAEgDlHEum6TRO?=
 =?us-ascii?Q?wLBD5AvcLHtVliRWUaDphyc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bObtgDpYx2WTluPoX3ELqKvddfuSE0NkzscgCJyrTbnViXhi4tO6doi37ZIk?=
 =?us-ascii?Q?/3iyd7Pw36BQ5k+xLm9kAqZiBlxlHW8B5R5zGRt+JVEHHrhT3d8aCovbM0V1?=
 =?us-ascii?Q?75ghBby8mzUo+bXEhkfNQg05oW5ybD6iY9BNoAUrnA1c3XztxPcQk954c97z?=
 =?us-ascii?Q?TDpdjsBpxDKyDbhAIc/QQU4ck/DjH+Icz3ecHD/BnP3A8zX+SaUCOtJYoM9J?=
 =?us-ascii?Q?yU2JEOxVrFPWpQJ5os3gnpo0HNZ7M5jBAT4af7xCNfW5wgRxlxPL6XPXVwWs?=
 =?us-ascii?Q?/YTgxT9K0fH284RMbTMv5ke58D/UIQVIsxwJim5erkMSgiQrRo/zCcf7co3t?=
 =?us-ascii?Q?lSS2GEZXkdzH9BlJ3LfKoJ0Io+dMe8R8/7E0Hur8y/2IhxQwMKhOFEPFn/9X?=
 =?us-ascii?Q?6s+DE+2z3DuzEEN4ctp7rZOh+w1YEiTBouDo3diSNscNkjMyTxhZoMSGSAPG?=
 =?us-ascii?Q?UzslnAmxcZIETsdqAapBKt8Rhpgo+huOMKeSJA7BS4kyzUG4xITHDcCjx2hX?=
 =?us-ascii?Q?VvuHzMjO3tn87nUrju5rh1pvj6h5pHn6o5EtNoM5gTEje1IR0NwAbi7DsNsR?=
 =?us-ascii?Q?dVeF2k7hElb0Mmd8AQY4IPSACBisgvElPQLG5jNVyQlkHKNp8Q9POr7ZQkQt?=
 =?us-ascii?Q?cD8Xbx/T4mvBUIR7JHqBYe3GxpXE0MHuKmS7dH8jaAiuHK41TMTOZLY89M1j?=
 =?us-ascii?Q?1VlAfJD1AUT9a7FqlXNhZtHe9gyUg4Ie7S/A4ezWnFQz1cdzBo7wMqSFjBqZ?=
 =?us-ascii?Q?O8SybmkxxZ7Yr1Z0ItwR4KIHMRrGRRwiSbT/h+lpd3WpfVRN0eaVlGgoE/rt?=
 =?us-ascii?Q?tzVfR0GYXoJ0uLx6Oekyk3HnWDby7xWqxjLuFBa5WFLMzyCfeTVp6A3hycJE?=
 =?us-ascii?Q?VUpfY8Q68bW1nM4IryiOm4il2A/2OGvES12IDHIeFh5alC5Tm0zZrcDFXxOG?=
 =?us-ascii?Q?lhkf/9KLEcTPlYu7us29GGN+pDUmDNJpM7EWaPVqvWvNHIeQZM4uhQzI9KIJ?=
 =?us-ascii?Q?hfkhGj/ZmGEiJxtyr20kVhAhiNURQnW43OfqDJhDJ7HErFZJhjBWUhLYqsyu?=
 =?us-ascii?Q?FyCgLaGMH3juXpE7vZceVv8/ah8TyTA34nD2vF6nWgSZ0HnOrvdZObNpzeyM?=
 =?us-ascii?Q?5XT6brBFIq+j/wRVlSap93smrt9DDwXyJMhNL3OENBGUqAWByYXH+NwpLNiz?=
 =?us-ascii?Q?nc2DnfV2P+47y94CAq4Q5Qzn6Edvqag/b9RMQNpkXrxNrw85sVMfQmvMiaOb?=
 =?us-ascii?Q?8+cFDsEb1ChI1iuQSgYfm1rRP65D6StZGZaGfhJHJU5LXhKdYP57a85UBPzS?=
 =?us-ascii?Q?L5AjLib2NMyhki+G8/xz+jVheFnH5L1VnlPVhN8fWxEWkz6bOdLEAFKwUtYc?=
 =?us-ascii?Q?B/RhqGya9Gs1DXky5MI6NANs6l+OkhVbI8o5ECaprZJ6GNZ4uObfUvHDgPyt?=
 =?us-ascii?Q?qWDZL662L8+V54WkLBS6RLfK/ppKLP02lCggAfFKSZCTs6VJx/4t7Q6+fEQB?=
 =?us-ascii?Q?GteXvYM6N1BUZvPZi1cL7aPL9l/0aVvQrEXOpS0GY5HUn75eQjqfl1H+ZYgr?=
 =?us-ascii?Q?WOOTNmz8dFGXSZh7/jfyUToqpA/AL6m8u6Q1AZ6gl2sUBzYuApP2gUg7bZhU?=
 =?us-ascii?Q?us31D0BXDZ5otapX+s/n3iCk2F8TdtAbdYEEkC+t1zx/QgOfBmR9WZtabE5z?=
 =?us-ascii?Q?tLdhH5AwUNE4mE1gzHTieOFZk3s9CjD4t4cI+ltQhRj440id8nMhl1mUT+vP?=
 =?us-ascii?Q?WG7wQgNkSp4KwLSfwGOtfHQpZkHX8Y2KSCvjCXHSrZbk9NKhVDycw84vWsmH?=
x-ms-exchange-antispam-messagedata-1: oTbDpyoaYNfRtTr1iRND7G8fEWEOIhPFumA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdb976d-f7af-4207-c3b0-08de70fa546f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2026 03:35:59.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AO2MeKg5C4bEcWr4kZlPTEebcIGR4vcazA9qr+QAB6++U36/Oizc7So235eSfi99yVivg3jqvM9whn+WQ43OcS3LDw5tiC0Y75zbTNXrm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9225
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14080-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV3PR11MB8768.namprd11.prod.outlook.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 229A316C08F
X-Rspamd-Action: no action

On <date>, Tejun Heo <tj@kernel.org> wrote:
> tmp_links entries are consumed by link_css_set() which
> list_move_tail()'s each entry off tmp_links and into
> cgrp->cset_links and cset->cgrp_links. The BUG_ON
> (!list_empty(&tmp_links)) right after the linking loop
> (line 1281) confirms that tmp_links is empty by the
> time we reach the threaded cset handling code below.
>
> The links, now owned by cset->cgrp_links, are properly
> freed by put_css_set(cset) which is already called on
> this error path.
>
> So the added free_cgrp_cset_links() call would just
> iterate an empty list and is a no-op. There is no leak
> here.

You are right.=20
put_css_set() already handles the cleanup.

The added call is indeed a no-op. Dropping this patch.

BR,
Kaushlendra

