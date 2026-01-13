Return-Path: <cgroups+bounces-13123-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D183D16CBC
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301523021FBC
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2336920C;
	Tue, 13 Jan 2026 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUu1B9U8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SFBbPq6S"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6483019DA;
	Tue, 13 Jan 2026 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285170; cv=fail; b=nZBpdEa+k6nr+5VAt1hKYluWozln9SyNbXTM5T43NAB4Z7yecvvO6lK7ymw4PyYlKErQGf2R82vc/4hdGM55txZNIyYfeOgWC7eraWGf26xy/5P9BEIY2AazVrHK5o1CfkzDu2L3keCAb1Pl8uUmULqgYpnqPWe5IpCB39PqUuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285170; c=relaxed/simple;
	bh=VonhcYAulPsGRd1LvRxM55eZBhAjVHqy2y0MPOQL6rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRCrBzkGp52BAtaXmSKByXF6bYg1On+vAV+2NWW+Xtlw8NXpUTwCPS45PimBgr0ioGd2FCHsi/2XIyEcMcYcqNbn3XuZKzZobn89ufbld9+q4gR060XdGgQFxr55VtY6FYi+sU8sa9AdGf0r6v+3IgJtPyssYl3LicWyG/E8LDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mUu1B9U8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SFBbPq6S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gJlA2753003;
	Tue, 13 Jan 2026 06:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RaXjqdEOlr6cU1Lo/3JplSCJcMzjoI3JhB3kN3dF6mk=; b=
	mUu1B9U8r/h8s9lw2Pi797dmV83o49sN2lsxBPyVtfxjnCrrcqc0UCXFNlCD27n1
	AeCIP27FmkjABkqKiqTqiB+twjvmBSALw9toXFucj0qaxQMztCeO8jiqsBUYWmKq
	XXeardELAtttXX8nQ+d1ePfP50VnDOAfvpp0X1bO/mshsb43g8q6O6IaxKpQzY9a
	O1lqx2uIJCLuoK9y/cJi7aDJ/7w6kdl6HP7hAbe43XA69ENyLYktTISW+VEpSBXe
	gIVIGBuVvCAaH7q4RskPCo3kwcNR/lum+90eeNIL0x7h4VZ/vsN2Unk00m0GaH9Q
	7JpIF0CVnMduUaI6Gxqupg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgjwn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5ddRW040448;
	Tue, 13 Jan 2026 06:19:00 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7c3rmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxCyGO0WZZ+qcbrOTcqTSt3skozKympXAAMJpxpWykmcW5LIqT8NFz7lGBCy23A9VzExEHjEKG0QtbdNyWJg1tMfxLDApTeVqrZlhMq5XRDRK0y1WNC9Z9lOfEDWh43bPumup9lx8WPzbh+gvFyjXHYEQXvUxIGZozDx0iIIGMJtv9FWRiaKYt4kIhq9P5an9TcvTVgOMLDbDopTsk4FZBi55YTrnTuH4i1WhKExK2+wk6siENvXEPIBFDBMmW5z3DwksZTa2QVND/5KrmvG/rBAEEqy89PAf2Bjt95+caZyZ7IwHoKmQFd9ACNd/oKU2rzmCCxnlanqDqB4ft+c/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaXjqdEOlr6cU1Lo/3JplSCJcMzjoI3JhB3kN3dF6mk=;
 b=IOBMEgI0ylQMMdT7AgG3vUzgxWnT8fu8RbZKiClkotMGn4rcCL6Z6e+DOXeMKbLDtQp6WJdmLvI634K9w3sNhAI0wnTvNI6D3XP+xKtGRng4VvyLSk8244Irvjv+eKTmGdfo9dYSmdZU30Nqa2+W4+PCsGW65Io/UUPi33fRW3CmL4nZePWU3WnCpBcrwmQuLMgblW0oUODYfDplD/HkPUYHLMRY0C1rxNLwaxMYAR0GRWn3vk4afvpVzrTsOTNGXkQ/8tk2jqk+7ttDWHeL75J24yWT13unBjWifZq80V8TPWe+1mY/Br5lKBuNl/Agm+zWB8NsWuUbYBb4nEfXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaXjqdEOlr6cU1Lo/3JplSCJcMzjoI3JhB3kN3dF6mk=;
 b=SFBbPq6SFtwfQ3cq8IbhWer0YzRl2BWyQ1+JbLKtBhA/tNbdU1HUhuVedi6XwLb1HMvItidXdfwTKAk//WzppXKWb/F58eQ4nBmLYp5Xtb0vDecD+tZm1AJFlcFBcOAxXYh1UzaRMjKwTM6l0xyAkujG0D74sqtdwN5JxIzFwtE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:18:56 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:18:56 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev, stable@vger.kernel.org
Subject: [PATCH V6 1/9] mm/slab: use unsigned long for orig_size to ensure proper metadata align
Date: Tue, 13 Jan 2026 15:18:37 +0900
Message-ID: <20260113061845.159790-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0028.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c840b2-bdac-4394-a345-08de526ba1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dfVfMfynWKUcnsM8t2b7ld8vqeTYz+o/nKX1PctoEEbbqg6E5aps83MHxotz?=
 =?us-ascii?Q?y9LucMCzmAcHpVf0pKHsgGopZhqeTwOuRl451k8iVElzU4imGbv8ULTbWLwC?=
 =?us-ascii?Q?K8fBUI9xOF7iHJP+lgruF3vKJhYLjZtWCAHb9qkuzRCiY/zWxrPDuLnvGmOb?=
 =?us-ascii?Q?rFg5nPez7BDdENaXhoS7qNCkCDHbUabBaRZpbVt0njOIm1+lLHhjtjdj0ItU?=
 =?us-ascii?Q?fUAspnM3X6St7eYq13tXVpEbWpwW86vtHr0bG/ir7HtxamZcHuuD7uQhHQpd?=
 =?us-ascii?Q?wqBBxdegLWnIrOD5cQgJI89AV1n5KVUXJsETVc/2/lDJRBRhtYPeVgPdmaBh?=
 =?us-ascii?Q?f+e4IuyWXemn+H1Hrl1aYG1C0BpQwUGY82ygbYODCjIZZ2PDLZHkK/sjTmWT?=
 =?us-ascii?Q?tk5ueydSqXe9CDZSFaMcJDp0mqQYio41Md4ea5dlFOcZynGy2BvyOifKUY76?=
 =?us-ascii?Q?rMlpiL2VBMUDPWWxkU3VLiA7Ifxf59G16YGaU4NjDef2dbXZmir1fEKvqFhu?=
 =?us-ascii?Q?18r4/b+HqwgSTGZ7zQamASqeMbBSI1kwEsrfgHjEZRexAkrhGRbg0nOQyR80?=
 =?us-ascii?Q?UQqJPZBiSQOy0H0uGlUfNPkW02Gqq/PvMvDkxcNWPVF5WWxQJOS0dupHGae2?=
 =?us-ascii?Q?LaXSjohxM3lYACmjqAR77HX/4kiwE5pmKTwM+bZ7uplNiNjYhaaFTd7rJcuE?=
 =?us-ascii?Q?tobfINOeMkL9mpQ85z/Cn7raro5q2pySbC/5LhVEKtVUamY/FANP+fO2Pm2/?=
 =?us-ascii?Q?1ycNYiG10NIKAzDm06jCpw7EufnlAJaarMovmwmpeui/9rS1t5NAvGY6opO9?=
 =?us-ascii?Q?M/gSGjzBv2SONYH8h+PcWpUqdCATFm3QJD80i2Om4AafBmFqW6Mt9/Vah2PX?=
 =?us-ascii?Q?hy6RLlhkYP+i7aCnKsAk46vMZHtd+0vYE7aZeImvUcn/EWSOWycjMoe0r5De?=
 =?us-ascii?Q?jikVbRCO5taIfn/pG4Q+6xsh8Gzn7MWmwrWwYVjXFJ0uq8B/9I5P0vzsTSh3?=
 =?us-ascii?Q?QcMcdL60zdUqQHUkyDYKurUufCWIaTipg1Lk4FggnHqwlSvaPv8wUPJXNwd3?=
 =?us-ascii?Q?5WSdKKhPBSxPyOcN1kCQHxNrRM4T+uUSSLuUD76ZnkDrvrpuCGCAH2mSFR0l?=
 =?us-ascii?Q?EoYeFkcWCk9Tf3+k02Q1Bx5BZoXQjLN5gM9yl3+frhQUajRrNoD0X4NjxqzR?=
 =?us-ascii?Q?LUUeoc009iWpEaEHfZaxkJANg8RRPO+D+1YTLTqY3LIFSzLHClDpJi4vZ+H0?=
 =?us-ascii?Q?zbhKJKqmH+ijFAxvqzt7DT4fv3uU/xcrlaE9bUsNAwblhmi92TBV+oZ1D57u?=
 =?us-ascii?Q?G9GpdDZ6iihoExiZ18JthEfJ2m5H28/8xC4c/2d1Fok3Mb+5s2lEqoKgdUCc?=
 =?us-ascii?Q?m01WIfA3jl3yHmgVpl0xgb08xb7tT9c5Fo+Um8lGWw7mzPqVTrICjxEWdRW0?=
 =?us-ascii?Q?LONp9c57LbfjCrGer1LM0+tlEkezERW59+7fjCbAFL64QWU11DQRFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zB0CJsr5iGcbf3w2c4OXmuCeaFZYxJrZ1tuMhnnolIOMtU06SyW1hikVr5HQ?=
 =?us-ascii?Q?djeBteVqx8KxTQHzUzM9jp3m/r3d5qE+0fQueLOyRvQcuv/g3HaAWP6J5IA0?=
 =?us-ascii?Q?FE4it2ehkmH7Af+dkjl+jsbNYQBFUgnT9HiY5wAaZQOXI4sVLYRO8xzIrkt5?=
 =?us-ascii?Q?u7mzJ9/uanwYf+qAWIyGOyFbi7okjoeJMZRZ9QvKHA8sq8wnfcWAc9Cp52Tu?=
 =?us-ascii?Q?93e0AM5EkIxUtb5iaraKtnnXfSrTffGrAqcqUnj5s/WgefnpoLoW5y61wF+c?=
 =?us-ascii?Q?Y3DkuMFgABNlOQY1jnu6U5f8hvvvA2VJ7KKb8w22F15P/0tehQ9xPhfjD05l?=
 =?us-ascii?Q?5434nLEq2pkIHHVEgVJWcfUEIeraFUE0XU2I01WXEJhURoMuguOwYBvl27U4?=
 =?us-ascii?Q?l0sYTDSYtqDYXOkh6nkgIu1fWdGAZPDVr2Qd/2tArrdDG1RvtNN1ot9pE7KP?=
 =?us-ascii?Q?VAhJYxwFhuzel7jkwK08WVLStVTs3FQ8aR5OWfT+lLwGRCNlzZ69AC4rvyFE?=
 =?us-ascii?Q?Hn1nEqt0JmolusrLeYj5MnSCdD9QbPsNUWzAVpWfHrSFoDoC5sAUkuN4TkfI?=
 =?us-ascii?Q?O40NOAO/xWRA1Qx6SE8YJfdphAQa4df6q3SnLbbYwwFMJyWJ/iB2znGeAv19?=
 =?us-ascii?Q?YqgBzU2tiUqS6vL9j0BuE3+j6Cugzv9SN35nqpOWZiVvzVylRZCGEjOOwFf2?=
 =?us-ascii?Q?WeH3nHyVarjYSEqIMIxZEksrqD0nPyqf+/JqDFDsKysi6aEWQHukLTL2WHy6?=
 =?us-ascii?Q?UVTqE6h/JR0ZR3cVflqa9tn5CEpOLfAIJ2tVGTaE+1miydig/x6GmMx+OrE/?=
 =?us-ascii?Q?6ortx0DdufX2Rjn1izhob/CeKuLbXc+eQrbgln/JIw1xiD/M6+g+hIvqzBHJ?=
 =?us-ascii?Q?Gu3RhyCriZNLlBmZ9C1ZXba5ZE81lO1cLxEwL4b3aEGGY65Qujr7FrxNkUHr?=
 =?us-ascii?Q?EhAIlWJu2XJ2+6gsFkP+GaHXkRmphOL2W0U0mAxsmxZuSMYgAC38dWuXLFtP?=
 =?us-ascii?Q?lGrvqrPLoY5V45PTA4tW55/VSMKloDkdk3nmZf9JKMpIxrgGggTa1gndbfzV?=
 =?us-ascii?Q?7yza2RwSKV5JEDCXnLKKPysWRYBcti1jkSeNI2Ozsp1RfMcs58JaIf6rLwcz?=
 =?us-ascii?Q?9EXhGT3wZsUUswoMvWj5FGKHsd4cvs04/DgYb+rcy5tO3EQLDWeYXwCUfst4?=
 =?us-ascii?Q?UziJYQwNaNKaJm0oaRqXvIf1ES+7ureYhIRJoTpXVDlRAFIbe+vyvYjdQBhf?=
 =?us-ascii?Q?lFhCTxUUKkXg7jK56s9ifGECgjFIVPSKhAGaztYH3Izeir/pev/wzoYZjYir?=
 =?us-ascii?Q?RzDMKik9BTPWUJKlUEcVZfuKakVw/ZUbk8Z7fUfKTRX+MESTc29OiEjmow1r?=
 =?us-ascii?Q?2B0RvmgdhjkDLLFJzgnMJwMWphZ6693eCupWIkCPfibrGoR3/sZRETKO404a?=
 =?us-ascii?Q?PG92SoByu/IdeIXqPw4oyG/lOaNEGQS0PTHhbf1BqQxFb6DcUAye6N6hrSW2?=
 =?us-ascii?Q?tuZJWWDZ5780EKRxGXkwic8fGhxDii8qpj1/ld1z75+1a/aNMOGovTRRS3CF?=
 =?us-ascii?Q?/n4PgMze41ObmS0MPd2VO0jgj7oYkBfyAMAJdwssVUw+1aGJ93CyzxCIfyKW?=
 =?us-ascii?Q?bKsgYmb1H/8mHmkw0BzJ8ksZdRA48zQj34Ukp6NYJ4ojhF8iO/Xgr+QMjFFt?=
 =?us-ascii?Q?syF/nOVSkedMcUvPYoy49eOyUTn0LolBTCGpgQ/x9JPsdrON9Cu7Dh+taW8R?=
 =?us-ascii?Q?OlGZrN9fPQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2tZaYLCuiFFyrSvQ4KrT6rdmHo2mKT2iZhr1pvREDu6ROCf8Ufc0GdAmCU3Kbu5hyjaxhb1xdSYBmX7HnZ4iEqHCHXz4QYA4vLy7Bhqz1H7MzQ6AOxSkKifA/1VneBzKLdmKmUFqvNTnJ7/51H0LN4JRTNyv1RQ+LngbwxlvAGYPM5hv2WdGBGCf6/PmQYDFJjyLs8IvDuW/ceI30xoV5aUZ+B6uMPcqRsaPRWrGm+MMS6LMSyO1NBmvpyYkNnws9JQP+YXvcBwtK+wZsslrIiYVGLHosZh8qr4bA2TsMAaF8fwNC9On78L4hjCuSxB1L3ePnAO/cCVEStO+IMYgFKN3im0R6AvXy6b50Zrh7qWG9MG5oBPgqS92dbw4NxWzPnS6hKDIcYmiQz2cMP7qPaDU791NrCN4cAj5WvLhnZoI8XsyfpPEYkvpEbP1ZNlXjL/wM/dI+soFaeKg451BgMld+i1zhWKzsszLaeKkqd3RqO2Xwo1I4jSPQ7MAq5r4wexp/JQjwpngDR9VScERcV/ewOsr+XOLmACxaUA4aDLhU1Q/g7dX40I1HnkuKtb+REVgRpNW5WbQtqK/IfvdIULwZsGOZUlkLSJpu9ioXTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c840b2-bdac-4394-a345-08de526ba1ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:18:56.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DvCOqlZPt5tKWTwmnueP7WqYL1d+F+iq+NSllO+GzI9bJ6PkWvUlzjMdWYr4HUkiFpyYjdnXpQ/C85vr6KSBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130050
X-Proofpoint-GUID: fL8HKPojHjGd8rlNA6rStAohEdNWiyev
X-Proofpoint-ORIG-GUID: fL8HKPojHjGd8rlNA6rStAohEdNWiyev
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=6965e3d5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=60bAUpEqyJ0hnt3RZ0MA:9 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfX4/4xNp4AsQ0l
 wopvg9CpqxzPY0eVHPMTYSNRz4Lj8L+dP9NtLhf4PGBGuAsSBPOlOVUV1MwcRHkHBX9svTdO5I9
 Zhuo711hkZ+HFhLRINOvuUp6ZZxpQqqMQ/oy4K0k7GppvwtVZX8aHuMjhsgDT19Wzo3twQqVRdZ
 SEq8TPzaloPBwSXF0koewu2/si085gcHMb8iorNCVce2bZK2i62mT15dgp8cqt+yR+S6NJSsyDT
 Jq/qBOoHdNGme2ouxXlOkevdpeYiTZKpnhgh0WZUYxtVOJQO9MSq7mf1DRFdF2dEvm6PitFTgWf
 qm4lr3vLonF2vv4vHXcl3v7M3TP35zrMa8Lih7Tbd40Kwi3P8nVRxJyO4SNOZSTBWPF3bG76upz
 jS6W0k73NjVjx+MJKUn4cnqHa2nqM1U4f+SmJUR3dEZ9oviI6ihelU6U5SXx5pqblVOZY9gfpgR
 JC0JHaFs4mD1uJWf0cfJGguvQ8/KQZkUGv7/S8S8=

When both KASAN and SLAB_STORE_USER are enabled, accesses to
struct kasan_alloc_meta fields can be misaligned on 64-bit architectures.
This occurs because orig_size is currently defined as unsigned int,
which only guarantees 4-byte alignment. When struct kasan_alloc_meta is
placed after orig_size, it may end up at a 4-byte boundary rather than
the required 8-byte boundary on 64-bit systems.

Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
are assumed to require 64-bit accesses to be 64-bit aligned.
See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
"ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.

Change orig_size from unsigned int to unsigned long to ensure proper
alignment for any subsequent metadata. This should not waste additional
memory because kmalloc objects are already aligned to at least
ARCH_KMALLOC_MINALIGN.

Closes: https://lore.kernel.org/all/aPrLF0OUK651M4dk@hyeyoo
Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 64d71a728d3d..2494ca8080f5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -857,7 +857,7 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
  * request size in the meta data area, for better debug and sanity check.
  */
 static inline void set_orig_size(struct kmem_cache *s,
-				void *object, unsigned int orig_size)
+				void *object, unsigned long orig_size)
 {
 	void *p = kasan_reset_tag(object);
 
@@ -867,10 +867,10 @@ static inline void set_orig_size(struct kmem_cache *s,
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-	*(unsigned int *)p = orig_size;
+	*(unsigned long *)p = orig_size;
 }
 
-static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
+static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
 {
 	void *p = kasan_reset_tag(object);
 
@@ -883,7 +883,7 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-	return *(unsigned int *)p;
+	return *(unsigned long *)p;
 }
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1198,7 +1198,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 	if (slub_debug_orig_size(s))
-		off += sizeof(unsigned int);
+		off += sizeof(unsigned long);
 
 	off += kasan_metadata_size(s, false);
 
@@ -1410,7 +1410,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 		if (s->flags & SLAB_KMALLOC)
-			off += sizeof(unsigned int);
+			off += sizeof(unsigned long);
 	}
 
 	off += kasan_metadata_size(s, false);
@@ -7961,7 +7961,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 
 		/* Save the original kmalloc request size */
 		if (flags & SLAB_KMALLOC)
-			size += sizeof(unsigned int);
+			size += sizeof(unsigned long);
 	}
 #endif
 
-- 
2.43.0


