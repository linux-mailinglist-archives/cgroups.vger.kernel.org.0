Return-Path: <cgroups+bounces-12586-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCCCD5C16
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 12:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBEC73019344
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE5E3161BC;
	Mon, 22 Dec 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QfHOYwK6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O+CZiJu+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D93161A2;
	Mon, 22 Dec 2025 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401809; cv=fail; b=thRzsSeeOqX2fRS6VFeeMWC7gJAROlyHkXlgUWo2nrGb1ZkZQnb5TE+ektLGpgMekQXGGBd+Wbuoja2gBqrDDQJNimYG/xxrSJ2xPVLIxsm0/YeFUb25pznYMqhKumGIvdoZxaJFAbU7puY0TxR47thXb1fffVCOWKDglC60PbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401809; c=relaxed/simple;
	bh=buxMDWtOovbagoJxjf1pQjpvHi3MB7//WJ/bSWxc+cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAxfRG6DZ9D4YycUw7q7REglqy2dNOxGw7QRfvmn3uKyiP5ycdofPC5y/hdavSaQV22wR5pHuSmrgfBgdyEpY57apdkqnpLJk6GBGs/9zzRT4OdFu9v/SpHJInEvAQJ0mPxh69WqV/9pjqmyNEhB0EyI1IpFFKOpLjxVIuTqDGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QfHOYwK6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O+CZiJu+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM7V05a2042999;
	Mon, 22 Dec 2025 11:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TuA7txRy/WPDi4hJJCftPxPaqvSz9zuEFZXeuHlioAw=; b=
	QfHOYwK6G7kAA+ACLnUZIPS1oObbNozaf7D/M7rlPBHvVxeczLyJZHVtESFSpkUt
	NRFM0j1tU2h02dySQQ7zGz8jKv3+el80B6v4eYyrSLN10c75kmLNlPNlEBj9w6bR
	Bn1Hulu5kiNdE90yrXIQRIEhZSENPdBGGHJNKjUX2wJMm+T6BBA1zCLzd3sNdbra
	asqeoJX4XtRO0ACrs7hL3p6Rf+YbV/q9tIM1jRT7QIQAp0SAFFPPkEM9LFUa3l6L
	XnnDv95G8KvmbPVms1NVj6Ez9RAQNRCTXjz6Jc/zLXsxZ9qQq9VEMHe2rgDap0Ba
	w4J3slopo9apejN5aGF99A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b71na084h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM9Vw5j032709;
	Mon, 22 Dec 2025 11:09:21 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j876hyd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdrS9nQXAMXR4r3LDUGGWrFUCoqjSqNmmijbz14+cw7Q5ZhXiGhWBk/WvFezKgDALZ5EGEqXauxhWz5+0ReEKXC6yAZDV9oSMXZESJmQh/3pqQ1FqO92TF7ZWATX1d7utc7J8tLF9YQmIaZV0KyNpASVFXdEQp2jqnNXKNG+e2+hIYP1WTAroJTuwpOKyem8VqYLNTsZfQmjVSEbJ4LeVYZGddkWtqHoTg3fXbT68aYGxVJW04yrcx7Cv1dJZL2CWbUELY0vpHSZBsUa5IcaBow2VksX1mzcTeKDOoe3hBxnP0t2YXOjiFQra26cOeIMtqR217RYMrscXakBkLU1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuA7txRy/WPDi4hJJCftPxPaqvSz9zuEFZXeuHlioAw=;
 b=REoIylwjshaQc8yg8kCdwP7tnoo15Kkl7nqGeRyT1WpXVymnX00MjKxQmzRfdSl+G6WSnphZEc3Tl48P0aXMDM5JYNX9nKlK42LyMHroCPsHJ+gGjt9OH9pRTT4v1wCJlq0nb+ArrsuqcSXQsw+tu1Zs6nlQ1CBhTeem4v5L6SK09KDrXjq7jxUZHSneJGik4g2sYuZI5+vlvlon69883xVtPZvmlW7Vf4M1en7Vb2BK+9f/WaG4E/YKZxDqqLuRA6KaXxlX10pRB7br36A7ZKQjr7dmrdiK7zHaGjg7ESqDEV7ONc0O9QcmZJDoNAXXXMoPxfYrQ3oWpwHGwxQfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuA7txRy/WPDi4hJJCftPxPaqvSz9zuEFZXeuHlioAw=;
 b=O+CZiJu+r1/OmR/TUJOnZqbRuY1v2fVH+AkXQ8YRviI0UGypp6nv0dXkz92NM/ygYNfgDr7w6SNgLLiKkE2tDh2P0aNFB+e2Xbj4wO1alrKuE/MLRo8LjouX49pOH4iv5sg0eaoax0JMHbZEQPGcy1uXcbkPouK39KLVya6ip98=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 11:09:18 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 11:09:18 +0000
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
Subject: [PATCH V4 6/8] mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
Date: Mon, 22 Dec 2025 20:08:41 +0900
Message-ID: <20251222110843.980347-7-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222110843.980347-1-harry.yoo@oracle.com>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0036.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ebc1e4-6ac7-40cb-b99f-08de414a8d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2D1O1onjCZ2eQ8R9D/PVUkmgn/SzqIx3gnuSjO2zQ8F/DWX7ydmSTJbp+FeP?=
 =?us-ascii?Q?ARv/mQZPvePzJV8/RCsUxaxZerdhssn75eSYRyZm8wkU2RsZB6QJTc2F8QOS?=
 =?us-ascii?Q?PSfvJ8d9ZbKMq3Qoc+y+VvH30hQF91pI1ejRBD2eNY2oZQ+CEajj046EBUmP?=
 =?us-ascii?Q?AtHpUPabqqGdu89tps28egYaTPHA+lWNf9wZLdmX5EdSGkVkSXApfJXyOJG3?=
 =?us-ascii?Q?WVvr4xOXwSLEFVMr2p+zvLhvQ0jneZ1WhpbFkCtHQf+mICFfg19I7JeCA1Fk?=
 =?us-ascii?Q?QYmgF/+v8Tji+qwcH9HyoFtOIXv9q/VONC4wxbjLT9U7ugBUHBAt8lVvzR4N?=
 =?us-ascii?Q?mFD2CDJNpnO9EqigNH3SFVSALmjqllCtl31iWVdUX8NRT36xk+gPcQNCVGyQ?=
 =?us-ascii?Q?LH0DMShm44M3oQLysnbMqZH+gHhsDHzkj8GnT/wxIBRx347lklwilDdg2Y8l?=
 =?us-ascii?Q?NUwnRIUtrFM5AIw4IpyPtlQZcdYr8vhdhNxR/Fw+a2eTocc9o3cVbogD4UKY?=
 =?us-ascii?Q?NIqlPaYPujNA4IkVteTZuTrSYV4GG+7KBNCVT1b6mZ5UX5p3MYP1hayDKGvQ?=
 =?us-ascii?Q?HLkwHgFy+TG4rPp4D6nJEPuezcOAVAxG5lY5WzjbWFnYvlZ1T8GAupMeB8qs?=
 =?us-ascii?Q?JPQ1Jze1e5tjnZ+oEdf3yMJTCKHpJ3OKQfw7ae4epYyvY/c1+d5fmxcThnFY?=
 =?us-ascii?Q?rzJqH7Ae7B92U9SGaehbQnwmjGfs5SQYaWi6o5IwpzoIyvj1fNAE4+22wvDw?=
 =?us-ascii?Q?0ffoJpLkZaE01euJ/1OuH8k61QKS6eqtWcWuiKJfTxBv2QxO4ccnGzM+co1p?=
 =?us-ascii?Q?hmvZVtZRDC+LmG9dFpb+ZrCwgk8ElxvwN5Yt8w8Xj6z5AVHe+nDZusKXRjtO?=
 =?us-ascii?Q?7ZRCgVr+bdsdepJVYPF7NhgOTL28Q6KUC19DIljdlNTkHUyl0eWBn+kPM5CG?=
 =?us-ascii?Q?/N7uzf/Xnv7ZKrylDltpZ+ZNRm9yjlYD1ieq7ydYzgQ6LA/DirrIwkKVRSlQ?=
 =?us-ascii?Q?QwrkK1hGgzoQYKR4TqqrqYl25jp/wceiLsfKrBqG/xYN5FY11K7Bcu1jdce4?=
 =?us-ascii?Q?2AxoQeNoQBxDcZ4UWZRqdjW/d2lH/PfRbg/CYsbWHEXOxdDI4vaedGvn9Srn?=
 =?us-ascii?Q?gKkEF2JFM3UbC1EBmtJW/RcXVJ2WXvzyd/mlm894gJtivd42qdz/hLykcvfP?=
 =?us-ascii?Q?SSbkvWxURso1y2vthYpZSluY3CiX1jISlmQs4eyj/32SrZKV8VW9lrPabCYH?=
 =?us-ascii?Q?K+vEdrpUEdXQaYOjIuTO0yPH9O3cedqn8TaHNox2o3dl3HJCjP+VWuiZjlKq?=
 =?us-ascii?Q?tF0oUl4+8p6tB15EB6zKcPpa3rwmGjtFb9ChfsYzXoULxILwhWNUw4rI8wv+?=
 =?us-ascii?Q?vas1JXlWZ6vLuSXlnkhLaY3cP4DEyYbKMvDjK5v19juA10ALPE7VS9fkaDJ7?=
 =?us-ascii?Q?b0IBE6wF84x6DBpSnNC7PL6GhHJIhcjusVp+n7if/3JO3zsBkOMMIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kojxijP3IbxY6PZAi+LMizSr5qcnEMZok8QXkht+pspQwyiHB+X+xoCR8zGr?=
 =?us-ascii?Q?mrBb+UhE4PCM+Wrje+BPCvAsupPyuNBsaYDkFju7W6byzNKABt4Um5nhChzv?=
 =?us-ascii?Q?nYzrWpaIfrXA/COJr0MOKG/I3Fl8ugKQQ7yUvJPqWOEuQ+6q0KQLQNZQO675?=
 =?us-ascii?Q?3sTrMpFU1t9bJBG9BAKMvQnwgY/fDXoDjajhkMW3yfkh0F1ESGD05Zmelp/j?=
 =?us-ascii?Q?Jh7SRCm6uihsmnTAD2npghHk4hPZjdvJaxTElVo8PB6VB0MzJ1/s5xNlzLaz?=
 =?us-ascii?Q?w0afiXrswe/My8eca1Wr8A+rTZLKb/Sb+9B02ZXYf838P0QV74xtHo7DMd1+?=
 =?us-ascii?Q?AlSaCLbT5kIOykz+ZPnVtN8Wsya+ucPjbirLzX3kuqbc0Ch5SKJt/Ensebv8?=
 =?us-ascii?Q?d+hWFEWJwsBwP89YIEKHl2WV1sXra6EA0Mi6IlMb6JuExjVeHgdxNdjP2yGZ?=
 =?us-ascii?Q?cVHUuxo6wTC6MhjrHABcJgTJvB/yuh/OrQaz9FTHRC/kM32hu4oUiPjCiRLu?=
 =?us-ascii?Q?NeIVD6rw/fIGvi99m621OtyQ4PBtEsYJR7BQtLMoBjJ2fH82QHTpfHsRGxXz?=
 =?us-ascii?Q?93W2GYlMPaSuWg1Wf1yiQQ6zey4BTBs+71iFCp5eEK59qH0vRbzU4rxHzoW8?=
 =?us-ascii?Q?AqF+gaT0lxZ9/RcT9H2NipZ41Wx6wNyDVSds0a1upLzme5Utu3SqocMFXgKl?=
 =?us-ascii?Q?stbYR+XETniXC/WdPOdBRv3X37guQxzD29DQz7RONA3edKDQTkorXw3UD0bK?=
 =?us-ascii?Q?n+/28fPpnPBd+JO7aXhgNOaHbRLeQvFZTK8htIn8Bx2D+IBdiarhdVGMQEae?=
 =?us-ascii?Q?2+bFp8cEFQr86yvyGyfD2BMJkXm7TrFlDFhb34qTl49RBqdrwQ/jMGl+deGC?=
 =?us-ascii?Q?U/7oo7CgoKw3hyORY1mn0GcVyS4fbLVPbnOCDxkRTEeIn874FDwEVfVmEBRH?=
 =?us-ascii?Q?4vTZtJ9wewVy3ukpuYSks3XS/C7dawHY1PdAV1zndb5iifgttNiwpfQ7f4yM?=
 =?us-ascii?Q?iaH4qaxHjMW81MFsYtJ7Mh8ct2UU8P7ld/4bsQBfJRXWMeE2Oq6wcrZFOsce?=
 =?us-ascii?Q?VLGFvWIKWH70lBrdc27NACtfp2nWP+GfW/HeknmXNYQhDdUCLnd2mPGcH3fP?=
 =?us-ascii?Q?E8OWwUEShDsMpKa0bOw30+qyZNHdTA7TBG1Xq1oBKaH/z1dK+PaydMFbe0mp?=
 =?us-ascii?Q?zRzODg2fb40AIeImY1RgobIQa1cB3MtRV8t5lkzTDIMxe/MPIwmlV0H5WC4/?=
 =?us-ascii?Q?+mnDbFjsEqokiglUP4Z8Icw6PGvtuNdOw1tAgGoqMP0zFHnHa7idtZwDV5hE?=
 =?us-ascii?Q?sWs7+6by/R042ByCNp0MtMDsaJ2UUlazaekN9VxPs0JVIKNOZ3cpcenoMDcB?=
 =?us-ascii?Q?d8m+heRl1qmtm0XkVdh5km+vQ7qwWLHu8OYvWlve0r7vzDfOqXjqp6rY8j3N?=
 =?us-ascii?Q?z/krpCemEWoiXf8tK0trte+6EMmEVCXktdlAn3fYGNOiae59LWLIVkz6I3wN?=
 =?us-ascii?Q?l5OgbmyPe4X8gAzFjSLdEpRgIVWu/puZCm6p2lsaKWLE3kxhGQv74RqM7kUk?=
 =?us-ascii?Q?aykpp9gSJ7kfii5Ldpcn76Ovn4lXaxCLP2GB2qYhHSvxC07B8WRjYH6qVfJu?=
 =?us-ascii?Q?He4O5Kh+RLsHIyok8/o9zVc+S2t35ukK2PS67jz1wthoXJhl2e8Nhr3VjpXg?=
 =?us-ascii?Q?v+HipfGFeYft4Qq8bOpTK1K6BPyueXOR1npgkL5MnAEHaPcMskTfLZPNSRYD?=
 =?us-ascii?Q?yc0ZttIf6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0aqw1+ClSNVluDMufCW3RMhASYXYwJ/0t/3KSmVLab1OuvldIpj5WhLtKRWz0Rb9tFPyIZ9Cfp0/HP0CtbGUfynhmtKsxJi1msa7H6+Ubj2fiM9Mm/hUmg8R5VdRVwrNCK1CZLf5lPxoPrp+PumnfX7o6jHPgQ8Sz7zpO6fjN0kSaY27vTqj+MHtO4GlGqBLePdcBdJKR/7svO0zb/qBK0gYuj0drckrsFM9ghzZlqKqeU5lI9V58ipnW9EzW08Cs7iKFqGVYy8HOiw1MdxG7U6ZB87/pusOhURHmxUPcNenkBYescNZaqFAwOfxYdAjFi5wouAAF+9Zb2QD13AiJUTN+p4vMp12TYQY5e/LPDenPiJc82T9uGq8sgcBrvLrbiFsjUtUJ5P3Zvsx9nFqcLfhLbC2ZB8H3b2Kgkh7Q61jO1YFINlEBPGpKYAw01QM04RQD/JYgC/fE37Zuy/OAa3HjHNaGaYGQ+i6SI6mWBxqduyD5ilrlHjx5Xt5R1Jkabh9Ka+PjrDUCFmuDvzn1UztNsbaO/wIH8SsrU8kSYAAkydpXF3BIZULqDkQH6kCFot+RqqkEXXppXTWwEWg2v6voSFz7M+MFIBfjESBJvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ebc1e4-6ac7-40cb-b99f-08de414a8d0a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:09:18.4075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /x84UC6UQd5fiGMuPozLalXj38cPHV9JOEoq4kN4YtAIicFsdFfbJUZH/R7mREQHF1TRfEfsI3FR+BAhruwqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMSBTYWx0ZWRfX0iqBalxmOBg1
 szmZ1bP9EtQMTJr6mdnUkrict3LRCLOZ/pcDRF/GHIaDxF27ssDDEDifGsYysvMFxOx0rZ1ACoZ
 qijuttY/wzv3TCOOHPnwhzPFJXHssGOst/VC5rHplWzMXvCM3aK/1l9DHIL5KWEypFsR7Jj+T4n
 xYvcJmjCUEdfotSq/tJ19uqXOLeVE0e9BB/D6mY5aerI72GB3SzAAxNyEJq3cRpP5+V2DDE6aMz
 ZK6iEhWuT+DWYi40WRYsF8qR+Ya3uMVOa+cdhy6mw1IqrUwDTTrK3HnUjdNpQZQaO3Qludl4hXw
 2oaSp+5w/R4GWmw6c80771mnrO8+1F3+NzBzcSUcWHPG9GS9SorORzY5gmDzZfQKwWd02scNCDu
 CcH8Xm2/ylsKGX5OcCGZPaVP9yQVUjsMqoLh2nJ3hFkVuOqGSnWffrP9B0aXCNj0YIoluRBIWu1
 YRYwqR+TVnLve2DUf9A==
X-Proofpoint-GUID: qBYy2Dp2gugU2FJ1lDv8HVwjUwttlpaz
X-Proofpoint-ORIG-GUID: qBYy2Dp2gugU2FJ1lDv8HVwjUwttlpaz
X-Authority-Analysis: v=2.4 cv=DMeCIiNb c=1 sm=1 tr=0 ts=694926e2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=4y3Wp0Wu7Q92bxCIkH4A:9

In the near future, slabobj_ext may reside outside the allocated slab
object range within a slab, which could be reported as an out-of-bounds
access by KASAN.

As suggested by Andrey Konovalov [1], explicitly disable KASAN and KMSAN
checks when accessing slabobj_ext within slab allocator, memory profiling,
and memory cgroup code. While an alternative approach could be to unpoison
slabobj_ext, out-of-bounds accesses outside the slab allocator are
generally more common.

Move metadata_access_enable()/disable() helpers to mm/slab.h so that
it can be used outside mm/slub.c. However, as suggested by Suren
Baghdasaryan [2], instead of calling them directly from mm code (which is
more prone to errors), change users to access slabobj_ext via get/put
APIs:

  - Users should call get_slab_obj_exts() to access slabobj_metadata.
    From now on, accessing it outside the section covered by
    get_slab_obj_exts() ~ put_slab_obj_exts() is illegal.
    This ensures that accesses to slabobj_ext metadata won't be reported
    as access violations.

  - If get_slab_obj_exts() returns zero, the caller should not call
    put_slab_obj_exts(). Otherwise it must be paired with
    put_slab_obj_exts().

Call kasan_reset_tag() in slab_obj_ext() before returning the address to
prevent SW or HW tag-based KASAN from reporting false positives.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/linux-mm/CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com [1]
Link: https://lore.kernel.org/linux-mm/CAJuCfpG=Lb4WhYuPkSpdNO4Ehtjm1YcEEK0OM=3g9i=LxmpHSQ@mail.gmail.com [2]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/memcontrol.c | 12 +++++++--
 mm/slab.h       | 54 +++++++++++++++++++++++++++++++++++---
 mm/slub.c       | 69 ++++++++++++++++++++++++-------------------------
 3 files changed, 95 insertions(+), 40 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fd9105a953b0..50ca00122571 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2604,10 +2604,16 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	if (!obj_exts)
 		return NULL;
 
+	get_slab_obj_exts(obj_exts);
 	off = obj_to_index(slab->slab_cache, slab, p);
 	obj_ext = slab_obj_ext(slab, obj_exts, off);
-	if (obj_ext->objcg)
-		return obj_cgroup_memcg(obj_ext->objcg);
+	if (obj_ext->objcg) {
+		struct obj_cgroup *objcg = obj_ext->objcg;
+
+		put_slab_obj_exts(obj_exts);
+		return obj_cgroup_memcg(objcg);
+	}
+	put_slab_obj_exts(obj_exts);
 
 	return NULL;
 }
@@ -3219,10 +3225,12 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			return false;
 
 		obj_exts = slab_obj_exts(slab);
+		get_slab_obj_exts(obj_exts);
 		off = obj_to_index(s, slab, p[i]);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
 		obj_cgroup_get(objcg);
 		obj_ext->objcg = objcg;
+		put_slab_obj_exts(obj_exts);
 	}
 
 	return true;
diff --git a/mm/slab.h b/mm/slab.h
index 38967ec663d1..ba67d6059032 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -510,6 +510,24 @@ bool slab_in_kunit_test(void);
 static inline bool slab_in_kunit_test(void) { return false; }
 #endif
 
+/*
+ * slub is about to manipulate internal object metadata.  This memory lies
+ * outside the range of the allocated object, so accessing it would normally
+ * be reported by kasan as a bounds error.  metadata_access_enable() is used
+ * to tell kasan that these accesses are OK.
+ */
+static inline void metadata_access_enable(void)
+{
+	kasan_disable_current();
+	kmsan_disable_current();
+}
+
+static inline void metadata_access_disable(void)
+{
+	kmsan_enable_current();
+	kasan_enable_current();
+}
+
 #ifdef CONFIG_SLAB_OBJ_EXT
 
 /*
@@ -519,8 +537,22 @@ static inline bool slab_in_kunit_test(void) { return false; }
  *
  * Returns the address of the object extension vector associated with the slab,
  * or zero if no such vector has been associated yet.
- * Do not dereference the return value directly; use slab_obj_ext() to access
- * its elements.
+ * Do not dereference the return value directly; use get/put_slab_obj_exts()
+ * pair and slab_obj_ext() to access individual elements.
+ *
+ * Example usage:
+ *
+ * obj_exts = slab_obj_exts(slab);
+ * if (obj_exts) {
+ *         get_slab_obj_exts(obj_exts);
+ *         obj_ext = slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, obj));
+ *         // do something with obj_ext
+ *         put_slab_obj_exts(obj_exts);
+ * }
+ *
+ * Note that the get/put semantics does not involve reference counting.
+ * Instead, it updates kasan/kmsan depth so that accesses to slabobj_ext
+ * won't be reported as access violations.
  */
 static inline unsigned long slab_obj_exts(struct slab *slab)
 {
@@ -539,6 +571,17 @@ static inline unsigned long slab_obj_exts(struct slab *slab)
 	return obj_exts & ~OBJEXTS_FLAGS_MASK;
 }
 
+static inline void get_slab_obj_exts(unsigned long obj_exts)
+{
+	VM_WARN_ON_ONCE(!obj_exts);
+	metadata_access_enable();
+}
+
+static inline void put_slab_obj_exts(unsigned long obj_exts)
+{
+	metadata_access_disable();
+}
+
 #ifdef CONFIG_64BIT
 static inline void slab_set_stride(struct slab *slab, unsigned short stride)
 {
@@ -567,15 +610,20 @@ static inline unsigned short slab_get_stride(struct slab *slab)
  * @index: an index of the object
  *
  * Returns a pointer to the object extension associated with the object.
+ * Must be called within a section covered by get/put_slab_obj_exts().
  */
 static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 					       unsigned long obj_exts,
 					       unsigned int index)
 {
+	struct slabobj_ext *obj_ext;
+
 	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
-	return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
+	obj_ext = (struct slabobj_ext *)(obj_exts +
+					 slab_get_stride(slab) * index);
+	return kasan_reset_tag(obj_ext);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
diff --git a/mm/slub.c b/mm/slub.c
index 8ac60a17d988..39c381cc1b2c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -975,24 +975,6 @@ static slab_flags_t slub_debug;
 static const char *slub_debug_string __ro_after_init;
 static int disable_higher_order_debug;
 
-/*
- * slub is about to manipulate internal object metadata.  This memory lies
- * outside the range of the allocated object, so accessing it would normally
- * be reported by kasan as a bounds error.  metadata_access_enable() is used
- * to tell kasan that these accesses are OK.
- */
-static inline void metadata_access_enable(void)
-{
-	kasan_disable_current();
-	kmsan_disable_current();
-}
-
-static inline void metadata_access_disable(void)
-{
-	kmsan_enable_current();
-	kasan_enable_current();
-}
-
 /*
  * Object debugging
  */
@@ -2042,23 +2024,27 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 {
-	unsigned long slab_exts;
 	struct slab *obj_exts_slab;
+	unsigned long slab_exts;
 
 	obj_exts_slab = virt_to_slab(obj_exts);
 	slab_exts = slab_obj_exts(obj_exts_slab);
 	if (slab_exts) {
+		get_slab_obj_exts(slab_exts);
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
 		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
 						       slab_exts, offs);
 
-		if (unlikely(is_codetag_empty(ext->ref)))
+		if (unlikely(is_codetag_empty(ext->ref))) {
+			put_slab_obj_exts(slab_exts);
 			return;
+		}
 
 		/* codetag should be NULL here */
 		WARN_ON(ext->ref.ct);
 		set_codetag_empty(&ext->ref);
+		put_slab_obj_exts(slab_exts);
 	}
 }
 
@@ -2228,30 +2214,28 @@ static inline void free_slab_obj_exts(struct slab *slab)
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
-static inline struct slabobj_ext *
-prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
+static inline unsigned long
+prepare_slab_obj_exts_hook(struct kmem_cache *s, struct slab *slab,
+			   gfp_t flags, void *p)
 {
-	struct slab *slab;
-	unsigned long obj_exts;
-
-	slab = virt_to_slab(p);
-	obj_exts = slab_obj_exts(slab);
-	if (!obj_exts &&
+	if (!slab_obj_exts(slab) &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
 		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
 			     __func__, s->name);
-		return NULL;
+		return 0;
 	}
 
-	obj_exts = slab_obj_exts(slab);
-	return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
+	return slab_obj_exts(slab);
 }
 
+
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline void
 __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
+	unsigned long obj_exts;
 	struct slabobj_ext *obj_ext;
+	struct slab *slab;
 
 	if (!object)
 		return;
@@ -2262,16 +2246,23 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	if (flags & __GFP_NO_OBJ_EXT)
 		return;
 
-	obj_ext = prepare_slab_obj_ext_hook(s, flags, object);
+	slab = virt_to_slab(object);
+	obj_exts = prepare_slab_obj_exts_hook(s, slab, flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_ext))
+	if (obj_exts) {
+		unsigned int obj_idx = obj_to_index(s, slab, object);
+
+		get_slab_obj_exts(obj_exts);
+		obj_ext = slab_obj_ext(slab, obj_exts, obj_idx);
 		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
-	else
+		put_slab_obj_exts(obj_exts);
+	} else {
 		alloc_tag_set_inaccurate(current->alloc_tag);
+	}
 }
 
 static inline void
@@ -2297,11 +2288,13 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	if (!obj_exts)
 		return;
 
+	get_slab_obj_exts(obj_exts);
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
 		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
+	put_slab_obj_exts(obj_exts);
 }
 
 static inline void
@@ -2368,7 +2361,9 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 	if (likely(!obj_exts))
 		return;
 
+	get_slab_obj_exts(obj_exts);
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
+	put_slab_obj_exts(obj_exts);
 }
 
 static __fastpath_inline
@@ -2418,10 +2413,14 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 	/* Ignore already charged objects. */
 	obj_exts = slab_obj_exts(slab);
 	if (obj_exts) {
+		get_slab_obj_exts(obj_exts);
 		off = obj_to_index(s, slab, p);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
-		if (unlikely(obj_ext->objcg))
+		if (unlikely(obj_ext->objcg)) {
+			put_slab_obj_exts(obj_exts);
 			return true;
+		}
+		put_slab_obj_exts(obj_exts);
 	}
 
 	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
-- 
2.43.0


