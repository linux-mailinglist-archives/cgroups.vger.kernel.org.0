Return-Path: <cgroups+bounces-12116-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E117FC7347C
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 10:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C5924E7C31
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4A2EA177;
	Thu, 20 Nov 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WLjisFa+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUMb4F5B"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E232EFDAD;
	Thu, 20 Nov 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631794; cv=fail; b=IO25tegzHvwVOZNnnUNlI1/0WH5rvz73gu0Q9C+VYB/WhG5fi3HhQrdhYAiJukrR/vWvINAA2H00qGq1reaYSjtwPOtcON1RxfhgGEjoxDo5mpJR6zSzyDZ2uGuLDq+M/yhLsGT2LD7gYabCRCrPc7z0FtZmDEvKsQMnmPUHdZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631794; c=relaxed/simple;
	bh=owaSFT+skYCn2YIB4v/fSRdYoaWeu6J0pafJZaT6XpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/HycgyemuVYjd4zSccTyrXqcNaN2+GmbwSF5H1gvkOrVsRhAmQmLCVNJSyMwlebGXre0iL/qJ4WWvraevK4jyMb0h2y9SJ0nBhx8FUdFW0oYt+So0uGleZibKLNHmHS3hwgQQzsFpNUvE/bvzar5+VcAdCheD/uu7lCq5odwL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WLjisFa+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RUMb4F5B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK7nkfQ014322;
	Thu, 20 Nov 2025 09:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2aW7YHoAm8J6aIawKP
	8JhLWo0wXqXGp7XHeLnpwQicc=; b=WLjisFa+T+e+Il0L7ZYZrofPB6n05A6ZNh
	hWS37V7mSSvn5Ocou5/MPPMDKIsn6O+vWeaPMajYFWxBFCik614eo4QGwBtUSbkH
	xDSPhEMI81zmO2vD8TGunKCYOBs7c5T3katH+RjUkF/a/sYAdgRlQylbRXQ3fhsB
	wc8/PuUSXmWwVxjpgLQVROqr9SApmhdVitRw0TIJjBs8Ybaee4xKMhoirohy1lyv
	qOq6jVUyGzlUMDl/At/Wete1lN3ZFu7B6aw3kXTkAVV3uNQ1o6cDri4faWByI1zk
	Bjc5DK9JO+WpBadornVprxXyJJUqtwowLzn7OaDQecY1Nak12qqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbgxmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 09:42:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK7gWt0035979;
	Thu, 20 Nov 2025 09:42:44 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyp3ekc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 09:42:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyP6zBRkZUpFpV0uccuobEZU3wqWu0SP9o8he+qoBcAHOiVk1FPwakQl3ZUCOQJGwMPg8H/mXaZnk25NGXsr0aFpc+LM097az54iNkM9DR39gtv0BKn+zLrOgee6hTHx3BoP3DJTYFF0qWB/OSIqNcJHjGdJWkdpe7yNhp/x9OU2SXMSA0Ijq8mnFq+dVeVRZBg6rAVYvqlbt9rdZe0Ey/pRnBUQULjg2Owxa3k2ECF3udb06fE1qDK5qiAs+YfKMYZ7hKZ+lCvXEYhveCpQ7jFkj0kkIWefGSZCpqRaCQx8tI9mq2L1tXbaoGzGiCaf/ugSVU014KgrjGi+1D8HKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aW7YHoAm8J6aIawKP8JhLWo0wXqXGp7XHeLnpwQicc=;
 b=Ec7syfSD3JSx3xc51AfREbKZhTU9DCk4mS+chyNqIyJiSFC4bkiE4h/1gakO8ECbr5rzVZNnG+FOmGj5BBUvpgAYbV4RKMKpvaN3DOakmAndIInNyjUNVZB3kgBupiY1336Wl8vkNf4q75aRkYUTk0xmrlXg/u6NFrn2//FN21BWp65sAHygPHDuoDUUEVGDEDiQTuqxUqap3Nv0JUM2uT+W9HI90rmazgY8z0feCu1uZA26BPPyvcj+vZLgBjVPQ5QJLdnRrZ6IJXFaD6wdJpc6wdu5veDEkGJc8daewoicx9yqO3JMwfljwA2yGnTimAPdey/gfBJI4nN0PV39Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aW7YHoAm8J6aIawKP8JhLWo0wXqXGp7XHeLnpwQicc=;
 b=RUMb4F5Bp1691ROlL3PV1Y1LdhuChXcpqXHF1O/53eK+l40GqUUQcit6wqtw+CMCdLOvwXodPN0Mn1gaL1ma6N+LtEk7ATj2FBKREF6PfWRIZROJ4+Ir/iw3AL8FrukQX4YYrShSqQYvHlOah5ghJAOZu2khkHOXGxKLxNhwbY8=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 SA1PR10MB5685.namprd10.prod.outlook.com (2603:10b6:806:23d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 09:42:41 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 09:42:39 +0000
Date: Thu, 20 Nov 2025 18:42:23 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>, Nhat Pham <nphamcs@gmail.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 18/26] mm: zswap: prevent lruvec release in
 zswap_folio_swapin()
Message-ID: <aR7ifyNg5qG38BLp@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <c85c86746a3103bac3657934a2655c1eb81ff290.1761658311.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85c86746a3103bac3657934a2655c1eb81ff290.1761658311.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SE2P216CA0056.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|SA1PR10MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: c94065f4-e07a-4af2-b5d8-08de281920d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDvNlYxKci8hmG3X2Y6zv6b9/rxmPTa1fFfhtslelwJ6G8f9bXO4WpD1rChU?=
 =?us-ascii?Q?zyAG/1rmaCxiQtm95Esa9o6H4QxknTeaFK1HmXeuMsGJeFuEhadVHEr/Mcz0?=
 =?us-ascii?Q?eUjGB9i2wIDO8XEMi6Wi38kqBdvKVHKSk6n20u2YwGHhOlG394FiOFiZJRhE?=
 =?us-ascii?Q?nRFsDJd8fmITnHoB7EM+O3924j2/ueCMNVeQXtL6HKcoVDGTB8JicSBaE3O0?=
 =?us-ascii?Q?skEbaNvRYfiRRfOMd53FiMQM17ytCCTvXHKWooE10qcnu6frOS92pL81Ogcx?=
 =?us-ascii?Q?K/76a/nTw50zlr05icvH5iYZoQY/KWFT/65YYnZf1JiQrRMZMDEmPTl319g/?=
 =?us-ascii?Q?HYESMcC9Q1iPCitOUty57Is5RAFL0gsY50Ox0X87WPts0vkKmGweP+hJRJoJ?=
 =?us-ascii?Q?jhC6MISFYAiOKGQ1W7cpxL08Oi4ioiV/dFyBzPOZ8Qay1anTsV8wpJvjceOj?=
 =?us-ascii?Q?w5pvqQrEzDk4oBB/DJ8pkJl8xH2etVWq+hWPZ2+oU3Gq1uH78WT93+zM/sgn?=
 =?us-ascii?Q?5QMJ3D0XELircHa0ktdhf6FOAPkzxdf3mPsLIorTXnH54CWeLzFsNzqfOA39?=
 =?us-ascii?Q?FfeuFBqLPi9/v97eOwvs21EGBhq8XLiSH2WurkFowa2rlFYRvM/brM5rmgnV?=
 =?us-ascii?Q?4lIAGR/JBNc7pQrfCQ6w41lS8AdmjojbdUvztOAxyn5qndv2KBMOqdlzwi4W?=
 =?us-ascii?Q?K8yH6fjO3PDusuoiCie0W8msl+SeQg0nvdAs+NIhkdZ6NM5ZZ+vPAnUhU4+F?=
 =?us-ascii?Q?jyUcQqEuASTq2DsEKSR4Yg4ymYbNh3zM/2s/jlEZvwbcgSzFamQrJ8VlDL+K?=
 =?us-ascii?Q?pADHvueZ2S7+uHha52jX1xKiMEOzvFG1uMKsMrP6VUQX6T42Bry49+iMSp6T?=
 =?us-ascii?Q?W9sL0gw/gGigQ3hUybcoaVQj4kiqClMyUYtbnBd0g1p7zx71/blT9AwIBEcU?=
 =?us-ascii?Q?okBIV33jTnwKCDQOQjL6vTF1WAnxuoBoimfIHlEY9uclRWUThcYbL3bpLiJG?=
 =?us-ascii?Q?o2TeUNRHcjWIROufOhLgo086E9TQJF5uFdcU1h//LoB4/dJikbbnSXCvayn2?=
 =?us-ascii?Q?pCZLVzV4379T8WoUrTb8G2+ZaEWpdfQv9FFhEVkVcp4RK77C5rv3qSPGFOmL?=
 =?us-ascii?Q?v34aO6C/7i6MdUk1t0aAn8Ps09EVS3DoVz6BzIGRsc9z3vGLQwP0htkD//RH?=
 =?us-ascii?Q?iLODnh8WCJZ7MX/y26MBuz5X3RCpRwJQB3gfdrBTGzOsYF0HVXqvaMiXyooK?=
 =?us-ascii?Q?N47M0VIORZwVQoP8UvCYVnl5WKSHLZfgmEnMwc8n80uMErsM9ZxBGRtDDBe5?=
 =?us-ascii?Q?451+Ugks3PtwOIuHHj2DjgYukIPhS/fmyZOh3+L4g4OjK6APoFVHHgYlGE8J?=
 =?us-ascii?Q?7OUKy9ytBlY6pTc/4yVph9Dvko5sXw3IK8eN7SxKazRbu4pTYrModbrUl65u?=
 =?us-ascii?Q?AEJqUUxtK6p4rQKOCUY0SaOKa7MV5tiI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9EgMsAdO5Y9wyA/idrLo0F+aJPAmzGYa6tIVqS64wXQL2ylwgsaQ9kP2vkh?=
 =?us-ascii?Q?oF9URMRkmgkovUYDBA9LDjcBt1Zo+KH3IigtReInf0g9YfDqfj1Wf/ENU8bl?=
 =?us-ascii?Q?aWJ5QkbIk65RGkIVQfZOHz985jRQxgWA1tXm10jYcs6IpgKLgZOr+vt4Ys3a?=
 =?us-ascii?Q?x+ll/F2n1p7MSBNiCYk4c8PPGXjk2Eh9DUfnvw7WLMq0b/Cjfxt2DbmmNhYg?=
 =?us-ascii?Q?5JUQQadUdPvG0o0it0Xhn2HQZo048jG45No9pkc2lxkx1ByEbZI1BRRiMPwG?=
 =?us-ascii?Q?0KosxZg67iwPecjW7YXeLVkpM1J0BeMS8B0MHs9b7cWIsz17laz8L8nmxMuW?=
 =?us-ascii?Q?bmNDSy9FzREUncllgkhk4K+OMmm9H7koFBPFNPpU6nFHVx2zgQeZTJ24Gj6Q?=
 =?us-ascii?Q?p5YzCvb8rRUjYJAA9Dfd8nuHYJrPPXXlGPApQs5iKh8CQH8nMh74sLD3G63f?=
 =?us-ascii?Q?fcmLBLqLzVRQ6UHcnws+lyG8b3RNWiZfAHhR/YdSvF1CVouBdMkoFC4ECXPj?=
 =?us-ascii?Q?JGnXkMvBMA5JFCMsIwstYzJAICRBW/GurAqS0SZGO/ICI7a4jx/34PKI2KGc?=
 =?us-ascii?Q?CIuIX2I6EpwLMdn8OmA7xvlK4/kK/g8UHtQdRmm9GT0k195M8lgMIAGLZpAb?=
 =?us-ascii?Q?0OIf0K7WKy0dKVMJ5pgjab+ndFdFNOGS/EtnqKroPaRdTvCEykc9yXOAX3ji?=
 =?us-ascii?Q?r9wAufZ9cvJbL0gq55D8U3nSIT6NuBUjOvvy0h711xW7PqGu538m1KOItu43?=
 =?us-ascii?Q?BzqwUkBJVJlWNhun/k+jdlKX/LKrN6ZpmKuyNvVOOZpW0TiBaZUfw8kwrFma?=
 =?us-ascii?Q?bSUuGIhmdqgKjRXOx79zMPKm2GA7B7Vy6TkdERP7AYjf6ko2xsqc7nKl9CLn?=
 =?us-ascii?Q?l8j3WcOdnzyZtuh/O2RzZaqwFvDkGtoOYY21URv3tRxak/EJo4KPgQNHUSwY?=
 =?us-ascii?Q?wA7ztmz1MzQhj0sZlbanEi1WluR/Ce2okhizaL2J89OwQm/37+S6nflf3zvF?=
 =?us-ascii?Q?xfuO1bXyZK0xpAMS/dpe9zVCZcPjAJaW3SSnj+4TUEtSDCcbOKhUapnoGoxP?=
 =?us-ascii?Q?s1RXCux9+W4p8t26bW1aandeuR7JuvKKkkwLhvrCQZ03ANutPjjmG3+LhYBM?=
 =?us-ascii?Q?2NPAO71kkkYbEwH2gnJis1g5YTn6ExgIacwmZhcvKzIGqwQE2v+87UoOl/sY?=
 =?us-ascii?Q?AO1V0NyBj3a2a0OQIclUovE76M2nl61yr/xnfPTIoW2tA/UPwrw363jAK3kn?=
 =?us-ascii?Q?gbrrn9ACRR/ODzWdzDwYGqG6UCDh1/6BtioC0wmxKA5u1BqngaqpB4LOT04u?=
 =?us-ascii?Q?5MnCLw1zKUWnUEY2655Kyisc+EvdyGkv59R+e9xNccQ6FRtZVzqdBVJ8L6bB?=
 =?us-ascii?Q?4wscxp7b941+dKW/9/lNH+ag0RGCgmzC6DF0Q0nu8bHz/6bdYGJhMun0Kz7S?=
 =?us-ascii?Q?lL599qm3KuflRQiBcMBeXXI/zPSossmzgXimFh75wIur/RRwXpq+lA6tNIul?=
 =?us-ascii?Q?lK/lN1rguTlRO5TfV4dmysb2xyjpD69sY876laoc2as2UjjfPaJ3SiOIdtmq?=
 =?us-ascii?Q?2AqBDeec3zwKZFjvEP2/nV7YA5B3Mfa7i2k1QWin?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mGJx+cGtFUFOyLtjl6JSuMGtZonsTDnUfiV1x6yN4fPMi4A+tzVDnwA6OsKNOxW2TTgqGOPadan0Vx0UGCXhWj8UQxsbNF+Ek+Hs22sRzNGLwnzGJBI9SS59lvwhy/mUfiMMowE+vyHHmn0R8bC2iPFPbiiNfu4eyM5hS/G8z/R8wZKXJXABDKWX/3reuocp3cNlH/qitokokdCeCRzvIPPnLJ7QPTFrBaNbydFJG6W8aVfMPq8DlLn8mZgy8acDXa16BOiIBY/2n+e8FhH6lCp2GqxKIJSYYkq0bM5gFNzVRKT0IR4pxVaiMSkD+gGEoOO/HEST0eB3HXFVV2HZw/q5i+Kx/z2E4IHJ2ns7My77Y20OO6nB/3HrCYBMOBFVBK7aYaInc9Zw5dDfGyRdSeGmaieYgE2g70S0nE+GelTc5UfNEHuu6TXUiNI50PqK7zZucUVOyRZngGs3krrijHqPqHfpRdmU7tsciIDxVvd7li+QmKo9fLfwP6sAGnbW51EBpkmphMivJGZ0R/y8h9H7lXFCeeNMSs786qpCko8trafM3WRhCNu5DgivVIiU7GF9laUAn24TSbEEIlqn1LvFC8ruy179UbidVv9J4x0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94065f4-e07a-4af2-b5d8-08de281920d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 09:42:39.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BrnBnuKD4elynPecZWV7WdmzfigVZ+Cwdm0BpxeTqbVIiP6pmNTrlFDkPFQURa4tsHEUIfL0n7rtzvHbu7z1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200058
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691ee295 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=W9BqLgzXg1EqYeH4nf4A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: FJSfOJP0M2aCzhSNGMQAuDn0h_JmBwqh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX37RFKbe9lcwF
 8RpAscF8SF3jgTtWae9GYajQudGQS3CXYUdKa+ikurRpu4afyXoHc25qEF8NKzqFewwbdvLJpFz
 mnB48phcvFMP1K3HDgreyk3bZhMKYkiU/lrrlpXnf6S+sW8vRLp7u1TYLAB4bbfgi94aDcyFTpm
 6jigM041wV0CkbWCR4iL3rgxAO2PNZgdVGL+4xg4nx2YARj8MZo40RPtSQExcSDi8uzm+RD/+zb
 7mCrkvLTYtsFJCXO+BkrbKFB8k6iPiSxusOcOaGslmplV3nxAIRgU7l2h9SRpwbogoVCp1FnW0H
 fns7ETqC04e34gquuns+wL/UvypA9XSPcDu1moeBpcVXG4vYfy3erNgWG/rNoIaWxg3li7PHDXI
 TJmfbgmSExIOcPH0Spp1DRdzPDZuX21c0p8G7w4ikDm1BMR1my8=
X-Proofpoint-GUID: FJSfOJP0M2aCzhSNGMQAuDn0h_JmBwqh

On Tue, Oct 28, 2025 at 09:58:31PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in zswap_folio_swapin().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

