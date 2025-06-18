Return-Path: <cgroups+bounces-8589-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B5ADEF66
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 16:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0CB1896FDA
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA22EB5A7;
	Wed, 18 Jun 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7TugOQX"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AD2E8E00;
	Wed, 18 Jun 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257151; cv=fail; b=ggNhyl3F6BOEag6lkBQBxzuvYmkM9978V135Ue63Lx7uW/3Fwbv8uKqXc2PhYq5h63AGtBBsUi8A3EEBzW6offA4n3WO5rETXdQVZYm/3FSm7FkdJPPE18rbKQ3EysJxCnf6+07UPJV3d3FdyKU7skS5hBF3MmOZVRhW5hpyM0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257151; c=relaxed/simple;
	bh=56ICOV9MlhaSO+1XGoE8d2k2Px3zuAnw7YPTn9b+q14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HJ6tUi7/G+h7ZkcROkOK9Zi/QjAUOGSEPKe1qfixU3DbkzHQxYIN/LxKWhMDK9WLDoDjXGrjaI40qw9keQ9x1/4GtmvxN3XJGPCFRCHktNfYOdztRAh/CmHCggQ8a7MK1s9Ax9MxObizfAPPfaMagwMagbPL+dWLNe5CmUtr6dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7TugOQX; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750257150; x=1781793150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=56ICOV9MlhaSO+1XGoE8d2k2Px3zuAnw7YPTn9b+q14=;
  b=Y7TugOQXTUETL2YdO4qg39dULoMDnjc2Br69uOYKuvTinNUg/kfzTA4T
   b6gRDaSrcJzqNwpRLMtlgmoaLZr/6Tc+Bjg8yLWUE/R19XHv3jYt9+PGy
   etWn3ra1f+ZVa2wD6ka9e40b1lFqA/YnZUNRzK7LIXbVS9Nd3gyZspnZu
   XlINRMlq/Hvr1eafseHeA/JkZkbJRuMs7ikKhZXT/pRqn0eBOJqZMPUeN
   F5DbMjPRUpmHXUUn4OCQHf/VcSeU9pBELUxOBwnU2CfeMGr6tdGMIVZiC
   22mxNZdKjhK97ylTCmv3rkEdxMI9D482n27Ari+xUNajC78C/6o/djOFO
   Q==;
X-CSE-ConnectionGUID: KgvtP3FUQsOz1ALgazQ7Ng==
X-CSE-MsgGUID: wQqvOw2QQE+PrYDHupbmYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="69920576"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="69920576"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 07:32:28 -0700
X-CSE-ConnectionGUID: rsPCBshCTxm3c5iCgdnKFw==
X-CSE-MsgGUID: cfHZU/EuTle1bFUPhnUi/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="155111025"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 07:32:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 07:32:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 07:32:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 07:32:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuvMGZLT/ahL+uAkQg9uOt2zeWNV974FwdsTFfWNV12o/jO33+qNbuxhFmm7dbXnrak+QJNXHmgO8pSGkwiN7x6AIHcx9bRLJ4mtel0vQFWylQXVqoOFYuGCuT0VhilTqkM1JqzSW8dXyBqyGVYXApOQYR8TxV+/rDqPV0zMdv0SS1uWFCe5s5+XycEAWSzeKAMJfITFgwFlOp+HKyuL9EJg7X8qdVua/GPF1DMmSiLTeaPeSEc9y3cL7dPZ1iZjlc2w8fRyCGeFCKbTsl0d36p+XZ7ERpKvxqEsEeID3nwkLve8sI5/Hoxa3TXkDAZr7EUEnprRaFLDGTGlclGxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56ICOV9MlhaSO+1XGoE8d2k2Px3zuAnw7YPTn9b+q14=;
 b=oLgXqX+SDuYQzyFpYVu8GG/1w7XrPmyGCHP5BPYI4j13H0K8RVeik8ICn/nUwm/Oz8ocZNiYzjFIpaeG3zq+BuJ/zwpl4v4zIqNbYC77vsihVUkazISAFNGBAOxwzLTK81fZD1XiLRWMhi10agCVyFwoQdKY7BCZF4BbyzeHjwm7/x3ULkx2xhTA/z9Dhn4VmXjBENHmURsMFZI/VU5on+AbVa64//zCSqnPEPpsbbY1kAcZCi2LDcGKUscTQEUSPpMEwuz8lA+rRJQt7moCr9HjVcwLlmp1xJfpAqj5xau8qsxAYYN28A+d4qwhUGtYBGyFqA/8mrmkoZZSto95Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17)
 by IA1PR11MB8788.namprd11.prod.outlook.com (2603:10b6:208:597::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 14:31:54 +0000
Received: from CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a]) by CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 14:31:54 +0000
From: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
To: =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC: "tj@kernel.org" <tj@kernel.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, JP Kobryn
	<inwardvessel@gmail.com>
Subject: RE: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Topic: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Index: AQHb33LUrIYV3Cvt2k+rQD7YLlN2JLQHVS0AgAGho8A=
Date: Wed, 18 Jun 2025 14:31:53 +0000
Message-ID: <CH3PR11MB7894190E3C849233A444E5CCF172A@CH3PR11MB7894.namprd11.prod.outlook.com>
References: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
 <ftih3vsbegjha32tjoktayjyak6zs6n7cbfuwzjasutexqiluo@pjauxm2b6xmn>
In-Reply-To: <ftih3vsbegjha32tjoktayjyak6zs6n7cbfuwzjasutexqiluo@pjauxm2b6xmn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7894:EE_|IA1PR11MB8788:EE_
x-ms-office365-filtering-correlation-id: 1eee9091-5a61-4e86-034d-08ddae74df2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UQ6c3n/My+6ZhP8lQlZDeEz/y4CCOJl677KM6aVHM4sCTHcJ3BamKrJBeK?=
 =?iso-8859-1?Q?LxNDU2RmlfaYWFqjD7OBd3JQSvC7R6ogrNDSTIrGfNcGgPKouMCYiNKg7g?=
 =?iso-8859-1?Q?AdU6TtJTMy4M5ZRqQR3XClNK9SamJkJi4WUmR/Rb7AYkGRw3CMITXfnLaG?=
 =?iso-8859-1?Q?B6KpqllFfDa5DyOnJzuW8bPKcmfPz9ZOlsahzfs6iiiE8evJDHLOjxQNwJ?=
 =?iso-8859-1?Q?7kWrD4oV62hkEtwfqyywumh0Ad2BRU+Dfyy2Py9q2iJ3R4o8hOkQYWz7NH?=
 =?iso-8859-1?Q?Zjfk2bQylfExA6PNtnzgxs6FYvP3DUL7YwN1SXFu0X+8lWQwJ++0yR3bKn?=
 =?iso-8859-1?Q?JCKuxRcKir+0rg3D+swwVlLRzcgt184ViwTzWrFiCTteKXLWrSR0chDpnr?=
 =?iso-8859-1?Q?rfeAuyUKhUUyG9BSQiCpO0gs0xQl1QIyrK5prGSdy1iiRFlMd3p3lnYnXj?=
 =?iso-8859-1?Q?RIxUERyb1gtX7FOC8TFN4+0UaGuAzJ+tHv5M2dpcNN1C9e/+N0OHt5IWT5?=
 =?iso-8859-1?Q?GfMAL8BOk7jI2LuJLlbSDo43VxRJfkxsf+J7YJykFYcV3PyaKI68I4I3g1?=
 =?iso-8859-1?Q?q8hitbjrYbHvlYoC2DdQ7x/m3exk4ozPBu13a0LwJKQ1XgHeDxef0KbiTs?=
 =?iso-8859-1?Q?mlMZPoDqD8QUQZ0hLoapYIw+UbfvBJzwFamacu7Srd95C+7Pwbl2OV502D?=
 =?iso-8859-1?Q?kI/yhk4w4SAnBMS+1YX++2gOdHTYX2kHgyv+1LDYK4l+xJE4UzjtAPLIsF?=
 =?iso-8859-1?Q?OT2VWDnEhxl0YkM42Px3hZRn0s5P7njGwantaDuTvO4wVn28ASAjT0gxDW?=
 =?iso-8859-1?Q?gEnt5aellNPvK0IjyL4k3YxsVJcsdmUQKE7OxAxzhmoM/c0CtDk60NCbYT?=
 =?iso-8859-1?Q?f0qpPCcbp2mju/wFDnWLiwV0klE0qYGsQWHfAEFaoDLWGctxGMII6qwxfO?=
 =?iso-8859-1?Q?oRVQMAFznggMmADu0+OHGUmOd8/tgapymHpqQgcqd3dwbA/zTXetW33uxJ?=
 =?iso-8859-1?Q?uIUo3+PhyUlsLIuTbRD9IzjBGRYscmua6IEz7b9mJu/xW19AMNeYvzOrta?=
 =?iso-8859-1?Q?B7X7kAAkDZOKqvi6vhB3mkRhy8UugY9fcltpaSl7Y6gKLH7YcaGTid4SZY?=
 =?iso-8859-1?Q?G2PcGYOFxgZsLp9ZoGHU/Sc5O69w2KcdVp+vZCivS2cUP3vkZJt4iL6rcb?=
 =?iso-8859-1?Q?8lXZCPmuk430q3+KGJBCfht/frXK9jiwSG1R1NidYq35VVtxpAkhEfkjDD?=
 =?iso-8859-1?Q?cvd8H9hQW8pthZ4N77JZHbIo1apK3mssXqye2HiRWuKaYV0z2FWPEXc2A5?=
 =?iso-8859-1?Q?coDNbPQgWywGn0NzcHcDprjoDuakfmoo1WYNzMPDG4TBmPqyJ6QF2jjzAF?=
 =?iso-8859-1?Q?gsw4OaQAhX01OF+/xORy6cxoqy/MSGL27zZQznwAHRkOtSvXCEhtsKMWp1?=
 =?iso-8859-1?Q?vLJA1vcGqdKJLRKoSkXdAq6qORXIr70DN6qtcCNI/hjG3+JEDppNwHZ1E0?=
 =?iso-8859-1?Q?JjZKrqqiBnbzXwMPUmufF3fmComBmqaB9msEL3qq7Uig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7894.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hxgZTZxH2JDHNbhoY84IvvIrWRhxW7bDH2JJx20ixKhabUFbRA8rk1E4KS?=
 =?iso-8859-1?Q?d1xPORyq7Ekm6RKX/cw5EnF34F8AYCzaz6/R77Uh63RnctFKVSlsHcEbQJ?=
 =?iso-8859-1?Q?VRbd0WJd1SzNkD62CQU1tQb+LiUfsPxC0GQH5FP+pc3Nid0H73HSozGcUx?=
 =?iso-8859-1?Q?oEXjhO5QMvb3g7RsB/buVsiaVVF0l7uh7vEolpxZMDV7mQpTJ3VlPSomeA?=
 =?iso-8859-1?Q?BAMw+I+woAGkuF/ToBe9twcuPQqhIZM4rBe02e2Y51ZRR3k0aVV7b+A5Ax?=
 =?iso-8859-1?Q?L592Nluwd8QAlEsibMvGyi4u80vm2+9rlQ8IUmu/M42S+5dIPLCqqh8JYL?=
 =?iso-8859-1?Q?qT0ZlkqXBUNkoe2uMGr+tjCu1ahhzzYMKNWlykLfDTUUZWDHB7JVZ/cAwa?=
 =?iso-8859-1?Q?L0cMQGYZk4JkrfH+XjGGRRmVnh9QaYGZWk6DfVV4+/CYcPhGOJuMXeb04h?=
 =?iso-8859-1?Q?UFp9CpXWSF5FO6x/wtOh+nqRzkLFleKfin6bHnymXD2B6Ji7hYX3Kddm2h?=
 =?iso-8859-1?Q?GGALfK8yVg/FlTY9nJHTO1oFlxDJ1VKmhEiZehm48pt9fAORFQpGIrerV+?=
 =?iso-8859-1?Q?FCEc69qNG/hDypH3M5XCdBjt0DtqpPRGWifBhvTQLABSyyYqpPd2b5FDpq?=
 =?iso-8859-1?Q?FRiiTY8+ROfk9K/QEjw3+vBAac9lfsfbNpb1hOKj5ckE8wRZFnKEzg/g2y?=
 =?iso-8859-1?Q?TZXlJZP9J2JeTB6guT6MyRAQdNGWYbYua7YyO/itNXKY8chFUjJuAc1t4J?=
 =?iso-8859-1?Q?Vi8oESdWTsKtIhmv6gvQNTsQLU09AIn93CDwAtdl+SICLphX8uhLqlwbfF?=
 =?iso-8859-1?Q?n86xhSOCU+6pqWaSxdAXF87ubPHwXYQ0mdsgXLtG8gkyqFwh+q4crQr4k+?=
 =?iso-8859-1?Q?ZNMAs3JM3AoE4DMQRK+GNSYP39V34by9EqJXsSTBbqYhernChmNeytciGd?=
 =?iso-8859-1?Q?jkueVt9q94RJBrc9N3dnFOXXB0ryY9gbA+fsRGeci+KpvbKCsWZp1wiwOR?=
 =?iso-8859-1?Q?D1rNg88L7MghvLoaP2K1a8NeHdDkEcQutWkoC+4jB/00/5fqXXdAgQDPrf?=
 =?iso-8859-1?Q?SP4RLQ+dsE8S660qlnvPioryjWz24w9YBiHnj3ZujrYrV+YusWEH/t+P4h?=
 =?iso-8859-1?Q?tesJ+E0Uy8Wh8qWWuC2B9yzC4qUahiSzqmlSA3ZMBnaNjro1vQpsEqaV5I?=
 =?iso-8859-1?Q?O9TjBwocMJ8VGoDJF2UIo2KreZ5c0tgvaMSN9VyjydsAt4V885rCAmHiaj?=
 =?iso-8859-1?Q?Cjk5vnwfPm97ZtRCoKgahZ74f9COX9qjx5hRCRt0KteIMT+RyeIietrxhK?=
 =?iso-8859-1?Q?g4gzqDIiP694am5hHcUq0XAQkAeATT+YU+0aC64xvRjQV3BsA8q5tCfLR1?=
 =?iso-8859-1?Q?9UAI3BxV6NW3TUWOBxm8wvM1csg/CwtyeRTPDuovxvQnHWGxrZMRhbpjd/?=
 =?iso-8859-1?Q?IV7+8kQXjmIEt5ItGmPlJcNAD6E7YMcL2hO9Qm1IXDSd5mP/coqPlzRWVB?=
 =?iso-8859-1?Q?DXUMajJFbT4IZV74LdewaJ7bEpwvNbziS0MtMyE7rcPdoffeBfhFp/4TQv?=
 =?iso-8859-1?Q?HNFxJpKg2/k2jszxKhRdzZbF8Vu7b6iM3QCRvvfF+Gfs2NHfsZvqSDZrRh?=
 =?iso-8859-1?Q?9aZ2oC3/q4cs+UnTvY4f/Rn3dwTRsWxfR3Ys/PYEiF86LNYN2ilg+yaw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7894.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eee9091-5a61-4e86-034d-08ddae74df2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 14:31:53.9662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E81nRtxl7tekbMiVPVujgOHoJaY/XygZ8+tXclPIGE6dYvGV7vbpmpHsaQIAOg5lzDVGIRexZxLDonKZdu0Tv9nBsPVEbBuAUvg/zQICluQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8788
X-OriginatorOrg: intel.com

Thank you for your time and answer.=20

> The kernel currently faces scalability issues when multiple userspace=20
> programs attempt to read cgroup statistics concurrently.

> Does "currently" mean that you didn't observe this before per-subsys spli=
t?

That means the current e04c78d86a9699d1 (Linux 6.16-rc2). It was observed b=
y our customer around winter this year and it's still present.
I believe it's present since the lock exists.=20

> The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,=20
> which prevents access and updates to the statistics of the css from=20
> multiple CPUs in parallel.

> I think this description needs some refresh on top of the current mainlin=
e (at least after the commit 748922dcfabdd ("cgroup: use subsystem-specific=
 rstat locks to avoid contention") to be clear which lock (and locking func=
tions) is apparently contentious.

The main culprit is css_cgroup_lock in cgroup_rstat_flush. It's locking css=
 although the main algo operates mainly on per cpu data.=20
Only propagation to parent needs to be locked but only if the data isn't at=
omic.
The benchmark results were gathered after the patch 748922dcfabdd on top of=
 the commit e04c78d86a9699d1 (Linux 6.16-rc2).

> Notably, performance for memory and I/O rstats remains unchanged, as=20
> these are managed in separate submodules.
=20

> Additionally, this patch addresses a race condition detectable in the=20
> current mainline by KCSAN in __cgroup_account_cputime, which occurs=20
> when attempting to read a single hierarchy from multiple CPUs.

> Could you please extract this fix and send it separately?

Unfortunately, I don't have it. My primary objective was to resolve perform=
ance bottleneck during rstat access for customer. I found the race conditio=
n by accident after my benchmark (provided in gist) run with KCSAN. Didn't =
investigated race alone.
=20
Thanks,
Bertrand

