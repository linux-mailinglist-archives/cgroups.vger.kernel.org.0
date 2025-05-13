Return-Path: <cgroups+bounces-8160-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3287AB52E1
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 12:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E031165A74
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B88267F6E;
	Tue, 13 May 2025 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P3+AzjPF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Okm5l0Q8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P3+AzjPF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Okm5l0Q8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491F26562C
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132710; cv=none; b=M7PM2npF62FL3GLNa8lAAgzWY5hfMFe/s1uVkNGe5mIWkcQAmt8oS1b+noj3k9gncLE/hgUBbxUa9UEeD664gfjOx4h92R20Y9h3lKR+bXqrugtf9T5iryMZUVYP/So8LNIJIxaJ9jMUJdfg6nMawVRpv/SC51YpZvc3zggjFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132710; c=relaxed/simple;
	bh=/Qc3pQgiDkR5qBzJ+yzUbDj5Pl4isZ8xGYkba4Jb8K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOt/Xsv0Na1nw0jHGBKlnHOmaa1JpttGQ90QLNNYvWv7QNaa4yBa5LpDUd6eIm9CP+PzkyX0U2/HVdP/ngIG3BSV2rFZAshT0BbdIzRlAcv6Fg/9HUvZE4PpOWeh0nFwQdp9t7Xbvj7o1fD6CLKti96vrJPAUANP1xmqgFInNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P3+AzjPF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Okm5l0Q8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P3+AzjPF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Okm5l0Q8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B65D821197;
	Tue, 13 May 2025 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747132706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWVeGGrrVccIAgdnNbZOJAAMnTBUdv4oDXowtq87uDk=;
	b=P3+AzjPFkNakHEM95xQQr3oLjUoJk8zOjjvZbxwGUFJpriPDMb0qg2VuQkccnYDOt47vn4
	E1ScVCgBDwJvQWQjcKaF6c7Kr4LBSnlFSgs0ONNjFUg3pXwcVjNseuWwFyY+3JHHclFbkK
	EodTeain+LCy0aM7sOUoaCuup9BVN+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747132706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWVeGGrrVccIAgdnNbZOJAAMnTBUdv4oDXowtq87uDk=;
	b=Okm5l0Q8DGC6QwnBNviCL323g5PTKMmwocNzSZxyqaEZrHstUyWGffiGdeh6rJQhYy2jb0
	1tCK5W2knUNOd7Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747132706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWVeGGrrVccIAgdnNbZOJAAMnTBUdv4oDXowtq87uDk=;
	b=P3+AzjPFkNakHEM95xQQr3oLjUoJk8zOjjvZbxwGUFJpriPDMb0qg2VuQkccnYDOt47vn4
	E1ScVCgBDwJvQWQjcKaF6c7Kr4LBSnlFSgs0ONNjFUg3pXwcVjNseuWwFyY+3JHHclFbkK
	EodTeain+LCy0aM7sOUoaCuup9BVN+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747132706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWVeGGrrVccIAgdnNbZOJAAMnTBUdv4oDXowtq87uDk=;
	b=Okm5l0Q8DGC6QwnBNviCL323g5PTKMmwocNzSZxyqaEZrHstUyWGffiGdeh6rJQhYy2jb0
	1tCK5W2knUNOd7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90CCE137E8;
	Tue, 13 May 2025 10:38:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /YgNIyIhI2i/IAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 10:38:26 +0000
Message-ID: <3eb24d4c-05ec-4c4c-a181-25a987fe69e5@suse.cz>
Date: Tue, 13 May 2025 12:38:26 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/7] memcg: make mod_memcg_state re-entrant safe
 against irqs
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
 <20250513031316.2147548-4-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250513031316.2147548-4-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,linux.dev:email]

On 5/13/25 05:13, Shakeel Butt wrote:
> Let's make mod_memcg_state re-entrant safe against irqs. The only thing
> needed is to convert the usage of __this_cpu_add() to this_cpu_add().
> In addition, with re-entrant safety, there is no need to disable irqs.
> 
> mod_memcg_state() is not safe against nmi, so let's add warning if
> someone tries to call it in nmi context.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Also a good cleanup.

Acked-by: Vlastimil Babka <vbabka@suse.cz>


