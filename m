Return-Path: <cgroups+bounces-12111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4DC72FD6
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 09:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69B4434DF4D
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32F6301482;
	Thu, 20 Nov 2025 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="njM9LnNo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YkuCDjcE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795E2E5B27;
	Thu, 20 Nov 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628857; cv=fail; b=fMLOnWpb5YZynyrB8GxRUUDNhSbUotahn0XETGfu8zk/qqjPfz2ii6W2/sti1SBzOMPo9r8P5aoLPcqdKW4Zoz/J7XGp06VTZ9dYBpZ4FUwSkO+NVylKofBnyc+nHc3aJiJUl1Sxgdz7VWTxXH8PVQ882Sn/yx0MBQwlzSGcuGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628857; c=relaxed/simple;
	bh=Xc4SMSl8DT245J6AD2XgW1nDZBaTZXQt0ZEXeZdK3fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XFurcD86vt7vuERpH0zonnazsq4fuHLPo2GqcdtjGe0pWp5dtqsDox4xNAwjFlHZI/wYbnXFaA1fkupejllbcl0TUwUQCWHlOvApBV/xYqx2ziayr4/ClRfjQaVlBqgP9ZzlQV9tDFOtZo6Y7CK4BAqSv6GaHoN6TcnbpBQtHlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=njM9LnNo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YkuCDjcE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK8qCrn007779;
	Thu, 20 Nov 2025 08:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VRxWnSBQGRxPa/50Nm
	SGC4OmoStFLQgz7oLKKx8W65g=; b=njM9LnNokFq5HtuRUM8N+GVVjPWnnHM6hV
	eHUMy73fFlpKIZfcOvyEIeIKGbFbRqLeWh0x3mQQB3IUsGx81mSbYWD+nxvSSY8F
	2Bz7rqSlhndVGZFRCPX7JJAtn03XGzWU6xhapp8q989nE02a39NMvqtRuagSPuUK
	JPhlfZg+H40rYK4Zvd6OUR6R2h0GhjtWuOB55Ls6a83W4oU77w1tSryW6kBChH67
	2amGd02kufBdh7SrIZ1EY6B/lfSdHTJY/rdWNe8XaRAX4smPjI9/ptmEisqDnOCU
	asBR97pL33a9+EFQTSgx9ujW9B4Tf95DQqHsD9/c4UDdx4qh1CAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejburhmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:53:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK6tQto004350;
	Thu, 20 Nov 2025 08:53:33 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybh44x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 08:53:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMT/bRFvx8dh8S+KqmE+29Rt79BgW6Z7DwxiKVwUd0C0WLzB+nu7iqQ4D9RJMaej3w+QjyA1bqgbm0U9pYg8xaM2/5+KbNlugG1ESAJRAw7AURRE20sGAgyL9HmR+UFHvpEIqPVgWw6XXgLgEDAf2eCGspe7xEytPPyHsNmI8Xw/L30zEV/5rs8D2EdQqynyJJ4LVy/3DgzfcbbJP2ii7LLiTDFvM5GnrqqVLhS8Ys6uBGrwKlKXAORgUda4jpTitWKYymQdrAc/uz1WMbGlTpJIw0Q880VQkEsDSWcCFR4aWJxsiwSbnpOyFZSjYWBATWwZFNC1Si9gWcjyoQARhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRxWnSBQGRxPa/50NmSGC4OmoStFLQgz7oLKKx8W65g=;
 b=gXBmkQRQuNa6VgcQDCL0lRrKElcECk2ITg9TgdtFsYZXfOlD+LFO9EU3tE7yvpn3bwbWusMvEg3940u1bgtxiwfxtXAk59+dt+ACSOHDrP+ku3Wh3fmoBs7CIU9BcvhiLvR7kM4Az5OTi/lAFUM1SWa/OrYDE0UIMps8GiBUoKKxmeNm3A6BqqEhmlCXVuBYZZQh459WcN6qBJvQz1JQYFbF6nqLjBLDxd/NtmOGsYvMIJUUYWKnTk1VIlTohhMBoSPwExNCUMcA+6E9a/QqT7S6Rctge62/ohalwp8VTj4w0pgDeapDbvdabRMeet5hY1jHX3Sfy3DIIfxBuhCgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRxWnSBQGRxPa/50NmSGC4OmoStFLQgz7oLKKx8W65g=;
 b=YkuCDjcE7EYnPz/7IcnBLCbeB66QDRcry8gz9LXi0mxHOi6BeSQxKVQteVMzTEnjSU9UBcdQl8mmTZsAoRx4c5+PQipFSKY+GKt/e2AjMasII92h1aD01dl7M6Oz3FVeZa4Hh0FYYToLQf/lqMuUhmXoRfPOgtCL3z9EgIHKHGI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4553.namprd10.prod.outlook.com (2603:10b6:806:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 08:53:31 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 08:53:30 +0000
Date: Thu, 20 Nov 2025 17:53:20 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 16/26] mm: thp: prevent memory cgroup release in
 folio_split_queue_lock{_irqsave}()
Message-ID: <aR7XAJn11ubk_om2@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <ae89721afa0a21376eeb3386fa60f7426c746cd7.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae89721afa0a21376eeb3386fa60f7426c746cd7.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0130.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcbd2a9-781c-4e75-20f4-08de28124771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BAQx3Zlh6HdURt9sfK+perQs/+ylFF8Ppc784IPBKpiF7MlOO+7yRW/ibkRE?=
 =?us-ascii?Q?o2isAydJ95W897nsz6di7A2YNyN8/V1A+sgVNZhAtIQo9dHxARdJWd7ckVTq?=
 =?us-ascii?Q?9FWEn0nblV9Pon8WOVCx5n0TVuSE7p0a50ERFVvYs5nspdFMvj8bQLZIXhMq?=
 =?us-ascii?Q?hF9KLhH449L+uHuHlE6SM2ip3oJWaDbEHRN2DmF2jDnAtHHwFWfhPPljEpbW?=
 =?us-ascii?Q?2eK4UQYMuCi6SlfTHezpQOzVZgidye55nasymrw6bgAgS0AGyfcmevcmV91F?=
 =?us-ascii?Q?CZU9QeF8n4KWHxQIB5L5/gPdttCfckMuL2c4e6Sv36lRILnp7lu2R49x8drM?=
 =?us-ascii?Q?uFN9xhXkYxutrf1kREDoSfYtNccu5Unhyj4eXhRgadcxit844UgzqB3jj8R1?=
 =?us-ascii?Q?Pajpp0zJ8S/va5MR5ymId8hdr/1fUTlUwSjuk0CstR62VN3RgA5/5/s5Az0D?=
 =?us-ascii?Q?JntBY2pl76V+zgwQ7OY4ZNskIfPHnUJ5E1N4LKOPHYR2oI89iKuwSVQtXJvt?=
 =?us-ascii?Q?hSNmk5h6OP+VDr5nhyOKWBrdFVqnYMJEbptUvHvY3lhz/W6KaTOd+B9dZVKH?=
 =?us-ascii?Q?0XynlSSSNhN6Jpz8T7U5f3nyq7uGAVo8BAOP30qfZfSbkcJphknI5CnxwDg0?=
 =?us-ascii?Q?5jXvoT5FJ5+nFkeEolUpXX6iy7Ff4jDWNzgzJUN7wzVmpqsOASMb8/hk1kK5?=
 =?us-ascii?Q?jHIEO0lkfmz2J+i+xjfnRqnQq9BRRji/CP20WOSABGiv7aqkchAiJZ1nnWRr?=
 =?us-ascii?Q?N6qwJjWiulKEmTWCLi0Qy7daTJK/ohL18axBG4ScV9jYo/XZGRbK3iNJnrar?=
 =?us-ascii?Q?p/hNo/Bgrto+XblEGkvdHFu8UL0H9pJvueLXsumPhIK6yOPXPpUP3pAvQNMp?=
 =?us-ascii?Q?tIGyk7oA4ND55jcW32s2rbyWyWd8cyDPC3ekFqGNFCjPuBD6OiR5jDUCnTBX?=
 =?us-ascii?Q?J2rzXcIfI84wbL97mqzYUxYNvkuX8Uf1+C9pb+KY2lsgdBdiy4XwKrJI5I1C?=
 =?us-ascii?Q?kwWuzXNx8LG4jAAVg8zYIR3nH4w09lge4faNqosssTxVNCE1oNg22Ov8i1dB?=
 =?us-ascii?Q?kQCn1K2ybNGtCOSqljXGnCOqc6gaUjnDi6pGBcVKoDg28UWqzoy2nqJRxxPJ?=
 =?us-ascii?Q?hbquaTliog0ZogGPDx0U9u6Hew2P7/pnJid6XOcd2R7Rc89KLFs5n8eCuTNN?=
 =?us-ascii?Q?q88sn7DVSmC1+WrN9E5sV840GNMUXW7msCelJSh4djYePODTw67VG7Rl9rYl?=
 =?us-ascii?Q?AdLWmCkYJBFreIko1TKcD7YJRJChbAJDUHc97AIaFoNmD7amR1e+dDKj2t7w?=
 =?us-ascii?Q?A/e+1hBuprlbsxbNU991dw0hbAyepvUUfL3YsHlF6HBbMgxPL5ZtM8oh+ewe?=
 =?us-ascii?Q?JidAMwtaoQh3VpqUMcyvXVzQqbi5jreOA4D7e2UEN3IqCWDLuPV3j6/aWwmI?=
 =?us-ascii?Q?X3S1KTAJZmlPI8KddcDnhqDFXnBwkmB4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8Me+kNN7njqe0dK3Q0QZLPsP36vfzEqH7c00desMv8LjF9gBi3yGzLoSERb?=
 =?us-ascii?Q?EBO7M7suqI7sFgpQ22EV17HrcEnObxiL9rolVAk+plRx9A7CZjqwDXEOASAA?=
 =?us-ascii?Q?xjPqNtMyryjY6Z7spjXxAKkXKxs2Fnf3NpMRpQfKhxfveJOuYSSqCcEjh1XP?=
 =?us-ascii?Q?8t2ScZ7sqGCY8oxEkU9Ws1qPEiyiJK5nKvt+MeTG+ky2ShrlgXVrlXUQJKRC?=
 =?us-ascii?Q?ssUZy7E4shhJ7aQ9QHvtoleKcMEPYAaStQDHizKm2ncThTbAGUyT0Nor7H9v?=
 =?us-ascii?Q?kfRA1vpjKKw9LR1x3C1fQxjqvhB+blAEmWq/y4FCgueZM/iT9eBexngNEzCM?=
 =?us-ascii?Q?k22s+3SkNLQ/BClWkmofQDpKIx16cRg1Y59wcFLCLodPuPgvFPOGHm3v/Doo?=
 =?us-ascii?Q?A9BBoQ3RurBWO3LQYIRhDwoUkCo/WMeMF8Z/5bbxzV4jtN2+v/xbQGH1sqsl?=
 =?us-ascii?Q?3yKZo567FCfgahb//uQ3o52YMO3PKCfOsrj3jrl+0yh147ZgNF6WdhAHYa/2?=
 =?us-ascii?Q?99iNV/ybO6xp8SpTwD6UVgb3NQnfHQXedYCkpsIBu9RpS879CaVAVMHAKIUW?=
 =?us-ascii?Q?7il03920Qv2XqaYZbnuC20XGfLrFRtv4VipMGFFHfOPXdBxo0zzdj+OD606S?=
 =?us-ascii?Q?KSRvxojTLEW5UHLWqMLEsN0qck+ObMwrL12a5bE31QCc3Z2+JLxt+EHSP4RH?=
 =?us-ascii?Q?ZqSXV3BjhU5RJsdsFIlj70mlzpg2XxmlEQT5RBwGnD848yb0KKy/8H9tL4Rt?=
 =?us-ascii?Q?LBkf/pzwHNFuyvxb2ALgfsb0tAR2it20MGQZcSXcKkucZyXnNQp+u9AXrNSJ?=
 =?us-ascii?Q?qWOVQEcBuePpGr3QoXmmFF0JdLty7v/6LkqJ19imWL3Ifu+FnIMMySi4AO7Q?=
 =?us-ascii?Q?3i7lM4m+umDpUSOFwGGKg7xSuMHMkyKl/MpCwSnSxx7r+qaApssKm3LAc/fD?=
 =?us-ascii?Q?qsnaoQvNMutbsqdBkGXHz781l8MJKEGvhLAc8Cd/c5pZZ/lgwQp2udLZnMPy?=
 =?us-ascii?Q?adh9GnA0wQQ9jxzaaBOxY0GkWzNgH8TVCPkktokM7x7w0ZxqLWXFDsOo1bJk?=
 =?us-ascii?Q?vyiiPIpwAJP5bGGuVObNcql2t36FGRtgnYAQ7jAiSP05TqC5d6CjRZaL1bm5?=
 =?us-ascii?Q?g2UaokFdyB76i8sVFsXub3smexi35iYkjSXzl3G25ESbflG0IQV5wILjCjyE?=
 =?us-ascii?Q?F5GjJ1/hC7V4xSN5jU6aNPRypX906x0h8E6f9uI/7V1/fudzqpR2t/6xv4te?=
 =?us-ascii?Q?uf9YTvLkJXrzqhWutdPWsLgxVCt/1hFUA6Eeerv6P1g+fvHAQiuurf8gpdZL?=
 =?us-ascii?Q?IlNxDwP7CfOpVlBVffL/xeLFW3it+Tqp46ULPdj654493P55Pp6t0MRiNuWT?=
 =?us-ascii?Q?mULjofJYDiLM+CIChxZHshjuEmJaItCeRLCSOsGWR1/4OI7TQDUEqjC63r7Y?=
 =?us-ascii?Q?dyKvLZND5pJTXuhy8ziECNIXmbFeQoX9oxYPE8QGBxzWtqZjUIieJkDJ+F1S?=
 =?us-ascii?Q?N3Dttp8zIUJrqf4pD24mAVSQWOU0CFA/uo6VXg/SwMMb5bw1ZcWm4xoYypwZ?=
 =?us-ascii?Q?pLHfKlwHCc6q4ZDVlLyzhvgMIhR5CEsyZoUMXK2xKQyVoL/Ru6S3laOl4Cki?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FX+SUTOqhBCd24fX3kQHITOWQ5iKvD9ShzQCG/cH92TIMdCOikJlk6xoN4N4VLwdS25WYsjQ3bBC/nGP+HspGvD6Wd2LvYxcIkMk5wWeHH6uXSk/CPOK/I/4GA3ee3dkeQDQIJvyFIJGUeY4s7dfxa5Vk+GVAMtKoAIIgSFbndN69FMRdk0p5k1W8D65uOQB7A1Ng/d45MgkDqPA8NsussttUpi8C9/cMcHFadKlboLjzvFUkYxNobcBQsyaGgsI3422ZWmMYe1AtCYkB2LlO48wcrsRmp+1Zyz/znV5dnG7zHjgL4Iyz0tv2xB40+b3lVPasrG4nE064EclhKrubM8keJH4C70zx9VA0VlbWr0rWEqcLXVYt+/M3ViEcHDVuZw0n0JmdTVWtLFpVB4TZaaEYQXXqTcvHxquVilcLhItpQgzWQrxJ9VeDjx/q7qLb75yTjyJSyvgizK92rex/VvaLEVr80vC1xIrBLd22LzfnHmHOoehlXnDFdMJlm+5tw6RBMpyHhBhQMWPWLIId6GV7XFXgwnJ63+CcTbAVxymrCdxnLevl6fRKIqmyYI79B5X0J3Z4EZi3RDPnfLNa2IhtuP1k1oOubCYPn9Y2eI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcbd2a9-781c-4e75-20f4-08de28124771
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:53:30.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnH8sqfSmbWzYbsoHohdajAqlM2z9CtGbP4SWpAgJIqUap/yT27MGqqDTJWmAG0ABW6t4jTZaHUkB+jGl7CQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200052
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+4IcZFDMi6Q6
 qsGTGfzKo9GkCJpQLJQXuZdO7NR/uiuPgZnMga/SImklKvPBsfyP4oGjujFUyqJOICOtUFh0FJl
 IAep8FVD8yrZL80TF0Wq43FiOkv/GaXONlZDeGphu31Zi2xngrIXNdM8GR+z9C+QKRva+k2WTTw
 pd/XgpnRNMub8CpHUTz9FiCgzMb+3AV6l5bb5wRNROXrOBKD5EZ0SKOMw7phTwWjcQIQMjF2e62
 ymPfrIeUL/e2bLr99wlNGNXuKTaZoaMnkxYe6HXWsG7Bc3UR6WcnE0yff9P0hmYTUAryq1M1ElK
 O/+w0YArF4romat5CdytquvkRh3X845x4tHSNQEZwabeTBZ70v8MLTdRBkW53yp2kpJemCCD4kj
 fKmf1/pjUoGGHig2Bj0+2sW5XSrLcw==
X-Proofpoint-GUID: Ik8NE6z6Yz_RsWE4lxTveUJkn70eEuQe
X-Proofpoint-ORIG-GUID: Ik8NE6z6Yz_RsWE4lxTveUJkn70eEuQe
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691ed70e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=QS2uWFhkPXxkyW2GHEwA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10

On Tue, Oct 28, 2025 at 09:58:29PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding memory
> cgroup. To ensure safety, it will only be appropriate to hold the rcu read
> lock or acquire a reference to the memory cgroup returned by
> folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard against
> the release of the memory cgroup in folio_split_queue_lock{_irqsave}().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Yeah, once we acquire the split-queue lock, the split queue won't
disappear under us because the reparenting logic also takes the same
lock before reparenting.

-- 
Cheers,
Harry / Hyeonggon

