Return-Path: <cgroups+bounces-15100-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GDrNBNkymn27gUAu9opvQ
	(envelope-from <cgroups+bounces-15100-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:52:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDF235A9DE
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96DF304996A
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF933C6A2B;
	Mon, 30 Mar 2026 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYyvaqbP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB63C7DFF
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871058; cv=none; b=ncsA08G8GrfhKOga+IioHF6rcTOFhmwKB9cgbR36PD8UgDrfW7F5QIMjTLr01TJAsQjddgfGVhQXS/tl67RjYWJdYjYWNgntKSxVyZN8Jjs71hkzC1cdw7GsZ9CxNsAcZ311aEbcmF6sZExJMQOsLW3CKqMEQdNFbacDX6bKbzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871058; c=relaxed/simple;
	bh=QNxeWPuNGI2eSY+5Z9RiWVoDWCQtoqxeBXkIfDy5SO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aj0RTDphjAAo7E5jwlepFa1TGdRfygzIf/ciCyDAMD0UJRw6QUNaQWddjduYV+HMJysDUhmOPnr7ofF5mpxxTsD2+qNA5iGx6S54miI2JPeaRng8NIm8V6z5tLLuAuFCZrYTN4ixM5MAvfE5PSUjh/ywP4mlnkYBcxlOCIBd+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYyvaqbP; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so676093c88.1
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774871056; x=1775475856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+Q88Kl0GUitZCzEyHgGQvEVgC1GtxxYgxFmpIs5N6Y=;
        b=XYyvaqbP5g62AM+ODyQkx/AGROye8iJuKUsMn0qSmvZ+oGvo5QsfVF4T9pyMT+028L
         hLIO5BOFGb7eAKb6KW/KyQ8AAPRocLPrV84sB1v+h10w4iio2usnEO8Sy0zapaWuuYJS
         0ZvBl8f0J3dLLk0uD5JHqUGY5XH1wgVik7WliQv1pDyKN4UHXu+12ZqmLqECGGUx+VJ4
         qz0XYkeMSV+GAWFcJWwd9WvOar3U7L3ABR9U8HvwWIL/4fss++njroFUGWWcPeLjo+bq
         DdrgnJAtXJ0bkhAuwKYtf7YcVQcLebywiYa6AiC2ZmHX9lhYg507F5X+4z6/HONMXEwW
         LwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871056; x=1775475856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+Q88Kl0GUitZCzEyHgGQvEVgC1GtxxYgxFmpIs5N6Y=;
        b=e/F1B5rvGNnzoX4T4gyQT3URZjpwr+8S+SGPAF36aHafZw0U1TqCHlLffqW82ndnGX
         UMfcS2QmOEwYjylj11vn4qleF6Tk7KBaH1UVxbEwBWC+cqfYcsEOtXuVYT1nknfXo710
         z6/w00NWKXj5w/+vDss5fjVhYx99584ABMLkCbFWeEnicGTkHn7jYxUgOlTtGXBkbAFr
         mr2zAeyEVxIzwdvjS5W4pU7mcHYNAtwiWADafaxVTz0uMG6Nn6SktkzNecui9tZH7/qu
         WD7ORhrCnkCGlHsPbKGfXvikkNUopiJjU+4MLttM3FDkEunICg0c7ZX9cBpKjPBNZRMF
         RGjg==
X-Forwarded-Encrypted: i=1; AJvYcCXpqDSMyjtoxxEcKdwMT0Vo97hOxAXqNc69CcOy8VHaQ5qiH1MOPQZF9n43weDtcNOOIKh1+NyC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1p77cvybeetrSXXzq3E/FaOjosjMJ4D2taokcATkD44Ci0qVO
	1ud4wjfmi7eokj4T3ph0/q/zgaImAhNMHnJKFy5/FckMloNp1U5ZHJxK
X-Gm-Gg: ATEYQzxJVFdgnybXr+3E2B2npMUmHUO8HZDDYrUJeZGDy4RhwAwoSWLQrhwZi3Tp0o1
	55A2unU1Is4u5uXfZ7hKxOhRCmYBOwmIakYOXxuIYAsPkCH9wkf+QteP4UeL+AWy8S9RdtYaGCV
	Trrwono+0jh90NBc3UMPCbfaWV79lQiJrXbtZB9WGzRNsf26+q43MbHrudLISkpjH3M7iAdRvaq
	kvJG7Va3mGuGed+jkk6bZcs054dEUPZM0wwBLr8eVmzXUt2P6zf9N4cIzfI0E3evhCZSHQ7OJER
	satw0Lpn6kkd+r55umw4TloBn3IcRcc1RX4gA2cqHWTy2CAA8l1SkNHl0ZlqccyZRcPL09mUTUA
	outtOxTDRqvndpB6xAal9zLcQ+uL59kv9OvAguZRCGBWqIcF7sR1RMJc6ZcO3AMrYIjPa5Ubhe0
	hRAOqyVSghC2LmLKYi7GwPU77L4L4yM3qev0c=
X-Received: by 2002:a05:7022:f005:b0:128:cf5c:5362 with SMTP id a92af1059eb24-12ab2884d8fmr7157614c88.12.1774871056408;
        Mon, 30 Mar 2026 04:44:16 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97ca83bsm7083511c88.2.2026.03.30.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:44:16 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: peterz@infradead.org
Cc: longman@redhat.com,
	cgroups@vger.kernel.org,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	boqun.feng@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	jiangshanlai@gmail.com,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	mathieu.desnoyers@efficios.com,
	mgorman@suse.de,
	mhocko@suse.com,
	mingo@kernel.org,
	mingo@redhat.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	realwujing@gmail.com,
	rostedt@goodmis.org,
	shuah@kernel.org,
	surenb@google.com,
	tglx@kernel.org,
	tj@kernel.org,
	urezki@gmail.com,
	vbabka@suse.cz,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	ziy@nvidia.com
Subject: Re: [PATCH 01/15] sched/isolation: Support dynamic allocation for housekeeping masks
Date: Mon, 30 Mar 2026 19:43:21 +0800
Message-ID: <20260330114348.102265-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325135707.GZ3738786@noisy.programming.kicks-ass.net>
References: <20260325135707.GZ3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux-foundation.org,linutronix.de,gmail.com,google.com,arm.com,kernel.org,cmpxchg.org,nvidia.com,joshtriplett.org,kvack.org,efficios.com,suse.de,suse.com,linux.dev,goodmis.org,suse.cz,linaro.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15100-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BDF235A9DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Peter,

On Wed, Mar 25, 2026 at 02:57:07PM +0100, Peter Zijlstra wrote:
> I think I asked this a while ago; why do we have more than one mask? 
> What is the actual purpose of being able to separate RCU from Timers?

That's a fair point. For the vast majority of use cases (like NOHZ_FULL), 
these masks are indeed identical and should be updated as a single unit. 

The original motivation for separation was to allow extreme fine-tuning in 
HFT environments—for example, offloading RCU callbacks to keep a core 
mostly clean but allowing pinned timers for specific localized 
telemetry/monitoring. 

However, I acknowledge this adds significant complexity. In V13, I will 
unify these into a single "Global Housekeeping Mask" by default to 
simplify the configuration space, while keeping the underlying notifier 
infrastructure flexible enough for future specialized needs.

