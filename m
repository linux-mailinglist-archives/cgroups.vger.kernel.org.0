Return-Path: <cgroups+bounces-13280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD562D3071C
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 12:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8BA830060F9
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07044378D99;
	Fri, 16 Jan 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rg5xA87I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hwbeh23P"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AD313558;
	Fri, 16 Jan 2026 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563229; cv=fail; b=ZaQYHSW3hF0bp5vxDXLN4Fl8JlpwRvfh8tdvLmWloV317MT3iwQWOyUPfbUi57Wm1T/3E+kHEwNw17Egtfo71V8yK70zVJZVXSA6ZHdXvo/uGeCLbBOHb0K/6UQ+qXxjd9rwn1u3UUi4YGv0VnL45VqwJ0OcBfU09wxNvDtq6+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563229; c=relaxed/simple;
	bh=vXJAJW5TxLhdG5j+DeiiFXwkZlI15JOQf8iUNOxHSQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b09Gi/+EcvX8AgqjjRIz+PzhdiqX2y1AEkPVEKZPoxG0NbYJKmTsHvjRIXableRYigBp2ydS/IMbgykDRHQb/GVnjwBA1wq1yZRH3veaHUEcDYoKwdekqeCAWanpg9XWHT65z8SB9wgHzXHHHWH9BAJIC2/lRAJbsiMP1rfPeiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rg5xA87I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hwbeh23P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNDlr1909898;
	Fri, 16 Jan 2026 11:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EW4fj1uSv6y/ypxe4i
	KV2oxyDRUf6+FcxXmeplwFLNw=; b=rg5xA87IgLeswqPBGeCc8h1QboupHE7qti
	YI7BNAlxCLIOANHBpfx3LyiIfGEc1ZsGKbU8npn4h9uk93WhydjwFwSj7FlyjYOC
	Kuja2n2GvhHitXU5cNEzR7q3oZ/5U4exueiEGR5X8KDD7L8wMsRbJKjDyDPQAKRZ
	u4Hq8sW+e05Uq9UhhpZh1ERPV+/APIBJg58E04ZmIjLJrwK5sFhY6fju2QQYPSyt
	lbTKeIfm+zh1UuhOxvQzvKSipxy3zKyhVkCfbFDCkL7JtVzIsLNTmVSRmQaSmGji
	QFo5rtXxceY94Nsv+cTjN19S3z9dbe3k1Dlug8+jgtqxii6W8v7Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkh7nsxnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 11:32:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G9VxRC004143;
	Fri, 16 Jan 2026 11:32:02 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7pkb14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 11:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY/Z7k5gEDJsXG4tsuRK99XSDbzr5VByJKj+uJqRMJNY5fU4/rZIqWUPG+4jNgFDizYSVI/1yClqTS1b/VSvY06vggeR8r0AnTHzKqGvIEc8bXBOdSY1xokmB1R68tj8P7Fo2nZX53xbWJjNwKngIchDHQBNExF6sZIibEoRgSKOnRNJborugDqXIjpe4IP3nddqw9I7yjcUA4FRVUefuggQhm1GjruLiJKbbAkPDomx5mWUWjFcUwI6QHKFkbJBUVczYD07RUBKBJ8VoHDyccqUzptSTMZUvIT+DFeBPux1hdgntqHGO6Tblvneq5YgmAAw6IdJuwQ5gUVI+/9CWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW4fj1uSv6y/ypxe4iKV2oxyDRUf6+FcxXmeplwFLNw=;
 b=x+QoeW3uSoDLWmVfjAlA5KgSwZ607RH2EoIxo3c1paT5vnXntPRkTvy6NS0xyEoHsOzKa+WLnwPvd/NlAiSQtArrunToSJBIOVTkwGYJKI7KyYtyGiJQip2Bsu2QBTT6vPIrJIZk6npD02CYLstkOf+flUO8oTBpn0fKfUTpr4w7oPUi9iiKGevIUxVMtnTzVoYugoApkd40sbXHfn3vLewxVLhEb+4BPeSKXtK440BVGi/gEy0Dw+yg0+bZpXc4V3+YnHbq3cYRKTGjuhZCBuluVctWLVeNGbQkrdxRMI9U7LvBQyGQyzfvVyMu3dShj0T2WHn1ZigFtICQlNIiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW4fj1uSv6y/ypxe4iKV2oxyDRUf6+FcxXmeplwFLNw=;
 b=hwbeh23PMtWRF+dxzi89RQraG8sT/PgOjS2GxoJVrNZ7D89n0p08cDeCVU6XUvg1PMJkovf5v9c/JO0LI5U8ggech5pzC70PdfpRN2KjFQ7/QnJP0ncFxEobWA+3G04R4Au7vZRmv9W4Z0mNoetbBiaZaTL6TFA6doELZ4qBR4Q=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.7; Fri, 16 Jan
 2026 11:31:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 11:31:58 +0000
Date: Fri, 16 Jan 2026 20:31:45 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 05/30] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <aWohobzAyFlYfyHM@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <52b3d175b0860bbf728feaf16d832e022afd171b.1768389889.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52b3d175b0860bbf728feaf16d832e022afd171b.1768389889.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0087.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee189a9-4b00-45b7-4fc4-08de54f2dbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDbGOBGqp1vMFkdkg1njBi4BCQmqsovqFQ046qCIJqRPsmSUp4+AxBGgQOH0?=
 =?us-ascii?Q?FaYDP8eak+dgS7zqffMqmVqCtt6sfe7+JM1v06y9akITThAVkAoVFOwtJctf?=
 =?us-ascii?Q?aCHXSs0o0MdT9DRTKqcjGY7XvLv6ZlY+71ChgM/xC3FJX0hIuJrjT5dbeIJ0?=
 =?us-ascii?Q?KAyXGMLLvkq8G+dZCrYNXpeaxt2cyvV0b7vhQsZrAv2JRzVwbd/Dwg8mV4sL?=
 =?us-ascii?Q?346fkGYoaaIk5CRcGpuJo+HcdpbpROGpF7xDQRMHBfKENlZkltrnlQNcYp5D?=
 =?us-ascii?Q?xEYSxWDiFWqrb4JeGSqYh1eTuJOuYgiFb1p8x7a0ciN20LqxVJwq0S4kja2m?=
 =?us-ascii?Q?6NTHCov4m+m/AMxxk3+vGKPzldvsHpcoMf7ldjyQ57apMKv3fiUEFxCrbZG7?=
 =?us-ascii?Q?1a1T15arZua9dxZX/dbzGe+F3iSVHzR9wgxlmEjDilGQbaIQ55kU6NxKs6Yc?=
 =?us-ascii?Q?Rj/04UFHGyxb2ewP2pK/0C4axWxPBnUtbmVmUVOF3DXLWMDZL6LGOVPjGXtw?=
 =?us-ascii?Q?uxz7/DfMrXbI9cY8strFt1tGUNI9c+NLMHV6hN3l2XGlR0xri4H7VuqiBS8R?=
 =?us-ascii?Q?k2+pApzw/HBAn6P5KTaAQpT8guJgjSE4O51yqhxcl+oboX/8gJU/MttXeduc?=
 =?us-ascii?Q?DYznXZHEu06So7BHfYLMY1Rdti/a+DOsK4iYR7zWKw0Sox3djfa2CQDEUIOw?=
 =?us-ascii?Q?dLYOrGb7jYcor2CU30Qb8Lvv+u9yRf3wptjDaNXLkZYX7QJmDyRZVbDEHg/0?=
 =?us-ascii?Q?wC4VlE7gV6NnllgDzOgL9M3zXl9iDMs5EEVzY0BDdSVR9OJM4C9lb5JN+KMH?=
 =?us-ascii?Q?gW/10BDOr8S9mtmQbItPy5TWYPfVjWdxkStTHx9hKL3xTWBv9kPrvwtP8gT5?=
 =?us-ascii?Q?f0B9JRJGBXdVwHuOY56a417V6zNioKYVDaYz8f7XToYG7q9/d/To+uU1rWFa?=
 =?us-ascii?Q?CPzDQKV+1wgv8Yxy29w+xy1pWE2/gDbEG9zc0fIIkYP+Z4YWuLG3RkaMvPYg?=
 =?us-ascii?Q?C7QPvjWQG1q/qJp4rm2v8nVMHQykUa+U+Xh32cADey8MxDLODus3k1dvQNtd?=
 =?us-ascii?Q?S3yMHJk2wAdU9gsHplZWsjo4hmlr8oAVElCD8KT6RtvZfbnzSqC8JEXrXJ8I?=
 =?us-ascii?Q?qeQZ0gmaCFn+jKRJ/7zIOu1QDt2ebjjX2fZqsjviZNXt4gz58JisLd8Xs9fU?=
 =?us-ascii?Q?MK7jhr0nKpgBKCi0oXnromVSPPv3HPqz2Dw+5tnyMoSCCJOhcmxgE8OmDrre?=
 =?us-ascii?Q?HpEyvqVpz3ri2uJ5NMT0Kkm53dD8JTVURzgBL43XR36hYGwc+CMj4R49B8NO?=
 =?us-ascii?Q?vvvXwBKSt2+dmenw/WVa6EHYA9ab0qJpAKeP4T+Yn/i/nMPbuUCvUkfNHtgw?=
 =?us-ascii?Q?GyrxzXrC74sDpf4bpvOHbKmMDoKVr+kWVWCIq/UgSwf4QX55tdSzMpAVM8sd?=
 =?us-ascii?Q?QPaiA3lkSmV69ZlG+WvxwsjEDboWSVQUWKKM+EJEeaxZxrmYXhwdHKB1eEuc?=
 =?us-ascii?Q?D5oZlPkltz/WLVl+/86WRgJqffahTZS5CodJTkXMyJ07FxtrFpfdp/gAb6XZ?=
 =?us-ascii?Q?nqRinNw+mRmzfO18o4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5A20n3HdiNPD6Vw3p2aHx0OGz16A9tK66Qnfx17cEL0P1PkRQ6rAGqs4+tRy?=
 =?us-ascii?Q?q66LPqAuzZzeI9bii5Ha13MW8QKbtvDEpVhI0VGMR6ClQfdD8DlFnU8zrmK7?=
 =?us-ascii?Q?xhcLHZ2c2Ivw2vPp68VXruB+X3tIpDQHYgfRX+4uMh4Ye6gvci2kd6pY+1ja?=
 =?us-ascii?Q?7g2QVAlCK4u4BMtz+YolMUVHgxyIXYffbBi0qcTeY1nzlFuEl4Nrvi3BXH/I?=
 =?us-ascii?Q?pSyF2rhQp7a6opAaCS1+ROndr2zwYWCaK7h2N2lApg0kEBQfV4xjNgCFnugo?=
 =?us-ascii?Q?v+YQtA5iI3RugStDuNY+1sgG6McRzK7iZtqhaQ4bQG30NToqt8MSAYJq1x2t?=
 =?us-ascii?Q?CO56yGbbqEWSjEjm2JoFDEAbJZjyJg9FJXGqtZFN4XTbE9+D2TLeyKJQK9z1?=
 =?us-ascii?Q?Nt/NcBMePzx37IvoApb9d5DLUjrEdPVSFrCdJEEeiwdNGC81ZdoVaXlbPibi?=
 =?us-ascii?Q?br7UngbbuI+Ln5G8M+ZvGYqUzTui2rDnYAVbUJEqdJfK3BqdbMJIf+9xUqzc?=
 =?us-ascii?Q?P0y7JOd4p/jRYer+TD4CdDACFyj02Uv4bPjCCHZrt1+bkZq5zaGFefcraypd?=
 =?us-ascii?Q?LcZajBbYbqyevCoNxKe9j/EzpR8RIPXQGHbMUVNZQlzFI2aOGiO3dcksmNbx?=
 =?us-ascii?Q?BPTRfcmuWI17r8Lj//xggnOtRWCUkEkg7G5Gzd7C1egAdg5FxA1i3hZjq6TO?=
 =?us-ascii?Q?gF9V+/96KRYkFkm+9UMRe7CBjT/R5nRcQGWZ5VkxltGrYrRKXNt17ttMEu6P?=
 =?us-ascii?Q?a85sRX69UoTYl/SpjiHkhkGtbeEbsqmtOLoVA8B2YRO1K2iDhOKwFfSsrTPR?=
 =?us-ascii?Q?YAsBEA01a/aLsT1zEw6FoQ4S97A8u+U+9Myf+9mPFeZbhSp9XDDwAtK+Fx0T?=
 =?us-ascii?Q?6/2SbRE/fPf3XlrA2nb3lZzrQXIOlCrZys+CnrC7PSSyb8+E/ETZak50uB8f?=
 =?us-ascii?Q?ju2tYDLI9FZANJ7AYAgqyxSh8fF25laz8++KbbWRy7X9Q2aW4pp9yx/b/DBl?=
 =?us-ascii?Q?7dWxfAnCnQcN8o1EJqQwGbc08JyHmGiHxD3yxxO36m4zqESOGv0aV3okdCXW?=
 =?us-ascii?Q?ZaCERGWIFugFd68936wHypXhCMqnFhiB+QpylzQyValFIXQChqJ71L55nst+?=
 =?us-ascii?Q?N4+NhqMAyyxOCASRcdFx2M+A54fygTdKtUkTONIq6v8ElgylcIOanHIr4pqz?=
 =?us-ascii?Q?0aM5jpI9DLjVC8kil0+PHYfgsyLG+imqMUxG46B5dnh7iQLIOwXOH+BwtauH?=
 =?us-ascii?Q?9vAIZIxuQCjG5F6A6V1Ow8fC+4aBWTHXBKB4EKfAwwHfE7WCjqphizcMqzM0?=
 =?us-ascii?Q?fLtyaB7nuEyycTT8/8ACEgPX89Tkgsmw/wKBQzeYz/64tRA6PoxYNpiXnSy9?=
 =?us-ascii?Q?mUSWgVLqR87Wn7Re/z/Xhe33fMtiO5SgZln66jqWTmnn5vXFkbKU4yRU5NSr?=
 =?us-ascii?Q?2OPGwNKPNcFV82iTJUvo9lnXZXkvoDz8QUOyCENDJjXgY5VB0Xj7Yk92FiTq?=
 =?us-ascii?Q?0WJVWPrzI4CuVIye9eG0KAE2xno46qCcYEqSzx1j2J85J8JzmMptt97iI0Zg?=
 =?us-ascii?Q?ePtmLGWnz7UKLdXTX9Ax7BKUmImIAjB48R6zB1Lu4JuYclnR9TYv4EH3Kfa7?=
 =?us-ascii?Q?q4U9XOYocn9tpc/sQ4dQNrtOV1uhF0tnMYvRiU1qifd0P1ZNSNIF6m2D1fcL?=
 =?us-ascii?Q?gAXuXmjVGIp50mjm7K7npn5WzuivE4RXj1Axiam3OWzjMG4sXXNPw71kwGWi?=
 =?us-ascii?Q?PCi5sWnW3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x/81DS9OCI0Crxb1MuBESJQLASSzmMgdHseQf5ZULTIreOJ8iOt13bOwFC5igDz1JLkvo/BPtxS50pD1/v2qfTRSYILciBHf/OTtR5FVm3d/uZf0YbnhnMPaPSF2g6WkCoOCTqTTCk+74vVN7A+wzQl251Nq+Y/qDh9WFzVL0S4VDDBLmDlUi1Xiuj1wK1FdTJlJy5bs5elVK9MJTMyOl4RW/SWDjzGlmd/fmqNFEmQqTZsQB+4/M6+F4Wb/GB3yjoYwEHLBJCzkPtkWrmzUQyn9zDUuIaBh9Ngl9zR7fQcUOilla12oD0D5Y0GO+5uNtG/j8pqyhQItlfePT++VeFIfWHa34VoSMCnQawtHLkRbsQFWAhaVf1h2H7wqENFM0kUGlkhHfrkKzaOs0HJU/8I4FinIjuHm3jPR7gTwlcs/SLvyyWsQFvWNpLous7Wb1RjcnArCGT5oAp0JZFuz3FJOUcHKd7l0GjFyuQA1ojUidBSKUTLEVpC2YV8gMTfmttdsoYqq5MuXhpDHfedz8SjLQlnShoAzaWjDV6aZlhIbKqwOhRPSzYdwjobH6tKAHE2gHgB0hBPaSOsPbQ4UWwr69hhuTQg0aDMk4O8AXyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee189a9-4b00-45b7-4fc4-08de54f2dbd0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 11:31:58.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vel7SNnZI09rjKnnH4VzshzZOVj0rexAgQKLJlJcEGhDhjYnnn3hzM25mZcmGBNU84UAmvh5Ad19UdzYf9WRCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160082
X-Proofpoint-GUID: XunnZTyWUOkv-hnFlAGJ5oY0bK0ycg0h
X-Authority-Analysis: v=2.4 cv=X7Bf6WTe c=1 sm=1 tr=0 ts=696a21b2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=yPCof4ZbAAAA:8 a=nhqOxqdgvJc3YwsKq2EA:9
 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf
 awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA4MyBTYWx0ZWRfX9gNCiNNzxD+S
 638zAnQwCFndL6b5PEs4ze6JxWp6ePpxJhjN4gA4RGHkRFGqCaZPSWQpVLE4AuXuo4BrVQVkqZE
 TFBkgSL09LbBsbDmsKvEgqs4cq+r8mm0mPCesD72FUQnuIqfrTCgM6TN136/Fb2cIsb+qj4xq+Q
 5rJWDh0RiITCmyGIZJigr1KDI/zRZ+Qlfgnsh+th+RYVTeqdW876veL1qsVlZrDwrAZbobp1zJR
 JRSYQQs1dHzX4M9yiJUXLmVV/WeD8SEVW6MS4LUa2FdtLo8JGBC5Laxu2PZtmXS6sZ5a8SB7Dnv
 dcE+n2wjasODfAmt8E/ATmEBixZAqJxoWVjI49SeLjBCSpfX2KQDxbD6Xjo36LU9Fkbvr+/USNY
 C4/UyyT+iSV2npg4/vxhlcDi9U0Sd3W+U4SDAaDquH/ZXnXyI1MzRpufOdiQ+w+hOagrzclDUWA
 ejz1FgIGImkjXR8KfT7HMASml9WD2s8l33J0WFJ8=
X-Proofpoint-ORIG-GUID: XunnZTyWUOkv-hnFlAGJ5oY0bK0ycg0h

On Wed, Jan 14, 2026 at 07:26:48PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In a subsequent patch, we'll reparent the LRU folios. The folios that are
> moved to the appropriate LRU list can undergo reparenting during the
> move_folios_to_lru() process. Hence, it's incorrect for the caller to hold
> a lruvec lock. Instead, we should utilize the more general interface of
> folio_lruvec_relock_irq() to obtain the correct lruvec lock.
> 
> This patch involves only code refactoring and doesn't introduce any
> functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

