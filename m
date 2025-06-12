Return-Path: <cgroups+bounces-8499-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E73AD6B3D
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 10:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FEA1885124
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E031DF75A;
	Thu, 12 Jun 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExYbnnQZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64111185;
	Thu, 12 Jun 2025 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717931; cv=fail; b=HNkoQpM2fjqGeAOfpqiVCUHUDbOSmmM81CmE9BKzu6UzVEmoo5KqPBeVZmS66yewe6X6LG8yxDl70wxXWmgaLAWKD1mQ3Mz6Owleo0bbvD86SzfdpCxkAQ+LqkHo5xkBurq3wxN3qdvFBmiWrJvVjhNNfOoXRylCyfob2L3raFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717931; c=relaxed/simple;
	bh=Pe9GhGtaRoyTVJhuKGug9/RnghQZEeHwfMJMWNcAUg8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ne1y73/64CdhdS2nFVf7xyTZYJtymX1B9aYEaz50mwD7iKJcuK3ZY6BY9yowyxufd5EjM9gnJkFg7xUBW1bDpEqVborOcA/CtWpyKZghhI01RGAlwYbS1wO60y5sblPJOJrKyfbEF+JEQRdqdSpJg0i69nFIwqJSfFZujF4YfJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExYbnnQZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749717929; x=1781253929;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pe9GhGtaRoyTVJhuKGug9/RnghQZEeHwfMJMWNcAUg8=;
  b=ExYbnnQZTZyFXLxVEJBpAb/YtuVvnMukn56Vo2YJw21rDJ9N1Na3nh3g
   /QC5heNc8AdWP64M4b/huKHDstX39Ne11TV79uw5MzCmjIjWq1M+WyBBG
   BeJpHmQWWDtpSeoARTOirPpqdnnrUc8lhTQSRQY6NL15sN6MzolnTvby+
   WAUKzaqHrf6AmmF/NCFmAUAfygPMdPlDJvDEc1ZD5AiGvey67akRooJn+
   ptaAMCvLAJX33NNs9xqoXQ/2B8ZBcm7n1M7G3ozN6pGJ6/8MdGTFsjkYh
   X4kfMDNEAh2g1vGrMGXg6uSI1EDlV7KdfHmmsSE7NG5VR3BoN6Cx7ziFl
   w==;
X-CSE-ConnectionGUID: Ghqx55KgTVuK9wXxMZeMxg==
X-CSE-MsgGUID: HR0GIBL4SjuC9CMuk6uoUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51985106"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51985106"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 01:45:26 -0700
X-CSE-ConnectionGUID: nU3amiOxRsaJZ5201dJ1rw==
X-CSE-MsgGUID: TWVbBs+DQcyi75ziLanlGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="170624890"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 01:45:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 01:45:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 01:45:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.84)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 01:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VigSDbaSMjPFVmZekcQ5V1jCWi7YwtrhUHIRKrj54sUE4sDmLohsS5x+cG79XRbFHtppfT5Nwc4c31kAa0a+zLGIYWem4ZOir3bHR91eC+2GNg4rbLPLHgpxXVSFgNTLJVI1BZzBLMcWWj3feI0xfbWxBXfxjVQxlBgxHhWO89IA/FO+9jDTChG3cbMw/m3HI08mQsbd9gORw+RZYw0ISMNGBSfYPAxFgzQjmu4RlN4BpJpHuiOj9rsD9oUc/4zHlMM95AnW6w6IMmQVfC9bwSC+DNx/OHCXHrTX6e8Rp7itjrZjsL1kR9lyNA9hgJfHDh3u1biS+vgm5tuYqCG8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R07v6FDfq5iFRNapmJzR5q246PAn/5NFDR+N/fVtcxI=;
 b=jY5qDG+DUzkne3AIEEz/j/UXqCYBaA3Zz7G5w+oSFvBvhMNok7/WAlTgFy4vxkV42IcCLTQfzHDS1G1m3I2grGyUgBaZbdyNOqv/jkXvoK0DAI0mj7iB83uwJvoyjtEvnxOZVKWaBjsT/s3I6+Lpx+grvv4lB3NLKroLVbng4/I9OA9HtXn5hwE1QZ5wPqikZpWfmxBwLzH31LnvaP5tup7+GdHY1G8JKPiRg/CabyxrZlIXDQPVoP103F19r3qYAmc7OAqKycmc4zUgkPnXH5K1JR9mkatPYmWp1S8XE7ESSlf3nR4xj99AnHjJAgeF1Zaz1oZ6hRyt5bW4gWZtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Thu, 12 Jun
 2025 08:45:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Thu, 12 Jun 2025
 08:45:21 +0000
Date: Thu, 12 Jun 2025 16:45:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Klara Modin <klarasmodin@gmail.com>,
	<cgroups@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [cgroup]  731bdd9746:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202506121630.2ea2a5b4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU2P306CA0005.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: f996632a-b473-427b-3530-08dda98d778c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?os636SNkVRCBQDforYPuIJONk8hSxo6+5qTkEMt8SAGiAhFLIz+g5ViLoSI2?=
 =?us-ascii?Q?25+8n9nZ2X94OXn8lDG67iDwxy1IHPS2B3fARWpkgqSYXduDWjM2Co6G7PK+?=
 =?us-ascii?Q?Fefx2GlCizlPJeM+WisDoABSqq5y7Svu4679f1e+9cpfSHOtrT4Fjos0OSmh?=
 =?us-ascii?Q?bdzozGeeE+TsN9IK51hy3aPKj0z9gnMV+irldzAAKp2KqKZ0BCZ+g8Lbz+uI?=
 =?us-ascii?Q?PEDmZh1MSA1xa/TpvzaCj/gcopvBKl/n+ZbC56UUI+sbARPqWai58vwCRSpn?=
 =?us-ascii?Q?7gH8kMwflnxqDOb96MYIDHM6ARqXX31TzR3wjL727DNBXDZ6iB98mPfXxXQO?=
 =?us-ascii?Q?VYA0HY+0mZNGr5SeYzFg8D0CjScEKh46rXoYqXZ7gfd7EG+uF3SshKBXyrGa?=
 =?us-ascii?Q?RkKYe6vq1nCXXocJK9m8Biaw3577UZi8OGEkJ9DJF4u4MJYiIl6fC5PJEMRc?=
 =?us-ascii?Q?Oy0dTPnmZHpwN3YAaxbPGd5JczPDlE2KeoRq9a1CyywXIUe0FrmKC+OZc4S9?=
 =?us-ascii?Q?RPzIB5ghkLy86k+J4dTwnJajTf1P58BEog+/KoEQHx4j0iJ8wyUdoG0AFiYp?=
 =?us-ascii?Q?tUDWO+LwSj9yLEFPiIR4fC96nI4kIzAUIzkHmaXonspfBU8b7GK+sLS4lnat?=
 =?us-ascii?Q?9vjJMOnXpLzWD5eYpQ/2acGcQb+XPZdc2ahrlf4t92osy83SlNaMUdoz+DBj?=
 =?us-ascii?Q?WIZIxATNerkoGyUu0tp00qWAbAl8+4hZVgcvduYR5w2bXN2UGt//zn2qWA9U?=
 =?us-ascii?Q?OY3ZnVKF+0NhfqKn8yDua2xevLNzr1TEre/kKGeeWB844bPlp0HRkr3JwwSF?=
 =?us-ascii?Q?aF/yoy548Xw1DRBr0DxfocKpzMayV+kGtOWD6jO3aS9xERzwRy+Iew0NcTNO?=
 =?us-ascii?Q?eJYqjlPRH81/j6ezMgdBciVwbhm/361EA5JA0mkUiICzQQMOI6FmR0PNSg3i?=
 =?us-ascii?Q?DFTeQZrnK6v9r/13nulZ44Ak41NMpdq30KWqRycE4lvejFsrAvR0KgTKLP61?=
 =?us-ascii?Q?G/aF4+NluxokXtWf8pAyWIDQDCEpvH4FkMo/NwKu+CD75qH/4Bt+4KBRfosT?=
 =?us-ascii?Q?1XBk6s4jkvkul+HCDyNY7b7YA5k9S5X31u7rxB8e+qO9LIem1yp5K0yeo7eE?=
 =?us-ascii?Q?iljRVHk0zUICYl43Awjv0odiAo0T6eVPfdljM5O8UwyLTHp18r90zJq4xv/M?=
 =?us-ascii?Q?GY9IdH7edBI8uxZZXW/+GB841KGdLt+PQeWmjdwA1D15QEIzoh/zMrdFoRLz?=
 =?us-ascii?Q?noXypUYMyuX9hfgjmnq+XouCLs9bdsJxC7vSH4whQPbWUcmSUdypJmer/iwR?=
 =?us-ascii?Q?XV1FaMO1UAH3sFbqQWDczBtoxb53n/HAjDB6ZZqnqejtB51lB90jvMN+ClGh?=
 =?us-ascii?Q?UrtXPKytPsGuPINCEjNrIbI7x2zt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXIIJ2fokFHhl36k/qM4npJW43yk2tJMmtKwxKC9xqLQ84U7xNsuMfHL4FLJ?=
 =?us-ascii?Q?Qf4RRu8bIS7y/m/qvzpMPXXBi4UlcJnR7EQWH/Viy0v91F3udV0UarfLI54d?=
 =?us-ascii?Q?1hPOa1gobJ3liuIPd6Oajp8rfTk5xfFS+90wjhzeBdY07hoLpMqqwx39eL/h?=
 =?us-ascii?Q?k3Je2FJNBHWcwiLLT/sDLysRGU99PQuKjyJfw0qOwgeztPpWos00wtEmZkbk?=
 =?us-ascii?Q?j755ZcFXfYaZ7KNtogTp24Q24sTW4G/nE18EH+W/+INp6XWtKG2GE1h2ronf?=
 =?us-ascii?Q?KLFiHbLdNujni1nzzT4y3zdaMBZKFF/X/IzCml3CSMvEGkZawnhembLGUu4q?=
 =?us-ascii?Q?PKGYKX7Fg6oUXajyZ4pdqQnWTW8c1hnvim0miSLTgi0ahySOw4PZAaLaIhoL?=
 =?us-ascii?Q?gq1Hl6/kFARBgkoM5hQQYgzbMyj9Sl1NZNG3WZSbsD/BoIh07XqR/2cuTCJX?=
 =?us-ascii?Q?0CKYCBBee92asaG5NjqnNUd0WopELJKSwr6XhgjQCvOYt4bOI58toT2yXFO2?=
 =?us-ascii?Q?woFEM5RiVzWOVHOTCRfyiIr4YH5VwNZAPoi6CZv4q16F2RYcPw3JvJ1A4VFQ?=
 =?us-ascii?Q?jBv83GW1acowR2Bl6LJkRFbgP3kT+SDphQH9jZ/yeW+mHxv40ez1VXQI3+1c?=
 =?us-ascii?Q?rXOQMtkOv6i/jNY3PNwlBBtbuas/Yx289zunbA+EmnDyeW4OwKQeioNU/OqP?=
 =?us-ascii?Q?r3WJG1VTTJlJGn2O7lO6Awtcx8zhHgXFnDcHOKQzQwqB2PA4Vf6xIhwA5gwf?=
 =?us-ascii?Q?pYZYCKqvHklnm5YWfqMZHU+K566cUd8eB5XyGQkpr4D/fTy9up+PYHd3+BYV?=
 =?us-ascii?Q?lDfYSVuKwnSEW1wOtaOFFAE6qOm6uQSJ1FWCW/3DRBdRKR8dwmbIppAFpxpp?=
 =?us-ascii?Q?xVREj7CRXCu1wyYzT0OS/7iRSAdIj2ulHtxUbdP4XEHYALwzg/WGJcpmVq8+?=
 =?us-ascii?Q?qau3hshhg7M5VOYuomdEuXN2J5estbZojI9RfKU3D8cfdw8mt+UL6hRwcqv6?=
 =?us-ascii?Q?StwiWDty2qJuIjsexhfNckPFa2OQTmk5tSEBK7hPM/Jz+rNGJTO5nSeBCy0C?=
 =?us-ascii?Q?n6v6aEoXu7AkxzgHT75/gB4zqFFVeAd+qqBq5OKW1l79jMujnHJwj/D7iukC?=
 =?us-ascii?Q?xDe7jPAQFuZZoG8s/9ZvCR7XRcoV86HnEQDTvauSeuxOcNWDOb96fHZAOBCj?=
 =?us-ascii?Q?PXPP9JXopc09gb8aDw096t3CoBCfKHKrmeBYYLVEPzfWnKDbulEeYTu5Apj6?=
 =?us-ascii?Q?JRyKOgmrA3XVLWTOf5rrN9QpMC/K8BXRsKv+tQqYlbmPvDKwKNDrFUMqvTLT?=
 =?us-ascii?Q?4kzneqKBeprF26u/rmD+d7O8etrYWYxvd/jYo+0ge5r/XGZ3RNzxJNlGdla+?=
 =?us-ascii?Q?PeNyDx2mbahsXryfiQpmFjDXAO+btzyr8PRKUaFwstB0Ven4JlOz9c4qRqjB?=
 =?us-ascii?Q?x7XpKdrZs1kB63fWxYSLz75staICDzqK3q+E3N3HHxNu34qkI0fRK3kwltfk?=
 =?us-ascii?Q?fX62vvCsPgaDBippjgj1HkLMiTf9+GGY1pmQKXkyIV7IuwIagZr0Hbd6PmuX?=
 =?us-ascii?Q?tH0Tfvov2fb8+iuwHTDFVasTYepA/DpK9gviuhkWKfj5BEmqqHrD/KOobJFR?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f996632a-b473-427b-3530-08dda98d778c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:45:21.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv+Xs6ZuNSUPCjxS+skKQGN/cc3mRLJu88psl7t9Goweht7aW9IRrhNtqBtIV/DEYjV8Y//xtcGezoLRYzRrwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com



Hello,


we reported
"[linux-next:master] [cgroup]  731bdd9746: BUG:kernel_NULL_pointer_dereference,address"
in
https://lore.kernel.org/all/202505281034.7ae1668d-lkp@intel.com/

and we noticed in
https://lore.kernel.org/all/9b500a3d-296b-4643-85d3-78d7bd6ec66b@gmail.com/
that there will be a patch.

since we noticed the commit is in mainline and we still observed similar issues,
just report again as a reminder. thanks


kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 731bdd97466a280d6bdd8eceeb13d9fab6f26cbd ("cgroup: avoid per-cpu allocation of size zero rstat cpu locks")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      aef17cb3d3c43854002956f24c24ec8e1a0e3546]
[test failed on linux-next/master 19a60293b9925080d97f22f122aca3fc46dadaf9]

in testcase: locktorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug



config: i386-randconfig-017-20250610
compiler: clang-20
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------+------------+------------+
|                                                                  | dc9f08bac2 | 731bdd9746 |
+------------------------------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address                      | 0          | 18         |
| Oops:Oops:#[##]                                                  | 0          | 18         |
| EIP:lockdep_init_map_type                                        | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception                         | 0          | 18         |
+------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506121630.2ea2a5b4-lkp@intel.com


[    2.332700][    T0] BUG: kernel NULL pointer dereference, address: 00000018
[    2.333523][    T0] #PF: supervisor write access in kernel mode
[    2.333523][    T0] #PF: error_code(0x0002) - not-present page
[    2.333523][    T0] *pde = 00000000
[    2.333523][    T0] Oops: Oops: 0002 [#1]
[    2.333523][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-11173-g731bdd97466a #1 PREEMPT(voluntary)  00fbd346f9ecab0633cc52854fbaacf90c8417e1
[    2.333523][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2.333523][ T0] EIP: lockdep_init_map_type (kernel/locking/lockdep.c:4945) 
[ 2.333523][ T0] Code: 00 00 00 5e 5d 2e e9 4e bf 3f 01 89 f0 e8 a7 43 f1 ff eb e5 90 90 90 90 90 55 89 e5 57 56 83 ec 08 8b 35 14 20 b8 9a 89 75 f4 <c7> 40 08 00 00 00 00 c7 40 04 00 00 00 00 8b 35 90 dd 90 9b 89 d7
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 5e 5d             	add    %bl,0x5d(%rsi)
   5:	2e e9 4e bf 3f 01    	cs jmp 0x13fbf59
   b:	89 f0                	mov    %esi,%eax
   d:	e8 a7 43 f1 ff       	call   0xfffffffffff143b9
  12:	eb e5                	jmp    0xfffffffffffffff9
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	55                   	push   %rbp
  1a:	89 e5                	mov    %esp,%ebp
  1c:	57                   	push   %rdi
  1d:	56                   	push   %rsi
  1e:	83 ec 08             	sub    $0x8,%esp
  21:	8b 35 14 20 b8 9a    	mov    -0x6547dfec(%rip),%esi        # 0xffffffff9ab8203b
  27:	89 75 f4             	mov    %esi,-0xc(%rbp)
  2a:*	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)		<-- trapping instruction
  31:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  38:	8b 35 90 dd 90 9b    	mov    -0x646f2270(%rip),%esi        # 0xffffffff9b90ddce
  3e:	89 d7                	mov    %edx,%edi

Code starting with the faulting instruction
===========================================
   0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
   7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
   e:	8b 35 90 dd 90 9b    	mov    -0x646f2270(%rip),%esi        # 0xffffffff9b90dda4
  14:	89 d7                	mov    %edx,%edi
[    2.333523][    T0] EAX: 00000010 EBX: 9a8f2e13 ECX: 9ba10c30 EDX: 9a8f2e13
[    2.333523][    T0] ESI: f894bc3e EDI: 9ba10c30 EBP: 9ab77efc ESP: 9ab77eec
[    2.333523][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210292
[    2.333523][    T0] CR0: 80050033 CR2: 00000018 CR3: 1b321000 CR4: 000406d0
[    2.333523][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    2.333523][    T0] DR6: fffe0ff0 DR7: 00000400
[    2.333523][    T0] Call Trace:
[ 2.333523][ T0] __raw_spin_lock_init (include/linux/lockdep.h:135 include/linux/lockdep.h:142 kernel/locking/spinlock_debug.c:25) 
[ 2.333523][ T0] ss_rstat_init (kernel/cgroup/rstat.c:530) 
[ 2.333523][ T0] cgroup_init_subsys (kernel/cgroup/cgroup.c:6091) 
[ 2.333523][ T0] cgroup_init (kernel/cgroup/cgroup.c:?) 
[ 2.333523][ T0] start_kernel (init/main.c:1094) 
[ 2.333523][ T0] i386_start_kernel (arch/x86/kernel/head32.c:79) 
[ 2.333523][ T0] startup_32_smp (arch/x86/kernel/head_32.S:292) 
[    2.333523][    T0] Modules linked in:
[    2.333523][    T0] CR2: 0000000000000018
[    2.333523][    T0] ---[ end trace 0000000000000000 ]---
[ 2.333523][ T0] EIP: lockdep_init_map_type (kernel/locking/lockdep.c:4945) 
[ 2.333523][ T0] Code: 00 00 00 5e 5d 2e e9 4e bf 3f 01 89 f0 e8 a7 43 f1 ff eb e5 90 90 90 90 90 55 89 e5 57 56 83 ec 08 8b 35 14 20 b8 9a 89 75 f4 <c7> 40 08 00 00 00 00 c7 40 04 00 00 00 00 8b 35 90 dd 90 9b 89 d7
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 5e 5d             	add    %bl,0x5d(%rsi)
   5:	2e e9 4e bf 3f 01    	cs jmp 0x13fbf59
   b:	89 f0                	mov    %esi,%eax
   d:	e8 a7 43 f1 ff       	call   0xfffffffffff143b9
  12:	eb e5                	jmp    0xfffffffffffffff9
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	55                   	push   %rbp
  1a:	89 e5                	mov    %esp,%ebp
  1c:	57                   	push   %rdi
  1d:	56                   	push   %rsi
  1e:	83 ec 08             	sub    $0x8,%esp
  21:	8b 35 14 20 b8 9a    	mov    -0x6547dfec(%rip),%esi        # 0xffffffff9ab8203b
  27:	89 75 f4             	mov    %esi,-0xc(%rbp)
  2a:*	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)		<-- trapping instruction
  31:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  38:	8b 35 90 dd 90 9b    	mov    -0x646f2270(%rip),%esi        # 0xffffffff9b90ddce
  3e:	89 d7                	mov    %edx,%edi

Code starting with the faulting instruction
===========================================
   0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
   7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
   e:	8b 35 90 dd 90 9b    	mov    -0x646f2270(%rip),%esi        # 0xffffffff9b90dda4
  14:	89 d7                	mov    %edx,%edi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250612/202506121630.2ea2a5b4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


