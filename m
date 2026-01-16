Return-Path: <cgroups+bounces-13271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE4D2E14C
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB5163015878
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5B2FFDD8;
	Fri, 16 Jan 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cIRyyDdu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bx3JtzeV"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE928371;
	Fri, 16 Jan 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552466; cv=fail; b=VygSXnYZIB7qIfvYEa4nr3vbQ88aeiXezNMDK4m5Po5fe9jQC7W9P/QZ6ht8gd4nUWOUXl24Ij55PbPEPGUOnB0hqQAsCz0rVaExb+nIl0fwNKKWY7y6qti358BOrZxk49CsRhlGOSoY3knB8KUkL7AZ4JqSlgH3AIslOib3Nr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552466; c=relaxed/simple;
	bh=GZ51emiLAp7QhKJYIuiH3QXL9jc4liXF0EuB33B9Nx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OIMnPd0SkdkwzskmA8KLeIWxaS9nWstInrhffZatC2FCOMeuFJpWpbWycrynP7LnhYikAWdBoWs8oJRznm/45BAxLgqYiaY4/9UHFx8c/9x96DsChWXSbcXpFh4HQZ4nv8/hVqmDARs6IGp5sWevKsRQvQR6PXD5sMkG3qKohGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cIRyyDdu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bx3JtzeV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60G1fdn71971956;
	Fri, 16 Jan 2026 08:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1crnPNlqRx19lL7D6g
	8r3vQ7+sbSKTe9zo0ZRmaOGd4=; b=cIRyyDduaUnp0BCVT+qqa3S1Oekkl5GL4Z
	O3MxZtaqUc9RifJEE29tVZvwOsAXq/6MIbAqtPzlQ4lW9F/Su599dLmEddzGu/tD
	5ZtNj9G7nS+k8eKhrFSMLj3mGG8Fb9EB6DY1Wwi2YmN8zVnMWDM0q7BnxKhcKuhL
	gnvAmEE2oBksQ6VRcpM/v2TpVNsOFjL69yXmt1MP4WBOKL7/i1S+9RAfpj5P66t3
	wCDPxNN4CP4B6CktbbnUyPwFctNHSXWVzr8LbT9h2ww3ZfB0Ul6wrCqtUS900t58
	UXMzFwPRndmxlu+f4C58ciu9hQ6lFo0tYpUpbS/9rNGmWRepX4sQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb9n54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 08:33:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G7UXw2001857;
	Fri, 16 Jan 2026 08:33:47 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7cmhbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 08:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfVY8U9HsNIcFdOb3m5AIsZv9KvxnOT964BHCkBKl0czLMhpYW2ElZK8rjsxZLO5Mi/qzCbmWrspWEqBs48tzsD/BYbGMRWAFAdU57URou6oa+fhWUVJT7mCVhFVw+u2B8ObH9dzyyCmKRqZ9BoYv+jreByan7mxDKJiwyfiJqWnUitVqjmB99UYIqrS5AcnhUtM/3PpNH7IuCW2ULOlp949hpuzDo7Gg+1TOlA+zkeQ/qFAFKQj9ydsCk+msakdCG1QBBoasRiSwv4qLCh1hdro9B8J+0pzfO8pM+jdS4A+DJTSmRgQJa95lgJfiGLXQiB1NVeF3anz6NOIhN0K2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1crnPNlqRx19lL7D6g8r3vQ7+sbSKTe9zo0ZRmaOGd4=;
 b=PMu6AbCxbRYn2ugen3sbPd5lq9mBykif9RoQU0J1Ty2GooQNUHqNxGehbgVVu5z3H/UNqo6gjILLm58j7CJ76G0FGuwpNa7zlHjv1hUzCjWVZd2e8T9HGGRNBeNYdVDjs8/qsFLbBBmUH9NMq/dgBYX6yJmkSfaa9S7SpPH6mvjcFEDPI+eoYwFYlgupuRbakTsx5iWnZpcKwmhRbCWny/5ozY8Lwdnz1Zxvo0To6nFdIPB9mlkfPI3tnIOTbgkSCe689hkR0x6nlhoMZOxfRvD7AXy3yc7PBsCG3UpFRqW2FFQLtWLT/VcssCsu3StN87vBakmOt/dMIPNhpz9Mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1crnPNlqRx19lL7D6g8r3vQ7+sbSKTe9zo0ZRmaOGd4=;
 b=bx3JtzeVvEHm+hnmJ6b0TmvYdjIn9OnhtSuoQyy22rlBAYg6vUirZ8WXMs5y1wvVYwsEI2dFJk5Ej17E/LA/nPecW/QUlZrdQQA5r0fLdOQFZeWIkBuu1p5kvRAHJNeQsTvhac4MoCer9CEYJ1vJjHkP1u8nVvD6LaXqUoSyR34=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH2PR10MB4310.namprd10.prod.outlook.com (2603:10b6:610:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 08:33:42 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 08:33:41 +0000
Date: Fri, 16 Jan 2026 08:33:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
        mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, ziy@nvidia.com,
        harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, hamzamahfooz@linux.microsoft.com,
        apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 00/30] Eliminate Dying Memory Cgroup
Message-ID: <fee37e75-e818-46b0-8494-684ef3eb5cd4@lucifer.local>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
 <0a5af01f-2bb3-4dbe-8d16-f1b56f016dee@lucifer.local>
 <20260115164306.58a9a010de812e7ac649d952@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115164306.58a9a010de812e7ac649d952@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH2PR10MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a3c3f9-55a8-4847-6c92-08de54d9f44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibP+31Pg6bfGy61FCGdL4tGgggIntI0m1gORvu6W5BhiROffPAoGFxsdQFuN?=
 =?us-ascii?Q?NhgXkYLpjNzAAExmA38O3QCqc1ROxHBcSh/CfL0h5aReka329FhOTnJkafxu?=
 =?us-ascii?Q?ulsadOLL5y9xtFxAHEgBpPGBwVPbMf3AoDtNmGXB56dP6Eg8Z6xVugKXh5Jh?=
 =?us-ascii?Q?LBYrrD7gHZ1X4/SXI/D5fnG33O0DrVkZH1a9sonkZfFVm+8Yb9MyEu3dH7ji?=
 =?us-ascii?Q?7RFKuiAOHEViNiHif+BY1f7ZPS50olOU2I5ZYB/dHOc1wC2/hCh4PMqC7ZlY?=
 =?us-ascii?Q?bFh4gWShQwqfJWKh/Elw6tIY2DPNyeeealhzraJtqH6OwppyhAsAEbcBmddS?=
 =?us-ascii?Q?4hGfWIAHFVFkJU/QfHlTJnUwR7Ra7197YKs7N+Brh89cQ6iDa8MTAGTChHoV?=
 =?us-ascii?Q?CymITXJC8l+S1D9LLxkGFTzyzeBRgmyiq9FUGuPJcmXUTZCRjO7S57o7xdwY?=
 =?us-ascii?Q?LX7LQkywIWiREJFTsWf3Hq7M+eoV7l/JuBiP21qrn7zrXTFDK8PP+kulrYwt?=
 =?us-ascii?Q?vFywu9Fgy0KpQDA/TmGq7mwwhDoeE9hk0Gq9w2zyw7Of7zNXEQbQHAZl7u/H?=
 =?us-ascii?Q?rXw180v5PEYYLVdZvncTOHfkkZ5ATMMaVblTAGUwVp5RYPgQLQrNTCy3hr2d?=
 =?us-ascii?Q?nS/xupGRahFmFQTgAet//i12U99N4xuh4t79cZNy3nzYKjoZJnD00qEftFCo?=
 =?us-ascii?Q?T6aX5d6uGMOmE7nBfLIjvRf+kNfX197HDDhGZX/QsNpBcEVw/Sw2JrWvxG11?=
 =?us-ascii?Q?gwUsS17Q8fUyxuUkpsYliVhgNz3pAdsbtdzeQKBRvMG3iA4Ct3Q6pdC9Xwa4?=
 =?us-ascii?Q?h5Lr6kRDmkMVgEGAVMH0dZC7r2/4G7yAbhCqmoEH3zjh3dXeoW5tySb48IKs?=
 =?us-ascii?Q?p1wWrUPSKD9z5ddqf5S1+i99HqULSy5pk1f5zPN/uotl0MtTrYhLoND2XwFM?=
 =?us-ascii?Q?bt3lrRTbT/6N8Zm4IHiQ8DXZCDtrYeNcWNY9o4dn03hMS/L+b0CyVI2vKWtj?=
 =?us-ascii?Q?ydjB6+0Nht5VMiNdF3VEI+70xo9wdYrgtkUfF8g9Bpu3PjcPlt8YUG868CJD?=
 =?us-ascii?Q?ep+VGj/F5EEdtWAJQvjQk+Gjb+DLeKb32O7e48fmZX2AVD2QL0nRgt8eVo8s?=
 =?us-ascii?Q?95PxdL01Y7Zd+V2cXHnJ2dmIwbkfc1U3C4B8YJRAL6WR6zwvMb5b9S3X+kO/?=
 =?us-ascii?Q?SCHVnhFY0GIe8+qOP60J0iSs3u0d8Fx8+vs6AnRpXHPi1KC+O8SuAZ4hShI4?=
 =?us-ascii?Q?XsUr+NoU77Fbo2wWuUC2xsndgZOlYh1CApCCrt2DUzkE/X81WpfcH/+vbKKd?=
 =?us-ascii?Q?bJowEoVqVXraPyjl8CHeHJtcZdhw2WpH4r9LUnHeNmP3XpVEPy9PA2B8Jcu1?=
 =?us-ascii?Q?+nb8Dk8pr6qVWQx76NN5xbUD6T9UdBptjGH/6dS9DTIYRr6CGkjjXMZiEdCU?=
 =?us-ascii?Q?eWS5tc5JMx0Lz4hqGv/Znnyd0G6gKyqVbcFfR4W/+q2R8ySU/i6aLZtFOVJe?=
 =?us-ascii?Q?Q6zMqLsg3XNcU14LUx2ACXB0YOLA2ih+9MKD4E4F6zs37qBpWq1K0PRDRLep?=
 =?us-ascii?Q?2Yb4XC5qd5q4QzFXXLQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCqc++r+pWrXX11GgUB9aizNfiKYXzoFepyXG6RhY0NHJ924w2dIeb1lw5BH?=
 =?us-ascii?Q?xlkstuWOvWXNgiMJnV35y0M0P/HLjw2zrFaH70mtySt/oa7kN7lE1WR33yDA?=
 =?us-ascii?Q?d0c8MMdiZuChyeeLG75Gg6QQa7zPBoJBvJSBxeZLUrgOtgG6PRsdd3p8DiUX?=
 =?us-ascii?Q?1Xsjt0EYQrXNev/QvV6hNVEdJQJsrJ61qiIyh0HWn5v4X6rBtiW15d9krKTP?=
 =?us-ascii?Q?WeFxFQGLut5miWB3x3pfDd+q3aSyCD2Mnm5uZddQt1ekfUg50rXSrC4sDiTc?=
 =?us-ascii?Q?rziAgn8bMzveYMgtEWefO0ElmtLHc2t0BEfpZ1UZEwBk4arqRKNcUoS0QUp7?=
 =?us-ascii?Q?x7PXLaHXqYjddxxSua5XcGNPqvwidQ9/seTuymSkOd9ktGZ0dH2ZOnsi92E9?=
 =?us-ascii?Q?7gzSQE9qOnU2qDlAoQob3wOVubpZaxTJUK2qSsmP9mQBGcp3iqbJhj1CFglB?=
 =?us-ascii?Q?sOGCmX33Mt0efW/5Rm4DWcEf0qGbSqKbBWanIAwBdWoEsmi41siyh+VQSamP?=
 =?us-ascii?Q?gWMz48nCImP81kw080P10NzcFC8qaWWKfLLEozd8bJuQFfz5w6GO59g/LTK7?=
 =?us-ascii?Q?c1jRGBItb2s6K6VQE2Rtuxc6aCUs8C2wJB24iO/6iODAC+Rzxs6wM3N6GyW2?=
 =?us-ascii?Q?aiJkZ6VCy4nshDG3q2fBGlUtMzP/dgkI1A0FxXKGPr6Rj3/aU+shAAxSluxx?=
 =?us-ascii?Q?yvkC9K8K9J9E4bEJpXKgZQ0Sl5LN7akwWZAxqWd+0eSYjaXoABuTascijqUV?=
 =?us-ascii?Q?4aDKY6VZJfLcsSABGWo5jJa+Zubn4Ym2fKj4sHHORzx0NsTMcKZxklnIqCTz?=
 =?us-ascii?Q?U7XWICX1vzLe5UA9uJ18Y9/DKZBOrsXMSW0Rh/QV7k5mmcDTPZGGOl1fqJjB?=
 =?us-ascii?Q?EmSvUdzW/+NEOawvIHT+ls9rEiGwYSIUDGpB80sKk6LJlu56jUWIyCWrua8M?=
 =?us-ascii?Q?UYuZPqhEffaocuqWZFFbZGNjrsugS5f6LCc+BH8ZSqrJXciMukFafwNVrV3O?=
 =?us-ascii?Q?C7IlJfKhrVGdlbo2YpveFTzEMXKUCQJxZ/H+KwswUoBOavWtGaK7Ev/jSukN?=
 =?us-ascii?Q?b5z74AZysn6+TqxjN9frJNeV9ML2C5Q/5RzTaql8m+IWDR/+u/ElJjXW25Vw?=
 =?us-ascii?Q?pGesIoxUdgAaeeBjfoAftC2PbOkQTeUnZWo5c/CIQG1JISx+Y+lW9DKFJP7M?=
 =?us-ascii?Q?PZyBYtlQo+M9ihesB5OuK3KWOtM5FrOMgA0ZPp6iAfVpFCJWd1cl8OiQGnue?=
 =?us-ascii?Q?wgsfXIELZMNFejLn7M1WO2D8SqlQtLaqZ3gaMNYgvLh92TPmKgtu8dXrLP85?=
 =?us-ascii?Q?RbRhudZxTRrDQk4dmlcfzYOmAzHnev7M20k0SEajog98I1V+V2GHkmz1RdVH?=
 =?us-ascii?Q?8LES1QVoSsODgAoaVTiJIrC/w274yfVnEDuHZShYtCzuXQSdY3VN+JxZ9OWr?=
 =?us-ascii?Q?UFJlfljmXukxYlI8VJ7Wf859HngN2sqP9CxxobVUFBwvo6GhTkjSXFVppajL?=
 =?us-ascii?Q?9dKj2vxDq0/zzVX6hHHmu59d4sScHB1O2ZR/3+BHNpxbxULrXJAkHM1tVlgK?=
 =?us-ascii?Q?B9645DpK2vTcLR6XrWqwHcirEYscM6r4+TfkAlgYiAwogU+ECUz+dXCrL7Jd?=
 =?us-ascii?Q?9ubY7xBn8O+UxgVIM1NO8+lAeXt8XEeuIGXcTqJ09frt5/AkMYz5ia7nA/6V?=
 =?us-ascii?Q?SZzash7X4us+T9xiJHTNfTbDyowVm8mxg0DO08Qiil2qcyhg0KNJMydTgj9j?=
 =?us-ascii?Q?ZgvxBzQGNvoEL3Z19O+d4W+iDbGaWN4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MsL1DUQNj5Zxxpqx9I3Dg1/ZUCnSswh4GKY31gtVGpT4Ecv+GkwvsEH/XF4+tULHLIonuxQUWwmZspl6nCbYRBe254JrPuaP8KSX4F3EB15e9dB4gKyXXDGVe+QOJfeUSR+q7/ZGJpjmmHLKY/V94oWwQ4Kkwt67VG2o01TD7fjLZav3OxQtR2gBtFiYNIjimAOq/fJFWpaiBxqOtGpoD3YGAovI4dLlQwscO1wCNhCBi5rCXhhzhBOAkwqJYOXuz5G3Ih7f4WyzfD4rD9TQrgIJwsKZkznvvqDg6BigZq3Lmnae9oV2c2KEVhTSap3fUmqKIohyQXCk/L04/iKsCDYuqV0npaCUsOFb+YFQMm5J6GvKBTy/vJCiOTJ2e5uWLaGAPJtgURx4XIVHVuCjJ0YVYt/TdlzCsH3j8Jdl01+BorR+jOw/27Mi70rXkWkRlOKZjgiVd/GwXuHTCoua6YFN1gxQFeFLo6nCyYC1GaXR78NQzSO09YfSijerGYZgQY6mhwZFxwkGfMgtQdVQ8+CrTjZiYY57EGSgxGqsdV+vf8LboyxQkV5Tz1QEFSOK94cwJRDX5j+c8VSIIrdNGgBSkw1UBafYrXUYQEygi/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a3c3f9-55a8-4847-6c92-08de54d9f44d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:33:41.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTjWKHDoRZRGNKHSk2gFZpV1N32YGwK/2hYPb5mZTknvDt8TdUP7yrrRMeCmjqgs7Q38g4JlQV+SMtMLvfGInyR0zyjseibHiX/LsUPpjAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160061
X-Proofpoint-GUID: Qu0Bc0uhHoNlpA9iqTVYHFoxPYpXfhhz
X-Proofpoint-ORIG-GUID: Qu0Bc0uhHoNlpA9iqTVYHFoxPYpXfhhz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA2MSBTYWx0ZWRfX2pV4g4DWznJR
 MZe8QXNNvAFUzPeY6lGYLCi5CvDAGCXAYhugEki/qusvFweyov/Wd7JRcN0+g6k/g4ZfT10XM9f
 hDkes67le+DjwWB5+wpSLzxtVehreQhRTY7gpPvNJIEolB5DRoUyPuXbOgozGQBj/P1PqZWVtkr
 Ok3z1mn8FaiomaJwm2aeuW0qwVFQZDPaXu2mv7okJQBmUawq9uhSL4Gx+EWMDioZRaDrV7O4b+F
 zHCSXMXXJhv4fBZhWvJ954E0wKpDXqqkKBZ7VOYCaEacOUsUwRUWeG79l9zdHcVlXdgS0p36Lq5
 TOAG+zcVQMmiirSokKoQNhcPt4yhiEvQbbQ6DZSXJJjdmsFPQ5zCHTQkv9oUki5RZbSaV+9gj+I
 5Fht6Nu5p+r8PLmRKiHEH5VpqDMPGzhZBhFGtX/2QW21BCVjbk9y0cMD+Pn6koIbOhYmfGVthhx
 GTlVpogzi4sCt1s7Q0A==
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=6969f7ec cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8 a=40unvB24EiYzUw0pFucA:9
 a=CjuIK1q_8ugA:10 a=ZmIg1sZ3JBWsdXgziEIF:22

On Thu, Jan 15, 2026 at 04:43:06PM -0800, Andrew Morton wrote:
> On Thu, 15 Jan 2026 12:40:12 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Wed, Jan 14, 2026 at 09:58:39AM -0800, Andrew Morton wrote:
> > > On Wed, 14 Jan 2026 19:26:43 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> > >
> > > > This patchset is intended to transfer the LRU pages to the object cgroup
> > > > without holding a reference to the original memory cgroup in order to
> > > > address the issue of the dying memory cgroup.
> > >
> > > Thanks.  I'll add this to mm.git for testing.  A patchset of this
> > > magnitude at -rc5 is a little ambitious, but Linus is giving us an rc8
> > > so let's see.
> > >
> > > I'll suppress the usual added-to-mm email spray.
> >
> > Since this is so large and we are late on in the cycle can I in this case
> > can I explicitly ask for at least 1 sub-M tag on each commit before
> > queueing for Linus please?
>
> Well, kinda.
>
> fs/buffer.c
> fs/fs-writeback.c
> include/linux/memcontrol.h
> include/linux/mm_inline.h
> include/linux/mmzone.h
> include/linux/swap.h
> include/trace/events/writeback.h
> mm/compaction.c
> mm/huge_memory.c
> mm/memcontrol.c
> mm/memcontrol-v1.c
> mm/memcontrol-v1.h
> mm/migrate.c
> mm/mlock.c
> mm/page_io.c
> mm/percpu.c
> mm/shrinker.c
> mm/swap.c
> mm/vmscan.c
> mm/workingset.c
> mm/zswap.c
>
> That's a lot of reviewers to round up!  And there are far worse cases -
> MM patchsets are often splattered elsewhere.  We can't have MM
> patchsets getting stalled because some video driver developer is on
> leave or got laid off.  Not suggesting that you were really suggesting
> that!

Yeah, obviously judgment needs to be applied in these situations - an 'M'
implies community trusts sensible decisions, so since this is really about
the cgroup behaviour, I'd say simply requiring at least 1 M per-patch from
any of:

M:	Johannes Weiner <hannes@cmpxchg.org>
M:	Michal Hocko <mhocko@kernel.org>
M:	Roman Gushchin <roman.gushchin@linux.dev>
M:	Shakeel Butt <shakeel.butt@linux.dev>

Suffices.

I am obviously not suggesting that we require sign off from _all_ sub-M's
for _all_ affected files, and then some changes may be blurry.

For the most part I think it's usually _fairly_ obvious which part of
MAINTAINERS applies, and in cases where it doesn't obviously people can be
pinged for opinions.

>
> As this is officially a memcg patch, I'd be looking to memcg
> maintainers for guidance while viewing acks from others as
> nice-to-have, rather than must-have.

Yeah agreed.

>
> > We are seeing kernel bot reports here so let's obviously stabilise this for
> > a while also.
>
> Yeah, I'm not feeling optimistic about getting all this into the next
> merge window.  But just one day in mm-new led to David's secret ci-bot
> discovering a missed rcu_unlock due to a cross-tree integration thing.

Yeah and that's not a big deal, things can wait a little while esp. the
bigger changes!

Stabilising it is more important :)

>
> I'll keep the series around for at least a few days, see how things
> progress.
>

Sounds sensible!

Cheers, Lorenzo

