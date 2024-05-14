Return-Path: <cgroups+bounces-2881-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C818C57B1
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 16:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD603B21A00
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E3144D07;
	Tue, 14 May 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XrAYQPgy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z+ahYdDB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13C1448D9;
	Tue, 14 May 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695810; cv=none; b=onN+VCCCYByVge14V0//NtScC2li7xFZqnAdCe8zcrtp/Anq/cH4C0c9/K2ZJ4ZmI2JRhTbyD8XMbnllUjeP+Xh/A/MFzRMEMBOu3lrDFDw/hWcs2mGvRghTdNawjR7uOqJnKJcTk3uy0PQgwDfeuA64++6FhG8Vk3kfB6xO6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695810; c=relaxed/simple;
	bh=iWP8HSVSOriGJffY8FlJsZ27CjnV1fyLluT/GZJnVxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuTjd9FtLYbePXFfbNkRy6CcpeVFdkA741gABmiEpFxTUjEkgbcoi80+X5x+eq5u2dY+HZPD1XJrq00gwVCSqIMy5kTMNVG5WYsJkk+/52Op7XdTSdCrhSJQIcMucmwM6l1bf9WLjdHTd/FPh/6UjUdcPX2CwZKtUCBN72IUCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XrAYQPgy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z+ahYdDB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF27060CBA;
	Tue, 14 May 2024 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715695801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QyObfHROCQM34yYn3NOjoIfR1A4DlxepS3b18yjnmzo=;
	b=XrAYQPgylTEL7g6Yo5/0DgxiLUTRWRRLkiGhCuK6M3u0Jh6IG/5CTKCMWRR+E8dRbQ+6RR
	hG6t8+TeaIZ6MZT0xraGqIH/czDduJua5MQLpN/yTD7msrAl5QtPiubbmrLiuuPLb6O4Cs
	ggx/XoJa1QHLVomm+XxUiabdGZRghW8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715695800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QyObfHROCQM34yYn3NOjoIfR1A4DlxepS3b18yjnmzo=;
	b=Z+ahYdDBy7cmu/gmrcLI/7WfPEw2IMCy7EqIruO2VnhI9pqPK0VZVAiFVhLrB3MjAiAaYM
	xrMhaZsOhffmyJjSHwqXSk0gcz5v55/3zs3DlWvGZ/0TDCKuZ4iQmFBRHp76a7lAJGsaym
	AaPTg+rL1UCibRfdv8ys7tjDaPIVBUk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D6FE137C3;
	Tue, 14 May 2024 14:10:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sg2vGbhwQ2Z6NwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 14 May 2024 14:10:00 +0000
Date: Tue, 14 May 2024 16:09:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memcg: don't handle event_list for v2 when
 offlining
Message-ID: <ZkNwthw5vJrnQSLL@tiehlicka>
References: <20240514131106.1326323-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514131106.1326323-1-xiujianfeng@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -2.82
X-Spam-Level: 
X-Spamd-Result: default: False [-2.82 / 50.00];
	BAYES_HAM(-2.02)[95.17%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Tue 14-05-24 13:11:06, Xiu Jianfeng wrote:
> The event_list for memcg is only valid for v1 and not used for v2,
> so it's unnessesary to handle event_list for v2.

You are right but the code as is works just fine. The list will be
empty. It is true that we do not need to take event_list_lock lock but
nobody should be using this lock anyway. Also the offline callback is
not particularly hot path. So why do we want to change the code?

> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  mm/memcontrol.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d127c9c5fabf..4254f9cd05f4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5881,12 +5881,14 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	 * Notify userspace about cgroup removing only after rmdir of cgroup
>  	 * directory to avoid race between userspace and kernelspace.
>  	 */
> -	spin_lock_irq(&memcg->event_list_lock);
> -	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
> -		list_del_init(&event->list);
> -		schedule_work(&event->remove);
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> +		spin_lock_irq(&memcg->event_list_lock);
> +		list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
> +			list_del_init(&event->list);
> +			schedule_work(&event->remove);
> +		}
> +		spin_unlock_irq(&memcg->event_list_lock);
>  	}
> -	spin_unlock_irq(&memcg->event_list_lock);
>  
>  	page_counter_set_min(&memcg->memory, 0);
>  	page_counter_set_low(&memcg->memory, 0);
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs

