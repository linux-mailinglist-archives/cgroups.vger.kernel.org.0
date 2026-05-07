Return-Path: <cgroups+bounces-15663-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPJgJzOr/GkNSgAAu9opvQ
	(envelope-from <cgroups+bounces-15663-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 17:09:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B54EAD2F
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C633C30A6635
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB93378D79;
	Thu,  7 May 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W62MmzGV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMWqGBW3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44323ED12B
	for <cgroups@vger.kernel.org>; Thu,  7 May 2026 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166232; cv=none; b=YZjvG/YAhSTjdjkVMVMaZr0SMmJRiuGqESsmJDPQPyatx/fenThVeNDfDULWijnAIvwSZ/XUqUm1tP4r+yeDtt42ELxtuS0ssVqxol/YY8yper1CmOqgkNWChIv+hxX1Q/nZaEvKRCIAeGWHG5pMqW1rT4mzHd0vxI7+Nmet/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166232; c=relaxed/simple;
	bh=UJs5ytlCCyg20J5o4zAHFe4QUueSJXkmMI6sMMBEKkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw7NnNMNryNJxQgTWz4X4FnL/MbA9BrrcpP3yE6T759LD9T0LJyWEQ/8eQZzssHFzYahP/ZJ7aE6eTrhrbIXTQmaQPEWmEwEG1dLsqnmijUsO55CwLzz1o3FSOpANU2qw5Lzpztb9OG5QD1bWEHRr1+XRINXTq+ndFe6TWPxMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W62MmzGV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMWqGBW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778166228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YURhvkXpTF8xikVoRHSszCa7GyvYbYBHZNpB5UERt/A=;
	b=W62MmzGVsORUEa6Cui+fkS77B5o8giUzm+JsfY+OMTJk72b0FRs4WB9wKYXNQGc9n0EmwV
	7RRMX0ChOMO5nCKLu/edFXWXeHWmyMm+fM+3ZUmw+vKYwaSZa7wLnemUQs8d6o8+OtLaJz
	0TDt7Ba570S4JyuVHQroyM3s0NWHI7k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-yEw8r08FMb2EVp83RngoDA-1; Thu, 07 May 2026 11:03:46 -0400
X-MC-Unique: yEw8r08FMb2EVp83RngoDA-1
X-Mimecast-MFC-AGG-ID: yEw8r08FMb2EVp83RngoDA_1778166225
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a55de6fb0so8385665e9.3
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778166225; x=1778771025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YURhvkXpTF8xikVoRHSszCa7GyvYbYBHZNpB5UERt/A=;
        b=aMWqGBW3Zla/3DO/SlaWchUFkCmoqtBZggt5NSfgrHGxqEmKR8nfRd/JAgAo0vSlVU
         eI60uscnPdT414mWDpcB0NEZ+2lOT23y/xSTeuU1Lcz6H4gzvJZ/aHTCoIe6ZgNxagk2
         2l0SWY/jxEuTfRbkbwecTWRf220+6qgOQfM70xnkfNDK7g+opEB9zx5GC0svcYf8GVsy
         g40fdff2Rj+X4nUDM/9mbr3fi5SkNe5mc1sK8IxT7OBELA0nFZ/Naz1MP2l4XHZeOVju
         w7IaEbwK5TSEHjFJR7+glQAG+QtoW5sYj7fO9FEXi0JjmjvFvLzz66v3ufxYr0/f7ahC
         ZLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778166225; x=1778771025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YURhvkXpTF8xikVoRHSszCa7GyvYbYBHZNpB5UERt/A=;
        b=gAZmC4eJ2eIrhNu7WU+XXzk+BMSu90/Y0EAHKwZc/gdrH3xHB9H53NL98CJcaywsyr
         BzEiDkDksGgQV6HiJJzzhu4lktO/2furK7yVSt635boewTzNfuXqXJ+bffEPCyNA9js7
         cclF25o3yiI6WnjusR21bodfBpodwGJqzgG+BsOmJv+78MbQ1z24pum20zsCZYjX/ZH5
         shNsmM0BQ1v9+MP11r6i8fQulBkMhPtX+THgvQpYnZF+P0IJ05dXbDdhEjlv5pPhPWdk
         FJ10cfzVDCcBmtW5WM76RmPKZvpk+DP9iATCjM5M1yMFglZn0S5MHp80rCPvWuwmOBTX
         aimQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Yoj/XTORkUcD/7OuxvxLaA4s1+t1t3CZ0el01Cng9D0+HuMzYX/S8b0sN8EkvYD6B7sXfXidp@vger.kernel.org
X-Gm-Message-State: AOJu0YzeANUIdVA4HVPuR4GkF3Cmn5dVCH8iWaO0cVwYs75IPgmQqvz2
	PwonQaUP1EJBrSZdxnyv1ASEgiBV5IjkdyR3SkKfvvwCHSxfvk7YH9ALkPfK6NKu0ni5G8g88+L
	6pK7EPOyQlotmUMu7bYC6n2X/7+YpB/FiScjvvkKlj8ENxcjp88Yv74vn0bM=
X-Gm-Gg: AeBDiet00GDqzO7YHI8T49aqdN49M5Jc0DDSjyUBoLlVWIh7WBqiNz4JJ8C32M3+wlD
	gsZM1KASB10jIr9AYdKSlXh3V27UUaCue081LgDuybXZWxZyaxG5fg6qw6oCIE2Q4f33O2RcYHX
	0ijZ5lWDV3UIkTkOKEHab+srNBiMRLUAKucprtESbRKd+8I/5+k1WlGsuigA69HbWMs0OzcoG7F
	zAOx5Xs3ezzitJ51yE2IMp3ob3i7WTxGSJjtte8wiG3uVrBuN2nMIir2jGkdKMt3X/j3lYijN85
	PIYnZMS5oJ6gXHgq4clOvpejJuObn8KeXceFEJpCBALZbGBWAv2K165+1Cgib3WPzZ0fEpFIq+X
	RZZy7WKcyDnlUmZISyiBsiDYdM1Aj0ktdtnIRPhogPMh+cptmL75cZjLeMLBGgQ==
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48e51f32c35mr131414385e9.13.1778166224912;
        Thu, 07 May 2026 08:03:44 -0700 (PDT)
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48e51f32c35mr131413315e9.13.1778166224163;
        Thu, 07 May 2026 08:03:44 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.7.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm22020103f8f.31.2026.05.07.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:03:43 -0700 (PDT)
Date: Thu, 7 May 2026 17:03:41 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <afypzfyH0M7Rcge2@jlelli-thinkpadt14gen4.remote.csb>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
X-Rspamd-Queue-Id: 133B54EAD2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15663-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jlelli-thinkpadt14gen4.remote.csb:mid]
X-Rspamd-Action: no action

On 07/05/26 12:53, Peter Zijlstra wrote:
> On Tue, May 05, 2026 at 09:56:58AM -1000, Tejun Heo wrote:

...

> > - However, the cpu controller is a threaded controller which means that it
> >   can have threaded sub-hierarchy where the no-internal-process rule doesn't
> >   apply. This was created explicitly for cpu controller. The proposed change
> >   blocks it effectively forcing cpu controller into regular domain
> >   controller behavior subject to no-internal-process rule. Note these are
> >   enforced at controller granularity and this means that users who use the
> >   threaded mode will be forced to pick between the two.
> 
> Right... this then means we need two controls, one to do hierarchical
> bandwidth distribution, and one to assign bandwidth to the internal
> group -- which is then subject to its own bandwidth distribution
> constraint.
> 
> This might be a little confusing, but there is no way around that
> AFAICT.

Just to check if I'm following, you are thinking something like below?

groupA/
  cpu.rt.max = "50 50 100"       <- 0.5 from root
  cpu.rt.internal = "20 20 100"  <- 0.2 from groupA for threads at this
                                        level
  + threadA                               <
  + threadB                               <
  +- group1/
       cpu.rt.max = "30 30 100"  <- 0.3 from groupA
       + threadC

And we still keep it flat, so 2 dl-entities (per CPU), one handles
threads at groupA level and the other threads inside group1?

Thanks,
Juri


