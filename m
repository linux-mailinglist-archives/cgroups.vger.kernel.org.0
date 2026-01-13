Return-Path: <cgroups+bounces-13151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C31DD19086
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C33D230C5CA4
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91F38FF1B;
	Tue, 13 Jan 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SiI3A9nI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xu4IgStq"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396A38FF0E;
	Tue, 13 Jan 2026 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309569; cv=fail; b=f3/xKgYjS/6x3Z2k5dH7L25D367CUjWjMRi6c1db3l3Svcx1eLqeme6E3v4yLs50UVHRtLDJmHomoTQkjGbvWjCEqAhEHeypICpng04k9tSdfJYdQ6meMHVK5Fu9/xDACebezzzkqnxuiV6n8n5x5fboKhzsyp4rDKEgVZ9L4/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309569; c=relaxed/simple;
	bh=rfQ5uX1WuAAkyvU4ahC4alalAw/t0x+2osH0kPsBHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V3ygI818DfumkkdvoCpzmeVHpL3LR5NGDzzC1jL5K+sQlINlsn2Lo1x+2JwC3glR799d2P+EsR+V0vtXKpWc/p1W0qrQp4A5frkxfdIlJodIE/sT9tHGjfhXRyoGSCv/fpsPCxSNtMBGanaGAIjWT9RSN34EPfFVj7bzxGcY1dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SiI3A9nI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xu4IgStq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gnw92753576;
	Tue, 13 Jan 2026 13:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fGmnZ0GkPilgKvj1bn
	Jy9cpPBD8RtUJkmhcggCGsSTA=; b=SiI3A9nI/vv7YRwdEZA/Ppidwh1i9BoUrA
	ZSJzkfrqo4pceLI3Fwekq+Wq9PH+enR2vxe4KBSqbJPZI9qwA6S8/41k2QhWJws2
	TNA3rPkxGtZaeXM8cLloABp0u2k5P5ln4nexZK7DSLJuRwAQgp7O36bFHPtPmaKK
	qpN6o6v+uqW5o8fOGWumUEoWDAlRUzw94SlqAGvZEZfXu0BN4t/qBgGaLOb//9Ya
	9n4HmkCrExN9cwCIy0Udm0EtIAVvhd5FPihyF7XCtDwqio7xj6n7ePn2ghOlhywe
	eQkOC7h9VuHxj3chWCnUUCg3byq60CLWw/m3UKbJur+zcRsr2H8w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgkcp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:05:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DB2L5V032743;
	Tue, 13 Jan 2026 13:05:34 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78q74e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfq+N3A9i43rOwBDc6P70ByBfkFHurnwuI11VGPtHenuE6q0d3oBhiI6aNhzJhDFJdfI2r3d8GLBAzBapL0im31NwjyK9Qmz/1uVLBKx0TJOT9VRN2McikNbLuu42Bxny7dTscWLNcxZcQ36ZQf33v/HtQaseCahQtxgl5Pzn9uZ7SYKnzOeUsyROKoFS8S6zKFHQYH3HWS7EJbXYaUMGtJQBHWISvKDKzsae0uTEFohI0cY36aGWMumMNObjguycmntyxN2QT+h46rVbpMc5khLLUqLodsBF30bWS8Oe5syIUzk4oPuF0hdNUg27qpwjVdbExp3IeV1VZQENM2mZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGmnZ0GkPilgKvj1bnJy9cpPBD8RtUJkmhcggCGsSTA=;
 b=JM1XLgX7OXp+iF05Zhl5MwTSERR1B71SS107O1mE6ZQddMRL7HnRrCXck/3jgm0JnOPrh27IaMKtCQTAWme9LFn0+5uNQvwbZNCGioTP4sWxdi3ANcwqIJG/d2MMpTFOg+q/Em9KLJVrZqXLRO3kReD3RQfZaIHQdhT/EW6UvqStQBuDA9PMw5NgFqZ3OfWt4JxScQaTko6yxQuXGbqH2WR3cS7XjqxVbY7GYp/OxX2e9UUapK0//kP0cbuZ1py6MuCWFJ7Fdow+0qFrJYo8KCqLYnddg8MaQurbIo15LNSNzqE6Os3Q3JC7PPofrAWQ11p6yr1Rk+id1Zez64t7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGmnZ0GkPilgKvj1bnJy9cpPBD8RtUJkmhcggCGsSTA=;
 b=Xu4IgStqq0KSIH38SnjfHWNjf+EaZDl029nynnbqaXV3KSBN4cEg0+LIQs7B0gk/cdxtOcLH9ip2WT5m5G03GBnzulIOzwpXHrFOW8NxAaU+Xxoq5u3l62MSIViU7xKN6rL2ye9k2sqWxLNqrNFOPgIijJAdqxqWS+mMWLAAa0E=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5114.namprd10.prod.outlook.com (2603:10b6:610:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 13:05:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 13:05:26 +0000
Date: Tue, 13 Jan 2026 22:05:17 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
        dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev
Subject: Re: [PATCH V6 8/9] mm/slab: move [__]ksize and slab_ksize() to
 mm/slub.c
Message-ID: <aWZDDfq72XP3Uuef@hyeyoo>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
 <20260113061845.159790-9-harry.yoo@oracle.com>
 <2cdff2ed-a45d-47e9-94ef-f8ecd178bbae@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cdff2ed-a45d-47e9-94ef-f8ecd178bbae@suse.cz>
X-ClientProxiedBy: SE2P216CA0133.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bdfab5-8530-497d-f778-08de52a46b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0kV+1sFVMXHJI5+MHpl/mPCInUsTsGIN2IT6YcW022NKHTFAagUpGKvNH/0U?=
 =?us-ascii?Q?M+6UdsmA4rSvMPxGHW/rhwOhtVAWjyoGpQ/ctPzcn2Dsarh1ILh6QGnwtL0J?=
 =?us-ascii?Q?rvqlU0YBhwbSsdVtRFEzK78JLvbcjuyzlJiUN80CZJS08eAGuezyVrzvG/K0?=
 =?us-ascii?Q?Jhv6dEQ6tTHSAezBqd5AbzBzqz84TdDGoX/7iylOgKNGd1dakHbIt8+kFq5P?=
 =?us-ascii?Q?8nq6AS8ZuVKZLPsCIfeikCfqZTHlzvcoEyVmfHDaW5vukV0CAD/w3W/81tJ3?=
 =?us-ascii?Q?QMD6MVQL69uc4phL2p3k4vqXST8fjzWYRZnoe3bkQpb1ywQvJtJYFZfkCRD6?=
 =?us-ascii?Q?koDDA1AlWvGLdR7yVdpKuVZUXlHmJ0AjJl3tDSub/3KjVWfw0/oSNb3ueydB?=
 =?us-ascii?Q?fQQurPWKcENvvXACaNIuHq8S/G+HeeffDa9BmVYxOqrZxM6fYZLDxrkLx+UY?=
 =?us-ascii?Q?C4DPO0LjGjSOa4g3tQeCKa72TFow/uifh79qZOd4B93aqcBePpjQLqylc3U9?=
 =?us-ascii?Q?BcshuDkeqBJEISf+mZlDoBoDmIjbl2aij/5vwQtBoDiIMyne7FiaL1+aB0Vm?=
 =?us-ascii?Q?UnVUhKOU9ipd/piP6l6yh/zb0/wjr8WurwbqbjB6JpsJVaDPcmM5aTvXS3vm?=
 =?us-ascii?Q?OQ2T6lSbDOXmi9YGaFvKOzSnLcVk3lM2+cARqoN+tKDfz1TBQGHQJWmSdH+P?=
 =?us-ascii?Q?tk77nQy3vYo2VoW17t5IfAX0MLNMWuXn2JjnRNsYTJER6VZI/OGsNQ73ashA?=
 =?us-ascii?Q?vhFOJ+m6ZU2yFDolpIJvgatbDaKUqO0o3RtZFCkYSBgXBz8gxvVx7rCo5/KK?=
 =?us-ascii?Q?cs6BY2ErtctU2C8HFFlgLqShykGk93nE014/Bl9MHdaho/SVMxP+buo6nMyf?=
 =?us-ascii?Q?ee/AXCqXGK6sxu26KdMUZFZPywjbO91hqesaN60BgHvGW0YejhbXk1f7S+Tz?=
 =?us-ascii?Q?M4hZZAryP4NjVfCq3Por7N9qOKY1gV0LV9IHUcWXEKhZi610z6fnOXA5IHUc?=
 =?us-ascii?Q?t2MQsNERICmeZtO5HOmL4W35AZZWYf2ab9NlJxuITi3tr6+LRYjKoMMJOzQ3?=
 =?us-ascii?Q?n8CcI7mZ8x/hAzg5GzaEN58Py6foJrgOzlKs5XOqBq5HRNH5LPMyHDioFa21?=
 =?us-ascii?Q?IqpxzeBm0f9l6BFyeMPX93WvXTEdN4rUnxl6HSpmOXq8NhdsaW/bd37E4VBc?=
 =?us-ascii?Q?Wm+MTFwBm8Uq46RgMHp7xHkjMqFLj9HzlXvsk+LwWTWWngkN1uDRHBsMrssP?=
 =?us-ascii?Q?zLFEGTYyWfN0UKP7X20N0W7KnUfsKkY/6GMMjD9nCckv2AZFO/RzX4Z6otdP?=
 =?us-ascii?Q?ngDtJ4YPi6XPINvU0WVNeg8Cc7hy15Z7DvNwCHdWCSdQUXJgCQcd12a2CY/7?=
 =?us-ascii?Q?/yG8cmA+tUscqmlOkMUW9YNn8Gsir4pqZJKlWV5rOc8uNIA6ktEqUglH8MGU?=
 =?us-ascii?Q?BwKexuKQkZrthyqirenSpZ9Rc/6CQ+/C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRMym9I6luC3fY1btQgnym+8nXmzs1d3rjXU+O1r8vayV32TV0fIGiN9b575?=
 =?us-ascii?Q?DVJZvcIXT8rO9/xdgFAZI6uzO67J4Q1y77agzo7mkBRnCEUN3zhwpfgH+xaR?=
 =?us-ascii?Q?bRaScro7Y4MkZUxri/UpvqHZX8BU6d5eCbRLRtFBGkS4zdi/KAxRHnJiDKRw?=
 =?us-ascii?Q?NEriHmsPbC+6y2cdrLuQQ1H62f49SLfat7/rXrR3CvwmSjuC9Xu7yBuvqDn1?=
 =?us-ascii?Q?i6p1jn48IILWFTCvUdIYzcAwvVIT//xvtmsmiNOEhnBsIHeSK1Pq7LjfnKAz?=
 =?us-ascii?Q?uCxODPt21KfEfhthOvFamXNy/GCb3zHyCNtbbEW1+u/q9DYJUWB/cxM/uzXl?=
 =?us-ascii?Q?rmjFu72dEMsEhY4sLUq/0pHNxTpdp5zDEY3eWXmEhM1v5WilogvO3AuzGUDl?=
 =?us-ascii?Q?Ro8o+7+mDZOl/8ldfrBeICigKGvQoWe36bZgwqfNrgfE2V7bA0w5pRmNeQgo?=
 =?us-ascii?Q?WuVDSmhTjIM7jKWVaRvLYzJqr1WU8YDxjt3RSovc0CU6/l/ImCZf389+ETsp?=
 =?us-ascii?Q?cFGV5w7N86PvXM7Xet/FkTKlq/XqvH/CDIJ7+bDavk7mU1VCZksDSBfeGqeU?=
 =?us-ascii?Q?cjUERKQdPRVL+NCnC6s0n7L0vadLDUgxyyrhBEoEymUiTkJfDn7yL9g7LFUU?=
 =?us-ascii?Q?55Y7yUyLj7297aQyuYfPgy3rta/F2JT0kiQFe57fxZZ0z3Aikp85Kaasj4w4?=
 =?us-ascii?Q?PDK92J89D1f1BKzUWUCbeKFuahmaUZBFMBqLwKPgWlWueMeJPXhGKAj/s7/9?=
 =?us-ascii?Q?2Ga8p82wbTIVnZQinHAIvldpCrpUOZwLQRTy6C6oeTuZV5+kMghy4hRn8N2o?=
 =?us-ascii?Q?lrfbsmdjehE1UQwMU18SHSdIoTjgWG53qSbTcNwZ5KEyH0dN2tFrEeYcB8LK?=
 =?us-ascii?Q?p9ti3r8A4l7DfrmjP0cpMSJF7FHuDUykqtndG6uKf3xv32yhRM8fV89bpSHY?=
 =?us-ascii?Q?cnMJOoypUVr3aBx0jB4ds0uTga88NS8cjIBh0I/gQ8Ck7XbHP76P4tyo3Brd?=
 =?us-ascii?Q?Hw3cYXhx1TRp3/Vgbt10m7JXmrop+aZFODZu60/jUFPHedKc3dWPvmWm5goS?=
 =?us-ascii?Q?ywESRz6EkJXcg9e0BrhpDzO2wtOa3qNWhV6MvIX4USX0KMtCr4aGQb6ldW4A?=
 =?us-ascii?Q?QU4EOlU+XQQ8EZZuW/nWmLFXwD5Ds1evVBaZuO4FWorhMmsh3+ENF1q+2G6X?=
 =?us-ascii?Q?ksO8tBiWbTm/yv5A9+QLZv7dH/qItyHWIeNtiqEb40bY/qGsHWHTnwe44twW?=
 =?us-ascii?Q?q5uC/Gu9Et2DmwU8L5v5C0/rXVRMjkLSNQP5bz/loPTpv9+ckvFA+pPCOTe0?=
 =?us-ascii?Q?COmGiV+rd1wuexPQn/J1I53iz9u76J16g61D5AjQP/mVWdWiXboE0og+IXbc?=
 =?us-ascii?Q?c8715KADgq4GUyy/t5OPrsirGIuiSRVs4df276f2Ro3m3OY76jGoAL3MeEyM?=
 =?us-ascii?Q?mz/ZnGnzEkNAqRjyjXPg6SvQAn1CHLMOMypN39SOSVdGEYBZLDtFQ0MhbTNJ?=
 =?us-ascii?Q?X0SBnnw8og5TmxtOG3YDKIWozfHrYYDixnOzwskZStuF09ohKdGR3qK0XHyj?=
 =?us-ascii?Q?Da+QMG4zb2FoTLF+EBu+TcUja2Aua7yz5mVOWmjQVCKq+S9mUYxgvdg9Ow4p?=
 =?us-ascii?Q?sIywXj3I64Oq8ICemdZ1lH80l3/gEf1Y1DHc4IT7sMDZe35ZnBB1TikShfza?=
 =?us-ascii?Q?8mapxCMcm+2CaiwU/cygGWi81uF+cL0SzEdy7hVUkxjJ1qzGn2bM8fBOGAXy?=
 =?us-ascii?Q?yb+M95ZB+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EkwftgYJyAA3aH+RoU0ufNvfaS9FalKJ6TGcxB9FuQZyvQGWshZEqxw553XJWXtIMe6vv+E3Wud8HPAlfDI3qDvni+t5xb1kGozX+2ODWyYzNEo7Fv1v2SYeo1Kkyvj3Uy9p9ds4jaCWyAqD0EOazUadMRz9PShR8ORS+j4FU2bjQ3Z9yl6cPrZVADt4ste/b6PW20CPTwoLSpkztTxJtBySCmQW0nAsHcCvDfDRqFLLn0XCpo8e7fMfRCeMPZkJ3oAIcNB59M1p27aSDuj8wlByL+rNuoMDqcnlu+fkYiVv4f3upPjojKBMCmPurFF/eB4Onk4w/AexHMZvs0e3fwmfYqocBUUl/m+TRGTN7N1rrBqSpmTxhe9kSCBJ8BhcCFScVq9RtBUeBKeofreDoqYONR7+Rf3Uo/qyWW40UsEYpUT5QwgALi8laIu0xX0CAxaNn0+k/KC/DTUf3m2175497qC/CfoxsT2ce4pkas+03EZGOUe9UscldHxFfB/gv7MdaI84MvCW7L4s3gw8wu0DPaVR+2iRmUzn4Bctiy1A6IokINith9yICo6tEFKCoBHNf0eF/LXS8O2osmkegKU6jpxnSIBoLJc4NeAD7ag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bdfab5-8530-497d-f778-08de52a46b15
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:05:25.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3JCb7Q/1b4MYDWisjoCEDbIOfXC53+28vQV09/7PeClsL2JUMyme6ahoaYzcCSjy6n8Za/r2modI7VK0gVT3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130110
X-Proofpoint-GUID: YiVwa6m0jFuuIFWagr87zHqN2D5IEb3Q
X-Proofpoint-ORIG-GUID: YiVwa6m0jFuuIFWagr87zHqN2D5IEb3Q
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=6966431f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=6axJ9Fno0YXlx75vuKsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEwOCBTYWx0ZWRfXz2H1SriIxRxy
 epyF7UjzCneSAcmf7phpGMqfmlMwt5AXcX3mVDr8sWyTjbAqHaV1TZ7s3yTE5RNfy5k0B7fqJIk
 myJJQeiUp13FE87uwgkLWBoFaGkzcYWfUYm3+3tjjLLQqlm61vvYmgpLeshWYswvFqkvhBXLn9a
 +Rt6zdWTUD8EkEHtSGvv4xq46IS/TQiuT5XKbCRUcVcE/rT7+LqrnWpdD6WkZmmlF1ErGA1TicU
 nz1tGIfm6PKvFLtn9kwJoqpqJzFsF4VBPakHYuZrmtNFHIq9Od368IciKOoW+R2w6guSzAhpkZy
 65QYEnp8j+pQLzXnED1NZxlUlTO/SuaPzcc0I75eo6wLpdVlWlQc9GfYAbu8nZMlJf8UQUKkHLZ
 9zd70mbB2NuUBlOd4NE4/4mu97/CKR/6mrxRgKMx+JsI4JkNokUl4oSD8vL1Y7YZG2ZxmEivCn5
 7+mH3sinovdG6enE2eg==

On Tue, Jan 13, 2026 at 01:44:45PM +0100, Vlastimil Babka wrote:
> On 1/13/26 7:18 AM, Harry Yoo wrote:
> > To access SLUB's internal implementation details beyond cache flags in
> > ksize(), move __ksize(), ksize(), and slab_ksize() to mm/slub.c.
> > 
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/slab.h        | 25 --------------
> >  mm/slab_common.c | 61 ----------------------------------
> >  mm/slub.c        | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 86 insertions(+), 86 deletions(-)
> > 
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 5176c762ec7c..957586d68b3c 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -665,31 +665,6 @@ void kvfree_rcu_cb(struct rcu_head *head);
> >  
> >  size_t __ksize(const void *objp);
> >  
> > -static inline size_t slab_ksize(const struct kmem_cache *s)
> > -{
> > -#ifdef CONFIG_SLUB_DEBUG
> > -	/*
> > -	 * Debugging requires use of the padding between object
> > -	 * and whatever may come after it.
> > -	 */
> > -	if (s->flags & (SLAB_RED_ZONE | SLAB_POISON))
> > -		return s->object_size;
> > -#endif
> > -	if (s->flags & SLAB_KASAN)
> > -		return s->object_size;
> > -	/*
> > -	 * If we have the need to store the freelist pointer
> > -	 * back there or track user information then we can
> > -	 * only use the space before that information.
> > -	 */
> > -	if (s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_STORE_USER))
> > -		return s->inuse;
> > -	/*
> > -	 * Else we can use all the padding etc for the allocation
> > -	 */
> > -	return s->size;
> > -}
> > -
> >  static inline unsigned int large_kmalloc_order(const struct page *page)
> >  {
> >  	return page[1].flags.f & 0xff;
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index c4cf9ed2ec92..aed91fd6fd10 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -983,43 +983,6 @@ void __init create_kmalloc_caches(void)
> >  						       0, SLAB_NO_MERGE, NULL);
> >  }
> >  
> > -/**
> > - * __ksize -- Report full size of underlying allocation
> > - * @object: pointer to the object
> > - *
> > - * This should only be used internally to query the true size of allocations.
> > - * It is not meant to be a way to discover the usable size of an allocation
> > - * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
> > - * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
> > - * and/or FORTIFY_SOURCE.
> > - *
> > - * Return: size of the actual memory used by @object in bytes
> > - */
> > -size_t __ksize(const void *object)
> 
> Think it could be also static and not in slab.h? I'll make that change
> locally.

Uh, great. Thanks!

By the way `size_t __ksize(const void *objp);` is in both
include/linux/slab.h and mm/slab.h.

-- 
Cheers,
Harry / Hyeonggon

