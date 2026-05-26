Return-Path: <cgroups+bounces-16319-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A2jBc3HFWpNbQcAu9opvQ
	(envelope-from <cgroups+bounces-16319-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 18:18:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A91AE5D985E
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF12307C7C7
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E02F3C0A;
	Tue, 26 May 2026 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FAHVvM5S"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A031D5CFB
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809359; cv=none; b=e5enIRq92ewt3GlL/XqrAnIKfNVedeRbf/IFBipLyZU0aVBnIQX+KDKEsyI6ei6WjS4xNIBBKUNLwsgCWG9/eTihYFscH658ywfW/NH6LcwX7ElvGiLZjFWTjSoU8eXDbOVBYwovknQ7k6pzlrYPBm/IOpj/VVwZB8pzI7z1WLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809359; c=relaxed/simple;
	bh=iaW2egWuutOQzQJPttk8wofrRQitMAilX88Xtvmq36k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsIzW/V6oF57xbDXntDNJtDAO8n3YfizFIsnzCBGp9zPeipHjVcHgajEeLfIQ7cURe6f2EVIUlD8NZ8xN4hWaIbQPjj0bnj3YecEqm/rHk0rmqDugTAUJWbudHbcAL16dpndmiPqJ8ypqgkNPzKlAijqqS6jBYAWF5w4ehmBT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FAHVvM5S; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZLf7M1stN9U84hzkxEqcuZtCDYEdgMJTdlio6Z+ay38=; b=FAHVvM5STRmvOPklSgnsY1Hh0B
	IaOATo77sSgHBrDCAqzqQ8+eUU3SWKrkeG2bMeyIrNTIH6T1OkZaCoqBq3f36glGl/C6Nzeeq1kzY
	Pok0OkXKmyxUJVWVDtt6pljX9dgpnLlDfAFxveExd20FjTnqHv3CPd6S2LS+aEZXo6qHcp145MSR4
	b+uH/zJ1W1Fcw6vsLDNcuO1KZmxVMcu48mh9S1xYrpSK6KU3y3BzYapJIo7vaJiU0uZ++wToktsId
	LWzGcP/+ztp5d3RWmEMHgDv6eMU6dYLHOCE0QEgNqLrSL1+S19jZ/AV/nSxKr1pPMdcbdzdZUIu5Z
	GVpSKkcw==;
Received: from 179-125-91-155-dinamico.pombonet.net.br ([179.125.91.155] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wRtiE-008UnI-Rg; Tue, 26 May 2026 17:28:59 +0200
Date: Tue, 26 May 2026 12:28:49 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>, cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
Message-ID: <ahW8MY4XBox_nsmB@quatroqueijos.cascardo.eti.br>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16319-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email]
X-Rspamd-Queue-Id: A91AE5D985E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:40:01PM +0100, Natalie Vock wrote:
> This helps to find a common subtree of two resources, which is important
> when determining whether it's helpful to evict one resource in favor of
> another.
> 
> To facilitate this, add a common helper to find the ancestor of two
> cgroups using each cgroup's ancestor array.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  include/linux/cgroup.h      | 21 +++++++++++++++++++++
>  include/linux/cgroup_dmem.h |  9 +++++++++
>  kernel/cgroup/dmem.c        | 28 ++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index bc892e3b37eea..560ae995e3a54 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -561,6 +561,27 @@ static inline struct cgroup *cgroup_ancestor(struct cgroup *cgrp,
>  	return cgrp->ancestors[ancestor_level];
>  }
>  
> +/**
> + * cgroup_common_ancestor - find common ancestor of two cgroups
> + * @a: first cgroup to find common ancestor of
> + * @b: second cgroup to find common ancestor of
> + *
> + * Find the first cgroup that is an ancestor of both @a and @b, if it exists
> + * and return a pointer to it. If such a cgroup doesn't exist, return NULL.
> + *
> + * This function is safe to call as long as both @a and @b are accessible.
> + */
> +static inline struct cgroup *cgroup_common_ancestor(struct cgroup *a,
> +						    struct cgroup *b)
> +{
> +	int level;
> +
> +	for (level = min(a->level, b->level); level >= 0; level--)
> +		if (a->ancestors[level] == b->ancestors[level])
> +			return a->ancestors[level];
> +	return NULL;
> +}
> +
>  /**
>   * task_under_cgroup_hierarchy - test task's membership of cgroup ancestry
>   * @task: the task to be tested
> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
> index 1a88cd0c9eb00..9d72457c4cb9d 100644
> --- a/include/linux/cgroup_dmem.h
> +++ b/include/linux/cgroup_dmem.h
> @@ -28,6 +28,8 @@ bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
>  			   struct dmem_cgroup_pool_state *test);
>  bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>  			   struct dmem_cgroup_pool_state *test);
> +struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dmem_cgroup_pool_state *a,
> +							       struct dmem_cgroup_pool_state *b);
>  
>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
>  #else
> @@ -75,6 +77,13 @@ static inline bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>  	return false;
>  }
>  
> +static inline
> +struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dmem_cgroup_pool_state *a,
> +							       struct dmem_cgroup_pool_state *b)
> +{
> +	return NULL;
> +}
> +
>  static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  { }
>  
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 28227405f7cfe..9ae085a7fcb73 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -756,6 +756,34 @@ bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>  }
>  EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
>  
> +/**
> + * dmem_cgroup_get_common_ancestor(): Find the first common ancestor of two pools.
> + * @a: First pool to find the common ancestor of.
> + * @b: First pool to find the common ancestor of.
> + *
> + * Return: The first pool that is a parent of both @a and @b, or NULL if either @a or @b are NULL,
> + * or if such a pool does not exist. A reference to the returned pool is grabbed and must be
> + * released by the caller when it is done using the pool.
> + */
> +struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dmem_cgroup_pool_state *a,
> +							       struct dmem_cgroup_pool_state *b)
> +{
> +	struct cgroup *ancestor_cgroup;
> +	struct cgroup_subsys_state *ancestor_css;
> +
> +	if (!a || !b)
> +		return NULL;
> +
> +	ancestor_cgroup = cgroup_common_ancestor(a->cs->css.cgroup, b->cs->css.cgroup);
> +	if (!ancestor_cgroup)
> +		return NULL;
> +
> +	ancestor_css = cgroup_e_css(ancestor_cgroup, &dmem_cgrp_subsys);

cgroup_e_css must be called in RCU read context. Besides, a reference to
ancestor_css must be got as later on, dmem_cgroup_pool_state_put will call
css_put.

Here is my fixup, which I tested and did not cause RCU or reference
warnings whereas the original patch caused such issues.

Feel free to use it with my sign-off.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Regards.
Cascardo.


diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 72ee8f1d69ef..28adb042baca 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -773,6 +773,7 @@ struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dmem_cgrou
 {
 	struct cgroup *ancestor_cgroup;
 	struct cgroup_subsys_state *ancestor_css;
+	struct dmem_cgroup_pool_state *pool = NULL;
 
 	if (!a || !b)
 		return NULL;
@@ -781,9 +782,15 @@ struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dmem_cgrou
 	if (!ancestor_cgroup)
 		return NULL;
 
+	rcu_read_lock();
 	ancestor_css = cgroup_e_css(ancestor_cgroup, &dmem_cgrp_subsys);
+	if (css_tryget(ancestor_css))
+		pool = get_cg_pool_unlocked(css_to_dmemcs(ancestor_css), a->region);
+	if (!pool)
+		css_put(ancestor_css);
+	rcu_read_unlock();
 
-	return get_cg_pool_unlocked(css_to_dmemcs(ancestor_css), a->region);
+	return pool;
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_get_common_ancestor);
 
-- 
2.47.3


> +
> +	return get_cg_pool_unlocked(css_to_dmemcs(ancestor_css), a->region);
> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_get_common_ancestor);
> +
>  static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
>  {
>  	struct dmem_cgroup_region *region;
> 
> -- 
> 2.53.0
> 

