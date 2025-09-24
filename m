Return-Path: <cgroups+bounces-10433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77CB9A6FE
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B583A432B
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA0530DD04;
	Wed, 24 Sep 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qf4rb90n"
X-Original-To: cgroups@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755D30CD9E;
	Wed, 24 Sep 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725839; cv=fail; b=txu5DMap88zGIvDEF8xGkd2XhwMQkhtqnS65jmqbrpwZdmWcg3mW5HCOo6dSn3CSGYo3YnNqc7UMt6tFtSvrkbvbdPMgha8NVQ9CRru2gcuDno+g/Q5q+S8R6RU70Ypf0jfFI+N2CMaB7LvFIALddbYQoP6czlvDduCtNSeu1kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725839; c=relaxed/simple;
	bh=WkfEaHr1mROIonCqP0Uv91TY6PVIKLvgUzHpAu/AoiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzTScq51hYvv0BO5lyA2s6EAhntTYPFRkSQ3bKhDFQqiCysX5Deyior5hK6moDDFOBKUPSSkUg5kI1n3BENn/SG2pZp8AKk9OEVusa6dewm0lkZlHJjWjpj1coiRHZEyltaswl+kvarbLUE94cTfuDtjpCMqqR5MoU/djLBtgck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qf4rb90n; arc=fail smtp.client-ip=52.101.46.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7Vv7SyrGi3kTOydwsbicFOoI4X5XvDeiwteyFCSfGAuzVNo6/cKrIPP13/eWxMkqUNYYFVgO+lGBEIRT59O4C470/nrOg+APu4IL21HA/qzGM3A1fJJhRtCC+GLCRn8hWRYJaPTut5rJysXb+8kZpluGqawlgN61gYpuzbUacm4d8iK64baPQPfDvDOH/d2Z8kN/VI35YwWFgatfdFeZFd/yPAuHwiVtOkaelAH6oV6RIAnIOast7l7fvRhrdKj4YU+FlaaK1ms2R10VI6jzPYoDDnAtlMXkOAqtsw9VrqX1XyeNUVGVQE524nXB1+Jfi0IwlNyR6S7XT0MrTGpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vtDmIog7ON06F4ZloSdkgCzhdVv9Y5MaEaDSA+kcUQ=;
 b=e5JbiowvDsCh/T5FyEknW7mb25Uu1l1Zn6OVfHceC+Ov3KIO7uCoqviyvMrWG10PchQFzz2fHqc6JgMk0MwKW2rhJ34mi5jk3pfjj+DNG4ikuJERZdmK5LerpgLCQxp/gIldz8nGFF7wym/1Q2sI0PHqN+pRbvKDAX+jyVfNCNXBPLhSYTQPaJ9DQvxnqk9dRyZbkFtx18PqT89GaP6AR1Cwn+FpvkN1i/DeMxetOCrmGeihv8QI1EeW4YOiBi4gViNIGAvfXj6llsOHQqm0TYY1xY7kZFDxS99G/ivjC9tR2QZoVMRSUthatBZnko1pwok1pCKWsxKTXQFJFqbjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vtDmIog7ON06F4ZloSdkgCzhdVv9Y5MaEaDSA+kcUQ=;
 b=qf4rb90ne8kz5ZI3fRVGa4oYQpQxu4AyS015gTudNvNGh/VA0kJQ1O9wuJQb+jwUpoFS0ci1Nzm11v20BG1bVDKyXHbsWfZlIFp/XweiUP5KndusVAJlgGNbKHzozf4ItBgWEEtgNdQVRX87GM8e5mLmVYRj51sgl0j6MnmuVeXxxmnjThijvtcgwe+7VhLHzQ/cGP0p1Ws7XFNR3dIjcn+xidF7Qxz407P4icFwTqwGUFziMOTPOFVjUJjUAGHMUgQ/e6fw12TUKAqdRH2VbksEfuib1GDJPhwXXqAvNbktYEV75MUUmTnwL9gGxip8rOXBcKAdOlZFhsb/1n95zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:57:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 14:57:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
Date: Wed, 24 Sep 2025 10:57:07 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <143FB0EF-187A-4A4D-9447-C2F681A62B98@nvidia.com>
In-Reply-To: <7d0bf9a8-7890-4002-9e02-5f7884ab0bca@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <782da2d3eca63d9bf152c58c6733c4e16b06b740.1758618527.git.zhengqi.arch@bytedance.com>
 <A64EA303-74CD-4CF9-B892-C0FF9699F3FF@nvidia.com>
 <7d0bf9a8-7890-4002-9e02-5f7884ab0bca@bytedance.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0956.namprd03.prod.outlook.com
 (2603:10b6:408:108::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: b80e6c47-298a-4680-8b20-08ddfb7aa39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aBIToMvo1XL1P+bDpTfzi1lBT7nQ0nPMyijhJAyCkAD3JfTPRAzhOMEKa+Y+?=
 =?us-ascii?Q?CuzHHlKLSXmRnAhxgs+LIyu8tkGbqmkgisqyHkEbdFEywK5PU0AAw2/26O+b?=
 =?us-ascii?Q?ljurSlT8qIuVB7bUPU8cpfzbDS9vj7N0+bGpJVgrwSRKZPq/e/BuTRcbHg8e?=
 =?us-ascii?Q?YNR0GM8j7sgHfdbo+Rh30vSn91eGzd187J3pcL4oP8inn419sk7mpqXgBLwh?=
 =?us-ascii?Q?gcJn2So+2kCmcAOI1RqANSRjXZPiDXbWEtxaxVjy7OdXWWWzJS2d+owRkvzC?=
 =?us-ascii?Q?ky4jugSxi6EHIxk4tbQpr+mOIo/9eHI4H1iTPNlmvkEgwr/S1tLSoPIPSqcg?=
 =?us-ascii?Q?juL0o1EaCEYkNkvk7zqAk1fUk7H7enOvsOtBYMQDzinDpmzDHE/VIi3lHx70?=
 =?us-ascii?Q?gtvBxG+A50fEC8EM26MV/hNhyIMBuKkx3gQkb/BGL6cSuoNMlaZcc4XUGUJs?=
 =?us-ascii?Q?XvhmKf+Ta5ugludgcw3fguX21zkuSMSaBW8GzYnO0dCvn5EUhBSY4Fr1BOKt?=
 =?us-ascii?Q?BT9rqH+DR/cBDMwcaGWtAsCTSgzY3nPxS+LOZejAC8hSddES0Vtl3uoikfVB?=
 =?us-ascii?Q?UFXMyKTQRbSx1EggnP3CsZ1oTNwhv1v7++QbnmfKYu7/Rb+nC5LnMDsZKbOu?=
 =?us-ascii?Q?fysY+Icac9kS76JVTJzTAUwj+yVYecjVpvEQq/dtwYPqktyXw1YKXZ1XLGYh?=
 =?us-ascii?Q?omwYEnJqYp+ldAzvUxINyanQGFVfgIX222LnvxYuXBj0bPqigAKF5NJHtEjF?=
 =?us-ascii?Q?n+4OpgxayhzxkVtQsXBESY3T+/TiS/Uqv9njs9IF1Lfx7tOAFo96bo0tHK18?=
 =?us-ascii?Q?UP5W5hLFAnZCYb8NjxlILsPipC4CWRGVSkP+AFE+XMmU41kWkO2Y+c2ynlrO?=
 =?us-ascii?Q?0pumHaFKuLSV1sMlR/DHM/fQVoAigPKHBdwI74QIR4L71fn1eyDOQ7vLD1s+?=
 =?us-ascii?Q?iSoEgC6vGJNufIBszkevDzpuXTBvLSNUnfT2uut4f3cTCrwlH/gBnaxRJGi3?=
 =?us-ascii?Q?BmBTPrgP40MCKt0BiLJSmSJQX3D+SFyoAC0Wt9thMp5NluwdCw3uNpEgqilA?=
 =?us-ascii?Q?wzvyPTozBPpevDX8t0BzUAY7IhdoE0aD+o55gBXrqUZ4NIgzE6Wp4PD/I6iu?=
 =?us-ascii?Q?4YC3mkHzu31jCC/iuz28I7qPj+izYmmCPnYpuZXDhaAtaaWi2J4vU25nghDJ?=
 =?us-ascii?Q?YAR7GZpZIogClm2BL8G9/MVMpZj+AWigRAxN9BkucJi36z/Ab//iexW9lI4Y?=
 =?us-ascii?Q?zVs9KXerYdLrYqIC5BioU7UOnPt5BV1UnDPXumGwmIukp32DLKmRmekcg1tL?=
 =?us-ascii?Q?u3Wkernj7CWo89XoMDo+oVpxezmC0PYhmk0TtxYL36CgoW+d6Pdyo/+Sok6V?=
 =?us-ascii?Q?KsYdgMsiIh4mKypXFNnDTbVOZIT5mf+oEExdUMAf1aV1fUZl+3AHHi8lUz5p?=
 =?us-ascii?Q?GNEh36NaoW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43DwrD/vjyd1EzYef++lLSODw5ZHYfXhtBL6hvvMQBp6jNTLCljSNVEZQL1E?=
 =?us-ascii?Q?f6PteSPGVG6igllsPQXEgK2ibFUPUS3+9FJ4tKw3nHH8BDVCighjOoGxm7Xy?=
 =?us-ascii?Q?pRHbpWF3e6c62phxN2m1821BporBB4IaM0ecObZ57fs5R81z9nMo3bLYQBTm?=
 =?us-ascii?Q?gK8F57kyxPEuuE5cLj4ipAJg5vn/AguxAKMOfKxleNql9vof0bGviqy94FOS?=
 =?us-ascii?Q?e5jAGx6puVGAED79X45gRiCDY1g7QTnPCqY8Vbrp4se43zsycQK7w9jsC0iB?=
 =?us-ascii?Q?kmTVwne7ZYJAG2YfAL43uwg3APVE1t717JkzLrpY2Ska99HhikDAs6+6Z5MZ?=
 =?us-ascii?Q?T7Lugp41GRK/iCFhaLgwgxCSTUFJOOIk2ug9dWgH+rYOZrpgM9h3F3SeBFkG?=
 =?us-ascii?Q?FqdrLHcNTR3HrOqPjAKZoNP3n8ojCHuP9rehO1AWQJ57s3AF79jBRLJOYwji?=
 =?us-ascii?Q?iMCJdX/YbpVOrWICcjr2iUaQ83xzLoLnolEZjJbfGf2dyyy6OdzA2RQlHt8U?=
 =?us-ascii?Q?BZ7StuEoq5LND67muip5pLbz34KvDgdXGY8J59sesP7MBMWSJaKWWBR+RQhf?=
 =?us-ascii?Q?Fjj/ATDlg40xChSfBxn7a+Y60pXCA/jhG8f+2carbzMJZkPo8ggZSJkii7RC?=
 =?us-ascii?Q?uHdvpy+BK/27W/x5kz7fID4YsGd6q+zsYP1MM3rRrmL8QWnhskL9I3NaBvXh?=
 =?us-ascii?Q?VZ0ZpWIR+a7/pV1CfYG7ZVV5Bns2PPnigzJ9TxUHapxVnwYwfzXxuiK12DWQ?=
 =?us-ascii?Q?lkre36+4o7RsTTOAKYKkV804nC3B6u7EQQNsNFiK5emE6Xf99HQdVB82A/L6?=
 =?us-ascii?Q?7wmgbIkZick7eu+glY5pHjvCAlsuNR7avDpTgyhUjjhiz867HxjIAo9zF5nm?=
 =?us-ascii?Q?IJ1d/J3hPB+dGFSBcuXHkQAzgNPX0T6Ju42AERMGyiD1YZKwKsHS3WiVqFaR?=
 =?us-ascii?Q?X5kEo47+T9A2Bag+BpkXmJqfUgofxZxFrIow32432Pi1F6FD+fg8Cg13EUmR?=
 =?us-ascii?Q?J5H5WJ7k5IjHGHCZSYrewrrkKOQy+llyLXMidyl/6apU5nUnyB8HW6xeAFBA?=
 =?us-ascii?Q?WkHr9DjXClcFtqoVFYw96iIr1mv4HEkt8DsLnhLpV0n7tb9sFAd1YojgnjSe?=
 =?us-ascii?Q?9Vi8Kgzrve0Zt9rB34EWGuwuAFzh+r2oVDNbEMXAnNLRlGUsHyVFC/iORRPg?=
 =?us-ascii?Q?LL745hBMjZiT2vsDKvdsOHxpOD61Wl2GcqCy+LuNxTJgahexoLg6zZYZvgRI?=
 =?us-ascii?Q?vHHHtU5bYDegJKpxpqb5j20U+j9+2ZbsG2RB1Jm4hR7jHxiypecBRVrB8t4Y?=
 =?us-ascii?Q?UuPuxvXcTtqAkF2MVg7SzsbhrTlDVb02wgii6t8gkWg5Wkx5gT46TAHZVisi?=
 =?us-ascii?Q?ih0SolOnlfV53BfP/6hGdXRZnj2WXdl6IE5OHMauWbjvLXxwfiRNoO3h1jEL?=
 =?us-ascii?Q?9E5Fr70hIEaLzUEpsHQcsFNzoJW2Jq2jCqaJveABPv7aEqQ4/7ScrJ6e5fYO?=
 =?us-ascii?Q?+zp+GDimOFcUeATiJEcwKfIuaV2ooATDiTk2BSSHkIgI+TaBT6004yNES8Uc?=
 =?us-ascii?Q?Nt/xeg8CSPtmsKm9bdUy4TBdzSFRMdpCiY4aVAF7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80e6c47-298a-4680-8b20-08ddfb7aa39d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:57:10.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCguTa+dvAjWA5ym2KvwGUmx1XEEb/WquYoy8Sp21F9SMZtriAydUiQSKcDJSbvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876

On 24 Sep 2025, at 5:57, Qi Zheng wrote:

> Hi Zi,
>
> On 9/23/25 11:31 PM, Zi Yan wrote:
>> On 23 Sep 2025, at 5:16, Qi Zheng wrote:
>>
>>> From: Muchun Song <songmuchun@bytedance.com>
>>>
>>> The maintenance of the folio->_deferred_list is intricate because it'=
s
>>> reused in a local list.
>>>
>>> Here are some peculiarities:
>>>
>>>     1) When a folio is removed from its split queue and added to a lo=
cal
>>>        on-stack list in deferred_split_scan(), the ->split_queue_len =
isn't
>>>        updated, leading to an inconsistency between it and the actual=

>>>        number of folios in the split queue.
>>>
>>>     2) When the folio is split via split_folio() later, it's removed =
from
>>>        the local list while holding the split queue lock. At this tim=
e,
>>>        this lock protects the local list, not the split queue.
>>>
>>>     3) To handle the race condition with a third-party freeing or mig=
rating
>>>        the preceding folio, we must ensure there's always one safe (w=
ith
>>>        raised refcount) folio before by delaying its folio_put(). Mor=
e
>>>        details can be found in commit e66f3185fa04 ("mm/thp: fix defe=
rred
>>>        split queue not partially_mapped"). It's rather tricky.
>>>
>>> We can use the folio_batch infrastructure to handle this clearly. In =
this
>>
>> Can you add more details on how folio_batch handles the above three co=
ncerns
>> in the original code? That would guide me what to look for during code=
 review.
>
> Sure.
>
> For 1), after adding folio to folio_batch, we immediatelly decrement th=
e
> ds_queue->split_queue_len, so there are no more inconsistencies.
>
> For 2), after adding folio to folio_batch, we will see list_empty() in
> __folio_split(), so there is no longer a situation where
> split_queue_lock protects the local list.
>
> For 3), after adding folio to folio_batch, we call folios_put() at the
> end to decrement the refcount of folios, which looks more natural.
>
>>
>>> case, ->split_queue_len will be consistent with the real number of fo=
lios
>>> in the split queue. If list_empty(&folio->_deferred_list) returns fal=
se,
>>> it's clear the folio must be in its split queue (not in a local list
>>> anymore).
>>>
>>> In the future, we will reparent LRU folios during memcg offline to
>>> eliminate dying memory cgroups, which requires reparenting the split =
queue
>>> to its parent first. So this patch prepares for using
>>> folio_split_queue_lock_irqsave() as the memcg may change then.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>   mm/huge_memory.c | 84 ++++++++++++++++++++++-----------------------=
---
>>>   1 file changed, 38 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2f41b8f0d4871..48b51e6230a67 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3781,21 +3781,22 @@ static int __folio_split(struct folio *folio,=
 unsigned int new_order,
>>>   		struct lruvec *lruvec;
>>>   		int expected_refs;
>>>
>>> -		if (folio_order(folio) > 1 &&
>>> -		    !list_empty(&folio->_deferred_list)) {
>>> -			ds_queue->split_queue_len--;
>>> +		if (folio_order(folio) > 1) {
>>> +			if (!list_empty(&folio->_deferred_list)) {
>>> +				ds_queue->split_queue_len--;
>>> +				/*
>>> +				 * Reinitialize page_deferred_list after removing the
>>> +				 * page from the split_queue, otherwise a subsequent
>>> +				 * split will see list corruption when checking the
>>> +				 * page_deferred_list.
>>> +				 */
>>> +				list_del_init(&folio->_deferred_list);
>>> +			}
>>>   			if (folio_test_partially_mapped(folio)) {
>>>   				folio_clear_partially_mapped(folio);
>>>   				mod_mthp_stat(folio_order(folio),
>>>   					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>>   			}
>>
>> folio_test_partially_mapped() is done regardless the folio is on _defe=
rred_list
>> or not, is it because the folio can be on a folio batch and its _defer=
red_list
>> is empty?
>
> Yes.
>
>>
>>> -			/*
>>> -			 * Reinitialize page_deferred_list after removing the
>>> -			 * page from the split_queue, otherwise a subsequent
>>> -			 * split will see list corruption when checking the
>>> -			 * page_deferred_list.
>>> -			 */
>>> -			list_del_init(&folio->_deferred_list);
>>>   		}
>>>   		split_queue_unlock(ds_queue);
>>>   		if (mapping) {
>>> @@ -4194,40 +4195,44 @@ static unsigned long deferred_split_scan(stru=
ct shrinker *shrink,
>>>   	struct pglist_data *pgdata =3D NODE_DATA(sc->nid);
>>>   	struct deferred_split *ds_queue =3D &pgdata->deferred_split_queue;=

>>>   	unsigned long flags;
>>> -	LIST_HEAD(list);
>>> -	struct folio *folio, *next, *prev =3D NULL;
>>> -	int split =3D 0, removed =3D 0;
>>> +	struct folio *folio, *next;
>>> +	int split =3D 0, i;
>>> +	struct folio_batch fbatch;
>>>
>>>   #ifdef CONFIG_MEMCG
>>>   	if (sc->memcg)
>>>   		ds_queue =3D &sc->memcg->deferred_split_queue;
>>>   #endif
>>>
>>> +	folio_batch_init(&fbatch);
>>> +retry:
>>>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>>   	/* Take pin on all head pages to avoid freeing them under us */
>>>   	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
>>>   							_deferred_list) {
>>>   		if (folio_try_get(folio)) {
>>> -			list_move(&folio->_deferred_list, &list);
>>> -		} else {
>>> +			folio_batch_add(&fbatch, folio);
>>> +		} else if (folio_test_partially_mapped(folio)) {
>>>   			/* We lost race with folio_put() */
>>> -			if (folio_test_partially_mapped(folio)) {
>>> -				folio_clear_partially_mapped(folio);
>>> -				mod_mthp_stat(folio_order(folio),
>>> -					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>> -			}
>>> -			list_del_init(&folio->_deferred_list);
>>> -			ds_queue->split_queue_len--;
>>> +			folio_clear_partially_mapped(folio);
>>> +			mod_mthp_stat(folio_order(folio),
>>> +				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>>   		}
>>> +		list_del_init(&folio->_deferred_list);
>>> +		ds_queue->split_queue_len--;
>>
>> At this point, the folio can be following conditions:
>> 1. deferred_split_scan() gets it,
>> 2. it is freed by folio_put().
>>
>> In both cases, it is removed from deferred_split_queue, right?
>
> Right. For the case 1), we may add folio back to deferred_split_queue.
>
>>
>>>   		if (!--sc->nr_to_scan)
>>>   			break;
>>> +		if (!folio_batch_space(&fbatch))
>>> +			break;
>>>   	}
>>>   	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>>
>>> -	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
>>> +	for (i =3D 0; i < folio_batch_count(&fbatch); i++) {
>>>   		bool did_split =3D false;
>>>   		bool underused =3D false;
>>> +		struct deferred_split *fqueue;
>>>
>>> +		folio =3D fbatch.folios[i];
>>>   		if (!folio_test_partially_mapped(folio)) {
>>>   			/*
>>>   			 * See try_to_map_unused_to_zeropage(): we cannot
>>> @@ -4250,38 +4255,25 @@ static unsigned long deferred_split_scan(stru=
ct shrinker *shrink,
>>>   		}
>>>   		folio_unlock(folio);
>>>   next:
>>> +		if (did_split || !folio_test_partially_mapped(folio))
>>> +			continue;
>>>   		/*
>>> -		 * split_folio() removes folio from list on success.
>>>   		 * Only add back to the queue if folio is partially mapped.
>>>   		 * If thp_underused returns false, or if split_folio fails
>>>   		 * in the case it was underused, then consider it used and
>>>   		 * don't add it back to split_queue.
>>>   		 */
>>> -		if (did_split) {
>>> -			; /* folio already removed from list */
>>> -		} else if (!folio_test_partially_mapped(folio)) {
>>> -			list_del_init(&folio->_deferred_list);
>>> -			removed++;
>>> -		} else {
>>> -			/*
>>> -			 * That unlocked list_del_init() above would be unsafe,
>>> -			 * unless its folio is separated from any earlier folios
>>> -			 * left on the list (which may be concurrently unqueued)
>>> -			 * by one safe folio with refcount still raised.
>>> -			 */
>>> -			swap(folio, prev);
>>> +		fqueue =3D folio_split_queue_lock_irqsave(folio, &flags);
>>> +		if (list_empty(&folio->_deferred_list)) {
>>> +			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
>>> +			fqueue->split_queue_len++;
>>
>> fqueue should be the same as ds_queue, right? Just want to make sure
>> I understand the code.
>
> After patch #4, fqueue may be the deferred_split of parent memcg.
Thank you for the explanation. The changes look good to me.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

