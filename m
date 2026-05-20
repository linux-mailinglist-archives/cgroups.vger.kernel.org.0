Return-Path: <cgroups+bounces-16102-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKh/Le0fDWoutgUAu9opvQ
	(envelope-from <cgroups+bounces-16102-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 04:43:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC04586EB5
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 04:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF26A304A61E
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554530C35C;
	Wed, 20 May 2026 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAVozVwy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E791A9F97;
	Wed, 20 May 2026 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245034; cv=fail; b=SzUsQPsMy5hLsL4c8grTx0vWBa6XvtlPKzWwTG2lkboq5fCeCWFrm7J393qt6apG9ITH5BRYi7IlhLoJTKpCorMCDmLfzJwnFL3MO8Fo0c3gebD22czGL40H0SS+O6ER1CvxDbD7lSre+ZHG7vxMR5Be7tbGT7415AknTYdjYtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245034; c=relaxed/simple;
	bh=c4CSALlocZgP/vC43MXQ0kasj9IJOG+OTnxiHu86IjE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PSLdhQyiG7kd4Hyvjyu78l64gWJYgSZ/cQhX7FoK9HEDRxBZYf+kqQhrN/xrBAnyWpyEheCyAICDjg8x0dVAQKsObvZpAWg88WYjExP3pdgwCMuHS/XcMMc1g4lJlL5f+v7YJmIiutabykIu6h4R8AS0GK5RQj2EV/tSx0XVL6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAVozVwy; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779245029; x=1810781029;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=c4CSALlocZgP/vC43MXQ0kasj9IJOG+OTnxiHu86IjE=;
  b=eAVozVwyQIFHMmetTfN8Ed6TbcioNKBEDm1aOgbAUOm3F/Dho5wspBgg
   OMJTcfK1DXroB0yL+HsFQtL5wDzj7dkNlsE/vA+rrWALayy6Eq6hg6mb+
   iTFrzKQtPNya2RwG+7RNpZpL6CLnP6tehCIW4B4FJ4IUFuZuYpyBS/8Ep
   FLD84fkDoakE1G+nlwevtsk6cs1WzGIVuoAjkUKz+K5aTjc6NGUy4onfi
   BsRUcBNLU5dSc7UM8dWE9dL7oeCIWAtNW/kQIISb0N4WNRb7rOGjGV2/J
   F+yOdiXw6U36c2o50CUX+ZIQoJyMBBU0DwQwzWJs7r/RWrACjCbkujyZV
   g==;
X-CSE-ConnectionGUID: RmWrEmh2TnCL42YOoGDA2Q==
X-CSE-MsgGUID: qjfODV8ESVuLoc9K8kogCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="67661148"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="67661148"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:43:48 -0700
X-CSE-ConnectionGUID: 8+qzW4ctSMOA8mhH2NBvmA==
X-CSE-MsgGUID: Swav/iOQRry8y5TSg8xQiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235552820"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:43:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:43:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 19:43:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO9QOGv5oNjmt5bK9IlYCy/Qe0UiSXmN6bzZFXw0MfGecaQDRM1xtyta5iUuBSsQ7+wCNyjOp7E5ekRGIM6We8mRkadjGH5+zH/EzkxF4UVAdd0ztcbL04geS4vtl1BSh8R8ESFiaQct0QE0eE1eEOtI5whDpZf/UN3Pp9MFRXmC/Idjgf9+5NElQWrcYGuDGUZUTPYB0Zoz/LuLQBBoJbgLLpHl7cAq7u/OCBoW1I5nXbPWXc9n6DNcIwjzvVdV0KghUPduL+f0lu49bg1htlonyjVKR2camca3kMl5s+wLFqp2Gm0m7ozKS+j34IntDUROENMcwH7+ryB23Ud3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBU06ZtEHbEd0VYSwfrPXHst8RcH73kcz9tExAykIOw=;
 b=Vd+eVgWUUUaaqyEtekEdCEZAx1PMbN1OYv/6eyW4LQfu1IIbL/UTGgRpp2P39GKKnim2NjvuqyXZCt5Z22SSL10fN1Fag/LTw8L8b/fnDs+pI3AtMz6Jst51wjT6Tbxp0oi4/DmvP1wFKF8L2KBnZHmsm7B4jtcGf/otogUhv2FB7goIqZG7wH7eExuOWm2TflJJaHA2XcvRfVx9rVLXc1dNviQQVB1WIpfCsBm+6K1hbB8a6dx7F5i2gIs0Sia/0ebMN5xRaTLQRBWFHNC6kWC1eOB28sxXmaEmEYjlTkpkhOeyTvqzlW0KbXcBzbku2ftHiuoA8v/8PyuRsZzldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:43:36 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0025.020; Wed, 20 May 2026
 02:43:36 +0000
Date: Wed, 20 May 2026 10:43:22 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: Qi Zheng <qi.zheng@linux.dev>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	David Carlier <devnexen@gmail.com>, Allen Pais <apais@linux.microsoft.com>,
	Axel Rasmussen <axelrasmussen@google.com>, Baoquan He <bhe@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, Chen Ridong
	<chenridong@huawei.com>, David Hildenbrand <david@kernel.org>, Hamza Mahfooz
	<hamzamahfooz@linux.microsoft.com>, Harry Yoo <harry.yoo@oracle.com>, "Hugh
 Dickins" <hughd@google.com>, Imran Khan <imran.f.khan@oracle.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Lance Yang <lance.yang@linux.dev>, Liam Howlett <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Michal
 =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Mike Rapoport
	<rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, Muchun Song
	<songmuchun@bytedance.com>, Nhat Pham <nphamcs@gmail.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, "Usama
 Arif" <usamaarif642@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, Wei Xu
	<weixugc@google.com>, Yosry Ahmed <yosry@kernel.org>, Yuanchu Xie
	<yuanchu@google.com>, Zi Yan <ziy@nvidia.com>, Usama Arif
	<usama.arif@linux.dev>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [mm] 01b9da291c: stress-ng.switch.ops_per_sec
 67.7% regression
Message-ID: <ag0fyi8GjHHf8bdC@xsang-OptiPlex-9020>
References: <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
 <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
 <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
 <agdS5rIhcjIBVSog@linux.dev>
 <agm61hMv08XnV8sI@xsang-OptiPlex-9020>
 <agoYp1zW9afZ6uQz@linux.dev>
 <agtATZG9mIlYzMUl@linux.dev>
 <agtPMpQK2jXdQAY4@linux.dev>
 <agvvRNJTAtNkCVZc@xsang-OptiPlex-9020>
 <agxxuHOfNLX-32kI@linux.dev>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agxxuHOfNLX-32kI@linux.dev>
X-ClientProxiedBy: TPYP295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::13) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f864e89-950b-449f-ec0b-08deb61996d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|22082099003|18002099003|11063799006|56012099003|3023799007;
X-Microsoft-Antispam-Message-Info: iCYLIfcEC4h/e+oG1xJIFAehuydy/SYUI2ltSYUplza+WCyVgEOQeMtqdxY6iYPJ/ui4ZHMgEzdk+KmOZ9103hvwfs/5qJTk4bRgunQTC+JZ0EwdfhftEDN0l1N0+GrUESOBkKOQs8Ka2Dgg2sBuZvF934hd4jj8sZ/XfGQYwrTV5HhbrQvuOKpxrsSpbkm+AFFyAnaBdLsSNDtkQJ+B3BB9FA6wMp4HLnUA9cbayBSIaqCrhUFHlEWseKl8jkhiYqeZ0sfDUbZuYJiR2ShXrIwYfvUb4a5GQlSfXHJCj9CaTA9v4Ham5W/MOv7iYC6/QPTTJOQuPvv7o1LGmeJ1V9K+NxrFfPQvu5j6nvLYPVcnVtZDL/KeEw1B7/Gtf/lnQHacC8rfvSOeQSZ/4nFEOSxCBUGm3rlmT8BAuyaeVY5wEGKoukTYBOLkTfJ0GnOZaElcS9+MY8x6DU7lR1MjHwwuI1aUIZY09x5pn0dVnjkK3x1ppISJE+XBWP+1rYx2bSwknwgbwKfWDclhAw52fmPaAL/C+/M3YMpg2TGWZm8QG7vSAIUK4FyqzKdwKAp3uup0y+ikGRtGcNQeFmQ9lB026CjPzu0Kn4gfxgHB/YX6JRSn9eCfmea3wzERfqhk5DqK+lEDwDwisaLAC648OryLpXscm+zhlECV8j2OnO+vDQDjWDeYz6HCrlQl8g0Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(22082099003)(18002099003)(11063799006)(56012099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?b1StIFvThNWyoOZg3SK/iaH48EboB5Pe+kePuhAOqDMXLqYH0m7/2xV+tN?=
 =?iso-8859-1?Q?IY01d5dlZdOBlwBBOeupqKLmUgh7brQ6kHdr1fk6UKOfV9CGpFjd5wa4D1?=
 =?iso-8859-1?Q?vHKWP8D1RpmJw61EMHqbbjGSreSL9SnGh3E7h4xl+VEfAaOL6An7ymxurT?=
 =?iso-8859-1?Q?J1KHOtz1aamVGGFiC46jl83KVWHl1WsKRGEsJKocin815pjR62uCw3D0R0?=
 =?iso-8859-1?Q?asvyemNoYJZ8Z5MUT4PzZpPMbqaQoEfiEOn7yhzPhd4UOu+JWZbxqLVmkd?=
 =?iso-8859-1?Q?b9/HhiuvQvk2we6GEzObMMQnWgud2QzLJY40279C6f8rg+3aIOugeMYfWM?=
 =?iso-8859-1?Q?vbSPgk/TXpkx/hTDBtKtXphnhVXH2FYEpQQOi1/er4XIFXoKM2UunYtrgp?=
 =?iso-8859-1?Q?S6JcetRRjdYwqz7jaTnMF16kLT+S2JReI6o1GvVDfKpcHT84z5mzeaEN9H?=
 =?iso-8859-1?Q?cwaLTDtNcvX+jZI54j7oiyEaBS8yrwwA/tvB0otdHXY0b3xuMu7+Bt3uRh?=
 =?iso-8859-1?Q?uNJKttSEQGEudtORpPE9bCOq/HkEwxz5wF2E+MDu3DG1aq3EgtBHbr2YKV?=
 =?iso-8859-1?Q?y7CtdAoDcM/KaS9VNfn1/3Zu5VHK2e4+OxKwr+d5TRo8qees+HzGwBtOt4?=
 =?iso-8859-1?Q?pmrHCf3V9EvwtcBw7t2n2ORv3pvcS43JFHfQ0iuTIyZHpNbNN7LZyKxBeM?=
 =?iso-8859-1?Q?GXgtxjgeI9yws9mXMTLNDL6MVuskX0FsnStV2eJ8lxqt+Ry5IwYb1Q493z?=
 =?iso-8859-1?Q?hBi/pstv/r0pPppUgiYSgph8FkHy6xwEGGTi9HwcF0x3m+4/qY1cTMPUJc?=
 =?iso-8859-1?Q?3t45Mhl21KKbqT+/cJ+hiBSNOYbhlbZXynsa+wz7R1oNHosTU4QPKH7Ri6?=
 =?iso-8859-1?Q?7I21HeesFYAejKAcP1vCSwYfff26sQEh5DSxx5ipQ1BR2y9JfOyBFiM5aZ?=
 =?iso-8859-1?Q?8hq8iW59/6JYNTrXHcXGWQpJPvJ+S8Bf/QehPavzuMf7Hj9nk8TH+vybQk?=
 =?iso-8859-1?Q?ryDP/dqGijuGAfgBrW4VUXhUw2ZjRNcUYKeU5QhkTbbur7H06fNBbMB0d6?=
 =?iso-8859-1?Q?kfGpQ/bhATD0zjospKm4tvA6nRuiVApBKK9GsmAUOem5nwsKsqm0C4XhLY?=
 =?iso-8859-1?Q?wytm0ZbNYDxm60ZW3x9PuFd3o9MzpqYSghZbQfvk1Kc9GOOcA2MQjniwR8?=
 =?iso-8859-1?Q?AC5ACdjzJU9zMsVXF+7g2N4RZeCvqaxseiYEW+whS5mjB7MopRxPQAl0Az?=
 =?iso-8859-1?Q?hlL4o++689eZOX9gGLOop7SNQUO3BH3suyO0iMdaVdupGkJE5rJkKxP3GU?=
 =?iso-8859-1?Q?LKC9AjZJj30Ka38TR7S403/wiYithq0Mp3V7bo0jmwBLQc6AkrWoZjhyqH?=
 =?iso-8859-1?Q?qpnrzQEX7JJ2w/P50LlQupetTzam8ZtwKTiXBN99tpa2ur6fCfhhELG13P?=
 =?iso-8859-1?Q?qJ6xoXAxhPJ5IWDjR9H1TEaL2DHhw+s6f5HJSHBr6G1yhHs++VDCkXNmjV?=
 =?iso-8859-1?Q?wJjePEJ1Ntocbfb8/6pTr8bOZSbVw02HoIF1n5xo1n3cMYr3/f6CLDbGcN?=
 =?iso-8859-1?Q?PBBXo2YfFYOUQnvcVG8x70AQ0qemZsu6jegZGBTCbdlpUSS2hFV5zbdrtb?=
 =?iso-8859-1?Q?KVQXs1kLhLyTvTJ6C1O61mb0FMS1LYl4CblZ5KNOXdRv2dkkNab7STS7kI?=
 =?iso-8859-1?Q?NZ6Vt2El9lN9jSDyaoEARWgPDMW8E2VbohTrC7NLdzMgp9Otvyv0iqkg30?=
 =?iso-8859-1?Q?nSykG0JsX59Hp77n+w8NgaH8BEUHQ/gbVzDthu/aeXiNaeLJ0Aat3qFT6Q?=
 =?iso-8859-1?Q?79x6BKI1NA=3D=3D?=
X-Exchange-RoutingPolicyChecked: r6uabdz6BFWH5aYew88y1kv+QYDXJFFoLd8u4xM2jd1jNsfg2dbCjs84kocQ3ykrI1w4hqCxjsgFGqGVkeo8pYKdp58GaJzfYLTM6QvnX9rYVJBVBmT3iMpj1VWj4GjmsU4ncK+n6RziY+zw+ywg3FYy5kPf/Tp2muCWwxcEpbz+aX/HWh7ftkrck9HjKIFCemGrQFRxqe6xjRrcpVwiSo1gVn622eJjE45btqYsjNh3z9aJPWpwO9XEzI05putgA7MHfDrLMQZJfITh4qC6NxV/v7V0hAI8rcuSi2HgvYzwqzaZTYaHpGMD2gotK1ap/j00OoJGIzjT8zcb8Sbjnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f864e89-950b-449f-ec0b-08deb61996d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:43:35.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FXNzJzqC4Zg7hn9tZBcxx1946bl7mBBMh9jnak/dUMPcgvRkVK58SlcPrOSfSJtnkaYxB3KHXY8rWLcZM7sRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16102-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:dkim,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1DC04586EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hi, Shakeel,

On Tue, May 19, 2026 at 07:22:52AM -0700, Shakeel Butt wrote:
> Hi Oliver,
> 

[...]

> 
> > > > 
> > > > Also I am rethinking the approach, so I will send a prototype in response on
> > > > this email for which I will need your help in testing.
> > > 
> > > Hi Oliver, can you please test the following patch?
> > 
> > got it. will change to test following patch. and this looks quite different
> > with v2 or v3, so if you still want us to test v3, please let me know. thanks!
> > 
> 
> No need to test v3 as it is similar to v2. Please test the following patch as it
> is a direction I want to pursue and wanted an early signal if this is the right
> direction.

FYI. in our tests, the following patch also recovers the regresion.

Tested-by: kernel test robot <oliver.sang@intel.com>

=========================================================================================
compiler/cpufreq_governor/kconfig/method/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/mq/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/switch/stress-ng/60s

commit: 
  8285917d6f ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
  01b9da291c ("mm: memcontrol: convert objcg to be per-memcg per-node type")
  542b7317fe ("memcg: shrink obj_stock_pcp and cache multiple objcgs")

8285917d6f383aef 01b9da291c4969354807b52956f 542b7317fe304742e79a9a2215e
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      5849          +210.2%      18145 ±  3%      +1.7%       5949        stress-ng.switch.nanosecs_per_context_switch_mq_method
 2.296e+09           -67.7%  7.408e+08 ±  3%      -1.7%  2.257e+09        stress-ng.switch.ops
  38288993           -67.7%   12355813 ±  3%      -1.7%   37646995        stress-ng.switch.ops_per_sec
  93416932           -68.6%   29310048 ±  3%      -0.7%   92764788        stress-ng.time.involuntary_context_switches
     15845           +11.0%      17584            +0.2%      15882        stress-ng.time.percent_of_cpu_this_job_got
      8556           +18.2%      10115            +0.4%       8589        stress-ng.time.system_time
    963.36           -53.5%     447.72 ±  3%      -1.1%     952.66        stress-ng.time.user_time
 1.518e+09           -69.7%  4.607e+08 ±  2%      -1.6%  1.494e+09        stress-ng.time.voluntary_context_switches
      1124 ± 17%     +34.3%       1509 ±  8%      -4.0%       1079 ± 27%  perf-c2c.HITM.remote
  2.55e+09           -12.3%  2.236e+09 ±  3%      +5.3%  2.685e+09 ±  6%  cpuidle..time
  8.29e+08           -71.8%  2.337e+08 ±  2%      -2.1%   8.12e+08        cpuidle..usage
  14184409 ±  2%     -16.4%   11860068            +0.5%   14258186        vmstat.memory.cache
  39204964           -69.7%   11868752 ±  2%      -2.9%   38078258        vmstat.system.cs
   1808848           -38.5%    1111830            -0.6%    1798192        vmstat.system.in
    389109 ± 23%     -20.4%     309611 ± 49%     +27.8%     497404 ±  8%  numa-numastat.node0.local_node
    504867 ±  9%     -13.8%     435237 ± 27%     +23.0%     621221 ± 10%  numa-numastat.node0.numa_hit
   4102960 ±  5%     -19.0%    3324393 ±  4%      -2.5%    3998654        numa-numastat.node1.local_node
   4218983 ±  3%     -18.7%    3430325 ±  3%      -2.6%    4107779 ±  2%  numa-numastat.node1.numa_hit
  93416932           -68.6%   29310048 ±  3%      -0.7%   92764788        time.involuntary_context_switches
     15845           +11.0%      17584            +0.2%      15882        time.percent_of_cpu_this_job_got
      8556           +18.2%      10115            +0.4%       8589        time.system_time
    963.36           -53.5%     447.72 ±  3%      -1.1%     952.66        time.user_time
 1.518e+09           -69.7%  4.607e+08 ±  2%      -1.6%  1.494e+09        time.voluntary_context_switches
     22.48            -4.4       18.08            +0.5       22.97 ±  4%  mpstat.cpu.all.idle%
      1.13            -0.4        0.73            -0.0        1.12        mpstat.cpu.all.irq%
      0.10            -0.0        0.09            -0.0        0.09        mpstat.cpu.all.soft%
     67.98            +9.1       77.06            -0.3       67.69        mpstat.cpu.all.sys%
      8.32            -4.3        4.04 ±  2%      -0.2        8.14        mpstat.cpu.all.usr%
     17.33 ±  2%     +15.4%      20.00 ±  4%      +2.4%      17.75 ±  4%  mpstat.max_utilization.seconds
  10939677 ±  2%     -21.0%    8641166            +0.8%   11022621 ±  2%  meminfo.Active
  10939661 ±  2%     -21.0%    8641149            +0.8%   11022605 ±  2%  meminfo.Active(anon)
  13917673 ±  2%     -16.4%   11633722            +0.6%   14000937        meminfo.Cached
  14400924 ±  2%     -16.0%   12102150            +0.3%   14443477        meminfo.Committed_AS
   8394752 ±  5%     +16.7%    9796949 ±  8%     +10.4%    9266688 ±  5%  meminfo.DirectMap2M
    617671           -12.0%     543559            +3.0%     636127 ±  3%  meminfo.Mapped
  18364992           -12.5%   16065468            +0.3%   18427193        meminfo.Memused
  10124702 ±  2%     -22.6%    7839682            +0.8%   10208910 ±  2%  meminfo.Shmem
  18393665           -12.5%   16100473            +0.4%   18462892        meminfo.max_used_kB
     60023 ± 85%     +48.1%      88868 ±  8%    +103.5%     122159 ± 17%  numa-meminfo.node0.Mapped
   1370772 ±124%    +153.5%    3474876          +175.9%    3782461        numa-meminfo.node0.Unevictable
  10552401 ±  4%     -23.3%    8092823            +1.9%   10752961        numa-meminfo.node1.Active
  10552392 ±  4%     -23.3%    8092820            +1.9%   10752957        numa-meminfo.node1.Active(anon)
     89021 ± 81%      -1.6%      87590 ± 71%    +108.4%     185539 ±  2%  numa-meminfo.node1.AnonHugePages
  12454155 ± 15%     -34.9%    8106052           -18.8%   10108844 ±  2%  numa-meminfo.node1.FilePages
     20917 ±  9%      -3.6%      20156 ±  9%      +8.5%      22693 ±  6%  numa-meminfo.node1.KernelStack
    559046 ±  8%     -19.2%     451929 ±  2%      -7.8%     515612 ±  4%  numa-meminfo.node1.Mapped
  14688311 ± 13%     -30.0%   10285394 ±  2%     -15.7%   12377651 ±  3%  numa-meminfo.node1.MemUsed
  10028979 ±  3%     -22.4%    7783864            +0.7%   10096369 ±  2%  numa-meminfo.node1.Shmem
   2425126 ± 70%     -86.7%     322088           -99.5%      12421 ±122%  numa-meminfo.node1.Unevictable
     10.59            -7.6        2.97 ±  8%      +0.1       10.69        turbostat.C1%
      0.85 ±  3%      +9.1        9.96 ±  2%      +0.0        0.87 ±  3%  turbostat.C1E%
      1.29 ±  6%     +19.4%       1.54 ±  2%      -1.4%       1.27 ± 16%  turbostat.CPU%c1
     48.67 ±  2%     -15.1%      41.33 ±  3%      -4.5%      46.50 ±  2%  turbostat.CoreTmp
      0.56           -60.7%       0.22 ±  3%      +0.9%       0.56        turbostat.IPC
 1.153e+08           -38.7%   70680365            +0.6%   1.16e+08        turbostat.IRQ
  10242404           -14.8%    8723704            -0.3%   10215225        turbostat.NMI
     88.65           -84.0        4.67 ± 33%      -2.9       85.77 ±  2%  turbostat.PKG_%
      3.82            -3.8        0.04 ± 10%      -0.2        3.60 ±  2%  turbostat.POLL%
     48.67 ±  2%     -13.7%      42.00 ±  3%      -4.5%      46.50 ±  2%  turbostat.PkgTmp
    683.77           -13.1%     594.00            -0.2%     682.36        turbostat.PkgWatt
     18.74            -3.3%      18.13            -0.6%      18.62        turbostat.RAMWatt
   2735312 ±  2%     -21.0%    2160742            +0.8%    2756101 ±  2%  proc-vmstat.nr_active_anon
    204708            -1.6%     201435            -0.1%     204540        proc-vmstat.nr_anon_pages
   3479812 ±  2%     -16.4%    2908863            +0.6%    3500665        proc-vmstat.nr_file_pages
    154477           -12.0%     135959            +3.0%     159129 ±  3%  proc-vmstat.nr_mapped
   2531568 ±  2%     -22.6%    1960353            +0.8%    2552660 ±  2%  proc-vmstat.nr_shmem
     42010            -3.5%      40543            +0.7%      42288        proc-vmstat.nr_slab_reclaimable
   2735312 ±  2%     -21.0%    2160742            +0.8%    2756101 ±  2%  proc-vmstat.nr_zone_active_anon
    210167 ±  5%     -11.5%     185950 ± 11%      -6.6%     196220 ±  5%  proc-vmstat.numa_hint_faults
   4730338 ±  2%     -18.2%    3871343            +0.1%    4733860        proc-vmstat.numa_hit
   4498551 ±  2%     -19.1%    3639783            +0.1%    4500902 ±  2%  proc-vmstat.numa_local
   4808959 ±  2%     -17.8%    3954157            -0.3%    4796169        proc-vmstat.pgalloc_normal
    806619            -5.1%     765525 ±  2%      +1.1%     815650 ±  2%  proc-vmstat.pgfault
     34098 ±  3%     -14.8%      29054            +0.7%      34328 ±  8%  proc-vmstat.pgreuse
     15033 ± 85%     +47.8%      22227 ±  8%    +103.3%      30562 ± 17%  numa-vmstat.node0.nr_mapped
    342693 ±124%    +153.5%     868719          +175.9%     945615        numa-vmstat.node0.nr_unevictable
    342693 ±124%    +153.5%     868719          +175.9%     945615        numa-vmstat.node0.nr_zone_unevictable
    505319 ±  9%     -14.0%     434390 ± 27%     +23.1%     622018 ± 10%  numa-vmstat.node0.numa_hit
    389561 ± 23%     -20.7%     308764 ± 50%     +27.9%     498200 ±  8%  numa-vmstat.node0.numa_local
   2638537 ±  4%     -23.3%    2022639            +1.9%    2688595        numa-vmstat.node1.nr_active_anon
   3113944 ± 15%     -34.9%    2025946           -18.8%    2527547 ±  2%  numa-vmstat.node1.nr_file_pages
     20917 ±  9%      -3.6%      20157 ±  9%      +8.5%      22691 ±  6%  numa-vmstat.node1.nr_kernel_stack
    139848 ±  9%     -19.3%     112912 ±  2%      -7.8%     128986 ±  4%  numa-vmstat.node1.nr_mapped
   2507650 ±  3%     -22.4%    1945399            +0.7%    2524428 ±  2%  numa-vmstat.node1.nr_shmem
    606281 ± 70%     -86.7%      80522           -99.5%       3105 ±122%  numa-vmstat.node1.nr_unevictable
   2638531 ±  4%     -23.3%    2022634            +1.9%    2688587        numa-vmstat.node1.nr_zone_active_anon
    606281 ± 70%     -86.7%      80522           -99.5%       3105 ±122%  numa-vmstat.node1.nr_zone_unevictable
   4219206 ±  3%     -18.7%    3430093 ±  3%      -2.6%    4108044 ±  2%  numa-vmstat.node1.numa_hit
   4103183 ±  4%     -19.0%    3324161 ±  4%      -2.5%    3998968        numa-vmstat.node1.numa_local
      0.11           +59.9%       0.17 ±  3%      -0.9%       0.11 ±  2%  perf-stat.i.MPKI
 6.653e+10           -61.7%  2.546e+10 ±  2%      +0.2%  6.669e+10        perf-stat.i.branch-instructions
      0.76            +0.1        0.89            +0.1        0.82        perf-stat.i.branch-miss-rate%
 4.685e+08           -59.7%  1.888e+08 ±  2%      +8.4%  5.079e+08        perf-stat.i.branch-misses
      1.12            +0.6        1.76 ±  3%      +0.0        1.13 ±  3%  perf-stat.i.cache-miss-rate%
  35553724 ±  3%     -40.4%   21188697            -0.8%   35253639 ±  2%  perf-stat.i.cache-misses
 4.194e+09           -68.3%  1.331e+09 ±  2%      -1.6%  4.129e+09        perf-stat.i.cache-references
  40710745           -69.6%   12395879 ±  2%      -1.5%   40099753        perf-stat.i.context-switches
      1.84          +189.1%       5.31 ±  2%      -0.5%       1.83        perf-stat.i.cpi
 5.965e+11            -2.0%  5.848e+11            -0.2%  5.956e+11        perf-stat.i.cpu-cycles
   8813175           -64.5%    3125097 ±  2%      -1.3%    8695118        perf-stat.i.cpu-migrations
     24447 ±  3%     +68.5%      41184 ±  2%      -0.4%      24353        perf-stat.i.cycles-between-cache-misses
 3.374e+11           -61.8%  1.287e+11 ±  2%      +0.1%  3.377e+11        perf-stat.i.instructions
      0.57           -60.8%       0.22 ±  2%      +0.3%       0.57        perf-stat.i.ipc
    221.10           -68.6%      69.32 ±  2%      -1.5%     217.85        perf-stat.i.metric.K/sec
     11782 ±  3%      -6.1%      11068 ±  3%      -2.7%      11463 ±  2%  perf-stat.i.minor-faults
     11782 ±  3%      -6.1%      11068 ±  3%      -2.7%      11463 ±  2%  perf-stat.i.page-faults
      0.10 ±  2%     +59.2%       0.17 ±  3%      -0.8%       0.10        perf-stat.overall.MPKI
      0.71            +0.0        0.75            +0.1        0.77        perf-stat.overall.branch-miss-rate%
      0.83 ±  3%      +0.7        1.56 ±  3%      +0.0        0.83        perf-stat.overall.cache-miss-rate%
      1.78          +162.2%       4.67 ±  2%      -0.4%       1.78        perf-stat.overall.cpi
     17181 ±  3%     +64.6%      28283            +0.4%      17248        perf-stat.overall.cycles-between-cache-misses
      0.56           -61.8%       0.21 ±  2%      +0.4%       0.56        perf-stat.overall.ipc
 6.388e+10           -62.3%  2.409e+10 ±  2%      +0.8%  6.439e+10        perf-stat.ps.branch-instructions
 4.538e+08           -60.0%  1.817e+08 ±  2%      +8.9%  4.941e+08        perf-stat.ps.branch-misses
  33674051 ±  3%     -40.1%   20155290            -0.2%   33597494        perf-stat.ps.cache-misses
 4.077e+09           -68.2%  1.296e+09 ±  2%      -1.2%  4.027e+09        perf-stat.ps.cache-references
  39570629           -69.5%   12072702 ±  2%      -1.2%   39106938        perf-stat.ps.context-switches
  5.78e+11            -1.4%    5.7e+11            +0.2%  5.793e+11        perf-stat.ps.cpu-cycles
   8584979           -64.5%    3051930 ±  2%      -1.0%    8495000        perf-stat.ps.cpu-migrations
 3.243e+11           -62.4%   1.22e+11 ±  2%      +0.6%  3.264e+11        perf-stat.ps.instructions
     11022 ±  4%      -6.5%      10300 ±  3%      -1.8%      10820        perf-stat.ps.minor-faults
     11022 ±  4%      -6.5%      10300 ±  3%      -1.8%      10821        perf-stat.ps.page-faults
 1.941e+13           -61.9%  7.405e+12 ±  3%      +2.3%  1.986e+13 ±  2%  perf-stat.total.instructions
     18451            +9.9%      20272            -0.5%      18360        sched_debug.cfs_rq:/.avg_vruntime.avg
      5869 ±  4%      -7.4%       5437 ±  5%     -10.1%       5278 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.68 ±  2%     -12.9%       0.59 ±  3%      -2.7%       0.66 ±  4%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.62 ±  6%     -12.9%       0.54 ±  2%      -3.3%       0.60 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      8469           +12.7%       9544 ±  2%      +1.3%       8581 ±  3%  sched_debug.cfs_rq:/.left_deadline.stddev
      8467           +12.7%       9542 ±  2%      +1.3%       8579 ±  3%  sched_debug.cfs_rq:/.left_vruntime.stddev
   3513124 ± 25%     -30.0%    2459550 ± 10%     -13.8%    3028548 ± 14%  sched_debug.cfs_rq:/.load.max
    588329 ±  5%     -11.2%     522578 ±  5%      +0.6%     591849 ±  3%  sched_debug.cfs_rq:/.load.stddev
     50699 ± 17%     -19.8%      40655 ±  7%     -24.8%      38144 ±  5%  sched_debug.cfs_rq:/.load_avg.max
      7968 ± 26%      -9.9%       7176 ± 15%     -30.7%       5519 ±  9%  sched_debug.cfs_rq:/.load_avg.stddev
      0.68 ±  2%     -12.9%       0.59 ±  3%      -2.8%       0.66 ±  4%  sched_debug.cfs_rq:/.nr_queued.stddev
     38.80 ± 32%    +108.5%      80.90 ± 16%     -14.7%      33.09 ± 15%  sched_debug.cfs_rq:/.removed.load_avg.avg
    857.83 ± 12%     +61.0%       1381 ± 12%      +1.4%     870.00 ± 17%  sched_debug.cfs_rq:/.removed.load_avg.max
    152.02 ± 18%     +57.2%     239.02 ± 11%      -8.0%     139.91 ±  8%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     26.08 ± 28%    +143.0%      63.37 ± 14%      -6.3%      24.43 ± 18%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    547.00 ± 13%     +88.7%       1032 ± 12%      +2.7%     561.75 ± 22%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     94.86 ± 17%     +84.3%     174.82 ±  9%      -2.9%      92.15 ±  9%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      9.09 ± 52%    +253.3%      32.11 ± 17%     -34.3%       5.97 ± 15%  sched_debug.cfs_rq:/.removed.util_avg.avg
    275.17 ±  3%    +130.3%     633.67 ±  9%      +0.5%     276.62        sched_debug.cfs_rq:/.removed.util_avg.max
     44.90 ± 30%    +126.4%     101.66 ± 11%     -13.2%      38.95 ±  8%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      8467           +12.7%       9542 ±  2%      +1.3%       8579 ±  3%  sched_debug.cfs_rq:/.right_vruntime.stddev
    659.63 ±  3%     +13.0%     745.47            -1.3%     651.21        sched_debug.cfs_rq:/.runnable_avg.avg
    271.34 ±  2%     +31.2%     355.98 ±  3%      -3.1%     262.84 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
      0.00 ± 26%    +110.4%       0.00 ± 45%      +1.8%       0.00 ± 32%  sched_debug.cfs_rq:/.spread.avg
      0.01 ± 13%    +174.3%       0.02 ± 25%     -28.3%       0.00 ± 26%  sched_debug.cfs_rq:/.spread.max
      0.00 ±  7%    +146.2%       0.00 ± 27%     -13.4%       0.00 ± 26%  sched_debug.cfs_rq:/.spread.stddev
    431.00           +14.5%     493.62            -2.7%     419.48        sched_debug.cfs_rq:/.util_avg.avg
      1061 ±  3%     +26.4%       1341 ±  3%      -0.6%       1055 ±  2%  sched_debug.cfs_rq:/.util_avg.max
    151.53 ±  5%     +50.1%     227.46 ±  2%      -9.2%     137.60 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    206.96           +17.5%     243.18 ±  3%      +8.4%     224.27 ±  8%  sched_debug.cfs_rq:/.util_est.avg
     18451            +9.9%      20272            -0.5%      18360        sched_debug.cfs_rq:/.zero_vruntime.avg
      5869 ±  4%      -7.4%       5437 ±  5%     -10.1%       5278 ±  2%  sched_debug.cfs_rq:/.zero_vruntime.stddev
      2345           +33.6%       3133 ±  5%     +20.6%       2829 ± 11%  sched_debug.cpu.avg_idle.min
     13.18 ±  2%     +39.8%      18.42 ±  6%      +4.1%      13.72        sched_debug.cpu.clock.stddev
      3961           +14.6%       4541            +6.0%       4197 ±  4%  sched_debug.cpu.curr->pid.avg
      3213           -15.4%       2718            -5.8%       3028 ±  3%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 29%    +157.3%       0.00 ± 35%    +101.7%       0.00 ± 51%  sched_debug.cpu.next_balance.stddev
      0.70           -15.8%       0.59 ±  3%      -5.0%       0.66 ±  2%  sched_debug.cpu.nr_running.stddev
   5474800           -69.7%    1660250 ±  2%      -1.6%    5386873        sched_debug.cpu.nr_switches.avg
   5648642           -65.5%    1946319 ±  5%      -1.5%    5561645        sched_debug.cpu.nr_switches.max
   2229198 ±  8%     -67.1%     734011 ± 20%      +9.1%    2431460 ± 15%  sched_debug.cpu.nr_switches.min
    297592 ±  6%     -25.9%     220513 ± 18%      -3.5%     287202 ±  9%  sched_debug.cpu.nr_switches.stddev
     23.75           -10.9       12.88            -6.3       17.48 ± 57%  perf-profile.calltrace.cycles-pp.common_startup_64
     23.65           -10.8       12.82            -6.2       17.41 ± 57%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     23.62           -10.8       12.81            -6.2       17.39 ± 57%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     23.51           -10.8       12.76            -6.2       17.30 ± 57%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     12.93            -7.0        5.94 ±  4%      -3.3        9.65 ± 57%  perf-profile.calltrace.cycles-pp.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.78            -6.9        5.89 ±  4%      -3.2        9.54 ± 57%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
     11.30            -5.2        6.07 ±  3%      -3.0        8.34 ± 57%  perf-profile.calltrace.cycles-pp.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.17            -5.2        6.02 ±  3%      -2.9        8.24 ± 57%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      9.89            -4.8        5.08 ±  4%      -2.6        7.32 ± 57%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q
      4.52            -4.5        0.00            -1.3        3.21 ± 57%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     12.41            -4.4        7.96            -3.3        9.09 ± 57%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.19            -4.4        4.77 ±  4%      -2.4        6.79 ± 57%  perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
     11.29            -4.0        7.29            -3.0        8.27 ± 57%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     11.38            -4.0        7.40            -3.0        8.34 ± 57%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.04            -3.9        4.13 ±  4%      -2.1        5.94 ± 57%  perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
      6.91            -3.8        3.08 ±  4%      -1.8        5.15 ± 57%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive
      6.76            -3.8        3.00 ±  4%      -1.7        5.04 ± 57%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedreceive
      8.71            -3.7        5.00            -2.2        6.52 ± 57%  perf-profile.calltrace.cycles-pp.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.71            -3.4        2.26 ±  4%      -1.5        4.21 ± 57%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      8.12            -3.4        4.72            -2.1        6.07 ± 57%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      7.76            -3.2        4.55            -2.0        5.80 ± 57%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend
      8.39            -3.1        5.26            -2.1        6.26 ± 57%  perf-profile.calltrace.cycles-pp.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.47            -3.1        4.35            -1.9        5.59 ± 57%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend
      4.92            -2.9        2.00 ±  4%      -1.3        3.62 ± 57%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      7.79            -2.8        4.97            -2.0        5.79 ± 57%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      7.48            -2.7        4.79            -1.9        5.57 ± 57%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive
      7.17            -2.6        4.60            -1.8        5.34 ± 57%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive
      5.54            -2.3        3.24 ±  4%      -1.5        4.05 ± 57%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend
      5.41            -2.2        3.16 ±  4%      -1.5        3.95 ± 57%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedsend
      3.88            -2.2        1.67 ±  4%      -1.0        2.86 ± 57%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      4.04            -2.2        1.88            -1.0        3.00 ± 57%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.44            -2.2        1.28 ±  3%      -0.9        2.54 ± 57%  perf-profile.calltrace.cycles-pp.store_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.84            -2.0        1.80            -1.0        2.84 ± 57%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      4.83            -2.0        2.85            -1.2        3.62 ± 57%  perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep
      4.71            -1.9        2.78            -1.2        3.53 ± 57%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_hrtimeout_range_clock
      1.84            -1.8        0.00            -0.5        1.35 ± 57%  perf-profile.calltrace.cycles-pp.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q
      4.39            -1.8        2.58            -1.1        3.30 ± 57%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      2.37            -1.5        0.84 ±  3%      -0.6        1.76 ± 57%  perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      2.66            -1.4        1.26 ±  4%      -0.7        1.96 ± 57%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      2.73            -1.4        1.33 ±  4%      -0.7        2.01 ± 57%  perf-profile.calltrace.cycles-pp.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.50            -1.3        2.17            -0.9        2.62 ± 57%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      2.37            -1.3        1.06 ±  2%      -0.6        1.78 ± 57%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.29            -1.3        0.00            -0.4        0.94 ± 57%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.23            -1.2        0.00            -0.3        0.90 ± 57%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.16            -1.2        0.00            -0.3        0.86 ± 57%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend
      1.15            -1.2        0.00            -0.6        0.59 ± 67%  perf-profile.calltrace.cycles-pp.task_h_load.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up
      1.15            -1.1        0.00            -0.3        0.84 ± 57%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule_idle.do_idle
      4.10            -1.1        3.03            -1.0        3.07 ± 57%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep
      2.20            -1.1        1.13 ±  5%      -0.6        1.62 ± 57%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      2.20            -1.1        1.15 ±  4%      -0.6        1.62 ± 57%  perf-profile.calltrace.cycles-pp.switch_fpu_return.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.20            -1.0        0.17 ±141%      -0.3        0.89 ± 57%  perf-profile.calltrace.cycles-pp.do_perf_trace_sched_wakeup_template.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedsend
      1.74            -1.0        0.73 ±  3%      -0.4        1.34 ± 57%  perf-profile.calltrace.cycles-pp.msg_get.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.32            -1.0        0.37 ± 70%      -0.3        0.98 ± 57%  perf-profile.calltrace.cycles-pp.do_perf_trace_sched_wakeup_template.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedreceive
      1.93            -0.9        0.99 ±  4%      -0.5        1.42 ± 57%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.93            -0.9        0.00            -0.3        0.67 ± 57%  perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      0.88            -0.9        0.00            -0.2        0.64 ± 57%  perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.34            -0.8        0.54 ±  5%      -0.3        1.00 ± 57%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive
      1.52            -0.8        0.73 ±  4%      -0.4        1.12 ± 57%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending
      0.74            -0.7        0.00            -0.2        0.55 ± 57%  perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.do_mq_timedsend
      1.05            -0.7        0.34 ± 70%      -0.3        0.78 ± 57%  perf-profile.calltrace.cycles-pp.__switch_to
      1.57            -0.7        0.90 ±  6%      -0.4        1.17 ± 57%  perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.67            -0.7        0.00            -0.2        0.46 ± 57%  perf-profile.calltrace.cycles-pp.__wake_up.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66            -0.7        0.00            -0.2        0.49 ± 57%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate
      0.60            -0.6        0.00            -0.2        0.42 ± 57%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      0.57            -0.6        0.00            -0.2        0.42 ± 57%  perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend
      2.56            -0.3        2.28            -0.6        1.91 ± 57%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.schedule_hrtimeout_range_clock
      5.87            +0.9        6.78            -1.5        4.41 ± 57%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.9        0.91 ± 30%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule.schedule
     35.80            +3.5       39.29            -8.5       27.26 ± 57%  perf-profile.calltrace.cycles-pp.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.59            +3.6       39.21            -8.5       27.09 ± 57%  perf-profile.calltrace.cycles-pp.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.4        4.37 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.drain_obj_stock.__refill_obj_stock.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg
      0.00            +4.4        4.39 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.drain_obj_stock.__refill_obj_stock.__memcg_slab_free_hook.kfree.free_msg
      0.00            +8.0        8.01 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__refill_obj_stock.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg.do_mq_timedsend
      0.00            +8.3        8.29 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__refill_obj_stock.__memcg_slab_free_hook.kfree.free_msg.do_mq_timedreceive
     28.51           +13.5       41.99            -7.2       21.32 ± 57%  perf-profile.calltrace.cycles-pp.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.23           +13.5       41.71            -7.1       21.11 ± 57%  perf-profile.calltrace.cycles-pp.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     70.69           +13.7       84.35           -17.4       53.34 ± 57%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.44           +13.8       84.26           -17.3       53.14 ± 57%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.99           +20.2       23.24 ±  2%      -0.3        2.70 ± 57%  perf-profile.calltrace.cycles-pp.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.79           +20.4       23.15 ±  2%      -0.2        2.56 ± 57%  perf-profile.calltrace.cycles-pp.kfree.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      2.43           +20.6       22.98 ±  2%      -0.1        2.28 ± 57%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kfree.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive
      2.26           +26.0       28.23 ±  2%      -0.2        2.03 ± 57%  perf-profile.calltrace.cycles-pp.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99           +26.8       27.80 ±  2%      +0.1        1.09 ± 57%  perf-profile.calltrace.cycles-pp.__kmalloc_node_noprof.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      0.65           +27.0       27.62 ±  2%      +0.2        0.84 ± 57%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend
     24.25           -12.2       12.02 ±  4%      -6.2       18.00 ± 57%  perf-profile.children.cycles-pp.wake_up_q
     24.00           -12.1       11.93 ±  4%      -6.2       17.82 ± 57%  perf-profile.children.cycles-pp.try_to_wake_up
     23.75           -10.9       12.88            -6.3       17.48 ± 57%  perf-profile.children.cycles-pp.common_startup_64
     23.75           -10.9       12.88            -6.3       17.48 ± 57%  perf-profile.children.cycles-pp.cpu_startup_entry
     23.68           -10.8       12.85            -6.3       17.43 ± 57%  perf-profile.children.cycles-pp.do_idle
     23.65           -10.8       12.82            -6.2       17.41 ± 57%  perf-profile.children.cycles-pp.start_secondary
     19.65            -8.3       11.33            -5.0       14.66 ± 57%  perf-profile.children.cycles-pp.__schedule
     17.14            -6.9       10.28            -4.3       12.80 ± 57%  perf-profile.children.cycles-pp.wq_sleep
     16.24            -6.4        9.82            -4.1       12.13 ± 57%  perf-profile.children.cycles-pp.schedule
     15.92            -6.2        9.69            -4.0       11.88 ± 57%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
     12.46            -6.1        6.32 ±  4%      -3.3        9.20 ± 57%  perf-profile.children.cycles-pp.select_task_rq
     12.19            -6.0        6.17 ±  4%      -3.2        9.00 ± 57%  perf-profile.children.cycles-pp.select_task_rq_fair
      9.91            -4.8        5.09 ±  4%      -2.6        7.33 ± 57%  perf-profile.children.cycles-pp.select_idle_sibling
      4.57            -4.6        0.02 ±141%      -1.3        3.24 ± 57%  perf-profile.children.cycles-pp.poll_idle
      9.27            -4.5        4.80 ±  4%      -2.4        6.85 ± 57%  perf-profile.children.cycles-pp.select_idle_cpu
     12.49            -4.5        8.03            -3.3        9.15 ± 57%  perf-profile.children.cycles-pp.cpuidle_idle_call
     11.41            -4.0        7.39            -3.1        8.36 ± 57%  perf-profile.children.cycles-pp.cpuidle_enter_state
     11.44            -4.0        7.43            -3.1        8.38 ± 57%  perf-profile.children.cycles-pp.cpuidle_enter
      8.17            -4.0        4.18 ±  4%      -2.1        6.04 ± 57%  perf-profile.children.cycles-pp.select_idle_core
      5.76            -3.5        2.28 ±  4%      -1.5        4.25 ± 57%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      5.47            -3.1        2.35 ±  4%      -1.4        4.04 ± 57%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      4.30            -2.4        1.94 ±  4%      -1.1        3.18 ± 57%  perf-profile.children.cycles-pp.sched_ttwu_pending
      4.08            -2.2        1.90            -1.1        3.02 ± 57%  perf-profile.children.cycles-pp.schedule_idle
      3.47            -2.2        1.30 ±  2%      -0.9        2.57 ± 57%  perf-profile.children.cycles-pp.store_msg
      5.87            -2.1        3.78            -1.5        4.38 ± 57%  perf-profile.children.cycles-pp.__pick_next_task
      4.84            -2.0        2.86            -1.2        3.63 ± 57%  perf-profile.children.cycles-pp.try_to_block_task
      4.73            -1.9        2.79            -1.2        3.54 ± 57%  perf-profile.children.cycles-pp.dequeue_entities
      4.73            -1.9        2.82            -1.2        3.55 ± 57%  perf-profile.children.cycles-pp.dequeue_task_fair
      4.04            -1.8        2.26            -1.1        2.98 ± 57%  perf-profile.children.cycles-pp._raw_spin_lock
      3.72            -1.7        2.03 ±  4%      -0.9        2.77 ± 57%  perf-profile.children.cycles-pp.enqueue_task
      2.40            -1.6        0.85 ±  3%      -0.6        1.79 ± 57%  perf-profile.children.cycles-pp._copy_to_user
      3.39            -1.5        1.86 ±  3%      -0.9        2.52 ± 57%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.56            -1.5        1.04 ±  5%      -0.7        1.90 ± 57%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      2.54            -1.5        1.03 ±  5%      -0.7        1.88 ± 57%  perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      2.76            -1.4        1.34 ±  4%      -0.7        2.03 ± 57%  perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      3.75            -1.4        2.34            -0.9        2.81 ± 57%  perf-profile.children.cycles-pp.dequeue_entity
      2.32            -1.4        0.95 ±  4%      -0.6        1.72 ± 57%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.72            -1.3        1.38 ±  2%      -0.7        2.05 ± 57%  perf-profile.children.cycles-pp.update_curr
      2.38            -1.3        1.06 ±  2%      -0.6        1.79 ± 57%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      4.24            -1.2        2.99            -1.1        3.16 ± 57%  perf-profile.children.cycles-pp.pick_next_task_fair
      2.21            -1.1        1.15 ±  5%      -0.6        1.63 ± 57%  perf-profile.children.cycles-pp.switch_fpu_return
      1.76            -1.0        0.73 ±  3%      -0.4        1.37 ± 57%  perf-profile.children.cycles-pp.msg_get
      1.67            -1.0        0.65 ±  3%      -0.6        1.10 ± 57%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.47            -1.0        1.47 ±  3%      -0.6        1.84 ± 57%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.39            -1.0        1.42            -0.6        1.78 ± 57%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      2.29            -1.0        1.32            -0.6        1.69 ± 57%  perf-profile.children.cycles-pp.update_load_avg
      1.60            -1.0        0.64            -0.4        1.20 ± 57%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.51            -0.9        0.57 ±  5%      -0.4        1.12 ± 57%  perf-profile.children.cycles-pp.__smp_call_single_queue
      1.84            -0.9        0.93 ±  6%      -0.5        1.35 ± 57%  perf-profile.children.cycles-pp.wake_affine
      1.49            -0.9        0.59            -0.4        1.10 ± 57%  perf-profile.children.cycles-pp.__check_object_size
      1.61            -0.9        0.72 ±  5%      -0.4        1.21 ± 57%  perf-profile.children.cycles-pp.update_rq_clock_task
      1.73            -0.9        0.87 ±  2%      -0.4        1.30 ± 57%  perf-profile.children.cycles-pp.update_se
      1.51            -0.9        0.65 ±  2%      -0.4        1.14 ± 57%  perf-profile.children.cycles-pp.wakeup_preempt
      2.00            -0.8        1.15 ±  3%      -0.5        1.48 ± 57%  perf-profile.children.cycles-pp.enqueue_entity
      1.26            -0.8        0.42 ±  3%      -0.5        0.80 ± 57%  perf-profile.children.cycles-pp.__wake_up
      1.31            -0.7        0.58 ±  5%      -0.3        0.97 ± 57%  perf-profile.children.cycles-pp.set_task_cpu
      1.15            -0.7        0.45 ±  3%      -0.3        0.85 ± 57%  perf-profile.children.cycles-pp.msg_insert
      1.04            -0.7        0.35 ±  5%      -0.3        0.78 ± 57%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      1.57            -0.7        0.90 ±  5%      -0.4        1.17 ± 57%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.00            -0.7        0.34 ±  7%      -0.3        0.74 ± 57%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.95            -0.7        0.29 ±  4%      -0.3        0.70 ± 57%  perf-profile.children.cycles-pp.llist_reverse_order
      1.14            -0.6        0.50 ±  5%      -0.3        0.84 ± 57%  perf-profile.children.cycles-pp.migrate_task_rq_fair
      1.11            -0.6        0.51            -0.3        0.82 ± 57%  perf-profile.children.cycles-pp.set_next_entity
      0.95            -0.6        0.39 ±  2%      -0.2        0.71 ± 57%  perf-profile.children.cycles-pp.__update_idle_core
      1.04            -0.6        0.49 ±  2%      -0.3        0.77 ± 57%  perf-profile.children.cycles-pp.pick_task_fair
      1.15            -0.6        0.60 ±  7%      -0.3        0.84 ± 57%  perf-profile.children.cycles-pp.task_h_load
      1.06            -0.5        0.52            -0.3        0.79 ± 57%  perf-profile.children.cycles-pp.set_next_task_idle
      0.84            -0.5        0.30 ±  5%      -0.2        0.63 ± 57%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      1.04            -0.5        0.51            -0.3        0.76 ± 57%  perf-profile.children.cycles-pp._find_next_bit
      1.38            -0.5        0.85            -0.4        1.02 ± 57%  perf-profile.children.cycles-pp.update_cfs_rq_load_avg
      1.28            -0.5        0.75            -0.3        0.95 ± 57%  perf-profile.children.cycles-pp.__switch_to
      0.85            -0.5        0.34 ±  3%      -0.2        0.66 ± 57%  perf-profile.children.cycles-pp.cpuacct_charge
      0.77 ±  4%      -0.5        0.25            -0.2        0.55 ± 57%  perf-profile.children.cycles-pp.__bitmap_andnot
      0.88            -0.5        0.41 ±  6%      -0.2        0.66 ± 57%  perf-profile.children.cycles-pp.update_entity_lag
      0.94            -0.5        0.48            -0.2        0.69 ± 57%  perf-profile.children.cycles-pp.prepare_task_switch
      0.74            -0.4        0.31 ±  2%      -0.2        0.56 ± 57%  perf-profile.children.cycles-pp.check_heap_object
      0.75            -0.4        0.32 ±  5%      -0.2        0.56 ± 57%  perf-profile.children.cycles-pp.requeue_delayed_entity
      0.80            -0.4        0.40            -0.2        0.60 ± 57%  perf-profile.children.cycles-pp.wakeup_preempt_fair
      0.55            -0.4        0.16 ±  2%      -0.1        0.40 ± 57%  perf-profile.children.cycles-pp.native_sched_clock
      0.57            -0.4        0.18 ±  4%      -0.2        0.41 ± 57%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.55            -0.4        0.17            -0.1        0.41 ± 57%  perf-profile.children.cycles-pp.os_xsave
      0.58            -0.4        0.20            -0.2        0.43 ± 57%  perf-profile.children.cycles-pp.sched_clock_cpu
      1.39            -0.4        1.01            -0.4        1.03 ± 57%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.18            -0.4        0.81            -0.3        0.88 ± 57%  perf-profile.children.cycles-pp.___task_rq_lock
      0.51 ±  3%      -0.4        0.14 ±  3%      -0.2        0.36 ± 58%  perf-profile.children.cycles-pp._copy_from_user
      0.56            -0.4        0.19 ±  2%      -0.1        0.41 ± 57%  perf-profile.children.cycles-pp.update_rq_clock
      0.51            -0.3        0.17 ±  2%      -0.1        0.38 ± 57%  perf-profile.children.cycles-pp.sched_clock
      0.56            -0.3        0.23 ±  3%      -0.1        0.44 ± 57%  perf-profile.children.cycles-pp.simple_inode_init_ts
      0.89            -0.3        0.56            -0.2        0.67 ± 57%  perf-profile.children.cycles-pp.put_prev_entity
      0.53 ±  3%      -0.3        0.21 ±  2%      -0.2        0.38 ± 57%  perf-profile.children.cycles-pp.__put_user_4
      0.68 ± 12%      -0.3        0.36 ±  4%      -0.1        0.57 ± 57%  perf-profile.children.cycles-pp.stress_switch_mq
      0.52            -0.3        0.20            -0.1        0.37 ± 57%  perf-profile.children.cycles-pp.set_next_task_fair
      0.55            -0.3        0.24 ±  5%      -0.1        0.40 ± 57%  perf-profile.children.cycles-pp.__switch_to_asm
      0.51            -0.3        0.21 ±  3%      -0.1        0.40 ± 57%  perf-profile.children.cycles-pp.inode_set_ctime_current
      0.56            -0.3        0.26 ±  3%      -0.1        0.42 ± 57%  perf-profile.children.cycles-pp.fdget
      0.52            -0.3        0.23 ±  3%      -0.1        0.39 ± 57%  perf-profile.children.cycles-pp.mm_cid_switch_to
      0.54            -0.3        0.25 ±  3%      -0.1        0.40 ± 57%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.79            -0.3        0.51            -0.2        0.59 ± 57%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.37            -0.3        0.11 ±  7%      -0.1        0.27 ± 57%  perf-profile.children.cycles-pp.__resched_curr
      0.57            -0.2        0.32            -0.1        0.42 ± 57%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.35            -0.2        0.12 ±  4%      -0.1        0.26 ± 57%  perf-profile.children.cycles-pp.avg_vruntime
      0.62            -0.2        0.39 ±  2%      -0.2        0.47 ± 57%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.34            -0.2        0.11            -0.1        0.25 ± 57%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.58            -0.2        0.36            -0.1        0.44 ± 57%  perf-profile.children.cycles-pp.__enqueue_entity
      0.52            -0.2        0.30 ±  3%      -0.1        0.38 ± 57%  perf-profile.children.cycles-pp.perf_tp_event
      0.46            -0.2        0.24            -0.1        0.34 ± 57%  perf-profile.children.cycles-pp.__pick_eevdf
      0.35            -0.2        0.14 ±  3%      -0.1        0.26 ± 57%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.56            -0.2        0.36            -0.1        0.42 ± 57%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.33            -0.2        0.13 ±  3%      -0.1        0.24 ± 57%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.31 ±  2%      -0.2        0.12 ±  4%      -0.1        0.24 ± 57%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.58            -0.2        0.40            -0.1        0.44 ± 57%  perf-profile.children.cycles-pp.menu_select
      0.32 ±  5%      -0.2        0.13            -0.1        0.22 ± 57%  perf-profile.children.cycles-pp.__check_heap_object
      0.31            -0.2        0.13 ±  3%      -0.1        0.23 ± 57%  perf-profile.children.cycles-pp.place_entity
      0.32            -0.2        0.14            -0.1        0.24 ± 57%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.36            -0.2        0.18 ±  2%      -0.1        0.27 ± 57%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.29            -0.2        0.11            -0.1        0.22 ± 59%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.33            -0.2        0.16 ±  3%      -0.1        0.24 ± 57%  perf-profile.children.cycles-pp.do_perf_trace_sched_stat_runtime
      0.35            -0.2        0.18 ±  2%      -0.1        0.26 ± 57%  perf-profile.children.cycles-pp.ktime_get
      0.25            -0.2        0.08 ±  5%      -0.1        0.18 ± 57%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.37            -0.2        0.20 ±  4%      -0.1        0.27 ± 57%  perf-profile.children.cycles-pp.___perf_sw_event
      0.23            -0.2        0.07 ±  6%      -0.1        0.17 ± 57%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.22            -0.2        0.07            -0.1        0.16 ± 57%  perf-profile.children.cycles-pp.read_tsc
      0.21            -0.1        0.06 ±  7%      -0.1        0.16 ± 57%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.25            -0.1        0.11 ±  7%      -0.1        0.18 ± 57%  perf-profile.children.cycles-pp.strnlen
      0.16            -0.1        0.02 ±141%      -0.0        0.11 ± 57%  perf-profile.children.cycles-pp.ct_idle_exit
      0.32            -0.1        0.18            -0.1        0.24 ± 57%  perf-profile.children.cycles-pp.__dequeue_entity
      0.23 ±  2%      -0.1        0.10 ±  4%      -0.1        0.18 ± 57%  perf-profile.children.cycles-pp.check_stack_object
      0.53            -0.1        0.40 ±  2%      -0.1        0.40 ± 57%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.23 ±  2%      -0.1        0.09 ±  5%      -0.1        0.17 ± 57%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.30 ±  3%      -0.1        0.17 ±  4%      -0.1        0.23 ± 57%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.20            -0.1        0.07            +0.3        0.46 ± 57%  perf-profile.children.cycles-pp.__account_obj_stock
      0.13            -0.1        0.00            -0.0        0.09 ± 57%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.41            -0.1        0.28 ±  2%      -0.1        0.30 ± 57%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.41 ±  2%      -0.1        0.29 ±  3%      -0.1        0.31 ± 57%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.31 ±  2%      -0.1        0.18 ±  2%      -0.1        0.24 ± 57%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.28 ±  2%      -0.1        0.16 ±  6%      -0.1        0.21 ± 57%  perf-profile.children.cycles-pp.update_process_times
      0.33            -0.1        0.21 ±  6%      -0.1        0.25 ± 57%  perf-profile.children.cycles-pp.attach_entity_load_avg
      0.12 ±  3%      -0.1        0.00            -0.1        0.05 ± 58%  perf-profile.children.cycles-pp.__do_notify
      0.19 ±  2%      -0.1        0.07 ±  7%      -0.0        0.14 ± 57%  perf-profile.children.cycles-pp.wake_q_add_safe
      0.23 ±  2%      -0.1        0.11            -0.1        0.17 ± 57%  perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.18            -0.1        0.07 ±  6%      -0.1        0.13 ± 57%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.56            -0.1        0.46            -0.1        0.42 ± 57%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.15            -0.1        0.05            -0.0        0.11 ± 57%  perf-profile.children.cycles-pp._raw_spin_unlock
      0.17            -0.1        0.08            -0.1        0.12 ± 57%  perf-profile.children.cycles-pp.security_msg_msg_free
      0.15            -0.1        0.06            -0.0        0.12 ± 57%  perf-profile.children.cycles-pp.inode_set_ctime_to_ts
      0.16 ±  2%      -0.1        0.08 ±  5%      -0.0        0.12 ± 57%  perf-profile.children.cycles-pp.dl_server_update
      0.13            -0.1        0.06 ±  8%      -0.0        0.10 ± 57%  perf-profile.children.cycles-pp.timestamp_truncate
      0.15 ±  3%      -0.1        0.08            -0.0        0.12 ± 57%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.07            -0.1        0.00            -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.kick_ilb
      0.13 ±  3%      -0.1        0.06            -0.0        0.09 ± 57%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.13 ±  3%      -0.1        0.06            -0.0        0.10 ± 57%  perf-profile.children.cycles-pp.migrate_disable_switch
      0.12 ±  6%      -0.1        0.05 ±  8%      -0.0        0.08 ± 58%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.11 ±  4%      -0.1        0.05            -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.14            -0.1        0.08 ±  5%      -0.0        0.10 ± 57%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.10            -0.1        0.05            -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.11            -0.1        0.06            -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.10 ±  4%      -0.0        0.05            -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.10            -0.0        0.06 ±  8%      -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.rest_init
      0.10            -0.0        0.06 ±  8%      -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.start_kernel
      0.10            -0.0        0.06 ±  8%      -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.10            -0.0        0.06 ±  8%      -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.08 ± 10%      -0.0        0.04 ± 71%      -0.0        0.06 ± 59%  perf-profile.children.cycles-pp.mq_timedreceive
      0.15            -0.0        0.11 ±  4%      -0.0        0.11 ± 57%  perf-profile.children.cycles-pp.vruntime_eligible
      0.13            -0.0        0.09            -0.0        0.10 ± 57%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.09            -0.0        0.05 ±  8%      -0.0        0.07 ± 57%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08            -0.0        0.05            -0.0        0.06 ± 57%  perf-profile.children.cycles-pp.choose_new_asid
      0.13            -0.0        0.11            -0.0        0.10 ± 57%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.07            -0.0        0.05            -0.0        0.05 ± 57%  perf-profile.children.cycles-pp.__set_next_task_fair
      0.76            -0.0        0.74            -0.2        0.56 ± 57%  perf-profile.children.cycles-pp.finish_task_switch
      0.09            -0.0        0.07 ±  6%      -0.0        0.07 ± 57%  perf-profile.children.cycles-pp.propagate_entity_load_avg
      0.10            -0.0        0.09            -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.handle_softirqs
      0.07            -0.0        0.06            -0.0        0.05 ± 57%  perf-profile.children.cycles-pp.clockevents_program_event
      0.07            +0.0        0.08            -0.0        0.05 ± 57%  perf-profile.children.cycles-pp.perf_swevent_event
      0.48            +0.0        0.49            -0.1        0.36 ± 57%  perf-profile.children.cycles-pp.process_simple
      0.05            +0.0        0.06 ±  7%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.sched_update_worker
      0.05            +0.0        0.07            -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.07 ± 11%      +0.0        0.09 ±  5%      +0.0        0.07 ± 58%  perf-profile.children.cycles-pp.mq_timedsend
      0.15 ±  3%      +0.0        0.20 ±  4%      -0.0        0.12 ± 57%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +0.1        0.05            +0.0        0.00        perf-profile.children.cycles-pp.__sched_balance_update_blocked_averages
      0.00            +0.1        0.05            +0.0        0.00        perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.06 ± 23%      +0.0        0.00        perf-profile.children.cycles-pp.generic_perform_write
      0.00            +0.1        0.06 ±  7%      +0.0        0.00        perf-profile.children.cycles-pp.detach_tasks
      0.00            +0.1        0.06 ± 29%      +0.0        0.00        perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.06 ± 29%      +0.0        0.00        perf-profile.children.cycles-pp.vfs_write
      0.00            +0.1        0.07 ± 25%      +0.0        0.00        perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.08 ± 30%      +0.0        0.00        perf-profile.children.cycles-pp.record__pushfn
      0.04 ± 71%      +0.1        0.12 ± 35%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.perf_mmap__push
      0.54 ±  2%      +0.1        0.62 ±  7%      -0.1        0.40 ± 57%  perf-profile.children.cycles-pp.cmd_record
      0.04 ± 71%      +0.1        0.13 ± 35%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.handle_internal_command
      0.04 ± 71%      +0.1        0.13 ± 35%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.main
      0.04 ± 71%      +0.1        0.13 ± 35%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.run_builtin
      0.04 ± 70%      +0.1        0.13 ± 32%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.10 ±  4%      +0.1        0.20 ±  4%      -0.0        0.08 ± 57%  perf-profile.children.cycles-pp.do_perf_trace_sched_switch
      0.00            +0.1        0.10 ±  4%      +0.0        0.00        perf-profile.children.cycles-pp.ct_idle_enter
      0.13 ±  3%      +0.2        0.29 ±  4%      -0.0        0.10 ± 57%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.21 ±  6%      +0.6        0.78 ±  3%      -0.0        0.16 ± 57%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.22 ±  6%      +0.6        0.81 ±  4%      -0.1        0.17 ± 57%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.22 ±  6%      +0.6        0.81 ±  3%      -0.1        0.17 ± 57%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.40 ±  3%      +0.7        1.08 ±  4%      -0.1        0.30 ± 57%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.27 ±  6%      +0.7        0.97 ±  4%      -0.1        0.21 ± 57%  perf-profile.children.cycles-pp.sched_balance_rq
      5.90            +0.9        6.81            -1.5        4.43 ± 57%  perf-profile.children.cycles-pp.intel_idle
     35.82            +3.5       39.30            -8.6       27.27 ± 57%  perf-profile.children.cycles-pp.__x64_sys_mq_timedreceive
     35.70            +3.5       39.25            -8.5       27.18 ± 57%  perf-profile.children.cycles-pp.do_mq_timedreceive
      0.00            +8.8        8.78 ±  3%      +0.0        0.00        perf-profile.children.cycles-pp.drain_obj_stock
     28.34           +13.4       41.76            -7.1       21.20 ± 57%  perf-profile.children.cycles-pp.do_mq_timedsend
     28.52           +13.5       41.99            -7.2       21.34 ± 57%  perf-profile.children.cycles-pp.__x64_sys_mq_timedsend
     70.76           +13.7       84.45           -17.4       53.40 ± 57%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.56           +13.8       84.39           -17.3       53.24 ± 57%  perf-profile.children.cycles-pp.do_syscall_64
      0.08           +16.2       16.31 ±  4%      +0.1        0.15 ± 57%  perf-profile.children.cycles-pp.__refill_obj_stock
      3.22           +20.1       23.33 ±  2%      -0.3        2.91 ± 57%  perf-profile.children.cycles-pp.kfree
      3.01           +20.2       23.25 ±  2%      -0.3        2.72 ± 57%  perf-profile.children.cycles-pp.free_msg
      2.46           +20.5       23.00 ±  2%      -0.1        2.31 ± 57%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      2.31           +25.9       28.25 ±  2%      -0.2        2.07 ± 57%  perf-profile.children.cycles-pp.load_msg
      1.00           +26.8       27.81 ±  2%      +0.1        1.10 ± 57%  perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.68           +27.0       27.65 ±  2%      +0.2        0.86 ± 57%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      4.41            -4.4        0.02 ±141%      -1.3        3.13 ± 57%  perf-profile.self.cycles-pp.poll_idle
      6.79            -3.2        3.63 ±  5%      -1.8        5.04 ± 57%  perf-profile.self.cycles-pp.select_idle_core
      3.07            -1.7        1.33 ±  4%      -0.7        2.36 ± 57%  perf-profile.self.cycles-pp.do_mq_timedreceive
      2.90            -1.6        1.31 ±  3%      -0.7        2.16 ± 57%  perf-profile.self.cycles-pp.__schedule
      2.37            -1.5        0.84 ±  3%      -0.6        1.77 ± 57%  perf-profile.self.cycles-pp._copy_to_user
      2.73            -1.5        1.22 ±  3%      -0.7        2.00 ± 57%  perf-profile.self.cycles-pp.do_mq_timedsend
      2.63            -1.4        1.25 ±  3%      -0.7        1.93 ± 57%  perf-profile.self.cycles-pp._raw_spin_lock
      1.64            -1.0        0.64 ±  3%      -0.6        1.08 ± 57%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.46            -0.9        0.55 ±  2%      -0.4        1.10 ± 57%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.54            -0.9        0.67 ±  6%      -0.4        1.16 ± 57%  perf-profile.self.cycles-pp.update_rq_clock_task
      1.48            -0.9        0.62 ±  3%      -0.4        1.13 ± 57%  perf-profile.self.cycles-pp.msg_get
      1.36            -0.8        0.58 ±  3%      -0.3        1.02 ± 57%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      1.11            -0.7        0.44 ±  4%      -0.3        0.82 ± 57%  perf-profile.self.cycles-pp.msg_insert
      1.56            -0.7        0.90 ±  6%      -0.4        1.17 ± 57%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.95            -0.7        0.29 ±  5%      -0.3        0.70 ± 57%  perf-profile.self.cycles-pp.llist_reverse_order
      1.00            -0.7        0.34 ±  7%      -0.3        0.74 ± 57%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      1.19            -0.6        0.59 ±  3%      -0.3        0.90 ± 57%  perf-profile.self.cycles-pp.wq_sleep
      0.92            -0.6        0.36 ±  6%      -0.2        0.69 ± 57%  perf-profile.self.cycles-pp.do_perf_trace_sched_wakeup_template
      0.90            -0.6        0.34 ±  2%      -0.2        0.68 ± 57%  perf-profile.self.cycles-pp.__update_idle_core
      1.15            -0.5        0.60 ±  7%      -0.3        0.84 ± 57%  perf-profile.self.cycles-pp.task_h_load
      0.83            -0.5        0.30 ±  5%      -0.2        0.62 ± 57%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.97            -0.5        0.44 ±  2%      -0.2        0.73 ± 57%  perf-profile.self.cycles-pp.dequeue_entities
      0.84            -0.5        0.34 ±  3%      -0.2        0.65 ± 57%  perf-profile.self.cycles-pp.cpuacct_charge
      0.96            -0.5        0.47 ±  4%      -0.2        0.72 ± 57%  perf-profile.self.cycles-pp.do_syscall_64
      1.23            -0.5        0.74            -0.3        0.91 ± 57%  perf-profile.self.cycles-pp.__switch_to
      0.73 ±  4%      -0.5        0.24 ±  3%      -0.2        0.52 ± 57%  perf-profile.self.cycles-pp.__bitmap_andnot
      0.69            -0.5        0.20 ±  4%      -0.2        0.51 ± 57%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.94            -0.5        0.47            -0.2        0.69 ± 57%  perf-profile.self.cycles-pp._find_next_bit
      0.77            -0.4        0.36 ±  6%      -0.2        0.58 ± 57%  perf-profile.self.cycles-pp.update_entity_lag
      0.76            -0.4        0.36 ±  3%      -0.2        0.56 ± 57%  perf-profile.self.cycles-pp.update_load_avg
      0.67            -0.4        0.27 ±  5%      -0.2        0.49 ± 57%  perf-profile.self.cycles-pp.__smp_call_single_queue
      0.70            -0.4        0.31 ±  2%      -0.2        0.52 ± 57%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.55            -0.4        0.17 ±  2%      -0.1        0.41 ± 57%  perf-profile.self.cycles-pp.os_xsave
      0.56            -0.4        0.18 ±  4%      -0.1        0.41 ± 57%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.63            -0.4        0.25            -0.2        0.46 ± 57%  perf-profile.self.cycles-pp.switch_fpu_return
      1.38            -0.4        1.01            -0.4        1.02 ± 57%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.69            -0.4        0.33 ±  5%      -0.2        0.51 ± 57%  perf-profile.self.cycles-pp.wake_affine
      0.53            -0.4        0.16            -0.1        0.38 ± 57%  perf-profile.self.cycles-pp.native_sched_clock
      0.67            -0.4        0.30 ±  2%      -0.1        0.52 ± 57%  perf-profile.self.cycles-pp.kfree
      0.75            -0.4        0.39 ±  3%      -0.2        0.57 ± 57%  perf-profile.self.cycles-pp.update_curr
      0.67            -0.4        0.31 ±  5%      -0.2        0.49 ± 57%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.53            -0.4        0.18 ±  2%      -0.1        0.38 ± 57%  perf-profile.self.cycles-pp.arch_exit_to_user_mode_prepare
      0.49 ±  2%      -0.4        0.14 ±  3%      -0.1        0.35 ± 58%  perf-profile.self.cycles-pp._copy_from_user
      0.63            -0.3        0.28 ±  3%      -0.2        0.47 ± 57%  perf-profile.self.cycles-pp.schedule_hrtimeout_range_clock
      0.58            -0.3        0.23 ±  4%      -0.1        0.43 ± 57%  perf-profile.self.cycles-pp.select_idle_sibling
      0.58            -0.3        0.24 ±  7%      -0.2        0.42 ± 57%  perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.64            -0.3        0.31            -0.2        0.47 ± 57%  perf-profile.self.cycles-pp.prepare_task_switch
      0.82            -0.3        0.49 ±  3%      -0.2        0.62 ± 57%  perf-profile.self.cycles-pp.select_idle_cpu
      0.52 ±  3%      -0.3        0.21 ±  2%      -0.1        0.37 ± 57%  perf-profile.self.cycles-pp.__put_user_4
      0.63 ± 11%      -0.3        0.32 ±  5%      -0.1        0.52 ± 57%  perf-profile.self.cycles-pp.stress_switch_mq
      0.54            -0.3        0.24 ±  5%      -0.1        0.40 ± 57%  perf-profile.self.cycles-pp.__switch_to_asm
      0.54            -0.3        0.25 ±  3%      -0.1        0.40 ± 57%  perf-profile.self.cycles-pp.fdget
      0.51            -0.3        0.22 ±  4%      -0.1        0.38 ± 57%  perf-profile.self.cycles-pp.mm_cid_switch_to
      0.44            -0.3        0.15 ±  6%      -0.1        0.33 ± 57%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.43            -0.3        0.15 ±  5%      -0.1        0.32 ± 57%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.49            -0.3        0.23 ±  6%      -0.1        0.37 ± 57%  perf-profile.self.cycles-pp.enqueue_task
      0.59            -0.2        0.34 ±  2%      -0.1        0.44 ± 57%  perf-profile.self.cycles-pp.try_to_wake_up
      0.73            -0.2        0.48            -0.2        0.54 ± 57%  perf-profile.self.cycles-pp.update_cfs_rq_load_avg
      0.35            -0.2        0.11 ±  4%      -0.1        0.26 ± 57%  perf-profile.self.cycles-pp.__resched_curr
      0.40            -0.2        0.16 ±  2%      -0.1        0.30 ± 57%  perf-profile.self.cycles-pp.__pick_next_task
      0.36            -0.2        0.12 ±  3%      -0.1        0.26 ± 57%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.34            -0.2        0.11            -0.1        0.25 ± 57%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.57            -0.2        0.36            -0.1        0.43 ± 57%  perf-profile.self.cycles-pp.__enqueue_entity
      0.51            -0.2        0.31            -0.1        0.38 ± 57%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.34            -0.2        0.14 ±  5%      -0.1        0.26 ± 57%  perf-profile.self.cycles-pp.wakeup_preempt
      0.34            -0.2        0.14 ±  3%      -0.1        0.25 ± 57%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.39            -0.2        0.20 ±  2%      -0.1        0.29 ± 57%  perf-profile.self.cycles-pp.do_idle
      0.31 ±  5%      -0.2        0.11            -0.1        0.21 ± 58%  perf-profile.self.cycles-pp.__check_heap_object
      0.37            -0.2        0.17 ±  2%      -0.1        0.27 ± 57%  perf-profile.self.cycles-pp.check_heap_object
      0.51            -0.2        0.32            -0.1        0.38 ± 57%  perf-profile.self.cycles-pp.schedule
      0.36            -0.2        0.18 ±  2%      -0.1        0.27 ± 57%  perf-profile.self.cycles-pp.__pick_eevdf
      0.61            -0.2        0.43            -0.2        0.46 ± 57%  perf-profile.self.cycles-pp.dequeue_entity
      0.29 ±  2%      -0.2        0.11 ±  4%      -0.1        0.22 ± 57%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.30            -0.2        0.12            -0.1        0.22 ± 57%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.27            -0.2        0.10 ±  4%      -0.1        0.20 ± 57%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.25            -0.2        0.08 ±  5%      -0.1        0.18 ± 57%  perf-profile.self.cycles-pp.__check_object_size
      0.26            -0.2        0.11 ±  4%      -0.1        0.19 ± 57%  perf-profile.self.cycles-pp.place_entity
      0.45            -0.2        0.30 ±  3%      -0.1        0.34 ± 57%  perf-profile.self.cycles-pp.enqueue_entity
      0.44            -0.2        0.29 ±  5%      -0.1        0.33 ± 57%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.24            -0.2        0.09            -0.1        0.18 ± 57%  perf-profile.self.cycles-pp.wake_up_q
      0.24            -0.1        0.09 ±  5%      -0.1        0.18 ± 57%  perf-profile.self.cycles-pp.___perf_sw_event
      0.22 ±  2%      -0.1        0.07            -0.0        0.17 ± 59%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.32            -0.1        0.18 ±  2%      -0.1        0.24 ± 57%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.21 ±  2%      -0.1        0.06 ±  7%      -0.1        0.15 ± 57%  perf-profile.self.cycles-pp.read_tsc
      0.20            -0.1        0.06            -0.1        0.15 ± 57%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.36            -0.1        0.22 ±  4%      -0.1        0.26 ± 57%  perf-profile.self.cycles-pp.perf_tp_event
      0.28            -0.1        0.14            -0.1        0.21 ± 57%  perf-profile.self.cycles-pp.__kmalloc_node_noprof
      0.24            -0.1        0.11 ±  4%      -0.1        0.18 ± 57%  perf-profile.self.cycles-pp.strnlen
      0.21            -0.1        0.08 ±  6%      -0.0        0.16 ± 57%  perf-profile.self.cycles-pp.load_msg
      0.33            -0.1        0.20 ±  4%      -0.1        0.24 ± 57%  perf-profile.self.cycles-pp.attach_entity_load_avg
      0.12 ±  3%      -0.1        0.00            -0.1        0.05 ± 58%  perf-profile.self.cycles-pp.__do_notify
      0.44            -0.1        0.33            -0.1        0.33 ± 57%  perf-profile.self.cycles-pp.menu_select
      0.41            -0.1        0.29            -0.1        0.30 ± 57%  perf-profile.self.cycles-pp.update_se
      0.27            -0.1        0.15 ±  6%      -0.1        0.20 ± 57%  perf-profile.self.cycles-pp.select_task_rq
      0.17 ±  2%      -0.1        0.06 ±  8%      -0.1        0.12 ± 57%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.23 ±  2%      -0.1        0.11 ±  4%      -0.1        0.16 ± 57%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.19            -0.1        0.08 ±  6%      -0.1        0.14 ± 57%  perf-profile.self.cycles-pp.update_rq_clock
      0.20 ±  2%      -0.1        0.09            -0.0        0.16 ± 57%  perf-profile.self.cycles-pp.check_stack_object
      0.18 ±  2%      -0.1        0.06 ±  7%      -0.0        0.14 ± 57%  perf-profile.self.cycles-pp.wake_q_add_safe
      0.18            -0.1        0.07            +0.2        0.38 ± 57%  perf-profile.self.cycles-pp.__account_obj_stock
      0.21 ±  2%      -0.1        0.10 ±  4%      -0.0        0.16 ± 57%  perf-profile.self.cycles-pp.__kmalloc_cache_noprof
      0.24            -0.1        0.14            -0.1        0.18 ± 57%  perf-profile.self.cycles-pp.__dequeue_entity
      0.19            -0.1        0.10 ±  4%      -0.0        0.14 ± 57%  perf-profile.self.cycles-pp.pick_task_fair
      0.14 ±  3%      -0.1        0.05            -0.0        0.11 ± 57%  perf-profile.self.cycles-pp.inode_set_ctime_current
      0.16 ±  3%      -0.1        0.06 ±  7%      -0.0        0.11 ± 57%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.16            -0.1        0.07            -0.0        0.12 ± 57%  perf-profile.self.cycles-pp.schedule_idle
      0.15            -0.1        0.06            -0.0        0.11 ± 57%  perf-profile.self.cycles-pp.avg_vruntime
      0.08            -0.1        0.00            -0.0        0.05 ± 57%  perf-profile.self.cycles-pp.security_msg_msg_free
      0.07            -0.1        0.00            -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.15            -0.1        0.08 ±  5%      -0.0        0.11 ± 57%  perf-profile.self.cycles-pp.dl_server_update
      0.15            -0.1        0.08 ±  5%      -0.0        0.11 ± 57%  perf-profile.self.cycles-pp.raw_spin_rq_lock_nested
      0.12            -0.1        0.05 ±  8%      -0.0        0.09 ± 57%  perf-profile.self.cycles-pp.migrate_disable_switch
      0.12 ±  4%      -0.1        0.05            -0.0        0.09 ± 57%  perf-profile.self.cycles-pp.__x64_sys_mq_timedreceive
      0.13            -0.1        0.07 ±  7%      -0.0        0.09 ± 57%  perf-profile.self.cycles-pp.___task_rq_lock
      0.09 ±  5%      -0.1        0.03 ± 70%      -0.0        0.08 ± 57%  perf-profile.self.cycles-pp.inode_set_ctime_to_ts
      0.22            -0.1        0.16            -0.1        0.16 ± 57%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.12            -0.1        0.06            -0.0        0.08 ± 57%  perf-profile.self.cycles-pp.store_msg
      0.12            -0.1        0.06            -0.0        0.08 ± 57%  perf-profile.self.cycles-pp.wakeup_preempt_fair
      0.11 ±  4%      -0.1        0.05 ±  8%      -0.0        0.08 ± 57%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.11            -0.1        0.05            -0.0        0.09 ± 57%  perf-profile.self.cycles-pp.timestamp_truncate
      0.12 ±  4%      -0.1        0.06 ±  7%      -0.0        0.09 ± 57%  perf-profile.self.cycles-pp.do_perf_trace_sched_stat_runtime
      0.11 ±  4%      -0.1        0.06 ±  8%      -0.0        0.08 ± 57%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.13 ±  3%      -0.0        0.08            -0.0        0.10 ± 57%  perf-profile.self.cycles-pp.update_curr_dl_se
      0.15            -0.0        0.11 ±  4%      -0.0        0.11 ± 57%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.09            -0.0        0.05 ±  8%      -0.0        0.07 ± 57%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.14 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ± 57%  perf-profile.self.cycles-pp.vruntime_eligible
      0.14 ±  3%      -0.0        0.11            -0.0        0.10 ± 57%  perf-profile.self.cycles-pp.ktime_get
      0.07 ±  7%      -0.0        0.03 ± 70%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.__set_next_task_fair
      0.15 ±  3%      -0.0        0.13            -0.0        0.12 ± 57%  perf-profile.self.cycles-pp.put_prev_entity
      0.11 ±  4%      +0.0        0.12 ±  3%      -0.0        0.08 ± 57%  perf-profile.self.cycles-pp.set_next_task_idle
      0.06            +0.0        0.08 ±  6%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.perf_swevent_event
      0.07 ±  7%      +0.0        0.09 ± 10%      +0.0        0.07 ± 58%  perf-profile.self.cycles-pp.mq_timedsend
      0.00            +0.1        0.05            +0.0        0.00        perf-profile.self.cycles-pp.ct_idle_enter
      0.00            +0.1        0.05            +0.0        0.00        perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.00            +0.1        0.06            +0.0        0.00        perf-profile.self.cycles-pp.sched_update_worker
      0.12            +0.1        0.18 ±  6%      -0.0        0.09 ± 57%  perf-profile.self.cycles-pp.x64_sys_call
      0.38 ±  2%      +0.1        0.46            -0.1        0.28 ± 57%  perf-profile.self.cycles-pp.finish_task_switch
      0.08 ±  5%      +0.1        0.20 ±  6%      -0.0        0.06 ± 57%  perf-profile.self.cycles-pp.do_perf_trace_sched_switch
      0.18 ±  5%      +0.5        0.71 ±  3%      -0.0        0.14 ± 57%  perf-profile.self.cycles-pp.update_sg_lb_stats
      5.89            +0.9        6.81            -1.5        4.43 ± 57%  perf-profile.self.cycles-pp.intel_idle
      0.07            +7.4        7.48 ±  4%      +0.1        0.14 ± 57%  perf-profile.self.cycles-pp.__refill_obj_stock
      0.00            +8.7        8.70 ±  3%      +0.0        0.00        perf-profile.self.cycles-pp.drain_obj_stock
      2.25           +12.4       14.61            -0.3        1.90 ± 57%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.53           +19.0       19.48            +0.1        0.60 ± 57%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook


> 
> > > 
> > > From: Shakeel Butt <shakeel.butt@linux.dev>
> > > Subject: [PATCH] memcg: shrink obj_stock_pcp and cache multiple objcgs
> > > 
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > >  mm/memcontrol.c | 213 +++++++++++++++++++++++++++++++++++-------------
> > >  1 file changed, 156 insertions(+), 57 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index d978e18b9b2d..2a9e5136a956 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -150,14 +150,14 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> > >  	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
> > >  	 *
> > >  	 * The following sequence can lead to it:
> > > -	 * 1) CPU0: objcg == stock->cached_objcg
> > > +	 * 1) CPU0: objcg cached in one of stock->cached[i]
> > >  	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
> > >  	 *          PAGE_SIZE bytes are charged
> > >  	 * 3) CPU1: a process from another memcg is allocating something,
> > >  	 *          the stock if flushed,
> > >  	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
> > >  	 * 5) CPU0: we do release this object,
> > > -	 *          92 bytes are added to stock->nr_bytes
> > > +	 *          92 bytes are added to stock->nr_bytes[i]
> > >  	 * 6) CPU0: stock is flushed,
> > >  	 *          92 bytes are added to objcg->nr_charged_bytes
> > >  	 *
> > > @@ -2017,13 +2017,25 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
> > >  	.lock = INIT_LOCAL_TRYLOCK(lock),
> > >  };
> > >  
> > > +/*
> > > + * NR_OBJ_STOCK is sized so the entire hot path of obj_stock_pcp
> > > + * (lock, accounting metadata, nr_bytes[] and cached[]) fits within a
> > > + * single 64-byte cache line on non-debug 64-bit builds. With 5 slots:
> > > + *   lock(1) + index(1) + node_id(2) + slab stats(4) + nr_bytes(10)
> > > + *   + pad(6) + cached(40) == 64 bytes.
> > > + * A CPU can thus consume/refill/account against five different objcgs
> > > + * (typically per-node variants of the same memcg) while incurring at
> > > + * most one cache miss on the stock.
> > > + */
> > > +#define NR_OBJ_STOCK 5
> > >  struct obj_stock_pcp {
> > >  	local_trylock_t lock;
> > > -	unsigned int nr_bytes;
> > > -	struct obj_cgroup *cached_objcg;
> > > -	struct pglist_data *cached_pgdat;
> > > -	int nr_slab_reclaimable_b;
> > > -	int nr_slab_unreclaimable_b;
> > > +	int8_t index;
> > > +	int16_t node_id;
> > > +	int16_t nr_slab_reclaimable_b;
> > > +	int16_t nr_slab_unreclaimable_b;
> > > +	uint16_t nr_bytes[NR_OBJ_STOCK];
> > > +	struct obj_cgroup *cached[NR_OBJ_STOCK];
> > >  
> > >  	struct work_struct work;
> > >  	unsigned long flags;
> > > @@ -2031,10 +2043,13 @@ struct obj_stock_pcp {
> > >  
> > >  static DEFINE_PER_CPU_ALIGNED(struct obj_stock_pcp, obj_stock) = {
> > >  	.lock = INIT_LOCAL_TRYLOCK(lock),
> > > +	.index = -1,
> > > +	.node_id = NUMA_NO_NODE,
> > >  };
> > >  
> > >  static DEFINE_MUTEX(percpu_charge_mutex);
> > >  
> > > +static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i);
> > >  static void drain_obj_stock(struct obj_stock_pcp *stock);
> > >  static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
> > >  				     struct mem_cgroup *root_memcg);
> > > @@ -3152,39 +3167,68 @@ static void unlock_stock(struct obj_stock_pcp *stock)
> > >  		local_unlock(&obj_stock.lock);
> > >  }
> > >  
> > > -/* Call after __refill_obj_stock() to ensure stock->cached_objg == objcg */
> > > +/* Call after __refill_obj_stock() so a slot for objcg exists in the stock */
> > >  static void __account_obj_stock(struct obj_cgroup *objcg,
> > >  				struct obj_stock_pcp *stock, int nr,
> > >  				struct pglist_data *pgdat, enum node_stat_item idx)
> > >  {
> > > -	int *bytes;
> > > +	int16_t *bytes;
> > > +	int i;
> > >  
> > > -	if (!stock || READ_ONCE(stock->cached_objcg) != objcg)
> > > +	/*
> > > +	 * node_id is stored as int16_t and -1 is used as the "no pgdat
> > > +	 * cached" sentinel, so MAX_NUMNODES must fit in a positive int16_t.
> > > +	 */
> > > +	BUILD_BUG_ON(MAX_NUMNODES >= S16_MAX);
> > > +
> > > +	if (!stock)
> > > +		goto direct;
> > > +
> > > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > > +		if (READ_ONCE(stock->cached[i]) == objcg)
> > > +			break;
> > > +	}
> > > +	if (i == NR_OBJ_STOCK)
> > >  		goto direct;
> > >  
> > >  	/*
> > >  	 * Save vmstat data in stock and skip vmstat array update unless
> > > -	 * accumulating over a page of vmstat data or when pgdat changes.
> > > +	 * accumulating over a page of vmstat data or when the objcg slot or
> > > +	 * pgdat the stats belong to changes.
> > >  	 */
> > > -	if (stock->cached_pgdat != pgdat) {
> > > -		/* Flush the existing cached vmstat data */
> > > -		struct pglist_data *oldpg = stock->cached_pgdat;
> > > +	if (stock->index < 0) {
> > > +		stock->index = i;
> > > +		stock->node_id = pgdat->node_id;
> > > +	} else if (stock->index != i || stock->node_id != pgdat->node_id) {
> > > +		struct obj_cgroup *old = READ_ONCE(stock->cached[stock->index]);
> > > +		struct pglist_data *oldpg = NODE_DATA(stock->node_id);
> > >  
> > >  		if (stock->nr_slab_reclaimable_b) {
> > > -			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
> > > +			mod_objcg_mlstate(old, oldpg, NR_SLAB_RECLAIMABLE_B,
> > >  					  stock->nr_slab_reclaimable_b);
> > >  			stock->nr_slab_reclaimable_b = 0;
> > >  		}
> > >  		if (stock->nr_slab_unreclaimable_b) {
> > > -			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
> > > +			mod_objcg_mlstate(old, oldpg, NR_SLAB_UNRECLAIMABLE_B,
> > >  					  stock->nr_slab_unreclaimable_b);
> > >  			stock->nr_slab_unreclaimable_b = 0;
> > >  		}
> > > -		stock->cached_pgdat = pgdat;
> > > +		stock->index = i;
> > > +		stock->node_id = pgdat->node_id;
> > >  	}
> > >  
> > >  	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
> > >  					       : &stock->nr_slab_unreclaimable_b;
> > > +	/*
> > > +	 * Cached stats are int16_t; flush directly if accumulating @nr would
> > > +	 * overflow or underflow the cache.
> > > +	 */
> > > +	if (abs(nr + *bytes) >= S16_MAX) {
> > > +		nr += *bytes;
> > > +		*bytes = 0;
> > > +		goto direct;
> > > +	}
> > > +
> > >  	/*
> > >  	 * Even for large object >= PAGE_SIZE, the vmstat data will still be
> > >  	 * cached locally at least once before pushing it out.
> > > @@ -3210,10 +3254,16 @@ static bool __consume_obj_stock(struct obj_cgroup *objcg,
> > >  				struct obj_stock_pcp *stock,
> > >  				unsigned int nr_bytes)
> > >  {
> > > -	if (objcg == READ_ONCE(stock->cached_objcg) &&
> > > -	    stock->nr_bytes >= nr_bytes) {
> > > -		stock->nr_bytes -= nr_bytes;
> > > -		return true;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > > +		if (READ_ONCE(stock->cached[i]) != objcg)
> > > +			continue;
> > > +		if (stock->nr_bytes[i] >= nr_bytes) {
> > > +			stock->nr_bytes[i] -= nr_bytes;
> > > +			return true;
> > > +		}
> > > +		return false;
> > >  	}
> > >  
> > >  	return false;
> > > @@ -3234,16 +3284,42 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> > >  	return ret;
> > >  }
> > >  
> > > -static void drain_obj_stock(struct obj_stock_pcp *stock)
> > > +/* Flush the cached slab stats (if any) back to their owning objcg/pgdat. */
> > > +static void drain_obj_stock_stats(struct obj_stock_pcp *stock)
> > > +{
> > > +	struct obj_cgroup *old;
> > > +	struct pglist_data *oldpg;
> > > +
> > > +	if (stock->index < 0)
> > > +		return;
> > > +
> > > +	old = READ_ONCE(stock->cached[stock->index]);
> > > +	oldpg = NODE_DATA(stock->node_id);
> > > +
> > > +	if (stock->nr_slab_reclaimable_b) {
> > > +		mod_objcg_mlstate(old, oldpg, NR_SLAB_RECLAIMABLE_B,
> > > +				  stock->nr_slab_reclaimable_b);
> > > +		stock->nr_slab_reclaimable_b = 0;
> > > +	}
> > > +	if (stock->nr_slab_unreclaimable_b) {
> > > +		mod_objcg_mlstate(old, oldpg, NR_SLAB_UNRECLAIMABLE_B,
> > > +				  stock->nr_slab_unreclaimable_b);
> > > +		stock->nr_slab_unreclaimable_b = 0;
> > > +	}
> > > +	stock->index = -1;
> > > +	stock->node_id = NUMA_NO_NODE;
> > > +}
> > > +
> > > +static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i)
> > >  {
> > > -	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
> > > +	struct obj_cgroup *old = READ_ONCE(stock->cached[i]);
> > >  
> > >  	if (!old)
> > >  		return;
> > >  
> > > -	if (stock->nr_bytes) {
> > > -		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> > > -		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
> > > +	if (stock->nr_bytes[i]) {
> > > +		unsigned int nr_pages = stock->nr_bytes[i] >> PAGE_SHIFT;
> > > +		unsigned int nr_bytes = stock->nr_bytes[i] & (PAGE_SIZE - 1);
> > >  
> > >  		if (nr_pages) {
> > >  			struct mem_cgroup *memcg;
> > > @@ -3269,44 +3345,43 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
> > >  		 * so it might be changed in the future.
> > >  		 */
> > >  		atomic_add(nr_bytes, &old->nr_charged_bytes);
> > > -		stock->nr_bytes = 0;
> > > +		stock->nr_bytes[i] = 0;
> > >  	}
> > >  
> > > -	/*
> > > -	 * Flush the vmstat data in current stock
> > > -	 */
> > > -	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
> > > -		if (stock->nr_slab_reclaimable_b) {
> > > -			mod_objcg_mlstate(old, stock->cached_pgdat,
> > > -					  NR_SLAB_RECLAIMABLE_B,
> > > -					  stock->nr_slab_reclaimable_b);
> > > -			stock->nr_slab_reclaimable_b = 0;
> > > -		}
> > > -		if (stock->nr_slab_unreclaimable_b) {
> > > -			mod_objcg_mlstate(old, stock->cached_pgdat,
> > > -					  NR_SLAB_UNRECLAIMABLE_B,
> > > -					  stock->nr_slab_unreclaimable_b);
> > > -			stock->nr_slab_unreclaimable_b = 0;
> > > -		}
> > > -		stock->cached_pgdat = NULL;
> > > -	}
> > > +	/* Flush vmstat data when its owning slot is being drained. */
> > > +	if (stock->index == i)
> > > +		drain_obj_stock_stats(stock);
> > >  
> > > -	WRITE_ONCE(stock->cached_objcg, NULL);
> > > +	WRITE_ONCE(stock->cached[i], NULL);
> > >  	obj_cgroup_put(old);
> > >  }
> > >  
> > > +static void drain_obj_stock(struct obj_stock_pcp *stock)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < NR_OBJ_STOCK; ++i)
> > > +		drain_obj_stock_slot(stock, i);
> > > +}
> > > +
> > >  static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
> > >  				     struct mem_cgroup *root_memcg)
> > >  {
> > > -	struct obj_cgroup *objcg = READ_ONCE(stock->cached_objcg);
> > > +	struct obj_cgroup *objcg;
> > >  	struct mem_cgroup *memcg;
> > >  	bool flush = false;
> > > +	int i;
> > >  
> > >  	rcu_read_lock();
> > > -	if (objcg) {
> > > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > > +		objcg = READ_ONCE(stock->cached[i]);
> > > +		if (!objcg)
> > > +			continue;
> > >  		memcg = obj_cgroup_memcg(objcg);
> > > -		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
> > > +		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg)) {
> > >  			flush = true;
> > > +			break;
> > > +		}
> > >  	}
> > >  	rcu_read_unlock();
> > >  
> > > @@ -3319,6 +3394,8 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > >  			       bool allow_uncharge)
> > >  {
> > >  	unsigned int nr_pages = 0;
> > > +	unsigned int stock_nr_bytes;
> > > +	int i, slot = -1, empty_slot = -1;
> > >  
> > >  	if (!stock) {
> > >  		nr_pages = nr_bytes >> PAGE_SHIFT;
> > > @@ -3327,21 +3404,43 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > >  		goto out;
> > >  	}
> > >  
> > > -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> > > -		drain_obj_stock(stock);
> > > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > > +		struct obj_cgroup *cached = READ_ONCE(stock->cached[i]);
> > > +
> > > +		if (!cached) {
> > > +			if (empty_slot == -1)
> > > +				empty_slot = i;
> > > +			continue;
> > > +		}
> > > +		if (cached == objcg) {
> > > +			slot = i;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (slot == -1) {
> > > +		slot = empty_slot;
> > > +		if (slot == -1) {
> > > +			slot = get_random_u32_below(NR_OBJ_STOCK);
> > > +			drain_obj_stock_slot(stock, slot);
> > > +		}
> > >  		obj_cgroup_get(objcg);
> > > -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> > > +		stock->nr_bytes[slot] = atomic_read(&objcg->nr_charged_bytes)
> > >  				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> > > -		WRITE_ONCE(stock->cached_objcg, objcg);
> > > +		WRITE_ONCE(stock->cached[slot], objcg);
> > >  
> > >  		allow_uncharge = true;	/* Allow uncharge when objcg changes */
> > >  	}
> > > -	stock->nr_bytes += nr_bytes;
> > >  
> > > -	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
> > > -		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> > > -		stock->nr_bytes &= (PAGE_SIZE - 1);
> > > +	stock_nr_bytes = (unsigned int)stock->nr_bytes[slot] + nr_bytes;
> > > +
> > > +	/* nr_bytes[] is uint16_t; flush if we would refill >= U16_MAX. */
> > > +	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
> > > +	    stock_nr_bytes >= U16_MAX) {
> > > +		nr_pages = stock_nr_bytes >> PAGE_SHIFT;
> > > +		stock_nr_bytes &= (PAGE_SIZE - 1);
> > >  	}
> > > +	stock->nr_bytes[slot] = stock_nr_bytes;
> > >  
> > >  out:
> > >  	if (nr_pages)
> > > -- 
> > > 2.53.0-Meta
> > > 

