Return-Path: <cgroups+bounces-7681-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F9A955D6
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 20:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D239A3B1979
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD74E1E5201;
	Mon, 21 Apr 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSWXvoeP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A10524C
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259543; cv=none; b=hcGmEdkD7tl/Agqy4GDn+Og+j7cFYYHQSFjPBoJm1lM0aCT75grxedDp5KP05MMgFMzPN/KzgE3WmrO4uq03BGZ8nXt/mqCuSKjvvJDAmlq4DOk2s++Av+evGClUDjhwWl/gv3dQHYUe3rzvUPWSok8UxfjmJIrhsfJ6ZTsz5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259543; c=relaxed/simple;
	bh=DEKrIDTzwtj3oabPFLMdzDfanV1Br041fTfu9CjcwTw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LRaqJvitx7pVbnN4hF3rl+FAftcynsG3OEr+Knzsd0W4ZF1JUaLHetIKpa79EsDFpBkIoJBclPcd8cEh+P5KZjRntgzmpLiA8lJkLYR8wIMhr4RBfI+gkpHq8QY+acwHv8nUgDgYxOpOH7zAUJtxMFVeb92oagmNQd1ZB6Ido+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSWXvoeP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736b98acaadso3971898b3a.1
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745259540; x=1745864340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4NnzSj3xXsMU6P72SjjLVYyHOckoaZh/vTDDVaG/Zv4=;
        b=kSWXvoePP6SyXoC/hYvK9IDRpHphrpEYrHXr8huXyhuVT/Fu0d16f7NNJNUD9oT9v7
         4ncTaQOoJjOD58bD1hvRXOj5Z7oBzXHK66NxAS1Qt67VVgp/fRiS6OsEumnYUPJo2az4
         dnr9zC+Pfs6ZshS9Tf01tlchgeXzKQlZZOSsTI9ghgJCMutwCOjdMD2ueOJuOyeHGooi
         oANwYWYZtsicGwXZc29xxATRfC6fYT8rrmLt6m3GBAJD1nVXQw/P1u2ygB3fIoaBRQZL
         4m7LP8Wr3n/Viws1SBbzhz0SwWKn6W2liDeT8eENwerS/RjmwXp8mr1ChwbMFrsMKCg5
         MlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745259540; x=1745864340;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NnzSj3xXsMU6P72SjjLVYyHOckoaZh/vTDDVaG/Zv4=;
        b=v7j8I53Nkba6lVvnyN8mGDPxBvUgG+BD9TKIl00Vk+qAHfLtHEtxHOZ6pR9nGiOoq3
         uE6cESjy068tNTPqM2FI3LBd3jmrYO1aO6phXnCAY0Lp5sjhcuHY+9p+s/uNFC0JHBaA
         K42cIBaLNc6F/YOFk4FHjjJF1ZU5W9qOLNiHtcYS9wdhCX7uNkjf+wlJZcD6DdQOCn/P
         +/qTYuKOt0q3N6N2o9mx+pSgHgdgdBBgIU56Pqi7TcU/DSD5PWpc097YoRuYwn3PJKYO
         zjamF2kfo3ZwQgcgnWa5wv/qELHEXlQoR4tl3CfcfqnkUphssv71Htr2kn4mOCZEDJZ2
         RPzg==
X-Forwarded-Encrypted: i=1; AJvYcCUNTUCBpVQkd90FQKylL9MFguWL9qGEXZ7sPxlo2htTisVYtExqEAfzTckosbFJQwe4WVruI193@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3mix6vpDAwi2TiAAOA+Eyl0ZK2u1O0rGbl+nbrJA0H6N+Z8N
	qI2qiubKW80p65uvIdLDjvNX6g8iEAESMDV6GF6cV7O4ynOHJtp2
X-Gm-Gg: ASbGncvy0DLiWwtPGKbM5qediANZ1cp4bsew3iTz4P1esbvm0DeUjqeLinK6m+H2e1k
	mlowb4i7bfjI8P0MEDomWNLg9w/gFbblyhngn43Jsbn8jNpJKrZ7ymSZxbDe6eEXSeRQbQ+4vrt
	mkJeli8230E5oWQculolOIDulbh8vD1BmGITtv/7xfnJYKQYpewE9bVr/1smsvsqU42EhL4Mt98
	xUnQaLGPT/11MT29uHw0RVaPSCCtdQnOUycHqdjH4TbY0B4PHUbPrLNfWmde0g/aL2Qw9NPRgXp
	AUYZcRxjrP7ICk1AH2vrpvO0QD3oOWzrbKaChSk4f5t9Ut2Ngmg31Q67N6V9/vcQd5IBOQKs0Q=
	=
X-Google-Smtp-Source: AGHT+IFXLQns15fh7pfXNc5ezyl1dqkgGArBZMs9ZhZAxbmZXFP14YURwrWhnlqgEDq+qrivE33rjw==
X-Received: by 2002:a17:90b:5410:b0:2fc:a3b7:108e with SMTP id 98e67ed59e1d1-3087bb3e865mr19134798a91.4.1745259540410;
        Mon, 21 Apr 2025 11:19:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:3aff:e3c0:27f0:39c9? ([2620:10d:c090:500::6:17e0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df05132sm6938105a91.12.2025.04.21.11.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 11:18:59 -0700 (PDT)
Message-ID: <8bc5579f-41b2-48b7-bf34-b970d98f0345@gmail.com>
Date: Mon, 21 Apr 2025 11:18:58 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250404011050.121777-5-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 6:10 PM, JP Kobryn wrote:
>   __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
>   {
> -	struct cgroup *cgrp = css->cgroup;
>   	int cpu;
>   
>   	might_sleep();
>   	for_each_possible_cpu(cpu) {
> -		struct cgroup *pos;
> +		struct cgroup_subsys_state *pos;
>   
>   		/* Reacquire for each CPU to avoid disabling IRQs too long */
>   		__css_rstat_lock(css, cpu);
> -		pos = cgroup_rstat_updated_list(cgrp, cpu);
> +		pos = css_rstat_updated_list(css, cpu);
>   		for (; pos; pos = pos->rstat_flush_next) {
> -			struct cgroup_subsys_state *css;
> -
> -			cgroup_base_stat_flush(pos, cpu);
> -			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
> -
> -			rcu_read_lock();
> -			list_for_each_entry_rcu(css, &pos->rstat_css_list,
> -						rstat_css_node)
> +			if (css_is_cgroup(pos)) {
> +				cgroup_base_stat_flush(pos->cgroup, cpu);
> +				bpf_rstat_flush(pos->cgroup,
> +						cgroup_parent(pos->cgroup), cpu);
> +			} else if (pos->ss->css_rstat_flush)
>   				css->ss->css_rstat_flush(css, cpu);

This needs to change from css to pos. Note this was not an issue up
through v3. The flushing functions changed upstream between v3 and v4 so
this was possibly missed during the rebase.

> -			rcu_read_unlock();
>   		}
>   		__css_rstat_unlock(css, cpu);
>   		if (!cond_resched())

