Return-Path: <cgroups+bounces-7066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5777DA60E97
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D88F1B60C77
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273A1F3D54;
	Fri, 14 Mar 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wfpY08Pu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqGeIASK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wfpY08Pu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqGeIASK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AC1F3BAC
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947452; cv=none; b=rds9lMNZ5c4mldaqX5Z4fEJ6VbRcSyzTpRw5qJhYbF0Ksgt26S9fQpbfY+r8RX7Lvh5TqAAC5UEx2MuNVZ9of+BmXh4Dwb8BETn6qJnZzUmDFwIhh0cgIg1g6PV2kKVbepcGqkdmPO61uXEDSMox79z0j7KmzzqZvqZt2xuG35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947452; c=relaxed/simple;
	bh=TSavoFdfPhmtgoCkF+2Znr7zfY08nKF/mjvV7zh1hsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3QBoo1S/kwdjdG/d1Mi0mEx9tRloFNNY3y163E6SZSj3TJauIqlAbSTDVqiNjEC7vtCVwoWcDhm0KN9U8VnuLg1yF09g3voqyJdPpkg5gk3DEZ7buu0QBk+fFWAPOau7xHEpsoyDMazQoA5XTviW3ChMlJV6QoHF+hw0yH7EVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wfpY08Pu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqGeIASK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wfpY08Pu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqGeIASK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26F9021185;
	Fri, 14 Mar 2025 10:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741947449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFwz+gJLZlMOek5VuKRc/mEh2xiuy371OM7h0EN1qmk=;
	b=wfpY08Pux9+iWkKXg+MjBJT1CJ5EOCKXyFkN4Jzmor4ZMqe3yBCnRUtBWE6G527vqcC1gk
	t0i2Raw6XsU+km4Za93VLm5uiQa6IU2uNljMO4gOlZAmxIjYPYUJlNjSMQ42juPiOejNX0
	CI4kggzZrsbGAuGm2m2XcCPxFgjxLuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741947449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFwz+gJLZlMOek5VuKRc/mEh2xiuy371OM7h0EN1qmk=;
	b=yqGeIASKR5y2z+DLp8wkczZc1LdisO6Sq751Y2XwKVac9O67H+eCI8S+UXdzxLtalmgoFh
	i3k8rh8h2P4MB7BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741947449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFwz+gJLZlMOek5VuKRc/mEh2xiuy371OM7h0EN1qmk=;
	b=wfpY08Pux9+iWkKXg+MjBJT1CJ5EOCKXyFkN4Jzmor4ZMqe3yBCnRUtBWE6G527vqcC1gk
	t0i2Raw6XsU+km4Za93VLm5uiQa6IU2uNljMO4gOlZAmxIjYPYUJlNjSMQ42juPiOejNX0
	CI4kggzZrsbGAuGm2m2XcCPxFgjxLuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741947449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFwz+gJLZlMOek5VuKRc/mEh2xiuy371OM7h0EN1qmk=;
	b=yqGeIASKR5y2z+DLp8wkczZc1LdisO6Sq751Y2XwKVac9O67H+eCI8S+UXdzxLtalmgoFh
	i3k8rh8h2P4MB7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFAF513A31;
	Fri, 14 Mar 2025 10:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0UTnOTgC1Gc4YgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 10:17:28 +0000
Message-ID: <0b3ab5e5-e684-44ce-b6ed-276ad37784e6@suse.cz>
Date: Fri, 14 Mar 2025 11:17:28 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/10] memcg: do obj_cgroup_put inside drain_obj_stock
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
 <20250314061511.1308152-7-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250314061511.1308152-7-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/14/25 07:15, Shakeel Butt wrote:
> Previously we could not call obj_cgroup_put() inside the local lock
> because on the put on the last reference, the release function
> obj_cgroup_release() may try to re-acquire the local lock. However that
> chain has been broken. Now simply do obj_cgroup_put() inside
> drain_obj_stock() instead of returning the old objcg.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Hm is this really safe? I can see obj_cgroup_release() doing
percpu_ref_exit() -> kfree(), do we have guaranteed that allocation won't be
also in a kmemcg and recurse?




