Return-Path: <cgroups+bounces-8141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2B2AB3B5E
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14D13B706B
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1E22A7EA;
	Mon, 12 May 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQgRKVzk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZIqE74n7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQgRKVzk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZIqE74n7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E911E503C
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061564; cv=none; b=d14ZPEmbAweqJzW7noT8GpeKcVNwqknnCpUkK7kXs4oXWc4bb+xzcuvxBNKJar6VFv1W13AAnWqH5XYS/Y0OuDN3krlcAHdGyb/4V6gpdIwpg5V2FLsRQEr7w5MGav8aihaeMhwAsdYpNToorgMFAjNGsIVWYI52cCFOT8txSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061564; c=relaxed/simple;
	bh=3Z2eg3E8yt+9yA4QqxprIHh1cIW4jZPwEyAwpNP/Xbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBjTFVKd/8u9bGTwNMBwbT0aXlVTSe8G6qP683/VjvzkLI01grL0lE1tDNW2ZzT/wV+NTHPfSUTkwJxnkMQjMsxr/pp6NU857jw94CzwEEfVIs9ocb0EeOowOIzbJR6ZUu7TLNfk69gEFGu/QJeg9O9wqYbk92k/VCs70SuHt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yQgRKVzk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZIqE74n7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yQgRKVzk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZIqE74n7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93BD82119D;
	Mon, 12 May 2025 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747061561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9UHevEDnKSe6Z9iaB3T6ATKSeVwm+Arr0x7pCh7tqU=;
	b=yQgRKVzk/Y1oFtP7jSXkNSxq5SQWRTNqrBwWjZScYD+1t3h1yeeR/U0ifcNli6pngFK9/H
	i9rdvpWhflmGq2B5Npqvt33CVAwZKXVQxHy6UL6KV4qmqRdQqjHuBN8DPokf165T84SA+E
	392kkXyy5xyREUSF1cuEeq85LxyAMZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747061561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9UHevEDnKSe6Z9iaB3T6ATKSeVwm+Arr0x7pCh7tqU=;
	b=ZIqE74n7cFg7putyLdOi9vmvyNeoHwhIMS08bhUEJymS8geMt2xCLSvh4zFo1pTzLD/3lD
	CIYiUpDzG5IFkGBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747061561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9UHevEDnKSe6Z9iaB3T6ATKSeVwm+Arr0x7pCh7tqU=;
	b=yQgRKVzk/Y1oFtP7jSXkNSxq5SQWRTNqrBwWjZScYD+1t3h1yeeR/U0ifcNli6pngFK9/H
	i9rdvpWhflmGq2B5Npqvt33CVAwZKXVQxHy6UL6KV4qmqRdQqjHuBN8DPokf165T84SA+E
	392kkXyy5xyREUSF1cuEeq85LxyAMZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747061561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9UHevEDnKSe6Z9iaB3T6ATKSeVwm+Arr0x7pCh7tqU=;
	b=ZIqE74n7cFg7putyLdOi9vmvyNeoHwhIMS08bhUEJymS8geMt2xCLSvh4zFo1pTzLD/3lD
	CIYiUpDzG5IFkGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A455137D2;
	Mon, 12 May 2025 14:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XRiBHTkLImgyRQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 May 2025 14:52:41 +0000
Message-ID: <45bf0c55-42c4-4af7-8e77-ac8dba2768dd@suse.cz>
Date: Mon, 12 May 2025 16:52:41 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <20250509182632.8ab2ba932ca5e0f867d21fc2@linux-foundation.org>
 <xe443fcnpjf4nozjuzx2lzwjqkhzhkualcwxk4f5y6e5v7d7vl@h47t3oz3ippf>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <xe443fcnpjf4nozjuzx2lzwjqkhzhkualcwxk4f5y6e5v7d7vl@h47t3oz3ippf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30

On 5/10/25 05:11, Shakeel Butt wrote:
> Before answering the questions, let me clarify that this series is
> continuation of the work which added similar support for page allocator
> and related memcg charging and now the work is happening for
> kmalloc/slab allocations. Alexei has a proposal on reentrant kmalloc and
> here I am providing how memcg charging for that (reentrant kmalloc)
> should work.
> 
> Next let me take a stab in answering the questions and BPF folks can
> correct me if I am wrong. From what I understand, users can attach BPF
> programs at almost any place in kernel and those BPF programs can do
> memory allocations. This line of work is to make those allocations work
> if the any such BPF attach point is triggered in mni context.
> 
> Before this line of work (reentrant page and slab allocators), I think
> BPF had its internal cache but it was very limited and can easily fail
> allocation requests (please BPF folks correct me if I am wrong). This
> was discussed in LSFMM this year as well.
> 
> Now regarding the impact to the users. First there will not be any
> negative impact on the non-users of this feature. For the value this
> feature will provide to users, I think this line of work will make BPF
> programs of the users more reliable with better allocation behavior.
> BPF folks, please add more comments for the value of these features.

Yes and I think this part of cover letter is also important:

> There will be a followup series which will make kernel memory charging
> reentrant for irq and will be able to do without disabling irqs.

The "without disabling irqs" part will improve performance for all users.

