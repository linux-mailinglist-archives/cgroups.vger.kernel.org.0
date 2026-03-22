Return-Path: <cgroups+bounces-14982-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBiCKmjIv2nQ8QMAu9opvQ
	(envelope-from <cgroups+bounces-14982-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 11:46:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1822E8DB4
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 11:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A7730097E5
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B456F3112C0;
	Sun, 22 Mar 2026 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guslL9dT"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50909175A86
	for <cgroups@vger.kernel.org>; Sun, 22 Mar 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774176357; cv=fail; b=XM1fmPiyQgiku04KSPmsZ6W9v9Z6REzczAq6+mP3UkSvniOlrr/Q5MhOpAuMOTdku4dHWliVFr++Sp8RY5amhm9EvwhlxRYSDkXc1eXcnOP166fQjMqzHiGSWKDKzu7XFe8GdsZGfNZj77k3/QkMemygRvnODDQAcp+POe5ipN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774176357; c=relaxed/simple;
	bh=Q9jnko7yDkOxGLtq4Slz0DkRVQklVLEYdnaVMGtEeb8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bG0rxcoY7BxSrmUxJA6IBf9aE3rD6m38YZPdCvrJYNKZUM/vHqBMJ3J8VxGIY+5YOvrV8wWvExUIxkFc9QZCgjRYtiq1Dt6uzGZYnqghW9seJ8dMq2Ng0z6PBxYixcUXXibq1x57S0G5LwmBererz1cTm1m+ZbVgHMeglN987l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guslL9dT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774176354; x=1805712354;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Q9jnko7yDkOxGLtq4Slz0DkRVQklVLEYdnaVMGtEeb8=;
  b=guslL9dTzUBBL4pSgWh5CsqROrznfgAlVLkYq/6KyCYKYkpSlP/JlIXV
   XQzWGIZhWos85By1J+ZaDs8qtnUyNOFNVHYFsQZ1Whr35/GqGrFHyfa3V
   jF0yRDY5FXSNL8MmtEZyCU1LSG5kzmCyShp7dZW/UOw4KtvYDfNyy2AZk
   JZWG6Y7SCPvfp0AJ4+zyvNXfdhgzfw3V+jvxl7hJpcR70uZL16xrxlPEI
   S9HSaa1lZu4oRHGzn7/6h3KJIYabEMD2aGyDV4e2MzD4GjlTyJUhjHD/Q
   o8rK7u3tp9GwTiaT5MZ6cX2vTdxrBIj/vexUzZlyAiqP1EenfYh6kFAiK
   g==;
X-CSE-ConnectionGUID: mkbw+criQNaXRSXKYJxINg==
X-CSE-MsgGUID: w/H2q01ySsSi7SjM5ccQ5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75170033"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="75170033"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 03:45:53 -0700
X-CSE-ConnectionGUID: Er6DlfEMTBuV00zdQsoIbA==
X-CSE-MsgGUID: ynPsZn/VSQ6z8vROoVXpfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="218994313"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 03:45:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 03:45:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 03:45:52 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 03:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWRtZvtzHBoPP2WtcMwzH4TktA5b2zCE8XttWsEvQ3M8kAWy9kBBaIbfmLjKe/qA46bp+3WeOpSR+vq3Ajz21sWb6v2l/3ltWWwXgsnbYaCNE2pUgMffCsUi2FGyrUEKLaBilcZvzsz0o5Jn/h3Rtuvta9OfDJjz8KzrPCm3dY+FNJsmTqIhHCAry0o/0HK72T5tOfnUMKWyAQRgF50mss3c+hBKFIMCBdHNZ+3o/3b8w6XISCAAQnoqNN+bX9ej1ne7JuTDSJAHSisi12WDX8w1RWW7xuICuDNBVC/7T+Fap5F15FTx9mHmt7z/G+DlmLBiAO8RskjC19rjPpuWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlnHSf/scVMZdmi2EXyIM20U9l80PnS0A4IDNOsaln4=;
 b=fMWeHu6tESSGQKsq5Wu3GDM+r6u4M1I3QcVe34oKeDRDL6di6pgcl6I1SJZcCcwHJ1HmUpFT3rwgzjkn4yVtJtHq6AhqSG/6YKs4pzWcUVyKAa+N8HGOeMmdA4R4j1plTo6fJvhRL9K4FM9pzOah8w7bKiesiYIuAbv1NFu2D8oAZxh//b7lXWXRC/6OYqT6FB0jkYhrkkTSn0OfGWygr1xmkSCxAcdOvSoWXZwASQlH0L4cygO/3O8KMmFcEZC6jJz1GYdO4jEpOnP0CqZCVaiE5TFpJ07MjYF3962FZcIMzY+/d9Iwk6qc0Lxu5CaFg0V2ttwXbn01TbzqpW9MVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 10:45:44 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9745.012; Sun, 22 Mar 2026
 10:45:44 +0000
Date: Sun, 22 Mar 2026 18:45:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <cgroups@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	<oliver.sang@intel.com>
Subject: [tj-cgroup:for-7.1] [cgroup]  4616120fca:
 stress-ng.mremap.ops_per_sec 48.3% improvement
Message-ID: <202603221824.c32929f7-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KL1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:820:d::16) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SJ2PR11MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f4acd9-550a-4452-8565-08de88002b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tu6o9NNv6oGbr6mQ040Vnq2MLxq5lECCfpwOndJ5+gTfAHCYJHooBDSQYpQ4MeTzicwh+bwmNMWt5CdT317uP6xBFigKhqQWu6PRQdjAqU5U9ljLclKIxa0qZY6PX5kgyvagwfk/TdxiOwNVeG6S+kKRLIJ0msp8aUVs6m4J2Ei8if8bCGCENtTiSyPsgwgLU+yXeNlraE5OoNBMPu2qQxXPTd/OzwpWguIgjzz0YareFHT46AGv598PVwrsk4udzaXtHWA+jMFPI3wAbbAQiuQBVtnOyDX6diwjphA6To7hEA8e5qTjXyi3tQQn2MO9/OpyI2jMqXiphk104Nzzvo2It6xIX/AjCC59533Scp9xLNt1p+M6IdIOLlJUl/8xNuhkhEYUXAfbF3C63TmkTp1K+Y3GeJtbODXjgWhWDuJCLe48u8ymkBFFCc4CZa8T3rz7e1I4aW5B8UNIripsa7AeNUP2zkXC6ky1YtvrCdii4CZw152p/btP7cQZPGwUByqqDux/pBvLDKGoH/Qju4vkNeV5wdoeZgwnHk2Dy+PCMHdjPi71z0VVEvNwZSA1ES2o2uXNtqnEhQ1La4H/NA/1c9KRnmZAy4iYRzxJOLaJrlnvbGT3WZR9qWbl5jN3yT/VeDWahNW4KjwZnFpDZCgpixvuaLASzHhd63gkoP2yJy6fgkP/lkMyEwOjde00XjuQjnOiPWYcplkDTEqG9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BErydvteTfUasRwgtxT2pL258XomFSsBBlz7m/DOS+LA1+8CnhukHV9wOp?=
 =?iso-8859-1?Q?OL3elGzNdObfScmO0GZx5a6XP8YwecLn3nZH4hqi6DUD1tsLQQwZftUZjA?=
 =?iso-8859-1?Q?6/EwZe0V1eLGsafx2mYipfE8EMOJ1Pzus4aalynH2wgUG7IdejwSrxFQEr?=
 =?iso-8859-1?Q?aFjvVUgcevp/1Op1uJA/Fxb55jHFqMspvWZ0rQ83lFg1pHo2jBMbA44TEL?=
 =?iso-8859-1?Q?yTlAkk0gOHsAQnwFQ7uoFBCeAApl54j2yNDNdVpOAqvAszObFilwM9ndnP?=
 =?iso-8859-1?Q?qtm8o5YZAJZuH8G6/3M3BOm8+lpg004gOHC3juaptLw2LU5JUE1V4gAATD?=
 =?iso-8859-1?Q?mLE3DMeM1tK1rthk5x6PlxSwgaPY2gz8Auu5S8pQXbScCPhZ18A8VzS1eC?=
 =?iso-8859-1?Q?TKHBYTzN/M+g1rL3/E8wW+UFpVuyXTArpvbVNX+h0d8kPwidsG7DXEgDCo?=
 =?iso-8859-1?Q?ro+QQ+4Cx7DpwIvbu2en6YVPYh2teDS3B65MN9/CcGraw/iadlpbQqeZHB?=
 =?iso-8859-1?Q?VoYydf1HGN3UoZ4OeHluEQmPBVb5fVIgBacf4V4//MgJsc8Y/3TRlpGk0Q?=
 =?iso-8859-1?Q?JNjn+nJZYU2ZrSJVxM6Xo3C1SPZ+W2czjBUrDCUpFJAC4KZEnKXRiNrb2/?=
 =?iso-8859-1?Q?B0126pCrM2HSIdmIElUkeP56SDriRIEz86dI0tbsqNw+ogf6FsiFQJecFk?=
 =?iso-8859-1?Q?GG4Rb6JS9oL0glgoCejYnZQfkyZMevXs+Crm+H1c80CGr375mSewCEZYKL?=
 =?iso-8859-1?Q?5qkg7XT/61GYeIV+ehA/OWY71KD83WClj5j+MNu5qW7lcvufoqQSQoUMtS?=
 =?iso-8859-1?Q?vHCDKxuWV+lXqOlWMaTT7/8SgDYb+L44md5swTSoTpGVEzxgW1fo/Ydujy?=
 =?iso-8859-1?Q?0l5FeQKEg/uugkashWHDrRQfjE9OL9Jb+VYFi5heeePC4yWgon7T5x1eW3?=
 =?iso-8859-1?Q?E66eDs6Sab551O/37WGH3ZrVSG5lQngOVEa0bgMxVX+S4KqyyM8vAY0Fwf?=
 =?iso-8859-1?Q?2sURwS9e038Y/HpxQ3dGF1Ye8GevmIpUkfzjxcRsi7yZ+5kDQ9X3uT6rg9?=
 =?iso-8859-1?Q?FY/Z0iiDeTGf5Ul1c44nqDlcnejTm4T82DDTkWgeSoXUZkXBnY5wQJWUPu?=
 =?iso-8859-1?Q?JpEyzs1NYr6QF++aXZSspvXkJ0SGeqhMtzPsakUg5Oynib1KaIWWBUgehC?=
 =?iso-8859-1?Q?vv1UG1E95nNVU9f/73OudALC4gXYMYeTqa7Z1byN9bRz0tK6tpzdP9+NoF?=
 =?iso-8859-1?Q?31x9GUAzpKZ6AuW/dRvQs+uLeUsqeth/jS5B8ULLl0waYG3oV77wn6IE3c?=
 =?iso-8859-1?Q?uFWnXflyYGttkpfQMcKOkKH2fdN3Eik1nXXRIhl7Xs7df8b+/AjMA36Gd9?=
 =?iso-8859-1?Q?Qq3Or1fEKgtfMpfAntaNvNO85RTGWvJpeq0TaBtK8pkcD/lcIpwIwIEmN5?=
 =?iso-8859-1?Q?szZjt0o1tvpCsVWzh32954n5+MXMaKdPkrLgcaEz2uwlm5iIFPWjnGxZjG?=
 =?iso-8859-1?Q?drhuDUNdvdrCH2daARCB82XKcJOkGIpU9qGgovVmaa2ggQdLU6hDO0DozJ?=
 =?iso-8859-1?Q?/mjsjTo+OX406MLILjxuIqrnlLrQZUKjH3Ux8jtWiNsXWQYr936yOoTU3L?=
 =?iso-8859-1?Q?Zuoict5s1BMobg+V6Gi3x8XXtagQYOKHzHcaJ0kHQAKMDCKwY1JrFnCEJY?=
 =?iso-8859-1?Q?+7e2Rap5CYXx25L3nZdAhRuwMAo8ZbVB5mSVXnfujotYHEts8x3uwmoGGH?=
 =?iso-8859-1?Q?vgRS/4E7RGkMl7S0Xmr3TSw0NOlRK0qUEjjUOGFJru+u8FFf7JYttM3N0z?=
 =?iso-8859-1?Q?l33gxbLC5A=3D=3D?=
X-Exchange-RoutingPolicyChecked: F8i78Hek45HDV3Uq8KDizQ6kjwcHaarxy1NIGJZN2dY9rXSQuH76NGzT0yLp0C2CuCIgUpDP7+ZRZTLgbRrB3HAaiGEehmbWkvD0pm3V6VtHIK5pjWadD+voHkrewWjA09qi0+LWNS7rCiuC5ykSo4x0tmdDFLB7lC5N2JGtZEaQfTv2Fx3ktTadYy/crqxWN2IiRhY9UaFIizuLQpuS2bsj9hEtx12hmILvBG9U0xbhSjkSbk/tm7duPLuM89ON7dhGen2y4p6UiVwqIgQeiwu9dAzOKwjJdstg4JOFkr6bny2+YRImMC9mIyHJc6/KE/JFnunek+gqCoHDbTrRRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f4acd9-550a-4452-8565-08de88002b6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 10:45:44.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqu4JEdtUtJUy9IAcHnOGnHeVUKfXDp0x1IfperFGGeelz8YjRHZbVjwYm4q4t/tnas8zjhWFcGznkFbIq5VVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14982-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,average.ms:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AE1822E8DB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hello,

kernel test robot noticed a 48.3% improvement of stress-ng.mremap.ops_per_sec on:


commit: 4616120fca7f6d48b4c640e3975352e451e9c2ce ("cgroup: add lockless fast-path checks to cgroup_file_notify()")
https://git.kernel.org/cgit/linux/kernel/git/tj/cgroup.git for-7.1


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: mremap
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260322/202603221824.c32929f7-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp2/mremap/stress-ng/60s

commit: 
  05070cd654 ("cgroup: reduce cgroup_file_kn_lock hold time in cgroup_file_notify()")
  4616120fca ("cgroup: add lockless fast-path checks to cgroup_file_notify()")

05070cd654f38346 4616120fca7f6d48b4c640e3975 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    670909 ±  2%     +48.3%     995054        stress-ng.mremap.ops
     11186 ±  2%     +48.3%      16595        stress-ng.mremap.ops_per_sec
     11269            -1.6%      11094        stress-ng.time.system_time
    181.60           +72.7%     313.62 ±  7%  stress-ng.time.user_time
      2870 ±  9%     +55.4%       4461 ± 18%  perf-c2c.DRAM.local
    349.27            +3.4%     361.27        turbostat.PkgWatt
    400595            +1.6%     407116        vmstat.system.in
      0.11            +0.1        0.18 ± 24%  mpstat.cpu.all.irq%
      0.06 ±  7%      +0.3        0.33 ± 37%  mpstat.cpu.all.soft%
      1.86            +1.1        2.98 ±  6%  mpstat.cpu.all.usr%
  19725586 ±  4%     +13.1%   22316349 ±  4%  perf-stat.i.branch-misses
 5.641e+08 ±  4%    +113.7%  1.206e+09 ± 19%  perf-stat.i.cache-references
  19314576           +15.6%   22334802 ±  2%  perf-stat.ps.branch-misses
 5.495e+08 ±  4%    +112.9%   1.17e+09 ± 19%  perf-stat.ps.cache-references
      0.02 ± 31%     -85.9%       0.00 ±223%  perf-stat.ps.major-faults
      0.44 ±  7%     +35.0%       0.60 ± 15%  perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.44 ±  7%     +35.0%       0.60 ± 15%  perf-sched.total_sch_delay.average.ms
    174.61            +7.1%     186.97 ±  4%  perf-sched.total_wait_and_delay.average.ms
    174.16            +7.0%     186.37 ±  4%  perf-sched.total_wait_time.average.ms
    174.61            +7.1%     186.97 ±  4%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    174.16            +7.0%     186.37 ±  4%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     92.34           -92.3        0.00        perf-profile.calltrace.cycles-pp.__mem_cgroup_try_charge_swap.folio_alloc_swap.shrink_folio_list.reclaim_folio_list.reclaim_pages
     92.34           -92.3        0.00        perf-profile.calltrace.cycles-pp.__memcg_memory_event.__mem_cgroup_try_charge_swap.folio_alloc_swap.shrink_folio_list.reclaim_folio_list
     92.03           -92.0        0.00        perf-profile.calltrace.cycles-pp.cgroup_file_notify.__memcg_memory_event.__mem_cgroup_try_charge_swap.folio_alloc_swap.shrink_folio_list
     92.02           -92.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.cgroup_file_notify.__memcg_memory_event.__mem_cgroup_try_charge_swap.folio_alloc_swap
     91.94           -91.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.cgroup_file_notify.__memcg_memory_event.__mem_cgroup_try_charge_swap
     92.62           -48.5       44.08 ± 77%  perf-profile.calltrace.cycles-pp.shrink_folio_list.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range
     92.51           -48.5       44.00 ± 77%  perf-profile.calltrace.cycles-pp.folio_alloc_swap.shrink_folio_list.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range
     92.71           -47.8       44.90 ± 74%  perf-profile.calltrace.cycles-pp.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range
     92.72           -47.8       44.92 ± 74%  perf-profile.calltrace.cycles-pp.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range
     93.60           -23.2       70.43 ± 22%  perf-profile.calltrace.cycles-pp.__walk_page_range.walk_page_range_vma_unsafe.madvise_pageout.madvise_vma_behavior.madvise_do_behavior
     93.60           -23.2       70.43 ± 22%  perf-profile.calltrace.cycles-pp.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range_vma_unsafe.madvise_pageout
     93.60           -23.2       70.43 ± 22%  perf-profile.calltrace.cycles-pp.walk_page_range_vma_unsafe.madvise_pageout.madvise_vma_behavior.madvise_do_behavior.do_madvise
     93.60           -23.2       70.43 ± 22%  perf-profile.calltrace.cycles-pp.walk_pgd_range.__walk_page_range.walk_page_range_vma_unsafe.madvise_pageout.madvise_vma_behavior
     93.61           -23.0       70.61 ± 22%  perf-profile.calltrace.cycles-pp.madvise_pageout.madvise_vma_behavior.madvise_do_behavior.do_madvise.__x64_sys_madvise
     93.73           -22.4       71.38 ± 21%  perf-profile.calltrace.cycles-pp.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range
     93.73           -22.4       71.38 ± 21%  perf-profile.calltrace.cycles-pp.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range
     93.73           -22.4       71.38 ± 21%  perf-profile.calltrace.cycles-pp.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range_vma_unsafe
     93.91           -21.8       72.07 ± 20%  perf-profile.calltrace.cycles-pp.madvise_vma_behavior.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     94.15           -20.9       73.21 ± 19%  perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     94.14           -20.9       73.20 ± 19%  perf-profile.calltrace.cycles-pp.madvise_do_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     94.15           -20.9       73.21 ± 19%  perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     94.15           -20.9       73.21 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     94.15           -20.9       73.22 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     94.16           -20.9       73.23 ± 19%  perf-profile.calltrace.cycles-pp.__madvise
      0.69 ±  3%      +0.4        1.13 ±  9%  perf-profile.calltrace.cycles-pp.stress_mmap_check
      0.00            +0.5        0.53 ±  3%  perf-profile.calltrace.cycles-pp.move_vma.do_mremap.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ±  5%      +0.7        1.39 ± 18%  perf-profile.calltrace.cycles-pp.stress_mmap_set
      0.00           +43.5       43.45 ± 77%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.folio_alloc_swap.shrink_folio_list.reclaim_folio_list
      0.00           +43.8       43.76 ± 77%  perf-profile.calltrace.cycles-pp._raw_spin_lock.folio_alloc_swap.shrink_folio_list.reclaim_folio_list.reclaim_pages
     92.34           -92.1        0.23 ± 50%  perf-profile.children.cycles-pp.__memcg_memory_event
     92.34           -92.1        0.24 ± 49%  perf-profile.children.cycles-pp.__mem_cgroup_try_charge_swap
     92.04           -92.0        0.00        perf-profile.children.cycles-pp.cgroup_file_notify
     93.22           -71.6       21.58 ± 68%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     92.62           -48.5       44.08 ± 77%  perf-profile.children.cycles-pp.shrink_folio_list
     92.51           -48.5       44.00 ± 77%  perf-profile.children.cycles-pp.folio_alloc_swap
     92.71           -47.8       44.90 ± 74%  perf-profile.children.cycles-pp.reclaim_folio_list
     92.72           -47.8       44.92 ± 74%  perf-profile.children.cycles-pp.reclaim_pages
     93.61           -23.0       70.61 ± 22%  perf-profile.children.cycles-pp.madvise_pageout
     93.86           -22.3       71.51 ± 21%  perf-profile.children.cycles-pp.madvise_cold_or_pageout_pte_range
     93.90           -22.3       71.59 ± 21%  perf-profile.children.cycles-pp.walk_pud_range
     93.90           -22.3       71.60 ± 21%  perf-profile.children.cycles-pp.walk_p4d_range
     93.90           -22.3       71.59 ± 21%  perf-profile.children.cycles-pp.walk_pmd_range
     93.90           -22.3       71.60 ± 21%  perf-profile.children.cycles-pp.__walk_page_range
     93.90           -22.3       71.60 ± 21%  perf-profile.children.cycles-pp.walk_pgd_range
     93.90           -22.3       71.60 ± 21%  perf-profile.children.cycles-pp.walk_page_range_vma_unsafe
     93.91           -21.8       72.07 ± 20%  perf-profile.children.cycles-pp.madvise_vma_behavior
     94.15           -20.9       73.21 ± 19%  perf-profile.children.cycles-pp.do_madvise
     94.14           -20.9       73.20 ± 19%  perf-profile.children.cycles-pp.madvise_do_behavior
     94.15           -20.9       73.21 ± 19%  perf-profile.children.cycles-pp.__x64_sys_madvise
     94.16           -20.9       73.23 ± 19%  perf-profile.children.cycles-pp.__madvise
     93.81            -3.8       90.06        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     98.15            -1.2       96.99        perf-profile.children.cycles-pp.do_syscall_64
     98.15            -1.2       97.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ± 14%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.free_unref_folios
      0.06            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.05            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__pi_memcpy
      0.05            +0.0        0.09 ± 22%  perf-profile.children.cycles-pp.update_process_times
      0.07            +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.mas_store_gfp
      0.14 ± 12%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.move_ptes
      0.06            +0.0        0.11 ± 22%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.05            +0.1        0.10 ± 26%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.sched_tick
      0.03 ± 70%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.vma_link
      0.16 ± 12%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.move_page_tables
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.unmapped_area_topdown
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.06            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__mmap_new_vma
      0.08            +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.copy_vma
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.09 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.08 ±  6%      +0.1        0.16 ± 28%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.06            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.mas_preallocate
      0.08            +0.1        0.17 ± 26%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.07 ±  6%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.13 ±  2%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__mmap_region
      0.00            +0.1        0.11 ±  5%  perf-profile.children.cycles-pp.__refill_objects_node
      0.01 ±223%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__pcs_replace_empty_main
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.refill_objects
      0.16 ±  3%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.do_mmap
      0.24 ±  8%      +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.copy_vma_and_data
      0.35 ±  3%      +0.2        0.54 ±  3%  perf-profile.children.cycles-pp.move_vma
      0.05 ±  7%      +0.3        0.32 ± 44%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.05            +0.3        0.32 ± 43%  perf-profile.children.cycles-pp.handle_softirqs
      0.00            +0.3        0.27 ± 53%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.3        0.28 ± 50%  perf-profile.children.cycles-pp.__kmem_cache_free_bulk
      0.00            +0.3        0.29 ± 49%  perf-profile.children.cycles-pp.rcu_free_sheaf
      0.00            +0.3        0.31 ± 44%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.3        0.31 ± 43%  perf-profile.children.cycles-pp.rcu_core
      0.20 ± 25%      +0.3        0.54 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.14 ±  2%      +0.3        0.49 ± 19%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.69 ±  3%      +0.4        1.13 ±  9%  perf-profile.children.cycles-pp.stress_mmap_check
      0.77 ±  8%      +0.7        1.42 ± 15%  perf-profile.children.cycles-pp.stress_mmap_set
      0.19 ±  7%      +0.7        0.89 ± 51%  perf-profile.children.cycles-pp.__vm_munmap
      0.19 ±  7%      +0.7        0.89 ± 51%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.21 ±  8%      +0.7        0.92 ± 49%  perf-profile.children.cycles-pp.__munmap
      0.22 ±  7%      +0.9        1.12 ± 53%  perf-profile.children.cycles-pp.faultin_page_range
      0.28 ± 88%      +1.0        1.28 ± 47%  perf-profile.children.cycles-pp.madvise_cold
      0.25 ± 13%     +43.6       43.88 ± 76%  perf-profile.children.cycles-pp._raw_spin_lock
     93.81            -3.9       89.93        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.12 ± 13%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.05            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__pi_memcpy
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.move_ptes
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__refill_objects_node
      0.19 ± 12%      +0.2        0.41 ± 31%  perf-profile.self.cycles-pp._raw_spin_lock
      0.69 ±  3%      +0.4        1.12 ±  9%  perf-profile.self.cycles-pp.stress_mmap_check
      0.68 ± 11%      +0.6        1.32 ± 27%  perf-profile.self.cycles-pp.stress_mmap_set




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


