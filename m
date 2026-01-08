Return-Path: <cgroups+bounces-12969-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E4D0265B
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 12:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF823302D391
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A43446C4;
	Thu,  8 Jan 2026 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G9VkMrZK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D1ibkEMY"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AD33DEDD;
	Thu,  8 Jan 2026 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861712; cv=fail; b=IGV4UBwKoYO8LUFbjHfgFhQ8pHC2HA+n5m6BtSiZMHd3oVdBLl4rjaQp3++MokP10vO2+sSaW3H9ZXaOrBOXGsAeysza/zb/Bcx/9zTmCVpvzAy7ZjFemboO5xINeicVOjQKB+WKUJZ9ZHI6kKjxqoAB9uDu8iXv7LCh8LDDUYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861712; c=relaxed/simple;
	bh=KqfC59VQnpeMFjq/15IL13yYen1m7Wg1C8deBnh/M0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ApBqXU8nsblR2mekkLJ5Y/Mr1OIDkSowwfHG8KLaQanI04slLiUpdnMeSlJ+vtFcxWqzUxcy05jUehOe9PJfrPgCquBLSgMUt5NYOCTrbTbnhhbVS4vcpBc8haFwKGZQI5ooD0qHTLNNfk2fPI//oBfuuB9C4hdvpv/Vm7HraSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G9VkMrZK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D1ibkEMY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6088LjGZ3972881;
	Thu, 8 Jan 2026 08:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4XpIdTdohZdVqYqkAf
	1xOjyrVzngN4NKCyBTg9qN4xQ=; b=G9VkMrZKy0SYhl7aCB/VYv/W31KNJIh1Kz
	BI0N+RHbzmya75w/ybY2lmtO9rnqGJSOVkH/AL1uZRxiw0A4Ue+DXz2AHlH0POza
	evqnnkbxMk5MGVe2rYPw+dclAD79ylV+QHYf+l2uviWWDZepbHFmZk3HDvYrS1Mk
	cj6LGDwQA/4zgaxA5dDMuZ3jk4tw+5wMDNFT1owYkHyGQXxqHupL7tszbvrC1BE3
	9ITMJH0j5XCoBTTrsOswB+5Ox/HeeCNdKKFO/wPmQXf9+LkzCc+my/4heZtx/4Pa
	JNVq5Lsehadz35/jp4pX6IpTbavLrNUlcS6FrgHrdb4qLpWh2aTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj90100nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 08:41:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60879i3h034119;
	Thu, 8 Jan 2026 08:41:18 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjaty3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 08:41:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHJvSTXnG/1DeKEPz2EJ+a26GI1yp6iMI2j7nCsEbRJKV5HwhoWk03NmfnkBmqZGf5xnFcyV+2hNiRgI+3rHnGQhRxYYhh27znWjCQ7SAUbFuF41fFq5vXjXLeQqC18ooynB6fuKP2XAg9SyfFylfkzh1bKhuF6rPi+EewVXUy4nFz2VAdEDuesC8MGMuQ82Gb8ud7xOjFnD+wQrqt23X8YvnQ5exR1AeH0DSwRn6Hm8eRuRPxoLUNJajyAcdu2o2/fJ5i8z4Xx26Nd2nNYIZpy3rOT5EZBe4K6OSowGky1nNiPI0537bL/WBhVdcIlWl5hf2SmfWN5kQl0yvsMNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XpIdTdohZdVqYqkAf1xOjyrVzngN4NKCyBTg9qN4xQ=;
 b=VsyehZdg2Qgk97DFUcSrgICVMLlmm9t8mf75Zv06JwMwFd40GXJBBCNBIV3tP7r8fUH1fUM78LNMAQrDT5E3TyMP9ajTUqS9cbk5pHEIgPG5lTf9X0tV8fSa1SEBxu2+n6vIvTjDZxBy5nZ3aWtz+s3Y522KMwfgLSPV1G5Si/tkQW+Lw6Sgf1jx0m1r7ypq880BycKcUPqgfC2vLf4EAa+MiF/M3pDsAiutWxW4UCa1LmQN5D6aHLkFRfzJNN/s18CZFr5TFHiipyFfclCDFbCAEhrVoQ1vkoI2alkgUhJoNjEhaNa9fqLbtzY+Sk9eY6QmIQ+cpNZmG8NHoEBw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XpIdTdohZdVqYqkAf1xOjyrVzngN4NKCyBTg9qN4xQ=;
 b=D1ibkEMYkyRML3SnBEL8GhvE4sOgXYEeI1EuWU+BT2PiTh9NxYfKfytfJje2GBMaiR9NPB4TigsmDsfnTYxKRNwGVuxPUNF2NsklxEDO80RxikD+L55vlktF+rRpQ+ctPhwSzaBKS3MJW2B0EmAHmSEf4wsyKyiKkO7YqedKXk8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB7984.namprd10.prod.outlook.com (2603:10b6:408:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 08:41:11 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 08:41:11 +0000
Date: Thu, 8 Jan 2026 17:41:00 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH V5 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <aV9tnLlsecX8ukMv@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-9-harry.yoo@oracle.com>
 <fgx3lapibabra4x7tewx55nuvxz235ruvm3agpprjbdcmt3rc6@h54ln5tfdssz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fgx3lapibabra4x7tewx55nuvxz235ruvm3agpprjbdcmt3rc6@h54ln5tfdssz>
X-ClientProxiedBy: SL2P216CA0148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cbb7ed-2b77-4252-3ecf-08de4e91ac84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92zl0WZQ9p7bYm22wn/SCeyNkRqitzIDfGMYgM1+ftIFpfoxbzx8wyHflZwe?=
 =?us-ascii?Q?EYGqk3ewEMxkhMM1XGS0ORytPhWlLyr90ilq3dib1cB0+Cf9q06jCkpurLMX?=
 =?us-ascii?Q?uxd+a9ONu5raajCSZGPawT3plye2YdmC+9LVuPi+cu/KmOvOzbqGqhcBKicK?=
 =?us-ascii?Q?rlnGotQzS2SbIz9+UXeD2koBQF8xYJRVltoo/UP2lVd4flE1jqKCEqd+U7CF?=
 =?us-ascii?Q?YBHZZfB68th7mgWs4hzF4gNAHiqzY6eIMnnSLEPnZ5EmCyRR1Wveo4IMhkwC?=
 =?us-ascii?Q?p0soNz4NmyNi/DJWWdlnLMs+2X6IG8fIaP+qW309qdSCOn6WwZbkzgqmKBsG?=
 =?us-ascii?Q?8FtZYbRmlOH5A3q52U9CGftFNtlDCvMje1/VAT9SEi8P8QBc0GHvq3tfKPD3?=
 =?us-ascii?Q?pF8JmEUt18Np6ww41bvzbhR6gHzkWO5eEuXGQS9vkLJAi6cR9ccYrIPyHjLI?=
 =?us-ascii?Q?Ae2nJCdz/wEao/GQaHm7zE4j5vSwd4kxxvgOXaX65YZjMzKgmD3ShiNXAkgU?=
 =?us-ascii?Q?z8oUQNKTiDIwnx2inumsv4ABVAYgQBcCNjwRfetuPlTrO3Ttk5I7Xpg/mah0?=
 =?us-ascii?Q?SJGEoQzjTpFilT5ZHqn4Ep//hy9YiCT0HMS3OnCkvzGWGQsWMbGtnrYxC/+a?=
 =?us-ascii?Q?ewG59lIv7qNmEre0tLLRF+YRaGJyy6H5VjtkW9UMowA8y40U2nU/JLigPWHo?=
 =?us-ascii?Q?6TQdDSXS2hMfxpC86dXfFJD4OVmjkQ04IvdmIUSOZ5BuKagKlEL6AvfeQi37?=
 =?us-ascii?Q?vWqu06+X3HPtC+1hNFeEkb5NJmXYfJ48BIclHUe5um1uxduUwbQQ6pNFmKVB?=
 =?us-ascii?Q?epeKE59u7tfy5px/viCaRql9bmVceiZghZAy8Xwj5tjHAurGQcmDz77W5bVF?=
 =?us-ascii?Q?ifG6+DUKLMAD1Np3tCISJNBY1doEQgKM686l/OiEBRCR3zlpeoHq02rcNGJV?=
 =?us-ascii?Q?BtAOe8sBw8FkrkQVCqT9KglEk57fwDWLRP+kopfM4wDUUMNrDOs1fVe1S29L?=
 =?us-ascii?Q?a9qC5mWl5N/PEJ4oKgWtmX2nxZLb6+w9bLhUf9dl2bHqKCR0rBSkAX7CioZv?=
 =?us-ascii?Q?OiktfDsNlweaE986Gt4Tzi4mD1BhKmOKu5qGg7RnJqB0Z8FfvGVU796ADzTx?=
 =?us-ascii?Q?sBO7DTnOIVAz5f1a2zw2BjnhRnZjuuFDk64Zs8TfOVyeXNcIfI8sZBUh19pS?=
 =?us-ascii?Q?Qb0WOm06s6mrWA53EqNMfDEBsdWUnNwiknhO5lRX68VFkRfibDokkFlzuP1A?=
 =?us-ascii?Q?4LXkXDk3VPcSAiyJ686bW5hqr14SmQtifQFBNKWhRlCt+ltBzuS5pmCIP8xa?=
 =?us-ascii?Q?LZpkt47Os6WzVxwGGgMLCZe/KPkbXRC4C+sDNRd8s6DWMACqR7TNx+J4QXzb?=
 =?us-ascii?Q?ka87EhH3X9UlzcgyK2U3ackc05+Ak0JoWyQl1ThylhUeJvukyDHR8380YFg3?=
 =?us-ascii?Q?+sp7kpz0tU7x9Jpbi5XOPdy38L7VScwS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JrPdKkNywEaa3zGRcYGWeleXFATI0gIwMjhDWNyyJ/5tO2kRC67tH4VjX2zJ?=
 =?us-ascii?Q?m1T11lbUfJ/fpQV/RvJDFQipRQenOkIX7knUgWPuebFbSM4zzbckTeJJlxZW?=
 =?us-ascii?Q?ItwpPGlVz+thoPfL2WjEG7A8Nzg0U9BntzQO6CABYdKBwg3zBpmASk6qrZyh?=
 =?us-ascii?Q?PcJPnn5dmmwog/Py/u4FtmesXU5k/vOagv7yRSfH6H/1WinTB8xjddfdK2O1?=
 =?us-ascii?Q?DvKOS3wa2/acKrTybveqUZt7mli9HBcHXNquoUsL+/UDWoGPNaLY8iEsrJiW?=
 =?us-ascii?Q?um11BtmS4m4kmPeh6NA2a97v2iJ3qN4S+k5VZz1MZVL/w+nb4VE5CwQDZjqV?=
 =?us-ascii?Q?BXKdq811mZDHTY7rKEJ3ENMYxxCamLoKGuz5anDDplHY/5jvCMo4QMRzUvn7?=
 =?us-ascii?Q?dzqqG7jFhXY5oY8uJQFRC34u2ftRopvxkNArmMjaOQp1fob5O3bD0SjH3fc4?=
 =?us-ascii?Q?r2D28GVPtNCbT85umktA+p+oMn2zgYJ2vzv8I1rhsngGVUiGOH8itHmcCjNt?=
 =?us-ascii?Q?zntQN1hTm3njBbTXCgA08Vkh5ffoOlL8toaF0JpiSXX8LyteZNXAfceQOmA/?=
 =?us-ascii?Q?EeRaXsBemGLaMLMdLOTKJGQJccLzAIoSwQMDbelI8tvS5bbap6Us4Q1XHmyz?=
 =?us-ascii?Q?YharBJ8fT44gkECuFBJWdmvxb7kdZQEm8B68eMZmHoJoCJW+N/zGsyAyZz73?=
 =?us-ascii?Q?2i7w8qQhv4soA0HiTgbULxo7eafbZEv2LLWxBbxOBC0xEB3tWKh9iRaeRiq7?=
 =?us-ascii?Q?QXL29MNQ6IYfr14eGzvXLr4nxHI2Yj//qAj+c609XdEaxcKm6j9e78n9EXKW?=
 =?us-ascii?Q?qwuK7O7Fcufl50b3uESXoZVQzm/7H96HNsk0WmpLHzvc1lufMvKX20KmAsuT?=
 =?us-ascii?Q?2OsKrPquYUxDYzPCekHBcdMRCnlYAPSleHx/vUE+mvugIVAwIk998cCDkDUY?=
 =?us-ascii?Q?c06YqlaacfMfazdp8eFZhuziXGlTpgsIBqk2Bka7A3vuj8om7H3DkG70Gvwa?=
 =?us-ascii?Q?GqVkBLYMwBr02rN/86RoHebXDISuCvbB6D21LguSHzEZ6nQYhq3ZsAOLQu2E?=
 =?us-ascii?Q?A09dDAJX9GljPaQu0iP7WCFmX/TsCXNJGkTwcZZWLBBrDuVjGdhfLJpywBxe?=
 =?us-ascii?Q?zSrYUMls9BwEnHPnHId4YFOGnHDU/SFW4gSYoONVtdlnLxrlzkk2mzx2jZsW?=
 =?us-ascii?Q?ymZao3XwI8ues+ZsaH24ULIAbqsxqkURWSbWa9jdoeNP27Wh9TtfhLX01jCj?=
 =?us-ascii?Q?tjarTQ46OXzy74lq7TRkuSyRnz/Y/qjkeV5cBTbdB72Z29XR1UcRzuKtAkQD?=
 =?us-ascii?Q?9s4PRRV2RoGnKFIyCsKakPvc+cRa9LshhyvGEgLEglAv/6gpZnISiUIqs5ob?=
 =?us-ascii?Q?kXzBRUO4v/xIDrYI60NKzxGzhizulzmHpXgDjttKAqY4gX/UOFJ7WNLQ0yHS?=
 =?us-ascii?Q?BWzgjotT8ULZX5VZZkSMdbuW9mUiYPYCbQ23JAwpycpvpOqVW+PgiHjfpTf1?=
 =?us-ascii?Q?w73UhxRo02s/VFMltCV7VXrrzVF/bwwYt2lOoll9rhOAAfNbt2HpKKKi/xql?=
 =?us-ascii?Q?SpnPcGWuRebIL15nuvMK9b38kPSMIXRUELFu174tv9Y8hiR0ImrbS72jXoEO?=
 =?us-ascii?Q?fE63uQrmeU0YywC3+3S25trrHnkdNcR2HxwJ6rXIyohELwCZJ52qGh2pBtzS?=
 =?us-ascii?Q?gKlxohmy2RY0I2zK79VosMYNlX1xybnK4TMpzQygZwJYzunkBX8RMxOIG2Gt?=
 =?us-ascii?Q?y0BQ8RpOWw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2uQLsS1gTPrE5D9EVHNvN7VtZqqOyV21Ws4ALddv4ZCcsQ7Eqx6X+DV2L8w2vMRDn7woJoHf0xokHv3dyTOuZ6vmqGQpmFTDAnEcs6ybSYjbNsn90xbVcdMVvTifDRFObF4vQTpNDttVM68RiYbPD1Tbk0bIIENj3RrVjHtTLEjmQ/yun7CbM2PUsJNN+WFQgEcop5+z36xkH0dK8/oJ3nQQ5P233zlI3aOso0Qk+X8gQwmluIIqJTWbZQQZjxSy3tvNU3/ZYdTSjW0gWSWVX+D4uUk5ytD6f829jjK/ThsD7badopvjbeof4GL9OkrlcY2y1negid+b39EZk25N5uERNrx7vrkfTdtA4qxt/QZxi9SwTIPbOIhXSXeCAzPtjycoyvWuB8KRM67CRZRBNEFl9N/6RS3fu4eT82c2QMrzv68dPqQfu8mEGX1jcMvtXfySs1ISlHnYjkezU4eh0yNqhswxwdwxMH8Bumvpv/qIPcwUEVUfoVH9ZTVQVsilaQcHDeZ9JINBcR8ntzUs4xODkEmDwt/6+V8x8QGh3zGYZHOVe1wYSKN+spXqRVZC0pNBtrMcb2+pC6lRn/ZRdHU8AXGnPjiyaB3XhxeYgds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cbb7ed-2b77-4252-3ecf-08de4e91ac84
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 08:41:10.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLzG1i3nid9hgTfUCAdzS7vJbQAggkOePnpf264ZGwwOB2Y0ghSGJmbNktNPb41yGaNq9UpynU5ICEZFoyUzvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080058
X-Authority-Analysis: v=2.4 cv=HfEZjyE8 c=1 sm=1 tr=0 ts=695f6daf b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=G_hDdaasInn1gm4QszYA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: BRlQYPzM-HUU7WrKFeyxCVifonzRcDRQ
X-Proofpoint-ORIG-GUID: BRlQYPzM-HUU7WrKFeyxCVifonzRcDRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1OCBTYWx0ZWRfX4z+QxhxDjagP
 WGW17HdqH8ethvDXEmTmV4xiHZudigUQY9KwJU0RKTBasMMEbTAH9dt/26Zubfgjt4P6bXL/ISA
 R/hWjxUjbq35c6D/WiHC6f9Ol9O5Q7zsZQQhFcSf6JCSR2U+mrJu1zz1+MBEtEwSPcfV//jM4a2
 cUyaBtT+kFF35CGFoSXDW6CBHTDLcsXkI2xGdSJdk76dUmb79a+jJUBY01QVwMot/h5R6EwW2Oi
 qDBBG5RGqRTnwhjEehR34WA4jMMyTdGjTBl9MWTZTyv22DjbySxFpLYt51CKgh+0vDTvehWrkex
 79ikhgOehIp8jwh+/IF17saBHzwZs9WdD2+VCXACxeij1NDDWMN2a/i+aK8yyBhwR8pCKZDwQJk
 91y82F7vJai8aOVlvduzKtZwzK3HkEb99jsSGYvW5ZDGA6THjEfS8GRro68RCfvwLi0sy4//Kdi
 iO9rUv74GrUlTAiJ6xA==

On Thu, Jan 08, 2026 at 01:52:09PM +0800, Hao Li wrote:
> On Mon, Jan 05, 2026 at 05:02:30PM +0900, Harry Yoo wrote:
> > When a cache has high s->align value and s->object_size is not aligned
> > to it, each object ends up with some unused space because of alignment.
> > If this wasted space is big enough, we can use it to store the
> > slabobj_ext metadata instead of wasting it.
> 
> Hi, Harry,

Hi Hao,

> When we save obj_ext in s->size space, it seems that slab_ksize() might
> be missing the corresponding handling.

Oops.

> It still returns s->size, which could cause callers of slab_ksize()
> to see unexpected data (i.e. obj_ext), or even overwrite the obj_ext data.

Yes indeed.
Great point, thanks!

I'll fix it by checking if the slab has obj_exts within the object
layout and returning s->object_size if so.

-- 
Cheers,
Harry / Hyeonggon

