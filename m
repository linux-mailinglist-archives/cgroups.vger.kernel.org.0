Return-Path: <cgroups+bounces-13498-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM8iDBfCemk3+QEAu9opvQ
	(envelope-from <cgroups+bounces-13498-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 03:12:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8BAB0E1
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 03:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 243B7300683A
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 02:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB71353EC3;
	Thu, 29 Jan 2026 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5HJmDrL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aoSRpQXo"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072631DD98;
	Thu, 29 Jan 2026 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652752; cv=fail; b=NkyqVzfRJSbSgtfAY0eKxxIFe2pIXKZVICZOg97USWutEheWzc7cMOo+19jO8BrISCxepu3qcuSRnMvUFL+OlcyNA6UP9G3byLn1sjlprq3yzGDP6ZEhVF694t9cTYmMizLz5BLBQfRpnyjK0cciWQoA8b4WLSSwP5l+o1nNb0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652752; c=relaxed/simple;
	bh=CFaivd3EZZeMdR0tcFHepxKsYfN9CufietzQxugmQtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C4NzFji72G2En4cqbnonBMterComOlMHo/0WibGLkotrO8EnYaNh5EZCjxJCgzv9gLTBpkKaVe0a5SodqAhP3HvJ1pqJoq9BYtNQDK748kpcNVZeTl0MUln4mtBQbdxj+xw0/fSAHqRZvchYRO6qGS3jjbyP+CWKZ2M/Uqk32XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S5HJmDrL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aoSRpQXo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SGiWXV1337323;
	Thu, 29 Jan 2026 02:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=oGBWf0xfFivfiqdNjC
	nPwZeKGCee+B2u14xPxFrrADM=; b=S5HJmDrLzXJWe63mFi3YwwAKSMBft06y2b
	nSz9pQR5b6w6t3dE3N8BXQJXraiGKU5e3rsHKZ9miOyRrUmXk8nJSg7mrTQ8yVYm
	P9J4u4yIGbqvPdaWLvwmhlM07KYKOkYf9P/sflwtCQtmeWa3h9cHBSSw8SDaxoA8
	4ro4qs22BBcyzcnglwX+T6t8K6WPskslgtcoEkOVRYT7GVMMROHjXwZ8CDF8w6OI
	bkmO3KvX7ZNZTns26WFyuWZgpoaSplVzjhQLDWtH24HmAKF65i5QdFwBkIOGBk9F
	7GiyM0rIMEqaG14r0hzlpZulReCJ4xnSO/XK1hl9z2fKB1vZdITg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09k5ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 02:10:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60T1dXmr033695;
	Thu, 29 Jan 2026 02:10:32 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhbpgfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 02:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvSfULngF3Y/P7Gn4cLmmpYKeif1xqwOAB9OGxht7anqr1uCeQWxPSc8soQU80IYibtB6DWdpfKK8aTwRpMTlFw097J12p87+Dd4xRCxVJy012GpN9iK08p3LJ37Ek0KfQe5wxS9tAD76YLbtzTZJNkQ3NMslO/2rBL0Do8I2o1CW9VpL6xYE8gY7s7dRAW9OcLxOPV4Ui35FjW5YQD+5oACF5s39kmOGEyy2QJGzhLkzcM+b91Yza7YzxaVXmOzNjOHsPzTMLMWCfiSuHDz024MtbVkzAnZJk5A3F7vFvfVS4mfLlxjZ1/2S6JOEzcV3dCa+CTkWXbbe/KGZ1f07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGBWf0xfFivfiqdNjCnPwZeKGCee+B2u14xPxFrrADM=;
 b=MwLFTsH2jidTY2oK+rWWy595aUpBXHGJNLV04vpubP8DHsv5eV4kDWV9yVnXT3ROvsSUdT02nCcfSBjI/XigSZh1ErmbIH2tqxBUNvPulzmBnrSGMwrY0NbOdwevx56x7sVBCriL8WSFTeg9uMWFjHgoFVXPDFaGuoK+8RBy5wj4oRXy23ZLh6VVnoBDR3Vm/5wvfjjHvLleGXdkNzFecPWm10Hk8ySnEkkxQCiFLHjruT7jqyccroK2JJxGMwhATdxvUbcZJc2xOgSnvz7hiuJRdrMKU4q3ZnZVx2/DDFzSnZ6S6Y2J5O0fhWFuodBKJHc6YyjSHhYowC2RTzbnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGBWf0xfFivfiqdNjCnPwZeKGCee+B2u14xPxFrrADM=;
 b=aoSRpQXoOTYxq399+ZkSvetnVWh2p1VPkP+5Fe5RG7f3rln6snTwsIB+/Oo+L1X7hufL61+QLXmOGiiaQQHbi2QjrVdNnNQOPT4y5OJ8QcBZd3rv07ZBP7hk+3H76+uXX2rZR+UhkJ07QLkwrmB5hhZiD+7xZtM7Uqr0be6c85M=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB4829.namprd10.prod.outlook.com (2603:10b6:5:38c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 02:10:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 02:10:28 +0000
Date: Thu, 29 Jan 2026 11:10:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
        hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 28/30] mm: memcontrol: prepare for reparenting
 state_local
Message-ID: <aXrBiPlpEOOC3cMZ@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
 <iu27pt5nqs6myshw57e7dotld33v6lwuyouvquoqc2zmc5loi6@f23auf7hqbdp>
 <9b9057f8-4c4c-4067-b6ba-0791888c25e8@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b9057f8-4c4c-4067-b6ba-0791888c25e8@linux.dev>
X-ClientProxiedBy: SL2P216CA0093.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d3fcbd-7b03-4c1e-5abe-08de5edb9279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bR97aPOgC8VyJNhjc3Jt8Q+u5y2z4UPJTGZ0byvNh9Ml0xJ3RQadP3Sjb3gy?=
 =?us-ascii?Q?lJJI0Q5R+JZ4DMNHM5cdw5eYq5A5HavB8qo6DLbagX1U6NlkybQz/mmmo9+0?=
 =?us-ascii?Q?tz90XxKai6cwR9Lz5Plj1LJAFnfdDQXMn7j4wffGfCPcH0OsR0hxgGf1YLGd?=
 =?us-ascii?Q?PP6TylGiYDbeyuo8RHWxm+J9E8JMH10o7prm6fmMpKxDX8ew2b9qR0S9Rk8n?=
 =?us-ascii?Q?mwhciz9aCnTAiIizZc+0oz8/fwb97vX2e//jAdw8IePUO8gZupoPjpRoAfwc?=
 =?us-ascii?Q?7xJ7dHK6D2Zr13U9vrko/lbK/TOTOMdqLrrmGR2J6eaPTLqfS8e0K3vSU8Ft?=
 =?us-ascii?Q?EAXIJnOgwgidE+4G+1y/UGbi7/XdhUv4e+2lDmarGYgI3ab2xAgzxyW9oi+t?=
 =?us-ascii?Q?I0WwYAGlHJ8EwsvUNQidLdgMB3xHd106ZQ661yh2Cib6/aNEU1CoHcFU2llF?=
 =?us-ascii?Q?hZssWU211JaPdG9unesGN95MDfUkkuH7Hn4RmUvJRfx5n+d8yh5WH2kY33Re?=
 =?us-ascii?Q?H5eF+aiOixGTYgU+5CQcUCfhfROZl3vzBcozHVw5Lpvjcr9IiT8ajX/5L8J1?=
 =?us-ascii?Q?9Yw0rSgbjfD/PCIO3Yio+UK7sskhk9YVoTBjds74QlN+RNmOQhIAXy0V8i9h?=
 =?us-ascii?Q?gL0QIPIMn8exHXVZ6IIkKp+H6qQ+Padb9ixMhwbSUBUbBLL1CLPVOOIr3CX1?=
 =?us-ascii?Q?y70HyLZGkTEMExrEBuRTTsaAkuR+3sNbViR8xqoGzcLRVZY/GL4hddQEnmmL?=
 =?us-ascii?Q?Uq/hy3wlO/zxH7Vu17kpIc1H7JYrI6bBTl49tg7vyLmaSY08TZA1EOyqZqQ0?=
 =?us-ascii?Q?CLYBk7/mbH4nh1RwNTzUZ/tfEglnz42xtW9fJEKjQbQWgXE0dTJU9yiC8kc8?=
 =?us-ascii?Q?j1ZINUpPOUl7Nuv7z7QnfIu0hdsRRZVlcJaQP7u1EJAdUCnQw80Xaqqg9Ojy?=
 =?us-ascii?Q?6q4F9q6rRKbCtTEQvNGvVDSkRCExN+rhJrWae8CEMqhy1PRGZz86nzsJy355?=
 =?us-ascii?Q?4CUALn0EC6UdNlgoLtlC5HmiujrL47ezYzsUAO+kJB0ZrVc/D1dfKZHOOGDB?=
 =?us-ascii?Q?aSRsX21i8oF1SDeA/XKnKrD5QXEElzq9rjc+rzzrBXHJPlDDHZoSmGF7A5pU?=
 =?us-ascii?Q?MC8Nv2U/W6ChRGLTV7E3Yhph8phvlJbpx1dZa/rjtNEqZ0ebcZkGS+Ft54L+?=
 =?us-ascii?Q?nDqRqAKVvrPp9PURwEaBOn5kIO3/JJggcDuRMefYCOV2NfyQBUcwUVhwIEPW?=
 =?us-ascii?Q?3p6fro6U9PNC1J+ADnNw0eCbtYtnmJHkDv7ApWeCXFAz/llBoLbYAGLmXrzi?=
 =?us-ascii?Q?Y2c3/LNeVq5d6iAGPFbzhf9taS3fTJ6WGeEH8S7YseysmK+YSbi2BNOOyTA4?=
 =?us-ascii?Q?0hB2CoKLQfI76/+R5T1gCPK9rAXxlgEUhhEr68dw/hvUwwFXDrHjODR54NkE?=
 =?us-ascii?Q?R8E00wMU2LdqLVDG97NUNfc+/QmP0zQX5HOqhTS4Y/Up/wjoKYP407Q8DCNW?=
 =?us-ascii?Q?j20v310qzP50BsewiAhuDpT0wpab7Wl1m6hwdXYQXSswzUDmPltrFmopRk3i?=
 =?us-ascii?Q?1pGcfrT+Zk8ln85w2zU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZmZyzujirhFOj0XPdVUyL1+K+o0ye0vMN7VX4HkHNZw/hqLaySL1bl5kyxQ?=
 =?us-ascii?Q?Fw+bCxfoTIcMGKVOS0NtJzTQ+3DOBlfcwI0QBpEVVCtUlE2s4tIjq+Zrx5a+?=
 =?us-ascii?Q?roUOxDuixeq69BpIllw2MmwgiQN4lj8acl4MV+t/oH3L7qcYUPWPn/lht1b/?=
 =?us-ascii?Q?bisL9d550o4SYPsyKF1mbopoOW1Nke+HT3wHGkT5SV1yShzyUd3dK0dHTKmY?=
 =?us-ascii?Q?RvFrbZT4+9vzMZ9u2ID5dcrJERGe9JSH8qqEZkqSVBotC/3RKDw3/vGB9vEF?=
 =?us-ascii?Q?m6ghBUau8seStD19NAvzqNTOIgGzRyJMU4k3XtaHRMXBsGKO91QndgIvfb24?=
 =?us-ascii?Q?IST/lJX6IitbnihEPJ8NVPrNUUfA6/PlLjVI9EJHuGrHZwXoOLFAsYG0NqKU?=
 =?us-ascii?Q?VABMLXFVnBYsrZ0sPOVmCcOeUdqkBMO39lizrH/HzvV5HG1nO5/RVlW3h6q0?=
 =?us-ascii?Q?rMk5B0jRSxIBcWirTNko+Aw2VRho24v6fd/R2xHLoMe2m89l0qy23AZOS54/?=
 =?us-ascii?Q?fOSdit2pKGSCL+9FTIFZDqyhm8QCd5v1AfUa+zxg+H18R7aIohDDOPTANqhb?=
 =?us-ascii?Q?pnuuEK7mPrgyUi/e75BsnvOLiCnBHAjxZvQcUDzhKZ214YSiN78OO7wayjs+?=
 =?us-ascii?Q?+Vx/hptN8eoHwYxVGlEZ6lYJET2khINr9QQdc1lw5sL58Cal1mKrNS/YR5Lz?=
 =?us-ascii?Q?vzLE4Ivdg3rUOnJz6MaeLFt12zRTmREOhyIKtStmvuMFDM96QbrfNl7GJ4dy?=
 =?us-ascii?Q?ak32byYWrX0AusbhyRO314HoUIRPJ8BbCiynr6eW8lhXlbd6q2NApnV9Sy9q?=
 =?us-ascii?Q?W/qwNak32oYNUKIveivi4Bkl8bP44qHSaqG5UJXxrOa4Cz1gE63IQab/LLRX?=
 =?us-ascii?Q?3t8AodIQ3cmM4eyboMQjGZs3P8Zlo6Zg2MP8V8NYFiXcUoGnIo40+yXjw+xh?=
 =?us-ascii?Q?vL37LS7whv1sNmpCf5A3wgq6qQxrAwSa7ZPd4k/8ueDwoX7XGhAoubWqX3Yu?=
 =?us-ascii?Q?vqZ+A989BdS+EHe1CURV+yiwooXpYj3+gS9q9wjmwHOTaDn/BVpDivm3jBJN?=
 =?us-ascii?Q?pkD5QwdAaK69Wg5SKGibNNTUTDPymkO5zjzskjs12RqNAvIK6NpRa3Zm89RT?=
 =?us-ascii?Q?Zo8GYA0ovKSHQghF5hc1DrfZum+zt4Bkxn4aEpLMRof+Wb8f++jyCJWOhFg8?=
 =?us-ascii?Q?GZS/fiR0hFNVXw/Xl3VCOSIb0DwYp1HxZxyrsjPu6xN56HBjasgBQ97xmXiB?=
 =?us-ascii?Q?0ceeSqpUG2iXqJ4GREUPEkqQP6fv7Fpz1kv5kZfAPknQ7cqMo+z67NQuN4vz?=
 =?us-ascii?Q?s4vr7VQedKVCvdzThpZuvsVZBNFW/Y5PPLGSd1hnWZGW0gLx8zxciOSgutxS?=
 =?us-ascii?Q?zBF5y4rHbljspVsuJNTAVm6AiBfvuhpc0AJzGejJhJkBuBHy5PMZR/pMdkv+?=
 =?us-ascii?Q?j5Lpm4XqQBi8/om1X+hkl14RDosNUvSDFu4CqGu/sEuETmTYO+aqMn5RHbaE?=
 =?us-ascii?Q?uZ2sK7HOXweNVxKuPJes+sFis3F2vAyHmqCUh6pW97X/J3LZmvdHTS2Wkx6M?=
 =?us-ascii?Q?TAZc/2w3YI01cY5NApxbb1iqbRCq6bma7hxWAsW3Efv+K3wkhmMQ+4WTgif7?=
 =?us-ascii?Q?m2/rAt0hw9hgpiTPdWdE+kZQmKzphAWl2RUygtfyjpVAR0FOjrygsZ9+N6fV?=
 =?us-ascii?Q?lZd0UORTOcg5m246rHDJZhMS848WbRYpipBXJtsMO4xObaE+DMsjRnqw8QR6?=
 =?us-ascii?Q?Vn7EaWpeeA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zBkUaswmE8dDmItr2QVlpv48qyIBlSx5wtFxGO9F0jLXvgvNu3FCuCOh3tiN6qbYaG4b8DW43mVKUP9vSO5DKrFu7qmcCxIKRHqRgvOzFtKp10iqwt304BBA6Y9w8DFCKiO/fGU7ySHGRVjFdhmBT1V4pWzRkCrlIuam4INej3ARTf0kBiZnwpi9vBA8S7EPcQeGlU24wbb0spFwMRgvwtvrCCZE4mTi5Y6nUahifHfYqgISIYcfcLgocHo1nfoP5SQikMIhBkENMBxihB9x084Ev6u8JHbUy+yVbVZoZ8eZekLg4l6YeWU9HmsE7ZMjMWqzyEClUEmHoFI25Q3YihnFxcsTL9it+UoqlQi4IEjcTlhS02EfksftVuFDGcy7OQG8EpBO+rWY4b+6fYoYmVgfP7Gutro/b209wNKL9JuJYn4UX+TxClRCTEjNpVQGklPDlGc69s3NEHkW5TdGXjYDWLF43oNAwr6nydWfyNXCvlm9DKezoZ/L9yp0I0s+PdRRMyqv1lcYcu+OYNqHub6AObNKdwt3EoRr57fbDo/tX+7YQkvrUXavX859AXH4Efam9N8O9s5LoLbxJZGWoT4y++rI4/2q7C5tLH47V6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d3fcbd-7b03-4c1e-5abe-08de5edb9279
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 02:10:28.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCsBun1oAQGoQu9YV9U/CVLJnT2s+cu0z9n6EIwlsPjRzGQAgm9oMjJZDmyX00ytpKzXGsgNEsCLzAUrC15JJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=706
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290014
X-Proofpoint-ORIG-GUID: 69NspH08ASoGWdhx8LY_prrRZk-oU_yj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAxMyBTYWx0ZWRfX9HN2shU05799
 n5na7aBRREt5jE/2VT9QN35OAGCneP5Pw5WN1Sqgzo7RCXfCWWRi2T4kqelSjfVVKxvrqlRG8db
 5hi/J+t+07b8AO0fUQ5OokFO2Z3A2hAdYsICWSynCiF6gFTiD6vwM/AMTqt8CpKHmsznIWUXVc9
 FWtdJ9uv2Otf38tTjMYgIqXsmtHypLt4HVdat5u+6SNIrIfEIJnzzq02Arxsh8tzxfVgG1/u5Gf
 ZKjtrUHRHEDZ42WCe7POq7Ft/DvveKhuWFsHBXNZ2TD9YvM+V6cBt4thfITGhNsSYckjvsfmhWX
 DIsQC5oAwFEBex4SegxoLS1+TOPzZ8ugqsuc2rz2utcp42QF6OaMpHNWaA0gaHB3BNykCcS1XiJ
 fmuKDRkY1LBstiYW8Uo1m1R/K3PLlujg/CitwGmSKVMrk+zKMyAVYX5mXXksSe1yH5OrQuqAExO
 mU0JNJUwkKU0ZimGlEg==
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=697ac199 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=BK8XirUzr3yz5t94q3EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 69NspH08ASoGWdhx8LY_prrRZk-oU_yj
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13498-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 41C8BAB0E1
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 11:34:53AM +0800, Qi Zheng wrote:
> 
> 
> On 1/18/26 11:20 AM, Shakeel Butt wrote:
> > On Wed, Jan 14, 2026 at 07:32:55PM +0800, Qi Zheng wrote:
> > > From: Qi Zheng <zhengqi.arch@bytedance.com>
> > > 
> > > To resolve the dying memcg issue, we need to reparent LRU folios of child
> > > memcg to its parent memcg. The following counts are all non-hierarchical
> > > and need to be reparented to prevent the counts of parent memcg overflow.
> > > 
> > > 1. memcg->vmstats->state_local[i]
> > > 2. pn->lruvec_stats->state_local[i]
> > > 
> > > This commit implements the specific function, which will be used during
> > > the reparenting process.
> > 
> > Please add more explanation which was discussed in the email chain at
> > https://lore.kernel.org/all/5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5/
> 
> OK, will do.
>
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 70583394f421f..7aa32b97c9f17 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -225,6 +225,28 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
> > >   	return objcg;
> > >   }
> > > +#ifdef CONFIG_MEMCG_V1
> > > +static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force);
> > > +
> > > +static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
> > > +{
> > > +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > +		return;
> > > +
> > > +	synchronize_rcu();
> > 
> > Hmm synchrinuze_rcu() is a heavy hammer here. Also you would need rcu
> > read lock in mod_memcg_state() & mod_memcg_lruvec_state() for this
> > synchronize_rcu().
> 
> Since these two functions require memcg or lruvec, they are already
> within the critical section of the RCU lock.

What happens if someone grabbed a refcount and then release the rcu read
lock before percpu refkill and then call mod_memcg[_lruvec]_state()?

In this case, can we end up reparenting in the middle of non-hierarchical
stat update because they don't have RCU grace period?

Something like

T1				T2

				- rcu_read_lock()
				- get memcg refcnt
				- rcu_read_unlock()

				- call mod_memcg_state()
				- CSS_IS_DYING is not set
- Set CSS_IS_DYING
- Trigger percpu refkill
				
- Trigger offline_css()
  -> reparent non-hierarchical	- update non-hierarchical stats
     stats
				- put memcg refcount

> > Hmm instead of synchronize_rcu() here, we can use queue_rcu_work() in
> > css_killed_ref_fn(). It would be as simple as the following:
> 
> It does look much simpler, will do.
> 
> Thanks,
> Qi

-- 
Cheers,
Harry / Hyeonggon

