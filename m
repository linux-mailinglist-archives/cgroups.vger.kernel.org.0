Return-Path: <cgroups+bounces-17406-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ViZHHTjtQ2qwlgoAu9opvQ
	(envelope-from <cgroups+bounces-17406-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 18:22:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8AB6E6643
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 18:22:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J3nVYiKZ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17406-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17406-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5972030421B1
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D85477E28;
	Tue, 30 Jun 2026 16:22:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC274779BF
	for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 16:22:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836533; cv=none; b=C77bFv7yjSEfkcMKX+oKH37CKtYy1hg/FtGbUT2h2og71EJea0QezP/fP+4ENlGzzQ+ymfaU7u74HIFK2mFEPmLaQQzg/C+5W68C6iwsglt88LphfADwva9Itmkz+CLJDMyz0BG2IlVAord2k1w0Xpfaf01KIjJ4l6KCHeo6s5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836533; c=relaxed/simple;
	bh=FKXhz8s3Vd+6bRKnI5aQiQgbkf0y8yxy+g2UiuewnfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2bjkYa+IK5wY5igpVm2c4K1Wno8X9wPgnDPBafMu3Ks71DCDnQtz8srnCffRD2s6X+I7ggkPObOVgizMJaGHNK4kweV9M34AmOAdjFT0YXWDa/Pji7S3cFdHhg/7eGA7DVhmFUSZNUIJv3cALc1hYpme6QDNNkBSmgiohtDl5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3nVYiKZ; arc=none smtp.client-ip=209.85.161.46
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69e9b037d82so3452249eaf.2
        for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782836531; x=1783441331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acv2p4BFA8gRpGMf2Eyfsq9WFKOfOwtHU816xigiBjE=;
        b=J3nVYiKZM5tcDNJkHkYPsPu6hl709S430ztA4aOm4LUTWmcn60WBcTTEgwrFCKY5TX
         5vp86H4kk+OsNXRITZMj8K0U/4WIj2yws+kjvaUJiq+2gt2OcidCyaCKGjksg1HGLIM8
         wyRsNxJZ0zInYc5IBznnUE/Z5FRl2Y9yxulf25sRxIc7VDpidaRWEj2eOE8+0lrs9wgQ
         YLUHWpOYWt/rFS2VnljehxXjb0cUrJeY+1wiR+Piz5HiJ9OhEy+JgOqOHF8GoOIH9Kxr
         1Blck6WcNDtXOpYTOeCf/61Nqve+CUassQ/KQajJUF8QvsXt42tL4Vapi5VyY5TW4njr
         G8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836531; x=1783441331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acv2p4BFA8gRpGMf2Eyfsq9WFKOfOwtHU816xigiBjE=;
        b=SIHyv/146Y9YzNyjF0aX/Xwi1rFN1/Miy3ewU2N0xX/1bQaniy/6x4fXekgMYos7CZ
         TvrkKfcUdv5/Cz2MTiTeORf8ld8n9xgLSoRtzPzu1E1GsDXcomZ7OeSx8KnYjZqVB7dG
         idHyq+NnPPgKgUBud6/kcfYH0bHHp94TfXyp2OT1bemFqt6YjthPt8xUGjX1znmhmasi
         JLepTxOiPMZ+u03yECTwrVGFsujhie+gO81ITvM81O/S+KdYEBgb1FsQGbKjs2fR3+jV
         TOACW8nijmBUwDGGki54s9OQ/URStt9ZAS9N6bIHObb1oPzzR0zIH9UKqT1Bf6uGYX6Z
         G5Eg==
X-Forwarded-Encrypted: i=1; AFNElJ/9DiDDdBdGlHmteN2X65pcm1MmtHvj6/Q+4ZCXIbwG8AsgqAHIH7RPbdARm9G1oKLiOM66I521@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvdp4tbhVhDKxyAZt7L5s+w2p/w77nCqeHO50U/hk4ABIew6zy
	MYTYoXSS8cg0qgeuSGSLZ/kK7xwCaGFWml4VH2U7ndaM6NP7f1WCZRF4dciHyA==
X-Gm-Gg: AfdE7clpfgpj6bsrxHPjkFJ5KpjUcooAZNI0RG7u4dm9bkB30s+cCVzfBJ4peuSZM0p
	x8cT7iJPyUm75N5mkofNGjrKd8IMxUUqV+Fj9iZeH6kz2iLTu8bn6xdf1yMW8Ez6JBVQH8ncZsX
	K3e94B1rShLZJbMwQaRon4RJ5dnCR6P7mf9asaQvkBeoNLixdlGAiwltiUOTUcMQEiDZZ4PfwTc
	jpYSRwllek/635YErvuxYboLVdZUlflHvK1JlfQDUUlEODnkWQvShfsFUeh/GdS8qdMWH0Vg6/h
	h3EF5Ox50TAbcLIrejRS5rE7VXnMGtA+q2E2NDZawOszFcVPdG1NoQlLwpzWfPH3K2egylUHmB9
	0V9MKgr5ORVuCZbGu4QJYVNDVeOkLuoIiPQWbUnYAJtvbKJV0tbZIJXYR7nSGgQ0jCHFG7xd6kQ
	+o+FHLkypbG8b6U/dGEYMrgwgDdZBzGQ8bsC1jC4mtpyg=
X-Received: by 2002:a4a:d2e1:0:b0:6a1:154c:8199 with SMTP id 006d021491bc7-6a1891d3bdemr2567738eaf.40.1782836530787;
        Tue, 30 Jun 2026 09:22:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:13::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a189493f93sm2155547eaf.14.2026.06.30.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:22:10 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RESEND PATCH v2] mm/memcontrol: Avoid stuck FLUSHING_CACHED_CHARGE on isolated CPU
Date: Tue, 30 Jun 2026 09:22:07 -0700
Message-ID: <20260630162208.1159952-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630070004.470181-1-hui.zhu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:hui.zhu@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:zhuhui@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17406-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B8AB6E6643

On Tue, 30 Jun 2026 15:00:04 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:

> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> drain_all_stock() sets FLUSHING_CACHED_CHARGE before calling
> schedule_drain_work() to queue per-CPU drain work.  When the target
> CPU is isolated (cpu_is_isolated() == true), the work is silently
> not queued, but FLUSHING_CACHED_CHARGE stays set.  Every subsequent
> drain_all_stock() then sees the bit and skips this stock entirely,
> so the entry is effectively pinned until something else on that CPU
> runs drain_local_*_stock() and clears the bit -- which on a long-
> isolated CPU may never happen.

Hello Hui,

I hope you're doing well! Thank you for the patch. I've also been
thinking about memcg stock and specifically on how the flushing happens.

I haven't been thinking about the issue of isolated work taking a long
time, but I have been reworking memcg stock by getting rid of it and
pushing it down to the page_counter level [1].

I think that this patch is still important because of the obj_stock
portion, which my series doens't touch. I just wanted to bring this
to your attention! I don't think there should be any other problems.

Thank you again, have a great day!
Joshua

[1] https://lore.kernel.org/all/20260623180124.868655-1-joshua.hahnjy@gmail.com/

> The original idea was to actually perform the drain from the calling
> CPU on behalf of the isolated one, by adding a lock around the
> per-CPU stock so that a remote drainer could safely touch it.  In
> practice this turned out to be intrusive: the stock data structures
> and their fast paths (consume_stock(), refill_stock(), the obj_stock
> helpers) are deliberately designed around current-CPU-only access,
> and retrofitting cross-CPU serialisation onto them adds non-trivial
> locking and PREEMPT_RT concerns for very little gain.
> 
> Looking at the actual amount of charge that can accumulate in a
> single per-CPU stock, it is bounded and small, so leaving an
> isolated CPU's stock undrained for a while is not a real problem.
> The only real bug is that the stuck FLUSHING_CACHED_CHARGE bit
> prevents future drain_all_stock() callers from re-attempting once
> the CPU is no longer isolated.
> 
> Fix this minimally by clearing FLUSHING_CACHED_CHARGE when the work
> could not be queued because the target CPU is isolated.  The cached
> charge itself is left in place; it will be released the next time
> the CPU runs drain_local_*_stock() (e.g. after leaving isolation,
> or if the isolated CPU itself calls drain_all_stock() -- in that
> case cpu == curcpu causes drain_local_memcg_stock() to be invoked
> directly), and the next drain_all_stock() call is free to retry
> instead of skipping the stock forever.
> 
> Fixes: 6a792697a53a ("memcg: do not drain charge pcp caches on remote isolated cpus")
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
> Changelog:
> v2:
> According to the comments of Waiman Long, updated fixes.
> 
>  mm/memcontrol.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6dc4888a90f3..2e66b4a2c25d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2256,7 +2256,8 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
>  	return flush;
>  }
>  
> -static void schedule_drain_work(int cpu, struct work_struct *work)
> +static void
> +schedule_drain_work(int cpu, struct work_struct *work, unsigned long *flags)
>  {
>  	/*
>  	 * Protect housekeeping cpumask read and work enqueue together
> @@ -2264,9 +2265,22 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>  	 * partition update only need to wait for an RCU GP and flush the
>  	 * pending work on newly isolated CPUs.
>  	 */
> -	guard(rcu)();
> -	if (!cpu_is_isolated(cpu))
> -		queue_work_on(cpu, memcg_wq, work);
> +	scoped_guard(rcu) {
> +		if (!cpu_is_isolated(cpu)) {
> +			queue_work_on(cpu, memcg_wq, work);
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * The target CPU is isolated: the drain work was not queued.
> +	 * Clear FLUSHING_CACHED_CHARGE so that future drain_all_stock()
> +	 * callers can re-attempt instead of skipping this stock forever.
> +	 * The cached charge is left in place; it will be released the
> +	 * next time the CPU itself runs drain_local_*_stock() (e.g.
> +	 * after leaving isolation), or by a follow-up mechanism.
> +	 */
> +	clear_bit(FLUSHING_CACHED_CHARGE, flags);
>  }
>  
>  /*
> @@ -2299,7 +2313,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  			if (cpu == curcpu)
>  				drain_local_memcg_stock(&memcg_st->work);
>  			else
> -				schedule_drain_work(cpu, &memcg_st->work);
> +				schedule_drain_work(cpu, &memcg_st->work,
> +						    &memcg_st->flags);
>  		}
>  
>  		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
> @@ -2309,7 +2324,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  			if (cpu == curcpu)
>  				drain_local_obj_stock(&obj_st->work);
>  			else
> -				schedule_drain_work(cpu, &obj_st->work);
> +				schedule_drain_work(cpu, &obj_st->work,
> +						    &obj_st->flags);
>  		}
>  	}
>  	migrate_enable();
> -- 
> 2.43.0

