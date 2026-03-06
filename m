Return-Path: <cgroups+bounces-14689-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J8wIkQ5q2nZbAEAu9opvQ
	(envelope-from <cgroups+bounces-14689-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 21:29:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6422780C
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 21:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89BD530162AF
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2026 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3947CC6C;
	Fri,  6 Mar 2026 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iupAZja8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A647799B
	for <cgroups@vger.kernel.org>; Fri,  6 Mar 2026 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828991; cv=none; b=NPjKdgy0x/1UpkNQd4301x4ZeXqc5gf7PBuISQUWLDp+xJF6+UKSpIfoQyKcaLd1Ykd5lm5OwGXsJvKNGgBz3idvFNdsTZyoS8+qfjH8jSPJi7+6HRKGozPrgB9jEi2r+1AeCuCXyRysCeClYEPqeZiDeHdFCu23uovnFHmOsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828991; c=relaxed/simple;
	bh=rFfmioNiorqkmxbTrUeBgC8NnB58UG6HTHT7bTr4Blo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/HR9ygWRqu+wV8IsslWnEU+84es3JbaGMUYoZ0clh6VT4I6D8k6oYEpdNYzVQy2dqoYtWLlAbJT7GUeMJ31hsy0/5ZPFO6aQlApz6Yu7KpyEkHc5+d0BaKIVvvakTvm46MgoPYoVokCto14CaeHj7uRqABjvKfBeNXj1/lcwCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iupAZja8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772828978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xu4FOpsB3tis67Vr0ogStH5duKlNRv21WglBri7UTcs=;
	b=iupAZja8wy6lFb/pwYfc8nhuO+aJSry5Kzt+7aHHLHQlaMXK2PAsZMFNNd66go/2W6Kkwe
	vdSCNOLTyQowEMIgGXwIyWRJErAzaAgNXx4GOqe/oeRcXdJ66tdgH5XHnVRTlmSidJ3kyS
	lzPKFMCdB6Vy+1HRz3vUG4R4h/6qZ20=
From: Usama Arif <usama.arif@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>,
	hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev,
	bhe@redhat.com,
	usamaarif642@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 31/33] mm: memcontrol: convert objcg to be per-memcg per-node type
Date: Fri,  6 Mar 2026 12:29:28 -0800
Message-ID: <20260306202931.3878822-1-usama.arif@linux.dev>
In-Reply-To: <56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1BB6422780C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14689-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,bytedance.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 19:52:49 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Convert objcg to be per-memcg per-node type, so that when reparent LRU
> folios later, we can hold the lru lock at the node level, thus avoiding
> holding too many lru locks at once.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h | 23 +++++------
>  include/linux/sched.h      |  2 +-
>  mm/memcontrol.c            | 79 +++++++++++++++++++++++---------------
>  3 files changed, 62 insertions(+), 42 deletions(-)
> 

[...]

> @@ -4087,7 +4100,13 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	xa_store(&mem_cgroup_private_ids, memcg->id.id, memcg, GFP_KERNEL);
>  
>  	return 0;
> -free_shrinker:
> +free_objcg:
> +	for_each_node(nid) {
> +		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
> +
> +		if (pn && pn->orig_objcg)
> +			obj_cgroup_put(pn->orig_objcg);

Is it possible that you might call obj_cgroup_put twice on the same cgroup?

If css_create fails, css_free_rwork_fn is queued, which ends up calling
mem_cgroup_css_free which calls obj_cgroup_put again?

Maybe adding pn->orig_objcg = NULL overhere after obj_cgroup_put
is enough to prevent the double put from causing issues?

> +	}
>  	free_shrinker_info(memcg);
>  offline_kmem:
>  	memcg_offline_kmem(memcg);
> -- 
> 2.20.1
> 
> 

