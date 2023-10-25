Return-Path: <cgroups+bounces-78-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826387D648F
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1134B1F22BC6
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7521C6B1;
	Wed, 25 Oct 2023 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUHvtSiH"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5671C2AF;
	Wed, 25 Oct 2023 08:07:53 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 01:07:51 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187BC1;
	Wed, 25 Oct 2023 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698221272; x=1729757272;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=0r6hGmJuCV7AiYrgBmJu0QWfYyF/BT82dpSLW3fEqR8=;
  b=jUHvtSiHqKZQsvfexuSy10jcsmvqDSNCM+XYcMJzhN91hn/tYA3L/GF5
   +jyP05kG6ahHvVThz9J3tKMwNEMt5LlC2YDUUm5AyKew4iKvdFAVBC1lj
   XeveSpEuUxxXldcxtjsh/EsoB3nkt/zbPWz94+Ikvv+UnxnUaS4lisLUm
   TcJJ/VM3z9P9uoq2Ugf1h3JGVC6PM08lZyRm/XAi+B+1Jqjgl3vFhbmfy
   xGuvtQMkGrk+QeDEatvu5Lcen0N9quEE5TrxiK3GjeCt5opg+fGMa4Q0t
   Ag//22I1n6Hbck29YHD9gZJb2Scasg9i00+NLBvEvBHJPzEAXkk0lJHuN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="25237"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="25237"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 01:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="875410515"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="875410515"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 01:06:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 01:06:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:06:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 01:06:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 01:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LclWtDEvCfy7TVBkcFrt7EthZ5wc3gp7DHPSB/6sAu4pjo5ARYO9i3+Y+1RJL8uyHL+OC4d7YX8tZk6LBFNhJaynIsYC0mIx5X1a/NUchp82ZHEofrK8VhePEfa+Me8ac3YEFE1YA1W8F6ANnJlzP2W0PwkUU4HMo9e4mDbj0XQ5SCdHeksn2dErQ55u58JrX6D1APQGvjW75slSupkCwt7JePz6l/5y5Rd69XbmCqWMOSqaNiX6J4aNHvKwTEWv2AJQNRtEYiEPcdm0U94IoVEhRk9CXuV9Sary/hqgyRJ05vhDQXh1s2n/tplGvf5hzqH6QqybHEqmGnfr5AFw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+vFAkAlvqZg/bUKsfEDRh9rBFhVUE7sogxbG3OMDi0=;
 b=fcUcVZYC3xKm2YwUaCJr16e9e+lVMOZDovuftg8z2CKlk6dsDEBBqgbtA3pCvrUCGBowowbpOcxxqp91UyhMYvAfhvOnwLLfT3gES2xTA8f3pLDkiy2dyRry/Jn2BzDHlMMnZ2Ki6dUHPhVaIGKFRlOXSnwjRHzFlVFLj6S4OwZn+6O7g2NtQA8iE6AWXy4hjUEE7fPJkGjM4vnVyfCb8kplBxpNw8ETe28oyDa1WNBulYPXYVW8rmNoqwz/s3h7o0SSGmZfdM3Gbea6qC+1Z3sbC9ERVr/h/3V00OCzRCsfxuo3QeMV6jtMI4w2AUe0cuW9UYcw5Dslkt++I+rHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB8091.namprd11.prod.outlook.com (2603:10b6:8:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:06:40 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 08:06:40 +0000
Date: Wed, 25 Oct 2023 16:06:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <cgroups@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <yosryahmed@google.com>,
	<mkoutny@suse.com>, <sinquersw@gmail.com>, <bpf@vger.kernel.org>, Yafang Shao
	<laoar.shao@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the
 cgroup root_list RCU safe
Message-ID: <202310251500.9683d034-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017124546.24608-2-laoar.shao@gmail.com>
X-ClientProxiedBy: KL1PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:820::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1601ff-4994-4bb2-3e5c-08dbd5315183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/HsFhKHu68zrz7NMckKZgh16L26+eqhZ/EisHXYy/ZbSRNKoxVx5sO+Jbp6CNcoFdTUuyv4mDFe4EarTa6aSqM14kA1n5H1RjYJ2bkTYAC5hzigx+1lXbdOPMgPRONkOzefuMhhZPyRniZqd1YrrR9w/CuDty9ADFxCPcldMlDY51Xd2UbkGcBY+XG1xKtOKaDlxeGVNEu5GRMBQgeinBXVdsMpDMLN5oOehjWXp0zRJo/c/uFfhFxPUcvOQO0Yw3No9wXu9QJ+WI/0qfC9Uvbj24uBWMxEzDde866kRErArF7teyuYNJcbUoHAQUk/QmFGwe1X2EGPz9qf/LAJV9dwlShvEpRcIw3EHjLHKfK7e1E9gsROstuPSPMBlZgknWdW4KZJFIdNPxox7sGJKgVziyjF4y8tG1Gdv2yYQpYoqM2CXiJvmkqFTlwTsoksvNCCUvp9WdxPza8FCmx5sLS+WKg9vTH/6wjgtWsFcMJwsWrAeyi5gKe0UNFkHHj0H6rNKr4U4B6YMKMDqmXTutQX/uApC7NYJb+aNGlUvqpxmIcDcZdP73WTEZrftyqzQnicxt21h24bw1TE00A6cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(2906002)(38100700002)(66476007)(6666004)(66946007)(66556008)(6916009)(478600001)(6506007)(966005)(6512007)(6486002)(83380400001)(86362001)(7416002)(36756003)(5660300002)(2616005)(82960400001)(107886003)(1076003)(8676002)(4326008)(8936002)(26005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Atv0NfPzJN3E+PmFmFRBqzHk08IuR72Bfge1b3zu7u/Gsr3dTF2p+6pmlqFr?=
 =?us-ascii?Q?GeQgqdReLK9qzshjCfITKKQlONp7w8QEClqj2pFC87c9YwX1bXBlyLZodrpV?=
 =?us-ascii?Q?FFQUqa8FNTxygi1/V7qImKvNoG2Ve2yHApsc7yLFL/FAgdrH01ogXYFvLIcc?=
 =?us-ascii?Q?/DF31rvLMaVeizsFf29syXfZ7K7hFrJwDYReVgRKcqEyvoXPhP2ua+kGblhD?=
 =?us-ascii?Q?YPDtK+hW/ilTf+KSol/i+T284x/x2QcWHM2HKomlUGFt7sDDQ6Gaw+CJwJEZ?=
 =?us-ascii?Q?PAPdVRWriJ2TqmOAt0+zm3xrKYgThLBlZ/WOZ6Ma7mkuBuOVBAbNXsovsyjL?=
 =?us-ascii?Q?NUv4HDDLcxbNV7e00dgMI7QjLFQi013YKh5QV0IYL2BKcWZQph9iBdJ0bHZF?=
 =?us-ascii?Q?h3VekxiQ1jzCpZ9Wyu0uG1GQb0yHfTObiqW1sHZBgdpqut0yWWMFGuCUorP/?=
 =?us-ascii?Q?bN8jAB3QjCJd9vmdRcezGTeBs88G/samFbirennVmrJs3zllkualXllB7HnA?=
 =?us-ascii?Q?X5imvCv31LJ8RyK3fsGEci6dzFeMNft9qPE5KPBnSe50USwhX5pz6CIK0Tzc?=
 =?us-ascii?Q?K9U0edLKS3q5/gx5hRwpwOehul96p6NkA6F1fxUC+taOOqPjwzLdV3CyDB8Y?=
 =?us-ascii?Q?Qc5slH8+tXBhylwwrJxg8+s65qYDr1FsGR7y0OpoEuvYdYJOIby9sW4H01yr?=
 =?us-ascii?Q?eaQI4omvZxs8VsqMpT19VD89hvPSTP/ykPsti50RybDsFnQlXxW2dAf1K8ts?=
 =?us-ascii?Q?Ay2dFJDssm6X+9oWl1EdcnOEYXquw51fiyKfiUoLbmQT8SGHuNk8gnJKi5Ld?=
 =?us-ascii?Q?ycY0lCYpvKt4JmuDkVEKy26UdT/3uS45SbLsTaBSH5/gP0z9ZGsF7L7vVnAo?=
 =?us-ascii?Q?lGTrKrknUeA5AwyP3Jq3MlRmgMz29YIYalwZtghQi6Fr+GJ9QHsPmIGAQi71?=
 =?us-ascii?Q?U0hu9vnHwwCjeL3VeW7klqUfjo2WT8aRuHpmgHQZ1K8qwa3QcNHGJFAIgLMR?=
 =?us-ascii?Q?Ls5znb2hU4JpUdmdIqkbZ0+eJHdXeEUpbn3aA/A60yhXn8Q4//hPFP49cPDK?=
 =?us-ascii?Q?S6mq54HyomAduKx7LkN6tRDV2psUcVudsRAG7rMShjKMMPGKSoEhJuDm9TH/?=
 =?us-ascii?Q?rol25S2k94K8E2WOCDT252eJSMFu0fQinX4+hRRnamd4d40WgqRsDYNUbUb7?=
 =?us-ascii?Q?HrSMFKRnfTEeAa30NlMEDPnpeif+c0KNIOYqvnmqYheMunfNXauIk4DrEnSf?=
 =?us-ascii?Q?yaewCPFyv96LNOyBTSw1t3Vh8PgGIAJxB9zJYc7C7VRhaeArTujm8vigNtLk?=
 =?us-ascii?Q?NnRRaby01/r2syJPNqJ/1a5Wiz/3oAE5GMAwTxCr1w/eX0aGv4BQ7ppyvHrz?=
 =?us-ascii?Q?5h/WP9a4gj69FQ4V6Qg4oGTzTOW1Disijk7Actx/3EUKKecJDTmyfoJPmw6Y?=
 =?us-ascii?Q?mTrNTL7CBRvIeDlQhphUZmNZ4zsMIMWSVoA2YNnT00szN9lMSqhNXliKyGWW?=
 =?us-ascii?Q?rrbVNs/7C/3JbpELTSlgEhtM/EC8e4xbuZUPBbt4yUG65W6nuvGIT3h4zxl7?=
 =?us-ascii?Q?yoTD8vshHTGqrph4zf+baRwzNgXS6dlVvPYB7mRTCGcxy5vBn1cb8xGUvv3D?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1601ff-4994-4bb2-3e5c-08dbd5315183
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:06:40.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttf54hvYCA4xl/1qOGNwbhlj0IRjmQt9LayZr65tsCzS9zi5BeJSm7yelhxxBxA9VnypP81lRKbS+fDIWl0cpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8091
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: bf652e038501425f21e30c78c210ce892b9747c5 ("[RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the cgroup root_list RCU safe")
url: https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/cgroup-Make-operations-on-the-cgroup-root_list-RCU-safe/20231017-204729
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
patch link: https://lore.kernel.org/all/20231017124546.24608-2-laoar.shao@gmail.com/
patch subject: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the cgroup root_list RCU safe

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------+------------+------------+
|                                                                  | 137df1189d | bf652e0385 |
+------------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                     | 0          | 6          |
| kernel/cgroup/cgroup#c:#RCU-list_traversed_in_non-reader_section | 0          | 6          |
+------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310251500.9683d034-oliver.sang@intel.com


[  245.792697][    T1] WARNING: suspicious RCU usage
[  245.793945][    T1] 6.6.0-rc5-01395-gbf652e038501 #1 Not tainted
[  245.795294][    T1] -----------------------------
[  245.796458][    T1] kernel/cgroup/cgroup-v1.c:1171 RCU-list traversed in non-reader section!!
[  245.798005][    T1]
[  245.798005][    T1] other info that might help us debug this:
[  245.798005][    T1]
[  245.800905][    T1]
[  245.800905][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  245.815563][    T1] 1 lock held by init/1:
[ 245.816666][ T1] #0: c3bfffb8 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock_and_drain_offline (kernel/cgroup/cgroup.c:3066) 
[  245.818306][    T1]
[  245.818306][    T1] stack backtrace:
[  245.820360][    T1] CPU: 0 PID: 1 Comm: init Not tainted 6.6.0-rc5-01395-gbf652e038501 #1
[  245.821860][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  245.823506][    T1] Call Trace:
[ 245.824459][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 245.825654][ T1] dump_stack (lib/dump_stack.c:114) 
[ 245.826665][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6712) 
[ 245.827845][ T1] cgroup1_root_to_use (kernel/cgroup/cgroup-v1.c:1171 (discriminator 9)) 
[ 245.828999][ T1] cgroup1_get_tree (kernel/cgroup/cgroup-v1.c:1245) 
[ 245.830101][ T1] vfs_get_tree (fs/super.c:1750) 
[ 245.831172][ T1] do_new_mount (fs/namespace.c:3335) 
[ 245.832199][ T1] path_mount (fs/namespace.c:3662) 
[ 245.833147][ T1] ? user_path_at_empty (fs/namei.c:2914) 
[ 245.834198][ T1] __ia32_sys_mount (fs/namespace.c:3675 fs/namespace.c:3884 fs/namespace.c:3861 fs/namespace.c:3861) 
[ 245.835242][ T1] do_int80_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:132) 
[ 245.836343][ T1] ? kfree (mm/slab_common.c:1073) 
[ 245.837335][ T1] ? __ia32_sys_mount (fs/namespace.c:3861) 
[ 245.838404][ T1] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 245.839479][ T1] ? syscall_exit_to_user_mode (kernel/entry/common.c:131 kernel/entry/common.c:298) 
[ 245.840593][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4565) 
[ 245.841824][ T1] ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
[ 245.842967][ T1] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 245.843964][ T1] ? __ia32_sys_mount (fs/namespace.c:3861) 
[ 245.844935][ T1] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 245.845958][ T1] ? syscall_exit_to_user_mode (kernel/entry/common.c:131 kernel/entry/common.c:298) 
[ 245.847004][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4565) 
[ 245.848103][ T1] ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
[ 245.849159][ T1] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 245.850163][ T1] ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
[ 245.851209][ T1] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 245.852179][ T1] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5775) 
[ 245.853126][ T1] ? irqentry_exit (kernel/entry/common.c:445) 
[ 245.858431][ T1] ? irqentry_exit_to_user_mode (kernel/entry/common.c:131 kernel/entry/common.c:311) 
[ 245.859731][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4565) 
[ 245.860985][ T1] ? irqentry_exit_to_user_mode (kernel/entry/common.c:312) 
[ 245.862110][ T1] ? irqentry_exit (kernel/entry/common.c:445) 
[ 245.863099][ T1] ? exc_page_fault (arch/x86/mm/fault.c:1565) 
[ 245.864073][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  245.865070][    T1] EIP: 0xb7f895ed
[ 245.865966][ T1] Code: 8b 7c 24 0c 50 e8 06 00 00 00 89 da 5b 5b 5f c3 8b 04 24 05 77 ec 04 00 8b 00 85 c0 74 06 50 8b 44 24 08 c3 8b 44 24 04 cd 80 <c3> 55 50 8b 6c 24 0c 8b 45 00 8b 6d 04 50 8b 44 24 04 e8 b9 ff ff
All code
========
   0:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
   4:	50                   	push   %rax
   5:	e8 06 00 00 00       	call   0x10
   a:	89 da                	mov    %ebx,%edx
   c:	5b                   	pop    %rbx
   d:	5b                   	pop    %rbx
   e:	5f                   	pop    %rdi
   f:	c3                   	ret
  10:	8b 04 24             	mov    (%rsp),%eax
  13:	05 77 ec 04 00       	add    $0x4ec77,%eax
  18:	8b 00                	mov    (%rax),%eax
  1a:	85 c0                	test   %eax,%eax
  1c:	74 06                	je     0x24
  1e:	50                   	push   %rax
  1f:	8b 44 24 08          	mov    0x8(%rsp),%eax
  23:	c3                   	ret
  24:	8b 44 24 04          	mov    0x4(%rsp),%eax
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	55                   	push   %rbp
  2c:	50                   	push   %rax
  2d:	8b 6c 24 0c          	mov    0xc(%rsp),%ebp
  31:	8b 45 00             	mov    0x0(%rbp),%eax
  34:	8b 6d 04             	mov    0x4(%rbp),%ebp
  37:	50                   	push   %rax
  38:	8b 44 24 04          	mov    0x4(%rsp),%eax
  3c:	e8                   	.byte 0xe8
  3d:	b9                   	.byte 0xb9
  3e:	ff                   	(bad)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	55                   	push   %rbp
   2:	50                   	push   %rax
   3:	8b 6c 24 0c          	mov    0xc(%rsp),%ebp
   7:	8b 45 00             	mov    0x0(%rbp),%eax
   a:	8b 6d 04             	mov    0x4(%rbp),%ebp
   d:	50                   	push   %rax
   e:	8b 44 24 04          	mov    0x4(%rsp),%eax
  12:	e8                   	.byte 0xe8
  13:	b9                   	.byte 0xb9
  14:	ff                   	(bad)
  15:	ff                   	.byte 0xff
[  245.868936][    T1] EAX: ffffffda EBX: 0804a431 ECX: 0804a429 EDX: 0804a431
[  245.870279][    T1] ESI: 0000000e EDI: 00000000 EBP: bffa7bd8 ESP: bffa7bb8
[  245.871623][    T1] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[  245.935209][    T1] init: Console is alive



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231025/202310251500.9683d034-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


