Return-Path: <cgroups+bounces-12613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 325EBCD9F37
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 17:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73A383029C00
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C340267B05;
	Tue, 23 Dec 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BX9ToXLw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c7yovGmW"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312A335077;
	Tue, 23 Dec 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507150; cv=fail; b=uLH3RQIGQe0l5BtpvF/i9plCzYIKPIhRMnPv6NWCmD3CJ3pRhHCDunQslOlNeT9kd1kAjtwG1ubbsVKzFI0O6YcP4K5MwQhI4gfWNdsln0C4r5IvtpJyiBx/7TxV1YRMumM4MCrwecwMPIwGnoGi9jb0BlgmstVJ/VCjfvIcKqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507150; c=relaxed/simple;
	bh=fewigic+VjFZiLFhwnGhOT4XgpSWsaJyHdwBiMGaCj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fmn6TWtLkjf1Dlw92lz4aA28uqRyJWO1aiuzDIozlFjTD1aZ6mytNYO1TVK4METzag4MLzlRy89yz+mQrG4aQLZMo2pxgRfq6DfS8IoghFSTS/dcyEru86MIsx4HIpZt9JtVTcg6TgZHx0O9dGyCqVEyKUP50i9kMNu3d8JFvYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BX9ToXLw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c7yovGmW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNFEhbe622704;
	Tue, 23 Dec 2025 16:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EVeuq7BANgUd/Te2c7
	K+hgT/DcWYDBvXNRAUjXESvgY=; b=BX9ToXLwRIzRjmWXJpFGkuu1Xxkk9XdXYH
	e3QWVZE81LhIZQiQzKXnzM8HUBlCuw1qSIXl+483MphWHSCApAAQYSHdm9z0Tbgh
	zRhwnqgpG42ekX5DfpulvaGz0S0JSx0rnfJeFpK2VZpXvNVOUCZgKxAmnsSCxhEr
	lyP3Va7Y5+9OAhiUVuIeLlcaI8H6p85gOm39WhdYFb9ugScOS44QDKWWJIfuGaMq
	B58zyUIaD0qIn8IAKENE7fzLY+WnAKNFSs0tnIG5vBLEArWXsVJK1pixHQg+gdeN
	/v3OFzXizg3BmugYHUIiJ2HaB7zTM8S9TN/EwKYRQ7Qgy3/xOK/g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7wj2831q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 16:25:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNFj8LB000657;
	Tue, 23 Dec 2025 16:25:26 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8jvhhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 16:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbDJ2fmLt5+8Zpx8VwFN+zUMbGisl3+fJTRJwCY9+zAM6DZ1py46232Wo027qqTA6b3D5fxgsl8fGYUSU6+oo829Lo9NE7zs6tq5QULb5CkoJ8k/i1x/9nT63E+/fZpP7WTfE12i1POlJV5HNMJFDskppLz3q30ITpoIutiUJq9Wyfy3QSwAiRrgdxewjsxovyMxdzGzSBuzQoC93i1dG9oWywtJzTLcFVROdTmUTRqY4qpUk7hEmGX8J5uqciP6+0An8cVALZF0c0Vk1Xwq+HH+yJ+A2LtSUVUvl6z2iITl84L8Hh/tnA33tqm0qtRrOQYMPvtOiyiFGdIcN57b9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVeuq7BANgUd/Te2c7K+hgT/DcWYDBvXNRAUjXESvgY=;
 b=erWZZS+Sg4X9zplYErezo8k7OAZfl7iOPNk2OLpZFVCHJ2ygrx4wHAbPX6GuXQxB1U3vVN7DSTeRwRE1/YYZ8QAuMDYTxAqWm3HtliAD1bWs1q6ohY8zqUPL2jo6k3QTPB5LlLK1bfcDnZEg4gO7LFYGNPOTW2ErH9Wcpcc/VftL22Q/wjn7XNVqxea0tDCoAGzvD+AbOWshzhhshCH+dssLcqvIq0HqU7zqU3F3Sr/phvxtq5mlnsGcq+eCyUSqufvjnrVGosnGKA+CzyNAeTVDqeikl5pAvmUP1MLsjg5vZ6km2WTC+nc+PMoCS6wPY4VnRWmoamnq+RXDLDUJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVeuq7BANgUd/Te2c7K+hgT/DcWYDBvXNRAUjXESvgY=;
 b=c7yovGmWIobVQDWHDbicmAfusmAJrfriVkuTr++ah90rSP9QhWZH3S/2XOv7fVSEas9p/z+hM2+wTVw+3vdVAl2GaF5I9l7L5pDW/edRPiLpaQzDpBcUvWZ+7WOSUWsG+wXTu9lyuMbfT1vm9lLDRVa2x9R1Cpojic5stQx7AhE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB5772.namprd10.prod.outlook.com (2603:10b6:510:130::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 16:25:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 16:25:09 +0000
Date: Wed, 24 Dec 2025 01:25:01 +0900
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
Subject: Re: [PATCH V4 7/8] mm/slab: save memory by allocating slabobj_ext
 array from leftover
Message-ID: <aUrCXYdziRWP9PfV@hyeyoo>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-8-harry.yoo@oracle.com>
 <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
 <aUq1x_BowqYpHZAQ@hyeyoo>
 <zex6wgdlxk5vgwm7ou657fdmi27xnxihdndlszfa2chghamfuz@grhtfqw7gm7o>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zex6wgdlxk5vgwm7ou657fdmi27xnxihdndlszfa2chghamfuz@grhtfqw7gm7o>
X-ClientProxiedBy: SE2P216CA0016.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cbbfe0-815c-4b43-a10e-08de423fd71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BgObz+y5ga9sb2pd6u2ihTFR1pmy3Q5I7hCuoEQeya1b/fZNa78YFlviDjnP?=
 =?us-ascii?Q?g5xm/B/6YFpgcTF7Re0bUzBgMTUuiYB+zLWGogikFm1DZPBC6mhg52Bg4GD9?=
 =?us-ascii?Q?v9SLEMN4n/QXtvxtJB1BtzI31iKj3x0IOYMymfv+T/X5hhYHyVlx9uuNUYdc?=
 =?us-ascii?Q?8SeX74UGVHazVOxMCg/Q3U7DpIYfW2/eaDtReWFLF8fKzXZY8AXCwMXN5SwD?=
 =?us-ascii?Q?owh/8fDXPGOKXTitPf65GYKFNm1Ka4NhZbuQDe+vDq6RC3+9g2RjpEqTzM3P?=
 =?us-ascii?Q?QHS2K8LOAc2sOaiyylgcB7K/gTCA35UKic0lt+skRaE88SFefXK0YvNqpp/7?=
 =?us-ascii?Q?9iDA1vK4uY9TIP3l3fxNg3hgp/Zi4dabEOO1r9pYTAm11Q6DpmNu00Y9Begq?=
 =?us-ascii?Q?ZaUxsvewkWv0zjUkaJM/6cmWT2lJIBa3zpvi/26ETvbXtZ9oM1OIf3htQVC9?=
 =?us-ascii?Q?nV7DMnRT08nz+zTVReC66bFZBpfY0/17exqogAZO+oCGK9bkyifC8kqUqa8l?=
 =?us-ascii?Q?XwMH4Lbx6x3Ilkf9ARuHeplBByNcTThZW2QTXjGgzPJ6u7dHlqDYNlpPKs3N?=
 =?us-ascii?Q?7gcbUn+uDU/qjeajKBn5kAdrfOi6tb2D4wkxHjB4OTG9ZFlZjYeu73dD31Pf?=
 =?us-ascii?Q?orahsSi17WtEsdevhhqmKTzVq/0LfXz0Ou+j5PDC6J13ub9hhrVL7SShJacG?=
 =?us-ascii?Q?iSzzdhlfk8W65ssiS0/eWugWnn3fP+5JCy/d6j94tCvcIelq10pnOg4CSYq0?=
 =?us-ascii?Q?Y5gcMVyy0Ik0MzwE6i39c0e3WZD6hqHRzGUiClBfwN9ueB/9lRN66tZR4vup?=
 =?us-ascii?Q?ZgFXvhfrbB3D2p4NBHSdSSSroDj9tpybhWVQ2u83P28S4egTi1ogdf0xCAoM?=
 =?us-ascii?Q?QZUgE2ZdD/k+9Pzs05e43VohPzb0vnywL6ISNW4L6er65FUtAlCxPmcoXggC?=
 =?us-ascii?Q?EFIqx+H3i4T+guSO0e2VG62mWNO8ORBkmcKDwftxk5KKLCk3fHaXIiBu2B0Y?=
 =?us-ascii?Q?TMtsCVNga+hCGuVnpfRwb4ViaoTIhU6x52q0e5tzZPpV6f7PRGiuvsJzK9Ei?=
 =?us-ascii?Q?5ouKgksk+c08/MJPzyCUpmR++6n8Nje3vIhG3Nuewon6CWet00363WkUbK+j?=
 =?us-ascii?Q?maQdTwEzIHt7F/vWUHOjvpI7Y1K8hHhPrnG39UDkONk63cAeGNvCuNVhLQ/g?=
 =?us-ascii?Q?1hEvrc7/7CUfYNcNngcLnpvnRfLkRai/b72aDzPWN70N/JBsfLLO8s1zZ3Mo?=
 =?us-ascii?Q?ywlWr6j86yp+pJzc5fw7ROLBsoauTI2AFThKimlWnwoxEeu2sPde2paUhKCv?=
 =?us-ascii?Q?KLKzlM4qDogZeX6lF4sYBFDJW4ROR37ms66wQmkxKslt2U4u2wged7reB1CR?=
 =?us-ascii?Q?TMehBCp8XxCmSke2Kn5MzRJ3bvJjhIlGJYwi1C4+DIybC0YEilouMIXbl2hU?=
 =?us-ascii?Q?4DoP9Q7UpJlDIo9Z+uPK1HEN53QCTY/jFsDyTBlJi+LtI1m5bn+ojA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oVCXLYXjaNZxwdURoygRgauJqLnWEPLt8nuVsFvtp9qpLpk6vTFLyfX4uNQ7?=
 =?us-ascii?Q?qR/5fRu4EuyA+EiPXiH4HeMKiKzrFBUxEtuG7BOCT/QbZAjchqlZ5w4gF3V0?=
 =?us-ascii?Q?Aj45Eh4atapEsYA9dh8AJIh9vGeJ3rbBs3tH55uXnPNdD0hlSaZxXQR+qht/?=
 =?us-ascii?Q?sNvpxJAh6dGrAVaYUhWYVu2/AEQUyyx8/2rJHCdaT0R8N4Zf5/wQAVbWS2CC?=
 =?us-ascii?Q?VDEJ8fZPpZn7Z2NmHzOMRCxLPEhkuspJVqK/e7BIFX86o42IWdqu8lTjAbFX?=
 =?us-ascii?Q?B7CpHyThdaKNZaXrGbSZLIOTOq/Bh7NaNPlTcR+R/b4H3AU8bz/ijlBVjahU?=
 =?us-ascii?Q?GXnSSosDa2PMUCbF0aOzGwoPjTgDKn8mpvIY2CaS9p3NZ9WpFQiy6lI+tak+?=
 =?us-ascii?Q?gKVYaVUK90kshukYM55ZfDiwuC3VSwtEOB0tJRuvmzDaa+b98f4MqwSl+RbW?=
 =?us-ascii?Q?0kugVLsUXfTyR7LUwIPlEEthgvjPcX4AkN4tU4X9IWJjIs4611eb4YcYawGK?=
 =?us-ascii?Q?YRhtOwjIGpjGAYQsjUFcQhXQODy8wUS7gdoDkdw0yC4A7dyfXIdy7OuHF0jv?=
 =?us-ascii?Q?turT0rmPTO6W9vKQ+VZE0EjMyAJZ+6XZtlvOxZu4bS65ffS65B0NshszTQZs?=
 =?us-ascii?Q?BQlhKC5ua3Yrb1wcUnywcqhVowxCCYrck87NVrzgObrhuTIWI042nwnvS+FP?=
 =?us-ascii?Q?Nrtxz23A/LkNIG1yvLk9EbY6XqM7XLcrjggCeEOubySenbXjF6o5a5KA3Iji?=
 =?us-ascii?Q?fsHeehbKLQ/2yifkjYn0xl54blLFu5pkvXkVrfT5il0ao+j0V0aX+oJTXIcj?=
 =?us-ascii?Q?w1/SbnrXJ/yh3tmZ6Ck8NcqV7WhE626PK1oObGxDQLIGwtDGvyY4ECvCdubv?=
 =?us-ascii?Q?IjfGo5nbzkqLzVV79+jYIs5kwZGiG01c9C9lbCaVfRpBaA/HaPNmbZ/2fJ0Y?=
 =?us-ascii?Q?irfohmCoBLUscnSG5EL7RlUBLQDLBQw43qbYUjfuf5wpzKrLHov0jeq1xxF5?=
 =?us-ascii?Q?T6eBcuO86X6NgNr0p0QPiwQnnBBX4NMOqtQGJQEB7MEgZjS2tIOZQQjZXwrM?=
 =?us-ascii?Q?Ah43HgE1T6ZftzPoELybKtOhMaaMqIQXat7svnOp+HPj+BzRDw3h+rgp8whV?=
 =?us-ascii?Q?V1eNNKJQqAP7e4Gli2UWTCC0bIhHebejmyZZ56R/MInAXe+SyV+s8OC8cjoZ?=
 =?us-ascii?Q?8lBIDK6mACIv+eKAGJUqn3ur3fp7H3KP3rxfIM11cCFkJZ3fdS5FUKb/+oqq?=
 =?us-ascii?Q?4KtgbQWoBk4fbv4kq2Jb6cRyt/lyZrG812E5Mtk/crZ5sA7HMmAV5N4SxXpG?=
 =?us-ascii?Q?4MiiX69XVLXF8tpagm2o9M7+EUL3bwp+Z5ng+aCsS77nZFOfKOdVX50dGwbk?=
 =?us-ascii?Q?SZQvN1K81yi1qiCM624jyO/AKvDkvpjYZ8nAwruNVDw9AK9nsrfnzGGf58Je?=
 =?us-ascii?Q?MjNDem/XGjJ1Tu8X84TrAT5Gzr8jlaV50Af1IE4OechUXe7h28FJAN6BMvR+?=
 =?us-ascii?Q?MnOJUrFsuRmh3dc9CULgktPMioHYzCSFfT104mb2k77MZJwW0E399Hlg+Snv?=
 =?us-ascii?Q?wGNmUp2H8/1/oH4K3ycM/d7zyo5ylCY4tB1fr6cKTCxXoDSQb5j4NKvAADAz?=
 =?us-ascii?Q?KsZAefdieXD2tayA7oShGBUreDogrsUSVSMpW7M52E0i6b2c//tZqiFP2uoS?=
 =?us-ascii?Q?gRx+dIfgZYJNcyyO+HUGVAnwSKP1n/wC3h80YG4Ll5y6NdElT9HObd5Y4I2z?=
 =?us-ascii?Q?rlsd9V/CVA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4sh7JDVOaGCPp3eCkj1GsId+Qby/K0byrTrShf+EnYFMRjLshmAdvArPaOvoO0/6ilecoTlF1dUmQL6NoSQOJvPURamoLP7KGIq4YbuagYbfpATtmoPJ1ZzQIdZxpUCHP9ZpqWpKP7SHIsYAMBmK3ViKZ2jU5BPz88RogIgBmAj8DNdH6KlmAtdkojLbvVrqcqIMHleOEvS/fCUeC5hfKHE7AiqAEovWZrZTAIO++UtMmtUmgkVnmImPQ8QcCC6b87JsK4OMehqCOwPfzhyPY1JaTgNnSVxoWElJwph8ZXDxq6BJ4bP1/A5c3CBpl6KkcwNNd2ZOEQ9m4iNNt1d3Svr3Hr6OOJQCoYvm17u3ciJ9U3ZrKcMAsqCXM8yNgAdYpeZaBVTaufk/5TVaD6YTUQ80m8KmSApVfax3lreCHo/DhG/SSPamaSrYa0JJOsKTz0i9Gt2mxDOgJhFf0w4GlRBSey5MlFhiyd1lk+/UfaCB5H/vyHvN7LJK4rD3modeDsYTvMDnmBuuENHTFNl8TEZLV1kggibyQJ3RQQGTCwj+rPsakw7ArE8py0XuZuzNJf5UYDU1PL0CnhKd8upWWFMocTytwOETiadi2/MU370=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cbbfe0-815c-4b43-a10e-08de423fd71a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 16:25:09.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4+QaSEqKdy4fFlxXf5AP5I5GoUx22wVbGzIqOM1VaY/zH+DDFb8KMhP1vujn9MzEm8sGH1O+W+XPehVPihUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512230135
X-Authority-Analysis: v=2.4 cv=OdSVzxTY c=1 sm=1 tr=0 ts=694ac277 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=JhRt-4ienvtJiXLqaIcA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEzNiBTYWx0ZWRfXyi56C2JiP8Vm
 Ys9hePiDucF2DPF9wpHdy2e9bluixm/HHwq3U+Oo8FAHmqIcSOwUjqcOZCFNkUTzj4l15kuizsj
 Q094X7e7tYNTfyQqT8X6wtxDjCXD4v3mPjd4FlALK/nYUqP3NusSdKewjcLJDqS6I+es21xpmEq
 b3FxF+fUj277n5RAmfNRwQu6yY7bW0HoDhyY2z9ilE88B9o3Ap0GKpBMSuOTUn6FpEubxJqCI0I
 fV0kQAqxcjTH8FO092hhOHmW9DUc+k1hQMqLHbgPNiP++7wLbhhSFG2PUtK9O6+Ozv5ayNWSuJ0
 FPoJjoJaQZAeTni+kWAof4n5LWsJVslA03pjYrvYkBXnR7J3r9h6ua+Rft7khW4e7pPobTRg7Y/
 GkcJdkYCVCvC3sod6vvKTfQ9NN2cxBf0rMKo3S9iZSeEsrIoeqNuAt1fJ0yTYciWW0A2s68IGx1
 szRWkpV17FqKdOtD66oaIUHt5UmNg/mVVd0LlYBg=
X-Proofpoint-GUID: DG7GIIbWdh0vEMM2RPwuyyEjW2W8OzhF
X-Proofpoint-ORIG-GUID: DG7GIIbWdh0vEMM2RPwuyyEjW2W8OzhF

On Wed, Dec 24, 2025 at 12:08:36AM +0800, Hao Li wrote:
> On Wed, Dec 24, 2025 at 12:31:19AM +0900, Harry Yoo wrote:
> > On Tue, Dec 23, 2025 at 11:08:32PM +0800, Hao Li wrote:
> > > On Mon, Dec 22, 2025 at 08:08:42PM +0900, Harry Yoo wrote:
> > > > The leftover space in a slab is always smaller than s->size, and
> > > > kmem caches for large objects that are not power-of-two sizes tend to have
> > > > a greater amount of leftover space per slab. In some cases, the leftover
> > > > space is larger than the size of the slabobj_ext array for the slab.
> > > > 
> > > > An excellent example of such a cache is ext4_inode_cache. On my system,
> > > > the object size is 1144, with a preferred order of 3, 28 objects per slab,
> > > > and 736 bytes of leftover space per slab.
> > > > 
> > > > Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> > > > profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> > > > fits within the leftover space.
> > > > 
> > > > Allocate the slabobj_exts array from this unused space instead of using
> > > > kcalloc() when it is large enough. The array is allocated from unused
> > > > space only when creating new slabs, and it doesn't try to utilize unused
> > > > space if alloc_slab_obj_exts() is called after slab creation because
> > > > implementing lazy allocation involves more expensive synchronization.
> > > > 
> > > > The implementation and evaluation of lazy allocation from unused space
> > > > is left as future-work. As pointed by Vlastimil Babka [1], it could be
> > > > beneficial when a slab cache without SLAB_ACCOUNT can be created, and
> > > > some of the allocations from the cache use __GFP_ACCOUNT. For example,
> > > > xarray does that.
> > > > 
> > > > To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> > > > MEM_ALLOC_PROFILING are not used for the cache, allocate the slabobj_ext
> > > > array only when either of them is enabled.
> > > > 
> > > > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > > > 
> > > > Before patch (creating ~2.64M directories on ext4):
> > > >   Slab:            4747880 kB
> > > >   SReclaimable:    4169652 kB
> > > >   SUnreclaim:       578228 kB
> > > > 
> > > > After patch (creating ~2.64M directories on ext4):
> > > >   Slab:            4724020 kB
> > > >   SReclaimable:    4169188 kB
> > > >   SUnreclaim:       554832 kB (-22.84 MiB)
> > > > 
> > > > Enjoy the memory savings!
> > > > 
> > > > Link: https://lore.kernel.org/linux-mm/48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz
> > > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > > ---
> > > >  mm/slub.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 151 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index 39c381cc1b2c..3fc3d2ca42e7 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -886,6 +886,99 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
> > > >  	return *(unsigned long *)p;
> > > >  }
> > > >  
> > > > +#ifdef CONFIG_SLAB_OBJ_EXT
> > > > +
> > > > +/*
> > > > + * Check if memory cgroup or memory allocation profiling is enabled.
> > > > + * If enabled, SLUB tries to reduce memory overhead of accounting
> > > > + * slab objects. If neither is enabled when this function is called,
> > > > + * the optimization is simply skipped to avoid affecting caches that do not
> > > > + * need slabobj_ext metadata.
> > > > + *
> > > > + * However, this may disable optimization when memory cgroup or memory
> > > > + * allocation profiling is used, but slabs are created too early
> > > > + * even before those subsystems are initialized.
> > > > + */
> > > > +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> > > > +{
> > > > +	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> > > > +		return true;
> > > > +
> > > > +	if (mem_alloc_profiling_enabled())
> > > > +		return true;
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> > > > +{
> > > > +	return sizeof(struct slabobj_ext) * slab->objects;
> > > > +}
> > > > +
> > > > +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> > > > +						    struct slab *slab)
> > > > +{
> > > > +	unsigned long objext_offset;
> > > > +
> > > > +	objext_offset = s->red_left_pad + s->size * slab->objects;
> > > 
> > > Hi Harry,
> > 
> > Hi Hao, thanks for the review!
> > Hope you're doing well.
> 
> Thanks Harry. Hope you are too!
> 
> > 
> > > As s->size already includes s->red_left_pad
> > 
> > Great question. It's true that s->size includes s->red_left_pad,
> > but we have also a redzone right before the first object:
> > 
> >   [ redzone ] [ obj 1 | redzone ] [ obj 2| redzone ] [ ... ]
> > 
> > So we have (slab->objects + 1) red zones and so
> 
> I have a follow-up question regarding the redzones. Unless I'm missing
> some detail, it seems the left redzone should apply to each object as
> well. If so, I would expect the memory layout to be:
> 
> [left redzone | obj 1 | right redzone], [left redzone | obj 2 | right redzone], [ ... ]
> 
> In `calculate_sizes()`, I see:
> 
> if ((flags & SLAB_RED_ZONE) && size == s->object_size)
>     size += sizeof(void *);

Yes, this is the right redzone,

> ...
> ...
> if (flags & SLAB_RED_ZONE) {
>     size += s->red_left_pad;
> }

This is the left red zone.
Both of them are included in the size...

Oh god, I was confused, thanks for the correction!

> Could you please confirm whether my understanding is correct, or point
> out what I'm missing?

I think your understanding is correct.

Hmm, perhaps we should update the "Object layout:" comment above
check_pad_bytes() to avoid future confusion?

> > > do we still need > s->red_left_pad here?
> > 
> > I think this is still needed.
> > 
> > -- 
> > Cheers,
> > Harry / Hyeonggon

-- 
Cheers,
Harry / Hyeonggon

