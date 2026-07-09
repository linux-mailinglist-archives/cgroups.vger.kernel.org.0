Return-Path: <cgroups+bounces-17591-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MIL3N741T2qpcAIAu9opvQ
	(envelope-from <cgroups+bounces-17591-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 07:46:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84272CDB7
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 07:46:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=mF5f1xVI;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17591-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17591-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE628301AD3A
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 05:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C83A9616;
	Thu,  9 Jul 2026 05:44:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255B43932C;
	Thu,  9 Jul 2026 05:44:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575887; cv=fail; b=ge6RQMpcsQ4Cy3feVXaH5nEClfa8yPvhj1oE52YxmcyY/0WxN6sZOrQpxPsivBZl3bm+ULyprfScHOe9SZETrn6PeBMJB0UY+D01M5NUGPkW1h5OoJFojhyJCqPSkMc/jR7Dx7QgBH7PN8R48CWkeJgKZrH/vvQju60l6bLH7yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575887; c=relaxed/simple;
	bh=AKE1LSXkXGoH4+/3gkqQMPcOBCz86YZ5xM9Zq2bGaBg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nqq4jDJ3D/nJ0oX1/uiPWABSMNZjHORGbdqSrA6vJEzTXJHv/Jlu39SFRGyatcYw5bp+eKkKMMMdLGNiwzY8J8xmfA/rMXubvOnLKd0GhlgJh2ipjgRaeJUuFdbTru11BbvJ87uBAoZzeG3LWFPOd4pwto7EBGUZWNfO4eTPs4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mF5f1xVI; arc=fail smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783575884; x=1815111884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AKE1LSXkXGoH4+/3gkqQMPcOBCz86YZ5xM9Zq2bGaBg=;
  b=mF5f1xVI8DKXcdSIYUUQvBpsc8CAMSMie2eK6SnG/duohL1qYGuLSRB8
   5AWug9Ss14nULCFm7HResT6a+X954xb/GaLAENJvffFeBiAg1AcU776jv
   m3EDM0/cNr4uwLu8PL5m0iQgtAQ5nCs7UFCsKJSMUnNq+6E6IXaDnPxpS
   ZDWeguZHgme2c5sXQZHt2KRXQMGW//xsLQBS7IwhE6dR+NuCGrjCrA0U1
   MUQCPPNDj5Ftw3Va9oOd81ApFh0IGPPqv425MR2KcqT7o+UeD5f7dqFjO
   BCNXTuvHZT/UN+4mZsibn4HwZxZwf1wlhixJLkuuIKVuscrLFWBk3I9VD
   g==;
X-CSE-ConnectionGUID: o9TlYCigR5eqeHv4f2X5Ew==
X-CSE-MsgGUID: zJljlT0USSaMcG9j4Z8q9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84301234"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84301234"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 22:44:43 -0700
X-CSE-ConnectionGUID: FMyiyKPNT8aXgAbMylsPEQ==
X-CSE-MsgGUID: Ldc4c1kuSb6Rt6vDfg5uTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250500723"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 22:44:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 22:44:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 22:44:42 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 22:44:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+2JsGTy69Hs7Kesi2D8o2xwgTLyoKKs1sJN4pTwlHK9gUy3spxOwPP1KpmCQqigveji7ogFtMNnCvgOGOd9de87MS2eQwB/YQzkJMov5mw3kG0CERE1zNdTAL/HlBhozZBA1d4HcrZ8AcjPMrD+GGIAqLJjCFtCNKhRYYQjPgIPch6rFgbY9qR+34YWEoIcDQ7pN1OJ9UMWDm6j2GPCGwWyUd0MQcGOgz0Chl0c8Sga8TNYSgy0BtmhV0a+94GhKF4zFLwO+32XChkjqzPW4JYLzFu6kOCRlCtZoxPop++P5djMhAON1dVjhu2LxVtmnfU1m9ceAfSHOp+ibvWhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeBuCxKGp+MgBJASYbOS2aS70dSFoh37KLx5zr6ER+w=;
 b=SdpDmuMXl66x0k3sfpRwxhDkHZ04V+Y3cBG9Xy/ET9wj9YYxUDmqGPhtSg/xF7CpGp2H/pGp1CXf18pBw8KigVOAHz+ykDkuBcshWKG31NeIdBp9+n2KtG4vfynpRU9BO3CbQXquQT7P4ENxUirZ7YoCaexgVXiKbAFRc/fyNLnZA0H2GaP5X+vd6D7IUwF7SWJr2dUzVtVAArKjswzkKDr27TF95Rc7AuI2insRA7wkDc4U1UN8O6f76OpBtHJcNbwQOvNX4i2ewduJqUeOgOvyIx5NkhP/exrxQ0pyaiaNk1b/QTTnPFtv+ZZdaQIRaX6fiGF8AlA7kyuNYOtaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS4PPF11A2D5672.namprd11.prod.outlook.com (2603:10b6:f:fc02::b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:44:40 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 05:44:39 +0000
Date: Wed, 8 Jul 2026 22:44:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Qiliang Yuan <realwujing@gmail.com>
CC: Christian Koenig <christian.koenig@amd.com>, Huang Rui
	<ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Tejun Heo <tj@kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Natalie Vock <natalie.vock@gmx.de>, Michal Hocko <mhocko@kernel.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, Qiliang Yuan <yuanql9@chinatelecom.cn>,
	<thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v7] cgroup/dmem: implement dmem.high soft limit with
 proactive reclaim
Message-ID: <ak81RUK6vRZaMN2D@gsse-cloud1.jf.intel.com>
References: <20260709-feature-dmem-high-v7-1-de559e7e7768@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709-feature-dmem-high-v7-1-de559e7e7768@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS4PPF11A2D5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a64ea7-e3b8-4826-39cf-08dedd7d2b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|6133799003|7136999003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: gMuiSEpQq5ypBZqe+Ehe+nL5kyCJBmH7nQWE+XgQcrmgVxKDoiXOic8KzNOGoqOP0UNdNCg+m68rW922gjOkDAfMbT1cetepKoPdlyyM+VagCPEg/rcN2ROgToq9dGxe7lSuU4Jzm0xp9efCOCmODk4V2XIOglpmtsUcz/JYAJPYMaWIWMkC9v9WnlpzrcqG/8tTYEW4XUPsLVGWUzGEIdMKqOtnGvAyO5o+m7DLuFD3aX8+LLnYWtDlGk/ANsUqIP3SVioj/tPOeae7S8TVAsxLYaXwH01udcIlD9JjY6Imbx4qy3ryPVYKtT+1QzB32WZHe6DiZKidgbvhb5LFGbA/Y+HZvNR/wfr/2ouuab6z/LbqQN8ks4U+kqyfUlFcAerDRmx2sfdqBkRFXv14b8m0q3qxJszPkvhmb0j2SHGu4TcqogSP5XQAfXHTt92o4YEu3sNLFmck7hLeJhEh0c1Md96FPUJ14A+eB7I9nbS4jrFRicYXKxvoZ8V+sZQ38PqkFnpomztZ5TAt2ocpUmnaMaiEbXSmuTvf9aBDIIwELyVGg05wXTJFYlvte3RwffL6UwUxbOs+LBS7KyCRbaxstaYA+iMVDXK8vYzEBUfz74OEhmHp7jgc3w2+mnly
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(6133799003)(7136999003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUpVeHcXU7ZDa9peUoABe6+/zRkKnr/NqaUHc3Omr6etzf1q9DKzSrzMnerM?=
 =?us-ascii?Q?AWAzKaW/qtOfHwJtpevC696q0PA1/vlZ5IaVYY0mP2xXVtNbJQ83FsVwZAUY?=
 =?us-ascii?Q?0xde3s1tJFTio6kByWWNfn0OpvKEhVPWDV9fIEYyYGDBKaJiy2LikUeCWIqq?=
 =?us-ascii?Q?Ponz6Mt0DDBY6KmxQzbsBtEuzAbZO2WpL9fuGWtkCkLpgIoyeoIykjhMm9cz?=
 =?us-ascii?Q?cJPqzbO2KPrTyPlKQNEkOZHZc4fus8UEFrGlu0SbHXCU3Of8EW05wJxywOGE?=
 =?us-ascii?Q?oWQclUNZhhlFSahAKo76bkwOPCueZE38uvZDfaTAFO6/4yD09tjPDolvB2Vn?=
 =?us-ascii?Q?kHBSKfTG8GFQxW/W9s4HPn0WNqMK36XBmT0ZVgoNe0Xtv/OfEbQ0xZaS0Eii?=
 =?us-ascii?Q?OU67dH8cLwyFJ6eFM/ewBT8x4WfHyErYRPKBKZ8kimJUj48rh6mq0DSvDsp1?=
 =?us-ascii?Q?kHlu4s9hDZZjnyI+77ePhAzol7ASX4wiyPn+Ee08mufy9DEAxjN18MEQmimH?=
 =?us-ascii?Q?1bQeETiaJnVg3z1AAGrBu5kSOph2//1H+um08WCfo0bQLLGj0ot0Uti3BXGd?=
 =?us-ascii?Q?EAVo+6z71O4dlsP6iyr/dul7yHtoLeZKc9k0Vsthxu5cUUZh5M+uOtU8/don?=
 =?us-ascii?Q?Og3wEJqWn9rwuO4XcvBe+y0KtOwNRZvO5bMUzF2SSp2zIu8Ptj527xI/zxlG?=
 =?us-ascii?Q?xl1C4KgVri5xi8zw8P75QVZdMStQT7P8a5G0ibXhUM+5SEY7Y6cg/ZtxcT95?=
 =?us-ascii?Q?Fdv4qE/VvrwaiGozO32WkaIY1ntmFva4KFYczRu2LtGQyk0V/IJ4cGJO8gvk?=
 =?us-ascii?Q?yQaA2w1+Idmu/ry6IXCeQFxf9WaaCzPn7fRUBg23+h6vifFV+oI/o3B0akqO?=
 =?us-ascii?Q?CaUSNYtECd55nJ5yg621jRceOk7RezHLaw9jd0PPxpiHBjI4jY9bSPfrfqb2?=
 =?us-ascii?Q?B93nxUd33esnt6JQZEIM9inlposkqzUkmSpHSk1DFM41o2/wjVyn1a3A64IN?=
 =?us-ascii?Q?jopj0vl9ay9ldv9ikLavnUw58Wc3CDmdueNMopFH1JgsjE1GuNZrUY7qC9mu?=
 =?us-ascii?Q?f117/aW0+dF0LXdwKqCjARLTFOez4fU7InG2fA8N7Kr7ZSVMf6F1YHdcJGMu?=
 =?us-ascii?Q?ktZ7FeIEduf8e9x8qyfipvkqeXVnXlayh/+0w6otYcZFhLUrenwv4M3dqu0p?=
 =?us-ascii?Q?EAGF2fidVnU0NQ+/LHR5hbH73pYBmXbLZa8AIW4WSfkpORyNAB7TJAlLBsrG?=
 =?us-ascii?Q?ZmiWZhtwIiH2fa/f1Ds852HcuWMiMjRoM91jvUmHKO7gYiSV+xauIaWf6lXK?=
 =?us-ascii?Q?UjDRKT7yy7aAKVBbeO1rw74D7Zlt9Il9QX3+JSGsSOOSVOW7vvHY6znj1cUn?=
 =?us-ascii?Q?njLVCQEwinCBMsuhICIQPE6RCsK4saOHrXcuCgzVXjXMpRdXIZX0LUi15QLu?=
 =?us-ascii?Q?yq06EagGNtpe9itsaMlbRqusv6dFLLnSNcTlZcMX2aRZz9QmwiI0lTABvj9x?=
 =?us-ascii?Q?xu/MzfALLjM2VmVMEoCaZhGqYeHltdX2mlN1rj4/8ZfG5tG0oGMK6br04G82?=
 =?us-ascii?Q?ko7eNUniN0M/pMdNGoA0FxRUD5LJnvQjAwzqdA37mU9Q/VH3VRCpD5+C0ETV?=
 =?us-ascii?Q?/y2vSdtoJizvR8RQt96/N9BUr9NYi9nsBfZal23wxcUvGUirrd7ZC+77m5HK?=
 =?us-ascii?Q?cmGTb1/EcWy9NPqb4re2VHrGV3Rj3pZCg7P1OYy7a1tTp7lED+2Lx93N/5am?=
 =?us-ascii?Q?Ei7FlcIdCg=3D=3D?=
X-Exchange-RoutingPolicyChecked: QL0jx4CB5i9zU+uQm8WRUNUWUJBITIsREMTt+5awBeDxBAx7geKOxabm10qHxKGdBCpEL33TX1Soc6IMuyBuiiZI32oNSuHHLim0W9QpFKouOupvac7AvbEiWLNCG19SypH/uJzB4/u11K98644kGeZgRn5t3zuqBwPWw+0ia3XdSGxtOxvTNZ2Jf8NzXQX9+Qgo1ALKMAkCHd64IGMceQIaV9lWogoUmiFRdSRdM0Zerp/UJUlG/iwnNgYApw/e+9nPCK7X9GG0VI/BppgXeV0SmXoP0ZoU89qu+txo4hA697T83i7V/5UAGZ4hu3P+R7LZ9fbVJcBRjR/J+mlKlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a64ea7-e3b8-4826-39cf-08dedd7d2b26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:44:39.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLNjwtx+CTkCiTBe1Uc5BMbKypo+Hq1tYQjPIxNGxsfPJX/9o7ezza8nqUXMK2wgFSbF/JeilwoJMVVuBeGrOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF11A2D5672
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:realwujing@gmail.com,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:natalie.vock@gmx.de,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:yuanql9@chinatelecom.cn,m:thomas.hellstrom@linux.intel.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17591-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp,chinatelecom.cn:email,gsse-cloud1.jf.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,patchwork.freedesktop.org:url];
	FORGED_SENDER(0.00)[matthew.brost@intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,cmpxchg.org,suse.com,gmx.de,linux.dev,lists.freedesktop.org,vger.kernel.org,kvack.org,chinatelecom.cn];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E84272CDB7

On Thu, Jul 09, 2026 at 12:02:00PM +0800, Qiliang Yuan wrote:

+Thomas

This looks quite similar to work Thomas is doing here [1].

Are either of you two aware of this seemly overlapping work?

Matt

[1] https://patchwork.freedesktop.org/series/163970/

> The dmem cgroup v2 controller currently only provides a hard "max"
> limit, which causes immediate allocation failures when a cgroup's
> device memory usage reaches its quota.  GPU-bound AI workloads need
> smoother over-subscription support: a soft limit that provides
> backpressure through reclaim before the hard limit is reached.
> 
> Implement dmem.high as a proper soft limit following the memory.high
> semantics: the limit is checked in the charge path on every successful
> allocation, and proactive reclaim is triggered when usage crosses the
> threshold, rather than waiting for a dmem.max hit to drive eviction.
> 
> Expose "high" as a new cgroupfs control file per region via
> set_resource_high() and get_resource_high(), initialized to
> PAGE_COUNTER_MAX in reset_all_resource_limits().  Like get_resource_max(),
> get_resource_high() returns PAGE_COUNTER_MAX when the pool is NULL.
> 
> Extend dmem_cgroup_try_charge() with a ret_over_high_pool output
> parameter.  On a successful charge, if the pool's usage now exceeds its
> dmem.high threshold, ret_over_high_pool is set so the caller can
> trigger proactive reclaim.  Propagate this signal through
> ttm_resource_alloc() up to ttm_bo_alloc_resource().
> 
> Add ttm_bo_proactive_evict_high() in TTM, which walks the LRU and
> evicts one BO from the over-limit cgroup (using the existing try_high
> logic in dmem_cgroup_state_evict_valuable()).  This is best-effort:
> the allocation already succeeded since dmem.high is a soft limit.
> A blocking lock is used when a ww_acquire_ctx ticket is available,
> trylock otherwise.
> 
> Remove the try_high first pass from ttm_bo_evict_alloc(): that pass
> tied the interface semantics to a specific eviction ordering detail
> rather than a proper soft limit.  Proactive reclaim in the charge
> path is the correct place to enforce the soft limit.
> 
> Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Signed-off-by: Jing Wu <realwujing@gmail.com>
> ---
> Implement dmem.high as a proper soft limit for the dmem cgroup v2
> controller, following memory.high semantics: the limit is checked in
> the charge path on every successful allocation, and proactive reclaim
> is triggered when usage crosses the threshold.
> 
> The dmem cgroup currently only supports a hard "max" limit, which causes
> allocation failures for GPU-bound workloads.  A soft limit enables
> smoother over-subscription by providing backpressure through reclaim
> before the hard limit is reached.
> 
> The implementation extends dmem_cgroup_try_charge() with a
> ret_over_high_pool output parameter that signals callers when a
> successful charge pushes usage above the dmem.high threshold.
> ttm_resource_alloc() propagates this signal up to
> ttm_bo_alloc_resource(), where ttm_bo_proactive_evict_high() evicts
> one BO from the over-limit cgroup on a best-effort basis.
> ---
> V6 -> V7:
> - Replace prioritized eviction (eviction-time ordering) with proactive
>   reclaim (charge-time enforcement): dmem.high is now checked in
>   dmem_cgroup_try_charge() on every successful allocation, matching
>   memory.high semantics as requested by Tejun Heo.
> - Add ret_over_high_pool output parameter to dmem_cgroup_try_charge()
>   to signal callers when a successful charge crosses the high threshold.
> - Add ttm_bo_proactive_evict_high() to evict one BO from the over-limit
>   cgroup on each allocation that crosses dmem.high (best-effort; the
>   allocation already succeeded since dmem.high is a soft limit).
> - Remove the try_high first pass from ttm_bo_evict_alloc(): the high
>   limit is no longer enforced via eviction ordering in the max path.
> - Propagate ret_over_high_pool through ttm_resource_alloc() and update
>   all callers (including TTM test files) to pass the new parameter.
> - Add Michal Hocko, Roman Gushchin, Shakeel Butt, Muchun Song to Cc
>   per Tejun's request for memcg input on soft limit semantics.
> 
> V5 -> V6:
> - Guard the try_high dereference of test_pool->cnt with a NULL check
>   to prevent a kernel panic during global memory pressure eviction
>   when a BO has no associated cgroup.
> - Make the disabled-cgroup stub for dmem_cgroup_state_evict_valuable()
>   return false in try_high mode so the stub does not incorrectly
>   enable Pass 1 when CONFIG_CGROUP_DMEM=n.
> 
> V4 -> V5:
> - Restore the original control flow in dmem_cgroup_state_evict_valuable():
>   test_pool is no longer dereferenced before the ancestry checks, fixing
>   a NULL pointer dereference on BOs without a cgroup.  The limit_pool
>   NULL-to-root-cgroup resolution is now performed before the try_high
>   block, fixing a panic during global memory pressure eviction.
> - Keep the try_high check for limit_pool == test_pool inside the existing
>   early-return branch to avoid bypassing the hierarchy constraint check
>   that prevents cross-cgroup eviction.
> - Use a blocking lock in Pass 1 only when a ticket is available
>   (trylock otherwise), addressing the deadlock risk of blocking without
>   a valid ww_acquire_ctx.
> - Explicitly reset trylock_only to true before Pass 2 so it does not
>   inherit Pass 1's blocking behavior.
> 
> V3 -> V4:
> - Use a blocking lock in Pass 1 instead of trylock to ensure
>   over-limit cgroups are penalized even when their BOs are actively
>   in use, as requested by Maarten Lankhorst.
> - Evaluate the try_high condition before the limit_pool == test_pool
>   early-return so that the limit-hitting cgroup's own BOs are also
>   filtered by dmem.high.
> - Remove the high-priority compensation retry at the start of Pass 3,
>   which is no longer needed now that Pass 1 uses a blocking lock.
> 
> V2 -> V3:
> - Walk the page_counter parent chain in the try_high pass to prevent
>   child cgroups from evading the penalty when a parent cgroup exceeds
>   its dmem.high limit.
> - Check dmem.min protection in the try_high pass to avoid evicting
>   BOs below the effective minimum.
> - Add a properly-locked high-priority retry at the beginning of Pass 3
>   so that actively-used over-limit BOs (which failed trylock in Pass 1)
>   are not skipped while innocent cgroups are evicted.
> - Fix get_resource_high(NULL) returning 0 instead of PAGE_COUNTER_MAX
>   to match the behavior of get_resource_max().
> 
> V1 -> V2:
> - Replace sleep-on-allocation throttling with prioritized eviction.
> - Remove task throttling entirely.
> - Add dmem.high cgroupfs control file per region.
> - Extend dmem_cgroup_state_evict_valuable() with try_high parameter.
> - Refactor ttm_bo_evict_alloc() into a 3-pass eviction strategy.
> - Initialize high to PAGE_COUNTER_MAX in reset_all_resource_limits().
> 
> v6: https://lore.kernel.org/r/20260531-feature-dmem-high-v6-1-20563ecd6dc7@gmail.com
> v5: https://lore.kernel.org/r/20260531-feature-dmem-high-v5-1-1c6c532b26a9@gmail.com
> v4: https://lore.kernel.org/r/20260530-feature-dmem-high-v4-1-ee7c6ec1c8da@gmail.com
> v3: https://lore.kernel.org/r/20260528-feature-dmem-high-v3-1-c642b34bcb2f@gmail.com
> v2: https://lore.kernel.org/r/20260522-feature-dmem-high-v2-1-1d7d4a0fa5da@gmail.com
> v1: https://lore.kernel.org/all/20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com
> ---
>  drivers/gpu/drm/ttm/tests/ttm_bo_test.c          |  18 ++--
>  drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |   4 +-
>  drivers/gpu/drm/ttm/tests/ttm_resource_test.c    |   2 +-
>  drivers/gpu/drm/ttm/ttm_bo.c                     |  60 ++++++++++---
>  drivers/gpu/drm/ttm/ttm_resource.c               |   8 +-
>  include/drm/ttm/ttm_resource.h                   |   3 +-
>  include/linux/cgroup_dmem.h                      |  15 +++-
>  kernel/cgroup/dmem.c                             | 104 +++++++++++++++++++++--
>  8 files changed, 179 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> index f3103307b5df9..7a03f6a04f4e8 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> @@ -258,13 +258,13 @@ static void ttm_bo_unreserve_basic(struct kunit *test)
>  	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
>  	bo->priority = bo_prio;
>  
> -	err = ttm_resource_alloc(bo, place, &res1, NULL);
> +	err = ttm_resource_alloc(bo, place, &res1, NULL, NULL);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	bo->resource = res1;
>  
>  	/* Add a dummy resource to populate LRU */
> -	ttm_resource_alloc(bo, place, &res2, NULL);
> +	ttm_resource_alloc(bo, place, &res2, NULL, NULL);
>  
>  	dma_resv_lock(bo->base.resv, NULL);
>  	ttm_bo_unreserve(bo);
> @@ -300,12 +300,12 @@ static void ttm_bo_unreserve_pinned(struct kunit *test)
>  	dma_resv_lock(bo->base.resv, NULL);
>  	ttm_bo_pin(bo);
>  
> -	err = ttm_resource_alloc(bo, place, &res1, NULL);
> +	err = ttm_resource_alloc(bo, place, &res1, NULL, NULL);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	bo->resource = res1;
>  
>  	/* Add a dummy resource to the pinned list */
> -	err = ttm_resource_alloc(bo, place, &res2, NULL);
> +	err = ttm_resource_alloc(bo, place, &res2, NULL, NULL);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	KUNIT_ASSERT_EQ(test,
>  			list_is_last(&res2->lru.link, &priv->ttm_dev->unevictable), 1);
> @@ -355,7 +355,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
>  	ttm_bo_set_bulk_move(bo1, &lru_bulk_move);
>  	dma_resv_unlock(bo1->base.resv);
>  
> -	err = ttm_resource_alloc(bo1, place, &res1, NULL);
> +	err = ttm_resource_alloc(bo1, place, &res1, NULL, NULL);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	bo1->resource = res1;
>  
> @@ -363,7 +363,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
>  	ttm_bo_set_bulk_move(bo2, &lru_bulk_move);
>  	dma_resv_unlock(bo2->base.resv);
>  
> -	err = ttm_resource_alloc(bo2, place, &res2, NULL);
> +	err = ttm_resource_alloc(bo2, place, &res2, NULL, NULL);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	bo2->resource = res2;
>  
> @@ -401,7 +401,7 @@ static void ttm_bo_fini_basic(struct kunit *test)
>  	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
>  	bo->type = ttm_bo_type_device;
>  
> -	err = ttm_resource_alloc(bo, place, &res, NULL);
> +	err = ttm_resource_alloc(bo, place, &res, NULL, NULL);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	bo->resource = res;
>  
> @@ -518,7 +518,7 @@ static void ttm_bo_pin_unpin_resource(struct kunit *test)
>  
>  	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
>  
> -	err = ttm_resource_alloc(bo, place, &res, NULL);
> +	err = ttm_resource_alloc(bo, place, &res, NULL, NULL);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	bo->resource = res;
>  
> @@ -569,7 +569,7 @@ static void ttm_bo_multiple_pin_one_unpin(struct kunit *test)
>  
>  	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
>  
> -	err = ttm_resource_alloc(bo, place, &res, NULL);
> +	err = ttm_resource_alloc(bo, place, &res, NULL, NULL);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	bo->resource = res;
>  
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> index 2db221f6fc3a1..cd40f5b2ab4f1 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -547,7 +547,7 @@ static void ttm_bo_validate_no_placement_signaled(struct kunit *test)
>  
>  	ttm_bo_reserve(bo, false, false, NULL);
>  
> -	err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
> +	err = ttm_resource_alloc(bo, place, &bo->resource, NULL, NULL);
>  	KUNIT_EXPECT_EQ(test, err, 0);
>  	KUNIT_ASSERT_EQ(test, man->usage, size);
>  
> @@ -604,7 +604,7 @@ static void ttm_bo_validate_no_placement_not_signaled(struct kunit *test)
>  	bo = ttm_bo_kunit_init(test, test->priv, size, NULL);
>  	bo->type = params->bo_type;
>  
> -	err = ttm_resource_alloc(bo, place, &bo->resource, NULL);
> +	err = ttm_resource_alloc(bo, place, &bo->resource, NULL, NULL);
>  	KUNIT_EXPECT_EQ(test, err, 0);
>  
>  	placement = kunit_kzalloc(test, sizeof(*placement), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_resource_test.c b/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
> index c0e4e35e04426..41fe4d89cd714 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
> @@ -303,7 +303,7 @@ static void ttm_sys_man_free_basic(struct kunit *test)
>  	res = kunit_kzalloc(test, sizeof(*res), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, res);
>  
> -	ttm_resource_alloc(bo, place, &res, NULL);
> +	ttm_resource_alloc(bo, place, &res, NULL, NULL);
>  
>  	man = ttm_manager_type(priv->devs->ttm_dev, mem_type);
>  	man->func->free(man, res);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bcd76f6bb7f02..bdfcfe5c7d1e2 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -505,6 +505,8 @@ struct ttm_bo_evict_walk {
>  
>  	/** @limit_pool: Which pool limit we should test against */
>  	struct dmem_cgroup_pool_state *limit_pool;
> +	/** @try_high: Whether to only evict BO's above the high watermark (first pass) */
> +	bool try_high;
>  	/** @try_low: Whether we should attempt to evict BO's with low watermark threshold */
>  	bool try_low;
>  	/** @hit_low: If we cannot evict a bo when @try_low is false (first pass) */
> @@ -518,7 +520,8 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>  	s64 lret;
>  
>  	if (!dmem_cgroup_state_evict_valuable(evict_walk->limit_pool, bo->resource->css,
> -					      evict_walk->try_low, &evict_walk->hit_low))
> +					      evict_walk->try_high, evict_walk->try_low,
> +					      &evict_walk->hit_low))
>  		return 0;
>  
>  	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
> @@ -538,7 +541,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>  	evict_walk->evicted++;
>  	if (evict_walk->res)
>  		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +					  evict_walk->res, NULL, NULL);
>  	if (lret == 0)
>  		return 1;
>  out:
> @@ -553,6 +556,38 @@ static const struct ttm_lru_walk_ops ttm_evict_walk_ops = {
>  	.process_bo = ttm_bo_evict_cb,
>  };
>  
> +/*
> + * Proactive reclaim: evict one BO from a cgroup that exceeds its dmem.high
> + * soft limit.  Called after a successful charge that pushed usage over the
> + * high threshold.  Best-effort; allocation already succeeded (soft limit).
> + */
> +static void ttm_bo_proactive_evict_high(struct ttm_device *bdev,
> +					struct ttm_resource_manager *man,
> +					const struct ttm_place *place,
> +					struct ttm_buffer_object *evictor,
> +					struct ttm_operation_ctx *ctx,
> +					struct ww_acquire_ctx *ticket,
> +					struct dmem_cgroup_pool_state *over_high_pool)
> +{
> +	struct ttm_bo_evict_walk evict_walk = {
> +		.walk = {
> +			.ops = &ttm_evict_walk_ops,
> +			.arg = {
> +				.ctx = ctx,
> +				.ticket = ticket,
> +				.trylock_only = !ticket,
> +			}
> +		},
> +		.place = place,
> +		.evictor = evictor,
> +		.res = NULL,
> +		.limit_pool = over_high_pool,
> +		.try_high = true,
> +	};
> +
> +	ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
> +}
> +
>  static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>  			      struct ttm_resource_manager *man,
>  			      const struct ttm_place *place,
> @@ -579,29 +614,24 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>  
>  	evict_walk.walk.arg.trylock_only = true;
>  	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
> -
> -	/* One more attempt if we hit low limit? */
>  	if (!lret && evict_walk.hit_low) {
>  		evict_walk.try_low = true;
>  		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>  	}
> +
>  	if (lret || !ticket)
>  		goto out;
>  
> -	/* Reset low limit */
>  	evict_walk.try_low = evict_walk.hit_low = false;
> -	/* If ticket-locking, repeat while making progress. */
>  	evict_walk.walk.arg.trylock_only = false;
>  
>  retry:
>  	do {
> -		/* The walk may clear the evict_walk.walk.ticket field */
>  		evict_walk.walk.arg.ticket = ticket;
>  		evict_walk.evicted = 0;
>  		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>  	} while (!lret && evict_walk.evicted);
>  
> -	/* We hit the low limit? Try once more */
>  	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
>  		evict_walk.try_low = true;
>  		goto retry;
> @@ -737,7 +767,17 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>  			continue;
>  
>  		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
> -		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
> +		{
> +			struct dmem_cgroup_pool_state *over_high_pool = NULL;
> +
> +			ret = ttm_resource_alloc(bo, place, res,
> +						 force_space ? &limit_pool : NULL,
> +						 &over_high_pool);
> +			if (!ret && over_high_pool)
> +				ttm_bo_proactive_evict_high(bdev, man, place, bo,
> +							    ctx, ticket, over_high_pool);
> +			dmem_cgroup_pool_state_put(over_high_pool);
> +		}
>  		if (ret) {
>  			if (ret != -ENOSPC) {
>  				dmem_cgroup_pool_state_put(limit_pool);
> @@ -1152,7 +1192,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
>  
>  		memset(&hop, 0, sizeof(hop));
>  		place.mem_type = TTM_PL_SYSTEM;
> -		ret = ttm_resource_alloc(bo, &place, &evict_mem, NULL);
> +		ret = ttm_resource_alloc(bo, &place, &evict_mem, NULL, NULL);
>  		if (ret)
>  			goto out;
>  
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 154d6739256f8..e6ad46d9ff181 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -389,7 +389,8 @@ EXPORT_SYMBOL(ttm_resource_fini);
>  int ttm_resource_alloc(struct ttm_buffer_object *bo,
>  		       const struct ttm_place *place,
>  		       struct ttm_resource **res_ptr,
> -		       struct dmem_cgroup_pool_state **ret_limit_pool)
> +		       struct dmem_cgroup_pool_state **ret_limit_pool,
> +		       struct dmem_cgroup_pool_state **ret_over_high_pool)
>  {
>  	struct ttm_resource_manager *man =
>  		ttm_manager_type(bo->bdev, place->mem_type);
> @@ -397,7 +398,8 @@ int ttm_resource_alloc(struct ttm_buffer_object *bo,
>  	int ret;
>  
>  	if (man->cg) {
> -		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
> +		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool,
> +					     ret_limit_pool, ret_over_high_pool);
>  		if (ret) {
>  			if (ret == -EAGAIN)
>  				ret = -ENOSPC;
> @@ -409,6 +411,8 @@ int ttm_resource_alloc(struct ttm_buffer_object *bo,
>  	if (ret) {
>  		if (pool)
>  			dmem_cgroup_uncharge(pool, bo->base.size);
> +		if (ret_over_high_pool)
> +			dmem_cgroup_pool_state_put(*ret_over_high_pool);
>  		return ret;
>  	}
>  
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index a5d386583fb6e..88fb402acfdc6 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -461,7 +461,8 @@ void ttm_resource_fini(struct ttm_resource_manager *man,
>  int ttm_resource_alloc(struct ttm_buffer_object *bo,
>  		       const struct ttm_place *place,
>  		       struct ttm_resource **res,
> -		       struct dmem_cgroup_pool_state **ret_limit_pool);
> +		       struct dmem_cgroup_pool_state **ret_limit_pool,
> +		       struct dmem_cgroup_pool_state **ret_over_high_pool);
>  void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res);
>  bool ttm_resource_intersects(struct ttm_device *bdev,
>  			     struct ttm_resource *res,
> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
> index dd4869f1d736e..1808bfbbc9a31 100644
> --- a/include/linux/cgroup_dmem.h
> +++ b/include/linux/cgroup_dmem.h
> @@ -19,11 +19,12 @@ struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *nam
>  void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region);
>  int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
>  			   struct dmem_cgroup_pool_state **ret_pool,
> -			   struct dmem_cgroup_pool_state **ret_limit_pool);
> +			   struct dmem_cgroup_pool_state **ret_limit_pool,
> +			   struct dmem_cgroup_pool_state **ret_over_high_pool);
>  void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size);
>  bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  				      struct dmem_cgroup_pool_state *test_pool,
> -				      bool ignore_low, bool *ret_hit_low);
> +				      bool try_high, bool ignore_low, bool *ret_hit_low);
>  
>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
>  #else
> @@ -38,13 +39,17 @@ static inline void dmem_cgroup_unregister_region(struct dmem_cgroup_region *regi
>  
>  static inline int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
>  					 struct dmem_cgroup_pool_state **ret_pool,
> -					 struct dmem_cgroup_pool_state **ret_limit_pool)
> +					 struct dmem_cgroup_pool_state **ret_limit_pool,
> +					 struct dmem_cgroup_pool_state **ret_over_high_pool)
>  {
>  	*ret_pool = NULL;
>  
>  	if (ret_limit_pool)
>  		*ret_limit_pool = NULL;
>  
> +	if (ret_over_high_pool)
> +		*ret_over_high_pool = NULL;
> +
>  	return 0;
>  }
>  
> @@ -54,8 +59,10 @@ static inline void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64
>  static inline
>  bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  				      struct dmem_cgroup_pool_state *test_pool,
> -				      bool ignore_low, bool *ret_hit_low)
> +				      bool try_high, bool ignore_low, bool *ret_hit_low)
>  {
> +	if (try_high)
> +		return false;
>  	return true;
>  }
>  
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 4753a67d0f0f2..b322c8a7e2a67 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -156,6 +156,12 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
>  	page_counter_set_low(&pool->cnt, val);
>  }
>  
> +static void
> +set_resource_high(struct dmem_cgroup_pool_state *pool, u64 val)
> +{
> +	page_counter_set_high(&pool->cnt, val);
> +}
> +
>  static void
>  set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
>  {
> @@ -167,6 +173,11 @@ static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
>  	return pool ? READ_ONCE(pool->cnt.low) : 0;
>  }
>  
> +static u64 get_resource_high(struct dmem_cgroup_pool_state *pool)
> +{
> +	return pool ? READ_ONCE(pool->cnt.high) : PAGE_COUNTER_MAX;
> +}
> +
>  static u64 get_resource_min(struct dmem_cgroup_pool_state *pool)
>  {
>  	return pool ? READ_ONCE(pool->cnt.min) : 0;
> @@ -186,6 +197,7 @@ static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
>  {
>  	set_resource_min(rpool, 0);
>  	set_resource_low(rpool, 0);
> +	set_resource_high(rpool, PAGE_COUNTER_MAX);
>  	set_resource_max(rpool, PAGE_COUNTER_MAX);
>  }
>  
> @@ -289,10 +301,13 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
>   * dmem_cgroup_state_evict_valuable() - Check if we should evict from test_pool
>   * @limit_pool: The pool for which we hit limits
>   * @test_pool: The pool for which to test
> + * @try_high: Only evict BOs whose usage exceeds the high limit (first pass)
>   * @ignore_low: Whether we have to respect low watermarks.
>   * @ret_hit_low: Pointer to whether it makes sense to consider low watermark.
>   *
>   * This function returns true if we can evict from @test_pool, false if not.
> + * When @try_high is set, only pools with usage above their high limit are
> + * evictable, enabling prioritized eviction of over-limit cgroups.
>   * When returning false and @ignore_low is false, @ret_hit_low may
>   * be set to true to indicate this function can be retried with @ignore_low
>   * set to true.
> @@ -301,15 +316,26 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
>   */
>  bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  				      struct dmem_cgroup_pool_state *test_pool,
> -				      bool ignore_low, bool *ret_hit_low)
> +				      bool try_high, bool ignore_low, bool *ret_hit_low)
>  {
>  	struct dmem_cgroup_pool_state *pool = test_pool;
>  	struct page_counter *ctest;
>  	u64 used, min, low;
>  
> -	/* Can always evict from current pool, despite limits */
> -	if (limit_pool == test_pool)
> +	/*
> +	 * When the limit-hitting cgroup's own BOs are being considered
> +	 * in try_high mode, only evict them if their pool exceeds its
> +	 * own dmem.high limit.  For non-try_high mode, maintain the
> +	 * existing behavior: always evict from the limit-hitting pool.
> +	 */
> +	if (limit_pool == test_pool) {
> +		if (try_high && test_pool) {
> +			ctest = &test_pool->cnt;
> +			used = page_counter_read(ctest);
> +			return used > READ_ONCE(ctest->high);
> +		}
>  		return true;
> +	}
>  
>  	if (limit_pool) {
>  		if (!parent_dmemcs(limit_pool->cs))
> @@ -330,10 +356,38 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  	}
>  
>  	ctest = &test_pool->cnt;
> +	used = page_counter_read(ctest);
> +
> +	if (try_high) {
> +		struct page_counter *c;
> +
> +		/*
> +		 * Walk the page_counter parent chain to check whether any
> +		 * ancestor cgroup exceeds its dmem.high limit.  This prevents
> +		 * child cgroups from evading the penalty when a parent cgroup
> +		 * is over its high limit.
> +		 */
> +		if (used <= READ_ONCE(ctest->high)) {
> +			for (c = ctest->parent; c; c = c->parent) {
> +				if (page_counter_read(c) > READ_ONCE(c->high))
> +					break;
> +			}
> +			if (!c)
> +				return false;
> +		}
> +
> +		/*
> +		 * Respect dmem.min protection: do not evict BOs below the
> +		 * effective minimum even during the high-priority pass.
> +		 */
> +		dmem_cgroup_calculate_protection(limit_pool, test_pool);
> +		min = READ_ONCE(ctest->emin);
> +
> +		return used > min;
> +	}
>  
>  	dmem_cgroup_calculate_protection(limit_pool, test_pool);
>  
> -	used = page_counter_read(ctest);
>  	min = READ_ONCE(ctest->emin);
>  
>  	if (used <= min)
> @@ -634,8 +688,9 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
>   * dmem_cgroup_try_charge() - Try charging a new allocation to a region.
>   * @region: dmem region to charge
>   * @size: Size (in bytes) to charge.
> - * @ret_pool: On succesfull allocation, the pool that is charged.
> + * @ret_pool: On successful allocation, the pool that is charged.
>   * @ret_limit_pool: On a failed allocation, the limiting pool.
> + * @ret_over_high_pool: On successful allocation, set if usage exceeds dmem.high.
>   *
>   * This function charges the @region region for a size of @size bytes.
>   *
> @@ -647,11 +702,17 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
>   * eviction as argument to dmem_cgroup_evict_valuable(). This reference must be freed
>   * with @dmem_cgroup_pool_state_put().
>   *
> + * When the function succeeds and @ret_over_high_pool is non-null, it will be
> + * set if the charged pool's usage now exceeds its dmem.high soft limit. The
> + * caller should trigger proactive eviction to bring usage back under the limit.
> + * This reference must be freed with @dmem_cgroup_pool_state_put().
> + *
>   * Return: 0 on success, -EAGAIN on hitting a limit, or a negative errno on failure.
>   */
>  int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
>  			  struct dmem_cgroup_pool_state **ret_pool,
> -			  struct dmem_cgroup_pool_state **ret_limit_pool)
> +			  struct dmem_cgroup_pool_state **ret_limit_pool,
> +			  struct dmem_cgroup_pool_state **ret_over_high_pool)
>  {
>  	struct dmemcg_state *cg;
>  	struct dmem_cgroup_pool_state *pool;
> @@ -661,6 +722,8 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
>  	*ret_pool = NULL;
>  	if (ret_limit_pool)
>  		*ret_limit_pool = NULL;
> +	if (ret_over_high_pool)
> +		*ret_over_high_pool = NULL;
>  
>  	/*
>  	 * hold on to css, as cgroup can be removed but resource
> @@ -685,6 +748,18 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
>  		goto err;
>  	}
>  
> +	/*
> +	 * Charge succeeded. Check if usage now exceeds the soft high limit so
> +	 * the caller can trigger proactive reclaim to bring the cgroup back
> +	 * under its dmem.high threshold.
> +	 */
> +	if (ret_over_high_pool &&
> +	    page_counter_read(&pool->cnt) > READ_ONCE(pool->cnt.high)) {
> +		*ret_over_high_pool = pool;
> +		css_get(&pool->cs->css);
> +		dmemcg_pool_get(*ret_over_high_pool);
> +	}
> +
>  	/* On success, reference from get_current_dmemcs is transferred to *ret_pool */
>  	*ret_pool = pool;
>  	return 0;
> @@ -835,6 +910,17 @@ static ssize_t dmem_cgroup_region_low_write(struct kernfs_open_file *of,
>  	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_low);
>  }
>  
> +static int dmem_cgroup_region_high_show(struct seq_file *sf, void *v)
> +{
> +	return dmemcg_limit_show(sf, v, get_resource_high);
> +}
> +
> +static ssize_t dmem_cgroup_region_high_write(struct kernfs_open_file *of,
> +					  char *buf, size_t nbytes, loff_t off)
> +{
> +	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_high);
> +}
> +
>  static int dmem_cgroup_region_max_show(struct seq_file *sf, void *v)
>  {
>  	return dmemcg_limit_show(sf, v, get_resource_max);
> @@ -868,6 +954,12 @@ static struct cftype files[] = {
>  		.seq_show = dmem_cgroup_region_low_show,
>  		.flags = CFTYPE_NOT_ON_ROOT,
>  	},
> +	{
> +		.name = "high",
> +		.write = dmem_cgroup_region_high_write,
> +		.seq_show = dmem_cgroup_region_high_show,
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +	},
>  	{
>  		.name = "max",
>  		.write = dmem_cgroup_region_max_write,
> 
> ---
> base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
> change-id: 20260519-feature-dmem-high-16997148dc38
> 
> Best regards,
> -- 
> Jing Wu <realwujing@gmail.com>
> 

