Return-Path: <cgroups+bounces-8654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638BCAEDD73
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD6B16E88F
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F587287249;
	Mon, 30 Jun 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nLPeRPWF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xxYa70xl"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42592286D74;
	Mon, 30 Jun 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287692; cv=fail; b=bgrVskjmcp7yhNdbMYQvU/XT4eBwf4p5jks2SxHw/YGFNR5QbuyxYYCuQ2iOFg1IC/UZxD3mUYwZDxR5H5nc4kND2T+L1/Nm+R4oNr043n6zoOw40gG6G3m5UNwx8tLsiCLLAopg8m+GhmSz8ZbCYoWKqI1A3TGGsKI4WmaB12A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287692; c=relaxed/simple;
	bh=KOjO/Z063vgMa+dJKqqy6wIiwapkW6dH9x7oVWdJh68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q+ujEiziNBxW8XuGG9M6qLlcEOchg0dXRPKgZvHCgWcdY+8CMroVEoofCKJJqrPAqL7bc363ESIt7MqbDbg72S+QxEhW167eHIcNKaS2YjJnorkPRufNt1a0i2c2tUnZBGMN0GSnQ8W/Ni5klD/qbywHm0KfMy3nPVmsELoMj4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nLPeRPWF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xxYa70xl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCfhd9022131;
	Mon, 30 Jun 2025 12:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Mzno0UMqn1E7Gr5grY
	hNR1YFSUG72HYwz1MC343zkTE=; b=nLPeRPWFhZu62CnrmADtC2irzwIbwFSQy8
	yhDBmCT70862+olv6YC6gw+YgGxl7jPgQniiL70zh9IktnMI1+a4ubAm/h9IAp8O
	ZTXL+ER3o9QKvn9NPncGGbMD3UkIVEeGIt+GqVAtebmIdyUrhcNXBC/6WPvnY5XK
	IqzSJVhW1tTNWJzaDuJt7CZfh0DqFPd5K+9kC+dbr+Ev+6LUtGVUz5J3J/RNMS3l
	No8pNxTv+MzZDM/rmzAPxaowXW8D/OUFCcqhrS7GZ4fFh2Kwjy6ykeenJLPDsSzt
	7EQyBvnzjIfC9qE5pQ8XdXajieRTdN9c22TfRpMvigGe/9qTiSgQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7sr9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 12:47:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCE3Mj017559;
	Mon, 30 Jun 2025 12:47:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1d1fw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 12:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n35fa0GINjvMaJAWJHvnft8LYW3L2U9CGsMwByi3XgcRorUQKzZ6I0K5q2IkGjuLjkGefbSc4OzoTLssuHFDTx9V6I3X1dCW3dmm08hjNdBe6gtoJCSaJPffWNXLCrnFdWL5JrJTL7q399dfoR+EtRDI6azM59HDKWTq0+ahXoGNFnl4pRo1Y8qLr/nL9A61Rlhg/3X8/vcG1+bcZtlidpcl8AivnEXwDPqW3bIPQHtcs4SZD+tIIHM5BTQhI1vPD3hBEIoylFyU2w6+MWEht98iP/OJm4N6PslWKXlCMrvkI5Nx7xn5ZTsaZrpiZTKinmW6KV9S0HdWUieQwClG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzno0UMqn1E7Gr5grYhNR1YFSUG72HYwz1MC343zkTE=;
 b=B3cULusfrvwygIIgq1k8S6w/DsyYA4NwsaxfIojXVhnusYtzGsMNJ5P5cSshk+r0aBEbV+GKHopuBAGGvtvVCn1lUI6WvO6KhoHVLlcjmHRCpRYOO3zWkrasQ0wKtu2RWoJxB17QSl9YfNYI8BKGrB4bKz5BTlypAub2l1awEZmiXRT8b3Jb01vEOf6A56+d9tMJuF/2f8ygdBpMkbxxpUyGJXXGakqi+G3qwc91AXO/d3QL0gjaPKbkjePAm8QN3dtsI+cqEelRrJQuM2d51VA6FzNNtQ+/aX8EaeJadzRG8xJyCbT/ysdQfCxtXWdrtDCXD7DHiBjzwdv2/OfgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzno0UMqn1E7Gr5grYhNR1YFSUG72HYwz1MC343zkTE=;
 b=xxYa70xlijMwNxVCznA9ZF4Rn5kmlnC/0uLQ68zErm6nROPKpC6EaBwYr359/FOCrkmP9XZCd+Njca9sV+23tPcGvKjf6ZGpaGLhWcJLMYSH6g8zjB4G2zVBAgDsQVs4MMRGKE3k/dUGyZnVllj9POsabDgtLIKCf55aNrOwLPU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4948.namprd10.prod.outlook.com (2603:10b6:208:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 30 Jun
 2025 12:47:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 12:47:40 +0000
Date: Mon, 30 Jun 2025 21:47:25 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev,
        akpm@linux-foundation.org, david@fromorbit.com,
        zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
        chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com
Subject: Re: [PATCH RFC 26/28] mm: memcontrol: introduce memcg_reparent_ops
Message-ID: <aGKHXWJl0ECKN1Zh@hyeyoo>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-27-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-27-songmuchun@bytedance.com>
X-ClientProxiedBy: SE2P216CA0048.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bb38c8-e6c1-4743-0eab-08ddb7d44c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WPcAWMqoZU7rIwpu01xaQCADmvwRcXoCwfhQOAFcF4gUv15PKEdInds+eHGc?=
 =?us-ascii?Q?FaST68f3CAeaYNMdPyBJ8KuZ2tG4auRZ53TsGOUR15MW3uGez1Fz5G6spinz?=
 =?us-ascii?Q?sABSEqDemVfgWjsQ+Sr3JXZffRGT+TOIRWtP0yBWhLmlZul7kG1oT1SP8XFu?=
 =?us-ascii?Q?DuciZCL20ZSk2vTI90SjGm1qr0wFXCIRUJMA8iH+A4COqnOanK3t/XMC+E5g?=
 =?us-ascii?Q?VqNWjWrMQ70Eu4Zo6vNgK0eD9isIMQFEyPRyAivzPOJrvLFjiGA+fCOrk2TR?=
 =?us-ascii?Q?PHqxfQxgXChXUWDLdg71rAFVTESip83r4yb5hBi2VmboMZeiNOUcPgj3grqA?=
 =?us-ascii?Q?uQBTPsVG/M9uYKGjRw2BanKRhAwTEe9CRC8ngArKxSHV3aB9GMO9AJz8a2QC?=
 =?us-ascii?Q?9ivJQUMYYRgrSiSgSU3n552CAbhDUjb7DFF9CgNXdUyIGHa7iThbiXNlMXfF?=
 =?us-ascii?Q?EyAkgL5G1XrB+9bm39vjrRpxjQbtWBDihwIFcXItxzr9epqUA/wZdKT+0lB1?=
 =?us-ascii?Q?uv28Dyb1S7se6ydSNL+4RyHZX2P3uZXPHvxig3jj2i/mau2GjFz/fvx2rUiQ?=
 =?us-ascii?Q?4jE0pgYiejMocPTQ2hilX9r85E+0P4M2IVKkVrr8hbRMRJh3hGPpAv7n9Ffg?=
 =?us-ascii?Q?VoX15O2VfgVXIpd4Hn+e60xa8mp2z1G64QfMoRtQruTlFf51+RX+0FMeIK9G?=
 =?us-ascii?Q?+TQusR0GBlRBmKhOKjsHm62X1Bfs0fOaVDJbM+FPKhlXEONXC38ObC8WcWiY?=
 =?us-ascii?Q?e7zvAMvu8KzBbPV163czxtxifuk6stzEAEl0aKfhPycvHTfHq05o0pWFoaq3?=
 =?us-ascii?Q?wsupAoa+kxuWih99f8SRjMGLaiQuM4h8pRT/GYHwp9gVDXLgoOIiKiWFfBih?=
 =?us-ascii?Q?h5ScSa9E1Mh5xhFZ1yNfn8CPUM7MdvlQVRgwFIo9QVTIIOOcHrSsZT8A8XCq?=
 =?us-ascii?Q?tN23wCPxjazZfAcX0vf/9mAMhjPMI1xJHcH1yQ4BtHvKBJN+Fz+8rIxN3cP0?=
 =?us-ascii?Q?DYd9TEtd+xSfYMSQAM5KUvFoRW6EnUCy4QCso3c75W7O+oGwpNApPxootx0B?=
 =?us-ascii?Q?TrNAbakO7L8nQHl4oGU6685EPXQ1BZQfi3HtwY5oXFGnfVTzw8ZV/w41FyCi?=
 =?us-ascii?Q?EZmNHY+p5yXESnzchqftZ9nC9YJeizs1GSSVTdVDutfRLzI3f+ADZfxzo4z6?=
 =?us-ascii?Q?s8KyUHzO7rXH2gVl6DrUZ+KTp/IZ7x2o4NZtHOE0jtzqu1b5geHwgzMcXClr?=
 =?us-ascii?Q?hI7MjSQ2RfR9Bu/2jgt01XTaaOoj/ptRLTKY1iuG0aniyTirAakjxzDgNqjR?=
 =?us-ascii?Q?u5aKgBy48FFTF8qvl5Mc9QZ+gXNxlW/NQE3l0TD/K5o+qB8M86FWfpd/nB5i?=
 =?us-ascii?Q?v5o7b/hXz/Yxj2pF2lP/fFUG4QWhBwOs649uAvYtiMsBHnFRUwdsMx071hPS?=
 =?us-ascii?Q?vs3ORfLBjVY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GnsjXJcv+RsId+HYK23qgy/uQWTa+baa5xjHDtZ0fEL38uYBq2KUkjC8xtAC?=
 =?us-ascii?Q?7c5WABa0/0MH5P+06lCbHj48yqS0cTZJAMqSTiufElPpkTlfbRIjtvA7nmBz?=
 =?us-ascii?Q?m+LekQHJ7M2H8UN9CXRcKQ+SuvTciE69RT+Y+CTzRvOhZovfFQxcOsnVx9W/?=
 =?us-ascii?Q?7SA/xxO8CrN1WYI5TgEVStt208KuDYDQBkTUVYGlgPeY1RjrgeSlXmUbjAyc?=
 =?us-ascii?Q?DHQRqo8oo+nyVLenKbKxR3gBVV8/olD4QUgUXUl/Avx5SrancxebywUODRw9?=
 =?us-ascii?Q?+rHjUtsv/VaBa5Kw/f4UH3Qb9BdEOV6MYTHo264LD41iFnH9o+CQvLmclnV6?=
 =?us-ascii?Q?ztcqFUzCOPpBXJ87qM5TSTyYowxS0lcDuRO5rTxzDLAwj0oajGcm+2AoW6Tq?=
 =?us-ascii?Q?4UaEqa72WouodIFjvEz3RT7aOzTDEdJuts3yRQeuLU+sCobdkg5a0bEU6/Zl?=
 =?us-ascii?Q?SAi2djgEijSF+DJdh706xtGNfj04CGNQ9l+fazY1iAp7Ny36b5wUDhlhyYZh?=
 =?us-ascii?Q?RUDeEITM042IWM9SnO6MMel1tOm92Z3fnA/Y/XuVGcCAUBU7KjnI5FUpujeZ?=
 =?us-ascii?Q?S24E+A0aPboN38g5Bm2dcA6GH/a0z3rWsZyyiOdWli47XEUnl5lryfkAMCAx?=
 =?us-ascii?Q?FbjKCrBuVHiaBP8qQE5gj1uPxwGHobTXukEFai0+FZS7eRHXM+xUdoR3OqQB?=
 =?us-ascii?Q?sBn4En2AC8pPcynQHxT6Mk0dQZGbnnp4cINbx0MHR/DQU0v8gqEdeoxa/bG6?=
 =?us-ascii?Q?E7vlVTbpVsoeQp37D2kJt9VXx6V6nuF+0eah9qwYDDwYkj33bFuqYwYjJ7lL?=
 =?us-ascii?Q?a7XM0nc/DpkeTdgRB3CImj+j1HP9QM8Tgy297NMczxglAKTBvnCbeckij8Ic?=
 =?us-ascii?Q?OvKDoB1yoaeWVTbZDlJcsbV/GiCHFu0QQw6wa+FDBuUqvM9XwL+Re6SrtInc?=
 =?us-ascii?Q?wdj7IjKZI7t7XaULp/BPxGj40vAK0qq7pzYCeBLqmmSbBJ6bFKIy/B+dIwX5?=
 =?us-ascii?Q?Ybso7CmaIu4RfSIx5xCQGYIAetBRN1b2Qy1kBG5G4PqE+HbIcK7PxEke//+Q?=
 =?us-ascii?Q?CwwKsYDDCf+I5vvp5PVe8hsazSAwE5bHN1oEPfGoVwtshZ1v6zibUf4FvqgP?=
 =?us-ascii?Q?5b+fHp09Nrl3aSCjNonI3pJdZ9KTNMLtCaWHJooJdj+4K0l4sK9Pd59Fdc1i?=
 =?us-ascii?Q?53WIbH1Y89C9ZHMhtGLrTg44d8LIGaHLF+bqwvs0T0akytGfyxK4vPAzkH7p?=
 =?us-ascii?Q?5N4HErWAoFOEm6MXfJ7GQg3ICP9E/eHle8//3zqJWe1Sg66kWOhISFA4ffZr?=
 =?us-ascii?Q?cDcWvFjYBjnHzpeLmdm1VarDZ1mYpJC+T/7q4Op7dD9czmwJIGQBbnPBPQHi?=
 =?us-ascii?Q?uX4PQ1WGalrhjwy3lZoGQHjFQJz1kYo/u1L0QFk2gW2gcyoOlhbHQzWRXQ+d?=
 =?us-ascii?Q?EpaeCFJmBPriPtn+5NajqklGoaBCCvHRehKsO0v+ybb83Mnu3gw/5aFNHaFn?=
 =?us-ascii?Q?J7ci1KyRVUwkQj5xowhdXMEN8iJhbgjMY+7DiifuR92HF7xcTKRKfoZR1PhZ?=
 =?us-ascii?Q?BmGBpqkZ5z51uLseKoUFkNcSmFsHK7gnWFJX9ifO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b5vRkqz8tMovPjU6w3TUvUEiSn8c1F7okooqB+rPkQTeZe4ulrnjIDmpOELTAyTrvxhExjDGE+XmhL8uXGMOW+Yb4NOa+tkgbabPCOtWFM6voZutQD+0XSyayPoQ7/lcLEUszIq+fqLIsZ/W6GTFBZ0HjecE9KcRLxklzOmUK5LUG5ffRUjv11DoucfGPmZQIO1fBJkUKRm94rbnIHu9ffzvRpxZf1VhmFEbjdltOx/eSXdWcgKKV6bRyieBudUVvDGO6cVTvFCJ171V8YAcH7Xx1ZKGTSZAg8cuW/nEo3VfjLHusKysFp176z2ItSSp5W2CuCtf8SzBAXtXmylKhuh4ngZKua5ELxYoitlsCe5I8eoJ6SPEcuP6VcqQB0Yd9OFW53Mkyo0f4bhzPqDeuadxV7HNGZp9O5zzJTKuHdXp2EhuI3Kl+8cWDpgFdKUeRgWLVorKyIfXyh1E6gBxaFWmvjxWvtcoUlLgQidRRYqqZdn6Vfj7A/5myh1dqkIX6hMgrrN/tO/FN+w4s/VVcsOvbyYgd+IZKTGRII5h6X5G7OG2FuCUbeDWexRZCNo8Hfx9QvkuCbNhqHpocfIMH5OKmvdkagU8M7tgSrBAiaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bb38c8-e6c1-4743-0eab-08ddb7d44c62
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:47:40.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8ihQ9zGXM/zqP0wob0H9HYHtWTTlM7dHYZs0pAKt6n6ILab4wcLFahPKkYkIxXm+0HnXsLcD+WPmrpOpnTaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=812 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEwNSBTYWx0ZWRfX2WSOAO5DSvJh DY8qT2ApQgMtKzZLJtIcfhOjf91PYBVLKSfNtnQuN0GDe0sDO/WXceNganXh1FjnKeYzhhvhUJP T1NnKJ5aebl0XQdtEqLLepjPC2K8LAoe3PycS7w+qSv3QRUiT5KBJFR2XioVVXjUjYx7p7SQSBJ
 YGSCfnK/loLGV1rwWB8tB8yGhWUx8ozNVOAmCGfYjRLDB+LPuzM4GbWfnCfx6AUMR7jbDNhhSZB 22KuxGhhnZgbluN5MUloam6BwmwrjJUWA2orePrEd73L0PFz8/Qo/qt89NmRj6ND/Ov9aWOD7p9 eQNFGesytG0Xtz2p4EoTesm04bY34IXuMjp+mKFrlw1r6GwNPr9AFWNqLxmDKCeZYoCP2o9NQPf
 DQqFVWu78Py2TRTXQmWWYaN8UXdf6ofNM+cyCwNfXH0OoojygxnRS/tvsGpt+vOtXrYy0s7b
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68628772 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=968KyxNXAAAA:8 a=mIqUuohHszICNoPOkwQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216
X-Proofpoint-ORIG-GUID: oWp-_kN5Q3O0-MP81kA5fMHBNSWgH2mu
X-Proofpoint-GUID: oWp-_kN5Q3O0-MP81kA5fMHBNSWgH2mu

On Tue, Apr 15, 2025 at 10:45:30AM +0800, Muchun Song wrote:
> In the previous patch, we established a method to ensure the safety of the
> lruvec lock and the split queue lock during the reparenting of LRU folios.
> The process involves the following steps:
> 
>     memcg_reparent_objcgs(memcg)
>         1) lock
>         // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
>         spin_lock(&lruvec->lru_lock);
>         spin_lock(&lruvec_parent->lru_lock);
> 
>         2) relocate from current memcg to its parent
>         // Move all the pages from the lruvec list to the parent lruvec list.
> 
>         3) unlock
>         spin_unlock(&lruvec_parent->lru_lock);
>         spin_unlock(&lruvec->lru_lock);
> 
> In addition to the folio lruvec lock, the deferred split queue lock
> (specific to THP) also requires a similar approach. Therefore, we abstract
> the three essential steps from the memcg_reparent_objcgs() function.
> 
>     memcg_reparent_objcgs(memcg)
>         1) lock
>         memcg_reparent_ops->lock(memcg, parent);
> 
>         2) relocate
>         memcg_reparent_ops->relocate(memcg, reparent);
> 
>         3) unlock
>         memcg_reparent_ops->unlock(memcg, reparent);
> 
> Currently, two distinct locks (such as the lruvec lock and the deferred
> split queue lock) need to utilize this infrastructure. In the subsequent
> patch, we will employ these APIs to ensure the safety of these locks
> during the reparenting of LRU folios.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h | 20 ++++++++++++
>  mm/memcontrol.c            | 62 ++++++++++++++++++++++++++++++--------
>  2 files changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 27b23e464229..0e450623f8fa 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -311,6 +311,26 @@ struct mem_cgroup {
>  	struct mem_cgroup_per_node *nodeinfo[];
>  };
>  
> +struct memcg_reparent_ops {
> +	/*
> +	 * Note that interrupt is disabled before calling those callbacks,
> +	 * so the interrupt should remain disabled when leaving those callbacks.
> +	 */
> +	void (*lock)(struct mem_cgroup *src, struct mem_cgroup *dst);
> +	void (*relocate)(struct mem_cgroup *src, struct mem_cgroup *dst);
> +	void (*unlock)(struct mem_cgroup *src, struct mem_cgroup *dst);
> +};
> +
> +#define DEFINE_MEMCG_REPARENT_OPS(name)					\
> +	const struct memcg_reparent_ops memcg_##name##_reparent_ops = {	\
> +		.lock		= name##_reparent_lock,			\
> +		.relocate	= name##_reparent_relocate,		\
> +		.unlock		= name##_reparent_unlock,		\
> +	}
> +
> +#define DECLARE_MEMCG_REPARENT_OPS(name)				\
> +	extern const struct memcg_reparent_ops memcg_##name##_reparent_ops
> +
>  /*
>   * size of first charge trial.
>   * TODO: maybe necessary to use big numbers in big irons or dynamic based of the
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1f0c6e7b69cc..3fac51179186 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -194,24 +194,60 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
>  	return objcg;
>  }
>  
> -static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
> +static void objcg_reparent_lock(struct mem_cgroup *src, struct mem_cgroup *dst)
> +{
> +	spin_lock(&objcg_lock);
> +}
> +
> +static void objcg_reparent_relocate(struct mem_cgroup *src, struct mem_cgroup *dst)
>  {
>  	struct obj_cgroup *objcg, *iter;
> -	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>  
> -	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
> +	objcg = rcu_replace_pointer(src->objcg, NULL, true);
> +	/* 1) Ready to reparent active objcg. */
> +	list_add(&objcg->list, &src->objcg_list);
> +	/* 2) Reparent active objcg and already reparented objcgs to dst. */
> +	list_for_each_entry(iter, &src->objcg_list, list)
> +		WRITE_ONCE(iter->memcg, dst);
> +	/* 3) Move already reparented objcgs to the dst's list */
> +	list_splice(&src->objcg_list, &dst->objcg_list);
> +}
>  
> -	spin_lock_irq(&objcg_lock);
> +static void objcg_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst)
> +{
> +	spin_unlock(&objcg_lock);
> +}
>  
> -	/* 1) Ready to reparent active objcg. */
> -	list_add(&objcg->list, &memcg->objcg_list);
> -	/* 2) Reparent active objcg and already reparented objcgs to parent. */
> -	list_for_each_entry(iter, &memcg->objcg_list, list)
> -		WRITE_ONCE(iter->memcg, parent);
> -	/* 3) Move already reparented objcgs to the parent's list */
> -	list_splice(&memcg->objcg_list, &parent->objcg_list);
> -
> -	spin_unlock_irq(&objcg_lock);
> +static DEFINE_MEMCG_REPARENT_OPS(objcg);
> +
> +static const struct memcg_reparent_ops *memcg_reparent_ops[] = {
> +	&memcg_objcg_reparent_ops,
> +};
> +
> +#define DEFINE_MEMCG_REPARENT_FUNC(phase)				\
> +	static void memcg_reparent_##phase(struct mem_cgroup *src,	\
> +					   struct mem_cgroup *dst)	\
> +	{								\
> +		int i;							\
> +									\
> +		for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)	\
> +			memcg_reparent_ops[i]->phase(src, dst);		\
> +	}
> +
> +DEFINE_MEMCG_REPARENT_FUNC(lock)
> +DEFINE_MEMCG_REPARENT_FUNC(relocate)
> +DEFINE_MEMCG_REPARENT_FUNC(unlock)
> +
> +static void memcg_reparent_objcgs(struct mem_cgroup *src)
> +{
> +	struct mem_cgroup *dst = parent_mem_cgroup(src);
> +	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
> +
> +	local_irq_disable();
> +	memcg_reparent_lock(src, dst);
> +	memcg_reparent_relocate(src, dst);
> +	memcg_reparent_unlock(src, dst);
> +	local_irq_enable();

Hi,

It seems unnecessarily complicated to 1) acquire objcg, lruvec and
thp_sq locks, 2) call their ->relocate() callbacks, and
3) release those locks.

Why not simply do the following instead?

for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++) {
	local_irq_disable();
	memcg_reparent_ops[i]->lock(src, dst);
	memcg_reparent_ops[i]->relocate(src, dst);
	memcg_reparent_ops[i]->unlock(src, dst);
	local_irq_enable();
}

As there is no actual lock dependency between the three.

Or am I missing something important about the locking requirements?

-- 
Cheers,
Harry / Hyeonggon

>  
>  	percpu_ref_kill(&objcg->refcnt);
>  }
> -- 
> 2.20.1
> 


