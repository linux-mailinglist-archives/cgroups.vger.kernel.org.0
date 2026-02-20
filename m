Return-Path: <cgroups+bounces-14073-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFLlHQrZmGnlNQMAu9opvQ
	(envelope-from <cgroups+bounces-14073-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 22:58:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD72516B159
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 22:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB55C3030B15
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5AC30DD1A;
	Fri, 20 Feb 2026 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+9lE5Dt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99B189F30
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624709; cv=none; b=ipEtTh5MW+tOLeg7+QJrKOnxsBRpbFZ2nSoOcd7QlxAkouFGuymhpY6Ru1E2CDTNqorfV+/R64hUEB30pLAwKem5HkfOYE8iTwymDPgdCnE+kRoKZdaGRDEZdDX6tgThdImbC1TgvHrrxSiVFFRgmZmPCynGq0StgPbX9zxP4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624709; c=relaxed/simple;
	bh=AOvfcc/Xozq8XEFtYt/HhA21k8kpHeqmR1iDAT8zXTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=puMTZ+kfxhBEZSE4NH5+xwDTyZzWd30X+uxrjh2fipgT//+LZxw1ksbr4ybIwSGApWc0B60ZzXCaMMIDzIPlxogQj8qQRc41XJX9TZs+QN3jzb+rdmYEPXjVwWLfrY1bqZhD0Hg2rGsW4UKD5ENnQjxszSHP/o1mzOQ90T3tFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+9lE5Dt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4362197d174so1639547f8f.3
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 13:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771624707; x=1772229507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sv6xYJAa/oThbMSrWyTLhp6ItSvlOyI8CiwPK1KtBnU=;
        b=d+9lE5DtQTFp93PSTQsZqwvjI0xaI6SHKdrTyZ7qEYTMQke8/pr6QleJJGEpwAU2L2
         6YHMaR3AXfh/w1Iqwa+QUfjTUfhWG95QUMzDmY6FqyaltyUNWoHd0vCOqt9Cr3HcnQo7
         Cjxh4xp9L0TFrnaZceISqrVO3HiwmuEX6C11PgrDOmT0UigyFUUFykPH9LOKivmrCjQ+
         Gu056Jt63fxEEIQk3QDydOJzC6Eimdtub5NXf3m6VQetF2OTrGZPwMmwB/OUgKg7Ki8s
         6rmhzHwsLb9G+XPoNq29dhkHRn3ZEgT9d7jlCSDIT+R75SuNBxpqpOYFU1xbTyNl2vcx
         sN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771624707; x=1772229507;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sv6xYJAa/oThbMSrWyTLhp6ItSvlOyI8CiwPK1KtBnU=;
        b=uKbXvVB6ZqvvNghxKuknB1wj+Cp+JkzCmUFIKxxkvuI94ztBLkF2TYFAFr0O1VQY16
         lVpvulRr5392a7lqee1Xx6PAesCPePbdV2EBOXWB8kowWSi1VZTQOWS36OuF/iacV/6l
         nCNrPnatoMYp8hyYyNUmSQ4fNkuVUW4LGOTeaJePjKRUDJmPj2BIVfuu4cWAvyQbqDBW
         eSBSOzC3e+fJ8Y2bigWItlvGQlNoZKdEM+/R2agEkeBcDPQ2rYbiVw3HHKA2My0HTrOv
         Yiew0xm52QGvpHsIKVKwpyYORszGSG8DDHVJiEzmKORzDb240c7OgQ9enz7E0O/IrGo3
         Wa1A==
X-Forwarded-Encrypted: i=1; AJvYcCV2/lC9CdCbMHMjADyZFhihwR3tbWHaQyxSJcdKz5Fh+5FJRaTfZ+CiISL41A4XGsyHp1aBjYzm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UNJzxS5i1nC/qfiwoO4peC5S9y6BM1ZS7uGnxSN1c85exbAs
	vVIGBldXp7eosn8LcTg+w/ZmWKTV6S/W3YytAG0eGF+i3NQykqwFxBl8
X-Gm-Gg: AZuq6aKZdxcLwVdatm9J7jwI/hrj5oUJ/G1C0B+j+oikcYyEA1+tnEk/fxsbsrGFVyU
	3iGqduoGQkd0fKCp5OQIhsRL8slHFobCxF5mOmLVkuanQbXOhUtcdqXHw4mTTrtyCUhk14jUifT
	Tj9A8nX9jfcbrjp1/8/Q0v/WINz/kcevi75jHucLoU90oG9YEbo6oGSB0k7MqgoANkqrec7mtgV
	YZyq8bs5u70WWF64WW+KbF00U9z6VeiXXA+d3n57Izc4SlvX49AUxQYOdSghfZrmDN7lTtm3xjg
	h5L6uAI/VQM5spN3ho1L4npMXEKswxtO+YvMxorOQmOvSj2iHpHuqxsvOIovpAnkNTQpUUoPgoX
	akbih0u7i+1VDPaT/rciMn2GeEEWI/L4IyKlXSBYR36cvxRy/4MpNr5o2vWl8KEyaPz7V0LKlSA
	2x+PQRMFWMA0yk+0pkKjfvXPQi/i0awNwIhGD5kaWh8BgR5Q==
X-Received: by 2002:a05:6000:248a:b0:436:3475:473e with SMTP id ffacd0b85a97d-4396f187ebemr2551008f8f.51.1771624706322;
        Fri, 20 Feb 2026 13:58:26 -0800 (PST)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00768sm910737f8f.10.2026.02.20.13.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:58:25 -0800 (PST)
From: Leonardo Bras <leobras.c@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Date: Fri, 20 Feb 2026 18:58:14 -0300
Message-ID: <aZjY9h3XXMNY-Ytd@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aZL45yORfkNvS9Rs@tiehlicka>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka> <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka> <aZDw6xI2izFDfuuu@WindFlash> <aZL45yORfkNvS9Rs@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14073-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,linutronix.de,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD72516B159
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:00:55PM +0100, Michal Hocko wrote:
> On Sat 14-02-26 19:02:19, Leonardo Bras wrote:
> > On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> > > On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > > > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > > [...]
> > > > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > > > have requirements as strong as RT workloads but the underlying
> > > > > fundamental problem is the same. Frederic (now CCed) is working on
> > > > > moving those pcp book keeping activities to be executed to the return to
> > > > > the userspace which should be taking care of both RT and non-RT
> > > > > configurations AFAICS.
> > > > 
> > > > Michal,
> > > > 
> > > > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > > > boot option qpw=y/n, which controls whether the behaviour will be
> > > > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > > 
> > > My bad. I've misread the config space of this.
> > > 
> > > > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > > > (and remote work via work_queue) is used.
> > > > 
> > > > What "pcp book keeping activities" you refer to ? I don't see how
> > > > moving certain activities that happen under SLUB or LRU spinlocks
> > > > to happen before return to userspace changes things related 
> > > > to avoidance of CPU interruption ?
> > > 
> > > Essentially delayed operations like pcp state flushing happens on return
> > > to the userspace on isolated CPUs. No locking changes are required as
> > > the work is still per-cpu.
> > > 
> > > In other words the approach Frederic is working on is to not change the
> > > locking of pcp delayed work but instead move that work into well defined
> > > place - i.e. return to the userspace.
> > > 
> > > Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> > > paths like SLUB sheeves?
> > 
> > Hi Michal,
> > 
> > I have done some study on this (which I presented on Plumbers 2023):
> > https://lpc.events/event/17/contributions/1484/ 
> > 
> > Since they are per-cpu spinlocks, and the remote operations are not that 
> > frequent, as per design of the current approach, we are not supposed to see 
> > contention (I was not able to detect contention even after stress testing 
> > for weeks), nor relevant cacheline bouncing.
> > 
> > That being said, for RT local_locks already get per-cpu spinlocks, so there 
> > is only difference for !RT, which as you mention, does preemtp_disable():
> > 
> > The performance impact noticed was mostly about jumping around in 
> > executable code, as inlining spinlocks (test #2 on presentation) took care 
> > of most of the added extra cycles, adding about 4-14 extra cycles per 
> > lock/unlock cycle. (tested on memcg with kmalloc test)
> > 
> > Yeah, as expected there is some extra cycles, as we are doing extra atomic 
> > operations (even if in a local cacheline) in !RT case, but this could be 
> > enabled only if the user thinks this is an ok cost for reducing 
> > interruptions.
> > 
> > What do you think?
> 
> The fact that the behavior is opt-in for !RT is certainly a plus. I also
> do not expect the overhead to be really be really big. 

Awesome! Thanks for reviewing!

> To me, a much
> more important question is which of the two approaches is easier to
> maintain long term. The pcp work needs to be done one way or the other.
> Whether we want to tweak locking or do it at a very well defined time is
> the bigger question.

That crossed my mind as well, and I went with the idea of changing locking 
because I was working on workloads in which deferring work to a kernel 
re-entry would cause deadline misses as well. Or more critically, the 
drains could take forever, as some of those tasks would avoid returning to 
kernel as much as possible. 

Thanks!
Leo

