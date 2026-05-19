Return-Path: <cgroups+bounces-16062-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIsmF/PvC2oDRgUAu9opvQ
	(envelope-from <cgroups+bounces-16062-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 07:06:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC6577598
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 07:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65D6B305F54A
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 05:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652E2D0614;
	Tue, 19 May 2026 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQrlUNM/"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF41AF0BB;
	Tue, 19 May 2026 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779167065; cv=fail; b=ZJyt7y/qxeMmWF9CnZcBc47JF4cHH5E+vxuMUcTiEkUS8+02DL6bB33Gp2pyKN6/wJEfNx+1m8NwDigdN6QoRi74ekLNPqUof+32hwG9XVBST/X+MaZrK76sLsd8eHhnAm0IvQiNJ0Lx/4dasS+20K9UEaJb7/hNyYnEf4mdmgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779167065; c=relaxed/simple;
	bh=xiGA5Ifbntt9q3pMdcauRBhdhK4/PgjLTuzjlWsjrk8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YqOevRSCfkQz/kFrIVdzSWgGfz1XeTW/z7hAFQwnTk/23TOOgp7rrc+xDWj4rNjCyvHEE4zg6pKzyBsRCTPvyRlOYhPDuPrj+WRrWW+cBMoni7JYxtjh7IAlia21kKzSgRjyF+R/WOVP58tY6nRG2bmvqaVsN589V0ffytnisog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQrlUNM/; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779167063; x=1810703063;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xiGA5Ifbntt9q3pMdcauRBhdhK4/PgjLTuzjlWsjrk8=;
  b=SQrlUNM/B0T79m0WMyDLcwuq9UOZWAcPCxV3Vy4kAX4k3997f5gxgovr
   4Hovm+3LgjtdHctiTp/PA6tMAfbaN0N3ljEsTwvjbM1LSnJqOG3x7TVms
   MEa/vIIp4eLy5bP6aAbfLWNft5w7KEKZkpgG9ID1fwov+SCsCl/vximmx
   Q+Y0a/9M4mkjbcwQJlOFSJpK+X8J2yj4St4PdGoQ1EfOx/DdFQ3ZDy1Or
   3CYXx0QXEIyv3rR6R4ZjlmZU4SkLVSX8eVt5N/LsRqyD7hk6ZBxy88YJp
   IpbxqjdwqBh39qdmOPbedX/MOEiKyZvwisbvpMnqztWMKzLQgPdpgMd5d
   w==;
X-CSE-ConnectionGUID: gYFBe8VoT8+KWwN4ooxJGg==
X-CSE-MsgGUID: r+VAtn8NQbWdRrfq4obfQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97602913"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97602913"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 22:04:22 -0700
X-CSE-ConnectionGUID: ++7FyAihTSaXJ0RiB6ZBnw==
X-CSE-MsgGUID: p52YVekHRVCRzQUmDEWzGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="243633947"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 22:04:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 22:04:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 22:04:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 22:04:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl+nOBdiBKPBwdR1QKIzG2dPY0o6/x64DRlb7ojnxT9u3eXYNRhOSPV8DXKRshkr5jHzMYSZk8wlEQrByDjoMA68gYZt4lH4YtVuALBbh5rrdbp2Ok1m1KY7B/6o2O8+0ZE4f6zENrF0PlFzf27A/1iRH6pYXW8ddDVSO4bbzTWgz2pp0hwOHQN+qIg+8dxrxXgO54/LcggiRLm8tkURzn7V8S4kdtbNVfOaTXtMcqmdhhWfXmajL64Gvy7tfjLIDm0CEQVbhPPAUVru/cEOzxE+LO5oJ/hLkbOoK0tl0psIVWHjwrMTpGqCGeUgMT7hcAxrk4vJ8dKN+gPpkt/OeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76GK+e5FznwGBvJ4rJ42nr8z3Ro0tA+H4wCZOAROpLg=;
 b=EnlHlNaVqrEXF8pt/AJ/XUZLHsVgI5GbiVg+1VStNsp8cC2WF8NNo4kfkhrT5mRHgFnmntd+glrJOAh5C46viI2P1kTwvVAGSLjmmMv9RtHkgDwJtvP36KbmFaSZUYcfUSdRpyA/ZVXWyjSVJxf0Sqlh1U4rpMMce64ftAEcIrqWJGf383IxQFf7yamiv6JawEuje+bFz3a4EYWWwmBGrM1HkBRKiqyYbwavOoVnHC02mVFWAyisSiHB8MKpEmBwki0lpMm0dKPGJeRXfQL6OQ/VX9hmz42WABU7aYEZkdD/lRj9yMzzZWfAGLTHxovb+HnpoFa61Re1Ao2wWWzz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 05:04:16 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 05:04:16 +0000
Date: Tue, 19 May 2026 13:04:04 +0800
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
Message-ID: <agvvRNJTAtNkCVZc@xsang-OptiPlex-9020>
References: <agSAT4ldp3dzKWPl@linux.dev>
 <agSJ4ulNDZ17ah8H@linux.dev>
 <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
 <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
 <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
 <agdS5rIhcjIBVSog@linux.dev>
 <agm61hMv08XnV8sI@xsang-OptiPlex-9020>
 <agoYp1zW9afZ6uQz@linux.dev>
 <agtATZG9mIlYzMUl@linux.dev>
 <agtPMpQK2jXdQAY4@linux.dev>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agtPMpQK2jXdQAY4@linux.dev>
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|MW3PR11MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d14d22-314a-4e6f-cd4d-08deb564138f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799003|4143699003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: JOcybUVkzReMugHNudXwrYZhayVeHvWXSUXxpizkUikEfcgFt6I3Gax+OFhakgELRi11e7e2uEtH+HisCQDeRzNbR+KeMSC+FFQkMWPuCS5ssyi3Yjp4rO09obpEb33xkevhFCJvQOamr4uJYPJ7eWmxBuRit3ZkOyrlT1VvMJkwXpdX3yq1erP6LLiuo/ZNdMWrKjL6qKDn7Cn/90EPi2JwunyjxqwLeqRtiocVcRQLOWx+BbELNZy0MGTbFeCTcgZcHQKGEPY2KglJ9gCipGTp8D3EZ9Djc0jPN/decQCnSpGxw1y4+/qvocnJoAKv1g18Cuz8XHNHGNu1QXz7lr1YW/weqMso6aC2T7+Sds2JqO30PWQTDFlqXzRmi6uWNoniKheN7MCIBxXgl1G0D6+iKZK0yYNoZ9H/mSnZ9aI9jxWP2fdrOFmFqInQx5C68IQ+vvqeQ+UNS9bWGxjqL52gtgnY4D0JXFayGZuV3xFxsvuGRxJoX9BC4gCLDWDfNMc1qX/FXAQd+j2q8pz80KC6unh/BVJuyjWCB6t8L9RRgsI9idJCEvuB/WCl+agVQcNVZ11b14I37/qAfUGQLhUiVtY8ZOlh0E7ukUc7WXkEPmb7rz77UroEObsgw131YbC/Ff0DY1HSkHxLs3EtK2WLfC/7Bg9oaqhNsMfwJ61jhP55AKKfQVtxfXDTn31C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(4143699003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ac/R5uxTSkbAzv+/2ddg4F8+toprHnMiWOue56oCfaRT/EYjOfh/XUhwAP?=
 =?iso-8859-1?Q?EODLCvZYqoSRQ0A/nnim1OD7zoRzOd8+SEFI1NO2Qy8zRw83yMdMYvs5os?=
 =?iso-8859-1?Q?3c8eJqW7u6lBRdIftcknNOetllIhSmxQISIAumRYe9rwL9rMxmftSLGpv/?=
 =?iso-8859-1?Q?78Q4MbcW+15Fc0q2RmaF2EYZ1LeOiyjQWke5fFkYVfY0HRqvxq4B3x+cr5?=
 =?iso-8859-1?Q?FnfpLNhfvu71fQuMTu0hYWxsXGyU+LCOtnghlUsbYRSYvC7EWSRDJ3XHub?=
 =?iso-8859-1?Q?mlDT63up6MBcF0Ij7NxOldsZYuxeuGOcCP8XO42odHG8opYrgcZ3mhU8aA?=
 =?iso-8859-1?Q?yq7PDlY9wt27JECY/sSkiXPR9v1Z6gV/mewKrJr0UXTEIGcQDZR1Pw9TlW?=
 =?iso-8859-1?Q?caRuBY9KM06l8oH09kUInv3DF+Cfzo0/T9hKvEz+aIfoIrYEdMylR5GpOF?=
 =?iso-8859-1?Q?/1sCdiP4sdk5PSdKo+0iNTmxvTb0/pF7MSjJ9wceaXq9bg4zxRBeJVuUe/?=
 =?iso-8859-1?Q?r16/M/fvwzBEA5QrSFNVRXV0wuoZRXLUXtKfm0beTm05KZHVJIIzD7HHrc?=
 =?iso-8859-1?Q?hisGFhGogCs9eGpfaHJwhTO99TqttfGBiKfls4YkXqSZ/60b/Ecj1qoJlz?=
 =?iso-8859-1?Q?ipsGp4SGSK+TZtumT/IIzarZ1E9aVeVbszPgD/vZH7C5h7pL+hUIynlp5G?=
 =?iso-8859-1?Q?IDHRQ0TPPkn5Uey9pc5AwEkeKSbb+geUeFo5CVwn08/y8FqFB+JcB2oXRF?=
 =?iso-8859-1?Q?FIn9tJsGJmsbFggzz//TPf/111Hg7jnU0VLA1uqg2CwVxotdcQyRN6Eale?=
 =?iso-8859-1?Q?kstXpp1pWSjoXNbWxShRBZbV4ewKSeiUCozTAB9QWtyueaBi6FrhADMonc?=
 =?iso-8859-1?Q?rt8fBcunqn5GvZO7WAGHaaxW+OqZU7o4VCftDaqP/2HY9VzzS91JsvDAAY?=
 =?iso-8859-1?Q?Ti0SPCyg04ztf0uSGCP/eSGSpZ4YT5ZYluXI7tSeu/FFEe0LxqJujjp6Pq?=
 =?iso-8859-1?Q?LNcKnhy6I8xM51N1FSb+ek0LdXCAVvhk1Ld3/O/DX9MzA8Txelk9/ffUnx?=
 =?iso-8859-1?Q?nu/RL1KTYWzARazWVLsUYNMy8b2YZSe3LioESzVQef15IZyIKOy1/cjowU?=
 =?iso-8859-1?Q?GwVZWvO/v5nfk61b6fyAMCNjTOrgNkjq14jUYeXhIzoRW8ud4UnjgaHkBS?=
 =?iso-8859-1?Q?BRExHgspC5q6HElU7lpdi+vjT97XOnpApGtPgVTnbc/sqTCFYaBCgx8+pj?=
 =?iso-8859-1?Q?0qgPjL5xNK5/uWUlewwcRf/V66SjhYVvUqrtS5iGMh2JIpN3jCoN9Oys7W?=
 =?iso-8859-1?Q?18d9KMa9hr/PKC2b6If/wf7ddLNc9KWCNoeKP5M3OYIvCqLhxOtbdyHz6Y?=
 =?iso-8859-1?Q?OwVWIgGNbmB2o6VSkxeRMG9bkqUELlfBujDU1he4krU529qVqtUi+AMmYL?=
 =?iso-8859-1?Q?CLLpNAoMEEIHNW2MaocN2SdDHqKRme7g92DkRXGUirT3XBqMJyJXCbRjRV?=
 =?iso-8859-1?Q?G4eRqWzxwOnyq6Aw/Hyw2XZ+H5irkXO4HeUxg9LIq/aI8IewOg1qjViUj/?=
 =?iso-8859-1?Q?E0iupNfJ+rfhuYPeISGnkHXKAN0CMCtXJTIX3q2rzGJObaqKIRZ3Cf8yss?=
 =?iso-8859-1?Q?65WEJsA8cWjEcWIlkdmuECelJkC8KMZJZVXeuQqoU6d32zsWGrkI+6+lh0?=
 =?iso-8859-1?Q?6WFWeWQMSUSHpHCmtWXlRvZbltbm/wKMTHQ+VC9zMewEKndbHA5eF2X8pE?=
 =?iso-8859-1?Q?9NYQuDPvAMWvghmOhcX524FUlt/MKKQg5XdNxJCixTV0uIUIlUSnWzNFh7?=
 =?iso-8859-1?Q?8dWhyFdCAw=3D=3D?=
X-Exchange-RoutingPolicyChecked: k7Pst6AdVMu4A86u8tF8dARh8KZUAKFglKuod8RIulbhi3ogVyl28/3l2mmtmQW8oMaX1ktOagOMZ67wElLLn3MmjSZ7go4v/pyqp8O9Fl2AwIytn65MGQ57vb+H26XFoVgSv4zfFO/DfT0SkAT2xUI98WQpHxHVU2ebbBM7JEpr7juUl8DAq518by/HrApka3ul8cUF2oh6+tsv3rP1GKtR2pUoS+Zi5090VchQX769N8gBXJolqqKo54CoDt7U2LrvH14QfIXsQhBDznjEGZ+fl8yRE6Zsv6I8xr5qAC5GA821SS1l8kiklHgnubeg2D+efkVNLNKa0XlD+sCX/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d14d22-314a-4e6f-cd4d-08deb564138f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 05:04:16.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1f+3hkH4VYVYgRMPVgUf/IFYMugYWHgHD7yrGLgjL7IHmB7AKdelTRwcy6PrP4SAsim3pK9I4nov8TLQmNrJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16062-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,linux.dev:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C7AC6577598
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hi, Shakeel,

On Mon, May 18, 2026 at 10:54:20AM -0700, Shakeel Butt wrote:
> On Mon, May 18, 2026 at 09:39:00AM -0700, Shakeel Butt wrote:
> > On Sun, May 17, 2026 at 12:38:48PM -0700, Shakeel Butt wrote:
> > > On Sun, May 17, 2026 at 08:55:50PM +0800, Oliver Sang wrote:
> > > > hi, Shakeel, hi, Qi,
> > > > 
> > > > #2: when we test above patch, we found the server easy to crash while running
> > > > tests. we try to run up to 20 times, only 2 of them run successfully (above
> > > > 37739220 is just the average data from these 2 runs, since the data is stable,
> > > > we think maybe it's ok to report to you with this data).
> > > > we also noticed for [1] there is a [syzbot ci] report in [2]. since we don't
> > > > have serial output for our test server in this report which is for performance
> > > > tests, we cannot say if other 18 runs failed due to similar reason. just FYI.
> > > > 
> > > 
> > > The syzbot report is simply a rcu warning which will be fixed in v2. Do you
> > > have more details on the crash you are seeing? Is it page counter underflow
> > > warning?
> > > 
> > > Thanks again for the help.
> > 
> > Hi Oliver, it seems like sashiko found another issue with v2, so, if you have
> > not yet started the test, you can skip it.

firstly, let me still give you an update about v2. I applied it directly on top
of 01b9da291c, found it can recover the performance.

=========================================================================================
compiler/cpufreq_governor/kconfig/method/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/mq/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/switch/stress-ng/60s

commit: 
  8285917d6f ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
  01b9da291c ("mm: memcontrol: convert objcg to be per-memcg per-node type")
  8da1b1ea43 ("memcg: cache obj_stock by memcg, not by objcg pointer")   <---- v2

8285917d6f383aef 01b9da291c4969354807b52956f 8da1b1ea4344c152a3892cbb132
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      5849          +210.2%      18145 ±  3%      +0.8%       5896        stress-ng.switch.nanosecs_per_context_switch_mq_method
 2.296e+09           -67.7%  7.408e+08 ±  3%      -0.8%  2.278e+09        stress-ng.switch.ops
  38288993           -67.7%   12355813 ±  3%      -0.8%   37987427        stress-ng.switch.ops_per_sec

but since this version is out-of-date now, I won't give out the full
comparison. if you still want it, please let me know.

> > 
> > Also I am rethinking the approach, so I will send a prototype in response on
> > this email for which I will need your help in testing.
> 
> Hi Oliver, can you please test the following patch?

got it. will change to test following patch. and this looks quite different
with v2 or v3, so if you still want us to test v3, please let me know. thanks!

> 
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Subject: [PATCH] memcg: shrink obj_stock_pcp and cache multiple objcgs
> 
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 213 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 156 insertions(+), 57 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d978e18b9b2d..2a9e5136a956 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -150,14 +150,14 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>  	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
>  	 *
>  	 * The following sequence can lead to it:
> -	 * 1) CPU0: objcg == stock->cached_objcg
> +	 * 1) CPU0: objcg cached in one of stock->cached[i]
>  	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
>  	 *          PAGE_SIZE bytes are charged
>  	 * 3) CPU1: a process from another memcg is allocating something,
>  	 *          the stock if flushed,
>  	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
>  	 * 5) CPU0: we do release this object,
> -	 *          92 bytes are added to stock->nr_bytes
> +	 *          92 bytes are added to stock->nr_bytes[i]
>  	 * 6) CPU0: stock is flushed,
>  	 *          92 bytes are added to objcg->nr_charged_bytes
>  	 *
> @@ -2017,13 +2017,25 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
>  	.lock = INIT_LOCAL_TRYLOCK(lock),
>  };
>  
> +/*
> + * NR_OBJ_STOCK is sized so the entire hot path of obj_stock_pcp
> + * (lock, accounting metadata, nr_bytes[] and cached[]) fits within a
> + * single 64-byte cache line on non-debug 64-bit builds. With 5 slots:
> + *   lock(1) + index(1) + node_id(2) + slab stats(4) + nr_bytes(10)
> + *   + pad(6) + cached(40) == 64 bytes.
> + * A CPU can thus consume/refill/account against five different objcgs
> + * (typically per-node variants of the same memcg) while incurring at
> + * most one cache miss on the stock.
> + */
> +#define NR_OBJ_STOCK 5
>  struct obj_stock_pcp {
>  	local_trylock_t lock;
> -	unsigned int nr_bytes;
> -	struct obj_cgroup *cached_objcg;
> -	struct pglist_data *cached_pgdat;
> -	int nr_slab_reclaimable_b;
> -	int nr_slab_unreclaimable_b;
> +	int8_t index;
> +	int16_t node_id;
> +	int16_t nr_slab_reclaimable_b;
> +	int16_t nr_slab_unreclaimable_b;
> +	uint16_t nr_bytes[NR_OBJ_STOCK];
> +	struct obj_cgroup *cached[NR_OBJ_STOCK];
>  
>  	struct work_struct work;
>  	unsigned long flags;
> @@ -2031,10 +2043,13 @@ struct obj_stock_pcp {
>  
>  static DEFINE_PER_CPU_ALIGNED(struct obj_stock_pcp, obj_stock) = {
>  	.lock = INIT_LOCAL_TRYLOCK(lock),
> +	.index = -1,
> +	.node_id = NUMA_NO_NODE,
>  };
>  
>  static DEFINE_MUTEX(percpu_charge_mutex);
>  
> +static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i);
>  static void drain_obj_stock(struct obj_stock_pcp *stock);
>  static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
>  				     struct mem_cgroup *root_memcg);
> @@ -3152,39 +3167,68 @@ static void unlock_stock(struct obj_stock_pcp *stock)
>  		local_unlock(&obj_stock.lock);
>  }
>  
> -/* Call after __refill_obj_stock() to ensure stock->cached_objg == objcg */
> +/* Call after __refill_obj_stock() so a slot for objcg exists in the stock */
>  static void __account_obj_stock(struct obj_cgroup *objcg,
>  				struct obj_stock_pcp *stock, int nr,
>  				struct pglist_data *pgdat, enum node_stat_item idx)
>  {
> -	int *bytes;
> +	int16_t *bytes;
> +	int i;
>  
> -	if (!stock || READ_ONCE(stock->cached_objcg) != objcg)
> +	/*
> +	 * node_id is stored as int16_t and -1 is used as the "no pgdat
> +	 * cached" sentinel, so MAX_NUMNODES must fit in a positive int16_t.
> +	 */
> +	BUILD_BUG_ON(MAX_NUMNODES >= S16_MAX);
> +
> +	if (!stock)
> +		goto direct;
> +
> +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> +		if (READ_ONCE(stock->cached[i]) == objcg)
> +			break;
> +	}
> +	if (i == NR_OBJ_STOCK)
>  		goto direct;
>  
>  	/*
>  	 * Save vmstat data in stock and skip vmstat array update unless
> -	 * accumulating over a page of vmstat data or when pgdat changes.
> +	 * accumulating over a page of vmstat data or when the objcg slot or
> +	 * pgdat the stats belong to changes.
>  	 */
> -	if (stock->cached_pgdat != pgdat) {
> -		/* Flush the existing cached vmstat data */
> -		struct pglist_data *oldpg = stock->cached_pgdat;
> +	if (stock->index < 0) {
> +		stock->index = i;
> +		stock->node_id = pgdat->node_id;
> +	} else if (stock->index != i || stock->node_id != pgdat->node_id) {
> +		struct obj_cgroup *old = READ_ONCE(stock->cached[stock->index]);
> +		struct pglist_data *oldpg = NODE_DATA(stock->node_id);
>  
>  		if (stock->nr_slab_reclaimable_b) {
> -			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
> +			mod_objcg_mlstate(old, oldpg, NR_SLAB_RECLAIMABLE_B,
>  					  stock->nr_slab_reclaimable_b);
>  			stock->nr_slab_reclaimable_b = 0;
>  		}
>  		if (stock->nr_slab_unreclaimable_b) {
> -			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
> +			mod_objcg_mlstate(old, oldpg, NR_SLAB_UNRECLAIMABLE_B,
>  					  stock->nr_slab_unreclaimable_b);
>  			stock->nr_slab_unreclaimable_b = 0;
>  		}
> -		stock->cached_pgdat = pgdat;
> +		stock->index = i;
> +		stock->node_id = pgdat->node_id;
>  	}
>  
>  	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
>  					       : &stock->nr_slab_unreclaimable_b;
> +	/*
> +	 * Cached stats are int16_t; flush directly if accumulating @nr would
> +	 * overflow or underflow the cache.
> +	 */
> +	if (abs(nr + *bytes) >= S16_MAX) {
> +		nr += *bytes;
> +		*bytes = 0;
> +		goto direct;
> +	}
> +
>  	/*
>  	 * Even for large object >= PAGE_SIZE, the vmstat data will still be
>  	 * cached locally at least once before pushing it out.
> @@ -3210,10 +3254,16 @@ static bool __consume_obj_stock(struct obj_cgroup *objcg,
>  				struct obj_stock_pcp *stock,
>  				unsigned int nr_bytes)
>  {
> -	if (objcg == READ_ONCE(stock->cached_objcg) &&
> -	    stock->nr_bytes >= nr_bytes) {
> -		stock->nr_bytes -= nr_bytes;
> -		return true;
> +	int i;
> +
> +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> +		if (READ_ONCE(stock->cached[i]) != objcg)
> +			continue;
> +		if (stock->nr_bytes[i] >= nr_bytes) {
> +			stock->nr_bytes[i] -= nr_bytes;
> +			return true;
> +		}
> +		return false;
>  	}
>  
>  	return false;
> @@ -3234,16 +3284,42 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  	return ret;
>  }
>  
> -static void drain_obj_stock(struct obj_stock_pcp *stock)
> +/* Flush the cached slab stats (if any) back to their owning objcg/pgdat. */
> +static void drain_obj_stock_stats(struct obj_stock_pcp *stock)
> +{
> +	struct obj_cgroup *old;
> +	struct pglist_data *oldpg;
> +
> +	if (stock->index < 0)
> +		return;
> +
> +	old = READ_ONCE(stock->cached[stock->index]);
> +	oldpg = NODE_DATA(stock->node_id);
> +
> +	if (stock->nr_slab_reclaimable_b) {
> +		mod_objcg_mlstate(old, oldpg, NR_SLAB_RECLAIMABLE_B,
> +				  stock->nr_slab_reclaimable_b);
> +		stock->nr_slab_reclaimable_b = 0;
> +	}
> +	if (stock->nr_slab_unreclaimable_b) {
> +		mod_objcg_mlstate(old, oldpg, NR_SLAB_UNRECLAIMABLE_B,
> +				  stock->nr_slab_unreclaimable_b);
> +		stock->nr_slab_unreclaimable_b = 0;
> +	}
> +	stock->index = -1;
> +	stock->node_id = NUMA_NO_NODE;
> +}
> +
> +static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i)
>  {
> -	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
> +	struct obj_cgroup *old = READ_ONCE(stock->cached[i]);
>  
>  	if (!old)
>  		return;
>  
> -	if (stock->nr_bytes) {
> -		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> -		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
> +	if (stock->nr_bytes[i]) {
> +		unsigned int nr_pages = stock->nr_bytes[i] >> PAGE_SHIFT;
> +		unsigned int nr_bytes = stock->nr_bytes[i] & (PAGE_SIZE - 1);
>  
>  		if (nr_pages) {
>  			struct mem_cgroup *memcg;
> @@ -3269,44 +3345,43 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
>  		 * so it might be changed in the future.
>  		 */
>  		atomic_add(nr_bytes, &old->nr_charged_bytes);
> -		stock->nr_bytes = 0;
> +		stock->nr_bytes[i] = 0;
>  	}
>  
> -	/*
> -	 * Flush the vmstat data in current stock
> -	 */
> -	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
> -		if (stock->nr_slab_reclaimable_b) {
> -			mod_objcg_mlstate(old, stock->cached_pgdat,
> -					  NR_SLAB_RECLAIMABLE_B,
> -					  stock->nr_slab_reclaimable_b);
> -			stock->nr_slab_reclaimable_b = 0;
> -		}
> -		if (stock->nr_slab_unreclaimable_b) {
> -			mod_objcg_mlstate(old, stock->cached_pgdat,
> -					  NR_SLAB_UNRECLAIMABLE_B,
> -					  stock->nr_slab_unreclaimable_b);
> -			stock->nr_slab_unreclaimable_b = 0;
> -		}
> -		stock->cached_pgdat = NULL;
> -	}
> +	/* Flush vmstat data when its owning slot is being drained. */
> +	if (stock->index == i)
> +		drain_obj_stock_stats(stock);
>  
> -	WRITE_ONCE(stock->cached_objcg, NULL);
> +	WRITE_ONCE(stock->cached[i], NULL);
>  	obj_cgroup_put(old);
>  }
>  
> +static void drain_obj_stock(struct obj_stock_pcp *stock)
> +{
> +	int i;
> +
> +	for (i = 0; i < NR_OBJ_STOCK; ++i)
> +		drain_obj_stock_slot(stock, i);
> +}
> +
>  static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
>  				     struct mem_cgroup *root_memcg)
>  {
> -	struct obj_cgroup *objcg = READ_ONCE(stock->cached_objcg);
> +	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
>  	bool flush = false;
> +	int i;
>  
>  	rcu_read_lock();
> -	if (objcg) {
> +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> +		objcg = READ_ONCE(stock->cached[i]);
> +		if (!objcg)
> +			continue;
>  		memcg = obj_cgroup_memcg(objcg);
> -		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
> +		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg)) {
>  			flush = true;
> +			break;
> +		}
>  	}
>  	rcu_read_unlock();
>  
> @@ -3319,6 +3394,8 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>  			       bool allow_uncharge)
>  {
>  	unsigned int nr_pages = 0;
> +	unsigned int stock_nr_bytes;
> +	int i, slot = -1, empty_slot = -1;
>  
>  	if (!stock) {
>  		nr_pages = nr_bytes >> PAGE_SHIFT;
> @@ -3327,21 +3404,43 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>  		goto out;
>  	}
>  
> -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> -		drain_obj_stock(stock);
> +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> +		struct obj_cgroup *cached = READ_ONCE(stock->cached[i]);
> +
> +		if (!cached) {
> +			if (empty_slot == -1)
> +				empty_slot = i;
> +			continue;
> +		}
> +		if (cached == objcg) {
> +			slot = i;
> +			break;
> +		}
> +	}
> +
> +	if (slot == -1) {
> +		slot = empty_slot;
> +		if (slot == -1) {
> +			slot = get_random_u32_below(NR_OBJ_STOCK);
> +			drain_obj_stock_slot(stock, slot);
> +		}
>  		obj_cgroup_get(objcg);
> -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> +		stock->nr_bytes[slot] = atomic_read(&objcg->nr_charged_bytes)
>  				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> -		WRITE_ONCE(stock->cached_objcg, objcg);
> +		WRITE_ONCE(stock->cached[slot], objcg);
>  
>  		allow_uncharge = true;	/* Allow uncharge when objcg changes */
>  	}
> -	stock->nr_bytes += nr_bytes;
>  
> -	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
> -		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> -		stock->nr_bytes &= (PAGE_SIZE - 1);
> +	stock_nr_bytes = (unsigned int)stock->nr_bytes[slot] + nr_bytes;
> +
> +	/* nr_bytes[] is uint16_t; flush if we would refill >= U16_MAX. */
> +	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
> +	    stock_nr_bytes >= U16_MAX) {
> +		nr_pages = stock_nr_bytes >> PAGE_SHIFT;
> +		stock_nr_bytes &= (PAGE_SIZE - 1);
>  	}
> +	stock->nr_bytes[slot] = stock_nr_bytes;
>  
>  out:
>  	if (nr_pages)
> -- 
> 2.53.0-Meta
> 

