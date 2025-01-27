Return-Path: <cgroups+bounces-6330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A33A1CF9D
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 03:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F88F165438
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 02:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD51AA1E0;
	Mon, 27 Jan 2025 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEkvU0Ii"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0357200A3
	for <cgroups@vger.kernel.org>; Mon, 27 Jan 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737946750; cv=none; b=AaaHNt/6xhvGccbvJsJd925d2dplpmOkZf4Mb9qmIpuwGs1mbA4t8ScXUFfqFAKeYRL0DAPGHvVYCakDmZ2Kp8txS6qVtwacrYDv0/eH3QhgfFNwm2jc6oEaFrJtoCUXTZC0TbH3juzdi11iHQFYKHGme8XsaXL57iMAklRKy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737946750; c=relaxed/simple;
	bh=J5gg+ygzIjMDdrcFZ4Wcp34PCbVnoLct7UCtiO6HpJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tMnH4fpLf4cmhh7gKP9TYbZOKWJ55/1xiaeeEhsmUmwyx4AUHm8WIdiOFa1Saeia/qToY15mPObC01eVO8pWurS9cmxBvleFoxO/eWQPmdpQmMEdB3w58+5xLbK1fUhyo+K52iAz2KC8u9lxAiFYsH8ZOnPZ+COyJGYX32kgoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEkvU0Ii; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso66774955ad.3
        for <cgroups@vger.kernel.org>; Sun, 26 Jan 2025 18:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737946747; x=1738551547; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gY7whz075gF2oDUVkEoQRi0JP9AZVP1TZQbx76u1kos=;
        b=EEkvU0Iif3Dx9u3xruy1rmclES5h2vE5UakacT/HQ3YLydv/WqfB5MnMBa0/xrKjOV
         +cSMfz9N50ltmOfIUofO3DHqrojQ5eW1dTNxDaQv55ijtfPXjAA8GtPET9I2N2Z4HPOE
         uFyByCZE+q/exjgy2qHim/bPEcrakH8gEvs1id/3/C4yDmwrKjpNTFMI3UgBAvJZ3Nej
         IWcKa/9JyxOOyhqopvWTDmC7q2ZH2r1N6fu8VeSjanyZBQ/EsG34KgZShqWG5763KmTX
         ni8ZtuoUYg66MyosQH/4j5KWIfAIX0J1kHOVbvTH+1dW48MW/NeCLQnFPLEfxS5Bt+oZ
         hB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737946747; x=1738551547;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY7whz075gF2oDUVkEoQRi0JP9AZVP1TZQbx76u1kos=;
        b=C9yp927yTSKHQ4V4T+FkgkkHnKPKPVUhCylHXB+CRzZXISh7IPIVB/pvzEq+QodRAL
         tehaG9t0qISh2qYssWMWotqyUIuCPTnhanE2lheAnOc6apzZp2vvuclfJuTgW0V81W2Y
         Z248OvH+jGu3eMG0elm8ffdrk0YCSzREZMt1yZ7LgtQKMdW9PxK3+PaS61SIC3BfIRuq
         rTu7YsBtMWLopd1QHr0CTcbGLEHZuSIzdzCayTttwPGzJG5B4zTUTLDvgdjptgYa1RBP
         YnifBQyl9r4c4EoBGhC26EmDnLvWYIlmJvzrpR9p0/rSfkwHMqe3vgGsyuChulauzvpo
         ikJg==
X-Forwarded-Encrypted: i=1; AJvYcCX9LCRjRlT3q1Y08r23QJxEJFQv11WwWwSypG+x68J3/F3F06YzGgsblF2Wr6zZ2MGvvkt6JnRB@vger.kernel.org
X-Gm-Message-State: AOJu0YzHy2O626kK/49tG7vTW02GPbyTCisYGXLP/36ZyQKG86lx1r6f
	sq+Y+QGGoiXpyd7pjqBHVGmfUfprAAXe6Gh198dSD3s4yrEofyCWx7uywJn4ig==
X-Gm-Gg: ASbGnctEyyelVtxGYl0ntCJtdyF6ED9Cnz4dSrxtii5/osVQ5EdKBJGv7D226A2qI8z
	28PAbCjLYo+qwl59ZU9GRt+YECzEy9TtOAiczPJbEJgd18tlmOC3RJpKNwiPS6JAFKhCkqij15k
	JZLcmV7yLOpUhNafKPtWZrCxegSPmav7Lox1AOsi+069Tm1RQOMHlMIOiAE9AlBYBKZXCt2RyQN
	Sd82t0zogaBHabHdBQsMXvLAtaEPTlXNo6S0iFpk9vGQn4PJlEjgQBtDt4hSW++VE9FBQtR/jDh
	RGwCTnFCKU0ytvYGAbMYedq012MGNp/mGWGDnll7SR2UcdPD237r6LMIq6TdkvxG
X-Google-Smtp-Source: AGHT+IEtis62Qgxn0OUJHhskPq+vJz2+MtDmdCQrrgYXMhkRJPuAp/K3UaUnvwTAxqlINGYQ2m8HrA==
X-Received: by 2002:a17:902:e5c6:b0:216:5e6e:68b4 with SMTP id d9443c01a7336-21c355f0a3bmr611437575ad.46.1737946746849;
        Sun, 26 Jan 2025 18:59:06 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424eb96sm52650665ad.222.2025.01.26.18.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 18:59:05 -0800 (PST)
Date: Sun, 26 Jan 2025 18:59:04 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
In-Reply-To: <20250124155420.GA1222@cmpxchg.org>
Message-ID: <9f162aae-00fb-dafd-848f-52214836789d@google.com>
References: <20250124054132.45643-1-hannes@cmpxchg.org> <a90b33c3-7ea3-5375-3fcd-c97cc13c9964@google.com> <20250124155420.GA1222@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Jan 2025, Johannes Weiner wrote:
> On Thu, Jan 23, 2025 at 10:53:04PM -0800, Hugh Dickins wrote:
> > On Fri, 24 Jan 2025, Johannes Weiner wrote:
> > 
> > > The interweaving of two entirely different swap accounting strategies
> > > has been one of the more confusing parts of the memcg code. Split out
> > > the v1 code to clarify the implementation and a handful of callsites,
> > > and to avoid building the v1 bits when !CONFIG_MEMCG_V1.
> > > 
> > >    text	  data	   bss	   dec	   hex	filename
> > >   39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
> > >   38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > I'm not really looking at this, but want to chime in that I found the
> > memcg1 swap stuff in mm/memcontrol.c, not in mm/memcontrol-v1.c, very
> > misleading when I was doing the folio_unqueue_deferred_split() business:
> > so, without looking into the details of it, strongly approve of the
> > direction you're taking here - thank you.
> 
> Thanks, I'm glad to hear that!
> 
> > But thought you could go even further, given that
> > static inline bool do_memsw_account(void)
> > {
> > 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> > }
> > 
> > I thought that amounted to do_memsw_account iff memcg_v1;
> > but I never did grasp cgroup_subsys_on_dfl very well,
> > so ignore me if I'm making no sense to you.
> 
> Yes, technically we should be able to move all the code guarded by
> this check to v1 proper in some form.
> 
> [ It's a runtime check for whether the memory controller is attached
>   to a cgroup1 or a cgroup2 mount. You can still mount the v1
>   controller when !CONFIG_MEMCG_V1, but in that case it won't have any
>   memory control files, so whether we update the memsw counter or not,
>   the results of it won't be visible. ]
> 
> But memcg1_swapout()/swapin() are special in that they are completely
> separate, v1-specific memcg entry points. The same is not true for the
> other occurrences:

Information overload!  Thank you for going to the trouble of explaining
those other cases, appreciated, but by "thought you could go even further",
all I had meant was that the do_memsw_account() checks in memcg1_swap*()
looked redundant to me; and possibly some other do_memsw_account() checks.
I'll say no more, I don't want to expose my memcg2 ignorance further,
and I don't deserve another reply.

Hugh

> 
> - mem_cgroup_margin():
> - mem_cgroup_get_max():
> 
> 	The v1 part is about half the function in both cases. We could
> 	split that out into a v1 subfunction, but IMO at a relatively
> 	high cost to the readability of the v1 control flow.
> 
> - drain_stock:
> - try_charge_memcg:
> - uncharge_batch:
> - mem_cgroup_replace_folio:
> - __mem_cgroup_try_charge_swap:
> - __mem_cgroup_uncharge_swap:
> - mem_cgroup_get_nr_swap_pages:
> - mem_cgroup_swap_full:
> 
> 	The majority of the code applies to v2 or both versions, and
> 	the v1 checks either cause an early return or guard the update
> 	to the memsw page_counter.
> 
> 	So not much to farm out code-wise. And the test uses a static
> 	branch, so not much overhead to be cut either.

