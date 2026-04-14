Return-Path: <cgroups+bounces-15290-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD0NBsfz3WmMlQkAu9opvQ
	(envelope-from <cgroups+bounces-15290-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 09:59:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DAD3F6D43
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 09:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C03D3050C21
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF4F386C0A;
	Tue, 14 Apr 2026 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxNNWlJe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA4382F00;
	Tue, 14 Apr 2026 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153402; cv=none; b=qd5+NfrkndZkNZW6k2PcgDq4Hy64AsjjBdlJ9bV72WslPNYbDVLE3diiifOX14CREqckIBHRUEmQ6bWWBOKO/iWJdEP7ZEdk85lpvPrkfDHAM7skjt2zXuy9xq2AqSk9v/lJA+JGTr/NF/KmDPHE6IA6KUg2xcfzLFZCpBG3bJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153402; c=relaxed/simple;
	bh=MF/GH4Czp0/CzU5o1NW/2mD2/47rYS+yvk8ECsG09p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDYS9DBwk4vL+PNQwhtqH7EqDJ0x9kglLO3wA5O0hsABI34HskAkRgTVsY4EwbKh2ToMtcsjBySVbpsIGwewNcNLO3peXP3ortB4drJ4BJKZtt0mFzuSNUz7ray63ucgZ16EA2PkNEp8rv9J24inKJumv27i01Ry+yiX0SpQNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxNNWlJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB928C19425;
	Tue, 14 Apr 2026 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776153401;
	bh=MF/GH4Czp0/CzU5o1NW/2mD2/47rYS+yvk8ECsG09p0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SxNNWlJeD5aohOwDA3UkElufaBir7/GNQbd0STtHgax6fm620fA3M1/yHj/e1LkC/
	 HugQj9UB8Z3rF61Ifmjq5/UN0LoYVyGyt0r328Nkx4gYET5Oj6MfG/IP6lwuZ8a+nL
	 QykXPzLtkRXaTJocTjQuRT88y9HJpES6Smzpk7PZ3MwQXOJ+BpAi6HoJyVxNEOeMVU
	 G4ztlGlMM0a9KkZANrWgosRSGYNSaNSRJWgIgQIINSZGt12U8lI5CohU5ZYKOvWp+G
	 53aOSuX0qa8nwDkonPSp5S9MOdIn8qGMFQJaB4r7jAgOfnqdfIdGHCRjsnn/7tghPX
	 bsksHMA4MzY/Q==
Message-ID: <ef2d8f65-b3b4-4a9c-a77f-78ad1cadff28@kernel.org>
Date: Tue, 14 Apr 2026 09:56:36 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memcontrol: restore irq wrapper for
 lruvec_stat_mod_folio()
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>, Cao Ruichuang <create0818@163.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com
References: <20260413064833.964-1-create0818@163.com>
 <ad0clnEYxf1H4_S1@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ad0clnEYxf1H4_S1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15290-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,1a3353a77896e73a8f53];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4DAD3F6D43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 18:44, Shakeel Butt wrote:
> On Mon, Apr 13, 2026 at 02:48:33PM +0800, Cao Ruichuang wrote:
>> Commit c1bd09994c4d ("memcg: remove __lruvec_stat_mod_folio") removed
>> the local_irq_save/restore wrapper around lruvec_stat_mod_folio(), based
>> on the assumption that the underlying stat update path was already
>> IRQ-safe.
> 
> Why is that an assumption? Please explain how lruvec_stat_mod_folio() is not
> safe against IRQs?
> 
>> 
>> That assumption is too broad for lruvec_stat_mod_folio() callers.
>> This helper is not just a thin stat primitive.  It also resolves
>> folio -> memcg -> lruvec under a helper-managed RCU read-side section.
>> 
>> syzbot now reports a PREEMPT_RT warning from:
> 
> The syzbot link you have provided has the kernel config without PREEMPT_RT?
> Where does this claim come from?
> 
>> 
>>   __filemap_add_folio()
>>     -> lruvec_stat_mod_folio()
>>        -> __rcu_read_unlock()
>> 
>> ending in bad unlock balance / negative RCU nesting.
> 
> If there is bad unlock balance, how is disabling/enabling IRQs would solve that
> issue?

This is obviously a product of LLM producing a patch from the syzbot report.
I suggest we ignore everything from this author.

