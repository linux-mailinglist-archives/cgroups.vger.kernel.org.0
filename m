Return-Path: <cgroups+bounces-6139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3497A10CA4
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1DC188A7E1
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF1B1ADC79;
	Tue, 14 Jan 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EselIIvZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BC23245F
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873204; cv=none; b=ab3+/B3AzwTKIOaxYcoAynCjqk/T26W0fHDrICpg4Jznvmsc/SIMWmDXCa6DfQWaIKkg1tp5DtP/HLLXpmj29hJ1ZArGHGjBjWChj/dpuJQMaGHwtYMrawZ0P3HB3LIgpQrV+/uADaj5sxBZFXENiUBcQdlSA5j+8xBvgmuUTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873204; c=relaxed/simple;
	bh=Od7cT+6OePddRARsQyMIKh3g3Dy5MlIPURlz6c/4yws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZIKC9I7hRETLkXB6TPEA3ng1CLSs7qe5mPUzjTwmY+9YWRnNJA0JGyVSmsufprfXl9I4H3qWEPl6Vu6PzmxPoO2X/L7GrrLsoyzFYYtXywKSvJBDwtjIwgL5+BYRN3CjBgw7P5PjjQ/8dEJO3toMBVxF+ldZhANTS3oY64Abck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EselIIvZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso9531013a12.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736873201; x=1737478001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2BHjXvqFbc3tWWjsYaH/7UzCgd7nB1pFhFnKUVV49g=;
        b=EselIIvZ1ddCBSnF85Vk0x7VLm0Vl0yG1YjxACBn0tzEruK3MFYy6i27MSI0Pqn2SN
         kEXd7xBukl1XZjwtAiCy52MzkvsxeHxC9+iraUBtPX1D3p68dgFWS+h74YZzJ50nkgyz
         pULlUKg/6GuhfwZWjDaCrk5RhNUraim4XhkZuGyz7myvddCHi2aRaQZSFFyP+C2LycHY
         +9+C3K8kKm5UfTK2ynlmDj44Gqpd8kAaoxa5yFRr4iKUGgQL616QPEEmPI31KYBShurO
         QxkPEPupPFLK1q+EupcL3khmQ7jJptTCDeqiYgMh69P6Olk1DbWbQLwKQsSFi0OLxvyI
         AezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873201; x=1737478001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2BHjXvqFbc3tWWjsYaH/7UzCgd7nB1pFhFnKUVV49g=;
        b=S7iUwpHpmrpOcnLlwWYjmw+BhADROxbCNm/8GyKJQ3MHWcjBadCglXYpe+Iu6TXK72
         HX6qu8Ada6zxI90Ui+CNZKkG6fcwl2Jx7R20Xoltr9d9Ey+fNsO77ZUqlxHVoMdrHK7P
         c/PGhi7RZ01GS9Stb4VNll0bdo+DF3T0PHwk5+AiZ1BjOXqPQVZ68Etpd6LovZh8N6az
         yUd/S10vh0jPkAOOk2qzho+QPLCosn5+PgRzOf+gQtfX93C4EJEq/LATvQmFIw0xBXb+
         dhwSjS142k8PWik0lCuRMN3GB8vOxWR8s4cNLBkM7/GFCbX9Fg5S8l0RUIasO4Xz/ZbD
         OT3A==
X-Forwarded-Encrypted: i=1; AJvYcCXqsOpM3+Mh/+7ewOOyP5fFpwI1Dg0r3RWanN/5FV7PD2j6MbMEmWLJIHUexutLUpz0y+sBHT2W@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8lQJYHab6UP/rjfpVtflX3LJmcSIVYCRyZ7nZMH8TAeuqtk0
	uTDuMD/VYfyGrnALfdHxjvXDgu9UCW9PaFP0v/rO+AsO4G8cblf0b5h/lEC9hEk=
X-Gm-Gg: ASbGnctuKagbWNcXuK2JheSniDU9C0eBnNUSIFtKeSuZ/8++zOuTBoxF64TnDvVbInl
	FXz1KfG0kzB7u0e/eV4Q7rCk2Zq54Qot51WIczTOgt855gn3O67v9WYkPDXlhcWwoyALxxBrQ1H
	8YiD2NBPzrd7zpjfVKw3vh3vpsCKdDOp7fkZE3eYjT40w3nw8mDwXubSQAzorNTPJiTtUjF7IWT
	ir37ZqBUa1cfQ31Fwdbgxzm1cTK9JTKI1+B+hg+x85a7W6548LVWrtwsG1dBbT0S3HdKQ==
X-Google-Smtp-Source: AGHT+IHPbTGhIrcMN7gSIY4GR5omZuGW4NRVR+gBuMJJgCqPbIEcYAZVtpjD8uuNUx3jv0VoINP82A==
X-Received: by 2002:a05:6402:50c9:b0:5d9:a61:e7c9 with SMTP id 4fb4d7f45d1cf-5d972e1bf6fmr24029174a12.20.1736873198702;
        Tue, 14 Jan 2025 08:46:38 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d98fe8f68csm6433022a12.0.2025.01.14.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:46:38 -0800 (PST)
Date: Tue, 14 Jan 2025 17:46:37 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z4aU7dn_TKeeTmP_@tiehlicka>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z2BJoDsMeKi4LQGe@tiehlicka>
 <20250114160955.GA1115056@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114160955.GA1115056@cmpxchg.org>

On Tue 14-01-25 11:09:55, Johannes Weiner wrote:
> Hi,
> 
> On Mon, Dec 16, 2024 at 04:39:12PM +0100, Michal Hocko wrote:
> > On Thu 12-12-24 13:30:12, Johannes Weiner wrote:
[...]
> > > If we return -ENOMEM to an OOM victim in a fault, the fault handler
> > > will re-trigger OOM, which will find the existing OOM victim and do
> > > nothing, then restart the fault.
> > 
> > IIRC the task will handle the pending SIGKILL if the #PF fails. If the
> > charge happens from the exit path then we rely on ENOMEM returned from
> > gup as a signal to back off. Do we have any caller that keeps retrying
> > on ENOMEM?
> 
> We managed to extract a stack trace of the livelocked task:
> 
> obj_cgroup_may_swap
> zswap_store
> swap_writepage
> shrink_folio_list
> shrink_lruvec
> shrink_node
> do_try_to_free_pages
> try_to_free_mem_cgroup_pages

OK, so this is the reclaim path and it fails due to reasons you mention
below. This will retry several times until it hits mem_cgroup_oom which
will bail in mem_cgroup_out_of_memory because of task_is_dying (returns
true) and retry the charge + reclaim (as the oom killer hasn't done
anything) with passed_oom = true this time and eventually got to nomem
path and returns ENOMEM. This should propaged -ENOMEM down the path

> charge_memcg
> mem_cgroup_swapin_charge_folio
> __read_swap_cache_async
> swapin_readahead
> do_swap_page
> handle_mm_fault
> do_user_addr_fault
> exc_page_fault
> asm_exc_page_fault
> __get_user

All the way here and return the failure to futex_cleanup which doesn't
retry __get_user on the failure AFAICS (exit_robust_list). But I might
be missing something, it's been quite some time since I've looked into
futex code.

> futex_cleanup
> fuxtex_exit_release
> do_exit
> do_group_exit
> get_signal
> arch_do_signal_or_restart
> exit_to_user_mode_prepare
> syscall_exit_to_user_mode
> do_syscall
> entry_SYSCALL_64
> syscall
> 
> Both memory.max and memory.zswap.max are hit. I don't see how this
> could ever make forward progress - the futex fault will retry until it
> succeeds.

I must be missing something but I do not see the retry, could you point
me where this is happening please?

-- 
Michal Hocko
SUSE Labs

