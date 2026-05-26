Return-Path: <cgroups+bounces-16304-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KGACSl9FWoQWAcAu9opvQ
	(envelope-from <cgroups+bounces-16304-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 12:59:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 807FF5D48B0
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF955300FEE7
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0214C3DDDBB;
	Tue, 26 May 2026 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R+C8IYVi"
X-Original-To: cgroups@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34E3CA4BF;
	Tue, 26 May 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792888; cv=fail; b=jXXF35IFp7o82+pwSVksaHpFnM9nU8//t8GBtD2forGor1ghaW/QGwTeLyOo0qSo20b7Ln7nf9+QOLVeeQ36ELvce/f89q6v2Af2C+mwT7s1hHA1F+U2UH98K1FaMlysrLmDLE0MKeEqkA6eYViMfrDa2UAu4fEH/wXBjBNAeV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792888; c=relaxed/simple;
	bh=SPPOIaQqPZ8EAUllASW/B8Hwr7EyWReZ/tgkIJvSxd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N19jxDlF7UCXQzu7iwjHAeiyOZB2+iXpk9AgjDqaafXIVOQC4/I88Mz8Mi0cX2ihl5luaiIQXzwpwdX9Us50Gbpwo5Ds+/1nVfuQjMnL6+Y0ZVXHsdkwDp24CY0B0UZoYKY0TEaB8sr1zhkemgWvUWCA3aW5mkRc6AhBN8keSRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R+C8IYVi; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qo6HgxbjzVJphs2GXobCKQ4idslkN/ZxtejpPLOrn6+O2c4IP1WsT+NLzfHz0/E1Gd1qOmM7k8jCAU8VlQ1qa1QBRwe2tZ7y6+xlO9+551YeFQGHpOC5XkPhSXeGc7W6IA8Zo85DweXnco8AHFmyinWEjd5utwLrvIL7lrhlDWRIphAUzq30C54SY5P0S3LaA7R0XRnoS3bF7ccZEiGT9eLyTMcC9unJhLGI8Fa66xyWjXwZeQbFxJu3DS7B1cgBlPUW1J0rIObZhroCBzAKgD2l9ykilTDxlAcip8BnAQSoZaBN2Uf1NSPFtO7NJB3WJ+3K1trjA2i4XOZhLahqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rKdVVuoB094ji9jAy7B3n2FZyZiLoOSWLYbionEJtw=;
 b=gQ5aVXiXVTXOKtINK99haztfikUaHW59bxO613ZNQcMXkABQHC6yRy76yAnJ/eUZcoVrsp2C+fLWO7QIpE7Euq5+G9h7DBPIpDt4XyzFs04j2MVSgrJmdHHsbJEZdyQU7D01zv1pUevww2+vL+dQwFzB0xrNsydAEbw5hzdxCilmgDkXa29ruJrqsAiajvW0knpWL8khKQpJFByL7mCUU18mp86CGP8NO3Xv50ebodWPFAvUltzulFKXdCY1ROD9TjVpPipPy/tweirVjf0ainkHqnqFX+Uzh7YzVkm6oiqtD5ycle9djvKnW8ZfNSZ40UW+GKTucf6ysIuqK0S98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rKdVVuoB094ji9jAy7B3n2FZyZiLoOSWLYbionEJtw=;
 b=R+C8IYVif6ZgW0GRysgrD3E9NgCEguF9M9O/8AQBCJoMUEzzYBOt4kCZZiyBHcNjETLdPl540t2ESqDDq05JpfLjro+CXdvYJXI6DVtzwUkPoah42+7c98tvQV8qbe3d9hyi/1gfaCqJyGS4MH5ILcguHTWQM3OBhUZsnPIHZAU=
Received: from BY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:1d0::30)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 10:54:39 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::86) by BY5PR04CA0020.outlook.office365.com
 (2603:10b6:a03:1d0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 10:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 10:54:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 05:54:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 05:54:37 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 05:54:33 -0500
Message-ID: <3f1fc681-a73b-4bd2-9a6a-e61b8fbd5826@amd.com>
Date: Tue, 26 May 2026 16:24:32 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>
CC: Zhang Qiao <zhangqiao22@huawei.com>, <mingo@kernel.org>,
	<longman@redhat.com>, <chenridong@huaweicloud.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>, <qyousef@layalina.io>,
	Hui Tang <tanghui20@huawei.com>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <a06e4744-2393-724c-14ff-154f1caa22a6@huawei.com>
 <85116808-8643-47d7-b4e7-2a11c3999b20@amd.com>
 <20260526095210.GC4149641@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260526095210.GC4149641@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: ec886c06-798b-40e0-8a08-08debb152ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	TE/UYLChRWMbCavs561VxoOX2akF8pF12X+Zoansm0ENrcH9K6MwAKe9XxSvmEF8QKyMtyzMwZTztg2DwzJFuvwUE1sTxp2H8uQ6Ttdo2V1Bg3sZnWchB0bje3GPYaheYqCi+G0yhR7Laq6ChRrmkl5bguAPDmInzGJ76+OxA3ySzhqPUq2L/PALBwdlppKd1lxJw5sN4hrL4mOG50KdQ+HMinDXD7w/7MhS7I8F+1I4hjpohIFq0jJyTjERJuYGJmVTfkjzgtAsak3KEn67pdvgH2bqH8RJWVwtovTJXYKxeKMYCMpxAmBOtK9Tc6+dM+cqnK+X1YVmNUtVOAGXNsuKPA2Fw9D64SV6zy9LZSYtkZWv5SHm+EtHubJjXRWGFuvC4r7Qa1+ekvLCFMw5+7RCxl+qMiwPUjmGe3I+X2Esc/A1rqYG1OkvkQx104g6b2fS/iCcmcAWe5TkbEAFJLaT96DY0p7y34CwL7+GBaDyqACeYSKJwbCM3ggBc5GsvyBI0+k2vWSVStH96gx/rU2TGS9KJ/O1gDxmFZAygaEK4XHBAY6QTfnbK2M768mSHecSZxWbgB749CH9nr5yX9nX4mroQBspA5WrXT/Qt0Uz+aXyFIGkaaZGQLmfsxfbCyPn8WDtDYeMXcpsI5J8wVyCl70PjKJ8jJL6c/CuQn56vjNp6mmimaud5VEKlEZJVry+wPW+XlnxrLf96h7nr4FGLrldTG3/KN276Jo4V3s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qy9CmgqypM9iAXrOnRV+86MNZObknHyiVDCHJZpA8+4aqQM8lp+EFRf0cvaNHO5lIHExKi+Yt+blSfTHkbxCxy/30cpht6rmlk6l7rY5yOX0OZFpCcvsamESwDVfwfSRgt9+mxPa/bxP+n6mpRnWBWpCH03uY+oBtDra/echIm7LnwZngHCj7oPODo9NxWDnf0Fb2q0ru4w9MrMiBzKs1GiFheGlwKQL/xI17sxIcV+MUJ8aeJwQA2ZTwJ3xN3Ig9WC8Xy07H4r6ZpFSh1+9KKFT+Ig/2dqYZNwAS7MqX2CXaChqMYQ+NV/kWXznFpIe9EF/Zdm53KGEzRxjfQGXNlD3vpccRV+pqqvGA6mc8BHN7Z/Cy11JnlE+7elb6VMn2YvPert+Bbmzrfe71SGz7fr7k3kIf2xVxoIf8Ix+NvKnnzlvPgxOIsPN/BPSjF32
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 10:54:38.5929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec886c06-798b-40e0-8a08-08debb152ecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16304-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 807FF5D48B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Peter,

On 5/26/2026 3:22 PM, Peter Zijlstra wrote:
> On Tue, May 26, 2026 at 02:45:45PM +0530, K Prateek Nayak wrote:
> 
>> The suggested diff above solves the crash in my case but your
>> mileage may vary. Peter can comment if this is the right thing
>> to do or not :-)
> 
> Is this a different issue than the one you raised before?

Yes, this is different. Essentially, this is what is happening:

  throttle_cfs_rq_work()
    task_rq_lock()

    dequeue_task_fair(current)    /* Task is dequeued on cfs side */
      __dequeue_task(current)
        dequeue_hierarchy(current);
          current->se.on_rq = 0;
          /* update_load_sub() */
    resched_curr();               /* Initiates a resched */

    task_rq_unlock()
      local_irq_enable();

  =====> sched_tick()
          task_tick_fair()
             __calc_prop_weight()
               /*
                * Oops: update_load_sub() above has
                * 0ed the weight of cfs_rq.
                */
  <====

  preempt_schedule_irq()
    next = ...
    put_prev_set_next_task() /* The runtime context is switched here */


> We talked about throtte, and you were going to make a proper patch of that cleanup
> iirc.

I had rebased your suggestion on tip and fixed a couple of splats but
once it was functional, I noticed hackbench taking twice as long to
complete compared to tip and I was chasing that before I fell sick.

Let me go dig deeper to see where exactly it is all going sideways.

-- 
Thanks and Regards,
Prateek


