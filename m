Return-Path: <cgroups+bounces-12110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C3C72EAD
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 09:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FF304EC202
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08E3128A7;
	Thu, 20 Nov 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NMSWJrmb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XrFlsXRx"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999883126C5;
	Thu, 20 Nov 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627257; cv=fail; b=ekfl0EQOvOqaHqJ3UDtSQISVZ6Ln7JdtTbZna2+ggdCt8/Dx+2+CTetnW+65Xg0+tHcjD5zOdyUcyuyacDtBrw2WEwQw3fN1kG9wKE4JgTGeNx+Bem8pQmLUM3vLP4mRhDJ12bEpf7xhhcNu1SOZO+NkBB4Z3F+tBE6nM7WiM1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627257; c=relaxed/simple;
	bh=r2zvrbtWGZFbgM8W5PkKH03vdv7JwTkhSRrYc3rOX7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3s72MTQAk3ORDAOZnlxNAZ+bPqWkR2qQJRrJEMsEkZvBgooJsUNv9yV7vhZ/6JpqopMsymzBYQJguMoV8vgZ+dUumV791HSW3Iws1Ukz2dkE1V4WGgIkGTqbX7Wj/bi/Bdi2zX7bGLALd1fybd0dQm5AUr7umkqDOqrOWY8XYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NMSWJrmb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XrFlsXRx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK7JxMK000320;
	Thu, 20 Nov 2025 08:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=w30oX5Fy2SnFWQBsDT
	RLt7Q/3MQgz1/wXPvbi4xRf5g=; b=NMSWJrmbrtSiSyiGe9vwmA1bvKI8mdd2Mi
	5P9IuSlBHCFQ0gnQwP0pSFGGT3WMjgPxROGpt6YNV8fZhaoCPcqPf22miTxqhoOj
	wMlS8oXr617s7w6H7KQwWbFjpxwJagJU4761X9/pgN+tKnw3qsRahulJn5eXyhnt
	4qiZbXWrzx2JLanfX3iqoGjwB9RfzlZw4bXE+5td7jkYn8M2+r1TxuaFu5PDNs7s
	/LiKibTuVz2ERNeVz6UwiT1xtqWJp3mIJieluRFEKjrfZQa5HGI20NnzhTRlVUts
	3/wI+NFFZrcnk4l/Q/rMOcHlHFfgJ5RxwH9gXO5SGlbuKP4FpJjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej908psw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:26:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK8ETBM007201;
	Thu, 20 Nov 2025 08:26:54 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybrgqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTVVKLtpAzNTahb2V+JWSkQxrGQSFIv9bphuCRrte6OMSQB6EixaIai3/3qosDoIbVMYlpgu9L5n5RmMGiR1U/59qHyMfeoYxD8X749R7uaCQlPG7d3O1re1mej4M5ifPqogN6YlNy77oaK4vkTdNcK+3EnKVsFerjPQONzlKdRecH1vHrp2Q2gITyAOGiajOaxouVFTwXZcvEb5D3Mx3C98njdGuTa9o+Au+vN50DXLqHuzq0D5qQ+uk9V6ioF3jrlJ+JToyQkyKPCujfv0wHBIyNmiOzv0Ii/3F3wspl3nmQz7iR9ZjqQn1/fNbvJ53qL9mwpJJW6NkSX56d+ZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w30oX5Fy2SnFWQBsDTRLt7Q/3MQgz1/wXPvbi4xRf5g=;
 b=br6r8a3A1NkZwHKqVFETQnCpC/4ypWrkSIb0tDOxOSy1yjOu/jupSKsvEa0uvNXazXSpFsSnq8O2TCBfkrzheabNXJKGOH1NCgb6y8ww1zE9ZVmj7qEVhJ+ZeYR/LappcynMlnUHw/0gXUstcwl3FbqL9WP45asgKOfHyUIL5GNwqpK7R3YerT3PKRGxsdGe+7UelttyBN4u+ZGxlXpLbmyAtHCnL+1CPXm49SOkcHVx6bsVe40cZFUdzJ6QFuSVEG9mw5hG7xg/vpmPth9GLGM1QRxtcrXW49XgbYpmbMBT9DGf5Uv2pcX/sa1pMThHeyUUK7cO/L8GQ/pbFH2lCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w30oX5Fy2SnFWQBsDTRLt7Q/3MQgz1/wXPvbi4xRf5g=;
 b=XrFlsXRxpYx9EHSWUGiIiFeIIYEJvkdFwxth3wXRejo0McELnoyRwDRjNycWpXp+SyHzDIVtToFzLlyTxeX0gh3CXg7tDKM1zEtdelFa3gU34cAhGpdh5StpBuX8//5w/h3YR/AC3w/ExOVKm9GDiief1NQK/n7sI4mQnbkTPE4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ5PPFEBE40EC96.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:26:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 08:26:51 +0000
Date: Thu, 20 Nov 2025 17:26:40 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 15/26] mm: workingset: prevent memory cgroup release
 in lru_gen_eviction()
Message-ID: <aR7Qqyr_vVmDrzjp@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <847c35eb649fde525eecde97fcee3d01708b7b3a.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847c35eb649fde525eecde97fcee3d01708b7b3a.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SE2P216CA0079.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ5PPFEBE40EC96:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8e6b24-81e6-464c-acb5-08de280e8de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JApFovuNDYTih6tP0oHwVSt8DPTpanMOZxE4yDv9jNBlz7d6yz4S3WleQan5?=
 =?us-ascii?Q?yWW4DmvpdUkV6OeIzb8HctPe7hJJuMh6aQM7pQaJ+8qe5+cyVwHRN3GCeo+8?=
 =?us-ascii?Q?XEjRZ1bu1E07podsQ83TMfR+AtpfTUtvm0+HkzbnijuEj3hEKL5O90UQFDvq?=
 =?us-ascii?Q?KE7VeB7t32I/sDD/2hY/rR5DnjoavjlfvbeT4Sgd9SNGYCAPA9x+3cDUQQHZ?=
 =?us-ascii?Q?XJ9HCwh00IaxfgQ1KwW5DUVvqLYG/L7TXZ2lJLnjxVoYae+AOlKGB1gMuHKv?=
 =?us-ascii?Q?usJ0zr9W+aGH0AgL3bFpkAUBwVMBAqBIFSAN8+AWh30/KsbOJlSLEYzC2+D1?=
 =?us-ascii?Q?M1i6teNybe+G6k42jyhJyilohJ3S5AR0+xntd5b+lWkbe73AUDPS6WRY2qje?=
 =?us-ascii?Q?EEgC5N+ZPUQ4RwTL51nX9pvaWzJB2FYn+ZgOunxBpMmBMp33uhy07luNjxzj?=
 =?us-ascii?Q?p5tobN8pHuMfrUpRJPgSaBrfdDCjyTnafyLX4ameBy6niMgRvaFD67h9Cge8?=
 =?us-ascii?Q?YP91WcRXLLRwht0piH4dyOWEJpHvDwCrfGVbj8fmhkoydE0WR1BVB8V4IW6O?=
 =?us-ascii?Q?kzf0jkZnZ+4GGU97nY8CwkNA1jyHgTt9YM/vzLCtcyRAl+L32hxA+4HLXMGz?=
 =?us-ascii?Q?Q03ZfOLqSrcG5xRh9Tw+yI3SpvJ1KSLEu6k4dunIYxMlQhYtPlvQpW+awhdf?=
 =?us-ascii?Q?aefBoxhdXN9NLaRAjHK3Fvbps0CMwfmdxyDRQBgsjpXU6fTD04fBI1xGifxa?=
 =?us-ascii?Q?ag5yWu4V1qdxCkYH76ChLUWJFw99AdbSOtXWf8s1L5u1MdgY0x//iEUuaUuA?=
 =?us-ascii?Q?fFy2yIEC/X7+0LKhafRNG2t7EOLDkGQi4VoLrWk9rORPT08rkaIaoN+Sf0nw?=
 =?us-ascii?Q?7a+2DcAhXIub1SSMZjUR+jqeG+unjkK+KBWgLM25SxorWCYgndQ//tliYx/U?=
 =?us-ascii?Q?qIkqvwKutEnDhshXfzLVrsARWm4BjjDXS3CzK5EP1u20kQXmtVY6qRVTXpvM?=
 =?us-ascii?Q?kRFtlE2PFRlZ9zmZk62mGpe5qTzlv0rm3hV23myY8xyhgPoSi2aKuWvWXnne?=
 =?us-ascii?Q?dxBY9KjclVyFm+RddT4UJeg+Lgf0yh6ueQiICtBlqIwqmQPGjJSMr/XYDWpA?=
 =?us-ascii?Q?915cuTW0s3fJ9sjxv9UddVk7D2G+JXS/vwYnG+k+mQA2MDtI3KjneK7TdZHi?=
 =?us-ascii?Q?jacS1wDu6OK/Di/f5JI0t4OcbAXGNrLdZyhixLmaLgZnjAkSHLbPjuHKhAn9?=
 =?us-ascii?Q?cdHE9vp/wyzo9bs82uygofaC4WKdNmgI03T1BJbZbcBe2DREGvQ0Oac2lwBR?=
 =?us-ascii?Q?UCIexaZpl2pwzIg9FltPCPHNq1UmK0Bod0+9fywayOOsLlGWF0A/nPDhnGdm?=
 =?us-ascii?Q?R1r4J/t1mRZ5A/SaQWxM4p9tbEl9Rxcl33dhLYBwaXU0Cs2x/k49p6aLfxyU?=
 =?us-ascii?Q?MJ1QhL0R24DLHUq5r//cX8ParyBAhraL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cy3MzNzJQ0Led6WhMxoBbMw4pmgjO6QBTzUadTc3Ou8PukDnatzVXJ+XR4xR?=
 =?us-ascii?Q?qtgqC9aVhCSGOp0caE6suEM8Kz7KkFSHgPVyd5m4goGmtfNEfb8iP3hHvUd8?=
 =?us-ascii?Q?pspO7LUC/9WpDLBlGFsHdcKqtmvXJwtuhYkeLrVrfzncgtRKpe+UFeVshXrU?=
 =?us-ascii?Q?sApuDGxlIxDvYCAkjfevGmpZJnvEivJhQFecaBDeSoDOW/3AHi+XitKAd4UN?=
 =?us-ascii?Q?KFs1+O2mvlpNih5pszBeOSaNQ9k00z7pmAfl4P4QLylwIdb92/W056K3bcMd?=
 =?us-ascii?Q?yrRmziQiERNnUpGkqwOLsJi4kBAz4e3CQgbNK35qED7MLJm/5sd3Z1kyB1eC?=
 =?us-ascii?Q?kPZl/nKI6CZeSmN/MvS2i2alvBc75GY7z1gDV+lik21GYVOd8RwolIKi3Sa6?=
 =?us-ascii?Q?GcUH5nKfg8ea2hFT3ud1xjdmIkVmP33pQnVzuGr1GwwjiZ/iDQ02vfLaQizL?=
 =?us-ascii?Q?Pr0P8gMjKK+1VpjwB7g/C1jfh8NvBIRET/iYALv+6KAmPPn2e+azxVfKALIy?=
 =?us-ascii?Q?Y3QuU1WhaZZPr3aOfEzEyc+CbDPgJLfgpE2gK0qhrxCV4yxuzT5Gbom9eRAi?=
 =?us-ascii?Q?qxkbjr138nyhaDYUmAzfUtw/vrb6Ext2WK7SUV+ezuK5/EAjYlk1IKZWxigD?=
 =?us-ascii?Q?RPHLsx9M09QX6W9u8k5SJ1qGoPqPgdo5kVJXHhvolM4+G1mZpSIsX8cE4n4j?=
 =?us-ascii?Q?sw04cDvMa7h0yiICPdVxCAfQLNSp7PCh1IEFfNXeLt5v9pfZDHTGynWWSQ7x?=
 =?us-ascii?Q?Q/q9dtFy3vUUM1nIqGMQfPSle3/H37YST5TpCtcdxMg10HTzIxbW7k5h2551?=
 =?us-ascii?Q?2HCnanl8/Zy4YCH6TsLXhubj3iLQEBws64zz/uzcKVG3kvGF2p6mv63zVIOI?=
 =?us-ascii?Q?410CM/8W/za/vNdIdnLnoawMnmWrzM4vrpE1A3z/G9EaVFBJghqoscMNhcHU?=
 =?us-ascii?Q?0pq+QwkQ9QfuBXKM383zc+akOWeEzuDGsIwtSTQ5CElYxn+PI1uBXZHqUVLN?=
 =?us-ascii?Q?4wWLdEfqqaZX4BjsNP5kJWrXX1V/gFushZM7f5bxEKFABTNDKaQBRonmxxLI?=
 =?us-ascii?Q?IPUAJL8X1QDFkpL0z/3+1MY1uoLG+QoqxN6m4zLMuDkOcixg4dNx0GCBAlpH?=
 =?us-ascii?Q?EN0dhCgKD/DTuBJBdFTv8BNjLvyzxr/GIyLHktnc/CbrfeS5gNLCN992hitW?=
 =?us-ascii?Q?xycTIyJJYaQmK0Y1lvNXhYdL53FjoOK+EtG+jugkiSXIGWhK9Soj8CoBT6Es?=
 =?us-ascii?Q?fg0IT6FJFzH28f8GxP8sULUMdJ4m0A5TC5I2pyXVRerQ0n6sR3ScvwF49CRq?=
 =?us-ascii?Q?8/E2Kh9oKs4dWNujYK9VR1TPaL6ytkXzTLcoX7O8UmjCdORG3+BCgnb1EC8o?=
 =?us-ascii?Q?Fwm9l5/SGJnfPXuNp+JOkDQa9HxNhenNlb4Utsm+oU/cKL2L4LUv9RBGGoCa?=
 =?us-ascii?Q?ozDJvEJxUqn+cRbUCDsJQblcyCCGqdajDSKog4LfeLWCl0tqp6d4OIWhuo+Z?=
 =?us-ascii?Q?XNkchXU19jh1onUfTosIlKYSSMu69jmx88JihGOUvHwYv/YnR7MoUOZpHyxZ?=
 =?us-ascii?Q?/OyYwHkuG7Q/thQ5L9p2LaBFRY84HPW5l1nNI+K6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y74qhxfr/ksaVKwvA+SLk0EPgSOIza0L49wgd9VayLfdlOKvNdFepvFPjOn5vfhKxhBY7/34cGR0W4jmMVOnmiTVaRz/ja/ehVgu95AEhor+ep7u9/8pBEb4ImDGkRv6cAhAi5yjYuX5xpu+SM42Vg74/567NcTm0Urjg+Jgd9js+Hi+PVzobz5uDGpm0ZucboZM/4A2Atz1Gzn17SJiPXmdKiTZcB6AysxAYoGLnyUkVvCbpA9yRN+OCIxlXA7dHag/IX/RnekVEPHnk55eQ6NOi0bZ16g7nBbEscfvGy/vn52GTiGcaujCS3XOlIFlBQtpj4+w+2Pqvv2W0rFxhAdPjmM7P1DETVq4l5jQ4ycznArF5mbzYXa1JQVR5XodjMfUDoskV7AsbHqIKjGaKHCNHHnp6ajWPqxZ7qF0iOzpUYlaQZlJ90FvkAKqUT1q1qwbZSgtsaFu2P2iuwpLzjn6WhQ71gpfu2iiydqTiwbRK/XRLrcct9qnY1wet1wCCgeL+DOQeOz8bf0Yt14wcNZ9JNdIZVObZPaktEfRvdpahaVBUIc27ySB7fjcvHaHej9EonPddkHi0Mmipl/RrxbX/vUzcpRvGP37AVfoFus=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8e6b24-81e6-464c-acb5-08de280e8de6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:26:50.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a42Ve0LfCobpMswPPoVkv4fgZxl4XsBIaico1OLXvGWxDXP4Ekb+3y1w+7/bwt5lUhYv4o+ZN7FtWfQyxUQ58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEBE40EC96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200048
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691ed0cf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=AFq6VSDrzhaw0vqUbCMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IyIqbHUBooxa0Gs1qczo6raMm6EGPmfq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX4sP0b26/tt4p
 rRWKnfWXGjNw71i35z/p8Vs6trDxKcd2SnHDMzc7Rl3m86T87U4QVFNah7J3vpOz8+1ImZ3uABo
 EqCDlFzsq8PYFnaRmGJzxhfuoNVvBWXV5pE4HOop9lUoWDp1zxZcd1T/4LYIYOTC9dg3NWica81
 id99HKR1J8AZ7lsXuYxKPDlVJUCNbpp3UYsDE+iFA9jbeTdVheS8WuTqXa583wolViHeYeyoa0U
 b9G3BVOYJ/FHIe9wPUjHD7NQJmk5dfcP6tRn6v/vygXXFRweBNwz+tAuTvffPM6pHMjv4MnXneg
 GeyiERmq6GfeMoE+levW3GX0jQYZKqLt5SPQqfRT6sg3QhejI094BQZ//M9Wq9jMqeSAcZYgRLn
 O1SM7SHFjGYzH8lZ8BhsmAWrMKuaGg==
X-Proofpoint-GUID: IyIqbHUBooxa0Gs1qczo6raMm6EGPmfq

On Tue, Oct 28, 2025 at 09:58:28PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in lru_gen_eviction().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

As this touches workingset detection logic, I was wondering
what would happen if a memcg id is recorded to a shadow entry and the
memcg is destroyed. But both the traditional LRU and MGLRU seem to
handle that.

-- 
Cheers,
Harry / Hyeonggon

