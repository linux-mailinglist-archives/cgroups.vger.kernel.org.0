Return-Path: <cgroups+bounces-17599-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNdNOJNcT2rTfAIAu9opvQ
	(envelope-from <cgroups+bounces-17599-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 10:32:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2F72E51E
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 10:32:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BZj5DZ18;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17599-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17599-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23D1D30678C3
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815C3EFD15;
	Thu,  9 Jul 2026 08:23:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B83EFFB9;
	Thu,  9 Jul 2026 08:23:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585435; cv=fail; b=Kdp1ESwq8EQ+TSdNPlUkkLsqdloMPEo+KzonyyY9vcbv7/B1skYI64ljc8pMVXcT0+N2CNl818H/uZ9B0MyILLwEjRqMblevGfurfnCERD50FFnyZBFWzG3D7hDeA0r/F2SCArCWVXL1GpMnfT6L1t4a79C/cgs1/yKq8X7ke+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585435; c=relaxed/simple;
	bh=QwsH6NjvJE5NQUF76c4PvOl7uzwNRDROByrpmJRXoCk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jt969c3TmNkWdKyjcCTgQwrfZ20AiENabg1lozQSJjaZHJwRITmyNKYsVrIKLWTVd5nCghOrNb9YrHoPI9GxPD7Bx+GKKFvlnIiZYGWQpV6PAzkVcMOCnporA0TFvsdRLCwWkm8QfCgOx4TMkQp10C+/WkBay3PCWAIwNa8iLaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZj5DZ18; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783585431; x=1815121431;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QwsH6NjvJE5NQUF76c4PvOl7uzwNRDROByrpmJRXoCk=;
  b=BZj5DZ18PS8bA8YlcDIX1zyVvFCTdbDCYdkVYXrM5SmdMufs/649k8xl
   BqjS+slmqFf68Rmi9thZhF7ZhT21tN3VlPiAMjKtA6GhuWTBlXj8Ik+Gd
   axJBJGSAiF5J70cZr+1l3YREp92urNR+emaK+BW/qpS12jbj7Rc22V8yt
   2QFK4yQghjTxi+svpmVBXRmVNPch9tnrtjmD1MxkRiPohHlhXMoCW31DI
   sNKbBDRarmvCoB0gIfvkTaWOb8yEfvrWPx7wQ5If5bo+m/9/7+aC7Z7YV
   lWJz86QJZmJjdMx+MsdYOuurakwoGlwKFlxi07sVCMLKH0znLNkjbhRCw
   g==;
X-CSE-ConnectionGUID: 3IIXuXwhTlKRdec1uhEETQ==
X-CSE-MsgGUID: 4vsXcu4FTNyoj3OKBsnMXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101687606"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101687606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 01:23:49 -0700
X-CSE-ConnectionGUID: Ea5TFJzBRIKcilB+9Y4rAQ==
X-CSE-MsgGUID: 6sG4sr78SvCPm46C+uPm6A==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 01:23:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 01:23:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 01:23:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 01:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdGBsKb77wGg1J5aDRMiCKHcxpqkYQCtK3NVlH1cXg9oyxUUKmpnMk6lZHjbCX4OtsyJM90opSavB578mszhzdzn8IOGkJzjdrNLD3kQmtdVOca4sAOmPxa9Xeub8SX1w9rIU8dhvmY047dsTdHKfHREbfUEjIeEmH3GRA2f09QexZFsw3NvLIzm8ItBCJkQgueGY3GbugGwhgRjyYtj1vVoNczu/n4+PMkoBiIOtViXQpooIioALKjBhN42CefjOloa7DDedGkdI5xdNOaC65MQZZUKuUBRZLqW9iThu0uc1b1kZ93fhR7IDUleA9P+OXa0t3LG2lD+5HwzX9odMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+WxHTMqEHcBROG5wVc1khOaDtfR1ssnkMUuk17x0wo=;
 b=Kv3ST9Y0PVFfGqQ06qAZ4i1+MPmarcApvNFmzc8s/xl0YtPpQblkjpgaMrRxIvyv8+/mV3vYvDp2zghvab4X/zjKXMcmDixQjV8jweUqyQZb1CNDpY7BB9SlUyYfNaAB/XJwPgyPlIDrs3iXkz93J5Yo80pofPWXcntSwIX6P20RxntCQTfWsKxfJNLea8P+xxodu6GbzLPe3xLQRhVV2o+V7VFUanFNbxEJJlrlEU94/h+dNzZVxKRKvQILi1q7QqRtNCb4RLiqbZO8saw9ST8aXThvEh1NInnj8l4oSFJLEa09TqKaDYQt6qpcP/UrOGOenyO9l+HntbC9jv+AFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM3PPF341F90799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 08:23:38 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 08:23:37 +0000
Date: Thu, 9 Jul 2026 16:23:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Weiner
	<hannes@cmpxchg.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	"Michal Hocko" <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam
 R . Howlett" <liam.howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v4 4/5] mm/memcontrol: convert memcg to use
 page_counter_stock
Message-ID: <202607090957.6713a660-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623180124.868655-5-joshua.hahnjy@gmail.com>
X-ClientProxiedBy: KL1PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:820:e::9) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM3PPF341F90799:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0e0c1f-297c-410f-bbd1-08dedd935f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: +G1xpMElA7xbRdAUi5jaZZq8crhST0xGwRAYW8chB6BbmbMB2wqVbLxgxMEWmQhf93MI1ad78OaYQHd7SmNShFH/9T2EkzvXOA2B14YCiNyyNCRbUsv3rfdtjzUibWdQvUW9cOCbliiHg3p5X/+u4PTOXRvYUwcmKkdL2T3G88/pnGaTX9YVU2NyBg2fB7mHYXhJxFkYFMPlXhwW15mRDUzCOWoBO84fAy6flWun8V8TigPQhXiKSJbhE42LG+Hnsfx2ckGKc4l5LSZMwNdZWFoo3wJWFX+2I0QhJeyyUY7tuBoPXU+HLtEe9SugX8b+QRCAzSXMaWRGsNfg57Bi4OCEQB/KHtQMasAJZocDuK1uYYxPOvABAyDyM94Y6FV3y991TMn2a6I7bxWWb6Uij97bRYTicYGYrio2UoZoZ/kq1V09GU++WtCI0TeM0aQTHiLXCrJksIszMg3hEGBo+TjZZ2gybTYRMQ9w+VRI67mpisx/+Z91A40ah/t2VQH37FPJB2ZRaDeUxRHVz+MWnHDivanHESyXNsfCl9knENod/pAJPjnEZ7axs9HdHh53lpKJbj9j5B5NeyZcXfD5DohEMgM0ttlvytmStC6yeze7p302SEASG87Niq0BJgWD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3Q88gnVzrLzlgV2m0y1YT3CT2p1jF+WHW+l8T9bIPkjVrx5hYpwEw6Q6Jo?=
 =?iso-8859-1?Q?+D+CZ+Ph9Fqir5ZutJ1nEnnsxDGzmjxC5KbMcAB1icO0CP6c8Lqz0w8ize?=
 =?iso-8859-1?Q?qKzmB2wIqDrgh+Yx0u+U8KP4As4fmuYCwd/9j160q0AxJIkKNY+rosXwKm?=
 =?iso-8859-1?Q?yQn/ZqQ87hAutIvF4m7oskvJPLclTUaRtSWlHNL7zbuvHthIBMPjX8+zZk?=
 =?iso-8859-1?Q?gJns/+jm3sKlKEMNdeixb0HNb+fF+8bMSdAmFAbJ/dsfbFrwoiPjUG+R5c?=
 =?iso-8859-1?Q?eIKbZRCYjkvsrscRSEwXHct+F61wzBukMV9iQE2d5Pt76LWznAFuzM1wN3?=
 =?iso-8859-1?Q?BJeJZuEgMb/F5pewgGMrbPsGXcHi8L3KBYxm3RcHVPtO5CwZRDgzBEj4iO?=
 =?iso-8859-1?Q?d0ZFt4bYmtQrw3r5iADxm9f3Wm3eQXYN4etoZgTI/MUKjOCeCxthHcnruQ?=
 =?iso-8859-1?Q?huwbdDZwZeygKP9/fBQ6lUeD8eLVifzRprWAFnCrT8CNnogTKxStlW+x8o?=
 =?iso-8859-1?Q?ngvoh5zkuQlTx5xUKqDk0xgv0qdMzNB1P7R9u/iFe64ugi2zPaM+HJPolV?=
 =?iso-8859-1?Q?JabqhL2HTIquVbw7i7AUiax4981EDYT/OsRy/++BRUoisLZBQc22rs4b9c?=
 =?iso-8859-1?Q?Kgc+n0cRC2fwez+x9eDhLVsh78q7H5KiE56ltO+aQIc0SbDggzt1e6+tqf?=
 =?iso-8859-1?Q?8U+DgqwBFB8M7EN0b3Uchj+s5KzJ21RAG31MJkIfOrI0jFLtP9+1+usI/6?=
 =?iso-8859-1?Q?0//35HrrLRjF/QvvaP3NcUjimP0oTD+wH1a8kuQTFCoTBfXJJ1uq6SAcy0?=
 =?iso-8859-1?Q?mnOjhhYBXvkuqpBGApFD/HfB5ZdrTnORoXgXDDp7gmqyggf4NB3FM2/nI+?=
 =?iso-8859-1?Q?dZhZNmIH5+LkSdLCN5UF1UuCefhiGAektcwu71lnp5yq/ubRJhPBdRehqI?=
 =?iso-8859-1?Q?ZRyFaTah7jP4FN7CM/vxD45KcVLqiEV9ZbBoIjOXEx6TSFnu+JJ0P290jS?=
 =?iso-8859-1?Q?rAp97urYEod2YQKwNI7O0R0w9PgvYjU+r1gDeQiq5IBwMo8cjt/cI8nbhK?=
 =?iso-8859-1?Q?dxV7pKF3mIjBpFc7G8EOzNpCzVxB92iOPczwGYIFbYolbrS82NrZhUl7vH?=
 =?iso-8859-1?Q?+0e/70iiB9ErCF9Zh4UO6TDFX/YvJxhlD5hzNAiDMQYBIQ7rlU5lWadpaX?=
 =?iso-8859-1?Q?4mA4Lus4JfTOE291apQ6f/aMqw8ADwhY6WWp0xT4z/uOj4RMWRZfuxENm7?=
 =?iso-8859-1?Q?CBe7+Lqf+hG8Pz62Yq7eyhJhHoeaSqQGCYbkpAyWKHXI8xSQrP9yQzPlJn?=
 =?iso-8859-1?Q?M23ej10o+T3YC8ZKcrAwRccHSJkvLNMZXWZcpa91ZUx/t+wPA490y3MfAz?=
 =?iso-8859-1?Q?rGqJJwLrrdpWN1ewOkEHb7rLX5BK6k08mpFg8/6tjfDZw24yxJefdgHAjX?=
 =?iso-8859-1?Q?TPQmQntxvG8VaZeJWpsBDvwsLPe5YtVwM5pUFCVMVqJYoZrgbrCe+T86DZ?=
 =?iso-8859-1?Q?PS069LAVMH/AQlhA/Gc2x5s8pm2zozHbV9Frxhm4iKa0YxuUePt+lJI6hw?=
 =?iso-8859-1?Q?RVGS1bZwQyvs0zJQlc/mhgPT/14EO0m0St8Ys7hWO6LXiHUxbMFZotbogc?=
 =?iso-8859-1?Q?Ri6/qEPZrQGcjkWTpGRlw/o0Ki0AinHz6aJWzUZNUYA0+vzAsdTYszymZN?=
 =?iso-8859-1?Q?KgosRWscwjBl59BY2ZleN5vR+2ZCmAFXkiHbTBNisk5bKLmi9mBTDIaHa6?=
 =?iso-8859-1?Q?UMuf9AcC/Z6ArQxbySVC2ubAtsqTp8Mp7veHj1GN3igNRgyd/AmskNxZGi?=
 =?iso-8859-1?Q?FX0MIqIXMw=3D=3D?=
X-Exchange-RoutingPolicyChecked: WCr79TLf2xq9mDBREHz5C5pqlS+XF5cn9LeD3oNWjMSjChWz8LpHJN9/yGvCHAA92ZqGVXB7FjaEsBnEVhxz6d3Qq/DVnUGQNJy1nCmsALvlW9RBmeJ6nJKhoNNZbeY5Fjg5VEkY64664ve5yKVOvr5rJmNpaXzvm7x9ZFa4rFEEOI1C50NUYMS3IMrSY6oR8oMm/kK/gyp8WEIOhN8GW1oKR61dcqJ5TWZpfUlq+IDff/CiHVCutt0E/fLnaHTrafHRVFgWlf3Lwxt3LF5u+zJ35sWy0GN1QSiPk8EBF9VSnjzG4ztTw3Ovx2/dNcKDZhUOD6D7kuQe18AwADvsLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0e0c1f-297c-410f-bbd1-08dedd935f6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:23:37.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LCjaBLHb6z0fBblx4RbRjvG70qIE3FfVgMd+y7zRU9qJqUtXo4crSZaQC3LpAaVqQwq4Fbvq/Vl+7cVg1xFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF341F90799
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17599-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:oliver.sang@intel.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp,01.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hitm.total:url,latency.us:url,system.in:url];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31F2F72E51E



Hello,

kernel test robot noticed a 73.9% regression of netperf.Throughput_tps on:


commit: 1e8017bb42651bb1dc84917b7864ae6159866b1d ("[PATCH v4 4/5] mm/memcontrol: convert memcg to use page_counter_stock")
url: https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/mm-page_counter-introduce-per-page_counter-stock/20260624-020302
patch link: https://lore.kernel.org/all/20260623180124.868655-5-joshua.hahnjy@gmail.com/
patch subject: [PATCH v4 4/5] mm/memcontrol: convert memcg to use page_counter_stock

testcase: netperf
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) (Sapphire Rapids) with 128G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: SCTP_RR
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------+
| testcase: change | lmbench3: lmbench3.AF_UNIX.sock.stream.bandwidth.MB/sec  12.1% regression |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=development                                                          |
|                  | nr_threads=20%                                                            |
|                  | test=UNIX                                                                 |
|                  | test_memory_size=50%                                                      |
+------------------+---------------------------------------------------------------------------+
| testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.64B.MB/sec  1.9% regression       |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=development                                                          |
|                  | nr_threads=20%                                                            |
|                  | test=TCP                                                                  |
|                  | test_memory_size=50%                                                      |
+------------------+---------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607090957.6713a660-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260709/202607090957.6713a660-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-14/performance/ipv4/x86_64-rhel-9.4/200%/debian-13-x86_64-20250902.cgz/300s/igk-spr-2sp1/SCTP_RR/netperf

commit: 
  35587f026a ("mm/page_counter: introduce page_counter_try_charge_stock()")
  1e8017bb42 ("[PATCH v4 4/5] mm/memcontrol: convert memcg to use page_counter_stock")

35587f026a945238 1e8017bb42651bb1dc84917b786 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  11703768 ± 15%     -73.9%    3053446 ±  5%  netperf.ThroughputBoth_total_tps
     26124 ± 15%     -73.9%       6815 ±  5%  netperf.ThroughputBoth_tps
  11703768 ± 15%     -73.9%    3053446 ±  5%  netperf.Throughput_total_tps
     26124 ± 15%     -73.9%       6815 ±  5%  netperf.Throughput_tps
 7.273e+08 ± 36%     -72.1%  2.032e+08 ± 10%  netperf.time.involuntary_context_switches
    207598            +1.6%     210869        netperf.time.minor_page_faults
      6280 ±  5%      -8.9%       5721        netperf.time.percent_of_cpu_this_job_got
    934.98 ± 11%     -76.3%     221.73 ±  9%  netperf.time.user_time
 2.796e+09 ± 10%     -74.5%  7.133e+08 ±  4%  netperf.time.voluntary_context_switches
 3.511e+09 ± 15%     -73.9%   9.16e+08 ±  5%  netperf.workload
      0.59 ± 14%      -0.4        0.23 ±  8%  mpstat.cpu.all.irq%
     36.63 ±  3%      +8.0       44.58        mpstat.cpu.all.soft%
     54.13 ±  4%      -3.6       50.54        mpstat.cpu.all.sys%
      3.07 ± 12%      -2.0        1.10 ±  8%  mpstat.cpu.all.usr%
   5888580 ± 57%     -53.7%    2727489 ± 12%  numa-meminfo.node1.Active
   5888580 ± 57%     -53.7%    2727489 ± 12%  numa-meminfo.node1.Active(anon)
   2004995 ± 41%     -62.5%     752662 ± 29%  numa-meminfo.node1.Mapped
   5285307 ± 60%     -55.9%    2332012 ± 12%  numa-meminfo.node1.Shmem
   1472770 ± 57%     -53.7%     682417 ± 12%  numa-vmstat.node1.nr_active_anon
    501469 ± 41%     -62.3%     188812 ± 30%  numa-vmstat.node1.nr_mapped
   1321957 ± 60%     -55.9%     583477 ± 12%  numa-vmstat.node1.nr_shmem
   1472769 ± 57%     -53.7%     682412 ± 12%  numa-vmstat.node1.nr_zone_active_anon
    240.00 ± 35%     +78.0%     427.17 ± 34%  perf-c2c.DRAM.local
      4842 ± 10%     -42.7%       2775 ± 20%  perf-c2c.DRAM.remote
     64063 ±106%     -86.2%       8844 ± 21%  perf-c2c.HITM.local
     65966 ±103%     -84.2%      10453 ± 21%  perf-c2c.HITM.total
   9255251 ± 34%     -32.3%    6262559 ±  4%  vmstat.memory.cache
    713.40 ±  3%      -8.1%     655.30        vmstat.procs.r
  24064688 ±  9%     -75.0%    6005256 ±  5%  vmstat.system.cs
    502095 ± 32%     -43.2%     285043 ±  5%  vmstat.system.in
   6319307 ± 50%     -48.3%    3267417 ±  8%  meminfo.Active
   6319307 ± 50%     -48.3%    3267417 ±  8%  meminfo.Active(anon)
    985505            -7.9%     907934        meminfo.AnonPages
   9084833 ± 34%     -32.7%    6110641 ±  4%  meminfo.Cached
   6756481 ± 46%     -45.2%    3701600 ±  7%  meminfo.Committed_AS
   2048504 ± 40%     -61.6%     786887 ± 23%  meminfo.Mapped
  12889379 ± 24%     -23.4%    9870167 ±  2%  meminfo.Memused
   5337612 ± 59%     -55.7%    2363424 ± 12%  meminfo.Shmem
  13126065 ± 24%     -23.3%   10070961 ±  2%  meminfo.max_used_kB
      2635 ±  2%      +2.5%       2700        turbostat.Bzy_MHz
      1.58 ± 86%      -1.6        0.01 ±159%  turbostat.C1%
      2.32            +0.6        2.89 ± 17%  turbostat.C6%
      0.71 ± 13%     +33.5%       0.94 ± 17%  turbostat.CPU%c1
      1.03 ±  8%     -75.1%       0.26 ±  5%  turbostat.IPC
 1.551e+08 ± 32%     -43.1%   88184621 ±  4%  turbostat.IRQ
  10482265 ±  2%     -22.9%    8081533 ± 17%  turbostat.NMI
    137.78 ± 12%    -137.4        0.39 ±143%  turbostat.PKG_%
    689.55           -13.2%     598.45        turbostat.PkgWatt
   1580810 ± 50%     -48.3%     817106 ±  8%  proc-vmstat.nr_active_anon
    246413            -7.9%     227050        proc-vmstat.nr_anon_pages
   2272155 ± 34%     -32.8%    1527847 ±  4%  proc-vmstat.nr_file_pages
    512918 ± 40%     -61.6%     197122 ± 24%  proc-vmstat.nr_mapped
     16475 ±  3%      -4.6%      15717        proc-vmstat.nr_page_table_pages
   1335349 ± 59%     -55.7%     591042 ± 11%  proc-vmstat.nr_shmem
     38411 ±  4%      -5.6%      36244        proc-vmstat.nr_slab_reclaimable
   1580810 ± 50%     -48.3%     817106 ±  8%  proc-vmstat.nr_zone_active_anon
   3560906 ± 29%     -32.6%    2398691 ±  3%  proc-vmstat.numa_hit
   3328182 ± 31%     -34.9%    2165871 ±  3%  proc-vmstat.numa_local
   3774711 ± 28%     -30.7%    2616266 ±  3%  proc-vmstat.pgalloc_normal
      1137 ±  9%     +25.6%       1428 ±  8%  proc-vmstat.unevictable_pgs_culled
      0.08 ± 21%     +91.2%       0.16 ± 13%  perf-stat.i.MPKI
 1.101e+11 ± 13%     -73.2%  2.951e+10 ±  4%  perf-stat.i.branch-instructions
 5.152e+08 ±  3%     -73.4%  1.373e+08 ±  4%  perf-stat.i.branch-misses
      7.79 ± 57%      +8.0       15.78 ±  7%  perf-stat.i.cache-miss-rate%
  40404057 ± 14%     -49.4%   20427349 ±  9%  perf-stat.i.cache-misses
 1.333e+09 ± 63%     -88.3%  1.555e+08 ± 23%  perf-stat.i.cache-references
  24074992 ±  9%     -74.9%    6042582 ±  5%  perf-stat.i.context-switches
      0.97 ±  8%    +297.8%       3.87 ±  5%  perf-stat.i.cpi
 5.567e+11 ±  5%      +5.7%  5.884e+11        perf-stat.i.cpu-cycles
     14286 ± 18%    +124.2%      32027 ±  9%  perf-stat.i.cycles-between-cache-misses
 5.812e+11 ± 13%     -73.4%  1.545e+11 ±  4%  perf-stat.i.instructions
      1.04 ±  7%     -73.5%       0.28 ±  5%  perf-stat.i.ipc
    113.97 ±  4%     -76.3%      26.96 ±  5%  perf-stat.i.metric.K/sec
      0.07 ± 25%     +83.8%       0.13 ±  7%  perf-stat.overall.MPKI
      5.74 ± 80%      +8.1       13.85 ± 14%  perf-stat.overall.cache-miss-rate%
      0.97 ±  8%    +298.7%       3.85 ±  4%  perf-stat.overall.cpi
     14137 ± 19%    +108.1%      29419 ±  8%  perf-stat.overall.cycles-between-cache-misses
      1.04 ±  8%     -75.0%       0.26 ±  4%  perf-stat.overall.ipc
 1.106e+11 ± 13%     -73.8%  2.897e+10 ±  4%  perf-stat.ps.branch-instructions
 5.149e+08 ±  3%     -73.9%  1.343e+08 ±  4%  perf-stat.ps.branch-misses
  40529012 ± 14%     -50.7%   19979807 ±  8%  perf-stat.ps.cache-misses
 1.291e+09 ± 65%     -88.5%  1.483e+08 ± 21%  perf-stat.ps.cache-references
  24179326 ±  9%     -75.3%    5978529 ±  5%  perf-stat.ps.context-switches
 5.837e+11 ± 13%     -74.0%  1.519e+11 ±  4%  perf-stat.ps.instructions
      4822 ± 14%     -15.5%       4073 ±  3%  perf-stat.ps.minor-faults
      4822 ± 14%     -15.5%       4073 ±  3%  perf-stat.ps.page-faults
 1.797e+14 ± 13%     -73.6%  4.737e+13 ±  4%  perf-stat.total.instructions
  20537761 ±  3%     -13.4%   17788695 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.avg
      2.79 ±  3%     -19.1%       2.26 ±  7%  sched_debug.cfs_rq:/.h_nr_queued.avg
      5.53 ±  3%     -12.8%       4.82 ±  7%  sched_debug.cfs_rq:/.h_nr_queued.max
      1.97 ±  2%     -12.7%       1.72 ±  7%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      4.14 ±  8%     -20.1%       3.31 ±  5%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.85 ± 22%     -29.1%       0.61 ±  6%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      1952 ±  5%     -13.3%       1691 ±  7%  sched_debug.cfs_rq:/.runnable_avg.avg
      3369 ±  2%     -12.7%       2941 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    740.41 ± 30%     -34.9%     481.70 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
  20537760 ±  3%     -13.4%   17788693 ±  8%  sched_debug.cfs_rq:/.zero_vruntime.avg
    171016 ±  6%     +55.6%     266184 ± 22%  sched_debug.cpu.avg_idle.avg
    759641 ± 33%    +124.8%    1707426 ± 29%  sched_debug.cpu.avg_idle.max
      3361 ±  6%    +685.4%      26403 ±143%  sched_debug.cpu.avg_idle.min
     63.83 ± 38%    +614.0%     455.76 ± 67%  sched_debug.cpu.clock.stddev
    142179           -10.1%     127827 ±  5%  sched_debug.cpu.clock_task.avg
    161238 ±  5%      -8.2%     148085 ±  5%  sched_debug.cpu.clock_task.max
    129160            -8.0%     118888 ±  6%  sched_debug.cpu.clock_task.min
    500065            +7.1%     535544 ±  3%  sched_debug.cpu.max_idle_balance_cost.avg
    505564 ±  2%    +221.9%    1627313 ± 32%  sched_debug.cpu.max_idle_balance_cost.max
    575.95 ±211%  +24724.5%     142975 ± 51%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 31%    +567.1%       0.00 ± 66%  sched_debug.cpu.next_balance.stddev
      2.80 ±  3%     -19.6%       2.25 ±  7%  sched_debug.cpu.nr_running.avg
      5.56 ±  3%     -13.8%       4.79 ±  7%  sched_debug.cpu.nr_running.max
      1.29 ± 23%     -32.5%       0.87 ±  6%  sched_debug.cpu.nr_running.stddev
  16175043 ±  9%     -76.0%    3889691 ± 11%  sched_debug.cpu.nr_switches.avg
  18893932 ±  3%     -72.4%    5210419 ± 18%  sched_debug.cpu.nr_switches.max
  10110072 ± 32%     -81.6%    1857421 ± 39%  sched_debug.cpu.nr_switches.min
     30.15 ±  7%     -19.7       10.40 ± 11%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
     28.40 ±  8%     -18.7        9.67 ±  9%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg
     69.42 ±  5%     -15.0       54.40 ±  8%  perf-profile.calltrace.cycles-pp.main
     65.93 ±  3%     -10.1       55.84        perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     34.79 ±  4%      -9.5       25.28 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.process_requests.spawn_child.accept_connection.accept_connections
     64.04 ±  3%      -8.9       55.19        perf-profile.calltrace.cycles-pp.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
     62.90 ±  3%      -8.1       54.80        perf-profile.calltrace.cycles-pp.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     34.74 ±  4%      -7.6       27.09 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_requests.spawn_child.accept_connection
     10.76 ±  6%      -7.3        3.42 ±  5%  perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
      8.82 ± 24%      -7.2        1.60 ± 20%  perf-profile.calltrace.cycles-pp.__sctp_write_space.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put
      8.58 ± 24%      -7.0        1.57 ± 20%  perf-profile.calltrace.cycles-pp.__wake_up.__sctp_write_space.sctp_wfree.skb_release_head_state.consume_skb
     33.68 ±  3%      -6.9       26.75 ± 12%  perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_requests.spawn_child
      8.34 ± 25%      -6.8        1.50 ± 21%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up.__sctp_write_space.sctp_wfree.skb_release_head_state
      8.17 ± 24%      -6.7        1.49 ± 21%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up.__sctp_write_space.sctp_wfree
      8.06 ± 24%      -6.6        1.46 ± 21%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up.__sctp_write_space
     34.79 ±  4%      -6.3       28.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.main
     34.73 ±  4%      -6.3       28.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.main
      9.28 ±  5%      -6.2        3.06 ±  5%  perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.sock_recvmsg.____sys_recvmsg
      9.13 ±  4%      -6.1        3.01 ±  5%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.sock_recvmsg
      8.99 ±  4%      -6.0        2.98 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg
      7.74 ±  2%      -5.8        1.91 ± 11%  perf-profile.calltrace.cycles-pp.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
     33.68 ±  3%      -5.6       28.10        perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.main
     33.41 ±  3%      -5.4       28.03        perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.main
     33.47 ±  3%      -5.4       28.10        perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_requests
     56.98 ±  2%      -4.7       52.26        perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg
     55.73 ±  2%      -4.1       51.67        perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
      4.85 ±  7%      -3.8        1.02 ± 27%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      4.78 ±  7%      -3.8        1.01 ± 27%  perf-profile.calltrace.cycles-pp.sctp_packet_append_chunk.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter
      4.05 ±  7%      -3.1        0.97 ± 27%  perf-profile.calltrace.cycles-pp.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg
      4.18 ± 10%      -3.0        1.18 ± 28%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      4.75 ± 16%      -2.7        2.02 ±  8%  perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      2.97            -2.2        0.74 ±  6%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
      3.41 ± 23%      -2.2        1.20 ±  6%  perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
      3.95 ± 22%      -2.1        1.82 ±  8%  perf-profile.calltrace.cycles-pp.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      2.80 ±  5%      -2.1        0.72 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.schedule_timeout
      2.87 ± 27%      -2.0        0.90 ±  5%  perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.sock_recvmsg.____sys_recvmsg
      2.31 ± 32%      -1.9        0.46 ± 45%  perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.sock_recvmsg
      1.81 ±  7%      -1.2        0.60 ± 10%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
      2.05 ± 23%      -1.2        0.84 ±  4%  perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
      1.59 ±  9%      -1.2        0.38 ± 71%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.sock_recvmsg.____sys_recvmsg
      1.92 ± 25%      -1.1        0.80 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_timeout
      1.84 ± 25%      -1.1        0.76 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      0.00            +0.9        0.91 ± 27%  perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter
      0.00            +0.9        0.92 ± 27%  perf-profile.calltrace.cycles-pp.__sk_mem_schedule.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
     47.94 ±  3%      +1.7       49.65        perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      0.00            +2.4        2.36 ± 23%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.release_sock.sctp_recvmsg.sock_recvmsg.____sys_recvmsg
      0.00            +2.4        2.38 ± 23%  perf-profile.calltrace.cycles-pp.release_sock.sctp_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
     42.56            +5.7       48.25        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
     41.94            +6.0       47.98        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
     41.66            +6.1       47.80        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
     41.20            +6.3       47.49        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.sctp_packet_transmit
     39.28            +7.4       46.67        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_output
     39.22            +7.4       46.66        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
     39.14            +7.5       46.61        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     38.20            +7.8       45.99        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     37.03            +8.4       45.48        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     36.96            +8.5       45.44        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     36.44            +8.7       45.17        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     34.61           +10.0       44.61        perf-profile.calltrace.cycles-pp.ip_local_deliver.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     34.55           +10.0       44.57        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core.process_backlog.__napi_poll
     34.48           +10.0       44.51        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core.process_backlog
     34.12           +10.3       44.38        perf-profile.calltrace.cycles-pp.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core
     30.23           +13.0       43.19        perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
     24.36 ±  3%     +16.7       41.04 ±  2%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
     24.18 ±  5%     +16.9       41.09        perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     23.35           +17.5       40.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.26           +17.6       40.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.36           +18.9       40.24        perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.96           +19.1       40.10 ±  2%  perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.96           +19.8       39.74 ±  2%  perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.33           +20.3       39.60 ±  2%  perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
     19.06           +20.4       39.50 ±  2%  perf-profile.calltrace.cycles-pp.sctp_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
     15.95 ± 12%     +21.5       37.40 ±  2%  perf-profile.calltrace.cycles-pp.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
     11.71 ± 16%     +24.3       35.99 ±  3%  perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
     11.16 ± 17%     +24.7       35.84 ±  3%  perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm
     10.58 ± 18%     +25.1       35.67 ±  3%  perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
     10.04 ± 21%     +25.4       35.48 ±  3%  perf-profile.calltrace.cycles-pp.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_outq_sack
      1.08 ± 21%     +29.6       30.72 ±  3%  perf-profile.calltrace.cycles-pp.skb_release_head_state.sk_skb_reason_drop.sctp_recvmsg.sock_recvmsg.____sys_recvmsg
      1.39 ± 20%     +29.8       31.22 ±  3%  perf-profile.calltrace.cycles-pp.sk_skb_reason_drop.sctp_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
      0.00           +30.4       30.38 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__sk_mem_reduce_allocated.skb_release_head_state.sk_skb_reason_drop.sctp_recvmsg
      0.00           +30.6       30.56 ±  3%  perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.skb_release_head_state.sk_skb_reason_drop.sctp_recvmsg.sock_recvmsg
      0.00           +30.8       30.84 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__sk_mem_reduce_allocated.sctp_wfree.skb_release_head_state.consume_skb
      0.00           +31.1       31.08 ±  3%  perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put
     69.66 ±  5%     -15.0       54.70 ±  8%  perf-profile.children.cycles-pp.main
     67.43 ±  3%     -11.1       56.32        perf-profile.children.cycles-pp.__sys_sendmsg
     66.96 ±  3%     -10.8       56.18        perf-profile.children.cycles-pp.___sys_sendmsg
     66.04 ±  3%     -10.1       55.90        perf-profile.children.cycles-pp.____sys_sendmsg
     35.53 ±  4%     -10.0       25.50 ± 18%  perf-profile.children.cycles-pp.accept_connections
     64.38 ±  3%      -9.0       55.34        perf-profile.children.cycles-pp.sctp_sendmsg
     35.53 ±  4%      -8.2       27.35 ± 12%  perf-profile.children.cycles-pp.accept_connection
     35.53 ±  4%      -8.2       27.35 ± 12%  perf-profile.children.cycles-pp.spawn_child
     63.02 ±  3%      -8.1       54.88        perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
     11.31 ±  3%      -7.7        3.61 ±  6%  perf-profile.children.cycles-pp.__schedule
     10.81 ±  6%      -7.4        3.44 ±  5%  perf-profile.children.cycles-pp.sctp_skb_recv_datagram
     10.97            -7.3        3.64 ±  6%  perf-profile.children.cycles-pp.schedule
      8.86 ± 24%      -7.0        1.82 ±  5%  perf-profile.children.cycles-pp.__sctp_write_space
      8.62 ± 24%      -6.8        1.78 ±  5%  perf-profile.children.cycles-pp.__wake_up
     35.53 ±  4%      -6.7       28.80        perf-profile.children.cycles-pp.process_requests
      8.36 ± 24%      -6.7        1.70 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      8.18 ± 24%      -6.5        1.68 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      8.12 ± 24%      -6.5        1.67 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      9.29 ±  5%      -6.2        3.06 ±  5%  perf-profile.children.cycles-pp.schedule_timeout
      7.92            -5.8        2.12 ±  7%  perf-profile.children.cycles-pp.sctp_outq_flush_data
     57.04 ±  2%      -4.7       52.31        perf-profile.children.cycles-pp.sctp_primitive_SEND
     56.93 ±  2%      -4.7       52.28        perf-profile.children.cycles-pp.sctp_do_sm
     56.72 ±  2%      -4.6       52.16        perf-profile.children.cycles-pp.sctp_cmd_interpreter
     56.06 ±  2%      -4.2       51.85        perf-profile.children.cycles-pp.sctp_outq_flush
      4.87 ±  7%      -3.6        1.24 ±  6%  perf-profile.children.cycles-pp.sctp_packet_transmit_chunk
      4.82 ±  7%      -3.6        1.22 ±  6%  perf-profile.children.cycles-pp.sctp_packet_append_chunk
      4.45 ± 14%      -3.2        1.23 ±  6%  perf-profile.children.cycles-pp.__alloc_skb
      4.08 ±  7%      -2.9        1.17 ±  6%  perf-profile.children.cycles-pp.sctp_datamsg_from_user
      3.84            -2.9        0.96 ±  7%  perf-profile.children.cycles-pp.__pick_next_task
      3.95 ±  9%      -2.9        1.10 ±  5%  perf-profile.children.cycles-pp._sctp_make_chunk
      3.68 ±  4%      -2.7        0.95 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.78 ± 16%      -2.6        2.16 ±  3%  perf-profile.children.cycles-pp.sctp_ulpq_tail_data
      3.68 ± 23%      -2.4        1.29 ±  6%  perf-profile.children.cycles-pp.sctp_ulpevent_free
      3.01 ±  9%      -2.2        0.76 ±  7%  perf-profile.children.cycles-pp.sctp_make_sack
      3.01 ±  3%      -2.1        0.86 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      4.02 ± 22%      -2.1        1.95 ±  3%  perf-profile.children.cycles-pp.sctp_ulpevent_make_rcvmsg
      2.68 ± 11%      -2.1        0.63 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.68 ± 10%      -1.9        0.76 ± 10%  perf-profile.children.cycles-pp.enqueue_task
      2.34 ± 34%      -1.9        0.42 ±  7%  perf-profile.children.cycles-pp.dst_release
      2.77 ± 13%      -1.9        0.88 ±  3%  perf-profile.children.cycles-pp.dequeue_entities
      2.36 ± 29%      -1.8        0.53 ±  5%  perf-profile.children.cycles-pp.skb_clone
      1.87 ± 89%      -1.8        0.09 ±  7%  perf-profile.children.cycles-pp.select_task_rq
      2.26 ±  5%      -1.7        0.60 ±  8%  perf-profile.children.cycles-pp.__sctp_rcv_lookup
      2.46            -1.6        0.82 ±  8%  perf-profile.children.cycles-pp.sctp_check_transmitted
      2.20 ±  5%      -1.6        0.58 ±  8%  perf-profile.children.cycles-pp.sctp_addrs_lookup_transport
      2.14 ± 12%      -1.6        0.55 ±  6%  perf-profile.children.cycles-pp.sctp_make_control
      2.26 ±  8%      -1.6        0.69 ±  6%  perf-profile.children.cycles-pp.sctp_make_datafrag_empty
      2.20 ±  5%      -1.6        0.64 ±  6%  perf-profile.children.cycles-pp.sctp_ulpq_tail_event
      1.96 ± 10%      -1.5        0.43 ±  6%  perf-profile.children.cycles-pp.lock_timer_base
      1.85 ± 32%      -1.5        0.34 ±  8%  perf-profile.children.cycles-pp.__copy_skb_header
      2.15 ±  9%      -1.5        0.65 ± 11%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.14 ± 13%      -1.5        0.67 ±  7%  perf-profile.children.cycles-pp.sctp_packet_pack
      2.04 ± 16%      -1.4        0.65 ± 10%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      1.91 ± 17%      -1.4        0.55 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
      1.70 ±  7%      -1.4        0.35 ±  3%  perf-profile.children.cycles-pp.wakeup_preempt
      1.89 ±  2%      -1.3        0.54 ±  4%  perf-profile.children.cycles-pp.update_curr
      1.83 ± 13%      -1.3        0.56 ±  6%  perf-profile.children.cycles-pp.do_ulpq_tail_event
      1.88 ± 13%      -1.2        0.63 ±  8%  perf-profile.children.cycles-pp.sctp_ulpevent_make_sender_dry_event
      2.00 ± 13%      -1.2        0.75 ±  7%  perf-profile.children.cycles-pp.sctp_sf_do_no_pending_tsn
      1.55 ±  9%      -1.2        0.30 ±  2%  perf-profile.children.cycles-pp.wakeup_preempt_fair
      1.82 ±  7%      -1.2        0.61 ±  9%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      1.67 ± 14%      -1.2        0.45 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      2.06 ± 23%      -1.2        0.85 ±  4%  perf-profile.children.cycles-pp.try_to_block_task
      1.60 ±  5%      -1.2        0.40 ±  6%  perf-profile.children.cycles-pp.timer_delete
      1.66 ± 13%      -1.2        0.50 ±  6%  perf-profile.children.cycles-pp.sctp_queue_purge_ulpevents
      1.36 ± 32%      -1.1        0.22 ± 10%  perf-profile.children.cycles-pp.sctp_v4_xmit
      1.40 ± 27%      -1.1        0.26 ±  9%  perf-profile.children.cycles-pp.ip_rcv
      1.66 ± 11%      -1.1        0.53 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.94 ± 25%      -1.1        0.81 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.00 ± 13%      -1.1        0.90 ±  9%  perf-profile.children.cycles-pp.kmem_cache_free
      1.41 ±  6%      -1.1        0.31 ±  7%  perf-profile.children.cycles-pp.pick_task_fair
      1.62 ± 12%      -1.1        0.54 ±  7%  perf-profile.children.cycles-pp.copy_msghdr_from_user
      1.60 ±  9%      -1.1        0.54 ± 10%  perf-profile.children.cycles-pp.__skb_datagram_iter
      1.53 ± 21%      -1.0        0.48 ±  8%  perf-profile.children.cycles-pp.__mod_timer
      1.54 ± 14%      -1.0        0.54 ±  9%  perf-profile.children.cycles-pp.__check_object_size
      1.38            -1.0        0.40 ±  5%  perf-profile.children.cycles-pp.sctp_chunkify
      1.32 ±  3%      -1.0        0.36 ±  7%  perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      1.80 ± 15%      -0.9        0.86 ±  6%  perf-profile.children.cycles-pp.kfree
      1.05 ± 32%      -0.9        0.13 ± 10%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      1.30 ± 14%      -0.9        0.39 ± 17%  perf-profile.children.cycles-pp.enqueue_entity
      1.22 ±  4%      -0.9        0.32 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      1.23 ± 12%      -0.9        0.33 ±  6%  perf-profile.children.cycles-pp.kmalloc_reserve
      1.24 ± 23%      -0.9        0.36 ±  9%  perf-profile.children.cycles-pp.sctp_outq_select_transport
      1.21 ±  5%      -0.9        0.35 ±  4%  perf-profile.children.cycles-pp.update_se
      1.08 ± 20%      -0.8        0.24 ± 10%  perf-profile.children.cycles-pp.sctp_transport_reset_t3_rtx
      1.03 ± 33%      -0.8        0.22 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.96 ± 37%      -0.8        0.19 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      0.98 ±  4%      -0.8        0.23 ±  7%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.03 ± 15%      -0.8        0.28 ±  6%  perf-profile.children.cycles-pp.sctp_user_addto_chunk
      1.63 ± 14%      -0.7        0.88 ±  8%  perf-profile.children.cycles-pp.skb_release_data
      1.07 ± 12%      -0.7        0.36 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.18 ± 11%      -0.7        0.48 ± 10%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.90 ± 17%      -0.7        0.22 ±  8%  perf-profile.children.cycles-pp.ktime_get
      0.96 ±  2%      -0.7        0.28 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      0.91 ±  8%      -0.7        0.25 ±  4%  perf-profile.children.cycles-pp.pick_eevdf
      0.82 ±  8%      -0.6        0.18 ±  7%  perf-profile.children.cycles-pp.put_prev_entity
      1.10 ± 10%      -0.6        0.46 ± 10%  perf-profile.children.cycles-pp.xmit_one
      0.96 ±  3%      -0.6        0.32 ±  7%  perf-profile.children.cycles-pp.set_next_entity
      0.87 ± 12%      -0.6        0.24 ±  6%  perf-profile.children.cycles-pp._copy_from_user
      0.74 ± 19%      -0.6        0.15 ±  7%  perf-profile.children.cycles-pp.update_cfs_rq_load_avg
      0.99 ± 10%      -0.6        0.40 ±  9%  perf-profile.children.cycles-pp.loopback_xmit
      0.88 ±  9%      -0.6        0.31 ±  9%  perf-profile.children.cycles-pp.sctp_packet_config
      0.70 ± 20%      -0.6        0.14 ±  7%  perf-profile.children.cycles-pp._copy_to_iter
      0.79 ± 12%      -0.6        0.24 ±  7%  perf-profile.children.cycles-pp.import_iovec
      0.87 ± 13%      -0.6        0.32 ±  9%  perf-profile.children.cycles-pp.skb_defer_free_flush
      0.83 ± 15%      -0.5        0.29 ±  8%  perf-profile.children.cycles-pp.check_heap_object
      0.76 ± 12%      -0.5        0.23 ±  6%  perf-profile.children.cycles-pp.__import_iovec
      0.70 ± 16%      -0.5        0.16 ±  7%  perf-profile.children.cycles-pp._find_next_bit
      0.69 ± 13%      -0.5        0.16 ±  8%  perf-profile.children.cycles-pp.skb_put
      0.72            -0.5        0.21 ±  6%  perf-profile.children.cycles-pp.fdget
      0.79 ±  9%      -0.5        0.29 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.72 ±  7%      -0.5        0.23 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.77 ± 18%      -0.5        0.29 ± 15%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.72 ±  3%      -0.5        0.24 ±  4%  perf-profile.children.cycles-pp.sctp_association_put
      0.55 ±  5%      -0.4        0.10 ± 11%  perf-profile.children.cycles-pp.sctp_cmp_addr_exact
      0.60 ± 14%      -0.4        0.17 ±  6%  perf-profile.children.cycles-pp.sctp_addto_chunk
      0.55 ± 31%      -0.4        0.12 ±  8%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.69 ± 18%      -0.4        0.27 ±  4%  perf-profile.children.cycles-pp.sctp_chunk_free
      0.62 ± 22%      -0.4        0.20 ±  8%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.49 ± 34%      -0.4        0.08 ± 10%  perf-profile.children.cycles-pp.sctp_inet_skb_msgname
      0.55 ± 12%      -0.4        0.14 ±  7%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.55 ±  2%      -0.4        0.14 ±  4%  perf-profile.children.cycles-pp.__enqueue_entity
      0.55 ± 12%      -0.4        0.14 ±  6%  perf-profile.children.cycles-pp.os_xsave
      0.70 ± 14%      -0.4        0.30 ± 10%  perf-profile.children.cycles-pp.sctp_inq_pop
      0.53 ± 12%      -0.4        0.13 ±  5%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      0.55 ±  6%      -0.4        0.17 ±  8%  perf-profile.children.cycles-pp.__dequeue_entity
      0.54 ±  8%      -0.4        0.16 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.53 ± 12%      -0.4        0.15 ±  7%  perf-profile.children.cycles-pp.copy_iovec_from_user
      0.50 ±  6%      -0.4        0.13 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.54 ±  7%      -0.4        0.17 ± 10%  perf-profile.children.cycles-pp.__sctp_packet_append_chunk
      0.51 ± 15%      -0.4        0.14 ±  8%  perf-profile.children.cycles-pp.sctp_transport_hold
      0.67 ± 13%      -0.4        0.31 ± 12%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.66 ±  6%      -0.4        0.30 ±  9%  perf-profile.children.cycles-pp.sched_clock
      0.76 ±  6%      -0.4        0.41 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.50 ± 12%      -0.4        0.14 ±  6%  perf-profile.children.cycles-pp.skb_dequeue
      0.53 ±  9%      -0.4        0.18 ±  7%  perf-profile.children.cycles-pp.sctp_association_hold
      0.51 ± 12%      -0.3        0.16 ± 20%  perf-profile.children.cycles-pp.__pi_memset
      0.48 ± 10%      -0.3        0.13 ±  7%  perf-profile.children.cycles-pp.sctp_datamsg_put
      0.46 ± 12%      -0.3        0.12 ±  6%  perf-profile.children.cycles-pp.sctp_ulpevent_receive_data
      0.47 ± 12%      -0.3        0.13 ±  7%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.43 ± 22%      -0.3        0.10 ±  5%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.40 ±  8%      -0.3        0.08 ±  8%  perf-profile.children.cycles-pp.requeue_delayed_entity
      0.43 ± 10%      -0.3        0.11 ±  5%  perf-profile.children.cycles-pp.vruntime_eligible
      0.40 ±  3%      -0.3        0.09 ±  5%  perf-profile.children.cycles-pp.avg_vruntime
      0.43 ±  2%      -0.3        0.12 ±  3%  perf-profile.children.cycles-pp.sctp_transport_put
      0.44 ± 13%      -0.3        0.13 ±  8%  perf-profile.children.cycles-pp.sock_kfree_s
      0.52 ± 10%      -0.3        0.21 ±  9%  perf-profile.children.cycles-pp.__netif_rx
      0.55 ±  4%      -0.3        0.24 ± 12%  perf-profile.children.cycles-pp.native_sched_clock
      0.49 ±  9%      -0.3        0.19 ±  9%  perf-profile.children.cycles-pp.netif_rx_internal
      0.56 ± 23%      -0.3        0.26 ±  8%  perf-profile.children.cycles-pp.lock_sock_nested
      0.48 ± 15%      -0.3        0.19 ±  6%  perf-profile.children.cycles-pp.reweight_entity
      0.44 ± 16%      -0.3        0.14 ±  7%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.41 ± 13%      -0.3        0.11 ±  6%  perf-profile.children.cycles-pp._copy_from_iter
      0.44 ± 14%      -0.3        0.15 ±  3%  perf-profile.children.cycles-pp.sock_wfree
      0.38 ±  3%      -0.3        0.09 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.39 ±  6%      -0.3        0.10 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.43 ± 21%      -0.3        0.15 ±  8%  perf-profile.children.cycles-pp.sctp_sf_eat_sack_6_2
      0.54 ±  5%      -0.3        0.26 ±  7%  perf-profile.children.cycles-pp.prepare_task_switch
      0.44 ±  9%      -0.3        0.17 ±  8%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.35 ± 23%      -0.3        0.08 ± 17%  perf-profile.children.cycles-pp.sctp_chunk_abandoned
      0.36 ± 10%      -0.3        0.10 ±  7%  perf-profile.children.cycles-pp.sctp_sendmsg_parse
      0.32 ± 26%      -0.3        0.06 ±  6%  perf-profile.children.cycles-pp.send_sctp_rr
      0.38 ± 13%      -0.3        0.13 ± 14%  perf-profile.children.cycles-pp.sctp_outq_tail
      0.35 ± 15%      -0.3        0.10 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.52 ± 13%      -0.3        0.26 ± 16%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.30 ± 20%      -0.2        0.06        perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.30 ± 36%      -0.2        0.06 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.34 ± 10%      -0.2        0.10 ±  7%  perf-profile.children.cycles-pp.__pi_memcpy
      0.32 ± 16%      -0.2        0.09 ±  6%  perf-profile.children.cycles-pp.do_perf_trace_sched_stat_runtime
      0.35 ±  6%      -0.2        0.12 ±  8%  perf-profile.children.cycles-pp.sctp_sock_rfree
      0.43 ± 18%      -0.2        0.20 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_sk_uncharge
      0.28 ± 28%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.perf_tp_event
      0.34 ± 10%      -0.2        0.12 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.34 ± 14%      -0.2        0.12 ± 10%  perf-profile.children.cycles-pp.__check_heap_object
      0.31            -0.2        0.09 ±  6%  perf-profile.children.cycles-pp.sctp_chunk_hold
      0.32 ± 15%      -0.2        0.10 ±  6%  perf-profile.children.cycles-pp.sctp_ulpevent_init
      0.32 ± 17%      -0.2        0.10 ±  9%  perf-profile.children.cycles-pp.recv_sctp_rr
      0.46 ± 11%      -0.2        0.25 ±  8%  perf-profile.children.cycles-pp.sock_kmalloc
      0.32 ± 15%      -0.2        0.12 ±  8%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.24 ± 49%      -0.2        0.04 ± 44%  perf-profile.children.cycles-pp.sctp_data_ready
      0.61 ±  8%      -0.2        0.42 ±  9%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.26 ±  6%      -0.2        0.07 ± 10%  perf-profile.children.cycles-pp.__set_next_task_fair
      0.33 ±  6%      -0.2        0.14 ±  4%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.28 ± 13%      -0.2        0.09 ±  6%  perf-profile.children.cycles-pp.__kmalloc_noprof
      0.27 ± 13%      -0.2        0.08 ±  8%  perf-profile.children.cycles-pp.__genradix_ptr
      0.26 ± 22%      -0.2        0.07 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.34 ± 10%      -0.2        0.16 ±  4%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.30 ± 11%      -0.2        0.12 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.26 ± 13%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.ip_rcv_core
      0.23 ±  5%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.23 ± 18%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.mm_cid_switch_to
      0.24            -0.2        0.08 ± 12%  perf-profile.children.cycles-pp.sctp_ulpq_order
      0.21 ± 15%      -0.2        0.05 ±  7%  perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.28 ± 13%      -0.1        0.13 ± 13%  perf-profile.children.cycles-pp.ip_local_out
      0.18 ±  7%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__put_user_nocheck_8
      0.18 ± 22%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.sctp_validate_data
      0.39 ± 16%      -0.1        0.25 ± 17%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.20 ± 17%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.skb_pull
      0.19 ± 11%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.sctp_datamsg_destroy
      0.20 ±  8%      -0.1        0.08 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.24 ± 14%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.__ip_local_out
      0.19 ± 15%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.__css_rstat_updated
      0.18 ±  9%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.detach_if_pending
      0.20 ±  2%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.enqueue_timer
      0.17 ± 15%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.netif_skb_features
      0.16 ±  4%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.entity_lag
      0.14 ± 12%      -0.1        0.05        perf-profile.children.cycles-pp.prandom_u32_state
      0.16 ± 15%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.sctp_transport_update_rto
      0.17 ± 12%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.sctp_sched_fcfs_dequeue
      0.17 ± 16%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__ip_finish_output
      0.13 ± 20%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.sctp_transport_raise_cwnd
      0.13 ± 12%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.check_stack_object
      0.12 ± 14%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.sctp_control_release_owner
      0.12 ± 14%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.kfree_skbmem
      0.14 ± 13%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.ip_send_check
      0.12 ± 13%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.choose_new_asid
      0.10 ± 13%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.skb_free_head
      0.10 ± 13%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.sctp_v4_addr_valid
      0.09 ± 14%      -0.0        0.05        perf-profile.children.cycles-pp.sctp_generate_fwdtsn
      0.03 ± 70%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.04 ± 71%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.sctp_assoc_rwnd_increase
      0.00            +0.1        0.12 ± 37%  perf-profile.children.cycles-pp.shmem_write_end
      0.00            +0.1        0.13 ± 61%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.02 ±223%      +0.2        0.17 ± 68%  perf-profile.children.cycles-pp.ordered_events__queue
      0.02 ±223%      +0.2        0.17 ± 68%  perf-profile.children.cycles-pp.process_simple
      0.02 ±223%      +0.2        0.17 ± 68%  perf-profile.children.cycles-pp.queue_event
      0.06 ± 73%      +0.2        0.28 ± 40%  perf-profile.children.cycles-pp.copy_folio_from_iter_atomic
      0.24 ± 42%      +0.2        0.47 ±  8%  perf-profile.children.cycles-pp.handle_internal_command
      0.24 ± 42%      +0.2        0.47 ±  8%  perf-profile.children.cycles-pp.run_builtin
      0.23 ± 49%      +0.2        0.47 ±  9%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.22 ± 48%      +0.2        0.47 ±  9%  perf-profile.children.cycles-pp.perf_mmap__push
      0.16 ± 46%      +0.3        0.46 ± 11%  perf-profile.children.cycles-pp.record__pushfn
      0.15 ± 45%      +0.3        0.46 ± 11%  perf-profile.children.cycles-pp.ksys_write
      0.12 ± 44%      +0.3        0.44 ± 15%  perf-profile.children.cycles-pp.generic_perform_write
      0.12 ± 45%      +0.3        0.44 ± 13%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.14 ± 45%      +0.3        0.46 ± 11%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.8        0.79 ±  5%  perf-profile.children.cycles-pp.page_counter_try_charge
      1.19 ± 15%      +0.9        2.10 ±  3%  perf-profile.children.cycles-pp.__sk_mem_schedule
      1.11 ± 15%      +1.0        2.08 ±  3%  perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      0.00            +1.0        1.00 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge_stock
      0.85 ± 15%      +1.1        1.98 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_sk_charge
      0.32 ± 13%      +1.5        1.84 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.56 ± 11%      +1.9        2.50 ± 22%  perf-profile.children.cycles-pp.release_sock
      0.46 ±  2%      +2.0        2.44 ± 22%  perf-profile.children.cycles-pp._raw_spin_lock_bh
     93.18 ±  3%      +5.3       98.45        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     92.97 ±  3%      +5.4       98.38        perf-profile.children.cycles-pp.do_syscall_64
     42.62 ±  2%      +5.7       48.30        perf-profile.children.cycles-pp.__ip_queue_xmit
     42.00            +6.0       48.02        perf-profile.children.cycles-pp.ip_output
     41.70            +6.1       47.85        perf-profile.children.cycles-pp.ip_finish_output2
     41.28            +6.3       47.54        perf-profile.children.cycles-pp.__dev_queue_xmit
     39.77            +7.1       46.84        perf-profile.children.cycles-pp.__local_bh_enable_ip
     39.33            +7.4       46.72        perf-profile.children.cycles-pp.do_softirq
     39.23            +7.4       46.66        perf-profile.children.cycles-pp.handle_softirqs
     38.29            +7.8       46.09        perf-profile.children.cycles-pp.net_rx_action
     37.08            +8.4       45.52        perf-profile.children.cycles-pp.__napi_poll
     37.03            +8.5       45.49        perf-profile.children.cycles-pp.process_backlog
     36.49            +8.7       45.22        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     34.65           +10.0       44.66        perf-profile.children.cycles-pp.ip_local_deliver
     34.60           +10.0       44.61        perf-profile.children.cycles-pp.ip_local_deliver_finish
     34.53           +10.0       44.56        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     34.27           +10.2       44.47        perf-profile.children.cycles-pp.sctp_rcv
     30.34           +12.9       43.28        perf-profile.children.cycles-pp.sctp_assoc_bh_rcv
     21.38           +18.9       40.25        perf-profile.children.cycles-pp.__sys_recvmsg
     20.98           +19.1       40.10 ±  2%  perf-profile.children.cycles-pp.___sys_recvmsg
     19.98           +19.8       39.75 ±  2%  perf-profile.children.cycles-pp.____sys_recvmsg
     19.48           +20.1       39.60 ±  2%  perf-profile.children.cycles-pp.sctp_recvmsg
     19.35           +20.3       39.60 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
     16.06 ±  5%     +21.4       37.44 ±  2%  perf-profile.children.cycles-pp.sctp_chunk_put
     16.01 ± 12%     +21.5       37.48 ±  2%  perf-profile.children.cycles-pp.sctp_outq_sack
     14.25 ±  8%     +22.4       36.69 ±  3%  perf-profile.children.cycles-pp.consume_skb
     10.08 ± 21%     +25.5       35.54 ±  3%  perf-profile.children.cycles-pp.sctp_wfree
      1.99 ± 18%     +29.4       31.41 ±  3%  perf-profile.children.cycles-pp.sk_skb_reason_drop
     14.26 ±  6%     +52.8       67.07 ±  3%  perf-profile.children.cycles-pp.skb_release_head_state
      0.80 ± 16%     +60.9       61.69 ±  3%  perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.00           +61.4       61.44 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      2.58 ± 11%      -2.0        0.61 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      2.31 ± 35%      -1.9        0.41 ±  8%  perf-profile.self.cycles-pp.dst_release
      2.18 ± 13%      -1.6        0.63 ±  6%  perf-profile.self.cycles-pp.__alloc_skb
      1.84 ± 32%      -1.5        0.34 ±  8%  perf-profile.self.cycles-pp.__copy_skb_header
      1.58 ± 14%      -1.2        0.42 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      1.34 ± 33%      -1.1        0.21 ± 11%  perf-profile.self.cycles-pp.sctp_v4_xmit
      1.53 ± 11%      -1.1        0.46 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.04 ± 32%      -0.9        0.12 ±  8%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      1.73 ± 15%      -0.9        0.84 ±  6%  perf-profile.self.cycles-pp.kfree
      1.45 ± 14%      -0.8        0.62 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.98 ±  4%      -0.8        0.22 ±  7%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.88 ± 17%      -0.7        0.21 ±  7%  perf-profile.self.cycles-pp.ktime_get
      0.80 ± 28%      -0.6        0.18 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.85 ± 12%      -0.6        0.24 ±  7%  perf-profile.self.cycles-pp._copy_from_user
      0.86 ±  3%      -0.6        0.25 ±  9%  perf-profile.self.cycles-pp.sctp_addrs_lookup_transport
      1.00 ±  3%      -0.6        0.39 ±  8%  perf-profile.self.cycles-pp.sctp_check_transmitted
      0.89 ± 18%      -0.6        0.29 ±  5%  perf-profile.self.cycles-pp.sctp_outq_sack
      0.91 ±  8%      -0.6        0.34 ±  5%  perf-profile.self.cycles-pp.sctp_chunk_put
      0.84 ± 20%      -0.6        0.28 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.69 ± 20%      -0.6        0.14 ±  4%  perf-profile.self.cycles-pp._copy_to_iter
      0.84 ± 27%      -0.5        0.30 ±  9%  perf-profile.self.cycles-pp.skb_release_head_state
      0.77 ± 31%      -0.5        0.24 ± 10%  perf-profile.self.cycles-pp.sctp_recvmsg
      0.93            -0.5        0.42 ± 10%  perf-profile.self.cycles-pp.sctp_cmd_interpreter
      0.66 ± 16%      -0.5        0.16 ±  5%  perf-profile.self.cycles-pp._find_next_bit
      0.69            -0.5        0.20 ±  7%  perf-profile.self.cycles-pp.fdget
      0.73 ± 12%      -0.5        0.25 ± 11%  perf-profile.self.cycles-pp.sctp_packet_config
      0.75 ±  9%      -0.5        0.28 ±  9%  perf-profile.self.cycles-pp.__switch_to
      0.63 ±  3%      -0.5        0.16 ±  6%  perf-profile.self.cycles-pp.sctp_skb_recv_datagram
      0.75 ± 13%      -0.5        0.28 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.61 ± 13%      -0.5        0.14 ± 11%  perf-profile.self.cycles-pp.skb_put
      0.69 ±  3%      -0.5        0.22 ±  4%  perf-profile.self.cycles-pp.sctp_association_put
      0.58 ± 13%      -0.4        0.15 ±  5%  perf-profile.self.cycles-pp.sctp_datamsg_from_user
      0.52 ±  5%      -0.4        0.10 ± 13%  perf-profile.self.cycles-pp.sctp_cmp_addr_exact
      0.54 ±  5%      -0.4        0.12 ± 10%  perf-profile.self.cycles-pp.sctp_make_sack
      0.58 ±  5%      -0.4        0.17 ±  5%  perf-profile.self.cycles-pp.pick_eevdf
      0.55 ± 12%      -0.4        0.14 ±  6%  perf-profile.self.cycles-pp.os_xsave
      0.54 ±  2%      -0.4        0.14 ±  2%  perf-profile.self.cycles-pp.__enqueue_entity
      0.60 ± 22%      -0.4        0.20 ±  8%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.47 ± 36%      -0.4        0.07 ±  5%  perf-profile.self.cycles-pp.sctp_inet_skb_msgname
      0.53 ± 15%      -0.4        0.14 ±  7%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.54 ±  4%      -0.4        0.15 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.57 ±  6%      -0.4        0.18 ±  8%  perf-profile.self.cycles-pp.sctp_sendmsg_to_asoc
      0.58 ± 13%      -0.4        0.19 ±  6%  perf-profile.self.cycles-pp.sctp_do_sm
      0.52 ± 12%      -0.4        0.14 ±  7%  perf-profile.self.cycles-pp.copy_iovec_from_user
      0.50 ± 17%      -0.4        0.13 ±  7%  perf-profile.self.cycles-pp.sctp_chunkify
      0.57 ± 19%      -0.4        0.21 ± 17%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.49 ± 15%      -0.4        0.14 ±  8%  perf-profile.self.cycles-pp.sctp_transport_hold
      0.50 ±  8%      -0.4        0.15 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.53 ±  7%      -0.3        0.19 ±  3%  perf-profile.self.cycles-pp.update_se
      0.55 ±  9%      -0.3        0.21 ± 10%  perf-profile.self.cycles-pp.sctp_assoc_bh_rcv
      0.45 ± 13%      -0.3        0.13 ±  8%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.50 ±  9%      -0.3        0.17 ±  7%  perf-profile.self.cycles-pp.sctp_association_hold
      0.45 ± 10%      -0.3        0.13 ±  4%  perf-profile.self.cycles-pp.sctp_datamsg_put
      0.52 ±  4%      -0.3        0.21 ± 13%  perf-profile.self.cycles-pp.native_sched_clock
      0.44 ± 16%      -0.3        0.13 ±  5%  perf-profile.self.cycles-pp.dequeue_entity
      0.46 ± 12%      -0.3        0.16 ± 21%  perf-profile.self.cycles-pp.__pi_memset
      0.40 ± 12%      -0.3        0.10 ± 10%  perf-profile.self.cycles-pp.sctp_packet_transmit
      0.36 ± 57%      -0.3        0.05 ±  7%  perf-profile.self.cycles-pp.sctp_outq_select_transport
      0.40 ± 25%      -0.3        0.10 ±  8%  perf-profile.self.cycles-pp.lock_timer_base
      0.44 ± 16%      -0.3        0.14 ±  9%  perf-profile.self.cycles-pp.sctp_packet_pack
      0.41            -0.3        0.12 ±  3%  perf-profile.self.cycles-pp.sctp_transport_put
      0.38 ±  3%      -0.3        0.08 ±  4%  perf-profile.self.cycles-pp.avg_vruntime
      0.42 ±  5%      -0.3        0.13 ±  9%  perf-profile.self.cycles-pp.sctp_outq_flush_data
      0.42 ±  5%      -0.3        0.13 ±  8%  perf-profile.self.cycles-pp.__dequeue_entity
      0.38 ± 11%      -0.3        0.10 ±  4%  perf-profile.self.cycles-pp.vruntime_eligible
      0.40 ± 13%      -0.3        0.11 ±  3%  perf-profile.self.cycles-pp._copy_from_iter
      0.41 ± 16%      -0.3        0.13 ±  7%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.35 ± 26%      -0.3        0.06 ±  7%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.34 ± 31%      -0.3        0.06 ±  6%  perf-profile.self.cycles-pp.update_cfs_rq_load_avg
      0.42 ± 14%      -0.3        0.14 ±  4%  perf-profile.self.cycles-pp.sock_wfree
      0.36 ± 18%      -0.3        0.08 ±  8%  perf-profile.self.cycles-pp.try_to_wake_up
      0.34 ± 24%      -0.3        0.07 ± 18%  perf-profile.self.cycles-pp.sctp_chunk_abandoned
      0.34 ±  4%      -0.3        0.08 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.36 ± 10%      -0.3        0.10 ±  7%  perf-profile.self.cycles-pp.sctp_sendmsg_parse
      0.40 ± 24%      -0.3        0.14 ±  8%  perf-profile.self.cycles-pp.sctp_sf_eat_sack_6_2
      0.36 ±  9%      -0.3        0.10 ±  6%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.31 ± 26%      -0.3        0.06 ±  9%  perf-profile.self.cycles-pp.send_sctp_rr
      0.32 ± 29%      -0.3        0.07 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.42 ± 12%      -0.2        0.18 ±  9%  perf-profile.self.cycles-pp.do_syscall_64
      0.48 ± 18%      -0.2        0.24 ±  8%  perf-profile.self.cycles-pp.lock_sock_nested
      0.40 ±  9%      -0.2        0.16 ±  5%  perf-profile.self.cycles-pp.sctp_sendmsg
      0.30 ± 19%      -0.2        0.06        perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.33 ±  9%      -0.2        0.10 ±  3%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.48 ± 13%      -0.2        0.25 ± 16%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.34 ± 16%      -0.2        0.10 ± 15%  perf-profile.self.cycles-pp.sctp_outq_tail
      0.30 ± 38%      -0.2        0.06 ±  6%  perf-profile.self.cycles-pp.update_cfs_group
      0.39 ± 11%      -0.2        0.16 ±  9%  perf-profile.self.cycles-pp.sctp_ulpevent_make_sender_dry_event
      0.34 ±  5%      -0.2        0.12 ±  8%  perf-profile.self.cycles-pp.sctp_sock_rfree
      0.31 ± 15%      -0.2        0.09 ±  5%  perf-profile.self.cycles-pp.skb_clone
      0.42 ± 11%      -0.2        0.20 ± 11%  perf-profile.self.cycles-pp.skb_release_data
      0.46 ±  9%      -0.2        0.24 ± 10%  perf-profile.self.cycles-pp.sctp_rcv
      0.40 ± 12%      -0.2        0.20 ± 12%  perf-profile.self.cycles-pp.sctp_inq_pop
      0.30 ±  2%      -0.2        0.09 ±  8%  perf-profile.self.cycles-pp.sctp_chunk_hold
      0.23 ± 50%      -0.2        0.02 ± 99%  perf-profile.self.cycles-pp.sctp_data_ready
      0.31 ± 15%      -0.2        0.10 ± 10%  perf-profile.self.cycles-pp.sctp_ulpevent_init
      0.32 ± 15%      -0.2        0.12 ± 11%  perf-profile.self.cycles-pp.__check_heap_object
      0.31 ± 16%      -0.2        0.10 ±  7%  perf-profile.self.cycles-pp.recv_sctp_rr
      0.27 ± 10%      -0.2        0.06 ±  9%  perf-profile.self.cycles-pp.sctp_packet_append_chunk
      0.33 ± 11%      -0.2        0.12 ± 10%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.29 ± 10%      -0.2        0.09 ±  8%  perf-profile.self.cycles-pp.__pi_memcpy
      0.37 ± 11%      -0.2        0.17 ±  3%  perf-profile.self.cycles-pp.dequeue_entities
      0.27 ± 13%      -0.2        0.07 ±  8%  perf-profile.self.cycles-pp.sctp_ulpevent_receive_data
      0.27 ± 14%      -0.2        0.07 ±  6%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.26 ±  7%      -0.2        0.07 ±  8%  perf-profile.self.cycles-pp.____sys_sendmsg
      0.31 ± 14%      -0.2        0.12 ± 10%  perf-profile.self.cycles-pp.check_heap_object
      0.30 ± 20%      -0.2        0.11 ± 14%  perf-profile.self.cycles-pp.consume_skb
      0.29 ± 15%      -0.2        0.10 ± 10%  perf-profile.self.cycles-pp.__sctp_packet_append_chunk
      0.28 ± 14%      -0.2        0.10 ±  6%  perf-profile.self.cycles-pp.__check_object_size
      0.27 ± 12%      -0.2        0.09 ±  4%  perf-profile.self.cycles-pp.__kmalloc_noprof
      0.25            -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.pick_task_fair
      0.30 ± 14%      -0.2        0.12 ±  5%  perf-profile.self.cycles-pp.reweight_entity
      0.30 ± 17%      -0.2        0.12 ±  8%  perf-profile.self.cycles-pp.sctp_ulpevent_free
      0.26 ±  2%      -0.2        0.08 ±  8%  perf-profile.self.cycles-pp.sctp_sf_eat_data_6_2
      0.31 ± 11%      -0.2        0.13 ±  5%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.26 ± 12%      -0.2        0.09 ± 10%  perf-profile.self.cycles-pp.___perf_sw_event
      0.26 ± 13%      -0.2        0.10 ±  9%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      0.32 ±  5%      -0.2        0.15 ± 12%  perf-profile.self.cycles-pp.handle_softirqs
      0.26 ± 14%      -0.2        0.10 ± 13%  perf-profile.self.cycles-pp.skb_defer_free_flush
      0.25 ± 14%      -0.2        0.08 ± 11%  perf-profile.self.cycles-pp.ip_rcv_core
      0.22 ± 19%      -0.2        0.06 ±  6%  perf-profile.self.cycles-pp.mm_cid_switch_to
      0.22 ±  6%      -0.2        0.06 ±  8%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.24 ±  7%      -0.2        0.07 ±  9%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.26            -0.2        0.10 ±  6%  perf-profile.self.cycles-pp.sctp_outq_flush
      0.20 ±  9%      -0.2        0.04 ± 45%  perf-profile.self.cycles-pp.sctp_transport_reset_t3_rtx
      0.23 ±  6%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.skb_copy_datagram_iter
      0.28 ± 11%      -0.2        0.12 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.33            -0.2        0.18 ± 10%  perf-profile.self.cycles-pp.__mod_timer
      0.23 ±  3%      -0.2        0.07 ±  6%  perf-profile.self.cycles-pp.sctp_ulpq_tail_event
      0.22 ± 12%      -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.__genradix_ptr
      0.37 ± 12%      -0.2        0.22 ± 10%  perf-profile.self.cycles-pp.ip_finish_output2
      0.23 ± 12%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp._sctp_make_chunk
      0.22 ± 13%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.finish_task_switch
      0.20 ± 12%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.sctp_addto_chunk
      0.23 ±  5%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.switch_fpu_return
      0.20 ± 15%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__kmalloc_cache_noprof
      0.23 ± 44%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.18 ± 12%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.timer_delete
      0.24 ± 14%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.22 ± 19%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.20 ± 10%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.wakeup_preempt_fair
      0.19 ± 18%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.17 ± 14%      -0.1        0.05 ± 45%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.19 ± 24%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.do_perf_trace_sched_stat_runtime
      0.38 ± 17%      -0.1        0.25 ± 17%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.20 ±  8%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.28 ± 15%      -0.1        0.16 ± 13%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.25 ± 10%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.copy_msghdr_from_user
      0.19 ± 15%      -0.1        0.08 ±  9%  perf-profile.self.cycles-pp.sctp_ulpevent_make_rcvmsg
      0.17 ± 18%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.skb_pull
      0.14 ± 13%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.14 ± 27%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.___sys_recvmsg
      0.18 ±  2%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.enqueue_timer
      0.16 ±  8%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.detach_if_pending
      0.16 ± 17%      -0.1        0.06 ± 21%  perf-profile.self.cycles-pp.__css_rstat_updated
      0.17 ± 13%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.set_next_entity
      0.13 ±  2%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.entity_lag
      0.14 ± 18%      -0.1        0.05 ± 45%  perf-profile.self.cycles-pp.sctp_transport_update_rto
      0.13 ± 11%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.prandom_u32_state
      0.11 ± 14%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.sctp_ulpq_tail_data
      0.14 ± 12%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__import_iovec
      0.12 ± 11%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.sctp_primitive_SEND
      0.15 ± 13%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.sctp_sched_fcfs_dequeue
      0.19 ±  2%      -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.12 ± 20%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.sctp_transport_raise_cwnd
      0.35 ±  6%      -0.1        0.28 ± 10%  perf-profile.self.cycles-pp.net_rx_action
      0.10 ± 15%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.__ip_local_out
      0.14 ± 14%      -0.1        0.08 ± 24%  perf-profile.self.cycles-pp.loopback_xmit
      0.10 ± 13%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.ip_rcv
      0.12 ± 11%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.do_softirq
      0.10 ± 11%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.check_stack_object
      0.13 ± 10%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.ip_send_check
      0.12 ± 15%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.sctp_control_release_owner
      0.20 ± 21%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.prepare_task_switch
      0.08 ± 13%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.sctp_generate_fwdtsn
      0.18 ± 15%      -0.0        0.13 ± 12%  perf-profile.self.cycles-pp.process_backlog
      0.12 ± 15%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.xmit_one
      0.08 ± 14%      -0.0        0.04 ± 73%  perf-profile.self.cycles-pp.__sys_sendmsg
      0.10 ± 14%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.choose_new_asid
      0.09 ± 12%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.kfree_skbmem
      0.07 ± 12%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.08 ± 13%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.sctp_v4_addr_valid
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.shmem_write_end
      0.03 ± 70%      +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.sctp_assoc_rwnd_increase
      0.00            +0.1        0.11 ± 72%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.02 ±223%      +0.2        0.17 ± 68%  perf-profile.self.cycles-pp.queue_event
      0.00            +0.2        0.20 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge_stock
      0.06 ± 73%      +0.2        0.28 ± 40%  perf-profile.self.cycles-pp.copy_folio_from_iter_atomic
      0.31 ± 13%      +0.5        0.84 ±  2%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00            +0.8        0.79 ±  5%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.48 ± 14%      +2.0        2.51 ± 21%  perf-profile.self.cycles-pp.sctp_wfree
      0.38 ± 11%      +2.0        2.43 ± 23%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.00           +61.3       61.28 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge


***************************************************************************************************

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-14/performance/x86_64-rhel-9.4/development/20%/debian-13-x86_64-20250902.cgz/igk-spr-2sp1/UNIX/50%/lmbench3

commit: 
  35587f026a ("mm/page_counter: introduce page_counter_try_charge_stock()")
  1e8017bb42 ("[PATCH v4 4/5] mm/memcontrol: convert memcg to use page_counter_stock")

35587f026a945238 1e8017bb42651bb1dc84917b786 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    107587           -12.1%      94557 ±  2%  lmbench3.AF_UNIX.sock.stream.bandwidth.MB/sec
      5.27            +4.5%       5.51        lmbench3.AF_UNIX.sock.stream.latency.us
    162.24 ±  4%     +16.2%     188.60 ±  6%  lmbench3.time.elapsed_time
    162.24 ±  4%     +16.2%     188.60 ±  6%  lmbench3.time.elapsed_time.max
      7532 ±  5%     +17.0%       8816 ±  8%  lmbench3.time.system_time
 2.846e+10 ±  4%     +16.0%  3.302e+10 ±  6%  cpuidle..time
   2739473 ±  6%     +16.3%    3184960 ±  7%  meminfo.Mapped
      0.03 ±  2%      +0.0        0.03 ±  2%  mpstat.cpu.all.soft%
     32.30            -6.3%      30.28        mpstat.max_utilization_pct
    684894 ±  6%     +16.3%     796276 ±  7%  proc-vmstat.nr_mapped
      5411            +3.2%       5585        proc-vmstat.nr_page_table_pages
    214.90 ±  4%     +12.7%     242.24 ±  6%  uptime.boot
     39047 ±  4%     +12.2%      43823 ±  6%  uptime.idle
      0.21 ±  5%      -0.1        0.16 ±  9%  turbostat.C1%
      4.62 ±  2%      +0.6        5.24        turbostat.C1E%
     14.30 ±  2%     +17.7%      16.83 ±  2%  turbostat.CPU%c1
     39.90            -6.8%      37.20        turbostat.CPU%c6
      0.39 ±  2%      -9.8%       0.35 ±  4%  turbostat.IPC
  45825805           +10.6%   50692463 ±  2%  turbostat.IRQ
   2203001            -5.3%    2086018        turbostat.NMI
   1580972 ±  7%     +63.3%    2582238 ± 23%  sched_debug.cfs_rq:/.avg_vruntime.max
    311815 ±  5%     +55.0%     483251 ± 24%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   1580972 ±  7%     +63.3%    2582238 ± 23%  sched_debug.cfs_rq:/.zero_vruntime.max
    311815 ±  5%     +55.0%     483250 ± 24%  sched_debug.cfs_rq:/.zero_vruntime.stddev
    817433            -5.7%     770900 ±  3%  sched_debug.cpu.avg_idle.avg
     11704            +6.2%      12434 ±  4%  sched_debug.cpu.curr->pid.max
      0.00 ±  2%    +152.4%       0.00 ± 72%  sched_debug.cpu.next_balance.stddev
      0.13 ±  2%     +19.5%       0.15 ± 10%  sched_debug.cpu.nr_running.avg
   3672599 ±  3%     +18.5%    4353050 ±  8%  sched_debug.cpu.nr_switches.max
      1.88 ±  2%      -6.3%       1.76 ±  4%  perf-stat.i.MPKI
 1.182e+10 ±  2%     -10.2%  1.061e+10 ±  3%  perf-stat.i.branch-instructions
      1.10 ±  3%      -0.1        0.99 ±  4%  perf-stat.i.branch-miss-rate%
  59483682 ±  3%     -10.7%   53143500 ±  5%  perf-stat.i.branch-misses
      8.06 ±  3%      -0.6        7.48 ±  3%  perf-stat.i.cache-miss-rate%
  53576199 ±  4%     -13.6%   46276297 ±  5%  perf-stat.i.cache-misses
  1.84e+09 ±  3%     -15.9%  1.548e+09        perf-stat.i.cache-references
      3.48           +13.7%       3.96 ±  3%  perf-stat.i.cpi
    336.56            -2.6%     327.72        perf-stat.i.cpu-migrations
     14899 ±  6%     -64.1%       5346 ±  7%  perf-stat.i.cycles-between-cache-misses
 5.974e+10 ±  2%      -9.8%  5.386e+10 ±  3%  perf-stat.i.instructions
      0.51 ±  2%     -10.1%       0.45 ±  3%  perf-stat.i.ipc
      8234 ±  4%      -9.2%       7476 ±  5%  perf-stat.i.minor-faults
      8234 ±  4%      -9.2%       7476 ±  5%  perf-stat.i.page-faults
      2.55 ±  2%     +11.1%       2.83 ±  4%  perf-stat.overall.cpi
      2789 ±  4%     +16.1%       3238 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.39 ±  2%      -9.9%       0.35 ±  4%  perf-stat.overall.ipc
 1.164e+10           -10.2%  1.045e+10 ±  3%  perf-stat.ps.branch-instructions
  58052733 ±  2%     -10.9%   51738606 ±  5%  perf-stat.ps.branch-misses
  53773032 ±  4%     -13.7%   46403673 ±  5%  perf-stat.ps.cache-misses
  1.85e+09 ±  3%     -15.9%  1.555e+09        perf-stat.ps.cache-references
    331.70            -2.3%     324.03        perf-stat.ps.cpu-migrations
 5.882e+10            -9.9%  5.303e+10 ±  3%  perf-stat.ps.instructions
      8075 ±  4%      -9.4%       7318 ±  5%  perf-stat.ps.minor-faults
      8075 ±  4%      -9.4%       7318 ±  5%  perf-stat.ps.page-faults
     13.77 ±  7%      -6.2        7.61 ±  5%  perf-profile.calltrace.cycles-pp.__free_frozen_pages.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     13.44 ±  7%      -6.1        7.32 ±  5%  perf-profile.calltrace.cycles-pp.free_frozen_page_commit.__free_frozen_pages.skb_release_data.consume_skb.unix_stream_read_generic
     12.37 ±  8%      -5.8        6.57 ±  5%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_frozen_page_commit.__free_frozen_pages.skb_release_data.consume_skb
     11.42 ±  8%      -5.7        5.77 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_frozen_page_commit.__free_frozen_pages.skb_release_data
     11.19 ±  9%      -5.6        5.58 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_frozen_page_commit.__free_frozen_pages
     37.36            -4.9       32.44        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.32            -4.9       32.39        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.22            -4.9       32.31        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.16            -4.9       32.25        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
     17.98 ±  5%      -4.4       13.62        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
     10.60 ±  6%      -4.3        6.30 ±  4%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags
     17.20 ±  5%      -4.2       13.01        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
     14.88 ±  5%      -3.9       11.00        perf-profile.calltrace.cycles-pp.alloc_pages_noprof.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
     14.84 ±  5%      -3.9       10.97        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
     14.77 ±  5%      -3.9       10.90        perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.alloc_skb_with_frags.sock_alloc_send_pskb
      8.82 ±  7%      -3.8        5.03 ±  4%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      7.91 ±  7%      -3.6        4.36 ±  4%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol
      7.77 ±  8%      -3.5        4.24 ±  4%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof
      6.82 ±  9%      -3.4        3.40 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      6.69 ±  9%      -3.4        3.29 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue
      1.26 ± 45%      -0.7        0.55 ± 45%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.uncharge_batch.__mem_cgroup_uncharge.__folio_put.skb_release_data
      2.24 ±  4%      -0.3        1.94 ±  6%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
      1.66 ±  5%      -0.3        1.41 ±  9%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.69 ±  5%      -0.3        1.44 ±  9%  perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
     96.52            -0.2       96.28        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     96.55            -0.2       96.30        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.86 ±  8%      -0.2        0.66 ±  5%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put
      1.19 ±  7%      -0.2        0.99 ± 14%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.77 ±  3%      -0.1        0.65 ±  4%  perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_frozen_page_commit.__free_frozen_pages.skb_release_data
      1.33            -0.1        1.23 ±  2%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      1.29            -0.1        1.19 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      1.17            -0.1        1.07 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.84 ±  4%      +0.0        0.89        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.85 ±  4%      +0.0        0.90        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.16 ±  4%      +0.1        1.27        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.60 ±  4%      +0.1        1.74        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.60 ±  4%      +0.1        1.75        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      1.60 ±  4%      +0.1        1.75        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      1.71 ±  3%      +0.2        1.86        perf-profile.calltrace.cycles-pp.common_startup_64
      1.29 ± 16%      +0.2        1.49        perf-profile.calltrace.cycles-pp.cmd_record
      1.29 ± 16%      +0.2        1.49        perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.cmd_record
      1.29 ± 16%      +0.2        1.49        perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.cmd_record
      1.29 ± 16%      +0.2        1.49        perf-profile.calltrace.cycles-pp.record__finish_output.cmd_record
      0.58 ±  7%      +0.6        1.15 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      0.00            +0.8        0.76 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__refill_obj_stock.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic
      0.00            +0.8        0.80 ±  3%  perf-profile.calltrace.cycles-pp.__refill_obj_stock.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.17 ±141%      +0.9        1.04 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      2.59 ±  7%      +1.3        3.85 ±  2%  perf-profile.calltrace.cycles-pp.try_charge_memcg.__memcg_kmem_charge_page.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      0.00            +1.6        1.56 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.page_counter_try_charge_stock.try_charge_memcg.__memcg_kmem_charge_page.__alloc_frozen_pages_noprof
      0.00            +2.3        2.33        perf-profile.calltrace.cycles-pp.page_counter_try_charge_stock.try_charge_memcg.__memcg_kmem_charge_page.__alloc_frozen_pages_noprof.alloc_pages_mpol
     20.50 ±  5%      +3.9       24.45 ±  3%  perf-profile.calltrace.cycles-pp.__folio_put.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     20.46 ±  5%      +3.9       24.41 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.__folio_put.skb_release_data.consume_skb.unix_stream_read_generic
     20.38 ±  5%      +4.0       24.34 ±  4%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.skb_release_data.consume_skb
     19.04 ±  6%      +4.6       23.67 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put.skb_release_data
     59.06            +4.7       63.76        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     59.02            +4.7       63.72        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     58.94            +4.7       63.65        perf-profile.calltrace.cycles-pp.sock_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     58.91            +4.7       63.62        perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
     58.90            +4.7       63.61        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
     58.86            +4.7       63.57        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read
     36.83            +4.9       41.72 ±  2%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
     35.95            +4.9       40.85 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      1.44 ±  8%      +7.2        8.59 ±  4%  perf-profile.calltrace.cycles-pp.kfree.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      1.06 ±  9%      +7.2        8.30 ±  4%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      0.27 ±143%      +7.5        7.73 ±  3%  perf-profile.calltrace.cycles-pp.__refill_obj_stock.__memcg_slab_free_hook.kfree.skb_release_data.consume_skb
      0.00            +7.5        7.47 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__refill_obj_stock.__memcg_slab_free_hook.kfree.skb_release_data
     18.54 ±  8%      -9.1        9.43 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     18.04 ±  9%      -9.1        8.98 ±  5%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     13.80 ±  7%      -6.2        7.64 ±  5%  perf-profile.children.cycles-pp.__free_frozen_pages
     13.44 ±  7%      -6.1        7.32 ±  5%  perf-profile.children.cycles-pp.free_frozen_page_commit
     12.38 ±  8%      -5.8        6.57 ±  5%  perf-profile.children.cycles-pp.free_pcppages_bulk
     37.41            -4.9       32.48        perf-profile.children.cycles-pp.ksys_write
     37.36            -4.9       32.44        perf-profile.children.cycles-pp.vfs_write
     37.23            -4.9       32.31        perf-profile.children.cycles-pp.sock_write_iter
     37.18            -4.9       32.27        perf-profile.children.cycles-pp.unix_stream_sendmsg
     17.98 ±  5%      -4.4       13.62        perf-profile.children.cycles-pp.sock_alloc_send_pskb
     10.62 ±  6%      -4.3        6.32 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
     17.20 ±  5%      -4.2       13.01        perf-profile.children.cycles-pp.alloc_skb_with_frags
     14.86 ±  5%      -3.9       10.99        perf-profile.children.cycles-pp.alloc_pages_mpol
     14.89 ±  5%      -3.9       11.01        perf-profile.children.cycles-pp.alloc_pages_noprof
     14.79 ±  5%      -3.9       10.92        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      8.85 ±  7%      -3.8        5.05 ±  4%  perf-profile.children.cycles-pp.rmqueue
      7.92 ±  8%      -3.6        4.37 ±  4%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      7.78 ±  8%      -3.5        4.25 ±  4%  perf-profile.children.cycles-pp.rmqueue_bulk
      2.16 ± 47%      -1.1        1.09 ± 29%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.75 ± 99%      -0.5        0.30 ±  7%  perf-profile.children.cycles-pp.__css_rstat_updated
      2.25 ±  4%      -0.3        1.94 ±  6%  perf-profile.children.cycles-pp.__alloc_skb
      1.70 ±  5%      -0.3        1.44 ±  9%  perf-profile.children.cycles-pp.kmalloc_reserve
      1.67 ±  5%      -0.3        1.41 ±  9%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller_noprof
     96.64            -0.2       96.40        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.62            -0.2       96.38        perf-profile.children.cycles-pp.do_syscall_64
      0.32 ±  8%      -0.2        0.08 ±  4%  perf-profile.children.cycles-pp.skb_set_owner_w
      1.43 ±  7%      -0.2        1.21 ± 11%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.54 ±  3%      -0.1        0.40 ±  5%  perf-profile.children.cycles-pp.__zone_watermark_ok
      1.40            -0.1        1.26        perf-profile.children.cycles-pp.__check_object_size
      0.78 ±  3%      -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.__free_one_page
      2.71            -0.1        2.60        perf-profile.children.cycles-pp._raw_spin_lock
      1.22            -0.1        1.12 ±  2%  perf-profile.children.cycles-pp.check_heap_object
      1.34            -0.1        1.24 ±  2%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.31 ± 12%      -0.1        0.22 ± 28%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.14 ± 11%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.unix_stream_data_wait
      0.37 ±  3%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.__pcs_replace_full_main
      0.28 ±  2%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.sock_def_readable
      0.49 ±  4%      -0.1        0.43 ±  3%  perf-profile.children.cycles-pp.intel_idle
      0.37            -0.0        0.33 ±  2%  perf-profile.children.cycles-pp.__pcs_replace_empty_main
      0.44 ±  3%      -0.0        0.40 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.33            -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.barn_replace_empty_sheaf
      0.40 ±  4%      -0.0        0.36        perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      0.10 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.34 ±  3%      -0.0        0.31        perf-profile.children.cycles-pp.__wake_up_common
      0.19 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.28 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.barn_replace_full_sheaf
      0.28 ±  3%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.28 ±  3%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.06 ±  9%      +0.0        0.07        perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.28 ±  3%      +0.0        0.30        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.10 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.13 ±  5%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.13 ±  8%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.17 ±  5%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.sched_balance_rq
      0.18 ±  6%      +0.0        0.20        perf-profile.children.cycles-pp.pick_next_task_fair
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
      0.16 ±  5%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.16 ±  5%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.88 ±  3%      +0.1        0.93        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.88 ±  3%      +0.1        0.93        perf-profile.children.cycles-pp.cpuidle_enter
      0.21 ±  6%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.intel_idle_xstate
      1.38            +0.1        1.49        perf-profile.children.cycles-pp.perf_session__process_events
      1.38            +0.1        1.49        perf-profile.children.cycles-pp.reader__read_event
      1.19 ±  3%      +0.1        1.31        perf-profile.children.cycles-pp.cpuidle_idle_call
      1.60 ±  4%      +0.1        1.75        perf-profile.children.cycles-pp.start_secondary
      1.71 ±  3%      +0.2        1.86        perf-profile.children.cycles-pp.common_startup_64
      1.71 ±  3%      +0.2        1.86        perf-profile.children.cycles-pp.cpu_startup_entry
      1.70 ±  3%      +0.2        1.86        perf-profile.children.cycles-pp.do_idle
      1.36 ± 15%      +0.2        1.56        perf-profile.children.cycles-pp.cmd_record
      1.29 ± 16%      +0.2        1.49        perf-profile.children.cycles-pp.record__finish_output
      1.42 ±  6%      +0.3        1.70 ±  3%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.58 ±  7%      +0.6        1.16 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      2.84 ±  7%      +1.4        4.28 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.00            +2.6        2.61        perf-profile.children.cycles-pp.page_counter_try_charge_stock
     20.51 ±  5%      +3.9       24.45 ±  3%  perf-profile.children.cycles-pp.__folio_put
     20.47 ±  5%      +4.0       24.42 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
     20.40 ±  5%      +4.0       24.35 ±  4%  perf-profile.children.cycles-pp.uncharge_batch
     59.07            +4.7       63.76        perf-profile.children.cycles-pp.ksys_read
     59.02            +4.7       63.72        perf-profile.children.cycles-pp.vfs_read
     58.94            +4.7       63.65        perf-profile.children.cycles-pp.sock_read_iter
     58.91            +4.7       63.62        perf-profile.children.cycles-pp.sock_recvmsg
     58.90            +4.7       63.61        perf-profile.children.cycles-pp.unix_stream_recvmsg
     58.87            +4.7       63.58        perf-profile.children.cycles-pp.unix_stream_read_generic
     36.84            +4.9       41.72 ±  2%  perf-profile.children.cycles-pp.consume_skb
     35.95            +4.9       40.86 ±  2%  perf-profile.children.cycles-pp.skb_release_data
      1.44 ±  7%      +7.2        8.60 ±  4%  perf-profile.children.cycles-pp.kfree
      1.52 ±  8%      +7.8        9.36 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.60 ± 40%      +8.0        8.55 ±  3%  perf-profile.children.cycles-pp.__refill_obj_stock
     19.17 ±  6%     +12.8       31.94 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
     18.04 ±  9%      -9.1        8.98 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.75 ±105%      -0.5        0.24 ±  6%  perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.74 ±101%      -0.5        0.29 ±  7%  perf-profile.self.cycles-pp.__css_rstat_updated
      1.23            -0.4        0.87 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.89 ±  2%      -0.3        0.61 ±  5%  perf-profile.self.cycles-pp.free_frozen_page_commit
      0.32 ±  7%      -0.2        0.08 ±  4%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.69            -0.2        0.46 ±  4%  perf-profile.self.cycles-pp.rmqueue
      0.51 ± 43%      -0.2        0.35 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.54 ±  3%      -0.1        0.39 ±  4%  perf-profile.self.cycles-pp.__zone_watermark_ok
      0.59 ±  4%      -0.1        0.48 ±  5%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.67 ±  2%      -0.1        0.56 ±  4%  perf-profile.self.cycles-pp.__free_one_page
      1.09            -0.1        0.99 ±  2%  perf-profile.self.cycles-pp.check_heap_object
      0.85            -0.1        0.77 ±  2%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.23 ±  2%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.__alloc_frozen_pages_noprof
      0.54            -0.1        0.48 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.49 ±  4%      -0.1        0.43 ±  3%  perf-profile.self.cycles-pp.intel_idle
      0.45 ±  2%      -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.unix_stream_read_generic
      0.42 ±  3%      -0.0        0.38 ±  2%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.18 ±  3%      -0.0        0.15 ±  5%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.20 ±  4%      -0.0        0.17 ±  5%  perf-profile.self.cycles-pp.skb_release_data
      0.48            -0.0        0.45 ±  3%  perf-profile.self.cycles-pp.sock_wfree
      0.24            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.barn_replace_empty_sheaf
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.08 ±  4%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.kmem_cache_free
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__free_frozen_pages
      0.15 ±  4%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.unix_stream_sendmsg
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      0.10 ±  7%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.mutex_unlock
      0.11            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.14 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.16            -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.fdget_pos
      0.11 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.refresh_cpu_vm_stats
      0.59 ±  4%      +0.0        0.63 ±  2%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.21 ±  7%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.intel_idle_xstate
      1.41 ±  8%      +0.3        1.66 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      1.36 ±  7%      +0.3        1.65 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.00            +0.9        0.90 ±  5%  perf-profile.self.cycles-pp.page_counter_try_charge_stock
     18.21 ±  6%     +12.7       30.90 ±  4%  perf-profile.self.cycles-pp.page_counter_uncharge



***************************************************************************************************

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-14/performance/x86_64-rhel-9.4/development/20%/debian-13-x86_64-20250902.cgz/igk-spr-2sp1/TCP/50%/lmbench3

commit: 
  35587f026a ("mm/page_counter: introduce page_counter_try_charge_stock()")
  1e8017bb42 ("[PATCH v4 4/5] mm/memcontrol: convert memcg to use page_counter_stock")

35587f026a945238 1e8017bb42651bb1dc84917b786 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     14.07           +24.1%      17.47        lmbench3.TCP.localhost.latency
     10728            -1.9%      10519        lmbench3.TCP.socket.bandwidth.64B.MB/sec
 4.537e+08 ±  2%      -6.6%  4.236e+08 ±  5%  cpuidle..usage
      0.92 ±  3%      -0.3        0.63 ±  4%  turbostat.C1%
      0.14 ±  2%      -0.1        0.07 ±  8%  turbostat.POLL%
      4.47            -2.0%       4.38        turbostat.RAMWatt
     20.90 ± 37%    +141.6%      50.50 ± 19%  perf-c2c.DRAM.local
    610.70 ± 18%     +80.5%       1102 ±  7%  perf-c2c.DRAM.remote
    351.60 ± 13%    +105.4%     722.10 ±  7%  perf-c2c.HITM.remote
    139805            -3.7%     134622        perf-c2c.HITM.total
      0.20 ± 24%      -0.1        0.07 ± 68%  perf-profile.children.cycles-pp.source
      0.15 ± 24%      -0.1        0.06 ± 78%  perf-profile.children.cycles-pp.write
      0.00            +0.7        0.75 ±199%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.8        0.77 ±199%  perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.13 ± 24%      -0.1        0.04 ±110%  perf-profile.self.cycles-pp.write
      0.00            +0.7        0.73 ±198%  perf-profile.self.cycles-pp.page_counter_uncharge
 1.262e+09 ±  3%      -5.7%   1.19e+09 ±  2%  perf-stat.i.cache-references
     18908 ±  8%     -34.9%      12304 ± 17%  perf-stat.i.cycles-between-cache-misses
     14.64            +0.6       15.27 ±  2%  perf-stat.overall.cache-miss-rate%
 2.934e+10            -2.8%  2.852e+10 ±  2%  perf-stat.ps.branch-instructions
  1.27e+09 ±  3%      -5.7%  1.197e+09 ±  2%  perf-stat.ps.cache-references
 1.532e+11            -2.7%   1.49e+11 ±  2%  perf-stat.ps.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


