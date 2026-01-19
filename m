Return-Path: <cgroups+bounces-13311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1FBD3A22B
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 09:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2458F30245AF
	for <lists+cgroups@lfdr.de>; Mon, 19 Jan 2026 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9BB350A2F;
	Mon, 19 Jan 2026 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RM+6HQ0h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f552GRUm"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424A33A008;
	Mon, 19 Jan 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812902; cv=fail; b=NowNlqVoBjTUZB6DasIrxz8tmsqDeofFhsQU5sNHQlJcNSxnAuJGxcdMZpfUeooE587gLKOFgvX5nW/UhbCZ3KWoRYUDadSqf+iU2fs+gi9CKVBQe8xc4aWDWAIDXTv8Ta/oAQb3zU2z/eSjBKXKseLFqk9DVX6l+uc6MEumRWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812902; c=relaxed/simple;
	bh=q1PJT5D200IrU0j8BIqWWnWL0XCYhBXGGij8pT+asIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kyie/+XEDeyejMqJT+AKwqO2LOKIohzUvjz+OVdM61i7aVFRx7WKYVdGotRWumi5yCoSqkhkjfmjWY57ghA3LU1yD3CJdDgF75ctCxJeFD9fDPkNdE5ay/zpNR+meDNWzd0dD+mXTSJIxEIbjInnbsZ3/6/+KSHmecCqpFedcQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RM+6HQ0h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f552GRUm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J0kafc417890;
	Mon, 19 Jan 2026 08:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=P9OlEIxs4zz/8PZKJL
	74eW2OfwYysJmD7vWZM1AP3Gc=; b=RM+6HQ0hj5g/rXRX2qpNG9iriVz4evFHg7
	fmoYOxqKpLnN8QYPuQm/xE085yv4q+a7mCdjzM7HgPnXNCMLLCbji8ruyfXuGM4m
	WWNsqvTqXYmqXF2+1/4lDIiCXpu4P94mMxD1qCLVZHZIPZI5wrTbbR/BE7o1aehq
	uc0E8UvtVKq8G0Qb5h2OlI33AbsIpDBdHraTVoT5vrwvbOJmUqjA3z53TRAV0jIy
	kiTLhNJfLVWQUsz5Pglr3lfDlEQZc4tG2qXG13lm5jp8mmn13pOkt+DU/oU6e2Np
	Il30IO23V4WEYKfoyNz90qkDAZrAzwSfqjkgJ1jFLV3oO/kU5xbQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br0u9hyag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 08:54:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J7RH6x008420;
	Mon, 19 Jan 2026 08:54:13 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v83xm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 08:54:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qekC3xvBAGR4RTxCeX1sJS6w5DnJEJc6QKnHutPverI7E/ZDBlh4ipe1+VBU+yIhuV+Rmm3XtTe2uwzEC5HZDMwOjl1mx4F9oR794wUY9ZWq26dAXvbJ9C+YGsB5d0B2ac5pW9+zm/NHw5sSIWeTGctlQoWx/BvDS9wG8UU8HOmUMX4xXMdpNBQHZEl1QoPHjrRQ4rOerwsW4KzAHYV0mnXSyfvDYoxF32b9LWykPt/y9lkAYfpGygBnliZ/LMSVrp5NjKKS4lVg9bxhMcGZ2atZuXoDJfhvnV99e5K/iOZBaw/bU0CKDkO3CntFq2o4r0I7Q8YGvX3j+Fop1ZYyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9OlEIxs4zz/8PZKJL74eW2OfwYysJmD7vWZM1AP3Gc=;
 b=vB5uU4vuZAv8bGuhuEF9/HHx53c+vwni7O6riVMBymWJmLC6LBaD4cQDtbweLznJNJiw015Gmeu0R/E2CN8NudQJ3FKTqxiaS9v62JvV0ebI+V8l05SnIEzA/fGUnsPFUqVQFprrkBHbEh2z/Xi02lSZ9Z0Ipwit82gA9HtsOhwt1/lRBI7OaMMNJjeDIX0x5ytQ8ewfNkbFW88E60JX8Dhn0lH+4Bv+X5tmCZHbA9gI0uMcKIcFdEJ+St3bJ4t4YIV8QRJ91Fg58fIXNiv4igBki/MhP1DrJIuHx7JftrVvkCoDFvXg0fxSlKlMZQ2B6GLNSCDPXN/yCo5OphDugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9OlEIxs4zz/8PZKJL74eW2OfwYysJmD7vWZM1AP3Gc=;
 b=f552GRUm4XcyXFzRBKXnjFlR01E7RRYCLQ0NBeaxma3tINA7M3X7fHYQsZsWGY4HjDPYI2NxGTpaoB4rbJHXTB71IZFYm1flEuldIDgwsZHgMBn2kpCinBM5r7o4FJNiP461hYS2RGbRx09gOeNFd4zAMhIESgXD3dLJVx4qIcg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7610.namprd10.prod.outlook.com (2603:10b6:610:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 08:54:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 08:54:10 +0000
Date: Mon, 19 Jan 2026 17:53:58 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
        mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
        yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 08/30] mm: memcontrol: prevent memory cgroup release
 in get_mem_cgroup_from_folio()
Message-ID: <aW3xJi_lmH51v2ky@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <c5c8eba771ab90d03f4c024c2384b8342ec41452.1768389889.git.zhengqi.arch@bytedance.com>
 <qdfq2vxdma4qnt7pyfvuiyiib6ffuv46jyqsfgab643ihzttb6@h4hodwsqkmom>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qdfq2vxdma4qnt7pyfvuiyiib6ffuv46jyqsfgab643ihzttb6@h4hodwsqkmom>
X-ClientProxiedBy: SEWP216CA0032.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: f35038ba-839b-4b26-23ee-08de57384fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9AVxWGvaNtAXxgdqUNSlvU5fyCp4PcMreX/1bWe+3tWaxCZdZJob5E9hp1yo?=
 =?us-ascii?Q?ZNGJhvZb9zTOfhXi1rMkai7KFG8JknVArEElnT3qQk2OhrvvSmyxGLEIV7rb?=
 =?us-ascii?Q?bvyA+oYM6vsgSTbq+e8esiR9f3GaTx1wip6e+bTv84yKfQq29CTt5f3bFgzT?=
 =?us-ascii?Q?8rRaSQySp7ouOm6lvVJ+Bp2WuiO8Y5IkZbCN/FeDXFCFDBYCRG6I4yAntKap?=
 =?us-ascii?Q?qv6vlMLfOi6E7bM1wVmctm+Qs7l9x2ChCpj3huh6Mu+laackAi/2yhQ6O8yH?=
 =?us-ascii?Q?tn2RpzndOFTQ9Dr4ki4fxFN7YwczPTECNCJ16694uEeDisIXo8KGNOzocPe7?=
 =?us-ascii?Q?4fVjYtdVrNAHuVYB5liP8A3QejlGXFK4AuBogP1n8F1XaOzOBqllAG255ncr?=
 =?us-ascii?Q?WL+m0MYivCldp/7y0/k0riKMrjpteZmD2hbo/wAOZyPHnRlBQQbEqY7RX/76?=
 =?us-ascii?Q?nLnPO74GUeYYxpMu2IYfIsRmr6rRPOncNe2w784e4Wssc3FnTaRFzxUltONR?=
 =?us-ascii?Q?/8PCGP8E8DDZGLrRlTblzkGmGIhjY168lrkALoo3f1jZ2sn8xkwpXraU+xKJ?=
 =?us-ascii?Q?SzqKp9izhqlHhoSg12n+ynzKcEvurpsxMavH2HBbAUrUwValCH4+0veC+RDF?=
 =?us-ascii?Q?aHceSzEr1rM/zf52k6pDRijuiAgP1oSTWkYfi7/vHNv+v5yTBHJ8az2iiflx?=
 =?us-ascii?Q?26gqm+1NZOzWtz/kBusMwN6YR3qNRq9MViu8z0yRPGJsra7gtwikzyo4MW6b?=
 =?us-ascii?Q?0ZjnWOLrfEhk1/8oG35aeekoONOZXfWHpNmBgwfqLfP4DQWTuUrn0brZ2eW7?=
 =?us-ascii?Q?nvlUVP5lRlLkhk1gmVRWfFoZiO1QwiVj23dmKsu9UExBETGkFjdnOS017d2F?=
 =?us-ascii?Q?vwJlydOruHP+OM1sXkdUFF15CnCxras6il+n3TW/7d3WON7wjZdkK3ua47Ns?=
 =?us-ascii?Q?eSKM8sTf1r7OxfAzRcGRtcK92KIianx3h+XECcQbCFIX1s4lu5z4r/31vjrM?=
 =?us-ascii?Q?Cp+W7x9qiVfk30fKSaKoOpDWCp8XvrJaDG6gN3HrxZwPgRO2swUcpkAVzu5E?=
 =?us-ascii?Q?zql6quWAsDk2CbIYsq6dtnc5oUGsxgrTCzVyxx6H2tjm2P6pa3PRTuFL7lll?=
 =?us-ascii?Q?tLOOn/xdbHKWErTRoHScB6RVWtDoHP9YLOfnBzSRS5/K2/aeDl3dRyC803Yb?=
 =?us-ascii?Q?cGiPivEXCAqTUbO/BuEPTk3Yb1/j81btumWAAouKyRyrLkHeG6GPDuVZmQT4?=
 =?us-ascii?Q?EIM2bzMNv4pjhu1YXStxLYf0rd+aoVdpe5ap6cg5AxgqvJb2P4tCb+D7TDBB?=
 =?us-ascii?Q?bCu3UR7DrSNTBYR18U1Q/s0ITtV+wNVIT6KpDwiAc+YxUGqnO47mRo4MDcTw?=
 =?us-ascii?Q?D4+VOHclYeylZjQMSd/BaNrKolMX8+X/LYXJ87tFBbLiqhgzR1xSTNDdFUud?=
 =?us-ascii?Q?iSq017XNfSX3laTXF4ykvXdEiYqIkb7f9SYNrUGlWP+Fg9OGe/oPYlfy+Z/F?=
 =?us-ascii?Q?JSFFXcD9UwOe/MQnoDDFlFIZmW7WGOdf6ze7yMHeSCwbCFYx8vwRUb9kyuG8?=
 =?us-ascii?Q?wXKl1VmCknUGRLCH9SM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SstxXUaQ05gaukmIMGgU/bSBXv1iGpAyCvc1ejOrpTN3cim4MkBCm6Mv5Es/?=
 =?us-ascii?Q?QZK4UYoSD1q/s+FDSt0+hWLbtjiJGoHY/mP8aUc8h1Go16F0398HwpGN9VGZ?=
 =?us-ascii?Q?ldKsilu8oKm2pwPwldFyksi30xZ2qvE1qqZaQY+ryVl4XW2ptttZmVM5IkQx?=
 =?us-ascii?Q?+PiqLRAz+6F4v0QrccQNgXbKW2ZX15l75D6bpl1q3LG8HH0ZIQQtJGp9fPSx?=
 =?us-ascii?Q?z62ATRpOhM+gnWm0aI9zlmp1fDd52b5/k8ic9TGxHwf/P3nL/TQKux5SR22p?=
 =?us-ascii?Q?rRBE43a63r4t57V9NFwl8/eeZb2wzBtgohoOR+LAqq6EUUl4Cpv1BqQhRguF?=
 =?us-ascii?Q?pNYGxKfmDYMrhjaW+cnPQ4acRZCJ4/HHx/rTr9I/HS8PNiGQsPWVUI26GkA7?=
 =?us-ascii?Q?3DXU1IYF3zuJdc1/22xsx9zXFHNNTviiUF+dvdpH4xRE8xLnf/r8vyg8oxEq?=
 =?us-ascii?Q?EWNIkah/lUmvYs0HNfWhpEJne8ZnZm0/gNL14ET4MPtZuxjJg1fXz5nwqYUV?=
 =?us-ascii?Q?CszxcmwxUJsz4Rt+OU0Fwc1qcIFIqTwYkaWTTzLtydJAINPCSXa1kMsSEPm3?=
 =?us-ascii?Q?It5ewjPF0PandHPhJm0aWM2clv9XVHf+pf0lIGBmsxDmbXdwszLRlcswKZxL?=
 =?us-ascii?Q?MeerLWaRrA+di0LuULnse12bA58rTypq65uA0YIzLB6C8uVhm7GqlRVfhga1?=
 =?us-ascii?Q?4P6SKZ55mHAYTo+kdrdO2dNnGw3+3ivvdLiGxsfmNQRmMkTHzduiGa3K0PPX?=
 =?us-ascii?Q?PQWMJ54HPKnZTPWvE83iQ1WzTXjtW5NCia9gP2BLk8R5bjg1H7eEJp88MjuC?=
 =?us-ascii?Q?2fLSSupfHP5944gVbP++XpJbdcUJszxXTeLyiiEH5ibU8p8uNimRFPxRWCNg?=
 =?us-ascii?Q?Kkz4lFSmLjMkz54nOj8a8tLlkrbIR8UWS2ToF2Zg3MMbYcpBjzedk/9D6+Tb?=
 =?us-ascii?Q?et76yTSNZ3fU21QVN6rq1FhC3mh+JHzkAxpjE8u0VQnHlRO20e6cYDWumGMw?=
 =?us-ascii?Q?kRqylKMDzQHzBXySFa5gpWWn8QmWlf1SMQGIgDFwtn/e3uSGhNHTnCbsL1hq?=
 =?us-ascii?Q?Jz3DJQ/n/cOK84F4xRXre9vcctopWo3eWFjXKwxnTIT3St9C5R2TsmP7JafB?=
 =?us-ascii?Q?OwTxPTUB6ZRihhJxiyYeWW4lP1RrVcsuGjzL208ILZEbPWUrfhDUr4cuV54E?=
 =?us-ascii?Q?gPMHgst87Bi7DD7EFa+Ht6dZh3jnfQe4mmfFM+hU6VJUXH+C9SMa1d2R281y?=
 =?us-ascii?Q?Tnp+zzIw/Le5MKPiWzJvle7cA+A+xdM7W8o2l1h9rh60odX/f8tBw4lhkJEf?=
 =?us-ascii?Q?hMJE6Gw4G8H3Rgx9iB1ek/ZW57RrVe/E90JhiZs2qaw6YhWipzb5Lw3rfSnB?=
 =?us-ascii?Q?tVVpN/WtIq2VdZOcQHc4/783QNFQnMb0T+lks60st5cJT7qHK6yFV3MPPw/x?=
 =?us-ascii?Q?BGe5HFc1EeNXg13cSs+5yL7uDo2hpNnlYrATsvLKTiyU8CrjR+kl7zE4YBp9?=
 =?us-ascii?Q?BulKeZbFYjDpwwzX8yIZ3wX0QsNVq+vqFxWrfXT9wRdf0pCqE5EqrP92UQoj?=
 =?us-ascii?Q?VJhed/xsS32sTJBKCS0jxb00RbgiZAn6bruhHfCH2Hsmv1EXUMBWCcdKNbAY?=
 =?us-ascii?Q?NuvsbbORH2uKEPOnRQrXoTop/q0ZlWExk4yV3PT/3BGZAOHrIfuxVd3C0lgI?=
 =?us-ascii?Q?lJKiVCRTtaZ960armLGRB1VumZ6PFODnkZsy8ILSgtVcbnWzr+zFXzfSLQ87?=
 =?us-ascii?Q?9WjNCmA28Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VK7n04mbx6UF4lFahLMJB8Tol99Lw+wiB6Du/3D239mOdfsDmEa2iURE0I7zcHMdNGRw3gbf5zPf190I+ZMvQZuhwky/rfdOmc/1BK1Vw7E0pzVBmmFVIh62nvSIFUtwT0DvSwFQEsYBT0Y7XPCp3qKrNMyJRykhfOVD0iwsVMlp51CmIPbZxBghRk0q9ZJx9EVklQ8Ve1VlJyR8dpJu2756StAWsZvqKrRI5yBMlmJOvTxaATAPyjwU7NRUs0MRKlXq+yBcBKvT/m5BRPCWgdu4VVjV0cWvo6JOznmf4b8iEfkmHkhZ1IVElkTuomw/Xyw2aLtx80Bl3Jm/XtzA2BY4VdtLC+hAemJIbljIkpn/3QSY+WfXAvKUych6dLjP7FaMXTUzLFhfusOop7ZZEFgCy2nsJ3KV95Rwfl9bZotINyQfpFgef3ytOWoW/S0y6J1rst9Lj+URXHlFICWU8KCj9qIAEQqWDfvX4f3VQZweovJj0JeIYB52W7Sxptmb/DBz3sZvSoIICkquH1Wo068g9C1mAtgHhtZQK5IbiRs2aEr59xWTrbHwdS9XdZBkM5dCKxHDpImKAWqqS3JPZKf59JroGCf4Fum8ywwHsck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35038ba-839b-4b26-23ee-08de57384fa2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:54:10.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5foWWLShfrwUgDOZMIAzs0UZeEBZaG34z1hUpRG36kSjnTqaVeVYb0juZMJI5axPEpK62S7jkCsPoPed+z2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190072
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=696df136 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=vZxbLtyPAAAA:8 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8
 a=Wq1xS6wZWycD94YqbkYA:9 a=CjuIK1q_8ugA:10 a=YIznc7gRMHvxYRuyG5Sm:22
X-Proofpoint-GUID: vgSHSui8AttPX-WG_MjnqmpdDPBkga3k
X-Proofpoint-ORIG-GUID: vgSHSui8AttPX-WG_MjnqmpdDPBkga3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA3MiBTYWx0ZWRfX5ya1TQ85s7wS
 ZcEKgRMmhoeRSB4Ysug0+XkF/Y5nUfFssERGWGq/ODBwAJOYTvBKvfePcPm6TsRFTN70J0kEUiC
 e1uxwJIK8+OG9Jju/IcMjTZ6diROqT4ciJNHHfP8KZ5gqsHTSCtJ1KcJs31kk1FGvSPG/ZI3HpM
 mzMFYact14j2Jk23xgnyce1O3kEJn3b1f+n7kdO56/oE4y6Cz/GVeBJ+CtSZsLu/KSgYFVZfuTx
 uX3+uT/BY0vNYwgc+ZgXkTmLiqw6eE/nq+eLSIZx+I7gzwUnvpMThZUopcI/SbDz8NXEQu69/1z
 kqKTXmzNr4YpqCPELej2tspOoNraIvkm7x/Kl6DKHzitrks8MnEGnKngx4Qm4nq3Kaa2gOwenaR
 45fRSbYVDaOF8e64T8tnC2OxVV/FmOhZjuEty8EblFoA95h6MGUeBK7lbvX+C3A2Nj5NkLkpxT/
 8hpAbYNXjGSxoEo8FOw==

On Sat, Jan 17, 2026 at 04:31:10PM -0800, Shakeel Butt wrote:
> On Wed, Jan 14, 2026 at 07:32:35PM +0800, Qi Zheng wrote:
> > From: Muchun Song <songmuchun@bytedance.com>
> > 
> > In the near future, a folio will no longer pin its corresponding
> > memory cgroup. To ensure safety, it will only be appropriate to
> > hold the rcu read lock or acquire a reference to the memory cgroup
> > returned by folio_memcg(), thereby preventing it from being released.
> > 
> > In the current patch, the rcu read lock is employed to safeguard
> > against the release of the memory cgroup in get_mem_cgroup_from_folio().
> > 
> > This serves as a preparatory measure for the reparenting of the
> > LRU pages.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/memcontrol.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 982c9f5cf72cb..0458fc2e810ff 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -991,14 +991,18 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
> >   */
> >  struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
> >  {
> > -	struct mem_cgroup *memcg = folio_memcg(folio);
> > +	struct mem_cgroup *memcg;
> >  
> >  	if (mem_cgroup_disabled())
> >  		return NULL;
> >  
> > +	if (!folio_memcg_charged(folio))
> > +		return root_mem_cgroup;
> > +
> >  	rcu_read_lock();
> > -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> > -		memcg = root_mem_cgroup;
> > +	do {
> > +		memcg = folio_memcg(folio);
> > +	} while (unlikely(!css_tryget(&memcg->css)));
> 
> I went back to [1] where AI raised the following concern which I want to
> address:
> 
> > If css_tryget() fails (e.g. refcount is 0), this loop spins indefinitely
> > with the RCU read lock held. Is it guaranteed that folio_memcg() will
> > return a different, alive memcg in subsequent iterations?
> 
> Will css_tryget() ever fail for the memcg returned by folio_memcg()?
> Let's suppose memcg of a given folio is being offlined. The objcg
> reparenting happens in memcg_reparent_objcgs() which is called in
> offline_css() chain and we know that the offline context holds a
> reference on the css being offlined (see css_killed_work_fn()).
> 
> Also let's suppose the offline process has the last reference on the
> memcg's css. Now we have following two scenarios:
> 
> Scenario 1:
> 
> get_mem_cgroup_from_folio()		css_killed_work_fn()
>   memcg = folio_memcg(folio)		  offline_css(css)
>   					    memcg_reparent_objcgs()
>   css_tryget(memcg)
>   					  css_put(css)
> 
> In the above case css_tryget() will not fail.
> 
> 
> Scenario 2:
> 
> get_mem_cgroup_from_folio()		css_killed_work_fn()
>   memcg = folio_memcg(folio)		  offline_css(css)
>   					    memcg_reparent_objcgs()
>   					  css_put(css) // last reference
>   css_tryget(memcg)
>   // retry on failure
> 
> In the above case the context in get_mem_cgroup_from_folio() will retry
> and will get different memcg during reparenting happening before the
> last css_put(css).
> 
> So, I think we are good and AI is mistaken.
> 
> Folks, please check if I missed something.

LGTM and I think we're good.

> > If the folio is isolated (e.g. via migrate_misplaced_folio()), it might be
> > missed by reparenting logic that iterates LRU lists.
> 
> LRU isolation will not impact reparenting logic, so we can discount this
> as well.
> 
> > In that case, the
> > folio would continue pointing to the dying memcg, leading to a hard lockup.
> >
> > Also, folio_memcg() calls __folio_memcg(), which reads folio->memcg_data
> > without READ_ONCE().
> 
> Oh I think I know why AI is confused. It is because it is looking at
> folio->memcg i.e. state with this patch only and not the state after the
> series. In the current state the folio holds the reference on memcg, so
> css_tryget() will never fail.

Makes sense!

> > Since this loop waits for memcg_data to be updated
> > by another CPU (reparenting), could the compiler hoist the load out of
> > the loop, preventing the update from being seen?
> >
> > Finally, the previous code fell back to root_mem_cgroup on failure. Is it
> > safe to remove that fallback? If css_tryget() fails unexpectedly, hanging
> > seems more severe than the previous behavior of warning and falling back.
> 
> [1] https://lore.kernel.org/all/7ia4ldikrbsj.fsf@castle.c.googlers.com/

-- 
Cheers,
Harry / Hyeonggon

