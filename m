Return-Path: <cgroups+bounces-15115-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK8kJGTIymmL/wUAu9opvQ
	(envelope-from <cgroups+bounces-15115-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 21:00:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BE360122
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E8EA303FD9C
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009E3E0251;
	Mon, 30 Mar 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIdg/ZZW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A33C140E
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897191; cv=none; b=LILNS1Cf7qUpOitqy+IkRngJ3bI26r5vRtDPDHlZvkHgZIsEAoWQRhALflWFTnEYoqFqyrLiWoWDhPOShlp0Oz7miscVElcnovjOWwmZcHz4E2hyrZkiRb4rVr1DDijjmd6Ee26NNf0SGEwayRikCPT/FmAVmZvGku9OleVSvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897191; c=relaxed/simple;
	bh=5BjoNsXzpMy+cVOBp+gg/3lFykrDC40QD5dKZmKMGTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEHbXlR1Qg4x1iAPm2Wliyf1Q7sUosji1fo43rMSDPiREUY816SRxwFGbLsPhmaLlVDPPrWJR5J92HfwwiR3SNEvtLFhSvpUel8jwca6K0X5vTgXZRlmnIrQ1Yff0d+ZHwp3kLN459RrV9IxE7sY/KuTQG31NKXmM9EMv7BrB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIdg/ZZW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-464ba2bb3aeso2850894b6e.1
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774897189; x=1775501989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFGS6w31Laz9Ddur1i7GLVmK/pVD2soBNffdP6C8TRo=;
        b=FIdg/ZZWuZtvCfbGY9TJBP0JcUsXK3cpvfzRxiBDU0sM8R67jZawLj6XnSOvkIM7MV
         ZWb+li5/FUErpMW0x+fRpj4SQiOEJiRuRlqFflxjJ0qa5FiTaMvsFMBFdXet69Oxrlxx
         dO3CmU7odExNg3/lcQKpyDNLIxGHXjTVoEnMN2fbkP2prpuGtESaslSMDl+ZGNUyUcHM
         KrGMRN7/1zaLweNAX7Ch4yyEmt0WznoTuOpMwehahDxGxp5vrxYowQfF/41+nHeQdIl1
         g1eW/ZODO2WX5TQZxCswcwXHpvxeFWWPywpnUjX0LG5o2smc4Cu+dWJSxTgF84CtND89
         mg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774897189; x=1775501989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFGS6w31Laz9Ddur1i7GLVmK/pVD2soBNffdP6C8TRo=;
        b=lrFIZtQFSE0FD2UtpDvRqwgCV21bV7O7iFtRFHJkP/nkkycYpjbdYp4Gm/WXTgzcRU
         uvVvZxlmh7McaQcDn3jeinx0DvDOrQppXNujEGk7Ipk/h4JXUDvSbWg0Bk/dYq3NjmzZ
         k6RwEdWb+2FGMliBMDyQrnMHIJvolUpbq5idNDw6VWT2Zlo2IZU3pAjty/ZXoSnb59Hl
         0ifL0YRgSl2sA8KAL+DwS+5IzpBbyxAegwcAQjszD4g/Ze4iZTMpJ1GWN7VArsSci2Ok
         e85qMmSkIlcawlKNstTTdvDVmgBlw7JPQFz3uUFvgxVkziR4cCH4gL7+qOmWFppsLaWq
         CJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCV8s/Q7KEj0F3IPjNIUeLjnukqiUKpzjhmIku4OtShGA/RYlGEFppGF9aR5UT/pckjRrDvB9tRZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxXm0hurFI/ZuZQ00VynvA1Kh0/SF29+KswJ1R++JkpLZqU6P9F
	JhZTtItLjJ1AMuQNmXtsHgWOzTg675bb08D59kIdRVCLB1PWE6pN/0vJ
X-Gm-Gg: ATEYQzwShufQxNv18qrFg0MtbC/A0iJnwgfhYy4itwzBr1qxyeorPJ+CakFRATRG4CV
	4J3HytRqz5YTJCaQX7jXp3r2xfgfKUZNFTM3OzJZO6BwzhPotqcVfQpnjvDTxfQ9bhlbs+JVH5+
	TLU2fsgzXnE9jqYsqA/TwyRXtI2MOGxOn64ZzsT0N5utRiip3v+UEOKwVoaC3ad5LI1bI2+yiAK
	ZQAK4NFBnrtiUz8q+kpcvtWz5LQ6aYk+pmBOPmOLviy29JQTPVh8j79Yn9B4nAfax1+wzIuLNiJ
	NFmlPevwFumFopEh+BMOFxpYJEEBiczV2K4TelusgojRkqiVtWwEcgvr0BOmXLFeMKdQPp/Uky1
	v7YuuWn3cZdHs2IwVy2enrWXm6LhNmBcJXg6xGOE2Db5RWLd8yRmys1Fo5wyR0O8S/ULdP+DxXf
	feyxvSAn6nksZDsk8hWjd6DQ==
X-Received: by 2002:a05:6808:2f09:b0:467:f1e5:a294 with SMTP id 5614622812f47-46acdb4b61cmr444228b6e.4.1774897188917;
        Mon, 30 Mar 2026 11:59:48 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa03656e2sm5180605b6e.11.2026.03.30.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:59:48 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
Date: Mon, 30 Mar 2026 11:59:45 -0700
Message-ID: <20260330185947.2427740-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAO9r8zOKaPocJYMKL=A=6=qpWgwCa=fMC8EZsSW+632M1q1sZg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15115-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F0BE360122
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 11:35:38 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> On Mon, Mar 30, 2026 at 7:21 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 30-03-26 07:10:10, Joshua Hahn wrote:
> > > On Mon, 30 Mar 2026 14:03:29 +0200 Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > > On Fri 27-03-26 12:19:35, Joshua Hahn wrote:
> > > > > Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> > > > > to give visibility into per-node breakdowns for percpu allocations and
> > > > > turn it into NR_PERCPU_B.
> > > >
> > > > Why do we need/want this?
> > >
> > > Hello Michal,
> > >
> > > Thank you for reviewing my patch! I hope you are doing well.
> > >
> > > You're right, I could have done a better job of motivating the patch.
> > > My intent with this patch is to give some more visibility into where
> > > memory is physically, once you know which memcg it is in.
> >
> > Please keep in mind that WHY is very often much more important than HOW
> > in the patch so you should always start with the intention and
> > justification.
> >
> > > Percpu memory could probably be seen as "trivial" when it comes to figuring
> > > out what node it is on, but I'm hoping to make similar transitions to the
> > > rest of enum memcg_stat_item as well (you can see my work for the zswap
> > > stats in [1]).
> > >
> > > When all of the memory is moved from being tracked per-memcg to per-lruvec,
> > > then the final vision would be able to attribute node placement within
> > > each memcg, which can help with diagnosing things like asymmetric node
> > > pressure within a memcg, which is currently only partially accurate.
> > >
> > > Getting per-node breakdowns of percpu memory orthogonal to memcgs also
> > > seems like a win to me. While unlikely, I think that we can benefit from
> > > some amount of visibility into whether percpu allocations are happening
> > > equally across all CPUs.
> > >
> > > What do you think? Thank you again, I hope you have a great day!
> >
> > I think that you should have started with this intended outcome first
> > rather than slicing it in pieces. Why do we want to shift to per-node
> > stats for other/all counters? What is the cost associated comparing to the
> > existing accounting (if any)? Please go into details on how do you plan
> > to use the data before we commit into a lot of code churn.
> >
> > TBH I do not see any fundamental reasons why this would be impossible
> > but I am not really sure this is worth the work and I also do not see
> > potential subtle issues that we might stumble over when getting there.
> > So I would appreciate if you could have a look into that deeper and
> > provide us with evaluation on how do you want to achieve your end goal
> > and what can we expect on the way. It is, of course, impossible to see
> > all potential problems without starting implementing the thing but a
> > high level evaluation would be really helpful.
> 
> You should probably also speak to extra memory overhead to move all
> these stats from per-memcg to per-lruvec.

Hello Yosry,

Thank you for your feedback!

Here are the things that I cna see from my end:
- NR_PERCPU_B adds a byte per-node, per-cpu. I think this is manageable.
- lruvec_stats_percpu grows by 1 long in 2 arrays (state, state_prev) since
  NR_MEMCG_NODE_STAT_ITEMS grows by 1 from ~30. This is +16 bytes per
  cgroup x node x CPU. Even still, I'm not sure this is too concerning,
  on a host with 300 CPUs across 2 nodes with 100 cgroups (theoretical)
  we would see a 16 * 300 * 2 * 100 = 937 kB change, less than a mB (and
  I think this would be considered a big machine).

What do you think? Do these numbers look acceptable?

Thanks again for your insights, I hope you have a great day : -)
Joshua

