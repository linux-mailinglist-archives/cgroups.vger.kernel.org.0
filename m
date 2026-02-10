Return-Path: <cgroups+bounces-13830-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFv5HIg6i2neRgAAu9opvQ
	(envelope-from <cgroups+bounces-13830-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 15:02:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3E11BAC1
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 15:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438103063D7D
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E636605C;
	Tue, 10 Feb 2026 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Og1WAsY4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505873590CC
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732075; cv=none; b=ScYMO4qpLRt50eIbE9DQt4NhJM2n5jA7hRtiiKQlk7f/pG6W/D4wrtC9D/m8u3pox7YBuxb9kEGdZhIAgp5AEnMCuahqRk456tue24b1BNU13V+5ASyknhnsqaDEmcVCGwc81/YfwRRUhpPgchEdsmiXUVoVU2Cp12xs+fWW52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732075; c=relaxed/simple;
	bh=+50oF9u4n9eTXHH4cVzoVk6iIl3FH4/Tov0ZyJpcWkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XloUW3tKlg8mkeJQ4QSMDWXbDJIMLkEUz8PLa7ZE5+GRH8ScO7qaYNgYCUbjcBMxDk9jJvM8mrCR1kV7waBR0Gq76ZvOfRoMtu/nduFFSMfsVLgezFdx+QA1LF8b2pXQanxvNww1zxXP/fl8D3FtMdHEMmGOsaS7T2fr6YIHhNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Og1WAsY4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362197d174so602208f8f.3
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 06:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770732073; x=1771336873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FnxXnVFI1K0nd8Coyw5JESfQAuts9vipw7Dj/0GRW4=;
        b=Og1WAsY4cH7OMJmrKX0jMX4fYSyOXKLWMMsHdbjXE3hHAFUyn2uD0K9PCOuAg41qRx
         aT+WarygDf4jI+NJQr9qfP062ewgMhUlhUZ1/M05SivHOn7hHqvrbsCcewh3hQ9FO14W
         Ulj57OvNiYQtlQMAdriYczyJwOE3CAYCyCVpbYGcQN09gNdR7JEp3Ncc5LXVZjUvqLNH
         kChhg+zRR3LeUKD5mpjjsNEBXpDBEck4bPEJapuvrQDXgoS1DjLlipYS8AF3oArlNszO
         cYdFsv9Do2hLdKfmnPo65E8PRqFKOeRljB7iSLuNPBb2Mw5BvgLkOpF/zYmPIswTIJ4I
         OgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770732073; x=1771336873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FnxXnVFI1K0nd8Coyw5JESfQAuts9vipw7Dj/0GRW4=;
        b=ga6eb85v6zlKkpU81FVOMrhucqiesSPydq06gkvMTrC074LUsgzJpbDGHStRxLiWhk
         D+s+b6gAHOTftg+Ci/04qduzftXKsVSiHQ/ak19pkZP1gHF8G2puTJHPV50PHIRflI8R
         tQKpN8+aFYD7RG6z/32Y1mkrnAW0bP3vXQjQdLwYBSrPraspy/s1HbzGFb29D0ibeOLK
         n3kA9mZ+F++WF1jitqg148vrC63Yws3GhNLcniZxNiDGsWVlqMgC4gDcqY8zxtb00EGy
         v1/EUFiT6qiy7BfFQOraMol/nUX3yIltMMnfjpG8eD9P3anNoxAPudMIc+AUaojGxgRT
         we6w==
X-Forwarded-Encrypted: i=1; AJvYcCWr7CiKdZpoO07ySlU19Du3frHnbOqQqsMl0PiW9xcd7wJuMWshVhUPA3B2aaZRXDQUex9rRFWs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1j+4tca1mjCIwFtd92zY8ZbQN+oxFwaDPdzhTs0o+cawHE3RZ
	xcuwBvQz5g25QYE38X7Xl7R5yVAGJC4LH6Y1v9+BRoAbF+uUAS8n1H4CwnW89/GSDtA=
X-Gm-Gg: AZuq6aJAtv9PBnbx77+L6IA3wAg1pCohKPgdryAceruMvsPynwBJrT6gfk5V9M2ScY2
	UddHcpD38reEqEG3VzuRQFj+ku+0gKar37dqaGtCsjtL9hNqiOXKDgCqS03TquoBUmCjXvEnx2M
	Oj03GZh1W5PY/OYHwN8I4w0CpqMy0vfyyI5a549E3A6JtnR1cLRi7JO0riRbdSO4bNU41gnsxrb
	uwWgrAcEz6iCOZySfpElVml5FJ5tb3UuRtZ8fh7+1ZFpVR8zZSvhJbqtDqFW45MbMQyEFWIVTUb
	3J8nibnt/HO8X/s4OQOT9C+mDtEprAknuYfGioK06UOCgrzwrF6g6DdxIcmqiKVwZoKIfUJmgGg
	rec5E3MU6Nw4s/+O5tnQ7s7XogB3XptuXcKKfK34Pp8iKHJ8blMafZhIw51uKbOaYt54qnJ34go
	lgkCNBW5zQmXeJJ0ZjdYdWNXpJpsj5JxGPwvxB
X-Received: by 2002:a05:6000:2382:b0:437:678a:5921 with SMTP id ffacd0b85a97d-437678a5b00mr12105418f8f.1.1770732072461;
        Tue, 10 Feb 2026 06:01:12 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4a1sm34344330f8f.17.2026.02.10.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 06:01:12 -0800 (PST)
Date: Tue, 10 Feb 2026 15:01:10 +0100
From: Michal Hocko <mhocko@suse.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aYs6Ju2G4bm6_tl2@tiehlicka>
References: <20260206143430.021026873@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206143430.021026873@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13830-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[suse.com:query timed out];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de,suse.de];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 13F3E11BAC1
X-Rspamd-Action: no action

On Fri 06-02-26 11:34:30, Marcelo Tosatti wrote:
> The problem:
> Some places in the kernel implement a parallel programming strategy
> consisting on local_locks() for most of the work, and some rare remote
> operations are scheduled on target cpu. This keeps cache bouncing low since
> cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> kernels, even though the very few remote operations will be expensive due
> to scheduling overhead.
> 
> On the other hand, for RT workloads this can represent a problem: getting
> an important workload scheduled out to deal with remote requests is
> sure to introduce unexpected deadline misses.
> 
> The idea:
> Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> In this case, instead of scheduling work on a remote cpu, it should
> be safe to grab that remote cpu's per-cpu spinlock and run the required
> work locally. That major cost, which is un/locking in every local function,
> already happens in PREEMPT_RT.
> 
> Also, there is no need to worry about extra cache bouncing:
> The cacheline invalidation already happens due to schedule_work_on().
> 
> This will avoid schedule_work_on(), and thus avoid scheduling-out an
> RT workload.
> 
> Proposed solution:
> A new interface called Queue PerCPU Work (QPW), which should replace
> Work Queue in the above mentioned use case.
> 
> If PREEMPT_RT=n this interfaces just wraps the current
> local_locks + WorkQueue behavior, so no expected change in runtime.
> 
> If PREEMPT_RT=y, or CONFIG_QPW=y, queue_percpu_work_on(cpu,...) will
> lock that cpu's per-cpu structure and perform work on it locally. 
> This is possible because on functions that can be used for performing
> remote work on remote per-cpu structures, the local_lock (which is already
> a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> is able to get the per_cpu spinlock() for the cpu passed as parameter.

What about !PREEMPT_RT? We have people running isolated workloads and
these sorts of pcp disruptions are really unwelcome as well. They do not
have requirements as strong as RT workloads but the underlying
fundamental problem is the same. Frederic (now CCed) is working on
moving those pcp book keeping activities to be executed to the return to
the userspace which should be taking care of both RT and non-RT
configurations AFAICS.

-- 
Michal Hocko
SUSE Labs

