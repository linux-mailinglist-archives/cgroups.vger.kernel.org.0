Return-Path: <cgroups+bounces-14618-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMN8MdiuqGmfwQAAu9opvQ
	(envelope-from <cgroups+bounces-14618-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 23:14:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E74208602
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C59A32026C7
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCE3890F7;
	Wed,  4 Mar 2026 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="z+5mes6F"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8038756E;
	Wed,  4 Mar 2026 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662019; cv=none; b=PAL9eZsjXBTr63Q7XVRjBxhUZ/movWhPUzXoTaX5W2eiHJzgXATAdC4QdoB1Kzr092HlDgKzgEhTCAEigapsDrMG3VW66OqQG/oxEUmt9x673BHvOn+NhT0PLKDu/V06W+hhhKyR+O0uwhMWr536jcnWzkJtXXsKkODOwqJSgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662019; c=relaxed/simple;
	bh=8Xl8IT7hq0toAnUmrvgPTcJcEweAl8oRj1L2Yr23ZGI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WoSmbhX49f/cq39JN3O7qdeDJJ/kZo9+6c7QhlIMrXzBTbKmIFzlUX9lzGO6qfznaJimgnn82dwXzGTJlHvUVAXVsKDwq6ltvjfH/z2l9y5hFSqm1mvN285/YYk+K2yhfHLrFAPBtL2TSRqmy/HfRUFG37kr77EK43OVWuk0JpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=z+5mes6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C7CC4CEF7;
	Wed,  4 Mar 2026 22:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772662018;
	bh=8Xl8IT7hq0toAnUmrvgPTcJcEweAl8oRj1L2Yr23ZGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z+5mes6FwNQGeJ64sQB9kTOAb1+U3o9CXqvn1QVnqtL3RkKbqtyrvwrfVJsQCoym2
	 K9kpNjb1puSgMCJuWYIntDZ/rfgjjkKYkAr3WKadzl1LAj6Q1BSgZqyvQCYlJ6BGea
	 QPWtnY0yAdaDZNMpYxglGqQe28i4oQ0QlBn4C/pQ=
Date: Wed, 4 Mar 2026 14:06:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Yosry Ahmed <yosry@kernel.org>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-Id: <20260304140656.10c524970519de373accca0b@linux-foundation.org>
In-Reply-To: <22cca07c-49e0-42e8-b937-7b1c7c51e78d@linux.dev>
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
	<20260228072556.31793-1-qi.zheng@linux.dev>
	<CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
	<de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev>
	<46bgg2vwqvmex7wtk2fkvf454tqgaychb7l4odnnrx7svci5ha@vy4b4ophm763>
	<22cca07c-49e0-42e8-b937-7b1c7c51e78d@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 22E74208602
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14618-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,google.com,suse.com,linux.dev,oracle.com,nvidia.com,huaweicloud.com,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 15:56:42 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6044,8 +6044,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, 
> const char *name, umode_t mode)
>    */
>   static void css_killed_work_fn(struct work_struct *work)
>   {
> -       struct cgroup_subsys_state *css =
> -               container_of(work, struct cgroup_subsys_state, 
> destroy_work);

Lots of wordwrapping in this patch.

