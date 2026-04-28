Return-Path: <cgroups+bounces-15546-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNuiJfYw8Wn7eQEAu9opvQ
	(envelope-from <cgroups+bounces-15546-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 00:13:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB7448C7F4
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 00:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB7433019618
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 22:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFB437B41A;
	Tue, 28 Apr 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XNpnAMES"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722637AA86;
	Tue, 28 Apr 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414374; cv=none; b=ly80DBWKtHz1dN/Z48b6fP5peNdr3Kub7oadhTYMOher5Zmi4wEiossNIYaI8fZ8F2xwfJp51A9diKUDyT5NxnAVPJKityls1F/tRSoOghJxD+KG17xiktdkLvoVd02YAanRUPHeZREdh09d6Jzt4IkeXgTGW0B7JRau8JUutH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414374; c=relaxed/simple;
	bh=kkg+9dj6Kg2m+RboFcKUDNE4w+XzBqWMxSts1BhV6I4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IyCHZ5BDAkUr5WKBCTOBGwFkKF1i5XWlI/60Q5jk60ZCLypmYedIdUnY5p+4XyQkaRr8WraCON7AtdXIsfuCDfc+0O40ZZB2xLSsu8spS7SokfmByCmYrBXFP2zVX1Gr8Zkbz7D562ZTLAKNpzuIET5VtHlYgU8DIsiTB0dSGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XNpnAMES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB121C2BCAF;
	Tue, 28 Apr 2026 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777414374;
	bh=kkg+9dj6Kg2m+RboFcKUDNE4w+XzBqWMxSts1BhV6I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XNpnAMES5OC4zofWEQ9KsfRL5J+zTlmIOclCucf7XWL26Ni9y2W9YOCHeIz4luJxW
	 6epdhnr0Ye6sH711e47Tlb8kS31HcY0e+SY+dZqW8c30qVDfqDpzZUDcKjrQCHSjD5
	 IFOoeMtYNvW5gut/7PMoK6wqunXzLTWN86Q4Xl3w=
Date: Tue, 28 Apr 2026 15:12:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, yosry@kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2] mm: memcontrol: fix rcu unbalance in
 get_non_dying_memcg_end()
Message-Id: <20260428151253.bdfb08401ebb74c438df0e52@linux-foundation.org>
In-Reply-To: <20260428103108.45719-1-qi.zheng@linux.dev>
References: <20260428103108.45719-1-qi.zheng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BDB7448C7F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-15546-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 18:31:08 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> Currently, get_non_dying_memcg_start() and get_non_dying_memcg_end() both
> evaluate cgroup_subsys_on_dfl(memory_cgrp_subsys) independently to
> determine whether to acquire or release the RCU read lock.

Sashiko review
(https://sashiko.dev/#/patchset/20260428103108.45719-1-qi.zheng@linux.dev)
is correct.

mm/memcontrol.c: In function 'mod_memcg_state':
mm/memcontrol.c:881:9: error: 'rcu_locked' is used uninitialized [-Werror=uninitialized]
  881 |         get_non_dying_memcg_end(rcu_locked);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/memcontrol.c:874:14: note: 'rcu_locked' was declared here
  874 |         bool rcu_locked;
      |              ^~~~~~~~~~
In function 'mod_memcg_lruvec_state',
    inlined from 'mod_lruvec_state' at mm/memcontrol.c:973:3:
mm/memcontrol.c:952:9: error: 'rcu_locked' is used uninitialized [-Werror=uninitialized]
  952 |         get_non_dying_memcg_end(rcu_locked);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/memcontrol.c:944:14: note: 'rcu_locked' was declared here
  944 |         bool rcu_locked;
      |              ^~~~~~~~~~
In function 'mod_memcg_state',
    inlined from 'mem_cgroup_sk_uncharge' at mm/memcontrol.c:5392:2:
mm/memcontrol.c:881:9: error: 'rcu_locked' is used uninitialized [-Werror=uninitialized]
  881 |         get_non_dying_memcg_end(rcu_locked);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/memcontrol.c:874:14: note: 'rcu_locked' was declared here
  874 |         bool rcu_locked;
      |              ^~~~~~~~~~

