Return-Path: <cgroups+bounces-15108-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO+oFnyIymn09gUAu9opvQ
	(envelope-from <cgroups+bounces-15108-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 16:28:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561F35CD32
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 16:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 468723000FCA
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7AA3D8121;
	Mon, 30 Mar 2026 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cXzUaOSO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A43A6B9E
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880477; cv=none; b=dIY+F4ajQMkJgkHX19vUBbwruocDgCw8VDzaf71eVRrxR0yCYnCFiEY5SnLBTk/NOEAF4n/4tbW9dre0u32ovTxCNyLCU0ff982GMVy80IHijK8DH8TkevRXPkHzXwoWYCTxnArMIQq8vhkXCI15O2Nw+hThmUPdLlOLY+yt3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880477; c=relaxed/simple;
	bh=UUKXlwT0m6VqmkPUCS2Ig+RSGPEazYfaChHNok//06Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnl2rKCVKyqwFGIPslE0rUN4A8ErhyCxkmq4uf7BGr1qaaZeX06vA8WpdwKotnGVn6EgoYKZn/Ocl5If9oD7DIEmPHNNbt2XqZjGO7i8caww7u+V1bGM2QUOA8/fdBq9FpWzkEx40oq6Dy6uaz/NGKnfB/KeXkyLTR/uPdLlGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cXzUaOSO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b41b545d9so4970367f8f.2
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774880475; x=1775485275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/ozzOwDq7xepOmxDik1p69jmSO0OqDcfdyRDIq86y8=;
        b=cXzUaOSOpHf6I1xsf7SKsgHwpFGUiJAEPCaIZlSfS4oCpm/r013PX88WFPSdHaLAwA
         pdTVk8M5do9o1fViPDjeEjh6zH4PRw1vtqrFvhykXhwbAqKCsP3+6fxu6cA2FYKoLPiJ
         EQYr13GNkMvJHGuwcfwrL/SNjQUNXb+vOCHcydq3FggTZrFlu0WDXRDjJ5s9GL5jWr5I
         pi4fAdzuav6jFkUqCaBQ+eyXFr4n90ele+Dnt2WECb/B/Nvo673RJLoTuAm2TcKnmGGF
         MOcuIO8OxdexR60QTUuZLvbsYpca/5uKtG9e58XbxH7sbjPUkUZfL/MDVPfOwJcBu+rt
         7Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880475; x=1775485275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/ozzOwDq7xepOmxDik1p69jmSO0OqDcfdyRDIq86y8=;
        b=MOheWnmBagbzR5ezpmO6hpUWHB2bxiIwQkHIsQPPaNpYXePT4mgc4MMMfxjiHccUjH
         NaaKugH3Nr/F00zIDrHvWHrbTZhfyb1S4WbtJl45MG5h8aOeLgs3iDhRg1770Bs8jI+Q
         VR9I/ffc9x5Ozjte7YC921ufCnfAVeW84p2FIA5MaK3SnZxsJ3XGM3dpB0Z+e/iqxcnU
         86QSXsApTLAUf3F/uEVlIfyLbjCggdMilofHX/Fz+iJlzavFqM6DszNXYIeWUiQbAHQI
         ku6Isrgh/yhzJ4kZ7ft1RgUi2d/LbZ5xuV6T8xQ1QVDusRB/6LLdBGWc/n5SLMorpPpH
         ZjSg==
X-Forwarded-Encrypted: i=1; AJvYcCVmZUgd06w0KJSmXXfmrQZN0SIECfRPKEIhfZzZvjTUFStEzekL9SJ8NMrg0OB0+jN4yBPP+99L@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTewjKJCaagd/Ui0woItahVsU4O/rj39zY9zM0SPfD7MNnBEv
	qIezmBjTWnonynog/pQ7Hv5Rh4YxRplGhnNqoxsnWmLXhW3z6NQYX8x6DOKZkhsIBvw=
X-Gm-Gg: ATEYQzyc42MJNlBrgu47nSTGCCfs+NMteHaYPmsJTTsSsaqZ01hgCPiAgvORLffw9kn
	bzojBj786D+WErZxptnK5PoBz3QnQmkU2NFG1td3lKg+6rF6R6Tged7FdjxfO9/8iEVxqfY7C3j
	nwb+W1I3nNPS9Ay49TITeb37967nhGLGyFL8Z7qMdcFmZC+892Ueenu/W907iqwWZ4+17zgA4sg
	/ABUhNlgliBPkSqdlpYGgYoHShz34/MrtdH7f1xQNCGEuFnp1x3XxlXUhngoLaq5R8DZIIuXH7L
	CEW5QbLmKvOeBXVmUkjZepP9XYrbgJqrFV7y6aT0luEe4Sc1GvpigFnhsQAHiGH3k52f+Mz8DhL
	8zTtJm1s0Dyztypu1/9sHb5bB6X3Qmwm7IcgLwJ84aM2ECA9l6yEWtBxgxL/Fwu8pTlEW61EDmx
	Z/zSCICTTHMVGaTnLP5xYOOThHSOzPiTwYDU/C
X-Received: by 2002:a05:6000:290b:b0:43c:f976:b8de with SMTP id ffacd0b85a97d-43cf976b9famr9996886f8f.20.1774880474446;
        Mon, 30 Mar 2026 07:21:14 -0700 (PDT)
Received: from localhost (109-81-17-175.rct.o2.cz. [109.81.17.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580194sm17882325f8f.37.2026.03.30.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:21:14 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:21:12 +0200
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Message-ID: <acqG2Mr5ekCn2HD0@tiehlicka>
References: <acpmkY6_gWLdtJCB@tiehlicka>
 <20260330141010.3126996-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330141010.3126996-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15108-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.858];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 8561F35CD32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon 30-03-26 07:10:10, Joshua Hahn wrote:
> On Mon, 30 Mar 2026 14:03:29 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Fri 27-03-26 12:19:35, Joshua Hahn wrote:
> > > Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> > > to give visibility into per-node breakdowns for percpu allocations and
> > > turn it into NR_PERCPU_B.
> > 
> > Why do we need/want this?
> 
> Hello Michal,
> 
> Thank you for reviewing my patch! I hope you are doing well.
> 
> You're right, I could have done a better job of motivating the patch.
> My intent with this patch is to give some more visibility into where
> memory is physically, once you know which memcg it is in.

Please keep in mind that WHY is very often much more important than HOW
in the patch so you should always start with the intention and
justification.

> Percpu memory could probably be seen as "trivial" when it comes to figuring
> out what node it is on, but I'm hoping to make similar transitions to the
> rest of enum memcg_stat_item as well (you can see my work for the zswap
> stats in [1]).
> 
> When all of the memory is moved from being tracked per-memcg to per-lruvec,
> then the final vision would be able to attribute node placement within
> each memcg, which can help with diagnosing things like asymmetric node
> pressure within a memcg, which is currently only partially accurate.
> 
> Getting per-node breakdowns of percpu memory orthogonal to memcgs also
> seems like a win to me. While unlikely, I think that we can benefit from
> some amount of visibility into whether percpu allocations are happening
> equally across all CPUs.
> 
> What do you think? Thank you again, I hope you have a great day!

I think that you should have started with this intended outcome first
rather than slicing it in pieces. Why do we want to shift to per-node
stats for other/all counters? What is the cost associated comparing to the
existing accounting (if any)? Please go into details on how do you plan
to use the data before we commit into a lot of code churn.

TBH I do not see any fundamental reasons why this would be impossible
but I am not really sure this is worth the work and I also do not see
potential subtle issues that we might stumble over when getting there.
So I would appreciate if you could have a look into that deeper and
provide us with evaluation on how do you want to achieve your end goal
and what can we expect on the way. It is, of course, impossible to see
all potential problems without starting implementing the thing but a
high level evaluation would be really helpful.

> Joshua
> 
> [1] https://lore.kernel.org/all/20260311195153.4013476-1-joshua.hahnjy@gmail.com/

-- 
Michal Hocko
SUSE Labs

