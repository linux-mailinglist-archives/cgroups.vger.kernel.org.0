Return-Path: <cgroups+bounces-14712-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNtPEKGYrmmBGgIAu9opvQ
	(envelope-from <cgroups+bounces-14712-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 10:53:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DF9236901
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE624303DD30
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2026 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D711138737D;
	Mon,  9 Mar 2026 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmiafaaU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016E38551E;
	Mon,  9 Mar 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049982; cv=none; b=WLdQlVpTkdjQGqx9wRR4thLjlPupiGgfG8hPZxPpopv+zuJXHI1QusQBCB1okbvJsVqWGa/QLivyMH4zgHAD+eT3IIINErx3w8pBb28n9GKU3KKv+7DTft7Inu4Qa5K34Iivz+fjRkQWcPhBlzoGi3IQCqx+hc3+Q28voJz89cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049982; c=relaxed/simple;
	bh=PMIuKPsEvPXOB7oPgsM4Nr0xqxaEsQcqjc5S8SS+m8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQ4x08bwWNHl1jGw6iXkfgLsMtYwKXI6lSYOPHY00+BmC9WPTNXnrn08H4eoU890Yr9eri7UdIvMl8f5eVPmBRRMqYAJlV4KXFuMYoHFSzJsJbw42Prp+AugksuGXjcfC8jxw9VfVciXurBsyUvm9k6RfqrDz1TeGq5cUOm2GC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmiafaaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B89C4CEF7;
	Mon,  9 Mar 2026 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773049981;
	bh=PMIuKPsEvPXOB7oPgsM4Nr0xqxaEsQcqjc5S8SS+m8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WmiafaaUd3N0urhZWm8ej60bzApAWQpt38JX2BoGr8OV3tszUuCJojKJMQmYGdJ7W
	 V9ZbwFBsf3RvRRBvf64aM99RzGfnI6VWkyivf4ZCXOhHJrOyJT1wo6kpxeMJIK0Pmw
	 O7H3J/IumMBFvtMEh5bfxgrIpVQ0tPc7ggQzTNSnbh3/hzml5wwraMlQ7GFkUt6CMo
	 vPXRZ+fzEvf6PqDOraPeM+pWGxu0R/MO6kMV39rYN6HkXH3aaB5DTR8LjuqgabY7jh
	 cP8GCa9K2RzX+qioulCI1ELzbTJD/VWY0bFe5y0mj7qmsdOijRN+Sp8gAcUgJDz4IT
	 NWvu6F0HYsBaQ==
Message-ID: <cbd42744-31e1-439c-b0f0-0cad052d3d9b@kernel.org>
Date: Mon, 9 Mar 2026 10:52:55 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
To: Leonardo Bras <leobras.c@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Frederic Weisbecker <fweisbecker@suse.de>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash> <aZL45yORfkNvS9Rs@tiehlicka>
 <aZjY9h3XXMNY-Ytd@WindFlash> <aZwYmNuucBspCYhk@tiehlicka>
 <aaJDjmnfuo8AM6J9@WindFlash> <aaYpICV55B70U1I2@tpad>
 <aa20uDGqnmiqYJ1w@WindFlash>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <aa20uDGqnmiqYJ1w@WindFlash>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A3DF9236901
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14712-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,gmail.com,redhat.com,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/8/26 18:41, Leonardo Bras wrote:
> Hi Marcelo,
> 
> Great, hiding migrate_disable under the static branch is the best scenario.
> 
> I wonder why we spend 2 cycles on the static branches, though, should be 
> close to nothing unless the branch predictor is too busy already. Well, we 

AFAIK static branches are runtime patched to non-conditional jumps or nops,
so there's nothing left for the branch predictor to do. Or maybe I
misunderstand your comment.
It does however increase code footprint and thus instruction cache usage, so
maybe that's an effect of that.

> can always try to optimize in a different way.
> 
> Thanks for the effort on this!
> Leo

