Return-Path: <cgroups+bounces-14792-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMLnNf0Xs2mDSAAAu9opvQ
	(envelope-from <cgroups+bounces-14792-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 20:46:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E72627847F
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A418314A177
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A494014B9;
	Thu, 12 Mar 2026 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiSBuOvp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF93EF0A0
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344696; cv=none; b=hEpasOJj/X0WLGHCLX6dFlOq5UiWEubD3nU48uVGLXmdAkuI9wLv6Gr390ChBp3V2nWa76DeybgOh+ahAAPKerQLuj+ZdstHu93r56pYmv5DSkQ96iR+towSDLufklUi/bETT4BshvmD/nZ5uQr3p0nxntLLtr9sDc0eY/rozEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344696; c=relaxed/simple;
	bh=sAj8Yed2r+Sak4xBV7Az4WU3/Y5LNIoW4xEify6TVqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkvEtaiylsgDMlpFQ2azS1UZT/dJP+VtF2sw6vlKmQ1BG22Z9wpk6zEFseAaKztH0gxrLcXU1mjrFODwzMcZvMc9gqnZTDv+imsKo9dqURYAK52CZMyBGQF4Wz5vULO+DJVZ7Wa/XnTrIF3XIyv89Z4HloGte4Uk4Gtzv4m2CkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiSBuOvp; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-41708e43f61so554501fac.1
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773344694; x=1773949494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHoIsTG7IVfAzcG8vtVaG2KfMTAKD1Mf8pCRYcgobfc=;
        b=eiSBuOvpEZuAz4P0bTbCWhMmcDctLcgQPpNE4N0h4qEmm47jC0yEW8BmNVG7ES16sq
         YhIVkae8fqk5kCqUnya1OZKwNHdUJpI+i55gMWjiIfKpX7OvkeB2RSiYbcCpKT3Ao/b7
         +pbnroymXiPDYOrxnsDQxCnjHTj8faVC+bi2CQYQKFZxnuGysZE/9GZNV5S3S8KdGFep
         ICWqK/QrkCVM5yZh23OP7uON7bVNAOd7pbggY5qAX1fpp0Rl3sEEFeZbgS3kCcKPbBL/
         7TToZ2xiFxCblYaadauqPYnBDxR50RMtgdVcXzJjG4jJNpSAJIjObp8QtPi0RLU2n0Sa
         jx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344694; x=1773949494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHoIsTG7IVfAzcG8vtVaG2KfMTAKD1Mf8pCRYcgobfc=;
        b=s3l1tiBrM1wY7ye0dw2SHQm4oNaED/r1TVBM+0pu9bVsxug7HGWvsK7J11/7bMIXXz
         Yi2IzdyHN16MUiZpVMPqSAoqLJghkuWka2xOlX6iw8Fd6Wu+OlqtnlWoKYq9yBobAmkx
         1a+EXOvik+Ae5q1zlZmSl0hDdu3FeU5e11yHNVuCsJAEzMneBdZIhPK4biZg9pstKmsq
         CZfTqBs3wIiuf+YcTTthOE9lgB7GXw43EAM7081JnSftkSz29NnR805ShB2eDbHy+E3U
         /vTqwYJMeKBRsWUJt3AOoaNHAa4WIab3gTjxRgZbTwrZ4YRlItKlg1PZ/6VVJoHCzZUR
         6rSg==
X-Forwarded-Encrypted: i=1; AJvYcCWCEybUXEwACUwusZAJAI6TAQxhnl44+wmuTAtB7R0NamBKsgkYzhcvF0TVNMk30aPPXe8KtUYm@vger.kernel.org
X-Gm-Message-State: AOJu0YxoGB3ufUzPaW2A90i9jkZYnReiWlD57n0HfyrjRmNBSowwOlLx
	GHqTvkN4JzMjQBnFTdfhOKWmZXZpq/tDI13lY+StNeRwxuR1nF9514q1
X-Gm-Gg: ATEYQzzG3o53ciI5L+kuKpvnfCAtFWpX2HrYxhOrV08LgvTf2dPFprMH7Nj0atsOnV5
	5J1k8sjutzvfRALt26a97lKdUR/LdUQlfdTjFoegoBK27L9GwjrP0l0+6sprjo/ERnAupGQx+b7
	f0OCiS50Osr+E456Z+hH7Z3mnoAwNEb/mh5MQk3Mq80K69b8reB13mlMSjjiLiiV+Gpd1hu1NYc
	6iBQ1DcVxf0byRp6HLsIGKmkVj1N7pSttQIlWWJ3wQIYtZnhSBRX2Je2T9DHmhW8QFxSb0IaUfu
	c562BqxgZFL1utK2fbGJjPrgIh7bdRNZ1wQB8MXXOFSI/7CMJDvWlqUMpIQ19P8X9mjVX4Iyixn
	k2phTrXuWsx96mSsAR7mKimAUcYEcWKIenPIuwVnyX2++lDg/y9kxDpHruquOKt1r5sbrB0m+HI
	G3AnLxHHG22FF3uwcWhVK7CQ==
X-Received: by 2002:a05:6870:8e15:b0:3fa:a43:1f0a with SMTP id 586e51a60fabf-417b93f3d61mr527488fac.37.1773344693894;
        Thu, 12 Mar 2026 12:44:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm5549386fac.17.2026.03.12.12.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:44:53 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Bing Jiao <bingjiao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH 6/6] mm/memcontrol: Make memory.high tier-aware
Date: Thu, 12 Mar 2026 12:44:51 -0700
Message-ID: <20260312194452.3418042-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <abHnHN74V3okn28D@google.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14792-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E72627847F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 22:05:16 +0000 Bing Jiao <bingjiao@google.com> wrote:

> On Mon, Feb 23, 2026 at 02:38:29PM -0800, Joshua Hahn wrote:
> > @@ -4485,15 +4527,22 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> >  		return err;
> >
> >  	page_counter_set_high(&memcg->memory, high);
> > +	toptier_high = page_counter_toptier_high(&memcg->memory);
> >
> >  	if (of->file->f_flags & O_NONBLOCK)
> >  		goto out;
> >
> >  	for (;;) {
> >  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> > +		unsigned long toptier_pages = mem_cgroup_toptier_usage(memcg);
> >  		unsigned long reclaimed;
> > +		unsigned long to_free;
> > +		nodemask_t toptier_nodes, *reclaim_nodes;
> > +		bool mem_high_ok = nr_pages <= high;
> > +		bool toptier_high_ok = !(tier_aware_memcg_limits &&
> > +					 toptier_pages > toptier_high);
> >
> > -		if (nr_pages <= high)
> > +		if (mem_high_ok && toptier_high_ok)
> >  			break;
> >
> >  		if (signal_pending(current))
> > @@ -4505,8 +4554,17 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> >  			continue;
> >  		}
> >
> > -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > -					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
> > +		mt_get_toptier_nodemask(&toptier_nodes, NULL);
> > +		if (mem_high_ok && !toptier_high_ok) {
> > +			reclaim_nodes = &toptier_nodes;
> > +			to_free = toptier_pages - toptier_high;
> > +		} else {
> > +			reclaim_nodes = NULL;
> > +			to_free = nr_pages - high;
> > +		}
> > +		reclaimed = try_to_free_mem_cgroup_pages(memcg, to_free,
> > +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
> > +					NULL, reclaim_nodes);
> >
> >  		if (!reclaimed && !nr_retries--)
> >  			break;
> 
> Hi Joshua, thanks for the patch.

Hello Bing!

I hope you are doing well, thank you for reviewing my patch : -)

> I have a concern regarding the system behavior when both the total
> memory.high limit and the new toptier_high limit are breached.
> 
> If both mem_high_ok and toptier_high are false, memory_high_write()
> invokes try_to_free_mem_cgroup_pages() with reclaim_nodes set to NULL
> to target all nodes. Under these conditions, the reclaimer might attempt
> to satisfy the target bytes by demoting pages from the top-tier to lower
> tiers. While this fulfills the toptier_high requirement, it fails to
> reduce the total memory charge for the cgroup because the counter tracks
> the sum across all tiers. Consequently, since the total memory usage
> remains unchanged, the reclaimer will likely become trapped in the loop
> until it reaches MAX_RECLAIM_RETRIES and other situations (e.g.,
> both !reclaimed && !nr_retries–), leading to excessive CPU consumption
> without successfully bringing the cgroup below its total memory limit,
> or causing all top-tier pages demoted to far-tier, or causing premature
> OOM kills.

I agree with everything you mentioned above. However, I would like to note
that my series preserves the default behavior for when memory.high
is breached (since toptier_high is always <= memory.high), so
memory_high_write() would previously have this behavior as well where
shrink_folio_list would prefer to demote as opposed to swapping and
lead to the infinite loop.

In that sense I think that it might make sense to introduce a fix for this
that is orthogonal to this series. AFAICT I don't think this is introducing
any new harmful behaviors.

> Given your tier-aware memcg limits, I think it is better to reclaim from
> lower tiers to swap to satisfy mem_high_ok by setting the allowed nodemask
> to far-tier nodes. Then demote pages from top tiers to ensure
> toptier_high is okay. This also prevents reclaiming pages directly from
> top tiers to swap and ensures that demotion actually contributes to
> reaching the targeted memory state without unnecessary performance
> penalties.

If I understand this correctly, this would mean that each loop would:
1. swap out low tier
2. demote top tier

And repeat this cycle until we meet the memory.high limit?

I think this makes sense. I will note that once again I think that this
change is orthogonal to this series, as it deals with the memory.high
violation case and not the toptier violation case. Note that if only
toptier limit is violated, demotion from the toptier does make sense,
since in this case it will shrink the metric we care about.

> To address the issue where a memcg exceeds its total limit and demotion
> cannot help to relief the memory memcg pressure, I am considering to
> introduce a reclaim_options setting that prevents page demotion by
> setting sc.no_demote = 1. I have a local patch for this and am preparing
> it for submission.

I think this makes sense. Please do CC me in the patch if/when you do
send it upstream!

> Please let me know if I have misunderstood any part of your
> implementation or if you see any issues with this proposed adjustment.

I think you understood my patch completely as I intended : -)
From my POV though, I just felt that the issues you mentioned actually have
to do with the standard memory reclaim infrastructure, and not necessarily
with the toptier high semantics.

And please let me know if you feel that I have not represented your
perspective as well! I hope you have a great day!!
Joshua

