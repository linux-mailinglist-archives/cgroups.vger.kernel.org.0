Return-Path: <cgroups+bounces-12038-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03348C6327A
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 10:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A723F4EF203
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEC5324B31;
	Mon, 17 Nov 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rIJOq8QA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eyBRohEQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51831A07B;
	Mon, 17 Nov 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371140; cv=fail; b=ZCv/yhYdYXw2/Vy9Tm/Cp4Xej6S8H97gnfwnSKWcQ16U4f3hq/VX+UzUDa/QqceRF8RxWQa6REFnEOEoktbmVlR2aMmxWI2XwAtBkGsC1oOVHAfs3gxw5HNdW+4obMpQUO2bZX9m+SEEjkAbslFMXNozG9q69ZJvOw5Xook3iHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371140; c=relaxed/simple;
	bh=3Zr2RuEZBNlC5DEuC+l1k7bKuDRr4wS6E5GoYkuIkGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/oPDblJO9dyQK8gKRnL5bnoRBrWDofR7Wmx+fSYIK6PDBoosra58q3neofsug83rs2gvwMzj0FsbjBJCGefH7fVu1L3pDFuhPFX2g3pHhfRyy1qvOdF9yW1sG9flo5n5NN1N/ru+XPnFanjm1Lx7PLXXyinPHZyFZh3GvKKIQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rIJOq8QA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eyBRohEQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH1v5wM002074;
	Mon, 17 Nov 2025 09:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=E3kUcMm2lKplGf9S9H
	uyydxU8gA0dIE24AwcntVXoFU=; b=rIJOq8QAtrJ5N+5XQ+CFj5ZBpLwZJim2jb
	9mPiDf45OmkuG7cNwDIAYbkHrJRJbKT4CqcLoh29599FaDDyo92OCO8V1X82UsTY
	CP92cO41hUp2hOMVffV+hpGVr6XTWnVkUtd33Y+QB8yAZSAc1zturBO2KRb0r+43
	S1aBwYvGV+gJBMJ1PBnTvPrk/BD2miowscMPgEd6GSh6wW8PfnVln2z9CemiXyGo
	tl7dUb3HrqoM2qYiYpnJW9rk1ATs3fER1Pue4/w4UG9pVkrEB5h3V7sTDpe8rWaH
	O3xcIUP6ftQL14rnW/XCXT/+6iG7jBuWky7Hu4+9IoxeWGpgeSeA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbt2vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 09:18:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH78hA6002488;
	Mon, 17 Nov 2025 09:18:22 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy7e2sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 09:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO2Y+E+QCgMvnP41Nq8u+5P1NSoRRuIO5SfkFR3880wrGg3qVZRnu1O/X235ZLCQGDYFWNJXm5U1SiloSzBBiV6Pzwgb3d55Dm7aJyB2JADlpT5MuR5Vo35vOI/aF6vuHD+PsOYEgehkgmXXEWKM0GdmuuXy+AolweduzBKaDZ2i3XgTYF7CXdEqPmRLra6tRZXCL3f3bDMhcJKcrbFzdnW/K5kSb3pT26pOr4UKt8yEJ3G9IfdED9saUGcKgyxrJPdi6TJEBjj4X24zj+b9tmjiKOZ9jBczEygOLhJ4rzGfNYlgjXrAnWKY39XIn+DdeS0dkZIa8w1tE0C9VBgnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3kUcMm2lKplGf9S9HuyydxU8gA0dIE24AwcntVXoFU=;
 b=L6HigS20q55L5aSWdnKYtJSjZzMZqDQr7wnCwKaDdkdGVr8MyqYJ8OgDqIWwRFoedy8gUaAmV89Gh1/kEz5FdW/whkand7d2ukiWQXUZsyH/yRTIsph+EllWQb6nDS1+cML6n69dVsET3I7eTHkVbeVQd4xd32+/BIKxRSPsNYqHgvb44oqJytPRT5PWZbRn6Ak76uZ4sOriSVbK+3SNDLM0Et/9UTpYjfbzvvJNV7/ziMb+c3IDsKJHfmPX2wo0ejqodwdHeF94Uk/u/jVRjPsfEmVYqErEQKloZ7rabCrwi+RS5GjFvMMlmfWGU5DcFW6F5VtAVEgqTtWLbRgj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3kUcMm2lKplGf9S9HuyydxU8gA0dIE24AwcntVXoFU=;
 b=eyBRohEQ1dPeZvBYy6cbVogenBGufSzSgPvRRqiMVWrqbnvjMRWvsKz5IKPzNfRIoelBZ52PtQu7b7dD2kcWLBPAhECIxky9N/g0fWJm6APYBRH7KXupvBdtac65IX2rNfc4AduSbeGsc2NLBDQdt88SbIxMCaQ9oyAqqH4MG+Q=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH4PR10MB8193.namprd10.prod.outlook.com (2603:10b6:610:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 09:18:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.019; Mon, 17 Nov 2025
 09:18:00 +0000
Date: Mon, 17 Nov 2025 18:17:47 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 06/26] mm: memcontrol: return root object cgroup for
 root memory cgroup
Message-ID: <aRroO9ypxvHsAjug@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <5e9743f291e7ca7b8f052775e993090ed66cfa80.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9743f291e7ca7b8f052775e993090ed66cfa80.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: TY4P286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH4PR10MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b4ea99-f91a-4d61-32a7-08de25ba33d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mP72Oh1Rt9tGGUutD5W/MV3JXl+e4RyBfLdBPtVysuF7z43qDdWAFGnQ9CB/?=
 =?us-ascii?Q?izxYPeb/pMActscomTWjTamZ9gbCoFMGadAwDdBdVPSPvnOfdYbPuwUBgzwx?=
 =?us-ascii?Q?51V/TiksmHwe9xOSernZxu3V/o5HtkkaYOFkQls0k1ymApgiKKLEInBdZsYT?=
 =?us-ascii?Q?WEJZAY/0r0hqXJqQOEDaptJ0AJQ2YjHudEsLQYDvh4C1myRbqYSeVWTys9gq?=
 =?us-ascii?Q?YRfZtnZ+WCSOrt0NM/+5JEBWL6gnbwWB346J7Hsco5yhaMZ6b6gz/w/Lx0yk?=
 =?us-ascii?Q?/ZfdcKZGzb7AC/85ppw/uzFnXDgFNp87iqtJoBtlOG/c/wPUrfwngGrU/A/5?=
 =?us-ascii?Q?GcLxA6MtFK7UrzejYO0u9cYhbfipGF0gkq10BEG1+TEo8KzbaBBHBpy95KDN?=
 =?us-ascii?Q?VfU4anD/sGUo4sz5uf+Z2OuKbk3Fafsf2iSu1OiPO22P5y40rN7JTsqtqAwO?=
 =?us-ascii?Q?yvRLtm8pVE0ivk5rnoaStnMOJezzEFAEZ/lWnXD4bFqfy9URzU/x5o4tNm7n?=
 =?us-ascii?Q?OMh6+ruqDODZ+wqZhGZD1B4QCRyr8ysWcKpArgN7sl8gbLFBT3TwB8EsdHlr?=
 =?us-ascii?Q?yTojWAW61CELeX12qgAujgDPb1ViLYG+U53VRSzRXSJtD7z2TmyRioHEquFk?=
 =?us-ascii?Q?3aNg1WKKiaVlmKy0jRf9grz7ZF5xhUwtfmQFAWvdZf7tntTRoheXGuIaz/o9?=
 =?us-ascii?Q?INnK547uXH6phBs9H5VX+ybmVWqS+LonwW/UI2sMxOQWxTlFKcboibWQcbd6?=
 =?us-ascii?Q?UHbeb48xk9i8aWWxgmlQe7gSYnlZg0fk18z7wgfmW/2BhKdS124V/LRf7b7g?=
 =?us-ascii?Q?/fQn0lPxTOhKNDJG1lQgY/5NdBYnnhvrU7hI7d6hEuE/BRKqJGOtg/yLeG/R?=
 =?us-ascii?Q?d7XUQs+Y076qE7ZJGr0jOX8Yxo/CwktM4RnRbje3RnfWeSS+0aSCOck99znE?=
 =?us-ascii?Q?HeimdEZv08svH46tO/979FSFTHaSy22yNfj2RhYEBBvOcSspiqIItzsSYpQF?=
 =?us-ascii?Q?P7OcwcMUsxM9gUFgKinkzyKxafgfleK8D0lR461k6xAoQTELxLr2YPDno2EB?=
 =?us-ascii?Q?VdM8sctr5tZAUUqyueoqk9r3UPU+xdT99dumzk308Xr+mPv/EMvpa36B6bnQ?=
 =?us-ascii?Q?x8HfPY7L0BM5yjFV9F7MxfX45oYA6Cyx00MXdGlcCA+Tb7Av8SYj77kjcy/c?=
 =?us-ascii?Q?Sj+mgz1gl++gvotGXOLLH3LHwtT470EwEX+X7M9glIG3gBHBYmLuKHkffkG1?=
 =?us-ascii?Q?kRLaFJhh6tjQ9pxR+YePItdiL+vfGG+WNGQFXxvLc5Aag+zd4m9Fm8neCeV/?=
 =?us-ascii?Q?3qtnNXbRkbVTEIXT1+g99tpw+FvsOodwjkiGNck0wNx6eRK/xHfW5wdbOTgf?=
 =?us-ascii?Q?BToAeiE93E0NUcITWqIfl+4wtSbwhkmvVnWAG+tyBFPE48G78IyUw8jsC51r?=
 =?us-ascii?Q?q6ZJOB5tVg4FIVaMkRvL0pcGSOaxVSgZ016iSHuuSPz8S9wK7CIkjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GOJVDq8rACuD7UjdeDVVjdY/O1Y/ppFOJ/Ee6j+h6lg2SBHsGFvrZjX5KBnv?=
 =?us-ascii?Q?WyaoQgFTY+t5Az3pDhr7cqyhbloSbQKhO84pX68sUr5xcw4nvL1CZIxKMA0+?=
 =?us-ascii?Q?I9V5z6VmY68TUOHJn/ZPnf4j4P7ajy1+rfcCrZD2Ui8WWtI3Gsvsp+Md+7Us?=
 =?us-ascii?Q?ve80bhTpNNABWPAChmhG5OhbxOAT6Lxet57dv92Mt7/ZpdfmGkMHdERXnSn4?=
 =?us-ascii?Q?6dkEeRDMIyiBIGBiEYy/pBqwxkV75fB9lFg5tz/ZiQ889XK9XVYiJRcZm3s2?=
 =?us-ascii?Q?hDEQboxQyOV+ICF8yVGrTQnPItfjr6bDJRY4K/fHX24YtU12Sfgl3doskMUu?=
 =?us-ascii?Q?4AeRKrREOIbz9MxkmZLaPBh7o9GN7E95Lazb22ha9ib/wbI4eLs2aKeti2/8?=
 =?us-ascii?Q?aywSuOcXd2SP/vM0WHCVTM6RoTQK1c6gqY9hC9DQXEn44bmMwjXOoTmfmzwa?=
 =?us-ascii?Q?3cuGeqHfRTouwDzy0U5gdWSn3XNBoU1AMBL9iYZlrwdrbKDhUjJLEAYXjvRc?=
 =?us-ascii?Q?DhKVsexDF94xvrPlEIuUcHzlJnne9TdP0Q96v4kyIxzGMuNBIQk/SumCZYRC?=
 =?us-ascii?Q?Sunw30DvxC+cG+AzR1KNX/kdTNqHS5Y8y8Od3w97QYu1J7GRCeaiKTq/jZup?=
 =?us-ascii?Q?ZtywyRhxDNNvQimhvinKCI0D5Bip4D2YNAompf8voYlfiIoUT1g/9LGIZ5sJ?=
 =?us-ascii?Q?RUQLPO5sDPl3Sa2KuDZWlsveCewksnuAgD7hfcDOhTAhKNHj/x/nkOsQBZYF?=
 =?us-ascii?Q?qOFufZRmJb6dYewm8p9GVFJVs8hZHnTxy0WREX2aENEJrlo7BvSfInzA4t6J?=
 =?us-ascii?Q?6SCD1XcJAFP9oQFE4k5I0FVY9n33qHODIQMcJOfiCMuUEUtjjykJTxy0ZCN9?=
 =?us-ascii?Q?3dtNBtAf9gPwg7+ztebhC3aobrFs8qkp9iZlNDUgaO9nHXBRJpguUtxgeDZd?=
 =?us-ascii?Q?v9fI8ZITUPh/gXBaxj20PzabB/3KbI0i0XaCo/+3OBILw4lipgmA0jtCNZAT?=
 =?us-ascii?Q?W+yJDv5SiwyuE0OemQIDkugdEBWMpW+meUwLvReraIoUza24h2AAOGzPFKiy?=
 =?us-ascii?Q?TQ0uvadfemu1uVYLmEYwFgDclzfvJoUXGBmbpIenvs1xO03rtBPBOVV9sweL?=
 =?us-ascii?Q?2ZOvl6qr8rXHKlcsN9UGsWIk844hkBhJSNAV2zKl8sHeJ2Aca07+5poebnge?=
 =?us-ascii?Q?eT8PgCedMznJmZYvUY/aG1QudGHAlwDY1cYyG9T1rpyVRg9D6TAR5+eOBtMv?=
 =?us-ascii?Q?3GsJyP0zZhTqkv5KYU0frPU4DSfGQ+5SuXNW6eCbZ4Kn0hOAkvD1XsuL/ld4?=
 =?us-ascii?Q?+ZYwr9+CY4diDWmZ1IQor0nUFndTTVFURMbC/BhL5DNMsbKORwcZ1wWNBVZ1?=
 =?us-ascii?Q?JceCSkBH4FAuNRMRJ6seKl0I8v+PJPeUrD7CNuIc1X8jI9D1hiwoCpgoxcwG?=
 =?us-ascii?Q?QYgNnzLPuZO21KWTsP61LuxELzdoE7LtIE84NuTfNwsesB+PIpoyHrkpbwUq?=
 =?us-ascii?Q?VFDFtFzhF0HtkZogg8w10IadEJGluzwmwqpswF+tq9vhI3cGn8hjCWITjtl4?=
 =?us-ascii?Q?BJsL2sb+GI11K1CEPB6puT+Ac+qPVTPH88QmYyHp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aFNJ7rLw5yNkLSeMFX/0ay6b/wAn/kUd0r59rW8npOGoA2jfyU/ov6H/YMvjd7Zg/PiNyYBV0RvX0lzcIgqAW3s0GkYAK2qA6M2F6YbUlr0IEhidDEfS/t3VDc4itPnEzaJYRqv8TWnBLTqF5BKKXpXaZQ0RE6+08PVKLIbe67QUuZFm4Z3GSg08KFUKSliBhfHccm3e3JiPCq8zogCyr9RIi+v00nYS4ss56QuIrme2/72OElDZ2wlpCb/N3HYruzm1KlVbcGFTSgo0kLoJQZaqnC/ICN8KfsZsbCyoPiOHSiVGIAvzawHog0WdSw9hlGdyZRZ9LjgCMuvhfXUT4ZABlaZ46ASeYYTw2nl9kwzw3Ikapmn4ekbNU7oUpPCFqN2t3f2upka2aXN26YRVGqmdVnSKcYhsfQEW+F2ssAiMdMZkgV6CnaN3rrWONCheyX+alVSU83Qu/za41VKUfHeQnizyIYtYodvzpWVxeLSMAyFNVlwAESS8+8UYnHOM4/7DiWyBJKrZ6g/i9IP1VoYLXFadhLqZujHlxDfSWaPzvSZJ9/J2tg6w1ICOH1irNrOPvXeU4hv8DGBmoYidvomNu8lIGzIah7ve+jHFFN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b4ea99-f91a-4d61-32a7-08de25ba33d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:17:59.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIaEWTZcM3ObsvEAYIFyqFTySClH/1+mUueZl0FxFakfI0YEabF2Jkpxw05cmop2kMmW19tLSCvurFeed/9ebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511170078
X-Proofpoint-GUID: PO8DDd2VH-qOszCLiN6ClnViL5Zmtiw5
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691ae85f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=ucnIb7OGsKaiW_AsaTYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PO8DDd2VH-qOszCLiN6ClnViL5Zmtiw5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX1bUqiwOhf0kO
 NwYqVovVd6oxUTvWPDUKVS+i0mxiznfUtT+31X5xJLsQGOqK5/oITmJ+jx6l7ISAI7aNcDC9yAJ
 Aip9LvRDFAAiCaTgGMkPHr7DkhNlx3vdEWhCJI3x02GBUEQxDV+POR+EQ+BvZ+JzrLoeUnthxPi
 zRZTjucbjUD3CdheqXNudCiBb7mZsBRIj5UjrxjpeyHPuQOKfsf8YKqdRkfNttsJ9NFTiBh49Z/
 2XlMDYTiya8CBsgRZO1OZrSSWlvrgoGdxW+dpPplERGT/aOJb0P4A50WqhPcl2ai6LZ0BaIENn5
 qNBtzUxMTd9nUgn7wA4M3LfQgcownBFzwOStn8Zrn5lKMVqfCBu129OHkixP3sD9tu7xlvYOXBX
 rKc+wREpjEpDFx2HMsCj7Y84imxxUg==

On Tue, Oct 28, 2025 at 09:58:19PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Memory cgroup functions such as get_mem_cgroup_from_folio() and
> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
> even for the root memory cgroup. In contrast, the situation for
> object cgroups has been different.
> 
> Previously, the root object cgroup couldn't be returned because
> it didn't exist. Now that a valid root object cgroup exists, for
> the sake of consistency, it's necessary to align the behavior of
> object-cgroup-related operations with that of memory cgroup APIs.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/memcontrol.h | 29 +++++++++++++++++-------
>  mm/memcontrol.c            | 45 ++++++++++++++++++++------------------
>  mm/percpu.c                |  2 +-
>  3 files changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6185d8399a54e..9fdbd4970021d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -332,6 +332,7 @@ struct mem_cgroup {
>  #define MEMCG_CHARGE_BATCH 64U
>  
>  extern struct mem_cgroup *root_mem_cgroup;
> +extern struct obj_cgroup *root_obj_cgroup;
>  
>  enum page_memcg_data_flags {
>  	/* page->memcg_data is a pointer to an slabobj_ext vector */
> @@ -549,6 +550,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>  	return (memcg == root_mem_cgroup);
>  }
>  
> +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
> +{
> +	return objcg == root_obj_cgroup;
> +}

After reparenting, an objcg may satisfy objcg->memcg == root_mem_cgroup
while objcg != root_obj_cgroup. Should they be considered as
root objcgs?

>  static inline bool mem_cgroup_disabled(void)
>  {
>  	return !cgroup_subsys_enabled(memory_cgrp_subsys);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2afd7f99ca101..d484b632c790f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2871,7 +2865,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>  	int ret = 0;
>  
>  	objcg = current_obj_cgroup();
> -	if (objcg) {
> +	if (!obj_cgroup_is_root(objcg)) {

Now that we support the page and slab allocators support allocating memory
in NMI contexts (on some archs), current_obj_cgroup() can return NULL
if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi()) returns true
(then it leads to a NULL-pointer-deref bug).

But IIUC this is applied to kmem charging only (as they use this_cpu ops
for stats update), and we don't have to apply the same restriction to
charging LRU pages with objcg.

Maybe Shakeel has more insight on this.

Link: https://lore.kernel.org/all/20250519063142.111219-1-shakeel.butt@linux.dev

-- 
Cheers,
Harry / Hyeonggon

