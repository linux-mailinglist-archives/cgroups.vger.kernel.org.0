Return-Path: <cgroups+bounces-13248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0AED2495A
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 13:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1493032979
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153B39903B;
	Thu, 15 Jan 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gmt913Yu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ass352NQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9602397AB6;
	Thu, 15 Jan 2026 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480877; cv=fail; b=FxdwZZ6MUhcduJdqIUo0E0iPIYMaKYFaw5dUfE1S7+pQ3BLAtY7BGCIuBLKgHfDkFasX1LXF1JbPeQhsZlzOKo94HkSEubVHo+R978nENbBXx8F/rBAnwZXGtSz5bi72vuOB2V9EuqrZWQThuCJyV1+18UfnnJtc1KZQKabRiag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480877; c=relaxed/simple;
	bh=r18wbKNw2zjLI/LOc26pZKXjFuBBN+Bp8LwNLRdY7Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TFD/N6ITNXvA1L8dhHB0AezyucWu5dOHbnP+5Bo96R2+PMq8gIkRpIkDbmml11d0rF4E/4snRPcGqnTc4NvLA0zvv7rj+WaCtZNwGb7oeVv/iLg5VAhtax4FAsTPOP5zpT2XVqJ50VkbY/9x1leq7dV5NGEIspi1UKvcXRSHp5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gmt913Yu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ass352NQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FBCqOn1360856;
	Thu, 15 Jan 2026 12:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pUd/kv2lcFFW2hHf48
	J3Lo4+hROUx93JtEH7K2pEXsY=; b=gmt913YuXBsLeQ+p67Fi8rHZRwKqDwMcus
	00oWPnCjxofVAF1cdOUQd2Xqw/U9cUqrzPuNOqV9MXuQUgmNGXV32Ar8GgcrehHq
	C/qFRNHdbZF1T1gqfCBns3ywDe2P23F/HUaKxRurn5VZ3KNntRKhSLKiTtGkrd/t
	w3VWrxZykLyaf3cB6JMo+DARJLrU6yHD2E/Z2FJ96dMED+lA2kAlsIL4qT0GFIOj
	u43IutOmfouK4bO0PkDIccl7nagwLASS+8SJie4ersLchnACPaq7vFiHeyXVtbVQ
	gtSvyXpjV7xKB5wCQN0brICQuJQ/i2uLClbKj20ylYB4mFLuw67w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp2wyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 12:40:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FCSr46004204;
	Thu, 15 Jan 2026 12:40:37 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7n335p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 12:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnO7avXc1KVZ/txHOYiQGu4joQ4R0uv9r4yK8BBD/1R3NsqCWzGZh3WQBAaFBcZLCt+5I3bANuxF4rMvaCMjZkYQyWRufu8+OF3GDoeQ18o51DXyJREhCExAI+IAQiWTyRjZCMxUUhQGzb2IP/9orT8CE2+ufDuiFp3niAhUvMKauAPtOSKbzcvub6uLzQZ/Wh3oHliPJZv/Oa1Ml+pc4cCjotO0JUOvcvdr7vIhSD6XXxAjSboCQhW6YaYTa9Rxj+6KNHVVJr3ZkcgzNS+i9anxSRBodw0plMlr2cPRtOb4OWtUuKBXOhBgSt49w/QU9JrLeX1EvQjsJxAIp4XliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUd/kv2lcFFW2hHf48J3Lo4+hROUx93JtEH7K2pEXsY=;
 b=lXd5NSZIcpgwmiaWq0ymxhIVNSyhkHZAjAEdz5qK3DtolU6p1QNfxh60rHiI7qtrqbCg2bI4XnrZrb5/HhilNstPN4GD7tXueTw8+fSabF0E7Y9XZnj87AiSdiowtJxizPJnOAPsbOlZd/etzaxmAWEf8KNN3KFH1bwK0LVJND/eEPgrsMhh4rtY2mHjwtqEcKNJoweFqa2z5Ul+RIkYqMLyZAau9dIVl538yfWZsCCQAJx06+p4VjaRhK+kKvw6s9KYLIzK1YXzKy/5mUALZsVcx9YVFVi0x11G3rZHkh97c8RtCgtlcj+Xk7jaIMjdIo2HFFLGnEAlRBgcEKmfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUd/kv2lcFFW2hHf48J3Lo4+hROUx93JtEH7K2pEXsY=;
 b=ass352NQ8zO+0TMljrGTzs2p04vQ0GF9+EhrWt7E9dRsRZ+457UdtDC7ZwAEybYf4pCUmSAPUq0xJ+AaqzGaXHPzPIhoZ3b/H796xhcoc2Yx1ptcQpuh1g4s8AZk89WBJMAtQBIPIq18sTMKHeipFN8pBSJ/s43Vwx5rU1ATEdY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA3PR10MB7072.namprd10.prod.outlook.com (2603:10b6:806:31d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 12:40:12 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 12:40:12 +0000
Date: Thu, 15 Jan 2026 12:40:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
        mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, ziy@nvidia.com,
        harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, hamzamahfooz@linux.microsoft.com,
        apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 00/30] Eliminate Dying Memory Cgroup
Message-ID: <0a5af01f-2bb3-4dbe-8d16-f1b56f016dee@lucifer.local>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
X-ClientProxiedBy: LO2P265CA0416.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA3PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: c74eb249-2bef-44eb-0df5-08de543339d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D5sYt2EyyTAWEaqbxhVbZysoauCFgM68OQYDAAlRbD3UWPcxocu4m8BPPIik?=
 =?us-ascii?Q?G+TKmbBSHjimJHeMwRjcgXa3irk66A6hMiRJO/8s5SUxh2AFtBMnTv40Ch/R?=
 =?us-ascii?Q?BhqJQ754zd9FsU4GQgX8nnzomAylOsRUWW7SaWjXuTi0a+acBHaCCwkOPGNM?=
 =?us-ascii?Q?AGF9Ds8+6zJ8LBC/8FJZ+ori2MaQOqNW9YJ9PjoEykE1bPN0fC9H/csKooY1?=
 =?us-ascii?Q?cON2Vx8aNssE3z7ob12DYlYJHWdB0Qk6xSE8qWKwiexiFvF7p4A1tYpbx1tK?=
 =?us-ascii?Q?4WEb88MF+ddtum2IGk8Aha/LIn6CIuBdJ+QDIaa9fxM6TFZHkn3YrXAbwCr5?=
 =?us-ascii?Q?UULl+6SfCBKqjICD6i9K07o46BIzCS16JwEmFXjOwXRBrY5fQjiAtJZoBsme?=
 =?us-ascii?Q?30tdp6MbyXmuY/Bru8aLBtNdtkgVouGhWT+3K4spPbDq8FPFc1f4Lxa296TB?=
 =?us-ascii?Q?3XWyHGedVNnm4m7dIKOanZOIIHTVYHup0DB2muIAvHu1bgOSbcWzLU8UrRLU?=
 =?us-ascii?Q?XBN+jQpq56s+ajvvVi51uaeE+REu83X0j03iclC4JcjjSWTDZL9350R79Kt3?=
 =?us-ascii?Q?RH/xnXUvb3iP9uX54/+nQfVtMLvDIZNi2DiiFcV8z3WydQS7/gqe8Ou8S0Sm?=
 =?us-ascii?Q?iPUvnWnW+RTtvZE70d0awShoG6DtoAECbbYndIRb5m2rwRzdZB9e6MTYlCKt?=
 =?us-ascii?Q?K4+HVUR78tsyksBjfjwpfNs6vAab/j99weyNxJg48hj2irEX8vAshUN1pS3s?=
 =?us-ascii?Q?hShjoR133AjltlEDbPhpYR8eMUYCwtW/J/3UNYC8iA2DxzQVp0Z24q8aBavL?=
 =?us-ascii?Q?VRO21IkBHrpLoYbE5eMJF2dZC7zPakRyxhYOn7vPDuOXSArbQ4nB3Si7/a1X?=
 =?us-ascii?Q?seSuQ5gYxi41HRPM980/lryQLSclIw1enSLP9HDx5oRrrDvo3FkrQz4q1nC5?=
 =?us-ascii?Q?W2E/a0Ya51IUXva/VEFeSNTvFoeqGVrrcwjiU9SwfQNBOKJZNN+ArponOV/2?=
 =?us-ascii?Q?8nR68pgpG72kS84oWv9g8jUZY3cwFmd2KiQsHyAFUbxMjdBrJRWH1Icpgp/8?=
 =?us-ascii?Q?fVyB2o7oN63UyKgSxhqTZVTafKIwUCGKFI/jQ2vPXFnolacNZyL7zuiaq7Rh?=
 =?us-ascii?Q?Kd2+Mr66tBdjqOeCcW3FwNjK33fcq4AGGUuvlWJ3pkemLAJxkqcUzfv9KQLX?=
 =?us-ascii?Q?OWO6yUuOMq4EdhtHP9ugUsfJJ84S2iqt4tne6oMx5UzJnyYXEFN8voReOq44?=
 =?us-ascii?Q?/EORXb2NHbQAYdj6vhsCx+Or1zn+Aoxw/ssri7+ZFCDLNUXnQHDMiiXiJuXG?=
 =?us-ascii?Q?tmfZ9XkPgKmyc78tNG31aT0xY4BbazrKxIyMhHzqHZnJT2vwcZnOScVdIJMu?=
 =?us-ascii?Q?tz+DT++8P+jnLf5BZP6KPRx3kgBzQrlVSSf+hQN6I4ACZpIoxZnhm2zla+SX?=
 =?us-ascii?Q?9Cnk81Afxy3z6huhKcEkirFVLJ1otZI+31S57aFesY4pyFk+A9+TKQEHfCWM?=
 =?us-ascii?Q?H28+OvnAJvGo7nATT3kj1nw5/mKDKzQ5u2kkur8YIPN9u9tHeCQS8lQrBDoK?=
 =?us-ascii?Q?ZA48SO3KJu1zMybCThM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VFCAFNkJux8lSpBNgytwGVX+OTkXmc/D58pewfAEShRKATBt+I13Kk4tw6GV?=
 =?us-ascii?Q?CzW/ZaSIlKBwNaUhW7v2xnEkcA8oB4TQ3hkRxL5rqpTJYNJbnYOpWVdHEPAr?=
 =?us-ascii?Q?nW6K0Vtm20T4WNjdZbLS4uJkJY9ahfoL9nt2/P9EAayZpTBFVLdAWDlGad2Q?=
 =?us-ascii?Q?VBjqQUOid5MDlLi96Ko9jDeNh11tzsnGbEgqt5fO1cdmwOUGu1WybTvDk477?=
 =?us-ascii?Q?dLT5+cndFZfI0t/g1VGEU+7aOzJTDit+C12dMz3MJV6OuQ6jFeJYi9VZCTFk?=
 =?us-ascii?Q?veZSs/6gSfCOz+BX9kasV0CwBHpimH3+SjiweEXIGWo+qA5FKR9zeE/kr0Be?=
 =?us-ascii?Q?C+WBuNTGgAlN0sVljRgEgelaeDLkoEeU/w1bdlu8GMO9mWrS3uRnoa3sHC3C?=
 =?us-ascii?Q?/CwK0y0WymAI89HpuUhP2Lcn7fz1tj49sOqKNLS974sPj2WSRZK6+1T8Pr36?=
 =?us-ascii?Q?QghSA8NvcSlc90NnOnTiKruMVk5N2P6eeMUXTE5d6M0vfm8SuPfv620J2QcY?=
 =?us-ascii?Q?jb6ArCz0Yfap+8Rza1i5OghE+d9Jgn6WOew86edmy2jjYY94qwLsW7yjJIit?=
 =?us-ascii?Q?xSfqhoTiPyrrGVPYocSY/Sk4thx+YlFeCIDdo93McYZ4sOdnOzIVnSs744Ra?=
 =?us-ascii?Q?bH0GzL1LWH+48CtSZiBYCUR4NV93w44wVfbnRLVp46d+F4NalUOwGbkMN83m?=
 =?us-ascii?Q?4k4DigY3ss4U0Edq6TxIPQeUJqDAwvN0WaC1FqiMnOPXZxIYU/9m0+Wzr2SQ?=
 =?us-ascii?Q?yVVgpArFZpxmFwQCHg5OrmH49fjpZneyfkam2oRU6veRHnwJlmdnk7zZa0uT?=
 =?us-ascii?Q?iMHucGcsV8MKt2ZO5SgwjdaZ58t6uLqI7uYt71L/z00RGA/S4KFcUWbQPW43?=
 =?us-ascii?Q?l8IqMj6gLczrdZPyoOiBoM0H35v/7xZyWk4CezGfcAeDohFrzvBrd7IuTyFI?=
 =?us-ascii?Q?Itgw6RZHinhiXzfTwIld9wvM7JxUw+UatzvAxB8aAeoAlMSbT/B/vKDpAhrw?=
 =?us-ascii?Q?3t35X5DxWxDkFmaf7QYR/NpABxOOonBWIj1T6WVFYuGgX7rbOCVL9WA8VgCe?=
 =?us-ascii?Q?uyZWKXbbD+rHxZnl3yMrCZ/wk3irmFFDW0pPLKoco0F0uwICQ4MZUBe+W0UB?=
 =?us-ascii?Q?/FHTwZh/w0Iu6AIW4xgrtq/YvVLrfCOzW5HY9Z0aBe8IWvYLyzojAOADJhwl?=
 =?us-ascii?Q?RpVtCxkXDbrY79YBkDi1Uo5WEbkrNea7qvrhAUwVL9tg5430Ci63ZrcTcIX1?=
 =?us-ascii?Q?8VZhL+6ycwYGxcKlGYoN/CNSd96Zp+e0xwp7lGV74TpYqXc3PUIei6LIsYiA?=
 =?us-ascii?Q?CBPJzb4vZ56OzSeIP2Ggk03n+/nmxXRDD84hpm6N5H28qMSme9ZnBtv+dcIF?=
 =?us-ascii?Q?JX5re8KUwQGpxkV89eh5dRufheJfB3wq3vlgYPwbRCg78PDlvHKSbzCuKNRc?=
 =?us-ascii?Q?l791SVA8kR0UQFlulpVqiqdkBAv3CwFLLjq5kiuS6URxzYRwqcsYGVfdNBSb?=
 =?us-ascii?Q?1cB97D6YiyOVryLrffBlDwzKYGfs2UMlT+hnexOoBC96X6LvF56YrLdKdZ+q?=
 =?us-ascii?Q?v1/m1H/Gq+nS6pyzOqG5lY6EwpGSB4gG+exLP7OpwH1KvRYgJWWTh+V71H51?=
 =?us-ascii?Q?rYOVAeToyFss9gvETTybbKYv2v93ilq30+yjxPEmOlfjEC1YoLPW4SK7TcfU?=
 =?us-ascii?Q?BZVQUGFtdj6mSiYvAScZEHyxi8/DGJ8DEFA2wK1u/Z1+sjwvS1f2FAXDoDVL?=
 =?us-ascii?Q?pyxcQPCR6x/a7sPlDrgGq9kLUdGfmjQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z2xd4yJmSNLaCg1pLVx+Ra5k0j8qqUTGrzWZQxsLW+Um3KLF25eYkd2CpNqgHtj7Sn+JEfOZR0zHmjgC0OjWVLWPN1Tj5qiHuAlDQrrniDWSa8+WO3a4Ui+RwMz4UUaCAvkhocBadlWEWX6wrRlBOkZO5TIImzjAI/OOvsppaNf6g4TJythzM32DwVy4U2Jc3PXWeZN0aqN2lqQUN6R14X7U1mV5VddN2cauCOqO6/H/eGHbQZBUGWquBycWk0UQohj6OXx6mK3ObXE+4kgeKvJNOQPFfHcYEXdbFTdPFO+m5J+afe8Yqduruidd6MoaCUcwpqXW47435u+bsuug0Fkggl4JhWgaJuyaetUT9XNm29AnjsZidlBBsPuyWYDxAikPN7i7DSLXGraAEISDfa5PVhlpNm8NfDZeRWNN57wCBRUfaMrNDeBMNvjkH1o1GS6t4z85mftb/DpXCzScxNuLsqaYBOZ8KEH6I1N9jC95qZ7XJ+w1DvBXiTfbzuIPITtAYVLv73C/i6WCUExWbdKY5MZf6nH1lQS04sSc7NhsnaBz1Eaxsn1aZXwPgB1uN9r7YW/rbwCVs8CbSi+XUWmuaqGhcLd2AIrmTJI/0cs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74eb249-2bef-44eb-0df5-08de543339d4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:40:12.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oGFgk0uv3UzluU00Lszip5JObIfkK9vnYyIEPhWlLbtnSrqqFl1GY9YEbgJXuQXfz/LFUozZTJXrv3ob5JT5YhramxtAdk+MvtfI6hHgHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_04,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=977 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601150094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA5MyBTYWx0ZWRfX6heAYc3adYHA
 hIpjT0tD51NFrJWHqtovQaj/8nqAHtnhJ6RpluaDm+pUgx6cD9WrC/8XDtyn0+u/zUq7O0J8xeq
 lbWusn2i9Z9kPGITa1Of6uPOwSYfWn8bBdB16DOV7WgNJ39M24d36EsXZHLCrA4mYC5Asd0W3S4
 gyGGqyynzoC67RKpvtKtWzgbl15SdiVDP5+Clw8C8RO3/ufhlbCbbcipCF+7dYPrseHTeyJJvCP
 mCdNJ+E8qDh9QSJUzPveELAm8uO4GrFJ4ZFtIxWWyov2DAGoIhA+d5qI+T8cI0qeCQT9QLQZRlp
 jCSYHBMP8WE3PiuZkBSifrJHth2cSPxuS7sp6tMCoEDCYP3Cfxn5xcz5dhuLZ/oylydggRFhbcZ
 vzB56xVDGHnKvxlB/lNAlyeomJNbR1ZjMfMvU6Y1AvsmwCh9pO1Sw+pAezSdbzxSnLFyE2kTqll
 rS1fIbV6zT71D6lQ0orBlkUFj1j0u6wBfh0xunKc=
X-Proofpoint-GUID: iI2qt7iYxPODI0ijr_STkYTRpZ2TRUVT
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=6968e046 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7Etcu_kTKpxH_ZaVkjYA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10 cc=ntf
 awl=host:12110
X-Proofpoint-ORIG-GUID: iI2qt7iYxPODI0ijr_STkYTRpZ2TRUVT

On Wed, Jan 14, 2026 at 09:58:39AM -0800, Andrew Morton wrote:
> On Wed, 14 Jan 2026 19:26:43 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
>
> > This patchset is intended to transfer the LRU pages to the object cgroup
> > without holding a reference to the original memory cgroup in order to
> > address the issue of the dying memory cgroup.
>
> Thanks.  I'll add this to mm.git for testing.  A patchset of this
> magnitude at -rc5 is a little ambitious, but Linus is giving us an rc8
> so let's see.
>
> I'll suppress the usual added-to-mm email spray.

Since this is so large and we are late on in the cycle can I in this case
can I explicitly ask for at least 1 sub-M tag on each commit before
queueing for Linus please?

We are seeing kernel bot reports here so let's obviously stabilise this for
a while also.

Thanks, Lorenzo

