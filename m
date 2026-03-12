Return-Path: <cgroups+bounces-14786-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHjMG+ySsmnONgAAu9opvQ
	(envelope-from <cgroups+bounces-14786-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 11:18:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E012A27041A
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 11:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7D953006536
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C91373C15;
	Thu, 12 Mar 2026 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2XNUNdc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="capZ3wXv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A823A9B3
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310697; cv=none; b=ane9tQ5qb6EsIg6uzCJYaN1RfKJc7ho1sXc78S1GprPHQZ7myxuEAARFiR087Svpvh1cJlO97Pnx6D+qyzG0+GvFaGZdbTzYdrQfONrHucvVoKd2Es5GpEPnIL2oxpZXHfk1qr8/1VndwWfOrVEhmBuzVWEhzEu7ExnNLy73kKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310697; c=relaxed/simple;
	bh=KRa4nEL6VAUnm3fAZ8Iplu+mkuF9gZAzbtyCij9zg54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6of0yp7LRZtQjMnrbdBZPKVkcpkK2g9U3MUDLtZITmfeH8nkIKkF3uj3CzjkojU8NCEnOHy2yFRCBvX66i1KJlFcxm3Dnr3eP4pTdYGiOd49PJ63eleiHKm/NBQLG9NfITOOhUmSwiVN0KJNVFpZVliz9xg37QB2Fw8H1CX0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2XNUNdc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=capZ3wXv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773310695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+Ji6hNrczoVrWaESBn86h3gDK3SZFevfxChGYgg3H0=;
	b=d2XNUNdceQZDR8ZWuHQMjRBS0k12dbL+PxW99EQpS73cTv38m79wmEbQzHTcYjx43uBOVK
	Sw3HXggZB9WqyjhMyNSh7ZpXcdLloauxVHGSXHkt1vCdPgjR+jjJfT8HJf3pUZds5pvDR0
	u+YEiwTQXME7dfCsCjXgcFVNfnf4+bY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490--Qe3VylPNxKy616PS5j6wQ-1; Thu, 12 Mar 2026 06:18:14 -0400
X-MC-Unique: -Qe3VylPNxKy616PS5j6wQ-1
X-Mimecast-MFC-AGG-ID: -Qe3VylPNxKy616PS5j6wQ_1773310693
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82988b04c5cso3031827b3a.3
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773310693; x=1773915493; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+Ji6hNrczoVrWaESBn86h3gDK3SZFevfxChGYgg3H0=;
        b=capZ3wXvdA9v+pth5rWa7wSYHWM68bCpLNPVrycN8DFP1GUe+WA9ufMlZby9qs/t0B
         mSU6Z+ovsfJGocpHip8OCKlNuJqrUZJauF5AeN80YUvJ9+pmlWZkhWyJEcYd2fWP8zL8
         xGfPfSlM+LaBAX4gmduVurNjuZTrLaC1cXGn3ryo9A1ya5ScyvniYlbsGOC5I0u8pHQR
         ul3tGGx2vo363HRRqZKw0ti3L91HMzD5FDPflYV12Wo/EbRqigHIlNx7IIEkwtMo5Ni9
         g/Vb7XtUVcbngTKIyLGP9DgyVo9R74el2BJw6DKUeB3/IM8xJZgr28NKK5cJfLgDmWgm
         y0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773310693; x=1773915493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+Ji6hNrczoVrWaESBn86h3gDK3SZFevfxChGYgg3H0=;
        b=hhATmgnPlQ7X6+brwpHOk3Byu/4NzuW2j8RsF+w0xv+8BFJXQV9gVIwfjv3F/JiTi/
         rpOpm8l5ijTFemek+AYdymNjXDp6cS137kQ6vxkMQ89K0LM+/SItS2bJxlRiilKBasbX
         Z+GaDnvju6Yle6/JDHHuClz3N1es4+YDNs+r92K9YZRrl12w3ZzdcwE6lcsqPydS5eb5
         cAojyExnjSzu3U37IiZCAHWriZF0zyVKJUHl/1QqSgTA2/nuZc31KjD9PpOk5BLyBW5U
         HVt4t3aATA0QYq72BGnMXCGfQVkxEqg9TVmt+qW6gS/76zszJjB/1dvzKYJjRU+GyID1
         EjPA==
X-Gm-Message-State: AOJu0YzNPDn9MIPxpf+sr+YGi8wPZsFu6z5ooXwxYAeDwdPVJHupM1WJ
	l7O3ETVyhmtFXywM3XYgT1D85rPLUTKz/uthDsBcZoU35qBEOlSe2YFeUu5DIHf+rrr5VKw1hDX
	JrfT9zk/2mXDBB51gQVfSjiYYkoiUGlFLDPKeJyzyMb2cIKhA0uL1XGt6eeoQsBj/z3k=
X-Gm-Gg: ATEYQzzPHQyxIEqZOX74G1wYVfaOXEHtyNEWqfcsoZNIqxy63qAKKomH0ahDgicgD01
	M7ug0w49flLgzlDUmEsb70VmXZJLEPDDuhP6caHXfQFQP17HubgKWfHBg4roh+MauoiM7JgYVta
	2ygPbhmRVfS1O8agh53Etp1ai8zIJEDIyZ1yQ/QXcUOz9sm/t8/PpVPYoNfUPGzYvOltth/kVc3
	+vMRngqZxFYTISEbPe9tmf2kLfkM7yaheOk86c5UK9jReSukZ0Zj3of+gA8lv8BdotUgmrWWIFL
	m34T8yViiacbtbsDY2DsigokCrvGBlA2Qv+v12pNvJAqH62RXYHO4MaX2gh8sdlOGuUcLky79MA
	9SorFrWv7dYC18vplhw==
X-Received: by 2002:a05:6a00:4c90:b0:823:5270:ef48 with SMTP id d2e1a72fcca58-829f7108c0bmr5039381b3a.33.1773310692843;
        Thu, 12 Mar 2026 03:18:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c90:b0:823:5270:ef48 with SMTP id d2e1a72fcca58-829f7108c0bmr5039356b3a.33.1773310692404;
        Thu, 12 Mar 2026 03:18:12 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a06fe211csm2635592b3a.0.2026.03.12.03.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:18:11 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:18:09 +0800
From: Li Wang <liwang@redhat.com>
To: Waiman Long <longman@redhat.com>, Lucas Liu <hongzliu@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Li Wang <liwan@redhat.com>
Subject: Re: [ISSUE] cgroup: test_percpu_basic fails on PREEMPT_RT due to
 lazy percpu stat flushing
Message-ID: <abKS4Qt72UP8rYS_@redhat.com>
References: <CAEnjF8FxM2CGgGC0R42R7R4=udHMtkwV9bCVcw7NDq7KTZMLkg@mail.gmail.com>
 <4238fec3-1a37-4924-b13e-a42d2454412c@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4238fec3-1a37-4924-b13e-a42d2454412c@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14786-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E012A27041A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Waiman Long wrote:

> On 3/11/26 4:49 AM, Lucas Liu wrote:
> > Hi recently I met this issue
> >   ./test_kmem
> > ok 1 test_kmem_basic
> > ok 2 test_kmem_memcg_deletion
> > ok 3 test_kmem_proc_kpagecgroup
> > ok 4 test_kmem_kernel_stacks
> > ok 5 test_kmem_dead_cgroups
> > memory.current 24514560
> > percpu 15280000
> > not ok 6 test_percpu_basic
> > 
> > In this test the memory.current 24514560, percpu 15280000, Diff ~9.2MB.
> > 
> > #define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
> > 
> > in this part (8cpus) MAX_VMSTAT_ERROR is 4M memory. On the RT kernel,
> > the labs(current - percpu) is 9.2M, that is the root cause for this
> > failure. I am not sure what value is suitable for this case(2M per cpu
> > maybe?)
> 
> Li Wang had posted patches to address some of the problems in this test.
> 
> https://lore.kernel.org/lkml/20260306071843.149147-2-liwang@redhat.com/
> 
> It could be the case that lazy percpu stat flushing can also be a factor
> here. In this case, we may need to reread the stat counters again several
> time with some delay to solve this problem.

When memory.stat is read, the kernel calls mem_cgroup_flush_stats(), which
invokes cgroup_rstat_flush() to drain per-cpu counters before returning
results. So in the normal read path, stats are flushed, they aren't
arbitrarily stale at the point this test reads them.

The "lazy" aspect, my understand, is that background flushing maybe skipped
sometime, as there is an situation: __mem_cgroup_flush_stats() skips the
flush if the total pending update is below a threshold, i.e.

  575  static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
  576  {
  577          return atomic64_read(&vmstats->stats_updates) >
  578                  MEMCG_CHARGE_BATCH * num_online_cpus();
  579  }

So the "lazy" could happen on a machine with too many CPUs, that threshold
can be non-trivial and could contribute a few MB of discrepancy.

But my failure observed on a 3CPUs box, it shouldn't go with "lazy" skip.

 # ./test_kmem
 TAP version 13
 1..6
 ok 1 test_kmem_basic
 ok 2 test_kmem_memcg_deletion
 ok 3 test_kmem_proc_kpagecgroup
 ok 4 test_kmem_kernel_stacks
 ok 5 test_kmem_dead_cgroups
 memory.current 11530240
 percpu 8440000
 not ok 6 test_percpu_basic
 # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
 
 # uname -r
 6.12.0-211.el10.aarch64
 
 # getconf PAGE_SIZE
 4096
 
 # lscpu
 Architecture:                aarch64
   CPU op-mode(s):            32-bit, 64-bit
   Byte Order:                Little Endian
 CPU(s):                      3
   On-line CPU(s) list:       0-2
 ...

Even on Lucas's test system, (8cpus), I assume the pagesize is 4k, the
threashold is 2M is still less than the failed result:
  64 × 8 = 512 pages = 512 × 4096 = 2 MB

Bose on the above two testing, the lazy produce deviation is not
like the root cause.

-- 
Regards,
Li Wang


