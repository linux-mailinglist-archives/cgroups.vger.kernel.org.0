Return-Path: <cgroups+bounces-8648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6290AEC399
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 02:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ED74A8072
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 00:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67812EBE7;
	Sat, 28 Jun 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bXaKWkvj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EwM+VSYu"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238A2F1FCB;
	Sat, 28 Jun 2025 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751071521; cv=fail; b=H8g6oTUShev2X3FPFfGo2C+xEc7y4J2HpdDhmwDXktqjdXFcVPoJ9GpBiiU2WgTBOWKxOVpGCgW7CxTV1so8DhceFOMtGxSbHorzcX6ApimNosVzdhTKdsfUle7fN+qicRQLrmvNrHLVOJWytTQiZ9F+PzQO8ga7ksiKyXtSCbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751071521; c=relaxed/simple;
	bh=XawHKTpNJuFzaayGEBo1pOHg/26ltkgeJdvat0LIjoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qgUWCwx91Q3wYjSTf4KPirHhRobfu4aapYnzePl+BundSUuJ5mf256cVnuIY7IP8MpJlSvhJlSx3GeyJHnrf5vfca9draFqzfKOMn96StNYIYcRcQxTIhZwotLQjN6P4Cke1b9Vg0ekwJ80UX+tKDXQTYfO/7LvwZK5CGUGlk3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bXaKWkvj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EwM+VSYu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55S0QYUE016968;
	Sat, 28 Jun 2025 00:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5RBKiA3xIhAu4WGvvj
	Fib4cSW3v0dUpbXbZxr5xHfis=; b=bXaKWkvjkRVDunTXPBw13fsJGUu3WIlbxM
	bgkW4294Rx0HH7zpX3M2nDyk1EKxDR6Szt8MAs3v5S4a2RTT2tJnYjG9v2yTOCPV
	dfJQrQ09zrSx7GGWs0b5+KRI7YzDP0aCy9VFui54un8zvf5Jh9+IRa7ntku042ja
	qDF3RGx6rcRNgmMGbThgQRvDzGDpHKEl1cggnGuDNw9mQRLIuJnNYlX5kQ06fNUm
	swIGeNJUJF6oD53uGRRtAyibTEixkax4wcN3ISUpfDASJ4qEFalhLAL0pQ1vZuKP
	sWCMfsIdyy8R+84zyb781ZiIADgJlVyLtI1Qy2Hd7y0THl5nTU1Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1kkau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 00:45:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55RMjRJM017876;
	Sat, 28 Jun 2025 00:45:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehw206hr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 00:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSN2Dsc9amf9S/tGMO4/bSGNbFq4uHC7paBj5FBgwHdzOJseF2eu1NC4ZPmBHJ76toOM0udsY5vwxnkcunG6tK0fSjeHKOsP4YmfFQaMEbeiTsL4kIhD4ZJHg9+2VVFqVk0EY40yA9ijIRYhj6po+/CgBu2Co48R2llzXcCN2pM13Egl/FMC6GPa3Z+LPTSfyAD+lQPuxRcNviYHyiAGuFmTkOWzwdFiqPIPK+ir9UV2iLlvCWRJyZyWImY7W/qeCRWJKHVSqlKSgqmUXen9vEpcLt1VUEl0XUoWB8GfpB7BYIlEeQgvETnGpTLzoCWSA3Wl7dOSTTVCSzroo5RZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RBKiA3xIhAu4WGvvjFib4cSW3v0dUpbXbZxr5xHfis=;
 b=bZxyXCJ57HdgJXEnSC1qPMWMlXYTYoHIEYIQsYDVpvPSLdofKK/7prBSBPcrkFwQ0VYaq0Ip8sPjo+q3miVXoeD0J+VIgceEaFsP8FxpwMXWApM2VS03q+Ui0fAF1QSl+qz2L5pWZxjDCllfX/rRDCVJHnNpsmlLGYPXnKp2MnLIPpmHGV4MvVcFZfz+Z0XL8eDlBlK5RHK0RJmD+HbFfhk6k2LTF9HDmsRbwopU5NjT7oO1oZL+I8HMZPRqUkMqmKzkM3yhaD1SvO/HcUIbsiI8ukJSragDxSRV8hCt8uzVUsx0zSXwGFjtMtwqz8URkc/PJl8lV04TFiFONSH2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RBKiA3xIhAu4WGvvjFib4cSW3v0dUpbXbZxr5xHfis=;
 b=EwM+VSYuHMEN64Z4JHxFZU1xvohnpJ1Q7oMzCnDuf1Rc4PWN+rA1Sfh1vadQAOWatFiOHOTWBKSDp/iPU6fmRXkK4evtvLJPjaIDhXBLoXEmaY9iAd+lelWIGyuMfgSaxxoLjbEo09J63RgrgNrSZ58JNxM3aoZ/s0e3Tez1IG4=
Received: from IA1PR10MB8211.namprd10.prod.outlook.com (2603:10b6:208:463::7)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 28 Jun
 2025 00:45:07 +0000
Received: from IA1PR10MB8211.namprd10.prod.outlook.com
 ([fe80::ec0a:e847:383e:1c40]) by IA1PR10MB8211.namprd10.prod.outlook.com
 ([fe80::ec0a:e847:383e:1c40%7]) with mapi id 15.20.8857.026; Sat, 28 Jun 2025
 00:45:07 +0000
Date: Fri, 27 Jun 2025 20:44:49 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4.1] rds: Expose feature parameters via sysfs
 (and ELF)
Message-ID: <aF87ATSJH3Q9rkju@char.us.oracle.com>
References: <20250623155305.3075686-1-konrad.wilk@oracle.com>
 <20250623155305.3075686-2-konrad.wilk@oracle.com>
 <20250625163009.7b3a9ae1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625163009.7b3a9ae1@kernel.org>
X-ClientProxiedBy: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To IA1PR10MB8211.namprd10.prod.outlook.com
 (2603:10b6:208:463::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8211:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe325ff-5e49-421c-61d0-08ddb5dd073c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bmFx5f+voRgO+xEeYYWpHINs9FdqCrKAPAXVWrNFxXXQLrlFXqlJsRoqfraH?=
 =?us-ascii?Q?1qoofBBxDofr6UGCeuDlVM8NSsXjeWHljK+Y9PNccKffAWFD663ZSqAVSfli?=
 =?us-ascii?Q?wGsoftpHAq+H6JM7o4hWGa1aWslp8TJCqAdIrgMChUMTcul4TafBKC8MgXcW?=
 =?us-ascii?Q?lZuNcXQb7xQavaBLdP7ylgmD7QDCB0uVVXhppkN2guH+0QS8XpBN7/5L+A7e?=
 =?us-ascii?Q?sZsGRAKD4HhKef3StcgaPld4d2m+Dk909gxlMulwVjYmp13o7Ew8M+l4SIUW?=
 =?us-ascii?Q?d+WmreJw/Jnotmo157yCqDUPjWv2sXKBeBGAVSQdLihdNHSwZFpHiWMyVqWB?=
 =?us-ascii?Q?gFrwJOg1HiMgV5YL0MWGUiXyJLGm6LGcc8G9bOm/IKRsY5tJatqPFBlCgQVW?=
 =?us-ascii?Q?MdOoZnwUa36GLjeKGeZAo8UDA054p+hD/4NSdIk2exbUS4CZY71qMTTQ5a9h?=
 =?us-ascii?Q?F0mCsrRVSlqxCoAYNAhlKB/WMi2ChcYUhWMw+/obuPg7hBCYHUPnlsHTW7a/?=
 =?us-ascii?Q?ggnOqfsau0jrC1Bma56lZAuGwyEureYk/GNeZwF7/wcIKnieaaovOu5KD90m?=
 =?us-ascii?Q?qYGZLR4PYEX5d5O49tL64Pup13aUkNqYZXY1qhc8cEUlPfmMaacyBV0ZLCZF?=
 =?us-ascii?Q?uavA4hAB/+xgnHxkpFGQekF0tAJX1PnkU4+Yn5rKAd5c8sG2c+I9GtlkNhCx?=
 =?us-ascii?Q?dsjBoCPYZic8fdnBw6xXyoGlRQc4KA5GOX2Q1zHrUKSWG6dTAGYzEb2XpIgR?=
 =?us-ascii?Q?PWoORCB1a1J5hX0e9FsNY7GWSGdc+6K4Fyg+XQV9YYUMpTHyRrQ14cEsjiwy?=
 =?us-ascii?Q?H11FBsrewSMRJ0GWSJpYEAwpiwviooAT7qzayFdp5S+L6mfAd1P2yGk6Dii8?=
 =?us-ascii?Q?0hX8t2Xa8/wWqumwKEADowgDnGZY+v/DSZUIJ/aDYDPQeySctZEtYUFce5tC?=
 =?us-ascii?Q?Uqw9ulsuWgzvVlIq4KgJ4IwpFD3mpSrZiUQk5t7zngB7D2aZuovwyRXILuWW?=
 =?us-ascii?Q?S6lCtQiUt3zacbPhjHjV8e9QL/sbg2hfCq2xkEjsYb7zXWq7VBjHwi6bCKco?=
 =?us-ascii?Q?cDVRY5RZALy2U+PzJda3PiavLJoiLiZmLLjTrCjZSFUA96ZHwfmYh2a7VLEa?=
 =?us-ascii?Q?Zyz7oZQg7h90DdQ80QGDUS06iM90f2gA8w/TIuGeNoqsuCmlPHagYIe4BVPA?=
 =?us-ascii?Q?2bDvYivbViG6k+MipM0VRt8WgBP/Sv0TPg3CCcBkGciX03WXuOgEAgP4yeJC?=
 =?us-ascii?Q?/ouoGVEPyd2JiOUtz4dYWSWLUXr4a7zG3Gr/WJpsvfsEjp5TfHiNbPJ22hnk?=
 =?us-ascii?Q?loZiQePaU2PsBoWhrBw9XKPts2pjPVGkfMtAn6NhNv5XYottfE5cNUmHeVuJ?=
 =?us-ascii?Q?3S941jnxXzN6zsrz1D5h2uyrgydsoklrzb/ILUKuNHrBzLdYibsjbU64DfPo?=
 =?us-ascii?Q?sIJLeVdvJl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8211.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gmrFZSvpN/ojNXfU2UWPK+jkwrYomO1lm75QLpOygXvM0wS7L2lXqD7hmxhA?=
 =?us-ascii?Q?V6WWVirMhViHDquLHIKcaPLBLLIpKy9QX+37XdUFYY1O8uiM1NhjKPPTMlaK?=
 =?us-ascii?Q?O9nwNSp/7hY8KXTvrN+qfiJld42ro3fQbD1nifm0Q+Z/TmE30h68miNMlnXx?=
 =?us-ascii?Q?DQBoJiOapaSoFzFUIc+Qh+5bXxtwNBp7iUER6XoeN9Plbge0SO99E6hm5mlc?=
 =?us-ascii?Q?0J3m+CfBqiec441UF09khc7Y3F9WbI76armxzDIq3Bn8LcXo8CtS7LLzkHWk?=
 =?us-ascii?Q?CpZezIRIpkzQaTOxkOL+xZ3rqLtR09C/9z26cDPG4wC6N92ZGBIdEyo/sIAF?=
 =?us-ascii?Q?zxXKWlQtsJwPidyHS9g8SOcn4QQtdt1z15R4ANfQo9yuXpU0ABrVkEdssXVI?=
 =?us-ascii?Q?oZSbPWezDTJzkkU5S6PzhuuvwV4GdzBzuJhAYudF83vtznYXoMVH1cemRZZl?=
 =?us-ascii?Q?SkDcGYdU6HFqSQ4wH49ujmtalRlttXYXZZxed2fKF/9++3ZDCX0KG0SR9wm2?=
 =?us-ascii?Q?rAQrLGRwID7MhHUy+tZOh9/CQuZ9GEBOPJR1X/5BifQ5WlcMGOkDV2BbETww?=
 =?us-ascii?Q?jRC5/rt+W5H9/XgcUn6a0IU2akBO8G7rbr+8r6aHAEXZDyaGB2qPNK7Vtnam?=
 =?us-ascii?Q?py7yi2mM64gHy+XiY/ObVUn15k59exCrkbcqZe9Jy0Q2PKfVYB+FnGpPIY78?=
 =?us-ascii?Q?7QKW22tAjKOQHkwr9MkytFJgTisjG9t2En6yxn5z4cDT5I5pOvZoC8cYef4b?=
 =?us-ascii?Q?NfjnbjVt2kQ4hxSQtOP44g5eHy/oMmsJivfqPsXKeHwcV+GE1q0aQ5ULScd/?=
 =?us-ascii?Q?fQ6aBCA6k/NiGs25B9Z6/CWhDSssHUd9A+9BxQblHzlJoeDjsGa13ptMKk7R?=
 =?us-ascii?Q?Y6+s8u6ctGXnwvS3MMeOmhnCPSSLyYR2M1VWVkH1vO2TezwM4aUr7XJhj+YO?=
 =?us-ascii?Q?jnlMX7k6g2vsYWVUs2uRJQwCSXvZKvMkg4Kw6Lo9wIBjdu7H4sRggque5U79?=
 =?us-ascii?Q?dYgAoKFb1j62+xQhvxvLB8HuZc/+eGYJc2sb3H/QSpe99cFPfT4XnaUIw7AF?=
 =?us-ascii?Q?ipQCYCh9HxtLtCj2Fj/vqPBhoWSas8S8/S/vReD/IQWElRX1qF058BGyKNJu?=
 =?us-ascii?Q?Ii8WkhLXTpHP5DzJeBxj4RCGNGdSFBey68c7BjWQfGiPr1ZxcqybV6IYSC4l?=
 =?us-ascii?Q?FkJc/MvvR3UtYMoF83xtuZwjy4Xo6IU5FBOL4QtBU8q7Ml3uFpsAzqQtcEWi?=
 =?us-ascii?Q?hK2zT4lvoAwOk/xi4/UlJHnMkk+nNocBwr+ZhN6AUQSeLsbk34e9s2xlRWGn?=
 =?us-ascii?Q?IumriBaCe6pzjgvF11euDfXNlXzMmNuiap1i3q/QKrC41h8kGX46/a36ABCP?=
 =?us-ascii?Q?A+BLO3ePJbkKIuAKxL+qZgD+sbrTNOQeeufRL8s5xRojKy0pPQIS6JtKRfQ4?=
 =?us-ascii?Q?ZHMAAOO0DwO9T5VqeTA2iINeDFMxcRd1NaLprj2sd3bfdNVAzIiv6upBVJiS?=
 =?us-ascii?Q?YA45J6nmEgAA0MqoxM7tV3leSXnJG8k3CRUegIVaUnNmumLdr70xQjNt9Cu0?=
 =?us-ascii?Q?MJHzyFj1J+FZ/Ye8CLv754FkZCA/72iMQ6j3YPlg7yjJwY9KnT9d4IKO8jse?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y7GNUvCDZBWFub3ywCi8xfPE8ECkrJp+KuFvibz36GLg3gbYftkPd3tFZY8OJOIgS/DUrw4cYsmTpXhD4zh3Kkn3F4eJbzlh5Rc8RDcJOOA9RBIl/V86tdvocF+Z4UPYXcpQK0j1fZo7Lo25y9UElAUgtnV1GL+kS4YR93tw+UQ3aNKc6H2x6jxyrcnyIz5fbwzs1g730QU/tt7Awo/AwanEvZgGfvWnV2MI7dcJBW+oz6pn5HQJoAFbbHFdBv9TxkPmUATCvI1ihlEMuUR5T/VwSY4grkxrACII2f/5KaDM606tSr0cmblz3N6f2gVxFbUxXB9DiUzgvOKpGVthamKu2cFGDPzqoBaDn4+HcL3cZzwkY1EbqNBi7+kOW6/ohTNHvtPqN/sQge91vmrxdCeIhZHP4Ihuz1U+7Ga0B00hR9XBIj7QwN69KO3J9gjTozFLEAjK2clgRtfFP3kTMQIt91XyFcZvprS5dCrPU/93EmbO9YfedA/7LVodRRrjxd7rBQmwzKvHOhKg3gP6FR3BPztZKA+cDXECQjRfYKRu7Zf3VKs9oTu3LoYPbMy4a2w0GA08WiVnpraz2npLU1DJPWXsx1SLiCMEnTAWjwY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe325ff-5e49-421c-61d0-08ddb5dd073c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8211.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 00:45:07.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ennLq8b8qSaCcV3HWPCy99jQR1K9FNPSYnjtNUByjYVvLyvOIlgz85g8mGWD6HPqW2IZkRsCXAKwmcyOeJrwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=978
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506280003
X-Proofpoint-GUID: bxN4YUIPGY_9puHueg3XDWFWa9B0KkUZ
X-Proofpoint-ORIG-GUID: bxN4YUIPGY_9puHueg3XDWFWa9B0KkUZ
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685f3b16 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=OdtpqN1j7cOETiBu9_AA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDAwMyBTYWx0ZWRfX2JKDn5ejBuKR 9SCNSQSvNxyQQZ2Hi8KqJda9iNZ5Fsys8o383MAGGhysr7zSiG9Jg2mi8EW8gk2hVM2VAUWbUov dHGk5S+yCEJqqoGfJCmm4PXNeAoCWvPxqqkkX4A7bj6LVLKv1jUVhoieHWg3+ZkfkeeQDGLNlNo
 uLZSgR4aRn1o6v75Zb68OLTik5M6l5VeIvrONZjvTYwOthPlsY7gsAefLNrV0veAurSoIOePJvR 4SGiHUFscUfVUhl8AMPe7XUiPjmhvSDO75HOtOpDB4YBMmbWETWGmMkESFbKBCQVDda0XluLVtO YfZ+AQ0w3O0or+9lFQ1S3fiuIY+woIjfADWRwtFFAJigfJdXpkeKVvWFrEmebvUJVIpcAxHk5Zl
 SfmUR9B4O9tAOnx0cFiAO/UvqeA3hq7uQVfrJhyQxB3xseUevvaP4NmUClXuvWPB6/D2LKYI

On Wed, Jun 25, 2025 at 04:30:09PM -0700, Jakub Kicinski wrote:
> On Mon, 23 Jun 2025 11:51:36 -0400 Konrad Rzeszutek Wilk wrote:
> > With the value of 'supported' in them. In the future this value
> > could change to say 'deprecated' or have other values (for example
> > different versions) or can be runtime changed.
> 
> I'm curious how this theoretical 'deprecated' value would work
> in context of uAPI which can never regress..

Kind of sad considering there are some APIs that should really
be fixed. Perhaps more of 'it-is-busted-use-this-other-API'?

> 
> > The choice to use sysfs and this particular way is modeled on the
> > filesystems usage exposing their features.
> > 
> > Alternative solution such as exposing one file ('features') with
> > each feature enumerated (which cgroup does) is a bit limited in
> > that it does not provide means to provide extra content in the future
> > for each feature. For example if one of the features had three
> > modes and one wanted to set a particular one at runtime - that
> > does not exist in cgroup (albeit it can be implemented but it would
> > be quite hectic to have just one single attribute).
> > 
> > Another solution of using an ioctl to expose a bitmask has the
> > disadvantage of being less flexible in the future and while it can
> > have a bit of supported/unsupported, it is not clear how one would
> > change modes or expose versions. It is most certainly feasible
> > but it can get seriously complex fast.
> > 
> > As such this mechanism offers the basic support we require
> > now and offers the flexibility for the future.
> > 
> > Lastly, we also utilize the ELF note macro to expose these via

.. <missing>

> > so that applications that have not yet initialized RDS transport
> > can inspect the kernel module to see if they have the appropiate
> > support and choose an alternative protocol if they wish so.
> 
> Looks like this paragraph had a line starting with #, presumably
> talking about the ELF note and it got eaten by git? Please fix.

Yup
> 
> 
> FWIW to me this series has a strong whiff of "we have an OOT module
> which has much more functionality and want to support a degraded /
> upstream-only mode in the user space stack". I'm probably over-
> -interpreting, and you could argue this will help you make real
> use of the upstream RDS. I OTOH would argue that it's a technical
> solution to a non-technical problem of not giving upstreaming 
> sufficient priority; I'd prefer to see code flowing upstream _first_ 
> and then worry about compatibility.

The goal here was to lay the groundwork for another patch series that
Allison had in her backlog which was to introduce the reset functionality.

Let me work with Allison on adding this to that patch series.

> 
> $ git log --oneline --since='6 months ago' -- net/rds/ 
> 433dce0692a0 rds: Correct spelling
> 6e307a873d30 rds: Correct endian annotation of port and addr assignments
> 5bccdc51f90c replace strncpy with strscpy_pad
> c50d295c37f2 rds: Use nested-BH locking for rds_page_remainder
> 0af5928f358c rds: Acquire per-CPU pointer within BH disabled section
> aaaaa6639cf5 rds: Disable only bottom halves in rds_page_remainder_alloc()
> 357660d7596b Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> 5c70eb5c593d net: better track kernel sockets lifetime
> c451715d78e3 net/rds: Replace deprecated strncpy() with strscpy_pad()
> 7f5611cbc487 rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy
> $
> 
> IOW applying this patch is a bit of a leap of faith that RDS
> upstreaming will restart. I don't have anything against the patch

It has to. We have to make the RDS TCP be bug-free as there are
customers demanding that. 

> per se, but neither do I have much faith in this. So if v5 is taking 
> a long time to get applied it will be because its waiting for DaveM or
> Paolo to take it.

