Return-Path: <cgroups+bounces-14518-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CtxAXq0pWkBFQAAu9opvQ
	(envelope-from <cgroups+bounces-14518-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 17:02:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 560D41DC4CE
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 17:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CCDD304EF1F
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209241C313;
	Mon,  2 Mar 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1Q1ivTW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A1E42317B
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466823; cv=none; b=q2oRngHVHZ0Bf5kFgbQSYu6ndC6GW1eLhZ8TTeLFTM4Vt9BvKlHbDJWJSjZl0o6oVgS9lf4xQu7PRgfDdBX3Rds+xVCO8SgJllWnzLmqeUqpZiVTo0d5QHZchnDYeqOTLENcFvjiVK+63M5XyXiMPg/RTFdL0+KLan8jJuvURWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466823; c=relaxed/simple;
	bh=1isY1xOkXNccpgxrRpip3TtO7vz3yH18hgsIi5dZDqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY5eOh684gHj1URbH5q+IH1Namd8+iR3baLf5CfIN81g1mpMiSC4kMrAsK1ujhcxqY0f7Ume3cSw08PGZBApQ07bKOYlSxV2J5UovztS70tJh5BzVp/ZZJGipb47en4x2BTlfIFuFW0CkgvQPkccHus2uRh/QQ7AMNWTaY4Apto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1Q1ivTW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772466815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaBXJgsoo6WsLjg1YVuWoSTbF9JI3puRHeYj5Y9cYkA=;
	b=Y1Q1ivTW6ckLsEGQXrkEkwD+8I/hZlk2dOQp+g39oYj97tjJID9UBgROnYj4t5+f/W71UG
	NLEEa86VX7X0KIS6xMUgrNW3bfStjH/4uPP2scaaEtCx/viwBeewIDeHeaq71yqtFsUI99
	1Dv5W+MooROtjRptkLlDhLf6gnJgcPY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-vTipCNljPmCj4_eeQjf37g-1; Mon,
 02 Mar 2026 10:53:29 -0500
X-MC-Unique: vTipCNljPmCj4_eeQjf37g-1
X-Mimecast-MFC-AGG-ID: vTipCNljPmCj4_eeQjf37g_1772466807
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E76011800267;
	Mon,  2 Mar 2026 15:53:26 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F51019560AD;
	Mon,  2 Mar 2026 15:53:26 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 40058401E0C28; Thu, 26 Feb 2026 15:24:29 -0300 (-03)
Date: Thu, 26 Feb 2026 15:24:29 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Vlastimil Babka <vbabka@suse.com>
Cc: Michal Hocko <mhocko@suse.com>, Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aaCP3V64INRZiZUH@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZiRAa6uf4KhscJC@tpad>
 <aZiSHT5DwIZwc/cH@tpad>
 <1fd2efef-888b-4d3c-9c72-bdb2d594336f@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd2efef-888b-4d3c-9c72-bdb2d594336f@suse.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 560D41DC4CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[93];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14518-lists,cgroups=lfdr.de];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,linutronix.de,redhat.com,suse.de];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 07:09:47PM +0100, Vlastimil Babka wrote:
> On 2/20/26 17:55, Marcelo Tosatti wrote:
> > 
> > #include <linux/module.h>
> > #include <linux/kernel.h>
> > #include <linux/slab.h>
> > #include <linux/timex.h>
> > #include <linux/preempt.h>
> > #include <linux/irqflags.h>
> > #include <linux/vmalloc.h>
> > 
> > MODULE_LICENSE("GPL");
> > MODULE_AUTHOR("Gemini AI");
> > MODULE_DESCRIPTION("A simple kmalloc performance benchmark");
> > 
> > static int size = 64; // Default allocation size in bytes
> > module_param(size, int, 0644);
> > 
> > static int iterations = 1000000; // Default number of iterations
> > module_param(iterations, int, 0644);
> > 
> > static int __init kmalloc_bench_init(void) {
> >     void **ptrs;
> >     cycles_t start, end;
> >     uint64_t total_cycles;
> >     int i;
> >     pr_info("kmalloc_bench: Starting test (size=%d, iterations=%d)\n", size, iterations);
> > 
> >     // Allocate an array to store pointers to avoid immediate kfree-reuse optimization
> >     ptrs = vmalloc(sizeof(void *) * iterations);
> >     if (!ptrs) {
> >         pr_err("kmalloc_bench: Failed to allocate pointer array\n");
> >         return -ENOMEM;
> >     }
> > 
> >     preempt_disable();
> >     start = get_cycles();
> > 
> >     for (i = 0; i < iterations; i++) {
> >         ptrs[i] = kmalloc(size, GFP_ATOMIC);
> >     }
> > 
> >     end = get_cycles();
> > 
> >     total_cycles = end - start;
> >     preempt_enable();
> 
> While preempt_disable() simplifies things, it can misrepresent the cost of
> preempt_disable() that's part of the locking - that will become nested and
> then the nested preempt_disable() is typically cheaper, etc.
> 
> Also the way it kmallocs all iterations and then kfree all iterations may
> skew the probabilities of fastpaths, cache hotness etc.
> 
> When introducing sheaves I had a similar microbenchmark, but there was
> different amounts of inner-loop iteraions, no outer preempt_disable(), and
> linear vs randomized array. See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/commit/?h=slub-percpu-sheaves-v6-benchmarking&id=04028eeffba18a4f821a7194bc9d14f7488bd7d9
> 
> (at this point the SLUB_HAS_SHEAVES parts should be removed and the
> kmem_cache_print_stats() stuff also shouldn't be interesting for QPW
> evaluation).

Hi Vlastimil,

There is a problem which the numbers vary significantly across runs
(on the same kernel, system is idle, cpu is isolated).

SLUB_HAS_SHEAVES is not defined on my build. Just copied slub_kunit.c
from slub-percpu-sheaves-v6-benchmarking
to current tip (and dropped call to kmem_cache_print_stats).

1st run:
[  635.059928] average (excl. iter 0): 56571797
[  635.235206] average (excl. iter 0): 58329901
[  635.409957] average (excl. iter 0): 57459678
[  635.585128] average (excl. iter 0): 58268333
[  635.767325] average (excl. iter 0): 60063837
[  635.944534] average (excl. iter 0): 58912817
[  636.154503] average (excl. iter 0): 68992131
[  636.362533] average (excl. iter 0): 69030629
[  636.536737] average (excl. iter 0): 56545622
[  636.704314] average (excl. iter 0): 55536407
[  636.879097] average (excl. iter 0): 57397803
[  637.051157] average (excl. iter 0): 57021907
[  637.296352] average (excl. iter 0): 81582815
[  637.539810] average (excl. iter 0): 81126686

2nd run:
[  662.824688] average (excl. iter 0): 56833529
[  662.996742] average (excl. iter 0): 57145388
[  663.167063] average (excl. iter 0): 55828870
[  663.339814] average (excl. iter 0): 57505312
[  663.514563] average (excl. iter 0): 57374528
[  663.690328] average (excl. iter 0): 57282062
[  663.896128] average (excl. iter 0): 68097440
[  664.103029] average (excl. iter 0): 69263914
[  664.276497] average (excl. iter 0): 57073271
[  664.442210] average (excl. iter 0): 54895879
[  664.617186] average (excl. iter 0): 56972700
[  664.787353] average (excl. iter 0): 56457173
[  665.028944] average (excl. iter 0): 80339269
[  665.268597] average (excl. iter 0): 80371907

3rd run:
[  716.278750] average (excl. iter 0): 54191777
[  716.442014] average (excl. iter 0): 54151132
[  716.605254] average (excl. iter 0): 53148722
[  716.766461] average (excl. iter 0): 53204894
[  716.933339] average (excl. iter 0): 54719251
[  717.098761] average (excl. iter 0): 54922923
[  717.296178] average (excl. iter 0): 65351864
[  717.491440] average (excl. iter 0): 65264027
[  717.660778] average (excl. iter 0): 54370768
[  717.823625] average (excl. iter 0): 54137410
[  717.988983] average (excl. iter 0): 54222488
[  718.152716] average (excl. iter 0): 54339019
[  718.387978] average (excl. iter 0): 78249026
[  718.619598] average (excl. iter 0): 77746198

Increasing total parameter from 10^6 to 10^7 does
not help:

1st run:
[ 1074.601686] average (excl. iter 0): 650711901
[ 1076.450880] average (excl. iter 0): 633014260
[ 1078.363300] average (excl. iter 0): 660440649
[ 1080.266134] average (excl. iter 0): 652695083
[ 1082.117007] average (excl. iter 0): 635632144
[ 1084.009277] average (excl. iter 0): 654270513
[ 1086.286343] average (excl. iter 0): 790520038
[ 1088.512516] average (excl. iter 0): 768071705
[ 1090.448161] average (excl. iter 0): 664564330 
[ 1092.349683] average (excl. iter 0): 659016349 
[ 1094.274099] average (excl. iter 0): 662388982
[ 1096.172362] average (excl. iter 0): 647972747
[ 1098.753304] average (excl. iter 0): 887576313
[ 1101.339897] average (excl. iter 0): 885102019

2nd run:
[ 1120.186284] average (excl. iter 0): 615756734
[ 1122.019323] average (excl. iter 0): 623846524
[ 1123.885801] average (excl. iter 0): 639124895
[ 1125.693617] average (excl. iter 0): 623667563  
[ 1127.588515] average (excl. iter 0): 646441510  
[ 1129.410285] average (excl. iter 0): 628291996
[ 1131.542157] average (excl. iter 0): 728497604
[ 1133.698744] average (excl. iter 0): 743717953
[ 1135.514112] average (excl. iter 0): 616621660
[ 1137.306874] average (excl. iter 0): 615863807
[ 1139.110637] average (excl. iter 0): 616425899
[ 1140.948769] average (excl. iter 0): 638115570
[ 1143.426557] average (excl. iter 0): 847799304
[ 1145.914827] average (excl. iter 0): 861180802

Will switch back to the simple test (and its pretty obvious 
from the patch itself that if qpw=0 the overhead should 
be zero, and it is). Its numbers are more
stable across runs.


