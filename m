Return-Path: <cgroups+bounces-14134-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G1yFsAInGnW/AMAu9opvQ
	(envelope-from <cgroups+bounces-14134-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 08:58:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA928172DD9
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 08:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71FE330097DA
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587134B697;
	Mon, 23 Feb 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBnpGlSV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nizPIKNt"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED41917F0
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833533; cv=fail; b=JugI/X9hJi85fSbhg/XhNxQgCyDGtzZl5Xg3TRHFD93pgSW5LtdSpZYnMKecbcXHk2t9Q19IS+mXPi0v9GihfKzjPa5hTiRzAcYsZLSqzu4QvJnUXsXQXFc/ObZLY1zpgx2diZ5Li8hYMY4XAHbpJzUiZuSERdyHg0bnBpS7Xb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833533; c=relaxed/simple;
	bh=zB5CW10ohyvSzLDB9IFV6vWMq7mvsn0XMQvzmaKXqmk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SuzzGxHo1HXm5ttRVfRWcMibTgFiU7N1kSSBC7Us3kJPtmbKk5r5eLZpJRHO5smFQNcz0R292VbGlI3Lg75iPNgbl9I1XGL+iENk7PTUzB/5d+xTIAtEvEc4yVvW2NeVi6ydCUdMR0Dc3T0xSyvU/dyhI8oFHtdKn4wryU5SPX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gBnpGlSV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nizPIKNt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N0u1GN4030649;
	Mon, 23 Feb 2026 07:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=58vGiZyVkXpRfOYo
	NAsnbqQXVnMvTymBcgGRjNFYIUo=; b=gBnpGlSVKCLVkNK7pMHriRU5eYuDnbEV
	DdQgtMCwMncjYESvvNWMe2qAdrRWYulYh+iPTVrKVHR3w2UVRJnLkIAuDwD59rhc
	kV81Tssvu7a1k82XsXv2SV+3JBu0AfgobcjgJpvA4SqNT2qTGZipzVDcTjqEWjqr
	tQbkokyq9zC8uPWp1QYSj4hswI95Cbp9/JPPJfI/Y7UocQRy3zdMXQ/gia3+bspH
	MYtc0lmWc67YjuMhnmceWd7aadmV/et0M7s/lyEqJGGyUWReylywRQgQtznawyqu
	OmcvhlGd6k7d1O4xGvlRuuYyTKT6KMZ/nVhvGLenaiShEpBnTsG3HA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3a01n96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 07:58:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61N7j7TH028497;
	Mon, 23 Feb 2026 07:58:27 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf3581nm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 07:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC1rP04pJuO1eqZKLkdHgP/IVj0Avpn7NyOY0phwJDZpoG8NrquJ+J/+m0/70fQu8ZgnoTxTs9Eiu6XNGRnUXcMAnPzX2nK0JeGsQAjoZZOFjmnbjFhmbdzym2H0RAubI40Tm1wB9vrsAhDckVntOMxlPRZ4c8mkeL1l0J1yrRGaC6JUbjlhUlu3ovQFyG9AD67zaZi8/KZmS48mLX32l7br5sbfnHNr1wGXznYOwn9DmcfPxTgx6m4dWDwn6C/Nj9G8OUQuzrUVjj/zT9ksR+3MRxzAhiLSafGyrk3hrVvUeW+xlFlwfyYL3WBxVGnGnD8+j8e07yMs/kcpwX40zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58vGiZyVkXpRfOYoNAsnbqQXVnMvTymBcgGRjNFYIUo=;
 b=FN6hsKkenVpcSMFvymoGmAMHwch9zGy//d4aC4Zpzq10w5EIVQI8VkJ6g+KAo+E2TkXTBwupjvOS6oYPqoYokp65e+XkfIzId6CSS6HTxMiY9IWeucpMGBGJPIzZKUmrfIoMnOWq9E4AfDIBBL4RyjfUbHRH9pgupUI/J8dD4DnF7uz0xsB3u8dj6c58XvOgqBvJ+TluLS/fQscjtJxRvmtux5lT+YtM/+BPDprgvrrT+85q75Z9OChC/plzhgjhzVQe1MuTJYNz3CS7vUnfB89NIiL//AyYf4FBUs5aX5O4/VbaAH5aaVOitiNOJV5nXP6wIdlxI7aZn8XlS159zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58vGiZyVkXpRfOYoNAsnbqQXVnMvTymBcgGRjNFYIUo=;
 b=nizPIKNtyrG7jIqkGE7vdexpYqUfuVbhkUviXjlfWFwSSfHv2jvrlYB0VuHhaWJC6b50ENM/vlZgHPs3jyqyep22QilgTJOySGG3yA36LRlOm9B6iS/75Z2KronScgCQCO1nXG/1WkwI3btKZ5VXxFiOn+a1+BxG6iALkWjHiXM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 07:58:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 07:58:24 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>, Alexei Starovoitov <ast@kernel.org>,
        Hao Li <hao.li@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] mm/slab: initialize slab->stride early to avoid memory ordering issues
Date: Mon, 23 Feb 2026 16:58:09 +0900
Message-ID: <20260223075809.19265-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0129.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: db69a8a1-9de0-494c-6bc8-08de72b15214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QD6YzvsRqL5cyCHlJmsi7h1cv/sKBNzSloZfDYjjOkmgrkERMEU4X8PrvDqE?=
 =?us-ascii?Q?NWeEpnmN0Hb9pWcKM8VVeCYvF8WHNJP83u0B7lPrpEDtKieLJMmCEEvNMYdW?=
 =?us-ascii?Q?D4k1lDQ/z+jybxyGMPr5O+kJXjmclvSSAxBTYv8VbB4dELY1yq3ynBaf7xyp?=
 =?us-ascii?Q?AIXYWduG+tLhJV5iL4PFDRMyyRqaG/qQHHS10g8DgOZaMzkCLASs1KkFiXhs?=
 =?us-ascii?Q?+6maDYkz5oMvjZkmt4bWEBZ6Gp0fLNQyRiAki3+BlswFUFnc/ji/wHRxZFm0?=
 =?us-ascii?Q?ySRGMRwuCJKKugN0AE4rTTxU3Ko10qfRa02Gv1PPPuzKQdRQoiqUV5yyXu2g?=
 =?us-ascii?Q?Y0uMOpi1VdnJlmzZ3URT5f8TsBB40xK2ac2Lg7Eu+jLpP+BGVG/1VnFadwim?=
 =?us-ascii?Q?FRWUJ6tpu+BgljC2LZySzg1vF1mjYZqDkjbYGvDMJFjnIP60vUlMEJerSsiE?=
 =?us-ascii?Q?a6tpO9YmgkdRltOcK06HcttsBvzoY1gif7Ayf8wYkR98HKTDmQLYnCCmaHGe?=
 =?us-ascii?Q?2ardWpQ5GpxMtZX4OokMasGd5UrYYLkFyCP4K6uEvnr3rNuLmR+qN1osSIi3?=
 =?us-ascii?Q?LWn/ezFWJddvb+N4iGchUeZ457eOoXfI6XK4n7tWO+HTkHUJdIh6/FnQDB6f?=
 =?us-ascii?Q?BlLYKy9ziRpWUj/jjqxRcrLOvN9pbhee19ECFlWlyFkSO0S6ffqfSUH9VlGR?=
 =?us-ascii?Q?BVJ9g3g82ribrIwDPd2Ogae71290O2JKs0to/bgacl8iOOq/dsjb49HwecQe?=
 =?us-ascii?Q?PsLPFxlfmr0J5wzr2JikU+wC153btAcPr+QKnC+ZWJ59lKkNzYm4R5qak1fg?=
 =?us-ascii?Q?55YYoo9f738QJ12gy24f6SkBd/qmZEmEv+vJSrest6jYd3ovsaop5jgyBGXh?=
 =?us-ascii?Q?apWXIC3HM/PicUSCyppsSwzyBUVwByi7nxHdJg6ilJW3VrCuu5D/rskpu1kd?=
 =?us-ascii?Q?mkXiVirdtq4oo86vxfk74OTtHCyhHoCGmpHLFK3pzZstLBxdvfaaPqZxvYNY?=
 =?us-ascii?Q?KkD5O4ranavehFuB9rEvgKrmcXm9evwHzrVAfrzSJnj91cGOttLQ09aOE9bd?=
 =?us-ascii?Q?Qm9xOxSy0WGjqu3mjbFbnHnVNmaotIVX86UvkXkQdjGn2cVIZwcg/w/xlwPE?=
 =?us-ascii?Q?0gWm85hVQvPD71G6R/4s/WnHX3b0ffNXM4iFKiWKUdtXnAx2ymHlcGdCKZdi?=
 =?us-ascii?Q?Kn6JCzs9pqs3EB1bsVV4AzzsJ5Xc/yTA91UvpjUd1bhAa4fT/bA8YktjCD6Z?=
 =?us-ascii?Q?3+u6RS2oceNRY9mCiW4h/UCp8if+o7hzqG7dETxi8w/Xo+6jz30fHGMnZYrV?=
 =?us-ascii?Q?Pe3ewgftbbMYtyiRF+CXMcbDdP8BBbAKn0k2Cl+Ybm6ddJSbUYQIg+XnWJq+?=
 =?us-ascii?Q?1fF2FkqMymWMRJ5yG+mwOTkaJZtYeZjXdusnaB91wp18CNAVt6/r10YItbJT?=
 =?us-ascii?Q?kCTYXkr1qIQtbNgT8W1YatMvIonVSR+LmW6qq/7tmgdpkkByztOQAgjZjfhK?=
 =?us-ascii?Q?CuzTjTkUtLoqf+D5FZ8LDSBByLg5bXjHPpiWSkmFTUOH9GTJCdZp2WFDIGUV?=
 =?us-ascii?Q?25Hpl8qQG7HdNxy00ss4mmVN0qmTYlAPgcu8Yua5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pw2VpkMKr367Ee8Bf1qM4UZg1G1tMd/OZ4UcU8pnsIc4EXPciFXz5MzltPXu?=
 =?us-ascii?Q?j6Sxcy2YJuJJ9UZ/QGiz0tn+zc/hftn8AfI3uYSLpoX+OtZJHnORKsPcmE/k?=
 =?us-ascii?Q?RKUfId6RdVibvC0a9k20u17FmYs5/IX/K7PNp/tpNGnUv9xZ1olK2fq8tKwX?=
 =?us-ascii?Q?fcmWlzjgmBjt5b98Tp2OrxTzifW9jsip3F672HkRZt0rjQwCCi2sV3zmKmL3?=
 =?us-ascii?Q?IfSJ+8Di0ifT+bHs6kJi/z6OKRNaVKEVvTteKDHsF8c2SLCSiZnv8+PcakCN?=
 =?us-ascii?Q?/kraB0rYbjmr5GSnMQ7dU2rqf9zDf6OnXQHlAdqH8HCKXvs88QpE23J49PMj?=
 =?us-ascii?Q?3Tyswz906mYYon1UdOlmFbHs1a56IUWN6r9IamDkcrxNmy9dwV6ZzPcjMOSE?=
 =?us-ascii?Q?SqYIfu3/6D6WENQfOyK/tGqaBsxuouyESNxsnIT8RtK49k+ilB8zXzYxpJv6?=
 =?us-ascii?Q?QyFQn1C4wuNdOoANuJWDJz9RvK7kRCBZ85jeZZpyO4NyhakXat2gGveZZaMp?=
 =?us-ascii?Q?oVfSIGCf7iayRWHwmTl6tVWlpYdXA0W8+AEYHmpmabvENm4FRnHUeLq9KSzE?=
 =?us-ascii?Q?ZqRcHdqveH5Cr8QghDtgTDGXmcr+zNyK7ptqIkdj5vo6PPXTNR+4HMZ/smCE?=
 =?us-ascii?Q?G7g9dO7ttfRhpp/w9lRn8Krd33N5spH1vUxVqshMRrjW29W/nY4vCkZpOasf?=
 =?us-ascii?Q?Ul79jzuPLYfOFjj7KoOn8JaZwexsY2HcDm485dIjqRnrp8Vic31V6/dkO9O5?=
 =?us-ascii?Q?tr1XGu9qfssgWPNVhg6Qog9KWm6/t0FlfTHYyzKEaZcufCThHI3kgiIcTUr7?=
 =?us-ascii?Q?HdXLU8U4h51gUm2S+IRcK8R2HSsLgAxBwOa6EOjWzdi2UaeZiBJVBRZ8LfHK?=
 =?us-ascii?Q?KdID5/zEJMeDNdqdz7FcELDaISs8QCM8AIVI2NIKeUrz+K0m8Kl+ZLGGpQ5t?=
 =?us-ascii?Q?mOC8BjwJ0pyVfG7AyyIDdFi3qL2K0NoNlDB8xh3bDKT6qtlGsvitoFf6YddZ?=
 =?us-ascii?Q?ih6qOd8RVLsotQ+KhMh3LSiJS5AZIX0kCmIetEolyreW7MUvo9xxEf30IwJR?=
 =?us-ascii?Q?ABRc8Qnds/tX3Z28k5o64899eK64Nk9JC3JsHDkSP8RoKSA6s12Bk13Azb64?=
 =?us-ascii?Q?TkSzySGCWhrNkiLaKwyRVsOSRnExUKw5syNIhtWXuD2YLRzDkeArc5MNvy8k?=
 =?us-ascii?Q?7EUkFEge8VNOv23wZYacNhkUM36nwp7MLbrfqqNPsPR5mG/N+Stvj6GjOdBL?=
 =?us-ascii?Q?VeMaKkFSzI36VHQMSKNLXtNSgeKmlysaozEkNm6jHoEMv3ls9tx8DJATy5m5?=
 =?us-ascii?Q?rDunUDIxdKC5JAjN5z4cDspOGd5l+ke6bT3rO7H3of5+ZyUd/PY55ueYdjGV?=
 =?us-ascii?Q?6+oK1uTm84SQqH4TQxmkhHiIA7WfbzfYAWo7IeAAGobkAhk+yf6O3X4lvVyx?=
 =?us-ascii?Q?ondMMkqZksALNLNIL4jz5nzRYamPD1fFQRHIb4OTLtuaj2CKhtDQjSopPbmQ?=
 =?us-ascii?Q?BGx5WgHzhPYxZ2pHf67cKk+jm+jydpU23KsfVlB1626XX0JqUa5fSLSz4quU?=
 =?us-ascii?Q?hKc1qGnTvFIh9VPvgv+p3SmmcSUEryxEzP6Le9wIkWv+zOilKNk5YhflsRKG?=
 =?us-ascii?Q?kgA/pihJ7U1/ucChlwEOgcEau/k/HSILhhEOoQtDR92b6ZBxWPr9jb4+Ee+q?=
 =?us-ascii?Q?/bS6qBDwYe+JPYMCU9cyIUcP2JyhsbY0JscqDsR9q4bA9q4F/atubs9HX9DK?=
 =?us-ascii?Q?86hTnPSdMw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CDdWhUCI20TfmD8ixXGx++8k5MMPwezFP+vRY9UKuBOpuqV6iBvSyj8NYfUw9YXbv2QmNI6egHR3pRXqKlxuySmbH1CcjHYLzThi30nqSAx9FTd/zluaeWCftVOyrhm9YyKEPLTRNxSV5v/dAYuEqNmMN33eBcHBuA2Pb1JoSpLDyUok+AhRRTuBnk9xFgJAJ4tFSSihBIpe30zXSIJ36GuCSGXJ9tlDaFgiSWhGcL6zSwA2sCa18rbeaXeYiNhXrmKhSaFUStfpQHLnja5ACvdLt09VPzchzveeKPCbRcy6Lim9gMiL9Du1nci3NxLOoKXzZe8vQucyFfzxxvTUthN/wc7hY4LtrZdv4tkJI6e9874istL0rvUeFN1zEJOH/P0d7M0JPkn6seJuQGEiSpSvoe1WwoPN2eF4DIUCfq/PTiqFJKfNLz0mO543obOZXxD0qnV8HK4uYsQzX96UdmvQ8qm6EZWsS55RCi4xlLbEoiWhURvTA5hVntGnRui99umMqXJcZtnJDn/olwR9i/K0eir6ipYDEkDVd6captUpXnOVnYopy0yHvJIQp3PkdoZNrkBDcd9RwBsO4iQ8fHKdzWii3k3lI4R3ZZknj68=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db69a8a1-9de0-494c-6bc8-08de72b15214
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 07:58:24.6466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVBWUrN4Q13Tv22Ulz0IMJjV14PdL+4UJ8GljwCqQyAEJaEtkVAVrKKLyaSnHhYEIS8c1v7OxOhP4eu79Rrexg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230069
X-Authority-Analysis: v=2.4 cv=IskTsb/g c=1 sm=1 tr=0 ts=699c08a4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=MeQ2rRwuPwZ-KCUY91cA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-ORIG-GUID: 4l4InuSO9I2gXI4kl3xzEvyJdyyBoHTX
X-Proofpoint-GUID: 4l4InuSO9I2gXI4kl3xzEvyJdyyBoHTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3MCBTYWx0ZWRfXzAJNFPZGDGm/
 LRQjZZLnJnp2cZGJBGKRMej6fw9gbF0ordNgpKMH4CeUKw9XRNcVTZyesTtyzZQpJpD5zXk3UCp
 b1Vv8y9JAoVIAvcRDHyjV7o8nXgrF7vS2w77M8Rqb9C3C9V7FaaJib1Ac5ZvJV80NxweB9waq/P
 qrxqt2MuSBmzz0Z+EpMEXRZdB5OzaMy8YVcUoq7Z4+GSXCXcYShkqynr5QTb3Yuf32MM99OF+ww
 7TwdsVUlnSYE8nC04fLnGCRvJ+jZ++uRE2rIQ5M+iGAAiJbpRkTyZbHn1A6DvDMeTFEEjtlft8+
 T1P+NmMBtg+29OXu6Ye6UDIdaQuKqmC07yXLOjunh4d9tXpetrKX+6MMrpBClpvl5VAJWUU032m
 X89lv0Qj4GFUERB877RZsGuBHwc+uaiCaCqggOped486jgW+ySGtAUKv9l6jzicsM/TPT+Ajtiy
 9VER4+IV+jgMjMkLYAQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14134-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BA928172DD9
X-Rspamd-Action: no action

When alloc_slab_obj_exts() is called later in time (instead of at slab
allocation & initialization step), slab->stride and slab->obj_exts are
set when the slab is already accessible by multiple CPUs.

The current implementation does not enforce memory ordering between
slab->stride and slab->obj_exts. However, for correctness, slab->stride
must be visible before slab->obj_exts, otherwise concurrent readers
may observe slab->obj_exts as non-zero while stride is still stale,
leading to incorrect reference counting of object cgroups.

There has been a bug report [1] that showed symptoms of incorrect
reference counting of object cgroups, which could be triggered by
this memory ordering issue.

Fix this by unconditionally initializing slab->stride in
alloc_slab_obj_exts_early(), before the need_slab_obj_exts() check.
In case of SLAB_OBJ_EXT_IN_OBJ, it is overridden in the same function.

This ensures stride is set before the slab becomes visible to
other CPUs via the per-node partial slab list (protected by spinlock
with acquire/release semantics), preventing them from observing
inconsistent stride value.

Thanks to Shakeel Butt for pointing out this issue [2].

Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
Link: https://lore.kernel.org/linux-mm/aZu9G9mVIVzSm6Ft@hyeyoo [2]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

I tested this patch, but I could not confirm that this actually fixes
the issue reported by [1]. It would be nice if Venkat could help
confirm; but perhaps it's challenging to reliably reproduce...

Since this logically makes sense, it would be worth fix it anyway.

 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 18c30872d196..afa98065d74f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2196,7 +2196,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
-	slab_set_stride(slab, sizeof(struct slabobj_ext));
 
 	if (new_slab) {
 		/*
@@ -2272,6 +2271,9 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 	void *addr;
 	unsigned long obj_exts;
 
+	/* Initialize stride early to avoid memory ordering issues */
+	slab_set_stride(slab, sizeof(struct slabobj_ext));
+
 	if (!need_slab_obj_exts(s))
 		return;
 
@@ -2288,7 +2290,6 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 		obj_exts |= MEMCG_DATA_OBJEXTS;
 #endif
 		slab->obj_exts = obj_exts;
-		slab_set_stride(slab, sizeof(struct slabobj_ext));
 	} else if (s->flags & SLAB_OBJ_EXT_IN_OBJ) {
 		unsigned int offset = obj_exts_offset_in_object(s);
 
-- 
2.43.0


