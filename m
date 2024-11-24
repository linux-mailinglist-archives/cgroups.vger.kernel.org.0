Return-Path: <cgroups+bounces-5674-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78BC9D7227
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2024 15:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B72164808
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2024 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC01F428F;
	Sun, 24 Nov 2024 13:38:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C341F428B;
	Sun, 24 Nov 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455536; cv=none; b=pEQFq2sfhqayPEG70UG/agnhZCGoN1uF5Fc36nOvph0dpQNDVDh3Vj6o7COPzhJU+6RHQfYzurZnu+DSojaUbFgP+i3C9M5yEDv6ylMvTojcaP8Pn8aXJ0S6pWDU1C0D8jHO8gBDb2Ca0azwnDmUa9RAQTdCeRjMUgK6XVcWYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455536; c=relaxed/simple;
	bh=OyVpN1p0XlBXrxg0R170MBcQmjAZ+eiNjVGiI6Dn8Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqP0OWjfAowrwOQosWk257BVdFsIz7rT4Z0FZA1Y2S2skn1VcEoFuIn8O0rS/C9iC1Ahs55xw6oIZwkkW+iDXdiw/n4lNxDnt3rzTzNqiVCGcWAYR43a1ES37JvJx8M8ha/cPU1+yVuSRy8jLj2AirEij+7Z7dMpaZcjmxlr5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EB8C4CECC;
	Sun, 24 Nov 2024 13:38:54 +0000 (UTC)
Date: Sun, 24 Nov 2024 08:39:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>, Suren Baghdasaryan
 <surenb@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <20241124083939.1fab4656@gandalf.local.home>
In-Reply-To: <c3eb6f05-f857-4c3d-9ef8-2488baecb00c@suse.cz>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
	<Z0IKhWfOr4ppnQem@casper.infradead.org>
	<i3joc4vme76imq2etk7gjfntsy2z5l5niyqobeun5e7m6jh4yi@adwzrxbvuc6l>
	<c3eb6f05-f857-4c3d-9ef8-2488baecb00c@suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Nov 2024 22:38:59 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/23/24 22:35, Shakeel Butt wrote:
> > On Sat, Nov 23, 2024 at 05:01:57PM +0000, Matthew Wilcox wrote:  
> >> On Fri, Nov 22, 2024 at 10:09:39PM -0800, Shakeel Butt wrote:  
> >> >  	TP_printk(
> >> > -		"mm=%p memcg_path=%s write=%s",
> >> > -		__entry->mm,
> >> > -		__get_str(memcg_path),
> >> > +		"mm=%p memcg_id=%llu write=%s",
> >> > +		__entry->mm, __entry->memcg_id,
> >> >  		__entry->write ? "true" : "false"  
> >> 
> >> Is it actually useful to print out the (hashed) pointer of the mm?
> >> Wouldn't the PID be more useful so you could actually associate it with
> >> a task?
> >>   
> > 
> > For our usecase i.e. bpftrace, we don't really care about these prints
> > as we can directly access the arguments like mm in bpftrace. I wonder if
> > others are using this hased pointer in some other way. I don't mind
> > chaning it but I think that would be a separate patch.  
> 
> I wonder if it's actually hashed when trace events are obtained in binary
> form, i.e. via trace-cmd. Might be hashed only when doing e.g. cat
> trace_pipe as that's when the kernel's printk with its hashing is used?
> 
> I guess that would be another argument for not using it in the tracepoint,
> as it would be a sidechannel...

This is no more a sidechannel than /proc/kallsyms. It is only accessible
via the privileged users. It's very common and useful to show pointers in
trace events.

You can use eprobes to get information off of pointers too:

 echo 'e:mmap_lock_count mmap_lock/mmap_lock_start_locking count=+0($mm):u32' > /sys/kernel/tracing/dynamic_events

and now you have an event that shows the mm_count of the mm structure.

-- Steve

