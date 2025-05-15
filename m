Return-Path: <cgroups+bounces-8218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E5AB8AA7
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 17:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DA87ADD20
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A044D218AAD;
	Thu, 15 May 2025 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hth9vXV+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jtkd7+e6"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993FA20C026;
	Thu, 15 May 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322950; cv=fail; b=rMJlCvIHINivycVV38X1r2YIRtKdv+xwd8LukySJuPs49raIgakEbn0t/EhzwteLxJnaUJqrbomlNpaE3fsUxsmZqmk5eJu+onSjeuBgWP+Vkze2S39Qk+0WffHpr2bu2GbWBJR066H7rTmlJmZzoLO1mLVDRHbSsj4k5XdoJaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322950; c=relaxed/simple;
	bh=GL/2+xOJzuRMrTKE4uMl+A9iXhhjffAJjX9uHtoYIzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ev3LfZsKwqcxe2c8JwP+TTiotSWeQPLAaG8gzi+QTrhqKkLONd98TvheOjQCp7M913ZiTj8NgviAaHrowYm3C49EQYNynugJrkQ+E9LQn+kdoAJAEu4UGk6RCEgJ3vAAd3Nqc+YCf/5Lc1iF+AqIzgPdgyUEqG2EHIk3w5gjal4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hth9vXV+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jtkd7+e6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1oQ4023611;
	Thu, 15 May 2025 15:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kbYU7Xr24lv4LDWcHgoFZsIIyh6VSwT+he1N5bzJ9ug=; b=
	hth9vXV+qlUT49eneUCRPn41j694G1uBBmPq4NG1FkOSyNRqNINMxX21uzMRLMYh
	3srySXoSiRAusIbFNk9L/Wt2OgBumF0L0lcvI039ruPtMCihhz84zWJRt0QsRcZx
	MVCLS2k1SDUTxh5C2p5cXkybE3KmG8ISxokjvHm/v/TY2HkILdU3uH0Zuk/bqLJl
	h1RHR+N2oONitNJiA65EEK1kTG9DYfO/SD2s+Hftxomiv1BFN7zOYGVy4GDeeVNn
	ABzutVyksbQVfLkImN68Ue6sV6WT0Tc65PPTIlrxfM3RkqNJlvg3+CYtiL32AMor
	wOBR9m2H8omime4LSKa/3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcdvf34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 15:28:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FFAotU016209;
	Thu, 15 May 2025 15:28:53 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc34y3yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 15:28:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsxGtABqxljN1IfcFtqFB29pSv8K4Z1eXZPvzcqvzkI1smyHonnsphisN4rnLW4CXoRAldr43VmuOSEpsh3AaZp2Dcj/osxGtXuN6fIYYtFmxiqQMJgSMFVnb/j+Nn0YVmZEdLiS6D+Lra6OMlpOOBOkxX3oIizz4dUxfNCTqX0j1YBzKMLpTx5pIfAp87eVawdCINxdpIKUSrCKNbLcEiD1murHYOZ4OSd2TMA8ObW5YsCKTThtrT0bXWcO1RKSYc7ZxRilzVMFGPdGK1pPgccXqdMaE6eDpUHloTQwP4jfT/HgXLehe1G/N8LvldjbxvAoOU+dQy/Vy5ioXi5JCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbYU7Xr24lv4LDWcHgoFZsIIyh6VSwT+he1N5bzJ9ug=;
 b=E19GGLaQcDhIdcAfbHeWlarTIuJTFTgtLFdaa8gNeX0UJ6TuX7HIT+H2PlJgLDAiT8ZyohJ7KnH6w+SO9zUC0q+xdtS1+2+84W0ImdwHmWxnox/grSosAF7jh6ETXjowk7zfuZNZLgGnfBlzXhP8G6wMOJpNpyiiqC/bMU8V4OCIqhh093NNiPizbGOw4ocxQZuntGdXBd5WX+240qhThl/VeYUzDGt1OFKMcn5qZgKNpuwzAqdF61WX5E4/0bry1gk9i/9biIBOQsXauJ2E438XzhRRR/uL5XPK5LmJHApxO9SQTQBEPRLJWPN48nW5O/1XUakEm9e7jYXAFL7nOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbYU7Xr24lv4LDWcHgoFZsIIyh6VSwT+he1N5bzJ9ug=;
 b=jtkd7+e6NggkOVFdsVX3fD4NZPad7Je15PIZGOhlnI294MYiIF0vr0M8GTyaLhX0+ldKQR9vDtnLczS7woWB9BwQgWc6A41rnMsXjrfrzUJ1hlf52CZRzKRZFA1SgXJcgNwLnliu8hdyREfkwUIULHgeVHwWvEh+GcAOxWM2KCA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 15:28:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 15:28:22 +0000
Date: Thu, 15 May 2025 16:28:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Alexei Starovoitov <ast@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe
 against irqs
Message-ID: <7349271e-25f3-44e8-afe4-29ab1019b8cd@lucifer.local>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
 <20250514184158.3471331-2-shakeel.butt@linux.dev>
 <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
 <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
 <a0328dd3-db4a-430a-9018-db796d0cf76e@lucifer.local>
 <bdxkbztn63ey4pndh3hfzope2bnysw6yyqqzfu2sdjue2glujy@5eqev4hldzxq>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdxkbztn63ey4pndh3hfzope2bnysw6yyqqzfu2sdjue2glujy@5eqev4hldzxq>
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f22169-e009-4ea1-ec21-08dd93c520a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V20xSnlvTjU3alEyNDUzNWl6MjZKZ2wza1JhUVZkOG1pajh3TW9hNDRwL3FU?=
 =?utf-8?B?OHdIdVUrZUxtVUgyTHpQNldJMTk1Ym96Q1BuMk1VT0xRbHdGS2lLYU5kd3lz?=
 =?utf-8?B?d2VUWGVtNW52ZGdmcnVITXFaT1FaR0ljZnhBZ3FsVUVwVitYVmd3NGtZQjdF?=
 =?utf-8?B?RnJwRmtXM2dvVWNtd1c1MXhBSm54L1YydHVnSkZvU1lnSStITjFGQnB1ZDln?=
 =?utf-8?B?V1ZpRk5Eb1ZRK0t5VUxtNlJWeXNpR21jSlVVTit5ekdtenlKMnJVWldKN0FB?=
 =?utf-8?B?Wi8xR01MYy96NVhWTmZvRTdVZEpDYmxhN1htbGpibXdXRkd2WC9ZamptOEtk?=
 =?utf-8?B?VGFBNmJ4ZnlIZVM4Q3BGQnhlMmhTSktBMG5QUFBoVFl3QWp0SzVxZHdERUJF?=
 =?utf-8?B?TmY1NkZTM2NMN1VLcStqTEhNcTMxM0ZSdzBvaFg1elhoUEp3MWQyZTlDZzNR?=
 =?utf-8?B?Yk01YmJhcVRNUndHc2R4eW1QUHlhWkwzNks3YVBkSzJ6QTZhQytaS2lYbWJm?=
 =?utf-8?B?ci9ldWZRSzBSN1h4dmUxN21GR2RnUVdZeXQ0Y1NuTHNYUTcvZVd6QTFrUUth?=
 =?utf-8?B?cGd1cW14S1lXbkJjcktWaHNiNkNUWVF2NWVxWDhxTXZFTktYS2RVTEExWGNa?=
 =?utf-8?B?QUhNdzBjRmxjVkpUUXhBckFNMi9iQkdkRmxqRUJCT09RZGJuWVBIeHg2Ylkx?=
 =?utf-8?B?bG96UFZ6cWhCRUJFN0Vtbm8xei8xc0VDOWx0b1QxRUZUcFUvcDIwU09obHVX?=
 =?utf-8?B?WjVyQnN1LzQ3R3p1NG5oWit4d2tRTklmY0ZJN216NUxmOTgrUGVZbWc4ejY0?=
 =?utf-8?B?QTBKQk9qNmpFUVE4U09Qd2FkQXF2RTBJTlg2NkwzZFlHVFdqOHJ6ei9QeVF3?=
 =?utf-8?B?QjRMdnY2M0MyRGc2UVovK3JmYlFjS1k5b1BHbVFkVkYxRVVKQ1FrZnNQM3VY?=
 =?utf-8?B?UUxqN2wvdGtvMFAyRFdxYU5ZL0FISm5QM3d6TGVkREM2cDVIL1E1REJ5US9K?=
 =?utf-8?B?aSswYVFzYWV4WUIxZkY3VlQ3R21ocHltRHVnaUtDRTBUOXUzaXE2UjUrNEp0?=
 =?utf-8?B?UUdlS2owNk1Xdko2c05RUENuMmJDWm1rb3Npb0MvSzBWNURVa2Z1REVpWEc3?=
 =?utf-8?B?dDEvS2FzS0ZKK3JTZE5nK0Qwby9yVklsdTh1enFvdVoxZ0U5SkpmSjVWNTJ3?=
 =?utf-8?B?eFRXUWptazJhNk16bUUycmVMblF1WVpxek4vSVN6R0NOellaMnZqVUFka3pr?=
 =?utf-8?B?SUFXcDE3Vzg4cG9mSjAwUFlEMnVTNEtOQldWM2tKeFp2SlpNaGxkREh0eDM2?=
 =?utf-8?B?R1oyL0dIL0tvZm9rb21CR1d4YXpvdG0rc0VBRW1MWXEyZlk3d0E2d0lSbFRC?=
 =?utf-8?B?MGdPVXFRZkRRTXpWbXRJUG5lR3NCQ0xyZnpuYVhUTjRCWktid2ZLSWFHSVE0?=
 =?utf-8?B?eFpwakFMQkNZVFVCaU9XTFJ1OE4wNFQwRWNZTlNkQTIvMHJSRHA2MFBRRWZ2?=
 =?utf-8?B?M0o0Yk4yZ2FoS1VUcjVOS09RRGlmc01NTmZydzJwakRjM3R1K2lTZ0RlQlZD?=
 =?utf-8?B?eWZuYW12cy9hSzZIMHJ4R0F0V2xwZDNDUHRtMHRqYkhxSmVhdU45VnVub1dp?=
 =?utf-8?B?Vi85RE1pT21wVTZZK3Z1MkN5MXNNVG5rckhCcFZVUlpKMlB4amNGVEg2VnM4?=
 =?utf-8?B?YzM4VjJRMVNqZGE4bzhtUnMzM0UzMVF5Q3BNaG1wQXZqNUZIR2tSWXMveEZ4?=
 =?utf-8?B?dDlPZHlwb0tHSmp5T0x3ekFyVEY0aWkyV2hNdStiWHNVSkpneUZIeXNhRUNS?=
 =?utf-8?B?a2FOSE0waG5oN0JVNGo0UHFDTHlWQ2NnMFpPU2o2T05wT0dpVitMRjRCN2pW?=
 =?utf-8?B?UWQyeGxzQ09Dd3M5K1VDRHpBRkJTNHYxYW0rYko0dzBYWXRzM3luSVlJdjUv?=
 =?utf-8?Q?WT8/TKK9qhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUxqeWFZVWt6ZmtBRCtpejB4Z1JvcEhTeUYyL1VNRTRhL2lWVThjVHAveTd2?=
 =?utf-8?B?MyttUGNSTXlZMzNkWFIrWklocUxYNDFUZzN3a29wdzhuYlB6bmhFZHBweFhS?=
 =?utf-8?B?WkRTOFJsTGpmQjRrSUdwRTRzVk1GMlNjaGJ6MDNCSXJ6ak94TDJBY3I3djJK?=
 =?utf-8?B?a3k1NkMwb1AxcVpUSUN4SUJkZXRKRSt0MkRWRlExK3pJcmdXYkgxSGNWTXFT?=
 =?utf-8?B?Wno3U3NLVWNTNk1vQVAyN3FTQ1BDekR2M3RuYnJ2a2JMSU1rNEpCRnBEV3Ux?=
 =?utf-8?B?UW1WNFhZczZNQUNud0JvdVNtWExpb09PR0txcXYzZUgwdDZxcVFSMzZhemtq?=
 =?utf-8?B?TjJrMlFkUWorVjFLSjM1WklHbEo0a3dqUGcrTnBzUmc0MjNtc1hKODd5cmZz?=
 =?utf-8?B?bTVtSVRRR1NFVlo3SGtMcDNKd25hdHpNaFlzNEdjTVJGdksydHQ5VlR5VmVB?=
 =?utf-8?B?SUExazRvT3BuL1VEZ2tURWlLVU5DeDI2c0tOemVNUzVZbUdvVTdoMHdrcmVQ?=
 =?utf-8?B?bEdnT0FoYTBpYlFOUkZ6aFBremZhVUtFQjV6TEZZRUFyZjVGemppVGRQREJ2?=
 =?utf-8?B?R0lOekxBMmxzWUxjVmhSZ2RIOXVHVEsvYjN1eUVKUTExZk5iN000dFRXeXBW?=
 =?utf-8?B?WmFveG5hUnVoeHY4UEswd2hjZU9BWTNUMzBIMUN0T2RuMjUyUjBSdDNtSGsx?=
 =?utf-8?B?OVJLM29rYkhXMVJiQ0pJQzM1QkNJVWdUSWNTVlNCcUIyTmY3MGZGQ3JZdlhp?=
 =?utf-8?B?Y1lGb1pvZWNkM0p6UTRtdVF3blVqN3dWSWNpODJ2WWZRN1pVblFvUTJ1SWQ4?=
 =?utf-8?B?S3ZTb05jMmZLbnhWd0U0L0RLckhKTlltUXBOVzRIYmw1NTBEMEkxNFl5OVBQ?=
 =?utf-8?B?YVVtWWVyZm16R3c1ZGp0Zmc3VWxnOEo5eXBDMmpBVkFqL2RFMFVGR0ljcXp3?=
 =?utf-8?B?STVLUGs0OHU1QkpZVkx6L3dtbjc4cnBIcVJldzlHTk5sazRCREVqZk42ZFQ0?=
 =?utf-8?B?bW94andsUGhOVDhSSVo1SGdJWlFYdTRId2htQUJhNjZnWm4zUWhweExPakxh?=
 =?utf-8?B?bFdYdlRjNDVEUC82am1WcUhjWGprS0NyRmZWVHhOMXJmSHU3VTdISGVYanFL?=
 =?utf-8?B?US9GSURoNmZYVTl3TDBPRnJTSnhxak8yTUk5cTdyY0NKVDltd0pVTDVuR3hL?=
 =?utf-8?B?TjRYTDQ3QlNwQzAva2FiVGVCRmlMenRVTEwvakN4N2oza2FGdFdhZnZkT0gx?=
 =?utf-8?B?a1pLa3h2RDlwUSttOGFEa1phRGlIem00amhoclJjbFNCK0l5OHBuWGhCRFdN?=
 =?utf-8?B?OUtDWXVQc21VVXhoVGdkTVNZZE9uaXZ4QzIxM0JVaWlaTERpMFkxUlcvNTZQ?=
 =?utf-8?B?bUhUOC9LT3JoOWhpeklWV1pqZjQzZlIxYWx0RCtxdm9jaXQ1Y2RGWlpaeUNF?=
 =?utf-8?B?MWs2MGRBWEJmTnBqakNRREM5c1hzaGRXSHh5K2RReS9nbXR4VXZRbmdvalU1?=
 =?utf-8?B?UHprU3prbStDZWNYeVduZStBc3c1T3Bla1VNODF6bTRFcmhsNzFScnp4MEEz?=
 =?utf-8?B?dXJMRytZZklsQjlrOVZkZDhlNFUwNzFWV0JBTlBqVjI2SEM4KzNhc3gydzN4?=
 =?utf-8?B?NTRISnA0ZGtGNmk4RDQ4V1lhNGVRSkxKaGVvc2VmcEcwaXBXaGowWGtNNk91?=
 =?utf-8?B?S0J5Qy9MaVdOdFd1UU5RaEp0ZjdGUkUzNmlGZTFROWI0SkZiT0l3Uy9lN3lh?=
 =?utf-8?B?U0hYY01zV2lLaUpMYzNOc3VST3A5WVI2QVU3aTg3ekpBakFicnFBNm5qVVdh?=
 =?utf-8?B?RGRHWlZqYkp1cHNjQlcvQmRzTkRaTENLNlRMOTI4c1pVSFgvbXUyT1IrYzl3?=
 =?utf-8?B?ZWd2NXRIVzVWbi9NWmYrTWhyZWV0QkhtbjZIUStiTVRXWWhjQjlKSHNrcXBS?=
 =?utf-8?B?KzdXbDViM2JiV3RUV3hEbU5FZmN3MG00TXpEbFRPUmRHVjR4K1Q4Qi8rZVBu?=
 =?utf-8?B?QTY2dVcwWDArMVZvYlozRDB4ekY3NTdrb2w2TU5JZzRMcDB4c1RpVkxnTE5Y?=
 =?utf-8?B?WjRoR25NSmd5RFR2eTBlVGVrbWdRUHhEYmMxSUFqRFltYTFxTWd0WEJXaG1W?=
 =?utf-8?B?YndHb2ZObk1uOUNJZVcvSEYweFNqV2N0aG5JWVFLS1UzTEhtK0lGei9tbDBK?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2iEvu73+NZu/LW+2B2yKR3ySzmh5ngkkKh5XLY/73Oh7WDdB7tv7PGxrMZqAHBIiirXCVPXIVqlKgmTVvsi3YoakOFw80VAceW4u6UQ0cWaRkcnQ4jKdEVL952MeFfQ39IbQhE7Qj29WSjoPE/hveiar69kOd26CxAgdY1TBaLeThBVnVfDoZWkaVUVayCAKyHs+lfSMiodun4tO2RyRvFTFGo0V9kE3mWnHB8ovgb4JTg65N0jPlPJZLl5ek6neWUe3A9LCVdYNWYF8GW5b5vVhVDvEzUOwQv7mxLDNVPPGLWlXW3A/5dHdZvpoZjAcBlVg1/3H51YbWXwiN4yyrtI9YKT4d1OcpDgIxyte13HNuYzJV8u9EMrNQP24qr5MrZiQjeaoTAmliuLQ+oIdmExXw73enEJSxLbbxOKJiXXiKiO/cxNx82mhZYbX21YRNc848YhHuwwvSRMUqLP4zsv2stEMaBd4FI6XT9gEG5U2bDw7UwecBF0U3xsQSx6dAlGX8Y6cHs6w0WVBFtwLAJERJVERzbkW+Y80Bvlbx4Xgrvaam/w8Y4XToZ5jhHcTBdiUCZk492O3NjjCixhkO3RI7rwfEqXLbncmu82HOOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f22169-e009-4ea1-ec21-08dd93c520a8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:28:22.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaKXFfx1/yfgAikmCEMQ4wZoaOv9mZGz5K9qGdRBLME+cb94lXDos3SKK6CCMGxTXI4V8kF20YXVQC3q02p1m6s4PKve+m86YWEey96Xicc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MyBTYWx0ZWRfXzmAWGfTaI9aU 2WOdB2H8hDEiQuPbfPzTJY23jUtq+BXpRGJ4CAtO/AWvcEfYdM1Av0ylLm/9MEtM1OEAex02Ged bcVHgPpYwwPHoQBo4BQRgwiPm6bb4URFKOCLVBCgTFCJLrWtEObWvi6K4gL4OkQzfTrjOLCTrMw
 aRarIOz/H7yrBEAZkZOxIbTVE2s0k9KM/BpA2FUolr2ZLMp43oOAoXtL+AaQ6J/B+r3iREVjqxH AqCP57IRmBfNkBWG774UI7eQYUxBvqWCqqWMDdV91rpm0Xe+cxEuUEgP+UIM5+cR051XvnksuYw LTGxoUYmLtxFWX4cCpm9xuC7ZPkamUwboqfRcIFMImiSso2yAx2ApjOVuD2lOgIqD9d7zbU7Pos
 fb+rPl+2kBOq6s/YNiUTUHIwTnVU/8JdKEonxb8/HH7bmd7FxeOqHc4EI2EDsIlQMYVD0Qk1
X-Authority-Analysis: v=2.4 cv=Y8T4sgeN c=1 sm=1 tr=0 ts=68260836 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=dZMcT9zdXABb4EEW5bgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: MFr6DS6Pfxfz58TS4zgpzOka1lbrw2GG
X-Proofpoint-ORIG-GUID: MFr6DS6Pfxfz58TS4zgpzOka1lbrw2GG

On Thu, May 15, 2025 at 08:22:04AM -0700, Shakeel Butt wrote:
> On Thu, May 15, 2025 at 03:53:17PM +0100, Lorenzo Stoakes wrote:
> > On Thu, May 15, 2025 at 07:31:09AM -0700, Shakeel Butt wrote:
> > > On Thu, May 15, 2025 at 5:47 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > Shakeel - This breaks the build in mm-new for me:
> > > >
> > > >   CC      mm/pt_reclaim.o
> > > > In file included from ./arch/x86/include/asm/rmwcc.h:5,
> > > >                  from ./arch/x86/include/asm/bitops.h:18,
> > > >                  from ./include/linux/bitops.h:68,
> > > >                  from ./include/linux/radix-tree.h:11,
> > > >                  from ./include/linux/idr.h:15,
> > > >                  from ./include/linux/cgroup-defs.h:13,
> > > >                  from mm/memcontrol.c:28:
> > > > mm/memcontrol.c: In function ‘mem_cgroup_alloc’:
> > > > ./arch/x86/include/asm/percpu.h:39:45: error: expected identifier or ‘(’ before ‘__seg_gs’
> > > >    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
> > > >       |                                             ^~~~~~
> > > > ./include/linux/args.h:25:24: note: in definition of macro ‘__CONCAT’
> > > >    25 | #define __CONCAT(a, b) a ## b
> > > >       |                        ^
> > > > ./arch/x86/include/asm/percpu.h:39:33: note: in expansion of macro ‘CONCATENATE’
> > > >    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
> > > >       |                                 ^~~~~~~~~~~
> > > > ./arch/x86/include/asm/percpu.h:93:33: note: in expansion of macro ‘__percpu_seg_override’
> > > >    93 | # define __percpu_qual          __percpu_seg_override
> > > >       |                                 ^~~~~~~~~~~~~~~~~~~~~
> > > > ././include/linux/compiler_types.h:60:25: note: in expansion of macro ‘__percpu_qual’
> > > >    60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
> > > >       |                         ^~~~~~~~~~~~~
> > > > mm/memcontrol.c:3700:45: note: in expansion of macro ‘__percpu’
> > > >  3700 |         struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
> > > >       |                                             ^~~~~~~~
> > > > mm/memcontrol.c:3731:25: error: ‘pstatc_pcpu’ undeclared (first use in this function); did you mean ‘kstat_cpu’?
> > > >  3731 |                         pstatc_pcpu = parent->vmstats_percpu;
> > > >       |                         ^~~~~~~~~~~
> > > >       |                         kstat_cpu
> > > > mm/memcontrol.c:3731:25: note: each undeclared identifier is reported only once for each function it appears in
> > > >
> > > > The __percpu macro seems to be a bit screwy with comma-delimited decls, as it
> > > > seems that putting this on its own line fixes this problem:
> > > >
> > >
> > > Which compiler (and version) is this? Thanks for the fix.
> >
> > gcc 15, but apparently 13, 14 also fail. It seems independent of config.
>
> Thanks, somehow it works with gcc 11.5.0.

That is... both extremely bizarre, and VERY gnu... haha

