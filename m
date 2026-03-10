Return-Path: <cgroups+bounces-14724-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL0BCRhgr2kDWwIAu9opvQ
	(envelope-from <cgroups+bounces-14724-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 01:04:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C8242CF9
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 01:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1610130A184F
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 00:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F3126BF1;
	Tue, 10 Mar 2026 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnAlZzfH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CD1397
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101055; cv=none; b=Uex1Akvtirp/tk3yQsVB1ySBgIGa9kWr5IP22CVvyBJ0hPF1rzJD/4F1K9y/yH/wuAjOl5iYLi8HuugWTJHJW5yV46WMU1MvJ16wiUZWQ5ry8FVSaS+mfwk6qyvz4qetbjowrQh024x6YO8q/UUGwsLj1cS+5qjqJz7pJFlRksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101055; c=relaxed/simple;
	bh=U/8rTD2o4m6Tjj3AJvdNv9BQmz1U4LX+8HgzxqcG0ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTqwdsJE9ZPL5TuXMyrFpEiyQpTxW/UaLYYodUdp/df7AiyaH8hLfgj/LHwkmI9tVGxTay39uP089mJ4IrDJCBX88rujfA36hOOiDQG0b2AoS4z5/toXmr8tsNT7eSHibLvGkzJq6lsMn9BkwFOVnejyANi5nmvVCQct5yInwnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnAlZzfH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773101052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUfLC0f2AWQrj2JXMtmVBU5gG8MnUPc2ruYf8Fml+U8=;
	b=AnAlZzfHZKRz8lmuRQjMfNffam6Vgiu7ynupKp1MRGJ/b+xInZPw/gh7/Xn8JBNTtk7g50
	c1k45kju4fOXrm/7wa3fCYsxa/zfsL3KU5ZeKdbUWV8L7O4ciJPbX68P1XNvdrp5x9fdvr
	BYeyQjT03pOeVpwcxP9Fu7sPGkBnqtg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-vCKMX45vN-W9t60to1Wwhw-1; Mon,
 09 Mar 2026 20:04:10 -0400
X-MC-Unique: vCKMX45vN-W9t60to1Wwhw-1
X-Mimecast-MFC-AGG-ID: vCKMX45vN-W9t60to1Wwhw_1773101049
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 704C11956060;
	Tue, 10 Mar 2026 00:04:08 +0000 (UTC)
Received: from [10.22.81.138] (unknown [10.22.81.138])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D67EE1800361;
	Tue, 10 Mar 2026 00:04:05 +0000 (UTC)
Message-ID: <38c7a9a2-a8f1-4ae2-9070-73d0ebb42f53@redhat.com>
Date: Mon, 9 Mar 2026 20:04:05 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: memcg: Skp memcg_sock test if address family
 not supported
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
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <4ddd3jascnb6nt7quhyjfmsgsmtfmjofwmnrgjktz57cfbfymj@6ejbdgbg4lz2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: BE0C8242CF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-14724-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Action: no action

On 3/9/26 2:07 PM, Michal Koutný wrote:
> On Mon, Mar 09, 2026 at 12:02:05PM -0400, Waiman Long <longman@redhat.com> wrote:
>> On systems where IPv6 isn't enabled or not configured to support
>> SOCK_STREAM, the test_memcg_sock test always fails.
> I think IPv6 is not substantial for the check...
I mentioned it because the current code is using AF_INET6 family.
>
>> The purpose of the test_memcg_sock test is to verify that
>> memory.stat.sock and memory.current values are close.
> ... so this should work with IPv4 too.
Probably, I will try that out.
>
>> If the socket() call fails, there is no way we can test that. I
>> believe it is better to just skip the test in this case instead of
>> reporting a test failure hinting that there may be something wrong
>> with the memcg code.
> Yes, the skip on (any) socket creation is also (independently) good.
>
>> @@ -1460,6 +1466,9 @@ static int test_memcg_sock(const char *root)
>>   	free(memcg);
>>   
>>   	return ret;
>> +skip:
>> +	ret = KSFT_SKIP;
>> +	goto cleanup;
> Maybe make this analogous with other cases where there is no specific skip-label but
>
> 	if (err == EAFNOSUPPORT) {
> 		ret = KSFT_SKIP;
> 		goto cleanup;
> 	}

Yes, that will work too. Will make the update in the next version.

Cheers,
Longman


