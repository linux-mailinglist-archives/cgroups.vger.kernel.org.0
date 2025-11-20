Return-Path: <cgroups+bounces-12118-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A81C73558
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 10:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7594354277
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E17030E846;
	Thu, 20 Nov 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mm5s0TDu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zYIQFKe+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0452EFD81;
	Thu, 20 Nov 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632528; cv=fail; b=nuAIqeqquR3b29Kobg1XhEwXah/IirS11RZPSFUZ8RTPmDN6HoSX+JCgc9CxpFBJ58qW2V6rIG7Y1eZPRvfNBkdhwWGGDSksSZrFnkIIjO+tHj9+0j9dbGAf5iIZLpXsRyo4xPJYErT58tNDD1WUiCot6Ukib1zNUBhvc+MtWa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632528; c=relaxed/simple;
	bh=RhQSK8Eatz+WDMz++X2gsKkwjzwocjqBhnqYlRSs3bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l6ggbJm/p046thiToiL10fNXUPpyDkkai68/mJFKfYDM2ZE/trSfrtCYBSRbKbyOzK6CF+sCdoPP5HxUxW0IhzT8CR6Hh2V9usz1UFwsQtnG6pq4Mvvu1VjaBAF1NJC5vJXcwFK8i8nixLVmeZPYpWfSKlycn8AdMMZX3zVbNVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mm5s0TDu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zYIQFKe+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK9Ae16032582;
	Thu, 20 Nov 2025 09:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=igEWjqpoev/IxPCvLH
	qhMxcZDsXHU/bd3VQ6KT9IMIE=; b=mm5s0TDupsrzSi3tldZBwvPqrVKS3R91h6
	rXNsw2oDJAWkUl1JChV4wPUWbrZJwWdHhE6GIivl1bpv/eNkEji6+py0xNP88foK
	zXHxhoTYCGh2tJRvoNbw/qvecnSZmAN0aLL09/5EcPzNsZUCrPm3s3Ibww23IV2L
	JzkZrbWfJIGJW0vWSsDKjvWHcVQZjJeUNo0FyBX6joGqgWq1hAQ7Hda9Ymhi4dsl
	86QiZwKvMqc6hC47rA4b4dyd14yXOGzq1X4Edx+17bYZMCrj3c58xUEZuviXI/QT
	xIGrAd/bbfCtUeGDVByzxUmWw7HqFxClIXD4OfWohTcM3SiL6HNg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej908uby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 09:54:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK8vb8H004341;
	Thu, 20 Nov 2025 09:54:57 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybk0r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 09:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9vrgjKtVBg/PY4vEGlgv0pg+o7XdLNBunx+oYbJ8VC3HPgh70NsrRv8pV6Edacw07zLSqbYCcugfJvzvz+vH+MM+dOl4h1Msd/Eyx/t3YC2EHC2KudL55OpG/NDN9NRPSrVAzh4mzCxt2CKDhuTOEZoup/c0MpY62fRfwuZIXOSxxiA69qnVzpxguAAOusr38u3CWtCwhLvGxhIzdf5vyUCgLLYNy8dODpwIJQsBIe43HN8OzpisOt4g4pTX8eW/ZzCpxpqGL9CMP/NkQwhm132hhDwE63K7MR/0uEJ1oU4yfV4wvGPzYqRbPOedpaeWgTu2F1Lbdq8OP5zU0+5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igEWjqpoev/IxPCvLHqhMxcZDsXHU/bd3VQ6KT9IMIE=;
 b=M9iEfLF0RN7hgRAdxOjRBYJ6qALTjlKEaIoXslEdfCxepSeJtwuD8VRt7t5BNHJfdgx5iIdri0O5bwKeRCFDhhd9UEEBiOSF1Cc1IeoxHO7P1g3EaGbt1HeUd4x/nxnlRX4lMOK2uO6mfootwPNJ+7OsOAslIkf13NY2YSuVmQ/f4FqnCZbuumxGpXN4eje4tDt2QdWoDwReHQuLee7FG4zwo27jxBsou8hl5bNapiX7lgPUNVNMi0MEmp/dy0O2uvEcku0CUj4imviX9/ahAh+w7OkyVhzFo3HdaCn8xHaULmtCOnTDiSyqn0596wBLNltBAzAxHdCgb7NMXMBWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igEWjqpoev/IxPCvLHqhMxcZDsXHU/bd3VQ6KT9IMIE=;
 b=zYIQFKe+g83awbrX2l+bo0Ic4jOzS16TiCeta8CGniCeY/zB1KqMCQdykHBBLuB4OK8d9h01HpZnKMGYbciqtblradkcGpaUNurUd3fWBkTK7Hp1yU8T9FYcM8+//hPUfJLeqs2Xj0KJ9pFfBqlWeInjWEBhr3fdugDNsdorY8o=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 09:54:53 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 09:54:53 +0000
Date: Thu, 20 Nov 2025 18:54:45 +0900
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
Subject: Re: [PATCH v1 20/26] mm: workingset: prevent lruvec release in
 workingset_activation()
Message-ID: <aR7lZdIHI44eZCFG@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <03a26f7d8723a42c29a24b03ed318a2830faff02.1761658311.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a26f7d8723a42c29a24b03ed318a2830faff02.1761658311.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0105.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 496dc0cf-146a-4f1b-daee-08de281ada54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7zrAJVecEeT9UTjhrRXfwCicOVlfzIkUc55gTQkI2dbOAMQM2EevmVl7p1DG?=
 =?us-ascii?Q?r15ALBZsGsWAdDELx8YPrRiJmUsdtUQagKK8/8sK1fRaG6nU97JE+gaDaDqk?=
 =?us-ascii?Q?t4rvhdxWd8jPgp758LrNFiHJ5mqucAJY5PnbnkqRmkrngcPTLKxnB45+s35o?=
 =?us-ascii?Q?fv6fIJz6s5rMZ4sNh7jIFmjAV099UmjbMEI/tR0/JtWGtOuxuZTYAkei9TXG?=
 =?us-ascii?Q?1TXS7HHv/GYXHrHHSbrfv+Vu1azLQpyvWVPlhXji99fGUT0x67BRmKtqDH/j?=
 =?us-ascii?Q?ogUU87HiFPIJ6tbDLmSTX9upoR6KYRFpqHamnJzM54D4ZPTMuFcL995g2IKA?=
 =?us-ascii?Q?PPWo0fGWYtEu6iD0Jsa4QzOtWQwrYod2FzlT9Rd4WUAe7ifGxE/mmHTnGTFF?=
 =?us-ascii?Q?KtOa9zIPWbymc0HW5SEUX1TPxyO1nmbWG1Jq26GqvIM1IjrQ/YQMgJdRN0B0?=
 =?us-ascii?Q?xLc41OO/+RfHXtefviquYMC3uwHNlt2oxUdr/TvKieFOXhUlgmptYR1vNSbd?=
 =?us-ascii?Q?3OSvT1kaR6YrvtIiPzQ/l6v8IC6LqGA8/t4YgIjiKYn0fW+jZ4pcASEPUSUx?=
 =?us-ascii?Q?qFMMisnlHEau1f2c5GrbNvR4IRKqLPMPEWcOWsVshi8xpFv61SC+PsNfXT6x?=
 =?us-ascii?Q?zka5tbuKOVSK9Tdbtk7ZgRErb9fm8T1kdObDlklDPkPAlxvTEhyROaHGz/5l?=
 =?us-ascii?Q?Y8uUuXAwfYwm4utZmEQT11sPqyHsi3vT51dh5qn6KpZL8s/hHwgxuEPjxdLL?=
 =?us-ascii?Q?eUHgBA6v0pVcUOVUn/gkytQ0AI8hOKY2S+ROqArR7hfiu7Ry2hwglKNMhrRk?=
 =?us-ascii?Q?z062YHZqZH8zZcYnRYHlYZdYh+m0doWS6pgW1TBh+LNh977PiIsdeIZ3wLQA?=
 =?us-ascii?Q?J40gwTe1YWR3va3FK0wd+VEmbRO7jX0+P8KNEmvodwYcIM819nr1a2SHUsCc?=
 =?us-ascii?Q?7DN10zmGvlilQ4sHEk3koZHcwIYMdO4FkS4DjQ/oB7SboWlhwWQtu4ET4Y6F?=
 =?us-ascii?Q?wu2XKOt4xx3pczmJf7s7jkCC+/k6ZWDQt7xoxd1Zb2Yj3CnVIDqP8HuB7AeC?=
 =?us-ascii?Q?GfAGqy2QnJz91aONE4KR3yut4+EfDa5AQWEpRzR75AkctjvsxaK3/vSr30ql?=
 =?us-ascii?Q?t1uqExX0acr6fw4J/fvLVjn79yCdfafm92A2ZaqYHTZUJTEU4CGOSN+sJlzi?=
 =?us-ascii?Q?KP5Iwv/qvEOSa/yGY6rQVeN7iFGWJqnoFeMPsEuJt4tC9fee6qR9wBfH9EoL?=
 =?us-ascii?Q?GteXRkhCfYleCXhFEhn4TbJ/Fi+Xp11g3EmQOgjNfvOKv0CVxJgiA4rkluP5?=
 =?us-ascii?Q?OcZtzASniOHOlI2LCekJMBEjIi3HywWSFYyX+QziwnbZr8FOvcVDyMTOePzK?=
 =?us-ascii?Q?fYL86UDR0+VMqL5DFD2O+1gSUSO/b1euIFihek2dRUYIHy0nDCf43im+DN5M?=
 =?us-ascii?Q?wpzarnIpsjwbLNk4P2xMU3voB+B54+I1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r6JrmoWnTtLW7gfivLrBfShJoEnucXfsVPUTS4FZ6E0zv3voMyVTNLqUC8lh?=
 =?us-ascii?Q?gB9lkG0j5leUgunRWcXc4s+ULp9p/QqnHNhg9DuP1jTLvXck976lRUt4aDAz?=
 =?us-ascii?Q?2G1jCFSZKWUlcf+XjDUIfoz8gonIIN1zfxlf4RDeVmEfciGOQuVNWc7ykaNb?=
 =?us-ascii?Q?kjLWLHnOiukgMnYLZn97CT2pHMOgQRAt0ZCsKl33t2oCp93nluTXiXBxRQhz?=
 =?us-ascii?Q?0ZkpgJuzfYh9VnfVV6uePlYIGOT1cTkNOxAf7eOPDe9EVAuAKj4hmtXWuqFj?=
 =?us-ascii?Q?yo6YddsHrCz76fTbKbhP/J5Z7WSGS1NQdyIe1FHIlB1wEt2+O1kwsEqqn/oC?=
 =?us-ascii?Q?FzRI5QQw5sgUBIXbCkmxfpCnQUHi7QJ1HrlcNMZdkFIKNTPVMaKPXBHz9aeB?=
 =?us-ascii?Q?HAqE3VJ1QrzWdnQY5Swt8QFnQb7zMt0s/nx2FEPpH9jnj6Lk0QniGJxngwK4?=
 =?us-ascii?Q?rAYqvxGIdeBFkX0M9D0XksekcmjvqGLLbzliXoHctG/gR7qQjc/bnW3+lFid?=
 =?us-ascii?Q?lLQQL39LEV8FpVs09YApSijqmoiXT+c8DpHfGx5+MPMPgoQ3IJ4eB68BrV4M?=
 =?us-ascii?Q?jSOhiJquqypk46aPyenuFBi/3/XsrqhySCb+4GsSUTP3phA7pk2Q6Nm0Bp02?=
 =?us-ascii?Q?DTMBAf0koM0Aqas3fWRpa3N1fT7PHFFCtkg68X3nJeZGXr485g042NgkUAa6?=
 =?us-ascii?Q?/UnAhqehGSltrD9Pm4f3RzwioGPS+v8X8u69V2GOGDCOLqsTColzd3dm2VOq?=
 =?us-ascii?Q?rJ6R+DFRDn/Q3FzQ62rxZ4qAxmzkBB9tfv5ovHbLex4dgwEsxwl1A6gsWrgT?=
 =?us-ascii?Q?tHA6BAl2buqPHGeMQTn6i8guhFlMeKJ16Et3WOaOp8NcFhEP9yLxSwXv0kWP?=
 =?us-ascii?Q?gXfGtmQIAMy7B7VaHy4kyrI4JbvCGQDIvKZ0xp95ByjiANIpXBMMyu2NDRVJ?=
 =?us-ascii?Q?KoZYqXTgk59I2fncwSycx11QbxQpSXj7Ox+QVScCy5LKxYGBdYHlXferNhEq?=
 =?us-ascii?Q?OExLg6qRXiRBVYbDvnrF5wFbvlTys7VJzDPKiKVSIZk836aoTUozFSLZm0yT?=
 =?us-ascii?Q?ikAQNUHwjQWrNadL86sSrPh/JQeWJmPxTWCH+8aS7piAIBWAUHxPw8aRoVCy?=
 =?us-ascii?Q?FAMpWVQTFQQxcY28NBtGrzXdPX+Mb2h/g5RdP5b4n4/XIQSQ3wXUCIMrLNrA?=
 =?us-ascii?Q?GLR1SbyCjX3/dHR86ucnVGB8q0zVB7VQX+9wsUvSsfF3pEw9tTKL3tuejl3F?=
 =?us-ascii?Q?U59gZ+Qr9E1F4azPuVTf2bMjU4ESdBYatkt0BcDkTx/8URKqQ0JqerZ3wqvr?=
 =?us-ascii?Q?Xn8Ftxn51GHm7qOPzuih7CX3nJ8uB68+gcHTToDxyTjnH5lXksJT6ZHe1NFx?=
 =?us-ascii?Q?S5iHC3agmWdDnone2u64ASPpJWJh0AGkK3E/fDgHXQlxkZukxy26MBOoiZ9q?=
 =?us-ascii?Q?UvsKEEJX/Iat9yIm8Ey4xP4n+FgluCCtGcgZ/1Qa8IQwsgYRGawL1P8fOvdm?=
 =?us-ascii?Q?6RDvUS4zbU+zWDQwtXMaMAiMRaUD2WN/wGkovS/lC1+HwDXoIFS6qo7eI5jJ?=
 =?us-ascii?Q?CAHp1gjiERq7F90+fMKgZLf0L9fQUZdYNOuojxWu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FKblBU4RLEoC/qPQ53hFwXdaLTZLLA4CuVix7Dss1hW4sH5jdEHwP4ZpiRHQ0SX7MclV+DYlknR4sPKxl9eclF2vq9+jgnQ55vKjrkOMCRItSIJXoGw2NnubdX7tiaBDHJ8jagd7UIqr7+MbdChYZZN2ZLcwe26TGswn1zjwm9oYeuCWjHCyMNGVNavQjO2DhnwBqOFn0F8y70Ca55N5KOkshZ9jYtAKbUpTbQZ+T8iN2nELDEdOVU0ZcSsUZ0ye39LZux5AaYrMY6mbCVTzM2tD3m0wqfcfa7C7+xX3xuQDgECimV9Ho4g1B5gxu7x+l3SC9Cin33rDblokjIKim9N07dlrAJQWsTmekCZuwlPNripJq7vbCsZwLpAfJaKzOgZboc/FbSlSBMBSxaLH+GbfsaRwX82/94fZOyxAq19T8omWfeQk3K5OZkc6YUCyqdVCKchhJUkfS+1DNn8Xnf06kRkJjpt6/sFFLwNwfL7OC/TjGXx+9I0xl+UYW69nfs2/9PZykb76TrLoLHlkCE1LIaxP/Y2p5C0PwuEggeN4O8qoxFWhGdgMo0XWN1uuBLTccxto+tR9Mr4V74+m3ffk0xUoXU93LSrsaKcZz9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496dc0cf-146a-4f1b-daee-08de281ada54
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 09:54:53.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40fCyhCos4lnUpGdqsQXS9YY1q39EqwRvjiPWDK/wuWfwFnlnvf2l1QSb+aaLvDEgw/XvNDgmgpeWDR6vsBxwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=978
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200060
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691ee572 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=W9BqLgzXg1EqYeH4nf4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yCyRFCzpwjF5WlmwBEE0XsvuP2S-HnAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXybnc4PlC6wLb
 uFMJKtQxOoyoM1tYX/vY8NsZj8pymI72i43XybTNisoFPdG7p2m1qzZoqozbQEGiU/tEflEpZDt
 c9nGKPOHi+asHtqVwcOSZBnegUh8cJrOiij1Ni371nOiji9w+JWbrD/yc7t+F9WXTcy8p+hzx52
 Kgc+jGsrceDQRkTqeCsrMj69SJdstVlatMYCR6XT62sknSJjqQLAvI6BSLCTWRWspI75ytDPM1y
 T935uK+BR+KIq2PPk2C7AaTqpq8AswBWnSgKDhsa16lPY/XY+gD0MyCZEOOYfuql4gL5bqGWDgw
 5ccVHeoZD2thm2uc8XWz7jnODNpoDYvV/NPsOc1DtYfHDX3AanejUUNwQN6gGJhxhBEjRaiWTfc
 oS0OzOg5b65A1IZvi87mMII1XNiO8g==
X-Proofpoint-GUID: yCyRFCzpwjF5WlmwBEE0XsvuP2S-HnAU

On Tue, Oct 28, 2025 at 09:58:33PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in workingset_activation().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

