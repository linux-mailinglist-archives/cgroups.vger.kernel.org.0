Return-Path: <cgroups+bounces-12082-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4803C6D59E
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 09:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36FD035BF62
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 08:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15E2F690B;
	Wed, 19 Nov 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nBm8tl8j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uucuwrra"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B1280339;
	Wed, 19 Nov 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539632; cv=fail; b=bVJtHX8zTeIXZbbsnAOZDui6+McvgFm98/LNk5desh3R+01r1KQvugGyWwW1r6ZApXlnFJTknxOM+FSwEP+NeujGjEVKug//TEOd4XdQa5g6HoPW5cpkmfcP8bAIM+DP3up4W4hjooMKU9YaaP1U9MP7JDdKrQ0yESMC4EygNO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539632; c=relaxed/simple;
	bh=PBixiLCnZO+HPhEivNnOnKsCbfXU45Y0FibwzBMJJIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IkpufCiJGMYBmhmrt5M9ZiqDSVH8sFnV8JOl/QGwj99+uGZl14/ZO5CU+Je1qOA/+xTM8uAMXRX7FPX8sr3Wi0d3gKreGYkWT6ckfK2iv/trcLTx+pneaejVboPmDPyiDr01eKy986OWQ5nr+XwV4rmePgim2NZ3hXHR4NnlM/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nBm8tl8j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uucuwrra; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AILNkA2000987;
	Wed, 19 Nov 2025 08:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=60OHn5X9coADUR2wvZ
	t16XCVjTPpSEFUEbaer7ktAW8=; b=nBm8tl8jxiCBYexeMvSbr3BLUWkxcKbZQN
	D9tZ0bRT8vWnkfF6/e7zXS2DBnetE7N6fPU2O6koit/oVzSqQTcVGaBysayuY0f/
	Escab3b9quSjnh8lE10UpaQyQ12VI4tBLPiG3nFUHPZBwNN9c8bN8exvg+be/NEA
	Wbb390q7eVgULx8l6a0bqt1ss6kinQMjQoGiYGRhuAn3Mc9gqSt3qBTZIwezZ6Gq
	oMueCCi7sdeZwt6JsPjelrWC0SSNBx0QO07OgQw2BKtQywV33OC+Q5peumj8L1Bw
	X1jMjaieWfzrmZ6uAuwfbcNq0rqIC31sMWwneQGhRE1CQtmWqQRw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1efjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 08:06:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ6UKJu002414;
	Wed, 19 Nov 2025 08:06:19 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefya8tjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 08:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUfNX1ur0WpjIZ2SkdmKwoS5EbA7bU6J2D38XDel/Q81HqGh9rNgneAqzqjwEib2eXiN1i3GU0SVpj8OFYfzW8QCo3ExjGLWojA1CEwpjXZqmxRFVH2ChgSkgKyWAVftZqNyCNQKbsYM1/ad5OtJiLyr1FWhGNTw9I2fty2Ai5HmKwx8nIIFseUe0+BIMdQBqGDESWRWdjXik7AFy11BPX+7Ykut2v93h/DPw+mU7gnWD5QZJen1BYY1rVNtnL9cD47ouqJTHo0fE3iiKHoK/sA1XYLIF6g9tglP2iBy2/yu8YBc/Fz3aHiNDAaI4rR8XTDn7n9GBGhTq5LvTZS5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60OHn5X9coADUR2wvZt16XCVjTPpSEFUEbaer7ktAW8=;
 b=xQ05522UOGW6hYKtnq0DROhX13E74zj6NPbasqTAW4AOVV7n+dn857laqqoUzT6zl/XIGOweAvwb2lmM5hWMnQSR/6KLUGQnvNC1zrPnE9CaFmNxBv5ze0u/aujlltDwxxtkix8o2mrDnjXB/L1eE1SRjvsW997t8ji5gvyfHFFKZHfNzlZydswUWyH6clhgCa7e2pLJNht2eAACOjr5Vx0vG3EtZwJWR4fM1vzjRo6MSXCVB44S+ycPARRdIJiXol/JmP9YV4EXXvrJy+J6IlISNLeNjIEtb3QFL5OJ4QiWJMnynrpv/dYkoYNHZ1mE/Gm3afGc40AJqC57IFFxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60OHn5X9coADUR2wvZt16XCVjTPpSEFUEbaer7ktAW8=;
 b=uucuwrraF8gf0XWKbMzbzH0K51q2R4f5AN0oiBUErbqD2YkoVBvElbE9npIItN6ExBS5RNJblHcTx+yCBGicMBLtERSTT2e0EhSvsmu84iVz9c96o3y1QsIVFCHX0IZk4aQ/VfLhHyjWOJqup7+rGkg+xxqKqLcI3yaIwTbgqM8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB6542.namprd10.prod.outlook.com (2603:10b6:806:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:06:15 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 08:06:15 +0000
Date: Wed, 19 Nov 2025 17:06:04 +0900
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
Subject: Re: [PATCH v1 07/26] mm: memcontrol: prevent memory cgroup release
 in get_mem_cgroup_from_folio()
Message-ID: <aR16bLuvj-W0AAM1@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <9eca65dec044d4352bee84511fb58960a1402ddf.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eca65dec044d4352bee84511fb58960a1402ddf.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0132.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ce37e6-45d7-4cac-bd6c-08de274282d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fpS2DnhdkYA3QBJ2kzBR1sveghlCq5lSWDqaeztavyyY9U7ANC29dzhe/Dcl?=
 =?us-ascii?Q?NjKfy2BtXW24ocWGCj/tgKGlOCS1/MR8fSEcWPCrnPv9clt1SgsdYnHYzFQW?=
 =?us-ascii?Q?6iXFKzn0VKG0Bj5NWqMijmq0uD50QDWgCImEQMEIMlvBsGH2iBFOnWHv8KVY?=
 =?us-ascii?Q?S6vUTI0J/Caq5Jhw7cWJVRb+TxURnZvDynbU51p6dB/dNspJCJbl4ALoUm1a?=
 =?us-ascii?Q?MGtv7OTQ+uomFxAhQkR1XqsfqzfiRTpV+06ELwv3kO0slQQV3wekhq/vV0f+?=
 =?us-ascii?Q?UEgMKT1eDoMNXff4O2mgLqb8iqirynFTTGl+FDiun43NpqGioZyJYn+vgNrK?=
 =?us-ascii?Q?DnLtDseiSrbvGWfPA80Ete9cWw4tt0ZBTcfbhJx3ZRCd24tJ0s1vlvVlLQHk?=
 =?us-ascii?Q?vlONx+6uKnEMbh8GcAPt8ZHpCXasMBBazOv1NDqMqdt8GPcBnIbFHAzxTOJx?=
 =?us-ascii?Q?9n20XFrkRSy2GxSiqXF213UVUvUQrlAjCLvDAdqx8P2MD4Fx9DMzO3ZTM7U6?=
 =?us-ascii?Q?Bw+DI2NAK/9Sx/aGI3rToTJgVCjAuetEG0zeyIKSbZyhHwQoyEwm04vAsVeY?=
 =?us-ascii?Q?3JJM0hbxr3GIoBgEUYO8E3qzliCAx2ZPSNPoOZkaVqQ6C0uQES2wb/p03Vlp?=
 =?us-ascii?Q?NBcjp6FZ66pAjCbjxGKSFxHXLwd4HtKS2ENY84rHrKFH3Cmzg3783pFwKMYe?=
 =?us-ascii?Q?Zc/n+H9mxAI5s4QQ3+iAtbwBt8S0F4sfQ8YF//8lCRxOfyBgYQsFJsfNlzQG?=
 =?us-ascii?Q?R92fNRN7menSJdsykC7QxFcJg3bWxOQ9AZ7Jfu2CGAFgWcPEZzxFpSKOwZtY?=
 =?us-ascii?Q?nGox7vhbbWFgGnJXG5oESqQmTfuREjrZ9f+q/+6Iz9ERVn4J7cTNl9UVFhwK?=
 =?us-ascii?Q?CRFoez4G9NSPFZqJGAhuFOZAcTa+M1AKssZ5hPp1V34dcpTFxJv6nQgc9q9F?=
 =?us-ascii?Q?S5B/DLQEQGFSUc5d8qTg652+c110SZdMHEveY8MVLUbUBfGG4tWFREbWo72G?=
 =?us-ascii?Q?swyAfSgrLabqPDgCq1gEGRNj9NcEJoJ14D8j7197IpV3AywOvOdIQuO7GaBm?=
 =?us-ascii?Q?7Ue2zQ26JFPK1pitUzNIB+MqQews3htt+h1Ienf+sYB2wpkwm9n8iaZZift1?=
 =?us-ascii?Q?Iv4oucCiCbK/8OTkOG2G2xX1haB2J5w4KY3MBIueFKssFQroBTnvR0mxx2xV?=
 =?us-ascii?Q?gj6UA1gWVTjqffVgXnYPNXmzEksa+qiCyZiY8j1yKlZNTRdqffkTo0rgzImA?=
 =?us-ascii?Q?98VdUA/h09FVQritIeZM2QNyh5X5DceDprJd+2OxfdMlgm+o5YBF3khV3D69?=
 =?us-ascii?Q?+6sNDyKQ+SGhle7L57AL9a81E1Ml39YnhjiPFnSXoDQg6iYCWD9rseKNm06o?=
 =?us-ascii?Q?3AlQ3eqX5ZtF4LKFFyPdjCUr5u1b5LieBlI7rUD1kOLVbT3PXRuI1VOFj+EJ?=
 =?us-ascii?Q?YoaJrDwEkJfMOyNGwgXNmXNmNBXw+cYa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aUP7DC+xYbO8S4CB5ACRMm2pzfuonvLxkXduUo6zvrJpYN5bsHdEAPakyZZY?=
 =?us-ascii?Q?o2K42JNpO0Kl9i+YNKDUzQ/ATNUpR8vGm0pVm5RrVTNPqetP2BK22gF3Rxxg?=
 =?us-ascii?Q?0IgIuXyJ03YBf1ZILR+PEBX5us4zhzqLFQ0pnAn4KPbvZIwWDNHN/4GJnYW+?=
 =?us-ascii?Q?68ADyZq40/G7yNBXOZ11ROLjvz3i5ygfTw8tQx0WMMyRkIQlG6ChWhV5/OyS?=
 =?us-ascii?Q?5ZMs+SjD/zC703wwgXbYwRbZXOTgtBqGzkyJjfoFC3QmGueDoX1NtnGvd4PJ?=
 =?us-ascii?Q?t3tLDBJSQUx4xGS4pFx58uLhua810FWKhc+PUL82ASp/RXygvXEsSOXHVAaA?=
 =?us-ascii?Q?aVCsJcyvgmpupEXs6GNkYhRJo+t/rMxXE2QsK338R2/ILp/s2lymrhQkbCEm?=
 =?us-ascii?Q?40VHWcyQZa9kGi+Ry1CT5005pGmk1ccrjM2qpuScESCT1GcXJ2v4K/N9sFyf?=
 =?us-ascii?Q?Z4CBzSC3IhxRg/nTHD2dfK5+tAqgncHstV0z1JVszhNEXc8evkFe/8embonM?=
 =?us-ascii?Q?H72fLNRc2+xQpK/vHS1StSe8eih0H9uFSAv0h0Qtqz3JT0ZyzYXvyr0pmely?=
 =?us-ascii?Q?mNfnNVd0NNZJsfBaw4jV5DKpzUlS47XPD4Lld8oTA1bpLOmk+8ZETnV0F1Hi?=
 =?us-ascii?Q?SeMTfKHm+7EPlTFFvQn+trCuTKZmMdx3h7b96TSdFB/lG6IZhsDDFv8nOFJt?=
 =?us-ascii?Q?BAEdXFcy/vCjVZjtusp3iLoY/eLcZJQl3t0AHI+igogQ7TeTefhuoS5aIN6O?=
 =?us-ascii?Q?aCOaB5EUC/CpC1srAChK0Dg0RNRZ1DWdCOTiwkSwPuLTzHdAeVkZRI8giy22?=
 =?us-ascii?Q?xG3222g9EEuG/qnu+52G2vtgLberEwSR3i5h3etMcmZSVx2VGKG2caoNBSaR?=
 =?us-ascii?Q?NEoNoZR5+vF7a8AWhWvj3N6DpGmc9IOTxPAaO8xhsSm5px5ZTo3xVZ6Lz4T/?=
 =?us-ascii?Q?7NVsruqr9yzQp2qANUa97wVzpEy4pY+8XKa1HrgCP4b3YX9W7IFV1iPN/1fZ?=
 =?us-ascii?Q?7JQer1d0FS9krTTAjc5ZIa+5/64T3WmV3AWlqccSZGDGoA3obuel6e9vi3MK?=
 =?us-ascii?Q?uWzZylsLgvhqx/sQQr4rgMV/GPINMh2zcc9dLejDXIuilrd57n8Ar1Z+5vYv?=
 =?us-ascii?Q?nV3+T6lj631shkqGdDE5LdCWEzUtqAdnpNfzDc3pXzXoPwrrk63ytsO/4lhD?=
 =?us-ascii?Q?HCaYXu7BtegDEn1BVacc1rU6eMKDlGQautLJCcAFvo5FxSH9oiQuWPiwZzeG?=
 =?us-ascii?Q?nAnP380AjnFu24fAwonICtvuZambjnyttwx6i4AJ1GdTsAGNyYuNBtw5ZIiF?=
 =?us-ascii?Q?ZZIQTrCf1bgDSm8ieSPNy53GiNPxKL+XV6IFE/1xXhGUmiiDHpW87wcEbpMg?=
 =?us-ascii?Q?3Xtn7oONCe0ZLZDo+Icu7wBab71oXbriKvIF+QRQT2LCiTny319ZiFM5hVlh?=
 =?us-ascii?Q?3ViR7MopFCh9ToZZqMVHykJBHiDRgS4ChI2Qj5GHAucRrZy9XGB9ocLOcawV?=
 =?us-ascii?Q?YgTkOjzXWQFz4hlmFB2VB4nxT5EyxmQYf9V8f2qQgDAitvzJ2bEfmHy4yiGh?=
 =?us-ascii?Q?mVvhl93OF3UjjqqwysiSbTg7ILlzSASWgaxkyVBR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vSC86m5sPztSMl0jeSrPGisQKpVdLGVjujkkSddro0wqaX8pznojCaMBZXjmT1sOg8iXryFMAC/xlzarWGTpq0lSQQEM78T5CdaYHLO4poHdvyv2+VSIfOAwYaHxepwOeAYMd+RsMPg/YtO0rGzP5D0D76jdtCUuaQg7WQ+f7Rg2RQ07OwnsNhk8PQABD+BpTTpD7EnQG1EkMDKDM9DcLy7HSMQ1bvQbdPm9DdVAIY0xPHvKol2l+B5kmcK3I6OFQI3t9AHbQ9jvJeNFY8I80jOKJVtNg+U4KUH0KfWOdpz4/QQWiU3LevdvB72R7fbDUYolI1seDRGdSIjBdx0wqiF8WW6UsjaWqKWWYaVewBcaCulxDuMyYBzDZbJgTk2WCiGHKnzZSXnoZhNv+BaoAnPAO1TDYVoOvSHX7uXH1dN3Us0x6wXv8HE1rW28+yynYmhFdWJovm/6jX8tmGgLDHiGOH4U5nAnt6Y4HwpnrXf6GoDCDVm72vwS172J6MaapidGYFs4pC+FckjmhchuPBQ9jkkVoI+GVHqR1ohMh8zUpYLOMoG+XPIh2S/AQRZqwkNS0Mt5nyGE4QgXHBlOjE0m1aty0St/pEgHijwANzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ce37e6-45d7-4cac-bd6c-08de274282d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:06:15.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1XmdTCdpLDU4BpCVJSrYXfZBJjYYrFAtNYwPpiWWiRng2yy94z/CfULajx83kkRUOxoY4rWo3PYRjouIUgMYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190062
X-Proofpoint-GUID: S93C2zN3cLFbRx7nL9w4pRM21niLJkAG
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691d7a7c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=LDjQ5iJgGQJlDgXJjzYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXxuKt+8f/mHJB
 tJrySC1lXAL5MyGWrEiLDU7h7KC6X/Gv564XMKfuzQtnUoYWfjiubCoZ6mwXDISolTFUsxTY6bf
 sVygQB79yTQxli2e9IOzq3cz/Rf2hqZVvJdY9taeJN5vAsmpeF19L0mJ4X+BrulWHl8jp55bsda
 u3JnK2fdVkfUiHLfAeUgyh23AItOGaO8Whz7b5rmwsAfR3ALpg0FBzTuu/CaZBiMi1XK3DsCb0/
 xXd7Ot5vSH51ZsOlbc/Npx9JqTYXdD1i9SCRS6ih516W9cpyAhJg0f15wV4x/AZSD/CFpESjdGR
 LCh2a2hS6eB2E/zF3YnNCZV3pptcMmjzCEvyrMwDnhoNs7vYFHeF1MYh0joTE5oo3wx7kky/8od
 kNVNwpB5H2LEptNcH8d6tip98+QfVw==
X-Proofpoint-ORIG-GUID: S93C2zN3cLFbRx7nL9w4pRM21niLJkAG

On Tue, Oct 28, 2025 at 09:58:20PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in get_mem_cgroup_from_folio().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

This patch looks correct to me, so:
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

with a few side question on current implementation rather than
this change...

>  mm/memcontrol.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d484b632c790f..1da3ad77054d3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -973,14 +973,19 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
>   */
>  struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
>  {
> -	struct mem_cgroup *memcg = folio_memcg(folio);
> +	struct mem_cgroup *memcg;
>  
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> +	if (!folio_memcg_charged(folio))
> +		return root_mem_cgroup;
> +
>  	rcu_read_lock();
> -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))

I have no idea why we're already calling rcu_read_lock() when a folio pins
the memcg :)

> -		memcg = root_mem_cgroup;
> +retry:
> +	memcg = folio_memcg(folio);
> +	if (unlikely(!css_tryget(&memcg->css)))
> +		goto retry;
>  	rcu_read_unlock();
>  	return memcg;
>  }
> -- 
> 2.20.1

-- 
Cheers,
Harry / Hyeonggon

