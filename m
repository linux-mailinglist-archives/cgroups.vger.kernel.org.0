Return-Path: <cgroups+bounces-8689-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8768AF93CB
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 15:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2601C438CB
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698AF2F7D00;
	Fri,  4 Jul 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LggOdICy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AFF2D9487;
	Fri,  4 Jul 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634848; cv=fail; b=fa8U9BamrPOuX7En4A/Y5Vm7PSnU2yU5UCMVA6Au0nAyzCM6L1ABYetrCsyD4wS2V4XD7kuAsG/I0wKTdLO+aSCDo4GM+4KTrwE641UqhHe1tgu176JE7WCRMxipY8h0loT+Dbti1Ia9aCaCwMG12LjGuxy8bFI3maYS//3DzgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634848; c=relaxed/simple;
	bh=kZ9yX9vegk3dkeOfo6QMYDf+V2zGmI4/+iIZOTqb15c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nFsgSJ7jHEGCHZF8gTG50xhSnbgKdz3nZYULZvc+4sI4XBPahUXtfZ1MVVhtO/xZK0FphceXUFa52VX5+Rxm4itoWfgyIuz1dWpXIeB3YlesyZHdlJSV+YWwW7aorXWLWPpjtOQSNEzpp6GZcp3DF9SAUSQnWlOdhjNxo8OmRFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LggOdICy; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751634847; x=1783170847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kZ9yX9vegk3dkeOfo6QMYDf+V2zGmI4/+iIZOTqb15c=;
  b=LggOdICyJWjs8qTBcvBjUf/pG0wo9a0kprRZ0Bs9S+2SfNP9TO5x2mDO
   AVF9Z5Baf29cv1n2vMVUYfvx/EBVby+U7aOhSjTFnRnBUV/bm1BYYocsY
   ujhl/Uw7sBC0yfrb96MoJ1C7ciIWs/NrMKTogbsdvnm/slRvwvWgDDNZo
   LXqnMI3lE3ohlrAObiWTAxUxFLa66Ud5nXfexjeWG5/9qalY6gugHpbTg
   5tJBMDsUDFrEJwlU24Caw+99rO/5bpozcTHGeg0eurI+gJwU8THAIqwvq
   Yn6VOOv7jjEaJoFbsUvCdVzm7tEKRWqP0U0M7T7FFMIBjU1oIEZnk2fcp
   g==;
X-CSE-ConnectionGUID: R37FX7EXSOuscwTC7Coa2A==
X-CSE-MsgGUID: pLrBzAyeS3+RMvHqbWfquQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="56594199"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="56594199"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:14:06 -0700
X-CSE-ConnectionGUID: 7S1d81UKQhaBIfzJn6mSag==
X-CSE-MsgGUID: A0gOQ5N/RlKYBqVgKeLRhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="159193470"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:14:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 06:14:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 4 Jul 2025 06:14:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.67)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 06:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRgFJZF4+vfMH4hV3mekDBVz5y3WWyjkq/e/t/c+Kyuy0pS/3CL1ryulk6ZPRUvY3w4XEKP/nFOuShM1I2eQhme7qAajDHYGjkzKN03JaM0cvQ8riCxeFQx+L5dQgNmKMsIC3BkqSybexIgGA+0rjswjMZDmA+uDEDjqreZDn8RV/ZKsKwKWZJJemwFlp9zr6OZU6taWuGWtoglw0ixhDunXsZTH7SfHAYwN0a4c4xrGic95ltFLXNCCSWcS2Fgmjg6yx/N67BqsgJ04oskjmPWI7oCMAtgO5GGUDDRDDNCyDRdGL5/+as37f/voe1NB0XdQw235ITycRCwWSNDXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOQa2FdKeWv+uwim6dF87Lq/QaE20SAV+kJKtTtd2S8=;
 b=Wc/x9GQFoz1Raaa6SEslanIB0I0VeRXy6asKT15FkUSnGYuwrq54RrpghoCcoo41dkeI+faeHh9j6/H32Ar7TDARepKe/hL7JT1tYWY0XtiE4+fWbpwb3GOzGzbkyasklVrECjDK/ea8RabMKpAWFLPhuwLo0A1PQFR70Y9C875pM06VkCqOXUqzEGYM4/0nCVXh64eWlNUjz/Utcrqe17THUsVvz/hoogzS/f9zkGnHxVbjX1zOCfCHDWxSN64VXIymoPHG/9bGGYQT3NO4QfAEhebNvhfWhtxRc7LwdWsSSyQif+4DpgShFYOymTWYg3Oh5HZBy8I2p2YbI7jCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17)
 by MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Fri, 4 Jul
 2025 13:13:57 +0000
Received: from CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a]) by CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a%3]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 13:13:57 +0000
From: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: Shakeel Butt <shakeel.butt@linux.dev>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"inwardvessel@gmail.com" <inwardvessel@gmail.com>
Subject: RE: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Topic: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Index: AQHb5RcNKOjgP8rvyEWnUhbN1DoTcLQV00mAgAEXB3CAAFLRAIAEgU7QgAAkKICABfAQIA==
Date: Fri, 4 Jul 2025 13:13:56 +0000
Message-ID: <CH3PR11MB7894766BBF3A24A4174D41A5F142A@CH3PR11MB7894.namprd11.prod.outlook.com>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
 <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aF7L8jRkWm1TrwSu@slm.duckdns.org>
 <CH3PR11MB7894D2570AEA9AB67DBF706DF146A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aGKxvQdAZ-vSd48D@slm.duckdns.org>
In-Reply-To: <aGKxvQdAZ-vSd48D@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7894:EE_|MN6PR11MB8170:EE_
x-ms-office365-filtering-correlation-id: e130016f-c184-42c0-d775-08ddbafca21d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|42112799006|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Y5/FBuv1pjy+YI4SpvH40uFKZWz8ga2k/4HtFybfWf4w2hlSvHSAt4w866ks?=
 =?us-ascii?Q?WhJofcun8iF17QKki1eyCjT1K8oAQicSLOrGSKlIEPYAn8msOkLwb4AjHCLS?=
 =?us-ascii?Q?sAd15korg4fBpgPKN4LFTpcSQyAsES+I3j2EP8e4owyWF3UiJl7CXicg8MSM?=
 =?us-ascii?Q?Nhmxy34FjX7Oc/B79neQHyGXbt7HEUfV7upav5yx7UMKaWWbve1i/aZ4TUSf?=
 =?us-ascii?Q?Dd2PE//6onAYRZM9DtvJgGZQx7AMCdzrFuJJ0R2KMDUXRJqbxEYOfi6+nprX?=
 =?us-ascii?Q?OeAO7/v8IWmHkHOhOi1MMos75uyAXejY6beyLQ6o98WPMH9xx3txxsqMgZrw?=
 =?us-ascii?Q?MMym8uVZw8aNZFPCmO4bg+l+xNYCAa4IqBwnBdniEfhZdW5nN41m+hkm31mL?=
 =?us-ascii?Q?JPNH7qQ6CSqJHLLGL2tuKmnHhrcz7kR1wwMpPSISTrS4yAbr8jEGQJmaVp2g?=
 =?us-ascii?Q?xiIhOOhgZOacoJlyC3cD8Ony5BkxkEfv+VGulEccKQQ0oIhlKc2EDH6iFk5n?=
 =?us-ascii?Q?Pki2GHskQyUyzOjqPUNRset/7t/tT63/YxRlnBmeoaio47pYvHdXcT9V9eY6?=
 =?us-ascii?Q?gEW2v36ohWX4Ot2JcId/80CytV4nwDzrxNZuiH4Cpf6wbPTzKpavqWpAc1cO?=
 =?us-ascii?Q?Nlbr5IZ8JxwlBpdkM9pkXCQANH78Q+7hmrcinSDM4C+3O3agzA8vVKyPSzux?=
 =?us-ascii?Q?DwZJbK0xj/o/fQ0vV/Vv9xBug/Nynr58k8MfYshJrGdZCoaRsnbddetMmH23?=
 =?us-ascii?Q?9fmn1xb9T4DJsmkHpR/B+6ERHsNryJL031lhlBUTYRU9gk19QS0hoBsgNZbh?=
 =?us-ascii?Q?A0t2NwJex+UWO8ZjS5DKNm5HCvrnKXgdiCFJJvY9dxfk9lERc+eVSz9qEZwX?=
 =?us-ascii?Q?CB1UjZbvct4li1N2OKRCabf2hLp80ruo5uHKuoVADnORGRRnGqEfvuKdxhFc?=
 =?us-ascii?Q?RFiSI4eo7h2fXWXThCr4FYNs6vKdmna9nPhgyNg5KLXrXMznjv0D5PigMt7J?=
 =?us-ascii?Q?+7sML/H48y8ZG/239ysV6TrjFm27Q5Ha8y02RnwP+hcQOtwYcJLrI0/tGEum?=
 =?us-ascii?Q?ERPRRb5kzD5Oza6Aa0aOycsTjhtV59EOJRwC3OO6AW0gjBl2uQRO0kT5X12o?=
 =?us-ascii?Q?iYvie+6luiTsrljQgEEOvnbiPKleMNMCxzbiZsOW6jFIAikBcRAsHn4yqQ/W?=
 =?us-ascii?Q?fNS30EFHXZA4QlZm3GA4cI08PzuulyBb97beUmKmrVkdbjwjhuqHKXe6msPk?=
 =?us-ascii?Q?yKKuTnZ2w3/PY29RcvnkVO+LWblmd2CB+Wfgzr6bDOpmwAInPyTh5aJ1+w9p?=
 =?us-ascii?Q?vmJgPBF/TjMO7qEHq1cpRU6HuXNR7yeMMYU6HDqFGmNZQMPG+OjN9hg9/S+F?=
 =?us-ascii?Q?LeEOlmrzV2dkuhYYmdJqiI23+m3mFEThtaes1bAFnezA3qfuKgEC6SSkog94?=
 =?us-ascii?Q?YfdkAt4PbPWFoUWWhoSUmN6df9jdR8EMYYGNSCwqpVHJGIegdeT2Rxb2CfDd?=
 =?us-ascii?Q?v9i0tm03LaZT+u0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7894.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(42112799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Efb6WVYSUanOwp9lpA37bn/PmB3cHoh8JOOPvmHkPPi2xmFiqdDu5sLQyMX0?=
 =?us-ascii?Q?fh1C+1imGpFYdwLWYZUOZAYOIGsIZTm4KdPM2HFyEGiLoDAcc85Um3MBujlv?=
 =?us-ascii?Q?gv6+jLKMUpe98ugtX8Wv8BPHUHgdt0pHxXu/AOCW4V7TtsHOiZU+1OwdWRJT?=
 =?us-ascii?Q?GxHb35j3hNgYeq1vFy12iUjXt2vui+hVlo7FNBmL18bi47BqVPqFwdbdj9sD?=
 =?us-ascii?Q?GgJe/qJ77dxO3og6WiG/u9SUtEntFcytCpZ4EX02od+r9yS2tRniskIHi81z?=
 =?us-ascii?Q?Ptnv300O0qLBC0Be/qh6jEjgK/OsXOseLAlnyygvcerrCHIe5vsKPKNVlYaD?=
 =?us-ascii?Q?l7RQpkJANcQHAVlpYfArLAIr1s1WtcEpEG7jw0PZ0jDt9Rs1R/T4anlwVjG3?=
 =?us-ascii?Q?6Xk45TU99X74QX/YJwqT+WaA6If89Zj8AWtrqaohTMnkxOiSBDNsed/2d1pa?=
 =?us-ascii?Q?OnPP8xQ3IkM81ZUCplEe9RCwK+/kop/2cpQ3YkC1r4j086gE2Bip8BAL6x6g?=
 =?us-ascii?Q?wbUp+QuHk3Bv6gZBKZgrvl+FjPrug3VVgRK7ZKdwvkbYkk1zUNl1xYeYJtoI?=
 =?us-ascii?Q?hOvJE+3Cr33LXTrJY7lguDVS6GU5Di4l3jzV30LTqs2rq12T1DPw3wWN018S?=
 =?us-ascii?Q?AlDVNPAFe8ir344Dcc+cnWg+QU2o5A5RZut5v6brzlahjBelpm7YQ1C8fZh9?=
 =?us-ascii?Q?4QAaYa+3Av3Yjs0PQU0YX/7ecEYTse9nDeppDpjEt/wsk/DqNBXxoMVqWOBU?=
 =?us-ascii?Q?rsTPU8bsk6DWxf3F6GIS9Hc6MhJnz9CddmSFaKZEW23fQVa4Pv9mZXlKHavp?=
 =?us-ascii?Q?FdJVW7lbJA8kiMEN+xArtPql1STnP9dRbbTIgP7IL5KmkMC6oaV7OMVDE79a?=
 =?us-ascii?Q?dcayuT6IWOs+wuq8Z3OuUpbAVfbwcfYkTXdC/163xORq8//IMNQNgMllZQfl?=
 =?us-ascii?Q?I+ZYKwQgjnL7z8qpCUZGIDzIBPbfkXcgQNPrRuZGA6RSpM+Bv3EsFAq9iJnq?=
 =?us-ascii?Q?ksrmvPLMjYCrwqZ+aKwnBsoLHc262UzNaJNUQl/Er6DHcq0AGHGysJQdjw9Z?=
 =?us-ascii?Q?Oe7iMXxnQyE+j1FT06nhQWGqoh6qFmyh8VmSCOgSQ7wJWlgBxGWZrCSKHMH7?=
 =?us-ascii?Q?1YayvOgVp7EDPb6SLhUbHdjaSKIlG0bhwCBeBoalegQXV7XZKkyCc2rxR3py?=
 =?us-ascii?Q?Qh6HPPVxLRwG4bl0fQzRtsqti3TJSDhvjBWSKJN8np/BO6EPvad89Ci4fDTs?=
 =?us-ascii?Q?tKJ2eRS5O/Q2PHBlCLoT6LF6ui/5M7PYEfEVjbzy16NFAIK8Psa4/wqih7Hr?=
 =?us-ascii?Q?6TjXRvdeQC0TT9xCNiHGNImmST0n2lnAyK6hE5858coBg4xNCdIhvsCS0nRp?=
 =?us-ascii?Q?NX5SLjvnk2B47bVXNrJqgMhc9DzJ8dxOL+2bcXhOkZ64h4p4kyPqy+Rb2qiT?=
 =?us-ascii?Q?a7crsLTnSY+eITGiv465iOQ0y/akIWuurBhvvfYri6d1FY7neZPo5KaLU+cQ?=
 =?us-ascii?Q?guR48fr6qx67VVnCNY7nzmzy1pC/bXNOuXbwTYGfyYQeVLpMGumSROLzGEYb?=
 =?us-ascii?Q?60GBgRDCx83zn/JpttN3jr0a/jivEvRHXqCgEdFId4UKzxfo0bRg2ojfMVUS?=
 =?us-ascii?Q?4g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e130016f-c184-42c0-d775-08ddbafca21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 13:13:57.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: at9BfXfAZuv0LGn357eW3lOYBpBgw+ensE/SXKm9mLslg1FxyMXr8MBAxBPP+9/DwvOa4iUbavbb4OanGxQhs5Lv9GlCrrm8gmgXbOen4tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8170
X-OriginatorOrg: intel.com

> >  > Also the response to the tearing issue explained by JP is not satisf=
ying.
> >=20
> > In other words, the claim is: "it's better to stall other cpus in=20
> > spinlock plus disable IRQ every time in order to serve outdated snapsho=
t instead of providing user to the freshest statistics much, much faster".
> > In term of statistics, freshest data served fast to the user is, in my =
opinion, better behavior.
>=20
> > This is a false choice, I think. e.g. We can easily use seqlock to remo=
ve strict synchronization only from user side, right?
>=20
> Yes, that's second possibility to solve a problem.
> I choose atomics approach because, in my opinion, incremental statistics =
are somewhat natural use case for them.

>They're good for individual counters but I'm not sure they're natural fit =
for a group of stats.=20

It depends on what we consider as a group of stats.=20
In case of rstat cpu we have statistics printed together but independently =
counted.
The only exception is sum_exec_runtime which existence purpose in rstats is=
 unknown for me.
From what I can observe and read in code (in rstat context, know about usag=
e in sched) it's just a sum of stime and utime.

> A series of atomic ops can be significantly more expensive than locked up=
dates and it also comes with problems like split updates as discussed in th=
is thread. I think most of resistance is from the use of atomics.

I just can't see what's the issue with split updates.
To illustrate let's perform an example thought experiment.

Let's assume we have three stats A, B, C initialized to 0 and execution is =
set on 0 unit of time.
We have two cpus which one want to perform read operation and second write =
operation at the same time.
Cost in time is 16 units per update operation, 2 per read.=20
Let's start the read with 16 units of time delay but write without any.

Lock scenario:
Init: A =3D 0, B =3D 0 , C =3D 0
cpu 0 - write {
 lock
 A =3D 1
 B =3D 1
 C =3D 1
 unlock
}=20
48 units elapsed

16 units delayed
Cpu 1 - read {
 spins 32 units
 lock
 read(A) // 1
 read(B) // 1
 read(C) // 1
 unlock
}
Result is A =3D 1, B =3D 1, C =3D1 after 54 units of time elapsed.=20

Atomic scenario:
Init: A =3D 0, B =3D 0, C =3D 0
cpu 0 - write {
 A =3D 1 // 16 units elapsed
 B =3D 1 // 32 units elapsed
 C =3D 1 // 48 units elapsed
}

16 units delayed
Cpu 1 - read {
 read(A) // A =3D 1 // 18 units elapsed
 read(B) // B =3D 0 // 20 units elapsed=20
 read(C) // C =3D 0 // 22 units elapsed
}=20
Result is A =3D 1, B =3D 0, C =3D 0 after 22 units of time elapsed.
=20
48 units delayed
Cpu 1 - read {
 read(A) // A =3D 1 // 50 units elapsed
 read(B) // B =3D 1 // 52 units elapsed=20
 read(C) // C =3D 1 // 54 units elapsed
}
Result is A =3D 1, B =3D 1, C =3D 1 after 54 units of time elapsed.

The difference is that with atomics you have access to the fresher state of=
 A statistic in 18 unit of time.
After 54 units both solutions have the same result.
What's the issue here? Why user seeing A =3D 1, B =3D 0, C =3D 0 in 22 unit=
 (instead of spin) is a bad thing in rstat scenario?

Moreover, I consider lock solution as inferior due to complexity.
For example, currently the function of ss_rstat_lock can return one of two =
locks.
Global rstat_base_lock or lock from cgroup_subsys. Lock for cgroup_subsys i=
s initiated in ss_rstat_init.
When? Why sometimes during flushes we are acquiring global lock and sometim=
es in happier scenario cgroup_subsys lock?
How to generalize performance solution here? Context of states and scopes t=
o remember when crafting a solution is larger in comparison to atomics.=20
Even now, mainline implementation still has race conditions. I know that th=
ese are worked on right now but it's a sign of solution complexity which es=
sentially atomics clear.

The patch removes more code then adds. Have much better resistance to stres=
s than lock.
The code handling 32 bit  __u64_stats_fetch is gone because it's not needed=
.
Makes everything simpler to reason, scopes are easy to grasp, opens opportu=
nities to further improvements in submodules and clears all races detected =
by KCSAN.

> Can you please try a different approach?

In last few days I've investigated this, have some success but nowhere near=
 to the improvements yield by atomics use.=20
For the reasons I mentioned above, locks approach is much more complex to o=
ptimize.

> > I wouldn't be addressing this issue if there were no customers=20
> > affected by rstat latency in multi-container multi-cpu scenarios.
>=20
> > Out of curiosity, can you explain the case that you observed in more de=
tail?
> > What were the customer doing?
>=20
> Single hierarchy, hundreds of the containers on one server, multiple inde=
pendent owners.
> Some of them wants to have current stats available in their webgui.
> They are hammering the stats for their cgroups.=20
> Server experience inefficiencies, perf shows visible percentage of cpu cy=
cles spent in cgroup_rstat_flush.
>=20
> I prepared benchmark which can be example of the issue faced by the custo=
mer:
> https://gist.github.com/bwlodarcz/21bbc24813bced8e6ffc9e5ca3150fcc
>=20
> qemu vm:
>                +---------+---------+
>      mean (s)  |8dcb0ed8 | patched |
> +--------------+---------+---------+
> |cpu, KCSAN on |16.13*   |3.75     |
> +--------------+---------+---------+
> |cpu, KCSAN off|4.45     |0.81     |
> +--------------+---------+---------+
> *race condition still present
>=20
> It's not hammering the lock so much as previous stressor, so the results =
are better for for-6.17 branch.
> The customer has much bigger scale than 4 cgroups in benchmark.=20
> There are workarounds implemented so it's not that hot now (for them).
> Anyway, I think it's worth to try improving the scalability situation,=20
> especially that as far as I see it, there are no downsides.
> =20
> There also reports about similar problems in memory rstats but I didn't l=
ook on them yet.=20

> Yeah, I saw the benchmark but I was more curious what actual use case wou=
ld lead to behaviors like that because you'd have to hammer on those stats =
really hard for this to be a problem. In most use cases that I'm aware of, =
the polling frequencies of these stats are >=3D 1sec. I guess the users in =
your use case were banging on them way harder, at least previously.

From what I know, the https://github.com/google/cadvisor instances deployed=
 on the client machine hammered these stats.
Sharing servers between independent teams or orgs in big corps is frequent.=
 Every interested party deployed its own, or similar, instance.=20
We can say just don't do that and be fine, but it will be happening anyway.=
 It's better to just make rstats more robust. =20


