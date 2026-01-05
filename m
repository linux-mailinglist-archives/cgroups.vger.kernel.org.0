Return-Path: <cgroups+bounces-12914-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE377CF2509
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA5A3075140
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125732DC333;
	Mon,  5 Jan 2026 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P4d1nAwL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pqsk9YLY"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837E2DC783;
	Mon,  5 Jan 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600221; cv=fail; b=C8FMr0D2wtMEYiOnN/5WhBrGDVGpl7PmHOnbo0VDq5vxeE70V0psZs/1rE7ifiitpldqrowx6/Uy73JsabjNMdX6WV4jor9jlYMUZPNrCx/Vna/bkBiczpLEu0NnhekDLQXq5b60QmbTl8uzOm89WJ+tka7iHIPYrtC150Go4Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600221; c=relaxed/simple;
	bh=3RmOe2gjoD4x6ILiGKu4BU2fKNZIbgsPSlg7PEzeL4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGWwPzNk8R2Tv6BcDo5ewVSEeLRzOX2ywFw+qNnm0A0iYK+I9WJ2/rUc9JzXnsL5WVIaJCaRko5tc7AuzYJOgeVA6gKuB4U+RohlyCDwp5oZoK5HljvPmLp3cWeIOknXlUFkgNAfaZ1BR6HIOVxwOsyMlc/4TvlJy7hFNA3Mp8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P4d1nAwL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pqsk9YLY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6051BecO303509;
	Mon, 5 Jan 2026 08:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X9hXyBeXASqMpguByQLfLFSmnkVIMnzkiAUM7X1b2ZA=; b=
	P4d1nAwLInXo0R87Us5l4dDWJZFAeJPNylkaRG0TGFimr1TePrGYfER597tvdwLS
	yQroztwbHO6ro+kLtrjKPTHjrt++uKMzqL81mPj5kLG5CUV0WMBxeilO2ljZXXOq
	HDt4yZQV7GfzkuAxBUjQZiiY5zngisHz616NkNFZm4s00beWkimxa2KfSk0VajR0
	d0r/rlsYj+ZbwAxReG6faY/cs6FsCKjkFIxxsqzekBxBC5em3NIwvFLvYXZDS/7r
	AZ5lfiHQI94ECoFrxlDEiREtpCNtSxvb3T3JXfzHUiU3bBL2viKYQJoUTNRwkwRq
	7J0kDDiJUAUwX7xq+XMZMg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev5qhaxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6055rDbr017260;
	Mon, 5 Jan 2026 08:03:04 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjhc0er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:03:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scU/DR4kSkFsCX9lBnb6j1nR3W62tuOJzQNDwio9+fu2GtfanuUkKZ/yk3RVwmf/Y8YimhJ0KY18q7VxaTBMagiT/tTr5rUdFKsEy5/+fqHXS2ODD04IacGxWauTaOiFD5DWJrBdjhKVeatI/dYVnO+FxYnbEHWaJro+CvtzwTXW3wMsc+E0jWDLMmw9sDToR1Hbtn/W/a2P95yLJYPByEyn2+4l4NE+k0beRuRD9y77AQJ+pX8eQ477rmw88ORN3JVQ4GYrC7WIZEpAfFDw6A7TlI7ZKaUYmofY2RmwhVD4q2zlTCviR2hBKGt/HrXpZx/KgG2/w7BMKma0Kp7yQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9hXyBeXASqMpguByQLfLFSmnkVIMnzkiAUM7X1b2ZA=;
 b=KohRifVeULLgf70srORWZS8/9FFkpIxu6nJ3UkbC9lEZJvTpy4srtMAqJqAvjzHfl7mFDctDqloC8pRdEygzapCtw5aecNQlH7bAMhfSPkn3n6x8g86tbAtHxn262QZ71bctYdFtlKTam9qhPT5TOzV4/3gu8I9iHgXK8qoqJjVXvQxmSZMbDUDtMFPWHjhCK2GEaZr9N+p+9zwT8VIyhIvz1L4fbBp6stjsRuMQvOQ7xRoD335ReJTRPYhy1HRiVyzomz7+5oJ603wbieeboMSE6uHoBLdKwat/0U9D9vhDKrhBUEOWFBWudd67f258j2TXiaFUKnUSb528uZibxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9hXyBeXASqMpguByQLfLFSmnkVIMnzkiAUM7X1b2ZA=;
 b=pqsk9YLYkoiB9olaWzobuQQAsyFf7hne6klo7yQ00Z9xf0OKW2xirf0+CeToim0IlfMqs6DrxxF2o/7LdLHKyncXgCpIjjL0yNS+tAwrqSikLAGFT/3OzdbsM8oRQf7D4hMZ8EIsxy/Ss+t0tWKCKyaagzHXBflDt/Bq+u0xCGo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:02:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:02:59 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: [PATCH V5 5/8] mm/slab: use stride to access slabobj_ext
Date: Mon,  5 Jan 2026 17:02:27 +0900
Message-ID: <20260105080230.13171-6-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0215.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b33f22d-c994-46b8-140c-08de4c30d750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9UXQ6a+vwLuWaOFj00Bb4T8KyjHBcZZFUN9qMxFhthb0R48VAS5LaJj306g?=
 =?us-ascii?Q?x2f1okvzTm2bF3nHRCYdtTUDSzuAEG+8ppMr85OzPjDgf0SD0qOZwzVyRLzy?=
 =?us-ascii?Q?bPqliegzhfpruee/Ddutszz56DeiwnQ64LD1A2hBCdok6LBKJxr2JF9735XU?=
 =?us-ascii?Q?h0E+WsLBB/6F4JUWc9PRfN0E2rZh5d9nzuGXUGjPlUpTYNFnat1nCjcRzAeU?=
 =?us-ascii?Q?t7aPctaOsMko370MSJg+k7pbTJgMTm5KWfhCcLdojFM2l4rrMrSYBQId/iKs?=
 =?us-ascii?Q?BD88PypE9UpSNbhK4M8Yg9SgX+uGd8iKndwhUPyK8hu4t8UEGEeFZwyN9T6Z?=
 =?us-ascii?Q?8mtAFv5UJ0jMcPGUksgAVMIOOgqZsDJ/l6IQnn5iaNEcsid2mMogpZF7loNm?=
 =?us-ascii?Q?NBI0s+btq6arHDfXpYvLeQgAuGkVH3hbmFMymbGOvzHepUbn3fsMywRXnn9E?=
 =?us-ascii?Q?uMd4CW+Ad2vuxK13bZVKl0Ss0YfCNB9/tE38/068QvtJeSSuQDf1IVk0bPjT?=
 =?us-ascii?Q?vQSj9JUgIHsTxSHfKlWQGqzwsffUp7ZTsvpFtJsFio67NkYm+dU02Cd1StNE?=
 =?us-ascii?Q?QGtWfe4QOSl7Dld8Zk808+XZceE2t0cJP4U+Lpa2uRsb8ipAHgFn4Wo8YOgp?=
 =?us-ascii?Q?+irwJ7y8FjyEUx2UudSdY+UXt1AOkJKlQQZm2CiZhDC9kJM8isFwn9Qv4ZWF?=
 =?us-ascii?Q?GcII4pElgGkzjfWQII38fZdtdfoakONzcxjmLwADGShyiBS/sgVuXUIt3enJ?=
 =?us-ascii?Q?LbLjVH0ul9LKeKHRw707X62EjE4QXMqYkOKfXsdRH8cn93xdijY2TQ7W6p5s?=
 =?us-ascii?Q?0MCvAKnFAlc7J6ub9H297S1MUtsZP3KFd7FZ4bdXsethZrMMJ6a5Xh3Wnf2Y?=
 =?us-ascii?Q?kbZs/BnvPMyhH+HiOseG68Bx5GrnwV1hLovymVdpNvPdXI/J9xMIbKph/dbw?=
 =?us-ascii?Q?rh/2c91XfV1RC3gpi5/oQE1x1Y3claKidR+8TCRf3bLtiDKg5uY4Y5pMHJZb?=
 =?us-ascii?Q?XoMUDPEX+X3NtjrDf9vaGpEurdJr5GD64f8wkFDBWDRortyDLKQ9qUSbrBTl?=
 =?us-ascii?Q?7XsuB2hsEYM3hZJE60gjGcCNPLI09GHt+j6p7PEq/P61yfFPdk23ivVyKyBP?=
 =?us-ascii?Q?QF94HDfDcoqB/x3eCSXfHzHyLJRkjH1S8i8VcttlXksiGa1ybAxHA57oBaJX?=
 =?us-ascii?Q?O6sgiOZ8uVbrWS1Hk3f5T7hFtPqOR1QzdtLpmgvRndFfNLqK1d7FlM8Au4XI?=
 =?us-ascii?Q?8iperyzVkPQAn2tZmf8drBx7Ad3J2Y6H1We1F1UQnGZSjEgzaHUClEglDqv3?=
 =?us-ascii?Q?pEB+SV2XHRK4b0Ej8iJV8GxWbSWMMHKWHvRSwWkNYvMEmMmMFGz7hPckE5RQ?=
 =?us-ascii?Q?aKjaIwaA04LAPxUUbUpa5BbCdYmxh1eqhyKK4jBKa/JuIrt4Dy6xdQSEQTYR?=
 =?us-ascii?Q?HXDfXDvLg4q2IKjpqhzY6xyI9AUtY37A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvh7TI+WaZDIzyJwE0NIb+84E5Jo7yGSb37mup5hW18K+nT6zPMXF3TBjxXn?=
 =?us-ascii?Q?V1NDzsE5L1KTtiE3ManqxJYT5L4xf8fUTH9DOPA0whRwvq3d8w1qRscH1ALd?=
 =?us-ascii?Q?+Mdnua+tpi3fIPZoPr75xF88+Xn/nFS50d0FXSL+Yf/pIHb/1WX2Yt2OFHNO?=
 =?us-ascii?Q?kLb6ROuamCjI712eXeeA296gRVizNxFSpgdu2CYZxoL20LlegiTxa9XsQph3?=
 =?us-ascii?Q?FF08tyr+dc9z/bXy+Ic24BcJQkSQtfLOMzDaGi69cn/xas+NBBH5zY/g9eSQ?=
 =?us-ascii?Q?bGdjWS3n17+Posi8btDoxdDqTVtbFN/UKcivuZxT4JP0s1iBc/4s6a5cGETF?=
 =?us-ascii?Q?Odmkq4Qr4Xfm0aW+mXOWi76+0d7b4bZzxSeOTKglcgfoQa9tEwvSDpEYUHmT?=
 =?us-ascii?Q?kDAez7/W3QKqRl93fTikInUwEjNem+XldM/HeU4YiWdI1mqF5UFyvMrq80aj?=
 =?us-ascii?Q?o9N+6TfvJq2UYPhYOPgVISkqqnyCv6ab5T11CDHU9jiYjZUqs8VN8PMi10Oh?=
 =?us-ascii?Q?rOToyBvRrsLNlfad2YVgzJFyHejzYlBkznui4+bbLsXYvfXCIk7HqtLS4SDu?=
 =?us-ascii?Q?IyLvcqUcUfAG5n0makVhuVSnpz87pI4dTiosXB/+V2v15D9c/qTzAp7jiDsi?=
 =?us-ascii?Q?2CZq7gOwE84pUjequC/tfXEFaYfjoDt3gF2+6j4MB4sr0pLj0YCAjW9VSjiM?=
 =?us-ascii?Q?Ysyen3s3K+0/9AIx5jIQl/oXb0PrDr2Scj7piUKVJaoJNWpGxMae6d5NVpVV?=
 =?us-ascii?Q?K5ttDWGKDK0m4uiUQvg17xtthJiAvyIle2ozbU7jKiOwOh60NCvDJR3Jwe+M?=
 =?us-ascii?Q?n4s1T2yNtQSZYv4DD7ZpljZyiTzh9fJ1/IgUWJbGNhf+Dr2YNJxCKdpbzlzm?=
 =?us-ascii?Q?lUqjx9LTBG+8RCx7ODrzu9YSY3PqI9rtAci6eDpm90QKkzoKK5oj+eAovdV2?=
 =?us-ascii?Q?TVEyZQtW9JyRKJJhhUjluWQxThOW0G/UpkVwpM8dtrFSkaHNn0r2mi1L7/XA?=
 =?us-ascii?Q?eabAL91F3WDBVxA8wUYXGLzjXEA9lHbUTcYFKxby014lHs5IFinPnVZKNUAZ?=
 =?us-ascii?Q?QQsRNqL55cyvi/kGJWutSEzsajh4stsaW2wOw7zC1Ca2bPhWuwjBn3ZDL4GP?=
 =?us-ascii?Q?yrI+VKcz/WVW9QmuZT464IunHb9r2hYsg7z0t2LBLAZITiVtSPgKqVJCnV9H?=
 =?us-ascii?Q?XLhRAkuH5jFvMXicQWg1be4+2wjBL+fxlGIcHY/M08j+9lpIXtLBH4PGBo2X?=
 =?us-ascii?Q?6JPGPRW9/sB1rQRlv8MLd+lyb1cKQ93/LXcwyEvCB5TblVb7cSTM4SR5s5LY?=
 =?us-ascii?Q?d3mHYpVGRwQBawn687YSes9Q8Dp8DS1NH3A9RcPYEmeJcbqsP/gkraImGD8R?=
 =?us-ascii?Q?fKSvotH/XPxhH+rZS9QAE92a7Maew8JktVfxmur8+BeAhs+rOX46oydQqyVl?=
 =?us-ascii?Q?eJehXGyvkDZlEkEdbThpDCvzCIjCW1nFi1njJQoAJoXwDeAuY3x+ShE1KfUC?=
 =?us-ascii?Q?vpLci5XhqCu7+sPGSUP/KaIKsFK7MjZBjWKw5UF53FBw7HhasY4ACPkUvwLi?=
 =?us-ascii?Q?WkwU6Q4RuE6lczMgTaMYBRiqEXhZd8w3h2VhJ3GNRSML+Be2oHdp0JoXx2KK?=
 =?us-ascii?Q?SsKksuONDjZW1AI7EPkyFzd+vJO0bw83FdYfIO87px8IVMGF2UQ66uLxpZ6i?=
 =?us-ascii?Q?LQVRtItEM2FRQCOBQX5ieRYucPxB6/dfy+nUOVa/wbzgvg23/+hjMlsv1F9O?=
 =?us-ascii?Q?Qkz5XS3paw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bvVspf2T2E+A9qnD5CXzooIuotdzUvxLwWZFeygHUD3uEIB4QBP+YyU3vdQXhCE9UpUjJIYZFvLjbYi9DWXfnvT13egF/nDQxkCsNOe3XvZLn1s0IsRSIu/EwHST+I2sSO+HApNc7taC8USKMEVoesmRctR2DGac6gCWKVoYXdXQIGH3+1T0nWoCIAk27mq6acRtTP31NsuzwNfH7EWc+JWHIKvexQe6/PrcdMMuSuv9WbEBAp+4FZf4zmiW/xwSPgFxyhCNfVaeyrK+5uh/ZrtZHW6FHIKp9edhamT3WVhdEsd+DsTRChZhB1H1N+URSfyz2LToimtOY2KqtNK4t0hx5ZcPw8i4M877fd+Thzi12ZJhjxsT2QI4Xn+mNNHrJsjeAY9UF6dxAnp502rD/xwsVDWwX3wL77D2A84kzy/6HOeiCW5zTHD5GHwyMTbQXxT7tUPn0HJF4HYPj11syupTglckiZAdRDFvW3pTwJCwoPAbYsFh/MlTb3V1a+tpxnmtGmYP17TfaPi/dOEb6RQXckToNZldR1kmYi4OnqyYNTb9+xexPg8T0fy4JHd9olU6HJSAD5GHxS9JuqeAVk9KrEkGwjR0WXyT+sv3nnw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33f22d-c994-46b8-140c-08de4c30d750
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:02:59.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nZUABHsYsOD6tdDjSCCHKb+YmPmjUYihzGFXvdrF8C5gl4DPa6vJOaIidxnw1+6FP2rdTmg2/Rn0ymsNu0m6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050071
X-Proofpoint-GUID: LmL2QSLJsma08-fdYVO1V4YLkjSut-g5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MSBTYWx0ZWRfX+luX7WAKXNyl
 A9AeYeaVAQI4aMc6erXAsaEHEzw1mVnwg8NIgN+B5OINGCYP7yCt4ITCViPvQIlPzRv4+bWJG3q
 cRKUNghuxNw4PWHPKb/PgR7KWyQAiBUNpQMw+6hxzhUBmk3WNQrGOnF0yVWjDjYzoVFkgJkz8xu
 gCykUQE88A1p7MqC7vBbWAj/jgh7Vw3evM2g56xpETgLzwjj2+EsnnPEpZcfKuBMIbdSzXTDpeY
 3Yad+3ZkKWNf77DmExyPEJkn7UGaMCFsNjEk13+AKTIRzESH67VrQLre5NcG+HbmmPYvw0vZcyI
 7tj/45hg7wvWoiZbOtUUmLm6fSH6yW3RoD/GmV+LOYJvxdHODaef/uFZbX4Mb9kHLIq3WR+zdJF
 5i+DKDCfw28dBecnk7pPFivHii6JZ+10W3jATBHbSxZOTR20kLUMsCw1AO34NkrlpF9VOwLFYGk
 1OvOcvYqz0Z4FqPgACf04WjKcnhupRetNViu00eo=
X-Proofpoint-ORIG-GUID: LmL2QSLJsma08-fdYVO1V4YLkjSut-g5
X-Authority-Analysis: v=2.4 cv=cePfb3DM c=1 sm=1 tr=0 ts=695b7039 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=UZPuyEf3i8-D8iXyNNYA:9 cc=ntf awl=host:12110

Use a configurable stride value when accessing slab object extension
metadata instead of assuming a fixed sizeof(struct slabobj_ext).

Store stride value in free bits of slab->counters field. This allows
for flexibility in cases where the extension is embedded within
slab objects.

Since these free bits exist only on 64-bit, any future optimizations
that need to change stride value cannot be enabled on 32-bit architectures.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slab.h | 37 +++++++++++++++++++++++++++++++++----
 mm/slub.c |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 6bd8e018117d..a4e48f88fa5b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -55,6 +55,14 @@ struct freelist_counters {
 					 * that the slab was corrupted
 					 */
 					unsigned frozen:1;
+#ifdef CONFIG_64BIT
+					/*
+					 * Some optimizations use free bits in 'counters' field
+					 * to save memory. In case ->stride field is not available,
+					 * such optimizations are disabled.
+					 */
+					unsigned short stride;
+#endif
 				};
 			};
 		};
@@ -531,6 +539,26 @@ static inline unsigned long slab_obj_exts(struct slab *slab)
 	return obj_exts & ~OBJEXTS_FLAGS_MASK;
 }
 
+#ifdef CONFIG_64BIT
+static inline void slab_set_stride(struct slab *slab, unsigned short stride)
+{
+	slab->stride = stride;
+}
+static inline unsigned short slab_get_stride(struct slab *slab)
+{
+	return slab->stride;
+}
+#else
+static inline void slab_set_stride(struct slab *slab, unsigned short stride)
+{
+	VM_WARN_ON_ONCE(stride != sizeof(struct slabobj_ext));
+}
+static inline unsigned short slab_get_stride(struct slab *slab)
+{
+	return sizeof(struct slabobj_ext);
+}
+#endif
+
 /*
  * slab_obj_ext - get the pointer to the slab object extension metadata
  * associated with an object in a slab.
@@ -544,13 +572,10 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 					       unsigned long obj_exts,
 					       unsigned int index)
 {
-	struct slabobj_ext *obj_ext;
-
 	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
-	obj_ext = (struct slabobj_ext *)obj_exts;
-	return &obj_ext[index];
+	return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -569,6 +594,10 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 	return NULL;
 }
 
+static inline void slab_set_stride(struct slab *slab, unsigned int stride) { }
+static inline unsigned int slab_get_stride(struct slab *slab) { return 0; }
+
+
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
diff --git a/mm/slub.c b/mm/slub.c
index 84bd4f23dc4a..8ac60a17d988 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2147,6 +2147,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
+	slab_set_stride(slab, sizeof(struct slabobj_ext));
+
 	if (new_slab) {
 		/*
 		 * If the slab is brand new and nobody can yet access its
-- 
2.43.0


