Return-Path: <cgroups+bounces-13055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86611D10B33
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 07:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84461301EA01
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E4430F818;
	Mon, 12 Jan 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GYgYuLKc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dQy3nPCk"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50052652B0;
	Mon, 12 Jan 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199353; cv=fail; b=YOwoSIMCHNfQcA5FFMhPazZs/LYrk6+5QEIVSQqdLyVLM4cRfPVZ3hNWwkv4O7MW6mPkWfJqL+JRPKl/eQDcyP+SVj83wJ6RGZuMO9GjNhO6Pjur0KiMeCfy4ihbBNaSqXtj9pTFmtKBMZH8m97q0SFCdy+MmSi40AHPnhFvUEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199353; c=relaxed/simple;
	bh=9jzRE4F1bN/l1UjMGrUFlTNRuNkX/REAio+c2QBBxO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MxpcVzrQBwI2pZKjRZwDby6QYbPrTOzZJJVBVshtEuZAoQpu4JBldilSInVPiD8NGbwXgnobCjFM/71PsJA2XnNW5N+1UoXnHsIVMJyFn0aHZsXpshKdUJLVt3k9MeULRM+x94C8Os4rSOEZ98bMqDehy1PQRv/WOtwFJolo8ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GYgYuLKc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dQy3nPCk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNam4F4045684;
	Mon, 12 Jan 2026 06:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Z1BzBlB7+Y76Ph+SGL
	BK1kg6q0QSQAjybyyJ1MUfNac=; b=GYgYuLKczLHS4yE/VIzXCok5hrRYKvQqeY
	7MRCN/jGtpGi5BmBOslEWeFd5kf4iLhTH/Yh9LMxrUaEsMaNuqz6JkRam7+QQVcH
	uovif+x5Zeq3rdrP13/E8RHEuuky/k1PPoXArZB6hFGVul0e9bJcHn3rY6J+7rQP
	kXZxrOqR1lKOhBquA/3oXW6FAvOFjpSXqun/1kCHQDrw3eOFwByrMI7/ik86iso1
	uOHujGDwryzlQN9lzcueZRYnuRC4BhIDuSTVBK2Gmk7186sgwFNh4G/LH/7OaYMG
	yvKbO2rL7i1IsYnYSBo8wDC6r0DYyQyKGDGiqMJoKOgboBa9z09A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3s37g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 06:28:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60C3FtBE029119;
	Mon, 12 Jan 2026 06:28:29 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7gswwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 06:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wroLqf7J3sZ5Bc6ezvC5jne6ZzFbJOFz3nhQyEsrJwW0Huo3rN3o6jVO3J5hVsLgZyOgQ+zPJD3vR7oJjSvOae0uBLz2YZe2+FU2T+B2RccXYvUCjp7FPTl7kl1A5FHZZH2u9oYTTDEUPjwVZ4fEg4gRO6waC58nE3pmxA9nCuBhc7umKKw/h7ZLqURWtA4xcrtPVbwwRljyBPDN8xrBxjjGmjlGOo6pQ6jRJ1iNAP+ZU6sxIlf7sbOCPiyuH5VY2p28ZlGh/ezA3IGaKeJFBDUILk7CPp26cMFWQz+Tw2ZaGPVvglMS/qcXrHIj7A0417V7/XexQBle71LSS4hCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1BzBlB7+Y76Ph+SGLBK1kg6q0QSQAjybyyJ1MUfNac=;
 b=nDnVYKC0AjLHd6wyxfJklUvmYXywM5fETp55X5HgtmyZWt0foAM2kImN9U/OeHtXmh6NLRbJ60AqlZTOcBJ3GA6sA8XzvYexpXImK1c7KkT1xcvh3WZLZLsCcL+/tpXq+jgZxpjdGb/5PUUr59QAcJjLOb78z5Aqwl5b55BzTzIspndXEhWDVwmtkAdlpHVqtYXaW+MDEoRHmq+gVIDer3kWQxDnz56UxtnmPdnzyaUzmFVAnrkFAqBCYmn/FNsifVfMzh7UarPyb7HTXPrHiroaU/1WreT+gXn+8JuWVX2DtMAo2OeDSh5KzKOtYKRet/2UDZ+geBpi4PitScEIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1BzBlB7+Y76Ph+SGLBK1kg6q0QSQAjybyyJ1MUfNac=;
 b=dQy3nPCk6sHZ5ILuEY0YVSqT/kfELLb/1uEYsCsCqQwvv+bnPpci8BEmAtrO7ZIj/ffa21STeGuc1zpSCwMLuYCuAP7LpQ9wULlYkB8Vsm3Oh1hFXzI2FJwoOBv3mbSBQThXJac4upBVVb+9q9LkYFfAQeTQVkqqi+RtpCgDKWk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB6422.namprd10.prod.outlook.com (2603:10b6:a03:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Mon, 12 Jan
 2026 06:28:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 06:28:25 +0000
Date: Mon, 12 Jan 2026 15:28:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@gentwo.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH V5 1/8] mm/slab: use unsigned long for orig_size to
 ensure proper metadata align
Message-ID: <aWSUgKO4eGpodV1j@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-2-harry.yoo@oracle.com>
 <CAG_fn=XCx9-uYOhRQXTde7ud=H9kwM_Sf3ZjHQd9hfYDspzeOA@mail.gmail.com>
 <aWBfZ4ga9HQ8L8KM@hyeyoo>
 <CAG_fn=Wyw-fGGQ802A1cUpkHHTnZi5gN7wZzRaF1s31SPOpC9g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Wyw-fGGQ802A1cUpkHHTnZi5gN7wZzRaF1s31SPOpC9g@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0107.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2b9b59-cad9-4655-90ff-08de51a3ca51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XR2HYNagdPW20wEWSLLeVspV/on6KGYTao1hkHnbixSnviVKnQUD9wlAoTaQ?=
 =?us-ascii?Q?cueGzdFbcMuM267eu3z88f4ed39Gflj1x8Cmy0mHrWmm/i8wP0FzNxUo4q65?=
 =?us-ascii?Q?LuRmleOP6PLsc5fAN+lNFr6NKXl/ie283poTLJFsNeDQN2DMwG3vnKWPyfIg?=
 =?us-ascii?Q?Er2rme7NdUTLAVbxCpqIDPeWXJg9WkmX/+8/iCLmtoCbL5KCK6ixUfzmnaq3?=
 =?us-ascii?Q?U/f2Q3gx2o9h1cNMYv19SKxFEIOHm49jP33ZsfNaDe3TpPj6/GbG68PxL9En?=
 =?us-ascii?Q?uv622pnIIjxCNmKmKcGQV4uLqBff4fyXyTTh0WQvFdNQYY+d6+h1yg9AncOB?=
 =?us-ascii?Q?3PwngJX4Kz7EtM6Yti0h0GnEmRV9n2+8xQ1G/JeBaLzRVKPHOvtO4dPehf9Z?=
 =?us-ascii?Q?kVmCYg3gFIc9MQUtFQrF1lMpBr/26Qii7fTxmfYO7EliRYyonx7hSiCNvHR4?=
 =?us-ascii?Q?g8w0fuz9y/7e8zIZMZJNzTGKgr1u5iJTO0NF/0Ihac60qCznlPc3WjYqqGyH?=
 =?us-ascii?Q?HyhXHH/J83NVlTx2tnz6/0+rOnTBFQa9rhECJfeQ9BuXRw+932lw5YeZ1eyy?=
 =?us-ascii?Q?2R0bWo0XyYAG65wlLPTkL1FS1UA9aoqNxqZoFASbF2qjr39kTvqOetyYU2hX?=
 =?us-ascii?Q?G3Td9raDKLvF98yTYToJGO5yw2mriFeGTuS9cr2s7gneAAIm9e6cPFGn/gfQ?=
 =?us-ascii?Q?uuRepj4EHBR9HJK/uKloMX8USLA5JcZV3jeblGPW7U0/S6QSAXgqwFJjNwjY?=
 =?us-ascii?Q?8k/6lx+nxRxVKYOXGcUoOgnrhYzw01DLVippPsIuLQLZhUVutM8UTAMSXp9f?=
 =?us-ascii?Q?NlOMMvjs4ktibn4uCqxCZAOSATHm1o0xiPju5JQbiO/RCoWLtyvrzAk7LWvE?=
 =?us-ascii?Q?tv0FcNbS2fgkZwhaM2Ff60N5k/GtbQUSQDDh4q4Fxv+yvJeSmVLXx4Li+l55?=
 =?us-ascii?Q?mT/BuELRcaDJwdMAhm79jRX29wsp9SBavIycPOX25ktLJFgrx/GUazjH5SoK?=
 =?us-ascii?Q?efj0n54hl8rUP7qUx2EjvBv7rCMHA6iJhKlPgL21Y8Hlyiy9eNnlBqh5oNlj?=
 =?us-ascii?Q?fLmnaHksp/1uZs4W86ErsJJFQB6TsC9JsYuEgkpn/BNVe7FgtR7/PiYagPlE?=
 =?us-ascii?Q?H1KTaNoynrZvexJMdD0CFtNZRNuK1AiNMtDdnefZsqer88Z2Dwv0uIHK8S0I?=
 =?us-ascii?Q?/O/X3OXwec8QoLIisbv60TrBWGhdwJJ71xS4HvSMNumzuBv9s+nB00dipPSn?=
 =?us-ascii?Q?VRqBHkdBlGw1VJxd9tZhcdvoFy+VRYO5eoSEM0YAPCvGBRFPt5NH34fevScN?=
 =?us-ascii?Q?iPoETS0lq4FBXzq5gN0dypCexmaKI8GuKIkfM1oCLWpsUwtMpeW7CLKtxJkd?=
 =?us-ascii?Q?o35V4dTLHbOu9nsju1qwlR4TaQ7X/mY8q+NovbHqgnRX05iqwjz1NHV/9+cW?=
 =?us-ascii?Q?PhEluFXWsfRJshxPYYXUYk1ZzM/wvnIp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1N7nu4FqftFCb3I+iAOkcMuZOs7CZjdNM8oZwNcQwPilyb9Yt7Y9N5oPAzCk?=
 =?us-ascii?Q?jxW0uY1ppnjhYwbt4QemSjeVyiYcQqy5M7xqQOCXd7b5lOYboJV53VfZtZ7j?=
 =?us-ascii?Q?6ryv2VU3rV9yZ/lRHMmlHyieagUOiIrbh8X7tHvEBJINXfO3w/BoaRcos0b6?=
 =?us-ascii?Q?zuoC60RjlBk0o0eDGSVYnLlpx3QBCiFt/hsFgqOXWDpkSqXWL6jWZ7e4eRhL?=
 =?us-ascii?Q?rBDnUiy/hStxBE/z3uxIQb0n0zQIPeNsIPzXJPgy52bMxTTrkdd6vAPhDcHT?=
 =?us-ascii?Q?mancg2Sey4+mlxxj0mk9RPZT2dpfyGmjJW5eDGB8ORfvhNXlsbOJS7gypJGs?=
 =?us-ascii?Q?WVp0y3HUFVbxHfDGATbuVarq2miwpUGdklP0XVCOG2myA28yaxMRncjo25Ze?=
 =?us-ascii?Q?MUjmVlCgB/usRSQHqaOAOkRmZ1wQpDe6Cj+1ymq5dRsZ8wl51Ieek6pJwERz?=
 =?us-ascii?Q?Mzc24DCV/TeUQLKANaeB8U9h4LW0g/1/EaKl79I0jxvHJuFjJf24DKsSSo+R?=
 =?us-ascii?Q?ufpalkdNeSzlzpuMnNc9/deG0lMHB5joW0PYTCVW6mBvR8+/lOQY6nbZD2Zl?=
 =?us-ascii?Q?StV4k9UHxYrdtqSxC6Ead3B1BOuOmYqhq0Gtmu3shvWfy+TZotUX/nMJiH1u?=
 =?us-ascii?Q?ncSAqQcuBjhLr8r3TMmO0zrmrwKeQ2ukdVljWNxX6HYGW4U1rAQ7j9snRl4e?=
 =?us-ascii?Q?ZH1KeJE7q8DuN+6/fCJcw66LbkYmlxSIX2SUoDgv2wRIKr5/n6GTkqssxDak?=
 =?us-ascii?Q?EoyD1ylSAd0UhHrv4cbYU72UuazYAN0Ia16hJ5ssm38iH0P2pSfWDRl9TKo2?=
 =?us-ascii?Q?7nzVCu0d+wEZ5LkhyToTQ2SiO+TdUrUfM8FoSAujjqguMR1tjQ647kAsGQlO?=
 =?us-ascii?Q?JrEc8FhW5tXTQCvAMwnSnx4HhlDIcoskHfJntAJ7hBHsNc7CSjRhl++XCwJ+?=
 =?us-ascii?Q?7zoGlRQESnOBztciMSs6pM8wVRTuMDPy4Xf3z1mnp4wmx4yBx3Fk8/8jvmdr?=
 =?us-ascii?Q?S7IT06bFy+o14g27h+aAzIwL0nBzsFVrNo0iGCtre7gneKHBMBuOV4XYCn87?=
 =?us-ascii?Q?bpHs4sF2RSrerMJtfEPVbAYVAc+K2XHSFNkzLpOFxhfPOo7FXeToho73YuPe?=
 =?us-ascii?Q?ge0CUYPSkqDqdPfxuO6PfIyXomrAeM7oIy7gNPSMZoMoaeZaoYBZKU5aJAHK?=
 =?us-ascii?Q?C49qXVfMRdJt0igh+pxbQ3lTeuz1jF8YU6KZ4/k9adOImkiWZrhuQQfZW+Yo?=
 =?us-ascii?Q?rMxEWV8k9nzzxxC+6uljrtEuvNb2l40bi1IWS3OL82AhaGuX64Zc6vmHrX3F?=
 =?us-ascii?Q?6YR74uzlRqzj5syASpeuuIqOOFOZdt6oxd3/fDjqV1Jhb6WVMkIvmk8jbYZf?=
 =?us-ascii?Q?F4KaTDcZTecXXWNKWGCaLOhXtDAokIm3MmVk5IwyJEWGpeU9xMpQ3z85PkHf?=
 =?us-ascii?Q?HUCRknHAln4YAcIjNVcTo0wZ7SHKU76FFg6qSDt7PWtcuctuvaCbJx14YdTS?=
 =?us-ascii?Q?xlxx2FgUJYFw6UBdHSc2y5HaHwVltsNejAxO/fqu0v7DukFnsNaaEP7dSZ4O?=
 =?us-ascii?Q?/3JfmnoEpafq4HxnNC4ZYUH0mp7k1u9pcUPk/UCMCWbONMiwnZVMV64N8jDw?=
 =?us-ascii?Q?ehmTJMaAGBiEkOs8vBrmdYLv0UpKJbGQs4FxC7wS4tqJiZ+x28CFlpzv6HoZ?=
 =?us-ascii?Q?J/mjtR1ggE3s00wv/A5kdKHAHw9E/ueDaxKIBJ6z2PFPzQo+hgFIpgGIGPUt?=
 =?us-ascii?Q?wbvr8zuIhw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PTmI+bOHr0vQeZzrXb679TVvfEUVHxWG19qhhapNth2e+YSkNnOkrbUcghLnIZtjUL2yjNyNYega+b+qBZhXWwxr/OwBEYzC+hNYNuZ8VCxm1/uJTmyY0qmGyvS05RIZiZvMHIAxRAfsNRN9kxzMQ99r9qkeBp7Y3niUOy4U5x/HJpFg32Z2sLRr5uS+/RSDpySzE8CbCmrC00X4QWRY65nl2EvXL+Wp23KyvmA21UZFhbgBTV+7Z1lF7IEqHo57dad8+EHhUYLnwDSr3s27XPNAzYNXwaXzz96rVxzUXPMcUAr+/aYGLS8VSSGx8v52EvoYkOGJE5MKzQKLPw4GWpB8RjToG21ZL9xJ5Os++qKesvCWBm2r7wjmCYKFaaksT1whkK2yMmkNtImrghysOtDwP2lpmoym7xORXyJmE89TEphhoaDeO9qgqZa6OWEMrKfs1AL6DK2OhLzxrZWRqDd/0xNgNpSUOFYjS/moOPnK+3ofVAE+YJsUuh2YePMuUrJ07dHmUaRzo8KgbKf78l51u0EayXzS4MGd2J2Cc7Bkniuc63JGULepDemdvl0+6m32MCiVdeQe1xqx1Hzs71KjfZOKxj6vJmzoYhYBH3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2b9b59-cad9-4655-90ff-08de51a3ca51
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 06:28:25.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MFSdTsAoKTBzb+Uouzp51Hk+R+yQjCh7/ul9QJzXseRo0hE33KqTlotCwZZWopZgER667/5huhUCItBbFjAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=699 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601120049
X-Proofpoint-ORIG-GUID: 0QdYyRkyN0Jhz0wUAaJgDOR4YGHCPhsD
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=6964948e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mJSlRs6pD3Wfz44BQ9gA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA0OSBTYWx0ZWRfX5/tva7pI9OST
 5a1/2lCB/1Rv3MpAeoSxAzV3HSaFGlrEpLQSOi0UAZd7A9BppHCULp9p0jAT4cLlNaSjGHg8Q5E
 OPkOrSiFlMVHlFW/oyvSUsj2ek0X7U5D+W0VYlzZtp6DqFD73JTPMPPu0AYlhGipQ2zn1Q2mQCe
 BoeeHsy/fGMJyXcuGELBZ6vubsvOn4IsqnrAAtOZLFaIJ3BgBv3/TZFKKcdXxirwDh+06Rxn6Xo
 Jc67jymKTCJs1QhSqTUbKSEt/ZLJl0TdBuzBeP7sW0Vn/8yRQYcUgMw2x+z6HByEGLFUq473OLs
 8vw6ij/ZDUA+nN7Z00Ws+QRhrE+y76vlk34xXrnDzxNy0pgipLv4FOqSSQaOU/eNTWAYlDui5zR
 A5OrMI7JNTNvrZ5gk7gzals0MaqZtt+2AKbiBAEJHCp+NRB5hiSHMbWEBgXo3hJa8g6/cnFVF/5
 nQ9272GQuI5TmjPA5jAG9BV6LjZyqQWVUNEWFvwo=
X-Proofpoint-GUID: 0QdYyRkyN0Jhz0wUAaJgDOR4YGHCPhsD

On Fri, Jan 09, 2026 at 10:30:47AM +0100, Alexander Potapenko wrote:
> > > Instead of calculating the offset of the original size in several
> > > places, should we maybe introduce a function that returns a pointer to
> > > it?
> >
> > Good point.
> >
> > The calculation of various metadata offset (including the original size)
> > is repeated in several places, and perhaps it's worth cleaning up,
> > something like this:
> >
> > enum {
> >   FREE_POINTER_OFFSET,
> >   ALLOC_TRACK_OFFSET,
> >   FREE_TRACK_OFFSET,
> >   ORIG_SIZE_OFFSET,
> >   KASAN_ALLOC_META_OFFSET,
> >   OBJ_EXT_OFFSET,
> >   FINAL_ALIGNMENT_PADDING_OFFSET,
> >   ...
> > };
> >
> > orig_size = *(unsigned long *)get_metadata_ptr(p, ORIG_SIZE_OFFSET);
> 
> An alternative would be to declare a struct containing all the
> metadata fields and use offsetof() (or simply do a cast and access the
> fields via the struct pointer)

But considering that a cache may enable only a subset of those debugging
features, I'm not sure determining that offset for all caches at build
time is possible.

-- 
Cheers,
Harry / Hyeonggon

