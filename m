Return-Path: <cgroups+bounces-15164-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHBuJrM3zmmAmAYAu9opvQ
	(envelope-from <cgroups+bounces-15164-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 11:32:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 381EB386F86
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E646730C6538
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2026 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11870382365;
	Thu,  2 Apr 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxcNR/jT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J180q0GQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330953939C8
	for <cgroups@vger.kernel.org>; Thu,  2 Apr 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122040; cv=none; b=rrMiBPAmXg9DdreZYZvI7d+mQ26GuAID/FhEw4h8hAbS+/uXd0PNUkUlsnX13V7MbUEILrUKUH1nBcKG/V+N7dIx5PkX7kPJ/8QIMWzYXwaEdZIK0YSHLrHm7U7E1ZhRlt614Ls7MRoNemu8UePlC9x89tsXnJ/brU5Iy7Du+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122040; c=relaxed/simple;
	bh=8HBEZkldhVOCvg+h8X+QyqxrVDgc44S4RwM2B4Lv89Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwj3RTtF4z09CE5a+2zarbP2p07L4WRyVHJI7aZEUoUkpaPb3DA+kAXQy8dD993JtfZVb1Jai02RCeLOR3NMjgJ+NtxnAqSszz788MwVKoOfNei3gPZSXrT5XX42EsACgnK8Lhui2Qsb9YoH8RRLMhYuuvbAPmRM5aDJJnN/m5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxcNR/jT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J180q0GQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775122030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36+ATcVryHEsHCfEL0i5GnGjSCxjk7f9m5BZERXBqcg=;
	b=WxcNR/jTpy8FNj3+m3kIgzNB1kOzMLYe0bTrsZTpfy2RpPXaqdvhaOhjhIVfNV/iGMzI9P
	VdKpbqKYmDZ3SQ9H+0Q7h6m56zoh2MGbKhTmQhqD9ctVa+FwWM5RwthGMmweWVXxNPqH5Z
	Zodjx1FueDTYs6Gx+24wIA0xJ3kRWDE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-MeOSfxCdOPuhIJSJ9YJ3xA-1; Thu, 02 Apr 2026 05:27:09 -0400
X-MC-Unique: MeOSfxCdOPuhIJSJ9YJ3xA-1
X-Mimecast-MFC-AGG-ID: MeOSfxCdOPuhIJSJ9YJ3xA_1775122028
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so824352a91.1
        for <cgroups@vger.kernel.org>; Thu, 02 Apr 2026 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775122028; x=1775726828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=36+ATcVryHEsHCfEL0i5GnGjSCxjk7f9m5BZERXBqcg=;
        b=J180q0GQPV0hVzyI1LSWUzdunwlCqdvAbMluYOJpoyMvgzWAzljWCOaI9zzUvvFJcD
         ZUAT8Xu++6Ynh/1n+sAfMpRVDPi/FVm3qbyFaSh6H3fPnylL5/tsyWvZ1SLrYVJD+o5c
         6/tPuaE+Cy/uhlBNYpyrijYtmx4fs7kc6FqRYBtGdbKrnS80NKUU0YeHsp9NNMMc6Bf5
         3Gb/2h2up4dQifohO3u9MxJ/y3+QW3U7dMf90vBbxdtbt3UEhQwHrmZNcEG2+fg6NMPl
         EPpAE9qarkD4+hdKuEngS0fvhHrrPy0ygUc2l/Jc01fk0hckVrt0Wv+zQ73+vino/DJ0
         KOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122028; x=1775726828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36+ATcVryHEsHCfEL0i5GnGjSCxjk7f9m5BZERXBqcg=;
        b=JTzx7s/hm9CCTQYUqDrE4xoE1erSK1WgKSvYSAehzSbHPCl+w4x0BdNMsUiDvzFeyV
         gsl+0og/nnzVNF2Kc5Oxgj+WiXHfGsstLuS8wsLkrKWBSiGZuTGB25SsLoAHlaeYd4Uo
         cFlBukkRofx/P0oBvMXkWikMM4aF8XZw5GOnIERukwzerAqbnvH6YBK355SNCknuScTn
         Wf0SzA44YiF5k+DEQskgJd/6qrSUUpgsQjAs386DWouUoQc+MVnaoiSZ1OUxseZEujiV
         AcnYG1LJzVKRKddbUYozaP/9fMHL/iIQlhI6IpSjU9By2fK+gblvj9wCGlQHS11lHi5H
         qVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW16G9YrsBFchXWn24KuEMkhC7tzTI6W67ZhhWJTaKHhaHHMev7P8JL+sKTiUOYb4XrJAR8MX7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEEyv/NVj8xwg0tOb8qvYZKkjZmmve6ZQ4pzhj0xmpbpztge4
	SXSAiEA/My9e0JaYQr7Es74n0X1SeZeqStMnm3gwmVLvyQN+JNHcufJuIJVx/HlwxgVux/7ZYtJ
	FqCsUEUdnliPy37C3+mtD14r5ymVenpMUxAr7XOc6NIWqs9IbOQG8E5Rg8fM=
X-Gm-Gg: AeBDieurOT1G7rfhm0HdmpTzJRTlpBHry+lFsGVVCsKbEwtYu5hyKs7JikwtKgiJ6+s
	weMAv+l0T4KK5M9KDIxO4g1gemuSE1QvQmfvx80OdlYFQ+pBtq+ino/8spALp02Zfg5LjoWOMew
	z441my5Jact0qZYXhq0NlcMNSxvsX9JP1ve5BNPzTECWGtot97tLJ10yjyZ3y3zMZa4DmUyP4Mg
	6lvHMflsGiS/BMJOb2FiWVHkV6cD2UUMEpgHt/y5C0gc7aWC2cUScDEdRgr+CHEkxfKhwX4fzlw
	ANM+IIEv0e27IMdtD3fbjnE4Q3ftWVo3BCyDctkf/690akTOgAg0aAHb1/0Y6ZvsrYHIyQ4/fqY
	wVMaGHCN5TKydvCAiTw==
X-Received: by 2002:a17:90b:3947:b0:35b:e566:15a6 with SMTP id 98e67ed59e1d1-35dc6f4f018mr6646525a91.28.1775122027806;
        Thu, 02 Apr 2026 02:27:07 -0700 (PDT)
X-Received: by 2002:a17:90b:3947:b0:35b:e566:15a6 with SMTP id 98e67ed59e1d1-35dc6f4f018mr6646481a91.28.1775122027294;
        Thu, 02 Apr 2026 02:27:07 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477736dsm22344875ad.24.2026.04.02.02.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:27:06 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:27:04 +0800
From: Li Wang <liwang@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH v2 1/7] memcg: Scale up vmstats flush threshold with
 int_sqrt(nr_cpus+2)
Message-ID: <ac42aIDVaGim5moO@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-2-longman@redhat.com>
 <n6mhkjsxsami3qmczkdh57eep4lmcgbtyl7ox3ajzveke44yf6@m4bjevvsr47k>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <n6mhkjsxsami3qmczkdh57eep4lmcgbtyl7ox3ajzveke44yf6@m4bjevvsr47k>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[redhat.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15164-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 381EB386F86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michal,

> Hello Waiman and Li.
> ...
> The explanation seems [1] to just pick a function because log seemed too
> slow.
> 
> (We should add a BPF hook to calculate the threshold. Haha, Date:)
> 
> The threshold has twofold role: to bound error and to preserve some
> performance thanks to laziness and these two go against each other when
> determining the threshold. The reasoning for linear scaling is that
> _each_ CPU contributes some updates so that preserves the laziness.
> Whereas error capping would hint to no dependency on nr_cpus.
> 
> My idea is that a job associated to a selected memcg doesn't necessarily
> run on _all_ CPUs of (such big) machines but effectively cause updates
> on J CPUs. (Either they're artificially constrained or they simply are
> not-so-parallel jobs.) 

> Hence the threshold should be based on that J and not actual nr_cpus.

I completely agree on this point.

> Now the question is what is expected (CPU) size of a job and for that
> I'd would consider a distribution like:
> - 1 job of size nr_cpus, // you'd overcommit your machine with bigger job
> - 2 jobs of size nr_cpus/2,
> - 3 jobs of size nr_cpus/3,
> - ...
> - nr_cpus jobs of size 1. // you'd underutilize the machine with fewer
> 
> Note this is quite naïve and arbitrary deliberation of mine but it
> results in something like Pareto distribution which is IMO quite
> reasonable. With (only) that assumption, I can estimate the average size
> of jobs like
> 	nr_cpus / (log(nr_cpus) + 1)
> (it's natural logarithm from harmonic series and +1 is from that
> approximation too, it comes handy also on UP)
> 
> 	log(x) = ilog2(x) * log(2)/log(e) ~ ilog2(x) * 0.69
> 	log(x) ~ 45426 * ilog2(x) / 65536
> 
> or 
> 	65536*nr_cpus / (45426 * ilog2(nr_cpus) + 65536)
> 
> 
> with kernel functions:
> 	var1 = 65536*nr_cpus / (45426 * ilog2(nr_cpus) + 65536)
> 	var2 = DIV_ROUND_UP(65536*nr_cpus, 45426 * ilog2(nr_cpus) + 65536)
> 	var3 = roundup_pow_of_two(var2)
> 
> I hope I don't need to present any more numbers at this moment because
> the parameter derivation is backed by solid theory ;-) [*]
> [*]

It is a elegant method but still not based on the J CPUs.

As you capture the core tension: bounding error wants the threshold
as small as possible, while preserving laziness wants it as large as
possible. Any scheme is a compromise between the two.

But there has several practical issues:

The threshold formula is system-wide, while each memcg has its own counter,
they all evaluate against the same MEMCG_CHARGE_BATCH * f(nr_cpu_ids),
with no awareness of how many CPUs are actually active for that particular
memcg. Small tasks with J=2 coexist with large services where J approaches
nr_cpus, yet they all face the same threshold. The ln-harmonic formula
optimizes for the average J, but workloads that most critically need
accurate memory.stat are precisely those spanning many CPUs, well above
average.

Moreover, the "average J" estimate assumes tasks are uniformly distributed
across CPUs, which rarely holds in practice with cpuset constraints, NUMA
affinity, and nested cgroup hierarchies. And even accepting that estimate,
the data shows ln-harmonic still yields 237MB of error at 2048 CPUs with
64K pages — still large enough to cause selftest failures.

In short: the theoretical analysis is sound, but the conclusion conflates
average case with worst case. Under the constraint of a single global
threshold, sqrt remains the more robust choice.

In future, if the J-sensory threshold per-memcg can be achieved, then your
ln-harmonic method is the most ideal formula.

To compare the three methods (linear, sqrt, ln-harmonic):

4K page size (BATCH=64):

  CPUs   linear   sqrt     ln-var3
  --------------------------------
  1      256KB    256KB     256KB
  2      512KB    512KB     512KB
  4      1MB      512KB     512KB
  8      2MB      768KB     1MB
  16     4MB      1MB       2MB
  32     8MB      1.25MB    2MB
  64     16MB     2MB       4MB
  128    32MB     2.75MB    8MB
  256    64MB     4MB       16MB
  512    128MB    5.5MB     32MB
  1024   256MB    8MB       64MB
  2048   512MB    11.25MB   64MB

64K page size (BATCH=16):

  CPUs   linear   sqrt     ln-var3
  --------------------------------
  1      1MB      1MB      1MB
  2      2MB      2MB      2MB
  4      4MB      2MB      2MB
  8      8MB      3MB      4MB
  16     16MB     4MB      8MB
  32     32MB     5MB      8MB
  64     64MB     8MB      16MB
  128    128MB    11MB     32MB
  256    256MB    16MB     64MB
  512    512MB    22MB     128MB
  1024   1GB      32MB     256MB
  2048   2GB      45MB     256MB

-- 
Regards,
Li Wang


