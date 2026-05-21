Return-Path: <cgroups+bounces-16141-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOktOJJ0Dmpa+wUAu9opvQ
	(envelope-from <cgroups+bounces-16141-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 04:57:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B559E386
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 04:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E7353028C60
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A036B067;
	Thu, 21 May 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v89jzktP"
X-Original-To: cgroups@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B75360EE4;
	Thu, 21 May 2026 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332237; cv=fail; b=DKv1anvs7wXBMJGwS746YgvcLaqz1x5T5jhVg0netlnIogfR14rNrRKHz2tAkce2DjHnVyGDXB4NDznj03NxMygVY2tef5rJ54XmWmlFPzkDV/z1QBfN/ByQYRZbW8Br1GMTD8cdl0xB/k3BMKWqx3DJB3MvVVv5g9CU8x9/XPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332237; c=relaxed/simple;
	bh=/hx6O9aTCG5mYs7wM+gzz4UrvDZhUW6Wlko9fBKevIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sunkvg5rpAPD3NHKZXjd1u3cao0jiHmYRBT/rXrG+OiIuCVY6M1aYOXShIdrDB/qsWdE6pN44dGaFtCX/2GdnMLLsnnFOLbHfqdcJjs/mjm3SJb5Bv2rCbUL8/FAcVbUtQSfgrYWBlHx/nqpfyMknYtUpWYGyGvmCl1aC/EXFuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v89jzktP; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkNlB6wdthnegjcLMMsO+R0XVIwtdT7TQHaAMw1yMJL5kxtwg99UdWdt4OOWzfqXAPFpmPFPDQvlX7mcpyy6c8xlm9iLjvOCBxQRMaUx+43oOelyStzuaW4aZTHrxgBsHuDRagiTS5FT+hwqkTCaNaHyCcHoa9rm+9WMU+sf/r89ueV+RhMVoMZ+sr/E876VfKPne64NTDYXP30U4eTTZHYrGOfMtAgU9J7YeWZ61v3+mrjfSPGM+/HD4CPsoEtIHuz49h6d/KXhYL5oBoE+NgB+pqZNktRgNQ/qhh/t4Yh6kmj2y3DkdbJZleKE7vcd/GPXvT7WNPpBAzSBR0yLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykXAeAEJ+AYn7LCmOOcz7C8BvF4Ux2D4XFu7JCV51NU=;
 b=QdX4OLxWcv3oQTbAbvHbJMYWdD+K5b/QHt4DeOkTEDTxNS99pcZoMHhN7tcoo+X/dMhj8tykGNoYBXj/pe2cVpOaD1EVWJk5tNOvbHNpxsLEVTLIUUma7amLzIEqlv6yrtfWqz3Vh4Kao9AnEHpF4Nl2OId2e0Vz0Mh/NOIQjnTHKcasC1pjhtA/EVqC/PJRuZ29MXtbaoS9cSTo4ZpFm4H8rCefS62A8TLGu+TPHq76F/m1PdGgNjavwzcxvzm04ZwfpXElLiZZXDFUovO8xAfLCaR8xVyjON1DwvNtYZeccGZnaYsKRfWgHu1+Z+U7Nzq6B6SbAWxsrPj5IZJZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykXAeAEJ+AYn7LCmOOcz7C8BvF4Ux2D4XFu7JCV51NU=;
 b=v89jzktPCqr6/7C6qLrOP1B5XwXwaCTgmF7Xj25B27O14R/qSnjBxZSQKUuc6UPPTbRn84yITAHzWhG8MLVnQSOJ9bjioOgO54snzy7nAeLYBgsgf8j8s0oTvUfBB/dKE7KcHiKw4clmSmV/BfwtEJPxcQyQvGakvK4L++Aes/0=
Received: from DM6PR05CA0059.namprd05.prod.outlook.com (2603:10b6:5:335::28)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 02:57:10 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::a) by DM6PR05CA0059.outlook.office365.com
 (2603:10b6:5:335::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Thu, 21
 May 2026 02:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 02:57:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 21:57:09 -0500
Received: from [10.136.36.105] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 21:57:04 -0500
Message-ID: <eb61103c-3dca-4032-90af-d472b26d2dbe@amd.com>
Date: Thu, 21 May 2026 08:27:03 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: <mingo@kernel.org>, <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
	<tj@kernel.org>, <hannes@cmpxchg.org>, <mkoutny@suse.com>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jstultz@google.com>, <qyousef@layalina.io>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <CAKfTPtCc=pBKe9eRbA5B0zhaXJKVjN4N74AT0BFyRK39cS4c5Q@mail.gmail.com>
 <ag3iC-jH6HPoWKGo@vingu-cube>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ag3iC-jH6HPoWKGo@vingu-cube>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4877e28b-b751-4530-3777-08deb6e4a71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4KViF/1fZnx7dMGahSyoUk6Y7NKT4cOzvAfyx283fhI9Dnd4FjAbGqzvnbZSiHFFfj4K8nEW1fQehALcFaaCoNmSWt5CgdMMxO8NfQ+HSK2zNk+Dxf2iHxDDJunt+i2TqxEFKU+YXKcQDT1Qi6fd8F+dRjKrGPA+T+wzRlHJ0bD/PryoRZ8BHlelMgrdabfE2LyUXojyJRJ/yU+19nlXFpjjtWkm1wyA7ROoDW9KPoDRp+koCeApqSWmr0Lj7ukNvSzyVoLQ3jk2wy2oirFySj8ES0HbXYJauxYJ4MeFXcXA8igoofdRdTZPRtS5cZ4t4Fqc20cp+Cxil52AHanKuT7DjDcEolt5dHuBxm0dB2X2MKBCoP+EJLHl9ATTw87VtICtIG6OeyeLa8mMRhOkQwY4H0TMC5EDhm0HDW4YMd2+EHx4FIbGW2mtVT37FwpJ0VVWoiffNvY6Re+raKs5PeD85CBxxx6UWZiH0m/bTTKn5q2iyVoALxXKd/6Zinbld6adtGdsodr0/1g971ZGwc3GfXy+D8k57rycOdbsi85D/gyZP/wAHomInJzb83a2HayZJqszECpSUeehyo7bAiSsUpzR+20UW1IBLJW4iszPseSSKYg8ZQTgKBlBKzdxwdrt2xt85b0+0dBubDioNhOFIoiX4C3qeqpIEUam9XIUU0PWyRHMUNIyBX2eukjZhsLM7zRIbBm7gMtVqRd2ST76Vd5KVWxY9TA70XLMWDY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	up5kePqjgArrraUHiKpFU4Vv3gi2lS4+VgDcSOZG0Fcz9EXHP4IJfRILE1sBzBqFnqqsvU38disMqcydZ2ibAQ+tSD+nWKZ7PrhTkZlZ4P+EGu7FTvQEDnmqEWSnGTyHs0OtMr+ZDcEOzl5sN4XXWAZRkUF5fpUn4hOmt1Fi3KP/imtUAhzAt401D27JQYukHmcLud1vG68Pd/mESK/csr5vr5TFHN+rY/lsOctxuxCUq5BhIACTy+5hsravVZLjtm13yPhVU3o+AyTiwbiqscH2iaZtexobqIxfLqoG185YDsQz536Kyb78uLru1GgdirZAu2zprsFW35OpbR6SFddc/ntrRxvwT/QezNgJTO8TRFkxbOkit66etG0o4RrMNuWosVla8TWOsbnV4Mm9ygSikX/+Z11bCSl99TBaj8YeEyN9dLy9cpADpB6JQG/3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:57:10.5119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4877e28b-b751-4530-3777-08deb6e4a71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16141-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4F2B559E386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Vincent,

On 5/20/2026 10:02 PM, Vincent Guittot wrote:
> I finally fount the root cause of regression: the update of entity lag happened
> after the task has been dequeued which screwed update_entity_lag():

Great catch!

> 
> update_entity_lag must be called after updating curr and cfs_rd and before 
> clearing on_rq
> 
> With the fix below I'm back to original hackbench figures and maybe even a bit better.
> I haven't checked shceduling latency yet
> 
> ---
>  kernel/sched/fair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77d0e1937f2c..32fe57004f27 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5753,6 +5753,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  
>  	update_stats_dequeue_fair(cfs_rq, se, flags);
>  
> +	if (entity_is_task(se))
> +		update_entity_lag(&rq_of(cfs_rq)->cfs, se);
> +
>  	se->on_rq = 0;

Ah! The curr->on_rq indicator changes here and we'll start ignoring it
for avg_vruntime() calculation afterwards! Makes sense.

>  	account_entity_dequeue(cfs_rq, se);
>  
> @@ -7423,6 +7426,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  		if (sched_feat(DELAY_DEQUEUE) && delay &&
>  		    !entity_eligible(cfs_rq, se)) {

Does this need a update_curr() before checking entity_eligible()?

Currently these bits reside in dequeue_entity() and is always done after
a update_curr(cfs_rq) but here we may need a:

    update_curr(task_cfs_rq(p)); /* to catch up h_curr's vruntime */

Just doing it for task_cfs_rq(p) should be fine since we only have to
catch up curr's vruntime - sum_w_vruntime and sum_weight at root cfs_rq
should be stable for all the tasks on rb-tree.

>  			update_load_avg(cfs_rq_of(se), se, 0);
> +			update_entity_lag(cfs_rq, se);
>  			set_delayed(se);
>  			return false;
>  		}
> @@ -7430,7 +7434,6 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  	dequeue_hierarchy(p, flags);
>  
> -	update_entity_lag(cfs_rq, se);

If we decide to do a update_curr(task_cfs_rq(p)) at the beginning of
__dequeue_task(), we can just move this to above dequeue_hierarchy()
before se->on_rq indicators are modified.

Thoughts?

>  	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
>  		se->deadline -= se->vruntime;
>  		se->rel_deadline = 1;

-- 
Thanks and Regards,
Prateek


