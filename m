Return-Path: <cgroups+bounces-13320-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COTaJPchcGlRVwAAu9opvQ
	(envelope-from <cgroups+bounces-13320-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 01:46:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 053574EAC6
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 01:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6C38A6A96
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85D428827;
	Tue, 20 Jan 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mWXJHzaI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lhEu3QtU"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107A427A09;
	Tue, 20 Jan 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913794; cv=fail; b=CIX+/kkR88X813H64SU/38NMz9T20YuGsvpdws08Xhifp1L41/itdbhDNHyeJ6mpAJnpb+vmf38GqoGsqF2XFSs5qXrMwHAIkzEOqETEPPANkO2ItY7xJ80lwnlG4oWINw6zaw3LGEV1kGc+q5ZeiqIoKMIaVFQFPm3NNZqaXnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913794; c=relaxed/simple;
	bh=iG5MAc4QWb39t2EA0vpgTp09g+Zq02L1AZuc8EfUVy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8n8u438Ylue4iPyJjJEzgs+wUyes2KDR8yW3Kyx6mAUPTgR9tRYkSpspXGh9HPebhn4AQD+d6hEw0UvRWX6INByo03AYgOXUSLpz/djMWqh2Wy201SKoIhnQlLqv7ISqvZxS+p4ta2D9EbBniMIkQ8UfQ/6nT9XzwOS9ZuzQD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mWXJHzaI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lhEu3QtU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7v1ZU3029082;
	Tue, 20 Jan 2026 12:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=41LxM6/SRG/iCpkOav
	iXqtB54/VsNA2SHG9ssYCLwts=; b=mWXJHzaIjgAbJvE90GNO8mg75vE6twB0kH
	HoN/pFgqUa/G22cJRMFQK3ibh1/qtwQWinFmfeXTkVLFmeZp3vgZ1TwSWNcFlmsy
	5A0uAYAsxKDjGlIloInv9DroKZOBKbt+g2tSXolyEPOhUSYtTdiTXGIgL7MT1VUw
	ogdSD1yuRPLsyqxaDgIZCFlu6r7V7TcotQSMQo8AUyWyE7KRjeam9lAPDd53ncsF
	RStAgZNnD13MiSCPqCFyB4LAfqwv9+9KiyYtni3iKd0irm41Yr0CTzIN4GJ3BEnn
	RX9raV0dIEwNGdnx1nlMRoPg5PiG7t6XruVotriN1f5xJvFlFyKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vuhvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 12:50:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KBqUrt038729;
	Tue, 20 Jan 2026 12:50:54 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v9kvgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 12:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W59ooPi7XYQ+7cRSnWew1VfdZK1XrOXPVx3d/b8I6nQ0/76to+gU3fjbJS9zudYWYYg9TYoqjBGNua4k1M+fDQINJn4V5YBTVooOiZcUjCjMZtqkgt5rMMfLq+QgNm9dsAhBiOBhtm2PJtc99arOoYat/sgOrM3GH90/+g6JDSug4/Ko+GEAeIwST2GjsIK3WEkQ60AAaA57p+XGFmLjBlL0B5EuuMDW3Px3lmKnCxlewfCnugvjRNNKIGuAxbcK0ZFJ8Tw6p3QUExJCbRJ54DoOZw2QUNU4hJs8CU8zk2zhBCMv055hN72z0XP7hmXKoISxvpijqbkq3HYrAW+8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41LxM6/SRG/iCpkOaviXqtB54/VsNA2SHG9ssYCLwts=;
 b=bAkC1GF9V99SxSMe0ppFH1kxuvQUMlxnXnMxXJNa0Z/+ijWUGYA9AoezGcQU+/PMlUSUQDvLySsj/8OBnVv0kJGpr9HvvgXbW13WytgQ6v7TD0LZ+AD+2Gx2uNgx7GMV8V0E1efra+ylQwU+jqTGFoKQPORPCzascnNT4abZ6Pbz9yP6yxPU4jJFOh+SJKUU3KDxAJ+5ZmwHYXQEapJeKTvt/0gxrv5E+xzWQLKios9BQAvnMsSrJMeXN82XxF2sMrp5pKZw5XjWf33tf8no3ImoeEeU17q8OU0gcqUFTDg4GDx/QAetvdUrGcWWpgPzZTWuYkXx3UUNsarltQatCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41LxM6/SRG/iCpkOaviXqtB54/VsNA2SHG9ssYCLwts=;
 b=lhEu3QtUR2ODYAk0jdLL7RvX18MwkeIHILTo17SLE1hXvHDZH1/gjP1bUvORbkt8vgWLlzDWOUnO3RQHb0KF78rpE3xxCQSRn+UkBJ3mEEnfSy+rnUcltjyET0LnyhJO5+q3t5lcPJTTNb2SeGcK5HQSW6KC5RL3AYSw7/se5B0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 12:50:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 12:50:48 +0000
Date: Tue, 20 Jan 2026 21:50:39 +0900
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
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <aW96HynobqE-qKz_@hyeyoo>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
 <aW86_5SOdtQQnVr7@hyeyoo>
 <88d90d30-8f54-43f5-98d6-1769aa05a10a@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d90d30-8f54-43f5-98d6-1769aa05a10a@linux.dev>
X-ClientProxiedBy: SL2P216CA0132.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: d0233ee3-8285-4f44-2831-08de582288ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FfHVGy23ld5FhGMHgbHWyB/I+zwto5VEB44eb9nXkDOfUlN4/NE26CXHBaSh?=
 =?us-ascii?Q?2ED82ni8SCHvezZhv9Ezrs7TiST0F/NkxdjNxGooL3FeackyJB3rqoq2CpVi?=
 =?us-ascii?Q?kHSCNtm2Wxb1NTgBddWjgacudYeCPCp+CYZNqLORrTfCvsjgK0Rg7No72+IN?=
 =?us-ascii?Q?lhHf6H8L3JszQHmov07CFuWAQKJ7e3sjyTPBnmDxXYhG24Afsss0dJJe8DNX?=
 =?us-ascii?Q?/oqVB+54R83zYJSJZFnqOV3jYW4ivPHPAtD+iE0lsFqoL8fE0NIQlm5EuCYl?=
 =?us-ascii?Q?5eBYA0MzCqUDnaJRPtLm5rZG4Oh8IzucqY42tNrCEAJATKCfUdkXRO1CdV0i?=
 =?us-ascii?Q?EcdoTyUCWsFqdrQTNmWCdGEo6xUa2z1i5RZlpSD/8xrzYT5qPsSbt5TwAFkE?=
 =?us-ascii?Q?7IRonCK1sWcqUtN2sxhyi0bihAquu5j9hJmC8AcuZGXHhT5goxDwgdVGgyXm?=
 =?us-ascii?Q?0yqTAv63989FRcrTxn6SoU5M3UU5Dr/nsYkT975gHuvddo5/a5+g/RH31n+Z?=
 =?us-ascii?Q?X0JG4ZBbeCTwlgOPh5d5oW0sdAE2qJWpvzXKHXjXr8HT6IHXLQbyXrplSe+r?=
 =?us-ascii?Q?uOtwalAdjZw1i6sH4iM8I8Eq7zr+i80iZZJzMx87TBY4Lwm7VNf351K3I6eD?=
 =?us-ascii?Q?No0M3LhR4SsSxXV2fab9e1EXNI11HwfK+jDWozi42TkfS5VlvhLl68wxncAX?=
 =?us-ascii?Q?r1ox6vBQYyB2YryjFq7byGvfdcM6DaeKroOQQG81V6PT00+VQkF8f0JvDjjW?=
 =?us-ascii?Q?lbuWXcg+khoVgrgXtoLFE3pxzxKYtr7KeWbVyfJahDrGbObIV3l6lqezoyrY?=
 =?us-ascii?Q?7eSuY5yufsIIT0Zm/QipIcB/E3WllaLpuDsX/I39mbYHP5zbXeUpzzu8Uhey?=
 =?us-ascii?Q?Jh121zUUyB3CSIiH+zyRz2TNXgDVT9CObB9KUjJXQ2rJ900Q4eZqya4cQUv/?=
 =?us-ascii?Q?XJUVm80JSPUQ8F+yfHxrA+syrQfcijNmt9O/hd50gtuoh3OUZME7otY0o5cS?=
 =?us-ascii?Q?Jjs+GBhXYFRlk9VDdXtVejGNjKZU0h9DVRu42Obsci4iDGZztDtCVDlUEGZL?=
 =?us-ascii?Q?EFv6pi0834kUjmVUMowH//7e7hbArYUG7vClmmlpE9s+kJJCcGuqvwOZncNV?=
 =?us-ascii?Q?z9Yy5zdct4u/zXiVTkXCIG5iv413VfacLi92gUy4hubv1jyEHL95xs1o46us?=
 =?us-ascii?Q?de1AUGJd6EyfXhpByhsqa53D2Q53V02nCQvwRThC6wpkmwxSGbvpmVjpQsns?=
 =?us-ascii?Q?GiwcrbBvwWYnRffYCQikF9GCBhk4dp0Ix/9LHs3vUiPDUap6WG6slnAGEPDw?=
 =?us-ascii?Q?Vz6IVHzhykunkiM1hh9hGZuLsmhz6BbjI42MAUdrnWnLo0YfH2Hx0VGWOeZ0?=
 =?us-ascii?Q?bSdbdTX7K3OG9P0yNhJupVlau14KZwBC1XmLqW5hE6VfkEfECKjrBklgXNQQ?=
 =?us-ascii?Q?2Pwx4zIHqikmLEE2OCUPdccWOl5+7e9HRh0/2y9ajC12vUE3vtr7YS27dSnM?=
 =?us-ascii?Q?hHsRT1euoT4Ke1Uh7Zg1nDLrzRML6JiWFEvrXQgFkkibyxJNR4ww3mst4Dpx?=
 =?us-ascii?Q?WY80/omXoQst3Rmdrvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HDhIDeiezErXTf6L446Z6hESRW2sBJpsm5RoJeR/7Av7e8cpU0A3Ksiy7THE?=
 =?us-ascii?Q?DKvkldpQmVlPRyujUUzOmjLTFkBqVfQnmt2dA9AUfDso9P1nq6TNX4jsTJDZ?=
 =?us-ascii?Q?f5ua7cWKkALv7iw4VUK5iRDwMW/+GR6dTDX9+k2caX6X/+FTpSQBOiBO4cCk?=
 =?us-ascii?Q?eou1pxmauJl7KiQrHGdTS0zWHtPE/SbyiRUh0L7nwSoBcJ/UAiYuJFEEz4je?=
 =?us-ascii?Q?z2fBbsjfL/fJsZwzjO5OuJTV5tasWGbQX/1nZpoPdHDF/49GFU/y9gKFro3B?=
 =?us-ascii?Q?+frdABB1QY0PiS9Tf9ZlkRh4/6dhfVZ3IDo9UO12S5rutPgQjgvQPzDrhAjq?=
 =?us-ascii?Q?jBHUmS4qDJA7+gOPHARvJ8p1keTPbCkEtEto1y99UK6X9+b/2jq6AsTznPCV?=
 =?us-ascii?Q?dRF9LPZ/6KPl5ntMlO1tgwmP0LQ2iWgGzr+wyjmiN+tWVP9V6aKQZkbgx5oO?=
 =?us-ascii?Q?pnfo8CQNA14kQ8EX759mhZopoB9YntjSdG0605TIzdHt5YXpaCl3tRuF7/Hv?=
 =?us-ascii?Q?AiJMZX1Y5blS0f+f4k6ZRduin5VMduW24gykDPKjUf1ukEkWiV/OD27iE+mx?=
 =?us-ascii?Q?fb0lIgHoEvgQ1U7CruSXf57Hgj4PGVhHeFgXMS3su+/Et+FJZf2cE3TCEJsW?=
 =?us-ascii?Q?H7M5VUG6zA2hAOhJ/s0UTHF1aGINIzwz8AhTU3FUJl6xUuuqT3idEK0obSGC?=
 =?us-ascii?Q?tRnomwjKxJYb2PHt1EVWeeUccq2v4S1lgLsi+IsQlB4WM/LjAlYUnScys8Ga?=
 =?us-ascii?Q?XTaHqHqFvU6P5PXZp1e2eO00KnIkx3S8ToJ6L4sGWbhPewrv0NLt0WwB+6Fr?=
 =?us-ascii?Q?njiv4o8WQiNY0MQl/NBPfe6f51Q4qjfW6W9YowyXpACXl+uujejkZvdaUhCw?=
 =?us-ascii?Q?Z8VcIKO3Rkj/e2gI7Le1gZAnsv7/74ipbpCQsuDQ+rC3zoSeSPrinYjXYqMU?=
 =?us-ascii?Q?+/OqGUSDCc5Vt+eRsNT/X4r+E7TeGtWw5TnyZEX0K6uDt0LzWx4DRAO1ksG6?=
 =?us-ascii?Q?P/1fzemwIT2rwSa18QMRgY9aOpDQoQukDLcxwtI+CGvLTSPvRZeFwc43PBJ7?=
 =?us-ascii?Q?vax1hOWXOf3Lr5rd5Vy2vMHL1AfjkIVjZ97k5pn1PCPZH6xaPxJYiqxk92/E?=
 =?us-ascii?Q?qGm6oQ4aCHqPRFz1W59Xv40A7QDLEd0fzhD3lfVAlXB9gKZXFjmgs9piJptx?=
 =?us-ascii?Q?MvBjPNygFAijGueFI8yaloJgPHz5/z1mU39ns26dK7b8CWAc4+G/KNK2okQu?=
 =?us-ascii?Q?oWYRm3sn/+mAugY4WeuC/mebgC3CjqxDQTf7wzhqG6uxa5y09SZftSsVoQZR?=
 =?us-ascii?Q?F5zdGNazQm+XS7U3QgQesAshEnBzUXxPSSr/7cVqCUsVpIu6bcuIJs3QWPKZ?=
 =?us-ascii?Q?YN3P3ZDwnCCRO5u5LbgZx+4zN93pwSChXax/djc0jlRmobpIHo4BcPCkVECM?=
 =?us-ascii?Q?0mC8IAjtooDNtSaKOeYGCDiSwAJ7CgIVmriPCUvcgepU93Ynlfb1OSDmp0h3?=
 =?us-ascii?Q?JKfiW/JUdlhWVJa9fGnVsaECRcNh6/+lT41E8C67iH19pcHi9qBLp96VAVj5?=
 =?us-ascii?Q?qvNLk8suwRQlY5phVPOKimD5okLNeex+osoKqLW5LkOjzs110D5JeJm2CmW5?=
 =?us-ascii?Q?1cidWwjp+q1gISU6DovcgeDIALgasyQjpgOq3KK1a/Abb6AJbn8/Aiin1ni/?=
 =?us-ascii?Q?69JjGmhCP6eswMmfzs/5yFmgA8vJORigDObbkpYoZqWAyggBVUpEU9HzFgfo?=
 =?us-ascii?Q?IL2jUsNJUw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yYcBfhT7/ZeP0M6H6byDbXAH+sDG+jWop/oGKqfBucJSrJwqhTTBfvNkDKnU2ILrkp2BkKJ2Mf5blMROEcUOJbsJdR4AEz71GJVhsAGPLbaOQuqvE/cW2sqZ3SBjKQSorTNov6BZhOPbSzB40yaq+NSKg2xrEbdvG8dnv0N1TCQTAFbfmJebrGuoSDLxVcYYT/KQuPdy+tTsw2vHx1q6LtHPAqd5edp3Q2xPtt0LKgN2XqYZoc9maN1Wu7muQrVuUMJIutEY1N+UcmmglZ8Q4IdP22CqpPIh9SQDIdiO9uGD89Q1AHvmERDFoy4S5PARM7WmtoKWsg4i4Cmbw8IMD5e/qWFQE/UPtDmTh7tBEOWGh5JyRa4yv3/VsVWGnxa6Y8KPtcdNYWtK3AjSo9bShr+USUx00L2Lk56ZipKG4/WhTEDisGwqGSlTv7IHv0+NXBmMBOEjbLAB7sbasU9cuQip3Re8TfeOocmCw4A4VVY808o7EiU38+vVO3qkBQ4mF0oIh22rsExUObCrOEKoy2pRQvuxKMgagHN0q1hqIji0x+t1ySQ3sMgp/s80YY6AqFEyUpw8fifItV/ZyowlkWY3RdNFb9yCc7ZT/W5gD+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0233ee3-8285-4f44-2831-08de582288ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 12:50:48.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQfMNIzMW3N6+RUoFnft71YQjNjy7ypvnBawNXtXhlAFzRSRTS1TUQirj6w3L0rAN99gS9gJcDIuY1A+RDGdxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200106
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696f7a2f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=Bffyql14oAGlypo2tCUA:9 a=CjuIK1q_8ugA:10
 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-GUID: m_JoQqer8urG-ZGEx9PoMxtx-U_Fd-hm
X-Proofpoint-ORIG-GUID: m_JoQqer8urG-ZGEx9PoMxtx-U_Fd-hm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDEwNiBTYWx0ZWRfXypp50oLj5Jwn
 P+mAX1Xin8Zni9exumhUL6PZTE8GVeL5fPWpa7RwB4HkYzpnxjBNJ8mIEu7ILbdc9vl4385gNo/
 zyJyu4l7NsCGYbmfZGQVZ/SVnlRirblDnPl/2sYmD2qZqo2zyMb61CMyVnwl2O99eDqS1qXZi0s
 yIBE9XESLMBYKq7+W2SYPUCjRCipfX6aErPPJV+uf/ws5E6CZ9nNvT+B5/nxHTYdhkrhLa2+t5u
 FuaayhRWjxZ68XK94dWuvwkdXKzelq/JvIdFsY3yH0ImTcHv/2Gf0SIcSQr644P8E/rqoY1HyYq
 HEVz8n/QsFnnecuLIH5p+H7xUF3GaQmfJWLDUkUJZEtIkCpcaTGu6pszgXHVCk9XNd1yfUBzOHM
 pNv+ty+NNmEPseEF1w4NNRKrZJwg+BxFh6q9/uMjdD0cjn9bPX/e0zXRfEIqbgNJ9cLCgPRNjCz
 5kA6FLYdQchMI3BlJ4w==
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13320-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.com:dkim,bytedance.com:email,cmpxchg.org:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 053574EAC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:51:29PM +0800, Qi Zheng wrote:
> 
> 
> On 1/20/26 4:21 PM, Harry Yoo wrote:
> > On Wed, Jan 14, 2026 at 07:32:51PM +0800, Qi Zheng wrote:
> > > From: Muchun Song <songmuchun@bytedance.com>
> > > 
> > > The following diagram illustrates how to ensure the safety of the folio
> > > lruvec lock when LRU folios undergo reparenting.
> > > 
> > > In the folio_lruvec_lock(folio) function:
> > > ```
> > >      rcu_read_lock();
> > > retry:
> > >      lruvec = folio_lruvec(folio);
> > >      /* There is a possibility of folio reparenting at this point. */
> > >      spin_lock(&lruvec->lru_lock);
> > >      if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > >          /*
> > >           * The wrong lruvec lock was acquired, and a retry is required.
> > >           * This is because the folio resides on the parent memcg lruvec
> > >           * list.
> > >           */
> > >          spin_unlock(&lruvec->lru_lock);
> > >          goto retry;
> > >      }
> > > 
> > >      /* Reaching here indicates that folio_memcg() is stable. */
> > > ```
> > > 
> > > In the memcg_reparent_objcgs(memcg) function:
> > > ```
> > >      spin_lock(&lruvec->lru_lock);
> > >      spin_lock(&lruvec_parent->lru_lock);
> > >      /* Transfer folios from the lruvec list to the parent's. */
> > >      spin_unlock(&lruvec_parent->lru_lock);
> > >      spin_unlock(&lruvec->lru_lock);
> > > ```
> > > 
> > > After acquiring the lruvec lock, it is necessary to verify whether
> > > the folio has been reparented. If reparenting has occurred, the new
> > > lruvec lock must be reacquired. During the LRU folio reparenting
> > > process, the lruvec lock will also be acquired (this will be
> > > implemented in a subsequent patch). Therefore, folio_memcg() remains
> > > unchanged while the lruvec lock is held.
> > > 
> > > Given that lruvec_memcg(lruvec) is always equal to folio_memcg(folio)
> > > after the lruvec lock is acquired, the lruvec_memcg_debug() check is
> > > redundant. Hence, it is removed.
> > > 
> > > This patch serves as a preparation for the reparenting of LRU folios.
> > > 
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >   include/linux/memcontrol.h | 45 +++++++++++++++++++----------
> > >   include/linux/swap.h       |  1 +
> > >   mm/compaction.c            | 29 +++++++++++++++----
> > >   mm/memcontrol.c            | 59 +++++++++++++++++++++-----------------
> > >   mm/swap.c                  |  4 +++
> > >   5 files changed, 91 insertions(+), 47 deletions(-)
> > > 
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 4b6f20dc694ba..26c3c0e375f58 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -742,7 +742,15 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> > >    * folio_lruvec - return lruvec for isolating/putting an LRU folio
> > >    * @folio: Pointer to the folio.
> > >    *
> > > - * This function relies on folio->mem_cgroup being stable.
> > > + * Call with rcu_read_lock() held to ensure the lifetime of the returned lruvec.
> > > + * Note that this alone will NOT guarantee the stability of the folio->lruvec
> > > + * association; the folio can be reparented to an ancestor if this races with
> > > + * cgroup deletion.
> > > + *
> > > + * Use folio_lruvec_lock() to ensure both lifetime and stability of the binding.
> > > + * Once a lruvec is locked, folio_lruvec() can be called on other folios, and
> > > + * their binding is stable if the returned lruvec matches the one the caller has
> > > + * locked. Useful for lock batching.
> > >    */
> > >   static inline struct lruvec *folio_lruvec(struct folio *folio)
> > >   {
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 548e67dbf2386..a1573600d4188 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index cb1148a92d8ec..7e53479ca1732 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -284,9 +286,11 @@ void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
> > >   		}
> > >   		spin_unlock_irq(&lruvec->lru_lock);
> > > +		rcu_read_unlock();
> > >   		lruvec = parent_lruvec(lruvec);
> > 
> > It looks bit weird to call parent_lruvec(lruvec) outside RCU read lock
> > because the reason why it holds RCU read lock is to prevent release of
> > memory cgroup and its lruvec.
> > 
> > I guess this isn't broken (for now) because all callers of
> > lru_note_cost_unlock_irq() are holding a reference to the memcg?
> 
> I checked all the callers again, and they do indeed hold the refcnt
> for the memcg, so it's safe for now.

Thanks for double checking!

> But it seems rather fragile,

Yeah, it's fragile and

> perhaps we should also include parent_lruvec() within the RCU lock.

that would be much better.

> > 
> > >   		if (!lruvec)
> > >   			break;
> > > +		rcu_read_lock();
> > >   		spin_lock_irq(&lruvec->lru_lock);
> > >   	}
> > >   }

-- 
Cheers,
Harry / Hyeonggon

