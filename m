Return-Path: <cgroups+bounces-4592-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A32964CFB
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 19:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF41282CFC
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823161B6548;
	Thu, 29 Aug 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQXwmBqT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lHOsBi8Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQXwmBqT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lHOsBi8Z"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512FD4D8AD;
	Thu, 29 Aug 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953176; cv=none; b=s5OWsSlVW0FcUbr4lhry3Kc7Tf1msK8NXZyjgzNmMgI7SnSJe6DzdFu3DMJb7B7trnjlttsWhEXX5OisvfhfiOC6jZYEJ3g79AuYXmCdbIkIDupA97E3G3pySxEUxUSqOG1CMCxoaCT7McGA82137EjPpA+NISj4KXfwDVb7zjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953176; c=relaxed/simple;
	bh=m0bNnA/F1PUbxFYlW3mu2ORO/RgzKqGUvIV3bXnYGDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bt3oHpHdKssG5XCtSyuFiB8kvmj3IgGs+ZocUhC0bNvX7JFk1gs2Z/f2C7lzCycKcJWPUHXmfRvqWNDMQhNdi/uaH9Bz56TNVruh3KuSQ0elQektcwDzKnUXr60mvaMU9rMGT9+b0pgqM/40Vcrw5laBwvfAU1RWqSLLa+IO7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQXwmBqT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lHOsBi8Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQXwmBqT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lHOsBi8Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7308A1F454;
	Thu, 29 Aug 2024 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724953172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knYaAgVRYgshjI/uTZOG3uXVzF6WdqSQAdgmVYbAPhg=;
	b=iQXwmBqTb6gtNnQLpZcv6wOaz9oWVyOmrqO+nCgQdragRwcUpFPDngzsUVg//UQPbksLIs
	LPSnbyRRy4EZKP3NbrWGbwcLVrlLVwZPwGztnJh6tu7dyDJRzd8F4kSRU2ppsgJo2SisZ4
	PwxcKcfZYaRauiu0DfCd0M000f24too=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724953172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knYaAgVRYgshjI/uTZOG3uXVzF6WdqSQAdgmVYbAPhg=;
	b=lHOsBi8ZqDK3eBDaqyO3bHzw7Buj+HXZBcKAx8nd5xkil7TVzehaH3n8VvfmSaX6hm7TC+
	+acazPPRYDFZpjCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724953172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knYaAgVRYgshjI/uTZOG3uXVzF6WdqSQAdgmVYbAPhg=;
	b=iQXwmBqTb6gtNnQLpZcv6wOaz9oWVyOmrqO+nCgQdragRwcUpFPDngzsUVg//UQPbksLIs
	LPSnbyRRy4EZKP3NbrWGbwcLVrlLVwZPwGztnJh6tu7dyDJRzd8F4kSRU2ppsgJo2SisZ4
	PwxcKcfZYaRauiu0DfCd0M000f24too=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724953172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knYaAgVRYgshjI/uTZOG3uXVzF6WdqSQAdgmVYbAPhg=;
	b=lHOsBi8ZqDK3eBDaqyO3bHzw7Buj+HXZBcKAx8nd5xkil7TVzehaH3n8VvfmSaX6hm7TC+
	+acazPPRYDFZpjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E47F13408;
	Thu, 29 Aug 2024 17:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 16mzElSy0GY4DwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 29 Aug 2024 17:39:32 +0000
Message-ID: <a21841c4-6d40-42cb-88cb-eee5f80ccf11@suse.cz>
Date: Thu, 29 Aug 2024 19:39:32 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <9fb06d9b-dec5-4300-acef-bbce51a9a0c1@suse.cz>
 <mvxyevmpzwatlt7z4fdjakvuixmp5hcqmvo3467kzlgp2xkbgf@xumnm2y6xxrg>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <mvxyevmpzwatlt7z4fdjakvuixmp5hcqmvo3467kzlgp2xkbgf@xumnm2y6xxrg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,google.com,gmail.com,davemloft.net,redhat.com,kvack.org,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 8/29/24 18:10, Shakeel Butt wrote:
> On Thu, Aug 29, 2024 at 11:42:10AM GMT, Vlastimil Babka wrote:
>> On 8/28/24 01:52, Shakeel Butt wrote:
>> > At the moment, the slab objects are charged to the memcg at the
>> > allocation time. However there are cases where slab objects are
>> > allocated at the time where the right target memcg to charge it to is
>> > not known. One such case is the network sockets for the incoming
>> > connection which are allocated in the softirq context.
>> > 
>> > Couple hundred thousand connections are very normal on large loaded
>> > server and almost all of those sockets underlying those connections get
>> > allocated in the softirq context and thus not charged to any memcg.
>> > However later at the accept() time we know the right target memcg to
>> > charge. Let's add new API to charge already allocated objects, so we can
>> > have better accounting of the memory usage.
>> > 
>> > To measure the performance impact of this change, tcp_crr is used from
>> > the neper [1] performance suite. Basically it is a network ping pong
>> > test with new connection for each ping pong.
>> > 
>> > The server and the client are run inside 3 level of cgroup hierarchy
>> > using the following commands:
>> > 
>> > Server:
>> >  $ tcp_crr -6
>> > 
>> > Client:
>> >  $ tcp_crr -6 -c -H ${server_ip}
>> > 
>> > If the client and server run on different machines with 50 GBPS NIC,
>> > there is no visible impact of the change.
>> > 
>> > For the same machine experiment with v6.11-rc5 as base.
>> > 
>> >           base (throughput)     with-patch
>> > tcp_crr   14545 (+- 80)         14463 (+- 56)
>> > 
>> > It seems like the performance impact is within the noise.
>> > 
>> > Link: https://github.com/google/neper [1]
>> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>> > ---
>> > v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
>> > Changes since v1:
>> > - Correctly handle large allocations which bypass slab
>> > - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
>> > 
>> > RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
>> > Changes since the RFC:
>> > - Added check for already charged slab objects.
>> > - Added performance results from neper's tcp_crr
>> > 
>> >  include/linux/slab.h            |  1 +
>> >  mm/slub.c                       | 51 +++++++++++++++++++++++++++++++++
>> >  net/ipv4/inet_connection_sock.c |  5 ++--
>> >  3 files changed, 55 insertions(+), 2 deletions(-)
>> 
>> I can take the v3 in slab tree, if net people ack?
> 
> Thanks.
> 
>> 
>> BTW, will this be also useful for Linus's idea of charging struct files only
>> after they exist? But IIRC there was supposed to be also a part where we
>> have a way to quickly determine if we're not over limit (while allowing some
>> overcharge to make it quicker).
>>
> 
> Do you have link to those discussions or pointers to the code? From what
> you have described, I think this should work. We have the relevant gfp
> flags to control the charging behavior (with some caveats).

I think this was the last part of the discussion, and in the cover letter of
that there are links to the older threads for more context

https://lore.kernel.org/all/CAHk-%3DwhgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0%3Dm1A@mail.gmail.com/

>> Because right now this just overcharges unconditionally, but that's
>> understandable when the irq context creating the socket can't know the memcg
>> upfront. In the open() situation this is different.
>> 
> 
> For networking we deliberately overcharges in the irq context (if
> needed) and the course correct in the task context. However networking
> stack is very robust due to mechanisms like backoff, retransmit to handle
> situations like packet drops, allocation failures, congestion etc. Other
> subsystem are not that robust against ENOMEM. Once I have more detail I
> can follow up on the struct files case.

Ack. Agreed with Roman that it would be a separate followup change.

> thanks,
> Shakeel
> 
> 


