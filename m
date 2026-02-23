Return-Path: <cgroups+bounces-14169-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAmtBHvCnGnJKAQAu9opvQ
	(envelope-from <cgroups+bounces-14169-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 22:11:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E53917D638
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 22:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8310C303D89A
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446937883B;
	Mon, 23 Feb 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6fcgnqF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kkByfEM9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A4378807
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881078; cv=none; b=X2oLX4JpuAva7P8NE/xNXSklj1rJG4TB+etQ3dHF3VvR28E66X5/qjxPK4W249gbS+RkHG7dYk8tGPjusjve/DOVlexnZAW5XVqTy3uNeKr+uaYrE6/Za6HjBwwk74EVU0bkmra8XVjT8TxANbCJzFpm3wsZJKhrZTBcDqcrVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881078; c=relaxed/simple;
	bh=Oci7+8idGwL92JXFpoRCI+rH3TTmT7M0UKWqCffu+FE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=taCnReOyJ+AbK813by9tACSKymxhAauLE49PLJugcNGPCbe1WPWskTyZVAijztFXKY1UywCxg1fdoKclGG893lbGZTEwEAUFz9MLwwwHAg+XOioM6ikw7tfQpa0vJEW37GlB9+YDYM7h50/C6w1HimLw85IStxFFf2OkEBfwVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6fcgnqF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kkByfEM9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771881076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXHLO9YupRsnUZVxUvtFlaS61MC9bw9nMsNVF6PIVB4=;
	b=A6fcgnqFeAUQ+K1LuN5K5sCWCoxejmVumCVra36/bfs1HcYxUGqbK+P+Yma8R+BavuteLU
	x+ut8nessrtjA27/zZYSE+OxjeOT9+uIp80zvKt228kpDdj/LYU1kB706nxK7FP7RZ9Caj
	XAIx7FW/up7FP1Yahf0WsjQ0lYfrGv0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-XrDq_cdqPN6XOCp0KrMbFQ-1; Mon, 23 Feb 2026 16:11:14 -0500
X-MC-Unique: XrDq_cdqPN6XOCp0KrMbFQ-1
X-Mimecast-MFC-AGG-ID: XrDq_cdqPN6XOCp0KrMbFQ_1771881073
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb5359e9d3so4575648585a.2
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771881073; x=1772485873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HXHLO9YupRsnUZVxUvtFlaS61MC9bw9nMsNVF6PIVB4=;
        b=kkByfEM9EuTWvlI8RiDPtbJUN+LJ8BrvzlbBvyqys+WONb70shUnA1StjjwQWNonm1
         c+AfALhMSU3JSrgeTvdvHu4DGVM64dunWgoUXZdKOUOGgoGuYZ8psJk8WO+Ge6Tc326Z
         /GFRgVPTbfmD2uTgdAmzlf/7uSncg0T10CER+UDhmKCT2H4E+F9mtHGQHkSlRScRBn0d
         JEw0FH3AJlobypMFhPvIZ/bydpIx8l4SWrd5h8MeDCNMYkelDFgWOFpP6AKqvP8/ckjm
         WO0xK4RrD9/RPxP85b4C1rF9XlOC+4hkRXb+1RgPHjYFEMCFsbaxNHRdst/9Jq1SjLja
         O9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771881073; x=1772485873;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXHLO9YupRsnUZVxUvtFlaS61MC9bw9nMsNVF6PIVB4=;
        b=hYD7fLvQjGEownYqndkVGOkhpP64E4JEz+I9w3ZOX3p8AL0C7NFnBdTTJt/VubLHWx
         FHjTqcrqsqZjU88pBkg6B0fAo3T9HNUu1cytTkQXpTgmNCU0/EdyP3gvZuuVDDz6v7ZL
         2wdS4ovPeyWZH5gCA6PXidV/GqH0pzz9bxFucRVgsuOdegwI0uF7KpIv/r1LStaSjvLf
         YWm3juZDLdtw+D5hDT5/gJLo2zsfBBf9Tp2rYS0AKkJczkoZqRqZRTVjWHo9H6LrMaCO
         yf2Wk7BojGrnTXRnt6yYq+ckDL0FDzHcR2PdQO1dPNHq+sOtnoi9BvD0PNI/m+AgInCg
         gsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4L9ZH7GCcO4L6e3RvWXB2dyqxozxubS+W6qbhAaplqKP8C5NCKqghTwAlHpLQBnwX17noMxVG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ObFA1SGhpfCBOCJadUQnYVsHfaah4jTpjXuRD/ix6r6hRBr1
	8b06CwORUYkg7vH9kyNSMdEYCi7takriCVir7o1MsaVUTeFuvMuqf2gvXW3mnNzmYqC+wD72Ppn
	aR/GmQtKdccFSBWqc0h5o1oup70Az/ccHHI7NmgMa1wtgpN5YxJke3A+769k=
X-Gm-Gg: AZuq6aJ2bk0PV7WAc4wdZodZICiAW+HIaP/ClC2fbAvlvVKost3xYQxizr5pl2Q8dLX
	yDejHcxcCMODnxzeG0g545B5IpRoJ+bFOiwdALlwUlEwCY2A56KVzRsDM3LXWNg38QU19d+E+ct
	p3y4k8mDBym2lJ17zzy4/vKiSBiUcpeYCpLzBErNZB0OPbYP+buvSS+G2b2E+sFgJEwvYm/5fVU
	T7bqn33IQwrjMH5dSAQOynNb1FunmDPGIqCmukXt3hxLHDho9Tk/aL0AWunktNHHi4u5d9lQDe9
	4XqeOGnU2KUdJmSIZO/lcmSJyu10CZtZ6g5NObQ53SqldDx/ruqXFpTOo00D9ECdDN9RpnCe8U9
	+abacoqD0soo8DkK92cZHJZBMEYdCWSPTr9+9lO//xDD1nVRL4Idrjk06fKEz5LixFYcz
X-Received: by 2002:a05:620a:2844:b0:8c9:e8e9:9bf5 with SMTP id af79cd13be357-8cb8ca6e6efmr1258294985a.53.1771881073482;
        Mon, 23 Feb 2026 13:11:13 -0800 (PST)
X-Received: by 2002:a05:620a:2844:b0:8c9:e8e9:9bf5 with SMTP id af79cd13be357-8cb8ca6e6efmr1258290885a.53.1771881073015;
        Mon, 23 Feb 2026 13:11:13 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0e7875sm834806885a.26.2026.02.23.13.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 13:11:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3a3548ae-c5e1-4ef0-86dd-f66bcd2c6d78@redhat.com>
Date: Mon, 23 Feb 2026 16:11:09 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] cgroup/cpuset: Fix partition related locking
 issues
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260221185418.29319-1-longman@redhat.com>
 <9cc7401e7137e27cd2f02625aab23330@kernel.org>
Content-Language: en-US
In-Reply-To: <9cc7401e7137e27cd2f02625aab23330@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-14169-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_cpuset_prs.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E53917D638
X-Rspamd-Action: no action


On 2/23/26 3:57 PM, Tejun Heo wrote:
> Hello,
>
>> Waiman Long (8):
>>    cgroup/cpuset: Fix incorrect change to effective_xcpus in partition_xcpus_del()
>>    cgroup/cpuset: Fix incorrect use of cpuset_update_tasks_cpumask() in update_cpumasks_hier()
>>    cgroup/cpuset: Clarify exclusion rules for cpuset internal variables
>>    cgroup/cpuset: Set isolated_cpus_updating only if isolated_cpus is changed
>>    kselftest/cgroup: Simplify test_cpuset_prs.sh by removing "S+" command
>>    cgroup/cpuset: Move housekeeping_update()/rebuild_sched_domains() together
>>    cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue
>>    cgroup/cpuset: Call housekeeping_update() without holding cpus_read_lock
> Applied 1-8 to cgroup/for-7.0-fixes with the following minor fixups:
>
> - 5/8: Removed a duplicate test entry that resulted from the "S+"
>    removal (two previously-different lines becoming identical).
>
> - 8/8: Fixed typos in commit message ("essentally" -> "essentially",
>    "beforce" -> "before") and code comment ("top_cpuset_mutex" ->
>    "cpuset_top_mutex").
>
> This has gone through more than enough iterations. We can resolve further
> issues if there's any incrementally.

Thanks for fixing the errors.

Cheers,
Longman


