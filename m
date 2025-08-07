Return-Path: <cgroups+bounces-9014-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF8B1D227
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 07:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BB67AC077
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 05:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490B1F4198;
	Thu,  7 Aug 2025 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/1iXqIZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21795BAF0;
	Thu,  7 Aug 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754545971; cv=fail; b=mjdq8ysKjkq3PGF8RnsYJz1kQcA0+PCxi3y8IVRbO5ze95g2DdzAhP1ZG6TtA+PDqJk4Sp86nGBLFTFEGCB4lYdsYpf2tiTJKs9VL59cBUGsVmqGS3petYK9/RRoe88mjP8y1Et619XUGAHes8/rvrxSD9Ek03k4+fbW3E/zmzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754545971; c=relaxed/simple;
	bh=B/BprS1Xu26XH/i8FYJ3YWGVJ/rDeZ3AAQEF1dkL2tE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PWSjaSgKAXhmnb+16VFjd8IJoHWTNaaMmapo+hWyHilnZXvXOUvGDob00TZnC+rjrIp+3TbFA8cXRUvvr9Gj5S7aGbx0RumgrYo6dwNP+HPJiXGe7OtkmA+YWO1sQjG4V6RXUvvrUnD/+uySkD04S0m3KHcbElKO6zjTQOqVMtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/1iXqIZ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754545969; x=1786081969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B/BprS1Xu26XH/i8FYJ3YWGVJ/rDeZ3AAQEF1dkL2tE=;
  b=j/1iXqIZwZ0repHzHg6t9LmkgGn7S9k5lmc5/tB2HwgAtNfu38Y987oE
   qCLq3AGCOD8d+obUpaBJWgHsCk0JZ/apuguSHJJu87240fri/9rsehwnm
   Z4tb6vdIP1bNpjDKRvpNLjBtWx+npixe4VXwkGYMxbzwT9RizFOV1gIrk
   rg0/O7jtolePbmo/Vb3/THG/HlEea138saw9UHJpqOhqfMEQTgCcfKKi9
   gDLpEZ+JTJry545gRiHTcsQwKwCG/YAF1xaQJ+JZ34nk9cmYQqOjT6znN
   0dbdTCT6klzBOlQrpT5LCJfotPnY0O2ujvSS/lrvMEQNAOXdhgscxvRbG
   g==;
X-CSE-ConnectionGUID: ikI+IfV1Sf2YJQQveFUEMQ==
X-CSE-MsgGUID: ZHUHjHDwTJaF3m0IBSQYEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56835426"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56835426"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 22:52:49 -0700
X-CSE-ConnectionGUID: Xet44cjwRtaRyPYE3Q+ACA==
X-CSE-MsgGUID: vd+Xuhs/RCGPd6zUJbiq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165384528"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 22:52:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 22:52:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 22:52:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.73) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 22:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UG/eFCfSYUFAMLN8Qz61IYUv7LjZ3dovXHbG4K+IRGbiIOPgqE/wyOSZMCojT06BBiM7IPYpLjbkQDab82X5GkPytCHFhrl6gyx+L4vUmkn49aDmVgoWv6cQu1HrbO9o2SWw/LUGAUhcldRF2B3mFnhDlbf/11X2fbk3OacQhieQJSC5Mb1fqhGNz9ySGxMIG2G99kMcl5G1ts6BtzCbcIxeCfYRIGLxqUPsPXFFc8dw2W+u/9/UQ+hxXrRehXnQw7P6Ues3jeh6ieIEwSG7w4rYWJYUsdkWUPmwpp96ju3VQ4wFbuzTXFxhVi0Ka/HOSnt7eLsbGJ0RWaFJubCLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uZAtFS6l+2iNBp6HImeSEhc1wJEumnCMmbOajD+Dh4=;
 b=ILPYSTVGmV7b1h7En+Ou7WsmM4VjEhoGpC61+N2KGi8akOf7FPKKeSuWlcNYyYIcZhjWDXrF2pWVrPzPltqKaVnf+vXBMXl47J8mOnHZB4eybTnMTIPCDki9eMPwlkSIYPvC5obSj2iJkxNgJV8E1dChDooHFRWZDjUd7qnLIndG2svmpgMuGDmJVze5qWSyxXbfRmWMe1DfV1aIZj5EAwTuR6UbuG8UBZdksuV2QdXiaR4fsiE3BtJSKGeuh9L3m323PaUG8fAaxkTrLlBN3VLZQ6O0UKevUf9oq+cugjX/7XeYzGNDF6+/qLE3OsozoX/n/jfYHepmpZlbSZGSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 05:52:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 05:52:40 +0000
Date: Thu, 7 Aug 2025 13:52:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Michal =?iso-8859-1?Q?Koutn=FD?=
	<mkoutny@suse.com>, <cgroups@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [selftests/cgroup]  954bacce36:
 kernel-selftests.cgroup.test_cpu.test_cpucg_max.fail
Message-ID: <202508070722.46239e7c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abd82bd-d384-432b-9438-08ddd5769e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8VO+j4VLXGWFjyR5WZZ9IO0/lGMGyOCtbORDRuqMzr6iuOjfsnwHhym74kvC?=
 =?us-ascii?Q?mHHbtNj00q6AAOLJ/NdWKaySoKs+3OyOnG5vYJtJtBqGgq+cLlFm//4QlYaS?=
 =?us-ascii?Q?2ar8iaFA82wwAumoE+c7YlU2yjqEI9ZBvWs6EiADKOAtU80NiI0g2iME0nGc?=
 =?us-ascii?Q?pxKzjdJ02FBEBj+Zjf+IDwa+W5XXaV8YhEcLwONmpbZOW1ct1aQo89rN5efu?=
 =?us-ascii?Q?6zrbUNb2wH8m8iCTkWFti4MfQhOpYtnywzRmb60sRd6/E8MerxAGt6RI7+vA?=
 =?us-ascii?Q?JboaZTInyoad7nYDmXof1kvjvTUbjQyTMczbJrZrTBVOo8f44hFrjNGBYVR0?=
 =?us-ascii?Q?XazsvEDswp7PG/Oc2YdIOS7XGNyGjXac2ZuA4vBfuqqyTqNPInIKHUUsSyFl?=
 =?us-ascii?Q?2KPpt1r6fnxkUakL8M7vSAiNq5IK+694NOHboD50uVUDXL8iHZrZQdsPdUWW?=
 =?us-ascii?Q?Chz+UQkjAnQuLNpGT/hwsRWJbGeEhyjuA3wRGGd4YfWFJxF5UdCrLAOS8/uA?=
 =?us-ascii?Q?wZRLPK+QXHhukXR0os8AYC+FhWEIy19Tl3iBl0FJ4Kav7W3+cpT8GR6ub4mt?=
 =?us-ascii?Q?6amnhEexM284UKx1H0YrAGHxF6ixp5HUr49C7lPwnUL34yn71fjLzyUFJekT?=
 =?us-ascii?Q?Q9n5ZkKDq6oGEDSeAjlUaCGGDaxWkyDG4QepUpy0bRu7xwfQ+6g6ckPDzzLf?=
 =?us-ascii?Q?EMJzOircqgErWKdQ0VaByHjLAk1C9lKBWyYn0nqru5AxkvC5stKPUVgIl3AE?=
 =?us-ascii?Q?T522Pdmuw3ZXHDbhoArsnFRC4XdTPrnkbuclUUA7BXn+1uYQyddgeSy7ANRG?=
 =?us-ascii?Q?8OWYQ07Rq8ov8g+NQhu/l/5Tb2951bJ0E8fJTTqFpSA3hwxYGZHMsW8Mf06W?=
 =?us-ascii?Q?Hb3QzyHHFSm85NbMd45zkueCYV3XAXDyRdUvTxazpGKF6kYPeHjLg2ygcPWj?=
 =?us-ascii?Q?sEV2K6R8vSa21Hl/SsAKO1hzFopQoQKJVE8Sa08p99mTJOO6XrMD4+N4ykpZ?=
 =?us-ascii?Q?GL8dcmT3ff0kzlHX5uwtHM2VJDy5rh+C0JfMEiklUr51/BuGSVKr0vwF0GHl?=
 =?us-ascii?Q?8DwkNa1sNRn9UCm+k7CfdWmvtGb8OUqB3r1v0/JotjbgKBE97oRsntPaRNv+?=
 =?us-ascii?Q?1Ziv+n1SrJJG+MFyrdAg7ZeEvQmTKk64okCWz58pd/wm60zUzi/JhiCJj1+S?=
 =?us-ascii?Q?0ozc7nhz4h0cbayzf/E5L+McUGLClYKyThD23EAfcYSSvcxEhT4AlBCNIEsL?=
 =?us-ascii?Q?u8FXo3TQIBjZpFLhnBkUjIzuW0WK08parNAe1AiHJd/MYHf7b3O5PI7x8giE?=
 =?us-ascii?Q?B8lZqZDRgrWssXJbW6srv0gHkpI2IkOrkLL0SHA/mucccFdB/L2a/CC1sD+W?=
 =?us-ascii?Q?aSL1gsWGXLGtqw9uv1RfqBN+gMZ7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g9Oso3LrjLWD8Py3TOVjZrBiuo4IAHMdE9dGWKjNkNUG4Bo4T+zmc0KeZeaZ?=
 =?us-ascii?Q?qiVrryDd0MnzC92zaCtib/H2aFav74HlGz3HaaA7DxL36RYTMN+9TMNGKtwC?=
 =?us-ascii?Q?s7EdMTuVdBa5N0ahE4y+GEIBlmbwMz5wbJ/ab2Kg+TMnPjhe3q4GKCB5El1S?=
 =?us-ascii?Q?65+CX8n4eSpt/i+HKOgCJPaEhRY+ICSpC1218iJeaCQI6AF4BKSINVyTBsdT?=
 =?us-ascii?Q?lwUvK4QWXlUOinF4WBQr9n/SiGBh56z0/0Gg7Gl2TgbtMj5TzRhd1vf/CdZy?=
 =?us-ascii?Q?zzM1/GTBlR4GgubL7KM75wHenTboUMrX7TqKKW7b/Fex1nmZUoxwUeXL0nP3?=
 =?us-ascii?Q?bjZuG486qex+3ssmL0bsUTN+i2c1P5FVER1cY8Oc3DZPQo511mBOih6k5AeT?=
 =?us-ascii?Q?zITeQ57wn4m/m+r43EfyVIN8qlTmVjfe9vppSharfBJmvnkGPo/j+XFf+gjJ?=
 =?us-ascii?Q?7uzQ9KqLJGaZRetf+XJZKK0w1up3257Du1UawBa+x2u/dmbASGxpByCRaa8c?=
 =?us-ascii?Q?InTwy6CDK56SVk+XgwooKvJMZSKSRdOkBSb1JGaxv6mvso5utoYXl4bcU2Fu?=
 =?us-ascii?Q?v/jaM70go+oVc65D8L3be3vTAW3+pBU4G4AspWxkHr1F1G+zh8yVluu467tS?=
 =?us-ascii?Q?y3QDcS1w/dd1Uv+QmEPi+uy+g0elYfhf/dp0AJFtPQ+5kYNITAmGxzogxa+e?=
 =?us-ascii?Q?v2wmSxhpxZ3zFPNHrUuy9MMjPKUQ2le7llt8PsjOX/ctxD2hwUPicwravMKm?=
 =?us-ascii?Q?ft+PiPtsngTJWSG8Cyv3OfONprE3395CJjw1XMuOvJf8I2vLa/HeU0IVB1Aa?=
 =?us-ascii?Q?685pWr7wHdTWZZxHu7C7Tv0kdIVe9ZBVvciahmoulll1+IZTS29UUa7PbNJ0?=
 =?us-ascii?Q?+tZ/5KuW/xRs7iGjnMZzEoaapi94kiG7qMobW6pg9J7Sc8hNc3r/n9zIqcI6?=
 =?us-ascii?Q?UIm0Dqa+QAZMjkkEqtAeR/EFddKWWAJaNsJZIi5jaoy2UoAFZCAv+WU8V+1b?=
 =?us-ascii?Q?CGINUKnrZRW0MM9C/nZKdMTbtlw95t7VfBdTEAR4NfS/ej3IEVUW7MbCrEX+?=
 =?us-ascii?Q?Pi+v9JDQGDNyEulpB8jUV5J/+HiFst5oYavWK9j8/1K/luMITg5u6aapQlom?=
 =?us-ascii?Q?ccpofEKzp5y84BzH8LVAVTBNaX4khbgeshk0QpZyBegNjG4R7+W74jZkTHoz?=
 =?us-ascii?Q?rQ+upfF5/iHPQbwi5+mvIFy91wOHX55VqJro1zzn2JB4Ri5kPy+ioQMGfa9b?=
 =?us-ascii?Q?YCNbv3BmJamirX6GEpkTRF4P1FoO8sTFE5WQKsgeS3+Ynn7zqKbh4g4yYN2/?=
 =?us-ascii?Q?eSLm38kyndIWsemVD4aQCKDYB52Q4cBHzjTJYEO3dSTfH0t38ZAK1jxbqxCE?=
 =?us-ascii?Q?ndxclrQLWmaGqZki0TEQ9LbZcB2GsAF3J9clzsKO42uf7dHGkvNdheLwYcdc?=
 =?us-ascii?Q?2hQAB/dJ5zX6T4wBEgSJGbN0sjUTZ0bIFYImSOBk6hz1024pjkq2wHxwPr6h?=
 =?us-ascii?Q?hKECxN7lXzv88ijqswBmSxqz75GmxykqwdmaTRPvk9NrulZCiFnzQglodWHj?=
 =?us-ascii?Q?/K29Ipz1jRsyw1ubchTD/nCIHbmsWWewtyfPiAr2cYHVb1ZbkR7L353pcCvo?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abd82bd-d384-432b-9438-08ddd5769e91
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 05:52:40.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5pkoM/3QDPoRLI2crid7ydZfpj1Pd68is6PYKkwwR48VGL7NNQhU45P4JDS0JdEFyI+qZ/I4z23B+RixcZq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com



Hello,


we noticed 954bacce36 is to address "cpu.max tests", however, we found below
two tests can pass on parent, but failed on 954bacce36.

dfe25fbaedfc2a07 954bacce36d976fe472090b5598
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6           100%          6:6     kernel-selftests.cgroup.test_cpu.test_cpucg_max.fail
           :6           100%          6:6     kernel-selftests.cgroup.test_cpu.test_cpucg_max_nested.fail


not sure if there are any necessary env setting? thanks


kernel test robot noticed "kernel-selftests.cgroup.test_cpu.test_cpucg_max.fail" on:

commit: 954bacce36d976fe472090b55987df66da00c49b ("selftests/cgroup: fix cpu.max tests")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 84b92a499e7eca54ba1df6f6c6e01766025943f1]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-ae388edd4a8f-1_20250729
with following parameters:

	group: cgroup



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508070722.46239e7c-lkp@intel.com



# timeout set to 300
# selftests: cgroup: test_cpu
# ok 1 test_cpucg_subtree_control
# ok 2 test_cpucg_stats
# ok 3 test_cpucg_nice
# not ok 4 test_cpucg_weight_overprovisioned
# ok 5 test_cpucg_weight_underprovisioned
# not ok 6 test_cpucg_nested_weight_overprovisioned
# ok 7 test_cpucg_nested_weight_underprovisioned
# not ok 8 test_cpucg_max
# not ok 9 test_cpucg_max_nested
not ok 2 selftests: cgroup: test_cpu # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250807/202508070722.46239e7c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


