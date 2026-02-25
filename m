Return-Path: <cgroups+bounces-14367-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHX/Kz8Pn2neYgQAu9opvQ
	(envelope-from <cgroups+bounces-14367-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:03:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E67F19926F
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 853713039338
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EDA3B52F8;
	Wed, 25 Feb 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCraxq8x"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788933C195
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031552; cv=none; b=cG9pP/xChe3lh5skUZRIm4FQWNBgUv89ZUPPoQeK3osD1Xb8SnirfP2GTkCHwScl+ZYMylJepPpiwjkmYdeG/MF12d0WfX6z+TX7r+21EXfJEOfbSOjO/U4AqQ9SjeWsttvC9oabM2tgsl0IXrJ8b8q3uXIiRy7Z4ylLRj74Ck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031552; c=relaxed/simple;
	bh=3Txd1OyD3NLDVRwknS9tkgQm0Wseoy61mGvIdnnZ8lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWg+XQWYALxjRCkZLjL+pvtJZcvN9uUKwnnbTapkMRXIIVjZKgY7zrFE/QjGt/lJBB+ehnwxPg7Z8M7+VQ3rS0S6YOzUj7/ceB2F2FbKGvKhQKfgbHEzBfDx1jtAFYa3sPjWyy1wXHP8ZB3BU/294k0QaE4/l/8bi8V7kkY0uis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCraxq8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9713FC19425
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772031552;
	bh=3Txd1OyD3NLDVRwknS9tkgQm0Wseoy61mGvIdnnZ8lA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SCraxq8xCF+tuvDyaEyzv3AhjlwhyDt+mMCw8aso7JcqEXgN+DGY9i95e09kMQRDZ
	 +tVNnHq7AuvueUBOaSC0SQlWxN+MQMTWEX4TcOvhyKB38NUuBiC1ALU4TrYa3aKH6t
	 LHA0a1EXQlPYNembvKi2ViOzNPic37ALJ4HKfrHoyv+/44/fBhtqKicBmLk0tlIBRX
	 KK3oqrp4GXS3Em3MXEPxzyBBHXOCZ6MhD3isGq1FjOfNrLssMkUV29X+BoJSSpRf0s
	 Ah9ZbWJ1blOlz4sHclObw+NZnJXzHQCA6WEaSCQ5mSQZ3sVJ53BwT54KMeZeSGtPTl
	 ECJ3uyn0v/lvQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b904e1cd038so976029266b.1
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 06:59:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYUvtOTR7NWDCkXKJtYppVEMvNihcV/q1hSkPaipjJgQTB+HZZW8kCp5gImL1HYlA2iolh0OEk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nRqWCDfBH9yuomN+3FPHoI0qYqkPztagzpjIXyAnpSociGoY
	JkVasnQP83DDm1wIqWZZiEXyerkJ3OrDND2XCag+L7aRGUA4k3kQPrPWTb4B3frven9CuKEWLWu
	g+wGnyAY1bKBpaXTvg2dys0kxDyR9gqg=
X-Received: by 2002:a17:906:fd83:b0:b8f:e46f:8079 with SMTP id
 a640c23a62f3a-b93516596b6mr43482566b.22.1772031551370; Wed, 25 Feb 2026
 06:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772005110.git.zhengqi.arch@bytedance.com> <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
In-Reply-To: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Feb 2026 06:58:59 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
X-Gm-Features: AaiRm51rcgwmhy_l6lMgbqkiAK7g6vTS87LlDp6ohQJzV813HW9AeoQpr_xIsok
Message-ID: <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com, 
	usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14367-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E67F19926F
X-Rspamd-Action: no action

> @@ -473,6 +493,29 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>         return x;
>  }
>
> +#ifdef CONFIG_MEMCG_V1
> +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
> +                                      struct mem_cgroup *parent, int idx)
> +{
> +       int i = memcg_stats_index(idx);
> +       int nid;
> +
> +       if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
> +               return;
> +
> +       for_each_node(nid) {
> +               struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> +               struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
> +               struct mem_cgroup_per_node *parent_pn;
> +               unsigned long value = lruvec_page_state_local(child_lruvec, idx);
> +
> +               parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
> +
> +               atomic_long_add(value, &(parent_pn->lruvec_stats->state_local[i]));
> +       }
> +}

Did you measure the impact of making state_local atomic on the flush
path? It's a slow path but we've seen pain from it being too slow
before, because it extends the critical section of the rstat flush
lock.

Can we keep this non-atomic and use mod_memcg_lruvec_state() here? It
will update the stat on the local counter and it will be added to
state_local in the flush path when needed. We can even force another
flush in reparent_state_local () after reparenting is completed, if we
want to avoid leaving a potentially large stat update pending, as it
can be missed by mem_cgroup_flush_stats_ratelimited().

Same for reparent_memcg_state_local(), we can probably use mod_memcg_state()?

