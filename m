Return-Path: <cgroups+bounces-16008-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CQTH/W6CWodnAQAu9opvQ
	(envelope-from <cgroups+bounces-16008-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 14:56:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F95610B6
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EA563003989
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163A736308D;
	Sun, 17 May 2026 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wf+zkuH6"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2946173;
	Sun, 17 May 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022575; cv=fail; b=PRWvP7WoOmHV6g9c5M8L8NrsNprLVZu9uRphwdYMypMS3+023BmKIJQtORFzFiZ0OVaL1hvJFuQXBPp+1ZXZBR7kpDLm9jiGbgeHHuzDhGrHRt94MT2Jhl/Vr0N68TJv7Bus9zIMpJzXdrtRK9DCIxswKdKCX0okZ89wKx1j4tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022575; c=relaxed/simple;
	bh=vfg/1yKD2XvQvwy+PL7qLSPs3Alut0POnctqYLakTCY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WykKLs53UqnaSVLt5OTq954GEw3g+Rhb28p06BoK969ZuPElp7FHmNPqdzlxi+5KCoLYx2RX3UdTz11Q/UXe5118cPg8HOt2Rhh42DaiUHo8LlpxOqNbaA8jK0kiApEePeOAeT3cc/8sXf3vD9kr3iyY86+AI18XA8M/LjUkzPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wf+zkuH6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779022571; x=1810558571;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vfg/1yKD2XvQvwy+PL7qLSPs3Alut0POnctqYLakTCY=;
  b=Wf+zkuH63Quylbqk8gvB7Hhu6Zee9HAyZUl6AUwz9IBcczTpq/OW1uic
   dhgx5tkZr5iSMe0J3wATqcNmNjI5D0kD7NAme1sSbzdBT1o5UpFcqb2h6
   D/T4YZ7LJI2DOH0vaxhBGEAasfIuCT5WABHUoU8n7VKlhIXOwMIbIrWsn
   FnlO9KYqhrBa4k0Qr2q6GOAnrakeHBnmeXkcnc69x0z98ENFLe0U03zE4
   h2ULvW+uSDDmqJfZdsyuCtIFG02iT67lXSgyvmnd6rivQ1vEEcMtOFlKm
   BeH8d22Gzz5bEAT6uhPUc6Qtozad7d3N5o1CqPRamec7E1a5oKrLHbqTB
   Q==;
X-CSE-ConnectionGUID: Q2e3vRxBSrG4HoIm2nmFRw==
X-CSE-MsgGUID: pEN644iYT2ym3O2njwUJ/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79868185"
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; 
   d="scan'208";a="79868185"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 05:56:09 -0700
X-CSE-ConnectionGUID: 4p1pW7liRdKazkq6e/7jOg==
X-CSE-MsgGUID: LFzxT3SMT+2dpMNmMa/t9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; 
   d="scan'208";a="240989698"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 05:56:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 17 May 2026 05:56:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 17 May 2026 05:56:07 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 17 May 2026 05:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU7Cm8FzSsJPMl3DjNzypixzsfc9fCauQp/Vxr65otPA1KPfHLzROy5eZCelZpzobQUyXpCKF2EUzGCd5iOsrQpxIXExaGfdJr310TCqK7ZJIsewY2KlSGaQ/xQLuzoLTfBvauiduyvOeVWGkRAtRKgmeLbyccYuHNZ0vZ+xjtntUxMn9/vsT+GE//52OIxE1c+TWj3OqWRL18vL35t9lBgYckeqOLPD2luNqPLtJcw16nMrNI9vNe7GcR4r4KKP+ko8s5rgsHZP7AFlZ691aDS8lIYHnnAN1e8M0k+TZ+O9cLL6sZOpnVevN2t7MK9E84Sqr3qUX8/zonUWjly4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M42P3Ylmc3cDuyQaw3R+yQXOp76XeXwh/J0d1bvhGus=;
 b=hbtRnOIWh2fvTQ1GQegPD1/CpkkFs04uRbwz48SGMqF6pKnxDkW5VHugM52tU4aFBHW0QOsnpEoFrnElGjU27HsnWvxT0S+EVf4x0mBTGXU7gWLLLX5FmfGus5OKeGZAPcMTqvgkAN4kRiTQuLSQxFeaW52+eN4LPgcc0tB2+/HCF20NvMSKiZoOyidX9bctDre2WpwIjK8BUkIFnfPCV6MEY020IdnkO2iBr8nUSaZjDoC1i9X8HJniOdrl3SlDKf/iQp1bAGob5e5sPKRsjpLjQhUX/nrweqSxYnA5tnl+mIY0+qjSNV+Mqp0gK3XAogBdLXo2YEenKf4FNZ1kIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 12:56:03 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 12:56:03 +0000
Date: Sun, 17 May 2026 20:55:50 +0800
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
Message-ID: <agm61hMv08XnV8sI@xsang-OptiPlex-9020>
References: <202605121641.b6a60cb0-lkp@intel.com>
 <agNO8G8tPnPuVrGq@linux.dev>
 <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev>
 <agSAT4ldp3dzKWPl@linux.dev>
 <agSJ4ulNDZ17ah8H@linux.dev>
 <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
 <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
 <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
 <agdS5rIhcjIBVSog@linux.dev>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agdS5rIhcjIBVSog@linux.dev>
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH3PR11MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec90f4e-08f7-44dd-02f1-08deb413a6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|4143699003|18002099003|11063799003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: XRoSc75mIJwJqnGV8DpMgGvWZddzW6xk2g2v03aFXB2G4DZzuZ0UL0cwh/FGbkIMBmxPA2zKJuNJXJtHLL0x92WZsxAglM9BU85aBc9HtV6uIsZsc0avLiggsB+lrMvw3yLBQXXvhco6wXqoXTomqy0BohZVu/+suasBJ0d3RffD/l491wzbiMNWuXr4tSunJZU0u41lMZji2QJXx5ZpIhVGFZsmqtL5OvlxDStWHlquD4ue6xpShtpBdmeG1nw/Fnsjc0CZ/V+6XDzCAtbSIAgYnKDWy5WGpucn/ozFos6yexuf1P04j/jlUnRVwuS5nKVHb286Y8El+uvQF7pCrqFUl0uypYT1V2f7Gwdnu7xypLEa07IwM9ajvLIK8UvyKxvaBOGwN3B+otL0zY1zGpR+N+93IOPS1ExCBOe/9NblNKezH0jki5J3X0h+ZTFujZuFSY6J123SyMAqKCO94NaTcez0WoNWes0o0pCQqOM7BR4uY7pqCxyNmCf72tB2O7klIfhOvbCegiLJXCZ4qgW6POtb8LIRXmhLB99JkhEG+112pDCOTvzGvKpiYyVUCGUbJu+JabdsBZps7uTJtkPSBrK5n68EjYLug1DWGA3+rOoHoLi0CbzhmgdshcZ/ttvaLxGULJXB1lPCXFz+7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(4143699003)(18002099003)(11063799003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HU66J1lc2zNLAHL71rjpR5Ebw6JmTxfgnJ9dHrP9yVwOU5B6MwDBFoQbte?=
 =?iso-8859-1?Q?51D0+vkMsOdxBwbBdA5YRXuFjCpiAxRuhF8TIyRrie7KIaxkTSJkSUEdLg?=
 =?iso-8859-1?Q?bdn6p9Rs4PkxYQGI4cQ/ypuvjFhYYR29en6kDS3s7+9L5EGzM8b/ipd3uD?=
 =?iso-8859-1?Q?6Ia6jEE4ySnvD9ubLu0gPPgRip4MsFWiaq2cPm3Vm309HlzbxprHHTFNd7?=
 =?iso-8859-1?Q?OOywFBogk51neHsEPEtC2H8HoZLRak8aTR22R1u+0iPNYXx2S+hSe5OJZE?=
 =?iso-8859-1?Q?yKwXV5uI7sSVPPIvaUoZifCh4c2WcbRDpU3ho+II9MNWCOSgFfkZj3+GxE?=
 =?iso-8859-1?Q?YeoDwqsxNslnjZTuojWXkfQi3RTlX1sKHQ46sZWOtessfFyiIRUh8slqF6?=
 =?iso-8859-1?Q?60N8vfrE1vrcbO80k/DvhHCMZ1+a0wQNzHjVYFDAxr/6BhHzV5WuZiIbJ4?=
 =?iso-8859-1?Q?en4DSv6FfcZo1EQg3mPYA7z/3AEG9p0rIXp7D9F7RMIujVBNo6e9LFMMu8?=
 =?iso-8859-1?Q?zYR5su7R6/HYz788cXoXPWW6z48qpTEiYb9bUJGMp2Q+eY4JgphUJUKSr3?=
 =?iso-8859-1?Q?S/jBscM3ZFXJCcM9fZrBGeGxXn+6pIFUuNJ4hkXx2W5AJATNr1X3k2pNC4?=
 =?iso-8859-1?Q?vTiu4VH27zp+boFvwOQs5372bc+zbfsrUAsoiIZyx/bstiE9aZLhDVL6qc?=
 =?iso-8859-1?Q?7I8BHohSVrCiE6aQCPgF+ozYvwQe00782Ynoh3SFNLxm0Kaaauonxnz4t9?=
 =?iso-8859-1?Q?zovzXWs8iQoMeJbioVWRQzG9xbXrZNbXJ+xi6tuVbJtlGhhbIzsht0ATi3?=
 =?iso-8859-1?Q?lWKqSNfPIEqD+JXZ1Rath+4kUAXBp+yGt0x5eCYHHgdrMTm+w/MOzMrJwQ?=
 =?iso-8859-1?Q?EdKkNB4bon/PrEGgp/80reV71R92DIITtmkxrpVHO/hO9PHoU7gKBy/V2f?=
 =?iso-8859-1?Q?/O+B85CLnOe7CkIU328470dLKItOVHYCt4/jqs5ZgOEOvpMApKq/VtHPa0?=
 =?iso-8859-1?Q?uFZhLshliSx0UteQOtDOwmsmKoZdeJGmt9meBtaGpjh3m4QXqfAO18iNXJ?=
 =?iso-8859-1?Q?qz+fui/Jsp3kDD473D1cot7YRMWwPNWa0rJ97Xq3dZgSEPuMMOX9kTePMR?=
 =?iso-8859-1?Q?/ZkhA9Iy7tW8Etqiar+7mF6Tc8UG/RseljfOcbNiGTTPT1+fUh1rjCAPTA?=
 =?iso-8859-1?Q?BAlyqoh5izxLyDCS4utNkw/SfzYAsbPjcFjLTLT0sx339RI6q/ZC1rz541?=
 =?iso-8859-1?Q?6MX/6ft016j1ZyiOLZTH7VOBXHt99SWsTEODIQzRm1vjrh2d2E60bg9/k1?=
 =?iso-8859-1?Q?3FFW0GEx1287bbcAQWgbPpFoC16rNRSsMD5oIU0wex7Tp3pd5kgtLpTbgZ?=
 =?iso-8859-1?Q?fGa3etckAlNbeBNOC+TkGKCdmlCoX1GRI4fiTSgJbUtErfm6Eat63xWSXO?=
 =?iso-8859-1?Q?hHQFbOvRng0L9ZrnBZA9518fNKREoATkFpG76aIy7wh0o4S5KbA3+1BCwg?=
 =?iso-8859-1?Q?zEEN42eZqWp8Vc87y+693ztEsNN1kIVcedFGRj5GLr30mpg44IL/DdeNSn?=
 =?iso-8859-1?Q?CWHZTBVgKKaFDHQHJOW9GkWC317rIbpykVGFbqCrVWpBVt3ByFaZ8+AsO5?=
 =?iso-8859-1?Q?Tok8FVr/mipITBCCpwlNtb1XqnlM2T9ZlRbGLNDSAU63rurWlOfQen2maz?=
 =?iso-8859-1?Q?GsYc59fsZ8o3vu4uPWGoTHi/m5wnP0kL9NtNoYIuqv/9b25gnkp/g896A0?=
 =?iso-8859-1?Q?MJM6HWk1TyW1GZqDMXlDb9kwpZZSy7LZANvt9lAiXYIpbzOm0/s/iiTqps?=
 =?iso-8859-1?Q?ZXKDM86jzQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: UzKf5ti+RGL8LyjooC197Hy6SV0ZUNtvrV5s/n0KOeM4rCTukuj/jHyU2y4VV87fi9L8qIXiBA1e0y9QxZ5TB19umpvu5P0VA1lFN1vEqDoXR4ksmPUnRkVsUDCTneB3iQjnFl0lSl52itPIBys2D0+trrdM4dYthM85xjP24hQ8aCEykc4qyQfqu0O5X5jaBEJOfje1qdTqrbvg8x+k5uBJJLRMbSVjFuwAy/vyFXFe3t2NeKYkMDYVwoqhlsVV+J5R2JTrudu/uhByI9aVlXSb3MImkP7md/NH6wv+RHx5+/ID/Y398RuV5iXBX6SIKuRLt+p2ipbRdtJJ14UygA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec90f4e-08f7-44dd-02f1-08deb413a6ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 12:56:03.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHeEpljXFKwAHgzlolKHo1ZxMG9UTBYjicyLLKbQRKC2Roev6zXjbsfX0ocJDGYsghNk4xxYD2mBvMgpw7e+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8414
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A08F95610B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16008-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
X-Rspamd-Action: no action

hi, Shakeel, hi, Qi,

On Fri, May 15, 2026 at 10:09:06AM -0700, Shakeel Butt wrote:
> On Fri, May 15, 2026 at 03:37:22PM +0800, Qi Zheng wrote:
> > Hi Shakeel,
> > 
> > On 5/14/26 9:40 PM, Shakeel Butt wrote:
> > > May 14, 2026 at 12:46 AM, "Qi Zheng" <qi.zheng@linux.dev mailto:qi.zheng@linux.dev?to=%22Qi%20Zheng%22%20%3Cqi.zheng%40linux.dev%3E > wrote:
> > > 
> > > 
> > > > 
> > > > On 5/13/26 10:27 PM, Shakeel Butt wrote:
> > > > 
> > > > > 
> > > > > On Wed, May 13, 2026 at 06:49:45AM -0700, Shakeel Butt wrote:
> > > > > 
> > > > > > 
> > > > > > On Wed, May 13, 2026 at 10:10:34AM +0800, Qi Zheng wrote:
> > > > > > 
> > > > >   On 5/13/26 12:03 AM, Shakeel Butt wrote:
> > > > >   On Tue, May 12, 2026 at 08:56:52PM +0800, kernel test robot wrote:
> > > > > 
> > > > >   Hello,
> > > > > 
> > > > >   kernel test robot noticed a 67.7% regression of stress-ng.switch.ops_per_sec on:
> > > > > 
> > > > >   commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> > > > >   https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > 
> > > > >   This is most probably due to shuffling of struct mem_cgroup and struct
> > > > >   mem_cgroup_per_node members.
> > > > > 
> > > > >   Another possibility is that after objcg was split into per-node, the
> > > > >   slab accounting fast path is still designed assuming only one current
> > > > >   objcg per CPU:
> > > > > 
> > > > >   struct obj_stock_pcp {
> > > > >   struct obj_cgroup *cached_objcg;
> > > > >   };
> > > > > 
> > > > >   So it's may cause the following thrashing:
> > > > > 
> > > > >   CPU stock cached = memcg/node0 objcg
> > > > >   free object tagged = memcg/node1 objcg
> > > > >   => __refill_obj_stock --> objcg mismatch
> > > > >   => drain_obj_stock()
> > > > >   => cache switches to node1 objcg
> > > > > 
> > > > >   next local allocation tagged = node0 objcg
> > > > >   => mismatch again
> > > > >   => drain_obj_stock()
> > > > > 
> > > > > > 
> > > > > > Actually I think this is the issue, we have ping pong threads running on
> > > > > >   different nodes where though theu are in same cgroup but their current->obcg is
> > > > > >   for local node and thus this ping pong is thrashing the per-cpu objcg stock.
> > > > > > 
> > > > > >   The easier fix would be to compare objcg->memcg instead of just objcg during
> > > > > >   draining and caching. In addition we can add support for multiple objcg per-cpu
> > > > > >   stock caching.
> > > > > > 
> > > > >   Something like the following:
> > > > >   From d756abe831a905d6fe32bad9a984fc619dafb7e0 Mon Sep 17 00:00:00 2001
> > > > >   From: Shakeel Butt <shakeel.butt@linux.dev>
> > > > >   Date: Wed, 13 May 2026 07:24:55 -0700
> > > > >   Subject: [PATCH] mm/memcontrol: skip obj_stock drain when refilled objcg
> > > > >   shares memcg
> > > > >   Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > >   ---
> > > > >   mm/memcontrol.c | 14 +++++++++++++-
> > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > >   diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > >   index d978e18b9b2d..01ed7a8e18ac 100644
> > > > >   --- a/mm/memcontrol.c
> > > > >   +++ b/mm/memcontrol.c
> > > > >   @@ -3318,6 +3318,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > > > >   unsigned int nr_bytes,
> > > > >   bool allow_uncharge)
> > > > >   {
> > > > >   + struct obj_cgroup *cached;
> > > > >   unsigned int nr_pages = 0;
> > > > >   > if (!stock) {
> > > > >   @@ -3327,7 +3328,18 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > > > >   goto out;
> > > > >   }
> > > > >   > - if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> > > > >   + cached = READ_ONCE(stock->cached_objcg);
> > > > >   + if (cached != objcg &&
> > > > >   + (!cached || obj_cgroup_memcg(cached) != obj_cgroup_memcg(objcg))) {
> > > > >   drain_obj_stock(stock);
> > > > >   obj_cgroup_get(objcg);
> > > > >   stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> > > > > 
> > > > This change looks like it should be able to fix the ping-pong issue, but
> > > > I stiil haven't reproduced the performance regression locally. I'll
> > > > continue testing it.
> > > 
> > > Same here, couldn't reproduce locally. It seems like we had to craft a scenario
> > > where the pair pingpong threads get their current->objcg from different nodes.
> > > I will try that.
> > 
> > I still haven't been able to reproduce the LKP results locally, but I
> > used an AI bot to generate a pingpong test case (pasted at the end) and
> > automatically ran the test on a physical machine. The results are as
> > follows:
> > 
> >   parent: 8285917d6f
> >   bad:    01b9da291c
> >   fix:    01b9da291c + stock patch
> > 
> >   | kernel | mq_ops/sec mean | vs parent | drain_obj_stock / round |
> >   |--------|-----------------|-----------|-------------------------|
> >   | parent |     9.743M      |  baseline |          ~0             |
> >   | bad    |     7.821M      |  -19.73%  |          ~11.16M        |
> >   | fix    |     9.274M      |  -4.81%   |          ~0             |
> > 
> > Probing the drain_obj_stock() calls confirms that the fix restores the
> > frequency to the parent's baseline.
> > 
> > And it seems that besides __refill_obj_stock(), we should also modify
> > __consume_obj_stock()?
> > 
> 
> Thanks a lot Qi. I will send the formal patch and will add your Debugged-by if
> you don't mind.
> 

Tested-by: kernel test robot <oliver.sang@intel.com>

we tested above patch, and it recovers the regression:

=========================================================================================
compiler/cpufreq_governor/kconfig/method/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/mq/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/switch/stress-ng/60s

commit:
  8285917d6f ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
  01b9da291c ("mm: memcontrol: convert objcg to be per-memcg per-node type")
  682fd4e9ff  <--- above patch from Shakeel

8285917d6f383aef 01b9da291c4969354807b52956f 682fd4e9ffd4009805f81dd25ed
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      5849          +210.2%      18145 ±  3%      +1.5%       5935        stress-ng.switch.nanosecs_per_context_switch_mq_method
 2.296e+09           -67.7%  7.408e+08 ±  3%      -1.4%  2.263e+09        stress-ng.switch.ops
  38288993           -67.7%   12355813 ±  3%      -1.4%   37739220        stress-ng.switch.ops_per_sec


full compasison is as below [3]

but there are two notes. 

#1 is that we noticed there is a fomal patch later from Shakeel in [1] which has
more changes. not sure if this test is enough? do you want us to test [1]
further?

#2: when we test above patch, we found the server easy to crash while running
tests. we try to run up to 20 times, only 2 of them run successfully (above
37739220 is just the average data from these 2 runs, since the data is stable,
we think maybe it's ok to report to you with this data).
we also noticed for [1] there is a [syzbot ci] report in [2]. since we don't
have serial output for our test server in this report which is for performance
tests, we cannot say if other 18 runs failed due to similar reason. just FYI.



[1] https://lore.kernel.org/all/20260515171953.2224503-1-shakeel.butt@linux.dev/

[2] https://lore.kernel.org/all/6a081599.170a0220.4530d.0003.GAE@google.com/

[3]
=========================================================================================
compiler/cpufreq_governor/kconfig/method/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/mq/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/switch/stress-ng/60s

commit:
  8285917d6f ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
  01b9da291c ("mm: memcontrol: convert objcg to be per-memcg per-node type")
  682fd4e9ff  <--- above patch from Shakeel

8285917d6f383aef 01b9da291c4969354807b52956f 682fd4e9ffd4009805f81dd25ed
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      5849          +210.2%      18145 ±  3%      +1.5%       5935        stress-ng.switch.nanosecs_per_context_switch_mq_method
 2.296e+09           -67.7%  7.408e+08 ±  3%      -1.4%  2.263e+09        stress-ng.switch.ops
  38288993           -67.7%   12355813 ±  3%      -1.4%   37739220        stress-ng.switch.ops_per_sec
  93416932           -68.6%   29310048 ±  3%      +0.1%   93506345        stress-ng.time.involuntary_context_switches
     15845           +11.0%      17584            +0.3%      15894        stress-ng.time.percent_of_cpu_this_job_got
      8556           +18.2%      10115            +0.5%       8597        stress-ng.time.system_time
    963.36           -53.5%     447.72 ±  3%      -1.3%     950.84        stress-ng.time.user_time
 1.518e+09           -69.7%  4.607e+08 ±  2%      -1.5%  1.496e+09        stress-ng.time.voluntary_context_switches
      1124 ± 17%     +34.3%       1509 ±  8%      -7.7%       1037 ± 14%  perf-c2c.HITM.remote
  2.55e+09           -12.3%  2.236e+09 ±  3%      -2.3%  2.491e+09        cpuidle..time
  8.29e+08           -71.8%  2.337e+08 ±  2%      -1.8%  8.143e+08        cpuidle..usage
  14184409 ±  2%     -16.4%   11860068            +0.5%   14255389 ±  2%  vmstat.memory.cache
  39204964           -69.7%   11868752 ±  2%      -1.2%   38715052        vmstat.system.cs
   1808848           -38.5%    1111830            -0.8%    1793867        vmstat.system.in
    115757 ± 52%      +8.5%     125625 ± 44%     -62.0%      44014 ± 32%  numa-numastat.node0.other_node
   4102960 ±  5%     -19.0%    3324393 ±  4%      -1.0%    4063575 ±  2%  numa-numastat.node1.local_node
   4218983 ±  3%     -18.7%    3430325 ±  3%      +7.3%    4526769 ±  3%  numa-numastat.node1.numa_hit
    116023 ± 52%      -8.7%     105932 ± 52%     +62.0%     187903 ±  7%  numa-numastat.node1.other_node
  93416932           -68.6%   29310048 ±  3%      +0.1%   93506345        time.involuntary_context_switches
     15845           +11.0%      17584            +0.3%      15894        time.percent_of_cpu_this_job_got
      8556           +18.2%      10115            +0.5%       8597        time.system_time
    963.36           -53.5%     447.72 ±  3%      -1.3%     950.84        time.user_time
 1.518e+09           -69.7%  4.607e+08 ±  2%      -1.5%  1.496e+09        time.voluntary_context_switches
     22.48            -4.4       18.08            -0.2       22.29        mpstat.cpu.all.idle%
      1.13            -0.4        0.73            -0.0        1.12        mpstat.cpu.all.irq%
      0.10            -0.0        0.09            -0.0        0.10        mpstat.cpu.all.soft%
     67.98            +9.1       77.06            +0.3       68.29        mpstat.cpu.all.sys%
      8.32            -4.3        4.04 ±  2%      -0.1        8.21        mpstat.cpu.all.usr%
     17.33 ±  2%     +15.4%      20.00 ±  4%      +3.8%      18.00        mpstat.max_utilization.seconds
  10552401 ±  4%     -23.3%    8092823            +0.3%   10586331 ±  6%  numa-meminfo.node1.Active
  10552392 ±  4%     -23.3%    8092820            +0.3%   10586323 ±  6%  numa-meminfo.node1.Active(anon)
  12454155 ± 15%     -34.9%    8106052            -3.6%   12008629 ± 16%  numa-meminfo.node1.FilePages
    559046 ±  8%     -19.2%     451929 ±  2%      -2.4%     545736 ± 10%  numa-meminfo.node1.Mapped
  14688311 ± 13%     -30.0%   10285394 ±  2%      -4.7%   14004338 ± 15%  numa-meminfo.node1.MemUsed
  10028979 ±  3%     -22.4%    7783864            +0.8%   10109957 ±  3%  numa-meminfo.node1.Shmem
  10939677 ±  2%     -21.0%    8641166            +0.5%   10995134 ±  2%  meminfo.Active
  10939661 ±  2%     -21.0%    8641149            +0.5%   10995117 ±  2%  meminfo.Active(anon)
  13917673 ±  2%     -16.4%   11633722            +0.4%   13973077 ±  2%  meminfo.Cached
  14400924 ±  2%     -16.0%   12102150            +0.6%   14482134 ±  2%  meminfo.Committed_AS
   8394752 ±  5%     +16.7%    9796949 ±  8%     +10.5%    9274368 ± 16%  meminfo.DirectMap2M
    617671           -12.0%     543559            -1.5%     608569        meminfo.Mapped
  18364992           -12.5%   16065468            +0.3%   18426986        meminfo.Memused
  10124702 ±  2%     -22.6%    7839682            +0.6%   10181038 ±  3%  meminfo.Shmem
  18393665           -12.5%   16100473            +0.4%   18458236        meminfo.max_used_kB
    115757 ± 52%      +8.5%     125625 ± 44%     -62.0%      44014 ± 32%  numa-vmstat.node0.numa_other
   2638537 ±  4%     -23.3%    2022639            +0.3%    2647116 ±  6%  numa-vmstat.node1.nr_active_anon
   3113944 ± 15%     -34.9%    2025946            -3.6%    3002667 ± 16%  numa-vmstat.node1.nr_file_pages
    139848 ±  9%     -19.3%     112912 ±  2%      -2.4%     136548 ± 10%  numa-vmstat.node1.nr_mapped
   2507650 ±  3%     -22.4%    1945399            +0.8%    2527999 ±  3%  numa-vmstat.node1.nr_shmem
   2638531 ±  4%     -23.3%    2022634            +0.3%    2647111 ±  6%  numa-vmstat.node1.nr_zone_active_anon
   4219206 ±  3%     -18.7%    3430093 ±  3%      +7.3%    4527044 ±  3%  numa-vmstat.node1.numa_hit
   4103183 ±  4%     -19.0%    3324161 ±  4%      -1.0%    4063850 ±  2%  numa-vmstat.node1.numa_local
    116023 ± 52%      -8.7%     105932 ± 52%     +62.0%     187903 ±  7%  numa-vmstat.node1.numa_other
     10.59            -7.6        2.97 ±  8%      -0.0       10.58        turbostat.C1%
      0.85 ±  3%      +9.1        9.96 ±  2%      +0.1        0.90        turbostat.C1E%
      1.29 ±  6%     +19.4%       1.54 ±  2%      +7.8%       1.39        turbostat.CPU%c1
     48.67 ±  2%     -15.1%      41.33 ±  3%     -14.7%      41.50        turbostat.CoreTmp
      0.56           -60.7%       0.22 ±  3%      +1.8%       0.57        turbostat.IPC
 1.153e+08           -38.7%   70680365            -1.1%   1.14e+08        turbostat.IRQ
  10242404           -14.8%    8723704            -0.2%   10218332        turbostat.NMI
     88.65           -84.0        4.67 ± 33%      -2.4       86.25 ±  2%  turbostat.PKG_%
      3.82            -3.8        0.04 ± 10%      -0.1        3.68        turbostat.POLL%
     48.67 ±  2%     -13.7%      42.00 ±  3%     -12.7%      42.50        turbostat.PkgTmp
    683.77           -13.1%     594.00            -0.1%     683.24        turbostat.PkgWatt
     18.74            -3.3%      18.13            -1.0%      18.54        turbostat.RAMWatt
   2735312 ±  2%     -21.0%    2160742            +0.5%    2749182 ±  2%  proc-vmstat.nr_active_anon
    204708            -1.6%     201435            -0.1%     204401        proc-vmstat.nr_anon_pages
   3479812 ±  2%     -16.4%    2908863            +0.4%    3493660 ±  2%  proc-vmstat.nr_file_pages
    154477           -12.0%     135959            -1.5%     152200        proc-vmstat.nr_mapped
   2531568 ±  2%     -22.6%    1960353            +0.6%    2545651 ±  3%  proc-vmstat.nr_shmem
     42010            -3.5%      40543            +0.0%      42030        proc-vmstat.nr_slab_reclaimable
   2735312 ±  2%     -21.0%    2160742            +0.5%    2749182 ±  2%  proc-vmstat.nr_zone_active_anon
    210167 ±  5%     -11.5%     185950 ± 11%      +7.6%     226044 ±  3%  proc-vmstat.numa_hint_faults
    198174 ±  6%      -7.8%     182781 ± 11%     +12.5%     222958 ±  4%  proc-vmstat.numa_hint_faults_local
   4730338 ±  2%     -18.2%    3871343            +6.3%    5030657 ±  3%  proc-vmstat.numa_hit
   4498551 ±  2%     -19.1%    3639783            +0.6%    4523449 ±  2%  proc-vmstat.numa_local
     22013 ± 74%     -11.9%      19394 ± 79%     -88.0%       2632 ±  2%  proc-vmstat.numa_pages_migrated
   4808959 ±  2%     -17.8%    3954157            +0.3%    4821123 ±  2%  proc-vmstat.pgalloc_normal
    806619            -5.1%     765525 ±  2%      +1.1%     815270        proc-vmstat.pgfault
    467932 ±  3%      -0.3%     466368 ±  2%      -5.2%     443691        proc-vmstat.pgfree
     22013 ± 74%     -11.9%      19394 ± 79%     -88.0%       2632 ±  2%  proc-vmstat.pgmigrate_success
     34098 ±  3%     -14.8%      29054            -8.8%      31100 ±  4%  proc-vmstat.pgreuse
      0.11           +59.9%       0.17 ±  3%      -3.8%       0.10 ±  2%  perf-stat.i.MPKI
 6.653e+10           -61.7%  2.546e+10 ±  2%      +1.7%  6.767e+10        perf-stat.i.branch-instructions
      0.76            +0.1        0.89            +0.0        0.78        perf-stat.i.branch-miss-rate%
 4.685e+08           -59.7%  1.888e+08 ±  2%      +4.8%  4.911e+08        perf-stat.i.branch-misses
      1.12            +0.6        1.76 ±  3%      +0.0        1.12        perf-stat.i.cache-miss-rate%
  35553724 ±  3%     -40.4%   21188697            -0.9%   35218701        perf-stat.i.cache-misses
 4.194e+09           -68.3%  1.331e+09 ±  2%      -1.3%  4.139e+09        perf-stat.i.cache-references
  40710745           -69.6%   12395879 ±  2%      -1.5%   40082554        perf-stat.i.context-switches
      1.84          +189.1%       5.31 ±  2%      -1.7%       1.81        perf-stat.i.cpi
 5.965e+11            -2.0%  5.848e+11            -0.1%  5.962e+11        perf-stat.i.cpu-cycles
   8813175           -64.5%    3125097 ±  2%      -2.0%    8632551        perf-stat.i.cpu-migrations
     24447 ±  3%     +68.5%      41184 ±  2%      +2.6%      25087        perf-stat.i.cycles-between-cache-misses
 3.374e+11           -61.8%  1.287e+11 ±  2%      +1.5%  3.426e+11        perf-stat.i.instructions
      0.57           -60.8%       0.22 ±  2%      +1.6%       0.58        perf-stat.i.ipc
      0.01 ±141%    +185.0%       0.04 ± 46%    +280.6%       0.05 ± 20%  perf-stat.i.major-faults
    221.10           -68.6%      69.32 ±  2%      -1.6%     217.48        perf-stat.i.metric.K/sec
     11782 ±  3%      -6.1%      11068 ±  3%      -1.0%      11660        perf-stat.i.minor-faults
     11782 ±  3%      -6.1%      11068 ±  3%      -1.0%      11660        perf-stat.i.page-faults
      0.10 ±  2%     +59.2%       0.17 ±  3%      -3.0%       0.10        perf-stat.overall.MPKI
      0.71            +0.0        0.75            +0.0        0.73        perf-stat.overall.branch-miss-rate%
      0.83 ±  3%      +0.7        1.56 ±  3%      -0.0        0.82        perf-stat.overall.cache-miss-rate%
      1.78          +162.2%       4.67 ±  2%      -1.4%       1.76        perf-stat.overall.cpi
     17181 ±  3%     +64.6%      28283            +1.6%      17452        perf-stat.overall.cycles-between-cache-misses
      0.56           -61.8%       0.21 ±  2%      +1.4%       0.57        perf-stat.overall.ipc
 6.388e+10           -62.3%  2.409e+10 ±  2%      +1.6%  6.492e+10        perf-stat.ps.branch-instructions
 4.538e+08           -60.0%  1.817e+08 ±  2%      +5.0%  4.764e+08        perf-stat.ps.branch-misses
  33674051 ±  3%     -40.1%   20155290            -1.6%   33143601        perf-stat.ps.cache-misses
 4.077e+09           -68.2%  1.296e+09 ±  2%      -1.1%  4.032e+09        perf-stat.ps.cache-references
  39570629           -69.5%   12072702 ±  2%      -1.4%   39036286        perf-stat.ps.context-switches
  5.78e+11            -1.4%    5.7e+11            +0.1%  5.784e+11        perf-stat.ps.cpu-cycles
   8584979           -64.5%    3051930 ±  2%      -1.8%    8430431        perf-stat.ps.cpu-migrations
 3.243e+11           -62.4%   1.22e+11 ±  2%      +1.5%  3.291e+11        perf-stat.ps.instructions
      0.01 ±141%    +195.1%       0.03 ± 41%    +270.3%       0.04 ± 20%  perf-stat.ps.major-faults
     11022 ±  4%      -6.5%      10300 ±  3%      -0.1%      11015        perf-stat.ps.minor-faults
     11022 ±  4%      -6.5%      10300 ±  3%      -0.1%      11015        perf-stat.ps.page-faults
 1.941e+13           -61.9%  7.405e+12 ±  3%      +2.5%  1.989e+13        perf-stat.total.instructions
     18451            +9.9%      20272            +2.2%      18858 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
      5869 ±  4%      -7.4%       5437 ±  5%     +10.3%       6472 ± 19%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.68 ±  2%     -12.9%       0.59 ±  3%      +0.6%       0.68        sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.62 ±  6%     -12.9%       0.54 ±  2%      +0.4%       0.62        sched_debug.cfs_rq:/.h_nr_runnable.stddev
      8469           +12.7%       9544 ±  2%      +3.0%       8727 ±  4%  sched_debug.cfs_rq:/.left_deadline.stddev
      8467           +12.7%       9542 ±  2%      +3.1%       8727 ±  4%  sched_debug.cfs_rq:/.left_vruntime.stddev
   3513124 ± 25%     -30.0%    2459550 ± 10%      -2.7%    3419965 ± 22%  sched_debug.cfs_rq:/.load.max
    588329 ±  5%     -11.2%     522578 ±  5%      +4.1%     612170        sched_debug.cfs_rq:/.load.stddev
     50699 ± 17%     -19.8%      40655 ±  7%     +20.0%      60854 ± 36%  sched_debug.cfs_rq:/.load_avg.max
      0.68 ±  2%     -12.9%       0.59 ±  3%      +0.9%       0.68        sched_debug.cfs_rq:/.nr_queued.stddev
     38.80 ± 32%    +108.5%      80.90 ± 16%    +276.0%     145.88 ± 64%  sched_debug.cfs_rq:/.removed.load_avg.avg
    857.83 ± 12%     +61.0%       1381 ± 12%   +2561.3%      22829 ± 96%  sched_debug.cfs_rq:/.removed.load_avg.max
    152.02 ± 18%     +57.2%     239.02 ± 11%    +955.1%       1604 ± 88%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     26.08 ± 28%    +143.0%      63.37 ± 14%     +23.5%      32.20 ±  9%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    547.00 ± 13%     +88.7%       1032 ± 12%      +6.4%     582.00        sched_debug.cfs_rq:/.removed.runnable_avg.max
     94.86 ± 17%     +84.3%     174.82 ±  9%     +19.2%     113.04 ±  2%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      9.09 ± 52%    +253.3%      32.11 ± 17%     +53.1%      13.91 ±  6%  sched_debug.cfs_rq:/.removed.util_avg.avg
    275.17 ±  3%    +130.3%     633.67 ±  9%      +0.0%     275.25        sched_debug.cfs_rq:/.removed.util_avg.max
     44.90 ± 30%    +126.4%     101.66 ± 11%     +30.9%      58.78 ±  2%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      8467           +12.7%       9542 ±  2%      +3.1%       8727 ±  4%  sched_debug.cfs_rq:/.right_vruntime.stddev
    659.63 ±  3%     +13.0%     745.47            +0.6%     663.51        sched_debug.cfs_rq:/.runnable_avg.avg
    271.34 ±  2%     +31.2%     355.98 ±  3%      +0.8%     273.61        sched_debug.cfs_rq:/.runnable_avg.stddev
      0.00 ± 26%    +110.4%       0.00 ± 45%      +3.3%       0.00 ± 21%  sched_debug.cfs_rq:/.spread.avg
      0.01 ± 13%    +174.3%       0.02 ± 25%     -36.7%       0.00        sched_debug.cfs_rq:/.spread.max
      0.00 ±  7%    +146.2%       0.00 ± 27%     -13.2%       0.00 ±  8%  sched_debug.cfs_rq:/.spread.stddev
    431.00           +14.5%     493.62            -1.9%     422.73        sched_debug.cfs_rq:/.util_avg.avg
      1061 ±  3%     +26.4%       1341 ±  3%      -3.5%       1024        sched_debug.cfs_rq:/.util_avg.max
    151.53 ±  5%     +50.1%     227.46 ±  2%      -8.0%     139.45        sched_debug.cfs_rq:/.util_avg.stddev
    206.96           +17.5%     243.18 ±  3%     +10.4%     228.53        sched_debug.cfs_rq:/.util_est.avg
     18451            +9.9%      20272            +2.2%      18858 ±  4%  sched_debug.cfs_rq:/.zero_vruntime.avg
      5869 ±  4%      -7.4%       5437 ±  5%     +10.3%       6472 ± 19%  sched_debug.cfs_rq:/.zero_vruntime.stddev
    460133 ±  2%      +2.0%     469231            +5.0%     483144 ±  5%  sched_debug.cpu.avg_idle.avg
      2345           +33.6%       3133 ±  5%    +887.0%      23149 ± 88%  sched_debug.cpu.avg_idle.min
     13.18 ±  2%     +39.8%      18.42 ±  6%      +5.1%      13.85 ±  5%  sched_debug.cpu.clock.stddev
      3961           +14.6%       4541            +0.7%       3989        sched_debug.cpu.curr->pid.avg
      3213           -15.4%       2718            -5.7%       3030        sched_debug.cpu.curr->pid.stddev
      0.00 ± 29%    +157.3%       0.00 ± 35%      -9.3%       0.00 ± 26%  sched_debug.cpu.next_balance.stddev
      0.70           -15.8%       0.59 ±  3%      -2.7%       0.68        sched_debug.cpu.nr_running.stddev
   5474800           -69.7%    1660250 ±  2%      -1.5%    5392540        sched_debug.cpu.nr_switches.avg
   5648642           -65.5%    1946319 ±  5%      -1.3%    5576589        sched_debug.cpu.nr_switches.max
   2229198 ±  8%     -67.1%     734011 ± 20%     +11.1%    2476939 ±  5%  sched_debug.cpu.nr_switches.min
    297592 ±  6%     -25.9%     220513 ± 18%      -5.6%     281029 ±  8%  sched_debug.cpu.nr_switches.stddev
     27.83 ± 30%     -24.0%      21.17 ± 17%     +33.8%      37.25 ± 14%  sched_debug.cpu.nr_uninterruptible.max
     23.75           -10.9       12.88            -0.3       23.42        perf-profile.calltrace.cycles-pp.common_startup_64
     23.65           -10.8       12.82            -0.3       23.32        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     23.62           -10.8       12.81            -0.3       23.28        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     23.51           -10.8       12.76            -0.3       23.18        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     12.93            -7.0        5.94 ±  4%      -0.1       12.82        perf-profile.calltrace.cycles-pp.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.78            -6.9        5.89 ±  4%      -0.1       12.66        perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
     11.30            -5.2        6.07 ±  3%      -0.1       11.22        perf-profile.calltrace.cycles-pp.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.17            -5.2        6.02 ±  3%      -0.1       11.10        perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      9.89            -4.8        5.08 ±  4%      -0.1        9.76        perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q
      4.52            -4.5        0.00            -0.1        4.39        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     12.41            -4.4        7.96            -0.2       12.20        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.19            -4.4        4.77 ±  4%      -0.1        9.06        perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
     11.29            -4.0        7.29            -0.2       11.11        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     11.38            -4.0        7.40            -0.2       11.20        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.04            -3.9        4.13 ±  4%      -0.1        7.93        perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
      6.91            -3.8        3.08 ±  4%      -0.1        6.80        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive
      6.76            -3.8        3.00 ±  4%      -0.1        6.66        perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedreceive
      8.71            -3.7        5.00            -0.0        8.67        perf-profile.calltrace.cycles-pp.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.71            -3.4        2.26 ±  4%      -0.1        5.64        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      8.12            -3.4        4.72            -0.0        8.08        perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      7.76            -3.2        4.55            -0.0        7.72        perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend
      8.39            -3.1        5.26            -0.0        8.35        perf-profile.calltrace.cycles-pp.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.47            -3.1        4.35            -0.0        7.44        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend
      4.92            -2.9        2.00 ±  4%      -0.1        4.86        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      7.79            -2.8        4.97            -0.0        7.74        perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      7.48            -2.7        4.79            -0.0        7.44        perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive.__x64_sys_mq_timedreceive
      7.17            -2.6        4.60            -0.0        7.13        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedreceive
      5.54            -2.3        3.24 ±  4%      -0.1        5.48        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend
      5.41            -2.2        3.16 ±  4%      -0.1        5.35        perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q.do_mq_timedsend
      3.88            -2.2        1.67 ±  4%      -0.1        3.82        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      4.04            -2.2        1.88            -0.0        3.99        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.44            -2.2        1.28 ±  3%      -0.1        3.38        perf-profile.calltrace.cycles-pp.store_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.84            -2.0        1.80            -0.0        3.79        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      4.83            -2.0        2.85            -0.0        4.80        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep
      4.71            -1.9        2.78            -0.0        4.68        perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_hrtimeout_range_clock
      1.84            -1.8        0.00            -0.0        1.81        perf-profile.calltrace.cycles-pp.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q
      4.39            -1.8        2.58            -0.0        4.36        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      2.37            -1.5        0.84 ±  3%      -0.0        2.34        perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      2.66            -1.4        1.26 ±  4%      -0.0        2.62        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      2.73            -1.4        1.33 ±  4%      -0.0        2.70        perf-profile.calltrace.cycles-pp.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.50            -1.3        2.17            -0.0        3.49        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      2.37            -1.3        1.06 ±  2%      -0.0        2.32        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.23            -1.2        0.00            -0.0        1.20        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.15            -1.2        0.00            -0.0        1.13        perf-profile.calltrace.cycles-pp.task_h_load.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up
      1.15            -1.1        0.00            -0.0        1.12        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule_idle.do_idle
      4.10            -1.1        3.03            +0.0        4.10        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.schedule_hrtimeout_range_clock.wq_sleep
      2.20            -1.1        1.13 ±  5%      -0.0        2.16        perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      2.20            -1.1        1.15 ±  4%      -0.0        2.18        perf-profile.calltrace.cycles-pp.switch_fpu_return.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.05            -1.0        0.00            +0.0        1.06        perf-profile.calltrace.cycles-pp.set_next_task_idle.__pick_next_task.__schedule.schedule.schedule_hrtimeout_range_clock
      1.21            -1.0        0.18 ±141%      -0.0        1.20        perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend
      1.20            -1.0        0.17 ±141%      -0.0        1.19        perf-profile.calltrace.cycles-pp.do_perf_trace_sched_wakeup_template.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedsend
      1.74            -1.0        0.73 ±  3%      +0.0        1.77        perf-profile.calltrace.cycles-pp.msg_get.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99            -1.0        0.00            +0.0        1.00        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98            -1.0        0.00            +0.0        1.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.32            -1.0        0.37 ± 70%      -0.0        1.32        perf-profile.calltrace.cycles-pp.do_perf_trace_sched_wakeup_template.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedreceive
      1.93            -0.9        0.99 ±  4%      -0.0        1.89        perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.34            -0.8        0.54 ±  5%      -0.0        1.34        perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.do_mq_timedreceive.__x64_sys_mq_timedreceive
      1.52            -0.8        0.73 ±  4%      -0.0        1.50        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending
      0.74            -0.7        0.00            -0.0        0.73        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.do_mq_timedsend
      1.05            -0.7        0.34 ± 70%      -0.0        1.05        perf-profile.calltrace.cycles-pp.__switch_to
      0.71            -0.7        0.00            -0.0        0.68        perf-profile.calltrace.cycles-pp.msg_insert.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.57            -0.7        0.90 ±  6%      -0.0        1.56        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.arch_exit_to_user_mode_prepare.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.67            -0.7        0.00            -0.0        0.64        perf-profile.calltrace.cycles-pp.__wake_up.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66            -0.7        0.00            -0.0        0.65        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate
      0.65            -0.6        0.00            -0.0        0.64        perf-profile.calltrace.cycles-pp.___task_rq_lock.try_to_wake_up.wake_up_q.do_mq_timedsend.__x64_sys_mq_timedsend
      0.60            -0.6        0.00            -0.0        0.58        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      0.56            -0.6        0.00            -0.0        0.55        perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested.___task_rq_lock.try_to_wake_up.wake_up_q
      0.54            -0.5        0.00            -0.0        0.53        perf-profile.calltrace.cycles-pp.os_xsave
      0.52            -0.5        0.00            -0.0        0.51        perf-profile.calltrace.cycles-pp.__switch_to_asm
      2.56            -0.3        2.28            -0.0        2.54        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.schedule_hrtimeout_range_clock
      0.00            +0.0        0.00            +0.5        0.50        perf-profile.calltrace.cycles-pp.__check_object_size.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      5.87            +0.9        6.78            -0.0        5.86        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.9        0.91 ± 30%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule.schedule
     35.80            +3.5       39.29            +0.1       35.92        perf-profile.calltrace.cycles-pp.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.59            +3.6       39.21            +0.1       35.70        perf-profile.calltrace.cycles-pp.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.4        4.37 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.drain_obj_stock.__refill_obj_stock.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg
      0.00            +4.4        4.39 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.drain_obj_stock.__refill_obj_stock.__memcg_slab_free_hook.kfree.free_msg
      0.00            +8.0        8.01 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__refill_obj_stock.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg.do_mq_timedsend
      0.00            +8.3        8.29 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__refill_obj_stock.__memcg_slab_free_hook.kfree.free_msg.do_mq_timedreceive
     28.51           +13.5       41.99            +0.3       28.81        perf-profile.calltrace.cycles-pp.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.23           +13.5       41.71            +0.3       28.53        perf-profile.calltrace.cycles-pp.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     70.69           +13.7       84.35            +0.3       71.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.44           +13.8       84.26            +0.3       70.77        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.99           +20.2       23.24 ±  2%      +0.4        3.35        perf-profile.calltrace.cycles-pp.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.79           +20.4       23.15 ±  2%      +0.4        3.16        perf-profile.calltrace.cycles-pp.kfree.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive.do_syscall_64
      2.43           +20.6       22.98 ±  2%      +0.4        2.80        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kfree.free_msg.do_mq_timedreceive.__x64_sys_mq_timedreceive
      2.26           +26.0       28.23 ±  2%      +0.6        2.90        perf-profile.calltrace.cycles-pp.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99           +26.8       27.80 ±  2%      +0.6        1.60        perf-profile.calltrace.cycles-pp.__kmalloc_node_noprof.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend.do_syscall_64
      0.65           +27.0       27.62 ±  2%      +0.6        1.24        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.load_msg.do_mq_timedsend.__x64_sys_mq_timedsend
     24.25           -12.2       12.02 ±  4%      -0.2       24.05        perf-profile.children.cycles-pp.wake_up_q
     24.00           -12.1       11.93 ±  4%      -0.2       23.81        perf-profile.children.cycles-pp.try_to_wake_up
     23.75           -10.9       12.88            -0.3       23.42        perf-profile.children.cycles-pp.common_startup_64
     23.75           -10.9       12.88            -0.3       23.42        perf-profile.children.cycles-pp.cpu_startup_entry
     23.68           -10.8       12.85            -0.3       23.34        perf-profile.children.cycles-pp.do_idle
     23.65           -10.8       12.82            -0.3       23.32        perf-profile.children.cycles-pp.start_secondary
     19.65            -8.3       11.33            -0.1       19.54        perf-profile.children.cycles-pp.__schedule
     17.14            -6.9       10.28            -0.1       17.06        perf-profile.children.cycles-pp.wq_sleep
     16.24            -6.4        9.82            -0.1       16.18        perf-profile.children.cycles-pp.schedule
     15.92            -6.2        9.69            -0.1       15.84        perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
     12.46            -6.1        6.32 ±  4%      -0.2       12.30        perf-profile.children.cycles-pp.select_task_rq
     12.19            -6.0        6.17 ±  4%      -0.2       12.03        perf-profile.children.cycles-pp.select_task_rq_fair
      9.91            -4.8        5.09 ±  4%      -0.1        9.78        perf-profile.children.cycles-pp.select_idle_sibling
      4.57            -4.6        0.02 ±141%      -0.1        4.44        perf-profile.children.cycles-pp.poll_idle
      9.27            -4.5        4.80 ±  4%      -0.1        9.14        perf-profile.children.cycles-pp.select_idle_cpu
     12.49            -4.5        8.03            -0.2       12.28        perf-profile.children.cycles-pp.cpuidle_idle_call
     11.41            -4.0        7.39            -0.2       11.23        perf-profile.children.cycles-pp.cpuidle_enter_state
     11.44            -4.0        7.43            -0.2       11.26        perf-profile.children.cycles-pp.cpuidle_enter
      8.17            -4.0        4.18 ±  4%      -0.1        8.06        perf-profile.children.cycles-pp.select_idle_core
      5.76            -3.5        2.28 ±  4%      -0.1        5.70        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      5.47            -3.1        2.35 ±  4%      -0.1        5.40        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      4.30            -2.4        1.94 ±  4%      -0.1        4.24        perf-profile.children.cycles-pp.sched_ttwu_pending
      4.08            -2.2        1.90            -0.0        4.03        perf-profile.children.cycles-pp.schedule_idle
      3.47            -2.2        1.30 ±  2%      -0.1        3.42        perf-profile.children.cycles-pp.store_msg
      5.87            -2.1        3.78            -0.0        5.86        perf-profile.children.cycles-pp.__pick_next_task
      4.84            -2.0        2.86            -0.0        4.81        perf-profile.children.cycles-pp.try_to_block_task
      4.73            -1.9        2.79            -0.0        4.69        perf-profile.children.cycles-pp.dequeue_entities
      4.73            -1.9        2.82            -0.0        4.70        perf-profile.children.cycles-pp.dequeue_task_fair
      4.04            -1.8        2.26            -0.0        4.00        perf-profile.children.cycles-pp._raw_spin_lock
      3.72            -1.7        2.03 ±  4%      -0.0        3.70        perf-profile.children.cycles-pp.enqueue_task
      2.40            -1.6        0.85 ±  3%      -0.0        2.37        perf-profile.children.cycles-pp._copy_to_user
      3.39            -1.5        1.86 ±  3%      -0.0        3.36        perf-profile.children.cycles-pp.ttwu_do_activate
      2.56            -1.5        1.04 ±  5%      -0.0        2.54        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      2.54            -1.5        1.03 ±  5%      -0.0        2.52        perf-profile.children.cycles-pp.do_perf_trace_sched_wakeup_template
      2.76            -1.4        1.34 ±  4%      -0.0        2.73        perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      3.75            -1.4        2.34            -0.0        3.74        perf-profile.children.cycles-pp.dequeue_entity
      2.32            -1.4        0.95 ±  4%      -0.0        2.30        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.72            -1.3        1.38 ±  2%      -0.0        2.72        perf-profile.children.cycles-pp.update_curr
      2.38            -1.3        1.06 ±  2%      -0.1        2.32        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      4.24            -1.2        2.99            -0.0        4.21        perf-profile.children.cycles-pp.pick_next_task_fair
      2.21            -1.1        1.15 ±  5%      -0.0        2.19        perf-profile.children.cycles-pp.switch_fpu_return
      1.76            -1.0        0.73 ±  3%      +0.0        1.80        perf-profile.children.cycles-pp.msg_get
      1.67            -1.0        0.65 ±  3%      -0.1        1.54        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.47            -1.0        1.47 ±  3%      -0.0        2.44        perf-profile.children.cycles-pp.enqueue_task_fair
      2.29            -1.0        1.32            -0.0        2.25        perf-profile.children.cycles-pp.update_load_avg
      2.39            -1.0        1.42            -0.0        2.37        perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.60            -1.0        0.64            -0.0        1.59        perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.51            -0.9        0.57 ±  5%      -0.0        1.49        perf-profile.children.cycles-pp.__smp_call_single_queue
      1.84            -0.9        0.93 ±  6%      -0.0        1.82        perf-profile.children.cycles-pp.wake_affine
      1.49            -0.9        0.59            +0.0        1.49        perf-profile.children.cycles-pp.__check_object_size
      1.61            -0.9        0.72 ±  5%      +0.0        1.62        perf-profile.children.cycles-pp.update_rq_clock_task
      1.73            -0.9        0.87 ±  2%      -0.0        1.73        perf-profile.children.cycles-pp.update_se
      1.51            -0.9        0.65 ±  2%      +0.0        1.53        perf-profile.children.cycles-pp.wakeup_preempt
      2.00            -0.8        1.15 ±  3%      -0.0        1.97        perf-profile.children.cycles-pp.enqueue_entity
      1.26            -0.8        0.42 ±  3%      -0.1        1.14        perf-profile.children.cycles-pp.__wake_up
      1.31            -0.7        0.58 ±  5%      -0.0        1.30        perf-profile.children.cycles-pp.set_task_cpu
      1.15            -0.7        0.45 ±  3%      -0.0        1.10        perf-profile.children.cycles-pp.msg_insert
      1.04            -0.7        0.35 ±  5%      -0.0        1.04        perf-profile.children.cycles-pp.perf_trace_buf_alloc
      1.57            -0.7        0.90 ±  5%      -0.0        1.56        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.00            -0.7        0.34 ±  7%      -0.0        1.00        perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.95            -0.7        0.29 ±  4%      -0.0        0.94        perf-profile.children.cycles-pp.llist_reverse_order
      1.14            -0.6        0.50 ±  5%      -0.0        1.13        perf-profile.children.cycles-pp.migrate_task_rq_fair
      1.11            -0.6        0.51            -0.0        1.10        perf-profile.children.cycles-pp.set_next_entity
      0.95            -0.6        0.39 ±  2%      +0.0        0.96        perf-profile.children.cycles-pp.__update_idle_core
      1.04            -0.6        0.49 ±  2%      -0.0        1.03        perf-profile.children.cycles-pp.pick_task_fair
      1.15            -0.6        0.60 ±  7%      -0.0        1.14        perf-profile.children.cycles-pp.task_h_load
      0.84            -0.5        0.30 ±  5%      -0.0        0.84        perf-profile.children.cycles-pp.call_function_single_prep_ipi
      1.06            -0.5        0.52            +0.0        1.07        perf-profile.children.cycles-pp.set_next_task_idle
      1.04            -0.5        0.51            -0.0        1.03        perf-profile.children.cycles-pp._find_next_bit
      1.38            -0.5        0.85            -0.0        1.36        perf-profile.children.cycles-pp.update_cfs_rq_load_avg
      1.28            -0.5        0.75            -0.0        1.27        perf-profile.children.cycles-pp.__switch_to
      0.85            -0.5        0.34 ±  3%      +0.0        0.86        perf-profile.children.cycles-pp.cpuacct_charge
      0.77 ±  4%      -0.5        0.25            -0.0        0.73        perf-profile.children.cycles-pp.__bitmap_andnot
      0.88            -0.5        0.41 ±  6%      +0.0        0.89        perf-profile.children.cycles-pp.update_entity_lag
      0.94            -0.5        0.48            -0.0        0.92        perf-profile.children.cycles-pp.prepare_task_switch
      0.74            -0.4        0.31 ±  2%      +0.0        0.76        perf-profile.children.cycles-pp.check_heap_object
      0.75            -0.4        0.32 ±  5%      +0.0        0.75        perf-profile.children.cycles-pp.requeue_delayed_entity
      0.80            -0.4        0.40            -0.0        0.80        perf-profile.children.cycles-pp.wakeup_preempt_fair
      0.55            -0.4        0.16 ±  2%      -0.0        0.54        perf-profile.children.cycles-pp.native_sched_clock
      0.57            -0.4        0.18 ±  4%      -0.0        0.56        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.55            -0.4        0.17            -0.0        0.54        perf-profile.children.cycles-pp.os_xsave
      0.58            -0.4        0.20            -0.0        0.57        perf-profile.children.cycles-pp.sched_clock_cpu
      1.39            -0.4        1.01            -0.0        1.36        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.18            -0.4        0.81            -0.0        1.18        perf-profile.children.cycles-pp.___task_rq_lock
      0.51 ±  3%      -0.4        0.14 ±  3%      -0.0        0.50        perf-profile.children.cycles-pp._copy_from_user
      0.56            -0.4        0.19 ±  2%      -0.0        0.54        perf-profile.children.cycles-pp.update_rq_clock
      0.51            -0.3        0.17 ±  2%      -0.0        0.50        perf-profile.children.cycles-pp.sched_clock
      0.56            -0.3        0.23 ±  3%      +0.0        0.58        perf-profile.children.cycles-pp.simple_inode_init_ts
      0.89            -0.3        0.56            +0.0        0.89        perf-profile.children.cycles-pp.put_prev_entity
      0.53 ±  3%      -0.3        0.21 ±  2%      +0.0        0.53        perf-profile.children.cycles-pp.__put_user_4
      0.68 ± 12%      -0.3        0.36 ±  4%      +0.1        0.76        perf-profile.children.cycles-pp.stress_switch_mq
      0.52            -0.3        0.20            -0.0        0.50        perf-profile.children.cycles-pp.set_next_task_fair
      0.55            -0.3        0.24 ±  5%      -0.0        0.54        perf-profile.children.cycles-pp.__switch_to_asm
      0.51            -0.3        0.21 ±  3%      +0.0        0.52        perf-profile.children.cycles-pp.inode_set_ctime_current
      0.56            -0.3        0.26 ±  3%      +0.0        0.57        perf-profile.children.cycles-pp.fdget
      0.52            -0.3        0.23 ±  3%      -0.0        0.51        perf-profile.children.cycles-pp.mm_cid_switch_to
      0.54            -0.3        0.25 ±  3%      -0.0        0.54        perf-profile.children.cycles-pp.remove_entity_load_avg
      0.79            -0.3        0.51            -0.0        0.78        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.37            -0.3        0.11 ±  7%      +0.0        0.37        perf-profile.children.cycles-pp.__resched_curr
      0.57            -0.2        0.32            -0.0        0.56        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.35            -0.2        0.12 ±  4%      -0.0        0.35        perf-profile.children.cycles-pp.avg_vruntime
      0.62            -0.2        0.39 ±  2%      -0.0        0.62        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.34            -0.2        0.11            -0.0        0.33        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.58            -0.2        0.36            +0.0        0.59        perf-profile.children.cycles-pp.__enqueue_entity
      0.46            -0.2        0.24            -0.0        0.45        perf-profile.children.cycles-pp.__pick_eevdf
      0.52            -0.2        0.30 ±  3%      +0.0        0.52        perf-profile.children.cycles-pp.perf_tp_event
      0.35            -0.2        0.14 ±  3%      -0.0        0.35        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.56            -0.2        0.36            -0.0        0.56        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.33            -0.2        0.13 ±  3%      -0.0        0.32        perf-profile.children.cycles-pp.__update_load_avg_se
      0.31 ±  2%      -0.2        0.12 ±  4%      +0.0        0.33        perf-profile.children.cycles-pp.__virt_addr_valid
      0.58            -0.2        0.40            -0.0        0.58        perf-profile.children.cycles-pp.menu_select
      0.32 ±  5%      -0.2        0.13            -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.31            -0.2        0.13 ±  3%      -0.0        0.30        perf-profile.children.cycles-pp.place_entity
      0.32            -0.2        0.14            -0.0        0.32        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.36            -0.2        0.18 ±  2%      -0.0        0.36        perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.29            -0.2        0.11            -0.0        0.28        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.33            -0.2        0.16 ±  3%      -0.0        0.32        perf-profile.children.cycles-pp.do_perf_trace_sched_stat_runtime
      0.35            -0.2        0.18 ±  2%      +0.0        0.36        perf-profile.children.cycles-pp.ktime_get
      0.25            -0.2        0.08 ±  5%      -0.0        0.25        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.37            -0.2        0.20 ±  4%      -0.0        0.36        perf-profile.children.cycles-pp.___perf_sw_event
      0.23            -0.2        0.07 ±  6%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.22            -0.2        0.07            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.read_tsc
      0.21            -0.1        0.06 ±  7%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.25            -0.1        0.11 ±  7%      -0.0        0.25        perf-profile.children.cycles-pp.strnlen
      0.16            -0.1        0.02 ±141%      -0.0        0.15        perf-profile.children.cycles-pp.ct_idle_exit
      0.32            -0.1        0.18            -0.0        0.31        perf-profile.children.cycles-pp.__dequeue_entity
      0.23 ±  2%      -0.1        0.10 ±  4%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.53            -0.1        0.40 ±  2%      -0.0        0.52        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.23 ±  2%      -0.1        0.09 ±  5%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.30 ±  3%      -0.1        0.17 ±  4%      -0.0        0.30        perf-profile.children.cycles-pp.tick_nohz_handler
      0.20            -0.1        0.07            +0.4        0.57 ±  3%  perf-profile.children.cycles-pp.__account_obj_stock
      0.13            -0.1        0.00            -0.0        0.12        perf-profile.children.cycles-pp.ct_kernel_enter
      0.13            -0.1        0.00            -0.0        0.12        perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.41            -0.1        0.28 ±  2%      -0.0        0.40        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.31 ±  2%      -0.1        0.18 ±  2%      -0.0        0.30        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.41 ±  2%      -0.1        0.29 ±  3%      -0.0        0.41        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.28 ±  2%      -0.1        0.16 ±  6%      -0.0        0.27        perf-profile.children.cycles-pp.update_process_times
      0.33            -0.1        0.21 ±  6%      +0.0        0.33        perf-profile.children.cycles-pp.attach_entity_load_avg
      0.12 ±  3%      -0.1        0.00            -0.0        0.08        perf-profile.children.cycles-pp.__do_notify
      0.19 ±  2%      -0.1        0.07 ±  7%      -0.0        0.18        perf-profile.children.cycles-pp.wake_q_add_safe
      0.23 ±  2%      -0.1        0.11            -0.0        0.22        perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.18            -0.1        0.07 ±  6%      -0.0        0.18        perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.56            -0.1        0.46            -0.0        0.56        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.15            -0.1        0.05            +0.0        0.15        perf-profile.children.cycles-pp._raw_spin_unlock
      0.17            -0.1        0.08            -0.0        0.16        perf-profile.children.cycles-pp.security_msg_msg_free
      0.15            -0.1        0.06            +0.0        0.16        perf-profile.children.cycles-pp.inode_set_ctime_to_ts
      0.08 ±  5%      -0.1        0.00            +0.0        0.11        perf-profile.children.cycles-pp.trylock_stock
      0.16 ±  2%      -0.1        0.08 ±  5%      -0.0        0.16        perf-profile.children.cycles-pp.dl_server_update
      0.13            -0.1        0.06 ±  8%      +0.0        0.13        perf-profile.children.cycles-pp.timestamp_truncate
      0.15 ±  3%      -0.1        0.08            +0.0        0.17        perf-profile.children.cycles-pp.perf_trace_buf_update
      0.13 ±  3%      -0.1        0.06            +0.0        0.13        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.13 ±  3%      -0.1        0.06            +0.0        0.13        perf-profile.children.cycles-pp.migrate_disable_switch
      0.12 ±  6%      -0.1        0.05 ±  8%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.11 ±  4%      -0.1        0.05            -0.0        0.11        perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.06            -0.1        0.00            +0.0        0.07        perf-profile.children.cycles-pp.raw_spin_rq_unlock
      0.14            -0.1        0.08 ±  5%      +0.0        0.14        perf-profile.children.cycles-pp.update_curr_dl_se
      0.06 ± 16%      -0.1        0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.css_rstat_updated
      0.10            -0.1        0.05            -0.0        0.10        perf-profile.children.cycles-pp.ct_kernel_exit
      0.11            -0.1        0.06            +0.0        0.11        perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.10 ±  4%      -0.0        0.05            +0.0        0.10        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.10            -0.0        0.06 ±  8%      -0.0        0.10        perf-profile.children.cycles-pp.rest_init
      0.10            -0.0        0.06 ±  8%      -0.0        0.10        perf-profile.children.cycles-pp.start_kernel
      0.10            -0.0        0.06 ±  8%      -0.0        0.10        perf-profile.children.cycles-pp.x86_64_start_kernel
      0.10            -0.0        0.06 ±  8%      -0.0        0.10        perf-profile.children.cycles-pp.x86_64_start_reservations
      0.08 ± 10%      -0.0        0.04 ± 71%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.mq_timedreceive
      0.15            -0.0        0.11 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.vruntime_eligible
      0.13            -0.0        0.09            +0.0        0.13        perf-profile.children.cycles-pp.put_prev_task_fair
      0.09            -0.0        0.05 ±  8%      -0.0        0.09        perf-profile.children.cycles-pp.native_irq_return_iret
      0.08            -0.0        0.05            +0.0        0.08        perf-profile.children.cycles-pp.choose_new_asid
      0.13            -0.0        0.11            +0.0        0.13        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.07            -0.0        0.05            +0.0        0.07        perf-profile.children.cycles-pp.__set_next_task_fair
      0.76            -0.0        0.74            -0.0        0.74        perf-profile.children.cycles-pp.finish_task_switch
      0.09            -0.0        0.07 ±  6%      -0.0        0.09        perf-profile.children.cycles-pp.propagate_entity_load_avg
      0.10            -0.0        0.09            -0.0        0.10        perf-profile.children.cycles-pp.handle_softirqs
      0.07            -0.0        0.06            +0.0        0.08        perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.0        0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.0        0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.00            +0.0        0.00            +0.3        0.32 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.07            +0.0        0.08            +0.0        0.07        perf-profile.children.cycles-pp.perf_swevent_event
      0.48            +0.0        0.49            +0.0        0.48        perf-profile.children.cycles-pp.process_simple
      0.05            +0.0        0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.sched_update_worker
      0.05            +0.0        0.07            -0.0        0.05        perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.07 ± 11%      +0.0        0.09 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.mq_timedsend
      0.15 ±  3%      +0.0        0.20 ±  4%      -0.0        0.15        perf-profile.children.cycles-pp.x64_sys_call
      0.00            +0.1        0.05            +0.0        0.00        perf-profile.children.cycles-pp.__sched_balance_update_blocked_averages
      0.00            +0.1        0.05            +0.0        0.00        perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.06 ± 23%      +0.0        0.00        perf-profile.children.cycles-pp.generic_perform_write
      0.00            +0.1        0.06 ±  7%      +0.0        0.00        perf-profile.children.cycles-pp.detach_tasks
      0.00            +0.1        0.06 ± 29%      +0.0        0.00        perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.1        0.06 ± 29%      +0.0        0.00        perf-profile.children.cycles-pp.vfs_write
      0.00            +0.1        0.07 ± 25%      +0.0        0.00        perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.08 ± 30%      +0.0        0.00        perf-profile.children.cycles-pp.record__pushfn
      0.04 ± 71%      +0.1        0.12 ± 35%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.perf_mmap__push
      0.54 ±  2%      +0.1        0.62 ±  7%      -0.0        0.54 ±  2%  perf-profile.children.cycles-pp.cmd_record
      0.04 ± 70%      +0.1        0.13 ± 32%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.04 ± 71%      +0.1        0.13 ± 35%      -0.0        0.04 ±100%  perf-profile.children.cycles-pp.handle_internal_command
      0.04 ± 71%      +0.1        0.13 ± 35%      -0.0        0.04 ±100%  perf-profile.children.cycles-pp.main
      0.04 ± 71%      +0.1        0.13 ± 35%      -0.0        0.04 ±100%  perf-profile.children.cycles-pp.run_builtin
      0.10 ±  4%      +0.1        0.20 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.do_perf_trace_sched_switch
      0.00            +0.1        0.10 ±  4%      +0.0        0.00        perf-profile.children.cycles-pp.ct_idle_enter
      0.13 ±  3%      +0.2        0.29 ±  4%      -0.0        0.13        perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.21 ±  6%      +0.6        0.78 ±  3%      -0.0        0.20        perf-profile.children.cycles-pp.update_sg_lb_stats
      0.22 ±  6%      +0.6        0.81 ±  4%      -0.0        0.21        perf-profile.children.cycles-pp.update_sd_lb_stats
      0.22 ±  6%      +0.6        0.81 ±  3%      -0.0        0.21        perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.40 ±  3%      +0.7        1.08 ±  4%      -0.0        0.40        perf-profile.children.cycles-pp.sched_balance_newidle
      0.27 ±  6%      +0.7        0.97 ±  4%      -0.0        0.26        perf-profile.children.cycles-pp.sched_balance_rq
      5.90            +0.9        6.81            -0.0        5.88        perf-profile.children.cycles-pp.intel_idle
     35.82            +3.5       39.30            +0.1       35.93        perf-profile.children.cycles-pp.__x64_sys_mq_timedreceive
     35.70            +3.5       39.25            +0.1       35.82        perf-profile.children.cycles-pp.do_mq_timedreceive
      0.00            +8.8        8.78 ±  3%      +0.0        0.00        perf-profile.children.cycles-pp.drain_obj_stock
     28.34           +13.4       41.76            +0.3       28.64        perf-profile.children.cycles-pp.do_mq_timedsend
     28.52           +13.5       41.99            +0.3       28.82        perf-profile.children.cycles-pp.__x64_sys_mq_timedsend
     70.76           +13.7       84.45            +0.3       71.10        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.56           +13.8       84.39            +0.3       70.90        perf-profile.children.cycles-pp.do_syscall_64
      0.08           +16.2       16.31 ±  4%      +0.2        0.27 ±  3%  perf-profile.children.cycles-pp.__refill_obj_stock
      3.22           +20.1       23.33 ±  2%      +0.4        3.62        perf-profile.children.cycles-pp.kfree
      3.01           +20.2       23.25 ±  2%      +0.4        3.38        perf-profile.children.cycles-pp.free_msg
      2.46           +20.5       23.00 ±  2%      +0.4        2.83        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      2.31           +25.9       28.25 ±  2%      +0.6        2.94        perf-profile.children.cycles-pp.load_msg
      1.00           +26.8       27.81 ±  2%      +0.6        1.62        perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.68           +27.0       27.65 ±  2%      +0.6        1.29        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      4.41            -4.4        0.02 ±141%      -0.1        4.28        perf-profile.self.cycles-pp.poll_idle
      6.79            -3.2        3.63 ±  5%      -0.1        6.70        perf-profile.self.cycles-pp.select_idle_core
      3.07            -1.7        1.33 ±  4%      -0.0        3.06        perf-profile.self.cycles-pp.do_mq_timedreceive
      2.90            -1.6        1.31 ±  3%      -0.0        2.88        perf-profile.self.cycles-pp.__schedule
      2.37            -1.5        0.84 ±  3%      -0.0        2.34        perf-profile.self.cycles-pp._copy_to_user
      2.73            -1.5        1.22 ±  3%      -0.0        2.70        perf-profile.self.cycles-pp.do_mq_timedsend
      2.63            -1.4        1.25 ±  3%      -0.0        2.59        perf-profile.self.cycles-pp._raw_spin_lock
      1.64            -1.0        0.64 ±  3%      -0.1        1.52        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.46            -0.9        0.55 ±  2%      -0.0        1.45        perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.54            -0.9        0.67 ±  6%      +0.0        1.54        perf-profile.self.cycles-pp.update_rq_clock_task
      1.48            -0.9        0.62 ±  3%      +0.0        1.49        perf-profile.self.cycles-pp.msg_get
      1.36            -0.8        0.58 ±  3%      -0.1        1.30        perf-profile.self.cycles-pp.exit_to_user_mode_loop
      1.11            -0.7        0.44 ±  4%      -0.0        1.08        perf-profile.self.cycles-pp.msg_insert
      1.56            -0.7        0.90 ±  6%      -0.0        1.56        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.95            -0.7        0.29 ±  5%      -0.0        0.94        perf-profile.self.cycles-pp.llist_reverse_order
      1.00            -0.7        0.34 ±  7%      -0.0        0.99        perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      1.19            -0.6        0.59 ±  3%      -0.0        1.18        perf-profile.self.cycles-pp.wq_sleep
      0.92            -0.6        0.36 ±  6%      -0.0        0.92        perf-profile.self.cycles-pp.do_perf_trace_sched_wakeup_template
      0.90            -0.6        0.34 ±  2%      +0.0        0.92        perf-profile.self.cycles-pp.__update_idle_core
      1.15            -0.5        0.60 ±  7%      -0.0        1.14        perf-profile.self.cycles-pp.task_h_load
      0.83            -0.5        0.30 ±  5%      -0.0        0.83        perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.97            -0.5        0.44 ±  2%      -0.0        0.94        perf-profile.self.cycles-pp.dequeue_entities
      0.84            -0.5        0.34 ±  3%      +0.0        0.86        perf-profile.self.cycles-pp.cpuacct_charge
      0.96            -0.5        0.47 ±  4%      +0.0        0.96        perf-profile.self.cycles-pp.do_syscall_64
      1.23            -0.5        0.74            -0.0        1.22        perf-profile.self.cycles-pp.__switch_to
      0.73 ±  4%      -0.5        0.24 ±  3%      -0.0        0.70        perf-profile.self.cycles-pp.__bitmap_andnot
      0.69            -0.5        0.20 ±  4%      +0.0        0.69        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.94            -0.5        0.47            +0.0        0.94 ±  2%  perf-profile.self.cycles-pp._find_next_bit
      0.77            -0.4        0.36 ±  6%      +0.0        0.77        perf-profile.self.cycles-pp.update_entity_lag
      0.76            -0.4        0.36 ±  3%      -0.0        0.74        perf-profile.self.cycles-pp.update_load_avg
      0.67            -0.4        0.27 ±  5%      -0.0        0.66        perf-profile.self.cycles-pp.__smp_call_single_queue
      0.70            -0.4        0.31 ±  2%      +0.0        0.70        perf-profile.self.cycles-pp.pick_next_task_fair
      0.55            -0.4        0.17 ±  2%      -0.0        0.54        perf-profile.self.cycles-pp.os_xsave
      0.56            -0.4        0.18 ±  4%      -0.0        0.54        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.63            -0.4        0.25            -0.0        0.62        perf-profile.self.cycles-pp.switch_fpu_return
      1.38            -0.4        1.01            -0.0        1.36        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.69            -0.4        0.33 ±  5%      -0.0        0.68        perf-profile.self.cycles-pp.wake_affine
      0.53            -0.4        0.16            -0.0        0.51        perf-profile.self.cycles-pp.native_sched_clock
      0.67            -0.4        0.30 ±  2%      +0.0        0.70        perf-profile.self.cycles-pp.kfree
      0.75            -0.4        0.39 ±  3%      +0.0        0.76        perf-profile.self.cycles-pp.update_curr
      0.67            -0.4        0.31 ±  5%      -0.0        0.66        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.53            -0.4        0.18 ±  2%      -0.0        0.52        perf-profile.self.cycles-pp.arch_exit_to_user_mode_prepare
      0.49 ±  2%      -0.4        0.14 ±  3%      -0.0        0.48        perf-profile.self.cycles-pp._copy_from_user
      0.63            -0.3        0.28 ±  3%      -0.0        0.62        perf-profile.self.cycles-pp.schedule_hrtimeout_range_clock
      0.58            -0.3        0.23 ±  4%      -0.0        0.57        perf-profile.self.cycles-pp.select_idle_sibling
      0.58            -0.3        0.24 ±  7%      -0.0        0.56        perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.64            -0.3        0.31            -0.0        0.63        perf-profile.self.cycles-pp.prepare_task_switch
      0.82            -0.3        0.49 ±  3%      -0.0        0.82        perf-profile.self.cycles-pp.select_idle_cpu
      0.52 ±  3%      -0.3        0.21 ±  2%      +0.0        0.52        perf-profile.self.cycles-pp.__put_user_4
      0.63 ± 11%      -0.3        0.32 ±  5%      +0.0        0.64        perf-profile.self.cycles-pp.stress_switch_mq
      0.54            -0.3        0.24 ±  5%      -0.0        0.53        perf-profile.self.cycles-pp.__switch_to_asm
      0.54            -0.3        0.25 ±  3%      +0.0        0.55        perf-profile.self.cycles-pp.fdget
      0.51            -0.3        0.22 ±  4%      -0.0        0.50        perf-profile.self.cycles-pp.mm_cid_switch_to
      0.44            -0.3        0.15 ±  6%      -0.0        0.44        perf-profile.self.cycles-pp.select_task_rq_fair
      0.43            -0.3        0.15 ±  5%      -0.0        0.42        perf-profile.self.cycles-pp.sched_ttwu_pending
      0.49            -0.3        0.23 ±  6%      +0.0        0.50        perf-profile.self.cycles-pp.enqueue_task
      0.59            -0.2        0.34 ±  2%      -0.0        0.58        perf-profile.self.cycles-pp.try_to_wake_up
      0.73            -0.2        0.48            -0.0        0.72        perf-profile.self.cycles-pp.update_cfs_rq_load_avg
      0.35            -0.2        0.11 ±  4%      +0.0        0.35        perf-profile.self.cycles-pp.__resched_curr
      0.40            -0.2        0.16 ±  2%      -0.0        0.40        perf-profile.self.cycles-pp.__pick_next_task
      0.36            -0.2        0.12 ±  3%      -0.0        0.35        perf-profile.self.cycles-pp.cpuidle_idle_call
      0.34            -0.2        0.11            -0.0        0.33        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.57            -0.2        0.36            +0.0        0.58        perf-profile.self.cycles-pp.__enqueue_entity
      0.51            -0.2        0.31            -0.0        0.50        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.34            -0.2        0.14 ±  5%      +0.0        0.36        perf-profile.self.cycles-pp.wakeup_preempt
      0.34            -0.2        0.14 ±  3%      -0.0        0.34        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.39            -0.2        0.20 ±  2%      -0.0        0.39        perf-profile.self.cycles-pp.do_idle
      0.31 ±  5%      -0.2        0.11            -0.0        0.28 ±  5%  perf-profile.self.cycles-pp.__check_heap_object
      0.37            -0.2        0.17 ±  2%      +0.0        0.37        perf-profile.self.cycles-pp.check_heap_object
      0.51            -0.2        0.32            +0.0        0.51        perf-profile.self.cycles-pp.schedule
      0.36            -0.2        0.18 ±  2%      -0.0        0.36        perf-profile.self.cycles-pp.__pick_eevdf
      0.61            -0.2        0.43            +0.0        0.63        perf-profile.self.cycles-pp.dequeue_entity
      0.29 ±  2%      -0.2        0.11 ±  4%      +0.0        0.31        perf-profile.self.cycles-pp.__virt_addr_valid
      0.30            -0.2        0.12            -0.0        0.29        perf-profile.self.cycles-pp.__update_load_avg_se
      0.27            -0.2        0.10 ±  4%      -0.0        0.27        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.25            -0.2        0.08 ±  5%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.26            -0.2        0.11 ±  4%      -0.0        0.25        perf-profile.self.cycles-pp.place_entity
      0.45            -0.2        0.30 ±  3%      -0.0        0.44        perf-profile.self.cycles-pp.enqueue_entity
      0.44            -0.2        0.29 ±  5%      -0.0        0.44        perf-profile.self.cycles-pp.enqueue_task_fair
      0.24            -0.2        0.09            +0.0        0.24        perf-profile.self.cycles-pp.wake_up_q
      0.22 ±  2%      -0.1        0.07            -0.0        0.21        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.24            -0.1        0.09 ±  5%      +0.0        0.24        perf-profile.self.cycles-pp.___perf_sw_event
      0.32            -0.1        0.18 ±  2%      +0.0        0.32        perf-profile.self.cycles-pp.dequeue_task_fair
      0.21 ±  2%      -0.1        0.06 ±  7%      -0.0        0.20        perf-profile.self.cycles-pp.read_tsc
      0.20            -0.1        0.06            -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.36            -0.1        0.22 ±  4%      -0.0        0.35        perf-profile.self.cycles-pp.perf_tp_event
      0.24            -0.1        0.11 ±  4%      -0.0        0.24        perf-profile.self.cycles-pp.strnlen
      0.28            -0.1        0.14            +0.0        0.28        perf-profile.self.cycles-pp.__kmalloc_node_noprof
      0.21            -0.1        0.08 ±  6%      +0.0        0.23        perf-profile.self.cycles-pp.load_msg
      0.33            -0.1        0.20 ±  4%      -0.0        0.32        perf-profile.self.cycles-pp.attach_entity_load_avg
      0.12 ±  3%      -0.1        0.00            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__do_notify
      0.41            -0.1        0.29            -0.0        0.40        perf-profile.self.cycles-pp.update_se
      0.44            -0.1        0.33            -0.0        0.44        perf-profile.self.cycles-pp.menu_select
      0.27            -0.1        0.15 ±  6%      -0.0        0.26        perf-profile.self.cycles-pp.select_task_rq
      0.17 ±  2%      -0.1        0.06 ±  8%      -0.0        0.17        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.23 ±  2%      -0.1        0.11 ±  4%      -0.0        0.22        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.19            -0.1        0.08 ±  6%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.update_rq_clock
      0.18 ±  2%      -0.1        0.06 ±  7%      -0.0        0.17        perf-profile.self.cycles-pp.wake_q_add_safe
      0.20 ±  2%      -0.1        0.09            +0.0        0.21        perf-profile.self.cycles-pp.check_stack_object
      0.18            -0.1        0.07            +0.1        0.26        perf-profile.self.cycles-pp.__account_obj_stock
      0.21 ±  2%      -0.1        0.10 ±  4%      -0.0        0.20        perf-profile.self.cycles-pp.__kmalloc_cache_noprof
      0.24            -0.1        0.14            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__dequeue_entity
      0.19            -0.1        0.10 ±  4%      -0.0        0.19        perf-profile.self.cycles-pp.pick_task_fair
      0.14 ±  3%      -0.1        0.05            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.inode_set_ctime_current
      0.16 ±  3%      -0.1        0.06 ±  7%      +0.0        0.16        perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.15            -0.1        0.06            +0.0        0.15        perf-profile.self.cycles-pp.avg_vruntime
      0.16            -0.1        0.07            +0.0        0.16        perf-profile.self.cycles-pp.schedule_idle
      0.08            -0.1        0.00            -0.0        0.07        perf-profile.self.cycles-pp.security_msg_msg_free
      0.07            -0.1        0.00            -0.0        0.06        perf-profile.self.cycles-pp.ct_kernel_enter
      0.07            -0.1        0.00            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.trylock_stock
      0.15            -0.1        0.08 ±  5%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.dl_server_update
      0.15            -0.1        0.08 ±  5%      +0.0        0.15        perf-profile.self.cycles-pp.raw_spin_rq_lock_nested
      0.12            -0.1        0.05 ±  8%      +0.0        0.12        perf-profile.self.cycles-pp.migrate_disable_switch
      0.12 ±  4%      -0.1        0.05            +0.0        0.12        perf-profile.self.cycles-pp.__x64_sys_mq_timedreceive
      0.13            -0.1        0.07 ±  7%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.___task_rq_lock
      0.09 ±  5%      -0.1        0.03 ± 70%      +0.0        0.11        perf-profile.self.cycles-pp.inode_set_ctime_to_ts
      0.22            -0.1        0.16            -0.0        0.21        perf-profile.self.cycles-pp.cpuidle_enter_state
      0.12            -0.1        0.06            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.store_msg
      0.12            -0.1        0.06            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.wakeup_preempt_fair
      0.11            -0.1        0.05            +0.0        0.11        perf-profile.self.cycles-pp.timestamp_truncate
      0.11 ±  4%      -0.1        0.05 ±  8%      +0.0        0.12        perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.12 ±  4%      -0.1        0.06 ±  7%      -0.0        0.11        perf-profile.self.cycles-pp.do_perf_trace_sched_stat_runtime
      0.11 ±  4%      -0.1        0.06 ±  8%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.07 ± 11%      -0.1        0.02 ±141%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.mq_timedreceive
      0.13 ±  3%      -0.0        0.08            +0.0        0.13        perf-profile.self.cycles-pp.update_curr_dl_se
      0.15            -0.0        0.11 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.09            -0.0        0.05 ±  8%      -0.0        0.09        perf-profile.self.cycles-pp.native_irq_return_iret
      0.14 ±  3%      -0.0        0.10 ±  4%      -0.0        0.13        perf-profile.self.cycles-pp.vruntime_eligible
      0.14 ±  3%      -0.0        0.11            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ktime_get
      0.07 ±  7%      -0.0        0.03 ± 70%      -0.0        0.06        perf-profile.self.cycles-pp.__set_next_task_fair
      0.15 ±  3%      -0.0        0.13            +0.0        0.16        perf-profile.self.cycles-pp.put_prev_entity
      0.02 ±141%      -0.0        0.00            +0.1        0.09        perf-profile.self.cycles-pp.css_rstat_updated
      0.02 ±141%      -0.0        0.00            +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.19            -0.0        0.18 ±  2%      -0.0        0.18        perf-profile.self.cycles-pp.__x64_sys_mq_timedsend
      0.00            +0.0        0.00            +0.1        0.11        perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.0        0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00            +0.0        0.00            +0.3        0.26 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.11 ±  4%      +0.0        0.12 ±  3%      +0.0        0.11        perf-profile.self.cycles-pp.set_next_task_idle
      0.06            +0.0        0.08 ±  6%      +0.0        0.06        perf-profile.self.cycles-pp.perf_swevent_event
      0.07 ±  7%      +0.0        0.09 ± 10%      +0.0        0.11        perf-profile.self.cycles-pp.mq_timedsend
      0.00            +0.1        0.05            +0.0        0.00        perf-profile.self.cycles-pp.ct_idle_enter
      0.00            +0.1        0.05            +0.0        0.00        perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.00            +0.1        0.06            +0.0        0.00        perf-profile.self.cycles-pp.sched_update_worker
      0.12            +0.1        0.18 ±  6%      +0.0        0.12        perf-profile.self.cycles-pp.x64_sys_call
      0.38 ±  2%      +0.1        0.46            -0.0        0.37        perf-profile.self.cycles-pp.finish_task_switch
      0.08 ±  5%      +0.1        0.20 ±  6%      -0.0        0.08        perf-profile.self.cycles-pp.do_perf_trace_sched_switch
      0.18 ±  5%      +0.5        0.71 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.update_sg_lb_stats
      5.89            +0.9        6.81            -0.0        5.88        perf-profile.self.cycles-pp.intel_idle
      0.07            +7.4        7.48 ±  4%      +0.1        0.22 ±  6%  perf-profile.self.cycles-pp.__refill_obj_stock
      0.00            +8.7        8.70 ±  3%      +0.0        0.00        perf-profile.self.cycles-pp.drain_obj_stock
      2.25           +12.4       14.61            +0.0        2.26        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.53           +19.0       19.48            +0.1        0.67        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook

