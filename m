Return-Path: <cgroups+bounces-14465-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NcvOgBSoWkfsAQAu9opvQ
	(envelope-from <cgroups+bounces-14465-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 09:12:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0F1B44D1
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 09:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76CE23050235
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0636E46E;
	Fri, 27 Feb 2026 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xw9+kuWD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tXcRgk2i"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32F3563E1
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179949; cv=fail; b=uMjyMFJXyiBJw3oAx3TFLgIcNLrk4wsOoOgb6DmjQhWk8Wz21uAjIeUXSWhRIxJP/Qj2x2jFWFjKBsPS3k4l1r8ewJa9l9UG5RqL6WIPMuC+woXLwxJ/hjt31q3NzGX4CQaOAGGvO2p1OMWT18lmm/s6b5b5E8s18chCJ4TkSQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179949; c=relaxed/simple;
	bh=UeY8Cv3vu7iu2OkDvFJk6a+esFQtkAcFU0REvu9di90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ja+GqzqYOzdiFHm/JbHpUq/h/CmZqW5U9HYqd0cmXKFEXOuV1C2zGl7r36+y6WnNxz/7ixjibqoEn7ZsSDhGYx2DLuVoN5pl4ssg6FddQlHY6E+zoZueQIMyPEfkVPcQFp95XDJFK+tQatU6MA08j4HVgxblQuT21RfjkBMWS70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xw9+kuWD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tXcRgk2i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QL5LED669803;
	Fri, 27 Feb 2026 08:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CBQ4c/spmPxQla5j87kiTID3ZJkydKm0SzquQblenCY=; b=
	Xw9+kuWDoAwdiSeUKlK89JnBge+LnuDm9lZ+byz2kCwr33W2zET0ht9mxifYdbFJ
	y06XQJBCIXnnYk8soSFNYHaeUzzBPQrW5ufPsqXXBD+gaCHYg9Zw/4UK0oBdGKhm
	yy8VhoUogTXuPbiErwAsCCk1F52Fi9oaqLLtbjXTdvRENAqxTFUCW+ijE3U6DeCO
	YS1cCXMrKVAzvuqMAxsWi0GaLzPrj5efH3jYHMhoSk+k2+KnCa9+YoV+opDggSWR
	xeET9Ikaygb9R/PQ2u/YXd/2TebxXDutdlQsKJQsR/LsiqLWu10JkGos+z+GGwIu
	wLBT2fEwOrNy6wybU1f7tA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m81t91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 08:12:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R6WEfK038447;
	Fri, 27 Feb 2026 08:12:03 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35qt8dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 08:12:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuUM4Y2g1/torIyFkPVu27jMDBCMMvgTuPu9+dT+C33g6IcOcNhkgKkvPV8LHLmV4zX7OaHm0sBgftBzRKev/Guq/r7y4jygm6oLnTVggOFOybKQgC6QFDNncHAJVoRhrMUg49owKEKyI/zeEqfCDW7zuEsZfh6Nx0IZZAkF5Ib2IVuyIurfeO5ocLSF1B5AeiQ2vMrbJ+7z/ZNc3mF+utsRqqxeZH+rUqH5k5Gy+r91LZSEQnS0y5mTEFbin+Ut1DEzFBGwva8DtntfokHWUZ1CZEN2xiCb6ZEd2E63IrvLkmGBwdvwCB4glbntXk2M+eOwvx2MF/UQolMAdie40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBQ4c/spmPxQla5j87kiTID3ZJkydKm0SzquQblenCY=;
 b=bntPnPwWwMAFbcmvJlszA/0h5gAkytmuhcfcNC+/sMW8tU89gXT+P+jnYFefkQDYG5Y4Ns698xwMXboGPJHPJ/E1g//ENR8Yf+4Kn7YWrF6zyR11DUWOTroGuXBq0ggawmqZPjjJjhpvrP39Bk8MSMAFdOsqbkz2BL/1fDegzUnnaWdMjb41zet3UNrr5XWDAOU3QnPHEeXQVHFZXEhpCocGmPXrl2V1XYuq0toxpQfA7ZxfKg9v5j9/3vxxIeDG0TEbmGj6c6iwSCMv+szeIx8NT4wYZrRFq5cMLdgLuhRNCs3kirqN6gQYD3JB7hIg2XlL0U7RmUGExebXSXwYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBQ4c/spmPxQla5j87kiTID3ZJkydKm0SzquQblenCY=;
 b=tXcRgk2iLri/N17PbMZMMNSoXOXifgm7SCLYkZb14UusZUNNfW+i6kksqjUC14PbUvNgp8+mpqscEOcnJ8AYFuYNhW0Xr/PAc/q4L2TfUUU9rhoMZ3wiryOJTRNosRGTZg3rwHHOkV+Hc800E/TtMgcvUPar1MUsXvbPw1pNIzs=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 08:12:00 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::81bc:4372:aeda:f71d]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::81bc:4372:aeda:f71d%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 08:11:59 +0000
Date: Fri, 27 Feb 2026 17:11:53 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, cgroups@vger.kernel.org,
        cl@gentwo.org, hannes@cmpxchg.org, hao.li@linux.dev,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        surenb@google.com, vbabka@suse.cz
Subject: Re: [PATCH] mm/slab: a debug patch to investigate the issue further
Message-ID: <aaFRycdCdrsjED2r@hyeyoo>
References: <84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com>
 <20260227030733.9517-1-harry.yoo@oracle.com>
 <dc88bc66-77ad-4762-80f6-18a1262d5355@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc88bc66-77ad-4762-80f6-18a1262d5355@linux.ibm.com>
X-ClientProxiedBy: SEWP216CA0148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::11) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: f3656b74-ee3f-4279-6657-08de75d7e18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	WLoHpYFePXcFb1WacL+2RwNd/edgW9trDRmS7eGMNJhWDMn8VmLTqXjlLg9ApVZ0R2ZkXIXz0YUaKEVpOnd89Vg6rz66D1F1QMM0DjeBBP8LW0MeSw33bvBrQrs5n0U6GLAH9NIHnNfAUZkPOekDJI6gWcY8t5hTg2Ru2FtnfxR/3/myQe4aCcxrDuT10M+Kr6WpOGBS9lYMtk8W6GaoO26K9XnDYNLF/p7wjC8+vA4u7MWkIexKc6gS+QtHNHZ2ApAMZWZ0hXdTBkhWpxUrwO6XmX7y/l0hz0dNxZVKPIp4ilfGS5ORePLexrp5RxPO8Gf1xn9hYHoPlYQ0Ncj2uYnDOi3JCHz/ZwSzRMEcjrB1VfZFzvEUiznyvGmQr2V7x3BODPYep081uwJDV9xRY8HggoaJBVC25OntC/mha36LbT3ZBhN/Bjg1od1XKzS3k6ytL+1E7oq7gApw6ojF4jFax+4bX0muxhTGsasRgsEcs/F3zIeZiGCPnQZo9r77rE8q0IiCJ0+aW4t8+j6ugdVuv++kFYegL+f7nkm/xciV9zuDRPJQVOP4i7Zo5QP9fggqkPVJRTpDTzsm6Se4EU/7Hfsiny4zEEv2gEgFQ+pjw1ZbaWeVupNK2nTC0QgZ5roaTR1XHf03c1ZfI/NvqMW1cAqnJ+1vbIwTFW4li8bp8SDvmxUtj4aY9/jzL7iW8V+C1ca+XeCOyJN51ppLz/2nin5AcWvQB+PPr/cqBJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y213R0NjQzFUbDhXdmM2ZXpHWldvM1ZwZXRETFR4a29IVzZKVDZWZmtHMEZ1?=
 =?utf-8?B?UTRNTmRnVlNrdW9NZVdXUEJzZ3V3alZLUy9sVGdORkJlY1hLbDFvc0Q0czFC?=
 =?utf-8?B?Z0taQkM5QmZiYWV0dlZtaXJTbVJSRC9iM0FNY1VZOVc1TkpKYnNWMWxOSWxQ?=
 =?utf-8?B?NHIvcEpnWktUWWh5bHBHOTJvNWZ5Tk12V09VeGExOXFtNXNXVmFMdDkzamZ6?=
 =?utf-8?B?WjljMmY5K0QwL2N3VmxtTlBxZHdtRGtrUTdvSHVvMEhHWSt4SEhmOUxpa1Fj?=
 =?utf-8?B?VHF2NGxCR01pejFUVmNRSTViaVorWnBJYkpuWTVKQlMrMDJna2JhWW5KQzBo?=
 =?utf-8?B?bWU1L0NMbjUyenRRb1g5UmdBeG9QR0I5U3RMMGZ3dSs4Zko0RkhVWGhpY3Fa?=
 =?utf-8?B?RERISVFvRW5iSVZOc1A1Z3lrN3lYaHNBR3dlNWNtRUZBQ1ZuYVk0VStHT2kr?=
 =?utf-8?B?MElNSDZRc3QyNmFmMXIrVEx6NTQvenQ2YThYMk93QzA4ZXRPdlQzbGMxVzJq?=
 =?utf-8?B?cWZwNEVMTHBabDRkR0ZPMmlybjFZZ1dia0ZDYXk0cERDdWdORmxzcy9KWHQr?=
 =?utf-8?B?VUdmekIvRzBLamFJM056Sm1ZRDlXVjJZRTdLUENGTjE2Qm9HVXJJWThDajhs?=
 =?utf-8?B?UVNqOC9BeW8wZmZJclRHTUNNN2J5c2xCQTdMdmh4UTJ0UGRwc2diMEZEQ2Rl?=
 =?utf-8?B?MW9HSmlHMTJKUUdScE1lOE9ETVJYeGxidGFneFVydEdlNHBLYmQ3UTNQZGlO?=
 =?utf-8?B?ZENPVzR2aVFqS2tZTit5cytPVHpIMmZMVC82UVNNTktMMWN0VGVmbTJvMGtx?=
 =?utf-8?B?LzNVU0M3Q0Y0SEJnS3hzYzZlVi9raDZrVk9lY2t4SW5IR2RwYmJuRDZWZVJK?=
 =?utf-8?B?YzdYK3NKRUlVTllERFV3a2hKRGFOU2d3Q0syZnF5aTI3Y05BOHhRYUlsc1VV?=
 =?utf-8?B?ZHlucE9YMWEzSm9WYkJLeldwQjkzY2VYbjE0V1VtZHpyQTlSb0NFaWxOVW5N?=
 =?utf-8?B?RUpTSHkzdEl6YnpmdEhjNTlTV0hDU0lBTGhhZGZDb2E5emc5TWxQb2xyc3Vw?=
 =?utf-8?B?UExUSkVuM0hUV1dYVy9STmhlamtPWVhQQ3QwTHpyeVZYTldJVzdlMTVrTVR2?=
 =?utf-8?B?VjZLTXVUSGo3aWszMUhFRWY4TkxnNHZQZSs3Y0tCYmVYR2dtdFZtdDNWU2tI?=
 =?utf-8?B?L1kyc3Yyd1VlTGM4cXZDaVlEaGtjM1Y4dWV4NFl5b2ZHaDZucFFhVE9oejc0?=
 =?utf-8?B?THdYVEVBUkx4OGFPRG9BbVR2YUhTbkxrb3prSCs2bVE2TndBRE1GOC9MWW5J?=
 =?utf-8?B?ZjdsaFBvVWR1eHd2SVdhdXhOR0tiTmVyZFh4RlNXTFVGYURNYURZRHFWM1ZU?=
 =?utf-8?B?WE9NWWxzb3VwYzJGVVVsbE1ZcytmMnJObTBmUFU1NFBHMW9hMkdDM1Q5Zzda?=
 =?utf-8?B?enIvdFcrRzJJbEp1cnlQeXc1NkVTTEtFOG9HeGgyMWlRbGpUdzZDbVZHcFJ0?=
 =?utf-8?B?R3lLWkpuSGZRUEdqQUJsN0NUNFlVa25iRjlFSFVZTjN5RlRzVFZFL3Viazdh?=
 =?utf-8?B?NlNwNFZzTm9GZlNML29PRmdyQnUrbnNFa1dJUTlQRHA3SGlCblFmbUlqZ1RQ?=
 =?utf-8?B?VjB2YkY4VmEwdExHK3B4RjhkRUlPODQvdHpnVG9XbEoyKzJUdUh5SUovSXZF?=
 =?utf-8?B?TTRVNHhUNmlwaGJzVndMWVBvR014VXlZZ1pHLzhhU29Zai9TZ0J4MjZtRjgy?=
 =?utf-8?B?dURUN1ZUZXBNYUEwSnhNUjZKS0RGdjRGdWNQTXpraUplK2U3aGticThNNlFX?=
 =?utf-8?B?cnoxWTMyVzlZYzBHOUNBeDhOL3NiWnllc3RDeWEyVzBqanR5Z0FBcncyeHR3?=
 =?utf-8?B?Sjl1dGhyUFJHNm1NUDhJaUtVL3RiRDZ1eEMwKzR4UnVSK0VQUXFTLyswUTZa?=
 =?utf-8?B?UERTWnVRZkRTc1lUKzJHbnoyNUpaT3RmOFE2bHQ0bzBvczI2cktkcDZBUVdF?=
 =?utf-8?B?L296c2dMR3JDQjYvWlRlNnQ3NmhLTWpTanRJZ1dlSWp1YmdSRUsrZlFJeVE4?=
 =?utf-8?B?UVhIUHhVc0VyNUIyc2N2cENSbHRpVm85MWUvdTRmbVJVVXAvSk0wRGxaRWoz?=
 =?utf-8?B?bC9TZGVnazFYeUhjNzdqS2Y1Z2loQUNqSHo4OC92U0dlc0J1UEJJR3FIcXpD?=
 =?utf-8?B?SHVpRnFCVXoyekRlRUxHNm12dnlHTmVTcEE3S0loQkxjMG5UOEdMOHBiZUJT?=
 =?utf-8?B?Nm5peCs1bDdEcElsRHRlR09oQmVVMGdwb1cyTTdWU21waDAxeXNaMVdIZ2NF?=
 =?utf-8?B?aDNmWW96MXdDUUg1VjJPTkIzd3ZVQVp1UVJnQ1lzSVZFVlE0b3hqUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H1vJJyi3T/hT8oP5LdJ433nPewdtBA7sZmELfuh67jnUtXxC73YtPKl/TN7LcIDatDJjqeuaaRlr73s/BI5Ik0nolIW0Nlv1cnuhazu9XFylYoHbOXfnLRO+mG+Pg7uIGx9u9R02jdczGaKl81MPfsxHLIhC4/Or4xEiuWNZ0P7Wa+sVQ8qbS8DNjrma2qGPE46zy/HpQcbnH6ovNgYgZr07hpHHAuahnHitrJgp8UBJmu9AQ1prOx7PGWkwwkolzrz0BvtZnZ/qjxVH7OSdJZ6+qkzJR/giDl3O+hRYvr/E7+E6n3m7IlrUcm+URDBrJpwVRnr8OoVVwgDffwzmWgKMCeunnLfdjJdzu10w3FXGEmGKCdRkUpTY8PzGXWJF3xZXC67YE26c0jykodttS4JGoqfqMf2B60uP75aCmkDw40KD6mrAnjGVvQTigpFsts+lb7LHOH5WWBE8PJfWtniHC5piKde3gm8gdviCuCmm3ie7f80sDgN0IcjGJuubDdswA1uLIBswyWILak6mmhI7NEwtZU9tLaaBHzau2DWtVWIxy+bPDNydybai3K2UJVO8pzwMskfuWMZ/MzPkhspyktObct0cNgHqBNWP3Pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3656b74-ee3f-4279-6657-08de75d7e18e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:11:59.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAH1zjQddo8sHRoamLIPL/c4cNrZ+0CvYASx6KC1k/sMSNh9gyApODMipHcuVu3dhE7UxxX2d7ChTmKY9ZoAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270068
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a151d4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=z6rXwFK9x9l-hLytNDsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12261
X-Proofpoint-GUID: On1BlFQEwzCH42K5P_rmSBQopjJ4tUSh
X-Proofpoint-ORIG-GUID: On1BlFQEwzCH42K5P_rmSBQopjJ4tUSh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA2OCBTYWx0ZWRfXxfVfiwKLGK36
 ir74i8Rw84AwuVFShj8j6VtBuv6Ko7+ufP5PaC6qLAuOidUGEu17SGuV8bQPdYdhv+AbLRu4+yU
 OJH0qAL1kI548Vd6ZqaAl4KVMNP3w3wUPvLQq8gXL4kIWllD9m1A84XqD1tA42faodz+Qe6kHD2
 L4zeWSgH+gNmEgBQcCBa1ULEwlF0+nHosYGoeZyi5xZXybNKtRNMiGrktZ8x/Zc9nwCUL25y6Zm
 9TDD+iInVgTqU6BFcm/+8k7tYlhfMktoz6lAOfhis0wsqTb1sjKWxPh7pYMfgziBOznUSkxqSyM
 q/wSiJJkkWMp2VsvSleAicD/pmiu4xSe7akdhSDAF/RbHpYssFBIp1rcEPkiuh0dSBG0IgYmQI3
 MlAyQBGXJdh3AGebfrV0+hX6+Ad67ItE/3dMY0ZRoW+E9+gPuzRT23/RTA3BEerNCtXkYcLXZ+R
 Yc6KsN4BXkP7nKI1UG0TWVRepXs3ruecrJ8nsCDc=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14465-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8AF0F1B44D1
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 01:32:29PM +0530, Venkat Rao Bagalkote wrote:
> 
> On 27/02/26 8:37 am, Harry Yoo wrote:
> > Hi Venkat, could you please help testing this patch and
> > check if it hits any warning? It's based on v7.0-rc1 tag.
> > 
> > This (hopefully) should give us more information
> > that would help debugging the issue.
> > 
> > 1. set stride early in alloc_slab_obj_exts_early()
> > 2. move some obj_exts helpers to slab.h
> > 3. in slab_obj_ext(), check three things:
> >     3-1. is the obj_ext address is the right one for this object?
> >     3-2. does the obj_ext address change after smp_rmb()?
> >     3-3. does obj_ext->objcg change after smp_rmb()?
> > 
> > No smp_wmb() is used, intentionally.
> > 
> > It is expected that the issue will still reproduce.
> > 
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> 
> Hello Harry,

Hello Venkat!

> I’ve restarted the test

Thanks :)

> but there are continuous warning prints in the
> logs, and they appear to be slowing down the test run significantly.

It's okay! the purpose of this patch is to see if there's any warning
hitting, rather than triggering the kernel crash.

> Warnings:
> 
> [ 3215.419760] obj_ext in object

The patch adds five different warnings:

1) "obj_exts array in leftover"
2) "obj_ext in object"
3) "obj_exts array allocated from slab"
4) "obj_ext pointer has changed"
5) "obj_ext->objcg has changed"

Is 2) the only warning that is triggered?

Also, the warning below says it's triggered by proc_map_release().

Are there any other call stacks, or is this the only caller that hits
this warning?

Thanks!

> [ 3215.419774] WARNING: mm/slab.h:710 at slab_obj_ext+0x2e0/0x338, CPU#26:
> grep/103571 >
> [ 3215.419783] Modules linked in: xfs loop dm_mod bonding tls rfkill
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc
> pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2 sd_mod nd_pmem
> sg papr_scm libnvdimm ibmvscsi ibmveth scsi_transport_srp pseries_wdt
> [ 3215.419852] CPU: 26 UID: 0 PID: 103571 Comm: grep Kdump: loaded Tainted:
> G        W           7.0.0-rc1+ #3 PREEMPTLAZY
> [ 3215.419859] Tainted: [W]=WARN
> [ 3215.419862] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [ 3215.419866] NIP:  c0000000008a9ff4 LR: c0000000008a9ff0 CTR:
> 0000000000000000
> [ 3215.419870] REGS: c0000001f9d37670 TRAP: 0700   Tainted: G   W           
> (7.0.0-rc1+)
> [ 3215.419874] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002404 
> XER: 20040000
> [ 3215.419889] CFAR: c0000000001bc194 IRQMASK: 0
> [ 3215.419889] GPR00: c0000000008a9ff0 c0000001f9d37910 c00000000243a500
> c000000127e8d600
> [ 3215.419889] GPR04: 0000000000000004 0000000000000001 c0000000001bc164
> 0000000000000001
> [ 3215.419889] GPR08: a80e000000000000 0000000000000000 0000000000000007
> a80e000000000000
> [ 3215.419889] GPR12: c00e0001a1a48fb2 c000000d0dde7f00 c000000004e49960
> 0000000000000001
> [ 3215.419889] GPR16: c00000006e6e0000 0000000000000010 c000000007017fa0
> c000000007017fa4
> [ 3215.419889] GPR20: 0000000000000001 c000000007017f88 0000000000080000
> c000000007017f80
> [ 3215.419889] GPR24: c00000006e6f0010 c0000000aef32800 c00c0000001b9a2c
> c00000006e690010
> [ 3215.419889] GPR28: 0000000000000003 0000000000080020 c00000006e690010
> c00c0000001b9a00
> [ 3215.419960] NIP [c0000000008a9ff4] slab_obj_ext+0x2e0/0x338
> [ 3215.419966] LR [c0000000008a9ff0] slab_obj_ext+0x2dc/0x338
> [ 3215.419972] Call Trace:
> [ 3215.419975] [c0000001f9d37910] [c0000000008a9ff0]
> slab_obj_ext+0x2dc/0x338 (unreliable)
> [ 3215.419983] [c0000001f9d379c0] [c0000000008b9a64]
> __memcg_slab_free_hook+0x1a4/0x3dc
> [ 3215.419990] [c0000001f9d37a90] [c0000000007f8270] kfree+0x454/0x600
> [ 3215.419998] [c0000001f9d37b20] [c000000000989724]
> seq_release_private+0x98/0xd4
> [ 3215.420005] [c0000001f9d37b60] [c000000000a7adb4]
> proc_map_release+0xa4/0xe0
> [ 3215.420012] [c0000001f9d37ba0] [c00000000091edf0] __fput+0x1e8/0x5cc
> [ 3215.420019] [c0000001f9d37c20] [c000000000915670] sys_close+0x74/0xd0
> [ 3215.420025] [c0000001f9d37c50] [c00000000003aeb0]
> system_call_exception+0x1e0/0x4b0
> [ 3215.420033] [c0000001f9d37e50] [c00000000000d05c]
> system_call_vectored_common+0x15c/0x2ec
> [ 3215.420041] ---- interrupt: 3000 at 0x7fff9bd34ab4
> [ 3215.420045] NIP:  00007fff9bd34ab4 LR: 00007fff9bd34ab4 CTR:
> 0000000000000000
> [ 3215.420050] REGS: c0000001f9d37e80 TRAP: 3000   Tainted: G   W           
> (7.0.0-rc1+)
> [ 3215.420054] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE> 
> CR: 44002402  XER: 00000000
> [ 3215.420077] IRQMASK: 0
> [ 3215.420077] GPR00: 0000000000000006 00007fffe2939800 00007fff9bf37f00
> 0000000000000003
> [ 3215.420077] GPR04: 00007fff9bfe077f 000000000000f881 00007fffe2939820
> 000000000000f881
> [ 3215.420077] GPR08: 000000000000077f 0000000000000000 0000000000000000
> 0000000000000000
> [ 3215.420077] GPR12: 0000000000000000 00007fff9c0ab0e0 0000000000000000
> 0000000000000000
> [ 3215.420077] GPR16: 0000000000000000 00000001235700f0 0000000000000100
> 0000000000000001
> [ 3215.420077] GPR20: 00000000ffffffff 00000001235702ef 0000000000000000
> fffffffffffffffd
> [ 3215.420077] GPR24: 00007fffe2939890 0000000000000000 00007fffe2939978
> 00007fff9bf12a88
> [ 3215.420077] GPR28: 00007fffe2939974 0000000000010000 0000000000000003
> 0000000000010000
> [ 3215.420144] NIP [00007fff9bd34ab4] 0x7fff9bd34ab4
> [ 3215.420148] LR [00007fff9bd34ab4] 0x7fff9bd34ab4
> [ 3215.420151] ---- interrupt: 3000
> [ 3215.420154] Code: 4e800020 60000000 60000000 7f18e1d6 7b180020 7f18f214
> 7c3bc000 4182febc 3c62ff7a 386336c0 4b9120a9 60000000 <0fe00000> eac10060
> 4bffff58 3d200001
> [ 3215.420183] ---[ end trace 0000000000000000 ]---
> 
> Regards,
> 
> Venkat.

-- 
Cheers,
Harry / Hyeonggon

