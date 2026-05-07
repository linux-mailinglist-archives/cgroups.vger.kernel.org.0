Return-Path: <cgroups+bounces-15662-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPfHMyij/Gn2SAAAu9opvQ
	(envelope-from <cgroups+bounces-15662-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 16:35:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA23F4EA477
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91C313017383
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E90402BBC;
	Thu,  7 May 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="ouY0OKaY"
X-Original-To: cgroups@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021133.outbound.protection.outlook.com [40.107.130.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316B3ED5D9;
	Thu,  7 May 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164279; cv=fail; b=VYOnzhT/VUlXBzi1hSRDaTA8JukzIXeGdMzJr6GnahLk7ZFk6q9/0XxYa8wRR4nOIeoK/0EhmGYfRgFt+L98Yla5hbd6fyYQO+GrEoUf3DmXcwNI6sH0IHI+5MKts+1+p0MQbAQ55JpoSwZmFg1bPVFbTTBj5Voi0+4iSft+Ol4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164279; c=relaxed/simple;
	bh=ZJMqSOWiZ7oWsD//26cv7NYkNbNZ1seJwyyYNwZFM58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oy6Pcp/qXLlHaPY1jLYxCtUKhezBz4/D3zOf7CUzZwfkS1dOtFHJAPnVcFdyz6VIS8aESNmJ1MIFhGAPNc2Owv+y9ivi0LazDZQef/5f6BHos75QV4HcVcn0kL9IwkVEBORSR3V+cS4JX/n5DrqEK/seP3llU2pPE3TbwzsP4dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=ouY0OKaY; arc=fail smtp.client-ip=40.107.130.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxb8RUg4r6VWn5frYzMj7IM86HnxMMfbhX7sp0kyQF93sWRZxRCus2mWJzhsjQBgCr62mt6XgLzLtpIPOXAyu5lcI9UWbhmmfGm7P2SMF775PIMszGd74boV1eNkQ51RlM7QSLBMv39RdY5Gtj+40AzSjfSYh0W0Wojwtiv1x9tQjDqa+FlHP4f7pKDMGiemBvvRNOU1QTOX4PvGBs0zSeIYSwOyA7EVllc2kp+xNn1BYTbPUtbGggdL3584HHLH+01Zv3zfkyFdXFVXWfXlzjEVfs5ZKHOBaFo+tgy+VmEgunX58piBNb0AZkXG2MxTCwyYEcIR9ZvxHsWWLcuCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4HjBlbNndBALW+dUlOxW7hRCEehStgzyE9I5pgrhwU=;
 b=CZRVpY7f34iWdjm36N+yX4GhRtoCcumEK1R5F+cT9qvPYj52kJ37GhEWxbrkRM0U0rlsbSH+HtmPVknN/0F+qKxyR5hjt+V8Y05UkCwqA1XsaajTykHpbNYvf5R4LQoNI29QkHDjlxuFxZN4QEgJl19j1YaoPQBTuluyO7dnlH4eiofs5Me/0mfnumLDK0alHTZRHHONBRnNYKbwPshvx1DUJFh521DwKQx85QVqLnnHJpXA4WL5ETVsQb4LtUt/wevG3ObdKdI5B81Jl230fRI/8wjukSmmr+eUWac1VjvIJEdQFCp9g9oSdnyfOobe9EMsTGLPVVFTLxwu+DWxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4HjBlbNndBALW+dUlOxW7hRCEehStgzyE9I5pgrhwU=;
 b=ouY0OKaYakX9tKbcjcUTaI2iwkD+3EzvORI/kWIpN96TTWdRHfo4sxjktGCxWIUJkzx1tIOiWbLojUDgLKLS2Xtu21/R36qIWJlTDrk1fxviFMwcJiQZA7F3CzqQbb7BZLahYs2rd6ULm9Uq09AzoS/2hETWO9Ix+S5UedImvL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by PA1PR03MB10673.eurprd03.prod.outlook.com (2603:10a6:102:482::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 14:31:12 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 14:31:12 +0000
Date: Thu, 7 May 2026 16:30:58 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Yuri Andriaccio
 <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Yuri Andriaccio
 <yuri.andriaccio@santannapisa.it>, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies
 of RT cgroups
Message-ID: <20260507163058.2c435922@nowhere>
In-Reply-To: <afpLir8tD0Ycb3D8@slm.duckdns.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
	<20260430213835.62217-21-yurand2000@gmail.com>
	<20260505151523.GF3102624@noisy.programming.kicks-ass.net>
	<afpLir8tD0Ycb3D8@slm.duckdns.org>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|PA1PR03MB10673:EE_
X-MS-Office365-Filtering-Correlation-Id: 72744339-08a7-483c-ff48-08deac454961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|786006|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mzIK+ZdWLBKko2ZrNOMWhSMqwLWn/0/oB6iO+5zbZAaEFi1PR5pcSZUUXdiii59mjFItMC9eYoisa4SuTFrbahxiBBMBfG/djl2VOOlso3whSiRScAQVPxWA2cgdEe001XDA4GyFFGDW4YrHOt7PIA713mv1gLKyRk+hY8rmVVAW15EZeAPXwDSkGjaka1jIVyIvB5ilt6pTF08ovh8mep0uiVsi2y3fG1usNeKt96bNBlcuRDbkxPjdbfmj+d6goZwwXeXz3VrihViU3/UOiY2yPgmRD0yMkZw8V4UEXzxAu9H/6KlSeXzfTszAtsVf+3q1iEINB6HWl2DvLmDban6xEurGlVbOtLF1YE+2EGUdZx5BfeVz+xTbgBJyULlm2PjngcW4T8OlHTF9JZUqz1AZmSgtgDCG07Z1FEimUCQVlS+U2abeuhysVpUe4AVszICq4I9KjukDwZZkLQDwLnr5vqQj8pyqoR95rpAf6twY0nNm1NgRHW6LcFIOU22P7kH2Nv/OZinWNP6iSZK3sL1hhRI9X40CVLsu1d1g+quv3lzBhnmRvod73vA9fV2zAkZajVZH5buGp1iyVgr46rNre2hR3utXo5vXHByIk2xDQQMwBJ60BvhYlaJ6tclQuDuDfHmcU4/NQxuRW95Nz7kW25GiL1IIQcuFLpZK+85/nmHfX0a4TZeT02Hnp677
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(786006)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5QDICSY8hoUp/I2c7pdoOixYCijbtXbdR5WMDE8ClIKgzcw18P40cCApELh?=
 =?us-ascii?Q?KgIkugufDn76BV4QiUq9lksZPy9EM9iFha1UggQSnhhv44PZJg9FiHUISXj0?=
 =?us-ascii?Q?WOfyhM4Kwzh6LPfdb10UWf59DnkSc0qm4wdFBur9Kp/tWOC81bGktiAUetGX?=
 =?us-ascii?Q?wt6MErFRfKR0r9SLvN2L07ieTfgh8Kx/IsgTRoTrJTSrwQOkdJCOOvOqdmRG?=
 =?us-ascii?Q?wSV02j83g7MTVQKfWGylBP0OJhFs9jA5kPblZKeQyzcbLGthp/HjoN0/D8dl?=
 =?us-ascii?Q?gOYbj8EJKW9DITwH0zYro/1NhQzxrLXT9XUXsRguDq3JVsZ1+RPGLhCZzJXb?=
 =?us-ascii?Q?1vNVmMkmXjXRqIP6M+XSOBT+9DWYnc4IM07rUMFKrXaZf+iTaUyD8sG7upMH?=
 =?us-ascii?Q?D8Yz6z0xpdw7OD5BeHZYXg8ZpMwFJ4N9Fs+7gSfxwP7jjHogMBTghOqoovir?=
 =?us-ascii?Q?QT1atrOzAcFURQgv64soD8aXyeZMlK4O9WkD4ydDhBOs1R90QLeovNDCvWVJ?=
 =?us-ascii?Q?PDNh1Bk4z1GyP0q7edQUa5VXDMHHF2eE4jUvUWOwWQIuKkxJaf76YkTe+1cC?=
 =?us-ascii?Q?soYf79SISMXE6a8K8z8Dqt8bxgJMbm2F28KPrDBvtf3P4qHKjeAKsFf1z2hi?=
 =?us-ascii?Q?oRnlT/v0h1ICtNr7KG8nSyIic1w58nB9FACrnjUNB8w07NWv8LyQsC2dRFRQ?=
 =?us-ascii?Q?5n+JMYwYYywiMLsesGMjPp8PPBNAoz1gLwKzLVO1M8Gnyw/oGMeZFwAJ8nXt?=
 =?us-ascii?Q?f8IYtHy6hLUdID27hEtefmfWhAftF3QUXisM7QNzW/VYPAgNn7g5dVPLtDqO?=
 =?us-ascii?Q?nyi+KFNLqqe/qkx1nwTN/bGJ3Q5rNiiUZKUtTtxhLxJNisZSns+LlAj0rIkD?=
 =?us-ascii?Q?7k6OiHEaOhLiQGrZl4rWx/LsQILJQFyq9mkkQUvLni4tnHHlqGlVe94puEEe?=
 =?us-ascii?Q?xccUPlgJW1QfA4yZjIqS+OYRlUQRHRC5ZEd/ixSq7tkNqv/TtwD2gD+N0a+I?=
 =?us-ascii?Q?3Xo1/MbsKRR+9cC4R9D7k6c7ONrspJx1dswyTCCKLuylp2bX9Nz7Gr7Z30va?=
 =?us-ascii?Q?qSRSxWIDh8DReWP9SWIa1FbyRKhF/wvXBT8b2wx9zk7V5TdQ3W3UE5rH5S+j?=
 =?us-ascii?Q?40jL4tChdON8+xRzdghObBNDIqXFe2XebsTNlSumy9sr6WW0WAbPhHjKhsuH?=
 =?us-ascii?Q?bmhGqVWjop4mfaBLYq0dQavqg/Vj1fThSPFWVaDDgWHvakbkhGakk79+gP0g?=
 =?us-ascii?Q?hSS4p04Jt2ykGoWykfI+R6CqGjWtUE2Ql9gmD0IOCLyLgRRSepBFR4gH20am?=
 =?us-ascii?Q?ttvt68ZsdGiSvZYKJG4+RaOrIC8Yc517D5lw+LIGo5pr5QhxqlFgBgJ82dCd?=
 =?us-ascii?Q?I2nMUTVYoHr5ZbSoKBhQfmbTG+SjfvEdyAgM18p+Z93vvrvmifrRRtLKNTpR?=
 =?us-ascii?Q?Vbl1DKkMNJPSHwAXBR4rXeEW8CF8i878uVSgvBIf7/qfAr/NxrVsHTvJaH0P?=
 =?us-ascii?Q?+mfONLjUAQsXjH1DF0P6qzXoSzUc+rxuicK3HhLRbn8jJ4fXGKFN33z/Dwm+?=
 =?us-ascii?Q?A1O+hXtoyYILjyj9JnNNTbqGeD70rOATisa2cQAohaZBg6it6jS8cQ2mxSjm?=
 =?us-ascii?Q?Hz5H5okcoD3EUHOoBOelN3JSL03N1jtiRhp21tIt3dNcFhQ3r32tAb7iditt?=
 =?us-ascii?Q?+TBxuYyMpB5a4SscXzIWNZ7/DQhPJ0Y15sHx+0Yeud6c/QPj/yLNC/ZGEa9r?=
 =?us-ascii?Q?dFirhMkqubT7ZfCn/hGytlV/9yCnsWv52kJHn26HeGkV/+xyOauoflL4CKiX?=
X-MS-Exchange-AntiSpam-MessageData-1: w/P5dp3vf1yFf6ie40T5zMEhHxzBLh6MXjQ=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 72744339-08a7-483c-ff48-08deac454961
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:31:11.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4hP4uK/1Jd5Qw8e827BklQHFirVhKpkC/a+BbzpnhUfDJjkG3fgBnRH09LwwPjmeehLWRXX7sWPlf8hveTQcang4yFYCM+ewIMMm2NjVj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR03MB10673
X-Rspamd-Queue-Id: CA23F4EA477
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15662-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.abeni@santannapisa.it,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[santannapisa.it:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Tejun,

first of all, thanks for your comments! I think this is the kind of
dicussion that we need to have...
Right now we have something that works "well enough" for real-time, but
we want to make it useful in general, so that distributions will not
disable it by default.

I need to better study your suggestions (I do not know cgroup v2
much...), but I have some questions to better understand possible
solutions:

On Tue, 5 May 2026 09:56:58 -1000
Tejun Heo <tj@kernel.org> wrote:
[...]
> - cgroup2 enforces that internal cgroups w/ controllers enabled
> cannot have threads in them. No need to enforce that separately.
> 
> - However, the cpu controller is a threaded controller which means
> that it can have threaded sub-hierarchy where the no-internal-process
> rule doesn't apply. This was created explicitly for cpu controller.
> The proposed change blocks it effectively forcing cpu controller into
> regular domain controller behavior subject to no-internal-process
> rule. Note these are enforced at controller granularity and this
> means that users who use the threaded mode will be forced to pick
> between the two.

Just to better understand: would it make sense to allow non-{FIFO,RT}
tasks to be in non-leaf cgroups (as allowed by the threaded CPU
controller), while enforcing that FIFO/RR tasks can only be in leaf
cgroups? Or would this be a hack that compromises the rt-CPU controller
usefulness?


> - This has the same problem with cgroup1's rt cgroup sched support
> where there is no way to have a permissive default configuration,
> which means that users who don't really care about distributing rt
> shares hierarchically would get blocked from running rt processes by
> default, which basically forces distros to disable rt cgroup sched
> support. This is not new but it'd be a shame to put in all the work
> and the end result is that most people don't even have access to the
> feature.

Yes, we have a bad default here.
Would a default like "allow running FIFO/RR tasks without runtime
enforcement" (this is what happens to FIFO/RR tasks running in the root
control group) be acceptable?


			Thanks,
				Luca

> 
> Here's my suggestion if there is desire for this to become something
> most people have easy access to:
> 
> - Don't make it impossible to use in conjunction with other resource
> control mechanisms especially not CPU controller itself. Don't force
> people to choose between threaded mode and rt control. Allow them to
> co-exist in a reasonable manner.
> 
> - The same in the wider scope. Don't let it get in the way of people
> who don't care about it. Compromising on interface / failure mode is
> better than people not being able to use it in most cases.
> 
> Thanks.
> 


