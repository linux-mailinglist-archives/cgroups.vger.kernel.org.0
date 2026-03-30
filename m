Return-Path: <cgroups+bounces-15102-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULF5Fv1iymn27gUAu9opvQ
	(envelope-from <cgroups+bounces-15102-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:48:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E0735A846
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 13:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64F353046F0C
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C813C7DEB;
	Mon, 30 Mar 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9hIlR57"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4B3C872E
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871118; cv=none; b=Ubr26Baf45/Anw1xMs80L7DoYvyLtfNDcMVwnap+kShWsvS4XNMH7TnLrjn2LEVLYSu1CCw1IcKTVzp/Yr3N39636/VY6PU5cISBDOCYO47lgTvUwGNXF0uVLsDgK/GKXM5N13ivBE73dME8wjunANr5mF2R1IFP7vCy4hbNVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871118; c=relaxed/simple;
	bh=kycga9i6Vn45DHzFTlgg9Oku8LYokhcIRIuU+jvkYqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTby4/D9EyGbIeCl5AWUTM/wiD5DpMnf/erFdI3LJBFEK0KJBAaOItCwNMDCqR27HK9slnVA2Njb3oranw3uFvTOUv02fRQgnf4vJ/hMpM4pc3HFsJ0leJqMqcbWUX89hDkCQ98LgDD5G7k7rDCGIyyhw3WPUS10MElCOtE77/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9hIlR57; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c56aa62931so455398eec.0
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774871116; x=1775475916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTACHKzRTTQTHv2BeEVVc+PV7wXJkipQOVm/vndnvSM=;
        b=Q9hIlR57opwLzxLoGOaNh4LiKBiKNdV44IqEoRdMuyK9MmIv58Tlbr8fxcoXZA8KHk
         cTh5YniRvEhyEhHgtyetXW+QyAoOGRvX6pTJ66pgIhshkYwyM86yke5foR6ecdMuDCOE
         CnkSMQnOn4wg9+pgvJg5hoc01+1FtDML7C+9gssrI/vEYkrM8Y30byoq0Z4mBIoMOsnX
         KtXHRLTwQS7PtLIaa2QGsuOSof5hQ4boXtV5QP/wXRfo6URzKh1oWugkvJ9QzILD4RzM
         FnZa7hBMLLfI3YUmk6MBfAKXNC0jE6j/VWK/mb9uky91MnvZRPuAP+T9Kk31xczm18ao
         hZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871116; x=1775475916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kTACHKzRTTQTHv2BeEVVc+PV7wXJkipQOVm/vndnvSM=;
        b=VQlISsuF34SzdkcQTb2tc3xmLfgy2Ll3r34BkQz2K3bUCID+22lhpDpIwP07ak6DRV
         rXCD15pP788LHK6uD5L13hVk3e0MD1VwQ4uxyM4VzHTJ68Gbu4jVSa6uumd4wVDd07rW
         LNPGyS1LjBXlh9+fDgYY/idQrsBRJUHBc+IrNxb+nW1MlaFQiaClvFDV/Ha3NYhpt4ib
         iQNe7M6mU8Lx9ruw63al3IFKv9peuJWi5cvCEPoj+jcKqGe6Rb5tE9+IxaFhzAQMy1Gt
         zusimpzxaySfFDTtb86NljCU+fTxdWQL28uSoao6bUhEfdAXbJ3smcTWnQbcC1b0o5DZ
         QF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHcB8BGpTZSzlBrIAqFnrDlGYGxp7NcsEHmdhjTodGx1/6xYwR0bwsotWZJL3oljOgroG1owvh@vger.kernel.org
X-Gm-Message-State: AOJu0YxWK3+rYkUfKJM4xorwz0F+subzBOUAf6LWqU4A+k3gfkRKeI2e
	pMLyeVVpEkj85lpeMMwgmp+imByglhYyhmB++43xvGKy/sgQ/wi82+N5
X-Gm-Gg: ATEYQzznBHfLVzHtpJHjd1cZzzTnXkLMPh5YcD+j1n5Gpvcj5ZIuxUF2X/fhRO2DelO
	zkSMmFgXgn2G6362b9eS5in99b68lFWhd69zARfoGo4jfuIC2YgU36WdM5szn7sfgST5Krqx6si
	SmKW9EfV9Fmh7vmoVmtcP7wqWZhsAasaB0ya89ifNn97XhZI+0mNos3+4Bx5jIAkrqQVwx8KLe2
	JcHtMKJJTgvpfJ1tZT1hQJl72S1GrbPTMzRsc0JKA3YLf2wGVozUtvWjeIDWjT2jk7JtSia80UD
	L5NU2DQHSdvwLFFlP3ozKwk7WVJRufr9+1gePUSWyH7xgd/nyikgrPAfuOOg9AEv6FnmSJyq7zw
	pMd+/T/Jm44oMA+QvvSOLRbYdyMLmmRv1UA/AQN3m27snk2hD1OXvCQvn6rTqnV2Fxre/xbEmfW
	Osjo6mvNLbcoeKK5iZQFVaPsc0OpadTAiUHXY=
X-Received: by 2002:a05:7300:dc90:b0:2c5:a6ce:e534 with SMTP id 5a478bee46e88-2c5a6cef339mr2202718eec.8.1774871115888;
        Mon, 30 Mar 2026 04:45:15 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c41c1513sm7056897eec.8.2026.03.30.04.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:45:15 -0700 (PDT)
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
Subject: Re: [PATCH 03/15] sched/isolation: Separate housekeeping types in enum hk_type
Date: Mon, 30 Mar 2026 19:44:48 +0800
Message-ID: <20260330114448.103086-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325135904.GB3738786@noisy.programming.kicks-ass.net>
References: <20260325135904.GB3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux-foundation.org,linutronix.de,gmail.com,google.com,arm.com,kernel.org,cmpxchg.org,nvidia.com,joshtriplett.org,kvack.org,efficios.com,suse.de,suse.com,linux.dev,goodmis.org,suse.cz,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15102-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4E0735A846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 02:59:04PM +0100, Peter Zijlstra wrote:
> What the hell for?

Direct and to the point. The original intent was to allow for asymmetric 
isolation (e.g. offloading RCU callbacks while keeping specific timers 
local for very specialized real-time monitoring).

However, I agree that for 99% of use cases, this is unnecessary 
complexity. In V13, I will consolidate these independent enum types 
into a unified housekeeping mask to simplify the configuration and 
reduce the "insane configuration space" you mentioned earlier.

