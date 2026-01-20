Return-Path: <cgroups+bounces-13317-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1352D3C18C
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AF925A4595
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963303C1FD7;
	Tue, 20 Jan 2026 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UR9HL1HG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eqA2xLg3"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F33ACA40;
	Tue, 20 Jan 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895975; cv=fail; b=m/boJPBO5YQLvujGmmwlscbh0bYL9PtUbYpOBB09z4xHHl+unJY8fwF75I4q1EPwXUTDSFrxUIJ77R+POZ2EBkK1JZ8rakMZ69Or5dEC0Uzr+OXlWUKgK+f8guf2VbJhAHmBXFNXLHE822ohFzVW0UTp9SwCWh20ulTacboexIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895975; c=relaxed/simple;
	bh=+3yCVWf/vopg1b5wWwL5YA20zz1RO7VRyEe0HxHB2u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=teMoWcz+P39EHAUWJXkJHVL3cBlqpMpOL5RJ/pwIfhwuR7ztiLuHb/y3NbiJhK2f/eQjSdqN9qfBV9fiZaZ1RXgt0ucs6Du49d9aHGMGuYuOVPke5eDm3FFxOp5qsdZjNEHKbop0K1HHSe0jNMojaSWEzBc9nVeLtrVLXdEr49w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UR9HL1HG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eqA2xLg3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7vK503524038;
	Tue, 20 Jan 2026 07:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vsLlTpmlPwSd1ys0ei
	AS8D1aWIzLKRcm4oOKLoquAX0=; b=UR9HL1HG2uUrds/S8Wr5WK8IryxQDzLodJ
	tY2YAhO0oXoTXnLerqA0BvIi/kRKhw/ipoLtDLXrFmaQYx7enW027JjkbsDsFxwH
	bjIc/nC2KfAgxj8zGi5qVafB9Ge5VI/OLliNVVkFBe9XzR8KGu15eG76DJVZL8WF
	zVqVr7Iq7N0YbHx6KBRMZ9QHKvFLmPjjNJEKrxIpw8AHQV+W8JYLiuCKM/HbdWLa
	IiZAahB40ZRSa5wdcgeDhoP1RB8Ym+peO07A9gW4pMc9qoQQ4cT4zCOh0cQ0glmB
	2K2igjTBbMFfTu11UgaZhrj2YD7nhPAxLNtPF/jyWPAeHMWnZJjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qb82k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 07:58:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K6Rdfs032223;
	Tue, 20 Jan 2026 07:58:51 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd1p5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 07:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3We2xi7UuYYCulICeRT9hqOKx1rKgSuS4HHe5YyYwCdT++/E4LkeTmlfwC8vgvgnldc0H56SCUhy/ZIzTVk4IDTqEcTRbEEUO5MkeW2ZSupenUivjkWXTOVaeur9UYoxuNYfENBZocIMKw14hdrQNwSs1IqC+DY7KZfMAhpv7oQ2bpg28XQGYEVZQpUIgvCU9snPtvFl05KKO6HGO/rLFuaGllFbDTCFBeUd1WgbJkkuJVLpbrrPUeg0qd47+0VoXAvckKQxJJCHzinbUYuNhCpyNL548dYK0Qquj0xCLXNqlEYKWLoPzY2OHw7I27CCn4+Yor2rq+mi892jy3Gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsLlTpmlPwSd1ys0eiAS8D1aWIzLKRcm4oOKLoquAX0=;
 b=lnee7FGV6G8+DeTHhCEN9fhXA1MkrcEAgiKl639UrnAtwGx+ABd0KFiRoKFEEUPkYzFybRmhLehr8nJct011ac/BvzOVOFBAp0/yoT5SDnMWZxXgsRwBthwbal4blGfurKeYQpN2Ixs/Qc8W8cM3OGyQYLOzihtY7rcM7EZjR4bjFCS934SRPgEXyH+ralDYqDEkBFfjeZ2yAdlxdKeJYFx664J2NEiBM0t8WOhM6LUyZO5ziY+DuWOeTfUkPbV/4ymaEFoi6z5QHHUMmN0laeB/KUg82VewL3+WXzyC1ZLrcE+0JWi9LBTJ9NopfqyxR8Yp1TpHtzXGlTz/xmHi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsLlTpmlPwSd1ys0eiAS8D1aWIzLKRcm4oOKLoquAX0=;
 b=eqA2xLg33ifep7ZKZNO0SBMUJAi9n0d1WkPdt6iDQl59NTdg4kCCQgFAv/WOmPlETGmHwJTBFBklP+vHKnqaVy+Y8wL8rmVOqlegKfNQbtY4FJ3bY4DK907whjp6gcOv2BZAS1vtghE8cgBxCYqlYvkCBphxlxJ32UtAUXvBp7o=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB5899.namprd10.prod.outlook.com (2603:10b6:208:3d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:58:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 07:58:46 +0000
Date: Tue, 20 Jan 2026 16:58:31 +0900
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
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 23/30] mm: do not open-code lruvec lock
Message-ID: <aW81p8eaA7qbi3nO@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <33fef62fd821f669fcdc999e54c4035a4e91b47d.1768389889.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fef62fd821f669fcdc999e54c4035a4e91b47d.1768389889.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0081.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b86d805-7424-459e-a2ff-08de57f9bcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N1361p+RSqtxcWReaPkb4NundvQ+Zd4GYMASxKyxEMeIdOjPisjlbhDkxpJl?=
 =?us-ascii?Q?EVvTNt+MPxmXLsgu1n2fpoRPY9mg/l9meZfQ6/RUq8uwxXPmDotyjrXOdbrq?=
 =?us-ascii?Q?rc4E52RAFFD3afN+DkYnRNyJx8QyUVT6g+gpfvYjubiwFSU1lC/Vf6k9vcYt?=
 =?us-ascii?Q?n72sEUpIiKJLsAN5KfRACCcZsQbpbmQR7c4gjcGNTlF3tCnYjaxXVY5Lwcdl?=
 =?us-ascii?Q?KrZ/CB2UDsL9HlB3H3G4sPeB/RXQMvCnGrwLDsG7CsqTKgFAlKXA6UL+wnd6?=
 =?us-ascii?Q?jWqp7fwksTfmWYt4Ipz/ZyOrAnr8wyBLcOdgDhO8mA0FWxwym2vwUWLT9u50?=
 =?us-ascii?Q?To2uLIf6jSaXWq6NYgogR0I5vLpFKCagWiBFqVmsasGXLc8Cy3WBjQtroerw?=
 =?us-ascii?Q?i6wPA3hyE3maoXSUCEZBgYppMz4Rgq1TKOwtxT5nVqVWWm5TzlBZJG7/qrFc?=
 =?us-ascii?Q?GkBVMo9JVhQ8x/hjVoEaErQg4I/sj+MAnw2cTVFCaifkLrw+5ZcG+0kIhSBA?=
 =?us-ascii?Q?66YoQI7iSNbCnA0yMhzZHi21wI/xfwhPMwsXX7P5NPIoUkWXNr9EEZcuT2hn?=
 =?us-ascii?Q?4BI0jQ0jqLwRLWrmypRamnD16sHn51VyJOAqnxo/ya2h8ZqDypg+OVmHK8UO?=
 =?us-ascii?Q?HSHCSF3MEoI3OsocMU1m9eS4KizEmX5w/pB0KN6VbNSo9bDd8L3AtCZoDwuH?=
 =?us-ascii?Q?hKDdNIy2Idt6K3790/jhPjYIritrwlWo5y9CEd7uyYzH1aa3v1BbQwFvI0Iz?=
 =?us-ascii?Q?phHRbxy/rVWMsDI63uEXcoFViUx5quXMvVkALiipG0oM3BZKb4NH5zP1CE6q?=
 =?us-ascii?Q?mHXqaqz5srpK5aLv21pDPaP9RBKlbhyAXGLK5sjZMrRcaKj3e668pGt84pYw?=
 =?us-ascii?Q?cu1+6Fy18KjuP/oh/e5lK2826M86AjTHMjji3AfOdpBz+g6Fh7NmORx0TlnQ?=
 =?us-ascii?Q?0LQCwudTJ4HJt4+zM4+tAkPwkIZwMV9VHUj7xc/rjTijSW272fkMalEF/nzc?=
 =?us-ascii?Q?rJosfyBPzZBnpqM/YcLJ3pH61Z2ozTTtWZftH7B93VLDG53ctIh6xAJ4XozM?=
 =?us-ascii?Q?5i6z2pUJVL5GyW9AqpefXzC8P9Q7m/q/JdWtaMMz46zWhb21Oc08a0SGnVeH?=
 =?us-ascii?Q?rKm5oT7KVDyat62qSpceiSmH6Dp1yeDSn5HAOo/Mqd2KEouTQr+sn4HXnVBl?=
 =?us-ascii?Q?hi///4vyONbBX6wj39pr/Nb+P1u8cgJyKsGSRbUbnvukO5L8/6BQxxEMw5G4?=
 =?us-ascii?Q?4Yvf1MMQw/xpV8dQVCzG1iUSLnJWX5IJ0WccWG5CQidVafD7tw8Gv3AX0cpf?=
 =?us-ascii?Q?LITC4Bw2kP39s898Qha87J+yFjIAbGS5Z5wJixyCLVeTD3t66bBuPKVpfYOx?=
 =?us-ascii?Q?63xGP367dPkM8PbrrOr1NnyF6zWO+w07HinMCA9OfVOfdK3wNh8M86sx/SYC?=
 =?us-ascii?Q?0aYmXpIYnt91EplUbh61E50HYOSS8+yYsqLacYYyXNBnrgO04UzQK+pcE7j9?=
 =?us-ascii?Q?aF6P12+oqpGLuN43xLvvs61xlZ71UiG52u0QmgcQJGNKSPlGgthdP5GEwOdJ?=
 =?us-ascii?Q?jH/kzagfBZAkseChCBo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/tnXGgA4CPCPETTx8sKgd+56vJDLR4sMzpT6QSm++xXGs3ZfwW0G5LNMSIz?=
 =?us-ascii?Q?O29ohthBP+O8uhayyAkoDy6Cf2pzIcdTgiUqoOPQsR/frLbZb8X1VmUoZiUq?=
 =?us-ascii?Q?+DG3iy9h+MhoPCg6uAyddzAyrep6Tb6/suXvOeo4qxnj/KZyDe8xOBIC1LFd?=
 =?us-ascii?Q?r29qfOXSRnTk7sgaiPDZ56i258qTtOEcQEUMON5HbwKYol/1dA8MC9cKI+TQ?=
 =?us-ascii?Q?m82rkhSlDibpijMhH+Nw+c/LXGqiuGtdvPpy4e8kmNin33ConvNd3xF93Bml?=
 =?us-ascii?Q?QqsXGJT7rD2VPOV513KNVvII5Hkj9AXAaWoxnx1qI3WV16nEIncdTTdZ5UwR?=
 =?us-ascii?Q?jQrlHg5C2IXUDJ9DXs4PzDOMBtoHpYNO2Zz0Dx4z4gn5XNFiMIba/VnSU82v?=
 =?us-ascii?Q?9z0XcTtyBJXy0nShAiieE8m+T7aEzh+YXNUaQW83w6mxLKLtbZ5GF1ySPmhr?=
 =?us-ascii?Q?8UNnki/rxtMnCPTQC6O+S0A60AT2YPeYXztyQTzMQsXtz0MonJspLOFGRkaA?=
 =?us-ascii?Q?7zIdQd9V/sEYYdu0IltqUP+5EftbHZBYY2sq3hkxnZ5KWouFrc8wJDkGOHc9?=
 =?us-ascii?Q?p7h2mrE03xHKWxENeCZJ0tEeDBoeXYlaNYfs/OB3Po+/7oynh76MPv9Ulwwj?=
 =?us-ascii?Q?/ggmJuPRYkCGDuxoE7QYrw2vSaIzQZ2NXrN2GfbUeNUBjK4N5TSQF/jKq0x8?=
 =?us-ascii?Q?aIzYRjpAeZBaIBML4e5gz1e0hX+QE9kd7/kg0I9LL6UaKlFsCTg4ZyRdr5JO?=
 =?us-ascii?Q?1vvFt+eZ0l3aedkcUSRYUDl9BW008bROevOlBp8JmsxZPh0d96VcojA54Gkc?=
 =?us-ascii?Q?wKgUJTa14suHNyfL23E1bCCm+xDrjxUrk6PFcF2F+htJsnKOg4w0ifRBdImX?=
 =?us-ascii?Q?Amj/Q/m/7JMpTzLFftm4ECao+H3TTw7a2J4P36Sxjh9rbs6lXy2tOtOrO3P7?=
 =?us-ascii?Q?E4Peykp1eHOKebFFE8ZkIuKbLPO4y3hjgJeHDj4Y6c21rqabIogRr2tFKhUv?=
 =?us-ascii?Q?3F08MhqpyMpYn/hKfyy3rvJbYb7VRs+ys/bISQSP4xZHDlVZkBez5ki1ybtY?=
 =?us-ascii?Q?iGrjYmRpgr12bpq6EmxcEHlIy1BDilDzdp8hBW121XEgIljRPURihKyW0CA8?=
 =?us-ascii?Q?qVzMO9v70bLoKHdhe65gMJ/oDoFN0p1avKC/oGFw04U1slDrYCB873xpX6Z1?=
 =?us-ascii?Q?pcAF9vzZ2SLajLHUCvLqrPH2EAJElyHl/HEyu+7Z/x5viNSUZAzfcsfDdL6e?=
 =?us-ascii?Q?nKK6YzpU5qX7dFIH+OLTVefQwjocjSKfoLNQ2U5Qe14Y3515hIBBP7admLb7?=
 =?us-ascii?Q?23v6CRsTFUwpG23UcAyShGNElPrrLUJXwHmGrQ1ETo0sapcUmOAOYKyq5RxN?=
 =?us-ascii?Q?k3tcw9DUaJZbet7ZAVojuXqBXEvY/yNAwlE1SDbrTgqGbg6X9VSevs2t3L1o?=
 =?us-ascii?Q?hO5SYFfHV30ncNyQikhP8GVfxoCKGw05l7qUgcJh262kGvMW8VKxiDmrBpAm?=
 =?us-ascii?Q?hv3KsKsQYvtCFht+z62OLp0jbKxWFCoj1SpGoLBoRnXgs5T2xI2oY2jl9fIb?=
 =?us-ascii?Q?sHq8Db6bN0E1+ooM5ZpZaZ5M0Z3YwXiLE0+8sSBV2hcb8RrKYzpk8rE1tPAd?=
 =?us-ascii?Q?a3ey37cDiV6rZnW2RJhNNE2BMyfH1XPeRr6c/zbRIn85q1TqL95RGHQQZk7v?=
 =?us-ascii?Q?GsXiaz4cP4bJb/5LMtyC9FFJwyIbKIBDAvRrcaV18eYTwPYv4i3xBhe6hSYa?=
 =?us-ascii?Q?wrpsvF02aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lBcbWHucC5gnPs55ZcscpjkOVREaf3tcjm9k59PSbguM3UsDuPqBLqGHbbola+r60p2m8VNP6eH5Fyx/D7slOpMcTKj7qEgBy597pv0WduKS15OpfK2MxxgS9P9BDBoTD2IPBnlU93y7owyUxLGaDy20HsG3D6Q+beseTY8qzUCaqrp1373pM5HdwlaWv6vl9SNVVXQMQDzToVvuAX5UgGt78sJ7DAd53+nBhkPiEi/lgO1QZkwkt9f4rltLZZ9C2WjhRjzoaKBu3UL2GivDP6FrkCW7KtxaYE8S6Iy816EVCpzzUz7F2tAHBlWEG5Fed3/uIp/AzimRhGlndDSxFwX8wrPNOGAUOVifRI/ivePhZuUazYCAPIsAu3cxulaPqk2/m8qIH4zsqVkHJ9N/z7729HsQ0Ku+o351LOKRLPwXWZfg+16mNpVEl9SYGcj3lK1nYZbUfN5yjkP6rkFbI7dbzlhcS/sz5PqS5rocWH07JtiMaMPU1nILKKbDrc6Pv9R+kkLJlh0SuwzdTo/QcTXKNN1pXBdNZs8PH7qSaF4OLA3IwkpfIBlJ0eiLTGT4LvwCa25c56qyAgrmO/i43FUHkrF0u4e58aV30QC2N6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b86d805-7424-459e-a2ff-08de57f9bcb0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:58:46.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXmaXX3z6M+Qat+VbYfL9AdPgT4zJCtLbuNU2yM1Ehf/c8n9JcLbro55aEWA/9ZazK+vxWhBG/NzpLeVxxUaKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200065
X-Proofpoint-GUID: Skp7gFhHRwnGRqtms9r8VxV32qfFl2Zf
X-Proofpoint-ORIG-GUID: Skp7gFhHRwnGRqtms9r8VxV32qfFl2Zf
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696f35bb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=EkPqdOoLW-AQgKYpJoMA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfXxfjpW7hLRgim
 PJCDZZW+Ccv36hOOHquJCL/PnHtOGdfznBqTbMaYSY+uKsuo7oIFicKY6cjgtFFxB9Pemy/QDVg
 QTQaLSjrhLLly7K0mQxC81k6qaoA3g200K52ClvQnSRPLezp3PDFWXu/8zH0pjeVfJrCNxKHz7s
 xyYpavMRYlYxxDS8F+X35ct4/O3cgoxVVCZdFq4PriGVEO5MURUYUrHLaBPSIO41JnozpPh+msc
 rhbMGvWXWRFGwQ6fDw3/0oGQdqNmlZlLiQEgMy2gd+x/NcN9iCMYj/O1VOyLF7LqiiTIkwNNBHY
 n9tSWQfOMuwYhcM0nyg/GJXxLX5C6URNNaTOU/JpaUNvExzWVDOTeXhvnySnU2dhY5+FUD/0pBl
 NYMMnPuBjlfvQjN/hSrkuO15AmNGyvVg/92oMcIOFxX93gFf90ihkKsXuGmUG+H6urM8ag2VHii
 J7NjpcLsYEw+4Qj47Vi31I2bHXCePGxXj+3e3WO8=

On Wed, Jan 14, 2026 at 07:32:50PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Now we have lruvec_unlock(), lruvec_unlock_irq() and
> lruvec_unlock_irqrestore(), but not the paired lruvec_lock(),
> lruvec_lock_irq() and lruvec_lock_irqsave().
> 
> There is currently no use case for lruvec_lock_irqsave(), so only
> introduce lruvec_lock() and lruvec_lock_irq(), and change all open-code
> places to use these helper function. This looks cleaner and prepares for
> reparenting LRU pages, preventing user from missing RCU lock calls due to
> open-code lruvec lock.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Assuming Baoquan's comment will be addressed,

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

