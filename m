Return-Path: <cgroups+bounces-6056-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2402FA0210B
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 09:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DE17A06DC
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83901D63FD;
	Mon,  6 Jan 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="taYyu+78";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T850A2Nq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yTKeAaP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4iJa5KHa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B531D79A9;
	Mon,  6 Jan 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736153157; cv=none; b=MFI+/KMJNIedChi8/zY4FXzvUYHNKorzYp1BQkCLPNpaVqnM9tWDjfLG1TDTiV4Y0iy8LgUgn64iDi8wJPBRm/sFe7rXb2YML0Zv5gQMydDI/+yJLBOQoXaBDb3YN28dJUPP59NIWcYMrtlQnYWOgz4GR/Ef81DykcgbFvbCF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736153157; c=relaxed/simple;
	bh=f8oKskr2lqOfA5GWBWO7bfkXy9cxLL8a5PV2VMOAHZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+tSSje3DjGNlqftxyD10x/SFie644vi3D5vfCWbDdMnddfUcYTvTC8+L5bx8xCw45MAl0W9JDBmwEMWlwj9KDAHINKZ1xQvcHt9MDtbT6TAZCbhV+5UQnKJ6y7K0EBOn5bMUgEayRyfJLXAHLhmmrbBOUuh5VuZtjbGtaplJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=taYyu+78; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T850A2Nq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yTKeAaP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4iJa5KHa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D67DE21161;
	Mon,  6 Jan 2025 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736153153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8unrTvKae6m1mp7QwRwUZgVhor5hVomY1M8CRyhx1+4=;
	b=taYyu+78nxoy1hBhtbsfzYwd1apDoVWptqLd9jL/ejhlPz5WjIT4oD+puSslPf3FhMHWXm
	OCtFoBiVf+jrDBwMeHaa4R5HGNLN3ECufho6AurtKVUl/IQIzy4RmUFE5+cYlhD5L//KcE
	nKy3PHhVFUG2IWgYSkfkvLSkYeGtdO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736153153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8unrTvKae6m1mp7QwRwUZgVhor5hVomY1M8CRyhx1+4=;
	b=T850A2NqzVzxD/inszYRD1cAzHEBLJ0JmybNcTdy37P8qcWXoP3Xzet4w3PkbsUKvO51Xe
	wI8oWwiNf8mK8IDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0yTKeAaP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4iJa5KHa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736153152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8unrTvKae6m1mp7QwRwUZgVhor5hVomY1M8CRyhx1+4=;
	b=0yTKeAaPuMt7aMZVg/9RvSJv8l2+JoBrK6KVp/9pWoW+8DQe2UsgFH+LZo8j3wLmm8dQyw
	GDe0xr99V3B9Nn9jCXK5kZk7bqZ8fVmEjePlGx+/jun3CGC1jW+Zeis7bVmPznZ0eMFl/g
	mRB2r2rqy/CP2V29yw8JO11cJmhS4xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736153152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8unrTvKae6m1mp7QwRwUZgVhor5hVomY1M8CRyhx1+4=;
	b=4iJa5KHa5G3udu4cYxTwrhisV3qDcqzgp9iKYP1HmNAOR1KCV1nBJqTtUQwANb1CyUR9MD
	SVvPUSSrU4UxLGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC94C137DA;
	Mon,  6 Jan 2025 08:45:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jYUVKUCYe2cBYwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 06 Jan 2025 08:45:52 +0000
Message-ID: <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
Date: Mon, 6 Jan 2025 09:45:52 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
To: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
 mhocko@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 davidf@vimeo.com, handai.szj@taobao.com, rientjes@google.com,
 kamezawa.hiroyu@jp.fujitsu.com, RCU <rcu@vger.kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241224025238.3768787-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D67DE21161
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12/24/24 03:52, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>

+CC RCU

> A soft lockup issue was found in the product with about 56,000 tasks were
> in the OOM cgroup, it was traversing them when the soft lockup was
> triggered.
> 
> watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [VM Thread:1503066]
> CPU: 2 PID: 1503066 Comm: VM Thread Kdump: loaded Tainted: G
> Hardware name: Huawei Cloud OpenStack Nova, BIOS
> RIP: 0010:console_unlock+0x343/0x540
> RSP: 0000:ffffb751447db9a0 EFLAGS: 00000247 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffffffff
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000247
> RBP: ffffffffafc71f90 R08: 0000000000000000 R09: 0000000000000040
> R10: 0000000000000080 R11: 0000000000000000 R12: ffffffffafc74bd0
> R13: ffffffffaf60a220 R14: 0000000000000247 R15: 0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2fe6ad91f0 CR3: 00000004b2076003 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  vprintk_emit+0x193/0x280
>  printk+0x52/0x6e
>  dump_task+0x114/0x130
>  mem_cgroup_scan_tasks+0x76/0x100
>  dump_header+0x1fe/0x210
>  oom_kill_process+0xd1/0x100
>  out_of_memory+0x125/0x570
>  mem_cgroup_out_of_memory+0xb5/0xd0
>  try_charge+0x720/0x770
>  mem_cgroup_try_charge+0x86/0x180
>  mem_cgroup_try_charge_delay+0x1c/0x40
>  do_anonymous_page+0xb5/0x390
>  handle_mm_fault+0xc4/0x1f0
> 
> This is because thousands of processes are in the OOM cgroup, it takes a
> long time to traverse all of them. As a result, this lead to soft lockup
> in the OOM process.
> 
> To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
> function per 1000 iterations. For global OOM, call
> 'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.
> 
> Fixes: 9cbb78bb3143 ("mm, memcg: introduce own oom handler to iterate only over its own threads")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/memcontrol.c | 7 ++++++-
>  mm/oom_kill.c   | 8 +++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 65fb5eee1466..46f8b372d212 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1161,6 +1161,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  {
>  	struct mem_cgroup *iter;
>  	int ret = 0;
> +	int i = 0;
>  
>  	BUG_ON(mem_cgroup_is_root(memcg));
>  
> @@ -1169,8 +1170,12 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  		struct task_struct *task;
>  
>  		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
> -		while (!ret && (task = css_task_iter_next(&it)))
> +		while (!ret && (task = css_task_iter_next(&it))) {
> +			/* Avoid potential softlockup warning */
> +			if ((++i & 1023) == 0)
> +				cond_resched();
>  			ret = fn(task, arg);
> +		}
>  		css_task_iter_end(&it);
>  		if (ret) {
>  			mem_cgroup_iter_break(memcg, iter);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1c485beb0b93..044ebab2c941 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -44,6 +44,7 @@
>  #include <linux/init.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/cred.h>
> +#include <linux/nmi.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>  	else {
>  		struct task_struct *p;
> +		int i = 0;
>  
>  		rcu_read_lock();
> -		for_each_process(p)
> +		for_each_process(p) {
> +			/* Avoid potential softlockup warning */
> +			if ((++i & 1023) == 0)
> +				touch_softlockup_watchdog();

This might suppress the soft lockup, but won't a rcu stall still be detected?

>  			dump_task(p, oc);
> +		}
>  		rcu_read_unlock();
>  	}
>  }


