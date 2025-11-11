Return-Path: <cgroups+bounces-11774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEEBC4B20E
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39951189C0BE
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 01:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A030E0F7;
	Tue, 11 Nov 2025 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="crubX3bZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ziKW/30G"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D730C639;
	Tue, 11 Nov 2025 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825614; cv=fail; b=MaZTztA4bXwL1zHshjT4qpsPpp5qg1jIpBc6GT6ACrLpLch8dlX8mmnA1zDUmCeB0XNyadpBtgl8MHwpK2FebCxchJvEv3UDDDUTxTCAseH7lWG4Yv2FQtYmSghWptXivPnhVXn86WWemWwMhPo2yc5ENTcuJA4PcQjalvPV1Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825614; c=relaxed/simple;
	bh=uLk0GGNuG2wOYNk/9JhL7j5fMf3z/JkVbEP4aGGowNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jj7RMZD0Jn71QjmZPZi1/N7NAWnTtYjQ7btWH73id+dgMTC47WrUKEh8Pbtxo2jEcvlJE19YKgLVC2DPZEjKxwUTYQzFWcU/WDpgROG07pQKR/JCWcivu76I81BGrlSP7htdTxmYovaRPkCA6gdAL1aoppyjVrFq3HZW4i7NOYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=crubX3bZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ziKW/30G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB1dbW9005133;
	Tue, 11 Nov 2025 01:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qfMdH+QHWZezPGDg9X
	62zGarkyl5wdkJpPkkby4eCOk=; b=crubX3bZWNqZ/T5h3zYIOmaSOQ8A8FnA3O
	6hMYIUg2dFBnK27+HCyKg3loSUFBFMvyanDUQA8Xd1SDh62PRMl75Bth/LAo8w6D
	55ArqtO6FLIbphaL3S1F8zH2iyo4EGKQWmqJL4/Wfkam8gNsdcebrbFgK3DtZF+2
	9U50oThFHHaqsdIlKygpuvByP1T9dBJo2q8fQq75i89GHwfc1uET8K8RcSef4/mM
	Al6H307QpGQAba9T3e1ipIqS7/zSmP0LjrIkLWbQgGvq08bkyDUFrNQbEcTQgZRT
	LgFFTrd8d8A8zAwVqcq3HNPkL5xCU6Q+UvtJ1zvDIj3fw4XWmI3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abswx04fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 01:46:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB0UDgB010027;
	Tue, 11 Nov 2025 01:46:37 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vajp51f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 01:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCrYz/5MLIPVN+Icc+Z+tLM/TVrbf+hRLyVzpxaQY1kxztAZk4qYD2oHYbj5iIQjKQ+b4SjqP4J8FHJlTNwW/IkKQ1rH6fgnpjNfm0wdpzqphaBCZCA4/iDB0eb9OrAoS+6aWQZJe1/g091o7wJdb96V4TQLy/Qtp7t+BbZqWXFxyhIUgBwUKKXxLv0pzmfZitjl3NnVcxSkoc9kheann+Px+PzDES9jkfFGnwjUYAjkBtk3DI7JaVpog7JhJTatj0d2uUXPatNGwX3iwbaw/qsho3nEmfDmV5FkwV+iewk2xFuofv81/jx4GNy74NBL/otmto3LESHRYoiL1+zKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfMdH+QHWZezPGDg9X62zGarkyl5wdkJpPkkby4eCOk=;
 b=Q/VdeRmp0rypTajWtsU8zyVoe0Qq7ze68EQLnnWJB80tHxezy19zw0Cl0jftXbeTjL5xH2Lv+61C6l+xHTMWkcWcU+TzY4YGAxnSbOAx6zsagah0nC0pNUGZirB8PIC9CkQekcxDYI53UAsZrX4rIwbMAlO62SUPHT1HQokfRsKf/G7kPP0WWBqWQDX7PiVUKsUvhYpDRH5PihoIEN56oboeXD1NR6FpXu1jrE4bfCueRWoYAJTnK8avLhIiz4yoM23fupo4YfdyiQ66goqo6R+r326aVZ+5fruNttnp/chg9kaoj4PCEiTjxEHx/b0N/VlJO0d018kB4tc8huRr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfMdH+QHWZezPGDg9X62zGarkyl5wdkJpPkkby4eCOk=;
 b=ziKW/30GOdZUlxLmqkFsor5Y7mfZw5D/UdYJkUvynkW9vDz09RJcy0QC7vORLj9KX2Wn4FP2QKqbObDqsR2Ug2ifWriWQu0SFnhYJ8T5VNL9Adgw/A2b9WpWRJ6HFgCZ563HwDS9XfeJiYq4cTgDVK/EWROo2XIOZpYBqOMJiws=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:46:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:46:33 +0000
Date: Tue, 11 Nov 2025 10:46:26 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/4] memcg: remove __mod_lruvec_kmem_state
Message-ID: <aRKVcvAEIuCqUdsx@hyeyoo>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110232008.1352063-3-shakeel.butt@linux.dev>
X-ClientProxiedBy: SE2P216CA0122.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6bebb4-8cba-41c1-9ebc-08de20c42445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HGoEqdtiDM7hXiAahFvektnQeANvTwh58/o1wfzLWRwEyZgw0XgV3VNp04Fm?=
 =?us-ascii?Q?7GBKi5SVmKxYN/vlfekUdeq6/7BMcvHJXQk1Yv1QMI4TxccVgwmJH5hKXz+n?=
 =?us-ascii?Q?QtohzpeHOGTmB6WQcAmlEiFdFgoYek1iQoQRZvNOhOAH2wq3yc3FrE02vAQb?=
 =?us-ascii?Q?SrlMiOhD7Q07Ld8ncI7+aDFyfzPb5ZkQ4axxv11m668ie41lHgELrcS02v5V?=
 =?us-ascii?Q?8wkzymz4Px1MweM4Ch5/gTBJKaMw36J5EfTQDt6SjBrJTwRbOmI9u5YMY4nS?=
 =?us-ascii?Q?vIKaytnK6ZumCnwdOszntsr+5WBBlfWiMrI4j52plG2tEBg0Skq+AWNJQesH?=
 =?us-ascii?Q?nMX8OhqEtix9PuTQeAeEJsSJjn1EdVu8Bp6M3fUou5B3D8bu8EY0Uayj8T7R?=
 =?us-ascii?Q?dcJDRxCmnDJltg4I1otNq30uKWSCG3cNJcFbWk4YybOKMtWiLXpuu70IVlps?=
 =?us-ascii?Q?g8Kb+BSwfesa8JfOGndvdI1a00oocqu1z2BCjSt8tiOrljjh3HtnRo3NnNsX?=
 =?us-ascii?Q?Nzz3eP4WvGwfQx/k2Ze8Tf7gWbFxFNECvxNvLrkU+4JbCL+QqaRnbJJFXTVo?=
 =?us-ascii?Q?ZqXf8ybwKMLVFS/1wjyEeFVm5QM/4lCVD4mA/xq70CP/DJmEYdXqncqombvL?=
 =?us-ascii?Q?4TwP/Z9jueajUYcMZmUzB3PgEHBMhjbZUhZyBSBQefeGJx7bpBHJcElV3GqP?=
 =?us-ascii?Q?4lURmIiK/HBnRFC+45hzgG3++rTXnC8u4nBpcHbjf6rmXN/SacRn+nAZ0aB8?=
 =?us-ascii?Q?C97Yl5zkBeHh6QySMroA4piRrFgJlGETTJFfcil2DmaZCpOE6bBngQ/+QIMb?=
 =?us-ascii?Q?5ZuC4l8eCvq1lUQSD3e7H8JSpBP7tsfer+Px6MwWhzwlZIMMBCcR6rtQcVli?=
 =?us-ascii?Q?NqRknrolcilcqrjpfVsSD4/vYA5lYsx1Lyx7fSSp8ywsFIOTHiqvFvzDVKrn?=
 =?us-ascii?Q?y5+/h/RWyvZOfUXddRnDoAxZV7IGWdx6/8BSffsDN13Urx5r5z1ZoYbZL3Kn?=
 =?us-ascii?Q?G4JZCXfOizmrah2STme8HmBA+9Zgad5trRPRdiev5v+BvE0oTwc3Oi3wGnpQ?=
 =?us-ascii?Q?/IfJ/KkUpWttQdtpVPuzogCI/jJqaw20pYKq4gDGZaT2kXWjeAeO4+nuTQqR?=
 =?us-ascii?Q?zO/EdWUzdfFIok2xffiC5uATEv7xzrQnDD2NwHNj03IOfoBdEi4OljOOl5b9?=
 =?us-ascii?Q?knM/H2DQQLFXfxPoNJ3hIiYqAbYtasqk3bl9mNSqTXtbkI+lHOptLCT8mDlO?=
 =?us-ascii?Q?jy3JEtRywY+y+RLdDkstfGXkecR6LjsblqGomr+6RKHfJXgPMpuwgGdxzoPZ?=
 =?us-ascii?Q?3d37J2SWoGbss0zE8af/1E9ihoQTftbr2lqNoGs2UYB4r87/uzqQ2CWdfSBE?=
 =?us-ascii?Q?mDrZvqKcsgjP34ccHQ+b5LfeOE96wmkkmBEJlCoIdDlCuOcAFQWIxQVUQuFx?=
 =?us-ascii?Q?AJOVY9PIOc74gq23YoHFrNmIxq0cGO1u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kp1w8N3tWZPH777PjVNA/4Vf1wF3pYVryIh/ENvDIOWJKiCm7OP1OBrWaAHg?=
 =?us-ascii?Q?gb/kQrzt2A7D0C6Bo+z6gsOniTpoztLr7q5nTx0KJsv+TY/kf9Tn3MPcO2/I?=
 =?us-ascii?Q?g3O9SOAJ+HYlCzCC89IQQdkv48Wblc2ulVAK5oUegj4J06KaD85t/xg7FgAT?=
 =?us-ascii?Q?sD7RJsPBD3oSH2b8jqHH1eFm70tZRYmiYP+FJkVKfYBFlhddHFBxKDVUBMAr?=
 =?us-ascii?Q?carN+AW3TOTMGerkSBuojk6VATt/b/9uGty4nbq4zR6S0EhyHKep+T7wuCk1?=
 =?us-ascii?Q?f+cM1abPbjTB3VR0HDTmPXOFUih9TogbftgX+HxCwONznS6ohftLMedC6WDA?=
 =?us-ascii?Q?rF7hNIWT9xUw4RKMhoEWvzYjIng0H+KT+wpnZ8MJdjMlt5TeJhFjrqO7L9UC?=
 =?us-ascii?Q?UtJrcUOFpVoRq0zF1aQ8WRilj7Sk1h/mTRyknp0dLq6PMd+WsYx2VWyqYPcr?=
 =?us-ascii?Q?y68fl9YRyMtinyKpbVfCPlVMV5lt+VL8agxNXL5CNpasSckF5RikIkLUV2X+?=
 =?us-ascii?Q?dl7PMuZzm+jOFNHwdnlQbkKHEepj+KCgvrCLcBBZQlw0Mj3Y0edNj6xcpRa/?=
 =?us-ascii?Q?rDL2ALIbno21kvf2Nc2/4B1rHakAD0ggqwkK04cJrsxzO5Mqm0p+MCKIWxVc?=
 =?us-ascii?Q?6TRfr10dC1EoevyH5EFaulY/La5Qv2pZ2zf65TEctQUxfRyK6+jKP8PKA8/5?=
 =?us-ascii?Q?hw20jcQsDjfSESbDYm7GWtoyThPYrQSd3QkHi5REZqOR3SSlMHZGqdAWQzJ7?=
 =?us-ascii?Q?nR7AJ/2rJopKmCC3VUJ16SL4zgLuD60XZXFQRHhfjFaZ+ADYfbJvLruU6l9w?=
 =?us-ascii?Q?srVGudaC6s15/upDY+LxjehaV/KF7hyUpJcNhmSgztXS4v3CY050a3xOWiw6?=
 =?us-ascii?Q?QmX7sEmCKTr8DZKp8C1EATJqeSGsnOp3RDiD/BLMfXYm31NBVUvmf/5IuXZH?=
 =?us-ascii?Q?fhoS3Dfe4cWwK8hmPj/ozViGk7OlEyrsQlKCSRwtc9ajfKrVdZNkFvIr4LNb?=
 =?us-ascii?Q?W+ACEUbJL84EFk/UUD8V+5DJgGVEGBhCgg7TL9bRFAb2t1PMPhAHE7gnGBmT?=
 =?us-ascii?Q?avTERA4UFheWTLPeeHdoDlkiOIqXQCLorMZV7YKoAoGGdsr98zWyqfBJYFDN?=
 =?us-ascii?Q?TjSZlvHoJTRe8tKfjuo5OmiF/sz5ehZ9Q2duNAHTFLlhq6TkXNSbB2IbSrG/?=
 =?us-ascii?Q?1iw3Sc4Dyh1A8hlW0P55GOn907wtnSFm3VvRoAhhs9Lglecl4Vi3a/VZR3Bn?=
 =?us-ascii?Q?6qHuqimjoM5LiTIrkC7T7dtKBjOP/OKHme0szuOis4jRGrDFzmkx2JPGp2/c?=
 =?us-ascii?Q?XRYAQAm/D3gLOPyEKIOz5SD+quyZt3TNyp4o73NawadTkCTKtx83mZQ3L4jO?=
 =?us-ascii?Q?gEPDZhFvIDZwpSziCUwNyczlBhxULCld4dmT33uW+3r2keDaqcve14JuS9nj?=
 =?us-ascii?Q?oIjUYU8Pz73Of8Kd0mENZbwB7rPHlLnxwWJZnXFNPo6u/D1yczMChO7lqkuc?=
 =?us-ascii?Q?t6lqb4HHoaRTCllrt2wvdDZeWJ7R1K/tQs4qbI78LD+f+0HpY9b/ZOfgsJDf?=
 =?us-ascii?Q?+GizEFjJftRJwl7k7YlGoBGhRqc3hhCdbUpvSZe8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KFokmDqGoQ5bWLlpg+kPtBgiPq+oN9yhAkaMjPDMZHQv9NDt7JyFSc2VcO0N0CjZL6q8OMmNCWB7P9VBh3EgA5bRkozEcDOr4iSsBwJPPf5BZKm0wYEsEBalGpoXatvK6zCMnQP/S+eZFgu/RWK5QZ81uKK97g1CvzoOTc5D8v4y8oZjnsbVmUQ8cdK26JlUagPuVULlro2gJAZfGclPa0KzT+dVY3J0QgJIfz1E1blvQP3fM4/Z61WppNNwY4JfZtZyw5lDNHfBbu65/TDSI+1Ka6S4jE9O4Ibbf46Sjc6k7jJpuXNjH9V5FM3KgwenDtnStFnVnVtlCnnhGMr36sEOkauoDGNsZcaSbkoAZ26pcXdUjTbwWzJry+1qIDln4S/dVEg7IHHE+cHaiDejRExEka9TY4uEe3+i3r+82ehiButLXoEkUHqce90GdiWxauSedSOV++R1qVo/hxy0qBXYWRcp3QAc+cmIY9hCaMIxyGRWcWME2Vr1VnKoYWxp9iO+Xkxl8HHDzhqq47Twz4SDOEnslMu5nzPx5m5Ocu0pwvfkX2bIaBibvlobXKLIwoIopjeDftjQKlsiEJ+pdJ+n+2XpSUScuP3wCq1ST+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6bebb4-8cba-41c1-9ebc-08de20c42445
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 01:46:33.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgFtftOkxQlZVMNfKEz+XDkzDBFXn/jqwJmTOeofW1ZK7yjaD9FufSgeygANq4R06YTMtUr2v+S5UwFNTf3q6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110009
X-Authority-Analysis: v=2.4 cv=L/sQguT8 c=1 sm=1 tr=0 ts=6912957f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=xRdWLtFIPaT35W9Np9gA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12100
X-Proofpoint-ORIG-GUID: 5eHMLsddXJfIgHdpRR1aZ8R_t_49saTA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5OSBTYWx0ZWRfX9CNM1+0yGXy2
 9p++hCe0eTBnIHHR0YS9MKkiZV7SXiG810MNEBZBFVuAdaDnQJjP+yfocP/tPiQjQY0DbF0k+i8
 6Cwek7PqM/6TzTY+TUTtT+FB80YNDLZQ/ztcJpibUE9QOoQB8UsgZqEM6N2cdj49XdOkxSup+ao
 0c1aRpM/ZYPDOFFmW6ZWTZXdvobuM3Ql8OpNpBSWn04vyiwXTq/ePxcmKxPSw53W5SzVqu44dCG
 j3H1SfNF1snjXEwiHq6+rpP3sUahan5SxqCOkeULJFZNdNC1lY9LjTHN8Ub6Ql+tlCVV0Accub8
 84l2Tc9HwvpUORQerbqwqoC3jFMupbeMPoQoqI7raxqZB9H6OopfvDsey41H4+vY0q3bhgdwzeY
 qoH4SLj3ErVy4eA8Y6dGeujiCpzHjdf04+k9hPyG01l/UYsDayI=
X-Proofpoint-GUID: 5eHMLsddXJfIgHdpRR1aZ8R_t_49saTA

On Mon, Nov 10, 2025 at 03:20:06PM -0800, Shakeel Butt wrote:
> The __mod_lruvec_kmem_state is already safe against irqs, so there is no
> need to have a separate interface (i.e. mod_lruvec_kmem_state) which
> wraps calls to it with irq disabling and reenabling. Let's rename
> __mod_lruvec_kmem_state to mod_lruvec_kmem_state.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

