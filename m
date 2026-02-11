Return-Path: <cgroups+bounces-13864-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCDVI2q1jGm5sQAAu9opvQ
	(envelope-from <cgroups+bounces-13864-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 17:59:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 019971265EF
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 232163013734
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA1345725;
	Wed, 11 Feb 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RG+3rD2J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JMbHUV5H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RG+3rD2J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JMbHUV5H"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9628690
	for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829156; cv=none; b=IQ/aJPHtlrhJCsvlYWFKFGVr5XqrAGOrCOo+ArUPpEdGSCdQUn2Tp/xjPP6n04whJyhY8urWkpOVznqt1MUph006wbSo5cGYkCV5iJoUMdnPvJ+PofYxeY2mI4ndZrTQuQzjjbNaR1pdDZEhoNjrriDXS4mFQGa18F5Ah4cNels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829156; c=relaxed/simple;
	bh=aQSg/2H1Jx9Naefx0WovVVHBT+Wi9U53YGUjQ2gaoWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=II6ieQPKmUEa4NuDqqt74H1VkZhDD6RJIRGP4Yt6jzhftsVa4XxXI8AWb6k1tZtSPDr+lz776BJBBVFaP9np6dawEnq3WkhTpmTF24bXkOZZB0ufsKWXVyHM20Ytl12BxqHQ6Uvy0nHE9ax0/xs/rYE/d43o2Lkg+K4mHoSO69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RG+3rD2J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JMbHUV5H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RG+3rD2J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JMbHUV5H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B07725BDDC;
	Wed, 11 Feb 2026 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770829153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K9A/zWvO7Ca3A+6Rp4L1LgDmPtAV9ih5Be5b7ZXx81Q=;
	b=RG+3rD2JmZFOblxH4HoEQuZTshdKV7Gi2Fys5An09Yo3nblQsDLIaZAv5NLWouyKu349sw
	vt5WuRm+1oQX8j6rc07XAuY2ALp/E5TKlgvTg57YsZVLMA6gBhzAydYTtuk/5ZRFNSXkUm
	/HF9raT7k5fdkOiB+uIYNMzNduKiBKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770829153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K9A/zWvO7Ca3A+6Rp4L1LgDmPtAV9ih5Be5b7ZXx81Q=;
	b=JMbHUV5HdetaNeOO6HVO4Rn19fzKF77FDs+WLeKYUx63usUw4P1+Wh7vrvxB5EqsRo/pd4
	NvENfBizJ/0gn0Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770829153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K9A/zWvO7Ca3A+6Rp4L1LgDmPtAV9ih5Be5b7ZXx81Q=;
	b=RG+3rD2JmZFOblxH4HoEQuZTshdKV7Gi2Fys5An09Yo3nblQsDLIaZAv5NLWouyKu349sw
	vt5WuRm+1oQX8j6rc07XAuY2ALp/E5TKlgvTg57YsZVLMA6gBhzAydYTtuk/5ZRFNSXkUm
	/HF9raT7k5fdkOiB+uIYNMzNduKiBKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770829153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K9A/zWvO7Ca3A+6Rp4L1LgDmPtAV9ih5Be5b7ZXx81Q=;
	b=JMbHUV5HdetaNeOO6HVO4Rn19fzKF77FDs+WLeKYUx63usUw4P1+Wh7vrvxB5EqsRo/pd4
	NvENfBizJ/0gn0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 826B43EA62;
	Wed, 11 Feb 2026 16:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NYLxHmG1jGnoUgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 11 Feb 2026 16:59:13 +0000
Message-ID: <40b42d83-3667-4489-818f-a01e1114d6b0@suse.cz>
Date: Wed, 11 Feb 2026 17:59:13 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Content-Language: en-US
To: Marcelo Tosatti <mtosatti@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Frederic Weisbecker <fweisbecker@suse.de>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka> <aYyzZbh/YRMDcviS@tpad>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aYyzZbh/YRMDcviS@tpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13864-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,gmail.com,redhat.com,linutronix.de,suse.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Queue-Id: 019971265EF
X-Rspamd-Action: no action

On 2/11/26 17:50, Marcelo Tosatti wrote:
> On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
>> On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
>> > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
>> [...]
>> > > What about !PREEMPT_RT? We have people running isolated workloads and
>> > > these sorts of pcp disruptions are really unwelcome as well. They do not
>> > > have requirements as strong as RT workloads but the underlying
>> > > fundamental problem is the same. Frederic (now CCed) is working on
>> > > moving those pcp book keeping activities to be executed to the return to
>> > > the userspace which should be taking care of both RT and non-RT
>> > > configurations AFAICS.
>> > 
>> > Michal,
>> > 
>> > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
>> > boot option qpw=y/n, which controls whether the behaviour will be
>> > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
>> 
>> My bad. I've misread the config space of this.
> 
> My bad, actually. Its only CONFIG_QPW on the current patchset.
> 
>> > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
>> > (and remote work via work_queue) is used.
>> > 
>> > What "pcp book keeping activities" you refer to ? I don't see how
>> > moving certain activities that happen under SLUB or LRU spinlocks
>> > to happen before return to userspace changes things related 
>> > to avoidance of CPU interruption ?
>> 
>> Essentially delayed operations like pcp state flushing happens on return
>> to the userspace on isolated CPUs. No locking changes are required as
>> the work is still per-cpu.
>> 
>> In other words the approach Frederic is working on is to not change the
>> locking of pcp delayed work but instead move that work into well defined
>> place - i.e. return to the userspace.
>> 
>> Btw. have you measure the impact of preempt_disbale -> spinlock on hot
>> paths like SLUB sheeves?
> 
> Nope, i have not. What is/are the standard benchmarks for SLUB/SLAB
> allocation ?

Those mentioned here, and I would say also netperf.
https://lore.kernel.org/all/20250913000935.1021068-1-sudarsanm@google.com/



