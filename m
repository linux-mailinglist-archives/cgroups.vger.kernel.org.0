Return-Path: <cgroups+bounces-11770-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE47C49E40
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 01:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507BB3A7D5A
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9E9247DE1;
	Tue, 11 Nov 2025 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eCeJwvh9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JcrA9Pw/"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7EE4C97;
	Tue, 11 Nov 2025 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821784; cv=fail; b=L2jzYvYP2P9Vs8K2fdnRWz8TueGh/G0e2xOXxv/QFtJ2InzjTlbEMWeZj7OMO+j+n1GAhz3Bv8RjlgNZSZsfhJK7WunsNc1fAsuWHEnUBrpJ+7WY9rr8/il1yz8yH1ygS7XbRbTsiE5IwtvTmSV7PG8gj8pNrthAIv2Kktp7FP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821784; c=relaxed/simple;
	bh=HkZvd6hJJMn8SGSYs9fjFBklQALhfZ2Xi1E05eb64jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nuvi+UK/onVy1oYS2xeh/j6dd/0f1OTdfzrUnDHYY0yzRpdFr4Kwd9KfYphgIQoA0eiK37P69vmw9Yw+9z/notxLS2CW4Ms/IOWtLRQhkFxcYu17de/28W5JAmHeUPN3BuFDHCwF0xznCugvrF2zR6/y9SJMfiNKoljkzYDiouQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eCeJwvh9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JcrA9Pw/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AANnJMh001557;
	Tue, 11 Nov 2025 00:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=J/crauIp5Z5v46GGl1
	CPl7I5uoF0p7/7DTyUO5spp8U=; b=eCeJwvh93gH++l9ZCuEnlfylJwwM+kEgZP
	/MG8S1cAc4DoyLxfzyiTYNgNQshYS3zRv8NOHsrPhOp7jXhwzCqrGVsV25k9ZcoP
	PyD2Kco5B3DZRENpQy02cENjzOS3YXL42oGVXvpxzOu6aQok/5ndza8Uts9fV1fE
	ox3/s+J62CfNyLxpU+D8AfcTFUNHBhfCFF1dWAlvAiU6Q9FazTAR2B0FRE9FLcHk
	h1cGLyfPHoX9l3x2MxXJLCSzyk9D9arqTAdTsx5Rz+7vt0PL4X14wPuAm6hlLzz+
	Uf/jOU01fpXcUJP3w3bNmtazI6U9JVJVJMaPP588C1gPaZS8dJbQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abqpugcuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 00:42:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB0BaHl012715;
	Tue, 11 Nov 2025 00:42:30 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacckm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 00:42:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAGv5iA+v102N8GqT2i/iY3AxmP23lyASS9QjYyF80DReqK19MX+QpnCz1S8utKk+c2eMZbvS9L66OY6Rwyh31qH+Zu/Nj3ztNfNpocKi9N5Fe0LZHVS7hJPE9fGWXP+AcbloPEQmzJhUZbqhECjRPLC0D9sC8wCWUrKEwWEV58BbUfqmlvF9DdBB1wDxo3bVeInI0w58t3dAS0Be7Ur0tQiM9xnRRruHHqADcgn5AF7ouUrvXO6buAPeSL0qU6zdSKFAiBCAP3BOwTtvr1CBsW+JDC/hK+uzFPOgtupLNfhQUnSeGQ9+T3XOg2+TD5mqLsHRudXsTGn/WtUforHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/crauIp5Z5v46GGl1CPl7I5uoF0p7/7DTyUO5spp8U=;
 b=SFULrzpQXj2Ww/77ioCjYMrTW00QG00cqri78hCFIRce33S+JoYdS0YOaUT0H/6b/Zs95w9IDbeTWxUdqdWcEl9MFxg3zkAGfNCJ+Fxa9kYy1ZEoa+VoAkUEq/KA4hYMmNKodcSxLwbblpHcHUf+766kypneRBGSIad+7eG0QZt1rbeTz8CLOX0kakdQzmK68aLGtXW3IS1lWi6vB2KzpYdmgKpisn3WtK1f0IkBykq0I85wLPwnVkUC2r/xESlAJtZCj7AA+JEgaYOWLxVzgu3dJ5N505T2VURZ5H4B2yUBFNnvIzNHRWrl0JGrVkA73P8suIHmEVmthWTFOL4wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/crauIp5Z5v46GGl1CPl7I5uoF0p7/7DTyUO5spp8U=;
 b=JcrA9Pw/AR49/FMgaYZcT1d06KZo+ewKf1Q6kL+AcL4MhF8qs4sw+yT9I3VfL1KRdBPvuSaJ12K6sPcznxCDMlwHaAH3yRgT5vzX0ZX71xl7psO4X9wJbgfP7UoEdSOznwe5jYcBFcHqC/M7Vjow0cJcMTpMWNeokgbsyDjDIxA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 00:42:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 00:42:26 +0000
Date: Tue, 11 Nov 2025 09:42:15 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
        mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
        imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <aRKGZ8CZ3DE_9o0j@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
 <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
X-ClientProxiedBy: SE2P216CA0093.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e17a49-766e-4036-c5a9-08de20bb2f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wfIVErPvwa8/w3dbAoERQUg2dhPoxj7YgyVABRywpBP+Yw7Mz3y21wba5Mbg?=
 =?us-ascii?Q?8jC6t8ydaxLDx7m6lU5wrL6nk5eIwliiv5hAMGiv8j5ioz41uzWCyXDD3UTX?=
 =?us-ascii?Q?O1F+PgPjiiLjsTQqqVas9K9QFJdFF+CHmoE3+ogOeAgKjZL0JV6emAG0Ee39?=
 =?us-ascii?Q?oot+Pr5DXnzjlPIjHYchsuv+mYb74uGFq3Y+tuXFBHqX/Z4eJXrTDT6HCylI?=
 =?us-ascii?Q?WDMn7PcQfHccW6wo8zelyFx2ZYJ6KcyE/c99JJLaGTjrL7kXqbGUcZ4k3tO+?=
 =?us-ascii?Q?svV6MT5euCAstQp8scsfsBR8mJNXDSzCeg89TNDugkiuWZComJvSeEqNw1gZ?=
 =?us-ascii?Q?efhOXo6zQSPWzVgxjMRiuAptBjK+ebmAWHurpTNF7QKiUXsRPf1PEq/bxHE9?=
 =?us-ascii?Q?VHsLLufJ7P9r7xiO81jv+y9+/sOTRjsCGQHFXZgq7Y/z8DCJNGcBdYHTSyba?=
 =?us-ascii?Q?ct0++s4s36Yp1SFGoit/9gwLm+hNODSzJki/s80s6HSIMsutNuF6yj7iRDsh?=
 =?us-ascii?Q?mE5aJ2lxCFKORAw0gRgW+oimchhJQhuxoAsYqczfCVE0L9yvN9bH6eqt3S71?=
 =?us-ascii?Q?neKOMwM7Lq8LAUgvkzPR/djS4dNK2J2TjIMjUQBp/Py/KscZeMdvYWgJ7CLF?=
 =?us-ascii?Q?pTx8jnJ4kUI1e6862p/Hiyjkb8DyuRWEDQyNS8ISWhzZj5MjEsHS6rTE15ld?=
 =?us-ascii?Q?W4SLMv725uOY8IbkAecbndXOexJtNKF3R7r5KkcIDixsAlNUTb8LJDW8Fw6D?=
 =?us-ascii?Q?wrvTsZMGGo+hUbgxmq725QD0Rrh3Zjmfn6aAbp8Y4wDyuN9RvrHjuSwbp39s?=
 =?us-ascii?Q?6qAyDlytB5mtEXjCjb/3GDf/XxvRTo9KsVmhnDt0g3AKtNkwcajfmpPePUJF?=
 =?us-ascii?Q?4pRAw+7CrVCPxBvs5oacjFEHbf/rvG9zGFtjdHBkakWLCV1pqd5Luukrrwsr?=
 =?us-ascii?Q?lvaLn0qVoe2vyXQ4wtL3AKZycJWMvlU/kjv3YYMmSmLk55n0FtqzqzdsHGtb?=
 =?us-ascii?Q?FyLchcm6EOAoKx8SmkWxheSkgM0H3HxbQ7obtjXWuhQpc7YVaAXVD5NwP2Uy?=
 =?us-ascii?Q?aEuRdCicHJYnbEnseMUMsH7fYjnwVAXKrgTBbtHopfKmx6ghqYUQVhQAgyUb?=
 =?us-ascii?Q?yzYYB0RIcZglvQlEJpqitzDkNfPysXSvvq6KfpNjlzEkWWBB/hGEC8jTvgBS?=
 =?us-ascii?Q?PCCwVseVwEADdr76ljBsw9LeUILEbjkC1esuPLPaw3TJCA09c7GYa7MQxcu7?=
 =?us-ascii?Q?rFh0TxhqIeafo0ZjyMOYZYo/zZlOoZUycRc+4RPnfbf3oyy584FkrRzXo6c6?=
 =?us-ascii?Q?5mkXVZDdjkZwVw7GzMXPb/eITmPeW8U/AIMz5B2g8AO5HsH6e2W9UvGzkoio?=
 =?us-ascii?Q?HcQmzvZc1nIIp0kRL7cZTzGUzUl4T4yuP8JTpNlOGoCDTo/lIMelQWGWnQQT?=
 =?us-ascii?Q?eW+MTEbcQjnYgvBtczFCqG1wCXo4BywB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLM3EiGUChgfUYcIyXm9bYE6+QiRkuM8WA8HabXGw8PkIbTt2ML6E/fvfwz+?=
 =?us-ascii?Q?VO/PgUK2ChKF0gDA+PabREKuWl9a+xXTI8uBDD9kJ5ZvVc8OxnugCvXLdh0c?=
 =?us-ascii?Q?BsY6YODjOJht76GukW3vIhsi353hmUZidAnPbe0skFFsxX7psP8klLNq3r2e?=
 =?us-ascii?Q?/RD0TDEwQY3iXK9bdzzMA8ow+zaan3d72nK37VcjHB8jSYE5sFmbwxOk2BFx?=
 =?us-ascii?Q?NO4remKrbfIuVYcPO9BA5MCkikEjtMW3+Qpo/Kkcf0wrCSMDAKU1JjI1FUID?=
 =?us-ascii?Q?uwVD7lEZ/GXrTHe+6G6MqIXBuAxUYGMqAhA+ZWAvVm3dzRCbzcylRXLlrSKe?=
 =?us-ascii?Q?/egP+TVOKFJGUMdujrhw36Ka8pqF5Iv3igNAw8+en9GOh5Yf1Fns8OQYyjcg?=
 =?us-ascii?Q?vLpD9OvmxhxRWwejDNtd9jixLasBZMBe9yxfCir8g3gvIkxx+OesR5+BWr54?=
 =?us-ascii?Q?QPD4hRLz8/zSvGOMbCo87lqblCPXgITKlFDuuFPmSRlHTkZ5nD7GFl40eCiL?=
 =?us-ascii?Q?V416smFjyRRpXULqLAKvbCBWqizGSqrmXwFLtCJ1z3Rhr6ZfgfbLhx9CWmcq?=
 =?us-ascii?Q?FeinorrtrUR0R5BwLwo+4Nxc/RURhWQ7V+uDjAJx24Jxu52KvID3RlHgWyVf?=
 =?us-ascii?Q?WBYiIbkMAqdQTb96JcXvuWNkEFy//Gn6CKi5iUhTLBI0QEqgRX3RVNywDtFA?=
 =?us-ascii?Q?tY6AxsdA7AtYLPLW+Yd7ZkDs8vjctFmqLtc0bbQpTJ+pYBrOf+ZL/c9clT4Z?=
 =?us-ascii?Q?fbEvKreOcmQimEkQPQ7jlt7cu0QrJmsewKKj/QybgCBzHUoNjAXfNBl90fql?=
 =?us-ascii?Q?PEcN4riYDW1sDvyuDToGlsdxCphS69Q44WsGFbS7Nu8YaptOD8kfxy4l1geD?=
 =?us-ascii?Q?tVdqP62GU8h6pNTeLSSVber9C4wvezt9JHdta5PbZjtayZXnF9OQCdlhgWI3?=
 =?us-ascii?Q?kpe+lw5Wj0WEnH1mL+qeHIpmqTgJD2anxWsbw4HerGdDfCLT5/W5L3Zf6pZ1?=
 =?us-ascii?Q?MQQiVjW0P15inasjsiR6N5ttlk99L6sTg9YAFhVJBArETA6viDxouipGqtn6?=
 =?us-ascii?Q?sPBBCGHWUdj/61JtU/c7zocAgjLq0lg6ngga4e/vJ9KdZCAZcr192+mrTGAm?=
 =?us-ascii?Q?+3q+BNA8Mpq4LKpbCfQaH2jDMwVOVKgmyVBGmsMvsM5zO0bDe2XEOQtWFiTd?=
 =?us-ascii?Q?DyYAvTRmT8kSkRl1KCNeiC9Tblj4q94m4RTkO0s2CcfGkIVNwI1eZkpcNNr7?=
 =?us-ascii?Q?UPkm8vSHo8QJUrkbRohgu2SQUqWJnVzzlrlkDkHxbiEbmHj+d7W8X0vBxSTX?=
 =?us-ascii?Q?TBsXAzZxtie5tb0vidyHdw9+t33saXgCwg4MKSB2hTesgUoUzif5heBKh6o+?=
 =?us-ascii?Q?zmqZyFQnoXTWminShHufMiD/dOBLebgPZkT3ve+ypiKVuBdjKPPa3aPEucta?=
 =?us-ascii?Q?z+FykjjfJypuJR9tqb43TkhbwRypge1K46vbY5j4Hf1NT/QA6K69Yo0724H0?=
 =?us-ascii?Q?gfV7+ZHoozwhd2WHOFG1AoFAtLEpSho3T6KSCd9372I9BbxTLxjfQuOJnqCA?=
 =?us-ascii?Q?K7NxMP/y0hRhUEBSXx/MUhEIQBEGpenKYcZ8VAMI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z15+d2iVRnOH6V++PJ3OxGNYPLw6lurpjJ5f1Ock3Gn4pSG0ZxOemjMXXfEhicnATjxeRIMvQl3Hzw9d4CbU2a6ASB05BZMRV+IvcLPUu1z5lwvg+r2u4o9xGh6C32kp5Z0/+Q/dDS+UuRmq5AXhPy0elC6oeh5kBxU6k/ltFiMDhngxm9mCrzQI3ODj6ORfU3xxCBE5dWueJwyXldhPwuJiXnQTgcS2gi/dxfchjfwuv+FjJtYOn4cFCIBcXFjme2dZ2MMCJTJMuq+BsBnF7NS/TPuOfPp0lzRxqFmeSLdyZExgza1hNmOOIJ0vzhb9m5h++86pzWsjSIwQRdH+Z1sYnfTaFyTZHt4MXB/JOQYj06ZQTMBSTArWmVXp8OyHY5lr/lw3ryXZyYS1dF7sZxoiXIF/dYlXrS2u2uAj/a/2u5i+61xI3KabbcMblzBPfj3NGD25CVRfC6nyReG+9SAy9JNp+6gzYNErzrYcj47DyMua+WAjjP8LB0l15IBxjqC1Wh6hj/w4bdfBQOU1WTHh5snh1XHTtQGgxconHRc/wVPy9NafIW1uMEOqspppHEXcrnYcNoN1QlsSeK6iqAgmsQ/aMcL6O/EykW3ErM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e17a49-766e-4036-c5a9-08de20bb2f94
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 00:42:26.6617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuoPchRdYcT2Ug+v+GkCLn2HNaUddzwPPX8cBGrgp/XCz0LLy0lKwzNvUJSET/A6TLjM2Gpsg+wIYjHq7rIdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=902 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110001
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfXym9Vb9bx4i4e
 MtQ1bmvkmKGG15N87xKR6E7ZVNwxU6JlBB+vq5nSgRNIauy3xI3RKRxqtwtlgNdbU2HzSIZMBv/
 59iFpWH7VjTVH+4XJii55iMZ1U1RDFGUee1NHAY2FkN+OojWqyhOO86rcj0so0PiGXJs5kjk36+
 rTQhPih/l8fVog0itkbgswmlgyCM5jOWPyi6dpMMqJSkg0YV7haDFrMixiktUtS+aOh4I/A/+hv
 cPlPOtsymli104A/5epR5lgy687jJp6evIY99g9bfuknlRySGPfDSzG4/289Y0cu5GmmIdjkn1P
 7D+uyISKMHbzINrZbQY6MJ3an3iBhRTn68VJ1oQ9xQY1pz4tVq0KCB7440if1FRJnGhykHIqWA8
 eh3rQ2dbLdWnQNX0xsyqh4YFCoYBzuOv9av3qT2CGW7oXeoV5fw=
X-Authority-Analysis: v=2.4 cv=H5rWAuYi c=1 sm=1 tr=0 ts=69128677 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=aYcVbtpDgWONolYQl4wA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: LwoPYoVPESvnLRrKI7CMkXZuI0VydgFf
X-Proofpoint-GUID: LwoPYoVPESvnLRrKI7CMkXZuI0VydgFf

On Mon, Nov 10, 2025 at 08:47:57AM -0800, Shakeel Butt wrote:
> On Mon, Nov 10, 2025 at 02:43:21PM +0900, Harry Yoo wrote:
> > On Mon, Nov 10, 2025 at 12:30:06PM +0800, Qi Zheng wrote:
> > > > Maybe we could make it safe against re-entrant IRQ handlers by using
> > > > read-modify-write operations?
> > > 
> > > Isn't it because of the RMW operation that we need to use IRQ to
> > > guarantee atomicity? Or have I misunderstood something?
> > 
> > I meant using atomic operations instead of disabling IRQs, like, by
> > using this_cpu_add() or cmpxchg() instead.
> 
> We already have mod_node_page_state() which is safe from IRQs and is
> optimized to not disable IRQs for archs with HAVE_CMPXCHG_LOCAL which
> includes x86 and arm64.

Nice observation, thanks!

> Let me send the patch to cleanup the memcg code which uses
> __mod_node_page_state.

I'll take a look.

-- 
Cheers,
Harry / Hyeonggon

