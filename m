Return-Path: <cgroups+bounces-13004-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63FD06C5A
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 02:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7197303FCF3
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 01:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F637236454;
	Fri,  9 Jan 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9gAt/Qs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NiU6ZPkv"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FA1B4223;
	Fri,  9 Jan 2026 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767923601; cv=fail; b=qsZSA00Czxto/rBSkDbOMM3E8dLuoLu++DdA5WtfdR6oWNb7oRjdTzpvmhBpsGHmB5KpIKlngHMLfAIb2ebhkjRjBJdoEAFkkXEn0cDbf1gDwEGYnwChZtUjpH66VXM7zILxp8c/lLjimbLlCt7bMiBcQ+fye5v3B/EKBzZde9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767923601; c=relaxed/simple;
	bh=mPeKKuKVikuC0GjBBRcLfgAGDX6y/eeDRVGY87DhBlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AxJo1c3rj0Ciz+N5a8dYOTbLHcSRpFpzx2yXZvX+4PbdHfJpCCkN413/RHemlPUbnWGeGudzedwiLHPfN7MXh/WDy9OJYO5bvlGtKrmx0PJgs3Bn1hqtjvR9UeLjTHAzVHkt2nmMHu2fNYPJdp2Ce0nf0D22lYJbr5VN10O520U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O9gAt/Qs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NiU6ZPkv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6090U1CC1895678;
	Fri, 9 Jan 2026 01:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XW4VWdm8xJIiUVF8xGb5Zz3v3ZLrJhnYSz29+uMlpIk=; b=
	O9gAt/QsONF0zCOwBGtbUmInwQtiX3yqb78EtxiC70V5L1y1fHRCCLgsm48D/FE8
	+YR7ShASfcUpNSLvhnmNCwtwJjsj9rnHTBcYxMLVLiaTTV3KPSiDsuYVeO7JIWdg
	6Tj/47eAqJHdW+VzGCP2Wrtf2JGL3NUtgDSbW088mIgr8ElLqwnuOueTV40XbDHz
	zQOVIFy9pV6nowmT/kVYqe+9wJqwf8rxxlLIwm8F48mNkLgYkRXlEpBgHYf/zzQE
	tWmlbXgEkLTfwv06F9VK7OuSEr18hOQtlhxU4ss7DZb3YVZD1sLNA8mHzpbSeibY
	mC6SD40iAOyr1+yQXnQbMA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjq68023j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 01:52:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6090ek4O034230;
	Fri, 9 Jan 2026 01:52:52 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjbt599-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 01:52:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfqUZJSjbxWxSOEtvChBYM2WAOpAvoZVXfnnnV7MnkaPmKzZNnGdxgM0v1IgrvTIOW3vOIImEv5Y/R0kvW/oochLvKcAvfkT2nCR2SsRbMLZ5s5WskXGL57drGJm3kNjouCphhZ3cbukc9U4fJO8O40fmkDwgO7tr5GeDM/4wC9r3Ybnlx9xppsh8Kn+DgAMSE56qyMTEr+i5R5si83O9xAc1MHBkBUb+8yNfSjuwZWjUnzKJvqfnIi3aQz4ETYn98Y3t6XNPX5p4csIrtBVAgaVvowl3lUaJfPU1KDTaIyktAGv24jJ1xjRGtKeHJEGhDxmMoo96EnRJC0qGTYMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XW4VWdm8xJIiUVF8xGb5Zz3v3ZLrJhnYSz29+uMlpIk=;
 b=cdhNnkbjfbBCKyoE3Z5gIjsLgvYp/xf/v5bUbbRqYOvbEX2zyxsixr+pFJXzQrVi3CLemzftwdThFkAIy9vatMYaYhQZv8dH8D/5qOE78HyNTJaNSSZmdzMdWy4tHFQIkTUqD8e3LcNFvPMJMPQYxJztC2b7G3PK2taADlNQMmIeV6UzzZP/mBrEuZro2RmlV4jleUc78h62jF4x3/6jVi+Bn3Uj4YhIM2+3IWY2KVLJL4CSWQq7AAcjTUCyEnTnNY2AJ9sgaoXUTzQJu7UVbmbc+oE2+CdlivwZONOvFooXVMBMaXviiS+DlyuBpmSKYTH1sxDXlBb7nCR1c5i+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XW4VWdm8xJIiUVF8xGb5Zz3v3ZLrJhnYSz29+uMlpIk=;
 b=NiU6ZPkv0hMd2e2pkzdR2B6iqWo9Ah5VsoCXS6gzNX+tBmUl2oI9VquxgYVIP0hEXJGLRT6XmkY/7+dN6Q8u88R4dp754TN1q6ZsaJXjcO9jATUDUOG9anBjFkcBVvD1PMJcsJRV9oZjik2Q859rOXqPs7CFyiKZ6G/LBVE3MBs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6107.namprd10.prod.outlook.com (2603:10b6:510:1f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 01:52:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 01:52:48 +0000
Date: Fri, 9 Jan 2026 10:52:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@gentwo.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH V5 1/8] mm/slab: use unsigned long for orig_size to
 ensure proper metadata align
Message-ID: <aWBfZ4ga9HQ8L8KM@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-2-harry.yoo@oracle.com>
 <CAG_fn=XCx9-uYOhRQXTde7ud=H9kwM_Sf3ZjHQd9hfYDspzeOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=XCx9-uYOhRQXTde7ud=H9kwM_Sf3ZjHQd9hfYDspzeOA@mail.gmail.com>
X-ClientProxiedBy: SL2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: b48d0367-f465-4be0-df06-08de4f21ca28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dSszKzdsdXpWbkszbzBRRFpmODI2MnNXaGpMU3V5NG12YmNDWE9maldnSEt1?=
 =?utf-8?B?RGRLYjdVaEdCbklSa2VJMzhwRFhEald6VDN5c1IwVEhITWNUMllQUUxuUXdh?=
 =?utf-8?B?K0w3a3NiaERvOWxSSEpnTXJxSENqZSs5SVpkMUZjSGRLb1FydTMrYmZaUUtY?=
 =?utf-8?B?TkJwNThIcVJTdHJhV1p1ZUVOTTMzRTNHSWNVaE5IZlBMWU5yZE9mdCtYVnhl?=
 =?utf-8?B?WTJybVg1aURCRlBtREgxbkxkRVVWNHBPU1NEK2RzZERORmcycHFNWFM0UGNX?=
 =?utf-8?B?WFVYYzRlQ0JQbC9NYzU4SkMyaWtWYzhqOE1EMGlvK1FWK3dsVmdqVC95bDR1?=
 =?utf-8?B?SThZNW12ZHk1Vko2VWxwRnViZW9vdnNweVJObWJpM1YzdjFueEtmZVZNOTlG?=
 =?utf-8?B?T2FYV2xVMXFyMVpnR2tpbm15WWVWcWZxczF4TE44bHNwaHF4dmhGYytxdk5v?=
 =?utf-8?B?UDBxWUlHTisxYlpjQy82eVdPNXZmZ2xEWDFzdFlmMi81REVBem4zT2o3WkRk?=
 =?utf-8?B?akgxTy9FeXVZVURFUy8rZDFWdlNiQ3ZuN2xxWGwyQlltVGN2N3hlQUJmb0N5?=
 =?utf-8?B?ZlNGMkg4UjVrNzhKMm4vdUZEaTZSRFRtaXI4QjdCQjlKNkFZcXo2TlFHVklm?=
 =?utf-8?B?N0k5ZzQvbklva3lubVV1bEdKQlUxT2s4QVdoL0ZZTVJGd0k3UU90U0dteVB3?=
 =?utf-8?B?L2lGRDZFd0xWcUxJSlBYWXhzVEQvcldmSDVnUFN2RjhNZDNEZUFVM0dGRGpw?=
 =?utf-8?B?NzMyQllpZ2VyV3hWaC8wOG9FeEFLN1FwZm9kcGJQZUpoU0F4bUZXVFNFMWNK?=
 =?utf-8?B?cUNWMkliT3hWWWtpcmJxenRKaElsZXVtdEJRMEd6OFhsNEJ1cWQ1aWd4NmFE?=
 =?utf-8?B?WHhBcitPNTB0QlFaOFZpa0NLdWtUQTBkVElJNmpsWklUWXlDekFMV0ZFZzRM?=
 =?utf-8?B?dTBpVWlJdm1ZNWNYREdEbm5lUTlja1BMUUJ6UUxmNkpzbnFwQnJocVU0M1Zm?=
 =?utf-8?B?LzRWV1IvbUNrOWRUbFVwUGZWZTlmZ3ltUTBHK0VFSGRJWE16VHJNQ3JBMG5m?=
 =?utf-8?B?b01lbTdySVpBRlg3S2RSMzU1S3pyNjlJU2dWY3NCWk9BOWhrVnFyaEtpalRI?=
 =?utf-8?B?K0dLOWZTbVFzSGFFb1ZDOU5hSWphdDRDSHFFNWFJTHdVVjJiZW1jbVVBczZV?=
 =?utf-8?B?MFVNUUZ5MDNsWkl2T3hSSlpITDUrZHJ6bXVBNUF6UU9ER2NkTG1Gekk3dTNa?=
 =?utf-8?B?enV5TGxRM2k4QXVHZVRxNjBsWE53QURETFNKU3lFdy9IVWZnMWRQYVZITGxB?=
 =?utf-8?B?RWlKWjl5ZUNoSjl5Qm10V3lleDlyZ0xUSFRVNWMxWXNqbVhNUzZmaXcyUGlF?=
 =?utf-8?B?dzVNRk9LRkpQa1pZRjFYaExnRi91VkFBWnZEMEpuMlJkeFNtZUczc09JNXVQ?=
 =?utf-8?B?MTBmOFBmMkdvWVBGem10R1M3Z2NEUERJNUQ5RThSbnB3L0lmNGxqZHlMVktH?=
 =?utf-8?B?eWxDRENHVFVxZ1J1aUtnZVNaSStBdTAwWGZZWndjRGNjdS9uM1ZFZEVaQ0lo?=
 =?utf-8?B?YWJaN1I1WndXb2NSSHZYMEtmSnRpaWVVODV0ZEVOc1ZpNXEzdm02QWtnNzRM?=
 =?utf-8?B?cmIzK1o3bzMrYmw0MnZLVW1lYTdJREhXNkNjT0prK1M0WC9vSDBnc28raHdl?=
 =?utf-8?B?NzZNWmRZVjI4czhIUm1mcmw5S1BVVnhoeHdlTFdiQmNtRDlNb3hoNGtPSTdy?=
 =?utf-8?B?WC9hamtXWDBBTmxHdEdCS3pLQXc2R2VUKy9nWXVkM252azVtZmlOQUJOSWNi?=
 =?utf-8?B?SE5XVWxiTkcxZnB5c1JsYTd2WkxNNjJ0TURxUzgvRlVtcnpZRlhHN3ZEZjFH?=
 =?utf-8?B?UjBrZ0hTMDE0YWRZSDdWT0pJNkdzalVjQ3dKS29oWjgwVkdiblRtcmVJUG5P?=
 =?utf-8?Q?Ws6Kal+ODuVKzpf16nlE839cnrw254FU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVJYQ3kyT2twQUlsdWtYQTFQMzJDWW5JWTNqRHJPZVFscSt4R0t4UWZHbGps?=
 =?utf-8?B?WjFHcXJSVzQ1RGNLV2pvOHVvV2NXZVNkTFduRDFMU2JGQXVnWHJnelQ4Rk9i?=
 =?utf-8?B?dDkyYTB6d0swZldpUVBZTHphVEM1TStrUW92Z3VkWVVhS09IaStGUisyV25l?=
 =?utf-8?B?NFpMOWdTT1VDSEYyMk1uTFV6Unl2c3BrWWxpUXBqazNWUzkxQk1SNHhPNS93?=
 =?utf-8?B?cHpoaUZHOUtha3lDaEdrbk8vTWZpdEs5Sm9zYVhpNWdsNlRRa0pBZnREd3g0?=
 =?utf-8?B?TGR3WU5NaUtVUkErTWxpQ2dRUUpvQkovaGVFdFJNdmFxYVh1MUVuZjVXTk4w?=
 =?utf-8?B?TTdTa1NuZDBQL3hqZ3EwYkdPcmtmL1dFS1dFWUwxNzBKV280amMrUVJFQVdj?=
 =?utf-8?B?WU55SHE5ZzVaNTE5am9xZFk2SnNuZFFPTlBJYWN0V1Z0OWViczlhelNtWXgr?=
 =?utf-8?B?US9RSndtVXU5c0FiZVlmM1FabVNFOU1uRndlNkRzTjRLV0t4c2JDYlZ2SmpD?=
 =?utf-8?B?UkJQdk9GcGt2YUIwTThTM0dmVWNvOTNld00vNEJjL0NCOHNxSEV2MlRUN1po?=
 =?utf-8?B?R2ZndStLYk4vSURJUWhtQnpzOUQ0UjNDMEdzTHFBTllIbk5KcjFYQUVkQjdn?=
 =?utf-8?B?bGs1bFRqdVlIZU81cTZuZzA2TXFocHUxOWVDOXI5OXFrWTNxZmI4ellGRlNW?=
 =?utf-8?B?UytESDYzejRRaGRmMlRkNlcvcUpVUCtQb2xFN2xzM0JFTmU5M29iaWp5N21O?=
 =?utf-8?B?VFBudStYODd5aUd3YjZIUjlzbEt5cWphcGNYR3FtNkFpMU91aWJ1YVN4elJZ?=
 =?utf-8?B?ZkhTSmphbERhUVM4bEtwN3ZrMUVuWTlTOGRyL014eGZHRWsyMXIweUhZbGhC?=
 =?utf-8?B?emM3Rk5xV3B3aE04dmdoVzVLMzBrTVpBL1daLzUvK2RQcWxjMFFoMDJkbTZI?=
 =?utf-8?B?YnNQUXlqeGJQZS9SWTdORDdyZ3dzNFJQaDB1M3JKVXlVcG9XZHFlTkNTRUtU?=
 =?utf-8?B?TkhPY3pLcC9GWTllSUZ6R3EveVc0aUlodTlKeUVmYldYS3FDYlpKT00rSFE5?=
 =?utf-8?B?WjFpMEY4QXI4N2NiVlpCVDZrQTliSStZVmtrNW93MVVTUURhSTRRMVVtVTB4?=
 =?utf-8?B?UVl4OU81UUhRWk0yVTE0SXhVRjJyaXFhMmJPeENMUDlWazkzbHdGeERhQUJl?=
 =?utf-8?B?bXlUdkxFZDBPMElkQ3dvQkhXczFHWDA5VU52UXRvNTR2cEx0MnYrbmhNQjQ2?=
 =?utf-8?B?UDQ5Y1BPMWQzUFplMzNGdnF5L1luQzNCRXRqZVdCKzFTK3hTSmhBeUkveFl1?=
 =?utf-8?B?aFFpTGhmMEUxc1h5anJpTUFkc0hEVVhqd3J2M3JTazNaVHh6V2tJbWZTSDBJ?=
 =?utf-8?B?ZDlxVWk3R2RVR3ZGVW5MZkI1RUZJbndXQlNPTDRHY2ZBZlR2ak9VSWg3QXYy?=
 =?utf-8?B?MCsrQkhpNWk2UkRoZUV0WERDejhCbW1wQ2IrMzRucHQvTUFnaHJqVXM3eW5N?=
 =?utf-8?B?dE8yWGxMeVZxVHpuVWljYTlPS0hLU1k0NmlUQ3VVeUNoKzIxOHhEWktZNFJN?=
 =?utf-8?B?dEVWWGg4YlRyTXBjanlEWFp5eW5sVHJXUXFTZElvMTJMYkZ4MHArbXF0QkFp?=
 =?utf-8?B?TGR0bXNxZWNMKzZtdUd2YlNxNDZIWEd5bzEwV0U1SnpDZWZWSVVyclBoWkpX?=
 =?utf-8?B?dk1LYkpwTkhXQm91RmlUS3VGVURSQm1vcDhaRmpzN0tacUJ4aEl6TlBva0J3?=
 =?utf-8?B?RmZ0a3U3MzEraCsvT3BXamkrbU1HOG1uYlpvYjFvdml5T0tyeXpaMlc1MFQ3?=
 =?utf-8?B?MU94VmZXMDNobVo1Q2dyVHp3dytiUFlqSURwNGdiN0YvaFJoUVRLMkxRN09W?=
 =?utf-8?B?VDZmNXNnRUVoaU1naW5qRExUK2RhUjd2NHJLTkRQQk1WbEFuOVp0OU5FR3hv?=
 =?utf-8?B?em15TnFqMDFIT3d5L1NndjIwMkU3dUg3ZkhOYnVBMjRIVmgxNDRWVWloVVFy?=
 =?utf-8?B?aVVTR05zM3JwYmZDSjBKY09HbUxmdUkrOHlVWXl5ZUZHdUg1TmV0TUZESkg3?=
 =?utf-8?B?T21CUlFZbmlaZzJneXRHT1locEdRKzhWNEtudEVFZW9ZSFJzb0VXYkVxUkhX?=
 =?utf-8?B?MkdwdjlmeEN1TnltZnBleEJFS0c1WXZKQkdsc2VzTUdxTW83SDRXd2FrWmdH?=
 =?utf-8?B?RjlZL0VRRTEyM3RoMWhwUWZMMFJWSkZqOGtZVWRUVi84Q08rWDdNUm1WUWs0?=
 =?utf-8?B?SWtrVFZUT3J2V1RUSldDSXdIR2IvbWJhZ0pGbHVvcm1jNGdKVlh6YVZ5YmFp?=
 =?utf-8?B?eTVjS2hhZWZCUTIxK1ptV0p6L0IwYVYvZG5RWWtjV1gweHpKc1diZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FOlwFoZSZBWk58INN8PhDTeexkgoWTmGHj5OOSWvpIz3kJ4mx3VbQpo9Q0hzdQVdxPnP7GvHFsafNEqKP+srQ1P7HlswUJtwFCtTE0Kr2oWXnuPXuGyC5xvHePxltK0DO3bFIredKYW0hVb3uC/g5/aFOWDFipOFZw5WGvEM/m3PZcokEhtfxCtjXGnJTiXwn66suIkmg8JxrOyO1CBytqCSwnZIpcLysw6c4MKveB8zqXs9gyB7xQ9NAZ0YNoCWyoVUUIL4IRecGERJ4DgGLRhD8XDSOQ2osprtfu0lLr0LmXfOoPXVUdINEMsRmYjLODSNZT9FZ3WH164/GWCZbcaPfJvBxOxbKEYV9J6z0QIL+ueQTFAGTpAlWHRz/HPzWM11FFbONitj8ldXo3QIjYuj9ytt5qZpTllRAkuYTOFkxfYg3PIWPxeq+1JRS2mjMFbp15/Ebn4zuGL7yguQDK+noMni8N2pXT8EvfQAjsrROvsS6sfAGmi0/sbEfqMLjo4riNIyuq57DHMSCSjVD194LN4fOWji21hkqxOVKwq3kqqdrzaZXX2YzkovzrXB+sbaKo5R5vL9Q97v4x6nRMgXFhO5dsHoMQCDmmLu0Uo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48d0367-f465-4be0-df06-08de4f21ca28
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 01:52:48.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3kH3bRS8jEFrwgI0/DO52/ssEE5x7OY+VNf6IIJIOBkcfIz8rELVKbiZQioIgXmgNB2UxGxzOAomzJs4hAm8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=975 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601090012
X-Authority-Analysis: v=2.4 cv=DNyCIiNb c=1 sm=1 tr=0 ts=69605f75 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=cGcmex2ascj-LIKmNdAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8l3fwn_EzGuB0-bu9baqXLKCiAxM1xQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAxMiBTYWx0ZWRfX1s53/TtiVe1T
 EzqGnLxUICH4+hRlSesaWCgV1fe946UfvuJMCb4ZDC3nQaYktU4vl+u3tixQCDscfYN7jvc5xFi
 MAuU9rrc2YfGk9jRnKLGSpi+YapVZj+JeldWhGZlHfCbDBc7xzSKFF6XEBJ+86PAahIfP2pvXyS
 ELG5fpm7GO9ifNWWEvCTJN4WULz/Zp64hYOb+0b4wfub1evUV/lxa//7vGT26GMGxp/DisnV83v
 LwUM5nKH1u9KWAVmrRPEfEcFInH9dymJfmdUMlY8JEl2PDyp/rB+iywfqOfmc0FXbqQpF+O+6DX
 ZssW6DLQkaMimJbSPLjrfUsGlEr5ykJs+7AgmbSFI9qFiAtXqb1/6M3A80paHKLvgxQDjVxmBhs
 8JiCh/hvPeBNmwHPGtIN+m4prdroHQj8M59piblu2sw/HcBs8516u7tluFn9B11nJCE/6oewV3D
 BcbeG9aan2LzM4ktAMQ==
X-Proofpoint-ORIG-GUID: 8l3fwn_EzGuB0-bu9baqXLKCiAxM1xQC

On Thu, Jan 08, 2026 at 12:39:22PM +0100, Alexander Potapenko wrote:
> On Mon, Jan 5, 2026 at 9:02 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > When both KASAN and SLAB_STORE_USER are enabled, accesses to
> > struct kasan_alloc_meta fields can be misaligned on 64-bit architectures.
> > This occurs because orig_size is currently defined as unsigned int,
> > which only guarantees 4-byte alignment. When struct kasan_alloc_meta is
> > placed after orig_size, it may end up at a 4-byte boundary rather than
> > the required 8-byte boundary on 64-bit systems.
> >
> > Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
> > are assumed to require 64-bit accesses to be 64-bit aligned.
> > See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
> > "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.
> >
> > Change orig_size from unsigned int to unsigned long to ensure proper
> > alignment for any subsequent metadata. This should not waste additional
> > memory because kmalloc objects are already aligned to at least
> > ARCH_KMALLOC_MINALIGN.
> >
> > Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/slub.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ad71f01571f0..1c747435a6ab 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -857,7 +857,7 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
> >   * request size in the meta data area, for better debug and sanity check.
> >   */
> >  static inline void set_orig_size(struct kmem_cache *s,
> > -                               void *object, unsigned int orig_size)
> > +                               void *object, unsigned long orig_size)
> >  {
> >         void *p = kasan_reset_tag(object);
> >
> > @@ -867,10 +867,10 @@ static inline void set_orig_size(struct kmem_cache *s,
> >         p += get_info_end(s);
> >         p += sizeof(struct track) * 2;
> >
> > -       *(unsigned int *)p = orig_size;
> > +       *(unsigned long *)p = orig_size;
> 
> Instead of calculating the offset of the original size in several
> places, should we maybe introduce a function that returns a pointer to
> it?

Good point.

The calculation of various metadata offset (including the original size)
is repeated in several places, and perhaps it's worth cleaning up,
something like this:

enum {
  FREE_POINTER_OFFSET,
  ALLOC_TRACK_OFFSET,
  FREE_TRACK_OFFSET,
  ORIG_SIZE_OFFSET,
  KASAN_ALLOC_META_OFFSET,
  OBJ_EXT_OFFSET,
  FINAL_ALIGNMENT_PADDING_OFFSET,
  ...
};

orig_size = *(unsigned long *)get_metadata_ptr(p, ORIG_SIZE_OFFSET);

... of course, perhaps as a follow-up rather than
as part of this series.

-- 
Cheers,
Harry / Hyeonggon

