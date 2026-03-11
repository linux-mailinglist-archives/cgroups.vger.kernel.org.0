Return-Path: <cgroups+bounces-14778-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNudMSznsWmcGwAAu9opvQ
	(envelope-from <cgroups+bounces-14778-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 23:05:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7364526ABC6
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 23:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF23330078AC
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 22:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC93364955;
	Wed, 11 Mar 2026 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmVDTFlF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C83590A9
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266726; cv=none; b=EnpmfyRAVwc0qxwBJs896x3p6WeK2xpVYvw43/78sBO9Mnid/gBkqcMTZxkDW8IY2+k/MIDdCb94TJF+lyo1QV2zCX+REdoOv0zPoXr715jruLQYEX4IdF8dgkRl+yZv52g+7LS75ev9cvyAMC4EFr9EVGGd3C5jZqBZbWJHw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266726; c=relaxed/simple;
	bh=+8RpzlRgG8CcMguiysKihl8ncy0qm2mBmUD1E0R4G/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvwveWDseGo0CTXTPzuyvHz0NW4WTXNUInKW5JPQmOMFxJh9veOsW5EhpZIN1pyBGehhVzwVNg1pKjLkBtBrfkglUYarqUEg4bgHAvOzgIJ5OS0C3aOnITVOHXdQYE+2rGQ2GIBXIMhMp0s7+uNgZ9YehNTsWRyG3yVmsbKQpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmVDTFlF; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1270fc2bdf2so4345c88.0
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 15:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773266723; x=1773871523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wXWniKRYu/9movUjNPN4FwDYQDKZWxsH7J4WhlFPgko=;
        b=EmVDTFlFD7dHSZ6uCvkgQJowUITrgYMbsIVoVMkwviE/rqQTW2ZGR1cZs1UQ6eTiaR
         2XCj7xXeZj1fd/tq905fQrRRmeiCEFxvcFls6astlbd5SkEmf9GayVyr58Q1sRPy7RRn
         LU87GVHJNARbp7lNY8msnWkMeoulD+DOXkGyYH9zQLPYJ5yiR/WK6/DphGBOjABsQYtN
         NB8TVNZ6SviBSVH+RThs7nvoJCzkyvTwbXmc1z/nfsY0GnvoFi7CMy070kgVTpp07epf
         ZgwQZW/Wy0eegaEOZlB5w7VMnpa+A4m6ymJkDcep/4WzDi4Vz43+Ea+deS3pVg/2Dx7s
         xoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773266723; x=1773871523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXWniKRYu/9movUjNPN4FwDYQDKZWxsH7J4WhlFPgko=;
        b=qUdiCXigBVqowFR1kz9txOmkv9P+les4pFiClGWuA7DdnkG/EdlQTPNES2OsZScnLY
         HAJiSzAMiOzSS255mAFHGz1mHiBjl3NqWrEN4X9c3/4VjkxE4ITgmdy+xedk01swOtO4
         Sq8gju0S/+z6zS51NIvhECkVQFR0dhSE26fOasChANvr2hfPOhsqDNDlvw0ALiMqgaBr
         dO131qEycrYdMCMPocB2PCPezApqWmyCxA474yi9SjhPWizLBt/aqGwIYWlQVoylRg4h
         Kimx0j3kTpa6OYPbhehi8bl8HdFtl5Z1/GHJylXDc/66AzUumXAVIs+wL5OgjK9qcL/6
         uJSw==
X-Forwarded-Encrypted: i=1; AJvYcCVpeS1QsHKYV6jeAyIPJj6JdgKgw96UlR4LbCNzUiyLvK3RH+WwM6GA8N5gUgT6Rx4noQ9n0UsE@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKGI2grTZ/Pz/WucnT6n3QAShcKbxEunT3j+VrJYmodSxJB9S
	e7aZEFI8dqXSERYNgFKqhyKfP8AqVY3RpZhX4TmFOHUfTOdBeeF0vWX3Zk3mbqxD0g==
X-Gm-Gg: ATEYQzzNHaHeX6+TH1/BVrwUnvaGyTxAxfwum20KskFLygW95V00XYbZCYuLbi4+qJ9
	wvrs4sYJaYpa78137QpD/vpLfrIz8mGyiqVf7Xp7pl73TgmT7roe8YT3BR1Nz9mB98FOU8opjYI
	vbM8MkzCD0NVuvD57G/2Tas8g5y+/EcemanDHXsYki2hvDN5l/sT4saqgdXOpJ96hI7YHsaBsZn
	pHno2UyMe9RM1aO7dUlcysunGC9xHy+3i/A0HDqqidPJk4YLMWe83ngUqEwxWUGVMAZkPeOj22I
	mdG4uC/MxouLZHqW+x8hAlvL8lJgqE2GOefymx3DAqCFp7zHPVDNGvMUUUWlxMsRho7iU8PeoKu
	myvU2yWDp+IhSsIPntrDedzulkN+YctkO6T2QkAou55CtyPrQxx4P8xXf0Qi/Yk7v+qzH93pPNK
	zCUg55nYK1psJ+q2pdUbddUPQWDTnPzuybKvNgjWL0+gVeTGx71fPtIh2+Esgv4avt
X-Received: by 2002:a05:7022:5f19:b0:127:366c:8722 with SMTP id a92af1059eb24-128ed176657mr29991c88.16.1773266721865;
        Wed, 11 Mar 2026 15:05:21 -0700 (PDT)
Received: from google.com (206.238.125.34.bc.googleusercontent.com. [34.125.238.206])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7bffd49sm6083208c88.5.2026.03.11.15.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 15:05:21 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:05:16 +0000
From: Bing Jiao <bingjiao@google.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
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
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 6/6] mm/memcontrol: Make memory.high tier-aware
Message-ID: <abHnHN74V3okn28D@google.com>
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
 <20260223223830.586018-7-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260223223830.586018-7-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14778-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7364526ABC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Feb 23, 2026 at 02:38:29PM -0800, Joshua Hahn wrote:
> @@ -4485,15 +4527,22 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  		return err;
>
>  	page_counter_set_high(&memcg->memory, high);
> +	toptier_high = page_counter_toptier_high(&memcg->memory);
>
>  	if (of->file->f_flags & O_NONBLOCK)
>  		goto out;
>
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> +		unsigned long toptier_pages = mem_cgroup_toptier_usage(memcg);
>  		unsigned long reclaimed;
> +		unsigned long to_free;
> +		nodemask_t toptier_nodes, *reclaim_nodes;
> +		bool mem_high_ok = nr_pages <= high;
> +		bool toptier_high_ok = !(tier_aware_memcg_limits &&
> +					 toptier_pages > toptier_high);
>
> -		if (nr_pages <= high)
> +		if (mem_high_ok && toptier_high_ok)
>  			break;
>
>  		if (signal_pending(current))
> @@ -4505,8 +4554,17 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  			continue;
>  		}
>
> -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
> +		mt_get_toptier_nodemask(&toptier_nodes, NULL);
> +		if (mem_high_ok && !toptier_high_ok) {
> +			reclaim_nodes = &toptier_nodes;
> +			to_free = toptier_pages - toptier_high;
> +		} else {
> +			reclaim_nodes = NULL;
> +			to_free = nr_pages - high;
> +		}
> +		reclaimed = try_to_free_mem_cgroup_pages(memcg, to_free,
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
> +					NULL, reclaim_nodes);
>
>  		if (!reclaimed && !nr_retries--)
>  			break;

Hi Joshua, thanks for the patch.

I have a concern regarding the system behavior when both the total
memory.high limit and the new toptier_high limit are breached.

If both mem_high_ok and toptier_high are false, memory_high_write()
invokes try_to_free_mem_cgroup_pages() with reclaim_nodes set to NULL
to target all nodes. Under these conditions, the reclaimer might attempt
to satisfy the target bytes by demoting pages from the top-tier to lower
tiers. While this fulfills the toptier_high requirement, it fails to
reduce the total memory charge for the cgroup because the counter tracks
the sum across all tiers. Consequently, since the total memory usage
remains unchanged, the reclaimer will likely become trapped in the loop
until it reaches MAX_RECLAIM_RETRIES and other situations (e.g.,
both !reclaimed && !nr_retries–), leading to excessive CPU consumption
without successfully bringing the cgroup below its total memory limit,
or causing all top-tier pages demoted to far-tier, or causing premature
OOM kills.

Given your tier-aware memcg limits, I think it is better to reclaim from
lower tiers to swap to satisfy mem_high_ok by setting the allowed nodemask
to far-tier nodes. Then demote pages from top tiers to ensure
toptier_high is okay. This also prevents reclaiming pages directly from
top tiers to swap and ensures that demotion actually contributes to
reaching the targeted memory state without unnecessary performance
penalties.

To address the issue where a memcg exceeds its total limit and demotion
cannot help to relief the memory memcg pressure, I am considering to
introduce a reclaim_options setting that prevents page demotion by
setting sc.no_demote = 1. I have a local patch for this and am preparing
it for submission.

Please let me know if I have misunderstood any part of your
implementation or if you see any issues with this proposed adjustment.

Best,
Bing


