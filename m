Return-Path: <cgroups+bounces-11308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B89C17864
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 01:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32BD7354A22
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 00:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8612505AA;
	Wed, 29 Oct 2025 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C01IuHp1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nEowCowB"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26C11CAF;
	Wed, 29 Oct 2025 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697375; cv=fail; b=lWvmMu6XSDuJSxgVWszmOzu9S/o41gyIut9+EOHty+3R3ttNkCkiJGnnGbpG8nRXn9jIW2voKsFNolffF4SlrkjM/fiRv5tpTTXnwDJR74PQ+LKmKQ4GUAc8fugyLPT48zNiu4oEh76f17vu5rrGvSvHIk1xNqwiiuKqi00j2P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697375; c=relaxed/simple;
	bh=dbompSjVHLWvVBQE5ejH/yX3xQpenzXUk0btW3L9Nu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qUykzg0f44vcjaLG9l0wIH+2dUMxteLpKJjna0VUPUTruNAjB8LDwgIBWa0ogZKy7lEZBvRkqWAy4G65nWPOG29FPW1R4NNOrLqHBhjoxrFZEIAffbQrHS66v4yiuxOKVRa8EGn4rywhYq+YhntmzudDnCYwVbOqM9xnP6icFdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C01IuHp1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nEowCowB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SMuRwt031793;
	Wed, 29 Oct 2025 00:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2LrH47vKe0WaMNdsdG
	z3fEzh8QY1lJRk7oKslOLYeAs=; b=C01IuHp1tX1O4kIG+KYXZTZEnrjPWeocSO
	1YE+rCEE1BO9xHDurlmuC1GoVdNWQXHabp3d5hkBsad3CNMdlC0ZWoJZGnBM7K69
	KL6KMma4+fOEcuJRy6yAmXkARgf2Z32zyynl7f1fPFiF6VC1Ab/wqOkcKq0MFBiS
	4fx3EAdCKEUY38TKjl449k4wc/fvCI8HBtDR3SihgmlMRWxtBbuBmPy7+sjvCeZ+
	7ntwZBdU4qskimtvMZvjqXTGDaRhno7ZcV8JorA8x3KcjeQmERJ2Y1gLa+iLaTNS
	YJvlJoujDBVatuAFTWSP62rO8FO5MhhOuwzfZkHeLdi+AOEoDBWw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vygedr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 00:22:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SLWY8k011644;
	Wed, 29 Oct 2025 00:22:20 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vwgtxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 00:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgfBdCT1vKhgevAxb4poEO3UvfFL0hWrmdjDq2niVMUjuYMWDswQn56cAOTrmd+2f+eLe8laZDc3X8hRR12uwe2DxbKHR/LyPDU492cVAQf2VQZOuqaH2dho1gOeWH6SJV5otlC0OiloT/xieXXhYfs4ETj7UONvcngP71Jn4MqguWR+d9XNt6WvvhKTc0c/6p+Jm7CocpRmdfbs/GhMyET+P7ZRTGgbI3O3O5dBIbvJwZgWGi4XYfIhMNekRVfir7kRYaAqcYQKBdr80Zler0P5FrM+TzOBUzKI0zUGLQRo3PLbgJ90Sf1UAB3dqpn5BoCtn4dqArVognjdZl849A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LrH47vKe0WaMNdsdGz3fEzh8QY1lJRk7oKslOLYeAs=;
 b=rwN2XPA40sYYX0d+Mu6BTLPxcuaKzUHDxt4KthbCQkKJaECTEHRmAcisUUAyMsf5zIoqoqBroHxbhvIGFTRLobQTBCv/dgEpU8DhbogYpcXekBXYviU0aUVLJ/7IMXEBSwJ3J3HQl0SkZA8WnekndiV/qlXuCHPXIKJpNU0rWuJpVlt70JQsTSGH+oTZ1mO4NlXJvabJc723d8uNTp/feg+NABEUEMYG6r/If0GFBqvzRopXg+Mhc7U3rxlcAPjZm+GHt+ZYjmyPL5p9otTRmW3JRfX2HsDiH5teLZq1hGlFt+S97KNBeSgu7rkRRbjL9t54zvGeCCKYFtM0aBOBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LrH47vKe0WaMNdsdGz3fEzh8QY1lJRk7oKslOLYeAs=;
 b=nEowCowBd5Ys/wBxEKrnePVkBt4SZu/1T5jeTux/gjBbJC30eyGdb81sNOFsbLH7bia+fsq7EQfAgMQGB/gnxsN3YLqhMUwO8PHGzc46KrTeusHFNfuDAnD7OFRUEAXJNxzX4W7tWIN6V5tTvbWw+iIPh/06oKFLZkxdcPCFuZs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB6433.namprd10.prod.outlook.com (2603:10b6:510:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 00:22:17 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 00:22:17 +0000
Date: Wed, 29 Oct 2025 09:22:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: syzbot ci <syzbot+cie7d8f1fc805fcd7a@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com,
        cgroups@vger.kernel.org, chengming.zhou@linux.dev, david@redhat.com,
        hannes@cmpxchg.org, hughd@google.com, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
        muchun.song@linux.dev, nphamcs@gmail.com, qi.zheng@linux.dev,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        songmuchun@bytedance.com, weixugc@google.com, yuanchu@google.com,
        zhengqi.arch@bytedance.com, ziy@nvidia.com, syzbot@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: Eliminate Dying Memory Cgroup
Message-ID: <aQFeMG8WEvrWaNf0@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <69012e79.050a0220.3344a1.03ee.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69012e79.050a0220.3344a1.03ee.GAE@google.com>
X-ClientProxiedBy: SE2P216CA0062.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb7b716-b32b-4ae7-f439-08de1681377d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?slFf1FWEuwFzuCRa5zEQKSiq9H7boeFP1lwVLVg3nHxSPrkaAvAdSGeLMGL9?=
 =?us-ascii?Q?ErvzqZlvIPnIFOTetk2KBpHztCYrQGFp51oHTgT8FR+Y1jLpFCcD6rBoxw2W?=
 =?us-ascii?Q?LzlS7EsjOddsdtFXeCs5s/8GY4U2fxnQsxqdapAmHqUhg5nXuFizGB9x80oA?=
 =?us-ascii?Q?DeZqTSslkyarCRtgMOPkmLyZ/hThSFMUYZfr6VUH8cqN/ssLpjGUTCeOl17k?=
 =?us-ascii?Q?VmSFR7vRKiby2a1wQDeypXy7fEkvKFQfb6y1MFM8+9tonbpNWp3BdoQxRJ6S?=
 =?us-ascii?Q?nqLbb+WWWDmXgZV6Xa9uDAc1NNhLUIb99aPUHE5r48ANvTwX1cGMBX5GlMUW?=
 =?us-ascii?Q?P3S3rhYb5nid3hLuuyMCJJuszyx72DWNAimfj/UXDQ35Q8y9CBs4YoNDQj72?=
 =?us-ascii?Q?K+QnF2I4irgWD6XrggTWpsvZJqHkyG8nkslSB+2xkTFZkEk+Mqg8+51xrRXn?=
 =?us-ascii?Q?Q7IrzTbpaUQ+o+411lNvm7wAU0YttoWfTApp2e7YBf4lsXTnhunRvYbgEEhT?=
 =?us-ascii?Q?hSnICg37Z1Z5oeIDzzlQqavU/fQgKCGtD4oUH6zTaPyiAP6k7OnpYIUR7paA?=
 =?us-ascii?Q?0nV+btmRcYPkByJm9l9qW1WkbTSUakGU+mWTbIG+gibFVvaJVMKEPE24sPMG?=
 =?us-ascii?Q?Ydx5Qn4fWBvr42xK0G5bbhb8Gf77RB1rx8/dRdowihFZx0GTP+NHO+QjZM9z?=
 =?us-ascii?Q?OCTdTt7Wp+COKx0iOWl2048q2/q86YPCxnk7ujgkRwhpudKeyQqdS+wd7/JI?=
 =?us-ascii?Q?RgVqbPOluBHu6je7SU6Abyggj9PLW1WR6VyA1bpMU3dRDG97lGNpLpafpFsP?=
 =?us-ascii?Q?j3yARMzKT9/s1DQUMxTqQiNZLVUHaVObWjEjkrkii5/8TUKmknYgbJEG7GK+?=
 =?us-ascii?Q?iAArR7YN69Q5u2cyeK06esAg1EVwbWnc6A7pkXg/4M+4zfAgG8vpAuAbFDRJ?=
 =?us-ascii?Q?aT8dGPu/xMOfhFwzIklbJX2y5bbdY7kQlDivEbs4AY5AATOcARX06OuLxp6f?=
 =?us-ascii?Q?I9Bsg8pL7akGtexCG8SXyIo18fHUJhc3/RXPOFOuwxpyYTJthU3lZJsXt1wA?=
 =?us-ascii?Q?ctob0ZNmAWb6hSwIQA24gBDqDN2XxwVz3rPgZBqt4b3Cv5YT2EfeaIwZ8gJD?=
 =?us-ascii?Q?gYJXTaRxuLDh2UYi1ng0fm7ADhKpAcsNaxIdptzXhIHzo4AkyYFx9oWILqqs?=
 =?us-ascii?Q?gzocsfUEFB6x9O89+V1i0c0uS9dNDzNRfs7asT+4wRqcP+HRcP/TOUHTyClI?=
 =?us-ascii?Q?lRrzsx/7yszXI9ddeLbmK7pjYuQh5fnY87Y8lSTrDevrf342KInVtITraqN5?=
 =?us-ascii?Q?r1qRhqovXORqMbDMPhCW2sw2mWbgATU0T6l+PE7oVfa6ocS3sL6IJowmE6cE?=
 =?us-ascii?Q?/xYITXIpdybelV43neME/rYW2n96pUZVnTWu1Zw2or3WDGjHRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHfc4XJDJE+lu/nGPBb7N+HeNGRb5INO4xnziIFqH4UQ8pMkNzpegytcNeQO?=
 =?us-ascii?Q?mJCwVKBSLnSPq1blS+3h7sJQrVUP+UJw5SG6KBOEjXHAXoHyh4vBPxM2qmbm?=
 =?us-ascii?Q?piwpEL+YCy6AwkL/9aiFFoBzs/wlvEX28XwI4MBwILubUwCisLfMlekERB8Q?=
 =?us-ascii?Q?zMLBLtTBoFoBnolBmbdIPF+j/qjbDsDO0iBS/qbv5VIAVaoExn5ZAUvvUsvx?=
 =?us-ascii?Q?X7FbN3P9LcQVkdM8AjwY2sl8OJDZ39wzIBbvgI06CvobkRkGjK8iN1yY56Ff?=
 =?us-ascii?Q?pEu3XBgPXXY4TdFiP3WxqdkGhgUhnyO/EnftNy/tgPIH2EFL2K6fgeWkfibn?=
 =?us-ascii?Q?HuphkwY0T55gBboCOOgCiau37pHumH8vDGMEhsbOrD+ffLh8hm5CFg0hkhX6?=
 =?us-ascii?Q?9o7jChZ1hkNp5aLQEtj7ANjXPSFh7orJG6Jv4RQcXwNk0UnwA8FbOfWdpTim?=
 =?us-ascii?Q?N7MULJSuET6RvGufFVotIN0R9rjfGVPKPuZyDlm14y6fGRee5fXPbF3OqL6w?=
 =?us-ascii?Q?EfHKsbzhYsJ+3UxzENQ82HfH3lKtrIEWz/1EMTMAtM08Ubr+Rs12tBqHp1TA?=
 =?us-ascii?Q?2IQc/YK6L+U81x0kDuknV7mp4yuHBcgBW8K66nkpn22eIcO4IULDY/nrISUf?=
 =?us-ascii?Q?osxZoO/ufAbbjn8qMdYE+rXGuWuL0Dg1wR0W3hEgmzXVFKsldPhr/kSK4cke?=
 =?us-ascii?Q?jlkLO79+hZpsfhMGuqnPf1707phFZRJu+drPLgtLkga/nmoswAZIJnauh+8d?=
 =?us-ascii?Q?IXbB4hHU9rP5Pb6gqUaEqgXsdgrnbIO2gd3L3AFDY07BPDxDzbnSiLZzpiA2?=
 =?us-ascii?Q?xXzJ+B0wmS9fYZcBqF/RgVfv03J1TNZRWIlU/T4wEgX5yhs4GNchuqy8mg5U?=
 =?us-ascii?Q?imYMybwvh8H8ct+zvxrpHOP8niuH4cD+xx27BMhtrejuqRW97dXCOEdgXd+z?=
 =?us-ascii?Q?ClbilB7PP3AZ8LLmpPbcqr0n/fsmKOl/gDn393tKA67jbBFVB71aVpSGUvtD?=
 =?us-ascii?Q?B2+1++CF+gOgoklbbXe6aTIQQjBQKF8eVKKtl7bNmBiirUfZjxLiyhaDnpEY?=
 =?us-ascii?Q?50/s7ZeQaEjDp3rfp3HWWn5/FpTuaf5Yarmy4ZoIcIlcdAfJFlF4q86uKBwR?=
 =?us-ascii?Q?ppgA7anHIxsEvXiutpDDnt9dCH77EluMyucJh2UxYktv12+CbfXCCwiIr3S6?=
 =?us-ascii?Q?zDLC28FY9xbt1RqoHyHYpyLPb0NZG1l8+k+avSPCFqZa4fbaxQTxk6Pn9r/7?=
 =?us-ascii?Q?yjg5Vay1HnnWdgB768CURQlZbkxL3hpYHIodXiW16FyNGOFpd6GS8F0lZglM?=
 =?us-ascii?Q?tyNHFFgBtp4hkqkCEGbWgKijJQY5/s99n94ypnU6L9Eru71BtFuBp9uzu0ip?=
 =?us-ascii?Q?j9k+SAHxRU8/Ut4am2OwYBoYFDI8+lOFkMTPJCTA0dsRNyM1HJ5ySkQXEozx?=
 =?us-ascii?Q?Ir5CqRGD9wCOE+tNZShve7Agdd98rksB7UjYuCjg7o709QSPf03JX31H5Mmz?=
 =?us-ascii?Q?nq+RdM/eqe615qa5KuiFbLejObJvZBeaulzByEmEZ9Hi1K4rq6sMxd8vQTOP?=
 =?us-ascii?Q?NC31dDn3/+HZ0rPi55s5uH5Tiw2Gv91H+SrTEYJ5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/v78klyJ5YAeMq6rcQCPrPPANPn7yJac+zRrzk0jdbgOL3PmT84tMxiVXE0I6ozm3PVYhGy2SpgLPifVP3617uM9SFDRUqKq2YkxAGPiOtM4/tY6lpVbQneFdsZ1pNvhXymshW6pSWsjpEtuineAIGMhDug5y1TzSGaOpItL/5ItV5rQV5CwO6dFGX+PPcZDEE6iHea5OFw7+ndRIWVhP4CvhiVbX+zcWKC4melQHuElpjsQsD8yd3lBCfrXBU2hu0kUqLwkU+F2bJgkQFqYGB4SpKmIFOmo/PvM2m1goX3xLEwhez2OJw7fWcldYGQ2KABnsEa7qeD1NqYgqHMMkNQlKEZpx390rdipSIoS+giD+VO+CiPTwwSJwhE+5lArR+sg+gvz769b3yM0p5niAeSJA2yqE9O3HqsuNA6oQ+kSGvYHFjp8Xcn1damDHAwEvrxOybb+aUu2GlrIJIzOGC2KIl3smmxapnS2fD1aVKcWVvWNEBOq7ptxeBC3UrgxHtBJPbfpbladSrmc+R70epSqI8EvfLjeu6lbn621OLSBzYRWHPhxxRQq288tVOWHBTEE1J8oOH/BYmL0cm6JZwMebMn5TV3BvEnsoSNhi6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb7b716-b32b-4ae7-f439-08de1681377d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 00:22:17.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZ1cZVihblHE/qMqFvdXGwRQJQNwn4UZplCtRKB51IfziogHrOXRmqxthVNaXcJ2pY4dMHipJ31eIiyRzoB48w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290000
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX34dmZzU4pocC
 z4ZzcAoykNbMHVmTAFh+IZwrxXjAF8aa4Pvx5s0HQucwWOBxIPTPVQ5W40uTiR94GkdVYRN9D9p
 NOht+ylxImffYlV77yVYB6YhkxOHiRo8J9sQCx1vvSoYk90fJ+B134RMubY4UJCd/ALv7j5JtSs
 YDB0roRG7vbB+1Mpj3Uws59w58WGeq+Ti7tiVeOqIDD0m6HaqCfvyTPtIsIs+R+weAHvJX+lPBU
 CCPTNznm3bfbxUNF1RutdvGvOH6qm5SLKZ1Vn4Jn2Rkoj8sDII/nF7mKcz7VJjQ1BbI0STQYpKf
 MyO/jrO+rQ5VsmuOZ8FaC3zYOt0Zqg+uL1PmIzdLkUkz/Oxa9n9imI7IQNZ8dTnqyGiKe3bDjzk
 pGFXFA66rcAQ2yPXtDJa4h7tOPAOfQ==
X-Proofpoint-ORIG-GUID: HIZr2uE2SNOgTV1kmrjoowzZP-KURkka
X-Authority-Analysis: v=2.4 cv=M8xA6iws c=1 sm=1 tr=0 ts=69015e3d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=-ibLmwfWAAAA:8 a=Oh2cFVv5AAAA:8
 a=Kx23NP5BX14ndz_FfJwA:9 a=CjuIK1q_8ugA:10 a=A6MkUVyZPcTV1i89ro0M:22
 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-GUID: HIZr2uE2SNOgTV1kmrjoowzZP-KURkka

On Tue, Oct 28, 2025 at 01:58:33PM -0700, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] Eliminate Dying Memory Cgroup
> https://lore.kernel.org/all/cover.1761658310.git.zhengqi.arch@bytedance.com
> * [PATCH v1 01/26] mm: memcontrol: remove dead code of checking parent memory cgroup
> * [PATCH v1 02/26] mm: workingset: use folio_lruvec() in workingset_refault()
> * [PATCH v1 03/26] mm: rename unlock_page_lruvec_irq and its variants
> * [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
> * [PATCH v1 05/26] mm: memcontrol: allocate object cgroup for non-kmem case
> * [PATCH v1 06/26] mm: memcontrol: return root object cgroup for root memory cgroup
> * [PATCH v1 07/26] mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()
> * [PATCH v1 08/26] buffer: prevent memory cgroup release in folio_alloc_buffers()
> * [PATCH v1 09/26] writeback: prevent memory cgroup release in writeback module
> * [PATCH v1 10/26] mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()
> * [PATCH v1 11/26] mm: page_io: prevent memory cgroup release in page_io module
> * [PATCH v1 12/26] mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
> * [PATCH v1 13/26] mm: mglru: prevent memory cgroup release in mglru
> * [PATCH v1 14/26] mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()
> * [PATCH v1 15/26] mm: workingset: prevent memory cgroup release in lru_gen_eviction()
> * [PATCH v1 16/26] mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()
> * [PATCH v1 17/26] mm: workingset: prevent lruvec release in workingset_refault()
> * [PATCH v1 18/26] mm: zswap: prevent lruvec release in zswap_folio_swapin()
> * [PATCH v1 19/26] mm: swap: prevent lruvec release in swap module
> * [PATCH v1 20/26] mm: workingset: prevent lruvec release in workingset_activation()
> * [PATCH v1 21/26] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
> * [PATCH v1 22/26] mm: vmscan: prepare for reparenting traditional LRU folios
> * [PATCH v1 23/26] mm: vmscan: prepare for reparenting MGLRU folios
> * [PATCH v1 24/26] mm: memcontrol: refactor memcg_reparent_objcgs()
> * [PATCH v1 25/26] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
> * [PATCH v1 26/26] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers
> 
> and found the following issue:
> WARNING in folio_memcg
> 
> Full report is available here:
> https://ci.syzbot.org/series/0d48a77a-fb4f-485d-9fd6-086afd6fb650
> 
> ***
> 
> WARNING in folio_memcg
> 
> tree:      mm-new
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
> base:      b227c04932039bccc21a0a89cd6df50fa57e4716
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/503d7034-ae99-44d1-8fb2-62e7ef5e1c7c/config
> C repro:   https://ci.syzbot.org/findings/880c374a-1b49-436e-9be2-63d5e2c6b6ab/c_repro
> syz repro: https://ci.syzbot.org/findings/880c374a-1b49-436e-9be2-63d5e2c6b6ab/syz_repro
> 
> exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0xe5674ec2, utbl_chksum : 0xe619d30d)
> exFAT-fs (loop0): failed to load alloc-bitmap
> exFAT-fs (loop0): failed to recognize exfat type
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5965 at ./include/linux/memcontrol.h:380 obj_cgroup_memcg include/linux/memcontrol.h:380 [inline]
> WARNING: CPU: 1 PID: 5965 at ./include/linux/memcontrol.h:380 folio_memcg+0x148/0x1c0 include/linux/memcontrol.h:434

This is understandable as the code snippet was added fairly recently
and is easy to miss during rebasing.

#syz test

diff --git a/mm/zswap.c b/mm/zswap.c
index a341814468b9..738d914e5354 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -896,11 +896,14 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * to the active LRU list in the case.
 	 */
 	if (comp_ret || !dlen || dlen >= PAGE_SIZE) {
+		rcu_read_lock();
 		if (!mem_cgroup_zswap_writeback_enabled(
 					folio_memcg(page_folio(page)))) {
+			rcu_read_unlock();
 			comp_ret = comp_ret ? comp_ret : -EINVAL;
 			goto unlock;
 		}
+		rcu_read_unlock();
 		comp_ret = 0;
 		dlen = PAGE_SIZE;
 		dst = kmap_local_page(page);


