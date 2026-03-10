Return-Path: <cgroups+bounces-14736-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLwGOu80sGnRhAIAu9opvQ
	(envelope-from <cgroups+bounces-14736-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 16:12:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A477D25305A
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 16:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FE3831F09BA
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DF391E61;
	Tue, 10 Mar 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwviW6v8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD9391E62
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151761; cv=none; b=qlgW/AxoejlxHudowdI0PvKRd7fcwJwoEfQ2VyzGVFTWmnyfCl6YpCpl2Jm1Yt5RcCpFyN/0n7+bFhVfkQYtp34uvbF7n+n+Qv32bZBdgR5XmDoD9/1duACWwQyCvZ88Cmct/x0kEr254tFU96yhl+HsdMWz4aocl1D8NtrWVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151761; c=relaxed/simple;
	bh=W2xN/mCb9NR3m8rj+NKaCGBJXePsMRnw221cQuOXCnU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H+Y4MOjU+l5oj4nECF45De+oz0jYKHU+7E6hcEmAxM5rJR31zXGWTJGt+iXvKZAx+/NqLWFG0XA7cBxbaq9GJ9iiUiaw0Ag4nvLGv+OCOp59xFD4Ao2fj8+xdFt7kJ9OctO/GccEkqqZXLAfVPgcyhS/pXu9vP1uH/ZJywY6JVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwviW6v8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773151759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UGaoul3yuJqynOQk2erX7A5QGgPE1g4T37mrg0FVrlk=;
	b=OwviW6v8EEsUDWEGkyqKHmpQgaAPybp+wu5/+ISGimLqHhs2Kp4cVmqGu0HGlvvomr00hl
	ncDPzczFU7fCyiAerQPmUBuV6hSk5mh5P5BdgUEgKkGs/gUCjeGc/rRIYRuDOfIg24WoWl
	7pGvYqV5eGksT+w/0NIWxRG7fkZMhP0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-m5o7F6riMXeKGzQ5SQSztg-1; Tue,
 10 Mar 2026 10:09:13 -0400
X-MC-Unique: m5o7F6riMXeKGzQ5SQSztg-1
X-Mimecast-MFC-AGG-ID: m5o7F6riMXeKGzQ5SQSztg_1773151747
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D3F51956095;
	Tue, 10 Mar 2026 14:09:07 +0000 (UTC)
Received: from [10.22.89.94] (unknown [10.22.89.94])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD8D61800576;
	Tue, 10 Mar 2026 14:09:04 +0000 (UTC)
Message-ID: <ee563439-9ba2-4f0e-8309-fcabc527ec58@redhat.com>
Date: Tue, 10 Mar 2026 10:09:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: memcg: Skp memcg_sock test if address family
 not supported
From: Waiman Long <longman@redhat.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20260309160205.651754-1-longman@redhat.com>
 <4ddd3jascnb6nt7quhyjfmsgsmtfmjofwmnrgjktz57cfbfymj@6ejbdgbg4lz2>
 <38c7a9a2-a8f1-4ae2-9070-73d0ebb42f53@redhat.com>
Content-Language: en-US
In-Reply-To: <38c7a9a2-a8f1-4ae2-9070-73d0ebb42f53@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: A477D25305A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-14736-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/26 8:04 PM, Waiman Long wrote:
> On 3/9/26 2:07 PM, Michal Koutný wrote:
>> On Mon, Mar 09, 2026 at 12:02:05PM -0400, Waiman Long 
>> <longman@redhat.com> wrote:
>>> On systems where IPv6 isn't enabled or not configured to support
>>> SOCK_STREAM, the test_memcg_sock test always fails.
>> I think IPv6 is not substantial for the check...
> I mentioned it because the current code is using AF_INET6 family.
>>
>>> The purpose of the test_memcg_sock test is to verify that
>>> memory.stat.sock and memory.current values are close.
>> ... so this should work with IPv4 too.
> Probably, I will try that out. 

On my test system, creating a socket with IPv4 does work. However, with 
IPv4, the memcg_sock test becomes unstable and it fails half of the 
times as the memory values aren't close enough. It is possible that the 
assumption that memory values should be close aren't quite true with 
IPv4. As I am not familiar with the networking code at all, I will let 
others who have more experience with the networking side to try that out.

Cheers,
Longman


