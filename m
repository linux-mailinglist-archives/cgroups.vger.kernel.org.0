Return-Path: <cgroups+bounces-15109-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHUyJrGUymkR+QUAu9opvQ
	(envelope-from <cgroups+bounces-15109-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 17:20:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95635DADF
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 17:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FC4F306A4E9
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8D32B98D;
	Mon, 30 Mar 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFy7WIPJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513153290AF
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882573; cv=none; b=mxkLri+8hEJvQlnMurSxuXLO1hvzj/kHAYJ6HjvLn4x5lzJNEPMXrE8mo3dGpIuARs+tMh8eF2r22HAs8Vbyfn0hg0qDSZZ2FiUTb7IKNF0kr8v8hjIw7yJVLUW6GXopgQgN3NAKE7v7Q6/zKQui1VdK3Eg/+w9N5JtIjD3p1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882573; c=relaxed/simple;
	bh=+CVv43g6Xaq0P7zA+4Wmh55geO6kvMEqdExsmVSR2xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/1BsmDT/M0o2jI4tvDbs2Z3ixH7DssoDLyEREvbrjEV4icLrfRZUwvpkzLoH2M6OvS3CFek0yGRxx+UaKIW6CujDjRAPUPJigTH9XrJcPLDT14xUr2hKMp+aHIF1Wv+EFn+V+AVn3c/9en4AHDpAHu3xHqkuI+4Ss33OJkJgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFy7WIPJ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7d50516e9so2959015a34.1
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774882571; x=1775487371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWKiqYjc9QcqJoKDuyruIGFZFhuWm0LaKPO8vIwd1A4=;
        b=jFy7WIPJ/p8Z4bPEeWIk93rLqxkxLgjkDSV0LtRxhewD9zo9KbWZjbN37obLm70bC4
         omaQol2iFwyEBDpH3wKAvKmZ83Lx6zZuQyHM8yzxRYUG3uGytZ7P/qj/2U/7wDTwBIES
         z5KeWWQRTY9p4lHXaSalegi/8VzsI+8AP1tFdg75cPZoyrmOzmjNUq0WYT47ga1jc47y
         TlNIuZmO5rb5wl3edGFa16DOnT5jutxaMgJ4tQydXq5DAJLjKi8ydVeWi7drQKlP/gOu
         QjALqeWs/vBns75xfjDP/jLVVuR1LYVxngGYdUIYvXp7z3EA3l3jBsAA44GqEuiQyeVS
         pnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882571; x=1775487371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XWKiqYjc9QcqJoKDuyruIGFZFhuWm0LaKPO8vIwd1A4=;
        b=h9mnzRbDk47nPzefkxQv9DAQ6pbfKFfkRsZ+Em8D+GSeE+UCgA7mekdqaNHxGHtyvG
         Iq0cMMRQHlTqMsMgerijoAm1c78gTMvj+ToaZW4qV9qML81KHvbAQqOuUBK8K9s9lPpS
         VHbkW3u9CrTu7JOfPi4jk+VJBPYqhTTOE5Jgcd6ifGvcGnTVSMN/9ewDmUg3MdUY+dsS
         eSxbTuA/24m1CzKMvwnp93X+5KZqAIft9bxHRjt/bitNu+o8TD2TazOcfNI/xtwFBrT8
         hSBldnjENTl6aI57Q2K92xW7rDVl1sx0QP5p7tY9fVln0UGC4n7Ji33mmp/kRADyWJVZ
         B6aA==
X-Forwarded-Encrypted: i=1; AJvYcCX+xYA0NDY7x4rM7afR353yNh8YnqHtLhAYZJonrANIJy02QcDqcfJXwZ6300OEVLR+i64L4JXt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpzgd2f6Wo7vhQZcm1iG2pOANXzDk6LQKkMCEfoUyJwSbowDft
	F0LTcYJ0SSFt1zAaTsZ9of6o1v91Ck/zdjAuGW8aA3AomHRQlEWy9QFC
X-Gm-Gg: ATEYQzyt9vmC63cTnRhC5XmBWnG2YrvVruI7n7Fw+k8+//G5mP71l4VmLKoUnAwOLOJ
	5JYxUybvT6RmdWyeapFqTxuBqhLLou8dMOniwYOV2aOXUPwqsXFsaHsi9WaEWGSf0Sf9RYjZtud
	Wp3zlCi3Dbv0PAIr2QAZSWzbKNbODgLcNcBEGqvawARGP3Fta1bCV7txTS2Bx8cntQIIZ2DosAJ
	iRVN4rYru7CB4dUzsZCqHPtkOPDBcBWGTJKtdRmApHxpfwOBwlwamb7dirLwX/7fdDP4vPdkGhB
	0nJz29TaAkyEAZ1LnyoXYUR/be5TNzb1sXUK9kXG1Y3E84DpGHF48bj3UuCgXEn52qbMY6SoMjz
	/ykuSNC+DuYLG3PtUQKt8OF9V1ukPY/1tEj3eFuibwLP4hSHTKDlORYOWvOE+urx6DfuBsisIMM
	H0HYNhQ0rypXD87ZJkjYQd
X-Received: by 2002:a05:6830:6a89:b0:7d7:d15a:ce8e with SMTP id 46e09a7af769-7d9fafafb09mr7526126a34.32.1774882571282;
        Mon, 30 Mar 2026 07:56:11 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a864514sm6135587a34.26.2026.03.30.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:56:10 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Date: Mon, 30 Mar 2026 07:56:07 -0700
Message-ID: <20260330145608.3574897-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <acqG2Mr5ekCn2HD0@tiehlicka>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15109-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA95635DADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 16:21:12 +0200 Michal Hocko <mhocko@suse.com> wrote:

> On Mon 30-03-26 07:10:10, Joshua Hahn wrote:
> > On Mon, 30 Mar 2026 14:03:29 +0200 Michal Hocko <mhocko@suse.com> wrote:
> > 
> > > On Fri 27-03-26 12:19:35, Joshua Hahn wrote:
> > > > Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> > > > to give visibility into per-node breakdowns for percpu allocations and
> > > > turn it into NR_PERCPU_B.
> > > 
> > > Why do we need/want this?
> > 
> > Hello Michal,
> > 
> > Thank you for reviewing my patch! I hope you are doing well.
> > 
> > You're right, I could have done a better job of motivating the patch.
> > My intent with this patch is to give some more visibility into where
> > memory is physically, once you know which memcg it is in.
> 
> Please keep in mind that WHY is very often much more important than HOW
> in the patch so you should always start with the intention and
> justification.

Ack, I'll keep in mind for the future!

> > Percpu memory could probably be seen as "trivial" when it comes to figuring
> > out what node it is on, but I'm hoping to make similar transitions to the
> > rest of enum memcg_stat_item as well (you can see my work for the zswap
> > stats in [1]).
> > 
> > When all of the memory is moved from being tracked per-memcg to per-lruvec,
> > then the final vision would be able to attribute node placement within
> > each memcg, which can help with diagnosing things like asymmetric node
> > pressure within a memcg, which is currently only partially accurate.
> > 
> > Getting per-node breakdowns of percpu memory orthogonal to memcgs also
> > seems like a win to me. While unlikely, I think that we can benefit from
> > some amount of visibility into whether percpu allocations are happening
> > equally across all CPUs.
> > 
> > What do you think? Thank you again, I hope you have a great day!

Thank you for the feedback, Michal. Let me break down your questions so I
can address them one-by-one:

> I think that you should have started with this intended outcome first
> rather than slicing it in pieces. Why do we want to shift to per-node
> stats for other/all counters? What is the cost associated comparing to the

Yup, ack here as well. Here is a bit more context on why I stumbled on this
in the first place. As you are aware, I'm also working on another series
whose goal is to make memory limits tier-aware [2]. While working on this,
I realized that memory in the enum memcg_stat_item had no physical
association, which meant that identifying (1) which node / tier they were on,
and (2) which node / tier the memory should be migrated to was completely
invisible.

That was the original motivation. Looking deeper I found that this is not
even a tier problem but rather just a lack of visibility into node-level
statistics for the user.

As another example, recently I have seen an example of socket memory
landing in CXL, which is really quite strange. (Was it demoted? Was it
through a fallback allocation?) It was only visible after there was an OOM
and I could use the vmcore to inspect the data manually and figure out
the page placement.

I was thinking that it would be very nice to have this level of node-level
perspective along with the memcg association because IMO something like
this has more value in being analyzed at runtime, rather than during a
post-mortem with the vmcore, and there is more we can do by understanding
what was happening at the system when this strange placement happened.

> What is the cost associated comparing to the
> existing accounting (if any)? Please go into details on how do you plan
> to use the data before we commit into a lot of code churn.

For percpu specifically, I think the cost is minimal. Thankfully these
changes also have minimal effects on single-NUMA machines as well.
But let me get some concrete numbers and get back to you so that I can
back these hypotheses up.

> TBH I do not see any fundamental reasons why this would be impossible
> but I am not really sure this is worth the work and I also do not see
> potential subtle issues that we might stumble over when getting there.
> So I would appreciate if you could have a look into that deeper and
> provide us with evaluation on how do you want to achieve your end goal
> and what can we expect on the way. It is, of course, impossible to see
> all potential problems without starting implementing the thing but a
> high level evaluation would be really helpful.

Great to hear that you think this is not impossible ; -)

Yes, I also definitely see that there can be some subtle issues. One thing
I'm trying to be very mindful of is locking semantics, whether we are
introducing any new bottlenecks for updates. I'll do some testing and
come back with numbers, hopefully that can instill some more confidence
with the side effects of these patches.

As a note of concern I do believe that socket memory will be tough
to track accurately since it uses a different model of memory accounting.
I hope that there can be some steps to make it more accurate without
introducing overhead in the socket hotpaths, since those are highly
performance-sensitive.

Another concern is what to do with MEMCG_SWAP, which is not really able
to be associated with a node. But swap is unique in that it genuinely
does not take up the memory in memory. So maybe at the end of all of this
when there is only MEMCG_SWAP in memcg_stat_item, we can treat it as a
single special case. 

Thank you for your thoughts Michal, I greatly appreciate them.
I hope you have a great day!
Joshua

> > [1] https://lore.kernel.org/all/20260311195153.4013476-1-joshua.hahnjy@gmail.com/
[2] https://lore.kernel.org/all/20260223223830.586018-1-joshua.hahnjy@gmail.com/

