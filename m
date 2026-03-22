Return-Path: <cgroups+bounces-14984-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5YFyDyrzv2kgBQQAu9opvQ
	(envelope-from <cgroups+bounces-14984-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 14:48:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E03BF2E9813
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 14:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4BD300C01C
	for <lists+cgroups@lfdr.de>; Sun, 22 Mar 2026 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4735836A;
	Sun, 22 Mar 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cviKMnEv"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF863375CB;
	Sun, 22 Mar 2026 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187293; cv=fail; b=XtDnG7cVaTDo3UQqkWFsnePPTLF5MY7CEX4M1XN/tyiif0IXtMJSrIZT/JvtzECog5TQuv4EMe6WG64YWqP5ESvsHFa/TIav2nK4b+6BNFn1+QSa54SrOCWCDQaj061oO8vR4I9jqSna83dIxc6WPxcM4lK5eDmkhaR6cRFUcSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187293; c=relaxed/simple;
	bh=f9C6Oe/uq/ejnmVryjcIMz7xnJSt5a0Iyxl/c1dNse4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XTKI91Ym4YecvoqIJ0N2wCIvnStLUu2ZylZBdnJcWNfk3MQBkgTsaZlELD8DlJupQjmxueRNyhNNKJ0Uv+BuLS0COf1Uf8kqp4N5B4ammLcE4PKgbixD76fLcaMP3eRQOdmgOykTtzabCfrhJ+PFB+BLi+D0paPpIM6mhez3LYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cviKMnEv; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774187292; x=1805723292;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f9C6Oe/uq/ejnmVryjcIMz7xnJSt5a0Iyxl/c1dNse4=;
  b=cviKMnEvLcfoN/CvMgKtkhfrqdjzlSTXUgHsH5rs0skr1+Nhimr2mujB
   uPf7XHhI/Ja5BLcLd327VKpSd1y575VhHZYGDxfN0WuhGGIs8tchur1E0
   81Cm5/KcxY2YjgypHQ5h+kCzq/ojjh4E4C+eKEh5FCI/Dr84jreKQONnr
   pMpd/suaHuwCzzeSs7qWVpFQSbDvcNIqPtpu3LW9wTWcQs/fNCigXG1LO
   l+uKRtkMhBpWHnu+BTAtAzoEUhk+WBIg+sLOdBHCn/krngalaURTfw2qx
   5CYXdjC0AijewbbIooAMjhWTm0EY8U0fcsAwhFeXa5xn8m1cApScsGnok
   g==;
X-CSE-ConnectionGUID: 5gDOEnuTTa+n7einQMi/hA==
X-CSE-MsgGUID: Fv1vXUYQSuidR6ZLkRG/5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="79068533"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="79068533"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 06:48:11 -0700
X-CSE-ConnectionGUID: QQrSybMCQOKdmVuGk1R8WQ==
X-CSE-MsgGUID: gr65rYy+QiWqOin6K4jMFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="219465423"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 06:48:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 06:48:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 06:48:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 06:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz2EnuuzNsA3bUEv1/obIO/B76PHohSVy1eDDPBQqMGxQHn422W9nP2ceW0IYB7p6iDlta4X2o+A2hRzE9fj1U0QY6jR/QGXhny8OccGafe7OkurwB7y95uqWbWtT040pNkiTNgZ6Xj6rVlByaHP38HPTpVk3oqvv8Zo0ArQBctdLm2QPcL/UU95h2fGCHuRpQ+WfEEkji5MfEQST/FG/wvi6Q4WIZVuIpLqpgdKPQcSqXAC64APti9sBqAP/4q0P/indHvl5MYlS7Y2XJtrDMf1h52uVBB1L1RhjrFaAMq8u33IhWT1aUtJ+gLxMdaZEcr834/mAC6w3RDvh1B8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+67/A9BvCcMRIlrFvJ+2QU0LX7yi9Fz/gzmgPSMOWM=;
 b=eOifU63F76P2wMXC2Zr4oIaM/naKI/xz0gdSh4Qzb5dNT2odjEDDNHfRyU2Acwml499ng2pv1KiqI83omAfVzKHc5Fov9H1rm2Kt69FjaCDmxlIDUsQML1kgplLMxwJ/YjKf1EAfu55XFW8v2+tGH18J0DFOZWm786/ePBxw46+6xqTMIRRnREo/nD6UcmvAIeanLlzRM00IR4LWFJLfQbROTMTXviJsE6sanqFVEgJZRgzZWiKnzdLTlHSDzDl/2HLAuOVGWXN4vHzVn19KaFlVxJAm/uqhSZfnv/RbLAtCSALD8ALjOGLebzPWFermnqkytSBTAVzWedWTykbBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by IA3PR11MB9400.namprd11.prod.outlook.com (2603:10b6:208:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Sun, 22 Mar
 2026 13:48:08 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9745.012; Sun, 22 Mar 2026
 13:48:08 +0000
Date: Sun, 22 Mar 2026 21:48:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<cgroups@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [cgroup]  a72f73c4dd:
 kernel-selftests.cgroup.test_stress.sh.test_cgcore_destroy.fail
Message-ID: <202603222104.2c81684e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::18) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|IA3PR11MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bab9b8-4ae0-4213-10be-08de8819a67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: EHMsopWZdQKtZGMtwr75nedkZbSVb6vK5rQcYtHssji9x7BJVYJ47GooirA8pbMrz6tr5KMnxI3Eco/EAO7gQJ2VvBEr01j0O1DyjLfgKf2IMqSLn21Cd+qKAnFH2U1FR+IrldGR3wwFj+OWH3W0pawKgnj1M5VsLyrfw3Sw5kbmUw9/f7FBPe6xwst/xrSSNZWI9vWdi7p24GNGdMQtGLfO2dnRtkSiVoEkk8oUxgm3e3ViIm3JsqwwRr1NOPJ1siP/4d7UPpn5TlniNdsHazyH0LdyBBhVT43cQPdju/k17S7cEo4nX7c1oTLNH/4zgGfL29Pzl+X11i4LWcgB1oTtqiATyvuG3iu0+U/eu6hdtHJKblWkwPUxITsfAGeukGukwHJUMIxHt7C4AmTPe1zaGzCvpAEfuqPhYW4rQ/Jerhn9fu2wFXbiAF82FpAP3SGPPDQJJxNuKgRHgDuSxiC32STqfL9QrVvh61xTA+vQAXVxayvA+kzuOj2FBM4n8fSMqokNie/fWWknC/qCqQ0IElGvokj2W76d4Q2me0Yq+ZbgMrGn+O0Z1uMRSsTYHRZsJDzLoklySA7CWFCRQ05B8SIc46mqQq742JLffMx5K5W6ms5ctz0fP69HFjCXsw1/1CySGIUXyljJux3h5eV9C4QvTxuvY/ZZpAp8HFQVRdIbzF9wraN4/A6djCoK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1w0NmwVI/NHGXLYfqlKSTr7PPnhrC4IM12OGYQsCCFKgX2WP9UOvavRKC3Dd?=
 =?us-ascii?Q?+62/AEslLP1+p4BOjJuZduA9OMG3lyDAZmRAN2tVLyAUum0yM6tUFf8lyb+M?=
 =?us-ascii?Q?0hdsRZL5AkzbeK0gXxcSLY9hFuwKr001924+C+ShAT6OnDKhsieBaTRe8DtV?=
 =?us-ascii?Q?2C20n+KRMJOVawfQqtav+RMYz0Bhs97ap1xGvDazhFc5WZY+KOBTAp0hz5Qw?=
 =?us-ascii?Q?q+kZYXVOU78OpHR0DFG2faGgzaG6fRRRs201BlN3qdF0b9402ush/VPHliW2?=
 =?us-ascii?Q?zIJGZ8uKtcVSuDcCxFes8fxAi1a6eEL0bvhHwTJthqMcaxCFtTw3gGz4Ucua?=
 =?us-ascii?Q?JbO4q+ROWWzQS9AFQFTW+j8oSLfCRkCfHi5Q+zCewdoCtoJ8HuDAkkiKCTyP?=
 =?us-ascii?Q?M79CNxV8QqgZjZHNpLFe2OnCGVHHS6mxOaYuoQUqj9mFbnDMK19Epr4OVxZs?=
 =?us-ascii?Q?nOqyHEEdN0eSpd5ODmzCOv0WThshtiA/6GGEPOJlDc+S0CJT6wRoOxKW+LND?=
 =?us-ascii?Q?71JVE31AWMOJhCgu/PIqu2HuNu9ZnR41uuNe+iF6P/OmsL3bHl6IuBmmvF7V?=
 =?us-ascii?Q?dSSGAxV3MHAaKoMyXQ14yAzfAXR15aZ2E9gLk+re2Oe1Em8wteH30/oNmMwT?=
 =?us-ascii?Q?M9t5L5TSkXQvWUSdRH8FMreTUFPVwVLZ+pmPZZNTkI6C8Ng0YPtLlJUX34DF?=
 =?us-ascii?Q?z4TMbnF2BXsyNbMbY5x8kGLu/T3rNVIP6EkeE5W85STp98NwjHHki/p3r/1Y?=
 =?us-ascii?Q?nHj2NWarPAiuUrG+0gtTgvPqiCxF/+1vma0+X/NZlZ8gYKaffrkGktrgvJQa?=
 =?us-ascii?Q?70LBoNk4k8E5D+y+8PiPMT9ZHvYZIGqIcsbelrrL4Uvp1bi1eIoYT3NIzR5U?=
 =?us-ascii?Q?+90E7iBuR2GvpzyxvDa3Hg1FkvHrukGppCW/UbEWk7C4J0ItRUnmIpY02IkQ?=
 =?us-ascii?Q?utRcTYErOwSnXg024+rI9FsgSugXJ0eptp5FWKGtbUB8ma98xQ5zv1yUcUda?=
 =?us-ascii?Q?h0Bx05WxZUFbjEten28SnMrK0nhDOwSbwrzfsQBTBzyj7TmCWC1VGNp2hYjZ?=
 =?us-ascii?Q?4IGIzlkEmVyffcloOh6bvW/4g5b084sxj8KliApZtYxMFVk160gEsGWiDdQ1?=
 =?us-ascii?Q?5PJcAJJglRyM+a/oGL9DASLxwfqw65RRX/GOm4omfx0ewrqRj72IFrX1pE36?=
 =?us-ascii?Q?x68KYXezPv7G9jQQN5Gu9/Lhx8hxwxKslwPZQt/jdcfZ7wxpW3g/qv4Oxaal?=
 =?us-ascii?Q?nBRRkUe0zs6koFguHEC7TgENlnBhAblftqv/yU9xdolECtlAixF+cNTfYueG?=
 =?us-ascii?Q?Mgyq1jzpV9M5LtsIxoQ/wEVB5UaGttmGoZTj4pda49VswvF+qodqooIHaA7B?=
 =?us-ascii?Q?y45vHl8ByrJ3jU/eaRtn2QOx3qILTmAneediCM1+PA9QQONl8C+PcDBVmT4w?=
 =?us-ascii?Q?pVjWnX0sehMwui1fH6Ixo9ySYS098kroSTpLDxj9+tVzEJbgyX9XdfTIye8x?=
 =?us-ascii?Q?SiZ4EQTvrNbVIpdGQ+cDgykEaZDr5SLc9NZiiZbb4Tar3BJfsH7XYXtLaytL?=
 =?us-ascii?Q?lxOQOc+XlhBwRJcoPS0C75BhUed8CvEhOeov/CnauUw312Yb/0FXmvyoiyzC?=
 =?us-ascii?Q?X2KG0C6KfmLANdDnYjeUC743zdhU80uZoPXDnVFbtCZUVaoTbqnNMQIxjR1j?=
 =?us-ascii?Q?4brJIkDlxC68+L+GjW6dAFbJFD1yMIsJanaHJI/zfaSkXqgsE5JK4j7O+r9U?=
 =?us-ascii?Q?j9VUn+rdgw=3D=3D?=
X-Exchange-RoutingPolicyChecked: vi+pmHOJec3N4HMJdiYOv4QPvDtnBiB/80vYaU3jteeyaBrUnLlYgaNUILl0I0JYLu58F+wULhsVPCOjc4aXoK3l20pVYGEdlIpTSqPLpltM7iRhyY4WJQl+zGUFLKVCfhsjxdQrXLVZjspJ9EFSzP2o2IW+B1Ngctt/kinUwijUBF7ewEnQwr6lOCfMgUqTb59TnwS3FrDGDialJ9/K/cPuo0TU69zLWH4o6yhU8RGgKjXPNh0NFN9aculZ8X2oPIqs7EF2cPrd1iWgU596bHsv2+5IIbP5R060TiejBhGINOXmIjdBuoDLY5bpCPs9LTbSi4YLSJnhqYF68GaKQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bab9b8-4ae0-4213-10be-08de8819a67c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 13:48:08.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Gm7aeByxAodqVBo/rmMd8BetkTMQTlZ4PQLSmOotHZLE4lb/kp8FoiAVY2lAcXAvARqLpEASHcw9ZcXvXWRkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9400
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,kernel.org,web.de];
	TAGGED_FROM(0.00)[bounces-14984-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test_cgcore_destroy.fail:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E03BF2E9813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hello,

kernel test robot noticed "kernel-selftests.cgroup.test_stress.sh.test_cgcore_destroy.fail" on:

commit: a72f73c4dd9b209c53cf8b03b6e97fcefad4262c ("cgroup: Don't expose dead tasks in cgroup")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      a0c83177734ab98623795e1ba2cf4b72c23de5e7]
[test failed on linux-next/master 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-8a30aeb0d1b4-1_20260319
with following parameters:

	group: cgroup



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


there is another test kernel-selftests.cgroup.test_core.test_cgcore_destroy also
failed on this commit but can pass on parent.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/group:
  lkp-skl-d08/kernel-selftests/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-kselftests/gcc-14/cgroup

ca174c705db52db3 a72f73c4dd9b209c53cf8b03b6e
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :9           67%           6:6     kernel-selftests.cgroup.test_core.test_cgcore_destroy.fail
           :9           67%           6:6     kernel-selftests.cgroup.test_stress.sh.test_cgcore_destroy.fail


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603222104.2c81684e-lkp@intel.com


TAP version 13
1..13
# timeout set to 300
# selftests: cgroup: test_core
# TAP version 13
# 1..12
# ok 1 test_cgcore_internal_process_constraint
# ok 2 test_cgcore_top_down_constraint_enable
# ok 3 test_cgcore_top_down_constraint_disable
# ok 4 test_cgcore_no_internal_process_constraint_on_threads
# ok 5 test_cgcore_parent_becomes_threaded
# ok 6 test_cgcore_invalid_domain
# ok 7 test_cgcore_populated
# ok 8 test_cgcore_proc_migration
# ok 9 test_cgcore_thread_migration
# not ok 10 test_cgcore_destroy          <------------
# ok 11 test_cgcore_lesser_euid_open
# ok 12 test_cgcore_lesser_ns_open
# # Totals: pass:11 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: cgroup: test_core # exit=1

...

# timeout set to 300
# selftests: cgroup: test_stress.sh
# TAP version 13
# 1..12
# ok 1 test_cgcore_internal_process_constraint
# ok 2 test_cgcore_top_down_constraint_enable
# ok 3 test_cgcore_top_down_constraint_disable
# ok 4 test_cgcore_no_internal_process_constraint_on_threads
# ok 5 test_cgcore_parent_becomes_threaded
# ok 6 test_cgcore_invalid_domain
# ok 7 test_cgcore_populated
# ok 8 test_cgcore_proc_migration
# ok 9 test_cgcore_thread_migration
# not ok 10 test_cgcore_destroy       <------------
# ok 11 test_cgcore_lesser_euid_open
# ok 12 test_cgcore_lesser_ns_open
# # Totals: pass:11 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 11 selftests: cgroup: test_stress.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260322/202603222104.2c81684e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


