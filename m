Return-Path: <cgroups+bounces-12913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD7BCF24FA
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD29F305222B
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549B2DCBFD;
	Mon,  5 Jan 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LpaebOU8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dE8I+vlA"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18429E116;
	Mon,  5 Jan 2026 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600208; cv=fail; b=C2GsFKKkeuU3G70INKdyZ82p/B2c20UCpsjMBTydPyYZ931rF5NthGY908ABsM6tLt2QsN1Xm6+1YolivW5OuYQbMQ7iGHfAqq0ojqSnic2tztVztngPHwVqR3xkbBmyp5l/8Xb1mfLGauHAEKVn64CDWAuKtNRWd3KOMusyPwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600208; c=relaxed/simple;
	bh=7JPo9Ea2tgtx3WipnvIWGhRjAYf5BZ002kjpay0+tvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pu4m8RKiEp/VmnLwwaIA17DKEmi/FgHyHoEOrYgfGMoDu/jdyt6jXE1rQ4MKim668/MbsQSY5GKSVQhz25Kz926CnzOYA4krjF09SZZNIHrquAgOHpxtUVbprqDgC/ZmZqvK3g6Ka6PjP5iCVnxeDAEcCaqW7nQmleRecmqw1qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LpaebOU8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dE8I+vlA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60501vp1191951;
	Mon, 5 Jan 2026 08:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fAAoInE+8mx/HljUId7scj8nia95YJ2EPLMk+iXayOU=; b=
	LpaebOU8x5x8WA2s7kXr3JPKe8UZPmq04TSPdmPB1C+Pn67jHaTjhMRzFXrL0w3Q
	1aM9pC2S0pE++Uu6/NgsfNhXGWOr9B/cn8axUWramhz99SEez6qv+NZ7xBYWsOp9
	a3KAAvupKXtRj9Donk+WDuw2eiqyBw0inhR8fJfLOjbUbCLi3Eeu8pgUgUtzddQ8
	XBqjk3r1oL+XtZlH7hDO3lPKMVS5GpylN3Ax/Ks6etkFx7yIe4q5XC1ahrbDEuE0
	m1rDE7HBeefSJD14dUfypypxMKdXnZsuEOvCuntRV2fmNMoyVc5CcnpPU9l5d0GK
	4zHN1xd6f/sifiDk6abL5w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev37sbgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6056SbTh026435;
	Mon, 5 Jan 2026 08:03:05 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjhc0f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO85S830IcnhJEIJmQt/R68PgEvOrjniT6KstG/NKUFGeroGyL78tBrFchiVM0AhnbYk7hIPtClO9Lm3oYiht6fJQ2he5AoA4n7uyZkGcWxk5Q/IKy3/ec+zbuCpi0VlClCtKQlrCLDTwNpJyKbjjYHgDW6U0HxWq4mBksczWGTGRFFh0Yixd6CKtvVq+9S4XjAMkWdJuhDEDgyQnQUZ26nnPRZVnmFniOFyU7LSWqbqEcrUUpyfZufpkQyNSBMdyVnDiVJrY4HNAiPn8S1UuuJNBHnHjZKPYOI6N9sf8RVxlV92/Aori1y9VuoUKCh2DT702dieZiTkXQds8AHYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAAoInE+8mx/HljUId7scj8nia95YJ2EPLMk+iXayOU=;
 b=hPFusou9nEezp7cNvPlB6USQIYwL/grrHwOc7b1wj221WcIPVphtoT6UFgddi7dyKCDBm132zSRQLHL5D6zZaI2wKiL9D9Jz0eGb2tR0WQb5iY/j8AhhaVg7x3vn/cV11zxEjv3kcOOnySdMyu8e5Na+LHKe2P+yIU8FrNBsWE1IWwjYRXZn+8FdTBmFoX9s31qAcA7hU2N61g7McS+WI953sdlKERqG8O5/sClNuJfP68vCaUdb1givniDKPjhwDlDNbINjM6zBSqTBYNaGhJj22oKD8chc+aSgA8MSuZ01xzMsfF8uXRO28i5lds20hu3nJLml+mt+tCZN+TK+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAAoInE+8mx/HljUId7scj8nia95YJ2EPLMk+iXayOU=;
 b=dE8I+vlAe9oCFlIU6ES+YFR4qfEzMEd9tKWqppYeT9e17VjIE5+VdngMW133NEt94qTBRbs2uUtE0fC7trq/tpcY2hC7FCub15VCySuA2iM9f7i5yt5jcUCoh9zxznIxkYKfDk3NTecHO5y5vyYTows3uNQFZTGYXz6U5sT5BM4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:03:02 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:03:02 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: [PATCH V5 6/8] mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
Date: Mon,  5 Jan 2026 17:02:28 +0900
Message-ID: <20260105080230.13171-7-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0160.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 74be986e-69b4-43d2-1503-08de4c30d985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?84vubhqzET9bTXOc+rMniUh/BPHNJ9pTIDM8W/m2hoNkjJ2/Xmf5Gi+w7ZWX?=
 =?us-ascii?Q?tIBM178B4T4sdbVr4N8PrN43IrEdZndKHR8ZekovuoESaAjuiYowNs2y3QMi?=
 =?us-ascii?Q?FX6Lmvg/Q+NMfMDKtBdnDZEYuGdvytqzhATr38kwgAOsPK3XYbZh8aoPxwTZ?=
 =?us-ascii?Q?a/ltEGC/L/yk9mq1Xl6CUnp7aARfDPHet2J9vSp7LO7JVgL5BSgR+pvlrvap?=
 =?us-ascii?Q?PsNlHrspiE36mMspOSZhydVQzZ+7994qKDYL4tsIG8E1I0DXBrLD/aYBC0UK?=
 =?us-ascii?Q?7ngWNyx32cl3T8zmT732p5qNOBLCeEAzarL7QFfO6ThCLvRZCvIzXUsQm7Aj?=
 =?us-ascii?Q?pnIzx94UCONZj2kdNCAEwV9I1n5vDguHDQY1VI43ARDPQ9vRZ0Fa9vVg89w0?=
 =?us-ascii?Q?hu0A5Fkp46179izn3/yrGYlVLkafYOFswALI+L5njs35XX4TEToaBoUB6cSQ?=
 =?us-ascii?Q?tbjLyBTY0UM4e56JM9/+iJLGZ1p4k1KdQYDpYKoJM7RXLmUQqwRIaFuxMSl/?=
 =?us-ascii?Q?lmpIhvyZrcgm1HTqwuGGNqoWVzk5evjtn3r4OCSUsI+EZUgxzyABadCAtDbJ?=
 =?us-ascii?Q?aStMxTJ41TrM4SY6E7mL1LO0/1dI3qS3Th75pS3mzu8BciDENsmOZgtKqyBi?=
 =?us-ascii?Q?JTOp1qjPkxL8Itc6XkknO070doikp+5Fv4psDiT/hm3C/KWZvoaqlC9CAWth?=
 =?us-ascii?Q?e4jwUa0p8Ve7c6szN5aT0ruIWXFVCCdh2ng7Jjty72/5ZkyFTuUjkOTMiHWL?=
 =?us-ascii?Q?pVTUsBp+FtjL75cMA/WAB/vqiFsmpPiyUPQATT95SJoBa5rQZX+8q7qgJoD/?=
 =?us-ascii?Q?7EbR8CnT7OQbM4HtYKswAJMBNYKMonJ+eMFS10deFampGt9af1styYAE+Eyj?=
 =?us-ascii?Q?givCZKN3P1F9YTZrlF6Sm89pJFv3YjXlDx745n8Mrp1VBBQVOY/79VjNedx4?=
 =?us-ascii?Q?eA75o6bL+1zg2fSDEWfF6IRbr5nz0TtZ04I/ekuGRh4KalpPuqE7YNYYT7dm?=
 =?us-ascii?Q?gEvgtn5G009YSuwvI1whU0d7E3ZIrp4/jCgv2p3tROIW9YTMjRLPVC/y/7XZ?=
 =?us-ascii?Q?8pqiugO4mgWQ7vuWAA0L2kAWmuRShWsJZkb9Rgb2vd5aLMRDPn8d0/o40122?=
 =?us-ascii?Q?K3rtW2WhVps96z4lKL+VaaPpnw+DQAMLXyKMy1bKoX1NorUcamJ551DbPCBx?=
 =?us-ascii?Q?V0FTEP8Wsw9exMYsdqZTmQNO6UPdHTCKbiLCBByhvdR8M1MTKTZGa7VQT/3G?=
 =?us-ascii?Q?+WEv4NlSK+EddF8H1XkTc2jdF4n4/1h3g29sXfGnzT7jLktkTPf3S6slxbS7?=
 =?us-ascii?Q?JZAnJ26fiNv71LHJUc5pkkTth+G4JVx2yM/5IOJxIxGHiaA7MUi0L9agJMjv?=
 =?us-ascii?Q?lwBtHaG24wcOk/7NIic/oj8Zg6W9keXM1+Mk/ZqtDErmsPuoNJKcGAnq4Y7g?=
 =?us-ascii?Q?2C1vfgkQ/dfgS2l9kML73qgcwD1Ik2eZLgEWRnTJnsD9YevRKgQLaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?20guLCrwx+32kUfGJdS9sfXBwQnprO8qbn2kQv1WYpLQG/Keoer4MV0IjGek?=
 =?us-ascii?Q?Lk7aedl9ZcmmvZ65qY2pT/h/RiEeK2cIC4AXjwYCVqg+o2OpdnKxBJRcoelB?=
 =?us-ascii?Q?VNU9Vsk0LMQXLyz0ljzdL+aBu25zIpUKf8UcAwVJCOba/PTukL5Lb1h4eIzJ?=
 =?us-ascii?Q?r+E+ZU3HQAurvhUlZ40ehtgLz9dtfVd658rA9yklD0U2gmQ8uyCAxUZkmW+A?=
 =?us-ascii?Q?7a/Tl7FLSLtl5GN+X4I9f1cVkkXWTzkuPzykfCFIa63LjuGMy20BheeMJKlI?=
 =?us-ascii?Q?SRJlcGvDjAB+MNBGP/Wdjh8gBctUOgbQkos+xl0FB5cU2IAApGnAY7kPoS9p?=
 =?us-ascii?Q?YS9qpZaDOw7110nsBqAh5Vr4BwGxZgwOu55CYRbx46k9AaTo/LSZfpNZwoSh?=
 =?us-ascii?Q?YNTLym5Ataigzm2DDfhSaDkO7R5g8TMQLUvPK9chr1DfRFceYoXJqNPDvbR7?=
 =?us-ascii?Q?k0k1Ukl/oypQQtEEC4jt+RzBnRwlR2TzjLs7ioGGqbzJmhCuya3eSFRwo0Y1?=
 =?us-ascii?Q?IUsRKnhqnXKhsyMkiMvIurvGRBRa5ShEKLbl8CgZnPwSYfsOcodzhifkTK3d?=
 =?us-ascii?Q?mIFnBdM9Meda7ey+8+wJYD2/Qt8tCFgja9CLPmfkyJqIUEpQIRPnQoGcd/lc?=
 =?us-ascii?Q?EGhQFycF0urtdRUx0lBORvjdKneRN3nfE5aVyXtkhXbN9LMH10sJ+tUVqkuz?=
 =?us-ascii?Q?TQaVdYYZ6v2aKFaaTuZ/9spE2JTNcjpDSFhdk4jEy00b2z+D248R1YJuo5mG?=
 =?us-ascii?Q?uAZ3eZHtx0wGrH5b4KVafi1gpvV64H3oht8bpCKWuupGAeDcUeZsD7Zs9bmp?=
 =?us-ascii?Q?iIk3d9UCy58xqeySV8slq/UYMwyT6SDpxyrL4cWIEa+9ROOOjcHjwkt7X6Rs?=
 =?us-ascii?Q?6fd3GZoBGIgNGawOelOYsTJPMZaRS6saBZft4erI0Ed6WtqEzjXllgsTCt80?=
 =?us-ascii?Q?Gk4c7pzWA7vH+uIrCwu0qJGMsGy1ia4++SpXoisK3Xo0LucKBEFjOfQg1ZW+?=
 =?us-ascii?Q?wL7DoTt2DiqDPV/rp/ELQ+qnuFwrhMBX1NoK5ERNaFyXUHmSm+KTRhkuhwwP?=
 =?us-ascii?Q?Fvc3eJBIzUWn8KDII8Jvyinv56/7NCo/ay9z8MVTpAl5F2jv+6pGPMvnJybf?=
 =?us-ascii?Q?jT7L6TahhEspGYJYReH40zk/oJL+WrZW/APEtgYTEnzuk1ABiMd3E6knWKrX?=
 =?us-ascii?Q?Qfll8fsebFUfOVlLB8RJVAkBUNxKS2FDEw/Zf3/A+dyFY2J1rnEBGCcT+lqv?=
 =?us-ascii?Q?kwp49jGq06gEx+uOoGy9FdcaBantw+Fum8YDyJcPiJzbl7c3CKQ+O+UhmvDY?=
 =?us-ascii?Q?sPScTOh1Y4vZ7Ftfj2DAgIrxXgiU54mPEDCh/rXvH2EXq8Xb1GhFifQHOqC7?=
 =?us-ascii?Q?IXcn+xOqKGUnp89kiTSPMDHioiOieWbvcvooFFIG0UAgR2OZ7HD8lj7BWrz/?=
 =?us-ascii?Q?BDlDhtXigCMYoHEiQXNOdFu56A9siPeT/qUMhYQFe+piORd3e9LvMZ0Kglp2?=
 =?us-ascii?Q?um8B+QpcB1P29hYG2Xp99VjQfhMt4+yCiQxmQsuAJ70zwipo6fjOFSMqeHV0?=
 =?us-ascii?Q?hvPuOKcB93Q3fv2hZ8aAeBEKjtCJ+qRz1ueyr/1YNCjGlPX7lA5GNnhpXSmz?=
 =?us-ascii?Q?AKEW3YKPduAorDaSEENCtGjLstoPg8MmNrKmSPvOn7EDZ9GC32SpWH1B+kpQ?=
 =?us-ascii?Q?v9mQOKyD3sZBM++gAtjvFGAXT8Xw1M6lUOarzmiJxO9KdyyFPZtsjqU1PlLT?=
 =?us-ascii?Q?IJn1S9RsXw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rnBqwUGaaI5MxnCsCGAdgZvlMGGYt/HbiZgQgNXmQNy+aAdcrzf1Cbkb23Tq34VrjqvN4OjXBdVkk0/rg54bhDhHbYZu9tDFveyan+uFRjtyrUMIRPV4DRjBU35wtYvDtfhDad8qQixjo8Cb/tvPCv1b0H8tKxhVmfYn5EzMxBZK+Ej69qnhBeBUem0AZqS9B9j4EzVzmngBrZib5AJunJxmbsT9Obcw8c0vvmS/bmWwYjhWnyNlcn1xy+0jvFJEvu6+qY2DHm8uupp3PlMRe9lM28isxUAMRvOl0GBUTl/SjlIkSS105edePVANpBXf0c0Jd51FzGkV5NAl1ORPNfRgufxYAvZ53Ne2WmWa29UzZ+8cm7AllvTlpNxQlkdqhgBPI+8vusPno7yrvPAsCYbzs88qb4ZQQj9XSSUF2Uxiz0qOgtKXesekMX4699qRLUGn7l3UiVpdaiZ/DHVtipXJJcXJQHnRsykk8HyXAJ5IRE28qXUx+wP3zeB1VTdtRcSf86+FOqj0LFVK6mZoNSTiAW97QGERpfDObeKjvBV5Zn5LbdEG5zojlhfH8FejPa7DGQMpOyt6XwpnGi+viZ/Ff6SfL2mNEw8p0gVmtJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74be986e-69b4-43d2-1503-08de4c30d985
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:03:02.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gI8kyYqB0FbBElf/LLQW3pHiHqHoFX5unsFU7VvX13BPsxqnuCuQeuBryfyb/Lse+DiS9rDx7GpKGO0EfQJmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MSBTYWx0ZWRfXxPr3wvd/ja77
 ZvOnRKpo5bh9FZH2vXF04KfuwBZ+3s4aMLSCsE8f8HP8S8WUB5YQbJUKu3pJwM4/Imynf0SeKWb
 a85Xtcvwu/1jMkAK/2DQ7Sd7Yx/kBki5jqIoOETXputB1Hj5AAByZT4GSg9D8NTeUAQb1b/IvoU
 0Wf82msw2gWwZY9OHKDjWfa8pSvCcEh998IjbWGWILVjNtERgTSnEop3CL/k7wZNeZRF4ronyjO
 FnJDLe/EPh2wYBrD00sxe/OmjRMHMCQLmbLv7cCsr+r94Y8u5xfcG390TvcDBVIPg20f84hif6m
 xPjjfiLMXB381O8HKsvA59FwbIhe/WEv+4uaZNEyv46u6fwdBDS3d5VYtHTGegZjdzUERYMGQNN
 o2lU2E7N/m+NW/25P8VRwpqzAyHflxl9EzewzaL6KV7E21Nq4ujBRkdHiLYMBlXXBFjcGGv5Lut
 qLLO7Heejg+7z6On8Z6pNVAN4DMORzFhxhSR4kwg=
X-Proofpoint-GUID: aG9Paf7p0d3Ib91Lk82bQenU6JyU7Y-A
X-Proofpoint-ORIG-GUID: aG9Paf7p0d3Ib91Lk82bQenU6JyU7Y-A
X-Authority-Analysis: v=2.4 cv=F89at6hN c=1 sm=1 tr=0 ts=695b703a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=4y3Wp0Wu7Q92bxCIkH4A:9 cc=ntf
 awl=host:12110

In the near future, slabobj_ext may reside outside the allocated slab
object range within a slab, which could be reported as an out-of-bounds
access by KASAN.

As suggested by Andrey Konovalov [1], explicitly disable KASAN and KMSAN
checks when accessing slabobj_ext within slab allocator, memory profiling,
and memory cgroup code. While an alternative approach could be to unpoison
slabobj_ext, out-of-bounds accesses outside the slab allocator are
generally more common.

Move metadata_access_enable()/disable() helpers to mm/slab.h so that
it can be used outside mm/slub.c. However, as suggested by Suren
Baghdasaryan [2], instead of calling them directly from mm code (which is
more prone to errors), change users to access slabobj_ext via get/put
APIs:

  - Users should call get_slab_obj_exts() to access slabobj_metadata
    and call put_slab_obj_exts() when it's done.

  - From now on, accessing it outside the section covered by
    get_slab_obj_exts() ~ put_slab_obj_exts() is illegal.
    This ensures that accesses to slabobj_ext metadata won't be reported
    as access violations.

Call kasan_reset_tag() in slab_obj_ext() before returning the address to
prevent SW or HW tag-based KASAN from reporting false positives.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/linux-mm/CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com [1]
Link: https://lore.kernel.org/linux-mm/CAJuCfpG=Lb4WhYuPkSpdNO4Ehtjm1YcEEK0OM=3g9i=LxmpHSQ@mail.gmail.com [2]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/memcontrol.c | 12 +++++++--
 mm/slab.h       | 54 +++++++++++++++++++++++++++++++++++---
 mm/slub.c       | 69 ++++++++++++++++++++++++-------------------------
 3 files changed, 95 insertions(+), 40 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fd9105a953b0..50ca00122571 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2604,10 +2604,16 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	if (!obj_exts)
 		return NULL;
 
+	get_slab_obj_exts(obj_exts);
 	off = obj_to_index(slab->slab_cache, slab, p);
 	obj_ext = slab_obj_ext(slab, obj_exts, off);
-	if (obj_ext->objcg)
-		return obj_cgroup_memcg(obj_ext->objcg);
+	if (obj_ext->objcg) {
+		struct obj_cgroup *objcg = obj_ext->objcg;
+
+		put_slab_obj_exts(obj_exts);
+		return obj_cgroup_memcg(objcg);
+	}
+	put_slab_obj_exts(obj_exts);
 
 	return NULL;
 }
@@ -3219,10 +3225,12 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			return false;
 
 		obj_exts = slab_obj_exts(slab);
+		get_slab_obj_exts(obj_exts);
 		off = obj_to_index(s, slab, p[i]);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
 		obj_cgroup_get(objcg);
 		obj_ext->objcg = objcg;
+		put_slab_obj_exts(obj_exts);
 	}
 
 	return true;
diff --git a/mm/slab.h b/mm/slab.h
index a4e48f88fa5b..c69ebbaab53b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -510,6 +510,24 @@ bool slab_in_kunit_test(void);
 static inline bool slab_in_kunit_test(void) { return false; }
 #endif
 
+/*
+ * slub is about to manipulate internal object metadata.  This memory lies
+ * outside the range of the allocated object, so accessing it would normally
+ * be reported by kasan as a bounds error.  metadata_access_enable() is used
+ * to tell kasan that these accesses are OK.
+ */
+static inline void metadata_access_enable(void)
+{
+	kasan_disable_current();
+	kmsan_disable_current();
+}
+
+static inline void metadata_access_disable(void)
+{
+	kmsan_enable_current();
+	kasan_enable_current();
+}
+
 #ifdef CONFIG_SLAB_OBJ_EXT
 
 /*
@@ -519,8 +537,22 @@ static inline bool slab_in_kunit_test(void) { return false; }
  *
  * Returns the address of the object extension vector associated with the slab,
  * or zero if no such vector has been associated yet.
- * Do not dereference the return value directly; use slab_obj_ext() to access
- * its elements.
+ * Do not dereference the return value directly; use get/put_slab_obj_exts()
+ * pair and slab_obj_ext() to access individual elements.
+ *
+ * Example usage:
+ *
+ * obj_exts = slab_obj_exts(slab);
+ * if (obj_exts) {
+ *         get_slab_obj_exts(obj_exts);
+ *         obj_ext = slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, obj));
+ *         // do something with obj_ext
+ *         put_slab_obj_exts(obj_exts);
+ * }
+ *
+ * Note that the get/put semantics does not involve reference counting.
+ * Instead, it updates kasan/kmsan depth so that accesses to slabobj_ext
+ * won't be reported as access violations.
  */
 static inline unsigned long slab_obj_exts(struct slab *slab)
 {
@@ -539,6 +571,17 @@ static inline unsigned long slab_obj_exts(struct slab *slab)
 	return obj_exts & ~OBJEXTS_FLAGS_MASK;
 }
 
+static inline void get_slab_obj_exts(unsigned long obj_exts)
+{
+	VM_WARN_ON_ONCE(!obj_exts);
+	metadata_access_enable();
+}
+
+static inline void put_slab_obj_exts(unsigned long obj_exts)
+{
+	metadata_access_disable();
+}
+
 #ifdef CONFIG_64BIT
 static inline void slab_set_stride(struct slab *slab, unsigned short stride)
 {
@@ -567,15 +610,20 @@ static inline unsigned short slab_get_stride(struct slab *slab)
  * @index: an index of the object
  *
  * Returns a pointer to the object extension associated with the object.
+ * Must be called within a section covered by get/put_slab_obj_exts().
  */
 static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 					       unsigned long obj_exts,
 					       unsigned int index)
 {
+	struct slabobj_ext *obj_ext;
+
 	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
-	return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
+	obj_ext = (struct slabobj_ext *)(obj_exts +
+					 slab_get_stride(slab) * index);
+	return kasan_reset_tag(obj_ext);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
diff --git a/mm/slub.c b/mm/slub.c
index 8ac60a17d988..39c381cc1b2c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -975,24 +975,6 @@ static slab_flags_t slub_debug;
 static const char *slub_debug_string __ro_after_init;
 static int disable_higher_order_debug;
 
-/*
- * slub is about to manipulate internal object metadata.  This memory lies
- * outside the range of the allocated object, so accessing it would normally
- * be reported by kasan as a bounds error.  metadata_access_enable() is used
- * to tell kasan that these accesses are OK.
- */
-static inline void metadata_access_enable(void)
-{
-	kasan_disable_current();
-	kmsan_disable_current();
-}
-
-static inline void metadata_access_disable(void)
-{
-	kmsan_enable_current();
-	kasan_enable_current();
-}
-
 /*
  * Object debugging
  */
@@ -2042,23 +2024,27 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 {
-	unsigned long slab_exts;
 	struct slab *obj_exts_slab;
+	unsigned long slab_exts;
 
 	obj_exts_slab = virt_to_slab(obj_exts);
 	slab_exts = slab_obj_exts(obj_exts_slab);
 	if (slab_exts) {
+		get_slab_obj_exts(slab_exts);
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
 		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
 						       slab_exts, offs);
 
-		if (unlikely(is_codetag_empty(ext->ref)))
+		if (unlikely(is_codetag_empty(ext->ref))) {
+			put_slab_obj_exts(slab_exts);
 			return;
+		}
 
 		/* codetag should be NULL here */
 		WARN_ON(ext->ref.ct);
 		set_codetag_empty(&ext->ref);
+		put_slab_obj_exts(slab_exts);
 	}
 }
 
@@ -2228,30 +2214,28 @@ static inline void free_slab_obj_exts(struct slab *slab)
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
-static inline struct slabobj_ext *
-prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
+static inline unsigned long
+prepare_slab_obj_exts_hook(struct kmem_cache *s, struct slab *slab,
+			   gfp_t flags, void *p)
 {
-	struct slab *slab;
-	unsigned long obj_exts;
-
-	slab = virt_to_slab(p);
-	obj_exts = slab_obj_exts(slab);
-	if (!obj_exts &&
+	if (!slab_obj_exts(slab) &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
 		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
 			     __func__, s->name);
-		return NULL;
+		return 0;
 	}
 
-	obj_exts = slab_obj_exts(slab);
-	return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
+	return slab_obj_exts(slab);
 }
 
+
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline void
 __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
+	unsigned long obj_exts;
 	struct slabobj_ext *obj_ext;
+	struct slab *slab;
 
 	if (!object)
 		return;
@@ -2262,16 +2246,23 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	if (flags & __GFP_NO_OBJ_EXT)
 		return;
 
-	obj_ext = prepare_slab_obj_ext_hook(s, flags, object);
+	slab = virt_to_slab(object);
+	obj_exts = prepare_slab_obj_exts_hook(s, slab, flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_ext))
+	if (obj_exts) {
+		unsigned int obj_idx = obj_to_index(s, slab, object);
+
+		get_slab_obj_exts(obj_exts);
+		obj_ext = slab_obj_ext(slab, obj_exts, obj_idx);
 		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
-	else
+		put_slab_obj_exts(obj_exts);
+	} else {
 		alloc_tag_set_inaccurate(current->alloc_tag);
+	}
 }
 
 static inline void
@@ -2297,11 +2288,13 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	if (!obj_exts)
 		return;
 
+	get_slab_obj_exts(obj_exts);
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
 		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
+	put_slab_obj_exts(obj_exts);
 }
 
 static inline void
@@ -2368,7 +2361,9 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 	if (likely(!obj_exts))
 		return;
 
+	get_slab_obj_exts(obj_exts);
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
+	put_slab_obj_exts(obj_exts);
 }
 
 static __fastpath_inline
@@ -2418,10 +2413,14 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 	/* Ignore already charged objects. */
 	obj_exts = slab_obj_exts(slab);
 	if (obj_exts) {
+		get_slab_obj_exts(obj_exts);
 		off = obj_to_index(s, slab, p);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
-		if (unlikely(obj_ext->objcg))
+		if (unlikely(obj_ext->objcg)) {
+			put_slab_obj_exts(obj_exts);
 			return true;
+		}
+		put_slab_obj_exts(obj_exts);
 	}
 
 	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
-- 
2.43.0


