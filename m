Return-Path: <cgroups+bounces-13959-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKtxGu3qkGkfdwEAu9opvQ
	(envelope-from <cgroups+bounces-13959-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 22:36:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C643413DA75
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 22:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F7E300C022
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 21:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8729D268;
	Sat, 14 Feb 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1JRfD4R"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2127510B
	for <cgroups@vger.kernel.org>; Sat, 14 Feb 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104963; cv=none; b=MJyMXOD8lzosC7slDK+Ab5rqumG54+Yrlcoy9nfzqNbQAH9pvGXRz2ZqScO1BIdO6o0DxLiJ938hBFHdES/dNasVz47STwQAmjHBf7T4OGcRkjDu4bhHCcvLDxMOH5GJOdmyDCUOehEJJbXxFyg35+KeifNbr0if5arQYRkkFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104963; c=relaxed/simple;
	bh=bi1UicSJT58WD6qJpXaLohdtYTns9OgaLip4oakEuek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=gZBJmKrTV4sZIyDgxQh6AwI6JjKYpD7CKsyRNr+xXvmBNNPQv22nVREHYGYVAQW7SQPNtwhV/SskIKktfXNBAl3lBWMcGCHZAuF6HEXQFjFPSW3sx2/KkUpNkn60e8xFCrl712fxPS6bFBN70aIOjnMbdJ6jb+f72j6P9Yzul/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1JRfD4R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806bf39419so29070215e9.1
        for <cgroups@vger.kernel.org>; Sat, 14 Feb 2026 13:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771104960; x=1771709760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ro0ZhP/FlNj+GMkv9hkfY7zWnxPHN/VgorELWyYQ2EU=;
        b=C1JRfD4RBwf1EvKvCBoDJrNQIQ5Ccd+Dgt8un8j+6Yp7oYxgvTb5lS4y1xAYrET9Cv
         5OxVLJ+kCJqtawTI6V2zgeUZSzFGGqCjWGfaUH2GS0FoIQ9ra4YRAmljvIXOPQnDM5wg
         56Zq+uzmNSr4De5irsih2xxfZemfthGX5fy12aR0oQXoEgdOvsKUrcy3wX9euPP6ty6v
         CGeMuIpbZK0yf5fszsiAiBW5QFffjKuB0x1ITZcaW8gymlB+nGylek8t5mp+58pfRN72
         lMYZKTtcvnhsnhK9I5/itgo7/mXlK03H1ecgM/zMAp6feiZxVsc442Prwks9eRjeyrGN
         j9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771104960; x=1771709760;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro0ZhP/FlNj+GMkv9hkfY7zWnxPHN/VgorELWyYQ2EU=;
        b=oQQt90/YBFsrXVX3knwioAyDGNIPELi9sCH5wtQ4+Z2/FXVKmuUIt66sxWh407lOWC
         qeyFDq79UF1uVj5n2Z7vHyWnj0T9bvw6fU9BOpxxmCYAFRJbFjlRVBmCXQQZko3hk2HR
         wXejOgBv8L3hcfxEJCIoi7vPdcXa2MpLHylPYNC9Kr92mAscgvJXyFju6SfBFSjFqoKG
         P0GW11DSdzz4ruXpxqZ6z/2lYma7Mksn97juUrqYWi/z/KQeS87kS+XNxCdKtngd2Mdf
         B5kcu1M6X4Z/bu2KbM0e8We4Z5ouiiXP43/ND4xvd4bM4/BwduGK2bPjfTEQ9MxrJKV+
         e62g==
X-Forwarded-Encrypted: i=1; AJvYcCX3zEEU/gB8Pn2QQ2eDBSkBDAKNfC+qwedBUGVqYS0xfWhuVX+bvGXIn9YWgSI6soCXTrOJ0L4i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzop0dWJOP2dWcqOmF6uw7wBXERXHxJ0Aiw6BMWsmKrQDdFgVi
	Ylwt4VQ+YRiVVDaTJO6k+rKuoz2V78nNAcQfdSyFgsEunZvwerbW8MVL
X-Gm-Gg: AZuq6aLvOwraWgT52T4HrTzL8M4nvOvjKCYm65YbZpiJzAEWlmkxuklp2RjmkKiLARl
	2CJ0s7a76iliETk09dME9rNv/zQ8fT26LE6uaVzcDLveaIyAVdMdFfbeL4t5DHYrYYVO7Dw577x
	R2Zt6AIcJkBv4WYxpcY8adeE23P8jneytXASujEX9Wzoyk0bHyZ0SrYTF1KYDWue8i1MwkxoSzl
	T7AIrQnVqG11iCc0EZvxGyBnqnXLY9RRVqCn8hGz1XAS5sJ9eEZVVKg6FZEUK++IzbGXX7XsY+O
	BqdAM9p5ZKRT5UcPpUwoT7h0cWDtExhrNqumuCAlD6HIkmvid2lXoesBGk3Gtqh2ya7DBkx5B+B
	8X8RPLGd5KKRbhqajm7U4F1WAFSdyCgukwt9udlgYcch9hCa/0Ie3siijVL+PgHtFli/4o6zqWa
	LITALih1gybumrb9KuvwhaBiKkO2Oe122IrxI=
X-Received: by 2002:a05:600c:4446:b0:47e:e38b:a83 with SMTP id 5b1f17b1804b1-48378d62a9emr67568155e9.7.1771104960057;
        Sat, 14 Feb 2026 13:36:00 -0800 (PST)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a4ffafsm49226635e9.5.2026.02.14.13.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 13:35:59 -0800 (PST)
From: Leonardo Bras <leobras.c@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
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
Date: Sat, 14 Feb 2026 18:35:58 -0300
Message-ID: <aZDqvsUt16ZjB2YM@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aYxx6cq6he6jTIZI@tpad>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka> <aYxviLoWsrLqDU7o@tpad> <aYxx6cq6he6jTIZI@tpad>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13959-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C643413DA75
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 09:11:21AM -0300, Marcelo Tosatti wrote:
> On Wed, Feb 11, 2026 at 09:01:12AM -0300, Marcelo Tosatti wrote:
> > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > > On Fri 06-02-26 11:34:30, Marcelo Tosatti wrote:
> > > > The problem:
> > > > Some places in the kernel implement a parallel programming strategy
> > > > consisting on local_locks() for most of the work, and some rare remote
> > > > operations are scheduled on target cpu. This keeps cache bouncing low since
> > > > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > > > kernels, even though the very few remote operations will be expensive due
> > > > to scheduling overhead.
> > > > 
> > > > On the other hand, for RT workloads this can represent a problem: getting
> > > > an important workload scheduled out to deal with remote requests is
> > > > sure to introduce unexpected deadline misses.
> > > > 
> > > > The idea:
> > > > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > > > In this case, instead of scheduling work on a remote cpu, it should
> > > > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > > > work locally. That major cost, which is un/locking in every local function,
> > > > already happens in PREEMPT_RT.
> > > > 
> > > > Also, there is no need to worry about extra cache bouncing:
> > > > The cacheline invalidation already happens due to schedule_work_on().
> > > > 
> > > > This will avoid schedule_work_on(), and thus avoid scheduling-out an
> > > > RT workload.
> > > > 
> > > > Proposed solution:
> > > > A new interface called Queue PerCPU Work (QPW), which should replace
> > > > Work Queue in the above mentioned use case.
> > > > 
> > > > If PREEMPT_RT=n this interfaces just wraps the current
> > > > local_locks + WorkQueue behavior, so no expected change in runtime.
> > > > 
> > > > If PREEMPT_RT=y, or CONFIG_QPW=y, queue_percpu_work_on(cpu,...) will
> > > > lock that cpu's per-cpu structure and perform work on it locally. 
> > > > This is possible because on functions that can be used for performing
> > > > remote work on remote per-cpu structures, the local_lock (which is already
> > > > a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> > > > is able to get the per_cpu spinlock() for the cpu passed as parameter.
> > > 
> > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > have requirements as strong as RT workloads but the underlying
> > > fundamental problem is the same. Frederic (now CCed) is working on
> > > moving those pcp book keeping activities to be executed to the return to
> > > the userspace which should be taking care of both RT and non-RT
> > > configurations AFAICS.
> > 
> > Michal,
> > 
> > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > boot option qpw=y/n, which controls whether the behaviour will be
> > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > 
> > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > (and remote work via work_queue) is used.
> 
> OK, this is not true. There is only CONFIG_QPW and the qpw=yes/no kernel 
> boot option for control.
> 
> CONFIG_PREEMPT_RT should probably select CONFIG_QPW=y and
> CONFIG_QPW_DEFAULT=y.

Fully agree :)

> 
> > What "pcp book keeping activities" you refer to ? I don't see how
> > moving certain activities that happen under SLUB or LRU spinlocks
> > to happen before return to userspace changes things related 
> > to avoidance of CPU interruption ?
> > 
> > Thanks
> > 
> 

