Return-Path: <cgroups+bounces-12437-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606FCC8E5E
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7FBB3037EB8
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFA3469FD;
	Wed, 17 Dec 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D09KqzWr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CC296BDB;
	Wed, 17 Dec 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989969; cv=none; b=M0ZdGKSJLisMdwlScyt8lK2EcK0l/MCM56XoDkaSHWOqRH6igYepv9Pi5UK0QTk/gABGIHw0BmH3zWPaoNlodn+FRinU09NPgc6FQ1RqV2eZk+7hG/GJw+A0L3wxD6Rk468lVIjVQkV46TgiE3AbniNm0c/7w0U2PlnGt7k8vcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989969; c=relaxed/simple;
	bh=TfiL+YyeKmFoynl0bRC4SawBPG7DFwpDo0DPvqK6eMQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jo0nHH1oMdADvsBYSB70z4EMOhJLiGsuU38vRihxpDS1BdjzlAh9u4++ew+YLKCiZUfWW0mKv4B3JZLyhcTw89TzRRvGveBgv/7Z6ox3tZBOdUQ68PDr9CVoYxBVrBjrLmLPdRG08PsjJ6/HpodlOWd0K5e0mdyyboSKzUR81CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D09KqzWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4465C4CEF5;
	Wed, 17 Dec 2025 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765989969;
	bh=TfiL+YyeKmFoynl0bRC4SawBPG7DFwpDo0DPvqK6eMQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=D09KqzWrvKJWbZtyJZfpdNvwSV8Wxqn0ENfqMvdu+thh7btC0yKSXk6YcelOxyLWQ
	 yynziDADrIn+1VdibU0RIp0gwAhqdGgjH3pIFMGZC+axZNZhWJ4T5ixywVAuK1uPOq
	 UvXnagFbW4B8AcR1rPw65039+kzy4ObQDLiTmUaLlnuyC7AXjcPnto1EP/6TeYm+d7
	 sB5SKINRe1jAvG2wbqh4kLjuslC8E8OpvR2Prvobq+ApZp8sJsaBNlVFChkybKpwts
	 iXM2zZLDi/ihWeKzxgNtGoLgMU70hSBTe7UGVVLWvPxeJ/iteDxmZ2DbBltqD5E6R1
	 uRuvWrQCSkx2A==
Content-Type: multipart/mixed; boundary="===============5419417971734705650=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dde17339701c8159c58f57d58e5e815b39d7bb22b8ea96ba1f63cfd1a25b94ce@mail.kernel.org>
In-Reply-To: <20251217162744.352391-3-mkoutny@suse.com>
References: <20251217162744.352391-3-mkoutny@suse.com>
Subject: Re: [PATCH 2/4] cgroup: Introduce cgroup_level() helper
From: bot+bpf-ci@kernel.org
To: mkoutny@suse.com,linux-block@vger.kernel.org,linux-kernel@vger.kernel.org,cgroups@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,netfilter-devel@vger.kernel.org,coreteam@netfilter.org,netdev@vger.kernel.org
Cc: mkoutny@suse.com,yukuai@fnnas.com,axboe@kernel.dk,tj@kernel.org,josef@toxicpanda.com,hannes@cmpxchg.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,pablo@netfilter.org,kadlec@netfilter.org,fw@strlen.de,phil@nwl.cc,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 17 Dec 2025 16:46:08 +0000 (UTC)

--===============5419417971734705650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index a0416927d33d..b4eebe61dca7 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c

[ ... ]

> @@ -3003,7 +3003,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
>  	init_waitqueue_head(&iocg->waitq);
>  	hrtimer_setup(&iocg->waitq_timer, iocg_waitq_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>
> -	iocg->level = blkg->blkcg->css.cgroup->level;
> +	iocg->level = cgroup_level(blkg->blkcg->css.cgroup)
                                                              ^
Is this missing a semicolon? The line should end with a semicolon to
make this valid C syntax. This will prevent the kernel from building
in the ioc_pd_init() function.

>
>  	for (tblkg = blkg; tblkg; tblkg = tblkg->parent) {
>  		struct ioc_gq *tiocg = blkg_to_iocg(tblkg);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20310204023

--===============5419417971734705650==--

