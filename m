Return-Path: <cgroups+bounces-894-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0574808EE9
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 18:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859C1280E7E
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6484AF6F;
	Thu,  7 Dec 2023 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkaEaSF3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B01712
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701970838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMnbB7T1LQp0wZWytMfSaP8EVvp37hw/oAE/reqSj0w=;
	b=CkaEaSF3nGO92pR76P6f7OLaE4OmfpM5CzP8IeVDPX41hL7YaPYXo71s38CpZ5GX5CSsb5
	YJ/9kmtlIeCb/RXZZyUCI5l/L3ILcAbIj5JVQN0/P+sUqiLQ+oeQiPnoMcmQ4bE09y0Hty
	HuqXIwwPSGIm07pbd+kIyYrzfdFPSkw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-buOtMp_5M4CzKtPTlcRHWw-1; Thu,
 07 Dec 2023 12:40:35 -0500
X-MC-Unique: buOtMp_5M4CzKtPTlcRHWw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E5CB1C05EB5;
	Thu,  7 Dec 2023 17:40:34 +0000 (UTC)
Received: from [10.22.32.209] (unknown [10.22.32.209])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EA010492BC6;
	Thu,  7 Dec 2023 17:40:33 +0000 (UTC)
Message-ID: <5c35f648-88cc-4de2-91d7-fb95ceae15b9@redhat.com>
Date: Thu, 7 Dec 2023 12:40:33 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of
 cgroup_root
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yafang Shao <laoar.shao@gmail.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Yosry Ahmed <yosryahmed@google.com>
References: <20231207134614.882991-1-longman@redhat.com>
 <65h3s447i3fkygdtilucda2q6uaygtzfpxb6vsjgwoeybwwgtw@6ahmtj47ggzh>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <65h3s447i3fkygdtilucda2q6uaygtzfpxb6vsjgwoeybwwgtw@6ahmtj47ggzh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 12/7/23 11:46, Michal Koutný wrote:
> On Thu, Dec 07, 2023 at 08:46:14AM -0500, Waiman Long <longman@redhat.com> wrote:
>> Commit 77070eeb8821 ("cgroup: Avoid false cacheline sharing of read
>> mostly rstat_cpu") happens to be the last straw that breaks it.
> FTR, when I build kernel from that commit, I can see
>
>> struct cgroup_root {
>> 	struct kernfs_root *       kf_root;              /*     0     8 */
>> 	unsigned int               subsys_mask;          /*     8     4 */
>> 	int                        hierarchy_id;         /*    12     4 */
>>
>> 	/* XXX 48 bytes hole, try to pack */
>>
>> 	/* --- cacheline 1 boundary (64 bytes) --- */
>> 	struct cgroup              cgrp __attribute__((__aligned__(64))); /*    64  2368 */
>>
>> 	/* XXX last struct has 8 bytes of padding */
>>
>> 	/* --- cacheline 38 boundary (2432 bytes) --- */
>> 	struct cgroup *            cgrp_ancestor_storage; /*  2432     8 */
>> 	atomic_t                   nr_cgrps;             /*  2440     4 */
>>
>> 	/* XXX 4 bytes hole, try to pack */
>>
>> 	struct list_head           root_list;            /*  2448    16 */
>> 	struct callback_head       rcu __attribute__((__aligned__(8))); /*  2464    16 */
>> 	unsigned int               flags;                /*  2480     4 */
>> 	char                       release_agent_path[4096]; /*  2484  4096 */
>> 	/* --- cacheline 102 boundary (6528 bytes) was 52 bytes ago --- */
>> 	char                       name[64];             /*  6580    64 */
>>
>> 	/* size: 6656, cachelines: 104, members: 11 */
>> 	/* sum members: 6592, holes: 2, sum holes: 52 */
>> 	/* padding: 12 */
>> 	/* paddings: 1, sum paddings: 8 */
>> 	/* forced alignments: 2, forced holes: 1, sum forced holes: 48 */
>> } __attribute__((__aligned__(64)));
> 2480 has still quite a reserve below 4096. (I can't see an CONFIG_*
> affecting this.)
>
> Perhaps, I missed something from the linux-next merging thread?

CONFIG_LOCKDEP and some other debug configs are enabled with 
allmodconfig. This can greatly increase the size of some of the 
structures. I am not able to use pahole due to missing BTF info so I 
don't the exact size. However, I can reproduce the build failure and the 
patch is  able to fix it.

Cheers,
Longman


