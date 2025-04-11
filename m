Return-Path: <cgroups+bounces-7468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C5A856B4
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 10:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DE27B7A97
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD62989AE;
	Fri, 11 Apr 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUkApBZH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lo3hGV31";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUkApBZH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lo3hGV31"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380D2989B0
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360446; cv=none; b=nIe16szlprtkNHdEk8db9Ii7Lhmac1yA+/absOePFtl0bdQC4N/wxMAbZ5pm4MrA1O/juh2tX6516KktnlIYBeoaKBQ58HeFusLmtotlzBFdUgXqyU2nYpwrqFDy0rrh23IUoYVh+uHUXznJlDHqehyks5f45/Zk5LL2+wMpd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360446; c=relaxed/simple;
	bh=xyfnsPjK02G6fiQJAYHQu/V8ZYcqHqst11v75l/DzXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WH6IX4NSydVDflfhxS/T6kRL9QkWrfEwWAd8PizrhjlyfQJLGzHaC68sXqQ4eGX41oV+xnAb2bjngW509B7nJjcTn4RKBm6RUoSbFeqn/pEKEHEx+rF1QK2pPSuvSxgblV7FS4TzSqfmA4aHITQGNRxL7zkaQ6b8CmUgS0Whjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUkApBZH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lo3hGV31; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUkApBZH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lo3hGV31; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A7C01F458;
	Fri, 11 Apr 2025 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744360443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvR2MR5akiMkWM7G6pD3bcsB9f1HRyvTUPK0rbyM7Qo=;
	b=iUkApBZHuhQIx1gB/kbdB2B9bzWpQ6NxCPydF9UfBzYzm+hBHbydOL7H7bIGU+s7kEZ6uP
	kcVlUFeKH1220FMo5idUv0Jt1cBMTwdA1DhLqSKDfp9cyjxoTK7y7Xr0M5gNQhKPn3tflp
	HlrOtOPXuniKB0WAK8pTYAWMXHpwdQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744360443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvR2MR5akiMkWM7G6pD3bcsB9f1HRyvTUPK0rbyM7Qo=;
	b=lo3hGV31CxICzaKWRI1fSuEMyTGkWWzQ4hSWLdW3/q7ymJn0zOXrtoFIsI7o78n0dUtQdV
	gE04kULO5PE0KPBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iUkApBZH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lo3hGV31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744360443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvR2MR5akiMkWM7G6pD3bcsB9f1HRyvTUPK0rbyM7Qo=;
	b=iUkApBZHuhQIx1gB/kbdB2B9bzWpQ6NxCPydF9UfBzYzm+hBHbydOL7H7bIGU+s7kEZ6uP
	kcVlUFeKH1220FMo5idUv0Jt1cBMTwdA1DhLqSKDfp9cyjxoTK7y7Xr0M5gNQhKPn3tflp
	HlrOtOPXuniKB0WAK8pTYAWMXHpwdQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744360443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvR2MR5akiMkWM7G6pD3bcsB9f1HRyvTUPK0rbyM7Qo=;
	b=lo3hGV31CxICzaKWRI1fSuEMyTGkWWzQ4hSWLdW3/q7ymJn0zOXrtoFIsI7o78n0dUtQdV
	gE04kULO5PE0KPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0279C136A4;
	Fri, 11 Apr 2025 08:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tr4ZAPvT+GcxFgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Apr 2025 08:34:03 +0000
Message-ID: <03330910-9fbb-452b-b817-5bc24462f8aa@suse.cz>
Date: Fri, 11 Apr 2025 10:34:02 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] memcg: do obj_cgroup_put inside drain_obj_stock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250404013913.1663035-1-shakeel.butt@linux.dev>
 <20250404013913.1663035-7-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250404013913.1663035-7-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1A7C01F458
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/4/25 03:39, Shakeel Butt wrote:
> Previously we could not call obj_cgroup_put() inside the local lock
> because on the put on the last reference, the release function
> obj_cgroup_release() may try to re-acquire the local lock. However that
> chain has been broken. Now simply do obj_cgroup_put() inside
> drain_obj_stock() instead of returning the old objcg.
> 
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


