Return-Path: <cgroups+bounces-14630-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCMHAYgqqWkL2gAAu9opvQ
	(envelope-from <cgroups+bounces-14630-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 08:02:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164F20C183
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 08:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 548B33084136
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4328430ACE6;
	Thu,  5 Mar 2026 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlIDJ9Yk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178541DF742
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694054; cv=fail; b=OEGPu8JmkAso7cT5650nCZRlmzWqWNTXIYkdFvYaeeE727Oa/wGSBBhoLIxutjYejW5t+SwouJbKOKntwpzmqOprbPwBCQYRcHC96fqxlhMyKwrZUWRMrbioHiVSFjWm5kVQuaET2lt6NVzb6AMJKv+d1hHZwJHIjS2J7iVU0Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694054; c=relaxed/simple;
	bh=4rsTmU/n5+pnhYq6qlxAKZEniwpvqOaIpk3euN0gqP4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hN5wNtkU+ZB7ic5BVqO7SBFhZylGEqMbH41mx2PIINfVBahktplpA4eyFAN7QNKYoeAsrBIjl8Rrb7d23vhIEzsrZyKs7iEwuiFpr4GhctOslWbnJcpUbcHsHxn2ac4uUd38hjQ84hj1la7Tb5hZMAI1mqLKgWadrC5zFgCVd4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlIDJ9Yk; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772694051; x=1804230051;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=4rsTmU/n5+pnhYq6qlxAKZEniwpvqOaIpk3euN0gqP4=;
  b=KlIDJ9YkGOP0AkFvxCp4XNPMPxNus87NxnFK2VboYeKcMftZM+KA4/A3
   tLI/RRkBM2pPK3eswD+l8T2U/Hr/ksqtQwanJr6HQyf5t4Rk7hFZXaAI5
   a8PNpuGwV6DUVmittcFGyUnl3+hEcjfpnAVd9P855l1jbYtS1sKD+0TjX
   1V5Es9rEE9BRkSIP+GuNRLzkSLd48W8XUv66LHvhm75rwaO7s0/6ZCk6H
   8KHoYTeCxWexmdcmJI95S7zgtDxnPUQpQKcQQnT+jyW4JPXka0WkgMpP4
   msNhy69/T0IgeqHLBrqAe1L8qbd3P/V6a0o9IDHMT3040DkybnTV9KRIc
   A==;
X-CSE-ConnectionGUID: PBd9G05zS1O0Xzmu6mtjww==
X-CSE-MsgGUID: njDeNnjJTdG/hHZpbKutyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="99239946"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="99239946"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:00:50 -0800
X-CSE-ConnectionGUID: eQSWWbzWSkG5y/V1kvMXeg==
X-CSE-MsgGUID: DvZCB1aiTpKuYsFICnHg5Q==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:00:50 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 23:00:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 23:00:49 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 23:00:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbD9LN7cJ9/LZg+LKFfRCzdy13wjWI9qSZo3PEEeKQIRglSVDwltwQgZG87iy8HDpWIRW9aQ5QSLYlaTEo19Ti4+BalgWSHLxMjxXflwPnMh9Kc0eQfF7KpvuMuHyicSNFnbT1itzPWJGPMlzx/J+RRFQvP/Vj2JBrcmA0uGjD8s1GSPz4T/2YTwjwP2fzRkWXssHpG+KYYn/ISNNsqyXSu2LZP43zJGWn8wbDrIiAFIpYAhwq6MSpWCIDP+jeatUKC/st+VJxUf0iMLVCzA2HyjsKpwvQYpOT28nzlRsj7GLZ4EAYBx95bHiZmxh8F9LQAgahAKe6U9AcwaIipDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5Oxn0RITVTS1IkxYHGTlUDb2pzyYWseL+Kp5vcC8pY=;
 b=TWuNnF0iP5oNycOY5ZDUp3jB0ko0Mm4uLM8tCVo5bbcy5X8bK5HAJ9pB93nKneOaHfdCXYOjNYLDVBBUDYa+S3uVmY3xu9GDgKS9jhnhqDcLF++gc10wY6biDnzOc/J5AwIwbXbXiIjVZNZcOB6UcSiILD8bMsQk3KjWE+tTOsx7J5EiBmI4SI6EM6vfMIVr6rdLTxbT9yKxdsqdMrMYHL4imFlP3ayPyxEmaZGMX4bCsQltmnHNAZU8h2f4qHQ/9h8iJe9jGjoiXrpoSSfs9kvtTTI8GHl5+rtbZogt32k2XooylwVA3BYzl99hoOQQ5qbrHAGrr6Pzxv5tPmWG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPF7708D4D9D.namprd11.prod.outlook.com (2603:10b6:518:1::d31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 07:00:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 07:00:45 +0000
Date: Thu, 5 Mar 2026 15:00:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Axel Rasmussen
	<axelrasmussen@google.com>, <linux-mm@kvack.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
	<cgroups@vger.kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 3/3] ptdesc: Account page tables to memcgs again
Message-ID: <202603051407.fde83fdb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225162319.315281-4-willy@infradead.org>
X-ClientProxiedBy: KL1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:820:d::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPF7708D4D9D:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f972475-65ef-4a62-478d-08de7a84ebbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: rUZjUcK3eKIf5cOulmhbdjp3X+uz1txEQ6M+N5rz966cczxu29SvkHsHnjZW1LopARAlWu2TogWYgZFVTEdmdRlozmtOCIp3Zu1TmUaebbCc8J3ZyAu5JpMnkrdY7NpnqK697w4lcOKL05/y1qev1dpKlmAsOdnjfa8FoKEm/XnOa8uJTBDmTcBj+EovWy6CM3eBgoVovm54eDDAfbXx/vRNUiSfqM8BL9SO5iZNQj/A74qNB8LCuRNkru82Q4JCyYdejw8M8UjU50690HAOi3JlKiWxbdjCSxCGxFATCBbbOxB2PptIaxWidBU4eCrzIg5+oJqzinHqBhJFDhjBVySGzwersE8bTJ62NLOIvpQClxSVfeeFByoFispoc/2hk9XZ1rgM7Jzsy2CeBeCDQVzT0QZkyFZ3aKIOvwlkinlwKRdJXKsPjqi7/dtkCapuy9obrjPkCHpPBJ1XY89S0g2wjxUI45/M+2frjzruOIN/ajGxGhWjHcKvw5OYDDlp3xR8ytAg5V/F+a7L/eEWcj5oSdG7HTdP9WTv2e8JmMbf/bIoEPdRuEGKjT7p7m+elfHxfc9YHfxBtAWQKK+MK9Gb2vtSINfQqXHwlb/fI3xWjLK1Ssy8G8QTel2xOXBjL3oTil0KBblIjTGhjEzSXr+L1oRhBSjrbRNNvw7/YFcIeGibsKrfRkKFprNQPkn6gg5Z6nz8bnpD9dZHuuK63B9Za51qkJ5b610GaExb49e5qd2cmVx6XwqKWRqNc/2G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9kKqxMiJ/qaFjt2LT0LSLEOPWYWeTXQuPhkFCpCz0gdBLduB2dr6VzXY0J2f?=
 =?us-ascii?Q?DrtpkT9uWVA/3W/q/Un3khDYOMG/8Ex+hqq1ox6pu2R1iNFOlip8hcA3EeeR?=
 =?us-ascii?Q?XD9g0qn6Pyl1zVj5R6Y9meXeZQ5AkFtk9tjHz1aT+15EEJudUzwncxBJCD2L?=
 =?us-ascii?Q?9U+b4b2fOgFyXEjLGND1PeHmfZLokRVCb0sfaSxxATF8QMQk1Urao6bKaupW?=
 =?us-ascii?Q?pDhO6gljuRJGmEpB0pT74Oe8/vl/aADuKWxub83Lmp19qztImPN5ABmj2LJK?=
 =?us-ascii?Q?pGSS1eTb3ALczZKBR5vh8pTAhIKjQpitkS5cjI7SuwofSYhO3nqcoGa7t9Ja?=
 =?us-ascii?Q?SIGBrdNJTn1z3TwXemQGDOeVl1PH7jU47DnUN8AZHEFQzyjrtD6lUQfEOq9C?=
 =?us-ascii?Q?5YQWUzxTd3Ip7fEE5mv+rTX1FrNRoGAnDNUWmuOs7572AOIWHmTEN+BtYHmJ?=
 =?us-ascii?Q?/k1mNNAD+5Qal1Fqwz62IA8m4vNdOe5oSJ8/TmPrNrwQrPrzeWnNNFCPTjsT?=
 =?us-ascii?Q?dNI7OEylU8Z2kexBeVrP6VudMeVuZGc3hZxHJGZvuS5oQs8D2CX8JA8Sit43?=
 =?us-ascii?Q?9pUOIirjxECFSlPCqfBhx7YPS/YyjF/KGEXJNUGES9LrfeZ/hBt07QPDtv6n?=
 =?us-ascii?Q?sB6TFJjQr0bXb3c9lJ1f3jk6Y1xGOrFiuxJ7BR7+ZHeevI1xIcoZNGHnLJa8?=
 =?us-ascii?Q?qvyHVgzu8BhPZqsgzuSs+cYA9r65x8iCquuegKg6xN8lYgL8j8p4Bky9NyIu?=
 =?us-ascii?Q?xGvQFxbYqu+3eADumOrIjjxxZebO0zHqp2vkfUMp+7npEWVq+tzFvr0MT2/P?=
 =?us-ascii?Q?/XtFSiP0wcAGhzlvbFyDsh+yTfsq/bHfjK7O6ESTI5YacE9XMe3B4uPxOxxJ?=
 =?us-ascii?Q?r+LJzUUJfYpIxHvfRDItlWOspz8EnSEJlr0K/zF+GCPklU2vCJSYQ0CJbPA5?=
 =?us-ascii?Q?9q2oQ04FZvGZrWRv6GhoqbzhIKrY4F48O+s+c06uMq3Otxtjk/2kAAGLmfOl?=
 =?us-ascii?Q?sHOvKsgOcNlgWhLhaIbqMGx2UYLuG4MFwtwJa8Q9vxivcuy6QPb5tdT8tFub?=
 =?us-ascii?Q?ZJtssOH1e5o+bllQEmwpe+p7r+NSqyImyjScQLKFPagejuhQGTVjKEMPUD+n?=
 =?us-ascii?Q?ItXVrSM1TlgQPQhA1DXVby0JIS5YEyX5/jFdMdhUiw/ana34NrSuj7nY23af?=
 =?us-ascii?Q?ggUvHaMrXPW1nX3t36pVv/ZokkaePeSqlFF22n1wgHWpKu6NMeWgJRyBvdz+?=
 =?us-ascii?Q?Pgslv3wi7A5iUOqwy4Elut+5+vc4qCWn6+njEYDzXsr+ksYfh4nlR/svbFWa?=
 =?us-ascii?Q?nPkZ52eUnCs4edxb/76MZomafo2kCyTwFaYU3scnF2IdxRjorgOMRIVloXXC?=
 =?us-ascii?Q?ZItPrK9zjJ8+lLu8ONJgvi+BzHH1DvAMq+mREaidbfVWbexTcUwgyOpbUMef?=
 =?us-ascii?Q?CRlN6Mgms590iokhVlMXCeDofqn/F9ggSGT4un/FdV2w8hIsHkD37FxIFyLm?=
 =?us-ascii?Q?kW2rI/kZnYVZvY2o8goSgqKU4bk9H2J7hpz+gzRu/bMXxVAltyIM8nMC/Uq0?=
 =?us-ascii?Q?hScWMDKphRZaft0/M5NEDCt2NJEwby7NAWRhzWHREjc3MnmK9Y1Ry1aYiBiF?=
 =?us-ascii?Q?pGnt6Y6+D007uwXiXd+GI4LIJnsIVdNXr9tOd4TuxBIOfbsOWwhVWcnYuWU0?=
 =?us-ascii?Q?xseUL59yM3eXO4fH9tQq+gMJlkaLvtDiNW3MCltrLOyVII6h+6HAJF0HZCSn?=
 =?us-ascii?Q?XLVtIDCDug=3D=3D?=
X-Exchange-RoutingPolicyChecked: biWGBg/fvcMW+1ohedHzPE3q8eKpkF1BAp3svqvyg7wKhF/S1zPJuaDYb5pWltC0ipZMdTAPezzxJgxn0vNveGnqu6KFyg2qy+aBzmwgTciCJwWacGvXW6A45ORL3lhiN0VnbH9fesd1DbntQR9PU4xxUSQgA+kyhqjpqu6Ph1ISxghkOzxV3QJVE0j3A+lPZGtqzCpCGS9GFhpOQvXo8S5YNtFpxS5HAsM4N8BB/V8oocZD21zFCiWoZv3f7mW/oSJ5j556rXyn5OyhABla6elHbhbp0RhF8X0WDyo1aNyFp3Xbg7SHITZaTjYV8TSkWjUtUsZTJQnKTbM3ZfFU2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f972475-65ef-4a62-478d-08de7a84ebbd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 07:00:45.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM/1VQfjxxth8QnxIfNECeX94YYDk3qz3zkauD5hk8U9wsda4e4BmvR0nyrjOsjGayWdmC2tvTYJyOqCau0c4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7708D4D9D
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7164F20C183
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14630-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,01.org:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 1445ef3d5f2fefd1fcedb68cff3fff0a33994791 ("[PATCH 3/3] ptdesc: Account page tables to memcgs again")
url: https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/memcg-Add-memcg_stat_mod/20260226-003144
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20260225162319.315281-4-willy@infradead.org/
patch subject: [PATCH 3/3] ptdesc: Account page tables to memcgs again

in testcase: boot

config: x86_64-randconfig-r052-20250414
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603051407.fde83fdb-lkp@intel.com



[   14.109191][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000880
[   14.109653][    T1] #PF: supervisor read access in kernel mode
[   14.109989][    T1] #PF: error_code(0x0000) - not-present page
[   14.110322][    T1] PGD 12a8ff067 P4D 12a8ff067 PUD 0
[   14.110622][    T1] Oops: Oops: 0000 [#1] SMP
[   14.110878][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 7.0.0-rc1-00154-g1445ef3d5f2f #1 PREEMPT(full)
[   14.111462][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   14.112082][    T1] RIP: 0010:mem_cgroup_lruvec (include/linux/memcontrol.h:729 (discriminator 1))
[   14.112396][    T1] Code: 74 09 48 8d 83 40 22 00 00 eb 1f 4d 85 e4 75 07 4c 8b 25 bd c3 1e 02 48 63 83 b8 1e 00 00 49 8b 84 c4 58 07 00 00 48 83 c0 40 <48> 39 98 40 08 00 00 74 07 48 89 98 40 08 00 00 5b 41 5c 5d c3 cc
All code
========
   0:	74 09                	je     0xb
   2:	48 8d 83 40 22 00 00 	lea    0x2240(%rbx),%rax
   9:	eb 1f                	jmp    0x2a
   b:	4d 85 e4             	test   %r12,%r12
   e:	75 07                	jne    0x17
  10:	4c 8b 25 bd c3 1e 02 	mov    0x21ec3bd(%rip),%r12        # 0x21ec3d4
  17:	48 63 83 b8 1e 00 00 	movslq 0x1eb8(%rbx),%rax
  1e:	49 8b 84 c4 58 07 00 	mov    0x758(%r12,%rax,8),%rax
  25:	00 
  26:	48 83 c0 40          	add    $0x40,%rax
  2a:*	48 39 98 40 08 00 00 	cmp    %rbx,0x840(%rax)		<-- trapping instruction
  31:	74 07                	je     0x3a
  33:	48 89 98 40 08 00 00 	mov    %rbx,0x840(%rax)
  3a:	5b                   	pop    %rbx
  3b:	41 5c                	pop    %r12
  3d:	5d                   	pop    %rbp
  3e:	c3                   	ret
  3f:	cc                   	int3

Code starting with the faulting instruction
===========================================
   0:	48 39 98 40 08 00 00 	cmp    %rbx,0x840(%rax)
   7:	74 07                	je     0x10
   9:	48 89 98 40 08 00 00 	mov    %rbx,0x840(%rax)
  10:	5b                   	pop    %rbx
  11:	41 5c                	pop    %r12
  13:	5d                   	pop    %rbp
  14:	c3                   	ret
  15:	cc                   	int3
[   14.113448][    T1] RSP: 0018:ffff888101467c10 EFLAGS: 00210202
[   14.113783][    T1] RAX: 0000000000000040 RBX: ffffffff83708880 RCX: 0000000000000001
[   14.114217][    T1] RDX: 0000000000000001 RSI: ffffffff83708880 RDI: ffff88812a845f82
[   14.114652][    T1] RBP: ffff888101467c20 R08: 0000000000000000 R09: 0000000000000000
[   14.115087][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88812a845f82
[   14.115979][    T1] R13: ffff888105fdd3a8 R14: ffff888105fdd740 R15: ffff888101442000
[   14.116421][    T1] FS:  0000000000000000(0000) GS:ffff88889bc98000(0063) knlGS:00000000f72f8840
[   14.116911][    T1] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   14.117276][    T1] CR2: 0000000000000880 CR3: 000000012b816000 CR4: 00000000000406f0
[   14.117713][    T1] Call Trace:
[   14.117901][    T1]  <TASK>
[   14.118070][    T1]  memcg_stat_mod (mm/memcontrol.c:804)
[   14.118328][    T1]  __pagetable_ctor (include/linux/mm.h:3547)
[   14.118595][    T1]  pgd_alloc (include/asm-generic/pgalloc.h:291 arch/x86/mm/pgtable.c:314 arch/x86/mm/pgtable.c:328)
[   14.118863][    T1]  mm_init+0x210/0x390
[   14.119129][    T1]  dup_mm+0x45/0xe0
[   14.119401][    T1]  copy_process (kernel/fork.c:1587 (discriminator 1) kernel/fork.c:2228 (discriminator 1))
[   14.119661][    T1]  ? free_filename (fs/namei.c:148)
[   14.119930][    T1]  kernel_clone (include/linux/random.h:26 kernel/fork.c:2660)
[   14.120200][    T1]  __do_compat_sys_ia32_clone (arch/x86/kernel/sys_ia32.c:255)
[   14.120519][    T1]  __ia32_compat_sys_ia32_clone (arch/x86/kernel/sys_ia32.c:240)
[   14.120837][    T1]  ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-r052-20250414/./arch/x86/include/generated/asm/syscalls_32.h:121)
[   14.121105][    T1]  __do_fast_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:307)
[   14.121398][    T1]  do_fast_syscall_32 (arch/x86/entry/syscall_32.c:332 (discriminator 1))
[   14.121671][    T1]  do_SYSENTER_32 (arch/x86/entry/syscall_32.c:371)
[   14.121926][    T1]  entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127)
[   14.122298][    T1] RIP: 0023:0xf7f9c38c
[   14.122527][    T1] Code: d2 74 05 c1 e8 0c 89 02 8b 5d fc 31 c0 c9 c3 cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 58 b8
All code
========
   0:	d2 74 05 c1          	shlb   %cl,-0x3f(%rbp,%rax,1)
   4:	e8 0c 89 02 8b       	call   0xffffffff8b028915
   9:	5d                   	pop    %rbp
   a:	fc                   	cld
   b:	31 c0                	xor    %eax,%eax
   d:	c9                   	leave
   e:	c3                   	ret
   f:	cc                   	int3
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	0f 1f 00             	nopl   (%rax)
  21:	51                   	push   %rcx
  22:	52                   	push   %rdx
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	cc                   	int3
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	58                   	pop    %rax
  3f:	b8                   	.byte 0xb8

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	cc                   	int3
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	58                   	pop    %rax
  15:	b8                   	.byte 0xb8


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260305/202603051407.fde83fdb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


