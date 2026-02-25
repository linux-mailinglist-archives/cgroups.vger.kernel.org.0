Return-Path: <cgroups+bounces-14390-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GntNxV2n2nScAQAu9opvQ
	(envelope-from <cgroups+bounces-14390-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 23:22:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F219E3C6
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 23:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830793046EB9
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775E32939F;
	Wed, 25 Feb 2026 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkMlvDHe"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4E31985B;
	Wed, 25 Feb 2026 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058127; cv=fail; b=gspPXSBSJBHt1Ljh4zk6CFUPJJVyJdnkiKfLBUkdlEU8SOZOGIPuXe4p5rvxUViGzUc8cvCQfb1VklPks1Fpbmtj9EomTsi/12BT8bjSuOT3MaFIaMJmCZ5oVIPMMHpVwScXcTpLRGF1tgJ+4j0teQllO9DYuKcOJzpOZGwmDcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058127; c=relaxed/simple;
	bh=xl1OfFp+Kky30f+IdLdbu8gRliaRpcYstiaOSMqdWPI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RrWsCeaPGx3gd6IANhuy35srT10GTwMEXnyBTGLsZZZ7RirGgEY+zH+jbQRzxZN2DhZAWAuodu8cotzDsK5+lmBHjpJDarzdg3yUfK4X2Mp2OFAasspUcv/33F6YOqVU4hkqs64BOJyPCwnt+4TiuluBFgBGaPb4WiSwnkdmi6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkMlvDHe; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772058125; x=1803594125;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xl1OfFp+Kky30f+IdLdbu8gRliaRpcYstiaOSMqdWPI=;
  b=hkMlvDHeAhNa7UNCqEgNaagNmbLqM9tvBGIhQMtnr8KmXD8hpm0c3yDM
   v3vr4NTPbHF3uij+xQWi4L84ob47NdDI3idO6q5MSXwa67rS7J6L8eeKj
   bVBHttZu+Qscw1yBIt+wL2k9UPXc/ypi1ajfExlKPIOkHe1JESj8KWnYY
   2A9Jg6lolmWcLOjw9yhmGs4pQ3ZC0XMzQpSH1slRIgMc9MDaQZ/1iFZIU
   BB3UnKfBmwT3l/zxIPuzMrXi6+cOHOdbsZrsxmnXP+WPaNcMGstn1vO19
   dFy8h3JUm+OmPDqGV8oeAkuqNsdJTnCVAklhzED3WAUNTNZtZ4UfaamNV
   g==;
X-CSE-ConnectionGUID: KbOtWOq8TeqmYb9vlyA4XA==
X-CSE-MsgGUID: PCvCQTFzQuiyki0WVl4fWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="84568181"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="84568181"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 14:22:04 -0800
X-CSE-ConnectionGUID: +pVxMKqnRoybzYTL37CMtA==
X-CSE-MsgGUID: Ye09/GDESNqwNI/F5VZh1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="214629860"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 14:22:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 14:22:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 14:22:04 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 14:22:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSSdy2eoL3ugXlpMvvlqnoflvNJkWvrni+GQOIdX4XSIGaJ5CI5kQoSB9T279uG+0NJeZn5/GOZAYqRAzGx8w4yUDCewLUk+45L7eKXKPkvlEKUbk3MiUloQ8WVeZ9YYqQ5GIBXHPzRzCCC3qkNjDOvlcRk7gT+VuYzFttIukjE0HO8eHyLnw4nNfnfgccCAXHveGgfWvnajD2+0IuZEZzIEaxNiTYTC/xdtSUOGL/l1ojoejJfeK8yiFikQfQL7w/S9FzIBpyHro9R7pi+80d0Mprz4ZUWRUwk/rDUz9lWFq4WZWEB3hYf/3xyNzXqr1WAzlANlAdRrb1yW0U/Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVPCAhZhb7CFIZ/7AaBjFvcIMSz2MfWgVWKZRLhxovo=;
 b=N2rwzG31tZVwmQVGztYpw6dG0wHRxYob0yrYY9oqIC3eVg0dGaRVcy/oJODTJXiPslIRyLihu9TRRJ0hrKHXE3NX1TTn3aiJoGcohAhuVFh7BCLNaq9EcdNb+iG/MQcklZHwQFyjtzHbYDfj2Z1zLMaHUk5pGTqm1AfpLAU/ZOFdWEPwJKGUUv1GQgcXYit4t20K1DVdacJV1jkUMA6j15kGgfxjpVQyAvSXYCN4/2o0VF6IUYPG22mYnoEz+RbtETK+h+jzY4Qqo255Z+9brj8ChzKqOjf/RPLS32XHaUkmePKzrZdYKno9y+7yjncxlJyZEUKSN1mzTCsy5RCZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 22:22:01 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 22:22:00 +0000
Date: Wed, 25 Feb 2026 14:21:54 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: Alistair Popple <apopple@nvidia.com>, <lsf-pc@lists.linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <damon@lists.linux.dev>,
	<kernel-team@meta.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <longman@redhat.com>,
	<akpm@linux-foundation.org>, <david@kernel.org>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<osalvador@suse.de>, <ziy@nvidia.com>, <joshua.hahnjy@gmail.com>,
	<rakie.kim@sk.com>, <byungchul@sk.com>, <ying.huang@linux.alibaba.com>,
	<axelrasmussen@google.com>, <yuanchu@google.com>, <weixugc@google.com>,
	<yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>, <jackmanb@google.com>, <sj@kernel.org>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>,
	<muchun.song@linux.dev>, <xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>,
	<jannh@google.com>, <linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>,
	<pfalcato@suse.de>, <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<riel@surriel.com>, <harry.yoo@oracle.com>, <cl@gentwo.org>,
	<roman.gushchin@linux.dev>, <chrisl@kernel.org>, <kasong@tencent.com>,
	<shikemeng@huaweicloud.com>, <nphamcs@gmail.com>, <bhe@redhat.com>,
	<zhengqi.arch@bytedance.com>, <terry.bowman@amd.com>
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aZ92AvAg5boiSVw1@lstrano-desk.jf.intel.com>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: c34d67fc-b774-4f5b-9f64-08de74bc4b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|3122999024;
X-Microsoft-Antispam-Message-Info: Z1nP8qxKJKQU5mImEmcwRw45dsmoqsSmFBIKcvErjhp6jbomlhfmlAi6WTCm7xouAH6L+CowyDosGF3istolCYjUyNRcBKaoR6P6Zvt3Kkz8OcqJVQKVr75zgrmfRLsJAtl13yhVD7VCz3xa/vkWcS6XVwAzRQX0ouB3XsJNJpPmwmMXWcPLBItPAXl1dZ/P8GVmoaAW4HsxH4r5agQBI1WIs1+Ai2ujAHnnKhzOJEMpyNSebiJtpm3lbf+hV6FXrtQ5YRMYxr8vJsK6q9LDrF05kBoWYpmyhgCLENpFLAB1S+iEYsbTYMxQlFjT2fXq6HoUcyFI5XR31frX1+VnCFjCiA0ffGn5IlUhgI5otdVR0KbvdZHSifLXDAmLowRgU4DdhT2zi6kYdpQwTLulafeVeTe95WUEuh8RB1jL9MPjhAWC46SZSbKfUmuy/jqbvKNe5wRd4nOVrTgg6ZGgHf4XLaf8MEfx3wXTGqmtmFgXTaUFnwplCM0RVewWORjgXHYvBAeZGwQQEdnchvauuiTDcq5LBBfdSonkYmm+KRdmh/1hue4e1Ndfg36NeKzkNFdprQ018+/PYLQ2JXKhdqvoeX/BcI+JZzeSXbjbvsYXPHvQ5mpR94xWMiBr7UdKkiYl7mWo3J5Y8fATOovL6JLtLEgjsBeSDT/cHlykVIU9+wtqdIz/GsYvydzEp3Wk/cloZPU1mCLduZIms7Dzs9SnQRZdfRaaPDPyHyK+FNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(3122999024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRsdlZBMkdGRGV2NmRmS0wzUXBPa3RDYWk5RVVKbTdtV0JVL3JNRXVrV2Jp?=
 =?utf-8?B?UjgxZEk2anA3MG0vMkY5SGNhV3lRdktodlNTd1ptbWw4QWYxcTJOWExlRGhX?=
 =?utf-8?B?L0xTL3hmTk01WmdJL1BSZVZQZkNkdExuVXQ5Rm9qSnc0dWxGYVpiUlYzTUpT?=
 =?utf-8?B?aGlEbW1iaUN6MjAraTVoQWNPc0hyRlhRWXVxOEVFd1VEelp6dDBHNDl0ZDJN?=
 =?utf-8?B?ZUxVa0tQZzRRdGY0aDNwNnBYWVp2ZU8vaVVJTE9Bd0hhZ1FBV3p4dWlIS3Ro?=
 =?utf-8?B?enl1ZXBnTXFqazhicW0wWjFMMlVoMEZOaitXV2N2ZFpLQm81SFNCZWxJd2Fp?=
 =?utf-8?B?eHpKKzE1Y09WWFpoenNTMDEyYW5pWEl2QkM4T2UyUURhMnc0SGMyek9ESGZC?=
 =?utf-8?B?bDl2dWZBTkhUK20ybEdLdCs1OUZtb1o2M2RuMm5yZ3dZRkhvUm84S01QWTNi?=
 =?utf-8?B?Uk5EVEZKcnFnS0FUTVlDVUd2ZDgzWUpPYmhHV2orSWUraG5NbkxKU1A5WHFl?=
 =?utf-8?B?d0EvTHI3STBnMlVTT0dsZitsQlJodm54aVh1elR1ekx0RkR0T1RUVzBGVEpz?=
 =?utf-8?B?ZytxQ1dwUnV6L0R6bHlBZlkyV1NTdE02V2MxY0NlMDgwV3hxQlRod0lNbVJL?=
 =?utf-8?B?Wm9YSzFHQzFPUjhyOGJzM3ZCZEh4cU92bURKRE9PVEk3TVZNSzlXUHBEbkJI?=
 =?utf-8?B?eWhjM3JoZ2dseU5xRkNoQmxuTVBXUVNYLzRsa1lxT3hWb3ROOE5ISE9jeEtF?=
 =?utf-8?B?U2hOcXYvSG5VTmdJYUw5S2tBQlR5aEYwdEY0cDJCZnQrZEJOaUdSMnZBQUNz?=
 =?utf-8?B?L2xOR3pUR3pyN1NLcHloVkN6VXdkV2d6TTNXWG5KNkd2dTI3dkJCTm5xVjZB?=
 =?utf-8?B?UkdlL3R4cDREMUh0QzFPTS9mVmM2aTdmNk9QYzlsSmFWOUlaOU51L3JCSkJN?=
 =?utf-8?B?NnVWcE81K0phekJCL0FVUUFERWQvU3VKdTlDU1V3MmpidnZPeEpkYnFsMDBO?=
 =?utf-8?B?WFl2eWQvT254UlFxL0RrbDVHU1ZzMVpHMnZ0TEtxZlY4NEdxUTVNakE5RlhO?=
 =?utf-8?B?b0JIN0REdjFrbWFsRFpRanNYeGVISjRlMGJDb1JhRW9RdjV6aHEva3Awalpq?=
 =?utf-8?B?TmdlV3A2cnhkYllXWlExTkd0bE5aZ2dYSWpnT0QxSzVwbU9KazZ0U1NSejFZ?=
 =?utf-8?B?aDZ6WkpwREcza0N3bXlaQzBnU3pXUHZZcFJyZEJkV0pSYlR2UTdTZzZ1Y0Fz?=
 =?utf-8?B?KzJ4SWx3cjF2em44aDZIaXliQ1J3eXUrZU1yNGV1Y1J5ZzMwM1JSWEM1dE9P?=
 =?utf-8?B?eUdHOHp3TlpVemJsMTZucWR4UGN3YXhZQ1RXQlN6dGFwdzRIbk9OWDErTkk0?=
 =?utf-8?B?OUF4WnpTS2IydGkyTk5mc09uK0tsVndYRFpLZWVDekJteXZxZWYwNG9FbS93?=
 =?utf-8?B?NkZ6ZitwemljTFlWRXVsV1NHL2dWT1dxYlhrNi9sZzl3SUJ5T2NmcGlKbm1S?=
 =?utf-8?B?NWp3THZES0xuT1BZWkxhWjlGWG5vTzVjM2hiT0FNRjVmbmVJU3BQRXIwZHFl?=
 =?utf-8?B?QTQ3dzYxS1k5UnVjd2ExOWd3bUNqdnJrcCtiaCtUQW5qU0syMjVQWW1kaFlT?=
 =?utf-8?B?Zy9hTzQzQUhqVmpCWGVrRTBiR204Qkl0aUU0TlowRUJaM3hhenlhMkRnNERj?=
 =?utf-8?B?TytWK0ZyT05CRmsyTnVjZ1lZVWRqQW1XVVRDOVB2b3doUDZ3VE1jZnlENDRB?=
 =?utf-8?B?UkMrTlJpMTBPbE03VU0zMWJSbDVQeUk0TjhFSVBlZEZHZHJ6YjNnQlUwQVE4?=
 =?utf-8?B?anBKY0t0U25kRWNRdVYwTkpjUmZlTzYyTk9zdTFsTWorTlBlMEh4c2ZDL2Rl?=
 =?utf-8?B?NkZjK1oyak00KzY0WmZ3SnRDOWtmOGd5RVZSUXFPQm5FUlZpU1pENFNaVDFJ?=
 =?utf-8?B?S3B6SWNDcmZLcFZWdERJOHRLRnk0SEpYekVzVWtyNDJLUnF3UnY1MmpUNXVt?=
 =?utf-8?B?a2R4YnlZRXRCVVVkRHMweXUvUkUzYXRTcitXZldpRGg4VDJaM0loY250Vjk0?=
 =?utf-8?B?L0xUMHhwYnRHZElTNGpQaCtQVzNSbjVYZ1hjamg1U0lNSXB2WFJvV3RFTjFk?=
 =?utf-8?B?WDFwZThOaGs1RDcvcXJTNVdsZzB6N2x0OUhITllpaHk5UmxiYzNQNndyanp1?=
 =?utf-8?B?OHZnRlJGWGJkVlhNU0ltUEdSRFhrSDM3b0VKV25wa0pQNHdMcVdhZHF4NDk4?=
 =?utf-8?B?dVJZeWEzNnI0SzRUVlFXbTk4bm8zMWxNc3YrSDFBZXpyVURJVCtoUVc3eVp3?=
 =?utf-8?B?YTArWkFxVjlGQnlSYkRtVEFXNDJBdXFFczFaU3FTRzRjSG1scDl3V2xNeW1C?=
 =?utf-8?Q?hMX4LPKX0hqbTqSc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c34d67fc-b774-4f5b-9f64-08de74bc4b87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 22:22:00.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heCi3iTcD1WVJcKiTHFFZ8edMb1HLGbekFVjarbsCMSps++x/ylYj2/4hjUeTw+qo9zWHsT2SLm4KRXf6N6mBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:email,lstrano-desk.jf.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14390-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 475F219E3C6
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:17:38AM -0500, Gregory Price wrote:
> On Tue, Feb 24, 2026 at 05:19:11PM +1100, Alistair Popple wrote:
> > On 2026-02-22 at 19:48 +1100, Gregory Price <gourry@gourry.net> wrote...
> > 
> > Based on our discussion at LPC I believe one of the primary motivators here was
> > to re-use the existing mm buddy allocator rather than writing your own. I remain
> > to be convinced that alone is justification enough for doing all this - DRM for
> > example already has quite a nice standalone buddy allocator (drm_buddy.c) that
> > could presumably be used, or adapted for use, by any device driver.
> >
> > The interesting part of this series (which I have skimmed but not read in
> > detail) is how device memory gets exposed to userspace - this is something that
> > existing ZONE_DEVICE implementations don't address, instead leaving it up to
> > drivers and associated userspace stacks to deal with allocation, migration, etc.
> > 
> 
> I agree that buddy-access alone is insufficient justification, it
> started off that way - but if you want mempolicy/NUMA UAPI access,
> it turns into "Re-use all of MM" - and that means using the buddy.
> 
> I also expected ZONE_DEVICE vs NODE_DATA to be the primary discussion,
> 
> I raise replacing it as a thought experiment, but not the proposal.
> 
> The idea that drm/ is going to switch to private nodes is outside the
> realm of reality, but part of that is because of years of infrastructure
> built on the assumption that re-using mm/ is infeasible.

I was about to chime in with essentially the same comment about DRM.
Switching over to core-managed MM is a massive shift and is likely
infeasible, or so extreme that we’d end up throwing away any the
existing driver and starting from scratch. At least for Xe, our MM code
is baked into all meaningful components of the driver. It’s also a
unified driver that has to work on iGPU, dGPU over PCIe, dGPU over a
coherent bus once we get there, devices with GPU pagefaults, and devices
without GPU pagefaults. It also has to support both 3D and compute
user-space stacks, etc. So requirements of what it needs to support is
quite large.

IIRC, Christian once mentioned that AMD was exploring using NUMA and
udma-buf rather than DRM GEMs for MM on coherent-bus devices. I would
think AMDGPU has nearly all the same requirements as Xe, aside from
supporting both 3D and compute stacks, since AMDKFD currently handles
compute. It might be worth getting Christian’s input on this RFC as he
likely has better insight then myself on DRM's future here.

Matt

> 
> But, lets talk about DEVICE_COHERENT
> 
> ---
> 
> DEVICE_COHERENT is the odd-man out among ZONE_DEVICE modes. The others
> use softleaf entries and don't allow direct mappings.
> 
> (DEVICE_PRIVATE sort of does if you squint, but you can also view that
>  a bit like PROT_NONE or read-only controls to force migrations).
> 
> If you take DEVICE_COHERENT and:
> 
> - Move pgmap out of the struct page (page_ext, NODE_DATA, etc) to free
>   the LRU list_head
> - Put pages in the buddy (free lists, watermarks, managed_pages) or add
>   pgmap->device_alloc() at every allocation callsite / buddy hook
> - Add LRU support (aging, reclaim, compaction)
> - Add isolated gating (new GFP flag and adjusted zonelist filtering)
> - Add new dev_pagemap_ops callbacks for the various mm/ features
> - Audit evey folio_is_zone_device() to distinguish zone device modes
> 
> ... you've built N_MEMORY_PRIVATE inside ZONE_DEVICE. Except now
> page_zone(page) returns ZONE_DEVICE - so you inherit the wrong
> defaults at every existing ZONE_DEVICE check. 
> 
> Skip-sites become things to opt-out of instead of opting into.
> 
> You just end up with
> 
> if (folio_is_zone_device(folio))
>     if (folio_is_my_special_zone_device())
>     else ....
> 
> and this just generalizes to
> 
> if (folio_is_private_managed(folio))
>     folio_managed_my_hooked_operation()
> 
> So you get the same code, but have added more complexity to ZONE_DEVICE.
> 
> I don't think that's needed if we just recognize ZONE is the wrong
> abstraction to be operating on.
> 
> Honestly, even ZONE_MOVABLE becomes pointless with N_MEMORY_PRIVATE
> if you disallow longterm pinning - because the managing service handles
> allocations (it has to inject GFP_PRIVATE to get access) or selectively
> enables the mm/ services it knows are safe (mempolicy).
> 
> Even if you allow longterm pinning, if your service controls what does
> the pinning it can still be reclaimable - just manually (killing
> processes) instead of letting hotplug do it via migration.
> 
> If your service only allocates movable pages - your ZONE_NORMAL is
> effectively ZONE_MOVABLE.  
> 
> In some cases we use ZONE_MOVABLE to prevent the kernel from allocating
> memory onto devices (like CXL).  This means struct page is forced to
> take up DRAM or use memmap_on_memory - meaning you lose high-value
> capacity or sacrifice contiguity (less huge page support).
> 
> This entire problem can evaporate if you can just use ZONE_NORMAL.
> 
> There are a lot of benefits to just re-using the buddy like this.
> 
> Zones are the wrong abstraction and cause more problems.
> 
> > >   free_folio           - mirrors ZONE_DEVICE's
> > >   folio_split          - mirrors ZONE_DEVICE's
> > >   migrate_to           - ... same as ZONE_DEVICE
> > >   handle_fault         - mirrors the ZONE_DEVICE ...
> > >   memory_failure       - parallels memory_failure_dev_pagemap(),
> > 
> > One does not have to squint too hard to see that the above is not so different
> > from what ZONE_DEVICE provides today via dev_pagemap_ops(). So I think I think
> > it would be worth outlining why the existing ZONE_DEVICE mechanism can't be
> > extended to provide these kind of services.
> > 
> > This seems to add a bunch of code just to use NODE_DATA instead of page->pgmap,
> > without really explaining why just extending dev_pagemap_ops wouldn't work. The
> > obvious reason is that if you want to support things like reclaim, compaction,
> > etc. these pages need to be on the LRU, which is a little bit hard when that
> > field is also used by the pgmap pointer for ZONE_DEVICE pages.
> > 
> 
> You don't have to squint because it was deliberate :]
> 
> The callback similarity is the feature - they're the same logical
> operations.  The difference is the direction of the defaults.
> 
> Extending ZONE_DEVICE into these areas requires the same set of hooks,
> plus distinguishing "old ZONE_DEVICE" from "new ZONE_DEVICE".
> 
> Where there are new injection sites, it's because ZONE_DEVICE opts
> out of ever touching that code in some other silently implied way.
> 
> For example, reclaim/compaction doesn't run because ZONE_DEVICE doesn't
> add to managed_pages (among other reasons).
> 
> You'd have to go figure out how to hack those things into ZONE_DEVICE 
> *and then* opt every *other* ZONE_DEVICE mode *back out*.
> 
> So you still end up with something like this anyway:
> 
> static inline bool folio_managed_handle_fault(struct folio *folio,
>                                               struct vm_fault *vmf,
>                                               enum pgtable_level level,
>                                               vm_fault_t *ret)
> {
>         /* Zone device pages use swap entries; handled in do_swap_page */
>         if (folio_is_zone_device(folio))
>                 return false;
> 
>         if (folio_is_private_node(folio))
> 		...
>         return false;
> }
> 
> 
> > example page_ext could be used.  Or I hear struct page may go away in place of
> > folios any day now, so maybe that gives us space for both :-)
> > 
> 
> If NUMA is the interface we want, then NODE_DATA is the right direction
> regardless of struct page's future or what zone it lives in.
> 
> There's no reason to keep per-page pgmap w/ device-to-node mappings.
> 
> You can have one driver manage multiple devices with the same numa node
> if it uses the same owner context (PFN already differentiates devices).
> 
> The existing code allows for this.
> 
> > The above also looks pretty similar to the existing ZONE_DEVICE methods for
> > doing this which is another reason to argue for just building up the feature set
> > of the existing boondoggle rather than adding another thingymebob.
> >
> > It seems the key thing we are looking for is:
> > 
> > 1) A userspace API to allocate/manage device memory (ie. move_pages(), mbind(),
> > etc.)
> > 
> > 2) Allowing reclaim/LRU list processing of device memory.
> > 
> > From my perspective both of these are interesting and I look forward to the
> > discussion (hopefully I can make it to LSFMM). Mostly I'm interested in the
> > implementation as this does on the surface seem to sprinkle around and duplicate
> > a lot of hooks similar to what ZONE_DEVICE already provides.
> > 
> 
> On (1): ZONE_DEVICE NUMA UAPI is harder than it looks from the surface
> 
> Much of the kernel mm/ infrastructure is written on top of the buddy and
> expects N_MEMORY to be the sole arbiter of "Where to Acquire Pages".
> 
> Mempolicy depends on:
>    - Buddy support or a new alloc hook around the buddy
> 
>    - Migration support (mbind() after allocation migrates)
>      - Migration also deeply assumes buddy and LRU support
> 
>    - Changing validations on node states
>      - mempolicy checks N_MEMORY membership, so you have to hack
>        N_MEMORY onto ZONE_DEVICE
>        (or teach it about a new node state... N_MEMORY_PRIVATE)
> 
> 
> Getting mempolicy to work with N_MEMORY_PRIVATE amounts to adding 2
> lines of code in vma_alloc_folio_noprof:
> 
> struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
>                                      struct vm_area_struct *vma,
> 				     unsigned long addr)
> {
>         if (pol->flags & MPOL_F_PRIVATE)
>                 gfp |= __GFP_PRIVATE;
> 
>         folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
> 	/* Woo! I faulted a DEVICE PAGE! */
> }
> 
> But this requires the pages to be managed by the buddy.
> 
> The rest of the mempolicy support is around keeping sane nodemasks when
> things like cpuset.mems rebinds occur and validating you don't end up
> with private nodes that don't support mempolicy in your nodemask.
> 
> You have to do all of this anyway, but with the added bonus of fighting
> with the overloaded nature of ZONE_DEVICE at every step.
> 
> ==========
> 
> On (2): Assume you solve LRU. 
> 
> Zone Device has no free lists, managed_pages, or watermarks.
> 
> kswapd can't run, compaction has no targets, vmscan's pressure model
> doesn't function.  These all come for free when the pages are
> buddy-managed on a real zone.  Why re-invent the wheel?
> 
> ==========
> 
> So you really have two options here:
> 
> a) Put pages in the buddy, or
> 
> b) Add pgmap->device_alloc() callbacks at every allocation site that
>    could target a node:
>      - vma_alloc_folio
>      - alloc_migration_target
>      - alloc_demote_folio
>      - alloc_pages_node
>      - alloc_contig_pages
>      - list goes on
> 
> Or more likely - hooking get_page_from_freelist.  Which at that
> point... just use the buddy?  You're already deep in the hot path.
> 
> > 
> > For basic allocation I agree this is the case. But there's no reason some device
> > allocator library couldn't be written. Or in fact as pointed out above reuse the
> > already existing one in drm_buddy.c.  So would be interested to hear arguments
> > for why allocation has to be done by the mm allocator and/or why an allocation
> > library wouldn't work here given DRM already has them.
> > 
> 
> Using the buddy underpins the rest of mm/ services we want to re-use.
> 
> That's basically it.  Otherwise you have to inject hooks into every
> surface that touches the buddy...
> 
> ... or in the buddy (get_page_from_freelist), at which point why not
> just use the buddy?
> 
> ~Gregory

