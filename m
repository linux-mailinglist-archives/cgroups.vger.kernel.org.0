Return-Path: <cgroups+bounces-12966-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968AD015B6
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 08:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D1FF300DCA7
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 07:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D57732A3CC;
	Thu,  8 Jan 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FjBgAi4B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JyFz3l27"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E15695;
	Thu,  8 Jan 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856485; cv=fail; b=ApEhNSkgvxLJNmWyQZz7JOCCX68L2uNUE4+ZLTVg1o85eR2Br65P2QCRsjZHCGdlauLeFfkCoBFfl/nZBFvF5lwGhwVqh9O4zbyYHHA4uZEfed/XHbxVu3uff0dUotGkcR0c7iM2C5/0OotBu6bL1YQGzgiSuhm/wEyGKxT2ZBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856485; c=relaxed/simple;
	bh=9rP4FUigpAFpoZ10WRN8dQ6iFovlAkZkhMJHH5RxmC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FYPN8KXctp2H6ANE1caRSlIriCcOk3IZ9TJS7erhu72rqte+K9TE0leFuCTtLWhRjYpQq72Zr1u5AEDsd0eC7rLCBhoLH6L7UqkKsyY/i8h+T0kdrgKvRVn00tIAXdmpB9iiaPq4FfpMczBQEAj0aGE10W8IHoZN+xcBA3ac46w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FjBgAi4B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JyFz3l27; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6086L82N3779802;
	Thu, 8 Jan 2026 07:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VNUVan6IJgVdffCPfo
	nb/MkPOEs2pdF9B1az3eLCXt8=; b=FjBgAi4ByRC4oHz44MkhXennkWiJQsLGOP
	HiAPBXVI4OLI716M+vMHmFcA1gO9510nTQLYMjjgN38VgienU6Qu0MiPz1qrQKBx
	kHHe3PgqzpuLbh25RVkWkyG5FCzatgM1kGNTX43wh20Zaux19hOpjqPob+hcxUTO
	qdR0z7PjeIWabONgrPWzkNRFZB6xsJCIwiQLOHMZRw8i3HW0f5Sb6VH35hi7vRKU
	1ncXMsIniAMkOjZBZmKc+DC1L/tVQ3pWJ0x0E+MhHdeCl9EOWFxvFyiHxNkMVp+r
	Qvi6gDxyMt7/cTOJyJSD+0XK68A/s1OiX4rsUoErlOjmxkNoLfoA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj78481d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 07:14:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60850rSX034230;
	Thu, 8 Jan 2026 07:14:21 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjarm6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 07:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deIWTNuxZIGfXiwZsaaycFE5aes6lWyWJDrvcM3wQTkhb4JvRMsPozFQ+tU7qqfPQt4exnce48vFswUNLrvYKGiTTxQxKP/xVwHMvs5197UmOs+5wUcucOTvT4/ICg3+8fKL2ENoppdMhMTf7QslXmZvqYGbe7gZvDCSLc9xy7PpNzGs9135BO2AoVL6iLuHWM9oXr+W3ppvndQ1hg2xjey8Hm5q8UGsUFkaBytxW7Us8cQv3JK5pEMyFG2A4+8djLv3CFbCF9BIf3LNe5X9iHjkCIUqQZr0jRZEXVo8FiGvFhiPacyo+gamAsRnm5R2onY/vwnvUXd4MVQWZxvzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNUVan6IJgVdffCPfonb/MkPOEs2pdF9B1az3eLCXt8=;
 b=OLuqLSjUzn8yTmYW0WyYxX1lmzMIYnO+gJoCi12eNNe7/YU8a8uOjcfs1EdXvB956OwjxyxndDRZygizRm91mfLd0iNgiiCkaJVbI4ZGx1olz7Oh6ktzZ/J9cz/e1zlSre1WnqMfX3DpOGExMr7x0HMeBgV8kabtyMqBc8azIhjv5cylrztn31MvGh6YjcSH0Ynh4WO4WgioFSWzyBUA035t8+N3sav8K1s0DSdjZbHXau2az1OkOE+LBUeA8M+w5zPJlGqQGSiOzTTNJ24Y6RpxPR9YVq35l3vorLr85RDzy/ylTEmVV4/gfxS3AZEZrBlny75OP4bsGCozTy+exQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNUVan6IJgVdffCPfonb/MkPOEs2pdF9B1az3eLCXt8=;
 b=JyFz3l27uNA52ILLhvuJHNzzCYC1I0zjXxswAHKQcwggewZQKeZEFBvW5jX+RxOnxTn8eNq2fga9DsVOXa/eoaUqjuWVZ9GkYoGdgjgYDJ6gTWaKSrFe++jmMtpGcVhV4rUg2MkCvyrgGr+K0LiCmnYouhVHwDeqM8E5L7BneXc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:14:17 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 07:14:17 +0000
Date: Thu, 8 Jan 2026 16:14:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
        dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev
Subject: Re: [PATCH V5 3/8] ext4: specify the free pointer offset for
 ext4_inode_cache
Message-ID: <aV9ZQP6nMk8rmXy0@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-4-harry.yoo@oracle.com>
 <e28c08e4-5048-429b-97a0-8d51e494efcd@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28c08e4-5048-429b-97a0-8d51e494efcd@suse.cz>
X-ClientProxiedBy: SE2P216CA0097.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: b38d62d9-2d43-4fc4-96ee-08de4e8588ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIjiGLQnU2U7QNnVg3M27mnABr/bYbjLRST7LDkkP+GMHbflcir8YDGKJwem?=
 =?us-ascii?Q?gpeGcDyxg+R13EK3W+iFoNLo1sIpOTaoe/YNvr5mnUeJODwiihbX/+5rPcFy?=
 =?us-ascii?Q?deq1hyFXwDkIj6uFGcF9o5S+e35+gleWwVrMIOdEjrEDdrPRr3zs/TiLQKj8?=
 =?us-ascii?Q?ZKwniNI709EOBWqKw1Z+qk+f3nAonbmn//A0Xmj1VXfxseXPxmaz9egLbCTs?=
 =?us-ascii?Q?gIE+QPIAaaGQaFfo3pzIJCBTnQU7XZrvTaI4YtR8zTtoUD6nJckUmTEJ3nUO?=
 =?us-ascii?Q?eKecJDaKhaLggMpbYzbseafzhs2tPCn1A3M2EXZJKXAexXUjBbatzTy8jVtS?=
 =?us-ascii?Q?puYJqpKXQDTtsQIIbABSFW1dZrAw2JVrp1vcvIsaYVwzfID1JwYq9CPzBaa0?=
 =?us-ascii?Q?eEtWjLbnwr+vs/EJ7MTHTEudbQlVGJUcQ3B+AZUEgpi5sJsjgUAY8fr8C2dK?=
 =?us-ascii?Q?pSXIPSYtlw9T4KB9iWHEQT1GevdJf+KLpEkwWn0/SK8M6RyiMBbQWns9esEG?=
 =?us-ascii?Q?CCo/ypKB3Y6kbbVikwHMcFFQoG9hz+Aj/Y4iGvX6DhVwpFKlH/lD7+Syfjzv?=
 =?us-ascii?Q?tEcNjspuPW0keLUuCKdJpZH2C3qx9d3JTRQpQTR4UeLu+xcBWM2xWfIMyeJr?=
 =?us-ascii?Q?yt3TuUDCC7gx1E9CPuLxVAbSoNUN1NpLt+LCN9DWkNH364yag424c7VspuYx?=
 =?us-ascii?Q?q2AW4dMvWapGQH+LD7Tegitd5GzMEianBGhbEVTrpNkINZLFbF0OJNBL+Jfk?=
 =?us-ascii?Q?65z6wjS39522Y1gZaG1wyPRFzr3IZoik8OfMZS+JGJ1pnzX82AnEmcIr/Q/4?=
 =?us-ascii?Q?jSAPfkGkYAMBPPP2doLPh3Jkd/BIQkefDXgI6oUSRkIzzy/rKuLV+OgDu78j?=
 =?us-ascii?Q?Osm29cKIkNGwmg18PMVxn3lYnQk3unzUH/X06q9QHtbTTdlxFXuwUwgFmAJx?=
 =?us-ascii?Q?BI8BA1TFF3OdENu9GC1WC/SA+bXPVUaFLFMEsOkmEWwcr7gp1HbmM0cx/q3K?=
 =?us-ascii?Q?+gx7ErjAdNdLlNAhlYGvIGC2qJR4NY3vZpbA23X4WNpCnK9ddoMtOHY+TvOS?=
 =?us-ascii?Q?08l5aaNjVzhPcA1qZ7a+KCVFlI0JakTnt3f/cZaT3vlquXo5sTGPw4rRa+TJ?=
 =?us-ascii?Q?G9zoktyVwW7SFu6yqT7j0tHtT2bzsmWcsQQsiOcVNGjHOiUdJftfscdY2gCW?=
 =?us-ascii?Q?XRw1FcXq+ArpxH2qqqbDVPFXKvHIeKbaElYiKHVQScr7mlJAd41c0Chu6ibt?=
 =?us-ascii?Q?XWbfgZax1uU4vrBfVqEIMhfMgIIIYHPPm82bjVHavj468HHQpQju1FeBKn+m?=
 =?us-ascii?Q?i0kxbzutx12FzZyCroMlDJC15pPmVPHuEiYuX53DDG4kAknORBZpR4bmAzWY?=
 =?us-ascii?Q?s+V2tjaC4Y11C62sdEQyHSwne2FeoNsfFgvasRCq/Pu5Lqv/zwCOFstl5EFV?=
 =?us-ascii?Q?FqYUe4fXn5MckqtWvElDjv8u4wMxNFHX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8NvIc2GQH0YWQZATNwE73Gz8hKYVDw5mUB9KZOKnNoOuXnV28lzKbp7nY69X?=
 =?us-ascii?Q?d33ilitX0eZyxIB2A1fcFTrfqy/ox7ygI1nzVksoFb77f9+A23FJmxd8BiI2?=
 =?us-ascii?Q?a+Gh1VzUBU8dkp0yhCXoRMGke40nYK8+FJxYXEvwCHmNN8D5dWfd820cxVuG?=
 =?us-ascii?Q?BnwC4/S+eaGDKcka5m0Vsu61M0Os3YaMXo0SJsysG/mgJbUe+b2YwvRRjxwX?=
 =?us-ascii?Q?mvrqJ0O3AeDGU8uQX82ELxHB7GxH/0Ozrbp5hgfP4Pa//QPZLe76mlx5hPWR?=
 =?us-ascii?Q?ezKihGldo3F8tdQdU+HFuamed5S2QFkuY5GWsGYVLGWhjw1H1I1DjsJqzaKi?=
 =?us-ascii?Q?6u7FZSgD6RUBF38m4O1m4GjKA1ADg77cKTFGcmCKV3ixFh2hOyhaGwf9RQvn?=
 =?us-ascii?Q?dNzkNXU4CQFyI8zY197yf/gHJpDfMA9gCpERUWRkuwIXipVkRs0HXJOnO67C?=
 =?us-ascii?Q?czHiIGTyNE9LD3n6FrAWdik0n6mr71jKVFMtZ3nQmFnCBYfOiNsmkKvdpluW?=
 =?us-ascii?Q?JcNqHyp4d26iQy1AqFpwsarCgBZ07MH6fYW8XJ3nPisphBkcwFyVzm7U/ST+?=
 =?us-ascii?Q?4NlmbDAJpwTfYAI2E5JJGBZxrp2aJOU8AEZTGIzGzvXzz5H4CL8WqnQgCRAl?=
 =?us-ascii?Q?cXgyFVJeripkvYK6Cjvb7jnaWufOAXlgIWo7nlmPiQwrRXSbiyxKLVDhtjKb?=
 =?us-ascii?Q?Q/qbT7HxbwAWnFzICEczXt9lIX4r038PXKKRtpEBKIYdmUhKHkEjRZ0mOMT9?=
 =?us-ascii?Q?dvC8icp9Rf8GGO8aiC4YT6Ogfrsm5GgJ1Z3YLWuTuG4pZbLbUBgOBlP/EgFz?=
 =?us-ascii?Q?aC+s81KWNnv57BpP2Gb4ct6OG/1PAmK/ulPQCBr1rnz0NI3BhGsx3yyyi2FT?=
 =?us-ascii?Q?z5IUpwL0bB5CevmDdzVi0IUfe5qySHBd7pa7w9YPyNeP0iKEHMTghnMN82YL?=
 =?us-ascii?Q?yEQvZbZhtHl5EVh4n0asad03EGJjNP4j1TI81jVFtpusQim9GREj++oS0ZX0?=
 =?us-ascii?Q?g8t6V6H9GMeAOkMz9WvRHjN75pBTKg1vgwKb0QGpyY0F62XLMiIFQaZvXNQx?=
 =?us-ascii?Q?83DUVP2F949L3UKCqVKfwQdavyRtAFH3ROCt0a+oYjYfqGHM67HjmN8iPdlV?=
 =?us-ascii?Q?GF50NCrcH01OsEoJM7krTg43nhQQoFwd14Ik4vVwHkpXBWdCxk8oQS2r50Mi?=
 =?us-ascii?Q?BXrq9BhKjn7gio6GKb3kKS25wg6MHsFIRYdwCmPPlWoYBtU6zq2GuW/8X9kt?=
 =?us-ascii?Q?gIR6VzMH0t8LgTMYCwFi0CEKVop5tOZYphSC9KFKWEn9kfoAJE/A0Jc8SYPg?=
 =?us-ascii?Q?TO8s0i/Y41q6yI5CGS8g7DslCHKiTS82lsUqDGZWUuRsoZ+TXDUEl2MKy3Q5?=
 =?us-ascii?Q?+KN93+UctrUNteb0mlzlh0ScduNjznRb+N9pWBeDUUHAKkbzc3VPQSxGahuR?=
 =?us-ascii?Q?cMSis/1GPPzm7b9asaNmg4CQxdmMiRSxgrC0yD6qxg1SgY0Gd+z2Do1wSmBb?=
 =?us-ascii?Q?BoUACZzu75hIrbgFro+O929JLHYq58RzFULftcg9DNMqlgQd4eMtFgVcsVN4?=
 =?us-ascii?Q?pdHZzA4gqSKiqIdQOULy2o5o+2cL/de3sntkbCvfPj2x2OeaxjS3W6pL7a0i?=
 =?us-ascii?Q?WTICl6jVQqd0tEHich+FKRgVmd6MjWKgxeH/eB3iXiXoW0jXuWRHLhvysYNB?=
 =?us-ascii?Q?e8I9O0/dBjc/vDCk4/SQxHyEKFhu1yysXMPbhpie6zgRbvgtTNuQUFyJMcqU?=
 =?us-ascii?Q?12TX86BKug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NIMRYIiRmRtvOK3PGicpT74FdpsDgNuwjnWghnRwgWdWKe6XrgC7bxoA+lMJN0j7YEsWmv6CI3FxhICpiRk+7ug8/5E9jW7pi3+gUVMKFjoHYjXD2RcqS1hDm0LOOZBBOq0uzzciOGShSqgBh+s8hrVVvqT7LXs/vgp35lhtJv9JawRCpNq/6qNwemCY6q/TbeyKrqJt+I0IzyF6auJsBjcTAItCEEhRy4Z3X9WPhg8SR1TklSkkunAKoQ6ecp2K65RYwXsnFhSdhPNYOABpeOlqOp1gliXXBqbECEb2D2v/LnArd+vVB+DKoA6wKLBeeZT1dIGmeiOB4seG+Oe4H/JW4nndj1hKeHSlyekQjAuJqv3qaRJSOzZJ54dPyuL9+v1f8PArtuT7ejckYPWzIDrnwpTw+sKdwGawybkJtVG9KJGG35exZyY7QvS5SCRtBWF5e/TDCt29ZLu17kHRKzIa9Q8xouZj6CN+8uIt5U5vxDOBGNf6wMByfJso9ddrOmeigaxrZ0/AdZ+RXfj/TFqBzp8aKV3loUnonX56P4IHNadMK6EUhvHVfyMwdVGKYeoTJ7wDsfVQlWM6HMsW8dCj/yg5u0SsqYzgfxpvQZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38d62d9-2d43-4fc4-96ee-08de4e8588ba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:14:16.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4ZlQZk/vUKZum8rhqEgCgSdh2IiTTitJbyOCHcRvxsp88WzTJgfcxUE5FXaMmOd6N4kZ05cqyhEVkl08TYf1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080047
X-Authority-Analysis: v=2.4 cv=QNplhwLL c=1 sm=1 tr=0 ts=695f594e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=RBpTM5pFb57_Pg13b-MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0NiBTYWx0ZWRfXzxuxXgEIqJdi
 8f4SCvHSePqMZrdRKdBRn7RKnnaZJbypIXNUgKO8bNnHBWVgxIehgqh/Pcu5jGhluCiy7X+bJrw
 Y/cDu/aDedKaa71uxIVSdCNlqcaFCkdtBHEBAx/OwwCfCoMw+ODwBv8xXpPc05tCaOSXCDJzfmN
 N0mruz0jfr/xRIhrPe9KKPMmXUxtLr35R/fXUcbYI2VS1e5CENC1Sa/J/Owzgz7k1Gk1i2w5+DA
 Qy1IWJlMj8tLr8wlCaGgN5n31bEaLCGz6DYIijpdtGvlMtzE3NU5aK3CzhyvPhosk3lUgRJFqZe
 9eigM+DHTcE40gBAKm1SofKhW8AZol/qp1Rwo0rD7o+WeYZkA+hNzBuQNarbzfmg5sIQU88r+HT
 cdzCIJM3RBPq6t+p2f4PoQ+UTRutRt8W298+wSiEArNFO4BaEjc+3kBHY4XojVxtJi5/xBek3ct
 TEn2aihR1IR/EHSuE/g==
X-Proofpoint-GUID: UmGqOUBnyUrzT-md6Ymj-O58lOPj63e8
X-Proofpoint-ORIG-GUID: UmGqOUBnyUrzT-md6Ymj-O58lOPj63e8

On Wed, Jan 07, 2026 at 02:54:15PM +0100, Vlastimil Babka wrote:
> On 1/5/26 09:02, Harry Yoo wrote:
> > Convert ext4_inode_cache to use the kmem_cache_args interface and
> > specify a free pointer offset.
> > 
> > Since ext4_inode_cache uses a constructor, the free pointer would be
> > placed after the object to overwriting fields used by the constructor.
> 
>                              ^ prevent?

Oops, right.
Will fix.

> > However, some fields such as ->i_flags are not used by the constructor
> > and can safely be repurposed for the free pointer.
> > 
> > Specify the free pointer offset at i_flags to reduce the object size.
> > 
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  fs/ext4/super.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 87205660c5d0..42580643a466 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1491,12 +1491,20 @@ static void init_once(void *foo)
> >  
> >  static int __init init_inodecache(void)
> >  {
> > -	ext4_inode_cachep = kmem_cache_create_usercopy("ext4_inode_cache",
> > -				sizeof(struct ext4_inode_info), 0,
> > -				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
> > -				offsetof(struct ext4_inode_info, i_data),
> > -				sizeof_field(struct ext4_inode_info, i_data),
> > -				init_once);
> > +	struct kmem_cache_args args = {
> > +		.align = 0,
> 
> Nit: it's implicit so not necessary.

Right, will do.

> > +		.useroffset = offsetof(struct ext4_inode_info, i_data),
> > +		.usersize = sizeof_field(struct ext4_inode_info, i_data),
> > +		.use_freeptr_offset = true,
> > +		.freeptr_offset = offsetof(struct ext4_inode_info, i_flags),
> > +		.ctor = init_once,
> > +	};
> > +
> > +	ext4_inode_cachep = kmem_cache_create("ext4_inode_cache",
> > +				sizeof(struct ext4_inode_info),
> > +				&args,
> > +				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT);
> > +
> >  	if (ext4_inode_cachep == NULL)
> >  		return -ENOMEM;
> >  	return 0;

-- 
Cheers,
Harry / Hyeonggon

