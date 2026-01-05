Return-Path: <cgroups+bounces-12912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB53CF24F1
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 676A9304B06E
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65C70808;
	Mon,  5 Jan 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a/ym72QP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F6sBFabt"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844232DAFDE;
	Mon,  5 Jan 2026 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600207; cv=fail; b=IlTGd6kU7vmfC9hpuwP+a6NIHUlIf2uT1UtWqXXK518Fav7fGVQly8KhGkl5kyOooj2l8KZhyop+otClgLcMYfKX3Dd85vCA6Gs3wCKnYIKWDJ0z/Wt0cvMcCbpDyCpikFjwe9+qtAGyZ7Y509Th7k6YmpDSg/+QGZHE3L/EScU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600207; c=relaxed/simple;
	bh=op4WBracsGJuEPD0pzkd1nH0iMYCIsp0rv+usq6ah2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDuvf5V3hsq5P8pIagpFlUsYF7y1K4w68BsKYjH61tCAujegt29QAlO4owkqOCKrDN3T7PW+IcxTy5vsDrvmHIM3bayemcdXri3wAmEen7c5k1uAARlkmtyhfpdexVIcZE2AcxpM7P1y6hyUArg16NzCWl0Kk4jbqIaF2a/p8Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a/ym72QP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F6sBFabt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604NoPXj269927;
	Mon, 5 Jan 2026 08:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=srD6y+rkSUYdJ7X1QMK/Blcv7CsghWbxQOAv+AF1V18=; b=
	a/ym72QPZrOsI/12e/1fRiTGUKj5fWrhnjjsn1ouqdfWEseA82TrQawmcre62k4T
	6j873v2Th0JGvLdqCqlOC1u+jVhdh9i3Cs06CGJVggWm4PxLufiJfhCre1WwioPu
	IWGt9fzc9Ljh1tjjs/2gcsbfpiTFX+Sp/MkoMKo22D9Ktu/zx0dibEYdwN5lywwT
	Te9oAD0Gmdqb4chszsXQvHuq/Ev+t4AiObH9qtTjdbWu9m+NmkMwrsA1vNJMhvzR
	rKsEaSkoG6xedu1EbVGI2XOEEH++3W6hIMdjOvlUxjhxpQwIGUzqa3yiW+FECuPq
	0BRBPtgQ7r4ioFaK7Jv40A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev1qsbfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:02:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6057MsL7026442;
	Mon, 5 Jan 2026 08:02:51 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj6ut4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdfrxVResC/0Q1pMVdGwvtqZfGpdau2SjFdbopalzJjwgnkAcVvkjamugy1H1IHv3vCeGjsvPW21cmi+L6WpbV2DkaUNStTAG/x70G9PwKOKP4cpUS4hL6EPVUxTIdWUYkJeeUXvLBjgUSOP1J9GdrGmT5Umsj5yINJ6uzGf6x7UUR8lC/f42A1MpEOkei9Qc6pQ29AD70/RCiTU6kVljTS8YHE5REPZhzDqEblo2c3fkLMbgbhTp3gcTlsyKbIcR5LlbmWsaPDHHLEsLsUrjLYonDbkvUu5EHEdiPYkbDIg3LuDePPYmuMebBIwImNBvmVIjHI3EIdtaNKuWaGHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srD6y+rkSUYdJ7X1QMK/Blcv7CsghWbxQOAv+AF1V18=;
 b=XNsfnsOa0HMWBkL2n7lSVnyuhDvo4yY6Xps02+69Di/oV9DkgGoN3suRADRi/kdJDriqRDTlFCnAlF80cJN0F8tkB8JOsbCMzfmIfodnA7ZR89jmcIlR3QQwzuqPHZVkj4bMOwIboklng4V7DLvpM7bUtv5iTLcNB+FwL9gAJ6mwerVgvwj87z3eWEGvFK/aAQdFtXYZu/drTLwsm3y5lAkF2qCcUI4NU3ttGnJZ6Zh7hIHqCZv31p4e3xo08Re7mjjc8rmDZjiIDUm7Cz446aXoUdmWxKogfj73X0qRWPcHBBYQW6AL4hSygOr8mah4FcxwqRc9Nug6NUF9fkLzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srD6y+rkSUYdJ7X1QMK/Blcv7CsghWbxQOAv+AF1V18=;
 b=F6sBFabt4Q3xIyFzybKpkDuzyGxvMtWGnS7vHs53BPSiiwrp61O0KIbmqQ66wCDMZKFm9SsZcgGiPYBIfV9uY9GTSxQ4dBRIi3wT0WQIFpP0GvXJSpbk5s0U54E3rka/j5yNcWfTdn/9yMDh/e/aWrQ1k2RnQwR02q0XkYzij5A=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:02:47 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:02:47 +0000
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
Subject: [PATCH V5 2/8] mm/slab: allow specifying free pointer offset when using constructor
Date: Mon,  5 Jan 2026 17:02:24 +0900
Message-ID: <20260105080230.13171-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0010.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 46463eb4-f647-45c0-6440-08de4c30d085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2QpXiu3Mtu3Uwb42volUqQ6YfaN8NPhrYfRV0VQz0D5ORYJffTy1Otfi+tnT?=
 =?us-ascii?Q?FuM3wFkgzt4Oe54uiaI7CGZo4cHy3OjHuyT26JBo0dI9DInZrbTp004B/Scm?=
 =?us-ascii?Q?3Q+4N4FkysBFQa1L0EwnRhdVngpv2sBlRcVePQhpDcfXLU0IcbyygdTvNiuV?=
 =?us-ascii?Q?rEOyWf9bDmBmiIPE5oHWDRk4qXTtAFfNnFlyyy4pWD4rR1uf0FiL4tz6/AN/?=
 =?us-ascii?Q?2BDICKHxyUtvSWwIfhG10+tj7o7qhBEn0MWYqbvPt+Dbibv7LFKLYcQ+3qQt?=
 =?us-ascii?Q?dPJb62psi67/Psky82Tnrs+err/bf3lIVIBdMaoqcjfqNKbfPeoE3sYmwYDP?=
 =?us-ascii?Q?dq9u6RURxN4KmBZItXmXT9uOPaZBr2dBFXoRF0J4zGJc5E3oRWhhi++jAuU4?=
 =?us-ascii?Q?gxN8PKUA5bNRsIdVCSYiJeqyMNDcCP5ymO932c9Q2pKMIhZWCgToD6CXn1/5?=
 =?us-ascii?Q?eE/enFUL9zLYPuFSyqV+xRhdhVO1dkzJP+HjWhmYPS+cebAwaIkUFZQm90bW?=
 =?us-ascii?Q?L3CUvqfSxLCj5M4F+BrhxAi1t6jn/wrOKwecKe1t46vZ1Xx7PmcnOeX4Z62u?=
 =?us-ascii?Q?XmfUwBeYCZSe8kTzfBYAodgE3r82/9RyDUfVZtPmsiYg4UyTPVbvk8cLaMcT?=
 =?us-ascii?Q?6vKkwG7LrUMp1VbUL0gHkw4JKmaV3OV+/9OimoGEj5XkhKPlHm9mbVOqXyFL?=
 =?us-ascii?Q?5hinPZdq+IoedNkrDJ/nUxLlA6rNwbVklzaI0ukRRLG9wng6R/sJKJ7vtOnU?=
 =?us-ascii?Q?E9SlnmheSkletfRhfuBkx/4dcLpqEcniymFgh6xCofARv2KnV0SbRx0iYzYU?=
 =?us-ascii?Q?5/NrOl3WPPfXO/5lYhuOEAltCECJXvybbk1HtLTga4nBjKcvp5tTx9EUWVUh?=
 =?us-ascii?Q?3XA+9XbBEbAnQsR5Mpi7eJtNihjdjbXep4FeYQPlgvMHx+xHGO5Hc0c0C6rz?=
 =?us-ascii?Q?DLuRqQjrg0WfZpzvA5Ld9WdlB0g60l8cLrHleXtdmHXFIvZO505WX0O0XQdm?=
 =?us-ascii?Q?k//iC2hVs/s78vt5xnpK8uQR4FN64P8pNpJF/ORA8Maj94ZShZmXQLUtDV7f?=
 =?us-ascii?Q?rZP8srX8POrN0Yc+r+u7rtjbjy+nFmF9HmZj+OlQkc7Q9aaunljdOSG3Q2qW?=
 =?us-ascii?Q?61c7o51atqG5t3GjZysl2h9XGo7Mn0Q4zebCArR8+VdVQbcmaAHKRdktNJKF?=
 =?us-ascii?Q?GLkVd527TzJUXlEW5ZU9dwZSsuhtx0tH00KPwsegpBtkHd6PUmJILj6QT/Ch?=
 =?us-ascii?Q?Wc37RjIV8EKDSyQ5Fj8/G293Q2X9HjcNpRaxxf3l4oTaS01whPxwmD77vuQ1?=
 =?us-ascii?Q?njUylGm/h2bRs6TW5b4ZytcJ3v4z1nM+qmAzeZ13wC/BxGq/ovdCOFxksYCN?=
 =?us-ascii?Q?WKoLy8r4eKPtNaoYhWKErIdD7SYrHyZH5GUOojjQxwGTReOFOcDFjTtlNcOl?=
 =?us-ascii?Q?tDnmRGfxhh5/b+noC/qpaI53gQmBDhU9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k1HrXyPv0fiTKpYEi1YwxpRwNcRfXEOlZXJAy4vTI8/mDV9ef5x+uGpd9bXL?=
 =?us-ascii?Q?5UlT+ou/uVIRlIgbXEHTaNIwicXBI1rJ32SuTMHjfc89cISo7kKSmFv1Vu5c?=
 =?us-ascii?Q?ZHESmK1Y1cnV4sRRKCpqtDAk0q4tyiFXMoANBDD7B1VwHGtvfzO3hp1P4BI6?=
 =?us-ascii?Q?7iEYpjB8Ukiwh7I63+VIVAGHjd+8zj81zzVDWvM3zFPBbcAtHrA9+EuOMYW/?=
 =?us-ascii?Q?AmKvs9qMTVue0kBsdimGvkOrHmmmdkOt1CMbcPNJekorISShXoExHt3haNPJ?=
 =?us-ascii?Q?+nYJZ/6wrpfFWqss1at3zZuzu/ind3nj4iID72QoMEMgl74CkF8m9ItfdcNT?=
 =?us-ascii?Q?FEE7kYYWTMOwrwswk9UJdFrYaXy9I6SRr8NqCGQKBsWRKUBJWLVJF84Jh0mp?=
 =?us-ascii?Q?4kN0MozHt6N9gbGhti8ZVD8zVgnD+v/KIw6cCWYgvsyzHKSnN4dLHffwYZgr?=
 =?us-ascii?Q?d4sE+1+Bc2cM/krlxuMuwvaUJuuJd7dQh3DqVawYV/wnTFFGpegSqQmtPzen?=
 =?us-ascii?Q?OAieMWqCa+E1vNJ8VeTt4Qw+UDNbM2OJmcj7gIBmib/XwIE8MR4/idgdRyMV?=
 =?us-ascii?Q?sQy9nMYvCOKRqYpQz5cgEpJ64FYHQWAcjjuJVCm0/rxeuZEcg8nZaVcDPfM4?=
 =?us-ascii?Q?iNBvLJ5GkmAjKtquH/ak3rGmM4JaFbiRo6fnDmWNLfEtDFZ47xuTAwDIpgia?=
 =?us-ascii?Q?CUE0VRuUa627iq2VcAS1zwCwBDlebMrMuM/t+yhgjRXfc3pU4pBSji6Rtkcr?=
 =?us-ascii?Q?0A1U+q9xnjT9TZf0PW2aAMeNfvchC/kVDJts6FU07GXEczSO9/iG/gFaWT7o?=
 =?us-ascii?Q?Z/8lgsXu4eiVG3C/Z2+VragpDC6hTd28djIWV6N41d57E7B/8WIVxp4KaLM7?=
 =?us-ascii?Q?t3jeCGWimGhm1v4I8pMSemzFI5RibKK1E08myP3iRrA1DmGiHCAW2A/zAi+v?=
 =?us-ascii?Q?j+ADndkV8KG7tLrd44leYwyV2s1HUkepz09c2XaWBf9zkWhIBDwE4UymDlNS?=
 =?us-ascii?Q?XY9NJgQSPOQoNHP3oxKq0gUsTAXMdbi4lrW8W7MCx1g+ynyiLqYaavwmFi6Q?=
 =?us-ascii?Q?pYGfiqek+UThBuQbRoRVQesQMZ/+/lhcx2o8p+VH2SW19AHBoKL/Yt3hp30p?=
 =?us-ascii?Q?MBKkMVgNFWZ0joQnjwZ1rLBVIHI1D5eIvM9jOMkDXapxF24C/yGfxVkubF2Y?=
 =?us-ascii?Q?1J7FOy/IwuAbDSCDidOm0vb73FSmMZIXqAbJeUpTZcgGTYcrMb1iPIeK2yb5?=
 =?us-ascii?Q?1tn4RvAtFxtDdNqjmZ8KVCzk9JzOMX8JMkV9bwSEhbdw5MgqYTfRPbQUY7oW?=
 =?us-ascii?Q?X9/Cu2vSjcM1QLcjR5eHC4ubGc26NjnT/uGk0gu98jaOGtys5CzxPWQP1Aw6?=
 =?us-ascii?Q?AHEMIbMFb8ssv0JzJAQFt+GzYKkE/5bcWinybdKK7I3zF7uMDOYaiSx2EcUq?=
 =?us-ascii?Q?7qT17zKtdLHhUZZWuBulhSHxcoVlnM1RlMi9THYI54XpPiFzFex+9eRIScpo?=
 =?us-ascii?Q?bEZbRdPzX8Q7hMbKcHKXz6tZDg4KrkfAHs0Pww/NJ+3u9G/5qag7qloRvPhE?=
 =?us-ascii?Q?vtbqGfNnLdm+evCGnSsfOhFZf+Lkv/x2ZeSLF1jhkPc/uycuK6IFp/DpPyF+?=
 =?us-ascii?Q?qfPbGSPqUh3truGI8BKDzJv3tIFnYuAJS7FanFA+RZwCkWTfYXMqKpnUeCjy?=
 =?us-ascii?Q?8HdNx+GNAncuSUEra4IM7jF3k/D3wpwzW4tiAyHAFj+OUG8LOJpSqXrk4axT?=
 =?us-ascii?Q?oDnKaCKthg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wq9uKiFMqvU81MVi/IX3jdcMTgQFxDbwWn6CjCjXcx7tBWLplkJOtbw85754E9u4oUGTBbT4jWuYoVktsNIcidh0Ey9l3yvTFJMMMYTrDAMZl5esvYnxUJdFO5sm6pwvZy3Yio+bIPVvzPM+t+BdFPAjojd7+zDhn+78sEPh9/8dIIRSGmri4GSvi1Jcf1u+ejjVSvNZzniDusGPxhDoI4qURi9UOSSVURqCj+dPy/vVGxNJA4acNChL6dOfbEIkeUOMMm6MBCmjYUdxIH92bUM9c7nQAvrHNqCYdks2Z0NtgudlaCV+PtNQev8o/FSvzqAQPf+VIK8WLKPAlhiwCYHWXmEwqPbF5pvX2jh6hBl+GRHbYr4pQ5OZmcoeIO6nZVTeMb4A/D8U8LrBTxDnHJpS0frPPZLbBMdSSqvuMT/GV5FstuygTOj2xegillUtL1817MdHP7UUVonpaAiOiHpWfr/J5qg72pq1D+KuFsL40WI9Z076ovtpXKLjI1u/1fFoVL4hLpCdEeAdcTJC5A7z955iSzHOq6JzVT2mQv8/K1ccbufHPSI7HCHMSbfVTNa5TgBGB06Fz0oIrXQb+r57aCRfp4TUauQfZqxhjdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46463eb4-f647-45c0-6440-08de4c30d085
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:02:47.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cjusem4cw/DlfGIutKRMbwVqGwN+rlBVYxpaSPYT5GUAFt1BlExm1cSOW2D/P9TQILgsFNz+SHrUN7hFac3JJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050071
X-Proofpoint-GUID: -ML8t6Kzj9RctkU4MJIWKHGFRZrBULGN
X-Authority-Analysis: v=2.4 cv=Ec7FgfmC c=1 sm=1 tr=0 ts=695b702c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=GMHoajJQQyXWUxyK3F0A:9
X-Proofpoint-ORIG-GUID: -ML8t6Kzj9RctkU4MJIWKHGFRZrBULGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MSBTYWx0ZWRfXwnx9O/ySXxVq
 j9Cmkq4KGN+s8Jp4DoVWnn00Wm8OS7z5Dm2zEufJBcniHHsPh+UGjmjmttGnt0bFlDbaPZ+N40f
 zziMRctKhmtFnqQUCDqimZ85weLiZ0o1nJ1QlELqCLm7yfc1Wp2MgzZPes3G9mYDhb1QTYkoxNy
 CgvVamPy8FVQtUb7Z+lFsw6iu/uYZUJ9KwDmlzZNBkYUELxQo5JlAOi+xKTsNHEQBpVWsxom3Zq
 VPPt8EQxL4zY8ik2Ma7oPyVOlJ8mQTzh18TC5ayyL/9+7tndDtnoXACXrQjU2S88zTdXUhl/BfT
 rhYbs8VwbQzXUhvjLMG5mrSD1TUs3SSieaT8o8CcIB0zR/HASGQ5EpIVOefUdWOpF97WyZQaPlS
 u3wyrA7gM6mT/U0QQVR9tnsuoQ7aLpIgXe1LPXsan/wkav0IpegJtVq8DlF9UKB2T8sZbwNB0km
 UwIR1458kNI/tmZfCVA==

When a slab cache has a constructor, the free pointer is placed after the
object because certain fields must not be overwritten even after the
object is freed.

However, some fields that the constructor does not initialize can safely
be overwritten after free. Allow specifying the free pointer offset within
the object, reducing the overall object size when some fields can be reused
for the free pointer.

Adjust the document accordingly.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/slab.h | 30 ++++++++++++++++--------------
 mm/slab_common.c     |  2 +-
 mm/slub.c            |  6 ++++--
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2482992248dc..4554c04a9bd7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -299,24 +299,26 @@ struct kmem_cache_args {
 	unsigned int usersize;
 	/**
 	 * @freeptr_offset: Custom offset for the free pointer
-	 * in &SLAB_TYPESAFE_BY_RCU caches
+	 * in caches with &SLAB_TYPESAFE_BY_RCU or @ctor
 	 *
-	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
-	 * outside of the object. This might cause the object to grow in size.
-	 * Cache creators that have a reason to avoid this can specify a custom
-	 * free pointer offset in their struct where the free pointer will be
-	 * placed.
+	 * By default, &SLAB_TYPESAFE_BY_RCU and @ctor caches place the free
+	 * pointer outside of the object. This might cause the object to grow
+	 * in size. Cache creators that have a reason to avoid this can specify
+	 * a custom free pointer offset in their data structure where the free
+	 * pointer will be placed.
 	 *
-	 * Note that placing the free pointer inside the object requires the
-	 * caller to ensure that no fields are invalidated that are required to
-	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
-	 * details).
+	 * For caches with &SLAB_TYPESAFE_BY_RCU, the caller must ensure that
+	 * the free pointer does not overlay fields required to guard against
+	 * object recycling (See &SLAB_TYPESAFE_BY_RCU for details).
 	 *
-	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
-	 * is specified, %use_freeptr_offset must be set %true.
+	 * For caches with @ctor, the caller must ensure that the free pointer
+	 * does not overlay fields initialized by the constructor.
+	 *
+	 * Currently, only caches with &SLAB_TYPESAFE_BY_RCU or @ctor
+	 * may specify @freeptr_offset.
 	 *
-	 * Note that @ctor currently isn't supported with custom free pointers
-	 * as a @ctor requires an external free pointer.
+	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
+	 * is specified, @use_freeptr_offset must be set %true.
 	 */
 	unsigned int freeptr_offset;
 	/**
diff --git a/mm/slab_common.c b/mm/slab_common.c
index eed7ea556cb1..c4cf9ed2ec92 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -231,7 +231,7 @@ static struct kmem_cache *create_cache(const char *name,
 	err = -EINVAL;
 	if (args->use_freeptr_offset &&
 	    (args->freeptr_offset >= object_size ||
-	     !(flags & SLAB_TYPESAFE_BY_RCU) ||
+	     (!(flags & SLAB_TYPESAFE_BY_RCU) && !args->ctor) ||
 	     !IS_ALIGNED(args->freeptr_offset, __alignof__(freeptr_t))))
 		goto out;
 
diff --git a/mm/slub.c b/mm/slub.c
index 1c747435a6ab..0e32f6420a8a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7907,7 +7907,8 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	s->inuse = size;
 
 	if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||
-	    (flags & SLAB_POISON) || s->ctor ||
+	    (flags & SLAB_POISON) ||
+	    (s->ctor && !args->use_freeptr_offset) ||
 	    ((flags & SLAB_RED_ZONE) &&
 	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
 		/*
@@ -7928,7 +7929,8 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		 */
 		s->offset = size;
 		size += sizeof(void *);
-	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_offset) {
+	} else if (((flags & SLAB_TYPESAFE_BY_RCU) || s->ctor) &&
+			args->use_freeptr_offset) {
 		s->offset = args->freeptr_offset;
 	} else {
 		/*
-- 
2.43.0


