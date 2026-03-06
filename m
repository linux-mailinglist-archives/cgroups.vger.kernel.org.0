Return-Path: <cgroups+bounces-14680-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGUdFVdzqmkfRwEAu9opvQ
	(envelope-from <cgroups+bounces-14680-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 07:25:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0C21C0C1
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 07:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 759CD301AAB2
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2026 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA073370D5E;
	Fri,  6 Mar 2026 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ue5M9tke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hsYAnB4C"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3E30EF88
	for <cgroups@vger.kernel.org>; Fri,  6 Mar 2026 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778324; cv=fail; b=Ee9tqNddmBPa28lVhInj0GSjxigYOVn1e6xQuKP7TKRzOmcICTOzlv5uNTk1VpFMMslMV+rFIH7kErFSFUyX9KQxBthpoxEkF68s3Gm6GHrmms37laKJJ27XmDdTLTpViya0jJSxLXaR3VhEojbq2DPzH/3Wyl9v1XAudjzNcn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778324; c=relaxed/simple;
	bh=askqgw0qG42q8F5CC3wITPPDA72vrDB+nGoCNaVaI7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EbvkVnUkty58T14hjUPTVDrRIb8lzW4A3ViZNGR0hLDMkrbVa4lEaAZbyEolK9bOjlnSWWyoz9TMM/v01ikGG8UvFx/krfU9q5cakOZaXYvxcpwz3M4LUNOVl7FcPYc4XRkiHEVgf+7ZXxKZKwD+DJgg7J1wZvpVgxdGTjtjCRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ue5M9tke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hsYAnB4C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264pGhn3919068;
	Fri, 6 Mar 2026 06:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=D9DziHSCuvDFtbG8+t
	TKi+ImGF85NRaTIFZsH4YmSJ0=; b=Ue5M9tke9sfPHuVIR2xD4o7gcQGug+qPRf
	1A/SQ9NOg3ACGp20Jt5fPuaNM4WLzafYgBCYRJBBoDcaRq3hIVMPtltw1eNW+llj
	MUoMEPyQTDKBf+rpLLLvxHfqCuMKaNaCXv7XOldBncrb7K3QCY6R46j62LuLJGHQ
	bsPEA/RCS/S6rm9ngzp4t7J2He/BhUDHSarrDRwsOKblmPLtuiceRTXb8MXMqhWo
	Nuj+Bwg2AQxu/GPaW6JppmhvHB17hADU/BJzg87yDebklKpeT+OsX5pEVD7vHPL4
	511tk00CUgsXfCT7jTukCQMuyPuv8Fc49bdbQUXgY2hG9LZdXQYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqr8xr325-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 06:24:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6265e9jn036916;
	Fri, 6 Mar 2026 06:24:51 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpte02r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 06:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/m6aFMgmDQmOfvwnjBT4AaXAhfgwqcIQWLBWxKO83AM/cz0MrU2Dbcf2D9zbKocrL7i643wf58S0VTxuiAcoD0xDcAmT7XNngWu9kPYIMfth3Bs2gIFS4yBNL1psnT6rT15++thQ4PPesCgVTy4yYwXSoEfsERjNCocuIoIkC3CTZJTNdCETTGplvaAuwB8shOpA0AMK8jiDl1U8YPA4mdTvpDaGlzhnjyhOsAQBRTNhgx8Xoe1mqID3qOYyjNPzZeVSpLXMTvTpSQZigcy/8mAa33Ns5d5eq3oYHFQVYXOBlm0EeWIixDEUt8wbXs7v1Fwq8HQ8ab03y1dZejwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9DziHSCuvDFtbG8+tTKi+ImGF85NRaTIFZsH4YmSJ0=;
 b=REwM/5o5izTGsNyThV5/6uEokF7RIKXg+UvDLP15Vbry71dMeJjaX4nmH4TWsTC0k1eSfU77ckAyYQGanL9qn5HE8vkj3ZM9HbfqKRwJ3Mbpdr/gbnPSib+7Dd0xL1+jkYDL/ZHn+uRofvMzk1iGc1/w0xnSqXXPdS9JFCi2Ldj2OT6EVEiTtZKIFGKoU9evw6QLHY5xphD9LsD+EKgCcGx9HZL+rhXw75favSsh+PQ5Z/siunU5Xctd0aZm+GAa+bqvD+1WkWkKPYSPoriULjS2fbJOZiHRXEuFbd2lMUtuzYJ6WM/a2btmy5XgkoJLaaAbHEn8VZ75KhYcu3hrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9DziHSCuvDFtbG8+tTKi+ImGF85NRaTIFZsH4YmSJ0=;
 b=hsYAnB4Cccpfwdp1+ON/bQHKk3QJMJGpeWdrLM0/oyfXxi7bXy+wG2tmFZVifF/L3vxo0f+8I9a0SYu/8A9saAP3JGejM3FmySxmULBBrcP1pq1vbq5rbptO9E/rFFZA1Sk54z8yerRrwVUg1I0ivWGwjRuqWVWIne0/1DJMGQs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 06:24:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 06:24:48 +0000
Date: Fri, 6 Mar 2026 15:24:38 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cgroups@vger.kernel.org,
        cl@gentwo.org, hannes@cmpxchg.org, hao.li@linux.dev,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        surenb@google.com, venkat88@linux.ibm.com
Subject: Re: [PATCH] mm/slab: change stride type from unsigned short to
 unsigned int
Message-ID: <aapzJhEFWejRGjxb@hyeyoo>
References: <20260303135722.2680521-1-harry.yoo@oracle.com>
 <koh6zoceul7tixkkup7f5vfhfsuzeidra66qrfmojh2izt2epm@aryxsv62nfft>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <koh6zoceul7tixkkup7f5vfhfsuzeidra66qrfmojh2izt2epm@aryxsv62nfft>
X-ClientProxiedBy: SL2P216CA0206.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: d68ea632-8e0f-4bc0-886c-08de7b4910fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	/QgUL8d5fxhzPJ6qdTWzp/aLBnshqWgQT7XpIAAxUeoEWM3o13cHdHJol2HncM/f7Q9dQ8HERb2opBF1V+cHy+DQeybrBlbV3F39I7sT3bDG2yVmwNzaAB4Rkw9xk1+yQ5DCwOi5C5WulfsvHMQ2FGGE0rA+u2mzTATH0TkxqDdk5ycID6hhsBYAGzFojyZ5MQ3KtBW7A7c4WkdFDnRxEgFLulghkJQy+79lrUGR6oiE1WRLvMFXnARh2HA758nv6Uhygrt3GYhVXtASg4doQWn+Un0DRv4sAsrja8gi6SgHWRnfUU2+LXcjyyb1uA55kiOvdQOcXjaFxlnI9Fge9DLkvRHpDMpmd1dlm/IUIxlLpn7kydD4IMmAhyS9XnHa0L5m5GRJepcv11IHDVSFDiFfyg5CSfSotS93hliKxP81/oL/7DGYrbvfvvTWY8t6Lj+D4bektcN024KkmHq/wvNGFziru/bWHsgg+To1qyN2IPPuUFIndi0tzQ8gxnglevb65hRlBjQrE9BRgRyEFNHFe4V7scL+PDvN57db8KpymNVxjGAV5N9XZmIMKfjFKaZWKQEqJRhxILYBN2Zr1JTCYRjXsMqyvhOVLjcdhhhkTM7ZXcyrnWCZR7NkxYQix6t2pYmfAd1KJlkMUMAHA0axkGVN2M6vtUiCpCbf67KvFg1/NL7G3lEnGOmON8Vm2D+UrF3XcpEuPOwhewE3oWhkvcMg8SRYTNKwv03fwN5M7TQlP13pGHmds9vUlI1E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jfTVzagCZFZaduRU9sQrtAVhpnzp3R+9APNT7kMMn+6Vm/T9UGYGHgBoBden?=
 =?us-ascii?Q?zrslwMHbKEULedvMYZb7DnOPFCY8aqmw25SRFTXgUspRYTu6KAsULuyEByNC?=
 =?us-ascii?Q?vSF1Qm/N7hJNgroL95jmHcqoqJzHSkmRKaujuYnDVcBdGX+d5T3W3+KfPhNp?=
 =?us-ascii?Q?J2gZI6eZfH19dAIEWnRi3QQsF8b5qVYioeYaq5TmDLPgcii6ozrfNt/M/66W?=
 =?us-ascii?Q?teO73fiUymn6Hb7LdltuGAjXzVijWWBSirHPRM4lC4P6hemG1ccTpeKseHBu?=
 =?us-ascii?Q?G2Dd8Lsw81cmpfA0xikC+jI5NCPpxxTZH+VtRBT0WISK2sCSzvtM+Mgs65te?=
 =?us-ascii?Q?0JqmNmg/Nz++rAd5CRzcnWdu9U0zoEOMDdD+493PryTJrHtsPpYmBzDhs+gF?=
 =?us-ascii?Q?UAqM3ApNJ7HvzhNAXzowtDGBEnfF9dFbCOTk9zhVSSlv94g96/ATN8kFOzUm?=
 =?us-ascii?Q?IKI3I9A3KJMtc5XlsbPnKMxTDERm60+KsIKoaZAHW+ezzXzw9ErXVA7HfN0W?=
 =?us-ascii?Q?XQZt32194n9JBXpRVpq7v3Ee6DGUrxPtIk/QajIS6zZfb7RH0akbrae0a4Er?=
 =?us-ascii?Q?PQtXW/MwLshpZjjToy55oy9QkDvaJBCDQGs8JuHpn4nohPomP68WF7lUW/wU?=
 =?us-ascii?Q?wylQRGiXoEbgPuwKsGAdjb7iIt3PJFXQfK1ETbMXv6SYaQFV9+EkhFMVFseO?=
 =?us-ascii?Q?WW+1ob3h0o0fqKCMl/dOlcLoS99fo2zz1rN0P4I75V3IHm5LpnaxMyk0pKut?=
 =?us-ascii?Q?THUCHFKOWshZtGKpfmmWTJNhy9sVCKK5EIIeZcUBkNLyyB/Alw1p1BEX/Z7O?=
 =?us-ascii?Q?wS0JB6nwokWUy2tPCryxI1PNBgZ1KS/v9AT/eu59KpAhmh4m/EHXCHuNNoHN?=
 =?us-ascii?Q?0jq6oXf9m1Ta5UfrSprUjYPzitWLzlyscHo3BZ4nP0y6ap9fno84FHiqdWtF?=
 =?us-ascii?Q?bLl/vgdl49OND3ArkQRYy0QLRz3oGyqA+YVHTo3R7ki5P9tLvPa8mCvxiqTH?=
 =?us-ascii?Q?kvUczJ/UdGzuif24GH+pvxQM1hWP/InnzvGvh27QvaMivvzvTOfWjVsR2k8U?=
 =?us-ascii?Q?3ymVA+Qdi6SU1j5Ciee//g+o6exL77GmMU6WCCwMq3EJ1sETNzANJiEFkySk?=
 =?us-ascii?Q?ikOsBjesru413MaJ1UnckUMdK2spVVmYWTw04NJEpoXYFYnuF5HNkn/au+oj?=
 =?us-ascii?Q?bi+C1Eidx0ahkvdWfqAmHA968MdZnx7LJinZCImOMnAvt0eLp5XgyZCpOIug?=
 =?us-ascii?Q?bARByDL2CHPbfqXSo0AEGcNb/mmcjt8gmIWnCCf2mI99jZ6lzOWzOrOd6KZP?=
 =?us-ascii?Q?vvsxI4Vn3VL4JHd/Bl5XILthdyFJsU99p/Cwv/sWoNJCLoj+I3YjuQiKnWON?=
 =?us-ascii?Q?P1/n6VrwN+hQPLIAPxbU3nYIx29PLNUR09g3K1HJ1Q4Hnszd1uo5Mama854h?=
 =?us-ascii?Q?XsSuYgBOqfZ1MTCfnuVDn+AVmsYh77oInIbvv9+8QleKqlkQ2zsVcYAlqdgB?=
 =?us-ascii?Q?5Lj0iBZ2yYzSBQ8H+ZUsjhPuiK3MUiJqLRNQ7fOWTVv/4EjcRKFZqEWoYv77?=
 =?us-ascii?Q?Aacw/tWU9zpiv7UZoSbwghMBm9SbIPS6ndkw+XIGDK+rnX7gzi8Kp73/lWMm?=
 =?us-ascii?Q?LOQhIKYbct1fKzIFJMJncfNhJLCHJBS6+3WEJL9CExb+X6bcGaL52NwztVAj?=
 =?us-ascii?Q?p3/KPZkp6ydRJInj8bKx/LMgvwRt16KFy4XbyKJD/fXwnS4ACoS2FUXL7y1L?=
 =?us-ascii?Q?5Ee1K2X6ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iFInUwA2JltMm6k+56KcfE2pd1w4LUaQi8AykXEoT8Pho5pmVAaYLFgP4nmBGf5EPnTWjmUUNU72m5VVU0tIlZ9ceGvD1Hngg1uGbRlhYVEBSvYKXzPBKv8kb9lSCJ8UdBwpABNjCXlIPmTMqV/+RlAxoDoof9MCUhVgNUO9bNMFdfAvrfpz2PGSYxgd7cTFy4W8xI2R5SDv4XNRkl1QmoTCsuJ4XCTznZ0mXACCnvF/eZ62OizNw2c04Mx6+jg+MLPw8XmLH8vEMZagJet93Lq39VBBLuvpt+Y8LznXfenf4X2tBM5F7xEvEoW205AOjEhiAPb9rClFvthk1ZdKdOCgEZPO48QX44b+n0yUhiMfvAMvsBUkuvu0jXC+ZUGDwjUrrckJHlHFUZglnkVIghC6K4x51vVIAm3KP/uelHiKUdcedv2ndKJS+HX7uFvO0xvK5+YZqPexFA0rw2JSFX0OuzAFooJzV+dD1WjEDbzFdrQvrTfuqrRzP07qBKA8uorI4hqzl83Z01kG1RlKPtSt+H8Zm34u7kwbU0172sgMg++vE+rJMhfe37Ut3n6+JiNsSCBOglYd8qE6YlomwAUD7kutKuh/baVPPFc75u0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68ea632-8e0f-4bc0-886c-08de7b4910fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 06:24:48.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hdJkYXsu2kI94eS4O905QYEHO3JhwHQGnmivB4GPCfsnNDT40SkxjaQ5t9d6oC2d6zcWFdsCoUagvKHx9tA1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060059
X-Authority-Analysis: v=2.4 cv=DqJbOW/+ c=1 sm=1 tr=0 ts=69aa7334 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=PH5Tzu57Fri5wPsWqzYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mMRmL5rukDAJtuInxYv5AkntE43NctVi
X-Proofpoint-ORIG-GUID: mMRmL5rukDAJtuInxYv5AkntE43NctVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA1OSBTYWx0ZWRfX1F1TuTzQgxCa
 YskAuYGnLHI1ooBZ5JssNoFkmDjRfoUvmqxIVbu76L/jvIdAwAZG2512LN5pikB5hhsaa9V3nvV
 sOdJUNY5OepU3IhkpKZlnGoCds7VJrPO8Of2y2EChVl+ujInGOLCeEVyezMU1RWWHzGuQ73YT6P
 2dA9y8u66fdfHU4/yIedM4qDaZzue3VVr9cQZ75DTG5A62l0NzuDCueZanpJ7S6DBcd2resjMZ9
 xrHzQySGnaqG4/VBHLUNuuG9b0v5WTrRGt7IK54LLM4Ik6u73LBbqZ8Q3YLv1O7EywkBqjI77o0
 8y1k5MH4BXSrM/EvXbA+lmVbUOi1amrQpgyVPbRAnynpb7f+bHFunyzNZRXOO/1VVrPaFossOB2
 JzIDCJXfJ1f2niD76E+wo4KOfncW55DDdYFS8UNCQPEhiCIVrGJeUJkNK8/BlrlAuTTiNKwnaJV
 Yhuqr5VylYQnE8/ZgOg==
X-Rspamd-Queue-Id: BBF0C21C0C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14680-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,suse.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 01:38:00PM +0000, Pedro Falcato wrote:
> On Tue, Mar 03, 2026 at 10:57:22PM +0900, Harry Yoo wrote:
> > Commit 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > defined the type of slab->stride as unsigned short, because the author
> > initially planned to store stride within the lower 16 bits of the
> > page_type field, but later stored it in unused bits in the counters
> > field instead.
> > 
> > However, the idea of having only 2-byte stride turned out to be a
> > serious mistake. On systems with 64k pages, order-1 pages are 128k,
> > which is larger than USHRT_MAX. It triggers a debug warning because
> > s->size is 128k while stride, truncated to 2 bytes, becomes zero:
> > 
> >   ------------[ cut here ]------------
> >   Warning! stride (0) != s->size (131072)
> >   WARNING: mm/slub.c:2231 at alloc_slab_obj_exts_early.constprop.0+0x524/0x534, CPU#6: systemd-sysctl/307
> >   Modules linked in:
> >   CPU: 6 UID: 0 PID: 307 Comm: systemd-sysctl Not tainted 7.0.0-rc1+ #6 PREEMPTLAZY
> >   Hardware name: IBM,9009-22A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.E0 (VL950_179) hv:phyp pSeries
> >   NIP:  c0000000008a9ac0 LR: c0000000008a9abc CTR: 0000000000000000
> >   REGS: c0000000141f7390 TRAP: 0700   Not tainted  (7.0.0-rc1+)
> >   MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28004400  XER: 00000005
> >   CFAR: c000000000279318 IRQMASK: 0
> >   GPR00: c0000000008a9abc c0000000141f7630 c00000000252a300 c00000001427b200
> >   GPR04: 0000000000000004 0000000000000000 c000000000278fd0 0000000000000000
> >   GPR08: fffffffffffe0000 0000000000000000 0000000000000000 0000000022004400
> >   GPR12: c000000000f644b0 c000000017ff8f00 0000000000000000 0000000000000000
> >   GPR16: 0000000000000000 c0000000141f7aa0 0000000000000000 c0000000141f7a88
> >   GPR20: 0000000000000000 0000000000400cc0 ffffffffffffffff c00000001427b180
> >   GPR24: 0000000000000004 00000000000c0cc0 c000000004e89a20 c00000005de90011
> >   GPR28: 0000000000010010 c00000005df00000 c000000006017f80 c00c000000177a00
> >   NIP [c0000000008a9ac0] alloc_slab_obj_exts_early.constprop.0+0x524/0x534
> >   LR [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534
> >   Call Trace:
> >   [c0000000141f7630] [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534 (unreliable)
> >   [c0000000141f76c0] [c0000000008aafbc] allocate_slab+0x154/0x94c
> >   [c0000000141f7760] [c0000000008b41c0] refill_objects+0x124/0x16c
> >   [c0000000141f77c0] [c0000000008b4be0] __pcs_replace_empty_main+0x2b0/0x444
> >   [c0000000141f7810] [c0000000008b9600] __kvmalloc_node_noprof+0x840/0x914
> >   [c0000000141f7900] [c000000000a3dd40] seq_read_iter+0x60c/0xb00
> >   [c0000000141f7a10] [c000000000b36b24] proc_reg_read_iter+0x154/0x1fc
> >   [c0000000141f7a50] [c0000000009cee7c] vfs_read+0x39c/0x4e4
> >   [c0000000141f7b30] [c0000000009d0214] ksys_read+0x9c/0x180
> >   [c0000000141f7b90] [c00000000003a8d0] system_call_exception+0x1e0/0x4b0
> >   [c0000000141f7e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> > 
> > This leads to slab_obj_ext() returning the first slabobj_ext or all
> > objects and confuses the reference counting of object cgroups [1] and
> > memory (un)charging for memory cgroups [2].
> > 
> > Fortunately, the counters field has 32 unused bits instead of 16
> > on 64-bit CPUs, which is wide enough to hold any value of s->size.
> > Change the type to unsigned int.
> > 
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
> > Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com [2]
> > Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Acked-by: Pedro Falcato <pfalcato@suse.de>

Thanks for the ack, Pedro!

> > ---
> > Hi Venkat, could you please test this on top of 7.0-rc2 (instead of
> > 7.0-rc1) and see if the bugs [1] [2] are reproduced on your machine?
> > 
> > I reproduced a debug warning on a ppc machine and fixed it.
> > The bugs are expected to be resolved by this fix.
> > 
> > p.s. After more debugging, I saw stride appeared as 0 even on the CPU
> > that wrote it, which likely rules out a memory ordering issue...
> 
> More fun than debugging memory ordering issues, is debugging memory ordering
> issues that actually don't exist!

Hehe, yeah. Just because memory barriers hid the problem doesn't mean
it's always a memory ordering issue... a lesson learned the hard way ;)

-- 
Cheers,
Harry / Hyeonggon

