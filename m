Return-Path: <cgroups+bounces-11666-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27614C40133
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 14:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A259818906E2
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF82C2D12EA;
	Fri,  7 Nov 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TErwYCxB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mel0BYWq"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3402BE65F;
	Fri,  7 Nov 2025 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521711; cv=fail; b=BBqTXk+IvGlsumeS8EhQoFuO7+iOdd2gnmpc9r0B4tZHeSkpv+JNRmTWnsMQJGw1sGit82Ab4WZu54Gl4xxfYi7ErofH2VJIU8iHLTfY2uhRa12i1rRG/4BJPAPOo2LUEPcKaNQoMwmSkr3sw70LShFA/ZVzk1I1ZBfOvOlgMZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521711; c=relaxed/simple;
	bh=dF1VjZHncRtUAT+uO9G08PUG4xrfhOXz07g5WTckU8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxxqljg9zMTTG2OCKKnceiydvw3Fdc6KgapaJuu5Evggc3EG6JJrinw+ZAyQY2HhQdqqA7HkjWawibb7CMFAUhv7/c/7Xj3YpsgptXf4V2ISUrB7UVe0xiTzsQ++dGNeei+cWkOY56MXBo6w6hPqYqF9yksVq3PXH2sZ9vzeos0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TErwYCxB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mel0BYWq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78v7d4010292;
	Fri, 7 Nov 2025 13:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1dxYkqfzAQJ0VMuPLg
	nWxRqr/DYBRXhqHw4VL/43QwI=; b=TErwYCxBAZZx3pgTSIe3o8+T6b2U/ev5I9
	thfzDEhNY7+EZyNB/Yo7MCck0rPewEwTYY529RdTF0VYmYMxLQFOo+JVvL1WMo3V
	llNP+dBvMmEJijZe+DX8xEx2vYeEXBPMADpoLCR5QUMzSQ05Ov3FcATCgLGG7iTA
	2JRUQFJBcUfasmDtpLY8+coYfGNduhsh8LnVc4pFgR5fT8itnTxmDVXalsNvn/ud
	hVkNdZ7tHdbCxtf4gjcsQZZeIyTKeaH5HiM0Z4Dsk75plffQ4AjToJQAXLL56Nsf
	ADT4Kn/1YMjI02ZQssKngOdgBxEd3Yo3ciwkIUF2ED24sY8nEkqA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yw9st4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 13:21:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7CKCvP039673;
	Fri, 7 Nov 2025 13:21:16 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndgaqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 13:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AafXdTsZKcwRoua9mFMvhDBEiQtYCYOj4pzliasZFj1TOSwZoQ3g5nSEV0dQbo+ATZAqlKj+AEswvTnc4dcdv7qC5uE8MnKyw7kJBH9HaWAqp9k0mHJ92vBmFXHUak+1q42AR6kcp0aQhAQ1yuboQAEoAk7ywhs1BsG9ckYHScoyfGODElUfXjILMu14aczKKZjITZQkntUlBpodAKLsZqU7dhbxczJp3mmoSUln9/kQlsyJqXZk526y3E7a20YyueA605w9S+6GBNNHJE+IxWVYCXJIei0eqNXyMUJ29kI78ukNFwbX707g2dAWcWQAZHGT3u7WTdy7Wgsgs+f6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dxYkqfzAQJ0VMuPLgnWxRqr/DYBRXhqHw4VL/43QwI=;
 b=W0Qta7fAxeZEInaHWEUX0fsykqVm5RHetwKwFJ+QS5lf3jta1ODYjY2f32IQp2URy6YDaVt+yMVgrQD0l3TEVOyydIJi0ZhVeb4IcRfc1FGVKD+wnHnVFtdpBu4XW3L1gvFhGELeFTYCfKN3KwVKUXgkSuhb0bvAWLRQUs2JEX8f/XLehkMkGUYA6QYEggrXWoKhEFsmk9KPu740vGJ2dnJ2WgloIGbs117hc2oiDTmmExTvq2Gxs5tbk+//aOfts5ZN1d33mPFOX0sRJbtLd9MCloe3GUZG9ozLJoK//Q/vYo1eLjIgT/vbFHtmUSxacP9FFdU25c/7Rpl8MmMYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dxYkqfzAQJ0VMuPLgnWxRqr/DYBRXhqHw4VL/43QwI=;
 b=mel0BYWqZGFy79M6QfirgELRI0XX2hGNBthPUvRaM+eN2EuUDLTgybfgq1t0NqCWu6AFYdejjlBt2BkAHaM6A9voSAYi1IGPk5QjqAaD4gOHT8tJWKIss2HZXNvOzVkOZZolE6eYfOyNMW1cne3ll34yHiZ4pgeXZU5qHNqUniQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB5095.namprd10.prod.outlook.com (2603:10b6:408:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Fri, 7 Nov
 2025 13:21:13 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 13:21:13 +0000
Date: Fri, 7 Nov 2025 22:20:57 +0900
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <aQ3yLER4C4jY70BH@harry>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
 <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
X-ClientProxiedBy: SL2P216CA0180.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edaa4a0-4a51-47b3-b3f0-08de1e008622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9udvx2aIIU1X2M5PUQktlXQ+/txTer44GV8HSZbzJBlc+xGgmnHqcIrM6LM?=
 =?us-ascii?Q?QnmS9L2Z4RRwCZcaTdKIiJNB6yTLoPZlrkVVkmA+wcaZYmLabv/27mqZ7k5B?=
 =?us-ascii?Q?UpQ2SnmrO5cl8XstbyiqV9n9vCpA2PE6uDwYoegANJxuhWlLhUb+0LggbQ6R?=
 =?us-ascii?Q?cz4+x6Vj0YtIAFiBmYW+Yc1SXqP39jeNQvloBQSa8NJjWpC/LabW9UpageYD?=
 =?us-ascii?Q?vBO25QJtDdGKoj88T1kBW3MNgp1J9DyloIdJcIeMqXNaqdyHUiWVB7oHnKTZ?=
 =?us-ascii?Q?ESefWKcbUcBxy43xUXPtHa8yxIdAfBPO1OWmO7svQRATHoI6YrqIdypuPuOz?=
 =?us-ascii?Q?nCN8E2Qe0Kw+LA7BkxGmitn+KvCRM4aH3DBIpGeK9vqBPwScR7kzQEeEC5k0?=
 =?us-ascii?Q?L08In74HWzYdz1NZA4JYSQ7ta2T+SgsH+sUCssZYWn/lLVAyciMJA5CqG0fN?=
 =?us-ascii?Q?Ifp2vAE33xSdbr9asC2AaNq3JNpfEsQ6/jIAxYT2Qj7zFQyyAF9QwJQlMYqR?=
 =?us-ascii?Q?MvDeDCvvFINRuxSpKiUd3SkO7YT3YkoHopzGUIvYjXq0TO6YwXTnQdCgbZtd?=
 =?us-ascii?Q?HDpmaaZi2E+OwN6FE3y2CYmHWRot1Yzc764e1wrHNjDhJz/ycSK3ki4X3fQL?=
 =?us-ascii?Q?Mq0PLjF6TMI7eYSCXnUmERZIR9CyAEP5NCHynW3+hFvdKvY+2Tr/wo6g3uqb?=
 =?us-ascii?Q?fUlWWDbygjYX0B/VOII1MtmQM5Km1z6abBqq055V87QIIebf7iDzxcymcOZe?=
 =?us-ascii?Q?M3XeEiNZZ8l8SfVTXcGayNBLIa+bl4pyunWlG9SToO32j1M95yyi34rG8pt5?=
 =?us-ascii?Q?PhTXFgvhDjIC98SLHun5w/v0088dWaNogmduamV7Ya/fmBr7LcOKt93MqEF6?=
 =?us-ascii?Q?/39rhQYYfH9OP1bZX+3z715fYvzkRKAG5Bm8P9xX/31jlVh9+iWenH5tyjNm?=
 =?us-ascii?Q?C6F1PWTltqYDG1wjocCCPDCPEO+rHjqsjPKjOqRzWE4XF9DBo3/oMhXRVX/D?=
 =?us-ascii?Q?nbM1hQvMEpD9/RVcJZWyzQOzeLC28a0PRlIpYmE/9IMsdvHhjYMcni/Cnpn+?=
 =?us-ascii?Q?fAFJhpADT96p1dSdhst55SpXhGa+ETYIKGZZIbpMZFl/TzWs+3F6Wd/m/P24?=
 =?us-ascii?Q?Ws6+asReOqnAXNP4Asma6gak0M4zJmZUgvl40A3Twok5ZsI8Jy8Fv7GQOaAA?=
 =?us-ascii?Q?sNjMb8WWCu95iajSmwPhnJgJtRzhiZvt1qFk0+3jmbm0vl7aoCZ8o7KcKb6w?=
 =?us-ascii?Q?jWBP6m0mF9QCXr+654LpBGMKxwNdn6zHuKz6HfZMZFWFRAbIkJzrw54Cmjop?=
 =?us-ascii?Q?hI8a3HUO6xilzez6wztOWCBIMbZT6fIWOvLOKe9Fr9vAyVInX2a/XGEFg7VT?=
 =?us-ascii?Q?H4O1yQLI5SqQcFdFa2v2F5z8e/UUIjSPIXV5TTPtt59jykgcI/sgGza0aSTP?=
 =?us-ascii?Q?fV3ALr7sy5pteSgJ669rKCYSG1WplxGj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H83YreP2PahkDA+PkAKHpWSrH6ibNNPdv8E/N1cSkztqsVlDXxGNL6XVlpaQ?=
 =?us-ascii?Q?5+96DvrMq8MeA2iksAat91a+tNFoHWNNR3y11nvZX6WzxUHe5Qwaf/XikFBO?=
 =?us-ascii?Q?cwW/v38JjIik2NKS06UKtyloyHAlsvX2SF7CTCXInFOr4VwAgWEGwkS2K1uc?=
 =?us-ascii?Q?ItQd7ofYj4h0D69BA5YDk5NL3SvZqd70QDW2pC5igqeeAa+27j5YxxhGClEp?=
 =?us-ascii?Q?o+tTwpo/JsxLfHf0eIq4LWlqqwXCQnB6dNoiwHTcxNdCXwFC27MM/bSghEBd?=
 =?us-ascii?Q?ga4KEOG0QdJRI6sX2S5iz9qgr7SUkFQAGsclGl8qXnss9AXJvkpJ9K7tsw6R?=
 =?us-ascii?Q?QcfENQZjQSrpY5dzbM6DLptGvnOWqikiTA5BgPDSc60I0S4lnSBqbdskRCq9?=
 =?us-ascii?Q?wCSa0WeM0PDDkmtiefBT2vK8tigCtYok0TtWcFwHBNuJdDhbEZdZXZusE7Hh?=
 =?us-ascii?Q?cU0IXTuGWPsFuZWdKjD7Ax1mgOAZBqCSgTzHL0tQ0H7v1C9pBhRtADULyN1z?=
 =?us-ascii?Q?TRIMjwjxaH0FY31+EKJFKgPUJw4ScMBgCRhzyRP2WVMc2uYcVmwL27B5y26J?=
 =?us-ascii?Q?cUVYrw43hAKYJYZ8qsQXDF059WJ2P1PjS5hdE7hTb4UKAy2BpaWjqXCUaNDB?=
 =?us-ascii?Q?JG6YyHH1xS/csYnYrJR785SpStBrj332mLIFjK+6p9PGaN5jLxdD0z8XCKEQ?=
 =?us-ascii?Q?ecsUB2PckamkkBh8fGF/ImqCRvtLXnNYQV6imcztfaGkL2ti0tmPpvAjAT3u?=
 =?us-ascii?Q?iqNIVqs0KA8fAWaXKYstOrp57xD1SsfumdpWI/k9eMonX7Zg7Nu0o63BOY/P?=
 =?us-ascii?Q?S3q2HsnS+OK5WyB45ilKQi40KdFawOcZ2/Tvfb6pHb6v24wBgMmCoxOSb5Y9?=
 =?us-ascii?Q?3RHCH6jlbMjtJXFB1CIJg7ek32tnoMgeS0Yeu6cuucCYNp/Ciwxcg5+vCptO?=
 =?us-ascii?Q?WnUp/BolE8PkHVBT+a11pVmXd9wszjpXRUNZpimiblbMI0HEhYZuskoYyk5c?=
 =?us-ascii?Q?N72AD8MU4EAfuN8wFKfGY5eLExsrsUWWOEgZfrXlLFeTbTXoU2iSr6RdSTTD?=
 =?us-ascii?Q?T8wJJvnfjquk36PAR5Q9Nh0fZUF0hJjEZACrhq2B+E2vhx7O/LT1ZSrTiZHE?=
 =?us-ascii?Q?HEbV+mS6nw2rntVTP0MxLUc9dggFJBveqv6Nc98KuxVuZIQnCUzV56Urztrv?=
 =?us-ascii?Q?9eZatiSc0sklRRURl89c1+OId4d3pPKdGMbCCU0eQYIhzZB5SyjuhPD0k9j5?=
 =?us-ascii?Q?XlWqvGsVRqiziWiBxu7ioSWMNtX0f0xBvI1B/hbIjUJBJsevWhnAa3eFKFWg?=
 =?us-ascii?Q?MLmxF5m0z9XS4rRRZ36AVjkPPR+ez4cW23lLl+XAvUfBAH/sJ+TZLpIRSEVM?=
 =?us-ascii?Q?qwo/peQYn9gMGMyz4uGC0a0SP4woh5twWM8qtxiEO1yeBAXVqc2C5YXywvwv?=
 =?us-ascii?Q?ZcdNaQQYrVPtZrO5JIe8D1QsJbLAWlSeQakvO4ytyD7BEyACSsJ2DIhn/r+/?=
 =?us-ascii?Q?hNYCppP5t6dO9oF2zrFeUtWveOiDi88xzGN7VLwMs2wgBwYgGYrhsEqYEvC4?=
 =?us-ascii?Q?KtehMxmyKwf1D4HQqaUieZnhWMJRq6KaNJX2P6jf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4duIJNj6pksaw/3hv9b/AuxT4GW1T1ilV2dXXwFfZHJra7rYC3kdhXrOhPrK877KsOe1oyIbPSZjO8j/CnulQtoVwMbEydGFLTs9T2s4AQYdGXkDqGCO0uOgc0z75HPEUjY+FM/BnJ6z57quFsmeMRpzoLYSTO0cRCzagLFCcUKaQ3g3UQaW/4o8hEncNrXY4YGmKgW2XRTHcDLxBWNwpyPMMx839o7EwB/qow4+2CS2w4GhxeNOJd2hDKOEGWaWYPY/AxmgjS2OGgVHOM97Ag6q0eKhdu878Agb4pniMRb8DoZm3dOVTrPg9D8TYlvfcluj7boqQAsYi/2i0eK68y3dsnJ/J9YmMYhvx1gzc5vvTacIcbd/nU9MNtDCvRX4rDeiFQykSipeexX7l8RujxVegaoQNObMdQv0H3q9OKaJN6ztSzRCogWjgIQnfguMw5n3oj73Tj/CuG6XMIbmCVU3ObYILiZzDuY/+bTYMsXCiTPSAwMw7kRv5KILwt1v0RoR3SW9goFAGbchrgEVMG/b9YqXzF/s8XnNStb+Rs+5EzSfQV3DSSCDy8HA5+04XQA6T3ai7X3MxrCQ7ytP/2zElb/qWAWQMXASzw/2AlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edaa4a0-4a51-47b3-b3f0-08de1e008622
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 13:21:13.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vt+5TPKKiMXb56edOXuqNvaDH5pxHbxDYyAMT8aMS7jQl0q08yUEpcUdEPDswLiB292LauDOf+lTLBndrm1pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070109
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=690df24d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=_kLJ_kKrpX1PSBtLytAA:9 a=CjuIK1q_8ugA:10
 a=ZmIg1sZ3JBWsdXgziEIF:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzOCBTYWx0ZWRfX65J5zNjxotZ2
 jJQKqtzcJwS8dk3RBEbGYcTSR3o+V2T8HJMcm1IgYU5bLdeE4aImkWhQxqiqCD3mSQGIoyq3eXS
 fOeBARQDb+Wq1MljH/kiHu2sH1Oa/c71V4wf01xMVa3dY1A4QW4kGF2UEZ1V5wL46+Y+r6u2kAA
 FgBw2mXQoNNBgAKzpAW9eeXB49+z87vwsFG6vLQJchdXxofcGgswineF10LlwMycpAjN1bKrhs4
 EMyAOXip5ub1/0nvadmLHOgWptQyeD+uxoNy4C9eZpvWy/JLWxSLAiupG448R3Tq2MD9Hu3ADdP
 89p0NFo77QFkKo6ZEUEr0Dme5xamq3TjhQige7keEZYOiyHszhKOLDgmc2B8Pd0is4m2UrZkDND
 FTNB7r37IFcLsjwPkhHlPpAX4CoU1Q==
X-Proofpoint-ORIG-GUID: zd2ZvLzUOF04igCfcXWBBsG4XpQLToQ2
X-Proofpoint-GUID: zd2ZvLzUOF04igCfcXWBBsG4XpQLToQ2

On Fri, Nov 07, 2025 at 02:41:13PM +0800, Qi Zheng wrote:
> Hi Harry,
> 
> On 11/7/25 1:11 PM, Harry Yoo wrote:
> > On Tue, Oct 28, 2025 at 09:58:17PM +0800, Qi Zheng wrote:
> > > From: Muchun Song <songmuchun@bytedance.com>
> > > 
> > > In a subsequent patch, we'll reparent the LRU folios. The folios that are
> > > moved to the appropriate LRU list can undergo reparenting during the
> > > move_folios_to_lru() process. Hence, it's incorrect for the caller to hold
> > > a lruvec lock. Instead, we should utilize the more general interface of
> > > folio_lruvec_relock_irq() to obtain the correct lruvec lock.
> > > 
> > > This patch involves only code refactoring and doesn't introduce any
> > > functional changes.
> > > 
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > ---
> > >   mm/vmscan.c | 46 +++++++++++++++++++++++-----------------------
> > >   1 file changed, 23 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 3a1044ce30f1e..660cd40cfddd4 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -2016,9 +2016,9 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
> > >   	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false,
> > >   					 lruvec_memcg(lruvec));
> > > -	spin_lock_irq(&lruvec->lru_lock);
> > > -	move_folios_to_lru(lruvec, &folio_list);
> > > +	move_folios_to_lru(&folio_list);
> > > +	spin_lock_irq(&lruvec->lru_lock);
> > >   	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
> > >   					stat.nr_demoted);
> > 
> > Maybe I'm missing something or just confused for now, but let me ask...
> > 
> > How do we make sure the lruvec (and the mem_cgroup containing the
> > lruvec) did not disappear (due to offlining) after move_folios_to_lru()?
> 
> We obtained lruvec through the following method:
> 
> memcg = mem_cgroup_iter(target_memcg, NULL, partial);
> do {
>     struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> 
>     shrink_lruvec(lruvec, sc);
>     --> shrink_inactive_list
> } while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
> 
> The mem_cgroup_iter() will hold the refcount of this memcg, so IIUC,
> the memcg will not disappear at this time.

Ah, right!

It can be offlined, but won't be released due to the refcount.

Thanks for the explanation.

> > >   	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> > > @@ -2166,11 +2166,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
> > >   	/*
> > >   	 * Move folios back to the lru list.
> > >   	 */
> > > -	spin_lock_irq(&lruvec->lru_lock);
> > > -
> > > -	nr_activate = move_folios_to_lru(lruvec, &l_active);
> > > -	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
> > > +	nr_activate = move_folios_to_lru(&l_active);
> > > +	nr_deactivate = move_folios_to_lru(&l_inactive);
> > > +	spin_lock_irq(&lruvec->lru_lock);
> > >   	__count_vm_events(PGDEACTIVATE, nr_deactivate);
> > >   	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
> > > @@ -4735,14 +4734,15 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
> > >   			set_mask_bits(&folio->flags.f, LRU_REFS_FLAGS, BIT(PG_active));
> > >   	}
> > > -	spin_lock_irq(&lruvec->lru_lock);
> > > -
> > > -	move_folios_to_lru(lruvec, &list);
> > > +	move_folios_to_lru(&list);
> > > +	local_irq_disable();
> > >   	walk = current->reclaim_state->mm_walk;
> > >   	if (walk && walk->batched) {
> > >   		walk->lruvec = lruvec;
> > > +		spin_lock(&lruvec->lru_lock);
> > >   		reset_batch_size(walk);
> > > +		spin_unlock(&lruvec->lru_lock);
> > >   	}
> > 
> > Cc'ing RT folks as they may not want to disable IRQ on PREEMPT_RT.
> > 
> > IIRC there has been some effort in MM to reduce the scope of
> > IRQ-disabled section in MM when PREEMPT_RT config was added to the
> > mainline. spin_lock_irq() doesn't disable IRQ on PREEMPT_RT.
> 
> Thanks for this information.
> 
> > 
> > Also, this will break RT according to Documentation/locking/locktypes.rst:
> > > The changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
> > > have a few implications. For example, on a non-PREEMPT_RT kernel
> > > the following code sequence works as expected:
> > > 
> > > local_irq_disable();
> > > spin_lock(&lock);
> > > 
> > > and is fully equivalent to:
> > > 
> > > spin_lock_irq(&lock);
> > > Same applies to rwlock_t and the _irqsave() suffix variants.
> > > 
> > > On PREEMPT_RT kernel this code sequence breaks because RT-mutex requires
> > > a fully preemptible context. Instead, use spin_lock_irq() or
> > > spin_lock_irqsave() and their unlock counterparts.
> > > 
> > > In cases where the interrupt disabling and locking must remain separate,
> > > PREEMPT_RT offers a local_lock mechanism. Acquiring the local_lock pins
> > > the task to a CPU, allowing things like per-CPU interrupt disabled locks
> > > to be acquired. However, this approach should be used only where absolutely
> > > necessary.
> 
> But how do we determine if it's necessary?

Although it's mentioned in the locking documentation, I'm afraid that
local_lock is not the right interface to use here. Preemption will be
disabled anyway (on both PREEMPT_RT and !PREEMPT_RT) when the stats are
updated (in __mod_node_page_state()).

Here we just want to disable IRQ only on !PREEMPT_RT (to update
the stats safely).

Maybe we'll need some ifdeffery? I don't see a better way around...

-- 
Cheers,
Harry / Hyeonggon

