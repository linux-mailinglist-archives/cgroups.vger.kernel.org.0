Return-Path: <cgroups+bounces-13491-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KjDDyB9emlN7AEAu9opvQ
	(envelope-from <cgroups+bounces-13491-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 22:18:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E90A90A5
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 22:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90AD9301CFC2
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3133A70A;
	Wed, 28 Jan 2026 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VcAbRWxC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2732882B4
	for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635089; cv=none; b=nS1JOJaUtJwvAPdzVqaCVuUcv24cpJ0wrVz2syoUxZDJIJC49Kz/pSFToOPzSICYNhubAZOCh0vCW3+S1/vjyUZkrh08WNk0n77Vg8KNEUyLrqQXowSvqJQZS3GwAtmcH+Odc/X+PShi5WgDrCCeK9SvySy7xQMPFRHvHIGgwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635089; c=relaxed/simple;
	bh=kjFXNlbmAL0BO92rYrTkCSuMABiMP5ofoNy2abW+ap8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM1SCOoQdErEyochIHSxgYSILVqtHtnB9e7Y8JCdUV5uX41YD4DveOBHOhpOqVXpx9z4Uo5UgaD1Vz0DwWk8864WEMBFNhOumMN3KNYfN0Y3/eYqz8neMHLxrN1TYFlf1ga+waeS+qM2aActxXU5sFQBFFAZLG6xcBo4urTl4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VcAbRWxC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801bc32725so2050885e9.0
        for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 13:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769635085; x=1770239885; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZU7FEnl0OZQVA7ODIpy0SKJAEacHqZRjK4EaXTvPIzs=;
        b=VcAbRWxCx1sqsR7wsEPCek4TghMY0a1vc9GxEknZR59yeMCqkqjg1CaJoLrqOfymzc
         LYIMCKsdWDcGTXFFAeHuG1vHMeb1H+qG5dYzKoFl7O7O7tffhq8wkVwb943kpXJavfS0
         JXZsmZ0mietseQsxHDXU+1WCIwSUXbjThkfHww+t/wfYahNCHJc0k2smjB2CrMlHRT1J
         oIQsBhMzeHlO8saKSiNKhXA9/h9DM4jnwQKUtbAdkzeoYpUc8uBTKgDNTO8n/XeLXBVg
         zwGU85oRqLdKHO38LyxQs5lZtHxrEalkUPEs9Yf3ZRzRT6Goe8iMzyZqQbtbc0i++cMy
         lmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635085; x=1770239885;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU7FEnl0OZQVA7ODIpy0SKJAEacHqZRjK4EaXTvPIzs=;
        b=c0I7haQFE1ayITYwmsSAZzsCHo48gQlVuvBqnchO1yvf/ZFoL9LXrmsJsB9e0+Ryzs
         m12W0WOyg7hpXwQa0B3IbkOwZEcUvKeauTXW4RCE2hBeaxuIvQ78SGUQBgEOfLMqzTRW
         Ue09LBBmKVDelbvTOCiruEMwYxJ7TTaBcUMI0dABBXVp15hrcz9H4VGizjwqU4xiCqAw
         WVFCIkitKuuGKOgRLavk1NCWT5nYAMhyARzcXt6TsNKCgOzEknEcri7q+EHSpWCa/SyN
         folWDFVYdg6azCPqSEx6OYzxMWhV6k7o8XM6XxwGOPHucUBEdiQ7lKzwOASDcZbJ+a6B
         eWew==
X-Forwarded-Encrypted: i=1; AJvYcCVpNw4wP8RrT3POZJ/v/qQZgu4ff0ggCVQBXNNym+cPfYhVwOl3c377SX4XjQnlL43+s/VRWeQm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3EHvGPTMbsVTsA5MMZV6d7SQeMLUTEEWudqBHtG6XSufoQGj
	jjGrjFot8Ts7hXyEXxFcruzqPFei3tWGlUOuoUxVsOrsLRf+ULLnW7iiP3lP5hS6o9A=
X-Gm-Gg: AZuq6aJCuZlwRUbWlLhV5X+y47dbaKnuC9S4dAkiNfCbki0MxPGQg4j91mC6sRxoKYq
	xtGi8N0qWeWnxQJCJb2vzbPWI/aoXVff3XRiBYAKhTkXzYfLYSBJji/DrXXo7UyCmd+VRoStYl5
	AeOqdWSVlqDifGhxcyQrcT00rekuEly9K2S4HccCoq4+QTb3RUgg7w0WzbH9P5iOrxnVXP32Syn
	EWgMtFBHd5ELFM+/SdHtEJdGcq6xqs5mMBAkNiDJEHQQvxY34vgTj5ixcG9UNxEtWDn4b999g6f
	XM2wriHaTXtBZnjlWwrN8wmaKt0P7AOPkVK1oQbfxIq2ma3eeqbdcaNbVmHsu73w2cBS7hspxFV
	+URNv+RRjZxzOk3+a8I0Hsn8lcasq/s8zfF8jDumf3cCWT9opN9tOCZwLWETR+UGCHvb/OQKFTg
	ekm3PEILdEVkxqOVx1JlDkboQH
X-Received: by 2002:a05:600c:154c:b0:47e:e9bf:dd8a with SMTP id 5b1f17b1804b1-48069cb2fddmr85513805e9.37.1769635084662;
        Wed, 28 Jan 2026 13:18:04 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c515sm85708295e9.11.2026.01.28.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:18:04 -0800 (PST)
Date: Wed, 28 Jan 2026 22:18:03 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/33] memcg: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXp9CzgCTBEhlDqM@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
 <aXeZQoSHJ9QX7B6W@tiehlicka>
 <aXizUsfywjtIIN50@localhost.localdomain>
 <aXnMj1phN3TJZkNz@tiehlicka>
 <aXnymtIZSc-fw1b8@localhost.localdomain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXnymtIZSc-fw1b8@localhost.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13491-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,lists.infradead.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0E90A90A5
X-Rspamd-Action: no action

On Wed 28-01-26 12:27:22, Frederic Weisbecker wrote:
> Le Wed, Jan 28, 2026 at 09:45:03AM +0100, Michal Hocko a écrit :
> > On Tue 27-01-26 13:45:06, Frederic Weisbecker wrote:
> > > Le Mon, Jan 26, 2026 at 05:41:38PM +0100, Michal Hocko a écrit :
> > > > On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> > > > > The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> > > > > runtime. In order to synchronize against memcg workqueue to make sure
> > > > > that no asynchronous draining is pending or executing on a newly made
> > > > > isolated CPU, target and queue a drain work under the same RCU critical
> > > > > section.
> > > > > 
> > > > > Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> > > > > workqueue flush will also be issued in a further change to make sure
> > > > > that no work remains pending after a CPU has been made isolated.
> > > > > 
> > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > ---
> > > > >  mm/memcontrol.c | 21 +++++++++++++++++----
> > > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index be810c1fbfc3..2289a0299331 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
> > > > >  	return flush;
> > > > >  }
> > > > >  
> > > > > +static void schedule_drain_work(int cpu, struct work_struct *work)
> > > > > +{
> > > > > +	/*
> > > > > +	 * Protect housekeeping cpumask read and work enqueue together
> > > > > +	 * in the same RCU critical section so that later cpuset isolated
> > > > > +	 * partition update only need to wait for an RCU GP and flush the
> > > > > +	 * pending work on newly isolated CPUs.
> > > > > +	 */
> > > > > +	guard(rcu)();
> > > > > +	if (!cpu_is_isolated(cpu))
> > > > > +		schedule_work_on(cpu, work);
> > > > 
> > > > Shouldn't this in the guarded rcu section?
> > > 
> > > This is what guard(rcu)() does, right?
> > > Or am I missing something?
> > 
> > I am probably misreading the patch. But I've had the following in mind
> > 
> > 	scoped_guard(rcu) {
> > 		if (!cpu_is_isolated(cpu))
> > 			schedule_work_on(cpu, work);
> > 	}
> 
> guard(...)() protects everything that follows within the same block
> (here the whole function) whereas scoped_guard only applies to the
> following scope (here what is inside the {} in your example).
> 
> So both work.

I see. Thanks for the clarification. I would probably prefer a more
explicit call convention but no strong opinion on that.
-- 
Michal Hocko
SUSE Labs

