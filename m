Return-Path: <cgroups+bounces-7065-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F47A60E45
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57770174F41
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 10:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5BB1F3BA4;
	Fri, 14 Mar 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpc9oY/8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IMhookhB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpc9oY/8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IMhookhB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686A13D246
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946999; cv=none; b=ChBvaiJiUWSCUVxlaYKg6DKqMNxQOu5E/MJiOknPq4T5RbmWPWqomLQJ7fIbJBIDYCj9DAfYped8uaGxR+jBEIOjDgs5yGHIDr71c7jL6lToKzx/btlbI1ePsWV/X+V8Bj9tT8K3cJ3M2UjTVufuLeqKFMTO4qynMSmvmf3Gj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946999; c=relaxed/simple;
	bh=jfLIebV3RBYaQmbQzr8YK9AEH8j3uypq/FS/4NkVIqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCcX+wEg5QkjNDdnmWA2QdBdR2gmjjrrhfa6tSHkDwdoGRzGJpGQxxuERDxcopK+uvop22evto0Eb5roT0ZwYlrcF+UDJKpXJ2gR1GZ5u5FS7gEnVXbwQcEp50YB1EXswZQxuXAzioybM/491/My6LuPZFmIq5shRmPvuRbZgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpc9oY/8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IMhookhB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpc9oY/8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IMhookhB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 933AB1F388;
	Fri, 14 Mar 2025 10:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741946995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXnVELVgbyUWhUtsRgP+HE2A9luq8SRAoNjEclIW8Kw=;
	b=lpc9oY/8VhhdfdQwOx37TTBd7ACoo58hHHoJmmAij+k/UxaYp26dEHq4OTAcaVdb3Odxfk
	dKFPGEZj+tbHGE25F/eSfMqS2A/NfX8FfeoMdxbbypf9DkpNXtPEGUOKmEeylUnSJQZySN
	FHt7TnIfAm5fO1iQTEWAYt3ykguCa0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741946995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXnVELVgbyUWhUtsRgP+HE2A9luq8SRAoNjEclIW8Kw=;
	b=IMhookhBwe2k/Xbd3Tpr8al72DMQupgmNX10mRiI/1/FJ4zB93BNENkq1+CtIPjq8ih6Mg
	/sWdqq+dmK5sZoDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741946995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXnVELVgbyUWhUtsRgP+HE2A9luq8SRAoNjEclIW8Kw=;
	b=lpc9oY/8VhhdfdQwOx37TTBd7ACoo58hHHoJmmAij+k/UxaYp26dEHq4OTAcaVdb3Odxfk
	dKFPGEZj+tbHGE25F/eSfMqS2A/NfX8FfeoMdxbbypf9DkpNXtPEGUOKmEeylUnSJQZySN
	FHt7TnIfAm5fO1iQTEWAYt3ykguCa0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741946995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXnVELVgbyUWhUtsRgP+HE2A9luq8SRAoNjEclIW8Kw=;
	b=IMhookhBwe2k/Xbd3Tpr8al72DMQupgmNX10mRiI/1/FJ4zB93BNENkq1+CtIPjq8ih6Mg
	/sWdqq+dmK5sZoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D91513A31;
	Fri, 14 Mar 2025 10:09:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pU9wGnMA1GfQXwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 10:09:55 +0000
Message-ID: <1058dae6-c89b-45ad-83c1-d903fd9532ae@suse.cz>
Date: Fri, 14 Mar 2025 11:09:55 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/10] memcg: no refilling stock from
 obj_cgroup_release
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-6-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250314061511.1308152-6-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/14/25 07:15, Shakeel Butt wrote:
> obj_cgroup_release is called when all the references to the objcg has
> been released i.e. no more memory objects are pointing to it. Most
> probably objcg->memcg will be pointing to some ancestor memcg and at the
> moment, in obj_cgroup_release, the kernel call
> obj_cgroup_uncharge_pages() to uncharge last remaining memory.
> 
> However obj_cgroup_uncharge_pages() refills the local stock. There is
> no need to refill the local stock with some ancestor memcg and flush the
> local stock. In addition this removes the requirement to only call
> obj_cgroup_put() outside of local_lock.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memcontrol.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7054b0ebd207..83db180455a1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -129,8 +129,7 @@ bool mem_cgroup_kmem_disabled(void)
>  	return cgroup_memory_nokmem;
>  }
>  
> -static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
> -				      unsigned int nr_pages);
> +static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
>  
>  static void obj_cgroup_release(struct percpu_ref *ref)
>  {
> @@ -163,8 +162,16 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>  	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
>  	nr_pages = nr_bytes >> PAGE_SHIFT;
>  
> -	if (nr_pages)
> -		obj_cgroup_uncharge_pages(objcg, nr_pages);
> +	if (nr_pages) {
> +		struct mem_cgroup *memcg;
> +
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
> +		memcg1_account_kmem(memcg, -nr_pages);
> +		if (!mem_cgroup_is_root(memcg))
> +			memcg_uncharge(memcg, nr_pages);
> +		css_put(&memcg->css);
> +	}
>  
>  	spin_lock_irqsave(&objcg_lock, flags);
>  	list_del(&objcg->list);


