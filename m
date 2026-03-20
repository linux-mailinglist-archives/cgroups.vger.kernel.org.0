Return-Path: <cgroups+bounces-14966-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAmaF4GtvWnIAQMAu9opvQ
	(envelope-from <cgroups+bounces-14966-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:26:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82B2E0CC6
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67607304B28B
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A930E85D;
	Fri, 20 Mar 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLo486en"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA302FF147
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038398; cv=none; b=Jl4YczzJjZ9URQgubmOm9Vmy4R+Y8A022ai1sWyne3kXGk1Bhlrz2AbdKdfetALBu7xaBgCfFI6/r391/oTYyIZBJFOpXCmxCOYeVb7W7NWAqp14aobZSJSzPkRoIHmsZZCMxUyhZ9Pt+LigVrMymnn/My49FcMdpDYXV+2zjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038398; c=relaxed/simple;
	bh=LcbGtTuSpB1/pNmFVKjQFRPwN3oBhlDbUUNemmVaQzA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lS58Zo82INXOT9WEmYH7jXczartR2k43syMD4QFIq/zl+jydAGo+tEfGUuu9eeP4sGk1zHKaInut6F2AVoRhR3481tXpU9U0txwEkJCf0157M3zblQEEahge1SZg3bWaQJdPcj4z3A1qMh6gKQMNqWg8waij6i8o6aPZ8KF0ZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLo486en; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774038396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bh7aOD8eVmeMWf72c7UmgdenGSk73cbCb4+ksWaH/Fg=;
	b=cLo486en7t6zn/2TPzvG+AAeO9S9pGnJOxpnByd9t582oIj8XnpQt3O2ySo7fB3ObggvgL
	2QtSQYinD4uzPzeYJfYQU4AwuBDD+AE/JWuTTFXHo8M5nQqsSsCXXX8vLlyqrWO5wv1Nm/
	+hdqD4Oy8xG0ZMdsZ3x4scTdiucFOsY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-kuO8f03HNYm3vhJUfRt_Qg-1; Fri,
 20 Mar 2026 16:26:32 -0400
X-MC-Unique: kuO8f03HNYm3vhJUfRt_Qg-1
X-Mimecast-MFC-AGG-ID: kuO8f03HNYm3vhJUfRt_Qg_1774038389
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 005071800561;
	Fri, 20 Mar 2026 20:26:29 +0000 (UTC)
Received: from [10.22.65.139] (unknown [10.22.65.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85C0618001FE;
	Fri, 20 Mar 2026 20:26:24 +0000 (UTC)
Message-ID: <056172d8-1e58-4437-9cd6-1239de292574@redhat.com>
Date: Fri, 20 Mar 2026 16:26:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] selftests: memcg: Fix test_memcontrol test failures
 with large page sizes
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 James Houghton <jthoughton@google.com>,
 Sebastian Chlad <sebastianchlad@gmail.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
 <20260319194347.1048fc8d737b6e8f9d82663d@linux-foundation.org>
 <cee91a5b-5b37-4e19-b0c9-eea985ab490b@redhat.com>
Content-Language: en-US
In-Reply-To: <cee91a5b-5b37-4e19-b0c9-eea985ab490b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14966-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BD82B2E0CC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 11:56 AM, Waiman Long wrote:
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -548,20 +548,20 @@ struct memcg_vmstats {
> >>   *    rstat update tree grow unbounded.
> >>   *
> >>   * 2) Flush the stats synchronously on reader side only when there 
> are more than
> >> - *    (MEMCG_CHARGE_BATCH * nr_cpus) update events. Though this 
> optimization
> >> - *    will let stats be out of sync by atmost (MEMCG_CHARGE_BATCH 
> * nr_cpus) but
> >> - *    only for 2 seconds due to (1).
> >> + *    (MEMCG_CHARGE_BATCH * (ilog2(nr_cpus) + 1)) update events. 
> Though this
> >> + *    optimization will let stats be out of sync by up to that 
> amount but only
> >> + *    for 2 seconds due to (1).
> > Is this description accurate regarding the maximum out of sync amount?
> > Looking at memcg_rstat_updated(), updates are buffered locally on 
> each CPU
> > up to MEMCG_CHARGE_BATCH - 1 before they are added to the global
> > vmstats->stats_updates counter.
> > Because memcg_vmstats_needs_flush() only checks the global counter, 
> could
> > N CPUs each buffer MEMCG_CHARGE_BATCH - 1 updates without triggering a
> > synchronous flush?
> > If so, wouldn't the actual worst-case out-of-sync error be
> > N * (MEMCG_CHARGE_BATCH - 1) + vmstats_flush_threshold, which remains
> > linear with the number of CPUs rather than scaling logarithmically?
>
> Good point, the worst case scenario can indeed be worse than that. I
> will update the comment accordingly.

Looking at the code again, the hidden charge in memcg_stock should only 
affect memory.current, not memory.stat. There is nothing to add to the 
worst case situation.

Cheers,
Longman


