Return-Path: <cgroups+bounces-14938-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELmSMI8vvWmI7QIAu9opvQ
	(envelope-from <cgroups+bounces-14938-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 12:29:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 484A62D9914
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 12:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0BE430EA356
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44539F16D;
	Fri, 20 Mar 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIclG2TU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5r4rnYm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3B317163
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005978; cv=none; b=gzOcuGWPRVeJ95Y7MSnsKj3fdLV5V7zVxuKn04ufwEQnQVE9TyL3yax5lJY+HMnFdQhGGWhv/lSFlVxPhRVmg5v9UjygbtL1WPBt66+e3HxEysycSjjcEhnZtkPB9C4a8ZEHp0v1zu0v3GF669wP+VAcS1bzoidruoHj+E6jx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005978; c=relaxed/simple;
	bh=sVlyVgj1KXRZy8BJPRwp5H/YcmC353Rz62nfZh184lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ2J9kCs1hIOSf52e5IA3xyNFnkPL3tobqDwWP1PbjkpAq5ZjVuFvRRD4r/wh9OQQwFR54DrL5Vkwf6hN/Fytec1qOzIcMpC1nSbt1Yap5aeoBw/W2ZMg6MKrvHEk1NJS3ftG3vULJYDyirmZk9bO9liTosAh0qkyXif8qNU0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIclG2TU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5r4rnYm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774005975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw/BFdoRDz/kwV1Lq1g5a7lIWwY3pXrRBNNHoMNS1Eg=;
	b=CIclG2TUoFT9owH+Cu04M4CG2JwbU/bXGnJZvLT17WUdq+8st5hgiuofve/VVqLVVWFMne
	qPOiJgBSSg1Tp7xe365AP5KWATfeASTLn+OKbjZyHwuBx+DcmTzmAa6LH5hcA8kkGbrCm+
	r+30wVW1HmZC9Ja+FeZOv+k9QMhmph0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-iwxqp2zXNTKr2zTMVHAJtQ-1; Fri, 20 Mar 2026 07:26:14 -0400
X-MC-Unique: iwxqp2zXNTKr2zTMVHAJtQ-1
X-Mimecast-MFC-AGG-ID: iwxqp2zXNTKr2zTMVHAJtQ_1774005974
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354bc535546so507870a91.3
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774005973; x=1774610773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw/BFdoRDz/kwV1Lq1g5a7lIWwY3pXrRBNNHoMNS1Eg=;
        b=G5r4rnYmbXWoZe1/t8PoeipN9dAkg6G/64ngerxrLCYuIPg6ccs6Y4IQGVHfbrmEOK
         1/biGDsPAeVf7z9jPKezFIAQkVNi0n+N53AlhVsAjHoa+e8XXyRyH5fhunPz800ogx5L
         hHK3hpSdWhAUvA2t3/ms8y+opUKVs/xSErXIBRiBBcy0O+b/bM5XrBTeMfTb/gtDoKuR
         9X63IiIIQ2+dddX9yl1PDIODYgCOtH4BIlAsF1+BHVcyaFsPhny+EG1d8/ACj3lOgIJr
         sRbBvdC+D2MjGaejpyd65EcdKt4ROQ0DommQiAKXVofILqksHgyDI16tkbBjCfXv1G07
         XmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005973; x=1774610773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw/BFdoRDz/kwV1Lq1g5a7lIWwY3pXrRBNNHoMNS1Eg=;
        b=jEfmtMNNmB42bnhHqUUx9AtBE2Dxrxrq2lgFSy/YbgFhBPgEOcwu4xzs2+7DKj2oO1
         CjjM+asJ0IZKl7xFdlBcFSwlCfGPtPqadRBke6Sj1o+bxJhKY0n0iskMTGpDQFREJ7qd
         0ZBUoXT+RR5OCHbFk5O5Z+zttn15jH3mF8xqPLfdAnX6uJjKA2/Fuw2N6ZyFqOc7zZgS
         tB8HotaN+2YSwYiV3L0D0kOqzJxo6vU7nR57QbROG3GVjYcXQs0KiQTiPsAISOcqo69F
         Lc4V/K60NP28tknoqvi02hvrW0uGXYXzmVyy9IKk4BCqePXTVe9MlwbrLmhAnhprXcp6
         mh0g==
X-Forwarded-Encrypted: i=1; AJvYcCWzEfTGX3BjJlSL6G3yml6Tktec1WXlDPS+MebAb/3zCy/jw58d614zIZXZ9jl7D8Y/0zHJqzSv@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjGxtvVL5dEOI/k86XnLsYr5ROxgyrm0tYGCd36hVnkzAn+ff
	KXEQBQQAZww93zJfq1OZ+3bNxHx4Wci0HPuxXTkJnuArF5kYoBUtPdTPw36WJm0pTxhO2HP/mL0
	PiYr17Kfd3OJCDV7WdmIdyWoOLQsEz5ugZMsASG11ztqYUsAR9r/w0C+hvs8=
X-Gm-Gg: ATEYQzwkwCiGqvxI1mwUy0ks3OI+m73Bdoa92U2wJUdTmLjCo27ahvdbmAVlsdsaCT+
	LRxRm7nP3eV5mPz5uTjf3EC3YkotFM+m1JnucJWfBRcOUPK91jCfttduCWyS0o2SlY45xiFXM5P
	Frma5kPEL8lQQrkOhE59Hv0nnpfwipydRtx6ODOfkUa+hTT9Qzq9WxL6ozeG4+pnEltRuVFCUNH
	7hTSwcjvbF5COa5WpoSdiUD+Bi8QFTAnnDO0ptD3gQXV//NSTVJq9WlVr2Ub59li9ZqEQOimyiv
	6YF+nj81A1f9s6h8UPMnfTI/yTE0pG/xpeKo1Zg7miumprFhQDely6sH/go+chzndc5JyPcK62S
	/ssCVP44Dqfw5FYCn9w==
X-Received: by 2002:a17:90b:4a50:b0:359:fc88:fa99 with SMTP id 98e67ed59e1d1-35bd2d39c11mr2044005a91.26.1774005973528;
        Fri, 20 Mar 2026 04:26:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4a50:b0:359:fc88:fa99 with SMTP id 98e67ed59e1d1-35bd2d39c11mr2043977a91.26.1774005973145;
        Fri, 20 Mar 2026 04:26:13 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bf2sm1655907a91.11.2026.03.20.04.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:26:12 -0700 (PDT)
Date: Fri, 20 Mar 2026 19:26:09 +0800
From: Li Wang <liwang@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH 2/7] memcg: Scale down MEMCG_CHARGE_BATCH with increase
 in PAGE_SIZE
Message-ID: <ab0u0XCi9xBefrhJ@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
 <20260319173752.1472864-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319173752.1472864-3-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14938-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 484A62D9914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Waiman Long wrote:

> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -328,8 +328,14 @@ struct mem_cgroup {
>   * size of first charge trial.
>   * TODO: maybe necessary to use big numbers in big irons or dynamic based of the
>   * workload.
> + *
> + * There are 3 common base page sizes - 4k, 16k & 64k. In order to limit the
> + * amount of memory that can be hidden in each percpu memcg_stock for a given
> + * memcg, we scale down MEMCG_CHARGE_BATCH by 2 for 16k and 4 for 64k.
>   */
> -#define MEMCG_CHARGE_BATCH 64U
> +#define MEMCG_CHARGE_BATCH_BASE  64U
> +#define MEMCG_CHARGE_BATCH_SHIFT ((PAGE_SHIFT <= 16) ? (PAGE_SHIFT - 12)/2 : 2)
> +#define MEMCG_CHARGE_BATCH	 (MEMCG_CHARGE_BATCH_BASE >> MEMCG_CHARGE_BATCH_SHIFT)

This is a good complement to the first patch. With this change,
I got a chart to compare the three methods (linear, log2, sqrt)
in the count threshold:

4k page size (BATCH=64):
  
  CPUs    linear    log2     sqrt
  --------------------------------
  1       256KB     256KB    256KB
  8       2MB       1MB      512KB
  128     32MB      2MB      2.75MB
  1024    256MB     2.75MB   8MB
	
64k page size (BATCH=16):

  CPUs    linear    log2     sqrt
  -------------------------------
  1       1MB       1MB      1MB
  8       8MB       4MB      2MB
  128     128MB     8MB      11MB
  1024    1GB       11MB     32MB


Both are huge improvements.

log2 flushes more aggressively on large systems, which gives more accurate
stats but at the cost of more frequent synchronous flushes.

sqrt is more conservative, still a massive reduction from linear but gives
more breathing room on large systems, which may be better for performance.

I would leave this choice to you, Waiman, and the data is for reference.

-- 
Regards,
Li Wang


