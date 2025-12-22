Return-Path: <cgroups+bounces-12584-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C697CD5C10
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 12:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E31030036E6
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB4314D21;
	Mon, 22 Dec 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dv+4so48";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VhX8tvfM"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B722313E36;
	Mon, 22 Dec 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401804; cv=fail; b=u8s0E2Mkxg2C8qiMizcuMtfW0nqz28xRtWG598lLO5BO5BBhsyqZdJVGSMf+29tY9U1Zl6WapvmdQQljXzVHcMroQ8qx7HDne4lWgFX71TMeayP3QSHGHyzU92CMwmVrlD4HgSlj6kWGRuIfYONuXXf1ba7iTWZv5gvGkCriev0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401804; c=relaxed/simple;
	bh=tkM/g7JFfIXgGrgl7Q4jbMSyQuQOmKRObMQXO3gZx40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSJ2wQWDj41r8NSZK7ABzfYAHhaQ/wFMCheJhN6FYhpv9peJTtYtCJECOlRorNfEyJyC8o0oZYgiIOgbj3T97Y/Fp2FhNhIlZbaUelOSk3gHPWv+02GtMHTYVIT41U1IaQfQqN3r/gP89Sz9iAxb6UbJQqz9gnAmURASafD9p7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dv+4so48; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VhX8tvfM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMB6OM82055836;
	Mon, 22 Dec 2025 11:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZgYDq55NddTdCoq575ubZpsBGuiiamuptc/Tq51krig=; b=
	Dv+4so48T2OZWNDd9Sn1DiCjdkw+REvpTSJO+dBsfMI3hS/djLCHP/Jvap0553RV
	NUP8H601T04JC/DMgIg6+kgbMpgX7nU+Lx2JwMrORw5SZBNr63Yc/H6FakXwWM4u
	4+ML4cXPgeFLq0bkRqlLjnVHyDfMueD5hZC8Ym1aYkJQx0+uPoRY5+tWmWv/iXzC
	DiKPDV+HklTQQX3YLuTrQhAbVYs3n4egKcni4kaE8hHf5j12FCsoJOLZxOusToE4
	I3xITkH3fqyqL3FrbHQXeTUTszyCfsQBIQhHGLENwoouDCd5+dituom1a9wCNm9T
	UQnGsDYaVkF9M5vEhoWeew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b74ttg0bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM9mdIn032802;
	Mon, 22 Dec 2025 11:09:29 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j876j41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH33xRrlCqTi2wXA6b48YZXV0VcAdLwZsDzax8fYWnjjtQk03ZF05SPdASH4Y1kzlOWx/cyaYQBVH2+S62tymwhoYnuyfxim2IbYcBj1i7iJL8WsaYv5cj88CRbcIOo4QDkEyZFY7hadBS4JD8MnZ8mVyxgfK4ZqYw39yborAMyDU/DlI72Gcr5Ao3QwrihbnCSkuxv0LH+XaG4iRkxpkhhPpE2T7ezRO6ivWyFZHICrQZPlD48lSOUmwpQeFyWOUn/+KhSztiIXNA1NfkfuXhsG2pCRV9yhVY6lDDP1HW8si599whgou1d68H4nB1a7qFpMXu7D+NSMso2zj7O/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgYDq55NddTdCoq575ubZpsBGuiiamuptc/Tq51krig=;
 b=r+E12thPUoCvUNnG3cdMLm7Y34xRU5xMo05am6ReS569IamJzypSU97GoWrw1rh8kzdhubEX2Rpl8nyOc7Rw+mAsqZlbfyHhNCkPmKL5G5Cqe1rzSkiGBBVzP7Gy0UO/UV0ehP7pJEtwDsj8LYlM8N8I6iRANcTInDNx2liazUX9DVgudoTdxxSZECcYIOo7Rr4LwYxDenKEnwDIAxa+wsH7UMdGR7ZrGsyyirDqipBZ11mM9DwOAYcjE7CFqcL08U3Pw0AHJhHbZPkZGqjdY3O7UfV/+oWKVc+DuBOA3c8fb7CobCJNauly+jeVfSX9kTDLMLtYXnwcUWzdaGGXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgYDq55NddTdCoq575ubZpsBGuiiamuptc/Tq51krig=;
 b=VhX8tvfMRoru5J8MyGO9CWmyCAmClBz4r63XhSNNNgjc1YqRwEGBUNyfNJPhfsOqtLmqJV97WzzTjAcr67QGrfnkRAHlV/5cu5f9VFgiTEgqM7A2+glVjw1ltWYD04Wl7R6CIYUEsB2mlGaJAINFi7qCphO7XjMkRyFAlFw5HTM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 11:09:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 11:09:26 +0000
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
Subject: [PATCH V4 8/8] mm/slab: place slabobj_ext metadata in unused space within s->size
Date: Mon, 22 Dec 2025 20:08:43 +0900
Message-ID: <20251222110843.980347-9-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222110843.980347-1-harry.yoo@oracle.com>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0092.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb6cd0b-841b-4723-7435-08de414a91b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z8DmiA+rtG8LXtEvkOt8bXQ8z+sXSP4EKrgrndy5nu/RRZt0isV8JoXtj/Oo?=
 =?us-ascii?Q?PEk8SKXiBgKSfYAjqubUKYywzRU6rlBrrnhOQ49Q3GtgdvSGlYOIkoR/tz6t?=
 =?us-ascii?Q?BDf8dVt3B/THnd+4XM7Hi4n/fUzOZWYGOJHNM4uORsLBtyCXFizGLiA92H1Q?=
 =?us-ascii?Q?7c8Lw+ismeMFp/7DmyT2kKfwcledGcWY5Q4RN1VlfBuRAY5BOMMM3lUJ9SwV?=
 =?us-ascii?Q?Vn4e4Yk+Ln+gvi4Kri7pLKvTz4dqArjAUaixFwLijigrJIkJcpe8aD4b+Go8?=
 =?us-ascii?Q?BZM1RThZWudz0pgiS5xCpnw5eSBc2wjkDcdrlj5b12E6qZPHxVP1t/eVfXsq?=
 =?us-ascii?Q?J35ZRDzbNOCZX2jhEF+F1Jnuzp6eGYH58Iyptq6W18uc0yV15oqraMk/auqG?=
 =?us-ascii?Q?gaGoEBkzx+FUE17ztqvM+/3YA0Fju2DY+Azu38raMSs1SApHuNuJt27vV/vT?=
 =?us-ascii?Q?HPFLZXGGeWg+UoUQ41ItXQkUDa551WqrNHgT6d2vR2Mx7Nh3eAixpX7BTur8?=
 =?us-ascii?Q?3J0c34YUWxyMy470MTVso2EZ0AVtPqxqOHPiLLK0c0926f2lGM1wfP2hrP49?=
 =?us-ascii?Q?rCftNQwDzQvB3EWl8+gpnSwq5sFrA02WpXyIR4ViSfB0qKtAk2+DzmQLF3za?=
 =?us-ascii?Q?f6upyCbD8qrGE22Ak5BLQefugXNTRld0odVVeTDwtZFXnrLilUYretU4KgBB?=
 =?us-ascii?Q?Z+sXHMVEGCaB38wlV9SettlNIk+GYSE+pqc2q26Kmp1eKfHf94C9481NwNLe?=
 =?us-ascii?Q?gKG3XQ6DMReXR4b30km+CEGyYHNcHdLGGPE995T3OlVO1qOUWL0P00roI+UQ?=
 =?us-ascii?Q?SDXpoqtJnYgJQEUNsDwCjr+p6sSrmP5gU9o3SR9xak0+4qqZ8eAnpFfAeNM2?=
 =?us-ascii?Q?WX0LtXpxHm2i5gf3niT4n1BGA1u6FERTQ1PZwVmeIdK5R0ZC1m83Z7HZmU9I?=
 =?us-ascii?Q?nHCi1U/cSo3PXbFxTG1/ot77pyYOkAbRq18FdMt6bnJVP6O6azZClK+rTeNy?=
 =?us-ascii?Q?Dv+If4tHlvYlKuhAissTRoWaQtxtaDPbJcAdUUEekSu/1fJQk+VKKYGqWb+0?=
 =?us-ascii?Q?LhsofsSSlAH+SbIyezQa9LifkZ+ZCrrm75nZ0ILJ3No7QY5tHZmeQBoGFQH7?=
 =?us-ascii?Q?0PVZeTj52bmh5sOBVzwstF/n05oT1wFNkv/HA6iDjVJeJtL7VSNwSOFhGq9N?=
 =?us-ascii?Q?JjrievIKYhVgM/4K1dxe9JxFLtDRsuNwd1WiYyUhGHLACF6PssxOC+4i7k6g?=
 =?us-ascii?Q?jfxBOAjIMKZ+u9wE2p4mtEPIYGRaFUa/Ss3EIvf1pOJx1EpZsneNSNWy+vU5?=
 =?us-ascii?Q?7la0Pj7CLrGwmljkDnvxTCmLdv6ouaLRb99SkHmMIEY7SkC68x5G9J4bqXqz?=
 =?us-ascii?Q?znDJKT91csQjHov4rcs1f2OEJYQU97VMCbkvkl6opJvi3CFCypV7BcvWXVXg?=
 =?us-ascii?Q?yTcK/RisgfHbzpFYebAYn6LEHWE64UH0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WY2Q0SSKDGVxn6VGatWwu9F+eqnRo9TZEwvFxr0cXXjxRTjsM332vGVG7RSF?=
 =?us-ascii?Q?pMOv9tnqj08OzQl+TfrcTxHRtsPt/jQhKRlI4INT2vmeUSHt5hwHOofOY5bS?=
 =?us-ascii?Q?gkMFUQAHWT6tf3hlMFqLiyiRrCpXTEPJ2pTsGymua0HVkwmfRGLkctsKsU0T?=
 =?us-ascii?Q?tVVzAmeHyK3to06Z4/wwjjUdtxi6TkZl3mjWS0G4zmWWr2MXfH+6t0W2bs7F?=
 =?us-ascii?Q?kKE9Gl8WrU4IWFPMX9WuxKMviZl5kEgYk5QnuTjiI2axkLWwo6iV50s0cl4h?=
 =?us-ascii?Q?TGBt9cWuNaMYFyWR5OpHwFc7GSLjYf0kdJVRR8k1qVWylD3Rvb2U8/Obu6iU?=
 =?us-ascii?Q?B+bLJZk08Dk9W54tdK9hREAV3iJBzVzhhOAq4cT72vDut9iLAJFhJPODwHDA?=
 =?us-ascii?Q?LsZoTR0vr6i8V82X3UA9OYeRyZOZZQsw/5Eips1HC+z1cZKkpGB67KUTGLsv?=
 =?us-ascii?Q?uSAMfA1mh/PVT31hw3UWIP4rmT8AFPAkvJY6u7c3I7sJ8LcAwoFKeX7NyXY4?=
 =?us-ascii?Q?2SvFK2ta9uQlJlH9+rdxfiwxQtdIo91AHRW9NbgqSBRLN4gKEcE76Lg7JKnM?=
 =?us-ascii?Q?vYkVv7QYFZR3sNcnlVlrtAfGgACRC9WwCgERO7UQQ4lQCZ1xjb+LYJct++mk?=
 =?us-ascii?Q?FN77iui1FiBgqCcPNUuXJejn997Sy3j60tk1Psh82Zr4HTeHmxh1cop8+jtA?=
 =?us-ascii?Q?DdeHilElpPXNUaNreEuvE9904GXU3HJ3CLdBH9eYVbTMQ2oDwdubfJGg+Cs+?=
 =?us-ascii?Q?RivH+HqZPTyLsgoc76/xfb5nC3bUPkzC+WlhFsi7b5H156aZCpcXLOIzm8WV?=
 =?us-ascii?Q?6VwBFKDv7xrZpTKuhwFIIohqo3EFAuEOTLEi0ZlqX1yZdG5rCtCwmaDWpRMj?=
 =?us-ascii?Q?u9tfE073X6ZmGj73zbJQU7M04pL4ASMxCkZOAlCR6EKP/670SYyNd19NwRbL?=
 =?us-ascii?Q?SK0z+0btdx2vSSric8M0URo9h3+k8OCLJdQ4vTMyjwfXQys1lz79y/ShshuQ?=
 =?us-ascii?Q?87OUkqi9nuWgVUZou1UeFlfJ2sErMerfZwp753J0TtVf5WHHkz6quOz8ARcn?=
 =?us-ascii?Q?cMiBV60jb6BNp5K2lDfkELh47ZNlZy7pLSUN0zqjaF9QjrPZADiBfdW6DXI6?=
 =?us-ascii?Q?pPrmQJvVtyzHU6o1csS87k3bCiA2t+HrPvVSLllNLOwSbbN40kfgil8xb/h6?=
 =?us-ascii?Q?papB1+w2fv5HuE1v9xNRp0z57ngw3YYoBIxOa4J9QOmtn8l+1+wG+/g0/MZU?=
 =?us-ascii?Q?7iB78kjMtNu0SKEVDGfJJm9yRaNpqowj1gFPJOQw09/WC56/jVpY11AqR7+T?=
 =?us-ascii?Q?2HxlN5Am8YmKpAkEDTcr2YEMnQoNE4rSQYPNo570TkWwTwsmKcxxKy4Zp1T7?=
 =?us-ascii?Q?zFfvqDB33DAw+lpoMQ1q8A37s4o8cqes7zUAwqFKBRHWHPz4IOzxAO1AN7PN?=
 =?us-ascii?Q?dRyk++OsAR7rp0gSwk9lBnF3qDBXCMGpwA6qz9nXV2ErY5gf717aIq3fhN7J?=
 =?us-ascii?Q?os5JKdzKp8WYpXTrHMu+gzMWeoFsFGlzuXUMaqe/PJIwkYZ6f/9kvUkB2Eic?=
 =?us-ascii?Q?LLNr0dexx55dir2W4g5VGVwsRXjiicJg4420ET8t0EmvnEiNtwrKwcQmj+j5?=
 =?us-ascii?Q?hla9/0HRU5m1dypRk/6msWRjTeYnyCdIaexUHyINna3ACiBqon6zY6S+UJ7/?=
 =?us-ascii?Q?o3TRykCfN1xmGXEZnqvQwpk9xrjXhdH3NpqBDDSiT8lOiBvR1p1MdEhfWDpF?=
 =?us-ascii?Q?tYgiBGE1vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CCz2H0edbkc5DP4qHMFx8qQLiSpJ8pr4BYxwz8jEfXnRIQdhRwCg71mF4Gl2GaRwTeAGSXxTzAznxgF6vq07iU/n9eQckyujbeJM4yNNEYoX6oZ/IVtlAKqj1y7vREjRC9POt6Do8V8bttz9TuOpplGToTTupA1G/UvguI3BQv6aLLHapxrkMV3XWm9crCAbROli4NnCXOhTz4AToVvUGx2PbodB37ZUTz7susgRbXs/tBOv58eEFLZpL8SBSU6dFh/pWxap0pZE8jhvg4qUlW0zibdTYX0e3uFLCrzLlR+Il6JFSXbDK8LeMdMMqjkP1l+IGxRnkaWGPy04RXJrvjmZLQy72dFsBBmXZWIm3T7O5jVwlZ9qU2saKPAH2lodlt5siGihoH6/JY4a4VavF5A2QoKkJn6sIMN5Plp6rSADnm0AzydMY1d5xsrFs3GvRavnx0xNumm9Sv1EN4hufnvyR+leDJypT6QyHBULx5M7O71BhVN7bU6Fim27b5Vr1VXPG8YZPuqkCYjhP93bqU6SHjJVMTGSw486DLbXQoz/ixwBHfbfy9vvaJBwGFWkOAfY3jbw7F1cZNQQMOxo/w5rIRJOYKwP/ClBdJ2IC3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb6cd0b-841b-4723-7435-08de414a91b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:09:26.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFyQ6QLQpOO9Z2B3bH7lgOhmtKK8eiXPcCeKO8aDxN/lB+rJakZJcaamayPUmDeQfN2cjEQPb1eexiI8ELHRQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220101
X-Proofpoint-ORIG-GUID: ai1fBMJ28Pei0_ko_T9-9rcDDmdtIkYy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMSBTYWx0ZWRfX7FVL+6Vvm+zO
 VSFjO59pcXi2YQEPSrTJFrnHdw1DM0U+JVmDoa5//YP5CZAnwUdH/ynraYjE1mQsfaFQp4lMB36
 uDyEiKE2YnovLOwdFxPOjZIPoORVyKw42GLwcQq0jIreLywSYFEf8nc41y1R5r+E/MpdGEIY9Ij
 +6RBQ+6Mu8/tkHRlrHnfRq/7AySIlF3GBKJmu2c+jasYGlU9OzeovtOzI5YNHc9H8/zRimsE+N+
 mS1YV26PuHHUCRl+5jJT6Yxx2mJ0d2U+WEzV+CmVw8kVaf+wvAaOx7Zvo/gYBpNWC5QT8oPlrcT
 WMGxh6Z3QDaN8SCt5Or5zH6oYNXZ2ApWYDMJTzFHTtfGfvsDVKX/R1XYDj3KupBf8OWyl43HyW0
 cNORtj4DEvIWPP/fpmIusRbFdrP1l7YX3YIgV30+7oG9t+3AbekiVzUQ2eyyjFFwx4AxmZmEvJK
 E7JeXdJidJRHbAhv9sQ==
X-Proofpoint-GUID: ai1fBMJ28Pei0_ko_T9-9rcDDmdtIkYy
X-Authority-Analysis: v=2.4 cv=d8H4CBjE c=1 sm=1 tr=0 ts=694926ea cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lMPLp5VHBhqu3uUK-QgA:9

When a cache has high s->align value and s->object_size is not aligned
to it, each object ends up with some unused space because of alignment.
If this wasted space is big enough, we can use it to store the
slabobj_ext metadata instead of wasting it.

On my system, this happens with caches like kmem_cache, mm_struct, pid,
task_struct, sighand_cache, xfs_inode, and others.

To place the slabobj_ext metadata within each object, the existing
slab_obj_ext() logic can still be used by setting:

  - slab->obj_exts = slab_address(slab) + s->red_left_zone +
                     (slabobj_ext offset)
  - stride = s->size

slab_obj_ext() doesn't need know where the metadata is stored,
so this method works without adding extra overhead to slab_obj_ext().

A good example benefiting from this optimization is xfs_inode
(object_size: 992, align: 64). To measure memory savings, 2 millions of
files were created on XFS.

[ MEMCG=y, MEM_ALLOC_PROFILING=n ]

Before patch (creating ~2.64M directories on xfs):
  Slab:            5175976 kB
  SReclaimable:    3837524 kB
  SUnreclaim:      1338452 kB

After patch (creating ~2.64M directories on xfs):
  Slab:            5152912 kB
  SReclaimable:    3838568 kB
  SUnreclaim:      1314344 kB (-23.54 MiB)

Enjoy the memory savings!

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/slab.h |  9 ++++++
 mm/slab_common.c     |  6 ++--
 mm/slub.c            | 73 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4554c04a9bd7..da512d9ab1a0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -59,6 +59,9 @@ enum _slab_flag_bits {
 	_SLAB_CMPXCHG_DOUBLE,
 #ifdef CONFIG_SLAB_OBJ_EXT
 	_SLAB_NO_OBJ_EXT,
+#endif
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+	_SLAB_OBJ_EXT_IN_OBJ,
 #endif
 	_SLAB_FLAGS_LAST_BIT
 };
@@ -244,6 +247,12 @@ enum _slab_flag_bits {
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
 #endif
 
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
+#else
+#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab_common.c b/mm/slab_common.c
index c4cf9ed2ec92..f0a6db20d7ea 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
 struct kmem_cache *kmem_cache;
 
 /*
- * Set of flags that will prevent slab merging
+ * Set of flags that will prevent slab merging.
+ * Any flag that adds per-object metadata should be included,
+ * since slab merging can update s->inuse that affects the metadata layout.
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE)
+		SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
diff --git a/mm/slub.c b/mm/slub.c
index 3fc3d2ca42e7..78f0087c8e48 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -977,6 +977,39 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 {
 	return false;
 }
+
+#endif
+
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+static bool obj_exts_in_object(struct kmem_cache *s)
+{
+	return s->flags & SLAB_OBJ_EXT_IN_OBJ;
+}
+
+static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
+{
+	unsigned int offset = get_info_end(s);
+
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
+		offset += sizeof(struct track) * 2;
+
+	if (slub_debug_orig_size(s))
+		offset += sizeof(unsigned long);
+
+	offset += kasan_metadata_size(s, false);
+
+	return offset;
+}
+#else
+static inline bool obj_exts_in_object(struct kmem_cache *s)
+{
+	return false;
+}
+
+static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1277,6 +1310,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
+	if (obj_exts_in_object(s))
+		off += sizeof(struct slabobj_ext);
+
 	if (off != size_from_object(s))
 		/* Beginning of the filler is the free pointer */
 		print_section(KERN_ERR, "Padding  ", p + off,
@@ -1446,7 +1482,10 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
  * 	A. Free pointer (if we cannot overwrite object on free)
  * 	B. Tracking data for SLAB_STORE_USER
  *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
- *	D. Padding to reach required alignment boundary or at minimum
+ *	D. KASAN alloc metadata (KASAN enabled)
+ *	E. struct slabobj_ext to store accounting metadata
+ *	   (SLAB_OBJ_EXT_IN_OBJ enabled)
+ *	F. Padding to reach required alignment boundary or at minimum
  * 		one word if debugging is on to be able to detect writes
  * 		before the word boundary.
  *
@@ -1474,6 +1513,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
+	if (obj_exts_in_object(s))
+		off += sizeof(struct slabobj_ext);
+
 	if (size_from_object(s) == off)
 		return 1;
 
@@ -2280,7 +2322,8 @@ static inline void free_slab_obj_exts(struct slab *slab)
 		return;
 	}
 
-	if (obj_exts_in_slab(slab->slab_cache, slab)) {
+	if (obj_exts_in_slab(slab->slab_cache, slab) ||
+			obj_exts_in_object(slab->slab_cache)) {
 		slab->obj_exts = 0;
 		return;
 	}
@@ -2326,6 +2369,23 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 			obj_exts |= MEMCG_DATA_OBJEXTS;
 		slab->obj_exts = obj_exts;
 		slab_set_stride(slab, sizeof(struct slabobj_ext));
+	} else if (obj_exts_in_object(s)) {
+		unsigned int offset = obj_exts_offset_in_object(s);
+
+		obj_exts = (unsigned long)slab_address(slab);
+		obj_exts += s->red_left_pad;
+		obj_exts += obj_exts_offset_in_object(s);
+
+		get_slab_obj_exts(obj_exts);
+		for_each_object(addr, s, slab_address(slab), slab->objects)
+			memset(kasan_reset_tag(addr) + offset, 0,
+			       sizeof(struct slabobj_ext));
+		put_slab_obj_exts(obj_exts);
+
+		if (IS_ENABLED(CONFIG_MEMCG))
+			obj_exts |= MEMCG_DATA_OBJEXTS;
+		slab->obj_exts = obj_exts;
+		slab_set_stride(slab, s->size);
 	}
 }
 
@@ -8023,6 +8083,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 {
 	slab_flags_t flags = s->flags;
 	unsigned int size = s->object_size;
+	unsigned int aligned_size;
 	unsigned int order;
 
 	/*
@@ -8132,7 +8193,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	 * offset 0. In order to align the objects we have to simply size
 	 * each object to conform to the alignment.
 	 */
-	size = ALIGN(size, s->align);
+	aligned_size = ALIGN(size, s->align);
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+	if (aligned_size - size >= sizeof(struct slabobj_ext))
+		s->flags |= SLAB_OBJ_EXT_IN_OBJ;
+#endif
+	size = aligned_size;
+
 	s->size = size;
 	s->reciprocal_size = reciprocal_value(size);
 	order = calculate_order(size);
-- 
2.43.0


