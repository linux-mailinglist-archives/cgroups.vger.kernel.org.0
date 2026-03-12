Return-Path: <cgroups+bounces-14787-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGl4NsmVsmlJNwAAu9opvQ
	(envelope-from <cgroups+bounces-14787-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 11:30:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A12705A4
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBC03040237
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15A37F74F;
	Thu, 12 Mar 2026 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGSc4b9X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYpxdQYU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF903090D5
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311431; cv=none; b=gtjHF3IXchnWfLCmSekfFtKKPBVDOoD668rCDXEokvxy1mdLXzn97hN6+TdMwXPVrHWs60bouEZYIEQQDai7r0K3fLZc1Z8AhIBVueeBNXvb+9jZXP/pcgGRO374wIxxy4dvG/tOfMjYv8cuLEJ4R0UN/VJKjudjtlxkAZqnpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311431; c=relaxed/simple;
	bh=AyXFsmDJUCozY6rSpw74QhgERTg2l2RQ8xHZngKetwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsjbwMq4wxVGjYhI02zNG9HsCfyVdBilSUYRByxCOOSDTWNPpA6y/ItCwWUTu99bGWuRCksyQfsME4i5NohjCv+op7hGpCw+YxMfHHcmBC0iZl6PJaLv7zwujPsEuyxa7skYiZay4O8dpsGikd1CjUv98iJjM18DiHN9JFpRJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGSc4b9X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYpxdQYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773311428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32DVdFVoSSIS89IzKF6JWHAvaVblS/d3/X9dpjjM4Ns=;
	b=WGSc4b9XhZ3plZIBA55yy3lSscPNSMHpk3+tRgpIziu623IbL4DjXtPXXmvGwkIlPjI6iF
	qkspOM0gdz8Jglcejj1uCUcCOsrICihHJ2P40kyd/hvs57fc2kbBQgLg4wmzMc3hHT7rnS
	ekCroN+W8IVaqBKiLfKftxa/QzZTSp0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-K0CasnsYPgSJtavo32Gtpg-1; Thu, 12 Mar 2026 06:30:27 -0400
X-MC-Unique: K0CasnsYPgSJtavo32Gtpg-1
X-Mimecast-MFC-AGG-ID: K0CasnsYPgSJtavo32Gtpg_1773311426
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7398e393a6so325899a12.1
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773311426; x=1773916226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32DVdFVoSSIS89IzKF6JWHAvaVblS/d3/X9dpjjM4Ns=;
        b=UYpxdQYU5Y+Nq2vJs6qlUfkJsr//F0lDPMzWQe11tLk0gkJh7/NfEvkXCasVZpjvLz
         36dfp/G2Zl8tMkpQeoE2AG4X9rl2ueKMQat6wIbTrSH+3YX+GTxCaDD1g1vrDrJrvR2o
         Qn42dvOEPHUgd+sFc81DkkEG4Qpt/vytgeQjjoCf7cfr80SwHqv06jrNonDgzG3ILhHn
         8t6qA0Bo4cBEL+Fs+AboFwgiV90mx8OxyxuidgtONW4jz5XGdaKNcUTj8itCMj5n0Eoa
         WdbEQkOJoaGlHVX97GNu7aVW29lX4IRpGZm8HM9YTYk+1PM4u6kaqlQPQ0H+eG6bns17
         4ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773311426; x=1773916226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32DVdFVoSSIS89IzKF6JWHAvaVblS/d3/X9dpjjM4Ns=;
        b=GimQMdKwKkCLxYzUzeAp0SxDTuZy5oGHcPClnIgX37O5DjrqmIGnPAY/+zs56YIk9H
         bH3P00QwDHzUKGWiOaI/aZ4HJsKBXjmREvcOe6fSvXkyhEwlfXwwL+1FAF6sivdUQjLs
         8K/hRfMrHB8o73NuFkaZ1k6lNzkvwn/Glgtfyy7T+JVb4Fq3A+o7aB2xvmBB5yDgEnbS
         WI2WMOAt9VjTUTUEgJ0F99jUnT5utx7qjci/78XfxrZxTEIfwngLmh1Fg5NawJV4sRlF
         +QQtLmMyT9ihvrI5Oph76TmMwHi6y2mEGdxVKaKrfuevZS8qwZA2hkyERPlKsCqSoalK
         DuTg==
X-Gm-Message-State: AOJu0Yx6RHQ1AKsfq1XNF9y9MSJtdZFQNGeocCwgqbtajg/TLdvZA5G7
	l5gtyE5VpCV1JLjFqaFJ2AThoyBR+TL6xYqZylhCDwth5iKvq2rpffhR/cBh0Mg3sGMf0J65cY9
	JKt9WA7OFMxDvSU7jRldVl/MVJgwR2lu23xQRRRvRWlWj6lz4jL0EWc7Uu0BAzqgUMrI=
X-Gm-Gg: ATEYQzyCPtC1ErE/aKWvwLT+ISL3aCI1zh1fezQ7njxnqsq1oS040iJBFNPnps+7eI8
	YDlSep1CX8ZgNpZ3d6yZlOWtzeiX75PTURUj7ZrgQKQDB12BqSCPSmRW1Fyw4LPuUaTdiIYyVy1
	jYCTu94fiHuVtp8MR+BGoJQiY6F4MwrQeMi5tvhBMS5kTlkKLpcm2cRlszwB7kL8syyuL/kYEKc
	APohrRc7ta+wUcoy+s3218+EhcrIB2bqYXJj8vOfsEFilcHV5+IYXV56zR4UBbWHavzV4uI6m4/
	gLNd3wba76ABpI8/8io2QBuk+fhltp+Ovu1uRgkn8fJIf4dYe9cGzPaSKTGhkrwVzfQ7cxbEq0j
	fVvciKrM/miLLK4RrzQ==
X-Received: by 2002:a05:6a21:7103:b0:398:c0ba:9cee with SMTP id adf61e73a8af0-398c5e6c8d1mr5177812637.8.1773311425445;
        Thu, 12 Mar 2026 03:30:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:7103:b0:398:c0ba:9cee with SMTP id adf61e73a8af0-398c5e6c8d1mr5177736637.8.1773311424350;
        Thu, 12 Mar 2026 03:30:24 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf9303csm5128727a12.18.2026.03.12.03.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:30:23 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:30:21 +0800
From: Li Wang <liwang@redhat.com>
To: Waiman Long <longman@redhat.com>, Lucas Liu <hongzliu@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Li Wang <liwan@redhat.com>
Subject: Re: [ISSUE] cgroup: test_percpu_basic fails on PREEMPT_RT due to
 lazy percpu stat flushing
Message-ID: <abKVvQc7NPAnoWq8@redhat.com>
References: <CAEnjF8FxM2CGgGC0R42R7R4=udHMtkwV9bCVcw7NDq7KTZMLkg@mail.gmail.com>
 <4238fec3-1a37-4924-b13e-a42d2454412c@redhat.com>
 <abKS4Qt72UP8rYS_@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abKS4Qt72UP8rYS_@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14787-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 422A12705A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 06:18:09PM +0800, Li Wang wrote:
> Waiman Long wrote:
> 
> > On 3/11/26 4:49 AM, Lucas Liu wrote:
> > > Hi recently I met this issue
> > >   ./test_kmem
> > > ok 1 test_kmem_basic
> > > ok 2 test_kmem_memcg_deletion
> > > ok 3 test_kmem_proc_kpagecgroup
> > > ok 4 test_kmem_kernel_stacks
> > > ok 5 test_kmem_dead_cgroups
> > > memory.current 24514560
> > > percpu 15280000
> > > not ok 6 test_percpu_basic
> > > 
> > > In this test the memory.current 24514560, percpu 15280000, Diff ~9.2MB.
> > > 
> > > #define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
> > > 
> > > in this part (8cpus) MAX_VMSTAT_ERROR is 4M memory. On the RT kernel,
> > > the labs(current - percpu) is 9.2M, that is the root cause for this
> > > failure. I am not sure what value is suitable for this case(2M per cpu
> > > maybe?)
> > 
> > Li Wang had posted patches to address some of the problems in this test.
> > 
> > https://lore.kernel.org/lkml/20260306071843.149147-2-liwang@redhat.com/
> > 
> > It could be the case that lazy percpu stat flushing can also be a factor
> > here. In this case, we may need to reread the stat counters again several
> > time with some delay to solve this problem.
> 
> When memory.stat is read, the kernel calls mem_cgroup_flush_stats(), which
> invokes cgroup_rstat_flush() to drain per-cpu counters before returning
> results. So in the normal read path, stats are flushed, they aren't
> arbitrarily stale at the point this test reads them.
> 
> The "lazy" aspect, my understand, is that background flushing maybe skipped
> sometime, as there is an situation: __mem_cgroup_flush_stats() skips the
> flush if the total pending update is below a threshold, i.e.
> 
>   575  static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
>   576  {
>   577          return atomic64_read(&vmstats->stats_updates) >
>   578                  MEMCG_CHARGE_BATCH * num_online_cpus();
>   579  }
> 
> So the "lazy" could happen on a machine with too many CPUs, that threshold
> can be non-trivial and could contribute a few MB of discrepancy.
> 
> But my failure observed on a 3CPUs box, it shouldn't go with "lazy" skip.
> 
>  # ./test_kmem
>  TAP version 13
>  1..6
>  ok 1 test_kmem_basic
>  ok 2 test_kmem_memcg_deletion
>  ok 3 test_kmem_proc_kpagecgroup
>  ok 4 test_kmem_kernel_stacks
>  ok 5 test_kmem_dead_cgroups
>  memory.current 11530240
>  percpu 8440000
>  not ok 6 test_percpu_basic
>  # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
>  
>  # uname -r
>  6.12.0-211.el10.aarch64
>  
>  # getconf PAGE_SIZE
>  4096
>  
>  # lscpu
>  Architecture:                aarch64
>    CPU op-mode(s):            32-bit, 64-bit
>    Byte Order:                Little Endian
>  CPU(s):                      3
>    On-line CPU(s) list:       0-2
>  ...
> 
> Even on Lucas's test system, (8cpus), I assume the pagesize is 4k, the
> threashold is 2M is still less than the failed result:
>   64 × 8 = 512 pages = 512 × 4096 = 2 MB
> 
> Bose on the above two testing, the lazy produce deviation is not
> like the root cause.

BTW, if the lazy flush does become a problem on large-CPU machines
in real test, we can add a retry loop (like Waiman suggested) in a
seperate patch. But I'd prefer to keep this one focused on the
missing slab accounting first.

-- 
Regards,
Li Wang


