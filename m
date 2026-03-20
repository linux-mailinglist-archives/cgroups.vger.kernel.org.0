Return-Path: <cgroups+bounces-14942-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGULNNVJvWlr8gIAu9opvQ
	(envelope-from <cgroups+bounces-14942-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 14:21:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E112DAE01
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 14:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58782304AA2A
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AAE3B9DA9;
	Fri, 20 Mar 2026 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaI2q7yh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DAD3B95F0
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012865; cv=none; b=AqWKuxMjKLjRdQowppgkHoiB6HZaYKfdV22kJduUGGNmvdXvbjGZErsw1zoLpOO5TqA85NWHGvfC1ZeqpU9WI0/oQ7R2r7wFByXl2AVmsxsPiw/Bc6SPGwlnVeD4rdmPnQXiaZkc+FVxznebKBnqla+LsXXk1F2UfUrBMRgc+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012865; c=relaxed/simple;
	bh=Y4Mi3460PRGZBtpb5gh+oWigApmPXlH+qaFKs4oNb1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxVLMpWvfESSWb/jNl5dfiGDgs5wslnJMPWuJtQZrTSywkKtS/+8Yf0a7KOGqKIPdnh+aDwzWubmKYO0DIF5FWkk67ifziAdn674PnTpcrwvHTItvJiZP2pKkxLwa6p5DRL0Tbg2x+k7y+s43R0iQFGBeaEhhDR9EtvYukWcL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaI2q7yh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774012861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwD2H1blMerUvhMy/76G3McoXreULE4NsdLlLVu3Q6U=;
	b=iaI2q7yhJ77mV8u41391c6KMJQhUhqPmHhbAAvdENq7CJd/TfbW0sfp7zzsDEZM0fb++Nm
	nx7Q55ebGfFsNF4BhVPJSPLNY/Ku5rdkQhmH7EBukrzB/ZUkAuy6VSQAYfTnKvZ+zfAV10
	fmscsoY8OsdwrkHL/Q/Av3KlfzowbNg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-ly8YZw-uNNerG81pJWhkkw-1; Fri,
 20 Mar 2026 09:20:57 -0400
X-MC-Unique: ly8YZw-uNNerG81pJWhkkw-1
X-Mimecast-MFC-AGG-ID: ly8YZw-uNNerG81pJWhkkw_1774012855
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 740061956048;
	Fri, 20 Mar 2026 13:20:54 +0000 (UTC)
Received: from [10.22.65.139] (unknown [10.22.65.139])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C025430002DF;
	Fri, 20 Mar 2026 13:20:50 +0000 (UTC)
Message-ID: <46d79476-39ea-4f0a-9739-56970d0cc2a2@redhat.com>
Date: Fri, 20 Mar 2026 09:20:49 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] memcg: Scale down MEMCG_CHARGE_BATCH with increase in
 PAGE_SIZE
To: Li Wang <liwang@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 James Houghton <jthoughton@google.com>,
 Sebastian Chlad <sebastianchlad@gmail.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
 <20260319173752.1472864-3-longman@redhat.com> <ab0u0XCi9xBefrhJ@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ab0u0XCi9xBefrhJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14942-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51E112DAE01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 7:26 AM, Li Wang wrote:
> Waiman Long wrote:
>
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -328,8 +328,14 @@ struct mem_cgroup {
>>    * size of first charge trial.
>>    * TODO: maybe necessary to use big numbers in big irons or dynamic based of the
>>    * workload.
>> + *
>> + * There are 3 common base page sizes - 4k, 16k & 64k. In order to limit the
>> + * amount of memory that can be hidden in each percpu memcg_stock for a given
>> + * memcg, we scale down MEMCG_CHARGE_BATCH by 2 for 16k and 4 for 64k.
>>    */
>> -#define MEMCG_CHARGE_BATCH 64U
>> +#define MEMCG_CHARGE_BATCH_BASE  64U
>> +#define MEMCG_CHARGE_BATCH_SHIFT ((PAGE_SHIFT <= 16) ? (PAGE_SHIFT - 12)/2 : 2)
>> +#define MEMCG_CHARGE_BATCH	 (MEMCG_CHARGE_BATCH_BASE >> MEMCG_CHARGE_BATCH_SHIFT)
> This is a good complement to the first patch. With this change,
> I got a chart to compare the three methods (linear, log2, sqrt)
> in the count threshold:
>
> 4k page size (BATCH=64):
>    
>    CPUs    linear    log2     sqrt
>    --------------------------------
>    1       256KB     256KB    256KB
>    8       2MB       1MB      512KB
>    128     32MB      2MB      2.75MB
>    1024    256MB     2.75MB   8MB
> 	
> 64k page size (BATCH=16):
>
>    CPUs    linear    log2     sqrt
>    -------------------------------
>    1       1MB       1MB      1MB
>    8       8MB       4MB      2MB
>    128     128MB     8MB      11MB
>    1024    1GB       11MB     32MB
>
>
> Both are huge improvements.
>
> log2 flushes more aggressively on large systems, which gives more accurate
> stats but at the cost of more frequent synchronous flushes.
>
> sqrt is more conservative, still a massive reduction from linear but gives
> more breathing room on large systems, which may be better for performance.
>
> I would leave this choice to you, Waiman, and the data is for reference.
>
I think it is a good idea to use the int_sqrt() function and I will use 
it in the next version.

Cheers,
Longman


