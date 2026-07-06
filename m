Return-Path: <cgroups+bounces-17541-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V0KnGobcS2pdbgEAu9opvQ
	(envelope-from <cgroups+bounces-17541-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 18:49:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CDC7137F0
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 18:49:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YlNn7q+h;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17541-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17541-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2DF3305B2AA
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF4414A18;
	Mon,  6 Jul 2026 16:24:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9B36C597
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 16:24:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355087; cv=fail; b=gvTXexXF3cUVwS0O1st+0SqVElTr4AHg1JXPYvoQOmVPag1wNwhW3PABMietSctJt1LYvHCav+mpGHTsjWAZonKkU+z2N9vIPVnIh+DQk0JNwZBzL3S1x11a5abuHqdiv7vTyWX1S878ys+7KCtuNtoq8OC7twv7el4ks9yJnXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355087; c=relaxed/simple;
	bh=KO5t+vw1fAxMXbUoanLtvlXZnpwroeI/M4O+6C7w8+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b0TzBJNzbcFYnuuGQZqsLdO64GV1kNN0+F7QT//E7iYEYKG8IpcC7Tnvk4K3a5SOcpxhMWozvrX4kXrzrrLve5TgFwPIjeAo1S+D+49Fc27wln2Zmb++kZUa/sceJPNeIJV3b9gzWKqzjATxeRIykyOkFNk255rrzFo09PsMEDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlNn7q+h; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783355085; x=1814891085;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KO5t+vw1fAxMXbUoanLtvlXZnpwroeI/M4O+6C7w8+o=;
  b=YlNn7q+hdppmo4SA4QUAeuO8MGJKWKz+dywM7DllGikeLq/WrxtmiRzZ
   Dkbf0/R/xnGCHoBgp7353du+vROF5ncRINDWs0cErrpWrRNRNbk96Sm6R
   WbMV9EpKsOPLGdBfbwuz7xuxPzknbRTD9NH9Ld8m9MlY6iaw5GPhnRWEb
   OGpKD/NW+XhYlT23exi5UszkD6L559PG6LTuWcLUkDO2CDK1VX1A2N2GY
   BaB5JXcSROfGtIoKf0N0y4b73+W4dYbKS9YhZfRvp4RVTNhcu/E6w7HAi
   1JzPvU6F0Sn+8F3yAPxnrjxtaQNynJymYfNYbci42cdsKI71okmmcKAs6
   Q==;
X-CSE-ConnectionGUID: wx79w2GoRYGz2YlYz2ZkDQ==
X-CSE-MsgGUID: QUUD5OVLRcCp5oDtRqphvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="94352430"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="94352430"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:24:38 -0700
X-CSE-ConnectionGUID: Z30JRJdwQo2jPy15hOOH3g==
X-CSE-MsgGUID: 41zkxBClR3a5KlFiumRA6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="249312161"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:24:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 09:24:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 09:24:37 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 09:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du7gVqlIUNy4503XxpNsOgeXQ6t3GXi6I0jBk3Iwpf3wUo5M/5zOgutuxSF1fsdIia7iNp85w261AZMfjVPIVrX5TFkCREMQjGbZ60eLsgRcZ1Zv2WAoKaoMStX1N6fvULidJmnR8hOyzDFjEd/8KVTNWHQcvHabxnktuPMzhZfJFOrcQMgmXlITpxzpL/4sNCRdhJ6A4Nhru0q5jYB/wTEQ0RdrqC4kY3uTG2ioIu02b5MXJj0FB4nwfbTBX4AhvpHMxwx5IqfLnBXzXKwzFYddIaE6uLRlKTuCNPZK7N2PQ5oXvUZ43ElPtKCqwV3RJRZxFvQcuXe5vl+smgv3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTcSSGoKX+Ldvjl5i5euMMcR5wDmlYtA0YCbQpZs8oU=;
 b=mrPWRipx674qJeGgqSPgmZOTOhogQ5QTzFWolZILwL+75qpIat4l+6tRuSN0LpYg0P4NVwPe9UXX7zAqn2V/XQEUQG8VFXB7fGqScjuGSM34kYgiw8538Iqz7qIfclPoVAcgUj8n3ca0Lmq4qCzbl3v/A36PTkwKO2hEWLN0VL2aA/KOot30nXS0hqeuO8MUpRSVyperWH6pyaX1JPdABbX9dz7+H1CLXSUfA1dS00xVyo7PwJ1nOdiK4CqHUz7wjYQHAKrdWRqR8oQXuqpgkyPieZ3wzW3w8APfOanPkBStmFNSppq0gRLQIWqORgQdMoTmaH2yh1jLZUxuw35g4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8343.namprd11.prod.outlook.com (2603:10b6:610:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 16:24:34 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 16:24:33 +0000
Date: Mon, 6 Jul 2026 09:24:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <tj@kernel.org>,
	<christian.koenig@amd.com>, Johannes Weiner <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	"Shakeel Butt" <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, Thomas Hellstrom
	<thomas.hellstrom@linux.intel.com>, Waiman Long <longman@redhat.com>,
	<simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 02/10] ttm: add a memcg accounting flag to the
 alloc/populate APIs
Message-ID: <akvWvjFi/v2MY8do@gsse-cloud1.jf.intel.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-3-airlied@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260706052330.1110909-3-airlied@gmail.com>
X-ClientProxiedBy: MW4PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:303:b5::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: a1097084-0b96-4f96-4079-08dedb7b1027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|11063799006|4143699003|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: EAJGuw8gkVdKsq603QsHRSIkNmhp90nUKhsGKvblA6IZhGBVZqdBhvIQOmeWiB4AqsxVDuCUqsDg1NyoxKkuKwbP4FpnOujNL8+4TKiVDpQVxzjjKmWu1+Qt98OEJB3MXn3jIieP4PV5fkd37TMLo0xAzOyHYKGnrlr8PsdFjz7zj+YF2Kko/POYc+mGgwt6ViXEWaFJteBWehaTqAw10ozlsq9J1enUDECwF7g51guMMuVFQ4D6qrVtLz9xnKXb7b0NBpGLKrQRAzNp7QHbA69p8RvlIMHqYAQL7zAFr5ls99nYQ4VNuR7Ld5ZElvdv3I4JGRr14PO1MacMExme84d20ecnpGuMiLP2zjFaGX8CWGLqrns72oqVT04Tga7Vb4nV6q4SAKpk1L3H4c+MxMB3ru6q2uBLDnJBSga1z/nLyN7N0WZC9TOgmEVFEQqJklVM9eotdkshlMZCH2iLQ2o1KC9jTFt9MKwq7IR99Syn8F9Se4PIZp2KdqcxjTZgakeIWOZQ77nC9rvwiQJWRvsOjn+oGn0A0GdYELOJcnv8fJd4JT7y2MuiA3K9jdPXm/zDC2ZRQjMTqSf+yW/ZRpEJn6J7TzWv2yE8dg0TTMkCmk1iUCEmbdcaw3eRBAev5vNJD3qBmDpRis2hOTeOi3cYTfmkerw9SA/0ZMenN1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VanDZ2mybtJ7ClR/EtsQRJtCmTEilR69pF+Up1k6EhAP7sUWra521tBprEiH?=
 =?us-ascii?Q?Y7BkYVO7PUMQcxec0RNYK6/nRBsi+8sFSWCUqzjhuzpV54iQ9yq4K8aJMSJJ?=
 =?us-ascii?Q?AG8/Ka6EjQ4lNkP7ezfuENQdj4PZvKoMb83dYYrGalDc4wIWnkv6/KgVF/Xa?=
 =?us-ascii?Q?2tJDAS1OxiXuoMcaf77RU10fh7tuEN8EBfRxLpllaXqGKAIma9VAZ1lLic8U?=
 =?us-ascii?Q?aofE2FlQJ/g78bfES2svxkrKhDW6ClB4WeWko6jWyArhKnX1djfMnjTmFsoJ?=
 =?us-ascii?Q?1FqeGsvq4l1LgBAjVcEe/mK4MlQB6Uj5kUNPBNXj1b8I8O362mTiodyyDk3U?=
 =?us-ascii?Q?V0YyudytJLZCw0CMIWpxv9M89YoZ2WmCrVeScrk6xRxZwuManVDVRx1RHPHE?=
 =?us-ascii?Q?6iXgOQQ6FNEV+lj3IVeaoQjCen2jBvhSeKnDbZkqRIanSsQ1llkv3YSUbqJs?=
 =?us-ascii?Q?nJfahyu//QDuzGaIS7vu2liduJfC4bwRQcI4k/9BW1t2vbPAkR9ZzNt5uiTr?=
 =?us-ascii?Q?73WhzSLwzFT0NvKiY6aCOmCtYhLC0eDARlduZe5fWQgx6YZ7wUEdiV9S8qfg?=
 =?us-ascii?Q?ogyIrcaTEXgt28waTw3bM+rjcH/3hM2UA3lsK5aSWXCkhtxzMz9DRHi4P021?=
 =?us-ascii?Q?akv1hg29fbCVjWJTEIQcgmBG+uBuR53G6+9lUSR7qhjeoS3JEod90zNdwMTH?=
 =?us-ascii?Q?35QOcp6tkyeliilEMLk/XAqrgL2dd/6zquTQIFN8arnwyhFdWyVwS0H6+Ek9?=
 =?us-ascii?Q?BtDe9rVT9K6Gde2yie7IoQAbq/1DvYjCM8xwb73V0zJCE0GXxqpMw7vsgQiu?=
 =?us-ascii?Q?lNYTmJoaG2av20JQj4lukHouIlaH6ne6g0LMVJn7Bog6eUvyxtDmAZd9iwxn?=
 =?us-ascii?Q?8RL+2AHw1fOUGxL0pGyC+FRVrB5ux4Qd7PD0vFDQm57XpiPvXgcKBmIcLgp/?=
 =?us-ascii?Q?NpLSSPNubOKV0jMneJxgnh4es0Sl1Jk0NOkP2+QuJz8EoWX0QG54IJc6dx6F?=
 =?us-ascii?Q?KmFBB1AjqhIfUHI59GGJX2/I5vLLPT2ynP01QlbCg9gl0nc5phECguSNe1nf?=
 =?us-ascii?Q?22gf4ZWcZOqyzKn9txarjGlj/AbR0EJgQLCiuCF/kr1+06O8V81U0B67/F+V?=
 =?us-ascii?Q?Ocgwmhmlcf5oeScvV7YQjbTlaeYMh2ISsf6kpaoGbHKepfplfGP4ITLmJLAL?=
 =?us-ascii?Q?ZBj0lFUvvFd5PedWCn/ThcmRjhYi93azoLuU+dMoofW6fL+bEv/7ZcRPKqs0?=
 =?us-ascii?Q?EHyyQzL1hCZUiNu3C0g95AZ85Bl0QOSRQ0U680K3p5xQElPDMApqP8cMOTnQ?=
 =?us-ascii?Q?sdsYdu4ftES7kpAhaj4/CMSNSTHFOuRSO6lyT/lgECNAq7GU23Sja/TUG54T?=
 =?us-ascii?Q?HZ+dhoLfaz0Cdv6h95AHnr18eC/Krfu3e/6eTEvvOBr+2FfmauCDQcTWlmrX?=
 =?us-ascii?Q?Fa4dsYEz5XczJikDDqZSwKkZPh9svg4rpkCcOiR8TbPfuUvIBzda1oLlllQB?=
 =?us-ascii?Q?WYfForZPKmba3EgtsixtoZlm3YzPsQlnYMXoiViDYT5Ebm3YJnSksIZT/ZS9?=
 =?us-ascii?Q?wUP0+VcMlxwP47k09GReB44pIeMPY+I7BDV4B16NlOcKNpi0ScwAknPG/CJd?=
 =?us-ascii?Q?sqLQDNTf49wxAvBNIUFtCD/kqIEejQ1ijpsc2mSqfHQN/I34wJMktD5uRMXg?=
 =?us-ascii?Q?CeqYIrQg6UbG7UUb8Zwa+ECkxpMOQ/6+RFbFH0q68dfhobsuR/MplIigci74?=
 =?us-ascii?Q?+ohaZfip9w=3D=3D?=
X-Exchange-RoutingPolicyChecked: dcLDcapEGz+LM+3/1FMQI0fe4KhFIKuYVCZ3Mkng0mI3iBLZtzmgYx5xB18RQvoSwEU348CDgDfgkPX8BmHJh5rpFbH/asTgpv0VDaWs3z1LpS1AAnlTPxA6nAG0Xuy5SlWleJtSGJCFmfOaAyo4myolxnDNWSBLm653NddvZNTD3NnoW+SgjNGDlzVk9h8smiBQhX4ZQDEEADD4nuGjlhKXDHZBklwmr3TVRXyPA6Ovb7+fxXONlDB+zrjMBMeZszhndNx0NynScoD8OLuLPj4WlQMJLqV0BygVhkIICkK3RF1yiiXgqUMH4O2MEPDGF5uF720pTk9x8vmTT7sbxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1097084-0b96-4f96-4079-08dedb7b1027
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:24:33.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX8628GeDrHcW10HGzrMY87ikEP007wKgqAIpXPf1YjBHaifeqI+4/wO2+/FhabxYrXQJpSDTZgRmYhkyYebGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8343
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17541-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[matthew.brost@intel.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gsse-cloud1.jf.intel.com:mid,intel.com:from_mime,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71CDC7137F0

On Mon, Jul 06, 2026 at 03:22:31PM +1000, Dave Airlie wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> This flag does nothing yet, but this just changes the APIs to accept
> it in the future across all users.
> 
> This flag will eventually be filled out with when to account a tt
> populate to a memcg.
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  3 ++-
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c          |  5 +++--
>  drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c     |  2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c       |  4 ++--
>  drivers/gpu/drm/loongson/lsdc_ttm.c              |  3 ++-
>  drivers/gpu/drm/nouveau/nouveau_bo.c             |  6 ++++--
>  drivers/gpu/drm/radeon/radeon_ttm.c              |  3 ++-
>  drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |  2 +-
>  drivers/gpu/drm/ttm/tests/ttm_pool_test.c        | 16 ++++++++--------
>  drivers/gpu/drm/ttm/tests/ttm_tt_test.c          | 12 ++++++------
>  drivers/gpu/drm/ttm/ttm_bo.c                     |  7 ++++---
>  drivers/gpu/drm/ttm/ttm_bo_util.c                |  6 +++---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c                  |  4 +++-
>  drivers/gpu/drm/ttm/ttm_pool.c                   |  6 ++++--
>  drivers/gpu/drm/ttm/ttm_tt.c                     |  8 +++++---
>  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c             |  4 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c       |  7 ++++---
>  drivers/gpu/drm/xe/xe_bo.c                       |  5 +++--
>  include/drm/ttm/ttm_bo.h                         |  1 +
>  include/drm/ttm/ttm_device.h                     |  1 +
>  include/drm/ttm/ttm_pool.h                       |  1 +
>  include/drm/ttm/ttm_tt.h                         |  1 +
>  22 files changed, 63 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 025625e7e800..8062b3d61157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1220,6 +1220,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
>   */
>  static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
>  				  struct ttm_tt *ttm,
> +				  bool memcg_account,
>  				  struct ttm_operation_ctx *ctx)

Would it be better to add a field to the ttm_operation_ctx for
memcg_account? Might be a little goofy if TTM internals toggle a field
in ttm_operation_ctx but IMO better than adding bool argument
everywhere.

Matt

>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
> @@ -1243,7 +1244,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
>  		pool = &adev->mman.ttm_pools[gtt->pool_id];
>  	else
>  		pool = &adev->mman.bdev.pool;
> -	ret = ttm_pool_alloc(pool, ttm, ctx);
> +	ret = ttm_pool_alloc(pool, ttm, memcg_account, ctx);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index df3fcc2b1248..d45ccede78a4 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -317,6 +317,7 @@ static struct ttm_tt *i915_ttm_tt_create(struct ttm_buffer_object *bo,
>  
>  static int i915_ttm_tt_populate(struct ttm_device *bdev,
>  				struct ttm_tt *ttm,
> +				bool memcg_account,
>  				struct ttm_operation_ctx *ctx)
>  {
>  	struct i915_ttm_tt *i915_tt = container_of(ttm, typeof(*i915_tt), ttm);
> @@ -324,7 +325,7 @@ static int i915_ttm_tt_populate(struct ttm_device *bdev,
>  	if (i915_tt->is_shmem)
>  		return i915_ttm_tt_shmem_populate(bdev, ttm, ctx);
>  
> -	return ttm_pool_alloc(&bdev->pool, ttm, ctx);
> +	return ttm_pool_alloc(&bdev->pool, ttm, memcg_account, ctx);
>  }
>  
>  static void i915_ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
> @@ -815,7 +816,7 @@ static int __i915_ttm_get_pages(struct drm_i915_gem_object *obj,
>  	}
>  
>  	if (bo->ttm && !ttm_tt_is_populated(bo->ttm)) {
> -		ret = ttm_bo_populate(bo, &ctx);
> +		ret = ttm_bo_populate(bo, false, &ctx);
>  		if (ret)
>  			return ret;
>  
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> index 56489cc127d6..b81c9df2d7eb 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> @@ -624,7 +624,7 @@ int i915_ttm_move(struct ttm_buffer_object *bo, bool evict,
>  
>  	/* Populate ttm with pages if needed. Typically system memory. */
>  	if (ttm && (dst_man->use_tt || (ttm->page_flags & TTM_TT_FLAG_SWAPPED))) {
> -		ret = ttm_bo_populate(bo, ctx);
> +		ret = ttm_bo_populate(bo, false, ctx);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
> index 4824f948daed..d951e58f78ea 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
> @@ -91,7 +91,7 @@ static int i915_ttm_backup(struct i915_gem_apply_to_region *apply,
>  		goto out_no_lock;
>  
>  	backup_bo = i915_gem_to_ttm(backup);
> -	err = ttm_bo_populate(backup_bo, &ctx);
> +	err = ttm_bo_populate(backup_bo, false, &ctx);
>  	if (err)
>  		goto out_no_populate;
>  
> @@ -190,7 +190,7 @@ static int i915_ttm_restore(struct i915_gem_apply_to_region *apply,
>  	if (!backup_bo->resource)
>  		err = ttm_bo_validate(backup_bo, i915_ttm_sys_placement(), &ctx);
>  	if (!err)
> -		err = ttm_bo_populate(backup_bo, &ctx);
> +		err = ttm_bo_populate(backup_bo, false, &ctx);
>  	if (!err) {
>  		err = i915_gem_obj_copy_ttm(obj, backup, pm_apply->allow_gpu,
>  					    false);
> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongson/lsdc_ttm.c
> index d7441d96a0dc..bfb5f1b1ec91 100644
> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
> @@ -111,6 +111,7 @@ lsdc_ttm_tt_create(struct ttm_buffer_object *tbo, uint32_t page_flags)
>  
>  static int lsdc_ttm_tt_populate(struct ttm_device *bdev,
>  				struct ttm_tt *ttm,
> +				bool memcg_account,
>  				struct ttm_operation_ctx *ctx)
>  {
>  	bool slave = !!(ttm->page_flags & TTM_TT_FLAG_EXTERNAL);
> @@ -123,7 +124,7 @@ static int lsdc_ttm_tt_populate(struct ttm_device *bdev,
>  		return 0;
>  	}
>  
> -	return ttm_pool_alloc(&bdev->pool, ttm, ctx);
> +	return ttm_pool_alloc(&bdev->pool, ttm, memcg_account, ctx);
>  }
>  
>  static void lsdc_ttm_tt_unpopulate(struct ttm_device *bdev,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 0e8de6d4b36f..a38c19f1d6dc 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -1417,7 +1417,9 @@ vm_fault_t nouveau_ttm_fault_reserve_notify(struct ttm_buffer_object *bo)
>  
>  static int
>  nouveau_ttm_tt_populate(struct ttm_device *bdev,
> -			struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
> +			struct ttm_tt *ttm,
> +			bool memcg_account,
> +			struct ttm_operation_ctx *ctx)
>  {
>  	struct ttm_tt *ttm_dma = (void *)ttm;
>  	struct nouveau_drm *drm;
> @@ -1434,7 +1436,7 @@ nouveau_ttm_tt_populate(struct ttm_device *bdev,
>  
>  	drm = nouveau_bdev(bdev);
>  
> -	return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, ctx);
> +	return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, memcg_account, ctx);
>  }
>  
>  static void
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index e7ab8162ac69..98b09463abc2 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -526,6 +526,7 @@ static struct radeon_ttm_tt *radeon_ttm_tt_to_gtt(struct radeon_device *rdev,
>  
>  static int radeon_ttm_tt_populate(struct ttm_device *bdev,
>  				  struct ttm_tt *ttm,
> +				  bool memcg_account,
>  				  struct ttm_operation_ctx *ctx)
>  {
>  	struct radeon_device *rdev = radeon_get_rdev(bdev);
> @@ -547,7 +548,7 @@ static int radeon_ttm_tt_populate(struct ttm_device *bdev,
>  		return 0;
>  	}
>  
> -	return ttm_pool_alloc(&rdev->mman.bdev.pool, ttm, ctx);
> +	return ttm_pool_alloc(&rdev->mman.bdev.pool, ttm, memcg_account, ctx);
>  }
>  
>  static void radeon_ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> index 2db221f6fc3a..0cbf732eebf3 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -538,7 +538,7 @@ static void ttm_bo_validate_no_placement_signaled(struct kunit *test)
>  
>  	if (params->with_ttm) {
>  		old_tt = priv->ttm_dev->funcs->ttm_tt_create(bo, 0);
> -		ttm_pool_alloc(&priv->ttm_dev->pool, old_tt, &ctx);
> +		ttm_pool_alloc(&priv->ttm_dev->pool, old_tt, false, &ctx);
>  		bo->ttm = old_tt;
>  	}
>  
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> index be75c8abf388..af235d64b970 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> @@ -89,7 +89,7 @@ static struct ttm_pool *ttm_pool_pre_populated(struct kunit *test,
>  
>  	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
>  
> -	err = ttm_pool_alloc(pool, tt, &simple_ctx);
> +	err = ttm_pool_alloc(pool, tt, false, &simple_ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	ttm_pool_free(pool, tt);
> @@ -157,7 +157,7 @@ static void ttm_pool_alloc_basic(struct kunit *test)
>  	KUNIT_ASSERT_EQ(test, pool->nid, NUMA_NO_NODE);
>  	KUNIT_ASSERT_EQ(test, pool->alloc_flags, params->alloc_flags);
>  
> -	err = ttm_pool_alloc(pool, tt, &simple_ctx);
> +	err = ttm_pool_alloc(pool, tt, false, &simple_ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	KUNIT_ASSERT_EQ(test, tt->num_pages, expected_num_pages);
>  
> @@ -220,7 +220,7 @@ static void ttm_pool_alloc_basic_dma_addr(struct kunit *test)
>  
>  	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
>  
> -	err = ttm_pool_alloc(pool, tt, &simple_ctx);
> +	err = ttm_pool_alloc(pool, tt, false, &simple_ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	KUNIT_ASSERT_EQ(test, tt->num_pages, expected_num_pages);
>  
> @@ -253,7 +253,7 @@ static void ttm_pool_alloc_order_caching_match(struct kunit *test)
>  	tt = ttm_tt_kunit_init(test, 0, caching, size);
>  	KUNIT_ASSERT_NOT_NULL(test, tt);
>  
> -	err = ttm_pool_alloc(pool, tt, &simple_ctx);
> +	err = ttm_pool_alloc(pool, tt, false, &simple_ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt->pages));
> @@ -285,7 +285,7 @@ static void ttm_pool_alloc_caching_mismatch(struct kunit *test)
>  	KUNIT_ASSERT_FALSE(test, !list_lru_count(&pt_pool->pages));
>  	KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt_tt->pages));
>  
> -	err = ttm_pool_alloc(pool, tt, &simple_ctx);
> +	err = ttm_pool_alloc(pool, tt, false, &simple_ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	ttm_pool_free(pool, tt);
> @@ -319,7 +319,7 @@ static void ttm_pool_alloc_order_mismatch(struct kunit *test)
>  	KUNIT_ASSERT_FALSE(test, !list_lru_count(&pt_pool->pages));
>  	KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt_tt->pages));
>  
> -	err = ttm_pool_alloc(pool, tt, &simple_ctx);
> +	err = ttm_pool_alloc(pool, tt, false, &simple_ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	ttm_pool_free(pool, tt);
> @@ -349,7 +349,7 @@ static void ttm_pool_free_dma_alloc(struct kunit *test)
>  	KUNIT_ASSERT_NOT_NULL(test, pool);
>  
>  	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DMA_ALLOC);
> -	ttm_pool_alloc(pool, tt, &simple_ctx);
> +	ttm_pool_alloc(pool, tt, false, &simple_ctx);
>  
>  	pt = &pool->caching[caching].orders[order];
>  	KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt->pages));
> @@ -379,7 +379,7 @@ static void ttm_pool_free_no_dma_alloc(struct kunit *test)
>  	KUNIT_ASSERT_NOT_NULL(test, pool);
>  
>  	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, 0);
> -	ttm_pool_alloc(pool, tt, &simple_ctx);
> +	ttm_pool_alloc(pool, tt, false, &simple_ctx);
>  
>  	ttm_pool_free(pool, tt);
>  	ttm_tt_fini(tt);
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> index bd5f7d0b9b62..dfa38bbfd829 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
> @@ -262,7 +262,7 @@ static void ttm_tt_populate_null_ttm(struct kunit *test)
>  	struct ttm_operation_ctx ctx = { };
>  	int err;
>  
> -	err = ttm_tt_populate(devs->ttm_dev, NULL, &ctx);
> +	err = ttm_tt_populate(devs->ttm_dev, NULL, false, &ctx);
>  	KUNIT_ASSERT_EQ(test, err, -EINVAL);
>  }
>  
> @@ -283,11 +283,11 @@ static void ttm_tt_populate_populated_ttm(struct kunit *test)
>  	err = ttm_tt_init(tt, bo, 0, ttm_cached, 0);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
> -	err = ttm_tt_populate(devs->ttm_dev, tt, &ctx);
> +	err = ttm_tt_populate(devs->ttm_dev, tt, false, &ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	populated_page = *tt->pages;
>  
> -	err = ttm_tt_populate(devs->ttm_dev, tt, &ctx);
> +	err = ttm_tt_populate(devs->ttm_dev, tt, false, &ctx);
>  	KUNIT_ASSERT_PTR_EQ(test, populated_page, *tt->pages);
>  }
>  
> @@ -307,7 +307,7 @@ static void ttm_tt_unpopulate_basic(struct kunit *test)
>  	err = ttm_tt_init(tt, bo, 0, ttm_cached, 0);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
> -	err = ttm_tt_populate(devs->ttm_dev, tt, &ctx);
> +	err = ttm_tt_populate(devs->ttm_dev, tt, false, &ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	KUNIT_ASSERT_TRUE(test, ttm_tt_is_populated(tt));
>  
> @@ -351,7 +351,7 @@ static void ttm_tt_swapin_basic(struct kunit *test)
>  	err = ttm_tt_init(tt, bo, 0, ttm_cached, 0);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
> -	err = ttm_tt_populate(devs->ttm_dev, tt, &ctx);
> +	err = ttm_tt_populate(devs->ttm_dev, tt, false, &ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	KUNIT_ASSERT_TRUE(test, ttm_tt_is_populated(tt));
>  
> @@ -361,7 +361,7 @@ static void ttm_tt_swapin_basic(struct kunit *test)
>  	KUNIT_ASSERT_TRUE(test, tt->page_flags & TTM_TT_FLAG_SWAPPED);
>  
>  	/* Swapout depopulates TT, allocate pages and then swap them in */
> -	err = ttm_pool_alloc(&devs->ttm_dev->pool, tt, &ctx);
> +	err = ttm_pool_alloc(&devs->ttm_dev->pool, tt, false, &ctx);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	err = ttm_tt_swapin(tt);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bcd76f6bb7f0..cf4ab2b5521a 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -145,7 +145,7 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>  			goto out_err;
>  
>  		if (mem->mem_type != TTM_PL_SYSTEM) {
> -			ret = ttm_bo_populate(bo, ctx);
> +			ret = ttm_bo_populate(bo, false, ctx);
>  			if (ret)
>  				goto out_err;
>  		}
> @@ -1255,6 +1255,7 @@ void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)
>   * is set to true.
>   */
>  int ttm_bo_populate(struct ttm_buffer_object *bo,
> +		    bool memcg_account,
>  		    struct ttm_operation_ctx *ctx)
>  {
>  	struct ttm_device *bdev = bo->bdev;
> @@ -1268,7 +1269,7 @@ int ttm_bo_populate(struct ttm_buffer_object *bo,
>  		return 0;
>  
>  	swapped = ttm_tt_is_swapped(tt);
> -	ret = ttm_tt_populate(bdev, tt, ctx);
> +	ret = ttm_tt_populate(bdev, tt, memcg_account, ctx);
>  	if (ret)
>  		return ret;
>  
> @@ -1293,7 +1294,7 @@ int ttm_bo_setup_export(struct ttm_buffer_object *bo,
>  	if (ret != 0)
>  		return ret;
>  
> -	ret = ttm_bo_populate(bo, ctx);
> +	ret = ttm_bo_populate(bo, false, ctx);
>  	ttm_bo_unreserve(bo);
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 3e3c201a0222..62dad6c05dff 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -167,7 +167,7 @@ int ttm_bo_move_memcpy(struct ttm_buffer_object *bo,
>  	src_man = ttm_manager_type(bdev, src_mem->mem_type);
>  	if (ttm && ((ttm->page_flags & TTM_TT_FLAG_SWAPPED) ||
>  		    dst_man->use_tt)) {
> -		ret = ttm_bo_populate(bo, ctx);
> +		ret = ttm_bo_populate(bo, false, ctx);
>  		if (ret)
>  			return ret;
>  	}
> @@ -352,7 +352,7 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
>  
>  	BUG_ON(!ttm);
>  
> -	ret = ttm_bo_populate(bo, &ctx);
> +	ret = ttm_bo_populate(bo, false, &ctx);
>  	if (ret)
>  		return ret;
>  
> @@ -533,7 +533,7 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
>  		pgprot_t prot;
>  		void *vaddr;
>  
> -		ret = ttm_bo_populate(bo, &ctx);
> +		ret = ttm_bo_populate(bo, false, &ctx);
>  		if (ret)
>  			return ret;
>  
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index a80510489c45..2e59836b6085 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -224,7 +224,9 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		};
>  
>  		ttm = bo->ttm;
> -		err = ttm_bo_populate(bo, &ctx);
> +		err = ttm_bo_populate(bo,
> +				      false,
> +				      &ctx);
>  		if (err) {
>  			if (err == -EINTR || err == -ERESTARTSYS ||
>  			    err == -EAGAIN)
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 278bbe7a11ad..e4dbf4c93091 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -761,6 +761,7 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
>  }
>  
>  static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> +			    bool memcg_account,
>  			    const struct ttm_operation_ctx *ctx,
>  			    struct ttm_pool_alloc_state *alloc,
>  			    struct ttm_pool_tt_restore *restore)
> @@ -871,6 +872,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>   * Returns: 0 on successe, negative error code otherwise.
>   */
>  int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> +		   bool memcg_account,
>  		   struct ttm_operation_ctx *ctx)
>  {
>  	struct ttm_pool_alloc_state alloc;
> @@ -880,7 +882,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  
>  	ttm_pool_alloc_state_init(tt, &alloc);
>  
> -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> +	return __ttm_pool_alloc(pool, tt, memcg_account, ctx, &alloc, NULL);
>  }
>  EXPORT_SYMBOL(ttm_pool_alloc);
>  
> @@ -935,7 +937,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  			return 0;
>  	}
>  
> -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
> +	return __ttm_pool_alloc(pool, tt, false, ctx, &alloc, restore);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index b645a1818184..aa0f17fca770 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -368,7 +368,9 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_tt *ttm,
>  EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_tt_swapout);
>  
>  int ttm_tt_populate(struct ttm_device *bdev,
> -		    struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
> +		    struct ttm_tt *ttm,
> +		    bool memcg_account,
> +		    struct ttm_operation_ctx *ctx)
>  {
>  	int ret;
>  
> @@ -397,9 +399,9 @@ int ttm_tt_populate(struct ttm_device *bdev,
>  	}
>  
>  	if (bdev->funcs->ttm_tt_populate)
> -		ret = bdev->funcs->ttm_tt_populate(bdev, ttm, ctx);
> +		ret = bdev->funcs->ttm_tt_populate(bdev, ttm, memcg_account, ctx);
>  	else
> -		ret = ttm_pool_alloc(&bdev->pool, ttm, ctx);
> +		ret = ttm_pool_alloc(&bdev->pool, ttm, memcg_account, ctx);
>  	if (ret)
>  		goto error;
>  
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> index 135b75a3e013..baa1c3fdb12c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> @@ -569,13 +569,13 @@ int vmw_bo_cpu_blit(struct vmw_bo *vmw_dst,
>  		dma_resv_assert_held(src->base.resv);
>  
>  	if (!ttm_tt_is_populated(dst->ttm)) {
> -		ret = dst->bdev->funcs->ttm_tt_populate(dst->bdev, dst->ttm, &ctx);
> +		ret = dst->bdev->funcs->ttm_tt_populate(dst->bdev, dst->ttm, false, &ctx);
>  		if (ret)
>  			return ret;
>  	}
>  
>  	if (!ttm_tt_is_populated(src->ttm)) {
> -		ret = src->bdev->funcs->ttm_tt_populate(src->bdev, src->ttm, &ctx);
> +		ret = src->bdev->funcs->ttm_tt_populate(src->bdev, src->ttm, false, &ctx);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
> index dfd08ee19041..368701756119 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
> @@ -360,7 +360,8 @@ static void vmw_ttm_destroy(struct ttm_device *bdev, struct ttm_tt *ttm)
>  
>  
>  static int vmw_ttm_populate(struct ttm_device *bdev,
> -			    struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
> +			    struct ttm_tt *ttm, bool memcg_account,
> +			    struct ttm_operation_ctx *ctx)
>  {
>  	bool external = (ttm->page_flags & TTM_TT_FLAG_EXTERNAL) != 0;
>  
> @@ -372,7 +373,7 @@ static int vmw_ttm_populate(struct ttm_device *bdev,
>  						       ttm->dma_address,
>  						       ttm->num_pages);
>  
> -	return ttm_pool_alloc(&bdev->pool, ttm, ctx);
> +	return ttm_pool_alloc(&bdev->pool, ttm, memcg_account, ctx);
>  }
>  
>  static void vmw_ttm_unpopulate(struct ttm_device *bdev,
> @@ -580,7 +581,7 @@ int vmw_bo_create_and_populate(struct vmw_private *dev_priv,
>  	if (unlikely(ret != 0))
>  		return ret;
>  
> -	ret = vmw_ttm_populate(vbo->tbo.bdev, vbo->tbo.ttm, &ctx);
> +	ret = vmw_ttm_populate(vbo->tbo.bdev, vbo->tbo.ttm, false, &ctx);
>  	if (likely(ret == 0)) {
>  		struct vmw_ttm_tt *vmw_tt =
>  			container_of(vbo->tbo.ttm, struct vmw_ttm_tt, dma_ttm);
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 4c80bac67622..20a10a174d1d 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -536,6 +536,7 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
>  }
>  
>  static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
> +			      bool memcg_account,
>  			      struct ttm_operation_ctx *ctx)
>  {
>  	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> @@ -553,7 +554,7 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
>  		err = ttm_tt_restore(ttm_dev, tt, ctx);
>  	} else {
>  		ttm_tt_clear_backed_up(tt);
> -		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
> +		err = ttm_pool_alloc(&ttm_dev->pool, tt, memcg_account, ctx);
>  	}
>  	if (err)
>  		return err;
> @@ -1926,7 +1927,7 @@ static int xe_bo_fault_migrate(struct xe_bo *bo, struct ttm_operation_ctx *ctx,
>  	if (ttm_manager_type(tbo->bdev, tbo->resource->mem_type)->use_tt) {
>  		err = xe_bo_wait_usage_kernel(bo, ctx);
>  		if (!err)
> -			err = ttm_bo_populate(&bo->ttm, ctx);
> +			err = ttm_bo_populate(&bo->ttm, false, ctx);
>  	} else if (should_migrate_to_smem(bo)) {
>  		xe_assert(xe_bo_device(bo), bo->flags & XE_BO_FLAG_SYSTEM);
>  		err = xe_bo_migrate(bo, XE_PL_TT, ctx, exec);
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 8310bc3d55f9..535ba37aff88 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -475,6 +475,7 @@ pgprot_t ttm_io_prot(struct ttm_buffer_object *bo, struct ttm_resource *res,
>  		     pgprot_t tmp);
>  void ttm_bo_tt_destroy(struct ttm_buffer_object *bo);
>  int ttm_bo_populate(struct ttm_buffer_object *bo,
> +		    bool memcg_account,
>  		    struct ttm_operation_ctx *ctx);
>  int ttm_bo_setup_export(struct ttm_buffer_object *bo,
>  			struct ttm_operation_ctx *ctx);
> diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
> index 5618aef462f2..a4bd23988ee0 100644
> --- a/include/drm/ttm/ttm_device.h
> +++ b/include/drm/ttm/ttm_device.h
> @@ -85,6 +85,7 @@ struct ttm_device_funcs {
>  	 */
>  	int (*ttm_tt_populate)(struct ttm_device *bdev,
>  			       struct ttm_tt *ttm,
> +			       bool memcg_account,
>  			       struct ttm_operation_ctx *ctx);
>  
>  	/**
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 26ee592e1994..7f3f168c536c 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -78,6 +78,7 @@ struct ttm_pool {
>  };
>  
>  int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> +		   bool memcg_account,
>  		   struct ttm_operation_ctx *ctx);
>  void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
>  
> diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
> index 406437ad674b..15d4019685f6 100644
> --- a/include/drm/ttm/ttm_tt.h
> +++ b/include/drm/ttm/ttm_tt.h
> @@ -250,6 +250,7 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_tt *ttm,
>   * Calls the driver method to allocate pages for a ttm
>   */
>  int ttm_tt_populate(struct ttm_device *bdev, struct ttm_tt *ttm,
> +		    bool memcg_account,
>  		    struct ttm_operation_ctx *ctx);
>  
>  /**
> -- 
> 2.54.0
> 

