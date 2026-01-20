Return-Path: <cgroups+bounces-13316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A40D3C10D
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 08:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 571C4566EAA
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B5B67E;
	Tue, 20 Jan 2026 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DZHwt5hx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SwcL9ZjS"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934E3B8BC1;
	Tue, 20 Jan 2026 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895347; cv=fail; b=eVXsL/7vWcifvdKXeLCdDmO+/Ds68En386JXyJVk/A63EAg2r+l+RLG0IJm9T2UiazGWTL43P9B5ypIos8AaJgqVXQxGo7QY2H2t93gQGSA5uaITQSHWgdtocUj/fs4HY20gbGWb6C7gW6hOi1D4WfsD9gTd5luUxj6nve9yrC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895347; c=relaxed/simple;
	bh=V3jKDA8h3aUOhJ7SV+GGt0053H0vEKqdBBkoGc0WG28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dCRTM9/YeCXvpEgVBEYHxjdELWdhinCWm2nXyWci2wFIEEEnRsxKYO/AP65vkW3yOzbw24v0b19CqbH3czTpzbycL7r8d/AEbZPg3rea057rr1pPP+PcziKEiCqCsYCVijnLbMkS92XMO+ds6tK21chK1jnizyhZCO9gxa4Eyug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DZHwt5hx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SwcL9ZjS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7KAoq1034800;
	Tue, 20 Jan 2026 07:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cloIzbaOkrY9axhBn1
	uRWWprtfUmpGdi9ibaraG31n8=; b=DZHwt5hxLvaQe0ggNYBwApzDcIFg+cyY0n
	WFZH6hFTtYlIMwZLWkocqrBBLPy/5OcISAVjcje8+AifKOQYpUW59o4E286qEhIp
	fJlIkUHSWylABD4ohiIFVcdGlufCdZ9M93P86cw+tvLmdRSg/qTG9yoayC+V6Mz1
	SETWK/1sNFk0clTL7e8Ur9oAvfzwoUl/TlV/OCyxhpo+ui1bZPm3BPb5KI+T0o9W
	v7YQaoRNLdA1c2SUE1E+CusHJoQgnjcgGkY2IJ9GOuXgTer7HEiIarJFYfkZG2lA
	sLUf6JepoWGgmLA+mbfVsmx2HyACPGbIPh6yUIwLuUYSVJaDEi8A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vu6rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 07:48:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K6eAqg018939;
	Tue, 20 Jan 2026 07:48:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrq2yhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 07:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxB4p1F+yxsaU9qMxYwHT5EuhC4lQUK566N43lolq/l0/8tuduiv7VxEHi18Leyw2TT+y6oh8rKJPASXFEDKm7Dl3y4W483k76EiEGusy41XRCgwyg7TtQrOWt3ekR9SrxaoDPJEgr6fJxl8IY7uSU6fCHnv2n+qlI5Wr77YloBH6/NqzVhZeCwpnacqBfulPkxdqcfPhaXiaxjpzV9U9jPWhtQFeK/RGn0Ewq47emscXqKLGJ23GaoOtYBoomA9/FwydZuk+IWfYtJX9MMf2JPaUWX029A5HyRbfnB/pgoKsPifJIg8+mFta8uVGc3hyf0tGHteblpKubbHrQpkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cloIzbaOkrY9axhBn1uRWWprtfUmpGdi9ibaraG31n8=;
 b=viSuo7IkjFsrwcoKxX5LGoN/09/NJB1QT2CAuvLxA5a215qIV2pw9Y5tvLg5H63U6Fhm0DYngxR8X90sB8p1VG45HCjRGLz6rtoSc0K5fOrljajpRTyZhiudVAdf7/2dHkd2Ei+jWwJKWahlIjDbk1aV82Oz1Mw8sLDWaQK+KPBP5XALIDX9lDtlxHVqvW3ZG1jZK+8Mmdqmo+GMJZ7cevoihEy8YxH12ZXSmkgBNjzfZxGWaZu5MtS9FXtM7X4ry8fXStCiOW5948taZltBR45wPlHzjjyi4m+qSg0wpS+R6VJpGUyMxOs3lMIl+8t0XfhQ3kRi7oGoWfeyU2RlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cloIzbaOkrY9axhBn1uRWWprtfUmpGdi9ibaraG31n8=;
 b=SwcL9ZjShNk466wEoupLoXl1/HrFh4IJL0wPLYfeDcSWyOsWButHMfsUBzkfoEMqrvh+TtQN8DxryaGFKT7B3MEnAiQuHNyAlNh/uXjPP80psIZAJm1QFgoGTkiLxkHbb/npJHxuSbD+OBSMh8rXeZ57VnfFRqo4Z0Y02KdMPJo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7182.namprd10.prod.outlook.com (2603:10b6:208:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:48:05 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 07:48:04 +0000
Date: Tue, 20 Jan 2026 16:47:55 +0900
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
Subject: Re: [PATCH v3 18/30] mm: zswap: prevent memory cgroup release in
 zswap_compress()
Message-ID: <aW8zKw5Ida_gKfQz@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <592f65bbe05587c01a2718443a70e639cc611f3d.1768389889.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592f65bbe05587c01a2718443a70e639cc611f3d.1768389889.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0020.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 080e4e3e-d5f3-48a2-310e-08de57f83e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cmqHUpJycmG4KDLjWB93oWKQ/0y0FoHmdhmm+ZJ+m6TCmlFePpn2kfsgxvml?=
 =?us-ascii?Q?VRWbDiUSPhCqUEE06ymIycjEqwQpgxWCbQlZspBgeqNB/VddC3GXbXFRPeZ9?=
 =?us-ascii?Q?zXdNz/QVnElAGer2njjcJ7I+F3fc445E64LaMx31mNuXNPSV8C/+yBWyz8xI?=
 =?us-ascii?Q?os+Fnx67cDUclX40ZAbW2JxMLXSEsfcP0iHJgVDiOPfoeNm9KqqpN10aM8Sc?=
 =?us-ascii?Q?HSjSoGq5APRTXpJ4zFI8WNuZdPVc5UVUirDNRUCXKQ9v6hy4AbpmKpzi6udY?=
 =?us-ascii?Q?Ax/9JNd/83e8/rEvGpsE+YePsDAKjGjn+MDJj2BGidntbagAV2788NQ8Hcyb?=
 =?us-ascii?Q?98jabKda3Wa5I55KNFUEYYuqO+Hc7DawZF6bHQql9I3iHzGqEEok4E32GlDL?=
 =?us-ascii?Q?t5NCcH4WoevA2qQC5ljzXBLS/Dyu0cXnzaXU6Jr5z8p/V+nWu5iaK5wWQ80Y?=
 =?us-ascii?Q?gVRvoNei4mtv6r3VvwEBnIZt2JkLduVfRCh80ufYBtH4QlAcBVKYIILPkpTQ?=
 =?us-ascii?Q?Zeo45ba+byxM+MyJF63vdFrNGYOvDZwx4grzmo4w3+FYCCvfoWBYHy9CIRbE?=
 =?us-ascii?Q?evl7kyXskAYiMMrMT58qwjI4pnEfctb1tbwktXTVkw+w7RHvYC1hKxepLqhi?=
 =?us-ascii?Q?/+kibQIw157hA9GpPcf0C9T2aExDiwBfaynFddXL6H8owpiaebZ3rvf4YBLy?=
 =?us-ascii?Q?0lU4HzkKcEWdMZyOvYtjQxeXUchzNImfZnXyHpD9WzjZPvXDkgq1a4XFaW6Z?=
 =?us-ascii?Q?7CcvramPKpEITPmfuUY8dUwdixx5n/bUwEM0u/KNahIGoV5Wy6Q7wKxU8iL4?=
 =?us-ascii?Q?ntf8+J6TrRipjfBLuxzJCzKbrGfyAFwg9c8K9Kv5NIKPIfr2BBeb//QENqUA?=
 =?us-ascii?Q?jrHTFLrf9UYWUm1TOfPsNgmYAfssMSNKtVeGV+Ogvc9EQEsWXffaXk0s7xri?=
 =?us-ascii?Q?EAy43nIOjGKm+H/s8Pp22fuzBZ1+Fh12PyiGIC8E+y28K8FelFip2xazeLD0?=
 =?us-ascii?Q?qeuyTfG0P0JwCREz8h2Eh7r2QnScTza0MCbCtSiOC7Cdhivb5yJFwNtQLlwG?=
 =?us-ascii?Q?9AYRwVHQR/vaxh23vJKJjxRWf+KbTwt9kZiO+ZcLA8b36UlAqznx7v23CbbK?=
 =?us-ascii?Q?dOUOt1ovNH/UFnT7+176Wc2DrYk4cvLcTd1vJSsrBpiw3XhN3P6CGb34Tg8U?=
 =?us-ascii?Q?GMkFG0Mcmag2P+PNrn433rNNFa0GUGmDbJXyo6SzKebuL7JrL/pPWGJbST8X?=
 =?us-ascii?Q?Y4sWEwFpZiuEit08SjGXJgQO4B/VnpBmP2zhcA5kTk5i079j/csjqj5Io/AM?=
 =?us-ascii?Q?l86lFifaJC03xH1u0M2Dp3vPX37rECZuHkhRxntOzXyM+QlkxkODU/sJOzSo?=
 =?us-ascii?Q?koZMeUqI2AGxDk8hG2q/WNJfeBNL7IyYzoxOPrnlsygBvvb77DrFmt1KCCad?=
 =?us-ascii?Q?2gkrDWT7sJhOxe2buRb//cY8DQks5NJ6R+ajtYzaOoS4s5MneGsOpzYJ3JaU?=
 =?us-ascii?Q?v2IY1B1FCn/87SSaUJcvNj4ba5uM8ZYQ0Nle3mus0cxcwa3uL06rJox9c58h?=
 =?us-ascii?Q?6RQslUCYdt8TVp0WbGI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/MtBSsMA3T38htICmmtJIcx49KpflXYc6YjTVrOuaMjy2vQq+lhZBv2/wus?=
 =?us-ascii?Q?Ex0R9SXsVQ0fQB3E0OOvXkfA9wqp/5ZLSrc/EOev7j06XSqTpq0FBMcAbO7b?=
 =?us-ascii?Q?sOakut1qOKf82HsIoJ5nXA/gJyQr2xAw9Bsx8NiB6qYKCnDZQkqcQeY6hfIv?=
 =?us-ascii?Q?ml04NKLZLwZY/Ua7JoQiY+p4ajsSYn5/JSJ9200EQq4J5p29T/suBjT873Yj?=
 =?us-ascii?Q?KHqt9Bm7T1QwWt/4N7VVJq7s1LugWZd+MN86sCYKEMupxlCeCXLjNUnb02Uq?=
 =?us-ascii?Q?4Rc9H6cYmU5rbZazuWIJoxq4npVEG/mBqH8Bp8vVpA4RHnJR6xhdnsZ/hGlw?=
 =?us-ascii?Q?iZ4KIIfgWYLqCPoM5bxIdJhxTxHg4eaYHNKblzSVQKMuwueRSDn862NyQLla?=
 =?us-ascii?Q?0iyHfFcj5HVd2AnU+w1J6cgZBd9zipR+rTABb5fJs75gpid2lolxv6AbsQ3i?=
 =?us-ascii?Q?nS1q/rLeWj128590i8CKZbQzgt17LYqjUlTjkIswawKlD7zuqU4SbRacO1ei?=
 =?us-ascii?Q?O/nofXOZw1FiQX2rRWKOYLVMJp4IVP59msclq2vhP4hDKXlHBTZqZ8p4DdMj?=
 =?us-ascii?Q?kLwADGjT6/Y2DOmcs8CoPCzVl8LyzEQ6pmN9cWMyx2g4k63mqiuIFY5jUygl?=
 =?us-ascii?Q?EUFIZZ00WGuQHFCPJsginHm0F18fFPbfmPXj1Pi9s97gmVUI/9irEIlgyC+d?=
 =?us-ascii?Q?tKCK0SzruMLzP4hEP8WHTjmO5IJlsAiubRRJK1GtJ/UzWLFJUdXeG3fWjZ7R?=
 =?us-ascii?Q?rIity/YvkUY0aR6AK2NzbTQEVplxjLDlq8XCaNOtAPiub5XN1eGLy5OrrSRF?=
 =?us-ascii?Q?3oHOcMxIaQ6YUwZiUI/BZXbjhikJb0arNmAFEd3QQawnv8NB0K3iSiRTycCr?=
 =?us-ascii?Q?1QPsQ6KCpLtParEN+ukMrye0vQuCqt7MPo20eVXv5xMb51sxob4iosVOO/I8?=
 =?us-ascii?Q?p8rrJzQm479gSuxkdQ5834wzoFuuQCx/opjqmr+6tdsL86lWe5t7Z1YY7Wh/?=
 =?us-ascii?Q?2LIqj9A/xHKVHlgvjDIKLUY2+Ouji5kbTtckJf0eNY8L0gl17ZaGdrSI6UdC?=
 =?us-ascii?Q?DpvcIyIig4OE5kYEd2NQoC8YiaY6MxYzWZc+LH973XW6uvTvOHArmlI+X/5O?=
 =?us-ascii?Q?nvD7ZLCbtVRm1GCpaG50bNb8l9WezEphtS9fwtHtIatzfBOLGKui9bVCzfeE?=
 =?us-ascii?Q?YG8ifnHGJixVosUy2BrrqBzwKGY3bvIvq90lRTYSeO49t2biyX+5xDCH2T5f?=
 =?us-ascii?Q?wUet4WP8uLatHfxSlpgYK8P6x6KL1Kq4aNx+dHZpB06aWy1txoaDP0MSgaWe?=
 =?us-ascii?Q?wiy4vAepA/HC/f6biUoEUNH2W1JRGqg2iE3+y9o9c2HzTPQuiihU6ywvxCn4?=
 =?us-ascii?Q?9rJmuTFTngy6pSvCJdgIBoghm17ZTBfT+aVW4x6msIhmldGB6vV4E3okT/cI?=
 =?us-ascii?Q?hbXZHI0FJiGMMK0ZNxDQTaaXzmCVuh1iGPgkQlpU8I5eXBJymG6lVGaJqiiA?=
 =?us-ascii?Q?eGZFVW4XpUVh2VRhCTHNaGyXrRQed6XT4+ME7EnpzyDmhR17eLVguRwdKpMn?=
 =?us-ascii?Q?mArv7wHz0d5loCPacM5bnlkWYA8iHcYRyEeIfjat4DGNMudj59s8obQcodtV?=
 =?us-ascii?Q?2U74PSnPhBRRvGI+y0o0nMNSTyB/iP+p/sz6fVKuMJOlZtvgRGCZaAauwi5H?=
 =?us-ascii?Q?ZFtJPQHakBUL/wBrTVs4Uvb8lJdcAROa7UZQb32wfxofD0DcmUBbnbg0sIXK?=
 =?us-ascii?Q?TyoQOb55lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gdr5LbN1Ko1ydSMuiQFP4vXs7QWiA/EqWWaSXVuS0GDuwnalXUXs7pCK9g0V7vF62CtAra5tUvjPkqpLZrQfQyRqSeAjNZxJwetVDq0Mh+5saNIZ3Qmb3p1DBJeAZacPx7UdFaQPII5ymzuCN18YqqK8kVa3225KPxRMk64yNj62FCaEIqzjZpO0WLdWMnDaEAbBQ3ACyNT34voi0FO61/VQTcJKguTm7EGzbjok1yYoznFnGThX6/yAVe//mbJtpBlWj6nro4VEOAiVo/Va3obVWU16T1mZtni+XNUofCsWXLg09kde2kRmFoAXKC6U2TLvCcaYWb1uf44heBuyX67gvO9z2hLOB1VAWrNcr/+Ow3o6QfV/IXst/YaiCNzEDUba6xAxFaiK5rlF5Q5FxIBpjHixcUAFxa2xN9063q4BZwmWuA+TTUb9SxOm81cwX1Nx/z8LmDfgiCT9pz11fGIwuNUrj/QwPED/zWp6zorqRmnh29mb+wdxAlfEMds8NqWyWJkGAdB0Sq6J3Br6FhkAq6z72pjTIabMJVX0AtCKadEzo3PnwdVM4TVCCRrQBSF0AjMlTL5rZ7cHyEAjOhv5sl6QfGN2aEvOxWz6ECA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080e4e3e-d5f3-48a2-310e-08de57f83e1a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:48:04.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jk8RXl6BlYzXq6aDrJcUvMPnZeUjpYzFBc0Cra6wTh76MSQvlIN7K7CE2cdIt0Akc5+uyBe9MxNZ6nWwmRP/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601200064
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696f334d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=yPCof4ZbAAAA:8 a=SoCXcYpnAmTxdRwB0ZoA:9
 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf
 awl=host:12110
X-Proofpoint-GUID: 2RKD1_70uirXgt_OZDl4gJrWSiorm0Ps
X-Proofpoint-ORIG-GUID: 2RKD1_70uirXgt_OZDl4gJrWSiorm0Ps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NCBTYWx0ZWRfX5LDaZRdKWmgl
 qtDrIbHEiMhMW4bQ66Q5yG4BVwZ5jSnvbOLhb455kcYcnHK9HPItkZ37eom3o3eyruWs8hl4uF1
 jyPI99nraVgksl4XZgysew9X2WgKXsYDjsCfhCGDJ0ZM5UmHYDgb0luSpdX4vEVFEIiATxUgNwd
 l9mIy+cz+0TFkls/l8b50b5iTgjLX7PRN5V3+XDyTdKbn+KZ5qhB8pi/bP/yGjFJtZuaUHxKuHD
 5YWNbICu1TZomip4fnPxOMxI37Xa03rI2xK1aKHeK2A8Jdhw/KWxeiGfF+XspSmdn6vOmwF+hwi
 WtzLUktwTzCQCsDzdcMKxg4XrLjY9vhacgPOne0ULeIOY+k4Ea7VO8Vc6f3jaOtYa4VlstVOB3C
 sdsKLYVfRA4mB2cgIsGWf2/8ShSaEvdVaY4WS6eRx+LPcf9VdQZbMTxANQuXdl8Fyraw2RwTucv
 Uyh0hAZvRa6BXfIEZ+6gypc6B0iOYWJPuAXUvzio=

On Wed, Jan 14, 2026 at 07:32:45PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding memory
> cgroup. To ensure safety, it will only be appropriate to hold the rcu read
> lock or acquire a reference to the memory cgroup returned by
> folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard against
> the release of the memory cgroup in zswap_compress().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

