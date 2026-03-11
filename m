Return-Path: <cgroups+bounces-14762-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFljBY15sWk2vgIAu9opvQ
	(envelope-from <cgroups+bounces-14762-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 15:17:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A926539F
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EE57301027D
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF7345731;
	Wed, 11 Mar 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZeaapUk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405D2EA731
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238664; cv=none; b=jZ1Xvn7iOCprwwgKrrwr58YCx/fUkrtph3Nw+DVeaWXBUzFpSdtokdhgMcAgIJxlvX/2K/xTTjr003QbKf1Q38zkxA0aThrwijF86LISZkTx3mhF8ZTsuDhHEk5LQfAW89TSaMDZq4QU3rl+pzrVxxZ/LFbZ8j0HYBUyG8+JdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238664; c=relaxed/simple;
	bh=F4ThM70N14D7WqCIFJvVReqZ4AoaM2J8nf2lReuds9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tXSYkGDEnKWNp5O7axYh2LnKvE5OrNdJdEbV7KiIT9+e+Isx4W2wyliM+uwg9qKk1JgEm+r6QMQoHiNCx+GT01dppy8/oCSKwl8d3RKR1cpp4T7Rso51llvefKi48uOK3ObhWtppwngTs2yelV9QK2KIkFd7zYN5Xo/m1bKJRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZeaapUk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773238662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aP5eMflMCUNlRkDOW0RWxKmlwhMbtbh/1Qm40wa/18=;
	b=NZeaapUkc8tBq5YyWaLxAZ7GKBU0D2nHd0kvOZGahrsMC1P9Bi5bZYs1b+0CjJ9+MnT8b9
	iTWxgwMlLVAsyh5e1MENIMBi/T7gJ5+TtJo9F8vVNTjMGpgmEWj0Yk5nJXQCI6mWv4Qd+t
	aYB1UDkxS2iQ0sOdRru/hM2Yq9WtrcE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-Ru_SNn1xPkGDi3zjdGy7Yg-1; Wed,
 11 Mar 2026 10:17:41 -0400
X-MC-Unique: Ru_SNn1xPkGDi3zjdGy7Yg-1
X-Mimecast-MFC-AGG-ID: Ru_SNn1xPkGDi3zjdGy7Yg_1773238660
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F53E195605F;
	Wed, 11 Mar 2026 14:17:40 +0000 (UTC)
Received: from [10.22.89.250] (unknown [10.22.89.250])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62BEC1956095;
	Wed, 11 Mar 2026 14:17:39 +0000 (UTC)
Message-ID: <4238fec3-1a37-4924-b13e-a42d2454412c@redhat.com>
Date: Wed, 11 Mar 2026 10:17:38 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ISSUE] cgroup: test_percpu_basic fails on PREEMPT_RT due to lazy
 percpu stat flushing
To: Lucas Liu <hongzliu@redhat.com>, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <CAEnjF8FxM2CGgGC0R42R7R4=udHMtkwV9bCVcw7NDq7KTZMLkg@mail.gmail.com>
Content-Language: en-US
Cc: Li Wang <liwan@redhat.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAEnjF8FxM2CGgGC0R42R7R4=udHMtkwV9bCVcw7NDq7KTZMLkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 8C7A926539F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14762-lists,cgroups=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/11/26 4:49 AM, Lucas Liu wrote:
> Hi recently I met this issue
>   ./test_kmem
> ok 1 test_kmem_basic
> ok 2 test_kmem_memcg_deletion
> ok 3 test_kmem_proc_kpagecgroup
> ok 4 test_kmem_kernel_stacks
> ok 5 test_kmem_dead_cgroups
> memory.current 24514560
> percpu 15280000
> not ok 6 test_percpu_basic
>
> In this test the memory.current 24514560, percpu 15280000, Diff ~9.2MB.
>
> #define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
>
> in this part (8cpus) MAX_VMSTAT_ERROR is 4M memory. On the RT kernel,
> the labs(current - percpu) is 9.2M, that is the root cause for this
> failure. I am not sure what value is suitable for this case(2M per cpu
> maybe?)

Li Wang had posted patches to address some of the problems in this test.

https://lore.kernel.org/lkml/20260306071843.149147-2-liwang@redhat.com/

It could be the case that lazy percpu stat flushing can also be a factor 
here. In this case, we may need to reread the stat counters again 
several time with some delay to solve this problem.

Cheers,
Longman


