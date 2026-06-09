Return-Path: <cgroups+bounces-16755-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RFI9HNGmJ2rJ0AIAu9opvQ
	(envelope-from <cgroups+bounces-16755-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 07:38:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C965C7BA
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 07:38:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=OyjhOFk2;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16755-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16755-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70797309FFD9
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 05:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F93C3458;
	Tue,  9 Jun 2026 05:37:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC071A304A;
	Tue,  9 Jun 2026 05:37:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983453; cv=fail; b=T3/b093Qizpx+mRmF2p7zqwXqHJj2mijF/yzZkFIE2ltQWOMNEFaKcbQJE2ubOcEPlnwTIkQh8Vxa6c/l9P6xLT5ZDUSF6MR1IFg9E5Im7avRI/OyMov7IKE9F6+XXjTuHVDB1ikKxX5YqsKMdaP8+IW2bfd1CDnWw0sEFNY7kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983453; c=relaxed/simple;
	bh=c674U/ylfj0U2oZUYP5fcXSvnFcDGZydL8dtFJkx7lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Eys/CnzAbgLFDycnP30FYfi84tNbUEDaw/WrHu/aG8nzWN3+cyZh3egFb8eT4ErR85NpxMMLfADojsJcfrPqfLtGQHDodFuApelbf42AE1721iwdIlHN5iymPQaW1Lk1a5vl+wDk/8S4F2wBRzgB1GJaM+O4xYLaTSOu+WaBnXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OyjhOFk2; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyBu/ZMJenlu3HXqtBoA335HSUugUZjlETqjG/F/Ak20kCy6aE7xXoBYxdcfcbcGcSiP+x1wdNT1wGzo+s3IQDwU8FUVkFSHMWQwy+matucBuaEFB0qTDWPFRJle/P3of7pXpZ9hWWlHKR+33WYQ17v7X97VwysMYjWvx9I9imfyyUVZoap5bzoxLPVQxBhR4V+c7h1WsCtA7JYeJ8MHhLhi9d0ICbLnztd/lj8HFlHq0sV2FNhUd2BDYjaAoGT0070wtryowAGRpPevs1YZ7LQn0kjxkGoEY6pp6MchVzyOb+VU78CKuMLuQ8peKLOg/IcdDWkHPcAq3QSrjWP5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR3vJ2TKdMP8utUOyTlmIBs/6RboWZae76q+FKFCZyg=;
 b=wbCs+jlRxztZpWzaBG47K3GrmI7D1lHzjBT1C02h2n6Zo9wxcjqa4nSNwmCsazc8mj1YqN1dhaFAnDPLw8Jh9VvzJxz+h3nq5pKSuxLRnIcJTd7/AdQ9YObbvQfhmLwhWMPFQLB/vJnC3lnAfTFL8E1ByffCTMGiYZaFVTo3V/9cQqfqTSp5o3tvJj7LY0EjkoKzIYcIBc3JL/rs/D/gfrNAPJcqaD8mEwj6Rt7IGTpZZ9LzJdiEr6yoH0LPGjbxSd50h5zmdpVJ+SyQLBzDY4g+iSEb/OJqZqDwlbN0guVYJKefThuIKrTmYa6CY9X+/OKJUsEogs7hqtKGgnVI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR3vJ2TKdMP8utUOyTlmIBs/6RboWZae76q+FKFCZyg=;
 b=OyjhOFk2UlevQGalRSGrxdWvNBJhSU3tgYvZERbOsXhcsIjtUudbfKx79bXCNMv/7QijVv6LYZm3n5aJip6KhARYCilDhvT5A12qyVwrYyQwLjjpUkDW7M6Y/1MfbK5kA+LRmsh1+bmZF1NpuInPRQEi32dz6a+QY+oqYqPoNQ8=
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 05:37:23 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::73) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 05:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:37:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 00:37:22 -0500
Received: from [10.136.43.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 00:37:15 -0500
Message-ID: <65980119-a26a-40d6-bec8-dd597833a6e8@amd.com>
Date: Tue, 9 Jun 2026 11:07:14 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] sched: Flatten the pick
To: Peter Zijlstra <peterz@infradead.org>, <mingo@kernel.org>
CC: <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>, <qyousef@layalina.io>
References: <20260605105513.354837583@infradead.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260605105513.354837583@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b0fec3-acc6-4201-f004-08dec5e92e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	t0TunDOXb855lmMkG6WSUfKDEwcf1TEBPsmCUROEuVZ40J2HYpC15vFf0bXQly+4Y5fXyKEXxnD2DbZo8z4nCTe8Nk+h3ApC5s5s7OChIThN2/8gTSKG7LxzHPt1C+9HJhNmXTBfdNYQfRj/f2rE0W5p861bdEV1d/Zj2IO6QgowBlGuRTuKWviuOaCqT/Cj6CQwnlpRXf8u4/GUU+cLjLwBxE0nA58CTxmM7JXTIFfUPtAIbg0ceSEq+2tCBFA/chabYpaDLG6Wv98EBBZEMZb+e/qbFL3Vo6q+0rCNWWzIFPPYDhEewQ2vW3XCADvVhDmh2ZZ8YFJ9l03JtQ+JyPve1hiA5TZUAEOgkp+rAnWEJ2v4abhzE6NBeG8iconl2YC8S70fp/O0YPSU9udg3ox9T75riozNUkdUuYMyMgcTQIeyptDW2LbxKraq0WPUub/MeqXiD2jZ/DyP3ddyUxmC6Yp9SgJc+AMG7gR/flND1KZKkUULHkMKDm35QX6y4imraPXW09eSl9M/jdYrql5DsBaO2u0deKjVRyh3qlUEYD5jiThTM5uCSPpWjRJXiDxY8J+z1FFYLVXMBv3O1rGE/TdpnpjBHT6VrFrY9BYFJrpa8HhPBNAAizVidqWDbTB//UuazSroUcXrNXUXgEGZIL3TQy0JLSAlnUf5lzrm6dxVzIQUXqjR8ceJO917VpyybBUWXiFRj3vgA3sUcROtf+Q/E4ntb6WjY9xBuDI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y8/yZ3IJMxstfT8TBXU9fU73TVFNVvBPPnJ+buTvZzGjTYKje3ZL0JAWbzPp/zPb02hpH2V1U54tFI9UoRPTZj4sTGgh/kpWY9RFrcc8xVGn/YrFU0/2DzwJ9qiOrCA/GBF0EqJLezo+SLOGbRb2tI3ez4M7VZKWH/USuvjlEdCzvq5sKdwOIwdabD0OzgrCyI0pT/rgUPzmxNnstqh747k/He0pqCWEkz6KNVuYUdhjg3r23HqCwZsfE4xbecIv1Sxo+G6vwkRn9/w64WsNd3SNvwL98VANS9JNHwYUmV9RcPB87KNueggGjP8Nz+3OmDpgobeIdY0ctnNVd/EkP3rxdjHLYSKRsbiVPFHnRqqOFVfD8d00all5IrgKPdx5nMOIEY+GAd3z4e+3oLy+OeHaN7vsQFtpbuO1yojH98sQ26E3ttH/xQbLxb8VlSB5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:37:22.6348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b0fec3-acc6-4201-f004-08dec5e92e3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16755-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kprateek.nayak@amd.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C93C965C7BA

Hello Peter,

On 6/5/2026 6:10 PM, Peter Zijlstra wrote:
> Can also be had:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/flat

Here are early performance numbers at commit 7eb85c33dd20 ("sched/eevdf:
Move to a single runqueue").

tl;dr

  Apart form a regression in the tbench and schbench at super high
  utilization, all numbers for concur mode looks good so 7.2-rc1 target
  should be good.

  P.S. I won't be able to look into this until Thursday; Sorry in
  advance.

Note: I haven't gotten around to analyzing anything in depth; These are
just early numbers on microbenchmarks and DeathStarBench. Please take
them with a grain of salt.

tip was at commit f666241e6bd5 ("sched/fair: Unify cfs_rq throttling via
account_cfs_rq_runtime()") and each label are the individual cgroup
mode togged on at queue:sched/flat:

Machine:

o 4th Generation EPYC system (Zen4c)
o 2 x 128C/256T (32LLCs)
o Boost enabled
o C2 disabled; MWAIT based C1 and POLL remained enabled

Benchmark numbers:


  ==================================================================
  Test          : hackbench
  Units         : Normalized time in seconds
  Interpretation: Lower is better
  Statistic     : AMean
  ==================================================================
  Case:           tip[pct imp](CV)            up[pct imp](CV)           smp[pct imp](CV)     max[pct imp](CV)        concur[pct imp](CV)      tasks[pct imp](CV)
   1-groups     1.00 [ -0.00](11.18)     1.01 [ -0.60](12.84)     1.12 [-12.08](12.50)     1.16 [-15.71]( 9.46)     1.07 [ -7.25](11.46)     0.99 [  1.21](15.44)
   2-groups     1.00 [ -0.00]( 4.73)     1.01 [ -1.00]( 9.29)     2.88 [-188.25](63.11)    0.97 [  2.75](11.62)     0.95 [  5.00](12.47)     0.96 [  4.00](11.72)
   4-groups     1.00 [ -0.00]( 2.90)     0.99 [  0.96]( 2.48)     0.99 [  0.72]( 2.38)     1.00 [  0.48]( 1.78)     0.99 [  0.96]( 6.61)     1.00 [ -0.00]( 5.23)
   8-groups     1.00 [ -0.00]( 1.82)     1.03 [ -2.51]( 2.81)     0.99 [  0.91]( 3.33)     0.99 [  0.91]( 2.40)     1.01 [ -0.68]( 2.44)     1.02 [ -1.60]( 2.45)
  16-groups     1.00 [ -0.00]( 3.05)     1.03 [ -2.96]( 1.97)     1.23 [-22.82](22.67)     1.01 [ -1.31]( 2.03)     0.99 [  0.99]( 2.48)     1.01 [ -0.66]( 2.76)

  Note: For smp variant runs, I think there was some system noise form
  an unrelated job that stated by mistake. I have to go back and
  rerun to confirm if the regression holds.
  
  ==================================================================
  Test          : tbench
  Units         : Normalized throughput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
  Clients:    tip[pct imp](CV)          up[pct imp](CV)         smp[pct imp](CV)         max[pct imp](CV)       concur[pct imp](CV)       tasks[pct imp](CV)
      1     1.00 [  0.00]( 0.23)     1.02 [  1.53]( 0.10)     1.02 [  1.80]( 0.96)     1.00 [  0.19]( 0.17)     0.99 [ -0.58]( 0.18)     1.01 [  1.13]( 0.18)
      2     1.00 [  0.00]( 0.11)     1.01 [  1.13]( 0.04)     1.01 [  1.26]( 0.08)     1.00 [ -0.12]( 0.21)     0.99 [ -1.00]( 0.29)     1.01 [  0.51]( 0.02)
      4     1.00 [  0.00]( 0.11)     1.01 [  1.30]( 0.16)     1.02 [  2.26]( 0.48)     1.00 [  0.06]( 0.37)     0.99 [ -0.74]( 0.52)     1.01 [  1.35]( 0.35)
      8     1.00 [  0.00]( 0.24)     1.01 [  1.19]( 0.81)     1.02 [  2.17]( 0.52)     1.00 [  0.45]( 0.36)     0.99 [ -0.80]( 0.05)     1.01 [  0.92]( 0.39)
     16     1.00 [  0.00]( 0.15)     1.01 [  0.87]( 0.70)     1.03 [  2.56]( 0.18)     1.00 [ -0.41]( 0.46)     0.99 [ -0.99]( 0.36)     1.01 [  0.55]( 1.02)
     32     1.00 [  0.00]( 1.02)     1.02 [  2.42]( 0.36)     1.04 [  3.76]( 0.94)     1.01 [  1.20]( 0.19)     1.00 [ -0.10]( 0.44)     1.02 [  1.61]( 0.27)
     64     1.00 [  0.00]( 0.36)     1.02 [  1.92]( 1.71)     1.03 [  2.59]( 1.15)     0.99 [ -0.51]( 0.88)     1.01 [  1.19]( 0.29)     1.02 [  2.42]( 0.57)
    128     1.00 [  0.00]( 0.45)     1.01 [  1.11]( 1.37)     1.05 [  4.64]( 1.05)     1.01 [  0.98]( 2.47)     1.01 [  0.84]( 1.97)     1.03 [  2.56]( 1.22)
    256     1.00 [  0.00]( 0.06)     1.02 [  2.23]( 1.11)     1.02 [  2.17]( 0.69)     1.03 [  2.87]( 0.46)     1.03 [  2.57]( 0.41)     1.03 [  2.99]( 0.84)
    512     1.00 [  0.00]( 1.50)     0.92 [ -7.62]( 6.42)     1.02 [  1.94]( 2.12)     1.01 [  0.74]( 6.70)     0.94 [ -6.09]( 5.19)     0.98 [ -2.40]( 3.00)
   1024     1.00 [  0.00]( 0.07)     0.98 [ -1.51]( 0.30)     1.02 [  1.66]( 0.13)     0.97 [ -2.97]( 0.76)     0.94 [ -6.33]( 0.26)     0.95 [ -4.63]( 0.47)
   2048     1.00 [  0.00]( 0.25)     0.98 [ -1.57]( 0.59)     1.02 [  1.81]( 0.20)     0.98 [ -1.94]( 0.38)     0.94 [ -5.54]( 0.17)     0.95 [ -4.56]( 0.77)
  
  
  ==================================================================
  Test          : stream-10
  Units         : Normalized Bandwidth, MB/s
  Interpretation: Higher is better
  Statistic     : HMean
  ==================================================================
  Test:       tip[pct imp](CV)          up[pct imp](CV)         smp[pct imp](CV)         max[pct imp](CV)        concur[pct imp](CV)     tasks[pct imp](CV)
   Copy     1.00 [  0.00]( 0.51)     0.92 [ -7.61](12.64)     0.99 [ -0.79]( 0.30)     0.85 [-15.33](21.73)     0.99 [ -0.61]( 0.35)     0.99 [ -0.90]( 0.38)
  Scale     1.00 [  0.00]( 0.35)     0.90 [ -9.96](14.86)     0.99 [ -1.45]( 0.76)     0.85 [-14.73](21.14)     0.99 [ -1.12]( 0.86)     0.99 [ -1.13]( 0.71)
    Add     1.00 [  0.00]( 0.21)     0.93 [ -6.95](10.26)     0.98 [ -1.51]( 0.80)     0.95 [ -4.91]( 9.84)     0.99 [ -0.98]( 0.69)     0.99 [ -1.37]( 0.67)
  Triad     1.00 [  0.00]( 0.24)     0.89 [-10.61](15.55)     0.99 [ -1.46]( 0.72)     0.95 [ -4.87]( 9.50)     0.99 [ -0.90]( 0.62)     0.99 [ -1.44]( 0.61)
  
  
  ==================================================================
  Test          : stream-100
  Units         : Normalized Bandwidth, MB/s
  Interpretation: Higher is better
  Statistic     : HMean
  ==================================================================
  Test:       tip[pct imp](CV)          up[pct imp](CV)         smp[pct imp](CV)         max[pct imp](CV)        concur[pct imp](CV)     tasks[pct imp](CV)
   Copy     1.00 [  0.00]( 1.52)     1.00 [ -0.16]( 0.56)     0.97 [ -2.54]( 2.30)     1.00 [  0.09]( 0.18)     1.00 [  0.17]( 0.44)     0.99 [ -0.74]( 1.49)
  Scale     1.00 [  0.00]( 1.43)     0.99 [ -0.63]( 0.55)     0.97 [ -2.72]( 2.44)     1.00 [  0.20]( 0.16)     0.99 [ -0.67]( 0.43)     0.99 [ -1.39]( 1.45)
    Add     1.00 [  0.00]( 1.06)     0.99 [ -1.27]( 0.42)     0.97 [ -3.08]( 1.95)     1.00 [ -0.13]( 0.19)     0.99 [ -1.19]( 0.34)     0.98 [ -1.76]( 1.07)
  Triad     1.00 [  0.00]( 1.10)     0.98 [ -1.55]( 0.41)     0.97 [ -3.40]( 1.95)     1.00 [ -0.42]( 0.16)     0.99 [ -1.49]( 0.35)     0.98 [ -2.08]( 1.11)
  
  
  ==================================================================
  Test          : netperf
  Units         : Normalized Througput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
  Clients:           tip[pct imp](CV)          up[pct imp](CV)         smp[pct imp](CV)         max[pct imp](CV)       concur[pct imp](CV)       tasks[pct imp](CV)
     1-clients     1.00 [  0.00]( 0.15)     1.02 [  2.24]( 0.12)     1.02 [  1.50]( 0.22)     1.07 [  6.86]( 2.15)     1.00 [  0.27]( 0.45)     1.02 [  1.86]( 0.15)
     2-clients     1.00 [  0.00]( 0.37)     1.03 [  2.50]( 0.80)     1.03 [  3.11]( 0.78)     1.07 [  7.15]( 0.96)     1.00 [ -0.43]( 0.54)     1.02 [  1.67]( 0.69)
     4-clients     1.00 [  0.00]( 0.26)     1.02 [  2.26]( 0.33)     1.02 [  2.02]( 0.37)     1.07 [  7.37]( 0.78)     1.00 [ -0.24]( 0.42)     1.02 [  1.84]( 0.22)
     8-clients     1.00 [  0.00]( 0.21)     1.02 [  2.47]( 0.55)     1.02 [  2.13]( 0.48)     1.08 [  7.60]( 0.57)     1.00 [ -0.15]( 0.37)     1.02 [  1.87]( 0.29)
    16-clients     1.00 [  0.00]( 0.23)     1.02 [  2.07]( 0.69)     1.02 [  1.87]( 0.42)     1.07 [  7.38]( 0.50)     0.99 [ -0.55]( 0.48)     1.02 [  1.78]( 0.25)
    32-clients     1.00 [  0.00]( 0.47)     1.02 [  2.14]( 0.63)     1.02 [  1.81]( 0.75)     1.07 [  7.44]( 0.94)     1.00 [ -0.38]( 0.53)     1.02 [  1.76]( 0.43)
    64-clients     1.00 [  0.00]( 0.91)     1.02 [  2.00]( 0.81)     1.02 [  1.74]( 0.96)     1.07 [  7.12]( 1.06)     1.00 [ -0.20]( 0.68)     1.02 [  1.63]( 0.76)
   128-clients     1.00 [  0.00]( 1.19)     1.01 [  1.36]( 1.28)     1.01 [  1.34]( 1.18)     1.06 [  6.37]( 1.47)     1.00 [ -0.49]( 1.15)     1.01 [  1.06]( 1.09)
   256-clients     1.00 [  0.00]( 1.00)     1.02 [  1.70]( 1.15)     1.02 [  1.64]( 1.18)     1.07 [  7.17]( 1.87)     1.00 [ -0.31]( 1.19)     1.01 [  1.29]( 1.12)
   512-clients     1.00 [  0.00]( 5.16)     1.00 [  0.02]( 6.48)     0.99 [ -0.60]( 4.31)     1.04 [  4.08]( 3.83)     1.00 [  0.02]( 2.52)     1.00 [  0.48]( 2.86)
   768-clients     1.00 [  0.00](34.61)     1.03 [  2.84](62.48)     1.00 [  0.26](30.91)     0.98 [ -2.12](13.41)     0.94 [ -6.34](11.15)     0.95 [ -4.82](10.61)
  1024-clients     1.00 [  0.00](41.78)     1.04 [  3.95](76.45)     1.01 [  0.99](40.23)     0.97 [ -2.58](11.79)     0.95 [ -5.36](11.21)     0.96 [ -4.01](12.98)
  
  
  ==================================================================
  Test          : schbench
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:  tip[pct imp](CV)          up[pct imp](CV)         smp[pct imp](CV)         max[pct imp](CV)        concur[pct imp](CV)     tasks[pct imp](CV)
     1     1.00 [ -0.00]( 5.88)     0.94 [  5.88](19.25)     0.88 [ 11.76]( 7.37)     0.88 [ 11.76](34.02)     1.06 [ -5.88](11.11)     0.94 [  5.88]( 3.69)
     2     1.00 [ -0.00](36.56)     0.97 [  3.03]( 9.52)     0.97 [  3.03]( 4.82)     1.00 [ -0.00](26.93)     0.97 [  3.03](14.53)     0.82 [ 18.18](13.87)
     4     1.00 [ -0.00]( 9.35)     0.97 [  3.12](18.25)     0.94 [  6.25]( 9.12)     1.00 [ -0.00](20.82)     1.00 [ -0.00]( 4.82)     0.88 [ 12.50](15.93)
     8     1.00 [ -0.00](23.38)     0.94 [  6.45](23.26)     1.26 [-25.81](14.43)     1.26 [-25.81](26.13)     1.06 [ -6.45]( 4.68)     0.97 [  3.23](10.00)
    16     1.00 [ -0.00]( 2.71)     1.04 [ -3.57]( 2.62)     1.00 [ -0.00]( 2.04)     0.98 [  1.79]( 2.76)     1.04 [ -3.57]( 0.00)     1.02 [ -1.79]( 2.70)
    32     1.00 [ -0.00]( 0.72)     1.00 [ -0.00]( 0.72)     0.96 [  3.75]( 1.30)     1.01 [ -1.25]( 0.71)     1.01 [ -1.25]( 1.88)     1.02 [ -2.50]( 1.86)
    64     1.00 [ -0.00]( 1.52)     0.96 [  4.41]( 1.18)     0.97 [  2.94]( 4.49)     0.94 [  5.88]( 1.19)     0.95 [  5.15]( 0.45)     0.96 [  4.41]( 0.45)
   128     1.00 [ -0.00]( 3.24)     0.96 [  3.80]( 0.91)     0.96 [  3.80]( 1.53)     0.95 [  4.64]( 0.26)     0.96 [  3.80]( 0.44)     0.97 [  2.53]( 1.32)
   256     1.00 [ -0.00]( 0.90)     0.92 [  7.60]( 0.75)     0.95 [  5.40]( 0.61)     0.92 [  7.80]( 0.55)     0.93 [  6.60]( 6.23)     1.00 [ -0.00]( 0.61)
   512     1.00 [ -0.00]( 1.76)     1.10 [-10.36]( 0.48)     1.04 [ -4.15]( 1.46)     0.97 [  3.45]( 7.07)     1.07 [ -6.56]( 2.54)     0.93 [  6.56]( 2.45)
   768     1.00 [ -0.00]( 2.79)     0.95 [  5.10]( 6.65)     1.71 [-70.87]( 4.67)     0.80 [ 20.13]( 1.81)     0.78 [ 21.80]( 1.19)     0.78 [ 22.36]( 1.46)
  1024     1.00 [ -0.00]( 0.86)     0.35 [ 64.79](18.07)     1.16 [-15.56]( 1.17)     1.00 [  0.32]( 3.65)     0.95 [  4.54]( 3.10)     0.90 [  9.72]( 2.33)
  
  
  ==================================================================
  Test          : new-schbench-requests-per-second
  Units         : Normalized Requests per second
  Interpretation: Higher is better
  Statistic     : Median
  ==================================================================
  #workers:  tip[pct imp](CV)          up[pct imp](CV)         smp[pct imp](CV)         max[pct imp](CV)       concur[pct imp](CV)       tasks[pct imp](CV)
     1     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [ -0.30]( 0.00)     1.00 [ -0.30]( 0.31)     0.99 [ -0.59]( 0.15)     1.00 [  0.00]( 0.00)
     2     1.00 [  0.00]( 0.00)     1.00 [  0.30]( 0.00)     1.00 [  0.00]( 0.61)     1.00 [  0.30]( 0.15)     1.00 [ -0.30]( 0.70)     1.00 [  0.00]( 0.61)
     4     1.00 [  0.00]( 0.00)     1.00 [  0.29]( 0.30)     1.00 [  0.00]( 0.15)     1.00 [  0.29]( 0.00)     1.00 [ -0.29]( 0.15)     0.99 [ -0.59]( 0.31)
     8     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [ -0.29]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [ -0.29]( 0.00)     1.00 [ -0.29]( 0.15)
    16     1.00 [  0.00]( 0.00)     1.00 [  0.29]( 0.15)     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)     1.00 [ -0.29]( 0.00)     1.00 [ -0.29]( 0.15)
    32     1.00 [  0.00]( 0.15)     1.00 [  0.29]( 0.15)     1.00 [  0.29]( 0.15)     1.00 [  0.29]( 0.00)     1.00 [  0.00]( 0.15)     1.00 [  0.29]( 0.15)
    64     1.00 [  0.00]( 0.15)     1.00 [  0.29]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [  0.29]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [  0.29]( 0.15)
   128     1.00 [  0.00](17.05)     1.01 [  0.59](14.45)     1.00 [  0.30]( 0.00)     1.01 [  0.59](10.49)     1.00 [  0.00]( 9.79)     1.00 [  0.30]( 0.31)
   256     1.00 [  0.00]( 0.59)     1.00 [  0.28]( 0.59)     1.00 [  0.28]( 0.44)     1.00 [ -0.28]( 0.82)     0.99 [ -0.57]( 0.39)     1.00 [  0.00]( 0.67)
   512     1.00 [  0.00]( 0.69)     1.01 [  1.50]( 1.66)     1.00 [  0.00]( 0.33)     0.99 [ -1.50]( 0.39)     0.99 [ -1.12]( 0.58)     1.00 [  0.00]( 0.78)
   768     1.00 [  0.00]( 1.13)     1.12 [ 11.51]( 9.06)     0.99 [ -1.15]( 0.21)     0.91 [ -8.52]( 0.47)     0.91 [ -8.98]( 0.47)     0.93 [ -6.67]( 0.84)
  1024     1.00 [  0.00]( 1.23)     1.12 [ 12.41]( 4.32)     1.01 [  1.10]( 0.71)     0.87 [-13.24]( 0.59)     0.87 [-12.97]( 0.49)     0.86 [-14.07]( 0.00)
  
  
  ==================================================================
  Test          : new-schbench-wakeup-latency
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:  tip[pct imp](CV)          up[pct imp](CV)         smp[pct imp](CV)         max[pct imp](CV)        concur[pct imp](CV)      tasks[pct imp](CV)
     1     1.00 [ -0.00](21.48)     2.75 [-175.00](14.06)    3.00 [-200.00](12.91)    3.62 [-262.50](29.64)    3.62 [-262.50](21.84)    2.25 [-125.00](12.45)
     2     1.00 [ -0.00]( 5.96)     1.33 [-33.33](24.78)     1.33 [-33.33](18.25)     1.11 [-11.11](25.37)     1.11 [-11.11]( 9.68)     1.11 [-11.11]( 5.00)
     4     1.00 [ -0.00]( 6.20)     1.38 [-37.50]( 4.84)     1.12 [-12.50]( 0.00)     1.25 [-25.00](21.51)     1.12 [-12.50](19.99)     1.38 [-37.50](12.81)
     8     1.00 [ -0.00]( 5.34)     1.20 [-20.00]( 0.00)     1.00 [ -0.00]( 5.00)     1.20 [-20.00]( 7.45)     1.20 [-20.00]( 0.00)     1.20 [-20.00]( 4.19)
    16     1.00 [ -0.00]( 5.53)     1.22 [-22.22]( 0.00)     1.11 [-11.11]( 0.00)     1.11 [-11.11]( 9.68)     1.33 [-33.33]( 0.00)     1.33 [-33.33]( 4.43)
    32     1.00 [ -0.00]( 5.53)     1.11 [-11.11]( 5.00)     1.00 [ -0.00]( 0.00)     1.11 [-11.11]( 5.00)     1.11 [-11.11]( 0.00)     1.11 [-11.11]( 0.00)
    64     1.00 [ -0.00](12.81)     1.00 [ -0.00]( 0.00)     0.91 [  9.09]( 5.34)     0.91 [  9.09]( 5.00)     0.91 [  9.09]( 5.00)     0.82 [ 18.18](10.68)
   128     1.00 [ -0.00](12.14)     1.12 [-12.50]( 4.97)     0.81 [ 18.75](13.62)     1.06 [ -6.25]( 5.26)     0.94 [  6.25](14.68)     0.81 [ 18.75]( 6.88)
   256     1.00 [ -0.00]( 4.83)     0.98 [  1.90]( 7.97)     0.98 [  2.37]( 2.41)     0.95 [  4.74]( 5.31)     0.95 [  5.21]( 3.25)     0.97 [  2.84]( 2.84)
   512     1.00 [ -0.00]( 0.00)     0.98 [  2.00]( 5.86)     0.96 [  3.99]( 1.61)     0.83 [ 16.83]( 1.08)     0.85 [ 14.84]( 7.53)     0.97 [  3.42]( 7.91)
   768     1.00 [ -0.00]( 0.71)     0.96 [  3.63](14.27)     0.96 [  3.73]( 1.19)     0.67 [ 32.98]( 0.00)     0.67 [ 32.98]( 0.00)     0.67 [ 32.98]( 0.15)
  1024     1.00 [ -0.00]( 2.55)     0.85 [ 14.99](14.23)     0.98 [  1.80]( 0.82)     0.79 [ 21.29]( 0.00)     0.79 [ 21.29]( 0.00)     0.79 [ 21.29]( 0.00)
  
  
  ==================================================================
  Test          : new-schbench-request-latency
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:  tip[pct imp](CV)          up[pct imp](CV)         smp[pct imp](CV)         max[pct imp](CV)       concur[pct imp](CV)       tasks[pct imp](CV)
     1     1.00 [ -0.00]( 0.14)     1.00 [ -0.00]( 0.00)     1.00 [ -0.00]( 0.14)     1.00 [ -0.26]( 0.27)     1.01 [ -0.53]( 0.27)     1.00 [ -0.00]( 0.14)
     2     1.00 [ -0.00]( 0.00)     1.00 [  0.26]( 0.14)     1.02 [ -2.36]( 1.51)     0.99 [  0.52]( 0.14)     1.00 [ -0.00]( 2.00)     1.00 [ -0.00]( 1.74)
     4     1.00 [ -0.00]( 0.00)     1.00 [  0.26]( 1.82)     1.03 [ -2.63]( 0.23)     0.99 [  0.53]( 0.14)     1.00 [ -0.26]( 1.61)     1.03 [ -3.42]( 1.79)
     8     1.00 [ -0.00]( 0.14)     0.99 [  0.79]( 0.00)     1.00 [ -0.00]( 0.00)     0.99 [  1.05]( 0.14)     1.00 [ -0.00]( 0.00)     1.00 [ -0.00]( 0.00)
    16     1.00 [ -0.00]( 0.14)     1.00 [ -0.00]( 1.16)     1.00 [ -0.26]( 1.28)     0.99 [  0.79]( 1.97)     1.00 [ -0.26]( 0.00)     1.02 [ -2.38]( 1.15)
    32     1.00 [ -0.00]( 0.23)     0.99 [  1.04]( 0.24)     1.00 [ -0.00]( 0.67)     0.99 [  1.04]( 0.14)     0.99 [  0.52]( 0.49)     0.99 [  1.30]( 0.95)
    64     1.00 [ -0.00](12.39)     1.72 [-71.69](26.18)     1.01 [ -1.29](28.90)     0.97 [  3.09]( 0.27)     0.98 [  2.06]( 0.41)     0.98 [  2.32]( 1.22)
   128     1.00 [ -0.00]( 4.75)     0.98 [  2.07](12.01)     0.99 [  0.59]( 0.41)     1.00 [  0.30]( 3.02)     1.00 [ -0.00]( 2.72)     0.99 [  0.59]( 0.77)
   256     1.00 [ -0.00]( 0.13)     0.99 [  0.76]( 0.13)     1.00 [ -0.00]( 0.13)     0.99 [  0.76]( 0.00)     0.99 [  0.51]( 0.13)     0.99 [  0.51]( 0.13)
   512     1.00 [ -0.00]( 7.49)     1.04 [ -4.36](28.15)     0.89 [ 10.50]( 4.15)     0.42 [ 57.93]( 9.03)     0.48 [ 52.23](25.18)     0.71 [ 28.83](25.82)
   768     1.00 [ -0.00]( 3.13)     1.31 [-31.19](10.91)     1.10 [-10.13]( 1.12)     0.71 [ 28.69]( 3.69)     0.70 [ 29.59]( 3.58)     0.84 [ 15.65]( 4.74)
  1024     1.00 [ -0.00]( 2.28)     1.44 [-44.48](16.05)     1.13 [-13.09]( 0.88)     0.85 [ 15.39]( 6.64)     0.85 [ 15.03]( 0.39)     0.81 [ 19.39]( 1.36)
---

DeathStarBench was run on a 3rd Generation EPYC system (2 x 64C/128T)
with boost enabled and C2 disabled:

  ==================================================================
  Test          : DeathStarBench
  Units         : %diff compared to tip
  Interpretation: Higher is better
  Statistic     : Average throughput
  ==================================================================

  Scaling\cg_mode    up      smp      max    concur    tasks
      2x            1.63%  -0.32%   -0.03%   -0.65%    0.62%
      4x           -4.94%   1.38%   -6.59%    1.09%   -6.11%
      6x            1.83%   0.16%   -0.87%    2.24%   -0.23%

---

I'll get to look any deeper into any of the regressions until Thursday
but overall the concur mode seems good in my testing for most part.

-- 
Thanks and Regards,
Prateek


