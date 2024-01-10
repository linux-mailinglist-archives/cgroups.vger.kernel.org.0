Return-Path: <cgroups+bounces-1113-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7630B829D14
	for <lists+cgroups@lfdr.de>; Wed, 10 Jan 2024 16:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6C11F22DF5
	for <lists+cgroups@lfdr.de>; Wed, 10 Jan 2024 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822664BA90;
	Wed, 10 Jan 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+2ejEls"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DF4BA85;
	Wed, 10 Jan 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704898952; x=1736434952;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=GG+9/C0e10qaGIU0mKsuA/7fjz2d0AsfACQ6DaAhb6A=;
  b=E+2ejElssBfZN4WbGw7EIgj5oT+2OwEl7j2kTu1Vo3Dcckbrgy2J9VIP
   dyBXy6r4Gw7mP0BdyNeMTSSsVa50nAVWOrVCvcJDGBhZbByDlr0C4qojy
   iba9k/v96OPQc2AQ6Os40xwYURZLBtMjxzcy+wNaKW4B8TBzVFBX0ckKr
   clm6YMECbVqEFfPpRDg0QViv4z/7KIrB+xfY6MINMVsEoeL6LWjEe4/X9
   AOydLypVNfnEL3OY8ingQKWNm1CDSNAeUqtqVdwWazelMU4r3PmymfP6I
   tSUk15A5I1Dd7UXDg2bKEgnV2F9Q+xbdTOHEWiXmK3BBqBAFHj+s5C6Xn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="5625639"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5625639"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="925661693"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925661693"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 07:01:29 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 07:01:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 07:01:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 07:01:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkUiEJy6HnRGdK+ASOkunVqQtT1OwXxaSXUkJlFWjFMf+BxzdBcldTYreB4Xqnn6WjxXOWnsmGhH5eUL+aeTbAxMCUTkSidBaM+la/IabgVVlvir2JP7CifkbWbWUQInHsApbXiTfWajcd8REx7D6wud6RNFp3CwRlv0pGqtinRuWXBvt1u0vODyerZtACIkVBFqNXrwZoXZf+frKw6C+KvyC2/G0AYqvEV/X+W26CI+V+ZKccjtXXVLwGWfYS271GNTkb0rpWejGhS4YD2P5zdANixZysguPamVq2B8bWUsV7gDFf9PBPJL1jKJSeGDGeSvxO2GEhCefsgHKTGKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfWsuNdmHBYOwM3O3Q/dey2Fe3yNXti7sC3NXagzApY=;
 b=gaBhNU3vjQ1Wyg0Hu9zc8+pOvX0Fhtk91azbYjue2SBh/owVH5yfoFHQmyJk3BCaz5aR+KjAcTwLqxg/18EmOY7nBCpIsQYGCxBvfmStYdwsV1CGsoFQB/XLoqq1kpsqAFbnYEZLbpD+pyno6feMUxaN/5aro26qDJv/rtXriC+KZ899KlXVU8/+mnqxr0NCdfJ5L2sJB3ksW0yNemvWrML3A8sgkp5zdQpKjJI9tm9DjAdfROZPWipP0EqOMcAxZBycbvnHi0NQp61PW1cX/d6aXwK2c3LbL8g9DzAOo45U4ChkqQha9piBwlAxw8oGNmmcJ1qiGvqeHpxAO8uMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6708.namprd11.prod.outlook.com (2603:10b6:510:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 15:01:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 15:01:23 +0000
Date: Wed, 10 Jan 2024 23:01:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <cgroups@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>, Zefan Li
	<lizefan.x@bytedance.com>, LKML <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] cgroup/cpuset: Adjust exception handling in
 generate_sched_domains()
Message-ID: <202401102216.c93598af-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53be5f98-6359-48b5-955e-fd203d99d3cb@web.de>
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: eb081f94-11c2-4ec5-b71f-08dc11ed02ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24wHX+YRbNBDkZDUEcN3kkgWUVCKc+NujlZtkQSjGbhJZQ16rZ5/GKDVPXOQveB2Hu/p6DNZ+iGz1ktdRICeJenf45VvuxytM50smo+lEWIgr/6PDPfekvs2Pt0Kr4jBNB49CUojg7BatjdQbtexNZl3PMGcU8F3NfeFHMBld7pdOPmfWDg0aaa8/sIYyK42vF7Mreg0wJ+4AU/FrYbyMm3fJiyBooSMDHE6KSoHmF1kus706MGcQMzpdfA17zvPjZpWGQXvwDaDxkvBj2PlhOl9HOMzSQVLPdr5ScEYUxPSM70Hbe0Q2JomawJiMDxIfYuUPWxQjpXlRgTyMfBC+9WC4OVE/vIDkB5r2fwtd9Dkhne9dqSufEdUuOXLZvQLg51w4fqnUXUUcwBhSe7AASFJvG9SSLNcU+F3rCq6+QR50LxUJBRbs9QqEehzfC584Oa5COEyetgC5fHiJS7sOngKpaQroUcwbrcI8enspJfXWN/0N9r/sheKem+Mh+R131WPdeFZ1P8kzlTdo3lih6Q8ms1Z/RXgZNrVACS44Ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(966005)(6666004)(478600001)(38100700002)(83380400001)(6506007)(6512007)(8676002)(26005)(6486002)(2616005)(107886003)(54906003)(2906002)(5660300002)(316002)(4326008)(86362001)(8936002)(66476007)(66556008)(36756003)(66946007)(6916009)(1076003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehsNBYMadYBA4cqtjRpaLDhtfIQWGpkYYTJ1in4IORESx9VBCwMwkggMYQJE?=
 =?us-ascii?Q?p5Xj3IF8FX/hY3spdyYA7KqaM27hrd7My6aERWUMv6EoQm58qUGJ9wSLhc/B?=
 =?us-ascii?Q?79Cb8xSQP3JkNd8whrSaYcWwqumYN+LHSFc08f3rchllzy6B7rDBjGDtvFZS?=
 =?us-ascii?Q?e7ZO63Dkdh7Pdv9PztRrw5qmFeTD+GSOQMPbxe5Htxyrk6Vpt8tpvujIfism?=
 =?us-ascii?Q?z3uS/MIGWZi5xnpT73QjybuFV01lJvdy3yhaMpE+bT3CN6CpxYjyu8ZBWtmn?=
 =?us-ascii?Q?Ruk+yF62VcfsHvvN9RTfzN2ywkTh2rJGoxDqqFjUULqEZUTop0fFP1MlQi3x?=
 =?us-ascii?Q?+ZN5cDNw5Vva80qnaLA+twSxRJEyKDuwRvM5B9ODAgKysBbULDvxhHbyxIqD?=
 =?us-ascii?Q?WN0l/bpY/bBiyCgm+bjWsU8yHcqDbLktbB87k2B14cH5H4L6dDDwi8T1kaWx?=
 =?us-ascii?Q?OkmwL5MeH6qrHQ2sU7xWN4yaP3KRAStd5aPcAodos764MrTZ5tryFI7QONQI?=
 =?us-ascii?Q?f5spzbvjutgiu0dyumG8Mze5nHi3LYyJlVrF0o2p45IyCR7pskGQnr31lZw8?=
 =?us-ascii?Q?FxoT3yGqk7vZGJN9VeVUCwYGFZGuSG8J56i2STjr1gTaO96qvnMMCQqhGRWr?=
 =?us-ascii?Q?9l704l7bEJV87kDQ8jh/qDArmYilvgIdPGLg1y11i+F2xDvOfYw2lqnDX7wE?=
 =?us-ascii?Q?4QPi09yZP91qDaBtqwVTdu9JIe7doY98L4KwdxF4b8kNL+41i4ZX95WXHJpl?=
 =?us-ascii?Q?Y4ISH/1pt22FmAQmd7uBZKEPjgLrL8ZpdnIhed20KrQ3/QoLBR+GuOeNgorD?=
 =?us-ascii?Q?LiFZMAGBEJoFh26kwhv2vS9rWLVL3jlifNwDxc1JX8D+TQzuyI4hgSoW/5if?=
 =?us-ascii?Q?Jx4H4vWoG9nMptVcHImYKe9ViGdshI2wXuswIPmWwEzwXnTRsgRvubtL8IS0?=
 =?us-ascii?Q?5VRWaLnL372/Sj3oSGbclHn3ZJFlE6Doii+Ud4UPtIEaAviUeM11hxcm7pXg?=
 =?us-ascii?Q?z8Q6Iy+p1FSwoIX9ixkyrasep8RuVS6vIaq4KGvD17aaJuas7YqM/MciXH2W?=
 =?us-ascii?Q?2lAU75kRA73GChPekuFmaIGnVuVTBXEWFQZp+ZBdUQ/2yDPTOWW0aIrVnZK+?=
 =?us-ascii?Q?OoszoiXe7GsG+CDQAqPYZ+WFtsbksdxo1b75xsP71HPowul7DkgrV2b9I8Lj?=
 =?us-ascii?Q?UrjO8MkYFMxCLW1ZxfOHUDZUTOAF6BtBBwnFOru1tkCBcD2hlI+lHk1dpH0k?=
 =?us-ascii?Q?ogE0Eqik/dVUIX9vLcfbid1Xb3noW+LxNWovQE+RpErPyVL6hSchvBR7fP94?=
 =?us-ascii?Q?4cZcfJGSpnq1gwSGi9ys6JboZwCiFxXEcc9pG60yUBetkYv/GE7B6PZNdlzh?=
 =?us-ascii?Q?1jqMxLBl9fEVsxTg7gVsiRu7OQqel8l0XikyBWn8wbFgxjblPsc/dTxiP/60?=
 =?us-ascii?Q?vBVDHMcVQMgrD/Nl6jQo58DwO42TxXGh7z0JLScWMdUCSfkja0Cf8nsgorFd?=
 =?us-ascii?Q?899Cw+BJ+8++TfIPT7l+Uo6zVVFLpKVzhABUgAdiCJr6YywXYy9uJDwdN3D6?=
 =?us-ascii?Q?SmhGBuC4HnAIF9yzhc2jtWlbJ1YHrmv0irVTuK4jzkCRAksnhOBbWB9CzOT6?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb081f94-11c2-4ec5-b71f-08dc11ed02ae
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:01:23.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS5SXYF5S0xxM53dZEjj70Gn8qIb1h/N3nbUL5YU5jrF0Qm3VwadWLWRZ//yJ+MEBZga++n6v9rpnFgvvQFLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6708
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "canonical_address#:#[##]" on:

commit: 85f67f5f644dba9e15b9fa957f4af4745a330157 ("[PATCH] cgroup/cpuset: Adjust exception handling in generate_sched_domains()")
url: https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/cgroup-cpuset-Adjust-exception-handling-in-generate_sched_domains/20231231-152941
base: https://git.kernel.org/cgit/linux/kernel/git/tj/cgroup.git for-next
patch link: https://lore.kernel.org/all/53be5f98-6359-48b5-955e-fd203d99d3cb@web.de/
patch subject: [PATCH] cgroup/cpuset: Adjust exception handling in generate_sched_domains()

in testcase: cpu-hotplug
version: 
with following parameters:




compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401102216.c93598af-oliver.sang@intel.com


[   32.391748][  T310] RESULT_ROOT=/result/cpu-hotplug/defaults/lkp-kbl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/85f67f5f644dba9e15b9fa957f4af4745a330157/0
[   32.391787][  T310]
[   32.412091][  T310] job=/lkp/jobs/scheduled/lkp-kbl-d01/cpu-hotplug-defaults-debian-11.1-x86_64-20220510.cgz-85f67f5f644d-20240110-32485-1y7a2hd-0.yaml
[   32.412128][  T310]
[   32.449795][    T8] smpboot: CPU 1 is now offline
[   32.455650][  T230] general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
[   32.467476][  T230] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
[   32.475678][  T230] CPU: 0 PID: 230 Comm: kworker/1:2 Not tainted 6.7.0-rc1-00370-g85f67f5f644d #1
[   32.484571][  T230] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[   32.492601][  T230] Workqueue: events cpuset_hotplug_workfn
[ 32.498139][ T230] RIP: 0010:generate_sched_domains (kbuild/src/consumer/kernel/cgroup/cpuset.c:985) 
[ 32.504106][ T230] Code: b8 ff ff bf 05 00 00 00 e8 98 60 e6 ff 48 8b 54 24 20 4c 8b 25 64 fb 71 03 48 89 c3 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 a1 08 00 00 48 ba 00 00 00 00 00 fc ff df 48 8b
All code
========
   0:	b8 ff ff bf 05       	mov    $0x5bfffff,%eax
   5:	00 00                	add    %al,(%rax)
   7:	00 e8                	add    %ch,%al
   9:	98                   	cwtl
   a:	60                   	(bad)
   b:	e6 ff                	out    %al,$0xff
   d:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
  12:	4c 8b 25 64 fb 71 03 	mov    0x371fb64(%rip),%r12        # 0x371fb7d
  19:	48 89 c3             	mov    %rax,%rbx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df 
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	0f 85 a1 08 00 00    	jne    0x8d5
  34:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  3b:	fc ff df 
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 a1 08 00 00    	jne    0x8ab
   a:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  11:	fc ff df 
  14:	48                   	rex.W
  15:	8b                   	.byte 0x8b
[   32.523422][  T230] RSP: 0000:ffffc900009afb58 EFLAGS: 00010202
[   32.529307][  T230] RAX: dffffc0000000000 RBX: ffffffff8546fa20 RCX: 0000000000000004
[   32.537078][  T230] RDX: 0000000000000002 RSI: ffffffff84bd2ac0 RDI: 0000000000000005
[   32.544847][  T230] RBP: ffff88810c9e4e10 R08: 0000000000000000 R09: fffffbfff097a571
[   32.552619][  T230] R10: ffffffff84bd2b8f R11: ffffffff819c9c87 R12: ffff88810c9e4c30
[   32.560388][  T230] R13: ffffffff85470010 R14: 1ffff92000135f84 R15: dffffc0000000000
[   32.568159][  T230] FS:  0000000000000000(0000) GS:ffff8887a5600000(0000) knlGS:0000000000000000
[   32.576877][  T230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.583270][  T230] CR2: 000055eb6b0d5000 CR3: 000000081ac5a001 CR4: 00000000003706f0
[   32.591040][  T230] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   32.598811][  T230] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   32.606583][  T230] Call Trace:
[   32.609699][  T230]  <TASK>
[ 32.612477][ T230] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 32.616462][ T230] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:700 kbuild/src/consumer/arch/x86/kernel/traps.c:642) 
[ 32.621824][ T230] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:564) 
[ 32.627357][ T230] ? __kasan_kmalloc (kbuild/src/consumer/mm/kasan/common.c:374 kbuild/src/consumer/mm/kasan/common.c:383) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240110/202401102216.c93598af-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


