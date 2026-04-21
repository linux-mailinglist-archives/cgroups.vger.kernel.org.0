Return-Path: <cgroups+bounces-15433-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCuJGR9452nf9AEAu9opvQ
	(envelope-from <cgroups+bounces-15433-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 15:14:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC88143B300
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC5E305814B
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7537D11A;
	Tue, 21 Apr 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgi1Jif/"
X-Original-To: cgroups@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5219005E;
	Tue, 21 Apr 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776913; cv=fail; b=CczcO8gJhU4lvjhnEiZ9lMH+VRNi1oKq5mpHFDm9MC2GX9I8d1adayRieQdCClpx6oS9vSme9s3LFsGYytVolhPQKpy3b3gjFloPDtWNJJfMnoIFLvLHJjZb2En8i1R7SJks0p9F3QB5CXO8CC849X6wLxQmat6zdZyzKrnq7D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776913; c=relaxed/simple;
	bh=9F26fdiDCr0yuo9wRvi9X8tH+EH4AUSGYz4K8TaphMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPjzGElmw6Kmn1hllTVypIf+ryGdBvn77gXd/qBp2beVKLMR5GvE7uuveSb6Z+sxMf4XDnqTXaxhEZRNnui4N407G2WA7IKZ6SUP1YrMxZUlIbt6+oDB68Ca87Qd3GseqHYonLWLViPLSIwfExZZdQXQY+GDjieEYCI+kniF8Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgi1Jif/; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xru3YrTsMY9q83b1/hClUhhqw/lSNO4j8PKKOnD/kmT73mFncGw4u/rHAGnhR/w/x7gee+HTUoXAH9Dwfkj6VkEy/T+iND3eag8NuVL6/ZAlHfoZsOrUnf/DsPKccEXNIx7Nz4HExVBT1InXBkUyU5xmtmfbIN7R0yW2hu57piu4V3MhHTNmt368mvYVNifg9g7rEiEukPPR0qRjf1cvPk/WHIycN7gtTGxr6ChXzQO8S8aj2z7DI5D90ThTODJHizCny+FAkV7feXREaa+s830HCc2js7jQwMVdEopkAbf9qWPf2pb4H9k1f55a1qRGUaGUh9WRqPoQOxd9spAaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNN1pFIYlyvpp/bsPpvuUwNaxiXRBobYDgL9X5P/+Bs=;
 b=mBUQoijHuiMeSlPR8/0cbJS0gboQ8lAMs3iIRUEUgux/8+wSxyx7KZ66EbBVXcQXxx0YRUpiLSUtexG4Kvf63n/4Wt7tgapVfD89fjBm4H7OpBvuBdCWggOkL7HkujKsuQ3xR7CFU/6WqKz1CFfcgp9CrvUctFhFTmTiv08gmRCp3rAUh/163u6yIjWpbhu4/xgin95iPelT3xhhpTQeYJWyuExBAMGip3bwxb4yu+TA6Eexs6PA7U5SwQds3uXHeZxq80KihntaOs5HbzL/uINIlMMd7yrkGeW3dc2T+g8fusWvtspLSDJSi51NEkroMqNK+ZpVIvmwP5E8RBG0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNN1pFIYlyvpp/bsPpvuUwNaxiXRBobYDgL9X5P/+Bs=;
 b=cgi1Jif/YUZfBtE86m4Tsctt0lqjYfX6G3Zz6kf3LohyY9THwdtYTP/tkqCiQRiniGbiOaZVp/PH/GemCpEpZDlHGM6xOocz/umQa/RouMZN0IOMTwVT8caDGZhYl4TkHYgzBRO0JWzvSV12wbIkwbiuO/rvl3WQejaGjiBx4nVm0DCfzjOo3CXrBnQ12H4PEgqieKgaRZxu2FYVVG3jKYPuM16k7YJS+DCy/4+3Yqqz/fKgILaCf13dppSW8fayzwILdcvGj+3o4Rsgw2a/DG9KqD4ivAJT7UITjKTTc28yPJA0DyMCPZ08urPZipTtj2ajVvy0cFocXW8zRgrOaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 13:08:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 13:08:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Youngjun Park <youngjun.park@lge.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v3 03/12] mm/huge_memory: move THP gfp limit helper into
 header
Date: Tue, 21 Apr 2026 09:08:21 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <D631DCC9-85F0-4E68-88A0-AD5DE328818E@nvidia.com>
In-Reply-To: <20260421-swap-table-p4-v3-3-2f23759a76bc@tencent.com>
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-3-2f23759a76bc@tencent.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:408:e4::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 53165013-4d08-4167-cb49-08de9fa7123d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x3aqijHv3ZNJpZXH+nfKDta1BCu236iEb6UDXeC7oMN5E4l+chP6MDLKODPGevWXToqG2KBOwmj2Sn0v2TejqjC+SRRItPzg8sud1O1U16/dNjUfwSMsQnl5a9/WFQv7Z03dK2G/tUdOfGvztbG8OtTZowh7K2aS+gW4lwItF360Re2KTRdwVNpDlrPEIE/1OQqPoSeeGvAMXEhtByqdksoUQmQE2QIlkyyPzGpwAPoWqpJOIK8sQ7wubQFgDK7R6Wv44OygSPwMsSOWlP2aQzrZM/jbnYpi7Tt22Z3Lm/Z1tEKRf2KuLX0ewvtIwm9l1a2CpHXEwtFJa8dGdK0v3MQ+Do/GIAX8CYoZtKVwJmfzlL0+nRDuW+NVEX+aJXylhitVZsnijAB8AksgG5uFCkzQDfrDAV/x1jwdaZX2QNPiCjAeHhCTpio8UHcBU2m9BIzSz78kHaU0kEbNg3QD4tAI6fVNDYv+kPs7oB+zmwKQr7yFyJ7G/jisJAJaLez7E7bpQ6ONtX5jfWpV4yLvA1TBxieys8uqpIfvICXdudk0kg4x5SVoqoAaaol4SSUh/obgw2b2///U131Kors35Lj3IU/6OSXkVXeXdy/dWv28U2UBxvWcu3ar+I7CVh/8zwUsD3iVlbaWjlN73cNd2AQ7csGpHzmKtNULSIqSQkcx0pDE01PT45PozGDPK9tLWL7Ec5MkhsbihQc0vDUEPw9fN7akLbn3yYAPXJFQLcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U+oftpWjOTP5DH5tEk1MQdztJYnhjEDKznzWA01jhoDm2jHyK4z0z6r57uU6?=
 =?us-ascii?Q?MIZImw0zkgZifenZpvSK/u9P2xYyZx5blXVVm7nC4c/wsaOYAIsTfb1DjjoP?=
 =?us-ascii?Q?PMQwlgmOyrEZJgs95i/sCLZoF+Zv5rph7aiPjANxqMc2Z+zQUQpR/gLhbV+X?=
 =?us-ascii?Q?yydpAU8PPxcQWANs6vqjTNrWd7qe3iHFKq+TYsqbsaxZNZF/ay0yQ5qHqT6P?=
 =?us-ascii?Q?2brq7jX3H268XO5VSodCGkiDbp8ktdDQ4H7uTiaXe+Lq4x39BPOL10wnvSMb?=
 =?us-ascii?Q?NsuHBIjPzjx8dvYZ5dn8IjG/jc2c40BpmWeRjLAbSZ9+NZNjNl12s6azAnRL?=
 =?us-ascii?Q?9hbNfSFvO5fVQYbY/NkEjrEj8j0fJqbPkOcFrxz6eqz9j5yzqofN7mKF8rnv?=
 =?us-ascii?Q?ghlN5f6yQK+FgkRCvHAWzswuWQBXCkUkZb/G6pj/vH7W4OyMIPL8pzHY8XIp?=
 =?us-ascii?Q?xLOD1DgQcLxuAnf+dq0CGkMjCf2kC+sfBTUFcH+KFk2kjc4wK8XWxUYZF5Xm?=
 =?us-ascii?Q?wg6wdjqDz43renXb3G+yQrr0GC1YfYbfq/yNZMtsO+iSwk2OUo01ShsEO240?=
 =?us-ascii?Q?8UtSWLxR8iAsEI0QJoDq1EYJv32fp+mOB86ibTby/XkVDAXxvpSzkgbS52Uy?=
 =?us-ascii?Q?kV1G9czoRsOkebmyRkShid9m92SKAWp8xlTKHCauLM3pu7rA+78tO/4Ow8fV?=
 =?us-ascii?Q?t9cHA9XwW5bjSgt8IV3gn1PPJqlzrZId9sgF34L7yT29IYoNYP2oNNobCEQC?=
 =?us-ascii?Q?PAji+HK0HGYuMv01HQNXspMoDsv3ElRnFxIm2TCZ6oc1NdSY68pqWEZ9y4eS?=
 =?us-ascii?Q?sYLjUlinm4lmmJxg6hteS6UHcFoiLFwsCPhip76rXNclTYsAaM6R1sr4mqqv?=
 =?us-ascii?Q?voCDjMkVtQYXE0aac5lMMc19X0m6jxegnhoawgceQUJMC6FofmVCkyq7sz2g?=
 =?us-ascii?Q?MqGigE9mwnaMP5prun7c+DCy0tpghiHTD9Q2xMdsqWc91BGbIYrwm1jA2frT?=
 =?us-ascii?Q?4CARmJ5D0pb+1INFQVBfoRYoiJk8QvVdp4rQUcLCwj060J/U/7WQ/dAAVkBr?=
 =?us-ascii?Q?RuotDGb1A0cLZEHucxI+d7UhpfIg0pVx2KvExNhQid/oVsgcrlO5ieMnX6a5?=
 =?us-ascii?Q?Akvu3c1SIftwUD9wI2W56TXGeJP88h6lWaPzO7VmnuulJiO1vlQ1VdvJ+BA4?=
 =?us-ascii?Q?Kf89HZ3SnfAs8heEZ4mTNNL0hOZQxJ+4U2Ufdkpaq0w35Yq8I/8TFuMBH43V?=
 =?us-ascii?Q?lWph4dLwzJjRti5g6Y7iIfrnd7ywwaopXKKf3z5o0SxNigiBiK5Qw04BuZZd?=
 =?us-ascii?Q?nB5seOcNaBKQhsC0JMjbHlK35sE+WLZTtwnuIKZ9LPchT3S4OewdA/TQJ9GZ?=
 =?us-ascii?Q?lMshJUXxCz1OOKGa3b3M/kpraksDs/ZOhP7nzZsFlwNzbwVQrYJwU66LEmpB?=
 =?us-ascii?Q?lY8FoFkDK1rvfRZMH3aq6jQrYpn/NkGLBTR+PgUCp6CCgbYcvOUWXVIAnrTH?=
 =?us-ascii?Q?Oot5lFWYrKrdh5yc6UnCefd7vNeNA0gL29UaILa02bX/zQgecba+WfS1loLv?=
 =?us-ascii?Q?+5qV7BaHAMgDx/UOU5MiqbErVj7mG7Fc1vAxtXe5/J9UYC9rDTEY9M/5QOxP?=
 =?us-ascii?Q?U3TI8Pz226FvkSxi0oo4SMa3yur6u6B+Xydj4Lli/FMMKT5xJYPkhP4mfdM0?=
 =?us-ascii?Q?853wOGiGHw5V74r8XG9utn/3CiILQa7Bkbp9yeGjn5d1ld4l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53165013-4d08-4167-cb49-08de9fa7123d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:08:24.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usIV+BDWHY5sLuTtVZDg+sPWzt+AH9KWhPdZkUyPt0P3GzvSiHR3W18InwXCoZz9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15433-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: BC88143B300
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21 Apr 2026, at 2:16, Kairui Song via B4 Relay wrote:

> From: Kairui Song <kasong@tencent.com>
>
> Shmem has some special requirements for THP GFP and has to limit it in
> certain zones or provide a more lenient fallback.
>
> We'll use this helper for generic swap THP allocation, which needs to
> support shmem. For a typical GFP_HIGHUSER_MOVABLE swap-in, this helper
> is basically a no-op. But it's necessary for certain shmem users, mostl=
y
> drivers.
>
> No feature change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/huge_mm.h | 30 ++++++++++++++++++++++++++++++
>  mm/shmem.c              | 30 +++---------------------------
>  2 files changed, 33 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2949e5acff35..ffe5a120eee4 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -237,6 +237,31 @@ static inline bool thp_vma_suitable_order(struct v=
m_area_struct *vma,
>  	return true;
>  }
>
> +/*
> + * Make sure huge_gfp is always more limited than limit_gfp.
> + * Some shmem users want THP allocation to be done less aggressively
> + * and only in certain zone.
> + */
> +static inline gfp_t thp_limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp=
)

Would it be better to rename it to thp_swap_limit_gfp_mask() or something=

more descriptive? I am just worried about misuses in the future due to
the generic thp prefix.

Otherwise, LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

> +{
> +	gfp_t allowflags =3D __GFP_IO | __GFP_FS | __GFP_RECLAIM;
> +	gfp_t denyflags =3D __GFP_NOWARN | __GFP_NORETRY;
> +	gfp_t zoneflags =3D limit_gfp & GFP_ZONEMASK;
> +	gfp_t result =3D huge_gfp & ~(allowflags | GFP_ZONEMASK);
> +
> +	/* Allow allocations only from the originally specified zones. */
> +	result |=3D zoneflags;
> +
> +	/*
> +	 * Minimize the result gfp by taking the union with the deny flags,
> +	 * and the intersection of the allow flags.
> +	 */
> +	result |=3D (limit_gfp & denyflags);
> +	result |=3D (huge_gfp & limit_gfp) & allowflags;
> +
> +	return result;
> +}
> +
>  /*
>   * Filter the bitfield of input orders to the ones suitable for use in=
 the vma.
>   * See thp_vma_suitable_order().
> @@ -581,6 +606,11 @@ static inline bool thp_vma_suitable_order(struct v=
m_area_struct *vma,
>  	return false;
>  }
>
> +static inline gfp_t thp_limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp=
)
> +{
> +	return huge_gfp;
> +}
> +
>  static inline unsigned long thp_vma_suitable_orders(struct vm_area_str=
uct *vma,
>  		unsigned long addr, unsigned long orders)
>  {


--
Best Regards,
Yan, Zi

